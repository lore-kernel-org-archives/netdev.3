Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807536A364
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830731; cv=none; b=ZUMLsnoYiCY4UNVzsqiuWqdbbGNKix/R9+eFDY17AVfNyDzbwbOeb3c/ir6xnR7hor3QHs8iouKAOxy8L9IcEHaOFNiBxv7sVxiuhqHiXe2p6EPQz6Kd8IK4S6CGEdKyWigNAo6tGbKm4xkdCEjiVIXwry6CKOYSjy9l77KpWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830731; c=relaxed/simple;
	bh=gmSV40KBOMFXEYl4r6Lum8yUR0xtZbiKDEX/X9NEm8s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZ1JzPpfrh/15EXAsUyTvcZNz/3reKMMJHCWrly16sB/l2RoTjhPC5VG0ePfVGJu9VCj6MtiMnXhoLvspRzXo3fB7YxEE6TtyDQSbzd1Db2m5u6xa0/Vtc9i17QBNrqUmn2MFMmEw1gYYR/gGYEHI+ev7kYY+4VYlGx5IIf3akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm5Skffk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm5Skffk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE601F008A2;
	Mon, 12 Oct 2026 18:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830729;
	bh=xX5toCkzw10GWFAcZNTBXxEAh03oosDpDlVmegz6kEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dm5SkffkkZ1yulc9T79TZS1CsXGaXU/2qE1uIwuUO/2zrtXNVK4am3ZtRLQcO/2bX
	 DCwI/mFwxpfzQPNZzTqAOucPPISv9tld/Y9gAJkMUm7KGeh3z9RMXac/Nwh5L8cIIK
	 VfnAKtBDfXWieq277JruGlnS4Coag1yvI7FAtoLUSDc72He9ao4i317A5pp5f/N2+w
	 90qdPnuo7A0+z/RqoPoEJG3k0mCYHToUBmLNQCzu0agngLxHNsU7SXDMKw8zc1dw4M
	 wmLknUIOi8kHL3EMD2pxCreLXdwzCzrIKjAuqLUGB0TgZWlwBPQ40vfIWcQ36G++J3
	 iFLyox44XUisA==
Subject: Re: [PATCH net-next v4 02/15] net: ethernet: cortina: Keep PHY-less
 port bound for shared IRQ
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:28 +0000
Message-ID: <179183072852.434549.12989194442523430973@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-2-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-2-4b1631b08f5d@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch moves gemini_port_publish()/gemini_ethernet_init()
  after devm_request_threaded_irq().
- [Medium] With the new IRQ-only peer (port->netdev == NULL),
  geth_resize_freeq() sizes the queue from one port only.
- [Medium] gemini_port_clear(), new in this patch, is called from every
  gemini_port_remove() and unconditionally sets geth->initialized =…

Pre-existing issues:
- [High] In this commit, geth_resize_freeq() masks SWFQ_EMPTY_INT_BIT
  under irq_lock and then calls geth_cleanup_freeq(), which does…
- [Low] In this commit, geth_resize_freeq()'s kernel-doc says it 'gets
  called at least once during probe()', and the comment above…

--

net: ethernet: cortina: Keep PHY-less port bound for shared IRQ

The software free queue interrupt is routed through port 1. This commit
keeps a Gemini child port bound as an IRQ-only port when it has no PHY
description. A port is now published to the parent only after its IRQ
and optional netdev are ready, and RTNL protects the port pointers and
the initialized flag.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index bf7652b04f1ba..ec2e476883376 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1051,10 +1053,17 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	u32 en;
>  	int ret;
>  
> +	ASSERT_RTNL();
> +
> +	/* The software free queue interrupt is routed through port 1. */
> +	if (!geth->initialized || !geth->port0 || !geth->port1)
> +		return -ENODEV;
> +
>  	if (netdev->dev_id == 0)
> -		other_netdev = geth->port1->netdev;
> +		other_port = geth->port1;
>  	else
> -		other_netdev = geth->port0->netdev;
> +		other_port = geth->port0;
> +	other_netdev = other_port ? other_port->netdev : NULL;

