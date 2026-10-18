Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A247043B;
	Sun, 18 Oct 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320460; cv=none; b=agHQIphQV7J4zJDFylUpAH5xmCvpr4EzNZSG+2rdRWhEekVAOrS9pPcSjPjyyu0wa/3iD9aQxNZS4cb3KcT6GyegiiyQy8aissfmnPt4vQ5RJoJcsRO4ANrZl8l4LVsn26mVapw1zVLOM4gKZ1UwSSwWA5yYfumyL8D3NNM87do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320460; c=relaxed/simple;
	bh=+zm1vzm8k0xDjh4VC612BoJ1oT7cc7MZohgAtfWsV+k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9JXgTQQWcS+A+I1DWrS4UzIvZviBezD3RYseBL62GpDrwiFMY1JEMulWVhw8Zs4yeDHzDmAd8c+dL2tbrOUGLoWLksvKU+1qVVmJ8KMolsiwLUhqE98Rd24A6TsqjXuyRUp4jATK0Psuk5RvRinc5hg2ot9pF1ItgClw0F1bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEGF7Hd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEGF7Hd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F871F000CB;
	Sun, 18 Oct 2026 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792320458;
	bh=SkZXiG1h3Fqd9FSyy/k/L6UQ3EgZGcMJZVDgN+k19A0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iEGF7Hd7iGU5n2JR6YujAwA7khIGa4mbnwAw3mmnN9x8gBBEb2/tOiuJQp7Ju7Sh1
	 yRwGP6pS/oswxRYu5ZV0cIVts4dJsjTAKHuqRU7YqzvdIjgahXVk9oquuhyWLuU1sT
	 fZNpxIyOAWnwOkH+3YXAtPm4e6jIwO2+TIfwk1g3jtYfmbw1Z9Fig/9iRNYpxc06RW
	 3LyDAllfBONt1LqulwzSD9Xse8GqT2A5vLdMexZutYO3wx7edBJNMBkl3yxGFdm6b4
	 ZJhzHnmKvbQxoMScyW3kjpjivAh0GyU4kB9Qh026uQmLCA+Cxg3o5MwUIuxkPaL+3a
	 RCR+78lj3J97A==
Subject: Re: [PATCH net-next v3 5/9] net: stmmac: qcom-ethqos: warn about
 legacy RGMII PHY modes
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
Date: Sun, 18 Oct 2026 10:47:36 +0000
Message-ID: <179232045684.3135.7391017635736760910@kernel.org>
In-Reply-To: <20261017-shikra_ethernet-v3-5-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-5-26a8beb44b8f@oss.qualcomm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new dev_warn() in qcom_ethqos_probe() calls "rgmii",
  "rgmii-rxid" and "rgmii-txid" legacy and tells the user to "consider…
- [Low] The commit message and the code disagree on which modes get the
  warning.
- [Low] In qcom_ethqos_probe() the legacy-mode dev_warn() runs early
  (line 769), before several steps that can return -EPROBE_DEFER: -…

--

net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes

This patch makes qcom_ethqos_probe() print a warning when the device tree
uses "rgmii", "rgmii-rxid" or "rgmii-txid". The aim is to move boards over
to "rgmii-id" with PHY-provided delays. The RGMII_ID case is moved below
the warning, so it still gets the same fix_mac_speed setup but does not
warn.

> The qcom-ethqos driver is moving towards using "rgmii-id" together
> with PHY-provided delays. However, existing DTBs use "rgmii" and
> "rgmii-txid" and must remain supported for backwards compatibility.
>
> Warn when either of these legacy PHY modes is used to encourage users
> to migrate to updated DTBs using "rgmii-id".

[Severity: Low]
This isn't a bug, but the commit message names two legacy modes and the
code warns for three. In qcom_ethqos_probe(), PHY_INTERFACE_MODE_RGMII_RXID
is still in the same case group as RGMII and RGMII_TXID, so "rgmii-rxid"
prints the warning too.

No in-tree qcom DTS uses "rgmii-rxid", so the "existing DTBs" reason does
not cover it.

Could the commit message mention rgmii-rxid and say why it counts as
legacy?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 53fb9de4d92c7..a92bf4a6a2dbd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -764,9 +764,11 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	ethqos->phy_mode = plat_dat->phy_interface;
>  	switch (ethqos->phy_mode) {
>  	case PHY_INTERFACE_MODE_RGMII:
> -	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		dev_warn(dev, "legacy RGMII phy-mode detected; consider upgrading to a newer DTB\n");

[Severity: Medium]
Is there a newer DTB for users to upgrade to? Every in-tree RGMII user of
this driver still uses one of the modes that now warn:

  arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts:  phy-mode = "rgmii";
  arch/arm64/boot/dts/qcom/sa8155p-adp.dts:      phy-mode = "rgmii";
  arch/arm64/boot/dts/qcom/sa8540p-ride.dts:     phy-mode = "rgmii-txid";
                                                 (on both ports)

The example in Documentation/devicetree/bindings/net/qcom,ethqos.yaml
also uses phy-mode = "rgmii".

The series, up to and including "net: stmmac: qcom-ethqos: add Shikra
EMAC support", does not convert any of these files. The current mainline
DTBs would therefore hit this warning on every probe, and twice on
sa8540p-ride.

Should the DTS files and the binding example be converted first, or
should the warning wait until they are?

The text also does not name the recommended mode. Could the message
mention "rgmii-id"?

Moving to rgmii-id also takes more than a DT edit. In this driver,
RGMII_ID takes a different MAC path:

ethqos_fix_mac_speed_rgmii() {
    ...
	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID) {
		rgmii_setmask(ethqos, SDCC_DLL_CONFIG_PDN, SDCC_HC_REG_DLL_CONFIG);
		rgmii_setmask(ethqos, SDCC_USR_CTL_DDR_BYPASS, SDCC_USR_CTL);

		ethqos_rgmii_id_macro_init(ethqos, speed);

		return;
	}
    ...
}

ethqos_set_clk_tx_rate() also uses a different link clock rate at
10/100M in this mode. No delay is added on the MAC side, so the PHY has to
add both the RX and TX delays.

If a board's PHY or PHY driver does not apply internal delays, could
following this warning break its RGMII link?

[Severity: Low]
Will this message repeat on deferred probe? The dev_warn() runs before
several steps in qcom_ethqos_probe() that can return -EPROBE_DEFER:

	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
	...
	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
	...
	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);

Each deferral runs qcom_ethqos_probe() again and prints the same warning
again. Could the warning move later in probe, after the steps that can
defer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-shikra_ethernet-v3-0-26a8beb44b8f%40oss.qualcomm.com
