Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D852E542C;
	Fri, 11 Sep 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125922; cv=none; b=Tyd12w4GnfYHs1VxgfoAqFwcXi6Le0E1y3mCW36MW37FD1foIjQRZxLE7Dw1jJzfBNWnusLkPAhEgULKgMk3JrE+fHE2XgKnQOjz4rfYhUcIDm1dP2wjEDfzzKw1GSHqjnyQiXc8dd6+Fixwb22yaDOVarYrykwH9g3DBz6qUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125922; c=relaxed/simple;
	bh=gpQK8zE9sxbzsaKQyc/Cqi/MOsTF+aD1TrpANQUTZhM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbKLd2X/OGcVLa90KDItQqug2l/FyobAB8WzYbaETHAyXg270h0K7rR3hA8b0deVGWnNBbK4cWbIqLb0A0zgdVVE79/UTkKhRAERvNbE37+UPEaqqaugj6JCselci8RuwWLQtvOGL0nlIj/SG4pINRMlgYH2wsw/N7wB4oyhIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBV/WqE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBV/WqE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3291F00899;
	Fri, 11 Sep 2026 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125912;
	bh=rKouco8/yNm0gBoTUKavYASU9EWlitA5dDOKirGScbk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fBV/WqE1dSL+wlc8I8clbjJeywFqIe4YN/xQX6mZMq9yQpdk6IkeXHCn2VzGB9781
	 ZGbzxC0urNvdKoO4O5GE7WNa5KAlLkzlmCV4sTNL4lRwCR8B11rC9qy8yn4CWqYIK3
	 eJIabMuUAH2P36dkh+KeMy+HB4CiRZ+RfpdeXDC5yS8Bunxz+8x8PSHKdKKr91Jr1Q
	 kIFwdIqwPa8AyefV1yoXJ4dE7cDH59X4hQX9Fl0OPGngJBmuw6CSCiHVFb0bYP4KeY
	 DSShphr1s11Rk5LGw2syNvxKMGlLRehxI8wuDvC3DMdrkoSkAHMRxIHkS1HtFkU37p
	 fVpkYMhkl2+bQ==
Subject: Re: [PATCH net-next v2 3/9] dt-bindings: net: qcom,ethqos: add
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
Date: Fri, 11 Sep 2026 11:25:10 +0000
Message-ID: <178912591096.219967.12828338145381099454@kernel.org>
In-Reply-To: <20260908-shikra_ethernet-v2-3-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-3-bbe3389d0652@oss.qualcomm.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Documentation/devicetree/bindings/net/qcom,ethqos.yaml: the new
  `if: compatible contains qcom,shikra-ethqos` block makes `operating-…
- [Low] Concern (verified as resolved within this series): the binding
  adds `qcom,shikra-ethqos` with six mandatory clocks (including `axi-…

--

dt-bindings: net: qcom,ethqos: add qcom,shikra-ethqos compatible

This adds the qcom,shikra-ethqos compatible to the qcom,ethqos and
snps,dwmac schemas, and introduces an if/else block that constrains Shikra
to six clocks (adding axi-noc and pcie-tile-axi-noc) while keeping the
existing compatibles at four. The Shikra branch also makes
operating-points-v2 mandatory.

A couple of questions below.

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
At this commit there is no driver side for this compatible:
qcom_ethqos_match[] in drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
has no qcom,shikra-ethqos entry, and nothing acquires axi-noc or
pcie-tile-axi-noc or registers an OPP table.

Checking the rest of the series shows this is closed later by "net: stmmac:
qcom-ethqos: add per-platform NOC clock voting" and "net: stmmac:
qcom-ethqos: add Shikra EMAC support", which add:

  { .compatible = "qcom,shikra-ethqos", .data = &shikra_data},

and

  static const struct ethqos_noc_clk_cfg shikra_noc_clks[] = {
	{ "axi-noc", 120000000 },
	{ "pcie-tile-axi-noc", 120000000 },
	{ "stmmaceth", 120000000 },
  };

along with qcom_ethqos_init_noc_clks() doing devm_clk_bulk_get() plus
devm_pm_opp_of_add_table() and dev_pm_opp_set_rate(). The clock-names order
here (rgmii as the fourth name) also matches shikra_data, which does not
override link_clk_name.

So this looks consistent with the series as a whole; noting it only because
the binding lands ahead of its consumer and the intermediate bisect point
has no driver support.

[ ... ]

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

[Severity: Low]
The commit message says the OPP table is there so its required-opps can
"vote VDD_CX to SVS when the NOC clocks are enabled". Should power-domains
be in this required list as well?

The required-opps vote only reaches a genpd if the consumer device has one
attached. In drivers/opp/core.c, _set_required_opps() starts with:

	struct device **devs = opp_table->required_devs;
	...
	if (!devs)
		return 0;

and required_devs[] is only populated via _opp_set_required_dev(), reached
from genpd_set_required_opp_dev() in drivers/pmdomain/core.c during genpd
attach, i.e. only when the node has a power-domains phandle. Even past that
point, dev_pm_domain_set_performance_state() in drivers/base/power/common.c
does:

	if (dev->pm_domain && dev->pm_domain->set_performance_state)
		return dev->pm_domain->set_performance_state(dev, state);

	return 0;

power-domains is already permitted through the snps,dwmac.yaml $ref (it is
declared there as power-domains: maxItems: 1), so unevaluatedProperties:
false is not in the way; it is simply not required.

As written, a Shikra node with operating-points-v2 and no power-domains
passes dt_binding_check, and at runtime the CX performance-state request is
silently skipped while the NOC clocks still run at 120 MHz. No in-tree DTS
is affected today since there is no Shikra DTS yet.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-shikra_ethernet-v2-0-bbe3389d0652%40oss.qualcomm.com
