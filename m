Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAE3F44D7;
	Thu, 10 Sep 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036223; cv=none; b=Imy56xf9Fbt6/4fI8z10yGx/eijWqRi/wD2G2+x34F/LNmbaJDWGA9ZSdTCYaLhtMrtVW1zS5uGloECXqmZDC2tUjwYK9MuoGv/XtS9pjqE2Fo8ccNdQuDL59bdjru4f063hpJgZ+3SC2uQbwfUKF+4DOVlDSWzUpN9VA9TVki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036223; c=relaxed/simple;
	bh=9cLaUEKNvDzi2PA3I1zjr5e7LYvp46+CZeIeiyiFBHA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXIpg9wqx9lxly5vgHd3HqhtOZnoDx6iolyquxDDlIli5WW5kKd6DCtkecbQYt9qrwddWN0QgS5+3mN+qKfaAFaXiSesv61rYLS+NxjXSzGJX9D9+jngoMPPzhHK8G2QwTDEzq5udCtgXZsgdp4I/7r0un5ZccA4vqvpsEuHdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSh2gH7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSh2gH7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432D41F00899;
	Thu, 10 Sep 2026 10:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036219;
	bh=CEMv/fmA92QlHZg1VVbM8l90rMClghkC4TG8mDUP1c8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CSh2gH7SEfVTLDX6wuulMqkuOgzq3HzKUemiMlo7ltew1K8feBqiEwpmK8mH0PL6m
	 k2fL47gvZDP/f78sJggd+205ERURDZCwuJOHqc9TdTFelNdY13ie43oIW6dH7MY05r
	 Wj7fMgh7EE28CmbD9WHmLorot1+yaPRkPteldLdLFuZvM43S1hA29+dTpCJL5HNelo
	 3zcJdmJ4lL8+u1wadtfjZPTL9tW5ymQt+JvsGzs7WN00Nlpena/SHGQUv7LOTHOYMD
	 w39SygK+h/mteSStMV0SWi6CFMhNtENFx/aw3J8mDvUEDn+EHkTHE2bqOi4yaru40l
	 IY6YrPSztJQAQ==
Subject: Re: [PATCH net-next v3 10/10] net: dsa: microchip: add periodic
 output support for the KSZ8463
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 10:30:17 +0000
Message-ID: <178903621782.219967.1067616730052651942@kernel.org>
In-Reply-To: <20260908-ksz-perout-v3-10-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-10-6722a3f1ca75@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 (2) · Medium: 2 · Low: 1

- [High] KSZ8463 advertises 12 periodic-output channels (.n_pins = 12,
  .n_per_out = 12, copied into caps by ksz8463_ptp_set_caps()) while the…
- [Medium] ksz8463_ptp_enable_perout() is not transactional: it calls
  ksz8463_ptp_tou_reset(dev, request->index) (stopping an already…
- [Medium] ksz8463_ptp_configure_perout() dereferences
  dev->ptp_data.pin_config[index]…
- [Low] ksz8463_ptp_set_caps() (drivers/net/dsa/microchip/ksz_ptp.c:1335)
  does not set ptp_data->caps.supported_perout_flags, while the code…

Pre-existing issues:
- [High] The new KSZ8463 settime/adjtime paths funnel into
  ksz_ptp_prepare_restart_perout(), whose catch-up arithmetic can…
- [High] A denormalized periodic-output period is accepted as zero
  nanoseconds and later causes a kernel divide-by-zero or an infinite…

--

net: dsa: microchip: add periodic output support for the KSZ8463

This adds KSZ8463 specific periodic output handling: per-unit trigger
configuration registers, a smaller maximum pulse width, and a new set of
ksz8463_* PTP callbacks installed by ksz8463_ptp_set_caps().  The chip
data now advertises 12 pins and 12 periodic output channels.

A few questions below about the new paths.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 041bb4f963659..9e234ad71b723 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1161,6 +1161,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.supports_mii = {false, false, true},
>  		.supports_rmii = {false, false, true},
>  		.internal_phy = {true, true, false},
> +		.n_pins = 12,
> +		.n_per_out = 12,
>  	},

[Severity: High]
Twelve periodic output channels are advertised here, but struct
ksz_ptp_data still keeps only one set of perout state (a single tou_mode,
one perout_target_time_first, one perout_period), and the restart helper
always rebuilds a request for channel 0:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_prepare_restart_perout() {
	...
	request->index = 0;
	request->flags = 0;

	return 0;
}

