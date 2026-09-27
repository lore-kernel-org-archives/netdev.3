Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC22F7EF2;
	Sun, 27 Sep 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790475282; cv=none; b=BksHVnuK63Hjx0kX+zoZ9dKhZdz/SJRw+d6ZE3g0cF2WYUCmvISJo98IUz9LYwn0I5WQwtzTogo+fyILTtmyzeaBeJEfGyQqGPn3Z7bm7xBmPIkXaJ2V4ys+qHfp682uEjeHK3HbVTkePiBJWaF9ZWNegXTfxLyFjYhI+HHAJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790475282; c=relaxed/simple;
	bh=q6/PMCNYDDscEJ5nw2CUclBXt9cRDAut+3mVMVGqNzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1fGBug4u9hkK/2uoamACmvrsjDwGlFmkXjPqgVSIEgcb7IbVVn5wyHA2TvWn5DN5C9T127UNqRsNDchX9PrKWyphIwuxUAHEBCwNRJepVGzgA6K579FV1xUK5IwLGH1Q9KOKMuativVAfq1ZZ7PVm8VtpgEQVBRCtdgx9hs/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+p4FyzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+p4FyzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CD11F000FF;
	Sun, 27 Sep 2026 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790475280;
	bh=W9u8hnmZuGo1NuDzpttD6IeA6/nBfLNcDzRrJr4v/OU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c+p4FyzTGBavXCR3JCnCpwmkVoq6mJ9yjxv5y7Yg8j8kuASzyB8UOr9y9L2kGWo1N
	 wnFw+sUDXC4VPsZcTCHsoVKR7O1j7GkqyF/mLbx7lKC169sqYeBu4CyYj+h2QJbXxG
	 FQA173QAHjP+8u/jirQSrawXDMI8B694Dk++FrAZ1kHmJcn8+tWlTG8bFGxbi5GpxN
	 KubCfpfcOzGmMKpH/CHvfhHpRszm/dPHX/dCeChZMu427EdCRzLe6OlR098z9+03Od
	 t8IouAZNH/dzBvtMQluD6qBhXtm9Uq3yakBVvK4JCfezBoY4KtSYct34cm96oe5efk
	 iux9q/SmX8c8Q==
Subject: Re: [PATCH] net: phy: aquantia: AQR113c fix up PMA capabilities
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 02:14:39 +0000
Message-ID: <179047527921.2160803.15181990521063252187@kernel.org>
In-Reply-To: =?utf-8?q?=3C20260923-net-phy-aqr113c-fix-pma-capability-v1-1-4?=
 =?utf-8?q?97359310f06=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20260923-net-phy-aqr113c-fix-pma-capability-v1-1-49?=
 =?utf-8?q?7359310f06=40oss=2Equalcomm=2Ecom=3E?=
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

- [Medium] The patch stops using the EEE capability discovery that
  AQR113C had before, so the kernel now treats EEE as unsupported on…
- [Low] The patch presents itself as a fix for a user-visible defect
  ("AQR113c fix up PMA capabilities": 10G/5G/2.5G not reported), but it…

--

net: phy: aquantia: AQR113c fix up PMA capabilities

This commit adds an aqr113c_get_features() callback for the AQR113C PHY.
The callback reuses aqr111_get_features() and also sets the 10000baseT
Full link mode. For this PHY, it replaces the generic C45 PMA ability
discovery.

> net: phy: aquantia: AQR113c fix up PMA capabilities
>
> AQR113c does not report few of the supported PMA
> capabilities which includes speeds like 10G/5G/2.5G,
> add get features support within aquantia driver to fix
> the same.
>
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

[Severity: Low]
This is described as a fix for missing 10G/5G/2.5G reporting, but there
is no Fixes: tag or stable Cc.

If the premise holds, the defect would date back to when AQR113C support
was added without a .get_features callback. Should a tag like this be
added so stable maintainers know whether to backport, and how far?

Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e95d391a6dc23..604f5492515dd 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -1094,6 +1094,18 @@ static int aqr111_get_features(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int aqr113c_get_features(struct phy_device *phydev)
> +{
> +	/* Generic C45 PMA abilities do not fully describe the PHY's copper
> +	 * autonegotiation modes, so add the 10G mode explicitly.
> +	 */
> +	aqr111_get_features(phydev);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phydev->supported);
> +
> +	return 0;
> +}

[Severity: Medium]
Does this drop EEE capability discovery on AQR113C?

Before this patch, the AQR113C entry had neither .features nor
.get_features, so phy_probe() took the is_c45 branch:

drivers/net/phy/phy_device.c:phy_probe() {
    ...
	if (phydrv->features) {
		linkmode_copy(phydev->supported, phydrv->features);
		genphy_c45_read_eee_abilities(phydev);
	}
	else if (phydrv->get_features)
		err = phydrv->get_features(phydev);
	else if (phydev->is_c45)
		err = genphy_c45_pma_read_abilities(phydev);
    ...
}

genphy_c45_pma_read_abilities() ends by calling
genphy_c45_read_eee_abilities(), which fills phydev->supported_eee.

Now that .get_features is set, phy_probe() runs only this callback. The
chain aqr113c_get_features()->aqr111_get_features()->aqr115c_get_features()
only sets bits in phydev->supported. Nothing in the aquantia driver reads
the EEE ability registers, so supported_eee stays empty.

phy_probe() then clears advertising_eee, so this sets eee_enabled to
false:

	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);

After that, genphy_c45_ethtool_get_eee() reports no supported EEE modes.
genphy_c45_ethtool_set_eee() also rejects explicit modes with -EINVAL:

	if (linkmode_andnot(tmp, adv, phydev->supported_eee)) {
		phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
		return -EINVAL;

genphy_c45_write_eee_adv() is gated on supported_eee as well:

	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {

That means neither aqr_config_aneg() nor ethtool would ever write the EEE
advertisement registers (7.60 and 7.62). The PHY would keep its firmware
default advertisement, and eee-broken-* DT quirks would have no effect.

Would either of these work instead?

- Call genphy_c45_pma_read_abilities() first, then add the missing bits.

- Call genphy_c45_read_eee_abilities() at the end of
  aqr113c_get_features(). It would have to run after the supported bits
  are set, because the EEE read only happens if supported intersects
  PHY_EEE_CAP1_FEATURES or PHY_EEE_CAP2_FEATURES.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06%40oss.qualcomm.com
