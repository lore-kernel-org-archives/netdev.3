Received: from out198-26.us.a.mail.aliyun.com (out198-26.us.a.mail.aliyun.com [47.90.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7B371046;
	Thu, 23 Jul 2026 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779306; cv=none; b=o6Sj+ZRnAq8Go+HDlVa4n9BRpRoVUE6tdUNzfsjCR7i/s8RVgBKvStgrady54ljwL88/TTiC2Im53obKWfwBaqFDLGTKSX0RIFgxQfqIXW17CosNzRaeCEHAlIFDQ5JL11ujtYLLYjcRcKblB8cBB5JeCfo5kL+cKXhzeS/wyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779306; c=relaxed/simple;
	bh=GckmmfPvwZxuYsRayoV4vPRyOyXsqZdYEEsdE60piHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbyUjBq2hfbXPFZBsurXduwVEhwusyecgnCR8v/+CNelMz2JA9Sna/m4KDM/NTf08nAuxkhzILzO+jxr/aLutbAVOucTTIdCbDs9jIqdVxw7MjiB+fA0/cwYdH7u3tMq9/bm/fHMJ5hTJOuQx7LjZ7B8A9uWuu74UhnkC0Y3mmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0116174-0.00132823-0.987054;FP=18028890183444219634|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iSkYubd_1784779286;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iSkYubd_1784779286 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 12:01:27 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v22 net-next 12/12] net/nebula-matrix: add common dev start/stop operation
Date: Thu, 23 Jul 2026 12:01:04 +0800
Message-ID: <20260723040110.91410-13-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add device start/stop helper functions to manage MSI-X vector mapping,
mailbox interrupt resource initialization and deinitialization.
Create unbound global workqueue for mailbox task scheduling; this shared
work infrastructure supports both current interrupt-driven receive and
future polling receive path.

This patch implements complete startup and shutdown flow for
common device resources:
1. Add nbl_dev_start() to finish device startup procedure:
   - Configure hardware MSI-X mapping table for different interrupt types
   - Allocate required MSI-X irq vectors via pci_alloc_irq_vectors
   - Request mailbox IRQ; interrupt handler schedules mailbox processing work
   - Enable hardware mailbox interrupt and mark channel interrupt ready

2. Add nbl_dev_stop() to tear down device resources safely in strict order:
   - Update software channel state first to switch to polling, then mask
     hardware interrupt to avoid stale ACK handling
   - Free mailbox IRQ handler and release MSI-X vector resources
   - Destroy hardware MSI-X mapping table

Extend channel TX waiting logic with polling fallback and shutdown detection.
When interrupt path is disabled, send routines rely on active polling to
wait for message ACK, preventing deadlock during device stop.

Hook nbl_core_start() / nbl_core_stop() into PCI probe and remove paths.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nbl/nbl_channel/nbl_channel.c             |  44 +++
 .../nbl/nbl_channel/nbl_channel.h             |   3 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  21 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 273 +++++++++++++++++-
 .../nbl/nbl_include/nbl_def_common.h          |   3 +
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  22 +-
 8 files changed, 361 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
index eb0d55dad944..762243a664b9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -725,6 +725,7 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
 	struct nbl_common_info *common = chan_mgt->common;
 	struct nbl_chan_waitqueue_head *wait_head;
 	struct nbl_chan_tx_param tx_param = { 0 };
+	int i = NBL_CHAN_TX_WAIT_ACK_TIMES;
 	struct nbl_chan_info *chan_info =
 		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
 	struct device *dev = common->dev;
@@ -852,6 +853,49 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
 		goto inflight_dec_out;
 	}
 
