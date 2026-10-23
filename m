Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726616;
	b=z4sYfCoeXHmOeI+dVPGEPL8Ie+HnejuyMzTdHcyO4yC7fQYB+c2zxq0pZSpL0XnP1jRu
	 u3JTA3KLlDoQYjkfedoQhqKOSQI512Bf8JSh9u0GrNhHfcN6oxBJy4VFhSd07Gq8KynVA
	 R9VaezUdd3U7hZsfgxHutgmYvBbDc0BaQDwVjPgyLq3LRarkkfbi0bY0nAeUZ8Fwdo0Gl
	 7uiQrjD6ASQwEvufJf3kYinusIJL25F9bHCbVExQLtHZDLc1qAPUBKlOyhCbr/6rkIlv9
	 97ASsgo2JkKUFwHIHM1l7lSuudchl95vNnZJrFK3TlPFjr9UXHwO24gbrWvOv1q0mPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726616;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CwTUdhR4eBYFEeTkoYMhPnX08JKC44f+6H0oQsn1gTQ=;
	b=a9tMN+GbZGh9abeBfLM+iXcbfilwlrSCC1ml5nZWc+pMBckGYZ/LqZ9rgkuwpjP7qNFK
	 ttwktEvOliV8XXi9WpLq2KAvDCEaSUAYc3Q4WSSYejwURo9Fx5vXKH46ptckSkj2HtH0X
	 XN29ANr4ZYLXTFGuqal6N6+sPZNMri3ipP/lBkJuTqxfIWgL/QJxZW6qr6FdImpiwJn6H
	 qA0/c6CkQbK7OMZSOHUXJu6SzD90m+X1W0QQuostDkZ4OJ8Q1epl6JsPBxvIzbSHvu5o+
	 t4C3xtGf5w5IxAS+uKsWjgshsdDzzOTzaobIjt6Heg0G6vTNgEkQHAHF0bXYkYOKnwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnOsRdbB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D3606A319;
	Fri, 23 Oct 2026 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnOsRdbB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90B51F01825;
	Fri, 23 Oct 2026 03:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792726615;
	bh=CwTUdhR4eBYFEeTkoYMhPnX08JKC44f+6H0oQsn1gTQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MnOsRdbBYNTAANy9atjTIoNc86VOnlvh4Aj7omsernt3bz5uCSq9nnGSDi5C11e13
	 T4fB+2TMuEztWAzvGbZar+BGxOp65XRxW7xBk4MXfOZ17SS+Cl0KXbOhdnF/zXRE+9
	 HMphKcK/omOFkRCKu21QDReqHv9KiA0xS1AAmdRLf0uy5M3B5ssmE25ETtuWj4pZHs
	 RWmPCWBFJkg6iyeFbSqL4pMOa9Sl7UVyXxn28NTU9uO2QoZcHo22sb3mW4f/xBn6Gu
	 pQY+gzWc2Wo08LgtNPGZ/oADIS3eWFiE91NaQiFc3AvsvhOelUGMazZVQwKz3wLkE7
	 Bw7QomvV0x5Fg==
Subject: Re: [PATCH net-next v3 1/5] dt-bindings: net: maxlinear: add
 MxL86211C VDDP supply
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Date: Fri, 23 Oct 2026 03:36:54 +0000
Message-ID: <179272661435.3134.10605479743655559994@kernel.org>
In-Reply-To: <20261020093655.344585-1-robert.marko@sartura.hr>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit, the binding adds `vddp-supply`
  (Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml,…
- [Low] Before this patch, maxlinear,gpy2xx.yaml had no `select`, no
  `properties/compatible` and no `$nodename`.

--

dt-bindings: net: maxlinear: add MxL86211C VDDP supply

This commit adds an optional vddp-supply property to the MaxLinear GPY2xx
PHY binding and limits it to the MxL86211C (ethernet-phy-idc133.5400). It
also adds a select statement, so the schema now applies to nodes with that
PHY ID or with the maxlinear,use-broken-interrupts property. A second
example showing the supply is added too.

> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 8a3713abd1ca..53f430e12151 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -10,10 +10,37 @@ maintainers:
>    - Andrew Lunn <andrew@lunn.ch>
>    - Michael Walle <michael@walle.cc>
>  
> +select:
> +  anyOf:
> +    - properties:
> +        compatible:
> +          contains:
> +            const: ethernet-phy-idc133.5400
> +      required:
> +        - compatible
> +    - required:
> +        - maxlinear,use-broken-interrupts

[Severity: Low]
Will this select branch make the first example in this file fail
dt_binding_check?

Before this patch the schema had no select, no compatible and no
$nodename. dtschema therefore generated a select that matched nothing, and
the existing dependency was never checked:

dependencies:
  maxlinear,use-broken-interrupts: [ interrupts ]

With this branch, every node that has maxlinear,use-broken-interrupts is
now selected. The first example has that property, but it uses
interrupts-extended instead of interrupts:

        ethernet-phy@0 {
            reg = <0>;
            interrupts-extended = <&intc 0>;
            maxlinear,use-broken-interrupts;
        };

If the dtschema interrupts fixup only rewrites properties and required, and
not dependencies, wouldn't this report interrupts as a missing dependency
of maxlinear,use-broken-interrupts? Real DTs that wire the GPY2xx IRQ with
interrupts-extended would get the same dtbs_check error.

The example and the dependency are unchanged at the end of the series.
Could the dependency accept either interrupts or interrupts-extended (for
example a oneOf of required: [interrupts] and
required: [interrupts-extended])? Or could the example use interrupts?

> +
>  allOf:

[ ... ]

>  properties:
> +  vddp-supply:
> +    description: |
> +      Optional regulator supplying the VDDP pin. Its voltage configures the
> +      MDIO, MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
> +

[Severity: Low]
Does anything use vddp-supply at this commit? The MxL86211C entry in
gpy_drivers[] in drivers/net/phy/mxl-gpy.c still uses gpy_probe() and
gpy21x_config_init(). Neither of them gets or enables a regulator.

Suppose a DT points vddp-supply at a switchable regulator that lacks
regulator-always-on. Could the rail stay off, or be turned off by the
unused-regulator cleanup, leaving the MDIO, MDC and MDINT pads without
power?

The next patch in the series, "net: phy: mxl-gpy: add MxL86211C VDDP
supply", fixes this. It adds mxl86211c_probe(), which calls
devm_regulator_get_optional(dev, "vddp") and regulator_enable(). It also
adds mxl86211c_config_init(), which reapplies the pad voltage after reset.
So only a kernel built at exactly this commit is affected.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020093655.344585-1-robert.marko%40sartura.hr
