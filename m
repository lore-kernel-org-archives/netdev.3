Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD1439F86;
	Fri,  4 Sep 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559037; cv=none; b=TII2VKu6fuf6iI+gqdyXDEOmjIqS2DCiomfcv+i9I5PATVERpL2OzUSqzv53AHF78f+ab4IiG2acNh1FVO3BtLgwoUgQYvfr8nzhgKAL7zq9+BWCkbsHnFvRz3qi292H836SrE7oSQo7tlFN2OLPjeSMPcVlD5CskxOYNW4b/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559037; c=relaxed/simple;
	bh=ojqONR1KfmVkJDx2v6rOs080HAvSv2vHM/qkxxDib74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYQBf8Wh0J0LmHfIAOKZrU7pAtCul6IceBFyuz6836EoHcWf6hp882inAAUuWqoyznPhByCXr8uUdjeT1XnwSgHw4EXuIm0CbWQ8TuPC8nq80xjxX0bUyN0mX7ISafzQMMadEWNn4j5QiklDfKfVsnUK+7Zr01HW8LIWHHP2GOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onWwGOXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onWwGOXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E76B1F00A3D;
	Fri,  4 Sep 2026 21:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559035;
	bh=iCsHHrBGNFhAhFyzAShXfP9teD/qZzuRKEYLSx3jk0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onWwGOXBeD1BwI64lFBd8mrLu6UwKBE5rLNpXnwy7AzxWGUG0wtobOd343eUECk6K
	 TFmsPQB9dXU4tl/88ftxSmENvMJi1cwqsxQTT8cIpS8yyZKB55wBFci/CeDfjAktKm
	 7kXG0VkrzSWoIIas6fuKEXZvq212HcgiEcjnwukbXdFjdudnGBX0Mhw3LkImz92tOA
	 slHL3+BSWYC4+FZAk3E9zahvLHHOw60rNAWyCgsoRlzYPIDqpKkFxmzPd/ef9ccAlt
	 ekCTYVJpK5wBef+0mAw2P4GSOrsTcAPucUyRv8r1h1KvADV8LWE50fHfB8lhq/W3U0
	 iVDpbGXXrvFjQ==
From: Jakub Kicinski <kuba@kernel.org>
To: dong100@mucse.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v10 2/5] net: rnpgbe: Add basic TX packet transmission support
Date: Fri,  4 Sep 2026 14:57:13 -0700
Message-ID: <20260904215713.3999937-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <F744115CE91035F6+20260831073608.401988-3-dong100@mucse.com>
References: <F744115CE91035F6+20260831073608.401988-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: rnpgbe: Add basic TX packet transmission support

This adds the TX path for rnpgbe: TX descriptor and buffer structures,
rnpgbe_xmit_frame_ring(), TX ring setup/teardown, completion handling in
rnpgbe_clean_tx_irq(), and TX counters exported via ndo_get_stats64().
It also switches probe to dma_set_mask_and_coherent(DMA_BIT_MASK(56))
and adds hw->cycles_per_us plus NETIF_F_HIGHDMA.

A few questions below about the new fault state, the teardown error
handling, the stats reader and the missing TX watchdog.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 77304196c2b6..6d0b9f424c64 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h

[ ... ]

> @@ -74,21 +139,20 @@ struct mucse_q_vector {
>  	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
>  };
>  
> -struct mucse_stats {
> -	u64 tx_dropped;
> -};
> -
>  #define MAX_Q_VECTORS 8
>  
> +#define M_DEFAULT_TXD     512
> +#define M_DEFAULT_TX_WORK 256
> +
>  enum mucse_state_t {
>  	__MUCSE_DOWN,
> +	__MUCSE_AXI_FAULT,
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index f511a3a5f916..ff81d222edd3 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -636,13 +760,169 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
>  		napi_disable(&mucse->q_vector[i]->napi);
>  }
>  
> +static void rnpgbe_stop_tx_ring(struct mucse_ring *tx_ring)
> +{
> +	if (!tx_ring->tx_buffer_info)
> +		return;
> +
> +	/* Stop hw. No new descriptors are fetched after TX_START=0.
> +	 * DMA for descriptors fetched before the stop may still be in flight.
> +	 */
> +	mucse_ring_wr32(tx_ring, RNPGBE_TX_START, 0);
> +	/* Flush posted write to ensure hardware sees TX_START=0 */
> +	(void)mucse_ring_rd32(tx_ring, RNPGBE_TX_START);
> +}
> +
> +static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_status;
> +	int err;
> +
> +	/* A timeout indicates a terminal AXI fault. Hardware stops DMA
> +	 * accesses, so teardown may release mappings, but configuration
> +	 * must not re-enable TX DMA.
> +	 */
> +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> +				 dma_status,
> +				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
> +				 RNPGBE_DMA_TX_STATUS,
> +				 10, 100000);
> +	if (err) {
> +		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
> +		dev_err(&mucse->pdev->dev,
> +			"TX DMA failed to quiesce, status %#x\n", dma_status);
> +	}
> +
> +	return err;
> +}

