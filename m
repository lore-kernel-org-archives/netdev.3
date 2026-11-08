Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096945;
	b=4ZGL2wTd16QxMeBQYX3VswcImAS47bqauTMCiOuC9Ber1Cit8AjEj8mx43HWTFpyWenc
	 xXLiVhvNFWBaqzGRyHXA3ruI9niEhe1BhF6dcqRNm92IDZLP2u4AcHwnaOLv/UXd2eloe
	 E57ydEAhwUQVw6RgVkuAxTUE02OmmrJtpBT0ATcZPUK52U3lHuXzbYzvMNW9J8FuVP+oz
	 32WnAFyNyg4fN8f6UIT2yB//7kahdB+qji7A6m0NnzO32cxYV7Y7DkX5+mE2NiaopEj7S
	 ds1JcoU75rX4VPYJ57YK/p468xrLLJXTHvwAJgL7fK120yKOezVZ+7/Ce0ceIiKQ1tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096945;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5CIX5+6/G8PYZAyVj920aV25d7PQcRlt29+7mQ9ch+A=;
	b=0HYt1TLIU+Q0wq3sarV+2xa8KfpsbHQqx730ChHijz9E9x7ZNCtTRkCgJ03ascIv5+0R
	 i/xnjUQ67pMyrdyyF0qUsVmGXEiXH/00qbm/mG3EW4SwID81/Lspi5AgvNd1PmNg+RFCt
	 DQRPpp4RCjSG9qXNF4W8OHUVzg+SyxNu60HHBmT2h2iX1sEAdf8zuhB+8ki0lwjOhIrNK
	 EhEMyTgwFE3U1guDnV6VVh2jI+HeXeg0u23EXpMtPyeaUWZ91jeznkZSajLeanBzEl3kl
	 V5TeKImlbkJ6UMYKP/thARDNyM2dwADRvVOc0VtMZr5Qv5eQZJ37PMUS9nnvBnmisRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmqgW0Q4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C5606A334;
	Sun,  8 Nov 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmqgW0Q4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04B21F0089F;
	Sun,  8 Nov 2026 00:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096945;
	bh=5CIX5+6/G8PYZAyVj920aV25d7PQcRlt29+7mQ9ch+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZmqgW0Q4yLLfOoWFNrXEbSIlDqMqOQMxk9DyfixDOZfg0HkZa2Wr4PtQAL5UWjyZP
	 hRxnueBB1nm5rZa9268c1VNWROGargUzZwEM7EaUNroZHW5w2Vf4b0vowi5wHdeMPb
	 ZcpN6bM2347Gfo0JvLx7G7qp1OK3WGx7hmXNMPzXk9+Q4CfTJO5EjCbRgptwXw7l/F
	 uiFMQRC/t4IF4DvKzBLZis4sWiJNQywhjW34Rdkfxm0WWonL+9tgVDQcpujXe7wbAf
	 WW4F4H0TTkCjRhAlQ+f+jNwGcPqfrANV09xF+TO6IvSs2EUyTTv81b0c9n3Nh8KCCk
	 WdfMErDVy50ow==
Subject: Re: [PATCH net-next v10 10/11] net: phy: ncn26000: Support for
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
Date: Sun, 08 Nov 2026 00:15:43 +0000
Message-ID: <179409694340.994134.286185793095635335@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-10-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-10-31b5a69b85b7@onsemi.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In the existing drivers/net/phy/ncn26000.c header, the patch
  changes the copyright line from 'Copyright 2022 onsemi' to 'Copyright…
- [Low] The commit message only says S2500 internal PHY support is added
  and that the PLCA TO_TIMER default is correct on S2500.
- [Low] This patch makes S2500 use ncn26000_c45_plca_set_cfg().
- [Low] The NCN26000_PHY Kconfig help text is out of date.

--

net: phy: ncn26000: Support for onsemi's S2500 internal phy

