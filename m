Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430926;
	b=x46bCsCa4suZ5u8UfIrI5GSeVdA/7RlYu2qe3VMYEtgN+1U98zXeHerp4f/U9i1+W2qP
	 zC2PH2fqKp0JYnfVEfE+jlHgplAruAZNmOrrVd00lLJI0OlLEEU7KdwjROCi6KXhMenid
	 bZGmolrwJGBYDB9GTC7L5vKdydkzjz7dqcScwnIkwJkIAHCNdVQXT5RyptQXsq9tWjNuZ
	 d6wgyAynE27nVI53yysi/bqS3MLhlNuHAxQXv2lWpRafHDYeEkashSna6cjTLtgRm2HAF
	 o5bIxVSWmVXIrE6PsxoOBD1NkChNYqqduGO6Yu7u7VK/M49AZ4NKYcNAlch+DA7ECZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430926;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3h8KM7bmTTxYu+jEhaAiykzHoSPKXi7bY9gdhvqM+BU=;
	b=EHnByWychrrTStbgAzrVnmKMhBwSofPB5OCdywtejL2nXy0SvaDX6ik4dzoonYxm4a96
	 4/VMRJqBkyRUOcT58Qr4CvI0yJ2AfI3ljsRhSvLyuA8GwmjvF5ueDsgbqclmPQPlyrD6/
	 M39AfJZ/5eOQ1nQvJn1QOxim9fUvWnb3JN/pH2uIfrBFik5p3RWSi4rhyS92w+le5Mifj
	 /suduqULHCWU0XF7HKzG4p9gA+qOvPEc5hJiJSXLo13Dg57/2PFbYDlp/0cIJ4pBR3HbC
	 rsFoaaUtS+szFQRRPwKdHpOqTfQhk5zb8uYv4k1oaxkh4XFWeBLlm5NYGne0sq6IRlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjkehFBS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02572606A326
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjkehFBS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7701F000C5;
	Mon, 19 Oct 2026 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430925;
	bh=3h8KM7bmTTxYu+jEhaAiykzHoSPKXi7bY9gdhvqM+BU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BjkehFBSHMdDjD/syW0rRCF2nFsDt8ZdRi5KDXXiWBkML6GzDLS8xLaLXPTI3E+t8
	 YO3DWee65umthNCrUzcOJzCYPQTJSAlSlTfW78IXKg/kIcvJzBeFSPjdt9ttx/EioM
	 PaF8ynM54kHPHSJbzXfP+PLBLUjGgXHpdh/xKftdwqOii4NVphRWWeO3gScKswpB+3
	 li/98VfnBniT+3psFjU10WyjbjObo5+YyIvY4XtFax6o9bueoc2nYzol4oohyOezaZ
	 /4LVV40V2d0e7CMkc4gTRCyJ67CBqF9C5hmgkjJRCbLbNM6BRpKNb1BB0gELD45CmS
	 u+je0FPGjFdBw==
Subject: Re: [PATCH net-next v5 04/14] net: ethernet: cortina: Normalize free
 queue pointers on rebuild
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:44 +0000
Message-ID: <179243092457.3135.17783670446097368529@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-4-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-4-b5c9e2f7b8a3@kernel.org>
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

- [Low] The commit fixes an out-of-bounds access but has no Fixes: tag.

Pre-existing issues:
- [Medium] The hardware SWFQ read pointer advances one fragment
  descriptor at a time.
- [Medium] In geth_freeq_alloc_map_page(), when a slot already holds a
  page, the loop `freeq_entry->word2.buf_adr = mapping` first overwrites…

--

net: ethernet: cortina: Normalize free queue pointers on rebuild

This patch masks the software free queue page index to the active queue
order in geth_fill_freeq(). It sizes the rebuilt free queue so that the
retained hardware read pointer fits inside it. Before the ring is filled,
it sets the write pointer from that read pointer.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 003108270d060..7ebd62f8a3a46 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -887,6 +887,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
>  
>  	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
>  	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
> +	pn &= m_pn;
>  	epn = (rw.bits.rptr >> fpp_order) - 1;
>  	epn &= m_pn;

[Severity: Low]
Should this patch carry a Fixes: tag?

Without this mask, rebuilding the queue at a smaller order through ethtool
-G could use the retained hardware rptr to index geth->freeq_pages[pn] past
the end of the kzalloc'd array:

gmac_set_ringparam()
  geth_resize_freeq()
    geth_setup_freeq()
      geth_fill_freeq(geth, false)
        pn = rw.bits.rptr >> fpp_order;
        gpage = &geth->freeq_pages[pn];

The unmasked computation appears to come from 4d5ae32f5e1e ("net:
ethernet: Add a driver for Gemini gigabit ethernet").

The other fixes in this series ("Keep shared free queue parent-owned",
"Drain free queue IRQ before resize" and "Preserve in-flight free queue
pages") all carry Fixes: 4d5ae32f5e1e. Without the tag here, stable trees
may not pick up this out-of-bounds fix.

[ ... ]

> @@ -958,6 +960,10 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  		if (!geth_freeq_alloc_map_page(geth, pn))
>  			goto err_freeq_alloc;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does
geth_freeq_alloc_map_page() unmap the right address when it replaces a
page?

The function writes the new page's mapping into the ring and then reads
the "old" mapping back from the same slot:

    for (i = (1 << fpp_order); i > 0; i--) {
        freeq_entry->word2.buf_adr = mapping;
        freeq_entry++;
        mapping += frag_len;
    }

    gpage = &geth->freeq_pages[pn];
    if (gpage->page) {
        mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
        dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
        ...
        put_page(gpage->page);
    }

The refill path in geth_fill_freeq() calls this to replace an in-use page
when page_ref_count(page) > 1 and fl <= 64 >> fpp_order. In that case it
looks like the new buffer, which the hardware is about to DMA into, gets
unmapped, and the old page's mapping is never unmapped.

The unmap also uses frag_len, not the PAGE_SIZE passed to
dma_map_single(). The error path in geth_setup_freeq() and
geth_cleanup_freeq() also unmap with frag_len.

When no page was present, gpage->mapping = mapping stores the address
after the fragment loop has moved past it, not the page base.

The next commit in this series, "Correct free queue DMA mappings", appears
to fix this. It removes the invalid replacement unmap, keeps the page DMA
base separate from the fragment iterator, and unmaps with PAGE_SIZE.

>  
> +	/* Match the software pointer to the retained hardware pointer. */
> +	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
> +
>  	filled = geth_fill_freeq(geth, false);

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens when the
retained rptr is odd?

The hardware read pointer moves one fragment descriptor at a time. With
the default fpp_order of 1, each page has two descriptors. However,
geth_fill_freeq() works in whole pages:

    pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
    pn &= m_pn;
    epn = (rw.bits.rptr >> fpp_order) - 1;
    ...
        page_ref_add(page, 1 << fpp_order);
    ...
    writew(pn << fpp_order, geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);

Take len = 1024 and rptr = 701. pn starts at 350 and the final wptr is
698. Both fragments of page 350 get a reference, but entry 700 sits
behind rptr and outside [rptr, wptr). The hardware is never offered it on
this lap.

On the next refill, page 350 still has page_ref_count() > 1, so the loop
breaks until the queue drains to 64 descriptors or fewer. That can let
the free queue fall to the swfq_empty threshold.

geth_freeq_alloc_map_page() then replaces the page but drops only one
reference. Does that leak the old page and its DMA mapping?

At the end of the series, the orphaned fragment seems to hold its
metadata slot, page and mapping until the next queue teardown.

The old setup fill also used rptr >> fpp_order, so this truncation
predates this patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
