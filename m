Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826A4E020E;
	Fri,  2 Oct 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953417; cv=none; b=ScJie+Md9EN6ljJFyOnHL46HYdb3ZV1VP/YZlug3eJVZR8dO5zCpH2Cj/DPC045r4j9BFJU/PLxkdRq3imlU5VXYL1y14X/QhZDaol2kKPX06s4/GJ1Xn5ybZaXb3nS6CjYxtlvqqD6GPUeUTSCgtXdoS5uBBh3aPKvRI/HfinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953417; c=relaxed/simple;
	bh=wnA0M22/GX0WizOZo9w/ezgfQQrpBDCaxhsabrfnoVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFdnmtc3yPOUPDh8hw3bCx77tVADrNdZVe3IE/Xq34xiHCnRLPU/vCBEnk4rCs1MCMqnqo14QsQBKnRz7vlR1QgQkUkeV5Dga21uq7RwFSuRYuhiWI3tlO2gqG54GYlpo4q8DbNZvZLwcWif2q/2BZJn6EJBu2pdLNTT0V1zljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=TEb9t7Sj; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="TEb9t7Sj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CA3EA4ACC;
	Fri,  2 Oct 2026 17:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OA1zuQMX8MOAkmDkySKV7HyXCjTrRDe3qUtWftBwxQg=;
	b=TEb9t7SjZdVG6KhsIidNrvCapo0od2OUiY4a1swNINBJ0eBkZvxoveoNUQeSxJ7vNDkr6x
	FXJs9axqYUmV5CbH90w+IF9b9VZrkFQQ3/cRt7SfsSGBmAC57IpwY58wlRWY7TbUgKcXw+
	F6ngX2DWBO9usaUMWSA1BXXLiz2gUdmefFpgT6EbGsSw4fQgcc/racGmDyfzbfIjY+4eN1
	o3QJz1QzfozfU72vxn9F8e6AVn4erEq56//UsWVUhpe8WxseUqbC5z9D3O4i4YEY013izp
	+3E1HIPOLNg3MOHK+MbHbA0SO5UvpP1mNxjOgRuYdIwPkjiVTdcma6BgomOeSA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 02 Oct 2026 17:03:25 +0200
Subject: [PATCH net-next 7/7] net: bcmgenet: reassemble jumbo frames from
 status block fragments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-nb-genet-mtu-nn-v2-v1-7-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The hardware does not truncate a frame longer than the packet ready
threshold. It splits the frame across descriptors and writes a status block
at the start of each one. The first fragment then arrives with SOP and no
EOP and is dropped as fragmented. This caps the MTU.

Strip the status blocks and reassemble the fragments. Only the last block
holds the checksum of the whole frame. Broadcom confirmed from the RTL that
every GENET revision splits long frames this way, not just the v5 this was
tested on.

The MAC only checksums a frame it holds in full, so anything longer than
the threshold falls back to software. At jumbo sizes the larger frame saves
more per packet overhead than the checksum costs.

UMAC_MAX_FRAME_LEN is 14 bit and counts the FCS. That puts the maximum MTU
at 16347.

Suggested-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 106 ++++++++++++++++++++++---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |   2 +
 2 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 0cd56ec1c5cc..62edbe51fe07 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -82,11 +82,8 @@
 				      ENET_THLD_MAX * ENET_THLD_UNIT, \
 				      ENET_THLD_PAGE_LEN)
 
