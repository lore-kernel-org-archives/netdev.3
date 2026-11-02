Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606082;
	b=j8+ETCFYC++4puOPnhP4Go1gYeuUfjnu9PF84Bt2I5dxg8dIa+Da1AhRX+WMCPMQ8lo8
	 7DPa0nxk8CbLXlLsDWaIuaupUOXv2mgzD79RvszgEVc2pKVPXzsSB0W80fguqtUl+CMFQ
	 YA5A37HquyOD+EzgxrGhc+/f20rLdy2dmXEVRtsjX0W7fNqUkoK8BhDSPAIw4WKLf/S1k
	 RgGm23nbf8ISxu9hgJQxA9NzmcBS7r1UPqRUZiqBxiispzKiNCM6bRh2F/fB5OA0qImoM
	 8LQ6an0ixrhn9OxK63EoCEEyV5Sxw1Lib6ijVXV3lSQl7Mq2eQ9FfuqpOmUhtLgf3Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606082;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gP4FFmF3JwXyz59JzbOD3CHD4XvzwRqk5xVgFd9wP90=;
	b=vjAAzOy0DSJdNSxcninL1ZU3UMdfvbBoNUu+tzqgxWLL3bQaes9WwGQfo+KU6mPTW3M9
	 n1v6szTxKxdAMhNd2xZ1jV8hIUeykdIsGK5oWdeRFmeIqrVrjZGSysZXhG2BjRPa7SouT
	 9JUGYNy1wvF4/zh+LAaGimkwrIbc1jtvQ923xf6r7J4hXIxo3D33V8LCXeCpNNhiSP3/i
	 ky4p6MiPKZAI9EVL7y+xLgadOzIe1VbRBF1O+3U3MHcn7ufmX57BRhwV/c8fjgMiOm7Yc
	 uObX/7mogSLW4JMjbtEB50mO9K+IKC8VhNNxRjh0Q58oJgH5z+6LoNJNeNz6hcXnJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.195
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C2606A329;
	Mon,  2 Nov 2026 07:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44C2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.006603-0.00306487-0.990332;FP=15024004753536933618|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033065158064;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jumCpbW_1793606074;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jumCpbW_1793606074 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 15:54:35 +0800
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
Subject: [PATCH v33 net-next 8/8] net/nebula-matrix: add common dev start/stop operation
Date: Mon,  2 Nov 2026 15:54:09 +0800
Message-ID: <20261102075424.2165-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
References: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
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
nbl_id_table (a VF, or a non-func-0 PF of this device) makes
pci_match_device() pass the dummy ID whose driver_data 0 leaves both
capabilities clear.  A foreign device at func 0 is unaffected -
nbl_get_func_param() gives any func 0 device has_ctrl, so it is not
rejected here and still runs nbl_core_init() with the local control
dispatch ops, as it did before this check existed.  nbl_dev_init()'s
unwind labels change with it: setup_ctrl_dev_fail becomes
out_remove_common_dev, and the setup_err path drops its label and
returns directly, since a failed nbl_dev_setup_common_dev() has nothing
to unwind.

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
entry, the intr_net/other_bmap bits and the coherent map table stay owned
by the control PF.  Those are host resources of that driver, not firmware
state, and neither recovery path needs a chip reset: a later successful
configuration of this function invalidates and rewrites the entry on its
had_config path, and nbl_intr_mgt_stop() clears the FUNCTION_MSIX_MAP
valid bit for every still-configured function when the control PF is
removed.  pci_clear_master() is not a safety net for this: on a
non-control PF it cannot stop DMA issued with the management PF's BDF.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   8 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 432 +++++++++++++++++-
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  37 +-
 4 files changed, 473 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index c3c4dd68..655dfb43 100644
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
index 01287c39..c25def18 100644
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
+ * the valid bit, invalidated the info entries and freed the map
+ * table, and how the device reacts to that is hardware-specific.
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
@@ -252,15 +508,16 @@ int nbl_dev_init(struct nbl_adapter *adapter)
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
@@ -269,9 +526,8 @@ int nbl_dev_init(struct nbl_adapter *adapter)
  * bind until this probe succeeds.  The next successful probe overwrites
  * the entries, and a chip reset clears them.
  */
