Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7C3E8C60;
	Fri, 15 May 2026 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830161; cv=none; b=dlOhYuPAPs5vc3VCe4dSc11mSTstThkhLZh+8RFh8gF4bNGsCUD4nHB/iDCiTBr27VYwcGdJMXdVzPyNdyDpXBKque2ThTWw9msfG+Egub0x0mNjmrDtcSJCgDm2zpm8/QCyiwM1eFGkct+beGtl0Oml/XJ5ggABZRmuG05Ex9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830161; c=relaxed/simple;
	bh=Nz609sIXNSfx4zkRvanpjMAqc+T7oYl5d5XpZwibQCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHjpgvmyH5MtmX/iMSxovYGxn/eqdqnD/40qTv01GxQf+M0V6bsp9OidtuaSztf+cMcr8bCHQ707z8xL1wHR2JRxGRskIPEnKwmLtC9YGarMsq9sdj2kYdZSMO3WIS0R0K2Sa+vMVgccbiABrrXqi432WhOEg1thWEB45JGAsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJqk6tlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJqk6tlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555D9C2BCB0;
	Fri, 15 May 2026 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778830160;
	bh=Nz609sIXNSfx4zkRvanpjMAqc+T7oYl5d5XpZwibQCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJqk6tlhH8G+drsgS6IYp7FBgGZuGNajkrXly5jKhAmEpg7ilfPOBUVDBr1D+3RWI
	 yw/KrKIGR9gZAwtTTU/x5LkYQNHwQvPOUN9yAdy0PBKxEdIoijwNZdruXRTIetIn22
	 HC3dTBAXkKv1bvYHmJpSJxmTu9tjrPzzji0jHFg4OODKYphs8IoxbdTIG70uiviY9N
	 tIgPE/yvnFncYBf/l7N3C9OEi4k1weBotb3CqOFhvURINy8yFsTZ1dJykXuq9VeXJv
	 vuLwHfAMd5wjSW65e6JpK1q6NsJTqKB5yJnUgMsHBYHhjlB04IFxQVB/kZ3iNMidfu
	 AIzE9WkgbyxMQ==
Date: Fri, 15 May 2026 09:29:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Minghuan Lian <minghuan.lian@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	andrew+netdev@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: add NXP i.MX RT1180
 NETC switch
Message-ID: <20260515-encouraging-hopeful-spider-aee4ae@quoll>
References: <20260509090632.2959553-1-minghuan.lian@nxp.com>
 <20260509090632.2959553-2-minghuan.lian@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260509090632.2959553-2-minghuan.lian@nxp.com>

On Sat, May 09, 2026 at 06:06:29PM +0900, Minghuan Lian wrote:
> +allOf:
> +  # Base: always a DSA switch

I have no clue what you want to say here.

> +  - $ref: /schemas/net/dsa/dsa.yaml#
> +
> +  # If the SPI-specific compatible is used, allow SPI properties and require reg.
> +  - if:
> +      properties:
> +        compatible:
> +          type: array

??? What? From where did you get such syntax?

> +          contains:
> +            const: nxp,imxrt1180-netc-switch-spi
> +    then:
> +      $ref: /schemas/spi/spi-peripheral-props.yaml#
> +      required:
> +        - reg
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # SPI-attached switch representation (current integration)
> +      - items:
> +          - const: nxp,imxrt1180-netc-switch-spi
> +          - const: nxp,imxrt1180-netc-switch

Drop both. You have one compatible.

Please do not send us AI slop.

> +      # Transport-agnostic representation (future integration)

Drop comment. Get the binding reviewed internally in NXP.

> +      - const: nxp,imxrt1180-netc-switch
> +
> +  reg:
> +    description: |
> +      SPI chip select number (only for SPI-attached deployments).

Drop description.

> +    maxItems: 1
> +
> +required:
> +  - compatible

Best regards,
Krzysztof

