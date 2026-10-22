Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640804;
	b=LHTzQYZPoLwI0CWMxBM9eWm94igfs9kbtKpweB8OeZqsJUJf2YusiWiW/xPKdQc0XHbJ
	 Ejk8g4HH2TYf/9iG+PePYllw3A9he38Y7FXfSqKKvCJ6aA7aXts3o2mDpnv3Zk4sJDfA2
	 ciMlHBHczqqWIaOWSpSxvxTA72tG/TDsDjqPec3Qb/vBc+oSPLx6Xggwi2vQr/L6rh1aE
	 NHenlTMyVBK5RbJ8bPFGbL2dOEPpzb5rY/dF73RJNOzXlYZ0NH5d3O+eOMTWhfQc5F5H8
	 cYU589lCNpbDcHNgbPbKb1dLX9vz/oNhGM+HDMnASmfxZO6eQxJi1j9VBjPML+VhjXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640804;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VjSl5G0xxAoo7SyMKgXsKJz9ZcCY1le0dNClbAjxsO4=;
	b=lHtnuUR2G5GEB6b//mSqTXyEu6EIAAzuOX11XrJr90CfcQ/RJCOAs7ASC47Zt52tBoHu
	 AKfY/yGdkjfDreYMqqshb8dF87xSigbpFDDcFuQFNAM65Nh548254EoNqFi6XgoQfppUJ
	 4ZxMhjx2FFGObdQh7U+kz4ORRafIcZecKxrSdrCBqa36nZup/rIUmTmsx1Ney5P6tmoAv
	 LV4sqVS3L3S0VqEVqQZPoEEWpnxf9btj+20v9Cvbph65jjfkyPmcsKDHeIKnrZehrA+r1
	 FSxZzWV41vihl5eFbdKnXr0cpt6cANlll0Lv5A8Ymyxuc+SDBHNj12Y9zQw6Gz2vdow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7Qe2Av6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E4606A31A;
	Thu, 22 Oct 2026 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7Qe2Av6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75F01F000C2;
	Thu, 22 Oct 2026 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640803;
	bh=VjSl5G0xxAoo7SyMKgXsKJz9ZcCY1le0dNClbAjxsO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G7Qe2Av6Lugi7X7bSVxeyVX0sUjW3F81XQNuRMfUolJXa0jICThu7mY6JDA+xrI43
	 iqT2Djx+pGUy1+MOWf3UlxniukX2phNmqVnOrDB1WypIHtXNgjwmtTKyPiFcQ+ux6y
	 GEMcUFz1QuzgVJ2TWCYW/TLDwxZWDwzZwrvRfDkMCqw1rxpMA1fDfnYfO5146fskLu
	 FegT+qtloRfQElw9keBScShlCDiJXD19LWaicfOqgiltsTB3bpdTohDznK5Y3BsE+C
	 X9zkJgZOVo/1khrC2p6JJLCU/B/dGZpjZW6uyay1ftyy3ELduTGm/ysP9IkUEvs4kP
	 FGSfzT6KRqXZA==
Subject: Re: [PATCH net-next v17 1/2] hinic3: Add ethtool statistic ops part1
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
Date: Thu, 22 Oct 2026 03:46:42 +0000
Message-ID: <179264080220.3135.11883538951453346110@kernel.org>
In-Reply-To:
 <0d19828afdc0cec629c8b342cc3f7a0c11ecb1f3.1792378301.git.gongfan1@huawei.com>
References:
 <0d19828afdc0cec629c8b342cc3f7a0c11ecb1f3.1792378301.git.gongfan1@huawei.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Several new ethtool -S strings report counters that already
  have a standard kernel uAPI.
- [Medium] Until this patch, csum_errors and other_errors were never
  incremented.
- [Medium] The new hot-path accounting counts aggregated packets as one
  packet.
- [Medium] net: hinic3: non-idempotent u64_stats retry loop in
  hinic3_get_stats64()
- [Low] TX packets and bytes are counted at submission, not when the
  device acknowledges them.

--

hinic3: Add ethtool statistic ops part1

This commit adds per-queue TX/RX software counters and firmware-backed
vport and physical port statistics to hinic3. They are exposed through
.get_strings, .get_sset_count and .get_ethtool_stats for ethtool -S. It
also adds packet and byte accounting to the RX and TX hot paths.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de95..64c862052f1e8 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c

[ ... ]

> @@ -409,6 +412,290 @@ hinic3_get_link_ksettings(struct net_device *netdev,

[ ... ]

> +static struct hinic3_stats hinic3_function_stats[] = {

[ ... ]

> +	HINIC3_FUNC_STAT(rx_multicast_pkts_vport),

[ ... ]

> +	HINIC3_FUNC_STAT(tx_discard_vport),
> +	HINIC3_FUNC_STAT(rx_discard_vport),
> +	HINIC3_FUNC_STAT(tx_err_vport),
> +	HINIC3_FUNC_STAT(rx_err_vport),
> +};

[ ... ]

> +static struct hinic3_stats hinic3_port_stats[] = {

[ ... ]

> +	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkts),

[ ... ]

> +	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkts),

