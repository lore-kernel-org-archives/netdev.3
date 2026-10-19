Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423514DA9D6;
	Mon, 19 Oct 2026 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411121; cv=none; b=FPHxJ6eVVyKfokKKwjJ+m2bJO5NwvYF4Ui6R+P0Ho++pqmsnVPAjphf8KO2z34PSTdd47Yd1pOFb6RYhuY6fOQ0Ix/QHE2DaTDy/4nIjiPRG4GoQuHWKj5LjiyhRPIC5BFBS0ecmiCST2D4aRZycX6XvtXmQedAFDWJS1cRyHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411121; c=relaxed/simple;
	bh=K1VB74abNbOAck37keRrgF/0OegSsDtCEmgWOWcH2b4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mUrx41YQllki09xgfBCVlPFPxWLRTYbBVp8R1b7twNqVq33iAZXBTPsnKaka4mW+I20LxM6R+73Gu3l+leZ/XVPeqOkJiz5X/BIplQHQgDqo52ggLD431GVKTQ14+Ry/gmxSgouGQ/TG8gc3obfw6mnd7IddxyD4s1v5eWN99bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF3e5hpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF3e5hpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A01F000C4;
	Mon, 19 Oct 2026 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411120;
	bh=aP+CfqviOKAMqwEpGVXJ4KmWQVovOfynC/UxbrqF8yY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BF3e5hpkqdKjSiRjcGGbdZthnQgjLe9wP28qXkd5/oRCtBXJPnWMvyQSOI6xX0Lh9
	 yxTfCCfOH0ASy9NDmFThUdajot6ykmLVrlu5tpzOylgz6yLVxkcsjopxuzvyNq9uvg
	 BnXqvQb8LoH9OLyymawsnt6nngvv/GoS9XBmOu7RnX99KuTUryq98Yaa9HnGGxKQXP
	 npaYOaYyZatZuGu+ME293IWHQjm/5I+37aJelI8xb84w0K1zO8ZxDxxZbRfExcgNWP
	 pE7T4TOUlBafRfOT8DeHw6Wn8DNNUkYbf6L3LdKCuSRQ3Bvi7Eg/eSJLSVh06dAIso
	 XdQlds1rkD/jA==
Subject: Re: [PATCH net v2 1/2] sfc: ptp: serialize host and MC
 synchronization transactions
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:58:39 +0000
Message-ID: <179241111900.3135.15377803717583250573@kernel.org>
In-Reply-To: <20261015114104.2531624-2-alex.austin@amd.com>
References: <20261015114104.2531624-2-alex.austin@amd.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: the Siena sibling driver is left with the same
  bugs.
- [Medium] efx_ptp_start() sends MC_CMD_PTP_OP_ENABLE through
  efx_ptp_enable() (line 1460) with no lock held.
- [Low] Resolved later in the series (baseline decision: false).
- [Low] The new kernel-doc for @phc_lock in struct efx_ptp_data (lines
  276-277) says the lock 'Serializes PHC commands and synchronization,…

--

sfc: ptp: serialize host and MC synchronization transactions

This patch adds a phc_lock mutex to struct efx_ptp_data. The lock is held
across efx_ptp_synchronize(), the PHC adjfine/adjtime/settime callbacks,
and the current_adjfreq reset in efx_ptp_start(). efx_ptp_synchronize()
also now bails out when efx_mcdi_rpc_start() fails, instead of finishing
an RPC that was never acquired.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 6ca9a75af01d8..c2f8b94592718 100644
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
Does this description cover more than the code does?

efx_phc_adjfine(), efx_phc_adjtime() and efx_phc_settime() take
phc_lock. efx_phc_gettime(), which is the gettime64 callback, still sends
MC_CMD_PTP_OP_READ_NIC_TIME without it when the PTP core calls it
directly:

drivers/net/ethernet/sfc/ptp.c:efx_phc_gettime() {
    ...
	rc = efx_mcdi_rpc(efx, MC_CMD_PTP, inbuf, sizeof(inbuf),
			  outbuf, sizeof(outbuf), NULL);
    ...
}

efx_phc_enable() also updates its state without the lock:

	ptp_data->nic_ts_enabled = !!enable;

