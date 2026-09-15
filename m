Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5A37FF50
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472579; cv=pass; b=SJXgwPVTGZgC1RJ23ehaCHlcm5lYzcyqwh3PYpPkV23x7tNlpWLJbNgLg9XwzctpX2Pi3+cn5El+zFpi1jBwLZs7H0ukT4AmR1uNnaDbYuMu86W5iHmkYISu8Mygqjdz5J2oATH75+9mDQjUhbcFf29Nj3+1LNewoIAHdH6t85o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472579; c=relaxed/simple;
	bh=77e1MGS6kCVnU1RufO4elxUOHjBahuFZ5h+/Df65DfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnykL9nya0dGyX0DvwygZ0/N+3dWzPsnApqpdCZOZZLbyQ5m4PxKd2Bhw/PNTxJfd5BdEIY1l8I2/aoZPv/vx87Rg6qVkWME3eejSoqd5inC1oSnd0f6OeNkQfBt9IQbqSJG2+h/2BzRIu5Uvpa/pNr2WBcEgFpn/De5EmxWQQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flw/goM4; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flw/goM4"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c299e97dc0aso105259566b.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789472575; cv=none;
        d=google.com; s=arc-20260327;
        b=jJruowOYsToK//z26KbO+jSa6YK2Cw2/nW/raX9cTJsSVZ1rbfGcCONs/RCnh/Ob58
         XSEvzDf5T6ufC5RMKAM9DG+XZyMaA7qnH3oPlzUbKSt1mJAtnS7+T0sl7LSLB2bR0S0q
         nXOlixrxYADoqHbIxkkisGhTVvuyv4xoOntffI1J4eSwT0tSeqKxEOKd7H7GIXWGEsvS
         GTnAApoK4yoCsLlrvxgHDhL7ai7VuzX5KPkavl4ss3TFGyCznN2C26M+eEvEgyRcDgvF
         3mMvFTvHPkO7+skiyluz3mmVpF7VJ3q8dLa5JGSFfswV29A+x7XHIbOhCa54W7H2bcui
         7f3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sISzfPmgoaQUIHyBbaL9mtqCySms90Uh3lkhXDJB000=;
        fh=27Eh4wqaEhRvOJ8jtq/4YBIn2FnHAlG7xCwc1B7WqQI=;
        b=NoTi/yQij/5JpFSRYu8i/Rs0KasQwj9SQ5diNHxVet9QB664Pnbrqyo7GSbBHCP6pp
         gDVBiTbrLvtcJ5pBP53shlpuZZUErv+oSISnxgyRDrZCzmKm2jCTCFUjWgmejhX6NFi5
         Us/flcyEs49pEQdKVroOUm5ou2K4530gU7wwkKqZp3ko7sPXmp03JjWmPyyFqBJ6M41D
         CkdyJ1pY9tn9p+EizxKXcP9ozFMVAGFFR4aFfaovGl8f83w6Amjte6G9s55IBSTJOGbi
         cPF2NbrlMb9qyN90huVwepPyyi/sJSUTrxFSS3VeNwPjqw5yfKh7ZmFdl/ytROmsZKvz
         shOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789472575; x=1790077375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sISzfPmgoaQUIHyBbaL9mtqCySms90Uh3lkhXDJB000=;
        b=flw/goM4CH254An4AqOe5VAybccWqXCz9qcK115/iQf2ZGNoyTQyvqGFYqW9GCvVD2
         hEpCnk07JZ5RxXaAJWh9WMtR2l8bXv1YMxtEawbelzrUYC/ALYUBy6FQY9L0CfZMAeuu
         12zpGNgsARfdE2D1xARA3y05K/cekPxzDNggByfeKFT20n72pjtz8KWkL046vaGjJABd
         EfM5EfqrlgXSMQW+5LQPoia34DEQNlJqyFGZwAsNCboU6p57cQ7VjkKplIgrhyKv3wxg
         +A4ZJ6y+TmWol0l2ULy8zr9yLBgl3DxQwFI8D0IOpcRyVuNbETjtFhCADzwWEXLiDloE
         gwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472575; x=1790077375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sISzfPmgoaQUIHyBbaL9mtqCySms90Uh3lkhXDJB000=;
        b=xPFeVIk7lmIqaeFSN/iPP3B1fjCc3312VcV0BDksR3FMe9a4FjKtCikLqvXRxFVJRk
         rcqXKcs8TaC6Ep5fFrs62xK7k/NJUlR5jqFOEtLKA2XXRCAjRVyJF0AcpGrm6JL41qGt
         LEs2fa5QZtx/5UqxmOGLLOnIsOhY8k3eyKTcdZr5LOmClwmN39Rt9xWZ4+KwevIQpegH
         R1JrLJfnvSbqZHFUBnF7L5zgI96m4UiwA9d0sbtcR7PL2uAhYa4fbPJ3rmiVRq1Xbzz7
         2FR2vU7158M2NTBfkz6gI15hnxkcYTlnFL4VlKyNEDQFSKLCRI9a9MMDWk2kNiyF7Jw6
         HMsg==
