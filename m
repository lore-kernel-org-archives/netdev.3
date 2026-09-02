Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FD4AA585;
	Wed,  2 Sep 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366430; cv=none; b=lolkwb2NK0CHIO8iKRuLTsaGNM1AWdpxYj6qlFVEoagovAMqXOdpaebtQrfWpI/WvE5xA8mFoJCIuSup/cwwfDKPgyzUgSBx51n9fszCRm5hv8Qr9IjaZHvBPBjl9jseuUj543DrFjRBqdd2vDCzhHFCB0NeFhD4SpQmsLuka54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366430; c=relaxed/simple;
	bh=ST4N2dLei7Tg+x9p8KKsIc+vsNyn3YdEa37uorRy2+E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WzPb9b7bzUVzhW9+ttd0194IoBKyg14BLkGwTgAX29Ie9COxQh6q9WzpHiDoEozGR3rc15l8E0ex0GQjg7hzk2SB+oIlg+HJAgbMDFZto9eXvz+Y8tRVW0uEkAHT/ulLaKuJa3Rm6UNqUt4BLdli7rMAZjEszQ1VNenfda1Hpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT7QjQSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT7QjQSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66451F00A3E;
	Wed,  2 Sep 2026 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366428;
	bh=sKz1XMs1vGldbbSm49wZdCrUSX6wH5Hww2M3IVnM4xY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IT7QjQSbs7ragt/rESK0eR9WeIVjJTxXbBuMSXKPrTSZaV76JSmGTCIpNyHHvYq0E
	 gRWZkrQMgMnDwkEbSGFcfQyxd6SXamNrlAbDst+LRWoQm6jhT8D/TDjPcG+UF84J1A
	 9u18YpKLGXduI5NaNfeU6YnhkT4hnh5g+Okvda/2C4jtD5BwOXsSJJQPBOo6D5R4Cr
	 WdrdxFdr5fuXEyFfyCMRcst8o53EPnuCwTgkD85ZLKy+ZK0bZoRneIgyuJeNgg4idt
	 6XaNzQ7RHrGGw3FrB8/iPTU7BDnNhUQuSYw2jSu9RX/mR6GnvUVHcAiS2QxKK4DDct
	 d5G3e98XdwOFg==
Subject: Re: [net-next,06/10] net: dsa: microchip: extract compute_width
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 16:27:07 +0000
Message-ID: <178836642718.3394541.10724573738708310422@kernel.org>
In-Reply-To: <20260831-ksz-perout-v1-6-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-6-14202db763b3@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (2) · Medium: 0 · Low: 2

