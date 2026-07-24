Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAC3218BA;
	Fri, 24 Jul 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913531; cv=none; b=kHnW8vjzkKANzbs4kgrmM6aVQB6cm8BuUfbMB1hNwJAYFnaMHY/Tge1hAUqCPLbMUQgCiIUym9WNS2poeG0cP9BkeEARsmVFQVhzHpPwa/R//5h0LskPAPSmNucvv/01b3LFW4/7b4tSXSeM6a+n01plasWdL2jRRj/kxEdKYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913531; c=relaxed/simple;
	bh=qhFVvkIfcKnj6tkYt9iQhzHCpzV6aeY+HB04tlCILTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6ai0qjSvZ/83mssJdZzludqEW7D+S6a1O4yMz4NIXXqqukpKrs2sX4VtUIsxJxdUm9takGdSF2vGBvGvvJa0hv61Mpyd+0qFcZtbKTP01SaVPsd0PedBa6XzlH68NpIYG8/UTu8vJABVDiG5icPkp9sDGIkv3CMhnvPOJ6M+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k+/vMRgj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k+/vMRgj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AkRiKMXzjkNXosCCd/qaEIDtrpg1y9MyrKkiTtEowTs=; b=k+/vMRgjhr4sWfmzAWvE74nTtx
	mZEhaM+VoP0RQgOsLTHEopf+K4z/ZBYgBJh8y6unxM8V5N7w5t0KLpAfXeb5XQafEP5OrNbOM2wA/
	yVGad9jRqo/OhMqK68P5PfE9RRjgzAqyFg1zolxTH0BBmyAx+XWlFSnwGM1RWA48+cy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnJXl-00E1uf-Fl; Fri, 24 Jul 2026 19:18:41 +0200
Date: Fri, 24 Jul 2026 19:18:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <d4f745df-715a-45c9-88a7-337b1dffd2ac@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-13-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-13-bdde4f905883@birger-koblitz.de>

> +static int asix_ax88279_read_status(struct phy_device *phydev)
> +{

> +	val = phy_read(phydev, MII_ADVERTISE);
> +	if (val < 0)
> +		return val;
> +
> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->advertising, val & AX_ADVERTISE_2500);

This looks wrong. A PHY driver should configure the hardware to
advertise what is in phydev->advertising. The PHY driver itself should
never change this value, especially in _read_status(). It is up to
user space to decide on what is advertised, and the phylib core will
sanitise the value to ensure it is within the PHYs capabilities.

> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	int ret;
> +	u32 adv;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, adv);

Can genphy_c45_an_config_aneg() be used here?

> +static int asix_ax88279_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
> +
> +	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
> +	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;

I would do this in probe. If you do this early, phylib might be able
to call genphy_c45_pma_read_abilities() on its own. Maybe, i don't
know.

> +	/* AX88279 does not support reported 100baseT-half duplex mode */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, mask);
> +	linkmode_andnot(phydev->supported, phydev->supported, mask);

If you are only changing one bit, it is simpler to use
linkmode_set_bit()/linkmode_clear_bit()

	Andrew
