Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476988;
	b=oGh6cRFc5vrdMMN+WFkjWRCw+SimAbB/vxQX+0BMzFRoUsp3Q1DM9bEv3IqILaa2qI74
	 dqaWfwdp/sI/x/KSHIlwuMiMIqhs8+Fw+mDt5xeRxLcum3cQ2S9J5Svggq06TyblzNn+i
	 mZ1v0lFABPVODtweI0MsBicOJOa2/SJi1xmUZr8TkQdcR716vYB0ydfIc7UsRNk36nvNU
	 BK75nTpcKwti+JXFcXk344Q1EZRaYbZrMsakXdUXa6v6p3xM59waZubQbvGRNlHOVnUeD
	 QB63pqAAp5VzzersJpLK82RoPoK28+G3YJS2zaxHiZFUJ1DGRbpXfq0RI2oWqwcUwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476988;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XUO+8ntepGOjwiMBKktc6LruprBH5/xMZRTtBIHfe8A=;
	b=zoMVD45Cbhi00XOfoDxMFQGSevmY++88PcGZ+qin3JoqaMt7LOUwsDioISrKt/KOmGxj
	 2CqssmlRePnL/rkEyPPLFLMFoLDTHpRCmiQG4XRL33qeUUDUC4PcZVsz+cHbpaklxz2cV
	 iXNmGCEPPGDB84qjhz5KtDeLOM998xEfvOak0zifr4dXy7JLb/VuqpZL6eur8J3kfDP9R
	 xqKEao9pqbP/Hfm83D8c6nsO+gblXWqUranQ4Xon3ZtEXbbDnRKCxs6H46xUZ+h3EXd7d
	 oqjdIZ6IwRGOavcJ7IwdWzleMRmFZRZ85x5IcEq5NjBbxyNltHr/NP6/pEQmMyoEevg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68060A2621;
	Thu, 12 Nov 2026 09:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB68060A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0174135-0.00159134-0.980995;FP=15093810564941315779|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.k0PDB2W_1794476975;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.k0PDB2W_1794476975 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 17:49:36 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v34 net-next 8/8] net/nebula-matrix: add common dev start/stop operation
Date: Thu, 12 Nov 2026 17:49:20 +0800
Message-ID: <20261112094925.6098-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112094925.6098-1-illusion.wang@nebula-matrix.com>
References: <20261112094925.6098-1-illusion.wang@nebula-matrix.com>
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

From: illusion wang <illusion.wang@nebula-matrix.com>

Add nbl_dev_start() and nbl_dev_stop(), called from nbl_probe() and
nbl_remove() via nbl_core_start() / nbl_core_stop().

Start configures the device MSI-X map, fetches the VSI/ETH ids, allocates
the MSI-X vectors and arms the mailbox interrupt; stop performs the
matching teardown.

nbl_probe() now rejects a function with neither the ctrl nor the net
capability with -EOPNOTSUPP, before any hardware is touched.  Such a
function would reach nbl_dev_start() with every dispatch op left NULL by
nbl_disp_refresh_ctrl_ops().  The state is only reachable through
driver_override: binding this driver to a function that is absent from
nbl_id_table makes pci_match_device() pass the dummy ID whose driver_data
0 leaves both capabilities clear.  That means a VF, or a foreign device
at a function other than 0 - a PF of this device always matches
nbl_id_table, and new_id rejects a driver_data the table does not
contain.  A foreign non-VF device at function 0 is unaffected:
nbl_get_func_param() gives it has_ctrl, so it is not rejected here and
still runs nbl_core_init() and nbl_core_start() with the local control
dispatch ops.  nbl_dev_init()'s unwind labels change with it:
setup_ctrl_dev_fail becomes out_remove_common_dev, and the setup_err path
drops its label and returns directly, since a failed
nbl_dev_setup_common_dev() has nothing to unwind.

