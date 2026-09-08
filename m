Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF45452B2;
	Tue,  8 Sep 2026 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871527; cv=none; b=c/MPWkcYtQI1+btBDMkWU+bPPFtr7D1Asc/04SmA/IKd7OJY8OhrLng7p1fdhduKwCbuV/3QkvLYnz247xHJKqtNSlCkxuuaqXBQQgTWY94My3eYfNlyooHAZQ7/i8343w0x89GbPLFHyVhIfpwbGpDQatOl3MKMu9/4Pj0zyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871527; c=relaxed/simple;
	bh=qM4yHLFAiOCn/tLi4tH5Sw6E2GLHH+lqzcns8awzhNQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVt8L9CrqDBVjYcdNRozt8te7tTl3f8tpU3jhXAPHuXzUHMTeJ9PvWee5/mKR6sYyDna2zGAbd8B3fMrFYP7m0ClRhojWGA704OKZvHn7ECGTAbrgicKbNPgZtY4w7tjkX/TR6RXUeaf1bxpZS/551/03NSVtmwKUnhDqPYd0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD36B1F00A3F;
	Tue,  8 Sep 2026 12:45:23 +0000 (UTC)
Subject: Re: [PATCH net-next v8 10/15] dpll: sit9531x: add support to adjust
 output phase
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:22 +0000
Message-ID: <178887152267.219967.2296326775875022935@kernel.org>
In-Reply-To: <20260902214030.20955-11-arouhi@sitime.com>
References: <20260902214030.20955-11-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 7 · Low: 1

- [Medium] sit9531x_dpll_output_pin_phase_adjust_get()
  (drivers/dpll/sit9531x/dpll.c:753) returns the software cache…
- [Medium] A negative phase request is encoded as an absolute delay
  'T_out - (|phase| mod T_out)' using the output period in force at the…
- [Medium] sit9531x_output_phase_adjust_set() (core.c:1364-1366) rejects
  every request with -EINVAL when the cached output frequency…
- [Medium] The commit message presents the operation as shifting one
  output in time 'against the others driven by the same PLL', but…
- [Medium] Only the negative branch of sit9531x_output_phase_adjust_set()
  reduces the request modulo the output period; the positive branch…
- [Medium] The driver now installs .phase_adjust_get/.phase_adjust_set
  for output pins (dpll.c:789-796) but never populates struct…
- [Medium] The 34-bit PRG_RST_DELAY word is written as five independent
  I2C byte writes, most-significant first (core.c:1438-1478), and every…
