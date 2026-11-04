Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788904;
	b=0ywKHS8S1NCMIx6S1ONq6H+jf93aNADBPetD0WcTR16OR827yCoTyuRUxa/jBoJHhcSf
	 sJg4ENY5XG81ctnvg3SiU7xF/eZoCx31vlQh+v4mWR7jSqJawVFBP8ub49n4uoKDLZZEl
	 Noo7CadRRR+Nfp5TyWbM9qCwIk7F17UcmQ252QZ7Wygb29BbH2Q7aVTFfpfP2aH1xkbZi
	 Bhj1yJbWNW2JPqSBTTHrw0Hq00e/9f6GPw8BTjRHBI7ecRnjt2eifnJMmi9k9FN7P3Ogs
	 DCCOTqD6OouzySzR5Rf8w4GSSkl0aVL8TAN4jpVk3dI0JqN0MMFFDRNLNLJYcdTJsjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=g/M5lTmWZ7ZLfEFYV6/3fxrG4+HGuIIbv/blTWR+kdI=;
	b=JNUKP8gs21nUqfQ4giswcfMER7zh/PRTnhyI3pkG35DrcDYT1I4Kz3xs52ropLOVK5T2
	 1tDF02qJwxwuyYETk2UtWVxrIuO3awCrBr+1eIVG2xF3eEZv1Yzw5L/Tyq+0QBbbMks/S
	 pxr1JM8PGjq0LikqyE0Vogzu19CmDm2b5t1wjLj1CkpR535Fp6bpA/0JKdcrpZsvPk05d
	 ZK7xnCVM6gY30uU8x+sRSkasANRreLqdFRo4jOIzGOvGm0F+jclFAA5iNPv4aTsRALRby
	 jrdzVBxOH1+uiwh33NT66eFLCGFLf90/yjoRlFuYjnQtnMvr8mYby6AUJNDetoxVdhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lN/JzBSS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE98606A31B;
	Wed,  4 Nov 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lN/JzBSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4084C1F000C1;
	Wed,  4 Nov 2026 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788903;
	bh=g/M5lTmWZ7ZLfEFYV6/3fxrG4+HGuIIbv/blTWR+kdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lN/JzBSSe6OsgtYBv24gjKdSML3Zm7sDoeZupAzIsmhc5fvTRjr1C65gCrzFAKLt+
	 wW55WL6Vb1+i1EFLVY1MQnhhGnRaK7z6Aq/IDQJRort4iDC/JXBZlxAQIUvMtbk1QO
	 SZB10ftHoeWXV/CHz78I1EBqkVXaquQ3FPIQlk35rlz7uBeT6GbrCZ8b+q9HRQ5REu
	 z0YiGZgd9K09E1v5ZE8d8bDhRWc9KT/zIgHT+cOekgIsZ72B4egbXbzuB6PaV3XPxl
	 o0MDbtwQF8lTzC5dVlvT6FY4wL8D2PBPlmRPL5dX3lHoK8ZvDHb/Je1MhJT5/0Puzv
	 +9ikraKroPphQ==
Date: Wed, 4 Nov 2026 11:41:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/7] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Message-ID: <20261104-prodigious-ara-of-research-05bf65@quoll>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-2-44057f4dde75@aspeedtech.com>
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
In-Reply-To: <20261104-support_ast2700-v5-2-44057f4dde75@aspeedtech.com>

On Wed, Nov 04, 2026 at 01:13:55PM +0800, Jacky Chou wrote:
> Add AST2700 to the FTGMAC100 compatible list and document that its
> RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line
> for AST2700 as it follows the same reset requirements as AST2600.
> 
> Require "phy-mode" to be present in the device tree when the AST2700
> compatible is used, matching the driver's probe-time requirement.
> 
> Add aspeed,ast2700-mac as a standalone compatible, consistent with
> the other Aspeed compatibles.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Your patch changed substantially, so dropping tag was appropriate.

> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index c870dd0bda7b..0a376b849a91 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -17,6 +17,7 @@ properties:
>            - aspeed,ast2400-mac
>            - aspeed,ast2500-mac
>            - aspeed,ast2600-mac
> +          - aspeed,ast2700-mac
>  
>    reg:
>      maxItems: 1
> @@ -28,7 +29,7 @@ properties:
>      minItems: 1
>      items:
>        - description: MAC IP clock
> -      - description: RMII RCLK gate for AST2500/2600
> +      - description: RMII RCLK gate for AST2500/2600/2700

So not valid for 2600?

>  
>    resets:
>      maxItems: 1
> @@ -80,12 +81,21 @@ allOf:
>            contains:
>              enum:
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>      then:
>        properties:
>          resets: true
>      else:
>        properties:
>          resets: false

Blank line here

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2700-mac
> +    then:
> +      required:
> +        - phy-mode

Please constrain clocks.

Best regards,
Krzysztof

