Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D519CC0F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521148; cv=none; b=OLfo1KGQZf1Bvmn5Y2v1iNiR6f44SOImy9D42Q2N5YtOU9CnsXV04AGMi0N/roOjvoYESZ7J5pWfC0IuJsx9RodMZFLIqU+wptKJwjeH2ougYp4r1nTSZZTFDGOYB9GgFkWC4glQkgzyORqkiDOFBIEwcZ+s+6fh8Km3XDFq7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521148; c=relaxed/simple;
	bh=9UIVYUJ65/2aCbuPY1Elex5foTqrVm/WR7Sg+CZFpu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DASCLt8jlU0CVwYjjr5yu+3dSWhwKaw1dPG+5h+prOMc+esasE3QMZgb+tjGLV8EYDLjiwNQ8/lmNytsRkSMXOMz/NOOxhsH/pR6SkqhwXxMq6bicX9QG+DCNxHNtvzA4KPImRGzWXfbdF4e82NyQdxeJc/rJi6e4MNRuq0N7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtNOplK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtNOplK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720611F000FF;
	Wed, 16 Sep 2026 01:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521147;
	bh=T1l11joOyeXdarNqQZf+yevzGGv+uCmyA3RaRY7M9fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtNOplK+YQRGuOVox+83r76S+t5tMvd62w12af3TjbjJDP4bCysWgvU7UberqIY/0
	 mCxftk3S8VQeUz7y/OZriMyYVzWECpJ0XRlfaGWxQ3tKE/i+xLp+TK242HxFFihRIZ
	 JGV0VCEX9oa7Ttboimdj36sINKGbEAQA62kgdumEfyrD+lNsNxAD81DqFCCteXYAI4
	 vPYhiIpZxJSxzxRyhFYsNP0go38u0nOWxCE+blvMf5EISLbJ9FhuLrqAdX/0nvlLni
	 3nfyiiyw/pK7/L5ul6oKAD0LjXaKKTLks0N6x3IKzL/cfvYOqCbzIRfqXdbkE634YG
	 lLPeebXHD8vXw==
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
Subject: Re: [PATCH net 12/15] ice: remove unnecessary discarding of timestamps after clock adjust
Date: Tue, 15 Sep 2026 18:12:25 -0700
Message-ID: <20260916011225.1632772-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-13-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-13-anthony.l.nguyen@intel.com>
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
ice: remove unnecessary discarding of timestamps after clock adjust

This drops the ice_ptp_mark_tx_tracker_stale() call from
ice_ptp_reset_cached_phctime(), so outstanding Tx timestamps are no longer
discarded when the PHC is adjusted or set.  The stale bit itself is kept and
is now only used by the link-down path.  The kernel-doc of
ice_ptp_mark_tx_tracker_stale() is updated to describe the new meaning.

A couple of questions below.

>     The original motivation for discarding timestamps was that extending an old
>     timestamp using the new cached value of PHC was a problem, as it could
>     produce incorrect results. The change did not describe what such "incorrect
>     results" were.
>
>     There are no such incorrect results. Extending the 32 bit timestamp with
>     the new time value just means that the timestamp is reported in terms of
>     the newly updated and adjusted system clock.

[Severity: High]
Does this hold for the .settime path too, or only for the atomic .adjtime
path?

