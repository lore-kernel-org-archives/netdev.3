Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902362472AE;
	Thu,  3 Sep 2026 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396965; cv=none; b=OgK2OSnnh1r39wo3Sr/5Q4K5eQub12LgP6ENqRLAIYj2nTU4OY1pFmz1hA7W+BuSEHtkzmbl8UGdJ/eM3MWaRmhQOUFfMCtaxVzzwWp8Z1miJwmRfhEY1vUjznVoLA0T2eWOjubxEPgfdNFAPCp2Y5vAGq0Kia4i8Yhwon/ViLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396965; c=relaxed/simple;
	bh=BkEUnYxguveRgPi0NIajQsfms9C2hQW3PkdlD1AC4mw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wwhzq2hVS1XFJNLBhZhw/B7FdOo3ZTBltDNwRP5L1D04Yjt+YHcJQRlbbTU+Rv8EJJHMOeTjvVVOJvgCSLpWEw5gK0uChlu6Nq7qCWywGQxhtbCx+M2kaAAnZxc+fh/JJcohOJjd4a1dl1M5YGZAn5RHSwyEM9UWMTIpFSHhxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0k9CA6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0k9CA6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7044B1F00A3A;
	Thu,  3 Sep 2026 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788396964;
	bh=2nrbwMRTtTirkx1WtbCoHypoyBVrrxGnXzudX8/8iXA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z0k9CA6z6jY/b+pyX8nRwMMFSHzqx9Zq2DT2Yuhg2s0hzOp942qQjhfeR8azDYQ9O
	 Rkl351RjLz39MHcbBBHyckXdP4V/a3PjMszwmMyg/uIh68rH762xV4vdKJp7IgP9V5
	 nEvwv3aJ9k/PolB/s6QIcLnQGgbNGwDz1fOn90UsG/TZHGmlLsiVrzTvUM9cdm5F/o
	 4fehsT9J2g6+owk3XhmKugbceOwB3w/IR+IjNW3ophQW3dg/d7wOJyZbJ9tdsl04zE
	 1YfNy8FXmWmfUeMB4cOK5cbsFOeTR9wRnEzbPcnzpzJMlrwV1a/7QLV19xRlUq6OUZ
	 Por9ebeFw466Q==
Subject: Re: [net-next,v6,2/3] dt-bindings: net: wiznet,w5100: add link status
 interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 00:56:02 +0000
Message-ID: <178839696296.3394541.3451749357764265327@kernel.org>
In-Reply-To: <20260831-wiznet-link-gpio-v6-2-abee6c5c966e@marmottus.net>
References: <20260831-wiznet-link-gpio-v6-2-abee6c5c966e@marmottus.net>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Incomplete per-variant schema constraint in
  Documentation/devicetree/bindings/net/wiznet,w5100.yaml: the new…
- [Low] Binding advertises a second (link-status/LINKLED) interrupt that
  no driver consumes.

--

dt-bindings: net: wiznet,w5100: add link status interrupt

This changes the interrupts property in the wiznet,w5100 binding from a
single entry to a two entry tuple with minItems: 1, so an optional second
interrupt tied to the LINKLED pin can be described.  The example is updated
to list two interrupts.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 601d828bae927..d0717ab45de6c 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -24,7 +24,11 @@ properties:
>        - wiznet,w5500
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Main interrupt (INT pin on the device).
> +      - description:
> +          Optional interrupt for link status changes (LINKLED pin on w5500).

[Severity: Medium]
The second item description says the LINKLED pin exists on the w5500, but
the interrupts definition here is unconditional, so should w5100 and w5200
nodes also be allowed to carry a second interrupt?

The compatible enum in this file covers all three parts:

  compatible:
    enum:
      - wiznet,w5100
      - wiznet,w5200
      - wiznet,w5500

and the only allOf entries are the two $ref lines:

  allOf:
    - $ref: /schemas/net/ethernet-controller.yaml#
    - $ref: /schemas/spi/spi-peripheral-props.yaml#

With no if/then block restricting interrupts by compatible string, a node
with compatible = "wiznet,w5100" and two interrupt entries passes
dt_binding_check even though the schema's own prose says the pin is w5500
only.

On the driver side, w5100_probe() only asks for the second interrupt on the
w5500:

  priv->link_irq = ops->chip_id == W5500 ?
                   fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;

so a w5100 or w5200 device tree written with two interrupts validates
cleanly and the second entry is silently ignored with no diagnostic.

Would it make sense to add an if/then block constraining interrupts to
maxItems: 1 for wiznet,w5100 and wiznet,w5200, or alternatively to reword
the description so it no longer claims the capability is w5500 specific?
The v6 changelog mentions the conditional properties were removed, so was
dropping the per-compatible conditional here intentional?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-wiznet-link-gpio-v6-0-abee6c5c966e%40marmottus.net
