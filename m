Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E74DEC26;
	Wed, 30 Sep 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792450; cv=none; b=J08ZR4bOtCBUvZctfn+UJau+EBhpS6gsF/Cq1DsE3bhZ9qOMt6oeRLwAAAvV0flSXIIOIey4iQaYdlBMdmfaHgdN98lc0nLSuDXEFN9w3imoAymVi9yquGN2eyMtCtx2KWdboQYnLzdkwdwD7oKNjzD37ykNccwpjMypjFhB1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792450; c=relaxed/simple;
	bh=ezBJ+zy0e5reHdRsuZ4tpWukuZ4wZScsXD6apZTSgiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sygKdjMWgoAA1VDliT3BVTz+I+NR+SzeHvX/zYTGEe+ifMGrOG0ePn1oQTADGLS5ecpJbVPOz34mnWlJ8m3/UpRqWhrLA4OK0GFqaa+guus/9rVFV1B4HGiFXtRAzzDSmVDqeh4tASHlI5oWN4Pw5Sp4QNZZcppDm/96XIT9ph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RSbRlzBW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RSbRlzBW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mUEIu4CoGpjPxI2NwTPet4Gva46cYnBcLeV2lVdhRNg=; b=RS
	bRlzBWo3ts7fMXb0bDxyfBA06MJQ7KcTnV6jquVYnx9KJ6k7XRQXE7f4GKB9VylOC6WH527XV0Mw8
	romvFiVsEbm9mmkwiqbzYPkNw+gVqNLULJjf3O9ffh3jVfIWan0+0vA2ww0ERBfna/3607THPCe2l
	a9jMBUiwULhTA1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xByut-008DJq-1u; Wed, 30 Sep 2026 20:20:31 +0200
Date: Wed, 30 Sep 2026 20:20:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO
 controller driver
Message-ID: <26a505c2-526c-43d3-aa9a-2ba4afb39b69@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
 <e4440c27-5551-482c-95ae-9b75481bcf7b@lunn.ch>
 <2c0a9d5f183cb9537b3f89016800247bb7b673c3.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c0a9d5f183cb9537b3f89016800247bb7b673c3.camel@linutronix.de>

On Wed, Sep 30, 2026 at 07:23:38PM +0200, Vasilij Strassheim wrote:
> On Sat, 2026-09-26 at 01:10 +0200, Andrew Lunn wrote:
> > > diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> > > index 048586746026..079b46dea25f 100644
> > > --- a/drivers/net/mdio/Makefile
> > > +++ b/drivers/net/mdio/Makefile
> > > @@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
> > >  obj-$(CONFIG_MDIO_PIC64HPSC)		+= mdio-pic64hpsc.o
> > >  obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
> > >  obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
> > > +obj-$(CONFIG_MDIO_SOCE)			+= mdio-soce.o
> > >  obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
> > 
> > Maybe the indentation is wrong here?
> 
> This looks fine in code.

Sometimes happens with tabs that the patch looks wrong, but is in fact
correct.

Thanks for checking.

	Andrew
