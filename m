Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20A4848A2;
	Thu, 17 Sep 2026 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657357; cv=none; b=RZo83vlNpPgWTcUAZApSY2lI4Fwd78zDUMWa2bkOhj5qYFs7hawph1j5XY8Wq2GYyB+ytuGOmd+e+NxUygjirrQVebAnMGUuS41tAAmqxQTp5C1QQhYufC+Nl/sbv7FmEhLsFndg7Bq8MHE7YMR/rPl2F/XuMB+DOfvgbdHQTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657357; c=relaxed/simple;
	bh=CmMMwBvq/kDNTYTwWWLOEArvyYA2+0u72Ps9xE35A5Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvuQQb+Xf67Ws9retne1xycvWsbywybde41aPCtO4jIMpettrYmDheAiENYSu2UjIg0NeawJhrRSuVt92FG2G5PPWEJUORnYHzlyjEu2JQR1Vj3OyBZuZy5Z8NXWj1XilKVeXvj8g37NZs3llaCYK2bp32RQZ29x7Ei/2i5c0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNeT0Cw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNeT0Cw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EEC1F00899;
	Thu, 17 Sep 2026 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657316;
	bh=oUNNlHWMyyB3kvdQMxgnrqPnfHk0XTZCn1hZNApvK5E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nNeT0Cw/qwOpG3LKyYULYKAQmrUurxejkK96pvU27i+499RzuRubuEytyWK3x2U91
	 iy7+xiQuV59Z0LI0OfqyJdQ0+tsCqgmyS2BFLDZc9cdNi82cqGautq05aYR/OaCYJE
	 3i4KoUE2UkAVhIC/+ZJclTMGiGB2iwnS2vZz0MSNR/rGRY9/8/c0/rhukDO0+SBECC
	 P2QuX2E8k8ni4TglqNzmY/2FXMqIu5/Pbw9b2F0aQjBCGAd8zh2H6g1HntVLJdW2hV
	 cJcmFvIFDeR1VE6i2Rtvr/3CGdnmrvY+tjl69B2VnRIF/F7MOufjodDAIZiL6xuM4X
	 F0SD1Z40hPUUQ==
Subject: Re: [PATCH net-next v9 12/15] dpll: sit9531x: add support to get
 phase offset on the connected input pin
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:55 +0000
Message-ID: <178965731504.22033.16886236332110416318@kernel.org>
In-Reply-To: <20260915000015.80480-13-arouhi@sitime.com>
References: <20260915000015.80480-13-arouhi@sitime.com>
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

Critical: 0 · High: 0 (1) · Medium: 4 · Low: 6

- [Medium] sit9531x_dpll_input_pin_phase_offset_get() publishes a TDC
  reading as DPLL_A_PIN_PHASE_OFFSET without checking the hardware…
- [Medium] In-band error overloading defeats two documented contracts.
- [Medium] The 35-bit TDC magnitude assembled from five raw register
  reads is used unvalidated as the numerator of…
- [Medium] sit9531x_dpll_input_pin_phase_offset_get() decides which pin a
  TDC sample belongs to from the driver's cached channel state, but the…
- [Low] The new comment block in
  sit9531x_dpll_input_pin_phase_offset_get() claims 'the open-loop…
- [Low] Dead and internally inconsistent debug-window register
  definitions in regs.h.
- [Low] Dead store into cached state: every path of
  sit9531x_dpll_input_pin_phase_offset_get() writes the measured value…
- [Low] Duplicate macros for the same register offset and the same magic
  key values.
- [Low] The new comment in sit9531x_dpll_input_pin_phase_offset_get()
  states 'The framework expects successive values to be averaged, which…
- [Low] sit9531x_phase_offset_read() programs two persistent pieces of
  PLL-page debug state but restores neither: it sets…

Pre-existing issues:
- [High] Recursive acquisition of the global dpll_lock:
  sit9531x_dpll_input_pin_prio_set() calls dpll_pin_change_ntf() for the…

--

dpll: sit9531x: add support to get phase offset on the connected input pin

