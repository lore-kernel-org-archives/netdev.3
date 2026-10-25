Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971848;
	b=n+LUkndsQ1Nb9UEJryv0aEATd+3MS+ZCVuj3sQXK6Pn5oTEyrSAzocJle/AZROrtgmoK
	 wZloBHdkdNeHqZg9q+6tNBaa0j98Dmi+4Q55sC+EwVy82kqQdqx9a58DFFYOMTnARDVnZ
	 hvhX3aMZVz2Evu7PszGDAf56NN5oX3nQSuuvgDiOpsFc9YozifCrzSDYD4lr72q9C+Vk7
	 Ldp7Z6qtZEUIKK8LsVDIZcz/kjRIADZvscaahsORigG/CSytSbEG4ZhhP/Gm+3Un4tyIZ
	 7NR5Ub7iFVJI2Zl7jAgQs7fbzORcmRTOwSu8GViyOeLfcXJ3tAIkYekVexDCxck+u9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971848;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dkdyOJYUkFmroPEHrw/gyaMaLpI/HNgMU0ErK4AO+jY=;
	b=kTunZNP3l0riEc/dkBVWTUvtDHbvs/P7bpsQuEFAU5VrL2/2OLz2jdnwKVMGcO8TPFDH
	 WIebVzJZ/PjwcypQ/pUXeNubWxeuG3+l6aPQ7puJVz9kxHHtBEQjAf2KoQtoauuwOoAm1
	 NKHf1rxLIbGLhZlM6pl+Z2vc9+XTALO5IlRrf8u9iej4zOt+Q5BsZDmpgTwuHvwGhyQcg
	 dgxtBMc0EqdZuML3/e2pEK0VE9rExGTQk21wcSUUZVruZZ/DOT0J4f4ffgVptF/+1GqFV
	 I0LsTMTX7lNMN47JzxNpf0kCquqa1vuu8CXV6hai2VkhtiSolQBg3ruGWhbFGo1K0XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A58ZRBWY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86384606A324
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A58ZRBWY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630641F01828;
	Sun, 25 Oct 2026 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971848;
	bh=dkdyOJYUkFmroPEHrw/gyaMaLpI/HNgMU0ErK4AO+jY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A58ZRBWYP1vRleH1RyYweUDDuuS8hfD8F3MXzXtjQpGfPm7CS3VyM9DP9c6R/xuUv
	 uXjCzI8aPYZbioPfBZLhwO4gxU3zbbu4ysf1QDvKbws8q2D2loMQpp9TvUoJ5yPYm4
	 92AfUgdx0Wis0RX7ZCo4YLy2I6771QnUgEYmF3ki7136/i8zxTEuGgdxGPjEfVtDlt
	 7c+Ppt9vSIxTEJyNWFX4WRttM8WACrAor+QylQ+MdD/xd/6wdm65XwP+hg/RqsS8NK
	 j1+wmjYA3IE/iBCjMZvpaTC19ts6zkPaEqp+RPl6TatS21STweXp3Gu0PMQ5Xzj56f
	 N1xaCb46PqEEw==
Subject:
 Re: [PATCH net v5 13/13] ice: don't clear in_use until HW clears ready bitmap
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:44:06 +0000
Message-ID: <179297184695.3134.4758101348262867336@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-13-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-13-72289a4ac8eb=40intel=2Ecom=3E?=
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch removes the hardware ready-bitmap check
  (ice_check_phy_tx_tstamp_ready()) from ice_ptp_tx_tstamps_pending().
- [Low] The kernel-doc of ice_ptp_process_tx_tstamp() (ice_ptp.c:514-562)
  no longer matches the code.

--

ice: don't clear in_use until HW clears ready bitmap

