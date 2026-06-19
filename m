Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20727FB1C;
	Fri, 19 Jun 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876091; cv=none; b=alt5lxvqcs8FYVmjK2A4QB99vUCmzo0HHN6oddtvf0N9GZFJfxtvws9eckX8KNdXA7sXncZEXiFN1qQ8g+mPpXLoGItvujthydHLdS1p28v8bz3qqXL/wUfIQbO5af5t6WB2QE4IWodgq2dTFalXsN6tUOfKESvUnQdf9gPIHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876091; c=relaxed/simple;
	bh=MlKwNk2tIhg2bj+hW6ItwWaYlAHfR2rh6+w7oqF4df0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUwisFJtdT2eK+LwMDPRM73g70Ox6DpPEy56r/TObx91WyDoz74OLqZmNqHzokyJ4ftscYud/eUh4kw25XMb0qzRG/wowqMYBN+d+szdcioxQ5VEoZPqIvuYtP4zw4+psk7FfUbhhIvYEIRpLdd8HY+qE6z8fTOnY9K4tJpfv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmOx9nLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmOx9nLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F395A1F000E9;
	Fri, 19 Jun 2026 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781876089;
	bh=sYUHHCrenxlXGhXvwjnod9b/MuyHh0FLIEdEp8H8pYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RmOx9nLwYp1abOLvpJwfCiCykM82dqqtnKBbGJSoHFncYV7vCq9bujBhggmyA3j6n
	 AeLRRQwiRjZqZAvEGMQX1N4FqVkI+d1swvLtyxgr5S7HgZO5sXKCEOjvDK5Ar4y+wW
	 zZbAhuEEWFr6QRKpWDMoPuqikAuI1RRBztRRW7ZfbKUQp3sc6aQSzomFlstwkZhF50
	 34ffM8a9IsRORQnUSuU6LyNdvpv/knPMffblwS0RUQl633eT/YuhL/80C/8R3mgNDx
	 ZkJBSkP58xVxrdtk6sgsx3v0rE/Ac34rxkt8UV+fvh2y1Redlf5uRSMPjRsdXsCgfq
	 znh3VAoprtarw==
From: Thomas Gleixner <tglx@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [RFC] Enabling CONFIG_NTP_PPS for NOHZ by adding ntp_error to
 system_time_snapshot
In-Reply-To: <3616fc9718614bf11915569599038a5bcb268c02.camel@infradead.org>
References: <3616fc9718614bf11915569599038a5bcb268c02.camel@infradead.org>
Date: Fri, 19 Jun 2026 15:34:46 +0200
Message-ID: <87h5myd56x.ffs@fw13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 19 2026 at 01:33, David Woodhouse wrote:
> @@ -1285,6 +1286,45 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *syst
>  
>  		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
>  		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
> +
> +		/*
> +		 * For the NTP-disciplined mono-based clocks, report how far
> +		 * @systime is from the ideal NTP time at @now, in signed ns,
> +		 * so a caller can land on the ideal line by adding it. Four
> +		 * terms, summed in ns << NTP_SCALE_SHIFT before converting:
> +		 *
> +		 *  - tk->ntp_error, the deviation as of the last update;
> +		 *  - (cycle_delta * ntp_err_frac), the fractional-mult drift
> +		 *    accrued since then (cycle_delta is at most a tick on a
> +		 *    tickful kernel, but many ticks' worth under NO_HZ);
> +		 *  - (cycle_delta * ntp_err_mult), subtracting the applied +1
> +		 *    mult dither over the same span;
> +		 *  - the sub-ns fraction @systime dropped when the read was
> +		 *    truncated to whole ns (low @shift bits, exact despite the
> +		 *    multiply overflowing).
> +		 *
> +		 * RAW is undisciplined and AUX has its own discipline, so they
> +		 * carry no ntp_error.

AUX has ntp_error too. AUX clocks have a per clock NTP instance, which
work exactly like the main timerkeeper's one. Only CLOCK_MONOTONIC_RAW
needs to be excluded.

> +		 */
> +		if (clock_id == CLOCK_REALTIME || clock_id == CLOCK_MONOTONIC ||
> +		    clock_id == CLOCK_BOOTTIME) {
> +			u32 nes = tk->ntp_error_shift;
> +			u64 cycle_delta = (now - tk->tkr_mono.cycle_last) &
> +					  tk->tkr_mono.mask;
> +			s64 err = tk->ntp_error +
> +				(((s64)mul_u64_u64_shr(cycle_delta,
> +						       tk->ntp_err_frac, 32) -
> +				  (s64)(cycle_delta * tk->ntp_err_mult)) << nes);
> +
> +			err += (s64)((cycle_delta * tk->tkr_mono.mult +
> +				      tk->tkr_mono.xtime_nsec) &
> +				     ((1ULL << tk->tkr_mono.shift) - 1)) << nes;
> +			systime_snapshot->ntp_error =
> +				(err + (1LL << (NTP_SCALE_SHIFT - 1))) >>
> +				NTP_SCALE_SHIFT;

This formatting makes my brain hurt. Can you please split that out into
a separate function?


/*
 * Big fat comment....
 */
static void snapshot_ntp_error(clockid_t clock_id, struct system_time_snapshot *snap,
       			       struct timekeeper *tk)
{
	if (clock_id == CLOCK_MONOTONIC_RAW) {
        	snap->ntp_error = 0;
                return;
        }

	u64 cycle_delta = (now - tk->tkr_mono.cycle_last) & tk->tkr_mono.mask;
       	u32 nes = tk->ntp_error_shift;
	s64 tmp, err = tk->ntp_error;

        err += ((s64)mul_u64_u64_shr(cycle_delta, tk->ntp_err_frac, 32) -
               (s64)(cycle_delta * tk->ntp_err_mult)) << nes;

	tmp = (s64)(cycle_delta * tk->tkr_mono.mult + tk->tkr_mono.xtime_nsec);
        tmp &= (1ULL << tk->tkr_mono.shift) - 1;
	err += tmp << nes;
	snap->ntp_error = (err + (1LL << (NTP_SCALE_SHIFT - 1))) >> NTP_SCALE_SHIFT;
}

or something readable like that.
                      
