Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB94F68BA;
	Mon, 19 Oct 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416785; cv=none; b=s55cRsSM4SffuWmXJvnYtEqfDcjhqXQ1XS7L+jalpQuRj+dtX43bKUyqu0sKD+Dx1BeXv8D6W5zMDvyenq+UKcThtRQE7/NvV4yFpkfZYZZ+jrgv15KBuJWdPbvshJWJvN624/whrd/N/mrYPYqfcH6+KGEvTmz84dXXN3XmH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416785; c=relaxed/simple;
	bh=5Gi9N8m0e09GPfPK02Aye7+6mFMg1lfI2ESI1R6KLuA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUoyYzFFj5CmbPbjj58hClDITvSbEFOajiJQTVKQM33KGHko2tWY38XmsNbNPkF2jU/V/CF02MeTqaBkXwrXCSTgpTJWV3a9olLtRkWPtkRFnXmBro8YfdnuFYQ0c46HbvraBwUUlS4GxmYQ7RKGxAcRbqWce1gaFIWI1tMftp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhqFur2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhqFur2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552F21F000C5;
	Mon, 19 Oct 2026 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416783;
	bh=MLiVOZniV9CY4lZ/vw6p2W9udZKkobj5rSzenn8hAPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lhqFur2zzYNVsc4jrfM5NrPsNx45F12iwFsU42anHX3XUyKWxucKooCbA1eEqV/hN
	 mmtf/7sNVLgD/EWBR9p+R8+Ji+5GjQwEugNsjbUsIuT7Nue+JPGxtAW0yBFrx8alb3
	 6ZeDaQHhA5wdp8eObyLyiUtBvGIjhQ7o02a5UwyHhTkdZBddbgPTKkRSL407MM+Yyr
	 BM4hD6WWGZEbQmvO4ee8DerqBeLjVXfDC6LBg4BWXHYvg6LujhwhwNa1KP6ImfOZiG
	 jWv2aLGIwO6iGZLEO3e18IyqhIYI3Wfv+rcwA9gmRX09and4wtcIQOgv+frE8WNCMv
	 cldw8GfVefYWA==
Subject: Re: [PATCH net-next v19 03/10] net: phylink: Register a phy_port for
 MAC-driven SFP cages
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
Date: Mon, 19 Oct 2026 13:33:01 +0000
Message-ID: <179241678192.3135.3853788668273794644@kernel.org>
In-Reply-To: <20261016133107.54054-4-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-4-maxime.chevallier@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] phylink_create_sfp_cage_port() in drivers/net/phy/phylink.c
  allocates the MAC/phylink-driven SFP cage port with phy_port_alloc()…

Pre-existing issues:
- [Medium] mtk_eth_soc creates a NETDEV phylink in mtk_add_mac() with
  phylink_create(&mac->phylink_config, of_fwnode_handle(mac->of_node),…

--

net: phylink: Register a phy_port for MAC-driven SFP cages

This commit makes phylink allocate a phy_port for an SFP cage driven by
the MAC and add it to the netdev's link topology. It does this only for
NETDEV phylink instances. The port is created in phylink_register_sfp()
and freed in phylink_destroy().

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a7d086cdc9b25..971f8961dcf1a 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -1767,6 +1770,52 @@ static void phylink_fixed_poll(struct timer_list *t)
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
Should parent_type and phy be set here? phy_port_alloc() uses kzalloc, so
this port ends up with parent_type == PHY_PORT_PHY (the zero value) and
port->phy == NULL. It is then published through phy_link_topo_add_port().

include/linux/phy_port.h describes PHY_PORT_PHY as the port being driven
by a PHY device, with @phy as the controlling PHY:

enum phy_port_parent {
	PHY_PORT_PHY,
};

The PHY-driven cage port in phy_setup_sfp_port() sets both fields
together:

	port->parent_type = PHY_PORT_PHY;
	port->phy = phydev;

There is currently no enum value that can describe a port owned by the
MAC or by phylink.

Nothing reads parent_type today. port_phydev() is only called from PHY
drivers' own port->ops callbacks, and this port has ops == NULL. However,
port_phydev() returns port->phy without checking it. A future consumer
that trusts parent_type and calls port_phydev() would then get NULL for
this port.

The same pattern appears later in the series. In "net: phy: Represent
PHY-less SFP modules with phy_port", phylink_add_sfp_mod_port() and
phy_add_sfp_mod_port() also publish ports with the default parent_type
and phy == NULL.

Would it make sense to add a parent type for MAC/phylink-driven ports and
set it here?

> +
> +	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
> +			  phylink_sfp_interfaces);
> +	phy_port_update_supported(port);
> +
> +	rtnl_lock();
> +	ret = phy_link_topo_add_port(pl->netdev, port);
> +	rtnl_unlock();

[ ... ]

> @@ -2069,6 +2127,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
>  void phylink_destroy(struct phylink *pl)
>  {
>  	sfp_bus_del_upstream(pl->sfp_bus);
> +	phylink_destroy_sfp_cage_port(pl);

[Severity: Medium]
This is a pre-existing issue, but it now also leaks the new phy_port.
phylink_destroy() is the only path that frees sfp_cage_port, and some
drivers never call it.

For example, drivers/net/ethernet/mediatek/mtk_eth_soc.c creates a NETDEV
phylink in mtk_add_mac():

	phylink = phylink_create(&mac->phylink_config,
				 of_fwnode_handle(mac->of_node),
				 phy_mode, mac_ops);

No phylink_destroy() call exists anywhere in that driver. Both
mtk_free_dev() and the mtk_add_mac() error path call free_netdev()
directly.

If the MAC node has an SFP cage, this call chain allocates the port:

mtk_add_mac()->phylink_create()->phylink_register_sfp()
  ->phylink_create_sfp_cage_port()->phy_port_alloc()

Teardown then follows this chain:

mtk_free_dev()->free_netdev()->netdev_free_phy_link_topology()
  ->xa_destroy(&topo->ports)

xa_destroy() frees only the xarray's internal nodes, not the stored
entries. Is the phy_port leaked on every unbind or failed probe here?

The missing phylink_destroy() in mtk_eth_soc predates this patch. It
already leaks the struct phylink and leaves the SFP upstream registered.
This patch adds one more object to that leak.

>  	if (pl->link_gpio)
>  		gpiod_put(pl->link_gpio);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
