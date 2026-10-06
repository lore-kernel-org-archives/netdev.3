Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986D4A2A50
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307154; cv=none; b=OlzjgD1RMUQvh2uTcZAr2D6BmwMMz0qTR7YSYYKO9MxJxCXUIr4aS/EOltJso1+BfHaTrdBlIE9YE9jgld687aw+7OGpRA+ZDcMLM9O967ADzaFC7E3UgfjBqkIiOPErVXT54D7CtueKkdU4G/MxvjfEeblXUPLH8E7Gn1Idh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307154; c=relaxed/simple;
	bh=vlc1eIXWKHa6OxTV7k4GF/XP/oSjAe5je92oOMzNgxE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwKqa8NMV7ZDGzifq6Wzto4vpAuPDu+ELpOtbdyIzQdCdAne8dv905BlFe0dGhLVynS6bpfUNWVCd8a/AHtwjcq57cZ6ZNkImFxH4tj+PspSdB8fONCWLyr7zG9b1JLFGAOKF9jiIMjVT4KjD/zZNA6TZ9tn8kBJtg4JcMuxL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYij6+yE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYij6+yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C531F0089D;
	Tue,  6 Oct 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307152;
	bh=YjIxz6zwHlnGbx9vs7f77uByDpbDzOGVO8jt3KOuwh8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JYij6+yEUIvyf41BFc3nRNDcej09pVrng2H2zUBY6s+yQmjAU72l5k28dGb6tEkuf
	 0kdcQnGj3os+ahk7i030bPsOfSUJGhBOq4xYipgUab8Lw3awdVsIFy4y7G95xazqLC
	 /oYvxfWzfwicdpG2FFLNYYrBEacKx2VVyxucP/60H/zzAPTkpmQHQMrYfPUhPK/7Pm
	 DbTxRrnuTp95hT7AUpV85j3Cd9E6yjS9KLaLy739leCfrbQq9QLndfMGaS4CBXuKSG
	 W1CT2f2EJ1+5udMwuc/2AEjjIuiZdiAYVrPLyzRaRX13zuHC26gqxMaoUx7+dHTHJa
	 hyDE+r11KI8Ag==
Subject: Re: [PATCH net-next v3 09/12] net: ethernet: cortina: Recycle claimed
 free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:11 +0000
Message-ID: <179130715162.434549.17096865539770064579@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-9-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-9-3e1f25890ae8@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Pages held by the network stack now keep their free-queue
  metadata slot, so the free queue can run out of buffers and RX stops…
- [Medium] geth_freeq_recycle_slot() walks all geth->num_freeq_pages
  entries of geth->freeq_pages.
- [Low] The commit message and Fixes tag are inaccurate.

--

net: ethernet: cortina: Recycle claimed free queue pages

This patch keeps the free queue base reference and the DMA mapping after
all fragments of a page have been claimed. When the page refcount drops
back to one, the page is synced for the device and posted again. A fresh
page is allocated only when no claimed page can be recycled.

> The lifetime fix releases each mapping after its last descriptor is
> claimed. Refilling therefore allocates and maps a fresh page at line
> rate even after the network stack has released all references to an old
> page.

[ ... ]

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

[Severity: Low]
Is this Fixes tag accurate? The commit message does not say which commit
"the lifetime fix" is.

The original driver already reused pages in place. The baseline
geth_fill_freeq() reused a page when page_ref_count(page) <= 1. It only
called geth_freeq_alloc_map_page() when the page was still in use.

The allocate-and-map on every refill seems to come from an earlier patch
in this series, "net: ethernet: cortina: Preserve in-flight free queue
pages". That patch's geth_freeq_claim() unmaps the page, puts it and
clears its slot on the last claim.

This patch also depends on the slot bitmap, the xarray index and
freeq_page_cursor from the same series.

