Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430928;
	b=dKy9JQAa+EHVXGKh/uMipFlp9IuB8HsbfV5ZIBRHwG5cNpl5GlAHD2swCwomLNoQz5yD
	 17s1GWYs20KBqqv8TOAH74qVl7WM10hx+Rmhou+00DHqHBHBB5abmNjH/x5WJLXlfiAVx
	 Ji5QZT1+SmqDeIqnMTfskH1Xb3V0YNeR3ULTquXNlMaBubogHmok6dYhEYGdAurIF8QeE
	 C84nsIIqM0CLLX7GZCbRyZi+qa7HHAUjTyWXKD0/O6BvfGWMxxEBp2ao6bFIF+2vTMgUG
	 oNthV269O3yLXop+GNIrVy43xgapG1ljoo4MJp2oL60jIjMKWAZIA0g3qRnaqX5yH3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430928;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H64gCWnJUN3ULFCzZ9Y94qLLnLbxOJQp1NbYNsvJ/yo=;
	b=gvelxfjGPPcR5YE65SUBT6jop4owiLgSrdv++nKgU7pTRRcGt9W1qZC2OliDCIy0x09l
	 lYvYlXca5CU1OObdxJUfVoGUxY1UCkNE0OfLkNACr427hIvEwzYSRi7gqT1PTalUf9URn
	 wEI0EDTTJpXinKLp3kblxRhOtXjPcV8uinr6YP7MwnYf4OyyzCAyZEp4o3KEGPIAKMa2u
	 5ZRrneIuxAZthab8wXdVe3Yl34YsWpVw/ZOaYd8T1C8TUeaKYX4xEoI1V4pjl3rcmHTW0
	 2N76rjotY/+lb0y7vPJsNYPOmIasTw3IoLDvDXrZ0CVWIUbZPYjP0SZwxTuE0GUaOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXup3m6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBE606A332
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXup3m6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2B01F000C7;
	Mon, 19 Oct 2026 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430928;
	bh=H64gCWnJUN3ULFCzZ9Y94qLLnLbxOJQp1NbYNsvJ/yo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXup3m6VBl8VMNIZBbdZrRC2XUWK+pK816bGV37gY923Va9FTHUzFFLYywEmjjKc+
	 4fmOlZo6ySQPRh1bAHiAwlvLQK8CO88ZD8VfBXkUtfzhi4IzXUHpNFJoJ/NhgSWNBY
	 ihlZfzPH9CI2tZO1zcuqfPfNosJ3ekuPj+ZWpVT/r5YzUDz+gGILu2sb+GPJ5ThE9E
	 1GsUT54MS3m7k4VQmNuhgCApGNd4eOPYH0MUR2VUI1gH0I7mIsoOx0q8OmDjIjyIBR
	 QCcQNviXcwIP+0jkFeyC7JSDfWz3X+mQD7ahLqlnSs3yDB2orH3Q7PGAHlIq61etOu
	 thnFD3V5nPOuQ==
Subject: Re: [PATCH net-next v5 07/14] net: ethernet: cortina: Preserve
 in-flight free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:47 +0000
Message-ID: <179243092709.3135.17234520297875888006@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-7-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-7-b5c9e2f7b8a3@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] geth_setup_freeq() sets the software write pointer to the
  hardware read pointer kept from the previous queue, using…
- [Low] geth_setup_freeq() allocates geth->freeq_pages with
  kzalloc_objs() sized by page_slots.

Pre-existing issues:
- [Low] The kernel-doc for geth_fill_freeq() says 'Usually the interrupt
  to refill the queue happens when the queue is half empty.' The SWFQ…

--

net: ethernet: cortina: Preserve in-flight free queue pages

This patch allocates free queue page metadata slots independently of free
queue positions. Occupied slots are tracked with a bitmap, and each fragment
DMA address stays in the XArray until its RX descriptor is claimed. The patch
also sizes the metadata pool for the free queue plus both RX rings, and
requires the initial fill to populate every usable entry.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index c1c42e1f93f42..faab1bb865ab4 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -910,20 +952,20 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,

[ ... ]

>  /**
>   * geth_fill_freeq() - Fill the freeq with empty fragments to use
>   * @geth: the ethernet adapter
> - * @refill: whether to reset the queue by filling in all freeq entries or
> - * just refill it, usually the interrupt to refill the queue happens when
> - * the queue is half empty.
> + *
> + * Usually the interrupt to refill the queue happens when the queue is half
> + * empty.
>   */

