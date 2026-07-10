Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D73FF1A4
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677921; cv=none; b=tsgpLx0mpydeHGJzYVcHQp5zs4hYTuqf8jDUZCln6RJ2tIw4FP5VFr7ZX53jcVNNos1RN2MC8HeDfcJrLSJY372Hcc3YcAtJHex0IAYIxZbRt6ppa141xnnLRcuPz/aYgD6If1q/4i+0Kpb7y63RkteWXy9AAV+RKaf//Ci+90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677921; c=relaxed/simple;
	bh=3fuC8z1bhX8psiLhS2onTYM4dWnklLZdxUKaWR/cc3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3UqumTmuNEhZ0m+H/TVv4o8ZCcUsqOdMvdzsjYkpcG9jdh0E3WpAi+Ehws6+OxzX6RLCChL+jrm2q1mGeTk/Dv4aNZu5eF1T2numHu9MwlMPGgQ6SF1UjbaTWssr2g/sRPaiwRcyRLlL7PEa66iDrdNWNYxV7Ak7CAc0FCS/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C6kTVosv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C6kTVosv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5906A1A0F38;
	Fri, 10 Jul 2026 10:05:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B9F260341;
	Fri, 10 Jul 2026 10:05:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E81D11BD1AEB;
	Fri, 10 Jul 2026 12:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783677914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1bX5NSiqOMnl6jJTIinOC/56HJpJ0cYOoXRZKB298/8=;
	b=C6kTVosvos3BivbCjSaXqQXmYMn0ESZowgQT+TW1NgyBRrBpD+Vn7WAOQTSPjqnV4unN7l
	lx6qIIJ/fxBrQBcTwwOBllHOGVV5EjNRUsMOF/l3J3GWG5OKTHjNGvt7GsvAM+2l9iOeLB
	xk2LBdKS8KzS5O/OhXGEGxQdnBslHLN5ipWMbpwh2FPXimzaMGYy2vV3Kb9OhGsM51HVfw
	s+rdnyCi9NZh3696RNHfSigQDcwXvddC0zU0HrwmxDWhZcth7AWjvi2kpI8AE9w5FRFc7M
	uBoUSm6gR3/z35T24SPab0zql6CiFd1341oAhcY8L4yVNU6RnXndctrjjfEM2g==
Message-ID: <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
Date: Fri, 10 Jul 2026 12:05:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, linux@armlinux.org.uk, enelsonmoore@gmail.com,
 daniel@thingy.jp
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260709100237.541-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/9/26 12:02, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> For Realtek nics, when we enable jumbo, pause are not supported. So we
> must check the pause capabilities from ourself and lp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v5:
>  - no changes, new file
> 
> Changes in v6:
>  - rename phylink_update_mac_pause_capabilities(), this function only
>    changes mac pause capability
>  - set asym pause and pause according to config->pause tx and rx
>  - add phydev->lock when change pl->phydev->advertising
> ---
>  drivers/net/phy/phylink.c | 87 +++++++++++++++++++++++++++++++++++++++
>  include/linux/phylink.h   |  2 +
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 59dfe35afa54..9e9cd79301d6 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1828,6 +1828,93 @@ int phylink_set_fixed_link(struct phylink *pl,
>  }
>  EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
>  
> +/**
> + * phylink_update_mac_pause_capabilities() - Dynamically update MAC pause
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @mac_pause: the new MAC pause capabilities mask
> + *
> + * This function allows a MAC driver to dynamically change its pause state,
> + * such as losing/gaining Pause frame support based on MTU size.
> + * It recalculates supported link modes and triggers renegotiation if needed.
> + */
> +void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause)
> +{
> +	struct phylink_link_state *config = &pl->link_config;
> +	unsigned long old_pause, caps_added, caps_removed;
> +	bool pause_adv, asym_adv;
> +
> +	ASSERT_RTNL();
> +
> +	if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
> +		phylink_err(pl, "Attempted to dynamically change non-pause MAC capabilities\n");
> +		return;
> +	}
> +
> +	old_pause = pl->config->mac_capabilities & (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	caps_added = mac_pause & ~old_pause;
> +	caps_removed = old_pause & ~mac_pause;
> +
> +	if (!caps_added && !caps_removed)
> +		return;
> +
> +	mutex_lock(&pl->state_mutex);
> +
> +	pl->config->mac_capabilities &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	pl->config->mac_capabilities |= mac_pause;
> +
> +	if (caps_removed & MAC_SYM_PAUSE)
> +		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
> +	if (caps_removed & MAC_ASYM_PAUSE)
> +		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
> +
> +	linkmode_and(config->advertising, config->advertising, pl->supported);
> +
> +	if (caps_added & MAC_SYM_PAUSE) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
> +		if (pl->phydev && !phylink_test(pl->phydev->supported, Pause))
> +			linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);

