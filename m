Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA571990A7;
	Sun, 19 Jul 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458076; cv=none; b=YUAunn51TgtMWcAbq2rSOnu+j363ZB+wIXSS4rpnVn5NhxR2ZRfWXFPAogIIarRc2/3vTwpTmhEkdt5wL/biE7JAJiMXieIBQTMSMVDpiXF60ABQJN3zLoLgi5xfQAzsOpkESGqL+8TFmiF0Kmy6CKTdb5Yx94D1ycBq5R4KGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458076; c=relaxed/simple;
	bh=kP6Mnc4zLctSv928rku8zR8L/wTSFwC783UHAIJgZng=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eRt/oUTfXL5bRHgulkkiyJCsJP6G33lJZdE1nzU6qD32+hnKRiYnfAVBUF5z/g2AfkpGsNmAxupa+wOfzYnVbT/sQu5zklxPHuW4GlUPia/25v8SKscVMtJclcJZAs0lavSY5X7ABAei54y9yUZuDVCdwHOCH2ka2jNlk29E16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3K5sGj00; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3K5sGj00"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17ADBA5188;
	Sun, 19 Jul 2026 12:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784458072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6OZrx4HccjSOL5B1zaxcIk5+e6e8FFrFt2CK42KZZHA=;
	b=3K5sGj00ae8sPZ9E0mIi7C9L4yYkZJwn951T5bklcTB/X6Wxrpi4BxT6/5FwbuXXZHDwxv
	mZkVp607WRYVCO+SEBZX7NWHKuE3JT4UcKhaYBuBSp2pVz+K0JfUkoJo4W03NxpWzD/nTn
	IdAyrtN3ympOFFSxM5oaOWfWl7IHdZYNcuWgJhWCMOdlefxUcr8HyjzWY7FXKs7FXwLW6H
	94GCQLofkW8HDMJX3BKGqBavnZtiSCLjx+YI0lxA3Ynq7ILv6zADQP+Upo+sAXrs9Q2FML
	gcfwhHPZ5qqrveXukKkBSoVvvZDWL0q8/d7I/imo99d6T1VdCT95mRW6SIOf9Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:47:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 12/15] net: macb: introduce
 macb_context_alloc() helper
In-Reply-To: <20260717-macb-context-v4-12-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-12-0acbe7f10cdb@bootlin.com>
Message-ID: <ff52f79545c1e68e267e10ea43bc47fd@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> Move the context allocation sequence from inline macb_open() to its own
> helper function called macb_context_alloc(). All ops doing context
> swapping (set_ringparam, change_mtu, etc) will use this helper.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 56 
> +++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index d396a307310b..4c94c23d925a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2866,6 +2866,36 @@ static int macb_alloc(struct macb_context *ctx)
>  	return -ENOMEM;
>  }
> 
> +static struct macb_context *macb_context_alloc(struct macb *bp,
> +					       unsigned int mtu,
> +					       unsigned int rx_ring_size,
> +					       unsigned int tx_ring_size)
> +{
> +	struct macb_context *ctx;
> +	int err;
> +
> +	ctx = kzalloc_obj(*ctx);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->info = &bp->info;
> +	ctx->rx_buffer_size = macb_rx_buffer_size(bp, mtu);
> +	ctx->rx_ring_size = rx_ring_size;
> +	ctx->tx_ring_size = tx_ring_size;
> +
> +	err = macb_alloc(ctx);
> +	if (err) {
> +		netdev_err(bp->netdev,
> +			   "Unable to allocate DMA memory (error %d)\n", err);
> +		kfree(ctx);
> +		return ERR_PTR(err);
> +	}
> +
> +	bp->macbgem_ops.mog_init_rings(ctx);
> +
> +	return ctx;
> +}
> +
>  static void gem_init_rx_ring(struct macb_context *ctx, unsigned int q)
>  {
>  	struct macb_rxq *rxq = &ctx->rxq[q];
> @@ -3233,27 +3263,15 @@ static int macb_open(struct net_device *netdev)
>  	if (err < 0)
>  		return err;
> 
> -	bp->ctx = kzalloc_obj(*bp->ctx);
> -	if (!bp->ctx) {
> -		err = -ENOMEM;
> +	bp->ctx = macb_context_alloc(bp, netdev->mtu,
> +				     bp->configured_rx_ring_size,
> +				     bp->configured_tx_ring_size);
> +	if (IS_ERR(bp->ctx)) {
> +		err = PTR_ERR(bp->ctx);
> +		bp->ctx = NULL;
>  		goto pm_exit;
>  	}
> 
> -	bp->ctx->info = &bp->info;
> -
> -	/* RX buffers initialization */
> -	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
> -	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
> -	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
> -
> -	err = macb_alloc(bp->ctx);
> -	if (err) {
> -		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
> -			   err);
> -		goto free_ctx;
> -	}
> -
> -	bp->macbgem_ops.mog_init_rings(bp->ctx);
>  	macb_init_buffers(bp);
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> @@ -3292,7 +3310,6 @@ static int macb_open(struct net_device *netdev)
>  		napi_disable(&queue->napi_tx);
>  	}
>  	macb_free(bp->ctx);
> -free_ctx:
>  	kfree(bp->ctx);
>  	bp->ctx = NULL;
>  pm_exit:
> @@ -5175,6 +5192,7 @@ static int at91ether_open(struct net_device 
> *netdev)
>  		ret = -ENOMEM;
>  		goto pm_exit;
>  	}
> +	bp->ctx->info = &bp->info;
> 
>  	/* Clear internal statistics */
>  	ctl = macb_readl(bp, NCR);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
