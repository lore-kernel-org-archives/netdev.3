Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71CF364943;
	Mon, 19 Oct 2026 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377534; cv=none; b=DTFwQ8CNms5N1Up5uSYiuTRDCGDextPz7ez5ORz9oM3bCYBd6mI0KdmzrCTsoXkDP3tbTO4HKnmJbUgRhWMdo923fAvUbsrb89YlBfe0opVdVRpzJE01lu6xK44AcrcmUTw+42eUT5gJP6Bu490+M9LrA462gNJNEXolm+RW3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377534; c=relaxed/simple;
	bh=jyT978WRZwYtdvjxnHBGIEagK3wQrhIZV6ZGqyVi8ew=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlHN7Nzjix8mVSqFkF596nhU1f4m7ljISVyOYrKgoonExFTK92QX2oubhTEob8DXOxQhwsi0BxH0l/OyoLaQ90Cg1jO3YO5yTALWIi19OsgltwFomAgoE101IX6nIJ1s2pdrQw9pKsq7AWfTBQrZ6f4CPvfK2i5fZlWREPU2Daw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeUbR/RO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeUbR/RO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715F31F000C5;
	Mon, 19 Oct 2026 02:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792377532;
	bh=JBoIp2kFOi/8Rb9HTrJXtAViU1KGcrdObT/hCxS0foo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JeUbR/ROhuTwyJohdwsr5PaiRRo7w0q3vxzf6i/LVRADOa/+lSB6JClStioxgQ3O8
	 ymMTlRaGJkrR5gvwUtd4+xRYawEf04OySdHkVMZ5G1/dVcxAgKstEWN16hBfyeeCD0
	 fAgselC1z+ddLMUFynFnrCVPmHCmjZ6j0QeT4ZeV6RXM45E2KYwOoKwWjusAA7Dnft
	 xBhbHd2PY8uOgYjXfROQ7NV/h+uHL2uGCSPhk1apN6ySnICzfyPbuPqBIp+HG0frUv
	 SqP9TdQhnxccp6FQ7ITcQSKngCCJ97wZA0O8em7zo5RlqD3s+f/cow/fTKKEyPhI2f
	 RCrYWV8FL3/zQ==
Subject: Re: [PATCH net-next v26 3/3] net: phy: Add driver for Motorcomm Quad
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
Date: Mon, 19 Oct 2026 02:38:51 +0000
Message-ID: <179237753101.3135.5143187427252185051@kernel.org>
In-Reply-To: <20261018022151.2677056-4-kyle.switch@motor-comm.com>
References: <20261018022151.2677056-4-kyle.switch@motor-comm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 7

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: phy: motorcomm: BMCR_PDOWN left set in
  yt8824_config_utp_init_paged()
- [Medium] In yt8824_config_init(), the package-wide SERDES tuning is
  gated by priv->sds_initialized.
- [Medium] Whenever the link is down, yt8824_read_status_paged() sets
  phydev->speed = SPEED_UNKNOWN and phydev->duplex = DUPLEX_UNKNOWN,…
