Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941009;
	b=n+b6f9WT6UauGPxQjT8pkJk+BQqNvG6bzV+Yxo0RfdsrtpjJNMa2YjnV9PZywAYrGIf/
	 FJw9wOpObT86qRzIrvPMNZLvUyHMzWwYJ0TmW+rwhLPn/nESOMrR8QXwYQn/glQUEXak8
	 61+nZoioYil77nSVe++siKCcTz18HgAZD7iZYzH5ohgYTtqhnmUs4thMkIqtVZyidjT8S
	 po8zaDcyW2ZDzp0CSlzqtQuze3L8OVUZ/YUMz0F5o4/qURVJLr3YKyDg33aGWswzzZHpn
	 t6poBp1/4ujpwmGh5nZ4FQCttfzVBJ1sn56m8MHP7STkaKy00QGQzYgD+YQuw4KarPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941009;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=II3fv4XE77dvQtYjSWnd4w7B4uea310gWxmxvufKnkc=;
	b=zo+Ie+letBZVRJG4mV158fharP/VEePPZaifTAQkMMy66LWIMX2nJuQD+Nb43T6RplKz
	 pPHoqPl0YrNWVu1Yt4ywe2ad2N+8HgRVpAKs4rN6ZiONi/mzxL9EPpqNkn7Q/H11kNoQf
	 fwcOMmWsFIhe5xeuzMmxnfPEdsxK97wNWFghjvwBKmRmrvLKofdoAbT1qhq1CTX84xxC5
	 X2evw35FbkijvswA1UKDH8/1+iCz2ZvMM8BSnsyJEOU8DBo3v7Y5BEbuPvRcxbCtMY7XH
	 XsnO5NVNO0d9GAdEqhrpYzAqBT1tqDpTj+eAdi6J95bgR8PW2PABvbM7QSYwn2s1Sig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.100
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C60606A329;
	Fri,  6 Nov 2026 04:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C60606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.003691-0.000809601-0.995499;FP=16337876638116699491|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jy28JiA_1793940995;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jy28JiA_1793940995 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 12:56:36 +0800
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
Subject: [PATCH v33 net-next 1/8] net/nebula-matrix: add channel layer
Date: Fri,  6 Nov 2026 12:56:18 +0800
Message-ID: <20261106045631.2224-2-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106045631.2224-1-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-1-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add a mailbox-based channel layer that carries control messages between
PF0 and the other PFs, providing the inter-PF control transport the rest
of the driver builds on.

The channel ops table is defined here; queue setup, RX interrupt/polling
processing and the upper-layer callers are wired up in later patches of
this series.

Implementation notes:
- Message handlers live in an xarray, giving lockless lookup and
  duplicate-registration rejection (xa_insert returns -EBUSY). Both
  fire-and-forget and synchronous ACK-based sends are supported.
- ACK wait-slot exhaustion returns -EAGAIN; a full TX descriptor ring
  returns -EBUSY. Payloads are inline (up to 16 B) or DMA-based (up to
  4032 B).
- The per-slot data buffers of each ring are carved out of one contiguous
  coherent DMA block, so those buffers cost one devres node and one IOMMU
  mapping per ring instead of one per slot. That is the only part of the
  ring which is collapsed: the descriptor ring is a second coherent
  allocation of its own, and the buf[]/wait[] bookkeeping arrays are
  devm_kcalloc() nodes.
- Mailbox queue resources are devm-managed and the DMA is allocated once
  during setup. There is no free path, so a channel is set up exactly
  once per device lifetime and teardown is terminal for it; a re-setup
  is rejected with -EBUSY.
- RX is driven either from the interrupt or by polling, with cleanup
  offloaded to a workqueue. Teardown quiesces both queues before the
  rings can be freed.
- Register access goes through hw_ops. The reg_lock spinlock covers BAR0
  register access only; BAR2 mailbox registers and the doorbell write do
  not take it.

This patch also adds nbl_probe_chip_deps() and calls it from nbl_probe()
before nbl_core_init(). For every PF that is not the physical function 0
(has_ctrl == 0) it resolves function 0 in the same slot and:

- fails the probe with -ENODEV if function 0 is absent, and also when the
  lookup resolves to this device itself: a VF is never the management PF,
  yet under ARI its devfn decodes to function 0 of a slot;
- returns -EPROBE_DEFER unless function 0 is bound to *this* driver with
  its probe completed. Testing links.status == DL_DEV_DRIVER_BOUND alone
  would also accept function 0 on vfio-pci or pci-stub through
  driver_override, where the chip-global setup this PF depends on never
  ran, so the bound driver is compared as well;
- creates a persistent DL_FLAG_AUTOPROBE_CONSUMER device link, so the
  driver core unbinds every sibling PF before function 0 goes away and
  re-probes them when function 0 binds again.

Function 0's device lock is only ever taken with device_trylock(): this
probe already runs under device_lock(funcN), so a blocking
device_lock(func0) would establish the N -> 0 order while __pci_bus_lock()
(AER recovery, slot reset) walks the bus in devfn order, 0 -> N, and
dev->mutex is lockdep_set_novalidate_class() so lockdep cannot report the
inversion. The link is created while that lock is still held, so function
0 can neither bind nor unbind in between.

A failed trylock is retried a bounded number of times before the probe is
deferred. The retry is needed because a single failure is not
self-healing: function 0 binds with device_lock(func0) held and
driver_bound() calls driver_deferred_probe_trigger() before releasing it,
so the deferred probe work can reach this probe while the lock is still
taken. driver_probe_device() only re-arms that work when
deferred_trigger_count changes during the probe, and it does not here, so
a bare -EPROBE_DEFER would leave this PF on deferred_probe_pending_list
with nothing scheduled to run it again. The wait is bounded rather than a
plain device_lock() because device_lock(funcN) is held throughout, so
waiting indefinitely would deadlock against __pci_bus_lock(); giving up
and deferring releases it and lets the other side make progress. A holder
that is not part of a bind - __pci_bus_lock() during AER recovery or a
bus/slot reset, pci_reset_function() through sysfs, an sriov_numvfs
write - can outlast the budget and no bind event follows those, so the
sibling PF then stays deferred until some unrelated driver binding
elsewhere re-triggers deferred probing.

Nothing here consumes the ordering yet - setup_queue() and
cfg_chan_qinfo_map_table() still have no callers - but the later
init/remove and start/stop patches do. Note the cost: with function 0
bound to another driver (e.g. vfio-pci) a sibling PF stays deferred for
as long as that holds, with only a dev_dbg() record, and a function 0
that is simply absent fails the probe outright.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    4 +-
 .../nbl/nbl_channel/nbl_channel.c             | 1528 +++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  196 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |   30 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    7 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  299 +++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |   41 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   32 +
 .../nbl/nbl_include/nbl_def_channel.h         |  125 ++
 .../nbl/nbl_include/nbl_def_common.h          |    3 +
 .../nbl/nbl_include/nbl_def_hw.h              |   42 +
 .../nbl/nbl_include/nbl_include.h             |    3 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  190 +-
 14 files changed, 2496 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index cc060cf8..04e1aa1f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -3,5 +3,7 @@
 
 obj-$(CONFIG_NBL) := nbl.o
 
