Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE273B4407;
	Sat,  8 Aug 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218506; cv=none; b=GdXRciiVjW6xRykdDKZIuN0CN/BeylhgL35HAG9XzM6Nsx25dqRnmroyRkDl7vreW6LMZUfl/l63Z6GCn1+8QxnHWXeT/oYDE8Z9vDdkU1MFcT+FWTcZ1i8oO37Q4LCncdeMP2z0l6XCHbVGQSM3oBMnotnQKxmyWyPVF1U+q/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218506; c=relaxed/simple;
	bh=Hh0q3cggCQ4UGqauvlMMbeaIEcl3ZT7o8C5gSNlO/04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMSq9AThD0M64OUS8EZHYmVFgH5hQNfU3UNL2mNJmdPduhoCTWjPCV5dMZa6f0MCDQvtI3WYScEYHTZIpz1Yt9GrD9BSVDXxAbmg8EZZp260dLdRjvSpq1Q+WiHBkEQEkxNHwiuZRJk/PgvJD4ilTzRd72KraVbvoHgbyEgK+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrD+83Al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrD+83Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874541F000E9;
	Sat,  8 Aug 2026 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218505;
	bh=4b1o0+cEVYX+UjAo2s2pv8sRX8xG8Y76NemrTHA1R78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrD+83AlV0CAHPC7M4XGP+1DQStgoiKT91cSITakBphZapAm/PkKUa1tFTXY2Qm8r
	 LhYn+hWGLOGwp33Xk0YGZ+wtH2nDdxBGS/3bEVgPO03twfYzvATJ68G3E10oBiDXW4
	 oJNbs/cVdvXtus4GMxLuC0ybZiL+wSnxqWFeMBa7NHfaGeAu5I3eWU1icH8CQVyYsz
	 +gJj3kYBxAjbWgzI01TtmQ2BQ0qiv1IYxA/B/QJJFPKXVNHBGmuAyETijtlNv45DwU
	 UGRGRTsGhCWUqArTLjKHQsAhFhMRztwB3eo+5vvUwv25WQeSUoAZ9XtgPHTt5rZ1AF
	 en6RZ5FixNfXw==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 07/20] net: xilinx: tsn: add the endpoint TX data path
Date: Sat,  8 Aug 2026 12:48:24 -0700
Message-ID: <20260808194824.132828-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-8-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-8-nagadheeraj.rottela@amd.com>
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
net: xilinx: tsn: add the endpoint TX data path

This adds the TX path for the Xilinx TSN endpoint conduit netdev: the
logical queue is translated to a physical DMA channel through the map built
at probe, the frame is mapped and submitted to that channel, and the queue
is stopped/woken based on the software ring occupancy.  A few questions
about the new ring accounting and the scatterlist handling below.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 207ca3242a12..7615d27f3b36 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -97,6 +99,7 @@ struct xlnx_tsn_ep_dma_chan {
>   * @ndev: the conduit netdev ("ep")
>   * @dev: backing device
>   * @regs: EP MAC register window
> + * @tx_lock: protects TX ring head/tail and SKB ring slots
>   * @num_tx_queues: number of TX DMA channels (one per priority)
>   * @num_rx_queues: number of RX DMA channels
>   * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
> @@ -110,6 +113,8 @@ struct xlnx_tsn_ep {
>  	struct device *dev;
>  	void __iomem *regs;
>  
> +	spinlock_t tx_lock;	/* protects TX ring buffers */
> +

[Severity: Low]
Does the implementation match this documented protection domain?  The
kernel-doc says tx_lock protects the "SKB ring slots", but ep_start_xmit()
drops the lock right after ep_get_desc() and then fills the slot unlocked:

	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (TX_BD_NUM_DEFAULT - 1));
	...
	spin_unlock_bh(&ep->tx_lock);

	sg_init_table(skbuf_dma->sgl, sg_len);
	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
	...
	skbuf_dma->skb = skb;
	skbuf_dma->sg_len = sg_len;

while ep_dma_tx_cb() reads skbuf_dma->skb/sgl/sg_len under the lock.  The
pre-existing teardown loop in ep_free_dma_chan() also walks chan->ring_tail
and clears skbuf_dma->skb with no tx_lock held at all.

As far as I can tell there is no race today: ep_parse_tx_queue_config()
rejects duplicate queue and duplicate channel numbers, so each DMA channel
is fed by exactly one netdev txq and the slot writes have a single writer
serialised by __netif_tx_lock, and the drain path only runs after
netif_tx_disable() plus dmaengine_terminate_sync().

Would it be clearer to narrow the comment to what is actually enforced,
e.g. "protects TX ring head/tail; slot payloads are serialised by the txq
xmit lock", or alternatively extend the locked region to cover the slot
writes?

>  	u32 num_tx_queues;
>  	u32 num_rx_queues;
>  	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
> @@ -268,8 +273,145 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	dma_async_issue_pending(xchan->chan);
>  }
>  
> +static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
> +{
> +	struct xlnx_tsn_ep_dma_chan *xchan = data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct xlnx_tsn_ep *ep = xchan->ep;
> +	struct netdev_queue *txq;
> +	struct net_device *ndev;
> +	struct scatterlist *sgl;
> +	struct sk_buff *skb;
> +	int sg_len;
> +	int len;
> +
> +	scoped_guard(spinlock, &ep->tx_lock) {
> +		skbuf_dma = ep_get_desc(xchan,
> +					xchan->ring_tail & (TX_BD_NUM_DEFAULT - 1));

[Severity: Low]
Should the new TX sites use xchan->ring_size instead of the compile-time
constant?  struct xlnx_tsn_ep_dma_chan documents ring_size as the "number
of slots in @skb_ring" and ep_free_dma_chan() uses it:

	skbuf_dma = chan->skb_ring[chan->ring_tail & (chan->ring_size - 1)];
	...
	for (i = 0; i < chan->ring_size; i++)

but the index masks in ep_dma_tx_cb() and ep_start_xmit(), and all four
CIRC_SPACE() computations, hardcode TX_BD_NUM_DEFAULT.  They agree today
only because ep_init_dmaengine() passes TX_BD_NUM_DEFAULT to
ep_alloc_dma_chan(); if the ring size ever becomes configurable through
ethtool set_ringparam the producer and consumer would mask against the
wrong size while the free path masks correctly.

> +		if (!skbuf_dma || !skbuf_dma->skb)
> +			return;
> +
> +		skb = skbuf_dma->skb;
> +		sgl = skbuf_dma->sgl;
> +		sg_len = skbuf_dma->sg_len;
> +
> +		dma_unmap_sg(xchan->dma_dev, sgl, sg_len, DMA_TO_DEVICE);
> +
> +		skbuf_dma->skb = NULL;
> +		xchan->ring_tail++;
> +	}
> +
> +	ndev = skb->dev;
> +	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
> +	len = skb->len;
> +
> +	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
> +		DEV_STATS_INC(ndev, tx_errors);
> +	} else {
> +		DEV_STATS_INC(ndev, tx_packets);
> +		DEV_STATS_ADD(ndev, tx_bytes, len);
> +	}
> +
> +	dev_consume_skb_any(skb);
> +	netif_txq_completed_wake(txq, 1, len,
> +				 CIRC_SPACE(READ_ONCE(xchan->ring_head),
> +					    READ_ONCE(xchan->ring_tail),
> +					    TX_BD_NUM_DEFAULT), 2);
> +}

