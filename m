Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4347424D64;
	Sun, 27 Sep 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526566; cv=none; b=iVnW1hYgyOIULVrT1vb1lfFUOVV2HB/SjxNJUjXcB6Un+/UaJCPz7hs+6dU3NK5t23Uzoar6jvt6CqSTT04K4zK2+oJIEsiFVukA3ZRusYDa/z0BSbmRmF5vn9tB8wo0KaJwpmNukRBbR4qOUzHrclgqGX4W57N9HKLlztYfLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526566; c=relaxed/simple;
	bh=WZrhzPU9ggaAPz6T902N9uW8zKhN+Vfr9kKmhl4UWOU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyh2Yl7mhccxonpoMpv8cTmHwZbEI97FU16b0u5dk6f/tbGwNUERf5sidZ1sxAIUST0uHyEKPKNKkQx798z8hiA914Y9vAOCvyHtaWZgL6xuLMGRUbQHwEkg/44GpUTjUghFgY7NpDe8BWvKdV+fBIUq30mD7uKhyxPR7M6sBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fasPIneY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fasPIneY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434BB1F00893;
	Sun, 27 Sep 2026 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526564;
	bh=zoTLegbFfnJOrfpouRcz/WJeOTR3x5k8yoa9csThsL4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fasPIneYM039A2YmPrOM+hwgTjDSA4RpxXcuABCxGj4qge9l8d8vOlRXpQUCuBKIf
	 EKDDxJhKdCWKMqDURCeksM8gBY7HCgJh8CqAWrVLo+hHtzlWriiotKkmwmV4dhEAeI
	 GIhwzy+b+gArY2IxjFLsmwQo9DzyTgeS4AidS3xsYcCcU0V+JlbowXGrR8XKTaZjzC
	 iMoYlU7rqRtNwZ8430QticP/BGWJZy4hOgL+fYPr8JRdW3yaFGO/6M3n7JFjLDw9fQ
	 LaTiVU99BI2uubFo4yectHfpuyYGEKmiAsnkfbDQZaE7HoJg7IP1mJ9fCZOPJX3/cl
	 dG554urWeC5/g==
Subject: Re: [PATCH net-next v15 9/9] net: stmmac: qcom-ethqos: add support
 for sa8255p
From: netdev-bot+sashiko@kernel.org
To: bartosz.golaszewski@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, vkoul@kernel.org,
 peppe.cavallaro@st.com, wens@kernel.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 shawnguo@kernel.org, festevam@gmail.com, jan.petrous@oss.nxp.com, s32@nxp.com,
 mohd.anwar@oss.qualcomm.com, romain.gantois@bootlin.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, mripard@kernel.org,
 christophe.roullier@foss.st.com, brgl@kernel.org, radu@rendec.net,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dfustini@tenstorrent.com,
 linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 bartosz.golaszewski@linaro.org
Date: Sun, 27 Sep 2026 16:29:21 +0000
Message-ID: <179052656185.2160803.1751830002645522416@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-9-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-9-e82f33720737@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With Wake-on-LAN armed, system suspend on sa8255p powers off
  the MAC's SCMI "core"/"mdio" domains, and on resume the EMAC wrapper…
- [Medium] The SCMI variant has no CSR/application clock, and nothing
  substitutes a rate for it.
- [Low] The new sa8255p (SCMI) variant accepts RGMII phy-modes but
  silently misconfigures them.
- [Low] The new comment in ethqos_scmi_setup() and the commit message
  misdescribe what the code does.

--

net: stmmac: qcom-ethqos: add support for sa8255p

This adds a new sa8255p variant to the qcom-ethqos glue driver. On this
variant, firmware handles power management over SCMI, and Linux models it
with power domains. It adds a new emac data variant with a fixed PTP clock
rate, plus a separate ethqos_scmi_setup() callback.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 509a5368e69a8..3d4bc950a72ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c

[ ... ]

