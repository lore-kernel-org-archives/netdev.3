Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28321496D3D;
	Sat, 10 Oct 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633355; cv=none; b=BDucN4cT65EzToMkDNJ1Dv+tfXGJy7yNRrjKwqPJdVGYfqI4U99WxoY0TMmILRL9zV9SRgcKaUuqr+tSjD30fb6WOX/8/6hz5pztrZmXazrrkJ9p6NMWM6fETjJpTA9g+nF79rrTcxewW6u0AessDgPmzXBOYHbNgROkT1N/lgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633355; c=relaxed/simple;
	bh=hLt1kN+v++LERGolIil3zVgHjDPIsbkbHJvcCxPOm/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgTRsHyUIV5Tgf+geG84XaMCNRbz/H5wfM312oHVdDIwdzjI0snnqoqNTSpW5xoozwVtmX8qMKpDhhfkwzNJ/DPXb+XjKATNKahUJd9c14T9GqeCsa94LWDLmXUqRfdskOX4o8WSrXh7Wv6d8jQI/StgL4ZRbi9MP+Qgga0j27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSkULGJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSkULGJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EF91F00898;
	Sat, 10 Oct 2026 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633347;
	bh=0kQcUPDmcbyhjzCBKf8tF82Z2HjQ1YjSAwJ5NLJ+ehI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MSkULGJnNIcjpmplQHQYI9OcY9VF5zfis3kCl+T7sEqTg/9cfdx03my53enxjkp6p
	 xBDuHDkxravpYoCPJCfcKj7pjRbBujVG/kBPH0dM9zSaUvnGVw/M+wbrQ2M5bK+7tB
	 Ty+aBc//BuZcemjSl/ANy3JE0rsxC93UUKwwTkGjkAC2wASVJdMql+hDd4tDc9jzs+
	 xHbRRi6DV0eFmnapQaBkxoM96hQcfm587y4egzYVvgpelK62fTJWkqcj70skiAzp9k
	 Qyc0jN2pIi2wh5vX+wx9LMFaJu01pw1GLOWJfFaN9fLan9/n12rqIUTh0Hi8XVk9vW
	 VzsGWRc+n6vhg==
Subject: Re: [PATCH net-next v4 6/6] net: xilinx: axienet: Add statistics
 support for XXV ethernet
From: netdev-bot+sashiko@kernel.org
To: suraj.gupta2@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 11:55:46 +0000
Message-ID: <179163334620.434549.1592021934536887221@kernel.org>
In-Reply-To: <20261006110550.1990213-7-suraj.gupta2@amd.com>
References: <20261006110550.1990213-7-suraj.gupta2@amd.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The driver uses PG210 STAT_RX_BAD_FCS (0x8C0) as its only RX
  FCS-error source.
- [Low] The new 'final snapshot' block in axienet_stop() only checks `if
  (lp->axienet_config->stats_update)`.
- [Low] The struct axienet_local kernel-doc is out of date.
- [Low] The kernel-doc for axienet_xxv_get_rmon_stats() says '@ranges:
  Set to the RMON histogram range table', but the function always sets…
- [Low] The 'Throwaway tick to drain pre-open counts so stats start from
  zero' in axienet_xxv_probe_init() does not achieve what its comment…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new XXV
  readers inherit it.

--

net: xilinx: axienet: Add statistics support for XXV ethernet

