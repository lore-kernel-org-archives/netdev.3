Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47F50128A;
	Thu, 17 Sep 2026 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680313; cv=none; b=mefO46LDe2SDqMv1ofMek/vcFXmkxGAs4drvg28awv4Ow/NzGSQck1On/Y/LYjg722ftLJOdIrLNb7IRyNWeo0wyc0DNzTRzJa+5r7QHMGmIBqLT1B9lInnBHqLBi9R2vjEQcVDbztZOpF2kg1SccTITjITT80nhHlU/2u+vkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680313; c=relaxed/simple;
	bh=AJNg0INWg0uP51uHVifrRSa+WHTRl50GB/LU9vc4JtY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a3p9OA/8QaIpZYCwNbrbEnAFyDxz9xB6ONm2AYR+Iw9vE/xX3AzNRAdFAtocJhU0NzjxuMlWIrrzy1A7Nb6KFFzE+w1tL/xJXXyl+ktIx4IUlB/EO+Sbv1qfw8WynL+9OvcdPDNJwcYoSWQkAmdWn6qrgkR+2LJ2K4dchvfSStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMAUSNyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMAUSNyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587DA1F00899;
	Thu, 17 Sep 2026 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680310;
	bh=8G+i/EpNRePmqbFpV4i6HAV924/QPX6CFfEDsVpWMkg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jMAUSNyZq5LEPjLceiqinc8OtqUUyRt5Mz/85NI84/aSSn8SHeXctmtpOnKluGzev
	 M1N5R/nhxn367jnWPccDvbiLd5IWTPSZSYcDuRi0PafmJLP3wlkwVSkgGfr0EtTMYw
	 6ThSlNHNmrweNDglBzGKCVKOhvpCZXN5EKM/aCVCzSdjmPIxA0CFixk09glTAg7KAM
	 /I9zvZosnKpR3huasNZtZwsVVhDEn/t8YwnifOFeALtxAK8fNlLROgHrYxiFtJBrlX
	 71rekHekAmAqQB7hDWSRLwL9Ec+2QhLr8z9ENzaXaAUGaHiarY+kltg5ZCTXT0Vae8
	 F9BWzx7ItJ15Q==
