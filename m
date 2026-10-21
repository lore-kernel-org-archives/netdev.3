Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584897;
	b=3u5Piy6pZfi2gCEWqd9uiE6c4/U9qmQUUh5NXBRe8ZDtbdazlutBwaC5c+vAvejjJ49M
	 sgu/4Ex174OT2d0s3PsHabOurrnZxRlvwoiBqcSv0GRHCwTAnbLconGTAJ63V/uvIpdO5
	 zmV3lefnPWms7/Bbe9KZCWVMRqbccMmoc3z/P4EJYjjbJbrCgENRV/kwCjU2vSfU6Tzv2
	 bflW4UN1u+y0LsjwKODVPgnN/KkrTnd2H4Uy52RASVx9vU7MG7sXY8BzNNSi5/8uEyaCa
	 I05oVeVBVTvlSN/o8G2zp6WOEVelK/h6p0KJryyIKsCsAQnceFwMeplldCajKOhthiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584897;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=8YT94N9emQsnD3hdEr15RR3Dmd5yrq+eYfgW+ApyqUU=;
	b=I7pbJHzFbQidD1D2MxZO23lazA37qwacZOHk4EjOP/w+ZF520rtkqIssw4msmfC/bflB
	 9izDEyeibCIDcp+RdMxpdy+tD4bMq1zN73KUlgw/lhOsQfgd0VF9cAUJPOcdDuoM32FDH
	 BPNlds/Sg9kCWOrvAH6L6krrfCEq4Zr4UzFdgY91lBBhOder0KlxIdnZXlG+Uc1pxUj+K
	 s6rgCTC+epstEGZgBODYzSS9wKomhkg19c7X17OHnXusJz47kZTKZTfsiigzSphSRmjoO
	 V0Z3ZjbKLD4ELroakLU6352oWSOsnljNgxy2IG2UyDqdfElcBmt4114+acBA4J3WlOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xP1IyTij;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1860A262D;
	Wed, 21 Oct 2026 12:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84E1860A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xP1IyTij
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8YT94N9emQsnD3hdEr15RR3Dmd5yrq+eYfgW+ApyqUU=;
	b=xP1IyTijexSX5YRzT2LwSA7pidkN19rQVt1MWx+r3DYvpJZ7PQ08jow5hvSmCBvw2CYXrkeIt
	CyOLDVG/7Q31Duonj2o/jpDswVkO47pA+QOjZhGK+CDUlSJQU2ZW8Y1QpPD0Jv8/xZJTnWGCZF7
	guNi5ze6QiiFMwqLzgrmCpA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j8pBC5fDvzLlV4;
	Wed, 21 Oct 2026 20:14:43 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B14CF4055B;
	Wed, 21 Oct 2026 20:14:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 21 Oct 2026 20:14:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net 2/3] net: hns3: fix interface stuck after OOM with full hardware rx queue
Date: Wed, 21 Oct 2026 20:14:25 +0800
Message-ID: <20261021121426.3096838-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021121426.3096838-1-shaojijie@huawei.com>
References: <20261021121426.3096838-1-shaojijie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

NAPI polling on hns3 is driven by hardware RX interrupts. Under
memory pressure, RX skb and frag allocations fail, packets are no
longer reaped from the hardware rx ring. Once the ring fills, the
hardware stops generating RX interrupts and NAPI is never scheduled
again -- even after memory becomes available, leaving the interface
deadlocked.

Break the deadlock by adding a software recovery path that re-arms
NAPI via a 250ms delayed_work, independent of hardware interrupts.
A per-vector bitmap tracks which vectors have rings in OOM state;
the work function schedules NAPI for each affected vector. OOM
state is marked at every RX allocation failure site and cleared
when the delayed_work fires.

This supersedes the busy-poll recovery from commit 68752b24f51a
("net: hns3: schedule the polling again when allocation fails"),
which returned budget on allocation failure to keep NAPI polling
and caused CPU spinning under prolonged memory pressure. Now
hns3_clean_rx_ring() returns recv_pkts instead of budget on
allocation failure, letting NAPI exit and the delayed_work take
over. Add rx_oom_cnt ethtool counter, incremented once per OOM
event (on the 0 -> 1 bitmap transition) for diagnostics.

Fixes: 81ae0e0491f3 ("net: hns3: Add skb chain when num of RX buf exceeds MAX_SKB_FRAGS")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v2:
  - Clear per-vector OOM bitmap when device is DOWN to avoid
    spurious napi_schedule() on next up event.
  - Move rx_oom_cnt accounting to hns3_ring_set_oom_state() with
    test_and_set_bit() for per-event counting.
  - Expand changelog: reference commit 68752b24f51a, explain
    hns3_clean_rx_ring() return value change, document rx_oom_cnt
    per-event counting semantics.
v1: https://lore.kernel.org/all/20260915132434.1141742-3-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 53 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   | 18 +++++++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  1 +
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2f3aeade558c..09f688893aab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -78,6 +78,8 @@ module_param(page_pool_enabled, bool, 0400);
 #define HNS3_MIN_TX_LEN		33U
 #define HNS3_MIN_TUN_PKT_LEN	65U
 