[Severity: Low]
Is the READ_ONCE() here paired with anything on the producer side?  This
read happens after the scoped_guard() block has already released
ep->tx_lock, while ep_start_xmit() updates the index with a plain
read-modify-write:

	spin_lock_bh(&ep->tx_lock);
	xchan->ring_head++;

That is a marked read against a plain write, which KCSAN would report, and
the wake decision is taken on a non-atomic snapshot of the (head, tail)
pair.  If the completion observes a stale head, CIRC_SPACE() over-estimates
the free space and the queue may be woken with only one slot free, so the
next ep_start_xmit() takes the "TSN TX ring full" path and returns
NETDEV_TX_BUSY.

Would WRITE_ONCE() on the ring_head update be appropriate here?

Note the stop/wake handshake itself looks fine: include/net/netdev_queues.h
documents these macros as single-producer/single-consumer safe and states
they do not prevent false wake ups when the ring is full, which
ep_start_xmit() re-checks on entry.

>  static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {

[ ... ]

> +	xchan = ep->tx_chans[phys_chan];
> +	dma_dev = xchan->chan->device;
> +
> +	sg_len = skb_shinfo(skb)->nr_frags + 1;
> +	txq = netdev_get_tx_queue(ndev, queue);
> +

[ ... ]

> +	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (TX_BD_NUM_DEFAULT - 1));
> +	if (!skbuf_dma) {
> +		spin_unlock_bh(&ep->tx_lock);
> +		goto err_drop_skb;
> +	}
> +	spin_unlock_bh(&ep->tx_lock);
> +
> +	sg_init_table(skbuf_dma->sgl, sg_len);
> +	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> +	if (ret < 0)
> +		goto err_drop_skb;
> +
> +	nents = dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +	if (!nents)
> +		goto err_drop_skb;

[Severity: Medium]
Can dma_map_sg() walk past the end of skbuf_dma->sgl here?  The return
value of skb_to_sgvec() is only tested for < 0 and then discarded, and the
assumed count sg_len = nr_frags + 1 is what gets passed as nents.

skb_to_sgvec() only emits an entry for a non-zero-length region and marks
the end at sg[nsg - 1]:

