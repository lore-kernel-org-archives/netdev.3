Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CB3D16EF;
	Thu, 17 Sep 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670289; cv=none; b=nRgfp1OmZl9fz6FWBOqiiqjhVdULGfYibAkxF08U6lsEPT+h1s6SxUGloyku1sngIYG/xrEcfJHr52sGnvGhTmNXaro/IlxUezuTsWgAQaziVxoSUIm6yDNWYKku5TGUk3AJD9wHy6Ys+bO4o2YqE0hqmYPMWErStc+6kSEQUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670289; c=relaxed/simple;
	bh=JBusg0CB798ntaOTMUEpsXUiiktFNNxILdyz9WqqgSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RiD7x7MEE5kRa8Skwe44vqRTr1QPw1IjONcAQD+uOEjwkbEhTJtd88kbYwjItBDLrlfXkjAHGErD2suL7rveECiubyekzeg5Z9UAzPgp9V+X1/CYuG+XNCljDgnI7645AsFTUVyiuROwmBCZBKc6iVbOzY/MHixlIHQkoHGRSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsSoSZes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsSoSZes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F1F1F000FF;
	Thu, 17 Sep 2026 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670287;
	bh=Yl0NIoaTbzqJUGwioU/MGVk1zJpCWvzCqfyTcfij6Dc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UsSoSZesD2MFZH9rCwaj7Gc1bo170eGg8BvlSC3/WwSqqtLBuusJaI82UdKYRYFNW
	 +2MVe7VjJW5STpBjkJUoQ/P5DeoQ9kS7E45GUej6ZJi2cnRBOJr1URc9d+q9WSPZu5
	 o+D3iUo90/k87HqbFn2u6oC8Sx9RKNwC5BHoZUwTNwQ1GmfNSoivfv42CR54AHVgjf
	 E6LGN/T2HGs2LHbGFLsc60NjSmDmt8/xHlanG/KM93KdBxNiY1KjG2TciM16RMUyJZ
	 fPFkbvsH76j3XI0Ak0FFqYqpLg8Ggx0V4RMkCaRy5qIwZkbYAI6nHQhv/uvTjlyVwP
	 DLE4y24ETx49Q==
Subject: Re: [PATCH net-next v6 01/11] net: stmmac: move XPCS lifetime
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
Date: Thu, 17 Sep 2026 18:38:05 +0000
Message-ID: <178967028545.22033.5966180145855511133@kernel.org>
In-Reply-To: <20260915123802.1561724-2-coiaprant@gmail.com>
References: <20260915123802.1561724-2-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] stmmac_pcs_setup()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:426) loses the only…

Pre-existing issues:
- [Medium] Clock reference leak in the XPCS constructor now invoked from
  intel_mgbe_pcs_init(): xpcs_init_clks() (drivers/net/pcs/pcs-…

--

net: stmmac: move XPCS lifetime management to platform drivers

This moves XPCS creation and destruction out of the common
stmmac_pcs_setup()/stmmac_pcs_clean() and into plat->pcs_init()/
plat->pcs_exit(), converts the Intel mGbE glue to create its own XPCS,
and makes the renesas-gbeth, rzn1 and socfpga pcs_exit() callbacks clear
priv->hw->phylink_pcs after destroying the PCS.

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

[Severity: Medium]
This isn't a bug introduced by this patch, but since the XPCS constructor
call now lives here, it may be worth noting: can the failure path inside
xpcs_init_clks() in drivers/net/pcs/pcs-xpcs.c leak the clk references?

xpcs_init_clks() takes the references and, if enabling fails, returns
without putting them back:

	ret = clk_bulk_get_optional(dev, DW_XPCS_NUM_CLKS, xpcs->clks);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to get clocks\n");

	ret = clk_bulk_prepare_enable(DW_XPCS_NUM_CLKS, xpcs->clks);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to enable clocks\n");

xpcs_create() then takes the error path:

	ret = xpcs_init_clks(xpcs);
	if (ret)
		goto out_free_data;

out_free_data calls xpcs_free_data() (mdio_device_put() plus kfree(xpcs)),
so xpcs_clear_clks() - the only caller of clk_bulk_put() - never runs and
the xpcs->clks array is freed with the references still held.

intel_mgbe_pcs_init() only receives an ERR_PTR here, so it has no way to
release them. Would adding clk_bulk_put() on the failed
clk_bulk_prepare_enable() path in xpcs_init_clks() be the right fix?

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
This removes the only generic reader of the documented "pcs-handle"
property (and of mdio_bus_data->pcs_mask). For a glue driver that does not
install plat->pcs_init, stmmac_pcs_setup() now returns 0 before looking at
the firmware node at all.

Does that make "pcs-handle" a silent no-op for the plain Synopsys
compatibles handled by dwmac-generic.c?

	static const struct of_device_id dwmac_generic_match[] = {
		{ .compatible = "snps,dwmac-4.10a"},
		{ .compatible = "snps,dwmac"},
		{ .compatible = "snps,dwxgmac-2.10"},

dwmac_generic_probe() sets no pcs_init, while "pcs-handle" is defined
generically in Documentation/devicetree/bindings/net/ethernet-controller.yaml
and imported unrestricted by snps,dwmac.yaml. Previously such a node got an
XPCS via xpcs_create_fwnode(); now priv->hw->xpcs stays NULL and the
former probe diagnostic ("No xPCS found" on -EPROBE_DEFER/-ENODEV) is gone
with nothing in its place. Should the bindings be updated, or should a
generic pcs_init helper keep honouring the property?

The commit message says:

    First, if a device tree specifies a "pcs-handle" but no select_pcs()
    callback is provided by the platform driver, the created XPCS is never
    used.

Is that accurate? priv->hw->xpcs has two consumers besides select_pcs().
stmmac_phylink_setup() uses it to widen the interface masks:

	/* If we have an xpcs, it defines which PHY interfaces are supported. */
	if (priv->hw->xpcs)
		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
	else
		pcs = priv->hw->phylink_pcs;

	if (pcs)
		phy_interface_or(config->supported_interfaces, ...

and stmmac_init_phy() uses it to skip PHY attachment:

	if (priv->hw->xpcs &&
	    xpcs_get_an_mode(priv->hw->xpcs, mode) == DW_AN_C73)
		return 0;

The commit message also says:

    Platforms that do not need an XPCS simply leave the callbacks as NULL
    and no change in behavior occurs.

For a platform that relied on the generic "pcs-handle" path, does behavior
change - narrowed config->supported_interfaces (and config->lpi_interfaces
when priv->dma_cap.eee is set), plus an unconditional PHY attach where the
DW_AN_C73 bypass used to apply?

There appear to be no in-tree DTS files pairing "snps,dwmac" with an
"snps,dw-xpcs" node today (RZ/N1, RZ/T2H, SoCFPGA and Rockchip all go
through glue that sets pcs_init, and pcs_mask is set only by dwmac-intel,
which this patch converts), and the gap is not filled later in the series -
at the end of the series stmmac_mdio.c still only dispatches to
plat->pcs_init and "pcs-handle" is parsed only by dwmac-intel,
dwmac-renesas-gbeth, dwmac-rzn1 and the new dwmac-rk. Could the commit
message state plainly that generic device tree XPCS attachment is being
removed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
