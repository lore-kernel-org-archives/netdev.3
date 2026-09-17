Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFF53A8A9;
	Thu, 17 Sep 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657338; cv=none; b=pqBpW2ebK2fGnLRFcHHl3K0KWRdb+3VXKfh4NRZ3LuYry5Nu59El0gI71s5qnHMzS49BHD6U4QGwbSROMr1TAm6CQtsU+lPVBhcvxBV1ZEFW0S9RKHG1F5bFtihjMn3P2Ztcmpe8nSSXW0oC/v8TbcecljN98gVU0nCe/XkUKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657338; c=relaxed/simple;
	bh=VRxzYZRLmUQTsgPwHyXCj06T0DuywkLrMO05wUa3LAA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYStRY6KDPalo/jSSTssZxZWq8Hn37vrDdJc/4R13GUDaipc6vsGFxaVdp2XXXVfiuhVHl9QuE8ClVlU7iOC16xpD2nIshEgstoaaxYNBgtTiK8Ven+SMwgbdWKaOHot/gexM+RxzIBcJ50GatBwXu/XuEQ2Dp2mXe1QVZN/hr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtrnKpCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtrnKpCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B14C1F008A2;
	Thu, 17 Sep 2026 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657314;
	bh=F/VjIbZt7310byV7oIr7RhP2VC6m/4QbhMNBGq3vJ7E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AtrnKpCu6IHZjxt0ovzsD9xuzs/g+XSChO3Q5cWj9A+ldBkhUJ3+AQsiB4bPx/BUm
	 vfC0zKbRUxsEOoydXXZSaAX/gCmOJeZ1rUMT/4wgBJh8Q7fLknvwy+jBqNeatES4v3
	 zFdHxem+zrfG4L5woSQ4kP3PHF2Eid1SyidAslNmwXH7/aLkIFpqJr4BaKLb8bR9P+
	 XzBZ8jeO59WrluF6JPSCuFW1CdYGKjYSRMcyexdANnNLKeIa7Vs0fDb4ZL5aUMhon7
	 QXjWH/+9jLfrGEm4ucckMY9ONew7qdMAu2osNLiadaExvvE9FpmYGFfaAYTnmrNPqX
	 kzKREKsRw1/Aw==
Subject: Re: [PATCH net-next v9 09/15] dpll: sit9531x: implement output pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:53 +0000
Message-ID: <178965731368.22033.17347004591457066845@kernel.org>
In-Reply-To: <20260915000015.80480-10-arouhi@sitime.com>
References: <20260915000015.80480-10-arouhi@sitime.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 1

- [Medium] The patch silently turns on DPLL registration of output pins.
- [Medium] sit9531x_dpll_output_pin_state_on_dpll_get()
  (drivers/dpll/sit9531x/dpll.c:763-772) discards the return value of…
- [Medium] sit9531x_output_hiz_write() (core.c:527-554) performs four
  independent read-modify-write register operations for a mute (DIFF…
- [Medium] The Hi-Z force/value register pair is written in a fail-unsafe
  order.
- [Low] Concern (validated as resolved later in this series, therefore
  discarded by the baseline decision): at this commit, registering…

--

dpll: sit9531x: implement output pin state on a DPLL

This adds state_on_dpll_get/set for sit9531x output pins, reporting an
output as connected while it drives and disconnected while it is muted.
Muting is done by forcing the pad to Hi-Z through the per-slot force/state
register pairs, with a cached mute state that is marked stale when the
post-write read-back fails.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index a83bf8ac83c1d..bba42fe302a3b 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -396,6 +396,47 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_output_state_refresh - read an output's mute state back
> + *
> + * Used when a mute could not be confirmed at the time it was written.  The
> + * driver does not poll output state, so without this the cached value would
> + * stand until something else happened to write it.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)
> +{
> +	bool muted;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	rc = sit9531x_output_forced_hiz(sitdev, out_idx, &muted);
> +	if (rc)
> +		return rc;
> +
> +	sitdev->out[out_idx].enabled = !muted;
> +	sitdev->out[out_idx].state_stale = false;
> +
> +	return 0;
> +}
> +
> +static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,
> +				unsigned int reg, u8 bit, bool set)
> +{
> +	u8 cur, new_val;
> +	int rc;
> +
> +	rc = sit9531x_read_u8(sitdev, reg, &cur);
> +	if (rc)
> +		return rc;
> +
> +	new_val = set ? (cur | BIT(bit)) : (cur & ~BIT(bit));
> +
> +	return sit9531x_write_u8(sitdev, reg, new_val);
> +}
> +