Why look at what the PHY can do here ? You shouldn't need to.

> +	}
> +	if (caps_added & MAC_ASYM_PAUSE) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
> +		if (pl->phydev && !phylink_test(pl->phydev->supported, Asym_Pause))
> +			linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
> +	}
> +
> +	linkmode_and(config->advertising, config->advertising, pl->supported);
> +
> +	if (config->pause & MLO_PAUSE_AN) {
> +		if (phylink_test(pl->supported, Pause) &&
> +		    (config->pause & MLO_PAUSE_RX) && (config->pause & MLO_PAUSE_TX))
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, config->advertising);

This isn't correct, Pause is set if RX is set, regardless of the TX value

> +
> +		if (phylink_test(pl->supported, Asym_Pause) &&
> +		    ((config->pause & MLO_PAUSE_RX) ^ (config->pause & MLO_PAUSE_TX)))
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, config->advertising);

to get this right, use :

linkmode_set_pause(adv, config->pause & MLO_PAUSE_TX, config->pause & MLO_PAUSE_RX)

This will build the supported bitfield for you.

I also think we should update pl->link_config.pause, as phylink_ethtool_get_pauseparam will
report wrong values otherwise.

I'm wondering wether it's worth keeping track of the user-requested pause settings when
changing the MTU, we have a true HW capability change here, so I think we should change it.

> +
> +	if (!pl->phydev)
> +		phylink_change_inband_advert(pl);
> +
> +	mutex_unlock(&pl->state_mutex);
> +
> +	if (pl->phydev) {
> +		pause_adv = linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +					      config->advertising);
> +		asym_adv = linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +					     config->advertising);
> +
> +		mutex_lock(&pl->phydev->lock);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +				 pl->phydev->advertising, pause_adv);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +				 pl->phydev->advertising, asym_adv);


This is too much manual interaction with all the supported/advertising in phylink/phylib, it's
hard to read, understand and debug :(

We have helpers in phylib such as phy_set_asym_pause() to change pause settings
in phy_devices, don't set these manually like this.

Let's take a step back, it seems you're following sashiko too literally here.

There's a change in the MAC's ability to support Pause, so we should :

 - Recompute the pl->supported field. Update the config.mac_capabilities with the
   new pause settings, calling phylink_validate() should do the trick I think, this
   will rebuild the capability list:

   phylink_validate(pl, pl->supported, &pl->link_config);
   
 - Then update the pl->link_config.pause,

 - Then update the pause advertising, like done in phylink_setpauseparam
   ( I think, everything that comes after pl->state_mutex gets released in
    phylink_ethtool_set_pauseparam)

Ideally, the logic to update the advertising and re-trigger a negociation
should be factored out in a private helper, then reused from both this
path (MAC updates pause support) and the phylink_ethtool_set_pauseparam path.

> +		mutex_unlock(&pl->phydev->lock);

Why take phydev->lock here ? Sashiko's comment on a possible race with ethtool -s
isn't right, you go through phylink_ethtool_ksettings_set() first, which is
serialised with this current function through RTNL.

Maxime
