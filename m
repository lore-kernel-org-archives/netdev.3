Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3D400987;
	Fri, 11 Sep 2026 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152727; cv=none; b=kMBaGdhMXvW5jYSz5UEoxnZkliWXLaGUW7ckEVLaF2NNHZ0f9kG8HdBnXwZAkey7aFfCbRQbWjvXQ8Uh78H9t83Z76vaIJrQWaAlE4EvZas3OzQ7VbzF7bPfl4KPIsIyh9m8bxztCKI2CL35UMhg2kKn0BeuI79ibdwdPYzXp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152727; c=relaxed/simple;
	bh=A3/Vk3AkTtt5PRXKjaAOLYyzv7ZwuJD8ALo8QeRV7Ng=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBwpkhnc5PuLI7/MGE+vlB1UWVzSxjD6vLgY7Mld8skyM7RRUftvgGUQ0vaso1uuOcAGkGCx9xnz3f+EHs6boXuT1rAzEdYlG63oUx+Q5kLoqtbhB075KhkIwbJG1ROW1biVZkW2KKm4ccE8qW+Jf7iZkHkNvw4jNwiQpsSLtgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/bE3/0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/bE3/0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3848E1F000FF;
	Fri, 11 Sep 2026 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152725;
	bh=bkUuWNYfIRFBXBucXr9dhuGN7D5HvpdUQMmsXZaL6Yg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g/bE3/0vFf67UgEPSV4XxX7uyNJycdj990I8gc1uwhP0GiU3eoaJ8zuGuwyYQa+XW
	 ZF/hCfgDcBKIeXFTuAupotFyS+uG9pADkpeeeKFKbVd9mz7KS0i25Zt1WHgKX2u8+A
	 3ZzkyNk73+1sNnEQYYvQ5d4t8Uc23SMmJGVT7Rb+PfHoJmCz/AE51BxCZZKEQiYTy7
	 njMONu5WGkY9P4IHOKj8YeyTM0Ub2JLME/fm4xEvnfQbobo5+jkRueTyyVOy7zORnx
	 2sygoc8XDf51n0m8SPANL5x1IdmqprKw5HiHl/IyEPdLDiOrrxQTY+lZbqHaqy/pXr
	 UdzTH1s/fU8dA==
Subject: Re: [PATCH RESEND net-next v17 03/10] net: phylink: Register a
 phy_port for MAC-driven SFP cages
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
Date: Fri, 11 Sep 2026 18:52:03 +0000
Message-ID: <178915272375.219967.11314796722105981414@kernel.org>
In-Reply-To: <20260910170103.1029108-4-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-4-maxime.chevallier@bootlin.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 2

- [High] phylink now mutates the rtnl-protected PHY link topology from
  contexts that explicitly do not hold rtnl, and frees a topology-…
