Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2B5448A9;
	Tue,  8 Sep 2026 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871523; cv=none; b=TbQcJ9RiwYwN40AoewzkE9mnWf9aDShHphaI5haAFgI688nLcy2U7gCwatkM884FEmGZ9Wv8m/vG3WVjsbySmWlf1ov6+3FhzLufBY7WNLUvi7QQitBztDwaTlwsdYEETTFdYn+dgl0/cux71DAXMnU4WH9dQ4FxDwkkCnWH8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871523; c=relaxed/simple;
	bh=FNY6Xtv2r3cF7nhHudjOVJcO4xwrI+gmxNTSeNL1GFQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oe97CLOhg3t9xMO3kXGXWJ9gbBTU9BdcFwp5OT06dykv6j3qJfxc5AazC9nN31TI4h5v3y9vS/StygBJemy/1nQNz4M7yyXwdeZn1lJKpnnlJcrIUotl2E3BCqmT/oAYXpap1+W1wdaF7y4H4TFG5vHHbPl+jq9OOBQI0/jy04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVI3uzAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVI3uzAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F31E1F00A3E;
	Tue,  8 Sep 2026 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871519;
	bh=fVNriULkyeIZbaipzV0Cqx5ilBmt/7Q6U02mWL8eUOg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kVI3uzAfi5iPVOWrsE0cnyTwQnfOpWX8RlIJXAPLxXUnYUgh4LDsyGsKk31xZf0I7
	 wcQ4/njBxkvTUWHvdUDizeXdlmwTdhei1IQ3a2lcYGjod1CyVlhzTmRqgt/gCy74cX
	 iV9fz9YK2QAFDFrAa1oTvK3UURZgSZQooOhRo2i5wSk71JFwjXlwN+rDuppR6plBZP
	 RDl9hnV2FY+C65bkpSEOS1CQEHUN681vcmfGGw3QIIjVms3+TLGBU6umEGqX6uY92F
	 d8jE1BIW/J+zX0mE6SWPYT1vyt5oxvwBmzDoQFmyUIsA+o+EomgVFW7qF5hZ0YrOER
	 BhXH8kRWQIGtg==
Subject: Re: [PATCH net-next v8 08/15] dpll: sit9531x: add support to get and
 set frequency on pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:18 +0000
Message-ID: <178887151864.219967.4978978194985471898@kernel.org>
In-Reply-To: <20260902214030.20955-9-arouhi@sitime.com>
References: <20260902214030.20955-9-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 9 · Low: 3

- [Medium] sit9531x_get_fvco() returns 0 both for a register-read failure
  (DIVN registers on the PLL page, or the XO-doubler bit at page 0 reg…
- [Medium] A per-pin frequency set has PLL-wide and NVM side effects that
  the commit message does not disclose: sit9531x_prg_commit() writes…
- [Medium] sit9531x_dpll_output_pin_frequency_get() converts every
  failure of sit9531x_output_freq_get() into success with the stale…
- [Medium] The new input .frequency_get reports sitdev->ref[].freq, which
  prop.c seeds with the *first* entry of the DT 'supported-frequencies-…
- [Medium] prop.c appends an unconditional catch-all supported-frequency
  range of 1 Hz..1 GHz to every ordinary pin, so the freq_supported set…
- [Medium] The new output frequency setter is reachable with values it
  never advertised, because the DPLL core narrows the u64 netlink…
- [Medium] sit9531x_output_phase_flush() sets
  SIT9531X_PLL_PHFL_ON_DEMAND_EN (PLL page reg 0x3D bit 7) and latches…
- [Medium] An I2C failure partway through the five-byte DIVO write leaves
  a mixed old/new 34-bit divider staged, and the common `goto commit`…
- [Medium] Truncation of computed output frequency to `u32` without
  bounds checking.
- [Low] DISCARDED (fixed later in the series).
- [Low] The kernel-doc block of the newly added sit9531x_get_fvco()
  explains it as a fix for 'the previous split between free-run and sync…
- [Low] sit9531x_output_freq_get()'s kernel-doc documents only '0 on
  success, -ENODEV when the output divider or VCO rate is not…

--

dpll: sit9531x: add support to get and set frequency on pins

This adds .frequency_get for input, XO and output pins and .frequency_set
for output pins.  Input frequencies are reported from the cached firmware
description, while output frequencies are computed from the DIVO divider
read back from the chip and programmed by writing a new divider inside the
chip's programming state.

A few questions about the new code below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index e706f6942f65..721b2c451d59 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -339,6 +339,35 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev, u8 slot,
>  	return 0;
>  }
>  
> +/*
> + * Commit a programming sequence started by sit9531x_prg_enter():
> + * update the NVM shadow and re-lock the loops.  The sleep gives the
> + * hardware its required settling time after the loop-lock command;
> + * it is intentional despite the caller holding multiop_lock, as the
> + * whole NVM + lock sequence must be atomic.
> + */
> +static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
> +{
> +	int rc, rc2;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +			       SIT9531X_UPDATE_NVM);

