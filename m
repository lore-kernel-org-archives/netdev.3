Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CB3DAABD
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846922; cv=none; b=pfQZYUGwuxWKzqm5eqzbeL8w85gZcBrHH2i1C2XUcTR6vENZSRooWC5rPwgDtbXngP6VXJjDutAIyUd+IbPtKAy/GtggUIDY8sb1UWUSrq6JJ8qiGbNNLAmywuE+IKKujnSSfsGGiXv4Gg3ls0G2qcd9NDGXXO1vQNUC2GGQv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846922; c=relaxed/simple;
	bh=524S6bZHwnAQ7oeU3WiwygCs11qhkot0wfva+mW8frQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4/Jz6hqY1uan2WncU5PP4BDnfLTajWbmSAxoNe/ZpW1KPg5xElEolrwU+McaA0FropYNP420dHioq/enMK75bOgsxPgNyxxoF6Gq8248lDiL/rzg/xcbx6d9DajRADLncKbTosBIOTKWBU0iBWU9iEtNTa9zngefZSX3tIMZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOu0PZLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOu0PZLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D1E1F008A2;
	Mon, 12 Oct 2026 23:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846920;
	bh=zNgcWX8wHTIEB7S3TM6Ad9lKWAOugE2roniz1H/kmUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aOu0PZLiOiYzW2c+CPWKKAgFCxRxl0SFQegR3/wWvXeib2BNx/se7PNZFYY/HeQIB
	 P+Bl1PM7XGzTq0JZMD7viFMT786QZhUCD33lzREqbC6Dw0dqc2o+ayapveI3D+A5Dr
	 JrFF2XofE4MUceIc2FHHG7jcjUgPKfosgTQEoShE6GcFPq9LeumrDkcaKeqP5o8xxh
	 pqaYEVBQrJEI4zk/YUqmB/cn7c4sdWsxel5iRMzCzX0/H0phDHu7oBmjIV6CeReEN9
	 UNxaxqYMEFgnENu7ScfVpZC27rV6xxg1cBOJCqRo1iB1zMqqQXGuNXcAsLzXDm+rM8
	 oWxowGizt/41A==
Subject: Re: [PATCH net v2 02/15] ice: use reference counting and SRCU for PTP
 port access
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.machnikowski@intel.com, jacob.e.keller@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 poros@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pmenzel@molgen.mpg.de, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Mon, 12 Oct 2026 23:15:19 +0000
Message-ID: <179184691959.434549.12801470720231194166@kernel.org>
In-Reply-To: <20261008215614.1987250-3-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-3-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the non-READY branch of ice_ptp_release() (state
  ICE_PTP_RESETTING or ICE_PTP_ERROR), the PF cancels its work, calls…
- [Medium] Lost-wakeup hang in ice_ptp_cleanup_pf()
  (drivers/net/ethernet/intel/ice/ice_ptp.c).

Pre-existing issues:
- [Medium] ice_ptp_cleanup_pf() cannot safely run twice, and the non-
  READY branch of ice_ptp_release() can run it twice.
- [Medium] ice_ptp_prepare_rebuild_sec() (E825 clock owner, non-PFR
  reset) calls ice_ptp_prepare_for_reset(peer_pf) while holding only…

--

ice: use reference counting and SRCU for PTP port access

This patch replaces the mutex that protects the ice adapter PTP port list
with an SRCU-protected list and adds a kref to each ice_ptp_port. Readers
skip ports whose kref has already dropped to zero.

ice_ptp_cleanup_pf() unlinks the port, drops the initial reference, waits
for the count to reach zero with wait_var_event(), and then calls
synchronize_srcu().

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index fe21cee4f9dee..94a66e9d8c05d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -673,20 +676,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  	pf->ptp.tx_hwtstamp_good += tstamp_good;
>  }
>  
> +static void ice_ptp_release_port_srcu(struct kref *ref)
> +{
> +	wake_up_var(ref);
> +}

[Severity: Medium]
Is a full memory barrier needed before this wake_up_var()?

