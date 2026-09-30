Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6B3FE37A;
	Wed, 30 Sep 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751446; cv=none; b=lVDbzGKLFMvo31zltTZ+lxUb2wr+U9fAXd4fUAMwvqy04fy6v9b2+Igvud1Uk/P3pjoOH9xRwWgEpoXnRPUO5wJWenUprOE6dObUahsF1YRzYT+rJ9n85IVxQaqcdyTHVx1Z2KbXbVh7w+xHmOEzC5pk1glu0Hd+iQqqVvAig5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751446; c=relaxed/simple;
	bh=UYoH5BQVrBn/CZBX7cLBtMuuAAiXPMl23lm4OTlUzac=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3hk7rcKh4L7oecGftbUimqYI1A5KprhU3u04BBtVkmuMQ0tsFBTJrcw5jrWAxZIZ6EGzjdFCPLcj3P5XiHghjIOcTvl0Oeox5I3iliSM7IfC9oaVqEkhWEFg89Wv2SubaHKcPHUeHTz0Gcos1ip81wcb1PGZPnbVvEFtXa3hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7FkyUIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7FkyUIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29861F00898;
	Wed, 30 Sep 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751434;
	bh=HmAXF1quhJ4EUgDx4TN1SB8pgNKFb2UGFX8jY2PzUq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m7FkyUIh3cn+i8kf43/JyExB5VCNQhJYi4gNtqW/1MVjUoQyqXXkJC6qrMTmI3MNU
	 jOZcwj3uRWAToOjDBq69xrtjb23nO+xsFCKT2LhP7a23exlgY54VhMcqxbg2ejO++n
	 R1Wg+flWXiNbkjcSlh01qIYxlINbY0MdcKlPEWWpHpRcPF3Bu5+KcjTH2AWWoETByL
	 EREmoMPjmGG4s5iVkALyxSqtgHxr4N/nWY1zUSgAruaT1SQIsQceo6/M3yJJnVp8sc
	 P1HgrKj1pCryd1NW50J4eyfNfLx2DAL/FkwpyyPOSGS4ABif5o+MRoG3v9JbNBL1t1
	 T91FcyFXTr8QQ==
Subject:
 Re: [PATCH net-next 3/6] dpll: zl3073x: allow enabling/disabling output pins
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org, jiri@resnulli.us,
 min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 06:57:13 +0000
Message-ID: <179075143358.434549.273733940449539275@kernel.org>
In-Reply-To: <20260928185552.1103515-4-ivecera@redhat.com>
References: <20260928185552.1103515-4-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On CMOS outputs, the output-wide STOP bit is mixed up with the
  per-pin GPO state.
- [Medium] CMOS output pins that firmware or board configuration set up
  as GPO status, IRQ or unknown-mode outputs…
- [Medium] The error path of zl3073x_dev_output_pin_state_set() does not
  close the stop/restart bracket symmetrically, for either CMOS pin.
- [Medium] The settle delay before the non-glitch-free GPO toggle in
  zl3073x_dev_output_pin_state_set() may be too short.

--

dpll: zl3073x: allow enabling/disabling output pins

This commit adds state_on_dpll_set support for zl3073x output pins.
Differential pins are toggled through the output_ctrl_x::stop bit. CMOS
pins are muted/unmuted through a GPO override, bracketed by a stop/restart
of the whole output. Output pins now advertise
DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE.

> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 7386932df032..89cf46111dcb 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c

[ ... ]

> @@ -667,6 +669,82 @@ int zl3073x_dev_gpo_set(struct zl3073x_dev *zldev, u8 gpo, bool value)

[ ... ]

> +int zl3073x_dev_output_pin_state_set(struct zl3073x_dev *zldev, u8 id,
> +				     bool enable)
> +{

[ ... ]

> +	/* Bracket the GPO override toggle below with a clean stop/restart,
> +	 * since the toggle itself is not glitch-free.
> +	 */
> +	zl3073x_out_stop(&out);
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +	if (rc)
> +		return rc;
> +
> +	/* output_ctrl_x::stop is edge-aligned, so the device can take up
> +	 * to half a period to actually reach the stopped state. Wait for
> +	 * that long plus 25 ms, to make sure it is really stopped before
> +	 * touching the GPO override below.
> +	 */
> +	delay = 25 * USEC_PER_MSEC;
> +	freq = zl3073x_dev_output_pin_freq_get(zldev, id);
> +	if (freq)
> +		delay += USEC_PER_SEC / 2 / freq;
> +	fsleep(delay);

[Severity: Medium]
Is this delay always long enough? zl3073x_dev_output_pin_freq_get() returns
an integer Hz value:

drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
    ...
	freq = zl3073x_synth_freq_get(synth) / out->div;

	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
		freq /= out->esync_n_period;
    ...
}

Sub-Hz rates truncate to 0. Take an N-div N pin with P at 1 Hz and
esync_n_period = 2, which runs at 0.5 Hz. freq becomes 0, so the half-period
term is skipped. The code then waits only 25 ms, while the real half period
is about 1 s.

Also, only the requested pin's frequency is used. On an N-div output, the
P pin's delay comes from the fast P rate. If the device aligns the stop of
the whole output to the slower N edge, could the P pin still be running
when its GPO override is toggled? This second case depends on how the
hardware aligns the stop, so it is less certain.

In either case, can the GPO mux switch while the clock is still active and
produce the runt pulse that the stop/restart bracket is meant to prevent?
This code is still the same at the end of the series.

