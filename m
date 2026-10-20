Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481250;
	b=5lBzRwlo/5bqkCSoIrJyyTHwRop2L+Ex2TsMgDnLH4Gu+eFTEPr6qPCPbfL0oXHYM9kH
	 mcXaVypwqvuiGP+oOX+dt48UOmmeHS4HixLnstRm7uMzdcWVUX8yqj8iF023JMJ3zD3Uj
	 hIVItyRqJjOIVW0KdGsxSQWmgg87jTjxg5zqpkjRT2/76FjzYrI/TO7NiEzst4DPrQbP2
	 PJFQ5xi1DdOo12aexwuRAWEqp3iu2swWN/3c65KCCot+cOjx1DBbUKxzEm5/5Shq2dEx5
	 5g9Z78yVLMP/dTbtqdZWokgf88BZUjL9LcUxcLZ0kUpufhfnJBaRH6Q1BhQIPBtDA9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481250;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Eb4pIl+p0P9P4pch0J7z+pBarnBhT5r7oyHUjiBjFUI=;
	b=d0ubA+c7zMkvBfeYnHE/mSqwSJL2wZ+j7EKD26YgmC+fe+Z8jgL/nexEjowsTH/F2lo8
	 oQAG9nLvLci61j1dlyrKWVxsh083c37EMmdwoW3MgCJbLZDM87RjSXf8B/YMuB1t9mpXN
	 cBmFMGjek3a8yEdNkP8G7sdnngVxkg/f8Pdwws/HUkujkEti9imeHqYGaHq61cDLnL243
	 9ue6ABTF5yBu0ESwZc+YJgUPcvzNwf420NZuv3lMh0d7VHdU4oEbUYjzk3uqg6PepTMN3
	 /JfHhCDJLdDn2CXUZ+R+Te4hIF1dOgnuBqL0OTv81Y+GrV2BWcM8wArflb23WYmNcLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1zx3Pqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D971606A325;
	Tue, 20 Oct 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1zx3Pqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9371F000C4;
	Tue, 20 Oct 2026 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792481250;
	bh=Eb4pIl+p0P9P4pch0J7z+pBarnBhT5r7oyHUjiBjFUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f1zx3Pqr3kynKf8YhnkwlNarW+yU7/7wR5eUdXXkX2bk4W3jPRHKbVIMFOSKzAiHO
	 XDutryKB1Skrm+dJ5TdSWJ2w+v3hnZzFRCWNviyUY5Bbqcw4yH1xKXpYE3lEU8tFgv
	 C3UR9LnDNleDzNMi3boSVLpcFmq2N3DJWnluKkv4K8hER5Dyhe7hFEjjgredAFKR3R
	 T7wFfkcJ2hGRbbsTnKihxJlWxBHU8FuZ8VSuNbDVzNbVY9hx9hcboGdfVtYo5ORYSl
	 c6xW1gyGpWEBuBRaHbCvaykPOzbXsR25pjDe+HX4eJcKY/PxhmkyKQAkyADdKckWI0
	 3mdx84bTPgIwA==
Date: Tue, 20 Oct 2026 09:27:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: realtek,pse: add
 gen1 I2C transport
Message-ID: <20261020-noisy-amorphous-jackal-1df08a@quoll>
References: <20261018161248.376205-1-sander@svanheule.net>
 <20261018161248.376205-2-sander@svanheule.net>
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
In-Reply-To: <20261018161248.376205-2-sander@svanheule.net>

On Sun, Oct 18, 2026 at 06:12:47PM +0200, Sander Vanheule wrote:
> Like the gen2 protocol, the gen1 protocol can also be used over both a
> raw I2C transport and an SMBUs transport. Add a compatible for the
> former and the compatible for the Ubiquiti Unifi Switch Lite 16 PoE
> device that uses it.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
> index 3bb32349c28c..526f8525bb4d 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
> @@ -54,6 +54,12 @@ properties:
>                - zyxel,gs1920-24hp-v2-pse
>            - const: realtek,pse-mcu-gen1-smbus
>  
> +      # I2C, raw framing
> +      - items:
> +          - enum:
> +              - ubnt,usw-lite-16-poe-pse
> +          - const: realtek,pse-mcu-gen1-i2c
> +
>        # UART
>        - items:
>            - enum:
> @@ -100,6 +106,7 @@ allOf:
>            contains:
>              enum:
>                - realtek,pse-mcu-gen1-smbus
> +              - realtek,pse-mcu-gen1-i2c

That's the same device as smbus, no? Same device, same compatible.

You can have property deciding about protocol, if this cannot be deduced
from the clients.

Best regards,
Krzysztof

