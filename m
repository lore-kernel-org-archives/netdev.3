Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4353CF208;
	Thu, 15 Oct 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102929; cv=none; b=gzw1HYAwbEa7sJBHVpmhCzS5kTA/dFYahP4kWkFocmWDVWpYckriHmLSMFTWsP2yJ1ELD17E/iB1gVYMA/svGVNKvyDFA8ATStqmDLw56HLQbehIDFFd2m9I1g9dgUwwVylRkaanHTB+PiNsneJeSX5qHOI0tx622ifuK6jOmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102929; c=relaxed/simple;
	bh=HnQP0yzd84S8/Ld8izXFE1YrEGTlOT9NU+rZMHQ8sEY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mbAAnFzyBbBcNsTnAjAqQY+e+hsJyaqxUqJ+8+BcAHxaDBDjzhcorzuy7zgy4s/zfKLZrO1e2TOPcRS9Wm0q6z6Amv7PojbgOIjLeSgWgXbE65YzI9U8uvzcPf4f+xZDDIQQ8WeQKlggB7N/b3AAprhlTRXHRZ5bwJbOwOMUQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT6GhtR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT6GhtR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F841F000C4;
	Thu, 15 Oct 2026 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792102927;
	bh=x7kqtq8YO/XazoqTxk0QCCpu82aNcDyZ2EuFdUxptAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nT6GhtR7444Kp0KGuS2XmyWHRZW4amlVUV/JbFpQvS2mhALV6rrDuMvBg8R925CHI
	 pM3K9Zz9ecCvOd50iZwogi/3ULh9WUy7Zsd9rL38KAGbNU6jABBjbkdxk+Eb2ul4qM
	 fCB75G4Oqv59HT4AkuPMsuFqkuvK/s7CAgeAgwR2s6+8LeHQLJ5zKorwZ355wdwhzT
	 aLGa0mrX+0KMUt/QlsrdkhXqMuwjqkH8ll9dQD2gDq7Swp1cX7sCNV4hGXDFmutmMH
	 DVuRrbqooYKcUqR5KPL5vzfJSJwzUlLJfkhqcyzReMWageYMuj/YLNFTjNMKDV4p4o
	 c+r6x1GgX5G5Q==
Subject:
 Re: [PATCH net v3 3/5] ptp: vclock: propagate physical clock sampling errors
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 mlichvar@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Date: Thu, 15 Oct 2026 22:22:06 +0000
Message-ID: <179210292629.434549.7415267131565563162@kernel.org>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-3-d3ee4ea62fc6@gmail.com>
References: <20261013-ptp-vclock-sampling-v3-3-d3ee4ea62fc6@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After one failed PHC sample, the virtual clock's anchor
  (tc->cycle_last) goes stale for a full extra refresh period, so the…
- [Low] ptp_vclock_register() now takes the initial PHC sample and calls
  timecounter_init() (drivers/ptp/ptp_vclock.c:237-240) before…

--

ptp: vclock: propagate physical clock sampling errors

This patch samples the parent PHC before timecounter_read() or
timecounter_init(). The cyclecounter read callback now returns the cached
successful sample, so a failed read no longer feeds a zero into the
timecounter. Sampling errors are returned to the vclock callers, and
ptp_vclock_register() takes the initial sample before publishing the clock
and returns an ERR_PTR that n_vclocks_store() propagates.

> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 84cb527f59ccc..eea207e5a8892 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c

[ ... ]

> @@ -75,15 +93,16 @@ static int ptp_vclock_gettime(struct ptp_clock_info *ptp,
>  			      struct timespec64 *ts)
>  {
>  	struct ptp_vclock *vclock = info_to_vclock(ptp);
> -	u64 ns;
> +	int err;
>  
>  	if (mutex_lock_interruptible(&vclock->lock))
>  		return -EINTR;
> -	ns = timecounter_read(&vclock->tc);
> +	err = ptp_vclock_sample(vclock);
> +	if (!err)
> +		*ts = ns_to_timespec64(timecounter_read(&vclock->tc));
>  	mutex_unlock(&vclock->lock);
> -	*ts = ns_to_timespec64(ns);
>  
> -	return 0;
> +	return err;
>  }

