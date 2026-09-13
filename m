Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30572F746D
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311134; cv=pass; b=ZsOS7xnQ6XRE20PEsN6DYm3bi13W8ukXEp9r/TQ7Afm5JaHs9+4ns2chGoS4WaVixaF6TUf1RV8iNSO3ogMgRAOtDWN7pneZ9ymIJvodqW+PbUrV/bQVTo59Hrazkb9P5dqIdZudGpJD8cAjMyekFrVh7taqhuZ6iOMH0jUeBdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311134; c=relaxed/simple;
	bh=9KobIys20bgObqUmjH0ICJgje31Yh9fzR2GAO/LeuCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKgeJQeQsH3EU9so7HTErwS9TCk4Ra6X1j+gZk3wRZ/M9YpfNXxNHL7FItOE8Sl/KGnDXaRq01Apn41wOhtQ+bzlairLGl+WOKpN0jb2wbdXWgwjHmmi3Aivzxk/W/IWFS0fniRE8DHtvp21+jk2dMg6EYRHWZ3a8cPStiiPCWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6KZzBqb; arc=pass smtp.client-ip=74.125.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6KZzBqb"
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c29390fa872so154693366b.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 07:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789311131; cv=none;
        d=google.com; s=arc-20260327;
        b=Sx0K+s+bTzmJA1h0OELLAv6rzFLI3QhyC/Y8ouW+6A4Xhi/97ejw9+Q2cggBlfUKNU
         yMzwVBF+J6azSbyzaiz4gC0j/o9Chpl4er3O1L2wcygUZ7m5oPHTAmFJnC4FiQ4wFrWj
         6pKFGOS/DN+MmOp+xwdiWfRaMExRHk8NQeQjRYW5U9p4byYfPjoHPaMdAx7QuUr7Qvjm
         KAflINzfpw9eXm8j/k8/FjaSrmfry6WeBEjrF+PmXaNzZeIYRlZTDboEcnfM5Z/v7bIZ
         4kkioGfP+TId1PotklWO4th6BfdRyTInw3yc+VLKjjixPI6X9PPxSsD4AU9wO+xFlgMN
         ArcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U1P22qVWYkkIQH3TqjK/hrzcvwyKwmsGg95mm1/PRSo=;
        fh=CabZFHHnmMlq55lwIs12a8VqwMpNvR85dGlL7idlCL0=;
        b=pw4xPbJElhAlMHzGqOoiFtqZfrC7UgXM0JI0Hz10h5U66jfjNN/s2MbE2SCGBVRwPr
         IKRnTYLOl83HLy38Jxw0DdiJYMWezuUtQdOn0wMH/IxRq+zW7gjcod92xsIbNAO92rk3
         ej5W2dKseAbUXHcjf9j7WBHb6HBoRwCUmT/DrnWU3AwwKwj05p7FEiuyfybv4kawR+U1
         guH3ogv5tpQr7W8zB5t/UwUf9AFrVadQGMYTKiUuDXH9oOo0MaEC74xzayw+8C0jSPg0
         zQGc/GN08rjKMyZuVY4/hBNZHWd3kRnSL1DPPpqz7BghdCpZPJL5I+hO7eIbwHeQNc1h
         +YGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311131; x=1789915931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1P22qVWYkkIQH3TqjK/hrzcvwyKwmsGg95mm1/PRSo=;
        b=m6KZzBqbDF/CyIJRzguze5GR4wbvSGy3MgyWr7VhgvLDDl0WlNpEgkddaWAOnftikq
         PJyAb5bKohOxRWD1DPCx+oKS6PUuCn3f2TnA66clL0bo7QWCJ/uBwyi6kBNtfMilTl0g
         NOWG22YbU4C318orL3V+x9AwBugwVVLaSdGoy5t0KBdtoI0LF9N2hG73Fno3DjOW29cA
         /hAsq+5Rm1vln6xms9U6vUt3tQN/njTVuOct9MwRhEpniJbfITWMVYNe7rSWegd0WhuK
         +7o0s5+lpTYIbfTtA1Q+TaRPLvbVTNxTB3zJBhSPHCLHfJxxrNXUvWlD6zuCosWOUlj3
         el8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311131; x=1789915931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1P22qVWYkkIQH3TqjK/hrzcvwyKwmsGg95mm1/PRSo=;
        b=n+6IB0UC8GSDDGzGIm6w0NNGdVmQTsNBWdtDlmlZonR+MXAi/lPuVz4a5N0mh+lWsm
         HfiVptZzj4i4MsrPl7gpn0dXSqTxmB6WPvAFg2L4vY02p1Mc5ep2czX9HFhBOAUxam4l
         kY+XzA+DtAyEMxdnD10K/zXFcH9fF/j7Nx9pZ1FQuKWknqeT8wr0ID9Fi4/uHqc2oQO+
         wBDlQkfNGu+XO3cOjoKK5UbB4qvMRhecYaIlTS3Csmz8ode87gMH3OYz3osI7siJIy0r
         0cIJP241soJ4SjIwCOtIUi7X09t8P4TfGP5k9YHItEmp3b1yG37lyCFMTTOE7gkMMlKG
         VMiQ==
