Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0124EE874;
	Tue, 29 Sep 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684879; cv=none; b=ifyW/yh5Zdb87LLoFf1CmFqNwQyQQ7kuLGdmFPGGtCyo1+BYAFCByRgVIcblKBKX1wdh57DKnkSma2NKkCTf+eanIFentN4fEaPSJAS5VRJC91ejSyqG8uxbXvkBovo61ipjWTdjlmsiqDSN0Hx5sRZ6Oec1yHSnut2LxMKyFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684879; c=relaxed/simple;
	bh=iI/y6G1rApeLXyhI5I/1YDctY/5ycSk2f8mMntIWxxU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q83ObXVAvn5ySpPC1eCNTMlomz6l8jO3esGVRt1sYUd4v7WRQsQqSJX3fd5wIFz1PS9yVuSdK6aojZs4leB7Xj5gDbdBVwsfOHHovlp+ndMs7q/PaQSMbD6DHYo4TfpUnP5v41VDcnf2MPT33BciACtVQs0GsParh1fh5XkgMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALAUI7eN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALAUI7eN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74BF1F000FF;
	Tue, 29 Sep 2026 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684877;
	bh=ahpktiMn1T8hkxWyx8EQPyqeO9rIhlIhPJ106yERwgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ALAUI7eNKd5dV0ya03MJV2G6lNlKNffUmqx2x2OkRB7pc6ahJouKjVDwVDJuAM4dG
	 vYFenuOTnDs04ETYUTHWMse4wTEdddJ5PiYlrukI4huFE41J50LFoKYYLStWMbcjT3
	 llJQ55M8n+CfQk2Ajy1V8HFAVtu/zLBPqf2VQB+w7/EqW+lsepGp4dquRnGcXM7LGF
	 NM4inTYUPEacXtIOuuJVxdqg2vQXc/9YHFbezhWmU8id4wCJLuVezuWd0kMMtaZI4Z
	 Yi1ulKYCCJuvZD5h2B54b1YgzBBZcA76tGcE6tGE6HdHnyYQMCHFdfYXjXkYWfbie5
	 voYaEQjdsN4rw==
Subject: Re: [PATCH net-next v4 01/11] net: dsa: microchip: fully save the
 periodic output request
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 12:27:56 +0000
Message-ID: <179068487632.434549.12891294812675724957@kernel.org>
In-Reply-To: <20260925-ksz-perout-v4-1-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-1-d675bd21ce49@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch keeps one saved request (ptp_data->perout_request) and
  one device-wide tou_mode, but the driver allows several trigger output…
- [Medium] This patch fixes a user-visible bug that already exists on the
  switches supported today (KSZ9477 family), but the commit message does…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is serious.
- [Medium] This problem wasn't introduced by this patch, but the restart
  path calls ptp_find_pin() without holding ptp_clock::pincfg_mux, which…
- [Low] ksz_ptp_enable_perout() selects the TOU and resets it with
  ksz_ptp_tou_reset(), which clears TRIG_ENABLE, before validation,…

--

net: dsa: microchip: fully save the periodic output request

This commit replaces the saved start time and period in struct
ksz_ptp_data with a full copy of the last successful struct
ptp_perout_request. After settime/adjtime, ksz_ptp_restart_perout() now
reuses that saved request, including its index and flags, instead of
forcing both to zero.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 39cc70d65900b..47cf397481d5e 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -263,6 +261,8 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  	if (ret)
>  		return ret;
>  
> +	memcpy(&ptp_data->perout_request, request,
> +	       sizeof(struct ptp_perout_request));
>  	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
>  
>  	return 0;

[Severity: High]
struct ksz_ptp_data has only one perout_request and one tou_mode. What
happens when more than one periodic output is active?

The busy check at the top of ksz_ptp_enable_perout() lets a second
channel start while another one is already in PEROUT mode:

	if (ptp_data->tou_mode != KSZ_PTP_TOU_PEROUT &&
	    ptp_data->tou_mode != KSZ_PTP_TOU_IDLE)
		return -EBUSY;

ksz_ptp_tou_reset() only touches the selected unit, so the earlier TOU
keeps running in hardware. Each successful start then overwrites
ptp_data->perout_request, whatever request->index is.

KSZ9477 advertises 2 pins and n_per_out = 3. Suppose pin0 is assigned to
PEROUT chan 0 and pin1 to PEROUT chan 1, and index 1 is started before
index 0. Only index 0 is saved.

On the next clock_settime or clock_adjtime, ksz_ptp_restart_perout()
re-arms only TOU0. TOU1 keeps a target time that was computed against
the clock before the step.

Disabling any one channel also clears the mode for the whole device:

	if (!on) {
		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
		return 0;
	}

This path is also reached from ptp_set_pinfunc()->ptp_disable_pinfunc()
when a pin is reassigned. After that, none of the outputs still running
are restarted on clock steps.

The KSZ8463 with its twelve outputs is the motivation here, and
ksz8463_ptp_enable_perout() later in the series writes into the same
slot. Would restart need a saved request and an active state per channel
to work for outputs other than the first?

[Severity: Low]
This isn't a bug introduced by this patch, but ksz_ptp_enable_perout()
calls ksz_ptp_tou_reset() on the selected TOU before it validates the
request. None of the later error returns restore the hardware state or
tou_mode.

Now that the request is saved only on success, consider a reconfiguration
of a running channel that fails after ksz_ptp_tou_reset(). Examples are a
period that doesn't fit TRIG_CYCLE_WIDTH_M, a start time over 32 bits, or
a failure in ksz_ptp_tou_start().

