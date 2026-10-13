Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C33E49DB;
	Tue, 13 Oct 2026 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858706; cv=none; b=US3ER3rqo40+RzeoDy+hOQAmXpFegro168dlcC99qPjLKRlioz7AxiZaUsZXBhP4rny3j79fjUpPFqYEcMu9omsO/rIKx9vCsItghlr3wofz9YEZvXAYfYWlxC6h/8hjXwnMKLKL/rGbxvoZbZTEQ686+nB/aC12rQx9n+bI1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858706; c=relaxed/simple;
	bh=lbfXzqUO87FTAw040EqzOHDrtLP9dEBjbiatXUUJ9eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seyhfvVNdyNyPe4IMVGVysTCt2aFLxleYzR0xBpX5NCa7q/PG5CAh03plypCjcgyos9hi4jvjalUgEsvhufWOhGHepElLRznx3b1jE4oz0xe8oI+IOkGSvKAe/0H6luuRJUs9wPKg0XNTuJj0nuNLD+EiQPGv/QXrwD5cc441Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1791858640tfe105ec2
X-QQ-Originating-IP: r1DKqBciRL3wXmDp1AbG6wGfi/ljJBMGafIw/7FjMIk=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:30:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5081615830987877520
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
Subject: [PATCH net-next v16 2/5] net: rnpgbe: Add basic TX packet transmission support
Date: Tue, 13 Oct 2026 10:30:36 +0800
Message-ID: <70FB65125730E856+20261013023036.63653-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: Mo9F5tYWNSxa5QeBm7U0ggCBkedOp0MM2boTWvhHsClt50hwyNSbfPw5
	kOQPJ2Bh1twYbyjW6Nqpe+6i8kqDMEkYWOloEe5ZzjZByT7HV98SC7bhNfG63EzCNnLK0ya
	HNPxlEmtqzms3Uwv4fZHfm5baxSxE4SCkRYheii4X9LIfrHFI2KtQgZWxAmBrGrBbDm/9y8
	EdXB94DWswGqtbshEE0Lc/IqCVNJWLxuxZ02lDaxfwc3kiA4/jBuZLKo2eJ22pjc+0hCtPj
	LeDsC4NyukEdWGf8ItQ1y7OM0c9TpwYQKEsUZ587BoUwcN7fT/X+6wQUxFGy1MaHvj1Vqus
	6fk393juKlwT9quuLhsbhgP/1R6Yu7P8T+AIavqR+Z+Y7fKtX9HRnikD0fHnUkpoSLy1acN
	q7Wicq01qLiD8iCkRkzXoCVIQYSuBDLIQw1jBlwb9GBs5AYA8xXU4W+w0BkmHu2yhS3ki8R
	rjLg8s9G6N608WwJQCq3+AIERK1a9Qw8H1Ov6StFpwM7j+fQjpfF+WPM4fSLev1aLmXLdRx
	zgjEvh25AUMVWkZSTjYDwEikHHAFw7sA8iYtIgiAKi3Zc/Gk+mSUzFpsL7WOP9iYs1BIjTk
	qe5rk4ZsnJxyl1AvvhPBtPFnsvg/EZZsw6XUSL56voxVGqtER0pLU2EfgZbH+HQE7ltd4mv
	oyL7D39SszsTVHTBTL4lQkcpY7fQfaxdMz6CjqctmPwwf9H4EeEacXqPdQdx5p3S+H4nYe+
	547XwU4T2rWdm/Iy1swHy4RzdzS4cf3iJxtNRfWn2MgZy/k3oQsPIh0Vta4yGGskh93ZsT1
	i12f5bDiPF08+aVtwyO/tE3wlQHptvC2ZxKu1rflNTtjQQFxtf7ur7BbmqZmP8BnTSiY0wg
	wWf5Gm6XZyL+40Hv70v9+z2UhRZNAO9kqAyiAUlp5QieggMRyF++YuVxxScgvshqRMG+OnJ
	ot9sHnGHL8c7qZGEEr/pQsxAvFNTF1NQfNhdmoSGGVK5+6a1ViOjivrQpJ750PK1UAIo/LX
	DrcuZFpmrcFVMtPS1Pc6mr0pGngOd8L5xWt6DH+axtTJy3QoLRb1a7cLrXpf1iav/UeN2s2
	Hn9cv2Q9M/r
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Add the basic TX path for the RNPGBE driver.

Introduce the TX descriptor structure and buffer management, the
rnpgbe_xmit_frame_ring() transmit function, TX ring allocation and
teardown, and TX completion handling in rnpgbe_clean_tx_irq(). Track TX
packet and byte statistics, and report dropped and tx_dropped counts
through ndo_get_stats64().

Keep carrier state off during registration. The link-status patch later
in this series enables carrier after firmware reports a valid link.

Configure streaming and coherent DMA masks for the hardware's 56-bit
DMA addressing capability. Add cycles_per_us to struct mucse_hw to scale
the TX interrupt timer, and enable NETIF_F_HIGHDMA when the DMA mask
allows it.

A TX DMA idle timeout is terminal for the current driver instance. The
hardware stops PCIe DMA requests, allowing cleanup to release DMA
resources. Recovery requires a chip-level reset and driver rebind.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  85 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   4 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   9 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 695 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  31 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  71 +-
 6 files changed, 876 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index f2d2fe07f9e0..5456919ef80b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -44,20 +44,85 @@ struct mucse_hw {
 	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
 	int port;
+	u16 cycles_per_us;
 	u8 pfvfnum;
 };
 
