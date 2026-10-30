Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364812;
	b=nWojWe1Hn10YBYDtByoDIme88hRCH2KJ+xGx560tEBnl2kY98dXhDdjsBr/f26nOOm6/
	 36Y/C189HH9OnXJ39gh71KXjvu5XmGFVSXooFo7x9Rrh7MDF9KPAx5I8cu+wjezs9Qcz9
	 qT2nq1r0aMB9W75puMQ5fEdye69UEexQ+zO/Ri8c3uTZTOI11CcAdWV8R8hshy1zdCSjc
	 fCRbJ6Sf71UzHx+6i4FnjeC/BJYouEceevteg0XgTDwJwkTKjDYB0nUTpOIgg4FE/MJll
	 fsQpln2tkoFzgUFwY0jCB1bKdMeuvQsvp7tgfw5rFg3mci33IEg2muBRpEyLtnvKSfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364812;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1kziA5drPPyq+6tSeFxqJ4sq1en25CYOmKxBsu8KxP0=;
	b=euGnSpcNMWSV2RD4ZM4xnDEgbzYA+47hjj6GRE5V9KEa8NDHCK+F0RYYve+crswj/gts
	 4+BfbkaoZX49T+9kAakPOuuoTAnn0BOBj7q7SPzQJ6lF1QCOWhh1n2b5P8pA63daDLVwo
	 bjSPzNYuQrLQWnosRdrrDh5wGDE2alDvi8ezczlxu08cjMoWDAEqM9HlP5qCPtqmGWGqp
	 Kkqyvd73QE3KpuJxHDlVAIPo90KztOcThLdLuUSJfQuAlJUFaJHJk2UOjlulpNnRAYSpB
	 kFcwaintM979Txm/oQK0pekjs7XZukMbnnaQ85tO2LEkHqKM0aYuDaXBXBO/tXubbQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9XNpqsB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A647606A326;
	Fri, 30 Oct 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9XNpqsB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB861F000C1;
	Fri, 30 Oct 2026 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364811;
	bh=1kziA5drPPyq+6tSeFxqJ4sq1en25CYOmKxBsu8KxP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c9XNpqsBR1XHOkcWfVXpAu3HilyQP4LGmtYB4fb2vFs7V43+/Cpm03qTLiPzD7+Pd
	 QYH9OutIg1dLM4MuH8innzP8z6HMgVAzCusVvvxyMvKQrI+pI4ZvhJ5qy6J6UmVwiv
	 MI1A/XBetiyJI4DivZ9haC3k7ngtGlMepIXH49O14UcQjht6atz4Kv4DQLAZggtYcc
	 r0G0FKRHLzlKf/Epirp+7SU15J8esxZLHB76tc/dFeiQv0MAee0B7gA40oK5b2uohG
	 jayAGd1LyyelLP2yaex1T5zPXI2FkZd3msGUOy2ovWY77qcUjE1nGCJu5wHBu8sd0Y
	 +Dm/H2x8QxtjQ==
Subject: Re: [PATCH net v4 2/3] sfc: ptp: serialize host and MC
 synchronization transactions
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 12:53:30 +0000
Message-ID: <179336481081.3134.5405870739856758840@kernel.org>
In-Reply-To: <20261026123023.3566549-3-alex.austin@amd.com>
References: <20261026123023.3566549-3-alex.austin@amd.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new kernel-doc for `@phc_lock` in struct efx_ptp_data
  (drivers/net/ethernet/sfc/ptp.c:275-276) says the lock "Serializes PHC…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  `_efx_phc_adjtime()` in drivers/net/ethernet/sfc/ptp.c (line 2144)…
- [Medium] Baseline decision: not a defect of this patch (pre-existing,
  Medium, in a driver the patch does not touch).
- [Low] Baseline decision: false positive, fixed later in the series.

--

sfc: ptp: serialize host and MC synchronization transactions

This adds a phc_lock mutex to struct efx_ptp_data. The mutex is held
across the whole efx_ptp_synchronize() transaction and around the PHC
adjfine/adjtime/settime operations, so the PPS worker and the hwtstamp
enable path no longer clobber each other's handshake flag and timesets.
It also bails out of efx_ptp_synchronize() when efx_mcdi_rpc_start()
fails.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 957ca08092e7f..e26269fae38d6 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c

[ ... ]

