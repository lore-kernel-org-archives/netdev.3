Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926773;
	b=MjtLb7f7HUM3K7VbNX86s4t/jr2AEXa3nM06D0KijIMvsFOXD8qw/WnStbtDS0YD1sUr
	 s6ZtCa3wySO+BTM1NlDP6AOrFIUtVcCHOpBKLYN/X3UGBli88HSMW734Rpt8jKCTmGXYd
	 KkHyQ7e2/oV4o13TsLrV1osLu19uScTFWpmlxi7c75lyOApXxDT4w5fG1+jGQb29JbMno
	 RK2Bf408J59bdwDofrsF6Y5LNizK8FUPqeCAmGB1O7FimnyaSBKoX83MWdyBOQs+Az154
	 it6s5CqD7Z28iKd2zdjYLjsSIRqVjdkd6UraHjZTC2960OIBHNfTr4Aeq0ZKBw1w2Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926773;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=c6HZ5AuQuDdSM6WePTl5pWE3nzEiRcbOpys/vPqDFO0=;
	b=aQg7bqfmHFIWm6lybwIg8BWtd2maRvtc0Ns1VgKGoky+xykNnp/0kgCcuvGV9BlrolsG
	 bEQCZN870Rx7mCAqq4xylnXkM6/iq72K27L0S9u5jIolBwI5LQm1YIX3Mqgnjp7Zm0kCA
	 qfrykz2qf2cXM3v/a/iF4qvcE2IzisEL3A+6vy787p+Wh92+Jvbzw+gMuK51OgGL+FV2b
	 3p6dPSvEJB5Nt8ie8Sj0kvsyZVq3zT2sUCEEeEX/JHROIbVhSeGcYDvpLJt04+q2h9jl9
	 VsMzkgXr9vxXjv4nZPh+E31CEatZvZzq51+1d3uFBkFzz49UGc8CTmZqwvxTv85N1UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="flZb/4PD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35F606A31E;
	Sun, 25 Oct 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flZb/4PD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDD31F01828;
	Sun, 25 Oct 2026 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792926772;
	bh=c6HZ5AuQuDdSM6WePTl5pWE3nzEiRcbOpys/vPqDFO0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=flZb/4PDwUdWoRVtglXxFjp4FpIq7BMCV4A17VFisPgcsOriLtlZrdifdXRBhDmas
	 sXCkY1gldaDptg9rogMbfPgeYXeCzEORMz02sHeEISR0T+rL4EKTPbJdTEsOtCjVrh
	 HDUeXle1Zj49++gm2owm8X8XgnnBj+dWk3BknuGPc5kpYZ6hM9Bo1Ik25gJVl1bX5w
	 MhLpBX+WFK6ogOFPX+7d1dfXhV6GEx8Gu0bB+Tqp/dGj//A5nefwgA1VgWUOT9oL26
	 VXdpG3Zp2Y6Z9Cx3sYblAWOuZy9/AEYLJRGV2BCBRJAt8/1Z5p6unG9Us2fKizo+Ew
	 KZr78mbB4Ru7g==
