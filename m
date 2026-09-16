Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8B0339396
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521134; cv=none; b=kUjIqirPbJXdb/VHOrpft68Stx/6uJblfC4Bp8KdARB/z7eoz2TASiMjlwW7jQ/GzQEwIhXpMv+cxHx/mdeI8IKqZMarA/ysMQbg5GKz+sJtJAJig15AzbwdmPVDrka+WTXWrydngBl0oBUXOFhqJ8Hz2mukdWxjN5p4a+snoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521134; c=relaxed/simple;
	bh=Wxqbv/SCX/bK2tWKzmN/iuiDVHK2IlyVK6IpxycrgM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnOb6RKhrqI7cMGxIkHqAL/u3cUDKBHD7U9NOHg5vgNnH/HogM+LMUQkDCriHDzqIThfCyhGfpwKK4KYVxMrusTxnD8s/SSgDr66tGGjBXBT1MCbtsZ9mdaf2Mwz4IHRIhq0kNXC0FhYMecIKLz/DQuuAgvuDxFZPVClZc5Nvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvAltbKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvAltbKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353781F000FF;
	Wed, 16 Sep 2026 01:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521132;
	bh=LmigYlvT52d/4bUIHMT/WMZaybufFyrjgeIoW7rFMIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WvAltbKdLjJRbtmFGefjhQNQeAmsE7ytEVKS5ghxprPuIKf0c97oYpPdwf5OHp6FP
	 eP8XIYUzQcFBQF1tjP2o/yRSc5JN8dDDkQZcVNNNk3TiZCTMapA3SHJ4UacoYMloCd
	 c69KN13IgrIGvd9/Nsu+g8afkPbw7DTML+amdjEdh5V8HwYxfbXZUliBG8kWZsYUX8
	 3v6FXiu2ZoSE+ZIXErYa2x/S5GaOGrWrGGd71thQB8et1MW8lkjWPYzBYuxJqjxXn1
	 puCYTfySeaAr2XEaB2b2xXF75OHhqXdaw3GTnr61fJw8uhjJ8wJXxfRTOOfMza/rKT
	 DGeEYgJVMqFfQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	maciej.machnikowski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 01/15] ice: use reference counting and RCU for PTP port access
Date: Tue, 15 Sep 2026 18:12:11 -0700
Message-ID: <20260916011211.1632220-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-2-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-2-anthony.l.nguyen@intel.com>
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
ice: use reference counting and RCU for PTP port access

The adapter-wide PTP port list is converted from a mutex-protected list to
an RCU list plus a kref on each struct ice_ptp_port. Iterators either stay
inside a single RCU read section, or take a reference and drop RCU across
the per-port work. PF teardown unlinks the port, drops the primary
reference, waits (with a 15 second timeout) for the remaining references,
and then calls synchronize_rcu().

A couple of questions below about the new iteration pattern and about a
few lifetime claims in the commit message.

> The kref reference counter ensures that we can
> safely acquire pointers with a guarantee of their lifetime, ensuring the
> associated PF will not be removed until the reference is released.

[Severity: High]

This isn't a bug introduced by this patch, but does that sentence read
wider than the change actually is?  The new kref covers the port list
only; the other cross-PF pointer on the adapter is still unprotected:

drivers/net/ethernet/intel/ice/ice_ptp.c:
static void ice_ptp_setup_adapter(struct ice_pf *pf)
{
	pf->adapter->ctrl_pf = pf;
}

drivers/net/ethernet/intel/ice/ice.h:
static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
{
	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
}

grep over drivers/net/ethernet/intel/ice/ finds exactly one assignment of
ctrl_pf and no site that ever clears it.

If the clock owner PF is unbound while a sibling PF of the same adapter
stays bound, the ice_adapter survives on the sibling's refcount, but
ctrl_pf still points at the freed struct ice_pf.  Can a later tx-clk
change then dereference it?

drivers/net/ethernet/intel/ice/ice_txclk.c:ice_txclk_set_clk()
	mutex_lock(&ctrl_pf->dplls.lock);
	clk_in_use = ice_txclk_any_port_uses(ctrl_pf, phy, clk);

