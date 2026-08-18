Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06B4B049B
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017644; cv=none; b=teNqmbg77mOlj1TTjR0zghEtOiVeBT+XR8jpavJLFMEtvuJsuei/d/IDA+EUoww9EsId9yUtBgNxH+CNp0OXHA0hQuf8LpnG7dPv17scpFdtLs2qf5tcDuHMZfPwsMxtRcEfdLoRxDnV/FQ8Wm1Aitg2A6yNpQmJ8OImRxuu1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017644; c=relaxed/simple;
	bh=fUwTnwv/KQ0NH7HajdULE6GdmzChfNq7QTBkd06QAr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qan2RNgn6PbYeAvy6RirBJFNgm9E1/RxTgIjuFLEnf1RQLWAiJdeVQBjUBZwpq5iVWwX42wuPTtYYo3ip/Q7b6oJGIk3w2m+iXB9f2FsEDwCXvhg4cvjsRZyDkTT2Uifl4oHOju2cMdsD7dZTFpUqXmS8iF5w7yA2Sj/mS1gqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2yIOoFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2yIOoFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9571F00A3A;
	Tue, 18 Aug 2026 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017642;
	bh=Z//6XvCnpw33U0V5zgEvxtKKwYyJ/oy/G42ztnrunFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2yIOoFDj3jXuRUB6lwQrnv6b3xFMIzimFN5Pitd4pEQvRIzZ92zKVYYw2ACXV25f
	 7u0+4hllNJfrAYeUcp2MdX/EHu0cqkayQ02y2W6WXPs4yNyLEdpSA5dt+mAJ4GMdL7
	 Ry15UclFgaplT6gIGT5vXqWDyERg6wktvEXT2dIoVVk/y0KUr/BIHPfndAgNAENMWp
	 fh2N/KybXWUZ8U502gZsiRMlELBykNx7zwNeRDCvdx/JYScnSUqY5yqUFvoGr3rou/
	 UvnL38Sm/T4YS7Tqg+lDtmSIGR/GG3ieNL7FUdrxnoCcLEemDZziENFrq5+4rJNwRY
	 1LPS49meOTbAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	nnac123@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	davemarq@linux.ibm.com,
	bjking1@linux.ibm.com,
	shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v5 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Mon, 17 Aug 2026 18:47:21 -0700
Message-ID: <20260818014721.3854017-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-5-mmc@linux.ibm.com>
References: <20260814073642.24630-5-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Refactor buffer pool management for per-queue MQ RX

This moves the five RX buffer pools to a per-queue array and introduces
ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools() plus the
per-queue helpers, wiring them into open() and close(). Queue 0 stays the
template for pool geometry and activation, and runtime is still
single-queue.

A few questions below about the new unwind paths and about two of the
new comments.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 168940bfa1094..1a428ee60d58c 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -627,6 +627,142 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>  	}
>  }
>  
> +/**
> + * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue

[ ... ]

> +/**
> + * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
> + * @adapter: ibmveth adapter structure
> + * @queue: queue index
> + *
> + * Allocates backing storage for each active pool on @queue.
> + * Inactive pools (!active) are skipped. Pool metadata must be
> + * initialized before calling this function.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
> +					    int queue)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		struct ibmveth_buff_pool *bpool =
> +			&adapter->rx_buff_pool[queue][i];
> +
> +		if (!bpool->active)
> +			continue;
> +
> +		if (ibmveth_alloc_buffer_pool(bpool)) {
> +			netdev_err(netdev,
> +				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
> +				   queue, i,
> +				   bpool->buff_size,
> +				   bpool->size);
> +			bpool->active = 0;
> +			/* Free by allocation presence, not active — the
> +			 * failing pool cleared active first and would be
> +			 * skipped by an active-only unwind.
> +			 */

[Severity: Low]
Is the stated rationale in this comment accurate?  Freeing by allocation
presence is a fine policy for the later resize paths, but the specific
claim that an active-only unwind would skip the failing pool and leak it
does not seem to hold here, because ibmveth_alloc_buffer_pool() already
undoes its own partial allocations before returning -1:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_alloc_buffer_pool() {
	pool->dma_addr = kzalloc_objs(dma_addr_t, pool->size);
	if (!pool->dma_addr) {
		kfree(pool->free_map);
		pool->free_map = NULL;
		return -1;
	}

	pool->skbuff = kcalloc(pool->size, sizeof(void *), GFP_KERNEL);

	if (!pool->skbuff) {
		kfree(pool->dma_addr);
		pool->dma_addr = NULL;

		kfree(pool->free_map);
		pool->free_map = NULL;
		return -1;
	}
	...
}

By the time bpool->active = 0 runs, free_map/dma_addr/skbuff are all NULL
for the failing pool, so there is nothing for an active-only unwind to
miss.  The same claim appears in the changelog ("v4 fail path freed by
active and skipped the failing pool", "open-fail cannot leak partially
allocated pools").  Could the comment and changelog instead justify
free-by-presence purely in terms of the later resize paths?

> +			ibmveth_free_queue_buffer_pools(adapter, queue);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> +	/* Allocate actual buffers for all queues */
> +	for (q = 0; q < adapter->num_rx_queues; q++) {
> +		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
> +		if (rc) {
> +			/* Free pools for all previous queues */
> +			while (--q >= 0)
> +				ibmveth_free_queue_buffer_pools(adapter, q);
> +			return rc;
> +		}
> +	}
> +
> +	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
> +		   adapter->num_rx_queues);