X-Forwarded-Encrypted: i=1; AKwUvByn+R2VMu0AyIG3Um6FSE9q3Eti5uKweXsmtk8vnCT9Rf4SsVIjUx8d5FrPCP8ekaVHv9LIw0w=@vger.kernel.org
X-Gm-Message-State: AFuF++liELJNZXZALjGlvLFC7Vvg/36zGpIE03ZWzSuxkJ1/3IkU2+S4
	rWsm+drMIvAxi2gkUke9t225GdqA/2FN9W71UJMxAYXrBU0+A5WgDucqNLMD+Q7bSqDLK9Ve3tr
	mu+YvlLZBEFJLSvwVC5ber7oGjQoEXgc=
X-Gm-Gg: AYBFou07jzgrZa8OgUhtSFLgJDR8yCjZ3iNdBZEG/gc32/VV6umb1xFRWSB6A6vJLFc
	nZCd4q58klq7G0hG50uBzxB/bAy0dGTOyIel/vXLcfuLBanPgIsHovYcow0lepDBzqZi0/r6XBw
	mMlw+2idfeI6m+4SXPwuXDhnANKRKzD+3Snndje0I/0YW5JumJJLTjgLdWdz31Q+9xVrcI/sSWo
	xyIOyaObb1qv195R/QKx5kugyU9jy75QLaoae1CijtSbxLFadJp5XiGYM+962fZR8BMQfUh8Nuf
	h7Gb8gA9U7J6NjKQPVxR+28Zhp5vKWsXUu4vQ1My8iMBZhTKISRDp+5Y2Q==
X-Received: by 2002:a17:907:6ea9:b0:c29:4490:50d6 with SMTP id
 a640c23a62f3a-c298594beffmr321786366b.47.1789311130637; Sun, 13 Sep 2026
 07:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907153713.2572547-3-coiaprant@gmail.com> <20260912201313.126882-1-kuba@kernel.org>
In-Reply-To: <20260912201313.126882-1-kuba@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 13 Sep 2026 22:51:58 +0800
X-Gm-Features: AcwNN1VXbO22gmmHfNIRMDToBFQhLF1DFxk7dhOhjAAsXMm_rbGvJWniNVflKXA
Message-ID: <CALj3r0iNGgrMNDNQ-_780p=qbSMNfF1i-DeAa4iHTwTGsJhj6g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/10] net: stmmac: move XPCS lifetime
 management to platform drivers
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
> net: stmmac: move XPCS lifetime management to platform drivers
>
> This removes the generic XPCS creation and destruction code from
> stmmac_pcs_setup() and stmmac_pcs_clean(), leaving those functions as
> plain dispatchers to plat->pcs_init() and plat->pcs_exit().  The Intel
> mGbE glue gains its own pcs_init()/pcs_exit() implementations, and the
> renesas-gbeth, rzn1 and socfpga pcs_exit() callbacks now clear
> priv->hw->phylink_pcs after destroying the PCS.
>
> A few questions on the changelog and on the removed common code below.
>
> [Severity: Medium]
> Three statements in the commit message do not seem to match the tree
> this patch applies to.
>
> First:
>
>     Address all of these issues by introducing pcs_init() and pcs_exit()
>     callbacks in plat_stmmacenet_data.
>
> Are these callbacks actually introduced here?  Both function pointers
> already exist in struct plat_stmmacenet_data at the baseline:
>
>         int (*pcs_init)(struct stmmac_priv *priv);
>         void (*pcs_exit)(struct stmmac_priv *priv);
>
> and this patch does not touch include/linux/stmmac.h at all.  The
> baseline stmmac_pcs_setup() and stmmac_pcs_clean() already call them.

You're right. These callbacks already exist. My patch simplifies the
dispatch, not introduces them. I'll fix the wording.

> Second:
>
>     Second, and more critically, when stmmac_pcs_setup() fails to create
>     an XPCS (either because no pcs-handle is present and no pcs_mask is
>     configured), it falls through to the else branch and leaves
>     priv->hw->xpcs as NULL. This will silently override any XPCS that a
>     platform driver may have already set up
>
> Is that the branch that causes the override?  In the baseline that arm
> returns immediately:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_pcs_setup() {
>         if (priv->plat->pcs_init) {
>                 ret =3D priv->plat->pcs_init(priv);
>         } else if (fwnode_property_present(devnode, "pcs-handle")) {
>         ...
>         } else {
>                 return 0;
>         }
>         ...
>         priv->hw->xpcs =3D xpcs;
> }
>
> so no XPCS pointer can be clobbered there.  The clobber only happens on
> the plat->pcs_init branch, where the local xpcs stays NULL and the
> unconditional priv->hw->xpcs =3D xpcs; afterwards overwrites whatever
> pcs_init() stored.  Could the changelog describe that path instead?

