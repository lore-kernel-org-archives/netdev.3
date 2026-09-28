Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8549158B;
	Mon, 28 Sep 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588533; cv=none; b=EqJL0xRq2BLvTp7+W6EU0k8Os5Yu6iKOOojq0/W1GmOYLGhPlnTn8/VNZR7pXFGr3yU5HzeGHGg96nLcSSBMH7UumOfWsFH+NjO/SfuOjEqPqznI/5k+AAKede73WyNt7u9f694qD7eBPzeRLuLir3mPKJFRX8zx4jzxdXzIY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588533; c=relaxed/simple;
	bh=Uzis3zwzOU7UBBDxg/EhQkXe5PWPIYAnmdFvNPj6tAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbpBDC65DC4+lspWa6ZtLsLl3t7YMUrw+g7TMyl3Vqt2zqgkUrH0DiI3ThmQUseGLruAKvTn9QZ/ozJP5+zbjXRlZHjPR0D8w4KCQ/y7yNIgDfL49+akG5kySBJzCDvpivimi6VyKv8TCvE8KlwOJEdpFRwBClUS+Gcwn3GnBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMGLAdMB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMGLAdMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA591F000FF;
	Mon, 28 Sep 2026 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588530;
	bh=UTengHvPYhZtBlgD3KO0eZxvsMlDR5S47JsF2+I3aO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MMGLAdMB1SK+dAHpsHxR0l1RGn/5uhjufqTy+67bIejnp34WcKMaznCq7CwxuELDE
	 6bME+jyzuaXf4KKbtTS5HVJ0o1ToM77S16ZSG61L5b4+3bZAuvXW59hpfAoqzq/03/
	 TtSAQA368xhScPVGlNpZcn6XIjiwGS2+fHmxLyxSSCUyWcgdLgRZRFtV7Gp8eK9GT7
	 aV2tTxRobtWgpwfKm1g13228+SZ6Fr8H7YJGlN/gLrG3P5fozA29lAyDghFGX2ogK8
	 YHSOgZ11C6chdzipze3p4rLPOTqgyPkqkKAx2jDKbqreF/uNA/1xZ/US3hd/stWjPa
	 Ys7OU+aO39qvw==
