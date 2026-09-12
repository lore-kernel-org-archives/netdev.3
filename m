Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9023C3F62;
	Sat, 12 Sep 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244007; cv=none; b=Th0mlAJngFHy2ZVGNsjhimdQjpxqjcM/tsNHdUX8Apf+clqsl+BNGthIuJvgctSQ3/f2TvaD0jTFaP3gEGSbPdjtIwEbbfpyv27PljaPBEVS5/IWJubEkcfsA3K2KlxzOgRJCCKaJID9OBVNqY/GKQGBK7cwMoLAene+k2VLc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244007; c=relaxed/simple;
	bh=rk5unmeLlCUGthS3HI13XpmtAajnVpZ+A7JWb0zBtAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN3V3YilYUS5TzgeNpXFZR2bM8RZHACuDlbtKDGFtEnhUXVDULt88QWUs/f+dMrEqjOBZYxwG+K+CT+bf4Yn0GGlZKeRluj88ux2d0o2YYhwSlNHR3NdIfNZMqRRX9AuIOGrTe8NkCgSKYfOxMTYGQ7q/VC53g3jHkRarkX1qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFk7I55v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFk7I55v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3E21F000FF;
	Sat, 12 Sep 2026 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244002;
	bh=JtoUpb6McNb8j9Z4qP+rOvN+AYV7xXHpuSQDz0IbEJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EFk7I55vjqe2AiKGLYvCZHQw7wNr/JCb+JgkqtAe19BCOXtj+ON+hCWj8q+x/nqIc
	 AY41oLO8iFVcwf1khYooVFFjvoieVNx6amrTRHlh6/Zqe9OPhbKiOdUzjURzA7Y+VZ
	 bDNRGkqGAavN2q96TX79ZybNdMSvUSu7h4Hp/X8SjhFkODokmuILfhgL8Ri8VR5xB/
	 Ky4jBUkDTLQgWYHlQXmXEehGMyKM9nYMpLKn1ASZRls2eYvG0wO1MU31pkkyfposGj
	 yXHAgrK4vO4z7Xp5XFzz9YtMYLKkEuqmeD8KWoUm1Z3WdYht8cOXheIZJXlJUjQV/9
	 CfMuGev1upN9w==
From: Jakub Kicinski <kuba@kernel.org>
To: coiaprant@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vkoul@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	romain.gantois@bootlin.com,
	hkallweit1@gmail.com,
	neil.armstrong@linaro.org,
	linux@armlinux.org.uk,
	shawn.lin@rock-chips.com,
	david@ixit.cz,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/10] net: stmmac: move XPCS lifetime management to platform drivers
Date: Sat, 12 Sep 2026 13:13:13 -0700
Message-ID: <20260912201313.126882-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907153713.2572547-3-coiaprant@gmail.com>
References: <20260907153713.2572547-3-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: move XPCS lifetime management to platform drivers

This removes the generic XPCS creation and destruction code from
stmmac_pcs_setup() and stmmac_pcs_clean(), leaving those functions as
plain dispatchers to plat->pcs_init() and plat->pcs_exit().  The Intel
mGbE glue gains its own pcs_init()/pcs_exit() implementations, and the
renesas-gbeth, rzn1 and socfpga pcs_exit() callbacks now clear
priv->hw->phylink_pcs after destroying the PCS.

A few questions on the changelog and on the removed common code below.

[Severity: Medium]
Three statements in the commit message do not seem to match the tree
this patch applies to.

First:

    Address all of these issues by introducing pcs_init() and pcs_exit()
    callbacks in plat_stmmacenet_data.

Are these callbacks actually introduced here?  Both function pointers
already exist in struct plat_stmmacenet_data at the baseline:

	int (*pcs_init)(struct stmmac_priv *priv);
	void (*pcs_exit)(struct stmmac_priv *priv);

and this patch does not touch include/linux/stmmac.h at all.  The
baseline stmmac_pcs_setup() and stmmac_pcs_clean() already call them.

Second:

    Second, and more critically, when stmmac_pcs_setup() fails to create
    an XPCS (either because no pcs-handle is present and no pcs_mask is
    configured), it falls through to the else branch and leaves
    priv->hw->xpcs as NULL. This will silently override any XPCS that a
    platform driver may have already set up

Is that the branch that causes the override?  In the baseline that arm
returns immediately:

drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_pcs_setup() {
	if (priv->plat->pcs_init) {
		ret = priv->plat->pcs_init(priv);
	} else if (fwnode_property_present(devnode, "pcs-handle")) {
	...
	} else {
		return 0;
	}
	...
	priv->hw->xpcs = xpcs;
}

