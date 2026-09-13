Received: from mail-ed2-f9.google.com (mail-ed2-f9.google.com [74.125.228.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA3363090
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789312331; cv=pass; b=oReC4ss0ZR34M74ab5Zmf+4+A9AT0SKTYxEVXzntSRT5pNdzVKoFf621VP61WhqKjpVIM/4HF/4g34fx4sO6rV4yiPM80Px0GGH8tpV0QElNs6v6B+YuRPUFbbxXYtu9oc4sBISN0sBDKAPxOfcLzDUrJCZZGUA/kla96eTdv8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789312331; c=relaxed/simple;
	bh=V9KdXH7CS1cOOua64xEPqp2VoZ+exq9zbbv82Os6Ku8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JADaohGIx7kIb3ZDuG2Hoap0GOskLG1MmzvYZeH4V83ugbm4gzkeZU1NE41TBdw7P6GZra8gGf07Dod7ngFl4lWBmqRn3NKfjgIFMROlxhYUTGvktqkXicAvJQo7WZYd/Evb/qBlnXOSJjJYNzoMVF1GLQ2Nh1AS6qVTnWEhQiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtQ9PtY+; arc=pass smtp.client-ip=74.125.228.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtQ9PtY+"
Received: by mail-ed2-f9.google.com with SMTP id 4fb4d7f45d1cf-6a99cd510ecso1202102a12.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 08:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789312325; cv=none;
        d=google.com; s=arc-20260327;
        b=NefT4VRxG1W5HgK/CyL71tV1hLq7+yX8/s2+z36E3f7SABp6T80GFjjrZF+vQuhSyV
         r1fK7nscKTN9BZkYj7tywoI/aZ3HovAH1L7AEpFLjHMnXggI8cIGsEi2w/7DDfMeRt31
         DOgPemHErsG2ifD8xv4pNAPt/DzJTsbDfjizfCWa9Nylu6SVotYuFCS8OZVTDeM4a0X3
         4G5/AjlsCXSgBVBfcB5QibRKOyh2PueTwHIlAkf2UQIHV6oy4WqFOnZ660SGp3kqRSgr
         rKns854yRrrHFw5xt4I7QRBbE3gu+YbMbrQpCKA3XDqDt88cXrT7fLM+CuGMF1O78GM9
         vxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i6FKqhHGMKbN+g1kF5qjdCbk6ZlE4yPuWZmPTrF4npY=;
        fh=xPLLOIZ6FJKM1jJjHRYVaDrSRnzm49xJEtFBL9ySI3w=;
        b=r8R65Qr9UPeRNBbvC1zZsKioE/cgPrvXRl4WpWiYyqexsBB+OUdGNqnpXU8HENUTMY
         BHi+6zWmcWAK2CIIX/zhViBDd2cwXo0L0eP1f0c6Cg3Q6Ta+ybYA/JzDywT1y+smq4zH
         RaNkI6woElidhb+4TiEcExP7Uv6OsM56+RH0vNAnXmyAhuXS/DuocooDLRjFOd1UOGmW
         zLCpeJObZpNk5vYDRdofc3hNOBatkak7yiwYIC92byqGNmERHGNx05Lf+S97TbvfeBvO
         l0fxDxizg5fId0gBkL0PLNWjGmZ05b5nO/rD3EdpEh8FUS+eHgbCWFClt/EK+bLWJT4z
         AuNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789312325; x=1789917125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6FKqhHGMKbN+g1kF5qjdCbk6ZlE4yPuWZmPTrF4npY=;
        b=mtQ9PtY+hXTDYFGOJzHeDL6RqWAIpqX/sgR8a+JUwBy81Rh7xKGGFJgoORe3fNVKVt
         TZHhaCidM9wa//4IIuALb0RKKz49eW64/83dF+niiS0mFWPtrRIP/dzlTEMEolLfkcze
         /U7Unvva88+erEt31A8qwo7Zn26WESvls8TSNruWdo9zpBTCB+VzhJPWFxDgEl5/3E/1
         77Hr03l9EVAGgqcDFd3lQoQ5sQsStmNJ6/FBr6JLC52ZKTnZfvYybw9H8qoq6IrAu0w0
         4JPjG1V/T9e008tQbGdig3wgpqa19uW/3PEDLVEzOMUZR8PWzax34dpTMPtofkyJ43ho
         Ha4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789312325; x=1789917125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6FKqhHGMKbN+g1kF5qjdCbk6ZlE4yPuWZmPTrF4npY=;
        b=KnG92LV95fusQwc1kTUsI/PJRdtGw5t8DrSfLKlzbXhECowSPnBWsdcyT4UiU4gmwx
         wo+uaknuDDnB7Kzc/S/WPkDJiwrY8q4/pfwroQGHmRszKWgtx3dO/b7B5VG48uw/YKiz
         T4kNG7VDuNdRFyT3GElLeswRTOo+n4pLqgt7h/Lyjg47/LBkqAHF7w1OTwBGKzTfm2gf
         WqTkYqxgAyKy8Z6SQFTO55FJJjOzussXiM+GJiXrudj9WgVTLA0xu7F40ZAeu+E7uW2L
         2Q8pTZKB9hyB5w4RYWX/HOB3domTxAowQs19mYwVX2WLQuPnakwFAKUAc9EDM0zuV6G6
         zfbA==
X-Forwarded-Encrypted: i=1; AKwUvByIGdDpfAL2pRtgTt6Wjh3XQBVUxCYlQiNDGEgmuUHluBC/m2AJhn+QqJPsKIuaYfgtKytOXPE=@vger.kernel.org
X-Gm-Message-State: AFuF++lrTNUsMeYdyVxg6ZwCqI8uw0ZWdEWXvsFJG0qmiekJi+Uf1kQb
	Zg0Uo6LD6AaUqGYqarE+mcrmWKVlYBlxytZNeBycZZHeAkMNf9G76y86CPehByFOFYk+PjYXPhT
	t9RLizcXZN/jQF877/9pMSGGGyrJVYdE=
X-Gm-Gg: AYBFou2OdLcooz+YTppkTXlKoy8lNFq1cOoit5KmWV3MYnO5ZHC+TTm23jR5wdnKgRs
	Yk1ASBz3oglSs84KY4yZHukZwatiJ4GRZJ5VGkDb5RrTwXsvt75ZyxFIE9FMTOdXsj14Ug9U2WC
	iTMd7VcYeZSdhYnGcBMGMB2SOyhfRyJSDKA2hIpKQ0nkfpAVp9LsZ+vskoP60WknEyqQi06gQO2
	ahUOurLaDJBtOTS/wRRGazC3M/m7EQPioDSwUI2X7l00P5wJZ1L9VnwxxRF/7oPmZNSL5IHYzyM
	DFfODP9pwzvGIosnCspI6Excsg9yCLqcjNcuuOKngxuVYlJtOrIAlQHEFQ==
X-Received: by 2002:a17:907:c48d:b0:c25:8eb7:f388 with SMTP id
 a640c23a62f3a-c2966732b44mr1279507266b.17.1789312324376; Sun, 13 Sep 2026
 08:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907153713.2572547-5-coiaprant@gmail.com> <20260912201322.126940-1-kuba@kernel.org>
In-Reply-To: <20260912201322.126940-1-kuba@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 13 Sep 2026 23:11:52 +0800
X-Gm-Features: AcwNN1XiM26q-ovJF_4CrXhU4nIDQ7WEDIwpgpUZziGAyddbfl9wQtAk49btimU
Message-ID: <CALj3r0jVNnwhT1odBn_7Fg4hqC5covyQTsw0B3wiNQhiciFTEg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/10] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, vkoul@kernel.org, maxime.chevallier@bootlin.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, romain.gantois@bootlin.com, 
	hkallweit1@gmail.com, neil.armstrong@linaro.org, linux@armlinux.org.uk, 
	shawn.lin@rock-chips.com, david@ixit.cz, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8813=E6=97=
=A5=E5=91=A8=E6=97=A5 04:13=E5=86=99=E9=81=93=EF=BC=9A
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
>
> This adds a "rockchip,sgmii-mac-sel" DT property to the RK3568 combphy
> driver so the SGMII interface can be routed to GMAC0 or GMAC1 through the
> pipe GRF pipe_sgmii_mac_sel bit. The value defaults to 1 (GMAC1) when the
> property is absent, and is written during PHY_TYPE_SGMII configuration.
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 229)
>
> A few questions below.
>
> > diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drive=
rs/phy/rockchip/phy-rockchip-naneng-combphy.c
> > index 7843356a4dd47..919bb97a4b182 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>
> [ ... ]
>
> > @@ -212,6 +213,7 @@ struct rockchip_combphy_priv {
> >       bool enable_ssc;
> >       bool ext_refclk;
> >       struct clk *refclk;
> > +     u32 sgmii_mac_sel;
> >  };
> >
> >  static void rockchip_combphy_updatel(struct rockchip_combphy_priv *pri=
v,
> > @@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device =
*dev, struct rockchip_combphy
> >
> >       priv->ext_refclk =3D device_property_present(dev, "rockchip,ext-r=
efclk");
> >
> > +     priv->sgmii_mac_sel =3D 1;
> > +     device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sg=
mii_mac_sel);
> > +
>
> [Severity: Medium]
> Since the return value of device_property_read_u32() is discarded here,
> rockchip_combphy_parse_dt() cannot distinguish "the DT asked for GMAC1"
> from "the DT said nothing about the mux".
>
> The result is that rk3568_combphy_cfg() writes PIPE_GRF 0x0040 bit 1 on
> every PHY_TYPE_SGMII bring-up, including for device trees that do not hav=
e
> the new property. Before this patch that bit was never touched, so whatev=
er
> routing the SoC reset or the boot firmware established was left alone.
>
> The commit message states:
>
>   "The hardware reset value is GMAC1 (1). If the property is set to 0,
>   the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
>   remains at GMAC1."
>
> The "or omitted" case now depends entirely on that reset value being 1. I=
f
> the reset value is actually 0, or if firmware routed SGMII to GMAC0 on a
> board wired that way and its DT lacks the property, does phy_init() still
> return success while the XPCS ends up attached to the wrong MAC, giving a
> link that never comes up and no message explaining why?
>
> Would it make sense to only write the bit when the property is actually
> present, for example:
>
>         if (!device_property_read_u32(dev, "rockchip,sgmii-mac-sel",
>                                       &priv->sgmii_mac_sel))
>                 priv->sgmii_mac_sel_valid =3D true;
>
> so that omitting the property leaves the mux untouched?

SGMII has never been functional on RK3568 in mainline before this
series. There is no existing user that relies on the old behaviour,
and no in-tree device tree enables SGMII. Boards that have the SGMII
routing configured in their bootloader were never able to use it with
a mainline kernel, because the driver did not support it.

Given that, unconditionally writing the MAC-select bit (with a default
of GMAC1, which matches the hardware reset value) is reasonable. It
makes the driver's behaviour explicit and deterministic rather than
depending on whatever the bootloader happened to leave behind.

I'll keep the current logic, but I'll make the commit message clearer
about the hardware reset value and the fact that SGMII is new in
mainline.

> >       priv->phy_rst =3D devm_reset_control_get_exclusive(dev, "phy");
> >       /* fallback to old behaviour */
> >       if (PTR_ERR(priv->phy_rst) =3D=3D -ENOENT)
> > @@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combp=
hy_priv *priv)
> >               break;
> >
> >       case PHY_TYPE_SGMII:
> > +             rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_s=
gmii_mac_sel,
> > +                                     priv->sgmii_mac_sel > 0);
>
> [Severity: Low]
> The binding added in the preceding patch of this series declares the
> property as:
>
>   rockchip,sgmii-mac-sel:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     enum: [0, 1]
>     default: 1
>
> but "priv->sgmii_mac_sel > 0" collapses the value to a boolean, and
> rockchip_combphy_parse_dt() does no range check.
>
> Does that mean a device tree setting the property to 2 or 0xffffffff is
> silently treated as GMAC1 rather than rejected? Similarly, a
> present-but-malformed property (wrong length or type) makes
> device_property_read_u32() fail, and the pre-seeded default of 1 is used
> with no diagnostic.
>
> dtschema only validates in-tree device trees, so for bootloader-supplied
> DTs or overlays the driver is the only place the enum can be enforced.
> Would checking the value against {0, 1} and returning an error, or
> alternatively documenting the property as a plain flag, close that gap?

