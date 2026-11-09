Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279101;
	b=tZYbZSz9tI0UhyAAtGlwo7T4uGZ7ut9hwmiZjidlfXrCDnvW18362cijslgPtOEvMS5P
	 xCUe2tijMwzX8y4MxTUBNWiaVSZ0JmxRU6CvzR9NebllZP45MK1JOoOmPYKF2V27SdmbW
	 vhoW6H7ksMrMauSnfADRE0qqwAnXQsDEOz52+Z52VTJT9vj85nB7KZLMEUtNcXfSb/WKk
	 1Kce7rsklZ+NPszu02bxS8ABl9Pipx8OHMTT7IOiDOKrqoBg2NKOExXGZuBcFjxpDwrI7
	 cxmFP0EYD4knqg7esg+eQrKM0SzYsr70xYkWIyf3SvGPunSfh4w9v9O6xRBcDb9zzPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279101;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=27fL9jyEKBFYegnjX3mm5ZGoz2eyAWbTtDAgS4A+SE0=;
	b=4R327dBJ8gKJt4G8Y2vFpPkSv371uVpiSK1Q2V18K/WwV07o/hvf3E2jpVeRUN/oi4eI
	 f+mHL9uzXT1NLPHvzLBf/OF01Lz7rA5j+NYqd2SRFpqhLmVcC0YTrN3hPIH/mguynl+sq
	 YL9IgkD9UAVpB4bT73rRs/PI6TWW+UUCR/n5cKgDpDlnluxsojMZ364x3ua0FRz/u1G7R
	 ZL+TbLepzWMeiSi6ghJ5E13JRu9fwdV2gKGUjSIqIUZo4vDN7fP178riTSEtFYQpzCuZK
	 WidhBKlhqjTkIWW8k+qG9i/g+k7dxio3gJHEqxQ5qhBQOoKKd31jqqIJZ9xT3nN1xSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=IIHoBaU2;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BD606A325;
	Tue, 10 Nov 2026 02:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 152BD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=IIHoBaU2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794279090; bh=27fL9jyEKBFYegnjX3mm5ZGoz2eyAWbTtDAgS4A+SE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIHoBaU2bD/EY6YxEUQU5ZeK7LnTfXIV5RMnYmemnmiAGsZHeEYioCsVPbUsQ7H2+
	 +ayTOy0KInVTw7KYl6pW5gZKwpoVyYI9AviQNjcZayJqHM2aH+ioJVThfmSR3jZ8Ss
	 eeJJhB9BZTXtzrRjHY2z5WcQymXrP8heHBtAaNvIw/DfspLvvSW29/v1UDlQF6gHXR
	 TLnQ6mnHXWYosYzfrVaAHHo3GWlJVFtIYKpBNeSJnD5lFhwh/K9Htz/x1lPIWuzwrK
	 ZoKEuLN+LSokqMu8ni0fqcZf6fluej/k8+DxBPfOZAvxkL9v/Nd2GeoSSJVyX9bB0H
	 gA4oBK9jCo6qg==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 75BED27A3806;
	Tue, 10 Nov 2026 04:51:30 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/3] net: ethernet: mtk_eth_soc: add 9K jumbo
Date: Tue, 10 Nov 2026 01:59:11 +0200
Message-Id: <patch-271a13eac7135a653a78c355e66438ab@loljews.com>
In-Reply-To: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
References: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The driver caps max_mtu at 2030 bytes and programs the MAC max-rx field
for at most 2048-byte frames, so MTU > 2K is rejected and 9K jumbo
frames are not usable on the 10G XGMII MACs.

Add a MTK_NETSYS_RX_9K capability for MT7988 and:
- advertise 9K max_mtu on the XGMII MACs, from the DT phy_mode at probe
  time, so DSA can raise the conduit MTU before the netdev is opened;
- derive the shared RX buffer length from the largest MTU of any MAC,
  with a 2K minimum, and size the RX rings from it;
- program the PDMA RX SDL max-frame field from that length on netsys
  v3+.  The field stores the frame length offset by MTK_PDMA_LRO_SDL,
  the layout of the MediaTek downstream driver, and the DMA engine
  accepts frames only up to it, so without this new write frames above
  the small reset default (~1518 bytes) are dropped on the wire;
