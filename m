Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1B374A12
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204884; cv=none; b=tKxYGT96UMpAcYUXjrwdznTJEQ1T9kW+zQnViCK+z8aw5qb5qY8CU7SNmo54U+0hCrPGeEq9mHQgHjnyGZeXKQ2OmXu2FH/dHZTOb+5SD13kAHBsjn1xx+FOBaKsH6o5BduL6OEUnU7qYLTFQ7fbdmgoWq6PcggLwSSkudnjLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204884; c=relaxed/simple;
	bh=+3x3MuAjLQxbVet68wGRQTDjyvgbSZNWfbYNTDjFZJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNvLa7x/JJnzS422UUN3sz3FomJ1curierAaJFsSoWqAt2VP5bt6CqeAWvmNXAt2o2RnSlOo/XmO/f4ZpHd+ePXaKI/874oLEzrSwEGmp3Hz3TkRhrjBTaE2cGDsO76b7tgVGFZxanch0x/KcXIxHV+mu97oKwV5a64cgcCyJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwRMiouU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwRMiouU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BDB1F000FF;
	Sat, 12 Sep 2026 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789204882;
	bh=f5oGaz5ho5MvRQlGQjolm/SelIg1RG5u1nzrVA1obXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JwRMiouUrOpBtnEjsp1kadLzhNuLUVSBBkZ/MitFGlsY+qLqPbzXs4h6Ez7W9P3ic
	 zRLphPly+9JyoFoOeYn7SSt0YW1xiPxkYqcm6zJNukhE+0ngEr4NuImSPvVAxcSuTZ
	 tGVejo0Fw5rN62GI85SEo4kQt5AgmDngaN1N+8Y6T2pATPkpGh3aLiyKJR1sLSxylj
	 bb4onmAsGPtzL5gtswbUVqWgTmxJ+WDpPoFy58QaooLE91JHIHXRH7W/g4YDxlnpI1
	 eGkqauiltu54muhtdL7QzI+KFkj/utXZTZPJGeROI32OFr5Wj4ZxImmu3N3qL/1ldi
	 BL0q7f0U4hp2Q==
Date: Sat, 12 Sep 2026 11:21:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	madhur.agrawal@airoha.com, horms@kernel.org
Subject: Re: [PATCH net-next v7] net: airoha: add LRO offload support
Message-ID: <aqUZkDuNobNC-Zdo@lore-desk>
References: <20260909-airoha-eth-lro-v7-1-e6317be79067@kernel.org>
 <178917159014.219967.5680210222972540082@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXAIBSm+x1tmWQlr"
Content-Disposition: inline
In-Reply-To: <178917159014.219967.5680210222972540082@kernel.org>

