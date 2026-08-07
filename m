Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389E3CB54C;
	Fri,  7 Aug 2026 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077896; cv=none; b=EX96Z3bjbBIdLjY33ITKIWIafWOfi6Rmq4sJUbDpYOKUI4TNXt4AhCsEEWo/koAUzPTNhUGRiyMi82ablUyhzSZtW/9zRlAMEh+aPA90prUwo+SqIN4QegAhLv0v9W27P8NP/bKIp64VXLd2uSyCe4zJSlFD/t+d1G15Eawwuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077896; c=relaxed/simple;
	bh=5+AjwAjYTnObs9GlyjmH6MHmoN5jhmr38UUgbsQXJns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3dhI8AprQUX2f7nhy2I7cCpKx3VggvlOvrAoF4CvZkPuH5jRDy+8tz/UkuabFSdiS+CjN15Qa04xbQHcp7AYQpOpc5Dzxdf3LUJaUOOC36bZxXyLJIoJPLJKOBAW5gt2ZpzA8ssiDoc8u7fEuUq1Wk3GEXdg7b+Kkq965v0Tqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0297637-0.00126913-0.968967;FP=16310151611689747643|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.ig.C8w-_1786077869;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.ig.C8w-_1786077869 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 12:44:30 +0800
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
Subject: [PATCH v24 net-next 04/11] net/nebula-matrix: add channel layer
Date: Fri,  7 Aug 2026 12:44:08 +0800
Message-ID: <20260807044422.2356-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

A channel management layer provides a structured approach to handle
communication between different components and drivers. Here's a summary
of its key functionalities:

1. Message Handling Framework
   Message Registration: Functions (nbl_chan_register_msg) allow dynamic
   registration of message handlers for specific message types, enabling
   extensible communication protocols.

   Message Sending/Acknowledgment: Core functions (nbl_chan_send_msg,
   nbl_chan_send_ack) handle message transmission. It supports two modes:
   fire-and-forget transmission, and synchronous send with ACK waiting.
   Received ACK messages are processed via nbl_chan_recv_ack_msg.
   TX slot allocation logic is implemented to limit concurrent outstanding
   messages; returns -EAGAIN when all waiting slots are occupied.

   Hash-Based Handler Lookup: A hash table (`handle_hash_tbl`) stores
   message handlers for efficient O(1) lookup by message type.
   The entire table is removed via `nbl_chan_remove_msg_handler` during
   driver teardown; per-message-type unregister is not implemented
   in this version.

   Tx descriptor supports two data formats: small embedded payload inside
   descriptor, and large payload via external DMA buffer.

2. Channel Types and Queue Management
   Mailbox Channel: implemented for inter-PF communication (PF0 <-> other PFs).

   Queue Initialization: Functions (nbl_chan_init_queue,
   nbl_chan_init_tx_queue) allocate resources:
   - TX/RX descriptors: dmam_alloc_coherent()
   - TX/RX buffer metadata arrays (txq->buf, rxq->buf): devm_kcalloc()

   Queue Teardown: nbl_chan_teardown_queue() stops hardware queues, cancels
   pending work items (clean_task), and waits for in-flight send threads
   to drain. It does NOT free DMA memory, which is released automatically
   via devm on driver remove.

   IMPORTANT - Resource Lifecycle Design:
   DMA memory allocated with dmam_alloc_coherent() is intentionally NOT
   freed in nbl_chan_teardown_queue(). The queues are allocated once
   during driver probe and freed only during driver remove. Dynamic
   per-PF queue teardown and re-creation during runtime is not supported.

   Queue Configuration: Hardware-specific queue parameters (e.g., buffer
   sizes, entry counts) are set via nbl_chan_config_queue, with hardware
   interactions delegated to hw_ops.

   RX completion relies on work_struct clean_task for descriptor processing.

3. Hardware Abstraction Layer (HW Ops)
   Hardware-Specific Operations: The nbl_hw_ops structure abstracts
   hardware interactions: queue configuration (config_mailbox_txq/rxq),
   tail pointer doorbell updates (update_mailbox_queue_tail_ptr),
   and PF mailbox routing table configuration.

NOTE: This initial implementation provides interrupt-driven receive path,
where actual RX message processing is scheduled into workqueue after
interrupt notification. Polling-based mailbox receive is not supported
in this patch and will be added in subsequent series.

And the optimization to requeue clean_task inside nbl_chan_clean_queue()
when processing budget is exhausted is deferred to follow-up patches.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    4 +-
 .../nbl/nbl_channel/nbl_channel.c             | 1068 +++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  170 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  166 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   29 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    7 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  174 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |   56 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   45 +
 .../nbl/nbl_include/nbl_def_channel.h         |  104 ++
 .../nbl/nbl_include/nbl_def_common.h          |   15 +
 .../nbl/nbl_include/nbl_def_hw.h              |   19 +
 .../nbl/nbl_include/nbl_include.h             |    3 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |    7 +
 14 files changed, 1866 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index caa863d3a582..6dc1539cee1f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -3,5 +3,7 @@
 
 obj-$(CONFIG_NBL) := nbl.o
 
