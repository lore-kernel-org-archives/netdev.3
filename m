Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633C43B4B3;
	Sat, 10 Oct 2026 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626415; cv=none; b=HcW9ZgY0JTEcQpCCNf4NUAMHoxkqFrBi6HxWDOw60gPnx0br/AyAHRcZnGe+AClA73X0iPQaS9cVtrDXS7TwF66R/y+4uUtfaCz3Nc/ZignnAzXYc84iD+3/keX+VUg8+EI7C8WQRtVYaEtY4b9YFOBQPJPNxS1JCHhrw69NQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626415; c=relaxed/simple;
	bh=g+//nxbRTLsviSXVZqwTxtaaJHm+6R0KWHePTBz9YME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TavjLlggoqN5F9sGqU9hZfUghXb/DZcwJrbUIgzuLmf0aiyUvZ7j7/YrHua3qaPVeWjyRB1/x7b6nTlfIsScQg4oQkUL6KaYEErN0cqTHWwMgts00bl/I4m5LYrMeGNLp9Hk2vv+hg06JBCnz+oLiZhhlQ2q3U/+VHbJBbWJnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00582233-0.000620875-0.993557;FP=15589206525042314994|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jYOxjsF_1791626390;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jYOxjsF_1791626390 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 17:59:51 +0800
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
Subject: [PATCH v31 net-next 8/8] net/nebula-matrix: add common dev start/stop operation
Date: Sat, 10 Oct 2026 17:59:31 +0800
Message-ID: <20261010095939.2230-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010095939.2230-1-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add nbl_dev_start() and nbl_dev_stop(), called from nbl_probe() and
nbl_remove() via nbl_core_start() / nbl_core_stop().

Start configures the device MSI-X map, fetches the VSI/ETH ids, allocates
the MSI-X vectors and arms the mailbox interrupt; stop performs the
matching teardown.

The start/stop pair is single-shot and non-repeatable, tied strictly to
the PCI probe/remove lifecycle: kernel vectors are released only by the
pcim_msi_release devres at detach, so a second start is rejected.

Startup RPC errors are propagated unchanged.  A -ETIMEDOUT here is a real
failure, not a "supplier not ready yet" condition: nbl_probe() already
deferred this PF in nbl_probe_chip_deps() until the control PF completed
probing, and that completion includes the control PF's own start, whose
mailbox responder has been live since nbl_dev_init().  Converting the
timeout to -EPROBE_DEFER would only hide it behind dev_dbg() and make
every later bind pay the multi-second wait again.

