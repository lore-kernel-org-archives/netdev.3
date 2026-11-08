Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096947;
	b=UEe7xKDuaVnywhh6k4tpR7u9/0KRQxOUEUJgSNYztNjSiS3R4TzaSh5MItDoQzRWFoqU
	 DCG3Dkptz4avDUU+8LubX7NY7qxQl/eLGqSSbhd40n25T670piITrgtklMeA4mZz/kHDf
	 vbYn5/0Lry10+O3bahcm1PTXyYKjSmVqCONQPFTt5pBYRVozDJrSTTd3j5m8AqS18NdQJ
	 PDbUGbnjp5t5T0v/5/a4nWygumswxYO0ShKT9LS+Qh8W7uKLvDQAq8XVUFV25FC2P6/ff
	 3g2NTT06hsJLIZ5PIwJvYYCYw06YPsDneebAMVbPzXfCFyE30kgGT0lhwuwfMzUGaag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096947;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2blDjoZm7fSGSwtlnh9END5OcqULp72mUsNTGTxsSYc=;
	b=kAhOv0ITw0Qx60K8qHwyazK7AQabdkvZPxZspYqKfeqEjwRLLdrY4UimPTy1mZXrlwwp
	 lfb7B/oVHPuNLZeYK6/O+M6cgpFCl4khsmmS8zt2Y6pQgQpOkqywWqvtHT1nyjeplBSpV
	 +yY54ZEAx8BpXHt9s3iRVAFMngJDKG3TPOqucwEO2cKEfOkPwG9upRi/kc/iURgt80GHZ
	 fRxq4leoxIeUYRyWb6e2mbiIhO73iLVmsY8ooDahmFRJj1bLfmzJ/Prz4mudqJj2HCTMM
	 ecRchVkyY1mtLmRuSsYRXmnsMLTt5aIJ1Y3Lc9HhMP7IIOecOBvNttknsrwHuVsALcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rl99Fi5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959E606D839;
	Sun,  8 Nov 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rl99Fi5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE561F008A4;
	Sun,  8 Nov 2026 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096947;
	bh=2blDjoZm7fSGSwtlnh9END5OcqULp72mUsNTGTxsSYc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rl99Fi5qSeKmZyvO/2mP+PnuI1aNNFc852g6eEHtnwZVGoNV4nlPKPwQfVELKoWZL
	 CoXcGi4bc695L+TGCamxq9HaIXP7wJr0OkwYs/2jYolZDZCN1qeBnXzHH0nvPBwOnR
	 4pqytsrikvII+57om1daoF495qnfAZh0MtjezKuX33QPyUk6s6sv1sstpRz2aIbn1m
	 VEE6vGcio20F6Mn4pleGqlbpU82TjlDU49F+qwZDjnIWlZ9QRaCHHWG/UiJ7mq4nxa
	 svn7/3xgIl3nl+UDdZEHCvcP9qGP3x1JIDbsSiVA78TypW/DRu44uIm/+hVBF5nQrt
	 +mNo4qgFN28pA==
