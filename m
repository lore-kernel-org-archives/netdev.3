Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0230AAA6;
	Mon, 28 Sep 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598780; cv=none; b=IAufjWmMxKFybTIeEhjP17eHN9YIgBqtqPbCHHkrEjpkB+n0CZI85pDdNL8K4VF6+H6mP+ihskhezDh/TRRTdpYUvjXTJ9HCMRQXr18ybKQwV7JWt/SqXBWS7GVtktMEZWYs0i2fFsPmhgv6Ohl8TBaaUluWRhhN7X7AUe0HcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598780; c=relaxed/simple;
	bh=aA3LK37ND8InfgoOb6toJSO/Iwh/BYmtBcawKezOHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vawjbh/pJc9KDDZ9Kh1GRZpu4M7noPOXPXpiJwshPYa6O/hQwGbqvp8DwMe0FoLr0w0PJZ4NFI3DKXQ7/JFkndE9V55kbJ1NBZxHxYc3utjD4uLUfA0nFRL2Xk7Bjj0WT+i26zjZ6Qt4uoCCbDZ0n2d0FJlEB67ROWWy32q+U50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00473138-0.000749274-0.994519;FP=17470580871598200306|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jQ6tpnt_1790598767;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jQ6tpnt_1790598767 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 20:32:48 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v30 net-next 8/8] net/nebula-matrix: add common dev start/stop operation
Date: Mon, 28 Sep 2026 20:32:33 +0800
Message-ID: <20260928123237.88994-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928123237.88994-1-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Implement nbl_dev_start() and nbl_dev_stop() to manage MSI-X hardware
mapping and mailbox interrupt setup/teardown.

nbl_dev_start() performs device startup in strict order: configure hardware
MSI-X mapping table, fetch VSI/ETH identity via dispatch RPC, allocate
MSI-X IRQ vectors with mailbox vector affinity isolation, request and
attach mailbox interrupt handler, then enable hardware mailbox interrupt
and mark channel interrupt ready.

Convert mailbox RPC timeouts to -EPROBE_DEFER for non-control PFs on
all startup RPC paths to trigger deferred probing when the control PF
is not ready. Isolate mailbox administrative vector from CPU affinity
management to avoid mailbox RPC stalls caused by CPU offline.

Skip redundant MSI-X map destroy RPC on unconfigured state during probe
rollback to eliminate unnecessary polling timeouts. Adjust interrupt
teardown ordering to clear channel IRQ ready state before masking
hardware interrupts, preventing in-flight ACK discard and "Channel
waiting ack failed" errors.

nbl_dev_stop() tears down resources in reverse startup order. Switch
channel to polling mode and clear IRQ ready state before masking
hardware interrupts to preserve ACK integrity. Release mailbox IRQ
handlers and destroy device-side MSI-X mapping while leaving kernel
MSI-X vectors managed by devres/pcim to avoid double-free.
Drain pending mailbox cleanup work to ensure consistent teardown.

Teardown is best-effort: failed MSI-X destroy RPC leaves stale hardware
entries which are reclaimed by firmware on chip reset, with
pci_clear_master() serving as the final safety net. The start/stop
pair is single-shot and non-repeatable, tied strictly to PCI probe/remove
device lifecycle.

Add thin nbl_core_start()/nbl_core_stop() wrappers and hook them into
PCI probe and remove paths to complete the device lifecycle management
series.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   8 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 372 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  18 +
 4 files changed, 400 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index c3c4dd685bf6..655dfb43e365 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -40,4 +40,12 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
 
+/*
+ * Single-shot start/stop pair, called once each from PCI probe/remove.
+ * Not repeatable: MSI-X vectors stay allocated until device detach, so
+ * a second start on a bound device is rejected by the MSI-X core.
+ */
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index e094b97acdfb..79c62c169d70 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -6,6 +6,17 @@
 #include <linux/pci.h>
 #include "nbl_dev.h"
 
+static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
+
+/* ----------  Interrupt config  ---------- */
+static irqreturn_t nbl_dev_clean_mailbox(int irq __always_unused, void *data)
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
@@ -18,6 +29,233 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
 	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
 }
 
