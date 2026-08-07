Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B343B19BA;
	Fri,  7 Aug 2026 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077891; cv=none; b=Dp1VbK3hAXLOld9+DPb6eyKzWqjO7hHPB+lpiw4pzQrUiSFaCmKXSlMBVaSO3KypAM55WlmDQ1tvC8vZ3q0X58FmXXgYjduExw0KwYZ5+dHnFURL4ZFrXE/f+MiV2HbPv2mb8cCg8SY2d4EfVRtHp+J/t0f0+kTxIbFM/E9UtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077891; c=relaxed/simple;
	bh=Gu6ZIvs49qOZdPUcs2Bil8s67MwlUg9BqtkbufjX558=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reHL3rwNurfUxSoMG1AO1ap3ROzjulOgOnNXzUcHJ1z52EJE/ZBtStvV/Ir9w7cYoczMIYQRfCKsAdzpDyi3VuBZw/OIQxAAdgr9LYlkC1KD5wEHnOzzEsCe0HDDjJptzBETGBHIJXRVgr13wUX2oShRhO994PidMsvsTB+S/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0115416-0.00592078-0.982538;FP=12255418535929994290|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.ig.C90W_1786077876;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.ig.C90W_1786077876 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 12:44:37 +0800
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
Subject: [PATCH v24 net-next 10/11] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Fri,  7 Aug 2026 12:44:14 +0800
Message-ID: <20260807044422.2356-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add nbl_dev_setup_common_dev() and nbl_dev_setup_ctrl_dev() initialization
helpers with paired teardown routines, and hook them into nbl_dev_init /
nbl_dev_remove.

Mailbox message processing is implemented via work_struct. This task
registration framework is reused for interrupt-driven receive now, and
can be shared with polling receive mode introduced in follow-up patches.

Extend channel send logic with polling ACK fallback path. During early
device initialization before interrupts are enabled, synchronous mailbox
requests rely on polling to wait for firmware ACK, avoiding silent
success and uninitialized variable reads when NBL_CHAN_INTERRUPT_READY
is not yet set.

Chip core hardware initialization is fully handled by firmware during
power-on; the driver only configures functional table entries and
registers after hardware is ready. Thus invoking
nbl_dev_setup_common_dev() before ctrl dev setup does not trigger
hardware faults, all register accesses are safe.
Teardown order explanation:
1. Remove ctrl dev first: notify firmware to clean all per-PF hardware
state including qinfo registers via driver status flag.
2. Then tear down common device queue resources.
Firmware cleanup ensures qinfo registers are valid during subsequent
common dev deinit writes, avoiding PCIe master abort or hardware access
panics.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_channel/nbl_channel.c             |  72 +++++-
 .../nbl/nbl_channel/nbl_channel.h             |   3 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  21 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   1 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 240 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  57 +++++
 .../nbl/nbl_include/nbl_def_common.h          |   3 +
 .../nbl/nbl_include/nbl_def_dev.h             |  14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   9 +
 10 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 56464f576cbe..0febda209865 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -11,4 +11,5 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_interrupt.o \
 				nbl_hw/nbl_chip.o \
 				nbl_core/nbl_dispatch.o \
+				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
index 9e0f9b6c4c3a..3b7f3876a075 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -636,10 +636,13 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
 static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
 				 struct nbl_chan_info *chan_info)
 {
+	struct nbl_common_info *common = chan_mgt->common;
 	struct nbl_chan_ring *rxq = &chan_info->rxq;
 	struct device *dev = chan_mgt->common->dev;
 	struct nbl_chan_rx_desc *rx_desc;
 	struct nbl_chan_buf *rx_buf;
+	struct work_struct *task;
+	bool more_work = false;
 	u16 next_to_clean;
 	u32 budget = 64;
 	u16 flags;
@@ -666,11 +669,22 @@ static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
 			next_to_clean = 0;
 		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
 		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
-		if (--budget == 0)
+		if (--budget == 0) {
+			more_work = true;
 			break;
+		}
 		cond_resched();
 	}
 	rxq->next_to_clean = next_to_clean;
