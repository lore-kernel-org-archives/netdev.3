Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DC3C872B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416002; cv=none; b=Tw2/ZEIRbl21/P+9qb5s8UlxmUytPpMU6fN72c8Q6XvWzE6FRvpM+iAXxkz6adCE2tg2t7pr7/xmebzZjq4/uU/Jgt6CecnajG5ZafA+2OhN1hNkYIgYUUydI/DQQbXTXkBWMEDtqyym+o3LpD84g6yHSS9yWners+yfo+aybpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416002; c=relaxed/simple;
	bh=in/p2CZiyo0dRbqJ4sNOXS6qjrOqKvH900+eAbMkCW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C32Pku9P/9D4t6QjyOtKq4bAXOPvYUgwaCVv+n+2CKgk7akftYdoNCI12nqDvB9njZEE0SL6j8JbQwQXoNLX/W43o47LliCZvKK7KmtMuR2tMIFEfv9N5OBgftLwO1WxRmWvDcgM/BjVkNXjykND3StaIfvjZZneg8Os7guXiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh1ZpTG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh1ZpTG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BADA1F00A3A;
	Thu,  3 Sep 2026 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788416001;
	bh=jtYaKiA8HJ9BiT0A6YR6Axd0K61gbVEHIO71vjCnhLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jh1ZpTG8N1Bp4gbhoUIyLVnFGifMBYMjMTg5fdamSKgIzV7rk7evz4B4zAeo7vXtu
	 3nK5roZve0Yh8NWyDptK1SkuXBCHvGljwgt02I09mg4oxpgguPD+AmPU8Czz2Wox2b
	 A7BWU7t/XK1sJwLlNLSXnvrP6FcCln6KcyMI5W8u5KsOo6JMqsf1vSTFkTj0ZF+s0a
	 YLWhRaEk72iQaE/DXJfBInqBcZtH/6agfB15u6LTt6xxrrBB6QkWqrhaf+fd05V9Vi
	 irLSfpR9etc5Y6urjc4+ittqg0IEbjDbQDwRIqKOOq5aXDfoN718x73MJZDrNUYJHW
	 zYbNcVcEsdNzw==
Date: Thu, 3 Sep 2026 08:13:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [net-next,v5] net: airoha: add HW GRO offload support
Message-ID: <apkP_n7q85Y6pni6@lore-desk>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
 <178839576918.3394541.6887762855417310645@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0dJzZuvLUcSBUXl7"
Content-Disposition: inline
In-Reply-To: <178839576918.3394541.6887762855417310645@kernel.org>

