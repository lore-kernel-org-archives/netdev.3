Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0E4FECDE
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459038; cv=none; b=lBsLSwS64dnTH22HMd7IXWOYCOOZ+//rdRyfMl5p8J3nktsxqwlYqpvV8v9pOtmYSG1z0nLBS2uRNHLS5yfBnsLw/IoIuffEMxHqYrDVEx+g+vMp3QcoLNxdr4dbkiqoklvRfhVFxSthlPTc64UMvkhcRG0MVCSUIlbvvjI/7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459038; c=relaxed/simple;
	bh=0WlcPF2ejY9uDTERzWsz4HlzvItLTlUXRwnvTxWgj7Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pN8brvKP1KuSMgHj+cNLIw60DuXsKZjtqBAFhf63w9PszEo5gV/1qaey2tPWUNT2s9MSFsEK1GK0z0ZTIeK5kIneld38PrgsWk235njSyvVx2JdSzpelFQzfMd/v3N4Sa2YxO3q5QcHKm3bJJRjtHgz4Ph3ce2WzWMdu9E/0bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axJJhwTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axJJhwTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE751F00A3F;
	Thu,  3 Sep 2026 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459037;
	bh=hHWkQO/URj8tgseb7SMStkKKOTVSkbUUE9l1d480uFE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=axJJhwTkstPRhO5WuCNk7Ac60w8VcloHGrSziy1Rpw1AgqbzB3Ox5xK2QRByWLzMT
	 BqVrNKJ/aiKC06PWZXiEupHi4Gn6QHxfwaDs7aRXZ1d5+kS31opJRDsVqVAAW9/1Fm
	 Awc2y9OQ+1OQlTnfbb0yk6Xpjll7ugCu0uq7d4veoXvcFtBAbqmV0yI61VWBicn9dU
	 T+9Ykw9uxpp24bhSyXHOsdC41d75Q0Iat8glicjSHDYxiXeQkj5aF21AIFOJoC6MT9
	 HBwS+4KEmcw1JlBwDY2ntQwBuPTcGyNfgNIDdbNFdUgqcH2zGz/ppec8MYJdMRJZk0
	 D4zZklBwTvouA==
Subject: Re: [net-next,v6,06/15] ibmveth: Refactor TX resource allocation in
 open/close paths
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:35 +0000
Message-ID: <178845903572.3394541.18066559713836022844@kernel.org>
In-Reply-To:
 <e07afab0a0129a7b01d24113d9d74bc10c7dc7de.1788102125.git.mmc@linux.ibm.com>
References:
 <e07afab0a0129a7b01d24113d9d74bc10c7dc7de.1788102125.git.mmc@linux.ibm.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (2)

- [Medium] The patch silently repairs a live mainline bug while
  presenting itself as a TX refactor.

Pre-existing issues:
- [Low] Concern (assessed as a FALSE POSITIVE): the new `if
  (unlikely(!adapter->tx_ltb_ptr[queue_num]))` guard in…
- [Low] Concern (assessed as a FALSE POSITIVE for the final series
  state): ibmveth_alloc_tx_resources() calls ibmveth_allocate_tx_ltb()…

--

ibmveth: Refactor TX resource allocation in open/close paths

This moves the per-queue TX LTB allocation and free out of ibmveth_open()
and ibmveth_close() into ibmveth_alloc_tx_resources() and
ibmveth_free_tx_resources(), moves the TX allocation to the end of open()
after RX interrupt setup, and adds a tx_ltb_ptr[] check to
ibmveth_start_xmit(). It also reworks the open() failure unwind labels.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 335712faaa42a..7a420e1a41d52 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1201,12 +1201,27 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  
>  static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
> -	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
> -			 adapter->tx_ltb_size, DMA_TO_DEVICE);
> -	kfree(adapter->tx_ltb_ptr[idx]);
> +	void *ltb = adapter->tx_ltb_ptr[idx];
> +	dma_addr_t dma = adapter->tx_ltb_dma[idx];
> +
> +	if (!ltb)
> +		return;
> +
> +	/*
> +	 * Clear the slot before releasing it. start_xmit() tests
> +	 * tx_ltb_ptr[idx] to decide whether the LTB is usable.
> +	 */
>  	adapter->tx_ltb_ptr[idx] = NULL;
> +	adapter->tx_ltb_dma[idx] = 0;
> +
> +	dma_unmap_single(&adapter->vdev->dev, dma, adapter->tx_ltb_size,
> +			 DMA_TO_DEVICE);
> +	kfree(ltb);
>  }
>  
> +/* Caller must ensure tx_ltb_ptr[idx] is NULL. open() runs on
> + * probe-zeroed slots; set_channels() skips populated indices.
> + */
>  static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
>  	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,

