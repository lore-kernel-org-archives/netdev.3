Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9073E317B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846932; cv=none; b=GIsBwf2x4L9/R+4Jcq/VmH/Ynv7kP+kopDOpQoURyE5K1E8clIrupEJkMAaWUgzJqHIftYKe2e7EniD4Bg8AtmD2d0x7HYeCv36zOG9o7FpZTB4m7BDsaDHCQpZQoPYVcTTNyZti1Z0f/+Z+7QAQvhyFNtROS0NN7SYegffT4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846932; c=relaxed/simple;
	bh=caFZMsXPTe8fscQ9kBJQMJMKhzeXuQGmkRQR54yP2k0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJafXYJGZOeksi0wuAVuvZPtpDMFHl5/xVk3zgLqLr2XOMzXsFgNRhOVj+cyu3aRpF631TUh62L7jJ1biDY2OY2RmiinyuN6mF7OXAvy8d5oWXGDud7GxdqALtQauN3ug2zyUN9qtsnLZCzjlq5ZUbUvKhl2kG+NNoduRimv+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COkpJ+No; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COkpJ+No"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AD71F008A1;
	Mon, 12 Oct 2026 23:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846931;
	bh=Z5kA9mQevNCzRqctBOtgmPUbzLyAWl49+s2VlpFfwo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=COkpJ+No7IRez+DPHTCvSO+Ri9ogkhI7tFzwFBBx3MrAyKpXmChA/F4aj1ssp3c6B
	 dd6t1KsIEc8AyzBWC3B7d5E8zamKrAdH9vv3UusgXle+pGhoXJaSVFNgvsu4B7VWk7
	 R4XgQKE/NIR27gqnTubdNfEZXCmxp1mvzqdU7ETEA6xyiYcpmnoMnoUu62yUK2e89R
	 +5xKsZ+2lw4cMAA17Pm5kW4vQpxAkjfAPOpxC2fOkLzWve3GWFVPlhOQHpNeFEdgyF
	 j3JePaMWNPFMxsufJ2x5+kYs+vbJBDdIWm59ZW9xkoHLfZ9LadT6pbQucseagSbweT
	 bBsdDOVwysBjA==
Subject: Re: [PATCH net v2 11/15] ice: wait for in-flight Tx timestamps before
 flushing the tracker
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
Date: Mon, 12 Oct 2026 23:15:30 +0000
Message-ID: <179184693018.434549.11776352686949111433@kernel.org>
In-Reply-To: <20261008215614.1987250-12-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-12-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On E830 the flush still leaves hardware-ready entries
  unacknowledged, so the drain does nothing for a device the commit…
- [Low] ice_ptp_rebuild_owner() calls ice_ptp_flush_all_tx_tracker(),
  which now runs ice_ptp_wait_for_tracker_drain() on every port of the…

Pre-existing issues:
- [Low] At this commit, ice_ptp_process_tx_tstamp() sets drop_ts =
  !link_up (line 592).

--

ice: wait for in-flight Tx timestamps before flushing the tracker

This patch adds a poll to ice_ptp_flush_tx_tracker(). For up to 10 ms per
port, it waits for the PHY to publish ready bits for all in-use Tx
timestamp slots, and only then flushes the tracker. E810 has no ready
bitmap, so it skips the wait.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 818e2e265a7e5..5220de274819a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -744,6 +744,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)

[ ... ]

