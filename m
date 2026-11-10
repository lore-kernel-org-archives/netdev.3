Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273382;
	b=UzQFwbhRqLYWvvElCF1XVu4blrb1aw/cngv3g0OC2MQWmmbqsVp2kIHslYR+XN0nVuNZ
	 x9N90MQiDA7a4iHdHL3t+7ugCkgPjpq4ZzkK6NGWz5ZUY0hBN5wQBuzkxt9rf0XThIbrS
	 FPpNcNdKLmLsoRBvUqyMwpMrsW6pKiRUWT9rw49vr12wdb8TTsviD6iq2MaNrUZAZ/cBB
	 4mAH21Y4D9cJjNVPEgSudUv0PMuiwBdYvH7aTNULT3ah95Q+2T3CXfFOhlqnLg05oUIbS
	 OlOTyRS8EyQB83FSc+bwlUf92vVszQmlCfa3OaX9AW6YDJTHgcQbX00z0TFVUeBEMQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+WKY8ifKoMbnv9CTOvkOcndIwR8a03h8Tit7iUgFQPI=;
	b=UqAssI2aqUGe9dsiCgYC/hCticW9fNufotWFisIg2PNJ7JXLoaechXXh5vsbX8uykWsG
	 ZwhW8BEGiDP1VABXDXXEzIk/QWmONl1WoLDuChrQI+U6x+Un+dVXahiZA3GKGBBdnnQze
	 /PLZxdSHFRTHyxne40WMrvCBPm4gEPudmHH64Nz3VK3wMfHW7Exz7RcjdO782w71fbpLG
	 YNMCe8zIIIlA7JaLtJXM7VET5zR32VQyxCs0CNnXEQ5VywvEu8cz83ZW+9WGOO27NSzJ3
	 oqyoNoIaZIkhgKOExi+v4H+ykYkfN0rR4arCCJvCvgRjx2vYePGJYK1oJmmQB3IAmhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJ9kglkI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB4606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJ9kglkI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA121F0089F;
	Tue, 10 Nov 2026 01:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273381;
	bh=+WKY8ifKoMbnv9CTOvkOcndIwR8a03h8Tit7iUgFQPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJ9kglkIYTuU+sam6VLawJDJQq1257WsfZ1g6/bz0oEWiDMJpt17azF+va2DOXMyS
	 TGhZjQkcU+PEU7OSiWmYZl9u1oYbby1SmCCJlQFGgTzWqB93rXUTfXzg5621FiQ6xc
	 bMzEX3Ewd3Y7ACApmG+hb7X3UNy0GgaxrXM7W3WsQXKeY/W4KisUN1GUt9TczVJ2LU
	 MwXgoWENDJkQ+atE0HbvHKqWgcDw1fNfeYFuZezSuB5k7H3eFU9+jwJIb7+hRjytlw
	 du4OMYVjG57ppYrCSTcWZGgYDJBybUVbGYNkdrpWscy6aKaGzeCkYvQEKjRODJLyUQ
	 0f8ukUpczv8VQ==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	ulli.kroll@googlemail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	mirq-linux@rere.qmqm.pl,
	mhun512@gmail.com,
	edumazet@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/15] net: ethernet: cortina: Preserve in-flight free queue pages
Date: Mon,  9 Nov 2026 17:16:20 -0800
Message-ID: <20261110011621.1733491-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-7-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-7-c4b5ff8a65d8@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: cortina: Preserve in-flight free queue pages

This patch stops indexing free queue page metadata by ring position.
Metadata slots now come from a pool tracked by a bitmap, and each fragment's
DMA address stays in the XArray until software claims it. Each posted
fragment holds its own page reference, the page is unmapped once both
fragments are claimed, and free queue sizing now accounts for both RX rings.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index c1c42e1f93f42..9602429388b16 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -910,88 +955,146 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,

[ ... ]