This commit adds statistics support for the XXV (10G/25G) MAC in the
axienet driver. The driver writes TICK_REG to latch the PG210
clear-on-tick counters and adds each interval's values to
xxv_stat_base[] in software. These accumulators feed ndo_get_stats64()
and the ethtool -S, pause, MAC and RMON callbacks.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 7ba2fe29e97bf..e8e9732c1c84f 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -549,6 +549,7 @@ struct skbuf_dma_descriptor {
>   * @rx_ring_head: RX skb ring buffer head index.
>   * @rx_ring_tail: RX skb ring buffer tail index.
>   * @xxv_ip_version: XXV IP version.
> + * @xxv_stat_base: Software accumulators for the XXV clear-on-tick counters.

[Severity: Low]
This isn't a bug, but should the @hw_stats_seqcount kernel-doc be updated
too? It still reads:

 * @hw_stats_seqcount: Sequence counter for @hw_stat_base, @hw_last_counter,
 *                     and @reset_in_progress.

axienet_xxv_stats_update() now writes xxv_stat_base[] inside the
hw_stats_seqcount write section. All of the XXV getters read it under
read_seqcount_begin()/read_seqcount_retry().

The new @xxv_stat_base line doesn't say what protects it either.

>   * @axienet_config: MAC-type specific configuration and operations.
>   */
>  struct axienet_local {

[ ... ]

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index f4b054433df95..cbc8caf781f3d 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

[ ... ]

> @@ -1789,6 +1802,13 @@ static int axienet_stop(struct net_device *ndev)
>  	lp->axienet_config->setoptions(ndev, lp->options &
>  				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
>  
> +	/* Final snapshot after RX/TX is disabled, so no frames are missed. */
> +	if (lp->axienet_config->stats_update) {
> +		mutex_lock(&lp->stats_lock);
> +		lp->axienet_config->stats_update(lp);
> +		mutex_unlock(&lp->stats_lock);
> +	}

[Severity: Low]
Should this check lp->features & XAE_FEATURE_STATS?

axienet_1g_config always sets .stats_update = axienet_1g_stats_update, but
the statistics block is optional on 1G:

axienet_1g_probe_init() {
	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
		lp->features |= XAE_FEATURE_STATS;
}

So on a 1G core built without the statistics block, every ifdown now reads
XAE_STATS_OFFSET registers that the core doesn't implement.
__axienet_device_reset() and the stats export callbacks all check
XAE_FEATURE_STATS before reading these registers.

axienet_refresh_stats() is also missing this check, but that was already
true before this patch.

This also changes 1G behaviour. On the 1G dmaengine path it adds a new
register read at stop. On the 1G non-dmaengine path it repeats the
axienet_stats_update(lp, true) that
axienet_dma_stop()->__axienet_device_reset() already does a few lines
later.

The commit message describes the patch as XXV-only. Could it mention the
1G change, or could this snapshot be limited to the MACs that need it?

> +
>  	if (!lp->use_dmaengine) {
>  		axienet_dma_stop(lp);
>  		cancel_work_sync(&lp->dma_err_task);
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
> index 9f7efab84f827..4a2d03b6c480d 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c

[ ... ]

> @@ -134,6 +199,10 @@ static void axienet_xxv_setoptions(struct net_device *ndev, u32 options)
>  static void axienet_xxv_probe_init(struct axienet_local *lp)
>  {
>  	lp->xxv_ip_version = axienet_ior(lp, XXV_CONFIG_REVISION);
> +	lp->features |= XAE_FEATURE_STATS;
> +
> +	/* Throwaway tick to drain pre-open counts so stats start from zero. */
> +	axienet_iow(lp, XXV_TICKREG_OFFSET, XXV_TICKREG_STATEN_MASK);

[Severity: Low]
Does this tick actually make the stats start from zero at open?

It runs only once, from axienet_probe()->probe_init, before any GT reset
or GTWIZ reset-done poll. axienet_xxv_poll_link_ready() says register
access should wait for that on IP v3.2+:

	/* Confirm XXV Ethernet is up: on IP v3.2+, wait for GT
	 * reset-done before further register access, then poll until
	 * RX PCS block lock is asserted.
	 */

Nothing between probe and the first ndo_open clears the RX/TX enables.
The first setoptions() call that clears TXEN/RXEN is in
axienet_device_reset() at open.

If the MAC comes out of reset with RX enabled, as the PG210
CONFIGURATION_RX_REG1 default suggests, frames received between probe and
the first open stay in the internal accumulators. The first stats_work
after open, queued by schedule_delayed_work(&lp->stats_work, 0) in
axienet_open(), would then latch them into xxv_stat_base[].

If the statistics clock domain isn't running yet at probe, this tick might
not latch anything at all.

Would it make more sense to drain on the open path, after GT reset-done
and before RX/TX are enabled and stats_work is armed? Later opens look less
affected, since axienet_stop() disables RX/TX and takes a final snapshot.

>  }
>  
>  /**
> @@ -308,6 +377,198 @@ static int axienet_10g25g_clk_init(struct axienet_local *lp)

[ ... ]

> +static void axienet_xxv_get_stats64(struct axienet_local *lp,
> +				    struct rtnl_link_stats64 *stats)
> +{
> +	unsigned int start;
> +	u64 tx_hw_errors;
> +
> +	do {
> +		start = read_seqcount_begin(&lp->hw_stats_seqcount);

[Severity: Medium]
This isn't a bug introduced by this patch, but the new XXV readers inherit
it.

hw_stats_seqcount is a seqcount_mutex_t associated with stats_lock (see
seqcount_mutex_init() in axienet_probe()). On PREEMPT_RT, a reader that
sees an odd sequence takes and drops the associated mutex:

include/linux/seqlock.h:SEQCOUNT_LOCKNAME() {
    ...
	if (preemptible && unlikely(seq & 1)) {
		__SEQ_LOCK(lockbase##_lock(s->lock));
		__SEQ_LOCK(lockbase##_unlock(s->lock));
    ...
}

axienet_xxv_get_stats64() is reached through dev_get_stats(). That can be
called under rcu_read_lock() (dev_seq_show() for /proc/net/dev) or under a
caller's spinlock (bond_get_stats()).

If such a read races with the write section in axienet_xxv_stats_update()
from stats_work or axienet_stop(), can the reader end up calling
mutex_lock() from atomic context on RT?

The 1G readers have used this seqcount the same way since before this
series. This patch adds more readers of the same kind.

> +		stats->rx_crc_errors = lp->xxv_stat_base[XXV_STAT_RX_BAD_FCS];
> +		/* Both in-range length errors and frame-too-long (oversize)
> +		 * frames are IEEE 802.3 length errors, so fold them together
> +		 * into rx_length_errors; rx_over_errors is reserved for receiver
> +		 * FIFO/ring overflow, which the XXV MAC does not expose.
> +		 */
> +		stats->rx_length_errors =
> +			lp->xxv_stat_base[XXV_STAT_RX_INRANGEERR] +
> +			lp->xxv_stat_base[XXV_STAT_RX_OVERSIZE];
> +		stats->rx_errors = lp->xxv_stat_base[XXV_STAT_RX_UNDERSIZE] +
> +				   lp->xxv_stat_base[XXV_STAT_RX_FRAGMENT] +
> +				   lp->xxv_stat_base[XXV_STAT_RX_JABBER] +
> +				   stats->rx_crc_errors +
> +				   stats->rx_length_errors;

[Severity: Medium]
Can rx_errors count fragment and jabber frames twice here?

XXV_STAT_RX_BAD_FCS_OFFSET is 0x8C0, which is stat_rx_bad_fcs in PG210. As
far as I can tell, that counter covers every received frame with a bad FCS,
whatever its length. It would then include fragments, which are also
counted in STAT_RX_FRAGMENT (0x8A0), and jabbers, which are also counted in
STAT_RX_JABBER (0x8B8).

Adding RX_FRAGMENT, RX_JABBER and rx_crc_errors together would then count
those frames twice.

The same counter also feeds FrameCheckSequenceErrors in
axienet_xxv_get_eth_mac_stats(). IEEE 802.3 aFrameCheckSequenceErrors
excludes too-short and too-long frames.

Would STAT_RX_PACKET_BAD_FCS (0x8C8, frames from 64 bytes up to the max
packet length) be a better source for both rx_crc_errors and
FrameCheckSequenceErrors?

> +		stats->multicast = lp->xxv_stat_base[XXV_STAT_RX_MULTICAST];

[ ... ]

> +/**
> + * axienet_xxv_get_rmon_stats - Fill RMON statistics and histogram ranges
> + * @lp: Pointer to the axienet_local structure
> + * @rmon_stats: Output ethtool_rmon_stats structure to populate
> + * @ranges: Set to the RMON histogram range table
> + */
> +static void axienet_xxv_get_rmon_stats(struct axienet_local *lp,
> +				       struct ethtool_rmon_stats *rmon_stats,
> +				       const struct ethtool_rmon_hist_range **ranges)
> +{

[ ... ]

> +	/* XXV currently exposes only aggregate RMON counters, not per-bin
> +	 * histogram buckets. Keep ranges NULL until histogram bins are wired.
> +	 */
> +	*ranges = NULL;

[Severity: Low]
This isn't a bug, but the @ranges kernel-doc says it is "Set to the RMON
histogram range table". The function always sets *ranges = NULL, and the
comment just above says to keep it NULL until histogram bins are wired.

Could the kernel-doc say that ranges is set to NULL?

> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006110550.1990213-1-suraj.gupta2%40amd.com
