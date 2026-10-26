Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056026;
	b=eFawxiEvgO/Uw+ENro9MOrZIRCe7BnhBaMacgIhHFJRSzulu5iK8qrybYoIl0GNzlZJr
	 2Q2JE/fRO5YAu8eH4ltkXOnpxFBuNplp+XRZC7aeU+yw21Bv8az3nWaPrac/A4CxcD3vB
	 7TGm4O6eHjWJg10BQNqNzK5uDX43qkVqSIm8U3Kus7pjda8hGyu7x/OOS0RMyj2Yle6vT
	 hhYftJoiZAPdUUq4oWOhAdizuhOguZ0wO3WQHRPvNsJdb2Hq0PgnUXrHMLFAhi51AkTQS
	 tyOyYUjkjwvvVHGK1RtiNdQE5HvYMThHmsVW5H2k29GQAfpxQrGpMk+7Zvu2ghKSAtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056026;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fEhOkaDx2BgDet9fiHWZORtpi+Ys8XjfTncuGtwe+Q4=;
	b=GKaSVd4dAFY4KCQ+Kn2EjTXf7YlSlEP4Fi8Rk0CYqXgKRaw8sBB9lCU95Q0NXx9MkEYI
	 VMd44kpa9bnqXAao5PqKd6iXQ2mjihD0Pb1jSRA1QxIfZvHsft4ifH656ndVrqEXfZYMj
	 ty9zLjdKsc9zh/Ku1eOypEhZWYjw3o0YloYHeLvcV/A3+nSf+bkiy1fCpfmwMyKdyUvwp
	 QJpcqdzTV5FegE+ZZ63+PAX1ckahuWyh27DyPFZnoA5ym/Pm2Z2Uyn4D87do3IC6PaAH8
	 sJK99SAqJZCHTIpb9mUUOGEHvzOPxvu1TZ1XwgPV9+JWZ/SCp+uzltz/d/9DWgahnsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvFqaGpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE0606A321;
	Mon, 26 Oct 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvFqaGpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB31F031E2;
	Mon, 26 Oct 2026 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056026;
	bh=fEhOkaDx2BgDet9fiHWZORtpi+Ys8XjfTncuGtwe+Q4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cvFqaGpFA1IS8qCjr5l4WaoeMSXiC6E83BbvjvhSqN7d0IIQcuTJXndlcXVFogg5e
	 487GxxoJFVxj+PlEHaX3RrOFg5pil3SIzor8r5raPMoZykWvIr6MUu2YJNZmytD+5t
	 sz7Sjwv2mdVj+5KC76PNk84S9NcAeeKvand9cfJ0F62iQ+NwfuzYcZpDr82U397Kf4
	 RsbwqduppX9AKt2Fo/cayIOf4jWoPugrD722v/KL+BXBw37gQuU/82qPOzolstzOpI
	 j5s5AJ2Os5D1OTsO/qrjPh9tIsOBrM/nEtzZieBhjCoJsPrmf6jP5Zc9eFzbJ99DY9
	 EPWg/jDWbPf4g==
Subject:
 Re: [PATCH net v2 2/4] net: phy: as21xxx: fix read_status speed handling
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:07:05 +0000
Message-ID: <179305602514.3134.16371797549825264348@kernel.org>
In-Reply-To: <20261022222955.698722-2-ansuelsmth@gmail.com>
References: <20261022222955.698722-2-ansuelsmth@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With autoneg enabled, as21xxx_read_status()
  (drivers/net/phy/as21xxx.c) now takes the duplex for 1000/100/10 links…
- [Medium] With autoneg enabled, as21xxx_read_status() now reads and
  decodes VEND1_SPEED_STATUS (MMD VEND1 0x4002) whenever the cached…
- [Low] The commit message does not match several behaviour changes in
  the patch.

--

net: phy: as21xxx: fix read_status speed handling

This commit reworks as21xxx_read_status() so that the speed always comes
from the vendor VEND1_SPEED_STATUS register, including when autoneg is
enabled. It also changes the switch to mask with VEND1_SPEED_MASK. The
generic link partner registers are now used only to resolve pause, through
phy_resolve_aneg_pause().

> With further test with 2.5G NIC it was discovered that
> phy_resolve_aneg_linkmode is not enough to detect speed higher that 1G
> when autoneg is enabled.

[ ... ]

> Rework the read_status code to always read the speed from the vendor
> register and parse the generic bit only for the pause frame.

[Severity: Low]
Could the commit message explain why phy_resolve_aneg_linkmode() was not
enough?

The removed genphy_c45_read_lpa() already read MDIO_AN_10GBT_STAT and set
the partner's 2.5G/5G/10G bits before resolution. The new code reads the
same register to fill lp_advertising:

    val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
    ...
    mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, val);

The message doesn't say whether that register is reliable on this PHY. If
it isn't, the partner modes reported to userspace would still be wrong.

