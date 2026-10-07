Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA370ADC;
	Wed,  7 Oct 2026 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409676; cv=none; b=R2BiAEi2xWlkvcfIIIp8j3ti94sVS3GChISowI6Fy2nm7hNT6lm+iOmhYfRGgjhZm3m9BwFuhH1oBoWVd9dHUC71FEPoOD7Qwt+W9svG+dDUT+RPBP2/NOZTjc5SAyHMdVh3pz9tJIblmWv6PWQ7y+qenRQYpkxchv+CAjzSqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409676; c=relaxed/simple;
	bh=SlpNA/HPfDr+tYE2NMiXG+o6GwHEjei6oFw1bAiDzXo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b93N3y1HVsfmg942k9NfDyo4FLM6bMCV7QWVlLY+BMOyfPVG8Z9nDMLqYypnLLqwg19+wvCsmta7zxxKnhnq1sT2srLy7wxGKu+xvh7gjr2I3q3gW6R+lvtCYP1imzTiRDvYmbTsZQls4XIFMOkHjPit+UP0DPVNeRWWG1Jd8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mANypWB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mANypWB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E111F00893;
	Wed,  7 Oct 2026 21:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791409674;
	bh=m+qk3tRtyxiz9qz093U3ajms9ku/87UZsBqKgXlb4hQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mANypWB+4/bW7RLhnlauC9I2CbC3lxZ1cLtl5M4s2+bNs+QgtNnrnoj9K+GyCsdDj
	 ElO8sNJHAhA99a78vETSI89OH+Qya27LgQ2VoSsVxRbaJJObcQVJ2CC+jF+kLMUpOm
	 JCKmUqYG4J7+waDyviuzPYWtYV/eN9KSDNc9pUGjtJSj+03erntBGhtpyyY7ZfpXit
	 PkG4IVTvIV+2wZXkrq6pUb9YrSfIs08dGcUYML4Mx9lyXqC/IzQir5JN1FkLY1+3Xw
	 VvKaN8Iuoxim3mUWNpLOBJGbQwNT0yqNpu7qlhrf6Vl6UVqQMQm0KXvpbG5gV/TvxU
	 GZ/HNWgnN8R6g==
Subject: Re: [PATCH net v2 2/2] ptp: vclock: preserve time across failed
 physical clock samples
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 edumazet@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 21:47:53 +0000
Message-ID: <179140967368.434549.18300768385033162106@kernel.org>
In-Reply-To: <20261005-ptp-vclock-sampling-v2-2-8ed12d4d10af@gmail.com>
References: <20261005-ptp-vclock-sampling-v2-2-8ed12d4d10af@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new comment above ptp_vclock_convert() says "Physical
  clock samples already contain full-width nanoseconds", and the new…
- [Low] The patch adds a new way for vclock creation to fail:
  ptp_vclock_sample() calls getcycles64() before registering the clock,…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but:
  ptp_convert_timestamp() never treats a zero (absent) hardware…

--

ptp: vclock: preserve time across failed physical clock samples

This patch drops the cyclecounter/timecounter from the PTP virtual clock.
It now samples the parent PHC directly, returns read errors to the caller,
and tracks time with a full 64-bit nanosecond anchor plus fractional ns.
It also changes n_vclocks_store() to unregister clocks that were only
partly created when a request to create several vclocks fails.

> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 84cb527f59ccc..52201c6b4d1f7 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c

[ ... ]

