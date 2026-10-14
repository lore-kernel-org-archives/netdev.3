Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40929992A;
	Wed, 14 Oct 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945405; cv=none; b=tksih24EWjWS9unBKGKbASd8y0S5TBgM6ZXbuENJQFqB3OVbUadxzO90znVOAQxFkN/95GnSaMyZkj5RHgjbK3/DoOtGQncc7eMtTU8i42hYAwQUAW2e8MPzZoI3XFAjrPY6oVMZYIbi4NYYxE0GE4aYAvS66garRX8ofcxiHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945405; c=relaxed/simple;
	bh=w8SROSJmbTTuXN8D5ueHreqcPmVVrCjinvI7fXcLG0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICDGMoU2u3ZiLKs0NS7D6f8L68D9vbcqfFAQZpilSbjdvDbmVVwvXACnGCwXIgKEONuhUmYqIdS+1HfHouKut8UPq9/eeOeVFw9BFhRPnejpeL6W7ZM5+tdKzw1s25K8c6zLo9PRUbwex+BAeQHgI3/PsICyKaFEDc2CyfUbatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9DSmFew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9DSmFew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FE21F000FF;
	Wed, 14 Oct 2026 02:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945403;
	bh=6GYF6cuw43sODTsKxpWjMHgnRVEWUNQRnVoKNLIBuXA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n9DSmFew9MiohSdHPFeeo7T7n08jTIfGv8sgzDE/zQs4h7r0YmP1CGrVZZhm5e10B
	 9SA1DwRpAdL/BJxtL7Qm56+KwCAIm8zk/VwLkiyjDGY8WK+ec6HrxB6dx2FYY53Hxi
	 WPGcccwYpNJHzc+Bd/jvnNdrnJHCcu1sr2QwH197eULmxMBSEKhpMeaOl0FdFkETe8
	 TA7NHfyHZ8fRbthYPQOmedDfh/5b09tcLhU9Xjw/AbT/QOyYE9JWsKjkg3Iv1BftuS
	 AhpyKj5CVItmaHjPDUuJgiozfZxyPZXZNCoBaCETnxTKNymWUy4hqd/evC1lHSSjGB
	 7oKPkcFAxef5g==
Subject: Re: [PATCH net-next v14 1/2] hinic3: Add ethtool statistic ops part1
From: netdev-bot+sashiko@kernel.org
To: gongfan1@huawei.com
Cc: wudi234@huawei.com, tengpeisen@huawei.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, ioana.ciornei@nxp.com,
 maxime.chevallier@bootlin.com, mohsin.bashr@gmail.com,
 dimitri.daskalakis1@gmail.com, hramamurthy@google.com,
 larysa.zaremba@intel.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 zhoushuai28@huawei.com, wulike1@huawei.com
Date: Wed, 14 Oct 2026 02:36:42 +0000
Message-ID: <179194540234.434549.9086977234857852355@kernel.org>
In-Reply-To:
 <441404dcc8af513f5c3dcee2fd88cefd5b888def.1791858167.git.gongfan1@huawei.com>
