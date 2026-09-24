Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE6392822;
	Thu, 24 Sep 2026 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271948; cv=none; b=VyFxjh94uzgVCt83y+ezfzuRmPmGoacnTWl7meLKvenb3FIa74MJvVSr9xVYodgTWQkj/EflGm/L5GEZ6MhNa90V+l/hnhTf5Ztd5aCXhl8dVAQ0ncLKHTXsMUQzKOM0f3JKeO+b413rlyPF8XXURZamYEE+1/hpeyiv3CgE3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271948; c=relaxed/simple;
	bh=h2/blhNRsbh+o1/mlauzZ99tk9oz4LtaDqUXDn45kek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GppiOgDOX8B6zkcVsHAvebHqZIMPkiQSLfJObnceK3g6Tr4eVZ/mG/X/WExLLmz+qWk0grMvzAqWWAUP2betPhYKxHw7mSHgdqYUyEvBGOhnFEXpSaiH4iGuxznzHa+ogtyGYiLGHeGPhZF21uIgxDqdZoT+HmJkGegst5bOiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNTv1Cqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNTv1Cqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717F91F000FF;
	Thu, 24 Sep 2026 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271946;
	bh=2OTsgbPso9JAaikpPdxHlRHS3J5ziutEjtFkotSuZTQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNTv1Cqy/drc640tyzTAZSev+oJZA4cOBCCG6EhuhGf42oecf/RxYpvUUYGWZXXJ3
	 aqoqrcqQv636j7h+CYN5STRmhdkZiOWLuciFOsWe3I9qATPbs63/kZstnPboMqvPF8
	 aItELmuHUmWmL0gmTooCDTyHfj5r5TAnCYQUfFkShRUJV9m1/Xzaf5IJsgMZNPF1Zw
	 ZYGiKkebKbDOvxYayUSlkDumtLrcHCehef2bf2XBfUPQrzADBOBi/vUVtgeAZa/bF0
	 PQ4jsj3gbO8Si0h5Vz2G1hE1ImSeu5uB1CrQkst+HuZcuUcVfftrczJp3EPIW3DBkq
	 lYXFm/upQ8dxQ==
Subject: Re: [PATCH v2] net: phy: aquantia: Add support for 5GbaseR
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 17:45:46 +0000
Message-ID: <179027194602.2160803.1483822531995612133@kernel.org>
In-Reply-To:
 <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
References:
 <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
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

- [Medium] The commit message does not mention a behaviour change in
  aqr_gen2_get_rate_matching()…
- [Low] The submission is incomplete.

--

net: phy: aquantia: Add support for 5GbaseR

This patch decodes PHYXS interface status code 12 as 5GBASER in
aqr_gen1_read_status(). It also makes aqr_gen1_config_init() accept
5GBASER, and makes aqr_gen2_get_rate_matching() report pause rate
matching for 5GBASER.

> Add support for 5GbaseR within Aquantia phy driver.
>
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://patch.msgid.link/20260923-aquantia-support-5gbaser-v1-1-537d39bb8c35@oss.qualcomm.com

[Severity: Low]
This isn't a bug, but the v2 changelog is still the unedited b4 template.
That makes it hard to tell what changed since v1.

The commit body is also a single line. Could it describe the three
separate changes in the patch?

  - aqr_gen1_read_status() now decodes interface status code 12.
  - aqr_gen1_config_init() now accepts 5GBASER for all gen1 and later
    PHYs, including AQR105.
  - aqr_gen2_get_rate_matching() now returns RATE_MATCH_PAUSE for
    5GBASER on existing gen2 and later PHYs.

Separately, the new define lines up its value with spaces:

  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G   12

The neighbouring MDIO_PHYXS_VEND_IF_STATUS_TYPE_* defines use tabs.

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e95d391a6dc23..0bcec88fcf727 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c

[ ... ]

> @@ -1040,7 +1045,8 @@ static int aqr_gen2_get_rate_matching(struct phy_device *phydev,
>  				      phy_interface_t iface)
>  {
>  	if (iface == PHY_INTERFACE_MODE_10GBASER ||
> -	    iface == PHY_INTERFACE_MODE_2500BASEX)
> +	    iface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    iface == PHY_INTERFACE_MODE_5GBASER)
>  		return RATE_MATCH_PAUSE;

[Severity: Medium]
Every PHY that uses aqr_gen2_get_rate_matching() now gets
RATE_MATCH_PAUSE for 5GBASER instead of RATE_MATCH_NONE. That covers
AQR107, AQCS109, AQR111/B0, AQR112, AQR412/C, AQR113/C, AQR114C,
AQR115/C and AQR813. Does this hold for every firmware provisioning?

aqr_gen2_read_global_syscfg() maps XFI5G to 5GBASER whatever the
provisioned rate adaptation mode is:

drivers/net/phy/aquantia/aquantia_main.c:aqr_gen2_read_global_syscfg() {
    ...
		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G:
			interface = PHY_INTERFACE_MODE_5GBASER;
			break;
    ...
}

So 5GBASER can end up in possible_interfaces when firmware provisions
XFI5G with RATE_ADAPT_NONE or RATE_ADAPT_USX.

At runtime, aqr_gen2_read_status() still takes the provisioned value:

drivers/net/phy/aquantia/aquantia_main.c:aqr_gen2_read_status() {
    ...
		if (syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE)
			phydev->rate_matching = RATE_MATCH_PAUSE;
		else
			phydev->rate_matching = RATE_MATCH_NONE;
    ...
}

phylink validation, however, uses the fixed answer:

phylink_validate_one()
    tmp_state.rate_matching = phy_get_rate_matching(phy, interface);
    ...
    phylink_get_capabilities()

When 5GBASER returns PAUSE, phylink_get_capabilities() adds every speed
below 5G to the supported and advertised link modes over 5GBASE-R. The
fallback path in phylink_validate_phy() also stops widening validation to
all interfaces for c45 PHYs.

The get_rate_matching kernel-doc in include/linux/phy.h says:

  It is assumed that if a rate matching mode is supported on an
  interface, then that interface's rate can be adapted to all slower
  link speeds supported by the phy.

Could phylink then advertise 10M to 2.5G over a 5GBASE-R host link that
the PHY won't pause-adapt? A MAC that only supports 5GBASE-R is one
example. Validation and runtime would then disagree about the same
interface.

The existing 10GBASER and 2500BASEX checks are just as unconditional, but
the 5GBASER case is new in this patch. Would it make sense to check the
provisioned rate_adapt in priv->global_cfg[] for the requested interface?
The commit message also doesn't mention this change in behaviour.

>  	return RATE_MATCH_NONE;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-aquantia-support-5gbaser-v2-1-4d789dc21418%40oss.qualcomm.com