[Severity: Medium]
Once __MUCSE_AXI_FAULT is set here, is there a way back?

Grepping drivers/net/ethernet/mucse/ at the end of the series shows no
clear_bit(__MUCSE_AXI_FAULT, ...) anywhere, and the existing
firmware-mediated reset rnpgbe_reset_hw() (which clears
RNPGBE_DMA_AXI_EN) is only called from rnpgbe_add_adapter() during
probe, never from this path.

After the bit is latched, rnpgbe_stop_all_tx_rings() always ends with
"return err ? err : -EIO;", so rnpgbe_configure_tx() can never succeed
again, and rnpgbe_open() bails out with -EIO on every subsequent
"ip link set <dev> up". Is unbind/rmmod the only intended recovery?

There is also an ordering question about when the poll first runs. The
quiesce poll is on the entry path:

rnpgbe_open()
  rnpgbe_configure()
    rnpgbe_configure_tx()
      rnpgbe_stop_all_tx_rings()
        rnpgbe_wait_tx_dma_idle()

mucse->num_tx_queues is already non-zero after probe, so this runs
before any ring has ever been started. If the tx_wr/tx_rd done bits in
RNPGBE_DMA_STATUS[23:22] do not read as set in the post-reset state,
would the very first open permanently latch the fault and leave the
netdev un-openable?

Could the commit message also mention the new terminal state? It
enumerates the descriptors, rnpgbe_xmit_frame_ring(), ring
alloc/teardown, rnpgbe_clean_tx_irq(), stats, the 56-bit DMA mask,
cycles_per_us and NETIF_F_HIGHDMA, but not that ndo_open can now fail
permanently on a hardware timeout.

