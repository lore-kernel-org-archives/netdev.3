Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D57345CA1
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773356; cv=pass; b=AWoAyE5w4LWdEhG0geLPNtB/zcPHbkElu31AQb5C703bzZawhO4MXm46lj+Q90h/HfZlTsExKnJkcb/+WyJJ6IXm7Q3m8RVnAV4b3rDu1uYn3CN9VMqm8PK77+iTxZP1WQSQDycOX7sLJwySeWwIEm5ViTveHpmLfYxYWLOxQak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773356; c=relaxed/simple;
	bh=WkleEX41KDLCmTlkLZWoFZUTVoGZM+SKri5I4gXE6so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acMQ2/1Q0ga0IMoI9Pt1b+x512texww8J/bgBqeEh3yWS2HNcJLi6HZFGTCbNshmr+8Y5PsKOI/GKLZeFu9Rj5Ka9ej/vlaF5gqyZWB5ZkpCw1vpcKHpgKGmz/3izGdq/jYpRfhXtLzIomYCzsnQaF/+Dx6p9bOwZbdZdfAI2EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6sr13ph; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6sr13ph"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-74ab6c88052so1150493137.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785773354; cv=none;
        d=google.com; s=arc-20260327;
        b=nTw/Tnh4cjrGwf3Qp+RS8KFI/zVLBQ6/Cwrt+9jGR+ajXGzc20kzQoFaG82uf13QhE
         XNjU3h2o1kJN0TAxwnCgn0EvFrjarw/RQixfPBzpJq5kd639hri3EzM5U6VBLRYT0fL+
         XijRroQ5Hd3aGeMmN5DJ03AxWkYZZsufB9+VgZ0iWiBl2HpGcRZ8r1v5i390kA5czB8y
         pIn/IAHeEMmcWiat0EwpDXCmFSxjB0o8EeCVlp8SLNBCJSylw6Z3X5RibMLhwKvqA71E
         thn+r9k8KCnBGVcmNX1vuuuXxK7Xk3gMUooMX2hTqeOXJLOfpeV7IDCk+9yE2fTbIVmK
         7EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kPUuUdXNlj9HGEt2H/gq9i9+yKMP/RfrBRw+r1bpfmE=;
        fh=J1adolm2ObY5jwVjycIYR0+K5fzRt2NnIscY8CnDyfI=;
        b=FHHx5QX/O3pLxeCchDGqo9EA/E2MP6wLW0Whs4IsiokT6SOF9cQYXR+JsCxeRgj09i
         7vB35Yf24UDVBMljBXB+pYjjdJRBjXu+Wq82IhNy5O8eMIA/H4YEdgZQXyf40gBN4nu1
         OW+ojjGqHGNrN+OiwJMNgujIfoaGDMf09E7FhSRgs4dPn4ZmSjtpV8RSfhPAoojHo0v+
         8kOtNQQM9C3y+LK0GV+la/uu3wKqJBq2EegBEgie0C9v/wmIa3e3FvrwA4qZszpUB3za
         s7lDKX6BvB3yYigswJaEKMnbMLoiqAn92L2mXOycS+PrHzlxGSmgI/kNlwxLOj1123k2
         2rCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785773354; x=1786378154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kPUuUdXNlj9HGEt2H/gq9i9+yKMP/RfrBRw+r1bpfmE=;
        b=R6sr13phygwg8sm4AgcW/fH3c9JPj5LLySV4hsZjUglHapiB8edOJHzLXh3YrVMV07
         pWw9I2WDMlGvDN2EHiDUp7NEhqTKFn0HMZR4+6Lgm0z49UM2MTd3CHsk3sOp25lpI/dC
         wYQtVcr1VH2SX8EwM/oNYlvSPmtWLef6SfakCVllq2Jy133EpHbS/UO9AfczCD4W8ime
         E0kDhxNWkz8PXx6Ds790P+LR9oKuoTx65JlmT8JrZ8ARJsqrU5Iy90f/sGvwnQIlBiW2
         myqHA1yurRQblMHLOdXW26XZQynCIMYaBICyyXyrsqH3zfvp0bq6LxbSlGNozc+Uypum
         V9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773354; x=1786378154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPUuUdXNlj9HGEt2H/gq9i9+yKMP/RfrBRw+r1bpfmE=;
        b=Hg2AwFDjwYVRqjs9uEo2RA7NtrfFdJtxHaojiOKplv1eZx2/wodoyiroiEoZSwsvmA
         UdA7PwcCY3JaAfOCcYHS05UpkndNYbjUKsREALQaZXw621Wkva6tyUMTR/qiWR8f6FPP
         PXWOEIDJH4oTJxx8OMIxv0OPh6W1Af6JZqj8/AdiaZZD6Fh8xEL4GZ78gid03U1eOxWi
         mrEzlfedwTilFRc8PhnC7i99N19ryTrT+waIz2fmEO/pVv1WypxNgWzTl9kbTZGL1Xfc
         3phRiTYUFraoX8GejvUujHTvgXKOpgizZEHBb+lukpkWlnE6+awGYsPZhM/fNFto6BJB
         XcAw==
