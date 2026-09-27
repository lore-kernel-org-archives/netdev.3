Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE683B585D;
	Sun, 27 Sep 2026 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790479735; cv=none; b=AjQt5bCXNZ0scwSVxn3mloow7bWflajlfmVwws31edRvb0Zm774k94uJM6VttZoYMsZm8MDQlZ0pIwVkjxnxbfvOnnyatlnb4Bqc/U4tR4pdXM6pHaHnoI/MF+HUxuGBFsU2rHEgDzs8BBLH9pnHlUv7ModUKMRk6TxM1Fz+bQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790479735; c=relaxed/simple;
	bh=gsts6d6x1u+7S1ZwEq4vim+z3A0KCbboCnFaPe4oUPw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XetKA8KPuSrykfXgBF0g1BX/S4Oy/LTzVsy/H6Qu95SRhQS0INFUugnzPN2/fWBGqebCHhtELeJSVztNz+ZBfgtTLEAxOYEU64qYT5BwnLCgUH8ujIgFXBPpjpypfdX4rVbxts+kJKrjuV+FULvqx+CmWGx4CQacjZtvbpOkfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/AZBRhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/AZBRhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC851F00898;
	Sun, 27 Sep 2026 03:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790479733;
	bh=T8rpIYRxynmwj+YRABxKQ0KfUWj0r0144BFAQo26olI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y/AZBRhhh5ofOp6wIPoGangQ/tgm6Xp4WgpEvyZMIrzB09IvsuHzfbLRNkw4+r4ae
	 KtZdcjgzIMk3ZVcT43g4jcWaaKhE/ylgOB4YW3hiXlUfPwM5BB5CTe+fpJ9+18pbI+
	 G7obYyL0VlEOE0nCtpOhmNw0WNNTnr51VeqSaoIyVJzg+GfhHerKNtR186mbXH0/H4
	 473Kv5ekO/MxAdohDugDOnY2jaGJ7tLrbiwW4XZDZZVBRPnoclY7tPSQlHsSQ9Tvmf
	 Fzrxz5Gl0vN3sjMrZC77Leyopm6EiAIWMat48rOGsyI0774/Ls5SOaHtq2VeaaCp69
	 0OpV243eC76dA==
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Add support for
 Agilex5 TSN GMAC with FPGA converter
From: netdev-bot+sashiko@kernel.org
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dinguyen@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 03:28:52 +0000
Message-ID: <179047973223.2160803.17475492528833274893@kernel.org>
In-Reply-To:
 <20260923021823.46649-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
References:
 <20260923021823.46649-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The DT binding's allOf conditional was not updated for the new
  compatible.
- [Medium] socfpga_agilex5_tsn_gmac_setup_plat_dat() rewrites every RGMII
  variant (rgmii, rgmii-id, rgmii-rxid, rgmii-txid) to…
- [Low] socfpga_get_plat_phymode() (dwmac-socfpga.c:76-79) now returns
  dwmac->mac_interface, the MAC-side interface selector, instead of…

--

net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter

This adds an "altr,socfpga-stmmac-agilex5-tsn" compatible for an Agilex5
board that has an FPGA GMII-to-RGMII converter between gmac1 and its PHY.
The new setup_plat_dat callback reuses the Agilex5 setup and forces GMII
for the MAC interface selector. It also rewrites any RGMII phy_interface
to plain RGMII.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d2889..0632105b420f1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -69,12 +69,13 @@ struct socfpga_dwmac {
>  	void __iomem *tse_pcs_base;
>  	void __iomem *sgmii_adapter_base;
>  	bool f2h_ptp_ref_clk;
> +	phy_interface_t mac_interface;
>  	const struct socfpga_dwmac_ops *ops;
>  };
>  
>  static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
>  {
> -	return dwmac->plat_dat->phy_interface;
> +	return dwmac->mac_interface;
>  }

[Severity: Low]
This isn't a bug, but socfpga_get_plat_phymode() now returns the MAC-side
interface selector, not plat_dat->phy_interface. The comment in
socfpga_gen10_set_phy_mode() was not changed:

	/* Overwrite val to GMII if splitter core is enabled. The phymode here
	 * is the actual phy mode on phy hardware, but phy interface from
	 * EMAC core is GMII.
	 */

With the TSN ops, phymode is GMII and the PHY hardware runs RGMII, so
this comment now says the opposite of what happens.