[ ... ]

> @@ -474,6 +515,166 @@ static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
>  	return rc2 ? rc2 : rc3;
>  }
>  
> +/*
> + * sit9531x_output_hiz_write - mute or unmute an output
> + *
> + * Muting takes control of the pin (MASK=1) and drives it low (STATE=0) on
> + * both the differential and the single-ended register pair, because the
> + * output must go quiet whichever way it is wired; unmuting hands it back
> + * to the device's own state machine.  The caller must already be in the
> + * programming state.
> + */
> +static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,
> +				     bool mute)
> +{
> +	struct sit9531x_hiz_regs r;
> +	int rc;
> +
> +	sit9531x_output_get_hiz_regs(slot, &r);
> +
> +	if (!mute) {
> +		rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);
> +		if (rc)
> +			return rc;
> +
> +		return sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);
> +	}
> +
> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);
> +	if (rc)
> +		return rc;
> +
> +	return sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);
> +}

[Severity: Medium]
Should sit9531x_output_hiz_write() unwind the bits it already wrote when
one of the four register operations fails?

Each of the four steps is an independent read-modify-write, and the
function returns on the first error, so a failure after step one leaves
r.diff_mask with the override-enable bit set while r.diff_state was never
programmed, and a failure after step three leaves r.se_mask set with
r.se_state untouched.

The caller then commits that half-programmed pair anyway:

	rc = sit9531x_output_hiz_write(sitdev, slot, true);
	...
	ret = sit9531x_prg_commit(sitdev);
	if (ret && !rc)
		rc = ret;

Nothing afterwards clears the MASK bit that was set, so a mute request can
leave the pad's override armed with a forced value that comes from the
loaded configuration blob rather than from this request.

The residue is also invisible to the driver's own read-back, since
sit9531x_output_forced_hiz() only inspects the pair matching out[].cmos:

	if (sitdev->out[out_idx].cmos) {
		mask_reg = r.se_mask;
		state_reg = r.se_state;
	} else {
		mask_reg = r.diff_mask;
		state_reg = r.diff_state;
	}

so a differential output whose SE writes failed reads back as cleanly muted
while a stale SE override stays armed on the same slot.

sit9531x_output_divo_write() in this same file already restores the bytes it
managed to write on its rollback: path before committing.  Would the same
approach fit here?

[Severity: Medium]
Is the write order of the pair fail-safe?  MASK (the override enable) is
asserted before STATE (the forced value) on both pairs:

	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
	if (rc)
		return rc;
	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);

By the driver's own decoding in sit9531x_output_forced_hiz(), muted means
MASK set and STATE clear, so the intermediate MASK=1/STATE=1 combination is
a driver-asserted override that pins the pad driven.  The previous STATE
value comes from the initial-config blob, and the un-mute path clears only
MASK without normalising STATE:

	if (!mute) {
		rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);
		if (rc)
			return rc;

		return sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);
	}

so STATE=1 at the moment MASK is set looks possible.

In the success case the pad then sits under a wrong-valued override for one
I2C transaction; if the STATE write fails, sit9531x_prg_commit() still runs
and MASK=1/STATE=1 becomes the committed configuration, i.e. the pad is
forced driving as the outcome of a mute request, and
sit9531x_output_forced_hiz() reports it as not muted.

Would programming STATE first and MASK second (STATE being inert while MASK
is clear) avoid the intermediate and the persistent case?

