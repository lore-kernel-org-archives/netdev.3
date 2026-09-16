Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E61E5B9F;
	Wed, 16 Sep 2026 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530859; cv=none; b=ugFc9DAK8/cZvILEn7qpJEn10YNUwwTUb1J1/p197p3494/MWkdvTTvtXHJECndm16y/+go/+QBqyGtGXrODHLSWgrOyKB08sSVYb9ziET4aHdpzhCFEhiTwGCvDXn8I+fJJ3+zlF7XYa/7CwrhVmwwecWZ0+RgHY6qN6QXIJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530859; c=relaxed/simple;
	bh=gz/3XW/K9e+8kOoFi6oCJ9S91rwKJqdLoiSDcadGXQU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmzKeNvFCTFjnYPHH2hE8FrcLEEn42Fw1JrVRKRAeGfZ/8ZErC4NgQqPNh782VOQm7SMu3tqz6DDgYZGuIWYnALPx6PQycPdq5Fd3Xnw4GvH+u+sQhcFA7izcUHxL6/QQNNQtS9AMMViYU22I3KTM8miJAvW4SWUSM2Vai063fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKn+EYMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKn+EYMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68861F000FF;
	Wed, 16 Sep 2026 03:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789530857;
	bh=CjRowWsdHtCIXoLKrFf4yVfbW0Q7HnldJYPvT2fpwso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UKn+EYMAt+Lqn6+P49BLM+UxdAENUISyyvRub0wYP2RpyOi5J0jp8pGmUY27UYrl4
	 da+HzeLwCvYLvj99gUjUTgkmhC4XR1nt25WFnR43P9Vd6OF1QlSUqM6dE8stE8qT/s
	 Xu4Y+YZdalt4ysLv9WM6CrhGwafOz2lo1k6cP8Xs0Qcz346GZNF60QXzv/vx1QkWIX
	 3AVGK6pynR0y/S1ZUtXy8BAQTB/Gax19KuB/3kETx1WHmiV6jU8djFfs3p7Neva3zF
	 77NE/B4j9/sETwwRE/LaEWn+Z4yTyuXEIOZ+URhv/T0M4LJwpj/6Zsia0s72w8DVyh
	 3anKiuuP2bzeA==
Subject: Re: [PATCH net-next v17 1/2] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com
Date: Wed, 16 Sep 2026 03:54:16 +0000
Message-ID: <178953085623.22033.2969855264580548672@kernel.org>
In-Reply-To: <20260912065224.2723883-2-kyle.switch@motor-comm.com>
References: <20260912065224.2723883-2-kyle.switch@motor-comm.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] Self-contradictory addressing in the new binding example: the
  package node is named `ethernet-phy-package@0`, carries `reg = <9>`,…
- [Medium] `phy-mode` is placed in `required` for the YT8824 PHY-package
  node…

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This adds a new binding for the Motorcomm YT8824, a package of four
Ethernet PHYs.  The schema references the common ethernet-phy-package.yaml
and requires compatible, phy-mode and reg.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 0000000000000..93e9f765404a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,59 @@

[ ... ]

> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorcomm,yt8824-package
> +
> +required:
> +  - compatible
> +  - phy-mode
> +  - reg

[Severity: Medium]
Is phy-mode defined anywhere in the schema chain that applies to this node?

The properties: block here defines only compatible.  The $ref'd
ethernet-phy-package.yaml defines only $nodename, reg, #address-cells,
#size-cells and the ^ethernet-phy@[a-f0-9]+$ children.  phy-mode is defined
by ethernet-controller.yaml:

  phy-mode:
    $ref: "#/properties/phy-connection-type"

which is a MAC-side binding and is not referenced here, so its enum never
applies to this package node.  Does that mean only the presence of phy-mode
is checked, and phy-mode = "sgmii" or even a non-string phy-mode = <0> would
pass make dt_binding_check for this compatible?

The driver added by the companion patch "net: phy: Add driver for Motorcomm
Quad 2.5GbE phy" accepts only two values in
yt8824_phy_package_probe_once():

  if (!of_property_read_string(np, "phy-mode", &interface_mode_name)) {
      if (!strcasecmp(interface_mode_name, phy_modes(PHY_INTERFACE_MODE_USXGMII))) ...
      else if (!strcasecmp(interface_mode_name, phy_modes(PHY_INTERFACE_MODE_INTERNAL))) ...
      else
          return -EINVAL;

so anything the unconstrained schema lets through fails probe with -EINVAL
and takes all four ports down.  Would it make sense to define the property
locally with an explicit type and the enum of modes the YT8824 supports?

For comparison, qcom,qca807x.yaml expresses the package-wide interface
setting as a locally defined and constrained vendor property:

  qcom,package-mode:
    $ref: /schemas/types.yaml#/definitions/string
    enum:
      - qsgmii
      - psgmii

and requires only compatible.

> +
> +unevaluatedProperties: false

[Severity: Low]
Does unevaluatedProperties: false have any effect here?  The referenced
ethernet-phy-package.yaml ends with additionalProperties: true, which looks
like it neutralises the restriction on property names for this node.

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
> +
> +            phy-mode = "internal";
> +
> +            ethernet-phy@4 {
> +                reg = <4>;
> +            };

[Severity: Medium]
Three different addresses appear for the same package in this example: the
unit address @0, reg = <9>, and member PHYs at 4, 5, 6 and 7.  Which one is
correct?

The unit address should match the first reg cell, so the node would be
ethernet-phy-package@9 if reg really is 9.

The referenced ethernet-phy-package.yaml describes reg as:

      The base ID number for the PHY package.
      Commonly the ID of the first PHY in the PHY package.

and says each member PHY reg is the absolute MDIO address.  With a base of 9
and members at 4-7, every member is at a negative offset from the base.  Can
phy_package_address() express that?

drivers/net/phy/phy_package.c:phy_package_address() {
    u8 base_addr = shared->base_addr;
    ...
    return base_addr + addr_offset;
}

There is also a runtime consequence for a board DT copied from this example.
of_phy_package_join() reads this reg into base_addr, and the YT8824 driver
from the companion patch does all package-global accesses at offset 0:

drivers/net/phy/motorcomm.c:ytphy_write_top_ext() {
    ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
    ...
}

so package-global configuration would be driven at MDIO address 9, outside
the 4-7 block the package occupies, and bus->shared[9] would collide with
any other package legitimately based at 9.

Note that dtc does not catch the mismatch: the unit_address_vs_reg check in
scripts/dtc/checks.c only verifies that a unit name and a reg are both
present or both absent, not that they match, and scripts/dtc/dt-check-style
only checks unit-address formatting.  The in-tree user of the same common
schema, qcom,qca807x.yaml, keeps all three consistent
(ethernet-phy-package@0, reg = <0>, first child ethernet-phy@0).

> +
> +            phy-mode = "internal";

[Severity: Low]
Is "internal" the intended value to document for an external package?
ethernet-controller.yaml describes internal as "There is not a standard bus
between the MAC and the PHY, something proprietary is being used to embed
the PHY in the MAC", which does not seem to describe a discrete 4-port PHY
package attached over MDIO.  Can a single package-level value describe the
four individual MAC-facing links?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912065224.2723883-1-kyle.switch%40motor-comm.com