This adds a .phase_offset_get callback for sit9531x input pins, backed by
a new core helper that unlocks the PLL page debug window, points the
readback mux at the on-chip time-to-digital converter and assembles a
35-bit sample plus sign into picoseconds using Fvco.  Non-selected pins
and PLLs without a programmed divider report zero.

A few questions below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 46179a9e13c32..356d1eac4ec54 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2132,6 +2132,154 @@ int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_phase_offset_read - read phase difference via TDC
> + * @phase_ps:	output phase difference in picoseconds
> + *
> + * Reads the Time-to-Digital Converter (TDC) signed 35-bit code from the
> + * PLL page registers, then converts to picoseconds using the VCO
> + * frequency: phase_diff = tdc_code / fvco.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       s64 *phase_ps)
> +{
> +	u64 fvco, mag_ps;
> +	s64 tdc_signed;
> +	u64 tdc_raw;
> +	int rc, lock_rc, i;
> +	bool sign;
> +	u8 v;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +
> +	/* Unlock the debug page so the TDC registers are accessible. */
> +	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
> +				   SIT9531X_PLL_REG_DEBUG,
> +				   SIT9531X_PLL_DEBUG_UNLOCK);
> +	if (rc)
> +		goto relock;
> +
> +	/*
> +	 * Select the debug clock for taps below 200 kHz, then point the
> +	 * readback at the TDC.  Only the one bit is touched: writing the
> +	 * modifier register whole would clear the fields belonging to
> +	 * other taps.
> +	 */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_DBG_WRITE_CODE,
> +				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,
> +				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);
> +	if (rc)
> +		goto relock;
> +	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
> +				   SIT9531X_PLL_REG_DBG_READ_CODE,
> +				   SIT9531X_DBG_READ_CODE_TDC);
> +	if (rc)
> +		goto relock;

[Severity: Low]
Should the previous contents of Dig_Sys_WriteCode (PLL 0xB4) and
Dig_Sys_ReadCode (PLL 0xB3) be saved and restored here?

sit9531x_phase_offset_read() sets SIT9531X_DBG_LOW_FREQ_CLK_BIT and
overwrites the read code with the TDC tap, but the relock epilogue only
rewrites the key register:

	lock_rc = sit9531x_write_pll_u8(sitdev, pll_idx,
					SIT9531X_PLL_REG_DEBUG,
					SIT9531X_PLL_DEBUG_LOCK);

So after the first pin-get on a connected input the PLL is left with a
debug sampling clock selected and the readback mux parked on read code
69, with the key re-locked so nothing can observe it.

sit9531x_output_phase_flush() takes the opposite approach for
PHFL_ON_DEMAND_EN, with the comment that leaving it set would be
"exactly the persistent side effect the one-shot sequence must not
have".

The later series commit "dpll: sit9531x: add support to get fractional
frequency offset" states the same hardware property ("The device never
clears the bit, so a read that left it to whatever the previous one set
would depend on the order the taps happened to be read in") and works
around it in sit9531x_dbg_sample(), but sit9531x_phase_offset_read()
itself is unchanged at the end of the series.

> +
> +	/*
> +	 * Latch a sample by reading the trigger register.  A single
> +	 * read returns the previous latch, so read it three times as
> +	 * the documented phase-difference procedure does.
> +	 */
> +	for (i = 0; i < SIT9531X_DBG_LATCH_READS; i++) {
> +		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);
> +		if (rc)
> +			goto relock;
> +	}
> +
> +	tdc_raw = 0;
> +
> +	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +				  SIT9531X_PLL_REG_DBG_DATA_4, &v);
> +	if (rc)
> +		goto relock;
> +	sign = !!(v & BIT(SIT9531X_TDC_SIGN_BIT));
> +	tdc_raw = (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;
> +

[ ... reads of DBG_DATA_3 .. DBG_DATA_0 snipped ... ]

> +	/*
> +	 * Apply sign.  Per the register map the sign bit is active-high
> +	 * for a positive offset: bit set -> +code, bit clear -> -code.
> +	 */
> +	tdc_signed = sign ? (s64)tdc_raw : -(s64)tdc_raw;
> +
> +	/*
> +	 * Get VCO frequency for conversion.  -ENODATA means DIVN is not
> +	 * programmed (PLL unused on this board) -- skip silently rather
> +	 * than spamming the log on every poll cycle.  A register access
> +	 * failure is returned as an error, not folded into a fabricated
> +	 * 0 ps measurement.
> +	 */
> +	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +	if (rc == -ENODATA) {
> +		dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",
> +			'A' + pll_idx);
> +		rc = -ENODEV;
> +		goto relock;
> +	}
> +	if (rc)
> +		goto relock;

