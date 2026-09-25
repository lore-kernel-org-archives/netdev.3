Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582238B12F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790310717; cv=pass; b=WbG1XHCz88khM/GYveXU4/1XE9b6uLICDTiU9+8gfH+rmK+R1ciUygIf6YQiU+i5FlvJG84FO1w7WEQdJwGPVCVGi0B38S58KQJyyhMyx/KJVMgPp/hZdSI0SmTPc0AfAE0n2t4uNgHxLEczm9Qjxqy1v9ZdF4T1Od2wy9BmUbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790310717; c=relaxed/simple;
	bh=bKcBxxTsghoqMHyafZwepzf6RtFX/VymNrBL22MAUE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCb/lZfXSYZPWEj+80Cqz/TThDhRLf9iewSpu3rATubl/8oidl9vU7euKcBymv7P8gWXv/EHFgKCK0eoSvhdGwcSdZvt0/7wfX7ae035qjEThBURGwxY6pZfVaH5lLoBtlPBLc9t61jusHpwS83g4orFunLG25Kbzkg7gAbPSgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biHxw4vz; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biHxw4vz"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c294938a983so17205666b.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790310712; cv=none;
        d=google.com; s=arc-20260327;
        b=SxJSQcx7vzwCalNsWd2X4h9WpNTTPEIM3Cm6Dua9QjU+oOI3fKcVA0ZPlvvd++4d4M
         dkAwsMULrprBzp4/N6uSNgxM0D6sEptx3GK3aXVaNTSKXPEOXnaDHsx/40+xqteXD2yF
         qkwJ/lRRjIBXVaLJBZN9PF4qmQxY3Y/Wwi35V+eNg3YpXFcVNJa8sFJX1sLt3PfOlH1l
         uH/ccnOt8qINDt6JelkbTLhjAREarx6OBxhSt3gbAqyxTmUWND8k0XbkbQeiF/Ajwq8L
         ydEl659MkeyxhqTzGkF0cqMZ9RJgOKrfInnnbYxElkgqsp7BQ7UxYBr0ys2w2fQPmhwu
         wkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TNCXrCGsdTEIc304eZ6sG3kavghRL8koSeqoFiVhQaw=;
        fh=W3B1j6Wm5hlrl57VwY+w2vW+En+blpmDnSmPazc0Jk8=;
        b=FoZNl4wdUjye0Usuj53XpOVq0cEYebUbnZ8y6fBYx1Tw3/qXOTjNcJGn3agSVYyAns
         q5RREvn1oRdb5k6wboCan9qcU4luJyg5fZhozIYk7G1Pbt0S2On3Bvl4xKwDXewQ2xKe
         p3p1J6ZMX37l4kNG0Oy8lNTg5+pRrRilzS+2/xfsiVUHnJ6jbg2P6jp16U0k/5ibZlZZ
         Ml0f+z8eBll/Cc562AoiKoxnXym22mE7vV70sJU+86Yoe13U0I93q9CmHfWDuHsZm+oH
         yJINtl7DUImicNCWVdVQwsWrr85NZU9Z3EmqMdT+TGqFXLZRnRJN8H+DqtDIhxCnGfr6
         N2rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790310712; x=1790915512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNCXrCGsdTEIc304eZ6sG3kavghRL8koSeqoFiVhQaw=;
        b=biHxw4vzKzUMDWrib41dTAVXYt7h5mMZCT/9+YZYvcXrfwD4ZoIvmuI9WRlkQWRN7N
         slIdmCrKRdN1owq2laQLISNABFx6H3r/hxVtkzqp2iBdCFttbGE8XfRGdcj3OzuwVZuB
         jNkqeonksW4iXbECQwarWZAUEnKopZy0VokA3zamCtiF3Ay3K1ATz6S+f9FzJim62urV
         p1wcpcIY2EQI/3dDuqv1CGRKIMEKH7UwzRSGDrn6bXjbq45ESsYJlzUSDN/xUpVghDc6
         rxpn+Gfxil1LYAcxh64+EYEt/tOIS9WImOWpAG9AunNnOqWxLh5Q6Jn2Tp/twGBYufPq
         vVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790310712; x=1790915512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNCXrCGsdTEIc304eZ6sG3kavghRL8koSeqoFiVhQaw=;
        b=b050/GeoQ35L7CSZz0xGZXObhtjmBAdv844M/Q1zohBFYE+to52iAt3LIPGhinF3vL
         qz+PmIgg67ugEDeA1vtBhj8zbxv1drHTGycs32vGCHkDy0ilV5BZskLetnGORKzH5Vc0
         6539lTnHvXw5jZr2Umgf1fiWN1ss2A5YOeCYj9aYyP3+W/8U1GFJ3jigkZzw7UEIXOTY
         2jWaCuT98F1fWBGp+PEItP+OpvOd36/QcpxyTJCSh9ese7jW+YUfAH6k3cuJoBadXDGB
         uu5iL4RvmyRVTN7iYGdrwfikxd2FRjQpOwQmRxdECl5sfu6QmOFmABx3HgfkguHqIlVk
         xFPA==