> +
> +/**
> + * rnpgbe_stop_all_tx_rings - Stop TX DMA on all queues
> + * @mucse: board private structure
> + *
> + * Return: 0 when TX DMA was quiesced, negative errno otherwise
> + **/
> +static int rnpgbe_stop_all_tx_rings(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_axi_ctl;
> +	int err = 0;
> +
> +	for (int i = 0; i < mucse->num_tx_queues; i++)
> +		rnpgbe_stop_tx_ring(mucse->tx_ring[i]);
> +
> +	if (mucse->num_tx_queues &&
> +	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> +		err = rnpgbe_wait_tx_dma_idle(mucse);
> +
> +	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +	dma_axi_ctl &= ~TX_AXI_RW_EN;
> +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
> +	/* Flush the posted write before continuing. */
> +	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +
> +	if (!test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> +		return 0;
> +
> +	return err ? err : -EIO;
> +}
> +
> +/**
> + * rnpgbe_clean_tx_ring - Free Tx Buffers
> + * @tx_ring: ring to be cleaned
> + **/
> +static void rnpgbe_clean_tx_ring(struct mucse_ring *tx_ring)
> +{

[ ... body of rnpgbe_clean_tx_ring() snipped ... ]

> +	netdev_tx_reset_queue(txring_txq(tx_ring));
> +	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;
> +	memset(tx_ring->tx_buffer_info, 0, size);
> +	/* Zero out the descriptor ring */
> +	memset(tx_ring->desc, 0, tx_ring->size);
> +	tx_ring->next_to_use = 0;
> +	tx_ring->next_to_clean = 0;
> +}
> +
> +/**
> + * rnpgbe_clean_all_tx_rings - Stop TX DMA and free Tx buffers for all queues
> + * @mucse: board private structure
> + **/
> +void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
> +{
> +	rnpgbe_stop_all_tx_rings(mucse);
> +
> +	for (int i = 0; i < mucse->num_tx_queues; i++)
> +		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
> +}

[Severity: Medium]
Is it safe to discard the return value of rnpgbe_stop_all_tx_rings()
here?

rnpgbe_stop_tx_ring() only writes RNPGBE_TX_START=0, and its own comment
says "DMA for descriptors fetched before the stop may still be in
flight". The only thing that establishes retirement is the
RNPGBE_DMA_TX_STATUS poll in rnpgbe_wait_tx_dma_idle(). When that poll
times out, rnpgbe_configure_tx() refuses to re-arm TX, but this caller
proceeds anyway:

rnpgbe_down()
  rnpgbe_clean_all_tx_rings()
    rnpgbe_stop_all_tx_rings()   /* -EIO ignored */
    rnpgbe_clean_tx_ring()       /* dma_unmap_*() + memset(desc) */

and then:

rnpgbe_close()
  rnpgbe_free_all_tx_resources()
    rnpgbe_free_tx_resources()
      dma_free_coherent(tx_ring->dev, tx_ring->size, tx_ring->desc, ...)

So the streaming mappings are released and the coherent descriptor ring
is handed back to the allocator while RNPGBE_TX_BASE_ADDR_LO/HI still
point at it, based on the comment's claim that "Hardware stops DMA
accesses". Can that claim be verified? It is asserted in exactly the
state where the register used to observe TX DMA retirement is the thing
that failed to report done.

Clearing TX_AXI_RW_EN gates new AXI transactions rather than draining
ones already accepted by the fabric, so does it substitute for the
quiesce handshake? If the engine is still active, a late write into
recycled pages or an IOMMU fault against the freed ring both look
possible. Would it be preferable to quarantine (leak) the mappings and
the coherent ring when the quiesce fails, instead of releasing them?

> +
>  bool rnpgbe_down(struct mucse *mucse)
>  {
> +	struct net_device *netdev = mucse->netdev;
> +
>  	if (test_and_set_bit(__MUCSE_DOWN, &mucse->state))
>  		return false;
>  
> +	netif_tx_disable(netdev);
>  	rnpgbe_napi_disable_all(mucse);
>  	rnpgbe_irq_disable(mucse);
> +	rnpgbe_clean_all_tx_rings(mucse);
>  
>  	return true;
>  }

> @@ -653,11 +933,420 @@ bool rnpgbe_down(struct mucse *mucse)

[ ... rnpgbe_up_complete(), TX resource setup/teardown, rnpgbe_tx_map()
and rnpgbe_xmit_frame_ring() snipped ... ]

> +/**
> + * rnpgbe_get_stats64 - Get stats for this netdev
> + * @netdev: network interface device structure
> + * @stats: stats data
> + **/
> +void rnpgbe_get_stats64(struct net_device *netdev,
> +			struct rtnl_link_stats64 *stats)
> +{
> +	struct mucse *mucse = netdev_priv(netdev);
> +	int i;
> +
> +	rcu_read_lock();
> +	for (i = 0; i < mucse->num_tx_queues; i++) {
> +		struct mucse_ring *ring = READ_ONCE(mucse->tx_ring[i]);
> +		u64 bytes, packets, dropped;
> +		unsigned int start;
> +
> +		if (ring) {
> +			do {
> +				start = u64_stats_fetch_begin(&ring->syncp);
> +				packets = ring->stats.packets;
> +				bytes = ring->stats.bytes;
> +			} while (u64_stats_fetch_retry(&ring->syncp, start));
> +			dropped = atomic64_read(&ring->stats.dropped);
> +
> +			stats->tx_packets += packets;
> +			stats->tx_dropped += dropped;
> +			stats->tx_bytes += bytes;
> +		}
> +	}
> +	rcu_read_unlock();
>  }

[Severity: Medium]
Does the rcu_read_lock() plus READ_ONCE() here actually protect the ring
memory?

mucse->tx_ring[i] points inside the struct mucse_q_vector allocation,
and the free side does not use an RCU grace period:

rnpgbe_free_q_vector()
	mucse_for_each_ring(ring, q_vector->tx)
		mucse->tx_ring[ring->queue_index] = NULL;
	...
	netif_napi_del(&q_vector->napi);
	kfree(q_vector);

On the shutdown path the free also happens outside rtnl while the netdev
is still registered:

rnpgbe_dev_shutdown()
	rtnl_lock();
	netif_device_detach(netdev);
	if (netif_running(netdev))
		rnpgbe_close(netdev);
	rtnl_unlock();

	rnpgbe_free_mbx_irq(mucse);
	rnpgbe_clear_interrupt_scheme(mucse);   /* kfree(q_vector) */

So can this sequence read freed memory?

CPU0: reboot -> rnpgbe_shutdown() -> rnpgbe_dev_shutdown()
        -> rnpgbe_clear_interrupt_scheme() -> kfree(q_vector)

CPU1: cat /proc/net/dev -> dev_seq_show() -> dev_get_stats()
        -> rnpgbe_get_stats64()
             ring = READ_ONCE(mucse->tx_ring[i]);  /* loaded pre-NULL */
             packets = ring->stats.packets;        /* freed slab */

Would kfree_rcu() for the q_vector (or unregistering the netdev before
freeing the vectors) be the right pairing for this reader?

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index b7472dba2a19..5be78afd0b25 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -26,6 +27,19 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
>  	{ },
>  };
>  
> +/**
> + * rnpgbe_configure - Configure the hardware
> + * @mucse: pointer to private structure
> + *
> + * rnpgbe_configure configure mac, tx, rx regs to hw
> + *
> + * Return: 0 on success, negative errno if hardware configuration fails
> + **/
> +static int rnpgbe_configure(struct mucse *mucse)
> +{
> +	return rnpgbe_configure_tx(mucse);
> +}

[Severity: Low]
This isn't a bug, but the kernel-doc says "configure mac, tx, rx regs to
hw" while the body only calls rnpgbe_configure_tx(). This resolves later
in the same series: the final state adds rnpgbe_configure_rx() and
rnpgbe_set_rx_mode() to this function, at which point the description
matches. Mentioning it only for completeness.

> @@ -40,6 +54,9 @@ static int rnpgbe_open(struct net_device *netdev)
>  	struct mucse *mucse = netdev_priv(netdev);
>  	int err;
>  
> +	if (test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> +		return -EIO;
> +
>  	err = rnpgbe_request_irq(mucse);
>  	if (err)
>  		return err;

[ ... ]

> @@ -83,25 +111,37 @@ static int rnpgbe_close(struct net_device *netdev)
>   * @skb: skb structure to be sent
>   * @netdev: network interface device structure
>   *
> - * Return: NETDEV_TX_OK
> + * Return: NETDEV_TX_OK or NETDEV_TX_BUSY when insufficient descriptors
>   **/
>  static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
>  				     struct net_device *netdev)
>  {
>  	struct mucse *mucse = netdev_priv(netdev);
> +	struct mucse_ring *tx_ring;
>  
> -	dev_kfree_skb_any(skb);
> -	mucse->stats.tx_dropped++;
> +	tx_ring = mucse->tx_ring[skb_get_queue_mapping(skb)];
>  
> -	return NETDEV_TX_OK;
> +	if (unlikely(skb_put_padto(skb, RNPGBE_TX_MIN_PKT_LEN))) {
> +		atomic64_inc(&tx_ring->stats.dropped);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	return rnpgbe_xmit_frame_ring(skb, tx_ring);
>  }
>  
>  static const struct net_device_ops rnpgbe_netdev_ops = {
>  	.ndo_open       = rnpgbe_open,
>  	.ndo_stop       = rnpgbe_close,
>  	.ndo_start_xmit = rnpgbe_xmit_frame,
> +	.ndo_get_stats64 = rnpgbe_get_stats64,
>  };

[Severity: Medium]
This patch makes the TX queues stoppable, but the ops table gains only
.ndo_get_stats64 and there is still no .ndo_tx_timeout (and
netdev->watchdog_timeo is never set). Was that intentional?

rnpgbe_xmit_frame_ring() stops the queue:

	if (!netif_txq_maybe_stop(txring_txq(tx_ring),
				  mucse_desc_unused(tx_ring),
				  count + RESV_DESC_NEEDED,
				  count + RESV_DESC_NEEDED))
		return NETDEV_TX_BUSY;

and the only wake is __netif_txq_completed_wake() inside
rnpgbe_clean_tx_irq(), which needs a TX completion interrupt to schedule
NAPI. Meanwhile the core watchdog never arms:

net/sched/sch_generic.c:netdev_watchdog_up() {
	if (!dev->netdev_ops->ndo_tx_timeout)
		return;
	...
}

So if a TX completion interrupt is lost or the TX engine stalls, does
anything detect the permanently stopped queue? The driver itself defines
RNPGBE_DMA_INT_TRIG as a "lost-interrupt recovery trigger", which
suggests interrupt loss is a real case for this hardware. The ops table
is still open/stop/start_xmit/set_rx_mode/get_stats64 at the end of the
series.

[ ... ]
