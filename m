Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440842;
	b=aryOEm8rLimzY+Xw0t+1K8VtsWaoAFTI1foOW1QGZGGtRc7xNi7vYSpFI/ZlNOS7zCGi
	 TwvL3AUha6bdQqn2yovirD9MjnJS99QYqFQhHE2ZCoDAezV7xrTEZu1ACsk2wfcE3TOUr
	 W3FWQj5z2fw9XN0P5ZW1o05mARCrruOOBqDq/jdSmgo7aDCyXKHxKceQSZyoh80dhu4Xo
	 TbJBb7t30ybMTYejLzDeL/VioR4wOpeVpdkLWlhShPlIo2qAru9/9+28FFgmYEc6aYT6p
	 dX+wfMoZt1+Xo/f+znRANlTzef9mbPltujuPtyk+Ev//8wUUlG7lPDdqeMNuiINlF0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440842;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FAn1ASQhBjAdskRy0U6YDMXo9t6gxFS4L8VQIffvUAA=;
	b=vS4FiFv6H7O2pqQDanzwWtl18sRj1S8kTWN9j/mDIDDGE8IGciizfZ5wbQ6xaCdrX3GA
	 CO7ziOCp2SWzR/OAVQA4m9ArI2uYJxR2aGjI4EdQnzVuAwX9Vxd0Y3PoHxaoQ07JNdCmH
	 Df19fCav+4Bn0T+wTpmCbJp5I+DgUWqRnPc4U1KHDfveV60nLcwjFpDpZ3FisGGpELrkM
	 +qB5fCk/3/iywBvTtNFgSqXCCe4c1+784TkAAIWUExx+zu0Ge//+psBVJenBb8Eo9LHkj
	 JTl9PGd2Z9aHZn7EhzkezarPhYI4YURxNVgxSnj3w8Xgo3XuMpKGTf493tYmlkQF7Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/pObdYz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE13606A321
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/pObdYz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8D81F000C6;
	Mon, 19 Oct 2026 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440842;
	bh=FAn1ASQhBjAdskRy0U6YDMXo9t6gxFS4L8VQIffvUAA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W/pObdYzOFCkiNT5CbbX+l9gIYnbJiYeRsUPZEjUDL31lPpy/dlxIH6vRI8jji9jz
	 PYkeyxxObAJAW0/FBubxdiqsEG5zataVFdYlhwMfIp2sTk/7156JaK+dxY8UAdph8P
	 b/OyVOznQOSm1hdaj0F+wAqUZIXUK4q6WQvrbDwvv1O4cR6EG2PqIfrBZxJzDscbNL
	 dh26wAN4sTGvMERtT0W9B4EiOYioWx2ZktW8NTODk9FUFg5y3r0yfVOxEq5eGqPEDA
	 NHXp8d4fpBmYpw3/ZHNJe2cRa32Gwg2MciNdm8Hs3BYUeIsRnFl7XS0hQ0QyOqCku/
	 jnfG2K9M9jFAQ==
Subject: Re: [PATCH net v3 01/14] ice: fix removal of PTP timestamp tracker
 during reset
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:00 +0000
Message-ID: <179244084072.3135.7212710300124211509@kernel.org>
In-Reply-To: <20261015191102.1174111-2-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On the clock owner, ice_ptp_init_owner() ->
  ice_ptp_create_clock() registers the PHC (/dev/ptpN) before the…
- [Medium] Because the E810 tracker is now kept across CORE/GLOBAL/EMP
  reset, the per-slot tx->tstamps[idx].cached_tstamp values survive the…

Pre-existing issues:
- [High] ice_ptp_setup_adapter() sets `pf->adapter->ctrl_pf = pf` for the
  clock-owner PF, and nothing ever clears it: not in the ice_ptp_init()…
- [High] At this commit the clock owner walks pf->adapter->ports.ports
  without adapter->ports.lock in ice_ptp_flush_all_tx_tracker(),…

--

ice: fix removal of PTP timestamp tracker during reset

