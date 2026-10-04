Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E6480DEB;
	Sun,  4 Oct 2026 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791148227; cv=none; b=Qt6TuUUMDybmFh7Uy9nWC7ARND+mx0IU5DZhRiIZRxOgAuNLSN6viQiblSe10cFB5pMd1Ny4vwQPa5ZbGhFR71LAu4ukSARQf2oC5ZcI2mJ1FWxJrJUSOtCTvnDwWYqsowge6RZh2r6uGyWqrop7/hYrnhKxFnIPcSJOkGzZ2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791148227; c=relaxed/simple;
	bh=cBI9ia5U6XO1S57QuiIFirdUVzD/Ux/OBkgkbFkbNpg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAswZ+sFQwxTHf5GULUQQlpsS8KtYO+NL2lpeCDyuK12trDErn8mjZ6ljMFG8/qw9JWx2L385Bu/W97dkaxPrW/bZ4VnjzEehBdFDZwQneLMaDiz6muLaMzCpI390d/JcyakSLc8uXu0skkH8F+NtkhlxKqk2h1FPqZQzAaiINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hckooh+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hckooh+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264B41F000FF;
	Sun,  4 Oct 2026 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791148225;
	bh=fB/TDQTPOKba6YQcpUyCG1I/tmeoqe2JlTghgFfrTII=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hckooh+wodURz51Yk7KRbYGUQz5KgWBJlB4RDj/uXuzgO+eQmPj+0/KFeVlBNKc+Z
	 l3xNpiorT9g95FpJP6/nB2LC8agBT+bseYrAMx5uiR5KkdbsjR3ZGL2uyQNUkilVc+
	 ojvRrpYD2dzFpGPhxRhzJWITxuboQcjgEz6Nj7FjkxZr9PdjA3eWo0JL9XEZwYkxhW
	 UD1HeI5poXasspsUlOkuxa/lp6789c0foD0ye5kKteKMYVt6mslsCpADxb5SWm24Pj
	 VBOtjubLpZMzpBoplIcLlfpnWpALRGts2jUvNwyB1le+woYMcUrBN4H5dYkL3eGrhO
	 FHiI/NKrioqXg==
Subject: Re: [PATCH net-next v23 3/3] net: phy: Add driver for Motorcomm Quad
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
Date: Sun, 04 Oct 2026 21:10:23 +0000
Message-ID: <179114822370.434549.9283126147007314820@kernel.org>
In-Reply-To: <20260930194513.663575-4-kyle.switch@motor-comm.com>
References: <20260930194513.663575-4-kyle.switch@motor-comm.com>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In yt8824_config_utp_init_paged() (drivers/net/phy/motorcomm.c),
  U0 TX channels CH0-CH3 are put into reset and never released.
- [High] net: phy: motorcomm: missing phy_package_init_once in
  yt8824_config_init disrupts active ports
- [Medium] In yt8824_config_utp_init_paged(), the '100M template
  amplitude' write to YT8824_DAC_IMID_CH2_CH3_CFG_ORG_REG (0x46e) has a…
- [Medium] yt8824_read_status_paged() sets phydev->speed = SPEED_UNKNOWN
  and phydev->duplex = DUPLEX_UNKNOWN whenever the link is down (lines…
- [Medium] yt8824_sds_isolate_and_softreset_paged() (lines 1060-1078) and
  yt8824_extern_config_sds_init_paged() hold the bus-wide MDIO mutex…
- [Low] yt8824_read_status_paged() calls genphy_c45_read_lpa() only when
  autoneg is enabled and complete (line 4602).
- [Low] In yt8824_probe(), phy_package_probe_once() sets the package
  'probed' bit through test_and_set_bit() before…

--

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
existing motorcomm driver. The driver uses the phy_package helpers to
reach the shared top extended register space. A package-wide mutex
serializes the UTP/SerDes space switching between the four ports.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..dfa0612d713cb 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -626,11 +935,1125 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

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
phy_select_page() takes the bus-wide mii_bus->mdio_lock and
phy_restore_page() releases it. That means this read_poll_timeout() sleeps
with the bus lock held. Because sleep_before_read is true, each call holds
it for at least 50ms and up to 600ms.

Is it ok to hold the global MDIO lock that long?

In 10G-QXGMII mode this path runs from soft_reset, suspend, resume and the
error restore paths, for each of the four ports. phy_init_hw() calls
.soft_reset and then .config_init, and yt8824_config_init() calls
yt8824_soft_reset() again. So a single port init goes through several of
these windows.

yt8824_extern_config_sds_init_paged() does the same thing. It holds the lock
across the whole SerDes init sequence and then runs another sleeping
BMCR_RESET poll at the end.

While the lock is held, the sibling ports' phy_state_machine() work, PHYs in
other packages and any switch on the same bus are all blocked. That can in
turn stall ethtool/RTNL users waiting on those phydev locks.

phy_read_poll_timeout() drops the bus lock between polls to avoid this. Here
that is harder, because the UTP/SerDes space select lives in the
package-common top-ext register.

> +	if (val < 0)
> +		ret = val;
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, old_page, ret);
> +}

