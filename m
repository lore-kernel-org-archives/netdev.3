Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203383E49C1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846934; cv=none; b=rVIG3oNM1yHkm27zaQ4qx7wuowuFzvh22c4pONFHd+Qju1/3fN17WkaSti0P7AP2/fGMprvk4+1wtBMiuc+TLzk/Mpw5hCQXooaJn3yqR+QmDE3EhtJpXIV6hNEo+dM6E693aXflutJ4IGnCIQ/FNUsozeujpwrjZAaCyX7HWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846934; c=relaxed/simple;
	bh=zgI4Z9giVCK7AfyfVzQm6ga+lGSVPkYWeXTRb/h3ZEs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1pR6raQUoVThKgxbhRAOjbainjP9GhgwxhK+h8E+gT9e4ZfUz8h6h9EsbwJBr1z4AO5zuozf5ElS+YGJhpoPuiiW7zqJenA60pme2HyZ8yb9qVMtgGF1tJti5lL7jBWmVz0v9wZKRp78RgxR8TFyU1s/fo/S1XeqYpHATV8lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laWJjIG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laWJjIG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF1F1F008A2;
	Mon, 12 Oct 2026 23:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846933;
	bh=4sEtCAQeJ2dr5uf/SkYfnqj7r5bOcI1qKRM2kO8RmHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=laWJjIG6PY/5LuvlkJC96dei9UfVqVDC1D2TGz1lord2f4lwn+DdBUw4uKy3S281R
	 CeZmuDxZWOBzs2XTiJdUfRVdm79HjpLJp6UY78JGB7ZQxaXet1Et7w2Hef4ZZsODn7
	 DfYvP+OlHtwp6XC78cuaevXxOEYLLcfr/D7SzuZRpqTQtn32YcWEUI3QZzi7OBIZrC
	 JcueM65gct5ycqHat20z13g4MVsyvA921qpdNcgYYeTjWJsT78Ka0y64RvDCGZf057
	 heyaZj0F97TSbQgyGa9ezTXwbJyTrpbH+FbUmhxAt7/TGNAZqOCoH1lgyYekqt1UMI
	 0EO9gUbaBvlvw==
Subject: Re: [PATCH net v2 12/15] ice: keep Tx timestamp slots tracked until
 completion or timeout
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
Date: Mon, 12 Oct 2026 23:15:31 +0000
Message-ID: <179184693169.434549.6103061809341882810@kernel.org>
In-Reply-To: <20261008215614.1987250-13-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-13-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds a sentence to the ice_ptp_process_tx_tstamp()
  kernel-doc: "in the unusual case where the PHY continuously fails to…
- [Low] The ice_ptp_maybe_trigger_tx_interrupt() kernel-doc still says
  the function will "periodically check if the PHY has outstanding…

Pre-existing issues:
- [Medium] ice_ptp_init() sets link_up from port_info under ps_lock but
  sets ptp->state = ICE_PTP_READY only after dropping the lock.
- [Low] Because the has_ready_bitmap gate is removed from
  ice_ptp_maybe_trigger_tx_interrupt(), the periodic worker on non-LL…

--

ice: keep Tx timestamp slots tracked until completion or timeout

When the link goes down, outstanding Tx timestamp requests are no longer
dropped. They are marked stale instead, new requests are rejected while
the link is down, and a slot that is not ready yet is freed only after the
two second timeout. The patch also changes ice_ptp_tx_tstamps_pending() so
stale entries are ignored when deciding whether to re-arm the IRQ, and lets
ice_ptp_maybe_trigger_tx_interrupt() run on devices that handle their own
Tx interrupt.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 5220de274819a..a5ee8c8edf3d6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -554,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
>   * extremely unlikely that a packet will ever take this long to timestamp. If
>   * we detect a Tx timestamp request that has waited for this long we assume
>   * the packet will never be sent by hardware and discard it without reading
> - * the timestamp register.
> + * the timestamp register. Note that in the unusual case where the PHY
> + * continuously fails to clear the ready bitmap index, the slot may remained
> + * locked for more than two seconds.
>   */
>  static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  {

[Severity: Low]
Does this new comment describe what the code does at this commit?

In ice_ptp_process_tx_tstamp(), nothing re-reads the PHY ready bitmap
after ice_read_phy_tstamp() and before the slot is released:

	err = ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);
	if (err && !drop_ts)
		continue;
	...
skip_ts_read:
	...
	clear_bit(idx, tx->in_use);

