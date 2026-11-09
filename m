Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262797;
	b=kOAMnthMW7qUuPHhyohiBKxBH+NOQ+MO/b7b0PYTkRRja5yEO2y14GmYTtfZHxR6fbFe
	 AhEAJZ2+Ou2eYp5xJQF0V1uj+CSM+j9rZmIhEwKlcREo50FYXUM221pmfVfouSrVuQ6Ou
	 srpaphU0KPtrtXQPsltGr5DGVs18lgQvjSESSIlAEMGYNtJFngryAt9dVxyjQgsixcvp8
	 kjjFDrHahDNOfH5Wx5dZb+anDph3LVPhm/tg0h0hcBFRjAc/4AompmFXERa/ROCLrTTqo
	 v81tR41EfxxKFho7DWuSqozxGPOzOnbbVDFLiQltjUqhI+VrcMzyvbuPRA1ygNaHj7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262797;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Nl3oOExTQ74HMckae6PwPrluldj6ZE8tIHdfvvG9Ot8=;
	b=dhTz3X6KWMRpD8Rv6DvhWUT4tlkTxkiW3WhEzREVI9MDXwtM3FVQtsCEmzOaaEV+ihS+
	 0D1TEFlBfdeCMIcOQz9FXViaY8bOdgDwM46wwzFuzRWIKWAp/+lEZZeHA6NyyoNLNWsbQ
	 tso3g6A6EhTpVa0c08mJ3v7RXZ3+e9cYpYKMZ67sSGxgZLhcrLs25DEEEm2QFvdshEF2s
	 mAnI/gT10dYHj9ZaE1Mk26YGhCJBZc7BlPbj07iomlHrgY5/SEYgodOK5Z2/HdW6aR9Jh
	 YQa4ByAi13YqOT2fjh5zUv1Dm6+rflI0lB4Ud/aa6hy5WpOzYtQt+HHjyRqo06JR5qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njFuq5MS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACB60A2611;
	Mon,  9 Nov 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njFuq5MS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132AE1F008A1;
	Mon,  9 Nov 2026 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262797;
	bh=Nl3oOExTQ74HMckae6PwPrluldj6ZE8tIHdfvvG9Ot8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=njFuq5MSbhNWD+iPwxeZemyqGDrtkevt59lMI/R6DXeWA+G4U0i1Bf7XrZ5GW14bh
	 /ZwcUoUPCeaji4I1u6F4i+mWEqWoF5MPi5+Tb/U8ERA/6rxQZDb4m5QnMeJn+1cqrK
	 a4gpVq9oWRl0ipkGNjCs90euBNmOXxvt491afj+gDvED1Lk0G/nRcR0hUSV14DT5+l
	 QKD2CvTUQcginqywgkkk/WgC29G9s4fdbTh4y7atOwB7w4MC4USFrPHyaWsiYRobUg
	 2HFQhPSOZLgc4y2c0lb317pW05eHKc4mBlcJEUx2Do1khAPPcVmrWXdtFiDZSCm2D4
	 mB7aqbTDPgocQ==
Subject: Re: [PATCH net-next v3 2/2] net: ethernet: mtk_eth_soc: add 9K jumbo
From: netdev-bot+sashiko@kernel.org
To: sandeeph@loljews.com
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 mason-cw.chang@mediatek.com, frank-w@public-files.de,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:19:55 +0000
Message-ID: <179426279563.994134.6856575949361866323@kernel.org>
In-Reply-To: <patch-10770ae7af4227d4823574c6689a7a4c@loljews.com>
References: <patch-10770ae7af4227d4823574c6689a7a4c@loljews.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mtk_xdp_setup() can accept an XDP program that then never runs.
- [Medium] The patch changes the GMAC MCR max-RX limit on every non-
  MT7628 SoC, not just MT7988.
- [Medium] mtk_pdma_set_sdl() writes `FIELD_PREP(GENMASK(30,16),
  MTK_PDMA_LRO_SDL + eth->rx_buf_len)` into PDMA RX_CFG (0x6a10) on…
