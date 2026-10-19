Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440860;
	b=IU8EvFaYZGhi4nr7mG2u+tnZlW1SHdmX6g/vlUS7he9kKdMEjcUeBHcHY6Re1M5IDfY7
	 OjjoohK1tw83GXFwN0BMkpy5hOZXyCNWeP/jcwKdO3fNBatyWOtQrGSecGH9nHuMFazKX
	 LKzb0bkzGxeHaXv2IuanHvITHqWcxTNb+XY8y9tBF0J2BcN6MX/bCoLyVCMfggpRs6vx7
	 wRdX7sH5jPGly0+rB0x8NrHhIN/9/KuIp8vsmB3+L1vbcXDaSg9mxtX5YsWUt+KskPv61
	 EHwlYQG8UWGmTFKWO5MkGt7bdMTYLhPsn8XL+h0hmQXedSCw25B5M3lWNnd/HtQvngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5gvBBvE2T00OiWhhUO68ZWle2+lSdMRsWfnCmkbWBHI=;
	b=XfZ2g7oM6/B8JIh5vpJhBJc2A8mkKjp49bT3gp6Otj+OKKRHy7OAMX2etvqarTqpN6m8
	 lhtSu3Qb7C5aGEeXhJBu4NsMsrq5Oc9MFLjM6h4eSSImxb0mil09SAchpOagE705bYknq
	 Eagq71jvEfPqxJqiBfJ7lV5zdiqOLQQvsCImOoBp4oMyRMKBE2ggW/q/pYd84PGfJ0/mg
	 6wtBVg/qXb9Ns+VDgubSVgnnMhLZ/B9LpzBBxiCBM+rgY87JuHVKjnPoxe+2y7iof4TbK
	 N36OD8zEVeSDCmO/iiDrMw53zhCm+fYl0I2GvdZV0vJGDS2vdacTZquwGGC8OZQcVMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOxoonIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B03606A339
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOxoonIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833901F000C9;
	Mon, 19 Oct 2026 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440859;
	bh=5gvBBvE2T00OiWhhUO68ZWle2+lSdMRsWfnCmkbWBHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JOxoonIPnHna89YibNwZY7z9k8KkkAtlFGZH8XFWMuJ4RW54E993IaRMD0E0jUCz6
	 WJerfd1OA7Gcze0y1FNPndEjzmKmwMD4GUSV6gwJ0Q5L2qrLJWJrraMfhgGWF8Dh0i
	 KbDCBEfN5qHzJGnd3Q3W74xHuRYnTmJLS8RZvy3yk5useuDtHHopMKzVMYIBqXQNKA
	 iEXvaagXgw2YY9emsoq4SCPJkPCs00Fy9mWFAUkHCG3FRagxzvogtyzp0R5Cc8EeFT
	 y7OLggD8rqwAPnuZpwV5acJS+XAANLGqDtB4MQAU+0YZNPFp6P58p2sbwR8TJfMiSd
	 XuaeLD1jFl0BA==
Subject:
 Re: [PATCH net v3 14/14] ice: don't clear in_use until HW clears ready bitmap
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:18 +0000
Message-ID: <179244085807.3135.9409141978116916415@kernel.org>
In-Reply-To: <20261015191102.1174111-15-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-15-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ice_ptp_maybe_trigger_tx_interrupt()
  (drivers/net/ethernet/intel/ice/ice_ptp.c), the patch now reads the…
- [Medium] ice_ptp_flush_tx_tracker() now increments
  pf->ptp.tx_hwtstamp_flushed on every flushed request, and also…
- [Medium] The new 'ready bit not cleared' branch in
  ice_ptp_process_tx_tstamp() decides based on PHY reads done without…
- [Low] pf->ptp.tx_hwtstamp_timeouts now has two writers that are not
  serialized against each other.

--

ice: don't clear in_use until HW clears ready bitmap

This commit re-reads the PHY Tx timestamp ready bitmap after each read in
ice_ptp_process_tx_tstamp(). If the hardware did not clear the bit, the
index stays locked and is marked stale. It also moves the timeout count to
the point where the index is released, counts timeouts on flush, and moves
the hardware ready bitmap check out of ice_ptp_tx_tstamps_pending() and
into ice_ptp_maybe_trigger_tx_interrupt().

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a9658f859c2e8..74e0c0138c501 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -627,6 +622,27 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
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
> +				skb = tx->tstamps[idx].skb;
> +				tx->tstamps[idx].skb = NULL;
> +				spin_unlock_irqrestore(&tx->lock, flags);
> +				/* Free the SKB immediately since we're never
> +				 * going to report a timestamp for the stale
> +				 * packet.
> +				 */
> +				dev_kfree_skb_any(skb);
> +				continue;
> +			}
> +		}

[Severity: Medium]
Can this branch mark a newer request in the same slot as stale and free
its skb?

The decision here comes from ice_read_phy_tstamp() and the ready bitmap
re-read. Neither is done under tx->lock. After the lock is taken, the only
check is test_bit(idx, tx->in_use), and that check can't tell the original
request from a new one that reused idx.

On E825, a link-up event can run this sequence while the IRQ thread sits
between the re-read and spin_lock_irqsave():

ice_ptp_link_change()
  ice_ptp_port_phy_restart()
    ptp_port->tx.calibrating = true;
    ice_ptp_flush_tx_tracker()   /* clears in_use[idx], frees skb */
    ice_start_phy_timer_eth56g()
    ptp_port->tx.calibrating = false;

ice_ptp_request_ts()
    tx->tstamps[idx].start = jiffies;
    tx->tstamps[idx].skb = skb_get(skb);
    ...
    clear_bit(idx, tx->stale);
    smp_mb__before_atomic();
    set_bit(idx, tx->in_use);