[Severity: Medium]
Can a bus error reach userspace as a valid 0 ps measurement here?

The private "no data" condition is re-encoded as -ENODEV, and the
netlink caller then treats any -ENODEV as "no programmed DIVN":

drivers/dpll/sit9531x/dpll.c:sit9531x_dpll_input_pin_phase_offset_get() {
	if (rc == -ENODEV) {
		dpin->phase_offset = 0;
		*phase_offset = 0;
		return 0;
	}
}

-ENODEV is also an errno the regmap/I2C layer produces (for instance a
USB-attached I2C adapter that has been unplugged), and
sit9531x_read_u8()/sit9531x_write_u8() pass regmap's errno through
verbatim.  A register access failure inside this function, or inside
sit9531x_get_fvco(), would then be reported as a successful zero
reading with nothing logged.

That seems to contradict both the comment just above ("A register access
failure is returned as an error, not folded into a fabricated 0 ps
measurement") and sit9531x_get_fvco()'s own kernel-doc ("A bus failure
is never folded into the -ENODATA case, so callers can fail a request
instead of acting on a guessed rate").

Would propagating -ENODATA to the caller, and matching on that instead,
keep those two contracts intact?

> +
> +	/*
> +	 * phase_diff (seconds) = tdc_code / fvco
> +	 * phase_diff (ps) = tdc_code * 1e12 / fvco
> +	 *
> +	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing
> +	 * by whole MHz instead would lose up to ~40 ppm of scale on a
> +	 * fractional-DIVN Fvco.
> +	 */
> +	mag_ps = mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,
> +				     1000000000000ULL, fvco);
> +	*phase_ps = tdc_signed < 0 ? -(s64)mag_ps : (s64)mag_ps;

[Severity: Medium]
Does this division need a lower bound on fvco?

The numerator comes straight from five register reads and can be up to
0x7FFFFFFFF (about 3.44e10).  sit9531x_get_fvco() only rejects
divn <= 0 and a product that truncates to zero, so a garbage or
partially programmed DIVN (int_part 0 with a small fracn over a large
fracd) can return an fvco of a few Hz.  With a full-scale code the u64
quotient overflows once fvco drops below roughly 1.9 kHz, and the x86
helper traps in that case:

arch/x86/include/asm/div64.h:mul_u64_add_u64_div_u64() {
	/*
	 * Will generate an #DE when the result doesn't fit u64, could fix with an
	 * __ex_table[] entry when it becomes an issue.
	 */
}

The sibling helper guards against exactly this class of input:

drivers/dpll/sit9531x/core.c:sit9531x_pll_ffo_ppt() {
	if (configured < SIT9531X_DIVN_SCALE)
		return -ENODATA;
}

There is a second overflow further along the path.  In
sit9531x_dpll_input_pin_phase_offset_get():

	offset *= DPLL_PHASE_OFFSET_DIVIDER;

This is unchecked, so mag_ps above roughly 9.2e15 ps (reachable with an
fvco of a few MHz and a large code) overflows s64 before the value is
put in the netlink attribute.

