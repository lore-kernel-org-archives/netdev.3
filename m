Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018650;
	b=ghwJzPAUOz4j7V9enJKh1i6RT1V2OohMGnpzrbW8X3EM9E1t+aIQezs8cUBtZxPuJEmw
	 UAe4dwgBrmDgniMZyj+Yw9zC9Q+Se7oCe63KL+sYGIpzC9sliZTqyYYl6eLzUroWkyvzq
	 ze6X712wwMrkRbiEuBNXjgamlfxHqi5LkkaKy+/7xWw9aqu6fUOMy8d1ICmybZzXl6jVk
	 WXZx+fzZ/Wb4Yvd5QAnFXqIgjaII/v75hRtBMXwDZ9BUi7F9zB8HYLOAPqO4+hDh8OgQi
	 WeTUHexERn917awvFNqmzW8rONehsPDA78i/W+QYYJcBhhm3u/X2yGnhZHsKH8UJ8+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018650;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OGdTeLhlX7anGpK/sof07r54SgkGVVV7bBbxgAgT74k=;
	b=K0hXjT8onmW7UV9gdeZL7sY1XnRMBxePcu+JNnc0nnbEpDO0Y+T5XpRNH/vAmiFFYduI
	 wu8uEK+I/WqY0xJuvrKwXOOhRpe5jElY/U2kXe4A6N5WiZi19POT5JsgvnQbJP+ix3yIe
	 J14/fkaceOXXiHStmIwjF0WRvQsjq3HV6KbR4geUUXImHa0w2euMOsschY3RleCQWGWRD
	 Vi/3VqLSADqDj7uQ5eLxnIOuseOtaCb8Un4tW6l9TRpDqfqNV1AdoVsCzXT0cA6h7SoXB
	 +CMIuLqc0uf+kCjJ8rpSW2tiALrLbmoN8qfGKMWGUNc2KzdUR/UEVPesLCd+sShCg2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJLHhNI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53E606A333;
	Mon, 26 Oct 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJLHhNI8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F21F031E6;
	Mon, 26 Oct 2026 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018649;
	bh=OGdTeLhlX7anGpK/sof07r54SgkGVVV7bBbxgAgT74k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eJLHhNI8eBbniE2m92MRjgZZO8297eDqWVBNTYc18O9W03O09SK8Mzj5snTCj86iM
	 6wT5eB2c27l5T8iLK0dfcERA7fJOxUXeEfu4xUQBZ7yeJ9PLBSIAeyct94eCyrlEb4
	 K46VOFdBoS8BeANQTzVpEpaXdIJWn29cm+gutrhe+NH6rZSnwiZAdxDlL/AGgYTiAc
	 cPqaweZkhxKhCEiNMxnT7e79dmiCA29y3upyQh89/RazdYMtz5PUV2xeIHWlAlpV4x
	 5uY35F/QbAKMJ5OkN5W+zuHxcRVsAW2Ei/ZcyaFgd0oX1qmIhSlaXLF/9oN0oMMplz
	 sDYT9KKTSqR0A==
Subject: Re: [PATCH net-next v18 1/4] hinic3: Add ethtool statistic ops part1
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
Date: Mon, 26 Oct 2026 12:44:08 +0000
Message-ID: <179301864810.3134.2939761618327593882@kernel.org>
In-Reply-To:
 <1b35942d45717da8896349eedc71ffc924a0e8f9.1792671176.git.gongfan1@huawei.com>
References:
 <1b35942d45717da8896349eedc71ffc924a0e8f9.1792671176.git.gongfan1@huawei.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] hinic3_send_one_skb()
  (drivers/net/ethernet/huawei/hinic3/hinic3_tx.c) reads skb->len for…
- [Medium] The commit is described as a feature (ethtool -S support).
- [Medium] The new TX byte (and packet) accounting in
  hinic3_send_one_skb() adds only skb->len and 1 per skb.
- [Medium] The new RX accounting in hinic3_rx_poll() adds the CQE pkt_len
  to rx_bytes and counts nr_pkts once per completion.

--

hinic3: Add ethtool statistic ops part1