- program XMAC_RX_CFG2 from the same length on the XGMII MACs, keeping
  the bits outside the length field, so 802.1Q-tagged frames fit at any
  MTU.  GMAC1 (the built-in switch port, phy-mode internal) keeps its
  MCR bucket programming instead: the XMAC register is not used for it,
  and the MCR field only encodes up to 2048, so that is the largest
  limit the driver can program for it.  The write runs after the XGMII
  setup of mtk_mac_config(), whose MAC_MCR_FORCE_LINK_DOWN write is a
  full-register write that would otherwise reset the field to the 1518
  bucket.  Whether the internal switch path enforces the MCR field at
  all is a hardware property: the downstream reference programs no
  limit for GMAC1 and jumbo frames pass the switch on the reference
  hardware, which suggests the field is not enforced there, but if it
  is, switch-side frames above 2048 bytes are dropped and no driver
  write can lift that;
- rewrite the MAC limits on every successful mtk_mac_config() and on
  every mtk_hw_init() call on the SoCs with the capability, so no MAC
  accepts a frame the rings cannot hold, not even after a reopen with a
  smaller MTU.  The other SoCs keep their per-device limits: they never
  grow their rings, and their MCR buckets are left exactly as before
  this patch;
- reject a runtime MTU change that would need larger buffers while DMA
  is running (-EBUSY).  Shrinking is allowed: the rings keep the buffers
  they already have.  The rings are shared by every MAC, so raising a
  DSA user port MTU on a live system fails while any MAC is up; the
  runtime reallocation that lifts this is a separate series.

XDP runs only on rings that have a page_pool, and the pool cannot back
buffers larger than MTK_PP_MAX_BUF_SIZE, so an MTU that needs a larger
buffer cannot be combined with XDP.  Both the XDP attach and the MTU
change are rejected in that case.  The check uses eth->rx_buf_len, the
length the live rings were actually built with; when the rings are not
live, or the attach itself tears them down, the next open re-derives
the length from the current MTUs and that value is checked instead.  A
program can therefore never attach and silently not run, and an attach
on a closed device is never rejected over a stale ring length.

Once any MAC's MTU needs more than ~3.5K, every RX buffer is a 16 KiB
compound page: with the 9K ring size that pins around 64 MiB while DMA
is up and turns the refill into a high-order GFP_ATOMIC allocation.
skb->truesize then reports the size actually allocated for those
buffers, not the smaller frag_size.

This is a forward-port of the MediaTek downstream jumbo work: Mason
Chang's "change default rx buffer length" and "add 9k jumbo frame
support" (MediaTek OpenWrt feed 999-eth-30/31, carried in
frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash the
right way".  The runtime reallocation of Mason's "dynamic rx buffer
adjustment" (feed 999-eth-33) is not included; it will be sent
separately.