Could the helper be renamed? The comments in socfpga_gen5_set_phy_mode()
and socfpga_gen10_set_phy_mode() would also need updating to match.

[ ... ]

> @@ -670,10 +673,28 @@ static const struct socfpga_dwmac_ops socfpga_agilex5_ops = {
>  	.setup_plat_dat = socfpga_agilex5_setup_plat_dat,
>  };
>  
> +static void socfpga_agilex5_tsn_gmac_setup_plat_dat(struct socfpga_dwmac *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
> +
> +	socfpga_agilex5_setup_plat_dat(dwmac);
> +
> +	/* FPGA converter supplies RGMII delays; MAC uses GMII, PHY gets plain RGMII */
> +	dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
> +	if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
> +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> +}

[Severity: Medium]
Should phy-mode values that this hardware cannot support be rejected here?
At the moment every RGMII variant is turned into plain RGMII.

The commit message says the FPGA converter provides both the TX and RX
delays. Under the phy-mode rules in ethernet-controller.yaml, that leaves
"rgmii-id" as the only consistent DT value. "rgmii" means the PCB already
provides both delays. "rgmii-txid" and "rgmii-rxid" mean the PCB provides
one of them. The binding also says:

  # link. Thus the MAC should report a fatal error for any modes which
  # cannot be supported.

stmmac already has a path for this in stmmac_pltfr_probe():

	if (plat->has_internal_tx_delay || plat->has_internal_rx_delay) {
		plat->phy_interface =
			phy_fix_phy_mode_for_mac_delays(plat->phy_interface,
							plat->has_internal_tx_delay,
							plat->has_internal_rx_delay);
		if (plat->phy_interface == PHY_INTERFACE_MODE_NA)
			return dev_err_probe(&pdev->dev, -EINVAL,
					     "unsupported phy interface mode\n");
	}

When both delays are internal, phy_fix_phy_mode_for_mac_delays() converts
rgmii-id to rgmii. For any other mode it returns PHY_INTERFACE_MODE_NA.

This patch does its own conversion instead. A DT with phy-mode = "rgmii",
"rgmii-txid" or "rgmii-rxid" then probes with no error. The converter then
adds its own delay on top of the PCB delay.

The phy-mode enum in altr,socfpga-stmmac.yaml accepts all four RGMII
variants, so dtbs_check won't catch this either.

Would setting plat_dat->has_internal_tx_delay and has_internal_rx_delay
work here? That would let stmmac_pltfr_probe() do the conversion and the
validation.

> +
> +static const struct socfpga_dwmac_ops socfpga_agilex5_tsn_gmac_ops = {
> +	.set_phy_mode = socfpga_gen10_set_phy_mode,
> +	.setup_plat_dat = socfpga_agilex5_tsn_gmac_setup_plat_dat,
> +};
> +
>  static const struct of_device_id socfpga_dwmac_match[] = {
>  	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
>  	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
>  	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
> +	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_tsn_gmac_ops },

[Severity: Medium]
Does the allOf conditional in the binding also need the new compatible?

In Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml, the if
block matches only the plain Agilex5 string:

  - if:
      properties:
        compatible:
          contains:
            const: altr,socfpga-stmmac-agilex5
    then:
      properties:
        interrupts:
          minItems: 17
        ...
        dma-coherent: true
    else:
      properties:
        interrupts:
          maxItems: 1

        interrupt-names:
          maxItems: 1

        dma-coherent: false

The earlier binding patch in this series added
altr,socfpga-stmmac-agilex5-tsn to select and to the compatible enum. It
also says agilex5 should not be used as a fallback. A node with
"altr,socfpga-stmmac-agilex5-tsn", "snps,dwxgmac-2.10" therefore gets the
else constraints.

The driver treats this compatible as full Agilex5 XGMAC hardware. It calls
socfpga_agilex5_setup_plat_dat(), which sets up the XGMAC core, TSO, TBS
on TX queues 6/7 and cross-timestamping. The gmac1 node in
socfpga_agilex5.dtsi, which the TSN board overrides, has 17 interrupts and
dma-coherent.

Won't dtbs_check reject a correct TSN gmac1 node, and accept one with a
single interrupt and no dma-coherent? Should the if block match both
strings, for example:

          contains:
            enum:
              - altr,socfpga-stmmac-agilex5
              - altr,socfpga-stmmac-agilex5-tsn

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade%40altera.com
