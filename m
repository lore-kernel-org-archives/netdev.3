Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172554;
	b=r4trAkpdzTgvNQHwSrJ/kD35bYC8c4ZmJddJ6atYihY49HCdUbUS0Ja83mZGEWcpMGuO
	 4m4+ZnrktFRKc6I9AzkuCRIjZEj2XBMXqIhvErOo7QzrfICxfI+8XdulIr+NG4EQVh6X0
	 R5qKQfIU9HSvwrb4TQ+7ruisXhi7p+ZgZn1cxW758lE5gJcg/3g94gPbWC+5hShrXQ5vS
	 rAlH6Ex2TvgtmbMaSYwC0KrUFadbgDORa0LxjQ1nMdL/lh5+u2ScrkWJdgRe72SsfU+yH
	 VmYIZaXeg5WGI2KW7HsNHAfnOYWIIwVyVtK0cGLQECsEwDkgxzMwZDjRHk2owydCo+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172554;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dCztAbNPUZ0mbKh3BMouVOhT5o3QfuvvRemRUrK7vVs=;
	b=MThZmyGtx0IRwT9h+nhVurT7bNlJRlrZwGzkxbmcR1OcSJ0VHrTwdjUHb8fUGO9Kp1Qj
	 VCnrcAMG7hhJgwP8/eCu1QQ/GlZqsUepJ2EwHzX7UxM7aPpFRj2mLfa04/IHecdD8iDk9
	 PYqpBRcY5HwPY9vy/um1UmRzBIyhIwRJP7BDKRRcKCi3D+h714jbZJzoMJzXgORBkk4/Z
	 Aca/O9hamaPhe3hbuvOd8Q3l1wovdbvkqdp34WaNYVFcBWNv4g09ywTaM4eYWqYWOFCU9
	 7hNcmo5iPxpYn7sXASL3X61/YKRfGH/tWV5pRC3Q6PJ1Nirnk4gO2dcx3F96gkPxWug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=dER34YZR;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7C606A322;
	Sun,  8 Nov 2026 21:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C7C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=dER34YZR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794172537; bh=dCztAbNPUZ0mbKh3BMouVOhT5o3QfuvvRemRUrK7vVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dER34YZRig/cG46lTXL246JlcDdPXXC8xwAoEk+hPnU8fDPQkJX78SKwRPLmvuppV
	 0dHQA3R28H1zUuP7YeD5Avs9ruKsKgS0jx5oxGVP7xc+3EdwYvG2lZAFNg2gi9vcvB
	 jokUCBwnDTUVBOPnca08cnVu8RI7XFB3NfDMCj2obeWnMw0tBsSphY3p0NZBs4MGQt
	 FrUkCF7tvCUGWRVE71QYcnz6luDBEhZtW6LHLJtc4EgnSBNDpGtF91xp0zL5fdo+G+
	 uiXsliud9dZ4tcd1DpfJ3qG6JTxLu22K5/PDsIiM8lXIXWl/X0PG6qU1zQF4/fPf2q
	 /JThg6yxGGwRA==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 0E25027A3806;
	Sun, 08 Nov 2026 23:15:37 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: ethernet: mtk_eth_soc: add 9K jumbo
Date: Sun, 8 Nov 2026 22:38:16 +0200
Message-Id: <patch-10770ae7af4227d4823574c6689a7a4c@loljews.com>
In-Reply-To: <patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com>
References: <patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com>
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
- program XMAC_RX_CFG2 on the XGMII MACs, keeping the bits outside the
  length field;
- program the PDMA RX SDL max frame from the shared buffer length,
  replacing the field instead of OR-ing into the value already there;
- derive the shared RX buffer length from the largest MTU of any MAC and
  size the RX rings from it, with 2K as the minimum so the MTUs every SoC
  accepts today keep working, at runtime included;
- program the MAC max-rx limits from that shared length in
  mtk_mac_config(), so no MAC accepts a frame the rings cannot hold, not
  even after a reopen with a smaller MTU;
- reject only a runtime MTU change that would need larger buffers while
  DMA is running (-EBUSY).  Shrinking is allowed: the rings keep the
  buffers they already have.

XDP needs a page_pool, and the pool cannot back buffers larger than
MTK_PP_MAX_BUF_SIZE, so an MTU that needs a larger buffer cannot be
combined with XDP.  Both the XDP attach and the MTU change are rejected
in that case, instead of letting a program attach and never run.

