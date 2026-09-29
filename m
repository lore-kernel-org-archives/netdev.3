Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86294FD289;
	Tue, 29 Sep 2026 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684887; cv=none; b=UhWN/jiDRfz0j0+CyvkDyWffkcNsmr2qjqnkrAJpFKYIImWTHC/qD295yyB1RA4vhq9eyF6dR51LlXi1n9isq44PWEQJtAVb75EhKoU8EwzGRfO90jIPyqfSquUYpy10JDxd5Dz/8ILwfJjCcwKHxwr+f9BvW/yY4hZWSFzRDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684887; c=relaxed/simple;
	bh=yKcIJH58i4ROOlMHTQamH6gkoXWLHZL6yM6TSO3Jon4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uf38flI6wr8NemmxCAsPCV3xROYdldhK3+r8eG8tAd5jZu12QPJC+H1ExiEN8UoUFCL5+kLXyBgrMw4EU0mcqvi1RRLLlUB7D8SFTE88pkI6oUTPAqegO3TFpa+CeT59QMAI02eDyc9CVvqtLoFgfWTppBD8dhpdjMY8h7W3wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IswU49UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IswU49UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73811F0089A;
	Tue, 29 Sep 2026 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684884;
	bh=8w5rbTTbD4CZE4YlgfZyB0g93zWcHIK0s+4W1tHXQOA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IswU49UIXM5x9mE1osd+4J6FrgqnfLL9fAGNR5O1vSpP+nv6mvLrsqNQxkCkPSfL2
	 h3bKYev68l+ocxYI/LR11QJfUEwP0H5lg9ApC5JFF8Xlv777lXT6tvF01sXDSCzl/8
	 DImh29l0j0+8h7CoQGcKpKe2xY4SxIFH0BNNOMxhh05qgSGlo4sJn7B5W/F4kxNdXO
	 lWcGAuHWpBUAzUk/aHG4cGTZOfNF4CrOrz0ZmpOE2PwtLaxO55xi2mq1Wm4G2f8icx
	 /5KKkdT58G8OhykCSK8HzhDKNYnwY2wxRQjasI76IgSRoduN/8iY3Hs6LjdFyzapNZ
	 zvohK5+NCO3nQ==
Subject: Re: [PATCH net-next v4 11/11] net: dsa: microchip: add periodic
 output support for the KSZ8463
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 12:28:03 +0000
Message-ID: <179068488323.434549.11261321164779716008@kernel.org>
In-Reply-To: <20260925-ksz-perout-v4-11-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-11-d675bd21ce49@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 2 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] KSZ8463 now advertises 12 independent periodic outputs
  (n_per_out = 12, one TRIGn_CFG register block per unit), but the new…
- [Medium] ksz8463_ptp_enable_perout() resets the unit
  (ksz8463_ptp_tou_reset(dev, request->index), line 343) before it…
- [Medium] The new ksz8463_ptp_settime()/ksz8463_ptp_adjtime() call
  ksz8463_ptp_restart_perout(), then ksz8463_ptp_enable_perout(), then…
- [Low] The new ksz8463_ptp_set_caps() never sets
  caps.supported_perout_flags, so it stays 0.
- [Low] The comment in the shared helper ksz_ptp_compute_perout_cycle()
  still says "Maximum pulse width supported by the hardware is a little…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  KSZ8463 settime/adjtime callbacks now reach it.
- [Low] This problem wasn't introduced by this patch, but the new KSZ8463
  path relies on it.
- [Low] This problem wasn't introduced by this patch, but
  ksz8463_ptp_settime() and ksz8463_ptp_adjtime() copy it.

--

net: dsa: microchip: add periodic output support for the KSZ8463

