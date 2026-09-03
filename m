Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E744483A2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432973; cv=none; b=Olc1CVabOgxK+CPuG8fq81fE9YydZp4b5jCgij/BefHw8yUSzYv7NckvCopgA4JHN8zPrc4Sy7z7F0lu2BHMKFTyPm7a/PktcVTCEjZulysuN2P96FQ6sSrJfCb0poG+MpB2w6u3WETtafjlbZa9uyaeq8IPT3x5i843Ir8agRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432973; c=relaxed/simple;
	bh=1vRIF/uPlZxBqnmGNlTiAY/LqIVVaCNQy3sDCCCmUMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrNOMWbYxu4xQxUBpw+iEFGaXAOQQBci4Tyj1QwnyTDzwy3THFowF/WhyjoEjVlJ3UrJ2vePCWXqYogKHrvYRqe6gjO/v8kf849zVrBgDeu1Tb8fL/7O8+55OBCrjCVV9XnqxEHITaF9stmh/j1OubFnB2HHmIXKT6gXklRvhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLyjsnhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLyjsnhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FD71F00A3A;
	Thu,  3 Sep 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432972;
	bh=CBG+i64jz1mBd1WZ/ZCtHsQOSaH5mD8NPD8LMZ8Y+BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QLyjsnhxK2Jp0T/3aoYXiMyYRsUfTsbmXaAv2i10ZIedIYvdntz6dTIIz9MdiJjTB
	 AKOMYYqvKkwASmSFYDOnOhkSEVuz3B53QwR1Kj+Kv3hweE1OGEybpUh8v+paxwUUCA
	 vMWcGNyv206JdumSMsE4to13raChtU5jCjtUIFlsqodXvxWBEuD9Q4NzQvQaoSZJip
	 SIJi/QSBuqf8yRxlHFG4cK+FAMOJfdzIdrZhJLfViksDyPJkDvHPtEUWdp3ruZZNPo
	 wiW8Sb70mKmdvIAtpCyao/EJRmq5ogu7zAmkZJOhdqz93V+s+XqgGUN5JszPMthqZT
	 9GrrduZkUJF1w==
Date: Thu, 3 Sep 2026 11:56:07 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksander.lobakin@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [net-next,v5] net: airoha: add HW GRO offload support
Message-ID: <20260903105607.GL396647@horms.kernel.org>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
 <178839576918.3394541.6887762855417310645@kernel.org>
 <apkP_n7q85Y6pni6@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apkP_n7q85Y6pni6@lore-desk>

