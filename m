Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1A3F44E2;
	Thu, 10 Sep 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036222; cv=none; b=elXgGIqkdpJzHioOTQ8vdy3LffoEOvrKL/5DveRfcDVhCeR1Jw0dYQZWHS8Mz13OFboMz1JEzb+hrbNHwGivE02Y0DdUAathqM+5rhp5jrUDJup4HVdHhzpmgaDG5NiAwAGG8wcS4JuvHaBsG/nvrL2gA9PniqlRG1tWsG2i+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036222; c=relaxed/simple;
	bh=V+sh97OPWV0fVPmqMMDm9UaODz3wBc7OVsa8/kjniTs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oWTsnGCbqxBKTuKKhDr8PS+t9HW69BVZ4ToHMF7GGqNUJFg9FEE3GWSqjnINmTxyMrb4CEQpTKD9R/pVz2rih05mUKgJnUWdnON6i09WehlcrFDNI+LcrlpjwNZdX5oCRhuhSGrmYJDsjEhRvbVJ6K5QgVtBdRnwwquBNm/0gH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQFIHqrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQFIHqrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAEF1F0089B;
	Thu, 10 Sep 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036217;
	bh=uoOomtWaXOh9o/jYW/1mRIJqRkhwL5jxoXbEl7mD9kI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FQFIHqrq70uG3eTrzVsRTZULyZ1qEluRpc1xfx4EvwFM1pO8tuAp0gKigk7zcL2RT
	 +YwLcdnmR43qSQ1MLlmexC4ashyhmZ/+vLzOz1+vMrQHxlewqemr4rgc9RWZIA+/03
	 funF4zVKXis6bAoNrcGtNEDdyrx3bt8MQBXHrzpTMyvhcg0cyk/NICAjMMhh/VUNL5
	 7gzf152wZzRAw1IoKcnJDzQu9kScXWhOgX039/NL0aFyldgq5KNgzWojJFGvzk2+Lc
	 2D9Ln1veoWwCxzIVhAfi+Gxf5orJGSrX4mpJHmWisH3TrkNsJp/mT/nUY5oq9g7SG/
	 2wPztoAb0J+Rw==
Subject:
 Re: [PATCH net-next v3 07/10] net: dsa: microchip: extract prepare reset
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 10:30:16 +0000
Message-ID: <178903621628.219967.14995486202100709722@kernel.org>
In-Reply-To: <20260908-ksz-perout-v3-7-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-7-6722a3f1ca75@bootlin.com>
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

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 1

- [Low] Commit subject mismatch: the subject line "net: dsa: microchip:
  extract prepare reset" does not describe the change.

Pre-existing issues:
- [High] Integer truncation causes an effectively unbounded loop in
  ksz_ptp_prepare_restart_perout()…

--

net: dsa: microchip: extract prepare reset

This patch moves the periodic output request initialization out of
ksz_ptp_restart_perout() into a new helper ksz_ptp_prepare_restart_perout(),
so a future ksz8463_ptp_restart_perout() can reuse it.  No functional change
is intended in the moved code.

> net: dsa: microchip: extract prepare reset

[Severity: Low]
Should the subject say "extract prepare restart" instead?  Nothing related
to a reset is touched here: ksz_ptp_tou_reset() and the TRIG_RESET handling
are unchanged, and the new helper is named ksz_ptp_prepare_restart_perout().

Also in the changelog:

  Extract the inialization into a dedicated function so it can be used
  later by the KSZ8463 support.

"inialization" should be "initialization".

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 2f141df65eb01..e262bc7448f29 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -788,11 +788,11 @@ static int ksz_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
>  	return ret;
>  }
>  
> -static int ksz_ptp_restart_perout(struct ksz_device *dev)
> +static int ksz_ptp_prepare_restart_perout(struct ksz_device *dev,
> +					  struct ptp_perout_request *request)
>  {
>  	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
>  	s64 now_ns, first_ns, period_ns, next_ns;
> -	struct ptp_perout_request request;
>  	struct timespec64 next;
>  	struct timespec64 now;
>  	unsigned int count;

[Severity: High]
This isn't a bug introduced by this patch, but since the calculation is now
being moved into a helper that a second caller will use, is the truncation of
count into unsigned int in the moved code intentional?

The body that moves with the function does:

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
	...
}

Can count wrap here?  div_u64() returns a u64 quotient, so if the distance
between ptp_data->perout_target_time_first and the freshly written clock
value exceeds 2^32 periods, next_ns ends up far behind now_ns and the guard
time loop has to close that gap one period at a time, with no iteration cap,
no cond_resched() and no signal check.

The path is reachable from userspace:

ksz_ptp_settime()
    mutex_lock(&ptp_data->lock);
    ...
    case KSZ_PTP_TOU_PEROUT:
        ret = ksz_ptp_restart_perout(dev);
            ksz_ptp_prepare_restart_perout()

Enabling a periodic output while the PHC is still near zero with a short
period (for example 100 ms, which passes ksz_ptp_compute_perout_cycle()'s
TRIG_CYCLE_WIDTH_M check, and whose derived pulse passes
ksz_ptp_tou_pulse_verify()) and then issuing PTP_CLOCK_SETTIME with a
wall-clock value gives roughly 1.7e10 iterations, and considerably more for
the smallest accepted periods.  Since ksz_ptp_settime() holds
ptp_data->lock across the call, does this hang the ioctl and block all other
PTP operations on the device, and stall the CPU on CONFIG_PREEMPT_NONE?

Would using a u64 count (or clamping the correction to a single modulo step
instead of the loop) be preferable before the helper gains a second caller?

The same calculation is still present at the end of the series
(ac820826db205f1767ca525d6e06b8b1de2200fe), so no later patch appears to
address it.

> @@ -823,12 +823,24 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  
>  	/* Restart periodic output signal */
>  	next = ns_to_timespec64(next_ns);
> -	request.start.sec  = next.tv_sec;
> -	request.start.nsec = next.tv_nsec;
> -	request.period.sec  = ptp_data->perout_period.tv_sec;
> -	request.period.nsec = ptp_data->perout_period.tv_nsec;
> -	request.index = 0;
> -	request.flags = 0;
> +	request->start.sec  = next.tv_sec;
> +	request->start.nsec = next.tv_nsec;
> +	request->period.sec  = ptp_data->perout_period.tv_sec;
> +	request->period.nsec = ptp_data->perout_period.tv_nsec;
> +	request->index = 0;
> +	request->flags = 0;
> +
> +	return 0;
> +}
> +
> +static int ksz_ptp_restart_perout(struct ksz_device *dev)
> +{
> +	struct ptp_perout_request request;
> +	int ret;
> +
> +	ret = ksz_ptp_prepare_restart_perout(dev, &request);
> +	if (ret)
> +		return ret;
>  
>  	return ksz_ptp_enable_perout(dev, &request, 1);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ksz-perout-v3-0-6722a3f1ca75%40bootlin.com
