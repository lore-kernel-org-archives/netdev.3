Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52441A553;
	Tue, 15 Sep 2026 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478820; cv=none; b=jU2cYcouawg5NVAqruva+B9eWeBhVkgMkSb2XhKmlBTYncqEU1taW/eDyMx9ObhyDAsA+uowhxNAHFe7JTMl5o0PGey2tu0I4kioq/KlEAPCChBIg6iWlYG5uCCbDrDAF+yqSSQBkUugDiSa7NqStXWVYHswlvppDtVu8AxlpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478820; c=relaxed/simple;
	bh=v12YutDfbaWPTUFzSC9yUkiR++sxrwoojUBeE3D2llI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyIp/UjEQRdZQNkwLFvovJXG8awrSIIlqpWfe2JByB0I1AMjPVN6lGzzWEXr89b+p+U0bSqWN56e9DR0KwfB4L4AZ+vLXIn8hqCCoaKONJQ8nu0EZ9Xn6DHTE5m1wmFR4Xy471fLsW6TR109NNMInsGhZxGuK+AlYLvoJocLsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mQsVAqCk; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mQsVAqCk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VttvV2/Bd1LDtPAy5kR23asbxd5UhaSXkKNOklJivXk=;
	b=mQsVAqCkoPViRvNiIsggCnahVl0WrOWuwE5sN0f22PDFux8K0NPMMtYx1288XF06JsLrdbrum
	AuEsf/+BRayT9INHADlETo84fvd3UbnFKFMRnX2xmEa4LQjTMws7IThLn1PD+PbjjR/3L0VqVoS
	Ohrp1YkaYj70AfP+XnYzu6Q=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hkjFH0tjxzRhXM;
	Tue, 15 Sep 2026 21:15:47 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C688B40575;
	Tue, 15 Sep 2026 21:26:42 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 15 Sep 2026 21:26:42 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 3/3] net: hns3: fix use-after-free in debugfs read during reset/unload
Date: Tue, 15 Sep 2026 21:24:34 +0800
Message-ID: <20260915132434.1141742-4-shaojijie@huawei.com>
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

The seq_file refactoring of hns3 debugfs removed the per-file entry
state checks. Without them, debugfs show callbacks can access
priv->ring, priv->tqp_vector, and ring->desc while these resources
are being freed by reset, driver unload, or ethtool ring resize.

Plain state-bit checks leave a TOCTOU window between check and use.

Fix by adding a mutex (dbg_mutex) to struct hnae3_handle, shared by
enet-layer and PF-layer debugfs callbacks via the common handle.
Readers acquire the mutex and check device state at entry and per
iteration -- the latter lets an in-flight reader exit promptly when
reset begins mid-dump, keeping reset latency bounded. Writers clear
INITED first to signal readers, then acquire the mutex before freeing
resources. The dbg_uninit() call stays outside the mutex to avoid
deadlock with debugfs_remove_recursive.