+#define HNS3_OOM_POLL_INTERVAL_MS	250
+
 /* hns3_pci_tbl - PCI Device ID Table
  *
  * Last entry must be all 0s
@@ -3793,6 +3795,7 @@ static int hns3_handle_rx_copybreak(struct sk_buff *skb, int i,
 
 		hns3_rl_err(ring_to_netdev(ring),
 			    "failed to allocate rx frag\n");
+		hns3_ring_set_oom_state(ring);
 		return -ENOMEM;
 	}
 
@@ -4162,6 +4165,7 @@ static int hns3_add_frag(struct hns3_enet_ring *ring)
 			if (unlikely(!new_skb)) {
 				hns3_rl_err(ring_to_netdev(ring),
 					    "alloc rx fraglist skb fail\n");
+				hns3_ring_set_oom_state(ring);
 				return -ENXIO;
 			}
 
@@ -4451,6 +4455,35 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
 	return 0;
 }
 
+static void hns3_oom_task(struct work_struct *work)
+{
+	struct hns3_nic_priv *priv = container_of(work, struct hns3_nic_priv,
+						  oom_task.work);
+	struct net_device *netdev = priv->netdev;
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
+		bitmap_zero(priv->oom_vector_bm, priv->vector_num);
+		return;
+	}
+
+	netif_dbg(h, rx_err, netdev, "oom napi_schedule 0x%*pb\n",
+		  priv->vector_num, priv->oom_vector_bm);
+	for (i = 0; i < priv->vector_num; i++)
+		if (test_and_clear_bit(i, priv->oom_vector_bm))
+			napi_schedule(&priv->tqp_vector[i].napi);
+}
+
+static void hns3_oom_task_schedule(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	hns3_ring_set_oom_state(ring);
+	schedule_delayed_work(&priv->oom_task,
+			      msecs_to_jiffies(HNS3_OOM_POLL_INTERVAL_MS));
+}
+
 int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 		       void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *))
 {
@@ -4472,6 +4505,9 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 
 		/* Poll one pkt */
 		err = hns3_handle_rx_bd(ring);
+		if (unlikely(err == -ENOMEM))
+			failure = true;
+
 		/* Do not get FE for the packet or failed to alloc skb */
 		if (unlikely(!ring->skb || err == -ENXIO)) {
 			goto out;
@@ -4493,7 +4529,10 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 		failure = failure ||
 			  hns3_nic_alloc_rx_buffers(ring, unused_count);
 
-	return failure ? budget : recv_pkts;
+	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
+		hns3_oom_task_schedule(ring);
+
+	return recv_pkts;
 }
 
 static void hns3_update_rx_int_coalesce(struct hns3_enet_tqp_vector *tqp_vector)
@@ -4788,6 +4827,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 			       hns3_nic_common_poll);
 	}
 
+	INIT_DELAYED_WORK(&priv->oom_task, hns3_oom_task);
 	return 0;
 
 map_ring_fail:
@@ -4865,9 +4905,18 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 		hns3_vector_coalesce_init(tqp_vector, priv);
 	}
 
+	priv->oom_vector_bm = bitmap_zalloc(vector_num, GFP_KERNEL);
+	if (!priv->oom_vector_bm) {
+		ret = -ENOMEM;
+		goto err_free_tqp_vector;
+	}
+
 	devm_kfree(&pdev->dev, vector);
 	return 0;
 
+err_free_tqp_vector:
+	devm_kfree(&pdev->dev, priv->tqp_vector);
+	priv->tqp_vector = NULL;
 err_put_vector:
 	for (i = 0; i < vector_num; i++)
 		h->ae_algo->ops->put_vector(h, vector[i].vector);
@@ -4889,6 +4938,7 @@ static void hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 	struct hns3_enet_tqp_vector *tqp_vector;
 	int i;
 
+	cancel_delayed_work_sync(&priv->oom_task);
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 
@@ -4920,6 +4970,7 @@ static void hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
 	struct pci_dev *pdev = h->pdev;
 	int i, ret;
 
+	bitmap_free(priv->oom_vector_bm);
 	for (i = 0; i < priv->vector_num; i++) {
 		struct hns3_enet_tqp_vector *tqp_vector;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 933e3527ed82..f71162af2da7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -449,6 +449,7 @@ struct ring_stats {
 			u64 non_reuse_pg;
 			u64 frag_alloc_err;
 			u64 frag_alloc;
+			u64 rx_oom_cnt;
 		};
 		__le16 csum;
 	};
@@ -585,6 +586,8 @@ struct hns3_nic_priv {
 	struct hns3_enet_tqp_vector *tqp_vector;
 	u16 vector_num;
 	u8 max_non_tso_bd_num;
+	struct delayed_work oom_task;
+	unsigned long *oom_vector_bm;
 
 	u64 tx_timeout_count;
 
@@ -711,6 +714,21 @@ static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
 #define hns3_rl_usec_to_reg(int_rl) ((int_rl) >> 2)
 #define hns3_rl_round_down(int_rl) round_down(int_rl, 4)
 
+static inline void hns3_ring_set_oom_state(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	if (!test_and_set_bit(ring->tqp_vector->idx, priv->oom_vector_bm))
+		hns3_ring_stats_update(ring, rx_oom_cnt);
+}
+
+static inline bool hns3_ring_is_oom_state(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	return test_bit(ring->tqp_vector->idx, priv->oom_vector_bm);
+}
+
 void hns3_ethtool_set_ops(struct net_device *netdev);
 int hns3_set_channels(struct net_device *netdev,
 		      struct ethtool_channels *ch);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index e7318f236315..392653635bda 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -62,6 +62,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
 	HNS3_TQP_STAT("frag_alloc_err", frag_alloc_err),
 	HNS3_TQP_STAT("frag_alloc", frag_alloc),
+	HNS3_TQP_STAT("rx_oom_cnt", rx_oom_cnt),
 };
 
 #define HNS3_PRIV_FLAGS_LEN ARRAY_SIZE(hns3_priv_flags)
-- 
2.43.0

