Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BA377019;
	Fri, 14 Aug 2026 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691850; cv=none; b=qGno8VP1BD7QUzlhqwoyfc65k1oGYLLe/FXQZ3kvzGiMrPKcctFQL7XmwDFVg4U5XBOhNlS0GVmFy1/1vbRtYFjK/OoBr4RbtoOEI2nFK1ekYrUcmrdLlbiPwLG0VCowaHnzjPVn2hgBooLD11LBS0zo6KwhjYW7XGZ9pre7QcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691850; c=relaxed/simple;
	bh=j24KVkyB0q0OaJ/yOFCb3wfuFrfDxqNqg1xYunq2vqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zplk0dRgDrk7jhwu7B1cP5vbq8nqaUzATEtrGEEuT4yp72+Cj6Vz494ChcOD9GvxHoFJU22S4dOZ0EqacLI6MxBnIqsYDeqRsSiwyTjEOp8PMgfFEoxyVJQIVJWvbokRTt/sbyVmE800uSfmpnrLePMnH5ltrIldCPUXnnXxYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EblVmG2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EblVmG2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7F1F000E9;
	Fri, 14 Aug 2026 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691848;
	bh=ls4Coej5vHvo87jU/0JKjM0skjKUPAZb4e9xNYa6dSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EblVmG2pbfiwzzs4V5mAU4ufoI4CBl7xvj9GW3d9Ig2iw6CdPAY/DhDytQYY/VEgO
	 dpQH4Z2Jj2qP7IM5cwc2RlpmTimxubJV3tZ0GnVe1JCSj37WZgdqOr1BIiaLAaJDgj
	 f50pXBnbRAKvIqOkuf+Xx2k6Lcu1VOHCn3fMcfdZRLcUN49X01JzE7SDoXrjNTYfPb
	 Nw/avFbNxM5q4Oen14SO9iR0O9TyAYCUI2a5hFRoFckI61A6IpPlcOcEncL42lWjqI
	 RtxTPaPq8CimailDt1J1hmIAfyyoRsB3S5QJHhb6UaqDC4TEKSHLXKp67dy/u4hSEP
	 2HWHKM8g/sd+Q==
Date: Fri, 14 Aug 2026 09:17:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arthur Crepin Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260814-loris-of-rampant-fragrance-bd2bf7@quoll>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
 <20260813-wiznet-link-gpio-v5-2-ac8046f24413@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813-wiznet-link-gpio-v5-2-ac8046f24413@marmottus.net>

On Thu, Aug 13, 2026 at 10:58:15AM +0200, Arthur Crepin Leblond wrote:
> Add an optional link status interrupt which can be connected to the
> LINKLED pin on the device to detect link status changes.
> 
> Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
> ---
>  .../devicetree/bindings/net/wiznet,w5100.yaml      | 34 ++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 217f301db182..81f4382eb96c 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -15,6 +15,33 @@ description: |
>  allOf:
>    - $ref: /schemas/net/ethernet-controller.yaml#
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - wiznet,w5500
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          items:
> +            - description: Main interrupt (INT pin on the device).
> +            - description:
> +                Optional interrupt for link status changes (LINKLED pin on
> +                w5500).
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - wiznet,w5100
> +              - wiznet,w5200
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Main interrupt (INT pin on the device).

allOf goes under required: block.

>  
>  properties:
>    compatible:
> @@ -23,10 +50,6 @@ properties:
>        - wiznet,w5200
>        - wiznet,w5500
>  
> -  interrupts:
> -    items:
> -      - description: Main interrupt (INT pin on the device).
> -

Properties are always defined in top-level

I do not understand why you made such changes. I did not ask for them.
Read again WHERE exactly my comment appears.

Best regards,
Krzysztof