[ ... ]

> +	HINIC3_PORT_STAT(mac_rx_pfc_pri0_pkts),

[ ... ]

> +	HINIC3_PORT_STAT(mac_rx_pfc_pri7_pkts),

[ ... ]

> +static struct hinic3_stats hinic3_tx_queue_stats[] = {
> +	HINIC3_TXQ_STAT(gso_packets),
> +	HINIC3_TXQ_STAT(busy),
> +	HINIC3_TXQ_STAT(skb_pad_err),
> +	HINIC3_TXQ_STAT(offload_cow_skb_err),
> +	HINIC3_TXQ_STAT(map_frag_err),
> +	HINIC3_TXQ_STAT(unknown_tunnel_pkt),
> +};
> +
> +static struct hinic3_stats hinic3_rx_queue_stats[] = {
> +	HINIC3_RXQ_STAT(lro_packets),
> +	HINIC3_RXQ_STAT(csum_errors),
> +	HINIC3_RXQ_STAT(other_errors),
> +	HINIC3_RXQ_STAT(rx_buf_empty),
> +	HINIC3_RXQ_STAT(alloc_skb_err),
> +	HINIC3_RXQ_STAT(alloc_rx_buf_err),
> +};

[Severity: Medium]
Several of these new ethtool -S strings look like duplicates of counters
that already have a standard uAPI.

Per-queue stats in hinic3_tx_queue_stats and hinic3_rx_queue_stats:

  txq%d_gso_packets is counted with skb_is_gso() in
  hinic3_get_pkt_stats(). That matches
  netdev_queue_stats_tx.hw_gso_packets.

  rxq%d_csum_errors counts HW-flagged bad checksums on packets that are
  still delivered with CHECKSUM_NONE. That matches
  netdev_queue_stats_rx.csum_bad.

  rxq%d_alloc_skb_err and rxq%d_alloc_rx_buf_err count RX skb and page
  allocation failures. That matches netdev_queue_stats_rx.alloc_fail.

  txq%d_busy is close to netdev_queue_stats_tx.stop.

Vport stats in hinic3_function_stats: rx_multicast_pkts_vport,
tx/rx_discard_vport and tx/rx_err_vport map to the multicast,
tx/rx_dropped and tx/rx_errors fields in rtnl_link_stats64. However,
hinic3_get_stats64() never fills multicast or tx_errors.

Port stats in hinic3_port_stats: mac_tx_pfc_pri0..7_pkts and
mac_rx_pfc_pri0..7_pkts duplicate the requests[] and indications[]
arrays in the dcbnl struct ieee_pfc.

The hinic3 driver has no netdev_stat_ops and no dcbnl ops, so ynl
qstats, ip -s link and dcb pfc cannot see any of these values. Once the
private names ship, moving them later is a user-visible change.

Could these counters go through the standard interfaces instead of
ethtool -S?

The later commit "hinic3: Add ethtool statistic ops part2" resolves the
RMON part. It adds get_rmon_stats, get_eth_mac_stats and get_pause_stats,
and the TX-side fragment, undersize, oversize and jabber counters have no
field in struct ethtool_rmon_stats. So only the per-queue, vport and PFC
duplicates remain.

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab59013797..44b0723cedbba 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c

[ ... ]

> @@ -330,10 +342,23 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
>  	struct net_device *netdev = rxq->netdev;
>  	bool l2_tunnel;
>  
> +	/* HW ensures that only 1 bit is set in csum_err. */
> +	if (unlikely(csum_err == HINIC3_RX_CSUM_IPSU_OTHER_ERR)) {
> +		u64_stats_update_begin(&rxq->rxq_stats.syncp);
> +		rxq->rxq_stats.other_errors++;
> +		u64_stats_update_end(&rxq->rxq_stats.syncp);
> +	}
> +
>  	if (!(netdev->features & NETIF_F_RXCSUM))
>  		return;
>  
>  	if (unlikely(csum_err)) {
> +		if (csum_err != HINIC3_RX_CSUM_HW_CHECK_NONE &&
> +		    csum_err != HINIC3_RX_CSUM_IPSU_OTHER_ERR) {
> +			u64_stats_update_begin(&rxq->rxq_stats.syncp);
> +			rxq->rxq_stats.csum_errors++;
> +			u64_stats_update_end(&rxq->rxq_stats.syncp);
> +		}
>  		/* pkt type is recognized by HW, and csum is wrong */
>  		skb->ip_summed = CHECKSUM_NONE;
>  		return;

[Severity: Medium]
Before this patch, csum_errors and other_errors were never incremented.
The packets they now count are still delivered to the stack with
CHECKSUM_NONE.

recv_one_pkt() returns 0 for these packets, so hinic3_rx_poll() also
counts them in nr_pkts and rx_bytes. The existing hinic3_get_stats64()
then does:

    errors += rxq_stats->csum_errors +
        rxq_stats->other_errors;
    ...
    stats->rx_packets = packets;
    ...
    stats->rx_errors  = errors;

Is each such packet now reported both in rx_packets ("Number of good
packets received") and in rx_errors ("Total number of bad packets
received")?

A remote peer can trigger this by sending frames with bad L4 checksums.

other_errors is bumped even when NETIF_F_RXCSUM is off, but csum_errors
is only bumped when it is on. As a result, the meaning of rx_errors
changes when RXCSUM is toggled.

Would netdev_queue_stats_rx.csum_bad be a better place for delivered
packets with a HW-flagged bad checksum?

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index f92568f0f00b7..ccac6413f9809 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c

[ ... ]

> @@ -487,6 +496,20 @@ static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
>  					      num_sge + !!offload);
>  }
>  
> +static void hinic3_get_pkt_stats(struct hinic3_txq *txq, struct sk_buff *skb)
> +{
> +	u64 gso_packets = 0;
> +
> +	if (skb_is_gso(skb))
> +		gso_packets = 1;
> +
> +	u64_stats_update_begin(&txq->txq_stats.syncp);
> +	txq->txq_stats.bytes += skb->len;
> +	txq->txq_stats.packets += 1;
> +	txq->txq_stats.gso_packets += gso_packets;
> +	u64_stats_update_end(&txq->txq_stats.syncp);
> +}

