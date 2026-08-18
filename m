Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEE343D86;
	Tue, 18 Aug 2026 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081565; cv=none; b=VnkwHKalmnT6toEJewoa3MsUBnoR8VMcCYKoONUJ+0T4AqFk2ZIsrnyrXSDCJ23l5qRK4KaFdEd473I1ytymGBoXuHQLpzkE4DqazFvbzz5gkuSWZM5utre2iWl9oC9LAFniwwFrdvrZU/ZRN2kcRcvF8jBq85Bj/trrI3dvDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081565; c=relaxed/simple;
	bh=l7FPGLHNHY3uXYd+JLdgkQ19Osu+EoRn3cY8/qQpA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk3tuviGxbEq1rIWiQyaoJ4MEDgZcXi5bAYJsWUlfNZRTqoYLwtgIdjl351xUqI2GzIrdRFBvqhmVIG7gKe4lcnUZQIoBqQZhVqAzQhQNQeJuPhfU9LISVkOH2FdOeXz7l0gnYP27oNyQ7lQhUyFOw09mxbZVO7u6HM7hqQyvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=26eqeVtj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="26eqeVtj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SG5VRjtPte6L9aJew4sPyVsnyomeyDOe/aSpZtCLGcM=; b=26eqeVtjz0wFX9cdB4ehc0LYkg
	meZxdZOYXQDI9NTVGr1JG8dTZXwlvRgUKPQx6dMCuO4NVSzJqAC8cJIgn6xlJcaPRxJLxsEGikYsc
	8Rfx+fXhjnqkeRy/Wg8ll4z7pvip4ZKBAULWVKAcDtSTVNugj0mHY8e62lLXj9qHNM50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwPXl-000WBc-7V; Tue, 18 Aug 2026 21:32:17 +0200
Date: Tue, 18 Aug 2026 21:32:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up
 C22 and C45 space in parallel
Message-ID: <789b5b28-e9af-4b8b-a674-6aafe8a16478@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-11-markus.stockhausen@gmx.de>
 <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
 <070901dd2e6d$f5b70c30$e1252490$@gmx.de>
 <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch>
 <089001dd2e83$b8957920$29c06b60$@gmx.de>
 <2fd17092-753a-4a80-bdf4-72801eca8d0a@lunn.ch>
 <08e501dd2e86$98e9fdf0$cabdf9d0$@gmx.de>
 <ecc68c5f-02cb-4249-9f09-f161cc97a989@lunn.ch>
 <073901dd2f39$4e234ac0$ea69e040$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073901dd2f39$4e234ac0$ea69e040$@gmx.de>

On Tue, Aug 18, 2026 at 07:44:58PM +0200, Markus Stockhausen wrote:
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Montag, 17. August 2026 22:32
> > An: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
> up C22 and C45 space in parallel
> > ...
> > > Until now we never encountered any of these PHYs in scope 
> > > (RTL8218x octa port) outside of the Realtek RTL83xx/RTL93xx 
> > > ecosystem.
> > 
> > Is the ID in registers 2 and 2 specific to the RTL83xx/RTL93xx ?  That
> > would make thinks simple.
> 
> There is no difference in the ID registers of the RTL8218 that
> is attached to RTL83xx/RTL93xx or to possible other SOCs.
> The RTL8218 series has a lot in common with the lower port
> designs (e.g. RTL8211). They are driven by dual QSGMII and
> can be attached to any non Realtek SOC.
> 
> If upstream rtlgen_read_mmd() is not the proper way then
> I must think about it. But that needs to wait a bit ...

I _think_ this becomes an issue when you have working C45 over C22,
but no C45. I can think of two solutions:

1. rtlgen_read_mmd() pokes around in the bus to find out if C45 is
supported, and if not, do C45 over C22.

2. When dealing with this horribly broken hardware polling, you trap
read/writes to C45 over C22 and emulate them using C45. That at least
keeps the workaround where it belongs, in the broken MDIO bus driver,
rather than the PHY driver.

	Andrew
