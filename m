Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83237DEAB;
	Thu, 17 Sep 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657344; cv=none; b=YBWrvHhQ0O4daK8R/l2bjeXZnAat9CUZUxFq3qi6WJvoGD/HBnBdXCX0ilmB7KtcLuKi8SYDN62qQ/wH0R57XsDR5+jSOrfO4qnDWRXC8Ac3tiCxbsXQ1tPrRQ7o5XiDwpeniNpka9TqlPv1f/Ihrc2crzQ3T1xY//0PipWJ/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657344; c=relaxed/simple;
	bh=pQtlmZTuIe43yac4a5l0oX1q+WpAtqhn24/l5MxhkQU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoNTXzhf28ATaI0zSzDWE2LP/GDOxAPQ8QdWZx89ErPygJI0QKUCRomGnUVxDZjYDn7opxp9KORw2oRXhG3DV+FoUdZL4Ny9LfVm7oitRXsaZaOnGAuule6fWOVfax0vpjbxU0tdQdqhuAz9mSQe8IY1SN3PRo9lAtACoao/Nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb3pZAZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb3pZAZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4341F008A1;
	Thu, 17 Sep 2026 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657313;
	bh=YVmw3COmW7NQvn12CnwbqyCjKR1/Rwn1jJQVKH93eP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fb3pZAZgNf7e1JGJwNz3eSrEYe/HaIVZV8aGXGohvjxkmF1RljV4j5M9VB9Yn+nza
	 J2Q8N1s/BHPzppfRtOByCGm2SCzOi4xIOWc++gsVNFiU6ezqMyPfgkzDb0ExPUS+c/
	 4H0TuD8R0KXUi28T2r21zNzDk2SaBj7H03HlhoJUbz4UiguvSUNyVjuZXr9kcPYngl
	 TbgMEkueIgL2YJj2lRs4X2OMqlfK7jwyGUjgO0eRid/h69mgdjA5Aa29oqAD7SuqEu
	 d2TNnuN/65iRmWQQk2jV4mtkK3rTJAmW6Vm04+mF1qAQlUJ/n2Mz2ERi38ic7PFB3j
	 yFuszEPslbdPg==
Subject: Re: [PATCH net-next v9 10/15] dpll: sit9531x: add support to adjust
 output phase
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:52 +0000
Message-ID: <178965731236.22033.10465683343985463430@kernel.org>
In-Reply-To: <20260915000015.80480-11-arouhi@sitime.com>
References: <20260915000015.80480-11-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 5 · Low: 1

- [Medium] `struct sit9531x_out.phase_adj` is a pure software cache that
  is never seeded from the hardware.
- [Medium] A per-pin phase-adjust request ends with
  `sit9531x_output_phase_flush(sitdev, pll_idx)`, which arms…
- [Medium] `sit9531x_output_phase_adjust_set()` commits the new
  PRG_RST_DELAY bytes to the device and only afterwards updates its…
- [Medium] `sit9531x_output_freq_set()` now returns the result of the
  added phase-adjust re-encode.
- [Medium] `sit9531x_output_phase_adjust_set()` derives the output period
  from the cached `sitdev->out[out_idx].freq` and only falls back to a…
- [Low] Concern that the block comment above
  `sit9531x_output_phase_adjust_set()` in core.c documents page/base…

--

dpll: sit9531x: add support to adjust output phase

This adds phase_adjust_get/phase_adjust_set to the sit9531x output pin ops,
programming the per-output PRG_RST_DELAY block (34-bit coarse in VCO cycles
plus a 3-bit fine field in 30 ps steps) from inside the PRG_CMD programming
state, and re-encoding a cached request when the output rate changes.

A few questions about the new code below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index bba42fe302a3b..8d857f1a0c890 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1641,7 +1641,17 @@ int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
>  
>  	sitdev->out[out_idx].freq = div64_u64(fvco, divo);
>  
> -	return 0;
> +	/*
> +	 * The programmed reset delay counts VCO cycles against the output
> +	 * period in force when it was written, so a rate change silently
> +	 * re-times a previously requested phase adjust.  Re-encode the
> +	 * cached picosecond request against the new rate.
> +	 */
> +	if (sitdev->out[out_idx].phase_adj)
> +		rc = sit9531x_output_phase_adjust_set(sitdev, out_idx,
> +						      sitdev->out[out_idx].phase_adj);
> +
> +	return rc;
>  }