> +
> +	rc = 0;
> +
> +relock:
> +	/*
> +	 * Close the debug window again.  The key register opens every debug
> +	 * register on this PLL while it holds the unlock value, and this read
> +	 * runs on every pin-get of a connected input, so leaving it open
> +	 * would mean normal monitoring permanently unlocks the block.
> +	 */
> +	lock_rc = sit9531x_write_pll_u8(sitdev, pll_idx,
> +					SIT9531X_PLL_REG_DEBUG,
> +					SIT9531X_PLL_DEBUG_LOCK);
> +	if (lock_rc && !rc)
> +		rc = lock_rc;
> +
> +	return rc;
> +}
> +
>  /*
>   * sit9531x_ref_state_fetch - read input reference status from hardware
>   * @index:	logical input index
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 0cad081eb5995..1dfd83b635e23 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -603,6 +603,107 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference
> + *
> + * What this reports, and what it deliberately does not:
> + *
> + * The ABI defines the attribute as the phase difference between the signal
> + * on a pin and its parent DPLL device, so this is the loop's own residual
> + * error, sampled with the loop closed.  On a locked DPLL it therefore
> + * trends small -- that is the measurement, not an artefact of it.  The
> + * framework expects successive values to be averaged, which suits a
> + * closed-loop residual and not a one-shot open-loop capture.

[Severity: Low]
This isn't a bug, but does the framework actually average anything?

drivers/dpll/dpll_netlink.c:dpll_msg_add_phase_offset() calls
ops->phase_offset_get() once and puts the returned value straight into
the message; it keeps no history:

	ret = ops->phase_offset_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
				    dpll, dpll_priv(dpll), &phase_offset,
				    extack);
	if (ret)
		return ret;
	if (nla_put_64bit(msg, DPLL_A_PIN_PHASE_OFFSET, ...))

Documentation/driver-api/dpll.rst says the reported value "may be
computed as the average of prior values and the current measurement",
tied to the device-configured DPLL_A_PHASE_OFFSET_AVG_FACTOR attribute,
which this driver does not implement.  Returning raw samples is fine,
but the comment states an expectation the core does not have.

> + *
> + * The chip can also measure the reference against the local oscillator
> + * with the outer loop's correction frozen, which is a different quantity
> + * and the one the documented phase-difference procedure produces.  That
> + * needs the digital loop filter held (and, on the 1PPS PLL, the automatic
> + * phase- and frequency-lock helpers held off), which leaves the PLL
> + * undisciplined until it is released.  A netlink read must not do that,
> + * so the open-loop measurement lives in a debugfs helper that owns the
> + * freeze and restores it; it is not this callback.

[Severity: Low]
Which debugfs helper does this refer to?  A grep for "debugfs" under
drivers/dpll/sit9531x/ at this commit returns only this comment line,
and the same is true at the end of the series: there is no debugfs
registration, no file operations and no loop-filter freeze/restore code
in the driver.  Should this paragraph be dropped or reworded until such
a helper exists?

> + *
> + * Precondition, which this callback cannot create: the TDC compares
> + * against a signal the PLL drives, so a PLL driving no output with its
> + * zero-delay buffer off has nothing to measure.  SiTime confirms this is
> + * a property of the hardware rather than of their measurement script.
> + * The script satisfies it by mapping a spare output and restarting the
> + * PLL -- side effects that do not belong in a getter, so a reading taken
> + * in that state is simply not meaningful.

[Severity: Medium]
If a reading taken in that state is not meaningful, should the callback
refuse to publish one?

sit9531x_dpll_input_pin_phase_offset_get() gates only on the cached
DPLL_PIN_STATE_CONNECTED selection state and on the -ENODEV (no DIVN)
case.  Nothing checks that the PLL drives an enabled output, and
nothing reads SIT9531X_PLL_ZDB_EN_BIT -- that macro is defined in
regs.h but referenced nowhere in core.c or dpll.c, here or at the end
of the series.

So a locked PLL with a programmed DIVN, all outputs muted and the
zero-delay buffer off returns rc == 0 and whatever the debug data
registers happen to hold is emitted as DPLL_A_PIN_PHASE_OFFSET.  The
attribute carries no validity marker, so userspace cannot tell that
value from a real measurement.

The commit message describes only the connected/non-connected
distinction ("Only the input a PLL has actually selected has a phase
offset against it") and does not mention this precondition.

> + *
> + * Non-selected pins and a PLL with no programmed divider report zero
> + * rather than an error: the DPLL core propagates any error from this
> + * callback and fails the whole pin dump with it, unlike the frequency
> + * offset getter, where -ENODATA makes the core omit the attribute.  There
> + * is no per-pin "no data" for phase offset, so it is a value or no
> + * callback at all.
> + */

