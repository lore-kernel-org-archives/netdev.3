Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD1377EC3;
	Wed, 16 Sep 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571158; cv=none; b=LppUwG2ZfsBvH2tEFowQSSuRs2QL8LRwRcsjOXW/+W5zI+WhpzadEjOizRbso5rPH3h+GHnM2tn6J8tz6/D1jfYgRQokthh/5zsH18yj7B8STJqkj6pWPhn+QgAn8cQ9OWZCCoi1dyg5DPhLfbg6IpSxp0/m/1/eyjt7DCJvEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571158; c=relaxed/simple;
	bh=zDRu1UxNQaWtyaQaGpNXH6htunvwdMBIbW0dt6nc1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heOSCrJ/RcGQbBuUqagEPiBeJ5esnWou5iwUt2CYQbfGFiGW+miCcxzALQPWsh+S+HFRAL/vjFuLfVhDpj2rj00nTpOibmoVafHn4OIwrRYPeNvjzlaxA9tIBNkuKogx9LPUEvvtnmx6f1Mmk7DD2jFQwduvf1n8I7ZzfXYaC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oN5thaAG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oN5thaAG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qlCJSKLUS9B63fmKa0acz9npjUMvdKnN6lO3guHAid8=; b=oN5thaAGSofYCg8N66dhpPqX3O
	9KVghMxg+yCffRUadxPNqKnEsvMizdKky/aQ/PcTXbC4gWjD0jUQlJKNymPjarclSRq2ZnaLCaT93
	1sgksytLC4JKdLrJbMe16FKNWf8Q1jfg6saOKLV9vfmuoILWw/295GYJFH7oVMXuImNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6rCe-005Uwr-IB; Wed, 16 Sep 2026 17:05:40 +0200
Date: Wed, 16 Sep 2026 17:05:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH net-next 2/4] net: phy: Add Allwinner AC300 EPHY driver
Message-ID: <18bb9de4-38bf-48ba-bb24-2b0564474945@lunn.ch>
References: <20260916044119.475666-1-alastair@d-silva.org>
 <20260916044119.475666-3-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916044119.475666-3-alastair@d-silva.org>

> +static int ac300_phy_config_init(struct phy_device *phydev)
> +{
> +	struct ac300_phy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	/* Write page-based EPHY transceiver and signal path optimizations */
> +	ret = phy_write(phydev, 0x1f, 0x0100); /* Switch to Page 1 */
> +	if (ret)
> +		return ret;
> +	ret = phy_write(phydev, 0x12, 0x4824); /* Disable APS */
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_write(phydev, 0x1f, 0x0200); /* Switch to Page 2 */
> +	if (ret)

Please implement .read_page and .write.page in struct phy_driver.

> +	/* Disable 802.3az EEE */
> +	ret = phy_write(phydev, 0x1f, 0x0200); /* Switch to page 2 */
> +	if (ret)
> +		return ret;

Is it broken? phy_disable_eee()?

> +	return phy_clear_bits_mmd(phydev, 0x7, 0x3c, BIT(1));

MDIO_MMD_AN, MDIO_AN_EEE_ADV.

With those magic numbers replaced with macros, i then have to ask what
is going on with EEE.

I also hope you see why magic numbers are bad and should where ever
possible be replaced to meaningful macros.

> +	/* Read calibration data from NVMEM/SID */
> +	ret = nvmem_cell_read_u16(dev, "calibration", &priv->caldata);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_warn(dev, "Failed to read EPHY calibration (%pe)\n", ERR_PTR(ret));

Take a look at dev_err_probe().

> +static int ac300_phy_match_phy_device(struct phy_device *phydev,
> +				      const struct phy_driver *phydrv)
> +{
> +	return of_device_is_compatible(phydev->mdio.dev.of_node,
> +				       "allwinner,sun50i-h618-ac300-ephy");
> +}

Why?

	Andrew