+	/* Polling: only init/deinit, add shutdown detect to avoid deadlock */
+	while (i--) {
+		if (READ_ONCE(chan_info->shutdown)) {
+			ret = -ESHUTDOWN;
+			goto inflight_dec_out;
+		}
+		/* Order shutdown read before accessing clean_task/workqueue */
+		smp_rmb();
+		if (READ_ONCE(chan_info->clean_task) && common->wq)
+			queue_work(common->wq, chan_info->clean_task);
+
+		spin_lock_irq(&wait_head->status_lock);
+		if (READ_ONCE(wait_head->acked)) {
+			/*
+			 * Memory barrier: ensure ack_data/ack_err are fully
+			 * written before reading, avoid multi-core stale data
+			 * due to CPU out-of-order execution.
+			 */
+			smp_rmb();
+			chan_send->ack_len = wait_head->ack_data_len;
+			ret = wait_head->ack_err;
+			wait_head->acked = 0;
+			wait_head->status = NBL_MBX_STATUS_IDLE;
+			spin_unlock_irq(&wait_head->status_lock);
+			goto inflight_dec_out;
+		}
+		spin_unlock_irq(&wait_head->status_lock);
+
+		usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
+			     NBL_CHAN_TX_WAIT_ACK_US_MAX);
+	}
+
+	spin_lock_irq(&wait_head->status_lock);
+	wait_head->acked = 0;
+	wait_head->ack_data = NULL;
+	wait_head->ack_data_len = 0;
+	wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+	spin_unlock_irq(&wait_head->status_lock);
+
+	dev_err(dev,
+		"Channel polling ack failed, message type: %d msg id: %u\n",
+		chan_send->msg_type, msgid);
+	ret = -ETIMEDOUT;
 inflight_dec_out:
 	atomic_dec(&chan_info->inflight_tx_cnt);
 	return ret;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
index 3ee84fc976c3..45a50844a4fa 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -24,6 +24,9 @@
 #define NBL_CHAN_TX_WAIT_US			100
 #define NBL_CHAN_TX_WAIT_US_MAX			120
 #define NBL_CHAN_TX_WAIT_TIMES			100
+#define NBL_CHAN_TX_WAIT_ACK_US_MIN		1000
+#define NBL_CHAN_TX_WAIT_ACK_US_MAX		1200
+#define NBL_CHAN_TX_WAIT_ACK_TIMES		5000
 #define NBL_CHAN_QUEUE_LEN			256
 #define NBL_CHAN_CLEAN_BATCH_SIZE		32
 #define NBL_CHAN_BUF_LEN			4096
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
index f1cd8e7d8a7f..d02b1f0365be 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -6,6 +6,27 @@
 #include <linux/device.h>
 #include "nbl_common.h"
 
