Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338C379C5D;
	Sun, 19 Jul 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784457641; cv=none; b=pWxE3RelKysgj8LXJlcJldmVgP3ANzkOpLVh6+A8yYgO2SOCmX/1tt7mGJuzAtjX9CpQUj+d//960ZQNAfnOjCFAoGzzwi3H9NQWU4H4/Ws6zJm31LzIbq+7gzZnSzsKJGOSmaC8wg/Y5Rhhf1HdwrIX8p2AIbFzm1Q2vVPlIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784457641; c=relaxed/simple;
	bh=pW3FjyuN5ele+CIlVgZFWovV1GW1r4TOCxjJFxSoIPc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=acI2hgQ7uTYZgPnIl1SwSLCvnVHAnCiUqCxiXxA+GB+SIyh+p7oRDnF+AJhpBEmRyl343f84ApBsViIHhUeHIDC0t2momNN6rNBA7Vevz2tWMfzWilAbkHWD5eE9M3hG+7DsYLwC2U6UQpYIz+qUQa921XH3HJiWmCOgBr3jiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jITSgT7C; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jITSgT7C"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB8C4A47FE;
	Sun, 19 Jul 2026 12:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784457637; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bDifZqXwxSBfjijAhLdPVREQPjsKboLNIVcVrv/bfnE=;
	b=jITSgT7CEwIAPwRBAkbl6tERjjCEGvoFpHe3MduDZLo3gJu6CyVmEqFQVvKGnefbqmjr88
	xMnPf1xyj0yRMaqQXOHWuL9BHn30BB+XWvhZGZZdCxERaoQp2PdgxKXNdvTgi+SwKxwMve
	jVVAVOw1ewiduzkroyXdRmVxzkm2ktewYw4h7nxyMmhI0DJruT7wORUw6y53PAT/10mm8h
	A8EdfENuGYOF/lw9SNE0JRZwOgxvCNaYziZWPJf8iazh8IxFL/AlN7nn0Ko1YPIBTI3axd
	TOemq5ghJehQ3CFXptd1BShZtaYnkWaAS26n4QifXksd7pLpZeD37nTfpWEYhg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:40:36 +0200
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
Subject: Re: [PATCH net-next v4 09/15] net: macb: make `struct macb` subset
 reachable from macb_context struct
In-Reply-To: <20260717-macb-context-v4-9-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-9-0acbe7f10cdb@bootlin.com>
Message-ID: <46fd268fe30473c2e13c93809f85a74d@tipi-net.de>
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
> To reduce bug surface area, we will taint those functions to *only* 
> take
> a context and no `struct macb *bp`. That way, no bug of using `bp->ctx`
> instead of `ctx` will ever occur.
> 
> For that, we need to embed a subset of `struct macb` information into
> each context so that all helpers can still do their jobs. That subset
> must be constant once probe is completed. Do this by taking a pointer
> to a subset of macb called `struct macb_info`.
> 
> That subset is accessible from context (ctx->info->caps) or
> from bp (bp->caps) using `-fms-extensions` option, thanks to
> commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").
> https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html
> 
> Add the structure and assign ctx->info at alloc,
> but nothing uses it yet.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      | 31 
> ++++++++++++++++++++++---------
>  drivers/net/ethernet/cadence/macb_main.c |  5 +++++
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index 452b2c8f8641..2db01fa81559 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1290,6 +1290,17 @@ struct ethtool_rx_fs_list {
>  	unsigned int count;
>  };
> 
> +struct macb_info {
> +	struct platform_device	*pdev;
> +	struct net_device	*netdev;
> +	struct macb_or_gem_ops	macbgem_ops;
> +	unsigned int		num_queues;
> +	u32			caps;
> +	int			rx_bd_rd_prefetch;
> +	int			tx_bd_rd_prefetch;
> +	struct queue_stats	*queue_stats[MACB_MAX_QUEUES];
> +};
> +
>  struct macb_rxq {
>  	struct macb_dma_desc	*ring;		/* MACB & GEM */
>  	dma_addr_t		ring_dma;	/* MACB & GEM */
> @@ -1309,6 +1320,8 @@ struct macb_txq {
>  };
> 
>  struct macb_context {
> +	const struct macb_info	*info;
> +
>  	unsigned int		rx_buffer_size;
>  	unsigned int		rx_ring_size;
>  	unsigned int		tx_ring_size;
> @@ -1324,6 +1337,15 @@ struct macb {
>  	u32	(*macb_reg_readl)(struct macb *bp, int offset);
>  	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
> 
> +	/*
> +	 * Give direct access (bp->caps) and
> +	 * allow taking a pointer to it (&bp->info) for contexts.
> +	 */
> +	union {
> +		struct macb_info;
> +		struct macb_info info;
> +	};
> +
>  	/*
>  	 * Context stores all its parameters.
>  	 * But we must remember them across closure.
> @@ -1335,17 +1357,14 @@ struct macb {
>  	struct macb_dma_desc	*rx_ring_tieoff;
>  	dma_addr_t		rx_ring_tieoff_dma;
> 
> -	unsigned int		num_queues;
>  	struct macb_queue	queues[MACB_MAX_QUEUES];
> 
>  	spinlock_t		lock;
> -	struct platform_device	*pdev;
>  	struct clk		*pclk;
>  	struct clk		*hclk;
>  	struct clk		*tx_clk;
>  	struct clk		*rx_clk;
>  	struct clk		*tsu_clk;
> -	struct net_device	*netdev;
>  	/* Protects hw_stats and ethtool_stats */
>  	spinlock_t		stats_lock;
>  	union {
> @@ -1353,15 +1372,12 @@ struct macb {
>  		struct gem_stats	gem;
>  	}			hw_stats;
> 
> -	struct macb_or_gem_ops	macbgem_ops;
> -
>  	struct mii_bus		*mii_bus;
>  	struct phylink		*phylink;
>  	struct phylink_config	phylink_config;
>  	struct phylink_pcs	phylink_usx_pcs;
>  	struct phylink_pcs	phylink_sgmii_pcs;
> 
> -	u32			caps;
>  	unsigned int		dma_burst_length;
> 
>  	phy_interface_t		phy_interface;
> @@ -1404,9 +1420,6 @@ struct macb {
>  	struct delayed_work	tx_lpi_work;
>  	u32			tx_lpi_timer;
> 
> -	int	rx_bd_rd_prefetch;
> -	int	tx_bd_rd_prefetch;
> -
>  	u32	rx_intr_mask;
> 
>  	struct macb_pm_data pm_data;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 29bf3c497f2a..40ebe20bb40c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3211,6 +3211,8 @@ static int macb_open(struct net_device *netdev)
>  		goto pm_exit;
>  	}
> 
> +	bp->ctx->info = &bp->info;
> +
>  	/* RX buffers initialization */
>  	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
>  	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
> @@ -5870,6 +5872,7 @@ static int macb_probe(struct platform_device 
> *pdev)
>  	u32 wtrmrk_rst_val;
>  	void __iomem *mem;
>  	struct macb *bp;
> +	unsigned int q;
>  	int num_queues;
>  	bool native_io;
>  	int err, val;
> @@ -5915,6 +5918,8 @@ static int macb_probe(struct platform_device 
> *pdev)
>  	bp->netdev = netdev;
>  	bp->regs = mem;
>  	bp->native_io = native_io;
> +	for (q = 0; q < MACB_MAX_QUEUES; q++)
> +		bp->info.queue_stats[q] = &bp->queues[q].stats;
>  	if (native_io) {
>  		bp->macb_reg_readl = hw_readl_native;
>  		bp->macb_reg_writel = hw_writel_native;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