-nbl-objs +=	nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+nbl-objs +=	nbl_common/nbl_common.o \
+		nbl_channel/nbl_channel.o \
+		nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
new file mode 100644
index 00000000..5b528cc6
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -0,0 +1,1528 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
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
+	struct nbl_chan_msg_node_data *handler;
+	int ret;
+
+	handler = kzalloc_obj(*handler, GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+
+	handler->func = func;
+	handler->priv = priv;
+
+	/* Each msg_type is registered at most once; reject duplicates. */
+	mutex_lock(&chan_mgt->handler_lock);
+	ret = xa_insert(&chan_mgt->handler_xa, msg_type, handler, GFP_KERNEL);
+	mutex_unlock(&chan_mgt->handler_lock);
+	if (ret)
+		kfree(handler);
+
+	return ret;
+}
+
+static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	int ret;
+
+	ret = devm_mutex_init(chan_mgt->common->dev, &chan_mgt->handler_lock);
+	if (ret)
+		return ret;
+
+	xa_init(&chan_mgt->handler_xa);
+
+	return 0;
+}
+
+static void nbl_chan_remove_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_chan_msg_node_data *handler;
+	unsigned long msg_type;
+
+	mutex_lock(&chan_mgt->handler_lock);
+	xa_for_each(&chan_mgt->handler_xa, msg_type, handler) {
+		xa_erase(&chan_mgt->handler_xa, msg_type);
+		kfree(handler);
+	}
+	mutex_unlock(&chan_mgt->handler_lock);
+	xa_destroy(&chan_mgt->handler_xa);
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
+	WRITE_ONCE(chan_info->shutdn, false);
+	WRITE_ONCE(chan_info->active, false);
+	WRITE_ONCE(chan_info->wait_head_index, 0);
+	memset(chan_info->state, 0, sizeof(chan_info->state));
+	init_waitqueue_head(&chan_info->inflight_wait);
+}
+
+static int nbl_chan_init_tx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = common->dev;
+	dma_addr_t base_dma;
+	size_t size =
+		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+	void *base;
+	u16 i;
+
+	txq->desc.tx_desc = dmam_alloc_coherent(dev, size, &txq->dma,
+						GFP_KERNEL);
+	if (!txq->desc.tx_desc)
+		return -ENOMEM;
+
+	/*
+	 * The per-entry *data buffers* all come from one contiguous coherent
+	 * block, so those buffers cost exactly one coherent allocation, one
+	 * devres node and one IOMMU mapping for the whole ring whatever the
+	 * page size is.  Per-entry dmam_alloc_coherent() instead rounds every
+	 * NBL_CHAN_BUF_LEN buffer up to a whole page (8 MiB per PF on 16 KiB
+	 * pages, 32 MiB on 64 KiB pages), and a dma_pool only fixes the
+	 * large-page case: with NBL_CHAN_BUF_LEN equal to PAGE_SIZE it still
+	 * degenerates to one allocation per buffer on 4 KiB pages.
+	 * NBL_CHAN_BUF_LEN is a power of two, so the block always divides
+	 * evenly into per-entry slots.
+	 *
+	 * That is the only part of the ring that is collapsed: the descriptor
+	 * ring above is its own dmam_alloc_coherent(), and txq->buf[] and
+	 * chan_info->wait[] below are separate devm_kcalloc() nodes, so a
+	 * ring is two coherent mappings plus those arrays, not one.
+	 */
+	base = dmam_alloc_coherent(dev,
+				   chan_info->num_txq_entries *
+				   chan_info->txq_buf_size,
+				   &base_dma, GFP_KERNEL);
+	if (!base)
+		return -ENOMEM;
+
+	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
+				       sizeof(*chan_info->wait), GFP_KERNEL);
+	if (!chan_info->wait)
+		return -ENOMEM;
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		init_waitqueue_head(&chan_info->wait[i].wait_queue);
+		WRITE_ONCE(chan_info->wait[i].status, NBL_MBX_STATUS_IDLE);
+		WRITE_ONCE(chan_info->wait[i].acked, 0);
+		WRITE_ONCE(chan_info->wait[i].ack_data, NULL);
+		WRITE_ONCE(chan_info->wait[i].ack_data_len, 0);
+		WRITE_ONCE(chan_info->wait[i].ack_err, 0);
+		WRITE_ONCE(chan_info->wait[i].msg_type, 0);
+		WRITE_ONCE(chan_info->wait[i].msg_index, 0);
+		WRITE_ONCE(chan_info->wait[i].dstid, 0);
+	}
+
+	txq->buf = devm_kcalloc(dev, chan_info->num_txq_entries,
+				sizeof(*txq->buf), GFP_KERNEL);
+	if (!txq->buf)
+		return -ENOMEM;
+
+	/* Carve the contiguous block into fixed-size per-entry slots */
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		txq->buf[i].va = (u8 *)base +
+				 (size_t)i * chan_info->txq_buf_size;
+		txq->buf[i].pa = base_dma +
+				 (dma_addr_t)i * chan_info->txq_buf_size;
+		txq->buf[i].size = chan_info->txq_buf_size;
+	}
+
+	txq->next_to_clean = 0;
+	txq->next_to_use = 0;
+	txq->tail_ptr = 0;
+
+	return 0;
+}
+
+static int nbl_chan_init_rx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = common->dev;
+	struct nbl_chan_rx_desc *desc;
+	dma_addr_t base_dma;
+	size_t size =
+		chan_info->num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+	void *base;
+	u16 i;
+
+	rxq->desc.rx_desc = dmam_alloc_coherent(dev, size, &rxq->dma,
+						GFP_KERNEL);
+	if (!rxq->desc.rx_desc) {
+		dev_err_ratelimited(dev,
+				    "Allocate DMA for chan rx descriptor ring failed\n");
+		return -ENOMEM;
+	}
+
+	/* See nbl_chan_init_tx_queue() for why one contiguous block is used */
+	base = dmam_alloc_coherent(dev,
+				   chan_info->num_rxq_entries *
+				   chan_info->rxq_buf_size,
+				   &base_dma, GFP_KERNEL);
+	if (!base)
+		return -ENOMEM;
+
+	rxq->buf = devm_kcalloc(dev, chan_info->num_rxq_entries,
+				sizeof(*rxq->buf), GFP_KERNEL);
+	if (!rxq->buf)
+		return -ENOMEM;
+
+	/* Carve the contiguous block into fixed-size per-entry slots */
+	for (i = 0; i < chan_info->num_rxq_entries; i++) {
+		rxq->buf[i].va = (u8 *)base +
+				 (size_t)i * chan_info->rxq_buf_size;
+		rxq->buf[i].pa = base_dma +
+				 (dma_addr_t)i * chan_info->rxq_buf_size;
+		rxq->buf[i].size = chan_info->rxq_buf_size;
+	}
+
+	desc = rxq->desc.rx_desc;
+	/*
+	 * Initially leave one RX descriptor unused so that
+	 * next_to_clean and next_to_use can distinguish an empty
+	 * ring from a full ring.
+	 *
+	 * The unused slot is replenished as RX descriptors are
+	 * consumed and recycled.
+	 */
+	for (i = 0; i < chan_info->num_rxq_entries - 1; i++) {
+		desc[i].buf_addr = cpu_to_le64(rxq->buf[i].pa);
+		desc[i].buf_len = cpu_to_le32(chan_info->rxq_buf_size);
+		desc[i].flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
+	}
+
+	rxq->next_to_clean = 0;
+	rxq->next_to_use = chan_info->num_rxq_entries - 1;
+	rxq->tail_ptr = chan_info->num_rxq_entries - 1;
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
+static void nbl_chan_cfg_qinfo_map_table(struct nbl_channel_mgt *chan_mgt,
+					 u8 bus, u8 devid)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	u32 pf_mask = 0;
+	u8 func_id;
+
+	/*
+	 * k_pf_mask rule: bit N == 0 means PF#N enabled, bit N == 1 masked out.
+	 * Program mailbox QINFO entry for each hardware-active PF func_id.
+	 *
+	 * Note: This loop iterates over the raw hardware PF func_id, so it
+	 * assumes product constraints limit supported PF counts to the
+	 * contiguous sets PF0, PF0~1 and PF0~3, i.e. pf_mask is one of
+	 * 0xfe/0xfc/0xf0.  Nothing enforces that here: the resource layer
+	 * that validates the mask, and every caller of this op, arrive in
+	 * later patches of this series.
+	 */
+	hw_ops->get_host_pf_mask(p, &pf_mask);
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (!(pf_mask & (1 << func_id)))
+			hw_ops->cfg_mailbox_qinfo(p, func_id, bus,
+						  devid, func_id);
+	}
+}
+
+/*
+ * The RX QINFO region is written only by config/stop paths, never by
+ * senders (which only touch the TX QINFO region and the doorbell), so
+ * stopping RX does not require txq_lock.
+ */
+static void nbl_chan_stop_rx_queue(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+
+	hw_ops->stop_mailbox_rxq(chan_mgt->hw_ops_tbl->priv);
+}
+
+/*
+ * The TX QINFO region is also written by nbl_chan_quiesce_and_reclaim_tx()
+ * under txq_lock, so TX stop must serialize against it via txq_lock.
+ */
+static void nbl_chan_stop_tx_queue(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+
+	hw_ops->stop_mailbox_txq(chan_mgt->hw_ops_tbl->priv);
+}
+
+static void nbl_chan_reset_wait_head(struct nbl_chan_info *chan_info,
+				     struct nbl_chan_waitqueue_head *wait_head)
+{
+	lockdep_assert_held(&chan_info->pending_lock);
+
+	WRITE_ONCE(wait_head->acked, 0);
+	WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_IDLE);
+	WRITE_ONCE(wait_head->ack_data, NULL);
+	WRITE_ONCE(wait_head->ack_data_len, 0);
+	WRITE_ONCE(wait_head->ack_err, 0);
+	WRITE_ONCE(wait_head->msg_type, 0);
+	WRITE_ONCE(wait_head->dstid, 0);
+}
+
+static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
+				   u8 chan_type)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+	struct nbl_chan_waitqueue_head *wait_head;
+	struct work_struct *task;
+	u16 i;
+
+	if (!READ_ONCE(chan_info->active)) {
+		dev_warn(chan_mgt->common->dev, "channel not active, skip duplicate teardown\n");
+		return 0;
+	}
+	/*
+	 * Step1:
+	 * block new sender
+	 */
+	mutex_lock(&chan_info->state_lock);
+	WRITE_ONCE(chan_info->shutdn, true);
+	task = READ_ONCE(chan_info->clean_task);
+	WRITE_ONCE(chan_info->clean_task, NULL);
+	mutex_unlock(&chan_info->state_lock);
+	/*
+	 * Step2:
+	 * abort pending ACK waiters
+	 *
+	 * Poke only slots with a live waiter (status == WAITING): publish a
+	 * synthetic (-EIO, len 0) completion and wake the owner. The slot is
+	 * deliberately NOT reset to IDLE here - ownership stays with the
+	 * sender, which consumes the completion and resets its own slot in
+	 * nbl_chan_send_msg():out_clear_wait_slot under pending_lock.
+	 *
+	 * Resetting an owned slot here would corrupt two things:
+	 *   - an ACKD slot whose sender is consuming the completion
+	 *     locklessly (smp_rmb()-ordered reads) could observe torn
+	 *     ack_data_len/ack_err pairs;
+	 *   - nbl_chan_get_msg_id() hands out IDLE/TIMEOUT slots, so a slot
+	 *     reset to IDLE under its live owner could be reallocated to a
+	 *     sender admitted before shutdn was set.
+	 *
+	 * IDLE/TIMEOUT slots have no waiter and need no action. A late ACK
+	 * racing this poke is serialized by pending_lock: either the real
+	 * completion lands first (status becomes ACKD and is skipped) or
+	 * this synthetic failure does, both are valid outcomes.
+	 */
+	mutex_lock(&chan_info->pending_lock);
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		wait_head = &chan_info->wait[i];
+		if (READ_ONCE(wait_head->status) != NBL_MBX_STATUS_WAITING)
+			continue;
+		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_ACKD);
+		WRITE_ONCE(wait_head->ack_data_len, 0);
+		WRITE_ONCE(wait_head->ack_err, (s32)-EIO);
+		/* Publish completion fields before the acked flag */
+		smp_wmb();
+		WRITE_ONCE(wait_head->acked, 1);
+		wake_up(&wait_head->wait_queue);
+	}
+	mutex_unlock(&chan_info->pending_lock);
+
+	/*
+	 * Step3:
+	 * stop the RX queue unconditionally. The RX QINFO region is written
+	 * only by config/stop paths, never by senders (which only touch the
+	 * TX QINFO region and the doorbell), so no txq_lock is needed. The
+	 * RX engine must be quiesced before the rings are freed, regardless
+	 * of TX-side state - skipping it would leave the device DMAing peer
+	 * messages and descriptor writebacks into released coherent memory.
+	 */
+	nbl_chan_stop_rx_queue(chan_mgt);
+
+	/*
+	 * Drain strategy mirrors mlx5 command interface teardown:
+	 * set shutdown flag first, abort all pending waiters, then
+	 * block until inflight_tx_cnt reaches zero.
+	 *
+	 * After shutdn is set every sender exits promptly at its next
+	 * checkpoint:
+	 *   - interrupt-driven senders wake on shutdn immediately
+	 *     (it is part of the wait_event condition);
+	 *   - ACK polling senders check shutdn each iteration before
+	 *     sleeping 1000-1200us. This per-iteration check avoids
+	 *     waiting the full 5.0-6.0s worst-case ACK timeout.
+	 *
+	 * The wait is deliberately unbounded: a surviving sender still
+	 * holds txq_lock or touches chan_info (state_lock, wait[]) on its
+	 * exit path, so returning early would let devres free the rings
+	 * and chan_info underneath it. In practice the TX polling loop is
+	 * bounded (NBL_CHAN_TX_WAIT_TIMES) and wedged-link MMIO reads
+	 * eventually complete with all-1s data, so this loop terminates;
+	 * warn periodically to keep a genuinely stuck sender diagnosable.
+	 */
+	while (wait_event_timeout(chan_info->inflight_wait,
+				  atomic_read(&chan_info->inflight_tx_cnt) == 0,
+				  msecs_to_jiffies(5000)) == 0)
+		dev_warn(chan_mgt->common->dev,
+			 "teardown: still waiting for %d inflight sender(s)\n",
+			 atomic_read(&chan_info->inflight_tx_cnt));
+
+	/*
+	 * Join the last exiting sender through state_lock.  A sender drops
+	 * inflight_tx_cnt and wakes this drain while still holding
+	 * state_lock, so observing the counter reach zero only proves the
+	 * decrement happened; the acquire below is what proves that no
+	 * sender still holds the lock.  Once it returns, no sender can be
+	 * using chan_info either: the decrement is the last field access a
+	 * sender makes, and the only thing that follows it is the
+	 * mutex_unlock() of state_lock itself.
+	 *
+	 * That trailing unlock is why this is one acquire/release pair and
+	 * not a handshake that ends the sender: mutex_unlock() may still be
+	 * touching the mutex structure after it has released it, so this does
+	 * not prove the sender has returned from it (see
+	 * Documentation/locking/mutex-design.rst).  It is safe only because
+	 * chan_info - mutexes included - is devm-allocated and released at
+	 * detach, long after this teardown, and because nothing frees it
+	 * here.  Freeing chan_info or calling mutex_destroy() at this point
+	 * would need a sender-exit completion the channel does not have.
+	 *
+	 * shutdn blocks new senders, so one acquire/release pair is
+	 * sufficient.
+	 */
+	mutex_lock(&chan_info->state_lock);
+	mutex_unlock(&chan_info->state_lock);
+
+	/*
+	 * All senders have exited, so txq_lock is uncontended: plain lock.
+	 * Take it so this is the sole writer of the TX QINFO block
+	 * (sender-side stop/config/doorbell sequences all run under
+	 * txq_lock).
+	 */
+	mutex_lock(&chan_info->txq_lock);
+	nbl_chan_stop_tx_queue(chan_mgt);
+	mutex_unlock(&chan_info->txq_lock);
+
+	/*
+	 * Join the RX clean work before active=false and before devres
+	 * releases the rings. IRQ is already freed and clean_task is
+	 * cleared under state_lock, so no new instance can be queued.
+	 */
+	if (task)
+		cancel_work_sync(task);
+
+	WRITE_ONCE(chan_info->active, false);
+	return 0;
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
+	if (READ_ONCE(chan_info->active)) {
+		dev_warn(common->dev, "channel already active, reject duplicate setup\n");
+		return -EBUSY;
+	}
+	/*
+	 * The descriptor rings and the per-ring contiguous buffer blocks are
+	 * allocated once and released only by devres at device detach: there
+	 * is no free path, so a channel is set up exactly once per device
+	 * lifetime and teardown is terminal for it.  Re-setup would allocate
+	 * a second set - about 2 MiB of coherent DMA plus the descriptor
+	 * rings and wait[] - and orphan the first one, and it would revive a
+	 * queue whose state teardown has already retired, so it is rejected.
+	 */
+	if (chan_info->dma_allocated) {
+		dev_warn(common->dev,
+			 "channel DMA already allocated, re-setup not supported\n");
+		return -EBUSY;
+	}
+
+	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
+				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
+				  NBL_CHAN_BUF_LEN);
+	/*
+	 * Set the flag before the first allocation and leave it set even
+	 * when setup fails: whatever nbl_chan_init_queue() managed to
+	 * allocate is devres-owned and stays live until detach, so the retry
+	 * that clearing the flag would allow would allocate a second set on
+	 * top of the orphans.
+	 */
+	chan_info->dma_allocated = true;
+	err = nbl_chan_init_queue(common, chan_info);
+	if (err)
+		return err;
+
+	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
+	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
+	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
+				 rxq->tail_ptr, NBL_MB_RX_QID);
+	WRITE_ONCE(chan_info->active, true);
+	return 0;
+}
+
+static bool nbl_chan_txq_full(struct nbl_chan_ring *txq,
+			      u16 num_entries)
+{
+	return NBL_NEXT_ID(txq->next_to_use, num_entries - 1) ==
+	       txq->next_to_clean;
+}
+
+static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
+				   struct nbl_chan_info *chan_info,
+				   struct nbl_chan_tx_param *param)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct nbl_chan_tx_desc *tx_desc;
+	struct nbl_chan_buf *tx_buf;
+
+	/*
+	 * param->arg is non-NULL whenever param->arg_len is non-zero:
+	 * nbl_chan_send_msg() validates that before calling here, because a
+	 * length with no buffer would publish buf_addr/buf_len describing
+	 * memory that was never filled.
+	 */
+	if (nbl_chan_txq_full(txq, chan_info->num_txq_entries))
+		return -EBUSY;
+	if (param->arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc))
+		return -EINVAL;
+	tx_desc =
+		NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_use);
+	tx_buf =
+		NBL_CHAN_TX_RING_TO_BUF(txq, txq->next_to_use);
+	tx_desc->dstid = cpu_to_le16(param->dstid);
+	tx_desc->msg_type = cpu_to_le16(param->msg_type);
+	tx_desc->msgid = cpu_to_le16(param->msgid);
+
+	/*
+	 * srcid field is filled by mailbox hardware after peer receives this
+	 * packet, driver producer never writes srcid; reused descriptor slots
+	 * will contain stale srcid value temporarily until hardware overwrites
+	 * it.
+	 */
+	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+		memcpy(tx_buf->va, param->arg, param->arg_len);
+		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
+		tx_desc->buf_len = cpu_to_le16(param->arg_len);
+		tx_desc->data_len = 0;
+		memset(tx_desc->data, 0, sizeof(tx_desc->data));
+	} else {
+		memset(tx_desc->data, 0, sizeof(tx_desc->data));
+		memset(&tx_desc->buf_addr, 0, sizeof(tx_desc->buf_addr));
+		if (param->arg_len)
+			memcpy(tx_desc->data, param->arg, param->arg_len);
+		tx_desc->buf_len = 0;
+		tx_desc->data_len = cpu_to_le16(param->arg_len);
+	}
+	/* Ensure descriptor data visible to device before AVAIL flag */
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
+/*
+ * Quiesce the TX mailbox queue and reclaim all outstanding
+ * descriptors.  Called from the timeout path of nbl_chan_kick_tx_ring()
+ * with txq_lock held.
+ *
+ * The device failed to fetch/complete the current descriptor within the
+ * polling window.  We assert QUEUE_RST to stop further DMA fetches,
+ * reclaim every descriptor between next_to_clean and next_to_use,
+ * reset the software tail_ptr counter to match the hardware reset state,
+ * and re-enable the queue so subsequent sends can proceed.
+ */
+static void nbl_chan_quiesce_and_reclaim_tx(struct nbl_channel_mgt *chan_mgt,
+					    struct nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *hw_priv = chan_mgt->hw_ops_tbl->priv;
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct nbl_chan_tx_desc *tx_desc;
+
+	/*
+	 * Assert QUEUE_RST to stop hardware fetching new descriptors.
+	 * stop_mailbox_txq() flushes through the mailbox BAR itself, so
+	 * the reset has reached the device when it returns.
+	 */
+	hw_ops->stop_mailbox_txq(hw_priv);
+
+	/*
+	 * Reclaim all outstanding descriptors between next_to_clean and
+	 * next_to_use.  Under txq_lock there is at most one in-flight
+	 * descriptor, but iterate the full range for robustness.
+	 */
+	while (txq->next_to_clean != txq->next_to_use) {
+		tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq,
+						   txq->next_to_clean);
+		WRITE_ONCE(tx_desc->flags, 0);
+		txq->next_to_clean =
+			NBL_NEXT_ID(txq->next_to_clean,
+				    chan_info->num_txq_entries - 1);
+	}
+
+	/*
+	 * Hardware tail_ptr counter is cleared by QUEUE_RST.  Reset
+	 * software counter to match so the next doorbell update does
+	 * not produce a false 16-bit wrap delta.
+	 */
+	txq->tail_ptr = 0;
+	txq->next_to_use = 0;
+	txq->next_to_clean = 0;
+
+	/*
+	 * Authoritative re-arm gate, evaluated while txq_lock is held:
+	 * teardown sets shutdn before draining senders and then owns
+	 * hardware state. If teardown started while we were stopping/
+	 * reclaiming, leave the queue in QUEUE_RST and never program
+	 * QUEUE_EN, otherwise the queue could be armed again pointing
+	 * at rings that are about to be freed.
+	 */
+	if (READ_ONCE(chan_info->shutdn))
+		return;
+
+	/* Re-enable queue with current ring base and size */
+	nbl_chan_config_queue(chan_mgt, chan_info, true);
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
+	/*
+	 * Poll for HW to mark descriptor as USED.
+	 * Mailbox is a low-speed control channel for management commands.
+	 * We avoid enabling dedicated per-TX interrupt for single control
+	 * message to reduce interrupt overhead, so use bounded polling
+	 * with small delay instead.
+	 */
+	while (retry_count < max_retries) {
+		if (READ_ONCE(chan_info->shutdn))
+			return -ESHUTDOWN;
+
+		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
+		    BIT(NBL_CHAN_TX_DESC_USED)) {
+			 /*
+			  * Order reads of other device-written descriptor
+			  * fields after observing USED.  Matches the RX side
+			  * pattern in nbl_chan_clean_queue().
+			  */
+			dma_rmb();
+			break;
+		}
+
+		retry_count++;
+		if (retry_count == max_retries) {
+			msg_type = le16_to_cpu(READ_ONCE(tx_desc->msg_type));
+			dev_err_ratelimited(dev, "chan send msg type: %d timeout\n",
+					    msg_type);
+			/*
+			 * Teardown may have started after the loop-top
+			 * check on this final iteration. Do not run lock
+			 * recovery then: it would stop/reclaim the queue
+			 * and, without the in-quiesce gate, re-arm it.
+			 * nbl_chan_teardown_queue() owns hardware state.
+			 */
+			if (READ_ONCE(chan_info->shutdn))
+				return -ESHUTDOWN;
+			/*
+			 * Device failed to complete this descriptor.
+			 * Quiesce the queue, reclaim the timed-out
+			 * descriptor, and re-enable so future sends can
+			 * proceed instead of stalling the ring full.
+			 */
+			nbl_chan_quiesce_and_reclaim_tx(chan_mgt,
+							chan_info);
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
+	u16 w_dstid, w_msgtype, w_msgidx;
+	u32 *payload = data;
+	u16 ack_msgtype = 0;
+	u16 ack_msgid = 0;
+	u32 ack_datalen;
+	void *ack_data;
+	u32 copy_len;
+	int w_status;
+	s32 raw_err;
+
+	if (READ_ONCE(chan_info->shutdn))
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
+		dev_err_ratelimited(dev, "chan recv msg id: %u err\n",
+				    ack_msgid);
+		return;
+	}
+	wait_head =
+		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid)];
+
+	mutex_lock(&chan_info->pending_lock);
+
+	/* Cache repeated READ_ONCE values */
+	w_dstid = READ_ONCE(wait_head->dstid);
+	w_status = READ_ONCE(wait_head->status);
+	w_msgtype = READ_ONCE(wait_head->msg_type);
+	w_msgidx = READ_ONCE(wait_head->msg_index);
+
+	if (srcid != w_dstid) {
+		mutex_unlock(&chan_info->pending_lock);
+		dev_err_ratelimited(dev, "ACK srcid=%u != dstid=%u, rejecting\n",
+				    srcid, w_dstid);
+		return;
+	}
+	if (w_status != NBL_MBX_STATUS_WAITING) {
+		mutex_unlock(&chan_info->pending_lock);
+		dev_err_ratelimited(dev,
+				    "Skip ack invalid status, wait msgtype:%u idx:%u status:%d ack msgtype:%u msgid:%u datalen:%u\n",
+				    w_msgtype, w_msgidx, w_status,
+				    ack_msgtype, ack_msgid, ack_datalen);
+		return;
+	}
+
+	if (w_msgtype != ack_msgtype) {
+		mutex_unlock(&chan_info->pending_lock);
+		dev_err_ratelimited(dev,
+				    "Skip ack msgtype mismatch, wait msgtype:%u idx:%u ack msgtype:%u msgid:%u\n",
+				    w_msgtype, w_msgidx, ack_msgtype,
+				    ack_msgid);
+		return;
+	}
+	if (FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, ack_msgid) != w_msgidx) {
+		mutex_unlock(&chan_info->pending_lock);
+		dev_err_ratelimited(dev,
+				    "Stale ACK: expected index=%u, got msgid=%u\n",
+				    w_msgidx, ack_msgid);
+		return;
+	}
+
+	raw_err = (s32)le32_to_cpu(*(__le32 *)&payload[NBL_CHAN_ACK_RET_POS]);
+	if (raw_err > 0 || raw_err < -MAX_ERRNO)
+		raw_err = -EREMOTEIO;
+
+	WRITE_ONCE(wait_head->ack_err, raw_err);
+
+	copy_len = min_t(u32, READ_ONCE(wait_head->ack_data_len), ack_datalen);
+	if (READ_ONCE(wait_head->ack_err) >= 0 && copy_len > 0) {
+		ack_data = READ_ONCE(wait_head->ack_data);
+		if (!ack_data) {
+			dev_err_ratelimited(dev, "ACK payload dropped: ack_data is NULL\n");
+			WRITE_ONCE(wait_head->ack_data_len, 0);
+			goto ack_done;
+		}
+		memcpy((char *)ack_data,
+		       payload + NBL_CHAN_ACK_HEAD_LEN, copy_len);
+		WRITE_ONCE(wait_head->ack_data_len, (u16)copy_len);
+	} else {
+		WRITE_ONCE(wait_head->ack_data_len, 0);
+	}
+ack_done:
+	/* Guarantee payload data finished before acked flag visible */
+	smp_wmb();
+	WRITE_ONCE(wait_head->acked, 1);
+	WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_ACKD);
+	mutex_unlock(&chan_info->pending_lock);
+	wake_up(&wait_head->wait_queue);
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
+	size_t avail_space;
+	u16 data_len_fw;
+
+	if (READ_ONCE(chan_info->shutdn))
+		return;
+
+	tx_desc = data;
+	msg_type = le16_to_cpu(READ_ONCE(tx_desc->msg_type));
+	dev_dbg(dev, "recv msg_type: %d\n", msg_type);
+
+	srcid = le16_to_cpu(READ_ONCE(tx_desc->srcid));
+	msgid = le16_to_cpu(READ_ONCE(tx_desc->msgid));
+
+	if (msg_type >= NBL_CHAN_MSG_MAILBOX_MAX)
+		return;
+
+	data_len_fw = le16_to_cpu(READ_ONCE(tx_desc->data_len));
+	if (data_len_fw) {
+		payload_len = data_len_fw;
+
+		if (payload_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+			dev_err_ratelimited(dev,
+					    "data_len=%u exceeds embedded buffer size=%u\n",
+					    payload_len,
+					    NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN);
+			return;
+		}
+		/* Small pkt: payload stored inside descriptor data[] array */
+		payload = tx_desc->data;
+	} else {
+		payload_len = le16_to_cpu(READ_ONCE(tx_desc->buf_len));
+
+		avail_space = NBL_CHAN_BUF_LEN - sizeof(*tx_desc);
+		if (payload_len > avail_space) {
+			dev_err_ratelimited(dev,
+					    "buf_len=%u exceeds external buffer size=%zu\n",
+					    payload_len, avail_space);
+			return;
+		}
+		/* Large pkt: payload follows immediately after tx_desc */
+		payload = tx_desc + 1;
+	}
+
+	msg_handler = xa_load(&chan_mgt->handler_xa, msg_type);
+	if (!msg_handler || !msg_handler->func) {
+		dev_err_ratelimited(dev,
+				    "No handler for msg_type: %u (srcid=%u, msgid=%u)\n",
+				    msg_type, srcid, msgid);
+		return;
+	}
+
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
+	/*
+	 * Recycle the RX descriptor at next_to_use. The initial
+	 * unused slot is intentionally recycled after the first
+	 * RX descriptor is consumed, allowing the ring to become
+	 * fully populated while next_to_clean tracks the consumer.
+	 */
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
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = chan_mgt->common->dev;
+	u32 budget = NBL_CHAN_RX_CLEAN_BUDGET;
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_chan_buf *rx_buf;
+	struct work_struct *task;
+	bool more_work = false;
+	u16 next_to_clean;
+	u16 flags;
+
+	/* Nothing to clean before setup: the RX ring is still NULL */
+	if (!READ_ONCE(chan_info->active))
+		return;
+
+	next_to_clean = rxq->next_to_clean;
+	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+	while (le16_to_cpu(READ_ONCE(rx_desc->flags)) &
+	       BIT(NBL_CHAN_RX_DESC_USED)) {
+		flags = le16_to_cpu(READ_ONCE(rx_desc->flags));
+
+		if (READ_ONCE(chan_info->shutdn))
+			break;
+		if (!(flags & BIT(NBL_CHAN_RX_DESC_WRITE)))
+			dev_dbg(dev,
+				"mailbox rx flag 0x%x missing NBL_CHAN_RX_DESC_WRITE\n",
+				flags);
+
+		/* Make sure hardware written descriptor visible to CPU */
+		dma_rmb();
+		nbl_chan_recv_msg(chan_mgt, rx_buf->va);
+		nbl_chan_advance_rx_ring(chan_mgt, chan_info, rxq);
+		next_to_clean++;
+		if (next_to_clean == chan_info->num_rxq_entries)
+			next_to_clean = 0;
+		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+		if (--budget == 0) {
+			more_work = true;
+			break;
+		}
+		cond_resched();
+	}
+	rxq->next_to_clean = next_to_clean;
+
+	mutex_lock(&chan_info->state_lock);
+	/* Prevent queue_work after teardown clears clean_task */
+	if (READ_ONCE(chan_info->shutdn)) {
+		mutex_unlock(&chan_info->state_lock);
+		return;
+	}
+	if (common->wq && more_work) {
+		task = READ_ONCE(chan_info->clean_task);
+		if (task)
+			queue_work(common->wq, task);
+	}
+	mutex_unlock(&chan_info->state_lock);
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
+	int search_loc = READ_ONCE(chan_info->wait_head_index), i;
+	struct nbl_chan_waitqueue_head *wait = NULL;
+	int status;
+	int next;
+
+	lockdep_assert_held(&chan_info->pending_lock);
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		wait = &chan_info->wait[search_loc];
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
+
+			/* Advance starting search position for next caller */
+			next = NBL_NEXT_ID(search_loc,
+					   chan_info->num_txq_entries - 1);
+			WRITE_ONCE(chan_info->wait_head_index, next);
+			return 0;
+		}
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
+	struct nbl_chan_waitqueue_head *wait_head = NULL;
+	struct nbl_chan_tx_param tx_param = { 0 };
+	int i = NBL_CHAN_TX_WAIT_ACK_TIMES;
+	struct nbl_chan_info *chan_info =
+		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
+	struct device *dev = common->dev;
+	struct work_struct *task;
+	u16 msgid = 0;
+	int ret;
+
+	if (chan_send->resp_len > NBL_CHAN_BUF_LEN) {
+		dev_err_ratelimited(dev, "resp_len %zu exceeds max %d\n",
+				    chan_send->resp_len, NBL_CHAN_BUF_LEN);
+		return -EINVAL;
+	}
+
+	/*
+	 * A length without a payload would leave the descriptor pointing at
+	 * whatever the reused slot still holds - nbl_chan_update_txqueue()
+	 * skips the copy - and the peer would receive those stale bytes.
+	 * Reject the combination instead of transmitting them.
+	 */
+	if (chan_send->arg_len && !chan_send->arg) {
+		dev_err_ratelimited(dev, "arg_len %zu without arg\n",
+				    chan_send->arg_len);
+		return -EINVAL;
+	}
+
+	/*
+	 * Entry points are only reached after a successful setup_queue()
+	 * (probe path), but the channel is a dynamic object: fail cleanly
+	 * instead of dereferencing rings/wait[] that were never allocated
+	 * (num_txq_entries == 0).  active is published last in setup and
+	 * cleared last in teardown, so a false value here means the channel
+	 * never came up - or has already been torn down, and shutdn tells
+	 * the two apart: it is set before active is cleared, so a
+	 * post-teardown sender gets the same -ESHUTDOWN as the check below
+	 * rather than the -ENODEV reserved for a channel setup_queue()
+	 * never completed.
+	 */
+	if (!READ_ONCE(chan_info->active)) {
+		if (READ_ONCE(chan_info->shutdn))
+			return -ESHUTDOWN;
+		return -ENODEV;
+	}
+
+	mutex_lock(&chan_info->state_lock);
+	if (READ_ONCE(chan_info->shutdn)) {
+		mutex_unlock(&chan_info->state_lock);
+		return -ESHUTDOWN;
+	}
+	atomic_inc(&chan_info->inflight_tx_cnt);
+	mutex_unlock(&chan_info->state_lock);
+
+	tx_param.msg_type = chan_send->msg_type;
+	tx_param.arg = chan_send->arg;
+	tx_param.arg_len = chan_send->arg_len;
+	tx_param.dstid = chan_send->dstid;
+	tx_param.msgid = msgid;
+	if (chan_send->ack) {
+		mutex_lock(&chan_info->pending_lock);
+
+		ret = nbl_chan_get_msg_id(chan_info, &msgid);
+		if (ret) {
+			mutex_unlock(&chan_info->pending_lock);
+			dev_err_ratelimited(dev,
+					    "Channel tx wait head full, send msgtype:%u to dstid:%u failed\n",
+					    chan_send->msg_type,
+					    chan_send->dstid);
+			goto out_clean_inflight;
+		}
+		wait_head =
+			&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK,
+						   msgid)];
+		WRITE_ONCE(wait_head->acked, 0);
+		WRITE_ONCE(wait_head->ack_data, chan_send->resp);
+		WRITE_ONCE(wait_head->ack_data_len, chan_send->resp_len);
+		WRITE_ONCE(wait_head->msg_type, chan_send->msg_type);
+		WRITE_ONCE(wait_head->msg_index,
+			   FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, msgid));
+		WRITE_ONCE(wait_head->dstid, chan_send->dstid);
+
+		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_WAITING);
+		mutex_unlock(&chan_info->pending_lock);
+
+		tx_param.msgid = msgid;
+	}
+
+	mutex_lock(&chan_info->txq_lock);
+	ret = nbl_chan_update_txqueue(chan_mgt, chan_info, &tx_param);
+	if (ret) {
+		mutex_unlock(&chan_info->txq_lock);
+		dev_err_ratelimited(dev,
+				    "Channel tx queue full, send msgtype:%u to dstid:%u failed\n",
+				    chan_send->msg_type, chan_send->dstid);
+		if (wait_head)
+			goto out_clear_wait_slot;
+		goto out_clean_inflight;
+	}
+
+	ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
+	mutex_unlock(&chan_info->txq_lock);
+	if (ret) {
+		if (wait_head)
+			goto out_clear_wait_slot;
+		goto out_clean_inflight;
+	}
+
+	if (!chan_send->ack) {
+		ret = 0;
+		goto out_clean_inflight;
+	}
+
+	if (test_bit(NBL_CHAN_IRQ_RDY, chan_info->state)) {
+		while (!READ_ONCE(wait_head->acked)) {
+			/*
+			 * avoids long task blocking when interrupt mode is
+			 * disabled mid-wait. Cannot guarantee subsequent ACK
+			 * delivery after interrupt mask off, only prevents
+			 * infinite blocking. Spurious timeout is possible.
+			 */
+			ret = wait_event_timeout(wait_head->wait_queue,
+						 READ_ONCE(wait_head->acked) ||
+						 READ_ONCE(chan_info->shutdn) ||
+						 !test_bit(NBL_CHAN_IRQ_RDY,
+							   chan_info->state),
+						 NBL_CHAN_ACK_WAIT_TIME);
+
+			if (READ_ONCE(chan_info->shutdn)) {
+				ret = -ESHUTDOWN;
+				goto out_clear_wait_slot;
+			}
+			if (!test_bit(NBL_CHAN_IRQ_RDY, chan_info->state)) {
+				ret = -EIO;
+				goto out_clear_wait_slot;
+			}
+			if (ret == 0) {
+				mutex_lock(&chan_info->pending_lock);
+				if (READ_ONCE(wait_head->status) ==
+				    NBL_MBX_STATUS_WAITING) {
+					WRITE_ONCE(wait_head->status,
+						   NBL_MBX_STATUS_TIMEOUT);
+					WRITE_ONCE(wait_head->acked, 0);
+					WRITE_ONCE(wait_head->ack_data, NULL);
+					WRITE_ONCE(wait_head->ack_data_len, 0);
+					/*
+					 * Ensure all status/ack slot
+					 * updates are visible before subsequent
+					 * readers observe acked == 0
+					 */
+					smp_wmb();
+					mutex_unlock(&chan_info->pending_lock);
+					dev_err_ratelimited(dev,
+							    "Channel waiting ack failed, message type: %d, msg id: %u\n",
+							    chan_send->msg_type,
+							    msgid);
+					ret = -ETIMEDOUT;
+					/*
+					 * TIMEOUT slots can be reused by
+					 * another sender. A late ACK is
+					 * rejected by the receive path,
+					 * which only accepts WAITING slots
+					 * (and by the msg_index generation
+					 * check after reallocation). The
+					 * current sender no longer owns the
+					 * slot, so skip the IDLE reset.
+					 */
+					goto out_clean_inflight;
+				}
+				/*
+				 * ACK won the timeout race: between the
+				 * final condition check and this lock the
+				 * receiver published acked=1/ACKD and
+				 * copied the payload into our response
+				 * buffer. The slot is still exclusively
+				 * ours (only IDLE/TIMEOUT slots are ever
+				 * reallocated), so consume the completion:
+				 * unlock and continue to the loop-bottom
+				 * acked check, which enters the normal
+				 * success readout and IDLE reset. Leaving
+				 * here via the timeout path would strand
+				 * the slot in ACKD forever, permanently
+				 * shrinking the 256-entry pool, and would
+				 * report a false -ETIMEDOUT for a request
+				 * whose response already arrived.
+				 */
+				mutex_unlock(&chan_info->pending_lock);
+			}
+
+			if (READ_ONCE(wait_head->acked))
+				break;
+		}
+		if (READ_ONCE(wait_head->acked)) {
+			/*
+			 * Load ordering: observe acked flag before
+			 * reading ACK payload metadata.
+			 */
+			smp_rmb();
+			chan_send->ack_len = READ_ONCE(wait_head->ack_data_len);
+			ret = READ_ONCE(wait_head->ack_err);
+		}
+	} else {
+		/* Polling path for synchronous ACK */
+		while (i--) {
+			if (READ_ONCE(chan_info->shutdn)) {
+				ret = -ESHUTDOWN;
+				goto out_clear_wait_slot;
+			}
+
+			mutex_lock(&chan_info->state_lock);
+			task = READ_ONCE(chan_info->clean_task);
+			if (common->wq && task &&
+			    !READ_ONCE(chan_info->shutdn) &&
+			    !work_pending(task))
+				queue_work(common->wq, task);
+			mutex_unlock(&chan_info->state_lock);
+			if (READ_ONCE(wait_head->acked)) {
+				/*
+				 * Guarantee load order: observe acked
+				 * flag before reading ack payload metadata.
+				 */
+				smp_rmb();
+				chan_send->ack_len =
+					READ_ONCE(wait_head->ack_data_len);
+				ret = READ_ONCE(wait_head->ack_err);
+				goto out_clear_wait_slot;
+			}
+
+			usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
+				     NBL_CHAN_TX_WAIT_ACK_US_MAX);
+			cond_resched();
+		}
+		mutex_lock(&chan_info->pending_lock);
+		if (READ_ONCE(wait_head->status) == NBL_MBX_STATUS_ACKD) {
+			chan_send->ack_len = READ_ONCE(wait_head->ack_data_len);
+			ret = READ_ONCE(wait_head->ack_err);
+			mutex_unlock(&chan_info->pending_lock);
+			goto out_clear_wait_slot;
+		}
+		/*
+		 * Polling timed out without receiving an ACK.  Transition
+		 * the slot to TIMEOUT so nbl_chan_get_msg_id() can reuse
+		 * it.  Must not proceed to out_clean_inflight with
+		 * the slot still in WAITING state — that would leak the
+		 * slot permanently and eventually exhaust the 256-entry
+		 * channel queue.
+		 */
+		if (READ_ONCE(wait_head->status) == NBL_MBX_STATUS_WAITING) {
+			WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_TIMEOUT);
+			WRITE_ONCE(wait_head->acked, 0);
+			WRITE_ONCE(wait_head->ack_data, NULL);
+			WRITE_ONCE(wait_head->ack_data_len, 0);
+		}
+		mutex_unlock(&chan_info->pending_lock);
+		dev_err_ratelimited(dev,
+				    "Channel polling ack failed, message type: %d msg id: %u\n",
+				    chan_send->msg_type, msgid);
+		ret = -ETIMEDOUT;
+		goto out_clean_inflight;
+	}
+
+out_clear_wait_slot:
+	mutex_lock(&chan_info->pending_lock);
+	nbl_chan_reset_wait_head(chan_info, wait_head);
+	mutex_unlock(&chan_info->pending_lock);
+
+out_clean_inflight:
+	mutex_lock(&chan_info->state_lock);
+	if (atomic_dec_and_test(&chan_info->inflight_tx_cnt))
+		wake_up(&chan_info->inflight_wait);
+	mutex_unlock(&chan_info->state_lock);
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
+	tmp = kzalloc(len, GFP_KERNEL);
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
+	mutex_lock(&chan_info->state_lock);
+	if (!READ_ONCE(chan_info->shutdn))
+		WRITE_ONCE(chan_info->clean_task, task);
+	mutex_unlock(&chan_info->state_lock);
+}
+
+static void nbl_chan_set_queue_state(struct nbl_channel_mgt *chan_mgt,
+				     enum nbl_chan_state state, u8 chan_type,
+				     u8 set)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+	int i;
+
+	if (set)
+		set_bit(state, chan_info->state);
+	else
+		clear_bit(state, chan_info->state);
+	/*
+	 * When clearing IRQ_RDY, wake all per-slot wait queues so
+	 * sleeping senders observe the condition immediately and
+	 * return -EIO instead of waiting out the 3s timeout and
+	 * reporting -ETIMEDOUT.
+	 *
+	 * wait[] is only allocated by a successful nbl_chan_init_tx_queue(),
+	 * while num_txq_entries is already set by nbl_chan_init_queue_param();
+	 * skip the walk if that allocation never happened.
+	 */
+	if (!set && state == NBL_CHAN_IRQ_RDY && chan_info->wait) {
+		for (i = 0; i < chan_info->num_txq_entries; i++)
+			wake_up_all(&chan_info->wait[i].wait_queue);
+	}
+}
+
+static struct nbl_channel_ops chan_ops = {
+	.send_msg			= nbl_chan_send_msg,
+	.send_ack			= nbl_chan_send_ack,
+	.register_msg			= nbl_chan_register_msg,
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
+		return ERR_PTR(ret);
+	ret = devm_mutex_init(common->dev, &mailbox->txq_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = devm_mutex_init(common->dev, &mailbox->state_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = devm_mutex_init(common->dev, &mailbox->pending_lock);
+	if (ret)
+		return ERR_PTR(ret);
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
+	    !chan_ops.register_msg || !chan_ops.cfg_chan_qinfo_map_table ||
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
+		return ERR_PTR(ret);
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
+	if (IS_ERR(chan_mgt))
+		return PTR_ERR(chan_mgt);
+
+	chan_ops_tbl = nbl_chan_setup_ops(dev, chan_mgt);
+	if (IS_ERR(chan_ops_tbl)) {
+		ret = PTR_ERR(chan_ops_tbl);
+		goto cleanup_mgt;
+	}
+
+	adap->intf.channel_ops_tbl = chan_ops_tbl;
+	adap->core.chan_mgt = chan_mgt;
+	ret = nbl_common_create_wq(&adap->common);
+	if (ret)
+		goto cleanup_mgt;
+	return 0;
+
+cleanup_mgt:
+	nbl_chan_remove_msg_handler(chan_mgt);
+	return ret;
+}
+
+void nbl_chan_remove_common(struct nbl_adapter *adap)
+{
+	struct nbl_channel_mgt *chan_mgt = adap->core.chan_mgt;
+
+	if (!chan_mgt)
+		return;
+	nbl_common_destroy_wq(&adap->common);
+	/*
+	 * All channel queues shall be torn down earlier in remove path
+	 * to drain inflight tx workers and stop hardware before destroying
+	 * message handler xarray.
+	 */
+	nbl_chan_remove_msg_handler(chan_mgt);
+	adap->core.chan_mgt = NULL;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
new file mode 100644
index 00000000..168f5de2
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CHANNEL_H_
+#define _NBL_CHANNEL_H_
+
+#include <linux/types.h>
+#include <linux/xarray.h>
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
+#define NBL_CHAN_TX_WAIT_ACK_US_MIN		1000
+#define NBL_CHAN_TX_WAIT_ACK_US_MAX		1200
+#define NBL_CHAN_TX_WAIT_ACK_TIMES		5000
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
+#define NBL_CHAN_RX_CLEAN_BUDGET		64
+
+enum {
+	NBL_MB_RX_QID = 0,
+	NBL_MB_TX_QID = 1,
+};
+
+enum {
+	NBL_MBX_STATUS_IDLE = 0,
+	NBL_MBX_STATUS_WAITING,
+	NBL_MBX_STATUS_ACKD,
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
+	u8 data[NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN];
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
+	/* Per-entry slots carved out of one contiguous coherent block */
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
+	int status;
+	u8 msg_index;
+	u16 dstid;
+};
+
+struct nbl_chan_info {
+	wait_queue_head_t inflight_wait;
+	struct nbl_chan_ring txq;
+	struct nbl_chan_ring rxq;
+	struct nbl_chan_waitqueue_head *wait;
+	/*
+	 * Serializes TX ring producer state (next_to_use/next_to_clean/
+	 * tail_ptr), descriptor publication and the doorbell, and the TX
+	 * queue config/stop sequences against
+	 * nbl_chan_quiesce_and_reclaim_tx().
+	 */
+	struct mutex txq_lock;
+	/*
+	 * Serializes the channel lifecycle: shutdn publication, clean_task
+	 * registration/clearing, inflight_tx_cnt transitions and the
+	 * inflight_wait wakeup.  The state bitmap is not covered by this
+	 * lock - it is only touched with atomic bit ops (set_bit(),
+	 * clear_bit(), test_bit()).
+	 */
+	struct mutex state_lock;
+	/*
+	 * Serializes the ACK wait slot array (wait[]): slot allocation in
+	 * nbl_chan_get_msg_id(), slot field publication in
+	 * nbl_chan_send_msg(), ACK completion in nbl_chan_recv_ack_msg()
+	 * and slot reset in nbl_chan_reset_wait_head().
+	 */
+	struct mutex pending_lock;
+	struct work_struct *clean_task;
+	u16 wait_head_index;
+	u16 num_txq_entries;
+	u16 num_rxq_entries;
+	u16 txq_buf_size;
+	u16 rxq_buf_size;
+	DECLARE_BITMAP(state, NBL_CHAN_STATE_NBITS);
+	u8 chan_type;
+	atomic_t inflight_tx_cnt;
+	bool shutdn;
+	bool active;
+	/*
+	 * One-shot lifecycle flag: DMA allocations use devm (descriptor/buf
+	 * arrays) and dmam (coherent descriptor ring, per-ring contiguous
+	 * buffer block) and are only released at device detach.  Teardown
+	 * only stops the hardware and clears active; it does not free
+	 * memory.  setup must never run twice on the same chan_info or the
+	 * first allocation set would be orphaned.
+	 */
+	bool dma_allocated;
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
+	/* Serializes handler_xa registration and teardown */
+	struct mutex handler_lock;
+	struct xarray handler_xa;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
new file mode 100644
index 00000000..181da46b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#include <linux/device.h>
+#include "nbl_common.h"
+
+void nbl_common_destroy_wq(struct nbl_common_info *common)
+{
+	if (!common || !common->wq)
+		return;
+
+	destroy_workqueue(common->wq);
+	common->wq = NULL;
+}
+
+int nbl_common_create_wq(struct nbl_common_info *common)
+{
+	char wq_name[32];
+
+	snprintf(wq_name, sizeof(wq_name), "nbl_wq_%s", pci_name(common->pdev));
+	common->wq = alloc_workqueue(wq_name, WQ_UNBOUND, 0);
+	if (!common->wq) {
+		dev_err(common->dev, "Failed to alloc workqueue %s\n", wq_name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
new file mode 100644
index 00000000..129073b0
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
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
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 1cd6587a..f998a2b4 100644
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
index cf40ddc4..36c58210 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -6,8 +6,257 @@
 #include <linux/pci.h>
 #include <linux/bits.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+				 u32 len)
+{
+	u32 i;
+
+	if (len % 4)
+		return;
+	if (reg >= (u64)hw_mgt->mailbox_bar_size ||
+	    reg + len > (u64)hw_mgt->mailbox_bar_size) {
+		dev_err_once(hw_mgt->common->dev,
+			     "mbx read out of range: reg=0x%llx len=%u bar_size=%pa\n",
+			     reg, len, &hw_mgt->mailbox_bar_size);
+		return;
+	}
+	for (i = 0; i < len / 4; i++)
+		data[i] = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
+static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  const u32 *data, u32 len)
+{
+	u32 i;
+
+	if (len % 4)
+		return;
+	if (reg >= (u64)hw_mgt->mailbox_bar_size ||
+	    reg + len > (u64)hw_mgt->mailbox_bar_size) {
+		dev_err_once(hw_mgt->common->dev,
+			     "mbx write out of range: reg=0x%llx len=%u bar_size=%pa\n",
+			     reg, len, &hw_mgt->mailbox_bar_size);
+		return;
+	}
+	for (i = 0; i < len / 4; i++)
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), data[i]);
+}
+
+/*
+ * Flush posted mailbox-BAR writes by reading back through the same
+ * BAR.
+ */
+static void nbl_hw_flush_mbx_write(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	u32 data;
+
+	nbl_hw_read_mbx_regs(hw_mgt, reg, &data, sizeof(data));
+}
+
+static void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+			   u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	for (i = 0; i < size; i++)
+		data[i] = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+}
+
+static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
+			   u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	for (i = 0; i < size; i++)
+		wr32(hw_mgt->hw_addr, reg + i * sizeof(u32), data[i]);
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
+/*
+ * Assert QUEUE_RST on a QINFO cfg entry, in a write of its own.
+ *
+ * The entry is four dwords and the device may act on each one as it
+ * lands, while data[3] carries QUEUE_RST/QUEUE_EN and data[0..2] carry
+ * the ring base and size.  Writing a new base while QUEUE_EN is still
+ * set from the previous configuration would have the queue fetch at a
+ * half-updated address - IOVA 0, once data[0..2] have been cleared -
+ * so the reset always goes in first, on its own, and the remaining
+ * dwords are written afterwards.  This also covers a device that only
+ * commits the entry when data[3] lands.
+ */
+static void nbl_hw_reset_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	u32 rst = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+
+	nbl_hw_write_mbx_regs(hw_mgt,
+			      reg + (MAILBOX_QINFO_CFG_TABLE_DWLEN - 1) *
+				    sizeof(u32),
+			      &rst, sizeof(rst));
+}
+
+static void nbl_hw_config_mailbox_rxq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	/* Hold the queue in reset before its base/size are reprogrammed */
+	nbl_hw_reset_mailbox_qinfo(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR);
+
+	cfg_tbl.data[0] = lower_32_bits(dma_addr);
+	cfg_tbl.data[1] = upper_32_bits(dma_addr);
+	cfg_tbl.data[2] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK,
+				     size_bwid);
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
+			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);
+	/*
+	 * data[0..2] land while QUEUE_RST is still set from the write above;
+	 * data[3] is written last and starts the queue on the new ring.
+	 */
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_config_mailbox_txq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	/* Hold the queue in reset before its base/size are reprogrammed */
+	nbl_hw_reset_mailbox_qinfo(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR);
+
+	cfg_tbl.data[0] = lower_32_bits(dma_addr);
+	cfg_tbl.data[1] = upper_32_bits(dma_addr);
+	cfg_tbl.data[2] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK,
+				     size_bwid);
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
+			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);
+	/*
+	 * data[0..2] land while QUEUE_RST is still set from the write above;
+	 * data[3] is written last and starts the queue on the new ring.
+	 */
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_stop_mailbox_rxq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	/*
+	 * Assert QUEUE_RST before data[0..2] are cleared: writing the
+	 * zeroed entry in one go would clear the ring base while QUEUE_EN
+	 * is still set.  The reset also clears QUEUE_EN, so what follows
+	 * lands on an already stopped queue.
+	 */
+	nbl_hw_reset_mailbox_qinfo(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR);
+
+	/* Now drop the stale base and size, keeping QUEUE_RST asserted */
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+	/* Ensure QUEUE_RST has reached the device before caller proceeds */
+	nbl_hw_flush_mbx_write(hw_mgt,
+			       NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR);
+}
+
+static void nbl_hw_stop_mailbox_txq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	/*
+	 * Assert QUEUE_RST before data[0..2] are cleared: writing the
+	 * zeroed entry in one go would clear the ring base while QUEUE_EN
+	 * is still set.  The reset also clears QUEUE_EN, so what follows
+	 * lands on an already stopped queue.
+	 */
+	nbl_hw_reset_mailbox_qinfo(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR);
+
+	/* Now drop the stale base and size, keeping QUEUE_RST asserted */
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+	/* Ensure QUEUE_RST has reached the device before caller proceeds */
+	nbl_hw_flush_mbx_write(hw_mgt,
+			       NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR);
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
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       &data, sizeof(data));
+	data &= ~(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK |
+		  NBL_MAILBOX_QINFO_MAP_DEVID_MASK |
+		  NBL_MAILBOX_QINFO_MAP_BUS_MASK |
+		  NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK |
+		  NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK);
+	data |= FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
+	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
+	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);
+	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       &data, sizeof(data));
+	spin_unlock(&hw_mgt->reg_lock);
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
@@ -23,6 +272,27 @@ static struct nbl_hw_mgt *nbl_hw_setup_hw_mgt(struct nbl_common_info *common)
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
@@ -43,6 +313,7 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 {
 	resource_size_t expect_sz = NBL_MEM_BAR_TOTAL_SIZE;
 	struct nbl_common_info *common = &adapter->common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl = NULL;
 	struct pci_dev *pdev = common->pdev;
 	struct nbl_hw_mgt *hw_mgt = NULL;
 	resource_size_t bar_len;
@@ -53,7 +324,7 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 	hw_mgt = nbl_hw_setup_hw_mgt(common);
 	if (IS_ERR(hw_mgt)) {
 		ret = PTR_ERR(hw_mgt);
-		goto setup_mgt_fail;
+		return ret;
 	}
 	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
 	ret = nbl_pcim_request_selected_bars(pdev, bar_mask, NBL_DRIVER_NAME);
@@ -61,14 +332,14 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 		dev_err(&pdev->dev,
 			"Request memory bar failed, err = %d\n",
 			ret);
-		goto setup_mgt_fail;
+		return ret;
 	}
 
 	bar_len = pci_resource_len(pdev, NBL_MEMORY_BAR);
 	if (!(pci_resource_flags(pdev, NBL_MEMORY_BAR) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "MEMORY BAR is not memory resource\n");
 		ret = -EINVAL;
-		goto setup_mgt_fail;
+		return ret;
 	}
 	if (common->has_ctrl) {
 		/*
@@ -90,7 +361,7 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 				"MEMORY BAR len %pa smaller than expected %pa\n",
 				&bar_len, &expect_sz);
 			ret = -EINVAL;
-			goto setup_mgt_fail;
+			return ret;
 		}
 		hw_size = PAGE_ALIGN_DOWN(NBL_MEM_BAR_TOTAL_SIZE -
 					  NBL_RDMA_NOTIFY_LEN);
@@ -103,7 +374,7 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 				"MEMORY BAR len %pa too small for net only reg space\n",
 				&bar_len);
 			ret = -EINVAL;
-			goto setup_mgt_fail;
+			return ret;
 		}
 		hw_size = NBL_REG_NET_ONLY_LEN;
 		hw_mgt->hw_addr = pcim_iomap(pdev, NBL_MEMORY_BAR,
@@ -112,37 +383,41 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 	if (!hw_mgt->hw_addr) {
 		dev_err(&pdev->dev, "MEMORY BAR pcim_iomap failed\n");
 		ret = -EIO;
-		goto setup_mgt_fail;
+		return ret;
 	}
 
 	bar_len = pci_resource_len(pdev, NBL_MAILBOX_BAR);
 	if (!(pci_resource_flags(pdev, NBL_MAILBOX_BAR) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "MAILBOX BAR is not memory resource\n");
 		ret = -EINVAL;
-		goto setup_mgt_fail;
+		return ret;
 	}
 	if (bar_len < NBL_BAR2_MAX_LEN) {
 		dev_err(&pdev->dev, "MAILBOX BAR length %pa too small\n",
 			&bar_len);
 		ret = -EINVAL;
-		goto setup_mgt_fail;
+		return ret;
 	}
 	hw_mgt->mailbox_bar_hw_addr = pcim_iomap(pdev, NBL_MAILBOX_BAR,
 						 bar_len);
 	if (!hw_mgt->mailbox_bar_hw_addr) {
 		dev_err(&pdev->dev, "MAILBOX BAR pcim_iomap failed\n");
 		ret = -EIO;
-		goto setup_mgt_fail;
+		return ret;
 	}
 
 	hw_mgt->mailbox_bar_size = bar_len;
+	spin_lock_init(&hw_mgt->reg_lock);
 
+	hw_ops_tbl = nbl_hw_setup_ops(common, hw_mgt);
+	if (IS_ERR(hw_ops_tbl)) {
+		ret = PTR_ERR(hw_ops_tbl);
+		return ret;
+	}
+	adapter->intf.hw_ops_tbl = hw_ops_tbl;
 	adapter->core.hw_mgt = hw_mgt;
 
 	return 0;
-
-setup_mgt_fail:
-	return ret;
 }
 
 void nbl_hw_remove_leonis(struct nbl_adapter *adapter)
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 1f9e509d..93e5c751 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -11,5 +11,46 @@
 #include "../../nbl_include/nbl_include.h"
 #include "../nbl_hw_reg.h"
 
+/*  ----------  REG BASE ADDR  ----------  */
+/* Interface modules base addr */
+#define NBL_INTF_HOST_PCOMPLETER_BASE		0x00f08000
+#define NBL_INTF_HOST_PADPT_BASE		0x00f4c000
+#define NBL_INTF_HOST_MAILBOX_BASE		0x00fb0000
+#define NBL_INTF_HOST_PCIE_BASE			0X01504000
+/*  --------  MAILBOX BAR2 -----  */
+#define NBL_MAILBOX_NOTIFY_ADDR			0x00000000
+#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	0x10
+#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	0x20
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
+
 #define NBL_BAR2_MAX_LEN		0x300
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
index e281109f..4c1bb789 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 
+#include "../nbl_include/nbl_def_channel.h"
 #include "../nbl_include/nbl_def_hw.h"
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
@@ -26,6 +27,37 @@ struct nbl_hw_mgt {
 	u8 __iomem *hw_addr;
 	u8 __iomem *mailbox_bar_hw_addr;
 	resource_size_t mailbox_bar_size;
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
+static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return readl(hw_mgt->mailbox_bar_hw_addr + reg);
+}
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
new file mode 100644
index 00000000..d6faa0bc
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_CHANNEL_H_
+#define _NBL_DEF_CHANNEL_H_
+
+#include <linux/types.h>
+
+struct nbl_channel_mgt;
+struct nbl_adapter;
+
+typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
+
+/*
+ * Mailbox wire opcodes, stable wire ABI shared between driver and firmware.
+ * Each opcode has a fixed assigned number to preserve compatibility.
+ * ABI compatibility rules:
+ * 1. New opcodes shall only be appended before NBL_CHAN_MSG_MAILBOX_MAX;
+ * 2. Reordering, inserting or deleting existing enumerators breaks driver-
+ *    firmware interoperability and must be avoided;
+ * 3. Modifications to existing opcodes require synchronized firmware ABI
+ *    updates.
+ *
+ * Only opcodes currently used by in-tree driver logic are defined here.
+ * Unimplemented feature opcodes (KTLS, IPsec, vDPA, mirror etc.) will be
+ * added incrementally together with their corresponding driver
+ * implementation patches.
+ */
+enum nbl_chan_msg_type {
+	NBL_CHAN_MSG_ACK = 0,
+	/* mailbox msg end */
+	NBL_CHAN_MSG_MAILBOX_MAX,
+};
+
+enum nbl_chan_state {
+	NBL_CHAN_IRQ_RDY,
+	NBL_CHAN_STATE_NBITS
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
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index ea646d1e..fda11330 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -12,6 +12,7 @@
 #include "nbl_include.h"
 
 struct nbl_common_info {
+	struct workqueue_struct *wq;
 	struct pci_dev *pdev;
 	struct device *dev;
 	u16 vsi_id;
@@ -28,4 +29,6 @@ struct nbl_common_info {
 	u8 has_net;
 };
 
+void nbl_common_destroy_wq(struct nbl_common_info *common);
+int nbl_common_create_wq(struct nbl_common_info *common);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index ecbf440e..6cb84371 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,48 @@
 
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
+	/**
+	 * get_host_pf_mask - Fetch host PF mask from firmware k_pf_mask reg
+	 * @hw_mgt: hardware management context
+	 * @pf_mask: output pointer for PF mask value
+	 *
+	 * k_pf_mask register rule:
+	 *   bit N == 0 -> PF#N enabled; bit N == 1 -> PF#N masked out.
+	 *   bit0 is PF0's mask bit (not reserved); PF0 can be masked but
+	 *   the driver requires at least PF0 enabled.
+	 *   Only 1/2/4 PFs are supported:
+	 *     1 PF  (PF0):     mask = 0xfe
+	 *     2 PFs (PF0,PF1): mask = 0xfc
+	 *     4 PFs (PF0~PF3): mask = 0xf0
+	 *   All-zero mask (0x00) means all 8 PFs enabled, which is
+	 *   unsupported by the driver.
+	 *
+	 * This op only returns the raw register value and does not validate
+	 * it.  Neither consumer exists yet at the commit that introduces it:
+	 * the resource layer, which validates the value, and the channel
+	 * layer, which programs the mailbox QINFO table from it, both arrive
+	 * later in this series, and validation runs before the channel layer
+	 * reads the mask.
+	 */
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
index 14e7b19f..f2d80239 100644
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
index f2552bc7..9a24af5d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,11 +7,22 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_def_channel.h"
 #include "nbl_include/nbl_def_hw.h"
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
+/*
+ * Budget for the device_trylock() loop that takes func 0's device lock in
+ * nbl_probe_chip_deps().  See the comment there for why a single failed
+ * trylock must not defer the probe, and why the wait has to stay bounded.
+ */
+#define NBL_MGT_LOCK_RETRY_MIN_US	1000
+#define NBL_MGT_LOCK_RETRY_MAX_US	2000
+#define NBL_MGT_LOCK_MAX_RETRIES	50
+
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param)
 {
@@ -36,15 +47,21 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 
 	ret = nbl_hw_init_leonis(adapter);
 	if (ret)
-		goto hw_init_fail;
+		goto out;
 
+	ret = nbl_chan_init_common(adapter);
+	if (ret)
+		goto out_hw_remove;
 	return adapter;
-hw_init_fail:
+out_hw_remove:
+	nbl_hw_remove_leonis(adapter);
+out:
 	return ERR_PTR(ret);
 }
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_chan_remove_common(adapter);
 	nbl_hw_remove_leonis(adapter);
 }
 
@@ -67,6 +84,164 @@ static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
 		param->caps.has_ctrl = 1;
 }
 
