Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA26449B17;
	Sat, 10 Oct 2026 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624554; cv=none; b=BhtT1AQ7QnENoJapjB8dRJG7qzdvWOlTIEipygTtpIVETEinkWguCaBh+7JL80FCtkWqwiJMMdmd3lq9U6YNwDctjyTyHbC/zL/idKw0vKC4MkJVMDTdx7Qf4HarKeTRwnnHtrIP9U1cN8zlEkxDsgmYj4zkvreIlkf1Q+c6TLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624554; c=relaxed/simple;
	bh=LiJUino/IAiPnPH0S1zUKHplSF1wzG8QrzRrNC0bJtY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SSvCXLIW8IPL+mLKnR7Mbagl0BN0SAO0qkujz+AajIk7tMrDEzn0cizO6b4kbNlehLivfRW12O9flh6WOtola9T0Hbm1cHrIUgtqTfcYqRTqxUHqIVtFEkV6wl9ShLFZhfGYv1BvpxWuJ5dwxre6zPyY8rAcj/s3vOgs7puTTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBqTJ7h4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBqTJ7h4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C38E1F00893;
	Sat, 10 Oct 2026 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624552;
	bh=ZF7el77aodFbHx+s0qkm81cFWG+XeUTwOA8WAxw3oBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QBqTJ7h4lb+6jb2snRTWhFr7wc9F1Hirh3ERLaUZ82J2CULKFEFJCxUObQngeCcAL
	 qQPGWX1ZviHskO78zaKTnvbftBak19rn5jfOatGhxlX4/awPHhxcDo+icpYm71bwWB
	 g1JABVw8W94bnRNIijAApglXLrQDZrMiqJ8S9NAVLsBeRYTAmEvnC4sqQ32hDvZYc3
	 q9b577m+bGEldllu8CojxGe5wcTsok0DFqr0lNG6u/NCDIvbcVK75i4IjRbXwtxC0i
	 jaPfBF04apZyZCXPWkbNNtVCj/c9S6hMthnCwuAphggt5ZTCIlzQJqQNP07I/+JR83
	 4T3WjhrFND1ww==
Subject: Re: [PATCH net-next v3 7/8] net: qualcomm: rmnet: Add DL coalescing
 statistics
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:10 +0000
Message-ID: <179162455062.434549.8200813403211201111@kernel.org>
In-Reply-To:
 <20261009084351.317632-8-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-8-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rmnet's new netdev_stat_ops does not follow the qstats
  contract.
- [Medium] In rmnet_map_segment_coal_skb() (rmnet_map_data.c:1166-1174),
  the standard HW-GRO counters are updated once per input MAPv5…
- [Medium] The new ethtool -S string 'Coal alloc packet drops'
  (coal_alloc_fail) duplicates a standard uAPI counter.
- [Medium] The comments and commit message misdescribe how far the new
  standard counters reach.
- [Medium] The standard qstats rx-alloc-fail counter is fed a packet
  count instead of a count of allocation failures.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  rmnet_vnd_init() (rmnet_vnd.c:121) allocates struct rmnet_pcpu_stats…

--

net: qualcomm: rmnet: Add DL coalescing statistics