You're right. The else branch returns immediately. The clobber happens on
the plat->pcs_init branch. I'll fix the changelog.

> Third:
>
>     Existing platform drivers (intel, rzn1, socfpga) are updated to use
>     the new callbacks by moving their XPCS creation and cleanup logic int=
o
>     pcs_init() and pcs_exit().
>
> rzn1 and socfpga already used pcs_init()/pcs_exit() before this patch,
> and neither creates an XPCS: rzn1_dwmac_pcs_init() calls miic_create()
> and socfpga_dwmac_pcs_init() calls lynx_pcs_create_mdiodev().  The only
> change for them is the added NULL assignment.  The patch also modifies
> dwmac-renesas-gbeth.c, which the changelog does not mention.  Should
> that list be corrected to intel only, plus a note about the pointer
> clearing in renesas-gbeth, rzn1 and socfpga?

Okay, I will update it.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > index f5f9fa67ecd77..fd5f01c8941c1 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > @@ -603,13 +603,47 @@ static void common_default_data(struct plat_stmma=
cenet_data *plat)
> >       plat->mdio_bus_data->needs_reset =3D true;
> >  }
> >
> > +static int intel_mgbe_pcs_init(struct stmmac_priv *priv)
> > +{
> > +     struct fwnode_handle *devnode, *pcsnode;
> > +     struct dw_xpcs *xpcs =3D NULL;
>
> [Severity: Low]
> This isn't a bug, but is the NULL initializer still reachable here?
> Both arms of the if/else below assign xpcs unconditionally, from
> xpcs_create_fwnode() or xpcs_create_mdiodev(), and neither returns NULL.
> In the common code this was moved from, the initializer mattered because
> a fall-through left xpcs NULL and the call was guarded by
> if (xpcs) xpcs_config_eee_mult_fact(...); that guard is now gone.

You're right. I'll drop it.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c =
b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > index 19f34e18bfef2..9af32c26f9c14 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > @@ -81,8 +81,11 @@ static int renesas_gmac_pcs_init(struct stmmac_priv =
*priv)
> >
> >  static void renesas_gmac_pcs_exit(struct stmmac_priv *priv)
> >  {
> > -     if (priv->hw->phylink_pcs)
> > -             miic_destroy(priv->hw->phylink_pcs);
> > +     if (!priv->hw->phylink_pcs)
> > +             return;
> > +
> > +     miic_destroy(priv->hw->phylink_pcs);
> > +     priv->hw->phylink_pcs =3D NULL;
> >  }
> >
> >  static struct phylink_pcs *renesas_gmac_select_pcs(struct stmmac_priv =
*priv,
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> > index 13634965bc19a..01df4776edb3f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> > @@ -35,8 +35,11 @@ static int rzn1_dwmac_pcs_init(struct stmmac_priv *p=
riv)
> >
> >  static void rzn1_dwmac_pcs_exit(struct stmmac_priv *priv)
> >  {
> > -     if (priv->hw->phylink_pcs)
> > -             miic_destroy(priv->hw->phylink_pcs);
> > +     if (!priv->hw->phylink_pcs)
> > +             return;
> > +
> > +     miic_destroy(priv->hw->phylink_pcs);
> > +     priv->hw->phylink_pcs =3D NULL;
> >  }
> >
> >  static struct phylink_pcs *rzn1_dwmac_select_pcs(struct stmmac_priv *p=
riv,
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index 1d7f0a57d2889..6d4bc1fe8f751 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -539,8 +539,11 @@ static int socfpga_dwmac_pcs_init(struct stmmac_pr=
iv *priv)
> >
> >  static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
> >  {
> > -     if (priv->hw->phylink_pcs)
> > -             lynx_pcs_destroy(priv->hw->phylink_pcs);
> > +     if (!priv->hw->phylink_pcs)
> > +             return;
> > +
> > +     lynx_pcs_destroy(priv->hw->phylink_pcs);
> > +     priv->hw->phylink_pcs =3D NULL;
> >  }
> >
> >  static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv=
 *priv,
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > index afe98ff5bdcb0..d2f77f0c223a7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > @@ -426,36 +426,15 @@ int stmmac_mdio_reset(struct mii_bus *bus)
> >  int stmmac_pcs_setup(struct net_device *ndev)
> >  {
> >       struct stmmac_priv *priv =3D netdev_priv(ndev);
> > -     struct fwnode_handle *devnode, *pcsnode;
> > -     struct dw_xpcs *xpcs =3D NULL;
> > -     int addr, ret;
> > -
> > -     devnode =3D dev_fwnode(priv->device);
> > -
> > -     if (priv->plat->pcs_init) {
> > -             ret =3D priv->plat->pcs_init(priv);
> > -     } else if (fwnode_property_present(devnode, "pcs-handle")) {
> > -             pcsnode =3D fwnode_find_reference(devnode, "pcs-handle", =
0);
> > -             xpcs =3D xpcs_create_fwnode(pcsnode);
> > -             fwnode_handle_put(pcsnode);
> > -             ret =3D PTR_ERR_OR_ZERO(xpcs);
> > -     } else if (priv->plat->mdio_bus_data &&
> > -                priv->plat->mdio_bus_data->pcs_mask) {
> > -             addr =3D ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
> > -             xpcs =3D xpcs_create_mdiodev(priv->mii, addr);
> > -             ret =3D PTR_ERR_OR_ZERO(xpcs);
> > -     } else {
> > +     int ret;
> > +
> > +     if (!priv->plat->pcs_init)
> >               return 0;
> > -     }
>
> [Severity: Medium]
> Does this drop the generic handling of the "pcs-handle" property?  After
> this change, any snps,dwmac node whose firmware points "pcs-handle" at a
> Synopsys XPCS, but whose glue driver does not set plat->pcs_init, gets
> priv->hw->xpcs =3D=3D NULL and no message at all, since the function just
> returns 0.  "pcs-handle" is still a documented generic property in
> Documentation/devicetree/bindings/net/ethernet-controller.yaml.
>
> The changelog explains this is harmless because:
>
>     First, if a device tree specifies a "pcs-handle" but no select_pcs()
>     callback is provided by the platform driver, the created XPCS is neve=
r
>     used.
>
> Is that accurate?  The core consumes priv->hw->xpcs in two places that
> do not go through plat->select_pcs():
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_phy_setup() {
>         /* If we have an xpcs, it defines which PHY interfaces are suppor=
ted. */
>         if (priv->hw->xpcs)
>                 pcs =3D xpcs_to_phylink_pcs(priv->hw->xpcs);
>         else
>                 pcs =3D priv->hw->phylink_pcs;
>
>         if (pcs)
>                 phy_interface_or(config->supported_interfaces, ...);
> }
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_init_phy() {
>         if (priv->hw->xpcs &&
>             xpcs_get_an_mode(priv->hw->xpcs, mode) =3D=3D DW_AN_C73)
>                 return 0;
> }
>
> Without the XPCS, supported_interfaces stays limited to
> plat->phy_interface and the DW_AN_C73 "no PHY" path is lost, so
> stmmac_init_phy() can now fail where it previously succeeded.
>
> Related, for Intel mGbE the callbacks are only installed inside the
> SGMII/1000BASEX branch of intel_mgbe_common_data(), while the removed
> common code created an XPCS from "pcs-handle" regardless of interface
> mode.  Should a warning be emitted when "pcs-handle" is present but no
> pcs_init() claims it, or should the changelog state the behaviour change
> explicitly?

This removal is intentional. Phylink relies on select_pcs() to obtain the
PCS. Without that callback, the PCS is effectively never used, as phylink
has no way to obtain it. Requiring pcs_init() to be set is a way to ensure
that only platforms that know they need a PCS will create one.

The two places in stmmac_main.c that read priv->hw->xpcs directly
(stmmac_phy_setup and stmmac_init_phy) do so under the assumption that
the platform has already set up a working PCS. A platform with
"pcs-handle" but no pcs_init()/select_pcs() has never had a functional
PCS.

However, to make this behaviour change explicit and avoid silent failures,
I'll add a warning or a comment in the changelog describing the
requirement. If you prefer, I can also emit a diagnostic when
"pcs-handle" is present but no pcs_init() claims it.

> >
> > +     ret =3D priv->plat->pcs_init(priv);
> >       if (ret)
> >               return dev_err_probe(priv->device, ret, "No xPCS found\n"=
);
> [Severity: Low]
> This is a pre-existing wording problem and not introduced by this patch,
> but with the generic XPCS code gone this is now the only diagnostic in
> stmmac_pcs_setup(), and three of the four pcs_init() implementers do not
> create an XPCS:
>
>   socfpga_dwmac_pcs_init()  -> lynx_pcs_create_mdiodev()
>   rzn1_dwmac_pcs_init()     -> miic_create()
>   renesas_gmac_pcs_init()   -> miic_create()
>
> So a miic_create() or lynx_pcs_create_mdiodev() failure, including
> -EPROBE_DEFER, is reported as "No xPCS found".  Would something like
> "failed to initialise PCS" be more accurate here?

I'll change it to "Failed to initialize PCS".