+struct rnpgbe_tx_desc {
+	__le64 pkt_addr; /* Packet buffer address */
+	union {
+		__le64 vlan_cmd_bsz;
+		struct {
+			__le32 blen_mac_ip_len;
+			__le32 vlan_cmd; /* vlan & cmd status */
+		};
+	};
+#define M_TXD_CMD_RS          0x040000 /* Report Status */
+#define M_TXD_STAT_DD         0x020000 /* Descriptor Done */
+#define M_TXD_CMD_EOP         0x010000 /* End of Packet */
+};
+
+#define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
+
+struct mucse_tx_buffer {
+	struct rnpgbe_tx_desc *next_to_watch;
+	struct sk_buff *skb;
+	unsigned int bytecount;
+	unsigned short gso_segs;
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+	bool mapped_as_page;  /* true if dma was mapped with dma_map_page */
+};
+
+struct mucse_queue_stats {
+	u64 packets;
+	u64 bytes;
+	atomic64_t dropped;
+	struct u64_stats_sync syncp;
+} ____cacheline_aligned_in_smp;
+
 struct mucse_ring {
 	struct mucse_ring *next;
 	struct mucse_q_vector *q_vector;
+	struct net_device *netdev;
+	struct device *dev;
+	void *desc;
+	struct mucse_tx_buffer *tx_buffer_info;
 	void __iomem *ring_addr;
+	void __iomem *tail;
 	void __iomem *irq_mask;
 	void __iomem *trig;
 	u8 queue_index;
 	/* hw ring idx */
 	u8 rnpgbe_queue_idx;
+	u8 pfvfnum;
+	u16 count;
+	u16 next_to_use;
+	u16 next_to_clean;
+	dma_addr_t dma;
+	unsigned int size;
+	struct mucse_queue_stats *stats;
 } ____cacheline_internodealigned_in_smp;
 
+static inline u16 mucse_desc_unused(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
+}
+
+static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
+{
+	return cpu_to_le64(((u64)vlan_cmd << 32) | ((u64)mac_ip_len << 16) |
+			   ((u64)size));
+}
+
+static inline struct netdev_queue *txring_txq(const struct mucse_ring *ring)
+{
+	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
+}
+
 struct mucse_ring_container {
 	struct mucse_ring *ring;
 	u16 count;
@@ -74,27 +139,33 @@ struct mucse_q_vector {
 	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
 };
 
-struct mucse_stats {
-	u64 tx_dropped;
-};
-
 #define MAX_Q_VECTORS 8
 
+#define M_DEFAULT_TXD     512
+#define M_DEFAULT_TX_WORK 256
+
+enum mucse_state_t {
+	__MUCSE_AXI_FAULT,
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
-	struct mucse_stats stats;
 	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
 	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
+	struct mucse_queue_stats tx_stats[RNPGBE_MAX_QUEUES];
 	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
+	int tx_ring_item_count;
+	int tx_work_limit;
 	int num_tx_queues;
 	int num_q_vectors;
 	int num_rx_queues;
 	char mbx_name[32];
 	bool mbx_irq_requested;
+	unsigned long state;
 	struct work_struct mbx_work;
 };
 
@@ -116,4 +187,8 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 	writel((val), (hw)->hw_addr + (reg))
 #define mucse_hw_rd32(hw, reg) \
 	readl((hw)->hw_addr + (reg))
+#define mucse_ring_wr32(ring, reg, val) \
+	writel((val), (ring)->ring_addr + (reg))
+#define mucse_ring_rd32(ring, reg) \
+	readl((ring)->ring_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 921cc325a991..291e77d573fe 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -93,6 +93,8 @@ static void rnpgbe_init_n500(struct mucse_hw *hw)
 
 	mbx->fwpf_ctrl_base = MUCSE_N500_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N500_FWPF_SHM_BASE;
+
+	hw->cycles_per_us = M_DEFAULT_N500_MHZ;
 }
 
 /**
@@ -110,6 +112,8 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
 
 	mbx->fwpf_ctrl_base = MUCSE_N210_FWPF_CTRL_BASE;
 	mbx->fwpf_shm_base = MUCSE_N210_FWPF_SHM_BASE;
+
+	hw->cycles_per_us = M_DEFAULT_N210_MHZ;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 0dce78e4a91b..f9ca13b29f69 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -4,16 +4,25 @@
 #ifndef _RNPGBE_HW_H
 #define _RNPGBE_HW_H
 
+#include <linux/bits.h>
+
 #define MUCSE_N500_FWPF_CTRL_BASE      0x28b00
 #define MUCSE_N500_FWPF_SHM_BASE       0x2d000
 #define MUCSE_N500_RING_MSIX_BASE      0x28700
+#define M_DEFAULT_N500_MHZ             125
 #define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
 #define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
 #define MUCSE_N210_FWPF_CTRL_BASE      0x29400
 #define MUCSE_N210_FWPF_SHM_BASE       0x2d900
 #define MUCSE_N210_RING_MSIX_BASE      0x29000
+#define M_DEFAULT_N210_MHZ             62
 
+#define RNPGBE_DMA_STATUS              0x0008
+#define TX_AXI_RW_EN                   0xc
+/* DMA_STATUS_REG[23:20]: tx_wr, tx_rd, rx_wr, rx_rd done status. */
+#define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
 #define RNPGBE_DMA_AXI_EN              0x0010
+#define RNPGBE_TX_MIN_PKT_LEN          33
 
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 81c3ec63a9a0..21cd578f7532 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -3,6 +3,9 @@
 
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <linux/iopoll.h>
+#include <linux/vmalloc.h>
+#include <net/netdev_queues.h>
 
 #include "rnpgbe_lib.h"
 #include "rnpgbe.h"
@@ -43,7 +46,6 @@ static void rnpgbe_irq_disable_queues(struct mucse_q_vector *q_vector)
 		writel(INT_VALID, ring->trig);
 		writel((RX_INT_MASK | TX_INT_MASK), ring->irq_mask);
 	}
