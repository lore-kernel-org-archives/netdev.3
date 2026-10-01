Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799BA4DD3B7;
	Thu,  1 Oct 2026 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848477; cv=none; b=hDFgUki4IMhY0EPtsC5+J9z/Feb88KZcbqLWgEci2L11WJ7X9GRdBVtdvqoBCiqomF6N33koFLpEIr1f3q/s5p6OAUdrC8tDnmrJPE+7W1hcvBEVL9r+uT21uZnMF5Sq6H4kgeILKvNFGH7g3sGYmi/L9Cdwk2eQEnnL3CylhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848477; c=relaxed/simple;
	bh=w4yov9Ff71ryWV5xJGvWEQTtp1KQopRMVXzLk06hrR8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+UnWv8PWxugpZrNCmWTdkyUrayqJ/4BWN42obyxgCQxxjShCw9IcROh5uTk2HhxQuwuC5xKAd4Ux00rEE8BJ6X1AcvHymkJqwi0XW1OBjM5FqgBQ1XKCxUXwBWBxJ88WJpTh4V/RKvUkesTG+dSdGnsotYww+PATN1+F4s6EIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY4beBLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY4beBLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134641F000FF;
	Thu,  1 Oct 2026 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848475;
	bh=KVXS9LbNYq3rlQ3b9dDNQPLyxSOXC6oYEzY48bSFdSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bY4beBLZRM0vRu+pPTh/230O6fC9SRk9Ry64PZe31OLX8dtBGrssA2VONaxkcCQzj
	 FuTC/jj/u0Hm9wPzfNZ+neS8f/ETrjjW2F9FpjvdP5wpaAHq7qCtrlW7qLerrPNahD
	 gQyQ04zFvAbgtCquuLu/7gMAFwDDIIrPOq4H1vKyBCfVlC0bhDbk9ffIumnQwZhXx/
	 2Cl1LS4Ma3w50XJjdd1Iq/Dmye7nEndowjw8bn8DPnmP/ikVpD+ZLkaEGEo/MbeCE6
	 LOnIoiOucoNMwbq+yo8VjeSOIjs2mTRT2QpGNAjUquQR+dVwhqeMVVJd4qhGxPnswM
	 iuVI4B4zgI6oA==
Subject: Re: [PATCH net-next v22 3/3] net: phy: Add driver for Motorcomm Quad
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
Date: Thu, 01 Oct 2026 09:54:33 +0000
Message-ID: <179084847364.434549.6613353375292448395@kernel.org>
In-Reply-To: <20260929095430.508657-4-kyle.switch@motor-comm.com>
References: <20260929095430.508657-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/phy/motorcomm.c, yt8824_read_status_paged()
  clears phydev->speed and phydev->duplex to UNKNOWN whenever the link…
- [Medium] yt8824_read_status_paged() only calls genphy_c45_read_lpa()
  when `phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete`.
- [Low] yt8824_probe() calls phy_package_probe_once(), and
  __phy_package_set_once() does `!test_and_set_bit()`, so the shared…
- [Low] In yt8824_config_aneg(), the comment says ADV2_5G is advertised
  'when 2.5G is explicitly forced', and the condition has a…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
existing motorcomm driver. It uses the phy_package helpers for the shared
top extended register space, and a package-wide mutex to serialize UTP and
SerDes register space switching. The package mode comes from the
"motorcomm,package-mode" DT property.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..11672fb25020b 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -3104,6 +4230,461 @@ static int yt8821_resume(struct phy_device *phydev)
>  	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
>  }
>  

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
Can ETHTOOL_LINK_MODE_2500baseT_Full_BIT stay set in
phydev->lp_advertising after a 2.5G link partner goes away?

If autoneg has not completed (link loss, or renegotiation in progress),
genphy_read_status()->genphy_read_lpa() clears only the C22 and 1000BASE-T
bits:

drivers/net/phy/phy_device.c:genphy_read_lpa() {
    ...
	if (phydev->autoneg == AUTONEG_ENABLE) {
		if (!phydev->autoneg_complete) {
			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
							0);
			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
			return 0;
    ...
}

Only the !MDIO_AN_STAT1_COMPLETE branch of genphy_c45_read_lpa() clears
the 2.5G link partner bit:

	if (!(val & MDIO_AN_STAT1_COMPLETE)) {
		...
		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);

The autoneg_complete gate here means that branch never runs. So ethtool
would keep showing 2500baseT/Full in the link partner advertisement until
the next negotiation completes. yt8821_read_status() has the same gate,
and this code copies it.

> +
> +	if (!phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;

[Severity: Medium]
Does this throw away the forced speed and duplex when autoneg is disabled?

With autoneg off, genphy_read_status()->genphy_read_status_fixed() has
just loaded the forced speed and duplex from BMCR. Whenever the link is
down, this block overwrites them with SPEED_UNKNOWN and DUPLEX_UNKNOWN.

On the next restart (ip link set down/up, or phy_start() on resume), the
path looks like this:

_phy_start_aneg()
  phy_sanitize_settings()
    phy_caps_lookup(SPEED_UNKNOWN, DUPLEX_UNKNOWN, supported, false)
      /* no match, falls back to 'last', the slowest capability */
  yt8824_config_aneg()
    __genphy_config_aneg()
      genphy_setup_forced()

BMCR then gets the slowest supported mode, normally 10 Mb/s half duplex.
It no longer matches what was requested with, for example,
"ethtool -s ethX autoneg off speed 100 duplex full".

The PHY_HALTED handling in _phy_state_machine() avoids this by resetting
speed and duplex only when autoneg is enabled:

	case PHY_HALTED:
		if (phydev->link) {
			if (phydev->autoneg == AUTONEG_ENABLE) {
				phydev->speed = SPEED_UNKNOWN;
				phydev->duplex = DUPLEX_UNKNOWN;
			}

Should this block be limited to AUTONEG_ENABLE as well?

> +		if (phydev->autoneg == AUTONEG_ENABLE)
> +			phy_resolve_aneg_pause(phydev);
> +		return 0;
> +	}

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
Is the phydev->speed == SPEED_2500 part of this condition reachable?

phy_ethtool_ksettings_set() rejects AUTONEG_DISABLE for any speed other
than 10, 100 or 1000:

	if (autoneg == AUTONEG_DISABLE &&
	    ((speed != SPEED_1000 &&
	      speed != SPEED_100 &&
	      speed != SPEED_10) ||

phylink_ethtool_ksettings_set() goes through the same helper. The comment
about 2.5G being "explicitly forced" therefore describes a case the driver
cannot currently reach.

If it were reachable, the C45 advertisement would come from
phydev->advertising. The forced C22 advertisement in __genphy_config_aneg()
comes from phy_caps_lookup(speed, duplex, supported) instead, so the two
halves would use different sources.

Could the condition and the comment cover only the autoneg case?

> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);

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

[Severity: Low]
What happens to sibling PHYs in the package when
yt8824_phy_package_probe_once() fails?

phy_package_probe_once() ends up in __phy_package_set_once(), which does
!test_and_set_bit(). The once-bit is therefore set before the DT property
is validated. On -EINVAL the bit is not cleared, and the failure is not
recorded in the shared priv.

devm_of_phy_package_join() runs outside the package lock. A sibling that
joined earlier (async probing, or overlapping manual binds) keeps the
shared object alive:

PHY A                                 PHY B
devm_of_phy_package_join()            devm_of_phy_package_join()
phy_package_lock()
phy_package_probe_once() -> true
yt8824_phy_package_probe_once()
  package_mode = INTERNAL
  return -EINVAL
phy_package_unlock()
                                      phy_package_lock()
                                      phy_package_probe_once() -> false
                                      phy_package_unlock()
                                      return 0

PHY B then binds with the PHY_INTERFACE_MODE_INTERNAL default that was
written before the property check. Its config_init runs the internal-mode
sequence on a package whose DT was already rejected.

With the default synchronous probing, the failed probe's devres unwind
drops the refcount to zero first. This only shows up with async probing.

Could the first probe's result be stored in yt8824_shared_priv so that
later joiners also fail?

As a side note, the !priv || !np check can't trigger, because
of_phy_package_join() always sets both.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929095430.508657-1-kyle.switch%40motor-comm.com
