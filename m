Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879836;
	b=MOlnyHjhCuAb5pSvVLx7d8cKhlGC71r9E8HbiR1e8e1p3xixLCsdohJwIgPclTl3o0w7
	 6hF31YyFOyoXMh6SyR70Sx7YjUmRFxcJECvKtXlEp0GJJIIjH9qSHaRw7yCHWlZIGiTwZ
	 PlR4zGQHA4qf5lm8ay8X/Rroe8hLjMyliksJscBbYiWKnBR1rOwITe0BDmBh08ATEapKF
	 ejy/d/Bp9yk3Ry8W9ytx0S2FPYW3UIMlTBLyFC3GG8puHPG2kpUMIvVQqJfZGGZytHRrv
	 TY4SkbDDmu/v0D+1eOQpbribDXETH4eVDIGhr70hwjMBZW7F0nkwdk1ugDjzrujALRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879836;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r6Zmr2w7yD8Ip+j9uCT09/R1QkyDYQmRF/et5N9k+lg=;
	b=sRz2CwF+UjY+5SjmBJRTbbPR6gQ63rPtbWjbPpyX9x8Bw6lTQrIRCrHoh/Cmcce4wfcS
	 u0WJNaTtZNhV7/kd0D+m45wNaRiAb0jkbPE/x2FbFlc1AlgstJtyAaA8d2SV4KtJGGzV2
	 qBuLYHet18Fq0jQJqonMEc/UteECtTYlsibvCroFYqIECKor2r8Qk+A/+ccrFQjjCnly/
	 JR4maYkJMs59UP1Yof/071VA7gRAIGG5WiLELlJtDfHekcEH3dqcxOdgSkQtE9Gt1oUJr
	 HBAxU2B9Z4G5kM7raVTV8VbYhqNRjvWbyi2+EhY75Fhii2urSTxxBLeHdbRQ1nRl+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTkmDUel;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06461606A33B;
	Thu,  5 Nov 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTkmDUel
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D883C1F00919;
	Thu,  5 Nov 2026 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879835;
	bh=r6Zmr2w7yD8Ip+j9uCT09/R1QkyDYQmRF/et5N9k+lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTkmDUel1hF5mX4WG1FDvygwC/sBvJsmKJkN64N5mS8ZMC5a+f8oTJ3ISN3ZVOWL4
	 mTwQMwzNLuNL7ibPktJ939U+6EknlJPb0RQVm9fvpkbNjMuxnqCH7Z+5s3SKedkLpT
	 tswdGkv5+25IksudFLaP9sdC1WSzb8JDtPh7MzFwtmHvzKcXsA1dA8Ay8B8ABMhFWG
	 SBQloVwIXjSJYDGz//5Ki3wtQ1USwZTIyRLvva27DNrEnEtZbQdtOQyP1+Ys7fKuq5
	 odxSGWc/CcDNvfIH+EqM0668iEdTHRVt8TUj1HyDVWyCpAIp4XxyD68l97DnZ8xdfK
	 kovsJbSrlHQGw==
Date: Thu, 5 Nov 2026 12:57:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <20261105-stoic-cricket-of-tolerance-cb3014@quoll>
References: <20261103163715.385394-1-tanure@linux.com>
 <20261103163715.385394-3-tanure@linux.com>
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
In-Reply-To: <20261103163715.385394-3-tanure@linux.com>

On Tue, Nov 03, 2026 at 04:37:10PM +0000, Lucas Tanure wrote:
> 
> Assisted-by: LLM

Drop this one.

> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index e769c9bb70d8..6de013e3e8f6 100644
> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> @@ -23,6 +23,7 @@ select:
>            - amlogic,meson-gxbb-dwmac
>            - amlogic,meson-axg-dwmac
>            - amlogic,meson-g12a-dwmac
> +          - amlogic,t7-dwmac
>    required:
>      - compatible
>  
> @@ -57,6 +58,59 @@ allOf:
>              - const: clkin1
>              - const: timing-adjustment
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,t7-dwmac
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GMAC main clock
> +            - description: First parent clock of the internal mux
> +            - description: Second parent clock of the internal mux
> +            - description:
> +                clock of the pipeline stage inserted in the bus path between
> +                the controller and the DRAM. Without it, the controller cannot
> +                complete DMA transfers.
> +            - description:
> +                clock of the register block holding PRG_ETH0 and PRG_ETH1.
> +                Without it, the block reads as zero and ignores writes.

This sounds like you take clock from other block. That's wrong, that
device should take its own clock.


> +
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: clkin0
> +            - const: clkin1
> +            - const: pipeline
> +            - const: pclk
> +
> +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.yaml.
> +        # The RX delay line of this glue is fine tuning in 200ps steps,
> +        # added on top of what phy-mode describes. The TX side has no fine
> +        # tuning: its only step is a quarter of the clock period, the full
> +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> +        tx-internal-delay-ps: false
> +
> +        # Deprecated: new SoCs use the standard *-internal-delay-ps
> +        # properties instead.
> +        amlogic,tx-delay-ns: false
> +        amlogic,rx-delay-ns: false
> +
> +  # Delay definitions for Meson8b and newer
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8b-dwmac
> +              - amlogic,meson8m2-dwmac
> +              - amlogic,meson-gxbb-dwmac
> +              - amlogic,meson-axg-dwmac
> +              - amlogic,meson-g12a-dwmac
> +    then:
> +      properties:
>          amlogic,tx-delay-ns:
>            enum: [0, 2, 4, 6]
>            default: 2
> @@ -106,6 +160,7 @@ allOf:
>            contains:
>              enum:
>                - amlogic,meson-g12a-dwmac
> +              - amlogic,t7-dwmac
>      then:
>        properties:
>          rx-internal-delay-ps:
> @@ -142,6 +197,10 @@ properties:
>        - items:
>            - const: amlogic,meson6-dwmac
>            - const: snps,dwmac
> +      - items:
> +          - const: amlogic,t7-dwmac
> +          - const: snps,dwmac-5.10a
> +          - const: snps,dwmac

I see no such hunk in the code, so not sure how to review this.

Best regards,
Krzysztof