--OXAIBSm+x1tmWQlr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>=20
> - [Medium] In airoha_qdma_init_rx_queue() the page_pool order, buffer
>   size and the hardware scatter-gather setting for RX rings 24-31 are=E2=
=80=A6
> - [Medium] The per-QDMA CDM LRO engine is armed from paths that do not
>   require the netdev to be running, and there is no unconditional disarm=
=E2=80=A6
>=20
> --
>=20
> net: airoha: add LRO offload support
>=20
> This adds LRO offload to airoha_eth using the eight hardware LRO queues
> mapped to RX rings 24-31, bumps the page_pool order for those rings and
> disables hardware scatter-gather on them, and sets GSO metadata plus
> CHECKSUM_PARTIAL on aggregated skbs. NETIF_F_LRO is exposed in
> hw_features and re-evaluated when the QDMA user count changes.
>=20
> A couple of questions below about the unconditional buffer sizing and
> about the lifetime of the CDM LRO enable bits.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 64619e9a704dd..21ac80bdd084a 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -800,12 +1027,10 @@ static int airoha_qdma_rx_napi_poll(struct napi_=
struct *napi, int budget)
> >  static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
> >  				     struct airoha_qdma *qdma, int ndesc)
> >  {
> > -	const struct page_pool_params pp_params =3D {
> > -		.order =3D 0,
> > +	struct page_pool_params pp_params =3D {
> >  		.pool_size =3D 256,
> >  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> >  		.dma_dir =3D DMA_FROM_DEVICE,
> > -		.max_len =3D PAGE_SIZE,
> >  		.nid =3D NUMA_NO_NODE,
> >  		.dev =3D qdma->eth->dev,
> >  		.napi =3D &q->napi,
> > @@ -813,9 +1038,10 @@ static int airoha_qdma_init_rx_queue(struct airoh=
a_queue *q,
> >  	struct airoha_eth *eth =3D qdma->eth;
> >  	int qid =3D q - &qdma->q_rx[0], thr;
> >  	dma_addr_t dma_addr;
> > +	bool lro_q;
> > =20
> > -	q->buf_size =3D PAGE_SIZE / 2;
> >  	q->qdma =3D qdma;
> > +	lro_q =3D airoha_qdma_is_lro_queue(q);
> > =20
> >  	q->entry =3D devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
> >  				GFP_KERNEL);
> > @@ -827,6 +1053,9 @@ static int airoha_qdma_init_rx_queue(struct airoha=
_queue *q,
> >  	if (!q->desc)
> >  		return -ENOMEM;
> > =20
> > +	pp_params.order =3D lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
> > +	pp_params.max_len =3D PAGE_SIZE << pp_params.order;
> > +
> >  	q->page_pool =3D page_pool_create(&pp_params);
> >  	if (IS_ERR(q->page_pool)) {
> >  		int err =3D PTR_ERR(q->page_pool);
> > @@ -835,6 +1064,7 @@ static int airoha_qdma_init_rx_queue(struct airoha=
_queue *q,
> >  		return err;
> >  	}
> > =20
> > +	q->buf_size =3D lro_q ? pp_params.max_len : pp_params.max_len / 2;
> >  	q->ndesc =3D ndesc;
> >  	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
> > =20
> > @@ -848,7 +1078,12 @@ static int airoha_qdma_init_rx_queue(struct airoh=
a_queue *q,
> >  			FIELD_PREP(RX_RING_THR_MASK, thr));
> >  	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
> >  			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
> > -	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
> > +	if (lro_q)
> > +		airoha_qdma_clear(qdma, REG_RX_SCATTER_CFG(qid),
> > +				  RX_RING_SG_EN_MASK);
> > +	else
> > +		airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid),
> > +				RX_RING_SG_EN_MASK);
>=20
> [Severity: Medium]
> Is the order-2 sizing meant to be paid even when LRO is never enabled?
>=20
> airoha_qdma_is_lro_queue() is a pure function of the ring index
> (AIROHA_RXQ_LRO_EN_MASK & BIT(qid)), so it does not depend on
> NETIF_F_LRO at all:
>=20
> 	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
>=20
> airoha_qdma_init_rx() initializes every ring in RX_DONE_INT_MASK, which
> expands to 0xffffffff, so rings 24-31 of both eth->qdma[0] and
> eth->qdma[1] are always live. For those rings this hunk gives
> pp_params.order =3D get_order(SZ_16K) (2 with 4 KiB pages),
> pp_params.max_len =3D 16384 and q->buf_size =3D 16384.
>=20
> Since q->buf_size equals max_len, page_pool_alloc_frag_netmem() no
> longer sub-allocates (it only splits when the request is smaller than
> max_size), so airoha_qdma_fill_rx_queue() consumes one whole order-2
> compound page per descriptor:
>=20
> 	page =3D page_pool_dev_alloc_frag(q->page_pool, &offset,
> 					q->buf_size);
>=20
> That moves the per-ring in-flight RX memory from roughly 31 x 2 KiB to
> 31 x 16 KiB, i.e. about +4 MiB per QDMA block.
>=20
> Meanwhile NETIF_F_LRO is only added to netdev->hw_features:
>=20
> 	netdev->hw_features =3D AIROHA_HW_FEATURES | NETIF_F_LRO;
> 	netdev->features |=3D AIROHA_HW_FEATURES;
>=20
> so LRO is off at probe, and airoha_dev_fix_features() strips
> NETIF_F_LRO whenever qdma->users > 1. On a board with two GDM devices
> sharing one QDMA the feature can never be turned on, yet those rings
> still hold 16 KiB buffers with RX_RING_SG_EN_MASK cleared, and the
> pools are never re-created when LRO is toggled.
>=20
> With scatter-gather cleared on those rings there is also no fragment
> fallback, and refill runs from NAPI with GFP_ATOMIC | __GFP_NOWARN.
> Could order-2 atomic allocation failures under fragmentation simply
> starve rings 24-31 here?
>=20
> Would it be possible to key the order, buf_size and SG setting on
> whether LRO is actually enabled, rather than on the ring index?

This capability will be added in a subsequent patch.

>=20
> [ ... ]
>=20
> > @@ -1954,6 +2235,10 @@ static int airoha_dev_stop(struct net_device *ne=
tdev)
> >  		airoha_set_gdm_port_fwd_cfg(dev->eth,
> >  					    REG_GDM_FWD_CFG(port->id),
> >  					    FE_PSE_PORT_DROP);
> > +
> > +	if (netdev->features & NETIF_F_LRO)
> > +		airoha_dev_lro_disable(dev);
> > +
> >  	return 0;
> >  }
>=20
> [ ... ]
>=20
> > @@ -2136,8 +2424,14 @@ static void airoha_dev_set_qdma(struct airoha_gd=
m_dev *dev)
> >  			airoha_qdma_rr(qdma, REG_CNTR_VAL((i << 1) + 1));
> >  	}
> > =20
> > -	if (cur_qdma)
> > +	if (cur_qdma) {
> > +		cur_qdma->users--;
> >  		netif_tx_wake_all_queues(netdev);
> > +	}
> > +
> > +	airoha_update_netdev_features(dev);
> > +	if (netdev->features & NETIF_F_LRO)
> > +		airoha_dev_lro_enable(dev);
> >  }
>=20
> [ ... ]
>=20
> > +static int airoha_dev_set_features(struct net_device *netdev,
> > +				   netdev_features_t features)
> > +{
> > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +
> > +	if (features & NETIF_F_LRO)
> > +		airoha_dev_lro_enable(dev);
> > +	else
> > +		airoha_dev_lro_disable(dev);
> > +
> > +	return 0;
> > +}
>=20
> [Severity: Medium]
> Should the LRO arming in airoha_dev_set_features() and at the tail of
> airoha_dev_set_qdma() be gated on netif_running()?
>=20
> __netdev_update_features() dispatches ndo_set_features regardless of
> the running state, so "ethtool -K ethX lro on" on an administratively
> down interface reaches airoha_dev_lro_enable(), which programs
> REG_CDM_LRO_LIMIT, REG_CDM_LRO_AGE_TIME, the REG_CDM_LRO_RXQ mapping
> and REG_CDM_LRO_EN for that QDMA block.
>=20
> The only automatic disarm is in airoha_dev_stop():
>=20
> 	if (netdev->features & NETIF_F_LRO)
> 		airoha_dev_lro_disable(dev);
>=20
> which is only reached for a device that was successfully opened, so
> nothing clears REG_CDM_LRO_EN for hardware armed while the device was
> down.
>=20
> The same applies to airoha_dev_set_qdma(): airoha_update_netdev_features()
> runs first, so a device whose wanted NETIF_F_LRO had been masked by
> qdma->users > 1 regains the bit and then gets the destination QDMA
> armed even while it is down.

