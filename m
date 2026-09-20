Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3194282F1E
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789918825; cv=none; b=cAe9hPzCom2v7WSIkSdeNZuzDjEQRQfizONtyV1wrjRY1JsG/p+ARdHgJR+ky+t5E+lGpUyXUROfjYqRYM/L+FptWm7BxRShMHckv4pxa7F0v75iepZu3/+H3HlpwpHZOryLIGNqc1HVSk1CGC/IayULmqYn37uqrrjH7tincO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789918825; c=relaxed/simple;
	bh=FAIdWrkjH+1qwmC4HE0u3EPWKuVqT87TcL1ARIieMF0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acSo1tZGRSq+g1e478U3bKZHmv2cUS9YHvzJwdsdzortfYa/JGzJZYpQCiuvz3ZWB2ZmJFb1Bmh/Bfa+SzdxFoQZw3CnaYiqI+jPiXmrP6+iaZUgT3apcg4E8+SPH/TWMIvoTOPBME4WQmdRz0BFb341KJWhbvRD00uUIU7Noyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX1gTT2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX1gTT2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAD81F000FF;
	Sun, 20 Sep 2026 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789918823;
	bh=2J25DW33pib1SsH3iQTO3cjeBEsm3iBnPIHhflbEbrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KX1gTT2MEy+l9dIOaWncsLwKQcdv7s8tC0Xn4LxRnDnBCMZakzBT1SRrs3QdCdHtR
	 bNpT8IZrkxvEIin8e/jshS2LLz/Mqu1ohj4pXtYSUAT1zOIpyOw2GrXMahBqF1K1Wr
	 LFvoK46WS+kfVKy0K4RR7i43ZMht99Fq1KOoXB3wCWggXAAGH2C9MJhyXWmEd11cvp
	 Ej2tVCh3xQhnNRwvoCLDBiPtjyORucmNZBwPW6EcBBKConfa/vjQ3K+UaBOs2byP5R
	 sVw4Uiy6YWl0QyrDagH8sG3q3E05BiZBamt/Y7OMn1h6bIm2K8zTZVTOPK0504UNM6
	 dhWgT9MtSQWjA==
