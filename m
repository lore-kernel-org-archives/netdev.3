Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0703DC87A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846936; cv=none; b=L86GfbDBJ9cfrMTUY92HZI4+28zyWeJubk7Jd+vPVaHjkwzd0p5vnEqXiMF1ldKX6b1wzF2FYIHfurLCht6o3WbXp8jcUjbG0RF89B830LSyqYkWJ0g2aAKskUPlyvNkP27lMa3F0fBlbmN3Fh5ChTM/Xe3bUiytONvecffyPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846936; c=relaxed/simple;
	bh=ATthFz0YMtFORfmvFlFb3qox7o0EnrFhaT6vZhzGOxM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPJxj4BRY066lu/hvW3NmHh+iCbshzJKBlnT83AT+OCTmYaFI9NtwHCpDNFHzHJuHGWXYVNVFBRwGRijqzbrrrFCw3I7vB/GhnnxY/TYfSoZLq3tUGu9TD0MgSjTCSepXb3Ra8yyx9h2yxTDphAboCWxO2Qj4DvTjNlse0q6Wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLDjzTlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLDjzTlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990E51F008A1;
	Mon, 12 Oct 2026 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846934;
	bh=SUxm/LbvV1SyZyQ68Q5Bs4h9/iXYov9twPZ/ID/V3hQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MLDjzTlxbDmU+M9Ew1jBOB4K46BocDvEn1nNTz9iwqV1sUnMrLwGpfCmhvWzQBvs2
	 VIuYGJHP1wLyAU2MxpxcPKWfC91bLxFszhJgYiPtqB/MphYWzQLgdlRlNVkGhn1Ga0
	 QIvFSUK5jQdOeNtYv7LZTIGTbuEqMaYw94vPxuxJzXnujdwU7aMHSr0iZwqDhrk/HH
	 4Yuv1EtJDf26o+yAlYHYQdXbw3S3ZS6ESxWrA/UyUBhO3trKS1dyA9BbxkU8gS7Zqm
	 /yLgcxrZTLWVsMagIPlM+KI/J6VJ9J41/VgoTu+UGIbcSaojvhIWrfH3Nif1xho8VX
	 ATq1qAH1pvynQ==
Subject:
 Re: [PATCH net v2 14/15] ice: don't clear in_use until HW clears ready bitmap
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
Date: Mon, 12 Oct 2026 23:15:33 +0000
Message-ID: <179184693319.434549.15963891869718203802@kernel.org>
In-Reply-To: <20261008215614.1987250-15-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-15-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice: Tx timestamp SKB leak when PHY ready bit is stuck
- [High] net/ice: IRQ storm due to PHY read failure bypassing stale
  cleanup
- [Medium] ice_ptp_maybe_trigger_tx_interrupt()
  (drivers/net/ethernet/intel/ice/ice_ptp.c:2994-3002) now calls…
- [Medium] This patch removes the hardware ready-bitmap fallback from the
  IRQ-thread re-arm decision.
- [Medium] The patch now deliberately leaves a PHY Tx ready bit set while
  it keeps the index in_use and stale (ice_ptp.c:622-634), and it also…
- [Low] In ice_ptp_process_tx_tstamp() (ice_ptp.c:622-634), suppose
  ice_read_phy_tstamp() succeeds and the hardware clears the ready bit,…

--

ice: don't clear in_use until HW clears ready bitmap

After each PHY timestamp read, this patch re-reads the Tx timestamp ready
bitmap. If hardware did not clear the ready bit, the index stays locked and
is marked stale. The patch also removes the hardware ready bitmap check from
ice_ptp_tx_tstamps_pending(), stops the IRQ re-arm for trackers that are not
up, and moves the hardware check into the periodic watchdog.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 9dc0b5fa33198..8d302b500a399 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -626,6 +619,20 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  		if (err && !drop_ts)
>  			continue;
>  
> +		/* verify ready bit cleared */
> +		if (tx->has_ready_bitmap) {
> +			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> +			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
> +				spin_lock_irqsave(&tx->lock, flags);
> +				if (test_bit(idx, tx->in_use) &&
> +				    !test_and_set_bit(idx, tx->stale))
> +					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
> +						ptp_port->port_num, phy_idx);
> +				spin_unlock_irqrestore(&tx->lock, flags);
> +				continue;
> +			}
> +		}

