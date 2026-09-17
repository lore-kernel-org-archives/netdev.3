Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2B40B0EC;
	Thu, 17 Sep 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678205; cv=none; b=PU43jNGUcB+3251kmYqTCN3rq4cgXpLaXChF0n4ND0OVoR0/Zl0GVJBBR1iJ38TLrglMKVN05drWSKZc26TrzLnhVhmk92zKMXxVdsouvW47eORkLGXFrWnGDEwVyYmQeCAr7zLYvCrOiJ5H/hDjJNWmcfpUoNZ2C4Uduww4QQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678205; c=relaxed/simple;
	bh=tATHDU3HrcesJEJqzIqEMQQbVjuF5L06ze10pOunSWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZwl5VYwsbsbEKpzVi5buD3FRFMCMaY8DSmH5gGVHgixZPma6J13ZXi7P4ckM27iRJ/TRHLtKW27rqOMg6nde7WXM5Tp5yepOAondcTbzwvePaU9Bpg5/pbSNNe9BVa/Yb12X8aZGfobeovepp29iCrfH4K2MQRalYph8Ght4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsti3UDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsti3UDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2641F000FF;
	Thu, 17 Sep 2026 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678202;
	bh=9SgyiGf32A0qCeIe4MMlsFd2r4nEIcNL3uAUmFwBb1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xsti3UDiKxUYtVjuLq32KnFTerEA7bHL/81vPf1hPanNvpBkZXOmKU0kPDfZR4DkF
	 K6RsPWcez5NDlVLMlsEQ0d9RD8ZbWxJ2PCqwvjk3TcwehBzr+PkILT0zcgBqbtPJ07
	 yYlCVkzzfHcG8l7ymzSVKfsS2XO280M0GtsRdD1ZdT9gOls3a2StanaPi8xoLYq1Nb
	 m2wc/IVaaEoRh8vhAYXTX63uccp/P4MBB/oP/6avUmvLB94bawkmtizwqHbTrTV77l
	 R9FyiWgctkZbWfKgxOO2TZK6BLQg7DtveMPj05YJ+gbFZ/GDWXE2N3JEsJy/kVQnAn
	 IZcw9+8v7ybvw==
Subject: Re: [PATCH v2 net-next 6/7] dt-bindings: net: dsa: mediatek,mt7530:
 add econet,en751221
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 17 Sep 2026 20:50:00 +0000
Message-ID: <178967820050.22033.18093714968849770785@kernel.org>
In-Reply-To: <20260915174643.253660-7-cjd@cjdns.fr>
References: <20260915174643.253660-7-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 · Low: 2

- [High] net: dsa: lockless child_bus access causes MDIO race condition
- [Medium] The new switch-device compatible `econet,en751221`
  (mediatek,mt7530.yaml line 126) is the identical string already…
