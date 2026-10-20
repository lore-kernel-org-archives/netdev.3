Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503385;
	b=dewfpaQZyd01RUGEeIJ8p4EGKsYkVAVLQTrhbd32zEvK1uSEr2K42ekiQNhHCUzT2Fqm
	 MpkFGdqs+6X5IfV9CfPd2yB4dP7SGDqB551cqNAunwmPgaEAxxTOFtb5RHymWqlLtu8jA
	 UoMA1BoT69+0KQClRrmQJY/uq2wAklZ817y6mDmKe451L7uKj5x/Eqt2L1QbjSym0syLx
	 7WfFMYEq9V5MwBXSSEgUMncT67gyXiitG9OUc6YojctMPXoVaM2nqlaZuunX5lzvyyLHW
	 umuCPPRFhVJsvemL8MF3+BTG2wZhtPgJr2js6vrLPsbppTP3Hkguq5rqmOZenMw1uIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503385;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6GZlVKtg84GdphSrcXZ8MrYPbKSkMaooWBifDaZ/5pk=;
	b=LEHu2h+YZctniS8UQbphFsTJoSFsgn7Xtthvr5RKDcVDgpMzEHjoVgXop4uDQMTD7Eh1
	 qy0cL5stKE0YHqptNLdpWB53EjLejbstoVGKRNskAcBJ6pb4MgZar5hp7Db3pDioZYuLP
	 ckDZqh7NyrMcj0SElWfCDE/BZpK9NZzTbFSpkubcQGVIlfQxIq2T3t5bhgMi//jusBbQP
	 WSk8mY0jR58KmjcuJ4kCm9/rQFI5Sm2Sg1QQa/S1JphfvMlgvV/COyrYj1wH4yNVy9vA0
	 cNNaLxJWIQWHPU1YoV/6RGlAaC8PYJJ62XLnuRNSpb0b0dokAOzHWS09mpyn7f+csDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsLffZX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E915606A322;
	Tue, 20 Oct 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsLffZX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E001F000C5;
	Tue, 20 Oct 2026 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503385;
	bh=6GZlVKtg84GdphSrcXZ8MrYPbKSkMaooWBifDaZ/5pk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZsLffZX9d0Mb8hUB1TnrDvczfOoYlwK/kccYoSaWEZWVsnp2xFPhYusZLPrf5iJ0i
	 wYNhzUR+wCghWlH7Rv20pL1Z8ddJKJhnK03XidJ+m+4G5uABbbCaF7OmFYJHehZPb5
	 /POf55g/hvssAe/JtFynZxzrsM5EVZjv6fjZfdq9uCpWa+5VoVJ3Y3/x1OOn3xhKHp
	 KmhE2ky6r4E9sKFcCyc4YONqb65I7NuvEzWjVsEcpkHxnvTbTZOOkcT+jzw/9Z4Im3
	 yNlxE/6HCdFj64McVrbAgUM86uBCKXCpSaa+Kugkl2JwwOX8iLgxIzWuTu8/mjUcD6
	 rS+4DyMoXwNAQ==
Subject: Re: [PATCH net-next v2 4/5] dt-bindings: net: maxlinear: add
 MxL86211C lane mapping support
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
 luka.perkov@sartura.hr
Date: Tue, 20 Oct 2026 13:36:23 +0000
Message-ID: <179250338355.3135.16545535633910438190@kernel.org>
In-Reply-To: <20261016112033.949026-4-robert.marko@sartura.hr>
References: <20261016112033.949026-4-robert.marko@sartura.hr>
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

- [Low] REFUTED (baseline decision false; kept only because
  requires_validation=true).
- [Low] The new line `else: properties: maxlinear,lane-asp-map: false` in
  maxlinear,gpy2xx.yaml can never take effect.

--

dt-bindings: net: maxlinear: add MxL86211C lane mapping support

This adds an optional maxlinear,lane-asp-map property to the GPY2xx PHY
binding. The property describes how the physical TPI lanes map to the
MxL86211C analog front ends (ASPs). The patch also extends the existing
else branch so the property is rejected on PHYs other than the MxL86211C.

> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index a0dfb6192d81b..4323be300c721 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -35,6 +35,7 @@ allOf:
>      else:
>        properties:
>          vddp-supply: false
> +        maxlinear,lane-asp-map: false

[Severity: Low]
Can this else branch ever be evaluated? The top-level select of this schema
only matches nodes that carry the MxL86211C PHY ID compatible:

select:
  properties:
    compatible:
      contains:
        const: ethernet-phy-idc133.5400
  required:
    - compatible

The if inside allOf tests the same condition:

  - if:
      properties:
        compatible:
          contains:
            const: ethernet-phy-idc133.5400
      required:
        - compatible

So every node this schema applies to takes the then branch. No other binding
references maxlinear,gpy2xx.yaml, so the else branch has no other way to be
reached.

Other PHY nodes are checked only by ethernet-phy.yaml, which selects by
$nodename and has additionalProperties: true. That covers other GPY2xx PHYs,
and also MxL86211C PHYs that leave out the optional PHY ID compatible because
they are auto-probed.

On those nodes, maxlinear,lane-asp-map: false is never enforced. The
minItems/maxItems, minimum/maximum and uniqueItems constraints are never
checked either, so a value like <0 0> would pass dtbs_check. The problem
would then only show up at boot, when the driver's config_init rejects the
value.

The vddp-supply: false line added earlier in this series has the same
problem. This patch adds a second restriction that depends on it.

Would it make sense to change the select so it matches every node that could
use this binding, or to drop the else branch? Another option is to require
the PHY ID compatible whenever maxlinear,lane-asp-map is present.

> @@ -42,6 +43,21 @@ properties:
>        Regulator supplying the VDDP pin. Its voltage configures the MDIO,
>        MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
>  
> +  maxlinear,lane-asp-map:
> +    description: |
> +      Mapping of physical TPI lanes A through D to analog front ends (ASPs)
> +      A through D. The array index identifies the physical TPI lane, while
> +      its value identifies the analog front end, encoded as 0 through 3.
> +      Each analog front end must be mapped exactly once. Omit the property to
> +      retain the hardware reset mapping.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 4
> +    uniqueItems: true
> +    items:
> +      minimum: 0
> +      maximum: 3

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016112033.949026-1-robert.marko%40sartura.hr