so no XPCS pointer can be clobbered there.  The clobber only happens on
the plat->pcs_init branch, where the local xpcs stays NULL and the
unconditional priv->hw->xpcs = xpcs; afterwards overwrites whatever
pcs_init() stored.  Could the changelog describe that path instead?

Third:

    Existing platform drivers (intel, rzn1, socfpga) are updated to use
    the new callbacks by moving their XPCS creation and cleanup logic into
    pcs_init() and pcs_exit().

rzn1 and socfpga already used pcs_init()/pcs_exit() before this patch,
and neither creates an XPCS: rzn1_dwmac_pcs_init() calls miic_create()
and socfpga_dwmac_pcs_init() calls lynx_pcs_create_mdiodev().  The only
change for them is the added NULL assignment.  The patch also modifies
dwmac-renesas-gbeth.c, which the changelog does not mention.  Should
that list be corrected to intel only, plus a note about the pointer
clearing in renesas-gbeth, rzn1 and socfpga?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index f5f9fa67ecd77..fd5f01c8941c1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -603,13 +603,47 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
>  	plat->mdio_bus_data->needs_reset = true;
>  }
>  
> +static int intel_mgbe_pcs_init(struct stmmac_priv *priv)
> +{
> +	struct fwnode_handle *devnode, *pcsnode;
> +	struct dw_xpcs *xpcs = NULL;

[Severity: Low]
This isn't a bug, but is the NULL initializer still reachable here?
Both arms of the if/else below assign xpcs unconditionally, from
xpcs_create_fwnode() or xpcs_create_mdiodev(), and neither returns NULL.
In the common code this was moved from, the initializer mattered because
a fall-through left xpcs NULL and the call was guarded by
if (xpcs) xpcs_config_eee_mult_fact(...); that guard is now gone.

> +	int addr;
> +
> +	devnode = dev_fwnode(priv->device);
> +
> +	if (fwnode_property_present(devnode, "pcs-handle")) {
> +		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
> +		xpcs = xpcs_create_fwnode(pcsnode);
> +		fwnode_handle_put(pcsnode);
> +	} else {
> +		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
> +		xpcs = xpcs_create_mdiodev(priv->mii, addr);
> +	}
> +
> +	if (IS_ERR(xpcs))
> +		return PTR_ERR(xpcs);
> +
> +	xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
> +
> +	priv->hw->xpcs = xpcs;
> +	return 0;
> +}
> +
> +static void intel_mgbe_pcs_exit(struct stmmac_priv *priv)
> +{
> +	if (!priv->hw->xpcs)
> +		return;
> +
> +	xpcs_destroy(priv->hw->xpcs);
> +	priv->hw->xpcs = NULL;
> +}
> +

[ ... ]