Message-ID: <8929fbe2-4a46-44c6-ac18-caff743b8075@kernel.org>
Date: Mon, 28 Sep 2026 11:42:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 05/10] net: phy: Represent PHY-less SFP
 modules with phy_port
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260927133619.955236-6-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-6-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> Now that the SFP bus infrastructure notifies when PHY-less modules are
> connected, we can create a phy_port to represent it. Instead of letting
> the SFP subsystem handle that, the Bus' upstream is in charge of
> maintaining that phy_port and register it to the topology, as the
> upstream (in this case a phy device) is directly interacting with the
> underlying net_device.
> 
> Add a phy_caps helper to get the achievable modes on this module based
> on what the phy_port representing the bus supports.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy-caps.h   |   2 +
>   drivers/net/phy/phy_caps.c   |  26 +++++++++
>   drivers/net/phy/phy_device.c | 100 +++++++++++++++++++++++++++++++++--
>   drivers/net/phy/phylink.c    |  76 ++++++++++++++++++++++++--
>   include/linux/phy.h          |   6 +++
>   5 files changed, 203 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
> index 421088e6f6e8..ec3d39a0ae06 100644
> --- a/drivers/net/phy/phy-caps.h
> +++ b/drivers/net/phy/phy-caps.h
> @@ -66,5 +66,7 @@ void phy_caps_medium_get_supported(unsigned long *supported,
>   				   enum ethtool_link_medium medium,
>   				   int lanes);
>   u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes);
> +void phy_caps_linkmode_filter_ifaces(unsigned long *to, const unsigned long *from,
> +				     const unsigned long *interfaces);
>   
>   #endif /* __PHY_CAPS_H */
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 942d43191561..558e4df4d63c 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -445,3 +445,29 @@ u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes)
>   	return mediums;
>   }
>   EXPORT_SYMBOL_GPL(phy_caps_mediums_from_linkmodes);
> +
> +/**
> + * phy_caps_linkmode_filter_ifaces() - Filter linkmodes with an interface list
> + * @to: Stores the filtered linkmodes
> + * @from: Linkmodes to filter
> + * @interfaces: Bitfield of phy_interface_t that we use for filtering
> + *
> + * Filter the provided linkmodes, only to keep the ones we can possibly achieve
> + * when using any of the provided MII interfaces.
> + */
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
> +EXPORT_SYMBOL_GPL(phy_caps_linkmode_filter_ifaces);
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3c20d4cc1a79..ab9631b161bc 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1400,11 +1400,21 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>   {
>   	struct phy_device *phydev = upstream;
>   	struct net_device *dev = phydev->attached_dev;
> +	int ret;
>   
> -	if (dev)
> -		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
> +	phydev->has_sfp_mod_phy = true;
>   
> -	return 0;
> +	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
> +	 * topology.
> +	 */
> +	if (!dev)
> +		return 0;
> +
> +	ret = phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
> +	if (ret)
> +		phydev->has_sfp_mod_phy = false;
> +
> +	return ret;
>   }
>   
>   /**
> @@ -1422,6 +1432,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
>   	struct phy_device *phydev = upstream;
>   	struct net_device *dev = phydev->attached_dev;
>   
> +	phydev->has_sfp_mod_phy = false;
> +
>   	if (dev)
>   		phy_link_topo_del_phy(dev, phy);
>   }
> @@ -1527,6 +1539,75 @@ static void phy_sfp_link_down(void *upstream)
>   		port->ops->link_down(port);
>   }
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
> +}
> +
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
> +
> +static void phy_sfp_module_stop(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +
> +	/* Called upon module removal or upstream removal */
> +	if (!phydev->has_sfp_mod_phy)
> +		phy_del_sfp_mod_port(phydev);
> +}
> +
>   static const struct sfp_upstream_ops sfp_phydev_ops = {
>   	.attach = phy_sfp_attach,
>   	.detach = phy_sfp_detach,
> @@ -1536,6 +1617,8 @@ static const struct sfp_upstream_ops sfp_phydev_ops = {
>   	.link_down = phy_sfp_link_down,
>   	.connect_phy = phy_sfp_connect_phy,
>   	.disconnect_phy = phy_sfp_disconnect_phy,
> +	.module_start = phy_sfp_module_start,
> +	.module_stop = phy_sfp_module_stop,
>   };
>   
>   static int phy_add_port(struct phy_device *phydev, struct phy_port *port)
> @@ -1638,6 +1721,7 @@ static int phy_sfp_probe(struct phy_device *phydev)
>   		port = phy_setup_sfp_port(phydev);
>   		if (IS_ERR(port)) {
>   			ret = PTR_ERR(port);
> +			port = NULL;
>   			goto out_sfp;
>   		}
>   	}
> @@ -1651,6 +1735,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
>   	 */
>   	sfp_bus_put(bus);
>   
> +	phydev->sfp_cage_port = port;
> +
>   	return ret;
>   
>   out_port:
> @@ -1744,6 +1830,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>   		phydev->attached_dev->phydev = NULL;
>   		phydev->attached_dev = NULL;
>   		phy_link_topo_del_phy(dev, phydev);
> +		if (phydev->mod_port)
> +			phy_link_topo_del_port(dev, phydev->mod_port);
>   	}
>   
>   	phydev->phy_link_change = NULL;
> @@ -1873,6 +1961,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>   		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
>   		if (err)
>   			goto error;
> +
> +		if (phydev->mod_port) {
> +			err = phy_link_topo_add_port(dev, phydev->mod_port);
> +			if (err)
> +				goto error;
> +		}
>   	}
>   
>   	/* Some Ethernet drivers try to connect to a PHY device before
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 19090916af75..db05d2dda429 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -96,6 +96,7 @@ struct phylink {
>   	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
>   	u8 sfp_port;
>   	struct phy_port *sfp_cage_port;
> +	struct phy_port *mod_port;
>   
>   	struct eee_config eee_cfg;
>   
> @@ -1792,10 +1793,15 @@ static int phylink_create_sfp_cage_port(struct phylink *pl)
>   
>   	ret = phy_link_topo_add_port(pl->netdev, port);
>   	if (ret)
> -		phy_port_destroy(port);
> -	else
> -		pl->sfp_cage_port = port;
> +		goto out_destroy_port;
> +
> +	pl->sfp_cage_port = port;
> +
> +	return 0;
>   
> +out_destroy_port:
> +	phy_port_destroy(port);
> +	pl->sfp_cage_port = NULL;
>   	return ret;
>   }
>   
> @@ -4012,14 +4018,65 @@ static void phylink_sfp_module_remove(void *upstream)
>   	phy_interface_zero(pl->sfp_interfaces);
>   }
>   
> +static int phylink_add_sfp_mod_port(struct phylink *pl)
> +{
> +	const struct sfp_module_caps *caps;
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	if (!pl->sfp_cage_port)
> +		return 0;
> +
> +	/* Create mod port */
> +	port = phy_port_alloc();
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->active = true;
> +
> +	caps = sfp_get_module_caps(pl->sfp_bus);
> +
> +	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
> +					pl->sfp_cage_port->interfaces);
> +
> +	if (pl->netdev) {
> +		ret = phy_link_topo_add_port(pl->netdev, port);
> +		if (ret) {
> +			phy_port_destroy(port);
> +			return ret;
> +		}
> +	}
> +
> +	pl->mod_port = port;
> +
> +	return 0;
> +}
> +
> +static void phylink_del_sfp_mod_port(struct phylink *pl)
> +{
> +	if (!pl->mod_port)
> +		return;
> +
> +	if (pl->netdev)
> +		phy_link_topo_del_port(pl->netdev, pl->mod_port);
> +
> +	phy_port_destroy(pl->mod_port);
> +	pl->mod_port = NULL;
> +}
> +
>   static int phylink_sfp_module_start(void *upstream)
>   {
>   	struct phylink *pl = upstream;
> +	int ret;
>   
>   	/* If this SFP module has a PHY, start the PHY now. */
>   	if (pl->phydev) {
>   		phy_start(pl->phydev);
>   		return 0;
> +	} else {
> +		ret = phylink_add_sfp_mod_port(pl);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	/* If the module may have a PHY but we didn't detect one we
> @@ -4028,7 +4085,16 @@ static int phylink_sfp_module_start(void *upstream)
>   	if (!pl->sfp_may_have_phy)
>   		return 0;
>   
> -	return phylink_sfp_config_optical(pl);
> +	ret = phylink_sfp_config_optical(pl);
> +	if (ret)
> +		goto del_mod_port;
> +
> +	return 0;
> +
> +del_mod_port:
> +	phylink_del_sfp_mod_port(pl);
> +
> +	return ret;
>   }
>   
>   static void phylink_sfp_module_stop(void *upstream)
> @@ -4038,6 +4104,8 @@ static void phylink_sfp_module_stop(void *upstream)
>   	/* If this SFP module has a PHY, stop it. */
>   	if (pl->phydev)
>   		phy_stop(pl->phydev);
> +	else
> +		phylink_del_sfp_mod_port(pl);
>   }
>   
>   static void phylink_sfp_link_down(void *upstream)
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 7c5098a0dd6c..dbd6ed5864f2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -611,7 +611,10 @@ struct phy_oatc14_sqi_capability {
>    * @irq: IRQ number of the PHY's interrupt (-1 if none)
>    * @phylink: Pointer to phylink instance for this PHY
>    * @sfp_bus_attached: Flag indicating whether the SFP bus has been attached
> + * @has_sfp_mod_phy: Set true if downstream SFP bus's module contains a PHY
>    * @sfp_bus: SFP bus attached to this PHY's fiber port
> + * @sfp_cage_port: The phy_port connected to the downstream SFP cage
> + * @mod_port: phy_port representing the SFP module, if it is phy-less
>    * @attached_dev: The attached enet driver's device instance ptr
>    * @adjust_link: Callback for the enet controller to respond to changes: in the
>    *               link state.
> @@ -802,7 +805,10 @@ struct phy_device {
>   
>   	/* This may be modified under the rtnl lock */
>   	bool sfp_bus_attached;
> +	bool has_sfp_mod_phy;
>   	struct sfp_bus *sfp_bus;
> +	struct phy_port *sfp_cage_port;
> +	struct phy_port *mod_port;
>   	struct phylink *phylink;
>   	struct net_device *attached_dev;
>   	struct mii_timestamper *mii_ts;