X-Forwarded-Encrypted: i=1; AKwUvBxM5/4vWYCZ9VJNTm/3h4WfvZ/0FSbboZuW4FMXV9YPFalDQK8GXCnLyvMxTNpwNgoYI48ZwnA=@vger.kernel.org
X-Gm-Message-State: AFuF++kwKbqxNvlacfBKMNfg9sYVwBXJnSKs39XzuZeQr/277tYX6UNX
	a+ZrzmwOglDw5fYIouw9NHe0i6Fa7e9lttVUPibV4yM8HqBnb1dHwL/SCGzj1gGd96WUlo2FmEk
	nrZjX1Brwz6ypzFC3a9EWJOMjk7fqYzs=
X-Gm-Gg: AYBFou2sdq/nqhglYLblM8D07yuoyHXPSEV3QnbF009eYXR1I7PprSOu5URHxp0BS4z
	IikVgi3kCxmIIjGEMBid/sO5vBojap0knVG2MHecAUCNYCt6wrwoUw7v0DhQ2n/5fYKYht4bpDd
	mUsiyNBN+ntBOouROcEiUYq0SLEPERTTvoO3L8zpzCsazDYnp6+iM/Q0yY3YFUpTxcYI/zYU3ac
	n63SySCFlpO+TBi1V9wYB/X2qvSXELCcsIiRhI27I45aue/Zbb9wXDoHYujz0Oivn/xJvVJShFW
	tp0ZuTDxULid0heAsYdURO4aYVqhEh7rCaB8OnlCY9Jiq2tvOdA6sOIR/A==
X-Received: by 2002:a17:906:7954:b0:c24:b11a:470f with SMTP id
 a640c23a62f3a-c29b7ff89aemr908365266b.0.1789472574755; Tue, 15 Sep 2026
 04:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913185849.907479-10-coiaprant@gmail.com> <178941749179.22033.3182687831989800376@kernel.org>
