Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625243B6D4;
	Sat, 10 Oct 2026 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626397; cv=none; b=pDnJjlmh38olXt6oGMGALzcRBqkWjDjQALp5CYt9p0bAlJmwhOzc+d7eBUDZbDX/dMip7ur3roXnZFq4VZZaC+ZOlW6gN3isd0ocNOhEoZV5NE4iSlJ8a/GnTXOP9OmRcpM0HmwTOiNeUlOm/CzKYZUpnfs3D7VqOFHp6JkfZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626397; c=relaxed/simple;
	bh=6bIaasU/yVfAoYI8yt2xtMGl7VT7NwIMiuD7+UTTXgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp6xgqToyr7D0dQF+RdObFzRqHgZT0FXXWCcwNugQsMZIWUlnOWSlFKS4oFjYmIpb9Fag8YCY3aqUrmvXqakp0k5NfvKZgfJCJJ3gmwpe54pOnO4dJdw5eGcK8f5DY6jKG0jY/lFc2hI4gr8ohJrHPdaga1pihLlt7NPpXgnhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0113905-0.00586475-0.982745;FP=16884975893114015378|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jYOxjrd_1791626390;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jYOxjrd_1791626390 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 17:59:50 +0800
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
Subject: [PATCH v31 net-next 7/8] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Sat, 10 Oct 2026 17:59:30 +0800
Message-ID: <20261010095939.2230-8-illusion.wang@nebula-matrix.com>
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

Add nbl_dev.c, nbl_dev.h and nbl_def_dev.h to host device-level
initialization and teardown logic, and wire the new nbl_dev_init() /
nbl_dev_remove() entry points into core init/remove.

Common device setup allocates per-device state, initializes the mailbox
cleanup work and creates the mailbox channel queue.  VSI/ETH identity
lookup and MSI-X vector allocation are deferred to the subsequent start
routine, so that the control PF mailbox responder is fully ready before
any cross-PF RPC is issued and each commit in the series can be probed
on its own.

Control-PF-only setup invokes chip-level module initialization and
programs the mailbox QINFO routing table entries that map PF bus/devid
to the mailbox queue.

Init/teardown ordering is dictated by a hardware constraint rather than
by strict symmetry.  Init: program mailbox QINFO (control PF only),
create the mailbox queue, then run control device init_module.  Teardown:
stop the mailbox channel and drain all in-flight DMA first, then call
deinit_module().  This ordering prevents the firmware from reclaiming
the routing under a live transfer, which would leave the device DMAing
into released memory.

The firmware reclaims per-PF state (mailbox QINFO routing, qinfo
registers and the like) asynchronously once driver status is marked
inactive.  It does not revert the chip-wide datapath registers
configured by init_module; those stay valid until chip reset (see
nbl_hw_deinit_module()).  The device link created during non-control PF
probe makes the driver core unbind all sibling PFs before the control PF
is removed.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   1 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 276 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  55 ++++
 .../nbl/nbl_include/nbl_def_dev.h             |  14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   9 +
 6 files changed, 356 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index b7eebd89b4d1..71fbe3ee7e62 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -11,4 +11,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_interrupt.o \
 		nbl_hw/nbl_chip.o \
 		nbl_core/nbl_dispatch.o \