[Severity: Medium]
The commit message says "The refresh worker can retry later without
consuming an invalid sample". Does the retry come soon enough?

ptp_vclock_refresh() calls this function, ignores its return value, and
always reschedules after the full interval:

drivers/ptp/ptp_vclock.c:ptp_vclock_refresh() {
	...
	ptp_vclock_gettime(&vclock->info, &ts);

	return PTP_VCLOCK_REFRESH_INTERVAL;
}

PTP_VCLOCK_REFRESH_INTERVAL is HZ * 2. After one failed sample here,
tc->cycle_last is about 4s old by the time of the next retry.

The cyclecounter is CYCLECOUNTER_MASK(32) of nanoseconds, which is about
4.295s. timecounter_cyc2time() treats any delta above mask / 2 (about
2.147s) as a timestamp in the past:

include/linux/timecounter.h:timecounter_cyc2time() {
	...
	if (unlikely(delta > cc->mask / 2)) {
		delta = (tc->cycle_last - cycle_tstamp) & cc->mask;
		nsec -= cc_cyc2ns_backwards(cc, delta, frac);
	...
}

Between about 2.147s and 4s after the last good sample, would
ptp_convert_timestamp(), ptp_vclock_gettimex() and
ptp_vclock_getcrosststamp() all return times about 2^32 ns too early?

ptp_convert_timestamp() handles every hardware timestamp on a socket bound
to the vclock. ptp_vclock_gettimex() is the only gettime path when the
parent has getcyclesx64.

If the next refresh also fails, the next successful timecounter_read()
sees a delta above 2^32 ns, and that delta gets masked. Can virtual time
then permanently lose a full 2^32 ns wrap?

For that to happen, the parent only has to be unavailable at two
consecutive refresh points about 2s apart. That is shorter than "long
enough to miss a counter wrap", as the commit message describes it.

Could ptp_vclock_refresh() return a short delay after a failed sample?
ptp_aux_kworker() requeues the work with any non-negative delay that
do_aux_work returns.

[ ... ]

> @@ -214,20 +234,28 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
>  
>  	mutex_init(&vclock->lock);
>  
> +	err = ptp_vclock_sample(vclock);
> +	if (err)
> +		goto free_vclock;
> +	timecounter_init(&vclock->tc, &vclock->cc, 0);
> +
>  	vclock->clock = ptp_clock_register(&vclock->info, &pclock->dev);
> -	if (IS_ERR_OR_NULL(vclock->clock)) {
> -		kfree(vclock);
> -		return NULL;
> +	if (IS_ERR(vclock->clock)) {
> +		err = PTR_ERR(vclock->clock);
> +		goto free_vclock;
>  	}
>  
>  	ptp_vclock_set_subclass(vclock->clock);
>  
> -	timecounter_init(&vclock->tc, &vclock->cc, 0);
>  	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);

[Severity: Low]
The initial sample and timecounter_init() now run before
ptp_clock_register(), but the first refresh is still queued only after
registration returns. Does this make the gap between tc->cycle_last and
the first refresh longer by however long ptp_clock_register() takes?

ptp_clock_register() can sleep in GFP_KERNEL allocations, in
kthread_run_worker() and in posix_clock_register().

Suppose that time plus kworker latency is more than about 147ms. Then
conversions through ptp_convert_timestamp() or ptp_vclock_gettimex() just
before the first refresh would fall past the 2.147s half-window and come
out about 2^32 ns early. If it is more than about 2.29s, the first
timecounter_read() would lose a full wrap.

The reorder does fix the old race, where the posix clock was exposed
before timecounter_init() while tc.cc was still NULL. Either of these
would keep that fix without the longer gap:

  - re-sample and re-initialise the timecounter under vclock->lock once
    ptp_clock_register() succeeds
  - queue the first refresh with a short or zero delay

>  
>  	ptp_vclock_hash_add(vclock);
>  
>  	return vclock;
> +
> +free_vclock:
> +	kfree(vclock);
> +	return ERR_PTR(err);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6%40gmail.com