Link: https://github.com/frank-w/BPI-Router-Linux/commit/b4c6cb1d5532
Link: https://github.com/mediatek/mtk-openwrt-feeds
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 268 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  12 +-
 2 files changed, 224 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 6768ab8eb..527fdaeec 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -171,6 +171,7 @@ static const struct mtk_reg_map mt7988_reg_map = {
 		.glo_cfg	= 0x6a04,
 		.rst_idx	= 0x6a08,
 		.delay_irq	= 0x6a0c,
+		.rx_cfg		= 0x6a10,
 		.irq_status	= 0x6a20,
 		.irq_mask	= 0x6a28,
 		.adma_rx_dbg0	= 0x6a38,
@@ -554,6 +555,47 @@ static int mtk_mac_prepare(struct phylink_config *config, unsigned int mode,
 	return 0;
 }
 
+/* The MACs are fed from the shared RX rings, so the maximum frame they may
+ * accept is a property of the ring buffer length.  GMAC1 on netsys v3+ is
+ * the built-in switch port: it has no XMAC_RX_CFG2 limit register and its
+ * MCR field only encodes up to 2048, so it keeps the MCR bucket
+ * programming the other SoCs use.
+ */
+static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val)
+{
+	struct mtk_eth *eth = mac->hw;
+	u32 mcr_cur, mcr_new;
+
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+		return;
+
+	if (!mtk_interface_mode_is_xgmii(eth, mac->interface) ||
+	    mac->id == MTK_GMAC1_ID) {
+		mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
+		mcr_new = mcr_cur & ~MAC_MCR_MAX_RX_MASK;
+
+		if (val <= 1518)
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1518);
+		else if (val <= 1536)
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1536);
+		else if (val <= 1552)
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1552);
+		else
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_2048);
+
+		if (mcr_new != mcr_cur)
+			mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
+	} else {
+		mcr_cur = mtk_r32(mac->hw, MTK_XMAC_RX_CFG2(mac->id));
+		mcr_new = mcr_cur & ~MTK_XMAC_MAX_RX_MASK;
+		mcr_new |= FIELD_PREP(MTK_XMAC_MAX_RX_MASK,
+				      min_t(u32, val, MTK_MAX_RX_LENGTH_9K));
+
+		if (mcr_new != mcr_cur)
+			mtk_w32(mac->hw, mcr_new, MTK_XMAC_RX_CFG2(mac->id));
+	}
+}
+
 static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 			   const struct phylink_link_state *state)
 {
@@ -678,6 +720,18 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 			mtk_setup_bridge_switch(eth);
 	}
 
+	/* On the SoCs with the 9K capability the rings grow with the MTU, so
+	 * rewrite the MAC limit on every successful mac_config, not only
+	 * when the interface mode changes: a reopen after an MTU change
+	 * must narrow the MACs that still carry the previous, larger
+	 * limit.  This must run after the XGMII setup above: its
+	 * MAC_MCR_FORCE_LINK_DOWN write is a full-register write that
+	 * would otherwise reset GMAC1's max-rx field (its limit lives in
+	 * the MCR register, not in XMAC_RX_CFG2) back to the 1518 bucket.
+	 */
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K))
+		mtk_set_mcr_max_rx(mac, eth->rx_buf_len);
+
 	return;
 
 err_phy:
@@ -1242,22 +1296,22 @@ static void mtk_get_stats64(struct net_device *dev,
 	storage->tx_dropped = dev->stats.tx_dropped;
 }
 
-static inline int mtk_max_frag_size(int mtu)
+static inline int mtk_max_frag_size(struct mtk_eth *eth, int mtu)
 {
-	/* make sure buf_size will be at least MTK_MAX_RX_LENGTH */
-	if (mtu + MTK_RX_ETH_HLEN < MTK_MAX_RX_LENGTH_2K)
-		mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;
+	/* make sure buf_size will be at least the shared rx buffer length */
+	if (mtu + MTK_RX_ETH_HLEN < eth->rx_buf_len)
+		mtu = eth->rx_buf_len - MTK_RX_ETH_HLEN;
 
 	return SKB_DATA_ALIGN(MTK_RX_HLEN + mtu) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 }
 
-static inline int mtk_max_buf_size(int frag_size)
+static inline int mtk_max_buf_size(struct mtk_eth *eth, int frag_size)
 {
 	int buf_size = frag_size - NET_SKB_PAD - NET_IP_ALIGN -
 		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	WARN_ON(buf_size < MTK_MAX_RX_LENGTH_2K);
+	WARN_ON(buf_size < eth->rx_buf_len);
 
 	return buf_size;
 }
@@ -1280,9 +1334,17 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	return true;
 }
 
