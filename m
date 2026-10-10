Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120874BEE53;
	Sat, 10 Oct 2026 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661235; cv=none; b=LliurMqlhYexULooZjGOvoczJEKGWCAmYnvjpb7rSp1EbEK07g6/BUmvmu5CvtoiVhKNdmL/UPXo8E1Tfo/ikoGW/B5dCLveujL17783Jh8Pkna5eIaGNfxUIT9GwdAfcBNtodqLrnnWhYf3vj2RQx0VMBAabgxTch3Ez+n5yaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661235; c=relaxed/simple;
	bh=2xHHTBibhKIPxt+dbbmjTGYHjjR8pLNNaXOO0z6XGPc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUU5YGyrf3ifN5IdPAAuqjJIeyWWvUdkmHQh91qUiS6JpadQjUTf203+FAIthrCov/SzpuQzyF44XK5VStTuZ99ljKKKQbrEXZKjEwRPKhiGN+30PZAuHbTsmlyoExdDUxNTdduypm0JW49zXCPDisXRgzgGwT5psqscQcil1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX/vtyVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX/vtyVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EB1F000FF;
	Sat, 10 Oct 2026 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661231;
	bh=giIBFlTs8SzRK0bKKBttRruO32bFt+Z8PnSWRPOMI+I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PX/vtyVJmXlGm/CJ7dxCM9ZuTHGAn8isUTH91rp5DdeQ9DUExuE5yX8fiKiq7xwtQ
	 qWewauv8OIvFD5szuA799o5FUxeuglkKjt4GPPtK/AIi5CYmwyHOoHtlC9XNk+/OdT
	 ZMVTCKNVErbv/n65pjiTzvK+vNoSUSxfe4ROTsISVnHReM+Wiy3q6kCCEylWVh0Uli
	 RwtUVCG4/YBjluthUND0YQx6Nc/AyYZzq/iQTm5njVhyrze0txib33vDlRDvXGGXcw
	 StF629TtwdnSZ1L/WPGrLKJCTkrWKtwHbyjI7/L3FGKESKAMxZwmIb8CxMcYksh9bT
	 R8mPzt13WnKNg==
Subject:
 Re: [PATCH net-next v9 11/11] net: phy: ncn26000: Support for loopback
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:29 +0000
Message-ID: <179166122916.434549.9063503265267082319@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-11-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-11-dcefe1d0bf0d@onsemi.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds loopback support for the S2500 by pointing
  .set_loopback at genphy_loopback_no_speed().
- [Low] The kernel-doc for genphy_loopback_no_speed() does not match the
  code.

--

net: phy: ncn26000: Support for loopback

This patch adds a generic helper, genphy_loopback_no_speed(), that only
toggles BMCR_LOOPBACK and rejects a speed when loopback is enabled. It
uses the helper as .set_loopback for the S2500 entry in ncn26000. It also
converts dp83867 from its private dp83867_loopback() to the new helper.

> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index a33ebb2a7ecef..de0fafda38761 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c
> @@ -178,6 +178,7 @@ static struct phy_driver ncn26000_driver[] = {
>  		.config_aneg           = ncn26000_config_aneg,
>  		.read_status           = ncn26000_read_status,
>  		.handle_interrupt      = ncn26000_handle_interrupt,
> +		.set_loopback          = genphy_loopback_no_speed,

[Severity: Medium]
Can ncn26000_config_aneg() quietly take the PHY back out of loopback? It
writes the whole BMCR and does not keep BMCR_LOOPBACK:

drivers/net/phy/ncn26000.c:ncn26000_config_aneg() {
    ...
	// bring up the link
	return phy_write(phydev, MII_BMCR, NCN26000_BCMR_LINK_CTRL_BIT);
}

genphy_setup_forced(), by contrast, keeps the bit:

	return phy_modify(phydev, MII_BMCR,
			  ~(BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN), ctl);

genphy_loopback_no_speed() sets bit 14 and returns. Nothing in the aneg
path checks phydev->loopback_enabled.

Here is one ordering that seems reachable. Bringing the interface up calls
phy_start(), which sets PHY_UP and queues the state machine. If ethtool -t
(net_selftest) takes phydev->lock in phy_loopback(true, 0) before that
work runs, the work then does:

phy_state_machine()
  _phy_state_machine()          /* PHY_UP */
    _phy_start_aneg()
      phy_config_aneg()
        ncn26000_config_aneg()
          phy_write(phydev, MII_BMCR, ...)   /* clears BMCR_LOOPBACK */

A cable test that finishes during the self-test (PHY_CABLETEST to PHY_UP)
reaches _phy_start_aneg() the same way.

phy_check_link_status() returns early when phydev->loopback_enabled is
set, so the mismatch is never noticed.

Wouldn't the net_selftest frames then go out onto the shared 10BASE-T1S
medium instead of looping back inside the PHY? That would make the
self-test report false failures, and the final phy_loopback(false) would
clear a bit that is already clear.

The old genphy_loopback() fallback also wrote BMCR_LOOPBACK. With this
helper, though, loopback actually engages, so the new feature depends on
config_aneg leaving bit 14 alone.

Should ncn26000_config_aneg() preserve BMCR_LOOPBACK, for example by using
phy_modify() instead of phy_write()?

>  		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
>  		.get_plca_cfg          = genphy_c45_plca_get_cfg,
>  		.get_plca_status       = genphy_c45_plca_get_status,
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index bfce8b893644f..03419f6455875 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2791,6 +2791,28 @@ int genphy_resume(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL(genphy_resume);
>  
> +/**
> + * genphy_loopback_no_speed - Helper to modify the PHY loopback mode
> + * without setting speed. Some PHYs, like 10Base-T1S, don't support
> + * auto-negotiation and therefore setting the speed isn't supported.
> + *
> + * @phydev: The phy_device struct
> + * @enable: Flag to enable or disable the PHY level loopback.
> + * @speed: Speed setting. Not expected to be set. Error if it is set.
> + *
> + * Returns: 0 if successful, negative error code on failure.
> + */
> +int genphy_loopback_no_speed(struct phy_device *phydev, bool enable,
> +			     int speed)
> +{
> +	if (enable && speed)
> +		return -EOPNOTSUPP;

[Severity: Low]
This isn't a bug, but the @speed description says "Error if it is set".
The code only returns -EOPNOTSUPP when enable && speed. A disable call
with a non-zero speed succeeds.

That behaviour matches the set_loopback contract in include/linux/phy.h,
where EOPNOTSUPP only applies when loopback is enabled with speed > 0.
Could the kernel-doc describe it that way?

The reason given about 10Base-T1S not supporting auto-negotiation also
fits poorly with dp83867. This patch converts dp83867 to the same helper,
and it is a gigabit PHY that supports autoneg.

Would something like "speed selection in loopback is not supported"
describe the helper more accurately?

> +
> +	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
> +			  enable ? BMCR_LOOPBACK : 0);
> +}
> +EXPORT_SYMBOL(genphy_loopback_no_speed);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
