Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0EF9C0
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060425; cv=none; b=fZsZE+JOh7R7CKvAxQb7e17EdzSpALzgIJu8AVMdn48FcDb6BX5B0m6f7IzDYlUNUsKIcmb4d5LvkIb403E9sQcdGiS0LP0UIOpW7oZ9CDOcJCKJCaAqyWfAR9vrkrsqOKIT4WIKFiC5m25cwMMFJ4hDRV+wrFj2y99031w/rSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060425; c=relaxed/simple;
	bh=PelXeydR42qVIsNb2VFj/IfacE/PO7OzZa/kC9lJEGM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1nH6M9VMI10krGh4kPhWSeI+KL7sY8i/h0q+VpZAINZcbMMd2TrFaWe8VcHQDm5hUeDuhWobQpOhKNTEXdvndifecjEi2hbIFmgm+UejjiAe0Coi00ZUez8jfJgcDJnrb0Dq78g7ksLROGybRapf2O5Hlra2XcI0CWfWhysQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlKoE1/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlKoE1/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7321F0089B;
	Sat,  3 Oct 2026 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791060423;
	bh=UBfpqOCkf4A0Np6kPyQFFXxr7Pn1MttthleHq/fPFXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HlKoE1/d+X7w/zinSDr3JeT0L3uRXOywz2AaymyFfkkRYTarGZncALL9mra9yMWNq
	 RsC3lNzOP6Y8WQ/aKL5OCYbGciCv8Lmp8ObKFFBR973WN92yZeIOSmHBhUqItpN3fd
	 BNgodcInyLcS+ggQ3la2PwzHyE9ZD4kYSj5iGHuf/SxFgEKVsZKOYWX8fuAisJgAUJ
	 pboYrczzY9SiomovjNO+82Hrs3bISrskEClD1K7OF6SBLtYi1mpFhAn4co38r75FPM
	 BIG48PB5R1RJApd0LXUXZ/sB97YCaL45y5IkgZRnNjEkiGHpH1VwbJI4w0tDZLZ92R
	 nQhbxybJUXmlQ==
Subject: Re: [PATCH net v2] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
From: netdev-bot+sashiko@kernel.org
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com,
 nb@tipi-net.de
Date: Sat, 03 Oct 2026 20:47:02 +0000
Message-ID: <179106042235.434549.7411488651428053486@kernel.org>
In-Reply-To: <20260929203400.1588868-1-justin.chen@broadcom.com>
References: <20260929203400.1588868-1-justin.chen@broadcom.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New BQL accounting in bcmasp_xmit() is not ordered before the
  TX doorbell.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the DMA
  mapping-error unwind in bcmasp_xmit() leaks the DMA mappings already…
- [Medium] This problem wasn't introduced by this patch, but
  intf->stats64.syncp has TX and RX writers that are not mutually…
- [Medium] This problem wasn't introduced by this patch, but
  bcmasp_interface_suspend() stops TX with netif_device_detach() alone…

--

net: bcmasp: fix lost TX wakeup race with lockless queue API

This patch fixes a lost-wakeup race between netif_stop_queue() in
bcmasp_xmit() and netif_wake_queue() in bcmasp_tx_poll(). It switches both
paths to the netif_txq_maybe_stop()/netif_txq_completed_wake() helpers.
It also replaces tx_spb_ring_full() with a bcmasp_tx_avail() count and
adds BQL accounting.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index f2176ef3a127b..3369c45b49d5b 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c

[ ... ]

> @@ -143,19 +147,13 @@ static void bcmasp_clean_txcb(struct bcmasp_intf *intf, int index)
>  	txcb->last = false;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but bcmasp_clean_txcb() only
clears the tx_cbs[] metadata. It is also the only cleanup that the DMA
mapping error path in bcmasp_xmit() does for entries that are already
mapped:

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

If a later fragment fails to map (i > 0), the head and the earlier
fragments stay mapped. Their dma_addr and dma_len are zeroed, and
tx_spb_index was never advanced. That means bcmasp_tx_reclaim() can't
unmap them later either.

Does this leak the DMA mappings (swiotlb slots or IOVA space) for those
entries?

[ ... ]

> @@ -333,15 +334,17 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 */
>  	wmb();
>  
> -	intf->tx_spb_index = spb_index;
> +	WRITE_ONCE(intf->tx_spb_index, spb_index);
>  	intf->tx_spb_dma_valid = valid;
>  
> +	netdev_tx_sent_queue(txq, total_bytes);
> +
>  	skb_tx_timestamp(skb);
>  
>  	tx_spb_dma_wq(intf, intf->tx_spb_dma_valid, TX_SPB_DMA_VALID);

[Severity: Medium]
Is the new BQL accounting ordered before the doorbell write?