-
 	/* flush posted writes to ensure hardware sees the mask */
 	if (q_vector->tx.ring)
 		readl(q_vector->tx.ring->irq_mask);
@@ -65,26 +67,143 @@ static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
 	}
 }
 
+/**
+ * rnpgbe_clean_tx_irq - Reclaim resources after transmit completes
+ * @q_vector: structure containing interrupt and ring information
+ * @tx_ring: tx ring to clean
+ * @napi_budget: Used to determine if we are in netpoll
+ *
+ * Return: true if cleaning completed within the budget, otherwise false
+ **/
+static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
+				struct mucse_ring *tx_ring,
+				int napi_budget)
+{
+	int budget = q_vector->mucse->tx_work_limit;
+	u64 total_bytes = 0, total_packets = 0;
+	struct mucse *mucse = q_vector->mucse;
+	struct mucse_tx_buffer *tx_buffer;
+	struct rnpgbe_tx_desc *tx_desc;
+	int i = tx_ring->next_to_clean;
+
+	tx_buffer = &tx_ring->tx_buffer_info[i];
+	tx_desc = M_TX_DESC(tx_ring, i);
+	i -= tx_ring->count;
+
+	do {
+		struct rnpgbe_tx_desc *eop_desc = tx_buffer->next_to_watch;
+
+		/* if next_to_watch is not set then there is no work pending */
+		if (!eop_desc)
+			break;
+
+		/* prevent any other reads prior to eop_desc */
+		dma_rmb();
+
+		/* if eop DD is not set pending work has not been completed */
+		if (!(eop_desc->vlan_cmd & cpu_to_le32(M_TXD_STAT_DD)))
+			break;
+		/* clear next_to_watch to prevent false hangs */
+		tx_buffer->next_to_watch = NULL;
+		total_bytes += tx_buffer->bytecount;
+		total_packets += tx_buffer->gso_segs;
+		napi_consume_skb(tx_buffer->skb, napi_budget);
+		if (tx_buffer->mapped_as_page) {
+			dma_unmap_page(tx_ring->dev,
+				       dma_unmap_addr(tx_buffer, dma),
+				       dma_unmap_len(tx_buffer, len),
+				       DMA_TO_DEVICE);
+		} else {
+			dma_unmap_single(tx_ring->dev,
+					 dma_unmap_addr(tx_buffer, dma),
+					 dma_unmap_len(tx_buffer, len),
+					 DMA_TO_DEVICE);
+		}
+		tx_buffer->skb = NULL;
+		dma_unmap_len_set(tx_buffer, len, 0);
+
+		/* unmap remaining buffers */
+		while (tx_desc != eop_desc) {
+			tx_buffer++;
+			tx_desc++;
+			i++;
+			if (unlikely(!i)) {
+				i -= tx_ring->count;
+				tx_buffer = tx_ring->tx_buffer_info;
+				tx_desc = M_TX_DESC(tx_ring, 0);
+			}
+
+			/* unmap any remaining paged data */
+			if (dma_unmap_len(tx_buffer, len)) {
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+				dma_unmap_len_set(tx_buffer, len, 0);
+			}
+		}
+
+		/* move us one more past the eop_desc for start of next pkt */
+		tx_buffer++;
+		tx_desc++;
+		i++;
+		if (unlikely(!i)) {
+			i -= tx_ring->count;
+			tx_buffer = tx_ring->tx_buffer_info;
+			tx_desc = M_TX_DESC(tx_ring, 0);
+		}
+
+		prefetch(tx_desc);
+		budget--;
+	} while (likely(budget > 0));
+
+	i += tx_ring->count;
+	tx_ring->next_to_clean = i;
+	u64_stats_update_begin(&tx_ring->stats->syncp);
+	tx_ring->stats->bytes += total_bytes;
+	tx_ring->stats->packets += total_packets;
+	u64_stats_update_end(&tx_ring->stats->syncp);
+
+#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
+	__netif_txq_completed_wake(txring_txq(tx_ring),
+				   total_packets, total_bytes,
+				   mucse_desc_unused(tx_ring),
+				   TX_WAKE_THRESHOLD,
+				   !netif_running(mucse->netdev));
+
+	return !!budget;
+}
+
 /**
  * rnpgbe_poll - NAPI polling callback
  * @napi: structure for representing this polling device
  * @budget: polling budget
  *
- * Complete NAPI polling and re-enable queue interrupts. Ring cleaning is
- * added when TX and RX support is enabled.
+ * Clean completed TX packets and complete NAPI polling when all queues are
+ * clean.
  *
- * Return: 0
+ * Return: 0 if all TX queues are clean, otherwise @budget
  **/
 static int rnpgbe_poll(struct napi_struct *napi, int budget)
 {
 	struct mucse_q_vector *q_vector =
 		container_of(napi, struct mucse_q_vector, napi);
+	bool clean_complete = true;
+	struct mucse_ring *ring;
 	int work_done = 0;
 
+	mucse_for_each_ring(ring, q_vector->tx) {
+		if (!rnpgbe_clean_tx_irq(q_vector, ring, budget))
+			clean_complete = false;
+	}
+
 	/* Exit if we are called by netpoll */
 	if (unlikely(!budget))
 		return 0;
 
+	if (!clean_complete)
+		return budget;
+
 	if (likely(napi_complete_done(napi, work_done)))
 		rnpgbe_irq_enable_queues(q_vector);
 
@@ -233,13 +352,18 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
 	ring = q_vector->ring;
 
 	for (idx = 0; idx < txr_count; idx++) {
+		ring->dev = &mucse->pdev->dev;
 		mucse_add_ring(ring, &q_vector->tx);
+		ring->count = mucse->tx_ring_item_count;
+		ring->netdev = mucse->netdev;
 		ring->queue_index = eth_queue_idx + idx;
 		ring->rnpgbe_queue_idx = txr_idx;
 		ring->ring_addr = hw->hw_addr + RING_OFFSET(txr_idx);
 		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
 		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
 		ring->q_vector = q_vector;
+		ring->pfvfnum = hw->pfvfnum;
+		ring->stats = &mucse->tx_stats[ring->queue_index];
 		mucse->tx_ring[ring->queue_index] = ring;
 		txr_idx += step;
 		ring++;
@@ -556,12 +680,173 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
 		napi_disable(&mucse->q_vector[i]->napi);
 }
 
+static void rnpgbe_stop_tx_ring(struct mucse_ring *tx_ring)
+{
+	if (!tx_ring->tx_buffer_info)
+		return;
+
+	/* Stop hw. No new descriptors are fetched after TX_START=0.
+	 * DMA for descriptors fetched before the stop may still be in flight.
+	 */
+	mucse_ring_wr32(tx_ring, RNPGBE_TX_START, 0);
+	/* Flush posted write to ensure hardware sees TX_START=0 */
+	(void)mucse_ring_rd32(tx_ring, RNPGBE_TX_START);
+}
+
+static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_status;
+	int err;
+
+	/* A timeout indicates a terminal AXI fault. Hardware stops all PCIe
+	 * DMA requests in this state, including requests accepted before the
+	 * fault. Teardown may therefore release mappings and descriptor memory.
+	 * Recovery requires a chip-level reset.
+	 */
+	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
+				 dma_status,
+				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
+				 RNPGBE_DMA_TX_STATUS,
+				 10, 100000);
+	if (err) {
+		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
+		dev_err(&mucse->pdev->dev,
+			"TX DMA failed to quiesce, status %#x\n", dma_status);
+	}
+
+	return err;
+}
+
+/**
+ * rnpgbe_stop_all_tx_rings - Stop TX DMA on all queues
+ * @mucse: board private structure
+ *
+ * Return: 0 when TX DMA was quiesced, negative errno otherwise
+ **/
+static int rnpgbe_stop_all_tx_rings(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_axi_ctl;
+	int err = 0;
+
+	for (int i = 0; i < mucse->num_tx_queues; i++)
+		rnpgbe_stop_tx_ring(mucse->tx_ring[i]);
+
+	if (mucse->num_tx_queues &&
+	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
+		err = rnpgbe_wait_tx_dma_idle(mucse);
+
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl &= ~TX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+	/* Flush the posted write before continuing. */
+	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+
+	if (!test_bit(__MUCSE_AXI_FAULT, &mucse->state))
+		return 0;
+
+	return err ? err : -EIO;
+}
+
+/**
+ * rnpgbe_clean_tx_ring - Free Tx Buffers
+ * @tx_ring: ring to be cleaned
+ **/
+static void rnpgbe_clean_tx_ring(struct mucse_ring *tx_ring)
+{
+	struct mucse_tx_buffer *tx_buffer;
+	u16 i = tx_ring->next_to_clean;
+	unsigned long size;
+
+	/* ring already cleared, nothing to do */
+	if (!tx_ring->tx_buffer_info)
+		return;
+
+	tx_buffer = &tx_ring->tx_buffer_info[i];
+
+	while (i != tx_ring->next_to_use) {
+		struct rnpgbe_tx_desc *eop_desc, *tx_desc;
+
+		dev_kfree_skb_any(tx_buffer->skb);
+		/* unmap skb header data */
+		if (dma_unmap_len(tx_buffer, len)) {
+			if (tx_buffer->mapped_as_page) {
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+			} else {
+				dma_unmap_single(tx_ring->dev,
+						 dma_unmap_addr(tx_buffer, dma),
+						 dma_unmap_len(tx_buffer, len),
+						 DMA_TO_DEVICE);
+			}
+		}
+		eop_desc = tx_buffer->next_to_watch;
+		tx_desc = M_TX_DESC(tx_ring, i);
+		/* unmap remaining buffers */
+		while (tx_desc != eop_desc) {
+			tx_buffer++;
+			tx_desc++;
+			i++;
+			if (unlikely(i == tx_ring->count)) {
+				i = 0;
+				tx_buffer = tx_ring->tx_buffer_info;
+				tx_desc = M_TX_DESC(tx_ring, 0);
+			}
+
+			/* unmap any remaining paged data */
+			if (dma_unmap_len(tx_buffer, len))
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+		}
+		/* move us one more past the eop_desc for start of next pkt */
+		tx_buffer++;
+		i++;
+		if (unlikely(i == tx_ring->count)) {
+			i = 0;
+			tx_buffer = tx_ring->tx_buffer_info;
+		}
+	}
+
+	netdev_tx_reset_queue(txring_txq(tx_ring));
+	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;
+	memset(tx_ring->tx_buffer_info, 0, size);
+	/* Zero out the descriptor ring */
+	memset(tx_ring->desc, 0, tx_ring->size);
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+}
+
+/**
+ * rnpgbe_clean_all_tx_rings - Stop TX DMA and free Tx buffers for all queues
+ * @mucse: board private structure
+ **/
+void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
+{
+	/* rnpgbe_stop_all_tx_rings() logs and latches any AXI fault. Hardware
+	 * stops DMA requests in this state, so cleanup intentionally ignores
+	 * an error and releases the mappings and descriptor memory.
+	 */
+	rnpgbe_stop_all_tx_rings(mucse);
+
+	for (int i = 0; i < mucse->num_tx_queues; i++)
+		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
+}
+
 void rnpgbe_down(struct mucse *mucse)
 {
+	struct net_device *netdev = mucse->netdev;
+
 	rnpgbe_irq_disable(mucse);
 	rnpgbe_napi_disable_all(mucse);
 	synchronize_net();
 	rnpgbe_irq_disable(mucse);
+	netif_tx_disable(netdev);
+	rnpgbe_clean_all_tx_rings(mucse);
 }
 
 /**
@@ -570,7 +855,409 @@ void rnpgbe_down(struct mucse *mucse)
  **/
 void rnpgbe_up_complete(struct mucse *mucse)
 {
+	struct net_device *netdev = mucse->netdev;
+
 	rnpgbe_configure_msix(mucse);
 	rnpgbe_napi_enable_all(mucse);
 	rnpgbe_irq_enable(mucse);
+	netif_tx_start_all_queues(netdev);
+}
+
+/**
+ * rnpgbe_free_tx_resources - Free Tx Resources per Queue
+ * @tx_ring: tx descriptor ring for a specific queue
+ *
+ * Free all transmit software resources
+ **/
+static void rnpgbe_free_tx_resources(struct mucse_ring *tx_ring)
+{
+	vfree(tx_ring->tx_buffer_info);
+	tx_ring->tx_buffer_info = NULL;
+	/* if not set, then don't free */
+	if (!tx_ring->desc)
+		return;
+
+	dma_free_coherent(tx_ring->dev, tx_ring->size, tx_ring->desc,
+			  tx_ring->dma);
+	tx_ring->desc = NULL;
+}
+
+/**
+ * rnpgbe_setup_tx_resources - allocate Tx resources (Descriptors)
+ * @tx_ring: tx descriptor ring (for a specific queue) to setup
+ *
+ * Return: 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_tx_resources(struct mucse_ring *tx_ring)
+{
+	struct device *dev = tx_ring->dev;
+	int size;
+
+	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;
+
+	tx_ring->tx_buffer_info = vzalloc(size);
+	if (!tx_ring->tx_buffer_info)
+		goto err_return;
+	/* round up to nearest 4K */
+	tx_ring->size = tx_ring->count * sizeof(struct rnpgbe_tx_desc);
+	tx_ring->size = ALIGN(tx_ring->size, 4096);
+	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size, &tx_ring->dma,
+					   GFP_KERNEL);
+	if (!tx_ring->desc)
+		goto err_free_buffer;
+
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+
+	return 0;
+
+err_free_buffer:
+	vfree(tx_ring->tx_buffer_info);
+err_return:
+	tx_ring->tx_buffer_info = NULL;
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_configure_tx_ring - Configure Tx ring after Reset
+ * @mucse: pointer to private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Tx descriptor ring after a reset.
+ **/
+static void rnpgbe_configure_tx_ring(struct mucse *mucse,
+				     struct mucse_ring *ring)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	mucse_ring_wr32(ring, RNPGBE_TX_BASE_ADDR_LO, (u32)ring->dma);
+	mucse_ring_wr32(ring, RNPGBE_TX_BASE_ADDR_HI,
+			(u32)(((u64)ring->dma) >> 32) |
+			((u32)hw->pfvfnum << 24));
+	mucse_ring_wr32(ring, RNPGBE_TX_LEN, ring->count);
+	ring->next_to_clean = mucse_ring_rd32(ring, RNPGBE_TX_HEAD) %
+			      ring->count;
+	ring->next_to_use = ring->next_to_clean;
+	ring->tail = ring->ring_addr + RNPGBE_TX_TAIL;
+	writel(ring->next_to_use, ring->tail);
+	mucse_ring_wr32(ring, RNPGBE_TX_FETCH_CTRL, M_DEFAULT_TX_FETCH);
+	mucse_ring_wr32(ring, RNPGBE_TX_INT_TIMER,
+			M_DEFAULT_INT_TIMER * hw->cycles_per_us);
+	mucse_ring_wr32(ring, RNPGBE_TX_INT_PKTCNT, M_DEFAULT_INT_PKTCNT);
+}
+
+/**
+ * rnpgbe_configure_tx - Configure Transmit Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Tx DMA after a reset.
+ *
+ * Return: 0 on success, negative errno if TX DMA did not quiesce
+ **/
+int rnpgbe_configure_tx(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 i, dma_axi_ctl;
+	int err;
+
+	err = rnpgbe_stop_all_tx_rings(mucse);
+	if (err)
+		return err;
+
+	for (i = 0; i < mucse->num_tx_queues; i++)
+		rnpgbe_configure_tx_ring(mucse, mucse->tx_ring[i]);
+
+	/* Ensure all ring configuration is visible before enabling TX DMA. */
+	wmb();
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl |= TX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+	/* Ensure TX_AXI_RW_EN is visible before starting the rings. */
+	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+
+	for (i = 0; i < mucse->num_tx_queues; i++)
+		mucse_ring_wr32(mucse->tx_ring[i], RNPGBE_TX_START, 1);
+
+	return 0;
+}
+
+/**
+ * rnpgbe_setup_all_tx_resources - allocate all queues Tx resources
+ * @mucse: pointer to private structure
+ *
+ * Allocate memory for tx_ring.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int rnpgbe_setup_all_tx_resources(struct mucse *mucse)
+{
+	int i, err = 0;
+
+	for (i = 0; i < mucse->num_tx_queues; i++) {
+		err = rnpgbe_setup_tx_resources(mucse->tx_ring[i]);
+		if (!err)
+			continue;
+
+		goto err_free_res;
+	}
+
+	return 0;
+err_free_res:
+	while (i--)
+		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
+	return err;
+}
+
+/**
+ * rnpgbe_free_all_tx_resources - Free Tx Resources for All Queues
+ * @mucse: pointer to private structure
+ *
+ * Free all transmit software resources
+ **/
+void rnpgbe_free_all_tx_resources(struct mucse *mucse)
+{
+	for (int i = 0; i < (mucse->num_tx_queues); i++)
+		rnpgbe_free_tx_resources(mucse->tx_ring[i]);
+}
+
+static int rnpgbe_tx_map(struct mucse_ring *tx_ring,
+			 struct mucse_tx_buffer *first, u32 mac_ip_len,
+			 u32 tx_flags)
+{
+	struct mucse_tx_buffer *tx_buffer;
+	struct rnpgbe_tx_desc *tx_desc;
+	struct skb_shared_info *shinfo;
+	unsigned int data_len, size;
+	struct sk_buff *skb;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	int nr_frags;
+	int frag_idx;
+	/* Hardware requires this in the upper 8 bits of
+	 * the descriptor address
+	 */
+	u64 fun_id;
+	u16 i;
+
+	skb = first->skb;
+	shinfo = skb_shinfo(skb);
+	fun_id = (u64)tx_ring->pfvfnum << 56;
+	nr_frags = shinfo->nr_frags;
+	i = tx_ring->next_to_use;
+	frag_idx = 0;
+	tx_desc = M_TX_DESC(tx_ring, i);
+	size = skb_headlen(skb);
+	data_len = skb->data_len;
+
+	if (size) {
+		dma = dma_map_single(tx_ring->dev, skb->data, size,
+				     DMA_TO_DEVICE);
+		first->mapped_as_page = false;
+	} else if (data_len) {
+		while (frag_idx < nr_frags &&
+		       !skb_frag_size(&shinfo->frags[frag_idx]))
+			frag_idx++;
+
+		if (frag_idx == nr_frags)
+			goto err_unmap;
+
+		frag = &shinfo->frags[frag_idx];
+		size = skb_frag_size(frag);
+
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0,
+				       size, DMA_TO_DEVICE);
+		first->mapped_as_page = true;
+		data_len -= size;
+		frag_idx++;
+	} else {
+		goto err_unmap;
+	}
+
+	tx_buffer = first;
+
+	dma_unmap_len_set(tx_buffer, len, 0);
+	dma_unmap_addr_set(tx_buffer, dma, 0);
+
+	for (;; frag_idx++) {
+		if (dma_mapping_error(tx_ring->dev, dma))
+			goto err_unmap;
+
+		/* record length, and DMA address */
+		dma_unmap_len_set(tx_buffer, len, size);
+		dma_unmap_addr_set(tx_buffer, dma, dma);
+
+		tx_desc->pkt_addr = cpu_to_le64(dma | fun_id);
+
+		while (unlikely(size > M_MAX_DATA_PER_TXD)) {
+			tx_desc->vlan_cmd_bsz = build_ctob(tx_flags,
+							   mac_ip_len,
+							   M_MAX_DATA_PER_TXD);
+			i++;
+			tx_desc++;
+			if (i == tx_ring->count) {
+				tx_desc = M_TX_DESC(tx_ring, 0);
+				i = 0;
+			}
+
+			tx_buffer = &tx_ring->tx_buffer_info[i];
+			dma_unmap_len_set(tx_buffer, len, 0);
+			dma += M_MAX_DATA_PER_TXD;
+			size -= M_MAX_DATA_PER_TXD;
+			tx_desc->pkt_addr = cpu_to_le64(dma | fun_id);
+		}
+
+		if (likely(!data_len))
+			break;
+		tx_desc->vlan_cmd_bsz = build_ctob(tx_flags, mac_ip_len, size);
+		i++;
+		tx_desc++;
+		if (i == tx_ring->count) {
+			tx_desc = M_TX_DESC(tx_ring, 0);
+			i = 0;
+		}
+
+		while (frag_idx < nr_frags &&
+		       !skb_frag_size(&shinfo->frags[frag_idx]))
+			frag_idx++;
+
+		if (frag_idx == nr_frags)
+			goto err_unmap;
+
+		frag = &shinfo->frags[frag_idx];
+		size = skb_frag_size(frag);
+		data_len -= size;
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, size,
+				       DMA_TO_DEVICE);
+		tx_buffer = &tx_ring->tx_buffer_info[i];
+		tx_buffer->mapped_as_page = true;
+	}
+
+	/* write last descriptor with RS and EOP bits */
+	tx_desc->vlan_cmd_bsz = build_ctob(tx_flags | M_TXD_CMD_EOP |
+					   M_TXD_CMD_RS,
+					   mac_ip_len, size);
+
+	/* Force memory writes to complete before letting h/w know there
+	 * are new descriptors to fetch.  (Only applicable for weak-ordered
+	 * memory model archs, such as IA-64).
+	 *
+	 * We also need this memory barrier to make certain all of the
+	 * status bits have been updated before next_to_watch is written.
+	 */
+	dma_wmb();
+	/* set next_to_watch value indicating a packet is present */
+	first->next_to_watch = tx_desc;
+	i++;
+	if (i == tx_ring->count)
+		i = 0;
+	tx_ring->next_to_use = i;
+	skb_tx_timestamp(skb);
+	netdev_tx_sent_queue(txring_txq(tx_ring), first->bytecount);
+	/* notify HW of packet */
+	writel(i, tx_ring->tail);
+
+	return 0;
+err_unmap:
+	for (;;) {
+		tx_buffer = &tx_ring->tx_buffer_info[i];
+		if (dma_unmap_len(tx_buffer, len)) {
+			if (tx_buffer->mapped_as_page) {
+				dma_unmap_page(tx_ring->dev,
+					       dma_unmap_addr(tx_buffer, dma),
+					       dma_unmap_len(tx_buffer, len),
+					       DMA_TO_DEVICE);
+			} else {
+				dma_unmap_single(tx_ring->dev,
+						 dma_unmap_addr(tx_buffer, dma),
+						 dma_unmap_len(tx_buffer, len),
+						 DMA_TO_DEVICE);
+			}
+		}
+		dma_unmap_len_set(tx_buffer, len, 0);
+		dma_unmap_addr_set(tx_buffer, dma, 0);
+		if (tx_buffer == first)
+			break;
+		if (i == 0)
+			i += tx_ring->count;
+		i--;
+	}
+	dev_kfree_skb_any(first->skb);
+	first->skb = NULL;
+	tx_ring->next_to_use = i;
+
+	return -ENOMEM;
+}
+
+netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
+				   struct mucse_ring *tx_ring)
+{
+	/* hw requires non-zero mac_ip_len even without offload;
+	 * Will be updated per-packet when offload is added
+	 */
+	u32 mac_ip_len = M_DEFAULT_MAC_IP_LEN;
+	struct mucse_tx_buffer *first;
+	u32 tx_flags = 0;
+	unsigned short f;
+	u16 count;
+
+	count = TXD_USE_COUNT(skb_headlen(skb));
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+		skb_frag_t *frag_temp = &skb_shinfo(skb)->frags[f];
+
+		count += TXD_USE_COUNT(skb_frag_size(frag_temp));
+	}
+
+	if (!netif_txq_maybe_stop(txring_txq(tx_ring),
+				  mucse_desc_unused(tx_ring),
+				  count + RESV_DESC_NEEDED,
+				  count + RESV_DESC_NEEDED))
+		return NETDEV_TX_BUSY;
+
+	/* record the location of the first descriptor for this packet */
+	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	first->skb = skb;
+	first->bytecount = skb->len;
+	first->gso_segs = 1;
+
+	if (rnpgbe_tx_map(tx_ring, first, mac_ip_len, tx_flags)) {
+		atomic64_inc(&tx_ring->stats->dropped);
+
+		goto out;
+	}
+
+	/* NETDEV_TX_BUSY is expensive. So stop advancing the TX queue. */
+	netif_txq_maybe_stop(txring_txq(tx_ring),
+			     mucse_desc_unused(tx_ring),
+			     DESC_NEEDED, DESC_NEEDED);
+out:
+	return NETDEV_TX_OK;
+}
+
+/**
+ * rnpgbe_get_stats64 - Get stats for this netdev
+ * @netdev: network interface device structure
+ * @stats: stats data
+ **/
+void rnpgbe_get_stats64(struct net_device *netdev,
+			struct rtnl_link_stats64 *stats)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < RNPGBE_MAX_QUEUES; i++) {
+		unsigned int start;
+		u64 bytes, packets, dropped;
+		struct mucse_queue_stats *queue_stats = &mucse->tx_stats[i];
+
+		do {
+			start = u64_stats_fetch_begin(&queue_stats->syncp);
+			packets = queue_stats->packets;
+			bytes = queue_stats->bytes;
+		} while (u64_stats_fetch_retry(&queue_stats->syncp, start));
+		dropped = atomic64_read(&queue_stats->dropped);
+
+		stats->tx_packets += packets;
+		stats->tx_dropped += dropped;
+		stats->tx_bytes += bytes;
+	}
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index a1074890f5ad..2e0f210f35e7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -5,20 +5,43 @@
 #define _RNPGBE_LIB_H
 
 #include <linux/bits.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
 
 struct mucse;
 struct mucse_hw;
