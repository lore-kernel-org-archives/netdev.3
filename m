Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DD43A80A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122439; cv=none; b=OJ7KMEem25R68cXJ/AM/qmypB76Dn2ASxJ/2EG2DNteImA6OIBJie4LlEdOSsKyCGLw3g9F+mdpqWmy/j/WY5i9cm1d7fzkfewMdhrB2ggf3NYwNYkFFQMba+tukTJa7ORaVrjbhcR3nx8ZutWg5yWGk8sgxVBv+R9gL5tpI4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122439; c=relaxed/simple;
	bh=EEVLz5gkdbg7u9bwAPenVfVaGNtSn63XF6gxgt04EJs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTT9pDAChagy68G7afRMims4sI5Th+HPBqQRyrKxCRcmt9ljrBjjSq+EzvoAe3+PAcREZaeZYVOeEyqVqYAVrC8WndmczUngrbjju8BJoQmasRDOdbZcVnsHOzrM56KaQIp6+c9EoTM2Hlv8eZsx9BCn0dZBSKwrhL2Gfv+zHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUoudR1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUoudR1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458A31F00899;
	Fri, 11 Sep 2026 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789122429;
	bh=aumurfYG0T/Q3ZVrtr9XUcIlRZ4tjjW/fqZ5hCfAr48=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PUoudR1V7WGuaW1eTDPDQpvhfTMo2XQByxVE9JapKKxxCTKrQUg/2AzUf5q6HPK66
	 7RrFWF5zLxaEq80Y+zoICsCLAq7UxYGfxf+a+srB9GE1Vd9TVTe+Gji/KpDif0GVDD
	 1lDOPeXyd4sIubqh8Q321AVbcDEVS1qUG+3E3xL+N6vP1uf9yedj9xxUpP1CVWjJQ5
	 qV0k3Q95zEyfPyDMI6n3lvPjmUUTEAlxg5wIepKU1FGfyIAW0QVFSAR9Tm5dYQjf2P
	 sdpZii8XUDm++4tK+DM9FM/ycsO6KDOa5tBtlH/zLyXiuOJZh+rcrRSaMO/uLtHilZ
	 mCie77hCwzNHw==
Subject:
 Re: [PATCH net-next 2/3] ice: add TSPLL DPLL device and TIME_REF pin for E825
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, arkadiusz.kubalewski@intel.com,
 przemyslaw.korba@intel.com, richardcochran@gmail.com,
 alexander.nowlin@intel.com
Date: Fri, 11 Sep 2026 10:27:08 +0000
Message-ID: <178912242885.219967.6718861956714436013@kernel.org>
In-Reply-To: <20260908222428.872254-3-anthony.l.nguyen@intel.com>
References: <20260908222428.872254-3-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 8 · Low: 2