- [Medium] The new `econet,en751221` conditional (mediatek,mt7530.yaml
  lines 369-377) applies only `$ref: "#/$defs/mt7530-passthrough-dsa-…
- [Medium] The series patch "net: dsa: mediatek: support MDIO switch
  downstream of MMIO switch" moved `mt7530_setup_mdio_irq()` out of…
- [Medium] In passthrough mode `mt753x_cpu_port_enable()` (added by the
  series patch "net: dsa: mediatek: add support for passthrough mode")…
- [Low] The paragraph added to the binding description
  (mediatek,mt7530.yaml lines 32-36) states that "EcoNet EN751221 SoCs…
- [Low] Concern that neither `econet,en751221-switch` nor
  `econet,en751221` has any consumer: at this commit…

--

dt-bindings: net: dsa: mediatek,mt7530: add econet,en751221

This adds two compatible strings to the MT7530 binding: econet,en751221-switch
for the memory mapped switch built into the EcoNet EN751221 SoC, and
econet,en751221 for the MT7530 multi-chip module that some EN751221 packages
attach to port 5 of the on-die switch via TRGMII. A new $defs block constrains
the DSA link port of the multi-chip module.

A few questions on the schema below, plus two observations about other
patches in the same series.

> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index e29fb86934981..106c4087528d7 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -29,6 +29,12 @@ description: |
>    and the switch registers are directly mapped into SoC's memory map rather than
>    using MDIO. The DSA driver currently doesn't support MT7620 variants.
>  
> +  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
                                                          ^^^^

[Severity: Low]
Should this be 4x 10/100 PHYs?  The commit message of this patch says
"ports 0..3 are 10/100 only, port 4 has a gigabit PHY", which is four fast
ethernet PHYs, and en751221_mac_port_get_caps() in the later driver patch of
this series agrees:

	/* EN751221 ports 0..3 are connected to the integrated FE PHYs. */
	case 0 ... 3:
		__set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
		config->mac_capabilities |= MAC_10 | MAC_100;

Since there is no in-tree EN751221 switch DTS yet, this paragraph is the only
port reference a DT author has.

> +  gigabit PHY. Some EN751221 chips such as EN7513G and EN7526G have a multi-chip
> +  module implementation of the MT7530 as well as the on-die switch. In these
> +  packages, the multi-chip module is connected to port 5 of the on-die switch
> +  via a TRGMII link.
> +
>    There is only the standalone version of MT7531.
>  
>    Port 5 on MT7530 supports various configurations:
> @@ -111,6 +117,14 @@ properties:
>            Built-in switch of the EcoNet EN7528 SoC
>          const: econet,en7528-switch
>  
> +      - description:
> +          Built-in switch of EcoNet EN751221 SoC
> +        const: econet,en751221-switch
> +
> +      - description:
> +          Multi-chip module MT7530 in EN751221 SoC
> +        const: econet,en751221

[Severity: Medium]
Can this string collide with the existing SoC compatible?  econet,en751221 is
already documented as the EN751221 root node compatible in
Documentation/devicetree/bindings/mips/econet.yaml:

  properties:
    $nodename:
      const: '/'

    compatible:
      oneOf:
        - description: Boards with EcoNet EN751221 family SoC
          items:
            - enum:
                - smartfiber,xp8421-b
            - const: econet,en751221

and arch/mips/boot/dts/econet/en751221.dtsi uses it on the root node:

  / {
	compatible = "econet,en751221";

dtschema derives the select clause of a binding from the strings enumerated
under properties:compatible, so after this patch mediatek,mt7530.yaml is also
selected for that root node.  The switch schema has required: [compatible,
reg], unevaluatedProperties: false, and via the new conditional below also
required: [mediatek,mcm] (which in turn pulls in resets and reset-names).  Does
make dtbs_check on arch/mips/boot/dts/econet/en751221_smartfiber_xp8421-b.dtb
now report the root node as an invalid MT7530 switch node?

The reverse direction looks affected too: a switch@... node carrying
compatible = "econet,en751221" is selected by mips/econet.yaml and fails its
$nodename: const: '/' and its two-entry board/SoC compatible list.

The analogous MT7621 case does not collide because the SoC root uses
mediatek,mt7621-soc.  Since the SoC compatible is already released, would a
distinct string for the switch, e.g. econet,en751221-mcm-switch, work here?

> +
>    reg:
>      maxItems: 1
>  

[ ... ]

> @@ -223,6 +237,20 @@ $defs:
>                  phy-mode:
>                    const: internal
>  
> +  mt7530-passthrough-dsa-port:
> +    patternProperties:
> +      "^(ethernet-)?ports$":
> +        patternProperties:
> +          "^(ethernet-)?port@[0-6]$":
> +            if:
> +              required: [ link ]
> +            then:
> +              properties:
> +                reg:
> +                  const: 6
> +                phy-mode:
> +                  const: trgmii
> +
>    mt7530-dsa-port:
>      patternProperties:
>        "^(ethernet-)?ports$":
> @@ -330,6 +358,7 @@ allOf:
>              - airoha,en7581-switch
>              - airoha,an7583-switch
>              - econet,en7528-switch
> +            - econet,en751221-switch
>      then:
>        $ref: "#/$defs/builtin-dsa-port"
>        properties:
> @@ -337,6 +366,16 @@ allOf:
>          mediatek,mcm: false
>          reset-names: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - econet,en751221
> +    then:
> +      $ref: "#/$defs/mt7530-passthrough-dsa-port"
> +      required:
> +        - mediatek,mcm

[Severity: High]
One more observation about another patch in this series, so there is
no hunk to quote for it either.

In "net: dsa: mediatek: support PLL setup on MMIO MT7530", is the MDIO
bus lock lost for the new child_bus path?  core_write() and core_rmw()
now do:

	if (!bus)
		bus = priv->child_bus;

	if (WARN_ON_ONCE(!bus))
		return;

	mt7530_mutex_lock(priv);

	/* Write the desired MMD Devad */
	ret = bus->write(bus, ctl_phy, MII_MMD_CTRL, MDIO_MMD_VEND2);

but mt7530_mutex_lock() only knows about priv->bus:

	if (priv->bus)
		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);

On an MMIO switch priv->bus is NULL, so the guard makes
mt7530_mutex_lock()/mt7530_mutex_unlock() a no-op while the following
bus->write()/bus->read() calls are raw driver callbacks issued on
child_bus without child_bus->mdio_lock held.  The indirect MMD sequence
(MII_MMD_CTRL devad, MII_MMD_DATA address, then the data phase) is not
atomic on the wire, so a concurrent mdiobus_read()/mdiobus_write() on
the same child bus - phylib polling the downstream MT7530 PHYs, or a
regmap access from the mt7530 MDIO path - can interleave and leave the
MMD devad/address latch pointing somewhere else, giving a read or write
to the wrong core register.  This is reachable from mt7530_setup_port6()
and the PLL setup path whenever a port changes state, i.e. during normal
operation, and the missing lock is invisible to lockdep because nothing
is taken at all.

Should mt7530_mutex_lock()/mt7530_mutex_unlock() fall back to
priv->child_bus->mdio_lock the same way core_write()/core_rmw() do, or
would it be cleaner for the child_bus path to call mdiobus_write()/
mdiobus_read() (which take the lock themselves) instead of the raw
bus->write()/bus->read() callbacks?  Either way the two places that
pick the bus should agree on which lock protects it.

[Severity: Medium]
Are the MT7530 per-port interface-mode constraints intentionally dropped for
this compatible?  The commit message says the multi-chip module "is similar to
the MT7621 multi-chip module", and the mediatek,mt7621 conditional in the same
allOf applies:

      $ref: "#/$defs/mt7530-dsa-port"
      required:
        - mediatek,mcm

A JSON-Schema object can only carry one $ref, so referencing
mt7530-passthrough-dsa-port here means $defs/mt7530-dsa-port (port 5:
gmii/mii/rgmii, other ports: rgmii/trgmii) is never evaluated.  A DT giving
this multi-chip module an ethernet (CPU) port with phy-mode = "sgmii",
"2500base-x" or "internal" would then pass dtbs_check and only fail later in
mt7530_mac_config()/phylink.

Related to that, the new $defs/mt7530-passthrough-dsa-port rule is gated on:

            if:
              required: [ link ]

so a node with no DSA link port gets no port validation at all, and ports
carrying ethernet are unconstrained.

On the on-die side, econet,en751221-switch is only added to the builtin enum,
whose $defs/builtin-dsa-port rule keys off required: [ ethernet ].  Nothing
pins the cascade port to port 5 with trgmii as the added description states, so
link can be declared on port@0..port@4, which en751221_mac_port_get_caps()
wires to the internal FE/GE PHYs and which offers TRGMII on port 5 only.

Should an example be added for the new on-die plus multi-chip module topology?
Without one, the new $def, the required mediatek,mcm and the implied
resets/reset-names combination are never exercised by dt_binding_check.

> +
>  unevaluatedProperties: false
>  
>  examples:

Two further observations concern other patches in the same series, so there are
no hunks to quote here.

[Severity: Medium]
In "net: dsa: mediatek: support MDIO switch downstream of MMIO switch", is the
new call site of mt7530_setup_mdio_irq() too late?  It used to run inside
mt7530_setup_mdio() before devm_of_mdiobus_register(), and now runs in
mt753x_setup() after mt7530_setup_mdio() has returned:

	ret = mt7530_setup_mdio(priv);
	if (ret)
		return ret;

	if (priv->irq_domain && ds->user_mii_bus)
		mt7530_setup_mdio_irq(priv);

Bus registration creates the phy_devices, and phy_device_create() copies the
IRQ once at creation time:

	dev->irq = bus->irq[addr];

mdiobus_alloc_size() pre-fills bus->irq[i] = PHY_POLL, so the internal PHYs are
created with phydev->irq == PHY_POLL and the later
ds->user_mii_bus->irq[p] = irq_create_mapping(...) writes an array that is not
read again.  Does this leave every MT7530/MT7531 board that declares
interrupt-controller on the switch node and has no mdio child node (binding
examples 3 to 7, MT7621 boards) on polled link detection instead of the
switch PHY link-change interrupt?  The ordering is unchanged at the end of the
series.

[Severity: Medium]
In "net: dsa: mediatek: add support for passthrough mode", is the egress tag
setting for the upstream port immediately overwritten?
mt753x_cpu_port_enable() programs:

	if (priv->is_passthrough) {
		/* Disable parsing of the DSA tag ... */
		regmap_write(priv->regmap, MT7530_PVC_P(port),
			     VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
			     PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));

but both callers, mt7530_setup() and mt7531_setup_common(), do this in the same
loop iteration right after the call:

		if (dsa_is_upstream_port(ds, i)) {
			mt753x_cpu_port_enable(ds, i);
		} else {
			...
		}
		/* Enable consistent egress tag */
		regmap_update_bits(priv->regmap, MT7530_PVC_P(i),
				   PVC_EG_TAG_MASK,
				   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));

MT7530_VLAN_EG_DISABLED is 0 and MT7530_VLAN_EG_CONSISTENT is 1 in
drivers/net/dsa/mt7530.h, so the field really changes.  The downstream DSA link
port is re-programmed to PVC_EG_TAG(MT7530_VLAN_EG_DISABLED) later in
mt7530_port_enable(), but with priv->is_passthrough set the upstream port takes
neither the user port branch nor the dsa_port_is_dsa(dp) && dp->index !=
upstream_pt branch there, so there is no later write for it.  Is the write in
mt753x_cpu_port_enable() then dead, or should the EG_CONSISTENT update be
skipped for the upstream port in passthrough mode?  The commit message of that
patch states both ports end up at MT7530_VLAN_EG_DISABLED.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915174643.253660-1-cjd%40cjdns.fr
