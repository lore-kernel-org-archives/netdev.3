Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0A47DD75;
	Tue, 18 Aug 2026 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071072; cv=none; b=B8mx/hlCxSwy6GSxg11KVUcfcFjXEBd90ib3raMq9/kyIRMvQg3MqZcPO2m44QSCoJ6ooo5+uu4CCCGl1p8KD7iZJj35aVhgP0KkC6O2Aoqxgt845jcI/qwrRsytjQea1YnaJ9kOpB2MfCFqqmkoKKZ8InygWdSo0Z29SERM8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071072; c=relaxed/simple;
	bh=cScN8e7SwLpJlTm/GZTE07E2bcqgcrjjKXUyKlU0dYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auih+hn1ijC8Ouf/cBj6SHnhBXgU7WbtvWuLXR47VJVJQix7tELRfBOF/1xP7k5mx9dkh3AlrD0fYcxVVRL8PV6YeazCuSynVDlUC2n0FsifyuAmw6jPRAnb3/OANRSQELQ5kDwQN+p6HF6AEXVqrX196xGrzrD05iG/gCsddsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQaw18S+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQaw18S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B442C1F00A3A;
	Tue, 18 Aug 2026 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071070;
	bh=vtL6p9J5OfMYga2s5sLGwnQ1CRuk+Ch84q80ZYWCZKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQaw18S+LRtoV5fE8ZBurtaWrdTBfq5wCKY1s3YoZMQhlUxOa+BSPUA9qCtsFAI6d
	 qrERgAq7TRjbJL4ivjboRDKnqgzwG1gTKU6rTNb5wFe1vtzhCqbW/jJrUw+hB1fN9L
	 VADyCPYzorSfsPzvWMO6vYcWSRdhpZfLwdXYacCRktlPptzV38jY75XlQH2uj7hchT
	 jdeb6dGp+pbFosJzGXM8DkwUu0fk8Fc4+127T9scaIdCXr8xbD5624AXGqOGaR+GTG
	 uzVjchJiQhhEntvkILRoXMaYc7VqV1QIWrknrGDbqrTcrXSIjs66gy2JBC/Njlrg4+
	 vFnyXgWI16gug==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	poros@redhat.com,
	vadim.fedorenko@linux.dev,
	Chris.duQuesnay@microchip.com,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	min.li@microchip.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/3] dpll: zl3073x: add PTP clock support
Date: Tue, 18 Aug 2026 09:37:48 -0700
Message-ID: <20260818163748.3988860-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814082656.306534-4-ivecera@redhat.com>
References: <20260814082656.306534-4-ivecera@redhat.com>
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
dpll: zl3073x: add PTP clock support

This registers a PTP clock device per DPLL channel and implements
gettimex64, settime64, adjtime, adjfine, adjphase and getmaxphase on top
of the existing ToD, TIE and output phase step helpers.  All callbacks are
serialized by the per-DPLL zldpll->lock mutex, and PTP_1588_CLOCK becomes
a hard dependency of the driver.

A few questions below.

> diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
> index 5bbca14005813..da1731ace15f0 100644
> --- a/drivers/dpll/zl3073x/Kconfig
> +++ b/drivers/dpll/zl3073x/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config ZL3073X
>  	tristate "Microchip Azurite DPLL/PTP/SyncE devices" if COMPILE_TEST
> -	depends on NET
> +	depends on NET && PTP_1588_CLOCK
>  	select DPLL
>  	select NET_DEVLINK
>  	select REGMAP
> @@ -16,7 +16,7 @@ config ZL3073X
>  
>  config ZL3073X_I2C
>  	tristate "I2C bus implementation for Microchip Azurite devices"
> -	depends on I2C && NET
> +	depends on I2C && NET && PTP_1588_CLOCK
>  	select REGMAP_I2C
>  	select ZL3073X
>  	help
> @@ -28,7 +28,7 @@ config ZL3073X_I2C
>  
>  config ZL3073X_SPI
>  	tristate "SPI bus implementation for Microchip Azurite devices"
> -	depends on NET && SPI
> +	depends on NET && SPI && PTP_1588_CLOCK
>  	select REGMAP_SPI
>  	select ZL3073X

[Severity: Low]
Should PTP_1588_CLOCK be a hard dependency here?

ZL3073X is only user-visible with COMPILE_TEST and is otherwise selected by
ZL3073X_I2C/ZL3073X_SPI, so on a tree with CONFIG_PTP_1588_CLOCK=n the
ZL3073X_I2C and ZL3073X_SPI prompts disappear on oldconfig and the whole
driver is dropped, including the DPLL, devlink/flash and SyncE
functionality that does not need PTP.

