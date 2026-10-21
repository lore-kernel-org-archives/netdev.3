Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584906;
	b=4NVjdPGWKGIWtnXEj2SRggY9swswbKqFlm2g0Paaq0n3ofu/PUyjI0VR0+FWn98d2lX5
	 hGXZN9OhdzvsDoXFKv869ekCuMzNkaN/pympepszbYj4hNX1AwkTj4UkkYyFlsRnFUNTy
	 BAF/DAQJ0S2hm8C+PjTBHDwgADyWvzPOh5NCSbfQhJB3/+0uZZTD8Za60GJsB4lhRPhzp
	 ZzNEm3tUePtXf+DnfxPJrh5OfIP70Ywq8E47z0rWKGwW0jtphrXPVez4ToOXv2SBLZf6A
	 4kxmVdj+caniUz6404EChK9hkiZhlPlgCS4IKU5NAvgIADHB63v6Vh6RidVQaXK844Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584906;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=sF9LDzpQEaJzHtp3EejibVBr7yA0oWFz7PGqdD3p6ho=;
	b=J7C/dDmhWmPK2qmCufRNy5J6YcEv8xbL0XVaDUDIUIlWeJd1+qz7/mNiOqhwnwMCCrh0
	 qcsEAhNbkk4sN/JNHmsTXY2k6Tm/ogQYK2UAsSJwr92yayGufCV++BPz/d4vbyOl2rA4X
	 WcOa8zWuCwltIf/KhPERDCY17umRcpRZj758ehx5FNRT+GOr2wG1F5JFhAt0M/ivHRcYL
	 jl4uSgTfB2o9nN4g3aqj1SI/XcOtnKrPLGGx1yol2auysZLVSpCai4piaq7F4sA8IQ0Od
	 i7pEsFAqL1V/JcD8nsGZ+Q/X82BvPLl6iJFMEgIuX+Lrgwz1Q4snDKmfrCR9n2aqn6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SPkctM56;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A73606A31A;
	Wed, 21 Oct 2026 12:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SPkctM56
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sF9LDzpQEaJzHtp3EejibVBr7yA0oWFz7PGqdD3p6ho=;
	b=SPkctM56Yi8TqBS6mx07tEet+yjU0hakrT5vu+O7nRYE2A5O/XQnUEYMqVyoYB4HZ7olOXVlF
	cIKFtTgA2jbpwNNYc13lRs7B4gYA27t5XRvmpAe+CtEsLSvw7mJv5NNej9BS31UZtTxpQN3SNgq
	OgIkfu5bldgzT0Cv1h92G84=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4j8pB90RCgz1T4Gb;
	Wed, 21 Oct 2026 20:14:41 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3676940579;
	Wed, 21 Oct 2026 20:14:49 +0800 (CST)
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
Subject: [PATCH v2 net 3/3] net: hns3: fix use-after-free in debugfs read during reset/unload
Date: Wed, 21 Oct 2026 20:14:26 +0800
Message-ID: <20261021121426.3096838-4-shaojijie@huawei.com>
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

The seq_file refactoring of hns3 debugfs removed the per-file entry
state checks. Without them, debugfs show callbacks can access
priv->ring, priv->tqp_vector, and ring->desc while these resources
are being freed by reset, driver unload, or ethtool ring resize.

Plain state-bit checks leave a TOCTOU window between check and use.

Fix by adding a mutex (dbg_mutex) to struct hnae3_handle, used by
enet-layer debugfs callbacks. Readers acquire the mutex, then check
device state per iteration -- this lets an in-flight reader exit
promptly when reset begins mid-dump, keeping reset latency bounded
by one iteration, and also rejects a reader that arrives after the
writer has finished tearing down resources (priv->ring is NULL by
then). Writers clear INITED first to signal readers, then acquire
the mutex before freeing resources. The dbg_uninit() call stays
outside the mutex to avoid deadlock with debugfs_remove_recursive.

Fixes: eced3d1c41db ("net: hns3: use seq_file for files in queue/ in debugfs")
Closes: https://lore.kernel.org/all/a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com/
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
Changes in v2:
  - Drop hclge_debugfs.c changes; mutex only protects enet-layer
    debugfs callbacks.
  - Replace guard(mutex) with explicit mutex_lock/unlock and
    "goto unlock" error-path labels.
  - Remove redundant if (!priv->ring) checks in
    hns3_dbg_rx_queue_info() and hns3_dbg_tx_queue_info().
  - Unify per-iteration return values from -EPERM to -EBUSY.
  - Reorder local variables to reverse-Christmas-tree order.
  - Reword changelog to drop the "PF-layer" description.