On Thu, Sep 03, 2026 at 08:13:18AM +0200, Lorenzo Bianconi wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> > 
> > Critical: 0 · High: 1 · Medium: 1 · Low: 0
> > 
> > - [High] LRO RX ring 31 is programmed as an active hardware-LRO
> >   destination but is bound to no IRQ bank, so it is never polled.
> > - [Medium] The driver advertises NETIF_F_GRO_HW while it cannot satisfy
> >   the documented rx-gro-hw contract, because the hardware does not…
> > 
> > --
> > 
> > net: airoha: add HW GRO offload support
> > 
> > This adds hardware GRO (LRO) offload to airoha_eth, mapping the 8 LRO
> > hardware contexts onto RX queues 24-31, bumping the page_pool order for
> > those queues and disabling scatter-gather on them.  Aggregated frames get
> > their network headers copied into a linear skb, the payload attached as a
> > frag, CHECKSUM_PARTIAL with a pseudo-header checksum, and GSO metadata
> > derived from the descriptor aggregation count.
> > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > > index 64619e9a704dd..57b19d7b5bd79 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > 
> > [ ... ]
> > 
> > > @@ -491,6 +493,88 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
> > >  				 CDM_CRSN_QSEL_Q1));
> > >  }
> > >
> > > +static void airoha_fe_lro_rxq_enable(struct airoha_eth *eth, int qdma_id,
> > > +				     int lro_queue_index, int qid,
> > > +				     int buf_size)
> > > +{
> > 
> > [ ... ]
> > 
> > > +	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
> > > +		      LRO_RXQ_MASK(lro_queue_index),
> > > +		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
> > > +	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
> > > +}
> > 
> > [ ... ]
> > 
> > > +static void airoha_dev_lro_enable(struct airoha_gdm_dev *dev)
> > > +{
> > > +	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
> > > +	struct airoha_eth *eth = qdma->eth;
> > > +	int qdma_id = qdma - &eth->qdma[0];
> > > +	int i, lro_queue_index = 0;
> > > +
> > > +	if (airoha_fe_lro_is_enabled(eth, qdma_id))
> > > +		return;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> > > +		struct airoha_queue *q = &qdma->q_rx[i];
> > > +		u32 size;
> > > +
> > > +		if (!q->ndesc)
> > > +			continue;
> > > +
> > > +		if (!airoha_qdma_is_lro_queue(q))
> > > +			continue;
> > > +
> > > +		size = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
> > > +		size = min_t(u32, size, AIROHA_MAX_RX_SIZE);
> > > +		airoha_fe_lro_rxq_enable(eth, qdma_id, lro_queue_index, i,
> > > +					 size);
> > > +		lro_queue_index++;
> > > +	}
> > > +}
> > 
> > [Severity: High]
> > Can traffic steered to LRO context 7 be dropped here?  This loop enables an
> > LRO context for every RX ring selected by airoha_qdma_is_lro_queue(), and
> > AIROHA_RXQ_LRO_EN_MASK is GENMASK(31, 24), so ring 31 gets LRO context 7 and
> > BIT(7) is set in REG_CDM_LRO_EN.
> > 
> > RX ring 31 does not appear in any IRQ bank pin mask in airoha_eth.h:
> > 
> > 	#define RX_IRQ0_BANK_PIN_MASK			0x839f
> > 	#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
> > 	#define RX_IRQ2_BANK_PIN_MASK			0x20
> > 	#define RX_IRQ3_BANK_PIN_MASK			0x40
> > 
> > The union of those four masks covers queues 0-4, 7, 8, 15 and 21-30, but not
> > BIT(31).  Since airoha_qdma_hw_init() derives the RX interrupt enables from
> > those masks:
> > 
> > 	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX2,
> > 			       INT_RX2_MASK(RX_IRQ_BANK_PIN_MASK(i)));
> > 
> > RX31_DONE is never enabled in any bank, and airoha_irq_handler() masks the
> > status with irq_bank->irqmask, so q_rx[31]'s NAPI is never scheduled.  The
> > re-arm loop in airoha_qdma_rx_napi_poll() is also a no-op for that qid:
> > 
> > 	if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
> > 		continue;
> > 
> > The ring is still created and filled by airoha_qdma_fill_rx_queue(), so once
> > its descriptors are consumed by the LRO engine it is never drained or
> > refilled again.  Would either restricting the mask to GENMASK(30, 24) or
> > adding BIT(31) to one of the bank pin masks be the intended fix?  The v4
> > changelog in this posting lists "Enable rx interrupt for queue 31", but that
> > change does not seem to be present in this version of the patch.
> 
> I think this issue has been already fixed in the following patch:
> https://lore.kernel.org/netdev/20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org/
> 
> > 
> > [ ... ]
> > 
> > > @@ -657,12 +742,191 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
> > >  	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
> > >  }
> > >
> > > +static struct sk_buff *airoha_qdma_lro_rx_skb(struct airoha_queue *q,
> > > +					      struct airoha_qdma_desc *desc,
> > > +					      struct airoha_queue_entry *e,
> > > +					      u32 msg1, u32 msg2, u32 len,
> > > +					      u32 agg_count)
> > > +{
> > 
> > [ ... ]
> > 
> > > +	page = virt_to_head_page(e->buf);
> > > +	data_len = len - data_off;
> > > +	shinfo = skb_shinfo(skb);
> > > +	skb_add_rx_frag(skb, shinfo->nr_frags, page,
> > > +			e->buf + data_off - page_address(page), data_len,
> > > +			q->buf_size);
> > > +
> > > +	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> > > +	/* HW does not report the per-segment MSS, so approximate it as
> > > +	 * the average segment size. The LRO engine always aggregates
> > > +	 * n-1 MSS-sized TCP segments plus one shorter tail for an
> > > +	 * aggregate of n segments, so this still re-segments into
> > > +	 * exactly agg_count segments, keeping gso_size/gso_segs and the
> > > +	 * packet accounting coherent, while never overestimating the MSS.
> > > +	 */
> > > +	shinfo->gso_size = DIV_ROUND_UP(data_len, agg_count);
> > > +	shinfo->gso_segs = agg_count;
> > 
> > [Severity: Medium]
> > Is NETIF_F_GRO_HW the right feature bit given this approximation?
> > Documentation/networking/netdev-features.rst says for rx-gro-hw:
> > 
> > 	A packet stream merged by Hardware GRO must
> > 	be re-segmentable by GSO or TSO back to the exact original packet stream.
> > 
> > With gso_size computed as the average payload size, the aggregate cannot be
> > re-segmented into the original stream whenever the tail segment is shorter
> > than the MSS, which the commit message describes as the normal case:
> > 
> > 	The LRO engine always aggregates n-1 MSS-sized TCP segments plus one
> > 	shorter tail for an aggregate of n segments
> > 
> > For a two-segment aggregate of 1460 + 1000 bytes, gso_size becomes 1230, and
> > GSO/TSO emits 1230 + 1230 rather than 1460 + 1000.  On the L3-forwarding path
> > this patch targets, airoha_dev_xmit() writes that value straight into the TX
> > descriptor MSS field:
> > 
> > 	__be16 csum = cpu_to_be16(skb_shinfo(skb)->gso_size);
> > 
> > 	tcp_hdr(skb)->check = (__force __sum16)csum;
> > 	msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
> > 
> > so forwarded flows end up with a reduced MSS.  Would NETIF_F_LRO be the more
> > accurate advertisement for an irreversible merge?
> 
> It is correct that the merged skb is not byte-exact re-segmentable since the
> hw does not report the per-segment MSS and it is only possible to estimate the
> gso_size using the following formula:
>        
>        gso_size = DIV_ROUND_UP(data_len, agg_count)
> 
> However the RX path builds a genuine GSO skb (SKB_GSO_TCPV4/V6,
> gso_size, gso_segs, CHECKSUM_PARTIAL) handed to napi_gro_receive()
> which is re-segmentable by GSO/TSO and further mergeable by software GRO.
> That is the defining property of NETIF_F_GRO_HW.
> Moreover, gso_size never exceeds the original MSS, so re-segmentation cannot
> emit a segment larger than the path MTU.
> Switching to LRO will disable the capability to forward/bridge the packet
> between two different interfaces.
> 
> > 
> > A related question on gso_segs: agg_count comes from
> > FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2) and is only bounded above by
> > AIROHA_RXQ_LRO_MAX_AGG_COUNT, while data_len has no lower bound beyond 1.  If
> > the engine ever aggregates segments that are not uniformly MSS-sized (for
> > example 64 segments totalling 100 payload bytes, giving gso_size 2 and 50
> > emitted segments), gso_segs would overstate the number of segments actually
> > produced, which feeds qdisc pkt_len accounting.  Is the uniform-segment
> > property guaranteed by the hardware for all aggregates?
> 
> I do not think the above example can occur since the hw will aggregate n-1
> MSS-sized segments plus one shorter tail. With this assumption gso_segs matches
> the number of segments actually emitted since:
> 
>       data_len >= (n - 1) * MSS
>       agg_count = ceil(data_len / gso_size) --> gso_segs


Thanks Lorenzo,

I agree that no action is required here.

Reviewed-by: Simon Horman <horms@kernel.org>