The property is validated by dtschema. For in-tree device trees, values
other than 0 or 1 are rejected at build time. I don't think the driver
needs to duplicate this check.

> [Severity: Low]
> The mux write is only added to the PHY_TYPE_SGMII case. The adjacent
> PHY_TYPE_QSGMII case in rk3568_combphy_cfg() programs the same pipe-grf
> register (pipe_xpcs_phy_ready at offset 0x0040 bit 2) but never touches
> the MAC-select bit:
>
>         case PHY_TYPE_QSGMII:
>                 rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_x=
pcs_phy_ready, true);
>                 ...
>
> The binding gates the property on the compatible only, not on the PHY
> type, and rockchip_combphy_parse_dt() runs at probe time before the PHY
> type is known from rockchip_combphy_xlate().
>
> If a device tree sets rockchip,sgmii-mac-sel on a combphy that a consumer
> later claims with PHY_TYPE_QSGMII, is the requested routing simply droppe=
d
> with no warning? If the property is meant to be SGMII-only, would
> rejecting or warning about it for other PHY types make that explicit?

You're right that the property is SGMII-only. For QSGMII, the hardware
routes to both MACs internally, so there is no MAC-selection bit to
program. We have not found any QSGMII device that exists outside of
OEM SDK EVB code, and mainline XPCS does not support QSGMII, so this
case is not currently reachable. I'll leave it as is.

