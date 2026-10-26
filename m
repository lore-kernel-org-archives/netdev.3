Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018652;
	b=h9apQfvNYe0Ho3AUuLpfwsEBtn82mW6oezoh9/rOcIFHRIwOHsHZKzv+wPShx1zeH1Yj
	 BpTwhBItLV129ZUph8f01SurUEfyooUPM6zBE78bR8QTgv+AeIqcyEisf9A4X9qpakjjn
	 mZbUxMtMjnm0zv4L8MZPLKnHlVTJ5zqkvkguPuNA8nXETFQBChE2bwqiu6u2l2Asdo+7C
	 O4PI9qYxrPwuQ/YCX5XM2IRhIOOcsKiaZadfu9mKr58AfpH6Fjlxk4iLhxSI7dQ5AnYn7
	 WdqqiqDaFPECPbYDmpj29GOIGp4nWRwkAD0hB+9X7gIxheBWKEvcYc4bc8bnGoqOzIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018652;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9THOll05jd1Z8uOdYQGQyK9LOXHpEwQd2xuYAvHMsOI=;
	b=r+FReDPFB0ft04iPLKoQETnVC8w0f2/YagdxoPDLIDjSgXSd9Tcz/T6S7RWEq8avL8je
	 Rw2ZcFrnOeq6d++4FQjNGWOgvMfd8+U2fRVZ8inlVcKOpO+rUwdpVt7NKVz4ulHJt/xQM
	 chHNZaHOJAPyo9zope1lpfCGbhB+zwq9KXXtpm9xCaijGQjwq3LgL4j+ELpvP7wwKo/9L
	 sQLLTFMzWTkTT4A4YAFX4FOiJTQ0546+rlsvGydowEDFkk+NuXHn0BN0lxBvWU1omnEbM
	 vuRwHnLnmlnvwh+aoEo74HLJmFCh9tQUsu10z1Ny82LaaZUyvPgt+5GILx6oN6B+PbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyK7Md73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513F606A33C;
	Mon, 26 Oct 2026 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyK7Md73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5321D1F031E0;
	Mon, 26 Oct 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018651;
	bh=9THOll05jd1Z8uOdYQGQyK9LOXHpEwQd2xuYAvHMsOI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RyK7Md73laUpqkg60e08r+8qzbSlUZyIzM4NfumjiMMzvjs0sGnRoa9Xh7s+CIhCg
	 g+KTuN4lxjdKYT0ciCFcfUg/5hBDr9wnsvsHkPpHU4aDUvWZzp47qTj3BRKmKilMzl
	 cqOJT9A+5sQPoqXXwwRXL7Dx2Yv67UE0GXv01ejOZytAM85q9YUrxLg/xkQay9yF3K
	 2d37UgVFhAC7xXDgwtXPcKzyTAanOQZPhnSIO16mrC6nl743OEOP3Teyl5Swmb2iON
	 4a9ON8mLwLAIj24WHWoa+jK3mqprAXuho0RCvdA/XDF2iFCZMnTlJBfxscJBwC/uta
	 KFDFY/oIScUVA==
Subject:
 Re: [PATCH net-next v18 3/4] hinic3: Add Add per queue netdev-genl stats
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
Date: Mon, 26 Oct 2026 12:44:09 +0000
Message-ID: <179301864989.3134.6585576685337889005@kernel.org>
In-Reply-To:
 <b241adb884df2f371ff5399e3be86199eed35250.1792671176.git.gongfan1@huawei.com>
References:
 <b241adb884df2f371ff5399e3be86199eed35250.1792671176.git.gongfan1@huawei.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] hinic3_get_queue_stats_rx() and hinic3_get_queue_stats_tx()
  index &nic_dev->rxqs[i] and &nic_dev->txqs[i] with the core-supplied…
- [Medium] hinic3_get_base_stats() calls memset(stats_rx, 0, ...) and
  memset(stats_tx, 0, ...) on the whole netdev_queue_stats_rx/tx structs.
- [Medium] hinic3_get_queue_stats_tx() reports txq_stats->busy as the
  qstat `stop` counter (stats_tx->stop = txq_stats->busy).
- [Medium] hinic3_get_base_stats() sums the inactive-queue history over
  [nic_dev->q_params.num_qps, nic_dev->max_qps).
- [Medium] hinic3_get_queue_stats_rx() reports stats_rx->alloc_fail =
  rxq_stats->alloc_fail per queue.
- [Medium] The per-queue qstats packets/bytes exported by
  hinic3_get_queue_stats_tx() and hinic3_get_queue_stats_rx() count skbs…
- [Low] The commit message has no body, and the subject has a typo:
  "hinic3: Add Add per queue netdev-genl stats".

--

hinic3: Add Add per queue netdev-genl stats

This commit adds netdev_stat_ops to the hinic3 driver. It implements
get_queue_stats_rx, get_queue_stats_tx and get_base_stats, so per-queue
and device-level counters are exported through the netdev-genl qstats
interface.

> hinic3: Add Add per queue netdev-genl stats

[Severity: Low]
This isn't a bug, but "Add" appears twice in the subject line.

