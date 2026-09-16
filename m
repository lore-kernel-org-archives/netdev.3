Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447B40DB38;
	Wed, 16 Sep 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565726; cv=none; b=IrHDhc0QTkKnlwgc8d4xJEDgXiu6a4gxoOItIW6wXm65it9hUvlU9TUmHd1Lg7xBv2SinXdOi7i6sS6MANyx4y7BHMnbWWlficZ1qCXyBX4qtb34MYdbOTye+aMuiEhqVDnHMI7pfYJHBj9kgNqXosZlxpQvL0PfTFXondhQjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565726; c=relaxed/simple;
	bh=ithp8wXehDVgZlFEPKBGbPttkHAR3iAsw/cqpEZqHHM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOm4d7gItOXsOW6UTA/Q5PBm/8V4btjx4XPqO8KxHYm9FQZQZLsbsXz5T62BfbIJUW7ylrUEohzaLAuDLOtkD9M+3b+DpMt84NoKIWulWNOUfwRqegm1TtE6CrdcqvtVOsWk4TyGLEEQfVQBqYOMbKQicyJoc8rTi8v5wWl7HOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfqbFyBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfqbFyBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B381F00893;
	Wed, 16 Sep 2026 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789565713;
	bh=AYi4cDOQ7Y4dMk8STRvfk3Fh9Q4RhLBOUTmA17gSuBs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YfqbFyBtHieZtUM1/VbFBmY0Zs+spP6/XaSU9GKDOupXLTvPhkCWJa/JzylzEpmkP
	 ZdmEsUJ2zR24CQ4bJO7+o3qcghLJZPPsUVVuGagG+ZgW4maBqP96EXfTJv+laAYq/+
	 8jgeWwdDJVjJsaeCEwEe8qZRocg/M1HjnfpTkInG+Q1SRuIAOp/y/2+M4ArsoGkmiU
	 SPi2dQurUhSH2CL/1NrLuz3aBiFEdkyFvRwKZ+lnbrRNIaApe1hymp0HvXaxqmwV6X
	 Fi8xHSraWRMzEOapKT7sX7KS5aTpvf1I5zQfnt37nZX49nIlIgUTv+08X2+kEneFZw
	 M21mEpQvePvFg==
Subject: Re: [PATCH net-next v4 2/5] dt-bindings: net: realtek,rtl9301-mdio:
 add clock-frequency
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 16 Sep 2026 13:35:12 +0000
Message-ID: <178956571230.22033.2648098417803980646@kernel.org>
In-Reply-To: <20260912130451.3757276-3-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-3-markus.stockhausen@gmx.de>
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

- [Low] Concern (validated as a FALSE POSITIVE, retained only per the
  retention policy): 'the binding adds a per-bus clock-frequency…
- [Low] Redundant re-declaration of the common `clock-frequency` property
  in Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml.

--

dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency

This documents the MDC frequencies supported by the Realtek Otto switch
MDIO controllers, adding per-family clock-frequency value sets and
describing the shared frequency selector on RTL839x.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 7f5b4897487b2..c5f2289dc0eb2 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -56,6 +56,9 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      clock-frequency:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +

[Severity: Low]
This isn't a bug, but is this declaration needed at all?  The mdio-bus
child subschema already does:

  '^mdio-bus@[0-3]$':
    $ref: mdio.yaml#

and Documentation/devicetree/bindings/net/mdio.yaml already declares the
property:

  clock-frequency:
    description:
      Desired MDIO bus clock frequency in Hz. Values greater than IEEE 802.3
      defined 2.5MHz should only be used when all devices on the bus support
      the given clock speed.

So the property is already permitted by the referenced schema, and its type
is known to dtschema without an explicit uint32 $ref.  Other in-tree
bindings rely on that, for example mscc,miim.yaml uses a bare
"clock-frequency: true" and microchip,pic64hpsc-mdio.yaml declares
clock-frequency with only a default.

The per-family enum blocks added below in the allOf if-then sections are
what actually restrict the accepted values, and those work independently of
this declaration.  Could this block be dropped so the common property is
only described in mdio.yaml?

>      required:
>        - reg
>  

[ ... ]

> @@ -77,8 +84,16 @@ allOf:
>                - realtek,rtl8381-mdio
>                - realtek,rtl8382-mdio
>      then:
> +      properties:
> +        mdio-bus@0:
> +          properties:
> +            clock-frequency:
> +              enum: [2500000, 10000000]
> +              default: 2500000
> +
>        patternProperties:
>          '^mdio-bus@[1-3]$': false

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912130451.3757276-1-markus.stockhausen%40gmx.de
