Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4DC4A2631
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307149; cv=none; b=GPDTHxp6AGMAxwbc9zQO5UPmY12ECs+xXxtO1WSe42630av/niYIBmUxQVSo6TVuEAg0x9Dylw+GtB4H6BHeouSxC2x5ctbFCQmucqm4ocYQOMCwuXuV7DdvbR/LAo9nKjpC6CChtAFjDERIMXM3zUwtpH8QnnBH11T5HD3at5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307149; c=relaxed/simple;
	bh=hfS2fXQduNVpm02JN6VudYG04t75r7Yk/PLREFKSlYk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuWZzMMg0RQjwh9ZhW7tmlJ7njLHazk1Nf9wibkFokgLvL9TBZRCzAhQWkOIEE9vk80pRpGptSiYeVNKJNkmqXPAYl/iQhS+lhc/uLy69In641BoZs6bz4/qp6XeEihxzsJw5IPXrvbXLilNGHuUYtGv3SFnuYHFBek0WOd7vSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouWJa8JE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouWJa8JE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F11E1F0089C;
	Tue,  6 Oct 2026 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307144;
	bh=iWqwDZeoxMTQkTT1K5JN8B4zXyknEQqptEZ29bMnVgQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ouWJa8JEErgUNKInoBtuBusB4eryp/926gar4LunGNRVMQmiO40jGnRRZda+1/YtM
	 i7b3nqN0vxuOsLfjk8bXgQwhU4X/ri3EsOn2e2BgXS3rcTQHiO0f5wVs7Mmw2NLjUl
	 G339RTkVRw/IIFN4dzp0ghy3l2iUHW+2DcKdvAi0IdjZIWaH4k4VXsrGoXTeX0OIDJ
	 xLNBjgKNJaXKYwlT0RCn5msqJ8ESEUjRsCi2Fpci5RTCUm1nG5RmRYT4uK2yedSpRg
	 XA+ioiStt7K2yq4nbZ4giPjp5aYp1JsWqLa8dY1J57TFxWj5vDsO7MvmQWr8ZzKaJ5
	 ebgyHvGq8z+4A==
Subject: Re: [PATCH net-next v3 02/12] net: ethernet: cortina: Keep shared
 free queue parent-owned
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:03 +0000
Message-ID: <179130714372.434549.14095836796572317577@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-2-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-2-3e1f25890ae8@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 (1) · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes the parent device own the shared software
  free queue (SWFQ), but the IRQ handler that refills it is still owned…
- [Medium] gemini_port_clear() clears geth->port0/port1 without any
  synchronization against sibling readers in geth_resize_freeq().

Pre-existing issues:
- [Critical] At this commit, geth_cleanup_freeq() frees each queue page
  with `while (page_ref_count(gpage->page) > 0) put_page(gpage->page);`…
- [High] This bug was not introduced by this patch, but the new
  devm_of_platform_depopulate() call now reaches it directly.

--

net: ethernet: cortina: Keep shared free queue parent-owned

This commit stops each port's remove path from tearing down the shared
software free queue. That cleanup now runs only from the parent remove
callback. The parent first depopulates both port devices and masks
GLOBAL_INTERRUPT_ENABLE_4_REG, then calls geth_cleanup_freeq(). That
function now returns early if no queue was allocated.

Closes: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 2be3e90519811..15ad9f721dd52 100644
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
This is a pre-existing issue, but gemini_ethernet_remove() is now the only
caller of geth_cleanup_freeq(). Could the page release loop further down
in this function over-release pages?

drivers/net/ethernet/cortina/gemini.c:geth_cleanup_freeq() {
    ...
		gpage = &geth->freeq_pages[pn];
		while (page_ref_count(gpage->page) > 0)
			put_page(gpage->page);
    ...
}

This loop also drops the references held by skbs that gmac_rx() passed up
the stack. Pages still referenced by sockets would then go back to the
allocator. The loop also reads the refcount of a page that may already
have been freed and reused.

If the parent is unbound, or the module is removed, while delivered skbs
are still queued, could this cause a use-after-free or a double free?

This appears to be fixed later in the series by "net: ethernet: cortina:
Preserve in-flight free queue pages". In that patch,
geth_freeq_release_pages() drops only the references the driver owns.

