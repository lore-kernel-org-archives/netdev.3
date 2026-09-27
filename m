Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F6415F2C;
	Sun, 27 Sep 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526550; cv=none; b=NN9qUdp964fBaKr1WBd/uJ742x9KDP3HMUHIIKihTS6oUpHmXWDa7UMU88wRCJSyaHkOYoyWKJbK4eHnpnXVtUHpEcJ4UqcvLZViMwCLNPfPPq9wjFc2iJwhOhFiauiROv3u/1P70VmqhRQiEl2xbDhp5Zvk36Uaf85LTqCf6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526550; c=relaxed/simple;
	bh=nlsSCJDSH3JNQmZR4k1g1eYsOTarj6PK2qUb+7jfj1Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9J09s7AAiebnnX4qG2BXXgpoGHeGN/O2KXEGhKbk12hEHPSMUZhvPRTJGT/qqxST+14TSg967cIoWx00ho+ErzDOiyH3YuPGy9XMyk7ZfnJmEtp82fJmv3aMuowuq/4sPvWY0LmtCYerpW9G82m/P6v2aRzia91cCM//zcs+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeV6qE1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeV6qE1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196661F00893;
	Sun, 27 Sep 2026 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526549;
	bh=gB2hKJgtjbVyDE2VSgLSgN/qQRPT4zl7qwrfLFCXv+s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eeV6qE1hzM2d8E9hcolO5ZjxVRkrTviuTICOhmUr23hR62jbAyUoGMVN4qFe/Ihxz
	 NjJs2nh2ZXURvMLNMsrSvyD6azjA2FEABq8+pyowJ1omhdsgPkc7gAWJ47aOTW6UoP
	 g7qsUhPtlmv0Lnn8+klu2GBmz02LEIFCrCqThKWNGnjbtm03y3mHQNv7Sp+Yclg5ci
	 NLpafzd0hFGQKmJ54ER7Q3lyevwEBTQqA48gSTRf7zk6UXI8CTs2v2W+55ylwAd2m0
	 1OlnVz96oYa5qW/LO7trgmEPxEiRMA+C1kVV0AxmD1s1JNujTNdtE15no8SjtXpSid
	 0Yq5Q6DCsjC0w==
Subject: Re: [PATCH net-next v15 3/9] phy: qcom: add the SGMII SerDes PHY
 driver for SCMI systems
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
Date: Sun, 27 Sep 2026 16:29:06 +0000
Message-ID: <179052654668.2160803.9784389469045924659@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-3-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-3-e82f33720737@oss.qualcomm.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Nothing in the new SCMI SerDes PHY driver ever tells firmware
  to power the SerDes down or release its rate vote.

--

phy: qcom: add the SGMII SerDes PHY driver for SCMI systems

This adds a separate PHY driver for the firmware-managed SGMII/SerDes PHY
on Qualcomm sa8255p platforms. The driver never touches registers or
clocks. It turns the requested interface mode into a genpd performance
state (SPEED_1000 or SPEED_2500) and uses runtime PM on the provider
device for power votes.

> diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
> new file mode 100644
> index 0000000000000..c726a414eb6a4
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c

[ ... ]

> +static int qcom_dwmac_sgmii_phy_scmi_set_mode(struct phy *phy, enum phy_mode mode,
> +					      int submode)
> +{
> +	struct device *dev = phy->dev.parent;
> +	unsigned int perf_state;
> +	int ret;
> +
> +	ret = qcom_dwmac_sgmii_phy_scmi_validate(phy, mode, submode, NULL);
> +	if (ret)
> +		return ret;
> +
> +	perf_state = (submode == PHY_INTERFACE_MODE_2500BASEX) ?
> +		     SPEED_2500 : SPEED_1000;
> +
> +	return dev_pm_genpd_set_performance_state(dev, perf_state);
> +}
> +
> +static const struct phy_ops qcom_dwmac_sgmii_phy_scmi_ops = {
> +	.set_mode	= qcom_dwmac_sgmii_phy_scmi_set_mode,
> +	.validate	= qcom_dwmac_sgmii_phy_scmi_validate,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static void qcom_dwmac_sgmii_phy_scmi_reset_perf_state(void *data)
> +{
> +	struct device *dev = data;
> +
> +	dev_pm_genpd_set_performance_state(dev, 0);
> +}
> +
> +static int qcom_dwmac_sgmii_phy_scmi_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	/*
> +	 * Enable runtime PM on the provider before creating the PHY so that the
> +	 * PHY core enables runtime PM on the PHY device too. The single SCMI
> +	 * power domain has already been attached to this device by the driver
> +	 * core, so runtime PM votes propagate to firmware through the genpd
> +	 * device link. No register or clock access is done here - firmware owns
> +	 * the SerDes.
> +	 */

[Severity: Medium]
Is this comment accurate for the domain type the binding describes?

The binding allows only one power-domains entry, and its example uses
<&scmi7_dvfs 0>. That is an SCMI perf domain, handled by
drivers/pmdomain/arm/scmi_perf_domain.c. When there is only one domain,
the driver core attaches it directly as dev->pm_domain, so no device
link is created.

scmi_perf_domain_probe() registers that genpd with no power_on or
power_off callbacks, and sets these flags:

	scmi_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
			       GENPD_FLAG_OPP_TABLE_FW |
			       GENPD_FLAG_DEV_NAME_FW;

In addition, scmi_pd_set_perf_state() returns before it reaches
perf_ops->level_set() when the level is 0:

	if (!state)
		return 0;

The MAC calls phy_power_off()/phy_exit() in
qcom_ethqos_serdes_powerdown(). When this provider then runtime
suspends, the path is:

genpd_runtime_suspend()
    genpd_power_off()                    <- no-op, ALWAYS_ON
    genpd_drop_performance_state()
        scmi_pd_set_perf_state(genpd, 0) <- returns 0, no SCMI message

Does anything ever ask firmware to power down the SerDes or release its
rate vote?

qcom_dwmac_sgmii_phy_scmi_reset_perf_state() has the same problem on
unbind or probe failure. Its dev_pm_genpd_set_performance_state(dev, 0)
call ends at the same early return.

Say qcom_dwmac_sgmii_phy_scmi_set_mode() has requested SPEED_1000 or
SPEED_2500. Firmware then seems to keep that level through interface
down, phy_power_off() and driver unbind. Meanwhile genpd records
performance_state = 0. Can the kernel's view and the firmware's view get
out of sync here?

Whether the SerDes stays physically powered may depend on firmware and on
the MAC's own SCMI power domains. Even so, this driver never sends a
power-off or release request.

The opposite problem shows up if the DT points at an SCMI power-protocol
domain (scmi_pm_domain.c) instead. On/off would then work, but that genpd
has no set_performance_state callback. _genpd_set_performance_state()
would record the state and return 0. set_mode() would then report
success for 2500BASE-X even though nothing reaches firmware.

Other sa8255p firmware-managed devices use separate domains for these
two jobs. For example, qcom,sa8255p-geni-i2c.yaml has 'power' and 'perf'
as <&scmi0_pd 0>, <&scmi0_dvfs 0>. Would this driver need the same power
plus perf split, with the probe comment updated to match?

> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-qcom-sa8255p-emac-v15-0-e82f33720737%40oss.qualcomm.com