The new code compiles against the !PTP stubs (only ptp_clock_register()
returns NULL, which zl3073x_dpll_ptp_register() already treats as
success), which is what PTP_1588_CLOCK_OPTIONAL in drivers/ptp/Kconfig is
for:

	config PTP_1588_CLOCK_OPTIONAL
		tristate
		default y if PTP_1588_CLOCK=n
		default PTP_1588_CLOCK

Would depends on PTP_1588_CLOCK_OPTIONAL work here instead?  If the hard
dependency is intended, could the changelog mention that PTP becomes
mandatory for existing users?

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 83bd3027dbaa1..f2e137475b40f 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -2313,45 +2315,384 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)

[ ... ]

> +/**
> + * zl3073x_dpll_ptp_settime64 - set ToD counters to given time
> + * @info: PTP clock info
> + * @ts: timespec with time to set
>   *
> - * Return: pointer to DPLL device on success, error pointer on error
> + * Return: 0 on success, <0 on error
>   */
> -struct zl3073x_dpll *
> -zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
> +static int zl3073x_dpll_ptp_settime64(struct ptp_clock_info *info,
> +				      const struct timespec64 *ts)
>  {
> -	struct zl3073x_dpll *zldpll;
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
>  
> -	zldpll = kzalloc_obj(*zldpll);
> -	if (!zldpll)
> -		return ERR_PTR(-ENOMEM);
> +	guard(mutex)(&zldpll->lock);
>  
> -	zldpll->dev = zldev;
> -	zldpll->id = ch;
> -	mutex_init(&zldpll->lock);
> -	INIT_LIST_HEAD(&zldpll->pins);
> +	return zl3073x_chan_tod_write(zldpll->dev, zldpll->id, *ts);
> +}

[Severity: High]
Does settime64() need to compensate for the deferred ToD load?

zl3073x_chan_tod_write() only ever issues the next-1Hz-edge command:

drivers/dpll/zl3073x/chan.c:zl3073x_chan_tod_write() {
	...
	return zl3073x_chan_tod_ctrl(zldev, ch,
				     ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ);
}

so the value written becomes the counter value at the coming 1 Hz edge,
0..1 s after the register write.  zl3073x_chan_tod_ready_wait() budgets
ZL_POLL_TOD_WR_TIMEOUT_US (1000 ms) for exactly that pending write.

zl3073x_chan_tod_adjust() in the same driver compensates for this by
basing the write on the next-1Hz read:

drivers/dpll/zl3073x/chan.c:zl3073x_chan_tod_adjust() {
	...
	rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
	...
	/* Apply delta to the next-Hz ToD */
	ts_next = timespec64_add(ts_next, delta);
	...
	return zl3073x_chan_tod_write(zldev, ch, ts_next);
}

Here the caller's timespec is written verbatim, so after the edge the
counter reads ts while real time has advanced by the distance from the
call to that edge.  Does this leave the clock up to a second behind the
requested time on every clock_settime()?

Also, ts.tv_nsec is written raw.  If a caller passes a non-zero tv_nsec,
does the ToD second boundary end up displaced from the DPLL 1 Hz / output
1PPS phase, i.e. the coherence that adjtime() takes care to preserve by
routing sub-second deltas through phase step or TIE write?

