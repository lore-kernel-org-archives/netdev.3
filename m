Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9737105A
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789322062; cv=pass; b=EHvX0MVdDfv0AXo7dI9X4ap2viGr8oIxLrzWrTdTIZ9BOMOwNS3Esz40Bk2x5WR4CzkXLajqPXT2riR3a3UK3cdvHZNSYMzdThnCama62/4fqhJ7p3WScmEd+AcY6rWBD75bDvkNwnxSB9ARRysS2MKvcifmrEf/mEHcHOoZc2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789322062; c=relaxed/simple;
	bh=5mJtBjQue10b8OYN9gooWp+BT0MXjYG0jovQVtZ1bT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P85k3RgGPgQ63vCoLxiVNFhS3k51YKe8w5AZUV0EET5Zh4mrzbJZG4bivQSNclUI+rFKhYwE6Hs/2cE3ANQgbkcR82LG7g8JgSrXsRk8LiWn16qjiR1FvSiuyY/Iq4xhct3osiSji2jcZrCbcv+ngzksjObsRlgvHdmL0r8Jt9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7ctSEYr; arc=pass smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7ctSEYr"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c25b4493edfso114881566b.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789322058; cv=none;
        d=google.com; s=arc-20260327;
        b=YJavIzV/8zDP+IibmG4NMLHZAylfeUQZptSrHGjaagxxSNlsML+nFXZVdENQt33887
         BHVdt3dICvfb15hoSSoTKGZwdesYSEZCAMrejXR7OUnfOqwFTqqet2Wdn0ovmonXS4QU
         YStht9BrTAxYPzCmQ051i/+XfZZutGuRM5t/Ju5N+IeofoNRb23PQHNyWgTNMC7vvifV
         xT/XqWMxyMd8BAptd0426r8FPZXuwhknOaJlErpe1dC6eSQbAZMjVar4N0EgfhawvNlp
         Nde5YlUBjTC+uZhVF8h/bRaDX8DzBXlqcmIP18SSXTI1CelX9Y5BmEz8Ipa4c/GvGoJq
         m63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2VcRS1K9zpuLLsLouHP0jen4im6vQDO3XTpDbYYnzBY=;
        fh=jK72mGJSLIfXUQMS6gjfcM/sjFfmV/15XtNHg4n+LpM=;
        b=oQ6NuuM7aX9T3t6NPRdqITE8PFyY10tt8kDoZCShtZStQ84/wbuUmVevStThRD2kZY
         TeJwUlWAHEiyeLdkLkJWFQ7CRLGutlMeaa+RbbRcca/HYm7ON2hFHtciZ3u7k4grRquJ
         TvtGqnCR6jby8QPBomJw43GM9BaYxZJHWSOYfL7l51ulyF44/+8DyqO7Kl7wZZHc6Mxj
         Fi1q284K0A1yNgYvzGpfGS6GxPB+16QcQkdS+i2GqcuJv/0R2r3WiGIfiJR2m+hquedm
         HMcD3VUbZU8L0hPwDJmixoq3Y6Iq9C23KSfksxAU4qOFfhSPqAYWnxzD4Eye2xoN0Nhs
         wRtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789322058; x=1789926858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2VcRS1K9zpuLLsLouHP0jen4im6vQDO3XTpDbYYnzBY=;
        b=p7ctSEYrvR62MEeTYz7AzmhUojZ8ePFhhiVGEzDCyr1uLYlIjgcSbmsCv0oVHA1bg0
         w3V/r/89bh35vb8YRncnqA38ApeCnr/uZKfiA8s1khdnpusCC/vwTt7+uUJ0hN9Xqkrk
         Zz96kl1w2D5LYvV3fisP0d/O/NGHSMflGJWP0grFQpGSiESFbHNZwmOKy1hLkxMrtpOE
         ewwt/BN+fxaRDUcNrf8Vc5Luum9uiKyEyCh5C6Vcke3YKp4kyhny8atrSsLcJu5lUVZ8
         pI6joe1EAHV8O2LMlXL6whGEyqNO51Omdayco5v56C0O5YFDhZRHepErl2JKXPjUHeJU
         ZYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789322058; x=1789926858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2VcRS1K9zpuLLsLouHP0jen4im6vQDO3XTpDbYYnzBY=;
        b=SulA3wJxcd9AKrnJ78B/qSxpySJ5c6Iq9fCom3iPDz1+TLg/KXF+Cx3QDJJZcUQt7M
         vWwRHx/J72py7h0t0eCtaN/uULT9XDhIR/cvF54JANbWNSovzWHnNNBdujqbZ2SgdaPy
         b59K8CZ5WV85m4veM/WUxwuv8/4tPuk2EzYv4mtzHogDyy5xWescLpb73R9WOzU0LbHX
         wA1bvd+ia6fPouZPi9+/8psMbplgn0dBa6RevrUnq2E8udzBK7b46TXqgnABdQ8TVx5/
         RiSIYEaBCtfXQ+OMZHL5wblw+bBino7AL0plkXJdTmW1wEXqgdBUhFNJYlp1RWDKCA7X
         /elQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLFYJ20ErF0kqyeQVs7RV1iHLNMSbLSDfEFaOcKzWFPXeJW7IyxAnHP38okpuxLOaLO8PHcXs=@vger.kernel.org
