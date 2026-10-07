Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8F46985A;
	Wed,  7 Oct 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363120; cv=none; b=J0yo2mr0UY+7Xrg7Ma/iYsRjY+uE64xtP8G4/EZPHlaJikdB/UI4l8uPfWdXnvqic72ADfVRlRPoPf4suOBiu64vH6STAY+3dmbbf7UmghQRyRpn/ezhAzNITKVpCjQNSujwYEuZ5bk6xFKP0WEK2t4vCndLcZOo/ODiWVtW9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363120; c=relaxed/simple;
	bh=pvO0rih5qqMVVd72Yv4dvYFY4G540PM0e2SigAcehoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9sjlMmcUunkhuwUh4fTuAGQAY1vGs3AKjlQUHRDfOuMskInWjNHbTeaTEwezfJBH1ecTdyaUlgix/R9p6pUJrLMfvXclPqcRIqeNM8NtPe1PzMCEEyZVfGuk04i5zS13g+dSxqMnWfZCcR0ijE0hbZBBX5PkiwKv+2iu4pe8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=GLf7QRxA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="GLf7QRxA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C253CA1552;
	Wed,  7 Oct 2026 10:51:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791363115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DwwslMF3Zg/M5hwc/Ds41duYYUPk9xL795BBcTVxLnE=;
	b=GLf7QRxAYo59tfouANXhV2VzKadL95Ku+HF3Th9nMkREuWU/tKE3mhCyBziib+yCtNq0GF
	0AXP+gPwNo30o0bhUsxGDXdgoEhg6Dj/sHHppeYjtqe54ggNCexEeqxkzd40OJ4Rk+tSiO
	FIVqVMnwiIywTRVwZPuze1h7MAJin9AtA9YUI45xM/X/boy9YiPQtWke8N+tUrk9r/pAS3
	6+qpsooKDyKDDdnYQYzwHNRY73LbkeyS4H/O7yQa/l6C0v9691bNwbT06zpskWJU74wtQd
	XS1oM4ov95cgkk7GazXLvv+g+NdZnRLJT6TEYE91mdeMNpAc5Z6kT3lXq80DtA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 07 Oct 2026 10:51:31 +0200
Subject: [PATCH net-next v3 8/8] net: bcmgenet: reassemble jumbo frames
 from status block fragments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-nb-genet-mtu-nn-v2-v3-8-74a796c019ce@tipi-net.de>
References: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
In-Reply-To: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: b4 0.16.0
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

The TX descriptor length field is wider than DMA_BUFLENGTH_MASK suggests,
that mask only extracts the length from the RX status word. Single
descriptor frames of up to 8998 bytes went out intact.

Suggested-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 133 ++++++++++++++++++++-----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |   2 +
 2 files changed, 111 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 6d21ac2d78d5..80215b5c0063 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -84,11 +84,8 @@
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
@@ -2187,8 +2184,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
-	/* The MAC only inserts a checksum into a frame it holds in full, and
-	 * silently drops a longer one, so fall back to software.
+	/* The MAC holds a frame to insert its checksum, but only as much as
+	 * its FIFO takes. Longer frames are dropped silently.
 	 */
 	if (unlikely(skb->len > priv->tx_thld_len) &&
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -2338,6 +2335,54 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
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
@@ -2402,6 +2447,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 		if (bcmgenet_rx_refill(ring, cb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
+			bcmgenet_discard_frags(ring);
 			goto next;
 		}
 
@@ -2426,24 +2472,41 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			  __func__, p_index, ring->c_index,
 			  ring->read_ptr, dma_length_status);
 
-		/* Only the first descriptor carries the alignment pad */
-		min_len = dma_flag & DMA_SOP ? GENET_RSB_PAD
-					     : sizeof(struct status_64);
+		/* Only the first descriptor carries the alignment pad. A head
+		 * with more to come must hold the Ethernet header.
+		 */
+		if (dma_flag & DMA_SOP) {
+			min_len = GENET_RSB_PAD;
+			if (!(dma_flag & DMA_EOP))
+				min_len += ETH_HLEN;
+		} else {
+			min_len = sizeof(struct status_64);
+		}
 
 		/* Reject lengths that would underflow the SKB build path. */
 		if (unlikely(len > priv->rx_buf_len || len < min_len)) {
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
+			if (!ring->frag_drop) {
+				BCMGENET_STATS64_INC(stats, fragmented_errors);
+				ring->frag_drop = true;
+			}
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			goto next;
@@ -2473,17 +2536,27 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
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
@@ -2495,17 +2568,26 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		skb_reserve(skb, GENET_RSB_PAD);
 		__skb_put(skb, len - GENET_RSB_PAD);
 
-		if (priv->crc_fwd_en) {
-			skb_trim(skb, skb->len - ETH_FCS_LEN);
+		if (unlikely(!(dma_flag & DMA_EOP))) {
+			ring->frag_head = skb;
+			goto next;
+		}
+
+deliver:
+		/* The FCS trim may release the page with the last status block */
+		rx_csum = (__force __be16)(status->rx_csum & 0xffff);
+
+		if (priv->crc_fwd_en &&
+		    unlikely(pskb_trim(skb, skb->len - ETH_FCS_LEN))) {
+			BCMGENET_STATS64_INC(stats, dropped);
+			dev_kfree_skb_any(skb);
+			goto next;
 		}
 
 		/* Set up checksum offload */
-		if (dev->features & NETIF_F_RXCSUM) {
-			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
-			if (rx_csum) {
-				skb->csum = (__force __wsum)ntohs(rx_csum);
-				skb->ip_summed = CHECKSUM_COMPLETE;
-			}
+		if ((dev->features & NETIF_F_RXCSUM) && rx_csum) {
+			skb->csum = (__force __wsum)ntohs(rx_csum);
+			skb->ip_summed = CHECKSUM_COMPLETE;
 		}
 
 		len = skb->len;
@@ -2613,6 +2695,8 @@ static void bcmgenet_free_rx_buffers(struct bcmgenet_priv *priv)
 			cb = ring->cbs + i;
 			bcmgenet_free_rx_cb(cb, ring->page_pool);
 		}
+		/* a partial frame still holds pages of this pool */
+		bcmgenet_discard_frags(ring);
 	}
 }
 
@@ -2683,7 +2767,8 @@ static void bcmgenet_link_intr_enable(struct bcmgenet_priv *priv)
 }
 
 /* Receive threshold in register units. Covers the alignment bytes and the
- * frame, but not the status block, which the hardware adds on top.
+ * frame up to the register maximum, but not the status block, which the
+ * hardware adds on top. A longer frame arrives in several descriptors.
  */
 static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
 {
@@ -4298,7 +4383,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	/* v1 cannot program the thresholds, so it stays at the default MTU */
 	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
 	if (!GENET_IS_V1(priv))
-		dev->max_mtu = ENET_MAX_MTU;
+		dev->max_mtu = ENET_MAX_JUMBO_MTU;
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index a4933a5d3823..97c27b7920d5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -581,6 +581,8 @@ struct bcmgenet_rx_ring {
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

