Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2E4718F9;
	Mon, 28 Sep 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582025; cv=none; b=hhzH9o9hXL8v42k1tD4ioYUvmuWz+rSZxK5kvx89ao8JQbZoTwtJRB75h/KuQqABhySxDG33ai9dZ2LiExET8v2VU0Gd01Z7SGPl1HW8zhuUkISk9pRL4qtjnPsJ8hR1yeIbn4oP9Iz6Mbq+SCzu9kOXVddAMDWTrW3m9HT7Z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582025; c=relaxed/simple;
	bh=714D5NaxsDSmEVNdl9+AGqX51zV5NknFaIxyV35GZVM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSKnLD+nNSTAYB39r2ScgK51scS4CxWzH0mJ8j/G5Z/oNMDYEuUk+4HivSIyfxiJcT2W019w3/CA5+5CpoUw5pmQTyTxicpVkl6RNJaMtwL68RlGz/9QBzo9talZP1mYTMqGsouquPTawbYibMu/J99qg3YDkVvSsPgwPLVtp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS6bqdzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS6bqdzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74BD1F000FF;
	Mon, 28 Sep 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582023;
	bh=DnS2H1WmQISUhYEre3k+AQu7LE/QH4s836Z2M97LRhU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iS6bqdzKc18eUmGFldoCdcVEQkGRiitV2LOMqRGp+YnBCtidHSkMZQs2qNDQ5IOFv
	 gF1OojhONXQEyGGTg0Pj4r/5SCz49VOL7HnPYbxM1M870LoNIaX3e92qMjAvjt+sEE
	 MH4+/A6O2csqEouPRX/JCwbKvNm+NtKYklyWbUqSYoDJUF3YWvwzk0OnxBEQ/iBlH+
	 aZJ5+CZGy258ZVtnZ5THX7JKMXFsQTvz5xpGUTBShfTFAQWhpjLkE4CMDKiCBJYHCi
	 OcWsdBzcyVPbSWj7hsXoM2hYwLrYD8KmgTXZRzGXoj3jIvkssgXmpP2DFbZcNd2jvu
	 ekBPO82lrhtoA==
Subject: Re: [PATCH net-next v21 3/3] net: phy: Add driver for Motorcomm Quad
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
Date: Mon, 28 Sep 2026 07:53:41 +0000
Message-ID: <179058202138.3145.10009749428787435555@kernel.org>
In-Reply-To: <20260924075048.4060414-4-kyle.switch@motor-comm.com>
References: <20260924075048.4060414-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] yt8824_read_status_paged() clears the forced speed and duplex
  whenever the link is down, even when autoneg is disabled: `if…
- [Medium] yt8824_probe() takes the package once-bit with
  phy_package_probe_once() (test_and_set_bit, never cleared) before the…
- [Medium] yt8824_sds_isolate_and_softreset_paged() and
  yt8824_extern_config_sds_init_paged() hold the bus-wide…
- [Medium] yt8824_read_status_paged() calls genphy_c45_read_lpa() only
  when `autoneg == AUTONEG_ENABLE && autoneg_complete`.
- [Low] yt8824_config_aneg() has a 'forced 2.5G' condition,
  `(phydev->autoneg == AUTONEG_ENABLE || phydev->speed == SPEED_2500) &&…
- [Low] The commit message is one sentence and leaves out behaviour a
  maintainer needs to judge this ~1.5k-line addition.
- [Low] yt8824_power_on() and yt8824_power_down() say UTP power-state
  changes 'need WA like softreset' and wrap the BMCR_PDOWN toggle in…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
motorcomm driver. It uses the phy_package helpers to reach the shared top
extended register space. It picks the internal or 10G-QXGMII init sequence
based on a phy-mode property in the package node.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758..c89ffb00e55e 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -614,23 +710,1053 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

[ ... ]

> +static int yt8824_sds_isolate_and_softreset_paged(struct phy_device *phydev)
> +{
> +	int old_page = YT8824_RSSR_UTP_SPACE;
> +	int val = 0;
> +	int ret = -1;
> +
> +	old_page = phy_select_page(phydev, YT8824_RSSR_SERDES_SPACE);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	/* sds softreset and disable isolate */
> +	ret = __phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ISOLATE,
> +			   BMCR_RESET & ~BMCR_ISOLATE);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +	/* poll while still holding the lock */
> +	ret = read_poll_timeout(__phy_read, val,
> +				(val < 0) || !(val & BMCR_RESET), 50000, 600000,
> +				true, phydev, MII_BMCR);

