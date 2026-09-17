Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FD5A9865;
	Thu, 17 Sep 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657341; cv=none; b=oDs+dzwiWxYpeCm1NAjFH68YtS5K2y1rmyzSNhP3M4WgzYNHk/hqGHS4kuJTEShbRtZiNClzdPCdvq9MZvmEFtchAnGiZX5qM8kNNCgTYqCtXI+h0ClF795omYbUS9IRnrGu9MCzamQ2tX6OeTzl9yd4msaBCOzevGoiBx9gDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657341; c=relaxed/simple;
	bh=hA3jL7213GtlsmNUsmR4tq7nmIWVaSFNnOjspCuMzj8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EzZl4sJ7TMihyK2CooXzSsf4ke/kBu2kp6HGeoBZFc+2Z6YftdzGAt+IfT/ZOzWpWZBwWdojOZV3VjmBr/UbWegWiwt7iFNMGZCKDmNi1lUwBHdG3oiNhC0dBYOyJb/OJR22I0WMG8Yw6cgJfLV/GYgUtbzwiYNlJuyMtoepBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6mNY76+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6mNY76+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538CD1F0089F;
	Thu, 17 Sep 2026 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657312;
	bh=fK2Lulnru0/gK45wIRhUdSv4HykWmC0BMJePsof2i3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T6mNY76+9e1s/p69Z7UiQAtKsTLU90H4mloVAb/UTQPJg0G6LqgUdWJEYiM/iTMkN
	 0ofYoQ0JKO6UqVyNDTwPKufXogACltNtTB1m9G1A41bBofHCD8a8XCyupVweW3o7AM
	 wc+iQul4/Txe9YTkbccKh2YUjbIlfot2SrayMLQs8Y0kR1+lrA6CfmlCSMi2tBYpE2
	 yWGcR5EBZHKFD606xRNOO+Q4DCvMVKeJfweSA95YU+DZgHLCqKJ4DmSlTmBgO3M0jE
	 IfmrWnuWVw/3r1ENik6vkHa7wWJAJJBazCVauhuJme/J4wVEdry0OvufLurr7KDhxa
	 5b5/okjyPA2wg==
Subject: Re: [PATCH net-next v9 08/15] dpll: sit9531x: add support to get and
 set frequency on pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:50 +0000
Message-ID: <178965731088.22033.1162228804028625041@kernel.org>
In-Reply-To: <20260915000015.80480-9-arouhi@sitime.com>
References: <20260915000015.80480-9-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 4 · Low: 3

- [High] sit9531x_output_divo_calc() computes the output divider with
  truncating division (divo = div64_u64(fvco, frequency)) and accepts…
- [High] sit9531x_divn_fixed() computes frac =
  mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd) directly…
- [Medium] sit9531x_prg_enter() unlocks the Page-3 debug block and then
  issues PRG_CMD; if the second write fails it returns the error with…
- [Medium] A phase-flush failure is reported after the new divider has
  already been committed: sit9531x_output_freq_set() returns the error…
- [Medium] When the Fvco derived from the chip's DIVN registers falls
  outside the per-PLL band assumed from the PLL index parity,…
- [Medium] The phase-flush sequence issues the PLL small-change command
  with regmap_update_bits() (sit9531x_update_pll_u8) against the PLL-…
- [Low] Output-pin frequency ops added by this patch are not reachable in
  this snapshot because sit9531x_dpll_pin_is_registrable() rejects every…
- [Low] Claim that the new frequency callbacks index sitdev->ref[] /
  sitdev->out[] with the wider DPLL pin-id namespace, reading past the…
- [Low] The new frequency code branches on and extensively documents the
  'sitime,pll-fvco' / 'sitime,output-pll-map' DT overrides (including a…

--

dpll: sit9531x: add support to get and set frequency on pins

This adds frequency_get for input and XO pins (reported from the cached
firmware description) plus frequency_get/frequency_set for output pins,
where the rate is derived from the VCO and the per-output DIVO divider.
The set path enters the output-system programming state, rewrites the
five DIVO bytes, commits, and then flushes the PLL output phase.

No Link: tags in the commit header.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 484c94def578c..a83bf8ac83c1d 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -396,6 +396,84 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,
>  	return 0;
>  }
>  
> +/*
> + * Enter the output-system programming state: unlock the debug
> + * registers on Page 3 and issue the PRG_CMD state command.  Register
> + * writes that reconfigure the output system only take effect when
> + * they are made inside this state.
> + */
> +static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
> +{
> +	int rc;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +			       SIT9531X_DEBUG_UNLOCK_VAL);
> +	if (rc)
> +		return rc;
> +
> +	return sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +				 SIT9531X_PRG_CMD_STATE);
> +}

[Severity: Medium]
If the second write in sit9531x_prg_enter() fails, is the Page 3 debug
unlock left in place?