> @@ -756,6 +788,80 @@ static int ethqos_hlos_setup(struct qcom_ethqos *ethqos,
>  	return 0;
>  }
>  
> +static const char *const ethqos_scmi_pd_names[] = { "core", "mdio" };
> +
> +static int ethqos_scmi_setup(struct qcom_ethqos *ethqos,
> +			     struct plat_stmmacenet_data *plat_dat)
> +{
> +	const struct dev_pm_domain_attach_data pd_data = {
> +		.pd_names	= ethqos_scmi_pd_names,
> +		.num_pd_names	= ARRAY_SIZE(ethqos_scmi_pd_names),
> +		.pd_flags	= PD_FLAG_DEV_LINK_ON,
> +	};
> +
> +	struct platform_device *pdev = ethqos->pdev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = devm_pm_domain_attach_list(dev, &pd_data, &ethqos->pds);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to attach power domains\n");

[Severity: Medium]
What happens to these two domains during system suspend when Wake-on-LAN
is armed?

devm_pm_domain_attach_list() creates virtual genpd devices through
genpd_dev_pm_attach_by_id(). Those devices have no parent:

drivers/pmdomain/core.c:genpd_dev_pm_attach_by_id() {
    ...
	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
	virt_dev->bus = &genpd_bus_type;
	virt_dev->release = genpd_release_dev;
	virt_dev->of_node = of_node_get(dev->of_node);
    ...
}

dpm_propagate_wakeup_to_parent() only passes wakeup_path to dev->parent.
It does not reach device-link suppliers, so device_awake_path(virt_dev)
stays false.

SCMI domains set GENPD_FLAG_ACTIVE_WAKEUP. Even so, genpd_finish_suspend()
falls through to genpd_sync_power_off():

	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
	    !device_out_band_wakeup(dev))
		return 0;

qcom_ethqos_probe() also sets plat_dat->pmt = true for this variant, so
WoL can be enabled with ethtool. With priv->wolopts set,
stmmac_pltfr_noirq_suspend() and stmmac_pltfr_noirq_resume() skip
pm_runtime_force_suspend() and pm_runtime_force_resume():

	if (!priv->wolopts) {
		/* enable the clk previously disabled */
		ret = pm_runtime_force_resume(dev);

As a result, ethqos_clks_config(true) does not run on resume.

If firmware really power-cycles the MAC and wrapper when the "core" and
"mdio" domains are turned off, can WoL fail to wake the system? Would the
SGMII loopback and FUNC_CLK_EN bits at rgmii_base also be lost, so that
stmmac_resume()->stmmac_hw_setup() hits the DMA SW-reset timeout that the
comment below describes?

On the HLOS variants, the single GDSC is the MAC's own pm_domain, so the
awake-path check applies to the MAC device itself. This looks specific to
the multi-domain attach used here. The kernel tree can't show whether
firmware actually removes power on that request.

> +
> +	/*
> +	 * The SerDes lane, its clocks and the MAC AXI/AHB clocks are owned by
> +	 * firmware and brought up through the SCMI power domains above. The
> +	 * MAC wrapper itself, however is in the kernel's register space: the
> +	 * wrapper bit that loops the PHY TX clock into the MAC's clk_rx_i -
> +	 * needed because no recovered RX clock exists yet - is not
> +	 * configured by firmware. Without it, clk_rx_i never toggles and the
> +	 * DMA SW-reset polled in dwmac4_dma_reset() never completes.

[Severity: Low]
Is this comment right about where the SerDes power comes from?

The sa8255p SerDes PHY binding (qcom,sa8255p-dwmac-sgmii-phy.yaml)
requires a power-domain of its own. phy-qcom-sgmii-eth-scmi.c votes for
it through the PHY device's runtime PM (devm_pm_runtime_enable() before
devm_phy_create()), and set_mode() sets its performance state.

qcom_ethqos_probe() still gets the "serdes" phy and installs
qcom_ethqos_serdes_powerup(). The PHY TX clock that is looped into
clk_rx_i therefore comes from serdes_powerup() in stmmac_open(), before
__stmmac_open()->stmmac_hw_setup(). It does not come from the "core" and
"mdio" domains attached above.

The current ordering works. Could the comment name the SerDes PHY's own
domain instead, so later changes to the SerDes or PM ordering are not
misled?

The commit message also says only:

  Unlike the previously supported variants, this one's power management
  is done in the firmware over SCMI. This is modeled in linux using power
  domains so add a new emac data variant and a separate setup callback.

Could it also mention the following?

  - The kernel still maps and programs the "rgmii" wrapper registers
    (SGMII loopback and FUNC_CLK_EN) at probe and on every runtime resume.
  - set_clk_tx_rate and dump_debug_regs are dropped for this variant.
  - A fixed 230.4 MHz PTP reference rate is hardcoded in
    emac_v4_0_0_scmi_data.

> +	 *
> +	 * Map the wrapper and program the same loopback/functional clock bits
> +	 * the non-firmware platforms rely on (see ethqos_clks_config) so the
> +	 * RX clock is present by the time the DMA engine is reset.
> +	 */

[ ... ]

> +	ret = devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos);
> +	if (ret)
> +		return ret;
> +
> +	plat_dat->clk_ptp_rate = ethqos->data->ptp_clk_rate;

