Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430925;
	b=NhmZ7R7umG+NLzRJUMEtzUnOyQm91RVKKo2lg+kvoJeTvilnBvrQ8SaHOKKt5K8S+5sf
	 8Pb1HM5wp0QWRz+ivkdtGJD6k/epk4Oc/8xmUeleD1MTWEnXqLmo+J1yBir3BapwbTsTa
	 a+2kAAch/0HcOg9WALCFOFYtgVhrD/JHoLh5ZNRsTsE7WThfYOXe5iWDbrX3e2nTenkGF
	 uyX5XdCzvzpDtIvZW8c1GKUNmhDsRINBT4UMIo7SaZfFUqn1kcrrUqF9I8lj4QQGbnPmz
	 oSG5cuS1vle9ngq0fLsXdzvhEMC46de1fGaCmKALg/JMTXmpZ43/ZhgvzbsRFXz4JYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430925;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WnyUVMzJSVyF8ZrXQiyEM2QiPs6JlOlSpYu+eZPl0nI=;
	b=Sb3Ub7DedwZ2C4Y2pbZwDXvkoEwR6PIqrLNIfUJqyNBGRuzXPnZicrAu68ds5o+yrWpX
	 kMxXcWIM5rRFOWkj/PXzILCHjpskXsEB7YIL965+XNPFLQy6YgITp6C1ORGehy8GS2e0k
	 BEwUXc3ryAamoCdvQzDJSB6Dp6CgHp6qvaY81NDPSwoRj8nAHWf03s2nb+v3myrDOkWs1
	 hoYHdzffneGYsqNf+ZbzgKeMY4mUJ486q+pmJb9+KPJC1zIxmJn3KKImr+wjNBDs8++b2
	 r1YmvgnYAdEV5mO/9sQWIc5h+MXNK5EE+ae+IsrGPmWxgczhBGYqOIlB2hKxyqGeH9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FH02ksK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE397606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FH02ksK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E8C1F000C4;
	Mon, 19 Oct 2026 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430924;
	bh=WnyUVMzJSVyF8ZrXQiyEM2QiPs6JlOlSpYu+eZPl0nI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FH02ksK3Owva2XIC57CXX+Fa9kQhZXg/amPjwPagwF7JdDKPl9OTOgSp3yKRom5kF
	 wEvKZJ6erDJqHVsyGjHsTfIx+YZ5Oxuh8T+pJaiVwBc9zwQCUA67p3YwbyxMP2UUwN
	 Ha6x7RKNm+avI+JoqbmsVhKY7EzOemFo6zxvaB5Mcl9kPLlLxCgF3t/mFoqwbpotTT
	 6yeBFxeeGYCMuO4VhfnFv+VIdmKW7PiDZmNjNklLesUbL8dViSCbkVjBawsdW+ERDa
	 YEr/Yytqc5tmxBdTAnv1hp1xivgNf7DL7J4l3ryO4RSv/UgL5DdMM3/qTvA+G9ECA/
	 7bjQeFQnplvdA==
Subject: Re: [PATCH net-next v5 01/14] net: ethernet: cortina: Keep shared
 free queue parent-owned
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:43 +0000
Message-ID: <179243092325.3135.5534691456764566511@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-1-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-1-b5c9e2f7b8a3@kernel.org>
X-sashiko-severity: High
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

Critical: 0 (1) · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, gemini_ethernet_remove() calls
  devm_of_platform_depopulate() (line 2689), which destroys the children…
- [High] net: cortina: MMIO access after pclk disable in remove

Pre-existing issues:
- [Critical] At this commit, geth_cleanup_freeq() releases each free-
  queue page with 'while (page_ref_count(gpage->page) > 0)…
- [High] This problem wasn't introduced by this patch, and it is still
  present at the end of the series.

--

net: ethernet: cortina: Keep shared free queue parent-owned

This patch moves cleanup of the shared software free queue into the parent
remove callback. That cleanup now runs after both port devices have been
depopulated, and it is skipped when no queue was allocated. The patch also
suppresses bind attributes on the port driver and unregisters each netdev
before disconnecting its PHY.

Closes: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 2fe7fd0202d26..bf7652b04f1ba 100644
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

[Severity: Critical]

This is a pre-existing issue, not one introduced by this patch. But now
that geth_cleanup_freeq() is the single teardown point, is the page release
loop later in this function safe?

    gpage = &geth->freeq_pages[pn];
    while (page_ref_count(gpage->page) > 0)
        put_page(gpage->page);

gmac_rx() hands references on these same pages to skbs:

    skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

Those skbs can still be sitting in socket queues when this runs from
gemini_ethernet_remove(). The same applies when it runs from
geth_resize_freeq() on ifup or ethtool -G while the other port is down.

If the refcount is forced to zero, the page goes back to the allocator while
live skbs still point at it. Wouldn't that lead to a double put_page() on the
later kfree_skb(), and to possible info leaks or corruption once the page is
reallocated?

