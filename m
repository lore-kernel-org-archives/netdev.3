Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120158;
	b=fuDnuCiNfvo9cO9SjdaDruFxXIgeUKahe/fxglk41Edq3jJNr2lzMYcKETgrw5R4h8w+
	 50LBFyZZckDzefdIlPHY4zxJ4gP1LSjaMC1mrWING5QegFLTqS9Vsik/iXGBeU0BXEOLK
	 jLCwhbKuMegbzx54jp4CCcfOxhXotb0lMBdLGUpVTqAi+oxwbUjnFCZzuXFKPXu31/R+3
	 SR6y24UOWh9LunwwFN0ovOgVxxiX6hO5NHxGbCDxEhRR4Gfq8l+D/PpC/BmsU2KElmOkT
	 EdsiiR3PmD69yD9zMDXXj7FqqJsx2lmUCcNEIfWCwBhF+sheij3yAhwRnLS12Ja8wHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120158;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KZT7bgvWnTvAxMtis05hFO4y3IU5EfwoyWPG0CeLY0M=;
	b=Dg8FButsjRTG6d85JkIlx+5EElx2JqCMei3D9vUKYeHX3NbZECpHv3o7CLhUPOaMrQRe
	 cEasHI873vFT9qYllc1wbNNLs7xQUZW8c9YOOvcz82ZvxqGzJHoxwjcIWoxnif3q6HboV
	 7AqlmylZKS6PohwMTK/I19w2ON9DBtofqM0AFJyfPn2wTu+cJ8tA2J5gs4surbpFEHv5v
	 VTP6/PugeFBskpXbbWEXGg280rjC2MWw3siqdYjQcStkdbU3bzEMSI5/A0ekJ/HRzhEba
	 KfC9dMCuOnilEidwwu9zP0MCU7QgP5c84wSjgdbdAMvUQGCE6CgGh9UbH+vT8W9CaBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WB0JGUXv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E71606A31A;
	Tue, 27 Oct 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WB0JGUXv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97E31F01825;
	Tue, 27 Oct 2026 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120157;
	bh=KZT7bgvWnTvAxMtis05hFO4y3IU5EfwoyWPG0CeLY0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WB0JGUXvnp1bVInpJqIHceUCHgEGusR8mt2sReRrejPI5x7wbwQhCrWWq0BM39EPd
	 3wz1hz/lSGE0dY9XdOWkADQSVutoTUwTnqar1DLVQjZ5i8Yf+qW20nbrIQwKk2VfUQ
	 nXLorH1YcTB4KW7RPZIHVmRmVzW+VJUuXOVGn8DIb3d2+gR3DYZtiRQfsAgogNetE4
	 PB3HygZc7cqDLHTt4RrLw4hwrVJ9R0YZgn0zQHNKX99ZKG2lFPs9GpbxQeIWDLycDN
	 XOKkkKA5FkOne1ocE/+RDKQC6u3nE003aMwz1S1KpLPa/ZNdjXERKrqq7wxVKClse9
	 lDI6YPhQwGa9g==
Subject: Re: [PATCH net v2 2/2] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 lukas@wunner.de, rafael.j.wysocki@intel.com, wei.fang@nxp.com,
 niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 16:55:56 +0000
Message-ID: <179312015623.3134.7149153472845451722@kernel.org>
In-Reply-To: <20261026045343.837889-3-iav@iav.lv>
References: <20261026045343.837889-3-iav@iav.lv>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] For PHYs whose PM is managed by the MAC driver
  (mac_managed_pm), mdio_bus_phy_suspend() now sets irq_suspended before…
- [Medium] When a PHY's interrupt is a nested threaded IRQ (PHY INT
  routed through an I2C/SPI GPIO expander or MFD irqchip that uses…
- [Low] The new depth fixup in phy_free_interrupt() is an unsynchronized
  check-then-act.

Pre-existing issues:
- [Medium] For a non-MAC-managed PHY, mdio_bus_phy_suspend() sets
  irq_suspended and stops the state machine, then returns the result of…