Subject: Re: [PATCH net v3 2/3] sfc: ptp: serialize host and MC
 synchronization transactions
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com
Date: Sun, 25 Oct 2026 11:12:51 +0000
Message-ID: <179292677109.3134.11754540009075067459@kernel.org>
In-Reply-To: <20261021091534.3164258-3-alex.austin@amd.com>
References: <20261021091534.3164258-3-alex.austin@amd.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Siena driver keeps its own copy of the PTP code in
  drivers/net/ethernet/sfc/siena/ptp.c (built into sfc-siena by…
- [Low] The new kernel-doc for @phc_lock in struct efx_ptp_data
  (drivers/net/ethernet/sfc/ptp.c line 276) says the lock "Serializes…

Pre-existing issues:
- [Medium] At this commit, efx_ptp_pps_worker()
  (drivers/net/ethernet/sfc/ptp.c line 1511) copies the shared…

--

sfc: ptp: serialize host and MC synchronization transactions

This adds a phc_lock mutex to struct efx_ptp_data. The lock is held for
the whole efx_ptp_synchronize() transaction and for the PHC adjfine,
adjtime and settime operations. It also makes efx_ptp_synchronize()
bail out when efx_mcdi_rpc_start() fails, instead of finishing an RPC
that was never started.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 2247e5e3e25a8..eedab53e308af 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c

[ ... ]

> @@ -272,6 +273,8 @@ struct efx_ptp_rxfilter {
>   * frequency adjustment into a fixed point fractional nanosecond format.
>   * @current_adjfreq: Current ppb adjustment.
>   * @phc_clock: Pointer to registered phc device (if primary function)
> + * @phc_lock: Serializes PHC commands and synchronization, and protects
> + *	      @current_adjfreq

[Severity: Low]
This isn't a bug, but does this comment claim more than the code does?
efx_phc_gettime(), the .gettime64 op, sends MC_CMD_PTP_OP_READ_NIC_TIME
without taking phc_lock. Only efx_phc_settime() holds the lock when it
calls efx_phc_gettime():

efx_phc_gettime() {
    ...
	rc = efx_mcdi_rpc(efx, MC_CMD_PTP, inbuf, sizeof(inbuf),
			  outbuf, sizeof(outbuf), NULL);
    ...
}

efx_phc_enable() also changes nic_ts_enabled without the lock. Only
adjfine, adjtime, settime and synchronize are serialized.

Could the comment name the operations the lock actually covers? Or
should gettime take the lock as well?

>   * @phc_clock_info: Registration structure for phc device
>   * @pps_work: pps work task for handling pps events
>   * @pps_workwq: pps work queue

[ ... ]

> @@ -1027,11 +1038,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
>  	MCDI_SET_QWORD(synch_buf, PTP_IN_SYNCHRONIZE_START_ADDR,
>  		       ptp->start.dma_addr);
>  
> +	mutex_lock(&ptp->phc_lock);
> +
>  	/* Clear flag that signals MC ready */
>  	WRITE_ONCE(*start, 0);
>  	rc = efx_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
>  				MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
> -	EFX_WARN_ON_ONCE_PARANOID(rc);
> +	if (rc)
> +		goto out;

[Severity: Medium]
Does the Siena driver need the same fix?

drivers/net/ethernet/sfc/siena/ptp.c is a separate copy that is built
into sfc-siena (siena/Makefile lists ptp.o). Its efx_ptp_synchronize()
still matches the version this patch replaces:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_synchronize() {
    ...
	WRITE_ONCE(*start, 0);
	rc = efx_siena_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
				      MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
	EFX_WARN_ON_ONCE_PARANOID(rc);
    ...
}

No lock is held there. efx_ptp_pps_worker() and
efx_siena_ptp_change_mode() can still race. The second one is reached
from ptp_set_ts_config() in siena.c. Each can clear the other's
handshake flag and overwrite ptp->timeset[] and ptp->host_time_pps.

efx_siena_mcdi_rpc_start() can return -ENETDOWN early, before
efx_mcdi_acquire_sync(), when mc_bist_for_other_fn is set or the mode
is MCDI_MODE_FAIL. The Siena function still calls
efx_siena_mcdi_rpc_finish() in that case, so it waits on and releases
an MCDI interface it never acquired.

Siena's efx_phc_settime() still calls efx_phc_gettime() and then
efx_phc_adjtime() as two separate steps, with no lock held.

current_adjfreq is still written without a lock in efx_phc_adjfine()
and efx_ptp_start(), and read in efx_phc_adjtime(). Patch 1 of this
series removes the efx_ptp_start() reset only from sfc. Nothing under
sfc/siena/ has a phc_lock.

The later "sfc: ptp: avoid racing PPS timestamp updates" patch fixes a
PPS race that is also still present in Siena:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_pps_worker() {
    ...
	ptp_evt.pps_times = ptp->host_time_pps;
    ...
}

All of this code descends from 7c236c43b838, the commit named in the
Fixes: tag. Should there be a companion sfc/siena patch, or at least a
note in the commit message, so that stable backports cover Siena too?

>  
>  	/* Wait for start from MCDI (or timeout) */
>  	timeout = jiffies + msecs_to_jiffies(MAX_SYNCHRONISE_WAIT_MS);

[ ... ]

> @@ -1062,11 +1076,13 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
>  			++ptp->no_time_syncs;
>  	}
>  
> +out:
>  	/* Increment the bad syncs counter if the synchronize fails, whatever
>  	 * the reason.
>  	 */
>  	if (rc != 0)
>  		++ptp->bad_syncs;
> +	mutex_unlock(&ptp->phc_lock);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
ptp->host_time_pps is still read after phc_lock has been dropped.
efx_ptp_pps_worker() copies it after efx_ptp_synchronize() returns:

efx_ptp_pps_worker() {
    ...
	ptp_evt.pps_times = ptp->host_time_pps;
    ...
}

At the same time,
efx_ptp_change_mode()->efx_ptp_synchronize()->efx_ptp_process_times()
can be rewriting the field in two steps under the lock:

	ptp->host_time_pps = *last_time;
	pps_sub_ts(&ptp->host_time_pps, delta);

Can the worker then pass a half-updated PPS timestamp, or the other
caller's timestamp, to ptp_clock_event()?

The next patch in the series, "sfc: ptp: avoid racing PPS timestamp
updates", appears to fix this for sfc. It returns the timestamp through
a caller-owned struct pps_event_time in efx_ptp_pps_worker() and passes
NULL from efx_ptp_change_mode().

>  
>  	return rc;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021091534.3164258-1-alex.austin%40amd.com