The wmb() above only orders stores made before it, and
netdev_tx_sent_queue() now comes after it. tx_spb_dma_wq() is a relaxed
MMIO write, from bcmasp.h:

	writeq_relaxed(val, intf->m + off);

When dql_avail() >= 0, dql_queued() does a plain store to
dql->num_queued with no CPU barrier.

On arm64, could the device see the new TX_SPB_DMA_VALID, transmit, and
raise the TX interrupt before that store is visible to another CPU?

In that case bcmasp_tx_poll() on the other CPU would reach:

bcmasp_tx_poll()
  netif_txq_completed_wake()
    netdev_tx_completed_queue()
      dql_completed()
        num_queued = READ_ONCE(dql->num_queued);
        ...
        BUG_ON(count > num_queued - dql->num_completed);

If only this packet is in flight, the stale num_queued would not include
total_bytes, and the BUG_ON() would fire. The smp_mb() in the completion
helper comes after dql_completed(), so it doesn't help here.

For this to happen, the store would have to stay invisible across the
whole DMA, transmit and interrupt round trip, so it may be mostly
theoretical. Would calling netdev_tx_sent_queue() before the wmb() close
the window?

[ ... ]

> @@ -433,33 +441,37 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)

[ ... ]

>  static int bcmasp_tx_poll(struct napi_struct *napi, int budget)
>  {
>  	struct bcmasp_intf *intf =
>  		container_of(napi, struct bcmasp_intf, tx_napi);
> -	int released = 0;
> +	struct netdev_queue *txq = netdev_get_tx_queue(intf->ndev, 0);
> +	unsigned int bytes = 0;
> +	int packets;
>  
> -	released = bcmasp_tx_reclaim(intf);
> +	packets = bcmasp_tx_reclaim(intf, &bytes);
> +
> +	netif_txq_completed_wake(txq, packets, bytes,
> +				 bcmasp_tx_avail(intf), BCMASP_TX_START_THRS);

[Severity: Medium]
This is a pre-existing issue, but can this wake the queue after
bcmasp_interface_suspend() has detached the device?

bcmasp_interface_suspend() stops TX with only netif_device_detach():

	netif_device_detach(dev);

	wake = device_may_wakeup(kdev) && intf->wolopts;

	bcmasp_netif_deinit(dev, !wake);

netif_device_detach() sets DRV_XOFF without taking the TX lock, and the
qdisc stays active during suspend.

bcmasp_tx_poll() can keep running until napi_disable(&intf->tx_napi) in
bcmasp_netif_deinit(). Here it calls netif_txq_completed_wake() with
down_cond false, which calls netif_tx_wake_queue() once
avail >= BCMASP_TX_START_THRS.

The old netif_wake_queue() had the same race. This patch adds a second
restart point: netif_txq_try_stop() in bcmasp_xmit() calls
netif_tx_start_queue() when a concurrent reclaim frees enough
descriptors.

Once the queue is running again, bcmasp_xmit() could race with
bcmasp_tx_reclaim() in bcmasp_netif_deinit(). It could also write
TX_SPB_DMA_VALID after the block's clocks are gated. Any skbs queued this
way would be lost when bcmasp_init_tx() memsets tx_cbs[] on resume.

Should the suspend path synchronize with bcmasp_xmit() and tx_napi before
tearing down the TX ring?

[ ... ]

> @@ -944,7 +957,7 @@ static void bcmasp_netif_deinit(struct net_device *dev, bool stop_phy)
>  	} while (timeout-- > 0);
>  	tx_spb_dma_wl(intf, 0x0, TX_SPB_DMA_FIFO_CTRL);
>  
> -	bcmasp_tx_reclaim(intf);
> +	bcmasp_tx_reclaim(intf, NULL);

[Severity: Medium]
This isn't a bug introduced by this patch, but is intf->stats64.syncp
safe to update from here?

bcmasp_netif_deinit() disables only tx_napi before it calls
bcmasp_tx_reclaim() from sleepable process context. rx_napi stays enabled
until later:

bcmasp_netif_deinit()
    napi_disable(&intf->tx_napi);
    ...
    bcmasp_tx_reclaim(intf, NULL);
        u64_stats_update_begin(&stats->syncp);
        ...
    ...
    napi_disable(&intf->rx_napi);

bcmasp_rx_poll() updates the rx_* counters under the same syncp.

On 32-bit kernels, u64_stats_update_begin() expects preemption to be
disabled, and on non-RT kernels preempt_disable_nested() is only a lockdep
assertion. It also relies on writers being mutually exclusive.

Could this trigger a lockdep warning on interface down or suspend?

Could a concurrent RX NAPI poll race the seqcount increment? The same
question applies to threaded NAPI running the TX and RX polls on different
CPUs.

A lost increment would leave the sequence odd, and the
u64_stats_fetch_retry() loop in bcmasp_get_stats64() would then spin
forever.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929203400.1588868-1-justin.chen%40broadcom.com
