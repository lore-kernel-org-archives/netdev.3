Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE437FF40
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034492; cv=none; b=lJXn2JqfWbMnr3CH1An53Vp6n6VNFlUD5Nk/9r6+s+23/ok0J15KRdH0BHHBm20SBWzZRNKQW2oQ4NPLH0/4KRMX9SVK3P3agb33elnL9jXXbnCK8Jcvx8sTuW4Du5yW3H44Lgp+vFqTe9VapzLcQ6B1G44AeyilbmfMi0Ehcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034492; c=relaxed/simple;
	bh=ypxAfB2Agl5+HZgmOO2oQLVT4UbaFvmHnwTHa5kygaQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxObyo0H7XyqhwjLZMcuBEmRDLrRgUyVZ1yG0olUczaPg1SziQ8rPvSGhTA2Dv4hCYYf2TbuI6pV3mWDrIzumQeyAb7GvXnDGU19gsQCLFpGKwiW+T+/YhpmjWHOHGNEHW2BwkbOh7D9u907L7iLwsjSkIbfh5U0kVWqYkAo4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxMRjNp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxMRjNp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DA21F000FF;
	Thu, 10 Sep 2026 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034489;
	bh=ex606ZDD6R2Ky7s9YD7XGQZyP1ABrG0R25HHsUWE2oc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PxMRjNp4o9g2l4mwa8Bydu7k/lDr+jeoldvoHKZXtr2Wgqq4fmBU06LSCfkwCUzLT
	 SAOy0IE1BmHWnloOKLXb+jFhLoutMSqcLBG5g5s3TKABMGQJL0yevCYmXYUAKWMgyI
	 OhoJkJMVEwd25EJaj10DzryQwkydPc7ZInIhdlWYmGbQgbC2qlLXRvZ0wX3KKcQTYE
	 pih9EIZQSnBcg3Oj/13qncht7hk+1POrps7p7VVpEYHjo4k+IoLtEcKahPKBKOKcBY
	 lbrEn87JRWvS/LoO9tq4oIgXXdoxVz5PnakZZBs0/5qpRVhshnsWglEXgnikaS2yN6
	 dkNvAUzt1mRMw==
Subject: Re: [PATCH net-next v5] net: Wangxun: protect ring accesses with RCU
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Date: Thu, 10 Sep 2026 10:01:28 +0000
Message-ID: <178903448885.219967.11444647645606742302@kernel.org>
In-Reply-To: <20260909090005.79368-1-mengyuanlou@net-swift.com>
References: <20260909090005.79368-1-mengyuanlou@net-swift.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 3 (2) · Low: 1

