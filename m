Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B628030E;
	Sun, 18 Oct 2026 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320458; cv=none; b=Oad79GRkdMru2mUnE03O9lMGD4TnUf+5LFunJ/uV5F55T16LxaP7/TpbZV9FxeMmhxhK6ZlDwO8zheepzLZ7QXIxMPNpYkIyaPFtWnpevmaA5wHJwly3pe6fbzidjRTBGaNzyLto6kICWX+WgkotnZDwderqyx1oLkmsw0M0WX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320458; c=relaxed/simple;
	bh=r83+JrXSRYUTYo1eNgya70LFOIp0KcIM2kOKH3tfyoA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZD/iIpnm1NOCi78GJ+Pxr8MT2/l+WRn7W0LJMn/LAupaRhknO6GSFz4iKRH+O3hUuuwmKp9DazAT3f9W1oSd1T/oqajnRFCnk6+0/8VUikmEhkBbQE0RbdHDwF3s4T8f9DBQH3fxue4MRI9iHrFRfah96D0IGrby9XcsBHIGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwySJSoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwySJSoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E2A1F000C5;
	Sun, 18 Oct 2026 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792320454;
	bh=UJSsa8/dqxJFlUf84mFtGfKTmeVos6ku3honnED/r7k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwySJSoDk9YehqvbyW26roV6nducdwa4/2LMwnS2Zo8Yz4BsJlWZV93iz86Fq3k70
	 pFZi27U3yoYIzZVRe6kJYpOHTezgRwvVSfLJmzsggz3KpHRvqPuSxD5yxKrayCwj7t
	 0NlvRdHao2NaT5vtm5326H+Ke6fDLSi8tnRKXzi3IDAWDyuskvqNbgT8N7cE+YH9rU
	 ZG3krFGuRJA1A2esqF0JTNH/nYi8mS+TCvhAbSe/8tc3WG79QpglRImutd27GAxQ3d
	 buAMw8wRNzu0GPuwNjUGWVhEWEyesPR3Qwr35jx/6P9iFm71uCNBlXHFc6YZojR6iC
	 tkq1La0TY2hLA==
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
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
Date: Sun, 18 Oct 2026 10:47:32 +0000
Message-ID: <179232045276.3135.12798783593655817967@kernel.org>
In-Reply-To: <20261017-shikra_ethernet-v3-2-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-2-26a8beb44b8f@oss.qualcomm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says Shikra's EMAC needs an OPP table whose
  required-opps vote VDD_CX to SVS while the NOC clocks are enabled.
- [Low] The commit message says the new if/else block constrains Shikra
  "while leaving existing compatibles unchanged".

--

dt-bindings: net: qcom,ethqos: add qcom,shikra-ethqos compatible

This commit adds the qcom,shikra-ethqos compatible to the qcom,ethqos and
snps,dwmac bindings. It allows up to six clocks by adding axi-noc and
pcie-tile-axi-noc, and adds the operating-points-v2 and opp-table
properties. A new if/else block requires Shikra to have exactly six clocks
and an OPP table.

> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 423959cb928d9..1167f11adbf30 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml

[ ... ]

> @@ -81,6 +83,11 @@ properties:
>        - const: cpu-mac
>        - const: mac-mem
>  
> +  operating-points-v2: true
> +
> +  opp-table:
> +    type: object
> +
>    phys: true
>  
>    phy-names:
> @@ -92,6 +99,46 @@ required:
>    - clock-names
>    - reg-names
>  
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,shikra-ethqos
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: pclk
> +            - const: ptp_ref
> +            - const: rgmii
> +            - const: axi-noc
> +            - const: pcie-tile-axi-noc
> +        operating-points-v2:
> +          description: |
> +            The OPP table specifies the rates for the NOC access
> +            clocks in "stmmaceth", "axi-noc", "pcie-tile-axi-noc"
> +            order.
> +      required:
> +        - operating-points-v2

[Severity: Medium]
Should power-domains also be required for Shikra here?

The commit message says the OPP table carries required-opps "to vote
VDD_CX to SVS when the NOC clocks are enabled". That vote only happens if
the device has a power domain attached. Here, power-domains is optional and
only comes in through the snps,dwmac.yaml reference (maxItems: 1).

If power-domains is missing, genpd never attaches the device, so
required_devs[0] stays NULL. _set_required_opps() then skips the entry and
does not return an error:

drivers/opp/core.c:_set_required_opps() {
    ...
		if (devs[index]) {
			required_opp = opp ? opp->required_opps[index] : NULL;

			ret = _set_opp_level(devs[index], required_opp);
    ...
}

As a result, a Shikra node with six clocks and an OPP table but no
power-domains passes dt_binding_check. The driver's ethqos_clks_config()
path through qcom_ethqos_set_opp() still succeeds, but CX is never raised
before the NOC clocks run at their OPP rates.

Other Shikra devices that vote CX through required-opps pair the OPP table
with the power domain. For example, sdhc_1 in
arch/arm64/boot/dts/qcom/shikra.dtsi has:

			power-domains = <&rpmpd RPMPD_VDDCX>;
			operating-points-v2 = <&sdhc1_opp_table>;

Could power-domains be added to the required list for Shikra? Could the
operating-points-v2 description also state that the OPP entries need
required-opps pointing at the CX domain?

> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: pclk
> +            - const: ptp_ref
> +            - enum:
> +                - rgmii
> +                - phyaux
> +

[Severity: Low]
The commit message says the if/else block leaves "existing compatibles
unchanged". Is that accurate?

operating-points-v2 and opp-table are added to the top-level properties, so
they apply to every compatible. This else branch only re-limits clocks and
clock-names.

Before this patch, neither qcom,ethqos.yaml nor snps,dwmac.yaml defined
these properties, so unevaluatedProperties: false rejected them. Now nodes
for qcs404, qcs615, sa8775p, qcs8300, sc8280xp and sm8150 pass validation
with an OPP table, even though those platforms have no NOC clocks.

Should the else branch also include something like this?

        operating-points-v2: false
        opp-table: false

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-shikra_ethernet-v3-0-26a8beb44b8f%40oss.qualcomm.com
