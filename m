Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE493E1225;
	Fri, 31 Jul 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499473; cv=none; b=LBMwj3Eoy4m9ZnjawVzZKtCK7QxD3BPu/uSOTdGUyblh7G6Dk96h/f2weccmRPrWL17hK4lLl3YSygmfd6kvMYxLtwyyhqq1OXVQG/vQhEgBV4hBP7nMRG4Zsl0pDL5/OHMDm6DQ6s9DGE1fJalEX7GtwOBF/o/TzPiFs/Gg+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499473; c=relaxed/simple;
	bh=/bFLeySUIQET+YN3VLeepGMr1HrlQtmYY6AtZ0QgGmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koLhAed6cVjjc4/gT2ti8exp2mBNd8adQSyKc392aCx8urejOXKuhMgw89dKKp/amkXjbjUB07Dfdq9X1b/4e1d79AtBoW/hEqomRINjvRmUtiSQECOdc3HUhHubB/W4l7JGMcc+MlnVRydkN4d7lZb8oS2yKh9tH/Hgny6aLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1785499422t53687a11
X-QQ-Originating-IP: 9V6ER0EIdUaeM1xVNkHFzgq7xDqYBDnYGEC/YTCIhXw=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 20:03:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12722072889354018071
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v8 3/4] net: rnpgbe: Add RX packet reception support
Date: Fri, 31 Jul 2026 20:03:21 +0800
Message-Id: <20260731120322.895955-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260731120322.895955-1-dong100@mucse.com>
References: <20260731120322.895955-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MjtcwOZJa0njYJlLpkmWES5QVqoC9bUXMxaJiO/UjjLqCR8rkHN4wBbB
	MvjWv/AaplLTqoVlBgcKkQWzbToH4QcentCAOAkHU2pxpaNzWFO98UIP9NffCjhmZBEbitT
	hqgYgBQFHaB9h1a2oQ7LKoTAHPtofVyr0dBac9c9dOo1/EMxJtVYCmkCM1JMo9HBKff33pH
	OLe7mN7d09g2d0zZeyoNtQLcm2FRh6Wzhgetacx7nv1Ft5N5TW5OOwrfH3XV3L4jJVd0VbI
	t0v2aE0LJgDeHJaf6HgnU33OCi1Tqs78cwBwPutVugU+FsWwo7XVm4Z+cXtpdJZKy2aArC+
	EIzJ6KK+JQQKOtUjVzYFCyPHotpqOVS7bV3apjN/Tze+TbKw59bSGf0XNuuu7iO2AyLohne
	Z/dcY0DHkxvDnK4fbGevtjsBpPtOCC0f+oz/Wv1l03waRiWTfUXmTH/kd9UEGtHdU9SLC+0
	HPtUJiXl7AfmlgYl7LKYheQsrfC4Rea2W0RGqNojK3YrC/75hIAPwJ2blEAOAR8wwY6t6+8
	oOstx4Mo95T1Svl1c2YHW2IMt583I+JDXiXW1rqrT4XhinnqncsW2C/oOBjQxIkDhEpEybn
	8VtyI1ACIv6lBCnzhqbXZ1x/rXWQEBg0E+E89580x5fnA1MQBe+RVMU3AurbiJboJ+WhmDF
	R8IapQQ8dqVfqRLSUE3L62egiQwwBlVj/e09PJ0HMDl49qO2IXMi7Ly0VwJ2soAFxI5EGuO
	7bZoqOGOhoZhQ4oGpNEYO6hYLSJ9LmgzxMjXMMtVR3lgkTlgzvjVHnzqV8H440ihMROdQ4F
	p6Xu3MHuHzKxu+ZXhs94eP5HhomjHK6axVpkOXnTn+dE2uDwB8lLkTSA0xPao3Rio6FiVBD
	wBBcmAAMmzOtrRuWRvDZc9ok25us1z/MpIdEiTNWhg+XrVJrYoPjk9OC+6FCXICDbHpMtQS
	gJtEXXZrMYGVP76pElvJfTGC6GmoLstuhruDL0UsAF/KfSiA+sS8pdBe+eORIhp4SwCBVgc
	qbrh3H2zhuuXeVWCJfK8Z165YOe89wRx3aJ7JYqCcM2ILAr1+wGrEHxMqmMkMvREjllUcMl
	PwQ7FW+pmouKTbjFVU8F8k=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Add basic RX packet reception infrastructure to the rnpgbe driver:
- Add RX descriptor structure (union rnpgbe_rx_desc) with write-back
  format for hardware status
- Add RX buffer management using page_pool for efficient page recycling
  (basic version, 1 page for 1 descriptor, no page splitting; ring depth
  is fixed at 512, 'ethtool ringparm' not yet supported)
- Implement NAPI poll callback (rnpgbe_poll) for RX processing
- Add RX ring setup and cleanup functions
- Implement packet building from page buffer
- Add RX statistics tracking

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/Kconfig            |   1 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  59 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 738 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  25 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   9 +
 6 files changed, 829 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..be0fdf268484 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -19,6 +19,7 @@ if NET_VENDOR_MUCSE
 config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
 	depends on PCI
