Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E6346ADB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736640; cv=none; b=Ii3eFayYIRckVZpP3mHy2yUx1iUXGxJ9rZlVNDKNeTNLPO2DbwYHHZ4cNF51gTkyacbAK381jMKl1thT0UpGywaNBZv1/UvH2ahHITEp7ThQq89WwuYi0cDB0CqKP6jd+U0h6hWr3AcSqsNQCSKYVLLwYf/9huvSHzVt7hJCNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736640; c=relaxed/simple;
	bh=JU2QAXggHJ7i4Eu+C6XWwssc/2c76vNqtoVhSTPTass=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUO83ay92KZbXoOimm80Dz8ekgxwyRMRnc071qFoXcjwKvR3a5nz1iwf6l8+kUXC30O+tO8QmHOR2vJG7LWRtewOcfLx31vDkwBYYR2I+eRH7Lkn/9ESWdSUAPDBKDGWSqKq12Bq2KN2X/VVFTV8k3ukSIIrEKXUGA+1Z6Ycgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvAeEiO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvAeEiO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A91F000FF;
	Wed, 30 Sep 2026 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736638;
	bh=jL02tx/YAdDy7CAD7wloxHmnjUYoLixggksEikSZmCY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UvAeEiO6xp3Ua4YEcU3R8gkqrbDylCGUVuAOeF3dHRVlAHAZ5FoqLTXWlr5E12B/F
	 1V2nGyq/67AmBh3IIp2p9STBkv4TBcTDaeFPa0DYvgeepnsrcW4wQrD48cx91AHTI2
	 oxtg1Ks5gn0AmEc3/twKfMvONqhLsoOVwIooBXod34p/JDPu1XFOW9ovvNiz7Mzxrs
	 PovLGo8DQT5UCPYM9ybsPdOnTCff08rLAJBuyEkJze5U+/PsYrSfqntsEaqHUYUr8A
	 JKNkdvugytPeZewLfUrmTfAhgL6LCiLK+FJ/vfoycxVLxS7h0E/COHVrAhv1KZdusU
	 AeLHsq6sI8EVw==
Subject: Re: [PATCH net-next v2 01/11] net: ethernet: cortina: Keep shared
 free queue parent-owned
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:37 +0000
Message-ID: <179073663764.434549.1944294968357082326@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-1-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-1-758a795d7a78@kernel.org>
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

- [Low] The commit message is incomplete for a stable-relevant memory-
  safety fix.
- [Low] At this commit, the new guard `if (!geth->freeq_ring) return;` in
  geth_cleanup_freeq() treats NULL as meaning 'no queue'.
- [Low] The patch moves all shared global-register teardown in the remove
  path so it runs after devm_of_platform_depopulate().
- [Low] The concern is that GLOBAL_INTERRUPT_SELECT_4_REG (0xFF000003,
  line 2429) routes the free-queue-empty interrupt to int1 (port1's…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  geth->port0/geth->port1 are written only in…
- [High] This problem wasn't introduced by this patch, but
  gemini_port_remove() calls phy_disconnect(port->netdev->phydev) before…
- [High] At this commit, geth_cleanup_freeq() forces each free-queue
  page's refcount to zero with `while (page_ref_count(gpage->page) > 0)…

--

net: ethernet: cortina: Keep shared free queue parent-owned

This commit stops each Gemini port child device from tearing down the
software free queue that both ports share. Only the parent's
gemini_ethernet_remove() now does the cleanup, after it depopulates the
children and disables the free-queue interrupt. It also adds a NULL check
on freeq_ring in geth_cleanup_freeq().

Resolves: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

> net: ethernet: cortina: Keep shared free queue parent-owned
>
> The software free queue is shared by both Ethernet ports, but each
> child removal tears it down. The parent removal then tears it down once
> more. This can destroy the queue while the sibling port is active and can
> free it repeatedly.

[ ... ]

> Reported-by: Myeonghun Pak <mhun512@gmail.com>
> Resolves: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/

[Severity: Low]
Is the order described here accurate for the common case?

Before this patch, gemini_ethernet_remove() called geth_cleanup_freeq()
first, while both netdevs were still registered. Devres then depopulated
the children, and each gemini_port_remove() freed the queue again. So a
plain rmmod or parent unbind could free the queue up to three times, not
only after a single-port unbind.

This fixes a repeated free of the shared queue. Should it carry a Fixes:
tag? The per-child geth_cleanup_freeq(port->geth) call removed here was
added by:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Also, Resolves: isn't a standard trailer. Should it be Closes:, placed
directly after Reported-by:? That is what checkpatch expects.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 2fe7fd0202d26..31bcd41c17fad 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1004,6 +1004,9 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  	unsigned int pages = len >> fpp_order;
>  	unsigned int pn;
>  
> +	if (!geth->freeq_ring)
> +		return;
> +

[Severity: Low]
This guard treats a NULL freeq_ring as "no queue allocated". However,
geth_cleanup_freeq() itself does not keep that rule:

	kfree(geth->freeq_pages);

	dma_free_coherent(geth->dev,
			  sizeof(*geth->freeq_ring) << geth->freeq_order,
			  geth->freeq_ring, geth->freeq_dma_base);

Both freeq_pages and freeq_ring are left dangling afterwards. Only the
error path in geth_setup_freeq() sets freeq_ring to NULL. Can the guard
detect a queue that has already been cleaned up?

No second cleanup call seems reachable at this commit. The later patch in
this series, "net: ethernet: cortina: Preserve in-flight free queue
pages", clears freeq_ring, freeq_pages, freeq_page_bitmap and
num_freeq_pages at the end of geth_cleanup_freeq() and on every
geth_setup_freeq() error path.

>  	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
>  	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
>  	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);

