Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440858;
	b=NJaAlwM+rCaw8Er7Am+i9KR5lhilUrl8cgovyMSpzTxBEFTKmRrUJgbfK4Fn0oUmgkOk
	 F8gTOVj//m+buygQq1pd3cZTK6xifVR7wXWygfdwsOPajMNkdeQAJBJTSJEFMiCHy8xsQ
	 anZb4nOvD3IMaR8fnhTKmL59Crbdc06jnZiLOuLrc+ETw21TtqAtnLYvIyuQaduOcx99Y
	 QyoUYyYlL8/QbPa2fDjEIiD99SaTBujA4CnUJBMfynIMlOuZTxxFynnJnUYylhSJX4EdN
	 0vXBECuavLxuQbflj5YNxXtmercHv+DbZ1BPZlmVPUNwkIpJcYL85hdgUr0IquSRa/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440858;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DBnRwgDrHbp2fcs994KXTsG/ID1RnejPmmX18JBHa3E=;
	b=ZIE/cHVuNZalnDQ3bVyb6cZVHQicHgvJxhwbvMXhT+Sl5a50qGawVq3B2jRObckudHEy
	 gZWdVvnGe7MGWnZAQkVJmD2sp+MiOcpNHxBfaoL8ve3Ntc1ALdCBBJcrMO2rfCH1HB2ys
	 h+apEnkxMT9HdDXcCjSlNbsj92AxdisYIPjR3MPaajNKKUG8BgotLENXclgUbDJFNUmBM
	 v3OZL7LmsKJMiLAc6m5U3pg26Kb16slmzomKPk698BGgRYzg88nzIRnvz+fe75s4dVaYn
	 yv65PP+luE3sQ8C+npdKh3GqzpcI//R3uXNDAHJXFlkcCqBBqfLfYFCZSrqRh3xr7/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjgbMro+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE060A261D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjgbMro+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D761F000CA;
	Mon, 19 Oct 2026 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440857;
	bh=DBnRwgDrHbp2fcs994KXTsG/ID1RnejPmmX18JBHa3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WjgbMro++xASOV+eCa5Q30+WQYM6vB4URSBXwUuWqMij+5h1JNtg8N9+zWwt+Eyt9
	 uZFAFKR1BAJ1DPISJVsit2B3d0nubZhAdiAbMnBc5bbF7nDcPVo47fAFdSiCLj9/1L
	 jJW0/yowLtWUz82/HKNIog69Q48n8StPiy2McroxF9W/G1zXT8zjmBZOhaIjdTkhAK
	 VJOtXMfGb8TMhlCY1L11NaLMwWY+NSJsz011JVpaAQYJhhh2a7g+PK2p8wBs3BKdit
	 RWHjiiGWn3URXhSaQX80sh5YplbAMstsEHTjqj7KugoBPNFksok/9Np9KaYwj6poxw
	 5ChjvDW0+sWug==
Subject: Re: [PATCH net v3 12/14] ice: keep Tx timestamp slots tracked until
 completion or timeout
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:16 +0000
Message-ID: <179244085652.3135.218744406584842048@kernel.org>
In-Reply-To: <20261015191102.1174111-13-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-13-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says this patch adds the tracker-init
  check: "Since we're adding a new call to ice_ptp_mark_tx_tracker,…
- [Medium] ice_ptp_link_change() now calls
  ice_ptp_mark_tx_tracker_stale() on every link-down, before the…
