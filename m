Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726621;
	b=eUqxPg72jvvItORW1JPrKv2V7zVPGUQ35kH3d0Njq88UxH82keT7Y25M481S51T7qNpl
	 onzbr9znklO843+GRz0Vv4YpmvV2g6jmn1hzY2zg0XwOdYaE3bmm0eY3FzDDoGbHMx/zi
	 n+/egAgFvwE8Az0xBMw8SfYIy2PKR8DnOVZRw048AFH4vMXaSbHAuqWa7xsoIt51vqHH3
	 ieeJ3o5TX0M7sM5ZTu//tOPdbnyfYty4xdYx0RGrAVVtI4Mbxr7I1je1GbiFUxhfhiLG4
	 O4+xH7qw7Lrs2u1lFbTaZa0ggFGanYt8Ip5uz++T2cEHYPO/p320ZYaBvu9HmQR6uoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726621;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vgVyc28o83ePa4RfuYkxxOp8BQWfpkm7DlJ7AzwYp/Q=;
	b=oz5s/IlwpUenGOMUj+p9xeTCj1vTxpNfWC674ZATrnWZA5Wv16pl/soQ8r5E/jtxXhcf
	 gwTPRJVxxrt8tqZQ5jrKv9g5EeCHJRgBaE+xvGqUP4XQw34UqkC2IyTinl8Wu5geb8NjJ
	 Bysvt5M8gOZsVLPmm/0uN/+o2LQUqXL8UC7fzufS8TM7TQKgM9fPE4El2Z8CmzjnmyHKA
	 QaezCDGC8AZYTJ57QPCDVChqSI8oe2/2Rgib/GT+sq/zgZ/8js2KuazU4bxP6TLYpPqht
	 HfpWafZvQH/j3PnBPxKRhyygFAoMFU7a9zhyAHmIuh1QTM3hD4tD4zW0mlxhUCEj9MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWjW44Zm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC4606A31D;
	Fri, 23 Oct 2026 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWjW44Zm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF4C1F01828;
	Fri, 23 Oct 2026 03:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792726621;
	bh=vgVyc28o83ePa4RfuYkxxOp8BQWfpkm7DlJ7AzwYp/Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aWjW44ZmrbUTynLjtYFaoeAztuXlm1Td6vlaoI1jlYqHV5wolvi6PQDFeitjTWoHr
	 OjKjw33jRpSdZmNHueKZYAJAvP5/lTMATJvslBbbOHD/h9wOqc7GDIfL9x6wWnpLrS
	 DLvm+s45ZjOvYKoWdscIPc3Gpynnvr02GIpljLskkDfKW/LQIMCbYyU0aO3ydpZngp
	 pLJpK8/Z5Qa5VHKyfzU+hGPTYxJZtfmJuyrcT+iIMpwp/rUSUL8yUKCQMkY8aiKe/j
	 dcnnS7m8+yOzE4s7cNB+Cxe0xzypgxOnrl0ysvqxyixE1+OwPFTlZi1Cbi9jVBM3ks
	 bwB73TTNcDBrA==
Subject: Re: [PATCH net-next v3 4/5] dt-bindings: net: maxlinear: add
 MxL86211C lane mapping support
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Date: Fri, 23 Oct 2026 03:36:59 +0000
Message-ID: <179272661940.3134.15176065761934199853@kernel.org>
In-Reply-To: <20261020093655.344585-4-robert.marko@sartura.hr>
References: <20261020093655.344585-4-robert.marko@sartura.hr>
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

- [Low] Concern: the binding adds `maxlinear,lane-asp-map` for the
  MxL86211C, but no driver code reads it, so the title "add MxL86211C…

--

dt-bindings: net: maxlinear: add MxL86211C lane mapping support

This patch documents an optional maxlinear,lane-asp-map property for the
MxL86211C. The property describes how the physical TPI lanes are wired to
the analog front ends (ASPs). The select block now also matches nodes that
carry the property, and the property is rejected for non-MxL86211C
compatibles.

> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 53f430e12151..7b6140baf175 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml

[ ... ]

> @@ -41,6 +44,21 @@ properties:
>        Optional regulator supplying the VDDP pin. Its voltage configures the
>        MDIO, MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
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
> +

[Severity: Low]
The subject says "add MxL86211C lane mapping support", but this commit
only documents maxlinear,lane-asp-map. Nothing in this commit reads the
property. Does the driver support come in a separate patch?

The next patch in the series appears to cover it. "net: phy: mxl-gpy:
support MxL86211C lane mapping" adds mxl86211c_configure_lane_asp_map() to
drivers/net/phy/mxl-gpy.c. That function:

  - reads the property with device_property_count_u32() and
    device_property_read_u32_array()
  - checks that each value is in the range 0 to 3 and appears only once
  - writes VSPEC1_LANE_ASP_MAP with phy_modify_mmd()

mxl86211c_config_init() calls it, so the mapping is programmed again after
each hardware reset.

At the end of the series the property has an in-tree user, so this looks
resolved. It is noted here only for completeness.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020093655.344585-1-robert.marko%40sartura.hr
