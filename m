Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90225A645;
	Mon,  5 Oct 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162610; cv=none; b=LA7tfptEAbykILRUrVkh1CMZroXSuoc9CeuUC5MUi1cgCFEVOilhckqKdVZrVPQO/NJlIKcYZXoHgfYpq7bVltrQiVpDAdGFSF+sA1Evzl7A2Ev0hyk6c9jLSQrnCnM5F2YUSQnseas5IiVw4qzrTtN10YqNLhN8tEXuM8PnAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162610; c=relaxed/simple;
	bh=rJJtQc7QiLgCTOVeYpiDMHKyjxR5gQt8tyVjGX0uEmw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FFl68bLNvAqHPQ88SrGaisMxlp/ZPkCAajWXpDnzLy7RdeaPklroP67b3GDM5V7M0kD5xPCJg1FBZpwwK51ydThbfEeNRXJ3FwUE+qFAH+h+FvAhBhvvdTta4kVGx7nNlG9k72zzJwsf/dRMqYfTYPCdOQUrRTL6llLqs6SR204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FePei7fU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FePei7fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245DF1F0089A;
	Mon,  5 Oct 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162608;
	bh=7WY4auHNPRuS3t9AfNnUcj1ZfnnxBZzWMZyfFgnIGx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FePei7fUdpBvVszcmQ5jZ9ieieiHiQrp2pSP615LifEM2kKJZXKez7uXjMKWhZvlM
	 TZiObiKH9Y5IODSI4d3Sb9WYuUu4DUCjUh7ZgBxkLzkgIPBE7+metCYw2jiVpH6cbL
	 /ewh7NEbUFM3mcpa4/04dMNxee5n/7HdbVb8HfWau8CjRredCeHiF7Za7fopjpdJAS
	 SUdgVYuFCGIU4HCiVQzVOIOmA5m2ZjtyW/qD78186OrkacHLEgV/AZqsGWO+c9CM29
	 DIephwlvFptyk95B0s/7/94aPNVg7z9MDx/a3e9KPE0ShvlRbWl4dvy5przdLHr2si
	 xb3ZTV0W3gaig==
Subject: Re: [PATCH net-next v11 11/13] dpll: sit9531x: add support to adjust
 output phase
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:06 +0000
Message-ID: <179116260667.434549.14297756482397841280@kernel.org>
In-Reply-To: <20260930233714.87679-12-arouhi@sitime.com>
References: <20260930233714.87679-12-arouhi@sitime.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 8 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Each phase-adjust write calls sit9531x_output_phase_flush()
  (core.c:2671).
- [Medium] On a rate change, sit9531x_output_freq_set() re-times from the
  cached phase_adj, which may be clamped or folded, rather than from the…
- [Medium] sit9531x_output_phase_read() is not the inverse of the
  encoding used by sit9531x_output_phase_adjust_set().
- [Medium] sit9531x_output_phase_read() discards register-access errors
  from sit9531x_output_divo_read().
- [Medium] A phase-flush failure that the setter records in phase_stale
  is never retried, because the getter clears phase_stale.
