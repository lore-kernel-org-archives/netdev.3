Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560069;
	b=1JpYRCRRhIgQnelig4MfAEvwVxMgSgjZbcU3GGunj3jx91SqeidrWvngkySA7KOlJzNB
	 lCVnUD9Zm3Fiy0XmfWsiRTQ0JuaLhFMBcTEukQPm7bvLcXBnum9BlV19AQjEOSJggaeIi
	 XNxhSyNuAn0l7d4ofGvHd2+IQaMZCNAQKV+v8Lk4YFO8M29KHMZ6Qe1vE8F4QRgm7tz7W
	 epdXZiS/PLWNu3bF4Y50GFC5h6ftR4dmmEQLgDlZeagkb/xlIu5MXvO8uwZuYqoLyIIUD
	 7W6JBfUFqSyGXp95fx9TaDLaFuSPJHTwUQTkjE6neoSJQVam1vEOzfcWosdXHcQPCcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560069;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ht781Us+bMMX67ft+kyqOg38x3ybNEBzTgFwKfzXbO4=;
	b=ag6DX4Ra5oXBD7A/FEkDRJSqxKw2o48MJ4SDs8tyer2DP5fYxVKO6T8LKb+cceqXF8L6
	 CICpnIuyBimFH1m8CMPkFVKtIaxTw3rkp+5sLP8QovvcL/mOmu6+vMK/7+fDBOHpWx85g
	 TS9yczkFaiLaHgkdMLaxrang8lM98ccq0j5qDFhuMQ1LBzT9bgpqDCww8uN/svJhc4vkU
	 I+SXv8uU1QvXrokkBCRIy5UFU+dTAExiMCu8sicPySzY2D5R+XVfvA3HrhIMaIeHWDsFm
	 /ATRwu+FxuWOh0eZmQIRNtQQ4iKuysPCmFOKltrLRNJYY7BK+bYErIAcAyXxDAaSC/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcuqhhKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B9606A319;
	Wed, 21 Oct 2026 05:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcuqhhKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E17F1F000CB;
	Wed, 21 Oct 2026 05:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792560068;
	bh=Ht781Us+bMMX67ft+kyqOg38x3ybNEBzTgFwKfzXbO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XcuqhhKKMAkPw4UqJqkN3soJoviL6/R3M539jn5Ici8IY/AMHa1a4YIuaPE+pSZ/W
	 fOroBOGCgSN4Jyw/Ha7PaBXsHNSD3TIve+RGS5MsD5SfHiXdLXt8KI8fP8wQhTe4nv
	 r34aK2n+ZVv8/Tor+ZX9kESKMEiKEqmLG6Aq2QMkXabJaRM2m6APLququSKtVKh31Y
	 i9nS1bacjlNpaNl2fxJ1p09EMhBmmH8nLFchCWz0WmZRC5+pylLoPHaFoGCm+qmA/w
	 rocXM1fY5ZdY66Y4iatFV3TX4FFo8yXzgT7FliD3OdkuhSAm5Ti3IiIwq/FRxVpu38
	 N7B935QaoLgAw==
Subject: Re: [PATCH net-next v27 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Date: Wed, 21 Oct 2026 05:21:07 +0000
Message-ID: <179256006718.3135.7319825879547657420@kernel.org>
In-Reply-To: <20261020021929.3028490-4-kyle.switch@motor-comm.com>
References: <20261020021929.3028490-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message is three lines long for a ~1900-line driver
  addition and leaves out behaviour a maintainer needs to judge it.
- [Medium] priv->sds_initialized is only reset in
  yt8824_phy_package_probe_once() and is set to true after the first…
- [Medium] net: phy: motorcomm: yt8824_read_status_paged() clears forced
  speed and duplex
- [Low] yt8824_probe() calls phy_package_probe_once() before
  yt8824_phy_package_probe_once() has validated the package.
- [Low] In yt8824_config_aneg() the forced-2.5G clause sets
  MDIO_AN_10GBT_CTRL_ADV2_5G only if 2500baseT_Full is also in…
- [Low] yt8824_read_status_paged() calls genphy_c45_read_lpa() only when
  autoneg is enabled and autoneg_complete is set.
- [Low] yt8824_sds_isolate_and_softreset_paged() and
  yt8824_extern_sds_softreset() poll BMCR_RESET with…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
existing motorcomm driver. It uses the phy_package helpers to access the
shared top extended register space. Two package modes are supported:
internal and 10g-qxgmii.

> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.

[Severity: Medium]

Could the commit message describe some of the less obvious behaviour
this adds?

yt8824_soft_reset(), yt8824_power_on() and yt8824_power_down() put the
PMA into 10GBASE-T template test mode 1 around every reset or power
transition, and switch it back to normal afterwards. In non-internal
mode they also isolate the SERDES and soft reset it. yt8824_config_init()
reaches the same sequence through yt8824_soft_reset(). The only
explanation in the code is "NOTE: need WA like softreset".

The changelog also doesn't mention the two package modes (internal and
10g-qxgmii). Nor does it mention the one-time package-wide SERDES
calibration, which only runs in 10g-qxgmii mode.

