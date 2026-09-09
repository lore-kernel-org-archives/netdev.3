Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35582492E2E;
	Wed,  9 Sep 2026 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924013; cv=none; b=BwmmKClrus7zu0QK7ySgInSV3r4ae/OH1kujL1vgYrgWjgrE8UBdTv1wbBLbWDyxCj/rtG0n9JvzmXUG34VmF1dP8XD7YQFftsW3sopzjvoZQTA+VPtWEGhzRdZw9InRi98aemlQtsFMiP4r1cyPiGSBk25sORaBkQA6DKMDfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924013; c=relaxed/simple;
	bh=IZDLYJ7xMnEPiB3Tf+1vZA9giriFKCN+nxZ8iF011Mk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB5i3VCafXraLDY7n/hX0WFjupOl3rJq9J9t3ja2zRE9abi/AaEeLDv5214Bmjoc2rx/I/LFMSEuqQsSORz9pgJadkcEny1jA5wjykEUY7i/K17muu5NmydZipPqc6k0RJA03V5Xt0SkkvaDe5J3J18K6vHdA5emJnrls17/Axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia2jUP+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia2jUP+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD4A1F00A3D;
	Wed,  9 Sep 2026 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924011;
	bh=+bE8TLlZRfzfaRnGKw6Bc14CJN9WPNxID2/uGzg5a1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ia2jUP+7RW2FyzCyeZl6xjqbgiexj3+sb1kZLHzYyZo2ebjR1Ry7bYKggOZliLSpv
	 Gv4IjpDVaLHcHGyYRtZ8s4RG8P3oiHe0JqbUjEMlgmjdidUsMDp031kvH71pnmzDDE
	 NjkTre1dzrjqt6Y4Pe+EIS57tCv3WKhNuir9FWDrv6TFamnfI16AY1h2hyXlM74Yzj
	 XrelGMgO4AINjnt2XW8yG1OSyTP1DWDd7WbNXDEUk9x3thdurvyAoCClbwplwbGYIQ
	 /ZGMfpPSt30gShMAqTEb3fWLZ2kHYyDVYbXNDtanslDmvNxdpBXqchbwRhzpcElHds
	 Nh3q4vWCHyfhA==
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: realtek,rtl9301-mdio:
 Add clock-frequency
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 03:20:10 +0000
Message-ID: <178892401047.219967.3156215211364602288@kernel.org>
In-Reply-To: <20260906081946.3499898-2-markus.stockhausen@gmx.de>
References: <20260906081946.3499898-2-markus.stockhausen@gmx.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Concern (validated as a FALSE POSITIVE, retained only because
  requires_validation=true): the claim is that the new `clock-frequency`…

--

dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency

This documents a per-bus clock-frequency property for the Realtek Otto
switch MDIO controller, with a default of 2.5MHz and per-family enums of
the supported MDC rates. No clock reference is added because the setup
bits do not look like dividers of a known hardware clock.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 67e0b23a8470e..88502d017eedb 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -56,6 +56,9 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      clock-frequency:
> +        default: 2500000
> +

[Severity: Low]
This isn't a bug, just a note on ordering for anyone reading this patch
standalone: at this commit nothing in tree reads clock-frequency for this
binding, so on its own the property and the documented 2.5MHz default are
not yet implemented.

The consumer arrives later in the same series, in
drivers/net/mdio/mdio-realtek-rtl9300.c:otto_emdio_probe_one():

	if (of_property_read_u32(node, "clock-frequency", &freq))
		freq = 2500000;
	err = priv->info->set_bus_frequency(bus, freq);
	if (err)
		return dev_err_probe(dev, err, "cannot set frequency %u for MDIO bus %d\n",
				     freq, mdio_bus);

with per-family .set_bus_frequency callbacks whose accepted values match
the enums added below, so the schema and the driver agree once the whole
series is applied. Nothing to change here.

>      required:
>        - reg
>  
> @@ -71,6 +74,43 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - realtek,rtl8380-mdio
> +              - realtek,rtl8381-mdio
> +              - realtek,rtl8382-mdio
> +    then:
> +      patternProperties:
> +        '^mdio-bus@[0-3]$':
> +          properties:
> +            clock-frequency:
> +              enum: [2500000, 10000000]

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906081946.3499898-1-markus.stockhausen%40gmx.de