The commit message also has no body. This patch adds new uAPI-visible
qstats output. Could the message describe how the driver counters map onto
the standard attributes (busy to tx-stop, csum_errors to rx-csum-bad,
alloc_fail to rx-alloc-fail)?

It could also say that get_base_stats treats queues in
[q_params.num_qps, max_qps) as the inactive range and zero-fills every
qstat field.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index c71bb3dff39c3..10364c4dc11f9 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c

[ ... ]

> @@ -866,7 +867,80 @@ static const struct net_device_ops hinic3_netdev_ops = {
>  	.ndo_start_xmit       = hinic3_xmit_frame,
>  };
>  
> +static void hinic3_get_queue_stats_rx(struct net_device *netdev, int i,
> +				      struct netdev_queue_stats_rx *stats_rx)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_rxq_stats *rxq_stats;
> +	struct hinic3_rxq *rxq;
> +	unsigned int start;
> +
> +	rxq = &nic_dev->rxqs[i];

[Severity: High]
Can i go past the end of nic_dev->rxqs[] here?

hinic3_alloc_rxqs() allocates nic_dev->rxqs with max_qps entries. The core,
however, calls this callback for every i below
netdev->real_num_rx_queues.

At probe, real_num_*_queues comes from hinic3_func_max_qnum():

hinic3_main.c:hinic3_nic_probe() {
    ...
    max_qps = hinic3_func_max_qnum(hwdev);
    netdev = alloc_etherdev_mq(sizeof(*nic_dev), max_qps);
    ...
}

After that, hinic3_sw_init()->hinic3_try_to_enable_rss() can shrink
max_qps to 1 when alloc_rss_resource() or hinic3_set_hw_rss_parameters()
fails:

hinic3_rss.c:hinic3_try_to_enable_rss() {
    ...
    err = alloc_rss_resource(netdev);
    if (err) {
        nic_dev->max_qps = 1;
        goto err_reset_q_params;
    }
    ...
}

Only hinic3_vport_up() lowers real_num_*_queues, and only on a successful
open. A device-scope dump before the first successful open (or after opens
that fail before hinic3_vport_up()) still does this:

netdev_nl_stats_by_netdev()
    netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
                          0, netdev->real_num_tx_queues, &tx_sum);

There is no netdev->up check on this path, so i runs from 1 to
func_max_qnum - 1 against a one-entry array.

Would this read past the end of the rxqs and txqs slab objects and return
those values to user space? NETDEV_CMD_QSTATS_GET does not require
GENL_ADMIN_PERM, so any local user can issue it.

The same applies to nic_dev->txqs[i] in hinic3_get_queue_stats_tx().
Before this patch hinic3 had no stat_ops, and hinic3_get_stats64() bounds
its loops by max_qps.

> +	rxq_stats = &rxq->rxq_stats;
> +	do {
> +		start = u64_stats_fetch_begin(&rxq_stats->syncp);
> +		stats_rx->bytes = rxq_stats->bytes;
> +		stats_rx->packets = rxq_stats->packets;

[Severity: Medium]
netdev.yaml defines rx-packets as "Number of wire packets successfully
received and passed to the stack." Do these counters still match that when
hardware LRO is active?

hinic3_rx_poll() counts one packet per CQE:

hinic3_rx.c:hinic3_rx_poll() {
    ...
        nr_pkts++;
        rx_bytes += pkt_len;
        num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
    ...
}

NUM_LRO gives the number of wire packets that were merged, and the skb gets
gso_segs = num_lro.

The tx side in hinic3_get_queue_stats_tx() looks similar. It counts once
per skb, right after the doorbell rather than at DMA completion:

hinic3_tx.c:hinic3_send_one_skb() {
    ...
    txq->txq_stats.bytes += skb->len;
    txq->txq_stats.packets += 1;
    ...
}

TSO/TSO6 is enabled by default when HINIC3_NIC_F_TSO is reported. One skb
then usually covers gso_segs wire frames, and the replicated headers are
missing from the byte count.

Would rx-packets/rx-bytes and tx-packets/tx-bytes undercount wire traffic
whenever TSO or LRO is active? The existing ndo_get_stats64 use did not
have this wire-packet requirement.

> +		stats_rx->csum_bad = rxq_stats->csum_errors;
> +		stats_rx->alloc_fail = rxq_stats->alloc_fail;
> +	} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
> +}
> +
> +static void hinic3_get_queue_stats_tx(struct net_device *netdev, int i,
> +				      struct netdev_queue_stats_tx *stats_tx)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_txq_stats *txq_stats;
> +	struct hinic3_txq *txq;
> +	unsigned int start;
> +
> +	txq = &nic_dev->txqs[i];
> +	txq_stats = &txq->txq_stats;
> +	do {
> +		start = u64_stats_fetch_begin(&txq_stats->syncp);
> +		stats_tx->bytes = txq_stats->bytes;
> +		stats_tx->packets = txq_stats->packets;
> +		stats_tx->stop = txq_stats->busy;

[Severity: Medium]
Is busy the right counter to report as tx-stop?

In hinic3_send_one_skb(), busy is only incremented in the NETDEV_TX_BUSY
fallback, when hinic3_wq_free_wqebbs() < wqebb_cnt:

hinic3_tx.c:hinic3_send_one_skb() {
    ...
        netif_subqueue_try_stop(netdev, txq->sq->q_id, ...);
        u64_stats_update_begin(&txq->txq_stats.syncp);
        txq->txq_stats.busy++;
        u64_stats_update_end(&txq->txq_stats.syncp);
        return NETDEV_TX_BUSY;
    ...
}

The normal stop happens on the success path, and no counter is updated
there:

    netif_subqueue_maybe_stop(netdev, txq->sq->q_id,
                              hinic3_wq_free_wqebbs(&txq->sq->wq),
                              txq->tx_stop_thrs,
                              txq->tx_start_thrs);

The fallback also increments busy even when netif_subqueue_try_stop() has
re-woken the queue.

netdev.yaml defines tx-stop as "Number of times driver paused accepting new
tx packets from the stack to this queue, because the queue was full."
Would tx-stop miss most real queue stops here, and count some events that
were not stops? tx-wake is not reported either.

> +	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
> +}
> +
> +static void hinic3_get_base_stats(struct net_device *netdev,
> +				  struct netdev_queue_stats_rx *stats_rx,
> +				  struct netdev_queue_stats_tx *stats_tx)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int i;
> +
> +	memset(stats_rx, 0, sizeof(*stats_rx));
> +	memset(stats_tx, 0, sizeof(*stats_tx));

