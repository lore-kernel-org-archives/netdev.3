Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482262AD1B
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710401; cv=none; b=jfnVOBMrgr4hLBueuATSgxx1tFP/qVnLUoOLvyXRAxDCGBEWBARsFn8ikvuv+75YIYMy4Uk/6z+OUek1zOVTBlNZA0RvJ3iJ3bsVIDAUlHtIVxhHlzD0VcxgwW/qrAF8Y6VXztzRozoyph7YdDDJOc7l1zcrRkyoi3vp8jNb0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710401; c=relaxed/simple;
	bh=azLlzMV2QrRCsr3ISGgMrOgCAaFrWbSZ5wXzPULIo3w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRA5FqZizsEfC6mr27WUmgXbN/UBCA8Rm7QYtV0+JclyffumeeiJZfiCqLMGoULiQYvyuPvvZZY27oBruA7zGZkZ02JOAC6WqsffBG3xUrTMJjamyVAdO4ALyLbVC71GimU6tjkkpVpEtDwRuMQZcRrBKUNVzl37MSp+K28LrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV2OsVwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV2OsVwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121EE1F000FF;
	Tue, 29 Sep 2026 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710399;
	bh=fKrbhHOEHtQ/A6BxrjMHyjdedmedCoflwL9Y/3vxJQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QV2OsVwMkm+LFN2lyb4H5etNQqunKYxp++zLoco8Yw7mpqf+Qs4YhCUygYTp8K+PS
	 g0sZWXSknTRzKqf/njWvq8gqyc6OjxA47FjPy5+KLUfxG0Iuo2OW7e+6qXaQI1co4w
	 XN5/I5XZP7LmkpePRkwHHj6Up9Fc/efa6QtpjtLdZ6WZr0CVwhEuw2VceBnYNt+bUV
	 W44TdigXrtJdSZIl+FUbv7Ak8JLnJ906y3JnAreVhwDwgGUu+rwh076OfZuN12q0Hm
	 wBf1VzCCGqURgomigSSe8+ZGaQvpv3YyeeogZw4ZTRa37T3sl2/mzpsEbeG2P9N/9I
	 KaacBmG0GpYBg==
Subject: Re: [PATCH net-next v7 06/15] ibmveth: Refactor TX resource
 allocation in open/close paths
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:18 +0000
Message-ID: <179071039865.434549.12128638769769737173@kernel.org>
In-Reply-To:
 <02196cd1ee13b66859544b7ab5fd0bd4d5d61fb9.1790319558.git.mmc@linux.ibm.com>
References:
 <02196cd1ee13b66859544b7ab5fd0bd4d5d61fb9.1790319558.git.mmc@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch moves ibmveth_alloc_tx_resources() to the end of
  ibmveth_open(), after h_register_logical_lan,…
- [Low] The new NULL-LTB guard in ibmveth_start_xmit()
  (drivers/net/ethernet/ibm/ibmveth.c:1874-1878) fixes a NULL-pointer…

