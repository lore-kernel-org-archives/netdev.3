Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EB4749DA;
	Mon, 14 Sep 2026 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427770; cv=none; b=ItRFbNppZErZJoZgplVwNKXyLWonX0QaAjvLu2Js82YspbssPqzd1C6DqjC69NlV8e2R074JZ4Uei++b3QazRcaskE35rgXe4hmunT0/vm24CVWgpbx0vIKaarRKDXOEKQy/toRMOd58oU68lWBPYT+9fr7/Mv4bJqr+M3Yeve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427770; c=relaxed/simple;
	bh=Iycun4fW04nSIw943uKE96HnWmw6yDCiGGmVgv/Pjc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxr1FRjn8khFTciWVb8SDRwzwmSFHpyOwKg8nuz2VmCWV8uv8bWEoBVAOcn8kwrD/ecGTUsjyZV8I7e4eli2QMvPWJkwLVmtp45kW/sbReGcmcGcTzx+gn5HdRd4I4YTh+XBh24TXFozMtsKJz6bUw6AEQarGkanVXEHKJ5+BHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQoTDPrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQoTDPrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A931F000FF;
	Mon, 14 Sep 2026 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427767;
	bh=8LNeiQS+Hat1NE34wNodfTvlRVgYQwg3caMAkmZTAyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQoTDPrxiJ25H9xSf4ddgoh4c0eEq5NHU1tRzhKcCQaxM77l+MYoudOOcG6JPug0Q
	 3MtNlQabum7cNQVS+3eoDSqh/9QFVR3Eo9gaQSqhVYw45LDqOhdLXHYOGKi+wFp3a2
	 L9c7T5IMbub606A0PayNEVztLQCLjS7yXYs8BjajiBuSstU6b3M0jpFVcIbznt/PwG
	 Rv+4ChGTifk5BMk+oxJPVKqNNdM642sw2SfKQKlQ/va1tkybqDHG8A3b+vY67WhKTy
	 gl3QOy65Vj4ti1jGRpmH0aWauEXfrJD3dKFdJ3zxksZKqR5Ja2U2HizMQJGSuiD1mm
	 5Ahbc5L+Z9eZw==
From: Jakub Kicinski <kuba@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vkoul@kernel.org,
	peppe.cavallaro@st.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	shawnguo@kernel.org,
	festevam@gmail.com,
	jan.petrous@oss.nxp.com,
	s32@nxp.com,
	mohd.anwar@oss.qualcomm.com,
	romain.gantois@bootlin.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mripard@kernel.org,
	christophe.roullier@foss.st.com,
	brgl@kernel.org,
	radu@rendec.net,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	dfustini@tenstorrent.com,
	linux-sunxi@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH net-next v14 03/10] phy: qcom: add the SGMII SerDes PHY driver for SCMI systems
Date: Mon, 14 Sep 2026 16:16:01 -0700
Message-ID: <20260914231601.704186-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-qcom-sa8255p-emac-v14-3-ec212b747a7d@oss.qualcomm.com>
References: <20260908-qcom-sa8255p-emac-v14-3-ec212b747a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
phy: qcom: add the SGMII SerDes PHY driver for SCMI systems

This adds a new platform driver for the firmware-managed SGMII/SerDes PHY
on Qualcomm sa8255p, kept separate from the HLOS-managed variant.  The
driver's only functional operation is a genpd performance-state vote from
its set_mode() callback.

A few questions about the new Kconfig entry and the probe path below.

> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index d910a5d1a1ac3..677662f642e42 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -242,3 +242,14 @@ config PHY_QCOM_SGMII_ETH
>  	help
>  	  Enable this to support the internal SerDes/SGMII PHY on various
>  	  Qualcomm chipsets.
> +
> +config PHY_QCOM_SGMII_ETH_SCMI
> +	tristate "Qualcomm DWMAC SGMII SerDes/PHY driver (firmware managed)"
> +	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select PM
> +	select PM_GENERIC_DOMAINS

