Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5E3C10A9;
	Mon, 31 Aug 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161849; cv=none; b=TNJl9DA0G32pBZESD1fBukRxXAz2Ydug4IfidbIcahpwrGAeS3oInoDzY/Kvh926EenjE3F3cgeqc8hD4aRWCtIzanQE0Q9KcJyVz5C+6tTFYupCTXPo4iibkIftFWhCWzjp7eQOz9hrpk7X154U3j+6R3vxApKF7GpVJIfzE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161849; c=relaxed/simple;
	bh=HLRV+G3PFgB8WvnHkFNcxvaNWStCcoFosqtgqvBNoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM0fjunGxmGxV4AFkxaPXXkwi1hNn1NZf3V5QxiLDLgS+9IxUnBcgE79T9piQnWrOBR9qhVCnB5xymCWeq6I4Gc4uqhJRYWp3ae98WpeNt/Dg0Dbm671Tv9fEnkjnL0dv8Q1/goCY23gKVXFadSHC0tTlmNfsI36XyZ2SvrMIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1788161784t0f7d0174
X-QQ-Originating-IP: XJN1fgms0polAdVB2QlSYi5cZWu1iyoA6HomXx0OT2s=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:36:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15819518121606917429
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
Subject: [PATCH net-next v10 3/5] net: rnpgbe: Add RX packet reception support
Date: Mon, 31 Aug 2026 15:36:06 +0800
Message-ID: <91082393C60E8281+20260831073608.401988-4-dong100@mucse.com>
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
X-QQ-XMAILINFO: MIAHdi1iQo+zAKr12rhV/tSv2qJAbAYsgJm+uyJ9PAR849CZsSVYn07L
	+xjkru+ZEAsQnb26gAxqQYV3OsLXj4iSnPUelHEv60s5XioqU0cyZl/3DmSndfH0S2UezSX
	/hFM8q9iKFM2aJd7s8/y7bvEq6+08NydRMz4OXGlUHw7iYuwpklLqIx/PleqBHxK9XTxKsx
	yAdyG+26n+xF220ukHUmWWMhciLqIPsUoYUOMyoPkut1CEo9Ggh9ofSOgS1UPsxT6jelXaT
	4fpkOIrXNOLY1xvn84DDSbBq35F5pYmfuXQIPn9T08FsNZWm6fyNTd5FuvR7wRuAyMAjgcX
	nGaOdY3BaOwlrq/yeL5FJet83D9l8MqwDQoj9FLy2Xr7uRueCGplVyIbDt79Im4ZMQorRFS
	HTlu2++dQl0JJS+6JWlG4ecYaV6aB0Obool1q5QgvVHJ0JHEvKXfuNTgvbrz9TnWQT1Uo48
	w6uYqKrI59etok5L4prth56wwnuzOILV2SqHr993w+eT7yK2N6ehkLMJw6tYiMwLSf/4gIA
	u2U+1Ek4BYHSt4PSe6OaY9OT5wrR/NFNfrIa4tzaK8DOzXsM6qHUhnqRSFjNTyD0nWfR10B
	Edlyz38oJV+t7bZ/Tp9pzeF2/VOYekPNLJOqiIuQ999WyX7EPoll4P/keqQxwl7fG3KgE9U
	A/6HgvSMzVQ4oCgrelYY3K8EPg9qzUza9fFNmPoQAOKaUOK8AVJftGevxWWxvJw6XbGotXo
	l/onxlnlErc2bo1LeQhqJVoHww8oY+7vWbUlLPnRdnEuYiBq9Ur5VurOHtZYcWqEHMN/bM2
	d/K4REqnHoxKvLUPK+L2AcyXX1/y43CDY45nrIBBaADHffSMp0WfAEW9O7revbReOeozLFP
	JSlbs3j/1N85yQJm7hGuy1CjBIUPoJ372O4XkpNF12DiznLTQ4EEXB3VQS8YS9+BUICHHiW
	idZd50DqmVsKKak42uQps1njUxYXoQ7dKpLcYjS0vJz5mTo2fcu9BkNaqAk5M60WzfOkST9
	7OhymUV2Q5u3YOnVr6iv3G29xvDiWKeyd+nK6e5jiEF3h+lrTe8ZBgLzNLVrI=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Add basic RX packet reception for the RNPGBE driver.

