Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA8369224;
	Sat, 26 Sep 2026 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390096; cv=none; b=YnzH/FkEc3WBTLQLPw7AbHIcOX9S1rcU9eSylJEEdUkNJ6GbkYid4u2Ucsyztg1uQwDjs8aEvic6DdwtPBlDDF+Sasxp7O7VFkJ33aKULiEcHn+KgaXAfzFJxLaAgGtraaYxi7+F+lWh4vQMHI9lj/qvC6Icm6GgzHSrJs06TyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390096; c=relaxed/simple;
	bh=I+ltuebhIH2yOLpjemnVV3keXfJpEwxzqAH0V6aGkaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9nce6Zm2jjl1MQmeEJe1u+0LjI8bQg09F2/f88Am3lOf9rFPBe5KvPe+HnhZ09744uSYhPyuRt+NuxAnLKEuQjGc8Xv/dmFcBsDPCd09PoXYsrExb7RrCB1K97Xnmx2zFAESAsi9EqZFqNmkwzwXumk8w0pjyyg3MY44Cv6/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ55Nc3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ55Nc3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E21F00899;
	Sat, 26 Sep 2026 02:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390092;
	bh=jZI6czODbvvcoMLML8mOggyZ6PuD8nY9dTIyRscBp+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZ55Nc3gtTEVR181V2OzjJ3Pb5RzP0NfpKISMssm/VO5AEh71EviZ8zDmGA79tFOY
	 tXaX4aykC5707rVrAh5EZhmUj96aGKJ+V7DmlP3hX0nHsGfoXbrJbksERCpZIm1y9o
	 j3CDgiI9dj6Aa5PoyzvkZsURGsVlfrWdHN/lWhMiwb7rZLcFsHoXOy1U5MBTgC4YuY
	 8jSBKacCMuz1wKttOmBDcek+nc6mJ8E6mSvrqSAmpl++a3KgF89M9zdNtrcE+jHrmw
	 rGMkAeSmVY3ZiX/pPOWvF0JtRtevwNwbI2Qm7ZBptEn6DbMB/SRi4LZ+aYJw8+7QJo
	 OeAVQEwKjkUYA==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/14] dpll: sit9531x: add support to adjust output phase
Date: Fri, 25 Sep 2026 19:34:50 -0700
Message-ID: <20260926023450.1567935-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-11-arouhi@sitime.com>
References: <20260921201108.42676-11-arouhi@sitime.com>
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
dpll: sit9531x: add support to adjust output phase

