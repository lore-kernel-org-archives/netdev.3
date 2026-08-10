Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9037DAAD;
	Mon, 10 Aug 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364975; cv=none; b=N2F+D+b3F/q6eg7yYatZ1CwN4PC+ns0bogBd59cgL3oO9z7lOmwJwHsgB7rP1YFP6okeiLicDE2hYgl6l49Z1EOGjAWQFmufFTR8t7WKBSS+ARUmgnLj0OXCCsBpuWM5yXhby7dOqtDFVlqLuS2jwV2uMnSVIRJ91WpC1kO1sEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364975; c=relaxed/simple;
	bh=8vsmwhWNjaNPKH86HTXo2PPNHimE6lkfREj7wYPV6V8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UyKCeGlaPAST8C5u60wt9TE0ZxdxlgBRGUMS2tlKJJ/tzbcDLwjtO7tz4wq5ynE30e4n1GaBU/zRxTYmCWB+oz0fXIbkEUfwzcf/OVdT0aEl/M9eSZFK7lGJNVs8OCh6fBLAIjYUlvurpLvm4ofRF8tonEcHgslkb51CNe+UgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=48NjAxVw; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="48NjAxVw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eEKdN4+rCiOEC1rkmWULm7wSG4IcgyfwzQPIBTSZNpU=;
	b=48NjAxVwi9VhtIsIjtYBdKRD78HkxlafuQcDO2uMWXdTmUxkpjGDkkpw2iwRycRxYx/1c+w88
	wFa90Rdt0fysKs/gP1C6oGEgtrMDTETTDC14MHm8Y8WVNTO++0G0MvPwIMLf6DGLjig66zYA3d9
	2SumihNZa3rNblLFIea7V1s=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hJYj31VfDz1T4Fq;
	Mon, 10 Aug 2026 20:19:35 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id E9F7C2025F;
	Mon, 10 Aug 2026 20:29:22 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 10 Aug
 2026 20:29:22 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH net-next] net: core: avoid WARN_ONCE for stale RX queue mappings
Date: Mon, 10 Aug 2026 20:50:29 +0800
Message-ID: <20260810125029.1567742-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500018.china.huawei.com (7.202.194.48)

An skb may retain its recorded RX queue index while a network device
reduces its number of active RX queues. For example, when a TUN queue
is detached, queued skbs can still carry the queue's previous index.

Both get_rps_cpu() and netif_get_rxqueue() validate the index before
accessing the RX queue array. They safely fall back to local processing
or the first RX queue, so an invalid index does not cause an
out-of-bounds access.

Using WARN_ONCE() for this recoverable condition can unnecessarily
panic systems with panic_on_warn enabled. Replace it with
netdev_warn_once() to retain the diagnostic without emitting a WARN
splat.

Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/core/dev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index af260ff5462a..5db98b0a853f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5126,10 +5126,11 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		u16 index = skb_get_rx_queue(skb);
 
 		if (unlikely(index >= dev->real_num_rx_queues)) {
-			WARN_ONCE(dev->real_num_rx_queues > 1,
-				  "%s received packet on queue %u, but number "
-				  "of RX queues is %u\n",
-				  dev->name, index, dev->real_num_rx_queues);
+			if (dev->real_num_rx_queues > 1)
+				netdev_warn_once(dev,
+						 "received packet on queue %u, but number "
+						 "of RX queues is %u\n",
+						 index, dev->real_num_rx_queues);
 			goto done;
 		}
 		rxqueue += index;
@@ -5443,11 +5444,11 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 		u16 index = skb_get_rx_queue(skb);
 
 		if (unlikely(index >= dev->real_num_rx_queues)) {
-			WARN_ONCE(dev->real_num_rx_queues > 1,
-				  "%s received packet on queue %u, but number "
-				  "of RX queues is %u\n",
-				  dev->name, index, dev->real_num_rx_queues);
-
+			if (dev->real_num_rx_queues > 1)
+				netdev_warn_once(dev,
+						 "received packet on queue %u, but number "
+						 "of RX queues is %u\n",
+						 index, dev->real_num_rx_queues);
 			return rxqueue; /* Return first rxqueue */
 		}
 		rxqueue += index;
-- 
2.34.1

