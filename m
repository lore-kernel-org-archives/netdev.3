Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041B3955F1
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880510; cv=pass; b=D0l2U1EHyiInPYnUOCD8DUK5w/x27dOGCX89czFadQESq2+9VxP6CRnM+qqULVU9AgYFGyvQnIrdfS6z5qQ8/XZ8OQ1YhsoGOobls7417T7dMria7365ACZOc2uBh/iiAUR8dKlxMy5YttvymGh75OAj5yBWLu/2lMO8cDXizkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880510; c=relaxed/simple;
	bh=pBdJ57ON/qFDUsOE7VZli4VSyyMWeePsEoC07w8ygoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTdzjslJp/3GoLdPx7RL4MGUpqyreqFBxu9GfvsHJC5ipDo6hPLwE8dSu4ScPDX9/EN3B1X6qnjn8ygWGO8japq/mRzhLZdLDvWy9W6ISnJS9jCypjcV1yZXf2NvWfAHN1crX3oOWLGXcNag2L1mAPMRldUcLdbleACGIwW1+lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5nSK6XS; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5nSK6XS"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4946642a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880499; cv=none;
        d=google.com; s=arc-20260327;
        b=bLyh2oGLKZ7kqeFQCNsCf/l/FhNsxFqg6kEMK6HR11D1DhoOJ8Yf/CMElAYXYXRHTm
         kNn9joiqBGqIERh5M03CfzKLySS6yV4fHwyMG7yfc5cKzO+u4Cj1ulctLZNWq3+Mcly8
         6j0vCSZWE5UZ/W+PX9sdRUjJWz/HcS8QTb61bzwwWBgXi428LZSbIay3Tuk8CRO9wRtP
         qIprFv4//FF7hDMz0lGYQiDkypcQ571B4a5oqc7uVlA7hdCk4FIAZXCS6rbOnLGoMN2x
         8X1/3JsD7acajCasQEu9tRNCW/6IjZjEENHjeQ9lh1xxNVon3YcKp+hBnhyHlFlwBu+t
         Rk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgYQMTATtyJWpk9CvcV0pYNidzQnxU/fkxOhjlNLIRE=;
        fh=xB11myxO4D0nViGT+hXYMSUxvH7dNIl2JCJadc9otKE=;
        b=l0DnyQKcWJxJneh/zauZxVGqPharUizmuyO7z4qhIx+XhxTqgvT0IIcssVNkEUb4kz
         a9c9c0aqBnJThw/gBjXWyEXyx01JTOjxI2l1UcbrO9H+RlPFBaXGyI2819PtDGZsEF5X
         yOVOSDgCG3WTp8FLe1ymBQnKsFh+PNGRf6TUHaD6iVVL+8N2HH6eASEdh7KyGzz6QGuY
         Rt9dBzOFpxDNglxSlZefKubbQaXRz6d1I80pnWrhdzSZ4AyKlC+rHohaO8dd6WLm+9d6
         48eBdimEzsp+bJ195QGApvCaFIcZAoL7lre+2K3SDvcZaKQIalMOfUXd0k54nM1akVAu
         146A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880499; x=1789485299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgYQMTATtyJWpk9CvcV0pYNidzQnxU/fkxOhjlNLIRE=;
        b=I5nSK6XSvYkaRoyt+bE2w2/h9d3lkWwaZzEKtzcVTKHTTBQh1104S9Jfvn1K6UDFZK
         EzzXvV+BCrjybujV4RfHnvyAR/ZjOxqCGwg0cAECEZpWmrp6XLVQ3S+gm231fcTWAlAs
         YTwIr3z73UlID2JpyyU3XhzCfR7lyQ9G8FifYHvupEQQpQRhFzdq+7TPFy0Lhb6RzMg8
         CSEk1q9Z9v2IQZsn0yfVlBX+DGxsCgfPqg81RA9xd1oe8POp79YxUXx8tCFMLiIdk34b
         VHgs7Ab2ZfLxHXY7hTbJDklWaOs3ZG8vkfqSSpfTCPP+A6gtIxiF/OtoHGcSEEpBuFer
         M4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880499; x=1789485299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgYQMTATtyJWpk9CvcV0pYNidzQnxU/fkxOhjlNLIRE=;
        b=oREuAFNRgQzWdxZiI3AcNTXrJOFWdp+aQuGtWpzB5DZpqLh5vxp0oSmuLGWKq9pkIy
         0pXYAvcNZBnkK3mzcXaJqkpN++dQp3GafLoHu1jDHKXJURvFg5c0MLYXaLIzD1HiRClq
         rxknzAuPBwzImheWZze8hy0/+ZqnHPipC2/GFGQ9kHnhwretpAJw2rYlzU4TW7/D0whw
         CDEmEo4cvvSEj5Tp+/kvMu9RTXUqf961KkyVPiiBLTvzXFfBBPoUVPJAdQl3ziZ1UYKI
         GkqeYrYSUA2jZiSL2BtoQwkDvsnrhyFw86by/duQ0Os04QOVvMGunr8++BNM4ft5LHa/
         25jw==
