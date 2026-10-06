Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41204A1E1F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307150; cv=none; b=ZX94KsFAD0wLQLnXxmnmHsLpWDGDBEAzyQGsScDc1AiWHjo8iLcH/XV3fVBD18rny2faFxB4vjfZMJEdvLyuTeW3+sJkYdcAOLrPC5hloVqCS27pd0mCH9Yo49Xs9+oYSePcAdB2CtJk4QT0YOarUotPDR+5qbPFj/GT02XU3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307150; c=relaxed/simple;
	bh=J2kLGCHLvBSZo8riNmnY/Rv9LlW3gpVqKz97EOjmJjg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rORWoLtxuaYFJ0IcXMFb5TFreacTY5QJmHzlLi+kO8YrMz1vZVKP84w2Y5dvxdo3brWnCa2Fq2aYz5s9kLTjvmr2PNHgGyFQJZtFFTZB+f7N6Jajcp8KVusOXxMvu8OcptZwEm6aW1Vkqj4eQtZRnH0YZ11GP47qwHVCvaTUpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Xnt3Ev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Xnt3Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAD01F0089D;
	Tue,  6 Oct 2026 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307145;
	bh=Oqeq9CQPG3V3fNygF4RruDyo8be3PstHbGEbmVjoB6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k7Xnt3EvW3a3eJKQiHki82Dpov/PDdahs8U3AwEeYYxK6exZwbODRggkdA5ig8V24
	 8/h6QXClINA02JCqmuYSTd9HDmU1vfrdEhMbMrxrubRAVvU8XbzrRI7vXLWUdS8gLJ
	 e4Jm8XAjyIhfFxTCmxMU9bhcA/S7e/agy7RcCVu7BKKwONKHGlFjwB9WpnODdBJ8Ux
	 nvM7hOv+wffRb9l8VdnLBba3Ena3GRpfTLSL2pQ5b8qpZOEsjeaTtSYeQtNaYSV8KO
	 J/WC9fQzwUg1s58xDvGJIbLp5ELr6BoU/WBbXRgfWZpIz/EGScZuiwIt2tSYGrINnW
	 M3M86defhbEqg==
Subject: Re: [PATCH net-next v3 03/12] net: ethernet: cortina: Drain free
 queue IRQ before resize
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:04 +0000
Message-ID: <179130714489.434549.15842638030329397677@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-3-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-3-3e1f25890ae8@kernel.org>
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

Critical: 0 (1) · High: 1 · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The free queue drain is incomplete.
- [Medium] This patch adds two new reads of geth->port1 inside
  geth_resize_freeq(): disable_irq(geth->port1->irq) (line 1104) and…
- [Low] Comments about the initial free queue setup no longer match the
  code.

Pre-existing issues:
- [Critical] geth_cleanup_freeq() does `while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);` (line 1024).
- [Medium] Free queue pages are mapped with dma_map_single(...,
  PAGE_SIZE, DMA_FROM_DEVICE) in geth_freeq_alloc_map_page() (line 822).
- [Medium] Rebuilding the free queue at a smaller order does not reset
  the hardware SWFQ pointers.

--

net: ethernet: cortina: Drain free queue IRQ before resize

This patch disables port 1's Linux IRQ for the whole of geth_resize_freeq().
The aim is to drain the threaded free queue handler before the ring and page
metadata are torn down and rebuilt. It also adds a geth_set_freeq_irq()
helper, re-enables SWFQ_EMPTY_INT_BIT only when setup succeeds, and clears
the freed free queue state.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 15ad9f721dd52..a2daf22e76989 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -984,6 +984,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	}
>  
>  	kfree(geth->freeq_pages);
> +	geth->freeq_pages = NULL;
> +	geth->num_freeq_pages = 0;
>  err_freeq:

[Severity: Medium]
This isn't a bug introduced by this patch, but the free queue pages are
mapped with PAGE_SIZE in geth_freeq_alloc_map_page():

    mapping = dma_map_single(geth->dev, page_address(page),
                             PAGE_SIZE, DMA_FROM_DEVICE);

