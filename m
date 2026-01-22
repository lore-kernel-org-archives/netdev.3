Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DC367F2D;
	Thu, 22 Jan 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100665; cv=none; b=dMNrBVXhLUUsb0jrfLEoSQOzVkSwnXmB9S5RGvh3WspNF9Obusb2JWb/c5uIXxGgtywvmBVtSM+JGQYFhV7IsTjVpzarW0BAbTrtihk1AoTb3hJRW2FrvnXNGW2YVu9emd2BDSB2M9RZVirIa9UBiI6t+7+GPlB4BnQ1nIkrnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100665; c=relaxed/simple;
	bh=/mtVAN0RP8289udhD8FKKzimHR1+8kf3y0daA0yHddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqBJ0VVC6zOBU9DfLNLbAvTk8m3xYn3AeZptCrhV6ROefo8TxIBZJsEIJ4YS9pGX5wZSoRm2AKz3SE3ff5FLlT7FpMwgf9qOPlBK6sgCUJJ8q/vvP+Mv0BUB942XuYE21jwJoK3Zf/BXzQ/+kGRW0j3zf62cPnrlByRjc+VtBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiIjjTqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiIjjTqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FA2C116C6;
	Thu, 22 Jan 2026 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769100663;
	bh=/mtVAN0RP8289udhD8FKKzimHR1+8kf3y0daA0yHddc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiIjjTqDgMnWLTZliMyOuLT+0NQqgDioGOcvDjmdYWKR4tPUnjHaLHOI+3+jvcQyk
	 83Gnz57GgeUYnmYtUoUruNOKwRrijZeShiumRaXz0J4CJ9hTruy8dDXzn464aOu8F3
	 Khb+/5PKske/lISXxpms5Z/kHqaHPxoRtK5o1Nin7CDE79IeqKUMuz7TlRbD3UHNK1
	 f/ap7r53UcnIt3OTZn72grzu0V5zwhcDMGuUr+o/4a0dhrtRfPGR+WK1usWc8em6Iz
	 TBF47e7k0HWU1InpeZcx22CLCsTjruJNz87y4VtgEZMzHUqnwv1MQinhHZBtjtDDcH
	 /+1yzQ9qsN/HA==
Date: Thu, 22 Jan 2026 10:51:02 -0600
From: Rob Herring <robh@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com
Subject: Re: [PATCH v2 3/4] dt-bindings: net: realtek,rtl82xx: add a property
 to set MDI polarity
Message-ID: <20260122165102.GA2564919-robh@kernel.org>
References: <20260121151506.813783-1-dam.dejean@gmail.com>
 <20260121151506.813783-3-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121151506.813783-3-dam.dejean@gmail.com>

On Wed, Jan 21, 2026 at 04:15:05PM +0100, Damien Dejean wrote:
> MDI pair polarity is usually configured by the bootloader.  However, on
> some designs the configuration is left untouched during boot and needs
> to be set by the driver.
> 
> Add the property 'realtek,mdi-cfg-polarity' to configure the polarity of
> each pair. Bit 0 to 3 configure the polarity or pairs A to D, if set to
> 1 the polarity is reversed for this pair.
> 
> Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index c4ced671ecb8..17088c147358 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -61,6 +61,13 @@ properties:
>      description:
>        Force normal (0) or reverse (1) order of MDI pairs.
>  
> +  realtek,mdi-cfg-polarity:
> +    description:
> +      A bitmap to describe pair polarity swap. Bit 0 to swap polarity of pair A,
> +      bit 1 to swap polarity of pair B, bit 2 to swap polarity of pair C and bit
> +      3 to swap polarity of pair D.
> +    $ref: /schemas/types.yaml#/definitions/uint32

maximum: 0xf

However, are these properties something that should be common?

Rob