Fixes: eced3d1c41db ("net: hns3: use seq_file for files in queue/ in debugfs")
Closes: https://lore.kernel.org/all/a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com/
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 95 +++++++++++--------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  6 ++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  1 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 14 +++
 5 files changed, 77 insertions(+), 40 deletions(-)

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
index 1347edac7699..7d913302f442 100644
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
@@ -448,18 +454,32 @@ static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
 	seq_puts(s, "HW_GL  HW_QL\n");
 
 	for (i = 0; i < priv->vector_num; i++) {
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
-	seq_puts(s, "\n");
-	hns3_dump_coal_info(s, false);
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
+	struct hns3_nic_priv *priv = h->priv;
+	int ret;
 
-	return 0;
+	guard(mutex)(&priv->ae_handle->dbg_mutex);
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
+	ret = hns3_dump_coal_info(s, true);
+	if (ret)
+		return ret;
+
+	seq_puts(s, "\n");
+	return hns3_dump_coal_info(s, false);
 }
 
 static void hns3_dump_rx_queue_info(struct hns3_enet_ring *ring,
@@ -504,22 +524,16 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
-	if (!priv->ring) {
-		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
-		return -EFAULT;
-	}
+	guard(mutex)(&priv->ae_handle->dbg_mutex);
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
 
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
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
 		hns3_dump_rx_queue_info(ring, s, i);
@@ -569,22 +583,16 @@ static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
-	if (!priv->ring) {
-		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
-		return -EFAULT;
-	}
+	guard(mutex)(&priv->ae_handle->dbg_mutex);
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
 
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
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
 		ring = &priv->ring[i];
 		hns3_dump_tx_queue_info(ring, s, i);
@@ -604,9 +612,14 @@ static int hns3_dbg_queue_map(struct seq_file *s, void *data)
 
 	seq_puts(s, "local_queue_id  global_queue_id  vector_id\n");
 
+	guard(mutex)(&priv->ae_handle->dbg_mutex);
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
-		if (!priv->ring || !priv->ring[i].tqp_vector)
-			continue;
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
+
 		seq_printf(s, "%-16u%-17u%d\n", i,
 			   h->ae_algo->ops->get_global_queue_id(h, i),
 			   priv->ring[i].tqp_vector->vector_irq);
@@ -661,8 +674,10 @@ static int hns3_dbg_rx_bd_info(struct seq_file *s, void *private)
 
 	ring = &priv->ring[data->qid + data->handle->kinfo.num_tqps];
 	for (i = 0; i < ring->desc_num; i++) {
-		desc = &ring->desc[i];
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
+		desc = &ring->desc[i];
 		hns3_dump_rx_bd_info(priv, desc, s, i);
 	}
 
@@ -706,8 +721,10 @@ static int hns3_dbg_tx_bd_info(struct seq_file *s, void *private)
 
 	ring = &priv->ring[data->qid];
 	for (i = 0; i < ring->desc_num; i++) {
-		desc = &ring->desc[i];
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
+		desc = &ring->desc[i];
 		hns3_dump_tx_bd_info(desc, s, i);
 	}
 
@@ -796,10 +813,9 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
-	if (!priv->ring) {
-		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
-		return -EFAULT;
-	}
+	guard(mutex)(&priv->ae_handle->dbg_mutex);
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
 
 	if (!priv->ring[h->kinfo.num_tqps].page_pool) {
 		dev_err(&h->pdev->dev, "page pool is not initialized\n");
@@ -810,9 +826,8 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	seq_puts(s, "POOL_SIZE(PAGE_NUM)  ORDER  NUMA_ID  MAX_LEN\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-			return -EPERM;
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
 		hns3_dump_page_pool_info(ring, s, i);
@@ -827,8 +842,8 @@ static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
 	struct hnae3_handle *h = data->handle;
 	struct hns3_nic_priv *priv = h->priv;
 
-	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+	guard(mutex)(&priv->ae_handle->dbg_mutex);
+	if (hns3_dbg_is_device_busy(priv))
 		return -EBUSY;
 
 	if (data->cmd == HNAE3_DBG_CMD_TX_BD)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0c088feae03c..bae8b32ffc5b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5449,6 +5449,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->min_tx_copybreak = 0;
 	priv->min_tx_spare_buf_size = 0;
 	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
+	mutex_init(&handle->dbg_mutex);
 
 	handle->msg_enable = netif_msg_init(debug, DEFAULT_MSG_LEVEL);
 
@@ -5562,6 +5563,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->ring = NULL;
 out_get_ring_cfg:
 	priv->ae_handle = NULL;
+	mutex_destroy(&handle->dbg_mutex);
 	free_netdev(netdev);
 	return ret;
 }
@@ -5585,6 +5587,7 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_free_rx_cpu_rmap(netdev);
 
+	mutex_lock(&handle->dbg_mutex);
 	hns3_nic_uninit_irq(priv);
 
 	hns3_clear_all_ring(handle, true);
@@ -5596,9 +5599,11 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	hns3_uninit_all_ring(priv);
 
 	hns3_put_ring_config(priv);
+	mutex_unlock(&handle->dbg_mutex);
 
 out_netdev_free:
 	hns3_dbg_uninit(handle);
+	mutex_destroy(&handle->dbg_mutex);
 	free_netdev(netdev);
 }
 
@@ -5875,6 +5880,7 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 		return 0;
 	}
 
+	guard(mutex)(&handle->dbg_mutex);
 	hns3_free_rx_cpu_rmap(netdev);
 	hns3_nic_uninit_irq(priv);
 	hns3_clear_all_ring(handle, true);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 392653635bda..4e7a7e6b21ee 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1258,6 +1258,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
 	if (if_running)
 		ndev->netdev_ops->ndo_stop(ndev);
 
+	guard(mutex)(&h->dbg_mutex);
 	hns3_change_all_ring_bd_num(priv, new_ringparam.tx_desc_num,
 				    new_ringparam.rx_desc_num);
 	hns3_change_rx_buf_len(ndev, new_ringparam.rx_buf_len);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 9a4e29bfa166..1e9d3e08b7de 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -15,6 +15,12 @@
 #define hclge_seq_file_to_hdev(s)	\
 		(((struct hnae3_ae_dev *)hnae3_seq_file_to_ae_dev(s))->priv)
 
+static bool hclge_dbg_is_device_busy(struct hclge_dev *hdev)
+{
+	return test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
+	       test_bit(HCLGE_STATE_RST_FAIL, &hdev->state);
+}
+
 static const char * const hclge_mac_state_str[] = {
 	"TO_ADD", "TO_DEL", "ACTIVE"
 };
@@ -2621,6 +2627,10 @@ static int hclge_dbg_dump_umv_info(struct seq_file *s, void *data)
 	struct hclge_vport *vport;
 	u8 i;
 
+	guard(mutex)(&hdev->vport[0].nic.dbg_mutex);
+	if (hclge_dbg_is_device_busy(hdev))
+		return -EBUSY;
+
 	seq_printf(s, "num_alloc_vport   : %u\n", hdev->num_alloc_vport);
 	seq_printf(s, "max_umv_size     : %u\n", hdev->max_umv_size);
 	seq_printf(s, "wanted_umv_size  : %u\n", hdev->wanted_umv_size);
@@ -2831,6 +2841,10 @@ static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev,
 	int ret;
 	u8 i;
 
+	guard(mutex)(&hdev->vport[0].nic.dbg_mutex);
+	if (hclge_dbg_is_device_busy(hdev))
+		return -EBUSY;
+
 	seq_puts(s, "FUNC_ID  PVID  ACCEPT_TAG1  ACCEPT_TAG2 ACCEPT_UNTAG1  ");
 	seq_puts(s, "ACCEPT_UNTAG2  INSERT_TAG1  INSERT_TAG2  SHIFT_TAG  ");
 	seq_puts(s, "STRIP_TAG1  STRIP_TAG2  DROP_TAG1  DROP_TAG2  ");
-- 
2.43.0

