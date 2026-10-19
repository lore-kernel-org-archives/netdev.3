Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333604F93DD;
	Mon, 19 Oct 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416789; cv=none; b=b+tfJfWvauys8/pdD8ai/K5Q+R+pbTi/qqUHQLIQwDI35j1JhKuOjtH6qQV7KwhOr6Eu2wq7Ep6CqDWu9sLEHOSYz9M018jkU6T4+JUwcHKUYfOcBjg5D+sJCCrlNWnVj30MYjFKjPjz82D/qKNJFHQ+cNql8ZwP87f8soZ6snU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416789; c=relaxed/simple;
	bh=oO1O30oxJNrqoFcgHa26ECrDGVkwkkW45rPQoAgck3o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gD0NmYCIrXtAcs7NcMFKzgohQs2ETWqy38+yoyvzn32fyUMw9LJsDMhCSb/a4Q59q/2O2Ajvzv3qpEtH+CYvA7zPh94W1r0jeiMQITqA3FmuMnrbkPMfL+nwkfmb4PLm/VNi3Fj8q9mgUAtmG2ElI+2lKNtgW78jHWXff0/tvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGUozV7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGUozV7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FF01F000C5;
	Mon, 19 Oct 2026 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416787;
	bh=YRmz2NAAlZa24yUWvfHH8e7jPbW9+jpbmUlQPkQr9Cs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QGUozV7xSmYPu++pJWnAZoBoloxYasttZ1IZcsn2GGT8uhaODDHoD7rKTigPU755p
	 zkjUu+Fuvy39oqlzKkpBMJlRR7RnMb+8+EjocpWvmA8foDeJz5y7EA/5CM+EtKBUKx
	 Cm9zp749rqGrFlXifbuAilJr6gHI5b3oVAjiMfJrwKNOU+N5wArB1lPaH8bLRqLdN/
	 ZO7maKFEZ46ePvHNvO9MwXuuAOanTQbegCHEZtCoNOwtaPlOwzH7jIc5oaSKiC7Vhs
	 RAdqhTa1XeyDaa0kF1LPCcV/eiQaHjPuV8OL2YQlOjrg2+Zp54fTeCi47/JoOxD1a8
	 gJrOzlOGzh+8Q==
Subject: Re: [PATCH net-next v19 05/10] net: phy: Represent PHY-less SFP
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
 f@lex.la, chleroy@kernel.org
Date: Mon, 19 Oct 2026 13:33:05 +0000
Message-ID: <179241678581.3135.10036975104512944563@kernel.org>
In-Reply-To: <20261016133107.54054-6-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-6-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The module port's ->supported mask is computed by the new
  phy_caps_linkmode_filter_ifaces(), and the result does not match the…
- [Medium] phy_detach_internal() always calls phy_link_topo_del_port(dev,
  phydev->mod_port) when mod_port is non-NULL, even on the…
- [Medium] phydev->mod_port and phydev->attached_dev are accessed from
  two contexts that share no lock.
- [Medium] The new topology mutations from the SFP
  module_start/module_stop callbacks run without rtnl and without any…
- [Low] phy_add_sfp_mod_port() (phy_device.c) and
  phylink_add_sfp_mod_port() (phylink.c) leave the module port only…

--

net: phy: Represent PHY-less SFP modules with phy_port

This commit creates a phy_port to represent a PHY-less SFP module. The
port is created in the SFP module_start callback and destroyed in
module_stop, for both the phylib (media converter PHY) and phylink
upstreams. It also adds phy_caps_linkmode_filter_ifaces(), which computes
the module port's supported link modes from the cage port's interfaces.

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

[Severity: Medium]
Does this filter always clear Autoneg, Pause and Asym_Pause from the
module port's supported mask?

ifaces_supported is built only from link_caps[].linkmodes.
phy_caps_init() fills that array only for link modes that have a valid
speed and duplex. sfp_module_parse_support() always sets these bits in
caps->link_modes:

drivers/net/phy/sfp-bus.c:sfp_module_parse_support() {
    ...
	phylink_set(modes, Autoneg);
	phylink_set(modes, Pause);
	phylink_set(modes, Asym_Pause);
    ...
}