+struct mucse_ring;
 
 #define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
+#define RNPGBE_TX_START           0x18
 #define RNPGBE_DMA_INT_MASK       0x24
 #define TX_INT_MASK               BIT(1)
 #define RX_INT_MASK               BIT(0)
 #define INT_VALID                 (BIT(16) | BIT(17))
 #define RNPGBE_DMA_INT_TRIG       0x2c /* lost-interrupt recovery trigger */
+#define RNPGBE_TX_BASE_ADDR_HI    0x60
+#define RNPGBE_TX_BASE_ADDR_LO    0x64
+#define RNPGBE_TX_LEN             0x68
+#define RNPGBE_TX_HEAD            0x6c
+#define RNPGBE_TX_TAIL            0x70
+#define M_DEFAULT_TX_FETCH        0x80008
+#define RNPGBE_TX_FETCH_CTRL      0x74
+#define M_DEFAULT_INT_TIMER       100
+#define RNPGBE_TX_INT_TIMER       0x78
+#define M_DEFAULT_INT_PKTCNT      48
+#define RNPGBE_TX_INT_PKTCNT      0x7c
 /* |  31:24   | .... |    15:8   |    7:0    | */
 /* |  pfvfnum |      | tx vector | rx vector | */
 #define RING_VECTOR(n)            (0x04 * (n))
 
