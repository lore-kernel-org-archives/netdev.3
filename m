Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450626D4C3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103094; cv=none; b=IH9K0UJ8zSn6IAwyEV/Ht0cQS2CHcGWL1d3jh09uIFxUzBK8K+XmvYJMgFvLH4LKnciFClBYd/VfGgzin9wsVLn7uvOXHxC6wJQy/Am6ppC4pOrUPbIunWWimzNTFsvCLMhNe+7mbt3tCC7++5rbQ73jL49YuTaUfuD5+J30yn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103094; c=relaxed/simple;
	bh=9paLRhR9FXbamS+uHGlN5+y1/BZ3QQD4U+vsx4ZGJvk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXr5KqnVv5siMULB9M7bp5YTleYC7GWRzucEEoPGFcfSefrI5wRULMu5V4X7yN6L7e7xzMf4zSmZvUgloE/pcYPAse7ULNzpZGHCxilTKZtMoqbDtDLD3Lmiy1aX0cKrw2IVrrD3EdAxreskGg96fqe7hpdiatsQnZ/P7apgvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYCml0EM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYCml0EM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5760A1F000FF;
	Tue, 22 Sep 2026 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103091;
	bh=ik3zihXTjP1ic9bPxJbqplqQqO3PuKuAjp80x7sd/nI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UYCml0EMGGTHpoh1bt32AK4DsJ/aa4jVM+YZlHzUCAHDZcgizLwxFVbtfPI30xc22
	 jxbAER7iQknArAk0eY5d3onGsaNeo521j6hST6QFFF1ZnebC64plJcoku3tPC8f6Ew
	 oxk/CdyLTl4e3m2qwiS7g+GLWpCee87dFaM+eR0jxBIUGTGpVJUh8U4F/ckPDFe0yF
	 JzTpzxYBpadz2ChIQM31tvh7sgMdx/Hf7tu6NVlwapkytxbinnwZ//sNda+0sJTVHP
	 A7u6b30P3narz47BULJM5ntZRNPW+cvKPCIkcXFDAH4N5kyuFwMWMSbtIGP8oe9H3P
	 L6SzgO3/n4V8w==
Subject: Re: [PATCH net-next 1/3] net: ethernet: cortina: Keep shared free
 queue parent-owned
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Tue, 22 Sep 2026 18:51:30 +0000
Message-ID: <179010309083.2160803.14840919814779271779@kernel.org>
In-Reply-To: <20260920-gemini-ethernet-fixes-3-v1-1-3a2a50a83d89@kernel.org>
References: <20260920-gemini-ethernet-fixes-3-v1-1-3a2a50a83d89@kernel.org>
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

- [Low] Claim that after removing the queue teardown from
  gemini_port_remove(), unbinding only the eth1 port device leaves the…

Pre-existing issues:
- [High] gemini_port_remove() (the function this patch edits) never
  clears geth->port0 / geth->port1, and geth_resize_freeq() dereferences…
- [High] geth_resize_freeq() re-arms SWFQ_EMPTY_INT_BIT in
  GLOBAL_INTERRUPT_ENABLE_4_REG unconditionally, ignoring…
- [Medium] geth_cleanup_freeq() drops every reference on each queue page
  (`while (page_ref_count(gpage->page) > 0) put_page(gpage->page);`),…

--

net: ethernet: cortina: Keep shared free queue parent-owned

The shared software free queue was torn down by every ethernet-port child
removal and then once more by the parent removal. This patch moves the
teardown to the parent only, depopulates the child devices first, masks the
free-queue interrupt after the managed handlers are gone, and makes
geth_cleanup_freeq() a no-op when no queue was allocated.

Resolves: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 2fe7fd0202d2..31bcd41c17fa 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1004,6 +1004,9 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  	unsigned int pages = len >> fpp_order;
>  	unsigned int pn;
>  
> +	if (!geth->freeq_ring)
> +		return;
> +
>  	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
>  	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
>  	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);

[Severity: High]
This is a pre-existing issue and not introduced here, but since the new
guard keys on geth->freeq_ring it may be worth looking at what the rest of
the free-queue state looks like when that pointer is NULL.

geth_setup_freeq() clears only freeq_ring on the error paths:

	kfree(geth->freeq_pages);
