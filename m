Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183A3CB8FF;
	Wed,  9 Sep 2026 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990453; cv=none; b=bhnkeGiTx8frq+ZSWuuNXVaBQ0XBuwnESZyvozhKzN2nb14r7xUXbkWUUUuwFdhiQMH1ES9atKVFl3UljsqxaN4IPt14IO5PKrvL1tHvIS1F2p8nyd9FjYKNAl5Vl0Hrpd7NeFOtnisUxEJqPCvY1ylNXEgByY6ch+6LdqelDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990453; c=relaxed/simple;
	bh=8UjF79UMzrjRdzbcoEST5V7GkCdM3ZKnBNl/7fPJOng=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPjGlts+n9mAdGsNMVN0P+FIg5+qo6+a+10ZeR2ie6rFRA0G6YMpMxsTy8LylLwmGXQvb5/RrPfLiTxHrxE2pF718NZY86gbaBQHjWjlgseiKxbG1w0Zgp41bwK4EpYVvul9NSa0M6jOOdmYGV2lXFIYPj625rXlPK651xgJciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVXjXBUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVXjXBUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDDC1F0089B;
	Wed,  9 Sep 2026 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990438;
	bh=b2bY2Hub+SpZQObKGH18+rjbZSyIPstkqYWfKls+4LU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RVXjXBUV4HlAflLQ3q+oqew72NDkWjHS6Oc3IIUlF9KwXQkYJ+a6HY3Bo4hUzrvo1
	 pMzRyCoKA4dJPVOxBOuvIxxkmy4f/UH+nY0YQFcnPI3eNPZxQzUOAiEqwtF/woQbUM
	 MG9XLE8yVgCyvjG5rFmIJt2wJqTQ4GPs1LTB8PuDxprCKeqvCZeKtAOZORd+EaKWu3
	 f1GJ0RxyVeuWGlYYv6sU3kRMnq2fdgZZ+EvQwJYXksh+rJxu8C0i6dc46nNpzydAIK
	 6i+6Myui6K3iraBSZ2hbE5Fda6S20JElabb97S9n9CsIr2a9EMLBvrwzOVYCmOTx1D
	 tjGaagutFVtxw==
Subject: Re: [PATCH net-next 8/9] net: stmmac: qcom-ethqos: add per-platform
 NOC clock voting
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
Date: Wed, 09 Sep 2026 21:47:16 +0000
Message-ID: <178899043644.219967.16301993674109894726@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-8-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-8-a50765996035@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 2 (1)

- [High] Incorrect power sequencing order in ethqos_clks_config() error
  path drops OPP performance state before disabling dependent clock.
- [Medium] Missing PM_OPP Kconfig dependency and undisclosed OPP/DT
  requirement: qcom_ethqos_init_noc_clks()…
- [Medium] Probe-time OPP/performance-state vote is never withdrawn on
  later probe failures.
- [Low] ETHQOS_MAX_NOC_CLKS is introduced but never enforced:
  qcom_ethqos_init_noc_clks() (dwmac-qcom-ethqos.c:809-815) copies…
