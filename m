Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99A4A2E2D;
	Sat, 10 Oct 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645060; cv=none; b=lPHOovHugtL035NqW01p7tQWjLJ1m4g9Aku3nKXzUVLaRUyo1Ie5DovmHpSzYBt+DE7zCYhIy3ra5rfeFpH/hm1Ldj3TJhBjS3cNpjEd7fnTOVTCtCtxojtMJ9jcLZxU4Ks78Jj407WpIXLryBsMD7tDce6Xj0EM2LTsP4b5acQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645060; c=relaxed/simple;
	bh=B+ZrO3Zx/KcZpKpoQE1DxfP2O7wfpAnD4j1ZDY1FfJ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meiGljQuaKkT6i4VzNgC80Nx04OgUA1KODLcMjcf34gvA/ZwVCQzOSu1B47eT7rQtpUz5rqyw2Vtosp4yqWoSGAmr4K8NUyl5PAbkxvm5XvZsux6w7KKPeAijfpFpbLrlVnXaFf06ucMK9xcsvcD1eyo7Prj1MTuYO8Uz0g3l2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLQ/aVeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLQ/aVeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD4B1F000FF;
	Sat, 10 Oct 2026 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645058;
	bh=ZQEawHrGNiFndc6AXaoDXk06UpR2L5aj8j9FtsTrp8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DLQ/aVeLPzggBWIXfpyDmYZm8rUi4EjhpgFicSicrqEjHT8SX/3FMZsFJQmDIwomK
	 0vU+hw6rLPqjCsDBmllbzQmoOJpAFZnZGTtqlHbP7L5A8esoaxyu5PVQFL6P5mnbAg
	 y7rgeawbyLc8kSmuOiITBkTObXDpStVvUkmHKELZ8NlcQ7bwM2z1BoWyALM3sDJdOf
	 atIAnjgQX+vNcIJZoYiudYn0LP2ydGeZl2pgpoMPOkjZQS1reB0jBI1LHWIWc2Fp2w
	 yRC8xCsrDPZhQpRRtg1H+uGb3QazDcKX5tiIbzRlGbyQ/CunKHZtzin5dPci+n/Rcn
	 yoD4Qimgf1Rqg==
Subject:
 Re: [PATCH net-next 3/5] ptp: add functions to adjust system timestamps
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, linux@armlinux.org.uk,
 conor.dooley@microchip.com, bcm-kernel-feedback-list@broadcom.com,
 tglx@kernel.org, mlichvar@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 15:10:57 +0000
Message-ID: <179164505716.434549.15283965048051692486@kernel.org>
In-Reply-To: <20261009143506.2507607-4-jjc@jclark.com>
References: <20261009143506.2507607-4-jjc@jclark.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ptp: direct addition of unscaled raw ns to slewed systime

--

> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -520,4 +520,52 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
>  		ktime_get_snapshot_id(sts->clockid, &sts->post_sts);
>  }
>  
> +static inline void __ptp_adjust_snapshot(struct system_time_snapshot *snap,
> +					 s64 ns)
> +{
> +	if (!snap->valid)
> +		return;
> +	snap->systime = ktime_add_ns(snap->systime, ns);
> +	snap->monoraw = ktime_add_ns(snap->monoraw, ns);
> +	/* No counter value corresponds to the adjusted times. */
> +	snap->cycles = 0;
> +	snap->cs_id = CSID_GENERIC;
> +	snap->hw_cycles = 0;
> +	snap->hw_csid = CSID_GENERIC;
> +}
> +
> +/**
> + * ptp_adjust_system_prets - Shift the lower system timestamp bound
> + * @sts: system timestamps, or NULL
> + * @ns: CLOCK_MONOTONIC_RAW nanoseconds to add
> + *
> + * Add @ns to the selected clock's time and to the CLOCK_MONOTONIC_RAW
> + * time of the lower bound, and clear its clocksource counter values.
> + * @ns is not scaled for the selected clock's frequency correction, so
> + * the bound is off by @ns times that correction.
> + */
> +static inline void ptp_adjust_system_prets(struct ptp_system_timestamp *sts,
> +					   s64 ns)
> +{
> +	if (sts)
> +		__ptp_adjust_snapshot(&sts->pre_sts, ns);
> +}
> +
> +/**
> + * ptp_adjust_system_postts - Shift the upper system timestamp bound
> + * @sts: system timestamps, or NULL
> + * @ns: CLOCK_MONOTONIC_RAW nanoseconds to add
> + *
> + * Add @ns to the selected clock's time and to the CLOCK_MONOTONIC_RAW
> + * time of the upper bound, and clear its clocksource counter values.
> + * @ns is not scaled for the selected clock's frequency correction, so
> + * the bound is off by @ns times that correction.
> + */
> +static inline void ptp_adjust_system_postts(struct ptp_system_timestamp *sts,
> +					    s64 ns)
> +{
> +	if (sts)
> +		__ptp_adjust_snapshot(&sts->post_sts, ns);
> +}
> +
>  #endif

[Severity: Medium]
__ptp_adjust_snapshot() adds ns straight onto snap->systime, and the
kerneldoc defines ns as a CLOCK_MONOTONIC_RAW duration. When
sts->clockid is CLOCK_MONOTONIC_RAW, systime is a copy of monoraw and
this is exact. For CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME or
an aux clock it is not: systime is in the selected clock's timescale,
which runs at the NTP/adjtimex corrected rate rather than the raw
rate. After the shift, systime and monoraw no longer describe the same
instant, and systime is off by ns times the current frequency
correction.

You already note this in the kerneldoc and below the cut line. For the
30 us MDIO write in this series the error stays at a few ns, even
during a large slew. My concern is the API scope.
ptp_adjust_system_prets() and ptp_adjust_system_postts() go into a
public header and accept any s64 ns. A later caller compensating for a
longer delay, such as a slow bus or a firmware round trip, would
silently move the bound by the wrong amount. The error is largest
exactly while the servo is slewing.

That matters most when pre_sts is moved forward. If it moves too far,
it can end up after the event it is supposed to precede. Userspace then
gets a pre/post window from PTP_SYS_OFFSET_EXTENDED that does not
actually bound the PHC read.

Could the ktime_scale_raw_ns() style helper you sketched be added to
timekeeping as part of this series, so the shift is done in the right
timescale? If that is out of scope, could the helpers document, or
enforce, a small upper bound on ns? Alternatively, should this stay
local to the MDIO driver until timekeeping can do the conversion?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009143506.2507607-1-jjc%40jclark.com
