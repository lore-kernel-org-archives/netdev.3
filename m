Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43925440A08;
	Thu, 24 Sep 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245279; cv=none; b=NBQGB8viP5TNIboo5oqN2ZrUD6krCOW0COcQ5XRnHqagsihkdZZ39N74xCGJ9Hbg2HcJ5m6SmeM5WJgWF6FHQzyeWJow0U/7e7sKzQ7ZZBOEOziFgyGwSO0OHwRt9yYM1L+We+wsVsIS8fhBA4mHoGKrzDfAFsQFfA5Iziy/EbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245279; c=relaxed/simple;
	bh=p9TY90geub1fC9fr3gH9BloG+6At6oCjWvKvPN47IJY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzWc73cR9gJQIZY8J3blTzr03H0eMRuXEZsLPMp0QH7yOVFZxSw1qUM4+z2vf5WiCR8uDMc6sz1u9qIT9iSvJE/Okqi/jlRP+67Chdufq7P8UesXWrEG5OhRkja4rVRnGvliz2lnPT+xMMmn6/RTFUZfKldgKmFio8FiW0U7xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwIb6uSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwIb6uSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AE01F000FF;
	Thu, 24 Sep 2026 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245271;
	bh=yCDGbhsWihQn3eTYtnVLZy7CG62BapTszQUWjuQBdG8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PwIb6uSsqaireY0zB7oBex+Kwo76E9iSlpaxgL/lirQtYY6Qey9GctykT7K1EFFzP
	 nph25rDbPlB3Qz23I1F+wVsabsHHmYcvf2E+jkWlW75WyPP0ZuAZJCxzv8ffivoKfn
	 vOpf8ugFeslQoPrBrlbXPX9h3xnZ/d9lBYzvCaxYjsMvjzujvgpdgehPYeHAWtZXXh
	 4+Omut8eh7np79L5RHAv6+XLt7QUe/DtBUyLv2YcEICt2cXXW0hHwaHXOaf1OhuhlZ
	 Qz6EKUlHnsREQNxuC+SG6f4OQj8887tewI/0LiWSSIbNspkWBsWeTmF4XnRz0LqMeM
	 lIhmiWC8xnr/g==
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: realtek,rtl82xx: Document
 RTL8261C/D PHYs
From: netdev-bot+sashiko@kernel.org
To: spolack+git@mailbox.org
Cc: andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, javen_xu@realsil.com.cn, chad@monroe.io,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 10:21:10 +0000
Message-ID: <179024527018.2160803.7990695653777964500@kernel.org>
In-Reply-To: <20260921161817.565185-2-spolack+git@mailbox.org>
References: <20260921161817.565185-2-spolack+git@mailbox.org>
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

- [Low] Concern (validated as FALSE POSITIVE / resolved inside the
  series): the binding enables rx-polarity/tx-polarity(-names) for…
- [Low] The new unconditional `- $ref: /schemas/phy/phy-common-
  props.yaml#` in…
- [Low] Concern (validated as FALSE POSITIVE / resolved inside the
  series): the binding permits a `leds` node for ethernet-phy-…
- [Low] The commit message states the leds node is allowed for the new
  parts "the way it is already allowed for the RTL8221B", but the only…
- [Low] Concern (validated as FALSE POSITIVE): the binding references
  phy-common-props.yaml wholesale for the RTL8261C/D compatibles without…

--

dt-bindings: net: realtek,rtl82xx: Document RTL8261C/D PHYs

Adds the three compatible strings for the RTL8261C/D family, allows a leds
node for them, and references phy-common-props.yaml so the tx-polarity and
rx-polarity properties can be used on those parts.  A second example using
inverted SerDes polarity and one LED is added.

Two questions below, one about the changelog and one about the schema.

> These parts drive four LEDs from the VEND2 LED register block, so allow
> the leds node for them the way it is already allowed for the RTL8221B.

[Severity: Low]
Is the reference to the RTL8221B here correct?  The only compatible that
was exempted from "leds: false" before this patch is
ethernet-phy-id001c.c916, and in drivers/net/phy/realtek/realtek_main.c
the PHY_ID_MATCH_EXACT(0x001cc916) entry carries:

	.name = "RTL8211F Gigabit Ethernet",

The RTL8221B ids are RTL_8221B_VB_CG (0x001cc849) and RTL_8221B_VM_CG
(0x001cc84a), i.e. compatibles ethernet-phy-id001c.c849 and
ethernet-phy-id001c.c84a, and those are still forced to "leds: false" by
this binding both before and after the patch.

Should the message name the RTL8211F instead?

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index 07b39ef1fc624..b21efcb9b2551 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml

[ ... ]

> @@ -74,15 +77,35 @@ unevaluatedProperties: false
>  
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - $ref: /schemas/phy/phy-common-props.yaml#

[Severity: Low]
This $ref is unconditional, so all six properties defined in
phy-common-props.yaml become evaluated for every compatible in this
binding, not just the three new ones.  Besides the four polarity
properties, phy-common-props.yaml also defines:

  tx-p2p-microvolt:
    description:
      Transmit amplitude voltages in microvolts, peak-to-peak. ...

  tx-p2p-microvolt-names:

Since the restriction block below only sets the polarity properties to
false, does this now let tx-p2p-microvolt and tx-p2p-microvolt-names pass
dt_binding_check on every Realtek PHY compatible listed in this file
(ethernet-phy-id001c.c916, c849, c84a and the rest), where before the
patch "unevaluatedProperties: false" rejected them?  There is no reader
for a transmit amplitude property anywhere in
drivers/net/phy/realtek/, so a device tree setting it would be silently
accepted and ignored.

Would adding

        tx-p2p-microvolt: false
        tx-p2p-microvolt-names: false

alongside the polarity entries, or moving the $ref under an
RTL8261-only branch, be preferable?

>    - if:
>        not:
>          properties:
>            compatible:
>              contains:
> -              const: ethernet-phy-id001c.c916
> +              enum:
> +                - ethernet-phy-id001c.c898
> +                - ethernet-phy-id001c.c899
> +                - ethernet-phy-id001c.c89a
> +                - ethernet-phy-id001c.c916
>      then:
>        properties:
>          leds: false
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - ethernet-phy-id001c.c898
> +                - ethernet-phy-id001c.c899
> +                - ethernet-phy-id001c.c89a
> +    then:
> +      properties:
> +        rx-polarity: false
> +        rx-polarity-names: false
> +        tx-polarity: false
> +        tx-polarity-names: false

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921161817.565185-1-spolack%2Bgit%40mailbox.org
