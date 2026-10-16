Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7ED38DC49
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161899; cv=none; b=oWcXxg5R/f7MKuedDEO1gmqd+KPRPlFWdKqNhQs6e4v0XC68Ax5BdzhKkPx1i2XcGv+7ej47HfXqghPCOzQn4aIAUi79pXUueV6KUaIw8MXMEVq5ifEMEH7uJte0FRjGOS+jHycAY8uNYkM9CYQOnWS3uTkqLNc+pVlsMcHRN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161899; c=relaxed/simple;
	bh=Ds0Uw0OiTjtR17u9nCfSLFbFVc0eIQMHdq4FyNrTqyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJkFVunG5Cfh/04L1Ikfr5gXuXV7zAqOCAOJFBFhgQpZUgSRC12HAwBA+K9YOD9Yxb8e8L92bbjd/qHATlGyJeTp8s5KDalMKwO2lnqMQqw3njp4byPfJjwH1ehOuYzKa/U2jBOrfC8yhnpQmHWfQVOjkCWdXqN2a8L0l/pP0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FlcfR7Q9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FlcfR7Q9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D06331A1255;
	Fri, 16 Oct 2026 14:44:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 961C56075D;
	Fri, 16 Oct 2026 14:44:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD5F610328BE6;
	Fri, 16 Oct 2026 16:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792161887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+0AXPlFze0BOG/sBmlCYKyCygdQcae/LGncpPghnnwQ=;
	b=FlcfR7Q91vBQss0fvH4P2vn74rnf/dSWcAk19bc1YL+ZzYIqTNd+sTzpsadrwo1YMBZwc1
	KFo7GSvZlkhHgiM6SmUy5UtIf/UTf3ibwwID6IXU8/40PopfES4v+kZvSeoOaNTH+Qftdg
	zWKsoi8qvy/ZOa2NLg7FyIJwNfxCUxqYTvP6Tutft6rskOT+LYTfDBKBt9lgbvSHqjz0QM
	1qjCc2sRqtRFL+YFOONbQVLaIhaxvoyirkmOFHisS5QIKEvwshEM9WQFY1VAQhiWvTrFob
	Tmsw0D6TnzrikjJGbdaOn3cbI/zDNM+puNaPFzjjsUNV9DHSdC6SuMl+l+035g==
Message-ID: <12b18559-3e8e-4a09-94a1-0d303ad7c2c6@bootlin.com>
Date: Fri, 16 Oct 2026 16:44:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
To: Ding Hui <dinghui1111@163.com>, netdev-bot+sashiko@kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
References: <20261012142458.2845385-1-dinghui1111@163.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261012142458.2845385-1-dinghui1111@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/12/26 16:24, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> 
> __alloc_dma_rx_desc_resources() and __alloc_dma_tx_desc_resources()
> allocate resources in multiple steps but return early on failure
> without cleaning up what they have already allocated. The outer
> error paths then call the free helpers on partially-initialized
> queues, which dereference pointers that were never allocated:
> 
>   - dma_free_rx_skbufs() and dma_free_rx_xskbufs() dereference
>     rx_q->buf_pool[i] via stmmac_free_rx_buffer(), but buf_pool
>     may be NULL if its kzalloc_objs() failed.
> 
>   - dma_free_tx_skbufs() dereferences tx_q->tx_skbuff_dma[i] via
>     stmmac_free_tx_buffer(), but tx_skbuff_dma may be NULL if its
>     kzalloc_objs() failed.
> 
>   - stmmac_free_tx_buffer() dereferences tx_q->xdpf[i] and
>     tx_q->tx_skbuff[i] (aliased through a union), but tx_skbuff
>     may be NULL if its allocation failed while tx_skbuff_dma
>     succeeded.
> 
> Fix this by making each allocation function responsible for undoing
> its own allocations on error, following the standard kernel error
> handling pattern of cleaning up in reverse order. Also add NULL
> checks in the free helpers as a defensive measure, since they may
> be called on partially-initialized queues.
> Additionally, make __free_dma_rx_desc_resources() and
> __free_dma_tx_desc_resources() clear the pointers they free, so that
> the NULL guards in the free helpers hold reliably when the long-lived
> priv->dma_conf is reused across XDP open/release cycles.
> Free the RX resources in alloc_dma_desc_resources() when the TX
> allocation fails, as the callers only free dma_conf itself on
> that path.
> After __stmmac_open() copies a temporary dma_conf into priv->dma_conf,
> release the descriptor resources through priv->dma_conf on an open
> failure. This keeps the long-lived configuration consistent with the
> resource cleanup while callers only free the temporary container.
> Finally, hold RTNL while descriptors_status inspects the descriptor
> rings. This serializes the debugfs reader with control-plane resource
> teardown paths and allows it to safely report queues whose descriptor
> rings are not allocated. Skip queues whose descriptor rings are not
> allocated in stmmac_rings_status_show() to avoid dereferencing a NULL
> pointer.
> 
> Signed-off-by: Ding Hui <dinghui@lixiang.com>

