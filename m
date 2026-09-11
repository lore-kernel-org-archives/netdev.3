Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6F4457A6;
	Fri, 11 Sep 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125927; cv=none; b=SzyR9faE2L24a3kzQxxx4XPMfzx8RFyZ+ej0jwRLZ6XGdBiBkGoJOD/dml+PdoXuJ24dMHVBRY2cDZpg5NgfvWE036g3Ny2XV2t9MVqqJC3kIzG/IKQPYFUv+v/GzxItr8Szh112u+o+mtfAtDg4kojplrq0LzDqw24/mcY9P3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125927; c=relaxed/simple;
	bh=9TXvv5+LY4xfEJb0CRlvOJtKXZ4kjAu/FFhCOzHGUjc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIQb+/snDrr4JXGMFINR9e6g1WLK2bu71ben2tjw3m/IJazy0rlVeI6REi7YvzEqiV1s5bomiud4dfQz2BPEowu5nsbmu/xorhwTuFyvQjouVVekPkuQjddqg+2Sf4hV8K2rJbDNf990+b2B657JVpjkEFPeLSVIC+ZPckU5d4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG3FUD5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG3FUD5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBC91F0089B;
	Fri, 11 Sep 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125918;
	bh=Tat9mq7+c+2wVgjCeNs6A4pXm6W+juN5KefobLoQo9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JG3FUD5WC0loPVITE99b8rSpPe+3pzbh5U+mDnRuYFnzgrcGV9L5vTYpNxPM8r2yy
	 61P4MOcbwypVzEjjeviACdXahJxdqE8IGiXHqknf1gkEuk8i5q2hCQVOVpYPVc77dn
	 FWadNFYGbMuMGRNwUob2IB3myd2Zi9fM/xoq2kWgegnUVNpLZVRIBG72w7aDnHHRkQ
	 dFXDIHjdb8Xtp++DVFQft/+Gm0ihNoHsy8TMG9YKOADk6cdikRnX65RNrdivuu3Wk9
	 mohBN1gswc2zLba12y3ePu1+VAmc4BGP8BEk6uKboTmXI0JK927sS2ieOOvP/4N6V0
	 J8X7fa+IqlHrw==
Subject: Re: [PATCH net-next v2 6/9] net: stmmac: qcom-ethqos: warn about
 legacy RGMII PHY modes
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
Date: Fri, 11 Sep 2026 11:25:16 +0000
Message-ID: <178912591683.219967.17377991068527504766@kernel.org>
In-Reply-To: <20260908-shikra_ethernet-v2-6-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-6-bbe3389d0652@oss.qualcomm.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Unactionable boot-time warning on every in-tree qcom ethqos
  platform: the new dev_warn() in qcom_ethqos_probe() (dwmac-qcom-…
- [Low] Commit message / code mismatch: the changelog of "net: stmmac:
  qcom-ethqos: warn about legacy RGMII PHY modes" states that "existing…

--

net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes

This adds a probe-time dev_warn() in qcom_ethqos_probe() when the ethernet
node uses one of the older RGMII phy-mode values, suggesting a move to
"rgmii-id" with PHY-provided delays.  PHY_INTERFACE_MODE_RGMII_ID is split
out of the shared case group so that it does not warn.

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

[Severity: Low]
The changelog says:

    However, existing DTBs use "rgmii" and "rgmii-txid" and must remain
    supported for backwards compatibility.

    Warn when either of these legacy PHY modes is used [...]

but the warning in qcom_ethqos_probe() is attached to a group of three case
labels, so PHY_INTERFACE_MODE_RGMII_RXID also warns.

Is "rgmii-rxid" intended to be declared legacy as well?  The driver does
treat these modes differently, for example in ethqos_rgmii_macro_init():

	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
		phase_shift = 0;
	else
		phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;

so which phy-modes are being deprecated seems worth stating exactly in the
commit message.

[Severity: Medium]
Is there an upstream DTB that this warning can point people at?  No in-tree
device tree for this driver uses "rgmii-id", and this series does not touch
arch/ at all, so every in-tree board hits the new warning on each probe:

  arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts	phy-mode = "rgmii";
  arch/arm64/boot/dts/qcom/sa8155p-adp.dts	phy-mode = "rgmii";
  arch/arm64/boot/dts/qcom/sa8540p-ride.dts	phy-mode = "rgmii-txid";  (both MACs)

The binding example in Documentation/devicetree/bindings/net/qcom,ethqos.yaml
also still uses:

      phy-mode = "rgmii";

and the binding carries no phy-mode deprecation note, so the documented ABI
still recommends what the driver now calls legacy.

Converting those device trees is also the only way the advocated
PHY-provided-delay path gets exercised, since ethqos_set_clk_tx_rate() stops
doubling the link clock only for PHY_INTERFACE_MODE_RGMII_ID.  Would it make
sense to convert the in-tree DTs (and the binding example/text) in the same
series, or to hold off on the warning until a migration target exists?

> +		fallthrough;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
>  		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_rgmii;
>  		break;
>  	case PHY_INTERFACE_MODE_2500BASEX:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-shikra_ethernet-v2-0-bbe3389d0652%40oss.qualcomm.com
