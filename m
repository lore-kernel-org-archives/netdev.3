Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F359384250;
	Tue, 29 Sep 2026 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642327; cv=none; b=bW0bUOM2f37QuqAsXk3KOYvt+1aHje4+7RythU/CcT/JYHN84Y4BERWAIFmpLa67MRrnADfSs9WzR1QKOpPjRSuW486657nmtIUNa/ylNv30Wwlzo9a5+vPbQeF/wV0rqEb0N4BJpbSns6ymoLN8KfZS5babkW/xj9Ug3EEBY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642327; c=relaxed/simple;
	bh=ggT2wAhmZEeAnK/Ek4pvRlvvHqBR42Kl98x/BxXAHSg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdbLPJO1o9F6gqEzZqjBVO9yjWnMGoHKguiLWkHHmCZD/mQwpE6OR8azav1sNX6Z/adXbz+XNN7KTwkG9keW0e+49AZcGfRu9x5Goax/JyvB+hPEL7qJzcunxpUMouw9v5L0qixLuAn38DRPJ58KNBxfm/iirTPtgrBb983lUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ2vjK04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ2vjK04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71481F00893;
	Tue, 29 Sep 2026 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642319;
	bh=mkyoSelDXdg9Yj5Y2Ua17nGqFa7/BiXuDZtfQjfAesw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nZ2vjK04GGHdQb7VTReKSb8FGsSVVC9Ed5vQ4p6aKZ/GSMm2D1j6MjiUax16pj7DE
	 9V8LlE9NNGM3tELuyucLR6L5yYYfz8h1QLZH+KgxYWUppn5w0k3tsTQyMsM52/qZKn
	 eHaoHPGpBNmTtBAtySWjTHr9pbCtbyo4XSTQeeZO22NfgguPzH9VgCP3+QwDZsxER2
	 40aoA6U+uxyoNAznCKJ6F+/TUUrTCvPk/ZKY44cOvkZPNx5GSiH/JA4s8+ilkQ5C68
	 utFnlxv1cq6g9mj+lOMUJBWlakGCb2InLWaWCXoKfJ6V6p3YyRXwdOFWlOOROTt2tw
	 9FrXRKcD+Y3nA==
Subject: Re: [PATCH net-next v18 05/10] net: phy: Represent PHY-less SFP
 modules with phy_port
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
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:37 +0000
Message-ID: <179064231728.3145.7796706208878514284@kernel.org>
In-Reply-To: <20260927133619.955236-6-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-6-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, phy_sfp_probe() assigns phydev->sfp_cage_port
  only after sfp_bus_add_upstream() (drivers/net/phy/phy_device.c:1729…
- [Medium] phy_caps_linkmode_filter_ifaces()
  (drivers/net/phy/phy_caps.c:458-472) turns each host cage interface…
- [Medium] phy_detach_internal() (drivers/net/phy/phy_device.c:1833-1834)
  calls phy_link_topo_del_port(dev, phydev->mod_port) whenever mod_port…
- [Low] The new module ports (phydev->mod_port from
  phy_add_sfp_mod_port() and pl->mod_port from…

--

net: phy: Represent PHY-less SFP modules with phy_port

This commit adds a phy_port to represent PHY-less SFP modules. The port
belongs to the SFP bus upstream, which is either a PHY device or phylink.
It is added to the netdev's link topology on module_start and removed on
module_stop. The commit also adds phy_caps_linkmode_filter_ifaces(), which
works out the module port's supported link modes from the cage port's
interfaces.

> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 942d43191561e..558e4df4d63c0 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -445,3 +445,29 @@ u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes)

[ ... ]

> +void phy_caps_linkmode_filter_ifaces(unsigned long *to,
> +				     const unsigned long *from,
> +				     const unsigned long *interfaces)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(ifaces_supported) = {};
> +	unsigned int ifaces_caps = 0;
> +	phy_interface_t interface;
> +
> +	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
> +		ifaces_caps |= phy_caps_from_interface(interface);
> +
> +	phy_caps_linkmodes(ifaces_caps, ifaces_supported);
> +
> +	linkmode_and(to, from, ifaces_supported);
> +}

[Severity: Medium]
Can this report link modes that the host can't run with the inserted
module?

This helper reduces each interface to speed/duplex caps, so the
encoding is lost. It also never looks at the module's own
caps->interfaces. Both phy_add_sfp_mod_port() and
phylink_add_sfp_mod_port() pass the raw EEPROM caps->link_modes through
it.

Take a cage port with interfaces {SGMII, 10GBASE-R} and a dual-rate
module with link_modes {1000baseX_Full, 10000baseSR_Full} and
caps->interfaces {1000BASEX, 10GBASER}. phylink_sfp_config_optical()
narrows the usable set to 10GBASE-R:

	phy_interface_and(pl->sfp_interfaces, pl->config->supported_interfaces,
			  pl->sfp_interfaces);