Suppose the PHY does not clear the ready bit, for example for an entry
with VALID clear that was captured while P_REG_TX_OR=0. Then the index is
freed and the skb released, which leaves a set ready bit with no in_use
owner. The slot does not stay locked.

At this commit ice_ptp_tx_tstamps_pending(pf, true) still falls back to
the hardware check:

	/* Check hardware indicator */
	ret = ice_check_phy_tx_tstamp_ready(hw);

That would re-arm PFINT_OICR_TSYN_TX for a bit the processing loop never
visits.

A later patch in this series, "ice: don't clear in_use until HW clears
ready bitmap", adds the "verify ready bit cleared" re-read. That re-read
keeps the index in_use and marks it stale. The same patch also removes the
hardware fallback from ice_ptp_tx_tstamps_pending(). After the full series
the comment matches the code.

Could this comment move into that later patch so each commit is consistent
on its own?

[ ... ]

> @@ -1426,6 +1428,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  
>  	WRITE_ONCE(ptp_port->link_up, linkup);
>  
> +	if (!linkup)
> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> +
>  	/* Skip HW writes if reset is in progress */
>  	if (pf->hw.reset_ongoing)
>  		goto out_unlock;

[Severity: Medium]
This is a pre-existing issue and this patch did not introduce it. This
patch does make link_up more important, though.

ice_ptp_init() seeds link_up while holding ps_lock, but it publishes
ICE_PTP_READY only after dropping the lock:

ice_ptp_init() {
    ...
	mutex_lock(&pf->adapter->ps_lock);
	if (pf->hw.port_info)
		WRITE_ONCE(ptp->port.link_up, ...);
	ice_ptp_port_phy_restart(&ptp->port);
	mutex_unlock(&pf->adapter->ps_lock);
	ice_ptp_cfg_tx_interrupt(pf);
	ptp->state = ICE_PTP_READY;
    ...
}

ice_ptp_link_change() checks the state without holding the lock:

	if (pf->ptp.state != ICE_PTP_READY)
		return;

ice_init() starts the service timer, and the netdev is registered before
ice_init_features()->ice_ptp_init() runs, so link events can arrive during
this window. Any link event in that window is dropped.

With this patch, ice_ptp_is_tx_tracker_up() and the link-down stale marking
both depend on link_up. A stale link_up=false now means every new request
is rejected until the next link flap. The race itself came from the
earlier commit "ice: call PTP link change only from link events".

Should ptp->state be set while ps_lock is held, or should link_up be
re-seeded after the state becomes ICE_PTP_READY?

[ ... ]

> @@ -2984,19 +2990,16 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  {
>  	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw *hw = &pf->hw;
> -	int ret;
>  
> -	if (!pf->ptp.port.tx.has_ready_bitmap)
> +	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
> +	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
>  		return;
>  

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. It is
a kernel-doc wording problem.

With the has_ready_bitmap gate gone, the periodic worker on non-LL E810
now reaches ice_check_phy_tx_tstamp_ready_e810(). At this commit it gets
there through ice_ptp_tx_tstamps_pending(). Later in the series it calls
it directly. The kernel-doc of that helper says it "should not be called
for E810 hardware", but the body is only:

static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
{
	return 0;
}

ice_misc_intr_thread_fn() already reached it on E810 before this patch,
so nothing changes at runtime.

Should that kernel-doc be updated, now that this is a regular call path?

> -	if (!ice_pf_src_tmr_owned(pf))
> +	if (pf->ptp.tx_interrupt_mode != ICE_PTP_TX_INTERRUPT_SELF &&
> +	    !ice_pf_src_tmr_owned(pf))
>  		return;
>  
> -	ret = ice_check_phy_tx_tstamp_ready(hw);
> -	if (ret < 0) {
> -		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
> -			ret);
> -	} else if (ret) {
> +	if (ice_ptp_tx_tstamps_pending(pf, false)) {
>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>  
>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

[Severity: Low]
Should the kernel-doc of ice_ptp_maybe_trigger_tx_interrupt() be updated
to match the new trigger condition? It still says:

 * To avoid getting permanently stuck, periodically check if the PHY has
 * outstanding timestamp data. If so, trigger an interrupt from software to
 * process this data.

With in_irq=false, ice_port_has_timestamps() returns:

	return !bitmap_empty(tx->in_use, tx->len);

That is true for any outstanding software request, including stale
requests and requests the PHY has not captured yet. So the interrupt now
fires on every 500 msec tick even when the PHY has no data. The commit
message describes this ("one extra IRQ every 500 msec until the timeout"),
but the function comment was not updated.

At the end of the series the condition is
"ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)" and the comment text is
the same, so the mismatch remains.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
