Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465793;
	b=J7X8gdMHLWu6C1f+8jjLh/7G0X2BTmgrXFepjlWEGOAInmgoUpN8oOsrFA5taFkuSMNF
	 a9bbQFAt6IFbjU8CemI1EZDsenOtCSOWXqHGp5xL/rhISAd9t8Jvh9HRX/u0ZwHtyJ/qd
	 RvFLu21Ta/ny95+LSoTZkTLxOeM11kSAwOfwa01zJexU26TK64a/mIZCxuDTK4p2HjtwQ
	 oq+ZrSRz0OJZNMXS7kG9hDvDSIZ2fRIXx7JSKkc1lmXnVjlWx4gDap/JSd1CP3vS9jNbE
	 19ZkKYBb97kdu6Bf5pEEAr/MYxzgjdWuyMovvlzcxsKXBafa7IdrcnbN99lAvT+ZPLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465793;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QdU5uGpr9zrsJfJKkQG9WuHZVN3chv636h+Qpk0Ql+8=;
	b=DrxcEAZ+fHSi5hY3CQoFriox//Z3fayMhJ0c8DTLM/HaQ7EdO7TFQSl/LLefMC8HjXZi
	 uQTpMYm8tRiy4yuJ4N11EGDblcUZcsj6qP35orGVRAAQy0kSbz9dAvUqe+hvEA+X4HWoZ
	 ypA7wAYSHRaHM3FacgZ7vej73QCKKZSdY/K/xLYiY2ze4ObyMADzBx+bGk12mTktp4J2U
	 MeB8YfZV69bgzl8d6nvnqds9HcIy8F4RSAjqNUJr7osy5U7JI3B7SEvZiddpWzvks6FUe
	 xZmOvGPXx3TfDuP7ks+oT3fvGIssjC2rpmy15255ihmz5663Ucy3cDeUzHNJ9whRNGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQylJBVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A241606A321;
	Tue, 20 Oct 2026 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQylJBVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FBD1F000C9;
	Tue, 20 Oct 2026 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465792;
	bh=QdU5uGpr9zrsJfJKkQG9WuHZVN3chv636h+Qpk0Ql+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dQylJBVi8dvC3aZ0zFo55neA4VQTA2homu1Hi2cp6Uu/d3VQ7lpg5GfAbtDKSYX5Y
	 ocw2/USgMRHeLnn19VPA8FBmOXPesi8ZavQjgf7He/GjsjmPrAEm+rY7ipVBSTpZyP
	 BmCE7FpI9KPQEuRnL19OIzxjMzFh6dIxbTDUYtBHvNOXWXx0whqUoaz2zW9qBTEdIL
	 XCBsH5Edgw1Qpw/eVxDOTMST7LsNz8HFXpC6TDQ5u3/nbL9y6aSgqm9T8vwou4EYHF
	 7xSISQjt1R/xwl2RuVyH1/xeq1SlP0KwEgRmnnvZdplUG7ltXshhTPStQoP3wqmdQf
	 MYjiVRZfGiNhQ==
Subject: Re: [PATCH net-next v14 10/12] dpll: sit9531x: add support to adjust
 output phase
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:51 +0000
Message-ID: <179246579138.3135.15760209396565800332@kernel.org>
In-Reply-To: <20261016005823.13690-11-arouhi@sitime.com>
References: <20261016005823.13690-11-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 9 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The reported phase value for an advance depends on history, so
  the same register contents can give two different uAPI values and two…
- [Medium] The 'owed flush' recovery tracked by @flush_pending cannot be
  reached by an identical retry, because the DPLL core drops that retry…
- [Medium] A profile delay that cannot be represented is reported as
  exactly +1 ms.
- [Medium] sit9531x_dpll_output_pin_phase_adjust_set() returns an error
  without a pin change notification, even after…
- [Medium] The flush is PLL-wide, but the record of a committed-but-
  unapplied delay is kept per output.
- [Medium] When a profile leaves an output with a delay beyond +/-1 ms,
  sit9531x_dev_state_fetch (core.c:3539-3540) caches it at probe as the…
- [Medium] sit9531x_output_phase_adjust_set() converts picoseconds into
  VCO cycles using the Fvco from sit9531x_get_fvco(), without the in-…
- [Medium] sit9531x_output_phase_adjust_set() treats every error from
  sit9531x_output_phase_flush() as proof that the delay was not applied,…
- [Medium] sit9531x_output_freq_set() writes the new DIVO first and the
  re-timed PRG_RST_DELAY bytes second, in the same PRG_CMD window.
