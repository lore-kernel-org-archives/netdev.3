Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0986484222;
	Thu,  6 Aug 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033301; cv=none; b=T4PlQuYblcYWw3Gv39735/M4x/GuQgz9Pz1c9F/3DeQBaPo3ak/u5IXjCAixmcHEpJ/EMcVTQ0P3BYwwGh7O/1YX6QKqUZ1OfCa+46ji51kRf9JY53uDEHzVgbL10R/UbyZ08LGf18qmRhjUWTlM+FNA/+MFrpudhNCepKFMNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033301; c=relaxed/simple;
	bh=CWSOB+01n6yBT5+NB6a/EI8aYO0RfIkBcqVF0QhrKZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBhmsYRYoTjxjMUIpvFfRCVa59Y3bu1p9OgweP6L3ysWukN8wxFMxvNQl5BBxk/phi/sGQ5Gb22XjlF5LzdypmJ6jWbYbhowmHHLbKgG2Ad64/RlqLyA5MRfipB5IKkuFHip9VbEDmUq9XFfLH67LoYANEqpDZ2xiJnoEC4FdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdK2i1+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdK2i1+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124801F00A3A;
	Thu,  6 Aug 2026 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033299;
	bh=3u7IMMljh9y+vRP22SDVLQd06oEen4ckU0ogzSPEl00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdK2i1+C3M5rRmuIdb8YZ9NmSjzGaGhIpsVIz5g0n6lMmJjKKnPpLsRWfNYfxBbL7
	 BiO19JgKRanD8H1xynr/8XBMw9OyLEs3zyMfzxfUdswgP9pLYx55eFgUQwPzEr1ebv
	 1a023096GkQ5Bd9qgtSOpN45yX6eoZb//EGUQ/QenxuKA6Y973sFUZSyWHWHxKfMdU
	 nHksRuDL2INbXdOfAaFdk0McpSLnbZ4AnyE1MYL2XznIPJRqXOuSSDPaDMiFb+3AHa
	 0lPMlpAxDmIaxiWDOGSslJ9+LKOvaPsRRaIx4LAqk5ShcOlREwIHXvWOb9hymgDW8x
	 Ldn5qe6tfZTtw==
From: Jakub Kicinski <kuba@kernel.org>
To: gongfan1@huawei.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	tengpeisen@huawei.com,
	wudi234@huawei.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	larysa.zaremba@intel.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chenanwen@huawei.com,
	august.hewei@huawei.com,
	zhangmin548@huawei.com,
	luosifu@huawei.com,
	guoxin09@huawei.com,
	zhoushuai28@huawei.com,
	wulike1@huawei.com,
	shijing34@huawei.com
Subject: Re: [PATCH net] hinic3: Fix SKB linearization mismatch and silent TX drops
Date: Thu,  6 Aug 2026 09:21:38 -0700
Message-ID: <20260806162138.2749871-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ca8f219dd1eac99e41e22477bd0902b92ec7628e.1785899557.git.tengpeisen@huawei.com>
References: <ca8f219dd1eac99e41e22477bd0902b92ec7628e.1785899557.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Let's add the counters in a separate patch targetting
net-next."
---
hinic3: Fix SKB linearization mismatch and silent TX drops

This moves the hinic3_tx_offload() call in hinic3_send_one_skb() ahead of
the num_sge computation so a linearizing skb_checksum_help() cannot leave a
stale fragment count behind, and propagates skb_checksum_help() errors as
HINIC3_TX_OFFLOAD_INVALID.  It also adds dropped, map_frag_err,
unknown_tunnel_pkt and skb_pad_err accounting to several TX error paths.

No Link: tags in the commit header.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index 9306bf0020caf..45effdddb4341 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> @@ -97,8 +97,12 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
>  
>  	dma_info[0].dma = dma_map_single(&pdev->dev, skb->data,
>  					 skb_headlen(skb), DMA_TO_DEVICE);
> -	if (dma_mapping_error(&pdev->dev, dma_info[0].dma))
> +	if (dma_mapping_error(&pdev->dev, dma_info[0].dma)) {
> +		u64_stats_update_begin(&txq->txq_stats.syncp);
> +		txq->txq_stats.map_frag_err++;
> +		u64_stats_update_end(&txq->txq_stats.syncp);
>  		return -EFAULT;
> +	}

[Severity: Low]
Can these three new counters actually be observed by a user?

