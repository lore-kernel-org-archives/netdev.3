Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F035AC1E;
	Mon, 19 Oct 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394833; cv=none; b=dha/6rS7AeN1e5JTjPxoFYLdCBi7SCFMjdiEAjBJ19ERTV9g0Mu6PAXoViucl0UJPawZupa3DTGkBUTEs+FY3Yp6ICGdblqwOafE3QTjo6kaWtiWB8kykIb+AsLiVWWFPcno6F10UtCtw5goK/BdQ7l7ZStcQxi9eIXJOtw9b0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394833; c=relaxed/simple;
	bh=JWRZ87p8cHMbw0v4XW5vqy8hPjLd0VdcwuFwgz6AS7E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5ezmIvkrGx0rH/SEB8bY4duqPKTrGn3WxHqmvA83pmy6HkB3BjiVjx74Ep6H5I4Xc+7w7IwXknpOuWfklKr/R3RkIYrVKqYj3D5P/eMDpKX3ElbSva/j8nS6kmnW0fDYfAfYc+tLHZ4taZbDxpCXvwI3HtKoYWlaCtsE+0mEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRpYsITy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRpYsITy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C731F000C4;
	Mon, 19 Oct 2026 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394832;
	bh=nicixn6yiGSSav/ZgC3Y6XWoIj2ecaBOT9kxq+wY4G4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lRpYsITyKsTuHHdgQPzQBIbjeVlMo0iBAEBCcayUFNLF+hUDK3DlErRjXUyhAzo9q
	 uCgYgpxQzve1QQSySObuHPzQihb8fJcBTCC0ee1MMFQ+aqBdhRBg4tV2/YMJ7c+2Nm
	 tbJplQDIhQAnonCD+ppJfzTDhpNTkwmoRf7GujtZAQQvALA8U/34BxA0ZaCI4kc7QA
	 3A/xiRT7rn7sahlmTwWVVRcpul8OMPcSLToj7j1dFLfbUHFhQbqLmIFt5MxWX8OGIn
	 liwhlaI0BaVYQPmeO81N8CdXZvpqGnFd5cQH4MKjHc+TFcthAw7DNfv7E2hnJkaLmJ
	 33JMizyuoqVjw==
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 07:27:11 +0000
Message-ID: <179239483139.3135.3394003778895796670@kernel.org>
In-Reply-To: <20261015-support_ast2700-v3-1-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-1-8d7999171ac4@aspeedtech.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In
  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml…