This commit adds per-queue TX/RX software counters plus firmware-backed
vport and physical port statistics to hinic3. It implements the
.get_strings, .get_sset_count and .get_ethtool_stats callbacks for
ethtool -S, and adds packet/byte accounting to the RX and TX hot paths.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9d..c71bb3dff39c3 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -802,14 +802,14 @@ static void hinic3_get_stats64(struct net_device *netdev,
>  		txq_stats = &txq->txq_stats;
>  		do {
>  			start = u64_stats_fetch_begin(&txq_stats->syncp);
> -			bytes += txq_stats->bytes;
> -			packets += txq_stats->packets;
> -			dropped += txq_stats->dropped;
> +			bytes = txq_stats->bytes;
> +			packets = txq_stats->packets;
> +			dropped = txq_stats->dropped;
>  		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
> +		stats->tx_packets += packets;
> +		stats->tx_bytes   += bytes;
> +		stats->tx_dropped += dropped;
>  	}
> -	stats->tx_packets = packets;
> -	stats->tx_bytes   = bytes;
> -	stats->tx_dropped = dropped;

[Severity: Medium]
The commit message says this patch adds ethtool -S support. This hunk
also changes hinic3_get_stats64() so it no longer accumulates with +=
inside the u64_stats_fetch_begin()/u64_stats_fetch_retry() loop. Before,
every retry added the values again.

The new increments in hinic3_rx_poll() and hinic3_send_one_skb() also
look like the first writes to rxq_stats/txq_stats packets and bytes,
apart from hinic3_rxq_clean_stats() and hinic3_txq_clean_stats().

At the baseline, did hinic3_get_stats64() then always report 0 for RX/TX
packets, bytes and dropped in ip -s link and /proc/net/dev?

If so, hinic3_net_dim() was only passing zeros to DIM:

hinic3_irq.c:hinic3_net_dim() {
    ...
	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,
			  rxq->rxq_stats.bytes, &sample);
    ...
}

That would mean adaptive RX coalescing never saw any traffic.

The commit message doesn't mention any of this. Could these fixes go to
net as separate patches, with Fixes: tags for the commits that added
.ndo_get_stats64 and DIM, so stable kernels get them?

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab59013797..ae4ccff4a09a9 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c

[ ... ]

> @@ -575,6 +602,7 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
>  			break;
>  
>  		nr_pkts++;
> +		rx_bytes += pkt_len;
>  		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
>  		if (num_lro)
>  			num_wqe += hinic3_get_sge_num(rxq, pkt_len);

[Severity: Medium]
When hardware LRO is on (ethtool -K <dev> lro on), one CQE stands for
num_lro coalesced wire packets. recv_one_pkt() already passes num_lro to
hinic3_lro_set_gso_params(), which sets gso_segs = num_lro.

Are rx_packets and rx_bytes undercounted for LRO aggregates? nr_pkts goes
up by one per completion. pkt_len holds only one copy of the headers, so
the headers of the other num_lro - 1 packets are not counted.

hinic3_get_stats64() reports these values as rx_packets/rx_bytes as they
are. Later in the series they are also reported as qstats
rx-packets/rx-bytes, which netdev.yaml defines as wire packets.

num_lro is already read here for the replenish threshold. Could it be
used for the counters too?

[ ... ]

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index f92568f0f00b7..b0a0ffb1052b3 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c

[ ... ]

> @@ -599,11 +617,19 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,
>  			hinic3_get_sq_local_pi(txq->sq));
>  
> +	u64_stats_update_begin(&txq->txq_stats.syncp);
> +	txq->txq_stats.bytes += skb->len;
> +	txq->txq_stats.packets += 1;
> +	u64_stats_update_end(&txq->txq_stats.syncp);
> +
>  	return NETDEV_TX_OK;

[Severity: High]
Can the skb already be freed when skb->len is read here?

At this point tx_info->skb is published and hinic3_write_db() has given
the WQE to the device. TX completion runs from NAPI on whichever CPU
handles the queue interrupt. It takes no lock that the xmit path also
takes:

hinic3_poll()
  hinic3_tx_poll()
    hinic3_tx_unmap_skb(netdev, tx_info->skb, tx_info->dma_info);
    napi_consume_skb(tx_info->skb, budget);

Suppose the device completes the packet and another CPU runs
hinic3_tx_poll() before this CPU reaches the stats update. That can
happen if this CPU takes a hardirq, if the vCPU is preempted, or under
PREEMPT_RT. The read of skb->len is then a use-after-free, and a garbage
value is added to tx_bytes.

Before this patch the skb was not touched after the doorbell, because
netif_subqueue_sent() reads skb->len earlier. The code is unchanged at
the end of the series ("hinic3: Add ethtool pause param ops").

Would saving skb->len in a local before the doorbell, next to
netif_subqueue_sent(), and using that local for the stats fix this?

[Severity: Medium]
How are TSO skbs counted here? hinic3_tso() passes gso_size to the
hardware via hinic3_set_tso_info(), so one GSO skb goes out as several
Ethernet frames. skb->len includes the L2/L3/L4 headers only once.

So tx_packets goes up by one per GSO skb rather than once per wire frame.
tx_bytes also misses the headers that are copied into each extra segment.

hinic3_get_stats64() reports these as rtnl_link_stats64
tx_packets/tx_bytes. The UAPI says tx_bytes should count the length of
Ethernet frames excluding the FCS.

Later in the series, "hinic3: Add Add per queue netdev-genl stats" also
reports these counters as qstats tx-packets/tx-bytes, which are defined
as wire packets.

Should this take gso_segs and the copied header length into account, for
example skb->len + (gso_segs - 1) * hdr_len?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792671176.git.gongfan1%40huawei.com
