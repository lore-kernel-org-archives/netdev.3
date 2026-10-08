Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585F3B2FE9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480178; cv=pass; b=p+I+EmBqOxY5WhHQvsJX7bBsAtJtH6pgDjSjj6Hcnay3Wmc/zkGwXsWf/LODlTUstyIL6xNXaQAVIpWB0ed6wJodAyYeRWm6IbNqiEkyndBimxZYnXSzeupSLC/dPBOcUbw9XR+cFWmn5qXuFTLn4JJzJloFqHkVOXJf7gQS9KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480178; c=relaxed/simple;
	bh=pWzqCCeV0T2q/xcDvCLhRhXLxRVs1uZuFMfnyPfHVOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQuEjS3TPDg3PPMINBQvw/SJuLHiX8b4gDAexRkIL+wEFP9oqvnlF7P4qLojXBhHbjlik7zblXzzHRO9Hc6ZsVYOU6aZfJcD+SOflKrE0ZqFxzYdRDKq2z8/qtTWYbjycFCfvA1QWGgxyCCwxbEDFBJKwdBHl/60a4ZYqzkzvv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2WVov53; arc=pass smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2WVov53"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c2e22754212so299219966b.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791480175; cv=none;
        d=google.com; s=arc-20260327;
        b=pDlE+CGEMMWSY8TVJgDcISOrgOp8yq1dJlSVCN50zpduDCQgdkoJXk7OSJhNe+pLkr
         28zMOwVLU3DiaGeHu4X6PudEdzPgOrNBzk8nWh0zifPFPV2wXye9flff4V+B+QCi7hN8
         mOHVw7EjTFnaUVk/CnkgN5DyzQvWZZohSg0rjaabStEdLKhBS0j7V4Gf3Vsn39s22BXJ
         l+pbwkfodjbOOTiS7KMSjErRYrwJKt4QXGWzO/6ZtEWWR8QWJ4+VO8wZpzCzKCgtRVCV
         2W+uhDi+rswuuGB6RiHpBY+FMGnXq0mVccuH8D0h/WNVSi0Nj6sjPKoJoDMLpV1sLn4w
         l/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p0EBynkMV9re2bWQbZpZelU+r1oieiYYosFapqOHGVk=;
        fh=kyusRd3mxReBY1Xedh/LtuvJJbB1A/dn6WWfoF5VlhY=;
        b=IeE2jZFqZFdELE7hP4UxMUehAT7cuuj5WS2gwpK6wCYsG5VBRfoDEu0PGu7cipxp16
         zQoTNW87x+lykiAAc3yG1A8q593hrjmZJ7I0beZpwewO0tx/ZF1PQ5wrHMP3+3pwm7Og
         gIlaRLEcqDoiObsxhiysVuguoH5Vkq1xFl8/u7S43k8qjqPpYpkDWnYj6sJZMoKguQX+
         sDxg2ZO6Y9VgubhD5OIfLpD/RUNRjkICHkWDCxknQ3nPxTnXS6WNQU3lVG8d5cJoSoeX
         GRwT8AlYlBG3JkhP1CKdbNpWJ/i3T3iMezeMyw9mV1MBxktiL24xD1HAJgbAet+Gd+GM
         Y8iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791480175; x=1792084975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0EBynkMV9re2bWQbZpZelU+r1oieiYYosFapqOHGVk=;
        b=A2WVov537IqpBIt1M7lEciGE1qlgSm4s2+aMiYLU7Je7dqzRDu8JToGSxhPSBLxSqJ
         nk5U85EoNZNj0t1bpGSAUbVq9DTk5vNkuBGptMeh1SfWdaq0hSjYJUKyfBnV4KzPv1ue
         BiBS3kkkpPRKdqU7fVWJtQC6/zTMeolGeISS4zLUTUE4BNqCXCeGuJhmZb71xGEBkEbt
         Derte0TRy9/4lXfo+T0lfxmqCUfiIUh7qCE+CLxN3HGvLzr49AgNXs8c0oZBU8E4ybfJ
         DAdZcwq8ouHQuU7y3SfbsAmPWwg/hDzEU4TFYpgxS8Dtl8PYuzcLRrQLHDywmoYZN/MI
         9kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480175; x=1792084975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0EBynkMV9re2bWQbZpZelU+r1oieiYYosFapqOHGVk=;
        b=bRS5UQ8s0B1DsKIwwtde1MXE7QEMXBcfL1vd7id+BiuJw68htJuMPgjBQY8elCgGYU
         q1p9skvlmTjhbz4px+glk4LeUfjH+JnuVdP7deHnuYRs6QMh33FhbDP+rrfpmZlcRFc3
         TXvtsyHtElsZf3dtXZ0SH11ZbBoOd1e/gJfR16eQcaCqifjzg52gXaEv6SKQ82wxdkG+
         pn9sUUbp8Jk8cX/j44uZoG/FbHUnb2XDhNjjKAoMCWbKNMfy0ixAdoMgdvKX0Ettvw3G
         YkRHeGLSNtufoRg1evnNJ91hfeLNTkaXJrO7peInPC/2jgYrziQlb8jJEmkvYNew5TIW
         eyIg==