Should this be folded into that commit, or name it as the commit being
followed up, instead of carrying a Fixes tag for 4d5ae32f5e1e?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 87c537ae83e7a..a0186cc4b9436 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -762,6 +763,35 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
>  	return slot;
>  }
>  
> +static int geth_freeq_recycle_slot(struct gemini_ethernet *geth)
> +{
> +	unsigned int slot = geth->freeq_page_cursor;
> +	unsigned int scanned;
> +
> +	lockdep_assert_held(&geth->freeq_lock);
> +
> +	if (!geth->freeq_recycle_pending)
> +		return -ENOSPC;
> +
> +	for (scanned = 0; scanned < geth->num_freeq_pages; scanned++) {
> +		struct gmac_queue_page *gpage = &geth->freeq_pages[slot];
> +
> +		if (gpage->page && !gpage->fragments &&
> +		    page_ref_count(gpage->page) == 1) {

[Severity: Medium]
How long can hard IRQs stay off in this loop? It walks all
num_freeq_pages entries and reads the refcount of every fully claimed
page. It runs under spin_lock_irqsave(&geth->freeq_lock), called from
geth_fill_freeq() in both the gmac_napi_poll() and
gemini_port_irq_thread() refill paths.

The only early exit is the freeq_recycle_pending check. geth_freeq_claim()
increments that counter while skbs still reference the page, and only a
successful pick decrements it.

If even one page stays in a socket queue, reassembly queue or qdisc
backlog, would every geth_fill_freeq() call that runs out of recyclable
pages do a full walk and find nothing?

num_freeq_pages is 2048 with defaults. With "ethtool -G rx 32768" it can
reach 16384 + 2 * 32768 = 81920. Before this patch, the IRQs-off part of
geth_fill_freeq() was one find_next_zero_bit() over the bitmap plus
posting a single page.

This cost also adds up with the SWFQ_EMPTY retrigger described in the
geth_freeq_claim() comment below.

[ ... ]

> @@ -794,16 +823,8 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
>  				      mapping - page_mapping, frag_len,
>  				      DMA_FROM_DEVICE);
>  	xa_erase(&geth->freeq_mappings, index);
> -	if (!--gpage->fragments) {
> -		slot = gpage - geth->freeq_pages;
> -		dma_unmap_single_attrs(geth->dev, page_mapping, PAGE_SIZE,
> -				       DMA_FROM_DEVICE,
> -				       DMA_ATTR_SKIP_CPU_SYNC);
> -		gpage->page = NULL;
> -		gpage->mapping = 0;
> -		__clear_bit(slot, geth->freeq_page_bitmap);
> -		put_page(page);
> -	}
> +	if (!--gpage->fragments)
> +		geth->freeq_recycle_pending++;

[Severity: High]
Can this let the free queue run out of buffers and stop RX on both GMAC
ports?

A fully claimed page now keeps gpage->page and its bit in
freeq_page_bitmap. The slot is reused only when geth_freeq_recycle_slot()
sees page_ref_count() == 1. The bit is cleared only on the
geth_freeq_add_page() error path.

geth_freeq_page_slots() sizes the slot pool for pages the hardware can
hold:

	unsigned int slots = 1 << (order - fpp_order);

	if (geth->port0 && geth->port0->netdev)
		slots += 1 << geth->port0->rxq_order;
	if (geth->port1 && geth->port1->netdev)
		slots += 1 << geth->port1->rxq_order;

That leaves no room for pages that skbs still reference after the claim.
Each fresh page from the fallback path takes a slot until it is recycled.

Once every slot holds a retained page that the stack still references,
the refill path looks like this:

geth_fill_freeq()
  geth_freeq_recycle_page()
    geth_freeq_recycle_slot()   returns -ENOSPC, refcount > 1
  geth_freeq_map_page()         new page allocated and mapped
  geth_freeq_add_page()
    geth_freeq_alloc_slot()     returns -ENOSPC, no zero bit left
  dma_unmap_single(); put_page(); break;

After that the write pointer in GLOBAL_SWFQ_RWPTR_REG stops advancing.
The shared software free queue then drains for both ports, including
traffic for sockets unrelated to the held pages.

The spare headroom is roughly 1024 pages with defaults. The smaller
rxq_order defaults on 32/64 MB systems from the later "Scale Gemini RX
queues to system memory" patch make it smaller.

gmac_rx() adds only frag_len to skb->truesize, so each small packet holds
a 2 KB half-page. Unread UDP sockets, TCP out-of-order queues, qdisc
backlogs or IP fragment reassembly queues could hold that many pages, and
a remote sender can fill the reassembly and socket queues.

Once RX has stopped, NAPI refill no longer runs. gemini_port_irq_thread()
then ACKs and re-enables SWFQ_EMPTY even when geth_fill_freeq() posted
nothing.

Depending on how the hardware asserts SWFQ_EMPTY, could this become
either an interrupt storm or a stall that remains after the stack
releases the pages?

The commit message says "Fall back to allocating a new page while old
fragments remain in the stack". Does that fallback only work until each
slot has been used once?

None of the later patches in the series ("Validate RX fragment lengths",
"Release partial RX frames on stop", "Scale Gemini RX queues to system
memory") changes the slot accounting.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