The kernel-doc for wake_up_var() in kernel/sched/wait_bit.c says:

  In order for this to function properly there must be a full memory
  barrier after the variable is updated ... If the variable was updated
  by a fully ordered operation such as atomic_dec_and_test() then no
  extra barrier is required. Otherwise smb_mb() is needed.

kref_put() goes through refcount_dec_and_test(). That is
atomic_fetch_sub_release() followed by smp_acquire__after_ctrl_dep() on
success, so it gives release ordering plus acquire on success. It is not
fully ordered. __wake_up_bit() then checks waitqueue_active() without
taking the waitqueue lock.

Can this interleaving happen on a weakly ordered architecture such as
arm64?

CPU1 (last reader, e.g. ice_ptp_tx_tstamp_owner)
kref_put()
  refcount_dec_and_test()      /* refs 1 -> 0, release only */
  ice_ptp_release_port_srcu()
    wake_up_var(ref)
      waitqueue_active() sees an empty queue

CPU2 (ice_ptp_cleanup_pf)
wait_var_event(ref, !kref_read(ref))
  adds itself to the waitqueue, set_current_state()
  kref_read(ref) still returns 1
  schedule()

If so, the remover sleeps in TASK_UNINTERRUPTIBLE with no timeout.
var_wake_function() filters on the key, so an unrelated wakeup on the
same hashed queue would not wake it.

Would adding smp_mb__after_atomic() before wake_up_var(), or using a
fully ordered decrement, avoid this?

