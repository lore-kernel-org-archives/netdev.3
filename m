Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFD38AC68
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521139; cv=none; b=HIt7xOYvvgSA7ymaUW7OTgsO+Ep6gpJV7GjW4ITliyrLO6AVuZN+P/hMl8EGQ1J3YHJY8N6O0t9rZErT0LP5tpxJjjvDxf1hkHt4i0wAXG+t5dTipw83qlJ/xnuCwuH6QwODh9DTBzUYTJ8sm7fhd70vXcAvpfE3UEP26p4o4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521139; c=relaxed/simple;
	bh=G3ansEJNeuVNJB6cmQQ+xoU1w+cht16CW1VtVIPgz4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UziBuBi2BMVFCfYTgRgYEJe1ct2Um7MG5yBwgGPjex1Z4GMNfITKiHk4492L9bFN9WKFYcCazDayu9mohQU3qRnGEzkeLbsWTmWGSmD69+v2ZHmCg8mwxyZTTbZJv3HPmiA95SB/AID4Hq0efOaP1rptsgNvD+CPZMPmZztFLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCwTfF+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCwTfF+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A40A1F00893;
	Wed, 16 Sep 2026 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521137;
	bh=0Te0Wbgyrd2sMprktQKFp/QcBOlOq3/62AE5rlMzp3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCwTfF+S9wu+lMgSAPNBeqJ2I1g/6/GpMebbdpepaDmJRMLR2gGYf3paWp+81GwUn
	 Y6SMsqv5DzGSXkdYMsaCExip7ltn9YCg4W5pV4+Hb3xwEdoSXikBZdXd5mVfwlV1HS
	 /3MP0bEJL590WOBElPNJuQoerBLDZ88jcMtFMjGbbM+ZR8M+M+pDZtI/lI5HuyipEP
	 UoTdx7oHhdyw/uMoA5N0wNzXsIja+3MAsQXHhZnyevjsIK1e4XdMXRcEyG6ngqTQCX
	 j98hoZcVUc+n3QHjHn1pztnA+hMPfsfa9swYDCOrIlSEGxywghObUJRXCufYD3GQpc
	 Y8YsigWz4RIYQ==
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
Subject: Re: [PATCH net 05/15] ice: E822: cancel offset verification work during reset preparation
Date: Tue, 15 Sep 2026 18:12:16 -0700
Message-ID: <20260916011216.1632452-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-6-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-6-anthony.l.nguyen@intel.com>
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
ice: E822: cancel offset verification work during reset preparation

This adds a kthread_cancel_delayed_work_sync() of the E82x offset
verification work (ov_work) to ice_ptp_prepare_for_reset(), so that the
work does not run while the PTP reset sequence executes.  A few questions
about the changelog and about the placement of the new cancel.

First, on the described failure mechanism:

> Without this, ice_ptp_wait_for_offsets() can execute during a reset,
> find that ice_is_reset_in_progress() is true, and re-queue itself in a
> tight loop. Meanwhile, the reset path in ice_ptp_rebuild_owner() calls
> ice_ptp_port_phy_restart(), which starts a new ov_work. This results in
> two ov_work instances running simultaneously, racing over the PHY offset
> registers and the calibrating flag.

[Severity: Medium]
Can this sequence happen as described?  ov_work is a single
struct kthread_delayed_work per port (ice_ptp.h, struct ice_ptp_port) run
by one per-PF kworker, so the same work item cannot execute twice at once.

The re-queue in ice_ptp_wait_for_offsets() also does not look like a tight
loop, and it returns before touching the PHY offset registers or
port->tx.calibrating:

	if (ice_is_reset_in_progress(pf->state)) {
		/* wait for device driver to complete reset */
		kthread_queue_delayed_work(pf->ptp.kworker,
					   &port->ov_work,
					   msecs_to_jiffies(100));
		return;
	}

And ice_ptp_port_phy_restart(), the only site that arms ov_work, already
cancel-syncs it under ps_lock before queueing again:

	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
	...
	kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0);

Could the changelog describe the actual window instead, for example a
worker instance that already passed the reset-in-progress check and is
mid-PHY-access when the reset starts, or one that gets re-armed after the
new cancel?

Second, on the Fixes tag:

> Fixes: 4809671015a1 ("ice: Fix E810 PTP reset flow")

[Severity: Medium]
Is this the right commit to reference?  git grep ov_work at 4809671015a1
under drivers/net/ethernet/intel/ice/ returns no matches, so the E82x
offset verification work did not exist yet at that commit, and the code
being changed here is the ICE_MAC_GENERIC branch of the PTP reset flow
rather than the E810 reset flow.  Stable tooling will use this tag to pick
backport targets.

Third, on the reference to an existing cancellation:

> Cancel ov_work in ice_ptp_prepare_for_reset() alongside the existing
> cancellation of the Tx tracker. The comment in the existing code already
> documents that ov_work interference during reset is a concern but only
> cancels it during ice_ptp_release().

[Severity: Medium]
Does ice_ptp_prepare_for_reset() still release the Tx tracker in this
tree?  The ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx) call that used
to be there was removed by the earlier patch in this series, "ice: fix
removal of PTP timestamp tracker during reset", so there is nothing left
in that function to cancel ov_work "alongside".

