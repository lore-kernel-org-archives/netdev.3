Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C167260D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785463729; cv=none; b=uapCYfRLbFBUVQAR0fANXc+k0K8VjzY8Wy1UqqhYTOHNDNaI5kVUjLZ2uAQ0g6UgQ4YLyf4Z+MhW0I2j2OsdwFkXtl3CjZqwJk1ErvB71kCwQwgKqsCgt8KjxlTEErcKDI8OF2Vae0SKKIn9CRMIW/tk9Sf743lgIlU7SXhq1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785463729; c=relaxed/simple;
	bh=iSnStwqiSG8L0PwY3a+SZlbqFnjluktWv3zEmKHenHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OpPSdHXC/M5PvCpims/UM8rNdTyOCVJXWkPmxkrf03cIKSDEzMzMx3xIjybW6e1AeP6nAtjdfh4zUsKFFtIhBeZV8tsaT1B0Mb3G7p0d5yp8TvrEhHc1MH2bZWB9VwTrHGGw0hUNMDTi2ff4mIo4sUC4yZ+PkBmOBhReJyekyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=siIH7f4S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="siIH7f4S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785463725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hPnWLjsMEg0dSZw07EDvuDAjkz15ZqLKki4UKr/EC3k=;
	b=siIH7f4SWicOmKaSNHGclLiA8iQHGZfKz3uOlTpudHjavFjR4lAHafyS+h7x8xNvzDXf0d
	RP26QWdRQ7nFwz0qqtUZGeqZoNAy8It2b60eq5VKpHx9NL6dj1umcYxOjkVXDWlqD3ziKW
	2QJ6aCmsa2dVfKu3kk1Rll5optcDpZY=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	kerneljasonxing@gmail.com,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net-next v3] i40e: xsk: use xdp_build_skb_from_zc() for XDP_PASS
Date: Fri, 31 Jul 2026 10:07:36 +0800
Message-Id: <20260731020736.170485-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Replace the driver-local i40e_construct_skb_zc() with the common
helper xdp_build_skb_from_zc(). On failure, free the xdp buff in
the caller.

xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
eth_type_trans(), so pull the remaining descriptor field setup into
__i40e_process_skb_fields() and use that on the XDP_PASS path.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v3:
 As suggested by Larysa:
 - Drop eth_skb_pad() on the XDP_PASS path, along with the
   temporary __skb_push()/__skb_pull() around it. The stack
   handles short skbs and other vendors do not pad on Rx.

v2:
 - https://lore.kernel.org/all/20260729054916.720750-1-chenguang.zhao@linux.dev/

v1:
 - https://lore.kernel.org/all/20260724020125.246333-1-chenguang.zhao@linux.dev/
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++-----------------
 3 files changed, 33 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ef5e657816f0..87553b14d34a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1833,17 +1833,17 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
 }
 
 /**
- * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
+ * __i40e_process_skb_fields - Populate skb fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
  * @rx_desc: pointer to the EOP Rx descriptor
  * @skb: pointer to current skb being populated
  *
- * This function checks the ring, descriptor, and packet information in
- * order to populate the hash, checksum, VLAN, protocol, and
- * other fields within the skb.
+ * Populate hash, checksum, PTP timestamp and VLAN from @rx_desc. Does not
+ * call skb_record_rx_queue() or eth_type_trans(); callers that already got
+ * those from xdp_build_skb_from_zc() should use this helper.
  **/
-void i40e_process_skb_fields(struct i40e_ring *rx_ring,
-			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
+void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
+			       union i40e_rx_desc *rx_desc, struct sk_buff *skb)
 {
 	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 	u32 rx_status = FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
@@ -1858,14 +1858,30 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 
 	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
 
-	skb_record_rx_queue(skb, rx_ring->queue_index);
-
 	if (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
 		__le16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
 
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
 				       le16_to_cpu(vlan_tag));
 	}
+}
+
+/**
+ * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
+ * @rx_ring: rx descriptor ring packet is being transacted on
+ * @rx_desc: pointer to the EOP Rx descriptor
+ * @skb: pointer to current skb being populated
+ *
+ * This function checks the ring, descriptor, and packet information in
+ * order to populate the hash, checksum, VLAN, protocol, and
+ * other fields within the skb.
+ **/
+void i40e_process_skb_fields(struct i40e_ring *rx_ring,
+			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
+{
+	__i40e_process_skb_fields(rx_ring, rx_desc, skb);
+
+	skb_record_rx_queue(skb, rx_ring->queue_index);
 
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index e26807fd2123..3c52e0e60487 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -9,6 +9,8 @@
 int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
 void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
 				   u64 qword1);
+void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
+			       union i40e_rx_desc *rx_desc, struct sk_buff *skb);
 void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 			     union i40e_rx_desc *rx_desc, struct sk_buff *skb);
 void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..dfa519c30a0d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf_trace.h>
 #include <linux/unroll.h>
+#include <net/xdp.h>
 #include <net/xdp_sock_drv.h>
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
@@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	return count == nb_buffs;
 }
 
-/**
- * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
- * @rx_ring: Rx ring
- * @xdp: xdp_buff
- *
- * This functions allocates a new skb from a zero-copy Rx buffer.
- *
- * Returns the skb, or NULL on failure.
- **/
-static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
-					     struct xdp_buff *xdp)
-{
-	unsigned int totalsize = xdp->data_end - xdp->data_meta;
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	struct skb_shared_info *sinfo = NULL;
-	struct sk_buff *skb;
-	u32 nr_frags = 0;
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-	net_prefetch(xdp->data_meta);
-
-	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
-	if (unlikely(!skb))
-		goto out;
-
-	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
-	       ALIGN(totalsize, sizeof(long)));
-
-	if (metasize) {
-		skb_metadata_set(skb, metasize);
-		__skb_pull(skb, metasize);
-	}
-
-	if (likely(!xdp_buff_has_frags(xdp)))
-		goto out;
-
-	for (int i = 0; i < nr_frags; i++) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
-		skb_frag_t *frag = &sinfo->frags[i];
-		struct page *page;
-		void *addr;
-
-		page = dev_alloc_page();
-		if (!page) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-		addr = page_to_virt(page);
-
-		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
-
-		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
-					   addr, 0, skb_frag_size(frag));
-	}
-
-out:
-	xsk_buff_free(xdp);
-	return skb;
-}
-
 static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 				      struct xdp_buff *xdp_buff,
 				      union i40e_rx_desc *rx_desc,
@@ -372,21 +309,19 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
 		 * SBP is *not* set in PRT_SBPVSI (default not set).
 		 */
-		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
+		skb = xdp_build_skb_from_zc(xdp_buff);
 		if (!skb) {
+			xsk_buff_free(xdp_buff);
 			rx_ring->rx_stats.alloc_buff_failed++;
 			*rx_packets = 0;
 			*rx_bytes = 0;
 			return;
 		}
 
-		if (eth_skb_pad(skb)) {
-			*rx_packets = 0;
-			*rx_bytes = 0;
-			return;
-		}
-
-		i40e_process_skb_fields(rx_ring, rx_desc, skb);
+		/* xdp_build_skb_from_zc() already ran eth_type_trans() and
+		 * skb_record_rx_queue().
+		 */
+		__i40e_process_skb_fields(rx_ring, rx_desc, skb);
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 		return;
 	}
-- 
2.25.1