Of the four counters added here, only dropped has a consumer.  The single
reader of struct hinic3_txq_stats is hinic3_get_stats64() in
hinic3_netdev_ops.c, which copies only bytes, packets and dropped into
struct rtnl_link_stats64:

	do {
		start = u64_stats_fetch_begin(&txq_stats->syncp);
		bytes += txq_stats->bytes;
		packets += txq_stats->packets;
		dropped += txq_stats->dropped;
	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));

and hinic3_ethtool_ops in hinic3_ethtool.c implements no
get_ethtool_stats/get_sset_count/get_strings callbacks, so there is no
ethtool -S path either.

That makes map_frag_err, unknown_tunnel_pkt and skb_pad_err dead stores.
The changelog says these events are "correctly reflected in interface
statistics" - does that hold for anything other than dropped?

>  
>  	dma_info[0].len = skb_headlen(skb);
>  
> @@ -117,6 +121,9 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
>  						     skb_frag_size(frag),
>  						     DMA_TO_DEVICE);
>  		if (dma_mapping_error(&pdev->dev, dma_info[idx].dma)) {
> +			u64_stats_update_begin(&txq->txq_stats.syncp);
> +			txq->txq_stats.map_frag_err++;
> +			u64_stats_update_end(&txq->txq_stats.syncp);
>  			err = -EFAULT;
>  			goto err_unmap_page;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but since it instruments exactly
this failure path it may be worth fixing in the same series: can the mapping
failure return here leave a dangling txq->tx_info[pi].skb?

In hinic3_send_one_skb() the ring slot is published before mapping:

	tx_info = &txq->tx_info[pi];
	tx_info->skb = skb;
	tx_info->wqebb_cnt = wqebb_cnt;

	err = hinic3_tx_map_skb(netdev, skb, txq, tx_info, &wqe_combo);
	if (err) {
		/* Rollback work queue to reclaim the wqebb we did not use */
		txq->sq->wq.prod_idx = saved_wq_prod_idx;
		txq->sq->owner = saved_sq_owner;
		goto err_drop_pkt;
	}

err_drop_pkt calls dev_kfree_skb_any(skb) but tx_info->skb is not reset, and
because prod_idx is rolled back, hinic3_tx_poll() - the only place that
clears tx_info->skb during normal operation - never visits that slot.

If the queue is torn down before that slot is reused
(hinic3_free_txrxq_resources() -> hinic3_free_txqs_res() ->
free_all_tx_skbs()), the stale pointer is consumed:

	if (tx_info->skb) {
		hinic3_tx_unmap_skb(netdev, tx_info->skb,
				    tx_info->dma_info);
		dev_kfree_skb_any(tx_info->skb);
		tx_info->skb = NULL;
	}

hinic3_tx_unmap_skb() reads skb_shinfo(skb)->nr_frags of the freed SKB and
dma_unmap()s stale entries (when the head mapping failed, dma_info[0].dma
holds DMA_MAPPING_ERROR and dma_info[0].len is stale), then the same SKB is
freed a second time.

Would clearing tx_info->skb (and wqebb_cnt) in the rollback block before the
goto be enough here?

> @@ -260,9 +267,11 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
>  		if (l4_proto != IPPROTO_UDP ||
>  		    ((struct udphdr *)skb_transport_header(skb))->dest !=
>  		    VXLAN_OFFLOAD_PORT_LE) {
> +			u64_stats_update_begin(&txq->txq_stats.syncp);
> +			txq->txq_stats.unknown_tunnel_pkt++;
> +			u64_stats_update_end(&txq->txq_stats.syncp);
>  			/* Unsupported tunnel packet, disable csum offload */
> -			skb_checksum_help(skb);
> -			return 0;
> +			return skb_checksum_help(skb);
>  		}
>  	}

[Severity: Low]
Is the comment still accurate after this change?  It says "disable csum
offload", but hinic3_tx_offload() now turns a negative return into a drop:

		tso_cs_en = hinic3_tx_csum(txq, task, skb);
		if (tso_cs_en < 0) {
			offload = HINIC3_TX_OFFLOAD_INVALID;
			return offload;
		}

The comment has also been separated from the statement it describes by the
new accounting block; moving it back above the return, and mentioning the
drop-on-failure behaviour, would read more clearly.

