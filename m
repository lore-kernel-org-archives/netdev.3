Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28543AC00
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171593; cv=none; b=DfpN2oYjJmn1xs4EfYsuFNrICXeDpnxZuW/zTe/fQeP24lKLWI5CWSxUbvxq6VdlMfb0q7p3umYA5BX4u4Za0sqzi6NmlFHP0E8TqDziGe1DGFWcYbV7Nroi6K3xtls9xyChpYH/q2T6BqXURCf6w65rkO2+shgTlnI0LJQ3NQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171593; c=relaxed/simple;
	bh=PzPzAYnFIyb1RpC3fFdHUBIUW34685ubm82agoPJHBM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzDlJOYnWf/PyYGLDtUQhGKF6IA0mS2C6nOUPQcqTdg93OVlQg3xyiUhYGxoEJb9suM6VoLvcbHSkOktGoBKLzWU/DBy4sFmAdZXAqC1MdoZBiSP1ErxHP4r8z3rzvdOujLhvZhQGyc22XsCbATnlfXYGhlPzKldiTQEipybRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTxGK2yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTxGK2yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332C1F00893;
	Sat, 12 Sep 2026 00:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171591;
	bh=lxOehLNxF4tlyLyLQCgqOYqfV3EqWhPuIVTXdkGG4gY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WTxGK2yjJPkp7v3hoam+kMczpPEuI9S9QSrtKLmok4sy4FrVvZBV2mD6ZqHg4B/+K
	 1LEk+v/nhNJJNyu4UcFW7Dqk9/dwe160Dz3dwWAGP19jgUu5MLaQGnmswbSr9Op151
	 3PP6zPkxKXYNffsaV30ywG08hzqanTlB7Z062AJfXZvj/UmblDa5jAyf5dOLnla/LA
	 f9aJy+Yx2IxM2kRzsfcu6OkRQHoWObPq8hvxy3YcXJYqV12RPB2lO6tswA/t8i75bn
	 xYEamReWEyFseWx2ceBYGOuyWwQx/+RG0/HxRthR6GtbojQ4Z5zQGLUr1nUro69ghk
	 BXRTHFSyear2Q==
Subject: Re: [PATCH net-next v7] net: airoha: add LRO offload support
From: netdev-bot+sashiko@kernel.org
To: lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, madhur.agrawal@airoha.com, horms@kernel.org
Date: Sat, 12 Sep 2026 00:06:30 +0000
Message-ID: <178917159014.219967.5680210222972540082@kernel.org>
In-Reply-To: <20260909-airoha-eth-lro-v7-1-e6317be79067@kernel.org>
References: <20260909-airoha-eth-lro-v7-1-e6317be79067@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] In airoha_qdma_init_rx_queue() the page_pool order, buffer
  size and the hardware scatter-gather setting for RX rings 24-31 are…
- [Medium] The per-QDMA CDM LRO engine is armed from paths that do not
  require the netdev to be running, and there is no unconditional disarm…

--

net: airoha: add LRO offload support

This adds LRO offload to airoha_eth using the eight hardware LRO queues
mapped to RX rings 24-31, bumps the page_pool order for those rings and
disables hardware scatter-gather on them, and sets GSO metadata plus
CHECKSUM_PARTIAL on aggregated skbs. NETIF_F_LRO is exposed in
hw_features and re-evaluated when the QDMA user count changes.

A couple of questions below about the unconditional buffer sizing and
about the lifetime of the CDM LRO enable bits.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 64619e9a704dd..21ac80bdd084a 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -800,12 +1027,10 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
>  static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
>  				     struct airoha_qdma *qdma, int ndesc)
>  {
> -	const struct page_pool_params pp_params = {
> -		.order = 0,
> +	struct page_pool_params pp_params = {
>  		.pool_size = 256,
>  		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  		.dma_dir = DMA_FROM_DEVICE,
> -		.max_len = PAGE_SIZE,
>  		.nid = NUMA_NO_NODE,
>  		.dev = qdma->eth->dev,
>  		.napi = &q->napi,
> @@ -813,9 +1038,10 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
>  	struct airoha_eth *eth = qdma->eth;
>  	int qid = q - &qdma->q_rx[0], thr;
>  	dma_addr_t dma_addr;
> +	bool lro_q;
>  
> -	q->buf_size = PAGE_SIZE / 2;
>  	q->qdma = qdma;
> +	lro_q = airoha_qdma_is_lro_queue(q);
>  
>  	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
>  				GFP_KERNEL);
> @@ -827,6 +1053,9 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
>  	if (!q->desc)
>  		return -ENOMEM;
>  
> +	pp_params.order = lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
> +	pp_params.max_len = PAGE_SIZE << pp_params.order;
> +
>  	q->page_pool = page_pool_create(&pp_params);
>  	if (IS_ERR(q->page_pool)) {
>  		int err = PTR_ERR(q->page_pool);
> @@ -835,6 +1064,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
>  		return err;
>  	}
>  
> +	q->buf_size = lro_q ? pp_params.max_len : pp_params.max_len / 2;
>  	q->ndesc = ndesc;
>  	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
>  
> @@ -848,7 +1078,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
>  			FIELD_PREP(RX_RING_THR_MASK, thr));
>  	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
>  			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
> -	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
> +	if (lro_q)
> +		airoha_qdma_clear(qdma, REG_RX_SCATTER_CFG(qid),
> +				  RX_RING_SG_EN_MASK);
> +	else
> +		airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid),
> +				RX_RING_SG_EN_MASK);

[Severity: Medium]
Is the order-2 sizing meant to be paid even when LRO is never enabled?