X-Forwarded-Encrypted: i=1; AHgh+Rrbb8VbzzINcMlCGuMRaWxjWKS6tekbgR68rEnQ2uO2dSC4ZUIX1bXAbXRS6rVVySyf6agsdfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6IljPqX+SUaNU7mqLlEEE3H2x3ZI2pXD0+IHgjYZSvAQqO9m
	tpPkkxRPnSKY5mD+S1AioC5NN9k7j1b7D35hIe8FKDCDFGraii4LbLB3+duTNxD4NAeCPxjS/mk
	w8eb+HNWIqVdYEKAsfwsOxsbbnT4trNQ=
X-Gm-Gg: AR+sD13QGYln1bNo5EhStiVvUBMWGj3Jtxg0hgYTnKnLJ/6p8dbaxSAMZPn9F3nprVU
	0UAmr/gIwGjmvb21ZFvUsbEbuB0TLA9QYZOwerjVi3k2OG2Zd1zFLNrgQc6YwJy86P6Xbm0GnC3
	DfjDI4CJvfSJp/pcWIB7VaHW4eJtItyQ3Y5Edz2aDdZyuoz013h5nttR0hrCpSw+hXUbpoEoFkH
	AnVMNr+hTMyECU304l55MRmZhtnLEJTOgdwtLUfTv+wF9JIKGP2H5Fv4ClHGCQWg7Y/C+G+qOJu
	D5Ibsqp/BdPRyHn2V7RE2WfpbDN5hBftHe9atUmjPgTeaunJiTQdujr5T17OLN/c7Z1Q7U6Uw9R
	kghTblJMRVlTxRv/6ODIHjl4+DJhgTC6lVNs4LKDkzFS9k12RJmM7dmlcZs7vUmqSCB2XVlSXRz
	bWWiyoyRzhAR4KE1v/rn6eUaaOgdXPHYBhR+Zy
X-Received: by 2002:a05:6102:15a3:b0:738:be73:55e0 with SMTP id
 ada2fe7eead31-75b237677ffmr7059647137.12.1785773353603; Mon, 03 Aug 2026
 09:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com> <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
In-Reply-To: <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 10:09:01 -0600
X-Gm-Features: AUfX_mx9mt9dbVrMmCFnN7qHq2KVIXtx4IDcN-1su1pyV_2ANjujEXVMup0YQWo
Message-ID: <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
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

On Mon, Aug 3, 2026 at 7:51=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int
> > +ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *control,
> > +                            unsigned long outputs)
> > +{
> > +}
>
> > +static int
> > +ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *control,
> > +                             bool active_low)
> > +{
> > +}
>
> I've not looked into the details, but these look like pinmux. Does
> this I2C device have a GPIO controller? Can these pins be used for
> other things than LEDs? Maybe you should be implementing a GPIO and
> pinmux driver. The Ethernet PHY driver can then just select the
> correct pinmux configuration.

These do not appear to be GPIO or muxable pins. The AC200
documentation describes them as three dedicated EPHY LED
outputs: link/activity, speed, and duplex. The bits in SYS_EPHY_CTL1
enable those output pads, while EPHY_CTL provides their shared
polarity setting. I have not found any documented GPIO data
registers or alternative functions for these pins.

Therefore, implementing a GPIO controller would expose capabilities
the hardware does not have, and a pinmux driver would only provide
a single fixed function. The callbacks exist because the LED function
belongs to the PHY, while the pad-enable and polarity registers are
reached through the AC200 I2C regmap rather than the PHY=E2=80=99s MDIO
registers.

>
> > +static int ac200_ephy_ctl_power_off_locked(struct ac200_ephy_ctl *priv=
)
> > +{
> > +}
> > +
> > +static int ac200_ephy_ctl_power_off(struct acx00_ephy_control *control=
)
> > +{
>
> > +}
> > +
> > +static int ac200_ephy_ctl_power_on(struct acx00_ephy_control *control,
> > +                                unsigned int phy_addr)
> > +{
> > +}
>
> These look like a regulator? The phylib core has support for
> regulators.

The external supplies are already represented as regulators. These callback=
s
do more than enable a supply: they sequence the package clock, reset and
shutdown controls, then program the PHY address, calibration and interface
state required before the normal Clause 22 endpoint becomes usable.

> Maybe take a step back and look at the overall architecture, and how
> Linux can represent these blocks.
>
>         Andrew
