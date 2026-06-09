Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84783285CB4;
	Tue,  9 Jun 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988522; cv=none; b=Oy+NHBcFZ7nSXHTuguArbwDWGqWLiH/mjgSJSi01KMs7njQQhsyuWoMO5ZWu/O3zZVpx2Ji4WztuI5hHkDkXL/6N947nmDcBvA21spE74ptQGErSYOKs4XJFoF2JLYvVlLREutkkt0MUdH/tDQVnHb3Q+cpiqmxcN+AkNe2B9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988522; c=relaxed/simple;
	bh=sGrD8apF8zbd+Xe6zc/cVyvP4Je1tvaycGIDTxOQiZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3U84gFlSCqKDsiXvGu/4dw9T2GYQ2CcxuRvPW23oOMiQ6wXntAoUG+prXE238/BBo8jDiJhTVsn/VITuqlB7HBK7SknVraf1H3G7tBU30bmltlB77RN8x+y6t0Qjvgfa6ubP0J92AnTCzsLq3QESrNxWbQXI/kujadbADvc9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok8H2Uhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok8H2Uhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9FD1F00893;
	Tue,  9 Jun 2026 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780988521;
	bh=w8bDKcwVaX/FMt0OtVmkeX4l8pXwbVj2zdV9SyYC/8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ok8H2Uhg8CJbOr4dGUd3LFIcRuZt5C+EPLU7vn0At86xhJpkopRyppET+vkr5G6up
	 chdc2y+xZoXc+2RTiDJ3R8HccQtrHN7qxn5ssV2BDu/UjmHBHDo2dlo3Zz4K+LAqRr
	 bXi0j5vgwx6fSGAEemS9XqDe8xQVP8H19HDkFZ2hVH4kVLs2K+c4O8tBlRX9H75sPR
	 CoXujuGxv/Z7FnYjfD58cKwYC07LwO+bMJXJybAh/j6kvvZFeufcOxSTuwecKZulap
	 /jVyKkhZwoRrdTuKCiQnVJ3CgDuCmk269IN4ZZ3E1Mm58NYeyGjcYhvteCWmu0rwma
	 FkNYjgpOHmqfw==
Date: Tue, 9 Jun 2026 09:01:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <20260609-scrupulous-cinnamon-grebe-d1c0a4@quoll>
References: <20260608192948.289745-1-joey@tinyisr.com>
 <20260608192948.289745-2-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608192948.289745-2-joey@tinyisr.com>

On Mon, Jun 08, 2026 at 10:29:45PM +0300, Joris Vaisvila wrote:
> +description:
> +  The MT7628 SoC's built-in Ethernet Switch has five user ports and one
> +  internally connected CPU port. The user ports are all connected to the SoC's
> +  integrated Fast Ethernet PHYs. The switch registers are directly mapped in
> +  the SoC's memory.
> +
> +unevaluatedProperties: false

This goes after "required:" block.

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
> +
> +  resets:
> +    items:
> +      - description: internal switch block reset
> +      - description: internal phy package reset
> +
> +  reset-names:
> +    items:
> +      - const: esw
> +      - const: ephy
> +
> +required:
> +  - compatible
> +  - reg
> +  - resets
> +  - reset-names
> +  - ethernet-ports
> +
> +examples:
> +  - |
> +    switch@10110000 {
> +        compatible = "mediatek,mt7628-esw";
> +

Drop blank line

With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

