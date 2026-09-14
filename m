Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175A46D573;
	Mon, 14 Sep 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417481; cv=none; b=bP2Z7oYTcVmY1xGLwFJr1f/M7SRksT4YLmKOUPGxh8CzyPjabmja41aQyah+pPP3lvVaEnmNcnG2XdnnNHhlyLzgY5LFi7stPx2iR8//1ECfCTPwgc1bhufMONTvfoebTWKv4UgNElF8gB6vGwvZ0AGCL9/7hEpbgHIZEHS5SR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417481; c=relaxed/simple;
	bh=i9ZUDU2F2FGWMeO9GW8ycRXVCKukXCPguAW6h5niXkE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qz+oSwNF/AnmbEltmE4UlQtc2bV5AabQ0EwZk8SYoaDd4R7iTvPIu/dzu3MB9QaJTqc/XxWZwi3N+M35gSqjK+dzs70KkjKtIV0Wi2hHbC7o724NbN5j0nQwsfnB8z+AP+Xj7Q/9b6Jn0wv88KGRamoSoYQ9IpWlukaAsN2AL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3ZZ+FSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3ZZ+FSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F881F000FF;
	Mon, 14 Sep 2026 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417476;
	bh=w7u0klR/IYUoGVOagYiSZ6HuUkgEjMwxzSC/jxfPsQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a3ZZ+FSyFcr4SLQqyug8gOzfrkQByO+wC7LUaFlE64JBvjeqHk170lvQkBTR+Fqci
	 m7PXm5OX8yCqHyCxCkO5gVaspHgasepSHjUbGzs/vNCXvdZjPKiEufKqzTBSoNhdTd
	 Kizf80RvRTTw+PMZbu9uIOBJV/+jjkH9GqaK0xi3Do1IuJ/MymwXv9h+ZFbHdhT0tV
	 lQc8FfQyYD2yxFgcxhDWnBb8VQdeN9uuYmCRi97+rSC8oiesh6yTnziNmhtVegZx4m
	 267+LpqHhdeZqq9dMFoahSzZuD+CDpKvKZmOMTIOlESmletw9JZG6Y//+WqkWmrMAN
	 PAP+F5yHSFTsA==
Subject: Re: [PATCH net-next v5 01/11] net: stmmac: move XPCS lifetime
 management to platform drivers
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
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
Date: Mon, 14 Sep 2026 20:24:35 +0000
Message-ID: <178941747507.22033.8211069120708719813@kernel.org>
In-Reply-To: <20260913185849.907479-2-coiaprant@gmail.com>
References: <20260913185849.907479-2-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] Commit message mischaracterizes the removal of the generic
  XPCS creation as removing dead code.
- [Medium] DT binding vs implementation mismatch: after this patch
  nothing in the stmmac core reads the generic 'pcs-handle' property,…
- [Low] The commit message describes two defects, one framed as "more
  critically" (the common code overwriting priv->hw->xpcs after a…

--

net: stmmac: move XPCS lifetime management to platform drivers

The generic XPCS creation in stmmac_pcs_setup() (pcs-handle lookup and
mdio_bus_data->pcs_mask based xpcs_create_mdiodev()) is removed, leaving
only the plat->pcs_init() / plat->pcs_exit() dispatch. The Intel mGbE glue
grows its own pcs_init()/pcs_exit() that create and destroy the XPCS, and
the renesas-gbeth, rzn1 and socfpga pcs_exit() callbacks now clear
priv->hw->phylink_pcs after destroying the PCS.

A few questions on the commit message and on the removal of the generic
path.

>     First, if a device tree specifies a "pcs-handle" but no select_pcs()
>     callback is provided by the platform driver, the created XPCS is never
>     used. The phylink framework requires select_pcs() to actually return
>     the PCS to the core, so the pcs-handle property becomes effectively
>     useless without the matching callback.

[Severity: Medium]
Is "the created XPCS is never used" accurate?  An XPCS stored in
priv->hw->xpcs has two consumers that do not go through select_pcs().