> +
> +	if (enable) {
> +		zl3073x_out_pin_func_set(&out, id, ZL3073X_OUT_PIN_F_CLOCK);

[Severity: Medium]
What happens here to a CMOS pin that firmware or the board set up as a GPO
status, IRQ or unknown-mode output (ZL3073X_OUT_PIN_F_GPO_STATUS,
ZL3073X_OUT_PIN_F_GPO_IRQ or ZL3073X_OUT_PIN_F_GPO_UNKNOWN)?

zl3073x_dpll_pin_is_registrable() only checks synth/output enablement and
signal format, so these pins are still registered.

Before this patch, every registered output pin reported connected. Now
zl3073x_dev_output_pin_state_get() reports these pins as disconnected,
because their function is not CLOCK:

	return zl3073x_out_is_diff(out) ||
	       zl3073x_out_pin_func_get(out, id) == ZL3073X_OUT_PIN_F_CLOCK;

zl3073x_pin_props_get() also now sets DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE
on every output pin.

A connect request then reaches this zl3073x_out_pin_func_set() call. It
clears gpo_en and throws away the status/IRQ function. A clock is then
driven onto a line the board may have wired as a lock-status or interrupt
signal.

A later disconnect writes GPO_CONST low, so the DPLL API can never restore
the original function.

Should pins with a GPO status/IRQ function be excluded from state changes,
or at least not advertise STATE_CAN_CHANGE? Neither the commit message nor
the rest of the series covers these pins.

> +	} else {
> +		rc = zl3073x_dev_gpo_set(zldev, id, false);
> +		if (rc)
> +			goto restart_output;
> +		zl3073x_out_pin_func_set(&out, id, ZL3073X_OUT_PIN_F_GPO_CONST);
> +	}
> +
> +	/* Restart the output regardless of the result below: on failure,
> +	 * don't leave the whole output, including the unrelated sibling
> +	 * pin, stopped indefinitely.
> +	 */
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +
> +restart_output:
> +	zl3073x_out_start(&out);
> +	rc = zl3073x_out_state_set(zldev, out_id, &out) ? : rc;

[Severity: Medium]
What does this restart do if the zl3073x_out_state_set() call just above
fails?

zl3073x_out_state_set() writes ctrl first. It stores dout->cfg only after
a successful mailbox commit:

drivers/dpll/zl3073x/out.c:zl3073x_out_state_set() {
    ...
	if (dout->ctrl != out->ctrl) {
		rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_CTRL(index),
				      out->ctrl);
		...
		dout->ctrl = out->ctrl;
	}

	/* Skip the mailbox commit if nothing else has changed */
	if (!memcmp(&dout->cfg, &out->cfg, sizeof(out->cfg)))
		return 0;
    ...
	/* After successful commit store new state */
	dout->cfg = out->cfg;
    ...
}

After a failed GPO commit, the local out holds the new gpo_en/gpo_config
values and the cache still holds the old ones.

The restart call writes ctrl first, which clears STOP and starts the output
again. It then sees the cfg difference and retries the same GPO mailbox
commit while the output is running. Isn't that the non-glitch-free toggle
the bracket is supposed to prevent?

If the retry succeeds, the restart call returns 0 and "? : rc" keeps the
earlier error.

zl3073x_dpll_output_pin_state_on_dpll_set() then reports "Failed to change
output pin state". dpll_pin_state_set() also skips __dpll_pin_change_ntf(),
even though the hardware and zldev->out[] now hold the new pin state.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 2c6de4dab8b4..426974b0b5dc 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> +static int
> +zl3073x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,

[ ... ]

> +	guard(mutex)(&zldpll->lock);
> +
> +	enable = state == DPLL_PIN_STATE_CONNECTED;
> +	if (zl3073x_dev_output_pin_state_get(zldev, pin->id) != enable) {
> +		rc = zl3073x_dev_output_pin_state_set(zldev, pin->id, enable);

[Severity: Medium]
Can a disconnect request on a CMOS pin be silently dropped here?
zl3073x_dev_output_pin_state_get() returns false for both P and N whenever
the output-wide STOP bit is set, whatever each pin's GPO function is:

	if (zl3073x_out_is_stopped(out))
		return false;

A CMOS output can be stopped in two ways:

- At probe. zl3073x_dpll_pin_is_registrable() does not reject stopped
  outputs, so an output that firmware left stopped is still registered.
- After the final restart write in zl3073x_dev_output_pin_state_set()
  fails.

Take a stopped CMOS output where N is still in CLOCK function:

  disconnect N
    zl3073x_dev_output_pin_state_get(N) returns false, same as enable
    -> returns 0, N stays in CLOCK function

  connect P
    zl3073x_dev_output_pin_state_set(P, true)
      zl3073x_out_start(&out)    <- restarts the whole output

Wouldn't N then drive its clock again, even though userspace was told N is
disconnected?

Changing one pin can also change the sibling's state:

- Restarting a stopped output moves the sibling from disconnected to
  connected.
- A failed final restart moves the sibling from connected to disconnected.

dpll_pin_state_set() only calls __dpll_pin_change_ntf() for the pin that
was requested.

Should this follow the pattern that the earlier patch in this series, "dpll:
zl3073x: notify sibling pin when shared output config changes", added to
zl3073x_dpll_output_pin_phase_adjust_set()?

	sibling = zl3073x_dpll_output_pin_sibling_get(pin);

	mutex_unlock(&zldpll->lock);

	if (sibling)
		__dpll_pin_change_ntf(sibling->dpll_pin);

This is still present at the end of the series. The PTP perout
enable/disable helpers added in "dpll: zl3073x: add PTP periodic output
support" call the same zl3073x_dev_output_pin_state_get() and
zl3073x_dev_output_pin_state_set() pair.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928185552.1103515-1-ivecera%40redhat.com
