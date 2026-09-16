Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00538E5FE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521150; cv=none; b=Zwqpgg3POhBkpOP9AuyX6E0o+B8HGPLLwDRlEQm6+it3OyyXX/6YN5Kp48sFCFfvjfURVWglNvMmRT3cXOhMBu4VFUx1yWVkRviQQ0QzOL2aaToaBdSzo0ssZFKrYss1eLxubZiUGcbWf8EAL/8Oq/cEWx6qFWfN1L9roISf3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521150; c=relaxed/simple;
	bh=KGEE7l+XZqPm6M60Q10vhXd8x2vjQL1HTQfcyjfkR5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk6RfwWdasx2dx1zkEdIwSlMsYAhtomo6jsA4Bi1QvL99BbpuD8kny70JaXcCpxiJXi+9/7Jl/eEsHyR1O/7+NhXP5u6HGx5VmchHdjHY5TdC7poovdntgSk8LWPA9ietUvFCbL4qGZQQON1blilw+6cX7Z9BdxOVLPEGrBwKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLX30Jkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLX30Jkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEC71F00893;
	Wed, 16 Sep 2026 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521148;
	bh=eu7OkoLu3v4t0HOwttJMPPUAn2RFMCj/X8jZ6U5BN/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLX30Jkt5PaZKr3QLGmDFL33vrm0CJpGNNwLG8y/u+Hxi0OY2hVOMlmmFq40tJ4Si
	 XF/RkCJ5DeBzlrfHZ6g8u/1OuNZhvf1Hb5sYOvp6yjAe1or64j+hVkMnV1qtfitOFU
	 V48BcqE3Mf13onOA3zJ65RbbwLiREut3axpAOLm/+OTV28cfBkFa6beGwSquPVrSq/
	 wp6V6IvZp1AFSb8ZgaocSQzSLYc+DkqM0TSsdVVYpL96fdvXPObrEeIdCAeOVP9efZ
	 5cc8yrEflCUqVOGslsb97jj978XUr0cK2Jc0XymgzYnECmlAN2wrCUBVGw+VyB63ij
	 HJZ3j+V4z0A/Q==
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
Subject: Re: [PATCH net 14/15] ice: don't clear in_use until HW clears ready bitmap
Date: Tue, 15 Sep 2026 18:12:27 -0700
Message-ID: <20260916011227.1632810-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-15-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-15-anthony.l.nguyen@intel.com>
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
ice: don't clear in_use until HW clears ready bitmap

On E825 the PHY can leave the Tx timestamp ready bit and valid bit set
around a link down transition, so this change re-reads the ready bitmap
after each PHY timestamp read and marks the index stale if it is still
set. It also moves the hardware ready bitmap check out of
ice_ptp_tx_tstamps_pending() into the watchdog and stops re-arming the
interrupt while the tracker is calibrating or link is down.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index e060de5026621..832cc6ad2f90c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -620,6 +620,19 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  		if (err && !drop_ts)
>  			continue;
>  
> +		/* verify ready bit cleared */
> +		if (tx->has_ready_bitmap) {
> +			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> +			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
> +				spin_lock_irqsave(&tx->lock, flags);
> +				if (!test_and_set_bit(idx, tx->stale))
> +					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
> +						ptp_port->port_num, phy_idx);
> +				spin_unlock_irqrestore(&tx->lock, flags);
> +				continue;
> +			}
> +		}
> +

[Severity: High]
Should this new gate honour drop_ts the way the ready-bit gate just above
it does?

The earlier gate in ice_ptp_process_tx_tstamp() jumps to skip_ts_read when
the 2 second deadline has already passed:

	if (tx->has_ready_bitmap &&
	    !(tstamp_ready & BIT_ULL(phy_idx))) {
		if (drop_ts)
			goto skip_ts_read;

		continue;
	}

The new block instead does a plain continue, so for an index whose ready
bit stays set the skip_ts_read block is never reached:

skip_ts_read:
		spin_lock_irqsave(&tx->lock, flags);
		...
		clear_bit(idx, tx->in_use);
		skb = tx->tstamps[idx].skb;
		tx->tstamps[idx].skb = NULL;

That is the only place in this function that clears in_use, detaches the
SKB and later calls dev_kfree_skb_any() on the reference taken by
skb_get() in ice_ptp_request_ts(). Does this mean the 2 second timeout
reclaim no longer works for exactly the stuck-ready-bit case the patch
targets, holding up to INDEX_PER_PORT (64) SKBs per port, each with
SKBTX_IN_PROGRESS still set and each pinning its socket, for as long as
the condition lasts?

On this path ice_ptp_link_change() only calls
ice_ptp_mark_tx_tracker_stale() for ICE_MAC_GENERIC_3K_E825 and does not
flush, and ice_ptp_flush_tx_tracker() is only reached from
ice_ptp_release_tx_tracker() and ice_ptp_flush_all_tx_tracker(), so is
recovery dependent on a link-up event that may never arrive while a cable
stays unplugged?

There is a second effect from the same continue. Because the entry is
never released and tx->tstamps[idx].start is never refreshed, this block
in the same loop runs again on every pass:

		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
			drop_ts = true;

			/* Count the number of Tx timestamps that timed out */
			pf->ptp.tx_hwtstamp_timeouts++;
		}

With the watchdog seeing ice_check_phy_tx_tstamp_ready() > 0 and
re-triggering the IRQ every 500 ms, does tx_hwtstamp_timeouts grow by
roughly two per second per stuck index without any SKB actually being
discarded? That counter is user visible both as ethtool -S
tx_hwtstamp_timeouts in ice_gstrings_pf_stats and as the standard
ts_stats lost field filled in by ice_ptp_get_ts_stats(), and it is
documented as the number of Tx skbs discarded with no time stamp.

>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
>  
>  		/* For PHYs which don't implement a proper timestamp ready
> @@ -2768,10 +2781,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>  		if (!tx->init)
>  			return false;
>  
> -		if (in_irq)
> +		if (in_irq) {
> +			if (!ice_ptp_is_tx_tracker_up(tx))
> +				return false;
> +
>  			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
> -		else
> +		} else {
>  			return !bitmap_empty(tx->in_use, tx->len);
> +		}
>  	}
>  }
>  
> @@ -2794,41 +2811,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
>  
>  bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>  {
> -	struct ice_hw *hw = &pf->hw;
> -	int ret;
> -
> -	/* Check software indicator */
>  	switch (pf->ptp.tx_interrupt_mode) {
>  	case ICE_PTP_TX_INTERRUPT_NONE:
>  		return false;
>  	case ICE_PTP_TX_INTERRUPT_SELF:
> -		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
> -			return true;
> -		break;
> +		return ice_port_has_timestamps(&pf->ptp.port.tx, in_irq);
>  	case ICE_PTP_TX_INTERRUPT_ALL:
> -		if (ice_any_port_has_timestamps(pf, in_irq))
> -			return true;
> -		break;
> +		return ice_any_port_has_timestamps(pf, in_irq);
>  	default:
>  		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
>  			  pf->ptp.tx_interrupt_mode);
> -		break;
> -	}
> -
> -	/* Check hardware indicator */
> -	ret = ice_check_phy_tx_tstamp_ready(hw);
> -	if (ret < 0) {
> -		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
> -			ret);
> -		/* Stop triggering IRQs if we're unable to read PHY */
>  		return false;
>  	}
> -
> -	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
> -	 * available, 0 if there are no waiting timestamps, and a negative
> -	 * value if there was an error (which we checked for above).
> -	 */
> -	return ret > 0;
>  }

[Severity: High]
After this change, which code path still consults the hardware ready
bitmap for an E830 PF that does not own the source timer?

