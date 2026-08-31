Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9B3C4563;
	Mon, 31 Aug 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161848; cv=none; b=can7Ubza+WaEXTl33tQEnF2t6UhxSujTi9Pm4Rb9X1CU5+UgexypuU6Apb7cqQbMtEMWnS0Ft7+2wVzpe+xIr5aiMpzvrEM/ZlW6YHr2zxJJ6oaQesd2sLaJn8RNHjKtfdkRkRJdXXUO704xPLh3dngBE48p6JYcF4qx1elSj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161848; c=relaxed/simple;
	bh=97oClA2CxliC+gHE77gUHLGUcbYNzhXPsKAEpf8Og0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU+paKLdPXr4C5i3VkR9OcPc+PAmokUcnJEEZnRu0Cty1TjhbcMSc5+A7Ge+gnWGOj/FHr0ErzFcFHm5TWPULInLru93AdEfq2by60ix3kjIY/ChD2N+P6R2oAim93uKlJLnc5Cy4EO1bTnNTFVlRCi9pLMOCNDlok49enbOy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1788161778tdfb885c7
X-QQ-Originating-IP: gw54gslMuQMQ/OSp0XX1VJlqOAwgTmr/4drZy6lyF/g=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:36:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4568099371273574317
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v10 1/5] net: rnpgbe: Add interrupt handling
Date: Mon, 31 Aug 2026 15:36:04 +0800
Message-ID: <F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260831073608.401988-1-dong100@mucse.com>
References: <20260831073608.401988-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OHSUP3LVL1ezDGy4sFd83ODzyuSYHi3jAZ3EPgo9IRMGxBT0cpRLgVKT
	y/wWmwajbd5pqDfLs+5DShQGpOeBF9fVeSiQ4av3b/iBKSyHUB0iqDSaKgu6nS/TQ2fsgXA
	tJ4+qRl4OpzWQVzd0lo5pM25DZUTrd0d6QJbt4vQCwauT4fqN/OyzxrQL3vfWeYCSm8/mTc
	yaPAZBi0PCeRpuFA3hIV0l6VEnalimdfQxPhdFCUE8J0HyDcIj7jwXfXwxYNOrWTEdy8K2X
	1FYqDm79ckkEu1XAJ85MHXS7uD8lxq7rRbD2RZFlVBaV/jy+/uZGTyN9xesEeDxgaX7laDY
	tBi7qQ+osF6YogGmq/J908WL+gwRnS00Oteyk4VBvFmULqLBEgEyDwKhQuuvuefZdCYZLng
	d8pUngGS7VClIBD7Am1IWQG8mH+JglT3QFpuMvGQGcG4pTMXTA71ug5Fh/S222DmjgKfCQ/
	/XB4uGy2tWIN9tyU7OmSwIS3SOHtkziQBp2KOtM9dqXyFP+mLbHnPkgqaEUFShEg5dN7SYQ
	75fj2CzO+nv0cw+W6RSbFndZIpORv8hDVnMTeW5sBQR5WQfq1Eyrj4ik4WyunEeOvM34AJS
	2+k1jATAyT9Pn98H9Qfn63CWDSharPICF2DsaUy6jvxzDlTjdYeuRF6/muCj+EDKRwHQvoI
	oYmJMc03HksqFNrZ3b7sru7Cljp0w4kf1roQ/jdhtslsG6VfcWg2Uzk8YcGRlBQ6KFQSUY2
	fKNgan0TczVn4PSzyOjfFsHyWw/y/kvpEXHfEWAlrwRkjLbccrBjyrELf7NjGhmoQEThl7a
	kRdODNc1/xRcyiXni1RiT67a+rCQ1cpidsz5LQUTNiu5N863T03nWPrr7NIRwsPlXXKr2ZC
	4tHIjO2jGTxR3fbERBU9nUhWewsGBKWb5NTDWwX29iQXlnJfztN3cVXSWJBpRY002nBwu3S
	g1thk/LQH+JzvHNdtgsRI5zikolJpEIG1HuZ9sDG+JHJFAkd+O05tE/ZlIZKtPAyJjN0Rmm
	y3c6pQloj6YE1frsX/k4mqXDddFG1+SQVWjhV1xA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Add interrupt support for the RNPGBE driver.

