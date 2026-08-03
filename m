Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F374334BB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782723; cv=pass; b=eliquu99/C5Wl+l28ubX7yjPDW1lrPFiTBMj5ZeGmabk5fxUpO21c4GDdYUoKTPwj9cuqSII12I8X92lCKlOgA5bN3CwszKGNVdmaYQLjokiK1BAiYiHRb4rXQ3C6XB/wTnVtFt8hoP4HbwhpKqgkfca6cXy/zNpjDZt/YdRWRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782723; c=relaxed/simple;
	bh=m2f7hLEA6HUqRGyrwkI9sBkGWy9QLT2mm+A3bdgIjyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/O2Uj36rsSVdrPINoFVTHe+pfooYkb8J4t1jGa8QikU9iOk1K+RY2upMMzoCCvClL76m6niC1ehFL6KEAhUo1tvaS97oqYoRLGiUXteXhnN/iFB3WWUFIOyJLeqYKzdt4ZAu2CG0sPXmFF1TtnQ8s6FFmIEySDjZPBoNZLiokk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT1FwG+x; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT1FwG+x"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfa6766cf6so2047042e0c.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785782720; cv=none;
        d=google.com; s=arc-20260327;
        b=bKgk38JdeNoudcHExY/Ye9lunYQxtvdlxL9+nQFGob08ETPwe7KL05WEbs9FtoeSme
         F+PB0RKAqmsDlDp9b1apYPwtiIDEEacGtA3dqk08T7MyIrQ4ecXJHzpR37AvZ3BNR6LI
         cDI5+uIXBKmif7Hhy6chWdcr/4lTZPzRAhSbm7J8NyKSG7iYn3WKv6UcJ/ySMPVE1y/2
         Ed/Pmf83A5l96sbE3h35QZaIILYoRFajGdTbTYe1k7iNEsuogINhrzs9Nu7dHW6Sy8By
         wTOLMdSQrdMzliz7mvV75FMJ9zudDaKnR+ZnKaYIqDL5sCOJyyWUCkta4PeQFF5A6wkM
         66XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhCHZs/g7TB5oMS7PG09o+GsecOnKpnv54KT75DfOGo=;
        fh=xXIdPKFLBI1MjViGYBn+jqkEKSxnlPLHFs6Qolm9loU=;
        b=FROBbK+2ZtM+VftFbVtF1d1qLSktw3HpbOFfgtSq6agWmkwXb2B+y10OUSvEK/YMQP
         r1/qwp0aPdrJq3EUhmGxcMBzUCQlHB2wPVuqM/2bzreEsOY5w9BeXW7jPkRDwpmQgRBt
         Y+qiuynR8YWZU5EZLurnWwwzoWxe9nKtYnraMLf6dLvqsQViJRd+PNuac/OJZ7E7RTaA
         Tp3jpLmWUZGTA4sEVsO3f1R8ondJge8xEGqcpRPfMqzAVjF0PS4zk8IyS4ORylQTAVsW
         JFRNQL0GCEcYNGNdShjZh0SUiIsWdsxNvKsGS2nEnrQ5n7TXuNJyost/ZqiIma3zCz5D
         bSpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782720; x=1786387520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lhCHZs/g7TB5oMS7PG09o+GsecOnKpnv54KT75DfOGo=;
        b=XT1FwG+x4c32drXubKav55DlmMm4WM2L2JfdP41qYfrgkotDtaNU0mCDsGGbS0KlVW
         oeUQHm+BQTUS6P9vL2sdNosBWmY0kUddgkcXUN9UPuyoxIshlc1p5YWs/1j2xgP6bgcT
         lxcEKp49RTR2teIZUsU6fcZXhfX/47VYXI8jw4md6dwqU6m4Ouk9mRpNe7VkL8NqTibc
         X/BcHLfPCNy5irYP/gBD1QjJvkDS342flrdiOaBtaV2jicuISfg+dXlzcjfDs2asv0wc
         E9afExLz98jElPOHJWBx6+sHBaQRPK43518Zmra6j7OFYSZN3XGPAPtlB5zrjUDCIvqL
         bbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782720; x=1786387520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhCHZs/g7TB5oMS7PG09o+GsecOnKpnv54KT75DfOGo=;
        b=tMmOeO9l9CptBhnbbQ3et0nrJdz81h0DLm/UONbFSwtlAPL1c70d602kMgXSQpKCK0
         Dj+SeLKDzkArUTXOFReL1KaXRjK/yg61anVL+4gF3wrWvOyNtDSVgfAU7B7LElPf2IAT
         X/UHC43LoiL8/P2zC2Uob70DxW9eFmKlz0P5FNgEYGtYMcrG9OTVmtbQCKDKCz2kwbAy
         9hwLNyD0wqwSUAUAx5nqhCnZ2OWRx5HTVBhfJUo6yXJma8nWlAgyqAy5CW4yd8DcFPEj
         ppcSwXWalWQ+fRgiAy+w82R6X6R2DLm6h/oHIWjhyjz8alclpvWLAQkoaE8c1e1dXT3/
         /YFA==
