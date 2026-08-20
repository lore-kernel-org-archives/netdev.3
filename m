Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47042A164;
	Thu, 20 Aug 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241380; cv=none; b=fU5FY8aUFBlYGP/px62MB+5lZ7nvHBKkyx9XckY4xvvJuwfIk0zVLmzOjDSh0bpH8U1Xg/FFwCoi9oidARxKRWRtPK3MO4ou01Qt3eqXjY+mDV6zaAzst2EtqpWeeqoDsPW+Rrmwn4WyU8kaRDnVEzmbi6gw1sO8FpYjrE+Hsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241380; c=relaxed/simple;
	bh=XSNoXPvKSLxy18NDikrDEH81F5HVqT2ksUllmlZeI3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8+yMFYY6qV4CD4WX7sNbZwDeEdi0CpXwjO4InqHqBVKAN7c4IA4FpXU/VtmwuY6e4NeDd4bfecgKj2HVxNnkwpQuX3yb7cVdam5T8PUAt9VfqgZRGTVtnnYDfK4rbsdmsKUoal3fklsMNIzz1YkkUf9RjT/wpzx77IlzipzPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkFLOxgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkFLOxgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637911F000E9;
	Thu, 20 Aug 2026 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787241379;
	bh=v4NplXrQfRG6wRcu4aPDPd0IjVzuVG4BC7S6mpuraKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bkFLOxgMp4CIBv0T9acdreBA8s4VtAo/Y1P0o0e+RVkOM0Qeec76qd0w24vfkRggY
	 8wgmeESMQwjrlK6bcafprHlNkjm9B0Ib7G8VANM3UaSC1NUKFWWP5k9Xe6tO12cjy3
	 MhXPhwZ7BDrF4juGDXNtm4g6RAZTWCqPDoy/VczwJax+lB+qr5Qa4m5WdpIbBiblJv
	 +mmYF4Tm2qwwbLE35XylPhUkks/Cly16tIicikodMVLHruOoanDLEso9DBIGCGjlEJ
	 e6AoAIbnuSEBYuUfB2o/5xtcuMmXYyBE1bMhVIaUqrU9j14W8d3L4Ok2iL+fEecdlU
	 AGYPLd8CCzG5w==
Date: Thu, 20 Aug 2026 16:56:15 +0100
From: Simon Horman <horms@kernel.org>
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Frank.Li@nxp.com, wei.fang@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Message-ID: <20260820155615.GA265046@horms.kernel.org>
References: <20260818033342.3154990-1-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818033342.3154990-1-wei.fang@oss.nxp.com>

On Tue, Aug 18, 2026 at 11:33:41AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The max_period bound in net_timer_enable_perout() was computed as:
> 
>   max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> 
> which exceeds U32_MAX when integral_period > 0 (e.g. 0x100000002 for
> the default 333333333 Hz clock). A period_ns that passes this check but
> exceeds U32_MAX is then silently truncated when stored into the u32
> struct netc_pp::period field.
> 
> A truncated value of zero can reach netc_timer_set_perout_alarm(), where
> the local u32 period variable would also be 0, causing a divide-by-zero
> in roundup_u64(delta, period) whenever the stime < min_time branch is
> taken (which always happens for a start time of {0, 0}).
> 
> Additionally, netc_timer_enable_periodic_pulse() and
> netc_timer_enable_fiper() both compute:
> 
>   fiper = pp->period - integral_period;
> 
> A zero pp->period results in an unsigned wraparound to 0xFFFFFFFD,
> mis-programming the FIPER hardware register.
> 
> Fix all three issues by capping max_period at NETC_TMR_DEFAULT_FIPER
> (0xFFFFFFFF). This ensures that any period_ns passing the range check
> fits in a u32 without truncation, so the stored value is always valid
> and non-zero. The accepted range is reduced by integral_period ns
> (typically only a few nanoseconds), which is negligible in practice.
> 
> Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

If so, then I think NETC_TMR_DEFAULT_FIPER can simply be used in
place of max_period.

Something like this (completely untested!):

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 28889b7b3e15..66d1f0532585 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -434,22 +434,22 @@
 	}

 	if (on) {
-		u64 period_ns, gclk_period, max_period, min_period;
+		u64 period_ns, gclk_period, min_period;
 		struct timespec64 period, stime;
 		u32 integral_period;
 		int alarm_id;

 		period.tv_sec = rq->perout.period.sec;
 		period.tv_nsec = rq->perout.period.nsec;
 		period_ns = timespec64_to_ns(&period);

 		integral_period = netc_timer_get_integral_period(priv);
-		max_period = NETC_TMR_DEFAULT_FIPER;
 		gclk_period = netc_timer_get_gclk_period(priv);
 		min_period = gclk_period * 4 + integral_period;
-		if (period_ns > max_period || period_ns < min_period) {
+		if (period_ns > NETC_TMR_DEFAULT_FIPER ||
+                   period_ns < min_period) {
 			dev_err(dev, "The period range is %llu ~ %lu\n",
-				min_period, max_period);
+				min_period, NETC_TMR_DEFAULT_FIPER);
 			err = -EINVAL;
 			goto unlock_spinlock;
 		}

