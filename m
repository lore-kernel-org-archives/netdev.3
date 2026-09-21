Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02035C6BE;
	Mon, 21 Sep 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996678; cv=none; b=TkJKmw4m6Mc4K5ViPiKAi1I9QXeK3PnCdQZ/5u9E+fK3MThGnPvQ3OtApgGYPvfIgne6ZKeUzc7z3311ruvQIB7HkrYXfmIFCydbY7fEp9QnBo1yukyvb9MP4UhqNVGNTHI4bPuDW7uM1HYjdTYX4fOvC35BVQ/1OGyId8LduvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996678; c=relaxed/simple;
	bh=/IrnzvYQot3hiSBOdI2+JLB3gjGuqiv+glwP/gCO+rs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NPo0O0AjN+FdK7N0uCjzrUNJbDJRMWIwIpIa8c0Ii+v1VBMqmha1bsuYATiYloTNw9AfhbpoUOiw2g83x3gRYF8b8AcuQIBCCQKzhyeyur1lxAD2kB4JquuBjuU2CofQ3rUSzTAfi05nF5ktl1vGGY3pu1VSZazNLBoOVx33Ecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyUAbcml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyUAbcml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EDA1F000FF;
	Mon, 21 Sep 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996676;
	bh=6raPsa/GzGfVtm1uCziBaV4OUSeDMBPoXDZejJq0Prc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AyUAbcmlEgnTIK2NDP+HRWLdN/Lo8X5+PAqZ6mwJoPipiEmDFvRp8eteCUpmSMVKj
	 k9iGtjbwP/0Fn4MwAYf4G6V5IXMQjWmylD1rAvK9m+zPU9EGuTfuQPdppfDumUlJrS
	 qnna0mOtix4nXBUtonuzrTqOYL9ANOQfsDPUXikjKZrCMagd3e0IRbmpgntoFEIRB9
	 B9yEqCXkHiNpvUh0bv0O07dW189EA+olc6JZSPbfrfv9Xg1nfXGMQ2VWF2JI28e/SM
	 9HRf3lA4c0ZkbNQGsLP3A2Fuv8IvZrHbvFl/kN/Z0a+XnrIGkK8ZIbHUWSUwdyWgDN
	 eIPxiEp7rsqFw==