In V1 Andrew requested that this targets net-next yet this series kept
targetting the "net" tree since then.

I think this is an omission on your side as you replied to the bots that
you removed the Fixes: tag on purpose :) You need to have "net-next" in
the patch topic : [PATCH net-next v5]

This is starting to look good, but as you need to respin, is it possible
that you split that patch down into simpler patches ? There are multiple
classes of problems being addressed here :
 - Error paths being reworked
 - Null checks being added
 - Some pointers being Nulled

It would make it easier to digest during review.

Thanks,

Maxime

> 
> ---
> Changes in v5:
>   - Release copied descriptor resources through priv->dma_conf when
>     __stmmac_open() fails, avoiding stale pointers in the long-lived
>     configuration.
>   - Hold RTNL while descriptors_status reads descriptor rings.
>   - Correct the commit message to refer to descriptors_status as a
>     debugfs entry rather than a sysfs entry.
>   - Link to v4:
>     https://lore.kernel.org/netdev/20261001035045.3305816-1-dinghui1111@163.com/
> Changes in v4:
>   - Free the RX resources in alloc_dma_desc_resources() when the TX
>     allocation fails.
>   - Skip queues whose descriptor rings are not allocated in
>     stmmac_rings_status_show() and print a hint instead.
>   - Link to v3:
>     https://lore.kernel.org/netdev/20260919121436.1642724-1-dinghui1111@163.com/
> Changes in v3:
>   - Use addr directly in __alloc_dma_rx_desc_resources() error path
>     instead of the if/else block on rx_q->dma_erx/dma_rx.
>   - Clear the freed pointers in __free_dma_rx_desc_resources() and
>     __free_dma_tx_desc_resources().
>   - Link to v2:
>     https://lore.kernel.org/netdev/20260905154654.1725313-1-dinghui1111@163.com/
> Changes in v2:
>   - Instead of only adding NULL checks in the free helpers, also fix
>     __alloc_dma_rx_desc_resources() and __alloc_dma_tx_desc_resources()
>     to clean up their own allocations on error, as suggested by Andrew.
>   - Update commit message.
>   - Link to v1:
>     https://lore.kernel.org/netdev/20260830040610.1156008-1-dinghui1111@163.com/
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 112 +++++++++++++++---
>  1 file changed, 96 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f2fc89176654..852a8b103c45 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1728,7 +1728,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
>  					 DMA_TO_DEVICE);
>  	}
>  
> -	if (tx_q->xdpf[i] &&
> +	if (tx_q->xdpf && tx_q->xdpf[i] &&
>  	    (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX ||
>  	     tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_NDO)) {
>  		xdp_return_frame(tx_q->xdpf[i]);
> @@ -1738,7 +1738,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
>  	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX)
>  		tx_q->xsk_frames_done++;
>  
> -	if (tx_q->tx_skbuff[i] &&
> +	if (tx_q->tx_skbuff && tx_q->tx_skbuff[i] &&
>  	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
>  		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
>  		tx_q->tx_skbuff[i] = NULL;
> @@ -1761,6 +1761,10 @@ static void dma_free_rx_skbufs(struct stmmac_priv *priv,
>  	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
>  	int i;
>  
> +	/* buf_pool may not be allocated if alloc failed early */
> +	if (!rx_q->buf_pool)
> +		return;
> +
>  	for (i = 0; i < dma_conf->dma_rx_size; i++)
>  		stmmac_free_rx_buffer(priv, rx_q, i);
>  }
> @@ -1802,6 +1806,10 @@ static void dma_free_rx_xskbufs(struct stmmac_priv *priv,
>  	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
>  	int i;
>  
> +	/* buf_pool may not be allocated if alloc failed early */
> +	if (!rx_q->buf_pool)
> +		return;
> +
>  	for (i = 0; i < dma_conf->dma_rx_size; i++) {
>  		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
>  
> @@ -2097,6 +2105,10 @@ static void dma_free_tx_skbufs(struct stmmac_priv *priv,
>  	struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[queue];
>  	int i;
>  
> +	/* tx_skbuff_dma may not be allocated if alloc failed early */
> +	if (!tx_q->tx_skbuff_dma)
> +		return;
> +
>  	tx_q->xsk_frames_done = 0;
>  
>  	for (i = 0; i < dma_conf->dma_tx_size; i++)
> @@ -2154,13 +2166,20 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
> +	rx_q->dma_rx_phy = 0;
>  
>  	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
>  
>  	kfree(rx_q->buf_pool);
> -	if (rx_q->page_pool)
> +	rx_q->buf_pool = NULL;
> +
> +	if (rx_q->page_pool) {
>  		page_pool_destroy(rx_q->page_pool);
> +		rx_q->page_pool = NULL;
> +	}
>  }
>  
>  static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
> @@ -2202,9 +2221,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
> +	tx_q->dma_etx = NULL;
> +	tx_q->dma_entx = NULL;
> +	tx_q->dma_tx = NULL;
> +	tx_q->dma_tx_phy = 0;
>  
>  	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma = NULL;
> +
>  	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff = NULL;
>  }
>  
>  static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
> @@ -2272,15 +2298,19 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	}
>  
>  	rx_q->buf_pool = kzalloc_objs(*rx_q->buf_pool, dma_conf->dma_rx_size);
> -	if (!rx_q->buf_pool)
> -		return -ENOMEM;
> +	if (!rx_q->buf_pool) {
> +		ret = -ENOMEM;
> +		goto err_destroy_pool;
> +	}
>  
>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>  
>  	addr = dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy,
>  				  GFP_KERNEL);
> -	if (!addr)
> -		return -ENOMEM;
> +	if (!addr) {
> +		ret = -ENOMEM;
> +		goto err_free_buf_pool;
> +	}
>  
>  	if (priv->extend_desc)
>  		rx_q->dma_erx = addr;
> @@ -2296,10 +2326,22 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
>  	if (ret) {
>  		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
> -		return -EINVAL;
> +		goto err_free_dma;
>  	}
>  
>  	return 0;
> +
> +err_free_dma:
> +	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
> +err_free_buf_pool:
> +	kfree(rx_q->buf_pool);
> +	rx_q->buf_pool = NULL;
> +err_destroy_pool:
> +	page_pool_destroy(rx_q->page_pool);
> +	rx_q->page_pool = NULL;
> +	return ret;
>  }
>  
>  static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
> @@ -2352,14 +2394,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
>  
>  	tx_q->tx_skbuff = kzalloc_objs(struct sk_buff *, dma_conf->dma_tx_size);
>  	if (!tx_q->tx_skbuff)
> -		return -ENOMEM;
> +		goto err_free_skbuff_dma;
>  
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
>  	addr = dma_alloc_coherent(priv->device, size,
>  				  &tx_q->dma_tx_phy, GFP_KERNEL);
>  	if (!addr)
> -		return -ENOMEM;
> +		goto err_free_skbuff;
>  
>  	if (priv->extend_desc)
>  		tx_q->dma_etx = addr;
> @@ -2369,6 +2411,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
>  		tx_q->dma_tx = addr;
>  
>  	return 0;
> +
> +err_free_skbuff:
> +	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff = NULL;
> +err_free_skbuff_dma:
> +	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma = NULL;
> +	return -ENOMEM;
>  }
>  
>  static int alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
> @@ -2411,6 +2461,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
>  		return ret;
>  
>  	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
> +	if (ret)
> +		free_dma_rx_desc_resources(priv, dma_conf);
>  
>  	return ret;
>  }
> @@ -4182,6 +4234,7 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	stmmac_release_ptp(priv);
>  init_error:
> +	free_dma_desc_resources(priv, &priv->dma_conf);
>  	return ret;
>  }
>  
> @@ -4214,8 +4267,13 @@ static int stmmac_open(struct net_device *dev)
>  	}
>  
>  	ret = __stmmac_open(dev, dma_conf);
> -	if (ret)
> -		goto err_serdes;
> +	if (ret) {
> +		stmmac_legacy_serdes_power_down(priv);
> +		phylink_disconnect_phy(priv->phylink);
> +		pm_runtime_put(priv->device);
> +		kfree(dma_conf);
> +		return ret;
> +	}
>  
>  	kfree(dma_conf);
>  
> @@ -4224,8 +4282,6 @@ static int stmmac_open(struct net_device *dev)
>  
>  	return ret;
>  
> -err_serdes:
> -	stmmac_legacy_serdes_power_down(priv);
>  err_disconnect_phy:
>  	phylink_disconnect_phy(priv->phylink);
>  err_runtime_pm:
> @@ -6130,7 +6186,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  
>  		ret = __stmmac_open(dev, dma_conf);
>  		if (ret) {
> -			free_dma_desc_resources(priv, dma_conf);
>  			kfree(dma_conf);
>  			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
>  			return ret;
> @@ -6501,8 +6556,10 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
>  	u8 tx_count = priv->plat->tx_queues_to_use;
>  	u8 queue;
>  
> +	rtnl_lock();
> +
>  	if ((dev->flags & IFF_UP) == 0)
> -		return 0;
> +		goto out;
>  
>  	for (queue = 0; queue < rx_count; queue++) {
>  		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
> @@ -6510,10 +6567,20 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
>  		seq_printf(seq, "RX Queue %d:\n", queue);
>  
>  		if (priv->extend_desc) {
> +			if (!rx_q->dma_erx) {
> +				seq_puts(seq, "Extended descriptor ring not allocated\n");
> +				continue;
> +			}
> +
>  			seq_printf(seq, "Extended descriptor ring:\n");
>  			sysfs_display_ring((void *)rx_q->dma_erx,
>  					   priv->dma_conf.dma_rx_size, 1, seq, rx_q->dma_rx_phy);
>  		} else {
> +			if (!rx_q->dma_rx) {
> +				seq_puts(seq, "Descriptor ring not allocated\n");
> +				continue;
> +			}
> +
>  			seq_printf(seq, "Descriptor ring:\n");
>  			sysfs_display_ring((void *)rx_q->dma_rx,
>  					   priv->dma_conf.dma_rx_size, 0, seq, rx_q->dma_rx_phy);
> @@ -6526,16 +6593,29 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
>  		seq_printf(seq, "TX Queue %d:\n", queue);
>  
>  		if (priv->extend_desc) {
> +			if (!tx_q->dma_etx) {
> +				seq_puts(seq, "Extended descriptor ring not allocated\n");
> +				continue;
> +			}
> +
>  			seq_printf(seq, "Extended descriptor ring:\n");
>  			sysfs_display_ring((void *)tx_q->dma_etx,
>  					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
>  		} else if (!(tx_q->tbs & STMMAC_TBS_AVAIL)) {
> +			if (!tx_q->dma_tx) {
> +				seq_puts(seq, "Descriptor ring not allocated\n");
> +				continue;
> +			}
> +
>  			seq_printf(seq, "Descriptor ring:\n");
>  			sysfs_display_ring((void *)tx_q->dma_tx,
>  					   priv->dma_conf.dma_tx_size, 0, seq, tx_q->dma_tx_phy);
>  		}
>  	}
>  
> +out:
> +	rtnl_unlock();
> +
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);

