Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1434EC67C;
	Wed, 16 Sep 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561200; cv=none; b=ke3QAqZk1GhqIeQnkHOhsymNQoA7lFmyxPdfXhqJQfUIct+oMX3M2w2hx0PhLRg1CBPgKvHR3Xam1n46dxI2N1twc3eliGT66fy5HX9PPrt7oALFPvvQvIz91XbfT3FK/cE87s4+p8rJl21RLs5HGuO6lv3poKNuPIdA6z2FTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561200; c=relaxed/simple;
	bh=7YwXfIzsjoMjOKwvDCdQfphejDrDv6RQV+RiJWeOjDU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNsX9W9twUVRGa2YuZwB7d4MBw+bW5yoztXTGON+h/EH+oymv8B60KKtg5z9EqWfhM/kCCtLIsIW1xhBnam9qkIBPLDcRsYocJsrSq/7ie52MeA89FpG+MrMhGdJNBRdr+UUjbpOFVTj/tCEyltHnUrkzmytQA4ROPMSG8R1jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VETJ3404; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VETJ3404"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588BA1F000FF;
	Wed, 16 Sep 2026 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561198;
	bh=fEFhzHMPOvWbVMmoEUILoLP5Uzr9QE7En/pY6cDBeSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VETJ3404ZnXG12u1D26Ca2+XB8zTtwldgtksvFJ2Kjn7u1N0NC+CWdcTJu5V+X3F4
	 dStzW7ovl2Z3UWJOypGRErX5cAMtMadHbvOgtGJ50PmI5a7Qt78AuJo7ZXpt6jJ2iA
	 mf9BxlyFdC17517819knDAMxMgirrnaLiLMJimRS5GlVndwK1UX6GNx5fXacXjOzdc
	 exuXuCDgvodioicIU235GxKd3k5EsPwAk/9YeI27OtCWnCx2yxOp4uzw1RGonO+4pY
	 jFPUmEDyAK84nJ6lwe+z6tE2fGD65rmKpQFZpjYIr4QJ3WFEYAZbKQqwbvdTq3uRB/
	 s+8DRvBlxpkIQ==
Subject: Re: [PATCH v5 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 srherobrine20@gmail.com
Date: Wed, 16 Sep 2026 12:19:56 +0000
Message-ID: <178956119685.22033.3792668833363404378@kernel.org>
In-Reply-To: <20260915113427.113296-1-cjd@cjdns.fr>
References: <20260915113427.113296-1-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] The new MCM detection in en751221_is_mcm_phy()
  (drivers/net/phy/mediatek/mtk-ge.c:138-144) tests the MDIO bus *parent…
- [Medium] mt7530_is_gphy() (drivers/net/phy/mediatek/mtk-ge.c:150-154)
  masks the raw return value of phy_read(phydev, MII_ESTATUS) with…
- [Low] The commit subject reads "net: phy: mediatek: support MT7530 PHYs
  on EN71221 MCM" while the commit body, the new code…

--

net: phy: mediatek: support MT7530 PHYs on EN71221 MCM

This adds a second phy_driver entry for MTK_GPHY_ID_MT7530 with an extra
register sequence for the EcoNet EN751221 multi-chip module, selects
between the two entries with new match_phy_device callbacks, and skips
MT7530-ID PHYs that report no gigabit support.

> net: phy: mediatek: support MT7530 PHYs on EN71221 MCM

[Severity: Low]
This isn't a bug, but the subject says EN71221 while the body, the code
(en751221_is_mcm_phy(), en751221_mcm_phy_config_init(), the driver name
"EcoNet EN751221 MCM PHY"), the compatible "econet,en751221" and every
other in-tree reference say EN751221.  Grepping the tree finds no
EN71221 identifier at all.

> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> index 96d8ac5154e5e..eddb66218d7c0 100644
> --- a/drivers/net/phy/mediatek/mtk-ge.c
> +++ b/drivers/net/phy/mediatek/mtk-ge.c

[ ... ]

> @@ -101,6 +102,69 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/*
> + * The EcoNet EN751221 "G" multi-chip module MT7530 requires additional PHY
> + * configuration.
> + */
> +static int en751221_mcm_phy_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_soft_reset(phydev);
> +	if (ret)
> +		return ret;

[ ... ]

> +static bool en751221_is_mcm_phy(struct phy_device *phydev)
> +{
> +	struct device *parent = phydev->mdio.bus->parent;
> +
> +	return parent && parent->of_node &&
> +	       of_device_is_compatible(parent->of_node, "econet,en751221");
> +}

[Severity: High]
Can this predicate ever return true?

"econet,en751221" is documented only as a machine compatible on the DT
root node:

Documentation/devicetree/bindings/mips/econet.yaml
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

and the only in-tree users put it on '/':

