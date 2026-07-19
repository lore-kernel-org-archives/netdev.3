Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2D2248BE;
	Sun, 19 Jul 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458010; cv=none; b=S0UoDgquOBGXy5AQhcugqmbdbBinFnvx1Ipk59JPSCtB+PL4RxQ5rWgPTIXdqsTPI0Vi9RBwmfgYChViOVZ8VvehCW6c1WrzJ4TjvIhewQo/b0TJ3rd/MtvLZIAWOzmjXCjIVE65mRa2lQGCydxXHl4DYdWWH/GT/m0V297Mtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458010; c=relaxed/simple;
	bh=cjTio2cr8zkLy78n9czGPMRtOPQp8wDvzWH6CSLUhbM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JOKM4VdOrQP7LPI8f6JsNFFjtKt/GtLDA7Wg6i4CLHW1tESptO5yGqFjOCXJYLRfpG4oDz140MAP3gocTR7HjzmlfHS2QP4lIwwPJ9X56h/Xw25JkNHCdR0iVorrE08oZfDwadoE9ngkBDFjlRzpAexnV97IaWdDpcIrOAxOHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=RvSMFMfn; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="RvSMFMfn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C239FA5120;
	Sun, 19 Jul 2026 12:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784458006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FUlJoECOW7ToCFgynV5EzrwYjwvK/90Mqnzo4M89AiQ=;
	b=RvSMFMfnphw/yTAkcw+gRDeTH9Lnd3HLJS98Zxssk/Uhy+kIbhrlINh3IoqOkmsA0g80io
	JQnHwosCkGLtHrSvSCugbNBcWB0AwaLXfetNR3Z/gSbgVm309tWGOTieeScQCPM9Ze9y3I
	a9U3PIsXQ5OqYO29HmbFYx/dNiH8cWwqGwiGySZEm05QXzRapF0FN+wFQZiy9XpQE6m2Fs
	FQE6dzQvH/qWfTqdGw4E52g/8D3tkj9cNQvjlMmG0cYzgYsKioffXvdQzKrexB+eeEOV6C
	GCOrJFeyf5GoC6CFl5+y77z58CgzIaUrEweOXPrTayUXwrAL+zlar7IQVwkQQw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:46:44 +0200
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
Subject: Re: [PATCH net-next v4 11/15] net: macb: change function signatures
 to take contexts
In-Reply-To: <20260717-macb-context-v4-11-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-11-0acbe7f10cdb@bootlin.com>
Message-ID: <a6ae2cec6d910378e790d52cc3fd1a00@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> For parallel MACB context to start become a reality, many functions 
> need
> to stop operating on bp->ctx (the currently active context) and instead
> work on a context they get passed. That context might be
> (1) the new one that is getting allocated and initialised, or,
> (2) the old one to be freed.
> 
> To reduce bug surface area, taint those functions to *only* take a
> context `struct macb_context *ctx` and no `struct macb *bp`. That way,
> no bug of using `bp->ctx` instead of `ctx` will ever occur.
> 
> We also convert functions that take a `struct macb_queue *queue` to
> instead take `struct macb_context *ctx, unsigned int q`, with q
> indexing ctx->txq[] and ctx->rxq[].
> 
> Full list:
> 
>    macb_adj_dma_desc_idx()
>    macb_tx_ring_wrap()
>    macb_tx_desc()
>    macb_rx_ring_wrap()
>    macb_rx_desc()
>    macb_get_addr()
>    gem_rx_refill()
>    macb_init_rx_ring()
>    gem_free_rx_buffers()
>    macb_free_rx_buffers()
>    macb_tx_ring_size_per_queue()
>    macb_rx_ring_size_per_queue()
>    macb_free()
>    gem_alloc_rx_buffers()
>    macb_alloc_rx_buffers()
>    macb_alloc()
>    gem_init_rx_ring()
>    gem_init_rings()
>    macb_init_rings()
> 
> Note about gem_rx_refill(): it ends with a netdev_vdbg() that prints 
> the
> queue pointer. Change to print the queue index because we do not have
> access to the queue anymore.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   7 +-
>  drivers/net/ethernet/cadence/macb_main.c | 398 
> ++++++++++++++++---------------
>  2 files changed, 215 insertions(+), 190 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index c551d7db8ebe..ac2f2d8065d7 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1196,11 +1196,12 @@ static const struct gem_statistic 
> queue_statistics[] = {
> 
>  struct macb;
>  struct macb_queue;
> +struct macb_context;
> 
>  struct macb_or_gem_ops {
> -	int	(*mog_alloc_rx_buffers)(struct macb *bp);
> -	void	(*mog_free_rx_buffers)(struct macb *bp);
> -	void	(*mog_init_rings)(struct macb *bp);
> +	int	(*mog_alloc_rx_buffers)(struct macb_context *ctx);
> +	void	(*mog_free_rx_buffers)(struct macb_context *ctx);
> +	void	(*mog_init_rings)(struct macb_context *ctx);
>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>  			  int budget);
>  };
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 7574418d5094..d396a307310b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

> [...]

> @@ -5083,7 +5107,7 @@ static int at91ether_start(struct macb *bp)
> 
>  	addr = rxq->buffers_dma;
>  	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
> -		desc = macb_rx_desc(queue, i);
> +		desc = macb_rx_desc(bp->ctx, 0, i);

AFAIU at91ether_open() doesn't set bp->ctx->info at this point in the
series, so with CONFIG_MACB_USE_HWSTAMP=y this should oops on ifup:

     macb_rx_desc()
       macb_adj_dma_desc_idx()
         macb_dma_ptp(ctx->info)   -> NULL deref

The next patch adds the missing assignment to at91ether_open(), so
only bisection is affected. Maybe move that line here or into patch 9?

> [...]

Thanks
Nicolai