> +/**
> + * zl3073x_dpll_ptp_adjtime_phase_step - adjust sub-second time via phase step
> + * @zldpll: DPLL channel
> + * @delta: time adjustment in nanoseconds (must be within (-NSEC_PER_SEC,
> + *         NSEC_PER_SEC))
> + *
> + * Uses the output phase step mechanism with tod_step=1 to adjust both
> + * the output clock phase and the ToD counter simultaneously. This keeps
> + * outputs and ToD coherent. Only valid for NCO.
> + *
> + * Outputs are grouped by synthesizer since the phase step value is in
> + * synthesizer clock cycles. The first synth group with enabled outputs
> + * uses tod_step to adjust both outputs and the ToD counter. Remaining
> + * groups step outputs only. If no synth has enabled outputs, the ToD
> + * counter is stepped alone using an empty output mask (the FW uses
> + * the first enabled synth's period for the conversion).

[Severity: Low]
This isn't a bug, but the kernel-doc of
zl3073x_dpll_ptp_adjtime_phase_step() speaks of "enabled outputs" while
the code filters on the device-global step-time mask instead:

	if (!zl3073x_dev_out_is_stepped(zldev, out_id))
		continue;

drivers/dpll/zl3073x/core.h:zl3073x_dev_out_is_stepped() {
	return !!(zldev->out_step_time_mask & BIT(index));
}

out_step_time_mask comes from ZL_REG_OUTPUT_STEP_TIME_MASK and says
nothing about whether an output is enabled, so an enabled, DPLL-owned
output that is absent from that mask is excluded from the phase step and
can also trigger the !tod_stepped ToD-only fallback.  Could the wording be
changed to refer to step-time-capable outputs?

> +	/* Process each synth group */
> +	for (i = 0; i < ZL3073X_NUM_SYNTHS; i++) {

[ ... ]

> +/**
> + * zl3073x_dpll_ptp_adjtime - adjust PTP clock time

[ ... ]

> +static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
>  {
> -	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
> +	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
> +						   ptp_info);
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	const struct zl3073x_chan *chan;
> +	bool sec_adjusted = false;
> +	struct timespec64 ts;
> +	int rc;
>  
> -	mutex_destroy(&zldpll->lock);
> -	kfree(zldpll);
> +	if (!delta)
> +		return 0;
> +
> +	guard(mutex)(&zldpll->lock);

[ ... ]

> +	if (delta >= NSEC_PER_SEC || delta <= -NSEC_PER_SEC) {
> +		s32 remainder;
> +
> +		ts.tv_sec = div_s64_rem(delta, NSEC_PER_SEC, &remainder);
> +		ts.tv_nsec = 0;
> +		delta = remainder;
> +
> +		rc = zl3073x_chan_tod_adjust(zldev, zldpll->id, ts);
> +		if (rc)
> +			return rc;
> +
> +		/* No sub-second remainder, done */
> +		if (!delta)
> +			return 0;
> +
> +		/* Wait for the ToD write to be applied at the 1 Hz edge
> +		 * before issuing phase step or TIE write, so the pending
> +		 * WR_NEXT_1HZ does not overwrite the sub-second adjustment.
> +		 */
> +		rc = zl3073x_chan_tod_ready_wait(zldev, zldpll->id);
> +		if (rc)
> +			return rc;
> +
> +		sec_adjusted = true;
> +	}

[Severity: Medium]
Is this error return reachable after the seconds are already committed?

zl3073x_chan_tod_adjust() ends in zl3073x_chan_tod_write(), which arms
ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ, so once it returns 0 the whole-second
step will latch at the next 1 Hz edge and cannot be revoked.  The
following zl3073x_chan_tod_ready_wait() can then fail:

drivers/dpll/zl3073x/chan.c:zl3073x_chan_tod_ready_wait() {
	...
	case ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ:
		timeout = ZL_POLL_TOD_WR_TIMEOUT_US;
	...
	return rc == -ETIMEDOUT ? -EBUSY : rc;
}

with ZL_POLL_TOD_WR_TIMEOUT_US == 1000 ms while zl3073x_chan_tod_adjust()
only guarantees a 20 ms margin before the edge, so the pending write can
need nearly the full second to retire.  A plain regmap read error gives
the same exit.

That return happens before sec_adjusted = true, so this is the one error
path that is not covered by the compensating logic further down:

	if (rc && sec_adjusted) {
		dev_warn(zldev->dev,
			 "Sub-second adjustment failed after seconds applied\n");
		return 0;
	}

Does the caller then get a failure for an adjustment whose seconds part is
already applied, with the sub-second remainder dropped?  If the servo or a
clock_adjtime(ADJ_SETOFFSET) user re-issues the same delta after the edge
has passed, is the whole second applied twice?

> +
> +	/* Apply sub-second delta via phase step (NCO) or TIE write */
> +	if (zl3073x_chan_mode_is_nco(chan)) {
> +		rc = zl3073x_dpll_ptp_adjtime_phase_step(zldpll, delta);
> +		if (!rc)
> +			return 0;
> +	} else {
> +		rc = zl3073x_chan_tie_write(zldev, zldpll->id, delta);
> +		if (!rc)
> +			return 0;
> +	}

[Severity: Medium]
Does the same pending WR_NEXT_1HZ hazard exist across callback
invocations?

The comment above acknowledges the hazard within one adjtime() call, but
the drain only runs when the seconds branch was taken.  For |delta| < 1 s
sec_adjusted stays false and zl3073x_chan_tod_ready_wait() is never
called, and zl3073x_dpll_ptp_adjphase() does not drain either:

	chan = zl3073x_chan_state_get(zldev, zldpll->id);

	if (!zl3073x_chan_mode_supports_tie(chan))
		return -EOPNOTSUPP;

	return zl3073x_chan_tie_write(zldev, zldpll->id, delta);