arch/mips/boot/dts/econet/en751221.dtsi
  / {
        compatible = "econet,en751221";

arch/mips/boot/dts/econet/en751221_smartfiber_xp8421-b.dts
  / {
        model = "SmartFiber XP8421-B";
        compatible = "smartfiber,xp8421-b", "econet,en751221";

The node handed to of_device_is_compatible() here is the MDIO bus parent
device, which for MT7530-internal PHYs is the switch device:

drivers/net/dsa/mt7530.c:mt7530_setup_mdio() {
    ...
	bus->parent = dev;
    ...
}

of_device_is_compatible() only inspects the compatible list of the node it
is given, so a switch node that is a child of '/' will not match a root
node compatible.  Does that make en751221_phy_match() always return zero,
leaving the new "EcoNet EN751221 MCM PHY" entry and
en751221_mcm_phy_config_init() unreachable, with mt7530_phy_match()
binding the plain MT7530 entry on the MCM hardware instead?

Would matching the switch's own compatible work better here?  The EcoNet
MCM switch already has one in-tree:

drivers/net/dsa/mt7530-mmio.c
  { .compatible = "econet,en7528-switch", .data = &mt753x_table[ID_EN7528], },

Alternatively, of_machine_is_compatible("econet,en751221") would test the
root node, or a new documented compatible for the MCM switch/MDIO node
could be added.

> +
> +/*
> + * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
> + * does not advertise ESTATUS_1000_TFULL.
> + */
> +static bool mt7530_is_gphy(struct phy_device *phydev)
> +{
> +	return phydev->phy_id == MTK_GPHY_ID_MT7530 &&
> +	       (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0;
> +}

[Severity: Medium]
Should the phy_read() return value be checked for an error before it is
masked?

ESTATUS_1000_TFULL is 0x2000, i.e. bit 13, and every small negative errno
has bit 13 set in two's complement (-EIO is 0xfffffffb, -ETIMEDOUT is
0xffffff92).  So a failed MDIO read makes mt7530_is_gphy() report
"gigabit capable", which is the opposite of the intended exclusion of the
FE PHY that shares MTK_GPHY_ID_MT7530.

phy_bus_match() returns the callback result verbatim:

drivers/net/phy/phy_device.c:phy_bus_match() {
    ...
	if (phydrv->match_phy_device)
		return phydrv->match_phy_device(phydev, phydrv);
    ...
}

so on a transient bus error the FE PHY would be claimed and programmed
with the GbE sequence in en751221_mcm_phy_config_init() (paged write of
0x3a04, MMD VEND2 0x0417, VEND1 0xa6 and 0x12) or mt7530_phy_config_init().

Should MII_ESTATUS also be gated on BMSR_ESTATEN, the way phylib does it
elsewhere?

drivers/net/phy/phy_device.c:genphy_read_abilities() {
    ...
	if (val & BMSR_ESTATEN) {
		val = phy_read(phydev, MII_ESTATUS);
		if (val < 0)
			return val;
    ...
}

Without that check, the value read from register 15 on a PHY that does not
implement it is not defined by Clause 22.

> +
> +static int mt7530_phy_match(struct phy_device *phydev,
> +			    const struct phy_driver *phydrv)
> +{
> +	return mt7530_is_gphy(phydev) && !en751221_is_mcm_phy(phydev);
> +}
> +
> +static int en751221_phy_match(struct phy_device *phydev,
> +			      const struct phy_driver *phydrv)
> +{
> +	return mt7530_is_gphy(phydev) && en751221_is_mcm_phy(phydev);
> +}
> +
>  static int mt7531_phy_config_init(struct phy_device *phydev)
>  {
>  	mtk_gephy_config_init(phydev);
> @@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
>  		 */
>  		.config_intr	= genphy_no_config_intr,
>  		.handle_interrupt = genphy_handle_interrupt_no_ack,
> +		.match_phy_device = mt7530_phy_match,
> +		.suspend	= genphy_suspend,
> +		.resume		= genphy_resume,
> +		.read_page	= mtk_phy_read_page,
> +		.write_page	= mtk_phy_write_page,
> +	},
> +	{
> +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
> +		.name		= "EcoNet EN751221 MCM PHY",
> +		.probe		= mt7530_phy_probe,
> +		.config_init	= en751221_mcm_phy_config_init,
> +		/* Interrupts are handled by the switch, not the PHY
> +		 * itself.
> +		 */
> +		.config_intr	= genphy_no_config_intr,
> +		.handle_interrupt = genphy_handle_interrupt_no_ack,
> +		.match_phy_device = en751221_phy_match,
>  		.suspend	= genphy_suspend,
>  		.resume		= genphy_resume,
>  		.read_page	= mtk_phy_read_page,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915113427.113296-1-cjd%40cjdns.fr
