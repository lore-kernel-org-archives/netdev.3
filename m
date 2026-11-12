Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527258;
	b=MIRdUEdMk/2ENUEc6h7HfBQi2IdvNC40A/6an3oRx01zBfTE42SGeyFVpV4jWk7dmvEX
	 fnl1uxgHhRjg4/wozPG1DzFeaLZzh6pIjqrBk4LyU+B4izVU1O7HqJM7u+h4/4NahBE6q
	 XWuc0IZNaxX0i5z787rtfLeBRH8elgLs/ifyWWIsd80512yO+ZIJOP7137zjoPktHXcOd
	 dMvCPHou2A4icRwezdFrjr2hgObPDnfQb/vH8N6hqOi7X8QgoxcJKjttNW4fXWYXz5N7k
	 DUm75p5wGNp4UEridTzj5WJDGhLUmV1TEGkYO0/yIe1Dsm7WjA5Iy/K7bhm3B2rl0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527258;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=W/o2ML2sA5Yx8bm0rnJCzuTd+aUYDtMZYPL1uTEwFLU=;
	b=C6mu2kswqzO37g6bKWDVN48aTBqS9KGEydhZaJIbIQZMEidN0o8DarQvPjj/OrlEnyDz
	 TpPk6NG4WN0JBjTZmnAfKzydSFvrpaLfGIQSHBqyhE4m8zGJYnKYcEZrfJBvLBMUHhRNo
	 MbqLo74hTOMt4jMHOHWEtzMRkjGDDy1PDtFjmR/1T0jCmDn2N7QYAtfiEzdDNhoqK//0c
	 hIye1wuY8etukOeVF0QpvUvNVRRRbFHVhlIhjj61Ldfess0+hIWrfMiK5FpAGP77/7qDH
	 3c5/kBMmqRJ0eHViBgXw95NbgdroSTFu+U40TqPyYBlfk4EsPb5qQGJrmWrSGqOsUCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXjY58Zw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0A606A336;
	Thu, 12 Nov 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXjY58Zw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FEB1F000C4;
	Thu, 12 Nov 2026 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527258;
	bh=W/o2ML2sA5Yx8bm0rnJCzuTd+aUYDtMZYPL1uTEwFLU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oXjY58ZwDdAvoPY5W8yPU3vAkrAyx0m9Dh7jF5bWqephZVmqzUqbCBipYHF5/fmmC
	 chcDOPeYgCRxKkTrlPa0lOGhHSkK2KyMIyEfFk60YIqxAWAN6iprFkDwwB2aObgO+c
	 vAlYmLHx8cg2cG/L6tl1PbalaMfIr8CSfpCEPx8STivT2+Ufk1VQ1mvVPLmiaZFV22
	 ++EgiZVgOfs/5X1L43u/Hq5VF68zNvPqQ4JpsRj8MKH1nXpECmuOC5eOeETB74SA/1
	 U717HVvxEtVEWmB/bVzvOmW58CTyDK4D+lVR9KnGKatyUjjMA/YZG+mxbN6Itzqtb2
	 Snr+dLZiUXPUA==
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: mtk_eth_soc: add 9K jumbo
From: netdev-bot+sashiko@kernel.org
To: sandeeph@loljews.com
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 mason-cw.chang@mediatek.com, frank-w@public-files.de,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 23:47:36 +0000
Message-ID: <179452725692.2199510.7733814065763991670@kernel.org>
In-Reply-To: <patch-271a13eac7135a653a78c355e66438ab@loljews.com>
References: <patch-271a13eac7135a653a78c355e66438ab@loljews.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 6 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The shared RX length leaves no room for an 802.1Q tag at 1 KiB
  boundaries, including the advertised max_mtu.
- [Medium] GMAC1 (the built-in switch port and DSA conduit on MT7988)
  advertises max_mtu = 9198, but the only receive limit the driver can…