[ ... function prologue snipped ... ]

> +	/*
> +	 * The on-chip TDC is a per-PLL resource that always measures the
> +	 * phase difference between the VCO and the PLL's currently
> +	 * selected reference; it cannot be pointed at an arbitrary input.
> +	 * For any input that is not the active reference there is no
> +	 * meaningful per-pin phase offset, so report 0 instead of the
> +	 * active reference's value.
> +	 */
> +	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);
> +	if (state != DPLL_PIN_STATE_CONNECTED) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		dpin->phase_offset = 0;
> +		*phase_offset = 0;
> +		return 0;
> +	}
> +
> +	rc = sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
Can this attribute a live TDC sample to the wrong pin?

sit9531x_dpll_selection_state_get() is a pure cache reader:

	chan = sit9531x_chan_state_get(sitdev, sitdpll->id);
	active_input = !chan->mode && chan->locked && !chan->inner_lol &&
		       chan->selected_ref == pin_id;

chan->selected_ref is written only by the monitor path, in
sit9531x_chan_state_fetch():

	chan->selected_ref =
		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);

and that monitor requeues itself twice a second:

	/* Run twice a second */
	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,
				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));

multiop_lock serialises the driver's register accesses, but it does not
stop the device from re-selecting a reference on its own (priority
selection, input failure, revert).  So:

  monitor caches selected_ref = IN0
  hardware fails over to IN1
  userspace issues DPLL_CMD_PIN_GET within the next ~500 ms

For IN0 the cache still says CONNECTED, and the TDC sample (the VCO
versus IN1 residual) is published as IN0's phase offset, while IN1
reports 0.

Would reading the live selected-reference register under multiop_lock
next to the TDC sample, and publishing only if it still names this pin,
close that window?

> +
> +	/*
> +	 * -ENODEV means the PLL has no programmed DIVN (unused on this
> +	 * board); report phase_offset = 0 so a full pin-get dump does not
> +	 * fail just because one DPLL is dormant.
> +	 */
> +	if (rc == -ENODEV) {
> +		dpin->phase_offset = 0;
> +		*phase_offset = 0;
> +		return 0;
> +	}
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "TDC phase readback failed");
> +		return rc;
> +	}
> +

[ ... unit-scaling comment snipped ... ]

> +	offset *= DPLL_PHASE_OFFSET_DIVIDER;
> +
> +	dpin->phase_offset = offset;
> +	*phase_offset = offset;
> +	return 0;
> +}
> +

[Severity: Low]
Is dpin->phase_offset read anywhere?

All three paths of sit9531x_dpll_input_pin_phase_offset_get() store into
struct sit9531x_dpll_pin::phase_offset, documented in dpll.h as
"in 1/DPLL_PHASE_OFFSET_DIVIDER picosecond units", but a grep for
phase_offset under drivers/dpll/sit9531x/ finds only these assignments
plus the member declaration, at this commit and at the end of the
series.

The per-DPLL monitor does compare cached pin state and notify:

drivers/dpll/sit9531x/dpll.c:sit9531x_dpll_changes_check() {
			pin->pin_state = state;
			dpll_pin_change_ntf(pin->dpll_pin);
}

but it never samples or compares the phase offset, so there is no
phase-offset change notification and the cached field has no consumer.

>  static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	.direction_get		= sit9531x_dpll_input_pin_direction_get,
>  	.frequency_get		= sit9531x_dpll_input_pin_frequency_get,
> @@ -610,6 +711,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	.state_on_dpll_set	= sit9531x_dpll_input_pin_state_on_dpll_set,
>  	.prio_get		= sit9531x_dpll_input_pin_prio_get,
>  	.prio_set		= sit9531x_dpll_input_pin_prio_set,
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue and was not introduced by this patch --
it comes from the earlier series patch "dpll: sit9531x: add support to
get and set priority on input pins" -- but can the prio_set callback
reached through this table deadlock on dpll_lock?