Which existing comment documents ov_work interference during reset?  At the
series baseline the only ov_work-adjacent comments are "Start the PHY timer
in Vernier mode" and "temporarily disable Tx timestamps while calibrating
PHY offset", and neither mentions reset.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index d018f02f700d7..9bf3bac552f11 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2998,6 +2998,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (reset_type == ICE_RESET_PFR)
>  		return;
>  
> +	/* Cancel the offset verification work for E82x before releasing the
> +	 * Tx tracker. If ov_work is running during reset, it may issue
> +	 * sideband queue commands that will fail or timeout, and may
> +	 * reference state that is being torn down.
> +	 */

[Severity: Medium]
Same point as above for the comment text itself: ice_ptp_prepare_for_reset()
does not release the Tx tracker anymore, so "before releasing the Tx
tracker" describes an ordering that does not exist here.  The only
remaining ice_ptp_release_tx_tracker() call is in ice_ptp_release(), and
there it runs before the ICE_MAC_GENERIC ov_work cancel reached via
ice_ptp_port_phy_stop(), i.e. the reverse order.  Would it be clearer to
drop that clause?

The second sentence also mentions sideband queue commands, but
ice_ptp_wait_for_offsets() returns as soon as ice_is_reset_in_progress() is
true, before any sideband access.  Which state that is being torn down does
the work reference?

> +	if (hw->mac_type == ICE_MAC_GENERIC)
> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);

[Severity: High]
Should this cancel be taken under ptp->port.ps_lock?  Both existing
ov_work cancel sites hold it, and ice_ptp_port_phy_restart() holds it
across cancel, PHY start and re-queue:

	mutex_lock(&ptp_port->ps_lock);
	...
	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
	...
	err = ice_start_phy_timer_e82x(hw, port);
	...
	kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0);

Without ps_lock here, can ov_work be armed again right after the sync
cancel returns, so the reset sequence still runs with ov_work queued?

Two arming paths look reachable during the reset window.  One is the
PTP_CLOCK_SETTIME ioctl, which has no ptp->state or reset-in-progress
check:

ice_ptp_settime64()
	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
	if (hw->mac_type == ICE_MAC_GENERIC)
		ice_ptp_restart_all_phy(pf);

The other is the clock-owner PF on a multi-PF E82x adapter, where
ice_ptp_rebuild_owner() -> ice_ptp_restart_all_phy() walks the adapter port
list and arms a peer PF's ov_work:

	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
		...
		if (port->link_up)
			ice_ptp_port_phy_restart(port);

while that peer PF's own service task is inside
ice_ptp_prepare_for_reset() on another CPU.  There is no cross-PF reset
serialization for E82x, since ice_ptp_prepare_rebuild_sec() is gated on
ICE_MAC_GENERIC_3K_E825 in the following hunk.

Would doing the cancel inside the ps_lock critical section, or simply
reusing ice_ptp_port_phy_stop(), close that window?  The ov_work callback
ice_ptp_wait_for_offsets() only takes port->tx.lock with
spin_lock_irqsave(), never ps_lock, so taking ps_lock around the sync
cancel should not deadlock.

[Severity: Low]
Separately, who re-arms ov_work for a non-owner PF after this cancel?
ice_ptp_wait_for_offsets() is the only place that programs the vernier
offsets and clears the calibrating flag:

	port->tx.calibrating = false;

and ice_ptp_is_tx_tracker_up() gates every Tx timestamp on it:

	return tx->init && !tx->calibrating;

At this commit the only re-arm during reset is ice_ptp_restart_all_phy()
from ice_ptp_rebuild_owner(), which runs on the clock-owner PF only, for
non-PFR only, for link-up ports only, and can arm a peer PF's ov_work just
before that peer cancels it here.  Note this appears to be resolved by the
next patch in the series, "ice: call PTP link change only from link
events", which adds an unconditional per-PF ice_ptp_link_change() call at
the end of ice_rebuild(); with that in place every PF re-arms its own
ov_work after its own rebuild.  Worth mentioning in the changelog that this
patch depends on that follow-up?

[Severity: Medium]
This isn't a bug introduced by this patch, but the state that
ice_ptp_prepare_for_reset() leaves behind interacts with an incomplete
teardown path.  ice_ptp_release() early-returns whenever
pf->ptp.state is neither ICE_PTP_UNINIT nor ICE_PTP_READY:

	if (pf->ptp.state != ICE_PTP_READY) {
		mutex_destroy(&pf->ptp.port.ps_lock);
		ice_ptp_cleanup_pf(pf);
		if (pf->ptp.clock) {
			ptp_clock_unregister(pf->ptp.clock);
			pf->ptp.clock = NULL;
		}
		return;
	}

ice_ptp_cleanup_pf() only removes the port from the adapter list and drops
the kref, so unloading the driver while the state is ICE_PTP_RESETTING
(set here) or ICE_PTP_ERROR (set on the ice_ptp_rebuild() failure path)
leaks the kthread worker created by kthread_run_worker() in
ice_ptp_init_work() and the tx->tstamps allocation from
ice_ptp_alloc_tx_tracker(), and does not sync-cancel ptp->work or
port.ov_work before the devm-allocated ice_pf embedding them goes away.
That branch also leaves state non-UNINIT, unlike the invariant the comment
above ice_ptp_release() describes.

>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>  

[ ... ]
