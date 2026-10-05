Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2D282F01;
	Mon,  5 Oct 2026 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178665; cv=none; b=sU6aaGVLwRWRjFsMN+pjnNrEysNI50AsuzhSctNHt/4sC3zFlAd1xWFX387Czb80eBvlpXKZKmCZcwKTpupCzXZoIxU72rtrunzXH4vliVb5fEQ9x+aY8eT6TL7u6gp+9LvmOZUPMGAW85a+zQ34slknX1ye0nUJvclHnLpeUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178665; c=relaxed/simple;
	bh=TJToDOUHDtHPM4N2O5f5L7qDo65omFsn8DFc3FGFcs4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PamRZl+QA6yo4B9LohmTKLM5UxqjOCtICKUzMEEt3rcHZwu5YD1BqAjqmiho+m2z8IOi4JLSsFMOqb2bnXTWQPC3wgGmNwYIFvrkRc+qpMcl5/Iazjwngq6AJb1W7WUoiXRiDSw7kBNcH6M7l2ofcyBEptivGm8L1NRXiDBzVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeCkYgN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeCkYgN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DFC1F000FF;
	Mon,  5 Oct 2026 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791178664;
	bh=/9Epm2FlcIQehxBeK+ORwn/UN+OgqHOlYE6pi8Zs9jo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CeCkYgN8b6LgwF/m0B40XDA7i75daCDZF1+45RTjtoPDYP143XNcBTFmQtdMV0P9h
	 vpMtsBwOM0cs49v9v6sy8n3fNWBmzGOGfzgtPxKpwR7NalAQT2d7uTniOam1uX5NaU
	 nPC3BL7U3Gs5eqHaZEBIq9P9/UVF99/eIDVVs7GsP+jXznSaFzTTXL0LudCoYjv7cA
	 QnNa79uKYzasqadFwbSb9Ry0JgsMx9ipWq6kXhY5CX/mxTofzOmPn0HxGYfMiDtA2A
	 +yd/w1fPyRh8E43FuNQ9U0X7/nALR61NLDaNskwswotA/qBH16a34V23yEuo80G50S
	 8cyYS4r8KBNcQ==
Subject: Re: [PATCH net] ptp: vclock: reject failed physical clock samples
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 edumazet@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 05:37:42 +0000
Message-ID: <179117866299.434549.5905299465507065336@kernel.org>
In-Reply-To: <20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com>
References: <20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Failed PHC reads can still put virtual time off by a 32-bit
  wrap.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  rollback path inherits it.

--

ptp: vclock: reject failed physical clock samples

With this patch, the virtual clock samples the parent PHC before it touches
the timecounter. Only successful samples are cached for the cyclecounter
read callback, and errors from adjfine, gettime and settime are passed back
to the caller. The patch also moves the initial timecounter_init() ahead of
ptp_clock_register() and adds a rollback in n_vclocks_store() for when
registration fails partway through.

> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index dc398c6b75284..9c25d897be196 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c

[ ... ]

> @@ -257,6 +257,12 @@ static ssize_t n_vclocks_store(struct device *dev,
>  	mutex_unlock(&ptp->n_vclocks_mux);
>  
>  	return count;
> +err_register:
> +	num = i;
> +	if (num)
> +		device_for_each_child_reverse(dev, &num, unregister_vclock);

[Severity: High]
This isn't a bug introduced by this patch, but the new rollback path
inherits an existing race with parent clock teardown.

In ptp_clock_unregister(), ptp_vclock_in_use() takes n_vclocks_mux and
releases it again before the children are walked:

drivers/ptp/ptp_clock.c:ptp_clock_unregister() {
	if (ptp_vclock_in_use(ptp)) {
		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
	}
	...
	posix_clock_unregister(&ptp->clock);
	...
}

The n_vclocks sysfs attribute stays in place until posix_clock_unregister()
runs. During that window, n_vclocks_store() can reach unregister_vclock()
in two ways: through the existing deletion branch, or through this new
err_register path. Either iterator can pick the same child as the one in
ptp_clock_unregister().

The klist iterator holds a reference on the child struct device. It does
not hold one on the separately allocated struct ptp_vclock, and
ptp_vclock_unregister() frees that directly:

drivers/ptp/ptp_vclock.c:ptp_vclock_unregister() {
	...
	ptp_vclock_hash_del(vclock);

	ptp_clock_unregister(vclock->clock);
	kfree(vclock);
}

If both callbacks hit the same child, can the second unregister_vclock()
run ptp_vclock_unregister() on freed memory? That would mean a double
ptp_clock_unregister() and a double kfree() of the vclock.

PHC reads may fail while the hardware is being removed. That makes a
failed ptp_vclock_register() during teardown plausible, so this rollback
adds another way into the race.

> +	for (num = 0; num < i; num++)
> +		ptp->vclock_index[ptp->n_vclocks + num] = -1;
>  out:
>  	mutex_unlock(&ptp->n_vclocks_mux);
>  	return err;
> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 84cb527f59ccc..6378e9a8cd805 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -42,21 +42,41 @@ static void ptp_vclock_hash_del(struct ptp_vclock *vclock)
>  	synchronize_srcu(&vclock_srcu);
>  }
>  
> +/* Sample before changing the timecounter. Its read callback cannot return an
> + * error, so passing a failed PHC read through it would fabricate a wraparound.
> + * The caller holds vclock->lock, or has not published the clock yet.
> + */
> +static int ptp_vclock_sample(struct ptp_vclock *vclock)
> +{
> +	struct ptp_clock *ptp = vclock->pclock;
> +	struct timespec64 ts;
> +	int err;
> +
> +	err = ptp->info->getcycles64(ptp->info, &ts);
> +	if (!err)
> +		vclock->cycles = timespec64_to_ns(&ts);
> +	return err;
> +}