ice_ptp_init_tx_interrupt_mode() assigns ICE_PTP_TX_INTERRUPT_SELF to
E810 and E830 PFs in the default arm of its switch, owner or not. The
hardware check has moved into ice_ptp_maybe_trigger_tx_interrupt(), which
returns before reaching it:

	if (!ice_pf_src_tmr_owned(pf))
		return;

	ret = ice_check_phy_tx_tstamp_ready(hw);

So for a non-owner E830 PF, both remaining re-arm sites,
ice_ptp_ts_irq() (case ICE_MAC_E830) and ice_misc_intr_thread_fn(), now
decide purely from the software tracker, and that decision was further
narrowed by the new ice_ptp_is_tx_tracker_up() early return and by
masking stale bits with bitmap_andnot().

The commit message says:

    Continue to check the hardware ready bitmap from the watchdog to catch
    cases of unexpected timestamps.

Does that hold only for clock-owner PFs? The kernel-doc of
ice_ptp_maybe_trigger_tx_interrupt() states the hardware will not
interrupt again until all current timestamp data is read, so does a valid
bit that software never reads block all further Tx timestamp interrupts on
that PF until a reset?

Two ways such an orphaned bit looks reachable on E830:

  - link down runs ice_ptp_mark_tx_tracker_stale(), which ORs stale over
    in_use and clears link_up, so the in_irq check returns false while the
    hardware bits for in-flight captures get set and are never read.

  - ice_ptp_flush_tx_tracker() clears in_use for an entry whose capture
    completes after the 10 ms drain wait, and ice_clear_phy_tstamp() has
    no E830 case (-EOPNOTSUPP), so the valid bit stays set with no
    software owner.

E810 looks unaffected since ice_check_phy_tx_tstamp_ready_e810() always
returns 0, and E82x uses the ALL/NONE modes where the owner still runs the
watchdog.

>  
>  /**
> @@ -2912,6 +2906,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  {
>  	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw *hw = &pf->hw;
> +	int ret;
>  
>  	if (!pf->ptp.port.tx.has_ready_bitmap)
>  		return;
> @@ -2919,7 +2914,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  	if (!ice_pf_src_tmr_owned(pf))
>  		return;
>  
> -	if (ice_ptp_tx_tstamps_pending(pf, false)) {
> +	ret = ice_check_phy_tx_tstamp_ready(hw);
> +	if (ret < 0) {
> +		dev_dbg(dev, "Unable to read PHY Tx timestamp ready bitmap, err %pe\n",
> +			ERR_PTR(ret));
> +		/* Don't trigger an IRQ if we are unable to access the PHY */
> +		return;
> +	}
> +
> +	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>  
>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

[Severity: Medium]
One more question on a related patch in this series rather than on this
hunk. The patch "ice: fix removal of PTP timestamp tracker during reset"
dropped the ice_ptp_release_tx_tracker() call from
ice_ptp_prepare_for_reset(), so the tracker now survives a reset.

If ice_ptp_rebuild() then fails, it takes the err label:

err:
	ptp->state = ICE_PTP_ERROR;
	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);

A later ice_ptp_rebuild() cannot recover, since the state is neither
READY nor RESETTING and it returns -EINVAL. On unload, ice_ptp_release()
takes the abbreviated branch:

	if (pf->ptp.state != ICE_PTP_READY) {
		mutex_destroy(&pf->ptp.port.ps_lock);
		ice_ptp_cleanup_pf(pf);
		if (pf->ptp.clock) {
			ptp_clock_unregister(pf->ptp.clock);
			pf->ptp.clock = NULL;
		}
		return;
	}

which never calls ice_ptp_release_tx_tracker(). Does this leak the
tstamps array and the two bitmaps allocated in
ice_ptp_alloc_tx_tracker(), along with any SKB references still held in
tx->tstamps[].skb, since ice_ptp_flush_tx_tracker() is not reached
either? Would releasing the tracker in the non-READY branch of
ice_ptp_release(), or on the ice_ptp_rebuild() error path, be
appropriate?