[Severity: Low]
This problem was not introduced by this patch. The "half empty" wording comes
from the old kernel-doc, and it doesn't seem to match the code.
geth_setup_freeq() programs the SWFQ empty interrupt with:

    qt.bits.swfq_empty = 32;

gemini.h documents that field as the "Software Free Queue Empty Threshold".

Only the NAPI refill in gmac_napi_poll() uses a half-queue threshold:

    freeq_threshold = 1 << (geth->freeq_order - 1);

gemini_port_irq_thread() has the same "half empty" comment. Could both
comments be fixed while this kernel-doc is being rewritten?

[ ... ]

> @@ -1003,27 +1106,22 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	}
>  
>  	/* Allocate page metadata referenced by the mapping index */
> -	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);
> +	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, page_slots);

[Severity: Low]
Could this allocation become hard to satisfy at larger ring sizes?

page_slots now includes both RX ring sizes, added in
geth_freeq_page_slots():

    if (geth->port0 && geth->port0->netdev)
        slots += 1 << geth->port0->rxq_order;
    if (geth->port1 && geth->port1->netdev)
        slots += 1 << geth->port1->rxq_order;

struct gmac_queue_page has also grown to 12 bytes on 32-bit Gemini.

At the ethtool maximum (rxq_order 15 on both ports, freeq_order 15) this is
16384 + 32768 + 32768 = 81920 entries. That is about 960 KiB of physically
contiguous kmalloc memory (order 8). Before this patch it was 128 KiB.

With rxq_order 11 on both ports it needs 96 KiB (order 5). The old code
needed 32 KiB.

If the allocation fails under fragmentation, geth_resize_freeq() fails, and
gmac_open() or the ethtool -G request returns -ENOMEM. Only the CPU accesses
this array, so would kvcalloc() and kvfree() be a better fit?

>  	if (!geth->freeq_pages)
>  		goto err_freeq;
> -	geth->num_freeq_pages = pages;
> -

[ ... ]

> +	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
> +	if (!geth->freeq_page_bitmap)
> +		goto err_freeq_pages;
> +	geth->num_freeq_pages = page_slots;
>  
>  	/* Match the software pointer to the retained hardware pointer. */
>  	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
>  	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
>  
> -	filled = geth_fill_freeq(geth, false);
> -	if (!filled)
> -		goto err_freeq_alloc;
> +	expected = len - (1 << fpp_order);
> +	filled = geth_fill_freeq(geth);
> +	if (filled != expected)
> +		goto err_freeq_bitmap;

[Severity: Medium]
Can the first page posted here straddle the hardware read pointer?

rptr is the read-only hardware SWFQ read pointer left over from the previous
queue. geth_cleanup_freeq() only sets wptr = rptr, and geth_resize_freeq()
keeps rptr through:

    new_order = max_t(unsigned int, new_order, fls(rptr));

If the hardware consumed an odd number of 2K fragments before the resize,
rptr is odd. geth_fill_freeq() then rounds the write pointer down to a page
index:

    pn = (rw.bits.wptr >> fpp_order) & m_pn;

geth_freeq_add_page() writes both fragments at freeq_ring + (pn << fpp_order).
So fragment 0 ends up in entry rptr - 1, behind the hardware read pointer.

For example, take len = 16 and rptr = 5:

- Page A goes into entries 4 and 5, and the fill ends at wptr = 2.
- The hardware reads entries 5..15, then 0 and 1.
- A later refill at rptr >= 8 writes page B into entries 4 and 5.
- The fragment 0 address of page A never comes back in an RX descriptor.

geth_freeq_claim() is the only path that releases a slot, and only when
gpage->fragments drops to zero. Does page A then keep its XArray entry, DMA
mapping, page references and freeq_page_bitmap bit until the queue is torn
down?

The old position-indexed code dropped the stale page when that position was
refilled, so this looks new with this patch. The later recycle patch in the
series only recycles pages whose fragments count reaches 0, so the problem
seems to remain at the end of the series.

The check above also counts the fragment that the hardware cannot see:

    expected = len - (1 << fpp_order);

So it passes in this case. Is this sentence in the commit message accurate
when rptr is not page aligned?

    Require the initial fill to populate every usable
    queue entry.

The impact looks bounded to one page and one slot per free queue lifetime.
Later refills always write page-aligned wptr values, and each setup gets a
fresh bitmap. It does use up one slot of the headroom computed by
geth_freeq_page_slots().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