stmmac_phylink_setup() in stmmac_main.c uses it to widen the phylink
interface sets:

	/* If we have an xpcs, it defines which PHY interfaces are supported. */
	if (priv->hw->xpcs)
		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
	else
		pcs = priv->hw->phylink_pcs;

	if (pcs)
		phy_interface_or(config->supported_interfaces, ...

and stmmac_init_phy() uses it to decide whether to attach a PHY at all:

	if (priv->hw->xpcs &&
	    xpcs_get_an_mode(priv->hw->xpcs, mode) == DW_AN_C73)
		return 0;

So for a dwmac instance with a pcs-handle but no plat->pcs_init, does this
change narrow config->supported_interfaces (and config->lpi_interfaces) and
alter the PHY-attach decision, rather than just dropping something unused?
Would it be worth spelling that behavioural change out in the commit
message?

>     Second, and more critically, when a platform driver sets pcs_init()
>     and creates an XPCS inside that callback, the common code afterwards
>     still runs unconditionally and overwrites priv->hw->xpcs with the
>     local xpcs variable, which stays NULL. The platform driver has no way
>     to prevent this override because the common code runs after the
>     platform-specific initialization.

[Severity: Low]
This isn't a bug, but could this paragraph say that no in-tree platform is
affected today?

All three pre-existing pcs_init() implementations store their PCS in
priv->hw->phylink_pcs, not priv->hw->xpcs:

  renesas_gmac_pcs_init()  -> priv->hw->phylink_pcs = miic_create(...)
  rzn1_dwmac_pcs_init()    -> priv->hw->phylink_pcs = miic_create(...)
  socfpga_dwmac_pcs_init() -> priv->hw->phylink_pcs = pcs

so the old "priv->hw->xpcs = xpcs;" on the pcs_init branch overwrote NULL
with NULL.  intel_mgbe_pcs_init() added here is the first in-tree pcs_init()
that stores an XPCS, which makes this a refactor that removes a latent trap
rather than a fix for observable breakage.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index f5f9fa67ecd77..4308dccbf2570 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -603,13 +603,47 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
>  	plat->mdio_bus_data->needs_reset = true;
>  }
>  
> +static int intel_mgbe_pcs_init(struct stmmac_priv *priv)
> +{
> +	struct fwnode_handle *devnode, *pcsnode;
> +	struct dw_xpcs *xpcs;
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

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb0..7396b68899c66 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -426,35 +426,14 @@ int stmmac_mdio_reset(struct mii_bus *bus)
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
>  
> +	ret = priv->plat->pcs_init(priv);
>  	if (ret)
> -		return dev_err_probe(priv->device, ret, "No xPCS found\n");
> -
> -	if (xpcs)
> -		xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
> -
> -	priv->hw->xpcs = xpcs;
> +		return dev_err_probe(priv->device, ret, "Failed to initialize PCS\n");
>  
>  	return 0;
>  }

[Severity: Medium]
After this change, does anything in the stmmac core still read the generic
"pcs-handle" property?

The property is still documented generically in
Documentation/devicetree/bindings/net/ethernet-controller.yaml:

  pcs-handle:
    $ref: /schemas/types.yaml#/definitions/phandle-array
    items:
      maxItems: 1
    description:
      Specifies a reference to a node representing a PCS PHY device on a MDIO
      bus to link with an external PHY (phy-handle) if exists.

and snps,dwmac.yaml $refs ethernet-controller.yaml and ends with
"additionalProperties: true", so pcs-handle stays schema-valid on every
dwmac node regardless of which glue is bound.

On a glue that does not set plat->pcs_init, stmmac_pcs_setup() now returns 0
without looking at the property, priv->hw->xpcs stays NULL, and nothing is
logged - whereas the removed code would at least fail probe with
"No xPCS found" for a bad phandle.  Should the binding be updated to say
pcs-handle is only honoured by specific glue drivers, or should the core
keep a generic path (or emit a warning) so the two agree?

The same question applies to struct stmmac_mdio_bus_data.pcs_mask.
stmmac_mdio_register() still treats it as "a PCS lives at these MDIO
addresses" and masks them out of the bus scan:

	new_bus->phy_mask = mdio_bus_data->phy_mask | mdio_bus_data->pcs_mask;

but no core code creates a PCS for those addresses any more, only
dwmac-intel's private intel_mgbe_pcs_init().  Does a glue that sets
pcs_mask without pcs_init now end up with that address neither scanned as a
PHY nor instantiated as a PCS?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
