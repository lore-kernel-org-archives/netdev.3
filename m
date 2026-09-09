Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED343AE185
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935808; cv=none; b=OmLLltFadgnAVB5+WrBaWTzJE+YXKkewKHksC93tV1wAYlkrE2WfNG38OrNQ4nBwjDvjQsQMMoye59+DcMX+q9yPtI8rUhUTtCXZHZNcxkGbKU2P+T5yxXX+RgqnhgYtg35rbE6ojDNwyWRvI1TzNI4I4r1FHcBVSyBFflo8axc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935808; c=relaxed/simple;
	bh=MbtHzIWfZPL32yWmUxl5oMb5klvMxru8idGtPZiOp90=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjKqznrpGyibqu/QcXxfO0ghHIVLFBtarQj0kbzxYkQmEDagLTs4pzSQCQ2Wy8szSk5LH+bVm/yjYoXSfVnGzEtou7a8eDEubPcJRe7s+vYH8TvjZxZwEqQKxmd9q++bZR2KbhS7ChygEHLw33w04ECtZ/4hVdfXCAt4ciRpFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS1LRARq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS1LRARq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBF81F00A3A;
	Wed,  9 Sep 2026 06:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935798;
	bh=LQqBI6ejBvDRlBhzvGR9su9GPpCHzF1qILQIojgm5Mw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jS1LRARqld8kZtl5I+TQJdUBa1Z2QlN+Nc+u3Mdd/oFYDN//Eozw1kpqPRG214O5Q
	 U+WFPBFrC7Vzs6w6F5wp803eZSRPfMAkgQU0xjW88EgmdHGTFaix86H+YTnCtQANVZ
	 99d68lIQd/mG+P+uN+QvkrZ7617CBdyYgKeDgNl5MK4mLENSOwx0kKDQ2LlADOMutZ
	 zVMkqDmj/6F++hTwiNMtUIdEXB8svcAZ26anNMsK+eG8S65YS29ObspgrRD3O1YeCy
	 bLSVze/K2UCpZUu0ZNEDZZMwfaZ2P2A/lmDHyITiNmd9iwdbb+Z1llsCIci1C216IT
	 HKUiFQ1z6dK5w==
Subject: Re: [PATCH net-next v6] net: airoha: add LRO offload support
From: netdev-bot+sashiko@kernel.org
To: lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, madhur.agrawal@airoha.com, horms@kernel.org
Date: Wed, 09 Sep 2026 06:36:37 +0000
Message-ID: <178893579710.219967.7015031895402367364@kernel.org>
In-Reply-To: <20260906-airoha-eth-lro-v6-1-a6cc5179a8c5@kernel.org>
References: <20260906-airoha-eth-lro-v6-1-a6cc5179a8c5@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] The new LRO drop path in `airoha_qdma_rx_process()` increments
  `netdev->stats.rx_dropped` (the legacy `struct net_device_stats`…
- [Low] The commit message claims "aggregated skbs are marked
  SKB_GSO_DODGY so that the stack does not rely on gso_size and does not…
- [Low] Teardown asymmetry for the shared FE/CDM LRO state:
  `airoha_dev_set_features()` arms the per-QDMA LRO block via…
- [Low] The new LRO error path performs a plain, non-atomic read-modify-
  write of the shared per-netdev counter `netdev->stats.rx_dropped++`…

--

net: airoha: add LRO offload support

This adds LRO offload to airoha_eth using the 8 dedicated LRO hardware
queues mapped to RX queues 24-31, bumping those queues' page_pool order
since LRO cannot use scatter-gather.  Aggregated skbs get GSO metadata
and a pseudo-header checksum so forwarded traffic can be re-segmented,
and NETIF_F_LRO is only offered while a single device uses the QDMA.

Link: https://lore.kernel.org/r/20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org

A few questions below.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 64619e9a704dd..7035b269a7c34 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -657,13 +742,146 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
>  	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
>  }
>  
> +static int airoha_qdma_lro_rx_skb(struct airoha_queue *q,
> +				  struct airoha_qdma_desc *desc,
> +				  u32 msg1, u32 len)
> +{

[ ... ]

> +	shinfo = skb_shinfo(skb);
> +	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> +	shinfo->gso_type |= SKB_GSO_DODGY;
> +	shinfo->gso_size = DIV_ROUND_UP(len - data_off, agg_count);
> +	shinfo->gso_segs = agg_count;

[Severity: Low]
Is the commit message description of SKB_GSO_DODGY the right way round?
It says:

    "aggregated skbs are marked SKB_GSO_DODGY so that the stack does not
     rely on gso_size and does not merge the aggregate into the GRO
     engine"

SKB_GSO_DODGY means the opposite for gso_segs: it tells the stack that
gso_segs is untrusted and must be recomputed from gso_size.  In
qdisc_pkt_len_segs_init() in net/core/dev.c:

	if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
		int payload = skb->len - hdr_len;
		...
		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);