- [Low] The newly added register-map comment in regs.h ('Outputs 0-5 are
  on Page 3, outputs 6-11 on Page 4.

--

dpll: sit9531x: add support to adjust output phase

This adds .phase_adjust_get/.phase_adjust_set for sit9531x output pins.  The
requested picosecond offset is split into a 34-bit coarse delay in VCO cycles
and a 3-bit fine field of 30 ps steps, written into the per-output
PROG6..PROG2 block from inside the PRG_CMD programming state.  The write is
followed by an on-demand phase flush on the owning PLL.

A few questions below about the register programming and about how the
value is reported back to userspace.

> dpll: sit9531x: add support to adjust output phase
>
> Shift an output in time against the others driven by the same PLL.  The
> device has a coarse delay counted in VCO cycles and a three-bit fine field
> in fixed thirty-picosecond steps, so a requested offset is split between
> the two and what the core reads back is what the registers hold rather
> than what was asked for.

[Severity: Medium]
Is the described scope of the operation complete?  The tail of
sit9531x_output_phase_adjust_set() calls:

	return sit9531x_output_phase_flush(sitdev, pll_idx);

and that helper's own comment says:

	 * Fires the chip's on-demand phase-flush (PHFL) so every output divider
	 * of @pll_idx restarts aligned to the PLL phase.

So adjusting one output also restarts the divider phase of every sibling
output on the same PLL, which looks like a phase step on clocks the user did
not touch.

The path also goes through sit9531x_prg_enter() (loops unlocked) and
sit9531x_prg_commit(), which writes SIT9531X_UPDATE_NVM, then
SIT9531X_LOOP_LOCK, then msleep(100).  Could the commit message mention the
NVM shadow write, the sibling-output phase restart, and the ~100 ms cost per
call?

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 0f886cfd1401..be033d7cfe7c 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1342,6 +1342,149 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
>   * output period, which is identical for a periodic signal.
>   */
>  
> +int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
> +				     u8 out_idx, s32 phase_ps)
> +{

[ ... ]

> +	freq = sitdev->out[out_idx].freq;
> +	if (!freq)
> +		return -EINVAL;

[Severity: Medium]
Should this bail out apply to every request?  freq is only consumed in the
negative branch below, yet a zero cache rejects phase_adjust = 0 and all
positive values too.

sitdev->out[].freq is only written in three places: sit9531x_prop_pin_get(),
sit9531x_output_freq_set() and sit9531x_output_freq_get().  In
sit9531x_prop_pin_get() it is seeded only when the pin fwnode was found and
lists frequencies:

	if (num_freqs <= 0) {
		num_freqs = 0;
		goto skip_fwnode_props;
	}
	...
		else
			sitdev->out[index].freq = (u32)freqs[0];

supported-frequencies-hz is optional in
Documentation/devicetree/bindings/dpll/dpll-pin.yaml ("required: - reg"), and
nothing seeds out[].freq at probe.  On a board whose DT omits it, does every
phase-adjust request return -EINVAL forever?  Would reading the frequency
back from the device, or restricting the check to the negative branch, be
better here?

> +
> +	fvco = sit9531x_get_fvco(sitdev, pll_idx);
> +	if (!fvco)
> +		return -EIO;
> +
> +	/*
> +	 * Convert to unsigned absolute delay.  Negative phase (advance)
> +	 * is rendered as T_out - |phase|, modulo the output period.
> +	 */
> +	if (phase_ps == 0) {
> +		abs_ps = 0;
> +	} else if (phase_ps > 0) {
> +		abs_ps = (u64)phase_ps;
> +	} else {
> +		u64 t_out_ps = div64_u64(1000000000000ULL, freq);
> +		u64 advance = (u64)(-(s64)phase_ps);
> +
> +		if (t_out_ps == 0)
> +			return -EINVAL;
> +		/*
> +		 * div64_u64_rem() rather than the % operator: a 64-bit
> +		 * modulo has no compiler helper on 32-bit targets and
> +		 * leaves the module with an undefined __umoddi3.
> +		 */
> +		div64_u64_rem(advance, t_out_ps, &advance);
> +		abs_ps = (advance == 0) ? 0 : (t_out_ps - advance);
> +	}

[Severity: Medium]
Should the positive branch also reduce modulo the output period?  The commit
message states:

    Delay only ever advances, so an offset larger than one output period is
    folded back into a single period -- for a periodic signal that is the same
    phase.

but only the negative branch performs that reduction; the positive branch
does abs_ps = (u64)phase_ps verbatim.

sit9531x_prop_pin_get() advertises the full window for outputs:

		props->dpll_props.phase_range.min = -1000000000; /* -1 ms in ps */
		props->dpll_props.phase_range.max =  1000000000; /* +1 ms in ps */

so +1000000 ps on a 10 MHz output (phase-equivalent to 0) programs millions
of VCO cycles of reset delay instead of at most one 100 ns period.  Since
PRG_RST_DELAY is a real reset delay applied when the divider restarts, does
that hold the output off for the whole interval rather than shifting its
phase?

[Severity: Medium]
A related question about the period-relative encoding: the value written here
depends on the output period in force at the time of the call, but nothing
recomputes it when the frequency changes later.

sit9531x_dpll_output_pin_frequency_set() -> sit9531x_output_freq_set() only
rewrites the DIVO bytes and then re-applies the phase reset:

	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
	if (rc)
		return rc;

	sitdev->out[out_idx].freq = (u32)div64_u64(fvco, divo);

A grep for phase_adjust in drivers/dpll/sit9531x/ shows no path that rewrites
PROG6..PROG2 or invalidates dpin->phase_adjust on a frequency change.  So
-100 ps at 10 MHz (encoded as ~99900 ps) becomes roughly +16567 ps after a
switch to 12 MHz, while the getter still reports -100 ps.  Should the delay be
reprogrammed from the cached request when the output frequency changes?

> +
> +	/*
> +	 * coarse_cycles = abs_ps * Fvco / 1e12 ps/s.
> +	 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches
> +	 * one second of 1 PPS wrap-around.
> +	 */
> +	coarse = mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);
> +	if (coarse >= (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))
> +		return -ERANGE;
> +
> +	/* Fine delay = round((abs_ps - coarse * vco_period_ps) / 30 ps) */
> +	coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +	rem_ps = (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;
> +	if (rem_ps) {
> +		u64 steps;
> +
> +		steps = div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,
> +				  SIT9531X_OUT_PRG_FINE_STEP_PS);
> +		if (steps > SIT9531X_OUT_PRG_FINE_MAX)
> +			steps = SIT9531X_OUT_PRG_FINE_MAX;
> +		fine = (u8)steps;
> +	}