- [Medium] Normal and QDMA RX rings now use high-order compound pages
  whenever frag_size > PAGE_SIZE: `mtk_max_buf_alloc(ring->frag_size,…
- [Medium] On MT7988, GMAC1 (built-in switch, DT phy-mode 'internal')
  counts as XGMII in mtk_interface_mode_is_xgmii(), so mtk_add_mac()…
- [Medium] In the XGMII branch, mtk_set_mcr_max_rx() writes the exact
  byte value it receives into MTK_XMAC_RX_CFG2[13:0] (`min_t(u32, val,…
- [Low] The commit message says the patch programs the PDMA RX SDL
  'replacing the field instead of OR-ing into the value already there',…
- [Low] The stated motivation is to let DSA raise the conduit MTU for 9K,
  but the -EBUSY check in mtk_change_mtu() (lines 4453-4455) tests the…
- [Low] The commit message says the patch is a forward-port of Mason
  Chang's 'change default rx buffer length' and 'add 9k jumbo frame…
- [Low] The comment above the page_pool gate in mtk_rx_alloc() (lines
  2865-2871) is now wrong in two ways.
- [Low] The comment in mtk_dma_init() (lines 3360-3364) says
  eth->rx_buf_len is 'Derived here, at ring allocation, so…

--

net: ethernet: mtk_eth_soc: add 9K jumbo

This adds a MTK_NETSYS_RX_9K capability for MT7988 and advertises a 9K
max_mtu on the XGMII MACs. The shared RX rings are sized from the largest
MTU of any MAC, and the GMAC/XMAC max-rx limits and the PDMA RX SDL are
programmed from that shared length. While DMA is running, MTU increases
that need larger buffers fail with -EBUSY, and XDP is rejected when the
buffer length is larger than MTK_PP_MAX_BUF_SIZE.

Link: https://github.com/frank-w/BPI-Router-Linux/commit/b4c6cb1d5532
Link: https://github.com/mediatek/mtk-openwrt-feeds

> - program the PDMA RX SDL max frame from the shared buffer length,
>   replacing the field instead of OR-ing into the value already there;

[Severity: Low]
Is this description accurate? In the baseline, MTK_PDMA_LRO_SDL and
MTK_RX_CFG_SDL_OFFSET are only defined in mtk_eth_soc.h. Nothing in
mtk_eth_soc.c uses them, and this patch adds the .rx_cfg reg map entry.

So there was no OR-ing to replace. The patch adds a new write to PDMA
RX_CFG through mtk_pdma_set_sdl(). It runs on every MT7988 DMA init and
on MTU changes while DMA is down, including at the default 1500 MTU.

Could the commit message say this is a new register write and not a fix
to existing behaviour?

> This is a forward-port of the MediaTek downstream jumbo work: Mason
> Chang's "change default rx buffer length" and "add 9k jumbo frame
> support" (MediaTek OpenWrt feed 999-eth-30/31, carried in
> frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash the
> right way".

[ ... ]

> Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>

[Severity: Low]
Should this carry credit tags for the original authors? The only trailer
is the submitter's Signed-off-by. There is no Co-developed-by: and
Signed-off-by: pair for Mason Chang or Frank Wunderlich, and no original
From:. Documentation/process/submitting-patches.rst asks for these when
porting someone else's work.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index f2b2fb1130ff9..c7bc8eaea7ab0 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

[ ... ]

> @@ -554,6 +555,41 @@ static int mtk_mac_prepare(struct phylink_config *config, unsigned int mode,
>  	return 0;
>  }
>  
> +static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val)
> +{
> +	struct mtk_eth *eth = mac->hw;
> +	u32 mcr_cur, mcr_new;
> +
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
> +		return;
> +
> +	if (!mtk_interface_mode_is_xgmii(eth, mac->interface)) {
> +		mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
> +		mcr_new = mcr_cur & ~MAC_MCR_MAX_RX_MASK;

[ ... ]

> +	} else if (mtk_is_netsys_v3_or_greater(mac->hw) &&
> +		   mac->id != MTK_GMAC1_ID) {

[Severity: Medium]
After this patch, does anything program an RX length limit for GMAC1 on
MT7988? GMAC1 is the built-in switch port with phy-mode internal, and
mtk_interface_mode_is_xgmii() treats PHY_INTERFACE_MODE_INTERNAL as
XGMII.

Once mtk_mac_config() sets mac->interface to INTERNAL, the MCR branch
above is skipped because the interface is XGMII. This branch is then
skipped by the mac->id != MTK_GMAC1_ID check.

Next, mtk_mac_config() does:

	if (mtk_interface_mode_is_xgmii(eth, state->interface)) {
		mtk_w32(mac->hw, MTK_GDMA_XGDM_SEL, MTK_GDMA_EG_CTRL(mac->id));
		mtk_w32(mac->hw, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(mac->id));

That leaves MAX_RX in MTK_MAC_MCR(0) at the 1518 encoding.
mtk_xgdm_mac_link_up() also returns early for GMAC1. In the baseline,
mtk_change_mtu() wrote MAX_RX into MTK_MAC_MCR(0).

At the same time, mtk_add_mac() advertises a 9K max_mtu for GMAC1,
because INTERNAL counts as XGMII.

Depending on the hardware, one of two things seems to follow. Either 9K
never works on the DSA conduit, or GMAC1 has no programmed limit at all.
In the second case, does the commit message's "no MAC accepts a frame
the rings cannot hold" hold for this MAC?

> +		mcr_cur = mtk_r32(mac->hw, MTK_XMAC_RX_CFG2(mac->id));
> +		mcr_new = mcr_cur & ~MTK_XMAC_MAX_RX_MASK;
> +		mcr_new |= FIELD_PREP(MTK_XMAC_MAX_RX_MASK,
> +				      min_t(u32, val, MTK_MAX_RX_LENGTH_9K));

[Severity: Medium]
Unlike the coarse buckets used for the GMAC MCR, this writes the exact
byte value into XMAC_RX_CFG2. mtk_change_mtu() passes:

	int length = new_mtu + MTK_RX_ETH_HLEN;

and MTK_RX_ETH_HLEN is ETH_HLEN + ETH_FCS_LEN, with no VLAN_HLEN.

Shrinking the MTU is allowed while running. After a runtime shrink to
MTU 1500 on MT7988 GMAC2, the XMAC limit becomes 1518. Would full-size
802.1Q tagged frames (1522 bytes) then be dropped by the MAC, even
though the rings hold at least 2048 bytes?

Likewise, at max_mtu the limit is capped at 9216, so tagged frames at
max_mtu could not be received either.

mtk_mac_config() also writes eth->rx_buf_len (at least 2048) into this
register on every open. The effective limit then depends on whether the
last operation was an MTU change or a reopen.

[ ... ]

> @@ -649,6 +685,13 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
>  		mac->interface = state->interface;
>  	}
>  
> +	/* What a MAC may accept is a property of the shared RX rings, so
> +	 * rewrite the limit on every mac_config and not only when the
> +	 * interface mode changes: a reopen after an MTU change must narrow
> +	 * the MACs that still carry the previous, larger limit.
> +	 */
> +	mtk_set_mcr_max_rx(mac, eth->rx_buf_len);

[Severity: Medium]
Is it intended that this affects every non-MT7628 SoC, and not only
MT7988?

mtk_rx_buf_len_from_mtu() never returns less than MTK_MAX_RX_LENGTH_2K.
Every open goes through
phylink_start()->phylink_mac_initial_config()->mtk_mac_config(). So on
MT7621/7622/7623/7629/7981/7986 the GMAC MCR now gets
MAC_MCR_MAX_RX_2048 at any MTU.

In the baseline, mtk_mac_config() did not touch this field, and
mtk_hw_init() used dev->mtu + MTK_RX_ETH_HLEN. A 1500 MTU interface got
the 1518 bucket and a 1504 DSA conduit got 1536. mtk_hw_init() now uses
eth->rx_buf_len as well.

So on all of these SoCs, frames up to 2048 bytes are accepted at a 1500
MTU, where before they were dropped and counted as rx_long_errors. The
commit message doesn't seem to mention this change.

mtk_change_mtu() also still calls:

	mtk_set_mcr_max_rx(mac, length);

with the per-device new_mtu + MTK_RX_ETH_HLEN. Doesn't that make the
same MTU give a different hardware limit, depending on whether an MTU
change or a reopen happened last?

[ ... ]

> @@ -2310,7 +2352,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			if (ring->frag_size <= PAGE_SIZE)
>  				new_data = napi_alloc_frag(ring->frag_size);
>  			else
> -				new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
> +				new_data = mtk_max_buf_alloc(ring->frag_size,
> +							     GFP_ATOMIC);

[Severity: Medium]
With a 9K MTU, the normal and QDMA rings now take this path.
mtk_max_buf_alloc() allocates whole pages:

	data = __get_free_pages(gfp_mask | __GFP_COMP | __GFP_NOWARN,
				get_order(size));

For a frag_size of about 9.6K that is 16 KiB. Later in mtk_poll_rx(),
the skb is still built with:

	skb = build_skb(data, ring->frag_size);

So skb->truesize comes from frag_size, not from the 16 KiB actually
allocated. Does that under-report the memory pinned by each skb by
about 40%? Remote traffic could then pin about 1.7x what the socket
rcvbuf and tcp_mem limits allow.

Before this patch only the HWLRO rings had this mismatch. Now it covers
every RX buffer once any MAC's MTU is above about 3.5K.

[ ... ]

> @@ -2812,8 +2855,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  		rx_dma_size = soc->rx.dma_size;
>  	}
>  
> -	ring->frag_size = mtk_max_frag_size(rx_data_len);
> -	ring->buf_size = mtk_max_buf_size(ring->frag_size);
> +	ring->frag_size = mtk_max_frag_size(eth, rx_data_len);
> +	ring->buf_size = mtk_max_buf_size(eth, ring->frag_size);

[Severity: Low]
This isn't a bug, but the comment a few lines below, above the page_pool
check in mtk_rx_alloc(), is now stale:

	 * length fits that.  Today every ring does; this is the preparation
	 * for the 9K support in the next patch, where the normal ring grows
	 * past the pool's limit and takes the netdev_alloc_frag()/
	 * mtk_max_lro_buf_alloc() path below instead.

This patch renames mtk_max_lro_buf_alloc() to mtk_max_buf_alloc(). This
patch is also the 9K support. With eth->rx_buf_len up to 9216, not every
ring fits MTK_PP_MAX_BUF_SIZE any more.

[ ... ]

> @@ -3256,6 +3300,55 @@ static int mtk_dma_busy_wait(struct mtk_eth *eth)

[ ... ]

> +static void mtk_pdma_set_sdl(struct mtk_eth *eth)
> +{
> +	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> +	u32 val;
> +
> +	if (!mtk_is_netsys_v3_or_greater(eth))
> +		return;
> +
> +	val = mtk_r32(eth, reg_map->pdma.rx_cfg);
> +	val &= ~MTK_RX_CFG_SDL_MASK;
> +	val |= FIELD_PREP(MTK_RX_CFG_SDL_MASK,
> +			  MTK_PDMA_LRO_SDL + eth->rx_buf_len);
> +	mtk_w32(eth, val, reg_map->pdma.rx_cfg);

[Severity: Medium]
Is MTK_PDMA_LRO_SDL + eth->rx_buf_len the intended value? The comment in
mtk_dma_init() says the SDL is programmed "from rx_buf_len so jumbo
frames up to it are accepted by the DMA engine".

The code writes 0x3800 (14336) at 2K and 0x5400 (21504) at 9K. That is
about 12 KiB more than both rx_buf_len and the per-descriptor
ring->buf_size.

MTK_PDMA_LRO_SDL is 0x3000, the same as MTK_MAX_LRO_RX_LENGTH. That is
an HW LRO constant, and MT7988 does not use HW LRO here.

The new MTK_RX_CFG_SDL_MASK, GENMASK(30, 16), sits under the "PDMA Global
Configuration Register" comment in mtk_eth_soc.h but is applied to
rx_cfg. At 9K, + and | give different values (0x5400 vs 0x3400), and the
write sets bit 30. If the real field is narrower, could this overwrite a
neighbouring RX_CFG control bit?

This register was never written before, so every MT7988 board now loses
its reset default, even at the default 1500 MTU. Is the field layout
documented somewhere?

[ ... ]

> @@ -3784,7 +3877,8 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (dev->mtu > MTK_PP_MAX_BUF_SIZE) {
> +	if (dev->mtu > MTK_PP_MAX_BUF_SIZE ||
> +	    mtk_rx_buf_len(eth) > MTK_PP_MAX_BUF_SIZE) {

[Severity: High]
Can this accept an XDP program that never runs?

mtk_rx_buf_len() recomputes the length from the current MTUs, but the
live rings were built from eth->rx_buf_len. mtk_change_mtu() allows a
shrink while DMA is running and leaves eth->rx_buf_len unchanged, so the
two values can differ.

On MT7988:

1. Set GMAC2 to MTU 9000 while it is down, then bring up GMAC2 and
   GMAC1. mtk_dma_init() sets eth->rx_buf_len to 9216, so
   ring->buf_size is larger than MTK_PP_MAX_BUF_SIZE and
   mtk_rx_alloc() creates no page_pool.

2. Run "ip link set <gmac2> mtu 1500" while it is running. The old 9000
   MTU still gives 9216, which is not larger than eth->rx_buf_len, so
   there is no -EBUSY and the rings stay at 9K.

3. Attach XDP to either netdev. dev->mtu is 1500 and mtk_rx_buf_len(eth)
   is 2048, so this check passes.

If the target is running, mtk_stop() returns early here, because the
other MAC still holds a reference:

	if (!refcount_dec_and_test(&eth->dma_refcnt))
		return 0;

mtk_open() then only does refcount_inc(). If the target is down,
nothing is reopened. Either way the rings are not rebuilt.

mtk_poll_rx() only calls mtk_xdp_run() inside if (ring->page_pool). So
every packet goes through build_skb() and up the stack while the program
shows as attached.

The commit message says this case is rejected "instead of letting a
program attach and never run". Should this check also look at
eth->rx_buf_len, or at whether the live rings have a page_pool?

[ ... ]

> @@ -4357,14 +4427,33 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
>  	int length = new_mtu + MTK_RX_ETH_HLEN;
>  	struct mtk_mac *mac = netdev_priv(dev);
>  	struct mtk_eth *eth = mac->hw;
> +	bool running;
> +	u32 rx_buf_len;
>  	int max_mtu, i;
>  
> +	/* The RX rings are shared by every MAC, so the buffer length follows
> +	 * the largest MTU of all of them, including the new one.
> +	 */
> +	max_mtu = mtk_max_gmac_mtu(eth);
> +	if (new_mtu > max_mtu)
> +		max_mtu = new_mtu;
> +	rx_buf_len = mtk_rx_buf_len_from_mtu(max_mtu);

[ ... ]

> +	running = refcount_read(&eth->dma_refcnt);
> +	if (running && rx_buf_len > eth->rx_buf_len)
> +		return -EBUSY;

[Severity: Low]
running comes from the DMA refcount that all MACs share, not from
whether this netdev is up.

On MT7988 boards where any other GMAC is up (for example a WAN port on
GMAC2 or GMAC3), raising the DSA conduit to a jumbo MTU returns -EBUSY,
even if the conduit itself is down. dsa_user_change_mtu() passes that
error back to the user port.

DSA brings the conduit up whenever a user port is up. Wouldn't raising a
user port MTU on a live system then always fail, so that 9K DSA only
works once every GMAC is down?

The commit message describes the -EBUSY rule, but not that it limits the
DSA flow it is meant to enable.

> +
>  	mtk_set_mcr_max_rx(mac, length);
>  	WRITE_ONCE(dev->mtu, new_mtu);
>  
> @@ -4372,6 +4461,11 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
>  	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
>  		mtk_ppe_update_mtu(eth->ppe[i], max_mtu);
>  
> +	if (!running) {
> +		eth->rx_buf_len = rx_buf_len;
> +		mtk_pdma_set_sdl(eth);
> +	}

[Severity: Low]
The comment in mtk_dma_init() says eth->rx_buf_len is "Derived here, at
ring allocation, so eth->rx_buf_len always describes the buffers the
rings actually hold". Here it is assigned while no rings exist.

rx_buf_len is also computed from mtk_max_gmac_mtu() before
WRITE_ONCE(dev->mtu, new_mtu), so this device's old MTU still counts.

For example, shrinking the only 9000 MTU device to 1500 while it is down
leaves eth->rx_buf_len at 9216 and the SDL programmed for 9216.
mtk_xdp_setup() computes 2048 from the new MTUs, so the two disagree
until the next mtk_dma_init() recomputes the value.

Should this use the new MTUs, or leave eth->rx_buf_len to mtk_dma_init()?

>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/patch-aad4cfa8d9522d1f7dbc9893ea12e813%40loljews.com
