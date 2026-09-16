Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93838C426
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521136; cv=none; b=dhZa/x+WF21KW+5IRgZFOiT+Yc9ohB0snLnQd2WjeigSEq/zvOFEZJGxSLw4XNp9TGM0wD6StG4wW7pLw1EKum9T9diEEJGTgEfg5V4aTAD2sUzFBsjwjM8RlWsjoNzaBtGEvia/JmxadSlru4tCkOyn/dv5Wc7qadcSYYeWWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521136; c=relaxed/simple;
	bh=hnWqADJtohzd5tZAG0nRHJ0tV5RqKUbDuB+0jPuf2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2XbgEzG3HYCE5OAhzVYSiGnE8mcGNMPIlLosFYooTZBKxoTsXU4CTgC0dWr+CjY+hZZNsNnxDlBDtaT/jmBWNJQYbe3PEnholnWo3NzzjAdIBBY0IXMCIKA+JqO1wCrD8xTmFNYoaKhrjCxl0XoOz7mzSyrBu106QN8f65zSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPXzsPVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPXzsPVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A369D1F00893;
	Wed, 16 Sep 2026 01:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521135;
	bh=bpa2++Zx4MpBeIF3bhOl4r+00PNM2NWI1ZOsi7rfQ+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPXzsPVe2QMGxcnSjSGrH7WUlkgjiOwjFq4vxLY3AyIpwtRiidfUmYz9pRulKwnFl
	 ZeLUxSzlun1Z8COU7DbEXiSIUV2BicuHC9Q7McYWglxl+uj6htbEitk9Vj+W0qujl3
	 DWrvdT3Cp7oAJCWPtaRRPpzIULoBbPBGAtmXWIh9BuG3cWMF0YwCHPLuxl3eFmQTTK
	 L8E92Vjoj/8vuwB3zOykReWuQkgZdvOrPZcHlTNGvFDE3q+CzaA+QUZDILBnXaCOdh
	 T/x+CzSqb6UTImr83PBB33N6d6oMb7A0RKUkx71Xv1j6MktPMLmXmlYpjxWfqlXVrR
	 LfbR8be2nrWPA==
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
Subject: Re: [PATCH net 02/15] ice: fix removal of PTP timestamp tracker during reset
Date: Tue, 15 Sep 2026 18:12:12 -0700
Message-ID: <20260916011213.1632286-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-3-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-3-anthony.l.nguyen@intel.com>
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
ice: fix removal of PTP timestamp tracker during reset

This drops the ice_ptp_release_tx_tracker() call from
ice_ptp_prepare_for_reset(), completing the intent of 7a25fe5cd5fb so the
Tx timestamp tracker is no longer destroyed (and never re-created) across a
CORE or GLOBAL reset.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8

>     Unfortunately, the commit only removed the calls to ice_ptp_init_tx_*().
>     This fixed a memory leak in PF reset. However, now a CORE or GLOBAL reset
>     will leave the device unable to initiate Tx timestamp requests
>     indefinitely.

[Severity: Low]
Is the list of affected reset types complete here?  ice_ptp_prepare_for_reset()
returns early only for PFR:

	if (reset_type == ICE_RESET_PFR)
		return;

	...
	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);

so the deleted call also ran for ICE_RESET_EMPR.  ice_reset_subtask() maps
ICE_EMPR_RECV to ICE_RESET_EMPR and then calls ice_prepare_for_reset(), and
the matching ice_rebuild() -> ice_ptp_rebuild() has no ice_ptp_init_tx_*()
call either.  Should the commit message mention EMP resets as well, since
that affects stable triage?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b12181b8c8434..142d39ee5cc52 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2979,8 +2979,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>  
> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> -

[Severity: High]
This call was also the only thing that cleared tx->init under tx->lock and
ran synchronize_irq() for the low latency Tx timestamp path.  With the
tracker left armed, can ice_ll_ts_intr() still run against live tracker
state in the middle of a CORE or GLOBAL reset?