The only code that writes SIT9531X_DEBUG_LOCK_VAL and re-issues
SIT9531X_LOOP_LOCK is sit9531x_prg_commit(), and the caller skips it:

	rc = sit9531x_prg_enter(sitdev);
	if (rc)
		return rc;

So on a bus error for the PRG_CMD write the debug block stays writable
indefinitely, and if the failed transfer's data did reach the part the chip
is left in PRG_CMD with the output loops open, which the comment in
sit9531x_prg_commit() calls "worse than any other failure this function can
report".

Would a goto to the commit/relock path be preferable here, in the same shape
sit9531x_phase_offset_read() already uses with its "goto relock" for its own
debug window?

[ ... ]

> @@ -921,6 +1004,510 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
>  /* The output divider is a 34-bit field */
>  #define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)
>  
> +/*

[ ... ]

> +static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)
> +{
> +	s64 whole = (s64)int_part * SIT9531X_DIVN_SCALE;
> +	u64 frac;
> +
> +	if (!fracd)
> +		return whole;
> +
> +	frac = mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);

[Severity: High]
Can this division trap when the register contents are not what the driver
expects?

The numerator and denominator come straight from the chip with no
plausibility check, and the denominator is biased by one in the caller:

	*divn = sit9531x_divn_fixed(int_part, (s32)fracn_raw,
				    (u64)fracd_raw + 1);

which also makes the "if (!fracd)" guard above unreachable.

abs(fracn) can be up to 2^31, so |fracn| * 1e12 / fracd exceeds U64_MAX
whenever |fracn| / fracd is above roughly 1.8e7 -- for example DEN reading
all zeroes (fracd == 1) with a NUM above about 18,446,744, or any fracd
below about 116 with a large numerator.

On x86_64 the helper is a mulq followed by a divq:

arch/x86/include/asm/div64.h:
	/*
	 * Will generate an #DE when the result doesn't fit u64, could fix with an
	 * __ex_table[] entry when it becomes an issue.
	 */

so an out-of-range quotient is a divide-error oops rather than a value the
later "if (divn <= 0) return -ENODATA;" in sit9531x_get_fvco() could reject.
This is reachable from the new output frequency get/set as well as from
sit9531x_phase_offset_read() on an ordinary pin get.

Would rejecting fracn magnitudes at or above fracd (or clamping the
fraction) before the division be a better fit for values read off a bus?

> +
> +	return fracn < 0 ? whole - (s64)frac : whole + (s64)frac;
> +}

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
> +
> +	/* Latch it with the PLL small-change update. */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_SMALL_UPDATE,
> +				    SIT9531X_SMALL_UPDATE_CMD,
> +				    SIT9531X_SMALL_UPDATE_CMD);

[Severity: Medium]
Is read-modify-write the right access for the small-change command?

SIT9531X_PLL_REG_SMALL_UPDATE is PLL-page offset 0x0F, which regs.h
describes as the per-page programming directive register (loop lock, NVM
bank, efuse program, small change update, PRG_CMD escape). The regmap has
.cache_type = REGCACHE_NONE, so sit9531x_update_pll_u8() reads the hardware
and performs no write at all when the masked bit already reads back set,
and it writes back whatever other directive bits the read returned.

If the command bit does not self-clear, does the latch here silently not
happen, and likewise the disarm latch below:

	if (!ret)
		ret = sit9531x_update_pll_u8(sitdev, pll_idx,
					     SIT9531X_PLL_REG_SMALL_UPDATE,
					     SIT9531X_SMALL_UPDATE_CMD,
					     SIT9531X_SMALL_UPDATE_CMD);

leaving the on-demand flush armed, which the comment there says the one-shot
sequence must not do?

The rest of the driver issues this command with a plain write, in
sit9531x_prio_prg_commit() and in dpll.c via sit9531x_write_pll_u8(...,
SIT9531X_PLL_REG_SMALL_UPDATE, SIT9531X_SMALL_UPDATE_CMD). Should this site
follow the same convention?

> +	if (rc)
> +		goto disarm;

[ ... ]