-/* Largest MTU that fits one descriptor, with room for a VLAN tag so a VLAN
- * interface can use the parent MTU.
- */
-#define ENET_MAX_MTU		(ENET_THLD_MAX_LEN - GENET_RBUF_ALIGN - \
-				 ETH_HLEN - VLAN_HLEN)
+/* UMAC_MAX_FRAME_LEN is 14 bits wide and counts the FCS */
+#define ENET_MAX_JUMBO_MTU	(GENMASK(13, 0) - ENET_FRAME_OVERHEAD)
 
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
@@ -2176,6 +2173,19 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
+	/* The MAC holds a frame to insert its checksum, but only as much as
+	 * its FIFO takes. Longer frames are dropped silently.
+	 */
+	if (unlikely(skb->len > priv->tx_thld_len) &&
+	    skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (skb_checksum_help(skb)) {
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			dev_kfree_skb_any(skb);
+			ret = NETDEV_TX_OK;
+			goto out;
+		}
+	}
+
 	/* Keep the frame out of the window just past the threshold */
 	if (unlikely(skb->len > priv->tx_thld_len &&
 		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
@@ -2318,6 +2328,54 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 	return 0;
 }
 
+/* Drop the frame being collected. Its remaining descriptors carry no SOP,
+ * so they are dropped quietly until the next one does.
+ */
+static void bcmgenet_discard_frags(struct bcmgenet_rx_ring *ring)
+{
+	ring->frag_drop = true;
+
+	if (!ring->frag_head)
+		return;
+
+	dev_kfree_skb_any(ring->frag_head);
+	ring->frag_head = NULL;
+}
+
+/* A frame longer than the threshold arrives in several descriptors, each with
+ * its own status block. Only the first one carries a header, so hand the page
+ * of every later one to the frame already being collected. Returns the frame
+ * once EOP is in, NULL while more descriptors are expected or once the frame
+ * had to be dropped.
+ */
+static struct sk_buff *bcmgenet_add_frag(struct bcmgenet_rx_ring *ring,
+					 struct page *page,
+					 unsigned int offset,
+					 unsigned int size,
+					 unsigned int dma_flag,
+					 unsigned int len)
+{
+	struct sk_buff *head = ring->frag_head;
+
+	if (unlikely(skb_shinfo(head)->nr_frags >= MAX_SKB_FRAGS)) {
+		BCMGENET_STATS64_INC((&ring->stats64), fragmented_errors);
+		bcmgenet_discard_frags(ring);
+		page_pool_put_full_page(ring->page_pool, page, true);
+		return NULL;
+	}
+
+	skb_add_rx_frag(head, skb_shinfo(head)->nr_frags, page,
+			offset + sizeof(struct status_64),
+			len - sizeof(struct status_64), size);
+
+	if (!(dma_flag & DMA_EOP))
+		return NULL;
+
+	ring->frag_head = NULL;
+
+	return head;
+}
+
 /* bcmgenet_desc_rx - descriptor based rx process.
  * this could be called from bottom half, or from NAPI polling method.
  */
@@ -2382,6 +2440,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 		if (bcmgenet_rx_refill(ring, cb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
+			bcmgenet_discard_frags(ring);
 			goto next;
 		}
 
@@ -2415,15 +2474,23 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			netif_err(priv, rx_status, dev,
 				  "invalid packet length %d\n", len);
 			BCMGENET_STATS64_INC(stats, length_errors);
+			bcmgenet_discard_frags(ring);
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			goto next;
 		}
 
-		if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
-			netif_err(priv, rx_status, dev,
-				  "dropping fragmented packet!\n");
-			BCMGENET_STATS64_INC(stats, fragmented_errors);
+		/* A new SOP resynchronizes after an incomplete frame */
+		if (dma_flag & DMA_SOP) {
+			if (ring->frag_head) {
+				BCMGENET_STATS64_INC(stats, fragmented_errors);
+				bcmgenet_discard_frags(ring);
+			}
+			ring->frag_drop = false;
+		} else if (unlikely(!ring->frag_head)) {
+			/* Rest of a dropped frame, or no SOP seen yet */
+			if (!ring->frag_drop)
+				BCMGENET_STATS64_INC(stats, fragmented_errors);
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			goto next;
@@ -2453,17 +2520,27 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 						DMA_RX_RXER)) == DMA_RX_RXER)
 				u64_stats_inc(&stats->errors);
 			u64_stats_update_end(&stats->syncp);
+			bcmgenet_discard_frags(ring);
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			goto next;
 		} /* error packet */
 
+		if (!(dma_flag & DMA_SOP)) {
+			skb = bcmgenet_add_frag(ring, rx_page, rx_offset,
+						rx_size, dma_flag, len);
+			if (!skb)
+				goto next;
+			goto deliver;
+		}
+
 		/* Build SKB from the page - data starts at hard_start,
 		 * frame begins after RSB(64) + pad(2) = 66 bytes.
 		 */
 		skb = napi_build_skb(hard_start, rx_size);
 		if (unlikely(!skb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
+			bcmgenet_discard_frags(ring);
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			goto next;
@@ -2475,6 +2552,13 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		skb_reserve(skb, GENET_RSB_PAD);
 		__skb_put(skb, len - GENET_RSB_PAD);
 
+		if (unlikely(!(dma_flag & DMA_EOP))) {
+			ring->frag_head = skb;
+			goto next;
+		}
+
+deliver:
+
 		if (priv->crc_fwd_en) {
 			skb_trim(skb, skb->len - ETH_FCS_LEN);
 		}
@@ -2593,6 +2677,8 @@ static void bcmgenet_free_rx_buffers(struct bcmgenet_priv *priv)
 			cb = ring->cbs + i;
 			bcmgenet_free_rx_cb(cb, ring->page_pool);
 		}
+		/* a partial frame still holds pages of this pool */
+		bcmgenet_discard_frags(ring);
 	}
 }
 
@@ -4272,7 +4358,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	/* v1 cannot program the thresholds, so it stays at the default MTU */
 	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
 	if (!GENET_IS_V1(priv))
-		dev->max_mtu = ENET_MAX_MTU;
+		dev->max_mtu = ENET_MAX_JUMBO_MTU;
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index eb00cff0e732..0f31ad2f280d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -579,6 +579,8 @@ struct bcmgenet_rx_ring {
 	unsigned int	cb_ptr;		/* Rx ring initial CB ptr */
 	unsigned int	end_ptr;	/* Rx ring end CB ptr */
 	unsigned int	old_discards;
+	struct sk_buff	*frag_head;	/* frame being reassembled */
+	bool		frag_drop;	/* discarding until the next SOP */
 	struct bcmgenet_net_dim dim;
 	u32		rx_max_coalesced_frames;
 	u32		rx_coalesce_usecs;

-- 
2.53.0

