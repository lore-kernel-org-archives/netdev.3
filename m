Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FE48FF91;
	Mon, 28 Sep 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588427; cv=none; b=EmD3W9OIE/w1HkPNzCKL3LAsKjNCM2ny7cEFs7dZN7QX/7i78MMQrWPILCSyHKmLN0O/8KAz6XLc1NkMocuGd3hQLj+iPOanI/3S84WWSan1TCBKp8YIfY7D5b2TFV/o3ndjFw2LuLZtr872jHvIGMdsLD2hghWzkfvw+AqziDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588427; c=relaxed/simple;
	bh=z7uZJW6kOmT6z67PfI7LPW5hVP4s3D6pjjSaycbLRo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLh5vubC6B8s3Xc9eWtwCFkQKxxzcrd5lqe8QUa1wGcQtPOI5NzA/g8FdxqdAxHoH23irLCSQT+ARcx8ANyNuqOR5lL9bOT11vdRWWhczOZlwM9LBne0ml+HEuWPywdC3XoDutWtDKsvfGdyRG4TroD2EnpRaYOKyNmKWOApayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM0ZHbnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM0ZHbnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CEA1F00893;
	Mon, 28 Sep 2026 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588425;
	bh=GmsPvJ2re1hlscT+T1bqWwUKpdXZoN20Mjs+yKK3pbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bM0ZHbnkGZHFK0+Z0oMXmXYnKXfS1dhMRDljLnD+tNoPCCgueRjs4PCGJ3BhR3bUM
	 bygYJz47rAeco9dQPh7qvfm0XM9XDGuy4d+1pfujovWBwsZNCXIwgAWur7ByH0h2Xq
	 DjEB/nfFEFqMHxF5YTmB1uqqoqjBpf2dOZ2F6R4xRuENj+DCVjbgEMxOAK7ehNWzyd
	 lnrCzH1XTCuf+Pxamcl/SEx96KSbGyTnDGdLEONGMSn3T58WTKGMH/PS8kLZq9FwlM
	 8yRNOz6tIEmqZY1G9tCrNvEGChLnXefmtUbzUG7JN/w4KoHsV5/PnBjd3hW4p4jjp0
	 KMrk5k0zmUQxg==
Message-ID: <d6cecdb4-dea0-4f3e-bc0b-aca745c2d68c@kernel.org>
Date: Mon, 28 Sep 2026 11:40:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 04/10] net: phy: Create SFP phy_port before
 registering upstream
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
 <20260927133619.955236-5-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-5-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> When dealing with PHY-driven SFP, we create a phy_port representing the
> SFP bus when we know we have such a bus.
> 
> We can move the port creation before registering the sfp upstream ops,
> as long as we know the SFP bus is there. This will allow passing the
> phy_port along with the upstream information to the SFP bus.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_device.c | 58 +++++++++++++++++++++++-------------
>   1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index c4d2c03b8282..3c20d4cc1a79 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1586,13 +1586,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
>   	phydev->n_ports--;
>   }
>   
> -static int phy_setup_sfp_port(struct phy_device *phydev)
> +static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
>   {
>   	struct phy_port *port = phy_port_alloc();
>   	int ret;
>   
>   	if (!port)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
>   	port->parent_type = PHY_PORT_PHY;
>   	port->phy = phydev;
> @@ -1607,10 +1607,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
>   	 * when attaching the port to the phydev.
>   	 */
>   	ret = phy_add_port(phydev, port);
> -	if (ret)
> +	if (ret) {
>   		phy_port_destroy(port);
> +		return ERR_PTR(ret);
> +	}
>   
> -	return ret;
> +	return port;
>   }
>   
>   /**
> @@ -1619,30 +1621,46 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
>    */
>   static int phy_sfp_probe(struct phy_device *phydev)
>   {
> +	struct phy_port *port = NULL;
>   	struct sfp_bus *bus;
> -	int ret = 0;
> +	int ret;
>   
> -	if (phydev->mdio.dev.fwnode) {
> -		bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
> -		if (IS_ERR(bus))
> -			return PTR_ERR(bus);
> +	if (!phydev->mdio.dev.fwnode)
> +		return 0;
>   
> -		phydev->sfp_bus = bus;
> +	bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);
>   
> -		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> -		sfp_bus_put(bus);
> +	phydev->sfp_bus = bus;
>   
> -		if (ret)
> -			phydev->sfp_bus = NULL;
> +	if (bus) {
> +		port = phy_setup_sfp_port(phydev);
> +		if (IS_ERR(port)) {
> +			ret = PTR_ERR(port);
> +			goto out_sfp;
> +		}
>   	}
>   
> -	if (!ret && phydev->sfp_bus) {
> -		ret = phy_setup_sfp_port(phydev);
> -		if (ret) {
> -			sfp_bus_del_upstream(phydev->sfp_bus);
> -			phydev->sfp_bus = NULL;
> -		}
> +	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> +	if (ret)
> +		goto out_port;
> +
> +	/* sfp_bus_add_upstream() grabs a ref to the sfp bus on success, it's
> +	 * safe to release it now.
> +	 */
> +	sfp_bus_put(bus);
> +
> +	return ret;
> +
> +out_port:
> +	if (port) {
> +		phy_del_port(phydev, port);
> +		phy_port_destroy(port);
>   	}
> +out_sfp:
> +	sfp_bus_put(bus);
> +	phydev->sfp_bus = NULL;
>   
>   	return ret;
>   }

