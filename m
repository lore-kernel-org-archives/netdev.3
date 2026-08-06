Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE038AC8C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041433; cv=none; b=FvRa18bAWuCIc+jrytPq9zbY+iMmVbIPgS7a0ZKoUBzdCo+4TrBn/igXBLRrg0UNpVf7QIod3+K/0JSKzFOlh7GiBGhqO9F84P2xQ2O2r3CDx+Dx/0WVMy63hcuvnNRPTfbzGXhcpOG3+JxNgVArCal79NB9MJURnw5VUInGQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041433; c=relaxed/simple;
	bh=myoyzkqC8QL5sL+Zxf+wzv7LcDSQEoQNtV35rGJBHm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UH8tSHkyad2wo7K2LhvM5d4WBokAOreYPKicGDXBETQU53nyYokbznvVKsZUozznR6ZL9KyWp1o1XRb6+MzqX0K+eIPdOBmnh3mHNPHvu8Hp43OQVyLHBasXa/+NxcmghdV7eWiPLDPPHW+gk1dTctErw4cNBgpVsA9QOvAdcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXO25lmb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXO25lmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F21F00A3A;
	Thu,  6 Aug 2026 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041427;
	bh=zaR4JHv1bKV9s+VwwvyqGdtrYMsfXB8/Yfp9wInQJQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXO25lmbdoAki1jcLv2aVL3OKyqrCdaIRf4eKARJyAsWO4TUJKOeRO+OnHWklr3hs
	 2VFZn2l9ZbtIhyqyOh2g/XQnfrbX9HA11GhTWNTZB6/WpXTojFfkYHNrgC+kd/3vTP
	 sgBacKC1DFGWLYXXANIF9JqDhye4pnJgN6lBpmrj3s9bh7TyM9JXhbRs5TUYHwnsO+
	 b7zt4TUIUMVEaQ6VgZ9WKOF9GrVyrL2iHxXDrQuR7EnvkdobM4aiIMlrXe2/ZHmnph
	 Y1IRsLP9n8AFaXwrUHAYHLa2TNNKAK0N6g2pdYEcASQsc1ZnAW9dPTIdI678GrMR02
	 AgRavjYlD3iNA==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 07/14] ibmveth: Add RX queue register/deregister helpers for MQ
Date: Thu,  6 Aug 2026 11:37:06 -0700
Message-ID: <20260806183706.3175447-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e415d7657c48f0848763b9781c7af3d8d3abc276.1785457143.git.mmc@linux.ibm.com>
References: <e415d7657c48f0848763b9781c7af3d8d3abc276.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Add RX queue register/deregister helpers for MQ

This patch factors the queue-0 control-plane work out of
ibmveth_open()/ibmveth_close() into ibmveth_register_rx_queues() and
ibmveth_free_all_queues(), teaches ibmveth_register_logical_lan() to use
h_register_logical_lan_with_handle() once multi_queue is set, and adds
adapter->hcall_stats. Runtime behaviour stays single-queue.

A few questions about the new open/close teardown pipeline below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 131c1a61d9e7e..9d1242dbcb19d 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1182,14 +1201,89 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
>  	return rc;
>  }
>  
> +/**
> + * ibmveth_free_all_queues - Free all RX queues at once
> + * @adapter: ibmveth adapter structure
> + *
> + * Uses H_FREE_LOGICAL_LAN to free all queues in one hypercall.
> + * Used during interface close and registration error cleanup.
> + *
> + * Clears queue handles only; queue_irq[] is released by
> + * ibmveth_cleanup_rx_interrupts().
> + */
> +static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
> +{
> +	unsigned long lpar_rc;
> +	int i;
> +
> +	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
> +
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +		adapter->hcall_stats.free_lan++;
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> +
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan failed: %ld\n", lpar_rc);
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		adapter->queue_handle[i] = 0;
> +}

[Severity: Low]
Where is the firmware contract for this documented?  The helper issues one
adapter-level h_free_logical_lan() and then clears queue_handle[] for all
num_rx_queues entries, which assumes that the single hcall also
deregisters the subordinate queues that later patches register with
H_REG_LOGICAL_LAN_QUEUE.

The header already provides a per-queue wrapper that this path never uses:

  static inline long h_free_logical_lan_queue(unsigned long unit_address,
					      unsigned long queue_handle)

The assumption cannot be exercised at this commit because multi_queue is
still 0, and the helper is unchanged at the end of the series, so nothing
in the series validates it.  The changelog justifies the new ordering with
"PHYP cannot retain a registered LAN while its DMA-backed RX pools are
released"; if H_FREE_LOGICAL_LAN does not release subordinate queue
registrations, then ibmveth_free_buffer_pools() and
ibmveth_cleanup_rx_resources() would unmap memory PHYP still owns.

Could the PAPR reference for the subordinate-queue semantics be stated in
the kerneldoc or the changelog before the MQ enablement patch relies on it?

[ ... ]

