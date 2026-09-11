Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2063BE16A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122436; cv=none; b=iIqiOhguiQT88S4iJoq1KyOEZGLdFNs8RLlS9K0xR7IibWS34bdTS7s5L2plQ1mmFrd15LXYRZuAO/1GmPlZKFLFIqpPdoDUq2ifmZT9U3Kuhm5970K+jUVF/fNrRF5ktUZnc/CJ84oA8zdtuzMkCYuqbODjKQqd2/hLdsoUTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122436; c=relaxed/simple;
	bh=S8YilWIQ5x6qHgsGal6aAs/6Ivg2tWgGngS4jZBZJxU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEVfn+5wR/sJCsCa8BQAeHN7afrt9t3fRdjUVi/eFSDj1cHGHhy8Cy/5fN/KCVLfOAIetbYB+W2jzU+WEHW/wmQXJ/ardRBAkbnaCPXaj5e2aifITzC8yF6xpLBD1gyIka7GSasQu1/7OeE5TBEN7VozQkyM4y36KBlTCqfEyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcf1wlMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcf1wlMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199E21F00898;
	Fri, 11 Sep 2026 10:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789122428;
	bh=gjUMDzkAjRhStbV25QO3SCRgeBzrAgqr1IOzHYEA0Us=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hcf1wlMUAF3pggfWnK2zLvmNmnfjxjnEKsQ/cLhqtphIhjv+iMjYFP60ui+BS00lF
	 ey7UVxLku2eSgf+zMq9rVJNB1/w416m/KAFNUvuscPnn3yeA5WiY6SKJCXw1CmP9qj
	 4wegXhUedtN8dI9KD61r+DFL85LFqsxkNAK9l//UKsyvPThk2NAbB4Zdt3hgnxEDIw
	 ZVH8nr57VhOXyWKkbO+CmBUwoUIwKPFix0/s8ME8EfcajSy37Adnkh0ApD7jyBBH2H
	 RwboOHN9LAQ+vTo+RHPYrpMXborPn6zOkTZJvcV5iDHpMxVB5wPMf/PodmHL/U3CaZ
	 UVWT6DbuN9BsA==
Subject:
 Re: [PATCH net-next 1/3] ice: monitor TSPLL lock from PTP periodic worker
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, arkadiusz.kubalewski@intel.com,
 przemyslaw.korba@intel.com, richardcochran@gmail.com,
 alexander.nowlin@intel.com
Date: Fri, 11 Sep 2026 10:27:07 +0000
Message-ID: <178912242763.219967.12573380582223666519@kernel.org>
In-Reply-To: <20260908222428.872254-2-anthony.l.nguyen@intel.com>
References: <20260908222428.872254-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 3

