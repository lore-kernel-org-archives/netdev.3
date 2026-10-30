Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376701;
	b=AyEVH1CYz68ae19OTZHTlRl1pD2QDXWWU/FFDmT+GNcgTlV50IpwW8Cc2jZ2vTja8Ck8
	 mr6mobLynm1Kp/cOcvDEU/AML5kfWHtH1CA/gA9TBtaRnt6X9NaXXPu/qivzqC+X7ALyy
	 l+Lj2fPoULzActlozpGmyBtZBUL0ySv2r5mxwDUMtk85FxOkOqeJY4BjBm2p65VadI48K
	 eDScXA3nTVP3j5Ln8/eG4y4YrdYyy5TJzMSO6wPF+zUbb6Wbhu+BrgelbNR8xGhQ7eEFa
	 IN+eNxcGyMZm9qUlvuMl1h9C5fBsZz8UZG/9IU/QP1fVp2yw8UMKd0Tp01zp64VAF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=THuUtMwAVhpRA2NrdipfCYJztWnUG7sDWK3sD1+K1lM=;
	b=Vn/lXIhcTVpScUBDFp+jsaNkx7t8+vTnHUxHWLBzyVrDQMJPe5PQ88hacNUZu2pzn/xV
	 TOV6DCRNESJEruHGL69GY9Zcn8EomJ9l0wK63Sd33v5YiPNj3xk1VvPnm24yvDZaq7UwJ
	 9zOa7yK426sj5XVBpOREpq9GxNG99EU41GEVa9Rzgmle1A7XzTEm11fAe5kZRKQ/eDMur
	 dE2FQb2R3RsZ7WMXrly+Or5tKaILNdR2agHkYDsP7T1CAR9UuKhUfv7jbvgLItg/DXvhI
	 ETYXe9kd96fygxmD14dlwKsy+7yCuxXymPlypK/5muvYjQF9gEYVB1eN8b9qIrN+0YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbP+WE9W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C45606A31A;
	Fri, 30 Oct 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbP+WE9W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D16C1F000C1;
	Fri, 30 Oct 2026 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376700;
	bh=THuUtMwAVhpRA2NrdipfCYJztWnUG7sDWK3sD1+K1lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fbP+WE9WgEDroWQuXs/xxxP43YHUSkAqlpiRQE41b7SzSq3/Q6hb64UvFiADwJDXv
	 CJ18QZZ6WHKWQudZ8i5PCsag/0BMfx6mkYpsSeO8e3i5gClIzcLjY1zuI1tGBRV5We
	 KcxOi0xekKwRumSOhPc/wJGh14FnTnRKzDDzEYDwvJ27fRh5bqbIHnke3sha4CPkH9
	 xVxYkLFt+EtAqfCR2OtCRGPFvh2zr/kNtFxs4kQRYlVrbiZ7xb/aRJQ+t0f3fDLn/v
	 knvqtnAis0ljkjIkst4j4uGkthg6m/g26ICo+bOBdzTJPadylKQzgio2uvi6K9hzki
	 jYU6GEt3rlRHA==
Date: Fri, 30 Oct 2026 11:11:36 -0500
From: Rob Herring <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
	michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 1/5] dt-bindings: net: maxlinear: add
 MxL86211C VDDP supply
Message-ID: <20261030161136.GA259810-robh@kernel.org>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020093655.344585-1-robert.marko@sartura.hr>

On Tue, Oct 20, 2026 at 11:35:34AM +0200, Robert Marko wrote:
> Describe the optional VDDP supply used by the MxL86211C PHY. Its
> voltage determines whether the MDIO, MDC, and MDINT pads use 1.8 V or
> 3.3 V.
> 
> Existing device trees do not describe the supply and rely on the hardware
> reset default. Keep the property optional to preserve their compatibility.
> 
> Select the MxL86211C PHY ID and nodes using the existing MaxLinear
> broken-interrupt property, so this binding is checked during normal DT
> validation. Restrict the new supply property to the MxL86211C with the
> compatible conditional.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v3:
> - Make VDDP optional for existing device trees.
> - Select MxL86211C nodes and nodes using the legacy MaxLinear property.
> - Replace the empty then branch with a negated compatible condition.
> 
> Changes in v2:
> - Model VDDP as a supply instead of a regulator provider.
> - Select the schema for the MxL86211C PHY ID.
> 
>  .../bindings/net/maxlinear,gpy2xx.yaml        | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> index 8a3713abd1ca9..53f430e121510 100644
> --- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> @@ -10,10 +10,37 @@ maintainers:
>    - Andrew Lunn <andrew@lunn.ch>
>    - Michael Walle <michael@walle.cc>
>  
> +select:
> +  anyOf:
> +    - properties:
> +        compatible:
> +          contains:
> +            const: ethernet-phy-idc133.5400
> +      required:
> +        - compatible
> +    - required:
> +        - maxlinear,use-broken-interrupts
> +
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: ethernet-phy-idc133.5400
> +        required:
> +          - compatible
> +    then:
> +      properties:
> +        vddp-supply: false
>  
>  properties:
> +  vddp-supply:
> +    description: |

Don't need '|'.

> +      Optional regulator supplying the VDDP pin. Its voltage configures the
> +      MDIO, MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
> +
>    maxlinear,use-broken-interrupts:
>      description: |
>        Interrupts are broken on some GPY2xx PHYs in that they keep the
> @@ -45,4 +72,25 @@ examples:
>          };
>      };
>  
> +  - |
> +    vddp: regulator-vddp {
> +        compatible = "regulator-fixed";
> +        regulator-name = "vddp";
> +        regulator-min-microvolt = <1800000>;
> +        regulator-max-microvolt = <1800000>;
> +    };

Drop. Examples don't show providers.

> +
> +    ethernet {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@0 {
> +            compatible = "ethernet-phy-idc133.5400",
> +                         "ethernet-phy-ieee802.3-c45";
> +            reg = <0>;
> +            vddp-supply = <&vddp>;
> +
> +        };
> +    };
> +
>  ...
> -- 
> 2.56.0
> 
