Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD84DEC39
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675367; cv=pass; b=BsSVak/jm/ph4LLMabGYBC8LGEAmkLiTlK+bzxj6PICqPT8L8YbZ45u9/R3DPkJ02qX3PCC1GdZ0Uo2MnCiJAAvKu3zNT9dJOWfKoMVMc6IUzbsKGcLaiezQ9yyTke6/plY+vdFncZrC/yVSa3TaCKY4pg6HMFoWQHHqM/NVbbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675367; c=relaxed/simple;
	bh=XYSnRptyCTVZc4+Lnpov9eW3Zf5zzdiWt8cU4taD6hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFpC1GumqxxJUmN0mV85G6XDH57LKJxJ85b2FTAGx9Qtv2FcN3b4Nu5YhZHGCQ9eUWNs1WkeU3eJTuH6D85BaUN/y6fyria/2pQY8I0PEEFW7Clmqv9cFpc2iMC+fVH+qZBLRPlTJeud4QAR1iDfXNmPvwpaBWs0cjXO1aWI2K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oij3SAOe; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oij3SAOe"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c294cac59bbso75614666b.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789675363; cv=none;
        d=google.com; s=arc-20260327;
        b=rknDDvC5B2pRsEJoxjml7FM8V391meECRTtBO/+mi1oMZBwuI0vl18/1/T4+b9bByv
         w3uaL8GdFkmQo9z1oX2+txQ9Ea4rOHFgRdQI/49xVEUnvVlCQZbrj/bHLUy+F6XI+CE5
         lMGwEWctoATjqDCVrclGRZGbi8r7P7tePL+HyfHy007LjTCn8SAVZ6n9t6KVCZVtcUIk
         WjItpnhlPxdw8pT5yiiit1pL8INOJ5ubO8aheMexfGgHE/L5jzktqy8XdMa/F8B2quTW
         ezO/H/aVSdMcMvgc7MWUNt3huBWdcfPL/4vOrUIzUt8zLtEcvSNmjCW2VZS7dmXb5j6o
         60Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7mBcc/zD+gqhLUWIiGJPhvEmDVUp2BOJbW6rUgXDAE=;
        fh=V0RMiRw93w4q9Jd7dkDIoA/EKdC3brmBs3zKHYUZwfI=;
        b=RofRRRhOlAIh1C5dokUAiOPaWTE51PrQeiMn5IEsd8ymOI+01o5VVWEu4PjvD3k5qa
         BLxXNoF7w7ovH8g7XOCNlFbN5fkWMxecjLfY+oaARpRgxsa2vn5uJPkVtL0kxw8z+kGf
         7reBlxwuIZVySJJ5SCfhO+GEU58j1GkjcOzp0b3dbfG9Zg+bdwckYeveZHqcX3gnouAs
         siPLqnPq2DPSfV/NOFWXWsZ53QABO76ps9xM9lSJsLLoVH0FuTDX9Dx5tVSgK0JEbdcH
         riYIXr61+Bzc1ceermwahuvf8KE+omUoeoKlQweYxdHumaazGEout/CFXHkIim0VOcwL
         W2jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675363; x=1790280163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7mBcc/zD+gqhLUWIiGJPhvEmDVUp2BOJbW6rUgXDAE=;
        b=oij3SAOeoJJRHYAVV++SzoG7xG2SruBf3BlBsV6QCxNUxdAwsLs5dpe+0MX1DFWxrq
         C2nuqho4y9B456Tx0aXxRmVvZKxtvoEtDL16l2pWVn7HAZc2cUaMyd4sqNvK2RsgX7vL
         /B2SKZF45jhOwb8csERYM22Jg8FlQFaCrPmOusCy96PLgQyFYTSS9/mX44YwSENOTV8E
         Zfd33z6rZ7c+NpVAcyW6tkfZXGvO86EBt5oa1PonnXlqktuzruo3IrFIm3vT1/ufzEHv
         dlGDTREb3ZwdIdxbTgIr2K05dzoxySLlqpL63XM64srkyrv/yfltFwnoPiCf2D6shRQ8
         PyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675363; x=1790280163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7mBcc/zD+gqhLUWIiGJPhvEmDVUp2BOJbW6rUgXDAE=;
        b=XLtPvypE4yexQo8acMYfhGHDReXmn9XVKlo+RNJL9Ld2GskYbZJ7VB4cJuVXufcEab
         PpA4h6RDIw6ihM40WmE764XVyosh2LdsgKdtXIxUanZ2ASRYSyXC6Ta5rHe7ZJY7k3X7
         IlxLoPklVvpdhuaAUO1KPuINLtSmGx+OktEySPh6p8zJ00haeVfjdYjkNL1B+l9UwBdh
         wPLbflaelqdV94s05R+HdpKNvWgxhzFxxYkLUxEuiLDlaziRfsNNS8otb2tqVgQ6T0G9
         feQ3H0dsLkiOC16t6IHXK5vOROph4MvES8uzJLgDbI38DvvBE8kRAxtQMemWEV5rk8Hw
         DOqg==
