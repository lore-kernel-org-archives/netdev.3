Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190F3DC87A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846931; cv=none; b=DF9hUZiOapAwMit9NoSP9qEBa5WAJED2CXWDIKCGP1YSZ5WeiB2E/ceLz2oqf+Vo0ueZUcCbw858xOhG4U2i+6+lz+QnSkfNSpbxmNjKJM64QfpapS4eYkKZMs8irG8pav9PXKgBXh5PpNiHvFQXSWJWQ7oPpg3+Iie1HYsK4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846931; c=relaxed/simple;
	bh=AymXMQmt+3em8zDOFYZJhTL3YBpqKBUgiFhs5BH0asw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2P+TcKO84lLPw4QI02tlMChIMGVXxTy/ryOOlioc5Uh2lJZQ0e4gKQzMhUq0xCVdWh3f2RfJcxORW+v+tTg+V7MbzBBOUsfuTbtkauQEt1TCDOKh4jGLky/HXiUGdmK/cmRq3GQLotyWes0wW7x+h9y7bGSbmIWtSLnCORri6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy9v7uRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy9v7uRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1760E1F008A2;
	Mon, 12 Oct 2026 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846930;
	bh=jkhPWV2GXNaFsqIDa1OHO/6ewuL3a7PJfwVTq1ubvfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iy9v7uRpMlGF3Uc/lw76o20J8C4POQK6uToY8ue9TVU9/mf7d3peS7hf/WAKzo50c
	 /RAq7LvAwVy3WUMbRcUFJU415EOG3+BKDF2x0OT5Hkh8bhUmj7eUbyW152ylf2pTfy
	 oSLBbo2oIZ3uxKtVR8SkrFdSdLEQPgc8IXfDOy3mQQASkhu7vBQSFiWkf11i91SV14
	 jJpbPSj6Ver2LMS3Saz+PqJf/P3jEuFskXmA2nhcORPnHZrovTNzQapidfWX/MOH6Q
	 FIiT2Ak4c3X7SDoPkY0JH/ynH1YW4AgNg8tKHKrMU0UKwlUrc7Huxn1cdNoHKYK3Kq
	 sFKqWip0vjmtg==
Subject: Re: [PATCH net v2 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
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
Date: Mon, 12 Oct 2026 23:15:28 +0000
Message-ID: <179184692867.434549.17457545223529058481@kernel.org>
In-Reply-To: <20261008215614.1987250-11-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-11-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a call to ice_ptp_phy_soft_reset_eth56g() in
  ice_start_phy_timer_eth56g() (ice_ptp_hw.c:2155), so every runtime…
- [Medium] The patch runs the sweep plus soft reset on the live restart
  path (link-up, rebuild, and at the end of the series settime64) but…
- [Medium] The runtime sweep and soft reset added by this patch are not
  synchronized with the Tx timestamp consumer.
- [Low] ice_ptp_clear_tx_memory_status_eth56g() returns void.

--

ice: E825: perform a soft reset when starting the PHY timer

This commit makes ice_start_phy_timer_eth56g() call
ice_ptp_phy_soft_reset_eth56g() right after the PHY timer is stopped.
The E825 PHY timer block is now soft reset, and its Tx timestamp memory
swept, before the PHY is reprogrammed. ice_start_phy_timer_eth56g() is
used by the runtime restart paths, so the sweep and reset now also run on
live ports.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index e83ad2bb8d420..e5bfede904314 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>  	if (err)
>  		return err;
>  
> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> +	if (err)
> +		return err;
> +

[Severity: Medium]
Does this discard Tx timestamps that the software tracker still treats as
outstanding?

ice_ptp_phy_soft_reset_eth56g() starts by calling
ice_ptp_clear_tx_memory_status_eth56g(). That function reads all
INDEX_PER_PORT entries, which clears every valid/ready bit on the port.

On the E825 branch of ice_ptp_port_phy_restart(), the tracker is only
marked stale before this runs:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
    ...
		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

		err = ice_start_phy_timer_eth56g(hw, port);
    ...
}

So outstanding entries keep their in_use bit and their skb reference.

Suppose hardware has captured a timestamp, but the IRQ thread has not
consumed it when the sweep reaches that index. Its ready bit is then gone
and will not be set again. ice_ptp_process_tx_tstamp() skips the entry
until the 2 second timeout:

	if (tx->has_ready_bitmap &&
	    !(tstamp_ready & BIT_ULL(phy_idx))) {
		if (drop_ts)
			goto skip_ts_read;

		continue;
	}

When the timeout expires, it increments pf->ptp.tx_hwtstamp_timeouts.
Before this change the timestamp memory survived the restart, so the
stale entry would have been read and dropped quietly.

At this commit, ice_ptp_tx_tstamps_pending() also sees in_use as
non-empty. It keeps re-arming PFINT_OICR_TSYN_TX for those 2 seconds.

