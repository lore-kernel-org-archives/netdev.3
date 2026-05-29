Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDD79CD;
	Fri, 29 May 2026 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015904; cv=none; b=fNSLEvcIUy1g/R9oBcm9JL9mH24L51y0uKFrAXDLSrKIMhHOBDEEeEe9jD3rzfQKqDXZoMIiDAzWxNZkskqTGP+5+MVC02izzVoKpUQsfP1F8sPNjfyVXhAmr0n6/PczHypP0Z6eE8X88hisXgOqRlLXyGZ91MSTUt54QIFt6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015904; c=relaxed/simple;
	bh=pqGznRDDc3omJ40yALvmqPIEbnUdvvyzX1TVjROK0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgQNuA/R8fZB2Lm8/PiirxfCLS0IjrAAY7xCbXUPbQoEYSoLLvYepbleuaoCRsLouZ+dLaw+mtvpvZZ/ZErOYh/TJoIuBcRHWOHk2BmhI6RQBE6vA424SEuQdYz05M1pkKYMvsp8RwB4fzqCf750DD6K3mSVjN2zwEiQxal1EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BXoHHZR8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BXoHHZR8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+DX002j6ba3TvwnVATaqftlAgb2V/+wJtHCukoyYYic=; b=BXoHHZR8GZpRDIvWXyftKf2mee
	UB59tCgi/7FHpO/ZaiQRO1deCTTJ4ypBOw9r/1cQVPIGjQC6eYJ517NsjDrbAj5K1t194ezqUjNJD
	ixCJECitdp3HLwceryznbQlRI3usOgXVvbL4Dr9dpw9yV38KYnDjUXhU7hXppVjoLL78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlRh-004zFF-IJ; Fri, 29 May 2026 02:51:29 +0200
Date: Fri, 29 May 2026 02:51:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Message-ID: <048a1319-f3c6-487f-901b-f303c7d40a1b@lunn.ch>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
 <d37ead5b1f9549d4903138cc4f70ffd0@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37ead5b1f9549d4903138cc4f70ffd0@tipi-net.de>

> > +static int rtl8261x_config_master_slave(struct phy_device *phydev)
> > +{
> > +	u16 val;
> > +	/*
> > +	 * Configure bits 15:14 of MMD 7.0x0020
> > +	 *
> > +	 * Bit 15 (Enable) | Bit 14 (Value) | Mode
> > +	 * ----------------|----------------|-------------
> > +	 *       0         |       0        | Auto (disabled)
> > +	 *       1         |       0        | Force Slave
> > +	 *       1         |       1        | Force Master
> > +	 */
> > +	switch (phydev->master_slave_set) {
> > +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> > +		val = RTL8261X_MS_MASTER;
> > +		break;
> > +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> > +		val = RTL8261X_MS_SLAVE;
> > +		break;
> > +	case MASTER_SLAVE_CFG_UNKNOWN:
> > +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> > +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> > +	default:
> > +		val = RTL8261X_MS_AUTO;
> > +		break;
> > +	}
> > +
> > +	return phy_modify_mmd(phydev, MDIO_MMD_AN, RTL8261X_MULTIG_CTRL,
> > +			      RTL8261X_MASTER_SLAVE_MASK, val);
> > +}
> 
> RTL8261X_MULTIG_CTRL is a IEEE-defined register, so it can use
> MDIO_AN_10GBT_CTRL instead.
> Also the define for RTL8261X_MULTIG_CTRL can be dropped.
> 
> While at it I would suggest to add MDIO_AN_10GBT_CTRL_MS_ENABLE (bit 15) and
> MDIO_AN_10GBT_CTRL_MS_VALUE (bit 14) to include/uapi/linux/mdio.h and also
> make use of it.
> RTL8261X_MS_AUTO would become

If this is all just standard 802.3, the function should be added to
phy-c45.c, so it can be used by any PHY driver.

	Andrew