> +
> +/*
> + * sit9531x_output_disable - mute an output (force Hi-Z)
> + * @index:	logical output index (0..info->num_outputs-1)
> + *
> + * Sets MASK and clears STATE on BOTH the DIFF and SE register pairs so that the
> + * output is muted regardless of its electrical configuration.  The
> + * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence
> + * so the new state is applied by the hardware.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)
> +{
> +	const struct sit9531x_chip_info *info = sitdev->info;
> +	bool muted;
> +	u8 slot;
> +	int rc, ret, state_rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (index >= info->num_outputs)
> +		return -EINVAL;
> +
> +	slot = info->clkout_map[index];
> +	rc = sit9531x_prg_enter(sitdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = sit9531x_output_hiz_write(sitdev, slot, true);
> +
> +	/*
> +	 * Always leave the PRG_CMD programming state, even on a mid-sequence
> +	 * write failure: prg_enter() unlocked the output loops, so returning
> +	 * without prg_commit() would strand the chip in the programming state
> +	 * with the loops unlocked.  Best effort -- keep the first error.
> +	 */
> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	/*
> +	 * Keep the software state aligned to what hardware now drives even
> +	 * when one write in the sequence failed. The commit above may have
> +	 * applied a partial mask/state combination.
> +	 */
> +	state_rc = sit9531x_output_forced_hiz(sitdev, index, &muted);
> +	if (!state_rc) {
> +		sitdev->out[index].enabled = !muted;
> +		sitdev->out[index].state_stale = false;
> +	} else {
> +		/*
> +		 * The writes may well have landed; what failed is the proof.
> +		 * Mark the cached state for a read-through rather than
> +		 * reporting the value it had before this call.
> +		 */
> +		sitdev->out[index].state_stale = true;
> +		if (!rc)
> +			rc = state_rc;
> +	}
> +
> +	return rc;
> +}
> +

[ ... sit9531x_output_enable() snipped, same structure ... ]

> @@ -2455,13 +2658,23 @@ static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll,
>  {
>  	struct sit9531x_dev *sitdev = sitdpll->dev;
>  
> -	if (dir != DPLL_PIN_DIRECTION_INPUT)
> +	if (dir == DPLL_PIN_DIRECTION_INPUT) {
> +		if (index == SIT9531X_MAX_INPUTS)
> +			return true;
> +		if (index == SIT9531X_INTSYNC_PIN_ID)
> +			return false;
> +
> +		return sit9531x_input_pin_is_registrable(sitdev, index);
> +	}
> +
> +	if (index == SIT9531X_INTSYNC_OUT_PIN_ID)
>  		return false;
>  
> -	if (index == SIT9531X_MAX_INPUTS)
> -		return true;
> +	if (index >= sitdev->info->num_outputs)
> +		return false;
>  
> -	return sit9531x_input_pin_is_registrable(sitdev, index);
> +	return sitdev->out[index].pll_idx == sitdpll->id &&
> +	       sitdev->out[index].routed;
>  }

[Severity: Medium]
Could the commit message mention that this hunk starts registering output
pins with the DPLL core?

Before this change sit9531x_dpll_pin_is_registrable() returned false for
every non-input direction, so sit9531x_dpll_pins_register() skipped all
output ids:

		if (!sit9531x_dpll_pin_is_registrable(sitdpll, dir, id))
			continue;

and no output pin was ever passed to dpll_pin_register().  After it, every
routed output whose pll_idx matches the DPLL is registered, which makes the
whole sit9531x_dpll_output_pin_ops table reachable for the first time,
including .frequency_set added by the earlier "add support to get and set
frequency on pins" patch, plus the output pin properties built by
sit9531x_pin_props_get().

The changelog describes only the new state_on_dpll_get/set, so the fact
that output pins begin to appear in pin dumps and become settable from
userspace is not documented.