- [Low] The kernel-doc of sit9531x_dpll_output_pin_phase_adjust_get()
  says it 'Returns what the delay registers hold, i.e. the value…
- [Low] core.h documents @flush_pending as 'the programmed delay is
  committed but the flush that applies it failed'.

--

dpll: sit9531x: add support to adjust output phase

This commit adds phase adjust support for sit9531x outputs. It programs
the per-output PRG_RST_DELAY coarse and fine delay registers and
advertises a +/-1 ms range at 1 ps granularity. Requests are folded into
one output period and advances are held as complementary delays. A rate
change re-times a programmed delay in the same programming window, and
the failure paths track stale caches and owed phase flushes per output.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 9aa0d327b6bf6..ffed2aaf8a345 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2267,11 +2267,431 @@ static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_idx,

[ ... ]

> +static int sit9531x_output_phase_encode(u64 fvco, u64 divo, s32 phase_ps,
> +					u64 *coarse_out, u8 *fine_out,
> +					s32 *phase_adj)
> +{

[ ... ]

> +	if (phase_norm_ps < 0)
> +		*phase_adj = abs_ps ?
> +			     -(s32)min_t(u64, t_out_ps - abs_ps,
> +					  SIT9531X_OUT_PHASE_ADJ_MAX_PS) : 0;
> +	else
> +		*phase_adj = (s32)min_t(u64, abs_ps,
> +					 SIT9531X_OUT_PHASE_ADJ_MAX_PS);

[Severity: Medium]
Does the reported phase now depend on history rather than on what the
registers hold?

A negative request always caches the advance form here, whatever the
period. sit9531x_output_phase_read() runs at probe and on a phase_stale
read-back, and it only reports the advance form when the period is longer
than 1 ms:

    if (ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS &&
        t_out_ps - ps <= SIT9531X_OUT_PHASE_ADJ_MAX_PS) {

Take a 10 MHz output from a 5 GHz VCO (divo = 500, T_out = 100000 ps). A
request of -100 ps encodes coarse = 499, fine = 3 (99890 ps) and caches
-110. After a driver reload or a stale read-back, the same registers
report +99890.

On a later rate change to 5 MHz, sit9531x_output_freq_set() re-encodes
whichever form is cached. With -110 cached it writes a 199890 ps delay.
With +99890 cached the bytes match, nothing is written, and the delay
stays at 99890 ps, which is a different edge.

The commit message says:

  "An advance is held as the complementary delay and reads back as an
  advance only where the period exceeds the advertised window; elsewhere
  the two describe the same edge and the delay form is reported."

Is that accurate? The advance form is reported after every successful
set, and the two forms only describe the same edge while the rate stays
fixed.

[ ... ]

> +int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,
> +			       s32 *phase_ps, bool *clamped)
> +{

[ ... ]

> +	if (!rc) {
> +		u64 t_out_ps = mul_u64_u64_div_u64(divo, 1000000000000ULL,
> +						   fvco);
> +
> +		if (ps >= t_out_ps)
> +			ps -= t_out_ps;
> +		if (ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS &&
> +		    t_out_ps - ps <= SIT9531X_OUT_PHASE_ADJ_MAX_PS) {
> +			*phase_ps = -(s32)(t_out_ps - ps);
> +			return 0;
> +		}
> +	}
> +	*clamped = ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS;
> +	*phase_ps = (s32)min_t(u64, ps, SIT9531X_OUT_PHASE_ADJ_MAX_PS);

[Severity: Medium]
Can a request for exactly +1 ms become a silent no-op here?

Take a profile delay that is outside the window and whose complement is
outside it too, such as a 5 ms delay on a 1 PPS output. This reports
+1000000000 ps, and sit9531x_dev_state_fetch() seeds that value into
out->phase_adj.

That value is inside the advertised range. A user request for +1 ms
passes the range check and then hits this in dpll_pin_phase_adj_set():

	if (phase_adj == old_phase_adj)
		return 0;

Userspace is told the output now has a +1 ms delay, but the registers
still hold the profile's 5 ms delay.

[ ... ]

> @@ -2280,11 +2700,45 @@ int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,

[ ... ]

>  	rc = sit9531x_prg_enter(sitdev);
>  	if (rc)
>  		return rc;
>  
>  	rc = sit9531x_output_divo_write(sitdev, out_idx, divo);
> +	if (!rc && retime)
> +		rc = sit9531x_output_phase_bytes_write(sitdev, out_idx,
> +						       new_bytes, old_bytes);

[Severity: Medium]
What happens to the new divider if sit9531x_output_phase_bytes_write()
fails here?

The rollback in sit9531x_output_phase_bytes_write() only restores the
delay bytes. The fully written DIVO stays in place, sit9531x_prg_commit()
makes it live, and the function returns an error without running
sit9531x_output_phase_flush().

The output then runs at the new rate with no realignment. An advance
still encoded as T_old - |adv| now counts against T_new.

The frequency getter reads DIVO back from hardware and reports the new
rate, so dpll_pin_freq_set() drops an identical retry:

	if (freq == old_freq)
		return 0;

This happens even though userspace was told the request failed. Before
this patch, a fully written divider was always followed by a commit and a
flush.

[ ... ]

> @@ -2374,27 +2866,140 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,

[ ... ]

> +int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
> +				     u8 out_idx, s32 phase_ps)
> +{

[ ... ]

> +	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +	if (rc)
> +		return rc == -ENODATA ? -ENODEV : rc;

[Severity: Medium]
Should this refuse an out-of-band Fvco, the way
sit9531x_output_divo_calc() does?

sit9531x_get_fvco() returns success for a Fref * DIVN outside the VCO
band, and its own comment says a set refuses to program against such a
rate. sit9531x_output_divo_calc() follows that:

	if (!sit9531x_fvco_in_band(pll_idx, fvco)) {
		...
		return -EINVAL;
	}

Here the estimate goes straight into sit9531x_output_phase_encode(). On
such a PLL (one fed from another PLL, for example), the delay is
programmed with the wrong scale and reported as exact.

The read-back uses the same estimate, so the error would not show up.

[ ... ]

> +	if (!memcmp(old_bytes, new_bytes, sizeof(new_bytes)) &&
> +	    !sitdev->out[out_idx].phase_stale) {
> +		if (!sitdev->out[out_idx].flush_pending)
> +			goto cache;
> +		goto flush;
> +	}

[Severity: Medium]
Can an identical retry ever reach this flush_pending path?

dpll_pin_phase_adj_set() calls phase_adjust_get() first, and returns
without calling the driver when the two values match:

	if (phase_adj == old_phase_adj)
		return 0;

dpll_pin_freq_set() does the same for the rate. Here are the paths that
set flush_pending.

When sit9531x_output_freq_set() hits a flush failure with retime set, it
stores the committed value in the cache:

		sitdev->out[out_idx].flush_pending = true;
		if (retime) {
			sitdev->out[out_idx].phase_adj = phase_adj;

The getter then publishes the committed value, and a retry of it is
dropped. The comment next to that code argues the opposite.

When that flush fails without retime, the cache already matches the
registers, so a retry is dropped as well.

A commit failure in either setter sets phase_stale and flush_pending. The
read-back in sit9531x_dpll_output_pin_phase_adjust_get() then publishes
whatever landed and clears phase_stale, so an identical retry is dropped
again.

The only request that seems to reach goto flush is one that differs from
the reported value but quantizes to the same bytes, say 1 ps off. Until
then the output runs unaligned while the pin reports success.

This seems to contradict the @flush_pending kernel-doc ("the next request
for that delay runs the flush although the registers already hold it").
It also contradicts the commit message:

  "a flush that failed after the delay was committed is retried by the
  next request"

[ ... ]

> +flush:
> +	/*
> +	 * Restart the output divider phase so the freshly programmed delay is
> +	 * applied against a known edge instead of the divider's arbitrary
> +	 * running phase.
> +	 */
> +	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +	if (rc) {
> +		/*
> +		 * The delay is committed but the output keeps the phase it
> +		 * had, so the cache is left as it is: it still says what the
> +		 * output realizes.  Record the flush that is owed instead.

[ ... ]

> +		sitdev->out[out_idx].flush_pending = true;
> +		return rc;
> +	}

[Severity: Medium]
Does every error from sit9531x_output_phase_flush() mean the delay was not
applied?

The flush can write DIVO_PHASE_TRIG successfully, which latches the
realignment, and then fail while restoring GPIO_FUNC_CTRL1, while
disarming, or while unparking the other PLLs:

	ret = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);
	if (ret && !rc)
		rc = ret;

In that case the output already runs the new delay X. The getter still
reports the old value Y, and phase_stale stays false.

A request for Y is then dropped by the core. A request for X takes the
flush_pending path and fires another PLL-wide restart.

> +	sitdev->out[out_idx].flush_pending = false;
> +	sitdev->out[out_idx].phase_stale = false;

[Severity: Medium]
The flush restarts every output divider of the PLL, but this bookkeeping,
and the bookkeeping in sit9531x_output_freq_set(), is per output.

What happens to a delay on output A that was committed but not applied,
when a later flush on the same PLL succeeds?

After the flush failure above, out[A] still holds Y with only
flush_pending set, while the registers hold X. Any later successful flush
of that PLL applies X. That flush can come from:

  a rate change on A with phase_armed false. Retime is false, so only
  flush_pending is cleared and the cache stays at Y.

  a rate or phase change on a sibling output B, which only updates out[B].

Either way the getter keeps reporting Y. A request to go back to Y,
including 0 to clear the delay, is dropped by the core, and the output
stays at X.

In the sibling case out[A].flush_pending is never cleared. A later
matching request on A then fires an unneeded PLL-wide restart. That is an
edge jump on every output of the PLL, or a loss of lock without PHFL_EN.

The mirror case looks similar. If the flush fails on a clear (X = 0),
phase_armed stays true with Y cached. The next rate change re-encodes Y
and undoes the committed clear.

[ ... ]

> @@ -2910,6 +3518,32 @@ static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)

[ ... ]

> +		mutex_lock(&sitdev->multiop_lock);
> +		rc = sit9531x_output_phase_read(sitdev, i, &phase_ps, &clamped);
> +		mutex_unlock(&sitdev->multiop_lock);
> +		if (!rc) {
> +			sitdev->out[i].phase_adj = phase_ps;
> +			sitdev->out[i].phase_armed = !clamped && phase_ps;

[Severity: Medium]
For a clamped profile delay, what keeps phase_adj in sync with the
registers after a rate change?

With phase_armed false, sit9531x_output_freq_set() skips the re-time
block. It refreshes the cache only when retime is set, and it never sets
phase_stale for this output.

sit9531x_output_phase_read() folds the raw coarse count modulo the current
DIVO. After a successful rate change the same registers can therefore
describe a different delay, possibly one inside the window. The getter
keeps returning the clamped 1 ms figure.

That breaks the @phase_adj description ("what the delay registers
actually realize") and the @phase_stale description ("the programmed delay
may differ from @phase_adj"). A user request equal to the stale value is
also dropped by the core.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 1464ba0b66142..0c42bfc05b0b2 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -104,6 +106,18 @@ struct sit9531x_ref {

[ ... ]

> + * @flush_pending:	the programmed delay is committed but the flush
> + *			that applies it failed, so the output still realizes
> + *			@phase_adj; the next request for that delay runs the
> + *			flush although the registers already hold it

[Severity: Low]
This may only be a documentation issue, but is this description narrower
than how the flag is used?

sit9531x_output_freq_set() sets flush_pending on both its commit-failure
and flush-failure paths, whatever phase_armed and retime are. That
includes plain rate changes on outputs with no delay at all:

		if (sitdev->out[out_idx].phase_armed)
			sitdev->out[out_idx].phase_stale = true;
		sitdev->out[out_idx].flush_pending = true;

sit9531x_output_phase_adjust_set() then treats the flag as meaning a flush
is owed, so a later phase request whose bytes already match fires a
PLL-wide flush.

Should the field description also cover an owed divider realignment?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index f6e76318a567a..b3719370901eb 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -959,12 +959,92 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustment
> + *
> + * Returns what the delay registers hold, i.e. the value
> + * sit9531x_output_phase_adjust_set() programmed after quantization,
> + * read from the cache unless a failed request left it unconfirmed.
> + */

[Severity: Low]
Is this accurate after a flush failure?

In that case sit9531x_output_phase_adjust_set() deliberately keeps
phase_adj at the previous value ("the cache is left as it is"), while the
registers hold the new delay. The getter then returns a value the
registers do not hold.

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "Phase adjust failed");
> +		return rc;
> +	}

[Severity: Medium]
Should this path send a pin change notification when the reported value
may have moved?

When sit9531x_output_phase_adjust_set() fails after its writes reached
the device, it sets phase_stale, and the next getter call can report a
different value.

The core only notifies on success, and the poll does not watch the delay
registers, so subscribers keep the old value.

sit9531x_dpll_intsync_src_state_on_dpll_set() and the output state
setter handle the same situation with a notification:

		dpll_pin = READ_ONCE(dpin->dpll_pin);
		if (moved && dpll_pin)
			__dpll_pin_change_ntf(dpll_pin);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