net/core/skbuff.c:__skb_to_sgvec() {
	...
	if ((copy = end - offset) > 0) {
	...
}

net/core/skbuff.c:skb_to_sgvec() {
	int nsg = __skb_to_sgvec(skb, sg, offset, len, 0);
	...
	sg_mark_end(&sg[nsg - 1]);
	return nsg;
}

So a zero-length page frag, or skb_headlen() == 0, yields nsg < nr_frags +
1 while the caller still hands nents = sg_len to dma_map_sg().
dma_map_sg_attrs() iterates with for_each_sg(sgl, sg, nents, i), and
sg_next() returns NULL once sg_is_last() is true, so the extra iterations
dereference NULL inside the DMA core.

The same value is stored in skbuf_dma->sg_len, which the struct documents
as "number of valid entries in @sgl", and it is later used for the
dma_unmap_sg() in ep_dma_tx_cb() and on the err_unmap_sg path.

Would using skb_to_sgvec()'s return value as the entry count for
dma_map_sg(), the prep call and skbuf_dma->sg_len be more robust?  Note
ndev->features sets NETIF_F_SG, so page frags are passed through as-is and
only frag_list skbs get linearized.  For what it is worth, the upstream
axienet dmaengine TX path has the same pattern, which is likely why this
has not been observed in practice.

> +
> +	dma_tx_desc = dma_dev->device_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
> +						    nents, DMA_MEM_TO_DEV,
> +						    DMA_PREP_INTERRUPT, NULL);
> +	if (!dma_tx_desc)
> +		goto err_unmap_sg;

[Severity: Low]
Any reason to call the ops member directly rather than use
dmaengine_prep_slave_sg(), which is what ep_rx_submit_desc() in this same
file does?

	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
					      1, DMA_DEV_TO_MEM,
					      DMA_PREP_INTERRUPT);

device_prep_slave_sg is optional: xilinx_dma_probe() installs it only for
XDMA_TYPE_AXIDMA and XDMA_TYPE_AXIMCDMA, while for CDMA it installs only
device_prep_dma_memcpy and for VDMA only device_prep_interleaved_dma.  If a
device tree pointed the endpoint dma-names at a CDMA or VDMA node, the RX
path would degrade gracefully (the wrapper returns NULL) but this line
would be a NULL function pointer call in the xmit path.  Switching to the
wrapper would also make the extra dma_dev local unnecessary.

> +
> +	skbuf_dma->skb = skb;
> +	skbuf_dma->sg_len = sg_len;
> +	dma_tx_desc->callback_param = xchan;
> +	dma_tx_desc->callback_result = ep_dma_tx_cb;
> +
> +	spin_lock_bh(&ep->tx_lock);
> +	xchan->ring_head++;
> +	netdev_tx_sent_queue(txq, skb->len);
> +	netif_txq_maybe_stop(txq,
> +			     CIRC_SPACE(xchan->ring_head,
> +					READ_ONCE(xchan->ring_tail),
> +					TX_BD_NUM_DEFAULT),
> +			     2, 2);
> +	spin_unlock_bh(&ep->tx_lock);
> +
> +	dmaengine_submit(dma_tx_desc);
> +	dma_async_issue_pending(xchan->chan);

[Severity: Medium]
What happens if dmaengine_submit() fails here?  The cookie is discarded
without a dma_submit_error() check, and the ring slot plus the BQL byte
charge have already been committed above.

The provider this driver targets can fail the submit:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_tx_submit() {
	if (chan->err) {
		err = xilinx_dma_chan_reset(chan);
		if (err < 0)
			return err;
	}
	...
}

xilinx_dma_reset() returns -ETIMEDOUT on reset timeout, and in that path
the descriptor is never appended to the pending list, so ep_dma_tx_cb()
never runs for it.

Because the completion retires strictly by ring_tail:

	skbuf_dma = ep_get_desc(xchan,
				xchan->ring_tail & (TX_BD_NUM_DEFAULT - 1));

one lost submit leaves a permanent one-slot offset.  After that, every
completion unmaps the scatterlist and calls dev_consume_skb_any() on a
frame that may still be in flight in the engine, the buffers the engine
actually finished stay mapped, and the length handed to
netif_txq_completed_wake() belongs to a different frame than the one BQL
was charged for.

The bytes charged for the frame that was never queued also stay outstanding
in the DQL forever.  Since ep_netdev_ops registers no .ndo_tx_timeout:

	static const struct net_device_ops ep_netdev_ops = {
		.ndo_open		= ep_open,
		.ndo_stop		= ep_stop,
		.ndo_start_xmit		= ep_start_xmit,
		.ndo_validate_addr	= eth_validate_addr,
		.ndo_set_mac_address	= eth_mac_addr,
	};

__netdev_watchdog_up() never arms the watchdog, so a queue left stopped by
the skewed accounting is never detected or recovered while the interface
stays up.

Would it make sense to submit first and only advance ring_head and call
netdev_tx_sent_queue() once dma_submit_error() reports success, and to add
an .ndo_tx_timeout handler?

> +
> +	return NETDEV_TX_OK;
> +
> +err_unmap_sg:
> +	dma_unmap_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +err_drop_skb:
>  	dev_kfree_skb(skb);
>  	DEV_STATS_INC(ndev, tx_dropped);
>  	return NETDEV_TX_OK;

[ ... ]
