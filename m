Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67D550DAA;
	Wed,  9 Sep 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956152; cv=none; b=MPIhznYB7z2V/WDG2GzuDaNVTnKK8mUNTZ5HNdj+Ie4L25ZxR1h1e1VZrigRPT7LCQQQa6+yMxk38TowRpG5buObPJQATRbPDokk9EpoTdCqaPouDeBX4Ci8o0lYgaWMSJL43gvIS+fcMVjj5jKS4/0WMnWPO2Amx0xYtRUuYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956152; c=relaxed/simple;
	bh=0yBz+vfmQAjsLLbc02fzl1rM5uTCPEj8y4eisX4Nb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uisFMtVzwEwvj6DFGhXI3oRQkjG+wy2OZSUmhR5UIKVjZPMdQ0dPBXNFQn78S5yxuT5niIMTDy8TdA0c5lFx6+Ru8dGAyCvAPdiEf85zHAdcYVv74RZJGY69py9A653KS/Ddvn0S8uvCsSISdDIhWZ14/o1Pa7VdbyBY//A8GlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f5LZqLGX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f5LZqLGX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4lNSvoiSu1Oe1KDHuQCmg5IrjKq5LQk9MUhqhzpAfU4=; b=f5LZqLGXXvOEfc7SKxBaSnFYWD
	8fUD+sruRwzKwhivGLkdPumNJZ49A+elVNBoeoVfknIU5fxLVw+cySda5scTERn+RkCUjJZFAt633
	bsKj28ZCaQbvA4EfO1g/aME7vjZodZFgknm8J2mJE5kUOlS7dvvh3w5GPxdfaD0ysQnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4HCs-004CRj-Ki; Wed, 09 Sep 2026 14:15:14 +0200
Date: Wed, 9 Sep 2026 14:15:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yury Norov <yury.norov@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Message-ID: <3fcc6c7e-a9c6-46c4-8393-1abe7d12dea6@lunn.ch>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
 <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
 <aqAnd1gpXne2lqCT@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqAnd1gpXne2lqCT@yury>

On Tue, Sep 08, 2026 at 11:19:19AM -0400, Yury Norov wrote:
> On Tue, Sep 08, 2026 at 03:52:09PM +0200, Andrew Lunn wrote:
> > > -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> > > -	if (linkmode_empty(sfp_support)) {
> > > +	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
> > >  		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");
> > 
> > From a readability perspective, i like linkmode_empty(). It is more
> > obvious than !linkmode_and().
> 
> OK, a function returning 2 values is not something obvious in C. What
> about this?
> 
>         
> 	sfp_supported = linkmode_and(sfp_support, port->supported, caps->link_modes);
>         if (!sfp_supported)
> 		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");

Why not keep it as it is? If the link mode is empty, we know we have a
problem. 


> 
> > None of this code is in the hot path. So we should put readability
> > above performance. 
> > 
> > >  	/* Some PHYs may advertise, by default, not support EEE modes. So,
> > >  	 * we need to clean them. In addition remove all disabled EEE modes.
> > >  	 */
> > > -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> > > -		     phydev->advertising_eee);
> > > -	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
> > > -			phydev->eee_disabled_modes);
> > > -
> > >  	/* There is no "enabled" flag. If PHY is advertising, assume it is
> > >  	 * kind of enabled.
> > >  	 */
> > > -	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
> > > +	phydev->eee_cfg.eee_enabled =
> > > +		linkmode_and_andnot(phydev->advertising_eee,
> > > +				    phydev->advertising_eee,
> > > +				    phydev->supported_eee,
> > > +				    phydev->eee_disabled_modes);
> > 
> > So, which is more readable, the original or this?
> 
> The new version is more readable to me. What about this:
>         
>         eee_advertised = linkmode_and_andnot(phydev->advertising_eee,
> 	                                     phydev->advertising_eee,
>                                              phydev->supported_eee,
> 		                             phydev->eee_disabled_modes);

I still prefer the original version.

Where do you stop with these functions? Why not add
linkmode_and_andnot_or()?  linkmode_and_nand_xor_nor()?

If complex expressions were used on the fast path, every packet
needing some bitmap logic, i can see the benefit of such complex
functions, if they can be optimised. But this is slow path, probe
time, or when the link goes up. Human readability comes first.

Just out of interest, did you look at the disassembly for both
versions? Isn't it the inline linkmode_ wrapper function which drops
the return value, which you are adding back. But the
compiler/optimizer sees it and could make use of it? Is gcc/clang
clever enough to do that?

	Andrew