Introduce the RX descriptor structure (union rnpgbe_rx_desc) with the
hardware write-back format, and manage RX buffers with page_pool using a
single page per descriptor without page splitting. Implement the NAPI
poll callback, RX ring setup and teardown, and packet assembly from page
buffers, along with RX statistics.

Keep a 16-descriptor gap in the fixed 512-entry RX ring so at most 496
descriptors are posted to hardware. Retry failed page allocations with
one timer per q_vector that schedules NAPI and is cancelled before RX
cleanup and q_vector teardown.

Disable NAPI before disabling interrupts and quiesce RX DMA once for all
rings before cancelling the refill timers and releasing RX resources. A
quiesce timeout is a terminal AXI fault: keep DMA disabled, release the
existing mappings safely, and reject subsequent opens until the device is
reset and reprobed. Do not re-enable queue interrupts while the device is
down.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/Kconfig            |   1 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  58 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 780 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  21 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  17 +-
 6 files changed, 870 insertions(+), 9 deletions(-)

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
index 6d0b9f424c64..8c3d8bbfcc1a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/timer.h>
 #include <linux/if.h>
 #include <linux/workqueue.h>
 
@@ -62,7 +63,32 @@ struct rnpgbe_tx_desc {
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
@@ -80,13 +106,24 @@ struct mucse_queue_stats {
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
@@ -102,8 +139,12 @@ struct mucse_ring {
 	unsigned int size;
 	struct mucse_queue_stats stats;
 	struct u64_stats_sync syncp;
+	bool drop_status;
 } ____cacheline_internodealigned_in_smp;
 
+/* Refill RX descriptors in batches of this size. */
+#define M_RX_BUFFER_WRITE	16
+
 static inline u16 mucse_desc_unused(struct mucse_ring *ring)
 {
 	u16 ntc = ring->next_to_clean;
@@ -112,6 +153,18 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+static inline u16 mucse_desc_unused_rx(struct mucse_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	/* Keep M_RX_BUFFER_WRITE descriptors unused so the ring is not filled
+	 * completely. Refill is attempted once at least this many descriptors
+	 * are available.
+	 */
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - M_RX_BUFFER_WRITE;
+}
+
 static inline __le64 build_ctob(u32 vlan_cmd, u32 mac_ip_len, u32 size)
 {
 	return cpu_to_le64(((u64)vlan_cmd << 32) | ((u64)mac_ip_len << 16) |
@@ -134,6 +187,7 @@ struct mucse_q_vector {
 	int hw_vector;
 	struct mucse_ring_container rx, tx;
 	struct napi_struct napi;
+	struct timer_list rx_alloc_timer;
 	char name[IFNAMSIZ + 18];
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
@@ -142,6 +196,7 @@ struct mucse_q_vector {
 #define MAX_Q_VECTORS 8
 
 #define M_DEFAULT_TXD     512
+#define M_DEFAULT_RXD     512
 #define M_DEFAULT_TX_WORK 256
 
 enum mucse_state_t {
@@ -165,6 +220,7 @@ struct mucse {
 	int tx_work_limit;
 	int num_tx_queues;
 	int num_q_vectors;
+	int rx_ring_item_count;
 	int num_rx_queues;
 	char mbx_name[32];
 	unsigned long state;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 6dc29ebe6fa7..1d87edfba3d7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -19,6 +19,8 @@
 #define TX_AXI_RW_EN                   0xc
 /* DMA_STATUS_REG[23:20]: tx_wr, tx_rd, rx_wr, rx_rd done status. */
 #define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
+#define RNPGBE_DMA_RX_STATUS           GENMASK_U32(21, 20)
+#define RX_AXI_RW_EN                   0x03
 #define RNPGBE_DMA_AXI_EN              0x0010
 #define RNPGBE_TX_MIN_PKT_LEN          33
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index ff81d222edd3..346e9a1cca8a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -4,8 +4,10 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/iopoll.h>
+#include <linux/etherdevice.h>
 #include <linux/vmalloc.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 
 #include "rnpgbe_lib.h"
 #include "rnpgbe.h"
@@ -198,15 +200,419 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
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
+	/* Publish the tail even when allocation stopped early, so a stale
+	 * tail from a previous session cannot point hardware at a
+	 * reallocated ring.
+	 */
+	dma_wmb();
+	mucse_update_rx_tail(rx_ring, i);
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
+	skb = napi_build_skb(va - RNPGBE_SKB_PAD, truesize);
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
+ * rnpgbe_process_skb_fields - Set the RX queue and protocol fields
+ * @rx_ring: RX descriptor ring containing the queue information
+ * @skb: skb currently being received
+ *
+ * Records the RX queue that received the skb and sets its protocol from
+ * the Ethernet header.
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
+ * rnpgbe_rx_alloc_retry - Retry RX buffer allocation
+ * @timer: RX allocation retry timer
+ *
+ * Schedules NAPI after RX buffer allocation fails during polling or
+ * initial ring configuration.
+ **/
+static void rnpgbe_rx_alloc_retry(struct timer_list *timer)
+{
+	struct mucse_q_vector *q_vector =
+		timer_container_of(q_vector, timer, rx_alloc_timer);
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
+	unsigned int work_done = 0;
+
+	while (likely(work_done < budget)) {
+		struct mucse_rx_buffer *rx_buffer;
+		union rnpgbe_rx_desc *rx_desc;
+		struct sk_buff *skb;
+		unsigned int size;
+
+		if (cleaned_count >= M_RX_BUFFER_WRITE) {
+			if (rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count)) {
+				mod_timer(&q_vector->rx_alloc_timer,
+					  jiffies + msecs_to_jiffies(500));
+				cleaned_count = mucse_desc_unused_rx(rx_ring);
+			} else {
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
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)) {
+				rx_ring->drop_status = false;
+				work_done++;
+			}
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
+			/* Free the partial skb from a previous non-EOP
+			 * descriptor before advancing next_to_clean.
+			 */
+			err_rx_buffer = &rx_ring->rx_buffer_info[idx];
+			if (unlikely(err_rx_buffer->skb)) {
+				dev_kfree_skb_any(err_rx_buffer->skb);
+				err_rx_buffer->skb = NULL;
+			}
+
+			/* drop data until eop */
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP))
+				work_done++;
+			else
+				rx_ring->drop_status = true;
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
+			if (rx_ring->next_to_clean >= rx_ring->count)
+				rx_ring->next_to_clean = 0;
+			continue;
+		}
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
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP))
+				work_done++;
+			else
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
+			work_done++;
+			continue;
+		}
+
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		rnpgbe_process_skb_fields(rx_ring, skb);
+		rx_desc->wb.cmd = 0;
+		napi_gro_receive(&q_vector->napi, skb);
+		/* Update packet statistics and NAPI work accounting. */
+		total_rx_packets++;
+		work_done++;
+	}
+
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.packets += total_rx_packets;
+	rx_ring->stats.bytes += total_rx_bytes;
+	u64_stats_update_end(&rx_ring->syncp);
+
+	return work_done;
+}
+
 /**
  * rnpgbe_poll - NAPI polling callback
  * @napi: structure for representing this polling device
  * @budget: polling budget
  *
- * Clean completed TX packets and complete NAPI polling when all queues are
- * clean.
+ * Clean completed TX and RX packets and complete NAPI polling when all
+ * queues are clean.
  *
- * Return: 0 if all TX queues are clean, otherwise @budget
+ * Return: number of RX packets processed, or @budget if polling continues
  **/
 static int rnpgbe_poll(struct napi_struct *napi, int budget)
 {
@@ -214,6 +620,7 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		container_of(napi, struct mucse_q_vector, napi);
 	bool clean_complete = true;
 	struct mucse_ring *ring;
+	int per_ring_budget;
 	int work_done = 0;
 
 	mucse_for_each_ring(ring, q_vector->tx) {
@@ -225,11 +632,27 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
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
 
-	if (likely(napi_complete_done(napi, work_done)))
-		rnpgbe_irq_enable_queues(q_vector);
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (!test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
+			rnpgbe_irq_enable_queues(q_vector);
+	}
 
 	return work_done;
 }
@@ -388,6 +811,7 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
 	/* tie q_vector and mucse together */
 	mucse->q_vector[vector_idx] = q_vector;
 	q_vector->mucse = mucse;
+	timer_setup(&q_vector->rx_alloc_timer, rnpgbe_rx_alloc_retry, 0);
 	q_vector->hw_vector = vector_idx;
 	/* if mbx use separate irq, we should add 1 */
 	if (mucse->flags & M_FLAG_MSIX_EN)
@@ -414,13 +838,18 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
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
@@ -443,6 +872,8 @@ static void rnpgbe_free_q_vector(struct mucse *mucse, int vector_idx)
 	struct mucse_q_vector *q_vector = mucse->q_vector[vector_idx];
 	struct mucse_ring *ring;
 
+	timer_delete_sync(&q_vector->rx_alloc_timer);
+
 	mucse_for_each_ring(ring, q_vector->tx)
 		mucse->tx_ring[ring->queue_index] = NULL;
 	mucse_for_each_ring(ring, q_vector->rx)
@@ -797,6 +1228,30 @@ static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
 	return err;
 }
 
+static int rnpgbe_wait_rx_dma_idle(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_status;
+	int err;
+
+	/* A timeout indicates a terminal AXI fault. Hardware stops DMA
+	 * accesses, so teardown may release mappings, but configuration
+	 * must not re-enable RX DMA.
+	 */
+	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
+				 dma_status,
+				 (dma_status & RNPGBE_DMA_RX_STATUS) ==
+				 RNPGBE_DMA_RX_STATUS,
+				 10, 100000);
+	if (err) {
+		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
+		dev_err(&mucse->pdev->dev,
+			"RX DMA failed to quiesce, status %#x\n", dma_status);
+	}
+
+	return err;
+}
+
 /**
  * rnpgbe_stop_all_tx_rings - Stop TX DMA on all queues
  * @mucse: board private structure
@@ -912,6 +1367,66 @@ void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
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
+ * rnpgbe_stop_all_rx_rings - Stop RX DMA for all queues
+ * @mucse: board private structure
+ *
+ * Return: 0 when RX DMA was quiesced, negative errno otherwise
+ **/
+static int rnpgbe_stop_all_rx_rings(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_axi_ctl;
+	int err = 0;
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_stop_rx_ring(mucse->rx_ring[i]);
+
+	if (mucse->num_rx_queues &&
+	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
+		err = rnpgbe_wait_rx_dma_idle(mucse);
+
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl &= ~RX_AXI_RW_EN;
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
+static void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
+
+/**
+ * rnpgbe_clean_all_rx_rings - Free Rx buffers for all queues
+ * @mucse: board private structure
+ **/
+static void rnpgbe_clean_all_rx_rings(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_clean_rx_ring(mucse->rx_ring[i]);
+}
+
+static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
+{
+	for (int i = 0; i < mucse->num_q_vectors; i++)
+		timer_delete_sync(&mucse->q_vector[i]->rx_alloc_timer);
+}
+
 bool rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
@@ -922,7 +1437,10 @@ bool rnpgbe_down(struct mucse *mucse)
 	netif_tx_disable(netdev);
 	rnpgbe_napi_disable_all(mucse);
 	rnpgbe_irq_disable(mucse);
+	rnpgbe_stop_all_rx_rings(mucse);
+	rnpgbe_cancel_rx_retry_timers(mucse);
 	rnpgbe_clean_all_tx_rings(mucse);
+	rnpgbe_clean_all_rx_rings(mucse);
 
 	return true;
 }
@@ -1348,5 +1866,257 @@ void rnpgbe_get_stats64(struct net_device *netdev,
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
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = rx_ring->count,
+		.nid = dev_to_node(rx_ring->dev),
+		.dev = rx_ring->dev,
+		.napi = &rx_ring->q_vector->napi,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = PAGE_SIZE,
+		.netdev = rx_ring->netdev,
+		.queue_idx = rx_ring->queue_index,
+	};
+	int ret = 0;
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
+ *
+ * Return: 0 on success, negative on failure
+ **/
+static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring)
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
+static void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
+{
+	struct mucse_rx_buffer *rx_buffer;
+	u16 i;
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
+		err = rnpgbe_setup_rx_resources(mucse->rx_ring[i]);
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
+	for (int i = 0; i < mucse->num_rx_queues; i++)
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
+	/* Set the descriptor registers after RX DMA has quiesced. */
+	mucse_ring_wr32(ring, RNPGBE_RX_BASE_ADDR_LO, (u32)ring->dma);
+	mucse_ring_wr32(ring, RNPGBE_RX_BASE_ADDR_HI,
+			(u32)((u64)ring->dma >> 32) |
+			((u32)hw->pfvfnum << 24));
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
+		mod_timer(&ring->q_vector->rx_alloc_timer,
+			  jiffies + msecs_to_jiffies(500));
+	}
+}
+
+/**
+ * rnpgbe_configure_rx - Configure Receive Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Rx unit after a reset.
+ *
+ * Return: 0 on success, negative errno if RX DMA did not quiesce
+ **/
+int rnpgbe_configure_rx(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	u32 dma_axi_ctl;
+	int err;
+
+	err = rnpgbe_stop_all_rx_rings(mucse);
+	if (err)
+		return err;
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		rnpgbe_configure_rx_ring(mucse, mucse->rx_ring[i]);
+
+	/* Ensure all ring configuration is visible before enabling RX DMA. */
+	wmb();
+	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+	dma_axi_ctl |= RX_AXI_RW_EN;
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
+	/* Ensure RX_AXI_RW_EN is visible before starting the rings. */
+	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
+
+	for (int i = 0; i < mucse->num_rx_queues; i++)
+		mucse_ring_wr32(mucse->rx_ring[i], RNPGBE_RX_START, 1);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 01e800f5f6a4..234b3bff94c4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -9,12 +9,27 @@ struct mucse_hw;
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
+#define RNPGBE_RX_TIMEOUT_TH      0x54
+#define M_DEFAULT_SG              96 /* unit 16b, 1536 bytes */
+#define RNPGBE_RX_SG_LEN          0x58
 #define RNPGBE_TX_BASE_ADDR_HI    0x60
 #define RNPGBE_TX_BASE_ADDR_LO    0x64
 #define RNPGBE_TX_LEN             0x68
@@ -37,13 +52,14 @@ struct mucse_ring;
 /* 2 desc gap to keep tail from touching head */
 /* 1 desc for context descriptor */
 #define RESV_DESC_NEEDED          3
+#define RNPGBE_SKB_PAD            (NET_SKB_PAD + NET_IP_ALIGN)
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
@@ -54,6 +70,7 @@ void rnpgbe_irq_disable(struct mucse *mucse);
 bool rnpgbe_down(struct mucse *mucse);
 void rnpgbe_up_complete(struct mucse *mucse);
 int rnpgbe_configure_tx(struct mucse *mucse);
+int rnpgbe_configure_rx(struct mucse *mucse);
 void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
 int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
 void rnpgbe_free_all_tx_resources(struct mucse *mucse);
@@ -61,4 +78,6 @@ netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
 				   struct mucse_ring *tx_ring);
 void rnpgbe_get_stats64(struct net_device *netdev,
 			struct rtnl_link_stats64 *stats);
