Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503380;
	b=veHk/OxSx18G8Nigg4Mq5rTp0Y31dNSoisVZuDxszWZCDgeBXh+I0Bduq8OUetkfENgi
	 8ciYQq+RziEtWZ+Nw6BtlTZY7sapRvWeQgT3YbAw1Sm0W9/oZ7rkkt6/xlIgcrtCpCS+n
	 lyY+8lriK4p8cKX3FJDmP855SqAkeaJhHGuy1QwT93PVkCsevtZk1XoD6BWgyH9oGmgBh
	 plrRTM59pXuibugVhCvP437pBm6MetICVn99dpcwnB6mYB107MRudNQQ3QYcVEwek6XD7
	 963iK5jqY7FUd7ZxEwM+bCL/1JFbmWfDN+SeenHSIh6M+Wq03irrFOzTHIPx6Nttz5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503380;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4g2T0lgFGixZisGN9hGL+MJinxnor9rjQW+5QYUQkr0=;
	b=OZiEe11DdXsuwjFpIJ4JDJ/dR6wl8R0KHFl76yPua6S8Cx4ANt33zae+79j1Y8eAa38U
	 0HOkDsVa3xZ04nY+LDmaXkpbLqfXyY2cMaz1RqYEw3UfclNcJZIcA0X1UzL6VqCfx0KTq
	 3Br3auCGI1VcIU4SGv3IvTzj95HVyvIx1UzB2yMgvPe7rVdJAJ9+WlzaZGAeZzOZXdGVs
	 ciazn/UFWUEuuRuuCTju7KGFB+9712UJxN//uD8q1X5ZeriB9DJJXylXwhEfiQYwAcsY/
	 n2pqfzG+FZjhAHhd8QAV/BkGWNBXhKhSRD7VBRa9VofAeYuphDhivcHejdt/QmkXUvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIr6uhWV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B19606A319;
	Tue, 20 Oct 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIr6uhWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4C21F000C4;
	Tue, 20 Oct 2026 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503380;
	bh=4g2T0lgFGixZisGN9hGL+MJinxnor9rjQW+5QYUQkr0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GIr6uhWVNcBMpHtrZ24bziY/EqfUphYURI8vuOYLpUJff4rJPberi/K2WtlIX+uEs
	 CgtHS39Hs+sULa7s3hjJml1aUMi2tOM1kmtyvoWo6Yx1VDaqVRsiRZ9V7quT+yznnR
	 s90d/Q7GSDDwNJTSgj+CXpyBAuvM1bg3R+XFvyIhTPNqIknkwYRaP7pvbNoexCl2V3
	 TN2nOhCfUnZSsS8Shsncyv7me8SHMEdc3I+RQk0hMIKYlqI3fkXY0rmZW9ymNfljuH
	 ZBrrfPtGA3UfD9egHmdiho6LuTrRi2Ll72NTbconz7XiLzgpQErXQ2fNgeIqWdqmQl
	 /1MDwp1WHVhKQ==
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: net: maxlinear: add
 MxL86211C VDDP supply
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
 luka.perkov@sartura.hr
Date: Tue, 20 Oct 2026 13:36:18 +0000
Message-ID: <179250337860.3135.8235082668261124184@kernel.org>
In-Reply-To: <20261016112033.949026-1-robert.marko@sartura.hr>
References: <20261016112033.949026-1-robert.marko@sartura.hr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding defines `vddp-supply` as "Regulator supplying the
  VDDP pin", which powers the MDIO/MDC/MDINT pads, and makes it…
- [Low] In Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml,
  the `else: properties: vddp-supply: false` branch (lines 35-37) can…

--

dt-bindings: net: maxlinear: add MxL86211C VDDP supply

This commit adds a vddp-supply property to the MaxLinear GPY2xx binding.
The voltage of that supply selects 1.8 V or 3.3 V for the MDIO, MDC and
MDINT pads. A top-level select restricts the schema to the MxL86211C PHY
ID, and an if/then/else makes the supply required for that PHY.

> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 8a3713abd1ca9..a0dfb6192d81b 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -10,10 +10,38 @@ maintainers:
>    - Andrew Lunn <andrew@lunn.ch>
>    - Michael Walle <michael@walle.cc>
>  
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: ethernet-phy-idc133.5400
> +  required:
> +    - compatible
> +
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ethernet-phy-idc133.5400
> +      required:
> +        - compatible
> +
> +    then:
> +      required:
> +        - vddp-supply
> +
> +    else:
> +      properties:
> +        vddp-supply: false

[Severity: Low]
Can this else branch ever be evaluated?

The new top-level select applies the schema only to nodes whose
compatible contains ethernet-phy-idc133.5400. The if above tests the
same predicate, so whenever the schema runs, only the then branch runs.

No other binding references this schema. Other GPY2xx nodes are not
selected at all, so "vddp-supply: false" is never enforced for them.

The later patch in the series, "dt-bindings: net: maxlinear: add
MxL86211C lane mapping support", adds "maxlinear,lane-asp-map: false" to
this same else branch. That constraint would not be enforced either.

>  
>  properties:
> +  vddp-supply:
> +    description: |
> +      Regulator supplying the VDDP pin. Its voltage configures the MDIO,
> +      MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
> +

[Severity: Medium]
This makes vddp-supply mandatory for the MxL86211C and describes it as
the supply for the MDIO, MDC and MDINT pads. Does anything in the series
enable this supply?

The later driver patch, "net: phy: mxl-gpy: add MxL86211C VDDP supply",
does only two things with the regulator: it gets it, and it reads its
voltage.

drivers/net/phy/mxl-gpy.c:mxl86211c_probe() {
    ...
	vddp = devm_regulator_get(dev, "vddp");
    ...
}

drivers/net/phy/mxl-gpy.c:mxl86211c_configure_mdio_voltage() {
    ...
	voltage = regulator_get_voltage(vddp);
    ...
}

Neither function calls regulator_enable() or devm_regulator_get_enable(),
so rdev->use_count stays 0 for this rail. Take a board where VDDP can be
switched and is not marked regulator-always-on. Could
regulator_late_cleanup() turn the rail off there?

drivers/regulator/core.c:regulator_late_cleanup() {
    ...
	if (rdev->use_count)
		goto unlock;
    ...
}

On DT systems have_full_constraints() is true, so the rail would be
disabled and the PHY would lose power to its MDIO pads.
regulator-boot-on does not prevent this, because late cleanup only checks
always_on.

If the rail is off at boot, nothing ever turns it on. The MDIO accesses
in mxl86211c_probe() and gpy_probe() would then fail.

Other PHY drivers handle this by enabling the supply. For example,
qcom/at803x.c calls devm_regulator_get_enable_optional(..., "vddio").
Should the MxL86211C driver do the same?

The binding example uses a regulator-fixed with no GPIO, which cannot be
switched off, so the example does not show this problem.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016112033.949026-1-robert.marko%40sartura.hr