References:
 <441404dcc8af513f5c3dcee2fd88cefd5b888def.1791858167.git.gongfan1@huawei.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 (1) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hinic3_rx_poll() now returns `budget` instead of nr_pkts when
  the loop exits because num_wqe >= nic_dev->lro_replenish_thld (new…
- [Medium] The new ethtool -S string tables add driver-private counters
  that already have a standard kernel uAPI, which networking-drivers.md…
- [Medium] hinic3_get_pkt_stats() uses `(gso_segs - 1) *
  skb_tcp_all_headers(skb)` to compute the replicated header bytes for…
- [Medium] net: hinic3: LRO packets undercounted in RX statistics
- [Low] In hinic3_rx_csum() the patch adds a second copy of the comment
  '/* pkt type is recognized by HW, and csum is wrong */' above the new…
- [Low] Each call to hinic3_get_ethtool_stats() sends
  L2NIC_CMD_GET_VPORT_STAT and, on a PF, MAG_CMD_GET_PORT_STAT to the…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new
  rx_buf_empty counter in hinic3_rx_fill_buffers() records an RQ-…
- [Low] The patch adds txq_stats.dropped++ on hinic3_send_one_skb()'s
  err_out path.

--

hinic3: Add ethtool statistic ops part1

This commit adds per-queue TX/RX software counters and firmware-backed
vport and physical port statistics to the hinic3 driver. It implements
the .get_strings, .get_sset_count and .get_ethtool_stats callbacks so
these can be read with ethtool -S, and adds packet/byte accounting to
the RX and TX hot paths.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de95..3863d26542ad4 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c

[ ... ]

> +static struct hinic3_stats hinic3_port_stats[] = {
> +	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_tx_65_127_oct_pkt_num),

[ ... ]

> +	HINIC3_PORT_STAT(mac_rx_fragment_pkt_num),
> +	HINIC3_PORT_STAT(mac_rx_undersize_pkt_num),
> +	HINIC3_PORT_STAT(mac_rx_undermin_pkt_num),
> +	HINIC3_PORT_STAT(mac_rx_64_oct_pkt_num),
> +	HINIC3_PORT_STAT(mac_rx_65_127_oct_pkt_num),

[ ... ]

> +static struct hinic3_stats hinic3_tx_queue_stats[] = {
> +	HINIC3_TXQ_STAT(busy),
> +	HINIC3_TXQ_STAT(skb_pad_err),
> +	HINIC3_TXQ_STAT(offload_cow_skb_err),
> +	HINIC3_TXQ_STAT(map_frag_err),
> +	HINIC3_TXQ_STAT(unknown_tunnel_pkt),
> +};
> +
> +static struct hinic3_stats hinic3_rx_queue_stats[] = {
> +	HINIC3_RXQ_STAT(csum_errors),
> +	HINIC3_RXQ_STAT(other_errors),
> +	HINIC3_RXQ_STAT(rx_buf_empty),
> +	HINIC3_RXQ_STAT(alloc_skb_err),
> +	HINIC3_RXQ_STAT(alloc_rx_buf_err),
> +};

[Severity: Medium]
Several of these ethtool -S strings look like duplicates of counters
that already have a standard uAPI.

In the port stats, mac_{rx,tx}_64_oct_pkt_num through
mac_{rx,tx}_12288_16383_oct_pkt_num map onto the ethtool_rmon_stats
hist[] and hist_tx[] buckets. mac_rx_fragment_pkt_num and
mac_rx_undersize_pkt_num map onto ethtool_rmon_stats fragments and
undersize_pkts. The per-priority PFC counters overlap with the DCB
ieee_pfc requests/indications.

In the per-queue stats:

  rxq%d_csum_errors corresponds to netdev_queue_stats_rx csum_bad
  rxq%d_alloc_skb_err and rxq%d_alloc_rx_buf_err correspond to
  netdev_queue_stats_rx alloc_fail
  txq%d_busy is close to netdev_queue_stats_tx stop

All of these are exposed through netdev netlink qstats (struct
netdev_stat_ops), which hinic3 does not implement yet.

The follow-up "hinic3: Add ethtool statistic ops part2" adds
.get_rmon_stats, .get_pause_stats and .get_eth_mac_stats, and fills
hist[]/hist_tx[] from the same mac_*_oct_pkt_num fields. It does not
remove those entries from hinic3_port_stats[], though. At the end of
the series, won't the histogram, fragment and undersize counters be
exported twice?

Could these entries be dropped from the ethtool -S tables in favour of
the standard interfaces, with netdev_stat_ops added for the per-queue
ones?

[ ... ]

> +static void hinic3_get_ethtool_stats(struct net_device *netdev,
> +				     struct ethtool_stats *stats, u64 *data)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct l2nic_vport_stats vport_stats = {};
> +	u16 i = 0, j;
> +	char *p;
> +	int err;
> +
> +	err = hinic3_get_vport_stats(nic_dev->hwdev,
> +				     hinic3_global_func_id(nic_dev->hwdev),
> +				     &vport_stats);
> +	if (err)
> +		netdev_err(netdev, "Failed to get function stats from fw\n");

[Severity: Low]
__dev_ethtool() does not require CAP_NET_ADMIN for ETHTOOL_GSTATS.
Every call here sends L2NIC_CMD_GET_VPORT_STAT to the management
firmware, and on a PF it also sends MAG_CMD_GET_PORT_STAT through
hinic3_get_ethtool_port_stats().

If the firmware rejects these commands or is unresponsive, each call
logs a dev_err() from hinic3_get_vport_stats() and
hinic3_get_phy_port_stats(), plus the netdev_err() calls here and in
hinic3_get_ethtool_port_stats(). None of these are rate limited.

Could an unprivileged user running ethtool -S in a loop flood the
kernel log this way, while also keeping the mailbox busy under rtnl?
Would a ratelimited variant, or logging only once per failure path,
work better here? The part2 commit appears to add more firmware-backed
callbacks that follow the same pattern.

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab59013797..df55d65a88516 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c

[ ... ]

> @@ -170,6 +172,11 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
>  				rxq->next_to_update << HINIC3_NORMAL_RQ_WQE);
>  		rxq->delta -= i;
>  		rxq->next_to_alloc = rxq->next_to_update;
> +	} else if (free_wqebbs == rxq->q_depth - 1) {
> +		syncp = &rxq->rxq_stats.syncp;
> +		flags = u64_stats_update_begin_irqsave(syncp);
> +		rxq->rxq_stats.rx_buf_empty++;
> +		u64_stats_update_end_irqrestore(syncp, flags);
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
The new rx_buf_empty counter records a state that the driver does not
appear to recover from by itself.

The only runtime refill is in hinic3_rx_poll():

	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
		hinic3_rx_fill_buffers(rxq);

Suppose page_pool_dev_alloc_frag() keeps failing under memory pressure
until every posted buffer has been consumed. The RQ then has no posted
WQEs and the NIC stops producing RX CQEs. hinic3_poll() calls
napi_complete_done() and re-enables MSI-X, and no timer or work item
retries the refill.

The SQ and RQ share the MSI-X vector, so a TX completion on the same
queue pair would schedule NAPI again. On a queue pair with no TX
traffic, does RX stay stalled until the interface is reset?

>  
>  	return i;

[ ... ]

> @@ -330,10 +337,24 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,

[ ... ]

>  	if (unlikely(csum_err)) {
> +		/* pkt type is recognized by HW, and csum is wrong */
> +		if (csum_err != HINIC3_RX_CSUM_HW_CHECK_NONE &&
> +		    csum_err != HINIC3_RX_CSUM_IPSU_OTHER_ERR) {
> +			u64_stats_update_begin(&rxq->rxq_stats.syncp);
> +			rxq->rxq_stats.csum_errors++;
> +			u64_stats_update_end(&rxq->rxq_stats.syncp);
> +		}
>  		/* pkt type is recognized by HW, and csum is wrong */
>  		skb->ip_summed = CHECKSUM_NONE;
>  		return;

[Severity: Low]
This isn't a bug, but the comment "pkt type is recognized by HW, and
csum is wrong" now appears twice. The second copy sits above the
fallback that also runs for HINIC3_RX_CSUM_HW_CHECK_NONE and
HINIC3_RX_CSUM_IPSU_OTHER_ERR. The new condition treats those two
values as not being checksum errors.

Could the second copy be removed or reworded?

[ ... ]

> @@ -575,18 +603,50 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)

[ ... ]

>  		rx_cqe->status = 0;
>  
> -		if (num_wqe >= nic_dev->lro_replenish_thld)
> +		if (num_wqe >= nic_dev->lro_replenish_thld) {
> +			poll_again = true;
>  			break;
> +		}
>  	}
>  
>  	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
>  		hinic3_rx_fill_buffers(rxq);
>  
> -	return nr_pkts;
> +	u64_stats_update_begin(&rxq->rxq_stats.syncp);
> +	rxq->rxq_stats.packets += (u64)nr_pkts;
> +	rxq->rxq_stats.bytes += rx_bytes;
> +	u64_stats_update_end(&rxq->rxq_stats.syncp);
> +	return poll_again ? budget : nr_pkts;

