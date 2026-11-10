Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333295;
	b=nar3x58OpLCRnYuftOs6Pbb7mhoBDmZxlk0qVwbWLFvZgZ4WFmBT3GWuAQgeLjpteolL
	 pQlyq0kkI9kwkQyGbhpunPYHXEHaQ4GfwObcMbsvROu9bUiY1azsm2ahyt5vZSfkrvwHM
	 MtIsdRAXhB+z2FERE9uUEInB3ZqAfF1h+57vTBVUEtYTaorLFoNN8ofeCVxOgkRRaXjxS
	 HU6mmL6z651igFd60/iI7dMytEEAVo7fSUoypn1JSuURrd+ztnfikWKUs2kGLMgJ/hNpE
	 K7hndWv5zRylJKCosL4hA6Mj+V3As7qU5VVnu/26/cNowoWtIrQZeqv6oPKxe/6QIiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DVguc/JEfu5tg9eL/EvmKXFDpXmh7ZbHiCLJmkzT58A=;
	b=W5yEzNdHap1hRrTdjzfmUN9myqe2MGVRBT3hC4YpKYnsxAvXezm+0n5vxPqLPCdKkKEq
	 8Pyw0OBcM7U+f3o+qYx//9rCBauguB47ZL35kJG9VOPKppcaIxF+kE6qo4+gKotchbiEF
	 SA4YNkvzk2mvh/D7rndYHyT2jdxrq/3PiwN6JJKy1L6rbbG2jMsh8looIlOACts9RnJ5f
	 rgY8Cd4B02DXNC9LtHQeEYkIyxlpnzXGX0UACP2JtKrC2JTQEvt1cnybexATo7hNuwY4v
	 luMhva8eAHKUsJmnvoopl857i/AAqbyqR/Ml9tR4TX1UcpZpd2iTcNIgSIVXS6zGVgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsJWDnyt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5E60A5BEB;
	Tue, 10 Nov 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsJWDnyt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11381F0089F;
	Tue, 10 Nov 2026 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333294;
	bh=DVguc/JEfu5tg9eL/EvmKXFDpXmh7ZbHiCLJmkzT58A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LsJWDnytPzC4b4TwtpmQ2p6dTKAVt+LKt+JO+6Vmzd9NizDFA0CIHwNQQ6AIuX4/s
	 SsGTjIMoGEYGYylrqoqSC+7pD6ePrIPrGXJ/520xx80j0Ql7SBWVpDJf3DtsxqizKW
	 bReRmSA5r6Wl8lV7mPGzizz1wCU2+osYEV2X8hfHa7RUOSOehY5aQt99e9AubhQEU4
	 VJEKYSweUPlLKcytgU8QsynZnIPhbJAk3JLb7GZ2+2LoHy4k2kZbtJi9wK35oUAk1X
	 2Ok7oUtnc927IbYmHbFNH+FFFIGb7CkRnghD9SonhReAdd5Z5TGgUonzhSXXx7Nt2W
	 Rvs0IAMzNsUEg==
Date: Tue, 10 Nov 2026 11:54:51 -0600
From: Rob Herring <robh@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <20261110175451.GA833369-robh@kernel.org>
References: <20261105100322.37816-1-tanure@linux.com>
 <20261105100322.37816-3-tanure@linux.com>
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
In-Reply-To: <20261105100322.37816-3-tanure@linux.com>

On Thu, Nov 05, 2026 at 10:03:17AM +0000, Lucas Tanure wrote:
> The T7 has the same ethernet glue as the G12A but needs two clocks of
> its own. The controller reaches memory through a pipeline stage with
> its own gate; nothing else claims it, so it is switched off as unused
> and transfers never finish. The glue registers sit in a block clocked
> together with the MDIO multiplexer, which probes after the controller
> has programmed them: the writes are lost and the port keeps the
> bootloader's delays.
> 
> So the T7 gets its own clock list, without the timing adjustment clock
> it never uses. Its delays follow ethernet-controller.yaml: the PHY adds
> the 2ns, and only the receive delay line offers fine tuning, so only
> rx-internal-delay-ps is valid here.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)

I tend to agree with the sashiko comment, but am fine either way. Once 
the if/then schemas are longer than the main schema, it's a sign to 
split.

> 
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index e769c9bb70d8..ff5e50f65114 100644
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
> @@ -84,6 +85,49 @@ allOf:
>          rx-internal-delay-ps:
>            default: 0
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

Sounds like constraints:

maximum: 2000
multipleOf: 200

> +        # added on top of what phy-mode describes. The TX side has no fine
> +        # tuning: its only step is a quarter of the clock period, the full
> +        # 2ns at 1Gbit/s, so the TX property is not accepted.

Move this to tx-internal-delay-ps. You can (kind of ackwardly) do:

tx-internal-delay-ps:
  description: ...
  not: {}

(or "not: true")

> +        rx-internal-delay-ps:
> +          default: 0
> +
> +        tx-internal-delay-ps: false
> +
> +        # Deprecated: new SoCs use the standard *-internal-delay-ps
> +        # properties instead.
> +        amlogic,tx-delay-ns: false
> +        amlogic,rx-delay-ns: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -106,6 +150,7 @@ allOf:
>            contains:
>              enum:
>                - amlogic,meson-g12a-dwmac
> +              - amlogic,t7-dwmac
>      then:
>        properties:
>          rx-internal-delay-ps:
> @@ -142,6 +187,10 @@ properties:
>        - items:
>            - const: amlogic,meson6-dwmac
>            - const: snps,dwmac
> +      - items:
> +          - const: amlogic,t7-dwmac
> +          - const: snps,dwmac-5.10a
> +          - const: snps,dwmac

I would drop either both or at least 'snps,dwmac'. They provide no value 
because there is nothing to use them. IOW, there's not s/w that works 
which only understands the last 2 and not amlogic,t7-dwmac. Correct me 
if I'm wrong. Maybe a bootloader with simple needs.

Rob
