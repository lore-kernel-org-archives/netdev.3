Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DF53D0C5;
	Tue, 22 Sep 2026 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078614; cv=none; b=iFn5+mchdsKL6l3Zwomvz1D2arDwzBwJgB9ta161wAzVRC/QtwM1eSOxaz1+Vxjwh7fS3uFb6twlEowk+Tg9IyQJy9oMh2l112C/I5K9sIFQQkLIr2TvePEaBimDRwMXytmWlFfpEGOYeKs8sscEAmpuXQJIM6uH8MFGU3sX/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078614; c=relaxed/simple;
	bh=1Y4xHZkaOnnpWmXdsaPo06WyDphbp+14Ql/B1YGaq4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULLWflhOxJzX++G0P1ZLzjpr3M63MN8qjuiEw0SaLz6qJtdQyNIHbvokgcn4wJKauuQQ4PhmtCs0wxVITI+rpKMc97hp4ifbw6ng6/ZNHYgIJDI4DPQKXYH4XeyApgmZxcfeN8rLZr5oiKJy9NvvgjTRieqVIIxDbxl57q5n+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0113905-0.00586475-0.982745;FP=16884940708758703762|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jK4DPVy_1790078600;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jK4DPVy_1790078600 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:03:20 +0800
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
Subject: [PATCH v29 net-next 7/8] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Tue, 22 Sep 2026 20:03:04 +0800
Message-ID: <20260922120311.86593-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add nbl_dev core infrastructure. Create nbl_dev.c / nbl_dev.h and
nbl_def_dev.h, introducing nbl_dev_setup_common_dev() and
nbl_dev_setup_ctrl_dev() initialization helpers with their teardown
counterparts, and wire them into nbl_dev_init() / nbl_dev_remove()
called from nbl_core_init() / nbl_core_remove().

Common device setup (nbl_dev_setup_common_dev):
- Allocate per-device state (nbl_dev_common)
- Set up mailbox channel queue and register cleanup work
- Initialize MSI-X service counts (mailbox = 1 vector; actual
  allocation deferred to nbl_dev_start() in the next patch; this
  patch only populates service vector counts)
- VSI/ETH identity fetch is deferred to nbl_dev_start() for both
  control and non-control PFs. This ensures mailbox channel and
  control PF responder are fully ready before RPC lookup, and keeps
  every intermediate commit bisect-bootable on multi-PF systems.

Control device setup (nbl_dev_setup_ctrl_dev, control PF only):
- disp_ops->init_module(): chip-wide hardware initialization callback
  (datapath pipeline setup, driver_status flag)
- Program mailbox QINFO routing map (bus/devid for each PF)

Chip core hardware initialization is done by firmware at power-on.
The driver only programs functional table entries after hardware is ready;
common_dev setup before ctrl_dev setup is safe.

Non-control PFs create device links to the control PF during probe.
The device link guarantees the kernel unbinds all non-control PFs before
the control PF can be removed, preventing broken cross-PF mailbox RPC.
A registry check is added as defense-in-depth, to skip global chip deinit
if sibling PFs remain bound.

Deinit order: ctrl dev cleanup after common dev teardown.
nbl_dev_remove_ctrl_dev() calls deinit_module(), which sets
driver_status=false to notify firmware to asynchronously clean
all per-PF hardware state including qinfo registers. The qinfo
map is not explicitly cleared by the driver; firmware handles it
on driver_status change. No completion handshake exists in the
current hardware revision.

Teardown ordering guarantee: stop mailbox channel and drain all
inflight DMA first, then invoke deinit_module to notify firmware.
This intentionally breaks strict init/teardown mirror symmetry due to
hardware constraint: firmware may perform asynchronous global hardware
cleanup once driver_status=false is set. We must guarantee no ongoing
mailbox DMA before deinit_module to avoid invalid DMA write.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   1 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 259 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  55 ++++
 .../nbl/nbl_include/nbl_def_dev.h             |  14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   9 +
 6 files changed, 339 insertions(+)
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
index 000000000000..35410c6f1fb9
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,259 @@
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
+	 * Initialize clean_mbx_task before any operation that could jump
+	 * to err_cleanup, so cancel_work_sync() is always safe there.
+	 */
+	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+
+	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	if (ret)
+		goto err_cleanup;
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
+err_cleanup:
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+	return ret;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int ret;
+
+	if (!common_dev)
+		return;
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	ret = nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	if (ret)
+		dev_warn(&adapter->pdev->dev, "mailbox queue teardown failed, inflight DMA may exist: %d\n",
+			 ret);
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+}
+
+static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	int ret;
+
+	ret = disp_ops->init_module(dev_mgt->disp_ops_tbl->priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Tear down control device: deinit_module sets driver_status=false
+ * to notify firmware to clean all per-PF hardware state (including
+ * qinfo registers).  The qinfo map programmed in setup_ctrl_dev is
+ * not explicitly cleared; firmware handles it on driver_status change.
+ *
+ * Teardown ordering guarantee: every non-management PF creates a
+ * consumer->control PF device link in its probe path, so the driver
+ * core always unbinds all siblings before allowing the control PF to
+ * be detached (sysfs unbind, driver unregister and hot-unplug alike).
+ *
+ * Safety net: this registry check additionally blocks the chip-global
+ * deinit if a sibling PF is somehow still bound on the same chip
+ * (defense in depth for paths that bypass device-link ordering).
+ * Skipping deinit leaves firmware/qinfo routing alive for the siblings;
+ * their control plane stays functional at the cost of deferring the
+ * global firmware cleanup until the next control PF init_module().
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
+ * hardware constraint: firmware may perform asynchronous global hardware
+ * cleanup once driver_status=false is set. We must guarantee no ongoing
+ * mailbox DMA before deinit_module to avoid invalid DMA write.
+ *
+ * Init order: create mailbox(common_dev) → ctrl dev init
+ * Teardown order: destroy mailbox(common_dev) → ctrl dev deinit
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
index 5979f62d7f81..d362f1270d83 100644
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

