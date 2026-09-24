Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA52F691D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273513; cv=none; b=kCEwF4kDKjZx9w8fzaBtwmp53rW+RLU1YBocaw5saS0ZPjA/V8+cQYMRYNa/N3sdY6uJSmZ1sfeEpNYiPXqTco+4GGvb/ksZYc8fa19XwGF5WEi1XGKlVT1mjCBc6uCQYI6rJ7P83delx3AXS9FNwli7lvrbKz1wgim/vN6iVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273513; c=relaxed/simple;
	bh=dXwarmAPPiKn84nMBSyH0y3K05SL9gOtvYRnr4TpcfA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBO/aOC9jtO8d1QxbyvuPtpGO/WD9XFwGnRY2GGdRmAjzrmeGPqJ05ylGj4vikWt60qHnyyQtEprSH3+qPSCU/1Ik3pqYN0UHe5BvBmQhOhKY8umsq9tEdTgtKZd7nsuYrowz1SCot2Hn47xfC5OvHbQTGM4MHmWU/jK0JC6IoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA6hBx7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA6hBx7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958891F000FF;
	Thu, 24 Sep 2026 18:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273512;
	bh=pyi+rs+fTEYFsA9Uqrhy34GjXSTuEjfLKAEw581RXI0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PA6hBx7xNUYECW/mvXoL4w490ZYVizCtyg/eD9plvMw/C9NX/twk9RT/l4ATYI4Iq
	 0hubkxViPm/dnhxAGf5ByBIbFzpc1UUibw2orPFKAMzpYDsjACLLTVT8htDZ4umYRF
	 lwnD1fOMGnCaYuqeMb9V8XGGKFfExKK9QOHVaX0ITkABqgbvEXJoV7zHodk0YkID+S
	 8M0B76wF4FNYyAmVwJyqC6LlkOvXJGOq2u4WljcKQlmdg4xvgrjn+O3MN/lFGkq9ar
	 rYDha+xYF0PhVMBemC+wQ8W36RXittpQVbmgYWBtj6u4zmqerOUfBZ97XY/4aboMf4
	 s5Iz7Yko8i69A==
Subject: Re: [PATCH v6 1/2] net: macb: Poll for link state changes when using
 the internal PCS.
From: netdev-bot+sashiko@kernel.org
To: nwhitehorn@pa.msu.edu
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch,
 kuba@kernel.org, pabeni@redhat.com
Date: Thu, 24 Sep 2026 18:11:51 +0000
Message-ID: <179027351112.2160803.2219415998781776075@kernel.org>
In-Reply-To: <20260922151429.23272-2-nwhitehorn@pa.msu.edu>
References: <20260922151429.23272-2-nwhitehorn@pa.msu.edu>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: only the SGMII PCS gets link-state polling;
  the sibling internal 10GBASE-R PCS (`bp->phylink_usx_pcs`) is left…
- [Low] The commit carries no `Fixes:` tag although, for the in-band
  SGMII/PCS configuration without an attached PHY, it repairs a pre-…

Pre-existing issues:
- [Medium] Enabling `poll` on the SGMII PCS creates a self-retriggering
  periodic phylink resolve path that is not quiesced by macb's Wake-on-…

--

net: macb: Poll for link state changes when using the internal PCS.

This sets phylink_pcs.poll on the macb SGMII PCS so phylink arms its
periodic resolve timer and re-reads the PCS link state. That covers the
case where the link is terminated at an offboard transceiver such as an
SFP rather than an onboard PHY.

No Link: tags are present in the commit header.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d1d1c273f4bbf..d48ad5b587d09 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *netdev)
>  	struct macb *bp = netdev_priv(netdev);
>  
>  	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
> +	bp->phylink_sgmii_pcs.poll = true;

[Severity: Medium]
Should bp->phylink_usx_pcs get the same treatment?  It is initialised on
the very next line and keeps the zero-initialised poll == false.

macb_mac_select_pcs() hands out the USX instance for 10GBASE-R:

	if (interface == PHY_INTERFACE_MODE_10GBASER)
		return &bp->phylink_usx_pcs;

