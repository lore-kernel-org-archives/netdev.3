Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604D34EEFB
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663653; cv=none; b=isqO2TawvZBY/tTqv+XMW+dML+W2jvuS9gUJq+u6xt2NCan8zDWrXrHgwRx4tf2rcO4MQwcb/hh9HcYVyE6KwiUYDUQEhXzPZVRkFkQn6xB2Bny7B3khvncnFz0ZELoJUkEHmIfQR1vtFPVJbGsM6btv08FMRtAfNCj5n0/zci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663653; c=relaxed/simple;
	bh=8EZjJ7bsklWn385NmwPw/6ua7IgqMEtQC5b0JTn1FV8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cI0YwAu4BKBYssu6h+glSH10c+QaxjqIPHxIEcUP9Qqh5aKkYKbN1ZtxinMLlk297OtvbPIvppfVagkaqTBbMLaGUYC/38D+Vlu+/jF3+U7ApEm5lxmOumlmHEMrcS+RxY+DVzfOg0Dz2cGiSrUZ7x67sFl/Aa2BkCPJHalHOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=usedsubc; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="usedsubc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58FE5A000A;
	Mon, 16 Mar 2026 13:20:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773663649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7OoTpeKBAanvT5jp/DYh3GsuqtRuL1q2NsS/JCtIhCY=;
	b=usedsubcUCQuuwvGLVBi+FwwJyhOwINxZm765SDc0/5qUs1YeSmG6qSbCCNH+xh2o52TJ6
	PZPHGeSKq0DITqQ1i5PVx3RxxIIgjBgx3/+kZ0yte0JTwjydozNz8Xg9V4tGMn8RZtcnWh
	93NXBC/omo+ooag9LstgZ+FqR3AVBHJTyBBoafyFaDbsrZJrD9GNaAFrQ1NjWWzoGenrqO
	MEp8+lrsdmL6ZMvCK+7fQOJkWNIYfAGHa3dmzJJp125MPgMCPnHedS3OSKvfKfCLHpYG/r
	3JRa4DlHWOxO7WcdWdmJ0LkAP8bw5JtYoZJtvOQQCh4pdblsSjqPVrYaIfGi2A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:20:49 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 2/8] net: macb: rename rx_skbuff into rx_buff
In-Reply-To: <20260313201433.2346119-3-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
 <20260313201433.2346119-3-pvalerio@redhat.com>
Message-ID: <4cb88a84234ce4af23dcc79faee126d2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 13.3.2026 21:14, Paolo Valerio wrote:
> This is a preparation commit as the field in later patches will no
> longer accomomdate skbuffs, but more generic frames.

nit: "accomomdate" should be "accommodate".

> 
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  2 +-
>  drivers/net/ethernet/cadence/macb_main.c | 24 ++++++++++++------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index 0acc188fe547..d84ec528c12f 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1277,7 +1277,7 @@ struct macb_queue {
>  	unsigned int		rx_tail;
>  	unsigned int		rx_prepared_head;
>  	struct macb_dma_desc	*rx_ring;
> -	struct sk_buff		**rx_skbuff;
> +	void			**rx_buff;
>  	void			*rx_buffers;
>  	struct napi_struct	napi_rx;
>  	struct queue_stats stats;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 2c36d3844bf5..2ed00e200933 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1492,7 +1492,7 @@ static int gem_rx_refill(struct macb_queue 
> *queue)
> 
>  		desc = macb_rx_desc(queue, entry);
> 
> -		if (!queue->rx_skbuff[entry]) {
> +		if (!queue->rx_buff[entry]) {
>  			/* allocate sk_buff for this free entry in ring */
>  			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
>  			if (unlikely(!skb)) {
> @@ -1511,7 +1511,7 @@ static int gem_rx_refill(struct macb_queue 
> *queue)
>  				break;
>  			}
> 
> -			queue->rx_skbuff[entry] = skb;
> +			queue->rx_buff[entry] = skb;
> 
>  			if (entry == bp->rx_ring_size - 1)
>  				paddr |= MACB_BIT(RX_WRAP);
> @@ -1614,7 +1614,7 @@ static int gem_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
> -		skb = queue->rx_skbuff[entry];
> +		skb = queue->rx_buff[entry];
>  		if (unlikely(!skb)) {
>  			netdev_err(bp->dev,
>  				   "inconsistent Rx descriptor chain\n");
> @@ -1623,7 +1623,7 @@ static int gem_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  			break;
>  		}
>  		/* now everything is ready for receiving packet */
> -		queue->rx_skbuff[entry] = NULL;
> +		queue->rx_buff[entry] = NULL;
>  		len = ctrl & bp->rx_frm_len_mask;
> 
>  		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
> @@ -2623,11 +2623,11 @@ static void gem_free_rx_buffers(struct macb 
> *bp)
>  	int i;
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		if (!queue->rx_skbuff)
> +		if (!queue->rx_buff)
>  			continue;
> 
>  		for (i = 0; i < bp->rx_ring_size; i++) {
> -			skb = queue->rx_skbuff[i];
> +			skb = queue->rx_buff[i];
> 
>  			if (!skb)
>  				continue;
> @@ -2641,8 +2641,8 @@ static void gem_free_rx_buffers(struct macb *bp)
>  			skb = NULL;
>  		}
> 
> -		kfree(queue->rx_skbuff);
> -		queue->rx_skbuff = NULL;
> +		kfree(queue->rx_buff);
> +		queue->rx_buff = NULL;
>  	}
>  }
> 
> @@ -2705,13 +2705,13 @@ static int gem_alloc_rx_buffers(struct macb 
> *bp)
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		size = bp->rx_ring_size * sizeof(struct sk_buff *);
> -		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
> -		if (!queue->rx_skbuff)
> +		queue->rx_buff = kzalloc(size, GFP_KERNEL);
> +		if (!queue->rx_buff)
>  			return -ENOMEM;
>  		else
>  			netdev_dbg(bp->dev,
> -				   "Allocated %d RX struct sk_buff entries at %p\n",
> -				   bp->rx_ring_size, queue->rx_skbuff);
> +				   "Allocated %d RX buff entries at %p\n",
> +				   bp->rx_ring_size, queue->rx_buff);
>  	}
>  	return 0;
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