+void nbl_common_destroy_wq(struct nbl_common_info *common)
+{
+	destroy_workqueue(common->wq);
+}
+
+int nbl_common_create_wq(struct nbl_common_info *common)
+{
+	char wq_name[32];
+
+	snprintf(wq_name, sizeof(wq_name), "nbl_wq_%s", pci_name(common->pdev));
+	common->wq = alloc_workqueue(wq_name, WQ_UNBOUND, 0);
+	if (!common->wq) {
+		pr_err("Failed to create workqueue nbl_wq\n");
+		goto alloc_wq_failed;
+	}
+
+	return 0;
+alloc_wq_failed:
+	return -ENOMEM;
+}
+
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
 					  u32 pf_id)
 {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index beeabf627402..5ab8555cf91f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -50,5 +50,7 @@ struct nbl_adapter {
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index eae6a00e6fcc..ca0a51ea77ae 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -6,6 +6,17 @@
 #include <linux/pci.h>
 #include "nbl_dev.h"
 
+static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
+
+/* ----------  Interrupt config  ---------- */
+static irqreturn_t nbl_dev_clean_mailbox(int __always_unused irq, void *data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
+
+	nbl_dev_clean_mailbox_schedule(dev_mgt);
+	return IRQ_HANDLED;
+}
+
 static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
@@ -14,6 +25,187 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
 	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
 }
 
+static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	u16 local_vec_id;
+	int irq_num;
+	int err;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = pci_irq_vector(common->pdev, local_vec_id);
+	if (irq_num < 0) {
+		dev_err(common->dev, "Failed to get mailbox IRQ vector: %d\n",
+			irq_num);
+		return irq_num;
+	}
+
+	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
+		 "nbl_mailbox@pci:%s", pci_name(common->pdev));
+	err = request_irq(irq_num, nbl_dev_clean_mailbox, 0,
+			  dev_common->mailbox_name, dev_mgt);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void nbl_dev_free_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	u16 local_vec_id;
+	int irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = pci_irq_vector(common->pdev, local_vec_id);
+	if (irq_num >= 0)
+		free_irq(irq_num, dev_mgt);
+}
+
+static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, true);
+
+	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
+					    local_vec_id, true);
+}
+
+static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	/*
+	 * Disable sequence invariant: update software state first, then mask
+	 * hardware interrupt. Must not reverse the order.
+	 *
+	 * If hardware interrupt is masked before clearing INTERRUPT_READY,
+	 * the hardware may still transmit outstanding ACK packets for in-flight
+	 * messages. Subsequent switch to polling mode discards pending ACK
+	 * processing, triggering "Channel waiting ack failed" and "Skip ack
+	 * with invalid status" errors.
+	 *
+	 * By entering polling mode first, any late hardware interrupts are
+	 * ignored without pending ACK expectations, then hardware interrupt
+	 * can be safely disabled.
+	 *
+	 * This helper is invoked in two paths:
+	 * 1. Error unwind path of nbl_dev_start(): immediately followed by
+	 *    nbl_dev_free_mailbox_irq(), channel resources
+	 *    are fully torn down afterwards, no stale descriptors remain.
+	 * 2. Normal device stop path nbl_dev_stop(): free_irq() synchronously
+	 *    waits for any in-flight threaded irq bottom-half handler to
+	 *    finish execution, all pending mailbox cleanup work completes
+	 *    before channel teardown in late remove stage. No stuck
+	 *    descriptors will linger in either scenario.
+	 */
+	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, false);
+
+	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
+					    local_vec_id, false);
+}
+
+static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
+	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+	u16 msix_not_net_num = 0;
+	int err, i;
+
+	msix_info->serv_info[NBL_MSIX_VIRTIO_TYPE].base_vector_id = 0;
+	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
+		msix_info->serv_info[i].base_vector_id =
+			msix_info->serv_info[i - 1].base_vector_id +
+			msix_info->serv_info[i - 1].num;
+
+	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++) {
+		if (i == NBL_MSIX_NET_TYPE)
+			continue;
+		msix_not_net_num += msix_info->serv_info[i].num;
+	}
+
+	err = disp_ops->configure_msix_map(dev_mgt->disp_ops_tbl->priv,
+					   msix_net_num, msix_not_net_num,
+					   mask_en);
+
+	return err;
+}
+
+static int nbl_dev_destroy_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+
+	return disp_ops->destroy_msix_map(dev_mgt->disp_ops_tbl->priv);
+}
+
+static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	int needed = 0;
+	int err;
+	int i;
+
+	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
+		needed += msix_info->serv_info[i].num;
+
+	err = pci_alloc_irq_vectors(common->pdev, needed, needed,
+				    PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+	if (err < 0) {
+		dev_err(common->dev,
+			"pci_alloc_irq_vectors failed, err = %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = dev_mgt->common;
+
+	pci_free_irq_vectors(common->pdev);
+}
+
 /* ----------  Channel config  ---------- */
 static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
@@ -72,6 +264,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
 				      NBL_CHAN_TYPE_MAILBOX);
 }
 
+static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	struct nbl_common_info *common = dev_mgt->common;
+
+	queue_work(common->wq, &common_dev->clean_mbx_task);
+}
+
 /* ----------  Dev init process  ---------- */
 static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
 {
@@ -95,11 +295,6 @@ static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
 	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
 	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
 				   &common_dev->clean_mbx_task);
-	/*
-	 * Even if has_ctrl=false (no dedicated control PF channel), we fetch
-	 * VSI/ETH info via regular mailbox message  instead of
-	 * dedicated control command.
-	 */
 	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
 	if (ret)
 		goto err_cleanup;
@@ -194,7 +389,9 @@ int nbl_dev_init(struct nbl_adapter *adapter)
 	dev_mgt->disp_ops_tbl = disp_ops_tbl;
 	dev_mgt->chan_ops_tbl = chan_ops_tbl;
 	adapter->core.dev_mgt = dev_mgt;