- [Medium] sit9531x_output_phase_adjust_set() truncates the output period
  to whole picoseconds (`t_out_ps = mul_u64_u64_div_u64(divo, 1e12,…
- [Medium] In sit9531x_output_freq_set(), the new phase re-time and
  invalidation block (core.c:2351-2372) is reached only when divo_write…
- [Medium] The new phase code converts VCO cycles to picoseconds with
  mul_u64_u64_div_u64(x, 1000000000000ULL, fvco), where x is a 34-bit…
- [Low] The commit message says the ±1 ms window 'is wider than the
  dynamic range but costs nothing', and prop.c:236 says '1 ms is well…
- [Low] The quantizer in sit9531x_output_phase_adjust_set() only
  considers coarse = floor(abs_ps * Fvco / 1e12) (core.c:2511) and…

--

dpll: sit9531x: add support to adjust output phase

This adds output phase-adjust support to the sit9531x DPLL driver. It
programs the per-output PRG_RST_DELAY coarse and fine registers, and it
folds each request modulo one output period. At probe the phase cache is
seeded from the hardware, advances are re-timed when the rate changes, and
the driver advertises a +/-1 ms range with 1 ps granularity.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 8fed14d8dca62..d2719ff24249f 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2183,6 +2183,110 @@ static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_idx,

[ ... ]

> +int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,
> +			       s32 *phase_ps)
> +{

[ ... ]

> +	coarse = (coarse > SIT9531X_OUT_PRG_DIVO_CYCLES) ?
> +		 coarse - SIT9531X_OUT_PRG_DIVO_CYCLES : 0;
> +
> +	ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);

[Severity: Medium]
Can this conversion overflow and raise a divide error? Here coarse is a
raw 34-bit value from the device. sit9531x_get_fvco() only rejects
fvco == 0; an out-of-band fvco gets a dev_warn_once() and is returned
anyway.

With a tiny DIVN (for example an integer part of 0 plus a small fraction),
fvco can be a few hundred Hz. If fvco is below about 940 Hz and coarse (or
divo, for t_out_ps below) is near 2^34, then x * 1e12 / fvco does not fit
in u64. On x86-64, mul_u64_u64_div_u64() is a mulq/divq pair, which raises
#DE in that case.

At probe this runs for every routed output through
sit9531x_dev_state_fetch()->sit9531x_output_phase_read(). The same pattern
appears in sit9531x_output_phase_adjust_set() for t_out_ps, coarse_ps,
up_ps and the cached value.

sit9531x_divn_static() already guards against this kind of #DE. Should
these conversions also bound fvco or the result?

> +	ps += (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;

[ ... ]

> +	if (!sit9531x_output_divo_read(sitdev, out_idx, &divo)) {

[Severity: Medium]
Does this drop register access errors from sit9531x_output_divo_read()?
An I2C or regmap error is handled the same way as -ENODATA, and the
function falls through to:

	*phase_ps = (s32)min_t(u64, ps, SIT9531X_OUT_PHASE_ADJ_MAX_PS);
	return 0;

The value returned is unfolded, possibly clamped, and never negative. The
kernel-doc promises "<0 on register access error", and the delay byte
reads and sit9531x_get_fvco() above do pass their errors back.

sit9531x_dpll_output_pin_phase_adjust_get() treats rc == 0 as
authoritative:

	sitdev->out[dpin->id].phase_adj = phase_ps;
	sitdev->out[dpin->id].phase_armed = !!phase_ps;
	sitdev->out[dpin->id].phase_stale = false;

So one transient bus error during the stale read-back could leave a 1 PPS
advance of -500000 ps cached as +1e9, with no stale marker. After that,
dpll_pin_phase_adj_set() drops a matching request, and the next rate
change writes the wrong delay. sit9531x_dev_state_fetch() seeds the cache
at probe from the same read.

Should only -ENODATA skip the fold, with other errors returned?

> +		u64 t_out_ps = mul_u64_u64_div_u64(divo, 1000000000000ULL,
> +						   fvco);
> +
> +		if (t_out_ps) {
> +			div64_u64_rem(ps, t_out_ps, &ps);
> +			if (ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS &&
> +			    t_out_ps - ps <= SIT9531X_OUT_PHASE_ADJ_MAX_PS) {

[Severity: Medium]
Is this the inverse of the encoding in
sit9531x_output_phase_adjust_set()? After the fold, ps < t_out_ps. When
t_out_ps <= SIT9531X_OUT_PHASE_ADJ_MAX_PS, which is every output faster
than 1 kHz, the two conditions can never both hold, so the function never
returns a negative value.

Take a 10 MHz output (T = 100000 ps). A -30000 ps request is written as
70000 ps (plus the two cycles) and cached as -30000. Reading it back gives
+70000.

That read-back happens at probe, and on the phase_stale path in
sit9531x_dpll_output_pin_phase_adjust_get(), which overwrites phase_adj
with +70000 and re-arms it. On the next rate change,
sit9531x_output_freq_set() encodes +70000 as a positive delay instead of
T_new - 30000. The output then sits at a different phase from the one
requested, and the reported phase_adjust changes sign.

The kernel-doc above says such an advance "reads back as that advance".
That does not seem to hold for these outputs.

> +				*phase_ps = -(s32)(t_out_ps - ps);
> +				return 0;
> +			}
> +		}
> +	}
> +	*phase_ps = (s32)min_t(u64, ps, SIT9531X_OUT_PHASE_ADJ_MAX_PS);
> +
> +	return 0;
> +}

[ ... ]

> @@ -2236,7 +2340,38 @@ int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
>  
>  	sitdev->out[out_idx].freq = div64_u64(fvco, divo);
>  
> -	return 0;
> +	/*
> +	 * The programmed reset delay counts VCO cycles, and a rate change
> +	 * moves only the divider, so a positive delay keeps its timing; an
> +	 * advance, though, is held as T_out - |advance| and has to be
> +	 * re-encoded against the new period.  Re-encode whatever was asked
> +	 * for: for a positive delay that lands on the same register bytes,
> +	 * and sit9531x_output_phase_adjust_set() then writes nothing.
> +	 */
> +	if (sitdev->out[out_idx].phase_armed) {

[Severity: Medium]
Is this block reached on every path where the divider changed? Earlier in
sit9531x_output_freq_set(), the function returns before getting here:

	ret = sit9531x_prg_commit(sitdev);
	if (ret && !rc)
		rc = ret;
	if (rc)
		return rc;

prg_commit() can report a failed UPDATE_NVM write that still reached the
part. Its loop-lock retries can also fail after the update took effect.
sit9531x_output_divo_write() can fail mid-sequence with a failed rollback,
and the remaining bytes are then committed.

If the period changed on one of those paths, a cached advance held as
T_old - |adv| no longer means -|adv|, but phase_stale stays false. The
getter keeps reporting the old advance, so the core drops a request to
restore that value. A retried frequency_set is dropped too, because the
core reads the new rate first.

Should the error path set phase_stale when phase_armed is set?

> +		s32 phase_ps = sitdev->out[out_idx].phase_adj;
> +		int ph_rc;
> +

[ ... ]

> +		ph_rc = sit9531x_output_phase_adjust_set(sitdev, out_idx,
> +							 phase_ps);

[Severity: Medium]
How many times does one rate change disturb the PLL here?
sit9531x_output_freq_set() has already called sit9531x_output_phase_flush()
after the DIVO commit.

For any advance, T_new - |adv| differs from T_old - |adv|, so the memcmp
shortcut in sit9531x_output_phase_adjust_set() does not match. The setter
then runs another prg_enter()/prg_commit() cycle, which opens the loops
again and adds another 100 ms settle, followed by another flush. Between
the two flushes the output runs with the old-period encoding.

On a PLL whose CONFIG47 PHFL_EN bit is clear, sit9531x_output_phase_flush()
does this:

	if (!(phfl & SIT9531X_PLL_CONFIG47_PHFL_EN))
		return sit9531x_write_pll_u8(sitdev, pll_idx,
					     SIT9531X_PLL_REG_DIRECTIVES,
					     SIT9531X_PLL_DIRECTIVE_RESTART);

regs.h describes that bit as "the restart bit restarts the PLL". On such a
PLL, every phase-adjust write restarts the whole PLL, and an armed rate
change restarts it twice.

The commit message says:

  The device has no per-output phase flush, so realigning the adjusted
  output restarts the divider phase of every output that PLL drives.

Should the commit message mention the full PLL restart? And could the rate
change avoid the second programming cycle and flush?

> +		if (ph_rc) {

[ ... ]

> @@ -2304,14 +2439,277 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,

[ ... ]

> +	t_out_ps = mul_u64_u64_div_u64(divo, 1000000000000ULL, fvco);
> +	if (!t_out_ps)
> +		return -EINVAL;
> +

[ ... ]

> +	abs_ps = abs(phase_ps);
> +	div64_u64_rem(abs_ps, t_out_ps, &abs_ps);

[Severity: Medium]
Does truncating the period to whole picoseconds give the wrong fold for
requests longer than one period? The dropped fraction accumulates once for
every period that is folded away.

For example, Fvco = 5.12 GHz with DIVO = 40 gives a 128 MHz output with a
7812.5 ps period, which is truncated to 7812. A 100000000 ps request is
exactly 12800 periods and should fold to 0. Instead,
100000000 % 7812 = 6400, so 6400 ps is programmed on a 7.8 ns period.

Rates such as 19.44 MHz and 122.88 MHz also have periods that are not a
whole number of picoseconds. A 1 ms request at 19.44 MHz is exactly 19440
periods, but it folds to 6400 ps.

The read-back fold in sit9531x_output_phase_read() uses the same truncated
period.

> +	phase_norm_ps = phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;
> +	abs_ps = (phase_ps < 0 && abs_ps) ? t_out_ps - abs_ps : abs_ps;
> +
> +	if (abs_ps) {
> +		u64 rem_ps, err, up_ps;
> +

[ ... ]

> +		coarse = mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);
> +

[ ... ]

> +		coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +		rem_ps = (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;
> +		if (rem_ps) {
> +			u64 steps;
> +
> +			steps = div64_u64(rem_ps +
> +					  SIT9531X_OUT_PRG_FINE_STEP_PS / 2,
> +					  SIT9531X_OUT_PRG_FINE_STEP_PS);
> +			if (steps > SIT9531X_OUT_PRG_FINE_MAX)
> +				steps = SIT9531X_OUT_PRG_FINE_MAX;
> +			fine = (u8)steps;
> +		}
> +		err = abs_diff(abs_ps, coarse_ps +
> +			       (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS);
> +		up_ps = mul_u64_u64_div_u64(coarse + 1, 1000000000000ULL,
> +					    fvco);
> +		if (up_ps - abs_ps < err) {
> +			coarse++;
> +			fine = 0;
> +		}

[Severity: Low]
Is the previous coarse cycle ever considered here? The fine field goes up
to 7 * 30 = 210 ps, which is longer than one VCO period in every
supported band. So coarse - 1 with a large fine code can be closer, or
even exact.

At 5 GHz (200 ps per cycle), a 210 ps request gives coarse = 1 with a
10 ps remainder. fine rounds to 0, and 200 ps is programmed, even though
coarse = 0 with fine = 7 gives exactly 210 ps. prop.c says requests are
"rounded to the nearest achievable delay".

The quantizer is also not idempotent for such encodings. A profile holding
coarse 0 / fine 7 seeds phase_adj = 210 and phase_armed = true. The next
frequency_set re-encodes it as 200 ps, which rewrites the registers and
flushes the PLL.

[ ... ]

> +	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +	if (rc) {
> +		/* The delay is programmed but not re-timed; same reasoning. */
> +		sitdev->out[out_idx].phase_stale = true;
> +		return rc;
> +	}
> +	sitdev->out[out_idx].phase_stale = false;

[Severity: Medium]
Is a failed flush here ever retried? The delay bytes can be committed and
then sit9531x_output_phase_flush() can fail, for example on its first
CONFIG47 read. When that happens, phase_stale is the only record of the
failure.

On a retry, dpll_pin_phase_adj_set() calls phase_adjust_get() first.
Because phase_stale is set, sit9531x_dpll_output_pin_phase_adjust_get()
reads the newly programmed bytes, publishes that value and clears
phase_stale. It does not redo the flush.

For an on-grid request, the core then sees:

	if (phase_adj == old_phase_adj)
		return 0;

and never calls the setter. For an off-grid request the setter does run,
but phase_stale is already clear, so it takes the shortcut:

	if (!memcmp(old_bytes, new_bytes, sizeof(new_bytes)) &&
	    !sitdev->out[out_idx].phase_stale)
		goto cache;

Either way the realignment never happens, although phase_stale exists to
force a rewrite after this kind of failure. Should a pending flush be
tracked separately from an unconfirmed cache?

[ ... ]

> @@ -2753,12 +3151,37 @@ static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)

[ ... ]

> +		mutex_lock(&sitdev->multiop_lock);
> +		rc = sit9531x_output_phase_read(sitdev, i, &phase_ps);
> +		mutex_unlock(&sitdev->multiop_lock);
> +		if (!rc) {
> +			sitdev->out[i].phase_adj = phase_ps;
> +			sitdev->out[i].phase_armed = !!phase_ps;

[Severity: Medium]
Can this seed a clamped value that a later rate change then writes to the
device? sit9531x_output_phase_read() saturates to +1 ms and returns
success when both the delay D and T_out - D are larger than
SIT9531X_OUT_PHASE_ADJ_MAX_PS.

Take a 1 PPS output whose profile holds a 10 ms reset delay. Probe stores
phase_adj = 1000000000 and phase_armed = true. The next unrelated
frequency_set on that output calls
sit9531x_output_phase_adjust_set(1000000000) from
sit9531x_output_freq_set(). That encodes different bytes, so the driver
writes, commits and flushes a 1 ms delay, and the profile's 10 ms delay is
lost. Before this patch, the frequency setter did not touch these
registers.

The getter also reports +1 ms while the hardware holds 10 ms. A request
for exactly +1 ms is therefore dropped by dpll_pin_phase_adj_set() and
never reaches the device.

Two comments seem to overstate the design:

- sit9531x_output_freq_set() says it re-encodes "whatever was asked for",
  but it actually re-encodes the folded or clamped cache.
- The @phase_armed doc in core.h says a rate change re-times the delay
  "even when it quantized to zero". In that case the cached value is 0, so
  the re-time programs 0 and clears phase_armed.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> index 42f3e53b6def2..02181e8bbaf8f 100644
> --- a/drivers/dpll/sit9531x/prop.c
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -228,6 +228,26 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
>  		props->dpll_props.capabilities =
>  			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
>  		curr_freq = sitdev->out[index].freq;
> +
> +		/*
> +		 * Allow phase-adjust over a +/-1 ms window.  The subsystem
> +		 * rejects pin_set(phase-adjust, X) when X falls outside
> +		 * [min, max], so leaving these at 0 silently blocks every
> +		 * netlink call.  1 ms is well beyond the DCO dynamic range
> +		 * but costs nothing.  Only outputs get a range: input pins

[Severity: Low]
Is "well beyond the DCO dynamic range" accurate? The PRG_RST_DELAY coarse
field is 34 bits of VCO cycles, about 3.4 s at 5 GHz, and requests are
folded modulo one output period. On a 1 PPS output, the hardware can
therefore realize delays anywhere in the 1 s period. The setter's own
comment mentions "abs_ps approaches one second of 1 PPS wrap-around".

On slow outputs, the +/-1 ms window is narrower than what the hardware can
do. The real limit is the s32 picosecond uAPI (about +/-2.147 ms), not the
device.

The commit message makes the same claim:

  The window advertised to the core is one millisecond either way, which is
  wider than the dynamic range but costs nothing

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
