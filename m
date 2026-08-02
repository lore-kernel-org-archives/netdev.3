Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB93D567F;
	Sun,  2 Aug 2026 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707773; cv=none; b=fFm8NZ4GNE4HPuLvT6C1TibaPuCONYqNjQrYv0Le5tkghyyXDwytq7PFOsTdv2pHtPJb9Mvi/EfSQYi6k7v6coVJ71R3IQbEP6Wqv10c5UoeNBv4+arDWIdBnbhv+MCf/kAJ0VCONl0nOS23URw8tD/5AaQCQTQYIrqn/RXdz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707773; c=relaxed/simple;
	bh=q3YsoUiSXFZKh0bWraeQzAJ+vvIPgq5eUYbjbcOReXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JULulqSHGayXSNG5DDgEVbqPFClrUbdEIIJiEv/7u8oCL6YORIbDpbhHugRGgHqEo4rb7oEAEp5u3uyoRPOjpA4v78sIoamKyGEb/IMeqHXFkYk7sRRN+qiojz+3e7AlFlm8NuJ7c7U4Koe9HSUhmZCGOq/rfTsTMJaoquYEO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ZkZZuxL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ZkZZuxL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4fgkRVlA5HE4QzWghQH2bN3F7vna2ElLZB7VbkQFuBU=; b=0ZkZZuxLBHaLKNSmxuyaXgzl6h
	ogyJyC90zzUb7kqL/mhNaGticOVVtlj0ONXZryL5DER04v2znRXakPQFEdEJ8lgbRPqH+2uqTUP4V
	6H/+itEURnFf4XK6LvlHyB3rP6pLqZa1MuIphkyKWeT4p/4VBuI+UHs3YXGUKh2nW5Bk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqeA3-00FcRa-LP; Sun, 02 Aug 2026 23:55:59 +0200
Date: Sun, 2 Aug 2026 23:55:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>

> +static int asix_ax88279_read_status(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +	phydev->rate_matching = RATE_MATCH_PAUSE;
> +
> +	if (!phydev->link)
> +		return 0;
> +
> +	ret = genphy_read_master_slave(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_lpa(phydev);
> +	if (ret < 0)
> +		return ret;

This looks pretty similar to genphy_read_status(). Can you call that
here? And then the rest of the code here can deal with higher speeds.

> +	/* Read actual speed from vendor register */
> +	val = phy_read(phydev, AX_CTRL_STATUS);
> +	switch (val & AX_CTRL_STATUS_SPEED_MASK) {
> +	case AX_CTRL_STATUS_SPEED_2500:
> +		phydev->speed = SPEED_2500;
> +		break;
> +	case AX_CTRL_STATUS_SPEED_1000:
> +		phydev->speed = SPEED_1000;
> +		break;
> +	case AX_CTRL_STATUS_SPEED_100:
> +		phydev->speed = SPEED_100;
> +		break;
> +	case AX_CTRL_STATUS_SPEED_10:
> +		phydev->speed = SPEED_10;
> +	}
> +
> +	/* MDIO_AN_10GBT_STAT_LP2_5G is broken, but we can deduce that
> +	 * the link-partner advertised 2500M if remotely AN succceded
> +	 * for link speed > 1000M and we locally have a link speed of
> +	 * 2500M
> +	 */
> +	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
> +	if (val >= 0 && val & MDIO_AN_10GBT_STAT_REMOK) {
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +				 phydev->lp_advertising,
> +				 phydev->speed == SPEED_2500);
> +	}
> +	/* Only supports full duplex */
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	return 0;
> +}
> +
> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
> +{
> +	bool adv_2500;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
> +		return -EINVAL;
> +	}

Why is that? Now that phylink is driving the PHY, and reporting
speeds, duplex etc, you should have everything you need to program the
MAC when the link mode is forced.

	Andrew