Could the comment be limited to the operations that actually take
phc_lock?

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
Does drivers/net/ethernet/sfc/siena/ptp.c need the same fix? It has the
same code, and every problem fixed here is still present there.

In siena, efx_ptp_synchronize() clears the start flag without a lock. If
the start fails, it still goes on to efx_siena_mcdi_rpc_finish():

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_synchronize() {
    ...
	/* Clear flag that signals MC ready */
	WRITE_ONCE(*start, 0);
	rc = efx_siena_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
				      MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
	EFX_WARN_ON_ONCE_PARANOID(rc);
    ...
}

efx_siena_mcdi_rpc_start() can return before efx_mcdi_acquire_sync()
through efx_mcdi_check_supported(), mc_bist_for_other_fn or
MCDI_MODE_FAIL.

The siena driver also has the same two concurrent callers,
efx_ptp_pps_worker() and efx_ptp_change_mode(). Its efx_phc_adjfine() and
efx_ptp_start() write current_adjfreq without a lock. Its
efx_phc_settime() still does gettime and adjtime as two separate steps.

The Fixes: tag points at 7c236c43b838 ("sfc: Add support for IEEE-1588
PTP"), the original code that siena/ptp.c was forked from. The commit
message does not mention Siena. Should there be a companion patch for
sfc-siena, or a note on why Siena is not affected?

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
>  
>  	return rc;
>  }

[Severity: Low]
After this unlock, efx_ptp_pps_worker() reads the shared synchronization
result without holding phc_lock:

drivers/net/ethernet/sfc/ptp.c:efx_ptp_pps_worker() {
    ...
	ptp_evt.type = PTP_CLOCK_PPSUSR;
	ptp_evt.pps_times = ptp->host_time_pps;
	ptp_clock_event(ptp->phc_clock, &ptp_evt);
}

Can a concurrent efx_ptp_change_mode()->efx_ptp_synchronize() rewrite
ptp->host_time_pps in efx_ptp_process_times() during that read?

	ptp->host_time_pps = *last_time;
	pps_sub_ts(&ptp->host_time_pps, delta);

If so, ptp_clock_event() would get a torn or foreign timestamp.

The next patch in the series, "sfc: ptp: avoid racing PPS timestamp
updates", removes host_time_pps. It copies the result into a stack-local
pps_event_time under phc_lock, so the unlocked read is gone by the end of
the series.

[ ... ]

> @@ -1446,7 +1462,9 @@ static int efx_ptp_start(struct efx_nic *efx)
>  		goto fail;
>  
>  	ptp->evt_frag_idx = 0;
> +	mutex_lock(&ptp->phc_lock);
>  	ptp->current_adjfreq = 0;
> +	mutex_unlock(&ptp->phc_lock);

[Severity: Medium]
Can a frequency adjustment still be lost here?

Just above this, efx_ptp_start() sends MC_CMD_PTP_OP_ENABLE without
holding any lock:

	rc = efx_ptp_enable(efx);
	if (rc != 0)
		goto fail;

The firmware enable and the cache reset are therefore not one critical
section, and efx_phc_adjfine() can run completely between them:

CPU0 (efx_ptp_start)            CPU1 (clock_adjtime ADJ_FREQUENCY)
efx_ptp_enable() completes
                                efx_phc_adjfine()
                                  mutex_lock(&ptp_data->phc_lock)
                                  MCDI ADJUST with FREQ=X
                                  current_adjfreq = X
                                  mutex_unlock(&ptp_data->phc_lock)
mutex_lock(&ptp->phc_lock)
current_adjfreq = 0
mutex_unlock(&ptp->phc_lock)

The next adjtime or settime goes through _efx_phc_adjtime(), which
programs the frequency from the cached value:

	MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);

That would put the MC back at frequency 0 and drop a correction that
adjfine already reported as applied.

The commit message says current_adjfreq "cannot be torn by the reset in
efx_ptp_start()". The patch prevents tearing, but the cached value can
still get out of sync with the hardware. Would phc_lock need to be held
across both efx_ptp_enable() and the reset?

Also, efx_ptp_enable() treats -EALREADY as success. In that case the
firmware probably did not reset its frequency, but the driver still sets
current_adjfreq to 0. Is that intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015114104.2531624-1-alex.austin%40amd.com
