Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093473D4116;
	Fri, 11 Sep 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125932; cv=none; b=KTMFNHh5LeZorBwRu98b6GOmIt5GMOVceujrYDpLBn8T3Ijgj65XerJZU6tbRsz/3ax7j02vErTLTaisQsP4IomnV78n+GVu/NIkQbD4VUHrsLJNo2Ntad3luySwVntrKOZvAv6A6UJNoONO+Ceswsx/3KxLfE7G+0M3JyOI+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125932; c=relaxed/simple;
	bh=JGDTX2OStM2e37UgfWdfDt5r7ozgdUeUC3G7DcOvtvM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pA6aBTtVik8177w9Y6zw4s+GXoIrl17t/3S61+WkW9+AfTwvCrP0yrqVO68YTAPCw+M3e5rFlYpVrqY+cSJfdEbqJ84hBqjAXy1dUM0OnRGsJ8ocCH3PQLXR8uTwysbEVEuDl0lt0vUFtwpMddrEZ8UPrBBR37mmGCDpFjM9/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdtyzogD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdtyzogD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F421F000FF;
	Fri, 11 Sep 2026 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125923;
	bh=Giz3DgoV1Kkxp/ItQMDYkJ9vVxOeemBUbGyOg9d1k88=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RdtyzogDQ01XzqOUeKqOMt1W9a+vkJRa0bUdI0tJRjpEDw23pe71irCkBXep+h8HL
	 NPjaj6HHcA3bTHZxcz9mW63lA5QtGQV4/jqH+L3vJejZe5+XjKOgvRZVyvimGSVWTR
	 KR7sepXRjTkumHQdPTgKlyNL356VjyhA2XIGzA5ZAU345VmWeppoTOdJjmWGCs7dpa
	 4OWiNyiqtn+58AVocIzrYnyxj74thlDyi1iAOZAMACvBRHjnA648E7RvpbVH8fn3ZN
	 zG/NUkQIUGaTnJ27nRRwJQRewMdQuBJxkl/5aDpEB59QgE2Dlaq3t7MJGzq3T7VRf7
	 NJybqGTqBGJ2w==
Subject: Re: [PATCH net-next v2 8/9] net: stmmac: qcom-ethqos: add
 per-platform NOC clock voting
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
Date: Fri, 11 Sep 2026 11:25:21 +0000
Message-ID: <178912592132.219967.18300009845024056442@kernel.org>
In-Reply-To: <20260908-shikra_ethernet-v2-8-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-8-bbe3389d0652@oss.qualcomm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] New hard dependency on the PM_OPP subsystem is not expressed
  in Kconfig.

--

net: stmmac: qcom-ethqos: add per-platform NOC clock voting

This adds an ethqos_noc_clk_cfg description so each compatible can declare
its own set of System NOC clocks with per-clock rates. The clocks are
acquired in probe via qcom_ethqos_init_noc_clks() and enabled/disabled
alongside the link clock in ethqos_clks_config(), with an OPP table used to
propagate the VDD_CX performance state.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 2471871562ed9..8871d28594116 100644
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

[ ... ]

> @@ -689,15 +703,51 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
>  static int ethqos_clks_config(void *priv, bool enabled)
>  {
>  	struct qcom_ethqos *ethqos = priv;
> +	unsigned int i;
>  	int ret = 0;
>  
>  	if (enabled) {
> +		if (ethqos->num_noc_clks) {
> +			ret = dev_pm_opp_set_rate(&ethqos->pdev->dev,
> +						  ethqos->noc_clk_rates[0]);
> +			if (ret) {
> +				dev_err(&ethqos->pdev->dev,
> +					"NOC OPP rate set failed: %d\n", ret);
> +				return ret;
> +			}

[ ... ]

> @@ -734,6 +789,51 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
>  	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
>  }
>  
> +static void qcom_ethqos_noc_opp_cleanup(void *dev)
> +{
> +	dev_pm_opp_set_rate(dev, 0);
> +}
> +
> +/* Some SoCs gate NOC access behind dedicated clocks. Acquire them here
> + * so ethqos_clks_config() can enable/disable them at runtime. The OPP
> + * table is used to propagate the required VDD_CX performance state via
> + * dev_pm_opp_set_rate().
> + */
> +static int qcom_ethqos_init_noc_clks(struct qcom_ethqos *ethqos,
> +				     const struct ethqos_emac_driver_data *data)
> +{

[ ... ]

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
> +
> +	ret = dev_pm_opp_set_rate(dev, data->noc_clk_cfg[0].rate);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set initial NOC OPP rate\n");

[Severity: Medium]
Should DWMAC_QCOM_ETHQOS gain a PM_OPP dependency now that these calls are
mandatory for compatibles that declare NOC clocks?

The Kconfig entry currently reads:

drivers/net/ethernet/stmicro/stmmac/Kconfig:
config DWMAC_QCOM_ETHQOS
	tristate "Qualcomm ETHQOS support"
	default ARCH_QCOM
	depends on OF && (ARCH_QCOM || COMPILE_TEST)

There is no depends on PM_OPP and no select PM_OPP, and PM_OPP itself is a
hidden symbol with no prompt:

drivers/opp/Kconfig:
config PM_OPP
	bool

so CONFIG_DWMAC_QCOM_ETHQOS=y with CONFIG_PM_OPP=n is a reachable
configuration. In that case the stubs are used:

include/linux/pm_opp.h:
static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
{
	return -EOPNOTSUPP;
}
...
static inline int devm_pm_opp_of_add_table(struct device *dev)
{
	return -EOPNOTSUPP;
}

qcom_ethqos_probe() -> qcom_ethqos_init_noc_clks() ->
devm_pm_opp_set_clkname() would then return -EOPNOTSUPP, and the
dev_err_probe() above aborts probe with "Failed to set OPP clock name", so
no netdev is registered for any compatible that sets num_noc_clks
(qcom,shikra-ethqos, added later in this series).

The same applies on the runtime path: ethqos_clks_config(priv, true)
propagates the -EOPNOTSUPP from dev_pm_opp_set_rate() on every enable and
resume.

Would adding select PM_OPP (or depends on PM_OPP) to DWMAC_QCOM_ETHQOS, or
tolerating -EOPNOTSUPP on the OPP path, be preferable here?

> +
> +	return devm_add_action_or_reset(dev, qcom_ethqos_noc_opp_cleanup, dev);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-shikra_ethernet-v2-0-bbe3389d0652%40oss.qualcomm.com