-static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
+/* mtk_max_buf_alloc() rounds the buffer up to a whole page order, so
+ * report the size it actually allocated, not the smaller frag_size, in
+ * skb->truesize.
+ */
+static unsigned int mtk_buf_alloc_size(unsigned int size)
+{
+	return PAGE_SIZE << get_order(size);
+}
+
+static void *mtk_max_buf_alloc(unsigned int size, gfp_t gfp_mask)
 {
-	unsigned int size = mtk_max_frag_size(MTK_MAX_LRO_RX_LENGTH);
 	unsigned long data;
 
 	data = __get_free_pages(gfp_mask | __GFP_COMP | __GFP_NOWARN,
@@ -2313,10 +2375,15 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 				skb_metadata_set(skb, metasize);
 			skb_mark_for_recycle(skb);
 		} else {
+			unsigned int alloc_size = ring->frag_size > PAGE_SIZE ?
+				mtk_buf_alloc_size(ring->frag_size) :
+				ring->frag_size;
+
 			if (ring->frag_size <= PAGE_SIZE)
 				new_data = napi_alloc_frag(ring->frag_size);
 			else
-				new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
+				new_data = mtk_max_buf_alloc(ring->frag_size,
+							     GFP_ATOMIC);
 
 			if (unlikely(!new_data)) {
 				netdev->stats.rx_dropped++;
@@ -2339,7 +2406,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
 					 ring->buf_size, DMA_FROM_DEVICE);
 
-			skb = build_skb(data, ring->frag_size);
+			skb = build_skb(data, alloc_size);
 			if (unlikely(!skb)) {
 				netdev->stats.rx_dropped++;
 				skb_free_frag(data);
@@ -2818,8 +2885,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		rx_dma_size = soc->rx.dma_size;
 	}
 
-	ring->frag_size = mtk_max_frag_size(rx_data_len);
-	ring->buf_size = mtk_max_buf_size(ring->frag_size);
+	ring->frag_size = mtk_max_frag_size(eth, rx_data_len);
+	ring->buf_size = mtk_max_buf_size(eth, ring->frag_size);
 	ring->data = kcalloc(rx_dma_size, sizeof(*ring->data),
 			     GFP_KERNEL);
 	if (!ring->data)
@@ -2864,7 +2931,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 			if (ring->frag_size <= PAGE_SIZE)
 				data = netdev_alloc_frag(ring->frag_size);
 			else
-				data = mtk_max_lro_buf_alloc(GFP_KERNEL);
+				data = mtk_max_buf_alloc(ring->frag_size,
+							 GFP_KERNEL);
 
 			if (!data)
 				return -ENOMEM;
@@ -3260,6 +3328,56 @@ static int mtk_dma_busy_wait(struct mtk_eth *eth)
 	return ret;
 }
 
+static int mtk_max_gmac_mtu(struct mtk_eth *eth)
+{
+	int i, max_mtu = ETH_DATA_LEN;
+
+	for (i = 0; i < ARRAY_SIZE(eth->netdev); i++)
+		if (eth->netdev[i] && eth->netdev[i]->mtu > max_mtu)
+			max_mtu = eth->netdev[i]->mtu;
+
+	return max_mtu;
+}
+
+static u32 mtk_rx_buf_len_from_mtu(int max_mtu)
+{
+	int length = max_mtu + MTK_RX_ETH_HLEN;
+
+	if (length <= MTK_MAX_RX_LENGTH_2K)
+		return MTK_MAX_RX_LENGTH_2K;
+
+	return DIV_ROUND_UP(length, 1024) * 1024;
+}
+
+/* The rx rings are shared by every MAC, so their buffers are sized for
+ * the largest MTU configured on any of them.
+ */
+static u32 mtk_rx_buf_len(struct mtk_eth *eth)
+{
+	return mtk_rx_buf_len_from_mtu(mtk_max_gmac_mtu(eth));
+}
+
+/* Program the PDMA RX max-frame (SDL) field from the shared RX buffer
+ * length.  The field only exists on netsys v3+ and stores the frame
+ * length offset by MTK_PDMA_LRO_SDL, the layout used by the MediaTek
+ * downstream driver; the DMA engine accepts frames only up to it, so
+ * without this write jumbo frames are dropped.
+ */
+static void mtk_pdma_set_sdl(struct mtk_eth *eth)
+{
+	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
+	u32 val;
+
+	if (!mtk_is_netsys_v3_or_greater(eth))
+		return;
+
+	val = mtk_r32(eth, reg_map->pdma.rx_cfg);
+	val &= ~MTK_RX_CFG_SDL_MASK;
+	val |= FIELD_PREP(MTK_RX_CFG_SDL_MASK,
+			  MTK_PDMA_LRO_SDL + eth->rx_buf_len);
+	mtk_w32(eth, val, reg_map->pdma.rx_cfg);
+}
+
 static int mtk_dma_init(struct mtk_eth *eth)
 {
 	int err;
@@ -3268,6 +3386,14 @@ static int mtk_dma_init(struct mtk_eth *eth)
 	if (mtk_dma_busy_wait(eth))
 		return -EBUSY;
 
+	/* Derived here, at ring allocation, so eth->rx_buf_len always
+	 * describes the buffers the rings actually hold; mtk_change_mtu()
+	 * updates it while DMA is down so it describes the rings-to-be,
+	 * and mtk_mac_config() then never lets a MAC accept a frame the
+	 * rings cannot take.
+	 */
+	eth->rx_buf_len = mtk_rx_buf_len(eth);
+
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA)) {
 		/* QDMA needs scratch memory for internal reordering of the
 		 * descriptors
@@ -3311,6 +3437,8 @@ static int mtk_dma_init(struct mtk_eth *eth)
 		mtk_w32(eth, 0x0, eth->soc->reg_map->qdma.hred);
 	}
 
+	mtk_pdma_set_sdl(eth);
+
 	return 0;
 }
 
@@ -3601,17 +3729,6 @@ static int mtk_device_event(struct notifier_block *n, unsigned long event, void
 	return NOTIFY_DONE;
 }
 
-static int mtk_max_gmac_mtu(struct mtk_eth *eth)
-{
-	int i, max_mtu = ETH_DATA_LEN;
-
-	for (i = 0; i < ARRAY_SIZE(eth->netdev); i++)
-		if (eth->netdev[i] && eth->netdev[i]->mtu > max_mtu)
-			max_mtu = eth->netdev[i]->mtu;
-
-	return max_mtu;
-}
-
 static int mtk_open(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -3781,6 +3898,7 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 	struct bpf_prog *old_prog;
+	u32 rx_buf_len;
 	bool need_update;
 
 	if (eth->hwlro) {
@@ -3788,12 +3906,26 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (dev->mtu > MTK_PP_MAX_BUF_SIZE) {
+	need_update = !!eth->prog != !!prog;
+
+	/* XDP only runs on rings that have a page_pool, and the pool is
+	 * only created when the shared RX buffer length fits
+	 * MTK_PP_MAX_BUF_SIZE.  eth->rx_buf_len describes the live rings;
+	 * when the rings are not live, or this operation tears them down,
+	 * the next open re-derives it from the current MTUs, so check
+	 * that value instead.
+	 */
+	rx_buf_len = eth->rx_buf_len;
+	if (!refcount_read(&eth->dma_refcnt) ||
+	    (netif_running(dev) && need_update &&
+	     refcount_read(&eth->dma_refcnt) == 1))
+		rx_buf_len = mtk_rx_buf_len(eth);
+
+	if (rx_buf_len > MTK_PP_MAX_BUF_SIZE) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
 		return -EOPNOTSUPP;
 	}
 