> @@ -2405,7 +2408,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
>  		unregister_netdev(port->netdev);
>  	}
>  	clk_disable_unprepare(port->pclk);
> -	geth_cleanup_freeq(port->geth);
>  	gemini_port_clear(port);
>  }

[Severity: Medium]
With the parent now owning the queue, what happens if only port1 is
unbound through sysfs while port0 is up?

The port driver does not set suppress_bind_attrs, so this can be done
from sysfs. After this change, gemini_port_remove() on port1 leaves
GLOBAL_SW_FREEQ_BASE_SIZE_REG programmed. It also leaves
SWFQ_EMPTY_INT_BIT set in GLOBAL_INTERRUPT_ENABLE_4_REG.

Devres then frees the port1 handler that gemini_ethernet_port_probe()
requested:

	ret = devm_request_threaded_irq(port->dev,
					port->irq,
					gemini_port_irq,
					gemini_port_irq_thread,
	...

However, gemini_ethernet_init() routes the free queue interrupt to the
port1 line:

	 *	FreeQ intr -----------> int1 ----> eth1

The queue-empty event would then arrive on an IRQ with no handler, while
port0 keeps using up fragments. A refill would only happen if an
unrelated int0 interrupt ran gemini_port_irq() for port0 and it noticed
the STATUS_4 bit. Once RX is starved, that may never happen.

Can port0 RX stall in this case?

Also, geth->port1 is now NULL, so reopening port0 would fail in
geth_resize_freeq() while the hardware queue is still live and armed:

	/* The software free queue interrupt is routed through port 1. */
	if (!geth->port1)
		return -ENODEV;

The new writel() to GLOBAL_INTERRUPT_ENABLE_4_REG runs only from
gemini_ethernet_remove(), not when port1 is unbound by itself. This looks
the same in the final state of the series.

[Severity: Medium]
What keeps gemini_port_clear() from running while the sibling port is
inside geth_resize_freeq()?

When gmac_open() runs for port0, it holds only RTNL, and
geth_resize_freeq() does:

	if (netdev->dev_id == 0)
		other_port = geth->port1;
	else
		other_port = geth->port0;
	other_netdev = other_port ? other_port->netdev : NULL;
	...
		new_size += 1 << (other_port->rxq_order + 1);

On the port1 unbind side, gemini_port_clear() runs after
unregister_netdev() has released RTNL. If port1 has no netdev, the unbind
path takes RTNL at no point. Devres then frees the netdev that contains
the port struct.

The platform bus takes no parent lock, so these two paths do not share a
lock.

Could geth_resize_freeq() read other_port->netdev or
other_port->rxq_order after the port struct has been freed?

The window gets wider later in the series. There, geth_resize_freeq()
reads geth->port1 again for enable_irq(geth->port1->irq) after
geth_setup_freeq(). geth_setup_freeq() can sleep in GFP_KERNEL and
dma_alloc_coherent() allocations.

If port1 is cleared during that window, would this be a NULL dereference?
Or a use-after-free plus an unbalanced enable_irq() on a freed IRQ?

In the final state of the series, geth_freeq_page_slots() also
dereferences geth->port0 and geth->port1 with only a NULL check.

> @@ -2706,6 +2708,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
>  {
>  	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
>  
> +	devm_of_platform_depopulate(&pdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but the new
devm_of_platform_depopulate() call now reaches it straight from the parent
remove. If a port's netdev is up, does gemini_port_remove() end up calling
phy_stop() with a NULL phydev?

gemini_port_remove()
  phy_disconnect(port->netdev->phydev)
    phy_detach()
      phydev->attached_dev->phydev = NULL;
  unregister_netdev(port->netdev)
    ... __dev_close_many()
      gmac_stop()
        phy_stop(netdev->phydev)   <-- now NULL
          struct net_device *dev = phydev->attached_dev;

phy_stop() does not check for NULL. This looks like a deterministic oops
when the parent or a port is unbound, or the module is removed, while the
interface is up.

The same ordering is present before this patch and in the final state of
the series.

> +	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
>  	geth_cleanup_freeq(geth);
>  	geth->initialized = false;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