X-Gm-Message-State: AFuF++kFr86Us/A82Rd10fsFHNFpaNdW/7o8I6jutfOl3zoMy5fow5gN
	+BRdqn6hqSLDQLOI4scGT/98N3YsB2bJJJT1Bcut/b6PPf9OxH/xhDFhLdOlyqzyn/AzD19YCK5
	PHG+7o5CG2IVyCrzjISxk6K22TX7Mw30=
X-Gm-Gg: AYBFou3ijFSxipJNwxL144U71X3BWzORgI8hGTRH9r8Z8gfzCCDXFrMyBGEQpCXsKlf
	c6Y9KjnyNJjX6WN3vqgQwHFE+PvoEC9yVD4vNNjwQrkNUYbRxOyWhLGSF5eXy/UAvItR+vKLkoB
	12IZBtlsRQ/tp9QVxgr5kQh/gX2WTu+AYHq2OXX+pcWORAARDa78Ws4TTZo5GuiNdiIvV0lTTKT
	YlZAZ+DEPsjDfOwrO5PWrQMbDx5ZRL5OenyBmKJY808LjT0RXu0037PAlnNGYNVHXM9IaAwGyVy
	NIdIMbDlgkGlFaPMIrQacIgJGhGF0WUe33Zvyy08iqV2R7EFHoZyD7dERg==
X-Received: by 2002:a17:907:9619:b0:c26:207d:8a8f with SMTP id
 a640c23a62f3a-c296668c70amr682570866b.27.1789322057580; Sun, 13 Sep 2026
 10:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907153713.2572547-10-coiaprant@gmail.com> <20260912201330.127164-1-kuba@kernel.org>
In-Reply-To: <20260912201330.127164-1-kuba@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Mon, 14 Sep 2026 01:54:06 +0800
X-Gm-Features: AcwNN1Ucyb3gV5K7ZLOVIG2XPGoU4DT98Q4QVU-FLrVaSsRTeWCQtGOJbGry1ZQ
Message-ID: <CALj3r0j8hLRfvhtJZ19XYu0+EMYKRkV9KTy2us_z7896egZ-kw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/10] net: stmmac: dwmac-rk: add SGMII
 support for RK3568
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
> net: stmmac: dwmac-rk: add SGMII support for RK3568
>
> This adds SGMII glue for RK3568: a set_to_sgmii() callback that programs
> GMAC CON1 bit 7, pcs_init/pcs_exit/select_pcs callbacks that create the
> Rockchip XPCS from the "pcs-handle" phandle, and a rework of the
> rk_gmac_powerup() error unwinding into a single clk_disable label.
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 386)
>
> A few questions below.
>
> > While at it, fix the clock enable ordering in rk_gmac_powerup():
> > gmac_clk_enable() is now called before any register access, including
> > the SGMII mode setup path.  Previously SGMII mode would bypass the
> > clock enable via a goto, which could cause synchronous external abort
> > when accessing MAC registers with the clock domain disabled.
>
> [Severity: Low]
> Does this paragraph describe the baseline?  At 879e280b8486 there is no
> SGMII case and no goto in rk_gmac_powerup(), and the order is already:
>
>         ret =3D rk_get_phy_intf_sel(bsp_priv->phy_iface);
>         if (ret < 0)
>                 return ret;
>         intf =3D ret;
>
>         ret =3D gmac_clk_enable(bsp_priv, true);
>         if (ret)
>                 return ret;
>         ...
>                 ret =3D rk_write_gmac_grf_reg(bsp_priv, val);
>
> so gmac_clk_enable() already preceded every register access and there was
> nothing that could bypass it.  The change here is a pure reorder ahead of
> rk_get_phy_intf_sel(), which touches no registers, plus the new unified
> unwind label.
>
> Would it be more accurate to describe this as preparing the ordering for
> the new SGMII path rather than as a fix for a synchronous external abort?

