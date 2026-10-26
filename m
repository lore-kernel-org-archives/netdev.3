Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030030;
	b=lJzRq2kM2HpdLW77CbYk/5mvobviyDdA+lBCHUfN5j/YUxnOwbfPcvegi2PngKEqerdq
	 Rk1+uHXmis5fbwJVGk0tMFXjfpbEHroQTDDxDVzIMLvr7q0mPQ2tcReZ00kcWynMlG8OL
	 xAHKRSY1HZdJ22gP45nt718HhXXX4kUQ6XcfI33c5oXSh3BhJRknCBwYtH2JcFweTdlav
	 Soxwy1EVqHKPcMDvqvhJhT5XUb76TmX7pYG671/llsaEawTgzeV/ZD/00+WeqaBt/C3o4
	 JQrlR2bExXAFqXyvhQnw3xbaoo7SSYOa3ag0daLgzyy8+VI8749Qsbu1nrd5K/bwWNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030030;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2svq3CU+h/wjTBe/BPU6GyHCrFin2y9txfqrV1ibhEY=;
	b=gl/sMuTGINun0WDSVm79KONwrAuvo/4Q6LoBq0GswffbblM743IuPAPrOnWvWQ5mMGYM
	 gnxQZ8DBmdwBPL9eH/CWVaalY48acpBR1KRl1ENfavtvmrG8GRg5SOLUDhg1H0KyIMBLf
	 SnYT5WRgAcfBkXvzutsi1PfpERqV35/MMRFxmDAFf0gXpiwS4m2TmzdBmbMey/rbbuTNo
	 TiYRyBBs7pg7deorkSK4+fpLhjbpisb8fWC4jH1DC6SEmyE5Bo+KJJstTku3/HLC+Xmt4
	 Hgnquu+5gDOl87CKJ2tYT261tt3d0CXlOdLzLrV47gYA7CpZ57ZyfOmHw4Z2mQ0+uLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkbbGEzY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0E606A31A;
	Mon, 26 Oct 2026 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkbbGEzY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E834C1F031E2;
	Mon, 26 Oct 2026 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030029;
	bh=2svq3CU+h/wjTBe/BPU6GyHCrFin2y9txfqrV1ibhEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lkbbGEzY0sWtN+8n+j35aa/SbQxM2MqaScZT0XIFmKcUpanNPgCNaCoyJf3JFzarg
	 SOf8KKn31Bmt5vL35tcI8t7u5UN3TRTSauZrpPUSJhHliBcVmQPOPLeDDIqtuZ3gIx
	 YEvf/7oab6POZGn/53cw7tRGXCkc9GY8Muh5ZK37CUkgSRHCphWVGJdhG4TR+6xX9j
	 mQnrprEWUq++Qg4RW2Gj+ASPDzCefOtGgNqz2wNf3y7dRJITIcJJoq3ZN0gaM1o0YH
	 wI4KxxYvY4pMXsaeL/x9De2dj0kziLBpMxQ1DpFxKexV7Eyi9dIKGicU/WgnKHZ5WM
	 /ALj7KXDIH9cw==
Subject:
 Re: [PATCH net v5 3/5] ptp: vclock: propagate physical clock sampling errors
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 mlichvar@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev
Date: Mon, 26 Oct 2026 15:53:48 +0000
Message-ID: <179303002839.3134.5595255852218546734@kernel.org>
In-Reply-To: <20261022-ptp-vclock-sampling-v5-3-06ceace17bac@gmail.com>
References: <20261022-ptp-vclock-sampling-v5-3-06ceace17bac@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The exponential retry backoff added to ptp_vclock_refresh() in
  drivers/ptp/ptp_vclock.c only looks at the previous retry delay.

--

ptp: vclock: propagate physical clock sampling errors

This patch caches a successful parent PHC sample before timecounter
operations. Read failures are now returned to callers instead of being
consumed as a zero sample. It also adds a refresh retry that starts at
10 ms and doubles on consecutive failures, up to the normal two second
interval, and makes ptp_vclock_register() return error pointers.

> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 84cb527f59ccc..c10eba6443f9a 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c

[ ... ]

> @@ -13,6 +14,7 @@
>  #define PTP_VCLOCK_FADJ_SHIFT		9
>  #define PTP_VCLOCK_FADJ_DENOMINATOR	15625ULL
>  #define PTP_VCLOCK_REFRESH_INTERVAL	(HZ * 2)
> +#define PTP_VCLOCK_RETRY_INTERVAL		msecs_to_jiffies(10)

[ ... ]

> @@ -151,8 +175,18 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
>  	struct ptp_vclock *vclock = info_to_vclock(ptp);
>  	struct timespec64 ts;
>  
> -	ptp_vclock_gettime(&vclock->info, &ts);
> +	/* Retry transient failures promptly, but back off during long outages. */
> +	if (ptp_vclock_gettime(&vclock->info, &ts)) {
> +		if (!vclock->retry_delay)
> +			vclock->retry_delay = PTP_VCLOCK_RETRY_INTERVAL;
> +		else
> +			vclock->retry_delay = min_t(unsigned long,
> +						    vclock->retry_delay * 2,
> +						    PTP_VCLOCK_REFRESH_INTERVAL);
> +		return vclock->retry_delay;
> +	}

[Severity: Medium]
Can this backoff skip past the 32-bit counter wrap and lose a full wrap
of virtual time?

The doubling only looks at the previous retry_delay. It does not look at
how long ago the last successful parent sample was taken. The
cyclecounter uses CYCLECOUNTER_MASK(32), so it wraps every 2^32 ns,
about 4.295 s.

Suppose the last good refresh was at t0 and getcycles64() starts failing
at the regular t0+2 s refresh. The retries then run at about:

  t0+2.010, 2.030, 2.070, 2.150, 2.310, 2.630, 3.270 s

After that the delay becomes 1280 ms, so the next attempt is at about
t0+4.550 s. At HZ=250, msecs_to_jiffies(10) rounds up to 12 ms, and the
last two attempts are at 3.524 s and 5.060 s.

If the outage ends anywhere between about 3.27 s and 4.295 s, the first
successful sample still comes more than 2^32 ns after cycle_last.
timecounter_read_delta() then masks the delta:

kernel/time/timecounter.c:timecounter_read_delta() {
    ...
	cycle_delta = (cycle_now - tc->cycle_last) & tc->cc->mask;
    ...
}

As a result, tc->nsec moves forward about 0.255 s instead of about
4.55 s. The virtual clock silently steps back by about 4.295 s, and no
error is returned.

A fixed 2 s refresh would have retried at t0+4.0 s and kept the wrap.
The commit message says:

    An isolated read failure
    should not deliberately defer the next attempt until that sample is four
    seconds old.

Here the backoff delays the next attempt until the sample is about
4.55 s old, after an outage of only about 1.3 to 2.3 s.

The later patches in this series do not change ptp_vclock_refresh(), so
this looks like it is still present at the end of the series.

Could the code record jiffies at the last successful sample and clamp
the returned delay? The next attempt would then land before
last_success + 2^32 ns, and preferably before the half-wrap point.

>  
> +	vclock->retry_delay = 0;
>  	return PTP_VCLOCK_REFRESH_INTERVAL;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-ptp-vclock-sampling-v5-0-06ceace17bac%40gmail.com
