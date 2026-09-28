Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EE48F016;
	Mon, 28 Sep 2026 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590998; cv=none; b=eXagaPgwJuttpswuqwdr6He37Yk5swA/VjZkV9iCubzn1nKEiT3cpSh4pp3kftrLLk0Q78dvposKCK4Vhv4oHkf3jXrN6OW/+Z3foooU5bk9LDSuDJdrPSzTOb6dXoZfpFxQ91Vq8BM5UH4QnvURlV3F/vectADW9wNfBfAoljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590998; c=relaxed/simple;
	bh=i6ceDNUAn7DtNkU54AwkgJ6i7SxNeka1+hUYln0wJ54=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpwur8X5IfOhbY+6kY0pJSFK5ZFGn+GCcv30wXOHcRSLr9NBOFp7TDKOZkzAVbKLFb7PyR/cjHgLgIA4W/q3eVqXABqxHFh5fXUSLlY/9vqfbyoI7wALzP2Ety5dhgp34pQQ4to7iMTXY8a5iO7/n1Nyr7gOSRIl0uXgVu/C3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVajzehD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVajzehD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267C21F000FF;
	Mon, 28 Sep 2026 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590996;
	bh=DnbFanEGS7RjICrt+fEOQLHwmDooc2fyhmAdKraSR+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VVajzehDLDLiUPjRewAlgVEtcvvUizuGXb3mj9lTKyWR+CgYyBJ99xiGw5IepSWUr
	 /f5tU7o/oKD5ezzeW/jVi2r41T9BHZehIBcx4VKpEU3RmKynm7NKUBAwwFG1QBZKpS
	 OgmkuvMhK+xTkT24c3LY/YvvAD2PDj8qjxL0DYcP349ixxRW7UnNQ6o1eNcGLOWY95
	 PgP7NHUPraYelaRK2rVLKe42wnse0Ys3K3TVY9qoqBpVAKv1Lml12KIqy5viQxANgF
	 NBtBPLzqs6miHf0d+ioK8Eoj2BOXrz0AwBqfkiUGH/bSJc+MZxFXzUcSqgJ9jW3Zn8
	 sVk2h5eHg8kcg==
Subject: Re: [PATCH net-next v11 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 10:23:15 +0000
Message-ID: <179059099561.3145.7542447951602158988@kernel.org>
In-Reply-To: <20260924-wiznet-link-gpio-v11-1-42a332517b30@marmottus.net>
References: <20260924-wiznet-link-gpio-v11-1-42a332517b30@marmottus.net>
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

- [Low] In Documentation/devicetree/bindings/net/wiznet,w5100.yaml, `spi-
  max-frequency` has a single `maximum: 80000000` that applies to all…

--

dt-bindings: net: wiznet,w5100: convert to DT schema

This commit converts the Wiznet w5x00 SPI Ethernet controller binding
from plain text to DT schema. It also changes the example interrupt
trigger type from edge-falling to level-low to match the driver, and
adds a MAINTAINERS entry for the new YAML file.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> new file mode 100644
> index 000000000000..df83f90b3919
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml

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

[ ... ]

> +  spi-max-frequency:
> +    description:
> +      According to the datasheets, w5500 and w5200 allow a maximum of 80 MHz
> +      while w5100 is reported by users to allow a maximum of 14 MHz. However,
> +      board designs may need to limit this value.
> +    maximum: 80000000

[Severity: Low]
The description gives w5100 a lower limit of about 14 MHz, but the only
constraint here is maximum: 80000000, and it applies to all three
compatibles. Should the schema enforce the w5100 limit as well?

The allOf above only holds the two $refs. Nothing like this lowers the
limit for w5100:

  if:
    properties:
      compatible:
        contains:
          const: wiznet,w5100
  then:
    properties:
      spi-max-frequency:
        maximum: 14000000

As a result, a node with compatible = "wiznet,w5100" and, for example,
the 30 MHz value from the example would pass dt_binding_check and
dtbs_check.

The driver does not clamp the rate either. w5100_spi_probe() picks
w5100_spi_ops from the match data and passes the device on to
w5100_probe(), and the SPI core uses the max_speed_hz from DT as is.

The same gap remains at the end of the series. The allOf if/then block
added by "dt-bindings: net: wiznet,w5100: add link status interrupt"
only restricts interrupts and does not touch spi-max-frequency.

The old text binding had no limit at all, so this is not a regression
from the conversion. If the 14 MHz figure is left unenforced on purpose
because it comes from user reports rather than the datasheet, could the
binding say so?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-wiznet-link-gpio-v11-0-42a332517b30%40marmottus.net