X-Gm-Message-State: AFuF++noNPBR19sI0mSULxM1cI6pqURsA5ueZH3Zl0yyNcAwrXTqBPLX
	PpK5FCWTmrqgiLLR6OCkbVmpCVFp0kM1A3/0ygCXx6Pxeqv9n243Z+FqnbJv9Cn/Egui/b+7nJj
	rkU0Xi+0WCpyYD10jwFtEqpVv+8Q3Pg==
X-Gm-Gg: AYBFou3Q+lEfEkTJcYRDQ5Js24TD9HagLQweNJWxfoh01a8MqQnEVQM1ol4VDs9hzTD
	/Y0OYzHXpg+Wy5JLfUl521EXGH/QVRIMLsM8t8lRV0FhvXY8srSJbfGTnP8d/Qplf8j+PQVPaHX
	3fkbge3VRRlSUs5Ool2KYlvuSJq8xrg6bNTD8aorui3LKc7fheqFnlcqZ3xZ3PcXPILAKvCuodW
	gnWNwlC+ftgOE05k2fezfbBEQbYO6kgHpJPGl9gWew/HJn4SS3eT+hMj1qQqNeOP7EpD80OdIW+
	R3n2d8x9E4XdUH9cNgefmRIJSfGd8CfOCKCRg67IGjg=
X-Received: by 2002:a17:903:26cc:b0:2db:56da:6a0b with SMTP id
 d9443c01a7336-2db56da6ebbmr216182465ad.13.1788880499195; Tue, 08 Sep 2026
 08:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com> <178885625700.219967.7168072838761125406@kernel.org>
In-Reply-To: <178885625700.219967.7168072838761125406@kernel.org>
From: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Date: Tue, 8 Sep 2026 18:14:46 +0300
X-Gm-Features: AcwNN1XB_kJovrt7RM82lErwqtpd0arCb5Y1gSidn9sAEhYEVo0spZm52sfv7_Y
Message-ID: <CADDoYm6gVeXpEdQJNzqBfBXXGSqg7TTZeyyqka7nShE=Aw6Rcw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: phy: mediatek-ge: disable EEE on the MT7530 PHY
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, daniel@makrotopia.org, 
	dqfext@gmail.com, SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com, 
	sean.wang@mediatek.com, olteanv@gmail.com, yangshiji66@outlook.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Both findings confirmed against current sources -- thank you, the
analysis is spot on.

v4 keeps the probe()-time advertisement clear, which also feeds an
empty advertisement back into genphy_c45_read_eee_adv() during
phy_probe(), and moves the durable disable to config_init(), the
dp83867 placement: config_init() runs after of_set_phy_eee_broken() in
phy_probe(), so the eee_disabled_modes fill is not undone, and it is
the callback phy_init_hw() replays after a PHY reset, so the register
clear is restored as well. The register is also written again there
for the reset path.

v4 follows as a fresh thread.
https://lore.kernel.org/netdev/20260908145213.3976508-1-vladislav.karmanov.=
dev@gmail.com/

Tested on the affected hardware (ASUS RT-AX53U, MT7621): single clean
100 Mbps WAN link + DHCP lease over a 2-pair cable, no flapping. The
ethtool re-enable path is not reachable on this board (phylink rejects
EEE ops at the MAC layer), so that part is verified at the code level
for standalone use of the PHY.

