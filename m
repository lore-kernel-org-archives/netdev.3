Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D249F127;
	Mon, 14 Sep 2026 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417495; cv=none; b=SU8ghmrBb1pUCF/B4datcFFK0e59zm8Gw9hzi7BgVs0VID2c0YIwiiPBhQ2ZM2/uKe0dpbP/muy/oJDE9T/9xm1k5TKj1ntQjL6BX8gkYVcch+6sUKLlA7W4XPlooIJtfQZXA7wPen3shEb8Prexw5mG4tNPlJTCsdggr8SCrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417495; c=relaxed/simple;
	bh=jf/OdAblXB14CXxvx52wNxZtvoX+uBB9Q35UVVultus=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ioaep7hCFZovw1eC+5JgZ74q8gDItIZCUs6RqS+ywiSwHRyxp6Bi8MnRFJB+c4nYu8vY8ESHV8BRlpTt/W5t76YKkPgAcurciJt57gXhMYOqDp5qhLi7hm4DNqks4Db9NYjlVpbdcTJMyB+dvsUjYHe+sjNeRY9eO3ytIZW0JaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMz3N7D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMz3N7D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B70B1F008AB;
	Mon, 14 Sep 2026 20:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417491;
	bh=6aOylPq8QnPfvdonDez7MymtTE8l4/nFf2/wk25ND9o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aMz3N7D9ioLUm4AQwgsjhTFk/c4ruGmOiuvcf8wqCumVWQEUDfTrfEn6y2hnZZLph
	 /NKYungq/1xmfE9KWEgwQ3uYRvQjZmu56PNsn+tz87I3qI5CwvGb0oj5VSrgWR0Cw1
	 PHcsqvaXdi7YoVMlxGFlykHoZryLZpr0Bsxzfh+2FYJuVBn3s894xTQeU34vWjW6aJ
	 w+LAMjmmVt1dYOs7gzEnKin+oHvPCCm/jqWhizILCG7lrtCoktTEehJ+HCacVhI0LH
	 6xFEcIGN3tvPHgcA/vbAEXFNFH8Y+UnQDmab6knE6jykCz6FSaD7G7xTZC5/5Wpo9S
	 xuXnnoX8zgRWw==
Subject: Re: [PATCH net-next v5 08/11] dt-bindings: net: rockchip-dwmac:
 document pcs-handle
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Date: Mon, 14 Sep 2026 20:24:49 +0000
Message-ID: <178941748966.22033.4234623456215568276@kernel.org>
In-Reply-To: <20260913185849.907479-9-coiaprant@gmail.com>
References: <20260913185849.907479-9-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 3

- [Low] Concern (verified FALSE POSITIVE, retained for policy): the
  binding makes `pcs-handle` required for `phy-mode = "sgmii"` and the…
- [Low] Concern (verified FALSE POSITIVE, retained for policy): the new
  `pcs-handle` property and the `if phy-mode contains sgmii -> require…
- [Low] Concern (verified FALSE POSITIVE, retained for policy): the new
  conditional's `if` clause tests the value of `phy-mode` without…

--

dt-bindings: net: rockchip-dwmac: document pcs-handle

This adds a pcs-handle property to the Rockchip dwmac binding and adds an
allOf conditional that makes pcs-handle a required property whenever
phy-mode contains "sgmii".  There are no other changes to the schema.

No Link: tags are present in the commit header.

> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 80c252845349c..67b21ea77ec96 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -120,6 +120,12 @@ properties:
>      maximum: 0x7F
>      default: 0x10
>  
> +  pcs-handle:
> +    description:
> +      Specifies a reference to a node representing the PCS device
> +      connected to this GMAC. Required when phy-mode is "sgmii".
> +    maxItems: 1
> +

[Severity: Low]

Should pcs-handle be gated on compatible?  As written the property is
accepted for every Rockchip GMAC compatible selected by this binding,
even though only rockchip,rk3568-gmac integrates the XPCS plus Naneng
combo SerDes.  Other SoC-specific properties in this file use the
else-branch form, for example:

    else:
      properties:
        rockchip,php-grf: false

Checking this further, the un-gated form does not appear to cause a
problem in practice.  At the end of the series only rk3568_ops provides
.set_to_sgmii, and rk_gmac_check_ops() in
drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c has:

	case PHY_INTERFACE_MODE_SGMII:
		if (!bsp_priv->supports_sgmii)
			return -EINVAL;

so an sgmii device tree on a Rockchip SoC without SGMII support fails
probe rather than misbehaving.  This binding has also never restricted
phy-mode per compatible, since it inherits the full phy-connection-type
enum through snps,dwmac.yaml, so accepting phy-mode = "sgmii" on other
Rockchip parts predates this patch.  The same construct appears un-gated
in Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml, which is
also a snps,dwmac child binding.

>    phy-supply:
>      description: PHY regulator
>  
> @@ -159,6 +165,15 @@ allOf:
>          clocks:
>            minItems: 5
>  
> +  - if:
> +      properties:
> +        phy-mode:
> +          contains:
> +            const: sgmii
> +    then:
> +      required:
> +        - pcs-handle
> +

[Severity: Low]

This conditional makes pcs-handle mandatory, and the commit message
describes its consumer in the present tense:

    The property is parsed by rk_pcs_init() and a missing phandle fails
    the probe

At this revision there is no rk_pcs_init() in
drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c, so is the wording ahead
of the tree here?

Looking at the rest of the series answers this: the following patch,
"net: stmmac: dwmac-rk: add SGMII support for RK3568", adds
rk_pcs_init() with exactly the described behaviour:

	pcs_node = of_parse_phandle(np, "pcs-handle", 0);
	if (!pcs_node)
		return -ENODEV;

and rk_gmac_probe() installs plat_dat->pcs_init = rk_pcs_init for SGMII.
Sending the binding before the driver change is the expected ordering, so
this is only visible when the patch is read on its own.

[Severity: Low]

Separately, the if clause tests the value of phy-mode without listing it
in required, for example:

  - if:
      properties:
        phy-mode:
          contains:
            const: sgmii
      required:
        - phy-mode

Without that, JSON Schema also matches nodes that omit phy-mode entirely,
which nominally makes template nodes such as gmac0 in
arch/arm64/boot/dts/rockchip/rk3568.dtsi and gmac1 in rk356x-base.dtsi
require pcs-handle.  Would adding required: [phy-mode] be worthwhile for
clarity?

Following this through, it does not change validation results.  This file
has allOf: - $ref: snps,dwmac.yaml#, and snps,dwmac.yaml already lists:

required:
  - compatible
  - reg
  - interrupts
  - interrupt-names
  - phy-mode

so a node without phy-mode already fails validation on the inherited
required list, and the new conditional only adds a second, redundant
message.  The two dtsi nodes above already omit the pre-existing
mandatory phy-mode, so nothing that previously validated is newly
rejected.  The same un-guarded pattern is used in
Documentation/devicetree/bindings/net/ethernet-controller.yaml.

>  unevaluatedProperties: false
>  
>  examples:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
