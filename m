Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140564189DE;
	Tue, 13 Oct 2026 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858715; cv=none; b=HukKQvkY/JkjpVlxpNu771zP3n8KKF4y16LqhKTFKsa5XuPoFPySR50e0nP3GWJsspfAc3T+BLtklmkGoKyJpMY22v05rv367pLeHNnUtZKwiXJdqWPe+wZLtCiNsm/Vf7G0qz0ZvvKyLdBB02rHUaXnOQy6IBVbUW0ztqO92rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858715; c=relaxed/simple;
	bh=WiyI6OpnOl57RJHv4NDlP6dXXAtxr9AP5KTeX1+uw78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyDAN6EMS7mnL634kHobDDVSFzGvymYWqjeYyrxkWqr1ceBcl5ifalHa8PlMxusnSdJ35KQ6zPuWOSki3T3S/89Gz7q3s/oPb72zuFO6BAIeyIwXkHcycmBahDUDWGWsKwkrO3KQ5me3ux4fIMFr8Aacg1VqodVApvXUDCnF2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1791858652t7db47bcd
X-QQ-Originating-IP: Q4AwAFpJHlgyWXBdo8inWAWK9E7hIG59g08LnDeoejs=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:30:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6210792629314630095
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
Subject: [PATCH net-next v16 3/5] net: rnpgbe: Add basic RX data path support
Date: Tue, 13 Oct 2026 10:30:48 +0800
Message-ID: <FA6FE70B8DB5E7FB+20261013023048.63685-1-dong100@mucse.com>
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
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NIkCQ2fokHudyrehw8OSrIP9cf605ZuoOZlYlGSBcWbnjlTgJf23l83f
	ukQRVLZXCcdb0Do0TfytzIaa+G8X6kmLi4zrqi8QsO594eXRbGER30IihqHHRampzl09TYE
	N9NA3Xw85YhYkiewd27LnrtRmuUDaeqxx6EhraBtFlZqlXppOGjv0zI3OyVrkVAgoSMvKBc
	jxrZ6/Tnf32Lt3z9MIydfNoaXiCtww95HPK8blEyQOQsw8iR0NEFPU4V5D5/YNk/QS3fcMf
	Pz60CNA54rl+dAr6Vcg/m/Axop20J1zdu+NCNUBaTEGPfNzgH5Tr5bsskkCSM4KAzkY6LYk
	aCSvTGlhwlplJ8blk5SeLLslNDwdVVUMk28DyJtfJxLVqyd2/XXWahbh6V4JRBl9c4m/982
	QTFdOSIbl2LYvbjUTYRjYgcG7y2UUkUucRGheGV3AnxGKwLI+euM26Q9HxnHmi9VoW8OtnK
	VUJagttqw8m+2wxjlu6F4gFXQKhMFBBUPAHYNbDNDTDE8k2LagmvDDvdmt5sG7dYw0lBAro
	fY7ybixiePllcPKiBS69lCfnfVyWDyELHIg0jwlAZhXRItJ7z/MMr+ayM77fN2z8ttxyQos
	yi0BwseuSHqMRjFZnVwxEo8r9/z39mnRud0Lxf9YMpj/NN4NALsuKiMLLjdkG1t5eQlN2fH
	Ptu8M4CEq5XU1aOqgckoGl8BFYf3f/43jy79YaUIyn8/0O5apBRTdRfxzIAQyXwYd/M664q
	NFOsSIPKrBDe5FU0JdHDaZsRgl8EfzGw2d4d4iaJmw+8WJpIbPinO7/vZiR/B59NlRsFqaE
	+9MnwYij53Cde4weOQkoNI5gsJ7JoBUosZmE6QbEk6eOMdh2WUWcHrC6mD4z/7an98ffsEh
	9bXkgmfLtrfdpE9I4Qm0lb65xUyoT6H3yuvmPTdljIt+8Z65PkZ6p/e5E1W5UzGNM8DYljj
	LkBNkDXb9P08xH/JnZR5NuTOU8+8n8wBBwDjsxMh70KTiwGEVlwMImPYTE9EoXmbecdIogO
	HRzYN4V606GsAXJ7TKnr4FZkaCPL33jmgf8OBMdM5whZ4CgPUPqVyi9XKsfq1Hx7w0qWbQp
	wBYVDSYJhoDCyvIwRMYA5iEf+D2gsFwSA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Add basic RX DMA data path for the RNPGBE driver.

