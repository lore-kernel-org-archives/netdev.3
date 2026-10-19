Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434373;
	b=Uknt22gZO7wS6AtUe9fRvZNl5pbobnX9kXotKGL3TlOP7NH8rS87ZVCMSlGrpODWLqCo
	 foxSZWhVHpuGhbBYzBVrOKBsLm33gcKtg9Wl7YnMkAj5WPM5uwtG/sFMHbFA99NHlC/uf
	 ou2h4MAlNlbJ381egWUKpPBytjpyLoPnla1oLFXHB4CdyM/JiL+iqqEqiEDFXKOsCJNld
	 a5i7mEyHlr7L7aqZm49iiWX3Cv0bHsVVtnKSJBfhhj6XvXCpF0k5539dAhrIE6A947FB/
	 /r9Rv2MPIlPxFhbkNSx9F8E2i3Tm9UCMPMhFGYBX1OqCJVJcAr2er0fCHnVKIrtYEOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434373;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MNLSyHfX8hU1gnhPS2X0MNpbE4i+8mSLX9/0n4UgOwM=;
	b=BzH5DT3ET4w2wlThXkweuZzArDYvTzhv5lIZ3eRVWrbWFjPOZPE/B1DSmoW2u7dDQc0Y
	 E2K2hbJchiPFEOe9WMEcSaVLj+It+g2kDT/+hGy2nGHpZZyj6vdrqHRUTJzfT2o5sS/7M
	 3ZRATGxjH+x+rbynCrUztkiks4WozmZ8d8Tp59F5GlgQ+CIRrx5t9jHj8w8u4xJ/Zt6HL
	 8Il2ORrD5TFOOqSYRT/QlyrfgQ5c5uC0yCWUY9UM1c0FeZoel8xEdSChKIJRdG6uaVO/v
	 5jUBjW0w9hqpBk+7DYgbYmYirWMoJLRwlYQetDfaU4TYxcrbVqUpvnSqVo+3xBnw7cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Didf/ez5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77231606A31C;
	Mon, 19 Oct 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Didf/ez5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69151F000C4;
	Mon, 19 Oct 2026 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434373;
	bh=MNLSyHfX8hU1gnhPS2X0MNpbE4i+8mSLX9/0n4UgOwM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Didf/ez5tGVqLDlLgBJ+6lGchkGMD4zmL0qzWOQRU47kkbBF4Jlm67b595dkdQXi8
	 zmvqzHOQWoDvQ8F+ukDTZuEmEVQvSUBz8m1j2KXSeS+IkgpJCDPh5pFI3tK2ygv+so
	 9QMUwxdDXagDl+ho93lz2PsLZ1Q01b+NH02LG8oiTM5lDp8EmwWpY1aRYUvXW7XHyl
	 JX2eEqgSgR+74oN0JvhsxFu7IREabG9oUpbUD/l86n54E4QyCHWi5HxIzuLKMpGQDl
	 liODi4pLZex8HOSmIq6de0NAxztl/7XsQk6Ef7oAmM9B6KaOe5ob9zJiyM3WRdUR7R
	 q6vaLOx5a87Aw==
Subject: Re: [PATCH net-next v3 1/2] net: phy: aquantia: restore EEE discovery
 in get_features callbacks
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 18:26:12 +0000
Message-ID: <179243437219.3135.15283018855918388042@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261016-net-phy-aqr113c-fix-pma-capability-v3-1-0?=
 =?utf-8?q?bbb1b84035d=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20261016-net-phy-aqr113c-fix-pma-capability-v3-1-0b?=
 =?utf-8?q?bb1b84035d=40oss=2Equalcomm=2Ecom=3E?=
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes aqr115c_get_features()
  (drivers/net/phy/aquantia/aquantia_main.c:1072) take phydev->supported…
- [Medium] The commit message misdescribes the hardware and understates
  the impact.
- [Medium] genphy_c45_read_eee_abilities() runs at the end of
  genphy_c45_pma_read_abilities().