This patch stops ice_ptp_prepare_for_reset() from releasing the Tx
timestamp tracker, so timestamping can resume after a CORE, GLOBAL or EMP
reset. It also reorders ice_ptp_init() so the kworker and tracker are
created before the port is added to the adapter port list. Finally, it
makes ice_ptp_release() do a full cleanup when PTP is not in the READY
state.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index eaec36ab6ae3f..e1c66cd0f94ff 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>  
> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> -

[Severity: Medium]
The tracker is now kept across CORE/GLOBAL/EMP reset. On E810, does that
leave the per-slot tx->tstamps[idx].cached_tstamp values out of sync with
the hardware?

During rebuild, the call chain is
ice_ptp_rebuild_owner()->ice_ptp_flush_all_tx_tracker()->
ice_ptp_flush_tx_tracker(). E810 reports every slot ready and
hw->reset_ongoing has already been cleared, so every in_use slot is
cleared in hardware:

	if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
		ice_clear_phy_tstamp(hw, tx->block, phy_idx);

ice_clear_phy_tstamp_e810() writes 0 to both halves of the slot. The
flush only clears skb, in_use and stale, so cached_tstamp keeps its old
non-zero value.

E810 has no ready bitmap. It detects a new capture by comparing the
register with cached_tstamp. If the slot is reused and read before the
new capture lands, the register reads 0, which does not match the cache.

In ice_ptp_process_tx_tstamp() the "not yet captured" check is then
skipped:

		if (!drop_ts && !tx->has_ready_bitmap &&
		    raw_tstamp == tx->tstamps[idx].cached_tstamp)
			continue;

		/* Discard any timestamp value without the valid bit set */
		if (!(raw_tstamp & ICE_PTP_TS_VALID))
			drop_ts = true;

so the request is dropped without a timestamp.

ice_ptp_complete_tx_single_tstamp() has no valid bit check:

	if (raw_tstamp == tx->tstamps[idx].cached_tstamp)
		return;

	tx->tstamps[idx].cached_tstamp = raw_tstamp;

Is 0 then taken as a fresh capture, extended through
ice_ptp_extend_40b_ts(), and delivered to the socket as a bogus Tx
timestamp?

Before this patch, and before 7a25fe5cd5fb, the tracker was either
freed or reallocated zeroed, so the cache and the hardware matched.
Should the flush also reset cached_tstamp?

[ ... ]

> @@ -3347,13 +3346,17 @@ void ice_ptp_init(struct ice_pf *pf)
>  		}
>  	}
>  
> -	err = ice_ptp_setup_pf(pf);
> +	err = ice_ptp_init_work(pf, ptp);
>  	if (err)
>  		goto err_exit;
>  
>  	err = ice_ptp_init_port(pf, &ptp->port);
>  	if (err)
> -		goto err_clean_pf;
> +		goto err_release_kworker;
> +
> +	err = ice_ptp_setup_pf(pf);
> +	if (err)
> +		goto err_release_tx_tracker;

[ ... ]

> -err_clean_pf:
> +err_release_tx_tracker:
> +	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> +err_release_kworker:
> +	kthread_cancel_delayed_work_sync(&ptp->work);
> +	kthread_destroy_worker(ptp->kworker);
> +	ptp->kworker = NULL;
>  	mutex_destroy(&ptp->port.ps_lock);
> -	ice_ptp_cleanup_pf(pf);
>  err_exit:
>  	/* If we registered a PTP clock, release it */
>  	if (pf->ptp.clock) {

[Severity: High]
On the clock owner, ice_ptp_init_owner()->ice_ptp_create_clock() has
already registered the PHC before ice_ptp_init_work() and
ice_ptp_init_port() run. If ice_ptp_init_port() fails (for example with
-ENOMEM from ice_ptp_alloc_tx_tracker()), this unwind destroys the worker
and sets ptp->kworker to NULL. Only after that does err_exit call
ptp_clock_unregister().

Can a concurrent clock_settime() or clock_adjtime() on /dev/ptpN reach
the driver in that window? ice_ptp_settime64() and ice_ptp_adjtime() call
ice_ptp_reset_cached_phctime() without any state check:

ice_ptp_reset_cached_phctime() {
    ...
	err = ice_ptp_update_cached_phctime(pf);
	if (err) {
		...
		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
					   msecs_to_jiffies(10));
	}
    ...
}