In-Reply-To: <178941749179.22033.3182687831989800376@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 15 Sep 2026 19:42:42 +0800
X-Gm-Features: AcwNN1XJ2v3mnflu7VzToAP_PI-o155G_VpQm1Am3WUv52DDebpEcVrTsTiWOeY
Message-ID: <CALj3r0giNFp6CLWW0dAXu=iSkNm2rYZb4=KUfnAbPaFDeYSUPw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/11] net: stmmac: dwmac-rk: add SGMII
 support for RK3568
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
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 3
>
> - [Medium] DWMAC_ROCKCHIP gains an unconditional `select
>   PCS_XPCS_ROCKCHIP` without inheriting the selected symbol's=E2=80=A6
> - [Medium] For SGMII the driver removes every speed-dependent clock
>   programming path (rk_gmac_probe() sets plat_dat->set_clk_tx_rate =3D=E2=
=80=A6
> - [Low] rk_get_interfaces() (dwmac-rk.c:1570-1571) now sets
>   PHY_INTERFACE_MODE_SGMII in phylink's supported_interfaces for every=E2=
=80=A6
> - [Low] The RK3568 XPCS SoC node added by the series ('arm64: dts:
>   rockchip: rk3568: add XPCS and fixed-clock nodes') omits properties=E2=
=80=A6
> - [Low] rk_select_pcs() (dwmac-rk.c:1268-1275) ignores its `interface`
>   argument and returns the SGMII XPCS for every interface mode,=E2=80=A6
>
> Pre-existing issues:
> - [Medium] DISCARDED (valid but pre-existing and below the reporting
>   threshold for pre-existing defects).
>
> --
>
> net: stmmac: dwmac-rk: add SGMII support for RK3568
>
> Adds a set_to_sgmii()/set_to_rmii() pair for rk3568 to program GRF bit 7,
> wires up pcs_init/pcs_exit/select_pcs so the Rockchip XPCS is used as the
> PCS, and reorders rk_gmac_powerup() so the clocks are enabled before the
> interface-specific configuration.
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 386)
>
> A few questions below.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/=
ethernet/stmicro/stmmac/Kconfig
> > index ab3c4cf964239..c6559e749c0ce 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -170,6 +170,7 @@ config DWMAC_ROCKCHIP
> >       default ARCH_ROCKCHIP
> >       depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
> >       select MFD_SYSCON
> > +     select PCS_XPCS_ROCKCHIP
>
> [Severity: Medium]
> Does this select produce unmet dependency warnings?  PCS_XPCS_ROCKCHIP in
> drivers/net/pcs/Kconfig carries three dependency lines:
>
>   config PCS_XPCS_ROCKCHIP
>         tristate "Rockchip XPCS controller support"
>         default ARCH_ROCKCHIP
>         depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
>         depends on GENERIC_PHY || COMPILE_TEST
>         depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>
> while DWMAC_ROCKCHIP only has "depends on OF && (ARCH_ROCKCHIP ||
> COMPILE_TEST)".  ARCH_ROCKCHIP in arch/arm64/Kconfig.platforms selects PM
> but neither GENERIC_PHY nor PM_GENERIC_DOMAINS, so a config with
> ARCH_ROCKCHIP=3Dy, COMPILE_TEST=3Dn and GENERIC_PHY=3Dn (or PM_GENERIC_DO=
MAINS=3Dn)
> force-enables PCS_XPCS_ROCKCHIP with its own depends unsatisfied:
>
>   WARNING: unmet direct dependencies detected for PCS_XPCS_ROCKCHIP
>
> pcs-xpcs-rk.o is then built against the phy stubs where devm_phy_get()
> returns ERR_PTR(-ENOSYS), so the probe cannot succeed.
>
> The select is also unconditional, so every Rockchip dwmac build
> (RK3288/RK3328/RK3399/RK3588 ...) force-enables the RK356x-only XPCS
> driver.  Would inheriting the constraints, or making the selection
> conditional, be preferable here?  Note that simply adding the two depends
> lines to DWMAC_ROCKCHIP would turn off Ethernet on existing RK3288/RK3399
> configurations, so the choice probably needs to be explicit.
>
> The Kconfig change is also not mentioned anywhere in the commit message.

You're right. I'll move the dependencies into PCS_XPCS_ROCKCHIP as
selects instead of depends on:

    config PCS_XPCS_ROCKCHIP
        tristate "Rockchip XPCS controller support"
        default ARCH_ROCKCHIP
        depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
        select GENERIC_PHY
        select PM_GENERIC_DOMAINS

This way the symbol pulls in its own dependencies when it is selected
by DWMAC_ROCKCHIP, so the unconditional select in dwmac-rk does not
produce an unmet-dependency warning.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 8d7042e689261..5d501ed8d1429 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>
> [ ... ]
>
> > @@ -1208,6 +1237,43 @@ static void rk_phy_powerdown(struct rk_priv_data=
 *bsp_priv)