v1: https://lore.kernel.org/all/20260915132434.1141742-4-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 124 +++++++++++-------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   7 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   2 +
 4 files changed, 88 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 4286af9239b0..e94cc33da864 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -944,6 +944,7 @@ struct hnae3_handle {
 
 	u8 netdev_flags;
 	struct dentry *hnae3_dbgfs;
+	struct mutex dbg_mutex;	/* protect debugfs against reset/unload */
 
 	/* Network interface message level enabled bits */
 	u32 msg_enable;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 1347edac7699..40d715924e58 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -389,6 +389,12 @@ static const char * const dim_state_str[] = { "START", "IN_PROG", "APPLY" };
 static const char * const
 dim_tune_stat_str[] = { "ON_TOP", "TIRED", "RIGHT", "LEFT" };
 
+static bool hns3_dbg_is_device_busy(struct hns3_nic_priv *priv)
+{
+	return !test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+	       test_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
+}
+
 static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 			       struct seq_file *s, int i, bool is_tx)
 {
@@ -434,7 +440,7 @@ static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 	}
 }
 
-static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
+static int hns3_dump_coal_info(struct seq_file *s, bool is_tx)
 {
 	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_enet_tqp_vector *tqp_vector;
@@ -448,18 +454,34 @@ static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
 	seq_puts(s, "HW_GL  HW_QL\n");
 
 	for (i = 0; i < priv->vector_num; i++) {
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
+
 		tqp_vector = &priv->tqp_vector[i];
 		hns3_get_coal_info(tqp_vector, s, i, is_tx);
 	}
+
+	return 0;
 }
 
 static int hns3_dbg_coal_info(struct seq_file *s, void *data)
 {
-	hns3_dump_coal_info(s, true);
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
+	struct hns3_nic_priv *priv = h->priv;
+	int ret;
+
+	mutex_lock(&priv->ae_handle->dbg_mutex);
+	ret = hns3_dump_coal_info(s, true);
+	if (ret)
+		goto unlock;
+
 	seq_puts(s, "\n");
-	hns3_dump_coal_info(s, false);
+	ret = hns3_dump_coal_info(s, false);
 
-	return 0;
+unlock:
+	mutex_unlock(&priv->ae_handle->dbg_mutex);
+	return ret;
 }
 
 static void hns3_dump_rx_queue_info(struct hns3_enet_ring *ring,
@@ -504,27 +526,22 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
-	if (!priv->ring) {
-		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
-		return -EFAULT;
-	}
-
+	mutex_lock(&priv->ae_handle->dbg_mutex);
 	seq_puts(s, "QUEUE_ID  BD_NUM  BD_LEN  TAIL  HEAD  FBDNUM  ");
 	seq_puts(s, "PKTNUM     COPYBREAK  RING_EN  RX_RING_EN  BASE_ADDR\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
-		/* Each cycle needs to determine whether the instance is reset,
-		 * to prevent reference to invalid memory. And need to ensure
-		 * that the following code is executed within 100ms.
-		 */
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-			return -EPERM;
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv)) {
+			mutex_unlock(&priv->ae_handle->dbg_mutex);
+			return -EBUSY;
+		}
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
 		hns3_dump_rx_queue_info(ring, s, i);
 	}
 
+	mutex_unlock(&priv->ae_handle->dbg_mutex);
 	return 0;
 }
 
@@ -569,27 +586,22 @@ static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
-	if (!priv->ring) {
-		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
-		return -EFAULT;
-	}
-
+	mutex_lock(&priv->ae_handle->dbg_mutex);
 	seq_puts(s, "QUEUE_ID  BD_NUM  TC  TAIL  HEAD  FBDNUM  OFFSET  ");
 	seq_puts(s, "PKTNUM     RING_EN  TX_RING_EN  BASE_ADDR\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
-		/* Each cycle needs to determine whether the instance is reset,
-		 * to prevent reference to invalid memory. And need to ensure
-		 * that the following code is executed within 100ms.
-		 */
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-			return -EPERM;
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv)) {
+			mutex_unlock(&priv->ae_handle->dbg_mutex);
+			return -EBUSY;
+		}
 
 		ring = &priv->ring[i];
 		hns3_dump_tx_queue_info(ring, s, i);
 	}
 
+	mutex_unlock(&priv->ae_handle->dbg_mutex);
 	return 0;
 }
 
@@ -604,14 +616,23 @@ static int hns3_dbg_queue_map(struct seq_file *s, void *data)
 
 	seq_puts(s, "local_queue_id  global_queue_id  vector_id\n");
 
+	mutex_lock(&priv->ae_handle->dbg_mutex);
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv)) {
+			mutex_unlock(&priv->ae_handle->dbg_mutex);
+			return -EBUSY;
+		}
+
 		if (!priv->ring || !priv->ring[i].tqp_vector)
 			continue;
+
 		seq_printf(s, "%-16u%-17u%d\n", i,
 			   h->ae_algo->ops->get_global_queue_id(h, i),
 			   priv->ring[i].tqp_vector->vector_irq);
 	}
 
+	mutex_unlock(&priv->ae_handle->dbg_mutex);
 	return 0;
 }
 
@@ -661,8 +682,11 @@ static int hns3_dbg_rx_bd_info(struct seq_file *s, void *private)
 
 	ring = &priv->ring[data->qid + data->handle->kinfo.num_tqps];
 	for (i = 0; i < ring->desc_num; i++) {
-		desc = &ring->desc[i];
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
+		desc = &ring->desc[i];
 		hns3_dump_rx_bd_info(priv, desc, s, i);
 	}
 
