Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD511D9A5F;
	Sun,  2 Aug 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785681605; cv=none; b=EHhLux2pb8kXiY2xI8Zu+Nd/vI93zMnypNoV3RkeZ9kW4Ds/hlxI59J+MRXX8E/agu+4y5Pl4K/1XSvL3XSzXqSAk9N815+ghHCyBOomxnToyXhrng7rRAc0+wJswpWfj93j4vV3KfYdPJfqDk7+3SQlLwB8ExZyrdVPhYXCW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785681605; c=relaxed/simple;
	bh=lBypRljVkeXbZ+ijCa8JQDEKfwENg0tAQYeDOy7ouH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdVl6OoP76xc73j1zq+xszczJpMCoYmCLr8UsK9PoSjD+2qF/Od84aShumQwG8kp8eIxsPwY7cyrHB8geNvhgIo2S4K9jO4u3pSfEnjRVJkFzNaPA14W0V1b2VrzG8Zf7O068o8/urC79utSDse9OzsgHsJJnM+ZnThozGCNbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N0oUJcTD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N0oUJcTD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O9/czP7ioI9JHcEbksjmAMrCOj4f1C2Czk3C5v8LVJ0=; b=N0oUJcTDIX+KIOvluhlbWZ6tmp
	36M5J+rTREuYz0/Q77XiMrfHby3pWmr1FZ75bT4DWzB5IkTrB8qgheB3gtsOiBAJkfktCnl/UcJr5
	5c6EKEHVbEKV2bnS0tuEmgvdXm1Ary4bWf3/x8Wrs7CuoCu6X4U189WWnRg7pEejPXJg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqXLu-00Fa2t-7Z; Sun, 02 Aug 2026 16:39:46 +0200
Date: Sun, 2 Aug 2026 16:39:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
Message-ID: <302c67b0-6729-4930-a409-a2408dde33fc@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-9-coiaprant@gmail.com>
 <23d8e994-8552-466f-98e6-c47d5783525b@lunn.ch>
 <CALj3r0i5yVcJY8V75y0Hm5xjtZSBpH0DXSAWKsAUqguChVcxYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0i5yVcJY8V75y0Hm5xjtZSBpH0DXSAWKsAUqguChVcxYA@mail.gmail.com>

On Sun, Aug 02, 2026 at 11:20:27AM +0800, Coia Prant wrote:
> > On Sat, Aug 01, 2026 at 10:22:31PM +0800, Coia Prant wrote:
> > > The XPCS block contains four MII ports (0..3), each of which can be
> > > routed to GMAC0 or GMAC1 via the pcs-handle property in the MAC node.
> > > The hardware maps these ports to different MMDs:
> > >   - port 0: MMD 7 (ROCKCHIP_MMD_MII)
> > >   - port 1: MMD 2 (ROCKCHIP_MMD_MII1)
> > >   - port 2: MMD 3 (ROCKCHIP_MMD_MII2)
> > >   - port 3: MMD 4 (ROCKCHIP_MMD_MII3)
> >
> > Why is port 0 called ROCKCHIP_MMD_MII not ROCKCHIP_MMD_MII0 ?
> 
> Hi Andrew,
> 
> The naming follows the Rockchip TRM. The hardware documentation refers to
> the MMD for the first port as simply "MII" without a numeric suffix, while
> the other ports are named "MII1", "MII2", "MII3". I kept the naming
> consistent with the TRM to make it easier to cross-reference.
> 
> As I understand it, this is probably because the MII controls not only
> Port 0, but
> also the entire PCS (these registers are read-only in Ports 1-3 and reflected
> back to the MII).
> 
> If you prefer, I can rename it to ROCKCHIP_MMD_MII0 for consistency. Let me
> know and I'll update it in v3.

If the TRM gives it this name, then O.K. It just makes the code look
odd, unbalanced.

> > > +static int xpcs_rk_read_c22(struct mii_bus *bus, int addr, int reg)
> > > +{
> > > +     struct dw_xpcs_rk *pxpcs = bus->priv;
> > > +     int dev;
> > > +
> > > +     if (!xpcs_rk_mdio_addr_validate(addr))
> > > +             return -ENODEV;
> > > +
> > > +     dev = xpcs_rk_mdio_read_remapping(addr, MDIO_MMD_VEND2, reg);
> >
> > Does this mean C22 registers are mapped into the first 32 of C45
> > MDIO_MMD_VEND2?
> 
> Yes, exactly. The C22 register space (reg 0-31) is mapped into the first
> 32 registers of the VEND2 MMD (MMD 7). This is how the hardware is designed
> and matches the standard C22 to C45 address mapping.

Does the xpcs code actually perform any C22 access? A quick look
suggests it is C45 only. xpcs_read() calls mdiodev_c45_read(). If C22
is not needed, i would not provide these functions.

> 
> >
> > > +static int xpcs_rk_read_c45(struct mii_bus *bus, int addr, int dev, int reg)
> > > +{
> > > +     struct dw_xpcs_rk *pxpcs = bus->priv;
> > > +
> > > +     if (!xpcs_rk_mdio_addr_validate(addr))
> > > +             return -ENODEV;
> > > +
> > > +     dev = xpcs_rk_mdio_read_remapping(addr, dev, reg);
> >
> > Should it be returning an error for dev == MDIO_MMD_VEND2? Or at least
> > if reg < 32?
> 
> No, we cannot simply return an error here.

Thanks for the explanation.

       Andrew
