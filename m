Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164E3C10AF;
	Wed, 19 Aug 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129430; cv=none; b=MY5t3UxcUgKT6wlzkHnQjts7bWwFEVr18Os9Ah/+JQSkWeG5uYE0wBZcNNDzIekNDFv5PuU6MgejvyCrNoJxUDf43hC/7fi3Y+WTPvBBJjUcXpGNyyQNzMS5X56+4j7o7tiF3BWAuYPteGHGr7tDP1oZVVQGA0YcE/leCiXPw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129430; c=relaxed/simple;
	bh=EXfl300+gN3PjwMh0ZVvKs8pQJxFlQhZStX1W68PuT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkIOqZwXKBp6eGA6LfqVyekoBok8eRy/zPyAw168QzLOvOtCrjfqDrK6ZQUM+k7TzDZ5StELJz5vPi/dBIUz3tUJ1+Ljhyo0bSRgUz737qf8X8kMOmmHS2rTC0En/LOdivH7zH8h8eU+55TM/HHbendv5Ad5gB0xGXgbZF1ZoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz1t1787129347tfba4e7b3
X-QQ-Originating-IP: 0iWO77d+erBpCFqALq47DykH42m7AqTvyp/+8kOKDlQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Aug 2026 16:49:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9229901496552399555
EX-QQ-RecipientCnt: 11
Date: Wed, 19 Aug 2026 16:49:04 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v9 2/4] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <5DC7ADB456BE9777+20260819084904.GB2730731@nic-Precision-5820-Tower>
References: <20260814111317.1741087-1-dong100@mucse.com>
 <20260814111317.1741087-3-dong100@mucse.com>
 <20260818110320.GB265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818110320.GB265046@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NJT5C3zFSytJG26o2C6OWonQnes3qrODQm34/LFdczpnGv70VFQ4bYxJ
	b/QSqI79pa3UD7NwerPTqFW0Iiix/5ELF+l1wuJt/kQZ9BTpmzxXYgM6QySzZ4Um7mu63fl
	StXrEpjy23W6vdU61McO3C+tXgqqNOlFrVmlTkxSZxWGCujUlZlh2SwfChxAkqaV2e+uTEO
	2s12Cf4psOZodyHEgc3EVKI8Lpwbjusfo5jzTN/h6f3cdbNNbxlzGppGNhPOo44BoAB/Hfp
	PvuqC5eZlgHELm5HUyUC9yZEiOMouPPKFx5FAV2YFUiNTTGwf4kRnqW2pWbykeYsOX6IbKh
	2mUO1ZL0c5az8xTpuwy7COTpfMh+ZkJEhaSRrmc24u4Pvj2TIpWFAzj/sU6btJ+lRoul4Il
	GzflCkgtqoZDloifoED92f07/OJ/nshFBHt41NEUm0vv6x301gk0lmIB9kp/P0u1q6SIamn
	FEM4Fd8wpEEJJBuaI397fk8sY00mXdxVsUVy1lIDtknAtvnZrY+NAEmxVolLhb9/JZp+pNc
	6GVagUCTLFcimNBUWGwQKSH2tSs78GeDq/PTD35PY7PxHcZeIxgUNl0V+uoMpsg3wTDyRsc
	g57E4l1lxdXXwGyCF6YUMY1V1S2oboyOUJ75rydu+yRpNa/0cIWBAPn0qKClODol6ggkstR
	UHz5IsrwuwR2FCjrX6eBcBCbqkcAEmx7gKsmv9I1hcp8l2TNo+G6vwf3q2/C9/fd1HPubTn
	O8bqgkQIlIJVifdrxHvwue6pH0SMRF6NoxBgzn8QpIX2gKEg1v8bYcB8DqMQ64OL7oE2f21
	DLaBbJX4tluZlv7qH9Uln7S/9RP4AoscAgUW6z01+o07graM6AwHBO4KEqB451lLw3qE+28
	51qkwKEB2nJvo/NgKNR13HGVuACyO9x5a5554Q2Tmy1wmiqyGRSxmY0hqg+WfmiG6AIPOBj
	J8pd69AMxGwux9B4/WdeaWD67HiL7ErPN7+sQuD5hH92Wj3bxXl9ZEHJ40Bi7yh4auyXjlA
	uN0U1KBIsQQ8HXcxi/VW/hZDYaNdQ4lWbCckkRysu52lm19F7bOUzQPNhrlqncM56JTHiN6
	2GU5y1zw6aZykARao/XXyhi3TCsGgh6ysXN7vaZZyGEL+BXK8patg4=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

