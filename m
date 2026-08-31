Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B28446831;
	Mon, 31 Aug 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183596; cv=none; b=EWK+qMtAQwtjKMkkgRKy8CaNBYn5YUHVKdoPsOlE+ASTyXan5Q0kDGx+wFfo1yjBzeb0T2aypKMEigDkzP2djlDMjDUZaZVUUXDardOcALfmhq1JA6050zwAyGeSA9QP0Sg1xf2hAXweQ+EomtWNiTM4hZLnfB+dqAHQZ48zGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183596; c=relaxed/simple;
	bh=zY0foNcTe5pgrKyzVvQ2QO9ue4Ee/GjJHcbY5BFUS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPw2CboNQKfI7FazIf4gXMBVir0gL3lSht8tFcwqVD/ktRMnyee3EgmsdHzYs6o2Ye7GfhdGMzWJuvuNPiNhr0wdtmhRoDUPiOJK6yMld2QiNrEg9zEppSuZN+Kyl5bYQ0ge7lUjOTXwyhzwJjMJ3Bvs20Gxs/UAcx3ZoclKTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyIuPFGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyIuPFGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE871F00A3F;
	Mon, 31 Aug 2026 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183594;
	bh=EhqP5zvrDsIqWJb83LJ/RPwpg5QZCRdSehbI/oyNgBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WyIuPFGbJx1WtHiD05nJd6x70Z9jJNrshCrJzvOJwsyc9ALOB0Q4YqYtIEvoYaOAq
	 Iyhow+ziUtj04L4pDc48dTbZDkXXKsxAHM5JjoC+rpyeK3PP+r9hT0n0dZEp5anQ+O
	 T2fxF+wSEKgXw9JGjjj1UYjDaWytcopV9g67C1rrc6aCsLThlxfQAj/ut4n5QyQrFy
	 3eIRE46P7YBSq4hoXtDafXmaQBacuCM2JgjA02XkWtDkBQtSq8w8bl1Mb4GfUdKWwn
	 y3I2MRN19EiQqgEntFYaPHYrHpqo4/69WQNhbwa6YIKd7Re+umtxtgCLAdBvqYB8s+
	 ox9SlZWhrWUeg==
Date: Mon, 31 Aug 2026 08:39:53 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [PATCH v2] dt-bindings: net: ti,davinci-emac: Convert to DT
 schema
Message-ID: <20260831133953.GA723881-robh@kernel.org>
References: <20260818-ti-davinci-emac-v2-1-805736d99e65@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-davinci-emac-v2-1-805736d99e65@gmail.com>

On Tue, Aug 18, 2026 at 05:00:59AM +0530, Bhargav Joshi wrote:
> Convert Texas Instruments DaVinci EMAC binding from text to DT schema.
> 
> Changes from the original binding:
> - Add clocks, clock-names, syscon, power-domains, and ti,hwmods
>   properties that are used in existing DTS files but were undocumented.
> - Disallow syscon and clock-names for ti,davinci-dm6467-emac since they
>   are not applicable to that SoC.
> - Allow 1-2 reg entries (DM816 uses two).
> - Make clocks a required property as driver probe fails without it.
> - Mark ti,hwmods as deprecated.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
> Changes in v2:
> - Remove original text binding that was left in v1
> - Link to v1: https://lore.kernel.org/r/20260817-ti-davinci-emac-v1-1-022678d966e9@gmail.com
> ---
>  .../devicetree/bindings/net/davinci_emac.txt       |  44 --------
>  .../devicetree/bindings/net/ti,davinci-emac.yaml   | 113 +++++++++++++++++++++
>  2 files changed, 113 insertions(+), 44 deletions(-)


> diff --git a/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> new file mode 100644
> index 000000000000..cb1394f6f2d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,davinci-emac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI DaVinci EMAC Ethernet Controller
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,davinci-dm6467-emac
> +      - ti,am3517-emac
> +      - ti,dm816-emac
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

Need to define what each entry is and then a conditional schema for when 
it is 1 entry or 2 entries.

> +
> +  interrupts:
> +    items:
> +      - description: Receive Threshold
> +      - description: Receive
> +      - description: Transmit
> +      - description: Miscellaneous
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ick
> +
> +  ti,davinci-ctrl-reg-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: offset to control register
> +
> +  ti,davinci-ctrl-mod-reg-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: offset to control module register
> +
> +  ti,davinci-ctrl-ram-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: offset to control module ram
> +
> +  ti,davinci-ctrl-ram-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size of control module ram
> +
> +  ti,davinci-rmii-en:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: Set to 1 to enable RMII (Reduced MII) mode.
> +
> +  ti,davinci-no-bd-ram:
> +    type: boolean
> +    description:
> +      Indicates that the EMAC does not have on-chip buffer descriptor RAM.
> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to a syscon node providing access to the System Control
> +      Module (SCM) registers. Used on AM3517 and DM816x to read
> +      factory-programmed MAC addresses from eFuse registers.
> +
> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: TI hwmod name
> +    deprecated: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,davinci-ctrl-reg-offset
> +  - ti,davinci-ctrl-mod-reg-offset
> +  - ti,davinci-ctrl-ram-offset
> +  - ti,davinci-ctrl-ram-size
> +  - clocks
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,davinci-dm6467-emac
> +    then:
> +      properties:
> +        syscon: false
> +        clock-names: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@220000 {
> +        compatible = "ti,davinci-dm6467-emac";
> +        reg = <0x220000 0x4000>;
> +        ti,davinci-ctrl-reg-offset = <0x3000>;
> +        ti,davinci-ctrl-mod-reg-offset = <0x2000>;
> +        ti,davinci-ctrl-ram-offset = <0>;
> +        ti,davinci-ctrl-ram-size = <0x2000>;
> +        local-mac-address = [ 00 00 00 00 00 00 ];
> +        interrupts = <33>, <34>, <35>, <36>;
> +        clocks = <&psc1 5>;
> +        power-domains = <&psc1 5>;
> +    };
> 
> ---
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> change-id: 20260817-ti-davinci-emac-7ec97feca43e
> 
> Best regards,
> -- 
> Bhargav
> 