+	select PAGE_POOL
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
 	  adapters.
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 716e778aedfe..8b0ac3e4255e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -62,7 +62,32 @@ struct rnpgbe_tx_desc {
 #define M_TXD_CMD_EOP         0x010000 /* End of Packet */
 };
 
+union rnpgbe_rx_desc {
+	struct {
+		__le64 pkt_addr; /* Packet buffer address */
+		__le64 resv_cmd; /* cmd status */
+	};
+	struct {
+		__le32 rss_hash; /* RSS HASH */
+		__le16 mark; /* mark info */
+		__le16 rev1;
+		__le16 len; /* Packet length */
+		__le16 padding_len;
+		__le16 vlan; /* VLAN tag */
+		__le16 cmd; /* cmd status */
+#define M_RXD_STAT_DD         BIT(1) /* Descriptor Done */
+#define M_RXD_STAT_EOP        BIT(0) /* End of Packet */
+	} wb;
+};
+
 #define M_TX_DESC(R, i) (&(((struct rnpgbe_tx_desc *)((R)->desc))[i]))
+#define M_RX_DESC(R, i) (&(((union rnpgbe_rx_desc *)((R)->desc))[i]))
+
+static inline __le16 rnpgbe_test_staterr(union rnpgbe_rx_desc *rx_desc,
+					 const u16 stat_err_bits)
+{
+	return rx_desc->wb.cmd & cpu_to_le16(stat_err_bits);
+}
 
 struct mucse_tx_buffer {
 	struct rnpgbe_tx_desc *next_to_watch;
@@ -80,13 +105,24 @@ struct mucse_queue_stats {
 	atomic64_t dropped;
 };
 
+struct mucse_rx_buffer {
+	struct sk_buff *skb;
+	dma_addr_t dma;
+	struct page *page;
+	u32 page_offset;
+};
+
 struct mucse_ring {
 	struct mucse_ring *next;
 	struct mucse_q_vector *q_vector;
 	struct net_device *netdev;
 	struct device *dev;
+	struct page_pool *page_pool;
 	void *desc;
-	struct mucse_tx_buffer *tx_buffer_info;
+	union {
+		struct mucse_tx_buffer *tx_buffer_info;
+		struct mucse_rx_buffer *rx_buffer_info;
+	};
 	void __iomem *ring_addr;
 	void __iomem *tail;
 	void __iomem *irq_mask;
@@ -102,6 +138,8 @@ struct mucse_ring {
 	unsigned int size;
 	struct mucse_queue_stats stats;
 	struct u64_stats_sync syncp;
+	bool drop_status;
+	struct delayed_work alloc_retry_work;
 } ____cacheline_internodealigned_in_smp;
 
 static inline u16 mucse_desc_unused(struct mucse_ring *ring)
@@ -112,6 +150,23 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+static inline u16 mucse_desc_unused_rx(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	/* Reserve 16 descriptors to keep the RX head aligned to a 16-descriptor
+	 * boundary after refill. Buffers are always refilled in batches of 16
+	 * (M_RX_BUFFER_WRITE) and the hardware DMA engine performs cache-line
+	 * prefetch based on the current head position. Keeping the head at a
+	 * 16-aligned boundary prevents partial cache-line fetches and improves
+	 * DMA efficiency.
+	 *
+	 * Effective ring depth: ring->count - 16
+	 */
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 16;
+}
+
 static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
 {
 	return cpu_to_le64(((u64)vlan_cmd << 32) | ((u64)mac_ip_len << 16) |
@@ -141,6 +196,7 @@ struct mucse_q_vector {
 #define MAX_Q_VECTORS 8
 
 #define M_DEFAULT_TXD     512
+#define M_DEFAULT_RXD     512
 #define M_DEFAULT_TX_WORK 256
 
 enum mucse_state_t {
@@ -164,6 +220,7 @@ struct mucse {
 	int tx_work_limit;
 	int num_tx_queues;
 	int num_q_vectors;
+	int rx_ring_item_count;
 	int num_rx_queues;
 	char mbx_name[32];
 	unsigned long state;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index cbc593902030..03688586b447 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -16,6 +16,7 @@
 #define M_DEFAULT_N210_MHZ             62
 
 #define TX_AXI_RW_EN                   0xc
+#define RX_AXI_RW_EN                   0x03
 #define RNPGBE_DMA_AXI_EN              0x0010
 
 #define RNPGBE_MAX_QUEUES 8
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 1a1afc93eb87..7825a36fdfbe 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -3,8 +3,10 @@
 
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/vmalloc.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 
 #include "rnpgbe_lib.h"
 #include "rnpgbe.h"
@@ -197,8 +199,433 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
 	return !!budget;
 }
 
+static bool mucse_alloc_mapped_page(struct mucse_ring *rx_ring,
+				    struct mucse_rx_buffer *bi)
+{
+	struct page *page = bi->page;
+	dma_addr_t dma;
+
+	if (page) {
+		/* Buffer is being reused without going back through the
+		 * page_pool. Do dma_sync for hw use.
+		 */
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset,
+						 PAGE_SIZE - bi->page_offset,
+						 DMA_FROM_DEVICE);
+		return true;
+	}
+
+	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+	if (unlikely(!page))
+		return false;
+	dma = page_pool_get_dma_addr(page);
+
+	bi->dma = dma;
+	bi->page = page;
+	bi->page_offset = RNPGBE_SKB_PAD;
+
+	return true;
+}
+
+static void mucse_update_rx_tail(struct mucse_ring *rx_ring,
+				 u32 val)
+{
+	rx_ring->next_to_use = val;
+	writel(val, rx_ring->tail);
+}
+
+/**
+ * rnpgbe_alloc_rx_buffers - Replace used receive buffers
+ * @rx_ring: ring to place buffers on
+ * @cleaned_count: number of buffers to replace
+ *
+ * Return: true if alloc failed
+ **/
+static bool rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count)
+{
+	u64 fun_id = ((u64)(rx_ring->pfvfnum) << 56);
+	union rnpgbe_rx_desc *rx_desc;
+	u16 i = rx_ring->next_to_use;
+	struct mucse_rx_buffer *bi;
+	bool err = false;
+	u64 addr;
+	/* nothing to do */
+	if (!cleaned_count)
+		return err;
+
+	rx_desc = M_RX_DESC(rx_ring, i);
+	bi = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+
+	do {
+		if (!mucse_alloc_mapped_page(rx_ring, bi)) {
+			err = true;
+			break;
+		}
+
+		addr = (u64)(bi->dma + bi->page_offset);
+		rx_desc->pkt_addr = cpu_to_le64(addr | fun_id);
+		/* clean dd */
+		rx_desc->resv_cmd = 0;
+		rx_desc++;
+		bi++;
+		i++;
+		if (unlikely(!i)) {
+			rx_desc = M_RX_DESC(rx_ring, 0);
+			bi = rx_ring->rx_buffer_info;
+			i -= rx_ring->count;
+		}
+		cleaned_count--;
+	} while (cleaned_count);
+
+	i += rx_ring->count;
+
+	if (rx_ring->next_to_use != i) {
+		/*
+		 * Force memory writes to complete before letting h/w know
+		 * there are new rx descriptors to fetch.  (Only applicable
+		 * for weak-ordered memory model archs, such as IA-64).
+		 */
+		dma_wmb();
+		/* Notify the Hardware that new rx descriptors are ready */
+		mucse_update_rx_tail(rx_ring, i);
+	}
+
+	return err;
+}
+
+/**
+ * rnpgbe_get_buffer - Get the rx_buffer to be used
+ * @rx_ring: pointer to rx ring
+ * @skb: pointer skb for this packet
+ * @size: data size in this desc
+ *
+ * Return: rx_buffer.
+ **/
+static struct mucse_rx_buffer *rnpgbe_get_buffer(struct mucse_ring *rx_ring,
+						 struct sk_buff **skb,
+						 const unsigned int size)
+{
+	struct mucse_rx_buffer *rx_buffer;
+
+	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+	*skb = rx_buffer->skb;
+	prefetchw(page_address(rx_buffer->page) + rx_buffer->page_offset);
+	/* we are reusing so sync this buffer for CPU use */
+	dma_sync_single_range_for_cpu(rx_ring->dev, rx_buffer->dma,
+				      rx_buffer->page_offset, size,
+				      DMA_FROM_DEVICE);
+
+	return rx_buffer;
+}
+
+/**
+ * rnpgbe_add_rx_frag - Add non-linear data to the skb
+ * @rx_buffer: pointer to rx_buffer
+ * @skb: pointer skb for this packet
+ * @size: data size in this desc
+ **/
+static void rnpgbe_add_rx_frag(struct mucse_rx_buffer *rx_buffer,
+			       struct sk_buff *skb,
+			       unsigned int size)
+{
+	/* FIXME: truesize is PAGE_SIZE for 1 page = 1 descriptor.
+	 * Optimize with page splitting later when refactoring
+	 * the Rx buffer management.
+	 */
+	unsigned int truesize = PAGE_SIZE;
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
+			rx_buffer->page_offset, size, truesize);
+}
+
+/**
+ * rnpgbe_build_skb - Try to build a skb based on rx_buffer
+ * @rx_buffer: pointer to rx_buffer
+ * @size: data size in this desc
+ *
+ * Return: skb for this rx_buffer
+ **/
+static struct sk_buff *rnpgbe_build_skb(struct mucse_rx_buffer *rx_buffer,
+					unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	unsigned int truesize = PAGE_SIZE;
+	struct sk_buff *skb;
+
+	net_prefetch(va);
+	/* build an skb around the page buffer */
+	skb = build_skb(va - RNPGBE_SKB_PAD, truesize);
+	if (unlikely(!skb))
+		return NULL;
+	/* update pointers within the skb to store the data */
+	skb_reserve(skb, RNPGBE_SKB_PAD);
+	__skb_put(skb, size);
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+/**
+ * rnpgbe_is_non_eop - Process handling of non-EOP buffers
+ * @rx_ring: rx ring being processed
+ * @rx_desc: rx descriptor for current buffer
+ * @skb: current socket buffer containing buffer in progress
+ *
+ * This function updates next to clean.  If the buffer is an EOP buffer
+ * this function exits returning false, otherwise it will place the
+ * sk_buff in the next buffer to be chained and return true indicating
+ * that this is in fact a non-EOP buffer.
+ *
+ * Return: true for not end of packet
+ **/
+static bool rnpgbe_is_non_eop(struct mucse_ring *rx_ring,
+			      union rnpgbe_rx_desc *rx_desc,
+			      struct sk_buff *skb)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	/* fetch, update, and store next to clean */
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+	prefetch(M_RX_DESC(rx_ring, ntc));
+	/* if we are the last buffer then there is nothing else to do */
+	if (likely(rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)))
+		return false;
+	if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
+		/* place skb in next buffer to be received */
+		rx_ring->rx_buffer_info[ntc].skb = skb;
+	} else {
+		atomic64_inc(&rx_ring->stats.dropped);
+		/* too much frags, force free */
+		dev_kfree_skb_any(skb);
+		rx_ring->drop_status = true;
+	}
+	/* we should clean it since we used all info in it */
+	rx_desc->wb.cmd = 0;
+
+	return true;
+}
+
+/**
+ * rnpgbe_cleanup_headers - Correct corrupted or empty headers
+ * @skb: current socket buffer containing buffer in progress
+ *
+ * Return: true if an error was encountered and skb was freed.
+ **/
+static bool rnpgbe_cleanup_headers(struct sk_buff *skb)
+{
+	/* if eth_skb_pad returns an error the skb was freed */
+	if (eth_skb_pad(skb))
+		return true;
+
+	return false;
+}
+
+/**
+ * rnpgbe_process_skb_fields - Setup skb header fields from desc
+ * @rx_ring: structure containing ring specific data
+ * @skb: skb currently being received and modified
+ *
+ * rnpgbe_process_skb_fields checks the ring, descriptor information
+ * in order to setup the hash, chksum, vlan, protocol, and other
+ * fields within the skb.
+ **/
+static void rnpgbe_process_skb_fields(struct mucse_ring *rx_ring,
+				      struct sk_buff *skb)
+{
+	struct net_device *dev = rx_ring->netdev;
+
+	skb_record_rx_queue(skb, rx_ring->queue_index);
+	skb->protocol = eth_type_trans(skb, dev);
+}
+
+/**
+ * rnpgbe_alloc_retry_work - Deferred alloc retry callback
+ * @work: pointer to delayed_work embedded in mucse_ring
+ *
+ * Scheduled after RX buffer allocation fails during NAPI polling or
+ * initial ring configuration. Re-schedules NAPI to retry descriptor
+ * refill without busy-looping.
+ **/
+static void rnpgbe_alloc_retry_work(struct work_struct *work)
+{
+	struct delayed_work *dw = to_delayed_work(work);
+	struct mucse_ring *rx_ring =
+		container_of(dw, struct mucse_ring, alloc_retry_work);
+	struct mucse_q_vector *q_vector = rx_ring->q_vector;
+
+	if (test_bit(__MUCSE_DOWN, &q_vector->mucse->state)) {
+		/* up_complete not yet run; retry later */
+		queue_delayed_work(system_wq, &rx_ring->alloc_retry_work,
+				   msecs_to_jiffies(500));
+		return;
+	}
+
+	napi_schedule(&q_vector->napi);
+}
+
+/**
+ * rnpgbe_clean_rx_irq - Clean completed descriptors from Rx ring
+ * @q_vector: structure containing interrupt and ring information
+ * @rx_ring: rx descriptor ring to transact packets on
+ * @budget: total limit on number of packets to process
+ *
+ * rnpgbe_clean_rx_irq tries to check dd in desc, handle this desc
+ * if dd is set which means data is write-back by hw
+ *
+ * Return: amount of work completed.
+ **/
+static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
+			       struct mucse_ring *rx_ring,
+			       int budget)
+{
+	unsigned int max_size = SKB_WITH_OVERHEAD(PAGE_SIZE) - RNPGBE_SKB_PAD;
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
+
+	while (likely(total_rx_packets < budget)) {
+		struct mucse_rx_buffer *rx_buffer;
+		union rnpgbe_rx_desc *rx_desc;
+		struct sk_buff *skb;
+		unsigned int size;
+
+		if (cleaned_count >= M_RX_BUFFER_WRITE) {
+			if (rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count)) {
+				queue_delayed_work(system_wq,
+						   &rx_ring->alloc_retry_work,
+						   msecs_to_jiffies(500));
+				cleaned_count = mucse_desc_unused_rx(rx_ring);
+			} else {
+				cancel_delayed_work(&rx_ring->alloc_retry_work);
+				cleaned_count = 0;
+			}
+		}
+		rx_desc = M_RX_DESC(rx_ring, rx_ring->next_to_clean);
+
+		if (!rnpgbe_test_staterr(rx_desc, M_RXD_STAT_DD))
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		dma_rmb();
+		/* Hardware enforces: minimum 33-bytes descriptor(no 1-13 byte
+		 * size), multi-descriptors only for jumbo frames > 1536 bytes
+		 * (controlled by M_DEFAULT_SG=96, each descriptor no more than
+		 * 1536 bytes). Small packets use single descriptor.
+		 */
+		size = le16_to_cpu(rx_desc->wb.len);
+
+		if (unlikely(rx_ring->drop_status)) {
+			cleaned_count++;
+			/* drop data until eop */
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP))
+				rx_ring->drop_status = false;
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
+			if (rx_ring->next_to_clean >= rx_ring->count)
+				rx_ring->next_to_clean = 0;
+			continue;
+		}
+
+		if (unlikely(!size || size > max_size)) {
+			struct mucse_rx_buffer *err_rx_buffer;
+			u16 idx = rx_ring->next_to_clean;
+
+			cleaned_count++;
+			atomic64_inc(&rx_ring->stats.dropped);
+
+			/* Free any skb left from a previous non-EOP descriptor.
+			 * When an earlier descriptor for a scattered (jumbo)
+			 * packet stored its skb in this slot via
+			 * rnpgbe_is_non_eop() and this descriptor turns out to
+			 * be invalid, we must release the partial skb before
+			 * advancing next_to_clean.
+			 */
+			err_rx_buffer = &rx_ring->rx_buffer_info[idx];
+			if (unlikely(err_rx_buffer->skb)) {
+				dev_kfree_skb_any(err_rx_buffer->skb);
+				err_rx_buffer->skb = NULL;
+			}
+
+			/* drop data until eop */
+			if (!rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP))
+				rx_ring->drop_status = true;
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
+			if (rx_ring->next_to_clean >= rx_ring->count)
+				rx_ring->next_to_clean = 0;
+			continue;
+		}
+
+		/* TODO: hardware error checks (wb.status: crc_err, etc.) in
+		 * the future. For now the basic RX path relies on the stack
+		 * to drop malformed packets naturally.
+		 */
+
+		rx_buffer = rnpgbe_get_buffer(rx_ring, &skb, size);
+
+		if (skb)
+			rnpgbe_add_rx_frag(rx_buffer, skb, size);
+		else
+			skb = rnpgbe_build_skb(rx_buffer, size);
+
+		if (!skb) {
+			cleaned_count++;
+
+			/* drop until eop if multiple descriptors */
+			if (!(rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)))
+				rx_ring->drop_status = true;
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
+			atomic64_inc(&rx_ring->stats.dropped);
+			if (rx_ring->next_to_clean >= rx_ring->count)
+				rx_ring->next_to_clean = 0;
+
+			continue;
+		}
+
+		rx_buffer->page = NULL;
+		rx_buffer->skb = NULL;
+		cleaned_count++;
+
+		if (rnpgbe_is_non_eop(rx_ring, rx_desc, skb))
+			continue;
+
+		/* verify the packet layout is correct */
+		if (rnpgbe_cleanup_headers(skb)) {
+			/* we should clean it since we used all info in it */
+			atomic64_inc(&rx_ring->stats.dropped);
+			rx_desc->wb.cmd = 0;
+			continue;
+		}
+
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		rnpgbe_process_skb_fields(rx_ring, skb);
+		rx_desc->wb.cmd = 0;
+		napi_gro_receive(&q_vector->napi, skb);
+		/* update budget accounting */
+		total_rx_packets++;
+	}
+
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.packets += total_rx_packets;
+	rx_ring->stats.bytes += total_rx_bytes;
+	u64_stats_update_end(&rx_ring->syncp);
+
+	return total_rx_packets;
+}
+
 /**
- * rnpgbe_poll - NAPI Rx polling callback
+ * rnpgbe_poll - NAPI polling callback
  * @napi: structure for representing this polling device
  * @budget: how many packets driver is allowed to clean
  *
@@ -212,6 +639,7 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		container_of(napi, struct mucse_q_vector, napi);
 	bool clean_complete = true;
 	struct mucse_ring *ring;
+	int per_ring_budget;
 	int work_done = 0;
 
 	mucse_for_each_ring(ring, q_vector->tx) {
@@ -223,6 +651,20 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 	if (unlikely(!budget))
 		return 0;
 
+	if (q_vector->rx.count > 1)
+		per_ring_budget = max(budget / q_vector->rx.count, 1);
+	else
+		per_ring_budget = budget;
+
+	mucse_for_each_ring(ring, q_vector->rx) {
+		int cleaned = 0;
+
+		cleaned = rnpgbe_clean_rx_irq(q_vector, ring, per_ring_budget);
+		work_done += cleaned;
+		if (cleaned >= per_ring_budget)
+			clean_complete = false;
+	}
+
 	if (!clean_complete)
 		return budget;
 
@@ -408,13 +850,18 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
 	}
 
 	for (idx = 0; idx < rxr_count; idx++) {
+		ring->dev = &mucse->pdev->dev;
 		mucse_add_ring(ring, &q_vector->rx);
+		ring->count = mucse->rx_ring_item_count;
+		ring->netdev = mucse->netdev;
 		ring->queue_index = eth_queue_idx + idx;
 		ring->rnpgbe_queue_idx = rxr_idx;
 		ring->ring_addr = hw->hw_addr + RING_OFFSET(rxr_idx);
 		ring->irq_mask = ring->ring_addr + RNPGBE_DMA_INT_MASK;
 		ring->trig = ring->ring_addr + RNPGBE_DMA_INT_TRIG;
 		ring->q_vector = q_vector;
+		ring->pfvfnum = hw->pfvfnum;
+		u64_stats_init(&ring->syncp);
 		mucse->rx_ring[ring->queue_index] = ring;
 		rxr_idx += step;
 		ring++;
@@ -844,7 +1291,7 @@ static void rnpgbe_clean_tx_ring(struct mucse_ring *tx_ring)
  * rnpgbe_clean_all_tx_rings - Free Tx Buffers for all queues
  * @mucse: board private structure
  **/
