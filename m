Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D34519A3;
	Mon, 28 Sep 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588607; cv=none; b=cUcOrzUZVVI4NgRksKMVhTiuim7Ipaf+Ri+qNT1cETsyFynSPSNP2XktkhuRhfb54ajssdxVyD0n6yQ9hoZr91+R+Y5x/IioBdif4K90RbbFm7lzPBvaMIVvKOw8hLIdVww2LZ+Fl0XEhUjj37Q3hdFa8xUkfJ6XYp7G+LY+/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588607; c=relaxed/simple;
	bh=US8vveFE17kSaYyKqyRnMEYYhk3vkY9iB/B7o/wtrJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXUwLiIAt1sS072EfOSJbapE9FG5I8on/0drHkBWVyAsFxEdm5kgT/NkTQgHIE4goHvNFcoYq+7eYTsSFjm+RtusFzKKsIvyQHilY/KFUnkS7s7DUY5BFE7tqRmqD0hvItg31ZhdRMqbnn46J32PqQewxzps6Z5QmpKnf5w5SEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7uTBw/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7uTBw/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314481F00893;
	Mon, 28 Sep 2026 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588605;
	bh=serXa8ATa4wjn72/YUoo0gJ0oU500SRV+rZODcA6X3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C7uTBw/xLkD7JxbqnQ+HpbvT/uEY00+JOiY2wIfkIGpMw0pU4lxJwjfjC4HR0EOfG
	 jelN69N0Zx+CYhhtr1j0bIInuz7ACeZps+JBHH3RR7toDFyb/Ah9vgdTrG1/MUm28R
	 06ScY5o3yzJ1+mTlib9D9pcQaYfP4uZCZ1K6LMdh7unidjc8S+r50EN1STOQYWX9O/
	 +xiPAhv8wC6+87g1If9y4foFIk43tNwTntvLEPCVsqrfANVEGOE2gbbahFRtfKl8Fo
	 N6F4v4aj7WdyRp38amG5hYBX+0duQAwGAq/gfPdxxujaeUOqfY7jYANnSxVMFxZK3z
	 5RRLel3gw+BDQ==
Message-ID: <04e6c889-b312-4351-a2b6-4540e9576408@kernel.org>
Date: Mon, 28 Sep 2026 11:43:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 06/10] net: phy: phy_port: Store information
 about a port's upstream
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
 <20260927133619.955236-7-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-7-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> MII phy_ports are not meant to be connected directly to a link partner.
