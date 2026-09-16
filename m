Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5C38E8B4
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521147; cv=none; b=ne+otOnqwMkZ9l/syJre6rARc+gPA/6FxKD3f+3SeXVNE+ah1cIMPE2jCq39g/ECGZ0yVPKXC/4EHgrZLKZoQT3lddtFhXGSqP4aMUNPq7bv3oLedv0fNWXgLN/ElV4+3pP79kuPBDgwTvCIPp9tE2Wk4euODILQQV/lpY93apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521147; c=relaxed/simple;
	bh=pQ5JmXQe1X0VHbFP/t69LIMbkbJRF+vcxPvoe6kxpXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEpgK+tDkPvUEicLBqWPT7mB7Co8AkdGlieOCmpQMmDDFPG2UdFu+CwrkTTTOGemqRLcuQWbgPChqzcgevwbjhld5Asfqv/ROuLj5IQqvkzKSfrT2vpvK3+dViXg4gh/ihVh7TOLtbPwNKW5kmxGApfqAWTSRggLm62CIlFjb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSGutcpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSGutcpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390941F00893;
	Wed, 16 Sep 2026 01:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521145;
	bh=QjKk9t5Fp3cboJuaUfKBeFxh8bnhF4E4yZlhqDiKJ8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSGutcpXq9C39pnRKp3q+XG8/lihnqnQ3tUd7s0so7cacsdaHlHHFNDJdlN1N3ams
	 igpq0JV2PZ+wyXT4P9hvcWKM0P66aI+ArCHo0BqjDSXVrEXeb3D5wEDNR/M4+LZ6IF
	 kQ+DRTBYlmefs/AIAW5V6t+V7aCXexwtwm4/ddh6gG3yfYUO45BG/ZgDI+pH96EwSf
	 kU4ggeuAl7Bg8Pnob8AYUAS4eduPDxRs9F/sJ73QccCwxMFATmG8Ry9e72rB7PW9H3
	 /gIBAJ2S1YBrujN7vG57bQeAe3HWuMC8PUszjOQx8gJPp1EPF4557wMxsTLM6spaGC
	 cM82rqfolk9hw==
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
Subject: Re: [PATCH net 11/15] ice: keep Tx timestamp slots tracked until completion or timeout
Date: Tue, 15 Sep 2026 18:12:24 -0700
Message-ID: <20260916011224.1632730-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-12-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-12-anthony.l.nguyen@intel.com>
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
ice: keep Tx timestamp slots tracked until completion or timeout