The err_freeq_alloc unwind just above here in geth_setup_freeq() and the
teardown loop in geth_cleanup_freeq() both unmap with frag_len, which is
normally 2048:

    dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);

Shouldn't the unmap size match the PAGE_SIZE used when mapping? As written,
this would trigger DMA-API debug warnings. On swiotlb or non-coherent setups
it would also only partly unmap and sync the page.

The commit "net: ethernet: cortina: Correct free queue DMA mappings" later
in the series appears to fix this.

[ ... ]

> @@ -1024,10 +1026,28 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  	}
>  
>  	kfree(geth->freeq_pages);
> +	geth->freeq_pages = NULL;
> +	geth->num_freeq_pages = 0;

[Severity: Critical]
This is a pre-existing issue, but the loop just above in geth_cleanup_freeq()
drops every reference on each free queue page:

    gpage = &geth->freeq_pages[pn];
    while (page_ref_count(gpage->page) > 0)
        put_page(gpage->page);

gmac_rx() gives fragment references from these pages to skbs:

    skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

Those skbs can still be in GRO or in socket receive queues when a resize
runs, for example on open after an RX ring change, or on ethtool -G.

Could this free pages that in-flight skbs still reference? The later skb
free would then call put_page() on a freed or reallocated page.

The commit "net: ethernet: cortina: Preserve in-flight free queue pages"
later in the series appears to fix this by giving each posted fragment its
own reference.

>  
>  	dma_free_coherent(geth->dev,
>  			  sizeof(*geth->freeq_ring) << geth->freeq_order,
>  			  geth->freeq_ring, geth->freeq_dma_base);
> +	geth->freeq_ring = NULL;
> +}

[Severity: Medium]
This is also a pre-existing issue. When the queue is rebuilt at a smaller
order, can the hardware SWFQ pointers end up outside the new ring?

geth_cleanup_freeq() only sets wptr equal to rptr and clears the base/size
register:

    writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
           geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
    writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);

The only place that writes 0 to GLOBAL_SWFQ_RWPTR_REG is
gemini_ethernet_init().

After geth_resize_freeq() sets freeq_order = new_order, geth_setup_freeq()
calls geth_fill_freeq(geth, false). That starts from the old pointer and does
not mask it with the new m_pn:

    pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
    ...
    gpage = &geth->freeq_pages[pn];

If rptr had advanced past the end of the smaller ring, wouldn't this index
past the newly allocated freeq_pages[] and write freeq_ring entries out of
bounds? One way to get there is to run traffic, take both ports down, and
shrink the RX rings with ethtool -G.

Whether this happens depends on the hardware keeping rptr when
GLOBAL_SW_FREEQ_BASE_SIZE_REG is reprogrammed, and the driver code doesn't
show that. The final state of the series still derives pn from an unmasked
wptr, so later patches don't seem to fix this.

[ ... ]

> @@ -1080,16 +1098,11 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	new_order = min(15, ilog2(new_size - 1) + 1);
>  	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
>  		new_size, new_order);
> -	if (geth->freeq_order == new_order)
> +	if (geth->freeq_ring && geth->freeq_order == new_order)
>  		return 0;

[Severity: Low]
This isn't a bug, but the new freeq_ring check forces the first setup
whatever freeq_order holds. That makes the sentinel in gemini_ethernet_init()
redundant, and its comment no longer matches the code:

    /* This makes the queue resize on probe() so that we
     * set up and enable the queue IRQ. FIXME: fragile.
     */
    geth->freeq_order = 1;

The kernel-doc for geth_resize_freeq() also still says "This gets called at
least once during probe()". The only callers are gmac_open() and
gmac_set_ringparam(). That probe() wording was there before this patch.

Could these comments be updated?

>  
> -	spin_lock_irqsave(&geth->irq_lock, flags);
> -
> -	/* Disable the software queue IRQs */
> -	en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> -	en &= ~SWFQ_EMPTY_INT_BIT;
> -	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> -	spin_unlock_irqrestore(&geth->irq_lock, flags);
> +	disable_irq(geth->port1->irq);
> +	geth_set_freeq_irq(geth, false);

