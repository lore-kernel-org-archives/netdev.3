Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088833;
	b=mqvyfpOLtNOTIRpCDZYuyvcoiBql9uIcm47aRC1h2ebmhFhyTOIsTMYKubRNxALPhYDs
	 NHZ0r47A3ge3k5xEnfFBoibou7W4fika4jsH9GfU5zjq80bBqQkUfMD1Y4aFxR47MvLT3
	 AiZyjCDS+43Mptgx3EVQdLYDy7PPIWk+eXGr5uA1JEZ3Uuf2GHcpT75ySo79D8iULWyWr
	 KeKodOSQGw89dMo2STQexLzJx70Z4Jdyfi44W6BOwPbaUu7LraDbmgpQfZOCn90bOXYSx
	 PCndDwk1EDB7WU8H8xnKXATKsd5KS9j/3DA9XDJmGZ+XuGQyQHYIcZ+KDNCXZPSnmgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088833;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QaioE7WJx6HqzbXk//5g/Hdq+H63H7gKI1NMPIdYlu4=;
	b=HxvoZmRqUOnPEyC3yUQCZ5T43KI1PV1Ngs+wHtzQObvp51dT4wHNrm7VMy0RzyvDdWIW
	 0BKpH7ifCGIfUsFcjj4Ru9anRO0Guts8I6Y4OfpM6brxACXsqo5t4x5oxMyxkrt93TWF6
	 hYiMGB1tfThLrfHEx09Sg6Z4sSCnhm281jz3Trw0l73IJJ9SQsE2JV61oblF2Thld1wtD
	 AbsVDcQx7uXd1SV1Agm9ITyKcAhbs6BUP2hsOTLGF+lvFwuHT+Fw1xind7/XpaZuayFIc
	 5uKvQ7WF0zV6bF1R43HD3vOMk0UqGQVJI4LnhRuRoSn8IGqhm0sYabJbFsKjdbv/ODA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxw1n2J4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF2606A336;
	Sat,  7 Nov 2026 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxw1n2J4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4801F008A1;
	Sat,  7 Nov 2026 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088832;
	bh=QaioE7WJx6HqzbXk//5g/Hdq+H63H7gKI1NMPIdYlu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hxw1n2J4UUJ96b9ExhgHhMrhBM+SCTabqkUtusQHjcshqlpzSYixR9PShCYYbz8f4
	 i5FnE55zOaHB2upZjI0iz2/ZlJMkYds65cGBNd6C+P8MPiH+2uvE5qZDX1SZXPh6nT
	 4Wf2J310hyQYfIgYZbO0zu3seB1Ku0l5J4Xpq3RlFOAbVpCWQenTGBSpZjDVsum2+9
	 pHBcrtSK7+uiU/4ykWU5sEY98XyNksHgVtcZxyyjmnHXaXGmtXm/3O3pXfrcsCsRvr
	 VvRCoahCFlZCkFlWlHio2JkMYdE26wTVTlv1CEvTdO2ohp6YsPVfx0bqqef2RgYn2k
	 iRavK+WTyD0bg==
Subject: Re: [PATCH net-next v2 2/2] net: ethernet: mtk_eth_soc: add 9K jumbo
From: netdev-bot+sashiko@kernel.org
To: sandeeph@loljews.com
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 mason-cw.chang@mediatek.com, frank-w@public-files.de,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 22:00:30 +0000
Message-ID: <179408883078.994134.17583422873503660321@kernel.org>
In-Reply-To: <patch-cb77640ba129138f860134f54fa345aa@loljews.com>
References: <patch-cb77640ba129138f860134f54fa345aa@loljews.com>
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

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 8 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] An XDP program can attach successfully and then never run.
- [Medium] This regression hits every SoC, not just MT7988, and the
  commit message does not say so.