+static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	u16 lvec;
+	int irq_num;
+	int err;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	lvec = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = pci_irq_vector(common->pdev, lvec);
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
+	u16 lvec;
+	int irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return;
+
+	lvec = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = pci_irq_vector(common->pdev, lvec);
+	if (irq_num >= 0)
+		free_irq(irq_num, dev_mgt);
+}
+
+/*
+ * Translate a mailbox RPC timeout on a non-control PF into deferred
+ * probing: the management PF/firmware is not responsive yet and the
+ * driver core should retry once PF0 is ready. Other errors, and all
+ * errors on the control PF itself, pass through unchanged.
+ */
+static int nbl_dev_rpc_timeout(struct nbl_common_info *common, int ret)
+{
+	if (!common->has_ctrl && ret == -ETIMEDOUT)
+		return -EPROBE_DEFER;
+	return ret;
+}
+
+static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	u16 lvec;
+	int ret;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	lvec = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	/*
+	 * Enable sequence: perform set_mailbox_irq RPC in polling mode first.
+	 * Only set NBL_CHAN_IRQ_RDY after RPC succeeds, mirroring disable path.
+	 * This avoids waiting for an interrupt which has not been armed yet.
+	 */
+	ret = disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
+					lvec, true);
+	if (ret)
+		return nbl_dev_rpc_timeout(dev_mgt->common, ret);
+	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
+				  NBL_CHAN_IRQ_RDY,
+				  NBL_CHAN_TYPE_MAILBOX, true);
+	return 0;
+}
+
+static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	u16 lvec;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	lvec = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
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
+	 * 1. Error unwind path of nbl_dev_start(): followed immediately by
+	 * nbl_dev_free_mailbox_irq() and full channel teardown. No new mailbox
+	 * interrupts can fire afterwards, and subsequent cancel_work_sync()
+	 * drains pending cleanup work before resources are released.
+	 * 2. Normal device stop path nbl_dev_stop(): free_irq() blocks until
+	 * any in-flight hardirq handler completes and prevents new interrupts.
+	 * cancel_work_sync() then waits for any already running mailbox cleanup
+	 * work to finish, or cancels queued but unstarted work items before
+	 * final channel destruction. No stuck descriptors linger in either
+	 * scenario.
+	 */
+	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
+				  NBL_CHAN_IRQ_RDY,
+				  NBL_CHAN_TYPE_MAILBOX, false);
+
+	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
+					 lvec, false);
+}
+
+static int nbl_dev_cfg_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
+	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+	u16 msix_not_net_num = 0;
+	int err, i;
+
+	msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id = 0;
+	/*
+	 * Calculate base_vector_id for each MSIX service type.
+	 * This relies on NBL_MSIX_TYPE enum being ordered sequentially,
+	 * starting from NBL_MSIX_NET_TYPE.
+	 */
+	for (i = NBL_MSIX_NET_TYPE + 1; i < NBL_MSIX_TYPE_MAX; i++)
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
+	err = disp_ops->cfg_msix_map(dev_mgt->disp_ops_tbl->priv,
+				     msix_net_num, msix_not_net_num,
+				     mask_en);
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
+	struct irq_affinity affd = { 0 };
+	int needed = 0;
+	int err;
+	int i;
+
+	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
+		needed += msix_info->serv_info[i].num;
+
+	/*
+	 * The mailbox vector is the trailing administrative vector;
+	 * reserve it via post_vectors so it is excluded from managed
+	 * affinity spreading. A managed vector can be shut down when
+	 * its last assigned CPU goes offline, which would stall every
+	 * mailbox RPC while NBL_CHAN_IRQ_RDY stays set.
+	 */
+	affd.post_vectors = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num;
+
+	err = pci_alloc_irq_vectors_affinity(common->pdev, needed, needed,
+					     PCI_IRQ_MSIX | PCI_IRQ_AFFINITY,
+					     &affd);
+	if (err < 0) {
+		dev_err(common->dev,
+			"pci_alloc_irq_vectors failed, err = %d\n", err);
+		return err;
+	}
+	if (err != needed) {
+		dev_err(common->dev, "pci_alloc_irq_vectors got %d vecs, need %d\n",
+			err, needed);
+		return -ENOSPC;
+	}
+	return 0;
+}
+
+/*
+ * Kernel-side MSI-X vectors are deliberately NOT freed here. They are
+ * released at device detach by the pcim_msi_release devres callback
+ * registered by pci_alloc_irq_vectors() (probe uses pcim_enable_device);
+ * freeing them here would double-free that callback.
+ *
+ * Consequently start/stop is a single-shot pair tied to probe/remove:
+ * vectors stay allocated until detach, and a second start against a
+ * device with msix_enabled set is rejected by __pci_enable_msix_range().
+ */
+static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+}
+
 /* ----------  Channel config  ---------- */
 static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