Startup RPC errors are propagated unchanged.  A -ETIMEDOUT here is a real
failure, not a "supplier not ready yet" condition: nbl_probe() already
deferred this PF in nbl_probe_chip_deps() until the control PF reached
DL_DEV_DRIVER_BOUND, and the driver core only marks a device bound once
its entire probe - including the control PF's own nbl_core_start() - has
returned.  That state is what bounds the wait, not nbl_dev_init(): on
the control PF inbound mailbox work only runs from clean_mbx_task, which
is queued by the mailbox hardirq, by the task's own self-requeue, or by
this function's polling sends, and the control PF uses the local dispatch
ops so it sends none.  The responder is armed by set_mailbox_irq(true)
at the end of the peer's nbl_dev_start().  Relaxing the dependency to
"func 0 finished nbl_dev_init()" would therefore let every sibling RPC
sit out the full 5-6s polling wait.  Converting the timeout to
-EPROBE_DEFER would only hide it behind dev_dbg() and make every later
bind pay that wait again.

Teardown releases the kernel MSI-X vectors before destroying the hardware
pcompleter map.  pci_free_irq_vectors() ends in pci_msix_shutdown(),
which masks every descriptor by writing the MSI-X table and reading it
back to flush the write; those accesses should reach the function while
FUNCTION_MSIX_MAP is still valid.  This mirrors start, where cfg_msix_map
runs before pci_alloc_irq_vectors_affinity().  It is not a double free of
the pcim_msi_release devres registered alongside
pci_alloc_irq_vectors(): that action only calls pci_free_irq_vectors()
again, and pci_disable_msix() returns early once msix_enabled is clear.
Start and stop still each run once, tied to probe and remove.

The rest of teardown is best-effort.  The MSI-X map is torn down even
when the configure RPC failed: a timeout only means the ACK never
arrived, while the responder runs to completion before ACKing, so the
entry, the intr_net/other_bmap bits and the kcalloc()ed vector array stay
owned by the control PF.  Those are host resources of that driver, not
firmware state, and neither recovery path needs a chip reset: a later
successful configuration of this function releases the old bits, frees
the old array, invalidates and rewrites the entry on its had_config path,
and nbl_intr_mgt_stop() clears the FUNCTION_MSIX_MAP valid bit for every
still-configured function when the control PF is removed.  The coherent
map table is different: neither per-function path frees it, it is kept
for the function's lifetime and reused in place, and nbl_intr_mgt_stop()
is the only place it is released.

That is also what keeps the stop ordering safe.  nbl_remove() calls
nbl_core_stop() before pci_clear_master(), so the control PF destroys
its own map entry while its Bus Master Enable is still set.  That is
deliberate: nbl_core_stop() cannot run after pci_clear_master(), because
on a non-control PF it is a mailbox RPC, which needs bus mastering for
the ring DMA.  The destroy only clears the VALID bit and keeps the
coherent table, so the actual free still happens later, in
nbl_intr_mgt_stop(), after pci_clear_master().  nbl_probe()'s
start-failure unwind uses the same order.  pci_clear_master() remains no
safety net for a non-control PF: it cannot stop DMA issued with the
management PF's BDF.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  11 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 446 +++++++++++++++++-
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  49 +-
 4 files changed, 502 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index c3c4dd685..051574810 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -40,4 +40,15 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
 