This patch moves the rmnet private checksum counters into the per-CPU
u64_stats protected structure and adds DL coalescing counters. The
HW-GRO and allocation failure counters are exported through
netdev_stat_ops queue stats and rx_dropped through ndo_get_stats64. The
remaining counters are exported through ethtool -S.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
> index 5adda0323dda7..917d31f6eded7 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
> @@ -63,31 +63,105 @@ struct rmnet_vnd_stats {
>  	u32 tx_drops;
>  };
>  
> +struct rmnet_priv_stats {
> +	/* Network stack RX statistics for all rmnet receive paths */
> +	u64 rx_hw_gro_packets;
> +	u64 rx_hw_gro_wire_packets;
> +	u64 rx_alloc_fail;
> +	u64 rx_dropped;

[Severity: Medium]
Is "all rmnet receive paths" accurate here? rx_dropped and rx_alloc_fail
are only written in __rmnet_map_segment_coal_skb().

Other RX drops on the same rmnet device leave both counters unchanged.
For example, rmnet_map_process_next_hdr_packet() has:

		if (skb_unclone(skb, GFP_ATOMIC))
			return -ENOMEM;

The coalescing header, packet count, bounds and IP/transport validation
failures also return an error. In each case __rmnet_map_ingress_handler()
then does:

		if (rmnet_map_process_next_hdr_packet(skb, &list, len, data_format))
			goto free_skb;

so the whole frame is freed and the standard counters do not change. The
alloc_skb() failure in rmnet_map_deaggregate() happens before the rmnet
device is known, so that one is harder to attribute. The skb_unclone()
and validation paths already have skb->dev set to the rmnet device.

There is also a mismatch with the commit message, which says:

  Expose these standard RX statistics through netdev_stat_ops:
  ...
  - RX drops for reconstructed packets discarded by rmnet

and with rmnet_get_ethtool_stats(), which says:

	/* The first four fields are reported through netdev queue statistics. */

In the code, rmnet_get_queue_stats_rx() reports three fields, and
rx_dropped is reported only through rmnet_get_stats64().

Could the comments and the commit message be updated to match what the
code does?

[ ... ]

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index e8adb40067175..74d64b7066e2b 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c

[ ... ]

> @@ -675,12 +732,29 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,

[ ... ]

>  	skbn = alloc_skb(hlen + dlen + RMNET_MAP_DEAGGR_HEADROOM, GFP_ATOMIC);
> -	if (!skbn)
> +	if (!skbn) {
> +		u64_stats_update_begin(&pcpu_ptr->syncp);
> +		/* The coal counter is the coalescing subset of the standard
> +		 * allocation failure and RX drop counters.
> +		 */
> +		u64_stats_add(&pcpu_ptr->priv_stats.rx_alloc_fail, coal_meta->pkt_count);

[Severity: Medium]
Should rx_alloc_fail be incremented by coal_meta->pkt_count here? The
whole segment uses a single alloc_skb() call, and netdev.yaml defines
rx-alloc-fail as:

  Number of times skb or buffer allocation failed on the Rx datapath.

As written, one failed allocation for a multi-packet segment shows up as
up to RMNET_MAP_V5_MAX_PACKETS failures in stats->alloc_fail, which
rmnet_get_queue_stats_rx() reports.

Would u64_stats_inc() be the right update for rx_alloc_fail, with the
packet count kept for rx_dropped and coal_alloc_fail?

> +		u64_stats_add(&pcpu_ptr->priv_stats.rx_dropped, coal_meta->pkt_count);
> +		u64_stats_add(&pcpu_ptr->priv_stats.coal_alloc_fail, coal_meta->pkt_count);
> +		u64_stats_update_end(&pcpu_ptr->syncp);
>  		goto next_pkt;
> +	}

[ ... ]

> @@ -1014,6 +1163,16 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
>  	if (total_pkts > 1 && (!rxcsum || !gro_hw))
>  		return -EINVAL;
>  
> +	if (gro && total_pkts > 1) {
> +		/* Standard counters cover delivered HW-GRO skbs. coal_rx and
> +		 * coal_pkts cover coalescing input regardless of HW-GRO.
> +		 */
> +		u64_stats_update_begin(&pcpu_ptr->syncp);
> +		u64_stats_inc(&pcpu_ptr->priv_stats.rx_hw_gro_packets);
> +		u64_stats_add(&pcpu_ptr->priv_stats.rx_hw_gro_wire_packets, total_pkts);
> +		u64_stats_update_end(&pcpu_ptr->syncp);
> +	}

[Severity: Medium]
These counters go up once per input coalescing frame, before the driver
knows how the frame will be delivered. The comment says they cover
delivered HW-GRO skbs. However, only rmnet_map_coal_gro_fast_path()
delivers a single aggregate, and only when num_nlos == 1 and
MAPV5_COALINFO_CSUM_VALID_FLAG is set.

In the other cases, rmnet_map_coal_segment_loop() flushes at every NLO
boundary. It also splits around each packet that has a checksum error
bit and drops that packet. __rmnet_map_segment_coal_skb() only
GSO-stamps a segment when pkt_count > 1.

Some examples:

- Three NLOs with one packet each are counted as 1 HW-GRO packet and 3
  wire packets, but no GSO skb is delivered.

- One NLO of 10 packets with CSUM_VALID clear and two error bits is
  counted as 1 and 10. Up to 3 GSO skbs are delivered, and the 2 dropped
  packets are also counted in rx_dropped.

- Segments that hit an alloc_skb() failure in
  __rmnet_map_segment_coal_skb() have already been counted as HW-GRO.

Would it be more accurate to update rx_hw_gro_packets and
rx_hw_gro_wire_packets where a GSO-stamped skb is actually queued, i.e.
in the fast path and in __rmnet_map_segment_coal_skb()?

[ ... ]

> @@ -1101,16 +1348,23 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,

[ ... ]

>  	switch (rmnet_map_get_next_hdr_type(skb)) {
>  	case RMNET_MAP_HEADER_TYPE_COALESCING:
>  		if (!(data_format & RMNET_FLAGS_INGRESS_COALESCE))
>  			return -EINVAL;
>  
> +		/* coal_rx counts coalescing input, not delivered HW-GRO skbs. */
> +		u64_stats_update_begin(&pcpu_ptr->syncp);
> +		u64_stats_inc(&pcpu_ptr->priv_stats.coal_rx);
> +		u64_stats_update_end(&pcpu_ptr->syncp);

[Severity: Low]
This issue is pre-existing and was not introduced by this patch.
rmnet_vnd_init() allocates the per-CPU stats with plain alloc_percpu()
and never calls u64_stats_init() on any CPU's syncp:

	priv->pcpu_stats = alloc_percpu(struct rmnet_pcpu_stats);

On 32-bit SMP kernels with CONFIG_DEBUG_LOCK_ALLOC,
u64_stats_update_begin() calls write_seqcount_begin() on a zeroed
dep_map that has no key. lockdep then prints "INFO: trying to register
non-static key" and turns itself off.

The existing writers in rmnet_vnd_rx_fixup() and rmnet_vnd_tx_fixup()
already hit this. This patch adds many more writers on the same syncp
in the RX coalescing, RX checksum and TX checksum paths. Torn-read
protection still works, since a zeroed seqcount is valid. Only lockdep
is affected.

Since this code is being reworked anyway, would it make sense to call
u64_stats_init() for each possible CPU, or to use
netdev_alloc_pcpu_stats()?

[ ... ]

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index b8542d2f03b23..d76af4788243b 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c

[ ... ]

> @@ -167,8 +173,45 @@ static void rmnet_get_stats64(struct net_device *dev,

[ ... ]

> +static void rmnet_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{

[ ... ]

> +	stats->hw_gro_packets = total_stats.rx_hw_gro_packets;
> +	stats->hw_gro_wire_packets = total_stats.rx_hw_gro_wire_packets;
> +	stats->alloc_fail = total_stats.rx_alloc_fail;
> +}
> +
> +static const struct netdev_stat_ops rmnet_stat_ops = {
> +	.get_queue_stats_rx = rmnet_get_queue_stats_rx,
> +};

[Severity: Medium]
rmnet_get_queue_stats_rx() never uses idx, so every RX queue reports the
device-wide totals. netdev_nl_stats_by_queue() calls it once for each
index below real_num_rx_queues:

	while (ops->get_queue_stats_rx && i < netdev->real_num_rx_queues) {

rmnet_link_ops has no get_num_rx_queues, so the queue count comes from
IFLA_NUM_RX_QUEUES (for example "ip link add ... numrxqueues 4 type
rmnet"). In that case each queue reports the same totals, and the sum
over all queues is N times the real value.

Separately, rmnet_stat_ops does not set .get_base_stats, and
netdev_nl_stats_by_netdev() returns early in that case:

	if (!netdev->stat_ops->get_base_stats)
		return 0;

As a result, does the default netdev-scope qstats-get dump report
nothing for rmnet? Since these counters are not tracked per queue,
would reporting them from .get_base_stats fit the qstats model better?

[ ... ]

> @@ -192,8 +235,34 @@ static const char rmnet_gstrings_stats[][ETH_GSTRING_LEN] = {
>  	"Checksum skipped",
>  	"Checksum computed in software",
>  	"Checksum computed in hardware",
> +	/* DL coalescing */
> +	"Coal alloc packet drops",

[Severity: Medium]
This counter looks like it will always equal the standard alloc_fail.
rx_alloc_fail is written in only one place, in
__rmnet_map_segment_coal_skb(), right next to coal_alloc_fail:

		u64_stats_add(&pcpu_ptr->priv_stats.rx_alloc_fail, coal_meta->pkt_count);
		u64_stats_add(&pcpu_ptr->priv_stats.rx_dropped, coal_meta->pkt_count);
		u64_stats_add(&pcpu_ptr->priv_stats.coal_alloc_fail, coal_meta->pkt_count);

rmnet_get_queue_stats_rx() already exports rx_alloc_fail as qstats
alloc_fail. Is a separate ethtool -S entry needed for the same value?

The commit message says the ethtool stats are kept for "diagnostics that
have no standard representation". Its list does not include
coal_alloc_fail, or coal_rx, coal_pkts, coal_csum_err and
coal_csum_drop.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com