> -static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
> +static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
>  {

[ ... ]

> +	/* Loop over the freeq ring buffer entries */
> +	for (;;) {
> +		dma_addr_t page_mapping;
> +		struct page *page;
> +		int ret;
>  
> -	spin_lock_irqsave(&geth->freeq_lock, flags);
> +		spin_lock_irqsave(&geth->freeq_lock, flags);
> +		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +		rptr = rw.bits.rptr & ring_mask;
> +		wptr = rw.bits.wptr & ring_mask;
> +		space = CIRC_SPACE(wptr, rptr, len) >= fragments;
> +		spin_unlock_irqrestore(&geth->freeq_lock, flags);
> +		if (!space)
> +			break;
>  
> -	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> -	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
> -	pn &= m_pn;
> -	epn = (rw.bits.rptr >> fpp_order) - 1;
> -	epn &= m_pn;
> +		ret = geth_freeq_map_page(geth, &page, &page_mapping);
> +		if (ret)
> +			break;

[Severity: Low]
This isn't a functional bug, but since this patch has a Fixes: tag, I have
a couple of questions about how it is meant to go to stable.

geth_freeq_claim() depends on freeq_mappings and
geth_freeq_mapping_index(). Both come from the earlier "Index free queue
fragments with XArray" patch, which has no Fixes: tag. Would this patch
apply and build on its own in a stable tree without that prerequisite?

This patch also removes position-based recycling. Every refill now maps a
fresh page through geth_freeq_map_page(), and geth_freeq_claim() unmaps
and frees each page once its last fragment is claimed.

The commit message says "A later patch restores recycling independently of
queue position". The later "Recycle claimed free queue pages" patch in this
series does that, and it is also tagged Fixes: 4d5ae32f5e1e. Should the
two patches be kept together for backports, so stable doesn't end up with
only the allocate-on-every-refill state?

[ ... ]

> @@ -1595,7 +1687,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		page = geth_freeq_lookup(geth, mapping, &page_offs);
> +		page = geth_freeq_claim(geth, mapping, &page_offs);
>  		if (!page) {
>  			dev_err_ratelimited(geth->dev,
>  					    "could not find mapping\n");

[Severity: Medium]
Can free queue pages leak if the hardware uses a posted buffer but the
driver never claims it?

With this patch, three things are released together: the page's slot in
freeq_page_bitmap, its streaming DMA mapping and its per-fragment
references. That happens only when geth_freeq_claim() sees every
fragment's exact DMA address, or when geth_freeq_release_pages() tears
down the whole free queue:

geth_freeq_claim() {
    ...
	if (!--gpage->fragments) {
		...
		__clear_bit(slot, geth->freeq_page_bitmap);
		put_page(page);
	}
    ...
}

gmac_rx() has two paths that drop a descriptor without claiming anything.
One is the "could not find mapping" case above. The other is the zero
address case just before it:

	if (!mapping) {
		if (net_ratelimit())
			netdev_err(netdev,
				   "rxq[%u]: HW BUG: zero DMA desc\n",
				   r);
		goto err_drop;
	}

If the hardware used a free queue fragment for one of these descriptors,
that fragment is never claimed.

gmac_cleanup_rxq() only walks the RX ring between rptr and wptr. A buffer
the DMA engine took from the shared free queue but had not yet written into
the ring before gmac_stop() would also stay unclaimed.

These slots come back only when the free queue is rebuilt. That doesn't
happen while the peer port is running, or on a reopen with the same order,
because geth_resize_freeq() returns 0 early in both cases.

geth_freeq_page_slots() sizes the pool as the free queue pages plus both RX
ring sizes, which leaves little slack. Once enough slots are pinned,
geth_freeq_alloc_slot() returns -ENOSPC:

	slot = find_first_zero_bit(geth->freeq_page_bitmap,
				   geth->num_freeq_pages);
	if (slot == geth->num_freeq_pages)
		return -ENOSPC;

and geth_fill_freeq() stops refilling the shared queue. Could RX on both
ports eventually starve this way?

The old position-indexed scheme got the metadata slot back the next time
that position was refilled.

The code doesn't make it clear whether the hardware really uses a posted
buffer in these error cases, so this may not be reachable in practice. The
same behaviour seems to remain at the end of the series, where slots are
still only released through a claim followed by recycle or discard.