> @@ -42,21 +44,74 @@ static void ptp_vclock_hash_del(struct ptp_vclock *vclock)
>  	synchronize_srcu(&vclock_srcu);
>  }
>  
> +/*
> + * Physical clock samples already contain full-width nanoseconds. Do not
> + * truncate them to a 32-bit counter: failed reads can postpone a refresh
> + * beyond its wrap period. Use a wide multiply and retain fractional ns.
> + * Packet timestamps may precede the last sample; conversion must not move
> + * the clock's anchor in that case. The caller holds vclock->lock.
> + */
> +static u64 ptp_vclock_convert(struct ptp_vclock *vclock, u64 cycles, u64 *frac)
> +{
> +	u64 delta = cycles - vclock->cycles;
> +	bool backwards = delta > S64_MAX;

[Severity: Medium]
Is the "full-width nanoseconds" statement true for every getcycles64 or
getcyclesx64 provider? The kernel-doc in include/linux/ptp_clock_kernel.h
only says @getcycles64 "Reads the current free running cycle counter from
the hardware clock". It gives no unit or width.

For example, mlx5_ptp_getcyclesx() returns raw internal timer ticks:

drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c:mlx5_ptp_getcyclesx() {
    ...
	cycles = mlx5_read_time(mdev, sts, false);
	*ts = ns_to_timespec64(cycles);
    ...
}

The same driver treats those ticks as frequency-scaled and masks them to
41 bits in mlx5_timecounter_init():

	timer->cycles.mult = clocksource_khz2mult(dev_freq,
						  timer->cycles.shift);
	timer->nominal_c_mult = timer->cycles.mult;
	timer->cycles.mask = CLOCKSOURCE_MASK(41);

Scaling raw mlx5 ticks 1:1 as ns is older than this patch. What this patch
changes is the wrap handling. The old CYCLECOUNTER_MASK(32) arithmetic
worked with any provider counter that was at least 32 bits wide. The new
code takes a full 64-bit delta and treats delta > S64_MAX as a backwards
step.

If a provider's counter wraps below 2^63, would ptp_vclock_convert() see
the wrap as a backward step and move the virtual clock back by the whole
wrap period? It isn't clear from the code whether the mlx5 hardware counter
really wraps at 41 bits. Even so, should the comment and the callback
contract be updated, or should this kind of wrap be handled?

> +	u64 nsec, rem;
> +
> +	if (backwards)
> +		delta = -delta;
> +	nsec = mul_u64_u32_shr(delta, vclock->mult, PTP_VCLOCK_CC_SHIFT);
> +	rem = (delta * vclock->mult) & PTP_VCLOCK_FRAC_MASK;
> +	if (backwards) {
> +		nsec = vclock->nsec - nsec - (rem > *frac);
> +		*frac = (*frac - rem) & PTP_VCLOCK_FRAC_MASK;
> +	} else {

[ ... ]

> @@ -214,6 +255,11 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
>  
>  	mutex_init(&vclock->lock);
>  
> +	if (ptp_vclock_sample(vclock, &vclock->cycles)) {
> +		kfree(vclock);
> +		return NULL;
> +	}
> +

[Severity: Low]
When getcycles64() fails here, the driver's error code is lost.
ptp_vclock_register() returns NULL, and n_vclocks_store() jumps to
err_register without touching err:

drivers/ptp/ptp_sysfs.c:n_vclocks_store() {
	int err = -EINVAL;
    ...
			vclock = ptp_vclock_register(ptp);
			if (!vclock)
				goto err_register;
    ...
}

So a transient -EIO, -EBUSY or -EAGAIN from the parent PHC, for example
during a NIC reset, reaches userspace as -EINVAL. That looks like an
invalid value was written to n_vclocks.

The commit message says failures from clock operations are now propagated.
Could this path pass the real error back as well, for example by returning
an ERR_PTR from ptp_vclock_register()? The ptp_clock_register() and
allocation failure paths already flattened their errors to -EINVAL before
this patch. The rollback in err_register looks fine; only the errno is
affected.

>  	vclock->clock = ptp_clock_register(&vclock->info, &pclock->dev);
>  	if (IS_ERR_OR_NULL(vclock->clock)) {
>  		kfree(vclock);

[ ... ]

> @@ -293,7 +338,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
>  
>  		if (mutex_lock_interruptible(&vclock->lock))
>  			break;
> -		vclock_ns = timecounter_cyc2time(&vclock->tc, ns);
> +		frac = vclock->frac;
> +		vclock_ns = ptp_vclock_convert(vclock, ns, &frac);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
ptp_convert_timestamp() never treats a zero hardware timestamp as "no
timestamp".

__sock_recv_timestamp() converts the value before it checks for zero:

net/socket.c:__sock_recv_timestamp() {
    ...
		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
			hwtstamp = ptp_convert_timestamp(&hwtstamp,
							 READ_ONCE(sk->sk_bind_phc));

		if (hwtstamp) {
			tss.ts[2] = hwtstamp;
    ...
}

Take a socket with SOF_TIMESTAMPING_BIND_PHC that also sets
SOF_TIMESTAMPING_RX_SOFTWARE or SOCK_RCVTSTAMP. It reaches this code even
for packets that have no hardware timestamp.

With ns == 0, delta = 0 - vclock->cycles is above S64_MAX, so the backwards
branch runs. ptp_vclock_convert() then returns vclock->nsec minus the
scaled anchor, which is non-zero. Is that value reported to userspace in
tss.ts[2] as a valid hardware timestamp?

The old timecounter_cyc2time() also returned a non-zero value here, within
about two seconds of the vclock time. This patch only changes how far off
the value is. Would it make sense to return 0 when *hwtstamp is 0?

>  		mutex_unlock(&vclock->lock);
>  		break;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af%40gmail.com