Teardown is best-effort.  The MSI-X map is torn down even when the
configure RPC failed: a timeout only means the ACK never arrived, while
the responder runs to completion before ACKing, so the entry, the
intr_net/other_bmap bits and the coherent map table stay owned by the
control PF.  Those are host resources of that driver, freed by a later
successful configuration of this function or by nbl_intr_mgt_stop() - not
firmware state.  pci_clear_master() is not a safety net for this: on a
non-control PF it cannot stop DMA issued with the management PF's BDF.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   8 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 391 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  18 +
 4 files changed, 419 insertions(+)

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
index 390bc2b177e2..41754fd06ea3 100644
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
@@ -18,6 +29,230 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
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
+	 * Disable sequence invariant: clear the software READY flag first,
+	 * then mask the hardware interrupt. Must not reverse the order.
+	 *
+	 * Clearing NBL_CHAN_IRQ_RDY is what makes an interrupt-mode sender
+	 * fail fast: nbl_chan_set_queue_state() wakes every per-slot wait
+	 * queue on the transition, and nbl_chan_send_msg() tests the flag
+	 * ahead of its timeout branch, so the sender returns -EIO right
+	 * away instead of waiting out NBL_CHAN_ACK_WAIT_TIME (3s) and
+	 * reporting a bogus -ETIMEDOUT / "Channel waiting ack failed".
+	 * Masking first would leave the sleeper blocked on an interrupt
+	 * that is already masked, i.e. guaranteed to time out.
+	 *
+	 * This does NOT preserve in-flight ACKs, and must not be described
+	 * as doing so: the woken sender gives up and resets its slot to
+	 * IDLE, so an ACK arriving afterwards finds a non-WAITING slot and
+	 * is dropped by the receive path ("Skip ack invalid status").
+	 * Interrupt mode is being torn down here; the guarantee is a
+	 * bounded, deterministic failure, not delivery.  In this driver
+	 * every ACK-requesting sender runs from probe/remove and the clean
+	 * task only sends ACK-less replies, so nothing depends on the
+	 * stronger claim today.
+	 *
+	 * This helper is invoked in two paths:
+	 * 1. Error unwind path of nbl_dev_start(): not reached with
+	 * IRQ_RDY set (nbl_dev_enable_mailbox_irq() sets it only after
+	 * its RPC succeeded), so only the hardware mask still applies,
+	 * followed by nbl_dev_free_mailbox_irq() and full channel
+	 * teardown.
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
@@ -85,6 +320,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
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
@@ -274,3 +517,151 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
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
+	/*
+	 * Startup RPC failures are reported as they are, including the
+	 * -ETIMEDOUT of a 5-6s polling wait against an unresponsive peer.
+	 * nbl_probe() already deferred this PF until the control PF had
+	 * completed probing (nbl_probe_chip_deps()), and that completion
+	 * includes the control PF's own nbl_core_start(); its mailbox
+	 * responder has been live since nbl_dev_init().  A timeout here
+	 * is therefore a real failure, not a "supplier not ready yet"
+	 * condition.  Turning it into -EPROBE_DEFER would hide it behind
+	 * dev_dbg() and leave the retry to the next unrelated device
+	 * bind, paying the multi-second timeout again on every retry.
+	 */
+	ret = nbl_dev_cfg_msix_map(dev_mgt);
+	if (ret)
+		goto err_destroy_map;
+
+	/* Fetch VSI/ETH identity after cfg_msix_map */
+	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
+	if (ret)
+		goto err_destroy_map;
+	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
+				   &common->eth_id, &common->logic_eth_id);
+	if (ret)
+		goto err_destroy_map;
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
+		goto err_free_irq;
+
+	return 0;
+
+err_free_irq:
+	/*
+	 * nbl_dev_enable_mailbox_irq() only fails before it sets
+	 * NBL_CHAN_IRQ_RDY - the flag is set after its RPC returns - so
+	 * there is no interrupt-mode sender to release and no software
+	 * state to revoke.  The peer-side mailbox routing, if the failed
+	 * RPC did land, is switched off by the destroy_msix_map() below,
+	 * whose prepare phase disables mailbox IRQ routing first.  Sending
+	 * set_mailbox_irq(false) from here would only add one more full
+	 * polling-mode ACK timeout against a peer that just proved
+	 * unresponsive.
+	 */
+	nbl_dev_free_mailbox_irq(dev_mgt);
+err_destroy_map:
+	/*
+	 * Always ask the peer to drop this function's MSI-X map, even when
+	 * the cfg RPC above failed: the teardown prepare phase returns 0
+	 * for a function that is not NBL_INTR_FUNC_CONFIGURED, so it is a
+	 * no-op when nothing landed, but a -ETIMEDOUT only means the ACK
+	 * never arrived - the responder runs to completion before it ACKs.
+	 * In that case the map entry, the intr_net/other_bmap bits, the
+	 * kcalloc()ed vector array and the coherent map table are all
+	 * still owned by the control PF, i.e. host resources of its
+	 * driver, released only when this function is configured again or
+	 * when nbl_intr_mgt_stop() tears the control PF down.  They are not
+	 * firmware state, so skipping the destroy would strand them for a
+	 * PF that has no driver to ever ask for them again.
+	 *
+	 * The destroy runs before detach even though kernel vectors stay
+	 * allocated until then (see nbl_dev_clear_interrupt_scheme): it
+	 * masks all hardware vectors and clears the pcompleter map entry,
+	 * so no MSI-X message can be delivered after vectors are released
+	 * at detach.
+	 *
+	 * For non-control PFs this is a polling-mode mailbox RPC:
+	 * NBL_CHAN_IRQ_RDY is never set on any rollback path, since
+	 * enabling it is the last step of nbl_dev_start().
+	 *
+	 * Note: pci_clear_master() runs in nbl_probe() core_start_err path;
+	 * on a non-control PF it cannot stop DMA using the management PF's
+	 * BDF, this is a known limitation.
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
+	 * Destroy the hardware MSI-X map now, before the kernel vectors
+	 * are released at device detach (they deliberately stay
+	 * allocated until then - see nbl_dev_clear_interrupt_scheme).
+	 * Masks all device vectors and clears the pcompleter map entry.
+	 *
+	 * Best-effort: if the destroy RPC fails, the control PF still owns
+	 * this function's map entry, its intr_net/other_bmap bits and its
+	 * coherent map table.  Those are host resources of that driver,
+	 * released either by a later successful configuration of this
+	 * function (reconfiguration recycles them) or by
+	 * nbl_intr_mgt_stop() when the control PF is removed; nothing else
+	 * collects them, so the hardware entry stays as it is until chip
+	 * reset - and nothing requests one.
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
index 6aacfadd8c0e..cacf4b680aad 100644
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
@@ -234,7 +244,13 @@ static int nbl_probe(struct pci_dev *pdev,
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
@@ -248,6 +264,8 @@ static void nbl_remove(struct pci_dev *pdev)
 	if (!adapter)
 		return;
 	pci_set_drvdata(pdev, NULL);
+
+	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 
 	pci_clear_master(pdev);
-- 
2.47.3