> > +static struct phylink_pcs *rk_select_pcs(struct stmmac_priv *priv,
> > +                                      phy_interface_t interface)
> > +{
> > +     if (!priv->hw->xpcs)
> > +             return NULL;
> > +
> > +     return xpcs_to_phylink_pcs(priv->hw->xpcs);
> > +}
>
> [Severity: Low]
> Should rk_select_pcs() look at its interface argument?  The mac_select_pc=
s
> contract in include/linux/phylink.h is to return the PCS for the specifie=
d
> interface, or NULL when none is required, but this returns the SGMII XPCS
> for any mode.
>
> On an RK3568 port probed as SGMII, rk_get_interfaces() also advertises th=
e
> RGMII variants and RMII, and xpcs->pcs.supported_interfaces is non-empty
> (filled in by xpcs_get_interfaces()).  When phylink validates one of thos=
e
> non-SGMII interfaces, phylink_validate_mac_and_pcs() hits:
>
>         if (!phy_interface_empty(pcs->supported_interfaces) &&
>             !test_bit(state->interface, pcs->supported_interfaces)) {
>                 phylink_err(pl, "MAC returned PCS which does not support =
%s\n",
>                             phy_modes(state->interface));
>                 return -EINVAL;
>         }
>
> Would returning the XPCS only for PHY_INTERFACE_MODE_SGMII and NULL
> otherwise avoid that error path?

plat_dat->select_pcs is only assigned inside the
if (phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII) branch of
rk_gmac_probe(). For RGMII/RMII ports the callback is NULL, so
stmmac_mac_select_pcs() returns NULL before reaching rk_select_pcs().

On an SGMII port, phylink_validate() is called with
state->interface =3D PHY_INTERFACE_MODE_SGMII, so only SGMII is
validated against the PCS. The RGMII/RMII bits in supported_interfaces
are not iterated in this path.

> > @@ -1379,16 +1450,19 @@ static int rk_gmac_powerup(struct rk_priv_data =
*bsp_priv)
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D gmac_clk_enable(bsp_priv, true);
> > +     if (ret)
> > +             return ret;
> > +
> [Severity: Medium]
> This isn't a bug introduced by this patch, but now that gmac_clk_enable()
> is the first resource acquisition in rk_gmac_powerup(), its partial-failu=
re
> path becomes more visible.  Do the bulk clocks leak when the clk_phy enab=
le
> fails?
>
> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:gmac_clk_enable() {
>         ...
>                 ret =3D clk_bulk_prepare_enable(bsp_priv->num_clks,
>                                               bsp_priv->clks);
>                 if (ret)
>                         return ret;
>
>                 ret =3D clk_prepare_enable(bsp_priv->clk_phy);
>                 if (ret)
>                         return ret;
>         ...
> }
>
> The second failure returns without calling clk_bulk_disable_unprepare() a=
nd
> without setting bsp_priv->clk_enabled, so the later gmac_clk_enable(bsp_p=
riv,
> false) in rk_gmac_powerdown() and at the new clk_disable label is a no-op
> because it is gated on clk_enabled.  This only triggers for integrated-PH=
Y
> setups where clk_phy is non-NULL.

This is pre-existing and unrelated to SGMII.

> > +     if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_SGMII)
> > +             goto set_mode;
> > +
> >       ret =3D rk_get_phy_intf_sel(bsp_priv->phy_iface);
> >       if (ret < 0)
> > -             return ret;
> > +             goto clk_disable;
>
> [ ... ]
>
> > @@ -1486,6 +1566,9 @@ static void rk_get_interfaces(struct stmmac_priv =
*priv, void *bsp_priv,
> >
> >       if (rk->supports_rmii)
> >               __set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
> > +
> > +     if (rk->supports_sgmii)
> > +             __set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
> >  }
> [Severity: Low]
> Is SGMII safe to advertise on a port that was not probed as SGMII?
> rk3568_ops populates set_to_sgmii unconditionally, and rk_gmac_setup()
> derives supports_sgmii from it, so every RK3568 port now advertises SGMII
> in phylink's supported_interfaces (stmmac_phy_setup() copies the
> get_interfaces() output verbatim into config->supported_interfaces).
>
> All the SGMII setup, though, is keyed off the probe-time DT phy-mode:
>
>   - rk_gmac_powerup() writes RK3568_GMAC_MODE_SGMII_QSGMII only in the
>     "case PHY_INTERFACE_MODE_SGMII:" branch, which runs once at init
>   - rk_gmac_probe() installs pcs_init/pcs_exit/select_pcs,
>     default_an_inband and clears set_clk_tx_rate only under
>     "if (plat_dat->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII)"
>
> So on a port probed as rgmii*/rmii, if phylink later selects SGMII (SFP
> cage, or a PHY reporting SGMII as its host interface), GRF bit 7 stays
> cleared by rk3568_set_to_rgmii()/rk3568_set_to_rmii(), plat->select_pcs i=
s
> NULL so stmmac_mac_select_pcs() returns NULL and there is no PCS to run
> autonegotiation.  Before this patch SGMII was not in supported_interfaces
> and such a configuration was rejected during validation.  Would gating th=
e
> __set_bit() on the probe-time interface be closer to what the hardware ca=
n
> actually do?