+#define M_MAX_TXD_PWR             12
+#define M_MAX_DATA_PER_TXD        (0x1 << M_MAX_TXD_PWR)
+#define TXD_USE_COUNT(S)          DIV_ROUND_UP((S), M_MAX_DATA_PER_TXD)
+#define DESC_NEEDED               (MAX_SKB_FRAGS + 4)
+/* Leave two descriptors between the tail and head. */
+#define RESV_DESC_NEEDED          2
+/* Hardware requires this to be nonzero */
+#define M_DEFAULT_MAC_IP_LEN      20
 #define mucse_for_each_ring(pos, head)\
 	for (typeof((head).ring) __pos = (head).ring;\
 	     __pos ? ({ pos = __pos; 1; }) : 0;\
@@ -32,4 +55,12 @@ int rnpgbe_request_irq(struct mucse *mucse);
 void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
 void rnpgbe_up_complete(struct mucse *mucse);
+int rnpgbe_configure_tx(struct mucse *mucse);
+void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
+int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
+void rnpgbe_free_all_tx_resources(struct mucse *mucse);
+netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
+				   struct mucse_ring *tx_ring);
+void rnpgbe_get_stats64(struct net_device *netdev,
+			struct rtnl_link_stats64 *stats);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 6022a1a2ddf1..265a3fcb07be 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
 #include <linux/pci.h>