The ethernet-phy-package node must carry the "motorcomm,package-mode"
property, or yt8824_phy_package_probe_once() returns -EINVAL. The
property is documented by "dt-bindings: net: Document Motorcomm YT8824
PHY package" earlier in this series. Could the changelog say that this
property is required?

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 463e1ea3efc9..6628ebcca081 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -638,15 +949,1165 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

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

[Severity: Low]

phy_select_page() takes the bus-wide mdio_lock and phy_restore_page()
releases it. sleep_before_read is true, so this poll holds mdio_lock for
at least 50ms and up to 600ms. Is it intended that every other user of
the MDIO bus is blocked for that long? That includes the other YT8824
ports, any other PHYs, and any switch on the bus.

In 10g-qxgmii mode this runs per port from yt8824_soft_reset(), which
phy_init_hw() reaches twice: once as .soft_reset and again through
yt8824_config_init(). It also runs on suspend, on resume and on the
restore path.

yt8824_extern_sds_softreset() has the same poll under the bus lock, and
it runs on every yt8824_config_init().

Could the page be restored and the lock dropped between poll reads
instead?

> +	if (val < 0)
> +		ret = val;
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}

[ ... ]

> +static int yt8824_config_init(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_config_utp_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
> +	} else {
> +		if (!priv->sds_initialized) {
> +			ret = yt8824_extern_config_sds_init_paged(phydev);
> +			if (ret < 0)
> +				goto err;
> +			priv->sds_initialized = true;
> +		}

[Severity: Medium]

priv->sds_initialized is only cleared in yt8824_phy_package_probe_once().
The shared priv lives as long as any port in the package stays bound.
What happens if the package loses its SERDES configuration after the
flag has been set?

One case is a PHY with reset-gpios that is detached and attached again:

phy_detach()
  phy_device_reset(phydev, 1)
phy_attach_direct()
  phy_init_hw()
    phy_device_reset(phydev, 0)
    yt8824_config_init()

Another is a system suspend that removes PHY power, followed by
mdio_bus_phy_resume()->phy_init_hw().

In both cases yt8824_config_init() would skip
yt8824_extern_config_sds_init_paged(). It would only redo the per-channel
SDS soft reset and the UTP init.

Would the SERDES PLL/CDR/AFE/DFE/TX tuning then stay at reset defaults
in 10g-qxgmii mode until the driver is rebound?

[ ... ]

> @@ -3240,6 +4701,450 @@ static int yt8821_resume(struct phy_device *phydev)

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

[Severity: Low]

Can the 2500baseT_Full bit in phydev->lp_advertising go stale here?

When the link drops or negotiation restarts, autoneg_complete is 0. In
that case genphy_read_status()->genphy_read_lpa() only clears the clause
22 and 1000BASE-T partner bits:

	if (!phydev->autoneg_complete) {
		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
						0);
		mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		return 0;
	}

genphy_c45_read_lpa() is skipped in that case, so its own
mii_10gbt_stat_mod_linkmode_lpa_t(..., 0) clearing never runs.

Would ethtool then keep reporting a 2.5G link partner capability while
no negotiation is complete? yt8821_read_status() has the same pattern,
and it appears to have been copied here.

[ ... ]