The handler is gated only on tx->init:

drivers/net/ethernet/intel/ice/ice_main.c:ice_ll_ts_intr() {
	spin_lock_irqsave(&tx->lock, flags);
	if (tx->init) {
		ice_ptp_complete_tx_single_tstamp(tx);

		idx = find_next_bit_wrap(tx->in_use, tx->len,
					 tx->last_ll_ts_idx_read + 1);
		if (idx != tx->len)
			ice_ptp_req_tx_single_tstamp(tx, idx);
	}
	...
}

The LL cause lives in PFINT_SB_CTL, so ice_ptp_disable_timestamp_mode() does
not mask it (it only clears PFINT_OICR_ENA TSYN_TX), and
ice_prepare_for_reset() only does synchronize_irq(pf->oicr_irq.virq), not
pf->ll_ts_irq.

Two consequences worth checking:

ice_ptp_complete_tx_single_tstamp() reads REG_LL_PROXY_L/H of a resetting
device, so can a garbage timestamp be reported through skb_tstamp_tx() for a
still-set in_use slot?

The handler sees the pre-reset in_use bits and issues a new firmware request
via ice_ptp_req_tx_single_tstamp(), which sets:

	params->atqbal_flags |= ATQBAL_FLAGS_INTR_IN_PROGRESS;

That flag is cleared only by ice_ptp_complete_tx_single_tstamp(), i.e. by a
later LL interrupt, and nothing re-initializes it on rebuild.  If the reset
swallows the request, does every subsequent user of the LL interface block
forever in the untimed wait in ice_ptp_prep_phy_incval_ll_e810() /
ice_ptp_prep_phy_adj_ll_e810():

	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
						  !(params->atqbal_flags &
						    ATQBAL_FLAGS_INTR_IN_PROGRESS));

These are reached from ice_ptp_rebuild_owner() through
ice_ptp_write_incval()/ice_ptp_write_init(), which run in the PF service task
workqueue where no signal can break the wait.

Note ice_ptp_ts_irq() checks ice_pf_state_is_nominal() and
ice_misc_intr_thread_fn() checks ice_is_reset_in_progress(), while
ice_ll_ts_intr() has no reset-state check.  Would keeping the tracker across
reset need an explicit disarm here (a state check honored by
ice_ll_ts_intr() plus synchronize_irq(pf->ll_ts_irq.virq)) rather than just
dropping the release?

[Severity: Medium]
Can the tracker allocations now leak at unload when the PTP state is not
ICE_PTP_READY?

tx->tstamps, tx->in_use and tx->stale are allocated in
ice_ptp_alloc_tx_tracker(), and after this change the only remaining free is
in the READY branch of ice_ptp_release():

	if (pf->ptp.state != ICE_PTP_READY) {
		mutex_destroy(&pf->ptp.port.ps_lock);
		ice_ptp_cleanup_pf(pf);
		if (pf->ptp.clock) {
			ptp_clock_unregister(pf->ptp.clock);
			pf->ptp.clock = NULL;
		}
		return;
	}
	...
	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);

ice_ptp_cleanup_pf() only unlinks the port from the adapter list and drops
the kref, so it does not touch the tracker.

If ice_ptp_rebuild_owner() fails, ice_ptp_rebuild() leaves the state at
ICE_PTP_ERROR:

err:
	ptp->state = ICE_PTP_ERROR;
	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);

and a failed ice_check_reset() leaves it at ICE_PTP_RESETTING.  A later
rmmod or unbind then takes the early-return branch above.  Does that leak the
timestamp array, both bitmaps, and any SKBs still pinned in tx->tstamps[]
along with their socket references?

[Severity: Medium]
With this call gone, the only reset-time flush left is
ice_ptp_flush_all_tx_tracker() inside ice_ptp_rebuild_owner().  What reclaims
the tracker if the reset never reaches ice_rebuild()?

