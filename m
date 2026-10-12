Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B157379C4A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830730; cv=none; b=quNcBegRJKdoiEFyjdM7wk2V/+9djenrqo1Eh8nLsscCzs1ULgBx8es7wbVOJO4wyqc/M/k9MZ6/ta3fOxfJ4z+m27natgV7DCyUhqvKH1+RaKMBHYqhLJyjN87oW7SUIBkQD/O3Xkq3iqFwv6o4PnoN/FbNQaLSBJgesiOWY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830730; c=relaxed/simple;
	bh=N1LGJkJtjVzU3rHCAxeqBNLbazMNV4NVoNp2dnUvU14=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PT+AcYK/kc1jVvO+sJoWYzu5R6ozy/6ngoZqCmSxbzdjd4lNWwAydox259VR5LngeYN3C5LdhKYklCXfRwQI5aUoAFedTjkRoWWB8m5NiQMntYijcCBaOC1oAJZ04Fv/1G0QtCx5yxhq57fWCaijWy9cYj0i/iVqzttLorEKOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaOFBV7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaOFBV7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478D1F0089B;
	Mon, 12 Oct 2026 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830728;
	bh=zpPYd+H4INT9bGEFLZpq/s+51wnsQ7lmdsFOSDgvJpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FaOFBV7EokcKkD9rmSBN/BRs7xfC1GRONvcgEtF7sr2Rh72s4vOtYVk/LpWo0yzjS
	 z4uvVlmnFreHIL9M4b21tYK/3+X5a2uN5cJOcG0o+KozmZqbug2UkXZz5PH47YjVbl
	 EdmXhDuc4loMWCKRql85nvt8aR99Rbr7gmtxAM8lzZDxQF5G3jlFNLnNsOdX86Wku1
	 X6m/EWYcigOc21YTNfzKCQpvDJURjdgXAdw92GTruLHL/oiU9QW1WIYRqhiixGjE+W
	 Jd6GEdq165Hm2aNqx6ISRh5HPDF41mD59OvGd16mat2Fi55N4as7AIJTTTVekeBh9m
	 8KsPWqXq+bENg==
Subject: Re: [PATCH net-next v4 01/15] net: ethernet: cortina: Keep shared
 free queue parent-owned
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:27 +0000
Message-ID: <179183072736.434549.11981012377638415771@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-1-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-1-4b1631b08f5d@kernel.org>
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

- [Low] The commit message gets the old teardown order backwards for the
  common path.

Pre-existing issues:
- [High] The RX coalescing hrtimer can be re-armed after gmac_stop()
  cancels it, and nothing cancels it again.
- [High] Discarded because a later patch in the series fixes it.
- [High] Discarded because a later patch in the series fixes it.
- [High] Discarded because a later patch in the series fixes it.

--

net: ethernet: cortina: Keep shared free queue parent-owned

This commit moves teardown of the shared software free queue out of the
per-port removal path and into the parent's remove. That teardown now runs
after both port devices are depopulated and the free queue interrupt is
masked. It also adds a NULL guard to geth_cleanup_freeq(), suppresses bind
attributes on the port driver, and unregisters each netdev before
disconnecting its PHY.

Closes: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

> The software free queue is shared by both Ethernet ports, but each
> child removal tears it down. The parent removal then tears it down once
> more. This can destroy the queue while the sibling port is active and
> can free it repeatedly.

[Severity: Low]
Is the old teardown order described correctly here? The parent driver is
unregistered first in gemini_ethernet_module_exit():

    platform_driver_unregister(&gemini_ethernet_driver);
    platform_driver_unregister(&gemini_ethernet_port_driver);

The children were created with devm_of_platform_populate(), and devres
actions run only after .remove() returns. On module unload or parent unbind,
the old gemini_ethernet_remove() therefore called geth_cleanup_freeq()
first. Both child netdevs were still registered at that point and could
still be doing DMA. Each child's gemini_port_remove() then called it again,
so the queue was freed three times.

The old cleanup also looks like it oopses when no interface was ever opened.
gemini_ethernet_init() sets freeq_order = 1, so
pages = (1 << 1) >> (12 - 11) = 1. geth_cleanup_freeq() then dereferences
geth->freeq_ring[0] while freeq_ring is NULL. The message mentions this
only as "Guard cleanup for paths where no queue was allocated".

Could the message describe these two cases, for the benefit of stable
backporters?

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

[Severity: High]
This isn't a bug introduced by this patch, but does the put_page() loop
later in geth_cleanup_freeq() also drop references owned by RX skbs that
are still in flight?

    gpage = &geth->freeq_pages[pn];
    while (page_ref_count(gpage->page) > 0)
        put_page(gpage->page);

