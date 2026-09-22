Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F955D88B;
	Tue, 22 Sep 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091815; cv=none; b=ezEbuvubBHRGJ3B08XeGhXX0+YxOcLLnj6SreBlRwktFJ5CiIrGBWd+mDdjXCuTP7EQ6tawbgp8MK7NVqK/xyPq0QeVuZwdz6mTSX+35hUFFfxQUUtS8QjIN/fAgqW2ooU5LFj6GMza4ExSqR31dIrd1RNAe8MvKojHzoCj4hTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091815; c=relaxed/simple;
	bh=rmm2ip3x4rObg7f/IAVd47+fOQlHAFprDiAJ7f3b2P4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLmcZXmrxoy4tcdylwngh493tc88PmfHS+VcgAOv5t+Uv5/sKD0KrgAq9zxwN8MhK7vWHej5iH+UKznLflXmoCBXxZ+W5COIbfVSkyNWztv/m/pcn1sN+gukeEfh21IKw9W7zpr7iVl9zYOxcso9pL98UGfGUwuGHFw1iJ1v2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdkMEqYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdkMEqYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17B1F000FF;
	Tue, 22 Sep 2026 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091805;
	bh=5mYDRdpqoJm7XMxAfIZWNQHNwzVLqZ0QTUodt1TbgI4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KdkMEqYMmwypy+vCPZp+0rfPCpV//vHL+13MpUUQEBpkTIKNd3FyaeP0YQvv7E2U9
	 oyqOqbLOT7zV4xv/l7/0CKpnWdPN+G7gGFFKrkpr+samrEKeOHpUs+GF3MGDcppo0u
	 zp3iLf4r7CHEYwHHmunilJlsYPu3+mjiIKV19Cpao+gX5QY4lL+XRgb830I6pW0Hkw
	 QdcCCHeWKy0tT/yApayK55iZTB8JldsqEBbTLrs7VJtueuTrHs8OPWO7XxSeqKplO0
	 CxMUgSg7F5KibA410lU3CfPaiKG+NoNXjG7lwpQgqaYAz7lf+/QxmqSH5/6r6qBbO3
	 mmCf3QY45OY0w==
Subject: Re: [PATCH net-next v9 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 15:43:24 +0000
Message-ID: <179009180465.2160803.12754142201441824675@kernel.org>
In-Reply-To: <20260918-wiznet-link-gpio-v9-1-5536f24d8d6d@marmottus.net>
References: <20260918-wiznet-link-gpio-v9-1-5536f24d8d6d@marmottus.net>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In Documentation/devicetree/bindings/net/wiznet,w5100.yaml the
  new machine-checkable constraint 'spi-max-frequency: maximum:…
- [Low] Undisclosed MAINTAINERS change: the commit adds a new "WIZNET
  W5100 ETHERNET DRIVER" section (MAINTAINERS:29442) that is never…

--

dt-bindings: net: wiznet,w5100: convert to DT schema

This converts the Wiznet w5x00 SPI Ethernet controller binding from plain
text to a YAML DT schema, and changes the documented interrupt trigger from
edge-falling to level-low to match the driver.  It also adds a new
MAINTAINERS section for the binding.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> new file mode 100644
> index 000000000000..25098308eb6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -0,0 +1,68 @@

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

[Severity: Medium]
Do the description and the constraint here disagree for wiznet,w5100?

The text says w5100 is limited to about 14 MHz, but the only
machine-checkable limit is a single unconditional maximum of 80000000 shared
by all three compatibles.  So this node passes dt_binding_check:

    ethernet@0 {
        compatible = "wiznet,w5100";
        reg = <0>;
        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
        spi-max-frequency = <80000000>;
    };

Nothing downstream clamps it either: w5100_spi_read() and w5100_spi_write()
in drivers/net/ethernet/wiznet/w5100-spi.c issue their transfers at the SPI
device's configured speed, with no per-chip ceiling, so the out-of-spec rate
is what actually gets driven for every register and packet buffer access.

Would an if-then block be preferable, keeping 80 MHz for the other two
parts?

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

Note the removed .txt scoped its 80 MHz statement to the w5500 only and had
no machine-checkable limit, so the unconditional bound is new here.  The
single maximum of 80000000 is still the only spi-max-frequency constraint at
the end of the series (9d871f2771b9), where the added allOf block constrains
only interrupts.

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index cae5962045dd..e6a5a4e245a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29439,6 +29439,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
>  S:	Maintained
>  F:	drivers/input/misc/wistron_btns.c
>  
> +WIZNET W5100 ETHERNET DRIVER
> +M:	Arthur Crepin Leblond <arthur@marmottus.net>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml

[Severity: Low]
Could the commit message mention this new MAINTAINERS section?  The
preserved log text only describes the .txt to YAML conversion and the
edge-falling to level-low trigger change; the new maintainership claim is
mentioned only in the changelog below the --- separator, which does not end
up in git history.

The section is named as a driver entry, but its only F: line matches the
binding file, so at this commit scripts/get_maintainer.pl will not route
drivers/net/ethernet/wiznet/ changes here.  That part is addressed later in
the same series: the commit "w5100: detect carrier state using link status
bit and optional interrupt" adds F: drivers/net/ethernet/wiznet/ to this
section, so the mismatch exists only between this patch and that one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d%40marmottus.net