- [Low] Topology: a PHY on another MAC's MDIO bus, linked to its consumer
  MAC via device_link_add() in phy_attach_direct().

--

net: phy: postpone PHY interrupts during sleep with MAC-managed PM

This patch makes mdio_bus_phy_suspend() set irq_suspended for PHYs whose PM
is managed by the MAC driver. It replays the postponed interrupt from
mdio_bus_phy_resume() through a new mdio_bus_phy_resume_irq() helper. It
also makes phy_free_interrupt() re-enable a line left disabled by a
postponed interrupt if other handlers still share it.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index fce9bc7be3304..00aa48e807a5e 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1508,6 +1508,15 @@ void phy_free_interrupt(struct phy_device *phydev)
>  {
>  	phy_disable_interrupts(phydev);
>  	free_irq(phydev->irq, phydev);
> +
> +	/* Undo the disable_irq_nosync() of a postponed interrupt if the line
> +	 * is still shared; otherwise the next irq_startup() resets the depth.
> +	 */
> +	if (phydev->irq_rerun) {
> +		phydev->irq_rerun = 0;
> +		if (irq_has_action(phydev->irq))
> +			enable_irq(phydev->irq);
> +	}

[Severity: Low]
Is this check-then-act safe if another driver calls request_irq() on the
same shared line at the same time?

By the time irq_has_action() runs, free_irq() has already dropped
desc->request_mutex and desc->lock. irq_has_action() only takes
rcu_read_lock().

If the PHY's action was the last one on the line, this interleaving
looks possible:

CPU1                                 CPU2
phy_free_interrupt()
  free_irq()
    __free_irq()
      irq_shutdown()  /* depth++ */
                                     request_threaded_irq(IRQF_SHARED)
                                       irq_startup()
                                         desc->depth = 0;
  irq_has_action()    /* true */
  enable_irq()
    __enable_irq()    /* depth == 0 */
      WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n", ...)

__enable_irq() does not change the depth when it is 0, so this seems
limited to a warning. The window is also narrow: irq_rerun must still be
set when the interface is closed during suspend, before
mdio_bus_phy_resume() runs.

The opposite order is harmless, because the depth++ in irq_shutdown()
absorbs the enable.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5d4508bcfbe99..e2807e08e4365 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -336,18 +336,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  {
>  	struct phy_device *phydev = to_phy_device(dev);
>  
> -	if (phydev->mac_managed_pm)
> -		return 0;
> -
>  	/* Wakeup interrupts may occur during the system sleep transition when
>  	 * the PHY is inaccessible. Set flag to postpone handling until the PHY
>  	 * has resumed. Wait for concurrent interrupt handler to complete.
> +	 * This holds when the MAC manages PHY PM too: an interrupt can still
> +	 * fire while the MAC has the PHY or the MDIO bus powered down.
>  	 */

[Severity: Low]
This isn't a regression introduced by this patch, but does this comment
claim more than the change covers?

When a PHY sits on another MAC's MDIO bus, phy_attach_direct() links it
to its consumer MAC:

	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);

In that topology the consumer MAC suspends before the PHY and resumes
after it. The handler can then still run, or be replayed from
mdio_bus_phy_resume_irq(), while the consumer MAC has cut the PHY's
regulator or reference clock (FEC, for example).

The MDIO bus owner is still an ancestor of the PHY, so the bus stall case
is covered.

Reads of an unpowered PHY over a live bus were also possible before this
patch. The pending interrupt was replayed from resume_device_irqs() in
dpm_resume_noirq(), which is even earlier than now.

Could the comment be narrowed to the MDIO bus case?

>  	if (phy_interrupt_is_valid(phydev)) {
>  		phydev->irq_suspended = 1;
>  		synchronize_irq(phydev->irq);
>  	}
>  
> +	if (phydev->mac_managed_pm)
> +		return 0;
> +

[Severity: Medium]
Can this abort system suspend for MAC-managed PHYs when wakeup is enabled
on the MAC device but no ethtool WoL is configured?

The PHY device suspends before its MDIO bus and the MAC, so irq_suspended
is now set before the MAC's suspend callback runs. With stmmac and
priv->wolopts == 0, the MAC then powers the PHY down itself:

stmmac_suspend()
  phylink_suspend(priv->phylink, false)
    phylink_stop()
      phy_stop()
        phy_suspend()

phy_suspend() keeps the PHY powered only when phy_may_wakeup() is true or
netdev->ethtool->wol_enabled is set. Here the PHY powers down and raises
the link down interrupt that the commit message describes.

That interrupt now goes through the postpone branch of phy_interrupt():

	else if (device_may_wakeup(&netdev->dev))
		pm_wakeup_dev_event(&netdev->dev, 0, true);
	else if (parent && device_may_wakeup(parent))
		pm_wakeup_dev_event(parent, 0, true);

When pmt is set, stmmac_dvr_probe() calls
device_set_wakeup_capable(priv->device, 1). If power/wakeup is then
enabled on that device through sysfs, this hard wakeup event makes
pm_wakeup_pending() abort the suspend with -EBUSY. That would happen on
every attempt made while the link is up.

Core-managed PHYs avoid this, because mdio_bus_phy_may_suspend() keeps
the PHY powered in that case:

	if (netdev->dev.parent && device_may_wakeup(netdev->dev.parent))
		return false;

MAC-managed PHYs never go through that check. Before this patch, the
interrupt was handled in place and suspend went ahead.

>  	/* We must stop the state machine manually, otherwise it stops out of
>  	 * control, possibly with the phydev->lock held. Upon resume, netdev
>  	 * may call phy routines that try to grab the same lock, and that may

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. For
PHYs that are not MAC-managed, mdio_bus_phy_suspend() sets irq_suspended
and stops the state machine. It then returns the result of phy_suspend()
without undoing either step if that call fails:

	phydev->suspended_by_mdio_bus = 1;

	return phy_suspend(phydev);

The PM core skips resume for a device whose suspend failed. Does that
leave irq_suspended set? If so, phy_interrupt() would postpone every
later interrupt and leave the line disabled.

For mac_managed_pm PHYs, the ones newly affected here, this function
always returns 0 after setting the flag. So this patch adds no new
failure path.

[ ... ]

> @@ -364,13 +366,33 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  	return phy_suspend(phydev);
>  }
>  
> +static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
> +{
> +	if (!phy_interrupt_is_valid(phydev))
> +		return;
> +
> +	phydev->irq_suspended = 0;
> +	synchronize_irq(phydev->irq);
> +
> +	/* Rerun interrupts which were postponed by phy_interrupt()
> +	 * because they occurred during the system sleep transition.
> +	 */
> +	if (phydev->irq_rerun) {
> +		phydev->irq_rerun = 0;
> +		enable_irq(phydev->irq);
> +		irq_wake_thread(phydev->irq, phydev);
> +	}
> +}

[Severity: Medium]
Does this replay work when the PHY interrupt is a nested threaded IRQ?
An example is PHY INT routed through an I2C or SPI GPIO expander that
uses handle_nested_irq().

__setup_irq() does not create a thread for nested IRQs:

	if (new->thread_fn && !nested) {
		ret = setup_irq_thread(new, irq, false);

So action->thread is NULL, and irq_wake_thread() does nothing.

The postpone branch in phy_interrupt() also returned without calling
handle_interrupt(). The PHY's interrupt status was therefore never read
or acked:

	phydev->irq_rerun = 1;
	disable_irq_nosync(irq);
	return IRQ_HANDLED;

enable_irq() only resends if IRQS_PENDING was set. Take a parent that
accepts only edge triggers and filters masked sources, in the style of
pca953x. The PHY INT would stay asserted with no new edge, and link
interrupts could stay dead after resume.

The replay code itself predates this patch. However, mac_managed_pm PHYs
with a valid IRQ now go through it. The link goes down while the MAC
suspends, as the commit message describes, so a postponed interrupt is
likely on every suspend cycle.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026045343.837889-1-iav%40iav.lv
