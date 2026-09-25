Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB03D75D1;
	Fri, 25 Sep 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318043; cv=none; b=IPvsDkZDfXV80CENjmAhiUygcGHhwQGwsgtYIjMi+JN5A7pBiAMLV+eeK7uPaTOcG3so+cURbrlsZLo1+B/cEUAr2OhOr1kp+gvWhFHYcfkC0yIhbwicFVbYyGV5FgLhy1KsCI4yvndDf2DlJG3A+FL3Dr0ce6gy/3TmYAOWqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318043; c=relaxed/simple;
	bh=vDpLsNZEuFtu9T7J6RcZqK9LzTP3Hx+gNVGiixjfySU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKETeeQjDAZiLSg1iouvIAItSCBPDLwyGI8d/cXFPRYzy0RQtlIaevXnbVzD1RgN/QjU/axeUt582A9kJMT/l2y1rcZN9Ex+J0pprs1hfryrWWH1jgmWI2PcgQmw8K116TavKCSjZNr6bJ6UsE3jifHL/X4yalLCkZWEQoxv5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXbWxPB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXbWxPB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA61F000FF;
	Fri, 25 Sep 2026 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790318042;
	bh=k/DnikR47aHy9Hp7UL8oGAN/En52/9Yc3DlBvxibw5U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mXbWxPB9uiBp2lMqybsV15K9tH3YsL+ItpZ15VnbfgsLWV7PZUPiAIjbJZTagNM5G
	 D7xx/4xdlHSMWOKVGKZRUEuovffDdiEUeftnKW5794w8ygA/npvFYWk3IP+KtQoH1E
	 2R09ma3xVV7BMttJlY4//VUa/r3IohjHN0qzpHuA46ECqyam/gSqPGP3dIzoMom7qR
	 A0/4TfwgptKbDNHL38Poz2i6dBMZ8TthqSwKT1DOI3tGpwby0OEgnIWiiiLg3YCp3a
	 0ikXeC1xmwIEWISQfFnCORSEKQE9RcnKJVAZi7D9y/T0klTrf9m5zYM3Kolb5KpiJg
	 pSHFvf+j4Bkdw==
Subject: Re: [PATCH net-next] dt-bindings: net: Document Marvell PHY
 "marvell,reg-init"
From: netdev-bot+sashiko@kernel.org
To: robh@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 06:34:00 +0000
Message-ID: <179031804081.2160803.4823115817421319418@kernel.org>
In-Reply-To: <20260922183157.291091-2-robh@kernel.org>
References: <20260922183157.291091-2-robh@kernel.org>
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

- [Medium] The newly added `marvell,reg-init` schema in
  Documentation/devicetree/bindings/net/ethernet-phy.yaml documents the…
- [Low] The new `marvell,reg-init` definition types the property as
  `uint32-matrix` and gives each of the four cells only a `description`,…

--

dt-bindings: net: Document Marvell PHY "marvell,reg-init"

This adds a schema definition for the marvell,reg-init property to the
generic ethernet-phy.yaml binding, described as one or more
<page register mask value> tuples and marked deprecated. The intent is to
let dtbs_check validate the existing board descriptions that use it.

> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index c3ebb3af8b528..336f73f9c43fd 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml

[ ... ]

> @@ -269,6 +269,18 @@ properties:
>        have to be placed on board. When omitted, the PHYs default will be left as
>        is.
>  
> +  marvell,reg-init:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    deprecated: true
> +    description:
> +      Register initialization tuples for Marvell PHYs.
> +    items:
> +      items:
> +        - description: register page
> +        - description: register number

[Severity: Low]
Since the goal here is to let dtbs_check validate these board descriptions,
should the cells carry range constraints?  The property is typed as
uint32-matrix with no minimum/maximum, but marvell_of_reg_init() in
drivers/net/phy/marvell.c narrows every cell to 16 bits:

	u16 page = be32_to_cpup(paddr + i);
	u16 reg = be32_to_cpup(paddr + i + 1);
	u16 mask = be32_to_cpup(paddr + i + 2);
	u16 val_bits = be32_to_cpup(paddr + i + 3);

and the register number is a clause-22 MDIO address (0..31).  A tuple such
as <3 0x10020 0 0x1017> passes the schema and then gets truncated by the
driver into a write to a different register.  Would adding maximum: 0xffff
for mask/value and a 0..31 maximum for the register number catch that?  All
in-tree users already stay well inside those ranges (largest observed page
0x12, register 0x19, mask 0xffff), so nothing existing would start failing.

> +        - description: mask of bits to clear
                          ^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Is the polarity of this description inverted with respect to the consumer?
marvell_of_reg_init() in drivers/net/phy/marvell.c uses the mask as an
AND/keep mask, not a clear mask:

	val = 0;
	if (mask) {
		val = __phy_read(phydev, reg);
		...
		val &= mask;
	}
	val |= val_bits;

	ret = __phy_write(phydev, reg, val);

So bits set in the mask are the bits preserved from the live register value,
and bits clear in the mask are the ones zeroed.  The driver's own comment
above that function says the same thing:

 * mask: if non-zero, ANDed with existing register value.

The existing boards agree, for example in
arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts:

	<2 0x15 0xffcf 0>, /* Reg 2,21 Clear bits 4, 5 */

where 0xffcf keeps everything except bits 4 and 5.  armada-385-turris-omnia.dts
uses <3 16 0xfff0 0x0001> and cn9130-cf-base.dts uses <3 16 0xf000 0x0a61> in
the same style.

A board author following the new wording would write 0x30 to "clear bits 4
and 5", which makes the driver preserve only those two bits and zero the
other 14 bits of the Marvell page register (LED control, clock skew, MODE
fields).  Would it be clearer to describe this cell as an AND/preserve mask
and spell the update out as (old & mask) | value?

The mask == 0 case also looks undocumented.  When mask is zero the driver
skips the read entirely and writes value verbatim, which is what most
in-tree users rely on, e.g. arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts:

	marvell,reg-init = <3 16 0 0x1017>;

Under the "bits to clear" reading, a zero mask would mean "clear nothing",
i.e. the register is preserved, which is the opposite of what happens.
Could that special case be mentioned in the description too?

> +        - description: value to apply
> +
>    leds:
>      type: object
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922183157.291091-2-robh%40kernel.org
