Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297918;
	b=gEEw3gZoOQCTpIsmW3+/G6RbuswXWLP3GoJ32mBrK78BD0176Sd2j2riE9owmHT47RJ4
	 jzHbClgD3+WNX6ai3MfkiXdTkhuKIATwMqDTM6N4nwWLhL5LXSoYptARMCCE83Kyabyl3
	 1TOSu2Xq2qYuAC/QcvwBJ0D6CX/MTApzlvm7Ar2TLbQmsxbx7pLJb+KTA1MgBay3Vu14E
	 kZWlebBJ+pBMIExXD6QmdhuheolElnVjVVrShZ6kJFargWwBEFw1IhM3wj4EMbDLJD4Mi
	 479lrZym1VhSL9myY2mKZL+c52SoPVlwkNaBiSLKLp4um1C/2Ae+2oqAi1UC7wW2y8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297918;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RRuKhO+Gqs/aresxXRqjjRtExNAeC2zZMKoz8mC2jhc=;
	b=eLhyQThlorswYWf9mpIfjux0mHawSDoNFnE48cmbdAnPrCZcFbXMcdvQy6lfJ7NYeXda
	 cD/fyZ58gdZU6WNqED7sKNk0EKC8ZRdPD71N7FipiAXcC6urAiDHgxBCLORI3zC9nrxqO
	 B337wzeEXVOweIfZYds7yp4Y0l5QSxqdvj7r81CuUvneFPMHzcwnl79R1R0Rm7U4+1XDp
	 KGnxzRu5GI9f4CAYFd7cuMaGefOEh4g9DlDkPvseYMc+Fl/Lbwc4uiFb8QLrIViz3KwK9
	 0mIGg5KRv7YD8YmRuSRLEJ3RiWo+rxGRLa5qvB3P1QNA8krr/+b2Rb2/87oO3e+21kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHtWTChy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4A606A31C;
	Tue, 10 Nov 2026 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHtWTChy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA851F0089F;
	Tue, 10 Nov 2026 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794297917;
	bh=RRuKhO+Gqs/aresxXRqjjRtExNAeC2zZMKoz8mC2jhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KHtWTChy3U8TCLPvKYF9zCxkxdw63IKUtrNdOTxtkGMP//+WsPGFNPYbaovW1wmg0
	 RMRm+v7qu7vDWTJx2oH09qkRpbc2VTAAhpLk23GxLnTBN5PJZ9YpX4Z8KcoIMfs+h9
	 /S4aabl+ovBcr5nFeu6nDmrj9eQffCXQRR747VjorcQECW8uyRVzs2TOzI79L+Yox5
	 9w65CfBWgo8kYZgrvbj9ni6QE4g6Ic2jT9QG7s/fEdYlB0tjnRlmWY23xz9df5m7RT
	 TgWFwuFw9RgkdmO/SRghSNj1PSlH41NjoGEJNXZqiaHdP65P+EoOiJpz3JeeHOJw08
	 +aSkqDYcVfyxg==
Date: Tue, 10 Nov 2026 09:05:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>, Ciprian Regus <ciprian.regus@analog.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] dt-bindings: net: adi,adin1110: Add
 adi,spi-oa-tc6
Message-ID: <20261110-stereotyped-tasteful-pelican-29046b@quoll>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
 <20261109085952.105331-7-iustin.stolniceanu@analog.com>
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
In-Reply-To: <20261109085952.105331-7-iustin.stolniceanu@analog.com>

On Mon, Nov 09, 2026 at 10:59:51AM +0200, Iustin Stolniceanu wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The ADIN1110 and ADIN2111 support two SPI host interface protocols:
> the generic SPI protocol and the OPEN Alliance TC6 protocol. The
> protocol is selected by the state of the SPI_CFG1 pin, which the device
> latches when it comes out of reset, together with SPI_CFG0, which
> selects CRC (generic SPI) or protection (OPEN Alliance) mode.
> 
> The protocol is set by the board hardware, so the driver must know it
> in advance. Add a boolean property to describe a device configured for
> the OPEN Alliance TC6 protocol. Without it, the generic SPI protocol is
> assumed, as before.
> 
> adi,spi-crc enables the CRC of the generic SPI protocol, so it is not
> allowed together with adi,spi-oa-tc6. The OPEN Alliance protection mode
> needs no property, as the driver reads it from the PROTE bit in CONFIG0.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> ---
>  .../devicetree/bindings/net/adi,adin1110.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> index 0a73e01d7f97..fa30787c663d 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> @@ -28,6 +28,12 @@ description: |
>  allOf:
>    - $ref: ethernet-controller.yaml#
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      required:
> +        - adi,spi-oa-tc6
> +    then:
> +      properties:
> +        adi,spi-crc: false

Please move the entire allOf to the bottom, after "required:" block.

>  
>  properties:
>    compatible:
> @@ -43,6 +49,12 @@ properties:
>        Enable CRC8 checks on SPI read/writes.
>      type: boolean
>  
> +  adi,spi-oa-tc6:
> +    description: |

Do not need '|' unless you need to preserve formatting.

Best regards,
Krzysztof

