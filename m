Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455771;
	b=1Dezf0ZJH5aEaN03UIe1k40tGkd5CWbCOEWcN8nLtcQFmjh2Lq6PAPh/HktFTsH7xnD0
	 eQa17VeR4KHbXfDphK7XjbPF0kdDoFBQXiG2a7iImm2z5XQFxTEjQwW2ObP8WkSQYIjgA
	 cXsQ8LZSiZuhYNSHhPAObFz3ckhYIJ8acxYngJ5kDsT4EC465HuZLh/YxngXo/tZyNaGE
	 Y7NPwqqrL1V3/rqEFSFo5l4aWhBD1A+sWFrblgHRKM3LZmRiljbMI8i958UYfZ2HRigko
	 3Y8bfVzCAl/Gwku3s3Xs5QbSdfzZO6zGaXpGMGH5be1h/EsraM43cm4CqmwsgbA8C6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cuREoA3nKFpLDq48TCNhPU6MtEhLwM7uNawqcIxEoG4=;
	b=THbKJIiau4RdT3fTJWSAGi1P1WI6U0ZE+jrooFaLeizLzri5UL76CrC8BgqjQZcE5AMM
	 kcEupirvJB/uddu72P5yFkMJdc8rzDUajaItZNWcSdhC/Whe9+FPQK482DXKOdXh6zgep
	 v7uGNgq6K58IyYEe7uLX/MR4LBdRMAH+IRvyI9DZUyn4+oLj22WcRKLQJsJg9kh3Yitoe
	 AVqlHrd6OqDchOBQFw1o/QpVemdFw3RvpubaKb+PxUquCgka4wekHi84jNYsqNzv+q6wX
	 2CxqfHgjasg/C9quJ5KJn6F9QFd8L1rsXmAK7s4+YJHvMoRiSdWcuO+B0wsux9MMGVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJCcyV7u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5C606A319;
	Tue, 20 Oct 2026 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJCcyV7u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D891F000C4;
	Tue, 20 Oct 2026 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455770;
	bh=cuREoA3nKFpLDq48TCNhPU6MtEhLwM7uNawqcIxEoG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QJCcyV7uEKxwmNkCjR0zo+bvbikvOGtA/gYceiaG0j0jGXLJaLRyUhKt8eVBlph2k
	 lO8K8P5kGM5jTQ25yKnJekwMyiSzL+zOIYo8+mCSqMw2jgOCxxMcBR1JUsJi+c5FaT
	 ExGXcDv776HAp3JBpNfC19Op9xM+zBJxC+Ra66YirJaFk6T+RZiP0WpcnMRPcZO5md
	 jJ9IiKtOD/6WH8p4FzUsx6Pa5D+zWUtvKVuSiFKkyxAzY6joMOiwjM0mutGR71e+dT
	 3vIQMIsn711Tatm+uioRcpmRLldrB7uD5lyzi9jFny+RQ0Dxm1EHjKSQOf8oRGNUbY
	 74tFcSx5ITMFg==
Subject:
 Re: [PATCH net v4 3/5] ptp: vclock: propagate physical clock sampling errors
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 mlichvar@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev
Date: Tue, 20 Oct 2026 00:22:49 +0000
Message-ID: <179245576913.3135.17393378308394380121@kernel.org>
In-Reply-To: <20261015-ptp-vclock-sampling-v4-3-cba6ffc8ceb6@gmail.com>
References: <20261015-ptp-vclock-sampling-v4-3-cba6ffc8ceb6@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ptp_vclock_refresh() (drivers/ptp/ptp_vclock.c) now returns
  the fixed PTP_VCLOCK_RETRY_INTERVAL (msecs_to_jiffies(10)) whenever…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, and the commit
  message explicitly documents it as a remaining limitation: 'prolonged…

--

ptp: vclock: propagate physical clock sampling errors

This patch samples the parent PHC before timecounter_read() and
timecounter_init(), caches the good sample for the cyclecounter read
callback, and passes PHC read errors back to callers. It also retries
failed refreshes after 10 ms instead of 2 s, initializes the timecounter
before the clock is registered, and makes ptp_vclock_register() return
error pointers.

> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 84cb527f59ccc..5f49f81891ef7 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c

[ ... ]

> @@ -13,6 +14,7 @@
>  #define PTP_VCLOCK_FADJ_SHIFT		9
>  #define PTP_VCLOCK_FADJ_DENOMINATOR	15625ULL
>  #define PTP_VCLOCK_REFRESH_INTERVAL	(HZ * 2)
> +#define PTP_VCLOCK_RETRY_INTERVAL		msecs_to_jiffies(10)
>  
>  /* protects vclock_hash addition/deletion */
>  static DEFINE_SPINLOCK(vclock_hash_lock);

[ ... ]

> @@ -151,7 +175,9 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
>  	struct ptp_vclock *vclock = info_to_vclock(ptp);
>  	struct timespec64 ts;
>  
> -	ptp_vclock_gettime(&vclock->info, &ts);
> +	/* Do not wait another full interval with a stale cycle_last. */
> +	if (ptp_vclock_gettime(&vclock->info, &ts))
> +		return PTP_VCLOCK_RETRY_INTERVAL;

[Severity: Medium]
What happens here if the parent PHC keeps failing, rather than failing just
once?

ptp_vclock_refresh() returns the same fixed 10 ms after every failure. There
is no backoff and no retry limit. ptp_aux_kworker() requeues the work with
whatever delay it gets back:

drivers/ptp/ptp_clock.c:ptp_aux_kworker() {
    ...
	if (delay >= 0)
		kthread_queue_delayed_work(ptp->kworker, &ptp->aux_work, delay);
}

Each vclock has its own worker. By default a physical clock allows 20
vclocks (PTP_DEFAULT_MAX_VCLOCKS), and max_vclocks can be raised through
sysfs. One failing parent could then see 2000 or more failed getcycles64()
calls per second. Before this patch it was one call per vclock every 2 s.

For parents without a free-running counter, getcycles64() goes through
ptp_getcycles64() to gettimex64/gettime64. With sja1105, for example, each
call takes ptp_data->lock and does an SPI transaction. Each failure is
also logged with no rate limit:

drivers/net/dsa/sja1105/sja1105_ptp.c:__sja1105_ptp_gettimex() {
    ...
	rc = sja1105_ptpclkval_read(priv, &ticks, ptp_sts);
	if (rc < 0) {
		dev_err(ds->dev, "Failed to read PTP clock: %d\n", rc);
		return rc;
	}
    ...
}

Could an SPI/MDIO bus fault, or a switch held in reset, turn this into a
storm of bus traffic, lock contention and kernel log messages at about 200
times the old rate?

Once an outage lasts longer than about 4.295 s, the counter wraps are
already lost, so retrying faster after that point gains nothing.

Would a capped exponential backoff still cover the isolated failure case
the commit message describes? For example, start at 10 ms and double up to
PTP_VCLOCK_REFRESH_INTERVAL. A bounded number of fast retries could also
work.

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The commit
message already lists it as a remaining limitation:

  "prolonged read failures or worker delays can still exceed the half-wrap
  conversion window, and a gap of about 4.295 seconds between successful
  samples can lose a full counter wrap."

When a sample fails, cycle_last keeps the last good value.
ptp_vclock_gettimex() still converts against it without checking how old
it is:

	err = pptp->info->getcyclesx64(pptp->info, &pts, sts);
	if (err)
		return err;
	...
	ns = timecounter_cyc2time(&vclock->tc, timespec64_to_ns(&pts));
	...
	return 0;

ptp_vclock_getcrosststamp() and ptp_convert_timestamp() do the same
conversion. Once cycle_last is more than mask/2 old (about 2.147 s), can
these return success with a time about 2^32 ns too early?

If no read succeeds for more than about 4.295 s, the next successful
timecounter_read() goes through timecounter_read_delta():

	cycle_delta = (cycle_now - tc->cycle_last) & tc->cc->mask;

That masking silently drops whole 32-bit wraps. The vclock then stays off
by a multiple of about 4.295 s until userspace steps it with settime.

Could the vclock be marked invalid, or forced to resync, after a long run
of failed refreshes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6%40gmail.com