phylink_create() receives the DT phy-mode as iface, and
phylink_validate() validates that fixed interface, not every bit in
supported_interfaces. The GRF is programmed from bsp_priv->phy_iface
in rk_gmac_powerup(), which is also the DT phy-mode. Advertising SGMII
in supported_interfaces does not change the interface mode at runtime.

> > @@ -1602,6 +1685,17 @@ static int rk_gmac_probe(struct platform_device =
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
> [Severity: Medium]
> The commit message says:
>
>   "Enable default_an_inband for SGMII and disable the generic stmmac
>    set_clk_tx_rate callback.  This forces phylink to use in-band mode,
>    where the PCS is responsible for speed/duplex negotiation."
>
> Is "forces" accurate?  default_an_inband is only a default, and the next
> paragraph of the message says so itself.  In phylink_parse_mode():
>
>         if (pl->config->default_an_inband)
>                 pl->cfg_link_an_mode =3D MLO_AN_INBAND;
>
>         dn =3D fwnode_get_named_child_node(fwnode, "fixed-link");
>         if (dn || fwnode_property_present(fwnode, "fixed-link"))
>                 pl->cfg_link_an_mode =3D MLO_AN_FIXED;
>
> and xpcs_inband_caps() advertises out-of-band as acceptable:
>
>         case DW_AN_C37_SGMII:
>         case DW_AN_C37_1000BASEX:
>                 return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
>
> so phylink_pcs_neg_mode() can settle on PHYLINK_PCS_NEG_OUTBAND for a
> fixed-link node or a PHY without in-band support.  With set_clk_tx_rate s=
et
> to NULL, rk3568_ops.set_speed =3D rk_set_clk_mac_speed also becomes
> unreachable, so a 10/100 Mbps link is brought up with the clocking left a=
t
> the 1 Gbps setting and nothing warns or fails.  Would rejecting a
> non-inband neg_mode (for example in mac_config or pcs_validate), or faili=
ng
> probe when a fixed-link node is present for SGMII, match what the message
> describes?

The v5 commit message already notes that default_an_inband can be
overridden by a fixed-link node, and that out-of-band SGMII is not
supported by this driver.

> One more observation on the series rather than on this patch: the new
> binding Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.ya=
ml
> lists phys and phy-names in its unconditional required list, but the
> ethernet-pcs@fda00000 node added to arch/arm64/boot/dts/rockchip/rk3568.d=
tsi
> supplies only reg, clocks, clock-names and power-domains.  Only
> rk3568-photonicat.dts adds them:
>
>   &xpcs {
>         phys =3D <&combphy2 PHY_TYPE_SGMII>;
>         phy-names =3D "serdes";
>         status =3D "okay";
>   };
>
> [Severity: Low]
> Does dtbs_check report "phys is a required property" for the other RK3568
> board DTBs?  dtschema validates nodes regardless of status =3D "disabled"=
.
> The neighbouring sata0 node in the same dtsi does carry phys/phy-names at
> SoC level, so would moving them into rk3568.dtsi be an option?

As replied earlier, the SerDes connection is board-specific and cannot
move into the SoC dtsi. dtbs_check skips required-property validation
for status =3D "disabled" nodes.
