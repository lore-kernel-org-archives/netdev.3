Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC503DAC13
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846921; cv=none; b=bp8Qr6+nQj3achIuGbjRYwcItnTxLflL2nPz2DOZ3T0rEFAC2aSSnl/Iz8txhNB3DKjumGNC1D5cvkpZmlt4Q9M+DW3hALbVim8EfHjmhUk1XCoadX97DnVITAoFnXlgOvrhYatJWpkBPr1yBf55+mSZA/+0hKA1lEGvw0nnTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846921; c=relaxed/simple;
	bh=78EP13SeR8CZpaSSWhWLL346nfC+Flhi1Nb9EW8Q5HY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ndaj3vVu9gMQMKWbFAAH9eS8rr8KEOCk+tKNwDgDuVKBwxmahnVcoULfPQwdY2rmnGSKo+63sGGDqxtjtWpvDd9+FsLPU+IewuFY/mF0PjiG4sWgph+d3SkiCbUU2GaMK6PG3uwlQ3c/wrnMhZ2ZEpev7wXQ3QDMBTM0xUgmF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0dtRYig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0dtRYig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C51F008A1;
	Mon, 12 Oct 2026 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846919;
	bh=nMBY2yWHbP63tpSqtiMy9TKiRHMxbn8wNvOwVwaDI8o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F0dtRYigWYySKs50LsLTYw8IsKlKeoDa1Ay58UOavuySiNbJmMlhzFksFoFQqAFh+
	 keScHmnwgU+YhTLobxfkWEhoXjkML8kjyLdPbkgGb3SZDnh7Em5BT5czsgoayKJgov
	 d+fNFngv2ltxZ22p0BKh6+eP3+V0mAPqOKsovGd56Qrr5fmZQW+WvfAw1dopFpEJG5
	 YmZumXx+wdhn4Y4DUVDsRp9T4xB8dpIXR3bxQ7zjwNzH/upBV6C6AdWVKPoOgXcj0i
	 wepbtxatouBnQVojDdKS2AtBPVI98Q3oyXOCNmgnVOy243QAhaiYoqImbcz3J4UxPo
	 zismrcUvZM/wg==
Subject: Re: [PATCH net v2 01/15] ice: fix removal of PTP timestamp tracker
 during reset
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
Date: Mon, 12 Oct 2026 23:15:18 +0000
Message-ID: <179184691805.434549.1970305171129280416@kernel.org>
In-Reply-To: <20261008215614.1987250-2-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 (4) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new non-READY (ERROR/RESETTING) branch of ice_ptp_release()
  destroys the worker too early.
- [Medium] The patch removes ice_ptp_release_tx_tracker() from
  ice_ptp_prepare_for_reset() and puts nothing in its place.
- [Medium] At this commit, when ice_ptp_init_work() fails, the code now
  jumps to err_clean_pf.
- [Medium] Now that the Tx tracker survives CORE/GLOBAL/EMP resets, its
  per-index tstamps[idx].cached_tstamp and last_ll_ts_idx_read are never…

Pre-existing issues:
- [Medium] The non-READY branch of ice_ptp_release() tears everything
  down: kworker, clock, list_del via ice_ptp_cleanup_pf(), the Tx…
- [Medium] At this commit, ice_ptp_flush_all_tx_tracker(),
  ice_ptp_restart_all_phy() and ice_ptp_prepare_rebuild_sec() walk…
- [Medium] On E825, ice_ptp_setup_pf() sets this port's bit in the
  control PF's shared tx_refclks[phy][tx_clk] map.
- [Medium] Neither the ice_ptp_init() error unwind (after
  ice_ptp_reset_phy_timestamping() and ice_ptp_cfg_tx_interrupt()) nor…

--

ice: fix removal of PTP timestamp tracker during reset

This commit stops releasing the PTP Tx timestamp tracker in
ice_ptp_prepare_for_reset(), so timestamping can resume after CORE, GLOBAL
or EMP resets. It reorders ice_ptp_init() so the tracker is allocated
before the port is added to the port list, and the tracker is released on
error. ice_ptp_release() now cancels the kworker and releases the tracker
when PTP is not in the READY state.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index eaec36ab6ae3f..fe21cee4f9dee 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>  
> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> -

[Severity: Medium]

With this call removed, nothing clears tx->init or calls synchronize_irq()
before a CORE, GLOBAL or EMP reset. Is that intended?

The Tx timestamp paths check only tx->init and tx->calibrating. They never
check ptp->state. Suppose ice_ptp_rebuild() fails:

ice_ptp_rebuild()
    err:
        ptp->state = ICE_PTP_ERROR;