- [Medium] The unpolled QDMA RX ring is now filled with jumbo-sized
  buffers.
- [Medium] Possible kernel memory exposure (speculative).
- [Medium] The PDMA RX max-frame (SDL) field may now be set 12 KiB above
  the posted buffer size (speculative).
- [Medium] net: mtk_eth_soc: mtk_xdp_setup() rejects XDP detach when MTU
  is jumbo
- [Low] The commit message hides a behaviour change on other SoCs and
  gets the buffer sizes wrong.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but on the first
  open, a failure while filling an RX ring leaks the buffers and frees…

--

net: ethernet: mtk_eth_soc: add 9K jumbo

This adds an MTK_NETSYS_RX_9K capability for MT7988. With it, the XGMII
MACs advertise a 9K max_mtu and the shared RX rings are sized from the
largest MTU of any MAC. The PDMA RX SDL field and the XMAC_RX_CFG2 / MCR
max-rx limits are programmed from that shared length, and larger-buffer MTU
changes are rejected while DMA is running.

Link: https://github.com/frank-w/BPI-Router-Linux/commit/b4c6cb1d5532
Link: https://github.com/mediatek/mtk-openwrt-feeds

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 6768ab8ebe4aa..527fdaeec50f8 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

[ ... ]

> @@ -2313,10 +2375,15 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				skb_metadata_set(skb, metasize);
>  			skb_mark_for_recycle(skb);
>  		} else {
> +			unsigned int alloc_size = ring->frag_size > PAGE_SIZE ?
> +				mtk_buf_alloc_size(ring->frag_size) :
> +				ring->frag_size;
> +

[Severity: Low]
This also changes the HWLRO rings on SoCs that don't have MTK_NETSYS_RX_9K.
On mt2701, mt7622, mt7623 and mt7629 the LRO rings use rx_data_len =
MTK_MAX_LRO_RX_LENGTH (12288). Their frag_size is therefore above PAGE_SIZE,
and alloc_size becomes 16384 instead of roughly 12.7 KiB.

Those LRO skbs get a larger truesize, and skb_shared_info moves to the end
of the order-2 page. The commit message says the other SoCs are left as
before and links the truesize change only to large MTUs. Should this change
be mentioned there?

The buffer sizes in the commit message also don't seem to match:

  Once any MAC's MTU needs more than ~3.5K, every RX buffer is a 16 KiB
  compound page

On arm64, NET_SKB_PAD is 64 and NET_IP_ALIGN is 0. With those values,
frag_size first goes above PAGE_SIZE at rx_buf_len = 4096, which is any MTU
above 3054.

For rx_buf_len 4096 to 7168 (MTU 3055-7150), get_order() gives order-1
(8 KiB) buffers. Only rx_buf_len 8192 and up (MTU 7151 and up) gives 16 KiB
buffers.

>  			if (ring->frag_size <= PAGE_SIZE)
>  				new_data = napi_alloc_frag(ring->frag_size);
>  			else
> -				new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
> +				new_data = mtk_max_buf_alloc(ring->frag_size,
> +							     GFP_ATOMIC);
>  
>  			if (unlikely(!new_data)) {
>  				netdev->stats.rx_dropped++;
> @@ -2339,7 +2406,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
>  					 ring->buf_size, DMA_FROM_DEVICE);
>  
> -			skb = build_skb(data, ring->frag_size);
> +			skb = build_skb(data, alloc_size);

[Severity: Medium]
Could this let the skb include memory the DMA engine never wrote?

Before this change, the tailroom left after skb_reserve(NET_SKB_PAD +
NET_IP_ALIGN) was exactly ring->buf_size, which is the DMA-mapped region.
For a 9K ring (buf_size 9216 in a 16 KiB allocation) it is now about 16000
bytes.

A little further down, pktlen comes from the descriptor and goes straight
into skb_put():

	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
	skb_put(skb, pktlen);

Nothing checks pktlen against ring->buf_size. If the hardware ever reports
a PLEN0 larger than the posted buffer, the old code hit skb_over_panic().
The new code would instead pass several KB of stale memory from
__get_free_pages() (no __GFP_ZERO) into the stack.

The new PDMA SDL write makes this harder to rule out; see the comment on
mtk_pdma_set_sdl() below.

Would it make sense to drop descriptors with pktlen > ring->buf_size before
skb_put()? Another option is to keep build_skb() at frag_size and account
for truesize separately.

[ ... ]

> @@ -2818,8 +2885,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  		rx_dma_size = soc->rx.dma_size;
>  	}
>  
> -	ring->frag_size = mtk_max_frag_size(rx_data_len);
> -	ring->buf_size = mtk_max_buf_size(ring->frag_size);
> +	ring->frag_size = mtk_max_frag_size(eth, rx_data_len);
> +	ring->buf_size = mtk_max_buf_size(eth, ring->frag_size);

