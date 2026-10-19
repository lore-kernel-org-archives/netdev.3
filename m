Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440855;
	b=4Jh1zGwKgWtDLkkfEb+HRWFjuY2NOYoY1VEuGi/OlUKIG006qI+bharLRWzuS8hsCJJH
	 neuSZUP74xv+1fsanmsSeiQE5jVahzFpGgNa+8j89lq05iqAldpjpDA0HaH4hzxIq0mJJ
	 X6UQ/VHsxguVvNZtOENnXnK9VntMH0gBOd9P4EtG7MOPmpda/3x1GgAwL/7u/ganCDbd/
	 Wkd+/c/2Lywaxd7XYn21mUY2DllLCucNyg/mf4XdCq+pyIr6T5nyiHb2pGek93cmkDWDU
	 YCbydKdrQ4ANfyezgURxG0SQQWYx9D+Cb2ZxI/WNtebt0+8J86UF1u+rPYNOGtdX6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440855;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld8b3jQrxWmEnmGuo9NBMsh9/VleTJ4Kby+pelQSDEY=;
	b=WQJG8LoMOofVXl8Ad2Kuqva86A0ESZlhnCIbDwrMDZZtggj65PNLwk9216l5ov+dfHRQ
	 cK8KaQzbhPqdF7jBhCBNHRF+BT9KROOZau1uCqkpjLKGqjvE5j45xfDE+hgUGqCBQGp/d
	 ysUDJsJW1CUUmRL2QZV8HqSrjhhS4hea4oQHEjHvOKpKokWP0cOtHLEDXyadK3QFj9+qG
	 aw2XFiQV4Yg6kJlVQy9GP8IfR+UKhVpXRq3QrWa3sBxodx02LauA5IQUC9nUQyiW1DBE5
	 9F0IL+ClW9is5n7ydEJOrHa5LXhXWl9Nk9bB8P8Sw65Q5+Vrw4VN2mLcPoh5Ty+W9Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiBt5LFo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B31606A336
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiBt5LFo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED361F000C4;
	Mon, 19 Oct 2026 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440854;
	bh=Ld8b3jQrxWmEnmGuo9NBMsh9/VleTJ4Kby+pelQSDEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eiBt5LFopH4EzBr0qPCX5WbAWLb106qQ6hNFPilGHsekPsOMiZALb+ItdalREaYVk
	 pOejsmK7f1VCxWfvnBFv2DnDPbLhdbGImY26tBvu4wEn91BV6u41xzVP83mJir2Pq+
	 OvsmN5G17vKG+y+agMf80oc88AbwdYui2eZHWjOt96OcjSG289uFJ3WlqTzux1W3o4
	 H4Daj/ooVd5ONQBo9YWdgEGC2CRlie5Q+V/4xtfnwfovoj2C6meLG46KjNzBhzujME
	 gVFjsY6dDFlB7xYL5GLnNjQYRfIo0xRi3OMo5vHVM9UScZOJyeg/4r2X+pKqfFXKkD
	 fQbQ3hgEdGRfg==
Subject: Re: [PATCH net v3 10/14] ice: E825: perform a soft reset when
 starting the PHY timer
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:13 +0000
Message-ID: <179244085327.3135.14633467597687530953@kernel.org>
In-Reply-To: <20261015191102.1174111-11-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-11-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes the E825 PHY restart path in
  ice_ptp_port_phy_restart()…
- [Medium] On E825, ice_ptp_port_phy_restart() now calls
  ice_ptp_flush_tx_tracker() on a live tracker without synchronizing…
- [Medium] ice_ptp_port_phy_restart() on E825 now flushes, i.e. releases
  in software, every outstanding Tx timestamp index right away.
- [Low] The kernel-doc for struct ice_ptp
  (drivers/net/ethernet/intel/ice/ice_ptp.h:250) still says…

--

ice: E825: perform a soft reset when starting the PHY timer

