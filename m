Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0F364934;
	Mon, 19 Oct 2026 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381832; cv=none; b=B45+gfPLHbAf3yUsEk/EBLOU3QnArBkS1yb9NN83b6Gg6e4aPElb4guAyoASUXUjrMXtsJhRYZuwj55Ff3cjv8+nRaAUk57pJOuHNtYGTlXa0QNVGSWGgx7oNG8xeLjgsUicuT7XI+6GBYmx/7RZuZp8XNzxOG0NS3OXA50ue/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381832; c=relaxed/simple;
	bh=qSeegf8NEZ7pE6we0K9CHOzDvlKVU++pLnONGpjoMkQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjTVYzS2U82W+DyQnoxr/RjfUDBNSCIAeG2PKQxjIRaTt2HP6lzUAd4MBSiHeKJqo29+xyeuQCmTjG0iYcH3lZ51qq56jvbqfHg2v8WJzirgu89vJNAVilL5MbvNOXlJ4xJ9j5DSplVO1I1sa8ILkhoJGacAlgnrf+PClveh/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGNfXvpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGNfXvpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4AF1F000C4;
	Mon, 19 Oct 2026 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792381830;
	bh=ggM4ukaiu3o/QTb4f//d4T2wt9h9pAoM47LHlCXnduE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NGNfXvpiOcY0ZcLhrnWcf2lC0HXZYTJmVNtVdp7XOrRNmRVPwUx/fXC2pKIokDtH9
	 5d50W5kAkfMiDwBHRZgmrVvDCt/PT9JC5zjW+2cLKk5spZ2tCgOPVIMfM9GOUHgJ1P
	 tTj22bHg9sFhmfnWVWcK+AmM0dywfofJKpqtb9Cac41djRl3QaOsaXuEDe7VoDNPM0
	 j0w+K3TzL4UT+ZIs0V6sbaQSrYeqOIkkcCB+RzLoiWBkPQauN4zgJ67TVH9xJaloU4
	 V2U5+zgjkbz148ScGfOEXxObxzopxV2TS0AYsrgKdrc239P11vkLyZcpf15ZEQDRGZ
	 hbVmQGkR+sUng==
Subject: Re: [PATCH net] net: sungem: shut down the link timer before freeing
 device state
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ae878000@gmail.com
Date: Mon, 19 Oct 2026 03:50:29 +0000
Message-ID: <179238182949.3135.11312717950838694999@kernel.org>
In-Reply-To: <179229264512.3933686.6151403340581004321.sungem@gmail.com>
References: <179229264512.3933686.6151403340581004321.sungem@gmail.com>
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

Critical: 0 · High: 3 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch leaves the root cause named in its own commit message
  in place, and the new comment in gem_remove_one() records it as…
- [High] In gem_remove_one()
  (drivers/net/ethernet/sun/sungem.c:2798-2811)…
- [High] net: sungem: incomplete fix leaves link_timer active when
  interface is down

--

net: sungem: shut down the link timer before freeing device state

The ethtool link-settings and nway-reset callbacks can arm link_timer
while the interface is administratively down. On removal,
unregister_netdev() skips ndo_stop(), so the timer could outlive the
private data. This patch adds timer_shutdown_sync() in gem_remove_one()
after unregister_netdev() and before cancel_work_sync() on reset_task.

> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index dc5638d105dbb..e8d3ac7b17962 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -2797,6 +2797,9 @@ static void gem_remove_one(struct pci_dev *pdev)
>  
>  		unregister_netdev(dev);
>  
> +		/* Link settings can restart the timer while the interface is down. */
> +		timer_shutdown_sync(&gp->link_timer);
> +

[Severity: High]
This only stops link_timer on the removal path. The timer can still be
armed on a down interface, and the damage it does there does not
require the device to be removed.

gem_set_link_ksettings() and gem_nway_reset() check only
netif_device_present(). gem_begin_auto_negotiation() takes its
"store the settings and return" shortcut only when the device is not
present. So with the interface down, either before the first
gem_open() or after gem_close(), ethtool -s or ethtool -r still
accesses the PHY over MDIO with gp->cell_enabled == 0. It then calls
mod_timer() on link_timer.

When gem_link_timer() later sees the link come up, the chain is:

gem_link_timer()
  netif_carrier_on(dev)
  gem_set_link_modes()
    gem_start_dma()
      enable TX/RX DMA and MAC, gem_enable_ints(), RXDMA_KICK

At that point the descriptor rings were either never programmed,
because gem_do_start() has not run yet, or have already been released
by gem_clean_rings() in gem_do_stop(). No IRQ handler is registered
either.

Is bus mastering guaranteed to be off in both of those states? If not,
kicking RX DMA here looks like memory corruption rather than just a
stray register write. Even with bus mastering off, unmasking
interrupts with no handler can get a shared INTx line disabled for its
other users.

It may not take a real link to get there. After gem_close(),
gem_stop_phy() has put the MIF into bit-bang mode. A frame-mode read
in __sungem_phy_read() can then time out and return 0xffff, and
genmii_poll_link() would read that as BMSR_LSTATUS and
BMSR_ANEGCOMPLETE both set.