[ ... ]

> +	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */
> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG(page, base),
> +			      &prog6_val);
> +	if (rc)
> +		goto commit;
> +
> +	prog6_val &= SIT9531X_OUT_PRG_OPSTG_MASK;
> +	prog6_val |= (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &
> +		     SIT9531X_OUT_PRG_FINE_MASK;
> +	prog6_val |= (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK);
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base),
> +			       prog6_val);
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 1),
> +			       (u8)((coarse >> 24) & 0xFF));
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 2),
> +			       (u8)((coarse >> 16) & 0xFF));
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 3),
> +			       (u8)((coarse >> 8) & 0xFF));
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 4),
> +			       (u8)(coarse & 0xFF));
> +
> +commit:
> +	/*
> +	 * Always leave the PRG_CMD state via prg_commit(), even on a
> +	 * mid-sequence write failure, so the output loops are re-locked rather
> +	 * than stranded unlocked; keep the first error.
> +	 */
> +	ret = sit9531x_prg_commit(sitdev);

[Severity: Medium]
Can a mid-sequence I2C failure commit a half-written delay word?  The 34-bit
field is written as five independent byte writes, most significant first, and
every failure jumps to the same label, where sit9531x_prg_commit()
unconditionally latches whatever is in the registers:

drivers/dpll/sit9531x/core.c:sit9531x_prg_commit() {
	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
			       SIT9531X_UPDATE_NVM);
	...
	rc2 = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
				SIT9531X_LOOP_LOCK);
}

With an old value of 0x00_0000_00FF and a new value of 0x00_FF00_0000, a
failure after the PROG5 write leaves 0xFF0000FF, about 4.28e9 VCO cycles,
which is far larger than either the old or the new intent and well past the
~7.8e6 cycles a 1 ms request can produce.

Nothing restores the previously read bytes, and
sit9531x_dpll_output_pin_phase_adjust_set() returns the error without
updating dpin->phase_adjust, so software keeps the old value while the device
holds the mixed one.  Would writing the arming byte last, or saving and
restoring the five original bytes before commit, bound this?

> +	if (ret && !rc)
> +		rc = ret;
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Restart the output divider phase so the freshly programmed delay is
> +	 * applied against a known edge instead of the divider's arbitrary
> +	 * running phase.
> +	 */
> +	return sit9531x_output_phase_flush(sitdev, pll_idx);
> +}
> +
>  /*
>   * sit9531x_clear_notifications - clear all notification registers
>   *
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 6365a83e4c52..c07fb2256510 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -736,12 +736,63 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustment
> + *
> + * returns cached value.
> + */
> +static int
> +sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,
> +					  void *pin_priv,
> +					  const struct dpll_device *dpll,
> +					  void *dpll_priv, s32 *phase_adjust,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +
> +	*phase_adjust = dpin->phase_adjust;
> +	return 0;
> +}

[Severity: Medium]
Does this match the commit message claim that "what the core reads back is
what the registers hold rather than what was asked for"?  The getter never
touches PROG6..PROG2; it returns the cache, and the setter below stores the
raw request into that cache.

sit9531x_output_phase_adjust_set() floors the coarse count and rounds and
clamps the residue, so the register value can differ from the request.  For
+10 ps at Fvco 5 GHz:

	coarse = mul_u64_u64_div_u64(10, 5000000000, 1000000000000) = 0
	steps  = div64_u64(10 + 15, 30) = 0

so no delay at all is programmed, yet DPLL_A_PIN_PHASE_ADJUST reports 10.

