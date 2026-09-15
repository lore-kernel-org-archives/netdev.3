Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E547ECDD
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467981; cv=pass; b=ENSOsj3IEOlrqBuHdNp8fpxKTNksbP4WLB1oqe2T8iRPrhFQwRqLM8xoaJfgkzOUjURsIZKcDtnnthxdJn3nMCgxDpDOQJVulP9QrEOMMNcCzwxV6A6aRSipdLuff62uKh8BwdGQdUF/erqnbBSghCzV/ldeJ+l32Q5ALgDUHV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467981; c=relaxed/simple;
	bh=vZzYcJ1wT8Rd7uAkDW6XfZWMX25LGItG9EqsF3/2Qs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYZsI393ah60+xekIhfu94MzTfK0Bgyb9Ub/zDVcX0nQnGs6UIPku40xo56/05ctU97NiEhAHvGfdrl3oYL5tgNF6QWtq8PigCuv85tx/0RP8soZmOwhNUFBb3fOKttYcEcCC27ue+gr4IQxU17sTZUCeFNuWnzZeveo2nDHmEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY7XcFp0; arc=pass smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY7XcFp0"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c25b4493edfso182598566b.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789467977; cv=none;
        d=google.com; s=arc-20260327;
        b=A5zjXkvPpTnKb+/4FszSoQpHTAw4qdPZmDBGwhFCIcw5OTrqAUC7NTWFxAld1pFD1w
         QHpwl5MXXcZ0ih1xJ7Aajluk52EWdoRLDMYybxihcddsyJx0FYth+noH6ZkzvADww1FP
         7dMu7TpIh4DaoCJT4c7Iq/QYsX6C4GM+fZ1Iz7soCNhcZIpWC2OTVuLr/cuAE23yE78X
         merDLmUuIPO5a4UU2ccM/nhklkcnn7InMH460lJMMyq/UQqx/Ek4wYoHwT3bSRkCIK9Q
         d3Y9CfpAZIZtR1aJ/ZwmBpiT/vsClFuWL+xjb6vMfjOAIqxbqaEin63CHQI8ItUQHOhb
         TMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PDmTn3anCnjZEAou9hrMuvIHzai6E6SOKUBtirHS8WY=;
        fh=FW7ZRSmdMl3+FYePKf9e6hfnNLjY+6gLiYeRedz1x2M=;
        b=c+MCq7rFADLdBuJbDSTOAMswYO/OzeflJINJLJyKNdPHBGSqy6ZQOwWLvAOwFDkzzh
         n60QzklYp/5hNijjfy7tlKa2i5gySVrCxnCRaGZrXmCKf7fXJTLSf2u8wNKZZdC0n47w
         HiM/WTM/n+ke4kO8k01Y7VwjHXcz93ytvF/om02Rrv4MQAgS9JvtYIg72EqT1ewGUydz
         f2KoLquqXZ5ndNB3rZNsam5IkHZ/YqiJpawG54bThgal5Z0l/ZriUvXQmBehvscj60ys
         hT9EQ2/trlbZsNVOPnlKOT9rADvP+NsVnqfhyZwleFYKR9C+xzgw7DkGkxvIgkK2qQnU
         RmdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467977; x=1790072777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PDmTn3anCnjZEAou9hrMuvIHzai6E6SOKUBtirHS8WY=;
        b=lY7XcFp0DaklzYdRxlf81uipUv5eTR6q1EHJ6VSQFTIv/YFwkJo5spbxNLcEEOrAOn
         Jdq7jZj3j3YXu3SqT2BwylXzHoPkV0nSXCMEGcTBNbvbNtKP/gcP4ydsZH5eziyrUHD2
         9/ZSPcN9sLvbcJ0Y5gYIXFtyLcI9yETUOFYlFj5N5PTScDIb9vZE34ICPeTBg1nI1dAU
         yEAMMDQifn4uZD1uCdmMP52SDOzuEFyMIfNz/ylvr8rz75e551mGXKDS/seNsuZXqSqg
         R0yQonNdjUlqjYymQ6VNVlButSe9toe0uVOMTNz1zLsCsEvobzN4BlgFJRji5REYOvmJ
         NDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467977; x=1790072777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PDmTn3anCnjZEAou9hrMuvIHzai6E6SOKUBtirHS8WY=;
        b=jxWdmMdgeNfc7KuMu/bjEyM6KZXsOUFMg7vpQAN7nDXXU8LgY1S41doh6lQ08PPuZ8
         PZ8P9cJoGzzIZEe9YjckOZk6uzp6F3qIEyMQNXAE+kDwoplAFpGO73hFw7jDLenfIqdU
         PXr3ijRuMOwdZKmlo84tnJsCncLw42XjK1gnH7n1qQC7dVP/qB2f2az2DekAJo3N7rvU
         aLT6BdH2/ZdKeBW10rQN3ER8aT1rjsC94s8n/O626L7XTLaYHSUgonwaKXijTQ2JGyHD
         22CrD8nkwWJ0oowZTgYNMMOsqtTQ+SJJQJW5QEqe8dBIINizPwIOgmewbkSlJ0ZcvPgy
         QU1w==
X-Forwarded-Encrypted: i=1; AKwUvBzPZ4X3AX6JMpAcIrndmhXkMZjatP9o0JyoHthK9F7VJW283xCfYckIj1CKeb7GBeOM4na9ueU=@vger.kernel.org
X-Gm-Message-State: AFuF++k7qRZWZOhHOtT/4pTr4E/laH7B0DgVMDsKI/KPIa1wt49YqI/B
	UN5rB17r0EyhZ90eCSD3Nllbz9twjjz06tLzUZwgQLNaAVSBfjJYRRFnqHGBQ0lxi3XgbSNFpTA
	QoFvdrg/XLatJIjRHT7uaA0T8rV/Ghrw=