[Severity: High]
The commit message says a failed ice_get_phy_tx_tstamp_ready() is
treated the same as a ready bit that didn't clear. That holds for
this re-read, but not for the first read at the top of
ice_ptp_process_tx_tstamp():

	if (tx->has_ready_bitmap) {
		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
		if (err)
			return;
	}

On that error the function returns before the loop. Nothing is
marked stale and the 2 second timeout is never checked.

With the link up, the tracker passes ice_ptp_is_tx_tracker_up(), and
bitmap_andnot(in_use, stale) is still non-empty. So
ice_misc_intr_thread_fn() sees ice_ptp_tx_tstamps_pending(pf, true)
return true and writes PFINT_OICR_TSYN_TX_M again right away.

If the sideband read keeps failing, doesn't this turn into the same
tight IRQ loop the patch is trying to remove? The pending skbs would
also never time out.

The early return was there before this patch. The new tracker-up
check only covers link down and calibrating, so it doesn't help in
this case.

Should the initial failure be handled like the re-read failure? For
example, the in_use entries could be marked stale while timed out
entries are still released. Note that tstamp_ready is uninitialized
on that path, so the loop can't simply fall through. Or is a
persistent read failure with the link up not expected to happen?

[Severity: High]
When the re-read still shows the ready bit set, this continue leaves
both the in_use bit and tx->tstamps[idx].skb in place. Is holding on
to the skb here intended?

Keeping the index locked makes sense. The problem is that the skb now
has no way out of the tracker while the PHY stays stuck, and the 2
second timeout no longer helps.

With the ready bit still set, a timed out entry doesn't take the goto
skip_ts_read branch. It reads the PHY again, fails this same check,
and hits this continue again. Before this patch the timeout path
always reached skip_ts_read and freed the skb.

ice_ptp_request_ts() stores a reference to the original skb taken
with skb_get(). The sending socket therefore stays charged in
sk_wmem_alloc for as long as the entry sits here.

The commit message says stuck indexes stay locked until the PHY is
reset on link up. As far as I can tell, if the link never comes back,
the skb is only freed by a reset or a driver unload. Until then the
owning socket can't be destroyed.

An unprivileged user in a container can request Tx timestamps. If
that happens around a link drop, the netns teardown could be left
hanging.

Could the skb be pulled out of tx->tstamps[idx] and freed (or
completed without a timestamp) under tx->lock once the timeout
expires? The in_use bit could still stay set so the index isn't
reused. Or is there another path that releases these skbs that I'm
missing?

[Severity: Low]
Suppose ice_read_phy_tstamp() succeeds and hardware clears the ready bit,
but this second ice_get_phy_tx_tstamp_ready() call hits a transient
sideband error. What happens then?

The index gets marked stale and stays in_use. On the next pass the ready
bit reads as clear, so ice_ptp_process_tx_tstamp() takes this earlier
branch:

		if (tx->has_ready_bitmap &&
		    !(tstamp_ready & BIT_ULL(phy_idx))) {
			if (drop_ts)
				goto skip_ts_read;

			continue;
		}

That branch never checks the stale bit. The slot seems to stay locked until
the 2 second timeout sets drop_ts. When it is finally released, timeout is
true and pf->ptp.tx_hwtstamp_timeouts gets incremented.

Would this count a PHY access error as a Tx timestamp timeout, and hold the
slot for up to 2 seconds?

The commit message says transient errors mark packets stale. It doesn't
mention the 2 second hold or the timeout being counted.

> +
>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);

[ ... ]

> @@ -2837,10 +2847,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>  		if (!tx->init)
>  			return false;
>  
> -		if (in_irq)
> +		if (in_irq) {
> +			if (!ice_ptp_is_tx_tracker_up(tx))
> +				return false;
> +
>  			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);

[Severity: Medium]
The verify path in ice_ptp_process_tx_tstamp() now leaves a ready bit set
while the index stays in_use and stale. Can a stuck index on one port delay
Tx timestamps for healthy ports that share the same interrupt source?