airoha_qdma_is_lro_queue() is a pure function of the ring index
(AIROHA_RXQ_LRO_EN_MASK & BIT(qid)), so it does not depend on
NETIF_F_LRO at all:

	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));

airoha_qdma_init_rx() initializes every ring in RX_DONE_INT_MASK, which
expands to 0xffffffff, so rings 24-31 of both eth->qdma[0] and
eth->qdma[1] are always live. For those rings this hunk gives
pp_params.order = get_order(SZ_16K) (2 with 4 KiB pages),
pp_params.max_len = 16384 and q->buf_size = 16384.

Since q->buf_size equals max_len, page_pool_alloc_frag_netmem() no
longer sub-allocates (it only splits when the request is smaller than
max_size), so airoha_qdma_fill_rx_queue() consumes one whole order-2
compound page per descriptor:

	page = page_pool_dev_alloc_frag(q->page_pool, &offset,
					q->buf_size);

That moves the per-ring in-flight RX memory from roughly 31 x 2 KiB to
31 x 16 KiB, i.e. about +4 MiB per QDMA block.

Meanwhile NETIF_F_LRO is only added to netdev->hw_features:

	netdev->hw_features = AIROHA_HW_FEATURES | NETIF_F_LRO;
	netdev->features |= AIROHA_HW_FEATURES;

so LRO is off at probe, and airoha_dev_fix_features() strips
NETIF_F_LRO whenever qdma->users > 1. On a board with two GDM devices
sharing one QDMA the feature can never be turned on, yet those rings
still hold 16 KiB buffers with RX_RING_SG_EN_MASK cleared, and the
pools are never re-created when LRO is toggled.

With scatter-gather cleared on those rings there is also no fragment
fallback, and refill runs from NAPI with GFP_ATOMIC | __GFP_NOWARN.
Could order-2 atomic allocation failures under fragmentation simply
starve rings 24-31 here?

Would it be possible to key the order, buf_size and SG setting on
whether LRO is actually enabled, rather than on the ring index?

[ ... ]

> @@ -1954,6 +2235,10 @@ static int airoha_dev_stop(struct net_device *netdev)
>  		airoha_set_gdm_port_fwd_cfg(dev->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> +
> +	if (netdev->features & NETIF_F_LRO)
> +		airoha_dev_lro_disable(dev);
> +
>  	return 0;
>  }

[ ... ]

> @@ -2136,8 +2424,14 @@ static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
>  			airoha_qdma_rr(qdma, REG_CNTR_VAL((i << 1) + 1));
>  	}
>  
> -	if (cur_qdma)
> +	if (cur_qdma) {
> +		cur_qdma->users--;
>  		netif_tx_wake_all_queues(netdev);
> +	}
> +
> +	airoha_update_netdev_features(dev);
> +	if (netdev->features & NETIF_F_LRO)
> +		airoha_dev_lro_enable(dev);
>  }

[ ... ]

> +static int airoha_dev_set_features(struct net_device *netdev,
> +				   netdev_features_t features)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +
> +	if (features & NETIF_F_LRO)
> +		airoha_dev_lro_enable(dev);
> +	else
> +		airoha_dev_lro_disable(dev);
> +
> +	return 0;
> +}

[Severity: Medium]
Should the LRO arming in airoha_dev_set_features() and at the tail of
airoha_dev_set_qdma() be gated on netif_running()?

__netdev_update_features() dispatches ndo_set_features regardless of
the running state, so "ethtool -K ethX lro on" on an administratively
down interface reaches airoha_dev_lro_enable(), which programs
REG_CDM_LRO_LIMIT, REG_CDM_LRO_AGE_TIME, the REG_CDM_LRO_RXQ mapping
and REG_CDM_LRO_EN for that QDMA block.

The only automatic disarm is in airoha_dev_stop():

	if (netdev->features & NETIF_F_LRO)
		airoha_dev_lro_disable(dev);

which is only reached for a device that was successfully opened, so
nothing clears REG_CDM_LRO_EN for hardware armed while the device was
down.

The same applies to airoha_dev_set_qdma(): airoha_update_netdev_features()
runs first, so a device whose wanted NETIF_F_LRO had been masked by
qdma->users > 1 regains the bit and then gets the destination QDMA
armed even while it is down.

Neither airoha_qdma_cleanup() nor airoha_hw_cleanup() clears the LRO
enable bits or the queue mapping before RX DMA is stopped and the rings
and page pools are destroyed, so the CDM aggregation engine is left
enabled with a stale queue mapping after teardown. Would an
unconditional airoha_fe_lro_disable() on the QDMA cleanup path be
appropriate?

This is also inconsistent with the surrounding convention in the same
file: airoha_enable_qos_for_gdm34() and airoha_disable_qos_for_gdm34()
both gate their REG_GDM_FWD_CFG writes on netif_running(netdev).

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index 527e3833e36b1..286f73e2e1e09 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -46,6 +46,18 @@
>  	 (_n) == 15 ? 128 :		\
>  	 (_n) ==  0 ? 1024 : 32)
>  
> +#define AIROHA_LRO_PAGE_ORDER		get_order(SZ_16K)
> +#define AIROHA_MAX_NUM_LRO_QUEUES	8
> +#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)

[ ... ]

> +static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
> +{
> +	struct airoha_qdma *qdma = q->qdma;
> +	int qid = q - &qdma->q_rx[0];
> +
> +	/* EN7581 SoC supports at most 8 LRO rx queues */
> +	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
> +		     AIROHA_MAX_NUM_LRO_QUEUES);
> +
> +	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-airoha-eth-lro-v7-1-e6317be79067%40kernel.org