As an aside, the earlier "register DPLL devices and pins" commit already
claimed to register "the outputs the loaded configuration routes to a PLL",
which its code did not do; this hunk is what implements it.

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 1ab8ebfd78da1..db9c73a79b041 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -100,6 +100,8 @@ struct sit9531x_ref {
>   * @enabled:		output is driving, i.e. not forced into Hi-Z
>   * @cmos:		output is wired single-ended; the Hi-Z pair that
>   *			speaks for it is the SE one, not the differential
> + * @state_stale:	the cached mute state could not be confirmed against
> + *			hardware and has to be read back before it is reported
>   * @routed:		output is mapped to @pll_idx by the initial
>   *			configuration; an unrouted output has no DPLL pin
>   * @pll_idx:		PLL driving this output (0-3)

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 88122a368053c..d550eb626e6de 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -736,10 +736,91 @@ sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state
> + *
> + * reports CONNECTED when the output is driven and
> + * DISCONNECTED when it has been muted via sit9531x_output_disable().
> + */
> +static int
> +sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,
> +					   void *pin_priv,
> +					   const struct dpll_device *dpll,
> +					   void *dpll_priv,
> +					   enum dpll_pin_state *state,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	const struct sit9531x_out *out;
> +
> +	/*
> +	 * A mute whose read-back failed left the cache unconfirmed; there is
> +	 * no poll of output state to correct it, so read it here rather than
> +	 * report a value that may predate the request.
> +	 */
> +	if (sitdev->out[dpin->id].state_stale) {
> +		mutex_lock(&sitdev->multiop_lock);
> +		sit9531x_output_state_refresh(sitdev, dpin->id);
> +		mutex_unlock(&sitdev->multiop_lock);
> +	}
> +
> +	out = sit9531x_out_state_get(sitdev, dpin->id);
> +	*state = out->enabled ? DPLL_PIN_STATE_CONNECTED
> +			      : DPLL_PIN_STATE_DISCONNECTED;
> +	return 0;
> +}

[Severity: Medium]
Should the return value of sit9531x_output_state_refresh() be propagated
here?

When the read-back fails, sit9531x_output_state_refresh() returns the error
from sit9531x_output_forced_hiz() without touching out[].enabled and
without clearing out[].state_stale:

	rc = sit9531x_output_forced_hiz(sitdev, out_idx, &muted);
	if (rc)
		return rc;

	sitdev->out[out_idx].enabled = !muted;
	sitdev->out[out_idx].state_stale = false;

The getter drops that error and still emits the cached value with return 0,
so a pin whose drive state is unknown is reported to userspace as an
authoritative connected/disconnected with no extack.

The sequence would be: pin_set state=DISCONNECTED reaches
sit9531x_output_disable(), its post-commit read fails and sets
out[].state_stale = true while out[].enabled still holds the pre-request
value; the next pin_get sees state_stale, the refresh fails again on the
same broken bus, and the pre-request value is reported as success.

That also contradicts the field's own kernel-doc, which says the cached
mute state "has to be read back before it is reported", and the comment
above the call, which says it reads it "rather than report a value that may
predate the request".

Other getters in this driver do propagate such failures:
sit9531x_dpll_output_pin_frequency_get() returns rc, and
sit9531x_dpll_input_pin_phase_offset_get() sets an extack and returns rc.
This is still the case at the end of the series.

[ ... sit9531x_dpll_output_pin_state_on_dpll_set() snipped ... ]

>  static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>  	.direction_get		= sit9531x_dpll_output_pin_direction_get,
>  	.frequency_get		= sit9531x_dpll_output_pin_frequency_get,
>  	.frequency_set		= sit9531x_dpll_output_pin_frequency_set,
> +	.state_on_dpll_get	= sit9531x_dpll_output_pin_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_output_pin_state_on_dpll_set,
>  };

[Severity: Low]
This one is resolved later in the same series, but worth noting for
bisectability: at this commit the newly registered output pins advertise a
phase-adjust window while no callback implements it.

The output branch of sit9531x_pin_props_get() in prop.c publishes:

		props->dpll_props.phase_range.min = -1000000000; /* -1 ms in ps */
		props->dpll_props.phase_range.max =  1000000000; /* +1 ms in ps */
		...
		props->dpll_props.phase_gran = 1;

while sit9531x_dpll_output_pin_ops above has neither .phase_adjust_get nor
.phase_adjust_set, so a pin_set(phase-adjust) inside the advertised range
answers -EOPNOTSUPP.  core.h also declares sit9531x_output_phase_adjust_set()
with no definition in the tree at this point.

The next patch, "dpll: sit9531x: add support to adjust output phase", adds
both callbacks and defines that function, so the gap only exists between
these two commits.  Would reordering, or folding, keep each commit
self-consistent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
