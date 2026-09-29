Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2D31E831;
	Tue, 29 Sep 2026 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641924; cv=none; b=rsV6nYtzZLZEkEBL3OOGLRZT8yuHHkXwDVaxkdqNTOOCt5K3b08Bt9iez7pgo0Z+2+RBIoBL5nXBXCdUgfyczt90QOrRG3a0GycBBf9oNLuxvF6r1NgOEQWnyVFVUpfUsED4/xrUXoVpd1ZpKgforrVVUTD6XAlXkEvxHhtX0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641924; c=relaxed/simple;
	bh=UXA5wu3CPeF7BOYx+25TH+fwtBXd4GyFGZsJDj0EmOc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddao9zLuJkRxQRuv2hjn/ePJJVul2eoAJTKhOJGeSSj+XUK0BRVbF0KNjcxELWmXAurQKcsFGjMMX+64NreSUptuy+LiVZvDkexlvznyuS4AWNRh7H4JpbbO1+Cp5CJryKp3dTiyDZae6gTwyUny6fX9SFpr70lvWAY4mBUULi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAxO1vpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAxO1vpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E31F00893;
	Tue, 29 Sep 2026 00:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641923;
	bh=YZi1ypieVFvTNbRUJLyNDXRClXWjs3iDMCHGJQWrE/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BAxO1vpp0GmfaW7ho7ka6JvRhmzh1DzOpd4Wrlmv/2gsZVyZUUhkzHBznPhlfxTQZ
	 llj6q9TD4B65BZBT7jHA+Yo9FNAMVLNSGRvDCNoldX4MZwaYXq06txMR1UBsjURSdT
	 8GR2sWgF9HJaGzK7fD8h67DA/P+qNxlRNPwEW3qvebwC5AX+qdZGgL6tg86pmqZaeY
	 fkBIoILmwrJg/KPRXHjqLIJBkCYpfirIVI5AZDAero0PvSjizhib6+FF8NP0qyj5QP
	 b5IrrHsTmTs9WJmu6xwxjjWdIte72oKDNPf2ao1MIN6xbgc5obqlsq/pdIJE1tSQXM
	 3Hx/b74YEfjuQ==
Subject: Re: [PATCH net-next v4 2/2] net: phylink: wait for PHYs that are
 known to probe late
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, conor@kernel.org,
 f.fainelli@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 00:32:01 +0000
Message-ID: <179064192169.3145.15914679496475412857@kernel.org>
In-Reply-To: <20260925001209.2334139-3-f@lex.la>
References: <20260925001209.2334139-3-f@lex.la>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Returning success before the PHY is attached causes a NULL
  pointer dereference in ucc_geth_open() on CONFIG_PPC_85xx.
- [Medium] The patch changes what a 0 return from
  phylink_fwnode_phy_connect()/phylink_of_phy_connect() means: it can…