+
+	/* Prevent queue_work after teardown clears clean_task */
+	if (READ_ONCE(chan_info->shutdown))
+		return;
+	if (common->wq && more_work) {
+		task = READ_ONCE(chan_info->clean_task);
+		if (task)
+			queue_work(common->wq, task);
+	}
 }
 
 static void nbl_chan_clean_queue_subtask(struct nbl_channel_mgt *chan_mgt,
@@ -728,10 +742,12 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
 	struct nbl_common_info *common = chan_mgt->common;
 	struct nbl_chan_waitqueue_head *wait_head;
 	struct nbl_chan_tx_param tx_param = { 0 };
+	int i = NBL_CHAN_TX_WAIT_ACK_TIMES;
 	struct nbl_chan_info *chan_info =
 		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
 	struct device *dev = common->dev;
 	bool inflight_inc = false;
+	struct work_struct *task;
 	u16 msgid = 0;
 	int ret;
 	u16 tmp;
@@ -869,6 +885,60 @@ static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
 		WRITE_ONCE(wait_head->ack_data_len, 0);
 		spin_unlock_irq(&wait_head->status_lock);
 		goto inflight_dec_out;
+	} else {
+		/* Polling wait path for synchronous ACK */
+		while (i--) {
+			if (READ_ONCE(chan_info->shutdown)) {
+				ret = -ESHUTDOWN;
+				/*
+				 * Shutdown happens during polling wait,
+				 * reclaim slot
+				 */
+				spin_lock_irq(&wait_head->status_lock);
+				WRITE_ONCE(wait_head->acked, 0);
+				WRITE_ONCE(wait_head->ack_data, NULL);
+				WRITE_ONCE(wait_head->ack_data_len, 0);
+				WRITE_ONCE(wait_head->status,
+					   NBL_MBX_STATUS_TIMEOUT);
+				spin_unlock_irq(&wait_head->status_lock);
+				goto inflight_dec_out;
+			}
+
+			task = READ_ONCE(chan_info->clean_task);
+			if (common->wq && task &&
+			    !READ_ONCE(chan_info->shutdown))
+				queue_work(common->wq, task);
+
+			spin_lock_irq(&wait_head->status_lock);
+			if (READ_ONCE(wait_head->acked)) {
+				chan_send->ack_len = wait_head->ack_data_len;
+				ret = wait_head->ack_err;
+				WRITE_ONCE(wait_head->acked, 0);
+				WRITE_ONCE(wait_head->status,
+					   NBL_MBX_STATUS_IDLE);
+				spin_unlock_irq(&wait_head->status_lock);
+				goto inflight_dec_out;
+			}
+			spin_unlock_irq(&wait_head->status_lock);
+
+			usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
+				     NBL_CHAN_TX_WAIT_ACK_US_MAX);
+			cond_resched();
+		}
+
+		/* Polling loop exhausted, reclaim slot */
+		spin_lock_irq(&wait_head->status_lock);
+		WRITE_ONCE(wait_head->acked, 0);
+		WRITE_ONCE(wait_head->ack_data, NULL);
+		WRITE_ONCE(wait_head->ack_data_len, 0);
+		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_TIMEOUT);
+		spin_unlock_irq(&wait_head->status_lock);
+
+		dev_err_ratelimited(dev,
+				    "Channel polling ack failed, message type: %d msg id: %u\n",
+				    chan_send->msg_type, msgid);
+		ret = -ETIMEDOUT;
+		goto inflight_dec_out;
 	}
 
 inflight_dec_out:
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
index 92db39e1b05e..d59e660be9c7 100644
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
 #define NBL_CHAN_BUF_LEN			4096
 #define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