[Severity: Low]
This isn't a bug, but adapter->num_rx_queues is declared as
"unsigned int num_rx_queues;" in drivers/net/ethernet/ibm/ibmveth.h, so
should these two new messages use %u rather than %d?  The same applies to
the netdev_dbg() in ibmveth_free_buffer_pools() below.

> +	return 0;
> +}
> +
> +/**
> + * ibmveth_free_buffer_pools - Free buffer pools for all queues
> + * @adapter: ibmveth adapter structure
> + *
> + * Frees buffer pools for all queues using the helper function.
> + */
> +static void
> +ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
> +{
> +	int q;
> +
> +	/* Free buffer pools for all queues */
> +	for (q = 0; q < adapter->num_rx_queues; q++)
> +		ibmveth_free_queue_buffer_pools(adapter, q);
> +
> +	netdev_dbg(adapter->netdev, "freed buffer pools for %d queue(s)\n",
> +		   adapter->num_rx_queues);
> +}
> +
>  /**
>   * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>   * @adapter: adapter instance
> @@ -851,16 +987,9 @@ static int ibmveth_open(struct net_device *netdev)
>  		goto out_free_tx_ltb;
>  	}
>  
> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> -		if (!adapter->rx_buff_pool[0][i].active)
> -			continue;
> -		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
> -			netdev_err(netdev, "unable to alloc pool\n");
> -			adapter->rx_buff_pool[0][i].active = 0;
> -			rc = -ENOMEM;
> -			goto out_free_buffer_pools;
> -		}
> -	}
> +	rc = ibmveth_alloc_buffer_pools(adapter);
> +	if (rc)
> +		goto out_free_tx_ltb;

[Severity: Medium]
This isn't a gap introduced by this patch (the old inline pool loop fell
through to the same labels), but since the edge is being rewritten here:
this goto is taken after ibmveth_register_logical_lan() has already
succeeded, and the unwind it lands on never issues h_free_logical_lan():

out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);
	ibmveth_cleanup_rx_resources(adapter);
out_free_filter_list:
	ibmveth_free_filter_list(adapter);

ibmveth_cleanup_rx_resources() does the dma_unmap_single() of
buffer_list_dma[], the dma_free_coherent() of the RX completion queue and
the free_page() of the buffer-list page, and ibmveth_free_filter_list()
releases the filter list, all while PHYP still holds those addresses.  The
adjacent request_irq() failure path does perform the handshake the driver
otherwise considers mandatory:

		do {
			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

Can PHYP write the rx_no_buffer counter into the freed buffer-list page, or
post a completion into the freed RX queue, after this path returns?  The
h_vio_signal(VIO_IRQ_DISABLE) issued just before registration also is not
rebalanced here.

Later patches in this series do repair this: "ibmveth: Refactor TX resource
allocation in open/close paths" retargets this edge to out_unregister_lan,
and by the end of the series ibmveth_open() allocates the pools before
ibmveth_register_rx_queues() and routes post-registration failures through
ibmveth_free_all_queues() -> h_free_logical_lan().  Would it be reasonable
to point this goto at a label that unregisters the logical LAN already in
this patch, so the intermediate commit is not bisect-visible?

>  
>  	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>  	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
> @@ -885,11 +1014,7 @@ static int ibmveth_open(struct net_device *netdev)
>  	return 0;
>  
>  out_free_buffer_pools:
> -	while (--i >= 0) {
> -		if (adapter->rx_buff_pool[0][i].active)
> -			ibmveth_free_buffer_pool(adapter,
> -						 &adapter->rx_buff_pool[0][i]);
> -	}
> +	ibmveth_free_buffer_pools(adapter);
>  out_free_tx_ltb:
>  	while (--i >= 0)
>  		ibmveth_free_tx_ltb(adapter, i);

[Severity: Medium]
This is a pre-existing issue rather than one introduced here, but does this
hunk silently fix a TX long-term-buffer leak?

In the parent commit the pool unwind consumed i:

out_free_buffer_pools:
	while (--i >= 0) {
		if (adapter->rx_buff_pool[0][i].active)
			ibmveth_free_buffer_pool(adapter,
						 &adapter->rx_buff_pool[0][i]);
	}
out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);

so on reaching out_free_tx_ltb by fall-through, i was already -1 and the
first test of --i evaluated to -2, meaning no tx_ltb_ptr[]/tx_ltb_dma[]
buffer was released.  With the pool unwind now a helper call that does not
touch i, i still holds the TX queue count from the completed TX allocation
loop, so the TX LTBs are freed.

Every PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE) TX buffer plus its DMA mapping was
leaked on each failing open, and it repeats per attempt ("ip link set <dev>
up" under memory pressure, or the close+open pair inside veth_pool_store(),
ibmveth_change_mtu() and ibmveth_reset()).

Would it make sense to split this out as its own patch with a Fixes: tag so
stable trees pick it up, or at least describe it in the changelog?

>  
> @@ -928,14 +1053,10 @@ static int ibmveth_close(struct net_device *netdev)

[ ... ]
