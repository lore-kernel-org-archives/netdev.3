Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C504414A20;
	Mon, 14 Sep 2026 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427766; cv=none; b=h06ITVWoX9WYXveTV2VtAjw8sO+ROYDxe23c9MvIYJrsPmGkmMiKbWZo3Lhth0x2gD5dolGQaXdkmniaLGy6JkJB72doJrFSoif5LY1oxVu1BX+ePyPjx+AUCalMqDgiIALLkUgUyPOa8Tcq1CLsgk6Kop9pewnyvJcP9Dgwsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427766; c=relaxed/simple;
	bh=1tYd0D9YMONLr54yHpJV6EBnF9Az2MSD5oj32ktpY10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2mQV9qU86SQgCBSFoo6SKC+Io4opXFw7n9pMhp+OaWoNLuKD5AUshiqgtXuSJJJtUpo0RkoejTXhuJY+3IT9YxOiKG16pYJ6cT1BjWvtDDu2pPX5Hn0NpUKVwU31BqNRhs3bHZPe/aV9YAwLW/jq1zAG4kUkSAT5EGETSUDVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goQyM3FM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goQyM3FM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80E21F008A1;
	Mon, 14 Sep 2026 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427761;
	bh=7A8bsZwZtUn262lTk7IyubDp7W1YXYAVchUWgLtGXAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=goQyM3FMdS+4uy3kh/E+DEd0gKrJrl1LoJbQcpJPU0pkEDMFeumZC0rXeero67oLZ
	 UL22IAP3R+QJtqR6PvhWIJJA3dMSY7jor7+OdCVkVXX/HUTwXZeks/ARs7R8amjpzU
	 /nLqxAwDyW2bcL8Yiu/0tJt+BmpW3pIU98xbnXJk5yIY/wKim2uozigmulByf4m96K
	 R0gMPMCCcgbMv/YbH9fcjrxymwylQyIaSMwpBxJWvY5FypWkbAgT9akEKa/7+4I+bN
	 hpuH7Uj2RH2iVoUjp5iUdWOU8/IztdooqGpHc4UgbVf7nwH7MhceescwmwNPEEvzt7
	 ueVIITBb+cGfw==
From: Jakub Kicinski <kuba@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vkoul@kernel.org,
	peppe.cavallaro@st.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	shawnguo@kernel.org,
	festevam@gmail.com,
	jan.petrous@oss.nxp.com,
	s32@nxp.com,
	mohd.anwar@oss.qualcomm.com,
	romain.gantois@bootlin.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mripard@kernel.org,
	christophe.roullier@foss.st.com,
	brgl@kernel.org,
	radu@rendec.net,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	dfustini@tenstorrent.com,
	linux-sunxi@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH net-next v14 01/10] net: phy: aquantia: fix system interface type not updated in forced mode
Date: Mon, 14 Sep 2026 16:14:47 -0700
Message-ID: <20260914231447.702704-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-qcom-sa8255p-emac-v14-1-ec212b747a7d@oss.qualcomm.com>
References: <20260908-qcom-sa8255p-emac-v14-1-ec212b747a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: aquantia: fix system interface type not updated in forced mode

This drops the phydev->autoneg == AUTONEG_DISABLE test from the early
return in aqr_gen1_read_status(), so that MDIO_PHYXS_VEND_IF_STATUS is
decoded into phydev->interface whenever the link is up. The commit is
marked for stable and carries Fixes: 110a2432c520 ("net: phy: aquantia:
add downshift support").

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e95d391a6dc23..b720e4e9028cc 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -544,7 +544,7 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> -	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
> +	if (!phydev->link)
>  		return 0;
>  
>  	/* The status register is not immediately correct on line side link up.

[Severity: Medium]
This early return was also gating the rest of aqr_gen1_read_status(), not
just the MDIO_PHYXS_VEND_IF_STATUS decode. With the autoneg test gone, the
tail of the function now runs in forced mode too:

drivers/net/phy/aquantia/aquantia_main.c:aqr_gen1_read_status() {
	...
	phydev->interface = aqr_translate_interface(phydev, interface);

	/* Read rate from vendor register */
	return aqr_gen1_read_rate(phydev);
}

aqr_gen1_read_rate() overwrites both speed and duplex unconditionally from
the autoneg MMD vendor register:

drivers/net/phy/aquantia/aquantia_main.c:aqr_gen1_read_rate() {
	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_TX_VEND_STATUS1);
	if (val < 0)
		return val;

	if (val & MDIO_AN_TX_VEND_STATUS1_FULL_DUPLEX)
		phydev->duplex = DUPLEX_FULL;
	else
		phydev->duplex = DUPLEX_HALF;

	switch (FIELD_GET(MDIO_AN_TX_VEND_STATUS1_RATE_MASK, val)) {
	case MDIO_AN_TX_VEND_STATUS1_10BASET:
		phydev->speed = SPEED_10;
	...
	default:
		phydev->speed = SPEED_UNKNOWN;
	}
}

In forced mode the speed and duplex were just established from the PMA by
aqr_read_status() -> genphy_c45_read_status() -> genphy_c45_read_pma(),
which reads the PMA MDIO_CTRL1 speed select and sets DUPLEX_FULL. Is
MDIO_AN_TX_VEND_STATUS1 still maintained by the firmware after
genphy_c45_an_disable_aneg() (called from genphy_c45_pma_setup_forced()
and aqr105_setup_forced())?

If it is not, a zeroed or stale rate field decodes as SPEED_10 with
DUPLEX_HALF, and an unrecognised code as SPEED_UNKNOWN, so a forced
1000BASE-T full duplex link would be reported to phylink at the wrong
rate and duplex. There is no validity qualifier and no "leave unchanged"
path in aqr_gen1_read_rate().

On gen2 parts a wrong or unknown speed also feeds the rate matching
lookup, which silently keeps the previous value when nothing matches:

drivers/net/phy/aquantia/aquantia_main.c:aqr_gen2_read_status() {
	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];

		if (syscfg->speed != phydev->speed)
			continue;
		...
			phydev->rate_matching = RATE_MATCH_PAUSE;
	...
}

The guard being removed came from the Fixes: commit 110a2432c520, where it
was added to keep the autoneg vendor rate handling out of the forced path.
Would it work to move the AUTONEG_DISABLE check onto the
aqr_gen1_read_rate() call instead of deleting it, so the interface decode
is always done but speed and duplex keep coming from the PMA in forced
mode? Alternatively, could the commit message state that
MDIO_AN_TX_VEND_STATUS1 is valid with autoneg disabled, since the message
currently only argues this for MDIO_PHYXS_VEND_IF_STATUS:

    MDIO_PHYXS_VEND_IF_STATUS is set by the PHY firmware based on the
    negotiated link speed, not based on whether autoneg was used to reach
    it.

This matters for the stable backport since the change is larger than the
one described.
