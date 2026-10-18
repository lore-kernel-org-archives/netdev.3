Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0147043B;
	Sun, 18 Oct 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320470; cv=none; b=EynzYpbiYdOWf+uuc88U9WQVRQRHHQ2dfwExPUbwNqZDfPfBlSM7x0hPykYu7iaKwajrW+Cid/u+gDrPbEgNLH86+OH/Rm0VKZf6arBYSWrqlCuLpxV+GoNwVqhqFdyUQE2M11Ydl/YvM5/SwvN8URAQYcsQjM271TK7mevSnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320470; c=relaxed/simple;
	bh=V+rXxFkcbfLrBeLA5fvqUz+Qp6bbOIoDFzKYc+vp8Bk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWWYQfAX/SJjW8RPdKYmdwjLQUkoRdRQ5LFtXK6hfebaCuhQJ+0T61hn7/BSapicEAdW30lO0SN6A7S6jvo4osZ102lE0sML9lBhpoTPYDYuXJbWUMcCVrX8zlPnD4F2iBvRHAHZH6j1mj6HT2YgI4Ta4Sw924Msi6Rqts7MK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPEalO6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPEalO6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593231F000C8;
	Sun, 18 Oct 2026 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792320462;
	bh=5hab7+141CDQa1JBhM1GvMqH/8AaEC11ek9yvkq2uC0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fPEalO6xUETTCLQJJT/mlPgbrqyjtJydGt/bhAGwWsovPYXyOkOBp4aaRwFA4Wo8J
	 G+WrRulRhyNHpDMuKhugSKWtS9L/y8oim7tjcaIUrhjO/kzgtMbu9dMh7RnNCDxz9a
	 9OL5c4OaKmBifWcbRriSd3wJHKG690aw2VpOP8Ooe+J1V7vdqKprEoqkVpyiiWs0ks
	 b78MlsSO+NX30tWF2BJQCY4u5mLfPx8hq1qEAwZ17C38W/VaYKK6uln33+Mdcv3d3R
	 I3id92GQj9ydDLczlg8VjW5T4bqhF/WSThBfDhURcgEn1GqlUYJSkkQ6XEoxlDDmPX
	 762ZrJEuMzB9A==
Subject:
 Re: [PATCH net-next v3 9/9] net: stmmac: qcom-ethqos: add Shikra EMAC support
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, lorenzo.bianconi@oss.qualcomm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Sun, 18 Oct 2026 10:47:40 +0000
Message-ID: <179232046091.3135.7041326304068020426@kernel.org>
In-Reply-To: <20261017-shikra_ethernet-v3-9-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-9-26a8beb44b8f@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new shikra_data descriptor
  (drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c:317-324) has…