Userspace can map pin 3 to PTP_PF_PEROUT chan 3 (ptp_set_pinfunc() only
checks chan < n_per_out, and ksz_ptp_verify_pin() accepts any PEROUT
pin/chan) and then arm PTP_PEROUT_REQUEST with index 3, which makes
ksz8463_ptp_enable_perout() program trigger unit 3 and set tou_mode =
KSZ_PTP_TOU_PEROUT.

The next clock_settime() then walks:

ksz8463_ptp_settime() -> ksz8463_ptp_restart_perout() ->
  ksz_ptp_prepare_restart_perout() (index = 0) ->
  ksz8463_ptp_enable_perout() -> ksz_ptp_get_pin() ->
  ptp_find_pin(clock, PTP_PF_PEROUT, 0)

With no pin mapped to chan 0 that returns -1 and ksz_ptp_get_pin() returns
-EINVAL.  Does that mean every clock_settime()/clock_adjtime() fails for as
long as a perout is armed on a channel other than 0?

And because the failure takes the goto unlock path after
__ksz_ptp_settime() has already loaded the hardware RTC, is
ptp_data->clock_time (used by ksz_tstamp_reconstruct()) left behind until
ksz_ptp_do_aux_work() happens to run?

If some pin is mapped to chan 0, the restart resets and re-arms unit 0 with
the last stored period and target instead, while the unit that is actually
running keeps its old absolute 32-bit target and is never re-armed.  Is
that intended?

