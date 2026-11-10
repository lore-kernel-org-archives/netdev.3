Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341327;
	b=BigorPkiOnhXR6MTXa3DMM3hcgUpjp4SVWSAD5K2svPqVsCaR2JcmN0C7ZaMO6qRO0ut
	 l9Q7/VfrohoRe0hG13LBIq+8z0PQdK1WNUPC+3klXZu/OSIRcA4FfOD3veRDbC38JKeFe
	 x3zCWM321hnj+WfG7SFmr3No73HaFOg7a4UMkHzkGMrtvnYhGIDCAtnIYNX0Ur1v5pxkd
	 R0UHl59Lz4h2JDkmlTlk8+490lJBqcXWIqyUx3pevHfoc29b7JpaVkLQ/1y5Pa0CPCK72
	 n5XltNSLhiAp2Ui1rPTH99gwciZO9maUMiJnAoWFRabsNM7oP8ANEGblDt/Qp1ADIlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341327;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RLqXByamkZhJZ65JXbFgm2scLbRUIk2K/YyB3fLw6kI=;
	b=JWsqf39VoNxCGl8FUlsM+Oi9sUHupfBFf/Qq1zf2sq2Y5rPF2Oefp33+vCnGDTLeqWxO
	 +CzTL2bh5+hcrS8qy2fxozjtDLORNmTremer84j6A7BUDfpRS4/rrPcr5fqKLox0egCwy
	 grd8m3iEB5sAiVNrKAjBGVWzN73U6sUZvpc7zwZLLRYOY4ZU7O3ikO0GdqyE8Nrc0bukD
	 Mj8oL/6r1/cCVYiZfe9BA67mzcJS8bs8zaN7DdxNQBgXL4+TXIU6yAZFLnYL4Qb/LXsBE
	 Q+/PGL4X51iTyR3z3aPt95gVWcNkebKYpVt1FQucBe+Y5rkJMgH76Hcx88oqb/PCI+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Inoqt/Y6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D8606A320;
	Tue, 10 Nov 2026 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Inoqt/Y6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCB41F008A1;
	Tue, 10 Nov 2026 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341327;
	bh=RLqXByamkZhJZ65JXbFgm2scLbRUIk2K/YyB3fLw6kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Inoqt/Y6Ud+R20HCM4wfUapvecOwDM/U2H6VjptTnjQj/O01GUkxAbinHYO7ck9+J
	 56LHS4ItjN8gCoeTjrqSR8XmBgjzqT+Wu/dg67DHPve+WwC+PE2qhNnmon/K3zA6fY
	 B61xzmUB+fzuvC/jaiZDry5jVAkHhSw8wrNxt2Ri9ptBZ2+mxMv5b42eOISOq34qco
	 h6O0AizjOlJaFQzuqG2Maq4iBZMa0RAUfjN87ifHlSr4P/q2xf7nRjBFoT2hwHVuB/
	 1DFAibUWAZcHqLvCQrXzLKZLh8Xi4BFLU9swlvdccGNmJX1kXcvJFRsxBTWCSczutj
	 k8qQQynPgW0+w==
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Tue, 10 Nov 2026 12:08:44 -0800
Message-ID: <20261110200844.2190972-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104040320.18077-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20261104040320.18077-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter

This adds the "altr,socfpga-stmmac-agilex5-tsn" compatible for Agilex5
boards where an FPGA GMII-to-RGMII converter between the MAC and the PHY
supplies the RGMII delays. socfpga_get_plat_phymode() now returns a new
mac_interface field. The new setup_plat_dat callback forces that field
to GMII and rewrites any RGMII phy_interface to plain RGMII.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 6d4bc1fe8f751..131d2a98c863f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c

[ ... ]

>  static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
>  {
> -	return dwmac->plat_dat->phy_interface;
> +	return dwmac->mac_interface;
>  }

[Severity: Low]
This isn't a bug, but socfpga_gen5_set_phy_mode() and
socfpga_gen10_set_phy_mode() both still have this comment:

	/* Overwrite val to GMII if splitter core is enabled. The phymode here
	 * is the actual phy mode on phy hardware, but phy interface from
	 * EMAC core is GMII.
	 */