This adds phase_adjust_get/set ops for sit9531x output pins. A requested
offset is split into a coarse delay counted in VCO cycles and a fine delay
in 30 ps steps, written to the per-output PRG_RST_DELAY registers. The
programmed delay is read back at probe to seed the cache, and a rate change
re-encodes an armed phase adjust against the new output period.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 8daf0fbf67720..c8c3cd6a64baf 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1811,6 +1811,69 @@ static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_idx,
>  	return rc;
>  }
>  
> +/**
> + * sit9531x_output_phase_read - read an output's programmed delay back

[ ... ]

> + * doing.  The registers carry an unsigned delay, so a request that was
> + * made as an advance reads back as the equivalent delay.

[ ... ]

> +	ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +	ps += (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;
> +
> +	*phase_ps = (s32)min_t(u64, ps, S32_MAX);

[Severity: Medium]
Can this saturation report a value that is neither the real delay nor an
equivalent phase?

The decoded delay is never folded against the output period, but
sit9531x_output_phase_adjust_set() encodes an advance as T_out - |advance|.
Take a 1 Hz output: a -1000 ps advance is held as about 999999999000 ps and
reads back here as 2147483647. The same happens on any output whose period
is above about 2.147 ms (1 PPS, 100 Hz), and for any profile delay above
2.147 ms.

That doesn't match the kernel-doc above ("reads back as the equivalent
delay"), or the @phase_adj description in core.h.

Both sit9531x_dev_state_fetch() and the stale read-back in
sit9531x_dpll_output_pin_phase_adjust_get() store this value in phase_adj
and set phase_armed. The getter then reports a value outside the
advertised phase_range of +/-1000000000 ps. If userspace writes that value
back, dpll_pin_phase_adj_set() rejects it.

After that, a rate change does this:

sit9531x_output_freq_set()
  sit9531x_output_phase_adjust_set(sitdev, out_idx, S32_MAX)

That call skips the core range check the abs() comment relies on. It
programs about 2.147 ms folded into the new period, runs a PLL-wide flush,
and the rate change is still reported as successful.

>  int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
>  			     u8 pll_idx, u64 frequency)
>  {
> @@ -1864,7 +1927,41 @@ int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
>  
>  	sitdev->out[out_idx].freq = div64_u64(fvco, divo);
>  
> -	return 0;
> +	/*
> +	 * The programmed reset delay counts VCO cycles against the output
> +	 * period in force when it was written, so a rate change silently
> +	 * re-times a previously requested phase adjust.  Re-encode the
> +	 * cached picosecond request against the new rate.
> +	 *
> +	 * Keyed off whether a delay was ever programmed rather than off the
> +	 * cached value: quantization can leave a whole period in the
> +	 * registers, which is the same phase and caches as zero, and that
> +	 * still has to be re-timed when the period changes.
> +	 */
> +	if (sitdev->out[out_idx].phase_armed) {
> +		s32 phase_ps = sitdev->out[out_idx].phase_adj;
> +		int ph_rc;

[ ... ]

> +		ph_rc = sit9531x_output_phase_adjust_set(sitdev, out_idx,
> +							 phase_ps);

[Severity: Low]
Do non-negative delays need this re-encoding?

The encoder computes coarse = abs_ps * Fvco / 1e12 and takes fine from the
remainder. sit9531x_output_freq_set() changes only DIVO, not Fvco, so a
positive delay keeps its absolute timing across a rate change. Only an
advance, encoded as T_out - |x|, depends on the period.

For positive delays, every rate change now adds a second
prg_enter()/prg_commit() cycle, with its 100 ms msleep. It also adds a
second sit9531x_output_phase_flush(), which restarts the divider phase of
every output on the PLL. This includes delays seeded from the factory
profile through phase_armed = !!phase_ps in sit9531x_dev_state_fetch().

The commit message body doesn't mention this change to frequency_set
either. It only shows up in the v10 notes.

[ ... ]

> @@ -1946,14 +2043,227 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,

[ ... ]

> +int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
> +				     u8 out_idx, s32 phase_ps)
> +{

[ ... ]

> +	t_out_ps = div64_u64(1000000000000ULL, freq);
> +	if (!t_out_ps)
> +		return -EINVAL;

[Severity: Low]
Can the wrap period be far off for a low-rate output that runs at a
non-integer frequency?

freq comes from the cache or from sit9531x_output_freq_get(), which stores
div64_u64(fvco, divo) truncated to whole Hz. With Fvco 5 GHz and DIVO 4e9
the output runs at 1.25 Hz (period 8e11 ps). freq is 1, though, so t_out_ps
becomes 1e12.

A -1000 ps request is then programmed as 999999999000 ps. Against the real
8e11 ps period that is roughly a 0.2 s delay, not a 1 ns advance, while the
cache reports -1000.

Rates the driver programs itself are close enough that the error is
negligible. This only affects low-rate, non-integer-Hz outputs that come
from a profile.

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(new_bytes); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(page, base + i),
> +				       new_bytes[i]);
> +		if (rc)
> +			goto rollback;
> +	}

[Severity: Low]
Should this skip the commit and flush when new_bytes[] matches
old_bytes[]?

The pin advertises phase_gran = 1 but caches the quantized value. So the
core's no-op check in dpll_pin_phase_adj_set() rarely matches when an
off-grid request is repeated:

	if (phase_adj == old_phase_adj)
		return 0;