Set up and tear down MSI-X/MSI vectors and NAPI. Add mailbox IRQ and
workqueue plumbing to defer firmware mailbox notifications from hard-IRQ
context. Queue mailbox work on system_percpu_wq.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  55 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   4 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 663 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  34 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  52 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  12 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  11 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   1 +
 10 files changed, 828 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index de8bcb7772ab..17574cad392a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o\
 	       rnpgbe_chip.o\
 	       rnpgbe_mbx.o\
-	       rnpgbe_mbx_fw.o
+	       rnpgbe_mbx_fw.o\
+	       rnpgbe_lib.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 5b024f9f7e17..77304196c2b6 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,11 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/if.h>
+#include <linux/workqueue.h>
+
+#include "rnpgbe_hw.h"
 
 enum rnpgbe_boards {
 	board_n500,
@@ -35,21 +40,69 @@ enum {
 
 struct mucse_hw {
 	void __iomem *hw_addr;
+	void __iomem *ring_msix_base;
 	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
 	int port;
 	u8 pfvfnum;
 };
 
+struct mucse_ring {
+	struct mucse_ring *next;
+	struct mucse_q_vector *q_vector;
+	void __iomem *ring_addr;
+	void __iomem *irq_mask;
+	void __iomem *trig;
+	u8 queue_index;
+	/* hw ring idx */
+	u8 rnpgbe_queue_idx;
+} ____cacheline_internodealigned_in_smp;
+
+struct mucse_ring_container {
+	struct mucse_ring *ring;
+	u16 count;
+};
+
+struct mucse_q_vector {
+	struct mucse *mucse;
+	/* hardware interrupt vector number */
+	int hw_vector;
+	struct mucse_ring_container rx, tx;
+	struct napi_struct napi;
+	char name[IFNAMSIZ + 18];
+	/* for dynamic allocation of rings associated with this q_vector */
+	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
+};
+
 struct mucse_stats {
 	u64 tx_dropped;
 };
 
+#define MAX_Q_VECTORS 8
+
+enum mucse_state_t {
+	__MUCSE_DOWN,
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
 	struct mucse_stats stats;
+#define M_FLAG_MSIX_SINGLE_EN      BIT(0)
+#define M_FLAG_MSIX_EN             BIT(1)
+	u32 flags;
+	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
+		____cacheline_aligned_in_smp;
+	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
+		____cacheline_aligned_in_smp;
+	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
+	int num_tx_queues;
+	int num_q_vectors;
+	int num_rx_queues;
+	char mbx_name[32];
+	unsigned long state;
+	struct work_struct mbx_work;
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -68,4 +121,6 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 
 #define mucse_hw_wr32(hw, reg, val) \
 	writel((val), (hw)->hw_addr + (reg))
+#define mucse_hw_rd32(hw, reg) \
+	readl((hw)->hw_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index ebc7b3750157..921cc325a991 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -89,6 +89,8 @@ static void rnpgbe_init_n500(struct mucse_hw *hw)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->ring_msix_base = hw->hw_addr + MUCSE_N500_RING_MSIX_BASE;
+
 	mbx->fwpf_ctrl_base = MUCSE_N500_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N500_FWPF_SHM_BASE;
 }
@@ -104,6 +106,8 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->ring_msix_base = hw->hw_addr + MUCSE_N210_RING_MSIX_BASE;
+
 	mbx->fwpf_ctrl_base = MUCSE_N210_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N210_FWPF_SHM_BASE;
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index e77e6bc3d3e3..0dce78e4a91b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -6,10 +6,12 @@
 
 #define MUCSE_N500_FWPF_CTRL_BASE      0x28b00
 #define MUCSE_N500_FWPF_SHM_BASE       0x2d000
+#define MUCSE_N500_RING_MSIX_BASE      0x28700
 #define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
 #define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
 #define MUCSE_N210_FWPF_CTRL_BASE      0x29400
 #define MUCSE_N210_FWPF_SHM_BASE       0x2d900
+#define MUCSE_N210_RING_MSIX_BASE      0x29000
 
 #define RNPGBE_DMA_AXI_EN              0x0010
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
new file mode 100644
index 000000000000..f511a3a5f916
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -0,0 +1,663 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+
+#include "rnpgbe_lib.h"
+#include "rnpgbe.h"
+#include "rnpgbe_mbx_fw.h"
+
+static void rnpgbe_mbx_work(struct work_struct *work)
+{
+	struct mucse *mucse = container_of(work, struct mucse, mbx_work);
+
+	mucse_fw_irq_handler(&mucse->hw);
+}
+
+/**
+ * rnpgbe_msix_other - Other irq handler
+ * @irq: interrupt number
+ * @data: private data
+ *
+ * Return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_msix_other(int irq, void *data)
+{
+	struct mucse *mucse = (struct mucse *)data;
+
+	queue_work(system_percpu_wq, &mucse->mbx_work);
+
+	return IRQ_HANDLED;
+}
+
+static void rnpgbe_irq_disable_queues(struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	/*
+	 * TX/RX pairs share interrupt control registers; update them through
+	 * the TX ring list.
+	 */
+	mucse_for_each_ring(ring, q_vector->tx) {
+		writel(INT_VALID, ring->trig);
+		writel((RX_INT_MASK | TX_INT_MASK), ring->irq_mask);
+	}
+
+	/* flush posted writes to ensure hardware sees the mask */
+	if (q_vector->tx.ring)
+		readl(q_vector->tx.ring->irq_mask);
+}
+
+/**
+ * rnpgbe_int_single - MSI-X single-vector/MSI interrupt handler
+ * @irq: interrupt number
+ * @data: private data
+ *
+ * Return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_int_single(int irq, void *data)
+{
+	struct mucse *mucse = (struct mucse *)data;
+	struct mucse_q_vector *q_vector;
+
+	queue_work(system_percpu_wq, &mucse->mbx_work);
+
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return IRQ_HANDLED;
+
+	q_vector = mucse->q_vector[0];
+	rnpgbe_irq_disable_queues(q_vector);
+	napi_schedule_irqoff(&q_vector->napi);
+
+	return IRQ_HANDLED;
+}
+
+static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	/*
+	 * TX/RX pairs share interrupt control registers; update them through
+	 * the TX ring list.
+	 */
+	mucse_for_each_ring(ring, q_vector->tx) {
+		writel(0, ring->irq_mask);
+
+		/* Re-trigger hw to re-check events lost while masked. */
+		writel(INT_VALID | TX_INT_MASK | RX_INT_MASK, ring->trig);
+	}
+}
+
+/**
+ * rnpgbe_poll - NAPI polling callback
+ * @napi: structure for representing this polling device
+ * @budget: polling budget
+ *
+ * Complete NAPI polling and re-enable queue interrupts. Ring cleaning is
+ * added when TX and RX support is enabled.
+ *
+ * Return: 0
+ **/
+static int rnpgbe_poll(struct napi_struct *napi, int budget)
+{
+	struct mucse_q_vector *q_vector =
+		container_of(napi, struct mucse_q_vector, napi);
+	int work_done = 0;
+
+	/* Exit if we are called by netpoll */
+	if (unlikely(!budget))
+		return 0;
+
+	if (likely(napi_complete_done(napi, work_done)))
+		rnpgbe_irq_enable_queues(q_vector);
+
+	return work_done;
+}
+
+/**
+ * rnpgbe_request_mbx_irq - Register mbx routine
+ * @mucse: pointer to private structure
+ *
+ * In MSIX mode, register a dedicated handler for vector 0 (mailbox)
+ * In MSI/MSI-X_SINGLE mode, mailbox is multiplexed through
+ * data tx/rx handler.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int rnpgbe_request_mbx_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+	int err = 0;
+
+	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
+		 "rnpgbe-mbx:%s", pci_name(pdev));
+	INIT_WORK(&mucse->mbx_work, rnpgbe_mbx_work);
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		err = request_irq(pci_irq_vector(pdev, 0),
+				  rnpgbe_msix_other, 0, mucse->mbx_name,
+				  mucse);
+	} else {
+		err = request_irq(pci_irq_vector(pdev, 0),
+				  rnpgbe_int_single, 0, mucse->mbx_name,
+				  mucse);
+	}
+
+	return err;
+}
+
+/**
+ * rnpgbe_free_mbx_irq - Remove mbx routine
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_free_mbx_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+
+	free_irq(pci_irq_vector(pdev, 0), mucse);
+	cancel_work_sync(&mucse->mbx_work);
+}
+
+/**
+ * rnpgbe_set_num_queues - Allocate queues for device, feature dependent
+ * @mucse: pointer to private structure
+ *
+ * Determine tx/rx queue counts
+ **/
+static void rnpgbe_set_num_queues(struct mucse *mucse)
+{
+	/* start from 1 queue */
+	mucse->num_tx_queues = 1;
+	mucse->num_rx_queues = 1;
+}
+
+/**
+ * rnpgbe_set_interrupt_capability - Set MSI-X or MSI if supported
+ * @mucse: pointer to private structure
+ *
+ * Attempt to configure the interrupts using the best available
+ * capabilities of the hardware.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
+{
+	int v_budget;
+
+	v_budget = min3(mucse->num_tx_queues, mucse->num_rx_queues,
+			MAX_Q_VECTORS);
+	v_budget = min_t(int, v_budget, num_online_cpus());
+	/* add one vector for mbx */
+	v_budget += 1;
+
+	/* Hardware limitation: only 1 MSI vector is supported even
+	 * if multiple messages are requested. MSI mode falls back
+	 * to single vector automatically.
+	 */
+	v_budget = pci_alloc_irq_vectors(mucse->pdev, 1, v_budget,
+					 PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (v_budget < 0)
+		return v_budget;
+
+	if (mucse->pdev->msix_enabled) {
+		/* q_vector not include mbx */
+		if (v_budget > 1) {
+			mucse->flags |= M_FLAG_MSIX_EN;
+			mucse->num_q_vectors = v_budget - 1;
+		} else {
+			mucse->flags |= M_FLAG_MSIX_SINGLE_EN;
+			mucse->num_q_vectors = 1;
+		}
+	} else {
+		/* Hardware supports only one MSI interrupt. */
+		mucse->num_q_vectors = 1;
+	}
+
+	return 0;
+}
+
+/**
+ * mucse_add_ring - Add ring to ring container
+ * @ring: ring to be added
+ * @head: ring container
+ **/
+static void mucse_add_ring(struct mucse_ring *ring,
+			   struct mucse_ring_container *head)
+{
+	ring->next = head->ring;
+	head->ring = ring;
+	head->count++;
+}
+
+/**
+ * rnpgbe_alloc_q_vector - Allocate memory for a single interrupt vector
+ * @mucse: pointer to private structure
+ * @eth_queue_idx: queue_index idx for this q_vector
+ * @vector_idx: q_vector array index
+ * @r_idx: starting hardware ring index
+ * @r_count: number of TX/RX ring pairs
+ * @step: ring step
+ *
+ * Return: 0 on success. If allocation fails we return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vector(struct mucse *mucse,
+				 int eth_queue_idx, int vector_idx, int r_idx,
+				 int r_count, int step)
+{
+	int rxr_idx = r_idx, txr_idx = r_idx;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_q_vector *q_vector;
+	int txr_count, rxr_count, idx;
+	struct mucse_ring *ring;
+	int ring_count;
+
+	/*
+	 * TX and RX rings are always allocated as pairs with the same hardware
+	 * ring index. Interrupt control is shared by the pair, so the TX ring
+	 * list is used to update the common registers.
+	 */
+	txr_count = r_count;
+	rxr_count = r_count;
+	ring_count = txr_count + rxr_count;
+
+	q_vector = kzalloc_flex(*q_vector, ring, ring_count);
+	if (!q_vector)
+		return -ENOMEM;
+
+	netif_napi_add(mucse->netdev, &q_vector->napi, rnpgbe_poll);
+	/* tie q_vector and mucse together */
+	mucse->q_vector[vector_idx] = q_vector;
+	q_vector->mucse = mucse;
+	q_vector->hw_vector = vector_idx;
+	/* if mbx use separate irq, we should add 1 */
+	if (mucse->flags & M_FLAG_MSIX_EN)
+		q_vector->hw_vector++;
+
+	ring = q_vector->ring;
+
+	for (idx = 0; idx < txr_count; idx++) {
+		mucse_add_ring(ring, &q_vector->tx);
+		ring->queue_index = eth_queue_idx + idx;
+		ring->rnpgbe_queue_idx = txr_idx;
+		ring->ring_addr = hw->hw_addr + RING_OFFSET(txr_idx);
+		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
+		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
+		ring->q_vector = q_vector;
+		mucse->tx_ring[ring->queue_index] = ring;
+		txr_idx += step;
+		ring++;
+	}
+
+	for (idx = 0; idx < rxr_count; idx++) {
+		mucse_add_ring(ring, &q_vector->rx);
+		ring->queue_index = eth_queue_idx + idx;
+		ring->rnpgbe_queue_idx = rxr_idx;
+		ring->ring_addr = hw->hw_addr + RING_OFFSET(rxr_idx);
+		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
+		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
+		ring->q_vector = q_vector;
+		mucse->rx_ring[ring->queue_index] = ring;
+		rxr_idx += step;
+		ring++;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_free_q_vector - Free memory allocated for specific interrupt vector
+ * @mucse: pointer to private structure
+ * @vector_idx: q_vector array index
+ *
+ * This function frees the memory allocated to the q_vector.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ **/
+static void rnpgbe_free_q_vector(struct mucse *mucse, int vector_idx)
+{
+	struct mucse_q_vector *q_vector = mucse->q_vector[vector_idx];
+	struct mucse_ring *ring;
+
+	mucse_for_each_ring(ring, q_vector->tx)
+		mucse->tx_ring[ring->queue_index] = NULL;
+	mucse_for_each_ring(ring, q_vector->rx)
+		mucse->rx_ring[ring->queue_index] = NULL;
+	mucse->q_vector[vector_idx] = NULL;
+	netif_napi_del(&q_vector->napi);
+	kfree(q_vector);
+}
+
+/**
+ * rnpgbe_alloc_q_vectors - Allocate memory for interrupt vectors
+ * @mucse: pointer to private structure
+ *
+ * Return: 0 on success, or -ENOMEM on allocation failure.
+ **/
+static int rnpgbe_alloc_q_vectors(struct mucse *mucse)
+{
+	int err, ring_cnt, v_remaining = mucse->num_q_vectors;
+	int r_remaining = min_t(int, mucse->num_tx_queues,
+			      mucse->num_rx_queues);
+	int num_q_vectors = 0;
+	int eth_queue_idx = 0;
+	int vector_idx = 0;
+	int ring_step = 1;
+	int ring_idx = 0;
+
+	for (; r_remaining > 0 && v_remaining > 0; v_remaining--) {
+		ring_cnt = DIV_ROUND_UP(r_remaining, v_remaining);
+		err = rnpgbe_alloc_q_vector(mucse, eth_queue_idx,
+					    vector_idx, ring_idx, ring_cnt,
+					    ring_step);
+		if (err)
+			goto err_free_q_vector;
+		ring_idx += ring_step * ring_cnt;
+		eth_queue_idx += ring_cnt;
+		r_remaining -= ring_cnt;
+		num_q_vectors++;
+		vector_idx++;
+	}
+	/* Record the number of queue vectors actually allocated */
+	mucse->num_q_vectors = num_q_vectors;
+	mucse->num_tx_queues = eth_queue_idx;
+	mucse->num_rx_queues = eth_queue_idx;
+
+	return 0;
+
+err_free_q_vector:
+	mucse->num_tx_queues = 0;
+	mucse->num_rx_queues = 0;
+	mucse->num_q_vectors = 0;
+
+	while (vector_idx--)
+		rnpgbe_free_q_vector(mucse, vector_idx);
+
+	return err;
+}
+
+/**
+ * rnpgbe_reset_interrupt_capability - Reset irq capability setup
+ * @mucse: pointer to private structure
+ **/
+static void rnpgbe_reset_interrupt_capability(struct mucse *mucse)
+{
+	pci_free_irq_vectors(mucse->pdev);
+	mucse->flags &= ~(M_FLAG_MSIX_EN |
+			M_FLAG_MSIX_SINGLE_EN);
+}
+
+/**
+ * rnpgbe_init_interrupt_scheme - Determine proper interrupt scheme
+ * @mucse: pointer to private structure
+ *
+ * We determine which interrupt scheme to use based on...
+ * - Hardware queue count
+ * - cpu count
+ * - interrupt mode (MSI and single-vector MSI-X use one vector)
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse)
+{
+	int err;
+
+	rnpgbe_set_num_queues(mucse);
+
+	err = rnpgbe_set_interrupt_capability(mucse);
+	if (err)
+		return err;
+
+	err = rnpgbe_alloc_q_vectors(mucse);
+	if (err) {
+		rnpgbe_reset_interrupt_capability(mucse);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_free_q_vectors - Free memory allocated for interrupt vectors
+ * @mucse: pointer to private structure
+ *
+ * This function frees the memory allocated to the q_vectors.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ **/
+static void rnpgbe_free_q_vectors(struct mucse *mucse)
+{
+	int vector_idx = mucse->num_q_vectors;
+
+	mucse->num_rx_queues = 0;
+	mucse->num_tx_queues = 0;
+	mucse->num_q_vectors = 0;
+
+	while (vector_idx--)
+		rnpgbe_free_q_vector(mucse, vector_idx);
+}
+
+/**
+ * rnpgbe_clear_interrupt_scheme - Clear the current interrupt scheme settings
+ * @mucse: pointer to private structure
+ *
+ * Clear interrupt specific resources and reset the structure
+ **/
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse)
+{
+	mucse->num_tx_queues = 0;
+	mucse->num_rx_queues = 0;
+	rnpgbe_free_q_vectors(mucse);
+	rnpgbe_reset_interrupt_capability(mucse);
+}
+
+/**
+ * rnpgbe_msix_clean_rings - MSI-x interrupt handler for ring irq
+ * @irq: interrupt number
+ * @data: private data
+ *
+ * rnpgbe_msix_clean_rings handle irq from ring, start napi
+ * Return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
+{
+	struct mucse_q_vector *q_vector = (struct mucse_q_vector *)data;
+
+	rnpgbe_irq_disable_queues(q_vector);
+	napi_schedule_irqoff(&q_vector->napi);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * rnpgbe_request_irq - Initialize interrupts
+ * @mucse: pointer to private structure
+ *
+ * Attempts to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ *
+ * Return: 0 on success, negative value on failure
+ **/
+int rnpgbe_request_irq(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_q_vector *q_vector;
+	int err, i;
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		for (i = 0; i < mucse->num_q_vectors; i++) {
+			q_vector = mucse->q_vector[i];
+
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-%s-%d", netdev->name, "TxRx", i);
+
+			err = request_irq(pci_irq_vector(pdev, i + 1),
+					  rnpgbe_msix_clean_rings, 0,
+					  q_vector->name,
+					  q_vector);
+			if (err) {
+				dev_err(&pdev->dev, "MSI-X req err %d: %d\n",
+					i + 1, err);
+				goto err_free_irqs;
+			}
+		}
+	}
+
+	return 0;
+err_free_irqs:
+	while (i--) {
+		q_vector = mucse->q_vector[i];
+		synchronize_irq(pci_irq_vector(pdev, i + 1));
+		free_irq(pci_irq_vector(pdev, i + 1), q_vector);
+	}
+
+	return err;
+}
+
+/**
+ * rnpgbe_free_irq - Free interrupts
+ * @mucse: pointer to private structure
+ *
+ * Attempts to free interrupts according initialized type.
+ **/
+void rnpgbe_free_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_q_vector *q_vector;
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		for (int i = 0; i < mucse->num_q_vectors; i++) {
+			q_vector = mucse->q_vector[i];
+			if (!q_vector)
+				continue;
+
+			free_irq(pci_irq_vector(pdev, i + 1), q_vector);
+		}
+	}
+}
+
+/**
+ * rnpgbe_set_ring_vector - Set the ring_vector registers,
+ * mapping interrupt causes to vectors
+ * @mucse: pointer to private structure
+ * @queue: queue to map the corresponding interrupt to
+ * @vector: the vector num to map to the corresponding queue
+ *
+ */
+static void rnpgbe_set_ring_vector(struct mucse *mucse,
+				   u8 queue, u8 vector)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 data;
+
+	data = hw->pfvfnum << 24;
+	data |= (vector << 8);
+	data |= vector;
+	writel(data, hw->ring_msix_base + RING_VECTOR(queue));
+}
+
+/**
+ * rnpgbe_configure_msi - Configure MSI hardware
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_configure_msi sets up the hardware to properly generate MSI
+ * interrupts.
+ **/
+static void rnpgbe_configure_msi(struct mucse *mucse)
+{
+	struct mucse_q_vector *q_vector = mucse->q_vector[0];
+	struct mucse_ring *ring;
+
+	/* TX/RX pairs share vector registers. Update them through TX. */
+	mucse_for_each_ring(ring, q_vector->tx)
+		rnpgbe_set_ring_vector(mucse, ring->rnpgbe_queue_idx, 0);
+}
+
+/**
+ * rnpgbe_configure_msix - Configure MSI-X hardware
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_configure_msix sets up the hardware to properly generate MSI-X
+ * interrupts.
+ **/
+static void rnpgbe_configure_msix(struct mucse *mucse)
+{
+	struct mucse_q_vector *q_vector;
+
+	for (int i = 0; i < mucse->num_q_vectors; i++) {
+		struct mucse_ring *ring;
+
+		q_vector = mucse->q_vector[i];
+		/* TX/RX pairs share vector registers.
+		 * Update them through TX.
+		 */
+		mucse_for_each_ring(ring, q_vector->tx) {
+			rnpgbe_set_ring_vector(mucse, ring->rnpgbe_queue_idx,
+					       q_vector->hw_vector);
+		}
+	}
+}
+
+static void rnpgbe_irq_enable(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		rnpgbe_irq_enable_queues(mucse->q_vector[i]);
+}
+
+/**
+ * rnpgbe_irq_disable - Mask off interrupt generation on the NIC
+ * @mucse: board private structure
+ **/
+void rnpgbe_irq_disable(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+
+	if (mucse->flags & M_FLAG_MSIX_EN) {
+		for (int i = 0; i < mucse->num_q_vectors; i++) {
+			rnpgbe_irq_disable_queues(mucse->q_vector[i]);
+			synchronize_irq(pci_irq_vector(pdev, i + 1));
+		}
+	} else {
+		rnpgbe_irq_disable_queues(mucse->q_vector[0]);
+		synchronize_irq(pci_irq_vector(pdev, 0));
+	}
+}
+
+static void rnpgbe_napi_enable_all(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		napi_enable(&mucse->q_vector[i]->napi);
+}
+
+static void rnpgbe_napi_disable_all(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		napi_disable(&mucse->q_vector[i]->napi);
+}
+
+bool rnpgbe_down(struct mucse *mucse)
+{
+	if (test_and_set_bit(__MUCSE_DOWN, &mucse->state))
+		return false;
+
+	rnpgbe_napi_disable_all(mucse);
+	rnpgbe_irq_disable(mucse);
+
+	return true;
+}
+
+/**
+ * rnpgbe_up_complete - Final step for port up
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_up_complete(struct mucse *mucse)
+{
+	if (mucse->flags & (M_FLAG_MSIX_EN | M_FLAG_MSIX_SINGLE_EN))
+		rnpgbe_configure_msix(mucse);
+	else
+		rnpgbe_configure_msi(mucse);
+	rnpgbe_napi_enable_all(mucse);
+	clear_bit(__MUCSE_DOWN, &mucse->state);
+	rnpgbe_irq_enable(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
new file mode 100644
index 000000000000..c03f7aad2c08
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_LIB_H
+#define _RNPGBE_LIB_H
+
+struct mucse;
+struct mucse_hw;
+
+#define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
+#define RNPGBE_DMA_INT_MASK       0x24
+#define TX_INT_MASK               BIT(1)
+#define RX_INT_MASK               BIT(0)
+#define INT_VALID                 (BIT(16) | BIT(17))
+#define RNPGBE_DMA_INT_TRIG       0x2c /* lost-interrupt recovery trigger */
+/* |  31:24   | .... |    15:8   |    7:0    | */
+/* |  pfvfnum |      | tx vector | rx vector | */
+#define RING_VECTOR(n)            (0x04 * (n))
+
+#define mucse_for_each_ring(pos, head)\
+	for (typeof((head).ring) __pos = (head).ring;\
+	     __pos ? ({ pos = __pos; 1; }) : 0;\
+	     __pos = __pos->next)
+
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
+int rnpgbe_request_mbx_irq(struct mucse *mucse);
+void rnpgbe_free_mbx_irq(struct mucse *mucse);
+int rnpgbe_request_irq(struct mucse *mucse);
+void rnpgbe_free_irq(struct mucse *mucse);
+void rnpgbe_irq_disable(struct mucse *mucse);
+bool rnpgbe_down(struct mucse *mucse);
+void rnpgbe_up_complete(struct mucse *mucse);
+#endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 70a2b0082ba8..b7472dba2a19 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_lib.h"
 #include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