- [Medium] ice_ptp_tspll_monitor()'s recovery cadence and its log rate-
  limit (ICE_TSPLL_LOG_INTERVAL = 120, documented as "~60 s at normal…
- [Medium] The lock-lost dev_warn() and the lock-acquired dev_info() in
  ice_ptp_tspll_monitor() are effectively unrate-limited when the TSPLL…
- [Low] Commit message misdescribes the tree state: it says the cached
  lock state is added "so a follow-up change can consume it from the…
- [Low] ice_ptp_tspll_monitor() is invoked at the top of
  ice_ptp_periodic_work(), ahead of ice_ptp_update_cached_phctime().
- [Low] ice_ptp_init() initializes only ptp->tspll_locked = true and
  never resets the newly added ptp->tspll_lock_retries, whereas the…

--

ice: monitor TSPLL lock from PTP periodic worker

Adds ice_ptp_tspll_monitor() to the PTP periodic worker so E825 owner PFs
poll the TSPLL lock status over CGU registers and restart the PLL when the
lock is lost.  The observed state is cached in pf->ptp.tspll_locked, and
three TSPLL helpers are added/exported for the read, the restart and the
clock source string.

A few questions about the new monitor and about the changelog below.

> Cache the observed lock state in pf->ptp.tspll_locked using
> WRITE_ONCE()/READ_ONCE() so a follow-up change can consume it from the
> DPLL periodic worker (for user-space notification via
> dpll_device_change_ntf()) and drop the redundant poll+recovery from
> that path.

[Severity: Low]
Is there really a redundant poll+recovery in that path today?

At the baseline, ice_dpll.c has no reference to ICE_CGU_RO_LOCK,
ICE_CGU_R23_R24_TSPLL_ENABLE or any lost-lock/restart helper; grepping the
ice/ directory matches only ice_tspll.c and ice_common.h.
ice_dpll_periodic_work() only calls ice_dpll_update_state(), which polls
EEC/PPS state over AQ.

The follow-up patch in this series adds a consumer of the new cache
(ice_dpll_periodic_work_e825() -> ice_dpll_tspll_lock_status_get() ->
READ_ONCE(pf->ptp.tspll_locked)) but does not remove any TSPLL poll or
recovery.

Could the wording be adjusted to say this adds new TSPLL monitoring and
recovery rather than relocating existing recovery out of the DPLL worker?
The same claim is repeated in the new kernel-doc for @tspll_locked in
ice_ptp.h.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index eaec36ab6ae3..4b1040d09f70 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -4,8 +4,11 @@
>  #include "ice.h"
>  #include "ice_lib.h"
>  #include "ice_trace.h"
> +#include "ice_tspll.h"
>  #include "ice_txclk.h"
>  
> +#define ICE_TSPLL_LOG_INTERVAL		120
> +
>  static const char ice_pin_names[][64] = {
>  	"SDP0",
>  	"SDP1",

[ ... ]

> @@ -2849,6 +2852,67 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  	}
>  }
>  
> +/**
> + * ice_ptp_tspll_monitor - poll and recover TSPLL lock on E825 owner PFs
> + * @pf: Board private structure
> + *
> + * Called from the PTP periodic worker. On E825 devices that own the source
> + * timer, poll the TSPLL lock status via CGU registers and trigger a restart
> + * if the lock has been lost. The result is cached in @pf->ptp.tspll_locked
> + * so it can be consumed by the DPLL periodic worker via READ_ONCE().
> + *
> + * TSPLL lock is critical for PHC operation and must be monitored regardless
> + * of whether DPLL init succeeded or CONFIG_DPLL is enabled. Placing the
> + * monitor here makes recovery independent of the dpll subsystem.
> + *
> + * AQ read errors are rate-limited and do not stop monitoring. Lock-lost
> + * events are logged every 120 retries (~60 s at normal poll rate) to
> + * surface persistent failures without flooding the log.
> + */
> +static void ice_ptp_tspll_monitor(struct ice_pf *pf)
> +{
> +	bool lock_lost;
> +	int err;
> +
> +	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825 ||
> +	    !ice_pf_src_tmr_owned(pf))
> +		return;
> +
> +	err = ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost);
> +	if (err) {
> +		dev_err_ratelimited(ice_pf_to_dev(pf),
> +				    "Failed reading TimeSync PLL lock status (err: %d). Retrying.\n",
> +				    err);
> +		return;
> +	}
> +
> +	if (lock_lost) {
> +		WRITE_ONCE(pf->ptp.tspll_locked, false);
> +		if (!(pf->ptp.tspll_lock_retries % ICE_TSPLL_LOG_INTERVAL))
> +			dev_warn(ice_pf_to_dev(pf),
> +				 "TimeSync PLL lock lost. Retrying to acquire lock.\n");
> +		err = ice_tspll_restart_e825c(&pf->hw);
> +		if (err)
> +			dev_err_ratelimited(ice_pf_to_dev(pf),
> +					    "Failed to restart TimeSync PLL (err: %d).\n",
> +					    err);
> +		pf->ptp.tspll_lock_retries++;

[Severity: Medium]
The kernel-doc above says lock-lost events are logged "every 120 retries
(~60 s at normal poll rate)", and the new @tspll_lock_retries documentation
in ice_ptp.h repeats "~every 120 retries / ~60 s".  Does that hold when the
worker requeues itself early?

ice_ptp_periodic_work() ends with:

	/* Run twice a second or reschedule if phc update failed */
	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
				   msecs_to_jiffies(err ? 10 : 500));

and ice_ptp_update_cached_phctime() returns an error whenever ICE_CFG_BUSY is
already set:

	if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
		return -EAGAIN;

ICE_CFG_BUSY is held for the whole duration of ice_set_ringparam(),
ice_set_link_ksettings() and queue count reconfiguration.  If one of those
overlaps a lost TSPLL lock, the monitor runs every ~10 ms rather than every
500 ms.

Each of those ticks calls ice_tspll_restart_e825c(), which clears
ICE_CGU_R23_R24_TSPLL_ENABLE, sleeps 1-2 ms with the source PLL disabled and
re-enables it.

Is it intended that the source PLL is held disabled for 10-20% of that
window, that 3-4 sideband transactions are issued every 10 ms, and that the
documented ~60 s warning interval collapses to ~1.2 s while "after %u
retries" no longer maps to a fixed time base?  The later commit in this
series that wraps the monitor body in pf->dplls.lock leaves this cadence
unchanged.

> +	} else {
> +		if (pf->ptp.tspll_lock_retries) {
> +			const char *src_str = "unknown";
> +			enum ice_clk_src clk_src;
> +
> +			if (!ice_tspll_get_clk_src(&pf->hw, &clk_src))
> +				src_str = ice_tspll_clk_src_str(clk_src);
> +			dev_info(ice_pf_to_dev(pf),
> +				 "TimeSync PLL lock acquired with %s clock source after %u retries.\n",
> +				 src_str, pf->ptp.tspll_lock_retries);
> +		}
> +		WRITE_ONCE(pf->ptp.tspll_locked, true);
> +		pf->ptp.tspll_lock_retries = 0;
> +	}
> +}

[Severity: Medium]
Because this branch resets pf->ptp.tspll_lock_retries to zero, the
'% ICE_TSPLL_LOG_INTERVAL' gate on the dev_warn() is satisfied again on the
very next lock-lost tick.