> +static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_idx,
> +				     u8 pll_idx, u64 frequency, u64 *fvco_out,
> +				     u64 *divo_out)
> +{

[ ... ]

> +	/* Determine VCO frequency band limits */
> +	if (pll_idx == 1 || pll_idx == 3) {
> +		/* PLLB, PLLD: high band */
> +		fvco_min = SIT9531X_FVCO_HIGHBAND_MIN;
> +		fvco_max = SIT9531X_FVCO_HIGHBAND_MAX;
> +	} else {
> +		/* PLLA, PLLC: low band */
> +		fvco_min = SIT9531X_FVCO_LOWBAND_MIN;
> +		fvco_max = SIT9531X_FVCO_LOWBAND_MAX;
> +	}
> +

[ ... ]

> +	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +	if (rc)
> +		return rc == -ENODATA ? -ENODEV : rc;
> +	if (!sitdev->pll_fvco[pll_idx]) {
> +		if (fvco < fvco_min)
> +			fvco = fvco_min;
> +		else if (fvco > fvco_max)
> +			fvco = fvco_max;
> +	}

[Severity: Medium]
Do the set and get paths disagree once this clamp fires?

sitdev->pll_fvco[] is zero on every board today, so any Fvco derived from
DIVN that falls outside the band picked from the PLL index parity is
replaced by the band edge, and both the divider and the cached rate come
from the fabricated value:

	sitdev->out[out_idx].freq = div64_u64(fvco, divo);

sit9531x_output_freq_get() applies no clamp:

	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
	...
	*frequency = div64_u64(fvco, divo);

So a 6 GHz derived VCO on a low-band PLL is treated as 5.89824 GHz on set
and 6 GHz on get, and the set returns success with nothing logged. The
comment a few lines above states "A VCO that cannot be read fails the
request: programming a divider from a guessed rate would put the output far
from what was asked for while reporting success" -- is clamping to a band
edge not also programming from a guessed rate?

> +
> +	divo = div64_u64(fvco, frequency);
> +	if (!divo)
> +		return -EINVAL;

[Severity: High]
Should a request that the divider cannot represent be rejected or rounded?

This is a truncating division, and the only checks are that the divider is
non-zero and fits the 34-bit field, so the realized rate fvco/floor(fvco/f)
is always above the request with no bound on the error.

With Fvco 4.9152 GHz, a 156250000 Hz request gives DIVO 31, i.e. 158.548
MHz, about 1.5% high. A 1000000000 Hz request gives DIVO 4, i.e. 1.2288
GHz, 23% high and above the 1 GHz maximum the pin itself advertises. With
Fvco 5.89824 GHz, a 100000000 Hz request gives DIVO 58 (101.69 MHz) even
though DIVO 59 would yield 99.97 MHz, so flooring picks the worse of the two
adjacent dividers.

These values reach the driver because prop.c advertises a continuous range
for outputs that list no supported frequencies:

drivers/dpll/sit9531x/prop.c:sit9531x_pin_props_get() {
	if (dir == DPLL_PIN_DIRECTION_OUTPUT && num_freqs == 0) {
		ranges[j].min = 1;
		ranges[j].max = 1000000000ULL; /* 1 GHz */
	...
}

and dpll_pin_freq_set() accepts any value inside an advertised range.

Would rounding to the nearest achievable divider plus a representability or
tolerance check (or refusing the request) be preferable to reporting success
for a rate the part is not running?

> +
> +	/*
> +	 * DIVO is a 34-bit field.  With a band-clamped Fvco this cannot
> +	 * overflow, but a DT Fvco override is taken verbatim, so guard the
> +	 * field width rather than silently truncating the divider.
> +	 */
> +	if (divo > SIT9531X_DIVO_MAX)
> +		return -EINVAL;

[ ... ]

> +int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
> +			     u8 pll_idx, u64 frequency)
> +{

[ ... ]

> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Step 5: flush the PLL's output phase so the new DIVO starts
> +	 * aligned instead of keeping the arbitrary phase the divider
> +	 * happened to be at.
> +	 */
> +	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +	if (rc)
> +		return rc;
> +
> +	sitdev->out[out_idx].freq = div64_u64(fvco, divo);

[Severity: Medium]
When the flush fails, the divider has already been committed, so the part
runs at the new rate while userspace is told the set failed, and
sitdev->out[out_idx].freq still holds the old rate. Any of the six register
accesses in sit9531x_output_phase_flush() can produce that error.

Can a retry recover the skipped phase realignment?

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
	ret = ops->frequency_get(... &old_freq, extack);
	...
	if (freq == old_freq)
		return 0;
	...
}

The readback now returns the committed divider, so an identical retry never
re-enters frequency_set and the flush never runs -- which per the comment in
sit9531x_output_phase_flush() leaves the output with an offset that only a
power cycle used to clear.

Should the previous DIVO be restored on a flush failure, or the cache be
updated before the flush is attempted so the reported rate matches the
hardware?

> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index e2ff21adfdb23..88122a368053c 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -644,8 +668,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
>  	return 0;
>  }
>  

[ ... ]

>  static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>  	.direction_get		= sit9531x_dpll_output_pin_direction_get,
> +	.frequency_get		= sit9531x_dpll_output_pin_frequency_get,
> +	.frequency_set		= sit9531x_dpll_output_pin_frequency_set,
>  };

[Severity: Low]
This isn't a bug, but at this commit no output pin is registered:
sit9531x_dpll_pin_is_registrable() still starts with

	if (dir != DPLL_PIN_DIRECTION_INPUT)
		return false;

so these two callbacks are not dispatchable until the following patch in the
series rewrites that helper. The commit message describes the output path,
including "a frequency set on this device delays netlink traffic for every
DPLL in the system for that long", as if it were already live. Could the
message note that output pins become reachable later in the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