-	need_update = !!eth->prog != !!prog;
 	if (netif_running(dev) && need_update)
 		mtk_stop(dev);
 
@@ -3928,30 +4060,6 @@ static void mtk_dim_tx(struct work_struct *work)
 	dim->state = DIM_START_MEASURE;
 }
 
-static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val)
-{
-	struct mtk_eth *eth = mac->hw;
-	u32 mcr_cur, mcr_new;
-
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
-		return;
-
-	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
-	mcr_new = mcr_cur & ~MAC_MCR_MAX_RX_MASK;
-
-	if (val <= 1518)
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1518);
-	else if (val <= 1536)
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1536);
-	else if (val <= 1552)
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1552);
-	else
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_2048);
-
-	if (mcr_new != mcr_cur)
-		mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
-}
-
 static void mtk_hw_reset(struct mtk_eth *eth)
 {
 	u32 val;
@@ -4219,8 +4327,11 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 			continue;
 
 		mtk_w32(eth, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(i));
-		mtk_set_mcr_max_rx(netdev_priv(dev),
-				   dev->mtu + MTK_RX_ETH_HLEN);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K))
+			mtk_set_mcr_max_rx(netdev_priv(dev), eth->rx_buf_len);
+		else
+			mtk_set_mcr_max_rx(netdev_priv(dev),
+					   dev->mtu + MTK_RX_ETH_HLEN);
 	}
 
 	/* Indicates CDM to parse the MTK special tag from CPU
@@ -4361,21 +4472,59 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 	int length = new_mtu + MTK_RX_ETH_HLEN;
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
+	u32 rx_buf_len;
+	bool running;
 	int max_mtu, i;
 
+	/* The RX rings are shared by every MAC, so the buffer length
+	 * follows the largest MTU of all of them, the new one included.
+	 */
+	max_mtu = new_mtu;
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
+		if (eth->netdev[i] && eth->netdev[i] != dev &&
+		    eth->netdev[i]->mtu > max_mtu)
+			max_mtu = eth->netdev[i]->mtu;
+	}
+	rx_buf_len = mtk_rx_buf_len_from_mtu(max_mtu);
+
 	if (rcu_access_pointer(eth->prog) &&
-	    length > MTK_PP_MAX_BUF_SIZE) {
+	    rx_buf_len > MTK_PP_MAX_BUF_SIZE) {
 		netdev_err(dev, "Invalid MTU for XDP mode\n");
 		return -EINVAL;
 	}
 
