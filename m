Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30B22B8AB
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395772; cv=none; b=RUV/Cwt4odcMMQQSHKu/1WAhNixQA7GQQ3cBYmnpnZBGNNoXvq8PaTvxGU7TTgsdBxnmcaiV5zF5rrFxX84DtQuR0XkHAf9nq2psEBLSDFa5cuuHEwQzEZD/dWA4XFvEal99/SEhGj6M+dNP+di0C21AOzorlNdXqzYrHIB4z/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395772; c=relaxed/simple;
	bh=BQFGPhvMs1GK55jF5PCVVENSgFD9mvtaJXdXn7scVcw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFn8dmArXtRNv5eaaP37fHLXqSmnV2YXR/XPv7VU06Kd3lvLkU0U9e/MmV+OOOTe7qO6lxLRymj8q7c48TXOxdMMOZs+SMY+5uGy/Ucy7+lcTxOeGyss5m4OyRa8XH6R9u7VjPFxk+T6QEOigMV2WjGHsT55XUGMOr+h7CTbzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amxqXOaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amxqXOaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14ED1F000E9;
	Thu,  3 Sep 2026 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788395770;
	bh=x2qNbvy1T2SnAes3F/wQppFd+FrV00UggrHHdFmIYeg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=amxqXOaVVe9Eq3ryHurCwJ9xMvkiw03drQaDa0HowYQkLxd73aX8AcA9Nsg7NXAC0
	 c+rH3TNwHooCCWUXqmta3Nru8s+8f2wkPjkpv3AyB2Ama7T7d1veTN2YFHLVjfTXhP
	 UPBiCtbjQuVMPaFhQr0jJcKD802DBMNuXixQ2u6Ofjm53vLnm2wF2DoIgyhyF2dtRM
	 NQ0fNROlfD0klqJECOLHwBx0fCwaIVzVb5IP2wEJGgciIT4pg4S9K6g9QR0CxjzzzG
	 V2J8JyHcQRQHou6vEwTfCbl2ZjcRbE+D6vQRVsZ/ETAkhrCdnzsDnsJLrpJCnfihFr
	 a6qGOoOLqvJdw==
Subject: Re: [net-next,v5] net: airoha: add HW GRO offload support
From: netdev-bot+sashiko@kernel.org
To: lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, madhur.agrawal@airoha.com
Date: Thu, 03 Sep 2026 00:36:09 +0000
Message-ID: <178839576918.3394541.6887762855417310645@kernel.org>
In-Reply-To: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] LRO RX ring 31 is programmed as an active hardware-LRO
  destination but is bound to no IRQ bank, so it is never polled.
- [Medium] The driver advertises NETIF_F_GRO_HW while it cannot satisfy
  the documented rx-gro-hw contract, because the hardware does not…

--

net: airoha: add HW GRO offload support

This adds hardware GRO (LRO) offload to airoha_eth, mapping the 8 LRO
hardware contexts onto RX queues 24-31, bumping the page_pool order for
those queues and disabling scatter-gather on them.  Aggregated frames get
their network headers copied into a linear skb, the payload attached as a
frag, CHECKSUM_PARTIAL with a pseudo-header checksum, and GSO metadata
derived from the descriptor aggregation count.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 64619e9a704dd..57b19d7b5bd79 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -491,6 +493,88 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
>  				 CDM_CRSN_QSEL_Q1));
>  }
>
> +static void airoha_fe_lro_rxq_enable(struct airoha_eth *eth, int qdma_id,
> +				     int lro_queue_index, int qid,
> +				     int buf_size)
> +{

[ ... ]

> +	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
> +		      LRO_RXQ_MASK(lro_queue_index),
> +		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
> +	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
> +}

[ ... ]

> +static void airoha_dev_lro_enable(struct airoha_gdm_dev *dev)
> +{
> +	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
> +	struct airoha_eth *eth = qdma->eth;
> +	int qdma_id = qdma - &eth->qdma[0];
> +	int i, lro_queue_index = 0;
> +
> +	if (airoha_fe_lro_is_enabled(eth, qdma_id))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> +		struct airoha_queue *q = &qdma->q_rx[i];
> +		u32 size;
> +
> +		if (!q->ndesc)
> +			continue;
> +
> +		if (!airoha_qdma_is_lro_queue(q))
> +			continue;
> +
> +		size = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
> +		size = min_t(u32, size, AIROHA_MAX_RX_SIZE);
> +		airoha_fe_lro_rxq_enable(eth, qdma_id, lro_queue_index, i,
> +					 size);
> +		lro_queue_index++;
> +	}
> +}

[Severity: High]
Can traffic steered to LRO context 7 be dropped here?  This loop enables an
LRO context for every RX ring selected by airoha_qdma_is_lro_queue(), and
AIROHA_RXQ_LRO_EN_MASK is GENMASK(31, 24), so ring 31 gets LRO context 7 and
BIT(7) is set in REG_CDM_LRO_EN.

RX ring 31 does not appear in any IRQ bank pin mask in airoha_eth.h:

	#define RX_IRQ0_BANK_PIN_MASK			0x839f
	#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
	#define RX_IRQ2_BANK_PIN_MASK			0x20
	#define RX_IRQ3_BANK_PIN_MASK			0x40