[Severity: Medium]
This sizing also applies to eth->rx_ring_qdma. On MT7988 (MTK_QDMA),
mtk_dma_init() allocates that ring with soc->rx.dma_size = 2048 entries.

As far as I can tell, that ring is only used in mtk_rx_alloc() and
mtk_rx_clean(). mtk_poll_rx() only takes rings from mtk_get_rx_ring(), and
that returns eth->rx_ring[].

Once any MAC MTU is above about 7150, is each of those 2048 entries an
order-2 16 KiB page from mtk_max_buf_alloc(..., GFP_KERNEL)? That would pin
about 32 MiB for a ring the CPU never reads or refills, compared with about
5 MiB of page frags before. It also doubles the number of high-order
allocations at open.

Could the QDMA RX ring stay at a fixed 2K buffer length, with the WARN_ON in
mtk_max_buf_size() relaxed for it?

>  	ring->data = kcalloc(rx_dma_size, sizeof(*ring->data),
>  			     GFP_KERNEL);
>  	if (!ring->data)
> @@ -2864,7 +2931,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  			if (ring->frag_size <= PAGE_SIZE)
>  				data = netdev_alloc_frag(ring->frag_size);
>  			else
> -				data = mtk_max_lro_buf_alloc(GFP_KERNEL);
> +				data = mtk_max_buf_alloc(ring->frag_size,
> +							 GFP_KERNEL);
>  
>  			if (!data)
>  				return -ENOMEM;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. What
happens to the entries that were already filled when this return is taken on
the first open?

eth comes from devm_kzalloc(), and mtk_rx_alloc() only sets ring->dma_size
after the fill loop:

	ring->dma_size = rx_dma_size;

On a partial fill (an allocation failure or a dma_mapping_error()), the
cleanup runs with ring->dma_size == 0:

mtk_start_dma()
  mtk_dma_free()
    mtk_rx_clean()

The buffer loop in mtk_rx_clean() visits nothing, so the filled buffers and
their DMA mappings leak. It then calls:

	mtk_dma_ring_free(eth, ring->dma_size * eth->soc->rx.desc_size,
			  ring->dma, ring->phys, in_sram);

That frees the descriptor ring with size 0. For a non-SRAM ring the path is:

dma_free_coherent(dev, 0, ...)
  dma_direct_free()
    dma_free_contiguous()
      __free_pages(page, get_order(0))

Here the page is outside CMA. At runtime, get_order(0) is 52 on 64-bit with
4K pages. Can that corrupt the buddy allocator?

For rx_ring[0] in SRAM the call becomes gen_pool_free(pool, addr, 0), which
looks like it leaks the SRAM block permanently.

This patch adds GFP_KERNEL order-1 and order-2 allocations to this path for
the MT7988 jumbo rings, so the path stays reachable. Would setting
ring->dma_size (or a fill count) before the loop, or unwinding inside
mtk_rx_alloc(), avoid this?

[ ... ]