[Severity: Medium]
The commit message describes an output frequency set only as "computed from
the divider read back from the chip and set by writing a new one".  Does a
single pin set also carry two side effects the message does not mention?

sit9531x_dpll_output_pin_frequency_set()
  sit9531x_output_freq_set()
    sit9531x_prg_commit()            /* SIT9531X_UPDATE_NVM + msleep(100) */
    sit9531x_output_phase_flush(pll_idx)

The NVM shadow update and the unconditional 100 ms sleep run on every
successful set, and the flush comment states that it makes "every output
divider of @pll_idx restart aligned to the PLL phase".

Does that mean setting the frequency of one output phase-steps every other
output driven by the same PLL, discarding whatever per-output phase adjust
was previously programmed on those siblings?  Could the changelog say that
a per-pin set is PLL-wide and touches the NVM shadow?

> +
> +	/*
> +	 * Issue the loop lock even if the update failed.  Callers reach
> +	 * this function through a goto so that the chip never stays in
> +	 * the PRG_CMD state with its loops open; returning early here
> +	 * would defeat that and leave the outputs unlocked until the
> +	 * next successful commit.
> +	 */
> +	rc2 = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +				SIT9531X_LOOP_LOCK);
> +
> +	msleep(100);
> +
> +	return rc ? rc : rc2;
> +}
> +
>  /*
>   * Input priority selection
>   *

[ ... ]

> @@ -735,6 +769,414 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
>  #define SIT9531X_FVCO_HIGHBAND_MIN		6875000000ULL
>  #define SIT9531X_FVCO_HIGHBAND_MAX		7812500000ULL
>  

[ ... ]

> +/*
> + * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers
> + *
> + * Fvco = Fref * DIVN, where DIVN comes from sit9531x_divn_static() and
> + * Fref = xtal_freq << doubler.  DIVN is the
> + * steady-state Fvco/Fref target programmed by the NVM blob and is
> + * authoritative in both free-run and sync modes; the previous split
> + * between free-run and sync formulas returned 0 on chips that didn't
> + * have a sync input populated, which broke the TDC phase readback.
> + *
> + * Return: Fvco in Hz, or 0 on error
> + */

[Severity: Low]
This comment describes "the previous split between free-run and sync
formulas returned 0 on chips that didn't have a sync input populated, which
broke the TDC phase readback".  Which upstream code is that referring to?

This patch adds the first Fvco computation in the driver, so there is no
previous split to have been replaced.  There is also no TDC phase readback
at this point in the series: sit9531x_phase_offset_read() is only declared
in core.h, with no definition in any .c file yet.

Could the paragraph be dropped, or reworded so it does not read as a fix
for a regression that never existed in tree?

> +static u64 sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{
> +	int doubler, rc;
> +	s64 divn;
> +	u64 fref;
> +
> +	/*
> +	 * DT board-config override: some configs (e.g. an INTSYNC PLL)
> +	 * run a VCO that Fref*DIVN does not reproduce.  When the board
> +	 * supplies the measured VCO, use it verbatim.
> +	 */
> +	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx])
> +		return sitdev->pll_fvco[pll_idx];
> +
> +	rc = sit9531x_divn_static(sitdev, pll_idx, &divn);
> +	if (rc || divn <= 0)
> +		return 0;
> +
> +	doubler = sit9531x_is_xo_doubler_enabled(sitdev);
> +	if (doubler < 0)
> +		return 0;
> +
> +	fref = (u64)sitdev->xtal_freq << doubler;
> +
> +	return mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);
> +}
> +
> +/*
> + * sit9531x_output_phase_flush - flush the output phase of a PLL

[ ... ]

> +static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{
> +	u8 ctrl, orig;
> +	int rc, ret;
> +
> +	/* Arm the on-demand phase-flush on the PLL page. */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_PHFL_CTRL,
> +				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,
> +				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);
> +	if (rc)
> +		return rc;

[Severity: Medium]
Is SIT9531X_PLL_PHFL_ON_DEMAND_EN meant to stay set after the flush?

