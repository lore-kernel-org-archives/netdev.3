Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356323;
	b=WCGeToPPHpi+a4uTO2qlGxc5+/Sr/7sHJCevYXK+WvLS85MS9HgvVlRXaf4aZL6TdTsf
	 OE/4SoW0vJthabm0otAe5EGv8dtSJXO0g+aJZ5rYvB5aMlN+yucdTTTGguBDRxdAiHzZV
	 PHVHCuMTOF3Sd6QjatUQ49gZQXrbxnpTjFWlStfVZQBqyt2mxL7Nld8cYIZLu9NttXqu0
	 gEqnswf1wL451X9wKdEWdWz8xVqVwNcE1oYE4akvbeV+q4UQxb4ufYIKAaTI3PDBSJsCY
	 ctBWThB1wUhvyJeTvnmefwDk2ofpOgf+N/+8WVS9QyTf8aVA+iio3esJFAZMLYF0lIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=r2Pi3UPi3G0rlz5GR/udFlpLVelhT3JmBXJfXkPJE7k=;
	b=0pmSy4nXAhDuMbyuG0RxpXML9UBs5UE+pYyyxGSGmn+Ax05sxhwdUd47OUXfQ2PddsTq
	 Vc84g7CDctRYhnXbrz96wtjw2VsH+o6mC/ySzTKL08bJBhxmI+onRsBZ2oIDdwCHXzJhY
	 PHRpt8uG5ps50yFslVl6bT13MfMqcJqHKV8uU2YLAWbpLaVU917hmSoOjuJN10VL7Zttd
	 JKQz3nZJ92NSAIQ2C1HuOY440qrSPaT0+rhfeR3Mk+ACF0ws83kOxvR+2R3XlFtNIODGK
	 6YLBxD864iisMcXI9nrFE/Qqudto7xTqgUN8qZPFFhF2JgcTk+QPEHOc7aNyqRO7Gaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nlS/Mdj7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B7606A321;
	Fri, 30 Oct 2026 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlS/Mdj7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5031F00A02;
	Fri, 30 Oct 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356322;
	bh=r2Pi3UPi3G0rlz5GR/udFlpLVelhT3JmBXJfXkPJE7k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nlS/Mdj79wamF46iTgBwc/sX7gKaxA90myb7Fjt/Lqzy28kotifOBKBN35nXK9N7b
	 1V7nyDtZweRzxy8s3osXVonUza+WmnzCiMnaFmYnFla3Uzj+6rbutBc9x8brdL7Q4a
	 9Q+ejOcAF1G9zBFKeXRQDiql+Q7EniJlWqJBa+obtFLUklSmLcvDKGMRSS/0BP2s8+
	 2bUxTVmuxElXLDYh6+38Y/9P81pBNr5L87Frei11JJFVx8MbNISNsjzInoVI50HRXq
	 GtGZ1eDRKvQhPSmF4AF4Z05fmhWRyRO0pd3CX9Wtu+t1VhRDV4FjMk8D+Je02wgazk
	 nX2uOwcXNBiuQ==
Subject:
 Re: [PATCH net v3 2/4] net: phy: as21xxx: fix read_status speed handling
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 10:32:01 +0000
Message-ID: <179335632134.3134.7804602022043442736@kernel.org>
In-Reply-To: <20261028073024.25175-3-ansuelsmth@gmail.com>
References: <20261028073024.25175-3-ansuelsmth@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With AUTONEG_DISABLE, as21xxx_read_status() no longer takes
  speed/duplex from the PHY.
- [Medium] In autoneg mode, as21xxx_read_status() now reads
  VEND1_SPEED_STATUS on every link-up, which is the PHY's own report of…
- [Medium] The new early `if (!phydev->link) return 0;` in
  as21xxx_read_status() (drivers/net/phy/as21xxx.c:732-733) makes the…
- [Medium] In forced mode (AUTONEG_DISABLE), phydev->speed/duplex hold
  the user's configuration.