Each repeat of the same request goes through the whole sequence again:
prg_enter(), a rewrite of the same five bytes, prg_commit() with its
100 ms settle, and sit9531x_output_phase_flush(). That flush restarts the
divider phase of every output on the PLL, which the commit message calls a
visible edge jump on the other outputs.

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
> +
> +	/*
> +	 * Restart the output divider phase so the freshly programmed delay is
> +	 * applied against a known edge instead of the divider's arbitrary
> +	 * running phase.
> +	 */
> +	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +	if (rc)
> +		return rc;

[Severity: Medium]
Should these error returns mark the cached phase as unconfirmed?

Three paths return an error when the new PRG_RST_DELAY bytes may already
be on the device:

- all five writes succeed, then sit9531x_prg_commit() fails. The failure
  can be in UPDATE_NVM, LOOP_LOCK or the debug-lock write, so it can come
  after the delay has latched.
- the commit succeeds and sit9531x_output_phase_flush() fails.
- a write fails and the rollback also fails.

None of these paths touch phase_adj, phase_armed or phase_stale.
sit9531x_dpll_output_pin_phase_adjust_set() doesn't set phase_stale
either. The only place phase_stale is set is the re-timing branch in
sit9531x_output_freq_set().

The getter's comment says its read-back covers exactly this case:

	 * A request whose writes reached the device but whose commit or
	 * phase flush failed left the cache describing the delay before it.

On the direct request path, though, the read-back never runs. The getter
keeps reporting the old value Y while the output runs the new delay X.

dpll_pin_phase_adj_set() returns 0 when a request equals what the getter
reports. So a request to go back to Y, such as 0 to clear the delay, is
silently dropped.

If this was the first request on the output, phase_armed also stays
false. A later rate change then skips re-timing a delay the registers
really hold.

> +
> +	/*
> +	 * Cache what the registers realize, and only once every step has
> +	 * succeeded: the core drops a repeated request with the same value,
> +	 * so a cache updated by a failed call would make the retry a no-op.
> +	 *
> +	 * Quantizing to whole VCO cycles plus 30 ps steps can land a few
> +	 * picoseconds past the end of the period, which would wrap the
> +	 * subtraction below; one period is the most a delay can be.
> +	 */
> +	coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +	abs_ps = coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;
> +	if (abs_ps > t_out_ps)
> +		abs_ps = t_out_ps;
> +	if (phase_norm_ps < 0)
> +		sitdev->out[out_idx].phase_adj =
> +			abs_ps ? -(s32)(t_out_ps - abs_ps) : 0;

[Severity: Low]
Does this clamp hide a residual the registers still hold?

Only the cached value is clamped. The registers that were just committed
and flushed still hold a delay that runs past the period.

Take Fvco 5 GHz, a 10 MHz output (T = 100000 ps) and a -1 ps request:

  abs_ps    = 99999
  coarse    = 499 (99800 ps), remainder 199 ps, fine = 7 (210 ps)
  total     = 100010 ps, clamped to 100000
  phase_adj = -(s32)(100000 - 100000) = 0

The output runs with a +10 ps residual while the getter reports 0. A later
request for 0 is dropped by dpll_pin_phase_adj_set() because it equals the
cached value, so the residual can't be cleared that way.

> +	else

[ ... ]

> +		sitdev->out[out_idx].phase_adj = (s32)min(abs_ps,
> +							  (u64)S32_MAX);
> +
> +	/*
> +	 * Record that a delay is programmed whatever it quantized to.  A
> +	 * request that lands on a whole period caches as zero, and the rate
> +	 * change that follows still has to re-time what the registers hold.
> +	 */
> +	sitdev->out[out_idx].phase_armed = true;

[Severity: Low]
This isn't a bug, but is "caches as zero" accurate for positive requests?
The re-timing comment in sit9531x_output_freq_set() makes the same claim.

Only the negative branch stores 0. The positive branch stores
min(abs_ps, S32_MAX), and abs_ps has already been clamped to t_out_ps, so a
whole-period result caches as t_out_ps.