After this change, phymode comes from dwmac->mac_interface, which is the
MAC-side mode. For the agilex5-tsn compatible it is GMII while the PHY
runs RGMII, so the comment now says the opposite of what phymode holds.

Should the comment be updated to match the new meaning? The same applies
to the name socfpga_get_plat_phymode().

[ ... ]

> @@ -673,10 +676,28 @@ static const struct socfpga_dwmac_ops socfpga_agilex5_ops = {
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

[Severity: Medium]
mac_interface is forced to GMII for every phy-mode. phy_interface is only
rewritten for RGMII variants. What happens with phy-mode "sgmii" or
"1000base-x"? The altr,socfpga-stmmac.yaml phy-mode enum allows both for
this compatible.

In that case socfpga_get_plat_phymode() returns GMII.
socfpga_dwmac_fix_mac_speed() then disables the SGMII adapter on every
link-up and never turns it back on:

	if (sgmii_adapter_base)
		socfpga_sgmii_config(dwmac, false);
	...
	if ((phymode == PHY_INTERFACE_MODE_SGMII ||
	     phymode == PHY_INTERFACE_MODE_1000BASEX) && sgmii_adapter_base)
		socfpga_sgmii_config(dwmac, true);

socfpga_gen10_set_phy_mode() also skips its final enable:

	if (phymode == PHY_INTERFACE_MODE_SGMII)
		socfpga_sgmii_config(dwmac, true);

Meanwhile phylink and the Lynx PCS keep using the DT mode. The
GMII-to-SGMII adapter would stay disabled while an SGMII or 1000base-x
link comes up, and nothing reports the problem.

Should the GMII override also be guarded by phy_interface_mode_is_rgmii()?
The other option would be to reject non-RGMII modes for this compatible.

> +	if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
> +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;

[Severity: Medium]
If the converter always adds both the TX and RX delays, rgmii-id seems to
be the only phy-mode that describes the board consistently. Is that
right?

"rgmii", "rgmii-txid" and "rgmii-rxid" each describe the PCB as providing
the delay in at least one direction. The converter would then add its
delay on top of that. This code rewrites all of them to plain RGMII
without a warning, so the link could fail with no diagnostic.

The stmmac core already handles MACs with fixed internal delays. With
plat_dat->has_internal_tx_delay and has_internal_rx_delay set (as
dwmac-ultrarisc.c does), stmmac_pltfr_probe() runs:

	if (plat->has_internal_tx_delay || plat->has_internal_rx_delay) {
		plat->phy_interface =
			phy_fix_phy_mode_for_mac_delays(plat->phy_interface,
							plat->has_internal_tx_delay,
							plat->has_internal_rx_delay);
		if (plat->phy_interface == PHY_INTERFACE_MODE_NA)
			return dev_err_probe(&pdev->dev, -EINVAL,
					     "unsupported phy interface mode\n");
	}

When both delays are set, phy_fix_phy_mode_for_mac_delays() maps rgmii-id
to rgmii and returns PHY_INTERFACE_MODE_NA for the other three modes:

	if (mac_txid && mac_rxid) {
		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
			return PHY_INTERFACE_MODE_RGMII;
		return PHY_INTERFACE_MODE_NA;
	}

Documentation/devicetree/bindings/net/ethernet-controller.yaml says this
about MACs with hard coded delays:

  It does however mean that a 'phy-mode' of 'rgmii' is now invalid, it
  cannot be supported, [...] Thus the MAC should report a fatal error for
  any modes which cannot be supported.

Could has_internal_tx_delay and has_internal_rx_delay replace the
open-coded rewrite here? Then inconsistent phy-modes would be rejected at
probe time.

> +}
> +
> +static const struct socfpga_dwmac_ops socfpga_agilex5_tsn_gmac_ops = {
> +	.set_phy_mode = socfpga_gen10_set_phy_mode,
> +	.setup_plat_dat = socfpga_agilex5_tsn_gmac_setup_plat_dat,
> +};

[ ... ]
