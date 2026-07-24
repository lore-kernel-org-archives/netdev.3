Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06A175A9C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784858475; cv=none; b=gI9Xq2D0mHaKDRJoeETi2kXRe2zvCLdtmj6i0Vwj5A0t1AqlXD/x2QzRXEp5d+H+Y7r4aY/Ld/IE0bcyxLdPqaYREVKhgbReCXT6mFDje8j9XG1QRqJC0B68BkP2fxT4m1nu6wO0ypgBOn32IlMpt3zDovwGxNVTuV9YaabSyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784858475; c=relaxed/simple;
	bh=eKaZb7GLHga1LZx8vFfL/GoJc+4KgUHsiTsmomSybRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNhRTixV3Xgyg6vxGqz8aFXfwLDAhq5vEcYpe3X/VAKgiqmQM/ikw6MX/JqqXsic3YS1bXbZbHPm8oMnuznBRyHE510//V7lDj3JqZ3wwnnOhJ3BCMyyXXRGyk5czVbmwp3bYdZrZN/Av33k8VFRJpV4SEcRyhR+D58RrAAp0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f5upw3LO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5upw3LO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784858471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0tDT/g3TXA0rbEsI/emPSUZnFB1zh/HlrYCD9mqHpMw=;
	b=f5upw3LO8ML5wa2x2HRNemNGGyG4Bg5ue5euIkmyd/4HzMT3MNagip8bbPK72YrshTSqeO
	jZV/+zI7Zpc3OHZA0YPayLpfgt1DlLsUfW6leHV8zWs/60Cd0TkWcEOQa4R/jUFQJL6fGa
	oUIiOOZsvB3FwSlgPIGqwOM7e8d+bng=
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
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next] i40e: xsk: use xdp_build_skb_from_zc() for XDP_PASS
Date: Fri, 24 Jul 2026 10:01:25 +0800
Message-Id: <20260724020125.246333-1-chenguang.zhao@linux.dev>
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
the caller. Push the Ethernet header back before eth_skb_pad()/
i40e_process_skb_fields() because xdp_build_skb_from_zc() already
called eth_type_trans().

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
The earlier patch was discussed on the net tree.
    v2:
    https://lore.kernel.org/all/20260717012416.168107-1-chenguang.zhao@linux.dev/
    v1:
    https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/
Because older kernels do not have xdp_build_skb_from_zc(), only the bugfix goes
to net; the refactor lands on net-next.

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 74 +++-------------------
 1 file changed, 9 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..13932b36142d 100644
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
@@ -372,14 +309,21 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
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
 
+		/*
+		 * xdp_build_skb_from_zc() already ran eth_type_trans();
+		 * restore the header for eth_skb_pad()/process_skb_fields().
+		 */
+		__skb_push(skb, skb->data - skb_mac_header(skb));
+
 		if (eth_skb_pad(skb)) {
 			*rx_packets = 0;
 			*rx_bytes = 0;
-- 
2.25.1

