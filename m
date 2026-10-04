Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE414296BA9;
	Sun,  4 Oct 2026 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119871; cv=none; b=NVjUsTU37lQgEP4/cLuGS8N/Nu5nuaPluj6p9oOC4roQytdDMKzzq3WbYyDbS8TY68b0eSn0PYcIY3QeRMnWXpEDnozoS/kXugKhSgmVOn0E8hq3dIbdYypcsIckycswUk8oVeaxls2EC3a4FBR5S0i6df8jL8hxLWAnMLKOio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119871; c=relaxed/simple;
	bh=eiZ0ytx/GzaVZKESSlon9Ky+pjkpkpKUkIIC0vxtsCo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoDktDtMcvdk9JBSoS/ZhnZktBdIN7kuxOwQ5CmBadumliLdzDV06o6LuZWEIkhyp79hLE50uyf03Klj2VumcadTYpkGbNkPswbQtEAjRX2OCX3NcYYj0x2n2x9dQyspVwjmONyGSsGqOGDVIXWM+WF2Oj9ARk6mKy6Ry9tNtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWN3nclK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWN3nclK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26C01F00893;
	Sun,  4 Oct 2026 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119864;
	bh=UI/+ROfNY8CI2KeLNP5CFWRi9MRb++9Dj01tc+lMdQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HWN3nclKlBoZd9HfEReqMpo6EgabkcaVHm9gJ6hAFenF1qVOvJuM04mFQa5Pud0sv
	 xQOb8xIQRWGj1rM3++9zElIZFc967o0nB4ljlVBT+JcacDAphCo5BGY1YhB+amJhVZ
	 CEIyziqfMl1AioyqxT5k89MfTkqPMYcR2Jtp9ILzM7shy7ZzM18KYdHbQREkSOXRok
	 gQJb5tyLOp90m9Ona0tC7Rz6+SiJo4zvKKxLKbd4tweK6mWq9vx9JO6AOprNZ+XP9y
	 goPaOd8NnXsSwuaifUoebuie2vwLkGC533P3vmtif/8CWbzcWvgkkHNoV9w1CzzTEt
	 NztgIUpMZBkRg==
Subject: Re: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane
 mapping support
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Date: Sun, 04 Oct 2026 13:17:43 +0000
Message-ID: <179111986344.434549.288089367079411456@kernel.org>
In-Reply-To: <20260930122305.293686-4-robert.marko@sartura.hr>
References: <20260930122305.293686-4-robert.marko@sartura.hr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The concern says that nothing reads the `maxlinear,lane-asp-map`
  property added by this binding, so DTs using it would be silently…

--

dt-bindings: net: maxlinear: add MxL86211C lane mapping support

This commit adds an optional maxlinear,lane-asp-map property to the
maxlinear,gpy2xx binding. The property describes how the MxL86211C
physical TPI lanes map to its analog signal processing lanes. It is
allowed only for the MxL86211C compatible.

> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 0645e885f1747..b98cb3c3e6d49 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -22,6 +22,21 @@ allOf:
>  
>      then:
>        properties:
> +        maxlinear,lane-asp-map:
> +          description: |
> +            Mapping of the physical TPI lanes A through D to the PHY's
> +            analog signal processing lanes (ASPs). The array index identifies
> +            physical lane A, B, C, or D, while its value identifies ASP A, B,
> +            C, or D, encoded as 0 through 3. Each ASP must be mapped exactly
> +            once. Omit the property to retain the hardware reset mapping.
> +          $ref: /schemas/types.yaml#/definitions/uint32-array
> +          minItems: 4
> +          maxItems: 4
> +          uniqueItems: true
> +          items:
> +            minimum: 0
> +            maximum: 3
> +

[Severity: Low]
Does anything read maxlinear,lane-asp-map at this point in the series? In
drivers/net/phy/mxl-gpy.c at this commit, mxl86211c_probe() does not
handle a lane map. So a device tree that sets this property would have it
silently ignored.

The concern goes away later in the series. The next patch, "net: phy:
mxl-gpy: support MxL86211C lane mapping", adds
mxl86211c_configure_lane_asp_map(), and mxl86211c_config_init() calls it:

mxl86211c_config_init()
  -> mxl86211c_configure_lane_asp_map()
       device_property_present(dev, "maxlinear,lane-asp-map")
       device_property_read_u32_array(dev, "maxlinear,lane-asp-map", ...)
       phy_write_mmd(..., VSPEC1_LANE_ASP_MAP, ...)

That function checks that the four values are a permutation of 0..3
before it writes the register. Once the whole series is applied, the
property has a consumer. Keeping the binding and driver changes in
separate patches is normal for dt-bindings, so this looks fine as posted.

> +
>          mdio-regulator:
>            type: object
>            description: |

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930122305.293686-1-robert.marko%40sartura.hr
