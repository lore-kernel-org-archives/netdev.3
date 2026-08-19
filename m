Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982E1B78F3;
	Wed, 19 Aug 2026 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098362; cv=none; b=h+VJIe5Lgf/X8dX1tVPUqefJ1+31JuuPLFcSWkSr15AJxIz5r+Ff4aMO2VQlCiuQyKcFCBhg+hE1zHOY+7I9Mc5BbUlMovWrE7wvF5X5FGKQ3MgJWBvceiiLEApyQRiOBJFeA8tOt6cUhldQ0kNqvu0nAiQ9n+1nsIT5SsUU1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098362; c=relaxed/simple;
	bh=FtB1aTEvUOg9KdSIUoWspr+mi2L3qzS57JejKb4HHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blBcZzbYpATkAxp04TiVXfaPkSVhEkP0bOPuyljgH1GkhDDhKXNqNHNBn13qPHY0FqRzbigtVlsFdODsIv6PxUKLDdKZW8d9wOAYbPNFl0h8zs+VV5iHmX6UO34K/bOU7jPrn2Ya12YdaBh8ttZZZRljwn2CBzutFeORr8S/Xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00789118-0.00105738-0.991051;FP=18038038118046123770|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iqi7ni1_1787098339;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iqi7ni1_1787098339 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 08:12:20 +0800
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
Subject: [PATCH v25 net-next 10/10] net/nebula-matrix: add common dev start/stop operation
Date: Wed, 19 Aug 2026 08:11:12 +0800
Message-ID: <20260819001117.46785-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
References: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
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
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 267 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  18 ++
 4 files changed, 289 insertions(+)

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
index 4fc52cadf60f..b81b0b4c41a6 100644
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
@@ -14,6 +25,189 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
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
+				  NBL_CHAN_IRQ_RDY,
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
+					    local_vec_id, false);
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
+	err = disp_ops->cfg_msix_map(dev_mgt->disp_ops_tbl->priv,
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
@@ -73,6 +267,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
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
@@ -234,3 +436,68 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
 		nbl_dev_remove_ctrl_dev(adapter);
 	nbl_dev_remove_common_dev(adapter);
 }
+
+/* ----------  Dev start process  ---------- */
+int nbl_dev_start(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int cleanup_ret;
+	int ret;
+
+	ret = nbl_dev_cfg_msix_map(dev_mgt);
+	if (ret)
+		goto cfg_msix_map_err;
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
+
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
+cfg_msix_map_err:
+	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
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
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", ret);
+	/*
+	 * destroy_msix_map() sends ack-requested messages which may requeue
+	 * clean_mbx_task via polling send path. Drain work after the operation.
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
index 9896c1b49be2..02cb35d32012 100644
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
@@ -127,7 +137,13 @@ static int nbl_probe(struct pci_dev *pdev,
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
 	pci_clear_master(pdev);
 	return err;
@@ -140,6 +156,8 @@ static void nbl_remove(struct pci_dev *pdev)
 	if (!adapter)
 		return;
 	pci_set_drvdata(pdev, NULL);
+
+	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 
 	pci_clear_master(pdev);
-- 
2.47.3

