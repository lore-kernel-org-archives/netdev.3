Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFD25B08A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896716; cv=none; b=FkVeXjVHUBEeMZlsldqnvD6QiIX3KVtgQFvCcMmPWiTD+LOAfs82kCuUFDbtzSsogUZqdwCwkLeZ0qnjEZxR/nr6l9zy1S5soUbLCbxo/+zNEsrJkuCZMXon4t+RLerHDbccFQLd8ayjgdzivoa78h9jW+mtITGV2zK2HrPaopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896716; c=relaxed/simple;
	bh=VlzpfeHLC95SasDYWLYq8h28/wLCrp8rNInmJ8kHnww=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGFJ/eJwIGjecDbpdlEXWk92bU8ojaw2564nbNFajjJija8c3RK484aV4ZjILkScdct08SmvYGyrRSt32DSHMygjuG+KlvQecB1rV2gJ5rK+qYy+CNqqu1Mu3tt8yLeheGR7p41nFnvhcE+y3nOgG1x2F/IJvV7/YIGLA0r3Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGjv19P5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGjv19P5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A8F1F000FF;
	Thu,  1 Oct 2026 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896714;
	bh=9gxZsqxIeJkoHh5DqC/rqEjAPzBQvO57+xhzgYdemZc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SGjv19P5MLfNKoswl3pPhdZnfGMf+aRY9zGW8PbSU3+g2E48TbPbfAOnbvkWc+V5k
	 /q9VYfQkuQET3ZjN0LeVNj4nwKdqiC2Gm8r4UYfIApv5PbPRSZUqurhD2E8eqg95di
	 Jp3hSjjH2DsoQMt/VbWLGG1Z6ughGP8lkbh4stQd1HOlt7sXruUZ8dzhzQEOEGUmGy
	 9HaSxWiKCWi/icsJwYDxokNC6eJ8q+rodHAM2hXFMbexs5A9TVUcpuB/3z3vDHSDBR
	 4s+ROoo1ps9/J14Snu6XEpvSpNHjFzhlQXlrAWrmoyEoAaGOQMSm/a8t1jIfPgQrvg
	 QCB3bZm/1R6YQ==
Subject:
 Re: [PATCH net] net: bcmasp: fix lost TX wakeup race with lockless queue API
From: netdev-bot+sashiko@kernel.org
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
Date: Thu, 01 Oct 2026 23:18:33 +0000
Message-ID: <179089671349.434549.3633307733239264894@kernel.org>
In-Reply-To: <20260928201816.3935530-1-justin.chen@broadcom.com>
References: <20260928201816.3935530-1-justin.chen@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  bcmasp_xmit() the dma_mapping_error() unwind leaks DMA mappings.
- [Medium] This problem wasn't introduced by this patch, but TX and RX
  update the same seqcount (intf->stats64.syncp) without being mutually…

--

net: bcmasp: fix lost TX wakeup race with lockless queue API

This patch moves bcmasp TX flow control from netif_stop_queue() and
netif_wake_queue() to the lockless netif_txq_maybe_stop() and
netif_txq_completed_wake() helpers, which also adds BQL accounting.
tx_spb_ring_full() is replaced by a live bcmasp_tx_avail() count.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index f2176ef3a127..00e39a230676 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c

[ ... ]

> @@ -241,16 +239,18 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)

[ ... ]

