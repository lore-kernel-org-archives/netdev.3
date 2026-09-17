Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923D4E0B7C;
	Thu, 17 Sep 2026 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675734; cv=none; b=Il6xf5EDatCh8UiPickNtPrfrwL4eTO0foMICC4n+OLSBByDQp7e1GLgHXkOZZvR5KplMJO09lQRYkPG11NvZQmB/XdNTE52Ae6mb0F+2qIq+urRgNd4DPtRBRLadyRr0IXs/z6+p54nW6+ve7nvuYBHvBl0pjpOa0jOkIpcC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675734; c=relaxed/simple;
	bh=qYOJE4s2kWhxWrb64TRwtbCAJAHdkJoTRECfV0/jiko=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7rP/klY0TmuRkOea5MPBkq4+k3nMhgJTAffzG714LByuqZ16/73tDeZesvRoh62uGUG+3j9enVXvJUasq5SwhGi1N63tVY/CPiVS0bTGBOo/JR9tFCu9eLCmzQShxzvjYmGcw8mrcrf1U0BQGb/9wMZP3VYH9hVVEpx/saj2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T83V11sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T83V11sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5003E1F00893;
	Thu, 17 Sep 2026 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675732;
	bh=3Z7npSUBxJB/BJjAI31cc9k+ZFuPWuAIILvoigjaUTc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T83V11svz74rjKmbpLVwxMSHh6zn4/cG88aN18jJjoN/fars3H1oETG6WSzhWc0lx
	 faXp3RLWEeCHzyi8PDsi07uByTD7yB6s8er7e4oPK+G2Z6W0R03q9tFilVtMilHoqv
	 +QDuYTFsxDR3pP+PzlZN7MoaHIozF8XFTv5OySFMSlwNGW5smQg2FSEiVKir8wegLe
	 XsEPiZ/fYgwFtr+rMt6BXwgTTsPqZJFtEpl35oTHDPEQQuOuxobjkfUzc7xxd+XRS0
	 SzY4PksloYg6a25dvWkgmABNoJe71vepn6/56/coD63qR8SMk1f2tH0xoQ0Zjr31IG
	 +xAH/u2y1a4BA==
Subject: Re: [PATCH net-next v8 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:08:50 +0000
Message-ID: <178967573088.22033.12415855189978378014@kernel.org>
In-Reply-To: <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>
References: <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] The new `allOf` `if/then/else` conditional in
  Documentation/devicetree/bindings/net/wiznet,w5100.yaml encodes a…
- [Low] Concern (assessed as NOT valid): the binding documents an
  optional second (LINKLED) interrupt for wiznet,w5500 and the semantics…

--

dt-bindings: net: wiznet,w5100: add link status interrupt

This documents an optional second interrupt on the wiznet SPI ethernet
binding, sourced from the LINKLED pin, for reporting link status changes.
The interrupts property is turned into a conditional list that allows two
entries for wiznet,w5500 and keeps a single entry for the other compatibles.

No Link: tags present in the commit header.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 25098308eb6e5..da03f4e07f29a 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml

[ ... ]

> @@ -24,8 +20,11 @@ properties:
>        - wiznet,w5500
>  
>    interrupts:
> -    maxItems: 1
> -    description: Main interrupt (INT pin on the device).
> +    description:
> +      The main interrupt (INT pin) is mandatory on all devices. The w5500
> +      additionally supports an optional second interrupt for link status changes
> +      (LINKLED pin). If it is not specified, link state changes will not be
> +      reported.

[Severity: Low]
At this commit, drivers/net/ethernet/wiznet/w5100.c only consumes spi->irq
and does not report carrier state, so the sentence "If it is not specified,
link state changes will not be reported" describes behaviour that has no
consumer yet.

Checking the rest of the series, the driver side does land in the following
patch, where w5100_probe() picks up the second entry:

  priv->link_irq = ops->chip_id == W5500 ?
                   fwnode_irq_get(dev_fwnode(dev), 1) : -EINVAL;

and w5500_report_carrier_state() calls netif_carrier_on()/
netif_carrier_off().  So this looks fine as a binding-before-driver
ordering, and is only noted here for completeness.

>  
>    reg:
>      maxItems: 1
> @@ -42,6 +41,30 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +          description: Main interrupt (INT pin on the device).

[Severity: Low]
Is this else branch describing the hardware, or the current Linux driver?

The LINKLED output exists on the w5100 and w5200 packages as well, so a
board that routes w5100/w5200 LINKLED to a host GPIO cannot be described
here:

  compatible = "wiznet,w5200";
  interrupts = <25 IRQ_TYPE_LEVEL_LOW>, <24 IRQ_TYPE_EDGE_BOTH>;

The second entry is rejected by maxItems: 1 during dt_binding_check.

The only in-tree justification found for the w5500 restriction is the
driver gate added later in this series, in w5100_probe():

  priv->link_irq = ops->chip_id == W5500 ?
                   fwnode_irq_get(dev_fwnode(dev), 1) : -EINVAL;

which is a software limitation (register readback of link state via w5500
PHYCFGR) rather than absence of the pin.  Would it be preferable to allow
two interrupts for all three compatibles and note in the interrupts
description which parts can actually report link state, so this constraint
does not have to be relaxed later?

>  
>  unevaluatedProperties: false
>  
>  examples:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-wiznet-link-gpio-v8-0-d173622474cc%40marmottus.net