Pages passed up the stack with skb_fill_page_desc() hold their own
references. This loop can free pages that socket-queued skbs still use, and
it can underflow the page refcount. A CAP_NET_ADMIN user can reach it by
taking the interface down and then resizing the ring or reopening.

A later patch in the series, "net: ethernet: cortina: Preserve in-flight
free queue pages", appears to fix this. It replaces the loop with
geth_freeq_release_pages(), which drops only gpage->fragments plus the
driver's base reference.

[Severity: High]
This is also a pre-existing issue, but can a failed geth_setup_freeq()
inside geth_resize_freeq() leave the next open running without a queue?

geth_resize_freeq() commits the new order before the setup that can fail.
It also re-enables SWFQ_EMPTY whatever ret is:

    geth->freeq_order = new_order;
    ret = geth_setup_freeq(geth);
    ...
    en |= SWFQ_EMPTY_INT_BIT;
    writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);

After a failure, freeq_pages still points at the array that
geth_cleanup_freeq() freed. On the next open, this shortcut returns 0:

    if (geth->freeq_order == new_order)
        return 0;

gmac_open() then carries on, and geth_fill_freeq() indexes the freed array:

    gpage = &geth->freeq_pages[pn];

This appears to be fixed later in the series by "net: ethernet: cortina:
Drain free queue IRQ before resize" and "net: ethernet: cortina: Rebuild
free queue metadata for RX ring changes". Those patches do the following:

  - NULL out freeq_pages, freeq_ring and the bitmaps on cleanup and on
    setup errors
  - take the fast path only when freeq_ring is non-NULL
  - re-enable the IRQ source only on success
  - propagate a resize failure from open

[ ... ]

> @@ -2387,11 +2390,10 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
>  static void gemini_port_remove(struct gemini_ethernet_port *port)
>  {
>  	if (port->netdev) {
> -		phy_disconnect(port->netdev->phydev);
>  		unregister_netdev(port->netdev);
> +		phy_disconnect(port->netdev->phydev);
>  	}
>  	clk_disable_unprepare(port->pclk);
> -	geth_cleanup_freeq(port->geth);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but unregister_netdev() here
ends up in gmac_stop(). Can the RX coalescing hrtimer still be pending
when gmac_stop() returns?

gmac_stop() cancels the timer first. It masks the port IRQs and frees the
IRQ only later:

    hrtimer_cancel(&port->rx_coalesce_timer);
    netif_tx_stop_all_queues(netdev);
    gmac_disable_tx_rx(netdev);
    gmac_stop_dma(port);
    napi_disable(&port->napi);
    ...
    gmac_enable_irq(netdev, 0);
    ...
    free_irq(netdev->irq, netdev);

In that window, a NAPI poll that is already running can finish and
re-enable the RX IRQ through gmac_napi_poll()->gmac_enable_rx_irq(). When
rx_coalesce_nsecs is non-zero, gmac_irq() then re-arms the timer:

    hrtimer_start(&port->rx_coalesce_timer, ktime,
                  HRTIMER_MODE_REL);

Nothing cancels the timer again after free_irq().

If the interface is reopened, gmac_open() calls hrtimer_setup() on a timer
that may still be queued. If the device is removed instead, freeing the
netdev also frees the port that embeds the timer. When the timer fires,
gmac_coalesce_delay_expired() calls napi_schedule(&port->napi) on freed
memory.

Triggering this needs a non-zero rx-usecs set with ethtool -C and RX
traffic arriving during ifdown. Would a final hrtimer_cancel() after
free_irq() close the window?

[Severity: High]
This is a pre-existing issue as well, but gemini_port_remove() still does
not clear geth->port0 or geth->port1. Can geth_resize_freeq() then
dereference a stale or NULL sibling pointer?

    if (netdev->dev_id == 0)
        other_netdev = geth->port1->netdev;
    else
        other_netdev = geth->port0->netdev;

gemini_ethernet_port_probe() also publishes the pointer before steps that
can still fail, and no error path clears it:

    if (!id)
        geth->port0 = port;
    else
        geth->port1 = port;

This looks reachable under RTNL from gmac_open() or the set_ringparam path,
either during depopulate or after a failed probe. The suppress_bind_attrs
change in this patch narrows the exposure.

A later patch in the series, "net: ethernet: cortina: Keep PHY-less port
bound for shared IRQ", appears to fix this. It adds
gemini_port_publish()/gemini_port_clear(), and geth_resize_freeq() returns
-ENODEV unless both ports are present and geth->initialized is set.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
