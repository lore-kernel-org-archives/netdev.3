Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563719;
	b=FvttyD8RzZMSdEXbdyD6ggv2DIiK/zN39axw96hAOI3VOykicJAn4Ak/HsTxhiOD/Whz
	 99a+n7Of32pZn39RTUVjmx2aQiadp6a46s6fu742TLfbhZ6nZzpuiDOPPFTI8cCed60ix
	 J/vppChAVSxJMY4DRv7qEI9cK8TVTjsYvcEW3sy+uayZErPdTLbuv+NeyaLD6SRJ0cel2
	 co1ae32w54f8wPab2oXSAsl2qYNScV9aZvcl1bxN9fJ7SizdnKF1gF98ZbVD+VfaKhdN1
	 KG3OBPFMib+SnNrWTS/PppnvasBTpAqBSVFy+45PcxRmBXufxqCqint9pL2zM2pKa+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563719;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fBWURODzbWmac10m43qhNzD6Sv5QBAAd9GIaOeDoPTk=;
	b=budEEq3wpysZIpaAS54lWysHGSwvWqNY5YjFBhsZBUrWo7nkjpxNoTq0x+wHBHo7JePj
	 zLvEqyDApP6UZKqLSx6Fn8c9rgqkZiH8MFxLupfw5dgM2sBxYfQlTosy3y0Hshv65maQo
	 QMKp0ePvLlhDnTZtm+2y7H3p+dm0GZloSS9PWxXwdiBfMvbz4fwxfeH9TYN6Vzit8z4CO
	 1M4Z/iLtzOU6HjYvXpY93P4WxVnrIswnzqVQYdlp0AFK1MhpBtyig3noYhkMWLxZ+4oHm
	 +iBftbAeAxt9SDBK3R4rVJpdxZSfcoICio2a2I/uJdOV+/nymaJhh+WdAw9VkGdIk5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.148
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBA606A32C;
	Wed, 21 Oct 2026 06:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCBA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0121959-0.00625832-0.981546;FP=17172643284969328274|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jmHtK1Y_1792563708;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jmHtK1Y_1792563708 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 21 Oct 2026 14:21:49 +0800
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
Subject: [PATCH v32 net-next 7/8] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Wed, 21 Oct 2026 14:21:06 +0800
Message-ID: <20261021062113.2158-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062113.2158-1-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-1-illusion.wang@nebula-matrix.com>
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
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 295 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  55 ++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  22 +-
 .../nbl/nbl_include/nbl_def_dev.h             |  14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   9 +
 7 files changed, 396 insertions(+), 1 deletion(-)
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
index 000000000000..cbb0b06b8011
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,295 @@
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
+	 *
+	 * Unregistering the clean task is the channel layer's job too:
+	 * teardown_queue() clears clean_task under state_lock and then
+	 * cancel_work_sync()es it, after shutdn has blocked new queues.  A
+	 * register_chan_task(..., NULL) from here would be a no-op anyway,
+	 * because nbl_chan_register_chan_task() ignores writes once shutdn
+	 * is set.
+	 */
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
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
+	 *
+	 * The QINFO routing has to be programmed before the mailbox queue is
+	 * enabled: nbl_dev_setup_common_dev() sets QUEUE_EN, and a queue that
+	 * is live before its routing is in place would drop or misroute
+	 * traffic.
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
+/*
+ * A failure after the QINFO routing was programmed leaves those entries
+ * in hardware: driver_status never goes 1 -> 0 on these paths, so
+ * firmware does not reclaim them.  This is harmless - firmware only
+ * routes once driver_status announces the driver, and no sibling PF can
+ * bind until this probe succeeds.  The next successful probe overwrites
+ * the entries, and a chip reset clears them.
+ */
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index cb68544e0272..59d80066f88b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -647,5 +647,25 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 
 void nbl_disp_remove(struct nbl_adapter *adapter)
 {
-	/* Dispatch structures are allocated via devm */
+	/*
+	 * Dispatch structures are devm-allocated and freed at detach.
+	 *
+	 * The five responders registered by nbl_disp_setup_msg() are
+	 * owned by the channel layer (xarray of handlers) and are never
+	 * unregistered here. This is safe because the teardown order
+	 * guarantees no responder can run after this point:
+	 *
+	 *   mailbox teardown
+	 *     -> cancel_work_sync(clean_mbx_task)   // drain RX work
+	 *     -> nbl_chan_teardown_queue()          // stop HW queue,
+	 *                                                 // join clean task,
+	 *                                                 // active=false
+	 *     -> nbl_chan_remove_common()
+	 *          -> nbl_common_destroy_wq()            // no new work
+	 *          -> nbl_chan_remove_msg_handler()      // free handler nodes
+	 *
+	 * By the time devres frees disp_mgt, the mailbox queue is stopped
+	 * and the handler xarray is empty, so no responder can touch
+	 * res_mgt->intr_mgt after nbl_intr_mgt_stop() has cleared it.
+	 */
 }
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
index d8a1e5690295..7598ebac91e3 100644
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
 		goto out_res_remove;
+
+	ret = nbl_dev_init(adapter);
+	if (ret)
+		goto out_disp_remove;
 	return adapter;
+
+out_disp_remove:
+	nbl_disp_remove(adapter);
 out_res_remove:
 	nbl_res_remove_leonis(adapter);
 out_chan_remove:
@@ -66,6 +74,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_dev_remove(adapter);
 	nbl_disp_remove(adapter);
 	nbl_res_remove_leonis(adapter);
 	nbl_chan_remove_common(adapter);
-- 
2.47.3