This adds a phy_driver entry and an MDIO device table row for the
internal PHY of onsemi's S2500 MAC-PHY. The PLCA TO_TIMER workaround in
ncn26000_config_init() now only runs on NCN26000. It also adds a
MAINTAINERS entry and a MODULE_AUTHOR line.

> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index 6d433f4e2c45d..0006e157917df 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c
> @@ -2,7 +2,7 @@
>  /*
>   *  Driver for the onsemi 10BASE-T1S NCN26000 PHYs family.
>   *
> - * Copyright 2022 onsemi
> + * Copyright 2026 onsemi
>   */

[Severity: Low]
This isn't a bug, but should the 2022 year stay here, for example as
"Copyright 2022-2026 onsemi"?

Most of the file is still the original 2022 code. This patch only adds a
driver entry, a conditional TO_TIMER write and a table row. Neither the
commit message nor the changelog mentions the date change.

[ ... ]

> @@ -163,6 +169,24 @@ static int ncn26000_config_intr(struct phy_device *phydev)
>  }
>  
>  static struct phy_driver ncn26000_driver[] = {
> +	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_S2500),
> +		.name                  = "S2500",
> +		.features              = PHY_BASIC_T1S_P2MP_FEATURES,
> +		.config_init           = ncn26000_config_init,
> +		.config_aneg           = ncn26000_config_aneg,
> +		.read_status           = ncn26000_read_status,
> +		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,

[Severity: Low]
Is bit 7 of VEND2 register 0x8001 on the S2500 the same ENI bit as on
the NCN26000?

ncn26000_c45_plca_set_cfg() changes that bit on every PLCA enable and
disable:

    eni_cfg = (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
    return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
                          NCN26000_REG_PHYCFG1,
                          NCN26000_PHYCFG1_ENI_MASK, eni_cfg);

The S2500 MAC driver uses a different name for the same MMS4 register
and defines no bits for it:

drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h:
    #define S2500_REG_VS_TWEAKS1		0x8001

It is also listed under OA_TC6_PHY_C45_VS_PLCA_MMS4 in s2500_ethtool.c.

If bit 7 means something else on the S2500, then every
"ethtool --set-plca-cfg ... enable on|off" would silently set or clear
an unrelated vendor tweak bit.

Can the S2500 bit layout be confirmed, or one name used in both drivers?

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
This isn't a bug, but the commit message only mentions S2500 support and
the TO_TIMER default. Could it also describe what the S2500 entry does
that the NCN26000 entry does not?

- SQI reporting through genphy_c45_oatc14_get_sqi() and
  genphy_c45_oatc14_get_sqi_max().

- OATC14 cable testing through .cable_test_start and
  .cable_test_get_status.

- Direct C45 MMD access through genphy_read_mmd_c45() and
  genphy_write_mmd_c45(). These helpers are for PHYs that support direct
  C45 access but not C22 indirect MMD access (registers 13 and 14). That
  hardware property seems worth stating.

- No .config_intr or .handle_interrupt, so the PHY always runs in polled
  mode. Only the v10 changelog says this, and that text is dropped when
  the patch is applied.

The patch also includes some changes that the commit message doesn't
mention:

- an unrelated reorder of the local variables in ncn26000_config_intr()
- a new MAINTAINERS M: entry
- a new MODULE_AUTHOR line

[ ... ]

> @@ -183,11 +207,13 @@ module_phy_driver(ncn26000_driver);
>  
>  static const struct mdio_device_id __maybe_unused ncn26000_tbl[] = {
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
> +	{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
>  	{ }
>  };

[Severity: Low]
Should the NCN26000_PHY help text in drivers/net/phy/Kconfig be updated
as well? It still says:

    Currently supports the NCN26000 10BASE-T1S Industrial PHY
    with MII interface.

With this patch the driver also binds PHY_ID_S2500. That is the internal
PHY of the S2500 SPI MAC-PHY, which has no MII interface. S2500_MACPHY
also selects NCN26000_PHY.

The help text is still unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
