Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F893E5585;
	Thu, 10 Sep 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036222; cv=none; b=vECgD7QtpOT5EtjVafJOm/6w/s3vWIX6lVVfx49hJ0f/76bnQx+DzMmAWq6DoTPv/uzPTvoY4pwEyLCoAZ5EPXTz/gDkXoooTNtYnUt+sOyapXmuzmvswf3kurdGwVBqONSnAyLvLShuAw/Z4C3oAPT2RQySVdJymaHL5aYdy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036222; c=relaxed/simple;
	bh=fCX3sVFz886y7m641WtjFbTWfBW6PBvUMdTcj5NnK5M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ba8EYQcL6LW7O9cWyZ4N2qvuQehjs9e5hqSMCIlTVkbZnaSWcm9qfADesM+GMo5HbJSOplpzugP4TPHrWvQsc+Qosn2dGZJ/5vPOZVBKulNKro1LlzfVpXip1DKO2G+JZv+4kYqYHFUTZF6l/f/sjjQs0kLQwkcj2iCQBMIAMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3AyFuVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3AyFuVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499191F00898;
	Thu, 10 Sep 2026 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036216;
	bh=mNOi62wWgutYu+Lhf2iXRgzwWzqEfOOgxfi8hdfGQ3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n3AyFuVmaQy0lsD7XLRbcUc+ueAJdi5qfB2jRgmLmdFLpGwY7KvaumaUUVN4UWRY1
	 29D974w4wUdXKF5NI04z/9NfDB+vwke+lxbfGKz0+lb1MbWTmrapTPBR4kz7ae4hhm
	 5+ERrilDb46bYK8JMxqNlOJAYgbnFGeZUa/T8J06a2NIqlTJw+6AyFfIicFoD0MM0b
	 RDux8pl8ZNpLx2nvegLBQBNA5MiyEb5GlZ7LK3CDLKMgzqGrj29hjJV9lHIjam/XZm
	 OSRbM8fs5bEtTtWldzxKhewCjD2uh4AtUPsR37dlZYaTFJfLU3TF9KePNzUm+P6t+i
	 pDgVSisq2/uLQ==
Subject:
 Re: [PATCH net-next v3 06/10] net: dsa: microchip: extract compute_width
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 10:30:14 +0000
Message-ID: <178903621484.219967.9567046893070615730@kernel.org>
In-Reply-To: <20260908-ksz-perout-v3-6-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-6-6722a3f1ca75@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 (1) · Low: 1

- [Low] The new helper `ksz_ptp_compute_perout_pulse()`
  (drivers/net/dsa/microchip/ksz_ptp.c:227) declares a `struct…

Pre-existing issues:
- [High] A non-normalized but individually non-zero periodic-output
  request is accepted and stored as an effective period of zero, after…
- [Medium] The KSZ PTP driver implements `PTP_PEROUT_DUTY_CYCLE`
  (accepted in `ksz_ptp_get_pin()`, consumed in the newly extracted…

--

net: dsa: microchip: extract compute_width

This moves the periodic-output cycle width and pulse width computations out
of ksz_ptp_enable_perout() into two new helpers,
ksz_ptp_compute_perout_cycle() and ksz_ptp_compute_perout_pulse(), so that
an upcoming ksz8463_ptp_enable_perout() can reuse them.  No functional
change is intended.

A few questions below.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index f97ea9d69ebc5..2f141df65eb01 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -203,12 +203,49 @@ static int ksz_ptp_get_pin(struct ksz_device *dev,
>  	return pin;
>  }
>  
> +static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
> +					struct ptp_perout_request const *request,
> +					u64 *cycle_width_ns)
> +{
> +	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
> +
> +	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
> +	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
> +
> +	ptp_data->perout_period.tv_sec = request->period.sec;
> +	ptp_data->perout_period.tv_nsec = request->period.nsec;
> +
> +	*cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
> +	if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {
> +		*cycle_width_ns = 0;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
This isn't a bug introduced by this patch, since the code is moved
unchanged, but can a period that sums to zero get past this check and
later divide by zero?

The core does not normalize the request.  In ptp_perout_request() the
enable argument is computed from the raw fields:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
    ...
	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
		return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
    ...
}

So a request with period.sec = -1 and period.nsec = 1000000000 arrives
here with on = 1.  ksz_ptp_compute_perout_cycle() stores both raw fields
into ptp_data->perout_period, and timespec64_to_ns() then yields
-1e9 + 1e9 = 0.  The guard passes because 0 & TRIG_CYCLE_WIDTH_M == 0.

ksz_ptp_compute_perout_pulse() returns 0 for the same input, and
ksz_ptp_tou_pulse_verify(0, TRIG_PULSE_WIDTH_M) also returns 0, so the
configuration succeeds and tou_mode becomes KSZ_PTP_TOU_PEROUT.

A later PTP_CLOCK_SETTIME or ADJTIME then reaches ksz_ptp_restart_perout()
with ptp_data->lock held:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_restart_perout() {
    ...
	period_ns = timespec64_to_ns(&ptp_data->perout_period);

	if (first_ns < now_ns) {
		count = div_u64(now_ns - first_ns, period_ns);
    ...
	/* Ensure 100 ms guard time prior next event */
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;
    ...
}

With period_ns == 0, is the div_u64() a divide error, and does the guard
time loop spin forever when first_ns >= now_ns?  In both cases
ptp_data->lock is never released, so subsequent PTP operations on the
switch would block.

Since this helper is becoming the shared entry point for the KSZ8463 too,
would it make sense to reject a computed cycle width of zero here?

> +
> +static u64 ksz_ptp_compute_perout_pulse(struct ksz_device *dev,
> +					struct ptp_perout_request const *request,
> +					u64 max_pulse_width)
> +{
> +	u64 req_pulse_width_ns;
> +
> +	if (request->flags & PTP_PEROUT_DUTY_CYCLE)
> +		return request->on.sec * NSEC_PER_SEC +	request->on.nsec;

[Severity: Low]
This isn't a bug, but the dev parameter of
ksz_ptp_compute_perout_pulse() is never used in the function body, which
only reads request->flags, request->on, request->period and
max_pulse_width.  Since the chip specifics are conveyed through
max_pulse_width, could dev be dropped from the signature before the
KSZ8463 caller is added?  The only current caller,
ksz_ptp_enable_perout(), passes it needlessly.

[Severity: Medium]
This is a pre-existing issue, but is this PTP_PEROUT_DUTY_CYCLE branch
reachable at all?

ksz_ptp_set_caps() fills in caps.enable, caps.verify, caps.n_pins and
caps.n_per_out but never sets caps.supported_perout_flags, and the PTP
core has no default for it:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
    ...
	if (perout->flags & ~ops->supported_perout_flags)
		return -EOPNOTSUPP;
    ...
}

With supported_perout_flags == 0, every PTP_PEROUT_REQUEST2 carrying
PTP_PEROUT_DUTY_CYCLE is rejected before ops->enable() runs, so
ksz_ptp_get_pin() and this branch never see the flag.

Since this branch is now shared with the upcoming KSZ8463 support, should
ksz_ptp_set_caps() also set

	ptp_data->caps.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;

> +
> +	/* Use a duty cycle of 50%. Maximum pulse width supported by the
> +	 * hardware is a little bit more than 125 ms.
> +	 */
> +	req_pulse_width_ns = (request->period.sec * NSEC_PER_SEC +
> +			      request->period.nsec) / 2;
> +	return min_t(u64, req_pulse_width_ns, max_pulse_width);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ksz-perout-v3-0-6722a3f1ca75%40bootlin.com