[Severity: Medium]
Does this hold the bus-wide mdio_lock across a sleeping poll that can last
up to 600ms?

phy_select_page() takes phydev->mdio.bus->mdio_lock, and the lock is only
released in phy_restore_page(). Because sleep_before_read is true,
read_poll_timeout() sleeps before the first read. It then keeps polling
with 50ms sleeps for up to 600ms.

In 10G-QXGMII mode this runs on every soft_reset, config_init, suspend and
resume. It runs again from yt8824_restore_working_status() on error paths.

yt8824_extern_config_sds_init_paged() does the same thing. It first issues
about 50 extended register writes, all inside the same phy_select_page()
window:

	/* poll while still holding the lock; __phy_read takes no lock */
	ret = read_poll_timeout(__phy_read, val,
				(val < 0) || !(val & BMCR_RESET), 50000, 600000,
				true, phydev, MII_BMCR);

While the lock is held, the other three YT8824 ports and any other PHY or
switch on the same MDIO bus are blocked.

Is there a way to avoid holding mdio_lock while waiting for the SerDes
reset to finish?

> +	if (val < 0)
> +		ret = val;
> +
> +err_restore_page:
> +	/* restore page, release the lock */
> +	return phy_restore_page(phydev, old_page, ret);
> +}

[ ... ]