That branch runs whenever ICE_CFG_BUSY is already held, for example by a
second concurrent settime or adjtime.

If this lands after ptp->kworker = NULL, is it a NULL pointer
dereference?

If it lands between kthread_cancel_delayed_work_sync() and
kthread_destroy_worker(), does it re-arm the delayed work timer on a
worker that is then freed? The timer callback would later touch the
freed worker.

ice_ptp_mark_tx_tracker_stale() also runs bitmap_or() on tx->stale
without checking tx->init. Could it race with
ice_ptp_release_tx_tracker() freeing the bitmaps when coming from
err_release_tx_tracker?

The new non-READY branch of ice_ptp_release() unregisters the clock
first. Should this error path use the same order?

The same ordering is still present in two other places. On the success
path the PHC is registered before ice_ptp_init_work() creates the
kworker. The READY branch of ice_ptp_release() still destroys the kworker
before ptp_clock_unregister().

The later patch "ice: use reference counting and SRCU for PTP port
access" adds a tx->init check to ice_ptp_mark_tx_tracker_stale(). It
does not change the kworker vs. unregister ordering.

> @@ -3399,12 +3405,22 @@ void ice_ptp_release(struct ice_pf *pf)
>  		return;
>  
>  	if (pf->ptp.state != ICE_PTP_READY) {
> -		mutex_destroy(&pf->ptp.port.ps_lock);
> -		ice_ptp_cleanup_pf(pf);
>  		if (pf->ptp.clock) {
>  			ptp_clock_unregister(pf->ptp.clock);
>  			pf->ptp.clock = NULL;
>  		}
> +		ice_ptp_cleanup_pf(pf);
> +		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);

[Severity: High]
This is a pre-existing issue, but at this commit the clock owner walks
pf->adapter->ports.ports without adapter->ports.lock in
ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy() and
ice_ptp_prepare_rebuild_sec():

	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);

A peer PF's ice_ptp_cleanup_pf() removes its node under ports.lock. This
path then frees that peer's Tx tracker, kworker and ps_lock. Nothing
waits for the unlocked walkers, so can the owner still be using the
peer's port memory after it is freed?

The later patch in this series, "ice: use reference counting and SRCU
for PTP port access", seems to fix this. It converts these walkers to
SRCU with kref_get_unless_zero(), and ice_ptp_cleanup_pf() waits for
readers to drain before the tracker and kworker are freed.

> +		if (pf->ptp.kworker) {
> +			kthread_cancel_delayed_work_sync(&pf->ptp.work);
> +			if (pf->hw.mac_type == ICE_MAC_GENERIC)
> +				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
> +			kthread_destroy_worker(pf->ptp.kworker);
> +			pf->ptp.kworker = NULL;
> +		}
> +		mutex_destroy(&pf->ptp.port.ps_lock);
> +
> +		pf->ptp.state = ICE_PTP_UNINIT;
> +		return;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but adapter->ctrl_pf is never
cleared. ice_ptp_setup_adapter() sets it for the clock owner:

static void ice_ptp_setup_adapter(struct ice_pf *pf)
{
	pf->adapter->ctrl_pf = pf;
}

Neither branch of ice_ptp_release() resets it, and neither does the
ice_ptp_init() error path.

The ice_adapter is shared and refcounted across all PFs of the device.
The owner's ice_pf is freed when that PF unbinds. If only the owner PF is
unbound (for example through sysfs for VFIO passthrough) and the other
PFs stay bound, is adapter->ctrl_pf left pointing at freed memory?

Any user could then reach it by running ethtool -T on a remaining PF:

ice_get_ts_info()
  ice_ptp_clock_index()
    ice_get_ctrl_ptp()        <- &freed_pf->ptp
    ptp_clock_index(ctrl_ptp->clock)

Other users of the pointer are ice_ptp_setup_pf() on re-init and the
ice_txclk.c paths, which take ctrl_pf->dplls.lock and touch
ctrl_pf->ptp.tx_refclks. This is still unchanged at the end of the
series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