The cache also starts at 0 (kzalloc_obj() in sit9531x_dpll_pin_alloc()) and
is never seeded from the delay registers, so an NVM-preloaded delay reads back
as 0.  With that stale 0 the core drops a request to clear it:

drivers/dpll/dpll_netlink.c:dpll_pin_phase_adj_set() {
	...
	if (phase_adj == old_phase_adj)
		return 0;
	...
}

Would reading the registers back and returning the effective, quantised value
avoid both of these?

> +
> +/*
> + * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment
> + *
> + * Programs the per-output PRG_RST_DELAY registers for deterministic
> + * phase offset; see sit9531x_output_phase_adjust_set() in core.c.
> + */
> +static int
> +sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,
> +					  void *pin_priv,
> +					  const struct dpll_device *dpll,
> +					  void *dpll_priv, s32 phase_adjust,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "Phase adjust failed");
> +		return rc;
> +	}
> +
> +	dpin->phase_adjust = phase_adjust;
> +	return 0;
> +}
> +
>  static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>  	.direction_get		= sit9531x_dpll_output_pin_direction_get,
>  	.frequency_get		= sit9531x_dpll_output_pin_frequency_get,
>  	.frequency_set		= sit9531x_dpll_output_pin_frequency_set,
>  	.state_on_dpll_get	= sit9531x_dpll_output_pin_state_on_dpll_get,
>  	.state_on_dpll_set	= sit9531x_dpll_output_pin_state_on_dpll_set,
> +	.phase_adjust_get	= sit9531x_dpll_output_pin_phase_adjust_get,
> +	.phase_adjust_set	= sit9531x_dpll_output_pin_phase_adjust_set,
>  };

[Severity: Medium]
Now that output pins support phase adjustment, should
struct dpll_pin_properties::phase_gran be populated too?  A grep for
phase_gran under drivers/dpll/ matches only dpll_netlink.c and zl3073x/;
sit9531x_prop_pin_get() sets only the range:

		props->dpll_props.phase_range.min = -1000000000; /* -1 ms in ps */
		props->dpll_props.phase_range.max =  1000000000; /* +1 ms in ps */

Documentation/driver-api/dpll.rst says that when pin phase adjustment is
supported, minimal and maximal values and granularity shall be provided on
DPLL_CMD_PIN_GET via DPLL_A_PIN_PHASE_ADJUST_MIN/MAX/GRAN.  With phase_gran
left at 0 the core skips both the attribute and the validation:

drivers/dpll/dpll_netlink.c:dpll_msg_add_pin_props() {
	if (prop->phase_gran &&
	    nla_put_u32(msg, DPLL_A_PIN_PHASE_ADJUST_GRAN,
			prop->phase_gran))
}

drivers/dpll/dpll_netlink.c:dpll_pin_phase_adj_set() {
	if (pin->prop.phase_gran && phase_adj % (s32)pin->prop.phase_gran) {
}

Should phase_gran be set to SIT9531X_OUT_PRG_FINE_STEP_PS so userspace can
see the 30 ps quantum, as zl3073x does?

>  
>  const struct dpll_pin_ops *
> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index 031c1a460d4a..91d33abd15c3 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -189,6 +189,32 @@
>  #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)
>  #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3
>  
> +/*
> + * Per-output programmable phase delay: 34-bit coarse (in VCO clock
> + * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output
> + * has a five-byte block PROG6..PROG2:

[ ... ]

> + * Outputs 0-5 are on Page 3, outputs 6-11 on Page 4.  The block base
> + * within a page is 0x15 + 16 * (out_idx % 6).
> + */

[Severity: Low]
This isn't a bug, but the documented formula is in terms of the logical
output index while the code uses the physical slot:

	slot = info->clkout_map[out_idx];
	page = (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
	base = SIT9531X_OUT_PRG_DELAY_BASE +
	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);

With clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11}, out_idx 4 gives page 3 /
base 0x55 by the comment but page 4 / base 0x25 in the code.  The same
out_idx wording appears in the new block comment above
sit9531x_output_phase_adjust_set() in core.c.  Could both comments be reworded
in terms of the slot, matching the inline note "Page/base must address the
slot, not the logical index"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
