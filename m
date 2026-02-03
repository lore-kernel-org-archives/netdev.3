Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8A31B123;
	Tue,  3 Feb 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141140; cv=none; b=QRmS+KCLReCIhycA3gLPelVQTIb9++n6IeDPdQLAZNOZonqF6tQjt++34vtM7ruoCxt1pt7v5juAeXpSFYYIx7SviPdpj+ZxNQ+DMnv04nzYxgYTDWEcjwzf/8grLz1d9mhSxggM15ebuiSniTbewaoL1dXzhUgzg+730vffwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141140; c=relaxed/simple;
	bh=BMoqo4Vjj3pjnlIguaSEYKWV1E5G0IXn/SzuqK999qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvGEoTo5pg1NHJ+KDoUMWEROGlj7/by4ud5UbTSuTH/g7/G6Zms3cJtEv484gf5se5kfR+hVh0i3JGPaFeoD2to4cZ3LyBAXISFjmYTNchHndMhkBHViBRvEawqyl9Bx4yCmRxTzNvsbJTf4Sxyt4nolF6loO2JYfuADmlSzg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKuK+QSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKuK+QSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF4CC116D0;
	Tue,  3 Feb 2026 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141139;
	bh=BMoqo4Vjj3pjnlIguaSEYKWV1E5G0IXn/SzuqK999qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKuK+QSRlz/G16B/A/gIe+Hh7Foxc7NU3ZF3e3QWAoutfFlPAk3o2FGXJcmyY+0Lm
	 hOIwD8aynydlM45g1qBbAPT3YZIjyj6syEV4CukZ4gR71KtPz1FhnhYEkVSXtGqObP
	 DNBdR6ppN3wParfoaLUMslebFEDUAqhy+3lKYsbNTU9lkUJbWYRzSIQ/m0lm3gcmPD
	 AFRqSpO4ox+NC1wTp5lGNzIhuAjaazRIyxInkAnpv53Tf1471VzbDQKjr3kkiGls/G
	 pD33+io7YIrDClvKqTHkPUuc4zwQfZKBpGcxOcrhr8CuJEGJkXtaWNSCehnaGDgZIK
	 S4ZDt76g1VSDQ==
Date: Tue, 3 Feb 2026 17:52:13 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v3 05/11] net: phy: Create SFP phy_port before
 registering usptream
Message-ID: <aYI1zd6Iddcdt6xc@horms.kernel.org>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
 <20260201151249.642015-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201151249.642015-6-maxime.chevallier@bootlin.com>

On Sun, Feb 01, 2026 at 04:12:42PM +0100, Maxime Chevallier wrote:
> When dealing with PHY-driven SFP, we create a phy_port representing the
> SFP bus when we know we have such a bus.
> 
> We can move the port creation before registering the sfp upstream ops,
> as long as we know the SFP bus is there. This will allow passing the
> phy_port along with the upstream information to the SFP bus.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

...

> @@ -1698,22 +1700,34 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
>   */
>  static int phy_sfp_probe(struct phy_device *phydev)
>  {
> +	struct phy_port *port;
>  	struct sfp_bus *bus;
> -	int ret = 0;
> +	int ret;
>  
> -	if (phydev->mdio.dev.fwnode) {
> -		bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
> -		if (IS_ERR(bus))
> -			return PTR_ERR(bus);
> +	if (!phydev->mdio.dev.fwnode)
> +		return 0;
> +
> +	bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);
>  
> -		phydev->sfp_bus = bus;
> +	phydev->sfp_bus = bus;
>  
> -		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> -		sfp_bus_put(bus);
> +	if (bus) {
> +		port = phy_setup_sfp_port(phydev);
> +		if (IS_ERR(port)) {
> +			sfp_bus_put(bus);
> +			return PTR_ERR(port);
> +		}
>  	}
>  
> -	if (!ret && phydev->sfp_bus)
> -		ret = phy_setup_sfp_port(phydev);
> +	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> +	sfp_bus_put(bus);
> +
> +	if (ret && port) {

Hi Maxime,

If bus is NULL then port will not be set here.

Flagged by Smatch.

> +		phy_del_port(phydev, port);
> +		phy_port_destroy(port);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.49.0
> 