> @@ -3260,6 +3328,56 @@ static int mtk_dma_busy_wait(struct mtk_eth *eth)
>  	return ret;
>  }
>  

[ ... ]

> +static u32 mtk_rx_buf_len_from_mtu(int max_mtu)
> +{
> +	int length = max_mtu + MTK_RX_ETH_HLEN;
> +
> +	if (length <= MTK_MAX_RX_LENGTH_2K)
> +		return MTK_MAX_RX_LENGTH_2K;
> +
> +	return DIV_ROUND_UP(length, 1024) * 1024;
> +}

[Severity: Medium]
Is there room for an 802.1Q tag here? MTK_RX_ETH_HLEN is ETH_HLEN +
ETH_FCS_LEN (18 bytes) and does not include VLAN_HLEN. This one value sets
the ring buf_size, the PDMA SDL field and XMAC_RX_CFG2.

On MT7988 (arm64, NET_IP_ALIGN 0, NET_SKB_PAD 64), mtk_max_buf_size()
returns exactly rx_buf_len, so the descriptor has no slack either.

A full-size tagged frame is mtu + 22 bytes. That exceeds every limit when
(mtu + 18) mod 1024 is 0, 1021, 1022 or 1023. Examples are MTU 3051-3054,
4075-4078, ..., 9195-9198.

That range includes the max_mtu now advertised in mtk_add_mac():

	eth->netdev[id]->max_mtu =
		MTK_MAX_RX_LENGTH_9K - MTK_RX_ETH_HLEN;

MTU 9198 gives rx_buf_len 9216, but a tagged frame at that MTU is 9220
bytes.

The commit message says XMAC_RX_CFG2 is programmed "so 802.1Q-tagged frames
fit at any MTU". That doesn't seem to hold at these MTUs.
mtk_ppe_update_mtu() already adds VLAN_HLEN per tag for the same reason.

Should the length be derived from mtu + VLAN_ETH_HLEN + ETH_FCS_LEN, or
VLAN_HLEN added before rounding, with max_mtu lowered to match?

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
> +}

[Severity: Medium]
Has the offset encoding of this field been confirmed? MTK_PDMA_LRO_SDL was
unused before this patch. Its value, 0x3000 (12288), equals
MTK_MAX_LRO_RX_LENGTH, which suggests it is the LRO segment length in bytes
rather than an offset.

If the SDL field is a plain byte length, a stock MTU 1500 system gets
0x3800 (14336) while its ring buffers are 2048 bytes, and a 9K setup gets
0x5400. The DMA engine would then no longer limit frames to ring->buf_size.

mtk_poll_rx() doesn't handle frames that span several descriptors, and it
doesn't check pktlen against buf_size before skb_put(). The commit message
also notes that the GMAC1 MAC limit may not be enforced.

The "~1518" reset default in the commit message would be a register value of
0x35EE under the offset reading and 0x05EE under a plain-length reading.

There is also the field width. If the field is narrower than the 15 bits
that GENMASK(30, 16) assumes, 0x5400 sets register bit 30.

Hardware testing alone wouldn't catch a wrong encoding, because any value of
9216 or more lets 9K frames through. Can the register definition be
confirmed? Would programming rx_buf_len or ring->buf_size directly be more
appropriate?

[ ... ]

> @@ -5021,8 +5170,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
>  	eth->netdev[id]->irq = eth->irq[MTK_FE_IRQ_SHARED];
>  	eth->netdev[id]->dev.of_node = np;
>  

[ ... ]

>  	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
>  		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN;
> +	else if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K) &&
> +		 mtk_interface_mode_is_xgmii(eth, phy_mode))
> +		eth->netdev[id]->max_mtu =
> +			MTK_MAX_RX_LENGTH_9K - MTK_RX_ETH_HLEN;