err_freeq:
	dma_free_coherent(geth->dev,
			  sizeof(*geth->freeq_ring) << geth->freeq_order,
			  geth->freeq_ring, geth->freeq_dma_base);
	geth->freeq_ring = NULL;
	return -ENOMEM;

geth->freeq_pages keeps pointing at the kfree()d array, and
geth_resize_freeq() re-arms the free-queue interrupt without looking at the
return value:

	geth->freeq_order = new_order;
	ret = geth_setup_freeq(geth);

	spin_lock_irqsave(&geth->irq_lock, flags);
	en |= SWFQ_EMPTY_INT_BIT;
	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
	spin_unlock_irqrestore(&geth->irq_lock, flags);

	return ret;

So after a failing gmac_open() -> geth_resize_freeq() (dma_alloc_coherent(),
kzalloc_objs(), geth_freeq_alloc_map_page() or a zero return from
geth_fill_freeq()), GLOBAL_SW_FREEQ_BASE_SIZE_REG has just been written to 0
by geth_cleanup_freeq() while SWFQ_EMPTY_INT_BIT stays enabled, and nothing
in the gmac_open() unwind masks it again.

When the free-queue-empty status then asserts, gemini_port_irq() sees
val & en & SWFQ_EMPTY_INT_BIT and returns IRQ_WAKE_THREAD, and
gemini_port_irq_thread() -> geth_fill_freeq(geth, true) walks the freed
array:

		gpage = &geth->freeq_pages[pn];
		page = gpage->page;
		...
		if (page_ref_count(page) > 1) {

Should the interrupt only be re-enabled when geth_setup_freeq() succeeded,
and should the error paths also set geth->freeq_pages to NULL?

> @@ -2391,7 +2394,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
>  		unregister_netdev(port->netdev);
>  	}
>  	clk_disable_unprepare(port->pclk);
> -	geth_cleanup_freeq(port->geth);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since this is now the whole
of the child teardown, is anything supposed to clear the parent's
back-pointer to the port?

geth->port0 / geth->port1 are only ever assigned, in
gemini_ethernet_port_probe():

	/* Assign pointer in the main state container */
	if (!id)
		geth->port0 = port;
	else
		geth->port1 = port;

The port object is the netdev private area from
devm_alloc_etherdev_mqs(), so devres frees it right after
gemini_port_remove() returns, while geth->portN still points at it.

geth_resize_freeq() then dereferences the sibling slot before any NULL
test:

	if (netdev->dev_id == 0)
		other_netdev = geth->port1->netdev;
	else
		other_netdev = geth->port0->netdev;

	if (other_netdev && netif_running(other_netdev))
		return -EBUSY;

Can unbinding one ethernet-port child and then bringing the surviving port
up (gmac_open() -> geth_resize_freeq(), or ethtool -G ->
gmac_set_ringparam()) read the freed netdev private area here and pass the
resulting garbage to netif_running()?

The same statement also dereferences NULL if the sibling port never reached
the geth->portN assignment, for example on a probe failure or
-EPROBE_DEFER, since the check below only guards other_netdev and not the
port pointer.

> @@ -2683,6 +2685,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
>  {
>  	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
>  
> +	devm_of_platform_depopulate(&pdev->dev);
> +	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
>  	geth_cleanup_freeq(geth);
>  	geth->initialized = false;
>  }

[Severity: Medium]
This is a pre-existing issue rather than something added here, but this
call site is now the only path into the forced reference drop in
geth_cleanup_freeq():

		gpage = &geth->freeq_pages[pn];
		while (page_ref_count(gpage->page) > 0)
			put_page(gpage->page);

gmac_rx() hands free-queue pages to the stack as skb fragments:

	skb_fill_page_desc(skb, frag_nr, page, page_offs + RX_INSERT_BYTES, frag_len);

If a socket still holds those skbs across unregister_netdev(), does this
loop return pages to the allocator while the queued fragments still
reference them, and does skb_release_data() then underflow the refcount?

For what it is worth, the following patch in the series, "net: ethernet:
cortina: Manage RX buffers with page_pool", drops this loop and returns
only the fragments the driver still owns, with page_pool_destroy()
deferring the final teardown, so the behaviour does not survive to the end
of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89%40kernel.org