[Severity: High]
This isn't a bug introduced by this patch. Further down in
geth_cleanup_freeq(), the refcount of every free queue page is forced to
zero:

		gpage = &geth->freeq_pages[pn];
		while (page_ref_count(gpage->page) > 0)
			put_page(gpage->page);

Does this also drop the references held by skb fragments? gmac_rx() hands
these pages to the stack through skb_fill_page_desc() and
napi_gro_frags(). Those skbs can outlive the queue, so this looks like a
use-after-free of in-flight RX pages.

This is fixed later in the series by "net: ethernet: cortina: Preserve
in-flight free queue pages". There, geth_freeq_release_pages() drops only
the outstanding per-fragment hardware references and the queue's base
reference. The related DMA map/unmap size mismatch in this function is
fixed by "net: ethernet: cortina: Correct free queue DMA mappings".

[ ... ]

> @@ -2391,7 +2394,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
>  		unregister_netdev(port->netdev);
>  	}
>  	clk_disable_unprepare(port->pclk);
> -	geth_cleanup_freeq(port->geth);
>  }

[Severity: High]
This is a pre-existing issue. The new devm_of_platform_depopulate() call
in gemini_ethernet_remove() now leads straight here. What happens if the
interface is still up when it is removed?

gemini_port_remove() does:

	if (port->netdev) {
		phy_disconnect(port->netdev->phydev);
		unregister_netdev(port->netdev);
	}

phy_disconnect()->phy_detach()->phy_detach_internal() runs:

	phydev->attached_dev->phydev = NULL;

For an IFF_UP interface, unregister_netdev() then calls ndo_stop:

gemini_ethernet_remove()
  devm_of_platform_depopulate()
    gemini_ethernet_port_remove()
      gemini_port_remove()
        phy_disconnect()              /* netdev->phydev = NULL */
        unregister_netdev()
          gmac_stop()
            phy_stop(netdev->phydev)  /* NULL */

Can phy_stop() oops when it dereferences phydev->attached_dev?

Unbinding a single port reaches the same path. The order dates back to
3e813d61401a ("net: gemini: Clean up phy registration") and is unchanged
at the end of the series.

[Severity: High]
This isn't a bug introduced by this patch. Now that a sibling port is
meant to keep running after the other port is removed, what happens to
geth->port0 and geth->port1?

They are only set in gemini_ethernet_port_probe():

	if (!id)
		geth->port0 = port;
	else
		geth->port1 = port;

Nothing clears them: not gemini_port_remove(), and not the probe error
paths after the assignment (devm_request_threaded_irq(),
gmac_setup_phy() or register_netdev() failure).

The port struct is the netdev_priv() of a netdev allocated with
devm_alloc_etherdev_mqs() on the port device. It is freed when that port
unbinds or fails probe.

geth_resize_freeq() then dereferences the sibling unconditionally:

	if (netdev->dev_id == 0)
		other_netdev = geth->port1->netdev;
	else
		other_netdev = geth->port0->netdev;

It follows up with netif_running(other_netdev) and
other_port->rxq_order. Could this be a use-after-free after, for
example, a sysfs unbind of one port followed by ip link set up or
ethtool -G on the surviving port?

The same seems possible in two other cases:

- port0 fails probe (for example, no PHY is found) and eth1 is then
  brought up.
- During depopulate, one child has been freed while the other is still
  registered.

These dereferences are still there at the end of the series, and more are
added: synchronize_irq(geth->port1->irq) in geth_resize_freeq(), and
geth->port0->rxq_order / geth->port1->rxq_order in geth_setup_freeq().

[Severity: Low]
gemini_ethernet_init() routes the FreeQ interrupt to int1, which is
port1's line:

	writel(0xFF000003, geth->base + GLOBAL_INTERRUPT_SELECT_4_REG);

With the per-port cleanup gone, unbinding only port1 leaves
SWFQ_EMPTY_INT_BIT enabled while port0 keeps using the shared queue. No
handler is left on int1. Is that a problem in practice?

>From the code it looks harmless:

- port0's gemini_port_irq() is registered with IRQF_SHARED and checks the
  global SWFQ_EMPTY bit in GLOBAL_INTERRUPT_STATUS_4_REG, whatever the
  routing.
- gmac_napi_poll() also refills the queue through geth_fill_freeq().
- free_irq() masks port1's line at the interrupt controller.

Before this patch, the same scenario was a use-after-free of the freed
queue.

[ ... ]

> @@ -2683,6 +2685,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
>  {
>  	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
>  
> +	devm_of_platform_depopulate(&pdev->dev);
> +	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
>  	geth_cleanup_freeq(geth);

[Severity: Low]
When these global register writes run, both children have already gone
through gemini_port_remove() and called clk_disable_unprepare(port->pclk).

The gmac0-gate and gmac1-gate clocks in drivers/clk/clk-gemini.c are
registered with flags 0, so they really do switch off. The parent node in
gemini.dtsi has no clocks property.

Does the global register block at 0x60000000 depend on either GMAC gate?
If so, some accesses could be lost or could stall the bus:

- the writel() to GLOBAL_INTERRUPT_ENABLE_4_REG here
- the GLOBAL_SWFQ_RWPTR_REG and GLOBAL_SW_FREEQ_BASE_SIZE_REG accesses in
  geth_cleanup_freeq()

Before this patch, the parent's cleanup ran while those clocks were still
enabled.

This may be fine. gemini_ethernet_probe() already reads
GLOBAL_TOE_VERSION_REG before any child enables PCLK, which suggests the
global block has its own clock.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
