Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF23955D8;
	Mon,  3 Aug 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779307; cv=none; b=QB4Ia2mxElafoTfDh4eVVw+EwpCZrctHURt6oqr4dP//Y1lEUhpOygLOHwlWYXmjCGFDaj8nU8OBNf8o/g6GyRrfp4BNVVOI9+bCsuitspByZM+gel/17kVOB5qzmnvqSBzzuqQu6bUHjdTedvemIIHHoTaL/ALjo3BvhLQ6RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779307; c=relaxed/simple;
	bh=65cb7UEHUvs9af0Ej+kL97qAT27LpOyQMo8mrY/QLik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO2kGNc8vHV1ucw58dFTTopdo0OO7+N9InqvqsBoC6OH7zAZAVkcuBN8k6OusrQ7WF0XZhKucuUyBcW42Yl26MvcIAatKvXFpd9XMja4ShLLeJPvByg/ZlVpwIIl8HUKLsmVtf5DxYUB570KyqcSu8fGOVgAuOJP1FKnzJgtTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u1kXI2+R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u1kXI2+R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cSyyM7BUXIDF3kJhgyCmgOwoW98OlpC1I9i3DPZMz2s=; b=u1
	kXI2+R12w43beaPSCbM1HCJtvorD9d3Ebq53sQZR3ik4voCij2lPlW5oXM+0wRshrRMCr87mcUHo7
	XN23BeKdWZNVXSS4v3jExOreZBR9tOxH6d4xKQfMcUyCUx/18N/JTdJBnEYVUqcMnpK/q5TYssUsX
	zXFXTFEDjez0ehA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqwlg-00Fn1q-LQ; Mon, 03 Aug 2026 19:48:04 +0200
Date: Mon, 3 Aug 2026 19:48:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mfd@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
Message-ID: <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
 <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
 <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>

On Mon, Aug 03, 2026 at 10:09:01AM -0600, James Hilliard wrote:
> On Mon, Aug 3, 2026 at 7:51 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +static int
> > > +ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *control,
> > > +                            unsigned long outputs)
> > > +{
> > > +}
> >
> > > +static int
> > > +ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *control,
> > > +                             bool active_low)
> > > +{
> > > +}
> >
> > I've not looked into the details, but these look like pinmux. Does
> > this I2C device have a GPIO controller? Can these pins be used for
> > other things than LEDs? Maybe you should be implementing a GPIO and
> > pinmux driver. The Ethernet PHY driver can then just select the
> > correct pinmux configuration.
> 
> These do not appear to be GPIO or muxable pins. The AC200
> documentation describes them as three dedicated EPHY LED
> outputs: link/activity, speed, and duplex. The bits in SYS_EPHY_CTL1
> enable those output pads, while EPHY_CTL provides their shared
> polarity setting. I have not found any documented GPIO data
> registers or alternative functions for these pins.

So what i'm trying to do with both of these is make it look more like
standard Linux building blocks.

If that is not possible, i would actually put all this code into the
PHY driver. You then have a regmap property to gain access to the I2C
registers.

       Andrew