You're right. The baseline already had gmac_clk_enable() before any
register access. This change is a reorder to prepare for the new SGMII
path that skips rk_get_phy_intf_sel(), not a fix for a pre-existing
SError. I'll correct the wording.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 8d7042e689261..e47ca1bec5b8b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>
> [ ... ]
>
> > @@ -809,6 +813,8 @@ static const struct rk_gmac_ops rk3528_ops =3D {
> >  #define RK3568_GRF_GMAC1_CON1                0x038c
> >
> >  /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
> > +#define RK3568_GMAC_MODE_RMII_RGMII          GRF_CLR_BIT(7)
> > +#define RK3568_GMAC_MODE_SGMII_QSGMII                GRF_BIT(7)
> >  #define RK3568_GMAC_FLOW_CTRL                        GRF_BIT(3)
> >  #define RK3568_GMAC_FLOW_CTRL_CLR            GRF_CLR_BIT(3)
> >  #define RK3568_GMAC_RXCLK_DLY_ENABLE         GRF_BIT(1)
> > @@ -851,18 +857,32 @@ static void rk3568_set_to_rgmii(struct rk_priv_da=
ta *bsp_priv,
> >                    RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
> >
> >       regmap_write(bsp_priv->grf, con1,
> > +                  RK3568_GMAC_MODE_RMII_RGMII |
> >                    RK3568_GMAC_RXCLK_DLY_ENABLE |
> >                    RK3568_GMAC_TXCLK_DLY_ENABLE);
> >  }
> >
> > +static void rk3568_set_to_sgmii(struct rk_priv_data *bsp_priv)
> > +{
> > +     u32 con1;
> > +
> > +     con1 =3D (bsp_priv->id =3D=3D 1) ? RK3568_GRF_GMAC1_CON1 :
> > +                                  RK3568_GRF_GMAC0_CON1;
> > +
> > +     regmap_write(bsp_priv->grf, con1, RK3568_GMAC_MODE_SGMII_QSGMII);
> > +}
> > +
> >  static const struct rk_gmac_ops rk3568_ops =3D {
> >       .init =3D rk3568_init,
> >       .set_to_rgmii =3D rk3568_set_to_rgmii,
> > +     .set_to_sgmii =3D rk3568_set_to_sgmii,
> > +
> >       .set_speed =3D rk_set_clk_mac_speed,
> >
> >       .gmac_phy_intf_sel_mask =3D GENMASK_U16(6, 4),
> >
> >       .supports_rmii =3D true,
> > +     .supports_sgmii =3D true,
>
> [Severity: Medium]
> Who clears CON1 bit 7 for RMII on rk3568?
>
> rk3568_set_to_rgmii() now explicitly writes RK3568_GMAC_MODE_RMII_RGMII,
> which shows bit 7 has to be programmed by the driver.  rk3568_ops declare=
s
> supports_rmii =3D true but has no .set_to_rmii, so the RMII branch of
> rk_gmac_powerup() is a no-op:
>
>         case PHY_INTERFACE_MODE_RMII:
>                 dev_info(dev, "init for RMII\n");
>                 if (bsp_priv->ops->set_to_rmii)
>                         bsp_priv->ops->set_to_rmii(bsp_priv);
>                 break;
>
> and the generic GRF write uses gmac_phy_intf_sel_mask =3D GENMASK_U16(6, =
4),
> whose write-enable half-word never covers bit 7.
>
> Since rk3568_set_to_sgmii() leaves bit 7 set persistently and nothing in
> rk_gmac_powerdown() restores it, can an RMII port come up muxed to the
> SerDes when bit 7 was left set by firmware or by a previous SGMII
> configuration of the same MAC (kexec, warm reboot)?  The probe would repo=
rt
> success while the link never works.

Good catch. rk3568_ops declares supports_rmii but has no .set_to_rmii,
so the RMII branch is a no-op. If bit 7 was left set by SGMII or
firmware, an RMII port would be muxed to the SerDes.

I'll add rk3568_set_to_rmii() that explicitly clears bit 7, and wire it
up in rk3568_ops.

Since we set set_to_rmii and set_to_sgmii, supports_rmii and supports_sgmii
will be omitted.

> > +static int rk_pcs_init(struct stmmac_priv *priv)
> > +{
> > +     struct device_node *np =3D priv->device->of_node;
> > +     struct device_node *pcs_node;
> > +     struct dw_xpcs *xpcs;
> > +
> > +     pcs_node =3D of_parse_phandle(np, "pcs-handle", 0);
> > +     if (!pcs_node)
> > +             return -ENODEV;
>
> [Severity: Low]
> Should "pcs-handle" be documented in the Rockchip MAC binding?
>
> This makes the property effectively mandatory for phy-mode =3D "sgmii" on
> RK3568: a missing phandle returns -ENODEV, and stmmac_pcs_setup() turns
> that into a probe failure:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_pcs_setup() {
>         ret =3D priv->plat->pcs_init(priv);
>         if (ret)
>                 return dev_err_probe(priv->device, ret, "No xPCS found\n"=
);
> }
>
> Documentation/devicetree/bindings/net/rockchip-dwmac.yaml does not mentio=
n
> pcs-handle at all - it is neither described nor conditionally required fo=
r
> the SGMII-capable compatibles - while the new
> Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml says the
> port "is linked to an Ethernet MAC controller via the pcs-handle property
> in the MAC's device tree node".  Other stmmac glue bindings that parse th=
is
> property describe it (renesas,rzn1-gmac.yaml, renesas,rzv2h-gbeth.yaml).
> Could the MAC binding be updated to match?

You're right, rockchip-dwmac.yaml should describe pcs-handle, since the
driver now requires it for phy-mode =3D "sgmii". I'll add it to the MAC
binding.

> > @@ -1379,16 +1441,19 @@ static int rk_gmac_powerup(struct rk_priv_data =
*bsp_priv)
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D gmac_clk_enable(bsp_priv, true);
> > +     if (ret)
> > +             return ret;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the bare return here canno=
t
> unwind a partially enabled clock domain.  gmac_clk_enable() leaks the bul=
k
> clock references when the PHY clock fails:
>
> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:gmac_clk_enable() {
>                         ret =3D clk_bulk_prepare_enable(bsp_priv->num_clk=
s,
>                                                       bsp_priv->clks);
>                         if (ret)
>                                 return ret;
>
>                         ret =3D clk_prepare_enable(bsp_priv->clk_phy);
>                         if (ret)
>                                 return ret;
>         ...
>                         bsp_priv->clk_enabled =3D true;
> }
>
> The second failure path returns without clk_bulk_disable_unprepare() and
> without setting clk_enabled, so the new clk_disable label,
> rk_gmac_powerdown() and the suspend path are all no-ops afterwards becaus=
e
> the disable branch is gated on clk_enabled.  Does this leave the bulk
> clocks prepared and enabled for the lifetime of the system?

This is a pre-existing bug, not introduced by this patch. The second
failure path returns without clk_bulk_disable_unprepare() and without
setting clk_enabled, so the new clk_disable label cannot unwind it.
It should fix it as a separate small patch.

> > @@ -1486,6 +1557,9 @@ static void rk_get_interfaces(struct stmmac_priv =
*priv, void *bsp_priv,
> >
> >       if (rk->supports_rmii)
> >               __set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
> > +
> > +     if (rk->supports_sgmii)
> > +             __set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
> >  }
>
> [Severity: Medium]
> Is the SGMII advertisement here consistent with where the PCS is installe=
d?
>
> supports_sgmii is true for every rk3568 instance regardless of DT, so SGM=
II
> always lands in phylink_config.supported_interfaces.  The PCS plumbing,
> however, is only installed when the DT phy-mode is exactly SGMII (see the
> rk_gmac_probe() hunk below).
>
> On an RK3568 board with phy-mode =3D "rgmii"/"rmii", phylink can still pi=
ck
> SGMII - phylink_validate_phy() intersects phy->possible_interfaces with
> config->supported_interfaces - and then:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_mac_select_pcs()=
 {
>         if (priv->plat->select_pcs) {
>                 pcs =3D priv->plat->select_pcs(priv, interface);
>                 if (!IS_ERR(pcs))
>                         return pcs;
>         }
> }
>
> returns NULL because select_pcs is unset, no XPCS was ever created
> (pcs_init is NULL), and rk_gmac_powerup() has already programmed the GRF
> once from the DT-derived bsp_priv->phy_iface, so rk3568_set_to_sgmii() ne=
ver
> ran.  Would gating the SGMII bit on the same condition that installs
> select_pcs/pcs_init keep the two in agreement?

The phy-mode is fixed by the device tree and does not change at runtime.

rk_gmac_powerup() programs the GRF according to bsp_priv->phy_iface, which
is derived from phy-mode, not from supported_interfaces. So advertising
SGMII in supported_interfaces does not cause the MAC to switch to SGMII on
an RGMII board.

This is the same as the existing handling for RGMII and RMII, which are
also advertised unconditionally when the SoC supports them. There is no
inconsistency introduced by this patch.

> >  static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
> > @@ -1602,6 +1676,17 @@ static int rk_gmac_probe(struct platform_device =
*pdev)
> >       plat_dat->suspend =3D rk_gmac_suspend;
> >       plat_dat->resume =3D rk_gmac_resume;
> >
> > +     if (plat_dat->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
> > +             /* SGMII clock always runs at 125 MHz */
> > +             plat_dat->set_clk_tx_rate =3D NULL;
> > +
> > +             /* SGMII requires a PCS */
> > +             plat_dat->default_an_inband =3D true;
>
> [Severity: Medium]
> Does default_an_inband guarantee in-band mode here?
>
> include/linux/phylink.h describes it as a default that "a fixed-link
> specification will override", and phylink has two ways out of in-band:
>
> drivers/net/phy/phylink.c:phylink_parse_mode() {
>         dn =3D fwnode_get_named_child_node(fwnode, "fixed-link");
>         if (dn || fwnode_property_present(fwnode, "fixed-link"))
>                 pl->cfg_link_an_mode =3D MLO_AN_FIXED;
> }
>
> drivers/net/phy/phylink.c:phylink_pcs_neg_mode() {
>                         neg_mode =3D PHYLINK_PCS_NEG_OUTBAND;
>                         if (pl->phydev)
>                                 mode =3D MLO_AN_PHY;
> }
>
> With set_clk_tx_rate cleared, stmmac_mac_link_up() then programs no rate =
at
> all:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_mac_link_up() {
>         if (priv->plat->set_clk_tx_rate) {
>                 ret =3D priv->plat->set_clk_tx_rate(priv->plat->bsp_priv,
>                                                 priv->plat->clk_tx_i,
>                                                 interface, speed);
> }
>
> So for phy-mode =3D "sgmii" with a fixed-link node, or with a PHY that ca=
nnot
> do in-band signalling, the fixed 125 MHz clock is used at 10/100 Mbps -
> which the commit message says gives working TX and failing RX.  Should th=
e
> driver reject out-of-band SGMII explicitly instead of relying on the
> default?

You're right. default_an_inband can be overridden by fixed-link, and
phylink can fall back to outband if the PHY cannot do in-band. With
set_clk_tx_rate =3D NULL, the MAC clock must stay at 125 MHz for 10/100
Mbps, otherwise the TX-works-RX-fails behaviour described in the
changelog occurs.

I will document the in-band-only limitation in the changelog.

Thanks,
Coia