=D0=B2=D1=82, 8 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 11:30=
, <netdev-bot+sashiko@kernel.org>:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [High] mt7530_phy_probe() (drivers/net/phy/mediatek/mtk-ge.c:65-84)
>   calls phy_disable_eee() from the driver's .probe callback, but phylib=
=E2=80=A6
> - [Medium] The hardware write that clears the EEE advertisement,
>   phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0) at=E2=80=A6
>
> --
>
> net: phy: mediatek-ge: disable EEE on the MT7530 PHY
>
> This adds an mt7530_phy_probe() callback to the mediatek-ge driver which
> clears MDIO_AN_EEE_ADV in hardware and then calls phy_disable_eee(), with
> the stated goal that neither phylib nor userspace can re-enable EEE on th=
e
> MT7530 internal GE PHY.
>
> > diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediat=
ek/mtk-ge.c
> > index 73d9b72f9d9e2..35600c70cab90 100644
> > --- a/drivers/net/phy/mediatek/mtk-ge.c
> > +++ b/drivers/net/phy/mediatek/mtk-ge.c
> > @@ -62,6 +62,27 @@ static void mtk_gephy_config_init(struct phy_device =
*phydev)
> >                      FIELD_PREP(MTK_MCC_NEARECHO_OFFSET_MASK, 0x3));
> >  }
> >
> > +static int mt7530_phy_probe(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     /* The MT7530 internal GE PHY has broken EEE: with EEE advertised=
,
> > +      * some link partners fail to establish a stable link (on a 2-pai=
r
> > +      * cable, 1000BASE-T training fails and the port loops instead of
> > +      * falling back). MediaTek recommends disabling EEE on this PHY.
> > +      * Clear the EEE advertisement early and mark EEE disabled, so
> > +      * that neither phylib nor userspace can re-enable it.
> > +      */
> > +
> > +     ret =3D phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> > +     if (ret)
> > +             return ret;
>
> [Severity: Medium]
> Should this register write also live in mt7530_phy_config_init()?  This i=
s
> the only place where MDIO_AN_EEE_ADV is cleared in hardware, and ->probe =
is
> the one callback phylib never replays.  phy_init_hw() deasserts the reset
> line, optionally soft-resets, and then re-runs only ->config_init and
> ->config_intr:
>
> drivers/net/phy/phy_device.c:phy_init_hw() {
>         ...
>         if (phydev->drv->config_init) {
>                 ret =3D phydev->drv->config_init(phydev);
>                 if (ret < 0)
>                         return ret;
>         }
>         ...
> }
>
> mt7530_phy_config_init() does not touch MDIO_AN_EEE_ADV, so after a PHY
> register reset the register is back at its EEE-advertising hardware defau=
lt
> while phydev->advertising_eee stays empty and eee_cfg.eee_enabled stays
> false, i.e. software and hardware state disagree.
>
> Two paths that re-init without ->probe:
>
>   - phy_detach() asserts the PHY reset signal and a later
>     phy_attach_direct() -> phy_init_hw() only replays config_init.
>   - the SIOCSMIIREG BMCR_RESET case in phy_mii_ioctl():
>
> drivers/net/phy/phy.c:phy_mii_ioctl() {
>         ...
>                 if (prtad =3D=3D phydev->mdio.addr &&
>                     devad =3D=3D MII_BMCR &&
>                     val & BMCR_RESET)
>                         return phy_init_hw(phydev);
>         ...
> }
>
> which returns without any aneg reconfiguration, so nothing rewrites the
> advertisement to zero.  __genphy_config_aneg() ->
> genphy_c45_an_config_eee_aneg() covers the usual renegotiation case, but =
it
> returns early without writing when phydev->autoneg =3D=3D AUTONEG_DISABLE=
.  The
> equivalent in-tree quirk issues the disable from the replayed callback,
> dp83867_config_init() -> phy_disable_eee().
>
> > +
> > +     phy_disable_eee(phydev);
>
> [Severity: High]
> Does the phy_disable_eee() state survive the rest of phy_probe()?  The
> linkmode_fill(phydev->eee_disabled_modes) done inside phy_disable_eee() i=
s
> what makes the disable permanent, but phylib clears that set later in the
> same probe flow:
>
> drivers/net/phy/phy_device.c:phy_probe() {
>         ...
>         if (phydev->drv->probe) {
>                 err =3D phydev->drv->probe(phydev);
>         ...
>         /* Get the EEE modes we want to prohibit. */
>         of_set_phy_eee_broken(phydev);
>         ...
> }
>
> drivers/net/phy/phy-core.c:of_set_phy_eee_broken() {
>         struct device_node *node =3D phydev->mdio.dev.of_node;
>         unsigned long *modes =3D phydev->eee_disabled_modes;
>
>         if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
>                 return;
>
>         linkmode_zero(modes);
>         ...
> }
>
> So for any MT7530 PHY that has an of_node, eee_disabled_modes ends up emp=
ty
> again unless the DT carries eee-broken-* properties.  An of_node is prese=
nt
> in a documented configuration: mt7530_setup_mdio() registers the internal
> bus with the switch's "mdio" child node,
>
> drivers/net/dsa/mt7530.c:mt7530_setup_mdio() {
>         ...
>         mnp =3D of_get_child_by_name(np, "mdio");
>         ...
>         ret =3D devm_of_mdiobus_register(dev, bus, mnp);
>         ...
> }
>
> and mediatek,mt7530.yaml documents that node, so ethernet-phy children
> described there get an of_node.
>
> With eee_disabled_modes empty, can userspace re-enable EEE again through
> dsa_user_set_eee() -> phylink_ethtool_set_eee() -> phy_ethtool_set_eee() =
->
> genphy_c45_ethtool_set_eee()?
>
> drivers/net/phy/phy-c45.c:genphy_c45_ethtool_set_eee() {
>         ...
>                 } else if (linkmode_empty(phydev->advertising_eee)) {
>                         phy_advertise_eee_all(phydev);
>                 }
>         ...
> }
>
> That repopulates advertising_eee with supported_eee, then
> genphy_c45_an_config_eee_aneg() rewrites MDIO_AN_EEE_ADV and
> phy_restart_aneg() renegotiates, which looks like it brings back exactly =
the
> 1000BASE-T training loop described in the commit message.
>
> Would moving the disable into mt7530_phy_config_init(), which runs after
> of_set_phy_eee_broken(), address both this and the reset case above?  Tha=
t
> is the placement dp83867_config_init() uses for the same kind of quirk.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260904202800.3410838-1-vladislav.karmanov.dev%40gmail.com