+/*
+ * Single-shot start/stop pair, called once each from PCI probe/remove.
+ * Not repeatable, but not because the MSI-X core would refuse a second
+ * start: nbl_dev_stop() releases the vectors with pci_free_irq_vectors().
+ * What the pair brackets is the device's active lifetime, and
+ * nbl_core_stop() is only ever followed by nbl_core_remove(), which
+ * destroys the mailbox channel and the resource state that start needs.
+ */
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 0cc0c58ad..e91ec22e3 100644
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
@@ -19,6 +30,243 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
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
+	 * The only caller is nbl_dev_stop(): free_irq() blocks until
+	 * any in-flight hardirq handler completes and prevents new interrupts.
+	 * cancel_work_sync() then waits for any already running mailbox cleanup
+	 * work to finish, or cancels queued but unstarted work items before
+	 * final channel destruction. No stuck descriptors linger.
+	 *
+	 * nbl_dev_start()'s unwind path does not reach here: err_free_irq runs
+	 * before IRQ_RDY is set, so only nbl_dev_free_mailbox_irq() applies
+	 * there and no set_mailbox_irq(false) is sent - see the comment on
+	 * that label.
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
+ * Release the kernel-side MSI-X vectors here, before the hardware
+ * pcompleter map is destroyed.  pci_free_irq_vectors() ends in
+ * pci_msix_shutdown(), which masks every descriptor by writing the
+ * vector control word in the MSI-X table and then reads mask_base
+ * back to flush that write; those MMIO accesses should reach the
+ * function while FUNCTION_MSIX_MAP is still valid.  This mirrors
+ * nbl_dev_start(), where cfg_msix_map runs before
+ * pci_alloc_irq_vectors_affinity(): the opposite order leaves the
+ * core poking the MSI-X table after destroy_msix_map() has cleared
+ * the valid bit and invalidated the info entries, and how the device
+ * reacts to that is hardware-specific.
+ *
+ * This is not a double free of the devres action.  probe uses
+ * pcim_enable_device(), so pci_alloc_irq_vectors() also registers
+ * pcim_msi_release, but that only calls pci_free_irq_vectors()
+ * again, and pci_disable_msix() returns early once msix_enabled is
+ * clear.
+ *
+ * The handler is expected to be gone by now: both callers run
+ * nbl_dev_free_mailbox_irq() first.
+ */
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
@@ -86,6 +334,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
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
@@ -254,15 +510,16 @@ int nbl_dev_init(struct nbl_adapter *adapter)
 	 */
 	ret = nbl_dev_setup_common_dev(adapter);
 	if (ret)
-		goto setup_err;
+		return ret;
 
 	if (common->has_ctrl) {
 		ret = nbl_dev_setup_ctrl_dev(adapter);
 		if (ret)
-			goto setup_ctrl_dev_fail;
+			goto out_remove_common_dev;
 	}
 
 	return 0;
+
 /*
  * A failure after the QINFO routing was programmed leaves those entries
  * in hardware: driver_status never goes 1 -> 0 on these paths, so
@@ -271,9 +528,8 @@ int nbl_dev_init(struct nbl_adapter *adapter)
  * bind until this probe succeeds.  The next successful probe overwrites
  * the entries, and a chip reset clears them.
  */
-setup_ctrl_dev_fail:
+out_remove_common_dev:
 	nbl_dev_remove_common_dev(adapter);
-setup_err:
 	return ret;
 }
 