The TOU is then left stopped. If the REG_PTP_TRIG_STATUS__4 read or the
TRIG_ERROR check fails after TRIG_ENABLE was set, it is left armed with
the failed parameters instead. Either way tou_mode stays
KSZ_PTP_TOU_PEROUT and perout_request still holds the previous request,
so the next clock step re-arms that TOU with the old parameters.

This matches the "successfully started" wording in the commit message.
It is also no worse than the old code, which saved start and period
before validation. Is falling back to the last successful request the
intended behaviour after a failed PTP_PEROUT_REQUEST?

> @@ -763,6 +763,7 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  	struct ptp_perout_request request;
>  	struct timespec64 next;
>  	struct timespec64 now;
> +	struct timespec64 tmp;
>  	unsigned int count;
>  	int ret;
>  
> @@ -773,10 +774,14 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  		return ret;
>  
>  	now_ns = timespec64_to_ns(&now);
> -	first_ns = timespec64_to_ns(&ptp_data->perout_target_time_first);
> +	tmp.tv_sec = ptp_data->perout_request.start.sec;
> +	tmp.tv_nsec = ptp_data->perout_request.start.nsec;
> +	first_ns = timespec64_to_ns(&tmp);
>  
>  	/* Calculate next perout event based on start time and period */
> -	period_ns = timespec64_to_ns(&ptp_data->perout_period);
> +	tmp.tv_sec = ptp_data->perout_request.period.sec;
> +	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
> +	period_ns = timespec64_to_ns(&tmp);
>  
>  	if (first_ns < now_ns) {
>  		count = div_u64(now_ns - first_ns, period_ns);

[Severity: High]
This isn't a bug introduced by this patch, but this function is being
reworked, so I'm raising it here. count is declared unsigned int, while
div_u64() returns u64. Can the quotient get truncated here?

Suppose 2^32 or more periods have passed since the last (re)start. Then
next_ns = first_ns + count * period_ns lands far in the past, and the
guard loop below has to catch up one period at a time, at least 2^32
times:

	/* Ensure 100 ms guard time prior next event */
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;

The loop has no cond_resched(), and ptp_data->lock is held by
ksz_ptp_settime() or ksz_ptp_adjtime() the whole time.

That point is reached after about 49.7 days without a clock step at a
1 ms period, about 71 minutes at 1 us, and about 34 seconds at 8 ns.

Would making count a u64 avoid this? Later in the series, the KSZ8463
restart path also uses the same code through
ksz_ptp_prepare_restart_perout().

> @@ -791,12 +796,10 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  
>  	/* Restart periodic output signal */
>  	next = ns_to_timespec64(next_ns);
> +	memcpy(&request, &ptp_data->perout_request,
> +	       sizeof(struct ptp_perout_request));
>  	request.start.sec  = next.tv_sec;
>  	request.start.nsec = next.tv_nsec;
> -	request.period.sec  = ptp_data->perout_period.tv_sec;
> -	request.period.nsec = ptp_data->perout_period.tv_nsec;
> -	request.index = 0;
> -	request.flags = 0;

[Severity: Medium]
The commit message says:

  I don't know if other switches use non-zero indexes but the KSZ8463 has
  twelve periodic outputs, so this index has to also be saved from now on.

Doesn't the removed request.index = 0 already break restart on the
KSZ9477-family switches supported today? ksz_ptp_clock_register()
advertises:

	ptp_data->caps.n_per_out	= 3;

ptp_perout_request() in drivers/ptp/ptp_chardev.c only rejects
perout->index >= n_per_out, so indexes 1 and 2 reach
ksz_ptp_enable_perout().

With the old code, a clock step through ksz_ptp_settime() or
ksz_ptp_adjtime() while channel 1 or 2 is running goes one of two ways:

- If no pin is assigned to PEROUT channel 0, ptp_find_pin() fails and
  ksz_ptp_enable_perout() returns -EINVAL. settime/adjtime then returns
  an error and the real channel is never re-armed.

- If a pin is assigned to channel 0, TOU0 is re-armed on that pin with
  the other channel's period.

Could the commit message describe this? Should it also carry a Fixes: tag
for 1f12ae5b67608f ("net: dsa: microchip: ptp: add periodic output
signal") so it can be considered for stable?

>  
>  	return ksz_ptp_enable_perout(dev, &request, 1);

[Severity: Medium]
This is a pre-existing issue, but ksz_ptp_restart_perout() is called from
ksz_ptp_settime() and ksz_ptp_adjtime(), which hold only ptp_data->lock.
The PTP core takes ptp_clock::pincfg_mux around ops->enable(), but not
around settime64 or adjtime.

ksz_ptp_enable_perout() then does:

	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);

The documentation for ptp_find_pin() in include/linux/ptp_clock_kernel.h
says "The caller must hold ptp_clock::pincfg_mux."

Meanwhile, ptp_set_pinfunc() can update pin2->func and pin2->chan while
holding only pincfg_mux. When the old function was PTP_PF_NONE it doesn't
call into the driver, so ptp_data->lock is never taken.

Can the restart see a half-updated pin descriptor and send the restarted
output to the wrong pin? This is still present at the end of the series
in ksz_ptp_get_pin().

ptp_find_pin_unlocked() exists for callers that don't hold pincfg_mux.
It would have to be called before ptp_data->lock is taken, though,
because ksz_ptp_enable() already takes ptp_data->lock with pincfg_mux
held.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-ksz-perout-v4-0-d675bd21ce49%40bootlin.com