Pre-existing issues:
- [Medium] At this commit, the comment added to ibmveth_allocate_tx_ltb()
  ('Caller must ensure tx_ltb_ptr[idx] is NULL.
- [Medium] The retry loop at out_unregister_lan in ibmveth_open() (lines
  1396-1399) discards the final H_FREE_LOGICAL_LAN result.
- [Low] The new drop path in ibmveth_start_xmit() does
  `netdev->stats.tx_dropped++`, a non-atomic read-modify-write on a…

--

ibmveth: Refactor TX resource allocation in open/close paths

This patch moves TX long term buffer (LTB) allocation and freeing in
ibmveth_open() and ibmveth_close() into two new helpers,
ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources(). TX LTB
allocation now happens at the end of open(), after LAN registration and RX
setup, and ibmveth_start_xmit() gains a NULL tx_ltb_ptr[] check. close()
now uses netif_tx_disable() and frees the TX LTBs after
h_free_logical_lan().

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index a22a17e05ae1c..011082db1e085 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1206,12 +1206,27 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,

[ ... ]

> +/* Caller must ensure tx_ltb_ptr[idx] is NULL. open() runs on
> + * probe-zeroed slots; set_channels() skips populated indices.
> + */
>  static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
>  	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does the
precondition in this comment still hold after a failed direct reopen?

ibmveth_set_channels() gates on IFF_UP:

	if (!(netdev->flags & IFF_UP))
		return netif_set_real_num_tx_queues(netdev, goal);

ibmveth_close() gates on adapter->opened:

	if (!adapter->opened)
		return 0;

Say a close()+open() cycle fails, for example from ibmveth_change_mtu() or
pool_store(). IFF_UP stays set and opened is false. If ethtool -L runs
next, it allocates LTBs for [old, goal) and calls
netif_tx_wake_all_queues().

A later close() returns early without freeing those LTBs. The next open()
then calls ibmveth_alloc_tx_resources(), which overwrites the populated
tx_ltb_ptr[] slots.

Does that leak the kzalloc() buffer and its DMA mapping? While the queues
are awake, xmit on them also calls h_send_logical_lan() on a LAN that has
been deregistered.

The commit message defers this ("set_channels() IFF_UP vs opened is later
(P14/P15)"). The later patch "ibmveth: Complete set_channels down-path and
mq_fallback max_rx cap" makes ibmveth_set_channels() check
adapter->opened, which removes the trigger.

[ ... ]

> @@ -1313,24 +1364,24 @@ static int ibmveth_open(struct net_device *netdev)

[ ... ]

>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
>  
> +	rc = ibmveth_alloc_tx_resources(adapter);
> +	if (rc)
> +		goto out_cleanup_rx_interrupts;
> +
>  	netif_tx_start_all_queues(netdev);

[Severity: High]
After this move, RX is live (LAN registered, NAPI enabled, replenish
kicked) while the TX LTBs are still being allocated. Can
ibmveth_start_xmit() run at the same time as ibmveth_alloc_tx_resources()?

On the first open after probe, the TX queues were never marked DRV_XOFF.
netdev_init_one_queue() leaves the queue state zeroed, and probe does not
stop the queues. generic_xdp_tx() in net/core/dev.c checks only the queue
state, not IFF_UP:

	HARD_TX_LOCK(dev, txq, cpu);
	if (!netif_xmit_frozen_or_drv_stopped(txq)) {
		rc = netdev_start_xmit(skb, dev, txq, 0);

If an inbound frame hits a generic XDP program that returns XDP_TX,
ibmveth_start_xmit() can run from NAPI on another CPU during this window.

The only guard is the new plain load of tx_ltb_ptr[queue_num] in
ibmveth_start_xmit(), and the stores on the allocation side are not
ordered against it.

ibmveth_allocate_tx_ltb() stores the pointer before the DMA address:

	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,
					   GFP_KERNEL);
	...
	adapter->tx_ltb_dma[idx] = dma_map_single(&adapter->vdev->dev,

Could an xmit that passes the NULL check build a descriptor from
tx_ltb_dma[queue_num] == 0 and pass it to the already registered LAN
through h_send_logical_lan()?

On a DMA map failure, the same function frees the buffer before clearing
the slot:

		kfree(adapter->tx_ltb_ptr[idx]);
		adapter->tx_ltb_ptr[idx] = NULL;

If a later queue fails, the err_free_ltbs unwind in
ibmveth_alloc_tx_resources() calls ibmveth_free_tx_ltb() on slots that
are already published, and nothing quiesces TX first. The
synchronize_net() under out_cleanup_rx_interrupts runs only after that
unwind.

Could an xmit that is already inside the memcpy() into
tx_ltb_ptr[queue_num] write packet data into freed memory? If it re-reads
the slot after the NULL store, could it oops on a NULL pointer instead?
The commit message itself says NULL-first "is not itself a UAF barrier".

This commit also has a second path in. A reopen fails, then ethtool -L
wakes the queues, then a direct close() skips netif_tx_disable() because
opened is false. open() then runs with TX awake under an active qdisc.

The final patch in the series removes that second path. The first-open
generic XDP path remains at the end of the series, because ibmveth_open()
still starts RX before ibmveth_alloc_tx_resources() and does not stop TX
first.

Would allocating the TX LTBs before registering the LAN and enabling RX,
or stopping TX before RX is enabled, close this window?

> @@ -1338,11 +1389,16 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  	return 0;
>  
> -out_free_buffer_pools:
> +out_cleanup_rx_interrupts:
> +	ibmveth_cleanup_rx_interrupts(adapter);
> +	/* As in close(): a poll past napi_complete_done() may still run. */
> +	synchronize_net();
> +out_unregister_lan:
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>  	ibmveth_free_buffer_pools(adapter);

[Severity: Medium]
This isn't a bug introduced by this patch. The final h_free_logical_lan()
result is thrown away here. The RX pools, RX queue, buffer list and filter
list are then unmapped and freed regardless.

ibmveth_close() does the same thing and only logs the failure:

	if (lpar_rc != H_SUCCESS) {
		netdev_err(adapter->netdev,
			   "h_free_logical_lan failed with %lx, continuing\n",
			   lpar_rc);
	}

If deregistration fails with a non-busy error, could the hypervisor still
be using those buffers after they are unmapped? The answer depends on PHYP
behaviour that the driver code alone cannot confirm.

This patch improves the pool-fail case, which previously made no
deregistration call at all. The later ibmveth_free_all_queues() helper
also documents that callers continue with RX pool and DMA teardown
afterward.

[ ... ]

> @@ -1812,6 +1871,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>  	int i, queue_num = skb_get_queue_mapping(skb);
>  	unsigned long mss = 0;
>  
> +	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
> +		netdev->stats.tx_dropped++;

[Severity: Low]
This is a pre-existing pattern and was not introduced by this patch.
netdev->stats.tx_dropped++ is a non-atomic update to a counter that all TX
queues share, and each queue is serialised only by its own txq lock.

Can drops on different queues at the same time lose increments here?

tx_packets, tx_bytes and tx_dropped already use the same pattern elsewhere
in ibmveth_start_xmit() and ibmveth_is_packet_unsupported(). The later
patch "ibmveth: Add per-queue RX and TX statistics collection" moves these
drops to adapter->tx_qstats[queue_num].dropped_packets.

> +		goto out;
> +	}

[Severity: Low]
This check appears to fix a NULL pointer dereference that exists before
this patch. The patch is described as a refactor and carries no Fixes:
tag.

Before this patch, the sequence is:

ibmveth_change_mtu() / pool_store() / set_csum_offload() / set_tso()
  ibmveth_close()
  ibmveth_open()
    fails (TX LTB kzalloc or DMA map, buffer pool alloc, or
    h_register_logical_lan())
    out_free_tx_ltb: frees every tx_ltb_ptr[]

IFF_UP stays set. ibmveth_set_channels() checks only IFF_UP. It allocates
LTBs for [old, goal), or none at all when shrinking, and then calls
netif_tx_wake_all_queues().

The next ibmveth_start_xmit() on queue 0 then does a memcpy() into the
NULL tx_ltb_ptr[0].

The v7 changelog points to a separate [PATCH net] series carrying Fixes:
d43732ce021f for a related open-fail fix. Should this guard be handled
the same way, so that the crash fix reaches stable trees?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com