[Severity: Medium]
Can this turn a completed frequency change into a reported failure?  By the
time this runs, sit9531x_output_divo_write(), sit9531x_prg_commit() and the
phase flush have all succeeded and sitdev->out[out_idx].freq already holds
the new rate.

Any error inside sit9531x_output_phase_adjust_set() (bus error in
sit9531x_prg_enter(), the read/write loops, prg_commit or the second flush,
or -ENODEV from sit9531x_get_fvco()) becomes the return value here, with no
rollback of DIVO, and sit9531x_dpll_output_pin_frequency_set() reports it as
"Output frequency set failed".

An identical retry does not repair it either, because dpll_pin_freq_set()
asks the driver for the current rate first:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
	...
	if (freq == old_freq)
		return 0;
	...
}

and sit9531x_dpll_output_pin_frequency_set()'s companion get reads DIVO back
from hardware, so the second request never reaches the driver and the phase
re-encode that failed is never performed.  For a negative cached adjust the
delay registers then stay encoded against the old period, since the
rendering T_out - |phase| depends on the period.

Would it be better to log the re-encode failure and still return success for
the frequency set?

> @@ -1731,6 +1741,206 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
>   * output period, which is identical for a periodic signal.
>   */
>  
> +int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
> +				     u8 out_idx, s32 phase_ps)
> +{

[ ... ]

> +	freq = sitdev->out[out_idx].freq;
> +	if (!freq) {
> +		/*
> +		 * The cache is only seeded by a DT frequency list or an
> +		 * earlier get/set; a board without supported-frequencies-hz
> +		 * would otherwise get -EINVAL on every phase request forever.
> +		 * Read the effective rate back from the divider chain.
> +		 */
> +		rc = sit9531x_output_freq_get(sitdev, out_idx, &freq);
> +		if (rc)
> +			return rc;
> +		if (!freq)
> +			return -EINVAL;
> +	}

[Severity: Medium]
The live divider is consulted only when the cache is zero.  Can a non-zero
cached value be a rate the hardware never produced?

sit9531x_pin_props_get() in prop.c seeds it from the DT list rather than
from the device:

	if (curr_freq) {
		if (dir == DPLL_PIN_DIRECTION_INPUT)
			sitdev->ref[index].freq = curr_freq;
		else
			sitdev->out[index].freq = curr_freq;
	}

where curr_freq is the first entry of supported-frequencies-hz, and the
binding only enumerates the rates the output supports.  The driver also
documents the cache as unreliable in sit9531x_output_freq_get():

	 * correct even when the divider was reprogrammed behind the driver's
	 * back (e.g. by a direct-I2C userspace tool), where the cached value
	 * would be stale.

A wrong period lands directly in the encoding, because the negative path
computes abs_ps = t_out_ps - advance.  With a true period of 40000 ps but
6400 ps assumed (156.25 MHz listed first), a request of -1000 ps programs a
5400 ps delay instead of 39000 ps, and success is returned.  Positive
requests are mis-folded the same way once the request exceeds the assumed
period.

Nothing in dpll_pin_phase_adj_set() calls frequency_get() first, so a phase
request can be the very first operation on the pin.  Should the period be
read back from DIVO on every phase update?

[ ... ]

> +	slot = info->clkout_map[out_idx];
> +	page = (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
> +	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
> +	base = SIT9531X_OUT_PRG_DELAY_BASE +
> +	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);

[Severity: Low]
This isn't a bug, but the block comment immediately above this function
describes the same addressing in terms of the logical output index:

 * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each
 * output's block at base = 0x15 + 16 * (out_idx % 6).

while the code here and the new regs.h comment use the physical slot from
clkout_map[].  The code is the correct one of the two.

The wording is already corrected later in the same series, in "dpll:
sit9531x: model the inter-PLL sync net as a pair of pins", where it becomes
"Slots 0-5 live on Page 3, slots 6-11 on Page 4 ... not the logical output
index", so this only concerns this commit.

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(new_bytes); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(page, base + i),
> +				       new_bytes[i]);
> +		if (rc)
> +			goto rollback;
> +	}
> +
> +	goto commit;

[ ... ]