[Severity: Medium]
If the peer is IRQ-only, other_netdev is now NULL here, so the shared
queue size comes from this port alone. Can the new order then equal the
freeq_order = 1 that gemini_ethernet_init() sets before any queue is
allocated?

Suppose the interface is down and someone runs "ethtool -G ethX rx 1".
gmac_set_ringparam() does:

    port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
    err = geth_resize_freeq(port);

This gives rxq_order = 0, new_size = 2 and new_order = 1. That matches
the sentinel, so this shortcut returns success:

    if (geth->freeq_order == new_order)
        return 0;

geth_setup_freeq() is never called and SWFQ_EMPTY is never enabled. A
later gmac_open() takes the same shortcut. The port then comes up with
GLOBAL_SW_FREEQ_BASE_SIZE_REG still zero.

Can RX work in that state?

Later in the series, "net: ethernet: cortina: Drain free queue IRQ
before resize" removes the sentinel. It also changes the shortcut to
require geth->freeq_ring && geth->freeq_order == new_order. Then "net:
ethernet: cortina: Preserve in-flight free queue pages" rejects
new_order <= fpp_order with -EINVAL.

>  
>  	if (other_netdev && netif_running(other_netdev))
>  		return -EBUSY;
> @@ -1065,7 +1074,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  		   new_size,
>  		   port->rxq_order);
>  	if (other_netdev) {
> -		other_port = netdev_priv(other_netdev);
>  		new_size += 1 << (other_port->rxq_order + 1);
>  		netdev_dbg(other_netdev, "port %d size: %d order %d\n",
>  			   other_netdev->dev_id,

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Further
down in geth_resize_freeq(), the SWFQ interrupt is masked and the queue
is torn down straight after:

    en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
    en &= ~SWFQ_EMPTY_INT_BIT;
    writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
    spin_unlock_irqrestore(&geth->irq_lock, flags);

    /* Drop the old queue */
    if (geth->freeq_ring)
        geth_cleanup_freeq(geth);

Nothing here waits for a gemini_port_irq_thread() that is already
awake. That thread calls geth_fill_freeq(), which dereferences
geth->freeq_pages[pn] under freeq_lock. geth_cleanup_freeq() calls
kfree(geth->freeq_pages) without taking freeq_lock.

Can the thread touch freeq_pages after it has been freed?

After the refill, the thread also does:

    irqmask |= readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
    writel(irqmask, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);

This could re-enable SWFQ_EMPTY while geth_setup_freeq() is only half
done.

The next patch in the series, "net: ethernet: cortina: Drain free queue
IRQ before resize", fixes this. It calls disable_irq(geth->port1->irq)
before the teardown and enable_irq() afterwards.

[ ... ]

> +static void gemini_port_clear(struct gemini_ethernet_port *port)
> +{
> +	struct gemini_ethernet *geth = port->geth;
> +
> +	ASSERT_RTNL();
> +
> +	if (!port->id && geth->port0 == port)
> +		geth->port0 = NULL;
> +	else if (port->id && geth->port1 == port)
> +		geth->port1 = NULL;
> +	else
> +		return;
> +
> +	geth->initialized = false;

[Severity: Medium]
Before this patch, geth->initialized was only cleared in
gemini_ethernet_remove(). Now removing a single child clears it, even
though the sibling port and the shared queue are still in use.

Suppose that child is re-created while the parent and sibling stay
bound. gemini_port_publish()->gemini_ethernet_init() then sees
!initialized with both ports set, and runs the cold init again:

    writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
    ...
    writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
    ...
    geth->freeq_order = 1;
    geth->initialized = true;

Would this mask the surviving port's interrupts and deprogram the free
queue while that port may have DMA running?

In this commit, it also resets geth->freeq_order to 1 while freeq_ring
and freeq_pages are still allocated at the old order. The next
geth_resize_freeq()->geth_cleanup_freeq() call derives both the page
count and the dma_free_coherent() size from freeq_order:

    unsigned int len = 1 << geth->freeq_order;
    unsigned int pages = len >> fpp_order;
    ...
    dma_free_coherent(geth->dev,
                      sizeof(*geth->freeq_ring) << geth->freeq_order,

Does that leak the remaining pages and DMA mappings, and free the
coherent ring with the wrong size?

OF dynamic reconfiguration looks like one way to reach this.
of_platform_notify() destroys a populated child on
OF_RECONFIG_CHANGE_REMOVE (for example, an overlay that sets status =
"disabled") and re-creates it on revert. The child driver sets
suppress_bind_attrs, so sysfs unbind does not trigger it.

Later in the series the freeq_order overwrite goes away, but the
register reset stays. After the reset, the fast path in
geth_resize_freeq() can return success without reprogramming the
zeroed GLOBAL_SW_FREEQ_BASE_SIZE_REG.

> +}
> +

[ ... ]

> @@ -2446,6 +2474,20 @@ static void gemini_ethernet_init(struct gemini_ethernet *geth)
>  	 * set up and enable the queue IRQ. FIXME: fragile.
>  	 */
>  	geth->freeq_order = 1;
> +	geth->initialized = true;
> +}

[Severity: Low]
This isn't a bug introduced by this patch, but two comments say the
queue gets resized during probe(): this one, and the kernel-doc of
geth_resize_freeq():

 * This gets called at least once during probe() so the device queue gets
 * "resized" from the hardware defaults.

geth_resize_freeq() is only called from gmac_open() and
gmac_set_ringparam(). No probe path calls it.

This patch adds ASSERT_RTNL() and a new -ENODEV return to
geth_resize_freeq(). Could the kernel-doc be updated at the same time?

Later in the series, "net: ethernet: cortina: Drain free queue IRQ
before resize" rewrites the kernel-doc to say it is called when a port
is opened or its RX ring size changes. That patch also removes the
freeq_order = 1 sentinel and this comment.

[ ... ]

> @@ -2541,15 +2583,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  	reset_control_reset(port->reset);
>  	usleep_range(100, 500);
>  
> -	/* Assign pointer in the main state container */
> -	if (!id)
> -		geth->port0 = port;
> -	else
> -		geth->port1 = port;
> -
> -	/* This will just be done once both ports are up and reset */
> -	gemini_ethernet_init(geth);
> -
>  	platform_set_drvdata(pdev, port);

[Severity: Medium]
Moving gemini_ethernet_init() from here changes when it runs relative
to the IRQ request. Before, the second port to probe (normally port 1,
whose line carries the SWFQ interrupt) ran it right after its reset. So
GLOBAL_INTERRUPT_ENABLE_0..4 were zeroed, STATUS_0..4 acked and
SELECT_0..4 programmed before that port's handler was installed.

Now the handler is installed first:

    ret = devm_request_threaded_irq(port->dev,
                                    port->irq,
                                    gemini_port_irq,
                                    gemini_port_irq_thread,
                                    IRQF_SHARED,
                                    port_names[port->id],
                                    port);

gemini_port_publish()->gemini_ethernet_init() runs only afterwards. For
a port with a PHY, that is after gmac_setup_phy() and
register_netdevice().

During that window the interrupt registers still hold bootloader or
reset state. freeq_order, freeq_frag_order and freeq_pages are still
zero from devm_kzalloc().

If SWFQ_EMPTY_INT_BIT is enabled and pending at that point,
gemini_port_irq() only checks:

    if (val & en & SWFQ_EMPTY_INT_BIT) {

and wakes the thread. gemini_port_irq_thread()->geth_fill_freeq() then
computes:

    m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;

With freeq_order == 0, that is a shift by a huge unsigned count. It
then dereferences:

    gpage = &geth->freeq_pages[pn];

with freeq_pages == NULL. Could this oops during boot?

If the thread runs after init instead, it ORs SWFQ_EMPTY_INT_BIT back
into GLOBAL_INTERRUPT_ENABLE_4_REG for a queue with no base programmed.

This needs the bootloader or reset state to leave SWFQ_EMPTY enabled,
pending and routed to int1, so not every board may hit it. The ordering
is still the same at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