I do not think this is harmful since you will not be able to set the device=
 up if
it does not follow LRO/QDMA restrictions, single QDMA user for LRO. In orde=
r to
put the device up, if the QDMA is shared, the user will need to disable LRO.

>=20
> Neither airoha_qdma_cleanup() nor airoha_hw_cleanup() clears the LRO
> enable bits or the queue mapping before RX DMA is stopped and the rings
> and page pools are destroyed, so the CDM aggregation engine is left
> enabled with a stale queue mapping after teardown. Would an
> unconditional airoha_fe_lro_disable() on the QDMA cleanup path be
> appropriate?

airoha_qdma_cleanup() runs removing the airoha_eth module. When the driver =
is
loaded again, airoha_hw_init() will reset the QDMA blocks, disabling the LRO
configuration.

Regards,
Lorenzo

>=20
> This is also inconsistent with the surrounding convention in the same
> file: airoha_enable_qos_for_gdm34() and airoha_disable_qos_for_gdm34()
> both gate their REG_GDM_FWD_CFG writes on netif_running(netdev).
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index 527e3833e36b1..286f73e2e1e09 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -46,6 +46,18 @@
> >  	 (_n) =3D=3D 15 ? 128 :		\
> >  	 (_n) =3D=3D  0 ? 1024 : 32)
> > =20
> > +#define AIROHA_LRO_PAGE_ORDER		get_order(SZ_16K)
> > +#define AIROHA_MAX_NUM_LRO_QUEUES	8
> > +#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)
>=20
> [ ... ]
>=20
> > +static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
> > +{
> > +	struct airoha_qdma *qdma =3D q->qdma;
> > +	int qid =3D q - &qdma->q_rx[0];
> > +
> > +	/* EN7581 SoC supports at most 8 LRO rx queues */
> > +	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
> > +		     AIROHA_MAX_NUM_LRO_QUEUES);
> > +
> > +	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
> > +}
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909-airoha-eth-lro-v7-1-e6317be79067%40kernel.org

--OXAIBSm+x1tmWQlr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqUZkAAKCRA6cBh0uS2t
rJcUAQCKwe8n7K8MzOTGFqJUvj5djBf6zmg26vlxFqos6XK7GQEAsbi9FsR1e/bR
RCxaZ/Y9LyNo/b3fjRf2QTYBk/rM5g0=
=ILZ9
-----END PGP SIGNATURE-----

--OXAIBSm+x1tmWQlr--
