Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F94848A2;
	Mon, 19 Oct 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389206; cv=none; b=MhUhzOTkL/i9ADJuigdGtPv7c2dYxlMHdbYSJiIyX9/Srf1obCR/GqFoVtdrv/RmQ6pbrVD2YCj7AlmhvIQ7dC6V7yaA4j1P3NjieqIYgneteIM8SY9pwgzE6K1P3b8OfToKpixsZ9kdFWAAdFUi6q146jnB2+JcFgzS5khjlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389206; c=relaxed/simple;
	bh=nx49MSLtyiPDDljE6IM3bYcc/KDW3S+LtxMZku1QdWw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VuSGJ+Mqfu02+yKA2qGnLLo2d4th7y4Js+MKwl2iwD31i2TB8J84rYYsmHL9puFR0ZWJu5ZitpM+5pHxxttToO/KYoQ5hNM42C54ORffptTEiC3z1cjirptynD8JuJId5uNnwYHXRs3ii3nz4D6l/ypu+12S6SD9mhgN7t1Zs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc/goaQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc/goaQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A401F000C8;
	Mon, 19 Oct 2026 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389089;
	bh=F4aw878zBp/+OqOCWyHDFn/Wy6qVeR7mplzpx+jUNuY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uc/goaQu/8WQ+iKpOyTypsZW8/M8Ht3q2eJegTrwKc0e1Q8giOramvrXk8ijO+S3V
	 /ePzT5b/QCYL1xuPlZzkHSsg+P1wtYurh9vFBPaq+Y9gIlPasqU8gDX0Q8/SUiCKRD
	 M8hvAV4ExeDq25PzRBv9/P3wgCYK4Cs4G9ZWzbw48iCAnTZigoqyCPmw6I6qg+5TTi
	 9Py/R6wmDgEqLr9qJbdTJnPMjS8cbsWAPsdKL0KJwHDcrSXOUZtImUOjIa3RWKjw0x
	 GZN0psjx3y1D6BIQHcw1WWyHIevkyp0gThl6NmoP12o1FjcicM4lI/susdvVK0bivr
	 TqibwfYiN2jqw==
Subject: Re: [PATCH net-next v25 3/3] net: phy: Add driver for Motorcomm Quad
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
Date: Mon, 19 Oct 2026 05:51:27 +0000
Message-ID: <179238908798.3135.17505116267547348158@kernel.org>
In-Reply-To: <20261015145021.2216003-4-kyle.switch@motor-comm.com>
References: <20261015145021.2216003-4-kyle.switch@motor-comm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] priv->sds_initialized is set to true in yt8824_config_init()
  once yt8824_extern_config_sds_init_paged() succeeds.
- [Low] yt8824_soft_reset(), yt8824_power_on(), yt8824_power_down() and
  the tail of yt8824_config_utp_init_paged() all follow the same…
- [Low] yt8824_probe() calls phy_package_probe_once(), which does
  test_and_set_bit(1, &shared->flags), before…
- [Low] yt8824_read_status_paged() calls genphy_c45_read_lpa() only when
  autoneg is enabled and autoneg_complete is set.

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This patch adds support for the Motorcomm YT8824 quad-port 2.5G PHY to
the existing motorcomm driver. It uses the phy_package helpers to reach
the shared top extended register space, and to share a mutex and the
package mode between the four ports.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..47f2e19f233db 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> +static int yt8824_soft_reset(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_utp_set_template_test_mode(phydev,
> +							MDIO_PMA_10GBT_TESTMODE_1);
> +		if (ret < 0)
> +			goto retry;
> +
> +		ret = yt8824_utp_softreset_paged(phydev);

[Severity: Low]
This isn't a bug, but could this workaround be documented?

yt8824_soft_reset(), yt8824_power_on(), yt8824_power_down() and the end
of yt8824_config_utp_init_paged() all run the same sequence:

  - put the UTP PMA into 10GBASE-T Test Mode 1
  - isolate the SERDES
  - do the BMCR reset or PDOWN change
  - go back to normal mode
  - soft-reset the SERDES

The only explanation in the code is the comment above yt8824_power_on()
and yt8824_power_down():

  * NOTE: need WA like softreset

The previous patch in the series describes genphy_c45_template_testmode()
as being used for PHY validation, but here it runs on normal runtime
paths.

Which erratum does this work around? Why is a transmit test waveform
needed? What does the link partner see while it is active? Without that,
it is hard to tell later which silicon revisions need it, or whether it
can be removed.

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
What happens to the shared SERDES configuration after the PHY hardware
has been reset?

priv->sds_initialized is cleared only in yt8824_phy_package_probe_once(),
which runs once for the lifetime of the package. phylib calls
config_init again after the reset line may have been asserted:

  phy_detach()
    phy_detach_internal()
      phy_device_reset(phydev, 1);

  phy_attach_direct()
    phy_init_hw()
      phy_device_reset(phydev, 0);
      yt8824_config_init()

mdio_bus_phy_resume()->phy_init_hw() has the same issue after a suspend
that removed power.

The shared priv survives this, because devres ties it to driver bind
rather than attach. So !priv->sds_initialized is false and
yt8824_extern_config_sds_init_paged() is skipped.

Would that leave the 10G-QXGMII lane at power-on defaults, without the
efuse-derived PLL/LDO trims, VCO tuning, RX/TX equalization and
calibration restart? The per-port SDS soft reset and UTP init would
still run, and all four ports share the lane.

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
Can this leave a stale 2500baseT bit in phydev->lp_advertising?

Negotiation becomes incomplete when the cable is pulled or AN is
restarted. In that case genphy_read_lpa() clears only the Clause 22 and
1000BASE-T partner bits:

genphy_read_lpa() {
    ...
		if (!phydev->autoneg_complete) {
			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
							0);
			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
    ...
}

The cleanup that genphy_c45_read_lpa() does when MDIO_AN_STAT1_COMPLETE
is not set never runs here. So ETHTOOL_LINK_MODE_2500baseT_Full_BIT from
the previous partner stays set, and ethtool keeps reporting it while the
link is down or renegotiating.

Could genphy_c45_read_lpa() be called whenever autoneg is enabled, or
could the 10GBT partner bits be cleared when autoneg_complete is false?

[ ... ]

> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	const char *mode;

[ ... ]

> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->sds_initialized = false;
> +	priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	if (!of_property_read_string(np, "motorcomm,package-mode",
> +				     &mode)) {

[ ... ]

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

[ ... ]

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
Is the once bit used up before the fallible init has succeeded?

phy_package_probe_once() calls test_and_set_bit() before
yt8824_phy_package_probe_once() validates the DT. Suppose
motorcomm,package-mode is missing or unsupported:

  - the bit stays set
  - priv->package_mode is left at PHY_INTERFACE_MODE_INTERNAL
  - only the current probe sees -EINVAL

If a sibling PHY has already joined the same shared object, the failing
PHY's leave drops only one reference. The sibling then gets false from
phy_package_probe_once(), returns 0, and binds in INTERNAL mode even
though the DT was rejected.

phy_driver_register() forces synchronous probing, so this needs a
device_add() triggered probe to overlap driver_attach() from module
load or deferred probe. With ordinary sequential probing, the shared
object is freed before the next PHY joins, so every port fails the same
way. The mutex is always initialized before validation fails, so there
is no locking problem.

Could the result of the package init be stored in the shared priv and
checked by every probe? Alternatively, the DT could be validated before
the once bit is set.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015145021.2216003-1-kyle.switch%40motor-comm.com
