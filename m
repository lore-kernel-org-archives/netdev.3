Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39004C10F8;
	Sat, 10 Oct 2026 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661237; cv=none; b=n2L1uhrp+da/gtV3CRVvC4s9SkeYZAzVdok3rsXVZrJhFPAyEIw27diRtppI85DwElp6llyF5AGAubFdrDCQhWOTYygSFdc7Cdg0EQZ7Zp3hXXPb7rC/rRuDzgDhh8HWNBl9zChSiXVYUD3ckgm1laja7oSdD2khxEVx2zsDQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661237; c=relaxed/simple;
	bh=GUBFWkXfhXltbnaZuVslhKmju7dqE874fnspU5gyWRU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJAeN2NaO2XeyqQH7LMNyXHArkvok6bQvxvpV5REx9b9rvqeLS7uC0fIxl4NEwzpx/fErlu9V7hMV0PM0uS6sXWPbkK1ncrgHcQ+vOi4VOZ3PRYlIFuQGM5oyk7YPpTkWyccssmRXTMl87R/8VyycTJNSlVXbdOI6x0ffftpYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0kX1eEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0kX1eEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730AD1F00899;
	Sat, 10 Oct 2026 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661229;
	bh=LnD8J2KcaI+gv3WBX2KIvBt99UZsK/idX/3+1TkS4xA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c0kX1eEYhE2cfwIqss7SNBiFDpiWfKprvGeazTslSNxlT4ZQ3jarcUeL+pE2fQ+WX
	 P/BCtZOP5mG/FxGtLYV01IpyB98KlhXw6aRLbxINrllltVTGkBemlwqOhItHA5oTbW
	 Y7Ason2kE21htbz7wr6J73fkwaTHyTd0Ksy0zfWA40c+tiy0XKqAei+6Rt/eMR5bR1
	 /GQIxyLS2pTJeAkJGKunPneHPOphykqYeMjU7lcBWEEAZUJR2CBXUM6B5mc+SJQFO4
	 UAjDaGvwXVg91/JkEti9K8xIRwFVrLeuN2GRnT6bznwFWCYS/lTu1HLE5yLiVaWhL6
	 P/WE79GJzgMRQ==
Subject: Re: [PATCH net-next v9 10/11] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
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
Date: Sat, 10 Oct 2026 19:40:26 +0000
Message-ID: <179166122697.434549.4781991463001466231@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-10-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-10-dcefe1d0bf0d@onsemi.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In this patch, the new S2500 entry in ncn26000_driver[]
  (drivers/net/phy/ncn26000.c, lines 172-191) has no .set_loopback…
- [Low] The help text for the NCN26000_PHY Kconfig option
  (drivers/net/phy/Kconfig, lines 393-398) still says "Currently…

--

net: phy: ncn26000: Support for onsemi's S2500 internal phy

This patch adds a phy_driver entry for the internal PHY of the onsemi
S2500 MAC-PHY to the ncn26000 driver. The NCN26000 PLCA TO_TIMER
workaround in ncn26000_config_init() now runs only for the NCN26000
model.

> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index 6d433f4e2c45d..a33ebb2a7ecef 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c

[ ... ]

> @@ -163,6 +169,26 @@ static int ncn26000_config_intr(struct phy_device *phydev)
>  }
>  
>  static struct phy_driver ncn26000_driver[] = {
> +	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_S2500),
> +		.name                  = "S2500",
> +		.features              = PHY_BASIC_T1S_P2MP_FEATURES,
> +		.config_init           = ncn26000_config_init,
> +		.config_intr           = ncn26000_config_intr,
> +		.config_aneg           = ncn26000_config_aneg,
> +		.read_status           = ncn26000_read_status,
> +		.handle_interrupt      = ncn26000_handle_interrupt,
> +		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
> +		.get_plca_cfg          = genphy_c45_plca_get_cfg,
> +		.get_plca_status       = genphy_c45_plca_get_status,
> +		.soft_reset            = genphy_soft_reset,
> +		.get_sqi               = genphy_c45_oatc14_get_sqi,
> +		.get_sqi_max           = genphy_c45_oatc14_get_sqi_max,
> +		.read_mmd              = genphy_read_mmd_c45,
> +		.write_mmd             = genphy_write_mmd_c45,
> +		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
> +		.cable_test_start      = genphy_c45_oatc14_cable_test_start,
> +	},

[Severity: Low]
The S2500 entry has no .set_loopback callback, so phy_loopback() falls
back to genphy_loopback(). That function overwrites all of BMCR:

drivers/net/phy/phy_device.c:genphy_loopback() {
    ...
		phy_modify(phydev, MII_BMCR, ~0, ctl);

		ret = phy_read_poll_timeout(phydev, MII_BMSR, val,
					    val & BMSR_LSTATUS,
				    5000, 500000, true);
    ...
}

This driver uses that BMCR bit for link control:

#define NCN26000_BCMR_LINK_CTRL_BIT	BMCR_ANENABLE

At this commit, does the PHY loopback selftest from "onsemi: s2500: Added
selftest support to onsemi's S2500 driver" fail on S2500? The path is
ethtool -t -> net_selftest -> phy_loopback() -> genphy_loopback().

This is not a regression against the pre-patch state. Before this patch
the generic PHY driver bound to 0x180FF411 and used the same fallback.

The later patch in this series, "net: phy: ncn26000: Support for
loopback", adds genphy_loopback_no_speed() and sets it as .set_loopback
on the S2500 entry. That fixes this by the end of the series.

[ ... ]

>  static const struct mdio_device_id __maybe_unused ncn26000_tbl[] = {
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
> +	{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
>  	{ }
>  };

[Severity: Low]
Should the NCN26000_PHY help text in drivers/net/phy/Kconfig be updated
as well? It still reads:

	  Currently supports the NCN26000 10BASE-T1S Industrial PHY
	  with MII interface.

With this patch the driver also binds the S2500 internal PHY. That PHY
is not a discrete MII-attached part; it is reached over the OA TC6 MDIO
bus with C45 accessors.

No later patch in the series changes Kconfig.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
