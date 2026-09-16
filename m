Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209933EDE7E;
	Wed, 16 Sep 2026 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541265; cv=none; b=Z8Ex468p0mXDCVTGMnUGGp4cGH2cly0BNuE3Y1b0zOWunYA0mVHhigurXLE5U++exnwxkUr3RDRx/eJlyUyqRimdmdc04/CKp06ZrStD7IZ2WeI4qf2IBLZd7nmIqukgkmgRr2mXdSRpn7P51iqX5ivbddmq59xxM/lBjcaPs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541265; c=relaxed/simple;
	bh=Shz+y+PGcxuROkvZnKD9eI6Al1q+lWT8CSWWRnqj8DA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZLZ+gwvfcMZXkhiMyXb34Pyaa72Fu1vvhFaW1DBGI8f+xhbv4z3rbw4mv8gZunuvwtC/GayALA+lHxssN+XNAj+LrPOQIhRKvHvz7xvFg/X+TaS/nbApEn+TMuUG7Y2vDnS+xGTHYeKDJ88GFwhENTm6hPp/DPsPBSH5d5K5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdjOOmRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdjOOmRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7803B1F00898;
	Wed, 16 Sep 2026 06:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541261;
	bh=r2kym4KRDmjsYqCFw7Sl0rygDL+A/S5TKEC/M/seOn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WdjOOmRJbooHygRPfNvbQ7uMeUVD3beeeBRi+YK3ljegHDV/iuLiuK06fCawDQykS
	 f2g0OmKyRqVSFmRzHd7BWN7WyUTwCaqnrsrDLBeGwr6vwOsTILQzlhp3wx3Kupnd3S
	 T+QN5nzh8abMRzmGsILjpDL2BReYcgG/dLtJ6vt1493hqI9vDlFlp1ixWzz8pxWFxh
	 TSd3OH/4rwp/J2i08PvnRuXpR+KI5wT1B3nYTfno38OpkQUi6c7CDHjPjAD7VZhZrx
	 7Y4L0BjQuZAO05EEz7uQiWZd3Ma2Klds3KHQsYPmlbdbHOEqlGqPEopifHBT9IpjAN
	 dyH1B+afFE03Q==
Subject: Re: [PATCH net-next v11 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:40 +0000
Message-ID: <178954126007.22033.1111190336627979779@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-15-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-15-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 5 · Low: 0

- [High] asix_ax88279_config_aneg() (drivers/net/phy/ax88796b.c:146-166)
  programs the vendor 2.5G advertisement bit (MII_ADVERTISE bit 12,…
- [Medium] asix_ax88279_get_features() (ax88796b.c:168-186) clears only
  ETHTOOL_LINK_MODE_100baseT_Half_BIT after…
- [Medium] asix_ax88279_read_status() (ax88796b.c:108) uses the return
  value of `phy_read(phydev, AX_CTRL_STATUS)` without checking for a…
- [Medium] asix_ax88772D_get_features() (ax88796b.c:207-223) removes only
  ETHTOOL_LINK_MODE_1000baseT_Full_BIT from the abilities produced by…
- [Medium] asix_ax88279_read_status() (ax88796b.c:99-144) has no `if
  (!phydev->link) return 0;` guard after genphy_read_status(): it…
- [Medium] In asix_ax88279_read_status() (ax88796b.c:128-133) the link-
  partner 2500baseT advertisement bit is only ever assigned inside the…

--

ax88796b: Add support for AX88772D, AX88179A and AX88279

The patch adds phy_driver entries and mdio device ids for the AX88772D,
AX88179A and AX88279 PHYs found in ASIX USB-Ethernet controllers, with
custom get_features, read_status, config_aneg and config_init callbacks
for the 2.5G part.

A few questions about the new callbacks below.

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
Should there be a link check here before the vendor decoding, the way
asix_ax88772a_read_status() does it?

drivers/net/phy/ax88796b.c:asix_ax88772a_read_status() {
	ret = genphy_update_link(phydev);
	if (ret)
		return ret;

	if (!phydev->link)
		return 0;
	...
}

When the link is down (or autoneg has not completed) genphy_read_status()
deliberately publishes an unknown state:

drivers/net/phy/phy_device.c:genphy_read_status() {
	...
	phydev->speed = SPEED_UNKNOWN;
	phydev->duplex = DUPLEX_UNKNOWN;
	...
}

asix_ax88279_read_status() then overwrites both, plus phydev->interface,
from the vendor register.  With no link AX_CTRL_STATUS reads 0, which
decodes to AX_CTRL_STATUS_SPEED_10, so does ethtool end up reporting
"10Mb/s, Full" on an unplugged port instead of Unknown?

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
Is the phy_read() return value missing an error check here?

These PHYs are internal to USB Ethernet controllers, so every MDIO access
is a USB control transfer that can fail with -EIO, -ETIMEDOUT or -ENODEV
on surprise removal.  The errno is then masked as if it were register
content, and since the switch covers all four values of the two-bit field
with no default, every error decodes to a concrete speed:

	(-EIO)      & 0x0c == 0x08 -> AX_CTRL_STATUS_SPEED_1000 -> SPEED_1000
	(-ETIMEDOUT) & 0x0c == 0x00 -> AX_CTRL_STATUS_SPEED_10   -> SPEED_10

The fabricated speed then selects phydev->interface further down, so the
MAC/PCS can be configured for 2500BASEX or SGMII based on an errno, and
the function still returns 0.  The MMD read a few lines below does check,
and asix_ax88772a_read_status() in the same file does:

	val = phy_read(phydev, MII_BMCR);
	if (val < 0)
		return val;

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
Can the 2500baseT bit in phydev->lp_advertising go stale here?

The bit is only ever assigned inside this branch.  If the MMD read fails,
or the new partner reports REMOK == 0, the previous value survives.

genphy_read_lpa() does not clear it either, it only touches the clause-22
partner modes:

drivers/net/phy/phy_device.c:genphy_read_lpa() {
		if (!phydev->autoneg_complete) {
			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
			return 0;
		}
	...
}

So after a 2.5G partner has linked up once and the cable is then moved to
a 1G partner, does ethtool keep listing 2500baseT/Full under "Link partner
advertised link modes"?  Would clearing the bit whenever the current read
does not positively establish 2.5G partner advertisement be better?  The
phy_read_mmd() error is also swallowed rather than propagated.

> +	/* Only supports full duplex */
> +	phydev->duplex = DUPLEX_FULL;
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

[Severity: High]
Is the 2.5G advertisement bit ever taken into an auto-negotiation session
here?  genphy_config_aneg() takes the restart decision before bit 12 of
MII_ADVERTISE is written.

Toggling ETHTOOL_LINK_MODE_2500baseT_Full_BIT does not change any register
that genphy_config_advert() writes, its MII_ADVERTISE mask does not contain
AX_ADVERTISE_2500 (0x1000):

drivers/net/phy/phy_device.c:genphy_config_advert() {
	err = phy_modify_changed(phydev, MII_ADVERTISE,
				 ADVERTISE_ALL | ADVERTISE_100BASE4 |
				 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM,
				 adv);
	...
}

so changed stays 0 and no restart is issued for a running, non-isolated
PHY:

drivers/net/phy/phy_device.c:genphy_check_and_restart_aneg() {
	if (!restart) {
		ret = phy_read(phydev, MII_BMCR);
		...
		if (!(ret & BMCR_ANENABLE) || (ret & BMCR_ISOLATE))
			restart = true;
	}

	if (restart)
		return genphy_restart_aneg(phydev);

	return 0;
}

phy_start_aneg() only calls phy_check_link_status() afterwards, and
phy_modify() discards the changed indication, so the new bit 12 value sits
in the register without BMCR_ANRESTART.  In the opposite case, where
something else did set changed, the restart happens while bit 12 still
holds its old value, so does the session negotiate the stale 2.5G
capability?

Would writing bit 12 before genphy_config_aneg(), or using
phy_modify_changed() plus an explicit genphy_restart_aneg(), fix both
directions?

> +
> +static int asix_ax88279_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
> +	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
> +
> +	linkmode_set_bit_array(phy_basic_ports_array, ARRAY_SIZE(phy_basic_ports_array),
> +			       phydev->supported);
> +
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* AX88279 does not support reported 100baseT-half duplex mode */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, phydev->supported);
> +
> +	return 0;
> +}