and the TCP GSO output path uses gso_size as the MSS when re-segmenting,
so the approximated gso_size is authoritative rather than advisory.

The scheme still looks workable, since DIV_ROUND_UP(sum, agg_count) can
never exceed the largest merged segment and the re-segmented packets only
come out smaller.  Could the commit message state that rationale instead
of saying the stack does not rely on gso_size?

[ ... ]

> @@ -707,9 +927,17 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  			__skb_put(q->skb, len);
>  			skb_mark_for_recycle(q->skb);
>  			q->skb->dev = netdev;
> -			q->skb->protocol = eth_type_trans(q->skb, netdev);
>  			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
>  			skb_record_rx_queue(q->skb, qid);
> +
> +			if (airoha_qdma_lro_rx_skb(q, desc, msg1, len)) {
> +				netdev->stats.rx_dropped++;
                                ^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does this counter ever reach userspace?  This driver registers
.ndo_get_stats64 = airoha_dev_get_stats64, and that callback assigns
rx_dropped from its own MIB-derived stats:

	storage->rx_dropped = dev->stats.rx_drops;

dev_get_stats() in net/core/dev.c memsets storage and calls
ndo_get_stats64 when it exists, only falling back to
netdev_stats_to_stats64(storage, &dev->stats) when there is no
ndo_get_stats64/ndo_get_stats, and afterwards only adds dev->core_stats.

So every packet dropped here (agg_count above
AIROHA_RXQ_LRO_MAX_AGG_COUNT, IPv6 with extension headers so nexthdr is
not NEXTHDR_TCP, iph->ihl below 5, th->doff below 5, or a frame shorter
than the headers) appears nowhere in ip -s link or rtnetlink.

Would dev_core_stats_rx_dropped_inc(netdev), or the driver's own
dev->stats.rx_drops under its u64_stats syncp, be the better sink here?

[Severity: Low]
Separately, can this increment lose counts?  netdev->stats.rx_dropped is
a plain unsigned long shared per netdev, and this is a non-atomic
read-modify-write from NAPI context.

Each RX ring has its own NAPI instance (q->napi, 32 rings across the IRQ
banks) and the target netdev is resolved per descriptor by
airoha_qdma_get_gdm_dev(), so two pollers on different CPUs, for example
LRO rings 24 and 31 both resolving to the same airoha_gdm_dev, can reach:

	airoha_qdma_rx_napi_poll()
	  airoha_qdma_rx_process()
	    netdev->stats.rx_dropped++;

concurrently with no lock and no per-CPU separation, which also tears on
32-bit.

> +				dev_kfree_skb(q->skb);
> +				q->skb = NULL;
> +				continue;
> +			}
> +
> +			q->skb->protocol = eth_type_trans(q->skb, netdev);
>  		} else { /* scattered frame */
>  			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
>  			int nr_frags = shinfo->nr_frags;

[ ... ]

> @@ -2288,6 +2582,32 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
>  	}
>  }
>  
> +static netdev_features_t airoha_dev_fix_features(struct net_device *netdev,
> +						 netdev_features_t features)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	struct airoha_qdma *qdma;
> +
> +	qdma = airoha_qdma_deref(dev);
> +	if (qdma->users > 1)
> +		features &= ~NETIF_F_LRO;
> +
> +	return features;
> +}
> +
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

[Severity: Low]
Should the enable path here be gated on netif_running()?  There is no
admin-state check, so ethtool -K ethX lro on arms the shared FE/CDM LRO
block of the QDMA while the interface is still down.

The only teardown sites for that hardware state are ndo_stop and a later
ndo_set_features.  unregister_netdev() does not call ndo_stop for an
already-closed device, and neither airoha_qdma_cleanup() nor
airoha_hw_cleanup() touches REG_CDM_LRO_EN, REG_CDM_LRO_RXQ or
REG_CDM_LRO_LIMIT, so after this sequence:

	ethtool -K ethX lro on      # link down, LRO armed anyway
	rmmod airoha_eth

the CDM LRO engine stays enabled and mapped to RX queues 24-31 after
those rings, descriptors and page pools are gone.

This looks like leftover hardware state rather than something worse:
airoha_qdma_cleanup() clears GLOBAL_CFG_RX_DMA_EN_MASK and polls
GLOBAL_CFG_RX_DMA_BUSY_MASK before the RX buffers are released, so no DMA
into freed pages, and airoha_hw_init() asserts and deasserts the fe reset
on the next probe before airoha_fe_init(), so the stale enable bits do not
survive a rebind and cannot make airoha_dev_open() return -EBUSY forever.

Would it make sense to call airoha_dev_lro_disable() from the remove path
as well, so enable and disable are symmetric?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906-airoha-eth-lro-v6-1-a6cc5179a8c5%40kernel.org