>  	nr_frags = skb_shinfo(skb)->nr_frags;
>  
> -	if (tx_spb_ring_full(intf, nr_frags + 1)) {
> -		netif_stop_queue(dev);
> +	if (unlikely(bcmasp_tx_avail(intf) < nr_frags + 1)) {
> +		netif_tx_stop_queue(txq);
>  		if (net_ratelimit())
>  			netdev_err(dev, "Tx Ring Full!\n");
>  		return NETDEV_TX_BUSY;

[Severity: High]
Can the lost wakeup still happen through this ring-full pre-check in
bcmasp_xmit()?

This path still calls a bare netif_tx_stop_queue() and returns
NETDEV_TX_BUSY. After it sets __QUEUE_STATE_DRV_XOFF there is no
smp_mb__after_atomic() and no second look at bcmasp_tx_avail(). Only the
stop at the end of bcmasp_xmit() was converted to netif_txq_maybe_stop().

The pre-check looks reachable. include/net/netdev_queues.h says:

    The macros guarantee that rings will not remain stopped if there's
    space available, but they do *not* prevent false wake ups when the
    ring is full! Drivers should check for ring full at the start for
    the xmit handler.

In bcmasp_tx_poll()->netif_txq_completed_wake(), bcmasp_tx_avail() reads
tx_spb_index before netif_tx_queue_stopped() is checked. A stale producer
index can therefore wake the queue while the ring is nearly full. The next
bcmasp_xmit() with enough frags then takes this branch, and this can
happen:

CPU0 (bcmasp_xmit)                  CPU1 (bcmasp_tx_poll)
bcmasp_tx_avail() < nr_frags + 1
                                    bcmasp_tx_reclaim() frees the rest
                                    netif_txq_completed_wake()
                                      smp_mb()
                                      queue not stopped, no wake
netif_tx_stop_queue(txq)
return NETDEV_TX_BUSY

That looks like the same window the commit message describes as "a
reclaim landing between the ring-full check and the stop call".

After this, no descriptors are in flight, so no TX interrupt comes to wake
the queue. bcmasp_tx_timeout() only does:

    intf->mib.tx_timeout_cnt++;

so TX would stay stuck until the interface is restarted.

Could this branch use the stop/re-check protocol, as bnxt_start_xmit()
does? For example:

    if (!netif_txq_try_stop(txq, bcmasp_tx_avail(intf),
                            BCMASP_TX_START_THRS))
        return NETDEV_TX_BUSY;

[ ... ]

> @@ -333,15 +333,17 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 */
>  	wmb();

[Severity: Medium]
This isn't a bug introduced by this patch, but does the dma_mapping_error()
unwind in the descriptor loop just above leak the DMA mappings that already
succeeded?

bcmasp_xmit() {
    ...
		if (dma_mapping_error(kdev, mapping)) {
			intf->mib.tx_dma_failed++;
			spb_index = intf->tx_spb_index;
			for (j = 0; j < i; j++) {
				bcmasp_clean_txcb(intf, spb_index);
				spb_index = incr_ring(spb_index,
						      DESC_RING_COUNT);
			}
			/* Rewind so we do not have a hole */
			spb_index = intf->tx_spb_index;
			dev_kfree_skb(skb);
			return NETDEV_TX_OK;
		}
    ...
}

bcmasp_clean_txcb() only clears txcb->skb, dma_addr, dma_len and last. It
never calls dma_unmap_single() or dma_unmap_page().

If skb_frag_dma_map() fails for a fragment with i > 0, the linear head
(mapped with dma_map_single()) and frags 1..i-1 stay mapped, and then the
skb is freed.

Can this leak IOVA or swiotlb slots and leave DMA_TO_DEVICE mappings that
point at freed memory?

[ ... ]

> @@ -423,6 +427,9 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
>  			u64_stats_inc(&stats->tx_packets);
>  			u64_stats_add(&stats->tx_bytes, txcb->bytes_sent);
>  			u64_stats_update_end(&stats->syncp);

[Severity: Medium]
This is a pre-existing issue, but can the TX and RX paths write
intf->stats64.syncp at the same time?

bcmasp_tx_reclaim() updates tx_packets and tx_bytes under stats->syncp.
bcmasp_rx_poll() updates rx_packets and rx_bytes under the same syncp:

bcmasp_rx_poll() {
    ...
		u64_stats_update_begin(&stats->syncp);
		u64_stats_inc(&stats->rx_packets);
		u64_stats_add(&stats->rx_bytes, len);
		u64_stats_update_end(&stats->syncp);
    ...
}

These run from separate NAPI instances. In bcmasp_netif_deinit(),
bcmasp_tx_reclaim() runs in process context while rx_napi is still active:

bcmasp_netif_deinit() {
	napi_disable(&intf->tx_napi);
	...
	bcmasp_tx_reclaim(intf, NULL);
	...
	bcmasp_enable_rx(intf, 0);

	napi_disable(&intf->rx_napi);
    ...
}

The two writers can also overlap at runtime with threaded NAPI, or when
IRQ affinity changes while one NAPI is still repolling.

u64_stats_sync writers have to be mutually exclusive on 32-bit kernels,
and ARCH_BRCMSTB includes arm. Could this let bcmasp_get_stats64() read
torn counters?

If both writers hit the sequence increment at the same moment, could one
increment be lost and the sequence left odd? Readers would then spin in
u64_stats_fetch_begin().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928201816.3935530-1-justin.chen%40broadcom.com
