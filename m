Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503682;
	b=XNTkF4rJbT88lvekKns725v9N25t7neM/+Ed2ZoZA8sf+ZW6DKQ1nhMlGMDG3yBqdBqI
	 KyS3+KTswgMWvAFdrvJJF8s+q6e3+N1QlY86aYYE1xEj3j0imi0cmlRKjMDBTARovNNXv
	 TZoMGMsAP6tgBigoCk/pDgTkoJ5ji5/8LsxX3gu7LCg7OQix3BGu2hdauCc7x3XoTeXDF
	 shwMtPFa7kJJiTRjkmFFi89N3XCdfmc2XHNHhh2POhL9y74eqaPDFKIS87f68sNzohAge
	 iuBOfGEsqGd8c9NAQtoJkgOrEtsg+6zzW5LlQP/i6ez/2WBstdcfGs2LNvjdWyfyCGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503682;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qMWqzOwgjhj/riKmv4SFNzHAl3QB/o2M98LqJqz9cVk=;
	b=ygJs/VaYw9Ix1bUBwA8Y5j//E2pA+4Bej4UXZDj0u4RhEvxyB4WyYlkv/kBNcuO4FOPq
	 NKmKcqzahH0J7SF0PoJZCmySnl1tq8LVIWRx186KU9LnfvaD/wWCmNHeP91r4QMySUxBD
	 uElnAv6+nW1Tnt1fuw7tPT1sx1Jf1FbyfeHyxWB608QXDZZidn4agHE/v2AO48sJoqcch
	 kgZSW4ohxNts2gA5RJrjGT12ED6LghJ+ybNoog3/SF67fDYM3vgR0jcZRpgM5cq61qAJP
	 dcEc3yXQEfbY25Y1AK6uuQYTcd6RbMlgigYfF9RQD0Xm3U5cpjkwVOBCotuz6n1GiAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2HPiEve;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350DC606A88C;
	Thu, 12 Nov 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2HPiEve
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2E01F000C7;
	Thu, 12 Nov 2026 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503681;
	bh=qMWqzOwgjhj/riKmv4SFNzHAl3QB/o2M98LqJqz9cVk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g2HPiEveQ9Hk3FTbbNbslgV94gxCizewq8sxOurtaZH7DSuKMBNaNP7/+ekEJkeyS
	 Nmr0mw/CeAiOUdEV4lNaTiyMC5l5/btuSmz4b8ygW46KgH5dF4wEelBQfUYSS3Gn39
	 BwZ2SGffDvwfqlOJb8/vRpFb2jLR7aoelTia+rn4jOl+6+XTfSfVIiCTjBkgWio+AN
	 joBDuoPqLB62PG04abyklNLgsF2FqxvOmVDDuizzaeUIBtV5n6+zu8QYSiEdq5/qPs
	 2TT6istSarz0eUe6annYpg2KCO/Qxg6SDR2JehJnjq1sXpCIKYETeLhHTiJHcgQ9Pq
	 aLZnsyFxEtxhw==
Subject:
 Re: [PATCH net 6/7] net: bcm4908_enet: publish the buffer address before OWN
From: netdev-bot+sashiko@kernel.org
To: kudzo51@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 17:14:40 +0000
Message-ID: <179450368092.2199510.12272271322711865382@kernel.org>
In-Reply-To: <20261109235700.2586821-7-kudzo51@gmail.com>
References: <20261109235700.2586821-7-kudzo51@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comment this patch adds in bcm4908_enet_dma_alloc_rx_buf()
  (drivers/net/ethernet/broadcom/bcm4908_enet.c, lines 292-295) says the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  function the patch edits and is still present at the end of the series.

--

net: bcm4908_enet: publish the buffer address before OWN

This patch changes the RX refill in bcm4908_enet_dma_alloc_rx_buf() so the
buffer address is written before the control word that carries
DMA_CTL_STATUS_OWN. It adds a dma_wmb() between the two stores on both the
RX refill path and the TX path. It also adds a dma_rmb() in
bcm4908_enet_poll_rx() after DMA_CTL_STATUS_OWN is seen clear.

> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index c0aca68010c3b..ea4a9eb98097c 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> @@ -289,8 +289,13 @@ static int bcm4908_enet_dma_alloc_rx_buf(struct bcm4908_enet *enet, unsigned int
>  	tmp |= DMA_CTL_STATUS_OWN;
>  	if (idx == enet->rx_ring.length - 1)
>  		tmp |= DMA_CTL_STATUS_WRAP;
> -	buf_desc->ctl = cpu_to_le32(tmp);
> +	/* The DMA must not see OWN before the new buffer address: with a full
> +	 * ring it waits on this very descriptor and would fill the old buffer,
> +	 * which is on its way up the stack as an skb.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment match what the rest of the driver
assumes about a full ring? The commit message makes the same claim:

  "which is where the DMA waits once the ring is full"

The end of bcm4908_enet_poll_rx() assumes the opposite for the same case:

	/* Hardware could disable ring if it run out of descriptors */
	bcm4908_enet_dma_rx_ring_enable(enet, &enet->rx_ring);

If the channel is disabled when it runs out of descriptors, it only
restarts through the writel() in bcm4908_enet_dma_rx_ring_enable(). That
write comes after the descriptor stores, so the window described here
would not open.

The new addr -> dma_wmb() -> ctl ordering looks correct under either
model. Could the new comment and the commit message be brought in line
with the existing comment, or hedged, so a reader can tell which hardware
behaviour applies?

>  	buf_desc->addr = cpu_to_le32(slot->dma_addr);
> +	dma_wmb();
> +	buf_desc->ctl = cpu_to_le32(tmp);
>  
>  	return 0;
>  }

[ ... ]

> @@ -638,6 +645,8 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
>  		ctl = le32_to_cpu(buf_desc->ctl);
>  		if (ctl & DMA_CTL_STATUS_OWN)
>  			break;
> +		/* Nothing the DMA wrote may be read before it gave the descriptor back */
> +		dma_rmb();
>  
>  		slot = enet->rx_ring.slots[enet->rx_ring.read_idx];
>  

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but it is
in the refill path this patch touches. What happens to the old RX buffer
when bcm4908_enet_dma_alloc_rx_buf() fails?

The refill writes into the live slot before it knows the refill will
succeed:

bcm4908_enet_dma_alloc_rx_buf() {
	slot->buf = napi_alloc_frag(ENET_RX_SKB_BUF_ALLOC_SIZE);
	if (!slot->buf)
		return -ENOMEM;
	...
	if (err) {
		...
		skb_free_frag(slot->buf);
		slot->buf = NULL;
		return err;
	}
	...
}

bcm4908_enet_poll_rx() keeps the old buffer only in its local copy:

	slot = enet->rx_ring.slots[enet->rx_ring.read_idx];

	/* Provide new buffer before unpinning the old one */
	err = bcm4908_enet_dma_alloc_rx_buf(enet, enet->rx_ring.read_idx);
	if (err)
		break;

After that break, slots[read_idx].buf is NULL. Its dma_addr holds either
the old mapping or the mapping error cookie. The filled, still-mapped old
buffer is leaked, and read_idx does not move. The descriptor still has
DMA_CTL_STATUS_OWN clear, and ctl still holds the old length and
SOP/EOP bits.

The next poll stops on the same index, now with slot.buf == NULL. The
refill succeeds this time, and the length and SOP/EOP check passes on the
stale ctl, so we get:

bcm4908_enet_poll_rx()
  dma_unmap_single(dev, slot.dma_addr, ...)   <- stale or error dma_addr
  build_skb(NULL, ENET_RX_SKB_BUF_ALLOC_SIZE)
    __build_skb_around()
      __finalize_skb_around()                 <- writes shinfo at NULL + size

The bad-frame path calls skb_free_frag(slot.buf) on NULL instead. Could
this oops in NAPI softirq context when GFP_ATOMIC allocations fail or DMA
mappings run out?

bcm4908_enet_dma_uninit() also skips slots with buf == NULL:

	if (!slot->buf)
		continue;

so the leaked frag and its mapping are never freed. The code looks the
same at the end of the series.

Would it work to allocate and map into local variables, and only write
them to the slot and the descriptor once both steps succeed? On failure,
poll_rx() could give the old buffer back to the hardware, or drop the
frame and keep the slot intact.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235700.2586821-1-kudzo51%40gmail.com