-
+	ret = nbl_common_create_wq(common);
+	if (ret)
+		return ret;
 	/*
 	 * Chip hardware initialization is completed by firmware at power-up.
 	 * Only driver functional table/register config follows here, safe to
@@ -202,7 +399,7 @@ int nbl_dev_init(struct nbl_adapter *adapter)
 	 */
 	ret = nbl_dev_setup_common_dev(adapter);
 	if (ret)
-		return ret;
+		goto setup_err;
 
 	if (common->has_ctrl) {
 		ret = nbl_dev_setup_ctrl_dev(adapter);
@@ -213,6 +410,8 @@ int nbl_dev_init(struct nbl_adapter *adapter)
 	return 0;
 setup_ctrl_dev_fail:
 	nbl_dev_remove_common_dev(adapter);
+setup_err:
+	nbl_common_destroy_wq(common);
 	return ret;
 }
 
@@ -229,4 +428,64 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
 	if (common->has_ctrl)
 		nbl_dev_remove_ctrl_dev(adapter);
 	nbl_dev_remove_common_dev(adapter);
+	nbl_common_destroy_wq(common);
+}
+
+/* ----------  Dev start process  ---------- */
+int nbl_dev_start(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int cleanup_ret;
+	int ret;
+
+	ret = nbl_dev_configure_msix_map(dev_mgt);
+	if (ret)
+		return ret;
+
+	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
+	if (ret)
+		goto init_interrupt_scheme_err;
+	ret = nbl_dev_request_mailbox_irq(dev_mgt);
+	if (ret)
+		goto mailbox_request_irq_err;
+	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
+	if (ret)
+		goto enable_mailbox_irq_err;
+
+	return 0;
+enable_mailbox_irq_err:
+	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to disable mailbox IRQ: %d\n", cleanup_ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+mailbox_request_irq_err:
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+init_interrupt_scheme_err:
+	cleanup_ret =  nbl_dev_destroy_msix_map(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", cleanup_ret);
+	return ret;
+}
+
+void nbl_dev_stop(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int ret;
+
+	ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to disable mailbox IRQ: %d\n", ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", ret);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 0e0ea10e20c7..2816132b69d1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -29,6 +29,7 @@ struct nbl_hash_tbl_mgt;
 	})
 
 struct nbl_common_info {
+	struct workqueue_struct *wq;
 	struct pci_dev *pdev;
 	struct device *dev;
 	u32 msg_enable;
@@ -55,6 +56,8 @@ struct nbl_hash_tbl_key {
 	u16 resv;
 };
 
+void nbl_common_destroy_wq(struct nbl_common_info *common);
+int nbl_common_create_wq(struct nbl_common_info *common);
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
 					  u32 pf_id);
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index b422a4edf0a9..32e6cce38d39 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -10,5 +10,7 @@ struct nbl_adapter;
 
 int nbl_dev_init(struct nbl_adapter *adapter);
 void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter);
+void nbl_dev_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 24d9f7474e53..4fa0b7a892d9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -16,6 +16,16 @@
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
+int nbl_core_start(struct nbl_adapter *adapter)
+{
+	return nbl_dev_start(adapter);
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	nbl_dev_stop(adapter);
+}
+
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param)
 {
@@ -137,7 +147,14 @@ static int nbl_probe(struct pci_dev *pdev,
 		goto adapter_init_err;
 	}
 	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter);
+	if (err)
+		goto core_start_err;
+
 	return 0;
+core_start_err:
+	pci_set_drvdata(pdev, NULL);
+	nbl_core_remove(adapter);
 adapter_init_err:
 	pci_clear_master(pdev);
 configure_dma_err:
@@ -149,9 +166,10 @@ static void nbl_remove(struct pci_dev *pdev)
 {
 	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
 
-	if (adapter)
+	if (adapter) {
+		nbl_core_stop(adapter);
 		nbl_core_remove(adapter);
-
+	}
 	pci_restore_state(pdev);
 	pci_clear_master(pdev);
 	pci_disable_device(pdev);
-- 
2.47.3

