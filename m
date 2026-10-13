Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4147604A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895551; cv=none; b=dVaFeHuJNEmzCaTxzb89dfEU7LNbBsMyFtLiS7u7I7o8mcfcr0sWRhlPwIZfm96uWqY5NzqvlEP6P2G64Vnk0SR7ZnXAHxyBUNuMgM58pnzAfFdw3XNVndz/wbfLW9Ms319Uw6V1Ze7TJkxlZ6bTDWs9+cZYKPa+zE9+KjvBeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895551; c=relaxed/simple;
	bh=8Ej5047EGa9SQQ7fDZBCo+IOLP4kElj2ptnrFmmlSFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxtqyEyUA7mq0tjyx9a8To1w8YczpcQG62K7Te9CubYAuaNioCyxGArMGGuA1lPwf6dG7xfdnXAQmA/nrsw2tKVpWy2fa0XRp3+Z6ZpM1LzyO5qDqHfB03h2uv1hamT8e+mJL9W5ouUso73OO919ItGP7PQ3nUlnZ+VxVOaQpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=luxXCgWp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="luxXCgWp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 06DC5C653EB;
	Tue, 13 Oct 2026 12:46:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 708AB60362;
	Tue, 13 Oct 2026 12:45:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48F3C11D7117D;
	Tue, 13 Oct 2026 14:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791895546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=b35gyqtypMMfbLXDKU179g34nu1XmunQVKn+LDLfT4Y=;
	b=luxXCgWp9wH3wbc1Nno+EuCfsV4mY2cUXjBcb+yfFmV+yijxiOYbZGvJxwys2PWin8ofek
	abIe2l/NMdiuYD4DtHYPxnW2LB3UuTnQyr7xUK6GrmwmmvWkk1fIJnagUn6ZDVbQ/tIJJI
	7yLlXpXJ+G+w1tZR6X3863NJnRIcR/aXDLm3/wpFY1uK4xyp0GY4/uKwLk9ZE8P2uylwkJ
	51K96yUWUVCK15nnjG95GqnYhFGz+CmHvhn6tHbOf2f2KOVPCN/wcmtVmQrND0yCRzFzZw
	qmxM9tw/5lQ3NKiNoSW9Qj7sCWpZU2oOslw1lurWccatsu511RDqyrg7fBhKdg==
Message-ID: <73ae9104-a79f-4369-a3da-245db11be834@bootlin.com>
Date: Tue, 13 Oct 2026 14:45:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: Track the TX DMA threshold per queue
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 xiaoliang.yang_1@nxp.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
 <20261013114503.57487-2-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261013114503.57487-2-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/13/26 13:45, Ovidiu Panait wrote:
> Commit 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from
> DMA descriptor") made dwmac4 raise the DMA threshold of the queues that
> report TX underflows. This is done by incrementing a module global
> parameter 'tc' by 64 on each underflow.
> 
> This leads to inconsistent TX DMA thresholds between queues and causes
> issues on platforms with multiple stmmac controllers, as 'tc' is shared
> by all of them. Once 'tc' goes over 256 the bumping stops, and queues
> that did not underflow before are left at the initial threshold.
> 
> On the Renesas RZ/V2H platform, which has two dwmac4 controllers, we
> observed sporadic iperf3 TCP TX failures:
> 
>   iperf3 -c <server> -t5 --bind-dev end1
>   ...
>   [  5]   0.00-5.00   sec  1.00 MBytes  1.68 Mbits/sec   87       sender
>   [  5]   0.00-5.00   sec   768 KBytes  1.26 Mbits/sec            receiver
> 
> This happens because the TX queues of end1 were underflowing on a large
> fraction of the packets, but the DMA TX threshold was never raised from
> the default of 64 bytes. The threshold was not raised because end0
> had underflowed first and had already pushed 'tc' past 256. Which
> controller is affected depends on which one underflows first.
> 
> To fix this, make the TX DMA threshold per queue instead of global.
> Each time an underflow happens on a queue, its TX DMA threshold gets
> incremented, without affecting other queues or controllers. With this
> change, 'tc' is only used as the initial value, and the RX threshold
> is no longer bumped together with the TX one, as TX underflows have
> nothing to do with the RX side.
> 
> Fixes: 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from DMA descriptor")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 +++++++++++--------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 9278378407e8..85d63450693e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -270,6 +270,7 @@ struct stmmac_priv {
>  	bool sph_capable;
>  	u32 sarc_type;
>  	u32 rx_riwt[MTL_MAX_RX_QUEUES];
> +	u32 tx_threshold[MTL_MAX_TX_QUEUES];
>  	int hwts_rx_en;
>  	bool tsfupdt_coarse;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b8b4de4c5b1a..b5ee0f297df6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2622,7 +2622,6 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>  	}
>  
>  	if (priv->plat->force_thresh_dma_mode) {
> -		txmode = tc;
>  		rxmode = tc;
>  	} else if (priv->plat->force_sf_dma_mode || priv->plat->tx_coe) {
>  		/*
> @@ -2636,7 +2635,6 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>  		rxmode = SF_DMA_MODE;
>  		priv->xstats.threshold = SF_DMA_MODE;
>  	} else {
> -		txmode = tc;
>  		rxmode = SF_DMA_MODE;
>  	}
>  
> @@ -2655,8 +2653,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>  	for (chan = 0; chan < tx_channels_count; chan++) {
>  		qmode = priv->plat->tx_queues_cfg[chan].mode_to_use;
>  
> -		stmmac_dma_tx_mode(priv, priv->ioaddr, txmode, chan,
> -				txfifosz, qmode);
> +		if (txmode == SF_DMA_MODE)
> +			priv->tx_threshold[chan] = SF_DMA_MODE;
> +
> +		stmmac_dma_tx_mode(priv, priv->ioaddr, priv->tx_threshold[chan],
> +				   chan, txfifosz, qmode);
>  	}
>  }
>  
> @@ -2822,17 +2823,20 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  
>  static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
>  {
> -	if (unlikely(priv->xstats.threshold != SF_DMA_MODE) && tc <= 256) {
> -		tc += 64;
> +	u32 thresh = priv->tx_threshold[chan];
>  
> -		if (priv->plat->force_thresh_dma_mode)
> -			stmmac_set_dma_operation_mode(priv, tc, tc, chan);
> -		else
> -			stmmac_set_dma_operation_mode(priv, tc, SF_DMA_MODE,
> -						      chan);
> +	if (unlikely(thresh == SF_DMA_MODE) || thresh > 256)
> +		return;
>  
> -		priv->xstats.threshold = tc;
> -	}
> +	thresh += 64;
> +
> +	if (priv->plat->force_thresh_dma_mode)
> +		stmmac_set_dma_operation_mode(priv, thresh, tc, chan);
> +	else
> +		stmmac_set_dma_operation_mode(priv, thresh, SF_DMA_MODE, chan);
> +
> +	priv->tx_threshold[chan] = thresh;
> +	priv->xstats.threshold = thresh;
>  }
>  
>  /**
> @@ -8133,6 +8137,9 @@ static int __stmmac_dvr_probe(struct device *device,
>  
>  	priv->xstats.threshold = tc;
>  
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
> +		priv->tx_threshold[i] = tc;
> +
>  	/* Initialize RSS */
>  	rxq = priv->plat->rx_queues_to_use;
>  	netdev_rss_key_fill(priv->rss.key, sizeof(priv->rss.key));

