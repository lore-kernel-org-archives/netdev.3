Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82C3859E9
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830739; cv=none; b=ZcNxIva3abRtLTgtWrubxH5mdkf+PCCZFv11+Itbf7CWRwkKdKIHX26FOitr6XNrkOUkkntEU7ZZd8/6TJsNW/uz8Byzfr09UvkfDDF1ZD0wBr2Md8iFoYUtzD8O7PNMqz8G/526zRc/ZZWq7f8uz4oJ9BruE6cqXU2RZgisyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830739; c=relaxed/simple;
	bh=i8hHhz2MKfAePGjYilbDi0iz4dhuCB+h/jKp1ZgWPSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlKTtZIDbCPbaLiT0T7q9vWePygfT6iu8hBKYE2T5NulZl05+nP1LRtq8R6ebob1y4ktupISZRWB1ZsogGiXv+OE8m+RmHIbQfQ007Ej/sNT5ZjvbZ3pbKmnJEvqv0VJR7bDCKjIs/5VIwi22t5D2M+N/hP5ZiUtJSHt6SeEgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVsiL9XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVsiL9XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5EC1F0089B;
	Mon, 12 Oct 2026 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830736;
	bh=B52craXkHAtouuaphH3VPohrGH5hHy0E/oTSsw1jiPE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YVsiL9XYKx83KG7FyqBNGRETVnO2ELn0bRyDiY1ouXOI7vrdMZ8vDmaZGcJYH1ovX
	 w4Ulo08sT8u7UfD55HHiNys/daQQ8fKXrXBtQNACochoq8Fvy0LbYa2H1s4LXmwTL0
	 +udnEgt9l4dm9QtCwj1fodBAIOERKqBpubfg31x4Ucw6LM6u3Zp2+l6QANHccSQSWM
	 y+vM3VIDprAziaOvuxt/3eapvZiwbHZvO/MqjZJ7VTlQa8v1y05TpQuqif14iDjwmj
	 OEAyxbUnKgR+JR/nArWmPA8NnBs89Khncx8eIFUOTGxulF95goc7Rl42toQdYpsgNl
	 zotulVZeuYcpA==
Subject: Re: [PATCH net-next v4 10/15] net: ethernet: cortina: Recycle claimed
 free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:35 +0000
Message-ID: <179183073562.434549.5772914368674443780@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-10-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-10-4b1631b08f5d@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] geth_fill_freeq() (drivers/net/ethernet/cortina/gemini.c) sets
  its local `recycle` flag to false the first time…

--

net: ethernet: cortina: Recycle claimed free queue pages

With this patch, a free queue page keeps its base reference and streaming
mapping after its last fragment is claimed. The slot is marked in a new
recycle bitmap. During refill, geth_fill_freeq() reuses the page if its
refcount has dropped back to one, and otherwise unmaps and releases it
before allocating a replacement.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 3bb96c51e0b71..943c31c026743 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -997,9 +1078,26 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
>  		pn = (rw.bits.wptr >> fpp_order) & m_pn;
>  		epn = (rw.bits.rptr >> fpp_order) - 1;
>  		epn &= m_pn;
> +		ret = -ENOSPC;
> +		if (pn != epn && recycle) {
> +			ret = geth_freeq_recycle_page(geth, pn);
> +			if (!ret) {
> +				count += 1 << fpp_order;
> +				pn++;
> +				pn &= m_pn;
> +				writew(pn << fpp_order,
> +				       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
> +			}
> +			if (ret == -ENOSPC)
> +				recycle = false;

[Severity: Low]

Once geth_freeq_recycle_page() returns -ENOSPC because freeq_recycle_pending
was 0, recycle stays false for the rest of this geth_fill_freeq() call.
Can new recyclable slots show up after that point?

freeq_lock is dropped at the end of each iteration and around
geth_freeq_map_page(). In that window gmac_rx()->geth_freeq_claim() can
retire pages. One example is the NAPI softirq running at hardirq exit while
gemini_port_irq_thread() is inside geth_fill_freeq():

geth_freeq_claim()
    if (!--gpage->fragments) {
        slot = gpage - geth->freeq_pages;
        __set_bit(slot, geth->freeq_recycle_bitmap);
        geth->freeq_recycle_pending++;
    }

These retired slots keep their freeq_page_bitmap bit set. Even so, the
remaining iterations still allocate and map a fresh page. Each one takes a
new metadata slot through geth_freeq_add_page()->geth_freeq_alloc_slot().

Can slot usage then exceed what geth_freeq_page_slots() sizes for (ring
pages plus rxq entries)? Retired pages now count on top of posted pages and
pages held by unclaimed RX descriptors.

If the table fills up, geth_freeq_alloc_slot() returns -ENOSPC.
geth_fill_freeq() then throws away the page it just mapped and stops:

    if (ret) {
        dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
                         DMA_FROM_DEVICE);
        put_page(page);
        break;
    }

This leaves the free queue under-filled while recyclable slots are still
pending.

The next geth_fill_freeq() call starts with recycle = true and drains them,
so this recovers on its own. It does still cause extra fresh page
allocations and mappings during the call, which the commit message is
trying to avoid.

Could the latch be dropped, or freeq_recycle_pending re-checked under
freeq_lock, before falling back to a fresh allocation?

> +		}
>  		spin_unlock_irqrestore(&geth->freeq_lock, flags);
>  		if (pn == epn)
>  			break;
> +		if (!ret)
> +			continue;
> +		if (ret != -ENOSPC && ret != -EAGAIN)
> +			break;
>  
>  		ret = geth_freeq_map_page(geth, &page, &page_mapping);
>  		if (ret)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
