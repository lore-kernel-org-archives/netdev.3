Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963634;
	b=GG/VcVAkCd/sYB5wyJagtksnRw88N6pF951lJCxikAOHr4QuD7YmV3ydX3qDICH7Zetx
	 AHA2lhC0EWc7UdRkcm6qM5eo/CpxazRtmjljgv0nW3+51F/OQ5qVVVPDwUPHoQXvGiAnh
	 vEcEiVMZXpl1kHqiyx7SsGqSBCzMa88wAbAO3Q6JSTR+GiMAKoUSM/x2cKNrY+Aw0+7lR
	 66NZDTO5YLIc4EBYuD38SaUnVscOEKTJaZsqrklpkyBCayUm2kH6Jp+EpY/L3mup0We0u
	 dZtDTsU8LU4hZiBbJsXsEOaStf8p35iqEpXRQ5QRAz0EYBgyhIN3dwYSRA/ESukh8Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963634;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FPW9YYdTNv+IQvXzFfrnGgMOfUMAXGequJy/ZFKNWxE=;
	b=CRAJFWmNyLh/h0p+M1lItfqK0VYVoA6ivliFXGm6Gborz8E0yqMy0MRv2HVkayE2N+3D
	 6PaM8bzxX0UPHwxaPClvdZM7a+hvxb8LxWhR/8kB3wSjQsOByGtrZ2uwbK2Izlw2ULtsE
	 cJp0Jnwy61fFaXF5z5vC59djRQHwWNIXc47ADYSrZM77I/Bte2dO9ZcUPSDxmP3n3AC3+
	 hK91rjcbmH28i1FdYf5P+oj4TVnSIkuOzMZ5CoEuds1NE9EYOh7N+3/+gu3xmGm2SmA0d
	 mBRDTb2P9QwRZvgTQwG/8uyPmGXeHgEhLaGc89LzYNbTzloDgiqmWuylr5E+vkFKBLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCty0Lx5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144C606A32E;
	Fri,  6 Nov 2026 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCty0Lx5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD841F008A2;
	Fri,  6 Nov 2026 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963634;
	bh=FPW9YYdTNv+IQvXzFfrnGgMOfUMAXGequJy/ZFKNWxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UCty0Lx5o5olONYrBwCIaVsiO8Ee6vuN1ogVF+XlJL+KPZCCZn4xmkabhgc4v8Zl7
	 jDjm9CxxzUioazAvPpEF2K44ed+PcGdnlV1eSp2BxKI/Dc4ZYxEDLtB+L48jhP7TT6
	 UWvdHfh9K0EKsxwkTey1TvB0V2KC+mBxuvjIkMaurbMIaUfDPys2k0YnY9NzgiabVg
	 OCHV9OLrQHsGRWTIrD3cd54YbnYq91A2hy8fs7XyOzd05SDHvN3oiWX17UUUiBMfb9
	 lPEvbP+eVBz2wnB9iVwm6jD4A644OgmNpq8zu9rT4HTp6NcpkLt5CeW3oKxi488A+m
	 KOupkyN+7YPMg==
Date: Fri, 6 Nov 2026 12:13:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	mfd@lists.linux.dev, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v4 4/8] dt-bindings: mfd: Add SoC-e SWIP parent
Message-ID: <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
 <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>

On Thu, Nov 05, 2026 at 03:16:48PM +0100, Vasilij Strassheim wrote:
> Add a binding for the SoC-e SWIP multifunction FPGA IP core.
> 
> Describe the shared MMIO address space and address translation for
> the required Ethernet switch child and the optional integrated MDIO
> controller and MMIO-controlled MDIO multiplexer.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  .../devicetree/bindings/mfd/soce,swip.yaml         | 137 +++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/soce,swip.yaml b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> new file mode 100644
> index 000000000000..625be299e262
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/soce,swip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC-e SWIP multifunction Ethernet switch FPGA IP core
> +
> +maintainers:
> +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> +
> +description:
> +  SoC-e Switch IP (SWIP) cores integrate Ethernet switching logic, an
> +  MDIO controller, and an MDIO bus multiplexer in one memory-mapped device.
> +  The MDIO bus multiplexer is wired to the integrated MDIO controller.
> +
> +properties:
> +  compatible:
> +    const: soce,swip
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  mdio@204:
> +    $ref: /schemas/net/soce,swip-mdio.yaml#
> +    unevaluatedProperties: false
> +
> +  mdio-mux@202:
> +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> +    unevaluatedProperties: false
> +
> +  ethernet-switch:

Why are you mixing children with and without bus addresses? This is
discouraged and shows that device is not correctly represented, e.g. if
the ethernet-switch does not have resources, then THIS device is the
ethernet switch.

> +    $ref: /schemas/net/dsa/soce,swip-switch.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +  - ethernet-switch
> +
> +dependentRequired:
> +  mdio-mux@202:
> +    - mdio@204
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ethernet-switch@80020000 {
> +        compatible = "soce,swip";
> +        reg = <0x80020000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x80020000 0x10000>;
> +
> +        mdio_parent: mdio@204 {
> +            compatible = "soce,swip-mdio";
> +            reg = <0x204 0xc>, <0x200 0x2>;
> +            reg-names = "data", "control";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +
> +        mdio-mux@202 {

Nodes are ordered by unit address.

Best regards,
Krzysztof