- [Low] Concern that the added NOC-clock/OPP infrastructure (struct
  ethqos_noc_clk_cfg, the new driver-data and runtime fields,…

Pre-existing issues:
- [Low] Concern that
  Documentation/devicetree/bindings/net/qcom,ethqos.yaml documents…

--

net: stmmac: qcom-ethqos: add per-platform NOC clock voting

Adds struct ethqos_noc_clk_cfg plus driver-data and runtime fields so each
compatible can declare its own set of System NOC clocks with per-clock
rates.  The clocks are acquired in probe via qcom_ethqos_init_noc_clks()
and enabled/disabled next to the link clock in ethqos_clks_config(), with
the OPP framework used to carry the VDD_CX performance state.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 4f9bef662c579..a31541506a4c9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -7,6 +7,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_opp.h>
>  
>  #include "stmmac.h"
>  #include "stmmac_platform.h"
> @@ -84,11 +85,18 @@
>  
>  #define SGMII_10M_RX_CLK_DVDR			0x31
>  
> +#define ETHQOS_MAX_NOC_CLKS			3
> +
>  struct ethqos_emac_por {
>  	unsigned int offset;
>  	unsigned int value;
>  };
>  
> +struct ethqos_noc_clk_cfg {
> +	const char *id;
> +	unsigned long rate;
> +};
> +
>  struct ethqos_emac_driver_data {
>  	const struct ethqos_emac_por *rgmii_por;
>  	unsigned int num_rgmii_por;
> @@ -98,6 +106,8 @@ struct ethqos_emac_driver_data {
>  	const char *link_clk_name;
>  	struct dwmac4_addrs dwmac4_addrs;
>  	bool needs_sgmii_loopback;
> +	const struct ethqos_noc_clk_cfg *noc_clk_cfg;
> +	unsigned int num_noc_clks;
>  };
>  
>  struct qcom_ethqos {
> @@ -112,6 +122,10 @@ struct qcom_ethqos {
>  	bool rgmii_config_loopback_en;
>  	bool has_emac_ge_3;
>  	bool needs_sgmii_loopback;
> +
> +	struct clk_bulk_data noc_clks[ETHQOS_MAX_NOC_CLKS];
> +	unsigned long noc_clk_rates[ETHQOS_MAX_NOC_CLKS];
> +	int num_noc_clks;
>  };
>  
>  static u32 rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
> @@ -691,15 +705,51 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
>  static int ethqos_clks_config(void *priv, bool enabled)
>  {
>  	struct qcom_ethqos *ethqos = priv;
> +	unsigned int i;
>  	int ret = 0;
>  
>  	if (enabled) {
> +		if (ethqos->num_noc_clks) {

[Severity: Low]
This isn't a bug, but as submitted every new block here and in
qcom_ethqos_init_noc_clks() is gated on ethqos->num_noc_clks, and no
ethqos_emac_driver_data entry in this commit sets .noc_clk_cfg or
.num_noc_clks, so none of the new code runs yet.  The consumer arrives
later in the series with "net: stmmac: qcom-ethqos: add Shikra EMAC
support", which adds shikra_noc_clks[] and
{ .compatible = "qcom,shikra-ethqos", .data = &shikra_data }, so the
infrastructure does get exercised by the end of the series.  Was the split
intentional?

> +			ret = dev_pm_opp_set_rate(&ethqos->pdev->dev,
> +						  ethqos->noc_clk_rates[0]);
> +			if (ret) {
> +				dev_err(&ethqos->pdev->dev,
> +					"NOC OPP rate set failed: %d\n", ret);
> +				return ret;
> +			}
> +

[Severity: High]
The unwind order here looks inverted with respect to the disable
path added a few lines below.  When clk_bulk_prepare_enable() on
ethqos->noc_clks fails, this drops the performance state with
dev_pm_opp_set_rate(&ethqos->pdev->dev, 0) first and only then calls
clk_disable_unprepare(ethqos->link_clk), so between the two calls the
link clock is still running while the VDD_CX vote taken by the earlier
dev_pm_opp_set_rate(dev, ethqos->noc_clk_rates[0]) has already been
released.  The !enabled branch of the same function does it the other
way around - clk_bulk_disable_unprepare(), clk_disable_unprepare(link_clk),
then dev_pm_opp_set_rate(dev, 0) - which is the sequence I would expect
if the clocks require the vote to be held while they are ungated.

The same concern applies to the clk_prepare_enable(ethqos->link_clk)
failure just above, although there nothing else is enabled yet so the
ordering is moot.

Is the ordering in the error path deliberate, or should these two calls
be swapped so that every unwind mirrors the disable sequence?  If the
hardware genuinely does not care about the relative order of the vote
and the link clock, it would still be worth keeping the error path and
the disable path identical so the intended sequencing is obvious to the
next reader.

[ ... ]

> @@ -736,6 +791,46 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
>  	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
>  }
>  
> +/* Some SoCs gate NOC access behind dedicated clocks. Acquire them here
> + * so ethqos_clks_config() can enable/disable them at runtime. The OPP
> + * table is used to propagate the required VDD_CX performance state via
> + * dev_pm_opp_set_rate().
> + */
> +static int qcom_ethqos_init_noc_clks(struct qcom_ethqos *ethqos,
> +				     const struct ethqos_emac_driver_data *data)
> +{
> +	struct device *dev = &ethqos->pdev->dev;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!data->num_noc_clks)
> +		return 0;
> +
> +	for (i = 0; i < data->num_noc_clks; i++) {
> +		ethqos->noc_clks[i].id = data->noc_clk_cfg[i].id;
> +		ethqos->noc_clk_rates[i] = data->noc_clk_cfg[i].rate;
> +	}
> +	ethqos->num_noc_clks = data->num_noc_clks;

[Severity: Low]
Should this loop check data->num_noc_clks against ETHQOS_MAX_NOC_CLKS?
The macro is added by this patch but never enforced anywhere, while the
destinations are fixed-size members of the devm_kzalloc'd struct:

	struct clk_bulk_data noc_clks[ETHQOS_MAX_NOC_CLKS];
	unsigned long noc_clk_rates[ETHQOS_MAX_NOC_CLKS];

Today the only table added by the series (shikra_noc_clks[]) has exactly
three entries, so nothing overflows noc_clks[] or noc_clk_rates[] right
now.  A future driver-data entry with four clocks would write past both
arrays, and a table that sets .num_noc_clks without .noc_clk_cfg would
dereference NULL at data->noc_clk_cfg[i].  Would a static_assert() on each
table, or an explicit

	if (data->num_noc_clks > ETHQOS_MAX_NOC_CLKS)
		return -EINVAL;

be worth adding here?

> +
> +	ret = devm_clk_bulk_get(dev, ethqos->num_noc_clks, ethqos->noc_clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get NOC clocks\n");
> +
> +	ret = devm_pm_opp_set_clkname(dev, data->noc_clk_cfg[0].id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set OPP clock name\n");
> +
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add OPP table\n");

[Severity: Medium]
Does this need a Kconfig dependency on PM_OPP?

With CONFIG_PM_OPP=n, include/linux/pm_opp.h provides stubs that return
-EOPNOTSUPP for devm_pm_opp_set_clkname() (via devm_pm_opp_set_config()),
devm_pm_opp_of_add_table() and dev_pm_opp_set_rate(), and each call here
is turned into a probe failure by dev_err_probe().

config DWMAC_QCOM_ETHQOS in drivers/net/ethernet/stmicro/stmmac/Kconfig
currently has only:

	depends on OF && (ARCH_QCOM || COMPILE_TEST)

and config PM_OPP in drivers/opp/Kconfig is a promptless "bool", i.e.
select-only, so PM_OPP=n is a legal configuration for this driver.  In
that build, any compatible declaring NOC clocks would fail to probe and
no netdev would be created.  Should DWMAC_QCOM_ETHQOS select PM_OPP, or
should these calls be made conditional?

Also, devm_pm_opp_of_add_table() makes an operating-points-v2 node a hard
requirement for such compatibles.  The commit message says:

  "The clocks are acquired during probe and enabled/disabled alongside
   the existing link clock in ethqos_clks_config()."

Could the new mandatory OPP table / device tree requirement be mentioned
there too?

> +
> +	ret = dev_pm_opp_set_rate(dev, data->noc_clk_cfg[0].rate);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set initial NOC OPP rate\n");
> +
> +	return 0;
> +}
> +
>  static int qcom_ethqos_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -795,6 +890,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
>  	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
>  
> +	if (data->num_noc_clks) {
> +		ret = qcom_ethqos_init_noc_clks(ethqos, data);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
>  	if (IS_ERR(ethqos->link_clk))
>  		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),

[Severity: Medium]
Can the performance-state vote taken by the dev_pm_opp_set_rate() at the
end of qcom_ethqos_init_noc_clks() leak if probe fails right after?

The only code that drops it is ethqos_clks_config(priv, false) with its
dev_pm_opp_set_rate(dev, 0), and that path is installed only later in
probe:

qcom_ethqos_probe()
	qcom_ethqos_init_noc_clks()	/* dev_pm_opp_set_rate(dev, rate) */
	devm_clk_get(dev, "rgmii")	/* can return -EPROBE_DEFER */
	ethqos_clks_config(ethqos, true)
	devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos)

If devm_clk_get() defers or ethqos_clks_config(true) fails, probe returns
before ethqos_clks_disable is registered.  Devres teardown does not appear
to compensate: _opp_table_kref_release() and _opp_clear_config() in
drivers/opp/core.c do not call _set_opp_level(dev, NULL) or
_set_required_opps(..., NULL), and on the genpd side only the default
pstate is dropped:

drivers/pmdomain/core.c:genpd_dev_pm_detach() {
	...
	/* Drop the default performance state */
	if (dev_gpd_data(dev)->default_pstate) {
		dev_pm_genpd_set_performance_state(dev, 0);
		dev_gpd_data(dev)->default_pstate = 0;
	}
	...
}

so the VDD_CX vote requested through the OPP would stay in place for a
device that never bound, and genpd_remove_device() unlinks the device
without re-evaluating genpd->performance_state.

Is this initial dev_pm_opp_set_rate() needed at all?
ethqos_clks_config(ethqos, true) applies the same rate a few lines later
and _set_opp() early-returns when the OPP is unchanged, so dropping it (or
pairing it with its own devm action) would close the window.

[Severity: Low]
This isn't a bug introduced by this patch, but at this point in the series
Documentation/devicetree/bindings/net/qcom,ethqos.yaml already documents
qcom,shikra-ethqos with the axi-noc / pcie-tile-axi-noc clocks and a
required operating-points-v2 property, while qcom_ethqos_match[] has no
matching entry and no driver data setting .noc_clk_cfg / .num_noc_clks.
The pair becomes consistent with the later commit "net: stmmac:
qcom-ethqos: add Shikra EMAC support", which adds both the compatible and
shikra_data, so this is only a transient mismatch inside the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