@@ -32,11 +33,28 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  * The open entry point is called when a network interface is made
  * active by the system (IFF_UP).
  *
- * Return: 0
+ * Return: 0 on success, negative value on failure
  **/
 static int rnpgbe_open(struct net_device *netdev)
 {
+	struct mucse *mucse = netdev_priv(netdev);
+	int err;
+
+	err = rnpgbe_request_irq(mucse);
+	if (err)
+		return err;
+
+	err = netif_set_real_num_queues(netdev, mucse->num_tx_queues,
+					mucse->num_rx_queues);
+	if (err)
+		goto err_free_irqs;
+
+	rnpgbe_up_complete(mucse);
+
 	return 0;
+err_free_irqs:
+	rnpgbe_free_irq(mucse);
+	return err;
 }
 
 /**
@@ -50,6 +68,13 @@ static int rnpgbe_open(struct net_device *netdev)
  **/
 static int rnpgbe_close(struct net_device *netdev)
 {
+	struct mucse *mucse = netdev_priv(netdev);
+
+	if (!rnpgbe_down(mucse))
+		return 0;
+
+	rnpgbe_free_irq(mucse);
+
 	return 0;
 }
 
@@ -106,6 +131,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	mucse = netdev_priv(netdev);
 	mucse->netdev = netdev;
 	mucse->pdev = pdev;