X-Forwarded-Encrypted: i=1; AKwUvBwl5rE2cWDJzD8OGFWiG4XIHZJp6F4sMu1jJRGA8awXzEP9RRmHM3cVzDHREnRM3g2noxC9R04=@vger.kernel.org
X-Gm-Message-State: AFuF++k6l5vyf4YhShjEuLNZfENplqfrqbgWyMNNH10diykrOEg3KVyC
	wsj3Q5wFUHgh2HgThuwlfbjdSBoJFQNwFRXLrYWeQ8zYs4N4UCqLw9LH27E6IdFY793RirwuOPc
	XX7236MFPWz2ljVrj1JHwX66an4RrMIQ=
X-Gm-Gg: AYBFou1JP/ValXLz0ubJOfUkFmfVRu8x15VIErbhsd/i+nz6PXCXizww0/ihpYyUUHX
	GKBXoj5oi56O3yuYUj/kXBMCcPzA7OjnWHp9XXOWe4ObtrOFJrDmTBQRcqC/mIgfMOZ6GXMU0Cg
	bbQ2Dpa6VUGTncUSzXCdOfJC4KJ6nV0jETJDoDSXSsL3KraNzFdGO+ClWjOnM+njVEGilgWxVoW
	T1GyxN6EkrPlTd3r3HGLY3J45rdD+1AxaZEp7tsbsSWFDl5z/Dai1wldew3qa1tLIk8H/LUVRmW
	UxE6hVS1PhibgdU8u4INF0ulbgcM55o81xCAOfG1hWK8wwi3HATVE9kDfnNJNX1Bv6X1Xg==
X-Received: by 2002:a17:907:3f89:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c2ac23eb793mr381414366b.23.1790310712139; Thu, 24 Sep 2026
 21:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200336.2201212-10-coiaprant@gmail.com> <179030182602.2160803.7636364487893366164@kernel.org>