-	mtk_set_mcr_max_rx(mac, length);
+	/* The rings cannot be resized in place while DMA is running: a
+	 * larger buffer can only come from the reallocation at the next
+	 * open, so reject it.  A smaller one is fine, the buffers the
+	 * rings already hold are big enough for it.
+	 */
+	running = refcount_read(&eth->dma_refcnt);
+	if (running && rx_buf_len > eth->rx_buf_len)
+		return -EBUSY;
+
+	/* On the SoCs whose rings grow with the MTU, keep the MAC limit in
+	 * step with the shared buffers; the other SoCs keep the per-device
+	 * limit they always had.
+	 */
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K))
+		mtk_set_mcr_max_rx(mac, rx_buf_len);
+	else
+		mtk_set_mcr_max_rx(mac, length);
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	max_mtu = mtk_max_gmac_mtu(eth);
 	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
 		mtk_ppe_update_mtu(eth->ppe[i], max_mtu);
 
+	/* While DMA is up the rings keep the buffers they were built
+	 * with; update eth->rx_buf_len only when DMA is down so it keeps
+	 * describing the buffers the rings hold, or will hold at the next
+	 * open.
+	 */
+	if (!running)
+		eth->rx_buf_len = rx_buf_len;
+
 	return 0;
 }
 
@@ -5021,8 +5170,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	eth->netdev[id]->irq = eth->irq[MTK_FE_IRQ_SHARED];
 	eth->netdev[id]->dev.of_node = np;
 
+	/* DSA sets the conduit MTU (user MTU + tag) before the netdev is
+	 * opened, so max_mtu must already be final here.  Deriving it only
+	 * in mtk_open() leaves the conduit at its 1504 default and blocks
+	 * 9K frames on the DSA user ports.
+	 */
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN;
+	else if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K) &&
+		 mtk_interface_mode_is_xgmii(eth, phy_mode))
+		eth->netdev[id]->max_mtu =
+			MTK_MAX_RX_LENGTH_9K - MTK_RX_ETH_HLEN;
 	else
 		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;
 
@@ -5163,6 +5321,8 @@ static int mtk_probe(struct platform_device *pdev)
 	spin_lock_init(&eth->rx_irq_lock);
 	spin_lock_init(&eth->dim_lock);
 
+	eth->rx_buf_len = MTK_MAX_RX_LENGTH_2K;
+
 	eth->rx_dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	INIT_WORK(&eth->rx_dim.work, mtk_dim_rx);
 	INIT_DELAYED_WORK(&eth->reset.monitor_work, mtk_hw_reset_monitor_work);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 88a9b3b23..6525fcc5c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -29,6 +29,7 @@
 #define MTK_QDMA_PAGE_SIZE	2048
 #define MTK_MAX_RX_LENGTH	1536
 #define MTK_MAX_RX_LENGTH_2K	2048