+/*
+ * Establish chip-wide dependencies for this PF:
+ *  - for every non-management PF, add a consumer->management PF device
+ *    link. The driver core then guarantees (sysfs unbind, driver
+ *    unregister, hot-unplug alike) that this consumer is released
+ *    BEFORE the func 0 supplier, which is the only teardown order in
+ *    which the chip-global firmware deinit is safe.
+ *
+ * The management PF is addressed by the deterministic identity
+ * (domain, bus, slot, func 0) instead of any name-based scan: hardware
+ * guarantees PFs are contiguous from func 0 in the same slot.
+ *
+ * The func 0 device must already be bound to this driver.  While func 0
+ * is still probing, its chip-global init (mailbox QINFO map programming,
+ * datapath setup) can race a sibling's mailbox setup, and a link created
+ * while the supplier has no driver starts DORMANT and is force-promoted
+ * (with a WARN backtrace) by device_links_driver_bound() when this probe
+ * ends, so it never delivers the unbind-order guarantee.
+ *
+ * The link is a persistent managed link with DL_FLAG_AUTOPROBE_CONSUMER:
+ * the core force-unbinds this consumer when func 0 unbinds (keeping the
+ * teardown order) and re-queues it for probe when func 0 binds again, so
+ * the sibling PFs and their ports come back without a manual rebind.
+ * AUTOREMOVE_CONSUMER would delete the link on unbind and cannot be
+ * combined with AUTOPROBE_CONSUMER (device_link_add() returns NULL for
+ * that pair).  The link is therefore not auto-purged on a failed probe:
+ * it lives with the two devices and is dropped when either is removed.
+ * The pointer device_link_add() returns is never dereferenced.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int nbl_probe_chip_deps(struct pci_dev *pdev, bool has_ctrl)
+{
+	struct pci_dev *mgt;
+	int retries;
+
+	if (has_ctrl)
+		return 0;
+
+	mgt = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					  pdev->bus->number,
+					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
+	if (!mgt) {
+		dev_err(&pdev->dev,
+			"management PF (func 0) not found on this chip\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * That identity is meaningless for a VF: under ARI a VF's devfn
+	 * decodes to function 0 of a slot, so the lookup can resolve to the
+	 * VF itself.  A VF is never the management PF, so stop here instead
+	 * of taking our own device lock below.
+	 */
+	if (mgt == pdev) {
+		dev_err(&pdev->dev,
+			"management PF lookup matched this device\n");
+		pci_dev_put(mgt);
+		return -ENODEV;
+	}
+
+	/*
+	 * func 0's device lock is taken with a trylock.  This probe already
+	 * runs under device_lock(funcN), so a blocking device_lock(func0)
+	 * would establish the N -> 0 order, while __pci_bus_lock() (AER
+	 * recovery, slot reset) walks the bus in devfn order, i.e. 0 -> N,
+	 * and dev->mutex is lockdep_set_novalidate_class(), so lockdep
+	 * cannot report that inversion.  A trylock never blocks, so it
+	 * cannot take part in a deadlock cycle.
+	 *
+	 * Holding the lock is what makes the check and the link creation
+	 * below atomic with respect to func 0: it both gains its driver
+	 * (driver_bound() -> device_links_driver_bound()) and loses it
+	 * (__device_release_driver() -> device_links_driver_cleanup())
+	 * under device_lock(func0), so func 0 can change neither driver nor
+	 * links.status while we hold it.
+	 *
+	 * One failed trylock is nevertheless not enough to defer on.  Func 0
+	 * binds with device_lock(func0) held, and driver_bound() calls
+	 * driver_deferred_probe_trigger() before it releases that lock, so
+	 * the deferred probe work it queues can re-probe this PF while func
+	 * 0's lock is still taken.  driver_probe_device() only re-arms that
+	 * work when deferred_trigger_count changes *during* the probe, which
+	 * it does not here: func 0's increment happened before this probe
+	 * read the count.  A bare -EPROBE_DEFER would therefore leave this
+	 * PF on deferred_probe_pending_list with nothing scheduled to run
+	 * it again.  Retrying closes that window - driver_bound() has only a
+	 * bus_notify() and a kobject_uevent() left before it drops the lock.
+	 *
+	 * The retry budget is what keeps this safe.  device_lock(funcN) is
+	 * held for the whole loop, so waiting indefinitely would deadlock
+	 * against __pci_bus_lock(); giving up and deferring releases it and
+	 * lets the other side make progress.  A holder that is not part of a
+	 * bind - __pci_bus_lock() during AER recovery or a bus/slot reset,
+	 * pci_reset_function() through sysfs, an sriov_numvfs write - can
+	 * outlast the budget, and no bind event follows those, so this PF
+	 * then stays deferred until some later deferred-probe trigger from
+	 * anywhere in the system.  There is no way to force one from here.
+	 */
+	for (retries = 0; !device_trylock(&mgt->dev); retries++) {
+		if (retries == NBL_MGT_LOCK_MAX_RETRIES) {
+			dev_dbg(&pdev->dev,
+				"management PF device lock busy after %u retries, deferring probe\n",
+				retries);
+			pci_dev_put(mgt);
+			return -EPROBE_DEFER;
+		}
+		usleep_range(NBL_MGT_LOCK_RETRY_MIN_US,
+			     NBL_MGT_LOCK_RETRY_MAX_US);
+	}
+
+	/*
+	 * The management PF must be bound to *this* driver, with its probe
+	 * completed.  links.status == DL_DEV_DRIVER_BOUND alone only says
+	 * "bound to some driver", so func 0 on vfio-pci or pci-stub
+	 * (driver_override) would pass it and this PF would run with func
+	 * 0's chip-global init never performed.  pdev->dev.driver is our
+	 * own driver, set by the core before ->probe() is called.
+	 *
+	 * Deferring is what recovers from this: a successful bind
+	 * re-triggers deferred probing for every pending device
+	 * (driver_bound() -> driver_deferred_probe_trigger()), so this PF is
+	 * retried once func 0 is bound to this driver.  That covers a func 0
+	 * that is not bound yet.  It does not cover a func 0 that is bound
+	 * while something else holds its device lock, which is what the
+	 * retry loop above is for and what its budget cannot fully rule out.
+	 */
+	if (mgt->dev.driver != pdev->dev.driver ||
+	    mgt->dev.links.status != DL_DEV_DRIVER_BOUND) {
+		device_unlock(&mgt->dev);
+		pci_dev_put(mgt);
+		return -EPROBE_DEFER;
+	}
+
+	/*
+	 * Create the link while func 0's lock is still held, so that func 0
+	 * cannot change state in between.  With the supplier bound and this
+	 * consumer PROBING, device_link_init_status() starts the link in
+	 * DL_STATE_CONSUMER_PROBE: that is the state
+	 * device_links_driver_bound() expects when this probe finishes, and
+	 * it is what device_links_busy() reports to func 0's own unbind, so
+	 * func 0 cannot be released underneath this PF.
+	 */
+	if (!device_link_add(&pdev->dev, &mgt->dev,
+			     DL_FLAG_AUTOPROBE_CONSUMER)) {
+		device_unlock(&mgt->dev);
+		dev_err(&pdev->dev,
+			"failed to create device link to management PF\n");
+		pci_dev_put(mgt);
+		return -ENOMEM;
+	}
+
+	device_unlock(&mgt->dev);
+	pci_dev_put(mgt);
+
+	return 0;
+}
+
 static int nbl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *id)
 {
@@ -75,27 +250,32 @@ static int nbl_probe(struct pci_dev *pdev,
 	struct nbl_adapter *adapter;
 	int err;
 
+	nbl_get_func_param(pdev, id->driver_data, &param);
 	err = pcim_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
 		return err;
 	}
 
-	nbl_get_func_param(pdev, id->driver_data, &param);
 	/* never return fail when DMA_BIT_MASK(64) */
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
 	pci_set_master(pdev);
 
+	err = nbl_probe_chip_deps(pdev, param.caps.has_ctrl);
+	if (err)
+		goto out_clear_master;
+
 	adapter = nbl_core_init(pdev, &param);
 	if (IS_ERR(adapter)) {
 		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
 		err = PTR_ERR(adapter);
-		goto adapter_init_err;
+		goto out_clear_master;
 	}
 	pci_set_drvdata(pdev, adapter);
+
 	return 0;
-adapter_init_err:
+out_clear_master:
 	pci_clear_master(pdev);
 	return err;
 }
-- 
2.51.0.windows.1