The message also leaves out a few behaviour changes:

- In as21xxx_read_c22_lpa(), the base page partner advertisement now
  comes from the mapped C22 MII_LPA instead of C45 MDIO_AN_LPA. The
  partner Autoneg bit therefore comes from LPA_LPACK instead of
  MDIO_AN_STAT1_LPABLE.

- Forced 10/100 used to always report DUPLEX_FULL and now reports the
  BMCR_FULLDPLX bit. Only the v2 changelog below the --- line mentions
  this, and that part is dropped when the patch is applied.

- The default -EINVAL return in the vendor speed switch can now be
  reached with autoneg enabled.

Since the patch carries a Fixes: tag, could the commit message describe
these changes too?

> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index 0db82da8dbdf3..519b78d3579d3 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c

[ ... ]

> @@ -720,58 +729,73 @@ static int as21xxx_read_status(struct phy_device *phydev)
>  	phydev->asym_pause = 0;
>  
>  	if (phydev->autoneg == AUTONEG_ENABLE) {
> -		ret = genphy_c45_read_lpa(phydev);
> -		if (ret)
> -			return ret;
> +		if (!phydev->autoneg_complete) {
> +			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
> +							0);
> +			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> +			mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> +			return 0;
> +		}

[Severity: Medium]
Can phydev->autoneg_complete be stale when this guard checks it?

as21xxx_read_link() returns early when ANRESTART is set, before it updates
autoneg_complete:

    if (*bmcr & BMCR_ANRESTART) {
        phydev->link = 0;
        return 0;
    }

If the previous poll saw the link up, autoneg_complete is still 1, so
renegotiation skips this guard. One example is
_phy_start_aneg()->phy_config_aneg()->phy_check_link_status() running
before ANRESTART self-clears.

The removed genphy_c45_read_lpa() re-read MDIO_STAT1 on every call. The
code also falls through when AN complete is still set but LSTATUS has
dropped.

In both cases the code goes on to decode VEND1_SPEED_STATUS while the link
is down or renegotiating, which can cause two problems.

First, VEND1_SPEED_10 is encoded as 0, so a zero or unresolved register
value is reported as a 10 Mbps link. If the register lags behind link up,
the "why bother the PHY if nothing can have changed" shortcut keeps that
speed until the link drops.

Second, any value outside the six documented codes hits the default
-EINVAL. phy_state_machine() turns that into phy_error_precise() and
PHY_ERROR. Before this patch, that path could only be reached with autoneg
disabled.

Should this guard use a fresh AN status read, or should the vendor speed
read be skipped when phydev->link is 0? The later patches in the series
don't seem to change this code.

>  
>  		ret = as21xxx_read_c22_lpa(phydev);
>  		if (ret)
>  			return ret;
>  
> -		phy_resolve_aneg_linkmode(phydev);
> -	} else {
> -		int speed;

[ ... ]

> +	switch (speed & VEND1_SPEED_MASK) {

[ ... ]

> +	case VEND1_SPEED_1000:
> +		phydev->speed = SPEED_1000;
> +		if (bmcr & BMCR_FULLDPLX)
>  			phydev->duplex = DUPLEX_FULL;

[ ... ]

> +		else
> +			phydev->duplex = DUPLEX_HALF;
> +		break;

[Severity: Medium]
With autoneg enabled, does BMCR_FULLDPLX report the negotiated duplex for
the 1000/100/10 cases?

Before this patch, the autoneg duplex came from
phy_resolve_aneg_linkmode(), which intersects advertising with
lp_advertising. BMCR bit 8 is a forced mode control bit (IEEE 802.3
22.2.4.1.8). genphy_read_status_fixed() reads it only for
AUTONEG_DISABLE.

Nothing on the autoneg path writes this bit. genphy_restart_aneg() only
sets BMCR_ANENABLE | BMCR_ANRESTART, while genphy_setup_forced() rewrites
the whole BMCR.

For example, if the user forces 100/half and then turns autoneg back on,
BMCR_FULLDPLX stays clear. Every later autonegotiated 10/100/1000 link
would then be reported as half duplex. A 1000/half result also looks
impossible here, because 1000baseT_Half doesn't seem to be advertised.

The reverse also applies: if the bit is left at 1, a link that negotiated
half duplex would be reported as full.

A wrong duplex also disables pause, because phy_resolve_aneg_pause() only
resolves it for full duplex:

    if (phydev->duplex == DUPLEX_FULL) {
        phydev->pause = linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, ...

Unless the vendor mapped C22 BMCR mirrors the resolved duplex, should the
autoneg case get the duplex from the advertisement intersection, as it did
before? The later patches in the series don't seem to change this either.

[ ... ]

> +	if (phydev->autoneg == AUTONEG_ENABLE)
> +		phy_resolve_aneg_pause(phydev);
> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022222955.698722-1-ansuelsmth%40gmail.com
