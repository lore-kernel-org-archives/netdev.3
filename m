Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364F31578E;
	Thu, 24 Sep 2026 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214957; cv=none; b=hOXIZVWgX6gY8WHnj8Gnv0QDRGgsnDfZUGdhdqmz37yO3/9ws5JTR39SRzKwVGlRaeo2gG4mM9VEgBvvXz1c2PbY6NuDLFZdLi7CpBlSIqn2wuJ3rgbDB3ZqqEphBjsfr4XPzN9xFotlaR8W63ba6rFIXSGyMBRz1T3yCxzmRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214957; c=relaxed/simple;
	bh=CwZ8HnW/9wixYdjE48vWBXx3+TyO7QtDYR+jyvO/eXc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtZxIEMn5+PSfZtJvP3uiUTUmZEbO47uLgXbNPSMRKpm1o2BNxxtrIRU7n39zclml0nCROsjQ1BS6z+LnBRj8oBcsaY78HRuBRisFYWHUhGd26EkusNzNFhDwdEgYqa7cQcXmt63T22W2rhwvLZ04P0Yu7p66dL4s9ARjDMxuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv029Vco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv029Vco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144351F00893;
	Thu, 24 Sep 2026 01:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214955;
	bh=42deq51se4mPqSGsEVff7TDuI9Gg5XuZIiqD6oV/avI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iv029VcoR4323Q73kJN+h35mOaq0a2Aiv23MJYCUaXAD7WJt3ioe3Yug+iaTvHa97
	 4Lb8ykVO4VnnOuQDcSUzqk3POyWo6ntrr9ghzrLk3/vbbRGUXshelBgO4BslEIX6OZ
	 zbk5u3jLa216ncxY1PDhjx+G9y8LN7+r/gMPO2iSpYO5DSJJRhvL4yupZsRIP/T6iy
	 w9CD963z9pDvUvv1UzV401PaWnyNSx1H2dYg/ERHMB/7OFJN6LRWn8Pe7N//aUGw9N
	 7Zv4ApLlaZ7AUy/X2OE4u9nkv3nr8NSxSf1xw3XpBV/xCHlJONy9H+uShUHYJP7hL1
	 O9iGQBnpNGc9w==
Subject: Re: [PATCH net-next v10 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 01:55:54 +0000
Message-ID: <179021495463.2160803.46310334870833128@kernel.org>
In-Reply-To: <20260921-wiznet-link-gpio-v10-2-5874a7a147a2@marmottus.net>
References: <20260921-wiznet-link-gpio-v10-2-5874a7a147a2@marmottus.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern (INVALIDATED by later patch in this series): the binding
  documents an optional second, LINKLED interrupt for wiznet,w5500 and…

--

dt-bindings: net: wiznet,w5100: add link status interrupt

This adds an optional second interrupt to the wiznet,w5100 binding for the
LINKLED pin, described as being supported only on wiznet,w5500.  The
interrupts property is moved to a two-item list with an allOf conditional
restricting non-w5500 compatibles to a single interrupt, and the example is
updated to list both interrupts.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 25098308eb6e5..ac2ee725af5d5 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml

[ ... ]

> @@ -24,8 +20,16 @@ properties:
>        - wiznet,w5500
>  
>    interrupts:
> -    maxItems: 1
> -    description: Main interrupt (INT pin on the device).
> +    minItems: 1
> +    description:
> +      The main interrupt (INT pin) is mandatory on all devices. The w5500
> +      additionally supports an optional second interrupt for link status changes
> +      (LINKLED pin). If it is not specified, link state changes will not be
> +      reported.
> +    items:
> +      - description: Main interrupt (INT pin on the device).
> +      - description:
> +          Optional interrupt for link status changes (LINKLED pin on w5500).

[Severity: Low]
At this point in the series, is there anything that consumes the second
interrupt?  The description promises that link state changes are reported
when the LINKLED interrupt is present, but w5100_probe() in
drivers/net/ethernet/wiznet/w5100.c only uses spi->irq (interrupt index 0)
and there is no netif_carrier_on() call in the driver yet.

For the record, this resolves later in the same series: the final patch
("w5100: detect carrier state using link status bit and optional
interrupt") adds

	priv->link_irq = -EINVAL;
	if (ops->chip_id == W5500) {
		priv->link_irq = fwnode_irq_get(dev_fwnode(dev), 1);

and w5500_report_carrier_state() which calls
netif_carrier_on()/netif_carrier_off().  So the documentation and the
implementation only disagree between this patch and that one, which is
nothing more than a transient bisect-window mismatch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-wiznet-link-gpio-v10-0-5874a7a147a2%40marmottus.net