[Severity: Medium]
This is a pre-existing issue, but this hunk sits right on top of it: the
TUNNEL_FLAG bit is set into the task descriptor earlier in hinic3_tx_csum(),
before the tunnel type is known:

		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
								 TUNNEL_FLAG));

On this software-fallback path nothing clears it again.  When
skb_checksum_help() succeeds the function returns 0, so
HINIC3_TX_OFFLOAD_CSUM is not set, but if the same SKB carries a VLAN tag
hinic3_tx_offload() still sets HINIC3_TX_OFFLOAD_VLAN and
hinic3_send_one_skb() publishes the task section:

	if (offload)
		*wqe_combo.task = task;

Does the device mind being told the frame is tunnelled while INNER_L3_EN,
INNER_L4_EN, PLDOFF and MSS are all zero?  This looks reachable with e.g.
GRE or GENEVE traffic on a VLAN interface.

>  
> @@ -412,6 +421,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
>  		offload |= HINIC3_TX_OFFLOAD_TSO;
>  	} else {
>  		tso_cs_en = hinic3_tx_csum(txq, task, skb);
> +		if (tso_cs_en < 0) {
> +			offload = HINIC3_TX_OFFLOAD_INVALID;
> +			return offload;
> +		}
>  		if (tso_cs_en)
>  			offload |= HINIC3_TX_OFFLOAD_CSUM;
>  	}

[ ... ]

> @@ -539,12 +552,17 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  	int err;
>  
>  	if (unlikely(skb->len < MIN_SKB_LEN)) {
> -		if (skb_pad(skb, MIN_SKB_LEN - skb->len))
> +		if (skb_pad(skb, MIN_SKB_LEN - skb->len)) {
> +			u64_stats_update_begin(&txq->txq_stats.syncp);
> +			txq->txq_stats.skb_pad_err++;
> +			u64_stats_update_end(&txq->txq_stats.syncp);
>  			goto err_out;
> +		}
>  
>  		skb->len = MIN_SKB_LEN;
>  	}
>  
> +	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
>  	num_sge = skb_shinfo(skb)->nr_frags + 1;

[Severity: Medium]
The offload call moved above the free-wqebb check, but the
HINIC3_TX_OFFLOAD_INVALID test stayed below it.  Should the INVALID test
move up with the call?

