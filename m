Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612313382CD
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817938; cv=pass; b=X/EKNabjQjj31uuwRmH29aGllz88rd9sr6IKYYIuERtH231KBcCUg9/te6Wg/qdasVO07BfzSj1UGt88RbjmyCdfTl4oA2KMlms5EBjEO9e6CK7dHuxpzJ3SEgAesQ7xthB5MLJyCWboN+9l++SW5pv0uxMThVaZjsAA+kd9F4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817938; c=relaxed/simple;
	bh=GiIFhUl7eFI3+MXUktDiqoIE9NJ1C/ZSCqWdRAOmTaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct0fjaTTm8JVjW8d/cQbPxJi0CUYBSyimyqLg3+k4OLnT1tRWSAReMvLks8KZ74mp9a6VVJhWJOuBsN1Uk1tdq8T25gIFkxqBBB4n8gYwNkhD80xBxHsGdGXg+L3nznTQgaAdio9VSp34fYr8HdD6wgbQkkW+kh24S/s7qASrbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecEDPy5i; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecEDPy5i"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf95ade656so1666209e0c.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 21:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785817935; cv=none;
        d=google.com; s=arc-20260327;
        b=gf1ktKv387RcIviDQ7mI0Te3HDNJG848nZz6zVQjBazQ1aSjKVtj9lAarluhNOBGwt
         WNcAnV50n6IOZSD0ZKhbUFPK1uf+dfYmVikfvZGPbt2WRK9OR2LqSQZ58TkM53damj1u
         bSgQlIKTDGJxnwpXF7K0P6GiMMRBWYFQ/1s3R/R31rD0OtIzJVfFzhbASoUDktOFmiG4
         fCQ4z2NW4uI+udD6Bw3klBT1Na6IKOekqtuWqaZcag2DAq3AwkP3wdD8vt6uqgZdWvuR
         BhD9ocG2Sfsr+VO6+exkNXeh5IGqz1RC1Bjnq/beq9EyIWT4eiiwNDNqOGfo5Om9pf3D
         mHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LUfG70xuwTFgcp+8i3Kan+grkhw/1qDG9gV+zT/fD6Q=;
        fh=I5KlBf6R7LEhHx5kpMqyPF7zYMiZmcCB7R0uQBcZHj8=;
        b=DjPFc7H2gtHpK2UpL2UuZbaORtM+xCFDYxE83nDJaET/Nf2mOXlXACCOOIpfaRurgF
         hAA1O14qnrgSV9n3CDDxOrxGBNmlv/LhsQi/NNYe0gRlDJ6ubha4vbgIdcZt2hXTnHsa
         DBngIPNHRXBegq1UT5xqrGGOxNLioBNi0mpYHb+bfc48ydu0uJGF0HiY495Qtr36U1Fo
         tQ/Y6kTrRoLNb+7f6durw/oCJ/96cOdC9FxxFR65Ee1kXKLjmnmu0qPaLlF/5GD6Mz4g
         o/2NuQOy6w9zvEmzBed8sD+cksNAAHv3p6Lb8aheMGOMpGxzKrafykm3c31JiVUCLBCN
         VqgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817935; x=1786422735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LUfG70xuwTFgcp+8i3Kan+grkhw/1qDG9gV+zT/fD6Q=;
        b=ecEDPy5iAhpVTwsa6wEoo8WMAvzMX7UuivammsLWC/ZJxD+SDjqioKBq7YTEAYcjbr
         8ZtkAkY3hO5GuFQ3nU2pTUA5ntC5zdzzPRxhqHA9Euk0Hjl2b749a7EvCLCWLGHfLjb7
         nAwJ0vBAqePSYZeh6nhzTCmBvK/PNoqfm7NMyby26EX+2OMjCU0mq8dSvLQpRbgRklwP
         7OhaBWVnHmaBENAh50nuu2CSRo7KBiyoryVEo8iyqHHKR0hMR5NPD6C3PUxw3O7MgBDz
         dZnI3gRMi01frserumU7GfhIsfroT450ToZ5UWPrQDF9P2kbsdH3IETDhqxLcR7f9by6
         Qc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817935; x=1786422735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUfG70xuwTFgcp+8i3Kan+grkhw/1qDG9gV+zT/fD6Q=;
        b=hByoTDtJRHYigBkdBMXi5s2TCmjUdisZFUjS7Ka623dDBcUPG2/3YIddh6ImozIn7W
         6txfkg/SryJWwJ4CgqP02ceGMbKYKf//TJckJKY2mJJIYiMaeZPZPDR3FFA+58fzDMH0
         4r7P5LldAsCzN0Kg7fdTmovatiKp27uvsdp3WT8pMw0MVPCRa3Es1VWsWwM2ihqHWWCr
         5d+BWd58ANo9+W0UMmsZenCgN5yFJBJ8MZkvQu+S38CYiTrUpY57XRqh+WtkIxaX7jrT
         mUX991wcWiNuBlD1Uq5JxF9LW9qPFho23gJQRZBddmBLLMz5UoS5/S96FWml6loCx8J1
         R0fQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRff0FNah/AdKjs+cx08Fx5u3tQHqnJuNDSFTmM/ScEXf1BGNsbzAkW/094Cbf1QuFTiTGu7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5u0kNwRvPG8NK6XEVCmYuiGuprkDpBZ4x0qkHjjy30kDUbsxO
	vqpOCY1Xb2QzK5DUxYi90TubQr5eVNlU9PP454ikt3tXTKQlEpjlMvjnK6kSihtIiwMhDvVwD1f
	hvGypOMU0IiEnj7oWHdCQ9trCEebxidY=