-static void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
+void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 {
 	struct mucse_hw *hw = &mucse->hw;
 	u32 dma_axi_ctl;
@@ -864,6 +1311,41 @@ static void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
 }
 
+static void rnpgbe_stop_rx_ring(struct mucse_ring *rx_ring)
+{
+	/* Stop hw. hardware design guarantees:
+	 * - No new descriptors will be fetched after RX_START=0
+	 * - No DMA will be initiated for already-fetched descriptors
+	 */
+	mucse_ring_wr32(rx_ring, RNPGBE_RX_START, 0);
+	/* Flush posted write to ensure hardware sees RX_START=0 */
+	(void)mucse_ring_rd32(rx_ring, RNPGBE_RX_START);
+}
+
+/**
+ * rnpgbe_clean_all_rx_rings - Free Rx Buffers for all queues
+ * @mucse: board private structure
+ **/
+static void rnpgbe_clean_all_rx_rings(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_axi_ctl;
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_stop_rx_ring(mucse->rx_ring[i]);
+
+	/* All queues are stopped before their DMA mappings are released. */
+	if (mucse->num_rx_queues)
+		usleep_range(300, 500);
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_clean_rx_ring(mucse->rx_ring[i]);
+
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl &= ~RX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+}
+
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
@@ -873,6 +1355,7 @@ void rnpgbe_down(struct mucse *mucse)
 	rnpgbe_napi_disable_all(mucse);
 	rnpgbe_irq_disable(mucse);
 	rnpgbe_clean_all_tx_rings(mucse);
