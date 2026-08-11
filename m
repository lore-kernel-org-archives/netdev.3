Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067B43800B;
	Tue, 11 Aug 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448656; cv=none; b=PmgJv57hZe9IBUyOETrpc9xtRoXzpMvUDWy/6LuaJrpGZeFUjvO6EPGe7mHayRiQU7zpQBtgKAdh+mpxDMpsaRY5y5dR8JS/Lk8zgYBbP6/jWtDx+Or5JxNYc6oY4GbKXX1mO205RQliw73oXge53L47gHbw+6Zwjr9+4DQv2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448656; c=relaxed/simple;
	bh=aKcHfZtH0PqJRxo5ON3bY99gAedM8k6F67oOVHHOl0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gvr9+MFZqAo4PGWtYxvNAi6h1i4OqbxzryMS2tSWfCjIeD2wfNJbmx+wEte1DiAwzmI0v/YYfvW6Pqo/8eFvfLu0WlkucGW60UpXjbORpOyZ3VvpCNDJHqnKOzHiYdF+KSy1MiZlDhcrA3FKW97rT+av7SZHlyrl2BYZIRxwkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TQGk9eQd; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TQGk9eQd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=413gHxUCocv8Yk4mjtkav76BxsrjOjkJp7/QRl5D8oI=;
	b=TQGk9eQdx63xM+AAskLcpqwrL7hLYMJn4O2F4E85CJ47MpvPUQnxif8xVSIMIYR5WuZTz8+3t
	LQxQzUn5ZiyS7ibX/ASXt6kLjfSqj3EKy3KziSDvdKgiozeLsyzyNViMqEnX4JBPG1C65Flc0tz
	6JDeumwpaiNe3m4AILxYPMQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hK8dQ6lhyzLlTg;
	Tue, 11 Aug 2026 19:33:30 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 469914056C;
	Tue, 11 Aug 2026 19:44:07 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Aug 2026 19:44:05 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Teng Peisen <tengpeisen@huawei.com>, Wu Di
	<wudi234@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, Zhang Min
	<zhangmin548@huawei.com>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>
Subject: [PATCH net v04] hinic3: Fix skb linearization mismatch and drop skb when skb_checksum_help() failed
Date: Tue, 11 Aug 2026 19:43:59 +0800
Message-ID: <78d8c61cab588240948eaddcb437d59add9f77ae.1786448013.git.tengpeisen@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Previously, hinic3_send_one_skb() cached the skb fragment count before
calling hinic3_tx_offload(). If hinic3_tx_csum() falls back to
skb_checksum_help() for unsupported tunnel packets, the skb may be
linearized. Continuing to build the TX descriptor with the stale
fragment count leads to a descriptor mismatch, which can trigger
out-of-bounds DMA reads or IOMMU faults.

Furthermore, the old code ignored the return value of skb_checksum_help(),
transmitting corrupted packets with incomplete checksums upon failure.

Fix this by:
1. Moving the hinic3_tx_offload() call before calculating 'num_sge' to
   ensure the correct fragment count is used if the SKB is linearized.
2. Propagating skb_checksum_help() errors and returning
   HINIC3_TX_OFFLOAD_INVALID to properly drop the skb.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020ca..cc541e7a2318 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
 			/* Unsupported tunnel packet, disable csum offload */
-			skb_checksum_help(skb);
-			return 0;
+			return skb_checksum_help(skb);
 		}
 	}

@@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
 		offload |= HINIC3_TX_OFFLOAD_TSO;
 	} else {
 		tso_cs_en = hinic3_tx_csum(txq, task, skb);
+		if (tso_cs_en < 0) {
+			offload = HINIC3_TX_OFFLOAD_INVALID;
+			return offload;
+		}
 		if (tso_cs_en)
 			offload |= HINIC3_TX_OFFLOAD_CSUM;
 	}
@@ -545,6 +548,7 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		skb->len = MIN_SKB_LEN;
 	}

+	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	num_sge = skb_shinfo(skb)->nr_frags + 1;
 	/* assume normal wqe format + 1 wqebb for task info */
 	wqebb_cnt = num_sge + 1;
@@ -560,7 +564,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}

-	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	if (unlikely(offload == HINIC3_TX_OFFLOAD_INVALID)) {
 		goto err_drop_pkt;
 	} else if (!offload) {

base-commit: 2195424c3da2ef1829a63b807e3a900a90e57d85
--
2.54.0