@@ -85,6 +323,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
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
@@ -251,3 +497,129 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
 	if (common->has_ctrl)
 		nbl_dev_remove_ctrl_dev(adapter);
 }
+
+/* ----------  Dev start process  ---------- */
+int nbl_dev_start(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	struct nbl_common_info *common = dev_mgt->common;
+	bool map_ready = false;
+	int cleanup_ret;
+	int ret;
+
+	ret = nbl_dev_rpc_timeout(common, nbl_dev_cfg_msix_map(dev_mgt));
+	if (ret)
+		goto err_destroy_map;
+	map_ready = true;
+
+	/* Fetch VSI/ETH identity after cfg_msix_map */
+	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
+	if (ret) {
+		ret = nbl_dev_rpc_timeout(common, ret);
+		goto err_destroy_map;
+	}
+	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
+				   &common->eth_id, &common->logic_eth_id);
+	if (ret) {
+		ret = nbl_dev_rpc_timeout(common, ret);
+		goto err_destroy_map;
+	}
+
+	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
+	if (ret)
+		goto err_destroy_map;
+
+	ret = nbl_dev_request_mailbox_irq(dev_mgt);
+	if (ret)
+		goto err_destroy_map;
+
+	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
+	if (ret)
+		goto err_disable_irq;
+
+	return 0;
+
+err_disable_irq:
+	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"rollback: disable mailbox IRQ failed: %d\n",
+			cleanup_ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+err_destroy_map:
+	/*
+	 * Destroy the device-side MSI-X map only when it was configured.
+	 * On a cfg RPC failure there is no known-good remote map; when
+	 * the failure is a timeout against an unready/unresponsive
+	 * management PF, issuing the destroy RPC would just burn another
+	 * multi-second ACK timeout. Partial remote state is best-effort
+	 * and reclaimed by firmware on chip reset.
+	 *
+	 * The destroy runs before detach even though kernel vectors stay
+	 * allocated until then (see nbl_dev_clear_interrupt_scheme): it
+	 * masks all hardware vectors and clears the pcompleter map entry,
+	 * so no MSI-X message can be delivered after vectors are released
+	 * at detach.
+	 *
+	 * For non-control PFs this is a polling-mode mailbox RPC
+	 * (IRQ_RDY already cleared by disable above, or never set).
+	 *
+	 * Note: pci_clear_master() runs in nbl_probe() core_start_err path;
+	 * on a non-control PF it cannot stop DMA using the management PF's
+	 * BDF, this is a known limitation.
+	 */
+	if (map_ready) {
+		cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
+		if (cleanup_ret)
+			dev_err(dev_mgt->common->dev,
+				"rollback: destroy MSI-X map failed: %d\n",
+				cleanup_ret);
+	}
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+
+	cancel_work_sync(&common_dev->clean_mbx_task);
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
+
+	/*
+	 * Destroy the hardware MSI-X map now, before the kernel vectors
+	 * are released at device detach (they deliberately stay
+	 * allocated until then - see nbl_dev_clear_interrupt_scheme).
+	 * Masks all device vectors and clears the pcompleter map entry.
+	 *
+	 * Best-effort: if the destroy RPC fails the hardware map stays
+	 * valid until vectors are freed at detach; stale entries rely on
+	 * firmware cleanup on chip reset.
+	 *
+	 * pci_clear_master() on a non-control PF cannot stop DMA using the
+	 * management PF's BDF.
+	 */
+	ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", ret);
+
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+
+	/*
+	 * destroy_msix_map() sends ack-requested messages which may
+	 * requeue clean_mbx_task via polling send path.  Drain work
+	 * after the operation.
+	 */
+	cancel_work_sync(&common_dev->clean_mbx_task);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index 51cf04e4c552..a66c633a0e7a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -10,5 +10,7 @@ struct nbl_adapter;
 
 int nbl_dev_init(struct nbl_adapter *adapter);
 void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter);
+void nbl_dev_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index af430d3dfb70..f16d79504e5d 100644
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
@@ -212,7 +222,13 @@ static int nbl_probe(struct pci_dev *pdev,
 		goto adapter_init_err;
 	}
 	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter);
+	if (err)
+		goto core_start_err;
+
 	return 0;
+core_start_err:
+	nbl_core_remove(adapter);
 adapter_init_err:
 chip_deps_err:
 	pci_clear_master(pdev);
@@ -227,6 +243,8 @@ static void nbl_remove(struct pci_dev *pdev)
 		return;
 
 	pci_set_drvdata(pdev, NULL);
+
+	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 
 	pci_clear_master(pdev);
-- 
2.47.3