The IS_ERR_OR_NULL(ctrl_pf) checks in that file cannot detect a stale
non-NULL pointer.  Would it be worth stating in the commit message that
the new reference counting is scoped to the port list, so that ctrl_pf
isn't assumed to be covered?

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index 4f695f32da3d8..39923dedd534e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -19,13 +19,13 @@ struct ice_pf;
>   *
>   * This structure contains data used to maintain a list of adapter ports
>   *
> - * @ports: list of ports
> + * @list: list of ports
>   * @lock: protect access to the ports list
>   */
>  struct ice_port_list {
> -	struct list_head ports;
> +	struct list_head list;
>  	/* To synchronize the ports list operations */
> -	struct mutex lock;
> +	spinlock_t lock;
>  };

[Severity: Low]

This isn't a bug, but should the kernel-doc be updated along with the
locking model?  After this patch, ports.lock is taken only around
list_add_rcu() in ice_ptp_setup_pf() and list_del_rcu() in
ice_ptp_cleanup_pf(); all five traversal sites in ice_ptp.c use
rcu_read_lock() plus list_for_each_entry_rcu() and never take the lock.

The comments still say "@lock: protect access to the ports list" and "To
synchronize the ports list operations", which reads as if holding the lock
were required (or sufficient) for iteration.  Would it help to note that
the list is RCU-protected for readers, and that readers which leave the
RCU section must hold a port reference?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index eaec36ab6ae3f..b12181b8c8434 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -673,20 +675,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  	pf->ptp.tx_hwtstamp_good += tstamp_good;
>  }
>  
> +static void ice_ptp_release_port_rcu(struct kref *ref)
> +{
> +	wake_up_var(ref);
> +}
> +
>  static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
>  {
>  	struct ice_ptp_port *port;
>  
> -	mutex_lock(&pf->adapter->ports.lock);
> -	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>  		struct ice_ptp_tx *tx = &port->tx;
>  
> -		if (!tx || !tx->init)
> +		if (!tx->init)
>  			continue;
>  
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +
> +		rcu_read_unlock();
> +
>  		ice_ptp_process_tx_tstamp(tx);
> +
> +		rcu_read_lock();
> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
>  	}
> -	mutex_unlock(&pf->adapter->ports.lock);
> +	rcu_read_unlock();
>  }

[Severity: High]

Is the loop advance still safe here?  The kref is held on the current port
only, and the for-loop advance reads port->list_node.next after the RCU
read section has been reopened.  list_del_rcu() only updates the
neighbours, so the removed entry's next pointer keeps pointing at its old
successor, and ice_ptp_cleanup_pf() unlinks before it drains references:

	spin_lock(&pf->adapter->ports.lock);
	list_del_rcu(&ptp->port.list_node);
	spin_unlock(&pf->adapter->ports.lock);

	ref = &ptp->port.ref;
	kref_put(ref, ice_ptp_release_port_rcu);

Can this sequence happen with two functions of the same adapter, where
port B follows port A in the list?

CPU0 (clock owner, ice_ptp_tx_tstamp_owner())
	kref_get_unless_zero(&portA->ref);
	rcu_read_unlock();
	ice_ptp_process_tx_tstamp(&portA->tx);   /* long PHY access */

CPU1 (unbind of the PF owning port B)
	ice_ptp_cleanup_pf()
	  list_del_rcu(&portB->list_node);
	  kref_put(&portB->ref, ...);            /* refcount reaches 0 */
	  wait_var_event_timeout(...)            /* returns immediately */
	  synchronize_rcu();                     /* CPU0 holds no RCU lock */
	... struct ice_pf of B (which embeds portB) is freed

CPU0
	rcu_read_lock();
	kref_put(&portA->ref, ice_ptp_release_port_rcu);
	/* loop advance: */
	pos = list_entry_rcu(portA->list_node.next, ...);  /* freed portB */
	if (!tx->init)                        /* read of freed memory */
	kref_get_unless_zero(&portB->ref)     /* cmpxchg on freed memory */