- [Low] The concern says the kernel-doc of
  ice_ptp_mark_tx_tracker_stale() ('should be called when the PTP clock…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but in the
  ICE_PTP_READY branch ice_ptp_release() calls…
- [Medium] The concern: the 2 s timeout in ice_ptp_process_tx_tstamp()
  releases a not-ready index without reading it.

--

ice: keep Tx timestamp slots tracked until completion or timeout

This commit stops dropping outstanding Tx timestamp requests when the
link goes down. Instead it marks them stale, rejects new requests while
the link is down, and frees a slot that is not ready only after the 2
second timeout. It also changes the pending-timestamp check used when
re-arming the IRQ and in ice_ptp_maybe_trigger_tx_interrupt().

> Since we're adding a new call to ice_ptp_mark_tx_tracker, notice that the
> function previously did not check the tracker initialization state. Fix
> this by only accessing the bitmaps if the init field is set.

[Severity: Medium]
Is this paragraph accurate for this patch? The diff does not modify
ice_ptp_mark_tx_tracker_stale(). The if (tx->init) guard in it comes
from the earlier commit "ice: E825: stop clearing
PHY_REG_TX_OFFSET_READY".

The message also names the function ice_ptp_mark_tx_tracker instead of
ice_ptp_mark_tx_tracker_stale.

This patch has Fixes: fcc2cef37fed, so it is likely to be picked for
stable. A backport of this patch alone would add the new
ice_ptp_link_change() caller without the guard. Then a link-down after a
failed tracker allocation would call bitmap_or() on NULL in_use and
stale bitmaps.

Could the message say that the guard is a prerequisite from the other
commit, so the two get backported together?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index ca581490f3edb..57141e94c5708 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  			return;
>  	}
>  
> -	/* Drop packets if the link went down */
> -	link_up = READ_ONCE(ptp_port->link_up);
> -
>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>  		struct skb_shared_hwtstamps shhwtstamps = {};
>  		u8 phy_idx = idx + tx->offset;
>  		u64 raw_tstamp = 0, tstamp;
> -		bool drop_ts = !link_up;
> +		bool drop_ts = false;
>  		struct sk_buff *skb;
>  
>  		/* Paired with smp_mb__before_atomic() in ice_ptp_request_ts()

[Severity: Medium]
This isn't a bug introduced by this patch, but the 2 second timeout
later in ice_ptp_process_tx_tstamp() still releases an index that is not
ready, without reading it:

		if (tx->has_ready_bitmap &&
		    !(tstamp_ready & BIT_ULL(phy_idx))) {
			if (drop_ts)
				goto skip_ts_read;

Suppose the hardware holds a timestamp-requested frame for more than 2
seconds, for example during a long pause or PFC stall. Could the capture
then land in an index that a new request has reused, or leave a ready
bit with no in_use owner?

That seems to conflict with this statement in the commit message: "This
way an index is never reused while the hardware can still write it".

For the link-down case itself, the device counts frames dropped while
the link is down (GLPRT_TDOLD), so that case looks less likely to hit
this.

[ ... ]

> @@ -1432,6 +1431,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  
>  	WRITE_ONCE(ptp_port->link_up, linkup);
>  
> +	if (!linkup)
> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> +
>  	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
>  		goto out_unlock;
>  

[Severity: Medium]
Can this take an uninitialized spinlock on link down?

ice_ptp_mark_tx_tracker_stale() takes tx->lock before it checks
tx->init:

	spin_lock_irqsave(&tx->lock, flags);
	if (tx->init)
		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
	spin_unlock_irqrestore(&tx->lock, flags);

The only spin_lock_init() of tx->lock is in ice_ptp_alloc_tx_tracker().
That is reached only through ice_ptp_init() -> ice_ptp_init_port(), and
ice_init_features() calls ice_ptp_init() only when
ICE_FLAG_PTP_SUPPORTED is set and the driver is not in safe mode.

ice_link_event() calls ice_ptp_link_change() without checking
ICE_FLAG_PTP_SUPPORTED, and the new call comes before the ICE_PTP_READY
check. Consider a PF without 1588 support, a PF in safe mode, or a PF
where ice_ptp_init() failed before reaching ice_ptp_init_port(). Every
link-down there would do:

ice_link_event()
  ice_ptp_link_change(pf, false)
    ice_ptp_mark_tx_tracker_stale()
      spin_lock_irqsave(&tx->lock, flags)

on a lock that was never initialized. With CONFIG_DEBUG_SPINLOCK this
gives "spinlock bad magic". With lockdep it gives "trying to register
non-static key" and lockdep turns itself off.

Also, ice_ptp_alloc_tx_tracker() sets tx->init = 1 before it calls
spin_lock_init(&tx->lock).

Should this new call depend on PTP having been initialized, for example
by moving it after the ICE_PTP_READY check?

[Severity: Low]
This isn't a bug, but the kernel-doc for ice_ptp_mark_tx_tracker_stale()
still says:

 * This should be called when the PTP clock is modified such as after a set
 * time request.

Now that ice_ptp_link_change() also calls it on link down, should the
comment mention that use as well?

[Severity: High]
This is a pre-existing issue, not one introduced by this patch.

ice_ptp_release() destroys the PTP kworker before it unregisters the
PHC:

	if (pf->ptp.kworker) {
		kthread_destroy_worker(pf->ptp.kworker);
		pf->ptp.kworker = NULL;
	}

	if (!pf->ptp.clock)
		return;

	/* Disable periodic outputs */
	ice_ptp_disable_all_perout(pf);

	ptp_clock_unregister(pf->ptp.clock);

Neither ice_ptp_settime64() nor ice_ptp_adjtime() checks ptp.state, and
on success they call ice_ptp_reset_cached_phctime(). If
ice_ptp_update_cached_phctime() returns -EAGAIN because ICE_CFG_BUSY is
held, that function then does:

		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
					   msecs_to_jiffies(10));

ICE_CFG_BUSY can be held by a concurrent settime or adjtime on the same
clock, or by ethtool set_link_ksettings or set_ringparam.

Could a clock_settime() on /dev/ptpX that races with PF removal queue
delayed work on a worker that kthread_destroy_worker() is about to free?
Could it instead call kthread_queue_delayed_work() with a NULL kworker?

The ethtool paths can still run at this point, because ice_unload()
tears down PTP before it unregisters the netdev:

ice_unload()
  ice_deinit_features()
    ice_ptp_release()
      kthread_destroy_worker()
      ...
      ptp_clock_unregister()
  ...
  ice_unregister_netdev()

Would unregistering the clock before destroying the worker close this
window?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