[Severity: Medium]
Does this also give GMAC1 a max_mtu of 9198? On netsys v3,
mtk_interface_mode_is_xgmii() returns true for PHY_INTERFACE_MODE_INTERNAL.
That is the only interface GMAC1 supports on MT7988.

mtk_set_mcr_max_rx() always sends GMAC1 down the MCR bucket path:

	if (!mtk_interface_mode_is_xgmii(eth, mac->interface) ||
	    mac->id == MTK_GMAC1_ID) {
		...
		else
			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_2048);

MAC_MCR_MAX_RX_MASK is GENMASK(25, 24), so 2048 is the largest limit it can
program.

If the internal switch path enforces this field, frames above 2048 bytes
sent to the CPU through the DSA conduit are dropped, and 9K on the DSA user
ports doesn't work. If it doesn't enforce it, the GMAC1 MCR programming in
mtk_mac_config(), mtk_hw_init() and mtk_change_mtu() has no effect.

Should GMAC1's max_mtu be capped to what the driver can program, or can
enforcement be confirmed on hardware before this is merged?

>  	else
>  		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;
>  

[ ... ]

> @@ -3788,12 +3906,26 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (dev->mtu > MTK_PP_MAX_BUF_SIZE) {
> +	need_update = !!eth->prog != !!prog;
> +
> +	/* XDP only runs on rings that have a page_pool, and the pool is
> +	 * only created when the shared RX buffer length fits
> +	 * MTK_PP_MAX_BUF_SIZE.  eth->rx_buf_len describes the live rings;
> +	 * when the rings are not live, or this operation tears them down,
> +	 * the next open re-derives it from the current MTUs, so check
> +	 * that value instead.
> +	 */
> +	rx_buf_len = eth->rx_buf_len;
> +	if (!refcount_read(&eth->dma_refcnt) ||
> +	    (netif_running(dev) && need_update &&
> +	     refcount_read(&eth->dma_refcnt) == 1))
> +		rx_buf_len = mtk_rx_buf_len(eth);
> +
> +	if (rx_buf_len > MTK_PP_MAX_BUF_SIZE) {
>  		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
>  		return -EOPNOTSUPP;
>  	}
>  
> -	need_update = !!eth->prog != !!prog;
>  	if (netif_running(dev) && need_update)
>  		mtk_stop(dev);
>  

[Severity: Medium]
Should this check be skipped when prog is NULL? As written it also
runs on a detach, and a detach does not need a page_pool at all.

eth->prog is a single pointer shared by every MAC on the mtk_eth.
The core, by contrast, tracks the attached program per net_device in
dev->xdp_state.

Take an MT7988 with programs attached to both eth0 and eth1.
Detaching from eth0 clears eth->prog, but the core still records
eth1's program or bpf_xdp_link. With eth->prog NULL, the XDP check in
mtk_change_mtu() no longer fires. While DMA is down, eth1's MTU can
then be raised to 9000, and mtk_rx_buf_len() returns 9216.

A later detach on eth1 reaches this check with prog == NULL. It picks
up rx_buf_len = 9216, either from mtk_rx_buf_len() with the rings
down or from eth->rx_buf_len once they were rebuilt at the jumbo
size. The detach then fails with -EOPNOTSUPP.

>From netlink, that leaves the administrator unable to remove the
program. The other callers are worse. dev_xdp_uninstall() runs at
unregister, and dev_xdp_detach_link() runs when the link is closed.
Both wrap dev_xdp_install() in WARN_ON(), so the failure warns and
leaves the core state out of sync with the driver.

Before this patch max_mtu was at most 2030, so the old dev->mtu check
could not fail. The 9K max_mtu is what makes this reachable.

Would it be enough to apply the size check only when prog is
non-NULL? The check in mtk_change_mtu() looks only at eth->prog, not
at whether any netdev on this mtk_eth still has a program attached.
Should that be tightened here, or left to a separate fix of the
shared eth->prog handling?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/patch-fc08a7ef40667bf3017366e452e6d3c0%40loljews.com