In-Reply-To: <179030182602.2160803.7636364487893366164@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 25 Sep 2026 12:31:40 +0800
X-Gm-Features: AclHuK-geYaCrQiIqbsqm9RqVt7-leTLevfj4XZTsxhgOEb2JIertLp2aoE5xzw
Message-ID: <CALj3r0hF_fwnA7Psp8kc8EqthS9FZr4LUkqGXDLtVHesw7tUvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 09/11] net: stmmac: dwmac-rk: add SGMII
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
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=BA=94 10:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (3) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In SGMII mode, the RK3568 glue tells phylink it supports
>   interface modes that the hardware cannot run and that the glue never=E2=
=80=A6
> - [Medium] The commit's explanation of the SGMII in-band vs out-of-band
>   problem does not match the code, and the driver does nothing to reject=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] rk_gmac_resume() (dwmac-rk.c:1618-1627) calls
>   rk_gmac_powerup() and throws away its return value, then always=E2=80=
=A6
> - [Medium] gmac_clk_enable(bsp_priv, true) (dwmac-rk.c:1181-1200) first
>   enables the bulk clocks with clk_bulk_prepare_enable() (line 1187).
> - [Medium] __stmmac_dvr_probe() calls pm_runtime_get_noresume(device) and
>   enables runtime PM (stmmac_main.c:8112-8115) before calling=E2=80=A6
>
> --
>
> net: stmmac: dwmac-rk: add SGMII support for RK3568
>
> This adds SGMII support for the RK3568 GMACs. It sets GRF bit 7 and
> hooks up the Rockchip XPCS through the pcs_init, pcs_exit and select_pcs
> callbacks. It also moves the clock enable in rk_gmac_powerup() earlier,
> unifies its error unwinding, and for SGMII clears set_clk_tx_rate and
> sets default_an_inband.
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 386)
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 8d7042e689261..88f09014e3a69 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>
> [ ... ]
>
> > @@ -1208,6 +1236,43 @@ static void rk_phy_powerdown(struct rk_priv_data=
 *bsp_priv)