The same drop-RCU-inside-the-loop pattern appears in
ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy() and
ice_ptp_prepare_rebuild_sec() below, and the windows there are wide
(ice_ptp_port_phy_restart() takes ps_lock and reprograms the PHY).

Note that ice_ptp_tx_tstamp_owner() previously held ports.lock across the
entire iteration, so this particular hazard is new for that function.
Would taking a reference on the next entry before dropping RCU, or keeping
the whole iteration inside one RCU read section, close this?

>  /**
> @@ -808,8 +823,16 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
>  {
>  	struct ice_ptp_port *port;
>  
> -	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +		rcu_read_unlock();
>  		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
> +		rcu_read_lock();
> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
> +	}
> +	rcu_read_unlock();
>  }

[Severity: Medium]

This is a pre-existing issue, not something this patch introduces, but
does the new port reference also cover the Tx tracker allocations reached
through the port?  At this commit a peer reset frees them while the port
stays linked in the list:

ice_ptp_prepare_for_reset()
	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);

ice_ptp_release_tx_tracker()
	synchronize_irq(pf->oicr_irq.virq);
	ice_ptp_flush_tx_tracker(pf, tx);
	kfree(tx->tstamps);

The synchronize_irq() is on the peer's own OICR vector, which does not
exclude the clock owner's IRQ thread in ICE_PTP_TX_INTERRUPT_ALL mode, and
the owner samples port->tx.init without tx->lock before calling
ice_ptp_process_tx_tstamp() or ice_ptp_flush_tx_tracker() on that peer
port.  Since the port is never unlinked in this path, the kref drain in
ice_ptp_cleanup_pf() does not apply.

The triggering call is removed later in the series by "ice: fix removal of
PTP timestamp tracker during reset", after which
ice_ptp_release_tx_tracker() only runs from ice_ptp_release() once
ice_ptp_cleanup_pf() has unlinked the port and drained references.

>  /**

[ ... ]

> @@ -1424,16 +1453,21 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
>   */
>  static void ice_ptp_restart_all_phy(struct ice_pf *pf)
>  {
> -	struct list_head *entry;
> +	struct ice_ptp_port *port;
>  
> -	list_for_each(entry, &pf->adapter->ports.ports) {
> -		struct ice_ptp_port *port = list_entry(entry,
> -						       struct ice_ptp_port,
> -						       list_node);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +		rcu_read_unlock();
>  
>  		if (port->link_up)
>  			ice_ptp_port_phy_restart(port);
> +
> +		rcu_read_lock();
> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
>  	}
> +	rcu_read_unlock();
>  }

[ ... ]