For example, Fvco 5 GHz, a 10 MHz output (T = 100000 ps) and a +99995 ps
request give coarse 499 (99800 ps) plus fine 7 (210 ps). That is
100010 ps, which is clamped to 100000, and the cache holds 100000.

After a re-probe, sit9531x_output_phase_read() reports the same registers
as 100010, because it applies no period clamp.

[Severity: Low]
Should phase_armed be set for a 0 ps request?

For 0 ps the if (abs_ps) block is skipped, so coarse and fine stay 0 and no
delay is programmed. phase_armed is still set to true here. By contrast,
sit9531x_dev_state_fetch() and the getter's read-back both use !!phase_ps.
Nothing ever clears phase_armed.

So after a delay is cleared with 0, every later sit9531x_output_freq_set()
on that output still runs the re-timing block. That means another
prg_enter()/prg_commit() with the 100 ms settle and another PLL-wide
sit9531x_output_phase_flush(), just to write zeros again.

The whole-period case the flag is meant for has abs_ps != 0 at this point,
so the two cases can be told apart.

[ ... ]

> @@ -2368,12 +2678,37 @@ static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)

[ ... ]

> +		/*
> +		 * The delay registers are part of the profile the chip loads
> +		 * before probe, so an output can already carry one.  Seeding
> +		 * the cache from the device is what lets a request of 0 ps
> +		 * clear it: the core drops a request equal to what the
> +		 * getter reports, and a cache that started at zero would
> +		 * make clearing a programmed delay impossible.  An output
> +		 * the configuration does not route has no Fvco to decode
> +		 * against, which is not an error here.
> +		 */
> +		mutex_lock(&sitdev->multiop_lock);
> +		rc = sit9531x_output_phase_read(sitdev, i, &phase_ps);
> +		mutex_unlock(&sitdev->multiop_lock);
> +		if (!rc) {
> +			sitdev->out[i].phase_adj = phase_ps;
> +			sitdev->out[i].phase_armed = !!phase_ps;
> +		} else if (rc != -ENODEV) {

[Severity: Low]
Does -ENODEV actually identify an unrouted output here?

For an output that no PLL maps, sit9531x_out_state_fetch() does this:

	/* Output not mapped to any PLL */
	out->pll_idx = 0;
	out->routed = false;

sit9531x_output_phase_read() checks neither routed nor pll_idx. It calls
sit9531x_get_fvco() for PLLA, which normally succeeds with the DT override
or PLLA's DIVN-derived rate. -ENODEV only comes back when PLLA's DIVN is
unprogrammed.

As a result:

- the delay registers of every unrouted slot are read at probe.
- a read error on any of them fails the whole probe.
- the value is decoded against the wrong PLL's VCO and stored in
  phase_adj/phase_armed.

Unrouted outputs have no DPLL pin, so these values are never exposed, but
the comment doesn't match what the code does. Also,
sit9531x_output_freq_get() returns -ENODEV for a similar condition, while
sit9531x_output_phase_adjust_set() returns -EINVAL.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> index 8270b8ee91bec..82e8cd2266f5a 100644
> --- a/drivers/dpll/sit9531x/prop.c
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -228,6 +228,25 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,

[ ... ]

> +		/*
> +		 * The fine step is 30 ps, but requests are accepted at 1 ps
> +		 * resolution and rounded to the nearest achievable delay, so
> +		 * advertise the request granularity, not the hardware step.
> +		 */
> +		props->dpll_props.phase_gran = 1;

[Severity: Low]
Is "rounded to the nearest achievable delay" what the encoder does?

sit9531x_output_phase_adjust_set() floors the coarse count and only rounds
the remainder into 30 ps fine steps. It never tries coarse + 1:

	coarse = mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);

Take Fvco = SIT9531X_FVCO_HIGHBAND_MAX (7.8125 GHz, a 128 ps VCO period)
and a 127 ps request. The encoder picks coarse 0 and fine 4, which is
120 ps (7 ps off). Coarse 1 with fine 0 would give 128 ps (1 ps off).