Introduce the RX descriptor structure (union rnpgbe_rx_desc) with the
hardware write-back format, and manage RX buffers with page_pool using a
single page per descriptor without page splitting. Implement the NAPI
poll callback, RX ring setup and teardown, and packet assembly from page
buffers, along with RX statistics.

Keep a 16-descriptor gap in the fixed 512-entry RX ring so at most 496
descriptors are posted to hardware. Retry failed page allocations with
one timer per q_vector that schedules NAPI and is cancelled before RX
cleanup and q_vector teardown.

An RX DMA quiesce timeout is a terminal AXI fault: keep DMA disabled,
release existing mappings safely, and reject subsequent opens. Recovery
requires a chip-level reset and driver rebind.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/Kconfig            |   1 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  67 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 837 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  23 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  21 +-
 6 files changed, 942 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 17528dba2613..c324118dae2b 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -20,6 +20,7 @@ config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
 	depends on PCI
 	depends on PCI_MSI
+	select PAGE_POOL
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
 	  adapters.
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 5456919ef80b..f839a402ad34 100644
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
@@ -77,17 +103,35 @@ struct mucse_tx_buffer {
 struct mucse_queue_stats {
 	u64 packets;
 	u64 bytes;
+	u64 length_errors;
 	atomic64_t dropped;
 	struct u64_stats_sync syncp;
 } ____cacheline_aligned_in_smp;
 
+struct mucse_rx_buffer {
+	struct sk_buff *skb;
+	dma_addr_t dma;
+	struct page *page;
+	u32 page_offset;
+};
+
+enum mucse_rx_drop_reason {
+	MUCSE_RX_DROP_NONE,
+	MUCSE_RX_DROP_RESOURCE,
+	MUCSE_RX_DROP_LENGTH,
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
@@ -101,9 +145,14 @@ struct mucse_ring {
 	u16 next_to_clean;
 	dma_addr_t dma;
 	unsigned int size;
+	u32 drop_bytes; /* bytes in the current frame being dropped */
 	struct mucse_queue_stats *stats;
+	enum mucse_rx_drop_reason drop_reason;
 } ____cacheline_internodealigned_in_smp;
 
+/* Refill RX descriptors in batches of this size. */
+#define M_RX_BUFFER_WRITE	16
+
 static inline u16 mucse_desc_unused(struct mucse_ring *ring)
 {
 	u16 ntc = ring->next_to_clean;
@@ -112,6 +161,18 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
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
@@ -134,6 +195,7 @@ struct mucse_q_vector {
 	int hw_vector;
 	struct mucse_ring_container rx, tx;
 	struct napi_struct napi;
+	struct timer_list rx_alloc_timer;
 	char name[IFNAMSIZ + 18];
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
@@ -142,6 +204,7 @@ struct mucse_q_vector {
 #define MAX_Q_VECTORS 8
 
 #define M_DEFAULT_TXD     512
+#define M_DEFAULT_RXD     512
 #define M_DEFAULT_TX_WORK 256
 
 enum mucse_state_t {
@@ -157,11 +220,13 @@ struct mucse {
 	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
 	struct mucse_queue_stats tx_stats[RNPGBE_MAX_QUEUES];
+	struct mucse_queue_stats rx_stats[RNPGBE_MAX_QUEUES];
 	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
 	int tx_ring_item_count;
 	int tx_work_limit;
 	int num_tx_queues;
 	int num_q_vectors;
+	int rx_ring_item_count;
 	int num_rx_queues;
 	char mbx_name[32];
 	bool mbx_irq_requested;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index f9ca13b29f69..dc869051c8fa 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -21,6 +21,8 @@
 #define TX_AXI_RW_EN                   0xc
 /* DMA_STATUS_REG[23:20]: tx_wr, tx_rd, rx_wr, rx_rd done status. */
 #define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
+#define RNPGBE_DMA_RX_STATUS           GENMASK_U32(21, 20)
+#define RX_AXI_RW_EN                   0x03
 #define RNPGBE_DMA_AXI_EN              0x0010
 #define RNPGBE_TX_MIN_PKT_LEN          33
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 21cd578f7532..22fe284729f2 100644
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
@@ -174,15 +176,465 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
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
+						 RNPGBE_RX_DESC_DATA_LEN,
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
+ **/
+static void rnpgbe_alloc_rx_buffers(struct mucse_ring *rx_ring,
+				    u16 cleaned_count)
+{
+	u64 fun_id = ((u64)(rx_ring->pfvfnum) << 56);
+	union rnpgbe_rx_desc *rx_desc;
+	u16 i = rx_ring->next_to_use;
+	struct mucse_rx_buffer *bi;
+	u64 addr;
+	/* nothing to do */
+	if (!cleaned_count)
+		return;
+
+	rx_desc = M_RX_DESC(rx_ring, i);
+	bi = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+
+	do {
+		if (!mucse_alloc_mapped_page(rx_ring, bi))
+			break;
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
+ * Advance next_to_clean. For a non-EOP descriptor, carry the skb into the
+ * next descriptor unless the fragment limit has been reached. In that case,
+ * free the skb and mark the remaining descriptors for drop.
+ *
+ * Return: true if the descriptor is not EOP. The skb may have been consumed
+ * when true is returned.
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
+		rx_ring->drop_bytes = skb->len;
+		/* too much frags, force free */
+		dev_kfree_skb_any(skb);
+		rx_ring->drop_reason = MUCSE_RX_DROP_RESOURCE;
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
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		dev_kfree_skb_any(skb);
+		return true;
+	}
+
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
+ * Schedules NAPI after RX buffer allocation fails.
+ **/
+static void rnpgbe_rx_alloc_retry(struct timer_list *timer)
+{
+	struct mucse_q_vector *q_vector =
+		timer_container_of(q_vector, timer, rx_alloc_timer);
+
+	napi_schedule(&q_vector->napi);
+}
+
+static bool rnpgbe_rx_refill_pending(struct mucse_q_vector *q_vector)
+{
+	struct mucse_ring *ring;
+
+	mucse_for_each_ring(ring, q_vector->rx) {
+		if (mucse_desc_unused_rx(ring) >= M_RX_BUFFER_WRITE)
+			return true;
+	}
+
+	return false;
+}
+
+static void rnpgbe_schedule_rx_retry(struct mucse *mucse)
+{
+	struct mucse_q_vector *q_vector;
+
+	for (int i = 0; i < mucse->num_q_vectors; i++) {
+		q_vector = mucse->q_vector[i];
+		if (rnpgbe_rx_refill_pending(q_vector))
+			mod_timer(&q_vector->rx_alloc_timer,
+				  jiffies + msecs_to_jiffies(500));
+	}
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
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
+	unsigned int total_rx_length_errors = 0;
+	unsigned int total_rx_dropped = 0;
+	unsigned int work_done = 0;
+
+	while (likely(work_done < budget)) {
+		struct mucse_rx_buffer *rx_buffer;
+		union rnpgbe_rx_desc *rx_desc;
+		struct sk_buff *skb;
+		unsigned int size;
+
+		if (cleaned_count >= M_RX_BUFFER_WRITE) {
+			rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count);
+			cleaned_count = 0;
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
+		/* Hardware guarantees the first descriptor of each packet is at
+		 * least 33 bytes, including multi-descriptor packets.
+		 * Multi-descriptor packets are only used for jumbo frames over
+		 * 1536 bytes (M_DEFAULT_SG = 96). Each descriptor is at most
+		 * 1536 bytes. Small packets use a single descriptor.
+		 */
+		size = le16_to_cpu(rx_desc->wb.len);
+
+		if (unlikely(!size || size > RNPGBE_RX_DESC_DATA_LEN)) {
+			struct mucse_rx_buffer *err_rx_buffer;
+			u16 idx = rx_ring->next_to_clean;
+
+			cleaned_count++;
+			/* Length errors override resource drops. */
+			rx_ring->drop_reason = MUCSE_RX_DROP_LENGTH;
+			rx_ring->drop_bytes = 0;
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
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)) {
+				total_rx_length_errors++;
+				rx_ring->drop_reason = MUCSE_RX_DROP_NONE;
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
+		if (unlikely(rx_ring->drop_reason != MUCSE_RX_DROP_NONE)) {
+			cleaned_count++;
+			if (rx_ring->drop_reason == MUCSE_RX_DROP_RESOURCE)
+				rx_ring->drop_bytes += size;
+
+			/* Count the packet once at EOP, using its final drop
+			 * reason even across NAPI polls.
+			 */
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)) {
+				if (rx_ring->drop_reason ==
+				    MUCSE_RX_DROP_LENGTH) {
+					total_rx_length_errors++;
+				} else {
+					total_rx_bytes += rx_ring->drop_bytes;
+					total_rx_packets++;
+					total_rx_dropped++;
+				}
+				rx_ring->drop_reason = MUCSE_RX_DROP_NONE;
+				rx_ring->drop_bytes = 0;
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
+			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP)) {
+				total_rx_bytes += size;
+				total_rx_packets++;
+				total_rx_dropped++;
+				work_done++;
+			} else {
+				rx_ring->drop_bytes = size;
+				rx_ring->drop_reason = MUCSE_RX_DROP_RESOURCE;
+			}
+
+			rx_desc->wb.cmd = 0;
+			rx_ring->next_to_clean++;
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
+		size = skb->len;
+		if (rnpgbe_cleanup_headers(skb)) {
+			if (size >= ETH_HLEN) {
+				total_rx_bytes += size;
+				total_rx_packets++;
+			}
+			/* we should clean it since we used all info in it */
+			total_rx_dropped++;
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
+	u64_stats_update_begin(&rx_ring->stats->syncp);
+	rx_ring->stats->packets += total_rx_packets;
+	rx_ring->stats->bytes += total_rx_bytes;
+	rx_ring->stats->length_errors += total_rx_length_errors;
+	atomic64_add(total_rx_dropped, &rx_ring->stats->dropped);
+	u64_stats_update_end(&rx_ring->stats->syncp);
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
@@ -190,6 +642,8 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		container_of(napi, struct mucse_q_vector, napi);
 	bool clean_complete = true;
 	struct mucse_ring *ring;
+	bool refill_pending;
+	int per_ring_budget;
 	int work_done = 0;
 
 	mucse_for_each_ring(ring, q_vector->tx) {
@@ -201,11 +655,31 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
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
+	/* Read RX indices while this poll still owns the NAPI instance. */
+	refill_pending = rnpgbe_rx_refill_pending(q_vector);
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (refill_pending)
+			mod_timer(&q_vector->rx_alloc_timer,
+				  jiffies + msecs_to_jiffies(500));
 		rnpgbe_irq_enable_queues(q_vector);
+	}
 
 	return work_done;
 }
@@ -345,6 +819,7 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
 	/* tie q_vector and mucse together */
 	mucse->q_vector[vector_idx] = q_vector;
 	q_vector->mucse = mucse;
+	timer_setup(&q_vector->rx_alloc_timer, rnpgbe_rx_alloc_retry, 0);
 	q_vector->hw_vector = vector_idx;
 	/* Vector 0 is reserved for the mailbox. */
 	q_vector->hw_vector++;
@@ -370,13 +845,18 @@ static int rnpgbe_alloc_q_vector(struct mucse *mucse,
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
+		ring->stats = &mucse->rx_stats[ring->queue_index];
 		mucse->rx_ring[ring->queue_index] = ring;
 		rxr_idx += step;
 		ring++;
@@ -399,6 +879,8 @@ static void rnpgbe_free_q_vector(struct mucse *mucse, int vector_idx)
 	struct mucse_q_vector *q_vector = mucse->q_vector[vector_idx];
 	struct mucse_ring *ring;
 
+	timer_delete_sync(&q_vector->rx_alloc_timer);
+
 	mucse_for_each_ring(ring, q_vector->tx)
 		mucse->tx_ring[ring->queue_index] = NULL;
 	mucse_for_each_ring(ring, q_vector->rx)
@@ -718,6 +1200,31 @@ static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
 	return err;
 }
 
+static int rnpgbe_wait_rx_dma_idle(struct mucse *mucse)
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
@@ -837,6 +1344,101 @@ void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
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
+ * Return: 0 if RX DMA is quiesced and no AXI fault is latched,
+ * negative errno otherwise
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
+	rx_ring->drop_bytes = 0;
+	rx_ring->drop_reason = MUCSE_RX_DROP_NONE;
+}
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
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
@@ -846,7 +1448,10 @@ void rnpgbe_down(struct mucse *mucse)
 	synchronize_net();
 	rnpgbe_irq_disable(mucse);
 	netif_tx_disable(netdev);
+	rnpgbe_stop_all_rx_rings(mucse);
+	rnpgbe_cancel_rx_retry_timers(mucse);
 	rnpgbe_clean_all_tx_rings(mucse);
+	rnpgbe_clean_all_rx_rings(mucse);
 }
 
 /**
@@ -859,6 +1464,7 @@ void rnpgbe_up_complete(struct mucse *mucse)
 
 	rnpgbe_configure_msix(mucse);
 	rnpgbe_napi_enable_all(mucse);
+	rnpgbe_schedule_rx_retry(mucse);
 	rnpgbe_irq_enable(mucse);
 	netif_tx_start_all_queues(netdev);
 }
@@ -1260,4 +1866,227 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 		stats->tx_dropped += dropped;
 		stats->tx_bytes += bytes;
 	}
+
+	for (i = 0; i < RNPGBE_MAX_QUEUES; i++) {
+		unsigned int start;
+		u64 bytes, packets, dropped, length_errors;
+		struct mucse_queue_stats *queue_stats = &mucse->rx_stats[i];
+
+		do {
+			start = u64_stats_fetch_begin(&queue_stats->syncp);
+			packets = queue_stats->packets;
+			bytes = queue_stats->bytes;
+			length_errors = queue_stats->length_errors;
+		} while (u64_stats_fetch_retry(&queue_stats->syncp, start));
+		dropped = atomic64_read(&queue_stats->dropped);
+
+		stats->rx_packets += packets;
+		stats->rx_dropped += dropped;
+		stats->rx_bytes += bytes;
+		stats->rx_errors += length_errors;
+		stats->rx_length_errors += length_errors;
+	}
+}
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
+		.offset = RNPGBE_SKB_PAD,
+		.max_len = RNPGBE_RX_DESC_DATA_LEN,
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
+ * rnpgbe_free_rx_resources - Free Rx Resources
+ * @rx_ring: ring to clean the resources from
+ *
+ * RX DMA must be quiesced and all ring-held buffers released before this
+ * function is called.
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
+	ring->drop_bytes = 0;
+	ring->drop_reason = MUCSE_RX_DROP_NONE;
+	mucse_ring_wr32(ring, RNPGBE_RX_SG_LEN, M_DEFAULT_SG);
+	mucse_ring_wr32(ring, RNPGBE_RX_FETCH, M_DEFAULT_RX_FETCH);
+	mucse_ring_wr32(ring, RNPGBE_RX_TIMEOUT_TH, 0);
+	mucse_ring_wr32(ring, RNPGBE_RX_INT_TIMER,
+			M_DEFAULT_INT_TIMER_R * hw->cycles_per_us);
+	mucse_ring_wr32(ring, RNPGBE_RX_INT_PKTCNT, M_DEFAULT_RX_INT_PKTCNT);
+	/* Fill the ring before RX DMA is enabled. Batch-sized allocation
+	 * shortfalls are retried after NAPI is enabled; smaller shortfalls are
+	 * replenished once traffic frees a complete refill batch.
+	 */
+	rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
+}
+
+/**
+ * rnpgbe_configure_rx - Configure Receive Unit after Reset
+ * @mucse: pointer to private structure
+ *
+ * Configure the Rx unit after a reset.
+ *
+ * Return: 0 on success, negative errno if RX DMA does not quiesce or
+ * an AXI fault is already latched
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
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 2e0f210f35e7..072993494deb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -13,12 +13,29 @@ struct mucse_hw;
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
+#define RNPGBE_RX_SG_UNIT_BYTES   16
+#define M_DEFAULT_SG              96
+#define RNPGBE_RX_DESC_DATA_LEN   (M_DEFAULT_SG * RNPGBE_RX_SG_UNIT_BYTES)
+#define RNPGBE_RX_SG_LEN          0x58
 #define RNPGBE_TX_BASE_ADDR_HI    0x60
 #define RNPGBE_TX_BASE_ADDR_LO    0x64
 #define RNPGBE_TX_LEN             0x68
@@ -40,13 +57,14 @@ struct mucse_ring;
 #define DESC_NEEDED               (MAX_SKB_FRAGS + 4)
 /* Leave two descriptors between the tail and head. */
 #define RESV_DESC_NEEDED          2
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
@@ -56,6 +74,7 @@ void rnpgbe_free_irq(struct mucse *mucse);
 void rnpgbe_down(struct mucse *mucse);
 void rnpgbe_up_complete(struct mucse *mucse);
 int rnpgbe_configure_tx(struct mucse *mucse);
+int rnpgbe_configure_rx(struct mucse *mucse);
 void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
 int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
 void rnpgbe_free_all_tx_resources(struct mucse *mucse);
@@ -63,4 +82,6 @@ netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
 				   struct mucse_ring *tx_ring);
 void rnpgbe_get_stats64(struct net_device *netdev,
 			struct rtnl_link_stats64 *stats);
+int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
+void rnpgbe_free_all_rx_resources(struct mucse *mucse);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 265a3fcb07be..21fa78c59e5b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -31,13 +31,19 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  * rnpgbe_configure - Configure the hardware
  * @mucse: pointer to private structure
  *
- * Configure Tx registers in hardware.
+ * Configure Tx and Rx registers in hardware.
  *
  * Return: 0 on success, negative errno if hardware configuration fails
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
@@ -100,6 +111,7 @@ static int rnpgbe_close(struct net_device *netdev)
 	rnpgbe_down(mucse);
 	rnpgbe_free_irq(mucse);
 	rnpgbe_free_all_tx_resources(mucse);
+	rnpgbe_free_all_rx_resources(mucse);
 
 	return 0;
 }
@@ -139,11 +151,14 @@ static void rnpgbe_sw_init(struct mucse *mucse)
 	int i;
 
 	mucse->tx_ring_item_count = M_DEFAULT_TXD;
+	mucse->rx_ring_item_count = M_DEFAULT_RXD;
 	mucse->tx_work_limit = M_DEFAULT_TX_WORK;
 
 	for (i = 0; i < RNPGBE_MAX_QUEUES; i++) {
 		u64_stats_init(&mucse->tx_stats[i].syncp);
 		atomic64_set(&mucse->tx_stats[i].dropped, 0);
+		u64_stats_init(&mucse->rx_stats[i].syncp);
+		atomic64_set(&mucse->rx_stats[i].dropped, 0);
 	}
 }
 
-- 
2.50.1