[ ... ]

> +static int yt8824_config_utp_init_paged(struct phy_device *phydev)
> +{

[ ... ]

> +	/* 100M template amplitude */
> +	ctrl = FIELD_PREP(YT8824_DAC_IMID_CH3_ORG, 0x45);
> +	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CH2_ORG, 0x45);
> +	mask = YT8824_DAC_IMID_CH3_ORG | YT8824_DAC_IMID_CH3_ORG;
                                          ^^^^

[Severity: Medium]
Should the second term be YT8824_DAC_IMID_CH2_ORG?

ytphy_modify_ext() goes through __phy_modify(), which writes
(old & ~mask) | set. With CH2 left out of the mask, the CH2 field of
YT8824_DAC_IMID_CH2_CH3_CFG_ORG_REG becomes old | 0x45 instead of 0x45.

The three sibling writes to 0x46f, 0x470 and 0x471 include both fields in the
mask.

> +	ret = ytphy_modify_ext_with_lock(phydev,
> +					 YT8824_DAC_IMID_CH2_CH3_CFG_ORG_REG,
> +					 mask, ctrl);
> +	if (ret < 0)
> +		goto err_restore;

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

[Severity: High]
Is the SerDes and PLL setup done here really per-port?

yt8824_config_init() runs the whole SerDes sequence in
yt8824_extern_config_sds_init_paged() and the UTP sequence in
yt8824_config_utp_init_paged() for every PHY in the package. It does
this each time phy_init_hw() is called for that PHY:

phy_attach_direct() / mdio_bus_phy_resume()
  phy_init_hw()
    yt8824_soft_reset()
    yt8824_config_init()
      yt8824_extern_config_sds_init_paged()
      yt8824_config_utp_init_paged()

In 10G-QXGMII mode all four ports are multiplexed onto one SerDes
lane, which is also why the init sets
YT8824_CSR_AFE_MANUAL_CTRL_10P3125G.

yt8824_extern_config_sds_init_paged() rewrites the SerDes PLL, LDO and
training registers. It restarts calibration through
YT8824_RESTART_CAL_CTRL_REG and ends with a BMCR_RESET on the SerDes.

yt8824_config_utp_init_paged() toggles YT8824_PLL_DAC_RST. It also
drives the TX RESETB bits in YT8824_U0_CRS_RESET_REG and
YT8824_U1_CRS_RESET_REG low before releasing them.

If any of these registers are package-wide rather than per-port, then
attaching or resuming one port resets the shared lane, PLL and TX
paths. That happens underneath sibling ports that already have link,
so their traffic drops until the lane retrains. Many MAC drivers
connect the PHY from ndo_open, so a plain ifup on one port is enough to
trigger this.

phy_package_init_once() exists for this case. Other multi-port PHY
drivers such as mscc and qca807x use it so that only the first port
runs the package-global setup.

Could the global part be split into a helper guarded by
phy_package_init_once(), leaving only the per-port writes in
yt8824_config_init()? Which of the registers touched here are actually
shared between the four ports?

If the shared SerDes and PLL must be reprogrammed after the package
loses power across suspend, how should that work with the once bit?

[ ... ]

> +	ctrl = FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH0, 1);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH1, 1);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH2, 1);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH3, 1);
> +	mask = YT8824_U0_CSR_RESETB_TX_CH0 | YT8824_U0_CSR_RESETB_TX_CH1 |
> +	       YT8824_U0_CSR_RESETB_TX_CH2 | YT8824_U0_CSR_RESETB_TX_CH3;
> +
> +	ctrl = FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH0, 1);