> +static int yt8824_soft_reset(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		/* test mode 1 */
> +		ret = yt8824_utp_set_template_test_mode
> +			(phydev, MDIO_PMA_10GBT_TESTMODE_1);

[Severity: Low]
This isn't a bug, but could the commit message explain the sequencing
here? The commit message is a single sentence:

  Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
  motorcomm driver, using the phy_package helpers for the shared top
  extended register space.

Several things aren't mentioned.

soft_reset, config_init, suspend and resume all put the PMA into 10GBASE-T
template test mode 1 around the operation and then switch back to normal.
The only rationale in the code is "NOTE: need WA like softreset" above
yt8824_power_on() and yt8824_power_down().

The earlier commit "net: phy: Add support for Template Control register
for PMA" describes test modes as being used for PHY validation, not as a
reset workaround.

There are two init flavours, internal and 10g-qxgmii. A phy-mode property
in the package node selects between them.

The PHY only binds inside an ethernet-phy-package DT node that has reg and
phy-mode. Otherwise probe fails.

phy_init_hw() calls .soft_reset (yt8824_soft_reset()) and then
.config_init. yt8824_config_init() ends with another call:

	mutex_unlock(&priv->shared_lock);
	ret = yt8824_soft_reset(phydev);

So the full reset sequence runs twice per phy_init_hw(). Is that intended?

[ ... ]

> +static int yt8824_extern_config_utp_init_paged(struct phy_device *phydev)
> +{
> +	int ret = 0;
> +	int val = 0;
> +	int r;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +	/* power down */
> +	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
> +	if (ret < 0)
> +		goto err_restore;

[Severity: Low]
Should the BMCR_PDOWN toggles here use the same sequence as
yt8824_power_on() and yt8824_power_down()?

Those functions say BMCR_PDOWN changes "need WA like softreset". They wrap
the change in template test mode 1 and, in external mode, SerDes
isolation.

Here the init code differs in three ways:

- BMCR_PDOWN is set in normal test mode, without SerDes isolation.
- The later BMCR_RESET runs in test mode 1, but without isolation.
- The err_restore paths clear BMCR_PDOWN with a plain phy_modify().

yt8824_internal_config_init_paged() also sets BMCR_PDOWN outside test
mode 1.

On the success path, yt8824_config_init() ends with yt8824_soft_reset(),
which runs the full workaround, so this may not matter in practice.

[ ... ]

> @@ -3104,6 +4230,444 @@ static int yt8821_resume(struct phy_device *phydev)

[ ... ]

> +static int yt8824_read_status_paged(struct phy_device *phydev)
> +{
> +	int ret;
> +	int val;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> +		ret = genphy_c45_read_lpa(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Medium]
Can this leave a stale 2500baseT_Full bit in phydev->lp_advertising?

After a link with a 2.5G-capable partner, lp_advertising has
2500baseT_Full set. When the link drops or negotiation restarts,
autoneg_complete is cleared. genphy_read_lpa() then clears only the
Clause 22 bits:

drivers/net/phy/phy_device.c:genphy_read_lpa() {
    ...
		if (!phydev->autoneg_complete) {
			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
							0);
			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
			return 0;
		}
    ...
}

genphy_c45_read_lpa() is skipped here, so nothing clears the 10GBT status
bits. Until negotiation completes again, ethtool keeps reporting that the
link partner supports 2.5G.

The same pattern exists in yt8821_read_status().

> +
> +	if (!phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		if (phydev->autoneg == AUTONEG_ENABLE)
> +			phy_resolve_aneg_pause(phydev);
> +		return 0;
> +	}

[Severity: Medium]
Does this overwrite a forced speed and duplex when autoneg is disabled?

With autoneg off, phydev->speed and phydev->duplex hold the user's forced
settings. genphy_read_status()->genphy_read_status_fixed() has just read
them back from BMCR.

Suppose the user forces 100/full and then unplugs the cable. This branch
sets speed and duplex to SPEED_UNKNOWN and DUPLEX_UNKNOWN. On the next
phy_start(), the state machine goes through _phy_start_aneg():

	if (AUTONEG_DISABLE == phydev->autoneg)
		phy_sanitize_settings(phydev);

phy_caps_lookup() finds no match for SPEED_UNKNOWN and returns the lowest
supported mode. yt8824_config_aneg()->__genphy_config_aneg()->
genphy_setup_forced() then programs 10Mb/s instead of 100/full.

phy_state_machine() only clears speed and duplex in PHY_HALTED when
phydev->autoneg == AUTONEG_ENABLE. Should this branch do the same?

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
> +	/*
> +	 * Only advertise 2.5G when autoneg is enabled, or when 2.5G is
> +	 * explicitly forced.  When a different speed is forced, clear
> +	 * ADV2_5G so a 2.5G-capable link partner cannot negotiate 2.5G.
> +	 * __genphy_config_aneg() only rewrites the
> +	 * clause 22 registers on the forced-speed path, so it will not
> +	 * clear this bit.
> +	 */
> +	if ((phydev->autoneg == AUTONEG_ENABLE ||
> +	     phydev->speed == SPEED_2500) &&
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;

[Severity: Low]
Can phydev->speed == SPEED_2500 ever be true here with autoneg disabled?

phy_ethtool_ksettings_set() rejects AUTONEG_DISABLE with any speed other
than 10, 100 or 1000:

	if (autoneg == AUTONEG_DISABLE &&
	    ((speed != SPEED_1000 &&
	      speed != SPEED_100 &&
	      speed != SPEED_10) ||

With autoneg enabled, the first operand already decides the result. So
the SPEED_2500 check looks like dead code, and the comment describes a
forced 2.5G case that the core never produces.

Could the condition and the comment be simplified?

[ ... ]

> +static int yt8824_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct yt8824_shared_priv *shared_priv;
> +	int ret;
> +
> +	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
> +	if (ret)
> +		return ret;
> +
> +	/* Ensure other PHY probes wait for shared mutex initialization. */
> +	phy_package_lock(phydev);
> +	if (phy_package_probe_once(phydev)) {
> +		ret = yt8824_phy_package_probe_once(phydev);
> +		if (ret) {
> +			phy_package_unlock(phydev);
> +			return ret;
> +		}
> +	}
> +	phy_package_unlock(phydev);
> +
> +	return 0;
> +}

[Severity: Medium]
What happens to the other PHYs in the package when
yt8824_phy_package_probe_once() fails?

phy_package_probe_once() does a test_and_set_bit() on the shared flags,
and the bit is never cleared. So the once-bit is used up before the
phy-mode validation runs.

If phy-mode is missing, of_get_phy_mode() leaves priv->interface_mode as
PHY_INTERFACE_MODE_NA. If phy-mode is unsupported, the rejected mode stays
in priv.

A sibling PHY may already have joined the package, for example with async
probing. It waits on phy_package_lock() and then sees
phy_package_probe_once() return false. It skips validation and returns 0.

That PHY then binds with an NA or rejected interface_mode. Every YT8824
op treats anything other than PHY_INTERFACE_MODE_INTERNAL as the external
SerDes case. So config_init, soft_reset, suspend and resume run the
SerDes sequences on a package that the driver itself rejected.

Could the validation result be recorded in the shared priv, or phy-mode
be validated on every probe, so all PHYs in the package fail the same
way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924075048.4060414-1-kyle.switch%40motor-comm.com