- [Medium] The commit message justifies taking a second enable reference
  on 'stmmaceth' (by putting it in shikra_noc_clk_names, so it goes…

--

net: stmmac: qcom-ethqos: add Shikra EMAC support

This patch adds Shikra EMAC support. It registers the qcom,shikra-ethqos
compatible with a new shikra_data descriptor. The descriptor enables three
NOC clocks (stmmaceth, axi-noc, pcie-tile-axi-noc), whose rates are set
through an OPP table, and sets a 36-bit DMA address width.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 9c602755532e1..a4e083a8517d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -307,6 +307,22 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
>  	.dwmac4_addrs = &ethqos_dwmac4_addrs,
>  };
>  
> +static const char * const shikra_noc_clk_names[] = {
> +	"stmmaceth",

[Severity: Medium]
The commit message says that managing "stmmaceth" through the same
clk_bulk path:

  keeps the rate-setting and enable/disable together.

Is that accurate? The stmmac core still enables stmmac_clk by itself,
before the OPP vote is applied.

At probe, stmmac_probe_config_dt() calls
clk_prepare_enable(plat->stmmac_clk). That happens well before
qcom_ethqos_init_noc_clks() and ethqos_clks_config(ethqos, true) set up
the OPP.

On runtime resume and noirq system resume, stmmac_bus_clks_config()
enables stmmac_clk first, and only then calls the glue clks_config():

drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:stmmac_bus_clks_config() {
    ...
	if (enabled) {
		ret = clk_prepare_enable(plat_dat->stmmac_clk);
		...
		ret = clk_prepare_enable(plat_dat->pclk);
		...
		if (plat_dat->clks_config) {
			ret = plat_dat->clks_config(plat_dat->bsp_priv, enabled);
    ...
}

On suspend, ethqos_clks_config(false) calls dev_pm_opp_set_rate(dev, 0).
That reaches _disable_opp_table(), which drops the bandwidth, level and
required-opps votes but does not change clock rates. So stmmaceth stays at
120 MHz.

On the next resume, is stmmaceth then enabled at 120 MHz before
qcom_ethqos_set_opp() restores the VDD_CX required-opps vote? The binding
commit says that vote is needed when the NOC clocks are enabled.

If so, the second enable reference doesn't keep rate-setting and
enable/disable together. Should the commit message rationale be updated?

> +	"axi-noc",
> +	"pcie-tile-axi-noc",
> +	NULL,
> +};
> +
> +static const struct ethqos_emac_driver_data shikra_data = {
> +	.dma_addr_width = 36,
> +	.has_emac_ge_3 = true,
> +	.noc_clk_names = shikra_noc_clk_names,
> +	.num_noc_clks = ARRAY_SIZE(shikra_noc_clk_names) - 1,
> +	.rgmii_config_loopback_en = false,
> +	.dwmac4_addrs = &ethqos_dwmac4_addrs,
> +};

[Severity: Medium]
Is it intentional that shikra_data has no .rgmii_por and .num_rgmii_por?

Every other descriptor has a POR table. That includes the other
has_emac_ge_3 descriptors, emac_v3_0_0_data and emac_v4_0_0_data.

Shikra still uses the RGMII path. qcom_ethqos_probe() installs
ethqos_fix_mac_speed_rgmii() for every RGMII phy-mode, and the binding
requires the "rgmii" link clock for Shikra.

With num_rgmii_por == 0, the reset loop in ethqos_fix_mac_speed_rgmii()
does nothing:

	/* Reset to POR values and enable clk */
	for (i = 0; i < ethqos->num_rgmii_por; i++)
		rgmii_writel(ethqos, ethqos->rgmii_por[i].value,
			     ethqos->rgmii_por[i].offset);

Most of the programming after this loop is read-modify-write. It seems to
rely on the POR rewrite to clear bits left over from an earlier speed.

For example, in ethqos_rgmii_macro_init(), the 10/100 branch sets
SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN. The 1G branch only sets
PRG_RCLK_DLY and PRG_DLY_EN:

	if (speed != SPEED_1000) {
		...
		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN,
			      SDCC_HC_REG_DDR_CONFIG);
	} else {
		...
		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_PRG_DLY_EN,
			      SDCC_HC_REG_DDR_CONFIG);
	}

On v3/v4, the POR value 0x80040800 for SDCC_HC_REG_DDR_CONFIG clears this
bit first. After a 10/100 to 1G renegotiation on Shikra, would the external
RX clock delay stay enabled along with the 1G programmed delay?

The reverse case has the same problem. The 1G path and
ethqos_dll_configure() set DLL_EN, CK_OUT_EN, CDR_EN and CDR_EXT_EN in
SDCC_HC_REG_DLL_CONFIG. After a 1G to 10/100 change, nothing clears them,
even though the 10/100 path deliberately skips enabling the DLL:

	if (speed != SPEED_100 && speed != SPEED_10) {
		/* Set DLL_EN */
		rgmii_setmask(ethqos, SDCC_DLL_CONFIG_DLL_EN,
			      SDCC_HC_REG_DLL_CONFIG);

On v3/v4, the POR value 0x2004642c clears these bits.

The driver also never programs some fields itself.
SDCC_DDR_CONFIG_TCXO_CYCLES_CNT is one: the v3/v4 POR sets it to 4, which
matches the "52 * 4" comment in the PRG_RCLK_DLY calculation.

In rgmii-id mode, SDCC_HC_REG_DDR_CONFIG and SDCC_HC_REG_DLL_CONFIG2 are not
touched at all. On Shikra they keep whatever the hardware reset or the
bootloader left there.

Could Shikra get its own POR table? If skipping it is safe, could the
commit message explain why?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-shikra_ethernet-v3-0-26a8beb44b8f%40oss.qualcomm.com
