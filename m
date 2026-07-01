Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F934A3AB;
	Wed,  1 Jul 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916380; cv=none; b=uklO0VR0NcYVLQ7O+l4hfm5M3uaFoFbZJ5Gb6Ct6nX+c/L2JhgCyfQ3wn8G3M2vRnz0XrojDvvTC8Ht1GMm+s9B+tDS6ZN+67w/SdxY9Eu26wo18FzSS27DJLhk240dezC+cmICchquACUv3A7UIBDO1QbYmgYYPz6Ra7sWn/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916380; c=relaxed/simple;
	bh=iwW0yaAypSyo6hwff9OUVhDwHVYyHZ51Ck+6K7RqP68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPUMyf/EFOgL2YD7QqO5Mpph4i7otDKLmyFBFZQruLG27xzfj4ugGGiOX/09a4t714CTgORRteCDjgcBmhP3hWxe0z68ZRFj+Fg+SrwZAed1zIB30ON64Oq8y9R+096IqsjN2oRtzFCWeSEQVbozd4H9IdMu7+jiLp1GTYw1kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=imXC22Hj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="imXC22Hj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DSlKJeVPx0TZyfKvWqzdvEvnU87xuN/vChHfrWxBrfs=; b=imXC22HjhlOkc9h4b18XVYlGGW
	O4dhAyf+be6Xme2EZyOOcVPmU8/NlC6Hz2MXsL3viBKs19fkysVtCab9ZvJLpYynNorsE0btcBHHW
	SRZQzOATxGtiywnlc+EmaenzaDoGf+Z1nfquitPstqZd5w+fzj5At043GykggATUg7t4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wevzV-00ABKo-CO; Wed, 01 Jul 2026 16:32:41 +0200
Date: Wed, 1 Jul 2026 16:32:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Clark Wang <xiaoning.wang@nxp.com>
Cc: Breno Leitao <leitao@debian.org>,
	"Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>,
	"Frank.Sae@motor-comm.com" <Frank.Sae@motor-comm.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Message-ID: <677882ca-16cb-4fd7-86d9-b00d62147bf9@lunn.ch>
References: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
 <akTLmyF0r70Jyn9m@gmail.com>
 <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>

On Wed, Jul 01, 2026 at 08:16:13AM +0000, Clark Wang wrote:
> > > In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> > > driver uses phydrv->features. Drivers that implement .get_features are
> > > responsible for reading the EEE abilities themselves.
> > >
> > > yt8521_get_features() does not do this, so phydev->supported_eee stays
> > > empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> > > not supported", even though the PHY has the standard EEE capability
> > > registers.
> > >
> > > Call genphy_c45_read_eee_abilities() at the end of
> > > yt8521_get_features() to populate supported_eee.
> > >
> > > Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521
> > > gigabit ethernet phy")
> > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > ---
> > >  drivers/net/phy/motorcomm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/phy/motorcomm.c
> > b/drivers/net/phy/motorcomm.c
> > > index b49897500a59..46efa3406841 100644
> > > --- a/drivers/net/phy/motorcomm.c
> > > +++ b/drivers/net/phy/motorcomm.c
> > > @@ -2439,6 +2439,9 @@ static int yt8521_get_features(struct phy_device
> > *phydev)
> > >  		/* add fiber's features to phydev->supported */
> > >  		yt8521_prepare_fiber_features(phydev, phydev->supported);
> > >  	}
> > > +
> > > +	genphy_c45_read_eee_abilities(phydev);
> > 
> > Don't you want to return error if genphy_c45_read_eee_abilities() fails?
> 
> EEE is an optional functionality, and the call in genphy_read_abilities() has the following comment. Therefore, I do not return its error here either.
> "
> 	/* This is optional functionality. If not supported, we may get an error
> 	 * which should be ignored.
> 	 */
> "

This conversation then raises the question, should this be a void
function?

	Andrew