[Severity: Medium]
The PTP rate gets a fixed value here, but what about the CSR clock?

The sa8255p binding has no clocks property. stmmac_probe_config_dt()
therefore fails devm_clk_get("stmmaceth") and leaves plat->stmmac_clk
NULL:

	plat->stmmac_clk = devm_clk_get(&pdev->dev,
					STMMAC_RESOURCE_NAME);
	if (IS_ERR(plat->stmmac_clk)) {
		dev_warn(&pdev->dev, "Cannot get CSR clock\n");
		plat->stmmac_clk = NULL;

dwmac4_core_init() then runs this on every stmmac_hw_setup():

	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
	writel((clk_rate / 1000000) - 1, ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);

With clk_rate == 0, won't this write 0xFFFFFFFF into
GMAC4_MAC_ONEUS_TIC_COUNTER? That would break the LPI/EEE timers, which
count in microseconds.

plat_dat->clk_ref_rate is not set either, so stmmac_usec2riwt() and
stmmac_riwt2usec() return 0:

	unsigned long clk = clk_get_rate(priv->plat->stmmac_clk);

	if (!clk) {
		clk = priv->plat->clk_ref_rate;
		if (!clk)
			return 0;

Would ethtool -C rx-usecs then fail the MIN_DMA_RIWT check, and would
rx-usecs be reported as 0?

> +
> +	switch (ethqos->phy_mode) {
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_SGMII:
> +		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_sgmii;
> +		break;
> +	default:
> +		break;
> +	}

[Severity: Low]
What happens here if the device tree sets an RGMII phy-mode on a
qcom,sa8255p-ethqos node?

qcom_ethqos_probe() accepts PHY_INTERFACE_MODE_RGMII, _ID, _RXID and _TXID
for every compatible, and the sa8255p binding does not constrain
phy-mode. For RGMII, this switch takes the default branch, so none of the
following happens:

  - no fix_mac_speed is installed
  - no set_clk_tx_rate is installed
  - no RGMII IO macro or DLL programming is done (emac_v4_0_0_scmi_data
    has no rgmii_por)

qcom_ethqos_set_sgmii_loopback() also returns early for non-SGMII modes.

The SCMI SerDes provider rejects RGMII as well:

drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c:qcom_dwmac_sgmii_phy_scmi_validate() {
	switch (submode) {
	case PHY_INTERFACE_MODE_SGMII:
	case PHY_INTERFACE_MODE_1000BASEX:
	case PHY_INTERFACE_MODE_2500BASEX:
		return 0;
	default:
		return -EINVAL;
    ...
}

With a phys property, qcom_ethqos_serdes_powerup()->phy_set_mode_ext()
fails at open time. Without one, the MAC runs in RGMII mode with no
wrapper configuration. In both cases probe succeeds, but the interface
never works.

Would it be better for ethqos_scmi_setup() to return -EINVAL for modes
that don't use the SerDes, or for the binding to limit phy-mode to an
enum, or both?

> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-qcom-sa8255p-emac-v15-0-e82f33720737%40oss.qualcomm.com