The RX rings are shared, so the largest MTU of any MAC pins order-2
buffers for every ring while DMA is up, around 64 MiB at 9K; the refill
in mtk_poll_rx() is then a high-order GFP_ATOMIC allocation.  That is the
cost of the downstream design and is documented in the commit message on
purpose.

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
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 205 +++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  10 +-
 2 files changed, 164 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index f2b2fb113..c7bc8eaea 100644
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
@@ -554,6 +555,41 @@ static int mtk_mac_prepare(struct phylink_config *config, unsigned int mode,
 	return 0;
 }
 
+static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val)
+{
+	struct mtk_eth *eth = mac->hw;
+	u32 mcr_cur, mcr_new;
+
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+		return;
+
+	if (!mtk_interface_mode_is_xgmii(eth, mac->interface)) {
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
+	} else if (mtk_is_netsys_v3_or_greater(mac->hw) &&
+		   mac->id != MTK_GMAC1_ID) {
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
@@ -649,6 +685,13 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		mac->interface = state->interface;
 	}
 
+	/* What a MAC may accept is a property of the shared RX rings, so
+	 * rewrite the limit on every mac_config and not only when the
+	 * interface mode changes: a reopen after an MTU change must narrow
+	 * the MACs that still carry the previous, larger limit.
+	 */
+	mtk_set_mcr_max_rx(mac, eth->rx_buf_len);
+
 	/* SGMII */
 	if (state->interface == PHY_INTERFACE_MODE_SGMII ||
 	    phy_interface_mode_is_8023z(state->interface)) {
@@ -1242,22 +1285,22 @@ static void mtk_get_stats64(struct net_device *dev,
 	storage->tx_dropped = dev->stats.tx_dropped;
 }
 
-static inline int mtk_max_frag_size(int mtu)
+static inline int mtk_max_frag_size(struct mtk_eth *eth, int mtu)
 {
-	/* make sure buf_size will be at least MTK_MAX_RX_LENGTH */
-	if (mtu + MTK_RX_ETH_HLEN < MTK_MAX_RX_LENGTH_2K)
-		mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;
+	/* make sure buf_size will be at least max rx buffer length */
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
@@ -1280,9 +1323,8 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	return true;
 }
 
-static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
+static void *mtk_max_buf_alloc(unsigned int size, gfp_t gfp_mask)
 {
-	unsigned int size = mtk_max_frag_size(MTK_MAX_LRO_RX_LENGTH);
 	unsigned long data;
 
 	data = __get_free_pages(gfp_mask | __GFP_COMP | __GFP_NOWARN,
@@ -2310,7 +2352,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			if (ring->frag_size <= PAGE_SIZE)
 				new_data = napi_alloc_frag(ring->frag_size);
 			else
-				new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
+				new_data = mtk_max_buf_alloc(ring->frag_size,
+							     GFP_ATOMIC);
 
 			if (unlikely(!new_data)) {
 				netdev->stats.rx_dropped++;
@@ -2812,8 +2855,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		rx_dma_size = soc->rx.dma_size;
 	}
 
-	ring->frag_size = mtk_max_frag_size(rx_data_len);
-	ring->buf_size = mtk_max_buf_size(ring->frag_size);
+	ring->frag_size = mtk_max_frag_size(eth, rx_data_len);
+	ring->buf_size = mtk_max_buf_size(eth, ring->frag_size);
 	ring->data = kcalloc(rx_dma_size, sizeof(*ring->data),
 			     GFP_KERNEL);
 	if (!ring->data)
@@ -2860,7 +2903,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 			if (ring->frag_size <= PAGE_SIZE)
 				data = netdev_alloc_frag(ring->frag_size);
 			else
-				data = mtk_max_lro_buf_alloc(GFP_KERNEL);
+				data = mtk_max_buf_alloc(ring->frag_size,
+							 GFP_KERNEL);
 
 			if (!data)
 				return -ENOMEM;
@@ -3256,6 +3300,55 @@ static int mtk_dma_busy_wait(struct mtk_eth *eth)
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
+/* The rx rings are shared by every MAC, so their buffers are sized for the
+ * largest MTU configured on any of them.
+ */
+static u32 mtk_rx_buf_len(struct mtk_eth *eth)
+{
+	return mtk_rx_buf_len_from_mtu(mtk_max_gmac_mtu(eth));
+}
+
+/* Program the PDMA RX max-frame field.  The frame engine is only reset at
+ * probe and on error recovery, not on every open, so the field has to be
+ * replaced rather than OR-ed: a later open with a different MTU would
+ * otherwise accumulate the old value.
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
@@ -3264,6 +3357,12 @@ static int mtk_dma_init(struct mtk_eth *eth)
 	if (mtk_dma_busy_wait(eth))
 		return -EBUSY;
 
+	/* Derived here, at ring allocation, so eth->rx_buf_len always describes
+	 * the buffers the rings actually hold and mtk_mac_config() never lets
+	 * a MAC accept a frame the rings cannot take.
+	 */
+	eth->rx_buf_len = mtk_rx_buf_len(eth);
+
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA)) {
 		/* QDMA needs scratch memory for internal reordering of the
 		 * descriptors
@@ -3307,6 +3406,11 @@ static int mtk_dma_init(struct mtk_eth *eth)
 		mtk_w32(eth, 0x0, eth->soc->reg_map->qdma.hred);
 	}
 
+	/* Program the PDMA max RX frame (SDL) from rx_buf_len so jumbo
+	 * frames up to it are accepted by the DMA engine.
+	 */
+	mtk_pdma_set_sdl(eth);
+
 	return 0;
 }
 
@@ -3597,17 +3701,6 @@ static int mtk_device_event(struct notifier_block *n, unsigned long event, void
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
@@ -3784,7 +3877,8 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (dev->mtu > MTK_PP_MAX_BUF_SIZE) {
+	if (dev->mtu > MTK_PP_MAX_BUF_SIZE ||
+	    mtk_rx_buf_len(eth) > MTK_PP_MAX_BUF_SIZE) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
 		return -EOPNOTSUPP;
 	}
@@ -3924,29 +4018,6 @@ static void mtk_dim_tx(struct work_struct *work)
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
 
 static void mtk_hw_reset(struct mtk_eth *eth)
 {
@@ -4215,8 +4286,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 			continue;
 
 		mtk_w32(eth, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(i));
-		mtk_set_mcr_max_rx(netdev_priv(dev),
-				   dev->mtu + MTK_RX_ETH_HLEN);
+		mtk_set_mcr_max_rx(netdev_priv(dev), eth->rx_buf_len);
 	}
 
 	/* Indicates CDM to parse the MTK special tag from CPU
@@ -4357,14 +4427,33 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 	int length = new_mtu + MTK_RX_ETH_HLEN;
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
+	bool running;
+	u32 rx_buf_len;
 	int max_mtu, i;
 
+	/* The RX rings are shared by every MAC, so the buffer length follows
+	 * the largest MTU of all of them, including the new one.
+	 */
+	max_mtu = mtk_max_gmac_mtu(eth);
+	if (new_mtu > max_mtu)
+		max_mtu = new_mtu;
+	rx_buf_len = mtk_rx_buf_len_from_mtu(max_mtu);
+
 	if (rcu_access_pointer(eth->prog) &&
-	    length > MTK_PP_MAX_BUF_SIZE) {
+	    rx_buf_len > MTK_PP_MAX_BUF_SIZE) {
 		netdev_err(dev, "Invalid MTU for XDP mode\n");
 		return -EINVAL;
 	}
 
+	/* The rings cannot be resized in place while DMA is running.  A
+	 * larger buffer would need the reallocation at the next open; a
+	 * smaller one is fine, the buffers the rings hold are already big
+	 * enough for it.
+	 */
+	running = refcount_read(&eth->dma_refcnt);
+	if (running && rx_buf_len > eth->rx_buf_len)
+		return -EBUSY;
+
 	mtk_set_mcr_max_rx(mac, length);
 	WRITE_ONCE(dev->mtu, new_mtu);
 
@@ -4372,6 +4461,11 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
 		mtk_ppe_update_mtu(eth->ppe[i], max_mtu);
 
+	if (!running) {
+		eth->rx_buf_len = rx_buf_len;
+		mtk_pdma_set_sdl(eth);
+	}
+
 	return 0;
 }
 
@@ -5017,8 +5111,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
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
 
@@ -5159,6 +5262,8 @@ static int mtk_probe(struct platform_device *pdev)
 	spin_lock_init(&eth->rx_irq_lock);
 	spin_lock_init(&eth->dim_lock);
 
+	eth->rx_buf_len = MTK_MAX_RX_LENGTH_2K;
+
 	eth->rx_dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	INIT_WORK(&eth->rx_dim.work, mtk_dim_rx);
 	INIT_DELAYED_WORK(&eth->reset.monitor_work, mtk_hw_reset_monitor_work);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 88a9b3b23..0cf2aaf23 100644
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
@@ -201,6 +202,7 @@
 /* PDMA Global Configuration Register */
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