> They are meant to feed into some media converter devices that will
> expose an MDI phy_port, so far we only support SFP modules for that.
> 
> In the case an MDI phy_port is backed by an MII port (e.g. a SFP
> module's port, backed by the SFP cage port), let's keep track of the
> port id of the MII port backing it.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_device.c | 29 +++++++++++++++++++++++++++--
>   drivers/net/phy/phylink.c    |  5 +++++
>   include/linux/phy.h          |  4 ++++
>   include/linux/phy_port.h     |  3 +++
>   4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ab9631b161bc..2bb4abd0d392 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1403,6 +1403,7 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>   	int ret;
>   
>   	phydev->has_sfp_mod_phy = true;
> +	phy_set_upstream_port(phy, phydev->sfp_cage_port);
>   
>   	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
>   	 * topology.
> @@ -1436,6 +1437,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
>   
>   	if (dev)
>   		phy_link_topo_del_phy(dev, phy);
> +
> +	phy_set_upstream_port(phy, NULL);
>   }
>   
>   /**
> @@ -1571,6 +1574,8 @@ static int phy_add_sfp_mod_port(struct phy_device *phydev)
>   	 */
>   	phydev->mod_port = port;
>   
> +	port->upstream_port = phydev->sfp_cage_port;
> +
>   	return 0;
>   }
>   
> @@ -1726,6 +1731,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
>   		}
>   	}
>   
> +	phydev->sfp_cage_port = port;
> +
>   	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
>   	if (ret)
>   		goto out_port;
> @@ -1735,14 +1742,13 @@ static int phy_sfp_probe(struct phy_device *phydev)
>   	 */
>   	sfp_bus_put(bus);
>   
> -	phydev->sfp_cage_port = port;
> -
>   	return ret;
>   
>   out_port:
>   	if (port) {
>   		phy_del_port(phydev, port);
>   		phy_port_destroy(port);
> +		phydev->sfp_cage_port = NULL;
>   	}
>   out_sfp:
>   	sfp_bus_put(bus);
> @@ -3687,6 +3693,25 @@ struct phy_port *phy_get_sfp_port(struct phy_device *phydev)
>   }
>   EXPORT_SYMBOL_GPL(phy_get_sfp_port);
>   
> +/**
> + * phy_set_upstream_port() - Sets the phy_port controlling the MII this PHY is
> + *			     attached to.
> + * @phydev: pointer to the PHY device we set the upstream of.
> + * @port: The phy_port upstream of this PHY, can be NULL.
> + */
> +void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port)
> +{
> +	struct phy_port *local_port;
> +
> +	ASSERT_RTNL();
> +
> +	phydev->upstream_port = port;
> +
> +	phy_for_each_port(phydev, local_port)
> +		local_port->upstream_port = port;
> +}
> +EXPORT_SYMBOL_GPL(phy_set_upstream_port);
> +
>   /**
>    * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
>    * @fwnode: pointer to the mdio_device's fwnode
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index db05d2dda429..2583e913cff6 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -4047,6 +4047,8 @@ static int phylink_add_sfp_mod_port(struct phylink *pl)
>   		}
>   	}
>   
> +	port->upstream_port = pl->sfp_cage_port;
> +
>   	pl->mod_port = port;
>   
>   	return 0;
> @@ -4150,6 +4152,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
>   	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
>   			  pl->config->supported_interfaces);
>   
> +	phy_set_upstream_port(phy, pl->sfp_cage_port);
> +
>   	/* Do the initial configuration */
>   	return phylink_sfp_config_phy(pl, phy);
>   }
> @@ -4158,6 +4162,7 @@ static void phylink_sfp_disconnect_phy(void *upstream,
>   				       struct phy_device *phydev)
>   {
>   	phylink_disconnect_phy(upstream);
> +	phy_set_upstream_port(phydev, NULL);
>   }
>   
>   static const struct sfp_upstream_ops sfp_phylink_ops = {
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index dbd6ed5864f2..1fb87d12367b 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -615,6 +615,7 @@ struct phy_oatc14_sqi_capability {
>    * @sfp_bus: SFP bus attached to this PHY's fiber port
>    * @sfp_cage_port: The phy_port connected to the downstream SFP cage
>    * @mod_port: phy_port representing the SFP module, if it is phy-less
> + * @upstream_port: phy_port this PHY's MII attaches to, if any
>    * @attached_dev: The attached enet driver's device instance ptr
>    * @adjust_link: Callback for the enet controller to respond to changes: in the
>    *               link state.
> @@ -809,6 +810,7 @@ struct phy_device {
>   	struct sfp_bus *sfp_bus;
>   	struct phy_port *sfp_cage_port;
>   	struct phy_port *mod_port;
> +	struct phy_port *upstream_port;
>   	struct phylink *phylink;
>   	struct net_device *attached_dev;
>   	struct mii_timestamper *mii_ts;
> @@ -2493,6 +2495,8 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
>   
>   struct phy_port *phy_get_sfp_port(struct phy_device *phydev);
>   
> +void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port);
> +
>   /**
>    * phy_module_driver() - Helper macro for registering PHY drivers
>    * @__phy_drivers: array of PHY drivers to register
> diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
> index 4e2a3fdd2f2e..8f45c031cbc1 100644
> --- a/include/linux/phy_port.h
> +++ b/include/linux/phy_port.h
> @@ -40,6 +40,8 @@ struct phy_port_ops {
>    * @head: Used by the port's parent to list ports
>    * @parent_type: The type of device this port is directly connected to
>    * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
> + * @upstream_port: Indicates the MII port that feeds this port, if any,
> + *		   e.g. the SFP cage port for a SFP module port.
>    * @ops: Callback ops implemented by the port controller
>    * @pairs: The number of  pairs this port has, 0 if not applicable
>    * @mediums: Bitmask of the physical mediums this port provides access to
> @@ -59,6 +61,7 @@ struct phy_port {
>   	union {
>   		struct phy_device *phy;
>   	};
> +	struct phy_port *upstream_port;
>   
>   	const struct phy_port_ops *ops;
>   

