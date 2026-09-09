Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3A5592F5;
	Wed,  9 Sep 2026 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957542; cv=none; b=YkCZy5cZ17/P1shMHRafbMwPWn+u8qWpguLSZC4x4OP3WZfLyrFrGF+VzLK5ZztMzhNfnBtxZDysBv7Ti68b/U7/YSmK6vPxgpSPrIIoO9I4rXIiD0fqF5rzW+ilP4f8I+GHaP+h/emjfTUxxMZqb1OryvHK95f3+1BnhVzJSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957542; c=relaxed/simple;
	bh=N8e0mHtfrLhJTzcSZsXBav63lynCCymY+XwiF4qZeBg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7zRRJwB29hhjXxx2RiD9/3Kw4zdSYkf46yGtIflQjPn3tOOvExASq+lR0OL4Ho15NX91qXfCyG8V3xIK9hNY42wDIKfCJDoDlPJuqnqzAcHCaaQ0xkesZIWZZCvOfx7Y7SktaLz8ufBU59pM6IKKItfIAqQ2RTQsAy9enTsgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFC9EwKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFC9EwKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0688E1F00A3A;
	Wed,  9 Sep 2026 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957539;
	bh=joLSSrsFmb2lcxW3W5OuNn3CdYAbfbENeKzl8u5hbCE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aFC9EwKdNv5cb72gC40/YaNlY/izlEbVukgbEOEeTcTUNvhDXYKsJEldTPnmQWYd0
	 cTg8VBwN0d1nSCEzy1Hw1n7mTsC0QpsT37E1sgpCgiFLV8TsPdqLFQEr3H6yXII4jK
	 A6qGh+azHHi5n1SIMhsAOWaIPH0RlOdp0pd6ZzlN+VKtrzRnfmY3HxC1umWgNT8kAI
	 g6l1luOpyTDgxa/yORWqReDIUbnsuU1LOaBQyeyxlTLyoViKXDO3U+zMBwoQ8ZdVlt
	 cuRPxupByWMXc8pjmhe5xbjBnphtC4894dHsanAE1cf3G18xrJHdoREXoFzz/OUDTI
	 d3sHPcz+bvFIg==
Subject: Re: [PATCH net-next v7 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com
Date: Wed, 09 Sep 2026 12:38:58 +0000
Message-ID: <178895753846.219967.8860843467900146377@kernel.org>
In-Reply-To: <20260904-wiznet-link-gpio-v7-1-69f01b70c96f@marmottus.net>
References: <20260904-wiznet-link-gpio-v7-1-69f01b70c96f@marmottus.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] In the newly added
  Documentation/devicetree/bindings/net/wiznet,w5100.yaml, `spi-max-…

Pre-existing issues:
- [Low] Documentation/devicetree/bindings/net/wiznet,w5100.yaml (added by
  this patch) constrains `interrupts` only with a count (`maxItems: 1`…

--

dt-bindings: net: wiznet,w5100: convert to DT schema

This converts the Wiznet w5x00 SPI Ethernet controller binding from plain
text to a YAML schema, adding the file wiznet,w5100.yaml and deleting
wiznet,w5x00.txt.  The new schema enumerates the three compatibles,
constrains reg/interrupts/spi-max-frequency, and carries over the
Raspberry Pi example.

A couple of questions below about the interrupt and spi-max-frequency
descriptions.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> new file mode 100644
> index 0000000000000..601d828bae927
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -0,0 +1,66 @@

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - wiznet,w5100
> +      - wiznet,w5200
> +      - wiznet,w5500
> +
> +  interrupts:
> +    maxItems: 1

[Severity: Low]
This isn't an issue introduced by this patch, but the interrupt polarity
disagreement between the binding and the driver is now the only in-tree
record of it, and the wording that described it is being dropped here.

The deleted wiznet,w5x00.txt said:

  w5x00 natively generates falling edge interrupts, however, additional
  board logic might invert the signal.

The new schema has no description and no type constraint under
interrupts, so that information disappears from the tree.

Meanwhile w5100_probe() in drivers/net/ethernet/wiznet/w5100.c hardcodes a
level-low trigger in both registration paths:

	err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
				   netdev_name(ndev), ndev);
	} else {
		err = request_irq(priv->irq, w5100_interrupt,
				  IRQF_TRIGGER_LOW, netdev_name(ndev), ndev);

and __setup_irq() in kernel/irq/manage.c applies the driver flags over
whatever the DT node asked for:

		if (new->flags & IRQF_TRIGGER_MASK) {
			ret = __irq_set_trigger(desc,
						new->flags & IRQF_TRIGGER_MASK);

So no interrupts are lost, but the type in a node copied from the example
is never the one the line is programmed with, and request_irq() fails
outright on an irqchip that cannot do level triggering.

Would it make sense to either describe/constrain the type as level-low in
the schema, or have the driver pass IRQF_TRIGGER_NONE and honour the DT
type?

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description:
> +      According to the w5500 datasheet, the chip allows a maximum of 80 MHz,
> +      however, board designs may need to limit this value.
> +    maximum: 80000000

[Severity: Low]
Should this ceiling be per-compatible?  The description scopes the 80 MHz
figure to the w5500 only ("According to the w5500 datasheet"), and the
deleted .txt scoped it the same way ("when accessing the w5500"), but the
constraint sits in the shared properties block so wiznet,w5100 and
wiznet,w5200 inherit it too.

The older parts have lower SCLK limits, so a node like:

    ethernet@0 {
        compatible = "wiznet,w5100";
        spi-max-frequency = <80000000>;
        ...
    };

passes make dt_binding_check with no diagnostic, and w5100-spi.c then
clocks the bus at that rate.

Other net SPI bindings in the same directory express this per variant
inside a compatible conditional, for example the spi-max-frequency block
in Documentation/devicetree/bindings/net/qca,qca7000.yaml:

        spi-max-frequency:
          default: 8000000
          maximum: 16000000
          minimum: 1000000

Would an allOf/if:properties:compatible:contains: block per part be
better here, or a description explaining why 80 MHz is safe for all
three?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:

[ ... ]

> +        ethernet@0 {
> +            compatible = "wiznet,w5500";
> +            reg = <0>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&eth1_pins>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;

[Severity: Low]
This is the same pre-existing mismatch noted above and not something this
patch introduces; the edge-falling type was in the old .txt example
verbatim.  Since this example is now the only surviving statement of the
expected trigger type, is IRQ_TYPE_LEVEL_LOW the value to show, given
w5100_probe() requests IRQF_TRIGGER_LOW?

Nothing in-tree uses these compatibles today (a grep for wiznet,w5 matches
only the binding and w5100-spi.c), so no shipped board DT is affected
either way.

> +            spi-max-frequency = <30000000>;
> +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> +        };
> +    };
> +...

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-wiznet-link-gpio-v7-0-69f01b70c96f%40marmottus.net