> >               rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_x=
pcs_phy_ready, true);
> >               rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_ph=
ymode_sel, true);
> >               rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_se=
l_qsgmii, true);
> > @@ -984,6 +991,7 @@ static const struct rockchip_combphy_grfcfg rk3568_=
combphy_grfcfgs =3D {
> >       .con3_for_sata          =3D { 0x000c, 15, 0, 0x00, 0x4407 },
> >       /* pipe-grf */
> >       .pipe_con0_for_sata     =3D { 0x0000, 15, 0, 0x00, 0x2220 },
> > +     .pipe_sgmii_mac_sel     =3D { 0x0040, 1, 1, 0x00, 0x01 },
> >       .pipe_xpcs_phy_ready    =3D { 0x0040, 2, 2, 0x00, 0x01 },
> >       .u3otg0_port_en         =3D { 0x0104, 15, 0, 0x0181, 0x1100 },
> >       .u3otg1_port_en         =3D { 0x0144, 15, 0, 0x0181, 0x1100 },
>
> For reference on the first two comments: this disable/enable encoding
> ({ 0x0040, 1, 1, 0x00, 0x01 }) is what maps the DT value onto GMAC0/GMAC1=
,
> and rockchip_combphy_param_write() always sets the write-enable mask:
>
>         tmp =3D en ? reg->enable : reg->disable;
>         mask =3D GENMASK(reg->bitend, reg->bitstart);
>         val =3D (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
>
> so the bit is committed to hardware on every SGMII bring-up regardless of
> whether the device tree expressed a preference. Could the TRM bit polarit=
y
> and the claimed reset value of 1 be confirmed in the commit message?
>
> Note that no in-tree Rockchip device tree requests PHY_TYPE_SGMII before
> this series, and the only user (rk3568-photonicat.dts) is added later in
> the series, so nothing in-tree changes behaviour today.

You're right, the commit message should state this explicitly. I'll
update it to describe both the bit polarity and the hardware reset
value.

From the RK3568 TRM Part1 (Page 229), the PIPE_GRF_XPCS_CON0 register
bit 1 is pipe_sgmii_mac_sel:

    0: SGMII interface is routed to GMAC0
    1: SGMII interface is routed to GMAC1

The hardware reset value is 1 (GMAC1). This matches the default I use
when the property is absent.

I'll include this in the commit message and the binding description so
that reviewers can verify the behaviour against the TRM.

Regarding the unconditional write: as I mentioned, SGMII has never been
functional on RK3568 in mainline before this series, and no in-tree
device tree enables it. So writing the bit on every SGMII bring-up does
not change behaviour for any existing user.

Thanks,
Coia