X-Forwarded-Encrypted: i=1; AKwUvByZFzJt42Vqx9gPoFpAhahLyhs34uMQW+VD7joIwLIHhV8+/+0u5K9dghygR/bUl0KwlEm11i4=@vger.kernel.org
X-Gm-Message-State: AFuF++lpzX3GefbOpILYP7yCnuqWqcqgchhORWeZWVXDleez4XIer/oa
	NHUHdB7a86phNmcd4HnSwO3Pa4Fi4mao2AHEBw2AcQ/y5VBk2oAgMbg4XqU9TYuyAvNRmiWBOku
	XU5Yxv4aqMGH7oOTzjiH5o+t6Cdu3T3msGRVeAsrilg==
X-Gm-Gg: AYBFou3Z8t48JHxX4hLVtmLgcfKl3LFIfVMcJoSJTSaYL92+Pz7/mSeP6jCTrJvC+5o
	YwlYgYeDqrXOd5VjNCrTZWGpAFB6d0YpHK6Cz/lfPFI/MX60KE1F/K270YqqAt+wVArQ+vASCFx
	fMAWsjWmqdDAPm7xJ5AB9lguFlUQ3NLyJ3kFHTJZN7LODFpLjnEjlj5yqsDVyfQEPEY0+flthpa
	lLOyIV6RGP8abJ3u9UbwlT9f72kVKlP1jd6KcHXE/A5AMhuvkOWBCncnh6gq4YmzxTYL45uRiK7
	HxkndvQpzapGmiWAjKTFbOGcSvohbpLARLJ3cUsHMEKRJjdomoUd7YUoxg==
X-Received: by 2002:a17:907:6eab:b0:c2a:fcb7:62f2 with SMTP id
 a640c23a62f3a-c317bdee527mr644738666b.19.1791480174426; Thu, 08 Oct 2026
 10:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005223011.1124347-6-coiaprant@gmail.com> <179147717619.434549.6837184634225737346@kernel.org>