- [Medium] The poller attaches the PHY based on a lockless readiness
  check, phylink_phy_is_usable() (`device_is_bound()` &&…
- [Low] Before this patch, a successful phylink_fwnode_phy_connect() in
  MLO_AN_PHY mode always replaced a PHY_INTERFACE_MODE_NA link_interface…
- [Low] The new kernel-doc of phylink_fwnode_phy_connect() says that for
  a needs-host-firmware PHY that is not usable yet, 'a poller connects…

--

net: phylink: wait for PHYs that are known to probe late

This commit changes phylink_fwnode_phy_connect() for PHYs whose DT node
has needs-host-firmware and whose driver has not bound yet. It now
returns 0 and arms a delayed work poller, which attaches the PHY once
the driver binds. Until then, the ethtool paths report no link modes and
refuse configuration changes.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a7d086cdc9b25..4a5b98b558891 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> +/* Stale the moment it returns: the device lock this wants cannot be held
> + * across the attach, whose own failure path takes it again.
> + */
> +static bool phylink_phy_is_usable(struct phy_device *phy_dev)
> +{
> +	return phy_dev && device_is_bound(&phy_dev->mdio.dev) && phy_dev->drv;
> +}

[ ... ]

> +	ret = phylink_attach_phy(pl, phy_dev, pl->link_interface,
> +				 pl->late_phy_flags);
> +	if (!ret && phy_driver_is_genphy(phy_dev)) {
> +		/* Lost the race: the attach bound the generic driver, which
> +		 * is the outcome this poller exists to avoid.
> +		 */
> +		phy_detach(phy_dev);
> +		lost_race = true;
> +		ret = -EAGAIN;
> +	}
> +	if (!ret) {
> +		ret = phylink_bringup_phy(pl, phy_dev,
> +					  pl->link_config.interface);

[Severity: Medium]
What happens if an unbind of the PHY driver overlaps this attach? Sysfs
unbind, rmmod and MDIO bus teardown take only the device lock, not rtnl.
__device_release_driver() runs its steps in this order:

__device_release_driver()
    device_remove(dev)
        phy_remove()
            phydev->drv = NULL;
    ...
    device_unbind_cleanup(dev)          <- clears dev->driver
    klist_remove(&dev->p->knode_driver);

In that window phy_attach_direct() still sees d->driver non-NULL. It
does not select genphy and leaves is_genphy_driven at 0. Then it calls:

	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))

That dereferences the NULL drv.

If the attach does get through, phy_driver_is_genphy() is false here, so
the lost_race recovery does not run. phylink_bringup_phy() then does:

	phylink_info(pl,
		     "PHY [%s] driver [%s] (irq=%s)\n",
		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);

Under rmmod, try_module_get(d->driver->owner) fails with -EIO instead.
That uses up one of the bounded retries as if the connect had really
failed.

The commit message says the attach-versus-unbind window is phylib's to
close. But the poller decides when to attach, based on a check it
documents as stale. Could this oops the work item while it holds rtnl?

[ ... ]

> @@ -2418,7 +2578,13 @@ EXPORT_SYMBOL_GPL(phylink_of_phy_connect);
>   * Connect the phy specified @fwnode to the phylink instance specified
>   * by @pl.
>   *
> - * Returns 0 on success or a negative errno.
> + * If the PHY node carries the needs-host-firmware property and the
> + * PHY is not usable yet, 0 is returned with no PHY connected: a poller
> + * connects it once its driver has probed. Until then the MAC runs
> + * without a PHY and ethtool reports no link modes.

[Severity: Low]
Is this description complete? phylink_late_phy_poll() can stop for good
after PHYLINK_LATE_PHY_RETRIES + 1 failed connects with the real driver
bound:

		} else {
			/* Silence from here reads as success otherwise. */
			phylink_err(pl, "giving up on %pfw after %u attempts\n",
				    pl->late_phy_fwnode,
				    PHYLINK_LATE_PHY_RETRIES + 1);
		}

That branch leaves pl->late_phy_fwnode set, so
phylink_late_phy_pending() stays true. The ethtool paths then keep
reporting no link modes and returning -EOPNOTSUPP until the MAC calls
disconnect and connect again. Rebinding the PHY driver does not restart
the poller.

Could the kernel-doc mention this terminal state?

[ ... ]

> @@ -2440,6 +2608,23 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
>  	}
>  
>  	phy_dev = fwnode_phy_find_device(phy_fwnode);
> +	if (fwnode_property_present(phy_fwnode, "needs-host-firmware") &&
> +	    !phylink_phy_is_usable(phy_dev)) {
> +		/* -ENODEV here would also send DSA to the switch's own bus. */
> +		if (phy_dev)
> +			phy_device_free(phy_dev);
> +
> +		pl->late_phy_fwnode = phy_fwnode;
> +		pl->late_phy_flags = flags;
> +		pl->late_phy_poll_ms = PHYLINK_LATE_PHY_POLL_MS;
> +		pl->late_phy_waited_ms = 0;
> +		pl->late_phy_retries = PHYLINK_LATE_PHY_RETRIES;
> +		pl->late_phy_warned = false;
> +		queue_delayed_work(system_freezable_power_efficient_wq,
> +				   &pl->late_phy_poll, 0);
> +		return 0;
> +	}