--0dJzZuvLUcSBUXl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> - [High] LRO RX ring 31 is programmed as an active hardware-LRO
>   destination but is bound to no IRQ bank, so it is never polled.
> - [Medium] The driver advertises NETIF_F_GRO_HW while it cannot satisfy
>   the documented rx-gro-hw contract, because the hardware does not=E2=80=
=A6
>=20
> --
>=20
> net: airoha: add HW GRO offload support
>=20
> This adds hardware GRO (LRO) offload to airoha_eth, mapping the 8 LRO
> hardware contexts onto RX queues 24-31, bumping the page_pool order for
> those queues and disabling scatter-gather on them.  Aggregated frames get
> their network headers copied into a linear skb, the payload attached as a
> frag, CHECKSUM_PARTIAL with a pseudo-header checksum, and GSO metadata
> derived from the descriptor aggregation count.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 64619e9a704dd..57b19d7b5bd79 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -491,6 +493,88 @@ static void airoha_fe_crsn_qsel_init(struct airoha=
_eth *eth)
> >  				 CDM_CRSN_QSEL_Q1));
> >  }
> >
> > +static void airoha_fe_lro_rxq_enable(struct airoha_eth *eth, int qdma_=
id,
> > +				     int lro_queue_index, int qid,
> > +				     int buf_size)
> > +{
>=20
> [ ... ]
>=20
> > +	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
> > +		      LRO_RXQ_MASK(lro_queue_index),
> > +		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
> > +	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
> > +}
>=20
> [ ... ]
>=20
> > +static void airoha_dev_lro_enable(struct airoha_gdm_dev *dev)
> > +{
> > +	struct airoha_qdma *qdma =3D airoha_qdma_deref(dev);
> > +	struct airoha_eth *eth =3D qdma->eth;
> > +	int qdma_id =3D qdma - &eth->qdma[0];
> > +	int i, lro_queue_index =3D 0;
> > +
> > +	if (airoha_fe_lro_is_enabled(eth, qdma_id))
> > +		return;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> > +		struct airoha_queue *q =3D &qdma->q_rx[i];
> > +		u32 size;
> > +
> > +		if (!q->ndesc)
> > +			continue;
> > +
> > +		if (!airoha_qdma_is_lro_queue(q))
> > +			continue;
> > +
> > +		size =3D SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
> > +		size =3D min_t(u32, size, AIROHA_MAX_RX_SIZE);
> > +		airoha_fe_lro_rxq_enable(eth, qdma_id, lro_queue_index, i,
> > +					 size);
> > +		lro_queue_index++;
> > +	}
> > +}
>=20
> [Severity: High]
> Can traffic steered to LRO context 7 be dropped here?  This loop enables =
an
> LRO context for every RX ring selected by airoha_qdma_is_lro_queue(), and
> AIROHA_RXQ_LRO_EN_MASK is GENMASK(31, 24), so ring 31 gets LRO context 7 =
and
> BIT(7) is set in REG_CDM_LRO_EN.
>=20
> RX ring 31 does not appear in any IRQ bank pin mask in airoha_eth.h:
>=20
> 	#define RX_IRQ0_BANK_PIN_MASK			0x839f
> 	#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
> 	#define RX_IRQ2_BANK_PIN_MASK			0x20
> 	#define RX_IRQ3_BANK_PIN_MASK			0x40
>=20
> The union of those four masks covers queues 0-4, 7, 8, 15 and 21-30, but =
not
> BIT(31).  Since airoha_qdma_hw_init() derives the RX interrupt enables fr=
om
> those masks:
>=20
> 	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX2,
> 			       INT_RX2_MASK(RX_IRQ_BANK_PIN_MASK(i)));
>=20
> RX31_DONE is never enabled in any bank, and airoha_irq_handler() masks the
> status with irq_bank->irqmask, so q_rx[31]'s NAPI is never scheduled.  The
> re-arm loop in airoha_qdma_rx_napi_poll() is also a no-op for that qid:
>=20
> 	if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
> 		continue;
>=20
> The ring is still created and filled by airoha_qdma_fill_rx_queue(), so o=
nce
> its descriptors are consumed by the LRO engine it is never drained or
> refilled again.  Would either restricting the mask to GENMASK(30, 24) or
> adding BIT(31) to one of the bank pin masks be the intended fix?  The v4
> changelog in this posting lists "Enable rx interrupt for queue 31", but t=
hat
> change does not seem to be present in this version of the patch.

I think this issue has been already fixed in the following patch:
https://lore.kernel.org/netdev/20260830-airoha-rxdone-rxq31-v1-1-830a91503f=
2f@kernel.org/

>=20
> [ ... ]
>=20
> > @@ -657,12 +742,191 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, =
struct airoha_qdma_desc *desc)
> >  	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
> >  }
> >
> > +static struct sk_buff *airoha_qdma_lro_rx_skb(struct airoha_queue *q,
> > +					      struct airoha_qdma_desc *desc,
> > +					      struct airoha_queue_entry *e,
> > +					      u32 msg1, u32 msg2, u32 len,
> > +					      u32 agg_count)
> > +{
>=20
> [ ... ]
>=20
> > +	page =3D virt_to_head_page(e->buf);
> > +	data_len =3D len - data_off;
> > +	shinfo =3D skb_shinfo(skb);
> > +	skb_add_rx_frag(skb, shinfo->nr_frags, page,
> > +			e->buf + data_off - page_address(page), data_len,
> > +			q->buf_size);
> > +
> > +	shinfo->gso_type =3D ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> > +	/* HW does not report the per-segment MSS, so approximate it as
> > +	 * the average segment size. The LRO engine always aggregates
> > +	 * n-1 MSS-sized TCP segments plus one shorter tail for an
> > +	 * aggregate of n segments, so this still re-segments into
> > +	 * exactly agg_count segments, keeping gso_size/gso_segs and the
> > +	 * packet accounting coherent, while never overestimating the MSS.
> > +	 */
> > +	shinfo->gso_size =3D DIV_ROUND_UP(data_len, agg_count);
> > +	shinfo->gso_segs =3D agg_count;
>=20
> [Severity: Medium]
> Is NETIF_F_GRO_HW the right feature bit given this approximation?
> Documentation/networking/netdev-features.rst says for rx-gro-hw:
>=20
> 	A packet stream merged by Hardware GRO must
> 	be re-segmentable by GSO or TSO back to the exact original packet stream.
>=20
> With gso_size computed as the average payload size, the aggregate cannot =
be
> re-segmented into the original stream whenever the tail segment is shorter
> than the MSS, which the commit message describes as the normal case:
>=20
> 	The LRO engine always aggregates n-1 MSS-sized TCP segments plus one
> 	shorter tail for an aggregate of n segments
>=20
> For a two-segment aggregate of 1460 + 1000 bytes, gso_size becomes 1230, =
and
> GSO/TSO emits 1230 + 1230 rather than 1460 + 1000.  On the L3-forwarding =
path
> this patch targets, airoha_dev_xmit() writes that value straight into the=
 TX
> descriptor MSS field:
>=20
> 	__be16 csum =3D cpu_to_be16(skb_shinfo(skb)->gso_size);
>=20
> 	tcp_hdr(skb)->check =3D (__force __sum16)csum;
> 	msg0 |=3D FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
>=20
> so forwarded flows end up with a reduced MSS.  Would NETIF_F_LRO be the m=
ore
> accurate advertisement for an irreversible merge?

It is correct that the merged skb is not byte-exact re-segmentable since the
hw does not report the per-segment MSS and it is only possible to estimate =
the
gso_size using the following formula:
      =20
       gso_size =3D DIV_ROUND_UP(data_len, agg_count)

However the RX path builds a genuine GSO skb (SKB_GSO_TCPV4/V6,
gso_size, gso_segs, CHECKSUM_PARTIAL) handed to napi_gro_receive()
which is re-segmentable by GSO/TSO and further mergeable by software GRO.
That is the defining property of NETIF_F_GRO_HW.
Moreover, gso_size never exceeds the original MSS, so re-segmentation cannot
emit a segment larger than the path MTU.
Switching to LRO will disable the capability to forward/bridge the packet
between two different interfaces.

>=20
> A related question on gso_segs: agg_count comes from
> FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2) and is only bounded above =
by
> AIROHA_RXQ_LRO_MAX_AGG_COUNT, while data_len has no lower bound beyond 1.=
  If