@@ -706,8 +730,11 @@ static int hns3_dbg_tx_bd_info(struct seq_file *s, void *private)
 
 	ring = &priv->ring[data->qid];
 	for (i = 0; i < ring->desc_num; i++) {
-		desc = &ring->desc[i];
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
+		desc = &ring->desc[i];
 		hns3_dump_tx_bd_info(desc, s, i);
 	}
 
@@ -796,13 +823,9 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
-	if (!priv->ring) {
-		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
-		return -EFAULT;
-	}
-
-	if (!priv->ring[h->kinfo.num_tqps].page_pool) {
-		dev_err(&h->pdev->dev, "page pool is not initialized\n");
+	mutex_lock(&priv->ae_handle->dbg_mutex);
+	if (!priv->ring || !priv->ring[h->kinfo.num_tqps].page_pool) {
+		mutex_unlock(&priv->ae_handle->dbg_mutex);
 		return -EFAULT;
 	}
 
@@ -810,14 +833,17 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	seq_puts(s, "POOL_SIZE(PAGE_NUM)  ORDER  NUMA_ID  MAX_LEN\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-			return -EPERM;
+		/* Per-iteration check bounds reset latency to one iteration. */
+		if (hns3_dbg_is_device_busy(priv)) {
+			mutex_unlock(&priv->ae_handle->dbg_mutex);
+			return -EBUSY;
+		}
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
 		hns3_dump_page_pool_info(ring, s, i);
 	}
 
+	mutex_unlock(&priv->ae_handle->dbg_mutex);
 	return 0;
 }
 
@@ -826,17 +852,23 @@ static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
 	struct hns3_dbg_data *data = s->private;
 	struct hnae3_handle *h = data->handle;
 	struct hns3_nic_priv *priv = h->priv;
+	int ret;
 
-	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-		return -EBUSY;
+	mutex_lock(&priv->ae_handle->dbg_mutex);
+	if (!priv->ring) {
+		mutex_unlock(&priv->ae_handle->dbg_mutex);
+		return -EFAULT;
+	}
 
 	if (data->cmd == HNAE3_DBG_CMD_TX_BD)
-		return hns3_dbg_tx_bd_info(s, private);
+		ret = hns3_dbg_tx_bd_info(s, private);
 	else if (data->cmd == HNAE3_DBG_CMD_RX_BD)
-		return hns3_dbg_rx_bd_info(s, private);
+		ret = hns3_dbg_rx_bd_info(s, private);
+	else
+		ret = -EOPNOTSUPP;
 
-	return -EOPNOTSUPP;
+	mutex_unlock(&priv->ae_handle->dbg_mutex);
+	return ret;
 }
 DEFINE_SHOW_ATTRIBUTE(hns3_dbg_bd_info);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 09f688893aab..aa5332e4dd29 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5450,6 +5450,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->min_tx_copybreak = 0;
 	priv->min_tx_spare_buf_size = 0;
 	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
+	mutex_init(&handle->dbg_mutex);
 
 	handle->msg_enable = netif_msg_init(debug, DEFAULT_MSG_LEVEL);
 
@@ -5563,6 +5564,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->ring = NULL;
 out_get_ring_cfg:
 	priv->ae_handle = NULL;
+	mutex_destroy(&handle->dbg_mutex);
 	free_netdev(netdev);
 	return ret;
 }
@@ -5586,6 +5588,7 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_free_rx_cpu_rmap(netdev);
 
+	mutex_lock(&handle->dbg_mutex);
 	hns3_nic_uninit_irq(priv);
 
 	hns3_clear_all_ring(handle, true);
@@ -5597,9 +5600,11 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	hns3_uninit_all_ring(priv);
 
 	hns3_put_ring_config(priv);
+	mutex_unlock(&handle->dbg_mutex);
 
 out_netdev_free:
 	hns3_dbg_uninit(handle);
+	mutex_destroy(&handle->dbg_mutex);
 	free_netdev(netdev);
 }
 
@@ -5876,6 +5881,7 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 		return 0;
 	}
 
+	mutex_lock(&handle->dbg_mutex);
 	hns3_free_rx_cpu_rmap(netdev);
 	hns3_nic_uninit_irq(priv);
 	hns3_clear_all_ring(handle, true);
@@ -5888,6 +5894,7 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	hns3_uninit_all_ring(priv);
 
 	hns3_put_ring_config(priv);
+	mutex_unlock(&handle->dbg_mutex);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 392653635bda..cb6a23085be4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1258,6 +1258,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	if (if_running)
 		ndev->netdev_ops->ndo_stop(ndev);
 
+	mutex_lock(&h->dbg_mutex);
 	hns3_change_all_ring_bd_num(priv, new_ringparam.tx_desc_num,
 				    new_ringparam.rx_desc_num);
 	hns3_change_rx_buf_len(ndev, new_ringparam.rx_buf_len);
@@ -1276,6 +1277,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
 		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
 			hns3_fini_ring(&tmp_rings[i]);
 	}
+	mutex_unlock(&h->dbg_mutex);
 
 	kfree(tmp_rings);
 
-- 
2.43.0