> @@ -2890,14 +2924,16 @@ void ice_ptp_queue_work(struct ice_pf *pf)
>  static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>  					enum ice_reset_req reset_type)
>  {
> -	struct list_head *entry;
> +	struct ice_ptp_port *port;
>  
> -	list_for_each(entry, &pf->adapter->ports.ports) {
> -		struct ice_ptp_port *port = list_entry(entry,
> -						       struct ice_ptp_port,
> -						       list_node);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>  		struct ice_pf *peer_pf = ptp_port_to_pf(port);
>  
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +		rcu_read_unlock();
> +

[ ... ]

> @@ -3086,11 +3126,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>  		return -ENODEV;
>  
>  	INIT_LIST_HEAD(&ptp->port.list_node);
> -	mutex_lock(&pf->adapter->ports.lock);
> +	kref_init(&ptp->port.ref);
>  
> -	list_add(&ptp->port.list_node,
> -		 &pf->adapter->ports.ports);
> -	mutex_unlock(&pf->adapter->ports.lock);
> +	spin_lock(&pf->adapter->ports.lock);
> +	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
> +	spin_unlock(&pf->adapter->ports.lock);

[Severity: Medium]

This isn't introduced by this patch, but is every successful
ice_ptp_setup_pf() matched by an ice_ptp_cleanup_pf() at this commit?  In
ice_ptp_init():

	ptp->state = ICE_PTP_READY;

	err = ice_ptp_init_work(pf, ptp);
	if (err)
		goto err_exit;
	...
err_clean_pf:
	mutex_destroy(&ptp->port.ps_lock);
	ice_ptp_cleanup_pf(pf);
err_exit:
	...
	ptp->state = ICE_PTP_UNINIT;

The err_exit path skips ice_ptp_cleanup_pf() and leaves the state at
ICE_PTP_UNINIT, and ice_ptp_release() then does:

	if (pf->ptp.state == ICE_PTP_UNINIT)
		return;

So if kthread_run_worker() in ice_ptp_init_work() fails, does the port stay
linked on adapter->ports.list with its primary reference held, inside
memory that is freed at PF removal?  That would also leave
kref_get_unless_zero() succeeding on freed memory for every peer iterating
the list, and should trip WARN_ON(!list_empty(&adapter->ports.list)) in
ice_adapter_free().

This is fixed later in the series by "ice: call PTP link change only from
link events", which moves ice_ptp_init_work() before the state assignment
and sends its failure path to err_clean_pf.

>  
>  	/* Seed the per-PHY Tx reference clock usage map for this port.
>  	 * Only meaningful on E825 (other MAC types don't expose tx-clk
> @@ -3113,12 +3153,32 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>  static void ice_ptp_cleanup_pf(struct ice_pf *pf)
>  {
>  	struct ice_ptp *ptp = &pf->ptp;
> +	struct kref *ref;
>  
> -	if (pf->hw.mac_type != ICE_MAC_UNKNOWN) {
> -		mutex_lock(&pf->adapter->ports.lock);
> -		list_del(&ptp->port.list_node);
> -		mutex_unlock(&pf->adapter->ports.lock);
> -	}
> +	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
> +		return;
> +
> +	/* The PF cannot be removed until there are no more remaining
> +	 * outstanding references to the PTP port. To make sure this is true,
> +	 * first remove the port from the list, then drop the primary
> +	 * reference this PF holds on the port. Once done, wait until all
> +	 * existing references are dropped. Finally, synchronize_rcu() to
> +	 * ensure that all RCU critical sections that might attempt to
> +	 * dereference the port are finished.
> +	 */

[Severity: Low]

The commit message describes the 15 second timeout and the tradeoff it
accepts, but this comment says the PF "cannot be removed until there are no
more remaining outstanding references" and that the code will "wait until
all existing references are dropped".  Should the comment mention the
timeout, since teardown continues after the dev_WARN_ONCE() with a nonzero
reference count?

> +
> +	spin_lock(&pf->adapter->ports.lock);
> +	list_del_rcu(&ptp->port.list_node);
> +	spin_unlock(&pf->adapter->ports.lock);
> +
> +	ref = &ptp->port.ref;
> +	kref_put(ref, ice_ptp_release_port_rcu);
> +
> +	dev_WARN_ONCE(ice_pf_to_dev(pf),
> +		      !wait_var_event_timeout(ref, !kref_read(ref), 15 * HZ),
> +		      "Timed out waiting for port references to release. Continuing to unload anyways.");
> +
> +	synchronize_rcu();
>  }

[Severity: Low]

This is a pre-existing ordering issue, not something this patch changes,
but now that ice_ptp_cleanup_pf() is the reference/RCU barrier, would it
make sense to call it before destroying port members?  Both teardown paths
currently do the opposite:

ice_ptp_init():
err_clean_pf:
	mutex_destroy(&ptp->port.ps_lock);
	ice_ptp_cleanup_pf(pf);

ice_ptp_release():
	if (pf->ptp.state != ICE_PTP_READY) {
		mutex_destroy(&pf->ptp.port.ps_lock);
		ice_ptp_cleanup_pf(pf);

In that window the port is still published on adapter->ports.list with its
primary reference held, so a peer in ice_ptp_restart_all_phy() or
ice_ptp_prepare_rebuild_sec() can take a reference and reach
mutex_lock(&ptp_port->ps_lock) on the destroyed mutex.  With
CONFIG_DEBUG_MUTEXES that is a DEBUG_LOCKS_WARN_ON splat rather than
corruption, since mutex_destroy() only clears lock->magic, but swapping the
two calls would keep cleanup_pf() as the single teardown point.

[ ... ]
-- 
pw-bot: cr