The union of those four masks covers queues 0-4, 7, 8, 15 and 21-30, but not
BIT(31).  Since airoha_qdma_hw_init() derives the RX interrupt enables from
those masks:

	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX2,
			       INT_RX2_MASK(RX_IRQ_BANK_PIN_MASK(i)));

RX31_DONE is never enabled in any bank, and airoha_irq_handler() masks the
status with irq_bank->irqmask, so q_rx[31]'s NAPI is never scheduled.  The
re-arm loop in airoha_qdma_rx_napi_poll() is also a no-op for that qid:

	if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
		continue;

The ring is still created and filled by airoha_qdma_fill_rx_queue(), so once
its descriptors are consumed by the LRO engine it is never drained or
refilled again.  Would either restricting the mask to GENMASK(30, 24) or
adding BIT(31) to one of the bank pin masks be the intended fix?  The v4
changelog in this posting lists "Enable rx interrupt for queue 31", but that
change does not seem to be present in this version of the patch.

[ ... ]

> @@ -657,12 +742,191 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
>  	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
>  }
>
> +static struct sk_buff *airoha_qdma_lro_rx_skb(struct airoha_queue *q,
> +					      struct airoha_qdma_desc *desc,
> +					      struct airoha_queue_entry *e,
> +					      u32 msg1, u32 msg2, u32 len,
> +					      u32 agg_count)
> +{

[ ... ]

> +	page = virt_to_head_page(e->buf);
> +	data_len = len - data_off;
> +	shinfo = skb_shinfo(skb);
> +	skb_add_rx_frag(skb, shinfo->nr_frags, page,
> +			e->buf + data_off - page_address(page), data_len,
> +			q->buf_size);
> +
> +	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> +	/* HW does not report the per-segment MSS, so approximate it as
> +	 * the average segment size. The LRO engine always aggregates
> +	 * n-1 MSS-sized TCP segments plus one shorter tail for an
> +	 * aggregate of n segments, so this still re-segments into
> +	 * exactly agg_count segments, keeping gso_size/gso_segs and the
> +	 * packet accounting coherent, while never overestimating the MSS.
> +	 */
> +	shinfo->gso_size = DIV_ROUND_UP(data_len, agg_count);
> +	shinfo->gso_segs = agg_count;

[Severity: Medium]
Is NETIF_F_GRO_HW the right feature bit given this approximation?
Documentation/networking/netdev-features.rst says for rx-gro-hw:

	A packet stream merged by Hardware GRO must
	be re-segmentable by GSO or TSO back to the exact original packet stream.

With gso_size computed as the average payload size, the aggregate cannot be
re-segmented into the original stream whenever the tail segment is shorter
than the MSS, which the commit message describes as the normal case:

	The LRO engine always aggregates n-1 MSS-sized TCP segments plus one
	shorter tail for an aggregate of n segments

For a two-segment aggregate of 1460 + 1000 bytes, gso_size becomes 1230, and
GSO/TSO emits 1230 + 1230 rather than 1460 + 1000.  On the L3-forwarding path
this patch targets, airoha_dev_xmit() writes that value straight into the TX
descriptor MSS field:

	__be16 csum = cpu_to_be16(skb_shinfo(skb)->gso_size);

	tcp_hdr(skb)->check = (__force __sum16)csum;
	msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);

so forwarded flows end up with a reduced MSS.  Would NETIF_F_LRO be the more
accurate advertisement for an irreversible merge?

A related question on gso_segs: agg_count comes from
FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2) and is only bounded above by
AIROHA_RXQ_LRO_MAX_AGG_COUNT, while data_len has no lower bound beyond 1.  If
the engine ever aggregates segments that are not uniformly MSS-sized (for
example 64 segments totalling 100 payload bytes, giving gso_size 2 and 50
emitted segments), gso_segs would overstate the number of segments actually
produced, which feeds qdisc pkt_len accounting.  Is the uniform-segment
property guaranteed by the hardware for all aggregates?

[ ... ]

> @@ -3430,11 +3781,9 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  	netdev->ethtool_ops = &airoha_ethtool_ops;
>  	netdev->max_mtu = AIROHA_MAX_MTU;
>  	netdev->watchdog_timeo = 5 * HZ;
> -	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6 |
> -			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
> -			      NETIF_F_HW_TC;
> -	netdev->features |= netdev->hw_features;
> -	netdev->vlan_features = netdev->hw_features;
> +	netdev->hw_features = AIROHA_HW_FEATURES | NETIF_F_GRO_HW;
> +	netdev->features |= AIROHA_HW_FEATURES;
> +	netdev->vlan_features = AIROHA_HW_FEATURES;
>  	SET_NETDEV_DEV(netdev, eth->dev);

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index fa9a8edce22ff..84cadbb538666 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -45,6 +45,18 @@
>  	 (_n) == 15 ? 128 :		\
>  	 (_n) ==  0 ? 1024 : 16)
>
> +#define AIROHA_LRO_PAGE_ORDER		get_order(SZ_16K)
> +#define AIROHA_MAX_NUM_LRO_QUEUES	8
> +#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)

[ ... ]

>  #define PSE_RSV_PAGES			128
>  #define PSE_QUEUE_RSV_PAGES		64

[ ... ]

> @@ -714,6 +728,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
>  	return eth->soc->version == 0x7583;
>  }
>
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

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-airoha-eth-lro-v5-1-6b0f50401121%40kernel.org
