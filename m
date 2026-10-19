Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434375;
	b=WzI+tu4ZK19MXrg4+THhnSDHhS0WqvpP3EKDExz+QE8O4GLDAD5kNubmeputZbVIhF/U
	 ba4AdOyNnP5IaLZD0TzPy7JAKJLVY0+gpMZIlUVwzG+I9GGd83XdQk9MCOpOsB1OUTdqI
	 em4l8lVp7cyTLKUE5y9NR0CEQ+3hQUSvBqdQC52IHp/ynQM4lzCPr6MptMuh3lKiGwWaO
	 3wXKrCBnnPAfgv1B8lHW7zWgJLvyAMqvcQ9uHNm52zWDxMyMKZrgFi5gVMUH4B83ej15l
	 CHvdA9zPr1ofsV1rnx+8U4agR91mPsXAI4/Qx3eislUkRZWuSvyX6KOpwwKcZHsMulQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434375;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Hpl7F0rKnMV0W7n9fTAJa8smp5Uzi179zmxJ/L78saA=;
	b=CHcAopW4ZK1wXyKKX3DVK6Upye4n4N37AHKSZWtlsvPK8McZny1bR8E7zptzpdIky3gA
	 vD1Ro1rcnURoqtUP6X3V57sbLsS7XBgJFQOmcgnBjwrSJ0voGwNOrNzQk+djud6ey70Po
	 d9ltlAkT5eZgKVYZtSsVFTQnmG9j4z0QZDbRD40itgtJ5N3rs2zu7U/cp8DoxpcU98ljG
	 y1pljWWk2OeWiUUsRmbchz21/rS3ubD9y7wFNk4zemuy6jiHPS21IiO51r+bcxA8EaZoF
	 IfIPS474/gbcBRuGjOvV9pdkGbUq0Q5UkoaRb/4emWB+ex1wSy13ldeFAL62qkIn3Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ncibVe2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3076606A324;
	Mon, 19 Oct 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ncibVe2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0130A1F000C4;
	Mon, 19 Oct 2026 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434374;
	bh=Hpl7F0rKnMV0W7n9fTAJa8smp5Uzi179zmxJ/L78saA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ncibVe2ihBADAZ5sayKy8u1N6ZbF81gRw09+h7RPbBKzk0yfnnLHV4d21fyzLmShz
	 ILC6NuQfLtGRRDO9SxHyo7kgkDw1xyJ0fH2LhXUrkqb4ndDE7CV3JTyn9S5EOGl588
	 kMiS2V+jrkbRHE2VJOwHj8JN8Zvhc8+OxcNo3IdoVYaUJO/MohyqRr4yA4aTZutGxt
	 jgXz5PKncMmHVdc+rET9gGp8lZoFchxXVjFt92d2GkrIX0paAuDW3grfRqaMkC5MpW
	 jOO/e+eg0VGJ1s+UUJ1KGykPtH1n2FcoykZ+ESIzOA3U+ZQis3VRzOVkIZ47QffIXk
	 UPv5tkvuJ7/ew==
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: add get_features()
 for AQR113C
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 18:26:13 +0000
Message-ID: <179243437352.3135.719818276407053323@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261016-net-phy-aqr113c-fix-pma-capability-v3-2-0?=
 =?utf-8?q?bbb1b84035d=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20261016-net-phy-aqr113c-fix-pma-capability-v3-2-0b?=
 =?utf-8?q?bb1b84035d=40oss=2Equalcomm=2Ecom=3E?=
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the patch adds get_features() to
  "explicitly declare 10G/5G/2.5G/1G support instead of relying on PMA…
- [Low] The patch is written as a fix for a hardware-reporting defect
  ("AQR113c does not correctly report its supported PMA capabilities"),…

--

net: phy: aquantia: add get_features() for AQR113C

This adds an aqr113c_get_features() callback to the AQR113C entry in
aqr_driver[]. The callback builds on aqr111_get_features() and also sets
10000baseT_Full in phydev->supported. The commit message says the PHY
does not correctly report its PMA capabilities.

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index ed5631f2956ee..8213d9a15b4fe 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -1096,6 +1096,23 @@ static int aqr111_get_features(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int aqr113c_get_features(struct phy_device *phydev)
> +{
> +	/* Generic C45 PMA abilities do not fully describe the PHY's copper
> +	 * autonegotiation modes, so add the 10G mode explicitly.
> +	 */
> +	int ret;
> +
> +	ret = aqr111_get_features(phydev);
> +	if (ret)
> +		return ret;
> +
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phydev->supported);
> +
> +	return 0;
> +}

[Severity: Medium]
Does the commit message match what this code does? It says:

  Add get_features() to explicitly declare 10G/5G/2.5G/1G support
  instead of relying on PMA register reads.

The call chain still starts with the generic PMA reads:

aqr113c_get_features()
  aqr111_get_features()
    aqr115c_get_features()
      genphy_c45_pma_read_abilities()

So phydev->supported is still built from the PMA registers. On top of
that, the chain only adds 2500baseT_Full in aqr115c_get_features(),
5000baseT_Full in aqr111_get_features() and 10000baseT_Full here.

Nothing in this chain sets 1000baseT_Full explicitly. It still comes only
from the PMA extended abilities register:

drivers/net/phy/phy-c45.c:genphy_c45_pma_read_ext_abilities() {
    ...
	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
			 phydev->supported,
			 val & MDIO_PMA_EXTABLE_1000BT);
    ...
}

The comment in the function gives a third version ("add the 10G mode
explicitly"). It does not mention that 5G and 2.5G are also forced
through the callees.

Could the commit message and the comment say which abilities the AQR113C
PMA registers (MDIO_PMA_EXTABLE / MDIO_PMA_NG_EXTABLE) actually
misreport? For example, if the PHY already reports 10GBASE-T in
MDIO_PMA_EXTABLE, the extra linkmode_set_bit() here does nothing.

[ ... ]

> @@ -1446,6 +1463,7 @@ static struct phy_driver aqr_driver[] = {
>  	.get_sset_count = aqr107_get_sset_count,
>  	.get_strings    = aqr107_get_strings,
>  	.get_stats      = aqr107_get_stats,
> +	.get_features   = aqr113c_get_features,

[Severity: Low]
The commit message describes this as a fix for a hardware reporting
problem. Should it have a Fixes: tag?

This commit added the AQR113C entry in aqr_driver[] without a
get_features callback:

  commit 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")

Because of that, phy_probe() has always used
genphy_c45_pma_read_abilities() for this PHY:

drivers/net/phy/phy_device.c:phy_probe() {
    ...
	else if (phydrv->get_features)
		err = phydrv->get_features(phydev);
	else if (phydev->is_c45)
		err = genphy_c45_pma_read_abilities(phydev);
    ...
}

Earlier fixes for the same quirk on related Aquantia PHYs had Fixes:
tags. Two examples are 17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up
PMA capabilities") and 8f61d73306c6 ("net: phy: aquantia: remove usage
of phy_set_max_speed").

Would something like this be appropriate?

  Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")

Without the tag, stable kernels that support AQR113C may not pick up this
change.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d%40oss.qualcomm.com