- [Low] The new helper `ksz_ptp_compute_perout_pulse()`
  (drivers/net/dsa/microchip/ksz_ptp.c:227) declares a `struct…
- [Low] The comment moved into the generic helper
  `ksz_ptp_compute_perout_pulse()`…

Pre-existing issues:
- [High] A denormalized periodic-output period from userspace is accepted
  as a zero-nanosecond period and later causes a kernel divide-by-zero…
- [High] A rejected periodic-output reconfiguration leaves hardware and
  driver bookkeeping inconsistent, and the poisoned cache can later…

--

net: dsa: microchip: extract compute_width

This moves the periodic-output cycle width and pulse width computations out
of ksz_ptp_enable_perout() into two new helpers,
ksz_ptp_compute_perout_cycle() and ksz_ptp_compute_perout_pulse(), so a
future ksz8463_ptp_enable_perout() can reuse them. The pulse helper takes
the maximum pulse width as a parameter instead of using KSZ_MAX_PULSE_WIDTH
directly.

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
This isn't a bug introduced by this patch, the baseline inline code did the
same mask check on the same cached values, but since the code is now being
moved into a helper that a second caller will reuse, can a zero period slip
through here?

ptp_perout_request() in drivers/ptp/ptp_chardev.c decides enable/disable
with:

	return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);

It never normalizes the timespec, so period.sec = -1, period.nsec =
1000000000 is treated as "enable". timespec64_to_ns() then yields
-1e9 + 1e9 = 0, and the check above passes because (0 & 0xffffffff) == 0.
ksz_ptp_compute_perout_pulse() returns 0 as well, which
ksz_ptp_tou_pulse_verify() accepts.

The zero period stays cached in ptp_data->perout_period while tou_mode is
KSZ_PTP_TOU_PEROUT, and the next PTP_CLOCK_SETTIME or ADJTIME reaches
ksz_ptp_restart_perout():

	period_ns = timespec64_to_ns(&ptp_data->perout_period);

	if (first_ns < now_ns) {
		count = div_u64(now_ns - first_ns, period_ns);

div_u64() takes a u32 divisor, so with period_ns == 0 this is a division by
zero in ioctl context. If instead the cached start time falls inside the
next 100 ms, this loop never terminates while ptp_data->lock is held:

	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;

Would it make sense to reject a zero or negative period in
ksz_ptp_compute_perout_cycle() while it is being factored out?

[Severity: High]
This is a pre-existing issue as well, the same ordering and the same
unconditional cache write existed before the move, but the same helper is
now shared with the KSZ8463 path, so it seems worth asking about.

The software cache is committed before the range check, so when the check
fails ptp_data->perout_period and perout_target_time_first describe a
configuration the hardware refused. Combined with the truncating divisor in
ksz_ptp_restart_perout():

	count = div_u64(now_ns - first_ns, period_ns);

a cached period of exactly 2^32 ns (period.sec = 4, period.nsec =
294967296) is precisely the kind of value that the TRIG_CYCLE_WIDTH_M check
rejects, and its low 32 bits are zero, so div_u64() divides by zero on the
next clock step. Should the period be validated before ptp_data is updated?

> +
> +static u64 ksz_ptp_compute_perout_pulse(struct ksz_device *dev,
> +					struct ptp_perout_request const *request,
> +					u64 max_pulse_width)
> +{
> +	u64 req_pulse_width_ns;
> +
> +	if (request->flags & PTP_PEROUT_DUTY_CYCLE)
> +		return request->on.sec * NSEC_PER_SEC +	request->on.nsec;
                                                     ^^^

[Severity: Low]
This isn't a bug, but two small things in ksz_ptp_compute_perout_pulse():
the dev parameter is never dereferenced in the body (only request->flags,
request->on, request->period and max_pulse_width are used), and a stray tab
ended up in the middle of the return statement where the original code had
a line break.

> +
> +	/* Use a duty cycle of 50%. Maximum pulse width supported by the
> +	 * hardware is a little bit more than 125 ms.
> +	 */
> +	req_pulse_width_ns = (request->period.sec * NSEC_PER_SEC +
> +			      request->period.nsec) / 2;
> +	return min_t(u64, req_pulse_width_ns, max_pulse_width);
> +}

[Severity: Low]
This isn't a bug either, but the comment now states a fixed device property
inside a helper that clamps to the caller-supplied max_pulse_width. The
KSZ8463 support that follows passes KSZ8463_MAX_PULSE_WIDTH (500000, i.e.
0.5 ms), which contradicts the "a little bit more than 125 ms" wording
sitting in the shared helper.

Would it be clearer to move that sentence next to the KSZ_MAX_PULSE_WIDTH
definition, or to reword it in terms of max_pulse_width?

>  
>  static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  				 struct ptp_perout_request const *request,
>  				 int on)
>  {
>  	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
> -	u64 req_pulse_width_ns;
>  	u64 cycle_width_ns;
>  	u64 pulse_width_ns;
>  	int pin = 0;
> @@ -234,29 +271,11 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
>  		return 0;
>  	}
> -
[ ... ]
> +	ret = ksz_ptp_compute_perout_cycle(dev, request, &cycle_width_ns);
> +	if (ret)
> +		return ret;

[Severity: High]
Related to the pre-existing ordering noted above, and again not changed by
this patch: ksz_ptp_tou_reset() earlier in ksz_ptp_enable_perout() has
already cleared TRIG_RESET/TRIG_ENABLE and stopped a running output by the
time this validation runs. On the -EINVAL return here, tou_mode stays at
KSZ_PTP_TOU_PEROUT (ksz_ptp_get_pin() explicitly allows re-entry in PEROUT
mode), so the driver reports an armed periodic output while the trigger unit
is disabled. Should tou_mode be set back to KSZ_PTP_TOU_IDLE on these error
paths?

> +	pulse_width_ns = ksz_ptp_compute_perout_pulse(dev, request,
> +						      KSZ_MAX_PULSE_WIDTH);
>  
>  	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns, TRIG_PULSE_WIDTH_M);
>  	if (ret)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz-perout-v1-0-14202db763b3%40bootlin.com