[Severity: Medium]
Should 10baseT_Half be cleared here too?

genphy_c45_pma_read_abilities() reaches the ext-abilities path (which is
what makes 100baseT_Half appear in the first place), and there the two
10 Mbit modes come from the same EXTABLE bit:

drivers/net/phy/phy-c45.c:genphy_c45_pma_read_ext_abilities() {
	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
			 phydev->supported,
			 val & MDIO_PMA_EXTABLE_10BT);
	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
			 phydev->supported,
			 val & MDIO_PMA_EXTABLE_10BT);
	...
}

So 10baseT half duplex stays in phydev->supported and hence in
phydev->advertising and MII_ADVERTISE, while asix_ax88279_read_status()
states the opposite and forces the result:

	/* Only supports full duplex */
	phydev->duplex = DUPLEX_FULL;

If a partner resolves 10baseT half duplex, the resolved DUPLEX_HALF is
replaced by DUPLEX_FULL and the MAC is configured for full duplex.  If the
PHY really cannot do half duplex, should the mode be dropped from
supported instead?  Which of the two is correct for this part?

> +
> +static int asix_ax88279_config_init(struct phy_device *phydev)
> +{
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces);
> +
> +	return 0;
> +}
> +
>  static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
>  {
>  	/* Reset PHY, otherwise MII_LPA will provide outdated information.
> @@ -94,6 +204,25 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
>  	}
>  }
>  
> +static int asix_ax88772D_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
> +
> +	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
> +	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* AX88772D does not support reported 1000baseT mode */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mask);
> +	linkmode_andnot(phydev->supported, phydev->supported, mask);
> +
> +	return 0;
> +}

[Severity: Medium]
Should the other gigabit modes be masked out as well on this 100 Mbit
part?  genphy_read_abilities() derives three modes from MII_ESTATUS:

drivers/net/phy/phy_device.c:genphy_read_abilities() {
		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
				 phydev->supported, val & ESTATUS_1000_TFULL);
		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
				 phydev->supported, val & ESTATUS_1000_THALF);
		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
				 phydev->supported, val & ESTATUS_1000_XFULL);
	...
}

Only 1000baseT_Full is removed, so if the AX88772D also reports
ESTATUS_1000_THALF or ESTATUS_1000_XFULL, those modes remain in
phydev->supported and phydev->advertising and are written to MII_CTRL1000
by genphy_config_advert().  Are those two bits known to be clear on this
part, or would masking the whole gigabit class be safer?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