sit9531x_output_phase_flush() sets it on the PLL page and latches it with
the small-change update, but no path in the driver clears it again -- a grep
for PHFL in drivers/dpll/sit9531x/ finds only this write site.  Only the
Page 0 trigger-source select is restored to orig at the end.

That leaves the PLL permanently armed, so a later assertion of the restored
(possibly GPIO-sourced) DIVO phase trigger re-flushes every output divider
of that PLL, which is the persistent output phase offset the flush was added
to avoid.

The function's own comment argues the trigger source must not stay pinned
after a one-shot flush; should the other half of the same one-shot sequence
be unwound too, or is the enable intentionally sticky and just missing a
comment saying so?

> +
> +	/* Latch it with the PLL small-change update. */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_SMALL_UPDATE,
> +				    SIT9531X_SMALL_UPDATE_CMD,
> +				    SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		return rc;

[ ... ]

> +	ret = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	return rc;
> +}
> +
> +/*
> + * sit9531x_output_freq_set - set output clock frequency

[ ... ]

> +int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
> +			     u8 pll_idx, u64 frequency)
> +{

[ ... ]

> +	fvco = sit9531x_get_fvco(sitdev, pll_idx);
> +	if (!fvco) {
> +		fvco = fvco_min;
> +	} else if (!sitdev->pll_fvco[pll_idx]) {
> +		if (fvco < fvco_min)
> +			fvco = fvco_min;
> +		else if (fvco > fvco_max)
> +			fvco = fvco_max;
> +	}

[Severity: Medium]
Is it safe to program a real divider from a guessed VCO rate here?

sit9531x_get_fvco() returns 0 for two very different situations:

	rc = sit9531x_divn_static(sitdev, pll_idx, &divn);
	if (rc || divn <= 0)
		return 0;

	doubler = sit9531x_is_xo_doubler_enabled(sitdev);
	if (doubler < 0)
		return 0;

so an unprogrammed DIVN and a failed regmap read of the DIVN registers or
of the doubler bit are indistinguishable.

In either case this code substitutes the band-edge constant fvco_min, then
DIVO is computed from it, written to the chip, committed to the NVM shadow
and the loops re-locked, and 0 is returned.  For a low-band PLL whose real
VCO is near 5.89824 GHz but whose readback failed, does that not put the
output roughly 20% away from what user space asked for while reporting
success?

The clamp path has the same question: an out-of-band readback is silently
pulled to the band edge rather than reported.

Would returning an error when the VCO cannot be read be preferable, and
should sit9531x_get_fvco() distinguish a bus error from a dormant PLL?

> +
> +	divo = div64_u64(fvco, frequency);
> +	if (!divo)
> +		return -EINVAL;

[Severity: Medium]
Can a request that the driver advertised as supported be satisfied at a
materially different rate here?

sit9531x_pin_props_get() in prop.c appends a catch-all range to every
ordinary pin:

	/* Always append a wide catch-all range */
	ranges[j].min = 1;
	ranges[j].max = 1000000000ULL; /* 1 GHz */

dpll_pin_freq_set() accepts anything inside prop.freq_supported, and this
code only rejects a zero DIVO.  With a low-band Fvco of 4915200000 Hz, a
request for 1 GHz gives DIVO = 4, so the pin emits 1228800000 Hz -- neither
the requested value nor inside the advertised range -- and the call returns
success.  Smaller residues appear everywhere else, e.g. 156250000 Hz becomes
158554838 Hz on the same VCO.

Should either the advertised ranges describe rates the divider can actually
produce, or the setter reject requests it cannot hit exactly?

> +
> +	dev_dbg(sitdev->dev,
> +		"out%u: Fvco=%llu freq=%llu DIVO=%llu (effective %llu Hz)\n",
> +		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));

[ ... ]

> +	divo_bytes[0] = (divo >>  0) & 0xFF;
> +	divo_bytes[1] = (divo >>  8) & 0xFF;
> +	divo_bytes[2] = (divo >> 16) & 0xFF;
> +	divo_bytes[3] = (divo >> 24) & 0xFF;
> +	divo_bytes[4] = (divo >> 32) & 0x03;  /* only bits [1:0] */
> +
> +	rc = sit9531x_read_u8(sitdev,
> +			      SIT9531X_REG(page, base_reg - 4), &msb_old);
> +	if (rc)
> +		goto commit;
> +	divo_bytes[4] |= msb_old & 0xFC;
> +
> +	for (j = 0; j < 5; j++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(page, base_reg - j),
> +				       divo_bytes[j]);
> +		if (rc)
> +			goto commit;
> +	}
> +
> +commit:

