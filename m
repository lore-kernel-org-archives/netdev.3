Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152B3CB56C;
	Wed,  9 Sep 2026 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990466; cv=none; b=b1x9Ljxkwa2hJ7CRmPbe1plc/4Pj6r9l0tKZFA/r1vw3iAScrhkmHKvPcazXszIM8hxYXHxR+AfyY8BS2nqrVdwjP9gMX/AUb0IiY5B6055gSp/HIreWgDNNAJI1bgLSgWrhC7zbOOh3sUOeYIqKQkhgK28shP5ny4jec8XEwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990466; c=relaxed/simple;
	bh=Tz8tOJ1hpLXBu6wtbzVBED1+49xi9UwTmp1d9nIl3sA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evIEDKFsJIlYLAZHs77OzqDw+RGCWEa3v7wI42sBqRwsiBjLQS+8wRQDc41dy3o957fx7LWAymbySI5ZfM0wVPejwK/qsvPN/0OfZep7KTkXfb/vjMYYl64Sgi8LKDtqoMlWQ7h1TYykhX3m8/mk3l8AI1NTF7+84HqfuL3a7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAqbmZTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAqbmZTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7651F0089D;
	Wed,  9 Sep 2026 21:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990440;
	bh=Um4PbpNaoB+q7vOWgdXZlGyVbU8hxhqvNDsLIljAtb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XAqbmZTxfracJIfJtsVDYiUPyu4P/w3Prkqza/W4Wl55ZmUBFt1rApkdNEx5bktGy
	 0mJ+USy6+YxqfnbQRpGlIyGWpzuB2lXHqQN5TPxJXztJnG8XCxs1cUsudu4nVvZpOY
	 8Kqw/eelJU9vasLiz1PRGrvePxBtAHY6WuJ8it9pT1LSOkBMYrn8/PHGpLfGW4/R2y
	 f4Co+L4axqaPjEzwSfxiw1eXDM1hfFy973ovXJmVYtibKqiIWXE6N2c1nAu6THCU0r
	 Ys1j96psqh1AHlne7VFUKoD8RKd8+/BqkR+TAwz7DBl2LEcLtbCr16EsvhkgQnof68
	 /k1srFuwkV//A==
Subject:
 Re: [PATCH net-next 9/9] net: stmmac: qcom-ethqos: add Shikra EMAC support
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 09 Sep 2026 21:47:18 +0000
Message-ID: <178899043882.219967.17727623521559354388@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-9-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-9-a50765996035@oss.qualcomm.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] shikra_data (drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-
  ethqos.c:337-359) is the only ETHQOS platform descriptor without…
- [Medium] Shikra is the first compatible with a nonzero num_noc_clks, so
  qcom_ethqos_probe() now calls qcom_ethqos_init_noc_clks(), which ends…
- [Medium] The PTP clock rate (`clk_ptp_rate`) is captured from the
  `stmmaceth` clock before its rate is updated to 120MHz, leading to…

--

net: stmmac: qcom-ethqos: add Shikra EMAC support

