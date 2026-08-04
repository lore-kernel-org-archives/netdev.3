Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47423EF666
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809275; cv=none; b=ZKw61B0V6Q0OjTeVB21xZRFUDDSJRC2uSOejNYRX4DK/OmWym6K1csPtKyZlasTmn1BfICFbR/C72aWwb5XhBO7GS3wUuvMt+hh0yLokJfqS3kFAegIJj9pL3Q0kvVN9K/Cmj3LNu8Gu483+8VMFGU06j+QqAWAbo+HWL29Edwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809275; c=relaxed/simple;
	bh=Gwm9t4RXpl+fHzy0Th3Jy27NVDr19uPXEPuQmLJwTuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tm/8uLn0ps01pXjMcm+eLSxj6pKZmDXfjWsv9cun12WW1xOg4bfbXYVvlkF2zs1u7bUM/7glGe8Qsl5MvQFts6kl7tlxYkpXh1cim7vG0KPsYhAhcifilsxP+sD2BXb6Kh1dFy0zswFAuAMKdPfD56bwctSy8wqiaJmGZhrCrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca16PMlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca16PMlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004941F00A3A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785809272;
	bh=mhqh3Nz3FO5T9fLfc4e6l+Yx57i8XvSVRlL8MU9+QdA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=ca16PMlxzRpA6Oq/fIE1y3VavJRKMJk11tEGYT4u8JfvW/lI1YhYc0iBHFai7yAlZ
	 D1klSGP1VbJbevPvXuJ42EsiIW/znQk6Uw9wkENrtWGubwmrbqkPsAZibK//O6AMqg
	 hJiSyka3RBYKxwU5TZaV6OYUUhdr3tvk+PDJSdD5cA+WYNhqMsAbUxjcST6+7M5umB
	 ve0aQrpx6KQjQ8+iqcBIHEa8CTYwYJB8qx6v4G7XNZrrGWNUEScqmrwUsTqlHF8ARi
	 0ndcsxkrxX3NjxD+u3G4cMJ5QfXF1pv2LsdVduYPNULmUQ5BZxoaa/jy+PIDHTZkuN
	 OC6BQR3rzxQ6w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so3696220e87.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:07:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMXA+kVV2A7q18kEJaF/xoyGoYrilJ8C+q13/lNTNVhTN6snHhHtn7MeMIsRYyc6uBhyujecc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxllx7Rmy20+eWTrZJc4dZTQQxZwgKWYHHnpuRXZs11TA4tX7tM
	Qs4r4IVuicPYhtsgVRGIrhnN5tHbi+gQceU01N+caxXwKeGaeiivNVq0X4ibr2xyAjWj/QnJoAF
	XdzZTUAuxMBopzAL6/so+91MQfRuRQXk=
X-Received: by 2002:a2e:9fc6:0:b0:39b:14ba:a5da with SMTP id
 38308e7fff4ca-39f86175217mr27582561fa.13.1785809270230; Mon, 03 Aug 2026
 19:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
 <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch> <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
 <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch> <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
In-Reply-To: <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 10:07:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64U9ZQxfb7M3VfoGH60iMHL01XDy6tjs8VbFPLfyaJWgw@mail.gmail.com>
X-Gm-Features: AUfX_mwGp_0m2GBis6TyXtQmz_W7xdVls2yXgA2h06qYGgsxLQfwj2BxAwZBVtk
Message-ID: <CAGb2v64U9ZQxfb7M3VfoGH60iMHL01XDy6tjs8VbFPLfyaJWgw@mail.gmail.com>
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>, Richard Genoud <richard.genoud@bootlin.com>, 
	Maxime Ripard <mripard@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:45=E2=80=AFAM James Hilliard <james.hilliard1@gmai=
l.com> wrote:
>
> On Mon, Aug 3, 2026 at 11:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Mon, Aug 03, 2026 at 10:09:01AM -0600, James Hilliard wrote:
> > > On Mon, Aug 3, 2026 at 7:51=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > > >
> > > > > +static int
> > > > > +ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *contro=
l,
> > > > > +                            unsigned long outputs)
> > > > > +{
> > > > > +}
> > > >
> > > > > +static int
> > > > > +ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *contr=
ol,
> > > > > +                             bool active_low)
> > > > > +{
> > > > > +}
> > > >
> > > > I've not looked into the details, but these look like pinmux. Does
> > > > this I2C device have a GPIO controller? Can these pins be used for
> > > > other things than LEDs? Maybe you should be implementing a GPIO and
> > > > pinmux driver. The Ethernet PHY driver can then just select the
> > > > correct pinmux configuration.
> > >
> > > These do not appear to be GPIO or muxable pins. The AC200
> > > documentation describes them as three dedicated EPHY LED
> > > outputs: link/activity, speed, and duplex. The bits in SYS_EPHY_CTL1
> > > enable those output pads, while EPHY_CTL provides their shared
> > > polarity setting. I have not found any documented GPIO data
> > > registers or alternative functions for these pins.
> >
> > So what i'm trying to do with both of these is make it look more like
> > standard Linux building blocks.
> >
> > If that is not possible, i would actually put all this code into the
> > PHY driver. You then have a regmap property to gain access to the I2C
> > registers.
>
> I understand the goal of using standard Linux building blocks where they
> fit, but I do not think folding these control paths into the common PHY
> driver gives the right device model here.
>
> The AC200 and AC300 expose the same Clause 22 PHY interface, but their
> control functions are separate devices with different transports and
> lifetimes. The AC200 control function is an MFD child accessed through
> the parent I2C regmap. The AC300 control function is a separately
> addressed non-PHY MDIO device. A regmap reference only describes the
> AC200 transport; it does not represent the AC300 control device.
>
> Folding both implementations into the common PHY driver would make that
> driver manage AC200 MFD registers and resources as well as an AC300 MDIO
> control endpoint. That would mix the package-specific control transports
> with the otherwise common Clause 22 implementation.
>
> The current split uses standard subsystems wherever they provide a
> matching abstraction: MFD, regmap, MDIO devices, clocks, regulators,
> NVMEM, device links, and the PHY LED framework. The narrow private
> interface covers only the compound operation which those frameworks
> cannot express: calibrating, addressing, configuring, and sequencing the
> package control block before the Clause 22 interface becomes usable.
>
> The link address is an important example. It is defined once by
> phydev->mdio.addr. AC200 must program that value through its I2C control
> interface, while AC300 must validate it against the address of its MDIO
> control endpoint. Generic PHY operations do not carry a consumer MDIO
> address. Encoding it in a phys specifier or control-node property would
> duplicate the PHY node's reg value. Giving the common PHY driver a raw
> regmap avoids passing the address only by moving the provider-specific
> implementation across the driver boundary.
>
> The LED pad-enable and polarity bits are similarly part of the package
> control function. They control dedicated EPHY outputs rather than GPIOs
> or muxable pins. The common PHY driver still owns the PHY LED semantics,
> while the selected control driver performs the package-specific register
> access.
>
> For those reasons, I think keeping the transport-specific control drivers
> and the common Clause 22 PHY driver separate is the cleaner division.

I think what Andrew is saying is that you can expose the regmap from the
MFD node, which you then reference from the PHY node with a custom phandle.

In the PHY driver, the first thing to do is retrieve the syscon, and if it
is not available yet, return -EPROBE_DEFER. Then you program all the bits
you currently do, just without going through a layer of redirection.
You can fetch the PHY address to program from the device tree. The downside
to doing all the setup in the PHY driver is that the PHY node has to have
the PHY ID in the compatible, as it is no longer generic. But you already
have that.


ChenYu
