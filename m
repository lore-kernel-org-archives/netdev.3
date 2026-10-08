Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BA3BD225;
	Thu,  8 Oct 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447516; cv=none; b=toMqPcCkBz150tekP2eOFCMAkUl3uNAFEakwlF+wgpgC2Za5IO5bIo2b01PJrPrAcZf7f+dogQU1DN8NAmsZzQGPy8c0c5fo1iR6BZ8teItFRUaXuU0QGyflLItKdHUC5mJ0l6mKCgDMGLQgBpX7XHL7hWYldQc3qoHaK1Odhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447516; c=relaxed/simple;
	bh=4TvBOCc9PvLboK/gz7ukwvoZMNEZzYpVEb5lLaHqwbI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nr8nh4T8SL5mr03fJOj/aaExG77R5CGUl3lMX/719blf0KY0+L05ToQfDz0U8cbEWKMq442YoAFd0pEQBaQ5u5HI9ww5PzTAsACUsIlZJtOuymzcu/JvAnCCrlolyo9lhlHmkWfboqxGR7GVnW5uY5uXgQRJTWOqoCt9RHN2O4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWZOFv3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWZOFv3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1041F000FF;
	Thu,  8 Oct 2026 08:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447515;
	bh=u0B6bXMn/46hV1IF9kkgPWYk3PJmCZ6sZG2kxLipFKc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RWZOFv3C68aCEZ7kzw+oBv5b+7x4SyNrt0y9YsYhKICCHnpT00EOtjXXK7UQngjuE
	 Czc/5BL5Jx32rnGwkd4ZV2osmA2wZIbbNEnENAnWBDEgj+oYTEW6EEXUpmi4V3LwkC
	 /aUJrFNYYx4P8DVC8KJhsHDsAhZ69KYaouHX/5vVBl0nuFIVidJPoWzeIQZzkEO2bK
	 57uijpjQPu+rrTiodNfbwnUI7KVob/+MC5XKZzTkUQQl+bGLomAPDgZ59839rt/B39
	 +d5xwNnvnRDLSvXKPLtgKvJXWk4ZdV4X3IKEwI+WQHCcjKafmHwnuiT/v71D3wWNYY
	 pvfRslJXaGohw==
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: realtek,rtl82xx:
 document RTL8224 packages
From: netdev-bot+sashiko@kernel.org
To: oskari@lemmela.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, daniel@makrotopia.org,
 javen_xu@realsil.com.cn, vladimir.oltean@nxp.com, olek2@wp.pl,
 o.rempel@pengutronix.de, ih@simonwunderlich.de, amadeus@jmu.edu.cn,
 jan@3e8.eu, f.fainelli@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mensi@mensi.ch
Date: Thu, 08 Oct 2026 08:18:33 +0000
Message-ID: <179144751377.434549.17815693541329607238@kernel.org>
In-Reply-To: <20261005201540.913977-2-oskari@lemmela.net>
References: <20261005201540.913977-2-oskari@lemmela.net>
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

- [Low] Not a bug in the final series state; dismissed after
  verification.
- [Low] In Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml,
  the new RTL8224 example gives each PHY node only compatible =…

--

dt-bindings: net: realtek,rtl82xx: document RTL8224 packages

This patch documents how RTL8224 parts are described with the existing
ethernet-phy-package binding. Each part has four PHYs at consecutive MDIO
addresses, and the package base need not be a multiple of four. It also
adds an example with a package that starts at MDIO address 1.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index 07b39ef1fc624..ca52c3ae19f7a 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -12,7 +12,17 @@ maintainers:

[ ... ]

> +  The RTL8224 contains four PHYs at consecutive MDIO addresses. Its PHY
> +  nodes may be grouped under an ethernet-phy-package node as described
> +  in ethernet-phy-package.yaml. The package reg must identify the first
> +  PHY's MDIO address, even if that PHY has no child node. This address
> +  need not be a multiple of four. Each child PHY reg is its absolute
> +  MDIO address, not an offset from the package base.

[Severity: Low]
At this commit, can the driver handle a package whose base is not a
multiple of four? rtl8224_probe() in drivers/net/phy/realtek/realtek_main.c
ignores the package reg and works out the base itself:

    devm_phy_package_join(dev, phydev, phydev->mdio.addr & ~3, 0)

Also, rtl8224_mdi_config_order() and rtl8224_mdi_config_polarity() pick
the port lane with addr & 3.

The example below has a package at 1 with PHYs 1-4. With that layout:

- PHYs 1-3 would join a package at base 0.
- PHY 4 would join a separate package at base 4.
- The VEND1 0xa90/0xa94 read-modify-writes would go to MDIO address 0.
- The lane bits would be wrong.

The next patch in the series, "net: phy: realtek: support unaligned RTL8224
PHY packages", fixes this:

- It reads the package reg into base_addr.
- It joins through devm_of_phy_package_join().
- It sets priv->port_offset = phydev->mdio.addr - base_addr for the MDI
  helpers.

With the full series applied, this layout is handled correctly. Merging the
binding before the driver change is also the usual order.

[ ... ]

> @@ -90,9 +100,45 @@ examples:

[ ... ]

> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@1 {
> +            reg = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ethernet-phy@1 {
> +                compatible = "ethernet-phy-ieee802.3-c45";

[Severity: Low]
Are these nodes ever checked against this schema? Their only compatible
is "ethernet-phy-ieee802.3-c45", and that string is not in this binding's
compatible enum.

realtek,rtl82xx.yaml has no explicit select, so dtschema builds one from
that enum. As a result, the four ethernet-phy@N nodes never match this
schema during dt_binding_check.

Only two schemas check these nodes:

- ethernet-phy.yaml, which selects on $nodename.
- ethernet-phy-package.yaml, which has additionalProperties: true.

That means this schema's own constraints never run on the new example.
This includes unevaluatedProperties: false, the leds conditional and the
realtek,* properties. The example also has nothing that marks the device
as an RTL8224.

Would a compatible like this work instead?

    compatible = "ethernet-phy-id001c.cad0", "ethernet-phy-ieee802.3-c45";

> +                reg = <1>;
> +                enet-phy-pair-order = <0>;
> +            };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005201540.913977-1-oskari%40lemmela.net
