Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503683;
	b=K9aL9/hHGujf8FkQNNTTjDRn+GUVwkS8t4AxoehnbJE2Kk2cWjEYu8rnqeIJsqSVhfvd
	 SzcCgl8WqGmkrkpztK+FyaK/f/+pKPwVh5gEP5oszcI+fNFWtee86/dVJVWrnrCO/wdvY
	 /ilMyPSiPmiH/JUGlSp0BLPqfiZ4U21vdZ36DSEz1mQgfR4hQOsy4pFKQ2g6Ed189+hEn
	 W304XeK/pur0eaHGAZiKcoBdp3/RwWGkko9qtdvx3hUT4s9Y8ByDueuxSUYU2xUd0ATU3
	 F2TQ2tb0MshGRTbUWOnboT6fm75ZpgRkdbRIageCy8l/D6x6HEJhd0rxaWmn5+NTxJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503683;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sIJOpYI0tqH12KdllEGaWQJYe1GWhkDdyw/STcddpKo=;
	b=yixpWzHgl13c22OIbpa2bWCIMLCfLS9hw+jLmBelmAJdrNvyncLBd9IlGOQnf2LvZW/5
	 uYEhHqIx8gtAhUekJbyLS5lc0nHz65ckoTr9oKCjrAp7SAGangTUjCz4uWzfDG+jL9uJP
	 fSWbYH/JX2K7htZtwldIwDp0qpni5FnSXUFwlbvre07fMqTiY82150K7v56qdMnCJQCtD
	 aHsbcI4SOy6zRkm3f/UKE6BGnc7VdOK1RZ1Jis9OF/lNQ9u/VUxDBoWVZri3AZH3mIf/N
	 6F1RtzRNU5hdRGHB21/qTOZGgSVghE60ZbO7XHK0iMxBfcONdNrwJKAtT+eHBx4E/Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kv2x/vPG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D00606A891;
	Thu, 12 Nov 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kv2x/vPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CA41F000CA;
	Thu, 12 Nov 2026 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503683;
	bh=sIJOpYI0tqH12KdllEGaWQJYe1GWhkDdyw/STcddpKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kv2x/vPG3dP93Xn0Pt8n8/AF+47yHXHhwxZmYonj60EUdbF2I4hCPcWctyPubBFKw
	 9YCmNSREnwdwhmH9ifRrNsWl9T3HI+mRvfh9AOFb/t5eARPoHgI+2QFa3fX+RXuaZs
	 eaoOURJouW9OkL0uKsettGZj6XMs3J4mAszE1d/5yzSCVW0UM17TDVU74eDgIIJ2+7
	 6cVRSlOJ48zMaqncdI8nxRDCljLQuKL/L3i9YARqRuT5jKphjMTcjRBSGEB4hDu5Cv
	 LOmC4xjBrIMBKugdm49FdDPjLn5ea+BNI1kLL0K7/FQ781zNZf/tW3kDbviy6ucevt
	 4gtWWWjgymRhQ==
Subject:
 Re: [PATCH net 7/7] net: bcm4908_enet: drop RX frames longer than the buffer
From: netdev-bot+sashiko@kernel.org
To: kudzo51@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 17:14:42 +0000
Message-ID: <179450368206.2199510.1806851064431992107@kernel.org>
In-Reply-To: <20261109235700.2586821-8-kudzo51@gmail.com>
References: <20261109235700.2586821-8-kudzo51@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new check in bcm4908_enet_poll_rx()
  (drivers/net/ethernet/broadcom/bcm4908_enet.c:664-671) treats a…
- [Medium] The new branch in bcm4908_enet_poll_rx()
  (bcm4908_enet.c:668-670) increments netdev->stats.rx_length_errors and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the RX refill
  failure path in bcm4908_enet_poll_rx() loses the old buffer and later…

--

net: bcm4908_enet: drop RX frames longer than the buffer

This patch adds a check to bcm4908_enet_poll_rx() so that RX descriptors
reporting a length larger than ENET_RX_BUF_DMA_SIZE are dropped instead
of being passed to skb_put(). Such frames are counted in rx_length_errors
and rx_dropped. The commit message says this was seen only with the RX
channel MAX_BURST raised to 32.

> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index ea4a9eb98097c..b2debdfa0902e 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> @@ -660,10 +660,13 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
>  
>  		len = (ctl & DMA_CTL_LEN_DESC_BUFLENGTH) >> DMA_CTL_LEN_DESC_BUFLENGTH_SHIFT;
>  
> -		if (len < ETH_ZLEN ||
> +		/* A length past the buffer would make skb_put() panic the kernel */
> +		if (len < ETH_ZLEN || len > ENET_RX_BUF_DMA_SIZE ||

[Severity: Medium]
On a mainline kernel, can the device ever report a length like this?

bcm4908_enet_dma_alloc_rx_buf() maps exactly ENET_RX_BUF_DMA_SIZE (1532)
bytes and puts that size in the descriptor:

    tmp = ENET_RX_BUF_DMA_SIZE << DMA_CTL_LEN_DESC_BUFLENGTH_SHIFT;

bcm4908_enet_set_mtu() programs mtu + ENET_MAX_ETH_OVERHEAD, which is
also 1532 at ENET_MTU_MAX:

    enet_umac_write(enet, UMAC_MAX_FRAME_LEN, mtu + ENET_MAX_ETH_OVERHEAD);

bcm4908_enet_dma_ring_init() only ever writes ENET_DMA_MAX_BURST_LEN (8)
to ENET_DMA_CH_CFG_MAX_BURST.

The commit message says:

    It was seen on a BCM4908 with the RX channel's MAX_BURST raised to
    32, where the DMA reported a length of 3388 bytes, more than twice
    the size of the buffer; with the default burst length it has not
    been seen.

Given that, does the Fixes: tag (and the stable backport it implies) fit
here? The triggering configuration is not one mainline uses.

There is also the question of what the hardware actually did. If the
DMA wrote the 3388 bytes it reported into a 1532-byte mapping, then the
skb_shared_info area of the frag, and part of the next napi_alloc_frag()
allocation, were overwritten before the CPU saw the descriptor.

Before this patch, skb_over_panic() stopped the system at that point.
With this patch the frame is dropped silently. There is no WARN or log
message, the channel is not reset, and bcm4908_enet_dma_rx_ring_enable()
re-enables the ring with the same configuration.

Did the hardware really overrun the buffer, or did it only misreport the
length? If an overrun is possible, would a WARN_ONCE() or a ratelimited
netdev_err() be better than a silent drop?

>  		    (ctl & (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) != (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) {
>  			dma_unmap_single(dev, slot.dma_addr, ENET_RX_BUF_DMA_SIZE, DMA_FROM_DEVICE);
>  			skb_free_frag(slot.buf);

[Severity: High]
This isn't a bug introduced by this patch, but slot.buf can be NULL
when this path runs, after an earlier RX refill failure.

bcm4908_enet_poll_rx() copies the ring slot by value and then refills
the same index:

    slot = enet->rx_ring.slots[enet->rx_ring.read_idx];

    /* Provide new buffer before unpinning the old one */
    err = bcm4908_enet_dma_alloc_rx_buf(enet, enet->rx_ring.read_idx);
    if (err)
        break;

bcm4908_enet_dma_alloc_rx_buf() writes straight into the ring slot
before it knows whether the allocation worked:

    slot->buf = napi_alloc_frag(ENET_RX_SKB_BUF_ALLOC_SIZE);
    if (!slot->buf)
        return -ENOMEM;

If napi_alloc_frag() fails, the ring slot now holds buf == NULL. The
only reference to the old, still-mapped frag was in the local copy,
which is discarded on the break.

On a dma_mapping_error(), slot->dma_addr is overwritten with the error
cookie and slot->buf is set to NULL, so the old streaming mapping is
leaked as well.

read_idx is not advanced, and the descriptor still has OWN clear. The
next poll therefore handles the same index with slot.buf == NULL. Once a
refill succeeds:

    bcm4908_enet_poll_rx()
      build_skb(NULL, ENET_RX_SKB_BUF_ALLOC_SIZE)
        __build_skb_around()
          __finalize_skb_around()
            memset(shinfo, ...)   <- NULL + size

Does this oops in NAPI softirq context? On the bad-frame path, including
the new len > ENET_RX_BUF_DMA_SIZE branch, the code calls
skb_free_frag(NULL) instead, and after a mapping error it calls
dma_unmap_single() on the error cookie.

bcm4908_enet_dma_uninit() skips slots with buf == NULL, so the leaked
frag and its mapping are never released at teardown either.

Could bcm4908_enet_dma_alloc_rx_buf() allocate and map into local
variables, and update the slot only on success?

> +			if (len > ENET_RX_BUF_DMA_SIZE)
> +				enet->netdev->stats.rx_length_errors++;
>  			enet->netdev->stats.rx_dropped++;

[Severity: Medium]
Should rx_errors be incremented here as well?

The struct rtnl_link_stats64 kernel-doc in include/uapi/linux/if_link.h
says:

    @rx_errors: Total number of bad packets received on this network
    device. This counter must include events counted by
    @rx_length_errors, ...

This driver never touches rx_errors, and bcm4908_enet_netdev_ops has no
ndo_get_stats64. Userspace therefore sees the raw netdev->stats values.
After one oversized frame, ip -s link would show a non-zero frame count
with zero errors.

The same frame is also counted in rx_dropped, which the uAPI describes
as packets received but not processed, for example because of a lack of
resources.

For comparison, bcmsysport.c and bgmac.c increment rx_length_errors
together with rx_errors, and do not also count the frame in rx_dropped.

>  			break;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235700.2586821-1-kudzo51%40gmail.com