@@ -303,3 +559,185 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
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
+	 * nbl_probe() already deferred this PF in nbl_probe_chip_deps()
+	 * until the control PF reached DL_DEV_DRIVER_BOUND, and the core
+	 * only marks a device bound once its whole probe - including the
+	 * control PF's own nbl_core_start() - has returned.  That state,
+	 * not nbl_dev_init(), is what makes a timeout here a real failure
+	 * instead of a "supplier not ready yet" condition: on the control
+	 * PF inbound mailbox work only runs from clean_mbx_task, queued
+	 * by the mailbox hardirq, by the task's own self-requeue, or by
+	 * this function's polling sends - and the control PF uses the
+	 * local dispatch ops, so it sends none.  The responder is armed
+	 * by set_mailbox_irq(true) at the very end of the peer's
+	 * nbl_dev_start(); relaxing the dependency to "func 0 finished
+	 * nbl_dev_init()" would let every sibling RPC sit out the full
+	 * 5-6s polling wait.  Turning -ETIMEDOUT into -EPROBE_DEFER would
+	 * hide it behind dev_dbg() and leave the retry to the next
+	 * unrelated device bind, paying that wait again on every retry.
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
+	 * RPC did land, is switched off by the destroy_msix_map() below: its
+	 * prepare phase, __nbl_res_intr_prepare_destroy_msix_map(), disables
+	 * mailbox IRQ routing for any CONFIGURED function before the map is
+	 * torn down.  That is what makes skipping set_mailbox_irq(false)
+	 * correct here, whatever way the enable failed - a local
+	 * -ESHUTDOWN/-ENODEV/-EINVAL on the control PF as much as a
+	 * polling-mode -ETIMEDOUT against an unresponsive peer.
+	 */
+	nbl_dev_free_mailbox_irq(dev_mgt);
+err_destroy_map:
+	/*
+	 * Always ask the peer to drop this function's MSI-X map, even when
+	 * the cfg RPC above failed: the teardown prepare phase returns 0
+	 * for a function that is not NBL_INTR_FUNC_CONFIGURED, so it is a
+	 * no-op when nothing landed, but a -ETIMEDOUT only means the ACK
+	 * never arrived - the responder runs to completion before it ACKs.
+	 * In that case the map entry, the intr_net/other_bmap bits and the
+	 * kcalloc()ed vector array are all still owned by the control PF,
+	 * i.e. host resources of its driver.  They are not firmware state,
+	 * so skipping the destroy would strand them for a PF that has no
+	 * driver to ever ask for them again.  A later successful
+	 * configuration of this function collects them on its had_config
+	 * path: it releases the old bitmap bits, kfree()s the old vector
+	 * array, invalidates and rewrites the entry.  The coherent map
+	 * table is different - it is never freed there, because it is kept
+	 * for the function's lifetime and reused in place, and
+	 * nbl_intr_mgt_stop() is what finally releases it.
+	 *
+	 * Kernel vectors are released first, by the
+	 * nbl_dev_clear_interrupt_scheme() below: the PCI core's MSI-X
+	 * shutdown writes the MSI-X table and reads it back, and those
+	 * accesses should land while this function's pcompleter map entry
+	 * is still valid.  The destroy then masks all hardware vectors
+	 * and clears that entry.
+	 *
+	 * For non-control PFs this is a polling-mode mailbox RPC:
+	 * NBL_CHAN_IRQ_RDY is never set on any rollback path, since
+	 * enabling it is the last step of nbl_dev_start().
+	 *
+	 * pci_clear_master() has not run at this point: nbl_probe() clears
+	 * it after this rollback returns, before nbl_core_remove() runs.
+	 * This rollback does not need it - the coherent table is kept, not
+	 * freed here (see __nbl_res_intr_complete_destroy_msix_map()) - and
+	 * on a non-control PF it could not stop DMA issued with the
+	 * management PF's BDF in any case.
+	 */
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"rollback: destroy MSI-X map failed: %d\n",
+			cleanup_ret);
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
+	 * Release the kernel vectors before destroying the hardware map:
+	 * the PCI core's MSI-X shutdown writes the MSI-X table and reads
+	 * it back, and those accesses should land while this function's
+	 * pcompleter map entry is still valid (see
+	 * nbl_dev_clear_interrupt_scheme).
+	 */
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+
+	/*
+	 * Destroy the hardware MSI-X map: masks all device vectors and
+	 * clears the pcompleter map entry.
+	 *
+	 * Best-effort: if the destroy RPC fails, the control PF still owns
+	 * this function's map entry, its intr_net/other_bmap bits and its
+	 * kcalloc()ed vector array.  Those are host resources of that
+	 * driver, released either by a later successful configuration of
+	 * this function - nbl_res_intr_cfg_msix_map() invalidates and
+	 * rewrites the entry, releases the old bits and frees the old array
+	 * on its had_config path - or by nbl_intr_mgt_stop() when the
+	 * control PF is removed, which walks every
+	 * NBL_INTR_FUNC_CONFIGURED function through
+	 * __nbl_res_intr_prepare_destroy_msix_map() and clears the
+	 * FUNCTION_MSIX_MAP valid bit.  The coherent map table is neither
+	 * freed nor reallocated by reconfiguration: it is kept for the
+	 * function's lifetime and released only by nbl_intr_mgt_stop().
+	 * Both rewrite the hardware entry without a chip reset; nothing else
+	 * collects it, so a stranded one just stays as it is, and nothing
+	 * requests one.
+	 *
+	 * pci_clear_master() on a non-control PF cannot stop DMA using the
+	 * management PF's BDF.  It has not run yet on the control PF either,
+	 * since nbl_remove() clears it after this function returns; what
+	 * makes the only free - the one in nbl_intr_mgt_stop() - safe is
+	 * that it runs after that point, with bus mastering off.
+	 */
+	ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", ret);
+
+	/*
+	 * destroy_msix_map() sends ack-requested messages which may
+	 * requeue clean_mbx_task via polling send path.  Drain work
+	 * after the operation.
+	 */
+	cancel_work_sync(&common_dev->clean_mbx_task);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index 51cf04e4c..a66c633a0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -10,5 +10,7 @@ struct nbl_adapter;
 
 int nbl_dev_init(struct nbl_adapter *adapter);
 void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter);