ice_rebuild() still calls ice_ptp_restore_timestamp_mode()
unconditionally, and that re-enables the Tx timestamp interrupt. After
that, ice_tstamp()->ice_ptp_request_ts() only checks:

    if (!ice_ptp_is_tx_tracker_up(tx)) {

So slots are still handed out (skb_get() plus SKBTX_IN_PROGRESS) against a
PHC that isn't running. In the ERROR state cached_phc_jiffies is never
refreshed, so ice_ptp_extend_40b_ts() would discard the result. Before
this patch, these requests were refused and counted in
tx_hwtstamp_skipped.

During the reset window itself, ice_ll_ts_intr() only checks tx->init:

    if (tx->init) {
        ice_ptp_complete_tx_single_tstamp(tx);

The E810 path in ice_ptp_ts_irq() also checks ice_pf_state_is_nominal().
Can the LL proxy registers now be accessed in the middle of a reset?

The commit message doesn't mention this change in behaviour. Later patches
in the series only add link_up and calibrating gating, so tx->init still
stays set across the reset.

[Severity: Medium]

The tracker now survives the reset, so tstamps[idx].cached_tstamp and
last_ll_ts_idx_read are no longer reset. The E810 PHY timestamp memory is
still reset. Can the two get out of sync?

On rebuild, ice_ptp_rebuild_owner()->ice_ptp_flush_all_tx_tracker()->
ice_ptp_flush_tx_tracker() calls ice_clear_phy_tstamp() for every in_use
index, because tstamp_ready is all ones on E810.
ice_clear_phy_tstamp_e810() then writes 0 to both halves:

    err = ice_write_phy_reg_e810(hw, lo_addr, 0);
    ...
    err = ice_write_phy_reg_e810(hw, hi_addr, 0);

E810 has no ready bitmap. It detects a new capture by checking raw_tstamp
!= cached_tstamp. After the reset, a reused index that hasn't captured yet
reads 0, and 0 differs from the stale cached value.

In ice_ptp_process_tx_tstamp(), the missing VALID bit makes it drop the
timestamp and release the slot. Because raw is 0, cached_tstamp isn't
updated, so the later real capture could be credited to the next request
that uses that index.

ice_ptp_complete_tx_single_tstamp() has no VALID check:

    if (raw_tstamp == tx->tstamps[idx].cached_tstamp)
        return;

    tx->tstamps[idx].cached_tstamp = raw_tstamp;
    clear_bit(idx, tx->in_use);

It would then pass ice_ptp_extend_40b_ts(pf, 0) to skb_tstamp_tx().

Before 7a25fe5cd5fb the tracker was reallocated with zeroed cached values,
so software and hardware stayed in sync. This is still present at the end
of the series.

>  	/* Disable periodic outputs */
>  	ice_ptp_disable_all_perout(pf);
>  
> @@ -3347,13 +3345,13 @@ void ice_ptp_init(struct ice_pf *pf)
>  		}
>  	}
>  
> -	err = ice_ptp_setup_pf(pf);
> +	err = ice_ptp_init_port(pf, &ptp->port);
>  	if (err)
> -		goto err_exit;
> +		goto err_destroy_ps_lock;
>  
> -	err = ice_ptp_init_port(pf, &ptp->port);
> +	err = ice_ptp_setup_pf(pf);
>  	if (err)
> -		goto err_clean_pf;
> +		goto err_release_tx_tracker;
>  
>  	/* Start the PHY timestamping block */
>  	ice_ptp_reset_phy_timestamping(pf);

[Severity: Medium]

This isn't a bug introduced by this patch, but neither the ice_ptp_init()
error unwind nor the non-READY branch of ice_ptp_release() puts the
hardware back into a quiet state.

ice_ptp_reset_phy_timestamping() and ice_ptp_cfg_tx_interrupt() run before
ice_ptp_init_work(). If ice_ptp_init_work() then fails, the unwind never
calls ice_ptp_disable_timestamp_mode(), ice_ptp_port_phy_stop() or the
perout/extts disables.

Can OICR TSYN_TX, PHY timestamping and the SDP outputs stay armed after the
software state has been torn down?

[ ... ]

> @@ -3365,14 +3363,17 @@ void ice_ptp_init(struct ice_pf *pf)
>  
>  	err = ice_ptp_init_work(pf, ptp);
>  	if (err)
> -		goto err_exit;
> +		goto err_clean_pf;

[Severity: Medium]

When ice_ptp_init_work() fails, this path now frees the Tx tracker and
destroys ps_lock. However, ptp->state was set just above:

    ptp->state = ICE_PTP_READY;

    err = ice_ptp_init_work(pf, ptp);
    if (err)
        goto err_clean_pf;

The PHC is also still registered at this point. Could ice_ptp_link_change(),
ice_ptp_queue_work() or the PHC callbacks touch the freed tracker or the
destroyed mutex in this window? One example is
ice_ptp_reset_cached_phctime()->ice_ptp_mark_tx_tracker_stale().

The NULL kworker exposure while READY was already there before. Later in
the series, ice_ptp_init() creates the kworker earlier and sets
ICE_PTP_READY only after ice_ptp_init_work() succeeds, which appears to
close this. At this commit the window is still open.

