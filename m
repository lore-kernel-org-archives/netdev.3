Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9927A133;
	Wed,  8 Apr 2026 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653253; cv=none; b=oBoiVaMctOnkI73RqOfB+lfuCfJ0Tpp6cVBFnkmOCFExMe2qenjpbaEbh+VPkfxTXiu8B1Wn29607ihUtargz4d5fVgCFRN1QKvcWFkMLrd9K+++ktRPJE1DViOqyCu1OBDUIJateAmpboxH+9rlAdtu8cVS34hRiSiPSvxVWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653253; c=relaxed/simple;
	bh=l+S6zaTMHhYUwW0ZmtulDL5Ipcm+rietWnAFHWCYVaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Z4C4tK6HrpGapDIRKouegJF/jt6nFAmWLvQ2fVdvsnfsqWkE6InDsxqUC7My8jxff2hoX3nKMt3fudSB2Pzi1nFB4bAyGIdwZAak7hW4kpKK6nqwLCGhm7xyfHJwEnquWHO9nlLIXX8wPw4w+WYEijsEf81BejGimeuyC1d1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrUKNJdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrUKNJdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B562C19421;
	Wed,  8 Apr 2026 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775653253;
	bh=l+S6zaTMHhYUwW0ZmtulDL5Ipcm+rietWnAFHWCYVaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrUKNJdIC2sHvOEeeLQy4ZebvZEkBrtqNyAc649t6XR5o86pw9WVxPb0cI3PJCLoI
	 nuPVaq8epBHPxn6Z1drKxZ/9Z2+McU/7xhrigXa+nxfH9vT13H8g+JyLK94Uxz7BsX
	 2yz7zb96s7IxCNyseVCEyew+MJjroxIsX6DxbAsQdVcuuCySTPc0+gZs5bcogJgEi5
	 SIQulv643nEr1hXcFq7w77TzrsexqXX9LuyLYUaT4HvCFb/Mx1XMIOHrhhIrkY3iQe
	 g5KNgkLwgwFX6exlGZ/xDGYR3OASD6nEhfJPX91KXMqhEyCwH93zrvwjSoRlHVmrPG
	 QtliB81fvnCIw==
Date: Wed, 8 Apr 2026 08:00:51 -0500
From: Rob Herring <robh@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <20260408130051.GA1895728-robh@kernel.org>
References: <20260330184017.766200-1-joey@tinyisr.com>
 <20260330184017.766200-2-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330184017.766200-2-joey@tinyisr.com>

On Mon, Mar 30, 2026 at 09:40:14PM +0300, Joris Vaisvila wrote:
> Add bindings for MT7628 SoC's Embedded Switch.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> ---
>  .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> new file mode 100644
> index 000000000000..d6c66ab677d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/mediatek,mt7628-esw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT7628 Embedded Ethernet Switch
> +
> +maintainers:
> +  - Joris Vaisvila <joey@tinyisr.com>
> +
> +description:
> +  The MT7628 SoC's built-in Ethernet Switch is a five port switch with
> +  integrated 10/100 PHYs. The switch registers are directly mapped in the SoC's
> +  memory. The switch has an internally connected 1G CPU port and 5 user ports
> +  connected to the built-in Fast Ethernet PHYs.
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7628-esw
> +
> +  reg:
> +    maxItems: 1
> +    description: MMIO address of the switch

Drop the description.

> +
> +  resets:
> +    items:
> +      - description: Phandle of system reset controller with ESW reset index
> +      - description: Phandle of system reset controller with EPHY reset index

Just describe these in terms of what they reset, not the provider.

> +
> +  reset-names:
> +    items:
> +      - const: esw
> +      - const: ephy
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - resets
> +  - reset-names

Surely 'ethernet-ports' is required?

> +
> +examples:
> +  - |
> +    switch0: switch@10110000 {
> +        reg = <0x10110000 0x8000>;
> +
> +        resets = <&sysc 23>, <&sysc 24>;
> +        reset-names = "esw", "ephy";
> +
> +        compatible = "mediatek,mt7628-esw";

compatible goes before reg.

> +
> +        ports {

"ethernet-ports" for new bindings.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {

And ethernet-port

> +                reg = <0>;
> +                phy-mode = "internal";
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                phy-mode = "internal";
> +            };
> +
> +            port@2 {
> +                reg = <2>;
> +                phy-mode = "internal";
> +            };
> +
> +            port@3 {
> +                reg = <3>;
> +                phy-mode = "internal";
> +            };
> +
> +            port@4 {
> +                reg = <4>;
> +                phy-mode = "internal";
> +            };
> +
> +            port@6 {
> +                reg = <6>;
> +                phy-mode = "internal";
> +                ethernet = <&ethernet>;
> +
> +                fixed-link {
> +                    speed = <1000>;
> +                    full-duplex;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.53.0
> 