Subject: Re: [PATCH net-next v20 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Date: Mon, 21 Sep 2026 13:17:55 +0000
Message-ID: <178999667530.2160803.2619551882908404136@kernel.org>
In-Reply-To: <20260917131441.3428554-2-kyle.switch@motor-comm.com>
References: <20260917131441.3428554-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The single example in the new binding is self-inconsistent and
  contradicts the semantics it inherits: the package node is named…
- [Medium] The binding redefines the standard, MAC-side property `phy-
  mode` on a PHY *package* node with its own type reference (`$ref:…
- [Medium] The package-level `phy-mode` enum is limited to `[internal,
  usxgmii]`.
- [Low] The new binding file
  Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml is not…
- [Low] Concern (judged a false positive at end of series): the binding
  requires `phy-mode` on the package node and defines compatible…

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This adds a new binding for the Motorcomm YT8824, described as a PHY
package containing four PHYs. The binding references
ethernet-phy-package.yaml and adds a package-level phy-mode property with
the values internal and usxgmii.

A few questions about the new schema below.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 0000000000000..9737364744a07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MotorComm YT8824 Ethernet PHY
> +
> +maintainers:
> +  - Kyle Switch <kyle.switch@motor-comm.com>

[Severity: Low]
Should MAINTAINERS gain an entry for this file?  The MOTORCOMM PHY DRIVER
section currently lists the binding literally:

  MOTORCOMM PHY DRIVER
  M:	Frank <Frank.Sae@motor-comm.com>
  L:	netdev@vger.kernel.org
  S:	Maintained
  F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
  F:	drivers/net/phy/motorcomm.c

That pattern does not match motorcomm,yt8824.yaml, and no other section
matches it either, so get_maintainer.pl will not report the Motorcomm PHY
maintainer for future changes to this file.  Widening the existing entry to
Documentation/devicetree/bindings/net/motorcomm,yt8*.yaml, or adding a new
F: line, would cover it.

> +
> +description:
> +  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
> +
> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorcomm,yt8824-package
> +  phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, usxgmii ]

[Severity: Medium]
Is phy-mode the right property name here, and is internal a valid value for
this device?

phy-mode is owned by ethernet-controller.yaml, as an alias of
phy-connection-type, and internal is defined there as:

      # There is not a standard bus between the MAC and the PHY,
      # something proprietary is being used to embed the PHY in the
      # MAC.
      - internal

The YT8824 is a discrete package addressed over MDIO, so that definition
does not appear to describe it.  The driver added later in the series keys
hardware bring-up off this value:

  drivers/net/phy/motorcomm.c:yt8824_config_init() {
      if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
          ret = yt8824_internal_config_init_paged(phydev);
      ...
  }

so the standard property name is being given a vendor-specific meaning that
the schema does not state.  The property is also added with no description
and placed in required:, which freezes it as ABI.

The closest peer binding, qcom,qca807x.yaml (which also references
ethernet-phy-package.yaml), uses a vendor-prefixed property with an explicit
mode table instead:

  qcom,package-mode:
    description: |
      PHY package can be configured in 3 mode following this table:

Would a described, vendor-prefixed property such as motorcomm,package-mode
be a better fit than overloading phy-mode?

[Severity: Medium]
Separately, is usxgmii the correct wire format for this package?

If the four 2.5G ports are multiplexed onto a single 10G SerDes uplink, the
kernel's interface mode for that format is 10g-qxgmii
(PHY_INTERFACE_MODE_10G_QXGMII), and ethernet-controller.yaml lists the two
as distinct values:

      - usxgmii
      - 10gbase-r
      - 25gbase-r
      - 10g-qxgmii

A MAC configured from phy-mode = "usxgmii" would program a single-channel
USXGMII PCS, which would leave the remaining three ports without a channel.

If the chip instead exposes four independent USXGMII lanes, a single
package-wide string cannot express which PHY sits on which lane, and the
binding defines no property for that mapping.  I could not determine the
host topology from the series: the only SerDes setup for the non-internal
mode is preamble padding in yt8824_extern_config_sds_init_paged(), which is
consistent with either arrangement.

Could the description: state the host-side topology explicitly?

> +
> +required:
> +  - compatible
> +  - phy-mode
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "motorcomm,yt8824-package";
> +            reg = <9>;

[Severity: Medium]
Two things about this node.

First, the unit address is @0 while reg = <9>.  Should the node be named
ethernet-phy-package@9 so the unit address matches the first reg entry?  As
written, two YT8824 packages on the same bus would both be named
ethernet-phy-package@0, which collides under the
-Wunique_unit_address_if_enabled used by
Documentation/devicetree/bindings/Makefile.

Second, is reg = <9> consistent with the meaning inherited from
ethernet-phy-package.yaml?

  reg:
    minimum: 0
    maximum: 31
    description:
      The base ID number for the PHY package.
      Commonly the ID of the first PHY in the PHY package.

Here all four members are at 4, 5, 6 and 7, i.e. below the declared base, and
phylib only ever forms member addresses by adding an unsigned offset to the
base:

  drivers/net/phy/phy_package.c:phy_package_address() {
      u8 base_addr = shared->base_addr;

      if (addr_offset >= PHY_MAX_ADDR - base_addr)
          return -EIO;
      return base_addr + addr_offset;
  }

so no member of this example is reachable as base + offset.

The driver added later in the series treats the package reg as the absolute
MDIO address of the shared top-extended register block, at offset 0:

  drivers/net/phy/motorcomm.c:ytphy_write_top_ext() {
      /*
       * The package base address is used here to read the top ext registers.
       * For example, in internal mode, the top ext address is fixed at 9;
       */
      ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
      ...
  }

If that is the intended meaning, should this binding add its own reg:
description overriding the base-ID wording?  A DT author following the
inherited text and writing reg = <4> would have of_phy_package_join() store
4 as base_addr, and the page-select and page-data writes above would then
land on the member PHY at address 4 instead of the package register block.

> +
> +            phy-mode = "internal";
> +
> +            ethernet-phy@4 {
> +                reg = <4>;
> +            };
> +
> +            ethernet-phy@5 {
> +                reg = <5>;
> +            };

[ ... ]

For reference, the binding file is unchanged by the remaining two patches in
the series, so nothing later adjusts the example or the phy-mode wording.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917131441.3428554-1-kyle.switch%40motor-comm.com
