Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2E19E992;
	Tue,  7 Jul 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439541; cv=none; b=obWLYYyVOgW1f6V88TH8PWTKVcg4qhpH1gfguktsKP4C/lFR9kTmZzI5KSIs9OczEC7V90DwUPg2Tj/d0FbEccJSk7oaL1b7XK9Z+l/AaZYYqDzGTGi3+dN4tcFWQr15BWqJjZSDEoM0HFqYHJSQOt2cHzInYMUTINrsL6dtYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439541; c=relaxed/simple;
	bh=mn2695PwULigxAPZXJmQkZmHEVMELMbWQTGEzdNQaw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg/w6INcixaqijEufRL2MC0e08P9kUy8Ut3qgl588WSpg+/eLTbsyimb/plb/UN57ylfVwhpqcLN8PRPivApoZy5fe/1cLCUlWR+VKdHSb9tY7O7EpPvJcCJb261+6ZuOO5F38v/Np0m8psLRXlMAz7sqpKb2ISbY0xW5SBfDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UGIrmmcr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UGIrmmcr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3bzyZ7EjHwGyaRoVnVC0MJKRQRV90xppXyfG+tEsghk=; b=UGIrmmcrRNye4Plc5jlKCJLfOc
	d27TO81g2gunK4MmL2mQfk8rhPfYU3lFX6T98240QWTQan/ZJ/yeu2anh1wl/vr/PGrCJN2qtyVC3
	mR3rEZTCHrQD7P6tTEIf9S4x9i6kZ0QFl3bQcMLC7ItWDGcc+Z442w8bXObzp69+cAJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh85f-00BBqa-VQ; Tue, 07 Jul 2026 17:52:07 +0200
Date: Tue, 7 Jul 2026 17:52:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: reject unsupported speed/duplex
 in ksettings_set() with PHY
Message-ID: <90ef4462-d086-4c02-97af-d55a19ac03bc@lunn.ch>
References: <20260707062735.17776-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707062735.17776-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Mon, Jul 06, 2026 at 11:27:35PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> When using ethtool to change speed and duplex on a phylink-managed
> interface with a PHY attached, the requested speed/duplex combination
> is not validated against the MAC's supported capabilities before being
> passed down to the PHY layer.

How are you invoking ethtool here? And what other invocations have you
tested, with this patch in place?

> @@ -2989,6 +2989,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
>  	if (pl->phydev) {
>  		struct ethtool_link_ksettings phy_kset = *kset;
>  
> +		if (!phy_caps_lookup(kset->base.speed, kset->base.duplex,
> +				     pl->supported, true))
> +			return -EINVAL;

Are base.speed and base.duplex always set? When looking at
phy_ethtool_ksettings_set() the values are only used when base.autoneg
is false. So maybe they are not always valid?

   Andrew
