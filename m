Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB32D29C8;
	Mon, 28 Sep 2026 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568586; cv=none; b=S26G+jPjhooR3/FXLchaTV8CwVATKZ/a0kNdogOHeJKnrz+RGKVXZexrKKjr3mDsVba7GKZL4O4gk5Ux4XAsrFfnqdU9BM7hnfvGVcORCEOHstOOZPbCVO0vGHbdLUnfkPO/kEhFPx0R2qTqkJGdl5Sl6jGdkCzk2GJx+BXfyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568586; c=relaxed/simple;
	bh=G8NMwEuSRB/CcoIUPcK0S3YolO7o8n6Bnm6GXQCevWM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BE8uHxB2nAZj6nAbmCd7ncF8ZSCIYCpC7blnURcAiMx5CkWvB8iSGtRmjPWiHM7eq0QcjjU1xJtDmeY37v+Mq2R9Z1j7jdLp0hOcp2fCJNaQzfcAmZd6uQu11ItSzccEIUVFX5fRN++1silr1PyhM6UUy5zCk3zn2c/nMhx3Y2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPpA495m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPpA495m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB311F000FF;
	Mon, 28 Sep 2026 04:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790568584;
	bh=u43RpCCF5drsEvpIG/ma+yDNf+UcywHh9C8ANoA0Ws4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IPpA495mypCm3cmjopHZFUY3Ony7mnJDP3VxDbQy3c9UyPv5DXQnz1AGP6PM7tJh5
	 AQHH4UdbrPtpliAjZ6X+RBptjbio2oAdMyyDOpTNflU9QZGySZJQftWInpF7aDUm1r
	 /4p/wudUVwA6YNVUUoH3EAZUW4u07W0ugZljfI6HAWaNdB6NqKKsgrAJSfqgZ9t7wH
	 naHQiBlX58xaX8D28E8rXaacR56GlrBE/4k7lH1oMMsyN+Dg4kQcIF2ZQApJUy2aQZ
	 Y1cuAVM0Ld9ANeO7G+LDb33w9IhTmYmx1mRzaGVsW6fwE42vfzX1IJj0lxJKiy9Tsb
	 yXO9d3Nd+V6gA==
Subject:
 Re: [PATCH net-next v2] net: phy: aquantia: add get_features() for AQR113C
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 04:09:43 +0000
Message-ID: <179056858385.3145.15807151008226199830@kernel.org>
In-Reply-To: =?utf-8?q?=3C20260924-net-phy-aqr113c-fix-pma-capability-v2-1-2?=
 =?utf-8?q?9b06283b0f3=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29?=
 =?utf-8?q?b06283b0f3=40oss=2Equalcomm=2Ecom=3E?=
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

- [Medium] The new aqr113c_get_features() stops the kernel from
  discovering EEE on AQR113C.
- [Low] If the premise is true, meaning AQR113C has never had its
  10G/5G/2.5G modes set correctly under the generic PMA path since…

--

net: phy: aquantia: add get_features() for AQR113C

This commit adds a get_features() callback for the AQR113C PHY. The PHY is
said to misreport its PMA capabilities, so the callback sets the
10G/5G/2.5G/1G link modes directly instead of reading the PMA registers.

> AQR113c does not correctly report its supported PMA
> capabilities which includes speeds like 10G/5G/2.5G.

[Severity: Low]
If AQR113C has never had its 10G/5G/2.5G modes reported correctly through
the generic PMA path, the bug goes back to the commit that added the
driver entry:

12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")

Should this carry a Fixes: tag so stable picks it up? The v2 changelog
shows the patch was moved to net-next on purpose, so this is only a
process question.

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
Does this stop EEE discovery on AQR113C?

Before this patch, AQR113C had no .get_features. So phy_probe() took the
is_c45 branch and called genphy_c45_pma_read_abilities(), which ends with
genphy_c45_read_eee_abilities() and fills in phydev->supported_eee.

With the new callback, phy_probe() takes the get_features branch instead.
The core reads EEE abilities itself only in the static features branch:

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

The new call chain is aqr113c_get_features()->aqr111_get_features()->
aqr115c_get_features(). It only sets speed bits in phydev->supported and
never touches supported_eee.

Later in phy_probe(), the empty supported_eee then clears advertising_eee
and eee_cfg.eee_enabled ends up false:

	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
		     phydev->advertising_eee);

genphy_c45_write_eee_adv() also writes the 7.60/7.62 advertisement
registers only when supported_eee intersects PHY_EEE_CAP1_FEATURES or
PHY_EEE_CAP2_FEATURES. That means the kernel can no longer change or clear
the EEE advertisement the PHY comes up with. Also, ethtool --show-eee
would report no supported modes.

aqr105_get_features() in the same file keeps EEE discovery by calling the
generic helper first and then adding the missing modes:

	ret = genphy_c45_pma_read_abilities(phydev);
	if (ret)
		return ret;

Would it make sense to follow that pattern here? Another option is to call
genphy_c45_read_eee_abilities(phydev) after setting the link modes.

AQR111, AQR114C and AQR115C already have the same gap. On AQR113C it is
new with this patch.

[ ... ]

> @@ -1444,6 +1456,7 @@ static struct phy_driver aqr_driver[] = {
>  	.get_sset_count = aqr107_get_sset_count,
>  	.get_strings    = aqr107_get_strings,
>  	.get_stats      = aqr107_get_stats,
> +	.get_features   = aqr113c_get_features,
>  	.link_change_notify = aqr107_link_change_notify,
>  	.led_brightness_set = aqr_phy_led_brightness_set,
>  	.led_hw_is_supported = aqr_phy_led_hw_is_supported,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29b06283b0f3%40oss.qualcomm.com
