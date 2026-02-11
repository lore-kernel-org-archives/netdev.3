Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA728506F;
	Wed, 11 Feb 2026 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818692; cv=none; b=pT+Fg+rHeq9evctMF5oZmY1NmsU8wV5ls+Zmiv98VMWw3cpM7dhtLUv314FwYkqJhUH0qZxrORGC3o4gkDNMsrgISAmdTaPaKkIVKtfAtMxlACODXFs2sTv7qRWUmjBnK463iJNu4N5swFmga7wsA5n2l07erPlOzumbJyzXP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818692; c=relaxed/simple;
	bh=ci4V4Mplql2td+2kgwF8k3uogFw/73wTM4qp8mLmfVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM9y0lvmwHk8rm2OiHo2wDwQ/9W8Fi8v0KDymv9Wd6RWJIUwgvq/DKkl+XVMHHAqBPCg9JDYp/tC2xijDU8Jm4LKvuW613pwSrRan20rSYWdcUWSH5twbpjAVT62XVvbuSDa6a2DrooMi5UIfMkCS7nNq9HyvUReIM0s1CbWaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LMCufY+q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LMCufY+q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vWp1Wr5c2beu3XILkgcCVpJMZPxe2mYtoBJprwZ+MGA=; b=LMCufY+qd3Hinf0Ej834SOb3yC
	R7GqkFUt9Tldk70cJUp4yZ1eUvr+d4DxmZw4bW6F4JTmDv0CyoDSER/bS7kLv2zDGPpn7eojA+APQ
	6tx4YAxaJU87J0nSS6raW8dk0N9fuCnCsBfRMpB2xQQpxIYVRW/jhbGGmFzcV+7FWRxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vqApg-006zvq-Iw; Wed, 11 Feb 2026 15:04:44 +0100
Date: Wed, 11 Feb 2026 15:04:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Meghana Malladi <m-malladi@ti.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
Message-ID: <1e648f2c-9b21-4a0f-95a4-274a97acbbf7@lunn.ch>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <aYyDkaynWEm-WJdg@shell.armlinux.org.uk>
 <b500116b-afdc-4e5b-af4b-6c1e15116111@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b500116b-afdc-4e5b-af4b-6c1e15116111@ti.com>

On Wed, Feb 11, 2026 at 07:23:12PM +0530, Meghana Malladi wrote:
> Hi Russell,
> 
> On 2/11/26 18:56, Russell King (Oracle) wrote:
> > On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
> > > When using DP83869 in force 100Base-Tx mode, the PHY is required
> > > to have robust Auto-MDIX feature enabled from register 1Eh.
> > > Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
> > > 
> > > [1]: https://www.ti.com/lit/ds/symlink/dp83869hm.pdf
> > > Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> > > ---
> > >   drivers/net/phy/dp83869.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> > > index 1f381d7b13ff..70d759c45c6a 100644
> > > --- a/drivers/net/phy/dp83869.c
> > > +++ b/drivers/net/phy/dp83869.c
> > > @@ -110,6 +110,7 @@
> > >   /* CFG4 bits */
> > >   #define DP83869_INT_OE	BIT(7)
> > > +#define DP83869_CFG4_ENABLE_AUTO_MDIX_100FD	BIT(9)
> > >   /* OP MODE */
> > >   #define DP83869_OP_MODE_MII			BIT(5)
> > > @@ -900,6 +901,23 @@ static int dp83869_phy_reset(struct phy_device *phydev)
> > >   	return dp83869_config_init(phydev);
> > >   }
> > > +static void dp83869_link_change_notify(struct phy_device *phydev)
> > > +{
> > > +	int cfg4;
> > > +
> > > +	/* When using DP83869 in force 100Base-Tx mode, the PHY is required
> > > +	 * to have robust Auto-MDIX feature enabled
> > > +	 */
> > > +	if (phydev->autoneg == AUTONEG_DISABLE &&
> > > +	    phydev->speed == SPEED_100 &&
> > > +	    phydev->duplex == DUPLEX_FULL) {
> > > +		cfg4 = phy_read(phydev, DP83869_CFG4);
> > > +		if (cfg4 >= 0) {
> > > +			cfg4 |= DP83869_CFG4_ENABLE_AUTO_MDIX_100FD;
> > > +			phy_write(phydev, DP83869_CFG4, cfg4);
> > > +		}
> > > +	}
> > 
> > Shouldn't this kind of configuration be done via .config_aneg() ?
> > 
> 
> AFAIK, in case of fixed mode, auto-neg might not be triggered all the time.
> In the phy_ethtool_ksettings_set() function, auto-neg is initiated only if
> the PHY hasn't started. PHY drivers are new to me, please do correct me if I
> am wrong.

.config_aneg() is badly named, since it is also used for forced mode. Just check
phydev->autoneg == AUTONEG_DISABLE.

	Andrew