[Severity: Medium]
Are the RX packet and byte counters meant to measure the same thing
for LRO completions? Right now they don't.

When num_lro is non-zero, hinic3_rx_poll() adds
(num_lro - 1) * pkt_hdr_len to rx_bytes. That rebuilds the header
bytes the hardware stripped while coalescing, so rx_bytes approximates
the bytes of all num_lro frames seen on the wire.

rxq_stats.packets is bumped by nr_pkts, though, and nr_pkts only
counts one per CQE. A completion that coalesced num_lro segments adds
the wire bytes of num_lro frames but counts as a single packet.

These counters feed rx_packets and rx_bytes in hinic3_get_stats64().
With LRO enabled, rx_packets is undercounted and the average RX packet
size looks inflated. The TX side does count wire packets:
hinic3_get_pkt_stats() adds gso_segs to txq_stats.packets. So TX and
RX now use different conventions.

Should the loop keep a separate packet count that adds num_lro (or 1
when num_lro is 0) and use that for rxq_stats.packets? nr_pkts would
stay as the NAPI budget counter. Alternatively, if per-aggregate
counting is what you want, should the header-length adjustment to
rx_bytes be dropped so both counters agree?

[Severity: Medium]
This changes the return value when the loop exits on the LRO
replenish threshold. It used to return nr_pkts and now returns budget.

