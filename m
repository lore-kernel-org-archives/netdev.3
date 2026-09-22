Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D144F570;
	Tue, 22 Sep 2026 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078614; cv=none; b=L/gY5iid8AbhI067Wq3/GQ0P5t5vPxo0x/poaxVIelkK3ysw+//mYDTz3kckHdzOvems1VBLqV10forr3JFyDAOmzVENP//rAyocCRh0w5NpbvwcBuLNIlfLSiWuCi4Y71bZmqeAdjxVJpOOMVetEVTbikZf+y4eD+6hHMldbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078614; c=relaxed/simple;
	bh=ldd9mi0YLqF/0JSnpUjot5thQq3ZpMjJ/bhmZ2B1Ers=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3zxKsGcqj3ovWYGbou72yzGXx0IFGNyJNf9+Q2lLmw40Oh8nxRXrQlOlAYPqf1p+YZKd8lPTH+adbvSiVEcbkBfSfhS2D8P8actiSzqiI7syriuK5QtQMXNfEcWoh5luVZySKbiAr68gUOZLKimXgw/l6MFzwuEy82QE61Qs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00481734-0.000760873-0.994422;FP=15732195813479701746|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jK4DPWq_1790078601;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jK4DPWq_1790078601 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:03:21 +0800
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
Subject: [PATCH v29 net-next 8/8] net/nebula-matrix: add common dev start/stop operation
Date: Tue, 22 Sep 2026 20:03:05 +0800
Message-ID: <20260922120311.86593-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Implement nbl_dev_start() and nbl_dev_stop() to manage MSI-X
hardware mapping and mailbox interrupt setup/teardown.

nbl_dev_start() performs device startup in strict order:
  1. Configure hardware MSI-X mapping table (cfg_msix_map)
  2. Fetch VSI and ETH identity information via dispatch RPC
     For non-control PF, if mailbox RPC times out because control
     PF is not ready yet, return -EPROBE_DEFER to trigger deferred
     probing, so kernel will retry later once PF0 comes up.
  3. Allocate MSI-X IRQ vectors via pci_alloc_irq_vectors()
  4. Request mailbox interrupt and attach handler
     (nbl_dev_clean_mailbox -> schedule cleanup work)
  5. Enable hardware mailbox interrupt and mark channel
     interrupt ready (NBL_CHAN_IRQ_RDY)

The VSI/ETH identity fetch for all PFs happens inside
nbl_dev_start(), after the MSI-X mapping is configured.
Non-control PFs rely on the control PF's mailbox responder
being fully operational when this RPC runs. If control PF
is not ready, return -EPROBE_DEFER for retry.

nbl_dev_stop() tears down resources in reverse order, with
device-side mapping destroyed before kernel-side vectors are
released:
  1. Switch channel to polling mode (clear NBL_CHAN_IRQ_RDY)
     before masking hardware mailbox interrupt. This ordering
     avoids discarding in-flight ACKs that would trigger
     "Channel waiting ack failed" errors.
  2. Release mailbox IRQ via free_irq()
  3. Destroy hardware MSI-X mapping table (masks all device
     vectors and clears the completer map entry)
  4. Kernel MSI-X vectors are managed by devres/pcim, so
     explicit pci_free_irq_vectors() is skipped to prevent
     double-free.
  5. Drain mailbox cleanup work via cancel_work_sync()

The start error-unwind path uses reverse ordering:
disable mailbox IRQ and free IRQ handler, destroy MSI-X map,
then drain work via cancel_work_sync, so a failure at any stage
leaves the device and kernel in a consistent state. Rollback
failures are logged.

This teardown is best-effort: destroy_msix_map uses mailbox RPC
and may fail. Stale hardware MSI-X entries are reclaimed by
firmware on chip reset. pci_clear_master() in nbl_remove()
provides the final safety net if a teardown RPC to the manager
PF cannot complete.

Add thin wrappers nbl_core_start() / nbl_core_stop() and hook
them into PCI probe and remove paths to control the device
lifecycle. This patch completes the dev lifecycle series.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 342 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  18 +
 4 files changed, 364 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index c3c4dd685bf6..56872c8ca9a7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -39,5 +39,7 @@ struct nbl_adapter {
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 35410c6f1fb9..e672478f6114 100644
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
@@ -18,6 +29,206 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
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
+		return ret;
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
+	if (err != needed) {
+		dev_err(common->dev, "pci_alloc_irq_vectors got %d vecs, need %d\n",
+			err, needed);
+		return -ENOSPC;
+	}
+	return 0;
+}
+
+static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	/*
+	 * pcim_enable_device() is used in nbl_probe().
+	 * pci_alloc_irq_vectors() registers pcim_msi_release devres callback,
+	 * which invokes pci_free_irq_vectors() automatically on device detach.
+	 * Do NOT call pci_free_irq_vectors() explicitly here to avoid
+	 * double-free.
+	 */
+}
+
 /* ----------  Channel config  ---------- */
 static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
@@ -85,6 +296,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
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
@@ -257,3 +476,126 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
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
+	int cleanup_ret;
+	int ret;
+
+	ret = nbl_dev_cfg_msix_map(dev_mgt);
+	if (ret)
+		goto err_destroy_map;
+
+	/* Fetch VSI/ETH identity after cfg_msix_map */
+	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
+	if (ret) {
+		if (!common->has_ctrl && ret == -ETIMEDOUT)
+			ret = -EPROBE_DEFER;
+		goto err_destroy_map;
+	}
+	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
+				   &common->eth_id, &common->logic_eth_id);
+	if (ret) {
+		if (!common->has_ctrl && ret == -ETIMEDOUT)
+			ret = -EPROBE_DEFER;
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
+	 * Destroy device-side MSI-X map BEFORE releasing kernel-side
+	 * vectors. This masks all hardware vectors and clears the
+	 * pcompleter map entry, so no MSI-X message can fire after
+	 * vector release.
+	 *
+	 * For non-control PFs this is a polling-mode mailbox RPC
+	 * (IRQ_RDY already cleared by disable above, or never set).
+	 * If the RPC fails the device may remain armed.
+	 *
+	 * This is best-effort teardown: we still release kernel vectors
+	 * even if remote RPC fails. The hardware entry will be reclaimed
+	 * by firmware on chip reset.
+	 *
+	 * Note: pci_clear_master() runs in nbl_probe() core_start_err path,
+	 * Also pci_clear_master() on non-control PF
+	 * cannot stop DMA using the manager PF's BDF; this is a known
+	 * limitation. Stale hardware entries will be reclaimed by firmware
+	 * on chip reset.
+	 */
+	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"rollback: destroy MSI-X map failed: %d\n",
+			cleanup_ret);
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
+	 * Destroy hardware MSI-X map BEFORE releasing kernel-side
+	 * vectors. Masks all device vectors and clears pcompleter
+	 * map entry first.
+	 *
+	 * This is best-effort teardown: if destroy_msix_map RPC fails,
+	 * hardware MSI-X map remains valid. We proceed to release
+	 * kernel vectors anyway. Hardware stale entries rely on
+	 * firmware cleanup on chip reset.
+	 *
+	 * pci_clear_master() on non-control PF cannot stop DMA using manager
+	 * PF's BDF.
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
index d362f1270d83..170a4d13494b 100644
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
@@ -181,7 +191,13 @@ static int nbl_probe(struct pci_dev *pdev,
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
@@ -196,6 +212,8 @@ static void nbl_remove(struct pci_dev *pdev)
 		return;
 
 	pci_set_drvdata(pdev, NULL);
+
+	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 
 	pci_clear_master(pdev);
-- 
2.47.3