-nbl-objs +=       nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+nbl-objs +=       nbl_common/nbl_common.o \
+				nbl_channel/nbl_channel.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
new file mode 100644
index 000000000000..3eb795199217
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -0,0 +1,1068 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
+#include <linux/atomic.h>
+#include <linux/wait.h>
+#include "nbl_channel.h"
+
+static int nbl_chan_add_msg_handler(struct nbl_channel_mgt *chan_mgt,
+				    u16 msg_type, nbl_chan_resp func,
+				    void *priv)
+{
+	struct nbl_chan_msg_node_data handler = { 0 };
+	int ret;
+
+	handler.func = func;
+	handler.priv = priv;
+	ret = nbl_common_alloc_hash_node(chan_mgt->handle_hash_tbl, &msg_type,
+					 &handler, NULL);
+
+	return ret;
+}
+
+static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_hash_tbl_key tbl_key = { 0 };
+
+	tbl_key.dev = common->dev;
+	tbl_key.key_size = sizeof(u16);
+	tbl_key.data_size = sizeof(struct nbl_chan_msg_node_data);
+	tbl_key.bucket_size = NBL_CHAN_HANDLER_TBL_BUCKET_SIZE;
+
+	chan_mgt->handle_hash_tbl = nbl_common_init_hash_table(&tbl_key);
+	if (!chan_mgt->handle_hash_tbl)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_chan_remove_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	if (!chan_mgt->handle_hash_tbl)
+		return;
+	nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl);
+	chan_mgt->handle_hash_tbl = NULL;
+}
+
+static void nbl_chan_init_queue_param(struct nbl_chan_info *chan_info,
+				      u16 num_txq_entries, u16 num_rxq_entries,
+				      u16 txq_buf_size, u16 rxq_buf_size)
+{
+	chan_info->num_txq_entries = num_txq_entries;
+	chan_info->num_rxq_entries = num_rxq_entries;
+	chan_info->txq_buf_size = txq_buf_size;
+	chan_info->rxq_buf_size = rxq_buf_size;
+	atomic_set(&chan_info->inflight_tx_cnt, 0);
+	WRITE_ONCE(chan_info->shutdown, false);
+}
+
+static int nbl_chan_init_tx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = common->dev;
+	size_t size =
+		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+	u16 i;
+
+	txq->desc.tx_desc =
+		dmam_alloc_coherent(dev, size, &txq->dma, GFP_KERNEL);
+	if (!txq->desc.tx_desc)
+		return -ENOMEM;
+
+	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
+				       sizeof(*chan_info->wait), GFP_KERNEL);
+	if (!chan_info->wait)
+		return -ENOMEM;
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		init_waitqueue_head(&chan_info->wait[i].wait_queue);
+		chan_info->wait[i].status = NBL_MBX_STATUS_IDLE;
+		spin_lock_init(&chan_info->wait[i].status_lock);
+	}
+
+	txq->buf = devm_kcalloc(dev, chan_info->num_txq_entries,
+				sizeof(*txq->buf), GFP_KERNEL);
+	if (!txq->buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int nbl_chan_init_rx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = common->dev;
+	size_t size =
+		chan_info->num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+
+	rxq->desc.rx_desc =
+		dmam_alloc_coherent(dev, size, &rxq->dma, GFP_KERNEL);
+	if (!rxq->desc.rx_desc) {
+		dev_err_ratelimited(dev,
+				    "Allocate DMA for chan rx descriptor ring failed\n");
+		return -ENOMEM;
+	}
+
+	rxq->buf = devm_kcalloc(dev, chan_info->num_rxq_entries,
+				sizeof(*rxq->buf), GFP_KERNEL);
+	if (!rxq->buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int nbl_chan_init_queue(struct nbl_common_info *common,
+			       struct nbl_chan_info *chan_info)
+{
+	int err;
+
+	err = nbl_chan_init_tx_queue(common, chan_info);
+	if (err)
+		return err;
+
+	err = nbl_chan_init_rx_queue(common, chan_info);
+
+	return err;
+}
+
+static void nbl_chan_config_queue(struct nbl_channel_mgt *chan_mgt,
+				  struct nbl_chan_info *chan_info, bool tx)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	struct nbl_chan_ring *ring;
+	dma_addr_t addr;
+	int size_bwid;
+
+	if (tx)
+		ring = &chan_info->txq;
+	else
+		ring = &chan_info->rxq;
+	addr = ring->dma;
+	if (tx) {
+		size_bwid = ilog2(chan_info->num_txq_entries);
+		hw_ops->config_mailbox_txq(p, addr, size_bwid);
+	} else {
+		size_bwid = ilog2(chan_info->num_rxq_entries);
+		hw_ops->config_mailbox_rxq(p, addr, size_bwid);
+	}
+}
+
+static int nbl_chan_alloc_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		buf = &txq->buf[i];
+		buf->va = dmam_alloc_coherent(dev, chan_info->txq_buf_size,
+					      &buf->pa, GFP_KERNEL);
+		if (!buf->va) {
+			dev_err_ratelimited(dev,
+					    "Allocate buffer for chan tx queue failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	txq->next_to_clean = 0;
+	txq->next_to_use = 0;
+	txq->tail_ptr = 0;
+
+	return 0;
+}
+
+static void nbl_chan_cfg_qinfo_map_table(struct nbl_channel_mgt *chan_mgt,
+					 u8 bus, u8 devid)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	u32 pf_mask = 0;
+	u8 func_id;
+
+	hw_ops->get_host_pf_mask(p, &pf_mask);
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (!(pf_mask & (1 << func_id)))
+			hw_ops->cfg_mailbox_qinfo(p, func_id, bus,
+						  devid, func_id);
+	}
+}
+
+static int nbl_chan_alloc_all_rx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_rx_desc *desc;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_rxq_entries; i++) {
+		buf = &rxq->buf[i];
+		buf->va = dmam_alloc_coherent(dev, chan_info->rxq_buf_size,
+					      &buf->pa, GFP_KERNEL);
+		if (!buf->va) {
+			dev_err_ratelimited(dev,
+					    "Allocate buffer for chan rx queue failed\n");
+			goto err;
+		}
+	}
+
+	desc = rxq->desc.rx_desc;
+	/*
+	 * RX ring adopts empty-ring convention: reserve one unused entry
+	 * to distinguish queue FULL vs queue EMPTY.
+	 * We initialize entries [0 ... num_rxq_entries - 2],
+	 * leave the last entry uninitialized as the hole marker.
+	 */
+	for (i = 0; i < chan_info->num_rxq_entries - 1; i++) {
+		buf = &rxq->buf[i];
+		desc[i].buf_addr = cpu_to_le64(buf->pa);
+		desc[i].buf_len = cpu_to_le32(chan_info->rxq_buf_size);
+		desc[i].flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
+	}
+
+	rxq->next_to_clean = 0;
+	/* Reserve last slot as hole to differentiate full/empty status */
+	rxq->next_to_use = chan_info->num_rxq_entries - 1;
+	rxq->tail_ptr = chan_info->num_rxq_entries - 1;
+
+	return 0;
+err:
+	return -ENOMEM;
+}
+
+static int nbl_chan_alloc_all_bufs(struct nbl_channel_mgt *chan_mgt,
+				   struct nbl_chan_info *chan_info)
+{
+	int err;
+
+	err = nbl_chan_alloc_all_tx_bufs(chan_mgt, chan_info);
+	if (err)
+		return err;
+	err = nbl_chan_alloc_all_rx_bufs(chan_mgt, chan_info);
+
+	return err;
+}
+
+static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+
+	hw_ops->stop_mailbox_rxq(chan_mgt->hw_ops_tbl->priv);
+	hw_ops->stop_mailbox_txq(chan_mgt->hw_ops_tbl->priv);
+}
+
+static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
+				   u8 chan_type)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+	struct nbl_chan_waitqueue_head *wait_head;
+	unsigned long wait_start, wait_timeout;
+	int ret = 0;
+	u16 i;
+
+	/* Step 1: Mark shutdown flag, reject all new send requests */
+	WRITE_ONCE(chan_info->shutdown, true);
+	/*
+	 * Full memory barrier: Ensure the write to 'shutdown' becomes visible
+	 * to all other CPUs BEFORE we start waiting on inflight_tx_cnt.
+	 * Peer send_msg threads check shutdown flag prior to taking new work;
+	 * this barrier prevents reordering that would let send paths observe
+	 * inflight_tx_cnt == 0 but still accept new messages.
+	 */
+	smp_mb();
+
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		wait_head = &chan_info->wait[i];
+		spin_lock_irq(&wait_head->status_lock);
+		/* Only wake threads that are actually waiting */
+		if (READ_ONCE(wait_head->status) == NBL_MBX_STATUS_WAITING) {
+			/* Mark as timeout so waking threads know to abort */
+			WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_TIMEOUT);
+			WRITE_ONCE(wait_head->acked, 1);
+			WRITE_ONCE(wait_head->ack_err, (s32)-EIO);
+			wake_up(&wait_head->wait_queue);
+		}
+		spin_unlock_irq(&wait_head->status_lock);
+	}
+	/* Stop hardware queues */
+	nbl_chan_stop_queue(chan_mgt);
+
+	/*
+	 * Step 2: Wait all in-flight send_msg threads exit FIRST.
+	 * Guarantee no further queue_work() can be triggered during cleanup.
+	 * Add timeout to avoid permanent blocking.
+	 */
+	wait_start = jiffies;
+	wait_timeout = msecs_to_jiffies(5000);
+	while (atomic_read(&chan_info->inflight_tx_cnt) != 0) {
+		if (time_after(jiffies, wait_start + wait_timeout)) {
+			dev_warn(chan_mgt->common->dev,
+				 "teardown: wait inflight_tx_cnt timeout, force continue\n");
+			ret = -ETIMEDOUT;
+			break;
+		}
+		cpu_relax();
+		usleep_range(1000, 2000);
+	}
+
+	/* Step3: All send paths drained, safely cancel cleanup work */
+	if (chan_info->clean_task) {
+		cancel_work_sync(chan_info->clean_task);
+		chan_info->clean_task = NULL;
+	}
+	return ret;
+}
+
+static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	int err;
+
+	if (READ_ONCE(chan_info->init_done))
+		return 0;
+	err = devm_mutex_init(common->dev, &chan_info->txq_lock);
+	if (err)
+		return err;
+	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
+				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
+				  NBL_CHAN_BUF_LEN);
+	err = nbl_chan_init_queue(common, chan_info);
+	if (err)
+		return err;
+	err = nbl_chan_alloc_all_bufs(chan_mgt, chan_info);
+	if (err)
+		return err;
+	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
+	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
+	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
+				 rxq->tail_ptr, NBL_MB_RX_QID);
+	WRITE_ONCE(chan_info->init_done, true);
+	return 0;
+}
+
+static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
+				   struct nbl_chan_info *chan_info,
+				   struct nbl_chan_tx_param *param)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct nbl_chan_tx_desc *tx_desc =
+		NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_use);
+	struct nbl_chan_buf *tx_buf =
+		NBL_CHAN_TX_RING_TO_BUF(txq, txq->next_to_use);
+
+	if (param->arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc))
+		return -EINVAL;
+
+	tx_desc->dstid = cpu_to_le16(param->dstid);
+	tx_desc->msg_type = cpu_to_le16(param->msg_type);
+	tx_desc->msgid = cpu_to_le16(param->msgid);
+
+	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+		memcpy(tx_buf->va, param->arg, param->arg_len);
+		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
+		tx_desc->buf_len = cpu_to_le16(param->arg_len);
+		tx_desc->data_len = 0;
+		memset(tx_desc->data, 0, sizeof(tx_desc->data));
+	} else {
+		memset(tx_desc->data, 0, sizeof(tx_desc->data));
+		memset(&tx_desc->buf_addr, 0, sizeof(tx_desc->buf_addr));
+		memcpy(tx_desc->data, param->arg, param->arg_len);
+		tx_desc->buf_len = 0;
+		tx_desc->data_len = cpu_to_le16(param->arg_len);
+	}
+	dma_wmb();
+	tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));
+
+	txq->next_to_use =
+		NBL_NEXT_ID(txq->next_to_use, chan_info->num_txq_entries - 1);
+	txq->tail_ptr++;
+
+	return 0;
+}
+
+static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
+				 struct nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = chan_mgt->common->dev;
+	int max_retries = NBL_CHAN_TX_WAIT_TIMES;
+	struct nbl_chan_tx_desc *tx_desc;
+	int retry_count = 0;
+	u16 msg_type;
+
+	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
+				 txq->tail_ptr, NBL_MB_TX_QID);
+
+	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);
+	while (retry_count < max_retries) {
+		if (READ_ONCE(chan_info->shutdown))
+			return -ESHUTDOWN;
+
+		/* Ensure HW written descriptor visible to CPU */
+		smp_rmb();
+		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
+		    BIT(NBL_CHAN_TX_DESC_USED)) {
+			break;
+		}
+
+		retry_count++;
+		if (retry_count == max_retries) {
+			msg_type = le16_to_cpu(READ_ONCE(tx_desc->msg_type));
+			dev_err_ratelimited(dev, "chan send msg type: %d timeout\n",
+					    msg_type);
+			txq->next_to_clean = txq->next_to_use;
+			return -ETIMEDOUT;
+		}
+		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
+	}
+
+	txq->next_to_clean = txq->next_to_use;
+
+	return 0;
+}
+
+static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
+				  u32 data_len)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_waitqueue_head *wait_head = NULL;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_info *chan_info =
+		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
+	u32 ack_datalen, ack_msgtype = 0;
+	u32 *payload = data;
+	u16 ack_msgid = 0;
+	u32 copy_len;
+
+	if (READ_ONCE(chan_info->shutdown))
+		return;
+	if (data_len > NBL_CHAN_BUF_LEN ||
+	    data_len < NBL_CHAN_ACK_HEAD_LEN * sizeof(u32)) {
+		dev_err_ratelimited(dev, "Invalid ACK data_len: %u\n",
+				    data_len);
+		return;
+	}
+	ack_datalen = data_len - NBL_CHAN_ACK_HEAD_LEN * sizeof(u32);
+	ack_msgtype = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_TYPE_POS));
+	ack_msgid = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_ID_POS));
+	if (FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid) >=
+	    chan_info->num_txq_entries) {
+		dev_err_ratelimited(dev, "chan recv msg id: %d err\n",
+				    ack_msgid);
+		return;
+	}
+	wait_head =
+		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid)];
+	spin_lock_irq(&wait_head->status_lock);
+	if (srcid != READ_ONCE(wait_head->dstid)) {
+		/* Do not modify the status; the slot remains WAITING,
+		 * and the sender will time out normally
+		 */
+		spin_unlock_irq(&wait_head->status_lock);
+		dev_err_ratelimited(dev, "ACK srcid=%u != dstid=%u, rejecting\n",
+				    srcid, READ_ONCE(wait_head->dstid));
+		return;
+	}
+	if (READ_ONCE(wait_head->status) != NBL_MBX_STATUS_WAITING) {
+		spin_unlock_irq(&wait_head->status_lock);
+		dev_err_ratelimited(dev,
+				    "Skip ack with invalid status, wait msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
+				    READ_ONCE(wait_head->msg_type),
+				    READ_ONCE(wait_head->msg_index),
+				    READ_ONCE(wait_head->status),
+				    READ_ONCE(wait_head->ack_data_len),
+				    ack_msgtype, ack_msgid, ack_datalen);
+		return;
+	}
+
+	if (READ_ONCE(wait_head->msg_type) != ack_msgtype) {
+		spin_unlock_irq(&wait_head->status_lock);
+		dev_err_ratelimited(dev,
+				    "Skip ack msg type mismatch, wait msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
+				    READ_ONCE(wait_head->msg_type),
+				    READ_ONCE(wait_head->msg_index),
+				    READ_ONCE(wait_head->status),
+				    READ_ONCE(wait_head->ack_data_len),
+				    ack_msgtype, ack_msgid, ack_datalen);
+		return;
+	}
+	if (FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, ack_msgid) !=
+	    READ_ONCE(wait_head->msg_index)) {
+		spin_unlock_irq(&wait_head->status_lock);
+		dev_err_ratelimited(dev,
+				    "Stale ACK: expected index=%u, got msgid %u\n",
+				    READ_ONCE(wait_head->msg_index), ack_msgid);
+		return;
+	}
+
+	wait_head->ack_err =
+		(s32)le32_to_cpu(*(__le32 *)(payload + NBL_CHAN_ACK_RET_POS));
+
+	copy_len = min_t(u32, READ_ONCE(wait_head->ack_data_len), ack_datalen);
+	if (wait_head->ack_err >= 0 && copy_len > 0) {
+		if (!READ_ONCE(wait_head->ack_data)) {
+			dev_err_ratelimited(dev, "ACK payload dropped: ack_data is NULL\n");
+			wait_head->ack_data_len = 0;
+			goto ack_done;
+		}
+		memcpy((char *)wait_head->ack_data,
+		       payload + NBL_CHAN_ACK_HEAD_LEN, copy_len);
+		wait_head->ack_data_len = (u16)copy_len;
+	} else {
+		wait_head->ack_data_len = 0;
+	}
+ack_done:
+	WRITE_ONCE(wait_head->acked, 1);
+	spin_unlock_irq(&wait_head->status_lock);
+	if (READ_ONCE(wait_head->acked))
+		wake_up(&wait_head->wait_queue);
+}
+
+static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
+{
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_msg_node_data *msg_handler;
+	u16 msg_type, payload_len, srcid, msgid;
+	struct nbl_chan_info *chan_info =
+		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
+	struct nbl_chan_tx_desc *tx_desc;
+	void *payload;
+	size_t size;
+
+	if (READ_ONCE(chan_info->shutdown))
+		return;
+	tx_desc = data;
+	msg_type = le16_to_cpu(READ_ONCE(tx_desc->msg_type));
+	dev_dbg(dev, "recv msg_type: %d\n", msg_type);
+
+	srcid = le16_to_cpu(READ_ONCE(tx_desc->srcid));
+	msgid = le16_to_cpu(READ_ONCE(tx_desc->msgid));
+	/* Only check if the value exceeds the maximum, relying on the hash
+	 * table to filter invalid message IDs.
+	 * The gap values are reserved for future protocol extensions.
+	 */
+	if (msg_type >= NBL_CHAN_MSG_MAILBOX_MAX)
+		return;
+
+	if (le16_to_cpu(READ_ONCE(tx_desc->data_len))) {
+		payload_len = le16_to_cpu(READ_ONCE(tx_desc->data_len));
+		if (payload_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+			dev_err_ratelimited(dev,
+					    "data_len=%u exceeds embedded buffer size=%u\n",
+					    payload_len,
+					    NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN);
+			return;
+		}
+		payload = tx_desc->data;
+	} else {
+		payload_len = le16_to_cpu(READ_ONCE(tx_desc->buf_len));
+		size = NBL_CHAN_BUF_LEN - sizeof(*tx_desc);
+		if (payload_len > size) {
+			dev_err_ratelimited(dev,
+					    "buf_len=%u exceeds external buffer size=%zu\n",
+					    payload_len,
+					    size);
+			return;
+		}
+		payload = tx_desc + 1;
+	}
+
+	msg_handler =
+		nbl_common_get_hash_node(chan_mgt->handle_hash_tbl, &msg_type);
+	if (!msg_handler || !msg_handler->func) {
+		dev_err_ratelimited(dev,
+				    "No handler for msg_type: %u (srcid=%u, msgid=%u)\n",
+				    msg_type, srcid, msgid);
+		return;
+	}
+	msg_handler->func(msg_handler->priv, srcid, msgid, payload,
+			  payload_len);
+}
+
+static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
+				     struct nbl_chan_info *chan_info,
+				     struct nbl_chan_ring *rxq)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_chan_buf *rx_buf;
+	u16 next_to_use;
+
+	next_to_use = rxq->next_to_use;
+	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_use);
+	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_use);
+
+	rx_desc->buf_addr = cpu_to_le64(rx_buf->pa);
+	rx_desc->buf_len = cpu_to_le32(chan_info->rxq_buf_size);
+
+	/*
+	 * DMA Write Memory Barrier:
+	 * Ensures all previous DMA-mapped writes (buffer address/length)
+	 * are completed before the descriptor flags are updated.
+	 * This prevents hardware from seeing a partially updated descriptor
+	 * where flags are set but buffer info isn't ready yet.
+	 */
+	dma_wmb();
+
+	rx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
+
+	rxq->next_to_use++;
+	if (rxq->next_to_use == chan_info->num_rxq_entries)
+		rxq->next_to_use = 0;
+	rxq->tail_ptr++;
+
+	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
+				 rxq->tail_ptr, NBL_MB_RX_QID);
+}
+
+static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
+				 struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_chan_buf *rx_buf;
+	u16 next_to_clean;
+	u32 budget = 64;
+	u16 flags;
+
+	next_to_clean = rxq->next_to_clean;
+	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+	while (le16_to_cpu(READ_ONCE(rx_desc->flags)) &
+	       BIT(NBL_CHAN_RX_DESC_USED)) {
+		flags = le16_to_cpu(READ_ONCE(rx_desc->flags));
+
+		if (READ_ONCE(chan_info->shutdown))
+			break;
+		if (!(flags & BIT(NBL_CHAN_RX_DESC_WRITE)))
+			dev_dbg(dev,
+				"mailbox rx flag 0x%x missing NBL_CHAN_RX_DESC_WRITE\n",
+				flags);
+
+		dma_rmb();
+		nbl_chan_recv_msg(chan_mgt, rx_buf->va);
+		nbl_chan_advance_rx_ring(chan_mgt, chan_info, rxq);
+		next_to_clean++;
+		if (next_to_clean == chan_info->num_rxq_entries)
+			next_to_clean = 0;
+		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+		if (--budget == 0)
+			break;
+		cond_resched();
+	}
+	rxq->next_to_clean = next_to_clean;
+}
+
+static void nbl_chan_clean_queue_subtask(struct nbl_channel_mgt *chan_mgt,
+					 u8 chan_type)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	nbl_chan_clean_queue(chan_mgt, chan_info);
+}
+
+static int nbl_chan_get_msg_id(struct nbl_chan_info *chan_info,
+			       u16 *msgid)
+{
+	int search_loc = chan_info->wait_head_index, i;
+	struct nbl_chan_waitqueue_head *wait = NULL;
+	int status;
+
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		wait = &chan_info->wait[search_loc];
+
+		spin_lock_irq(&wait->status_lock);
+		status = READ_ONCE(wait->status);
+		if (status == NBL_MBX_STATUS_IDLE ||
+		    status == NBL_MBX_STATUS_TIMEOUT) {
+			WRITE_ONCE(wait->msg_index,
+				   NBL_NEXT_ID(wait->msg_index,
+					       NBL_CHAN_MSG_INDEX_MAX));
+
+			*msgid = FIELD_PREP(NBL_CHAN_MSGID_INDEX_MASK,
+					    wait->msg_index) |
+				 FIELD_PREP(NBL_CHAN_MSGID_LOC_MASK,
+					    search_loc);
+			spin_unlock_irq(&wait->status_lock);
+
+			/* Advance starting search position for next caller */
+			WRITE_ONCE(chan_info->wait_head_index, search_loc);
+			return 0;
+		}
+		spin_unlock_irq(&wait->status_lock);
+
+		search_loc = NBL_NEXT_ID(search_loc,
+					 chan_info->num_txq_entries - 1);
+	}
+
+	/*
+	 * All tx slots are occupied. May happen under high transmit load
+	 * or delayed remote ACK responses. Caller should retry later.
+	 */
+	return -EAGAIN;
+}
+
+static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
+			     struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_waitqueue_head *wait_head;
+	struct nbl_chan_tx_param tx_param = { 0 };
+	struct nbl_chan_info *chan_info =
+		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
+	struct device *dev = common->dev;
+	bool inflight_inc = false;
+	u16 msgid = 0;
+	int ret;
+	u16 tmp;
+
+	if (chan_send->resp_len > NBL_CHAN_BUF_LEN) {
+		dev_err_ratelimited(dev, "resp_len %zu exceeds max %d\n",
+				    chan_send->resp_len, NBL_CHAN_BUF_LEN);
+		return -EINVAL;
+	}
+
+	atomic_inc(&chan_info->inflight_tx_cnt);
+	inflight_inc = true;
+	/*
+	 * Ensure reading chan_info->shutdown happens
+	 * strictly after inflight_tx_cnt increment above on this CPU.
+	 * Prevent compiler/cpu reordering: read shutdown before incrementing
+	 * inflight counter, which would cause missing shutdown check and leak
+	 * tx inflight count.
+	 */
+	smp_rmb();
+	if (READ_ONCE(chan_info->shutdown)) {
+		atomic_dec(&chan_info->inflight_tx_cnt);
+		return -ESHUTDOWN;
+	}
+
+	mutex_lock(&chan_info->txq_lock);
+	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state)) {
+		ret = -EIO;
+		goto unlock_out;
+	}
+	ret = nbl_chan_get_msg_id(chan_info, &msgid);
+	if (ret) {
+		dev_err_ratelimited(dev,
+				    "Channel tx wait head full, send msgtype:%u to dstid:%u failed\n",
+				    chan_send->msg_type, chan_send->dstid);
+		goto unlock_out;
+	}
+
+	tx_param.msg_type = chan_send->msg_type;
+	tx_param.arg = chan_send->arg;
+	tx_param.arg_len = chan_send->arg_len;
+	tx_param.dstid = chan_send->dstid;
+	tx_param.msgid = msgid;
+
+	ret = nbl_chan_update_txqueue(chan_mgt, chan_info, &tx_param);
+	if (ret) {
+		dev_err_ratelimited(dev,
+				    "Channel tx queue full, send msgtype:%u to dstid:%u failed\n",
+				    chan_send->msg_type, chan_send->dstid);
+		goto unlock_out;
+	}
+
+	wait_head =
+		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, msgid)];
+	spin_lock_irq(&wait_head->status_lock);
+	WRITE_ONCE(wait_head->acked, 0);
+	WRITE_ONCE(wait_head->ack_data, chan_send->resp);
+	WRITE_ONCE(wait_head->ack_data_len, chan_send->resp_len);
+	WRITE_ONCE(wait_head->msg_type, chan_send->msg_type);
+	WRITE_ONCE(wait_head->msg_index,
+		   FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, msgid));
+	WRITE_ONCE(wait_head->dstid, chan_send->dstid);
+
+	WRITE_ONCE(wait_head->status, chan_send->ack ?
+		   NBL_MBX_STATUS_WAITING : NBL_MBX_STATUS_IDLE);
+	spin_unlock_irq(&wait_head->status_lock);
+
+	ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
+	if (ret) {
+		spin_lock_irq(&wait_head->status_lock);
+		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_TIMEOUT);
+		WRITE_ONCE(wait_head->acked, 0);
+		WRITE_ONCE(wait_head->ack_data, NULL);
+		WRITE_ONCE(wait_head->ack_data_len, 0);
+		spin_unlock_irq(&wait_head->status_lock);
+		goto unlock_out;
+	}
+	mutex_unlock(&chan_info->txq_lock);
+	if (!chan_send->ack) {
+		tmp = FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, msgid);
+		wait_head = &chan_info->wait[tmp];
+		spin_lock_irq(&wait_head->status_lock);
+		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_IDLE);
+		spin_unlock_irq(&wait_head->status_lock);
+		atomic_dec(&chan_info->inflight_tx_cnt);
+		return 0;
+	}
+
+	/* choose wait strategy based on interrupt state */
+	if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
+		spin_lock_irq(&wait_head->status_lock);
+		while (!READ_ONCE(wait_head->acked)) {
+			spin_unlock_irq(&wait_head->status_lock);
+			ret = wait_event_timeout(wait_head->wait_queue,
+						 READ_ONCE(wait_head->acked) ||
+						 READ_ONCE(chan_info->shutdown),
+						 NBL_CHAN_ACK_WAIT_TIME);
+			spin_lock_irq(&wait_head->status_lock);
+
+			if (READ_ONCE(chan_info->shutdown)) {
+				ret = -ESHUTDOWN;
+				WRITE_ONCE(wait_head->ack_data, NULL);
+				WRITE_ONCE(wait_head->ack_data_len, 0);
+				WRITE_ONCE(wait_head->status,
+					   NBL_MBX_STATUS_IDLE);
+				spin_unlock_irq(&wait_head->status_lock);
+				goto inflight_dec_out;
+			}
+			if (ret == 0) {
+				if (READ_ONCE(wait_head->status) ==
+				    NBL_MBX_STATUS_WAITING) {
+					WRITE_ONCE(wait_head->status,
+						   NBL_MBX_STATUS_TIMEOUT);
+					WRITE_ONCE(wait_head->acked, 0);
+					WRITE_ONCE(wait_head->ack_data, NULL);
+					WRITE_ONCE(wait_head->ack_data_len, 0);
+				}
+				spin_unlock_irq(&wait_head->status_lock);
+				dev_err_ratelimited(dev,
+						    "Channel waiting ack failed, message type: %d, msg id: %u\n",
+						    chan_send->msg_type, msgid);
+				ret = -ETIMEDOUT;
+				goto inflight_dec_out;
+			}
+
+			if (READ_ONCE(wait_head->acked))
+				break;
+		}
+
+		chan_send->ack_len = wait_head->ack_data_len;
+		ret = wait_head->ack_err;
+		WRITE_ONCE(wait_head->acked, 0);
+		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_IDLE);
+		WRITE_ONCE(wait_head->ack_data, NULL);
+		WRITE_ONCE(wait_head->ack_data_len, 0);
+		spin_unlock_irq(&wait_head->status_lock);
+		goto inflight_dec_out;
+	}
+
+inflight_dec_out:
+	atomic_dec(&chan_info->inflight_tx_cnt);
+	return ret;
+
+unlock_out:
+	mutex_unlock(&chan_info->txq_lock);
+	if (inflight_inc)
+		atomic_dec(&chan_info->inflight_tx_cnt);
+	return ret;
+}
+
+static int nbl_chan_send_ack(struct nbl_channel_mgt *chan_mgt,
+			     struct nbl_chan_ack_info *chan_ack)
+{
+	size_t head_len = NBL_CHAN_ACK_HEAD_LEN * sizeof(u32);
+	size_t data_len = chan_ack->data_len;
+	struct nbl_chan_send_info chan_send;
+	__le32 *tmp;
+	size_t len;
+	int ret;
+
+	if (data_len >
+	    NBL_CHAN_BUF_LEN - sizeof(struct nbl_chan_tx_desc) - head_len)
+		return -EINVAL;
+
+	len = head_len + data_len;
+	tmp = kzalloc(len, GFP_ATOMIC);
+	if (!tmp)
+		return -ENOMEM;
+
+	*(__le16 *)&tmp[NBL_CHAN_MSG_TYPE_POS] =
+		cpu_to_le16(chan_ack->msg_type);
+	*(__le16 *)&tmp[NBL_CHAN_MSG_ID_POS] = cpu_to_le16(chan_ack->msgid);
+	tmp[NBL_CHAN_ACK_RET_POS] = cpu_to_le32(chan_ack->err);
+	if (chan_ack->data && chan_ack->data_len)
+		memcpy(&tmp[NBL_CHAN_ACK_HEAD_LEN], chan_ack->data,
+		       chan_ack->data_len);
+
+	nbl_chan_fill_send_info(&chan_send, chan_ack->dstid, NBL_CHAN_MSG_ACK,
+				tmp, len, NULL, 0, 0);
+	ret = nbl_chan_send_msg(chan_mgt, &chan_send);
+	kfree(tmp);
+
+	return ret;
+}
+
+static int nbl_chan_register_msg(struct nbl_channel_mgt *chan_mgt, u16 msg_type,
+				 nbl_chan_resp func, void *callback)
+{
+	return nbl_chan_add_msg_handler(chan_mgt, msg_type, func, callback);
+}
+
+static bool nbl_chan_check_queue_exist(struct nbl_channel_mgt *chan_mgt,
+				       u8 chan_type)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	return chan_info ? true : false;
+}
+
+static void nbl_chan_register_chan_task(struct nbl_channel_mgt *chan_mgt,
+					u8 chan_type, struct work_struct *task)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	chan_info->clean_task = task;
+}
+
+static void nbl_chan_set_queue_state(struct nbl_channel_mgt *chan_mgt,
+				     enum nbl_chan_state state, u8 chan_type,
+				     u8 set)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	if (set)
+		set_bit(state, chan_info->state);
+	else
+		clear_bit(state, chan_info->state);
+}
+
+static struct nbl_channel_ops chan_ops = {
+	.send_msg			= nbl_chan_send_msg,
+	.send_ack			= nbl_chan_send_ack,
+	.register_msg			= nbl_chan_register_msg,
+	.unregister_all_msg		= nbl_chan_remove_msg_handler,
+	.cfg_chan_qinfo_map_table	= nbl_chan_cfg_qinfo_map_table,
+	.check_queue_exist		= nbl_chan_check_queue_exist,
+	.setup_queue			= nbl_chan_setup_queue,
+	.teardown_queue			= nbl_chan_teardown_queue,
+	.clean_queue_subtask		= nbl_chan_clean_queue_subtask,
+	.register_chan_task		= nbl_chan_register_chan_task,
+	.set_queue_state		= nbl_chan_set_queue_state,
+};
+
+static struct nbl_channel_mgt *
+nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter)
+{
+	struct nbl_hw_ops_tbl *hw_ops_tbl = adapter->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adapter->common;
+	struct device *dev = &adapter->pdev->dev;
+	struct nbl_channel_mgt *chan_mgt;
+	struct nbl_chan_info *mailbox;
+	int ret;
+
+	chan_mgt = devm_kzalloc(dev, sizeof(*chan_mgt), GFP_KERNEL);
+	if (!chan_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	chan_mgt->common = common;
+	chan_mgt->hw_ops_tbl = hw_ops_tbl;
+
+	mailbox = devm_kzalloc(dev, sizeof(*mailbox), GFP_KERNEL);
+	if (!mailbox)
+		return ERR_PTR(-ENOMEM);
+	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
+	chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX] = mailbox;
+
+	ret = nbl_chan_init_msg_handler(chan_mgt);
+	if (ret)
+		return ERR_PTR(-ENOMEM);
+
+	return chan_mgt;
+}
+
+static struct nbl_channel_ops_tbl *
+nbl_chan_setup_ops(struct device *dev, struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	int ret;
+
+	chan_ops_tbl = devm_kzalloc(dev, sizeof(*chan_ops_tbl), GFP_KERNEL);
+	if (!chan_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+	if (!chan_ops.send_msg || !chan_ops.send_ack ||
+	    !chan_ops.register_msg || !chan_ops.unregister_all_msg ||
+	    !chan_ops.cfg_chan_qinfo_map_table ||
+	    !chan_ops.check_queue_exist || !chan_ops.setup_queue ||
+	    !chan_ops.teardown_queue || !chan_ops.clean_queue_subtask ||
+	    !chan_ops.register_chan_task || !chan_ops.set_queue_state)
+		return ERR_PTR(-EINVAL);
+
+	chan_ops_tbl->ops = &chan_ops;
+	chan_ops_tbl->priv = chan_mgt;
+
+	ret = nbl_chan_register_msg(chan_mgt, NBL_CHAN_MSG_ACK,
+				    nbl_chan_recv_ack_msg, chan_mgt);
+	if (ret)
+		return ERR_PTR(-ENOMEM);
+
+	return chan_ops_tbl;
+}
+
+int nbl_chan_init_common(struct nbl_adapter *adap)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct device *dev = &adap->pdev->dev;
+	struct nbl_channel_mgt *chan_mgt;
+	int ret;
+
+	chan_mgt = nbl_chan_setup_chan_mgt(adap);
+	if (IS_ERR(chan_mgt)) {
+		ret = PTR_ERR(chan_mgt);
+		goto exit;
+	}
+
+	chan_ops_tbl = nbl_chan_setup_ops(dev, chan_mgt);
+	if (IS_ERR(chan_ops_tbl)) {
+		ret = PTR_ERR(chan_ops_tbl);
+		goto cleanup_mgt;
+	}
+	adap->intf.channel_ops_tbl = chan_ops_tbl;
+	adap->core.chan_mgt = chan_mgt;
+	return 0;
+
+cleanup_mgt:
+	nbl_chan_remove_msg_handler(chan_mgt);
+exit:
+	return ret;
+}
+
+void nbl_chan_remove_common(struct nbl_adapter *adap)
+{
+	struct nbl_channel_mgt *chan_mgt = adap->core.chan_mgt;
+
+	if (!chan_mgt)
+		return;
+
+	/*
+	 * All channel queues shall be torn down earlier in remove path
+	 * to drain inflight tx workers and stop hardware before destroying
+	 * message handler hash table.
+	 */
+	nbl_chan_remove_msg_handler(chan_mgt);
+	adap->core.chan_mgt = NULL;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
new file mode 100644
index 000000000000..92db39e1b05e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CHANNEL_H_
+#define _NBL_CHANNEL_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+#define NBL_CHAN_TX_RING_TO_DESC(tx_ring, i) \
+	(&((((tx_ring)->desc.tx_desc))[i]))
+#define NBL_CHAN_RX_RING_TO_DESC(rx_ring, i) \
+	(&((((rx_ring)->desc.rx_desc))[i]))
+#define NBL_CHAN_TX_RING_TO_BUF(tx_ring, i) (&(((tx_ring)->buf)[i]))
+#define NBL_CHAN_RX_RING_TO_BUF(rx_ring, i) (&(((rx_ring)->buf)[i]))
+
+#define NBL_CHAN_TX_WAIT_US			100
+#define NBL_CHAN_TX_WAIT_US_MAX			120
+#define NBL_CHAN_TX_WAIT_TIMES			100
+#define NBL_CHAN_QUEUE_LEN			256
+#define NBL_CHAN_BUF_LEN			4096
+#define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
+
+#define NBL_CHAN_TX_DESC_AVAIL			0
+#define NBL_CHAN_TX_DESC_USED			1
+#define NBL_CHAN_RX_DESC_WRITE			1
+#define NBL_CHAN_RX_DESC_AVAIL			3
+#define NBL_CHAN_RX_DESC_USED			4
+
+#define NBL_CHAN_ACK_HEAD_LEN			3
+#define NBL_CHAN_ACK_RET_POS			2
+#define NBL_CHAN_MSG_ID_POS			1
+#define NBL_CHAN_MSG_TYPE_POS			0
+
+#define NBL_CHAN_ACK_WAIT_TIME			(3 * HZ)
+
+#define NBL_CHAN_HANDLER_TBL_BUCKET_SIZE	512
+
+enum {
+	NBL_MB_RX_QID = 0,
+	NBL_MB_TX_QID = 1,
+};
+
+enum {
+	NBL_MBX_STATUS_IDLE = 0,
+	NBL_MBX_STATUS_WAITING,
+	NBL_MBX_STATUS_TIMEOUT,
+};
+
+struct nbl_chan_tx_param {
+	enum nbl_chan_msg_type msg_type;
+	void *arg;
+	size_t arg_len;
+	u16 dstid;
+	u16 msgid;
+};
+
+struct nbl_chan_buf {
+	void *va;
+	dma_addr_t pa;
+	size_t size;
+};
+
+struct nbl_chan_tx_desc {
+	__le16 flags;
+	__le16 srcid;
+	__le16 dstid;
+	__le16 data_len;
+	__le16 buf_len;
+	__le64 buf_addr;
+	__le16 msg_type;
+	u8 data[16];
+	__le16 msgid;
+	u8 rsv[26];
+} __packed;
+
+struct nbl_chan_rx_desc {
+	__le16 flags;
+	__le32 buf_len;
+	__le16 buf_id;
+	__le64 buf_addr;
+} __packed;
+
+union nbl_chan_desc_ptr {
+	struct nbl_chan_tx_desc *tx_desc;
+	struct nbl_chan_rx_desc *rx_desc;
+};
+
+struct nbl_chan_ring {
+	union nbl_chan_desc_ptr desc;
+	struct nbl_chan_buf *buf;
+	u16 next_to_use;
+	u16 tail_ptr; /* hardware does modulo ring size internally */
+	u16 next_to_clean;
+	dma_addr_t dma;
+};
+
+#define NBL_CHAN_MSG_INDEX_MAX 63
+
+#define NBL_CHAN_MSGID_INDEX_MASK GENMASK(5, 0)
+#define NBL_CHAN_MSGID_LOC_MASK GENMASK(13, 6)
+
+static inline void nbl_chan_update_tail_ptr(struct nbl_hw_ops *hw_ops,
+					    void *hw_priv, u32 tail_ptr, u8 qid)
+{
+	hw_ops->update_mailbox_queue_tail_ptr(hw_priv, tail_ptr, qid);
+}
+
+struct nbl_chan_waitqueue_head {
+	struct wait_queue_head wait_queue;
+	char *ack_data;
+	int acked;
+	s32 ack_err;
+	u16 ack_data_len;
+	u16 msg_type;
+	/*
+	 * Spinlock protecting all fields.
+	 * Must be held when reading/writing: status, acked, ack_err,
+	 * ack_data_len, etc.
+	 * The lock ensures atomic updates of these fields and
+	 * proper memory ordering with smp_wmb()/smp_rmb().
+	 */
+	spinlock_t status_lock;
+	int status;
+	u8 msg_index;
+	u16 dstid;
+};
+
+struct nbl_chan_info {
+	struct nbl_chan_ring txq;
+	struct nbl_chan_ring rxq;
+	struct nbl_chan_waitqueue_head *wait;
+	/*
+	 *Protects access to the TX queue (txq) and related metadata.
+	 *This mutex ensures exclusive access when updating the TX queue
+	 */
+	struct mutex txq_lock;
+	struct work_struct *clean_task;
+	u16 wait_head_index;
+	u16 num_txq_entries;
+	u16 num_rxq_entries;
+	u16 txq_buf_size;
+	u16 rxq_buf_size;
+	DECLARE_BITMAP(state, NBL_CHAN_STATE_NBITS);
+	u8 chan_type;
+	atomic_t inflight_tx_cnt;
+	bool shutdown;
+	bool init_done;
+};
+
+struct nbl_chan_msg_node_data {
+	nbl_chan_resp func;
+	void *priv;
+};
+
+struct nbl_channel_mgt {
+	struct nbl_common_info *common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_chan_info *chan_info[NBL_CHAN_TYPE_MAX];
+	struct nbl_hash_tbl_mgt *handle_hash_tbl;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
new file mode 100644
index 000000000000..fc9b489ca02c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#include <linux/device.h>
+#include <linux/jhash.h>
+#include "nbl_common.h"
+
+static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
+{
+	u32 hash;
+
+	if (bucket_size == 0 || bucket_size == NBL_HASH_TBL_LIST_BUCKET_SIZE)
+		return 0;
+
+	hash = jhash(key, key_size, 0);
+
+	/* Use bitmask if bucket_size is a power of 2 */
+	if ((bucket_size & (bucket_size - 1)) == 0)
+		return hash & (bucket_size - 1);
+	else
+		return hash % bucket_size;
+}
+
+/*
+ * alloc a hash table
+ * the table support multi thread
+ */
+struct nbl_hash_tbl_mgt *
+nbl_common_init_hash_table(struct nbl_hash_tbl_key *key)
+{
+	struct nbl_hash_tbl_mgt *tbl_mgt;
+	int bucket_size;
+	int i;
+
+	tbl_mgt = devm_kzalloc(key->dev, sizeof(*tbl_mgt), GFP_KERNEL);
+	if (!tbl_mgt)
+		return NULL;
+
+	bucket_size = key->bucket_size;
+	tbl_mgt->hash = devm_kcalloc(key->dev, bucket_size,
+				     sizeof(struct hlist_head), GFP_KERNEL);
+	if (!tbl_mgt->hash)
+		goto alloc_hash_failed;
+
+	for (i = 0; i < bucket_size; i++)
+		INIT_HLIST_HEAD(tbl_mgt->hash + i);
+
+	memcpy(&tbl_mgt->tbl_key, key, sizeof(struct nbl_hash_tbl_key));
+
+	return tbl_mgt;
+
+alloc_hash_failed:
+	return NULL;
+}
+
+/*
+ * Allocate a hash node and add to the hash table.
+ *
+ * Note: The hash table is protected by the caller's mutex (txq_lock),
+ * not lock-free. The "single context" comment refers to: this function
+ * is only called during init from nbl_chan_init_msg_handler, so there
+ * is no concurrent mutation during init.
+ * After init, the table is read-only (no unregister API), so no lock is needed
+ * for lookups either.
+ *
+ * The tbl_mgt and bucket array are devm-allocated, so they are automatically
+ * freed on device detach. Only the hash nodes themselves need explicit cleanup.
+ */
+int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
+			       void *data, void **out_data)
+{
+	struct nbl_hash_entry_node *hash_node;
+	u16 data_size;
+	u16 node_size;
+	u32 hash_val;
+	u16 key_size;
+
+	node_size = sizeof(*hash_node);
+	hash_node = kzalloc(node_size, GFP_KERNEL);
+	if (!hash_node)
+		return -ENOMEM;
+
+	key_size = tbl_mgt->tbl_key.key_size;
+	hash_node->key = kzalloc(key_size, GFP_KERNEL);
+	if (!hash_node->key)
+		goto alloc_key_failed;
+
+	data_size = tbl_mgt->tbl_key.data_size;
+	hash_node->data = kzalloc(data_size, GFP_KERNEL);
+	if (!hash_node->data)
+		goto alloc_data_failed;
+
+	memcpy(hash_node->key, key, key_size);
+	memcpy(hash_node->data, data, data_size);
+
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+
+	hlist_add_head(&hash_node->node, tbl_mgt->hash + hash_val);
+	tbl_mgt->node_num++;
+	if (out_data)
+		*out_data = hash_node->data;
+
+	return 0;
+
+alloc_data_failed:
+	kfree(hash_node->key);
+alloc_key_failed:
+	kfree(hash_node);
+	return -ENOMEM;
+}
+
+/*
+ * get a hash node, return the data if node exist
+ */
+void *nbl_common_get_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key)
+{
+	struct nbl_hash_entry_node *hash_node;
+	struct hlist_head *head;
+	void *data = NULL;
+	u32 hash_val;
+	u16 key_size;
+
+	key_size = tbl_mgt->tbl_key.key_size;
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+	head = tbl_mgt->hash + hash_val;
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->key, key, key_size)) {
+			data = hash_node->data;
+			break;
+		}
+
+	return data;
+}
+
+static void nbl_common_detach_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt,
+					struct nbl_hash_entry_node *hash_node)
+{
+	hlist_del(&hash_node->node);
+	kfree(hash_node->key);
+	kfree(hash_node->data);
+	kfree(hash_node);
+	tbl_mgt->node_num--;
+}
+
+/*
+ * Free all hash nodes in the table.
+ */
+void nbl_common_remove_hash_table(struct nbl_hash_tbl_mgt *tbl_mgt)
+{
+	struct nbl_hash_entry_node *hash_node;
+	struct hlist_node *safe_node;
+	struct hlist_head *head;
+	u32 i;
+
+	for (i = 0; i < tbl_mgt->tbl_key.bucket_size; i++) {
+		head = tbl_mgt->hash + i;
+		hlist_for_each_entry_safe(hash_node, safe_node, head, node) {
+			nbl_common_detach_hash_node(tbl_mgt, hash_node);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
new file mode 100644
index 000000000000..ad8fb7ec9f45
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_COMMON_H_
+#define _NBL_COMMON_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_common.h"
+
+/* list only need one bucket size */
+#define NBL_HASH_TBL_LIST_BUCKET_SIZE 1
+
+struct nbl_hash_tbl_mgt {
+	struct nbl_hash_tbl_key tbl_key;
+	struct hlist_head *hash;
+	u16 node_num;
+};
+
+struct nbl_hash_entry_node {
+	struct hlist_node node;
+	void *key;
+	void *data;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index e2e33fbb848a..66861d684220 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -14,13 +14,20 @@ enum {
 	NBL_CAP_HAS_NET_BIT,
 };
 
+struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_channel_ops_tbl *channel_ops_tbl;
+};
+
 struct nbl_core {
 	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_channel_mgt *chan_mgt;
 };
 
 struct nbl_adapter {
 	struct pci_dev *pdev;
 	struct nbl_core core;
+	struct nbl_interface intf;
 	struct nbl_common_info common;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index d66d7ca8a2bb..7faac0718038 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -10,6 +10,150 @@
 #include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  const u32 *data, u32 len)
+{
+	u32 i;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), data[i]);
+}
+
+static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+				u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+
+	spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++)
+		data[i] = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_hw_wr_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				const u32 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	spin_lock(&hw_mgt->reg_lock);
+	for (i = 0; i < size; i++)
+		wr32(hw_mgt->hw_addr, reg + i * sizeof(u32), data[i]);
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
+						 u16 tail_ptr, u8 txrx)
+{
+	/* local_qid 0 and 1 denote rx and tx queue respectively */
+	u32 local_qid = txrx;
+	u32 value = ((u32)tail_ptr << 16) | local_qid;
+
+	/* wmb for doorbell */
+	wmb();
+	nbl_mbx_wr32(hw_mgt, NBL_MAILBOX_NOTIFY_ADDR, value);
+}
+
+static void nbl_hw_config_mailbox_rxq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+
+	cfg_tbl.data[0] = lower_32_bits(dma_addr);
+	cfg_tbl.data[1] = upper_32_bits(dma_addr);
+	cfg_tbl.data[2] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK,
+				     size_bwid);
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
+			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_config_mailbox_txq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+
+	cfg_tbl.data[0] = lower_32_bits(dma_addr);
+	cfg_tbl.data[1] = upper_32_bits(dma_addr);
+	cfg_tbl.data[2] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK,
+				     size_bwid);
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
+			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_stop_mailbox_rxq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_stop_mailbox_txq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask)
+{
+	nbl_hw_rd_regs_lock(hw_mgt, NBL_PCIE_HOST_K_PF_MASK_REG, pf_mask,
+			    sizeof(*pf_mask));
+}
+
+static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				     u8 bus, u8 devid, u8 function)
+{
+	u32 data = 0;
+
+	data = FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
+	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
+	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+			    &data,
+			    sizeof(data));
+}
+
+static struct nbl_hw_ops hw_ops = {
+	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
+	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
+	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
+	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
+	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
+	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+
+};
+
 /* Structure starts here, adding an op should not modify anything below */
 static struct nbl_hw_mgt *nbl_hw_setup_hw_mgt(struct nbl_common_info *common)
 {
@@ -25,6 +169,27 @@ static struct nbl_hw_mgt *nbl_hw_setup_hw_mgt(struct nbl_common_info *common)
 	return hw_mgt;
 }
 
