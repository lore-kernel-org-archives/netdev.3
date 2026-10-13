Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4343DEAC;
	Tue, 13 Oct 2026 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858692; cv=none; b=SsZXwiTtVxkrIEYrW9RAZZu4zyLGwB3KzFY3U4OJ2zCvDwBEJ2H8uenni5M4XfeVyJ3KKTDsRYv8W1JdBx0RxuBnjO8AQ4mzjnz7c5HPSU6X0GozFlMsnTNv1qW6X7MJJAIC3Ju1kBv5hJQox6W0kg5IRT4qXNOPCnG2vco2EBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858692; c=relaxed/simple;
	bh=AB4yPc8YIyqDBCzmGRENsec1+cSuXQ4/ejVyBWbbOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGBSQgC1+s322sFwckQjT4PgrzMn87hCS4wBOBI5tw1Iz2NwurJtWmQbmhP44ZcwaM/ozkokzslMGmWQb+rm9SLq0sdysEsQ4T4/6ZVTz9Y5gmZa4wj3uLH7NChgVlmMFN4UOSCGPGyeqPn65ICvhGbVDejREg+3NfeAdEfAeWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1791858629tf852045f
X-QQ-Originating-IP: orlUzRfimQ8SeJL/ktfFAlTFsmdgWjfosV4Z0TnulQU=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:30:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11414775473402586508
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
Subject: [PATCH net-next v16 1/5] net: rnpgbe: Add interrupt handling
Date: Tue, 13 Oct 2026 10:30:25 +0800
Message-ID: <A4AA29A72BA34A26+20261013023025.63622-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
References: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MgQY1K25Ph0mo4uuDF/O3+sOKOnLxESHkKRlxZfBS5qNPa0jMg0VhGl4
	avG8Uk64dJ9yKnicNnpqESVSK0POlIpL9Wn+3XN0Syb7sfyhIfMkBtzJvwG8xPBeg219S1v
	c2ncT1UHtU3df/GqgoN9a9iQOwkcHLVwrR/vtKGRiOLfXplLVhul39HGSHKL+A5kfL9XVBv
	rK9DnS4b1pRGU2Lej8K2cFzJJJRQIXMq9EBmoqEBScnu+OGr0o9DgGlj6uqX7UxGZMyEBLt
	hUihdWar81Ay8cN7RSBUTBsaZ57RxciARRcZhz3F6BpSTfCSx1fDKH2iVqLIYDA2sQz6pD2
	HlaokEv4hi/nrGweeQkWi7fmhVMEnxhInJlAw2d7Q++tJl9FnyNYB9USPh5uSLe7HQr+/px
	MUTR0vUvEltooQbWrd+EQV11GCEIadHmQ/qD6MaJ+WbRZd0jIZlQSYVQDCbDdLpepYwlKUX
	2/0SBf6rrzuAlG6ojA07VLFVojOimEftOYwgoKVtvhO2r3oeOo9LjmWiu4zvj85Yx3JzmPL
	EhbQRdU3usPX5RgogrS+wR56viG5+rpU+urbEIiap0NcYG/mST60B7uvY9S/5atEfuli7t0
	52lLJKsX/k+qC9zmuSvM/br1wUZMN1uJFlP9X077kJxJsYWfpEcZFVTHuvzrDAFoiLEhxun
	vakaUVxNE3U46eqZrjlwf45bKVyPuKxdeIu3YHy/Pe/sqZAsg4CsEkzE0jfA1bV4eBGKuJx
	Cq8GhzueJs6X7C1TPxfZ/wqsWgSwZyynx6LGulWos5ZEWCe/+tUuckHPnCW4PyhrC/kTocX
	ZIF7OjJYAZuY3cuRYxFlLmVd0pwnha/SXpt2m1/OiseNs8cwfXgrlaH5sUxqwdKF5VyQyeD
	LC2OqzIfvHkVDGQbQ4IB5iiTp/NF7itzvmA0SV8xLp6rjmruGBqrebDSQpd4ZVgyNhDWp4p
	n93W4bNVJXYT8HOK/ZeYnHE4DUUJ+E4v1nzjzG8d3TuGhY4PTt4bYvIVxqIKZsk2u3ZIsah
	9uhNXwoOvENjEHH4JhbnkYFFK87ufmynnB8tL34RrpSAMtoZHz5o1QG8px8v0=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Add interrupt setup and teardown for the RNPGBE driver.