[Severity: Low]
Should this driver be forcing CONFIG_PM on with select?

kernel/power/Kconfig has:

	config PM
		bool "Device power management core functionality"

Since PM is a user-visible prompt symbol, selecting it from a leaf driver
means that enabling PHY_QCOM_SGMII_ETH_SCMI silently turns device power
management on for the whole kernel and the user can no longer unset it.
PM_GENERIC_DOMAINS is likewise normally owned by genpd providers and SoC
glue rather than by consumers.

This driver only consumes a domain (dev_pm_genpd_set_performance_state()
on its own device), so would "depends on PM_GENERIC_DOMAINS" (which
implies PM) express the requirement instead?

> +	help
> +	  Enable this to support the internal SerDes/SGMII PHY on Qualcomm
> +	  chipsets where the SerDes hardware (clocks and registers) is owned
> +	  by the firmware.

[ ... ]

> diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
> new file mode 100644
> index 0000000000000..ae961975dcd87
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
> @@ -0,0 +1,115 @@

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

[Severity: High]
Who drops the performance-state vote when this driver goes away?

qcom_dwmac_sgmii_phy_scmi_set_mode() raises the vote on the provider
device to SPEED_1000 or SPEED_2500, but nothing in the driver ever
lowers it again.  There is no .remove callback, and the only teardown
action registered in probe is
qcom_dwmac_sgmii_phy_scmi_runtime_disable(), which merely calls
pm_runtime_disable().  So after a sysfs unbind or an rmmod of
phy-qcom-sgmii-eth-scmi, the last level requested by set_mode() is
never reset to 0.

For the SCMI perf domain the binding example points at, the level was
pushed all the way down to firmware via scmi_pd_set_perf_state() ->
perf_ops->level_set(), and the domain carries GENPD_FLAG_ALWAYS_ON, so
there is no power-off transition that would incidentally clear it
either.  The practical effect is that firmware keeps the SerDes clocked
for 2.5G indefinitely after the driver is gone, and the vote is also
stale across a rebind until the first set_mode() call arrives.

We are not sure the core covers this for you: on detach,
genpd_dev_pm_detach() -> genpd_remove_device() removes the device from
genpd->dev_list and frees its generic_pm_domain_data, which is what
_genpd_reeval_performance_state() aggregates over, so it is not obvious
whether the aggregated level is recomputed downwards at that point or
just left where it was.  Could you confirm which core path resets it,
and if there is none, add an explicit dev_pm_genpd_set_performance_state(dev, 0)
in a .remove callback or a devres action registered next to the
runtime-PM one?

[Severity: Low]
Where is the performance-level namespace for this device defined?

qcom_dwmac_sgmii_phy_scmi_set_mode() feeds the ethtool link-speed
constants SPEED_1000 and SPEED_2500 from <linux/ethtool.h> (Mb/s values
1000 and 2500) directly into dev_pm_genpd_set_performance_state(), and
scmi_pd_set_perf_state() in drivers/pmdomain/arm/scmi_perf_domain.c hands
the number on unchanged:

	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);

The new binding qcom,sa8255p-dwmac-sgmii-phy.yaml declares no OPP table,
no required-opps and no description of valid performance levels, so the
"Mb/s as SCMI level" contract is not written down anywhere.  If firmware
uses indices or different units instead, does the wrong SerDes rate get
selected?  Could the meaning of these levels be documented in the
binding, or the values derived from an OPP table?

[Severity: Low]
(same hunk) Other in-tree genpd consumers derive the level from
OPP-supplied pstates, INT_MAX, or a driver-defined enum rather than from
an ethtool speed constant.  Is reusing SPEED_* here intentional?

[ ... ]

> +static int qcom_dwmac_sgmii_phy_scmi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *provider;
> +	struct phy *phy;
> +	int ret;
> +
> +	/*
> +	 * Enable runtime PM on the provider before creating the PHY so that the
> +	 * PHY core enables runtime PM on the PHY device too. The single SCMI
> +	 * power domain has already been attached to this device by the driver
> +	 * core, so runtime PM votes propagate to firmware through the genpd
> +	 * device link. No register or clock access is done here - firmware owns
> +	 * the SerDes.
> +	 */
> +	pm_runtime_enable(dev);

