Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA333C10BD;
	Wed,  9 Sep 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990450; cv=none; b=Fz7iWrPADDuZfeqc/LFXaLghAQ6rGwrBwRx5pGUsDd9KwVbSYdXggiMEUDAdPjUCL+vttVLHjNB34zibxwHHycfwuCCHtwltGZi4Myx3Vz+gUhZc3tPwy/u3ytUsN1OSDvRAIIVlfJuRhAObSU7NDTkdHHQBAVusbln24ka/sBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990450; c=relaxed/simple;
	bh=zP+ejzq3PURFESVFVeeglVfJJbtzBw44MmEUGUVo1t4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkyGzMLTX6yv2gyX6gNuC/VH5W94YZ8eSFDjdVqg2yevRvqpQMB5TEhjgvNkZrtk3Vsm4VAQ5F/ntqd1LERrXlC9fsNnkZtvZzWnUX7hw8IVHNIqeM6RWAGA6G4RWXY5GEsxGQ5pKSQDDuRQ/U9ckyJcK3R+XI7bg3RUm8PMxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUcYEFS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUcYEFS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B051F000FF;
	Wed,  9 Sep 2026 21:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990427;
	bh=VyR/9+HKKkwanUiR3MUx/t7NgUeADXU1eBQkqHF17Qc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TUcYEFS0/z0SsQXt7rbqKc78YIO0ooWhOFE1+FPYtSpnX7ywW+8KZRyUbHL2hhNQ1
	 1u8vZCUzEceW55ZGjRJRuWAnw35q6oQvizoS2ugVzpRKrnHOH4J0qhcvbLr8/fXK+a
	 DtL2m5O5O8yv1uFQW/IEwaYSv3ujujB7p2jJyOQQhBK+tMJYsx0RYQ8nTpirKMRVZl
	 XSTjcr8XhDuEk3VSCTwJpfKV0ZvimvrhsC2TGngCXBrIXlOoplD5+VPvtkAOt2heuW
	 HA222fcuGLtsfSuAd2nV6f0nSNG9vXMtUxFICewcIJvyPiSFwotD2YM7UGVebbFdXX
	 5zung3x9ENHYw==
Subject: Re: [PATCH net-next 3/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
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
Date: Wed, 09 Sep 2026 21:47:05 +0000
Message-ID: <178899042581.219967.9210178730210063221@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-3-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-3-a50765996035@oss.qualcomm.com>
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

- [Medium] The new `qcom,shikra-ethqos` conditional in
  Documentation/devicetree/bindings/net/qcom,ethqos.yaml enforces only…
- [Low] Reported concern: the binding documents `qcom,shikra-ethqos` (a
  standalone compatible with no fallback), two new clocks (`axi-noc`,…

--

dt-bindings: net: qcom,ethqos: add qcom,shikra-ethqos compatible

Adds the qcom,shikra-ethqos compatible to the ethqos and snps,dwmac
bindings, extends the clock list with axi-noc and pcie-tile-axi-noc, and
adds an if/else block constraining Shikra to six clocks while requiring
operating-points-v2.

> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> index 423959cb928d9..ad2cc706fa740 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml

[ ... ]

> @@ -32,6 +29,7 @@ properties:
>            - qcom,qcs404-ethqos
>            - qcom,sa8775p-ethqos
>            - qcom,sc8280xp-ethqos
> +          - qcom,shikra-ethqos
>            - qcom,sm8150-ethqos

[Severity: Low]

This is a standalone compatible with no fallback, and at this point in the
series nothing consumes it, the two new NOC clocks, or the mandatory OPP
table.

Checking the end of the series, this is addressed by the later patches:
"net: stmmac: qcom-ethqos: add per-platform NOC clock voting" adds
qcom_ethqos_init_noc_clks() with devm_clk_bulk_get() and
devm_pm_opp_of_add_table(), and "net: stmmac: qcom-ethqos: add Shikra EMAC
support" adds shikra_noc_clks[] plus:

	{ .compatible = "qcom,shikra-ethqos", .data = &shikra_data},

to qcom_ethqos_match[], so the compatible does bind by the end of the
series. Noting it only for ordering visibility.

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

[Severity: Medium]

The OPP properties are added here, but power-domains is never mentioned
anywhere in qcom,ethqos.yaml. It is only permitted through the inherited
$ref to snps,dwmac.yaml, which defines:

  power-domains:
    maxItems: 1

The commit message says the OPP table exists "to vote VDD_CX to SVS when
the NOC clocks are enabled" through required-opps. Can that vote take
effect without a power-domains phandle on the node?

A per-OPP required-opps entry reaches genpd only via:

drivers/base/power/common.c:dev_pm_domain_set_performance_state() {
	if (dev->pm_domain && dev->pm_domain->set_performance_state)
		return dev->pm_domain->set_performance_state(dev, state);

	return 0;
}

With no power-domains phandle, dev->pm_domain is NULL and this returns 0
without doing anything, so dev_pm_opp_set_rate() ->  _set_required_opps()
-> _set_opp_level() silently drops the CX corner while the two 120 MHz NOC
clocks run.

> @@ -92,6 +99,41 @@ required:
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
> +      required:
> +        - operating-points-v2

[Severity: Medium]

Should power-domains also be listed in this required block, next to
operating-points-v2?

As written, a Shikra node carrying operating-points-v2 and an OPP table
full of required-opps but no power-domains = <&rpmhpd RPMHPD_CX> passes
dt_binding_check and dtbs_check cleanly, and the schema emits no
diagnostic for the missing phandle.

Grepping drivers/net/ethernet/stmicro/stmmac/ at the end of the series
returns no pm_domain references, so the device tree is the only place the
CX dependency can be expressed.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