and macb_usx_pcs_get_state() reads a level status bit in exactly the same
way that macb_pcs_get_state() reads PCSSTS:

	val = gem_readl(bp, USX_STATUS);
	state->link = !!(val & GEM_BIT(USX_BLOCK_LOCK));

phylink_pcs_poll_start() arms the timer only for the currently selected
PCS:

	if (pl->pcs && pl->pcs->poll && pl->cfg_link_an_mode == MLO_AN_INBAND)
		mod_timer(&pl->link_poll, jiffies + HZ);

For an SFP, phylink_sfp_set_config() forces MLO_AN_INBAND, and macb has no
other link notification for this path: phylink_pcs_change() is never
called, and MACB_ISR_LINK_* exists only as a register bit definition in
macb.h, never written to IER nor handled in macb_interrupt().  The
phylink_config.poll_fixed_state / get_fixed_state pair set below is only
consulted by phylink_start() for MLO_AN_FIXED:

	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
		poll |= pl->config->poll_fixed_state;

So with a 10GBASE-R module, does USX_BLOCK_LOCK coming up late leave the
carrier down permanently, and does a later loss of block lock leave a
stale carrier up until some unrelated phylink event (module removal, ip
link down/up) forces a re-resolve?

The follow-up patch in the series, "net: macb: add support for
1000BASE-X autonegotiation to PCS", extends only the SGMII PCS, so this
stays the same at the end of the series.

[Severity: Low]
Would a Fixes: tag be appropriate here?  For the in-band SGMII/PCS
configuration with no attached PHY, nothing re-sampled the PCS before
this change: phylink honours poll_fixed_state/get_fixed_state only in
MLO_AN_FIXED, macb installs no PCS link-change notification, and
pl->link_poll was never armed for the PCS path, so macb_pcs_get_state()
ran only at major-config time.

The message carries only Signed-off-by and Reviewed-by, and commit
8876769bf936 ("net: macb: convert to phylink PCS") is not referenced, so
backporters have nothing to key off if this is meant for stable.

If the intent is purely to enable a configuration that was not supported
before (direct PCS-to-SFP attachment, as described in the follow-up
patch), then net-next without a Fixes: tag is fine — could the intent be
made explicit?

[Severity: Medium]
This isn't a bug introduced by this patch, but arming the periodic poll
adds one more trigger to a path that macb_suspend() does not quiesce when
Wake-on-LAN is armed:

drivers/net/ethernet/cadence/macb_main.c:macb_suspend() {
	...
	if (!(bp->wol & MACB_WOL_ENABLED)) {
		rtnl_lock();
		phylink_stop(bp->phylink);
		rtnl_unlock();
	...
}

phylink_stop() is the only caller of timer_delete_sync(&pl->link_poll) and
the resolve flush.  With WoL enabled it is skipped, while
phylink_fixed_poll() keeps re-arming itself and queues the resolve on
system_power_efficient_wq, which is not WQ_FREEZABLE:

	mod_timer(t, jiffies + HZ);
	phylink_run_resolve(pl);
	...
	if (!pl->phylink_disable_state)
		queue_work(system_power_efficient_wq, &pl->resolve);

phylink_resolve() has no netif_device_present() or suspend guard, so a
polled state change calls macb_mac_link_down() (clears NCR RE|TE, masks
queue interrupts) or macb_mac_link_up() (re-enables RE|TE, rewrites
NCFGR, writes per-queue IER, wakes TX queues) on a detached netdev whose
MAC was just armed for WoL.  Can that drop a magic/ARP wake frame while
RE is clear, or re-enable non-WoL queue interrupts on a wake-armed IRQ
line and cause a spurious wake?

The same hazard already exists without this change: macb sets
phylink_config.mac_managed_pm = true, so mdio_bus_phy_suspend() returns
early and the PHY state machine keeps driving resolves during WoL
suspend, and sfp_poll() does the same for SFP setups.  So the underlying
gap looks like macb_suspend()'s WoL path not stopping link management
rather than this one-line flag.

>  	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
>  
>  	bp->phylink_config.dev = &netdev->dev;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922151429.23272-1-nwhitehorn%40pa.msu.edu