Require at least two MSI-X vectors. Reserve vector 0 for the mailbox
and assign the remaining vectors to the data path. Set up mailbox
workqueue plumbing for asynchronous firmware events. Mailbox
transactions run in process context, allowing mailbox lock acquisition
to use sleepable polling.

Notify firmware of driver powerdown from both remove and shutdown
through a shared helper.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/Kconfig            |   1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  48 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   4 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 576 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  35 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  89 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  12 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  11 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   1 +
 11 files changed, 765 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..17528dba2613 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -19,6 +19,7 @@ if NET_VENDOR_MUCSE
 config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
 	depends on PCI
+	depends on PCI_MSI
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
 	  adapters.
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
index 5b024f9f7e17..f2d2fe07f9e0 100644
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
@@ -35,21 +40,62 @@ enum {
 
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
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
 	struct mucse_stats stats;
+	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
+		____cacheline_aligned_in_smp;
+	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
+		____cacheline_aligned_in_smp;
+	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
+	int num_tx_queues;
+	int num_q_vectors;
+	int num_rx_queues;
+	char mbx_name[32];
+	bool mbx_irq_requested;
+	struct work_struct mbx_work;
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -68,4 +114,6 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 
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
index 000000000000..81c3ec63a9a0
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -0,0 +1,576 @@
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
+ * Register the dedicated mailbox handler on vector 0.
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
+	err = request_irq(pci_irq_vector(pdev, 0), rnpgbe_msix_other, 0,
+			  mucse->mbx_name, mucse);
+	if (!err)
+		mucse->mbx_irq_requested = true;
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
+	if (mucse->mbx_irq_requested) {
+		mucse->mbx_irq_requested = false;
+		free_irq(pci_irq_vector(pdev, 0), mucse);
+		cancel_work_sync(&mucse->mbx_work);
+	}
+}
+
+/**
+ * rnpgbe_set_num_queues - Set initial TX/RX queue counts
+ * @mucse: pointer to private structure
+ *
+ * Start with one TX queue and one RX queue.
+ **/
+static void rnpgbe_set_num_queues(struct mucse *mucse)
+{
+	mucse->num_tx_queues = 1;
+	mucse->num_rx_queues = 1;
+}
+
+/**
+ * rnpgbe_set_interrupt_capability - Set MSI-X interrupt capability
+ * @mucse: pointer to private structure
+ *
+ * Allocate one MSI-X vector for the mailbox and one or more vectors for
+ * the data path.
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
+	/* Vector 0 is reserved for mailbox events and must not share NAPI. */
+	v_budget = pci_alloc_irq_vectors(mucse->pdev, 2, v_budget,
+					 PCI_IRQ_MSIX);
+	if (v_budget < 0)
+		return v_budget;
+
+	/* q_vectors do not include the mailbox vector. */
+	mucse->num_q_vectors = v_budget - 1;
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
+	/* Vector 0 is reserved for the mailbox. */
+	q_vector->hw_vector++;
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
+	if (!mucse->pdev->msix_enabled)
+		return;
+
+	pci_free_irq_vectors(mucse->pdev);
+}
+
+/**
+ * rnpgbe_init_interrupt_scheme - Initialize the interrupt scheme
+ * @mucse: pointer to private structure
+ *
+ * Set up one TX/RX queue pair with a dedicated mailbox vector.
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
+ * rnpgbe_request_irq - Register data-path MSI-X handlers
+ * @mucse: pointer to private structure
+ *
+ * Register interrupt handlers for the data-path MSI-X vectors.
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
+	for (i = 0; i < mucse->num_q_vectors; i++) {
+		q_vector = mucse->q_vector[i];
+
+		snprintf(q_vector->name, sizeof(q_vector->name),
+			 "%s-%s-%d", netdev->name, "TxRx", i);
+
+		err = request_irq(pci_irq_vector(pdev, i + 1),
+				  rnpgbe_msix_clean_rings, 0,
+				  q_vector->name, q_vector);
+		if (err) {
+			dev_err(&pdev->dev, "MSI-X req err %d: %d\n",
+				i + 1, err);
+			goto err_free_irqs;
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
+ * rnpgbe_free_irq - Free data-path MSI-X handlers
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_free_irq(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_q_vector *q_vector;
+
+	for (int i = 0; i < mucse->num_q_vectors; i++) {
+		q_vector = mucse->q_vector[i];
+		if (!q_vector)
+			continue;
+
+		free_irq(pci_irq_vector(pdev, i + 1), q_vector);
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
+ * rnpgbe_irq_disable - Mask queue interrupt generation on the NIC
+ * @mucse: board private structure
+ **/
+static void rnpgbe_irq_disable(struct mucse *mucse)
+{
+	struct pci_dev *pdev = mucse->pdev;
+
+	for (int i = 0; i < mucse->num_q_vectors; i++) {
+		rnpgbe_irq_disable_queues(mucse->q_vector[i]);
+		synchronize_irq(pci_irq_vector(pdev, i + 1));
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
+void rnpgbe_down(struct mucse *mucse)
+{
+	rnpgbe_irq_disable(mucse);
+	rnpgbe_napi_disable_all(mucse);
+	synchronize_net();
+	rnpgbe_irq_disable(mucse);
+}
+
+/**
+ * rnpgbe_up_complete - Final step for port up
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_up_complete(struct mucse *mucse)
+{
+	rnpgbe_configure_msix(mucse);
+	rnpgbe_napi_enable_all(mucse);
+	rnpgbe_irq_enable(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
new file mode 100644
index 000000000000..a1074890f5ad
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_LIB_H
+#define _RNPGBE_LIB_H
+
+#include <linux/bits.h>
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
+void rnpgbe_down(struct mucse *mucse);
+void rnpgbe_up_complete(struct mucse *mucse);
+#endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 70a2b0082ba8..6022a1a2ddf1 100644
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
@@ -50,6 +68,11 @@ static int rnpgbe_open(struct net_device *netdev)
  **/
 static int rnpgbe_close(struct net_device *netdev)
 {
+	struct mucse *mucse = netdev_priv(netdev);
+
+	rnpgbe_down(mucse);
+	rnpgbe_free_irq(mucse);
+
 	return 0;
 }
 
@@ -166,11 +189,33 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	err = rnpgbe_init_interrupt_scheme(mucse);
+	if (err) {
+		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	err = netif_set_real_num_queues(netdev, mucse->num_tx_queues,
+					mucse->num_rx_queues);
+	if (err)
+		goto err_clear_interrupt;
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
@@ -236,6 +281,26 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return err;
 }
 
+/**
+ * rnpgbe_notify_powerdown - Notify firmware that the driver is going down
+ * @mucse: pointer to private structure
+ *
+ * Skip the mailbox access if an earlier shutdown has already disabled the
+ * PCI device.
+ **/
+static void rnpgbe_notify_powerdown(struct mucse *mucse)
+{
+	int err;
+
+	if (!pci_is_enabled(mucse->pdev))
+		return;
+
+	err = rnpgbe_send_notify(&mucse->hw, false, mucse_fw_powerup);
+	if (err)
+		dev_warn(&mucse->pdev->dev,
+			 "Send powerdown to hw failed %d\n", err);
+}
+
 /**
  * rnpgbe_rm_adapter - Remove netdev for this mucse structure
  * @pdev: PCI device information struct
@@ -245,17 +310,15 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
-	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
-	int err;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
 	unregister_netdev(netdev);
-	err = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
-	if (err)
-		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
+	rnpgbe_free_mbx_irq(mucse);
+	rnpgbe_notify_powerdown(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	free_netdev(netdev);
 }
 
@@ -272,7 +335,8 @@ static void rnpgbe_remove(struct pci_dev *pdev)
 {
 	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
-	pci_disable_device(pdev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
 }
 
 /**
@@ -287,9 +351,14 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 	rtnl_lock();
 	netif_device_detach(netdev);
 	if (netif_running(netdev))
-		rnpgbe_close(netdev);
+		dev_close(netdev);
 	rtnl_unlock();
-	pci_disable_device(pdev);
+
+	rnpgbe_free_mbx_irq(mucse);
+	rnpgbe_notify_powerdown(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
 }
 
 /**
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