DPLL_CMD_PIN_SET is registered with a locking pre_doit:

drivers/dpll/dpll_nl.c {
		.cmd		= DPLL_CMD_PIN_SET,
		.pre_doit	= dpll_pin_pre_doit,
}

drivers/dpll/dpll_netlink.c:dpll_pin_pre_doit() {
	mutex_lock(&dpll_lock);
	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_PIN_ID)) {
}

and the callback then calls the locking notification helper for every
sibling whose slot changed:

drivers/dpll/sit9531x/dpll.c:sit9531x_dpll_input_pin_prio_set() {
	while (changed_cnt--)
		dpll_pin_change_ntf(changed[changed_cnt]);
}

drivers/dpll/dpll_netlink.c:dpll_pin_change_ntf() {
	mutex_lock(&dpll_lock);
	ret = __dpll_pin_change_ntf(pin);
	mutex_unlock(&dpll_lock);
}

That re-acquires a mutex the same task already holds, on essentially
every successful priority set.  The core provides
__dpll_pin_change_ntf() for callers already under dpll_lock, and
zl3073x uses that variant from its pin callbacks.  Would switching to
__dpll_pin_change_ntf() here be correct?  The current code is still
present at the end of the series.

>  	.phase_offset_get	= sit9531x_dpll_input_pin_phase_offset_get,
>  };
>  
>  /*
> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index 9d515e109feb5..08eae8a2c279a 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -271,6 +271,44 @@
>  #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */
>  #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */
>  
> +/* Debug register unlock */
> +#define SIT9531X_PLL_REG_DEBUG		0xBD
> +#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3
> +#define SIT9531X_PLL_DEBUG_LOCK			0x00

[Severity: Low]
This isn't a bug, but the same offset and the same two key values are
already spelled out in this header, with a comment saying the register
is page-independent:

/* Debug register (same offset, per-page) */
#define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)
#define SIT9531X_DEBUG_UNLOCK_VAL		0xC3
#define SIT9531X_DEBUG_LOCK_VAL			0x00

Could the new PLL-page macros reuse those key values instead of
duplicating 0xBD/0xC3/0x00, so the two copies cannot diverge later?

> +
> +/*
> + * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects
> + * which point of the pathway is tapped, Dig_Sys_WriteCode carries the
> + * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes
> + * and the trigger register latches a sample.  The TDC phase
> + * measurement is one tap among several, reached through read code 69.
> + */
> +#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3
> +#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4
> +#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)
> +#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */
> +#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */
> +#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */
> +#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */
> +#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */
> +#define SIT9531X_PLL_REG_DBG_DATA_5		0xBA  /* [47:40] */
> +#define SIT9531X_PLL_REG_DBG_DATA_6		0xBB
> +#define SIT9531X_PLL_REG_DBG_DATA_7		0xBC

[Severity: Low]
Two small things here.

SIT9531X_PLL_REG_DBG_DATA_5, _6 and _7 have no user anywhere in the
driver at this commit, and still none at the end of the series (the
later sit9531x_dbg_sample() indexes SIT9531X_PLL_REG_DBG_DATA_0 + i).
Same for SIT9531X_DBG_DATA_BYTES at this commit, though that one does
gain a user in the fractional-frequency-offset patch.

The bit annotations also disagree: DATA_4 is "[34:32] + sign" while the
next line is "[47:40]", which leaves bits 35..39 unaccounted for.  The
core.c kernel-doc calls the value a "signed 35-bit code", but the decode
uses 35 magnitude bits plus a separate sign bit
(SIT9531X_TDC_SIGN_BIT 3, SIT9531X_TDC_MAG_HI_MASK GENMASK(2, 0)).
Could these be made consistent?

> +#define SIT9531X_PLL_REG_DBG_TRIGGER		0xD0  /* read to latch a sample */
> +

[ ... remaining regs.h definitions snipped ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