+	rnpgbe_clean_all_rx_rings(mucse);
 }
 
 /**
@@ -892,6 +1375,8 @@ void rnpgbe_up_complete(struct mucse *mucse)
 	clear_bit(__MUCSE_DOWN, &mucse->state);
 	rnpgbe_irq_enable(mucse);
 	netif_tx_start_all_queues(netdev);
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		mucse_ring_wr32(mucse->rx_ring[i], RNPGBE_RX_START, 1);
 }
 
 /**
@@ -1291,5 +1776,254 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 			stats->tx_bytes += bytes;
 		}
 	}
+
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		struct mucse_ring *ring = READ_ONCE(mucse->rx_ring[i]);
+		u64 bytes, packets, dropped;
+		unsigned int start;
+
+		if (ring) {
+			do {
+				start = u64_stats_fetch_begin(&ring->syncp);
+				packets = ring->stats.packets;
+				bytes = ring->stats.bytes;
+			} while (u64_stats_fetch_retry(&ring->syncp, start));
+			dropped = atomic64_read(&ring->stats.dropped);
+
+			stats->rx_packets += packets;
+			stats->rx_dropped += dropped;
+			stats->rx_bytes += bytes;
+		}
+	}
 	rcu_read_unlock();
 }
+
+static int mucse_alloc_page_pool(struct mucse_ring *rx_ring)
+{
+	int ret = 0;
+
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = rx_ring->count,
+		.nid = dev_to_node(rx_ring->dev),
+		.dev = rx_ring->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = PAGE_SIZE,
+	};
+
+	rx_ring->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(rx_ring->page_pool)) {
+		ret = PTR_ERR(rx_ring->page_pool);
+		rx_ring->page_pool = NULL;
+	}
+
+	return ret;
+}
+
+/**
+ * rnpgbe_setup_rx_resources - allocate Rx resources (Descriptors)
+ * @rx_ring:    rx descriptor ring (for a specific queue) to setup
+ * @mucse: pointer to private structure
+ *
+ * Return: 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
+				     struct mucse *mucse)
+{
+	struct device *dev = rx_ring->dev;
+	int size;
+
+	size = sizeof(struct mucse_rx_buffer) * rx_ring->count;
+
+	rx_ring->rx_buffer_info = vzalloc(size);
+
+	if (!rx_ring->rx_buffer_info)
+		goto err_return;
+	/* Round up to nearest 4K */
+	rx_ring->size = rx_ring->count * sizeof(union rnpgbe_rx_desc);
+	rx_ring->size = ALIGN(rx_ring->size, 4096);
+	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size, &rx_ring->dma,
+					   GFP_KERNEL);
+	if (!rx_ring->desc)
+		goto err_free_buffer;
+
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+
+	if (mucse_alloc_page_pool(rx_ring))
+		goto err_free_desc;
+
+	INIT_DELAYED_WORK(&rx_ring->alloc_retry_work,
+			  rnpgbe_alloc_retry_work);
+
+	return 0;
+err_free_desc:
+	dma_free_coherent(dev, rx_ring->size, rx_ring->desc,
+			  rx_ring->dma);
+	rx_ring->desc = NULL;
+err_free_buffer:
+	vfree(rx_ring->rx_buffer_info);
+err_return:
+	rx_ring->rx_buffer_info = NULL;
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_clean_rx_ring - Free Rx Buffers per Queue
+ * @rx_ring: ring to free buffers from
+ **/
+void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
+{
+	struct mucse_rx_buffer *rx_buffer;
+	u16 i;
+
+	cancel_delayed_work_sync(&rx_ring->alloc_retry_work);
+
+	/* ring already cleared, nothing to do */
+	if (!rx_ring->rx_buffer_info)
+		return;
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < rx_ring->count; i++) {
+		rx_buffer = &rx_ring->rx_buffer_info[i];
+
+		if (rx_buffer->skb) {
+			struct sk_buff *skb = rx_buffer->skb;
+
+			dev_kfree_skb(skb);
+			rx_buffer->skb = NULL;
+		}
+
+		if (rx_buffer->page) {
+			page_pool_put_full_page(rx_ring->page_pool,
+						rx_buffer->page, false);
+			rx_buffer->page = NULL;
+		}
+	}
+
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+}
+
+/**
+ * rnpgbe_free_rx_resources - Free Rx Resources
+ * @rx_ring: ring to clean the resources from
+ *
+ * Free all receive software resources
+ **/
+static void rnpgbe_free_rx_resources(struct mucse_ring *rx_ring)
+{
+	vfree(rx_ring->rx_buffer_info);
+	rx_ring->rx_buffer_info = NULL;
+	/* if not set, then don't free */
+	if (!rx_ring->desc)
+		return;
+
+	dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
+			  rx_ring->dma);
+	rx_ring->desc = NULL;
+	if (rx_ring->page_pool) {
+		page_pool_destroy(rx_ring->page_pool);
+		rx_ring->page_pool = NULL;
+	}
+}
+
+/**
+ * rnpgbe_setup_all_rx_resources - allocate all queues Rx resources
+ * @mucse: pointer to private structure
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int rnpgbe_setup_all_rx_resources(struct mucse *mucse)
+{
+	int i, err = 0;
+
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		err = rnpgbe_setup_rx_resources(mucse->rx_ring[i], mucse);
+		if (!err)
+			continue;
+
+		goto err_setup_rx;
+	}
+
+	return 0;
+err_setup_rx:
+	while (i--)
+		rnpgbe_free_rx_resources(mucse->rx_ring[i]);
+	return err;
+}
+
+/**
+ * rnpgbe_free_all_rx_resources - Free Rx Resources for All Queues
+ * @mucse: pointer to private structure
+ *
+ * Free all receive software resources
+ **/
+void rnpgbe_free_all_rx_resources(struct mucse *mucse)
+{
+	for (int i = 0; i < (mucse->num_rx_queues); i++)
+		rnpgbe_free_rx_resources(mucse->rx_ring[i]);
+}
+
+/**
+ * rnpgbe_configure_rx_ring - Configure Rx ring info to hw
+ * @mucse: pointer to private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Rx descriptor ring after a reset.
+ **/
+static void rnpgbe_configure_rx_ring(struct mucse *mucse,
+				     struct mucse_ring *ring)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	/* Stop hw. hardware design guarantees:
+	 * - No new descriptors will be fetched after RX_START=0
+	 * - No DMA will be initiated for already-fetched descriptors
+	 */
+	mucse_ring_wr32(ring, RNPGBE_RX_START, 0);
+	/* Flush posted write to ensure hardware sees RX_START=0 */
+	(void)mucse_ring_rd32(ring, RNPGBE_RX_START);
+	/* Wait for in-flight DMA to quiesce */
+	usleep_range(300, 500);
+	/* Set the descriptor registers */
+	mucse_ring_wr32(ring, RNPGBE_RX_BASE_ADDR_LO, (u32)ring->dma);
+	mucse_ring_wr32(ring, RNPGBE_RX_BASE_ADDR_HI,
+			(u32)((u64)ring->dma >> 32) | (hw->pfvfnum << 24));
+	mucse_ring_wr32(ring, RNPGBE_RX_LEN, ring->count);
+	ring->tail = ring->ring_addr + RNPGBE_RX_TAIL;
+	ring->next_to_clean = mucse_ring_rd32(ring, RNPGBE_RX_HEAD) %
+			      ring->count;
+	ring->next_to_use = ring->next_to_clean;
+	ring->drop_status = false;
+	mucse_ring_wr32(ring, RNPGBE_RX_SG_LEN, M_DEFAULT_SG);
+	mucse_ring_wr32(ring, RNPGBE_RX_FETCH, M_DEFAULT_RX_FETCH);
+	mucse_ring_wr32(ring, RNPGBE_RX_TIMEOUT_TH, 0);
+	mucse_ring_wr32(ring, RNPGBE_RX_INT_TIMER,
+			M_DEFAULT_INT_TIMER_R * hw->cycles_per_us);
+	mucse_ring_wr32(ring, RNPGBE_RX_INT_PKTCNT, M_DEFAULT_RX_INT_PKTCNT);
+	if (rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring))) {
+		queue_delayed_work(system_wq, &ring->alloc_retry_work,
+				   msecs_to_jiffies(500));
+	}
+}
+
+/**
+ * rnpgbe_configure_rx - Configure Receive Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Rx unit after a reset.
+ **/
+void rnpgbe_configure_rx(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_axi_ctl;
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_configure_rx_ring(mucse, mucse->rx_ring[i]);
+
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl |= RX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 4659d90e24b8..9ee224d9e7eb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -9,12 +9,28 @@ struct mucse_hw;
 struct mucse_ring;
 
 #define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
+#define RNPGBE_RX_START           0x10
 #define RNPGBE_TX_START           0x18
 #define RNPGBE_DMA_INT_MASK       0x24
 #define TX_INT_MASK               BIT(1)
 #define RX_INT_MASK               BIT(0)
 #define INT_VALID                 (BIT(16) | BIT(17))
 #define RNPGBE_DMA_INT_TRIG       0x2c /* lost-interrupt recovery trigger */
+#define RNPGBE_RX_BASE_ADDR_HI    0x30
+#define RNPGBE_RX_BASE_ADDR_LO    0x34
+#define RNPGBE_RX_LEN             0x38
+#define RNPGBE_RX_HEAD            0x3c
+#define RNPGBE_RX_TAIL            0x40
+#define M_DEFAULT_RX_FETCH        0x100020
+#define RNPGBE_RX_FETCH           0x44
+#define M_DEFAULT_INT_TIMER_R     30
+#define RNPGBE_RX_INT_TIMER       0x48
+#define M_DEFAULT_RX_INT_PKTCNT   64
+#define RNPGBE_RX_INT_PKTCNT      0x4c
+#define RNPGBE_RX_ARB_DEF_LVL     0x50
+#define RNPGBE_RX_TIMEOUT_TH      0x54
+#define M_DEFAULT_SG              96 /* unit 16b, 1536 bytes */
+#define RNPGBE_RX_SG_LEN          0x58
 #define RNPGBE_TX_BASE_ADDR_HI    0x60
 #define RNPGBE_TX_BASE_ADDR_LO    0x64
 #define RNPGBE_TX_LEN             0x68
@@ -37,13 +53,15 @@ struct mucse_ring;
 /* 2 desc gap to keep tail from touching head */
 /* 1 desc for context descriptor */
 #define RESV_DESC_NEEDED          3
+#define RNPGBE_SKB_PAD            (NET_SKB_PAD + NET_IP_ALIGN)
+#define M_RX_BUFFER_WRITE         16
+
 /* Hardware requires this to be nonzero */
 #define M_DEFAULT_MAC_IP_LEN      20
 #define mucse_for_each_ring(pos, head)\
 	for (typeof((head).ring) __pos = (head).ring;\
 	     __pos ? ({ pos = __pos; 1; }) : 0;\
 	     __pos = __pos->next)
-
 int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
 void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
 int rnpgbe_request_mbx_irq(struct mucse *mucse);
@@ -54,10 +72,15 @@ void rnpgbe_irq_disable(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
 void rnpgbe_up_complete(struct mucse *mucse);
 void rnpgbe_configure_tx(struct mucse *mucse);
+void rnpgbe_configure_rx(struct mucse *mucse);
+void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
 int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
 void rnpgbe_free_all_tx_resources(struct mucse *mucse);
 netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
 				   struct mucse_ring *tx_ring);
 void rnpgbe_get_stats64(struct net_device *netdev,
 			struct rtnl_link_stats64 *stats);
+void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
+int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
+void rnpgbe_free_all_rx_resources(struct mucse *mucse);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index cd5d0a93013a..3eeea9f51d7e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -35,6 +35,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 static void rnpgbe_configure(struct mucse *mucse)
 {
 	rnpgbe_configure_tx(mucse);
+	rnpgbe_configure_rx(mucse);
 }
 
 /**
@@ -63,11 +64,17 @@ static int rnpgbe_open(struct net_device *netdev)
 	err = rnpgbe_setup_all_tx_resources(mucse);
 	if (err)
 		goto err_free_irqs;
+	err = rnpgbe_setup_all_rx_resources(mucse);
+	if (err)
+		goto err_free_tx;
 
 	rnpgbe_configure(mucse);
 	rnpgbe_up_complete(mucse);
 
 	return 0;
+err_free_tx:
+	rnpgbe_clean_all_tx_rings(mucse);
+	rnpgbe_free_all_tx_resources(mucse);
 err_free_irqs:
 	rnpgbe_free_irq(mucse);
 	return err;
@@ -89,6 +96,7 @@ static int rnpgbe_close(struct net_device *netdev)
 	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
 	rnpgbe_free_all_tx_resources(mucse);
+	rnpgbe_free_all_rx_resources(mucse);
 
 	return 0;
 }
@@ -121,6 +129,7 @@ static const struct net_device_ops rnpgbe_netdev_ops = {
 static void rnpgbe_sw_init(struct mucse *mucse)
 {
 	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->rx_ring_item_count = M_DEFAULT_RXD;
 	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
 }
 
-- 
2.25.1