[Severity: High]
Does draining only port1->irq here cover every instance of the free queue
handler?

gemini_ethernet_port_probe() registers the same handler pair on both ports'
IRQ lines:

    ret = devm_request_threaded_irq(port->dev,
                                    port->irq,
                                    gemini_port_irq,
                                    gemini_port_irq_thread,
                                    IRQF_SHARED,
                                    port_names[port->id],
                                    port);

gemini_port_irq() only reads the global status and enable registers and
never checks port->id:

    val = readl(geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
    en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);

    if (val & en & SWFQ_EMPTY_INT_BIT) {
        ...
        ret = IRQ_WAKE_THREAD;
    }

Port 0's line stays enabled during the resize. It is shared with gmac_irq,
which gmac_open() requests before the resize, and irqpoll or misrouted IRQ
polling can also run it through try_one_irq().

If that handler runs between disable_irq(port1) and
geth_set_freeq_irq(geth, false), it wakes port 0's thread. Nothing here waits
for that thread. The thread then runs:

gemini_port_irq_thread()
    geth_fill_freeq(geth, true)
        gpage = &geth->freeq_pages[pn];

This can run while geth_cleanup_freeq() frees freeq_pages and sets it to
NULL, or while geth_setup_freeq() is still sleeping in its allocations.

Afterwards the thread ORs SWFQ_EMPTY_INT_BIT back into
GLOBAL_INTERRUPT_ENABLE_4_REG unconditionally, even if setup failed. The next
SWFQ interrupt would then run geth_fill_freeq() with freeq_pages set to NULL.

The commit message says:

  "disable_irq() drains hard and threaded handlers and prevents a new
  thread from being woken."

Isn't that true only for port 1's registration? Would gemini_port_irq() need
to filter SWFQ handling by port->id, or would both ports' IRQs need to be
disabled? The final state of the series still drains only port1->irq with the
same handler on both lines.

>  
>  	/* Drop the old queue */
>  	if (geth->freeq_ring)
> @@ -1103,10 +1116,9 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	 * after probe(), this is where the interrupts get turned on
>  	 * in the first place.
>  	 */
> -	spin_lock_irqsave(&geth->irq_lock, flags);
> -	en |= SWFQ_EMPTY_INT_BIT;
> -	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> -	spin_unlock_irqrestore(&geth->irq_lock, flags);
> +	if (!ret)
> +		geth_set_freeq_irq(geth, true);
> +	enable_irq(geth->port1->irq);

[Severity: Medium]
Can geth->port1 be NULL by the time this line runs?

The only NULL check is at the top of geth_resize_freeq():

    if (!geth->port1)
        return -ENODEV;

Between that check and this enable_irq() there is a long window where the
task can sleep. disable_irq() waits for the threaded handler, then
geth_cleanup_freeq() and geth_setup_freeq() run, with dma_alloc_coherent()
and GFP_KERNEL allocations.

Only RTNL serializes geth_resize_freeq(). gemini_port_clear() sets
geth->port1 = NULL without holding RTNL in two places:

- gemini_port_remove(), after unregister_netdev() returns, or with no netdev
  at all for a PHY-less port 1
- the probe unprepare error path

devm then frees port 1's IRQ action and the port memory. For example:

CPU0 (eth0 open)                 CPU1 (port 1 unbind or probe failure)
geth_resize_freeq()
  geth->port1 is non-NULL
  disable_irq(geth->port1->irq)
  geth_setup_freeq() sleeps
                                 gemini_port_clear()
                                   geth->port1 = NULL;
                                 devm frees the IRQ and the port
  enable_irq(geth->port1->irq)   <- NULL dereference

Probe has a second window. gemini_ethernet_port_probe() sets
geth->port1 = port before it calls devm_request_threaded_irq(). A resize from
port 0 in that window calls disable_irq() on a descriptor with no action.

Won't the first __setup_irq() then reset the depth through irq_startup()?
That would cancel the disable, and the later enable_irq() would hit the
"Unbalanced enable for IRQ" warning.

Before this patch, geth->port1 was only read at the top of the function.
These two re-reads are unchanged in the final state of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