+static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
+					       struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct device *dev;
+
+	dev = common->dev;
+	hw_ops_tbl = devm_kzalloc(dev, sizeof(*hw_ops_tbl), GFP_KERNEL);
+	if (!hw_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+	if (!hw_ops.update_mailbox_queue_tail_ptr ||
+	    !hw_ops.config_mailbox_rxq || !hw_ops.config_mailbox_txq ||
+	    !hw_ops.stop_mailbox_rxq || !hw_ops.stop_mailbox_txq ||
+	    !hw_ops.get_host_pf_mask || !hw_ops.cfg_mailbox_qinfo)
+		return ERR_PTR(-EINVAL);
+	hw_ops_tbl->ops = &hw_ops;
+	hw_ops_tbl->priv = hw_mgt;
+
+	return hw_ops_tbl;
+}
+
 static int nbl_pcim_request_selected_bars(struct pci_dev *pdev, u32 mask,
 					  const char *name)
 {
@@ -45,6 +210,7 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 {
 	struct nbl_common_info *common = &adapter->common;
 	struct pci_dev *pdev = common->pdev;
+	struct nbl_hw_ops_tbl *hw_ops_tbl = NULL;
 	struct nbl_hw_mgt *hw_mgt = NULL;
 	resource_size_t bar_len;
 	u32 bar_mask;
@@ -136,6 +302,14 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 		goto setup_mgt_fail;
 	}
 
+	spin_lock_init(&hw_mgt->reg_lock);
+
+	hw_ops_tbl = nbl_hw_setup_ops(common, hw_mgt);
+	if (IS_ERR(hw_ops_tbl)) {
+		ret = PTR_ERR(hw_ops_tbl);
+		goto setup_mgt_fail;
+	}
+	adapter->intf.hw_ops_tbl = hw_ops_tbl;
 	adapter->core.hw_mgt = hw_mgt;
 
 	return 0;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 77c67b67ba31..1d2dd10e6239 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -11,4 +11,60 @@
 #include "../../nbl_include/nbl_include.h"
 #include "../nbl_hw_reg.h"
 
+/*  ----------  REG BASE ADDR  ----------  */
+/* Interface modules base addr */
+#define NBL_INTF_HOST_PCOMPLETER_BASE		0x00f08000
+#define NBL_INTF_HOST_PADPT_BASE		0x00f4c000
+#define NBL_INTF_HOST_MAILBOX_BASE		0x00fb0000
+#define NBL_INTF_HOST_PCIE_BASE			0X01504000
+/* DP modules base addr */
+#define NBL_DP_USTORE_BASE			0x00104000
+#define NBL_DP_UQM_BASE				0x00114000
+#define NBL_DP_UPED_BASE			0x0015c000
+#define NBL_DP_UVN_BASE				0x00244000
+#define NBL_DP_DSCH_BASE			0x00404000
+#define NBL_DP_SHAPING_BASE			0x00504000
+#define NBL_DP_DVN_BASE				0x00514000
+#define NBL_DP_DSTORE_BASE			0x00704000
+#define NBL_DP_DQM_BASE				0x00714000
+#define NBL_DP_DPED_BASE			0x0075c000
+#define NBL_DP_DDMUX_BASE			0x00984000
+/*  --------  MAILBOX BAR2 -----  */
+#define NBL_MAILBOX_NOTIFY_ADDR			0x00000000
+#define NBL_MAILBOX_BAR_REG			0x00000000
+#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	0x10
+#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	0x20
+#define NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR	0x30
+
+/*  --------  MAILBOX  --------  */
+
+/* mailbox BAR qinfo_cfg_table */
+#define MAILBOX_QINFO_CFG_TABLE_DWLEN	4
+/* data[2] */
+#define NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK	GENMASK(3, 0)
+/* data[3] */
+#define NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK		BIT(0)
+#define NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK		BIT(1)
+#define NBL_MAILBOX_QINFO_CFG_DIF_ERR_MASK		BIT(2)
+#define NBL_MAILBOX_QINFO_CFG_PTR_ERR_MASK		BIT(3)
+struct nbl_mailbox_qinfo_cfg_table {
+	u32 data[MAILBOX_QINFO_CFG_TABLE_DWLEN];
+};
+
+/*  --------  MAILBOX BAR0 -----  */
+/* mailbox qinfo_map_table */
+#define NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id) \
+	(NBL_INTF_HOST_MAILBOX_BASE + 0x00001000 + (func_id) * sizeof(u32))
+
+/* MAILBOX qinfo_map_table */
+#define NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK		GENMASK(2, 0)
+#define NBL_MAILBOX_QINFO_MAP_DEVID_MASK		GENMASK(7, 3)
+#define NBL_MAILBOX_QINFO_MAP_BUS_MASK			GENMASK(15, 8)
+#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK		GENMASK(28, 16)
+#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK	BIT(29)
+
+/*  --------  HOST_PCIE  --------  */
+#define NBL_PCIE_HOST_K_PF_MASK_REG (NBL_INTF_HOST_PCIE_BASE + 0x00001004)
+#define NBL_PCIE_HOST_TL_CFG_BUSDEV (NBL_INTF_HOST_PCIE_BASE + 0x11040)
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
index 1a199357e85f..0026cee101aa 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 
+#include "../nbl_include/nbl_def_channel.h"
 #include "../nbl_include/nbl_def_hw.h"
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
@@ -16,6 +17,7 @@
 #define NBL_MAILBOX_BAR				2
 #define NBL_RDMA_NOTIFY_LEN			(8ULL << 10)
 #define NBL_REG_NET_ONLY_LEN			(8ULL << 10)
+#define NBL_HW_DUMMY_REG			0x1300904
 /*
  * PCI MEMORY BAR total size: 64MiB.
  * First 32MiB: module registers + table entry address range.
@@ -28,6 +30,49 @@ struct nbl_hw_mgt {
 	u8 __iomem *hw_addr;
 	u8 __iomem *mailbox_bar_hw_addr;
 	resource_size_t hw_size;
+	spinlock_t reg_lock; /* Protect reg access */
 };
 
