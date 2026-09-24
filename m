Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19653A1685;
	Thu, 24 Sep 2026 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214956; cv=none; b=kWv+vhmg4AkW3PnVCsQ6yzhy+0PiF9LF8omv1e3MDyTkKqjN3OQlTTjAAgXHDFg9Jcuq2kHn7Rlm46Bmn2+JvE6Ar+ehbPzEchjKtRxeng3bWMo3oJQ1fkcArPmUmNDPLiOkBsFjmz8W2q7bQGyAhr+oymJrnRwM7VwhvZmIKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214956; c=relaxed/simple;
	bh=d5hRGQwlUe0I4kNX7f2Y6mX0zXWFGYRNkLVC2ZVzovo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiKRC6nNxJX14Az3d/IwIr4iABWZt4KTdcpR49xqUVJ0RBZVTgdP3buNJdKgGb7RSTRyMtJG6/JN9FloiJWMEzNGC22ELXVeiXG1FvSWslOlAN4Z46tZLpU2vC+5g9Z7hN7XTs+3viRgsLL8UBBZrv6QOawEKoHK+HOd1a2qdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZPlh3KY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZPlh3KY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD02B1F000FF;
	Thu, 24 Sep 2026 01:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214954;
	bh=6ZIYgKi6p21Q91cSj+8cKV3sY8NG7q7UCpClxLbOXrM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OZPlh3KYmstgWcBGXz5Hcmqm4S2mD03d5ZxYGJFqBAbzzJqUvzaJwZdyniMdV5bpa
	 3JZPysEOjfS7ty+2l0DVsr3XNllQuMEIgG4eFCfVaP6hu57nzL6EYjPeyOKJqoF114
	 w40r/y+fMV62Si/lwTfLe8k09WsIObXTMJgl4lWa/KVhCCVYc5Hs5PGfzrbDxuMmyz
	 V2tD3bGNJDeWESyl/6IHcnpid7H3J5A7LuNG1EW5A1U7WqsIM5OQjm7DzYAvtlzOxa
	 Sbw8uyGvxhAcOueQ1ZZpfvgxuRBNPNV+p4fq1rQGhsq1zdwa9eEojAcJEOYbug8GOq
	 FCOfXHQW7E/HA==
Subject: Re: [PATCH net-next v10 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 01:55:53 +0000
Message-ID: <179021495314.2160803.14503162237139110651@kernel.org>
In-Reply-To: <20260921-wiznet-link-gpio-v10-1-5874a7a147a2@marmottus.net>
References: <20260921-wiznet-link-gpio-v10-1-5874a7a147a2@marmottus.net>
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

- [Low] The patch silently adds a new MAINTAINERS section ("WIZNET W5100
  ETHERNET DRIVER") naming the submitter as maintainer, but the commit…
- [Low] In Documentation/devicetree/bindings/net/wiznet,w5100.yaml the
  new schema states a single, unconditional 'spi-max-frequency: maximum:…

--

dt-bindings: net: wiznet,w5100: convert to DT schema

This converts the Wiznet w5x00 SPI Ethernet controller binding from plain
text to a YAML DT schema, and changes the documented interrupt trigger type
from edge-falling to level-low to match the driver. It also adds a new
MAINTAINERS section for the binding.

Two questions below.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> new file mode 100644
> index 0000000000000..25098308eb6e5
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

[Severity: Low]
The description here says the w5100 tops out around 14 MHz, but the only
machine-checkable constraint is the loosest value, 80000000, and it applies
to all three compatibles.

Should the w5100 limit be expressed as a conditional instead, so that it is
actually validated?

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

As written, a node with:

    compatible = "wiznet,w5100";
    spi-max-frequency = <80000000>;

passes dt_binding_check and dtbs_check with no diagnostic. Nothing in
drivers/net/ethernet/wiznet/ looks at spi->max_speed_hz either, so the
14 MHz figure is not enforced anywhere.

This is still the case at the end of the series: the allOf if/then block
added later by "dt-bindings: net: wiznet,w5100: add link status interrupt"
only constrains interrupts, and spi-max-frequency keeps the unconditional
80 MHz ceiling.

Separately, the old wiznet,w5x00.txt documented the 80 MHz figure for the
w5500 only:

    - spi-max-frequency: Maximum frequency of the SPI bus when accessing
      the w5500.

The new schema extends that ceiling to w5100 and w5200 as well. Could the
commit message mention that change?

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index df8ab9b824024..9f84e4c8163e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29450,6 +29450,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
>  S:	Maintained
>  F:	drivers/input/misc/wistron_btns.c
>  
> +WIZNET W5100 ETHERNET DRIVER
> +M:	Arthur Crepin Leblond <arthur@marmottus.net>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +

[Severity: Low]
The commit message describes only the .txt to .yaml conversion and the
trigger type change, but this hunk also creates a new maintainership entry.
The "v8: Add a myself in MAINTAINERS" note is below the --- line and will
not land in git history.

Could the commit message describe the MAINTAINERS addition too?

Also, at this commit the section is titled "WIZNET W5100 ETHERNET DRIVER"
while the only F: pattern matches the YAML binding, so get_maintainer.pl
still reports no maintainer for drivers/net/ethernet/wiznet/. That gap is
closed later in the series: "w5100: detect carrier state using link status
bit and optional interrupt" adds F: drivers/net/ethernet/wiznet/ to the
same block. Would it make sense to add that F: line here, where the section
is introduced?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-wiznet-link-gpio-v10-0-5874a7a147a2%40marmottus.net