As it stands, a packet that hinic3_tx_offload() has already declared
untransmittable (skb_checksum_help() failure, hinic3_tso()/skb_cow_head()
failure, or PLDOFF above SQ_CTRL_MAX_PLDOFF) hits this first:

	if (unlikely(hinic3_wq_free_wqebbs(&txq->sq->wq) < wqebb_cnt)) {
		...
		return NETDEV_TX_BUSY;
	}

	if (unlikely(offload == HINIC3_TX_OFFLOAD_INVALID)) {
		goto err_drop_pkt;

so when the SQ is full the qdisc re-queues a packet that will fail
deterministically on every retry, holding up that txq until the SQ drains,
and neither dropped nor busy is accounted for it.

There is a second effect of the reordering: all of hinic3_tx_offload()'s
side effects on the SKB - skb_cow_head(), the in-place pseudo-header writes
in hinic3_tso(), skb_checksum_help() with its possible __skb_linearize() and
ip_summed = CHECKSUM_NONE, and the new unknown_tunnel_pkt increment - are
now performed before the driver knows it can enqueue, so they are repeated
and thrown away on every NETDEV_TX_BUSY attempt.  Since skb_checksum_help()
leaves ip_summed at CHECKSUM_PARTIAL when it fails, that work is redone on
each retry too.

The changelog says only that the call moved "before calculating 'num_sge'";
could it also mention that it now runs before the NETDEV_TX_BUSY return?

[Severity: High]
This isn't a regression from this patch, but this is the line where the
check would belong: num_sge is derived straight from nr_frags with no clamp
against the hardware limit HINIC3_MAX_SQ_SGE (18, hinic3_nic_io.h) and no
skb_linearize() fallback.

hinic3_tx_map_skb() then writes one dma_info entry per fragment with no
bound:

	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
		...
		idx = i + 1;
		dma_info[idx].dma = skb_frag_dma_map(...);

and the per-slot slice is tx_info[idx].dma_info = &tqres->bds[idx *
HINIC3_BDS_PER_SQ_WQEBB], where HINIC3_SQ_WQEBB_SIZE is 16 and
sizeof(struct hinic3_sq_bufdesc) is 16, so HINIC3_BDS_PER_SQ_WQEBB is 1.
The array is allocated in hinic3_alloc_txqs_res() with exactly
HINIC3_MAX_SQ_SGE entries of tail slack:

		tqres->bds = kzalloc_objs(*tqres->bds,
					  sq_depth * HINIC3_BDS_PER_SQ_WQEBB + HINIC3_MAX_SQ_SGE);

With CONFIG_MAX_SKB_FRAGS raised above 18 (net/Kconfig permits up to 45), a
transmit at the tail of the ring writes DMA addresses and lengths past the
end of that allocation, and programs a WQE whose BUFDESC_NUM exceeds the
18-SGE limit.  Grep finds no comparison of num_sge against
HINIC3_MAX_SQ_SGE anywhere in the driver, and the declared frag_size_err and
frag_len_overflow counters are never incremented, which suggests a bounds
check was intended here.  Can this overflow tqres->bds[]?

>  	/* assume normal wqe format + 1 wqebb for task info */
>  	wqebb_cnt = num_sge + 1;
>  
> @@ -560,7 +578,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  		return NETDEV_TX_BUSY;
>  	}
>  
> -	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
>  	if (unlikely(offload == HINIC3_TX_OFFLOAD_INVALID)) {
>  		goto err_drop_pkt;
>  	} else if (!offload) {

[Severity: Low]
These are pre-existing gaps rather than something this patch introduces, but
they are in the same area the patch is closing, so it may be worth covering
them too:

- this NETDEV_TX_BUSY return never increments txq_stats.busy, which is
  already declared and zeroed by hinic3_txq_clean_stats().

- hinic3_xmit_frame() has its own err_drop_pkt label for the carrier-down
  and out-of-range q_id cases, and it still frees the SKB and returns
  NETDEV_TX_OK without touching any counter:

	err_drop_pkt:
		dev_kfree_skb_any(skb);

		return NETDEV_TX_OK;

  so "silent TX drops" remain for those two cases.

- offload_cow_skb_err stays permanently zero even though this patch reworks
  the hinic3_tso()/skb_cow_head() failure branch that the counter was
  declared for:

	tso_cs_en = hinic3_tso(task, queue_info, skb);
	if (tso_cs_en < 0) {
		offload = HINIC3_TX_OFFLOAD_INVALID;
		return offload;
	}

[ ... ]

> @@ -604,6 +621,10 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  err_drop_pkt:
>  	dev_kfree_skb_any(skb);
>  err_out:
> +	u64_stats_update_begin(&txq->txq_stats.syncp);
> +	txq->txq_stats.dropped++;
> +	u64_stats_update_end(&txq->txq_stats.syncp);
> +
>  	return NETDEV_TX_OK;
>  }

[Severity: Medium]
This is a pre-existing problem, not one this patch creates, but the patch
makes it easier to notice: hinic3_get_stats64() publishes tx_packets and
tx_bytes from fields that nothing ever increments.

	stats->tx_packets = packets;
	stats->tx_bytes   = bytes;
	stats->tx_dropped = dropped;

The only site in the driver that touches txq_stats->packets and
txq_stats->bytes is hinic3_txq_clean_stats():

	txq_stats->bytes = 0;
	txq_stats->packets = 0;

The TX path accounts bytes through netif_subqueue_sent() and
netif_subqueue_completed_wake() (BQL) instead, so "ip -s link show" reports
tx_packets and tx_bytes as 0.  After this patch tx_dropped becomes non-zero
while those two stay at zero.  Should the packet and byte counters be
incremented in hinic3_send_one_skb() as well?

[Severity: Low]
This is a pre-existing style point about the reader side of these counters
rather than a bug in this patch, and no user is affected today:
hinic3_get_stats64() accumulates with "+=" inside the retry loop:

	do {
		start = u64_stats_fetch_begin(&txq_stats->syncp);
		bytes += txq_stats->bytes;
		packets += txq_stats->packets;
		dropped += txq_stats->dropped;
	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));

A retry would add each counter twice.  It cannot happen here, because
drivers/net/ethernet/huawei/hinic3/Kconfig has "depends on PCI_MSI && 64BIT"
and the 64-bit __u64_stats_fetch_retry() in include/linux/u64_stats_sync.h
is a compile-time "return false".  Would using local temporaries assigned
inside the loop and adding them after it be preferable, so the loop body
stays idempotent?
-- 
pw-bot: cr