+#include <linux/skbuff.h>
 #include <net/rtnetlink.h>
 #include <linux/etherdevice.h>
 
@@ -26,6 +27,19 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{ },
 };
 
+/**
+ * rnpgbe_configure - Configure the hardware
+ * @mucse: pointer to private structure
+ *
+ * Configure Tx registers in hardware.
+ *
+ * Return: 0 on success, negative errno if hardware configuration fails
+ **/
+static int rnpgbe_configure(struct mucse *mucse)
+{
+	return rnpgbe_configure_tx(mucse);
+}
+
 /**
  * rnpgbe_open - Called when a network interface is made active
  * @netdev: network interface device structure
@@ -40,6 +54,9 @@ static int rnpgbe_open(struct net_device *netdev)
 	struct mucse *mucse = netdev_priv(netdev);
 	int err;
 
+	if (test_bit(__MUCSE_AXI_FAULT, &mucse->state))
+		return -EIO;
+
 	err = rnpgbe_request_irq(mucse);
 	if (err)
 		return err;
@@ -49,9 +66,19 @@ static int rnpgbe_open(struct net_device *netdev)
 	if (err)
 		goto err_free_irqs;
 
+	err = rnpgbe_setup_all_tx_resources(mucse);
+	if (err)
+		goto err_free_irqs;
+
+	err = rnpgbe_configure(mucse);
+	if (err)
+		goto err_free_tx;
 	rnpgbe_up_complete(mucse);
 
 	return 0;
+err_free_tx:
+	rnpgbe_clean_all_tx_rings(mucse);
+	rnpgbe_free_all_tx_resources(mucse);
 err_free_irqs:
 	rnpgbe_free_irq(mucse);
 	return err;
@@ -72,6 +99,7 @@ static int rnpgbe_close(struct net_device *netdev)
 
 	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
+	rnpgbe_free_all_tx_resources(mucse);
 
 	return 0;
 }
@@ -81,25 +109,44 @@ static int rnpgbe_close(struct net_device *netdev)
  * @skb: skb structure to be sent
  * @netdev: network interface device structure
  *
- * Return: NETDEV_TX_OK
+ * Return: NETDEV_TX_OK or NETDEV_TX_BUSY when insufficient descriptors
  **/
 static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
 				     struct net_device *netdev)
 {
 	struct mucse *mucse = netdev_priv(netdev);
+	struct mucse_ring *tx_ring;
 
-	dev_kfree_skb_any(skb);
-	mucse->stats.tx_dropped++;
+	tx_ring = mucse->tx_ring[skb_get_queue_mapping(skb)];
 
-	return NETDEV_TX_OK;
+	if (unlikely(skb_put_padto(skb, RNPGBE_TX_MIN_PKT_LEN))) {
+		atomic64_inc(&tx_ring->stats->dropped);
+		return NETDEV_TX_OK;
+	}
+
+	return rnpgbe_xmit_frame_ring(skb, tx_ring);
 }
 
 static const struct net_device_ops rnpgbe_netdev_ops = {
 	.ndo_open       = rnpgbe_open,
 	.ndo_stop       = rnpgbe_close,
 	.ndo_start_xmit = rnpgbe_xmit_frame,
+	.ndo_get_stats64 = rnpgbe_get_stats64,
 };
 
+static void rnpgbe_sw_init(struct mucse *mucse)
+{
+	int i;
+
+	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
+
+	for (i = 0; i < RNPGBE_MAX_QUEUES; i++) {
+		u64_stats_init(&mucse->tx_stats[i].syncp);
+		atomic64_set(&mucse->tx_stats[i].dropped, 0);
+	}
+}
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -172,6 +219,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
 		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
@@ -206,6 +254,14 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_clear_interrupt;
 	}
 
+	netdev->features |= NETIF_F_SG;
+	netdev->hw_features |= NETIF_F_SG;
+	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32)) {
+		netdev->features |= NETIF_F_HIGHDMA;
+		netdev->hw_features |= NETIF_F_HIGHDMA;
+	}
+
+	netif_carrier_off(netdev);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_remove_mbx;
@@ -248,12 +304,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		return err;
 
-	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
-	if (err) {
-		dev_err(&pdev->dev,
-			"No usable DMA configuration, aborting %d\n", err);
-		goto err_disable_dev;
-	}
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(56));
 
 	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
 	if (err) {
-- 
2.50.1