X-Gm-Gg: AYBFou1mbmIw1mTVqw5ySHC/9/hef2v9D1eR296AIrQMRfDCMHmXbQ7O2CpCrCjRjva
	uxFl6OceR3R7uWvVQ+2BHZF5aydMphpI+K3yUBy2t4Kd7sW6OB4Tv68su7ucBjl0tJzoEVctYF0
	PDy61yp93fMZtqHtKAzBIWwv8zk555I4/MlbUUdMcrpuo84FDzjXygLhBzrSmYoKslsOzRDM/46
	G2Rzpstm+DuCcIipG/vsuY0oLELraY1JVmU/SR0mGwKZz5dlvMpmDCnd79Cimr+l8zx0diceVCg
	+wM9ELOB8WsE0HAfxU+jfabSqHZdUzqMR07gyj6J3988ORffP22cUia50g==
X-Received: by 2002:a17:906:6a01:b0:c26:2205:3df8 with SMTP id
 a640c23a62f3a-c29d7717424mr36060866b.9.1789467977119; Tue, 15 Sep 2026
 03:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913185849.907479-4-coiaprant@gmail.com> <178941747926.22033.15174869537556409251@kernel.org>
In-Reply-To: <178941747926.22033.15174869537556409251@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 15 Sep 2026 18:26:04 +0800
X-Gm-Features: AcwNN1ULwDCN22NcSTGJGIqUo7wEAVDbHGW4RjkupXf6vRbCRoH1F1Vq6Gp7hg4
Message-ID: <CALj3r0hg6kchV72wSv0ybPVqG93D4_QnB-diFmW45jLZwoP_cA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/11] phy: rockchip: naneng-combphy: add
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

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C 04:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] In rk3568_combphy_cfg() (drivers/phy/rockchip/phy-rockchip-
>   naneng-combphy.c:881-882) the newly added write of pipe_sgmii_mac_sel=
=E2=80=A6
>
> --
>
> phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
>
> This adds a "rockchip,sgmii-mac-sel" DT property to pick whether the RK35=
68
> SGMII interface is routed to GMAC0 or GMAC1 via PIPE_GRF_XPCS_CON0 bit 1.
> The value is read in rockchip_combphy_parse_dt() and programmed from the
> PHY_TYPE_SGMII branch of rk3568_combphy_cfg().
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 229)
>
> One question about the commit message wording:
>
>     The hardware reset value is 1 (GMAC1). If the property is set to 0,
>     the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
>     remains at GMAC1.
>
> Does "or omitted ... it remains at GMAC1" match the code?  The write in
> rk3568_combphy_cfg() is unconditional, so in the omitted case the driver
> does not leave the bit alone, it actively programs it to 1.  See the
> inline comment below.
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
> Since device_property_read_u32() leaves the output untouched on failure,
> rockchip_combphy_parse_dt() ends up with priv->sgmii_mac_sel =3D=3D 1 bot=
h when
> the property says 1 and when the property is absent.  Is there a way for =
the
> driver to express "leave the bit as firmware left it"?
>
> Before this patch the kernel never touched PIPE_GRF_XPCS_CON0 bit 1, so a
> board whose bootloader routed SGMII to GMAC0 kept that routing.  With thi=
s
> change, a DT that instantiates the combphy as PHY_TYPE_SGMII but does not
> carry the new property has the bit re-programmed to GMAC1 on every
> phy_init().  Can that break such a board's SGMII link?
>
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
> > +                                          priv->sgmii_mac_sel > 0);

The hardware reset value of PIPE_GRF_XPCS_CON0 bit 1 is 1 (GMAC1),
so programming it to 1 when the property is absent produces the same
result as leaving it alone =E2=80=94 the bit is already 1 after reset. The
"remains at GMAC1" wording in the commit message reflects that.

SGMII has never been functional on RK3568 in mainline before this
series, so there is no existing in-tree or out-of-tree board whose
SGMII link could be broken by this. A board whose firmware happened to
route the bit to GMAC0 still cannot use SGMII with a mainline kernel
before this series, and will need the new property to describe that
routing once it can.

> [Severity: Low]
> This write always happens, including in the "property omitted" case, and
> rockchip_combphy_param_write() sets the write-enable mask along with the
> value:
>
>         tmp =3D en ? reg->enable : reg->disable;
>         mask =3D GENMASK(reg->bitend, reg->bitstart);
>         val =3D (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
>
>         return regmap_write(base, reg->offset, val);
>
> so with priv->sgmii_mac_sel defaulting to 1 the register gets
> (0x1 << 1) | (GENMASK(1, 1) << 16), i.e. GMAC1 is forced.  Would it be
> better to only issue this write when the property is actually present?
>
> A second question: bit 1 of PIPE_GRF_XPCS_CON0 is a single SoC-wide mux,
> while the property sits on a per-PHY node.  If two combphy instances that
> share the same rockchip,pipe-grf syscon are both brought up as
> PHY_TYPE_SGMII with different property values, the last phy_init() wins a=
nd
> nothing is reported.  Should conflicting values be rejected or at least
> warned about?
>
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
>
> For what it is worth, the only in-tree SGMII consumer at the end of this
> series, rk3568-photonicat.dts, sets rockchip,sgmii-mac-sel =3D <0>
> explicitly, so no upstream DT changes behaviour today; the concern is abo=
ut
> out-of-tree or ported device trees and about the commit message wording.

There is no in-tree case where two combphy instances are both brought
up as PHY_TYPE_SGMII with different values. This is a single SoC-wide
mux and only one SGMII link exists on RK3568, so the situation cannot
arise on real hardware. I'll leave it as is.