> +commit:
> +	/*
> +	 * Always leave the PRG_CMD state via prg_commit(), even on a
> +	 * mid-sequence write failure, so the output loops are re-locked rather
> +	 * than stranded unlocked; keep the first error.
> +	 */
> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +	if (rc)
> +		return rc;

[Severity: Medium]
When the five writes all succeeded and sit9531x_prg_commit() then fails,
this returns before the phase_adj assignment at the end of the function, and
nothing restores old_bytes.  The same applies to the
sit9531x_output_phase_flush() failure below.

So the delay registers of that slot hold the new coarse/fine value while
sitdev->out[out_idx].phase_adj still holds the previous one, and only a
mid-write failure takes the rollback path.

Getting back to the reported value is then not possible through the
attribute, because the core drops a request equal to what the getter
reports:

drivers/dpll/dpll_netlink.c:dpll_pin_phase_adj_set() {
	...
	if (phase_adj == old_phase_adj)
		return 0;
	...
}

The unrecorded delay is also applied at the next output-divider phase flush
of that PLL, for instance during a frequency set on a sibling output, so the
phase step appears at a point the driver never recorded.

Should these two paths roll the delay bytes back, or update the cache to
what the registers now hold?

> +	/*
> +	 * Restart the output divider phase so the freshly programmed delay is
> +	 * applied against a known edge instead of the divider's arbitrary
> +	 * running phase.
> +	 */
> +	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +	if (rc)
> +		return rc;

[Severity: Medium]
Does a single-pin phase-adjust request disturb the sibling outputs of the
same PLL?  sit9531x_output_phase_flush() arms
SIT9531X_PLL_PHFL_ON_DEMAND_EN on the PLL page and then pulses the global
trigger:

	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,
			       ctrl | SIT9531X_DIVO_PHASE_TRIG);

regs.h documents SIT9531X_DIVO_PHASE_TRIG as flushing the output phase with
no per-output selection, so the output-divider phase of every output fed by
that PLL looks like it gets restarted, i.e. an edge jump on the outputs that
were not adjusted.

On top of that, sit9531x_prg_enter() puts the whole output system into the
PRG_CMD state with the loops open, and sit9531x_prg_commit() re-locks them
after msleep(100), so each phase-adjust request also touches outputs of the
other PLLs.

The DPLL ABI models phase adjust as a per-pin property.  Could the scope of
this operation be narrowed, or at least described in the commit message and
in a comment?

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index d550eb626e6de..78034b7f089cc 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -815,12 +815,68 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustment
> + *
> + * Returns the applied phase cached in out->phase_adj, i.e. the value
> + * sit9531x_output_phase_adjust_set() actually programmed after quantization.
> + */
> +static int
> +sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,
> +					  void *pin_priv,
> +					  const struct dpll_device *dpll,
> +					  void *dpll_priv, s32 *phase_adjust,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	*phase_adjust = sit9531x_out_state_get(sitdev, dpin->id)->phase_adj;
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	return 0;
> +}

[Severity: Medium]
Is the value returned here ever reconciled with the device?  phase_adj is
zeroed by the devm_kzalloc() in sit9531x_i2c_probe(),
sit9531x_out_state_fetch() reads output mode, forced Hi-Z and routing but
never the five PROG6..PROG2 delay bytes, and the only assignment is at the
tail of sit9531x_output_phase_adjust_set().

Since that setter commits with SIT9531X_UPDATE_NVM through
sit9531x_prg_commit(), and the delay fields are part of the profile the chip
loads before probe, the device can hold a non-zero delay while this reports
0 - after a module unload/reload, after a warm reboot, or on a board whose
profile programmed a delay.

A request of 0 ps meant to clear such a delay then never reaches the driver:

drivers/dpll/dpll_netlink.c:dpll_pin_phase_adj_set() {
	...
	if (phase_adj == old_phase_adj)
		return 0;
	...
}

and the re-encode added to sit9531x_output_freq_set() is gated on
if (sitdev->out[out_idx].phase_adj), so an unrecorded hardware delay is not
re-timed on a rate change either.

This also does not match the commit message:

    the two and what the core reads back is what the registers hold rather
    than what was asked for

nor the new kernel-doc "phase adjust the delay registers actually realize",
since the registers are never read for this purpose.  This looks unchanged
at the end of the series.

Could phase_adjust_get() decode the PRG_RST_DELAY block, or the startup
state fetch seed phase_adj from it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