+int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
+void rnpgbe_free_all_rx_resources(struct mucse *mucse);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 5be78afd0b25..e62366291b2a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -37,7 +37,13 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_configure(struct mucse *mucse)
 {
-	return rnpgbe_configure_tx(mucse);
+	int err;
+
+	err = rnpgbe_configure_tx(mucse);
+	if (err)
+		return err;
+
+	return rnpgbe_configure_rx(mucse);
 }
 
 /**
@@ -69,13 +75,18 @@ static int rnpgbe_open(struct net_device *netdev)
 	err = rnpgbe_setup_all_tx_resources(mucse);
 	if (err)
 		goto err_free_irqs;
+	err = rnpgbe_setup_all_rx_resources(mucse);
+	if (err)
+		goto err_free_tx;
 
 	err = rnpgbe_configure(mucse);
 	if (err)
-		goto err_free_tx;
+		goto err_free_rx;
 	rnpgbe_up_complete(mucse);
 
 	return 0;
+err_free_rx:
+	rnpgbe_free_all_rx_resources(mucse);
 err_free_tx:
 	rnpgbe_clean_all_tx_rings(mucse);
 	rnpgbe_free_all_tx_resources(mucse);
@@ -102,6 +113,7 @@ static int rnpgbe_close(struct net_device *netdev)
 
 	rnpgbe_free_irq(mucse);
 	rnpgbe_free_all_tx_resources(mucse);
+	rnpgbe_free_all_rx_resources(mucse);
 
 	return 0;
 }
@@ -139,6 +151,7 @@ static const struct net_device_ops rnpgbe_netdev_ops = {
 static void rnpgbe_sw_init(struct mucse *mucse)
 {
 	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->rx_ring_item_count = M_DEFAULT_RXD;
 	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
 }
 
-- 
2.50.1