This commit adds a PHY soft reset to ice_start_phy_timer_eth56g() so the
E825 PHY timer starts in a clean state. Because the restart path now
performs a soft reset, ice_ptp_port_phy_restart() flushes outstanding Tx
timestamps instead of marking them stale.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 365cff9c10173..32be908373c30 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -756,7 +756,8 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
>   * @pf: Board private structure
>   * @tx: the tracker to flush
>   *
> - * Called during teardown when a Tx tracker is being removed.
> + * Called to immediately discard any outstanding Tx timestamps, including when
> + * tearing down the Tx tracker, and on E825 when restarting the PHY.
>   */

[Severity: Low]
This isn't a functional bug, but should the kernel-doc for
tx_hwtstamp_flushed in struct ice_ptp also be updated? ice_ptp.h still
says:

 * @tx_hwtstamp_flushed: number of Tx skbs flushed due to interface closed

On E825, the flush is now called from ice_ptp_port_phy_restart(). Every
PHY restart that has outstanding timestamps now increments this counter.
That covers link-up via ice_ptp_link_change(), the initial restart in
ice_ptp_init(), and ice_ptp_restart_all_phy() during owner rebuild. None
of these is an interface close.

The counter is exported as tx_hwtstamp_flushed in ethtool -S. It is also
added into the standard timestamping err stat in ice_get_ts_stats():

	ts_stats->err = ptp->tx_hwtstamp_skipped +
			ptp->tx_hwtstamp_flushed +
			ptp->tx_hwtstamp_discarded;

As a result, link-up flushes now show up as timestamp errors. Before this
patch, stale-marked requests were dropped without being counted in err.

[ ... ]

> @@ -1327,7 +1328,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>  		ptp_port->tx.calibrating = true;
>  		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>  
> -		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> +		ice_ptp_flush_tx_tracker(pf, &ptp_port->tx);

[Severity: High]
Does this drop the tx->init protection that this call site had before?

ice_ptp_mark_tx_tracker_stale() only touches the bitmaps under tx->lock,
and only when tx->init is set:

	spin_lock_irqsave(&tx->lock, flags);
	if (tx->init)
		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
	spin_unlock_irqrestore(&tx->lock, flags);

An earlier commit in this series, "ice: E825: stop clearing
PHY_REG_TX_OFFSET_READY", added that guard here to prevent a possible
use-after-free on the bitmap.

ice_ptp_flush_tx_tracker() never checks tx->init. It walks tx->in_use
without tx->lock and dereferences tx->tstamps[idx]. It also makes
sleeping sideband calls (ice_get_phy_tx_tstamp_ready(),
ice_clear_phy_tstamp()) while it does so.

Can this race with ice_ptp_release() during driver unload or devlink
reload? The service task path:

ice_link_event()
  ice_ptp_link_change()
    mutex_lock(&pf->adapter->ps_lock)
    pf->ptp.state == ICE_PTP_READY check passes
    ice_ptp_port_phy_restart()
      ice_ptp_flush_tx_tracker()

can run at the same time as:

ice_unload()
  ice_deinit_features()
    ice_ptp_release()
      pf->ptp.state = ICE_PTP_UNINIT    (ps_lock not held)
      ice_ptp_cleanup_pf()
      ice_ptp_release_tx_tracker()
        tx->init = 0
        synchronize_irq(pf->oicr_irq.virq)
        ice_ptp_flush_tx_tracker()
        kfree(tx->tstamps); tx->tstamps = NULL;
        bitmap_free(tx->in_use); tx->in_use = NULL;

synchronize_irq() waits only for the interrupt, not for the service
task. ice_service_task_stop() runs later, in ice_deinit_dev().

If an E825 link-up or speed change is processed during unload, could the
restart's flush read and write tx->in_use and tx->tstamps after they
have been freed or set to NULL?

The commit message doesn't mention losing this guard. The unguarded
flush in ice_ptp_port_phy_restart() is still there at the end of the
series.

[Severity: Medium]
Is this flush synchronized with the clock owner's Tx timestamp
processing?

ice_ptp_process_tx_tstamp() runs from
ice_misc_intr_thread_fn()->ice_ptp_process_ts()->ice_ptp_tx_tstamp_owner()
without adapter->ps_lock. It reads tstamp_ready, the in_use bit and
raw_tstamp without tx->lock. It takes the lock only at skip_ts_read,
where it claims whatever skb is in the slot at that moment:

skip_ts_read:
		spin_lock_irqsave(&tx->lock, flags);
		...
		clear_bit(idx, tx->in_use);
		skb = tx->tstamps[idx].skb;
		tx->tstamps[idx].skb = NULL;
		if (test_and_clear_bit(idx, tx->stale))
			drop_ts = true;
		spin_unlock_irqrestore(&tx->lock, flags);

Could the following sequence deliver a pre-reset timestamp to a
different packet?

owner IRQ thread:
  ice_ptp_process_tx_tstamp() reads raw_tstamp for skb A at idx,
  then is delayed

restart path:
  ice_ptp_flush_tx_tracker() frees A, clears in_use[idx] and stale[idx]
  ice_start_phy_timer_eth56g() soft reset (at least 10ms of sleeps)
  ptp_port->tx.calibrating = false

xmit path:
  ice_ptp_request_ts() reuses idx (lowest free index) for skb B

owner IRQ thread resumes:
  takes tx->lock, claims B, finds no stale bit,
  extends A's pre-reset value and calls skb_tstamp_tx() on B

There is also a variant. The thread uses a tstamp_ready snapshot taken
before the reset and reads the now-cleared register for B's index. It
then drops B for missing the valid bit. B's real capture stays ready
with no in_use owner. The comment in ice_ptp_process_tx_tstamp() warns
that this kind of state can leave interrupt generation stuck.

Before this patch, the restart only marked indices stale. The processing
thread then kept ownership of each index until it cleared in_use under
tx->lock. The other live-tracker flush, in ice_ptp_release_tx_tracker(),
first sets tx->init = 0 and calls synchronize_irq().

The flush also increments tx_hwtstamp_flushed for indices whose skb the
processing thread has already taken, when skb is NULL.

>  
>  		err = ice_start_phy_timer_eth56g(hw, port);
>  		if (err)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 38d0ded1d0cc0..51442b26516ee 100644
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
Can Tx captures land after the memory sweep, into slots that software
has already released in ice_ptp_port_phy_restart()?

The restart flushes every in_use index immediately. Packets that already
hold those indices may still be in the hardware Tx ring with
ICE_TX_CTX_DESC_TSYN set and the index encoded by ice_tstamp().

Setting tx.calibrating only blocks new ice_ptp_request_ts() calls. Also,
ice_stop_phy_timer_eth56g() leaves PHY_REG_TX_OFFSET_READY set:

 * Note this does *not* clear PHY_REG_TX_OFFSET_READY. Clearing it would
 * cause the Tx timestamps to be captured with their valid bit clear.
 * Unfortunately the captured timestamps still increment the internal counter
 * and result in off-by-one accounting. Instead, Tx timestamp requests should
 * be disabled by other means.

ice_ptp_phy_soft_reset_eth56g() runs the sweep first and sleeps before
it asserts the reset:

	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
	...
	usleep_range(5000, 6000);

	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;

If a capture lands before the reset is asserted, the counter and status
are zeroed while the memory still holds a valid entry. If it lands
after, there is a ready bit with no in_use owner.

ice_ptp_process_tx_tstamp() only walks tx->in_use, so that slot is never
read. At this commit, ice_ptp_tx_tstamps_pending() also checks the
hardware ready bitmap, so it would keep re-arming the interrupt.

Later, ice_ptp_request_ts() hands that index to a new skb C. Wouldn't
the processing loop then trust the old ready bit and deliver packet A's
capture to C? C's own capture would then be orphaned, and this would
repeat for each later user of the index until the next restart.

The commit message says:

    This is safe because the soft reset procedure will restore the
    timestamp state and clear any desync.

That seems to hold only for captures that land before the sweep. The
previous stale-marking approach kept these indices in_use until the late
capture was read and discarded, or until the 2 second timeout.

This patch also applies the soft reset to live ports: link-up, up to up
speed changes via ice_link_event(), and ice_ptp_restart_all_phy() on
other PFs' ports during owner rebuild.

A later commit in this series, "ice: keep Tx timestamp slots tracked
until completion or timeout", describes hardware completing captures
after software released the slot around a link bounce. The flush in
ice_ptp_port_phy_restart() is unchanged at the end of the series.

>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>  
>  	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