+#define MTK_MAX_RX_LENGTH_9K	9216
 #define MTK_TX_DMA_BUF_LEN	0x3fff
 #define MTK_TX_DMA_BUF_LEN_V2	0xffff
 #define MTK_QDMA_RING_SIZE	2048
@@ -198,9 +199,10 @@
 #define MTK_MULTI_EN		BIT(10)
 #define MTK_PDMA_SIZE_8DWORDS	(1 << 4)
 
-/* PDMA Global Configuration Register */
+/* PDMA RX Configuration Register */
 #define MTK_PDMA_LRO_SDL	0x3000
 #define MTK_RX_CFG_SDL_OFFSET	16
+#define MTK_RX_CFG_SDL_MASK	GENMASK(30, MTK_RX_CFG_SDL_OFFSET)
 
 /* PDMA Reset Index Register */
 #define MTK_PST_DRX_IDX0	BIT(16)
@@ -530,6 +532,8 @@
 /* XFI Mac control registers */
 #define MTK_XMAC_BASE(x)	(0x12000 + (((x) - 1) * 0x1000))
 #define MTK_XMAC_MCR(x)		(MTK_XMAC_BASE(x))
+#define MTK_XMAC_RX_CFG2(x)	(MTK_XMAC_MCR(x) + 0xd0)
+#define MTK_XMAC_MAX_RX_MASK	GENMASK(13, 0)
 #define XMAC_MCR_TRX_DISABLE	0xf
 #define XMAC_MCR_FORCE_TX_FC	BIT(5)
 #define XMAC_MCR_FORCE_RX_FC	BIT(4)
@@ -985,6 +989,7 @@ enum mkt_eth_capabilities {
 	MTK_INFRA_BIT,
 	MTK_SHARED_SGMII_BIT,
 	MTK_HWLRO_BIT,
+	MTK_NETSYS_RX_9K_BIT,
 	MTK_SHARED_INT_BIT,
 	MTK_TRGMII_MT7621_CLK_BIT,
 	MTK_QDMA_BIT,
@@ -1026,6 +1031,7 @@ enum mkt_eth_capabilities {
 #define MTK_INFRA		BIT_ULL(MTK_INFRA_BIT)
 #define MTK_SHARED_SGMII	BIT_ULL(MTK_SHARED_SGMII_BIT)
 #define MTK_HWLRO		BIT_ULL(MTK_HWLRO_BIT)
+#define MTK_NETSYS_RX_9K	BIT_ULL(MTK_NETSYS_RX_9K_BIT)
 #define MTK_SHARED_INT		BIT_ULL(MTK_SHARED_INT_BIT)
 #define MTK_TRGMII_MT7621_CLK	BIT_ULL(MTK_TRGMII_MT7621_CLK_BIT)
 #define MTK_QDMA		BIT_ULL(MTK_QDMA_BIT)
@@ -1127,7 +1133,7 @@ enum mkt_eth_capabilities {
 
 #define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_GMAC2_2P5GPHY | \
 		      MTK_MUX_GMAC2_TO_2P5GPHY | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
-		      MTK_RSTCTRL_PPE2 | MTK_SRAM)
+		      MTK_RSTCTRL_PPE2 | MTK_SRAM | MTK_NETSYS_RX_9K)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1151,6 +1157,7 @@ struct mtk_reg_map {
 		u32	glo_cfg;	/* global configuration */
 		u32	rst_idx;	/* reset index */
 		u32	delay_irq;	/* delay interrupt */
+		u32	rx_cfg;		/* rx dma configuration */
 		u32	irq_status;	/* interrupt status */
 		u32	irq_mask;	/* interrupt mask */
 		u32	adma_rx_dbg0;
@@ -1314,6 +1321,7 @@ struct mtk_eth {
 	struct mtk_tx_ring		tx_ring;
 	struct mtk_rx_ring		rx_ring[MTK_MAX_RX_RING_NUM];
 	struct mtk_rx_ring		rx_ring_qdma;
+	u32				rx_buf_len;
 	struct napi_struct		tx_napi;
 	struct napi_struct		rx_napi;
 	void				*scratch_ring;
-- 
2.53.0