The comment above ice_ptp_maybe_trigger_tx_interrupt() says:

 * timestamp data from the PHY. It will not interrupt again until all
 * current timestamp data is read.

An earlier commit in this series also says an unread ready bit means
delivery for the whole quad degrades to the periodic work.

On E82x, the timestamp interrupt enable and threshold are per quad. See the
single Q_REG_TX_MEM_GBL_CFG in ice_phy_cfg_intr_e82x(). On E825, the TSYN_TX
causes for all ports go to the clock owner in ICE_PTP_TX_INTERRUPT_ALL mode.

Before this patch, the hardware check in the IRQ re-arm path caused the
storm, but it also kept serving the other ports in the quad within
microseconds.

The in_irq branch now looks only at software state. Would new timestamps on
healthy ports then be handled only when ice_ptp_periodic_work() writes
PFINT_OICR every 500 ms?

On E825, ice_ptp_link_change() only restarts the PHY on link up, so this
could last as long as the bad port's link stays down. The latency numbers in
the commit message only cover healthy links.

> -		else
> +		} else {
>  			return !bitmap_empty(tx->in_use, tx->len);
> +		}
>  	}
>  }
>  
> @@ -2872,41 +2886,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
>  
>  bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>  {

[ ... ]

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
Removing this hardware fallback also affects the in_irq callers:
ice_misc_intr_thread_fn() and the E830 top half in ice_ptp_ts_irq(). Can a
stale index on a tracker that is up miss its re-arm?

Stale entries can exist while the tracker and link are both up, for example
after a PHC settime/adjtime:

ice_ptp_reset_cached_phctime() {
    ...
	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
}

Such a stale index might become ready after ice_ptp_process_tx_tstamp() has
already passed it in the loop, or after the last refresh of tstamp_ready.
If so, it isn't read in that pass. Then ice_misc_intr_thread_fn() runs:

	if (ice_ptp_tx_tstamps_pending(pf, true)) {
		...
		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

The software check is now bitmap_andnot(in_use, stale), which is empty, so
no re-arm happens. Before this patch, ice_check_phy_tx_tstamp_ready() would
have seen the ready bit and re-armed.

An earlier commit in this series says the PHY doesn't raise another Tx
timestamp interrupt until every outstanding ready bit is read. If that
holds, would new non-stale timestamps then wait for ice_ptp_periodic_work()
(500 ms)? That is well past ptp4l's default 10 ms tx_timestamp_timeout.

The commit message justifies dropping the hardware check for trackers that
are calibrating or link down. It doesn't cover trackers that are up and have
stale entries whose ready bits are set.

[ ... ]

> @@ -2999,7 +2991,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  	    !ice_pf_src_tmr_owned(pf))
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

[Severity: Medium]
Does this early return change when the watchdog kicks the interrupt?

Before this patch, ice_ptp_tx_tstamps_pending(pf, false) checked the
software in_use bitmap first. It only read the PHY when nothing was pending
in software.

Now a PHY read error returns before the software check runs. In that case
PFINT_OICR_TSYN_TX_M is not written, even if in_use has entries.

ice_check_phy_tx_tstamp_ready_eth56g() returns the first error from any
port, and ice_check_phy_tx_tstamp_ready_e82x() does the same over quads:

	for (port = 0; port < hw->ptp.num_lports; port++) {
		...
		err = ice_get_phy_tx_tstamp_ready(hw, port, &tstamp_ready);
		if (err)
			return err;

In ICE_PTP_TX_INTERRUPT_ALL mode, one port or quad with a failing status
read would then stop the watchdog kick for every port.

After this patch, the in_irq path skips stale entries and trackers that are
down. The 2 second timeout is only checked inside
ice_ptp_process_tx_tstamp().

While the read keeps failing, would those in_use entries and their skbs stay
unreleased until a real PHY interrupt arrives?

Would it make sense to check the software tracker first, or to ignore the
PHY error when in_use is not empty? The commit message says the watchdog
continues to check the hardware bitmap. It doesn't mention this change in
ordering.

>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>  
>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
