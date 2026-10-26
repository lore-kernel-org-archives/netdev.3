Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056027;
	b=gLc2iL4YAYD+Pn04YcxtfX2RqGKKeoNAjHtURFQ4wWvYEQzGYYBflRIylRQkLMdNV99m
	 bbXwaT7LK4sozU1JcYnLZlq3h14YVqIuubJwnYgaKLHgWXuim9sDWW1rZMQTKy8g/i6A6
	 jZMY+H0iwN5l5SHACQLYKbjVqosLIQ4VJ3GK0C1QpLOJ1Zb+5Oi/PDyc2x84mstB9DLQA
	 PlDGQKu4kyVDvkGaGfhO+PZVwaTYW0qOlWKFyPMToRHd0tqCThHcdLwFX5XN+ON3Wu1HF
	 /gRLaWHkFd1PBN08mLaPqPnzSgY6DxODFtGeO6Am7h/oWgF79atDU7c6LUb6Iv/5PrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056027;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cHpKnaLvTFTPYsx/NVwHyh0ZcsClx45PWlCQo1pFj+w=;
	b=N324n3iLJWt0MnhI5wZqTiBv3Y35tlv5fHM/ZiZzODOka6l2lqcqNS4bFumIK3jv+xNp
	 mQYLhEhGyIWWj3TimM1jNK7qPP/1Fj+V12yq3LLjhH25uJjY+mEhtp3x6XTpZ+dDN0RIq
	 jvzPyuSWR+7t31g97J+b19LLb6nm+5jRdiEZ8PcYFQOgCUmoVW/M10/qeFL5Vjo3x5HQi
	 68yfvZT+1A9IgwA2bbLVKHQ2AFG7GTv6PNpd3Q+t+T5WzmaMNLNn7gcxB15a78X59pjUl
	 ZrOrx4sRzsuqhXIiEo5AbAmagUUYC9ufqLKVuO/GGb600QKpi6lq135NdkoHwkIeQWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z98xm/jV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914D606A325;
	Mon, 26 Oct 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z98xm/jV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD871F031E6;
	Mon, 26 Oct 2026 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056027;
	bh=cHpKnaLvTFTPYsx/NVwHyh0ZcsClx45PWlCQo1pFj+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z98xm/jVPcJrFcR5BChPoLPJpmAObj6q7LUEbYg8O8yfQ7tY1Z4bSA9H4nl6mVUQM
	 eG/sJWl2DwLJKRamCYkbU9OstNDZ2wbi9mcfri2RBIy9mz3db21GqIrfct807FMWYN
	 xAUNrc1TshJGLZGPlM74umrBO3nzZWzTLcpsHrx9b6h3tgGRJJRrqt6lFO4Q20XgaU
	 IIUMgGVbPq2/mlBnr5ZuVoVk4gDM8S4D/0sEPHb36PuF5Dih1AWzJbHkaDbPqxk9nN
	 +xnfsZf/LfZXev5E8TnQh5g2gOXKwsyKuIdxBRBnHf7Q/RIKhZU0DtkxQrtOfumvFu
	 2hc8IbQyTwTcA==
Subject: Re: [PATCH net v2 3/4] net: phy: as21xxx: force C45 OPs for AUTONEG
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:07:06 +0000
Message-ID: <179305602633.3134.8105334301986052059@kernel.org>
In-Reply-To: <20261022222955.698722-3-ansuelsmth@gmail.com>
References: <20261022222955.698722-3-ansuelsmth@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new as21xxx_config_aneg() in drivers/net/phy/as21xxx.c
  never checks phydev->autoneg, so a forced speed/duplex request is…
- [Medium] Installing the custom as21xxx_config_aneg() also drops
  master/slave (timing role) programming.

--

net: phy: as21xxx: force C45 OPs for AUTONEG

This patch clears the C22 bit from devices_in_package in as21xxx_probe().
It adds a custom as21xxx_config_aneg() that uses the generic C45 AN helpers
and also writes the 1000BASE-T advertisement through the mapped C22
CTRL1000 register in MMD 7. The new callback is hooked into all of the
post-firmware driver entries.

> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index 519b78d3579d3..e2988cb10c047 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c

[ ... ]

> @@ -633,6 +640,32 @@ static int as21xxx_probe(struct phy_device *phydev)
>  	return aeon_dpc_ra_enable(phydev);
>  }
>  
> +static int as21xxx_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	int ret;
> +	u16 adv;
> +
> +	ret = genphy_c45_an_config_aneg(phydev);

[Severity: Medium]
What happens here when phydev->autoneg == AUTONEG_DISABLE? There is no
forced-mode branch, so a request like "ethtool -s ethX autoneg off speed 100
duplex full" goes through:

phy_ethtool_ksettings_set()
  _phy_start_aneg()
    phy_config_aneg()
      as21xxx_config_aneg()
        genphy_c45_an_config_aneg()
        genphy_c45_check_and_restart_aneg()
          genphy_c45_restart_aneg()

genphy_c45_restart_aneg() sets MDIO_AN_CTRL1_ENABLE | MDIO_AN_CTRL1_RESTART.
So autoneg stays enabled, or gets turned back on, and no forced speed or
duplex is programmed.

Before this patch there was no .config_aneg, so phy_config_aneg() used
genphy_config_aneg()->__genphy_config_aneg(). That path handled forced mode
with genphy_setup_forced() below 1000, and for 1000 it advertised only the
requested mode. genphy_c45_config_aneg(), which this code seems to be
based on, also starts with:

	if (phydev->autoneg == AUTONEG_DISABLE)
		return genphy_c45_pma_setup_forced(phydev);

The config_aneg kernel-doc in include/linux/phy.h says the callback "forces
the speed to the current settings in phydev if phydev->autoneg is off".
as21xxx_read_status() also still has an AUTONEG_DISABLE branch.

Is this a regression for forced link modes? Against a partner forced to
10/100 full duplex, this side would fall back to parallel detection and end
up at half duplex. A forced 1000 request would also no longer restrict the
advertisement, so the link could come up at 2.5G or higher.

Would it make sense to add an AUTONEG_DISABLE branch at the top of
as21xxx_config_aneg(), for example returning
genphy_c45_pma_setup_forced(phydev)?

> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
> +				     AS21XXX_MDIO_AN_C22 + MII_CTRL1000,
> +				     ADVERTISE_1000FULL |
> +				     ADVERTISE_1000HALF, adv);

[Severity: Medium]
Does this drop master/slave (timing role) programming? The mask only covers
ADVERTISE_1000FULL | ADVERTISE_1000HALF. genphy_c45_an_config_aneg() only
writes the advertisement registers, so nothing in this callback uses
phydev->master_slave_set.

Before this patch, __genphy_config_aneg() called genphy_setup_master_slave().
That function does:

	return phy_modify_changed(phydev, MII_CTRL1000,
				  (CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER |
				   CTL1000_PREFER_MASTER), ctl);

Its result was also counted toward the AN restart decision.
genphy_c45_config_aneg() does the same through
genphy_c45_an_setup_master_slave().

The ethtool paths can't reach this for this PHY, because master_slave_get is
never set and stays MASTER_SLAVE_CFG_UNSUPPORTED. A DT "timing-role"
property still sets master_slave_set through
phy_probe()->of_set_phy_timing_role().

With this patch that role is no longer written to the PHY. A role change on
its own also no longer causes an AN restart. If the link partner is forced
to the same role, master/slave resolution would fail and the link would not
come up.

as21xxx_read_c22_lpa() still prints "Master/Slave resolution failed, maybe
conflicting manual settings?", which suggests manual roles are meant to work.

Should the CTL1000 role bits be programmed in the mapped register as well,
or genphy_c45_an_setup_master_slave() be called, with the result folded
into changed?

> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	return genphy_c45_check_and_restart_aneg(phydev, changed);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022222955.698722-1-ansuelsmth%40gmail.com
