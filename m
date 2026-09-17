Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF04E3769;
	Thu, 17 Sep 2026 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675733; cv=none; b=brfWTq3hhacHTtdnpEsQ7cDoq6fq3o1G7wWf32G/vTItXSL2YvmFhXXWed5cMo+/PqV07SdhYBO52B0Zfh2r+iTiOOYoTfH5Oqs8Kd5rEHjjf42c8PFECRnOHuRy1x4+0BJBKElkDbsJnJb0r1Fptj/eAWcRgzNiJ+nVfE6V8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675733; c=relaxed/simple;
	bh=IIsV1U6PauBbsTaBCTwAkycnPPPdpJTtWKCHAFfVjgE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kY1pjApaWSfZVYU4Nh9xnIejvMJnKFGEnUn6NSIFDuakgNJw7H4NqqDBEP//HPlH9QYOS6I3zGkX9H7N9V9fHNJXBBFZj7dB+9WYep+zTYVfY+jxEJiDuBfq4SSMai6S2mj6pdsMhKEKQVcaSkFuY1tNUw6T96eN1hOxZlnqRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaVmBZBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaVmBZBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A981F000FF;
	Thu, 17 Sep 2026 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675730;
	bh=//NLXZkiBLVTK0DM7831/W9LL24+RBN8sB0Du64xfc0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GaVmBZBGjJ6FI1R6xrcYjVGvZXVd9APwwC2nYYtwun/LD/RMYMsg8H95cwR7YdHkm
	 RXiSQ1gkGqkml/gNox2tTvKMiiKVoc2PdVk/Q0DRuZx7duF9Fb1GlzdcMKIobtGnRF
	 C4E3tfb17gK9INpV2oRI41u9p7hHsCWaOJs8z6aWgRQZNmqarx4i7NXxoEyAExcW9n
	 IECpo7IzFln+vkvJMualU7Ds96uDEvJQb2UyFQoU7cuM199Pn28omAhU7wRQKz3/9l
	 zSEchSLkiIevUlqTQh9AjfTWXDXIT8SHF/Cob9ZhCrgAunzAaCs6tkyHjhXHQ+5wPe
	 gA271o8fM4dLA==
Subject: Re: [PATCH net-next v8 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:08:49 +0000
Message-ID: <178967572953.22033.7825853149442957564@kernel.org>
In-Reply-To: <20260915-wiznet-link-gpio-v8-1-d173622474cc@marmottus.net>
References: <20260915-wiznet-link-gpio-v8-1-d173622474cc@marmottus.net>
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

- [Low] In Documentation/devicetree/bindings/net/wiznet,w5100.yaml the
  new schema applies one global `spi-max-frequency: maximum: 80000000`…
- [Low] This patch is not a pure format conversion: the removed
  Documentation/devicetree/bindings/net/wiznet,w5x00.txt explicitly…

--

dt-bindings: net: wiznet,w5100: convert to DT schema

This converts the Wiznet w5x00 SPI Ethernet controller binding from plain
text to a YAML schema covering wiznet,w5100, wiznet,w5200 and wiznet,w5500,
and adds a MAINTAINERS entry for the new file.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> new file mode 100644
> index 0000000000000..25098308eb6e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -0,0 +1,68 @@

[ ... ]

> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - wiznet,w5100
> +      - wiznet,w5200
> +      - wiznet,w5500
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Main interrupt (INT pin on the device).
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description:
> +      According to the datasheets, w5500 and w5200 allow a maximum of 80 MHz
> +      while w5100 is reported by users to allow a maximum of 14 MHz. However,
> +      board designs may need to limit this value.
> +    maximum: 80000000

[Severity: Low]
The description says the 14 MHz limit applies only to w5100 while 80 MHz
applies to w5200/w5500, but the single maximum: 80000000 is applied to all
three compatibles.  Should the w5100 limit be expressed as a conditional so
dt_binding_check can enforce it?

With this schema as written, a node like:

    ethernet@0 {
        compatible = "wiznet,w5100";
        reg = <0>;
        spi-max-frequency = <80000000>;
        ...
    };

passes validation even though it is roughly 5.7x the documented w5100
ceiling.  Would something like this in the allOf block match the intent of
the description?

    allOf:
      - if:
          properties:
            compatible:
              contains:
                const: wiznet,w5100
        then:
          properties:
            spi-max-frequency:
              maximum: 14000000

Per-compatible spi-max-frequency constraints are already expressed this way
in other net bindings, for example
Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml and
Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml.

The same unconditional maximum: 80000000 is still present at the end of the
series (commit ebaf57af, "w5100: detect carrier state using link status bit
and optional interrupt"), so no later patch adjusts this.

[ ... ]

> +        ethernet@0 {
> +            compatible = "wiznet,w5500";
> +            reg = <0>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&eth1_pins>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_LEVEL_LOW>;

[Severity: Low]
This changes the recommended trigger type from IRQ_TYPE_EDGE_FALLING in the
removed .txt binding to IRQ_TYPE_LEVEL_LOW, and the deleted text also
claimed "w5x00 natively generates falling edge interrupts".  Could the
commit message mention this correction?

The new value agrees with the driver, which requests the device interrupt
level-low in w5100_probe():

    err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
                               IRQF_TRIGGER_LOW | IRQF_ONESHOT,
                               netdev_name(ndev), ndev);

The commit message body only says the binding is converted from plain text
to DT schema.  The only record of the trigger change is the v8 changelog
line "Change edge-falling to level-low" below the --- separator, which git
does not keep.

Would a Fixes: 0114214eca21 ("dt-bindings: net: wiznet: add w5x00 support")
tag be appropriate here as well?

> +            spi-max-frequency = <30000000>;
> +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> +        };
> +    };
> +...

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> deleted file mode 100644
> index e9665798c4be6..0000000000000
> --- a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@

[ ... ]

> -- interrupts: Specify the interrupt index within the interrupt controller (referred
> -              to above in interrupt-parent) and interrupt type. w5x00 natively
> -              generates falling edge interrupts, however, additional board logic
> -              might invert the signal.

[ ... ]

> -		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-wiznet-link-gpio-v8-0-d173622474cc%40marmottus.net