>  
>  	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
>  	return;
>  
>  err_clean_pf:
> -	mutex_destroy(&ptp->port.ps_lock);
>  	ice_ptp_cleanup_pf(pf);

[Severity: Medium]

This is a pre-existing issue, but on E825 ice_ptp_setup_pf() sets this
port's bit in the control PF's shared map:

    set_bit(port_num,
            &ctrl_ptp->tx_refclks[phy][pf->ptp.port.tx_clk]);

ice_ptp_cleanup_pf() only does list_del() and never clears that bit. After
this error path, or after an unbind, would ice_txclk_any_port_uses() still
count this port as a user of the reference clock?

> +err_release_tx_tracker:
> +	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> +err_destroy_ps_lock:
> +	mutex_destroy(&ptp->port.ps_lock);
>  err_exit:

[ ... ]

> @@ -3399,12 +3400,20 @@ void ice_ptp_release(struct ice_pf *pf)
>  		return;
>  
>  	if (pf->ptp.state != ICE_PTP_READY) {
> -		mutex_destroy(&pf->ptp.port.ps_lock);
> -		ice_ptp_cleanup_pf(pf);
> +		if (pf->ptp.kworker) {
> +			kthread_cancel_delayed_work_sync(&pf->ptp.work);
> +			if (pf->hw.mac_type == ICE_MAC_GENERIC)
> +				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
> +			kthread_destroy_worker(pf->ptp.kworker);
> +			pf->ptp.kworker = NULL;
> +		}

[Severity: High]

The worker is destroyed here and pf->ptp.kworker is set to NULL. The PHC is
only unregistered further down, and the port stays on
adapter->ports.ports until ice_ptp_cleanup_pf() runs. Can anything still
reach this worker in between?

On ICE_MAC_GENERIC, ice_ptp_settime64() calls ice_ptp_restart_all_phy()
without checking ptp->state. ice_ptp_adjtime() does the same through its
non-atomic path. ice_ptp_restart_all_phy() walks the list without
ports.lock:

    list_for_each(entry, &pf->adapter->ports.ports) {
        ...
        if (port->link_up)
            ice_ptp_port_phy_restart(port);
    }

ice_ptp_port_phy_restart() then does:

    case ICE_MAC_GENERIC:
        kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
        ...
        kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
                                   0);

Here pf is the releasing PF. That covers the releasing PF's own port, and
also its port when it is a peer and the owner PF is the one calling
settime.

ice_ptp_reset_cached_phctime() also queues on pf->ptp.kworker when
ICE_CFG_BUSY is set, with no NULL or state check.

Before this patch the non-READY branch leaked the worker rather than
freeing it, so this NULL dereference or use-after-free of the
kthread_worker looks new. It can be hit if a PF in ERROR or RESETTING
state is unbound while userspace calls clock_settime() on the owner PHC.

Could the clock be unregistered and the port removed from the list before
the worker is destroyed? The commit message already describes that
ordering for ps_lock. The ordering here is unchanged at the end of the
series.

>  		if (pf->ptp.clock) {
>  			ptp_clock_unregister(pf->ptp.clock);
>  			pf->ptp.clock = NULL;
>  		}
> +		ice_ptp_cleanup_pf(pf);
> +		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);

[Severity: Medium]

This is a pre-existing issue, but three functions walk
adapter->ports.ports without ports.lock: ice_ptp_flush_all_tx_tracker(),
ice_ptp_restart_all_phy() and ice_ptp_prepare_rebuild_sec(). For example:

    list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
        ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);

Meanwhile ice_ptp_cleanup_pf() unlinks the port under the lock, and
ice_ptp_release_tx_tracker() then frees the tracker. Trackers now stay
allocated across CORE/GLOBAL resets, so the owner's rebuild-time flush
works on live peer trackers. Can one of these walkers race with this
teardown?

A later patch in this series, "ice: use reference counting and SRCU for
PTP port access", converts these walkers to SRCU with kref and appears to
close this race.

> +		mutex_destroy(&pf->ptp.port.ps_lock);
>  		return;
>  	}

[Severity: Medium]

This isn't a bug introduced by this patch, but this branch tears
everything down and returns without setting pf->ptp.state to
ICE_PTP_UNINIT. If ice_ptp_release() runs again before ice_ptp_init()
resets the state, would ice_ptp_cleanup_pf() call list_del() on a node
that already holds LIST_POISON pointers?

One possible sequence:

1. devlink reinit_down runs while PTP is in ERROR or RESETTING, which goes
   through ice_unload()->ice_ptp_release().
2. reinit_up fails before ice_load().
3. ice_remove()->ice_unload()->ice_deinit_features()->ice_ptp_release()
   runs again.

The old branch had the same list_del() without a state change, and the end
of the series still doesn't set ICE_PTP_UNINIT here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
