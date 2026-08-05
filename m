Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7A3DCD95;
	Wed,  5 Aug 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914989; cv=none; b=GP+omS0UtJYn9vlmzQ7HEKthm0muBfabltySaLve9YqWfMbESLtyX+tKbBBZVKzRODPdyD0625hxAdHea72/9Hyc5SzzYbV4SRKaT/bzeL9RH4wX4Hxg8O3uzDIkyq70rD438fBrvCzRCiDEm5tTi58DQo+Jmr3PlzLcXg4x5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914989; c=relaxed/simple;
	bh=f75pkb7T5/jdu6CFpLTd/bzqMnhk7pQpIT7E9X/CQ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB6D81kRKw16NujTrd8Y+O/Fiy7bZrZ5X6oC8xpVbsX5HERD3IYI6e1YTdAS1S9WGWR1gJoTzJ3wUfdAp0AjfWV2L+XPzOxjI9+jBZ2pSCtyhPmVXB8YlSeE0sPE1cm6ng0OWWsAlRbG2EBjI+qlNF6vuv+tQIY0c4p3UsIuOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfuCMa2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfuCMa2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E0F1F000E9;
	Wed,  5 Aug 2026 07:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914986;
	bh=kJXq08sJkug6Mcz5qGLPAxyPM7bBnkDiej3zEpwgtzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VfuCMa2ZSKpC7x6V3r4+9Q7OvelZRJaKlPLGdse6v7At7B0BQfHZjm68xaWRUeISH
	 FYcMOx5aVLYwrJkeRLYCRlRRme3pn+edrgFN8umcaH9bNx4D4Xw/0aKcv3f1LKY3G2
	 vDU9geH1EyduSUlp4DQj7H5IZTrAXSyXJYM78aeqdHybSlw8hbvabPEfAMksFpqkLx
	 +Z4kkdPrskRmrW6PmQRNucRRvOrlVdE/uUagFA8wOezUrXNxHKcfwPPkeZ3aM+Y9G9
	 wyLXAB5hS6odKAaIX/8CoV1KTWblG+sr+a20aMJCT8lIEfvup6NUebxEjg10Cd6bNK
	 NtlH/WP425dkQ==
Date: Wed, 5 Aug 2026 09:29:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs
 binding
Message-ID: <20260805-stirring-wondrous-mule-faf37d@quoll>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-6-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801142244.679437-6-coiaprant@gmail.com>

On Sat, Aug 01, 2026 at 10:22:28PM +0800, Coia Prant wrote:
> Add device tree binding documentation for the Synopsys DesignWare
> XPCS integrated on the Rockchip RK3568 SoC.
> 
> The XPCS is accessed over the APB3 bus and internally connected to
> a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
> QSGMII modes, with four MII ports.
> 
> The binding describes:
> - Required properties: compatible, reg, clocks, clock-names
> - Optional properties: phys, phy-names, power-domains
> - pcs-mii sub-nodes for each MII port (reg 0..3)

Irrelevant paragraph. We can read the diff. Drop.

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
> new file mode 100644
> index 0000000000000..3e3f3a388d822
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/rockchip-dwxpcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
> +
> +maintainers:
> +  - Coia Prant <coiaprant@gmail.com>
> +
> +description: |
> +  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Physical
> +  Coding Sublayer (XPCS).
> +  The PCS provides an interface between the Media Access Control (MAC)
> +  and the Physical Medium Attachment (PMA) sublayer through a Media
> +  Independent Interface (GMII).
> +
> +  The XPCS is accessed over the APB3 bus and internally connected to a
> +  Naneng Combo SerDes PHY.
> +  It supports 1000BASE-X, SGMII and QSGMII modes.
> +
> +  The block contains four MII ports (pcs-mii@0..3) that can be
> +  individually enabled and routed to one of the Ethernet GMAC controllers
> +  via the pcs-handle property in the MAC device tree node.
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3568-xpcs
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

reg is always the second property.

Also, use consistent style of quotes.

> +
> +  reg:
> +    description: |
> +      Base address and size of the XPCS register space mapped over the
> +      APB3 bus.

Drop description, redundant.

> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      Clock sources for the XPCS:
> +      - csr: APB3 bus interface clock (clk_csr_i), required for register
> +        access.
> +      - eee: EEE clock (clk_eee_i), required for Energy Efficient
> +        Ethernet (EEE) operation.
> +    minItems: 2
> +    maxItems: 2

No, instead list items with description.

> +
> +  clock-names:
> +    items:
> +      - const: csr
> +      - const: eee
> +
> +  phys:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      The phandle of SerDes PHY (Naneng Combo PHY) that provides
> +      the serial lanes for 1000BASE-X / SGMII / QSGMII.
> +      The SerDes must be powered on and initialised before any XPCS
> +      register access.
> +    maxItems: 1
> +
> +  phy-names:
> +    const: serdes
> +
> +  power-domains:
> +    description: |
> +      Power domain for the XPCS.

Drop sentence and |

> +      On RK3568 this is typically the PD_PIPE power domain, which also
> +      supplies the SerDes PHY.
> +    maxItems: 1
> +
> +patternProperties:
> +  "^pcs-mii@[0-3]$":

Why `git grep pcs-mii@` gives me no results? Are you doing this
similarly to existing devices or is this quite different device than
every other hardware?

> +    type: object
> +    description: |

Same here

> +      One of the four MII ports of the XPCS.
> +      The port number is specified by the reg property (0..3).

Drop sentence, redundant. Schema tells that.

> +      The port is linked to an Ethernet MAC controller via the
> +      pcs-handle property in the MAC's device tree node.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +        description: |

As well

> +          MII port number of PCS.
> +
> +      status: true

Nope, do you see anywhere code like this?

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    #include <dt-bindings/power/rk3568-power.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    pcs@fda00000 {
> +      compatible = "rockchip,rk3568-xpcs";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0xfda00000 0x200000>;
> +      clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> +      clock-names = "csr", "eee";
> +      phys = <&combphy2 PHY_TYPE_SGMII>;
> +      phy-names = "serdes";
> +      power-domains = <&power RK3568_PD_PIPE>;
> +
> +      pcs-mii@0 {
> +        reg = <0>;
> +      };
> +    };
> -- 
> 2.47.3
> 