In-Reply-To: <179147717619.434549.6837184634225737346@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 9 Oct 2026 01:22:41 +0800
X-Gm-Features: AclHuK_-hedDg8zCqAPrYyf_XLOD6FRv2_L3UganQGVdJ3Cn6nu0L2YERFkLqUA
Message-ID: <CALj3r0hnXMqLihuZ5fe65Z=g_jz5FHVf_GMhRGpTfSWYW7JoYA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 5/6] net: stmmac: dwmac-rk: add SGMII support
 for RK3568
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, maxime.chevallier@bootlin.com, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, david.wu@rock-chips.com, 
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=94 00:32=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 3 (2) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] SGMII cannot work at all, and the XPCS leaks on every probe.
> - [Medium] With phy-mode=3D"sgmii", rk_gmac_probe() clears
>   plat_dat->set_clk_tx_rate and sets default_an_inband=3Dtrue, but that=
=E2=80=A6
> - [Medium] The commit message's account of in-band vs out-of-band SGMII
>   is wrong in three ways.
> - [Medium] xpcs_rk_create(), which the new rk_pcs_init() calls, assumes
>   that 'supplier->links.status =3D=3D DL_DEV_DRIVER_BOUND' right after=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   rk_gmac_exit() assumes driver data already exists.
> - [Medium] This problem wasn't introduced by this patch, but
>   rk_gmac_resume() ignores the return value of rk_gmac_powerup() and=E2=
=80=A6
>
> --
>
> net: stmmac: dwmac-rk: add SGMII support for RK3568
>
> This patch adds RK3568 SGMII support to dwmac-rk. It adds a set_to_sgmii(=
)
> GRF callback, plus pcs_init/pcs_exit/select_pcs callbacks that create the
> XPCS with xpcs_rk_create(). For SGMII it also enables clocks earlier in
> rk_gmac_powerup(), sets default_an_inband and clears set_clk_tx_rate.
>
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TR=
M%20Part1%20V1.1-20210301.pdf (Page 386)
>
> > On RK3568, the MAC clock is fixed at 125 MHz and cannot be dynamically
> > changed by the stmmac core's set_clk_tx_rate callback.  In-band mode
> > works because the PCS handles rate adaptation internally.  Out-of-band
> > mode does not work because the MAC would need to change the clock rate
> > to 125/12.5/1.25 MHz for 1000/100/10 Mbps respectively, and the clock
> > is fixed.
>
> [Severity: Medium]
> Are these rates correct? The clk_tx_i kernel-doc in include/linux/stmmac.=
h
> says "SGMII 125MHz SerDes clock divided by 1, 5, or 50". Also,
> rgmii_clock(), which rk_set_clk_mac_speed() uses, returns
> 125/25/2.5 MHz.
>
> The reason given for in-band working and out-of-band failing also doesn't
> seem to match the code:
>
> - rk_gmac_probe() sets set_clk_tx_rate to NULL for every SGMII
>   configuration, so the MAC clock is handled the same way in both modes.
> - The XPCS is told the speed in both modes: through MAC_AUTO_SW in
>   xpcs_config_aneg_c37_sgmii() for in-band, and through a BMCR write in
>   xpcs_link_up_sgmii_1000basex() for out-of-band.
>
> > Enable default_an_inband for SGMII and disable the generic stmmac
> > set_clk_tx_rate callback.
>
> The callback that gets cleared is rk_set_clk_tx_rate(). That is the
> Rockchip-specific one, which ends up in rk_set_clk_mac_speed() on rk3568,
> not a generic stmmac callback.
>
> Could the commit message be updated on these points?