[Severity: Low]
Is the claim that "runtime PM votes propagate to firmware through the
genpd device link" true for the provider the binding example names?

The example in qcom,sa8255p-dwmac-sgmii-phy.yaml wires the PHY to

	power-domains = <&scmi7_dvfs 0>;

and drivers/pmdomain/arm/scmi_perf_domain.c registers those domains as:

	scmi_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
			       GENPD_FLAG_OPP_TABLE_FW |
			       GENPD_FLAG_DEV_NAME_FW;
	scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;

There is no power_on/power_off callback and the domain is ALWAYS_ON, so
no runtime PM power vote can reach firmware through it.  The other SCMI
provider, drivers/pmdomain/arm/scmi_pm_domain.c, has power_on/power_off
but no set_performance_state, so it cannot serve set_mode() either.

Since the binding allows only one phandle, can any single in-tree SCMI
provider offer both capabilities?  Would it be clearer to say the runtime
PM plumbing exists so genpd re-applies the performance state on resume?

[Severity: Low]
Related to the same comment: the binding added earlier in this series,
Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml,
lists

	required:
	  - compatible
	  - reg
	  - "#phy-cells"
	  - power-domains
	  - power-domain-names

but this driver consumes neither reg nor power-domain-names.  There is no
platform_get_resource()/devm_platform_ioremap_resource() call and no
of_property_match_string()/devm_pm_domain_attach_by_name() call anywhere
in the file, and the comment above states that registers are not touched.
With power-domains capped at maxItems: 1 the automatic attach in
genpd_dev_pm_attach() never looks at power-domain-names either.

Comparable sa8255p bindings that require power-domain-names (for example
qcom,sa8255p-geni-uart.yaml) declare two domains, "power" and "perf", and
their drivers attach by name.  Should reg and power-domain-names still be
mandatory here?

> +
> +	ret = devm_add_action_or_reset(dev, qcom_dwmac_sgmii_phy_scmi_runtime_disable, dev);
> +	if (ret)
> +		return ret;
> +
> +	phy = devm_phy_create(dev, NULL, &qcom_dwmac_sgmii_phy_scmi_ops);
> +	if (IS_ERR(phy))
> +		return dev_err_probe(dev, PTR_ERR(phy), "failed to create the phy\n");
> +
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return dev_err_probe(dev, PTR_ERR(provider),
> +				     "failed to register the PHY provider\n");
> +
> +	return 0;
> +}

[Severity: Medium]
Should qcom_dwmac_sgmii_phy_scmi_probe() verify that a genpd was really
attached before publishing the PHY provider?

The comment above asserts the precondition, but nothing checks it.
genpd_dev_pm_attach() in drivers/pmdomain/core.c returns success without
attaching anything when the phandle count is not exactly one:

	if (of_count_phandle_with_args(dev->of_node, "power-domains",
				       "#power-domain-cells") != 1)
		return 0;

So with zero or two or more power-domains entries in the DT node,
dev->pm_domain stays NULL while pm_runtime_enable(), devm_phy_create()
and devm_of_phy_provider_register() all succeed.

Every later phy_set_mode_ext() from ethqos then hits:

	genpd = dev_to_genpd_safe(dev);
	if (!genpd)
		return -ENODEV;

in dev_pm_genpd_set_performance_state(), and
qcom_dwmac_sgmii_phy_scmi_set_mode() returns that -ENODEV without any
message.  Does this leave the SerDes rate unprogrammed for the lifetime
of the device, with the link never coming up and no diagnostic pointing
at the PHY provider?  Would a check such as dev_to_genpd_safe(dev) (or
dev->pm_domain) in probe, with dev_err_probe(), make the failure visible?

[ ... ]
