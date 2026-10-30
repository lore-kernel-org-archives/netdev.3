Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400031;
	b=U/okz5KUD/X9uWi7ezjNonN5g2UJBA29EV/Do9jjl5t4XvR8cQAdWgEvmWanCFUl1XBU
	 oObZjeZoanex4TCZhFZGh+Oj5ImnQwug0KcqGRQQeP0lxUyHFBY5Vutgof8q9zU9nXz12
	 oaXBqEk+ygws2tDpc2+ELu3p/CQQST8c/TcPyrsaKUeauVKA3BSix8KYyIdx7x3AUXQju
	 YEy0wYRx1b6sW0wE2iGiHMbHIsip62H+lK3aisQZKgz28xEwj6qt4BLtdAV7RP+hHsdww
	 SjFCb4AFZerq+iWfKF4/iuDMJdKgogLL7q1wMw2Io66VTWr3B2LhiUnpHMGJlUu4Snw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400031;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+PnYMh6DNzPpqVbgvmgcrkPxRCl7vamjubwgznqMc0I=;
	b=NEnYXt/aIevUvSl0J2dvgN8FxUVASb09AzSdOcuBDdf8ftBlW0vEbotN69DAfQPkpfb4
	 wSg6OwdwrfE9E0EuJ3tSptcQ8iwrdX9hUDKYMXqOXBLjErg+K/BpvG6AusJFtl2wKPvXf
	 nlaIuCBiqL9/zdgRcSRsRZ320f2JkX/dDoKZt/ROnYc9609ZWoioqQyHf0vNs1QHpXD9e
	 K4naDSkYXiZW6/S+5UyTLCKLIOoY6SOwAk7pXk+Cq1oQJKHitY3aFjWOzxRVRZ8kTjdtM
	 gKQS7JOicv6aeq2yL8roAMio5P1Hj1Ev2lNFxd+wNMLlfigmYgmcrSNSgG3Ul4OCeCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7jI9KwO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107A606A32E;
	Fri, 30 Oct 2026 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7jI9KwO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FA31F00A16;
	Fri, 30 Oct 2026 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400030;
	bh=+PnYMh6DNzPpqVbgvmgcrkPxRCl7vamjubwgznqMc0I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C7jI9KwOzTSNbzqNWDGF6ldNnWvKy0zZjLWego4dtGWM2zamD2KnJgDJR7sLSE2fF
	 DGVmdHtMD1vHfEtKOtW9WRv+wJI7IP0bx4dyf1C0iEivGuBOeXeiYBmVf8RA4wPy/N
	 Lc1ZL0M7AvovGOTSahTEwK7cUp+kReCl3xPOaq0N1IjVdTUKW+BhZ5IGB5s0P4mDEi
	 5zX0o6lEDn/7nSrox+bDgH0KAfp1qV/WOTWJr0bbtQXfinAdoLRSATPX4+tdO+DjUM
	 E9M5lI9VjaEtbVe+2ovLekUZf8lUtIZRBjojk70WCbtBXkxDmhwUgQy6VVN6kgkGPh
	 OOJhxYaT7smTQ==
Subject: Re: [PATCH net v3 2/2] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com,
 wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 22:40:29 +0000
Message-ID: <179340002921.3131.2310990267446945871@kernel.org>
In-Reply-To: <20261029-b4-phylib-mac-pm-irq-v3-v3-2-5907045f3210@iav.lv>
References: <20261029-b4-phylib-mac-pm-irq-v3-v3-2-5907045f3210@iav.lv>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phy_interrupt() now decides whether a postponed interrupt on a
  MAC-managed-PM PHY is a wakeup by checking only…
- [Medium] The patch adds a second, unsynchronized consumer of irq_rerun
  and writer of irq_suspended in phy_free_interrupt() (phy.c:1518-1523).

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch.

--

net: phy: postpone PHY interrupts during sleep with MAC-managed PM

This commit makes mdio_bus_phy_suspend() set irq_suspended for PHYs whose
PM is managed by the MAC. It also makes mdio_bus_phy_resume() replay
postponed interrupts for those PHYs. For these PHYs, phy_interrupt() no
longer reports non-WoL wakeup events, and phy_free_interrupt() now clears
irq_suspended and re-enables a line left disabled by a postponed interrupt
before freeing it.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9af303d60bd6b..c3863a72a5dab 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1421,12 +1421,16 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
>  
>  		if (netdev) {
>  			struct device *parent = netdev->dev.parent;
> +			/* Without WoL, a MAC that manages PHY PM takes the
> +			 * link down itself: that interrupt is not a wakeup.
> +			 */
> +			bool may_wake = !phydev->mac_managed_pm;
>  
>  			if (netdev->ethtool->wol_enabled)
>  				pm_system_wakeup();
> -			else if (device_may_wakeup(&netdev->dev))
> +			else if (may_wake && device_may_wakeup(&netdev->dev))
>  				pm_wakeup_dev_event(&netdev->dev, 0, true);
> -			else if (parent && device_may_wakeup(parent))
> +			else if (may_wake && parent && device_may_wakeup(parent))
>  				pm_wakeup_dev_event(parent, 0, true);
>  		}

[Severity: Medium]
For mac_managed_pm PHYs, does this leave netdev->ethtool->wol_enabled as
the only thing that can turn a postponed interrupt into a wakeup?

Elsewhere, phylib also counts the PHY's own wakeup state as WoL.
phy_suspend() does:

	phydev->wol_enabled = phy_may_wakeup(phydev) ||
			      (netdev && netdev->ethtool->wol_enabled);