Instead of dropping every outstanding Tx timestamp request when the link
goes down, the outstanding requests are marked stale, new requests are
rejected while the link is down, and a not yet ready slot is only released
by the two second timeout in ice_ptp_process_tx_tstamp().
ice_ptp_tx_tstamps_pending() gains an in_irq argument so the interrupt
re-arm path ignores stale slots while the periodic worker still sees them.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index f32041dd8b274..d12952171a991 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3248,7 +3248,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
>  	ice_irq_dynamic_ena(hw, NULL, NULL);
>  	ice_flush(hw);
>  
> -	if (ice_ptp_tx_tstamps_pending(pf)) {
> +	if (ice_ptp_tx_tstamps_pending(pf, true)) {
>  		/* If any new Tx timestamps happened while in interrupt,
>  		 * re-arm the interrupt to trigger it again.
>  		 */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b142b779dc105..299de9d494233 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -364,9 +364,12 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
>  static bool
>  ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
>  {
> +	struct ice_ptp_port *ptp_port =
> +		container_of(tx, struct ice_ptp_port, tx);
> +
>  	lockdep_assert_held(&tx->lock);
>  
> -	return tx->init && !tx->calibrating;
> +	return tx->init && !tx->calibrating && ptp_port->link_up;
>  }

[Severity: Medium]
With link_up now part of the tracker-up test, is the E825 PHY restart path
still covered?

ice_ptp_link_change() sets ptp_port->link_up = true before it reaches
ice_ptp_port_phy_restart(), and for ICE_MAC_GENERIC_3K_E825 that function
calls ice_start_phy_timer_eth56g() without setting tx.calibrating:

	case ICE_MAC_GENERIC:
		...
		ptp_port->tx.calibrating = true;
		...
	case ICE_MAC_GENERIC_3K_E825:
		err = ice_start_phy_timer_eth56g(hw, port);
		break;

So during the E825 restart ice_ptp_is_tx_tracker_up() returns true
(tx->init && !tx->calibrating && ptp_port->link_up), and
ice_ptp_request_ts() keeps handing out indices while
ice_start_phy_timer_eth56g() walks the Tx timestamp memory and soft resets
the PHY.

The window is also reachable while the carrier stays up: ice_link_event()
continues past

	if (link_up == old_link && link_speed == old_link_speed)
		return 0;

on a speed-only change and calls ice_ptp_link_change(pf, link_up) while the
netdev is transmitting.

Are the captures requested in that window simply lost until the two second
timeout, and should tx.calibrating be set around the E825 restart as it is
for the E82X case?

> @@ -563,7 +566,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  	struct ice_pf *pf;
>  	struct ice_hw *hw;
>  	u64 tstamp_ready;
> -	bool link_up;
>  	int err;
>  	u8 idx;
>  
> @@ -581,14 +583,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  			return;
>  	}
>  
> -	/* Drop packets if the link went down */
> -	link_up = ptp_port->link_up;
> -
>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>  		struct skb_shared_hwtstamps shhwtstamps = {};
>  		u8 phy_idx = idx + tx->offset;
>  		u64 raw_tstamp = 0, tstamp;
> -		bool drop_ts = !link_up;
> +		bool drop_ts = false;
>  		struct sk_buff *skb;
>  
>  		/* Drop packets which have waited for more than 2 seconds */
> @@ -1371,6 +1370,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	if (pf->hw.reset_ongoing)
>  		goto exit_kref_put;
>  
> +	if (!linkup)
> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> +

[Severity: High]
Who runs the processing pass that applies the two second timeout on E810,
and on PFs that are not the source timer owner?

After this hunk the stale slots are only released from inside
ice_ptp_process_tx_tstamp(), by

		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
			drop_ts = true;

which requires something to schedule another pass. The candidates all look
closed on those configurations:

ice_misc_intr_thread_fn() re-arm now passes in_irq = true, and
ice_port_has_timestamps(tx, true) returns
bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len), which is 0 for an
all-stale tracker. The hardware fall-through in
ice_ptp_tx_tstamps_pending() does not help on E810 either, since
ice_check_phy_tx_tstamp_ready_e810() is:

	static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
	{
		return 0;
	}

The replacement periodic sweep is not reached on those devices, see the
early returns in ice_ptp_maybe_trigger_tx_interrupt() quoted in the last
hunk below.

No hardware TSYN_TX interrupt can arrive either, because the packets whose
captures are outstanding were not transmitted, and
ice_ptp_is_tx_tracker_up() now rejects new requests while link_up is false.

Does this mean the index and the skb reference taken in
ice_ptp_request_ts() by

		tx->tstamps[idx].skb = skb_get(skb);
		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

stay held for the entire link-down period?

There is a second effect worth checking. Requests are still accepted
between the physical link loss and the firmware link event, so the tracker
can fill up (tx->len is INDEX_PER_PORT, 64, on E810). If every index is
in_use and stale, does ice_ptp_request_ts() then return -1 for every packet
after link-up, so no timestamp is requested, no TSYN_TX interrupt is
generated, no processing pass ever runs, and Tx timestamping for that port
stays dead until a PF reset or driver reload? ice_ptp_flush_tx_tracker() is
only reached from ice_ptp_release_tx_tracker() and the clock-owner rebuild
path, and ice_ptp_link_change() returns early for E810 and E830 without
flushing.

For reference, the E810 low latency read sub-path does not appear affected:
ice_ll_ts_intr() -> ice_ptp_req_tx_single_tstamp() keeps walking in_use on
every LL_TS interrupt, so the timeout still fires there.

>  	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
>  	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
>  		int pin, err;

[ ... ]