Subject: Re: [PATCH net-next v12 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:08 +0000
Message-ID: <178968030887.22033.2787971070924550661@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-15-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-15-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 6 · Low: 0

- [Medium] asix_ax88279_config_aneg()
  (drivers/net/phy/ax88796b.c:146-166) programs the vendor 2.5G…
- [Medium] asix_ax88279_read_status()
  (drivers/net/phy/ax88796b.c:108-121) does not check the return value…
- [Medium] asix_ax88279_read_status() (drivers/net/phy/ax88796b.c:99-144)
  has no `if (!phydev->link) return 0;` guard.
- [Medium] asix_ax88279_read_status() hard-codes phydev->duplex =
  DUPLEX_FULL with the comment 'Only supports full duplex'…
- [Medium] In asix_ax88279_read_status() the link-partner 2.5G capability
  bit is only ever assigned inside `if (val >= 0 && val &…
- [Medium] net: phy: ax88796b: incomplete clearing of 1000baseT
  capabilities for AX88772D

--

ax88796b: Add support for AX88772D, AX88179A and AX88279

This adds phy_driver entries and matching MDIO ids for the AX88772D,
AX88179A and AX88279 PHYs found in ASIX USB-Ethernet controllers, plus
AX88279-specific get_features, read_status, config_aneg and config_init
callbacks.

A few questions about the new AX88279 callbacks below.

> diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
> index f20ddf6491499..62f6beb25f41e 100644
> --- a/drivers/net/phy/ax88796b.c
> +++ b/drivers/net/phy/ax88796b.c
> @@ -13,6 +13,19 @@
>  #define PHY_ID_ASIX_AX88772A		0x003b1861
>  #define PHY_ID_ASIX_AX88772C		0x003b1881
>  #define PHY_ID_ASIX_AX88796B		0x003b1841
> +#define PHY_ID_ASIX_AX88772D		0x003b772d
> +#define PHY_ID_ASIX_AX88179A		0x003b179a
> +#define PHY_ID_ASIX_AX88279		0x003b2790
> +
> +#define AX_ADVERTISE_2500		0x1000
> +
> +/* MII Vendor registers */
> +#define AX_CTRL_STATUS			0x1d
> +#define AX_CTRL_STATUS_SPEED_MASK	0x0c
> +#define   AX_CTRL_STATUS_SPEED_10	0x0
> +#define   AX_CTRL_STATUS_SPEED_100	0x4
> +#define   AX_CTRL_STATUS_SPEED_1000	0x8
> +#define   AX_CTRL_STATUS_SPEED_2500	0xc
>  
>  MODULE_DESCRIPTION("Asix PHY driver");
>  MODULE_AUTHOR("Michael Schmitz <schmitzmic@gmail.com>");

[ ... ]

> @@ -83,6 +96,103 @@ static int asix_ax88772a_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int asix_ax88279_read_status(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;
> +

[Severity: Medium]
Is clearing only 1000baseT_Full enough for a 100MBit part?

The comment says the AX88772D falsely reports 1000baseT, but
genphy_read_abilities() derives three gigabit modes from MII_ESTATUS
when BMSR_ESTATEN is set:

	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
			 phydev->supported, val & ESTATUS_1000_TFULL);
	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
			 phydev->supported, val & ESTATUS_1000_THALF);
	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
			 phydev->supported, val & ESTATUS_1000_XFULL);

Only ETHTOOL_LINK_MODE_1000baseT_Full_BIT is put into mask and removed
from phydev->supported here, so if the hardware also sets
ESTATUS_1000_THALF or ESTATUS_1000_XFULL those bits survive in
phydev->supported. They are then copied into phydev->advertising by
phy_probe()/phy_advertise_supported(), reported to userspace by
phy_ethtool_get_link_ksettings(), and accepted by
phy_ethtool_ksettings_set() since it validates the request against
phydev->supported. genphy_config_advert() would put ADVERTISE_1000HALF
in MII_CTRL1000 for a PHY that cannot do gigabit at all.

If the ESTATUS block is bogus on this part, would it be clearer to drop
all three bits, or to mask off the whole of MII_ESTATUS? Also, the mask
plus linkmode_andnot() dance is a long way of writing what the sibling
asix_ax88279_get_features() does with linkmode_clear_bit() -- is there a
reason for the difference here?

[Severity: Medium]
Should asix_ax88279_read_status() bail out here when the link is down?

genphy_read_status() only takes its "nothing changed" early return when
autoneg is enabled and both old_link and phydev->link are set. On a
link-down poll it falls through and does:

	phydev->speed = SPEED_UNKNOWN;
	phydev->duplex = DUPLEX_UNKNOWN;

The rest of this callback then overwrites both unconditionally, so with the
cable unplugged ethtool reports a speed decoded from AX_CTRL_STATUS and
"Duplex: Full" instead of Unknown/Unknown, and phydev->interface is flipped
based on a register that carries no valid speed.

The sibling callback asix_ax88772a_read_status() in this same file has:

	if (!phydev->link)
		return 0;

> +	/* Read actual speed from vendor register */
> +	val = phy_read(phydev, AX_CTRL_STATUS);
> +	switch (val & AX_CTRL_STATUS_SPEED_MASK) {
> +	case AX_CTRL_STATUS_SPEED_2500:
> +		phydev->speed = SPEED_2500;
> +		break;
> +	case AX_CTRL_STATUS_SPEED_1000:
> +		phydev->speed = SPEED_1000;
> +		break;
> +	case AX_CTRL_STATUS_SPEED_100:
> +		phydev->speed = SPEED_100;
> +		break;
> +	case AX_CTRL_STATUS_SPEED_10:
> +		phydev->speed = SPEED_10;
> +	}

[Severity: Medium]
Can a failed MDIO read turn into a fabricated link speed here?

phy_read() can return a negative errno, and this PHY is reached over USB
control transfers (ax88179_mdiobus_read() in
drivers/net/usb/ax88179a_devices.c), so -ENODEV/-ETIMEDOUT/-EPIPE are
ordinary outcomes on unplug or transport errors.

The value is masked without being checked, and since all four values of the
two-bit field have a case and there is no default, every errno decodes as a
speed:

	-EIO       (0xfffffffb) & 0x0c == 0x08 -> SPEED_1000
	-ETIMEDOUT (0xffffff8e) & 0x0c == 0x0c -> SPEED_2500
	-ENODEV    (0xffffffed) & 0x0c == 0x0c -> SPEED_2500

That speed then feeds the lp_advertising computation and the
phydev->interface selection below, and the callback still returns 0, so
phy_check_link_status() never sees the I/O failure. The MMD read a few lines
down does check val >= 0, and asix_ax88772a_read_status() uses:

	val = phy_read(phydev, MII_BMCR);
	if (val < 0)
		return val;

Would the same check be appropriate for AX_CTRL_STATUS?

> +
> +	/* MDIO_AN_10GBT_STAT_LP2_5G is broken, but we can deduce that
> +	 * the link-partner advertised 2500M if remotely AN succceded
> +	 * for link speed > 1000M and we locally have a link speed of
> +	 * 2500M
> +	 */
> +	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
> +	if (val >= 0 && val & MDIO_AN_10GBT_STAT_REMOK) {
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +				 phydev->lp_advertising,
> +				 phydev->speed == SPEED_2500);
> +	}

[Severity: Medium]
Can a stale 2500baseT/Full bit survive in phydev->lp_advertising?

This is the only assignment to that bit, and it is gated on both a
successful read and MDIO_AN_10GBT_STAT_REMOK. If the link then moves to a
1000M or 100M partner that does not set REMOK, or if the MMD read fails,
the bit set by the previous 2.5G partner is never cleared.

genphy_read_lpa() only touches the Clause 22 derived partner modes:

	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
	mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);

so it cannot clear this driver-added bit either. Userspace would keep
reporting 2500baseT/Full for a partner that never advertised it, and
phy_resolve_aneg_linkmode() can resolve that stale mode as the highest
common one.

The read error is also swallowed rather than returned. Was that intentional?

> +	/* Only supports full duplex */
> +	phydev->duplex = DUPLEX_FULL;

[Severity: Medium]
If the part only supports full duplex, should all half-duplex modes be
removed from phydev->supported?

asix_ax88279_get_features() clears only one of them:

	/* AX88279 does not support reported 100baseT-half duplex mode */
	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, phydev->supported);

but genphy_c45_pma_read_abilities() -> genphy_c45_pma_read_ext_abilities()
derives 10baseT_Half from the same hardware bit as 10baseT_Full:

	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
			 phydev->supported,
			 val & MDIO_PMA_EXTABLE_10BT);

so 10baseT_Half stays in phydev->supported. phy_ethtool_ksettings_set()
masks the requested advertisement against phydev->supported rather than the
phylink MAC capabilities, so "ethtool -s ethX advertise ..." including
10baseT/Half reaches genphy_config_advert() and puts ADVERTISE_10HALF on the
wire. If the partner links half duplex, this line still reports DUPLEX_FULL
to the MAC.

Would clearing the remaining half-duplex bits in get_features, or resolving
duplex from hardware, be preferable?

> +
> +	/* PHY switches interface between 2.5GBit and slower modes */
> +	if (phydev->speed == SPEED_2500)
> +		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
> +	else
> +		phydev->interface = PHY_INTERFACE_MODE_SGMII;
> +
> +	return 0;
> +}
> +
> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
> +{
> +	bool adv_2500;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = genphy_config_aneg(phydev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	adv_2500 = linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising);
> +	ret = phy_modify(phydev, MII_ADVERTISE, AX_ADVERTISE_2500,
> +			 adv_2500 ? AX_ADVERTISE_2500 : 0);
> +
> +	return ret;
> +}

[Severity: Medium]
Does the vendor 2.5G advertisement bit get negotiated after this write?

genphy_config_aneg() ends with the restart decision:

	return genphy_check_and_restart_aneg(phydev, changed);

and "changed" comes from genphy_config_advert(), whose mask does not include
bit 12:

	err = phy_modify_changed(phydev, MII_ADVERTISE,
				 ADVERTISE_ALL | ADVERTISE_100BASE4 |
				 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM,
				 adv);

So for a request that differs only in 2500baseT/Full,
genphy_check_and_restart_aneg() sees no change, autoneg enabled and
isolation clear, and returns without writing BMCR_ANRESTART:

	if (restart)
		return genphy_restart_aneg(phydev);

	return 0;

AX_ADVERTISE_2500 is then written here with no restart following, and
_phy_start_aneg() does not issue one either, so the new advertisement is
accepted but never put on the wire.

In the opposite case, where a standard bit did change, the restart happens
inside genphy_config_aneg() before AX_ADVERTISE_2500 is programmed, so
negotiation can run with the previous 2.5G advertisement.

Would it work to program the vendor bit with phy_modify_changed() first and
pass that result into __genphy_config_aneg(phydev, changed)?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