The suspend path has the same hole. For !netif_running(dev),
gem_suspend() calls netif_device_detach() and returns without touching
link_timer. A timer armed this way keeps re-arming every 1.2 seconds
and accessing MMIO and MDIO across system suspend. The commit message
says "Keep ordinary close and suspend timer cancellation restartable",
but for a down interface the suspend path never cancels the timer.

Would it be better for gem_set_link_ksettings() and gem_nway_reset(),
or gem_begin_auto_negotiation() itself, to treat !netif_running() the
same way as !netif_device_present()? They would only store
gp->want_autoneg and gp->phy_mii.speed/duplex, and gem_init_phy()
would apply them on the next open. Then link_timer could never be
armed on a closed device, and this timer_shutdown_sync() in
gem_remove_one() would no longer be needed for that case.

[Severity: High]
This comment records the root cause from the commit message as expected
behaviour. Should gem_set_link_ksettings() and gem_nway_reset() check
netif_running() instead?

Both callbacks check only device presence:

drivers/net/ethernet/sun/sungem.c:gem_set_link_ksettings() {
    ...
	/* Apply settings and restart link process. */
	if (netif_device_present(gp->dev)) {
		timer_delete_sync(&gp->link_timer);
		gem_begin_auto_negotiation(gp, cmd);
	}
    ...
}

gem_begin_auto_negotiation() takes its "just store the settings" shortcut
only when !netif_device_present(gp->dev). On a closed interface it goes on
to program the PHY through setup_aneg()/setup_forced() and then calls
mod_timer() on link_timer.

By that point gem_close() has already run gem_do_stop() (gem_stop_dma(),
gem_reset(), gem_clean_rings(), free_irq()), then pci_disable_device()
and gem_put_cell(). On CONFIG_PPC_PMAC, gem_put_cell() gates the GMAC
clock.

gem_link_timer() checks neither the running state nor the present state.
On link-up the call chain is:

ethtool -s / ethtool -r on a down interface
  gem_set_link_ksettings() / gem_nway_reset()
    gem_begin_auto_negotiation()
      mod_timer(&gp->link_timer, ...)
gem_link_timer()
  netif_carrier_on(dev)
  gem_set_link_modes()
    gem_start_dma()
      enables TX/RX DMA and the MAC, gem_enable_ints(), writes RXDMA_KICK

Can this re-enable DMA and unmask interrupts on a chip that has been reset
and whose IRQ handler has already been freed? On a shared INTx line, an
interrupt that nobody handles could get the line disabled for the other
devices on it. The timer also re-arms itself every 1.2 seconds.

gem_suspend() only calls netif_device_detach() when !netif_running(dev),
so would this timer keep touching MMIO and MDIO across system suspend? The
commit message says "Keep ordinary close and suspend timer cancellation
restartable", but the suspend path for a down interface never cancels the
timer.

The sibling callbacks already follow this convention, for example
gem_set_mac_address():

	/* We'll just catch it later when the device is up'd or resumed */
	if (!netif_running(dev) || !netif_device_present(dev))
		return 0;

	/* Better safe than sorry... */
	if (WARN_ON(!gp->cell_enabled))
		return 0;

If the two link callbacks only stored the settings while the interface is
down, as the !present path already does, link_timer could never be armed
on a closed device. That would cover the removal case, the DMA re-enable
after close, the suspend case and the linkwatch window below. The
timer_shutdown_sync() added here would then not be needed.

[Severity: High]
Is it safe to shut the timer down only after unregister_netdev() has
returned?

A link_timer armed while the interface was down may still be running when
unregister_netdev() returns, for example inside poll_link(). It may also
fire before timer_shutdown_sync() runs. If the callback sees a link
transition, it calls netif_carrier_on() or netif_carrier_off(). Those
helpers bail out only for NETREG_UNINITIALIZED:

net/sched/sch_generic.c:netif_carrier_on() {
    ...
	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state)) {
		if (dev->reg_state == NETREG_UNINITIALIZED)
			return;
		atomic_inc(&dev->carrier_up_count);
		linkwatch_fire_event(dev);
	}
}

linkwatch_add_event() then puts dev on lweventlist and takes
netdev_hold().

However, unregister_netdev()->netdev_run_todo() has already called
linkwatch_sync_dev() and waited for the device references to drop. After
that, nothing drains this device's entry. timer_shutdown_sync() waits for
the callback but does not remove the queued event, and free_netdev() then
frees dev and gp along with it.

Can linkwatch_event()->__linkwatch_run_queue() later dereference the freed
net_device through the leftover entry on lweventlist?

The window is narrow. Would calling timer_shutdown_sync() before
unregister_netdev() close it? That order looks safe: once the timer is shut
down, timer_delete_sync() in gem_do_stop() and mod_timer() in
gem_reset_task() and gem_begin_auto_negotiation() do nothing. Checking
netif_running() in the ethtool callbacks, as suggested above, would also
close this window.

>  		/* Ensure reset task is truly gone */
>  		cancel_work_sync(&gp->reset_task);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179229264512.3933686.6151403340581004321.sungem%40gmail.com