[ ... ]

> @@ -76,14 +96,18 @@ static int ptp_vclock_gettime(struct ptp_clock_info *ptp,
>  {
>  	struct ptp_vclock *vclock = info_to_vclock(ptp);
>  	u64 ns;
> +	int err;
>  
>  	if (mutex_lock_interruptible(&vclock->lock))
>  		return -EINTR;
> -	ns = timecounter_read(&vclock->tc);
> +	err = ptp_vclock_sample(vclock);
> +	if (!err) {
> +		ns = timecounter_read(&vclock->tc);
> +		*ts = ns_to_timespec64(ns);
> +	}
>  	mutex_unlock(&vclock->lock);
> -	*ts = ns_to_timespec64(ns);
>  
> -	return 0;
> +	return err;
>  }

[Severity: High]
Can a failed refresh still put virtual time off by a 32-bit wrap?

ptp_vclock_refresh() is not changed and still ignores the error that
ptp_vclock_gettime() now returns:

drivers/ptp/ptp_vclock.c:ptp_vclock_refresh() {
	...
	ptp_vclock_gettime(&vclock->info, &ts);

	return PTP_VCLOCK_REFRESH_INTERVAL;
}

So when ptp_vclock_sample() fails, tc->cycle_last is left alone, and the
next try comes a full 2 seconds later. ptp_vclock_cc uses
CYCLECOUNTER_MASK(32) on nanosecond values. That gives a wrap horizon of
about 4.29s and a forward window in timecounter_cyc2time() of about 2.147s.

With one failed refresh, the last good sample is about 4s old by the next
refresh. Once it is more than about 2.147s old, timecounter_cyc2time()
treats current timestamps as past ones:

include/linux/timecounter.h:timecounter_cyc2time() {
	...
	if (unlikely(delta > cc->mask / 2)) {
		delta = (tc->cycle_last - cycle_tstamp) & cc->mask;
		nsec -= cc_cyc2ns_backwards(cc, delta, frac);
	...
}

Would ptp_convert_timestamp(), ptp_vclock_gettimex() and
ptp_vclock_getcrosststamp() then return values about 4.29s early?

When the parent has getcyclesx64, ptp_vclock_gettimex() never advances
cycle_last. Only refresh, adjfine and settime can recover it, and all three
sample the same failing PHC.

With two failed refreshes in a row, the gap is at least 6s. The next
successful timecounter_read() then goes through timecounter_read_delta():

	cycle_delta = (cycle_now - tc->cycle_last) & tc->cc->mask;

This looks like it drops a whole 2^32 ns from virtual time, and the loss is
permanent. One failure plus more than about 295ms of worker delay would
have the same effect.

In this case the masked delta now always comes out one wrap short. The old
path, which consumed a zero sample and then the real value, gave the
correct elapsed time for some counter phases.

The initial sample in ptp_vclock_register() is now taken before
ptp_clock_register(). The time spent registering therefore adds to the age
of cycle_last before the first refresh runs.

The commit message says a failed sample "can add an extra 32-bit wrap to
virtual time". Is that still reachable through failed refreshes?

Would it make sense for ptp_vclock_refresh() to retry sooner on failure?
Another option would be to handle gaps longer than the mask using the full
64-bit ns sample.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-ptp-vclock-sampling-v1-1-c11bc16691ae%40gmail.com
