Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E311DDF0;
	Fri, 25 Sep 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340246; cv=none; b=C24aZ0wQJ+mHke8KE0BpT9oCI5avT28LZlNJq2WTZApMIgAc97WN5PwBEs3gQISabY2uZYG9nivuC3R6MWaBmlEAN8PvTDc9w/KKa+kmazgBQcujlI2oFAW5Qe7VN33UVkRtYnpsOnKrKcLm4pgNgSIWWAmAZy/KWbYaCUFagtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340246; c=relaxed/simple;
	bh=XN0Gf1zvOCykiChPwISzY8g//JmTBnwFnHJOq0q3Buc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIeuqqhhDzYFm49gWFZ2vzNmXvAqV52nInw/OovRTgH+36eiTTlve/AnIOAeGu95NOSPooDKaOESkV9Qaq3PVY+KCGYn2kefgC+NHNNOT4TNv4p3j60SNH7rJvj0R1GQq5dNXjZAi0+bVagRZ/7HWhkqijybRj5XiL/AWHfF4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W6Ss2O0A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W6Ss2O0A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OHkkYwmGY8TatjNU9FZ7bLDOmRJ2GPTH7qfyHVSXguo=; b=W6Ss2O0AOsM0xBeviLYmE+NaLh
	js2qCsglwdRISHyTivMkIqbEuP/d8INQ2qabbBRpdkSaqrww/PbdWp4DuJOVnd9LW616GAgn6tHcf
	9Oe4qy4R60aYaWDzyQXxWAGAjGW5yt+y002csIw21oNg+Ffoq3uPTOUX7VBWT42fxzjY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA5HG-007CIn-NS; Fri, 25 Sep 2026 14:43:46 +0200
Date: Fri, 25 Sep 2026 14:43:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net: pcs: airoha: add support for Airoha
 AN7583 SoC
Message-ID: <8448d07f-a0eb-41d4-8d66-f6af8525c6fa@lunn.ch>
References: <20260925072712.23419-1-ansuelsmth@gmail.com>
 <12d6e310-3aa9-45f1-925e-e3c8f2f0efad@lunn.ch>
 <6ab6669c.232cdbff.15fa39.f0d3@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab6669c.232cdbff.15fa39.f0d3@mx.google.com>

On Fri, Sep 25, 2026 at 02:18:34PM +0200, Christian Marangi wrote:
> On Fri, Sep 25, 2026 at 02:07:52PM +0200, Andrew Lunn wrote:
> > > +static void an7583_pcs_setup_scu_pcie(struct airoha_pcs_priv *priv,
> > > +				      int index, phy_interface_t interface)
> > > +{
> > > +	u32 xsi_sel;
> > > +
> > > +	if (priv->phy)
> > > +		return;
> > > +
> > > +	switch (interface) {
> > > +	case PHY_INTERFACE_MODE_USXGMII:
> > > +	case PHY_INTERFACE_MODE_10GBASER:
> > > +	default:
> > > +		xsi_sel = AIROHA_SCU_PCIE_XSI1_USXGMII;
> > > +	}
> > > +
> > > +	regmap_update_bits(priv->scu, AIROHA_SCU_SSTR,
> > > +			   AIROHA_SCU_PCIE_XSI1_SEL,
> > > +			   xsi_sel);
> > 
> > I suspect the AI will be here soon. xsi_sel is initially a random
> > stack value. IF interface is something else, you use that random value
> > with regmap_update_bits().
> >
> 
> Doesn't default address that case?

Yes, maybe. But why have a switch statement at all?

	Andrew
