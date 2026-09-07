Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0BE448392;
	Mon,  7 Sep 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772887; cv=none; b=Cswge3JUSl4/EuG02tDH7nOS2T4jWB9oVUNVRIz2hdGSYkE+J3P/EhauxOMxiwcxfTM5yn3h0nCoo0oR/tBqGjt8GXc7hpQLSa9Iep0Pd3CQWFvEM6tey8D8cfPBxmUS8UmNEuzBfJxbIAOeKqJvm/cQSQu/V2RcGO/gLngJ9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772887; c=relaxed/simple;
	bh=dXlQ2Fg5i37mpPrZt9hpZ8bAbyBistuBZFQllpjQ9kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7tnu1Q9+dLapPtN7ghCS53UXCw5rS0NMxcRZqBLJr+0stvnKCzLc//VwdHWTpZ0AzzlfJEnL3/oTHQg3e+RH50zpPrI+5h/T2RuGZFWw6UjAMxycNWVdSDleCPRIZXqlBR2N7m1zmcfFLaXotq79eXHHvgYCRQ7pqnZpBX5qYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNKCpcky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNKCpcky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4F31F00A3A;
	Mon,  7 Sep 2026 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788772885;
	bh=vobIiljlcAsX0NjzOBm2HwqlV+hAVsEf4kXRt73ZKG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KNKCpcky6JKpBAF5KSqqVvOOIsP5V20tllovLPz+eBUBoHQwK1DQ8AXJFLxa7FL1a
	 CAM/5hz6uBiO9S0Ee/EBQDpPD5bvNw4cw2zdMIZsuwKGQl2d8yTRHveOyL2nWpwZ5u
	 xo/DWfv6wgx+y0WADn3/ACaTQ8+PYFL3Nss55YwvrbKbGlgVhUvLJhXYm8+gNu4o3k
	 ocuzXXKouFnxuMkRaZoBXOEHcYd0FnfpRU2Uks5MJQ/jJNNmuskM7DNaM9h6t5v2Xz
	 GKHtjOPOr8+k+xE31AaZ+Y12IkE1G63hHVoAurhtAkHxLTPdRgWDbD3+1zeC+97mdA
	 Mq4lhqMYMVMzQ==
Date: Mon, 7 Sep 2026 11:21:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>

On Thu, Sep 03, 2026 at 08:10:59PM +0200, Vasilij Strassheim wrote:
> Add a binding for SoC-e FPGA-based Ethernet switch IP cores.
> 
> The compatible identifies a register layout characterized by the core
> and feature identification registers at the encoded offsets. The
> concrete synthesis-time configuration is then autodetected from these
> registers.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  .../devicetree/bindings/net/dsa/soce,swip.yaml     | 161 +++++++++++++++++++++
>  1 file changed, 161 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> new file mode 100644
> index 000000000000..508e444e10da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/soce,swip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC-e ethernet switch IP core for FPGAs
> +
> +maintainers:
> +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> +
> +description:
> +  SoC-e Ethernet switch IP cores are FPGA-based switches whose features
> +  and number of ports are selected at synthesis time. Ports can connect
> +  to CPUs, external PHYs, FPGA logic, or other switch cores. The
> +  integrated MDIO controller provides multiple independently selectable
> +  external outputs.
> +
> +$ref: dsa.yaml#
> +
> +properties:
> +  compatible:
> +    const: soce,swip-00-04-0c-10
> +    description:
> +      Register layout with the core version register at offset 0x00 and
> +      feature identification registers at offsets 0x04, 0x0c, and 0x10.
> +      Switch instances using this register layout are autodetected from
> +      these registers and use this compatible regardless of their
> +      synthesis-time feature and port configuration.

There is no traceable and documented version or model name?

> +
> +  reg:
> +    maxItems: 1
> +
> +  mdios:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      External MDIO buses provided by the integrated MDIO controller.
> +      Each child bus selects one controller output.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^mdio@[0-9a-f]+$':
> +        $ref: /schemas/net/mdio.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maximum: 30
> +            description:
> +              MDIO controller output index, which must be lower than the
> +              number of implemented switch ports.
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +patternProperties:
> +  '^(ethernet-)?ports$':

ethernet-ports

> +    patternProperties:
> +      '^(ethernet-)?port@[0-9a-f]+$':

ethernet-port

> +        $ref: dsa-port.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maximum: 30
> +            description:
> +              Switch port index. Supported switch configurations have
> +              up to 31 ports, numbered from 0 through 30.

Best regards,
Krzysztof