[Severity: Medium]
Does zeroing the whole structs here report counters that hinic3 never
collects?

netdev_nl_stats_by_netdev() pre-fills the sums with the NOT_SET sentinel.
It relies on get_base_stats to touch only the fields the driver supports:

    memset(&rx_sum, 0xff, sizeof(rx_sum));
    memset(&tx_sum, 0xff, sizeof(tx_sum));

    netdev->stat_ops->get_base_stats(netdev, &rx_sum, &tx_sum);

The kdoc for struct netdev_stat_ops in include/net/netdev_queues.h says:

 * Only statistics which are set in @get_base_stats will be reported
 * at the device level, ...
 * This is because @get_base_stats has a second function of designating which
 * statistics are in fact correct for the entire device ...

With this memset, fields such as rx-hw-drops, rx-csum-complete,
rx-hw-gro-*, tx-hw-drops, tx-needs-csum, tx-hw-gso-* and tx-wake become
valid zeros. Per-queue NOT_SET values are skipped when summing, so every
device-scope dump reports these fields as a constant 0.

Could this function set only the fields hinic3 actually collects (bytes,
packets, csum_bad, alloc_fail, stop), as other drivers do?

> +
> +	for (i = nic_dev->q_params.num_qps; i < nic_dev->max_qps; i++) {

[Severity: Medium]
Can this range overlap the live-queue range that the core sums?

The core sums [0, netdev->real_num_*x_queues) itself, and
netdev_stat_queue_sum() documents the base range as
[real_num_*x_queues, num_*x_queues). The lower bound here is
q_params.num_qps instead, and it can drift away from real_num_*_queues.

hinic3_open()->hinic3_setup_num_qps()->hinic3_config_num_qps() can lower
num_qps when there are not enough IRQs:

    if (alloc_num_irq < q_params->num_qps) {
        q_params->num_qps = alloc_num_irq;

real_num_*_queues is only synced later, in hinic3_vport_up():

    err = netif_set_real_num_queues(netdev, nic_dev->q_params.num_qps,
                                    nic_dev->q_params.num_qps);

Suppose one of these fails in between: hinic3_alloc_channel_resources(),
hinic3_open_channel(), hinic3_set_vport_enable() or
hinic3_maybe_set_port_state(). No error path restores num_qps, so it stays
at the lower value M while real_num_*_queues keeps the old value N.

Would queues [M, N) then be counted twice in every device-level query,
once here and once in the core sum? Those queues still hold counters from
earlier opens, since stats are only reset at probe. That would inflate
bytes, packets, csum_bad and stop.

> +		struct netdev_queue_stats_rx rx = {0};
> +
> +		hinic3_get_queue_stats_rx(netdev, i, &rx);
> +		stats_rx->bytes += rx.bytes;
> +		stats_rx->packets += rx.packets;
> +		stats_rx->csum_bad += rx.csum_bad;
> +	}

[Severity: Medium]
Is rx.alloc_fail meant to be dropped here?

hinic3_get_queue_stats_rx() reports alloc_fail per queue, and the memset
above marks stats_rx->alloc_fail as a valid device total. This loop,
however, only adds up bytes, packets and csum_bad.

When num_qps is lowered (for example by hinic3_config_num_qps() on an IRQ
shortage), allocation failures recorded on the now-inactive queues would
drop out of the device-level rx-alloc-fail. Bytes, packets and csum_bad
keep their history, because rxq_stats is only cleared at probe by
hinic3_rxq_stats_init().

Should this loop also do stats_rx->alloc_fail += rx.alloc_fail?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792671176.git.gongfan1%40huawei.com
