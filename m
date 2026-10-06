Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6D4A263B;
	Tue,  6 Oct 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304306; cv=none; b=eQv7vAVTVkgzijSsq0E17DWwAcRNRCgPbJ1kyoU//BMBdppY4xE/gTYWDas8K1jMyJOprOF5FlzzKh4x6LlRzWvp7xFUQmR6lXV2kPFVHT6rgBlipl6RfOPTbQ2Mals19OwqXQcQQYi5cUjDFZ8ntATBu/oUXJFNYlKNMvSG+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304306; c=relaxed/simple;
	bh=VGpo3YNSdRdbX+RP/gKRnDYPeaLBdX/dgKTSFL/IZ7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAWafOcblKvJOR3fA4j5R6PFN4PdWQOAbJMaY1/AaKHP8wro7Zrt4tZAYTxuXwVhZaZo4ZNjINM04gg/darqHaX7MP/921HmLB8aswKaslLYL75K7Ksr5xN9gf4eAGqdAaDt8dAlpsG/5asstcXVSMBqias9xNF0H5c7fMNxi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvF8J5DK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvF8J5DK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217F61F0089B;
	Tue,  6 Oct 2026 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304304;
	bh=lBdRtQZsStubLmMRZaxWdXR9jv+5z2tA6rm0+eMN/68=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZvF8J5DKOPRkYR08I4NAxmAxRB6dAV9g7alg+iTCtDFmxYu5fmopO99DG3IMftLvy
	 CgQ0CXUL2J/6vmdKctoWlC5Y7h2qP8lMJsUnAn/ke60RfHuGjIremCYCbF5NuLoeMa
	 DLDTlLW+MiTucSabzqeqhahJHUUXvA0mLtvLTmLQ/kqkYDvS/fYDpd3nc5/7wjZwZS
	 MaHBkEjWTdYfx4g4uSEtOIDX9uPjLBip50UXTNL0CEwAwGNJtZSqzQtkCvfp542MFg
	 kwRWdryCvsCtjwq7jcu2gaVLCVEn7/Vf92r+MWxhyL2oXQZ1QGyyLR4Qd/YanMXHoJ
	 nKCxJxEZ2R74w==
Subject: Re: [PATCH net-next v24 3/3] net: phy: Add driver for Motorcomm Quad
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
Date: Tue, 06 Oct 2026 16:31:42 +0000
Message-ID: <179130430268.434549.16236732059337568756@kernel.org>
In-Reply-To: <20261002153034.934814-4-kyle.switch@motor-comm.com>
References: <20261002153034.934814-4-kyle.switch@motor-comm.com>
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

- [Medium] yt8824_read_status_paged() sets phydev->speed/duplex to
  SPEED_UNKNOWN/DUPLEX_UNKNOWN whenever the link is down, even with…
- [Medium] priv->sds_initialized is set to true after the first
  successful package SERDES init in yt8824_config_init().
- [Medium] yt8824_probe() calls phy_package_probe_once(), which
  permanently sets the package's 'probed' bit via test_and_set_bit()…
- [Medium] After a negotiation with a 2.5G-capable partner,
  lp_advertising holds ETHTOOL_LINK_MODE_2500baseT_Full_BIT.
- [Low] The commit message (three lines for about 1900 added lines)
  leaves out behaviour a maintainer needs in order to review the driver.
- [Low] Some kernel-doc does not match the code.
- [Low] yt8824_config_utp_init_paged() writes the U0/U1 TX resetb bits to
  0 and later to 1, and pulses YT8824_PLL_DAC_RST 0→1.

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
existing motorcomm driver. The phy_package helpers are used to reach the
shared top extended register space. The package mode (internal or
10G-QXGMII) is read from the PHY package DT node.

> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.

[Severity: Low]
Could the commit message say more about what the driver does? It is three
lines long for roughly 1900 added lines.

Five functions put the copper side into PMA template TESTMODE_1, do the
reset or power change, and then switch back to TESTMODE_NORMAL:
yt8824_soft_reset(), yt8824_power_on(), yt8824_power_down(),
yt8824_restore_working_status() and yt8824_config_utp_init_paged().

yt8824_soft_reset()
    yt8824_utp_set_template_test_mode(phydev, MDIO_PMA_10GBT_TESTMODE_1);
    ...
    yt8824_utp_softreset_paged(phydev);
    ...
    yt8824_utp_set_template_test_mode(phydev, MDIO_PMA_10GBT_TESTMODE_NORMAL);

This looks like a hardware workaround. However,
genphy_c45_template_testmode() was added in "net: phy: Add support for
Template Control register for PMA" as a helper "used for PHY validation".

Could the commit message explain the workaround and why it is needed?

Probe also now requires DT. devm_of_phy_package_join() needs an
ethernet-phy-package parent with a reg property. Without
motorcomm,package-mode, yt8824_phy_package_probe_once() returns -EINVAL.
The two package modes also take quite different init paths.

Could these points be mentioned as well, along with the source of the many
magic register values in the init sequences?

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..1d096d232224b 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -437,6 +684,70 @@ static int ytphy_read_ext_with_lock(struct phy_device *phydev, u16 regnum)
>  	return ret;
>  }
>  
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
> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_package_read(phydev, 0, YTPHY_PAGE_DATA);
> +}

