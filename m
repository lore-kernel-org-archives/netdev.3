Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC549A3D5;
	Mon, 28 Sep 2026 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590999; cv=none; b=O9aB/xqFsFRSYaIbqklUYNA6aVJdDjjhr9s+6ulRIami9xAb9lUatpntP13HRnzs5ea90z4DfxgJPTw0QQExq//cT+yGHwJ8HvMPKygSE4K/SHdb1RbrVJxsOANFtjLeITUtI+bpykTyfOUtpKi3Z3vaeGb6uT1gpDnyhq1j844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590999; c=relaxed/simple;
	bh=UZO47OsT20TKAJNwVQzE/1MTz01gvOI+H5zZ3roCSV4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtowxiPB3CWcVfxLSJTfYK33dYeVWK8d4gRC4XAO3eNj3a+09aX7DvBO2bZThSTwWWnVrxelD+kNmHiJcWxZ8S3h2GVbWGhcdkJixX/CkoSLBbfErv3edIexwkfAotrdg/+kq8922UFYaKKp42iTL2eM/1mjM9vaJ8EORxlhjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enqkD+0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enqkD+0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8341F00898;
	Mon, 28 Sep 2026 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590998;
	bh=vrjcMuRTBtOPqSRHa0SJ5F35IEage9YEMAc3K4h7vsk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=enqkD+0O/LcHQDvZ9clkemagE6hWguQ1m7HJS0kKz+PP4Caf/0n/ybU2V02XxdDAE
	 Ect5v1ZSfIHbBI1uuU8xxELx7SYTU/CgpBLHNpUD30PcQns7q/7mnaTLyF0lAoM7kV
	 yVuG28XgsmkAIVEKR2cvb2ZfOzz3K6zMw/KLwodRPVg0awaT7yhwlWXadLSc5uFwYq
	 qgYbeccfDbhZwzzO0qJhVUCFKCCDeN3hfM1lUG7M+t20/9Bbr9dSJzBUjp8FKXC0Ft
	 yIbUifhy7U0MsL9nQUdd13A21eLPDak5mb69TnAmXj5EuS/52CGLiYpflGpTKiQ1Pq
	 f1GSffhoesuNA==
Subject: Re: [PATCH net-next v11 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 10:23:17 +0000
Message-ID: <179059099703.3145.14706585546923275926@kernel.org>
In-Reply-To: <20260924-wiznet-link-gpio-v11-2-42a332517b30@marmottus.net>
References: <20260924-wiznet-link-gpio-v11-2-42a332517b30@marmottus.net>
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

- [Low] The new allOf conditional in
  Documentation/devicetree/bindings/net/wiznet,w5100.yaml (`if: not:…

--

dt-bindings: net: wiznet,w5100: add link status interrupt

This patch adds an optional second interrupt to the wiznet,w5100 binding.
The second interrupt is meant to be wired to the LINKLED pin so link
status changes can be detected. A new allOf conditional limits every
compatible except wiznet,w5500 to a single interrupt.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index df83f90b3919..b0d1e1d699dc 100644
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

[ ... ]

> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - wiznet,w5500
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1

[Severity: Low]
Is this restriction based on a hardware difference, or does it follow the
driver implementation?

As far as I can tell, the w5200 (and the w5100) also have a LINKLED
output. The w5200 also has a readable link bit in PHYSTATUS, so the same
"LINKLED edge, then read the link register" approach looks like it would
work there too. I haven't been able to confirm this against the
datasheets, so please correct me if that's wrong.

In the follow-up driver patch, w5100_probe() only reads the second
interrupt on the W5500:

drivers/net/ethernet/wiznet/w5100.c:w5100_probe() {
    ...
	if (ops->chip_id == W5500) {
		priv->link_irq = fwnode_irq_get(dev_fwnode(dev), 1);
    ...
}

The older link_gpio / w5100_detect_link() logic that commit dacf281771a9
("w5100: remove unused gpio link detection") removed was not tied to a
particular chip, so link status wiring was not limited to the w5500
before.

With this patch, a w5200 board that routes LINKLED to a SoC interrupt
line would fail dtbs_check with "too many items". The w5100 seems to
have no link-status register, so the case is weaker there, but the w5200
case still seems to apply.

The commit message only says:

  "This second interrupt is only supported on wiznet,w5500."

The item description says "LINKLED pin on w5500". Could the commit
message name the hardware reason, or could the conditional be relaxed
to cover the w5200?

A smaller point: because the conditional uses "not: contains:", any
WIZnet compatible added later will also get maxItems: 1 by default.

> +
>  unevaluatedProperties: false
>  
>  examples:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-wiznet-link-gpio-v11-0-42a332517b30%40marmottus.net
