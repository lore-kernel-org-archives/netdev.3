Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D93CE48E;
	Fri,  3 Apr 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233717; cv=none; b=AAlJE+P626hQTI+G58zvKOgaKomHaDup48zmhh4KNXNRhfodJBjMn1pMg5dXNShEHR0rN7sK8F+InDDJZH7hzv85/P3NZDNLr8takv6EWL8QUGgcakjZBoP5Gi13Qw9bWaHY2W9fPM5wK8BAq/4Cpiitc4JOuKZVoPYAJjq6MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233717; c=relaxed/simple;
	bh=ksFgA/u2N4SRYvgJuiBxNktrLTy17CcaLr4WBoZeuwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmOKX1eG8DqDKXO9ig0yJ1o7R/IQUq+3Fm3iTrMBNBA7Ox651zlsVZydOthBDUwzQdvoplP1JhrwSDAthFY0ZwodtVlclrhvxlDTefny9UT4Jskdrp5YXDT8vHZBFQID9+IM4j9sCAGwBpuSORn++HewQm5Z/EE74uKrdPLMd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=POwDYbpM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="POwDYbpM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hwRBDQPTngoPa9INpbm8rSrx+5HNSS1PTuzENhOG9qs=; b=POwDYbpMP11WnGNZRSng9fPF8Y
	vbPLlLvLOPz9PNL7MHvMaF0h+/q1EDiHdn0c7bPcGzZSVPfwUvn375AgIBnY1gjAOsUChiBMaPx+i
	oKdc0HS0oJTyxS4PGxcZ1zCC5hwDG0aIVUn5ksN68PEQLwiEgJPRa1HRQ+2wpQL0xXIbYkxcPSaiC
	A/+1P2jBqxV18ILhBYLl5C2GqIg1SQ068W3sUakYJW9qdIBLXscZfd2cqaHIC8ECwPPzySjTZPnZI
	QdE0F0WmdM8IUCM0Ks3yRZgHB2dWP++B+yA+8tlOCm8pE7Msvk9KyxoEnpAUR30LbN2boZ7umXY6o
	zCdWKvog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57270)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8hNd-000000005pf-1WoV;
	Fri, 03 Apr 2026 17:28:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8hNa-000000006t4-3itU;
	Fri, 03 Apr 2026 17:28:18 +0100
Date: Fri, 3 Apr 2026 17:28:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: micrel: Fix MMD register access during SPD
 in ksz9131_resume()
Message-ID: <ac_qokUkztGRLNa0@shell.armlinux.org.uk>
References: <20260403111738.37749-1-ovidiu.panait.rb@renesas.com>
 <ac_Udvtrj0Bl-6wl@shell.armlinux.org.uk>
 <TY7P301MB1984FB759690AB12AD509CD8D35EA@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY7P301MB1984FB759690AB12AD509CD8D35EA@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 03, 2026 at 03:48:02PM +0000, Ovidiu Panait wrote:
> Hi,
> 
> > 
> > On Fri, Apr 03, 2026 at 11:17:38AM +0000, Ovidiu Panait wrote:
> > > During system suspend, phy_suspend() puts the PHY into Software Power-
> > Down
> > > (SPD) by setting the BMCR_PDOWN bit in MII_BMCR. According to the
> > KSZ9131
> > > datasheet, MMD register access is restricted during SPD:
> > >
> > >   - Only access to the standard registers (0 through 31) is supported.
> > >   - Access to MMD address spaces other than MMD address space 1 is
> > >     possible if the spd_clock_gate_override bit is set.
> > >   - Access to MMD address space 1 is not possible.
> > >
> > > However, ksz9131_resume() calls ksz9131_config_rgmii_delay() before
> > > kszphy_resume() clears BMCR_PDOWN. This means MMD registers are accessed
> > > while the PHY is still in SPD, contrary to the datasheet.
> > >
> > > Additionally, on platforms where the PHY loses power during suspend
> > > (e.g. RZ/G3E), all settings from ksz9131_config_init(), not just the
> > > RGMII delays, are lost and need to be restored. When the MAC driver
> > > sets mac_managed_pm (e.g. stmmac), mdio_bus_phy_resume() is skipped,
> > > so phy_init_hw() (which calls config_init to restore all PHY settings)
> > > is never invoked during resume.
> > >
> > > Fix this by replacing the RGMII delay restoration with a call to
> > > phy_init_hw(), which takes the PHY out of SPD and performs full
> > > reinitialization.
> > >
> > > Fixes: f25a7eaa897f ("net: phy: micrel: Add ksz9131_resume()")
> > > Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > > ---
> > >  drivers/net/phy/micrel.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > > index 2aa1dedd21b8..4236dbf4ad6b 100644
> > > --- a/drivers/net/phy/micrel.c
> > > +++ b/drivers/net/phy/micrel.c
> > > @@ -6016,8 +6016,13 @@ static int lan8841_suspend(struct phy_device
> > *phydev)
> > >
> > >  static int ksz9131_resume(struct phy_device *phydev)
> > >  {
> > > -	if (phydev->suspended && phy_interface_is_rgmii(phydev))
> > > -		ksz9131_config_rgmii_delay(phydev);
> > > +	int ret;
> > > +
> > > +	if (phydev->suspended) {
> > > +		ret = phy_init_hw(phydev);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > >
> > >  	return kszphy_resume(phydev);
> > >  }
> > 
> > mdio_bus_phy_resume():
> > 
> >         ret = phy_init_hw(phydev);
> >         if (ret < 0)
> >                 return ret;
> > 
> >         ret = phy_resume(phydev);
> >         if (ret < 0)
> >                 return ret;
> > 
> > where phy_resume() calls your resume function.
> > 
> > If a MAC driver is handling suspend/resume by setting
> > phydev->mac_managed_pm then maybe the MAC driver should also be
> > issuing phy_init_hw() before calling phy_resume() ?
> > 
> > Which MAC driver are you seeing a problem with?
> > 
> 
> On my board the KSZ9131RNX PHY is paired to stmmac.
> 
> I could add phy_init_hw() before the phylink_prepare_resume() call, which
> does the phy_resume() and remove the ksz9131_config_rgmii_delay() call from
> ksz9131_resume(), as it is not correct/complete.

Yes, I think we should add phy_init_hw() before calling phy_resume()
in phylink's prepare_resume() path to ensure that the PHY state is
the same as when the PHY is resumed via the MDIO bus. Please prepare
a patch to that end, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