X-Forwarded-Encrypted: i=1; AKwUvByw1MlF39gzPmqq0pKh7Zb765v8hCIGmJXW+pCIZ1is6j18NH/Mgh5F/Fd8eNm38vhXncM+Z24=@vger.kernel.org
X-Gm-Message-State: AFuF++mIATY6+qYSVF97O6DjtvLZulkt4TnXh43pz6z/gZZdWKSOAcqS
	53qLN53sEr+wIkCltIsAYYRkZ+5b1CRhAneevQMC2CGihDqj+qmbPTJCqBJonU8FYPuCutVUaMU
	3h8dLwbnQRgy1Otl8B0Io//I8DcmW/SA=
X-Gm-Gg: AYBFou1uqre7Pcz3uszUpiDdwDGeJUOD0R/wucKgl1qRrLJuI1YgAusb+zsRdgYINh5
	GharZpGcwNRESX7j3L7GfBf0WlE/i87fnW0bUwlegAqVyo7JsuLDrTRKSCStHqWn3HVJg5s6fCE
	+VvSSGKxSjgzk7H3qsCvL4+6LlOcoflRvT0fg4F+EeokTFOXwZaKnR85GTx4V2Lq/xRH25SNT3R
	89NVdfbMM9YvbbHTOYEjlnYGdDsC6n2PrmnldmssbDVFilPS8uHgF0BPm77ZahgvXRnycAkoAkl
	+HvVKxbW3B5BylIxlyCfL4CjeTdulO1hUkcwxJEO6Et44EIz3PNV5bxUag==
X-Received: by 2002:a17:907:3ea5:b0:c29:4204:8dbf with SMTP id
 a640c23a62f3a-c2a157be91fmr24595366b.7.1789675362739; Thu, 17 Sep 2026
 13:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915123802.1561724-4-coiaprant@gmail.com> <178967028966.22033.2377561177851606071@kernel.org>
In-Reply-To: <178967028966.22033.2377561177851606071@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 18 Sep 2026 04:02:31 +0800
X-Gm-Features: AcwNN1V0XFtsL3x8UawoWV106fmNQdao8d4jMazcuCe1sSda_ba5TrpA_lpwoh4
Message-ID: <CALj3r0jGVO_bDDkf1ts8ajtsRf8Tq--TG=Hfb4m8B5bbNLryqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org, 
	linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz, 
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 02:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:380-381 reads
>   'rockchip,sgmii-mac-sel' with device_property_read_u32() for every=E2=
=80=A6
>
> --
>
> phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
>
> This adds a "rockchip,sgmii-mac-sel" DT property so the RK3568 SGMII
> interface can be routed to GMAC0 or GMAC1 via the PIPE_GRF_XPCS_CON0
> pipe_sgmii_mac_sel bit, defaulting to GMAC1 to match the hardware reset
> value.
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 229)
>
> > diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drive=
rs/phy/rockchip/phy-rockchip-naneng-combphy.c
> > index 7843356a4dd47..7b867e7520064 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>
> [ ... ]
>
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
> [Severity: Low]
> This isn't a bug for any schema-checked device tree, but would it be wort=
h
> reacting to the return value here?
>
> The binding restricts the property to two values and to one compatible:
>
>   rockchip,sgmii-mac-sel:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     enum: [0, 1]
>     default: 1
>
>   ...
>         rockchip,sgmii-mac-sel: true
>     else:
>       properties:
>         rockchip,sgmii-mac-sel: false
>
> In rockchip_combphy_parse_dt() the result of device_property_read_u32() i=
s
> dropped, so a malformed property (for example a zero-length or wrong-size=
d
> cell, which returns -ENODATA/-EOVERFLOW and leaves the output untouched)
> ends up indistinguishable from an explicit request for GMAC1.
>
> The read also happens for every compatible, including rk3528/rk3562/rk357=
6/
> rk3588 where the binding declares the property invalid; there the value i=
s
> parsed and then never used, since only rk3568_combphy_cfg() consumes it.
>
> [ ... ]
>
> > @@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combp=
hy_priv *priv)
> >               break;
> >
> >       case PHY_TYPE_SGMII:
> > +             rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_s=
gmii_mac_sel,
> > +                                          priv->sgmii_mac_sel > 0);
>
> [Severity: Low]
> Should out-of-range values be rejected rather than folded into GMAC1?
>
> The "priv->sgmii_mac_sel > 0" test collapses the u32 to a boolean, so a
> device tree with rockchip,sgmii-mac-sel =3D <2> (or 0xffffffff) that was =
never
> run through dtbs_check gets the GMAC1 routing and rk3568_combphy_cfg() st=
ill
> returns success, with nothing logged.
>
> A range check in rockchip_combphy_parse_dt() returning -EINVAL, or at lea=
st
> a dev_warn(), would make such a device tree visible instead of silently
> selecting the default route.

Thanks for the review.

The property is validated by dtbschema for all in-tree device trees,
which is where the enum and the compatible gating are enforced. A
malformed or out-of-range value can only come from a bootloader-supplied
DT or an overlay that bypassed dtbs_check, which is a user error rather
than something the driver needs to defend against.

The read result is intentionally ignored: the default of 1 matches the
hardware reset value, so a missing property and an explicit "1" are
semantically identical for this hardware.

Thanks,
Coia
