Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8951345EA7;
	Tue,  4 Aug 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848992; cv=none; b=tyOMMEs1BuqooZZfFm5sKE+yEOkrJYsBO3wQBORil0wWrq4GhQeOZBRfNKehOG/z6LNjfobolsto1O512zTWXqOAPZ1U3fab1zIoKHTBwcRS9PNPx80+dC9pUE1zTAY4aavoBNKGl4WOSCMtOlmZb1Ab2t7V9qtSZbw0CjZt0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848992; c=relaxed/simple;
	bh=Xyi5ZiaOqlkOmCtqUZu2OT8ZVpIYGI/99QDXRlpa+6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXj5cYrMpilYZEXjf/XMcyLL3co+uf+gVif/2Wu2S6SYECLRmgHbbF5zOiOHlxiXmDOn6m2iP68sCSWHXkS2bOpBnJnxjzK1h1nKXsHBJMJFAyG8A4Xw1vvfpb67Rx7ReOezHxczlv4kp7lwTzrs/bAWd+13D5zbbbN2Ofs4zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z5jdKhRU; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z5jdKhRU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9UDznz8MNBnpQ4rofIlTzG6x8jUqk6tN4Vf4Jm77vmE=;
	b=Z5jdKhRUJJTynOVDpZ8vNRLVT/wSIpL4vTTaZSelw+r0STw/MWsR/IpAGFeFf+QKxl84eJXor
	XSbl7bacdZBaUPcw7gNqj36I9d8xKydVrzCQyc7/LA0kq9xixm7UXmBEjsahWCTAFFYHy55QAdw
	ib/tMy7gztt8V2u0NQMjn3c=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hDtsY64wkznTVn;
	Tue,  4 Aug 2026 20:59:13 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CEC3140578;
	Tue,  4 Aug 2026 21:09:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 21:09:40 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 3/3] net: hns3: use txqueue parameter directly in ndo_tx_timeout
Date: Tue, 4 Aug 2026 21:09:33 +0800
Message-ID: <20260804130933.880552-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804130933.880552-1-shaojijie@huawei.com>
References: <20260804130933.880552-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)

From: Jian Shen <shenjian15@huawei.com>

The ndo_tx_timeout callback already provides the timed out txqueue
index. Use it directly instead of iterating all tx queues to find
the timed out one.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 47 ++++++++-----------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6ecb32e28e79..d0656289d68e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2825,32 +2825,25 @@ static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 	return ret;
 }
 
-static int hns3_get_timeout_queue(struct net_device *ndev)
+static void hns3_dump_timeout_queue(struct net_device *ndev,
+				    unsigned int txqueue)
 {
-	unsigned int i;
-
-	/* Find the stopped queue the same way the stack does */
-	for (i = 0; i < ndev->num_tx_queues; i++) {
-		unsigned int timedout_ms;
-		struct netdev_queue *q;
+	unsigned int timedout_ms;
+	struct netdev_queue *q;
 
-		q = netdev_get_tx_queue(ndev, i);
-		timedout_ms = netif_xmit_timeout_ms(q);
-		if (timedout_ms) {
+	q = netdev_get_tx_queue(ndev, txqueue);
+	timedout_ms = netif_xmit_timeout_ms(q);
+	if (timedout_ms) {
 #ifdef CONFIG_BQL
-			struct dql *dql = &q->dql;
+		struct dql *dql = &q->dql;
 
-			netdev_info(ndev, "DQL info last_cnt: %u, queued: %u, adj_limit: %u, completed: %u\n",
-				    dql->last_obj_cnt, dql->num_queued,
-				    dql->adj_limit, dql->num_completed);
+		netdev_info(ndev, "DQL info last_cnt: %u, queued: %u, adj_limit: %u, completed: %u\n",
+			    dql->last_obj_cnt, dql->num_queued,
+			    dql->adj_limit, dql->num_completed);
 #endif
-			netdev_info(ndev, "queue state: 0x%lx, delta msecs: %u\n",
-				    q->state, timedout_ms);
-			break;
-		}
+		netdev_info(ndev, "queue state: 0x%lx, delta msecs: %u\n",
+			    q->state, timedout_ms);
 	}
-
-	return i;
 }
 
 static void hns3_dump_queue_stats(struct net_device *ndev,
@@ -2900,25 +2893,25 @@ static void hns3_dump_queue_reg(struct net_device *ndev,
 				      HNS3_RING_TX_RING_EBD_OFFSET_REG));
 }
 
-static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
+static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev,
+					 unsigned int txqueue)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 	struct hns3_enet_ring *tx_ring;
-	u32 timeout_queue;
 
-	timeout_queue = hns3_get_timeout_queue(ndev);
-	if (timeout_queue >= ndev->num_tx_queues) {
+	if (txqueue >= ndev->num_tx_queues) {
 		netdev_info(ndev,
 			    "no netdev TX timeout queue found, timeout count: %llu\n",
 			    priv->tx_timeout_count);
 		return false;
 	}
+	hns3_dump_timeout_queue(ndev, txqueue);
 
 	priv->tx_timeout_count++;
 
-	tx_ring = &priv->ring[timeout_queue];
-	hns3_dump_queue_stats(ndev, tx_ring, timeout_queue);
+	tx_ring = &priv->ring[txqueue];
+	hns3_dump_queue_stats(ndev, tx_ring, txqueue);
 
 	/* When mac received many pause frames continuous, it's unable to send
 	 * packets, which may cause tx timeout
@@ -2941,7 +2934,7 @@ static void hns3_nic_net_timeout(struct net_device *ndev, unsigned int txqueue)
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
 
-	if (!hns3_get_tx_timeo_queue_info(ndev))
+	if (!hns3_get_tx_timeo_queue_info(ndev, txqueue))
 		return;
 
 	/* request the reset, and let the hclge to determine
-- 
2.43.0