> @@ -1252,10 +1332,9 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  out_cleanup_rx_interrupts:
>  	ibmveth_cleanup_rx_interrupts(adapter);
> -out_unregister_lan:
> -	do {
> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> +out_unregister_queues:
> +	ibmveth_free_all_queues(adapter);
> +out_free_buffer_pools:
>  	ibmveth_free_buffer_pools(adapter);
>  out_free_queue_mem:
>  	ibmveth_cleanup_rx_resources(adapter);

[Severity: High]
This isn't a bug introduced by this patch, but should the unwind here leave
state that a later ibmveth_close() can walk again?

ibmveth_set_csum_offload(), ibmveth_set_tso() and ibmveth_change_mtu() call
ibmveth_close()/ibmveth_open() directly instead of dev_close()/dev_open(),
so when the re-open fails the error is only returned as an errno while
IFF_UP and netif_running() stay set:

	if (restart)
		rc2 = ibmveth_open(dev);

	return rc1 ? rc1 : rc2;

After that failed open, every RX resource is freed (buffer_list_addr[] is
NULLed by ibmveth_cleanup_rx_resources()), NAPI is left disabled, and
queue_irq[0] is deliberately kept populated.  The next ndo_stop, for
example retrying the same ethtool command or an "ip link set dev X down",
re-enters ibmveth_close() -> ibmveth_cleanup_rx_interrupts(), which does:

	for (i = 0; i < adapter->num_rx_queues; i++)
		napi_disable(&adapter->napi[i]);

	for (i = 0; i < adapter->num_rx_queues; i++) {
		if (adapter->queue_irq[i])
			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
	}

Can the second napi_disable() ever return?  napi_disable_locked() leaves
NAPIF_STATE_SCHED|NAPIF_STATE_NPSVC set, and the second call waits in
usleep_range() for bits that no poll will clear, with rtnl held by the
ndo_stop caller.  The free_irq() that follows also refers to an IRQ that is
no longer requested.

If it did get past those, ibmveth_update_rx_no_buffer() would dereference
the now-NULL buffer_list_addr[0]:

	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;

and ibmveth_free_all_queues() would issue H_FREE_LOGICAL_LAN for a LAN that
is not registered.

The baseline close() already had an unconditional napi_disable(), so the
hang predates this patch, but this patch centralizes and extends the
unconditional teardown (now also free_all_queues() plus the NULL-able
buffer_list_addr[0] read) without an "already torn down" guard, and the
same structure survives to the end of the series.  Would a state check at
the top of ibmveth_close(), or switching those callers to
dev_close()/dev_open(), be preferable?

> @@ -1268,7 +1347,6 @@ static int ibmveth_open(struct net_device *netdev)
>  static int ibmveth_close(struct net_device *netdev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> -	long lpar_rc;
>  
>  	netdev_dbg(netdev, "close starting\n");
>  
> @@ -1277,18 +1355,8 @@ static int ibmveth_close(struct net_device *netdev)
>  	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
>  	ibmveth_free_tx_resources(adapter);
>  	ibmveth_cleanup_rx_interrupts(adapter);

[Severity: Medium]
Does the PHYP mask taken by ibmveth_cleanup_rx_interrupts() actually stay
in effect until free_irq()?

The helper masks queue 0 and calls synchronize_irq() before napi_disable():

	ibmveth_disable_irq(adapter, i);
	synchronize_irq(adapter->queue_irq[i]);
	...
	for (i = 0; i < adapter->num_rx_queues; i++)
		napi_disable(&adapter->napi[i]);

But a poll that is already in flight unmasks it again on completion, with
no coordination against teardown:

ibmveth_poll()
	if (!napi_complete_done(napi, frames_processed))
		goto out;

	/* We think we are done - reenable interrupts, ... */
	lpar_rc = ibmveth_enable_irq(adapter, 0);

So napi_disable() can return with the source unmasked.  In the window
before free_irq(), an RX interrupt is then delivered and
ibmveth_interrupt() -> ibmveth_schedule_rx_queue() sees napi_schedule_prep()
fail and returns IRQ_HANDLED without masking, since masking only happens on
the napi_schedule_prep() success branch.  Can a VIO source with pending RX
re-assert repeatedly until free_irq() shuts the line down, and can
ibmveth_free_all_queues() then issue H_FREE_LOGICAL_LAN while the source is
still unmasked?

The kerneldoc in cleanup_rx_interrupts() states "Mask PHYP before
napi_disable so ibmveth_interrupt cannot return IRQ_HANDLED without
masking", which does not seem to hold when the poll itself is the entity
that unmasks.  The pre-series code did napi_disable() first, then
h_vio_signal(VIO_IRQ_DISABLE), then free_irq(); this patch propagates the
new ordering into the open-failure unwind as well and places
ibmveth_free_all_queues() behind it, and ibmveth_poll() still unmasks
unconditionally at the end of the series.

> -
> -	do {
> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
> -			   "continuing with close\n", lpar_rc);
> -	}
> -
>  	ibmveth_update_rx_no_buffer(adapter);
> -
> +	ibmveth_free_all_queues(adapter);

[Severity: Low]
Was moving ibmveth_update_rx_no_buffer() ahead of the H_FREE_LOGICAL_LAN
intentional?

Previously the counter was read after h_free_logical_lan() returned, so the
hypervisor was no longer writing it.  ibmveth_update_rx_no_buffer() reads
the last 8 bytes of the DMA-mapped buffer_list page that PHYP updates:

	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;

	adapter->rx_no_buffer = be64_to_cpup(p);

At the new call site the LAN is still registered, so frames can still be
dropped and counted after the snapshot, and those drops are lost from the
rx_no_buffer value reported by ethtool -S.

The 7-step close pipeline in the changelog does not mention
ibmveth_update_rx_no_buffer() at all:

  ibmveth_close():

    1. netif_tx_stop_all_queues()
    2. ibmveth_free_tx_resources()
    3. ibmveth_cleanup_rx_interrupts() - mask PHYP, napi_disable, free_irq
    4. ibmveth_free_all_queues()       - H_FREE_LOGICAL_LAN
    5. ibmveth_free_buffer_pools()
    6. ibmveth_cleanup_rx_resources()
    7. ibmveth_free_filter_list()

Could the step list be updated to include it and to say where it belongs
relative to H_FREE_LOGICAL_LAN?  The ordering is unchanged through the end
of the series.

>  	ibmveth_free_buffer_pools(adapter);
>  	ibmveth_cleanup_rx_resources(adapter);
>  	ibmveth_free_filter_list(adapter);

[ ... ]