Ack, I'll fix the commit message: the rates are 125/25/2.5 MHz, and the
reason out-of-band does not work is that the driver disables
set_clk_tx_rate, so the MAC clock stays at 125 MHz. It's a driver
choice, not a hardware limitation.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac-rk.c
> > index 72bdbcb5e863a..3b50ad3c600b9 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>
> [ ... ]
>
> > @@ -1211,6 +1239,43 @@ static void rk_phy_powerdown(struct rk_priv_data=
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
>
> [Severity: Medium]
> Can xpcs_rk_create() race with the XPCS driver binding? It does this:
>
> drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_create() {
>     ...
>         link =3D device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONS=
UMER);
>     ...
>         if (READ_ONCE(link->supplier->links.status) !=3D DL_DEV_DRIVER_BO=
UND) {
>     ...
> }
>
> fw_devlink does not parse "pcs-handle", so nothing orders the supplier
> ahead of this probe. Suppose the XPCS device has no driver when
> device_link_add() runs:
>
> - The link starts in DL_STATE_DORMANT.
> - If the XPCS driver binds before the READ_ONCE() check,
>   device_links_driver_bound() moves the link to DL_STATE_AVAILABLE, not
>   DL_STATE_CONSUMER_PROBE.
> - The DL_DEV_DRIVER_BOUND check still passes.
>
> device_links_unbind_consumers() only waits for links in
> DL_STATE_CONSUMER_PROBE. Could a concurrent unbind of the XPCS driver the=
n
> free the devm-managed pxpcs and mii_bus while xpcs_create_mdiodev() is
> still using them?
>
> Also, if the stmmac probe then succeeds, wouldn't
> device_links_driver_bound() for the consumer hit
> WARN_ON(link->status !=3D DL_STATE_CONSUMER_PROBE)?
>
> > +     of_node_put(pcs_node);
> > +     if (IS_ERR(xpcs))
> > +             return PTR_ERR(xpcs);
> > +
> > +     priv->hw->xpcs =3D xpcs;
>
> [Severity: High]
> Does this XPCS pointer survive after the callback returns? On the pcs_ini=
t
> branch, stmmac_pcs_setup() never sets its local xpcs, and then writes it
> back unconditionally:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_pcs_setup() {
>         struct dw_xpcs *xpcs =3D NULL;
>         ...
>         if (priv->plat->pcs_init) {
>                 ret =3D priv->plat->pcs_init(priv);
>         } else if (fwnode_property_present(devnode, "pcs-handle")) {
>         ...
>         priv->hw->xpcs =3D xpcs;
>
>         return 0;
> }
>
> So once rk_pcs_init() returns, priv->hw->xpcs is NULL again.
>
> In stmmac_phylink_setup(), priv->hw->xpcs and priv->hw->phylink_pcs are
> then both NULL, so the XPCS supported_interfaces are never merged.
> rk_get_interfaces() has already set the RGMII and RMII bits for rk3568,
> so PHY_INTERFACE_MODE_SGMII never ends up in supported_interfaces.
>
> With default_an_inband set, phylink_parse_mode() takes the in-band path
> and phylink_validate() fails. Doesn't that make phylink_create(), and so
> the whole probe, fail with -EINVAL on every phy-mode =3D "sgmii" board?
>
> Even if probe got past that, rk_select_pcs() would return NULL. Also,
> rk_pcs_exit() and stmmac_pcs_clean() both return early when
> priv->hw->xpcs is NULL, so xpcs_destroy() never runs. Is the dw_xpcs,
> together with its mdio_device reference and clocks, leaked on every probe
> attempt?
>
> The other pcs_init users (socfpga, rzn1, renesas) avoid this by storing
> their PCS in priv->hw->phylink_pcs.
>
> Because of this, the commit message statement that SGMII "comes from the
> XPCS's own supported_interfaces, merged by stmmac_phylink_setup()" does
> not currently hold.

Fixed by the stmmac XPCS lifetime patch in the same series, which
rewrites stmmac_pcs_setup() and no longer overwrites priv->hw->xpcs with
a local variable. Sashiko is looking at the pre-patch baseline.

> [Severity: Medium]
> default_an_inband only picks the default. Does anything stop phylink from
> running this link out-of-band?
>
> - A fixed-link node gives MLO_AN_FIXED.
> - If the PHY reports only LINK_INBAND_DISABLE: xpcs_inband_caps() returns
>   LINK_INBAND_DISABLE | LINK_INBAND_ENABLE for SGMII, so
>   phylink_pcs_neg_mode() selects PHYLINK_PCS_NEG_OUTBAND.
>
> rk_select_pcs() returns the XPCS whatever the neg_mode is. With
> set_clk_tx_rate cleared, the MAC clock stays at 125 MHz.
>
> According to the commit message, 10/100 Mbps would then have working TX
> and failing RX. The link would still be reported up, and nothing would be
> logged.
>
> Could the driver reject this or warn about it, for example by checking th=
e
> neg_mode or limiting the MAC capabilities? Right now it is only documente=
d
> in the commit message.
>
> > +             plat_dat->pcs_init =3D rk_pcs_init;
> > +             plat_dat->pcs_exit =3D rk_pcs_exit;
> > +             plat_dat->select_pcs =3D rk_select_pcs;
> > +     }
> > +
> >       plat_dat->bsp_priv =3D rk_gmac_setup(pdev, plat_dat, data);
> >       if (IS_ERR(plat_dat->bsp_priv))
> >               return PTR_ERR(plat_dat->bsp_priv);

There is no platform hook to reject a neg_mode at the MAC level today;
pcs_init/select_pcs only give us a phylink_pcs. Limiting this would
need a stmmac/phylink core change, out of scope for this series. I've
documented the limitation in the commit message.
