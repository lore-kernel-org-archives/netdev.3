Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9113F8EA2;
	Fri, 11 Sep 2026 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152729; cv=none; b=RxU7ixKQdwxT8bCM9aahxsybAjNo1TIKznAGYWAM7ik87HU0AToNyeRlKcWEUXjv+ixcy3B04C4AFJWvdsYJq54LAI30f7nm/J+udfCd172hbUkMytUFCyPcvc/OYuZg/kQp7E+RwIU2ENOugyrlQ7xARpISQqC2Hxtc0C+SJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152729; c=relaxed/simple;
	bh=RCeSx3IrYG4rfAXHao35oWByJ4omMqIyh00vGCSQSfA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2EqVi9HKsxjTIb2CvNevYmhytOPy/jKajW0ZmyExMIpwVwRp2qgII32RqJxUhfL0f9mjfssM2OJKYM8Vo0zMSzuIqjlweqitHhc+kM8BcYeDQq/FNwe4Ly6dRZ/r5M/LsmRCFoJu+TycHWWb8kW2OA7ysOnOzKhrLem1St5pJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6SAHj6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6SAHj6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441701F00893;
	Fri, 11 Sep 2026 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152727;
	bh=8p7zYuyuGA3gQQYpgulfyn0ZpME2hZEJKSkR2ar+2PM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U6SAHj6r+4GI1aqP+QTcUvmucbddmVNZKycLoE586l6CWMmflmf5+xp72fJ7NbOYY
	 4DgAuoPmFwQ9fmDWDBHRN4w4E590ygMiXRpe+c/+ikgUsDffJXHASWg5fsBA4JAdtI
	 SSExCABZBX1timPi3xR+sdUFGhzNq8RD4+LJqSEJTxW7+drsSrQsH0kH/EcSeY+7s5
	 CJ3a1lZy6eTSYtDDkVHdi1PoUqVvIcXvkDh33ExXeWtc5Q+5fHmGV6nqoHtnHI/IYX
	 TIUNVAQSry6iWrn1IhHYOb7cSUKCe7NDySynlcQTAr7vUjIfQh8hrKK1el5YssM4h8
	 MKCBrPiFX29Dw==
Subject: Re: [PATCH RESEND net-next v17 05/10] net: phy: Represent PHY-less
 SFP modules with phy_port
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it
Date: Fri, 11 Sep 2026 18:52:05 +0000
Message-ID: <178915272580.219967.8750635719140746575@kernel.org>
In-Reply-To: <20260910170103.1029108-6-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-6-maxime.chevallier@bootlin.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 1

- [High] FALSE POSITIVE (resolved later in the same series).
- [High] Bitfield data race on `has_sfp_mod_phy` can silently corrupt
  hardware interrupt flags
- [Medium] Failure to allocate/register the purely informational SFP-
  module phy_port now makes the whole SFP module bring-up fail…
- [Medium] Unbalanced registration teardown for `phydev->mod_port`:
  `phy_detach_internal()` unconditionally calls…
- [Low] FALSE POSITIVE.

--

net: phy: Represent PHY-less SFP modules with phy_port

This adds a phy_port to represent a PHY-less SFP module, created and
destroyed from the new .module_start / .module_stop upstream ops in both
phy_device.c and phylink.c, plus a phy_caps helper to filter the module
link modes by the cage port's MII interfaces.

A couple of questions on the new error paths below.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index f15c0fc339b4d..26634ef274f33 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1617,6 +1629,75 @@ static void phy_sfp_link_down(void *upstream)
>  		port->ops->link_down(port);
>  }
>  
> +static int phy_add_sfp_mod_port(struct phy_device *phydev)
> +{
> +	const struct sfp_module_caps *caps;
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	/* Create mod port */
> +	port = phy_port_alloc();
> +	if (!port)
> +		return -ENOMEM;
> +

[ ... ]

> +	if (phydev->attached_dev) {
> +		ret = phy_link_topo_add_port(phydev->attached_dev, port);
> +		if (ret) {
> +			phy_port_destroy(port);
> +			return ret;
> +		}
> +	}

[ ... ]

> +static int phy_sfp_module_start(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +
> +	/* If there's a downstream SFP module, and it doesn't contain a PHY
> +	 * device, let's create a phy_port to represent that module.
> +	 */
> +	if (!phydev->has_sfp_mod_phy)
> +		return phy_add_sfp_mod_port(phydev);
> +
> +	return 0;
> +}

[Severity: Medium]
Should a failure to create this port really abort the whole module
bring-up?

Both new .module_start implementations propagate the error: here
phy_sfp_module_start() returns phy_add_sfp_mod_port()'s -ENOMEM from
phy_port_alloc(), or whatever phy_link_topo_add_port() returns
(xa_alloc_cyclic() -ENOMEM, or -EOPNOTSUPP after the WARN_ON_ONCE for
netdev_need_ops_lock() devices), and phylink_sfp_module_start() does the
same in its new else branch:

	} else {
		ret = phylink_add_sfp_mod_port(pl);
		if (ret)
			return ret;
	}

