Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15E39A06B;
	Wed,  7 Oct 2026 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359013; cv=none; b=nN9gmMdv82xeqDlK+S/dp1Z0eQjiqgjEo1OYdZ/SPeUoUmb2OfMvHukKDIlgAZiSMsYsWuhd3vIAK+6lN9Xb0SAnJ3IVX5Gdezx0u9aydkfIGnP6rtiR+hLAebEvw8nOD1ayXinm4JTAPmueIbN0AqS4dM44sxXnaN6u0wXl4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359013; c=relaxed/simple;
	bh=N5rQ1HvkbnGVZXYoYzrUqHL48aCM+AmX0NrPHUy/dKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M88W+g+UtL/ru/1+w+HCgJxO1X0Zp8IO4gIKuiS/2YfWldu6wIMwArLlp5zorujzOHjuRDQTH1savE/+uGRboJVZQrAZ+nJs8mdJNqx936D28yxGRhwGUf72mcz/Lg8YrmUidrIgMeU+5fplqtzj97ifL/abTvBdkedW0SBrWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AAwvb6H6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLbKXV7T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AAwvb6H6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLbKXV7T"
Message-ID: <c1f48a5caa670ece21e73458787a62f97879346f.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791358999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXCuBoVHEq47ESs5wsAP5vYQrZJBRcyyNOmcXot4ByI=;
	b=AAwvb6H6X76pmnw2SFLsGUaUN4Ris2V5y6ufDe3Jy31sBOB2ElOzEBi5YNOZG1RQaRIyHt
	3WC1JzFmksgBwyuo7/OwgTyPSIc+Ozb2ad1CCW29J/mgA6yvML47NeAcZmgRPXu70bmNzf
	6CwCPSh2a0Bt/zmPIn2PSQJyys7HnJLYEgRXFB5D1paMW7Vnywt9xJSC2orZTLiw4JqVjB
	D8VaAYr0XsENVhLciVlH/aYnVE6bElfSlCf9R6zdlVkDJsmc0OFLnfmaftkURVhzQ/PuQG
	MR1F3xa4LVjSgwgRlXCAxg9GRGCvMykJt75gK698wpyVoLLCYhY+DoiD0P4Gow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791358999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXCuBoVHEq47ESs5wsAP5vYQrZJBRcyyNOmcXot4ByI=;
	b=nLbKXV7TiIPPRLqQAZcpEEa1KC1ns92ajm6qxmSW/EmDGReOmmGFCoAoRYbpiUlvtlpHso
	ZreauVAJKTmVviCQ==
Subject: Re: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch,  olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch,  hkallweit1@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Wed, 07 Oct 2026 09:43:18 +0200
In-Reply-To: <179051210447.2160803.13761066598804865928@kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
	 <179051210447.2160803.13761066598804865928@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 12:28 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] In soce,swip-mdio.yaml the MDIO controller owns the whole
>   32-bit 'control' register (<0x200 0x4>), which the binding calls the=E2=
=80=A6
> - [Low] The only compatible is 'soce,swip-mdio-23-02', and neither the
>   binding nor the commit message explains the '23-02' suffix.
>=20
> --
>=20
> dt-bindings: net: Add SoC-e SWIP MDIO controller
>=20
> This adds a devicetree binding for the MDIO controller built into SoC-e
> SWIP Ethernet switch IP cores. The controller has a data register region
> and a shared transaction control and bus selector register. It is the
> parent bus for an MDIO mux that reaches the external MDIO interfaces.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml =
b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
> > new file mode 100644
> > index 0000000000000..3cf4bde0508ab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
> > @@ -0,0 +1,47 @@
>=20
> [ ... ]
>=20
> > +description:
> > +  MDIO controller integrated into SoC-e Ethernet switch FPGA IP cores.
> > +  The controller accesses multiple external MDIO buses through a mux.
> > +
> > +$ref: mdio.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: soce,swip-mdio-23-02
>=20
> [Severity: Low]
> What does the 23-02 suffix mean? Neither the binding nor the commit
> message explains it. It looks like a YY-MM IP release tag. The DSA
> driver commit in this series mentions testing an MRS 25.01 core.
>=20
> This MDIO block is part of the larger SWIP switch. It sits at
> 0x200-0x20f inside the switch register window.
> Documentation/devicetree/bindings/writing-bindings.rst says:
>=20
>   For sub-blocks/components of bigger device (e.g. SoC blocks) use rather
>   device-based compatible (e.g. SoC-based compatible), instead of custom
>   versioning of that component.
>=20
> Could the version scheme be documented, or could a device-based
> compatible be used instead? As it stands, it isn't clear whether each
> future IP release would need a new compatible.

I will remove this suffix. For a child of MFD "soce,swip-mdio" is
enough.

>=20
> > +
> > +  reg:
> > +    items:
> > +      - description: MDIO parameter, write data, and read data registe=
rs
> > +      - description: Shared MDIO transaction control and bus selection=
 register
>=20
> [Severity: Medium]
> Is this the right way to describe the bus selector? This node claims the
> whole 32-bit control register at <0x200 0x4>, bus selector field
> included. The binding gives the mux no way to reach that field. There is
> no #mux-control-cells and no mux child node, even though the description
> says the buses are reached through a mux.
>=20
> Later in the series, the example in "dt-bindings: net: dsa: Add SoC-e
> SWIP switch" covers this with a sibling mdio-mux-mmioreg node:
>=20
> Documentation/devicetree/bindings/net/dsa/soce,swip.yaml:
>     mdio-mux@202 {
>         ...
>         reg =3D <0x202 0x2>;
>         ...
>=20
> That range is the upper halfword of the register that mdio@204 already
> claims as control. The driver commit "net: mdio: Add SoC-e SWIP MDIO
> controller driver" says the same thing: the selector is bits 26:16, and
> a generic MMIO MDIO mux manages it through the upper 16-bit halfword.
>=20
> The result is two sibling nodes with overlapping reg ranges for one
> hardware register. This only works because neither driver requests its
> region exclusively. soce_mdio_iomap() in drivers/net/mdio/mdio-soce.c
> does:
>=20
>     return devm_ioremap(dev, res.start, resource_size(&res));
>=20
> mdio_mux_mmioreg_switch_fn() also does a plain ioremap() on every
> switch. If either driver moved to devm_platform_ioremap_resource(),
> probe would fail with -EBUSY.
>=20
> Nothing fails with the current series. There is no -EBUSY today. The
> mux's 16-bit read-modify-write and the 32-bit read-modify-write in
> soce_mdio_start() are serialized: mdio_mux_read() and mdio_mux_write()
> hold the parent bus mdio_lock around both switch_fn() and the parent
> access.
>=20
> The concern is the DT ABI. Once this binding is merged, moving to a
> description without overlapping ranges would break compatibility. Two
> options would avoid the overlap:
>=20
>   - make this controller a mux provider with #mux-control-cells
>   - have the controller register its child buses itself
>=20
> Would it be better to choose one of these before the binding is merged?
>=20

Yes. I will address this in the MFD rework.

The MFD parent will register both child devices, with mdio-parent-bus
connecting the mux to the controller.

As already mentioned in other thread, this overlap is wrong.
The MDIO controller will use only the lower 16-bit half of the control
register through readw()/writew(). The sibling mdio-mux-mmioreg node
will use the upper half, so the resources will no longer overlap.

pw-bot: cr