ice_ptp_adjtime() only uses the atomic ice_ptp_write_adj() path for
|delta| <= S32_MAX:

	if (delta > S32_MAX || delta < S32_MIN) {
		dev_dbg(dev, "delta = %lld, adjtime non-atomic\n", delta);

Larger deltas, and every clock_settime() on /dev/ptpN, take
ice_ptp_adjtime_nonatomic() -> ice_ptp_settime64() -> ice_ptp_write_init()
-> ice_ptp_init_time(), which replaces the 64-bit source timer with an
arbitrary new value rather than shifting it by a bounded amount.

The PHY Tx timestamp memory keeps only the captured low 32 bits of nominal
nanoseconds, and ice_ptp_settime64() only restarts the PHY blocks on E82X:

	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
	if (hw->mac_type == ICE_MAC_GENERIC)
		ice_ptp_restart_all_phy(pf);

So on ICE_MAC_E810 / ICE_MAC_E830 a capture taken just before the step is
still in the PHY bank with its ready bit set when
ice_ptp_process_tx_tstamp() runs after the cache was replaced.  With the
stale bit no longer set, that slot passes the drop checks and
ice_ptp_extend_40b_ts() extends the pre-step low 32 bits with the post-step
READ_ONCE(pf->ptp.cached_phc_time).

Isn't the value produced by ice_ptp_extend_32b_ts() then the alias of the
real event time nearest the new clock, i.e. off by (step mod 2^32), which is
up to about +/- 2.147 s and can even be dated after the new PHC value?  The
same function documents that this is outside its stated assumption:

 * 2) assume that the in_tstamp was captured 2^31 nanoseconds (~2.1
 *    seconds) before or after the PHC time was captured.

Separately, is the reverse branch safe when the clock is set to a small
absolute value (for example phc_ctl set 0)?

	if (delta > (U32_MAX / 2)) {
		/* reverse the delta calculation here */
		delta = (phc_time_lo - in_tstamp);
		ns = cached_phc_time - delta;

With cached_phc_time smaller than delta this u64 subtraction wraps, and
ns_to_ktime() then reports a negative hardware timestamp.  Previously the
stale bit hid this case; now it is reachable.

In both cases the result is counted in pf->ptp.tx_hwtstamp_good and handed
to skb_tstamp_tx() rather than dropped.  Would it make sense to keep
discarding outstanding captures for the settime and large-adjtime paths, or
alternatively to restrict the claim in the commit message to the atomic
adjustment case and note the trade-off (a wrong timestamp delivered instead
of no timestamp)?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 299de9d494233..277d9c77af1cb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -826,12 +826,10 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>   * ice_ptp_mark_tx_tracker_stale - Mark unfinished timestamps as stale
>   * @tx: the tracker to mark
>   *
> - * Mark currently outstanding Tx timestamps as stale. This prevents sending
> - * their timestamp value to the stack. This is required to prevent extending
> - * the 40bit hardware timestamp incorrectly.
> - *
> - * This should be called when the PTP clock is modified such as after a set
> - * time request.
> + * Mark currently outstanding Tx timestamps as stale. This prevents the driver
> + * from reporting the timestamp to the stack. This is called to inform the
> + * driver that a timestamp is expected to fail if it was initiated as the link
> + * went down.
>   */
>  static void
>  ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)

[Severity: Low]
This kernel-doc is updated, but two other comment blocks still describe the
removed behaviour.  Should they be updated in the same patch?

The kernel-doc of ice_ptp_reset_cached_phctime(), the function being changed
here, still says:

 * This function must be called when the cached PHC time is no longer valid,
 * such as after a time adjustment. It marks any currently outstanding Tx
 * timestamps as stale and updates the cached PHC time for both the PF and Rx
 * rings.

And the kernel-doc of ice_ptp_process_tx_tstamp() still says the opposite of
the reasoning in this commit message:

 * In cases where the PTP hardware clock was directly adjusted, some
 * timestamps may not be able to safely use the timestamp extension math. In
 * this case, software will set the stale bit for any outstanding Tx
 * timestamps when the clock is adjusted. Then this function will discard
 * those captured timestamps instead of sending them to the stack.

After this patch the only caller of ice_ptp_mark_tx_tracker_stale() is the
link-down branch in ice_ptp_link_change():

	if (!linkup)
		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

so nothing sets the stale bit on a clock adjustment any more.  Both comments
are still present unchanged at the end of the series.

>  static void
> @@ -1049,13 +1047,6 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
>  		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
>  					   msecs_to_jiffies(10));
>  	}
> -
> -	/* Mark any outstanding timestamps as stale, since they might have
> -	 * been captured in hardware before the time update. This could lead
> -	 * to us extending them with the wrong cached value resulting in
> -	 * incorrect timestamp values.
> -	 */
> -	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
>  }
>
>  /**