In hinic3_poll():

	work_done = hinic3_rx_poll(irq_cfg->rxq, budget);
	busy |= work_done >= budget;

	if (busy)
		return budget;

As a result, the threshold exit now skips napi_complete_done(),
hinic3_net_dim() and the MSI-X re-enable. NAPI keeps polling instead
of waiting for the next interrupt.

This seems unrelated to statistics, and the commit message does not
mention it. Was it intended? If it fixes an LRO stall, could it go in
a separate patch with its own explanation and a Fixes: tag?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index d19cfbe3ed3b3..d6c4efd43b7cd 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c

[ ... ]

> @@ -487,6 +495,27 @@ static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
>  					      num_sge + !!offload);
>  }
>  
> +static void hinic3_get_pkt_stats(struct hinic3_txq *txq, struct sk_buff *skb)
> +{
> +	u32 hdr_len, tx_bytes;
> +	unsigned short pkts;
> +
> +	if (skb_is_gso(skb)) {
> +		hdr_len = (skb_shinfo(skb)->gso_segs - 1) *
> +			  skb_tcp_all_headers(skb);

[Severity: Medium]
Is skb_tcp_all_headers() correct for encapsulated GSO skbs? When VXLAN
offload is supported, the driver advertises NETIF_F_GSO_UDP_TUNNEL and
NETIF_F_GSO_UDP_TUNNEL_CSUM, so VXLAN-encapsulated TSO skbs reach this
code.

For those skbs, skb_transport_header() points at the outer UDP header.
tcp_hdrlen() then reads doff from the VXLAN header (the first VNI
byte) instead of the inner TCP header. That usually gives 0, not the
size of the replicated headers.

hinic3_tso() already switches to skb_inner_transport_header() when
skb->encapsulation is set, and include/linux/tcp.h provides
skb_inner_tcp_all_headers() for this case. hinic3_get_stats64()
reports txq_stats.bytes as tx_bytes, so wouldn't tx_bytes be
undercounted for tunnel traffic?

> +		tx_bytes = skb->len + hdr_len;
> +		pkts = skb_shinfo(skb)->gso_segs;
> +	} else {

[ ... ]

> @@ -608,6 +648,9 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  err_drop_pkt:
>  	dev_kfree_skb_any(skb);
>  err_out:
> +	u64_stats_update_begin(&txq->txq_stats.syncp);
> +	txq->txq_stats.dropped++;
> +	u64_stats_update_end(&txq->txq_stats.syncp);
>  	return NETDEV_TX_OK;
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but hinic3_xmit_frame() has
its own drop path that never reaches err_out:

	if (unlikely(!netif_carrier_ok(netdev)))
		goto err_drop_pkt;

	if (unlikely(q_id >= nic_dev->q_params.num_qps))
		goto err_drop_pkt;
	...
err_drop_pkt:
	dev_kfree_skb_any(skb);

	return NETDEV_TX_OK;

Drops taken here are not counted anywhere, so they will not show up in
tx_dropped. Is that intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791858167.git.gongfan1%40huawei.com