and phy_may_wakeup() checks the PHY device itself:

	if (phy_can_wakeup(phydev))
		return device_may_wakeup(&phydev->mdio.dev);

	return phy_drv_wol_enabled(phydev);

The @wol_enabled kernel-doc in include/linux/phy.h also says "the PHY or
the attached MAC". mdio_bus_phy_may_suspend() notes that not all network
drivers set the netdev wol_enabled flag.

Before this patch, interrupts on these PHYs went straight to the PHY
driver's handler. Some of those handlers report their own wake event. For
example, rtl8211f_handle_interrupt() calls pm_wakeup_event() on PME, and
the broadcom and air_an8801 drivers do something similar.

Suppose phy_may_wakeup() is true but netdev->ethtool->wol_enabled is
false, and a WoL interrupt arrives between mdio_bus_phy_suspend() and the
noirq phase. The interrupt is postponed, the line is disabled, and no
wakeup is reported. Could that wake event be lost?

The ethtool set_wol paths always set the netdev flag, so this would need
WoL configured some other way, for example by firmware or by a driver at
probe time. Would also checking phy_may_wakeup(phydev) here match the rest
of phylib?

The new comment "Without WoL, a MAC that manages PHY PM takes the link
down itself" also only covers the netdev flag.

[ ... ]

> @@ -1507,6 +1511,17 @@ EXPORT_SYMBOL(phy_request_interrupt);
>  void phy_free_interrupt(struct phy_device *phydev)
>  {
>  	phy_disable_interrupts(phydev);
> +
> +	/* The PHY is reachable: stop postponing, and while our handler is still
> +	 * registered re-enable a line that a postponed interrupt left disabled.
> +	 */
> +	phydev->irq_suspended = false;
> +	synchronize_irq(phydev->irq);
> +	if (phydev->irq_rerun) {
> +		phydev->irq_rerun = false;
> +		enable_irq(phydev->irq);
> +	}
> +
>  	free_irq(phydev->irq, phydev);
>  }

[Severity: Medium]
Can this race with mdio_bus_phy_suspend() or mdio_bus_phy_resume_irq()?

irq_suspended and irq_rerun are plain bools with no shared lock.
synchronize_irq() only orders each writer against the IRQ thread.

phy_free_interrupt() can be reached through phy_disconnect() from
kernel-internal close/reopen paths. The PM core does not serialize those
paths with the PHY's PM callbacks.

One example is stmmac_reset_subtask(), which runs dev_close() and
dev_open() under RTNL from priv->wq. That workqueue comes from
create_singlethread_workqueue(), so it is not freezable. The PHY PM
callbacks don't take RTNL.

On resume, both sides could see irq_rerun set:

CPU1 mdio_bus_phy_resume_irq()      CPU2 phy_free_interrupt()
if (phydev->irq_rerun) {            if (phydev->irq_rerun) {
    phydev->irq_rerun = false;          phydev->irq_rerun = false;
    enable_irq(phydev->irq);            enable_irq(phydev->irq);
    irq_wake_thread(...);               ...
                                        free_irq(phydev->irq, phydev);

Would the second enable_irq() trigger an "Unbalanced enable for IRQ"
warning? Could irq_wake_thread() also run for a line that is being freed?

On suspend, the order could be:

CPU2 phy_free_interrupt()
    phydev->irq_suspended = false;
    synchronize_irq(phydev->irq);
    /* irq_rerun is false here */
                                    CPU1 mdio_bus_phy_suspend()
                                        phydev->irq_suspended = true;
    /* shared-line interrupt */
    phy_interrupt() (IRQ thread)
        phydev->irq_rerun = true;
        disable_irq_nosync(irq);
    free_irq(phydev->irq, phydev);

Would that leave an IRQF_SHARED line disabled for its other users? The
stale irq_rerun would also make a later mdio_bus_phy_resume_irq() call
enable_irq() on a newly requested line.

Before this patch, nothing on the PM side wrote these fields for
mac_managed_pm PHYs, so this interleaving could not happen for them.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 79dba43d703a2..7d14861850704 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -336,18 +336,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)

[ ... ]

>  	if (phy_interrupt_is_valid(phydev)) {
>  		phydev->irq_suspended = true;
>  		synchronize_irq(phydev->irq);
>  	}
>  
> +	if (phydev->mac_managed_pm)
> +		return 0;
> +

[ ... ]

> @@ -364,13 +366,33 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  	return phy_suspend(phydev);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens to
irq_suspended when phy_suspend() fails here?

For PHYs without mac_managed_pm, mdio_bus_phy_suspend() sets
irq_suspended and stops the state machine. It then returns
phy_suspend(phydev) without undoing either one on error.

phy_suspend() can return -EBUSY:

	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;

mdio_bus_phy_may_suspend() doesn't check phy_may_wakeup() when a netdev
is attached, so that case reaches this call. MDIO errors from
drv->suspend() are passed back as well.

When the callback fails, device_suspend() in drivers/base/power/main.c
never sets dev->power.is_suspended. device_resume() then skips the
device:

	if (!dev->power.is_suspended)
		goto Complete;

So mdio_bus_phy_resume() never runs for this PHY. Does irq_suspended stay
true after that? If so, the first PHY interrupt afterwards would disable
the line for good, and the state machine would stay stopped.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-b4-phylib-mac-pm-irq-v3-v3-0-5907045f3210%40iav.lv