After each PHY timestamp read, this patch re-reads the Tx timestamp ready
bitmap. If the index's ready bit has not cleared, the index is marked
stale and kept locked, and its SKB is freed. The patch also drops the
hardware ready bitmap check from the in-IRQ re-arm decision. That check
now runs only from the periodic watchdog.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b0ea01cfcc4f..c0d056896825 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -557,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
>   * extremely unlikely that a packet will ever take this long to timestamp. If
>   * we detect a Tx timestamp request that has waited for this long we assume
>   * the packet will never be sent by hardware and discard it without reading
> - * the timestamp register.
> + * the timestamp register. Note that in the unusual case where the PHY
> + * continuously fails to clear the ready bitmap index, the slot may remain
> + * locked for more than two seconds.
>   */
>  static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  {

[Severity: Low]
Is the rest of this kernel-doc still accurate after this change? The
numbered list earlier in the same comment still says:

 * 3) read and copy the timestamp out of the PHY register
 * 4) unlock the index by clearing the associated in_use bit
 * 5) check if the timestamp is stale, and discard if so

Look at the new "verify ready bit cleared" block in
ice_ptp_process_tx_tstamp(). If the ready bit is still set after the read,
or the re-read of the ready bitmap fails, the index is marked stale and
the SKB is freed. in_use stays set, so step 4 never happens.

The opening line, "loop over each index with a waiting skb", is also no
longer true. in_use slots with a NULL skb are now visited on every pass
until the hardware clears the bit.

This paragraph also still says timed-out requests are discarded "without
reading the timestamp register". A timed-out index whose ready bit is set
is still read through ice_read_phy_tstamp(), and with this patch it can
stay locked.

Could the kernel-doc be updated to describe the new flow?

[ ... ]

> @@ -2766,10 +2787,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
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
> @@ -2801,41 +2826,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
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

[Severity: Medium]
Can removing this hardware fallback leave the PHY Tx timestamp interrupt
blocked until the watchdog runs?

ice_misc_intr_thread_fn() and the E830 path in ice_ptp_ts_irq() call
ice_ptp_tx_tstamps_pending(pf, true) to decide whether to re-arm:

drivers/net/ethernet/intel/ice/ice_main.c:ice_misc_intr_thread_fn() {
    ...
	if (ice_ptp_tx_tstamps_pending(pf, true)) {
		/* If any new Tx timestamps happened while in interrupt,
		 * re-arm the interrupt to trigger it again.
		 */
		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
		ice_flush(hw);
	}
    ...
}

This change, combined with the new ice_ptp_is_tx_tracker_up() check in
ice_port_has_timestamps(), means the re-arm only looks at non-stale
in_use slots on trackers that are up.

The kernel-doc of ice_ptp_maybe_trigger_tx_interrupt() says the PHY "will
not interrupt again until all current timestamp data is read". So if a
ready entry is still unread at the end of an IRQ pass, nothing
retriggers the interrupt. It stays blocked until the 500 ms watchdog,
ice_ptp_periodic_work()->ice_ptp_maybe_trigger_tx_interrupt(), runs.

A few ways such an entry can be left behind:

 - a stale request whose timestamp lands mid-pass, after the ready
   bitmap was read
 - a late completion on a port that is link down, or (on E82x) in
   Vernier calibration with tx.disabled set until
   ice_ptp_wait_for_offsets() succeeds
 - an index this patch keeps locked on purpose because its ready bit
   did not clear

Before this patch, the in-IRQ ice_check_phy_tx_tstamp_ready() call
retriggered the interrupt right away and drained these entries.

On E82x, timestamp memory and the interrupt are per quad (see
ice_phy_cfg_intr_e82x() and the quad split in ice_ptp_init_tx_e82x()).
In ICE_PTP_TX_INTERRUPT_ALL mode the clock owner services every port.

Could one leftover entry on a port that is going down or calibrating
then delay Tx timestamps for healthy link-up ports in the same quad by
up to about 500 ms? That is far beyond the 10 ms ptp4l default the
commit message cites. The race window looks narrow, but link flaps and
E82x recalibration happen in normal operation.

The commit "ice: keep Tx timestamp slots tracked until completion or
timeout" in this series also says an orphaned ready bit "blocks the
port interrupt".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