- [Medium] The patch removes MT7628's max_mtu limit.
- [Medium] Two statements in the commit message do not match the code.
- [Medium] The PDMA RX SDL field in pdma.rx_cfg (0x6a10 on MT7988) is
  written as `mtk_w32(eth, val | ((MTK_PDMA_LRO_SDL + eth->rx_buf_len)…
- [Medium] The code breaks the invariant stated in the new mtk_dma_init()
  comment, that eth->rx_buf_len is derived at ring allocation "so ...…
- [Medium] While DMA is running, mtk_change_mtu() rejects any change
  whose computed rx_buf_len differs from eth->rx_buf_len (`!=`), not…
- [Medium] Once any MAC's MTU makes frag_size exceed PAGE_SIZE (MTU above
  ~3054 on MT7988), every RX ring is filled with high-order compound…
- [Medium] In the XGMII branch of mtk_set_mcr_max_rx(),
  MTK_XMAC_RX_CFG2(mac->id) is read into mcr_cur, but the new value is…
- [Low] The comment in mtk_rx_alloc() (lines 2861-2865) says large rings
  "take the netdev_alloc_frag()/mtk_max_lro_buf_alloc() path below" and…

--

net: ethernet: mtk_eth_soc: add 9K jumbo

This commit adds a MTK_NETSYS_RX_9K capability for MT7988. With it, the
XGMII MACs advertise a 9K max_mtu, and the driver programs XMAC_RX_CFG2
and the PDMA RX SDL. The shared RX buffer length now comes from the
largest MTU of any MAC, and runtime MTU changes that need a different
buffer size are rejected while DMA is running.

Link: https://github.com/frank-w/BPI-Router-Linux/commit/b4c6cb1d5532
Link: https://github.com/mediatek/mtk-openwrt-feeds

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 29370376f0322..38d402c5ead73 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

[ ... ]

> @@ -554,6 +555,43 @@ static int mtk_mac_prepare(struct phylink_config *config, unsigned int mode,
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
> +		mcr_cur = mtk_r32(mac->hw, MTK_XMAC_RX_CFG2(mac->id));
> +
> +		if (val < MTK_MAX_RX_LENGTH_9K)
> +			mcr_new = FIELD_PREP(MTK_XMAC_MAX_RX_MASK, val);
> +		else
> +			mcr_new = MTK_MAX_RX_LENGTH_9K;

[Severity: Medium]
Does this clear the rest of XMAC_RX_CFG2? The code reads mcr_cur, but it
builds mcr_new from the length field alone. Any bits outside
MTK_XMAC_MAX_RX_MASK (GENMASK(13, 0)) are written back as zero.

The GMAC branch above keeps the other bits with
mcr_cur & ~MAC_MCR_MAX_RX_MASK. Should the XGMII branch do the same?

This branch runs on the GMAC2/GMAC3 XGMII MACs from three places:
mtk_mac_config() on an interface change, mtk_change_mtu(), and
mtk_hw_init() after a reset. If the upper bits hold non-zero defaults,
the mcr_new != mcr_cur check will also trigger a write every time.

> +
> +		if (mcr_new != mcr_cur)
> +			mtk_w32(mac->hw, mcr_new, MTK_XMAC_RX_CFG2(mac->id));
> +	}
> +}
> +
>  static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
>  			   const struct phylink_link_state *state)
>  {
> @@ -647,6 +685,7 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
>  		regmap_write(eth->ethsys, ETHSYS_SYSCFG0, val);
>  
>  		mac->interface = state->interface;
> +		mtk_set_mcr_max_rx(mac, eth->rx_buf_len);
>  	}

[Severity: Medium]
Can a MAC end up accepting frames larger than the RX ring buffers here?

This call is inside the if (mac->interface != state->interface) block.
mac->interface is not reset on close, so the call only runs on the first
mac_config for a given interface mode.

Take two MACs, A and B:

  A at MTU 9000 (or 2000 on MT7621), B at MTU 1500
  open both: mtk_dma_init() sets rx_buf_len to 9216 (or 2048), and
             mtk_mac_config(B) programs B's limit to 9216 (or MAX_RX_2048)
  close both
  set A's MTU to 1500: dma_refcnt is 0, so this is allowed, and only
             A's MAC is reprogrammed
  reopen: mtk_dma_init() recomputes rx_buf_len as 1536 and the rings
          shrink, but mtk_mac_config(B) skips this call because the
          interface did not change

B's MAC would still accept 9216 or 2048 byte frames into 1536 byte
buffers. That seems to contradict the new comment in mtk_dma_init():

    /* Derived here, at ring allocation, so eth->rx_buf_len always describes
     * the buffers the rings actually hold and mtk_mac_config() never lets
     * a MAC accept a frame the rings cannot take.
     */

Before this patch the buffers were always at least 2048 bytes, which
covered the largest MAC limit. The driver can't show what the PDMA does
with a frame longer than PLEN0, and mtk_poll_rx() has no handling for
frames that span multiple descriptors.

[ ... ]

> @@ -1280,9 +1319,8 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
>  	return true;
>  }
>  
> -static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
> +static void *mtk_max_buf_alloc(unsigned int size, gfp_t gfp_mask)
>  {

[Severity: Low]
This isn't a bug, but the comment above the page_pool check in
mtk_rx_alloc() still uses the old name and treats 9K jumbo as a future
case:

	/* page_pool hands out order-0 pages and the pool is created with
	 * MTK_PP_MAX_BUF_SIZE, so only rings whose buffers fit in a page can
	 * use it.  The larger rings (HW-LRO, and 9K jumbo once enabled) take
	 * the netdev_alloc_frag()/mtk_max_lro_buf_alloc() path below.
	 */

Should it be updated now that this patch renames the helper to
mtk_max_buf_alloc() and enables MTK_NETSYS_RX_9K for MT7988?

[ ... ]

> @@ -2812,8 +2851,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  		rx_dma_size = soc->rx.dma_size;
>  	}
>  
> -	ring->frag_size = mtk_max_frag_size(rx_data_len);
> -	ring->buf_size = mtk_max_buf_size(ring->frag_size);
> +	ring->frag_size = mtk_max_frag_size(eth, rx_data_len);
> +	ring->buf_size = mtk_max_buf_size(eth, ring->frag_size);

[Severity: High]
Can an attached XDP program silently stop running once frag_size grows
past PAGE_SIZE?

The normal ring's frag_size now follows eth->rx_buf_len. A page_pool is
only created when the buffer fits in a page:

	if (mtk_page_pool_enabled(eth) && ring->frag_size <= PAGE_SIZE) {

mtk_poll_rx() only calls mtk_xdp_run() inside the if (ring->page_pool)
branch. Without a page_pool, every packet goes to napi_gro_receive() and
the program never sees it.

The XDP admission checks only look at the MTU of a single device:

mtk_xdp_setup():
	if (dev->mtu > MTK_PP_MAX_BUF_SIZE) {
		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
		return -EOPNOTSUPP;
	}

mtk_change_mtu():
	if (rcu_access_pointer(eth->prog) &&
	    length > MTK_PP_MAX_BUF_SIZE) {

On MT7988 there seem to be two ways to reach this:

1) GMAC1 (the DSA conduit, max_mtu 9198) is at MTU 9000, so rx_buf_len
   is 9216 and frag_size is around 9.6K. Attaching XDP to another MAC
   with MTU 1500 succeeds, but the program never runs on any MAC.

2) With XDP attached and the interfaces down, an MTU of 3055..3502
   passes the MTK_PP_MAX_BUF_SIZE check. The 1K rounding then gives
   rx_buf_len 4096 and frag_size around 4.5K, so the next open builds
   the rings without a page_pool.

Before this patch the normal ring's frag_size was always around 2.4K, so
page_pool, and therefore XDP, was always active on netsys v2 and later.
Should the XDP checks use the shared rx_buf_len instead of the MTU of
one device?

[ ... ]

> @@ -2857,7 +2896,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  			if (ring->frag_size <= PAGE_SIZE)
>  				data = netdev_alloc_frag(ring->frag_size);
>  			else
> -				data = mtk_max_lro_buf_alloc(GFP_KERNEL);
> +				data = mtk_max_buf_alloc(ring->frag_size,
> +							 GFP_KERNEL);

[Severity: Medium]
Is this memory cost intended when only one MAC uses a jumbo MTU?

Once frag_size exceeds PAGE_SIZE (MTU above roughly 3054 on MT7988),
every RX ring is filled from mtk_max_buf_alloc(). That includes
rx_ring_qdma, which mtk_get_rx_ring() never returns and NAPI never polls.

At rx_buf_len 9216, frag_size is around 9.6K, so each slot is an order-2
allocation (16 KiB). rx_ring_qdma and rx_ring[0] each have 2048 entries
(rx.dma_size), so about 64 MiB stays pinned while DMA is up. Around half
of that sits in the unused QDMA ring. Before this patch it was about
16 MiB of order-0 page_pool pages.

The refill in mtk_poll_rx() also becomes an order-2 GFP_ATOMIC
allocation for every packet:

	new_data = mtk_max_buf_alloc(ring->frag_size,
				     GFP_ATOMIC);

__GFP_NOWARN is set, so when memory is fragmented these allocations fail
without a warning and the packets are counted in rx_dropped. The
GFP_KERNEL fill at open can fail with -ENOMEM for the same reason.

[ ... ]

> @@ -3253,6 +3293,35 @@ static int mtk_dma_busy_wait(struct mtk_eth *eth)

[ ... ]

> +static u32 mtk_rx_buf_len_from_mtu(int max_mtu)
> +{
> +	int length = max_mtu + MTK_RX_ETH_HLEN;
> +
> +	if (length <= MTK_MAX_RX_LENGTH)
> +		return MTK_MAX_RX_LENGTH;

[Severity: Medium]
Does this change behaviour on every SoC, not just MT7988?

At the default MTU of 1500 the length is 1518, so this returns
MTK_MAX_RX_LENGTH (1536). mtk_max_frag_size() now uses that as the
buffer floor instead of the fixed MTK_MAX_RX_LENGTH_2K. All rings on
MT7621/7622/7623/7629/7981/7986 shrink from 2048 to 1536.

mtk_change_mtu() also gains this check:

	if (refcount_read(&eth->dma_refcnt) && rx_buf_len != eth->rx_buf_len)
		return -EBUSY;

Together, these make any runtime MTU change that needs a frame above
1536 bytes (MTU 1519..2030) fail with -EBUSY while any MAC is up. For
example, MTU 1600 gives length 1618 and rx_buf_len 2048. Those changes
were accepted before.

With DSA, dsa_user_change_mtu() raises the conduit MTU with
dev_set_mtu() and rolls back on failure. Raising a user port from 1500
to 1520 (conduit 1524, length 1542) on MT7621 with MT7530 would now fail
while the conduit is up.

The commit message describes this as an MT7988 jumbo feature. Should it
mention the smaller default buffer on the other SoCs, or should those
SoCs keep the 2K floor?

> +
> +	return DIV_ROUND_UP(length, 1024) * 1024;
> +}

[ ... ]

> @@ -3304,6 +3379,17 @@ static int mtk_dma_init(struct mtk_eth *eth)
>  		mtk_w32(eth, 0x0, eth->soc->reg_map->qdma.hred);
>  	}
>  
> +	/* Program the PDMA max RX frame (SDL) from rx_buf_len so jumbo
> +	 * frames up to it are accepted by the DMA engine.
> +	 */
> +	if (mtk_is_netsys_v3_or_greater(eth)) {
> +		u32 val = mtk_r32(eth, eth->soc->reg_map->pdma.rx_cfg);
> +
> +		mtk_w32(eth, val | ((MTK_PDMA_LRO_SDL + eth->rx_buf_len) <<
> +			MTK_RX_CFG_SDL_OFFSET),
> +			eth->soc->reg_map->pdma.rx_cfg);

[Severity: Medium]
Should the SDL field be cleared before the new value is ORed in?

The frame engine is only reset at probe and in error recovery, not on
close/open. mtk_dma_init() runs on every first open, and mtk_change_mtu()
does the same write on every MTU change. So the field holds the OR of
every value written and can only grow:

  open at MTU 1500:            0x3000 + 1536 = 0x3600
  close, set MTU 9000, reopen: 0x3600 | 0x5400 = 0x7600
  set MTU 1500 again:          stays 0x7600

A 1536 to 2048 change likewise gives 0x3600 | 0x3800 = 0x3e00.

There is also no field mask to go with MTK_PDMA_LRO_SDL and
MTK_RX_CFG_SDL_OFFSET. 0x3000 + 9216 = 0x5400 needs 15 bits. If the
field is narrower than that, does the shift by 16 set bit 30, which
belongs to another control field?

mtk_poll_rx() assumes one frame per descriptor. Could a DMA frame limit
that doesn't match buf_size cause the hardware to split frames?

[ ... ]

> @@ -4362,6 +4415,17 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
>  		return -EINVAL;
>  	}
>  
> +	/* The RX rings are shared and cannot be resized in place while DMA is
> +	 * running.  Until the reallocation worker lands, reject a runtime MTU
> +	 * change that would need a different ring buffer size.
> +	 */
> +	max_mtu = mtk_max_gmac_mtu(eth);
> +	if (new_mtu > max_mtu)
> +		max_mtu = new_mtu;
> +	rx_buf_len = mtk_rx_buf_len_from_mtu(max_mtu);
> +	if (refcount_read(&eth->dma_refcnt) && rx_buf_len != eth->rx_buf_len)
> +		return -EBUSY;

[Severity: Medium]
Should this only reject changes that need larger buffers, that is
rx_buf_len > eth->rx_buf_len?

max_mtu includes this device's old MTU, so lowering the largest MTU is
allowed once and eth->rx_buf_len stays at the old ring size. After that,
smaller changes that would fit in the existing buffers fail:

  DMA running, A at 9000, rx_buf_len 9216
  A 9000 -> 1500: max_mtu 9000, 9216 == 9216, allowed
  A 1500 -> 1400: 1536 != 9216, -EBUSY
  B 1500 -> 2000: 2048 != 9216, -EBUSY

>From then on, no MTU can be lowered until every MAC is closed. DSA user
port MTU changes that propagate to the conduit fail the same way.

> +
>  	mtk_set_mcr_max_rx(mac, length);
>  	WRITE_ONCE(dev->mtu, new_mtu);

[Severity: Medium]
The commit message says:

  The RX rings and their buffers are sized for the largest MTU of any MAC,
  so the MTU limits of the MACs are now written from mtk_mac_config() and
  mtk_change_mtu() with eth->rx_buf_len rather than a fixed 2K.

Is that accurate? This call still passes the per-device length.
mtk_hw_init() also still uses the per-device MTU:

	mtk_set_mcr_max_rx(netdev_priv(dev),
			   dev->mtu + MTK_RX_ETH_HLEN);

Only mtk_mac_config() uses eth->rx_buf_len, so the MAC limit depends on
which of the three call sites ran last. The baseline never wrote a fixed
2K either: both earlier call sites used dev->mtu + MTK_RX_ETH_HLEN.

The commit message also lists "add dynamic rx buffer adjustment support"
as part of this forward-port. However, the comment above refers to a
reallocation worker that hasn't landed yet, and runtime changes return
-EBUSY. Could the commit message be updated to match the code?

[ ... ]

> @@ -5014,8 +5087,15 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
>  	eth->netdev[id]->irq = eth->irq[MTK_FE_IRQ_SHARED];
>  	eth->netdev[id]->dev.of_node = np;
>  
> -	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
> -		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN;
> +	/* DSA sets the conduit MTU (user MTU + tag) before the netdev is
> +	 * opened, so max_mtu must already be final here.  Deriving it only
> +	 * in mtk_open() leaves the conduit at its 1504 default and blocks
> +	 * 9K frames on the DSA user ports.
> +	 */
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K) &&
> +	    mtk_interface_mode_is_xgmii(eth, phy_mode))
> +		eth->netdev[id]->max_mtu =
> +			MTK_MAX_RX_LENGTH_9K - MTK_RX_ETH_HLEN;
>  	else
>  		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;

[Severity: Medium]
Was dropping the MT7628 case intended? MT7628 used to get max_mtu 1518
(MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN). Commit 4fd59792097a added that
limit on purpose ("MT762x HW, except for MT7628, supports frame length
up to 2048"). MT7628 now falls into the else branch and gets 2030.

Nothing else limits the frame size on MT7628. mtk_set_mcr_max_rx()
returns early for MTK_SOC_MT7628, and its RX descriptors are written as
RX_DMA_LSO with no PLEN0. With the interfaces down, mtk_change_mtu()
would now report success for MTUs 1519..2030 on hardware that cannot
receive frames above 1536 bytes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/patch-2793186c653124c4c0b3d463bde2ea3a%40loljews.com
