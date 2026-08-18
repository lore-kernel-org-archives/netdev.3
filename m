Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907A401A06;
	Tue, 18 Aug 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039445; cv=none; b=mlXRlV+Mu5jf4Sww9ErL0bOi2E/QSpY4XR4TK7D3DfZ1/nzl4zFieyJJtL6H4HxKx7BfBq2couiElDbeA7BqEiOCNF4lSQfeeUxQ6OkorllBBJh43eZn+ZNrqm4La2bqUeqCdMnoRYRNHWPbZS61PtGZRCNq9+ZHTbdSw/cXCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039445; c=relaxed/simple;
	bh=Tk7+mA/LObxk1eqqkH8r7Z2nbkar5sRTutyaDk623pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvow3wAj5KJjJ+2s4uSlRpc6yLCI0658SaOJuIY1W5tdP7y9rfv7DrpMvd2eVnsJyqS8jW3XPMbBNTWMQ3xLB4em0As3R03CHyvk6lq9Jj24DBY+ZO11oQg8ONMr93iG4hsrQphZ75IfD9wQn1wHEDKvwAZfvYTsSdjsPHtvZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JouN23T9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JouN23T9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBB81F000E9;
	Tue, 18 Aug 2026 07:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787039444;
	bh=x7u1BSkyIVC26XYovMuaIID4kfdAVP7TOBnqBXgS3kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JouN23T9gqbL0MvqLpJB/NwTOD5eZAluJEemTMRT5mAsIJfIuwc+iNDTkven89hDb
	 t+AvphYGl3JgvWznEyAR3H0mmChPPA4kSTzeFjsLvDZ2I+UxHm5AbHqCSaItvUUkrj
	 Amlif6AjzawOhD0gXLpdrDQaIgXtnqVPPRF/T9kYHMSl0gMG8RPH+sCCXasfuNwOBD
	 xZEcarVjx1OhOYtJCJdVEZqv+FVvPGq86hZyzilVP6VAQG4l9APTAh7QHf8EXC0RqR
	 p3I2JY5tbO6JH+GzPkFqdBLpBNo8Od3Lq+AB5YaXwYhQlETRndCOl/5MDXDvRP94tK
	 Dcp9271P/e9QA==
Date: Tue, 18 Aug 2026 09:50:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: realtek: add
 RTL8365MB power supplies
Message-ID: <20260818-accurate-crouching-elk-2964db@quoll>
References: <20260811113901.3114169-1-o.rempel@pengutronix.de>
 <20260811113901.3114169-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811113901.3114169-2-o.rempel@pengutronix.de>

On Tue, Aug 11, 2026 at 01:39:00PM +0200, Oleksij Rempel wrote:
> Document the RTL8365MB power rails as optional supplies. They are optional
> because the rails are often always-on; some designs break them out for
> granular hwmon monitoring and regulator control.
> 
> They are scoped to realtek,rtl8365mb: different Realtek switch families use
> different power-rail naming schemes, so these rails do not apply to other
> families such as realtek,rtl8366rb (VDDA/VDD_CORE/VDDIO/...).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/dsa/realtek.yaml  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index 473facd87a62..98ea6072bd96 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -8,6 +8,30 @@ title: Realtek switches for unmanaged switches
>  
>  allOf:
>    - $ref: dsa.yaml#/$defs/ethernet-ports
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: realtek,rtl8365mb
> +    then:
> +      properties:
> +        avddh-supply:
> +          description: AVDDH high-voltage analog supply.

Properties cannot be defined in if: block. Only in top-level. You only
customize them, see also writing bindings and writing schema.

Best regards,
Krzysztof