For a reference clock that alternates between locked and unlocked, does this
emit one dev_warn("TimeSync PLL lock lost...") plus one unrate-limited
dev_info("TimeSync PLL lock acquired ... after %u retries.") per poll pair,
i.e. roughly two messages per second for as long as the input flaps (and up
to ~100 per second if the worker is also requeueing at 10 ms)?

Would dev_warn_ratelimited()/dev_info_ratelimited(), or a counter that a
transient re-lock does not clear, match the stated intent of surfacing
persistent failures "without flooding the log"?

> +
>  static void ice_ptp_periodic_work(struct kthread_work *work)
>  {
>  	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
> @@ -2858,6 +2922,8 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
>  	if (pf->ptp.state != ICE_PTP_READY)
>  		return;
>  
> +	ice_ptp_tspll_monitor(pf);
> +
>  	err = ice_ptp_update_cached_phctime(pf);

[Severity: Low]
The monitor runs ahead of the cached PHC refresh in the same serialized
kthread work item.  On a lock-lost tick it issues up to four sideband CGU
transactions plus the unconditional usleep_range(USEC_PER_MSEC,
2 * USEC_PER_MSEC) in ice_tspll_restart_e825c(), and each control queue
command is bounded only by ICE_CTL_Q_SQ_CMD_TIMEOUT (USEC_PER_SEC, "max
delay 1s" in ice_controlq.h).

ice_ptp_update_cached_phctime() documents that it "must be called
periodically to ensure that the cached value is never more than 2 seconds
old", and it warns and bumps late_cached_phc_updates when that is exceeded.

Would calling ice_ptp_tspll_monitor() after ice_ptp_update_cached_phctime(),
or from a separate work item, keep the sleeping hardware recovery sequence
off the time-critical path?

>  
>  	ice_ptp_maybe_trigger_tx_interrupt(pf);
> @@ -2975,6 +3041,9 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
>  	err = ice_tspll_init(hw);
>  	if (err)
>  		return err;
> +	/* Rebuild reinitialized TSPLL, so reset monitor retry state. */
> +	WRITE_ONCE(ptp->tspll_locked, true);
> +	ptp->tspll_lock_retries = 0;
>  
>  	/* Acquire the global hardware lock */
>  	if (!ice_ptp_lock(hw)) {
> @@ -3319,6 +3388,7 @@ void ice_ptp_init(struct ice_pf *pf)
>  	}
>  	ptp->port.port_num = hw->lane_num;
>  
> +	ptp->tspll_locked = true;
>  	ice_ptp_init_hw(hw);

[Severity: Low]
Should ptp->tspll_lock_retries be cleared here as well?  The rebuild path
above resets both fields, but ice_ptp_init() only sets tspll_locked.

struct ice_ptp is embedded in the probe-lifetime struct ice_pf,
ice_ptp_release() does not clear either field, and
ice_init_features()->ice_ptp_init() /
ice_deinit_features()->ice_ptp_release() run again on the same pf across a
devlink reload.

If the TSPLL happened to be unlocked at unload time, does the leftover
non-zero counter make the first successful poll after reload print
"TimeSync PLL lock acquired with %s clock source after %u retries." for a
lock that was never lost in this instance, and start the
'% ICE_TSPLL_LOG_INTERVAL' gate at a stale phase so a genuine first
lock-lost event stays unlogged for up to ~119 poll cycles?

>  
>  	ice_ptp_init_tx_interrupt_mode(pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index c4b0da7ce20e..0e40fef3b4e8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -249,6 +249,15 @@ struct ice_ptp_pin_desc {
>   * @tx_hwtstamp_discarded: number of Tx skbs discarded due to cached PHC time
>   *                         being too old to correctly extend timestamp
>   * @late_cached_phc_updates: number of times cached PHC update is late
> + * @tspll_locked: last observed TSPLL lock state on E825 owner PFs.
> + *	Written by the PTP periodic worker after polling the TSPLL and
> + *	intended to be read (without pf->dplls.lock) by the DPLL periodic
> + *	worker in a follow-up change. Access via READ_ONCE()/WRITE_ONCE();
> + *	precise synchronization is not required because both workers
> + *	converge on the same value within one poll period.
> + * @tspll_lock_retries: counts consecutive poll cycles in which the TSPLL
> + *	was found unlocked. Reset to zero when lock is re-acquired. Used to
> + *	rate-limit the lock-lost log message (~every 120 retries / ~60 s).
>   */

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
> index fd4b58eb9bc0..78752dc1e762 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.c

[ ... ]

> @@ -531,6 +531,62 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
>  	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
>  }
>  
> +int ice_tspll_restart_e825c(struct ice_hw *hw)
> +{
> +	u32 val;
> +	int err;
> +
> +	/* Read the initial values of r23 and disable the PLL */
> +	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &val);
> +	if (err)
> +		return err;
> +
> +	val &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
> +	err = ice_write_cgu_reg(hw, ICE_CGU_R23, val);
> +	if (err)
> +		return err;
> +
> +	/* Wait at least 1 ms before reenabling PLL */
> +	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> +	val |= ICE_CGU_R23_R24_TSPLL_ENABLE;
> +	return ice_write_cgu_reg(hw, ICE_CGU_R23, val);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908222428.872254-1-anthony.l.nguyen%40intel.com