> the engine ever aggregates segments that are not uniformly MSS-sized (for
> example 64 segments totalling 100 payload bytes, giving gso_size 2 and 50
> emitted segments), gso_segs would overstate the number of segments actual=
ly
> produced, which feeds qdisc pkt_len accounting.  Is the uniform-segment
> property guaranteed by the hardware for all aggregates?

I do not think the above example can occur since the hw will aggregate n-1
MSS-sized segments plus one shorter tail. With this assumption gso_segs mat=
ches
the number of segments actually emitted since:

      data_len >=3D (n - 1) * MSS
      agg_count =3D ceil(data_len / gso_size) --> gso_segs

Regards,
Lorenzo

>=20
> [ ... ]
>=20
> > @@ -3430,11 +3781,9 @@ static int airoha_alloc_gdm_device(struct airoha=
_eth *eth,
> >  	netdev->ethtool_ops =3D &airoha_ethtool_ops;
> >  	netdev->max_mtu =3D AIROHA_MAX_MTU;
> >  	netdev->watchdog_timeo =3D 5 * HZ;
> > -	netdev->hw_features =3D NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TS=
O6 |
> > -			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
> > -			      NETIF_F_HW_TC;
> > -	netdev->features |=3D netdev->hw_features;
> > -	netdev->vlan_features =3D netdev->hw_features;
> > +	netdev->hw_features =3D AIROHA_HW_FEATURES | NETIF_F_GRO_HW;
> > +	netdev->features |=3D AIROHA_HW_FEATURES;
> > +	netdev->vlan_features =3D AIROHA_HW_FEATURES;
> >  	SET_NETDEV_DEV(netdev, eth->dev);
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index fa9a8edce22ff..84cadbb538666 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -45,6 +45,18 @@
> >  	 (_n) =3D=3D 15 ? 128 :		\
> >  	 (_n) =3D=3D  0 ? 1024 : 16)
> >
> > +#define AIROHA_LRO_PAGE_ORDER		get_order(SZ_16K)
> > +#define AIROHA_MAX_NUM_LRO_QUEUES	8
> > +#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)
>=20
> [ ... ]
>=20
> >  #define PSE_RSV_PAGES			128
> >  #define PSE_QUEUE_RSV_PAGES		64
>=20
> [ ... ]
>=20
> > @@ -714,6 +728,18 @@ static inline bool airoha_is_7583(struct airoha_et=
h *eth)
> >  	return eth->soc->version =3D=3D 0x7583;
> >  }
> >
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
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260831-airoha-eth-lro-v5-1-6b0f50401121%40kernel.org

--0dJzZuvLUcSBUXl7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapkP/gAKCRA6cBh0uS2t
rIDoAQCulrw4FAc3wmMeCnXUOEsUqkEI2oHQNzhKjYBqKUTNTwD/aRRzhwBZdIz3
dKJT0H9wCWHvkMIB3GSHuHCZgXjPXQ8=
=MftG
-----END PGP SIGNATURE-----

--0dJzZuvLUcSBUXl7--