+	set_bit(__MUCSE_DOWN, &mucse->state);
 	pci_set_drvdata(pdev, mucse);
 
 	hw = &mucse->hw;
@@ -166,11 +192,28 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	err = rnpgbe_init_interrupt_scheme(mucse);
+	if (err) {
+		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	err = rnpgbe_request_mbx_irq(mucse);
+	if (err) {
+		dev_err(&pdev->dev, "register mbx irq failed %d\n", err);
+		goto err_clear_interrupt;
+	}
+
 	err = register_netdev(netdev);
 	if (err)
-		goto err_powerdown;
+		goto err_remove_mbx;
 
 	return 0;
+
+err_remove_mbx:
+	rnpgbe_free_mbx_irq(mucse);
+err_clear_interrupt:
+	rnpgbe_clear_interrupt_scheme(mucse);
 err_powerdown:
 	/* notify powerdown only powerup ok */
 	if (!err_notify) {
@@ -253,9 +296,11 @@ static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 		return;
 	netdev = mucse->netdev;
 	unregister_netdev(netdev);
+	rnpgbe_free_mbx_irq(mucse);
 	err = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
 	if (err)
 		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	free_netdev(netdev);
 }
 
@@ -289,6 +334,9 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 	if (netif_running(netdev))
 		rnpgbe_close(netdev);
 	rtnl_unlock();
+
+	rnpgbe_free_mbx_irq(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	pci_disable_device(pdev);
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index c46408698263..2310f01df1f5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -84,7 +84,7 @@ static u32 mucse_mbx_get_lock_pf(struct mucse_hw *hw)
  * @hw: pointer to the HW structure
  *
  * Pair with mucse_release_mbx_lock_pf()
- * This function maybe used in an irq handler.
+ * All mailbox access runs in process context.
  *
  * Return: 0 on success, negative errno on failure
  **/
@@ -93,11 +93,11 @@ static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
 	struct mucse_mbx_info *mbx = &hw->mbx;
 	u32 val;
 
-	return read_poll_timeout_atomic(mucse_mbx_get_lock_pf,
-					val, val & MUCSE_MBX_PFU,
-					mbx->delay_us,
-					mbx->timeout_us,
-					false, hw);
+	return read_poll_timeout(mucse_mbx_get_lock_pf,
+				 val, val & MUCSE_MBX_PFU,
+				 mbx->delay_us,
+				 mbx->timeout_us,
+				 false, hw);
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 5ba74997beac..e28f3193aa85 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -197,3 +197,14 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 
 	return 0;
 }
+
+/**
+ * mucse_fw_irq_handler - Deferred firmware mailbox notification hook
+ * @hw: pointer to the HW structure
+ *
+ * No asynchronous firmware events are enabled until link status support is
+ * added.
+ **/
+void mucse_fw_irq_handler(struct mucse_hw *hw)
+{
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index fe996aeffc4d..a6bf5de55aa3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -99,4 +99,5 @@ int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup);
 int mucse_mbx_reset_hw(struct mucse_hw *hw);
 int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			  u8 *mac_addr, int port);
+void mucse_fw_irq_handler(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.50.1