-setup_ctrl_dev_fail:
+out_remove_common_dev:
 	nbl_dev_remove_common_dev(adapter);
-setup_err:
 	return ret;
 }
 
@@ -301,3 +557,171 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
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
+	 * In that case the map entry, the intr_net/other_bmap bits, the
+	 * kcalloc()ed vector array and the coherent map table are all
+	 * still owned by the control PF, i.e. host resources of its
+	 * driver, released only when this function is configured again or
+	 * when nbl_intr_mgt_stop() tears the control PF down.  They are not
+	 * firmware state, so skipping the destroy would strand them for a
+	 * PF that has no driver to ever ask for them again.
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
+	 * Note: pci_clear_master() runs in nbl_probe() core_start_err path;
+	 * on a non-control PF it cannot stop DMA using the management PF's
+	 * BDF, this is a known limitation.
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
+	 * coherent map table.  Those are host resources of that driver,
+	 * released either by a later successful configuration of this
+	 * function - nbl_res_intr_cfg_msix_map() invalidates and rewrites
+	 * the entry on its had_config path - or by nbl_intr_mgt_stop()
+	 * when the control PF is removed, which walks every
+	 * NBL_INTR_FUNC_CONFIGURED function through
+	 * __nbl_res_intr_prepare_destroy_msix_map() and clears the
+	 * FUNCTION_MSIX_MAP valid bit.  Both rewrite the hardware entry
+	 * without a chip reset; nothing else collects it, so a stranded
+	 * one just stays as it is, and nothing requests one.
+	 *
+	 * pci_clear_master() on a non-control PF cannot stop DMA using the
+	 * management PF's BDF.
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
index 51cf04e4..a66c633a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -10,5 +10,7 @@ struct nbl_adapter;
 
 int nbl_dev_init(struct nbl_adapter *adapter);
 void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter);
+void nbl_dev_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index a3e599f5..0bdc7f99 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -25,6 +25,15 @@
 #define NBL_MGT_LOCK_RETRY_MIN_US	1000
 #define NBL_MGT_LOCK_RETRY_MAX_US	2000
 #define NBL_MGT_LOCK_MAX_RETRIES	50
+int nbl_core_start(struct nbl_adapter *adapter)
+{
+	return nbl_dev_start(adapter);
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	nbl_dev_stop(adapter);
+}
 
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param)
@@ -277,6 +286,25 @@ static int nbl_probe(struct pci_dev *pdev,
 	int err;
 
 	nbl_get_func_param(pdev, id->driver_data, &param);
+	/*
+	 * Reject a function with neither capability before touching any
+	 * hardware.  nbl_disp_refresh_ctrl_ops() leaves every dispatch op NULL
+	 * for such a function, while nbl_dev_start() reaches cfg_msix_map,
+	 * get_vsi_id, get_eth_id and (on unwind) destroy_msix_map through
+	 * those pointers.  The state is reachable through driver_override:
+	 * binding this driver to a function that is not in nbl_id_table (a VF,
+	 * or a non-func-0 PF) makes pci_match_device() pass the dummy ID whose
+	 * driver_data 0 leaves has_ctrl and has_net both clear.  A foreign
+	 * device at func 0 is unaffected: nbl_get_func_param() gives any
+	 * func 0 device has_ctrl, so it is not rejected here and still runs
+	 * nbl_core_init() with the local control dispatch ops, as it did
+	 * before this check existed.
+	 */
+	if (!param.caps.has_ctrl && !param.caps.has_net) {
+		dev_err(dev, "Function has neither ctrl nor net capability\n");
+		return -EOPNOTSUPP;
+	}
+
 	err = pcim_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
@@ -314,8 +342,12 @@ static int nbl_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
-
-	return 0;
+	err = nbl_core_start(adapter);
+	if (err) {
+		nbl_core_remove(adapter);
+		pci_clear_master(pdev);
+	}
+	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
@@ -326,6 +358,7 @@ static void nbl_remove(struct pci_dev *pdev)
 		return;
 	pci_set_drvdata(pdev, NULL);
 
+	nbl_core_stop(adapter);
 	/*
 	 * Stop bus mastering before any teardown runs.
 	 *
-- 
2.51.0.windows.1