[Severity: Medium]
What happens to the 34-bit divider when one of these five writes fails
partway through?

The bytes are written one register at a time, so a failure at j > 0 leaves a
mixed old/new DIVO staged, and the shared exit then applies it:

commit:
	ret = sit9531x_prg_commit(sitdev);   /* UPDATE_NVM then LOOP_LOCK */

Does that leave the output running at a frequency nobody requested, with the
NVM shadow updated to match, while the function returns an error and
sitdev->out[out_idx].freq still describes the old rate?

The commit message covers the exit running on failure ("the exit runs even
when a write in the middle failed and the first error is the one returned"),
but not the half-written field.  Would saving and restoring the five
pre-write bytes on the failure path, or abandoning the staged update, be
possible here?

> +	/*
> +	 * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip
> +	 * leaves the PRG_CMD state with the output loops re-locked, even when a
> +	 * write above failed; keep the first error to return.  It also carries
> +	 * the required post-lock settling sleep.
> +	 */
> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +	if (rc)
> +		return rc;

[ ... ]

> +	sitdev->out[out_idx].freq = (u32)div64_u64(fvco, divo);
> +
> +	return 0;
> +}
> +
> +/*
> + * sit9531x_output_freq_get - read output clock frequency from hardware
> + * @out_idx:	output index (0-N for this chip variant)
> + * @frequency:	output frequency in Hz

[Severity: Medium]
Is a u32 wide enough for the effective rate this line caches?

struct sit9531x_out.freq is a u32, but the value stored here is
fvco / divo, and divo is only rejected when it is zero.  With divo == 1
the effective rate is the raw VCO, 4.9-5.9 GHz on a low-band PLL and
6.9-7.8 GHz on a high-band one, all above U32_MAX (~4.29 GHz), so the
cast silently wraps: a 4915200000 Hz output would be cached as
620232704 Hz.  sit9531x_output_freq_get() does the same thing one
function below with (u32)*frequency, so a read-back of such an output
overwrites the cache with the same wrapped value even though
*frequency itself is correct.

That matters because sit9531x_dpll_output_pin_frequency_get() falls
back to sit9531x_out_state_get(sitdev, dpin->id)->freq whenever the
register read path returns an error, so user space can be handed the
wrapped rate as a live frequency, and dpll_pin_freq_set() compares its
request against that same value.

Would widening sit9531x_out.freq to u64 be the intended fix, or should
sit9531x_output_freq_set() reject requests whose divider would come out
below the smallest DIVO the hardware supports, so a rate the field
cannot represent is never programmed in the first place?

[ ... ]

> + * Return: 0 on success, -ENODEV when the output divider or VCO rate
> + *	   is not resolvable, <0 on register access error
> + */
> +int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
> +			     u64 *frequency)
> +{
> +	const struct sit9531x_chip_info *info = sitdev->info;
> +	u8 slot, page, base_reg, pll_idx, v;
> +	u64 fvco, divo = 0;
> +	int rc, j;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (out_idx >= info->num_outputs)
> +		return -EINVAL;

[Severity: Low]
The Return: block lists 0, -ENODEV and register access errors, but this
-EINVAL for an out-of-range out_idx is not among them.  Could it be added?

In the same area, the doc block of sit9531x_output_freq_set() numbers a
seven-step write sequence while the in-body comments label the same points
"Step 4" and "Step 5", so the two numberings do not line up.

> +
> +	pll_idx = sitdev->out[out_idx].pll_idx;
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -ENODEV;
> +
> +	fvco = sit9531x_get_fvco(sitdev, pll_idx);
> +	if (!fvco)
> +		return -ENODEV;

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 67b9fbba9f2e..a7510ca721b6 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -302,6 +302,28 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_dpll_input_pin_frequency_get - read input pin frequency
> + *
> + * returns cached frequency from DT or last set.
> + */
> +static int
> +sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,
> +				      void *pin_priv,
> +				      const struct dpll_device *dpll,
> +				      void *dpll_priv, u64 *frequency,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	const struct sit9531x_ref *ref;
> +
> +	ref = sit9531x_ref_state_get(sitdpll->dev, dpin->id);
> +	*frequency = ref->freq;
> +
> +	return 0;
> +}

[Severity: Medium]
The changelog says "An input's frequency is what the board presents".  Is
ref->freq actually that value when a board lists several rates?