+static inline u32 rd32(u8 __iomem *addr, u64 reg)
+{
+	return readl(addr + reg);
+}
+
+static inline void wr32(u8 __iomem *addr, u64 reg, u32 value)
+{
+	writel(value, addr + reg);
+}
+
+static inline void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	/* Used for emu, make sure that we won't write too frequently */
+	wr32(hw_mgt->hw_addr, reg, value);
+}
+
+static inline u32 nbl_hw_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return rd32(hw_mgt->hw_addr, reg);
+}
+
+static inline void nbl_mbx_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	writel(value, hw_mgt->mailbox_bar_hw_addr + reg);
+}
+
+/*
+ * Only call this when has_ctrl=true, which maps enough space
+ * (bar_len - 8192) to cover NBL_HW_DUMMY_REG (0x1300904).
+ * The flow/design guarantees this is only called in the
+ * has_ctrl path.
+ */
+static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+}
+
+static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return readl(hw_mgt->mailbox_bar_hw_addr + reg);
+}
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index be374667c338..b5a7b069d834 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -6,6 +6,13 @@
 #ifndef _NBL_DEF_CHANNEL_H_
 #define _NBL_DEF_CHANNEL_H_
 
+#include <linux/types.h>
+
+struct nbl_channel_mgt;
+struct nbl_adapter;
+
+typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
+
 /*
  * Mailbox wire opcodes
  * Every opcode is assigned explicit fixed numeric value, stable wire ABI
@@ -239,4 +246,101 @@ enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_MAILBOX_MAX,
 };
 
+enum nbl_chan_state {
+	NBL_CHAN_INTERRUPT_READY,
+	NBL_CHAN_ABNORMAL,
+	NBL_CHAN_STATE_NBITS
+};
+
+struct nbl_board_port_info {
+	u8 eth_num;
+	u8 eth_speed;
+	u8 p4_version;
+	u8 rsv[5];
+};
+
+struct nbl_chan_send_info {
+	void *arg;
+	size_t arg_len;
+	void *resp;
+	size_t resp_len;
+	u16 dstid;
+	u16 msg_type;
+	u16 ack;
+	u16 ack_len;
+};
+
+struct nbl_chan_ack_info {
+	void *data;
+	int err;
+	u32 data_len;
+	u16 dstid;
+	u16 msg_type;
+	u16 msgid;
+};
+
+enum nbl_channel_type {
+	NBL_CHAN_TYPE_MAILBOX,
+	NBL_CHAN_TYPE_MAX
+};
+
+static inline void
+nbl_chan_fill_send_info(struct nbl_chan_send_info *info,
+			u16 dst_id, u16 msg_type,
+			void *argument, u32 arg_length,
+			void *response, u32 resp_length,
+			bool need_ack)
+{
+	info->dstid = dst_id;
+	info->msg_type = msg_type;
+	info->arg = argument;
+	info->arg_len = arg_length;
+	info->resp = response;
+	info->resp_len = resp_length;
+	info->ack = need_ack;
+}
+
+static inline void
+nbl_chan_fill_ack_info(struct nbl_chan_ack_info *info,
+		       u16 dst_id, u16 msg_type, u16 msg_id,
+		       int err_code, void *ack_data, u32 data_length)
+{
+	info->dstid = dst_id;
+	info->msg_type = msg_type;
+	info->msgid = msg_id;
+	info->err = err_code;
+	info->data = ack_data;
+	info->data_len = data_length;
+}
+
+struct nbl_channel_ops {
+	int (*send_msg)(struct nbl_channel_mgt *chan_mgt,
+			struct nbl_chan_send_info *chan_send);
+	int (*send_ack)(struct nbl_channel_mgt *chan_mgt,
+			struct nbl_chan_ack_info *chan_ack);
+	int (*register_msg)(struct nbl_channel_mgt *chan_mgt, u16 msg_type,
+			    nbl_chan_resp func, void *callback_priv);
+	void (*unregister_all_msg)(struct nbl_channel_mgt *chan_mgt);
+	void (*cfg_chan_qinfo_map_table)(struct nbl_channel_mgt *chan_mgt,
+					 u8 bus, u8 devid);
+	bool (*check_queue_exist)(struct nbl_channel_mgt *chan_mgt,
+				  u8 chan_type);
+	int (*setup_queue)(struct nbl_channel_mgt *chan_mgt, u8 chan_type);
+	int (*teardown_queue)(struct nbl_channel_mgt *chan_mgt, u8 chan_type);
+	void (*clean_queue_subtask)(struct nbl_channel_mgt *chan_mgt,
+				    u8 chan_type);
+	void (*register_chan_task)(struct nbl_channel_mgt *chan_mgt,
+				   u8 chan_type, struct work_struct *task);
+	void (*set_queue_state)(struct nbl_channel_mgt *chan_mgt,
+				enum nbl_chan_state state, u8 chan_type,
+				u8 set);
+};
+
+struct nbl_channel_ops_tbl {
+	struct nbl_channel_ops *ops;
+	struct nbl_channel_mgt *priv;
+};
+
+int nbl_chan_init_common(struct nbl_adapter *adapter);
+void nbl_chan_remove_common(struct nbl_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 5b7ec68d620b..4f651a227539 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -29,4 +29,19 @@ struct nbl_common_info {
 	u8 has_net;
 };
 
+struct nbl_hash_tbl_key {
+	struct device *dev;
+	u16 key_size;
+	u16 data_size; /* no include key or node member */
+	u16 bucket_size;
+	u16 resv;
+};
+
+struct nbl_hash_tbl_mgt *
+nbl_common_init_hash_table(struct nbl_hash_tbl_key *key);
+void nbl_common_remove_hash_table(struct nbl_hash_tbl_mgt *tbl_mgt);
+int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
+			       void *data, void **out_data);
+void *nbl_common_get_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 517cfa5c755e..9cba73fe24ac 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,25 @@
 
 struct nbl_hw_mgt;
 struct nbl_adapter;