> @@ -2767,28 +2769,29 @@ void ice_ptp_process_ts(struct ice_pf *pf)
>  	}
>  }
>  
> -static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
> +static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>  {
> -	bool more_timestamps;
> +	DECLARE_BITMAP(tstamps, INDEX_PER_PORT_MAX) = {};
>  
>  	scoped_guard(spinlock_irqsave, &tx->lock) {
>  		if (!tx->init)
>  			return false;
>  
> -		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
> +		if (in_irq)
> +			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
> +		else
> +			return !bitmap_empty(tx->in_use, tx->len);
>  	}
> -
> -	return more_timestamps;
>  }

[ ... ]

> -bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
> +bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>  {
>  	struct ice_hw *hw = &pf->hw;
>  	int ret;
> @@ -2808,11 +2811,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>  	case ICE_PTP_TX_INTERRUPT_NONE:
>  		return false;
>  	case ICE_PTP_TX_INTERRUPT_SELF:
> -		if (ice_port_has_timestamps(&pf->ptp.port.tx))
> +		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
>  			return true;
>  		break;
>  	case ICE_PTP_TX_INTERRUPT_ALL:
> -		if (ice_any_port_has_timestamps(pf))
> +		if (ice_any_port_has_timestamps(pf, in_irq))
>  			return true;
>  		break;
>  	default:

[Severity: Low]
This is a pre-existing issue and is not introduced by this patch, and on
closer reading it looks like a non-issue here, but it is worth noting for
completeness.

The commit message says the in_irq filtering avoids an IRQ storm, while
after the switch above ice_ptp_tx_tstamps_pending() still falls through to
the unconditional hardware check:

	/* Check hardware indicator */
	ret = ice_check_phy_tx_tstamp_ready(hw);

A PHY ready bit with no in_use owner would therefore still make
ice_misc_intr_thread_fn() and the ICE_MAC_E830 branch of ice_ptp_ts_irq()
re-arm PFINT_OICR(TSYN_TX) regardless of in_irq. Such an unowned ready bit
can be produced by the timeout path in ice_ptp_process_tx_tstamp(), which
clears in_use without reading or clearing the PHY slot:

		if (tx->has_ready_bitmap &&
		    !(tstamp_ready & BIT_ULL(phy_idx))) {
			if (drop_ts)
				goto skip_ts_read;

That release-without-read is unchanged from before this patch and is
described as intentional in the ice_ptp_process_tx_tstamp() kernel-doc. For
the case the commit message actually describes, a stale packet that is
never timestamped, no ready bit is ever set, so the hardware check returns
0 and the stated goal holds. The remaining hardware check is also removed
later in this series by "ice: don't clear in_use until HW clears ready
bitmap", which makes ice_ptp_tx_tstamps_pending() consult only the software
tracker.

> @@ -2918,7 +2921,6 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  {
>  	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw *hw = &pf->hw;
> -	int ret;
>  
>  	if (!pf->ptp.port.tx.has_ready_bitmap)
>  		return;
> @@ -2926,11 +2928,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  	if (!ice_pf_src_tmr_owned(pf))
>  		return;
>  
> -	ret = ice_check_phy_tx_tstamp_ready(hw);
> -	if (ret < 0) {
> -		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
> -			ret);
> -	} else if (ret) {
> +	if (ice_ptp_tx_tstamps_pending(pf, false)) {

[Severity: High]
Is the new in_irq = false check reachable on the devices that need it?

ice_ptp_init_tx() sets:

	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;

so the first early return above skips every E810 PF, and the
ice_pf_src_tmr_owned() return skips PFs that are not the source timer
owner, including ICE_PTP_TX_INTERRUPT_SELF PFs on E830. Combined with the
suppressed re-arm in ice_misc_intr_thread_fn(), does anything on those
devices ever call ice_ptp_process_tx_tstamp() again so the two second
timeout can release the stale slots?

Would moving the ice_ptp_tx_tstamps_pending(pf, false) check ahead of the
has_ready_bitmap and ice_pf_src_tmr_owned() early returns give the
software tracker a guaranteed sweep on all configurations?
