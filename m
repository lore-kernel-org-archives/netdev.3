Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33073BE620;
	Tue, 15 Sep 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478816; cv=none; b=LURY9ocRP64lB3CpEFpW7JOHb6kO4uJqg9vtmcgPdXAXbgNVXj+yiMI5wkViieHwfUaefbvCmreOfh6tfN5vrLifdwya+RgtHZTwt+MNLDdKsq11swv2Zlidy43lDiq57nOgFIe7YIKzI64A3wUg8PjlnJeCr3FCD40upZdIrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478816; c=relaxed/simple;
	bh=G4ARr1WYf1+Ki+0ccpiCwcmwDH0Q/ADyXWpIW3sMsGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLAa1GPo+gLf61eHr5zJuHrbh6DCCMLhgdLlhw44TPM9zNokqHBA82K9OsO+2jeYJlha5F9TKCkt3zDVLtx7npTmnW4tm4wsmdlwGbp+o3dSyTdLFNipPM7KtEh/EDzkp2fv9pA7CuG7MrYlYTAxQPxO3OUR2/CQLfNPGHh0YN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zssx77MN; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zssx77MN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IVwbRmiGXKvtwCcZODjzAIndq5MMm/JFgxFrtHKZWGI=;
	b=zssx77MNBzPS7BvWchSjcSJ+l+Y2jnQpDSLTy14Mb/8k7uYvEcPw3iND9ek65Z+EwUM85puci
	TCfM3CbFIxni0CCBht4VhKj56+QGekPP2Eh527fC63/IVA81dGJTe3R4Eunhc6XBW8duKkgky7a
	+Rhnu6JIF4gYm33u+8DEiEc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hkjF14FsVz12LF9;
	Tue, 15 Sep 2026 21:15:33 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4764540538;
	Tue, 15 Sep 2026 21:26:42 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 15 Sep 2026 21:26:41 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 2/3] net: hns3: fix interface stuck after OOM with full hardware rx queue
Date: Tue, 15 Sep 2026 21:24:33 +0800
Message-ID: <20260915132434.1141742-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915132434.1141742-1-shaojijie@huawei.com>
References: <20260915132434.1141742-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500018.china.huawei.com (7.202.195.199)

NAPI polling on hns3 is driven by hardware RX interrupts. Under
memory pressure, RX skb and frag allocations fail, so packets are
no longer reaped from the hardware rx ring. Once the ring fills,
the hardware stops generating RX interrupts and NAPI is never
scheduled again -- even after memory becomes available. The
interface falls into a deadlock: draining the ring needs NAPI,
scheduling NAPI needs an interrupt, and the interrupt needs the
ring to be drained.

Break the deadlock by adding a software recovery path that re-arms
NAPI via a 250ms delayed_work, independent of hardware interrupts.
A per-vector bitmap tracks which vectors have rings in OOM state,
and the work function schedules NAPI for each affected vector.
OOM state is marked at every RX allocation failure site.

Also fix hns3_clean_rx_ring() to return recv_pkts instead of budget
on allocation failure, preventing NAPI busy-poll under low memory.
Add rx_oom_cnt ethtool counter for diagnostics.

Fixes: 81ae0e0491f3 ("net: hns3: Add skb chain when num of RX buf exceeds MAX_SKB_FRAGS")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 52 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   | 17 ++++++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  1 +
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2f3aeade558c..0c088feae03c 100644
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
 
@@ -4451,6 +4455,34 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring)
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
+	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
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
+	hns3_ring_stats_update(ring, rx_oom_cnt);
+	hns3_ring_set_oom_state(ring);
+	schedule_delayed_work(&priv->oom_task,
+			      msecs_to_jiffies(HNS3_OOM_POLL_INTERVAL_MS));
+}
+
 int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 		       void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *))
 {
@@ -4472,6 +4504,9 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 
 		/* Poll one pkt */
 		err = hns3_handle_rx_bd(ring);
+		if (unlikely(err == -ENOMEM))
+			failure = true;
+
 		/* Do not get FE for the packet or failed to alloc skb */
 		if (unlikely(!ring->skb || err == -ENXIO)) {
 			goto out;
@@ -4493,7 +4528,10 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 		failure = failure ||
 			  hns3_nic_alloc_rx_buffers(ring, unused_count);
 
-	return failure ? budget : recv_pkts;
+	if (unlikely(failure || hns3_ring_is_oom_state(ring)))
+		hns3_oom_task_schedule(ring);
+
+	return recv_pkts;
 }
 
 static void hns3_update_rx_int_coalesce(struct hns3_enet_tqp_vector *tqp_vector)
@@ -4788,6 +4826,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 			       hns3_nic_common_poll);
 	}
 
+	INIT_DELAYED_WORK(&priv->oom_task, hns3_oom_task);
 	return 0;
 
 map_ring_fail:
@@ -4865,9 +4904,18 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
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
@@ -4889,6 +4937,7 @@ static void hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 	struct hns3_enet_tqp_vector *tqp_vector;
 	int i;
 
+	cancel_delayed_work_sync(&priv->oom_task);
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
 
@@ -4920,6 +4969,7 @@ static void hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
 	struct pci_dev *pdev = h->pdev;
 	int i, ret;
 
+	bitmap_free(priv->oom_vector_bm);
 	for (i = 0; i < priv->vector_num; i++) {
 		struct hns3_enet_tqp_vector *tqp_vector;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 933e3527ed82..27a09629cbca 100644
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
 
@@ -711,6 +714,20 @@ static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
 #define hns3_rl_usec_to_reg(int_rl) ((int_rl) >> 2)
 #define hns3_rl_round_down(int_rl) round_down(int_rl, 4)
 
+static inline void hns3_ring_set_oom_state(struct hns3_enet_ring *ring)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ring_to_netdev(ring));
+
+	set_bit(ring->tqp_vector->idx, priv->oom_vector_bm);
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

