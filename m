Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945689;
	b=128p8qyFXhl8XFmzUBeUrZHbRIfuSrmlZtBALkxLf1PNm02PK+5dkRW0b6+mAu/YOZ+2
	 7cXYX5uAAKZJMyCAvZJ7u9rLvfKwFjl//GIwEreWC7kT16dlJxL7A5/42gDhxyKXNyqCt
	 7t03Oq3biX6+8nO9w+fynoxFT/QQx+lW31TvQ2V7EEZHEzujLDF+Mn8mkWYUelwOju37s
	 B5X2PZcHYloAY3MaGLPKZ+tp2xToqc6CI0SL/WmPUvmuBeQ359n4S2hM+SCTZRvucoTV8
	 GQ8105B13JBbIDL+hVKeb11rRpUPDfkjNWvYvd/XaITMMmci1K9xsPjObmGOTCZc5jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945689;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=8H4BiAzL9XZzDteByBJrPGAy9cQmcdMJFtoFmH4ZVmQ=;
	b=TpIyt0KsuntCaAprhYJnXHFj0XdEcwkiCs/ZDSN8ZKp0gQt7O9W9784dlDwVLIPBJY+u
	 ecIz6yUysILreQB8qtG4ZltZFfqbq7VXWwxy6Xr1XAnhxAn1dsu4DyCm8PYj6BtXjPZBj
	 +PpATfC2pIIU0lL0isIJYcnZMq7ekTyEy/34pq9BP7TSPGdCuB7jSXBjBkm2P/q2sujKk
	 XmqWlvzJ3/wCiLyIclKvm/+2IsO+ySVpptsHjHJO1DeR/pe1ry1rUBHdtTvAnEreqI7jd
	 42D6UzRC+20i3Jk7aM70KRO8JKuDYlEWgVkReOFomaV3AGzqoaDzPM8cWh0SOGuqatQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5gK0O8x2;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB8606A331;
	Fri,  6 Nov 2026 06:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FB8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5gK0O8x2
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8H4BiAzL9XZzDteByBJrPGAy9cQmcdMJFtoFmH4ZVmQ=;
	b=5gK0O8x26QeXWexMiNyCAkgm2z90c9zzMHBOuRyZIoz9pAhKlatVpS5t30kzCstUPmBqlCrJM
	frs0s5S2yDjI0AS8406TFnziv+jHqpsZ5OgL9OSNgV7B1yb8SH6NpwN7RhFgeMDUURha9xI2gmp
	749zlE6tCFN1S2+B8+dvsj8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jLTRJ2dzMzKm8R;
	Fri,  6 Nov 2026 14:14:36 +0800 (CST)
Received: from dggpemr200009.china.huawei.com (unknown [7.185.36.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B6B54056C;
	Fri,  6 Nov 2026 14:14:43 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200009.china.huawei.com (7.185.36.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:42 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 14:14:40 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v01 1/4] Fixes: Solve an LRO stall issue
Date: Fri, 6 Nov 2026 14:14:28 +0800
Message-ID: <6b3a98338e27fbfa923069686b7cd472f30f5033.1793946318.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1793946318.git.gongfan1@huawei.com>
References: <cover.1793946318.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100015.china.huawei.com (7.152.185.230)

As noted in the subsequent review.

This changes the return value when the loop exits on the LRO
replenish threshold. It used to return nr_pkts and now returns budget.
In hinic3_poll():
	work_done = hinic3_rx_poll(irq_cfg->rxq, budget);
	busy |= work_done >= budget;
	if (busy)
		return budget;
As a result, the threshold exit now skips napi_complete_done(),
hinic3_net_dim() and the MSI-X re-enable. NAPI keeps polling instead
of waiting for the next interrupt.
This seems unrelated to statistics, and the commit message does not
mention it. Was it intended? If it fixes an LRO stall, could it go in
a separate patch with its own explanation and a Fixes: tag?

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 309ab5901379..9c4ab88998d4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -555,6 +555,7 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
 	u32 sw_ci, status, pkt_len, vlan_len;
 	struct hinic3_rq_cqe *rx_cqe;
+	bool poll_again = false;
 	u32 num_wqe = 0;
 	int nr_pkts = 0;
 	u16 num_lro;
@@ -581,12 +582,14 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 
 		rx_cqe->status = 0;
 
-		if (num_wqe >= nic_dev->lro_replenish_thld)
+		if (num_wqe >= nic_dev->lro_replenish_thld) {
+			poll_again = true;
 			break;
+		}
 	}
 
 	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
 		hinic3_rx_fill_buffers(rxq);
 
-	return nr_pkts;
+	return poll_again ? budget : nr_pkts;
 }
-- 
2.43.0