- [Low] The patch fixes a user-visible regression (EEE not reported or
  configurable through ethtool on…

--

net: phy: aquantia: restore EEE discovery in get_features callbacks

This patch changes aqr115c_get_features() to build phydev->supported with
genphy_c45_pma_read_abilities() and then set the 2.5G bit. Previously it
used phy_gbit_features plus 2.5G. The aim is to fill
phydev->supported_eee so ethtool can show and configure EEE.
aqr111_get_features() now also returns the error from
aqr115c_get_features().

> As a result, phy_probe() never populates supported_eee for AQR111,
> AQR114C and AQR115C. The kernel then clears advertising_eee:

[ ... ]

> Fix this by following the pattern used in aqr105_get_features(): call
> genphy_c45_pma_read_abilities() as the base, then set the 2.5G bit
> explicitly since the PHY does not report it correctly in PMA registers.

[Severity: Medium]
Is this description of the hardware accurate? aqr105_get_features() is
for a PHY that fails to report 2.5G and 5G:

    /* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
     * here
     */

Earlier commits for this PHY family describe the opposite problem. Commit
17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up PMA capabilities") says:

    AQR115c reports incorrect PMA capabilities which includes 10G/5G and
    also incorrectly disables capabilities like autoneg and 10Mbps support.

Commit 0974f1f03b07 says AQCS109 reports 10G and 5G but doesn't support
them. Commit 8f61d73306c6 removed an aqr111_config_init() comment saying
AQR111 reports speeds up to 10G but only supports up to 5G.

That history is the reason for the "PMA capabilities are not useful"
comments. The patch removes them without saying why the PMA registers can
now be trusted.

The list of affected parts also looks incomplete. In aqr_driver[],
AQCS109, AQR111B0 and AQR115 use these same callbacks.

The message describes an EEE-only change, but the supported and
advertised link modes change too. 10G/5G may be added, and Autoneg,
10baseT, 1000baseT_Half and TP may be lost. Should the commit message
say so?

> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

[Severity: Low]
Should this patch have a Fixes: tag? The missing EEE discovery seems to
come from 17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up PMA
capabilities") and 8f61d73306c6 ("net: phy: aquantia: remove usage of
phy_set_max_speed"). Those commits added ->get_features callbacks that
skip genphy_c45_pma_read_abilities().

phy_probe() only reads EEE abilities on the static ->features path:

	if (phydrv->features) {
		linkmode_copy(phydev->supported, phydrv->features);
		genphy_c45_read_eee_abilities(phydev);
	}
	else if (phydrv->get_features)
		err = phydrv->get_features(phydev);

Before 8f61d73306c6, AQR111, AQR114C and AQCS109 had no get_features
callback. They used the default genphy_c45_pma_read_abilities() path,
which does read the EEE abilities.

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e95d391a6dc23..ed5631f2956ee 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -1071,23 +1071,25 @@ static int aqr_gen1_resume(struct phy_device *phydev)
>  
>  static int aqr115c_get_features(struct phy_device *phydev)
>  {
> -	unsigned long *supported = phydev->supported;
> +	int ret;
>  
> -	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
> -	 * are not useful.
> -	 */
> -	linkmode_or(supported, supported, phy_gbit_features);
> -	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this bring back the wrong speed capabilities that 17cbfcdd85f6,
0974f1f03b07 and 8f61d73306c6 fixed?

AQCS109, AQR115 and AQR115C use this callback. aqr111_get_features()
calls it too, so AQR111, AQR111B0 and AQR114C are also affected.

genphy_c45_pma_read_ext_abilities() sets 10000baseT_Full from
MDIO_PMA_EXTABLE_10GBT and 5000baseT_Full from MDIO_PMA_NG_EXTABLE_5GBT.
The new code only sets bits after that and never clears any. As a
result:

  - the 2.5G parts (AQCS109, AQR115, AQR115C) would report 5G and 10G
    again
  - the 5G parts (AQR111, AQR111B0, AQR114C) would report 10G again

The modes that phy_gbit_features used to supply (Autoneg, 10baseT,
1000baseT_Half, TP) are also no longer forced on.
genphy_c45_pma_read_abilities() starts with:

	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);

It sets the bit again only if AN STAT1 reports ABLE. 17cbfcdd85f6 says
AQR115C misreports this. If it does, phy_probe() runs:

	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
			       phydev->supported))
		phydev->autoneg = 0;

aqr_config_aneg() then calls genphy_c45_pma_setup_forced(), and
2.5GBASE-T can't link without autoneg.

If autoneg stays enabled, phy_advertise_supported() copies the false
10G/5G modes into advertising. aqr_config_aneg() then advertises them to
the link partner through genphy_c45_an_config_aneg().

The next patch in this series, "net: phy: aquantia: add get_features()
for AQR113C", builds on aqr111_get_features() and doesn't fix this.

Could the hard-coded speed mask stay, with a call to
genphy_c45_read_eee_abilities(phydev) after it is built? phy_probe()
already does this for drivers with static ->features.

> +
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);

[Severity: Medium]
Can supported_eee still be missing the 2.5G and 5G EEE modes?
genphy_c45_read_eee_abilities() runs at the end of
genphy_c45_pma_read_abilities(). That happens before this line sets
2500baseT_Full, and before aqr111_get_features() sets 5000baseT_Full.

It reads the EEE capability 2 register (2.5G/5G EEE) only in this case:

	if (linkmode_intersects(phydev->supported, PHY_EEE_CAP2_FEATURES)) {
		val = genphy_c45_read_eee_cap2(phydev);

PHY_EEE_CAP2_FEATURES contains only 2500baseT_Full and 5000baseT_Full.

The commit message says the PHY doesn't report 2.5G in the PMA
registers. If MDIO_PMA_NG_EXTABLE reports neither 2.5G nor 5G, cap2 is
never read. phy_probe() then drops these modes from advertising_eee, and
ethtool --set-eee can't enable EEE at 2.5G or 5G.

Would calling genphy_c45_read_eee_abilities() after the final supported
mask is built avoid this?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d%40oss.qualcomm.com