- [Medium] E825 TSPLL DPLL device is registered and its periodic worker
  started based only on `ice_pf_src_tmr_owned(pf) &&…
- [Medium] ice_dpll_deinit_tspll_pins() unconditionally calls
  ice_dpll_stop_fwnode_pin_activity(&pf->dplls.tspll_in, true), which…
- [Medium] The patch introduces `!IS_ERR_OR_NULL(pf->dplls.tspll.dpll)`
  as the existence predicate for the new TSPLL dpll device (in…
- [Medium] pf->dplls.lock is taken only by the new userspace TSPLL
  reconfiguration path (ice_dpll_tspll_state_on_dpll_set()) and the PTP…
- [Medium] The new userspace-reachable path
  ice_dpll_tspll_state_on_dpll_set() -> ice_tspll_set_cfg() ->…
- [Medium] ice_dpll_tspll_state_on_dpll_set() never compares the
  requested pin state with the currently programmed clock source…
- [Medium] TSPLL source changes and E825 periodic-output configuration
  perform unsynchronized read-modify-write operations on different…
- [Medium] A userspace-selected TSPLL clock source is not preserved
  across an E825 reset: ice_dpll_tspll_state_on_dpll_set() writes the…
- [Low] ice_tspll_cfg_e825c() now returns -EAGAIN for 'configuration
  applied but PLL not locked yet', but the new contract is not reflected…
- [Low] struct ice_dplls's kernel-doc still describes @lock as a purely
  DPLL-internal mutex ('protects DPLL configuration', '@lock serializes…

--

ice: add TSPLL DPLL device and TIME_REF pin for E825

This exposes the E825 source timer PLL (TSPLL) as a DPLL_TYPE_GENERIC device
with a fwnode-backed "time_ref" input pin, so its lock status can be read and
its clock source switched between TIME_REF and TCXO from userspace.  It also
moves the pf->dplls.lock lifetime out to ice_init_features() /
ice_deinit_features() and takes that mutex in the PTP TSPLL monitor.

A few questions below about the new paths.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 85a74cd6ea1f..00e3f7de7810 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -2814,6 +2817,160 @@ static const struct dpll_pin_ops ice_dpll_txclk_ops = {
>  	.direction_get = ice_dpll_input_direction,
>  };
>  
> +/**
> + * ice_dpll_tspll_lock_status_get - derive TSPLL state for dpll subsystem
> + * @pf: board private structure
> + * @use_cached: if true, read lock state from pf->ptp.tspll_locked (maintained
> + *              by the PTP periodic worker); if false, query hardware directly
> + *
> + * If TIME_REF is not selected, TSPLL is treated as unlocked from the dpll
> + * subsystem perspective, regardless of raw lock bit.
> + *
> + * Return: TSPLL lock status
> + */
> +static enum dpll_lock_status
> +ice_dpll_tspll_lock_status_get(struct ice_pf *pf, bool use_cached)
> +{
> +	enum ice_clk_src clk_src;
> +	bool locked;
> +
> +	if (ice_tspll_get_clk_src(&pf->hw, &clk_src) ||
> +	    clk_src != ICE_CLK_SRC_TIME_REF)
> +		return DPLL_LOCK_STATUS_UNLOCKED;
> +
> +	if (use_cached) {
> +		locked = READ_ONCE(pf->ptp.tspll_locked);
> +	} else {
> +		bool lock_lost;
> +
> +		if (ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost))
> +			return DPLL_LOCK_STATUS_UNLOCKED;
> +		locked = !lock_lost;
> +	}
> +	return locked ? DPLL_LOCK_STATUS_LOCKED : DPLL_LOCK_STATUS_UNLOCKED;
> +}

[ ... ]

> +static int
> +ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll,
> +				 void *dpll_priv, enum dpll_pin_state state,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_pf *pf = p->pf;
> +	enum ice_clk_src clk_src;
> +	bool changed = false;
> +	struct ice_dpll *tp;
> +	int ret;
> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	if (state != DPLL_PIN_STATE_CONNECTED &&
> +	    state != DPLL_PIN_STATE_DISCONNECTED) {
> +		NL_SET_ERR_MSG(extack,
> +			       "unsupported pin state for TSPLL reference clock");
> +		return -EINVAL;
> +	}
> +
> +	clk_src = (state == DPLL_PIN_STATE_CONNECTED) ? ICE_CLK_SRC_TIME_REF :
> +							ICE_CLK_SRC_TCXO;

[Severity: Medium]
Should this compare the requested state against the currently programmed
clock source before reprogramming?

The dpll core does not filter a set request that matches the current state -
dpll_pin_state_set() in drivers/dpll/dpll_netlink.c calls
ops->state_on_dpll_set() unconditionally:

	ret = ops->state_on_dpll_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
				     dpll, dpll_priv(dpll), state, extack);

So a management daemon that periodically re-asserts DPLL_PIN_STATE_CONNECTED
runs the full ice_tspll_set_cfg() sequence each time, which clears
ICE_CGU_R23_R24_TSPLL_ENABLE and ICE_CGU_R9_TIME_SYNC_EN, reprograms the
dividers, sleeps and waits 1-2 ms for re-lock.  Can that stop the PHC long
enough for ice_ptp_tspll_monitor() to see a lost lock and enter its restart
path, for a request that should be a no-op?  The get callback already has
ice_tspll_get_clk_src() available for the comparison.

> +	tp = &pf->dplls.tspll;
> +	/* Serialize multi-register TSPLL reconfiguration with restart path. */
> +	mutex_lock(&pf->dplls.lock);
> +	ret = ice_tspll_set_cfg(&pf->hw, ICE_TSPLL_FREQ_156_250, clk_src);

[Severity: Medium]
Is pf->dplls.lock enough to cover all TSPLL writers?  The commit message says:

    Serialize both with pf->dplls.lock across their HW-read -> cache-write
    sequence

but there is a third writer that takes no lock at all.  ice_ptp_rebuild_owner()
reprograms the same CGU registers and writes the same cache:

	err = ice_tspll_init(hw);
	if (err)
		return err;
	/* Rebuild reinitialized TSPLL, so reset monitor retry state. */
	WRITE_ONCE(ptp->tspll_locked, true);

Neither ice_prepare_for_reset() nor ice_ptp_prepare_for_reset() takes
pf->dplls.lock, and the ice_dpll_is_reset() check above happens before the
mutex is acquired, so a reset can start after the check passes.

Can two read-modify-write sequences on ICE_CGU_R9 / ICE_CGU_R23 then overlap
while ice_tspll_cfg_e825c() has the PLL disabled and is sleeping, and can the
unlocked WRITE_ONCE(ptp->tspll_locked, true) clobber the value published under
the mutex here?

[Severity: Medium]
Does the source selected here survive a reset?  Nothing records the requested
clk_src, while reset recovery reprograms the source from the firmware
capability value in ice_tspll_init():

	tspll_freq = (enum ice_tspll_freq)ts_info->time_ref;
	clk_src = (enum ice_clk_src)ts_info->clk_src;

ice_ptp_rebuild_owner() calls ice_tspll_init() for the source timer owner on
every non-PFR reset, so after an admin switches TIME_REF -> TCXO through this
pin, any PF/CORE/GLOBAL reset would silently revert it while the same pin
stays registered and only the lock status is republished.

[ ... ]

> @@ -3134,12 +3291,44 @@ ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
>  	return ret;
>  }
>  
> +/**
> + * ice_dpll_periodic_work_e825 - TSPLL DPLL periodic update for E825
> + * @pf: board private structure
> + *
> + * Publish TSPLL lock status to the dpll subsystem. The PTP periodic worker
> + * owns TSPLL lock polling and recovery; this function consumes the cached
> + * result for dpll notifications.
> + *
> + * Context: Must be called without pf->dplls.lock held.
> + */
> +static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
> +{
> +	struct ice_dpll *tp = &pf->dplls.tspll;
> +	enum dpll_lock_status new_state;
> +	bool changed = false;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	new_state = ice_dpll_tspll_lock_status_get(pf, true);

[Severity: Medium]
What updates pf->ptp.tspll_locked when ice_ptp_init() failed?

The TSPLL device and this worker are started from ice_dpll_init_e825() based
on ice_pf_src_tmr_owned(pf) && test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags),
which does not imply PTP reached ICE_PTP_READY.  ice_init_features() ignores
the outcome of ice_ptp_init(), and the error exits there (hw->lane_num < 0,
ice_ptp_init_owner() failure, ice_ptp_init_work() failure) set state to
ICE_PTP_UNINIT without clearing ICE_FLAG_PTP_SUPPORTED.

The only producer of the cache then never runs:

ice_ptp_periodic_work()
	if (pf->ptp.state != ICE_PTP_READY)
		return;

	ice_ptp_tspll_monitor(pf);

So with use_cached = true the published status appears to freeze at whatever
ice_ptp_init() left in tspll_locked (it optimistically assigns
ptp->tspll_locked = true before the failing steps), for the lifetime of the
driver.  Can the first tick here also overwrite the init-time direct hardware
read done in ice_dpll_init_info_e825c() and emit a change notification that
does not reflect hardware?

[ ... ]

> @@ -3806,6 +4022,25 @@ static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
>  	return 0;
>  }
>  
> +/**
> + * ice_dpll_deinit_tspll_pins - deinitialize TSPLL fwnode pin
> + * @pf: board private structure
> + *
> + * Stop notifier activity and release the TIME_REF fwnode pin, unregistering
> + * it from the TSPLL DPLL if it was registered.
> + */
> +static void ice_dpll_deinit_tspll_pins(struct ice_pf *pf)
> +{
> +	struct ice_dpll_pin *time_ref = &pf->dplls.tspll_in;
> +	struct ice_dpll *tp = &pf->dplls.tspll;
> +
> +	ice_dpll_stop_fwnode_pin_activity(time_ref, true);
> +	if (!IS_ERR_OR_NULL(time_ref->pin))
> +		dpll_pin_unregister(tp->dpll, time_ref->pin,
> +				    &ice_dpll_tspll_in_ops, time_ref);
> +	ice_dpll_release_fwnode_pin(time_ref);
> +}
> +
>  /**
>   * ice_dpll_deinit_pins - deinitialize direct pins
>   * @pf: board private structure
> @@ -3826,7 +4061,10 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
>  
>  	ice_dpll_deinit_rclk_pin(pf);
>  	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
> -		ice_dpll_deinit_txclk_pins(pf);
> +		if (ice_pf_src_tmr_owned(pf) &&
> +		    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> +			ice_dpll_deinit_tspll_pins(pf);
> +		ice_dpll_deinit_txclk_pins(pf, true);
>  		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
>  	}

[Severity: Medium]
Is it safe to decide this teardown from re-evaluated runtime state rather than
from the pin object itself?

ice_dpll_stop_fwnode_pin_activity() dereferences pin->pf with no NULL check:

	unregister_dpll_notifier(&pin->nb);
	if (flush)
		flush_workqueue(pin->pf->dplls.wq);

and tspll_in.pf / tspll_in.nb are populated only inside
ice_dpll_init_tspll_pins() (unlike txclks and inputs, whose pf is assigned
unconditionally in ice_dpll_init_info_txclk_pins_e825c() and
ice_dpll_init_info_direct_pins()).

ice_pf_src_tmr_owned() reads pf->hw.func_caps.ts_func_info.src_tmr_owned,
which ice_rebuild() re-populates from firmware via ice_get_caps() while the
driver stays loaded.  If the gate was false at init and true here, does this
oops on flush_workqueue(pin->pf->dplls.wq) and unregister a zeroed
notifier_block?  In the inverse case, is the registered notifier and the
fwnode pin reference leaked past unload?  Guarding on tspll_in.fwnode or
tspll_in.pf would make init and deinit symmetric.

[ ... ]

> @@ -4022,6 +4260,45 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
>  	return ret;
>  }
>  
> +static int ice_dpll_init_tspll_pins(struct ice_pf *pf)
> +{
> +	struct ice_dpll_pin *time_ref = &pf->dplls.tspll_in;
> +	struct ice_dpll *tp = &pf->dplls.tspll;
> +	int ret;
> +
> +	time_ref->pf = pf;
> +	ret = ice_dpll_init_fwnode_pin(time_ref, ice_dpll_fwnode_time_ref);
> +	if (ret)
> +		return ret;

[ ... ]

> @@ -4237,6 +4530,7 @@ static void ice_dpll_deinit_worker(struct ice_pf *pf)
>  
>  	kthread_cancel_delayed_work_sync(&d->work);
>  	kthread_destroy_worker(d->kworker);
> +	d->kworker = NULL;
>  }

[ ... ]

> @@ -4861,9 +5161,10 @@ void ice_dpll_deinit(struct ice_pf *pf)
>  		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>  	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
>  		ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
> +	if (!IS_ERR_OR_NULL(pf->dplls.tspll.dpll))
> +		ice_dpll_deinit_dpll(pf, &pf->dplls.tspll, false);
>  
>  	ice_dpll_deinit_info(pf);
> -	mutex_destroy(&pf->dplls.lock);
>  }

[Severity: Medium]
Can pf->dplls.tspll.dpll be stale here?  ice_dpll_deinit_dpll() puts the
reference but never clears the pointer:

	if (cgu || pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
		dpll_device_unregister(d->dpll, d->ops, d);
	dpll_device_put(d->dpll, &d->tracker);

pf (and pf->dplls) survives an unload/load cycle via devlink reload, and the
TSPLL device is created only when ice_pf_src_tmr_owned(pf) &&
ICE_FLAG_PTP_SUPPORTED holds.  If that gate is false on a later cycle, does
this predicate still see the already-put pointer from the previous cycle and
call dpll_device_unregister()/dpll_device_put() on a device it no longer owns?

The same patch adds d->kworker = NULL in ice_dpll_deinit_worker() precisely so
the new if (pf->dplls.kworker) predicate is truthful - would a matching
d->dpll = NULL be appropriate?

[ ... ]

> @@ -4904,9 +5202,30 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
>  	err = ice_dpll_init_info_e825c(pf);
>  	if (err)
>  		goto err_exit;
> +	if (ice_pf_src_tmr_owned(pf) &&
> +	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
> +		err = ice_dpll_init_dpll(pf, &pf->dplls.tspll, false,
> +					 DPLL_TYPE_GENERIC);
> +		if (err)
> +			goto deinit_info;

[ ... ]

> +		err = ice_dpll_init_worker(pf);
> +		if (err)
> +			goto deinit_tspll;
> +	}
>  	err = ice_dpll_init_dpll(pf, &pf->dplls.txc, false, DPLL_TYPE_GENERIC);
>  	if (err)
> -		goto deinit_info;
> +		goto deinit_worker;
>  	err = ice_dpll_init_pins_e825(pf);
>  	if (err)
>  		goto deinit_txclk;
> @@ -4917,10 +5236,15 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
>  
>  deinit_txclk:
>  	ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
> +deinit_worker:
> +	if (pf->dplls.kworker)
> +		ice_dpll_deinit_worker(pf);
> +deinit_tspll:
> +	if (!IS_ERR_OR_NULL(pf->dplls.tspll.dpll))
> +		ice_dpll_deinit_dpll(pf, &pf->dplls.tspll, false);
>  deinit_info:
>  	ice_dpll_deinit_info(pf);
>  err_exit:
> -	mutex_destroy(&d->lock);
>  	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..2f372dd37b53 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4725,6 +4725,14 @@ static void ice_init_features(struct ice_pf *pf)
>  	if (ice_is_safe_mode(pf))
>  		return;
>  
> +	/* pf->dplls.lock guards TSPLL/CGU access shared between the DPLL
> +	 * subsystem callbacks and the PTP periodic worker's TSPLL monitor.
> +	 * Initialize it before ice_ptp_init() so the PTP kworker never sees
> +	 * an uninitialized mutex, and destroy it in ice_deinit_features()
> +	 * only after ice_ptp_release() has drained the kworker.
> +	 */
> +	mutex_init(&pf->dplls.lock);
> +

[Severity: Low]
Could the kernel-doc for the mutex be updated along with its new owner?

struct ice_dplls in ice_dpll.h still describes @lock as "protects DPLL
configuration (see Locking below)" and states that "@lock serializes all DPLL
state mutations on this PF", with a Locking section that lists only DPLL-side
acquirers.  After this change the mutex is also taken from
ice_ptp_tspll_monitor() in ice_ptp.c, and its lifetime belongs to
ice_init_features()/ice_deinit_features() rather than
ice_dpll_init()/ice_dpll_deinit().

The @tspll_locked kernel-doc in ice_ptp.h also still says the field is
"intended to be read (without pf->dplls.lock) by the DPLL periodic worker in
a follow-up change", while this patch reads it with pf->dplls.lock held.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 4b1040d09f70..e54a98a0bdd0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2878,8 +2878,19 @@ static void ice_ptp_tspll_monitor(struct ice_pf *pf)
>  	    !ice_pf_src_tmr_owned(pf))
>  		return;
>  
> +	/* Serialize the entire monitor tick against TSPLL userspace reconfig
> +	 * (ice_dpll_tspll_state_on_dpll_set()). Both paths read HW state and
> +	 * write pf->ptp.tspll_locked; without holding pf->dplls.lock across
> +	 * the HW read here, a preempted monitor could observe stale HW state
> +	 * and then overwrite an accurate cache update from the DPLL callback.
> +	 * pf->dplls.lock is initialized in ice_init_features() before the PTP
> +	 * kworker starts and destroyed in ice_deinit_features() only after
> +	 * ice_ptp_release() has drained the kworker, so it is always valid.
> +	 */
> +	mutex_lock(&pf->dplls.lock);
>  	err = ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost);

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
> index 78752dc1e762..85bacb7c3a79 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
> @@ -334,8 +334,9 @@ static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
>   * Return:
>   * * %0       - success
>   * * %-EINVAL - input parameters are incorrect
> - * * %-EBUSY  - failed to lock TSPLL
> - * * %other   - CGU read/write failure
> + * * %-EAGAIN - TSPLL configuration succeeded but lock is not acquired yet
> + * * %-EBUSY  - CGU access is busy (for example during reset)
> + * * %other   - other CGU read/write failures
>   */
>  static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
>  			       enum ice_clk_src clk_src)
> @@ -467,7 +468,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
>  
>  	if (!(val & ICE_CGU_RO_LOCK_TRUE_LOCK)) {
>  		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
> -		return -EBUSY;
> +		return -EAGAIN;
>  	}

[Severity: Low]
Should ice_tspll_cfg_e82x() and the ice_tspll_cfg() wrapper doc follow this
new convention?  ice_tspll_cfg_e82x() still returns -EBUSY for the identical
"configured but not locked" check on ICE_CGU_RO_BWM_LF_TRUE_LOCK, so the two
implementations behind one wrapper now report different errnos for the same
hardware condition, and the wrapper's kernel-doc still mentions only "other
negative error codes when failed to configure CGU".

The E825-only path means this cannot be hit through ice_tspll_set_cfg() today,
but a future caller reading the wrapper contract could get it wrong.

> +/**
> + * ice_tspll_set_cfg - configure TS PLL with new settings
> + * @hw: board private hw structure
> + * @clk_freq: clock frequency to program
> + * @clk_src: clock source to select (TIME_REF, or TCXO)
> + *
> + * Configure CGU with new clock source and clock frequency settings.
> + *
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */

Could this kernel-doc list -EAGAIN as well?  Its only caller,
ice_dpll_tspll_state_on_dpll_set(), special-cases that value and maps it to
success, which the "negative - error" wording contradicts.

> +int ice_tspll_set_cfg(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
> +		      enum ice_clk_src clk_src)
> +{
> +	int ret;
> +
> +	if (!ice_tspll_check_params(hw, clk_freq, clk_src))
> +		return -EINVAL;
> +
> +	ret = ice_tspll_dis_sticky_bits(hw);
> +	if (ret)
> +		return ret;
> +
> +	return ice_tspll_cfg(hw, clk_freq, clk_src);
> +}

[Severity: Medium]
What restores the hardware if this sequence fails half way through?

ice_tspll_cfg_e825c() first clears ICE_CGU_R23_R24_TSPLL_ENABLE and
ICE_CGU_R9_TIME_SYNC_EN and re-enables them only at the end.  Any sideband
read or write failure in between returns early with no rollback, so the PLL is
left disabled and TIME_SYNC_EN gated.

The runtime recovery path only touches R23:

ice_tspll_restart_e825c()
	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &val);
	...
	val &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
	...
	val |= ICE_CGU_R23_R24_TSPLL_ENABLE;
	return ice_write_cgu_reg(hw, ICE_CGU_R23, val);

so ICE_CGU_R9_TIME_SYNC_EN is never restored.  Can the PLL then re-lock,
ice_ptp_tspll_monitor() log "lock acquired" and set tspll_locked = true, and
the new TSPLL DPLL device publish LOCKED, while the 1588 clock feeding the
source timer stays gated and the PHC is frozen?  Before this patch the
sequence ran only from ice_tspll_init() at probe/reset, where failure aborts
PTP init.

[Severity: Medium]
Can this collide with the E825 periodic-output configuration on ICE_CGU_R9?

ice_tspll_cfg_e825c() reads R9 at the start and writes the whole register back
several sideband transactions later, while ice_tspll_cfg_pps_out_e825c() does
its own full-register read-modify-write of the 1PPS fields:

	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &val);
	...
	val &= ~(ICE_CGU_R9_ONE_PPS_OUT_EN | ICE_CGU_R9_ONE_PPS_OUT_AMP);
	...
	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);

That path is reached from ice_ptp_write_perout() on the ptp_clock ioctl and
does not take pf->dplls.lock.  Can a perout enable be erased by the
source-change write, or a perout write based on the pre-change R9 snapshot
restore the old TIME_REF_EN/CLK_EREF0_EN/TIME_SYNC_EN after R23 has already
switched TIME_REF_SEL, leaving receiver and PLL source inconsistent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908222428.872254-1-anthony.l.nguyen%40intel.com