> +static int yt8824_config_aneg(struct phy_device *phydev)
> +{

[ ... ]

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

Does this condition match the comment above it? For forced speeds of
1000 and above, __genphy_config_aneg() builds the advertisement from
phydev->supported, not phydev->advertising:

		c = phy_caps_lookup(phydev->speed, phydev->duplex,
				    phydev->supported, true);

Suppose 2.5G is forced after 2500baseT_Full was removed from
phydev->advertising. This clears ADV2_5G, and nothing usable is left in
the advertisement.

This can't be reached today. phy_ethtool_ksettings_set() rejects
AUTONEG_DISABLE with any speed other than 10/100/1000, so the
phydev->speed == SPEED_2500 clause is dead code.

Should that clause be dropped together with the "explicitly forced"
part of the comment? Alternatively, could it stop depending on
phydev->advertising?

[ ... ]

> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	const char *mode;
> +
> +	if (!priv || !np) {
> +		phydev_err(phydev, "%s: missing shared priv or DT node\n",
> +			   __func__);
> +		return -EINVAL;
> +	}
> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->sds_initialized = false;
> +	priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	if (!of_property_read_string(np, "motorcomm,package-mode",
> +				     &mode)) {

[ ... ]

> +	} else {
> +		phydev_err(phydev, "missing package-mode in PHY package node.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int yt8824_probe(struct phy_device *phydev)
> +{

[ ... ]

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

[Severity: Low]

What happens to the sibling ports if yt8824_phy_package_probe_once()
fails here?

phy_package_probe_once() does an unconditional test_and_set_bit() on
shared->flags. The INTERNAL default is stored in priv->package_mode
before the property is checked. If "motorcomm,package-mode" is missing
or unsupported, this port fails with -EINVAL, but the failure is not
recorded anywhere.

A sibling PHY in the same package may join before this port's devres
runs phy_package_leave(). Its reference keeps the shared object, and the
once bit, alive. phy_package_probe_once() then returns false for the
sibling, so it skips validation, returns 0, and runs in INTERNAL mode
whatever the DT says.

phylib probes synchronously, so this needs two ports of the package to
probe at the same time. One example is driver_attach() from a module
load racing with mdiobus_register().

Could the validation happen before the once bit is used up? Another
option would be to keep a validated or failed state in the shared priv
for siblings to check.

As a side note, the !priv || !np check can't trigger.
of_phy_package_join() always sets np, and it always allocates priv when
priv_size is non-zero.

[ ... ]

> @@ -3240,6 +4701,450 @@ static int yt8821_resume(struct phy_device *phydev)
>  	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
>  }
>  
> +/**
> + * yt8824_get_features - read mmd register to get 2.5G capability
> + * @phydev: target phy_device struct
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_get_features(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		goto err;
> +	ret = yt8821_get_features(phydev);
> +
> +err:
> +	mutex_unlock(&priv->shared_lock);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_aneg_done()  - check negotiation state.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: auto-negotiation complete status or negative errno code
> + */
> +static int yt8824_aneg_done(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int auto_neg;
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = phy_read(phydev, MII_BMSR);
> +	if (ret < 0)
> +		goto err;
> +	mutex_unlock(&priv->shared_lock);
> +	auto_neg = !!(ret & BMSR_ANEGCOMPLETE);
> +
> +	phydev_dbg(phydev, "%s, phy addr: %d, auto negotiation done: %d\n",
> +		   __func__, phydev->mdio.addr, auto_neg);
> +	return auto_neg;
> +err:
> +	mutex_unlock(&priv->shared_lock);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_read_status_paged() -  determines the speed and duplex of one page
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
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
> +
> +	if (!phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		if (phydev->autoneg == AUTONEG_ENABLE)
> +			phy_resolve_aneg_pause(phydev);
> +		return 0;
> +	}
> +
> +	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = ret;
> +
> +	yt8821_adjust_status(phydev, val);
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE)
> +		phy_resolve_aneg_pause(phydev);
> +
> +	return 0;
> +}
> +
> +/**
> + * yt8824_read_status() -  determines the negotiated speed and duplex
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_read_status(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = yt8824_read_status_paged(phydev);
> +	mutex_unlock(&priv->shared_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * yt8824_utp_power_on(): utp power on.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_utp_power_on(struct phy_device *phydev)
> +{
> +	int ret = 0;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0x0);
> +}
> +
> +/**
> + * yt8824_utp_power_down(): utp power down.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_utp_power_down(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
> +}
> +
> +/**
> + * yt8824_power_on()  - set utp power on.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * NOTE: need WA like softreset
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_power_on(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +	int r;
> +
> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_1);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_power_on(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_NORMAL);
> +		if (ret < 0)
> +			goto retry;
> +	} else {
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_1);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_sds_isolate_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_power_on(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_NORMAL);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +	}
> +	return 0;
> +
> +retry:
> +	/*
> +	 * If the PHY up operation succeeds but the subsequent operation
> +	 * fails, revert to the default state.
> +	 */
> +	r = yt8824_utp_power_down(phydev);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	ret = yt8824_restore_working_status(phydev, ret);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_resume() - resume the hardware
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_resume(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = yt8824_power_on(phydev);
> +	mutex_unlock(&priv->shared_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * yt8824_power_down()  - set utp power down.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * NOTE: need WA like softreset
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_power_down(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +	int r;
> +
> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_1);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_power_down(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_NORMAL);
> +		if (ret < 0)
> +			goto retry;
> +	} else {
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_1);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_sds_isolate_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_power_down(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_NORMAL);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +	}
> +	return 0;
> +
> +retry:
> +	/*
> +	 * If the PHY down operation succeeds but the subsequent operation
> +	 * fails, revert to the default state.
> +	 */
> +	r = yt8824_utp_power_on(phydev);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	ret = yt8824_restore_working_status(phydev, ret);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_suspend() - suspend the hardware
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_suspend(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = yt8824_power_down(phydev);
> +	mutex_unlock(&priv->shared_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * yt8824_config_aneg() - config negotiation
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
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
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = __genphy_config_aneg(phydev, ret);
> +
> +err:
> +	mutex_unlock(&priv->shared_lock);
> +	return ret;
> +}
> +
> +/**
> + * phy_mode_check() - check if mode names the PHY interface.
> + * @mode: PHY interface mode string
> + * @interface: PHY interface mode to compare against
> + *
> + * Return: true if @mode matches @interface, false otherwise.
> + */
> +static bool phy_mode_check(const char *mode, int interface)
> +{
> +	return !strcasecmp(mode, phy_modes(interface));
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
> +	const char *mode;
> +
> +	if (!priv || !np) {
> +		phydev_err(phydev, "%s: missing shared priv or DT node\n",
> +			   __func__);
> +		return -EINVAL;
> +	}
> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->sds_initialized = false;
> +	priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	if (!of_property_read_string(np, "motorcomm,package-mode",
> +				     &mode)) {
> +		if (phy_mode_check(mode, PHY_INTERFACE_MODE_INTERNAL)) {
> +			priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		} else if (phy_mode_check(mode,
> +					  PHY_INTERFACE_MODE_10G_QXGMII)) {
> +			priv->package_mode = PHY_INTERFACE_MODE_10G_QXGMII;
> +		} else {
> +			phydev_err(phydev, "unsupported package-mode %s\n",
> +				   mode);
> +			return -EINVAL;
> +		}
> +	} else {
> +		phydev_err(phydev, "missing package-mode in PHY package node.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
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
> +
>  static struct phy_driver motorcomm_phy_drvs[] = {
>  	{
>  		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),

[Severity: Medium]
When the link is down, this block overwrites phydev->speed and
phydev->duplex with SPEED_UNKNOWN and DUPLEX_UNKNOWN, whatever
phydev->autoneg is set to. Is that intended for the forced case?

With AUTONEG_DISABLE, phydev->speed and phydev->duplex are more than
status. They also hold the forced mode the user configured.
phy_ethtool_ksettings_get() reports them back. _phy_start_aneg()
passes them to phy_sanitize_settings() before phy_config_aneg().
genphy_read_status() has just refreshed them from BMCR through
genphy_read_status_fixed(), and this block then discards them.

Take "ethtool -s ethX autoneg off speed 100 duplex full" with the
cable unplugged. phy_check_link_status() runs straight after
phy_config_aneg() and loses the forced speed and duplex. Now take the
interface down and up, or suspend and resume. _phy_start_aneg() calls
phy_sanitize_settings(), which calls phy_caps_lookup() with
SPEED_UNKNOWN and exact == false. That lookup falls back to the lowest
supported mode, so the PHY ends up forced to 10/Half rather than the
100/Full the user asked for.

While the link stays down, a partial linkmodes update over ethtool
netlink also starts from these unknown values.
phy_ethtool_ksettings_set() then rejects AUTONEG_DISABLE with an
unknown speed or duplex and returns -EINVAL.

With autoneg enabled, genphy_read_status() already resets speed,
duplex and pause before reading the link partner, so the block looks
redundant there. The phy_resolve_aneg_pause() call is also a no-op.
Duplex has just been set to DUPLEX_UNKNOWN, and
phy_resolve_aneg_pause() only does anything for DUPLEX_FULL.

yt8821_read_status() does not do this. It only calls
yt8821_adjust_status() when the link is up. Could the !phydev->link
branch become a plain return 0, or be limited to AUTONEG_ENABLE?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020021929.3028490-1-kyle.switch%40motor-comm.com