[Severity: High]
Is a ytphy_modify_ext_with_lock() call on YT8824_U0_CRS_RESET_REG missing
here?

Earlier in yt8824_config_utp_init_paged(), the active-low U0 TX RESETB bits
are written to 0. The U0 release value and mask are built here, but ctrl and
mask are overwritten by the U1 values straight away. Only
YT8824_U1_CRS_RESET_REG is written afterwards.

This means U0 TX channels CH0-CH3 seem to stay in reset, while the function
still returns 0.

This path runs on every attach and resume, in both package modes:

phy_init_hw()
  yt8824_config_init()
    yt8824_config_utp_init_paged()

> +	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH1, 1);
> +	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH2, 1);
> +	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH3, 1);
> +	mask = YT8824_U1_CSR_RESETB_TX_CH0 | YT8824_U1_CSR_RESETB_TX_CH1 |
> +	       YT8824_U1_CSR_RESETB_TX_CH2 | YT8824_U1_CSR_RESETB_TX_CH3;
> +	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U1_CRS_RESET_REG,
> +					 mask, ctrl);

[ ... ]

> @@ -3104,6 +4527,449 @@ static int yt8821_resume(struct phy_device *phydev)

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
When autoneg is enabled but not complete (link down or renegotiation
pending), genphy_c45_read_lpa() is skipped. genphy_read_status() then calls
genphy_read_lpa(), which only clears the clause 22 partner bits:

drivers/net/phy/phy_device.c:genphy_read_lpa() {
    ...
	if (phydev->autoneg == AUTONEG_ENABLE) {
		if (!phydev->autoneg_complete) {
			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
							0);
			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
			return 0;
		}
    ...
}

Could a 2500baseT_Full bit from an earlier 2.5G negotiation stay in
phydev->lp_advertising and keep showing up in ethtool?

Other 2.5G drivers such as rtl822x_read_status() clear it explicitly with
mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0). The existing
yt8821_read_status() has the same pattern.

> +
> +	if (!phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;

[Severity: Medium]
Does this lose a forced speed/duplex when autoneg is disabled?

With AUTONEG_DISABLE, phylib keeps the user's forced setting only in
phydev->speed and phydev->duplex. genphy_read_status() has just restored
them from BMCR via genphy_read_status_fixed(). After one link-down poll they
are replaced with SPEED_UNKNOWN and DUPLEX_UNKNOWN.

On the next ifdown/ifup or resume:

phy_start() / mdio_bus_phy_resume()
  _phy_start_aneg()
    phy_sanitize_settings()
      phy_caps_lookup(SPEED_UNKNOWN, DUPLEX_UNKNOWN, supported, false)

No capability matches speed -1, so phy_caps_lookup() returns the slowest
supported mode. Then yt8824_config_aneg()->__genphy_config_aneg() takes the
speed < SPEED_1000 path, and genphy_setup_forced() programs 10Mb/s instead
of the forced 100/1000/2500.

genphy_read_status() and yt8821_read_status() leave the forced values alone
in this case.

> +		if (phydev->autoneg == AUTONEG_ENABLE)
> +			phy_resolve_aneg_pause(phydev);
> +		return 0;
> +	}

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
This may not be reachable in practice. phy_package_probe_once() sets the
package once bit with test_and_set_bit() before the DT parsing in
yt8824_phy_package_probe_once(), which can fail. The bit is not cleared
again on failure.

If another package member had already joined at that point, it would skip
the init and probe successfully with the default PHY_INTERFACE_MODE_INTERNAL.
It would not fail on the missing or unsupported motorcomm,package-mode.

However, phy_driver_register() sets PROBE_FORCE_SYNCHRONOUS. With
sequential probing, the failing PHY's devres release calls
phy_package_leave(), the refcount drops to zero and the shared struct is
freed, once bit included. The next joiner then starts fresh.

The !priv || !np check in yt8824_phy_package_probe_once() also looks
unreachable. of_phy_package_join() always sets shared->np, and priv is
allocated because priv_size is non-zero.

Would it be cleaner to validate the DT property before consuming the once
bit, or is the current ordering fine given synchronous probing?

> +
> +	return 0;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930194513.663575-1-kyle.switch%40motor-comm.com
