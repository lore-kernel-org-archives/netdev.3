Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F548E0CC;
	Mon, 28 Sep 2026 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588349; cv=none; b=LBWwbPJqvWPc52kn7ME0xCGr7LfnbJJw5eTkHM4OVKh0NFmzBY3Ciqy0Jpp4HXgy1HWQlbuuRi2VluWzn6K7fLkvvEeePvnLED/FrZlvFFZ7u/T1IRtOmp7OBzFolVOpXpXhwwRPzydR+IxeLDSlDTHYhEk0qCg7HXymTSw/edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588349; c=relaxed/simple;
	bh=51+6ZFW3Ml0dab1cvW6uohfPnjsoAVVUNAs5xPj3FVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryL24ruLZxmfgMOE7UrXr8e2QHvO7Pp0Tp5JPkjwFLbKWdqQTNI7unHTjb+LZ1LPyI7lCRGS24y6L+ABo5lpPsJ9J1obT0PUkKGv3sbfeqVtvXLN/+9MsMhQOxccnr1AGIodlI7Exm4uWtn9iqRPyraxMBNjfU7NR9QOdInwhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAQd2AlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAQd2AlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641491F000FF;
	Mon, 28 Sep 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588347;
	bh=QT5/TA1Et+zjC7by1UQS1uKsBPM+2raJprefhFjg8no=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YAQd2AlYDbbsP5vP/THTpAO7pUQW1NaGgM8ucecNHryxArSa7gZv2gdJfUvpMAInO
	 wzO1VFBe6tcQWbXKX63DJbwuBuXSZ8U+YILRw4UlShBYznUx2T7Xh8idG2QS8w31Cw
	 UglHo3i9fiSjmmJWInuccd3GiasSHZnnU2iqt9/GkkGEWeAViRpuCmJSp3jCjZSMBP
	 zsBbCTYfkcjhGvluBhJkk+pgtTMOEeYxLh7MTVjg2nZOuZ2WIvBmIFmpg3s/ZlMj9Y
	 p75yJ5xha5l0Afxnq9GSYEUxRsOFmICEWEX6mseVtxJ9plTzWBsLm1G6qVXpomsKZQ
	 FL7CGIyw98RLg==
Message-ID: <7149879c-2432-4072-82e0-452f9881418c@kernel.org>
Date: Mon, 28 Sep 2026 11:38:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 03/10] net: phylink: Register a phy_port for
 MAC-driven SFP cages
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
 <20260927133619.955236-4-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> phy_port tracks the interfaces that a netdevice feeds into. SFP cages are
> such ports, but so far we are only tracking the ones that are driven by
> PHYs acting as media-converters.
> 
> Let's populate a phy_port for MAC driven SFP cages, handled by phylink.
> 
> This phy_port represents the SFP cage itself, and not the module that
> may be plugged into it. It's therefore not an MDI interface, so only the
> 'interfaces' field is relevant here.
> 
> The phy_port is only populated for 'NETDEV' phylink instances, as
> otherwise we don't have any topology to attach the port to.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phylink.c | 57 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a7d086cdc9b2..19090916af75 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -14,6 +14,8 @@
>   #include <linux/of_mdio.h>
>   #include <linux/phy.h>
>   #include <linux/phy_fixed.h>
> +#include <linux/phy_link_topology.h>
> +#include <linux/phy_port.h>
>   #include <linux/phylink.h>
>   #include <linux/rtnetlink.h>
>   #include <linux/spinlock.h>
> @@ -93,6 +95,7 @@ struct phylink {
>   	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
>   	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
>   	u8 sfp_port;
> +	struct phy_port *sfp_cage_port;
>   
>   	struct eee_config eee_cfg;
>   
> @@ -1767,6 +1770,50 @@ static void phylink_fixed_poll(struct timer_list *t)
>   
>   static const struct sfp_upstream_ops sfp_phylink_ops;
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
> +	if (pl->netdev && pl->sfp_cage_port) {
> +		/* The port may still be accessed under RTNL */
> +		rtnl_lock();
> +		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
> +		rtnl_unlock();
> +	}
> +
> +	if (pl->sfp_cage_port)
> +		phy_port_destroy(pl->sfp_cage_port);
> +
> +	pl->sfp_cage_port = NULL;
> +}
> +
>   static int phylink_register_sfp(struct phylink *pl,
>   				const struct fwnode_handle *fwnode)
>   {
> @@ -1784,9 +1831,18 @@ static int phylink_register_sfp(struct phylink *pl,
>   
>   	pl->sfp_bus = bus;
>   
> +	ret = phylink_create_sfp_cage_port(pl);
> +	if (ret) {
> +		sfp_bus_put(bus);
> +		return ret;
> +	}
> +
>   	ret = sfp_bus_add_upstream(bus, pl, &sfp_phylink_ops);
>   	sfp_bus_put(bus);
>   
> +	if (ret)
> +		phylink_destroy_sfp_cage_port(pl);
> +
>   	return ret;
>   }
>   
> @@ -2069,6 +2125,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
>   void phylink_destroy(struct phylink *pl)
>   {
>   	sfp_bus_del_upstream(pl->sfp_bus);
> +	phylink_destroy_sfp_cage_port(pl);
>   	if (pl->link_gpio)
>   		gpiod_put(pl->link_gpio);
>   