Meanwhile zl3073x_dpll_ptp_settime64(), and adjtime() on an exact
whole-second delta ("No sub-second remainder, done"), both drop
zldpll->lock while a WR_NEXT_1HZ is still armed, because
zl3073x_chan_tod_write() only waits for a previous operation on entry:

CPU0
zl3073x_dpll_ptp_settime64()
   zl3073x_chan_tod_write()
      zl3073x_chan_tod_ctrl(..., ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ)
   /* mutex released, write still pending */

CPU0 (or another task), same 1 Hz interval
zl3073x_dpll_ptp_adjphase()          /* or sub-second adjtime() */
   zl3073x_chan_tie_write()          /* no ToD semaphore poll */
   /* 1 Hz edge: pending absolute ToD write lands, sub-second
      adjustment discarded, outputs already stepped */

The mutex serializes register accesses but not the retirement of the
asynchronous device command, so does 0 get returned for an adjustment that
was silently dropped, leaving ToD and outputs incoherent for the NCO phase
step case?  Would calling zl3073x_chan_tod_ready_wait() unconditionally
before the phase step / TIE write cover this?

> +
> +	/* Phase step or TIE write failed, fall back to ToD adjust */
> +	rc = zl3073x_chan_tod_adjust(zldev, zldpll->id,
> +				     ns_to_timespec64(delta));

[ ... ]

> +/**
> + * zl3073x_dpll_ptp_adjfine - adjust PTP clock frequency
> + * @info: PTP clock info
> + * @scaled_ppm: frequency adjustment in scaled ppm (ppm * 2^16)
> + *
> + * Only supported for NCO. Writes the delta frequency offset register.
> + *
> + * Return:
> + * * %0			- success or @scaled_ppm is zero (no-op)
> + * * %-EOPNOTSUPP	- NCO pin is not connected and @scaled_ppm is non-zero
> + * * negative		- other error
> + */

[Severity: Low]
This isn't a bug, but does the documented "@scaled_ppm is zero (no-op)"
match the code?

> +	guard(mutex)(&zldpll->lock);
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	if (!zl3073x_chan_mode_is_nco(chan))
> +		return scaled_ppm ? -EOPNOTSUPP : 0;
> +	if (offset == chan->df_offset)
> +		return 0;
> +
> +	return zl3073x_chan_df_offset_set(zldpll->dev, zldpll->id, offset);
> +}

With scaled_ppm == 0 on an NCO channel whose cached df_offset is non-zero,
offset becomes 0 and zl3073x_chan_df_offset_set() performs a 48-bit write
to ZL_REG_DPLL_DF_OFFSET, which changes the NCO frequency and can return a
negative errno.  Could the Return section be reworded to describe the
absolute setpoint semantics?

> @@ -2436,6 +2777,47 @@ zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll)
>  	return 0;
>  }
>  
> +/**
> + * zl3073x_dpll_alloc - allocate DPLL device
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel number
> + *
> + * Allocates DPLL device structure for given DPLL channel.
> + *
> + * Return: pointer to DPLL device on success, error pointer on error
> + */
> +struct zl3073x_dpll *
> +zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
> +{
> +	struct zl3073x_dpll *zldpll;
> +
> +	zldpll = kzalloc_obj(*zldpll);
> +	if (!zldpll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	zldpll->dev = zldev;
> +	zldpll->id = ch;
> +	mutex_init(&zldpll->lock);
> +	INIT_LIST_HEAD(&zldpll->pins);
> +
> +	return zldpll;
> +}
> +
> +/**
> + * zl3073x_dpll_free - free DPLL device
> + * @zldpll: pointer to zl3073x_dpll structure
> + *
> + * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
> + */
> +void
> +zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
> +{
> +	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
> +
> +	mutex_destroy(&zldpll->lock);
> +	kfree(zldpll);
> +}
> +

[Severity: Low]
This isn't a bug, but zl3073x_dpll_alloc() and zl3073x_dpll_free() are
moved verbatim from where the new PTP helpers were inserted to this spot,
with no functional change and no mention in the changelog.  That accounts
for roughly 35 of the 439 added lines and mixes code motion with new
logic.  The new PTP helpers are all static and self-contained, so is the
move needed?  Could it be dropped or split into a separate no-functional-change
patch?

[ ... ]