so linkmode_and() drops them. In contrast, phy_caps_medium_get_supported()
keeps these special bits on purpose ("will be masked away by the port
parent"), and phylink_validate_mask_caps() keeps Autoneg and the port
modes. Is it intended that they are dropped here?

There is a second issue. In phylink_add_sfp_mod_port() the interface
mask comes from pl->sfp_cage_port->interfaces, which is
config->supported_interfaces & phylink_sfp_interfaces:

	phy_interface_and(interfaces, pl->sfp_cage_port->interfaces,
			  caps->interfaces);
	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
					interfaces);

This skips the mac_capabilities/PCS validation that
phylink_sfp_config_optical() applies to pl->sfp_support through
phylink_validate_mask(). For example, phy_caps_from_interface(SGMII)
includes 1000HD. A PHY-less 1000BASE-T module could then report
1000baseT_Half on a MAC without MAC_1000HD.

Can the port list modes that phylink will never configure? Later in the
series this mask is reported to userspace as
ETHTOOL_A_PORT_SUPPORTED_MODES through port_fill_reply().

> +}
> +EXPORT_SYMBOL_GPL(phy_caps_linkmode_filter_ifaces);
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 7713418a6734e..13eb1d40badb5 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1527,6 +1539,78 @@ static void phy_sfp_link_down(void *upstream)
>  		port->ops->link_down(port);
>  }
>  
> +static int phy_add_sfp_mod_port(struct phy_device *phydev)
> +{
> +	DECLARE_PHY_INTERFACE_MASK(interfaces);
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

[Severity: Low]
Is this port initialized enough before it is published to the topology?

Only ->active and ->supported are set here, and the same is true of
phylink_add_sfp_mod_port(). ->mediums and ->pairs stay 0, because
neither phy_caps_mediums_from_linkmodes() nor
phy_port_update_supported() is called, and caps->port from the EEPROM
is not used.

With empty mediums, phy_port_get_type() would return PORT_OTHER for a
fibre or DAC module, and phy_port_is_fiber() and phy_port_is_copper()
would both return false. phy_port_restrict_mediums() documents:

	/* We forbid ending-up with a port with empty mediums */

and phy_default_setup_single_port() does:

	port->mediums = phy_caps_mediums_from_linkmodes(port->supported);

->parent_type is also left at its zero value, PHY_PORT_PHY, while ->phy
stays NULL. port_phydev() therefore returns NULL for a port that claims
a PHY parent. phy_setup_sfp_port() sets:

	port->parent_type = PHY_PORT_PHY;
	port->phy = phydev;

In the phylink case there is no PHY parent at all.

Nothing reads these fields on the mod port yet. net/ethtool/port.c
port_prepare_data() only uses supported, interfaces, id, is_mii, is_sfp
and upstream_port, so this is latent for now.

Should the mediums be derived from the supported modes, and the parent
fields be set consistently?

> +
> +	caps = sfp_get_module_caps(phydev->sfp_bus);
> +
> +	phy_interface_and(interfaces, phydev->sfp_cage_port->interfaces,
> +			  caps->interfaces);
> +	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
> +					interfaces);
> +
> +	if (phydev->attached_dev) {
> +		ret = phy_link_topo_add_port(phydev->attached_dev, port);
> +		if (ret) {
> +			phy_port_destroy(port);
> +			return ret;
> +		}
> +	}
> +
> +	/* we don't use phy_add_port() here as the module port isn't a direct
> +	 * interface from the PHY, but rather an extension to the sfp-bus, that
> +	 * is already represented by its own phy_port
> +	 */
> +	phydev->mod_port = port;
> +
> +	return 0;
> +}
> +
> +static void phy_del_sfp_mod_port(struct phy_device *phydev)
> +{
> +	if (!phydev->mod_port)
> +		return;
> +
> +	if (phydev->attached_dev)
> +		phy_link_topo_del_port(phydev->attached_dev, phydev->mod_port);
> +
> +	phy_port_destroy(phydev->mod_port);
> +	phydev->mod_port = NULL;

[Severity: Medium]
What serializes phydev->mod_port and phydev->attached_dev between this
SFP state machine path and phy_attach_direct()/phy_detach_internal()?

phy_sfp_module_start() and phy_sfp_module_stop() run under sm_mutex, and
under rtnl when called from sfp_timeout() or sfp_check_state().
phy_attach_direct() and phy_detach_internal() do not assert rtnl, and
driver .remove() paths often call phy_disconnect() without it.

phy_disconnect() only calls phy_stop() when phy_is_started() is true.
For a PHY in PHY_ERROR, the SFP upstream therefore stays started and
mod_port is still alive when phy_detach() runs. If the module is pulled
at the same time:

CPU1 (driver .remove)              CPU2 (SFP state machine)
phy_detach_internal()
  if (phydev->mod_port)
                                   sfp_check_state()
                                     phy_sfp_module_stop()
                                       phy_del_sfp_mod_port()
                                         phy_port_destroy(phydev->mod_port);
                                         phydev->mod_port = NULL;
    phy_link_topo_del_port(dev, phydev->mod_port);
      xa_erase(&topo->ports, port->id);

Could this read port->id from the freed port and erase an arbitrary
index?

The add side has a similar window. phy_add_sfp_mod_port() checks
attached_dev and only then publishes mod_port, while phy_attach_direct()
sets attached_dev and then checks mod_port. Depending on the
interleaving, the port is either missing from the topology or added
twice. In the second case xa_insert() returns -EBUSY and the attach
fails.

> +}
> +
> +static int phy_sfp_module_start(void *upstream)
> +{

[ ... ]

> +static void phy_sfp_module_stop(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +
> +	/* Called upon module removal or upstream removal */
> +	if (!phydev->has_sfp_mod_phy)
> +		phy_del_sfp_mod_port(phydev);

[Severity: Medium]
Can this erase and free a topology port without rtnl held?

phy_stop() takes only phydev->lock and runs the SFP stop synchronously:

phy_stop()
  sfp_upstream_stop()
    sfp_stop()
      sfp_sm_event(SFP_E_DEV_DOWN)
        sfp_sm_main()
          sfp_module_stop()
            phy_sfp_module_stop()
              phy_del_sfp_mod_port()
                phy_link_topo_del_port()
                phy_port_destroy()

phylib MAC drivers often call phy_stop() from .suspend(), or through
phy_disconnect() in .remove(), without rtnl. phy_link_topo_add_phy()
says "rtnl_lock is what currently protects the PHY topology", and
phy_link_topo_get_or_alloc() describes the SFP state machine as "rtnl
held or not".

phy_port_destroy() is a plain kfree(). An ETHTOOL_MSG_PORT_GET dump
holding rtnl (port_dump_one_dev() walking topo->ports, added later in
the series) could still be using the port when it is freed.

phylink_add_sfp_mod_port() and phylink_del_sfp_mod_port() also call
phy_link_topo_add_port() and phy_link_topo_del_port() without any rtnl
assertion. phylink_create_sfp_cage_port() in this same patch wraps the
same call:

	rtnl_lock();
	ret = phy_link_topo_add_port(pl->netdev, port);
	rtnl_unlock();

Should these paths assert or take rtnl?

> +}
> +

[ ... ]

> @@ -1744,6 +1833,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
>  		phy_link_topo_del_phy(dev, phydev);
> +		if (phydev->mod_port)
> +			phy_link_topo_del_port(dev, phydev->mod_port);
>  	}
>  
>  	phydev->phy_link_change = NULL;
> @@ -1876,6 +1967,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
>  		if (err)
>  			goto error;
> +
> +		if (phydev->mod_port) {
> +			err = phy_link_topo_add_port(dev, phydev->mod_port);
> +			if (err)
> +				goto error;

[Severity: Medium]
If phy_link_topo_add_port() fails here, or phy_link_topo_add_phy() fails
just above, goto error lands in phy_detach_internal(). That function
calls phy_link_topo_del_port(dev, phydev->mod_port) even though mod_port
was never inserted into dev's topology.

Can this remove some other port from the topology?

phy_link_topo_del_port() does a blind xa_erase(&topo->ports, port->id).
mod_port and its id survive a detach, for example for a PHY in PHY_ERROR
where phy_disconnect() skips phy_stop(), or when phy_detach() is called
on a started PHY. phy_link_topo_add_port() reuses a non-zero id with
xa_insert().

Suppose the PHY is then attached to a different netdev whose topology
already has a port at that index. xa_insert() returns -EBUSY, and the
error path erases that unrelated live port.

phy_link_topo_add_phy() only undoes the ports it actually added, using
list_for_each_entry_continue_reverse(). Should the mod_port unwind also
track whether its insert succeeded?

> +		}
>  	}
>  
>  	/* Some Ethernet drivers try to connect to a PHY device before

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