+void nbl_dev_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index dd81720df..93c8d3d86 100644
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
@@ -242,6 +252,27 @@ static int nbl_probe(struct pci_dev *pdev,
 	int err;
 
 	nbl_get_func_param(pdev, id->driver_data, &param);
+	/*
+	 * Reject a function with neither capability before touching any
+	 * hardware.  nbl_disp_refresh_ctrl_ops() leaves every dispatch op NULL
+	 * for such a function, while nbl_dev_start() reaches cfg_msix_map,
+	 * get_vsi_id, get_eth_id and (on unwind) destroy_msix_map through
+	 * those pointers.  The state is reachable through driver_override:
+	 * binding this driver to a function that is absent from nbl_id_table
+	 * makes pci_match_device() pass the dummy ID whose driver_data 0
+	 * leaves has_ctrl and has_net both clear.  That means a VF, or a
+	 * foreign device at a function other than 0: a PF of this device
+	 * always matches nbl_id_table, and new_id rejects a driver_data the
+	 * table does not contain.  A foreign non-VF device at function 0 is
+	 * unaffected: nbl_get_func_param() gives it has_ctrl, so it is not
+	 * rejected here and still runs nbl_core_init() and nbl_core_start()
+	 * with the local control dispatch ops.
+	 */
+	if (!param.caps.has_ctrl && !param.caps.has_net) {
+		dev_err(dev, "Function has neither ctrl nor net capability\n");
+		return -EOPNOTSUPP;
+	}
+
 	err = pcim_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
@@ -279,8 +310,16 @@ static int nbl_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
-
-	return 0;
+	err = nbl_core_start(adapter);
+	if (err) {
+		/*
+		 * Same order as nbl_remove(): stop bus mastering before the
+		 * teardown that frees the MSI-X map tables.
+		 */
+		pci_clear_master(pdev);
+		nbl_core_remove(adapter);
+	}
+	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
@@ -291,6 +330,7 @@ static void nbl_remove(struct pci_dev *pdev)
 		return;
 	pci_set_drvdata(pdev, NULL);
 
+	nbl_core_stop(adapter);
 	/*
 	 * Stop bus mastering before the teardown in nbl_core_remove()
 	 * releases the map tables.
@@ -303,6 +343,11 @@ static void nbl_remove(struct pci_dev *pdev)
 	 * nbl_intr_quiesce_wait()).  Clearing Bus Master Enable first
 	 * keeps the device from starting a new fetch at all, so that
 	 * residual window only covers requests already in flight.
+	 *
+	 * nbl_core_stop() above has already torn down this function's own
+	 * map, so what is left to protect here is the control PF's table of
+	 * per-function entries, freed from nbl_intr_mgt_stop() inside
+	 * nbl_core_remove().
 	 */
 	pci_clear_master(pdev);
 
-- 
2.51.0.windows.1