> @@ -733,6 +767,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
>  	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
>  		plat->mdio_bus_data->pcs_mask = BIT_U32(INTEL_MGBE_XPCS_ADDR);
>  		plat->default_an_inband = true;
> +		plat->pcs_init = intel_mgbe_pcs_init;
> +		plat->pcs_exit = intel_mgbe_pcs_exit;
>  		plat->select_pcs = intel_mgbe_select_pcs;
>  	}
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> index 19f34e18bfef2..9af32c26f9c14 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -81,8 +81,11 @@ static int renesas_gmac_pcs_init(struct stmmac_priv *priv)
>  
>  static void renesas_gmac_pcs_exit(struct stmmac_priv *priv)
>  {
> -	if (priv->hw->phylink_pcs)
> -		miic_destroy(priv->hw->phylink_pcs);
> +	if (!priv->hw->phylink_pcs)
> +		return;
> +
> +	miic_destroy(priv->hw->phylink_pcs);
> +	priv->hw->phylink_pcs = NULL;
>  }
>  
>  static struct phylink_pcs *renesas_gmac_select_pcs(struct stmmac_priv *priv,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> index 13634965bc19a..01df4776edb3f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> @@ -35,8 +35,11 @@ static int rzn1_dwmac_pcs_init(struct stmmac_priv *priv)
>  
>  static void rzn1_dwmac_pcs_exit(struct stmmac_priv *priv)
>  {
> -	if (priv->hw->phylink_pcs)
> -		miic_destroy(priv->hw->phylink_pcs);
> +	if (!priv->hw->phylink_pcs)
> +		return;
> +
> +	miic_destroy(priv->hw->phylink_pcs);
> +	priv->hw->phylink_pcs = NULL;
>  }
>  
>  static struct phylink_pcs *rzn1_dwmac_select_pcs(struct stmmac_priv *priv,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d2889..6d4bc1fe8f751 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -539,8 +539,11 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
>  
>  static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
>  {
> -	if (priv->hw->phylink_pcs)
> -		lynx_pcs_destroy(priv->hw->phylink_pcs);
> +	if (!priv->hw->phylink_pcs)
> +		return;
> +
> +	lynx_pcs_destroy(priv->hw->phylink_pcs);
> +	priv->hw->phylink_pcs = NULL;
>  }
>  
>  static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb0..d2f77f0c223a7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -426,36 +426,15 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  int stmmac_pcs_setup(struct net_device *ndev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	struct fwnode_handle *devnode, *pcsnode;
> -	struct dw_xpcs *xpcs = NULL;
> -	int addr, ret;
> -
> -	devnode = dev_fwnode(priv->device);
> -
> -	if (priv->plat->pcs_init) {
> -		ret = priv->plat->pcs_init(priv);
> -	} else if (fwnode_property_present(devnode, "pcs-handle")) {
> -		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
> -		xpcs = xpcs_create_fwnode(pcsnode);
> -		fwnode_handle_put(pcsnode);
> -		ret = PTR_ERR_OR_ZERO(xpcs);
> -	} else if (priv->plat->mdio_bus_data &&
> -		   priv->plat->mdio_bus_data->pcs_mask) {
> -		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
> -		xpcs = xpcs_create_mdiodev(priv->mii, addr);
> -		ret = PTR_ERR_OR_ZERO(xpcs);
> -	} else {
> +	int ret;
> +
> +	if (!priv->plat->pcs_init)
>  		return 0;
> -	}

[Severity: Medium]
Does this drop the generic handling of the "pcs-handle" property?  After
this change, any snps,dwmac node whose firmware points "pcs-handle" at a
Synopsys XPCS, but whose glue driver does not set plat->pcs_init, gets
priv->hw->xpcs == NULL and no message at all, since the function just
returns 0.  "pcs-handle" is still a documented generic property in
Documentation/devicetree/bindings/net/ethernet-controller.yaml.

The changelog explains this is harmless because:

    First, if a device tree specifies a "pcs-handle" but no select_pcs()
    callback is provided by the platform driver, the created XPCS is never
    used.

Is that accurate?  The core consumes priv->hw->xpcs in two places that
do not go through plat->select_pcs():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_phy_setup() {
	/* If we have an xpcs, it defines which PHY interfaces are supported. */
	if (priv->hw->xpcs)
		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
	else
		pcs = priv->hw->phylink_pcs;

	if (pcs)
		phy_interface_or(config->supported_interfaces, ...);
}

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_init_phy() {
	if (priv->hw->xpcs &&
	    xpcs_get_an_mode(priv->hw->xpcs, mode) == DW_AN_C73)
		return 0;
}

Without the XPCS, supported_interfaces stays limited to
plat->phy_interface and the DW_AN_C73 "no PHY" path is lost, so
stmmac_init_phy() can now fail where it previously succeeded.

Related, for Intel mGbE the callbacks are only installed inside the
SGMII/1000BASEX branch of intel_mgbe_common_data(), while the removed
common code created an XPCS from "pcs-handle" regardless of interface
mode.  Should a warning be emitted when "pcs-handle" is present but no
pcs_init() claims it, or should the changelog state the behaviour change
explicitly?

>  
> +	ret = priv->plat->pcs_init(priv);
>  	if (ret)
>  		return dev_err_probe(priv->device, ret, "No xPCS found\n");

[Severity: Low]
This is a pre-existing wording problem and not introduced by this patch,
but with the generic XPCS code gone this is now the only diagnostic in
stmmac_pcs_setup(), and three of the four pcs_init() implementers do not
create an XPCS:

  socfpga_dwmac_pcs_init()  -> lynx_pcs_create_mdiodev()
  rzn1_dwmac_pcs_init()     -> miic_create()
  renesas_gmac_pcs_init()   -> miic_create()

So a miic_create() or lynx_pcs_create_mdiodev() failure, including
-EPROBE_DEFER, is reported as "No xPCS found".  Would something like
"failed to initialise PCS" be more accurate here?

>  
> -	if (xpcs)
> -		xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
> -
> -	priv->hw->xpcs = xpcs;
> -
>  	return 0;
>  }
>  

[ ... ]