> @@ -271,6 +272,8 @@ struct efx_ptp_rxfilter {
>   * frequency adjustment into a fixed point fractional nanosecond format.
>   * @current_adjfreq: Current ppb adjustment.
>   * @phc_clock: Pointer to registered phc device (if primary function)
> + * @phc_lock: Serializes PHC commands and synchronization, and protects
> + *	      @current_adjfreq

[Severity: Low]
Does this comment claim more coverage than the code gives? Two of the
callbacks in the PHC ops table don't take phc_lock. efx_phc_gettime()
(.gettime64) sends MC_CMD_PTP_OP_READ_NIC_TIME, and efx_phc_enable()
(.enable) flips nic_ts_enabled. A standalone clock_gettime() on the PHC
therefore runs without phc_lock.

Making the comment true by adding the lock to efx_phc_gettime() would
self-deadlock, because efx_phc_settime() now calls it with phc_lock
already held:

	mutex_lock(&ptp_data->phc_lock);
	rc = efx_phc_gettime(ptp, &time_now);

Nothing breaks today, since the MCDI interface lock already serializes
the RPCs. Could the comment instead list what phc_lock actually covers
(synchronize, adjfine, adjtime and settime)?

>   * @phc_clock_info: Registration structure for phc device
>   * @pps_work: pps work task for handling pps events
>   * @pps_workwq: pps work queue

[ ... ]

> @@ -1026,11 +1037,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
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
This is a pre-existing issue, and it is not in a file this patch
touches. The Siena copy of this function still has the same pattern:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_synchronize() {
    ...
	WRITE_ONCE(*start, 0);
	rc = efx_siena_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
				      MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
	EFX_WARN_ON_ONCE_PARANOID(rc);
    ...
}

It takes no host lock around the handshake flag. When rpc_start fails
it still goes on to efx_siena_mcdi_rpc_finish(), and it processes
results into ptp->timeset[] after the MCDI interface has been released.
Both racing callers exist there as well: efx_ptp_pps_worker() and
efx_ptp_change_mode().

The Siena efx_phc_settime() also still does an unserialized gettime
followed by adjtime. current_adjfreq is written in efx_phc_adjfine() and
read in efx_phc_adjtime() with no lock.

Would it make sense to send a separate sfc/siena patch with the same
fix?

>  
>  	/* Wait for start from MCDI (or timeout) */
>  	timeout = jiffies + msecs_to_jiffies(MAX_SYNCHRONISE_WAIT_MS);
> @@ -1061,11 +1075,13 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
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

[Severity: Low]
This isn't a bug introduced by this patch, but ptp->host_time_pps is
still read outside phc_lock. efx_ptp_process_times() writes it under
the lock in several steps:

	ptp->host_time_pps = *last_time;
	pps_sub_ts(&ptp->host_time_pps, delta);

efx_ptp_pps_worker() then copies it after efx_ptp_synchronize() has
dropped the lock:

	ptp_evt.pps_times = ptp->host_time_pps;

Can a concurrent efx_ptp_synchronize() from efx_ptp_change_mode()
overwrite host_time_pps before the PPS worker reads it?

The next patch in the series, "sfc: ptp: avoid racing PPS timestamp
updates", appears to address this. It removes the shared host_time_pps
field and has efx_ptp_synchronize() return the timestamp through a
caller-provided struct pps_event_time. The PPS worker passes a stack
variable and efx_ptp_change_mode() passes NULL.

>  
>  	return rc;
>  }

[ ... ]

> -static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +static int _efx_phc_adjtime(struct efx_ptp_data *ptp_data, s64 delta)
> +	__must_hold(&ptp_data->phc_lock)
>  {
> -	u32 nic_major, nic_minor;
> -	struct efx_ptp_data *ptp_data = container_of(ptp,
> -						     struct efx_ptp_data,
> -						     phc_clock_info);
> -	struct efx_nic *efx = ptp_data->efx;
>  	MCDI_DECLARE_BUF(inbuf, MC_CMD_PTP_IN_ADJUST_LEN);
> +	struct efx_nic *efx = ptp_data->efx;
> +	u32 nic_major, nic_minor;
> +
> +	lockdep_assert_held(&ptp_data->phc_lock);
>  
>  	efx->ptp_data->ns_to_nic_time(delta, &nic_major, &nic_minor);

[Severity: High]
This is a pre-existing issue, but should this be
ptp_data->ns_to_nic_time() rather than going back through
efx->ptp_data? The ptp_data argument comes from container_of() on the
registered phc_clock_info, so it is always valid here.

efx_realloc_channels() clears efx->ptp_data while it tears down the old
channels, and the PHC stays registered for that whole time:

drivers/net/ethernet/sfc/efx_channels.c:efx_realloc_channels() {
    ...
out:
	efx->ptp_data = NULL;
	/* Destroy unused channel structures */
	for (i = 0; i < efx->n_channels; i++) {
    ...
	efx->ptp_data = ptp_data;
    ...
}

A clock_settime() or clock_adjtime(ADJ_SETOFFSET) on the PHC that runs
at the same time as ethtool -G could then do:

efx_phc_settime() or efx_phc_adjtime()
  mutex_lock(&ptp_data->phc_lock)
  _efx_phc_adjtime()
    efx->ptp_data->ns_to_nic_time()    <-- efx->ptp_data is NULL

The PHC ioctl path does not take RTNL, and efx_realloc_channels() does
not take phc_lock, so nothing seems to stop the two from overlapping.

With this patch the oops now happens while phc_lock is held. Would that
leave the mutex locked for good? Every later efx_ptp_synchronize() call
would then block, both from the PPS worker and from
efx_ptp_change_mode(), which runs under RTNL for SIOCSHWTSTAMP.

Since this function is already being reworked here, using the ptp_data
argument would avoid the NULL dereference.

>  
> @@ -2133,6 +2152,18 @@ static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  			    NULL, 0, NULL);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026123023.3566549-1-alex.austin%40amd.com