Subject: Re: [PATCH net] net: stmmac: fix rx Scatter-Gather support
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Sun, 20 Sep 2026 15:40:22 +0000
Message-ID: <178991882229.2160803.15018709305891810820@kernel.org>
In-Reply-To: <20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com>
References: <20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 1 · High: 1 (1) · Medium: 6 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] stmmac_rx() strips the FCS with an unchecked unsigned
  subtraction (`buf2_len -= ETH_FCS_LEN` at stmmac_main.c:5803,…
- [High] The patch unconditionally allocates a secondary RX page and
  unconditionally reports a non-zero buffer2 length for every MAC core,…
- [Medium] The RX page pool is created with `pp_params.offset =
  stmmac_rx_offset(priv)` and `max_len = dma_conf->dma_buf_sz`, and only…
- [Medium] For GMAC4 without SPH, stmmac_rx_buf2_len() now assumes every
  intermediate descriptor's buffer2 is completely filled (returns…
- [Medium] The patch makes the secondary page-pool page mandatory for
  every RX descriptor on every stmmac device and configuration…
- [Medium] With a native XDP program attached, stmmac_xdp_set_prog()
  explicitly clears priv->sph_active, and this patch now arms buffer2…
- [Medium] The AF_XDP zero-copy refill path is left untouched:
  stmmac_rx_refill_zc() still calls `stmmac_set_desc_sec_addr(priv,…
- [Medium] The new length arithmetic depends on `priv->hw->rx_csum`,
  which stmmac_set_features() (stmmac_main.c:6210-6214) mutates from…
- [Low] The descriptor-position comments in the changed RX length helpers
  no longer describe the code.

Pre-existing issues:
- [High] In stmmac_rx(), when napi_build_skb() fails the code calls
  page_pool_recycle_direct(rx_q->page_pool, buf->page) and jumps to…

--

net: stmmac: fix rx Scatter-Gather support

The patch always allocates and programs the secondary RX buffer (sec_page)
instead of doing so only when split-header is active, so that a frame
overflowing buffer1 does not make the DMA write to an unmapped address.
stmmac_rx_buf1_len() and stmmac_rx_buf2_len() are adjusted to account for
buffer2 in the non-SPH case.

A few questions about the buffer2 accounting and the cores/paths that are
now affected.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..be7cb0cafeb50 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1659,17 +1659,14 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
>  		buf->page_offset = stmmac_rx_offset(priv);
>  	}
>  
> -	if (priv->sph_active && !buf->sec_page) {
> +	if (!buf->sec_page) {
>  		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>  		if (!buf->sec_page)
>  			return -ENOMEM;
>  
>  		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
> -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> -	} else {
> -		buf->sec_page = NULL;
> -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
>  	}
> +	stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);

[Severity: High]
Does the "always mark buffer2 as valid" part hold on the legacy cores?
Only dwmac4_descs.c and dwxgmac2_descs.c provide a set_sec_addr callback;
enh_desc_ops (dwmac1000) and ndesc_ops (dwmac100) do not, and the
dispatch macro silently skips an absent callback:

drivers/net/ethernet/stmicro/stmmac/hwif.h:stmmac_do_void_callback() {
	int __result = -EINVAL; \
	if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) { \
		(__priv)->hw->__module->__cname((__arg0), ##__args); \
	...
}

So on those cores buf->sec_addr is never handed to the hardware, and in
ring mode with 16 KiB buffers the hardware buffer2 is inside the primary
page anyway:

drivers/net/ethernet/stmicro/stmmac/ring_mode.c:refill_desc3() {
	if (priv->dma_conf.dma_buf_sz == BUF_SIZE_16KiB)
		p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
}

With the "!priv->sph_active" early return gone from stmmac_rx_buf2_len(),
buf2_len becomes non-zero on those cores too, and stmmac_rx() then does:

	if (buf2_len) {
		dma_sync_single_for_cpu(priv->device, buf->sec_addr,
					buf2_len, dma_dir);
		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
				buf->sec_page, 0, buf2_len,
				priv->dma_conf.dma_buf_sz);

Can this publish the contents of a page the DMA never wrote to the network
stack?  On dwmac1000/dwmac100 the intermediate descriptors of a scattered
frame are discarded by enh_desc_get_rx_status()/ndesc_get_rx_status(), so
the last descriptor is processed with len = 0 and its FL field is the total
frame length; a 3000-byte frame with dma_buf_sz = 2048 would give
buf1_len = 2048 and buf2_len = 952 out of the untouched sec_page.  For
larger jumbo frames buf2_len (plen - dma_buf_sz) can also exceed the
order-0 sec_page.  Should buffer2 be gated on the cores that can actually
program an independently mapped buffer2?

[Severity: Medium]
The secondary buffer is handed to the DMA at page offset 0, but the page
pool is only configured with offset 0 when SPH is active:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:__alloc_dma_rx_desc_resources() {
	pp_params.offset = stmmac_rx_offset(priv);
	pp_params.max_len = dma_conf->dma_buf_sz;

	if (priv->sph_active) {
		pp_params.offset = 0;
		pp_params.max_len += stmmac_rx_offset(priv);
	}
}

net/core/page_pool.c:__page_pool_dma_sync_for_device() {
	dma_sync_size = min(dma_sync_size, pool->p.max_len);
	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
				     dma_sync_size, pool->p.dma_dir);
}

With !sph_active the pool syncs from dma_addr + NET_SKB_PAD + NET_IP_ALIGN,
so the first bytes of every secondary page are given to the device without
a sync-for-device, both on first map and on recycle.  On a non-coherent
platform, can a dirty cache line in that prefix be written back over data
the device has already placed there?  The SPH path sets offset = 0 for
exactly this reason.

> @@ -5097,7 +5094,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  				break;
>  		}
>  
> -		if (priv->sph_active && !buf->sec_page) {
> +		if (!buf->sec_page) {
>  			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>  			if (!buf->sec_page)
>  				break;

[Severity: Medium]
This makes a second page-pool page mandatory for every RX descriptor on
every stmmac device, doubling the RX buffer footprint (order-2/order-3
pages for the 8/16 KiB bfsize cases), while pp_params.pool_size stays at
dma_conf->dma_rx_size, i.e. the recycle ring is now sized for half the
in-flight pages.

For MTU-conformant traffic dma_buf_sz is always above the MTU:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_set_bfsize() {
	if (mtu >= BUF_SIZE_8KiB)
		ret = BUF_SIZE_16KiB;
	...
	else
		ret = DEFAULT_BUFSIZE;
}

so buffer1 alone holds the frame and the second page is unused.  Could the
commit message state in which configuration an in-spec frame exceeds
dma_buf_sz, and mention the extra page per descriptor plus the pool_size
mismatch?

> @@ -5108,10 +5105,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
>  
>  		stmmac_set_desc_addr(priv, p, buf->addr);
> -		if (priv->sph_active)
> -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> -		else
> -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
> +		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
>  		stmmac_refill_desc3(priv, rx_q, p);

[Severity: Medium]
Native XDP always runs in the non-SPH mode that this patch now arms
buffer2 for:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
}

In stmmac_rx() the program only ever sees buffer1:

	xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
			 buf->page_offset, buf1_len, true);

and on a TX/redirect verdict the loop leaves before the buf2_len block:

	} else if (xdp_res & (STMMAC_XDP_TX |
			      STMMAC_XDP_REDIRECT)) {
		xdp_status |= xdp_res;
		buf->page = NULL;
		skb = NULL;
		count++;
		continue;
	}

XDP caps the configured MTU at ETH_DATA_LEN, but GMAC_CORE_INIT in
dwmac4.h contains GMAC_CONFIG_JE and XGMAC_CORE_INIT_RX programs
GPSL = XGMAC_JUMBO_LEN, so an oversized frame is still accepted and split.
Does this silently forward a truncated frame, and should the multi-buffer
case be rejected instead?

[Severity: Medium]
The AF_XDP zero-copy refill path is left as it was:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_refill_zc() {
	stmmac_set_desc_addr(priv, rx_desc, dma_addr);
	stmmac_set_desc_sec_addr(priv, rx_desc, 0, false);
}

but on XGMAC the validity argument is ignored and there is no BUF2V bit in
the RX read descriptor:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c:dwxgmac2_set_sec_addr() {
	p->des2 = cpu_to_le32(lower_32_bits(addr));
	p->des3 = cpu_to_le32(upper_32_bits(addr));
}

so buffer2 stays armed at DMA address 0 while RBSZ for a ZC queue is
xsk_pool_get_rx_frame_size() and GPSL is the jumbo limit.  Is the SMMU
translation fault quoted in the commit message still reachable on this
path?  The multi-descriptor rejection in stmmac_rx_zc() happens after the
DMA write.

> @@ -5160,7 +5154,7 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
>  	plen = stmmac_get_rx_frame_len(priv, p, coe);
>  
>  	/* First descriptor and last descriptor and not split header */
> -	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
> +	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
>  }

[Severity: Low]
This isn't a bug, but the descriptor-position comments here no longer
match the code.  The non-first-descriptor early return at the top of
stmmac_rx_buf1_len() is gated on priv->sph_active, so with non-SPH
scatter-gather a continuation descriptor (len != 0) falls through to the
branches commented "First descriptor, not last descriptor and not split
header" and "First descriptor and last descriptor and not split header",
while plen - len only makes sense for a continuation descriptor.

> @@ -5170,10 +5164,6 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  	int coe = priv->hw->rx_csum;
>  	unsigned int plen = 0;
>  
> -	/* Not split header, buffer is not available */
> -	if (!priv->sph_active)
> -		return 0;
> -

[Severity: Critical]
With this return gone, the last-descriptor path returns the exact
remainder plen - len, which can be 1, 2 or 3.  stmmac_rx() then strips the
FCS with an unchecked unsigned subtraction:

	/* ACS is disabled; strip manually. */
	if (likely(!(status & rx_not_ls))) {
		if (buf2_len) {
			buf2_len -= ETH_FCS_LEN;
			len -= ETH_FCS_LEN;
		} else if (buf1_len) {
			buf1_len -= ETH_FCS_LEN;
			len -= ETH_FCS_LEN;
		}
	}

and passes the result straight on:

	if (buf2_len) {
		dma_sync_single_for_cpu(priv->device, buf->sec_addr,
					buf2_len, dma_dir);
		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
				buf->sec_page, 0, buf2_len,
				priv->dma_conf.dma_buf_sz);

Can a frame that overflows a buffer boundary by 1..3 bytes wrap this?
GMAC_CORE_INIT in dwmac4.h sets GMAC_CONFIG_JE unconditionally, so with
MTU 1500 and dma_buf_sz = DEFAULT_BUFSIZE = 1536 a 1537-byte frame is
accepted and split as 1536 + 1.  On that first-and-last descriptor
stmmac_rx_buf1_len() returns min(1536, 1537 - 0) = 1536, then
stmmac_rx_buf2_len() returns 1537 - 1536 = 1, and 1 - 4 gives 0xfffffffd
being handed to dma_sync_single_for_cpu() and skb_add_rx_frag().  The
buf1_len branch is reachable the same way with frames of
2 * n * dma_buf_sz + 1..3 bytes, and stmmac_rx_zc() also subtracts
ETH_FCS_LEN from stmmac_rx_buf1_len() unconditionally.  Before this patch
the non-SPH path returned 0 here, and in SPH mode buffer1 ends at the
split header so the whole FCS always landed in buffer2.

>  	/* For GMAC4, when split header is enabled, in some rare cases, the
>  	 * hardware does not fill buf2 of the first descriptor with payload.
>  	 * Thus we cannot assume buf2 is always fully filled if it is not
> @@ -5188,8 +5178,9 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  	 * Thus 'plen - len' always gives the correct length of buf2.
>  	 */
>  
> -	/* Not GMAC4 and not last descriptor */
> -	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
> +	/* Not GMAC4, or non-SPH and not last descriptor */
> +	if ((priv->plat->core_type != DWMAC_CORE_GMAC4 || !priv->sph_active) &&
> +	    (status & rx_not_ls))
>  		return priv->dma_conf.dma_buf_sz;
>  
>  	/* GMAC4 or last descriptor */

[Severity: Medium]
For GMAC4 without SPH this now assumes every intermediate descriptor's
buffer2 is completely filled, discarding the accumulated-PL value that the
comment just above describes as always giving the correct length of buf2.

The fall-through has no len <= plen guard:

	plen = stmmac_get_rx_frame_len(priv, p, coe);

	return plen - len;

and stmmac_rx_buf1_len() clamps the same wrapped value with
min_t(unsigned int, dma_buf_sz, plen - len) rather than detecting the
inconsistency.  One way the assumption can break is the RBSZ field itself:
DMA_RBSZ_MASK is GENMASK(14, 1) in dwmac4_dma.h and cannot represent
BUF_SIZE_16KiB, so dwmac4_set_dma_bfsize() writes a truncated RBSZ while
the driver keeps assuming dma_buf_sz per buffer.  If an intermediate
buffer2 is short by even one byte, does the accumulated len exceed plen and
turn buf2_len into a multi-gigabyte fragment length?  Would a
plen > len ? plen - len : 0 form be safer here?

The commit message says the GMAC4 plus split-header path keeps the
accumulated payload semantics "since there an intermediate descriptor's
buffer2 can be only partially filled" - is there a databook statement that
this cannot happen for GMAC4 outside SPH mode?

[Severity: Medium]
Both helpers read priv->hw->rx_csum independently for the same descriptor
(int coe = priv->hw->rx_csum;) and feed it to stmmac_get_rx_frame_len(),
whose COE_TYPE1 path subtracts 2 from the descriptor frame length.  The
writer runs from process context with no synchronization against the RX
NAPI poll:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_set_features() {
	if (features & NETIF_F_RXCSUM)
		priv->hw->rx_csum = priv->plat->rx_coe;
	else
		priv->hw->rx_csum = 0;
	...
	stmmac_rx_ipc(priv, priv->hw);
}

If ethtool -K ethX rx off/on lands between the stmmac_rx_buf1_len() and
stmmac_rx_buf2_len() reads on type-1-COE hardware, plen in the second call
is 2 bytes smaller than the one used to accumulate len, so plen - len
wraps.  Before this patch the non-SPH path returned 0 here and buf1_len did
no subtraction, so the worst case was a 2-byte length inaccuracy.  Could
coe/plen be read once per descriptor?

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the RX
buffer lifecycle the patch reworks: in stmmac_rx() the napi_build_skb()
failure path releases the page without clearing buf->page:

	skb = napi_build_skb(page_address(buf->page),
			     rx_q->napi_skb_frag_size);
	if (!skb) {
		page_pool_recycle_direct(rx_q->page_pool,
					 buf->page);
		rx_dropped++;
		count++;
		goto drain_data;
	}

Every other consumption site in the function sets buf->page = NULL after
handing the page away.  With the stale pointer, stmmac_rx_refill() skips
the replacement allocation and programs the already-recycled page back
into the descriptor:

	if (!buf->page) {
		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);

and at teardown stmmac_free_rx_buffer() puts it a second time:

	page_pool_put_full_page(rx_q->page_pool, buf->page, false);
	buf->page = NULL;

Can this alias one page into two descriptors and underflow the page-pool
refcount?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f%40oss.qualcomm.com
