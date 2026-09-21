Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB349DBB7;
	Mon, 21 Sep 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996682; cv=none; b=Zoqd7GZBWC2S3wf23rz8JC14vV98PuuTODOt3YuCGmyTTSOu2CxUCKJn0hPrP516m7gy/jBqXzuHviA4Ymi8vTYD+k/783cMbKHiiQK46JIuyXjA+eA5h6Iv6pMmPUVuJd6Snib9e98T28DZBklrG0ggFRIEKNCAJfAGNmC7wPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996682; c=relaxed/simple;
	bh=o/r83dZ76tmwYyr0ledevPcV8QHUrw91z3jV74RcwOE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUJI7pzSnT/hLk5bou5DFps1CllgkEfE2kFv16pxr6vKbSg0DDXyia721GuSe6T31qVRRqe4lRbJF8Yf5s97xR0zRyWSHPuGtxgbaKxeU22OVZiuSqLqkonC4M/UNYU7RDvwaYsLu3w3VoI2q6Bd6YriZ/AtV7aKYTX1Pi/yaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhv3qZTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhv3qZTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7241F000FF;
	Mon, 21 Sep 2026 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996680;
	bh=XebRR2z/pZVczwWi4MObmcPweWeJ/0Wcn3jiq8o9P+o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mhv3qZTfMjV9qv9AbofIM6JxZ64mSmm1Efyn+r4HW7ayPCAUwsbmrpkMBytzlgVkZ
	 mS0ibSM6VRTOvoqXtE8po0G6zSKFMkeVQ0tPaGuU0p8FazYUvYlWhfT5j/ZHM/S7Yg
	 VldFkmHCGsQYox47PtvmKxEly6S931fsFGkkMfe4G2uG0xzOxifBtdnNfwKYLwAO7n
	 uP5MWHhNrHW5CoDnYtYKnnNUHUPRC2+TJCQ12q9uJsHFpdr+GgJTTkG5d0rtnNZryR
	 cDSkKrsXJ2uoGgOS9j3UO0wUDDAecmrROcSjcNlrz5Aw+excmSiv4EU+qjk9RZL/B1
	 40j+/fQYcN4eg==