[Severity: High]
Can this leave dev->phydev NULL for callers that take 0 to mean the PHY
is attached? ucc_geth_open() is one of them:

	err = phylink_of_phy_connect(ugeth->phylink, ugeth->dev->of_node, 0);
	if (err) {
		dev_err(&dev->dev, "Could not attach to PHY\n");
		return -ENODEV;
	}
	...
	device_set_wakeup_capable(&dev->dev,
			qe_alive_during_sleep() || dev->phydev->irq);

With CONFIG_PPC_85xx, qe_alive_during_sleep() always returns 0, so
dev->phydev->irq is evaluated. The deferral branch never calls
phy_attach_direct(), so dev->phydev is still NULL at that point.

Would this oops in ndo_open with rtnl held on an 85xx QE board? The
conditions are a PHY node with needs-host-firmware and a PHY driver that
is not loaded yet.

Before this patch, the same situation either bound genphy or returned
-ENODEV, and ucc_geth_open() handles both.

[Severity: Medium]
A related question: several callers do one-time PHY setup right after a
successful connect. The late attach in phylink_late_phy_poll() only does
phylink_attach_phy(), phylink_bringup_phy() and phy_start(), so that
setup is never repeated.

enetc_phylink_connect():

	/* disable EEE autoneg, until ENETC driver supports it */
	memset(&edata, 0, sizeof(struct ethtool_keee));
	phylink_ethtool_set_eee(priv->phylink, &edata);

With pl->phydev NULL, phylink_ethtool_set_eee() returns -EOPNOTSUPP and
changes nothing. ENETC has no LPI mac ops, so phylink_bringup_phy() does
not touch EEE either. Does the late PHY end up advertising EEE on a MAC
that explicitly tries to turn it off?

stmmac_init_phy() passes priv->tx_lpi_timer to phylib through
phylink_ethtool_get_eee() and phylink_ethtool_set_eee(). Both fail when
there is no PHY, so a timer set before the first open looks to be lost.

mvneta_mdio_probe() calls device_set_wakeup_capable() once, from
phylink_ethtool_get_wol(), right after the connect. Nothing updates it
after the late attach, so PHY WoL would never be reported.

sparx5_port_open() takes a NULL phydev after a successful connect to
mean the port has no PHY, and powers up the SerDes:

	if (!ndev->phydev) {
		/* power up serdes */
		port->conf.power_down = false;

The phylink_of_phy_connect() kernel-doc also still says "Actions
specified in phylink_connect_phy() will be performed". That is not true
on the deferred path.

Is there a way for these callers to learn that the connect was deferred,
or for the poller to re-run their post-connect setup?

[Severity: Low]
Does returning here skip the PHY_INTERFACE_MODE_NA fix-up that the
non-deferred path does further down?

	/* Use PHY device/driver interface */
	if (pl->link_interface == PHY_INTERFACE_MODE_NA) {
		pl->link_interface = phy_dev->interface;
		pl->link_config.interface = pl->link_interface;
	}

A DSA user port with no phy-mode in DT gets PHY_INTERFACE_MODE_NA from
dsa_port_phylink_create():

	err = of_get_phy_mode(dp->dn, &mode);
	if (err)
		mode = PHY_INTERFACE_MODE_NA;

Before this patch, a successful connect in MLO_AN_PHY mode meant the
interface was set before phylink_start() ran. Now
phylink_start()->phylink_mac_initial_config() copies pl->phy_state with
the interface still NA. phylink_major_config() then passes it to
mac_select_pcs(), mac_prepare() and mac_config().

The poller's forced major config fixes this later. In the meantime, can
the MAC/PCS be programmed with PHY_INTERFACE_MODE_NA, or fail on it and
set major_config_failed?

>  	/* We're done with the phy_node handle */
>  	fwnode_handle_put(phy_fwnode);
>  	if (!phy_dev)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925001209.2334139-1-f%40lex.la
