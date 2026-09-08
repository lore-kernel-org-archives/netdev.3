Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E8468C09;
	Tue,  8 Sep 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856260; cv=none; b=n72fsOvFc9LAq8r0zxo9pjzPMsYjZkTQT9vFfaIBxzWHoRPEm15dqV8wrzWVIYVHGxiOsku6/gbClrcUV+PDK4EvI7zS8f9dR2Zv0+gv925GhYdcr58kkr+yp5jMQgF9shp4nSB3FZuTrM5+/JZRKVXfWnk9XL2/TLQiShYZaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856260; c=relaxed/simple;
	bh=Ku8ObEGbi1/RcpYIfDLxWFtsKveccfSQO5nuLAH26qk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6k4A0tRRTwY3fpce6FBbML/NltfkXMFVcG+xGHlMA+EK3GjMyBX1aAaRPVR09HlTyZobS523297PwkqAUYzRQ/m+lnwjXeAW/t9aLvQGzcgJ3mKlFfFJ9hJZwq113OVKbcz2v4FP3h4KEkMIkDXQzfjEqyKcbWzTdMhTzOIjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHyAKrYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHyAKrYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC081F00A3A;
	Tue,  8 Sep 2026 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856258;
	bh=XRyoCgDmBInYuoL+EEo9VItygSlD5zki+crpNhx0V/M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aHyAKrYaWMjznjzNlsUJmc5ukzaoOS6Xv2gpvMGd/2Op9BHteSDDkSSl/CZvyTNxE
	 B+UDWFpQeAYADTggfc266BLePQeFe0BimBU74DQzHN3R5VsmqCLFMGjnxxRjpH0T6C
	 PSRx54LVkSx0K8CHbihFNoQcrztC+7697PmhPuXAXMHZ1EpD/mcNiNk3Nmd9+6OTze
	 bQlUBCI37Qz3CRUIeitpxSL7AHKwp9OeCbgRS68djkMwQ3QTi0hR2gF1lvVUDrUusa
	 /Z8uWk1J3vRVqhakH9NEDGinScyXi0Z+WFEYC9A+eTgv/stZs3i8qtziZfqtL3GOo9
	 2TdZiIk1r/lOg==
Subject:
 Re: [PATCH net v3] net: phy: mediatek-ge: disable EEE on the MT7530 PHY
From: netdev-bot+sashiko@kernel.org
To: vladislav.karmanov.dev@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, daniel@makrotopia.org,
 dqfext@gmail.com, SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 sean.wang@mediatek.com, olteanv@gmail.com, yangshiji66@outlook.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 08 Sep 2026 08:30:57 +0000
Message-ID: <178885625700.219967.7168072838761125406@kernel.org>
In-Reply-To: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
References: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] mt7530_phy_probe() (drivers/net/phy/mediatek/mtk-ge.c:65-84)
  calls phy_disable_eee() from the driver's .probe callback, but phylib…
- [Medium] The hardware write that clears the EEE advertisement,
  phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0) at…

--

net: phy: mediatek-ge: disable EEE on the MT7530 PHY

This adds an mt7530_phy_probe() callback to the mediatek-ge driver which
clears MDIO_AN_EEE_ADV in hardware and then calls phy_disable_eee(), with
the stated goal that neither phylib nor userspace can re-enable EEE on the
MT7530 internal GE PHY.

> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> index 73d9b72f9d9e2..35600c70cab90 100644
> --- a/drivers/net/phy/mediatek/mtk-ge.c
> +++ b/drivers/net/phy/mediatek/mtk-ge.c
> @@ -62,6 +62,27 @@ static void mtk_gephy_config_init(struct phy_device *phydev)
>  		       FIELD_PREP(MTK_MCC_NEARECHO_OFFSET_MASK, 0x3));
>  }
>  
> +static int mt7530_phy_probe(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* The MT7530 internal GE PHY has broken EEE: with EEE advertised,
> +	 * some link partners fail to establish a stable link (on a 2-pair
> +	 * cable, 1000BASE-T training fails and the port loops instead of
> +	 * falling back). MediaTek recommends disabling EEE on this PHY.
> +	 * Clear the EEE advertisement early and mark EEE disabled, so
> +	 * that neither phylib nor userspace can re-enable it.
> +	 */
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Should this register write also live in mt7530_phy_config_init()?  This is
the only place where MDIO_AN_EEE_ADV is cleared in hardware, and ->probe is
the one callback phylib never replays.  phy_init_hw() deasserts the reset
line, optionally soft-resets, and then re-runs only ->config_init and
->config_intr:

drivers/net/phy/phy_device.c:phy_init_hw() {
	...
	if (phydev->drv->config_init) {
		ret = phydev->drv->config_init(phydev);
		if (ret < 0)
			return ret;
	}
	...
}

mt7530_phy_config_init() does not touch MDIO_AN_EEE_ADV, so after a PHY
register reset the register is back at its EEE-advertising hardware default
while phydev->advertising_eee stays empty and eee_cfg.eee_enabled stays
false, i.e. software and hardware state disagree.

Two paths that re-init without ->probe:

  - phy_detach() asserts the PHY reset signal and a later
    phy_attach_direct() -> phy_init_hw() only replays config_init.
  - the SIOCSMIIREG BMCR_RESET case in phy_mii_ioctl():

drivers/net/phy/phy.c:phy_mii_ioctl() {
	...
		if (prtad == phydev->mdio.addr &&
		    devad == MII_BMCR &&
		    val & BMCR_RESET)
			return phy_init_hw(phydev);
	...
}

which returns without any aneg reconfiguration, so nothing rewrites the
advertisement to zero.  __genphy_config_aneg() ->
genphy_c45_an_config_eee_aneg() covers the usual renegotiation case, but it
returns early without writing when phydev->autoneg == AUTONEG_DISABLE.  The
equivalent in-tree quirk issues the disable from the replayed callback,
dp83867_config_init() -> phy_disable_eee().

> +
> +	phy_disable_eee(phydev);

[Severity: High]
Does the phy_disable_eee() state survive the rest of phy_probe()?  The
linkmode_fill(phydev->eee_disabled_modes) done inside phy_disable_eee() is
what makes the disable permanent, but phylib clears that set later in the
same probe flow:

drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (phydev->drv->probe) {
		err = phydev->drv->probe(phydev);
	...
	/* Get the EEE modes we want to prohibit. */
	of_set_phy_eee_broken(phydev);
	...
}

drivers/net/phy/phy-core.c:of_set_phy_eee_broken() {
	struct device_node *node = phydev->mdio.dev.of_node;
	unsigned long *modes = phydev->eee_disabled_modes;

	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
		return;

	linkmode_zero(modes);
	...
}

So for any MT7530 PHY that has an of_node, eee_disabled_modes ends up empty
again unless the DT carries eee-broken-* properties.  An of_node is present
in a documented configuration: mt7530_setup_mdio() registers the internal
bus with the switch's "mdio" child node,

drivers/net/dsa/mt7530.c:mt7530_setup_mdio() {
	...
	mnp = of_get_child_by_name(np, "mdio");
	...
	ret = devm_of_mdiobus_register(dev, bus, mnp);
	...
}

and mediatek,mt7530.yaml documents that node, so ethernet-phy children
described there get an of_node.

With eee_disabled_modes empty, can userspace re-enable EEE again through
dsa_user_set_eee() -> phylink_ethtool_set_eee() -> phy_ethtool_set_eee() ->
genphy_c45_ethtool_set_eee()?

drivers/net/phy/phy-c45.c:genphy_c45_ethtool_set_eee() {
	...
		} else if (linkmode_empty(phydev->advertising_eee)) {
			phy_advertise_eee_all(phydev);
		}
	...
}

That repopulates advertising_eee with supported_eee, then
genphy_c45_an_config_eee_aneg() rewrites MDIO_AN_EEE_ADV and
phy_restart_aneg() renegotiates, which looks like it brings back exactly the
1000BASE-T training loop described in the commit message.

Would moving the disable into mt7530_phy_config_init(), which runs after
of_set_phy_eee_broken(), address both this and the reset case above?  That
is the placement dp83867_config_init() uses for the same kind of quirk.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904202800.3410838-1-vladislav.karmanov.dev%40gmail.com