[Severity: Low]
This isn't a bug, but the kernel-doc for ytphy_read_top_ext() and
ytphy_write_top_ext() says they access "a PHY's top extended register".

Both helpers call __phy_package_read()/__phy_package_write() with offset 0.
That reaches the package-shared block at the package reg address, not this
PHY's own address. Writing YT8521_REG_SPACE_SELECT_REG through them
therefore switches the register space for all four ports.

Could the comments say that?

The kernel-doc for yt8824_restore_working_status() has a similar problem.
It says "called to do store working status", but the function restores
state: it sets the template test mode back to NORMAL, and outside internal
mode it clears SERDES isolate and soft resets the SERDES.

[ ... ]

> @@ -622,15 +933,1165 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

[ ... ]

> +static int yt8824_config_utp_init_paged(struct phy_device *phydev)
> +{

[ ... ]

> +	ctrl = FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH0, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH1, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH2, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH3, 0);
> +	mask  = YT8824_U0_CSR_RESETB_TX_CH0 | YT8824_U0_CSR_RESETB_TX_CH1 |
> +		YT8824_U0_CSR_RESETB_TX_CH2 | YT8824_U0_CSR_RESETB_TX_CH3;
> +	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U0_CRS_RESET_REG,
> +					 mask, ctrl);
> +	if (ret < 0)
> +		goto err_restore;

[ ... ]

> +err_restore:
> +	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	return ret;

[Severity: Low]
Suppose an MDIO access fails after the U0/U1 TX resetb bits have been
cleared, or between the two YT8824_PLL_DAC_RST writes. err_restore only
clears BMCR_PDOWN in that case.

Is it intended that the TX channels stay held in reset here?

In that case config_init returns an error, and a later phy_init_hw() runs
the whole sequence again, which deasserts the resets. So this may be fine.
If it is, a short comment saying so could help.

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
What resets priv->sds_initialized once the package has lost its register
state? The only place that sets it to false is
yt8824_phy_package_probe_once().

config_init is called again from phy_init_hw() in at least two places where
the hardware may have been reset:

phy_detach_internal()
    phy_device_reset(phydev, 1);
...
phy_attach_direct()
    phy_init_hw()
        yt8824_config_init()

mdio_bus_phy_resume()
    phy_init_hw()
        yt8824_config_init()

In both cases the shared priv is still alive, because the package is joined
at probe and sibling PHYs keep their references. So
yt8824_extern_config_sds_init_paged() is skipped.

In 10G-QXGMII mode, would the package-wide SERDES PLL/CDR/AFE and
calibration settings then stay at their reset defaults?

[ ... ]

> @@ -3104,6 +4565,450 @@ static int yt8821_resume(struct phy_device *phydev)
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
Can lp_advertising keep a stale ETHTOOL_LINK_MODE_2500baseT_Full_BIT here?

When a link with a 2.5G partner goes down or renegotiates,
genphy_read_status()->genphy_read_lpa() takes its !autoneg_complete branch.
That branch only clears the clause 22 bits:

genphy_read_lpa()
    mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
    mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);

genphy_c45_read_lpa() would clear the 10GBT bits, but it only runs when
autoneg_complete is set. phy_ethtool_ksettings_get() copies lp_advertising
unchanged, so ethtool would still show a 2.5G-capable link partner.

rtl822x_read_status() avoids this by clearing the 10GBT bits first.

> +
> +	if (!phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		if (phydev->autoneg == AUTONEG_ENABLE)
> +			phy_resolve_aneg_pause(phydev);
> +		return 0;
> +	}

[Severity: Medium]
Does this throw away a forced speed and duplex while the link is down?

With autoneg disabled, genphy_read_status() has just reloaded speed and
duplex from BMCR via genphy_read_status_fixed(). This block then replaces
them with SPEED_UNKNOWN/DUPLEX_UNKNOWN.

On the next phy_start(), for example after ifdown/ifup or resume, the
PHY_UP path does:

_phy_start_aneg()
    phy_sanitize_settings()
        phy_caps_lookup(SPEED_UNKNOWN, DUPLEX_UNKNOWN, supported, false)

That lookup matches nothing and returns the slowest supported mode. Then
yt8824_config_aneg()->__genphy_config_aneg()->genphy_setup_forced() would
program 10/half instead of the forced setting the user chose.

yt8821_read_status() in the same file does not clear speed on link down.
Could the clearing here be limited to the autoneg case?

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

[Severity: Medium]
What happens to the other PHYs in the package when
yt8824_phy_package_probe_once() fails?

phy_package_probe_once() has already set the probed bit with
test_and_set_bit(), and nothing clears it later. priv->package_mode has
also already been set to PHY_INTERFACE_MODE_INTERNAL before
motorcomm,package-mode is checked.

With async probing, a sibling PHY can join through
devm_of_phy_package_join() before the failing PHY's devres drops its
reference. The shared struct then survives. The sibling sees
phy_package_probe_once() return false, skips the validation, and binds in
internal mode even though the DT never asked for that.

Would it be better to validate the property before the once bit is
consumed, so that every PHY in the package fails the same way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002153034.934814-2-kyle.switch%40motor-comm.com