X-Forwarded-Encrypted: i=1; AHgh+RoxE5El6EPRfAZ/6mZ0fovOEjBAt9JzhDx+P2p/xZ/2ba9E1BYeSrTXiP3bML4WzN03cuzFpQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4vmQNUMUVYJHIcoEPp+AV+YEWfdCs+yfvON9GOJ8M/NX5cw+
	14q78EPycd48FDpM+W8cZA06om37w2PrUYEbToBJhmrHuRAnQyQhafKs1qnABjVy6pkWA80ZJoq
	FOKEAvh02m9RzNC+QVgUzG3KumRHFI8U=
X-Gm-Gg: AR+sD13lU3IE7NpD4ZVibuESMVLcCL10hFX9wMj2aXOdS56wOMI8DY3H494bAuAGjNg
	HgtgZBKETRUfFpjd1m7FOVNt0Bi2lbs+lQyPojWVJiOuZMSAOiDwo3bSVoeQDfJLc7EIPS/x1o8
	FjhNzjt7dOgNy5vQGU5dZ1WNLD4ifDNdU2UZdmWfqfR6N5lX7P8pALTvNBFIqgFYWNLvMasLkSw
	5/p2Z7l+vIItuoe+Jw8j8Dl/wLThZsd1jQZA7achPyyjA6NBVpwlnsuAslAHGOSkCMfgnWcsMqL
	ZnoTrsmjL+CpjVKV+F5/akGy3WlGZY9vAJT4IuwLyqTlvuK6m82s/Kgaugz1OTGrIRm2lEfAtRW
	EfwmYkHYIja8XbSdomdJh8jFnMGB1Z+dBJrgm+QYX9+JyH7Eu40GY9eiqGIJVi39d8IBM/+0Uh8
	xDMbD4cZI4T7rox/tx6BsagUGuTbLAyegb3tay
X-Received: by 2002:a05:6102:fa5:b0:74a:b492:3a62 with SMTP id
 ada2fe7eead31-75b21e6b74emr8853495137.4.1785782720194; Mon, 03 Aug 2026
 11:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
 <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch> <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
 <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch>
In-Reply-To: <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 12:45:07 -0600
X-Gm-Features: AUfX_mxrC1O9cxNBLhvxxOGulQcP38PJEIX9XeOzWBEdBf_aYCt8UZQ5evY-RxY
Message-ID: <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 03, 2026 at 10:09:01AM -0600, James Hilliard wrote:
> > On Mon, Aug 3, 2026 at 7:51=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > +static int
> > > > +ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *control,
> > > > +                            unsigned long outputs)
> > > > +{
> > > > +}
> > >
> > > > +static int
> > > > +ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *control=
,
> > > > +                             bool active_low)
> > > > +{
> > > > +}
> > >
> > > I've not looked into the details, but these look like pinmux. Does
> > > this I2C device have a GPIO controller? Can these pins be used for
> > > other things than LEDs? Maybe you should be implementing a GPIO and
> > > pinmux driver. The Ethernet PHY driver can then just select the
> > > correct pinmux configuration.
> >
> > These do not appear to be GPIO or muxable pins. The AC200
> > documentation describes them as three dedicated EPHY LED
> > outputs: link/activity, speed, and duplex. The bits in SYS_EPHY_CTL1
> > enable those output pads, while EPHY_CTL provides their shared
> > polarity setting. I have not found any documented GPIO data
> > registers or alternative functions for these pins.
>
> So what i'm trying to do with both of these is make it look more like
> standard Linux building blocks.
>
> If that is not possible, i would actually put all this code into the
> PHY driver. You then have a regmap property to gain access to the I2C
> registers.

I understand the goal of using standard Linux building blocks where they
fit, but I do not think folding these control paths into the common PHY
driver gives the right device model here.

The AC200 and AC300 expose the same Clause 22 PHY interface, but their
control functions are separate devices with different transports and
lifetimes. The AC200 control function is an MFD child accessed through
the parent I2C regmap. The AC300 control function is a separately
addressed non-PHY MDIO device. A regmap reference only describes the
AC200 transport; it does not represent the AC300 control device.

Folding both implementations into the common PHY driver would make that
driver manage AC200 MFD registers and resources as well as an AC300 MDIO
control endpoint. That would mix the package-specific control transports
with the otherwise common Clause 22 implementation.

The current split uses standard subsystems wherever they provide a
matching abstraction: MFD, regmap, MDIO devices, clocks, regulators,
NVMEM, device links, and the PHY LED framework. The narrow private
interface covers only the compound operation which those frameworks
cannot express: calibrating, addressing, configuring, and sequencing the
package control block before the Clause 22 interface becomes usable.

The link address is an important example. It is defined once by
phydev->mdio.addr. AC200 must program that value through its I2C control
interface, while AC300 must validate it against the address of its MDIO
control endpoint. Generic PHY operations do not carry a consumer MDIO
address. Encoding it in a phys specifier or control-node property would
duplicate the PHY node's reg value. Giving the common PHY driver a raw
regmap avoids passing the address only by moving the provider-specific
implementation across the driver boundary.

The LED pad-enable and polarity bits are similarly part of the package
control function. They control dedicated EPHY outputs rather than GPIOs
or muxable pins. The common PHY driver still owns the PHY LED semantics,
while the selected control driver performs the package-specific register
access.

For those reasons, I think keeping the transport-specific control drivers
and the common Clause 22 PHY driver separate is the cleaner division.

>
>        Andrew
>