[Severity: Low]
This is a pre-existing style point rather than something this patch breaks,
but the new kdoc on ibmveth_allocate_tx_ltb() states an invariant that the
helper itself never checks:

  /* Caller must ensure tx_ltb_ptr[idx] is NULL. ...

and ibmveth_alloc_tx_resources() below calls it unconditionally for every
index in [0, real_num_tx_queues). If a slot were ever populated on entry,
the kzalloc() would overwrite the old pointer and leak both the 64 KiB
buffer and its streaming DMA mapping.

Tracing the callers, the only way to reach open() with a populated slot was
ibmveth_set_channels() gating on IFF_UP instead of adapter->opened, and a
later patch in this series makes set_channels() return early on !opened
before it touches the LTBs, so no reachable caller can present a populated
index. Would a WARN_ON_ONCE(adapter->tx_ltb_ptr[idx]) (or just an early
return) be worth adding so the documented precondition is enforced rather
than only described?

[ ... ]

> @@ -1308,24 +1359,24 @@ static int ibmveth_open(struct net_device *netdev)
>  				     rxq_desc.desc,
>  				     mac_address);
>  		rc = -ENONET;
> -		goto out_free_tx_ltb;
> +		goto out_free_queue_mem;
>  	}
>  
>  	rc = ibmveth_alloc_buffer_pools(adapter);
>  	if (rc)
> -		goto out_free_tx_ltb;
> +		goto out_unregister_lan;
>  
>  	rc = ibmveth_setup_rx_interrupts(adapter);
> -	if (rc) {
> -		do {
> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -		goto out_free_buffer_pools;
> -	}
> +	if (rc)
> +		goto out_unregister_lan;
>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
>  
> +	rc = ibmveth_alloc_tx_resources(adapter);
> +	if (rc)
> +		goto out_cleanup_rx_interrupts;
> +
>  	netif_tx_start_all_queues(netdev);
>  
>  	adapter->opened = true;
> @@ -1333,11 +1384,14 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  	return 0;
>  
> -out_free_buffer_pools:
> +out_cleanup_rx_interrupts:
> +	ibmveth_cleanup_rx_interrupts(adapter);
> +out_unregister_lan:
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>  	ibmveth_free_buffer_pools(adapter);
> -out_free_tx_ltb:
> -	while (--i >= 0)
> -		ibmveth_free_tx_ltb(adapter, i);
> +out_free_queue_mem:
>  	ibmveth_cleanup_rx_resources(adapter);

[Severity: Medium]
Should the h_free_logical_lan() part of this hunk be split out as its own
patch with a Fixes: tag and Cc: stable?

Rerouting the ibmveth_alloc_buffer_pools() failure to out_unregister_lan
looks like a real bug fix, not just a label rename. At the series merge base
(1b78070aaef6) that failure path in ibmveth_open() runs:

  rc = ibmveth_alloc_buffer_pools(adapter);
  if (rc)
          goto out_free_buffer_pools;
  ...
  out_free_buffer_pools:
          while (--i >= 0) { ... }
  out_unmap_filter_list:
          dma_unmap_single(dev, adapter->filter_list_dma, 4096,
                           DMA_BIDIRECTIONAL);

so the filter list, the buffer list and the RX completion ring are unmapped
and freed while the logical LAN registered by ibmveth_register_logical_lan()
is still live. Only the request_irq() failure path issued the hcall. This
patch is the first place that path deregisters, which matches the commit
message note:

  "After LAN registration, open-fail teardown issues h_free_logical_lan()
  before RX pool DMA teardown on the pool-fail path that previously never
  issued that hcall (missing deregistration, not a preference reorder)."

The concern is packaging rather than correctness of the code here. As
written, the fix for an ifup-under-memory-pressure path that leaves PHYP
registered against freed DMA memory is folded into a TX helper refactor with
no Fixes: tag, no Cc: stable and no statement of the failure mode.

The next patch in the series ("ibmveth: Add RX queue register helpers for
MQ") then moves pool allocation ahead of registration, so this arrangement
is transient inside the series and no single commit is backportable for the
mainline/stable bug. Could the deregistration fix be lifted to a standalone
patch at the front of the series?

[ ... ]

> @@ -1807,6 +1864,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>  	int i, queue_num = skb_get_queue_mapping(skb);
>  	unsigned long mss = 0;
>  
> +	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
> +		netdev->stats.tx_dropped++;
> +		goto out;
> +	}
> +
>  	if (ibmveth_is_packet_unsupported(skb, netdev))
>  		goto out;
>  	/* veth can't checksum offload UDP */

[Severity: Low]
This isn't a bug introduced by the patch, and after checking it appears to
be safe, but the shape of the new guard invites the question. The check
reads adapter->tx_ltb_ptr[queue_num] once, then the body re-reads the same
slots later:

  memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
  ...
  desc.fields.address = adapter->tx_ltb_dma[queue_num];

Since ibmveth_free_tx_ltb() now NULLs the slot before the unmap, is the
guard intended as a race barrier, or purely as a check for a slot that is
already known to be quiesced?

Every free site does look quiesced independently of this check:
ibmveth_close() calls netif_tx_disable() plus synchronize_net() before
ibmveth_free_tx_resources(); the ibmveth_set_channels() shrink frees only
after netif_set_real_num_tx_queues(), which does synchronize_net() on the
disabling path; and the open() unwind runs with all TX queues still XOFF.

The commit message already says as much:

  "NULL-first in free_tx_ltb() only closes the check-then-use window, it is
  not itself a UAF barrier."

Would it be clearer to state next to the guard that TX is quiesced at all
free sites, so the single read is not load-bearing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com