This commit adds periodic output support for the KSZ8463. The chip has 12
trigger output units, and each unit has its own register block. The patch
adds KSZ8463 specific reset, start, configure and enable helpers, new
settime, adjtime and enable callbacks, and advertises 12 pins and 12
periodic outputs for the chip.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index c1c4c781bca79..1c59428b159b1 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -147,6 +181,56 @@ static int ksz_ptp_tou_start(struct ksz_device *dev, u8 unit)
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_configure_perout(struct ksz_device *dev,
> +					struct ptp_perout_request const *request,
> +					u32 cycle_width_ns, u32 pulse_width_ns,
> +					u8 index)
> +{

[ ... ]

> +	/* KSZ8463 uses a 8 ns unit value to compute the pulse width */
> +	data = (pulse_width_ns / 8);
> +	ret = ksz_write16(dev, cfg_base + KSZ8463_PULSE_WIDTH_OFF, data);

[Severity: Low]
This isn't a bug introduced by this patch, but the new KSZ8463 path depends
on ksz_ptp_tou_pulse_verify(), and that function only checks for 4 ns
alignment:

    if (pulse_ns & 0x3)
        return -EINVAL;

The KSZ8463 register counts in 8 ns units. A pulse width that is 4 mod 8
therefore passes validation and is truncated here. For example, a 1016 ns
period gives a 508 ns pulse, which gets programmed as 504 ns.

Should this register be validated against 8 ns alignment instead?

> @@ -242,6 +326,61 @@ static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_enable_perout(struct ksz_device *dev,
> +				     struct ptp_perout_request const *request,
> +				     int on)
> +{
> +	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
> +	u64 cycle_width_ns;
> +	u64 pulse_width_ns;
> +	int pin;
> +	int ret;
> +
> +	pin = ksz_ptp_get_pin(dev, request);
> +	if (pin < 0)
> +		return pin;
> +
> +	ret = ksz8463_ptp_tou_reset(dev, request->index);
> +	if (ret)
> +		return ret;

[Severity: Medium]
The unit is reset here, before the new request is validated. Any of these
can fail afterwards:

    ksz_ptp_compute_perout_cycle()
    ksz_ptp_tou_pulse_verify()
    ksz8463_ptp_configure_perout()
    ksz8463_ptp_tou_start()

In that case the function returns with the unit stopped. tou_mode is still
KSZ_PTP_TOU_PEROUT, and perout_request still holds the old parameters.

For example, with channel N running, a new request for N with a 1002 ns
period gives a 501 ns pulse. That fails the 0x3 alignment check and returns
-EINVAL.

Userspace has seen an error and the output has stopped. Will the next
clock_settime() or clock_adjtime() then run ksz8463_ptp_restart_perout()
and silently re-arm the output with the old parameters?

> +
> +	if (!on) {
> +		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
> +		return 0;
> +	}
> +
> +	ret = ksz_ptp_compute_perout_cycle(dev, request,
> +					   KSZ8463_MAX_PULSE_WIDTH,
> +					   &cycle_width_ns, &pulse_width_ns);

[Severity: Low]
This isn't a bug, but the comment in the shared
ksz_ptp_compute_perout_cycle() still says:

    /* Use a duty cycle of 50%. Maximum pulse width supported by the
     * hardware is a little bit more than 125 ms.
     */

This caller passes KSZ8463_MAX_PULSE_WIDTH (500 us). Could the comment say
that the limit comes from max_pulse_width instead?

> +	if (ret)
> +		return ret;
> +
> +	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns,
> +				       KSZ8463_TRIG_PULSE_WIDTH_M);
> +	if (ret)
> +		return ret;

[ ... ]

> +	ret = ksz8463_ptp_tou_start(dev, request->index);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(&ptp_data->perout_request, request,
> +	       sizeof(struct ptp_perout_request));
> +	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;

[Severity: Medium]
KSZ8463 now advertises n_per_out = 12, but struct ksz_ptp_data still has
one tou_mode and one perout_request for the whole device. Does this work
when more than one output is in use?

Each successful enable overwrites perout_request. If channel 0 is enabled
and then channel 1, a later clock step only reschedules channel 1 through
ksz8463_ptp_restart_perout(). Channel 0 keeps a target time that was
computed against the old RTC value.

The disable path above also marks the whole device idle:

    if (!on) {
        ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
        return 0;
    }

Suppose channels 0 and 1 are enabled and then channel 1 is disabled. Won't
ksz8463_ptp_settime() and ksz8463_ptp_adjtime() then skip the restart
completely and leave channel 0 misaligned?

Should the mode and the saved request be tracked per unit?

[ ... ]

> @@ -853,6 +992,18 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  	return ksz_ptp_enable_perout(dev, &request, 1);
>  }
>  
> +static int ksz8463_ptp_restart_perout(struct ksz_device *dev)
> +{
> +	struct ptp_perout_request request;
> +	int ret;
> +
> +	ret = ksz_ptp_prepare_restart_perout(dev, &request);

[Severity: High]
This is a pre-existing issue, but the new KSZ8463 settime and adjtime
callbacks now reach it. ksz_ptp_prepare_restart_perout() stores the number
of elapsed periods in an unsigned int:

    unsigned int count;
    ...
    if (first_ns < now_ns) {
        count = div_u64(now_ns - first_ns, period_ns);
        next_ns = first_ns + count * period_ns;
    }
    ...
    while (next_ns < now_ns + 100000000)
        next_ns += period_ns;

If the quotient is larger than 2^32, count wraps. The while loop then has
to catch up one period per iteration.

Here is a common sequence: the PHC starts at 0, a periodic output is
enabled with a 100 ms period, and ptp4l steps the clock to current TAI
(about 1.79e9 s). That is roughly 1.7e10 iterations, and many more for
shorter periods.

Can this loop spin for seconds or longer while holding ptp_data->lock and
never calling cond_resched()? That would block other PTP operations on the
device and trigger soft lockup warnings.

Should count be a u64?

> +	if (ret)
> +		return ret;
> +
> +	return ksz8463_ptp_enable_perout(dev, &request, 1);

[Severity: Medium]
When called from ksz8463_ptp_settime() or ksz8463_ptp_adjtime(), this
reaches ptp_find_pin() without holding ptp_clock::pincfg_mux:

    ksz8463_ptp_enable_perout()
      ksz_ptp_get_pin()
        ptp_find_pin()

The kernel-doc for ptp_find_pin() says:

    The caller must hold ptp_clock::pincfg_mux.

The PTP core takes pincfg_mux only around ->enable() and ptp_set_pinfunc().
It does not take it around ->settime64() or ->adjtime().
ksz8463_ptp_configure_perout() then also reads pin->chan and pin->index to
pick cfg_base and the GPO field.

ptp_set_pinfunc() writes pin->func and pin->chan with only pincfg_mux held.
If the pin's previous function was PTP_PF_NONE, it does not call ->enable()
first, so it never takes ptp_data->lock.

Can a concurrent PTP_PIN_SETFUNC race with a clock step here? If so,
ptp_find_pin() could match the wrong pin, and the wrong trigger unit or
GPIO would get programmed.

Before this patch KSZ8463 had n_pins = 0, so this path could not be reached
on this chip.

Would saving the resolved pin and unit at enable time avoid the lookup?
Switching to ptp_find_pin_unlocked() would create an ABBA ordering with the
ioctl path, which takes pincfg_mux and then ptp_data->lock.

> +}
> +
>  static int __ksz_ptp_settime(struct ksz_device *dev,
>  			     const struct timespec64 *ts)
>  {
> @@ -879,6 +1030,41 @@ static int __ksz_ptp_settime(struct ksz_device *dev,
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{

[ ... ]

> +	mutex_lock(&ptp_data->lock);
> +
> +	ret = __ksz_ptp_settime(dev, ts);
> +	if (ret)
> +		goto unlock;
> +
> +	switch (ptp_data->tou_mode) {
> +	case KSZ_PTP_TOU_IDLE:
> +		break;
> +
> +	case KSZ_PTP_TOU_PEROUT:
> +		ret = ksz8463_ptp_restart_perout(dev);
> +		if (ret)
> +			goto unlock;

[Severity: Low]
This is a pre-existing issue that was copied from ksz_ptp_settime() and
ksz_ptp_adjtime(). If __ksz_ptp_settime() succeeds and
ksz8463_ptp_restart_perout() then fails, the goto skips the update of
ptp_data->clock_time. The hardware clock has already been set at that
point.

ksz_tstamp_reconstruct() uses clock_time for the upper seconds bits:

    ts.tv_sec = (ptp_clock_time.tv_sec & ~3) | ts.tv_sec;

Could reconstructed timestamps be off by the step amount until the next
ksz_ptp_do_aux_work() refresh? ksz8463_ptp_adjtime() has the same pattern.

> +
> +		break;
> +	}
> +
> +	spin_lock_bh(&ptp_data->clock_lock);
> +	ptp_data->clock_time = *ts;
> +	spin_unlock_bh(&ptp_data->clock_lock);

[ ... ]

> @@ -1103,6 +1343,27 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
>  	return 0;
>  }
>  
> +void ksz8463_ptp_set_caps(struct dsa_switch *ds)
> +{

[ ... ]

> +	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
> +	ptp_data->caps.enable		= ksz8463_ptp_enable;
> +	ptp_data->caps.verify		= ksz_ptp_verify_pin;
> +	ptp_data->caps.n_pins		= dev->info->n_pins;
> +	ptp_data->caps.n_per_out	= dev->info->n_per_out;
> +}

[Severity: Low]
caps.supported_perout_flags is never set here, so it stays 0. As a result,
ptp_perout_request() in drivers/ptp/ptp_chardev.c rejects the request
before ->enable() is called:

    if (perout->flags & ~ops->supported_perout_flags)
        return -EOPNOTSUPP;

The driver itself accepts PTP_PEROUT_DUTY_CYCLE in ksz_ptp_get_pin(), and
ksz_ptp_compute_perout_cycle() has a branch that uses request->on. Is that
branch unreachable? If so, the KSZ8463 pulse width is always
min(period / 2, 500 us).

Should supported_perout_flags be set to PTP_PEROUT_DUTY_CYCLE? The existing
ksz_ptp_set_caps() has the same omission.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-ksz-perout-v4-0-d675bd21ce49%40bootlin.com