There are two related effects: enabling a second channel overwrites the
stored period/target of the first, and disabling any single channel sets
the global tou_mode to KSZ_PTP_TOU_IDLE, after which clock steps take the
IDLE branch and the units still set in KSZ8463_TOU_EN are never
resynchronised.  Should the perout state become per-channel before
n_per_out = 12 is exposed?

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 0a77b46cfad25..d33034892a8f6 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -120,6 +132,28 @@ static int ksz_ptp_tou_target_time_set(struct ksz_device *dev,
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_tou_start(struct ksz_device *dev, u8 unit)
> +{
> +	u16 data;
> +	int ret;
> +
> +	ret = ksz_rmw16(dev, KSZ8463_TOU_EN, BIT(unit), BIT(unit));
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz_read16(dev, KSZ8463_TOU_ACTIVE, &data);
> +	if (ret)
> +		return ret;
> +
> +	if (!(data & BIT(unit))) {
> +		dev_err(dev->dev, "%s: Trigger unit%d error!\n", __func__,
> +			unit);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -147,6 +181,56 @@ static int ksz_ptp_tou_start(struct ksz_device *dev, u8 unit)
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_configure_perout(struct ksz_device *dev,
> +					u32 cycle_width_ns, u32 pulse_width_ns,
> +					struct timespec64 const *target_time,
> +					u8 index)
> +{
> +	struct ptp_pin_desc *pin = &dev->ptp_data.pin_config[index];
> +	u16 cfg_base = KSZ8463_TRIG1_CFG + KSZ8463_TRIGN_CFG_SIZE * pin->chan;

[Severity: Medium]
Is pin_config safe to read here with only ptp_data->lock held?  pin->chan
selects which trigger unit's register block gets rewritten, and
drivers/ptp/ptp_private.h documents the lock for that array as:

	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */

The core holds pincfg_mux around ->enable() only, not around
->settime64()/->adjtime().  So on the new paths:

CPU0: clock_settime() -> ksz8463_ptp_settime() (takes ptp_data->lock only)
        -> ksz8463_ptp_restart_perout() -> ksz8463_ptp_enable_perout()
        -> ksz_ptp_get_pin() -> ptp_find_pin() -> ksz8463_ptp_configure_perout()
           reads pin_config[index].chan / .index

CPU1: PTP_PIN_SETFUNC -> ptp_set_pinfunc() (holds pincfg_mux) writes

	if (pin1) {
		ptp_disable_pinfunc(info, func, chan);
		pin1->func = PTP_PF_NONE;
		pin1->chan = 0;
	}
	...
	pin2->func = func;
	pin2->chan = chan;

Those stores happen after ptp_disable_pinfunc() has already returned from
ksz8463_ptp_enable() and released ptp_data->lock, and for func ==
PTP_PF_NONE no ->enable() call happens at all, so ptp_data->lock does not
close the window.  Can cfg_base then point at a different, possibly
active, trigger unit than the one reset and enabled via request->index and
silently rewrite its configuration?

Note that taking pincfg_mux inside ptp_data->lock would invert the order
the core establishes in ptp_set_pinfunc() -> ptp_disable_pinfunc() ->
ksz8463_ptp_enable(); caching the pin/chan under ptp_data->lock at
enable() time looks like it would avoid that.

> +	u16 data;
> +	int ret;
> +
> +	/* Hardware has only 32 bit */
> +	if ((target_time->tv_sec & 0xffffffff) != target_time->tv_sec)
> +		return -EINVAL;
> +
> +	data = KSZ8463_NOTIFY_BIT |
> +	       FIELD_PREP(KSZ8463_PATTERN_M, TRIG_POS_PERIOD) |
> +	       pin->index;
> +	ret = ksz_write16(dev, cfg_base + KSZ8463_PATTERN_OFF, data);
> +	if (ret)
> +		return ret;

[ ... ]

> +	return 0;
> +}
> +

[ ... ]

> @@ -241,6 +325,58 @@ static u64 ksz_ptp_compute_perout_pulse(struct ksz_device *dev,
>  	return min_t(u64, req_pulse_width_ns, max_pulse_width);
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
> +
> +	if (!on) {
> +		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
> +		return 0;
> +	}
> +	ret = ksz_ptp_compute_perout_cycle(dev, request, &cycle_width_ns);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Is there a way back out of this sequence when a request is rejected?  The
running unit is reset before the request is validated, and
ksz_ptp_compute_perout_cycle() overwrites the saved schedule before it can
reject the period:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_compute_perout_cycle() {
	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
	...
	*cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
	if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {
		*cycle_width_ns = 0;
		return -EINVAL;
	}
}

So with a perout already running, a PTP_PEROUT_REQUEST carrying a period
whose ns value does not fit 32 bits (period.sec >= 5) resets trigger unit
N, stores the rejected start/period, and returns -EINVAL, while tou_mode
stays KSZ_PTP_TOU_PEROUT from the previous successful enable.  Does every
later clock_settime()/clock_adjtime() then take the PEROUT branch, call
ksz8463_ptp_restart_perout() with the rejected parameters, fail again, and
jump to unlock after the RTC has already been written but before
ptp_data->clock_time is updated?

The same applies to the -EINVAL/-ERANGE returns from
ksz_ptp_tou_pulse_verify(), the 32-bit target check in
ksz8463_ptp_configure_perout(), any regmap error, and the -EIO from
ksz8463_ptp_tou_start().

Related: ksz8463_ptp_tou_start() sets KSZ8463_TOU_EN before reading
KSZ8463_TOU_ACTIVE and does not clear the enable bit when the read fails
or ACTIVE is not set, so does an operation reported as -EIO leave the unit
enabled in hardware?

> +	pulse_width_ns = ksz_ptp_compute_perout_pulse(dev, request,
> +						      KSZ8463_MAX_PULSE_WIDTH);
> +
> +	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns,
> +				       KSZ8463_TRIG_PULSE_WIDTH_M);
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz8463_ptp_configure_perout(dev, cycle_width_ns, pulse_width_ns,
> +					   &ptp_data->perout_target_time_first,
> +					   pin);
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz_ptp_tou_gpio(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz8463_ptp_tou_start(dev, request->index);
> +	if (ret)
> +		return ret;
> +
> +	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -845,6 +981,18 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  	return ksz_ptp_enable_perout(dev, &request, 1);
>  }
>  
> +static int ksz8463_ptp_restart_perout(struct ksz_device *dev)
> +{
> +	struct ptp_perout_request request;
> +	int ret;
> +
> +	ret = ksz_ptp_prepare_restart_perout(dev, &request);
> +	if (ret)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but the helper reached from here
truncates the catch-up quotient to 32 bits, and this adds a second entry
point into it:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_prepare_restart_perout() {
	unsigned int count;
	...
	if (first_ns < now_ns) {
		count = div_u64(now_ns - first_ns, period_ns);
		next_ns = first_ns + count * period_ns;
	} else {
		next_ns = first_ns;
	}

	/* Ensure 100 ms guard time prior next event */
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;
}

count is only unsigned int, so once the true number of elapsed periods
passes 2^32, next_ns is left roughly 2^32 * period_ns in the past and the
guard loop advances one period per iteration, with ptp_data->lock held, in
ioctl context, and without cond_resched().

Small periods are accepted (TRIG_CYCLE_WIDTH_M is GENMASK(31, 0), and a
1 us period yields a 500 ns pulse that passes ksz_ptp_tou_pulse_verify()),
so a perout with a 1 us period armed a day earlier gives a true quotient
around 8.6e10.  Can the next clock_settime() ->
ksz8463_ptp_settime() -> ksz8463_ptp_restart_perout() then spin for that
many iterations under the PTP mutex, producing RCU stalls or soft lockups
and blocking every other PTP operation on the device?

Write access to /dev/ptpN is enough to reach both steps, since posix
dynamic clocks only require FMODE_WRITE.  Would widening count, or
bounding the accepted period, be worth doing here?

[Severity: High]
This is a pre-existing issue in the same shared helper, but the new
KSZ8463 clock update paths make it reachable for this chip too: a
denormalized period is accepted as zero nanoseconds.

PTP_PEROUT_REQUEST does not check that struct ptp_clock_time is
normalized, and the core enables the output because the fields are
nonzero:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
	...
	return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
}

So period.sec = -1 with period.nsec = 1000000000 reaches
ksz8463_ptp_enable_perout() with on = 1, ksz_ptp_compute_perout_cycle()
stores those raw fields into ptp_data->perout_period, timespec64_to_ns()
is 0, and 0 passes both the TRIG_CYCLE_WIDTH_M test and
ksz_ptp_tou_pulse_verify().

With a stored period of 0 and tou_mode still KSZ_PTP_TOU_PEROUT from an
earlier successful enable, the next clock_settime()/clock_adjtime() reaches
ksz_ptp_prepare_restart_perout():

	if (first_ns < now_ns) {
		count = div_u64(now_ns - first_ns, period_ns);

Does this divide by zero and Oops with ptp_data->lock held?  And in the
other branch, does

	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;

add zero forever?  Would a normalized, strictly positive period check in
ksz_ptp_compute_perout_cycle() cover both cases?

> +
> +	return ksz8463_ptp_enable_perout(dev, &request, 1);
> +}
> +

[ ... ]

> @@ -871,6 +1019,41 @@ static int __ksz_ptp_settime(struct ksz_device *dev,
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
> +	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
> +	int ret;
> +
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
> +
> +		break;
> +	}
> +
> +	spin_lock_bh(&ptp_data->clock_lock);
> +	ptp_data->clock_time = *ts;
> +	spin_unlock_bh(&ptp_data->clock_lock);
> +
> +unlock:
> +	mutex_unlock(&ptp_data->lock);
> +
> +	return ret;
> +}
> +

[ ... ]

> @@ -1095,6 +1332,27 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
>  	return 0;
>  }
>  
> +void ksz8463_ptp_set_caps(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz_ptp_data *ptp_data;
> +
> +	ptp_data = &dev->ptp_data;
> +
> +	ptp_data->caps.owner		= THIS_MODULE;
> +	snprintf(ptp_data->caps.name, 16, "Microchip Clock");
> +	ptp_data->caps.max_adj		= KSZ_MAX_DRIFT_CORR;
> +	ptp_data->caps.gettime64	= ksz_ptp_gettime;
> +	ptp_data->caps.settime64	= ksz8463_ptp_settime;
> +	ptp_data->caps.adjfine		= ksz_ptp_adjfine;
> +	ptp_data->caps.adjtime		= ksz8463_ptp_adjtime;
> +	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
> +	ptp_data->caps.enable		= ksz8463_ptp_enable;
> +	ptp_data->caps.verify		= ksz_ptp_verify_pin;
> +	ptp_data->caps.n_pins		= dev->info->n_pins;
> +	ptp_data->caps.n_per_out	= dev->info->n_per_out;
> +}
> +

[Severity: Low]
supported_perout_flags is not set here, while the path installed by this
function implements PTP_PEROUT_DUTY_CYCLE: ksz_ptp_get_pin() only rejects
flags outside PTP_PEROUT_DUTY_CYCLE, and
ksz_ptp_compute_perout_pulse() consumes request->on:

	if (request->flags & PTP_PEROUT_DUTY_CYCLE)
		return request->on.sec * NSEC_PER_SEC +	request->on.nsec;

The core rejects the ioctl before ->enable() runs:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
	if (perout->flags & ~ops->supported_perout_flags)
		return -EOPNOTSUPP;
}

So does every PTP_PEROUT_REQUEST2 with PTP_PEROUT_DUTY_CYCLE fail with
-EOPNOTSUPP, leaving the duty cycle handling unreachable?  The same
omission exists in ksz_ptp_set_caps(), so the KSZ8463 is no worse than the
other chips, but should the new initializer either set
supported_perout_flags = PTP_PEROUT_DUTY_CYCLE or drop the duty cycle
handling?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ksz-perout-v3-0-6722a3f1ca75%40bootlin.com