- [Medium] yt8824_sds_isolate_and_softreset_paged() and
  yt8824_extern_sds_softreset() call read_poll_timeout(__phy_read, ...,…
- [Medium] yt8824_read_status_paged() only calls genphy_c45_read_lpa()
  when autoneg is enabled and complete.
- [Medium] yt8824_config_utp_init_paged() runs on every port's
  config_init in both package modes, with no once-per-package gate.
- [Low] yt8824_probe() consumes the one-shot phy_package_probe_once() bit
  (test_and_set_bit, never cleared) before the DT parsing in…
- [Low] In yt8824_config_utp_init_paged(), the err_restore path only
  clears BMCR_PDOWN.
- [Low] The commit message is three lines long for about 1900 lines of
  new hardware support.
- [Low] Leftover code: YT8824_PLL_VCO_SEL_CURRENT_B (line 431) is
  defined, but yt8824_config_utp_init_paged() uses the bare literal…
- [Low] The kernel-doc for yt8824_restore_working_status() says it is
  'called to do store working status'.
- [Low] The kernel-doc for yt8824_config_utp_init_paged() says 'config
  external phy8824 utp init', but yt8824_config_init() calls it in both…
- [Low] (Baseline: false positive.) The concern is that the comment in
  yt8824_config_aneg() ('Only advertise 2.5G when autoneg is enabled, or…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
motorcomm driver. It uses the phy_package helpers to access the shared top
extended register space, and supports an internal and a 10G-QXGMII package
mode.

> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.

[Severity: Low]
This isn't a bug, but could the commit message say more about the design?
It is three lines long for about 1900 lines of new code.

It doesn't say why every soft reset, suspend and resume first puts the port
into 10GBASE-T PMA template test mode 1. The only hint in the code is
"NOTE: need WA like softreset", and the previous patch in the series
describes these test modes as being used for PHY validation.

It also doesn't mention the package-wide shared_lock that serializes all
four ports. The two package modes and their separate init paths aren't
described either.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 463e1ea3efc93..6628ebcca0819 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -397,6 +416,226 @@

[ ... ]

> +/* PHY8824 UTP init registers */
> +#define YT8824_WRITE_PROTECT_CAL_REG		0x1
> +#define YT8824_WRITE_PROTECT			BIT(0)
> +#define YT8824_PLL_VCO_ATEMP_REG		0xa20e
> +#define YT8824_PLL_VCO_SEL_CURRENT		GENMASK(7, 4)
> +#define YT8824_PLL_VCO_SEL_CURRENT_B		0xb

[Severity: Low]
This isn't a bug, but YT8824_PLL_VCO_SEL_CURRENT_B is never used.
yt8824_config_utp_init_paged() uses the literal value instead:

	ctrl = FIELD_PREP(YT8824_PLL_VCO_SEL_CURRENT, 0xb);

YT8824_FFE_SUM_THRES is also unused, and so is the new
#include <linux/of_net.h>. yt8824_read_page() and yt8824_write_page() each
end with a stray "};".

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

[Severity: Medium]
Does this sleep for 50ms to 600ms while holding the bus-wide mdio_lock?

phy_select_page() takes phydev->mdio.bus->mdio_lock, and the lock isn't
released until phy_restore_page(). Because sleep_before_read is true,
every call sleeps at least once for 50ms under that mutex.

yt8824_extern_sds_softreset() has the same poll. In 10G-QXGMII mode a
single port's phy_init_hw() goes through it at least three times:

phy_init_hw()
  yt8824_soft_reset()
    yt8824_sds_isolate_and_softreset_paged()
  yt8824_config_init()
    yt8824_extern_sds_softreset()
    yt8824_soft_reset()
      yt8824_sds_isolate_and_softreset_paged()

Suspend, resume and the yt8824_restore_working_status() error path go
through it again.

While it sleeps, every other MDIO access on the bus is blocked. That
includes the sibling ports, other PHYs and any switch on the same bus.

yt8824_utp_softreset_paged() uses phy_read_poll_timeout(), which drops
the lock between reads. Could the SERDES polls avoid sleeping under
mdio_lock in a similar way?

[ ... ]

> +/**
> + * yt8824_restore_working_status() - called to do store working status
> + * @phydev: a pointer to a &struct phy_device
> + * @ret: operation's return code

[Severity: Low]
This isn't a bug, but the summary says "store" while the function
restores state. It sets the test mode back to normal and, outside
internal mode, clears SERDES isolate and soft-resets the SERDES.

[ ... ]

> +/**
> + * yt8824_config_utp_init_paged() - config external phy8824 utp init
> + * @phydev: target phy_device struct

[Severity: Low]
This isn't a bug, but yt8824_config_init() calls this function in both
the internal and the 10G-QXGMII branches, so "external" doesn't look
accurate.

The _paged suffix is also a little misleading. Elsewhere in this file it
marks helpers built on phy_select_page()/phy_restore_page(). This function
uses phy8824_page_write_with_lock() instead and never restores the page.

[ ... ]

> +	ctrl = FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH0, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH1, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH2, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH3, 0);
> +	mask  = YT8824_U0_CSR_RESETB_TX_CH0 | YT8824_U0_CSR_RESETB_TX_CH1 |
> +		YT8824_U0_CSR_RESETB_TX_CH2 | YT8824_U0_CSR_RESETB_TX_CH3;
> +	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U0_CSR_RESET_REG,
> +					 mask, ctrl);
> +	if (ret < 0)
> +		goto err_restore;

[Severity: Medium]
Are the U0/U1 RESETB_TX registers, the P0/P1 DAC bias registers and
P01_PLL_EN private to this port, or are they shared across the package?

yt8824_config_init() runs this function for every port in both modes.
Unlike the SERDES init, there is no once-per-package gate. Using the
calling port's address, it pulses YT8824_PLL_DAC_RST, then clears and sets
all eight U0/U1 RESETB_TX_CH0..3 bits.

The U0/U1, P0/P1 and P01 names suggest these registers cover more than one
UTP. If they are shared, would bringing up or resuming one port reset the
TX channels or PLL DAC of a sibling port whose link is already up?

The register overview in this patch lists a per-port UTP Top Extended
space separately from Common Top Extended, so this may be fine. It just
isn't clear from the code.

[ ... ]

> +err_restore:
> +	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	return ret;

[Severity: High]
Does this leave the UTP port powered down when the init succeeds?

The function sets BMCR_PDOWN at the start with phy_modify(). The later
reset only touches BMCR_RESET | BMCR_ANENABLE, so phy_modify() writes
BMCR_PDOWN back as it was. The success path then returns 0 just before
the err_restore label. The phy_modify() that clears BMCR_PDOWN only
runs on errors.

The err_restore_normal path clears BMCR_PDOWN after the reset, which
suggests the bit survives BMCR_RESET on this chip.

The ret >= 0 check under err_restore can never be true, because every
goto err_restore happens with ret < 0. That suggests the success path
was meant to fall through to the label.

yt8824_config_init() then calls yt8824_soft_reset(). Its call to
yt8824_utp_softreset_paged() only sets BMCR_RESET, so nothing there
powers the port back up either.

On attach, phy_start() and mdio bus resume, phy_resume() runs after
phy_init_hw(). yt8824_power_on() then clears BMCR_PDOWN, so the common
case may hide this.

phy_init_hw() is also called on its own, though. Examples are
phy_mii_ioctl() when userspace writes BMCR_RESET,
phy_abort_cable_test(), and MAC drivers that reinit the PHY during
error recovery. In those paths the port would stay powered down and no
error would be reported. The link would not come back until something
calls the resume callback again, for example an ip link down/up.

Was the port meant to be powered back up here, or is that deliberately
left to the resume callback? If it is deliberate, could the dead check
under err_restore be dropped and a comment added to explain it?

[Severity: Low]
Some steps above assert a reset in one write and release it in another. If
the releasing write fails, for example the second YT8824_PLL_DAC_RST write
or the U0/U1 RESETB_TX writes to 1, this path only clears BMCR_PDOWN.

Would that power the UTP back up with the PLL DAC or TX channels still
held in reset, the write-protect bit still set, and the analog trim only
half applied?

config_init does return the error, and the next config_init runs the whole
sequence again, so this only matters when MDIO writes fail.

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
Can sds_initialized go stale after the chip loses its register state?

The flag is only set to false once, in yt8824_phy_package_probe_once().
No remove, reset or resume path clears it.

phylib calls config_init again in cases where the PHY may have been reset
or powered off:

mdio_bus_phy_resume()
  phy_init_hw()
    yt8824_soft_reset()
    yt8824_config_init()
      if (!priv->sds_initialized)   <- false, SERDES init skipped

phy_detach_internal() also asserts the reset line with
phy_device_reset(phydev, 1) while the driver stays bound.

In that case the package-wide SERDES setup would not be redone. That setup
covers the write-protect unlock, the reset bypasses, CDR mode, the PLL VCO
trim, the efuse-derived values and the calibration restart.

The SERDES shared by all four ports in 10G-QXGMII mode would then run on
its power-on defaults, and no error would be reported.

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

[Severity: Medium]
When autoneg is enabled but has not completed, can a stale
2500baseT_Full bit stay in phydev->lp_advertising?

In that case genphy_read_lpa() only clears the C22 link partner bits:

	if (!phydev->autoneg_complete) {
		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		return 0;
	}

genphy_c45_read_lpa() is skipped here, so the 10GBT link partner bits
learned from an earlier 2.5G partner are never cleared. ethtool would keep
reporting them after the cable is unplugged or the partner changes.

rtl822x_read_status() in realtek_main.c clears these bits unconditionally
with mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0) before
reading them. Would something similar work here?

> +
> +	if (!phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		if (phydev->autoneg == AUTONEG_ENABLE)
> +			phy_resolve_aneg_pause(phydev);
> +		return 0;
> +	}

[Severity: Medium]
Should speed and duplex only be reset here when autoneg is enabled?

With autoneg disabled, phydev->speed and phydev->duplex hold the forced
configuration. genphy_read_status() has just read it back through
genphy_read_status_fixed(). In the halted state, phy_state_machine() only
clears these fields when autoneg is enabled.

With a forced 100/full setting and no link, after ip link down/up:

phy_start()
  phy_state_machine()   /* PHY_UP */
    _phy_start_aneg()
      phy_sanitize_settings()
        phy_caps_lookup(SPEED_UNKNOWN, ...)

No capability matches, so the lookup falls back to the lowest supported
mode, and the forced 100/full would quietly become 10 Mbps. Until then,
ethtool also reports the speed as Unknown.

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
What happens to the sibling ports if yt8824_phy_package_probe_once() fails?

phy_package_probe_once() uses test_and_set_bit(), and the bit is never
cleared, so it records that an attempt was made rather than that it
succeeded.

Suppose two ports have already joined the package, and the first one fails
because motorcomm,package-mode is missing or invalid. The shared storage
survives, because the package refcount is still non-zero.

The second port then sees phy_package_probe_once() return false, skips the
validation, and probes successfully. Its package_mode is still the default
that yt8824_phy_package_probe_once() stored before the check:

	priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;

That would leave one port failed and its siblings running in internal
mode, whatever the DT asked for. Hitting this needs concurrent probing and
an invalid DT.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018022151.2677056-1-kyle.switch%40motor-comm.com
