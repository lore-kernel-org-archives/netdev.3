Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431DF364942;
	Fri,  7 Aug 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096510; cv=none; b=U29XhNwfGVLIpIhHDyla8qIaj8Gi4B9SKpaZzzdJQ8eRV2oDDUhVSa/eIzBASqShuYqM7B8zROd9nHHUmPhCCFFVRRmu3vURtAlowhCUNzF2mnL1p66Fisl4ts4YS1n9lWpdJrmjIKIs3wMBQLr46ofZg1D6osntpIpFjvngPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096510; c=relaxed/simple;
	bh=sXJT/i4T8Y/i1dpiQ0hI6DwNGhbr3te0HCa4Am2V1z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub3c21Lgfe9owkMMM9bQs5tHJZT6KkgXcqcs/odliBOvScBjdmz2f41xkhxPp0/kpP87DK0JoTho/uEPRWCyCva+PiCmodN6Uox6uUEpUxPj/S6D2CDXldh9NpoAZ3fMaQW+2I+PxQarEyQY3zslTcAQe96K8bHvGxCefBZjmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aPxfxZKF; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aPxfxZKF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Wj/YKLTbFip53atrpIExASDYQUL2EmPFh7HcTco3lPA=;
	b=aPxfxZKFTUlNRpiavJGsWX5oVgK/YBK5mGxTJ50sW/an5qhocSG6owLrNWZgSX1inrpGCv8Ux
	kjaTIOQ0zCKAr1tLpvJE+Fw0jVsHdc5iAauMN7IDWfYfaqlzvhFmMyFbsFgRWajWNDrCLIwug+C
	pryynISbfpSoymgvPtfSOQU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hGfPT19hYz1K96b;
	Fri,  7 Aug 2026 17:44:29 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 170CB40586;
	Fri,  7 Aug 2026 17:55:03 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 17:55:02 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 3/3] net: hns3: use txqueue parameter directly in ndo_tx_timeout
Date: Fri, 7 Aug 2026 17:54:35 +0800
Message-ID: <20260807095435.2959246-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260807095435.2959246-1-shaojijie@huawei.com>
References: <20260807095435.2959246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

From: Jian Shen <shenjian15@huawei.com>

The ndo_tx_timeout callback already provides the timed out txqueue
index. Use it directly instead of iterating all tx queues to find
the timed out one.

Use h->kinfo.num_tqps for the bounds check instead of
ndev->num_tx_queues, as the ring array is allocated with num_tqps
entries and num_tx_queues may be larger.  This issue has not been
encountered in practice, so it is folded into this cleanup rather
than tracked as a separate bugfix.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v2:
- Use h->kinfo.num_tqps for bounds check instead of
  ndev->num_tx_queues
- Restore the netif_xmit_timeout_ms() check by making
  hns3_dump_timeout_queue() return bool and gating on
  its return value, so a cleared stall does not trigger
  a reset
- Fold the bounds fix into this patch rather than tracking
  it as a separate bugfix, as the OOB has not been
  encountered in practice

v1: https://lore.kernel.org/all/20260804130933.880552-1-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 48 +++++++++----------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6ecb32e28e79..47788be64be6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2825,32 +2825,28 @@ static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 	return ret;
 }
 
-static int hns3_get_timeout_queue(struct net_device *ndev)
+static bool hns3_dump_timeout_queue(struct net_device *ndev,
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
+		return true;
 	}
 
-	return i;
+	return false;
 }
 
 static void hns3_dump_queue_stats(struct net_device *ndev,
@@ -2900,15 +2896,15 @@ static void hns3_dump_queue_reg(struct net_device *ndev,
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
+	if (txqueue >= h->kinfo.num_tqps ||
+	    !hns3_dump_timeout_queue(ndev, txqueue)) {
 		netdev_info(ndev,
 			    "no netdev TX timeout queue found, timeout count: %llu\n",
 			    priv->tx_timeout_count);
@@ -2917,8 +2913,8 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 
 	priv->tx_timeout_count++;
 
-	tx_ring = &priv->ring[timeout_queue];
-	hns3_dump_queue_stats(ndev, tx_ring, timeout_queue);
+	tx_ring = &priv->ring[txqueue];
+	hns3_dump_queue_stats(ndev, tx_ring, txqueue);
 
 	/* When mac received many pause frames continuous, it's unable to send
 	 * packets, which may cause tx timeout
@@ -2941,7 +2937,7 @@ static void hns3_nic_net_timeout(struct net_device *ndev, unsigned int txqueue)
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
 
-	if (!hns3_get_tx_timeo_queue_info(ndev))
+	if (!hns3_get_tx_timeo_queue_info(ndev, txqueue))
 		return;
 
 	/* request the reset, and let the hclge to determine
-- 
2.33.0