Nothing in that sequence waits for an IRQ thread that is already inside the
loop. When the IRQ thread resumes, test_bit(idx, tx->in_use) returns true.
It then sets stale[idx] and frees the new request's skb because of the old
request's hardware state. The new packet's Tx timestamp is lost and
skb_tstamp_tx() is never called for it.

The timing window is narrow, and the freed reference came from skb_get(),
so this is a lost timestamp, not a memory safety issue. The existing
skip_ts_read path has a similar check-then-act gap.

>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
>  
>  		/* For PHYs which don't implement a proper timestamp ready
> @@ -643,6 +659,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  			drop_ts = true;
>  
>  skip_ts_read:
> +		if (timeout)
> +			pf->ptp.tx_hwtstamp_timeouts++;
> +
>  		spin_lock_irqsave(&tx->lock, flags);
>  		if (!tx->has_ready_bitmap && raw_tstamp)
>  			tx->tstamps[idx].cached_tstamp = raw_tstamp;

[Severity: Low]
Is the timeout counted here only when this path is the one that actually
releases the index?

The increment happens before tx->lock is taken, and it doesn't check that
in_use[idx] is still set. This patch also adds an increment of
tx_hwtstamp_timeouts in ice_ptp_flush_tx_tracker(), under tx->lock.

On E82x/E825, ice_ptp_process_tx_tstamp() runs in the clock owner's misc
IRQ thread without ps_lock. The flush can run at the same time from
ice_ptp_port_phy_restart() (E825 link up), from
ice_ptp_flush_all_tx_tracker() during reset, or from tracker release.

Here is one way it can happen:

1. The IRQ thread sees a request that is older than 2 seconds with its
   ready bit clear, sets timeout = true and jumps to skip_ts_read.
2. The flush takes tx->lock, increments tx_hwtstamp_timeouts and clears
   in_use.
3. The IRQ thread increments tx_hwtstamp_timeouts again, and its
   clear_bit() does nothing.

One request ends up counted twice. Also, a plain u32 increment from two
CPUs can lose updates.

The commit message says:

  "This ensures that we don't double count timeouts or count them
  prematurely."

Is that still true now that the flush path also increments this counter?

[ ... ]

> @@ -849,14 +869,20 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>  			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
>  
>  		spin_lock_irqsave(&tx->lock, flags);
> +
> +		/* Count the number of Tx timestamps flushed */
> +		pf->ptp.tx_hwtstamp_flushed++;
> +
> +		/* Also count timeouts if we flush a request that timed out */
> +		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ))
> +			pf->ptp.tx_hwtstamp_timeouts++;
> +

[Severity: Medium]
Doesn't this count one flushed request as both err and lost in the ethtool
timestamping stats?

Both counters are incremented here for the same idx. ice_get_ts_stats()
reports them as:

drivers/net/ethernet/intel/ice/ice_ethtool.c:ice_get_ts_stats() {
    ...
	ts_stats->err = ptp->tx_hwtstamp_skipped +
			ptp->tx_hwtstamp_flushed +
			ptp->tx_hwtstamp_discarded;
	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
}

The kernel-doc for struct ethtool_ts_stats in include/linux/ethtool.h says:

 * @err: Number of arbitrary timestamp generation error events that the
 *	hardware encountered, exclusive of @lost statistics.

This patch lets stuck slots stay locked for well over 2 seconds, so the
E825 link-up flush from ice_ptp_port_phy_restart() is likely to hit this
case. Should tx_hwtstamp_flushed be skipped when the request is counted as
a timeout?

A related detail: an index whose skb was already freed by the new
stuck-ready-bit path still counts towards tx_hwtstamp_flushed, even though
tx->tstamps[idx].skb is NULL. Is that intended?

[ ... ]

> @@ -3001,7 +3009,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
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
Can this early return stop the watchdog from re-triggering the interrupt
for ports that still have outstanding requests?

Before this patch, ice_ptp_tx_tstamps_pending(pf, false) checked the
software in_use bitmaps first, and returned true whenever any request was
outstanding. The hardware check only ran when software had nothing
pending, and an error from it only turned off that hardware-only trigger.

Now the hardware read happens first. On E82x and E825
(ICE_PTP_TX_INTERRUPT_ALL on the clock owner), ice_check_phy_tx_tstamp_ready()
walks every quad or port and returns the first error it hits:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_check_phy_tx_tstamp_ready_eth56g() {
	for (port = 0; port < hw->ptp.num_lports; port++) {
		...
		err = ice_get_phy_tx_tstamp_ready(hw, port, &tstamp_ready);
		if (err)
			return err;
    ...
}

ice_check_phy_tx_tstamp_ready_e82x() does the same across quads.

As long as one PHY can't be read, the watchdog triggers no IRQ for any
port. ice_ptp_process_tx_tstamp() is not re-run, so timed-out or stale
slots on healthy ports are not reaped and a stalled hardware interrupt is
not recovered.

This patch also stops the IRQ path from re-arming for stale entries and
for link-down or calibrating trackers, which leaves the watchdog as the
only fallback. The commit message also says PHY access errors can happen
during the link transition window this patch targets. The commit message
doesn't mention this ordering change.

The kernel-doc for ice_ptp_maybe_trigger_tx_interrupt() still says:

 * To avoid getting permanently stuck, periodically check if there is any
 * outstanding timestamps or if the PHY has marked any index as ready.

Would it work to check ice_ptp_tx_tstamps_pending() first, and treat a
hardware read error the same as no hardware-ready timestamps?

>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>  
>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