- [Medium] The rewritten `compatible: oneOf` in faraday,ftgmac100.yaml
  (lines 13-20) no longer accepts the two-string `"aspeed,astXXXX-mac",…
- [Medium] dt-bindings: net: unconditional phy-mode requirement conflicts
  with use-ncsi
- [Low] The commit message says requiring phy-mode 'match[es] the
  driver's probe-time requirement' and talks about AST2700…
- [Low] At this commit, the binding documents a standalone
  `aspeed,ast2700-mac` compatible, but ftgmac100_of_match[] (line 2138)…
- [Low] The new aspeed,ast2700-mac compatible does not require `clocks`
  (top-level `required:` at faraday,ftgmac100.yaml lines 71-74 lists…

--

dt-bindings: net: ftgmac100: Add AST2700 compatible

This adds aspeed,ast2700-mac to the ftgmac100 binding, allows the reset
line for it and requires phy-mode for it. It also changes all of the
Aspeed compatibles from the "aspeed,astXXXX-mac", "faraday,ftgmac100" pair
to standalone strings.

> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..0a376b849a91 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -13,12 +13,11 @@ properties:
>    compatible:
>      oneOf:
>        - const: faraday,ftgmac100
> -      - items:
> -          - enum:
> -              - aspeed,ast2400-mac
> -              - aspeed,ast2500-mac
> -              - aspeed,ast2600-mac
> -          - const: faraday,ftgmac100
> +      - enum:
> +          - aspeed,ast2400-mac
> +          - aspeed,ast2500-mac
> +          - aspeed,ast2600-mac
> +          - aspeed,ast2700-mac

[Severity: Medium]
Will DTBs written to the new binding still get networking on older
kernels?

Before commit 03a2aba50b2c ("net: ftgmac100: List all compatibles"),
ftgmac100_of_match[] in drivers/net/ethernet/faraday/ftgmac100.c only had:

    { .compatible = "faraday,ftgmac100" },

On those kernels, Aspeed MAC nodes bound only through the fallback string.
A node with only compatible = "aspeed,ast2500-mac", as in the updated
example, matches no driver on such a kernel. That includes stable/LTS
kernels that predate that commit, and any other DT consumer that matches
only the generic string.

The commit message only mentions the dtbs_check warnings and calls this a
binding correctness fix. Could it also mention this forward-compatibility
change? Alternatively, could the two-string form be kept as a deprecated
alternative instead of being removed?

[Severity: Medium]
Without the items branch, both oneOf branches accept only a single
string. Every in-tree Aspeed MAC node still uses the two-string form:

arch/arm/boot/dts/aspeed/aspeed-g4.dtsi (mac0, mac1):
    compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";

arch/arm/boot/dts/aspeed/aspeed-g5.dtsi (mac0, mac1):
    compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";

arch/arm/boot/dts/aspeed/aspeed-g6.dtsi (mac0..mac3):
    compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";

After this patch, these 8 MAC nodes fail dtbs_check on every AST2400,
AST2500 and AST2600 board. Nothing in this series updates the dtsi files,
and DTBs already deployed with this compatible become schema-invalid too.
The two-string form was never marked deprecated before being removed.

Dropping the pair also changes nothing at runtime on current kernels.
of_match_node() scores matches by their position in the node's compatible
list, so the dedicated aspeed,astXXXX-mac entries in ftgmac100_of_match[]
already win over "faraday,ftgmac100".

Could the existing items form stay valid, for example marked deprecated,
next to the new standalone enum?

[Severity: Low]
At this commit, ftgmac100_of_match[] has no aspeed,ast2700-mac entry and
enum ftgmac100_mac_id has no AST2700 value. A schema-valid AST2700 node
would therefore bind to nothing.

Later in the series, "net: ftgmac100: Add AST2700 compatible support"
adds FTGMAC100_AST2700, the match entry and the BIT(30) EDORR selection in
ftgmac100_probe(). So this only affects the intermediate state.

> @@ -30,7 +29,7 @@ properties:
>      minItems: 1
>      items:
>        - description: MAC IP clock
> -      - description: RMII RCLK gate for AST2500/2600
> +      - description: RMII RCLK gate for AST2500/2600/2700

[Severity: Low]
Should clocks also be required for aspeed,ast2700-mac? The top-level
required list has only compatible, reg and interrupts, and no conditional
adds clocks.

With the later driver patches in this series, ftgmac100_probe() calls
ftgmac100_setup_clk() for AST2700, which does:

	clk = devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
	if (IS_ERR(clk))
		return PTR_ERR(clk);

So an AST2700 node without clocks passes dt_binding_check but then fails
probe.

phy-mode is made required below to match a probe-time requirement. Should
clocks be required for the same reason? AST2400-2600 already have this
gap; this patch extends it to the new compatible.

> @@ -82,26 +81,35 @@ allOf:
>            contains:
>              enum:
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>      then:
>        properties:
>          resets: true
>      else:
>        properties:
>          resets: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2700-mac
> +    then:
> +      required:
> +        - phy-mode

[Severity: Medium]
Should this requirement exclude NC-SI configurations? use-ncsi takes
the place of an MDIO PHY. When it is present, probe goes down the
ftgmac100_probe_ncsi() path and returns before ftgmac100_mii_probe()
is reached. The driver therefore never reads phy-mode for such a node.

With this block, an AST2700 node written like the first example in
this binding fails dt_binding_check / dtbs_check because phy-mode is
missing:

    compatible = "aspeed,ast2700-mac";
    reg = <...>;
    interrupts = <...>;
    use-ncsi;

The only way to make it pass is to add a phy-mode value that nothing
consumes. That value would also not describe the hardware, since
there is no PHY on that MAC.

The commit message says this matches the driver's probe-time
requirement. As far as I can tell, that requirement only applies on
the PHY path, not with use-ncsi.

Could the then: branch be limited to nodes without use-ncsi? For
example, a nested if: with not: required: use-ncsi could carry the
phy-mode requirement. Or is there a reason AST2700 NC-SI boards need
phy-mode as well?

[Severity: Low]
The commit message says:

    Require "phy-mode" to be present in the device tree when the AST2700
    compatible is used, matching the driver's probe-time requirement.

It also describes the AST2700 EDORR, clock and DMA mask handling in
ftgmac100_probe().

At this commit, ftgmac100.c has no AST2700 support and never calls
dma_set_mask*(). ftgmac100_mii_probe() also still treats phy-mode as
optional:

	err = of_get_phy_mode(np, &phy_intf);
	if (err)
		phy_intf = PHY_INTERFACE_MODE_RGMII;

This driver behavior is added later in the series by:

    "net: ftgmac100: Add AST2700 compatible support"
    "net: ftgmac100: Require phy-mode for AST2700"
    "net: ftgmac100: Add AST2700 upper DMA address support"

Putting the binding first is the normal order. Could the commit message
say that it describes the driver once the rest of the series is applied?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-support_ast2700-v3-0-8d7999171ac4%40aspeedtech.com