+struct nbl_hw_ops {
+	void (*update_mailbox_queue_tail_ptr)(struct nbl_hw_mgt *hw_mgt,
+					      u16 tail_ptr, u8 txrx);
+	void (*config_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt,
+				   dma_addr_t dma_addr, int size_bwid);
+	void (*config_mailbox_txq)(struct nbl_hw_mgt *hw_mgt,
+				   dma_addr_t dma_addr, int size_bwid);
+	void (*stop_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt);
+	void (*stop_mailbox_txq)(struct nbl_hw_mgt *hw_mgt);
+	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);
+
+	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				  u8 bus, u8 devid, u8 function);
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	struct nbl_hw_mgt *priv;
+};
 
 int nbl_hw_init_leonis(struct nbl_adapter *adapter);
 void nbl_hw_remove_leonis(struct nbl_adapter *adapter);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 70f4f4b4c49c..4dc0615ecc82 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -10,6 +10,9 @@
 
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl"
+#define NBL_MAX_PF					8
+#define NBL_NEXT_ID(id, max) (((id) + 1) % ((max) + 1))
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index bd9f682b8323..2d30c0eed00f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/bits.h>
 #include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_def_channel.h"
 #include "nbl_include/nbl_def_hw.h"
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
@@ -38,13 +39,19 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	if (ret)
 		goto hw_init_fail;
 
+	ret = nbl_chan_init_common(adapter);
+	if (ret)
+		goto chan_init_fail;
 	return adapter;
+chan_init_fail:
+	nbl_hw_remove_leonis(adapter);
 hw_init_fail:
 	return ERR_PTR(ret);
 }
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_chan_remove_common(adapter);
 	nbl_hw_remove_leonis(adapter);
 }
 
-- 
2.47.3