The later commit "net: ethernet: cortina: Preserve in-flight free queue
pages" in this series seems to address this. It replaces the loop with
geth_freeq_release_pages(), which drops only the outstanding hardware
fragment references plus the base reference.

> @@ -2387,11 +2390,10 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
>  static void gemini_port_remove(struct gemini_ethernet_port *port)
>  {
>  	if (port->netdev) {
> -		phy_disconnect(port->netdev->phydev);
>  		unregister_netdev(port->netdev);

[Severity: High]

This is a pre-existing issue, not one introduced by this patch.
unregister_netdev() here ends up in gmac_stop(), and devres then frees the
netdev that embeds the port. Can rx_coalesce_timer still be queued at that
point?

gmac_stop() cancels the timer before anything else:

    hrtimer_cancel(&port->rx_coalesce_timer);
    netif_tx_stop_all_queues(netdev);
    ...
    napi_disable(&port->napi);
    ...
    gmac_enable_irq(netdev, 0);
    ...
    free_irq(netdev->irq, netdev);

While napi_disable() waits, gmac_napi_poll() can re-enable the RX IRQ
through napi_complete_done(), and gmac_irq() is still registered. If
rx_coalesce_nsecs was set with ethtool -C, gmac_irq() then re-arms the
timer:

    hrtimer_start(&port->rx_coalesce_timer, ktime,
                  HRTIMER_MODE_REL);

Nothing cancels the timer again after free_irq(). If the driver is unbound
next, gmac_coalesce_delay_expired() would call napi_schedule(&port->napi) on
freed memory.

A quick reopen would also run hrtimer_setup() in gmac_open() on a timer that
is still queued.

The managed SWFQ handler draining added to gemini_ethernet_remove() doesn't
cover this timer, and nothing later in the series seems to fix it either.
Should the timer be cancelled again after free_irq() in gmac_stop()?

> +		phy_disconnect(port->netdev->phydev);
>  	}
>  	clk_disable_unprepare(port->pclk);
> -	geth_cleanup_freeq(port->geth);
>  }

[ ... ]

> @@ -2683,6 +2686,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
>  {
>  	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
>  
> +	devm_of_platform_depopulate(&pdev->dev);

[Severity: High]

devm_of_platform_depopulate() removes the children one at a time in reverse
order, so port 1 goes first. gemini_port_remove() unregisters port 1's
netdev but never clears geth->port1. Devres then frees the refill IRQ and
the netdev that contains the port.

Port 0 is still registered and usable during that window. Could bringing
eth0 up or running ethtool -G on it then reach geth_resize_freeq() and
dereference the freed port?

    if (netdev->dev_id == 0)
        other_netdev = geth->port1->netdev;
    ...
    if (other_netdev && netif_running(other_netdev))
        return -EBUSY;
    ...
        other_port = netdev_priv(other_netdev);
        new_size += 1 << (other_port->rxq_order + 1);

If the resize goes ahead, it also sets SWFQ_EMPTY_INT_BIT in
GLOBAL_INTERRUPT_ENABLE_4_REG again, even though port 1's refill handler is
already gone.

The commit message says:

    Port 1 owns the shared refill interrupt, so prevent the children from
    being unbound independently.

This teardown order still lets port 0 outlive port 1, though.

The later commit "net: ethernet: cortina: Keep PHY-less port bound for
shared IRQ" in this series appears to close this window. It clears
geth->initialized under RTNL before depopulating, and it clears
geth->port0/port1 under RTNL in gemini_port_clear(). It also makes
geth_resize_freeq() return -ENODEV in those cases.

> +	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
>  	geth_cleanup_freeq(geth);
>  	geth->initialized = false;
>  }

[Severity: High]
By the time devm_of_platform_depopulate() returns,
gemini_port_remove() has run for both ports. Each of those calls ends
with clk_disable_unprepare(port->pclk), so both GMAC gate clocks are off
when gemini_ethernet_remove() writes GLOBAL_INTERRUPT_ENABLE_4_REG. They
are still off when geth_cleanup_freeq() goes on to touch
GLOBAL_SWFQ_RWPTR_REG and GLOBAL_SW_FREEQ_BASE_SIZE_REG.

The parent driver doesn't take a clock of its own, so nothing keeps the
block behind geth->base clocked at this point. Is that global register
space clocked independently of the port pclks? If it isn't, these
accesses hit a gated IP block. On ARM that usually ends in an external
abort rather than a silently dropped write.

Register accesses that work in gemini_ethernet_probe() don't show that
the clocks are unnecessary. Probe can run before clk_disable_unused() at
late_initcall, so gates the bootloader left on may still be enabled
then. In the remove path, the explicit clk_disable_unprepare() calls
reliably turn them off first.

Should the parent hold a reference on whichever clock feeds the global
block for its whole lifetime? Alternatively, should the port that goes
last mask the free-queue interrupt and let the queue be torn down before
it drops its pclk? Nothing later in the series seems to change this
ordering.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