On the SFP core side, any non-zero return is fatal, in sfp_sm_main():

	case SFP_S_INIT_PHY:
		...
		if (sfp_module_start(sfp->sfp_bus)) {
			sfp_sm_next(sfp, SFP_S_FAIL, 0);
			break;
		}

There is no case SFP_S_FAIL: in that switch, so the only way out is the
global handling at the top of the function, i.e. losing SFP_MOD_PRESENT
or clearing SFP_DEV_UP.

So does a transient kzalloc() failure for this port leave the link down
until the interface is taken down and up again, or the module is
physically re-inserted? Given that the module port is a purely
informational topology object with no data-path role, would it be
preferable to warn and continue rather than to fail the state machine?

The commit message describes only the representation of the module as a
phy_port and doesn't mention this new failure mode.

> @@ -1834,6 +1920,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
>  		phy_link_topo_del_phy(dev, phydev);
> +		if (phydev->mod_port)
> +			phy_link_topo_del_port(dev, phydev->mod_port);
>  	}
>  
>  	phydev->phy_link_change = NULL;
> @@ -1963,6 +2051,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
>  		if (err)
>  			goto error;
> +
> +		if (phydev->mod_port) {
> +			err = phy_link_topo_add_port(dev, phydev->mod_port);
> +			if (err)
> +				goto error;
> +		}
>  	}

[Severity: Medium]
Can this pair of add/del calls unregister a port that belongs to someone
else?

The del side in phy_detach_internal() runs whenever phydev->mod_port is
non-NULL, with no record of whether the port was inserted into this
netdev's topology during this attach. And the del is by id only, without
checking the stored entry:

drivers/net/phy/phy_link_topology.c:phy_link_topo_del_port() {
	struct phy_link_topology *topo = dev->link_topo;

	if (!topo)
		return;

	xa_erase(&topo->ports, port->id);
}

Since a phy_port keeps its id across detach so it can be re-used,
phy_link_topo_add_port() re-inserts with xa_insert():

	if (port->id)
		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);
	else
		ret = xa_alloc_cyclic(&topo->ports, &port->id, port,
				      xa_limit_32b, &topo->next_port_index,
				      GFP_KERNEL);

Two sequences look problematic:

phy_link_topo_add_phy() fails (pdn allocation, -EBUSY on a colliding
index, or -EOPNOTSUPP for an ops-locked netdev)

	goto error;
	  phy_detach_internal(phydev, false)
	    phy_link_topo_del_port(dev, phydev->mod_port)
	      xa_erase(&topo->ports, port->id)

and the module port was never inserted into this topology, so whatever
occupies that index is erased.

The second one is the new call itself: xa_insert() returns -EBUSY when
mod_port's retained id is already taken by another port of that netdev,
and the cleanup then erases exactly that foreign entry.

Would it make sense to only call phy_link_topo_del_port() for a port that
was successfully added here (a flag, or clearing/zeroing the id), and to
have phy_link_topo_del_port() verify the stored pointer before erasing?

This needs mod_port to survive a previous detach, which looks possible
since neither phy_detach() nor phy_detach_internal() stop the SFP state
machine or clear mod_port - only .module_stop does.

[ ... ]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -724,6 +727,7 @@ struct phy_device {
>  	unsigned irq_rerun:1;
>  
>  	unsigned default_timestamp:1;
> +	unsigned has_sfp_mod_phy:1;
>  
>  	int rate_matching;
>  

[Severity: High]
Which lock protects the word this new bit lives in?

has_sfp_mod_phy is added right after default_timestamp, so it lands
in the same machine word as the interrupt bookkeeping bits
interrupts:1, irq_suspended:1 and irq_rerun:1. A C bitfield
assignment is not atomic with respect to its neighbours: the compiler
is free to emit a load of the enclosing word, an OR/AND of one bit,
and a store back. Any concurrent update of a different bit in that
same word is then lost.

The writers of has_sfp_mod_phy are phy_sfp_connect_phy() and
phy_sfp_disconnect_phy(), which run from the SFP state machine work
under rtnl_lock() but without phydev->lock and with interrupts
enabled. irq_rerun (and irq_suspended) are written from
phy_interrupt() and from the mdio_bus_phy_suspend()/_resume() PM
paths, neither of which take rtnl. So a store to has_sfp_mod_phy
that races with phy_interrupt() setting irq_rerun = 1 can drop the
irq_rerun update, and the pending wakeup interrupt is then never
re-run after resume - a silently missed PHY interrupt / broken WoL
wakeup rather than an obvious failure.

The existing rtnl-protected SFP state in this struct is a plain bool
(sfp_bus_attached, with the "This may be modified under the rtnl
lock" comment above it), and the new sfp_cage_port / mod_port
pointers you add sit in that same group. Would it be cleaner to make
has_sfp_mod_phy a bool next to sfp_bus_attached, so it is covered by
the same rule as the rest of the SFP fields and shares no word with
the IRQ flags? If you would rather keep it a bitfield, which lock is
intended to serialise the enclosing word, and how is that
synchronised against phy_interrupt()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