index 149681dd216d..f10ef78ee7f6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -7,6 +7,27 @@
 #include <linux/jhash.h>
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
+	common->wq = alloc_workqueue("%s", WQ_UNBOUND, 0, wq_name);
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
 /*
  * nbl_common_func_id_to_rel_pf_id - convert absolute PF id to relative PF id
  *
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 566d67130975..9519aacbf0ea 100644
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
index 000000000000..bdb4d6a45fbc
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
+	struct nbl_common_info *common = dev_mgt->common;
+	struct nbl_dev_common *common_dev;
+	int ret;
+
+	common_dev = devm_kzalloc(&adapter->pdev->dev, sizeof(*common_dev),
+				  GFP_KERNEL);
+	if (!common_dev)
+		return -ENOMEM;
+	common_dev->dev_mgt = dev_mgt;
+
+	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
+				   &common_dev->clean_mbx_task);
+	/*
+	 * Even if has_ctrl=false (no dedicated control PF channel), we fetch
+	 * VSI/ETH info via regular mailbox message  instead of
+	 * dedicated control command.
+	 */
+	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
+	if (ret)
+		goto err_cleanup;
+	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
+			     &common->eth_id, &common->logic_eth_id);
+	if (ret)
+		goto err_cleanup;
+
+	dev_mgt->common_dev = common_dev;
+	nbl_dev_init_msix_cnt(dev_mgt);
+
+	return 0;
+err_cleanup:
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	return ret;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+
+	if (!common_dev)
+		return;
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	cancel_work_sync(&common_dev->clean_mbx_task);
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
+	nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+
+	return 0;
+}
+
+/*
+ * This is intentional.  The qinfo registers are managed by the chip
+ * firmware, not by the driver.  Setting driver status to false is the
+ * designed teardown mechanism — it notifies the firmware, which then
+ * performs its own cleanup of all per-PF state including the qinfo
+ * registers.
+ * An inverse helper would duplicate work that the firmware already
+ * does, and would add error-path complexity for no benefit.  We keep
+ * the deinit path minimal and rely on the firmware cleanup for
+ * correctness, including in abnormal reset scenarios.
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
+	ret = nbl_common_create_wq(common);
+	if (ret)
+		return ret;
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
+	nbl_common_destroy_wq(common);
+	return ret;
+}
+
+/*
+ * Teardown order: ctrl dev first, then common dev.
+ * nbl_dev_remove_ctrl_dev() notifies firmware to clean all per-PF state
+ * (including qinfo registers), so subsequent common dev queue cleanup
+ * will not trigger PCIe master abort or invalid register access.
+ */
+void nbl_dev_remove(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+
+	if (common->has_ctrl)
+		nbl_dev_remove_ctrl_dev(adapter);
+	nbl_dev_remove_common_dev(adapter);
+	nbl_common_destroy_wq(common);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
new file mode 100644
index 000000000000..7666ab9a73f3
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+	/* virtio_dev has a config vector_id, and the vector_id need is 0 */
+	NBL_MSIX_VIRTIO_TYPE = 0,
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index af7e7225a879..75882bfe4c93 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -28,6 +28,7 @@ static inline u32 nbl_vsi_id_gap(u32 m)
 }
 
 struct nbl_common_info {
+	struct workqueue_struct *wq;
 	struct pci_dev *pdev;
 	struct device *dev;
 	u32 msg_enable;
@@ -54,6 +55,8 @@ struct nbl_hash_tbl_key {
 	u16 resv;
 };
 
+void nbl_common_destroy_wq(struct nbl_common_info *common);
+int nbl_common_create_wq(struct nbl_common_info *common);
 int nbl_common_func_id_to_rel_pf_id(struct nbl_common_info *common, u32 pf_id,
 				    u32 *rel_pf_id);
 struct nbl_hash_tbl_mgt *
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
new file mode 100644
index 000000000000..b422a4edf0a9
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
index 6bd74c933c78..8a968a06b5b6 100644
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