On Tue, Aug 18, 2026 at 12:03:20PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814111317.1741087-2-dong100@mucse.com?part=2
> ---
> --- Patch [2]: [PATCH net-next v9 2/4] net: rnpgbe: Add basic TX packet transmission support ---
> commit 8bff6db2aa4a278636a66ac5e08b9b7d42fd23a7
> Author: Dong Yibo <dong100@mucse.com>
> 
> net: rnpgbe: Add basic TX packet transmission support
> 
> This adds the TX path for rnpgbe: the TX descriptor layout and buffer
> management, rnpgbe_xmit_frame_ring(), TX ring setup/teardown, and TX
> completion handling in rnpgbe_clean_tx_irq(). It also requires the 56-bit
> DMA mask and enables NETIF_F_SG plus NETIF_F_HIGHDMA.
> 
> A few questions about the TX stop/wake logic and the TX DMA quiesce
> handling below.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index 0dce78e4a91ba..6dc29ebe6fa70 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -7,13 +7,20 @@
> > +#define RNPGBE_DMA_STATUS              0x0008
> > +#define TX_AXI_RW_EN                   0xc
> > +/* DMA_STATUS_REG[23:20]: tx_wr, tx_rd, rx_wr, rx_rd done status. */
> > +#define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
> >  #define RNPGBE_DMA_AXI_EN              0x0010
> > +#define RNPGBE_TX_MIN_PKT_LEN          33
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > index c661290d561bd..8700c48669ecb 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > @@ -89,6 +91,114 @@ static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
> > +static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
> > +				struct mucse_ring *tx_ring,
> > +				int napi_budget)
> > +{
> 
> [ ... ]
> 
> > +	i += tx_ring->count;
> > +	tx_ring->next_to_clean = i;
> > +	u64_stats_update_begin(&tx_ring->syncp);
> > +	tx_ring->stats.bytes += total_bytes;
> > +	tx_ring->stats.packets += total_packets;
> > +	u64_stats_update_end(&tx_ring->syncp);
> > +
> > +#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
> > +	__netif_txq_completed_wake(txring_txq(tx_ring),
> > +				   total_packets, total_bytes,
> > +				   mucse_desc_unused(tx_ring),
> > +				   TX_WAKE_THRESHOLD,
> > +				   !netif_carrier_ok(tx_ring->netdev) ||
> > +				   test_bit(__MUCSE_DOWN, &mucse->state));
> 
> [Severity: High]
> [Finding: main-1-1]
> [Sources: opus-5]
> Can the TX queue end up stopped forever here?
> 
> rnpgbe_clean_tx_irq() is the only place in the driver that can clear
> __QUEUE_STATE_DRV_XOFF after rnpgbe_xmit_frame_ring() stops the queue,
> and the down_cond argument suppresses the wake whenever the carrier is
> reported down:
> 
> 	!netif_carrier_ok(tx_ring->netdev) ||
> 	test_bit(__MUCSE_DOWN, &mucse->state)
> 
> Since link state is polled by the service task, netif_carrier_off() can
> lag the real link event. If the hardware finishes the queued descriptors
> during that window, this call drains the ring but returns without waking,
> and with an empty ring there is no further TX interrupt to re-evaluate
> the condition.
> 
> What re-enables the queue after that? netif_tx_start_all_queues() is
> called only from rnpgbe_up_complete() on ifup, and the runtime carrier-on
> handler added later in the series only calls netif_carrier_on() without
> touching the queues. dev_activate() does not clear DRV_XOFF either.
> 
> rnpgbe_netdev_ops also registers no .ndo_tx_timeout, and
> netdev_watchdog_up() bails out early in that case:
> 
> net/sched/sch_generic.c:netdev_watchdog_up() {
> 	if (!dev->netdev_ops->ndo_tx_timeout)
> 		return;
> }
> 
> so dev_watchdog() never fires and a genuine hardware TX stall (DD never
> set, no TX interrupt) is equally invisible. Would it make sense to add
> .ndo_tx_timeout, and to wake the queues from the carrier-on path?
> 
Yes, it is an error. I will remove the carrier state from the TX completion
down_cond and retain only the device-down check. Thus a completion can
clear DRV_XOFF while the interface is administratively up; linkwatch and
the carrier state still prevent transmission while the link is down.
.ndo_tx_timeout may be added in future, not in this series patches.
> > +
> > +	return !!budget;
> > +}
> 
> [ ... ]
> 
> > @@ -633,13 +758,144 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
> > +static void rnpgbe_stop_tx_ring(struct mucse_ring *tx_ring)
> > +{
> > +	if (!tx_ring->tx_buffer_info)
> > +		return;
> > +
> > +	/* Stop hw. No new descriptors are fetched after TX_START=0.
> > +	 * DMA for descriptors fetched before the stop may still be in flight.
> > +	 */
> > +	mucse_ring_wr32(tx_ring, RNPGBE_TX_START, 0);
> > +	/* Flush posted write to ensure hardware sees TX_START=0 */
> > +	(void)mucse_ring_rd32(tx_ring, RNPGBE_TX_START);
> > +}
> > +
> > +static void rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
> > +{
> > +	struct mucse_hw *hw = &mucse->hw;
> > +	u32 dma_status;
> > +	int err;
> > +
> > +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> > +				 dma_status,
> > +				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
> > +				 RNPGBE_DMA_TX_STATUS,
> > +				 10, 100000);
> > +	if (err)
> > +		dev_warn(&mucse->pdev->dev,
> > +			 "Timed out waiting for TX DMA to quiesce, status %#x\n",
> > +			 dma_status);
> > +}
> 
> [Severity: Medium]
> [Finding: gpt-5-6-sol-4-6]
> [Sources: gpt-5-6-sol, opus-5]
> Should the timeout here be propagated to the callers?
> 
> rnpgbe_wait_tx_dma_idle() returns void, so a timeout is only logged and
> both callers continue as if the engine had confirmed idle. On the ifdown
> side that means rnpgbe_clean_all_tx_rings() clears TX_AXI_RW_EN and then
> rnpgbe_clean_tx_ring() calls dma_unmap_single()/dma_unmap_page() on every
> in-flight TX buffer, and rnpgbe_close() -> rnpgbe_free_all_tx_resources()
> -> rnpgbe_free_tx_resources() then dma_free_coherent()s the descriptor
> ring.
> 
> The comment in rnpgbe_stop_tx_ring() states that DMA for descriptors
> fetched before the stop may still be in flight, which is what this poll
> is guarding. If the poll times out, can the device still be reading the
> mapped buffers or writing back into the descriptor ring after they are
> released?
> 
> The same unchecked wait sits at the head of rnpgbe_configure_tx(), where
> RNPGBE_TX_BASE_ADDR_LO/HI, RNPGBE_TX_LEN and TAIL are reprogrammed and
> TX_START is set to 1 again. Is a device reset or an error return needed
> when the engine never reports idle?
> 
After TX_START has been cleared for all TX rings, normal outstanding
DMA transactions reach idle well within 100 ms. If DMA_STATUS still does
not report idle after that timeout, the hardware has entered an
unrecoverable AXI fault state. In this state, the EP will not issue any
further DMA accesses to RC memory, so teardown can safely release the DMA
mappings. Recovery requires a chip-level reset.
I will make the helper return an error. On this error, the driver will
report it with dev_err() and will not enable or reprogram TX DMA again;
the configuration/open path will fail instead. Does this approach sound
reasonable?

Thanks for your feedback.