drivers/net/ethernet/intel/ice/ice_main.c:ice_reset_subtask() {
		if (ice_check_reset(&pf->hw)) {
			set_bit(ICE_RESET_FAILED, pf->state);
		} else {
			...
			ice_rebuild(pf, reset_type);
	...
}

In that path ice_ptp_prepare_for_reset() has already run, so the pre-reset
tx->in_use bits stay set with skb_get() references pinned in tx->tstamps[]
and SKBTX_IN_PROGRESS still set, while the PHY timestamps were destroyed by
the reset.

The 2 second timeout drain cannot run either:

	if (pf->ptp.state != ICE_PTP_READY)
		return;

in ice_ptp_periodic_work(), and the work was cancelled in
ice_ptp_prepare_for_reset().  The OICR TSYN_TX cause was masked by
ice_ptp_disable_timestamp_mode() and is only re-enabled by
ice_ptp_restore_timestamp_mode() at the end of a completed ice_rebuild().
Combined with the non-READY branch of ice_ptp_release() above, are those SKBs
and their socket references then held for the remaining lifetime of the
driver instance?

For contrast, the narrower case of a *PTP* rebuild failure does still drain:
ice_ptp_rebuild() returns void, ice_rebuild() continues and calls
ice_ptp_restore_timestamp_mode(), so the stale entries age out via the 2 s
timeout.

[Severity: Medium]
After a failed CORE or GLOBAL PTP rebuild, does the retained tracker keep
accepting requests that can never complete?

tx->init now stays 1, and admission in ice_ptp_request_ts() consults only the
tracker:

	if (!ice_ptp_is_tx_tracker_up(tx)) {
		spin_unlock_irqrestore(&tx->lock, flags);
		return -1;
	}

ice_ptp_is_tx_tracker_up() tests tx->init && !tx->calibrating and never looks
at pf->ptp.state.  Meanwhile ice_ptp_rebuild() has set ICE_PTP_ERROR and
returned void, so ice_rebuild() reattaches the netdev and calls
ice_ptp_restore_timestamp_mode(), re-enabling the Tx timestamp cause, while
the PHY was never restarted (ice_ptp_restart_all_phy() sits after the failure
point) and:

	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
	    pf->ptp.state == ICE_PTP_READY)
		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work, 0);

in ice_ptp_queue_work() refuses to restart periodic processing.  Before this
patch tx->init had been cleared, so this error path rejected requests.  Would
each timestamp-requesting SKB now be held until the 2 second timeout drops it
and bumps tx_hwtstamp_timeouts?

[Severity: Medium]
Since peer PFs' trackers now survive CORER/GLOBR, can the clock owner's
rebuild flush race the peers?

ice_ptp_rebuild_owner() -> ice_ptp_flush_all_tx_tracker() walks every port of
the adapter:

		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);

and ice_ptp_flush_tx_tracker() does its PHY register work outside tx->lock:

	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
	...
		if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
			ice_clear_phy_tstamp(hw, tx->block, phy_idx);

On E810/E830 each PF uses ICE_PTP_TX_INTERRUPT_SELF, so a peer PF that has
already finished its own ice_rebuild() (and therefore
ice_ptp_restore_timestamp_mode()) can be inside ice_ptp_process_tx_tstamp()
reading the same block:

	if (tx->has_ready_bitmap) {
		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
	...
		err = ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);

Before this patch the peers' trackers had been released (tx->len = 0, in_use
NULL, tx->init = 0), so the owner's flush iterated nothing and the peers could
not process.  Can a timestamp be cleared between the peer's ready-bitmap read
and its register read here, which the comment in ice_ptp_process_tx_tstamp()
warns can wedge the interrupt generation logic?  Note the teardown path
(ice_ptp_release_tx_tracker()) clears tx->init and calls synchronize_irq()
before flushing, but the rebuild flush has no equivalent quiesce for peer
PFs.