- [High] wx_xmit_frame() now guards against wx->tx_ring[r_idx] being NULL
  during teardown, but the line immediately above still does `if (r_idx…
- [Medium] The commit body states that the pre-patch code can produce
  "NULL pointer dereferences or Use-After-Free (UAF) issues" when…
- [Medium] wx_xmit_frame() now reads the newly __rcu-annotated ring
  pointer with the classic rcu_dereference(), but it is the…
- [Medium] Bypassing lockdep validation by passing `1` as the lock
  condition to `rcu_dereference_protected()`.
- [Low] The commit message claims that during "interface stop" ring
  pointers "can be cleared to NULL and freed asynchronously via…

Pre-existing issues:
- [High] wxvf_suspend() (wx_vf_common.c:14-24), also used by
  wxvf_shutdown(), only does netif_device_detach() and then…
- [Medium] ngbe_set_ringparam() (ngbe_ethtool.c) and
  txgbe_set_ringparam() (txgbe_ethtool.c) initialise err to 0, call…
- [Medium] ngbe_setup_tc() (ngbe_main.c:620-645) and txgbe_setup_tc()
  (txgbe_main.c:611-635) close the running device, destroy the interrupt…

--

net: Wangxun: protect ring accesses with RCU

This annotates wx->tx_ring[] and wx->rx_ring[] with __rcu, converts the
lockless readers to rcu_dereference() inside rcu_read_lock() sections with
NULL checks, publishes and clears the slots with rcu_assign_pointer(), and
uses rcu_dereference_protected() in the control paths.

A couple of questions about the changelog and the converted call sites
below.

Two notes on the commit message first.

> Concurrency between interface reconfiguration and background tasks (such
> as service tasks, dev_get_stats, or PTP watchdogs) can result in NULL
> pointer dereferences or Use-After-Free (UAF) issues when accessing
> per-queue structures.

[Severity: Medium]
The v5 changelog says the description was reworded "to suit net-next rather
than a bug fix" and that the Fixes: tag was dropped, but the text above
still describes a real crash in shipped kernels.

Before this patch wx_update_stats() dereferenced wx->rx_ring[i] and
wx->tx_ring[i] unconditionally after only a non-atomic gate:

	if (test_bit(WX_STATE_DOWN, wx->state) ||
	    test_bit(WX_STATE_RESETTING, wx->state))
		return;

and it is reached from wx_get_stats64(), the ndo_get_stats64 callback,
which dev_get_stats() calls without RTNL (for example from /proc/net/dev
readers).

Meanwhile wx_free_q_vector() NULLs the slots and hands the containing
q_vector to kfree_rcu() during ethtool -L / setup_tc, and the pre-existing
READ_ONCE() plus NULL check already in wx_get_stats64() suggests the array
was known to be observable mid-teardown.

Since the state test is a check-then-use rather than mutual exclusion, is
the affected part of this change actually a fix that stable trees need,
and would a Fixes: tag be appropriate so backport tooling can find it?

> During queue teardown, interface stop, or channel reconfiguration (e.g. via
> ethtool -L), ring pointers in wx->rx_ring[] and wx->tx_ring[] can be
> cleared to NULL and freed asynchronously via kfree_rcu().

[Severity: Low]
Is "interface stop" accurate here? The ndo_stop implementations
ngbe_close(), txgbe_close() and wxvf_close() bring the device down and
release descriptor resources through wx_free_resources()/wx_free_irq(),
but none of them calls wx_clear_interrupt_scheme(), so the ring array
stays published and no q_vector is handed to kfree_rcu().

Only interrupt-scheme teardown clears the slots:

wx_clear_interrupt_scheme()
	wx_free_q_vectors()
		wx_free_q_vector()

which is reached from ngbe_setup_tc()/txgbe_setup_tc(), PCI remove,
shutdown, suspend and the probe error paths, rather than from a plain
interface stop.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd..9f90aa92f840 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1714,7 +1714,12 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
>  
>  	if (r_idx >= wx->num_tx_queues)
>  		r_idx = r_idx % wx->num_tx_queues;

[Severity: High]
Can this modulo still divide by zero in the same teardown window the new
NULL check is meant to cover?

wx_free_q_vectors() zeroes the counts before the ring slots are cleared:

	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;

	while (v_idx--)
		wx_free_q_vector(wx, v_idx);

So a concurrent transmit observes num_tx_queues == 0 strictly before it can
observe a NULL ring. With count 0 the unsigned comparison is always true
and r_idx % 0 raises a divide error before the guard below is reached.

Is the window open on the VF suspend/shutdown path? wxvf_suspend() only
does:

	netif_device_detach(wx->netdev);
	wx_clear_interrupt_scheme(wx);

netif_device_detach() stops the queues without taking the per-txq locks, so
an xmit already inside wx_xmit_frame() on another CPU keeps running. The PF
paths differ because ngbe_close()/txgbe_close() run netif_tx_disable(),
which takes every txq lock and drains in-flight transmits.

Would snapshotting the count once with READ_ONCE() and returning early when
it is 0, or keying the whole decision off the ring pointer, be a better fit
than adding the NULL check after the division?

> -	tx_ring = wx->tx_ring[r_idx];
> +	tx_ring = rcu_dereference(wx->tx_ring[r_idx]);

[Severity: Medium]
Should this be rcu_dereference_bh()? wx_xmit_frame() is the
ndo_start_xmit callback and runs inside rcu_read_lock_bh() taken by
__dev_queue_xmit():

net/core/dev.c:__dev_queue_xmit() {
	/* Disable soft irqs for various locks below. Also
	 * stops preemption for RCU.
	 */
	rcu_read_lock_bh();
	...
}

rcu_dereference(p) expands to rcu_dereference_check(p, 0), whose condition
is rcu_read_lock_held(), and that returns lock_is_held(&rcu_lock_map) while
rcu_read_lock_bh() acquires rcu_bh_lock_map instead.

With CONFIG_PROVE_RCU=y, does the first packet on a wangxun NIC produce a
"suspicious rcu_dereference_check() usage" splat from the transmit path?
This also looks like the only reader converted here that has no
rcu_read_lock() of its own, now that struct wx carries:

	struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
	struct wx_ring __rcu *rx_ring[64];

> +
> +	if (unlikely(!tx_ring)) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
>  
>  	return wx_xmit_frame_ring(skb, tx_ring);
>  }

[ ... ]

> @@ -2245,10 +2250,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
>  	struct wx_ring *ring;
>  
>  	wx_for_each_ring(ring, q_vector->tx)
> -		wx->tx_ring[ring->queue_index] = NULL;
> +		rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
>  
>  	wx_for_each_ring(ring, q_vector->rx)
> -		wx->rx_ring[ring->queue_index] = NULL;
> +		rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
>  
>  	wx->q_vector[v_idx] = NULL;
>  	netif_napi_del(&q_vector->napi);

[Severity: High]
This isn't a bug introduced by this patch, but the VF suspend path reaches
this function without any prior quiesce, and the RCU conversion makes the
resource side unrecoverable.

wxvf_suspend() in wx_vf_common.c, also used by wxvf_shutdown(), does only:

	netif_device_detach(wx->netdev);
	wx_clear_interrupt_scheme(wx);
	pci_disable_device(pdev);

There is no wxvf_down(), no wx_free_irq(), no timer_delete_sync() /
cancel_work_sync(), and no wx_free_resources().

Does this free the q_vector while its users are still live? The NAPI
instance is still enabled, the DIM work items are only disabled by
wx_napi_disable_all(), the service timer is still armed from
wxvf_up_complete(), and the MSI-X handlers are still requested:

wx_msix_clean_rings() {
	struct wx_q_vector *q_vector = data;

	if (q_vector->rx.ring || q_vector->tx.ring) {
		napi_schedule_irqoff(&q_vector->napi);
	...
}

That runs in hard-IRQ context, which the kfree_rcu() grace period does not
synchronise against, and wx_reset_interrupt_capability() then calls
pci_free_irq_vectors() with the handlers still installed.

Does the same path also leak the ring memory? wx_free_q_vectors() zeroes
num_tx_queues/num_rx_queues/num_q_vectors before this function NULLs the
slots, so wx_free_all_tx_resources()/wx_free_all_rx_resources() would
iterate zero queues afterwards and the dma_alloc_coherent() descriptor
rings, the tx_buffer_info/rx_buffer_info arrays and the page pools become
unreachable, with page_pool_destroy() never called.

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index 1960f7154151..9e90702a5146 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -37,9 +37,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
>  
>  	if (!netif_running(wx->netdev)) {
>  		for (i = 0; i < wx->num_tx_queues; i++)
> -			wx->tx_ring[i]->count = new_tx_count;
> +			rcu_dereference_protected(wx->tx_ring[i], 1)->count = new_tx_count;
>  		for (i = 0; i < wx->num_rx_queues; i++)
> -			wx->rx_ring[i]->count = new_rx_count;
> +			rcu_dereference_protected(wx->rx_ring[i], 1)->count = new_rx_count;
>  		wx->tx_ring_count = new_tx_count;
>  		wx->rx_ring_count = new_rx_count;

[Severity: Medium]
This is a pre-existing issue, not something this patch introduces, but
while touching these functions: ngbe_set_ringparam() and
txgbe_set_ringparam() initialise err to 0 and then drop the return value
of wx_set_ring():

	ngbe_down(wx);

	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
	kvfree(temp_ring);

	ngbe_up(wx);

wx_set_ring() returns the failures from wx_setup_tx_resources() and
wx_setup_rx_resources(), and an Rx allocation failure can happen after the
Tx rings and wx->tx_ring_count were already committed. Does ethtool -G
then report success for a partially applied configuration?

wx_set_ringparam_vf() captures and returns this value, so should the PF
versions do the same?

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610..e45d7dfdc9f9 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -406,7 +406,7 @@ static void ngbe_disable_device(struct wx *wx)
>  	/* disable all enabled rx queues */
>  	for (i = 0; i < wx->num_rx_queues; i++)
>  		/* this call also flushes the previous write */
> -		wx_disable_rx_queue(wx, wx->rx_ring[i]);
> +		wx_disable_rx_queue(wx, rcu_dereference_protected(wx->rx_ring[i], 1));

[Severity: Medium]
This is a pre-existing issue rather than something added here, but it is in
the reconfiguration path the commit message names. ngbe_setup_tc() in this
same file, and txgbe_setup_tc(), close the running device, destroy the
interrupt scheme, and then ignore both return values:

	wx_init_interrupt_scheme(wx);

	if (netif_running(dev))
		ngbe_open(dev);

	return 0;

If wx_alloc_q_vectors() fails it zeroes the queue counts:

wx_alloc_q_vectors() {
err_out:
	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;
	...
}

so setup_tc re-opens a device with zero queues, ngbe_open()'s error is
dropped, and __LINK_STATE_START stays set from the direct close/open calls.
wx_set_channels() propagates only setup_tc's return value, so does
ethtool -L report success while leaving the interface unusable, and with
netif_running() true and num_tx_queues == 0 does it also feed the modulo
in wx_xmit_frame() discussed above?

[ ... ]

> @@ -2775,7 +2780,7 @@ void wx_clean_all_tx_rings(struct wx *wx)
>  	int i;
>  
>  	for (i = 0; i < wx->num_tx_queues; i++)
> -		wx_clean_tx_ring(wx->tx_ring[i]);
> +		wx_clean_tx_ring(rcu_dereference_protected(wx->tx_ring[i], 1));
>  }
>  EXPORT_SYMBOL(wx_clean_all_tx_rings);
>  

[Severity: Medium]
Every control-path conversion in this series passes a literal 1 as
the condition argument, here and in wx_configure_tx(),
wx_configure_rx(), wx_set_rx_buffer_len(), wx_fc_enable(),
wx_cache_ring_rss(), wx_cache_ring_vmdq(), wx_set_ring(),
wx_setup_all_{tx,rx}_resources(), wx_free_all_{tx,rx}_resources(),
wx_configure_tx_vf(), wx_configure_rx_vf(), the three
*_set_ringparam() variants, ngbe_disable_device(),
txgbe_disable_device(), txgbe_add_ethtool_fdir_entry() and
txgbe_fdir_filter_restore().

rcu_dereference_protected(p, 1) makes the lockdep check
unconditionally true, so it only casts away the __rcu annotation for
sparse and asserts nothing at runtime. The commit message says these
sites are "strictly guarded by outer locks (e.g. RTNL or dev state
locks)", which is exactly the claim the condition argument exists to
verify under CONFIG_PROVE_RCU. As written, a future caller that
reaches wx_configure_tx() or wx_clean_all_tx_rings() without the
outer lock held will not be caught by anything.

Which lock is actually being relied on at these sites? The
*_set_ringparam() paths hold wx->reset_lock and come in through
ethtool, while wx_configure_tx()/wx_configure_rx() are also reached
from the reset and open paths, so the answer may differ per call
site. If a single predicate covers all of them, could the condition
spell it out, for example lockdep_is_held(&wx->reset_lock) or a
combination with lockdep_rtnl_is_held()? Where no such predicate
exists, a short comment naming the lock that makes the access safe
would at least tell the next reader why the bare 1 is there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909090005.79368-1-mengyuanlou%40net-swift.com