- [Medium] net: phy: as21xxx: missed pause and <=1G speed in
  as21xxx_read_status()
- [Low] VEND1_SPEED_STATUS is now read on every autoneg link-up as well
  as in forced mode.

--

net: phy: as21xxx: fix read_status speed handling

This patch reworks as21xxx_read_status() to use the VEND1_SPEED_STATUS
vendor register for speeds above 1G. Speeds of 1G and below come from
phy_resolve_aneg_linkmode() in autoneg mode and from
genphy_read_status_fixed() in forced mode. It also changes the switch mask
to VEND1_SPEED_MASK, reads MII_LPA from the mapped C22 space, and clears
autoneg_complete when AN is restarted.

> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index 0db82da8dbdf3..f5968eec11c85 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c

[ ... ]

> @@ -719,57 +729,63 @@ static int as21xxx_read_status(struct phy_device *phydev)
>  	phydev->pause = 0;
>  	phydev->asym_pause = 0;
>  
> +	if (!phydev->link)
> +		return 0;
> +

[Severity: Medium]
With AUTONEG_DISABLE, phydev->speed and phydev->duplex hold the forced
configuration. Just above this, as21xxx_read_status() does:

	phydev->speed = SPEED_UNKNOWN;
	phydev->duplex = DUPLEX_UNKNOWN;

The "why bother the PHY" shortcut only applies to AUTONEG_ENABLE.

In forced mode with the link down, does this new early return mean nothing
puts those values back? genphy_read_status() re-reads the fixed settings
whatever the link state is.

On the next _phy_start_aneg(), for example after ip link set down/up or
resume, phy_sanitize_settings() calls phy_caps_lookup() with
SPEED_UNKNOWN/DUPLEX_UNKNOWN. Nothing matches, so it falls back to:

	if (!match && !exact)
		match = last;

That is the slowest supported mode, which can be 10/half.

Would the PHY then be reprogrammed at that rate instead of the speed the
user forced?

The later patch in this series, "net: phy: as21xxx: force C45 OPs for
AUTONEG", makes as21xxx_config_aneg() call genphy_c45_pma_setup_forced().
That function returns -EINVAL for anything other than DUPLEX_FULL. With
that patch, could the PHY end up in PHY_ERROR on every restart until it is
reconfigured with ethtool?

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
Is this block reachable? as21xxx_read_link() sets link to 0 on
BMCR_ANRESTART. It also does:

	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
		phydev->link = 0;

After the new !phydev->link early return, autoneg_complete is therefore
always 1 at this point. For the same reason, the autoneg_complete test in
the phy_resolve_aneg_linkmode() condition below is redundant.

Does this mean lp_advertising is no longer cleared when the link drops or
AN restarts? Before this patch, genphy_c45_read_lpa() cleared the partner
bits when AN was not complete, and the forced branch always ran
linkmode_zero().

phylib zeroes lp_advertising only in PHY_HALTED, and
phy_ethtool_ksettings_get() copies it out unconditionally. Would ethtool
then keep showing the old link partner's advertised modes after the cable
is unplugged?

[ ... ]

> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> +		phy_resolve_aneg_linkmode(phydev);
> +	} else if (phydev->autoneg == AUTONEG_DISABLE) {
> +		ret = genphy_read_status_fixed(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Medium]
Before this patch, genphy_c45_read_lpa() set phydev->pause and
phydev->asym_pause directly from LPA_PAUSE_CAP and LPA_PAUSE_ASYM.
With that call gone, pause is only resolved by phy_resolve_aneg_pause()
inside phy_resolve_aneg_linkmode(). That helper only updates pause
when phydev->duplex is already DUPLEX_FULL at the time it runs.

phy_resolve_aneg_linkmode() only sets duplex when
phy_caps_lookup_by_linkmode() finds a match in lp_advertising &
advertising. The commit message suggests the >1G partner bits are not
usable on this PHY. If that is so, and there is no common <=1G
full-duplex mode (for example when only 2.5G/5G/10G is advertised),
duplex is still DUPLEX_UNKNOWN here.

The VEND1_SPEED_STATUS switch below then sets DUPLEX_FULL for the
2500/5000/10000 codes. Nothing resolves pause again after that.

Wouldn't that leave pause and asym_pause at 0 on a full-duplex >1G
link even when the partner advertised pause? The MAC would then come
up without flow control.

The same ordering causes the downshift problem with the 1000/100/10
cases below. If the mode resolved here is above the rate VEND1
reports, phydev->speed keeps the value taken from the advertisement
rather than the actual link rate.

Could speed and duplex be taken from VEND1 for every code first, with
phy_resolve_aneg_pause() called after the switch?

[Severity: Medium]
Can genphy_read_status_fixed() be trusted on this PHY? It does a plain C22
read:

	int bmcr = phy_read(phydev, MII_BMCR);

It then takes speed from BMCR_SPEED1000/BMCR_SPEED100 and duplex from
BMCR_FULLDPLX. as21xxx_read_link() deliberately avoids that register:

	/* Normal C22 BMCR report inconsistent data, use
	 * the mapped C22 in C45 to have more consistent link info.
	 */

The mapped bmcr value it returns is no longer used anywhere in
as21xxx_read_status(). The VEND1_SPEED_1000/100/10 cases below only
break, so for forced 10/100/1000 the reported values come from the native
BMCR.

With the later patch in this series, "net: phy: as21xxx: force C45 OPs for
AUTONEG", forced mode is set up only through genphy_c45_pma_setup_forced()
(PMA/PMD CTRL1/CTRL2, full duplex only). The native BMCR is then never
written.

Could this report DUPLEX_HALF, or a speed that differs from what VEND1
reports?

There is also the case of an MDIO bus with no C22 read callback. There,
__mdiobus_read() returns -EOPNOTSUPP, which would now leave read_status
and put the PHY in PHY_ERROR. The old forced path made no C22 access.

[ ... ]

> +	speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> +			     VEND1_SPEED_STATUS);
> +	if (speed < 0)
> +		return speed;
> +
> +	switch (speed & VEND1_SPEED_MASK) {
> +	case VEND1_SPEED_10000:
> +		phydev->speed = SPEED_10000;
> +		phydev->duplex = DUPLEX_FULL;
> +		break;

[ ... ]

> +	case VEND1_SPEED_1000:
> +	case VEND1_SPEED_100:
> +	case VEND1_SPEED_10:
> +		break;

[Severity: Medium]
In autoneg mode the hardware-reported rate is now read on every link-up.
For 1000/100/10, though, it is discarded, and phydev->speed/duplex keep
whatever phy_resolve_aneg_linkmode() set: the highest mode both sides
advertise.

The commit message says phy_resolve_aneg_linkmode() is "not enough" for
this PHY, but it stays the only source at 1G and below. Two cases look
like problems.

Suppose lp_advertising contains a mode above 1G (MDIO_AN_10GBT_STAT is
now read), but the link trains at 1G or 100M, for example after a firmware
downshift. Would read_status report 2.5G while VEND1 says 1G?

If the common advertisement has no match, would the link be reported up
with SPEED_UNKNOWN/DUPLEX_UNKNOWN even though VEND1 holds a valid code?

Would it make sense to set speed and duplex from VEND1 for all six codes?

> +	default:
> +		return -EINVAL;
>  	}

[Severity: Low]
Before this patch, VEND1_SPEED_STATUS was read only in forced mode. It is
now read on every autoneg link-up as well. Any value outside the six known
codes lands here. _phy_state_machine() turns the -EINVAL into
phy_error_precise(), which leaves the PHY in PHY_ERROR.

Can this firmware-maintained register hold a transient or unlisted value
at link-up? If so, would it be safer to keep the resolved speed than to
fail read_status?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028073024.25175-1-ansuelsmth%40gmail.com