+		nbl_core/nbl_dev.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 4d8cea8d8ab3..c3c4dd685bf6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -25,6 +25,7 @@ struct nbl_core {
 	struct nbl_hw_mgt *hw_mgt;
 	struct nbl_resource_mgt *res_mgt;
 	struct nbl_dispatch_mgt *disp_mgt;
+	struct nbl_dev_mgt *dev_mgt;
 	struct nbl_channel_mgt *chan_mgt;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
new file mode 100644
index 000000000000..390bc2b177e2
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_dev.h"
+
+static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+
+	/* mailbox vector allocated in nbl_dev_start() via
+	 * nbl_dev_init_interrupt_scheme(); nbl_dev_request_mailbox_irq()
+	 * only attaches the irq handler to pre-allocated vectors.
+	 */
+	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
+}
+
+/* ----------  Channel config  ---------- */
+static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
+	struct nbl_common_info *common = dev_mgt->common;
+
+	if (!chan_ops->check_queue_exist(priv, chan_type))
+		return;
+
+	/*
+	 * common->hw_bus is the control PF's real bus number, captured in
+	 * nbl_res_ctrl_dev_sriov_info_init() during nbl_res_init_leonis().
+	 * nbl_core_init() runs resource init before nbl_dev_init(), so the
+	 * value is always initialized when this control-PF-only path runs;
+	 * nbl_res_intr_cfg_msix_map() consumes it for cfg_msix_map() the
+	 * same way.
+	 */
+	chan_ops->cfg_chan_qinfo_map_table(priv, common->hw_bus, common->devid);
+}
+
+static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(priv, chan_type))
+		ret = chan_ops->setup_queue(priv, chan_type);
+
+	return ret;
+}
+
+static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(priv, chan_type))
+		ret = chan_ops->teardown_queue(priv, chan_type);
+
+	return ret;
+}
+
+static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
+				       u8 chan_type, struct work_struct *task)
+{
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+
+	if (chan_ops->check_queue_exist(dev_mgt->chan_ops_tbl->priv, chan_type))
+		chan_ops->register_chan_task(dev_mgt->chan_ops_tbl->priv,
+					     chan_type, task);
+}
+
+/* ----------  Tasks config  ---------- */
+static void nbl_dev_clean_mailbox_task(struct work_struct *work)
+{
+	struct nbl_dev_common *common_dev =
+		container_of(work, struct nbl_dev_common, clean_mbx_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+
+	chan_ops->clean_queue_subtask(dev_mgt->chan_ops_tbl->priv,
+				      NBL_CHAN_TYPE_MAILBOX);
+}
+
+/* ----------  Dev init process  ---------- */
+static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev;
+	int ret;
+
+	common_dev = devm_kzalloc(&adapter->pdev->dev, sizeof(*common_dev),
+				  GFP_KERNEL);
+	if (!common_dev)
+		return -ENOMEM;
+	common_dev->dev_mgt = dev_mgt;
+
+	/*
+	 * INIT_WORK must precede nbl_dev_register_chan_task() below: the
+	 * registration hands the work item to the channel and the IRQ
+	 * path may queue it as soon as setup_queue() completes.
+	 */
+	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+
+	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	if (ret) {
+		/*
+		 * Nothing to unwind: chan_info->active is only set on a
+		 * successful setup_queue(), so a failed one left no
+		 * sender, no registered work item and no mailbox
+		 * traffic.  Calling teardown_queue() here would only
+		 * take its "channel not active" early exit and emit a
+		 * misleading duplicate-teardown warning.  The partially
+		 * allocated DMA rings are intentionally kept until devres
+		 * releases them at detach (chan_info->dma_allocated
+		 * blocks a re-setup).
+		 */
+		return ret;
+	}
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
+				   &common_dev->clean_mbx_task);
+	/*
+	 * VSI/ETH identity fetch moved to nbl_dev_start().
+	 * This avoids cross-PF probe race when manager PF is not ready.
+	 */
+	dev_mgt->common_dev = common_dev;
+	nbl_dev_init_msix_cnt(dev_mgt);
+
+	return 0;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+
+	if (!common_dev)
+		return;
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	/*
+	 * nbl_chan_teardown_queue() never fails: it returns 0 both on the
+	 * early exit for a channel that never became active and on the
+	 * normal path, which drains every inflight sender before
+	 * returning.  There is therefore no partial-failure state that
+	 * could leave mailbox DMA in flight and nothing to report here.
+	 */
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+}
+
+static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+
+	return disp_ops->init_module(dev_mgt->disp_ops_tbl->priv);
+}
+
+/*
+ * Tear down control device: deinit_module sets driver_status=false
+ * to notify firmware to clean all per-PF hardware state (including
+ * qinfo registers).  The qinfo map programmed in nbl_dev_init() via
+ * nbl_dev_setup_chan_qinfo() is not explicitly cleared; firmware
+ * handles it on driver_status change.
+ *
+ * Teardown ordering guarantee: every non-management PF creates a
+ * consumer->control PF device link in its probe path, so the driver
+ * core always unbinds all siblings before allowing the control PF to
+ * be detached (sysfs unbind, driver unregister and hot-unplug alike).
+ * nbl_probe_chip_deps() defers a sibling's probe until the control PF
+ * is fully bound (DL_DEV_DRIVER_BOUND), and re-checks that state after
+ * device_link_add() so a supplier that slipped to DL_DEV_NO_DRIVER or
+ * DL_DEV_PROBING in between also defers.  A sibling therefore cannot
+ * reach its mailbox setup before the control PF is fully probed, nor
+ * race this deinit afterwards - the link forces it to be unbound
+ * first.  The link is a persistent managed link with
+ * DL_FLAG_AUTOPROBE_CONSUMER, so binding the control PF again makes
+ * the core re-probe the siblings; without it they would stay unbound
+ * until an admin rebound each one by hand.
+ *
+ * Direct control-PF FLR (which never runs driver teardown) cannot be
+ * guarded here.
+ */
+static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+
+	disp_ops->deinit_module(dev_mgt->disp_ops_tbl->priv);
+}
+
+static struct nbl_dev_mgt *nbl_dev_setup_dev_mgt(struct nbl_common_info *common)
+{
+	struct nbl_dev_mgt *dev_mgt;
+
+	dev_mgt = devm_kzalloc(common->dev, sizeof(*dev_mgt), GFP_KERNEL);
+	if (!dev_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	dev_mgt->common = common;
+	return dev_mgt;
+}
+
+int nbl_dev_init(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl =
+		adapter->intf.dispatch_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		adapter->intf.channel_ops_tbl;
+	struct nbl_dev_mgt *dev_mgt;
+	int ret;
+
+	dev_mgt = nbl_dev_setup_dev_mgt(common);
+	if (IS_ERR(dev_mgt)) {
+		ret = PTR_ERR(dev_mgt);
+		return ret;
+	}
+
+	dev_mgt->disp_ops_tbl = disp_ops_tbl;
+	dev_mgt->chan_ops_tbl = chan_ops_tbl;
+	adapter->core.dev_mgt = dev_mgt;
+	if (common->has_ctrl)
+		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	/*
+	 * Chip hardware initialization is completed by firmware at power-up.
+	 * Only driver functional table/register config follows here, safe to
+	 * access hardware registers before ctrl dev setup.
+	 */
+	ret = nbl_dev_setup_common_dev(adapter);
+	if (ret)
+		goto setup_err;
+
+	if (common->has_ctrl) {
+		ret = nbl_dev_setup_ctrl_dev(adapter);
+		if (ret)
+			goto setup_ctrl_dev_fail;
+	}
+
+	return 0;
+setup_ctrl_dev_fail:
+	nbl_dev_remove_common_dev(adapter);
+setup_err:
+	return ret;
+}
+
+/*
+ * Teardown order: Stop mailbox channel and drain all inflight DMA first,
+ * then invoke deinit_module to notify firmware.
+ *
+ * This intentionally breaks strict init/teardown mirror symmetry due to
+ * a hardware constraint: firmware performs asynchronous *per-PF* cleanup
+ * (mailbox QINFO routing, qinfo registers and the like) once
+ * driver_status=false is set.  It does not revert the chip-wide
+ * datapath registers configured by init_module - those stay valid until
+ * chip reset (see nbl_hw_deinit_module()).  We must guarantee no ongoing
+ * mailbox DMA before deinit_module so firmware cannot reclaim the
+ * routing under a live transfer and leave the device DMAing into
+ * released memory.
+ *
+ * Init order: program mailbox QINFO routing (ctrl PF only) ->
+ *            create mailbox queue/common_dev -> ctrl dev init_module
+ * Teardown order: destroy mailbox queue/common_dev -> ctrl dev deinit_module
+ */
+void nbl_dev_remove(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+
+	nbl_dev_remove_common_dev(adapter);
+	if (common->has_ctrl)
+		nbl_dev_remove_ctrl_dev(adapter);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
new file mode 100644
index 000000000000..24e890fd8987
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEV_H_
+#define _NBL_DEV_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_resource.h"
+#include "../nbl_include/nbl_def_dispatch.h"
+#include "../nbl_include/nbl_def_dev.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+#define NBL_STRING_NAME_LEN			32
+
+enum nbl_msix_serv_type {
+	NBL_MSIX_NET_TYPE,
+	NBL_MSIX_MAILBOX_TYPE,
+	NBL_MSIX_TYPE_MAX
+};
+
+struct nbl_msix_serv_info {
+	char irq_name[NBL_STRING_NAME_LEN];
+	u16 num;
+	u16 base_vector_id;
+	/* true: hw report msix, hw need to mask actively */
+	bool hw_self_mask_en;
+};
+
+struct nbl_msix_info {
+	struct nbl_msix_serv_info serv_info[NBL_MSIX_TYPE_MAX];
+};
+
+struct nbl_dev_common {
+	struct nbl_dev_mgt *dev_mgt;
+	struct nbl_msix_info msix_info;
+	char mailbox_name[NBL_STRING_NAME_LEN];
+	/* for ctrl-dev/net-dev mailbox recv msg */
+	struct work_struct clean_mbx_task;
+};
+
+struct nbl_dev_mgt {
+	struct nbl_common_info *common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dev_common *common_dev;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
new file mode 100644
index 000000000000..51cf04e4c552
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_DEV_H_
+#define _NBL_DEF_DEV_H_
+
+struct nbl_adapter;
+
+int nbl_dev_init(struct nbl_adapter *adapter);
+void nbl_dev_remove(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 86536d582d92..6aacfadd8c0e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -12,6 +12,7 @@
 #include "nbl_include/nbl_def_hw.h"
 #include "nbl_include/nbl_def_resource.h"
 #include "nbl_include/nbl_def_dispatch.h"
+#include "nbl_include/nbl_def_dev.h"
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
@@ -53,7 +54,14 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	ret = nbl_disp_init(adapter);
 	if (ret)
 		goto disp_init_fail;
+
+	ret = nbl_dev_init(adapter);
+	if (ret)
+		goto dev_init_fail;
 	return adapter;
+
+dev_init_fail:
+	nbl_disp_remove(adapter);
 disp_init_fail:
 	nbl_res_remove_leonis(adapter);
 res_init_fail:
@@ -66,6 +74,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_dev_remove(adapter);
 	nbl_disp_remove(adapter);
 	nbl_res_remove_leonis(adapter);
 	nbl_chan_remove_common(adapter);
-- 
2.47.3