>  static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
>  {

[ ... ]

> @@ -1424,16 +1449,22 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
>   */
>  static void ice_ptp_restart_all_phy(struct ice_pf *pf)
>  {
> -	struct list_head *entry;
> +	struct ice_port_list *ports = &pf->adapter->ports;
> +	struct ice_ptp_port *port;
> +	int srcu_idx;
>  
> -	list_for_each(entry, &pf->adapter->ports.ports) {
> -		struct ice_ptp_port *port = list_entry(entry,
> -						       struct ice_ptp_port,
> -						       list_node);
> +	srcu_idx = srcu_read_lock(&ports->srcu);
> +	list_for_each_entry_srcu(port, &ports->list, list_node,
> +				 srcu_read_lock_held(&ports->srcu)) {
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
>  
>  		if (port->link_up)
>  			ice_ptp_port_phy_restart(port);

[Severity: High]
Can this loop reach a port whose PF has already destroyed its kthread
worker?

When the state is ICE_PTP_RESETTING or ICE_PTP_ERROR, ice_ptp_release()
takes its non-READY branch. That branch tears down the worker and the
clock before the port is removed from the list:

ice_ptp_release() {
    ...
	if (pf->ptp.state != ICE_PTP_READY) {
		if (pf->ptp.kworker) {
			kthread_cancel_delayed_work_sync(&pf->ptp.work);
			...
			kthread_destroy_worker(pf->ptp.kworker);
			pf->ptp.kworker = NULL;
		}
		if (pf->ptp.clock) {
			ptp_clock_unregister(pf->ptp.clock);
			pf->ptp.clock = NULL;
		}
		ice_ptp_cleanup_pf(pf);
    ...
}

ice_ptp_cleanup_pf() is the only place that unlinks the port, so
kref_get_unless_zero() here still succeeds until it runs. port->link_up
can also still be true, because only ice_ptp_link_change() rewrites it,
and only in the READY state.

For ICE_MAC_GENERIC, ice_ptp_port_phy_restart() then does:

	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
	...
	kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
				   0);

kthread_destroy_worker() frees the worker but does not clear
ov_work.work.worker. The cancel would therefore take the lock of a freed
worker. The queue call would then pass a NULL pf->ptp.kworker.

The clock owner can hit this through ice_ptp_rebuild_owner(). Because
ptp_clock_unregister() can sleep, the window is wider than it looks.

The same window seems to affect ice_ptp_prepare_rebuild_sec(). It calls
ice_ptp_prepare_for_reset(peer_pf), which runs
kthread_cancel_delayed_work_sync(&ptp->work) on the peer.

The READY branch already calls ice_ptp_cleanup_pf() before it cancels
any work. Should the non-READY branch also call ice_ptp_cleanup_pf()
before destroying the worker?

The commit message says the kref "ensures that a PF will have a valid
lifetime and not be removed until the reference is released". It also
lists ice_ptp_restart_all_phy() as one of the iterations being fixed.

> +
> +		kref_put(&port->ref, ice_ptp_release_port_srcu);
>  	}
> +	srcu_read_unlock(&ports->srcu, srcu_idx);
>  }

[ ... ]

> @@ -2890,14 +2930,18 @@ void ice_ptp_queue_work(struct ice_pf *pf)
>  static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>  					enum ice_reset_req reset_type)
>  {

[ ... ]

> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +
>  		if (!ice_is_primary(&peer_pf->hw)) {
>  			if (rebuild) {
>  				/* TODO: When implementing rebuild=true:
> @@ -2909,7 +2953,10 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>  				ice_ptp_prepare_for_reset(peer_pf, reset_type);
>  			}
>  		}

[Severity: Medium]
This is a pre-existing issue, but does anything here serialize the peer's
ptp->state against the peer's own ice_ptp_release()?

ice_ptp_prepare_for_reset() checks and sets the peer's state without a
lock:

	if (ptp->state != ICE_PTP_READY)
		return;

	ptp->state = ICE_PTP_RESETTING;

	/* Disable timestamping for both Tx and Rx */
	ice_ptp_disable_timestamp_mode(pf);

	kthread_cancel_delayed_work_sync(&ptp->work);

At the same time, ice_ptp_release() on the peer reads this field and
writes ICE_PTP_UNINIT to it.

If the owner writes RESETTING after the peer has written UNINIT, the
peer exits release in a non-READY state. A later ice_ptp_release() would
then repeat the cleanup.

In the opposite order, the peer takes the non-READY branch and destroys
its kworker while the owner is about to cancel work on it. That is the
same ordering problem described above for ice_ptp_restart_all_phy().
Calling ice_ptp_cleanup_pf() first in that branch would fix this case
too.

The kref and SRCU here protect the port memory and the list linkage. They
do not protect the PF state machine. The commit message notes that the
change "focuses solely on the port list".

> +
> +		kref_put(&port->ref, ice_ptp_release_port_srcu);
>  	}
> +	srcu_read_unlock(&ports->srcu, srcu_idx);
>  }

[ ... ]

> @@ -3110,13 +3157,23 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>  
>  static void ice_ptp_cleanup_pf(struct ice_pf *pf)
>  {

[ ... ]

> +	spin_lock(&ports->lock);
> +	list_del_rcu(&ptp->port.list_node);
> +	spin_unlock(&ports->lock);
> +
> +	ref = &ptp->port.ref;
> +	kref_put(ref, ice_ptp_release_port_srcu);
> +
> +	wait_var_event(ref, !kref_read(ref));

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens if
ice_ptp_cleanup_pf() runs twice for the same PF?

The non-READY branch of ice_ptp_release() calls ice_ptp_cleanup_pf() and
returns without setting ptp.state to ICE_PTP_UNINIT. This sequence seems
to run the cleanup twice:

ice_devlink_reinit_down()->ice_unload()->ice_deinit_features()
  ->ice_ptp_release()
    (state is ICE_PTP_ERROR or ICE_PTP_RESETTING, cleanup #1)

ice_devlink_reinit_up() fails before ice_init_features()
    (ice_ptp_init() never resets the state)

ice_remove()->ice_unload()->...->ice_ptp_release()
    (cleanup #2)

Before this patch, the second list_del() on a poisoned node either
faulted or, with LIST_HARDENED/DEBUG_LIST, warned and was skipped.

With this patch, the second kref_put() runs on a kref that is already
zero. refcount_dec_and_test() warns and saturates the counter without
calling the release function.

kref_read() then never returns zero. wait_var_event() would block
uninterruptibly forever while devl_lock is held. On hardened-list
kernels, the result changes from a warning to a hang.

Should the non-READY branch move the state to ICE_PTP_UNINIT, or should
ice_ptp_cleanup_pf() be made safe to call twice?

> +
> +	synchronize_srcu(&ports->srcu);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