> +static void
> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
> +{
> +	bool drained;
> +	int err;
> +
> +	if (!tx->has_ready_bitmap)
> +		return;

[Severity: Medium]
Does the drain actually help on E830? E830 has has_ready_bitmap set, so it
enters this wait. The commit message also lists it among the devices that
benefit:

  "Only later devices (E822, E825, E830) have the bitmap ... Thus, skip
  the wait for E810"

However, ice_clear_phy_tstamp() in ice_ptp_hw.c has no E830 case:

ice_clear_phy_tstamp() {
	switch (hw->mac_type) {
	case ICE_MAC_E810:
		return ice_clear_phy_tstamp_e810(hw, block, idx);
	case ICE_MAC_GENERIC:
		return ice_clear_phy_tstamp_e82x(hw, block, idx);
	case ICE_MAC_GENERIC_3K_E825:
		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
	default:
		return -EOPNOTSUPP;
	}
}

ice_ptp_flush_tx_tracker() ignores that return value, then clears in_use
and frees the skb anyway:

	if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
		ice_clear_phy_tstamp(hw, tx->block, phy_idx);

ice_ptp_reset_ts_memory(), ice_ptp_port_phy_stop() and
ice_ptp_port_phy_restart() also do nothing for E830.

So on E830, wouldn't an entry that becomes ready during the wait stay set
in E830_PRTMAC_TS_TX_MEM_VALID with no owner? That is the orphaned ready
bit state this patch is trying to prevent.

On the rebuild path the tracker stays initialized. For E830,
ice_ptp_ts_irq() re-arms PFINT_OICR whenever ice_ptp_tx_tstamps_pending()
sees a hardware ready bit.

Could such an orphan keep re-triggering the interrupt, or be picked up as
a stale timestamp by a later request that reuses the index?

The actual effect depends on two hardware details: whether E830 valid bits
clear only when the timestamp is read, and whether CORER resets the PRTMAC
timestamp memory. The E830 case is still missing from
ice_clear_phy_tstamp() at the end of the series.

> +
> +	err = read_poll_timeout(ice_ptp_is_tracker_drained,
> +				drained, drained, 500, 10 * USEC_PER_MSEC, false,
> +				pf, tx);

[Severity: Low]
Will this poll always run until its full 10 ms timeout on the post-reset
rebuild path?

This call chain reaches the poll for every port on the adapter, one port
after another:

ice_rebuild()->ice_ptp_rebuild()->ice_ptp_rebuild_owner()->
ice_ptp_flush_all_tx_tracker()->ice_ptp_flush_tx_tracker()

ice_reset_subtask() clears reset_ongoing before the rebuild:

		} else {
			/* done with reset. start rebuild */
			pf->hw.reset_ongoing = false;
			ice_rebuild(pf, reset_type);

So the reset_ongoing early return in ice_ptp_is_tracker_drained() does not
skip the poll.

A CORER/GLOBR/EMPR reset drops the Tx rings. A request whose packet was
dropped that way will never get a ready bit, so
ice_ptp_is_tracker_drained() keeps returning false. That costs about 20
rounds of SBQ ready-bitmap reads per port. On an 8-port adapter it adds
roughly 80 ms to reset recovery.

A Tx hang is a common reason for the reset, and it is also the case most
likely to leave such entries behind.

The wait also seems unnecessary there. Right after the flush,
ice_ptp_rebuild_owner() does:

	ice_ptp_flush_all_tx_tracker(pf);

	/* Enable quad interrupts */
	err = ice_ptp_cfg_phy_interrupt(pf, true, 1);

ice_ptp_cfg_phy_interrupt() calls ice_ptp_reset_ts_memory(), which resets
the E82x timestamp memory. On E825 ports with link up,
ice_ptp_restart_all_phy() then does a PHY soft reset.

Would it make sense to wait only on the release path? That is where new
requests are blocked and captures can still be in flight.

> +	if (err) {
> +		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
> +			tx->block);
> +	}
> +}
> +

[ ... ]

> @@ -760,6 +822,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>  	int err;
>  	u8 idx;
>  
> +	ice_ptp_wait_for_tracker_drain(pf, tx);
> +

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The new
drain only covers ice_ptp_flush_tx_tracker(). At this commit,
ice_ptp_process_tx_tstamp() can still create the same orphan when the link
goes down:

	bool drop_ts = !link_up;
	...
			if (drop_ts)
				goto skip_ts_read;

When a slot is not ready yet, this path clears in_use and frees the skb
without touching the PHY entry. If the capture finishes later, its ready
bit has no owner. That is the case the commit message describes.

The next patch in the series, "ice: keep Tx timestamp slots tracked until
completion or timeout", removes the link-down drop. After that patch, only
the 2 second timeout frees a slot that is not ready. That timeout is
intentional and is documented both in the ice_ptp_process_tx_tstamp()
kernel-doc and in that patch's commit message. So by the end of the series
this no longer applies.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
