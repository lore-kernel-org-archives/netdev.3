Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91857459AD9;
	Tue,  6 Oct 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293071; cv=none; b=Z2+fnO0L6PYc9guYk+fwjMkSjvWMPd/yXw/238aaLXB/3fZyxYNopzEx3OacQNfjYdnMa7oBJnvTdo4etysDPtBqgvcuVQmycTo2i/pAEOzA1AwzMhqTo9vRIo6pgdWifsiGzkbowF7Dx9y9BNHHn7ARuot30FSPyoOkgf8DSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293071; c=relaxed/simple;
	bh=m+Q0z6sOWMEGT1cG48PY7ZD1vCDWAvdsZRqG86THNwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq6zVR+UbcFgJAga3Df8Mqt+k/VpQyiceYIujO5g6LqQlsaNj1W+WstaH+Sc3aX2UitjPp5oUf78CVY4Bj9Dt64lrkUxis6JFogFVI2JoavSVYW/foL0cLg7RAAloiGpLQ+pHCtU8j9QtKLOpdYXlfppcgxPI7sw1uMGPiKtp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuOP5EDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuOP5EDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4EE1F000FF;
	Tue,  6 Oct 2026 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791293070;
	bh=76u9YDW7aKiOQkrk/yybh/tScB4dKv9L1ujivE8+las=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DuOP5EDheODNf4/AFDlTAYw+nYmy4Ieq5s6wLw4yZmmzM3wVUzF9UFio40Cw54iKX
	 tToacGZwZwpAAp6Lbwfel7lvim54fmBt8R2+A+3ZqdAJnskODzeZTnSczp+cRggMCL
	 MUvYTYgDfE4uURhSfzFPb5nSIDSqfY2oO3fXNpbREmSjcl+gFnsfOwAt11p6W+V+EP
	 cFo+Cnqmvngkk3pMjWYsdhjRyGLNZ0ctGv96xnF0PKv791p8VVLM+qeLazLX1rqylq
	 V1gN0Nlu5tTZ3E9zhLTtZx1S9iKkjEGjY8Vd7q4gxBgGQQARdzbj7vI3M2YPk6+FGp
	 0dwvNAIFXroxA==
Date: Tue, 6 Oct 2026 08:24:28 -0500
From: Rob Herring <robh@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 1/6] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
Message-ID: <20261006132428.GA1659963-robh@kernel.org>
References: <20261005223011.1124347-1-coiaprant@gmail.com>
 <20261005223011.1124347-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005223011.1124347-2-coiaprant@gmail.com>

On Tue, Oct 06, 2026 at 06:30:03AM +0800, Coia Prant wrote:
> Add device tree binding documentation for the Synopsys DesignWare
> XPCS integrated on the Rockchip RK3568 SoC.
> 
> The XPCS is accessed over the APB3 bus and internally connected to
> a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
> QSGMII modes, with four MII ports.
> 
> The four MII ports are described as ethernet-pcs-mii@N child nodes,
> consumed by the Rockchip XPCS glue driver later in this series.
> 
> phys and phy-names are required because dtbs_check only validates
> required properties for enabled nodes. The SerDes link is a board-level
> design choice (combphy1 on some boards, combphy2 on others), so these
> properties must be provided by the board device tree, not the SoC dtsi.
> 
> The CRU reset lines (SRST_XPCS*) are intentionally not described: no
> in-tree user requests them, and bring-up relies on the PD_PIPE power
> domain, the SerDes PHY and the in-IP soft reset. They can be added
> later as optional without breaking ABI.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  .../net/pcs/rockchip,rk3568-xpcs.yaml         | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..703fcff0e3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/rockchip,rk3568-xpcs.yaml#
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
> +  The block contains four MII ports that can be individually enabled and
> +  routed to one of the Ethernet GMAC controllers via the pcs-handle
> +  property in the MAC device tree node.
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3568-xpcs
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: APB3 bus interface clock (clk_csr_i), required for register access
> +      - description: EEE clock (clk_eee_i), required for Energy Efficient Ethernet operation
> +
> +  clock-names:
> +    items:
> +      - const: csr
> +      - const: eee
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: serdes

You don't really need phy-names if there is only 1 entry.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^ethernet-pcs-mii@[0-3]$":
> +    type: object
> +    description:
> +      One of the four MII ports of the XPCS. The port is linked to an
> +      Ethernet MAC controller via the pcs-handle property in the MAC's
> +      device tree node.
> +
> +    properties:
> +      reg:
> +        description: MII port number.
> +        enum: [0, 1, 2, 3]
> +
> +    required:
> +      - reg

Why the child nodes? They don't contain anything.

Perhaps that's due to pcs-handle not supporting arg cells to pass the 
port number? That's about to change[1].

Rob

[1] https://github.com/devicetree-org/dt-schema/pull/198
