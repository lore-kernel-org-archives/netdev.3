Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4A43F081
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191339; cv=none; b=JRw2MvEvQ88b0/+qCYLiwdj9EkRhwscGUr+8A7WsfbQhdRPNoujaLPEy2Qn//3mwAGaG04Mn6CwBHJU+/LLGIdG98mZdK3R6MU+8FZpRiRAA1i0F0tNZ8mXRf7Y3G5RVqMP9qNZDmrdtWgqI6W8Zjsz9F4UaviHS7nU059EH9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191339; c=relaxed/simple;
	bh=VQZX0Da/ceNqihT/J5l4QQg0qaaZ5ORM9Sx6bZuzuyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm6qhAoFxV/XOYBXrsQDC1cVzuZwJGElWFRW2puQZoMcfZIhRPZyPVCUWA6LTqKlPn0o8uQ0JAbKVRMfj6wOx/BZOgDSYgCCJQZZ6vSTmPBoecBUbveRiILUUx1YpGbsuAgr1lkfTAfEwK3fKEDbtZdKl3u5rLJYIOAl+5kbLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iUSR1pPm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iUSR1pPm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4EA874E41192;
	Mon,  5 Oct 2026 09:08:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15477604FE;
	Mon,  5 Oct 2026 09:08:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60A2C103302A5;
	Mon,  5 Oct 2026 11:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791191332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=07uKuqI8GniZ9HvoR4zINMNLz/CuH/DmSgE2kepr/K4=;
	b=iUSR1pPm/oxDt9LD+8Tef6UKLEh3GJDKmXBpKxrg3lTrXBl+NpjKwdwWWKPjJi8rUOmoBE
	JDh3qfFfjmMb4IHl1U48/OVYA293hYpYSb84y9JSbJA2IaDg1IkjQO+ShbSIb8J3WztIyW
	OtmyzQuETPKyd7DExeVRLqdP5KWEtg1B96Sm8lMsGV8Ekn94MtL+zDp3iGntGaox85IrBm
	21tx9zAXQqWZMlAoRjvVtxaleg6t5uojJdZePETfNyMenuFWDw1mB11Upzg46OuUH7XR4M
	IcRqv8A65dy/EvaP7JFazYPGQHrOAe7PeL1JuTJwoQRpulql0Apc7bYBGCb3Ug==
Message-ID: <38937aef-76e9-440f-97f6-4ea68f9b2091@bootlin.com>
Date: Mon, 5 Oct 2026 11:08:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 10/5/26 10:11, Lorenzo Bianconi wrote:
> stmmac_dl_ts_coarse_set() runs under devl_lock only while
> stmmac_hwtstamp_set() runs under RTNL. They read/write
> systime_flags/tsfupdt_coarse and run stmmac_config_hw_tstamping().
> 
> stmmac_dl_ts_coarse_set() snapshots priv->systime_flags, programs
> PTP_TCR, PTP_SSIR and PTP_TAR, and only then publishes tsfupdt_coarse
> and systime_flags. A concurrent stmmac_hwtstamp_set() can read the
> stale tsfupdt_coarse, build fine-mode flags, program PTP_TCR in fine
> mode and set hwts_rx_en.
> 
> Take priv->lock in both stmmac_dl_ts_coarse_set() and
> stmmac_hwtstamp_set() so the timestamping configuration is updated
> under a single lock.
> 
> Fixes: 6920fa0c764d ("net: stmmac: Add a devlink attribute to control timestamping mode")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Thanks for fixing this,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> Changes in v2:
> - Use proper Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++++++++---------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a..a6793054a179 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -685,14 +685,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	u32 snap_type_sel = 0;
>  	u32 ts_master_en = 0;
>  	u32 ts_event_en = 0;
> -
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> -		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> -		priv->hwts_tx_en = 0;
> -		priv->hwts_rx_en = 0;
> -
> -		return -EOPNOTSUPP;
> -	}
> +	int ret = 0;
>  
>  	if (!netif_running(dev)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> @@ -700,13 +693,23 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  		return -ENODEV;
>  	}
>  
> -	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
> -		   __func__, config->flags, config->tx_type, config->rx_filter);
> -
>  	if (config->tx_type != HWTSTAMP_TX_OFF &&
>  	    config->tx_type != HWTSTAMP_TX_ON)
>  		return -ERANGE;
>  
> +	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
> +		   __func__, config->flags, config->tx_type, config->rx_filter);
> +
> +	mutex_lock(&priv->lock);
> +
> +	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> +		priv->hwts_tx_en = 0;
> +		priv->hwts_rx_en = 0;
> +		ret = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
>  	if (priv->adv_ts) {
>  		switch (config->rx_filter) {
>  		case HWTSTAMP_FILTER_NONE:
> @@ -829,7 +832,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  			break;
>  
>  		default:
> -			return -ERANGE;
> +			ret = -ERANGE;
> +			goto unlock;
>  		}
>  	} else {
>  		switch (config->rx_filter) {
> @@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
>  
>  	priv->tstamp_config = *config;
> +unlock:
> +	mutex_unlock(&priv->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -7753,9 +7759,12 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
>  	struct stmmac_priv *priv = dl_priv->stmmac_priv;
> -	u32 systime_flags = priv->systime_flags;
> +	u32 systime_flags;
>  	int ret;
>  
> +	mutex_lock(&priv->lock);
> +
> +	systime_flags = priv->systime_flags;
>  	if (ctx->val.vbool)
>  		systime_flags &= ~PTP_TCR_TSCFUPDT;
>  	else
> @@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  	if (ret) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to reconfigure PTP adjustment");
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	priv->tsfupdt_coarse = ctx->val.vbool;
>  	priv->systime_flags = systime_flags;
> +unlock:
> +	mutex_unlock(&priv->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,
> 
> ---
> base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
> change-id: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c
> 
> Best regards,