[Severity: Medium]
With this patch, the TX and RX hot paths start updating bytes,
packets and dropped under txq_stats.syncp and rxq_stats.syncp. On
32-bit builds the seqcount in these syncps now really moves while
traffic is flowing.

The existing reader in hinic3_get_stats64() in hinic3_netdev_ops.c
does not look safe against that:

    do {
        start = u64_stats_fetch_begin(&txq_stats->syncp);
        bytes += txq_stats->bytes;
        packets += txq_stats->packets;
        dropped += txq_stats->dropped;
    } while (u64_stats_fetch_retry(&txq_stats->syncp, start));

Suppose hinic3_get_pkt_stats(), hinic3_send_one_skb() or
hinic3_xmit_frame() updates the queue while the reader runs. Then
u64_stats_fetch_retry() returns true and the body runs again. That
second pass adds the queue's counters to the running totals a
second time. A torn value read on the first pass also stays in the
sum.

The rxq loop has the same pattern. It accumulates bytes, packets and
dropped, plus errors += csum_errors + other_errors, while
hinic3_rx_poll() and hinic3_rx_csum() are now writers.

On a 32-bit system under load, ip -s link, /proc/net/dev and
RTM_GETSTATS can therefore report inflated and non-monotonic rx/tx
counters. On 64-bit the seqcount compiles away, so this does not
show up in testing there.

This patch is what makes these counters live. Could it also change
the reader to snapshot each queue's values into locals inside the
retry loop, and add them to the totals only after the loop exits?

[Severity: Medium]
Should this take skb_shinfo(skb)->gso_segs into account?

A GSO skb is counted here as one packet and skb->len bytes. The device
actually sends gso_segs frames and repeats the headers in each one, so a
64KB TSO skb is roughly 45 frames on the wire.

hinic3_get_stats64() exports these values as tx_packets and tx_bytes.
if_link.h says IEEE 802.3 devices should count the length of Ethernet
frames, and netdev.yaml defines tx-packets as wire packets.

hinic3_rx_poll() has the same pattern on the RX side:

    nr_pkts++;
    rx_bytes += pkt_len;
    num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
    if (num_lro) {
        num_wqe += hinic3_get_sge_num(rxq, pkt_len);
        lro_packets++;
    }

An LRO CQE adds 1 to rxq_stats.packets even though num_lro gives the
number of aggregated packets. That half is more debatable, because
several in-tree drivers count per completion.

hinic3_net_dim() also passes rxq_stats.packets and rxq_stats.bytes to
dim_update_sample(), so DIM now sees aggregated packet rates rather than
the wire rate.

[ ... ]

> @@ -595,6 +628,7 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  				  txq->tx_stop_thrs,
>  				  txq->tx_start_thrs);
>  
> +	hinic3_get_pkt_stats(txq, skb);
>  	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);
>  	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,
>  			hinic3_get_sq_local_pi(txq->sq));

[Severity: Low]
This counts the skb as transmitted before hinic3_prepare_sq_ctrl()
publishes the descriptor and before the doorbell is rung.
hinic3_tx_poll() does not update txq_stats on completion.

include/uapi/linux/if_link.h describes hardware tx_packets as packets
the device acknowledged it copied out of host memory. netdev.yaml
tx-packets refers to the device usually having issued a DMA completion.

Would hinic3_tx_poll() be a better place for this accounting?

With the current placement, in-flight descriptors are reported as sent.
Descriptors that never complete, such as skbs freed when the ring is
flushed on reset or close, stay counted as sent permanently.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792378301.git.gongfan1%40huawei.com