sit9531x_pin_props_get() in prop.c seeds it with the first list entry:

	if (num_freqs > 0) {
		if (dir == DPLL_PIN_DIRECTION_INPUT)
			sitdev->ref[index].freq = (u32)freqs[0];

The generic binding in Documentation/devicetree/bindings/dpll/dpll-pin.yaml
describes supported-frequencies-hz only as a "List of supported frequencies
for this pin, expressed in Hz", so list order carries no current-rate
meaning.

With no input .frequency_set and no hardware measurement, does this report
an arbitrary entry of the supported list as the pin's live frequency, with
no way for user space to correct it?

[Severity: Low]
Separately, does this read past ref[] for the INTSYNC pin at this point in
the series?

sit9531x_dpll_pin_ops_get() returns sit9531x_dpll_input_pin_ops for the
INTSYNC destination pin, whose dpin->id is SIT9531X_INTSYNC_PIN_ID (9),
while sitdev->ref[] is dimensioned SIT9531X_MAX_INPUTS + 1 (9 entries), so
ref[9] aliases out[0].  The error fallback in the output getter below has
the same shape with out[12] aliasing chan[0].

The later series patch "dpll: sit9531x: model the inter-PLL sync net as a
pair of pins" adds dedicated INTSYNC ops tables with no frequency callbacks
and a comment saying exactly this, so the path is gone by the end of the
series -- would it be worth ordering that patch before this one so no commit
in between exposes ref[9] and out[12] as pin frequencies?

>  /*
>   * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state
>   *

[ ... ]

> @@ -576,8 +600,79 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_dpll_output_pin_frequency_get - read output pin frequency
> + *
> + * Reads the DIVO divider back from the chip and computes the live
> + * frequency as Fvco / DIVO.  Falls back to the cached value when the
> + * output is not resolvable through the divider chain (e.g. not mapped
> + * to a PLL), so a netlink dump never fails on such pins.
> + */
> +static int
> +sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,
> +				       void *pin_priv,
> +				       const struct dpll_device *dpll,
> +				       void *dpll_priv, u64 *frequency,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_output_freq_get(sitdev, dpin->id, frequency);
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc)
> +		*frequency = sit9531x_out_state_get(sitdev, dpin->id)->freq;
> +
> +	return 0;
> +}

[Severity: Medium]
The comment justifies the fallback for outputs "not resolvable through the
divider chain (e.g. not mapped to a PLL)", but does this also swallow I2C
and regmap errors?

sit9531x_output_freq_get() propagates the error of sit9531x_read_u8() for
each of the five DIVO byte reads, and sit9531x_get_fvco() reads the DIVN
registers and the doubler bit as well:

		rc = sit9531x_read_u8(sitdev,
				      SIT9531X_REG(page, base_reg - j), &v);
		if (rc)
			return rc;

With every non-zero rc turned into "return 0" plus the stale cached value,
a transient bus failure is reported to user space as a valid live frequency.

Does it also affect the set path?  dpll_pin_freq_set() calls
ops->frequency_get() first and then:

	if (freq == old_freq)
		return 0;

so if the stale cache happens to equal the requested frequency, the set is
reported as successful without frequency_set() ever running.

Would distinguishing -ENODEV (the unresolvable case the comment describes)
from register access errors work here?

> +
> +/*
> + * sit9531x_dpll_output_pin_frequency_set - set output pin frequency
> + *
> + * computes DIVO = Fvco / frequency and writes the
> + * 34-bit output divider to the output system registers via
> + * sit9531x_output_freq_set().
> + */
> +static int
> +sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
> +				       void *pin_priv,
> +				       const struct dpll_device *dpll,
> +				       void *dpll_priv, u64 frequency,
> +				       struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
> +				      frequency);
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
Should this setter sanity-check the upper bound of frequency itself?

The core validates the request narrowed to 32 bits before handing over the
full 64-bit value:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
	u64 freq = nla_get_u64(a), old_freq;
	...
	if (!dpll_pin_is_freq_supported(pin, freq)) {
	...
	ret = ops->frequency_set(pin, ..., freq, extack);
}

with

static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)

Combined with the 1 Hz..1 GHz catch-all range this driver advertises, does a
request of 4294967297 Hz validate as 1 Hz and then arrive here at full
width?  sit9531x_output_freq_set() only rejects a zero DIVO, so for a
documented band VCO it would compute DIVO = 1 and program the output at the
raw VCO rate of 4.9-7.8 GHz while returning success, and the u32 cache
update would wrap.

The narrowing helper predates this series, but this is the first driver
callback that can act on it.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
