Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD526AC5;
	Thu,  3 Sep 2026 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396964; cv=none; b=ZJakPw58fpQ1Jp+bGr9g5dB94t2ejYEX+qL/2fSWvgAwWQypbrMphcXiEpfsgYgC+ZIKeq1NoPoTDAPQHcB6SRWsKjrTniPWGHql2Q0Gw9iHYNmplBCbBjmZcWaPquNV5y6Vw8km8QncmlhR0Hyea/5LBI3DoPoXOZNOuUrVQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396964; c=relaxed/simple;
	bh=qtVlNxCnVzLzBM9Vf+e2JmadYkECyr8fqlB/cwj1NvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gj87+KH1dPFxoEipFl12YkbreSqpDGMoSq/g2vlQi+I8PYJKeyM8IVxEz4MKVJMVscA4DB+u5pG2uvcDo7ZkgFbg0uyzfn8RcUIo2GOompp6Tby/Krxfe7UIhKU13NwcGCeG+elZCaYL4gm6ftfMXMJmBG4QNCu3Y+v4NLW8ATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=norbZ+og; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="norbZ+og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168F1F000E9;
	Thu,  3 Sep 2026 00:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788396962;
	bh=XqHrAGcUd2P6zGJxD2gyGcw4Dr0oavq/XJn+jXJPwuo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=norbZ+ogNZ8U6sL39LN07dZ1Xh90iqTjXcGcM4iEw9w0pxz0OgittRG1cUVb8kUa8
	 CyrS8gmOXzVwfXILdnCW1A7DjY4HFgKE49fBL/kJ6MdmJJc0RqDhaxvYlIjZDT4qhD
	 rRV7dnmCUiaEPT22mNL4jTTzfWY5ZM20dOQV0Uh1kK7Uuld7ZpaJDFUIC8UbBfLS2T
	 wOiTCUs1wDjSaxkdE17C/1qXxddZO0MvMwpXP7CJGnM7+WCGtgXDjyzmpKLqxP8wcF
	 nlvzyBpguoXbM3CTYxpbNuhDfl09EgyuZZgInNi4V1Lud/Chh7PI/rubBNtYqiv8b+
	 XrjOBYlkT03SA==
Subject:
 Re: [net-next,v6,1/3] dt-bindings: net: wiznet,w5100: convert to DT schema
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 00:56:01 +0000
Message-ID: <178839696151.3394541.8695572250360907851@kernel.org>
In-Reply-To: <20260831-wiznet-link-gpio-v6-1-abee6c5c966e@marmottus.net>
References: <20260831-wiznet-link-gpio-v6-1-abee6c5c966e@marmottus.net>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The new schema enforces one `spi-max-frequency: maximum:
  80000000` for all three compatibles (wiznet,w5100, wiznet,w5200,…

--

dt-bindings: net: wiznet,w5100: convert to DT schema

This converts the Wiznet w5x00 SPI Ethernet controller binding from plain
text to a YAML DT schema, covering the wiznet,w5100, wiznet,w5200 and
wiznet,w5500 compatibles. The old wiznet,w5x00.txt file is removed.

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
Should the 80 MHz limit be conditional on the compatible string?

The description scopes the number to the w5500 datasheet, but the maximum
applies to all three compatibles enumerated just above, including
wiznet,w5100 and wiznet,w5200, whose SPI slave interfaces are rated lower
(the W5100 SPI timing figures are in the tens of MHz, not 80 MHz).

With a single top-level maximum, a device tree that clocks a wiznet,w5100
at 80000000 passes dt_binding_check without a complaint, and the value is
then handed straight to spi->max_speed_hz for the register accesses done by
w5100_spi_read()/w5100_spi_write() in
drivers/net/ethernet/wiznet/w5100-spi.c, which use a different opcode
protocol from the w5200/w5500 ops.

Would per-variant limits be more accurate here, for example:

    allOf:
      - if:
          properties:
            compatible:
              contains:
                enum:
                  - wiznet,w5100
        then:
          properties:
            spi-max-frequency:
              maximum: <w5100 limit>

Note the exact W5100 and W5200 fSCLK ratings are not derivable from the
tree, so this is based on the schema's own statement that the number comes
from the w5500 datasheet.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-wiznet-link-gpio-v6-0-abee6c5c966e%40marmottus.net