A later patch in the series stops counting stale entries in IRQ context.
The 2 second slot/skb hold and the timeout count are still there at the
end of the series, though.

The final patch, "ice: Recalibrate PHY after settime64 on E825-C", makes
ice_ptp_settime64() call ice_ptp_restart_all_phy() on live ports without
flushing, which makes this easier to hit. The rebuild path is not
affected, because ice_ptp_rebuild_owner() calls
ice_ptp_flush_all_tx_tracker() first.

Would it make sense to flush the tracker with ice_ptp_flush_tx_tracker()
before the soft reset, instead of only marking it stale? The commit
message also does not mention that in-flight timestamps are discarded on
every restart.

[Severity: Medium]
Is Tx timestamp capture still enabled while this sequence runs?

ice_stop_phy_timer_eth56g() only clears PHY_REG_RX_OFFSET_READY. Its
kernel-doc says PHY_REG_TX_OFFSET_READY is left set, and that "Tx
timestamp requests should be disabled by other means".

In ice_ptp_port_phy_restart(), the only other means are setting
tx.calibrating = true and calling ice_ptp_mark_tx_tracker_stale(). These
block new ice_ptp_request_ts() reservations. Descriptors already posted to
the Tx ring with a timestamp request are still outstanding in hardware.

Inside ice_ptp_phy_soft_reset_eth56g(), the memory sweep happens first.
Then come a PHY_REG_GLOBAL read/write and a sleep, and only after that is
the reset asserted:

	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
	...
	usleep_range(5000, 6000);

	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;

A timestamp might be captured after the sweep has passed its index but
before the assert. The memory entry would then stay valid while the reset
zeroes the internal outstanding-timestamp counter.

Wouldn't that cause the counter/memory mismatch that the comment on
ice_ptp_clear_tx_memory_status_eth56g() warns "may become out of sync and
prevent new timestamp interrupts"?

On the rebuild path, ice_ptp_flush_all_tx_tracker() has already freed the
software index. A new request that reuses the index could then read the
leftover ready entry.

Previously the soft reset only ran at PHC init, with no traffic. Later in
the series, "ice: wait for in-flight Tx timestamps before flushing the
tracker" adds drain logic, but only to ice_ptp_flush_tx_tracker() and not
to this restart path. The window is still there at the end of the series.

[Severity: Low]
What happens if one of the sweep reads fails here?

ice_ptp_clear_tx_memory_status_eth56g() returns void and only warns:

	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
		if (err)
			failed++;
	}

	if (failed)
		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
			 failed, port);

ice_ptp_phy_soft_reset_eth56g() then toggles the soft reset anyway. Next,
ice_start_phy_timer_eth56g() sets TX/RX_OFFSET_READY and returns success,
and ice_ptp_port_phy_restart() clears tx.calibrating.

The comment justifies this by saying software only reads indices it
already knows are ready. If the failed read was on a valid entry, though,
the reset zeroes the outstanding-timestamp counter while that entry stays
in memory. That is the same counter/memory desync the comment warns can
prevent new timestamp interrupts.

Before this patch the sweep and reset never ran at runtime, so a
transient sideband failure during a restart could not cause this.

The commit message says "This ensures that we clear any outstanding Tx
timestamp memory", which does not hold when a sweep read fails. Should
the sweep failure be propagated to the caller?

[Severity: Medium]
Does anything keep the Tx timestamp IRQ thread out while the sweep and
soft reset run?

ice_ptp_port_phy_restart() holds adapter->ps_lock. The consumer path does
not take ps_lock, or anything else that excludes the restart:

ice_misc_intr_thread_fn()
  ice_ptp_process_ts()
    ice_ptp_process_tx_tstamp() / ice_ptp_tx_tstamp_owner()

tx->lock only covers the in_use/skb bookkeeping.

ice_ptp_process_tx_tstamp() reads the ready bitmap once with
ice_get_phy_tx_tstamp_ready(). It then calls ice_read_phy_tstamp() for
each in_use index that bitmap marked ready. Those reads can interleave
with ice_ptp_clear_tx_memory_status_eth56g() and with the roughly 10ms
PHY_REG_GLOBAL toggle.

Suppose the bitmap snapshot is taken before the sweep, and the per-index
read happens after the reset. The IRQ thread then reads an entry that was
already cleared, against a counter that was just zeroed.

The comment on ice_ptp_clear_tx_memory_status_eth56g() says reads outside
the soft reset procedure can put the counter out of sync and prevent new
timestamp interrupts. The IRQ thread could also issue sideband reads to
the port's timestamp block while the reset is asserted.

ice_ptp_restart_all_phy() runs this sequence on every live port on the
adapter, including other PFs' ports. It is called on rebuild, and on
settime64 at the end of the series. Nothing in the series adds
synchronize_irq() or similar to keep the consumer out during this
sequence.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