Subject:
 Re: [PATCH net-next v10 11/11] net: phy: ncn26000: Support for loopback
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
Date: Sun, 08 Nov 2026 00:15:45 +0000
Message-ID: <179409694533.994134.4523797133943252048@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-11-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-11-31b5a69b85b7@onsemi.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, the S2500 enters loopback by setting only
  the BMCR_LOOPBACK bit (genphy_loopback_no_speed() in…
- [Low] The subject line "net: phy: ncn26000: Support for loopback" and
  the body describe an onsemi S2500 change.
- [Low] The kernel-doc for genphy_loopback_no_speed() in
  drivers/net/phy/phy_device.c says `@speed: Speed setting.

--

net: phy: ncn26000: Support for loopback

This commit adds a new exported phylib helper, genphy_loopback_no_speed().
It changes only the BMCR_LOOPBACK bit and returns an error if a non-zero
speed is passed when enabling. The helper is used as the set_loopback
callback for the onsemi S2500 PHY, and dp83867 is converted to it in place
of its identical private dp83867_loopback().

> net: phy: ncn26000: Support for loopback
>
> Adding loopback support for S2500 internal PHY to help running
> loopback test through ethtool.
>
> This instance requires only manipulating the loopback bit in
> the PHY, without setting the speed. So, added a generic helper
> function to modify loopback bit of the PHY only. This will
> help the PHY drivers, like 10Base-T1S or any other PHYs that
> want to handle loopback bit only.

[Severity: Low]
This isn't a bug, but the subject and body only describe an ncn26000/S2500
change. The patch also adds a new exported phylib core API,
genphy_loopback_no_speed(), in phy_device.c and phy.h. It also converts the
TI dp83867 driver: dp83867_loopback() is deleted and
dp83867_driver[].set_loopback now points to the new helper.

The dp83867 conversion behaves the same as the removed code. However,
dp83867 is not mentioned anywhere in the commit message. The v8 changelog
says two patches were merged into one.

Could the commit message mention the dp83867 conversion? Alternatively, the
core helper and the dp83867 conversion could go back into a separate patch,
so that the subject prefix matches what each patch touches.

> diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> index 0006e157917df..c115af6eda33d 100644
> --- a/drivers/net/phy/ncn26000.c
> +++ b/drivers/net/phy/ncn26000.c
> @@ -176,6 +176,7 @@ static struct phy_driver ncn26000_driver[] = {
>  		.config_init           = ncn26000_config_init,
>  		.config_aneg           = ncn26000_config_aneg,
>  		.read_status           = ncn26000_read_status,
> +		.set_loopback          = genphy_loopback_no_speed,

[Severity: Medium]
Can the S2500's own config_aneg callback silently clear the loopback bit
that this sets? genphy_loopback_no_speed() does a read-modify-write of
BMCR_LOOPBACK only. ncn26000_config_aneg() overwrites the whole register:

drivers/net/phy/ncn26000.c:ncn26000_config_aneg() {
    ...
	// bring up the link
	return phy_write(phydev, MII_BMCR, NCN26000_BCMR_LINK_CTRL_BIT);
}

NCN26000_BCMR_LINK_CTRL_BIT is BMCR_ANENABLE, so this write clears
BMCR_LOOPBACK. If config_aneg runs while loopback is enabled, the PHY
leaves loopback but phydev->loopback_enabled stays at 1. Frames the caller
expects to loop back then go out on the shared 10BASE-T1S segment.

One path that reaches config_aneg while loopback is active:

phy_ethtool_ksettings_set()
  phydev->state = PHY_UP
  phy_state_machine()
    _phy_start_aneg()
      phy_config_aneg()
        ncn26000_config_aneg()

The same PHY_UP branch runs if phy_loopback() takes phydev->lock just after
phy_start(). BMCR writes through phy_mii_ioctl(), which call
phy_start_aneg(), also reach it.

genphy_setup_forced() avoids this by keeping the loopback bit out of the
mask:

	return phy_modify(phydev, MII_BMCR,
			  ~(BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN), ctl);

Should ncn26000_config_aneg() use phy_modify() with a similar mask so that
BMCR_LOOPBACK is kept?

>  		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
>  		.get_plca_cfg          = genphy_c45_plca_get_cfg,
>  		.get_plca_status       = genphy_c45_plca_get_status,
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 06c5a8c8cc2a2..ffb6845d5b03b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2923,6 +2923,28 @@ int genphy_resume(struct phy_device *phydev)
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

[Severity: Low]
This isn't a bug, but the doc for @speed doesn't match the code below:

	if (enable && speed)
		return -EOPNOTSUPP;

A disable request with a non-zero speed succeeds and clears BMCR_LOOPBACK.
Could the comment say that an error is returned only when enabling with a
non-zero speed?

> + *
> + * Returns: 0 if successful, negative error code on failure.
> + */
> +int genphy_loopback_no_speed(struct phy_device *phydev, bool enable,
> +			     int speed)
> +{
> +	if (enable && speed)
> +		return -EOPNOTSUPP;
> +
> +	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
> +			  enable ? BMCR_LOOPBACK : 0);
> +}
> +EXPORT_SYMBOL(genphy_loopback_no_speed);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