SGMII maps to LINK_CAPA_1000FD here, so mod_port->supported still
contains 1000baseX_Full.

In the same way, a cage with {USXGMII, 1000BASEX} would keep
10000baseSR_Full, because USXGMII maps to LINK_CAPA_10000FD.

The ETHTOOL_MSG_PORT_GET support added later in the series passes this
mask to userspace unchanged.

Could the cage interfaces be intersected with caps->interfaces first?
For phylink, could the mask come from the validated pl->sfp_support
instead?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3c20d4cc1a79d..ab9631b161bc4 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1527,6 +1539,75 @@ static void phy_sfp_link_down(void *upstream)
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
> +	port->active = true;
> +
> +	caps = sfp_get_module_caps(phydev->sfp_bus);
> +
> +	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
> +					phydev->sfp_cage_port->interfaces);

[Severity: Low]
This has no functional effect today, but should more of the port be
filled in before it goes into dev->link_topo->ports?

Only active and supported are set. phy_port_alloc() uses kzalloc, so
parent_type is 0 (PHY_PORT_PHY), phy and ops are NULL, and mediums is 0.
The struct phy_port kernel-doc says:

 * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
 * @mediums: Bitmask of the physical mediums this port provides access to

So a fibre module port claims a PHY parent but has no PHY. Also,
phy_port_get_type() and phy_port_is_fiber() would return PORT_OTHER and
false for it.

The supported mask is also missing some bits.
phy_caps_linkmode_filter_ifaces() builds its mask from
link_caps[].linkmodes, and phy_caps_init() only fills that in for link
modes with a known speed. As a result, the Autoneg, Pause, Asym_Pause,
FIBRE and TP bits in caps->link_modes don't make it into
mod_port->supported.

That doesn't match the MDI ports that phy_default_setup_single_port()
creates. The ETHTOOL_MSG_PORT_GET support added later in the series
reports this mask unchanged.

phylink_add_sfp_mod_port() has the same issue.

[ ... ]

> @@ -1651,6 +1735,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
>  	 */
>  	sfp_bus_put(bus);
>  
> +	phydev->sfp_cage_port = port;
> +
>  	return ret;
>  
>  out_port:

[Severity: Medium]
Is sfp_cage_port assigned too late here? By this point
sfp_bus_add_upstream() has already registered sfp_phydev_ops, including
the new .module_start, and has dropped RTNL.

phy_add_sfp_mod_port() dereferences the cage port without a NULL check,
unlike phylink_add_sfp_mod_port():

	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
					phydev->sfp_cage_port->interfaces);

sfp_upstream_clear() doesn't clear bus->started. On a rebind,
sfp_register_bus() can therefore restart the state machine:

	if (bus->started)
		bus->socket_ops->start(bus->sfp);

If module_start runs before this assignment, it would read NULL on the
first bind.

On a rebind it would read a freed port. phy_sfp_release() destroys the
cage port but leaves phydev->sfp_cage_port pointing at it:

	list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
		if (!port->is_sfp)
			continue;

		phy_del_port(phydev, port);
		phy_port_destroy(port);
	}

The window is small. module_start runs from the SFP delayed work at
least module_t_wait (about 50ms) after the upstream is added.

A later patch in this series, "net: phy: phy_port: Store information
about a port's upstream", moves this assignment before
sfp_bus_add_upstream() and clears it on the out_port error path. Would
it make sense to use that ordering in this patch instead?

[ ... ]

> @@ -1744,6 +1830,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
>  		phy_link_topo_del_phy(dev, phydev);
> +		if (phydev->mod_port)
> +			phy_link_topo_del_port(dev, phydev->mod_port);
>  	}
>  
>  	phydev->phy_link_change = NULL;
> @@ -1873,6 +1961,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
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
Can this error path remove an unrelated port from the new netdev's
topology?

Both goto error paths end up in phy_detach_internal(). That function
now calls phy_link_topo_del_port(dev, phydev->mod_port) whenever
mod_port is set, and phy_link_topo_del_port() erases by id with no
further check:

	xa_erase(&topo->ports, port->id);

The first goto is taken when phy_link_topo_add_phy() fails. At that
point mod_port hasn't been added to this topology at all.

mod_port can also keep a stale non-zero id from an earlier netdev. For
example, the PHY is started with a PHY-less module fitted, and then
phy_detach() is called without phy_stop(). phy_detach() doesn't stop
the PHY; only phy_disconnect() does.

On the next phy_attach_direct(), phy_link_topo_add_port() reuses that
id:

	ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);

If another port already owns that id in the new topology, this fails
with -EBUSY. The error path would then erase the other port's entry.

phy_link_topo_del_phy() does the same thing for the PHY's own ports.
The mod_port case is new in this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