> >               dev_err(bsp_priv->dev, "fail to disable phy-supply\n");
> >  }
> >
> > +static int rk_pcs_init(struct stmmac_priv *priv)
> > +{
> > +     struct device_node *np =3D priv->device->of_node;
> > +     struct device_node *pcs_node;
> > +     struct dw_xpcs *xpcs;
> > +
> > +     pcs_node =3D of_parse_phandle(np, "pcs-handle", 0);
> > +     if (!pcs_node)
> > +             return -ENODEV;
> > +
> > +     xpcs =3D xpcs_rk_create(priv->device, pcs_node);
> > +     of_node_put(pcs_node);
> > +     if (IS_ERR(xpcs))
> > +             return PTR_ERR(xpcs);
>
> [Severity: Medium]
> This is a pre-existing issue in the stmmac core, but this patch makes it
> much easier to hit. rk_pcs_init() returns -EPROBE_DEFER from
> xpcs_rk_create() whenever the XPCS device isn't bound yet. Does each of
> those deferrals leak a runtime PM usage count?
>
> __stmmac_dvr_probe() takes the reference before PCS setup:
>
>     pm_runtime_get_noresume(device);
>     pm_runtime_set_active(device);
>     if (!pm_runtime_enabled(device))
>         pm_runtime_enable(device);
>     ...
> error_pcs_setup:
>     stmmac_mdio_unregister(ndev);
> error_mdio_register:
>     stmmac_napi_del(ndev);
>
> None of the error labels drop that count or disable runtime PM.
> pm_runtime_reinit() returns early while runtime PM is enabled, so
> usage_count is never reset.
>
> fw_devlink doesn't parse pcs-handle, so the GMAC can probe before the
> XPCS. After the probe finally succeeds, the count can't reach zero, so
> the MAC would never runtime suspend.
>
> Deferral from stmmac_mdio_register() already hit this path before the
> patch, but deferral is now likely on RK3568 SGMII boards.

Agreed that this is a real problem, but it's in __stmmac_dvr_probe(),
not in dwmac-rk. The error labels in the core don't drop the count that
pm_runtime_get_noresume() took, and pcs-handle is not a fw_devlink
dependency so the deferral is now easier to hit. That should be fixed
in the stmmac core in a separate series. I'm not going to restructure
the core probe error paths as part of a platform glue patch.

> > +
> > +     priv->hw->xpcs =3D xpcs;
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > +static struct phylink_pcs *rk_select_pcs(struct stmmac_priv *priv,
> > +                                      phy_interface_t interface)
> > +{
> > +     if (!priv->hw->xpcs)
> > +             return NULL;
> > +
> > +     return xpcs_to_phylink_pcs(priv->hw->xpcs);
> > +}
>
> [Severity: Medium]
> Does this give phylink interface modes that the RK3568 hardware can't
> run?
>
> rk_get_interfaces() still sets RGMII and RMII, because rk3568_ops now
> has both set_to_rgmii and set_to_rmii. SGMII comes from the XPCS through
> stmmac_phylink_setup():
>
>     if (pcs)
>         phy_interface_or(config->supported_interfaces,
>                          config->supported_interfaces,
>                          pcs->supported_interfaces);
>
> xpcs_rk_create() uses the plain xpcs_create_mdiodev() and never narrows
> pcs.supported_interfaces. The set is therefore filled from the generic
> synopsys_xpcs_compat[] table: USXGMII, 10GKR, 25GBASER, XLGMII,
> 50GBASER, LAUI, 100GBASEP, 10GBASER, SGMII, 1000BASEX and 2500BASEX.
>
> The rockchip,rk3568-xpcs.yaml binding in this series says the hardware
> supports only 1000BASE-X, SGMII and QSGMII. The dwmac4 MAC caps include
> MAC_2500FD, so phylink keeps 2500BASE-X and USXGMII as valid choices.
>
> rk_select_pcs() also ignores its interface argument and returns the XPCS
> for every mode. Neither the GRF nor the combphy is reprogrammed when the
> interface changes: set_to_sgmii() runs once from the DT phy-mode, and
> the combphy is fixed to PHY_TYPE_SGMII.
>
> Now take an SFP cage, or a PHY that switches host interface, such as a
> 2.5G PHY moving between SGMII and 2500BASE-X. Could phylink pick
> 2500BASE-X or USXGMII, and xpcs_config() then program a mode the SerDes
> and MAC clocking can't carry?
>
> The same set is also copied into lpi_interfaces for EEE.
>
> The in-tree Photonicat board uses a 1G PHY with a fixed SGMII interface,
> so it isn't affected.
>
> Could the RK3568 XPCS supported_interfaces be restricted, and
> rk_select_pcs() return the PCS only for SGMII?

The glue passes pcs-handle to xpcs_rk_create(), which uses the plain
xpcs_create_mdiodev(). The XPCS core has no platform callback to narrow
supported_interfaces, so the glue cannot filter the list cleanly.

The only way I see to restrict it from the glue is to overwrite
pcs->supported_interfaces (and possibly compat) after
xpcs_create_mdiodev() returns. That reaches into the core's internal
structure and I'm not sure maintainers would accept it, so I've left it
out of this series for now. If there's a preferred way to express
"this platform only supports SGMII" from a glue driver, I'm happy to
use it.

In practice the phy-mode is fixed in DT and the combphy is configured
for PHY_TYPE_SGMII, so phylink will not negotiate into 2500BASE-X or
USXGMII on this platform. The wide set is harmless here.

> > @@ -1379,16 +1449,19 @@ static int rk_gmac_powerup(struct rk_priv_data =
*bsp_priv)
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D gmac_clk_enable(bsp_priv, true);
> > +     if (ret)
> > +             return ret;
> > +
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the direct return here
> only works if gmac_clk_enable() cleans up after itself. Does it?
>
> gmac_clk_enable() {
>     ...
>         ret =3D clk_bulk_prepare_enable(bsp_priv->num_clks,
>                                       bsp_priv->clks);
>         if (ret)
>             return ret;
>
>         ret =3D clk_prepare_enable(bsp_priv->clk_phy);
>         if (ret)
>             return ret;
>     ...
> }
>
> If clk_prepare_enable(bsp_priv->clk_phy) fails, the bulk clocks stay
> enabled and clk_enabled stays false.
>
> Every later gmac_clk_enable(bsp_priv, false) then returns early on the
> clk_enabled check. That includes the new clk_disable label and
> rk_gmac_powerdown(). Does this leak the enable counts of the bulk
> clocks?
>
> This only applies with an integrated PHY, because clk_phy is NULL
> otherwise.

The clk_phy failure path was already fixed by a separate commit.

> >       ret =3D rk_phy_powerup(bsp_priv);
> > -     if (ret) {
> > -             gmac_clk_enable(bsp_priv, false);
> > -             return ret;
> > -     }
> > +     if (ret)
> > +             goto clk_disable;
> >
> >       pm_runtime_get_sync(dev);
> >
> > @@ -1463,6 +1538,10 @@ static int rk_gmac_powerup(struct rk_priv_data *=
bsp_priv)
> >               bsp_priv->ops->integrated_phy_powerup(bsp_priv);
> >
> >       return 0;
> > +
> > +clk_disable:
> > +     gmac_clk_enable(bsp_priv, false);
> > +     return ret;
> >  }
>
> [Severity: Medium]
> This is a pre-existing issue, but rk_gmac_resume() throws away the error
> that this path returns:
>
>     if (!device_may_wakeup(dev))
>         rk_gmac_powerup(bsp_priv);
>
>     return 0;
>
> On the non-WoL resume path, a failure in rk_phy_powerup() takes the
> clk_disable label, gates the GMAC clocks and returns an error. Nothing
> sees that error.
>
> stmmac_resume() checks the plat->resume return value, but gets 0 here.
> Can it then go on to MDIO and MAC/DMA setup with pclk_mac and aclk_mac
> disabled?