X-Gm-Gg: AR+sD135gG98USsxfH9KnCfuh5UM+4OrZ08Om9pqaLxFH4EM+pzW0Ks5HNDzo7/GJvK
	iZ3vbz5VQHUuf9WuJ9hscAF0ufe4omOkDgOVwiDac07mqrSahB6koo6lVmo0+XeHwNjkkz2Pej1
	VelOHaOkEDFzCbPPKHc1GcUf6omcv8c5cdH3pPe2Rw3ZKuuBbpfG1DgBmRqIly+PAKowkVKI4eD
	UObX5W1Tbl+dUyKhb72jqOeUIGC6ZkqWb21Gtnzdld3bjWImF48fnuk3PJzYXANqIgScLG3kVCV
	sjM3OS92mo7EVe51xd1kxrQFXNJemOglIiW0PTzLbc+jjC+ose9PlWvM4Jjm4O7D+AVXXaQoLBW
	35WzIlyCvLwHcf9YYtxOshsK6ULoQ1HEzA+Xmwur+c79VOV7vnTn40kv9quOganFAmQSl9cXlew
	b6gdbvYgO1n3b45ydLjK7GjKxHnDtD1064wq73
X-Received: by 2002:a05:6102:15a3:b0:738:be73:55e0 with SMTP id
 ada2fe7eead31-75b237677ffmr8262959137.12.1785817935136; Mon, 03 Aug 2026
 21:32:15 -0700 (PDT)
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
 <CAGb2v64U9ZQxfb7M3VfoGH60iMHL01XDy6tjs8VbFPLfyaJWgw@mail.gmail.com>
In-Reply-To: <CAGb2v64U9ZQxfb7M3VfoGH60iMHL01XDy6tjs8VbFPLfyaJWgw@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 22:32:04 -0600
X-Gm-Features: AUfX_mzUkHY4di871Z-oeEmg1mv3oYLeo3scVGxNss1cbpF1OmuFzb1N7ZoUB_U
Message-ID: <CADvTj4rCaL+Kf5C_Sd8-p5nJHxF8GR2i8oHFJd1Nz=egx9RcYg@mail.gmail.com>
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
To: wens@kernel.org
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

On Mon, Aug 3, 2026 at 8:07=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrote=
:
>
> On Tue, Aug 4, 2026 at 2:45=E2=80=AFAM James Hilliard <james.hilliard1@gm=
ail.com> wrote:
> >
> > On Mon, Aug 3, 2026 at 11:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Mon, Aug 03, 2026 at 10:09:01AM -0600, James Hilliard wrote:
> > > > On Mon, Aug 3, 2026 at 7:51=E2=80=AFAM Andrew Lunn <andrew@lunn.ch>=
 wrote:
> > > > >
> > > > > > +static int
> > > > > > +ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *cont=
rol,
> > > > > > +                            unsigned long outputs)
> > > > > > +{
> > > > > > +}
> > > > >
> > > > > > +static int
> > > > > > +ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *con=
trol,
> > > > > > +                             bool active_low)
> > > > > > +{
> > > > > > +}
> > > > >
> > > > > I've not looked into the details, but these look like pinmux. Doe=
s
> > > > > this I2C device have a GPIO controller? Can these pins be used fo=
r
> > > > > other things than LEDs? Maybe you should be implementing a GPIO a=
nd
> > > > > pinmux driver. The Ethernet PHY driver can then just select the
> > > > > correct pinmux configuration.
> > > >
> > > > These do not appear to be GPIO or muxable pins. The AC200
> > > > documentation describes them as three dedicated EPHY LED
> > > > outputs: link/activity, speed, and duplex. The bits in SYS_EPHY_CTL=
1
> > > > enable those output pads, while EPHY_CTL provides their shared
> > > > polarity setting. I have not found any documented GPIO data
> > > > registers or alternative functions for these pins.
> > >
> > > So what i'm trying to do with both of these is make it look more like
> > > standard Linux building blocks.
> > >
> > > If that is not possible, i would actually put all this code into the
> > > PHY driver. You then have a regmap property to gain access to the I2C
> > > registers.
> >
> > I understand the goal of using standard Linux building blocks where the=
y
> > fit, but I do not think folding these control paths into the common PHY
> > driver gives the right device model here.
> >
> > The AC200 and AC300 expose the same Clause 22 PHY interface, but their
> > control functions are separate devices with different transports and
> > lifetimes. The AC200 control function is an MFD child accessed through
> > the parent I2C regmap. The AC300 control function is a separately
> > addressed non-PHY MDIO device. A regmap reference only describes the
> > AC200 transport; it does not represent the AC300 control device.
> >
> > Folding both implementations into the common PHY driver would make that
> > driver manage AC200 MFD registers and resources as well as an AC300 MDI=
O
> > control endpoint. That would mix the package-specific control transport=
s
> > with the otherwise common Clause 22 implementation.
> >
> > The current split uses standard subsystems wherever they provide a
> > matching abstraction: MFD, regmap, MDIO devices, clocks, regulators,
> > NVMEM, device links, and the PHY LED framework. The narrow private
> > interface covers only the compound operation which those frameworks
> > cannot express: calibrating, addressing, configuring, and sequencing th=
e
> > package control block before the Clause 22 interface becomes usable.
> >
> > The link address is an important example. It is defined once by
> > phydev->mdio.addr. AC200 must program that value through its I2C contro=
l
> > interface, while AC300 must validate it against the address of its MDIO
> > control endpoint. Generic PHY operations do not carry a consumer MDIO
> > address. Encoding it in a phys specifier or control-node property would
> > duplicate the PHY node's reg value. Giving the common PHY driver a raw
> > regmap avoids passing the address only by moving the provider-specific
> > implementation across the driver boundary.
> >
> > The LED pad-enable and polarity bits are similarly part of the package
> > control function. They control dedicated EPHY outputs rather than GPIOs
> > or muxable pins. The common PHY driver still owns the PHY LED semantics=
,
> > while the selected control driver performs the package-specific registe=
r
> > access.
> >
> > For those reasons, I think keeping the transport-specific control drive=
rs
> > and the common Clause 22 PHY driver separate is the cleaner division.
>
> I think what Andrew is saying is that you can expose the regmap from the
> MFD node, which you then reference from the PHY node with a custom phandl=
e.
>
> In the PHY driver, the first thing to do is retrieve the syscon, and if i=
t
> is not available yet, return -EPROBE_DEFER. Then you program all the bits
> you currently do, just without going through a layer of redirection.
> You can fetch the PHY address to program from the device tree. The downsi=
de
> to doing all the setup in the PHY driver is that the PHY node has to have
> the PHY ID in the compatible, as it is no longer generic. But you already
> have that.

I agree that direct regmap access would be reasonable for an
AC200-only driver, but I do not think it is a good fit for the
combined AC200/AC300 case.

The proposed phandle only models AC200. AC300 has no corresponding
MFD regmap: its control block is a separate non-PHY Clause 22
endpoint, with its own clock, regulator and sequencing requirements.
Folding everything into the link-PHY driver would therefore still
require two transport-specific implementations -- raw AC200 I2C
regmap access and raw AC300 MDIO access -- plus conditional resource
acquisition and cleanup. It would remove the function-pointer calls,
but merely replace them with AC200/AC300 branches throughout the
common driver.

This also matters for boards sharing one board identity but
containing either package, as selected by SID. Fixed boards can
reference one control provider, while variant boards can reference
both and let the common link-PHY driver select exactly one. The
selected provider then owns its transport-specific resources and
lifetime. That avoids making an MDIO PHY driver directly manage an
I2C MFD function on one system and a second MDIO device on another.

The control interface is also used for more than initial probe. It
participates in suspend/resume and reset sequencing, interface-mode
changes once the MAC attaches, and package LED-pad configuration.
Consequently, exposing a raw regmap would not reduce this to a
one-time register setup; the common driver would still need
package-specific implementations of all those operations.

The PHY address should not be read from firmware again. The MDIO core
has already parsed reg, and the authoritative address is
phydev->mdio.addr. Passing that address to the selected provider
avoids duplicating or independently interpreting the firmware
description. Similarly, the forced ethernet-phy-id0044.1400
compatible is required in either design because the identification
registers are inaccessible until the package control block has been
initialized; it is not a consequence of using a separate control
driver.

Also, AC200 is an I2C MFD rather than a syscon. Exposing its regmap as
a syscon solely so another bus device can perform raw accesses would
blur the ownership of the AC200 function.

The private interface is intentionally narrow: it contains only the
operations whose implementation differs between the two packages,
while all normal Clause 22 behavior remains in one shared PHY driver.
Given the AC200-only, AC300-only and runtime-selected board
configurations, I think that separation provides a cleaner boundary
than moving both control backends into the common link-PHY driver.