Subject: Re: [PATCH net-next v20 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Date: Mon, 21 Sep 2026 13:17:58 +0000
Message-ID: <178999667872.2160803.17632200084783672911@kernel.org>
In-Reply-To: <20260917131441.3428554-4-kyle.switch@motor-comm.com>
References: <20260917131441.3428554-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The YT8824 driver silently redefines the meaning of the PHY-
  package 'reg' property: ytphy_read_top_ext()/ytphy_write_top_ext()…
- [Medium] yt8824_phy_package_probe_once() takes the PHY-to-MAC interface
  mode exclusively from a new 'phy-mode' property on the PHY *package*…
- [Medium] yt8824_config_aneg() programs the 2.5G advertisement
  (MDIO_AN_10GBT_CTRL_ADV2_5G) solely from phydev->advertising, ignoring…
- [Medium] yt8824_read_status_paged() unconditionally overwrites the link
  state computed by genphy_read_status() with the current vendor…
- [Medium] yt8824_probe() consumes the package one-shot flag
  (phy_package_probe_once() is a bare test_and_set_bit()) before running…
- [Medium] The package-shared mutex priv->shared_lock and
  priv->interface_mode are initialized inside…
- [Low] Concern (assessed FALSE POSITIVE): 'YT8824 support is advertised
  without disclosing that the driver can only bind from an ethernet-phy-…
- [Low] The YT8824 binding example names the package node 'ethernet-phy-
  package@0' while declaring 'reg = <9>'.
- [Low] yt8824_read_status_paged() calls genphy_c45_read_lpa() whenever
  phydev->autoneg_complete is set (without requiring phydev->autoneg ==…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

Adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the existing
motorcomm driver.  The shared "Common Top Extended" register block is
reached through the phy_package helpers, and a package-shared mutex plus a
package-level phy-mode property drive the internal/usxgmii init paths.

A few questions below about the register-space addressing, the interface
mode source, the read_status/config_aneg paths and the package probe
sequencing.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..7ab09666ab3f4 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -399,6 +425,12 @@ struct yt8521_priv {
>  	u8 reg_page;
>  };
>  
> +struct yt8824_shared_priv {
> +	phy_interface_t interface_mode;
> +	/* shared_lock used to UTPs operation isolation during swap reg space */
> +	struct mutex shared_lock;
> +};
> +

[ ... ]

> @@ -437,6 +469,78 @@ static int ytphy_read_ext_with_lock(struct phy_device *phydev, u16 regnum)
> +/**
> + * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
> + * @phydev: a pointer to a &struct phy_device
> + * @regnum: register number to read
> + *
> + * Returns: the value of regnum reg or negative error code
> + */
> +static int ytphy_read_top_ext(struct phy_device *phydev, u16 regnum)
> +{
> +	int ret;
> +
> +	/*
> +	 * The package base address is used here to read the top ext registers.
> +	 * For example, in internal mode, the top ext address is fixed at 9;
> +	 * for usxgmii, the offset is 4. Instead of using the offset approach
> +	 * a fixed address is used here to avoid situations such as when phy0
> +	 * is not in use, where the top ext register address cannot be obtained
> +	 * correctly.
> +	 */
> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_package_read(phydev, 0, YTPHY_PAGE_DATA);
> +}

[Severity: Medium]
This uses package offset 0, so the address used for the top extended block
is whatever of_phy_package_join() took verbatim from the package node:

drivers/net/phy/phy_package.c:of_phy_package_join() {
	...
	if (of_property_read_u32(package_node, "reg", &base_addr))
	...
}

Documentation/devicetree/bindings/net/ethernet-phy-package.yaml describes
that property as:

  reg:
    minimum: 0
    maximum: 31
    description:
      The base ID number for the PHY package.
      Commonly the ID of the first PHY in the PHY package.

The new motorcomm,yt8824.yaml lists reg as required but does not re-describe
or constrain it, while the comment above states the hardware requirement
(address 9 in internal mode, first PHY + 4 for usxgmii).

If a device tree follows the documented meaning and sets reg to the address
of the first PHY, do ytphy_read_top_ext()/ytphy_write_top_ext() then write
YTPHY_PAGE_SELECT/YTPHY_PAGE_DATA (0x1e/0x1f) into an unrelated sibling PHY?
That would make every page switch through yt8824_read_page(),
yt8824_write_page() and phy8824_page_write_with_lock() silently ineffective
while clobbering another port's extended registers, and the efuse reads in
yt8824_extern_config_sds_init_paged() would come from the wrong device.

Should the binding document and constrain reg for this device, or should the
driver derive the top extended address rather than assuming package offset 0?

[ ... ]

> @@ -622,15 +726,1045 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

[ ... ]

> +static int yt8824_config_init(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_internal_config_init_paged(phydev);
>  		if (ret < 0)
> -			goto err_restore_page;
> +			goto err;
> +	} else {
> +		ret = yt8824_extern_config_sds_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
> +		ret = yt8824_extern_config_utp_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
>  	}
> +	mutex_unlock(&priv->shared_lock);
> +	ret = yt8824_soft_reset(phydev);

[Severity: Medium]
This branch, and the same test in yt8824_soft_reset(), yt8824_power_on(),
yt8824_power_down() and yt8824_restore_working_status(), uses only
priv->interface_mode, which comes from a new phy-mode property on the PHY
package node.  phydev->interface is never consulted, even though phylib has
already resolved it per port from the MAC's phy-mode/phy-connection-type by
the time config_init runs.

Can these two descriptions of the same link disagree?  A device tree whose
MAC node says usxgmii while the package node says internal would run
yt8824_internal_config_init_paged() and skip the SerDes isolate/soft-reset
sequences in soft_reset/resume/suspend, with config_init still returning 0
and no diagnostic.

Also, the new property is per-package while phydev->interface is per-port, so
a per-port difference cannot be expressed at all.  Since this adds a new DT
ABI that duplicates information phylib already has (qca807x used a
vendor-specific qcom,package-mode property instead), would using
phydev->interface here work?

[ ... ]

> @@ -3104,6 +4238,426 @@ static int yt8821_resume(struct phy_device *phydev)

[ ... ]

> +static int yt8824_read_status_paged(struct phy_device *phydev)
> +{
> +	int link = 0;
> +	int ret = 0;
> +	int val = 0;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (phydev->autoneg_complete) {
> +		ret = genphy_c45_read_lpa(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Low]
This tests only phydev->autoneg_complete, not phydev->autoneg.  With
"ethtool -s ethX autoneg off speed 1000 duplex full", clause 22
autonegotiation is still running (genphy_check_and_restart_aneg() leaves
ANENABLE set), so BMSR_ANEGCOMPLETE and therefore autoneg_complete become 1
while phydev->autoneg is AUTONEG_DISABLE.

genphy_read_status() deliberately clears the pause state for that case:

drivers/net/phy/phy_device.c:genphy_read_status() {
	...
	phydev->pause = false;
	phydev->asym_pause = false;
	...
	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
		phy_resolve_aneg_linkmode(phydev);
	else if (phydev->autoneg == AUTONEG_DISABLE)
		err = genphy_read_status_fixed(phydev);
	...
}

genphy_c45_read_lpa() then sets phydev->pause from LPA_PAUSE_CAP again.
Should the call be gated on phydev->autoneg == AUTONEG_ENABLE too?

> +
> +	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = ret;
> +
> +	link = val & YTPHY_SSR_LINK;
> +	if (link)
> +		yt8821_adjust_status(phydev, val);
> +
> +	if (link) {
> +		if (phydev->link == 0)
> +			phydev_dbg(phydev, "%s, phy addr: %d, link up\n",
> +				   __func__, phydev->mdio.addr);
> +		phydev->link = 1;
> +	} else {

[Severity: Medium]
Here the link state computed by genphy_read_status() is replaced by the
current vendor status bit.  genphy_update_link() keeps the latched-low BMSR
indication in polling mode (and forces link = 0 while BMCR_ANRESTART is set)
so that a drop between two polls is observable.

If a cable is unplugged and replugged between two 1 second polls, does this
sequence lose the transition?

genphy_update_link()       -> phydev->link = 0 (latched BMSR)
yt8824_read_status_paged() -> YTPHY_SSR_LINK set, phydev->link = 1
phy_check_link_status()    -> link && state == PHY_RUNNING, no branch taken

drivers/net/phy/phy.c:phy_check_link_status() {
	if (phydev->link && phydev->state != PHY_RUNNING) {
	...
		phy_link_up(phydev);
	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
	...
}

yt8821_adjust_status() has already updated phydev->speed/duplex, so if the
new speed differs the MAC keeps its old configuration and phy_link_up() is
never called.  The same overwrite exists in the older yt8521/yt8821 helpers,
but this is new code; could the generic link-down result be preserved instead
of being promoted back to link up?

> +		if (phydev->link == 1)
> +			phydev_dbg(phydev, "%s, phy addr: %d, link down\n",
> +				   __func__, phydev->mdio.addr);
> +		phydev->link = 0;
> +	}
> +	phy_resolve_aneg_pause(phydev);
> +	return 0;
> +}

[ ... ]

> +static int yt8824_config_aneg(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int phy_ctrl = 0;
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = __genphy_config_aneg(phydev, ret);

[Severity: Medium]
The 2.5G advertisement is programmed from phydev->advertising alone, without
looking at phydev->autoneg or phydev->speed.  Is the forced speed still
honoured in this case?

"ethtool -s ethX autoneg off speed 1000 duplex full" keeps the
2500baseT_Full bit in phydev->advertising:

drivers/net/phy/phy.c:phy_ethtool_ksettings_set() {
	...
	linkmode_copy(phydev->advertising, advertising);
	...
}

so MDIO_AN_10GBT_CTRL_ADV2_5G is set here, and __genphy_config_aneg() then
takes the forced-speed path which only rewrites the clause 22 registers:

drivers/net/phy/phy_device.c:__genphy_config_aneg() {
	...
	} else {
		linkmode_zero(fixed_advert);
		c = phy_caps_lookup(phydev->speed, phydev->duplex,
				    phydev->supported, true);
		if (c)
			linkmode_and(fixed_advert, phydev->supported,
				     c->linkmodes);
		advert = fixed_advert;
	}
	...
}

Nothing clears the 2.5G advertisement, so can the port still negotiate
2.5G with a capable partner after 1000/full was forced?  Should ADV2_5G be
cleared when autoneg is disabled and the forced speed is not 2500?

> +
> +err:
> +	mutex_unlock(&priv->shared_lock);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_phy_package_probe_once()  - init phy package for phy8824.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	int res;
> +
> +	if (!priv || !np) {
> +		phydev_err(phydev, "%s: missing shared priv or DT node\n",
> +			   __func__);
> +		return -EINVAL;
> +	}
> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	res = of_get_phy_mode(np, &priv->interface_mode);
> +	if (res < 0) {
> +		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n", __func__);
> +		return res;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
mutex_init(&priv->shared_lock) and the write of priv->interface_mode happen
without the package lock held.  phy_package_probe_once() is only a
test_and_set_bit(), so it guarantees single execution but provides no mutual
exclusion and no ordering for the other package members:

drivers/net/phy/phy_package.c:phy_package_probe_once() {
	return __phy_package_set_once(phydev, 1);
}

A sibling whose probe sees the bit already set returns immediately, and
phy_probe() then calls yt8824_get_features(), which does
mutex_lock(&priv->shared_lock).  Can that run on a mutex whose wait_lock and
wait_list are still the zeroed memory from the kzalloc'ed shared priv, and
can interface_mode be read before it is written?

dp83640 wraps the same sequence:

drivers/net/phy/dp83640.c:dp83640_probe() {
	...
	/* Ensure other PHY probes wait for shared clock initialization. */
	phy_package_lock(phydev);
	if (phy_package_probe_once(phydev))
		dp83640_clock_init(clock);
	phy_package_unlock(phydev);
	...
}

Would the same phy_package_lock()/phy_package_unlock() pairing be
appropriate here?

> +
> +/**
> + * yt8824_probe() - phy8824 probe.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct yt8824_shared_priv *shared_priv;
> +	int ret;
> +
> +	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
> +	if (ret)
> +		return ret;

[Severity: Low]
This isn't a bug, but the join is unconditional, so a YT8824 that is not
described under an ethernet-phy-package node cannot bind and fails with
-EINVAL from of_phy_package_join().  That matches qca807x_probe(), which
also calls devm_of_phy_package_join() unconditionally, and the requirement is
documented by motorcomm,yt8824.yaml added earlier in the series.  Would it be
worth saying in the commit message that the YT8824 binds only from a PHY
package topology?

> +
> +	if (phy_package_probe_once(phydev)) {
> +		ret = yt8824_phy_package_probe_once(phydev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
The one-shot bit is consumed before the fallible initialization runs, and
nothing puts it back if yt8824_phy_package_probe_once() fails.

of_get_phy_mode() leaves *interface untouched on error and the shared priv is
kzalloc'ed, so priv->interface_mode stays PHY_INTERFACE_MODE_NA (0) when the
phy-mode lookup fails.  If a sibling of the same package already holds a
reference, that sibling skips initialization entirely and runs with
interface_mode == NA.

Every later test is of the form:

	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL)
		...internal path...
	else
		...SerDes path...

so does NA silently select the external USXGMII path?  Those ports would run
yt8824_extern_config_sds_init_paged() (efuse-derived PLL/LDO trims, VCO/CDR
writes, MII_RESV1 preamble config, SerDes BMCR reset) and isolate/reset the
SerDes on every resume/suspend/soft_reset even on a part wired for the
internal host interface, with success returned.

Should the one-shot state be rolled back on failure (or the elect plus init
be done under phy_package_lock() as dp83640_probe() does), and should
PHY_INTERFACE_MODE_NA be rejected rather than defaulting to the SerDes path?

One more question about the binding added earlier in this series,
Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml:

[Severity: Low]
The example names the package node ethernet-phy-package@0 while declaring
reg = <9>:

        ethernet-phy-package@0 {
            #address-cells = <1>;
            #size-cells = <0>;
            compatible = "motorcomm,yt8824-package";
            reg = <9>;

The unit address should match the first entry of reg, and reg is the value
of_phy_package_join() turns into the package base address that
ytphy_read_top_ext()/ytphy_write_top_ext() rely on.  Should the node be named
ethernet-phy-package@9?  dtc's unit_address_vs_reg check only tests for
presence, so dt_binding_check will not flag this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917131441.3428554-1-kyle.switch%40motor-comm.com