Pre-existing. The path that returns an error from rk_gmac_powerup() is
the rk_phy_powerup() failure, which on RK3568 is the external PHY
regulator. It's not related to SGMII or XPCS. I'll leave it for a
separate fix.

> > @@ -1602,6 +1681,17 @@ static int rk_gmac_probe(struct platform_device =
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
> Does the commit message's explanation of the in-band vs out-of-band
> problem match the code? It says:
>
>     Out-of-band mode does not work because the MAC would need to change
>     the clock rate to 125/12.5/1.25 MHz for 1000/100/10 Mbps
>     respectively, and the clock is fixed.
>
> The clk_tx_i comment in include/linux/stmmac.h and
> stmmac_set_clk_tx_rate() both give 125/25/2.5 MHz for 1000/100/10.
>
> In stmmac_mac_link_up(), the negotiation mode is passed only to
> plat->fix_mac_speed, which dwmac-rk doesn't set. The MAC speed
> programming and the now-NULL set_clk_tx_rate call are the same in both
> modes. The MAC therefore sees the same fixed 125 MHz clock whether
> in-band or out-of-band is used.
>
> The difference between the modes seems to be on the XPCS side: AN in
> xpcs_config_aneg_c37_sgmii(), versus the fixed BMCR write in
> xpcs_link_up_sgmii_1000basex():
>
>     if (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED)
>         return;
>     ...
>     ret =3D xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
>                      mii_bmcr_encode_fixed(speed, duplex));
>
> The commit message also says that fixed-link nodes, and PHYs without
> in-band support, can still end up in out-of-band SGMII. TX then works
> but RX fails at 10/100.
>
> xpcs_inband_caps() returns this for SGMII:
>
>     case DW_AN_C37_SGMII:
>     case DW_AN_C37_1000BASEX:
>         return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
>
> So phylink will accept out-of-band mode, and the glue neither rejects
> nor reports it. Should rk_gmac_probe() refuse, or at least warn about, a
> fixed-link or out-of-band SGMII setup, rather than bring the link up
> with RX not working?

The out-of-band SGMII rejection cannot be implemented here: the XPCS
core's xpcs_inband_caps() returns LINK_INBAND_DISABLE |
LINK_INBAND_ENABLE for SGMII, and there is no platform callback for the
glue to narrow that or to veto out-of-band mode. Phylink will therefore
accept out-of-band SGMII and the link will come up with RX broken at
10/100. That needs an XPCS core API, not a dwmac-rk change.

No respin planned for this series.

Coia