Adds a qcom,shikra-ethqos compatible backed by a new shikra_data
descriptor.  The descriptor enables three NOC clocks (axi-noc,
pcie-tile-axi-noc, stmmaceth) at 120 MHz and sets a 36-bit DMA address
width.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index a31541506a4c9..f96680456472d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -328,6 +328,36 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
>  	},
>  };
>  
> +static const struct ethqos_noc_clk_cfg shikra_noc_clks[] = {
> +	{ "axi-noc", 120000000 },
> +	{ "pcie-tile-axi-noc", 120000000 },
> +	{ "stmmaceth", 120000000 },
> +};
> +
> +static const struct ethqos_emac_driver_data shikra_data = {
> +	.dma_addr_width = 36,
> +	.has_emac_ge_3 = true,

[Severity: Medium]
Note that this list programs the main MAC clock ("stmmaceth") to
120 MHz, and shikra_data is the first descriptor to do so.  That
interacts badly with how the PTP reference rate is captured earlier in
probe.

qcom_ethqos_probe() calls devm_stmmac_probe_config_dt() before any of
the clock rates are touched, and stmmac_probe_config_dt() has the
fall-back path:

	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
	if (IS_ERR(plat->clk_ptp_ref)) {
		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
		plat->clk_ptp_ref = NULL;
		dev_info(&pdev->dev, "PTP uses main clock\n");

so plat_dat->clk_ptp_rate is a snapshot of whatever rate the bootloader
left on stmmaceth.  Only afterwards do qcom_ethqos_init_noc_clks() and
ethqos_clks_config() move that same clock to the 120 MHz requested
above.  And ethqos_ptp_clk_freq_config() cannot repair the value,
because it bails out first thing when the fall-back was taken:

	if (!plat_dat->clk_ptp_ref)
		return;

Does that leave stmmac using a stale clk_ptp_rate for the sub-second
increment and addend programming, i.e. PTP timestamps that advance at
the wrong rate?  If the boot rate happens to be 0, the check in
stmmac_init_tstamp_counter() rejects it outright ("Invalid PTP clock
rate") and hwtstamping fails.

Admittedly this needs a DT that omits ptp_ref, which the
qcom,shikra-ethqos binding does not allow, so the window is narrow.
Still, since the core explicitly supports the fall-back, it would be
good to know the intent here: is ptp_ref mandatory for Shikra by
construction, or should the stmmaceth rate be established before
devm_stmmac_probe_config_dt() runs (or clk_ptp_rate re-read after the
rate change) so the two cannot disagree?

[Severity: Medium]
Is the missing .rgmii_por / .num_rgmii_por pair intentional here?  This is
the only descriptor in the file without a POR table; emac_v2_1_0_data,
emac_v2_3_0_data, emac_v3_0_0_data and emac_v4_0_0_data all supply a
six-entry table.

Since .link_clk_name is also unset, qcom_ethqos_probe() asks for the clock
named "rgmii":

	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");

so this instance takes the ethqos_fix_mac_speed_rgmii() path, where the
POR restore loop runs zero times:

	/* Reset to POR values and enable clk */
	for (i = 0; i < ethqos->num_rgmii_por; i++)
		rgmii_writel(ethqos, ethqos->rgmii_por[i].value,
			     ethqos->rgmii_por[i].offset);

With num_rgmii_por == 0, RGMII_IO_MACRO_CONFIG, RGMII_IO_MACRO_CONFIG2,
SDCC_HC_REG_DLL_CONFIG(2), SDCC_HC_REG_DDR_CONFIG and SDCC_USR_CTL are
never returned to a known baseline before the speed-specific
read-modify-write sequence runs.

Can that leave a stale delay setting across a speed change?  In
ethqos_rgmii_macro_init(), the non-1000 Mbps branch does:

	rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN,
		      SDCC_HC_REG_DDR_CONFIG);

while the SPEED_1000 branch only programs PRG_RCLK_DLY and sets
PRG_DLY_EN.  Neither branch clears the other branch's enable bit; on the
existing ge_3 platforms the POR write (DDR_CONFIG = 0x80040800, with
EXT_PRG_RCLK_DLY_EN clear) is what clears it.  Does a 10/100 to 1000 Mbps
renegotiation on Shikra therefore end up with the external RX clock delay
path enabled together with the 1 G programmed delay?  The first link-up
would likewise be configured on top of whatever the bootloader left in the
IO macro and DLL.

Alternatively, if Shikra is not an RGMII part, then the "rgmii" link clock
name and the absent .needs_sgmii_loopback look inconsistent with
emac_v4_0_0_data.  The commit message only says "similar to previous
platforms", which does not say which of the two it is.

> +	.noc_clk_cfg = shikra_noc_clks,
> +	.num_noc_clks = ARRAY_SIZE(shikra_noc_clks),

[Severity: Medium]
This is the first descriptor with a nonzero num_noc_clks, so it is also the
first to activate the NOC/OPP voting path in qcom_ethqos_probe().  Can that
leave a performance state vote behind on a probe failure?

qcom_ethqos_init_noc_clks() ends with:

	ret = dev_pm_opp_set_rate(dev, data->noc_clk_cfg[0].rate);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to set initial NOC OPP rate\n");

which programs axi-noc and, through the required-opps, raises the device's
genpd performance state.  The paired teardown is only installed later:

	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
	if (IS_ERR(ethqos->link_clk))
		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
				     "Failed to get link_clk\n");

	ret = ethqos_clks_config(ethqos, true);
	if (ret)
		return ret;

	ret = devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos);

So if devm_clk_get() returns -EPROBE_DEFER (rgmii clock provider not yet
registered) or -ENOENT on an incomplete DT, probe returns before
ethqos_clks_disable is registered and dev_pm_opp_set_rate(dev, 0) is never
issued.

Does the devm cleanup undo the vote?  _opp_table_kref_release() in
drivers/opp/core.c drops current_opp, clears the OF table and puts the
clock, but performs no OPP transition:

	if (opp_table->current_opp)
		dev_pm_opp_put(opp_table->current_opp);
	_of_clear_opp_table(opp_table);
	/* Release automatically acquired single clk */
	if (!IS_ERR(opp_table->clk))
		clk_put(opp_table->clk);

And on the genpd side, genpd_dev_pm_detach() only drops the attach-time
default pstate:

	/* Drop the default performance state */
	if (dev_gpd_data(dev)->default_pstate) {
		dev_pm_genpd_set_performance_state(dev, 0);
		dev_gpd_data(dev)->default_pstate = 0;
	}

which is 0 here because the required-opps live on the OPP table entries,
and genpd_remove_device() does not re-evaluate genpd->performance_state.
Does that mean the elevated VDD_CX and 120 MHz axi-noc vote survives with
no driver bound?

A narrower variant is the dev_pm_opp_set_rate() failure inside
ethqos_clks_config(true), which returns the error without lowering the vote
taken in qcom_ethqos_init_noc_clks().

Would it work to register the cleanup action (or call
dev_pm_opp_set_rate(dev, 0)) immediately after the initial vote, or to move
the initial vote into the existing ethqos_clks_config() sequence where
failures already lower it?

> +	.rgmii_config_loopback_en = false,
> +	.dwmac4_addrs = {

[ ... ]

> +	},
> +};
> +

[ ... ]

> @@ -957,6 +987,7 @@ static const struct of_device_id qcom_ethqos_match[] = {
>  	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
>  	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
>  	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
> +	{ .compatible = "qcom,shikra-ethqos", .data = &shikra_data},
>  	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
>  	{ }
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