- [Low] In `phylink_create_sfp_cage_port()`
  (drivers/net/phy/phylink.c:1773-1800) the newly allocated `struct…
- [Low] Concern (invalidated): Documentation/networking/phy-port.rst
  'Next steps' still claims that only PHY-controlled ports are supported…

--

net: phylink: Register a phy_port for MAC-driven SFP cages

This adds a phy_port object representing a MAC-driven SFP cage, allocated
and registered into the netdev's PHY link topology from
phylink_register_sfp(), and removed/freed from phylink_destroy(). The port
is only created for phylink instances that have a netdev.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 390d3eb3e6f7e..bc81ce7f766fa 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -1767,6 +1770,46 @@ static void phylink_fixed_poll(struct timer_list *t)
>  
>  static const struct sfp_upstream_ops sfp_phylink_ops;
>  
> +static int phylink_create_sfp_cage_port(struct phylink *pl)
> +{
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	if (!pl->netdev || !pl->sfp_bus)
> +		return 0;
> +
> +	port = phy_port_alloc();
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->is_sfp = true;
> +	port->is_mii = true;
> +	port->active = true;

[Severity: Low]
Should this port also describe its parent?

phy_port_alloc() uses kzalloc_obj(), and enum phy_port_parent in
include/linux/phy_port.h currently only has PHY_PORT_PHY, which is 0:

	enum phy_port_parent {
		PHY_PORT_PHY,
	};

So this cage port ends up self-describing as "driven by a PHY device" while
port->phy stays NULL. Every other producer sets both fields together, for
example in phy_device.c:

	port->parent_type = PHY_PORT_PHY;
	port->phy = phydev;

and port_phydev() returns port->phy unconditionally, so a consumer keying
off parent_type would resolve this port to a NULL phy_device. Nothing
dereferences it today since this port has ops == NULL and the ethtool
reader added later in the series does not look at parent_type, but would it
make sense to add an enum value for a MAC/phylink-owned port (something
like PHY_PORT_MAC) and set it here, rather than leaving the zero value
meaning "PHY parent"?

> +
> +	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
> +			  phylink_sfp_interfaces);
> +	phy_port_update_supported(port);
> +
> +	ret = phy_link_topo_add_port(pl->netdev, port);
> +	if (ret)
> +		phy_port_destroy(port);
> +	else
> +		pl->sfp_cage_port = port;
> +
> +	return ret;
> +}
> +
> +static void phylink_destroy_sfp_cage_port(struct phylink *pl)
> +{
> +	if (pl->netdev && pl->sfp_cage_port)
> +		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
> +
> +	if (pl->sfp_cage_port)
> +		phy_port_destroy(pl->sfp_cage_port);
> +
> +	pl->sfp_cage_port = NULL;
> +}
> +

[Severity: High]
What serializes this xa_erase() plus kfree() against topology readers?

phy_link_topo_del_port() erases the port from dev->link_topo->ports and
phy_port_destroy() immediately kfree()s it, with no rtnl, no RCU grace
period and no refcount. The topology is otherwise documented as being
rtnl-protected: phy_link_topo_add_phy() states "rtnl_lock is what currently
protects the PHY topology", and the reader added later in this series
carries an ASSERT_RTNL() plus "Caller must hold RTNL while handling the
phy_port".

The free side runs from phylink_destroy(), whose own kernel-doc says the
opposite:

drivers/net/phy/phylink.c:
	/*
	 * Note: the rtnl lock must not be held when calling this function.
	 */
	void phylink_destroy(struct phylink *pl)
	{
		sfp_bus_del_upstream(pl->sfp_bus);
		phylink_destroy_sfp_cage_port(pl);

Can this then race with an ethtool netlink reader on a live netdev?

CPU0 (ETHTOOL_MSG_PORT_GET, rtnl held)
net/ethtool/port.c:port_prepare_data()
	port = phy_link_topo_get_port(req_info->dev, request->port_id);
	...
	linkmode_copy(reply->supported, port->supported);

CPU1 (dpaa2 DPNI "endpoint changed" threaded IRQ, no rtnl)
dpaa2_eth_disconnect_mac() -> dpaa2_mac_disconnect() -> phylink_destroy()
	phylink_destroy_sfp_cage_port()
		phy_link_topo_del_port()	/* xa_erase */
		phy_port_destroy()		/* kfree */

dpaa2_mac_disconnect() drops rtnl before calling phylink_destroy():

drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:
	rtnl_lock();
	phylink_disconnect_phy(mac->phylink);
	rtnl_unlock();

	phylink_destroy(mac->phylink);

and MAC-driven SFP cages on dpmac nodes do exist in tree, e.g.
fsl-ls1088a-ten64.dts has "&dpmac2 { sfp = <&sfp_xg0>; }", so pl->sfp_bus
is non-NULL and the cage port really is created and destroyed on that
runtime connect/disconnect path.

There is a second, related question on the add side: phylink_create() also
runs without rtnl in that driver, and phy_link_topo_get_or_alloc() does an
unlocked check-then-allocate with a plain store of dev->link_topo:

drivers/net/phy/phy_link_topology.c:
	if (dev->link_topo)
		return dev->link_topo;
	...
	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;

	dev->link_topo = topo;

Is there something that prevents an rtnl-holding reader from observing
dev->link_topo before the xarrays are initialized, given there is no lock
and no release barrier on the publish? The comment in that function argues
races cannot happen based on ordering of PHY versus SFP registration, but
that reasoning does not seem to cover a concurrent reader on an
already-registered netdev.

>  static int phylink_register_sfp(struct phylink *pl,
>  				const struct fwnode_handle *fwnode)
>  {

[ ... ]

> @@ -2069,6 +2121,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
>  void phylink_destroy(struct phylink *pl)
>  {
>  	sfp_bus_del_upstream(pl->sfp_bus);
> +	phylink_destroy_sfp_cage_port(pl);
>  	if (pl->link_gpio)
>  		gpiod_put(pl->link_gpio);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
