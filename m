Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F03EB11E;
	Sat, 10 Oct 2026 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659449; cv=none; b=UlwDn5MXrsxK879G4mPYhapW/s7cuhwTpsW+6esJRInLzYWfWmg0+x0Sgkzsv2SKkyl9CdHPm1qpFffX0FEX5BGAO1bgnMebg4q640KOAsu+tfT6lt+ukWcMwRRMaQpka/hgdTxaj16CYKNpsZy5k7bxgxBt4EpbG+i8XmZo6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659449; c=relaxed/simple;
	bh=siTGSaxa2ghjbwi1HBCDUIewIA+lbRItIkT1fFM421Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVp5K5abIQUOX0Hig5xYx5u8H9680eLkVKm10M++0J6o8bfWS2PvfnWD/4QPlZHcmxsNqxqtWcG+f1OoMqB2fBLdYGTvdQzEkJ2NwWuZHMf0QKRvdWsMZ5GCL12+8+Uu0EVpDpSodGWG8/wxBzaZj7OjHnNqcWj2mr//h+ABi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBscKhh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBscKhh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703861F000FF;
	Sat, 10 Oct 2026 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791659447;
	bh=Yg4STVau57RFMxif8ip3Fv5kvfpRUl+yjYtx6g84m3A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KBscKhh9j/JJla+92whP86amlQota94cZQk+fhLh9TmvUxhTzAGQOdnjmDKBWaJ/j
	 SYFsL+uQdYGpT9X7/Vq8C3Bg/ss5GWkz8sm4oNCNrFXhG17ahu+ARbwY6txge/2528
	 3+GnLVzsyX8Ya8XvM0oSYgRhtBDgouY9e+M6cCOlwCvPkm+hBw3q6+YvrM305j0tpQ
	 2TB9fz8Gaolx4Eoucw4X8t5tZsq6uWN4Kuzj+y/edJ9KVR/1PPmZp0xstIyx/FMl/5
	 zITJ0T7e5t2MDiqJeaTkPH/YOgE7DAmzot6QOFlpcwG3xsdh6bSY0Y8JKVaQLoTi2m
	 amDyAhsgFnXkA==
Subject: Re: [PATCH net 1/2] sfc: ptp: serialize host and MC synchronization
 transactions
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, bhutchings@solarflare.com,
 davem@davemloft.net, ecree.xilinx@gmail.com, edumazet@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 pabeni@redhat.com, richardcochran@gmail.com, smhodgson@solarflare.com,
 alucero@amd.com, pieter.jansen-van-vuuren@amd.com, alucerop@amd.com
Date: Sat, 10 Oct 2026 19:10:45 +0000
Message-ID: <179165944590.434549.13992833657056738261@kernel.org>
In-Reply-To: <20261009183240.1898762-2-alex.austin@amd.com>
References: <20261009183240.1898762-2-alex.austin@amd.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, ptp->host_time_pps is written by
  efx_ptp_process_times() while phc_lock is held.
- [Medium] phc_lock is created separately in each PCI function's
  efx_ptp_data: efx_ptp_probe() calls mutex_init(&ptp->phc_lock) for…
- [Medium] sfc: data race on current_adjfreq in efx_ptp_start
- [Low] The patch changes how efx_ptp_synchronize()
  (drivers/net/ethernet/sfc/ptp.c) handles a failed…
- [Low] The commit message says clock adjustments are serialized with
  phc_lock "so they cannot change the PHC during a capture".

Pre-existing issues:
- [Medium] efx_ptp_start() resets ptp->current_adjfreq = 0 (line 1457)
  without phc_lock.

--

sfc: ptp: serialize host and MC synchronization transactions

This commit adds a phc_lock mutex to struct efx_ptp_data and holds it
across the SYNCHRONIZE DMA handshake in efx_ptp_synchronize(). The PHC
adjfine, adjtime, gettime and settime callbacks are serialized with the
same mutex, and efx_phc_settime() now reads and adjusts under one lock
hold.

> Protect the DMA handshake and result processing against concurrent
> synchronization callers. Serialize clock adjustments with the same mutex
> so they cannot change the PHC during a capture.

[Severity: Low]
Is this rationale accurate for adjustments made on the same function?

efx_ptp_synchronize() acquires the MCDI interface in
efx_mcdi_rpc_start()->efx_mcdi_acquire_sync(). It only releases it at
the end of efx_mcdi_rpc_finish():

drivers/net/ethernet/sfc/mcdi.c:efx_mcdi_acquire_sync() {
	wait_event(mcdi->wq,
		   cmpxchg(&mcdi->state,
			   MCDI_STATE_QUIESCENT, MCDI_STATE_RUNNING_SYNC) ==
		   MCDI_STATE_QUIESCENT);
}

efx_phc_adjfine(), efx_phc_adjtime() and efx_phc_gettime() all go
through efx_mcdi_rpc()->_efx_mcdi_rpc()->efx_mcdi_rpc_start(). So even
before this patch, they could not send an MC command while SYNCHRONIZE
was in flight.

After rpc_finish, efx_ptp_process_times() only uses the response buffer
and nic_to_kernel_time(). It does not use current_adjfreq.

The commit message doesn't mention what the new PHC locking actually
adds:

- efx_phc_settime() now does its gettime and adjtime atomically.
- The current_adjfreq cached by efx_phc_adjfine() now stays consistent
  with the PTP_IN_ADJUST_FREQ value that _efx_phc_adjtime() sends.

Could the commit message describe these changes instead?

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index 6ca9a75af01d8..ac9951fee5ddd 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c

[ ... ]

> @@ -1027,11 +1030,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
>  	MCDI_SET_QWORD(synch_buf, PTP_IN_SYNCHRONIZE_START_ADDR,
>  		       ptp->start.dma_addr);
>  
> +	mutex_lock(&ptp->phc_lock);
> +

[Severity: Medium]
Can a per-function phc_lock protect a PHC that is shared across PCI
functions?

efx_ptp_probe() calls mutex_init(&ptp->phc_lock) for every function.
Only the primary function registers the clock with ptp_clock_register().
efx_ptp_get_ts_info() reports the primary's clock for secondaries too:

drivers/net/ethernet/sfc/ptp.c:efx_ptp_get_ts_info() {
    ...
	if (primary && primary->ptp_data && primary->ptp_data->phc_clock)
		ts_info->phc_index =
			ptp_clock_index(primary->ptp_data->phc_clock);
    ...
}

A secondary function still captures against that clock through
efx_ptp_change_mode()->efx_ptp_synchronize(). While it does so it holds
only secondary->ptp_data->phc_lock.

On the primary, efx_phc_adjtime(), efx_phc_settime() and
efx_phc_adjfine() take primary->ptp_data->phc_lock, which is a different
mutex. They send MC_CMD_PTP_OP_ADJUST over the primary's own MCDI
interface, so per-function MCDI serialization doesn't cover this case
either.

If ptp4l on the primary steps the PHC while SIOCSHWTSTAMP runs on a
secondary, could the secondary's timesets become inconsistent?

In that case efx_ptp_process_times() would return -EAGAIN. The baseline
synchronisation in efx_ptp_change_mode() would then fail, and PTP would
be stopped on that function:

			if (rc == 0) {
				rc = efx_ptp_synchronize(efx,
							 PTP_SYNC_ATTEMPTS * 2);
				if (rc != 0)
					efx_ptp_stop(efx);
			}

Whether this actually goes wrong depends on whether the MC firmware
processes the primary's ADJUST while it is servicing the secondary's
SYNCHRONIZE. That can't be confirmed from the driver.

Would a lock scoped to the clock be needed to fully cover the case the
commit message describes? One option is a lock shared through
efx->primary->ptp_data.

>  	/* Clear flag that signals MC ready */
>  	WRITE_ONCE(*start, 0);
>  	rc = efx_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
>  				MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
> -	EFX_WARN_ON_ONCE_PARANOID(rc);
> +	if (rc)
> +		goto out;

[Severity: Low]
This change looks correct, but it fixes a separate bug that the commit
message doesn't mention.

efx_mcdi_rpc_start() can fail before it calls efx_mcdi_acquire_sync().
This happens when efx_mcdi_check_supported() fails, when
mc_bist_for_other_fn is set, or when mcdi->mode is MCDI_MODE_FAIL:

drivers/net/ethernet/sfc/mcdi.c:efx_mcdi_rpc_start() {
    ...
	if (efx->mc_bist_for_other_fn)
		return -ENETDOWN;

	if (mcdi->mode == MCDI_MODE_FAIL)
		return -ENETDOWN;

	efx_mcdi_acquire_sync(mcdi);
    ...
}

Without paranoid checks, EFX_WARN_ON_ONCE_PARANOID() compiled to
nothing. The old code then busy-waited for up to MAX_SYNCHRONISE_WAIT_MS
and called efx_mcdi_rpc_finish() anyway.

That path waited for a completion that never came and called
efx_mcdi_abandon(). It then called efx_mcdi_release() on an interface
this caller had never acquired.

Could this be described in the commit message, or split into its own
patch with its own justification?

[ ... ]

> @@ -1062,11 +1068,13 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
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

[Severity: Medium]
Is ptp->host_time_pps still racy after this unlock?

efx_ptp_process_times() writes ptp->host_time_pps while phc_lock is
held. efx_ptp_pps_worker() reads it only after efx_ptp_synchronize() has
dropped the mutex:

drivers/net/ethernet/sfc/ptp.c:efx_ptp_pps_worker() {
	...
	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
		return;

	ptp_evt.type = PTP_CLOCK_PPSUSR;
	ptp_evt.pps_times = ptp->host_time_pps;
	ptp_clock_event(ptp->phc_clock, &ptp_evt);
}

A concurrent SIOCSHWTSTAMP can go through
efx_ptp_change_mode()->efx_ptp_synchronize() and overwrite host_time_pps
while the worker is copying it. The PPS event passed to
ptp_clock_event() could then carry a torn timestamp.

This race existed before this commit.

The next patch in this series, "sfc: ptp: avoid racing PPS timestamp
updates", removes host_time_pps from struct efx_ptp_data. That patch
returns the result through a caller-owned struct efx_ptp_sync_result
filled in under phc_lock, and efx_ptp_change_mode() passes NULL. The
race is gone by the end of the series.

[ ... ]

> @@ -2106,23 +2117,23 @@ static int efx_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>  	MCDI_SET_QWORD(inadj, PTP_IN_ADJUST_FREQ, adjustment_ns);
>  	MCDI_SET_DWORD(inadj, PTP_IN_ADJUST_SECONDS, 0);
>  	MCDI_SET_DWORD(inadj, PTP_IN_ADJUST_NANOSECONDS, 0);
> +	mutex_lock(&ptp_data->phc_lock);
>  	rc = efx_mcdi_rpc(efx, MC_CMD_PTP, inadj, sizeof(inadj),
>  			  NULL, 0, NULL);
> -	if (rc != 0)
> -		return rc;
> -
> -	ptp_data->current_adjfreq = adjustment_ns;
> -	return 0;
> +	if (!rc)
> +		ptp_data->current_adjfreq = adjustment_ns;
> +	mutex_unlock(&ptp_data->phc_lock);
> +	return rc;
>  }

[Severity: Medium]
efx_ptp_start() still writes ptp->current_adjfreq without taking
phc_lock:

drivers/net/ethernet/sfc/ptp.c:efx_ptp_start() {
    ...
	ptp->evt_frag_idx = 0;
	ptp->current_adjfreq = 0;
    ...
}

current_adjfreq is an s64. _efx_phc_adjtime() reads it under phc_lock
and passes it to MCDI_SET_QWORD(). That macro evaluates its value
argument twice, once for the low dword and once for the high dword.
Even on 64-bit the compiler is free to emit two separate loads. On
32-bit, the store in efx_ptp_start() is also two separate 32-bit
writes.

efx_ptp_start() is reached in two ways that don't hold phc_lock:

- SIOCSHWTSTAMP via efx_ptp_change_mode()
- efx_ptp_worker(), when reset_required is set

So a concurrent clock_adjtime() on the PHC can run _efx_phc_adjtime()
at the same moment.

Could the MC then receive a PTP_IN_ADJUST_FREQ built from the low half
of one value and the high half of another? Suppose current_adjfreq
held a small negative value. The low dword could read the new 0 while
the high dword still reads 0xffffffff. The result is a frequency
adjustment of roughly -4.3e9, which is neither the old value nor 0.
How the firmware reacts to such a value can't be determined from the
driver.

This is the same unlocked write raised above for efx_phc_adjfine(),
but the consequence here is a corrupted value rather than just a lost
one. This patch makes phc_lock the lock for current_adjfreq. Should
efx_ptp_start() also take phc_lock around the reset?

efx_ptp_start() runs in process context. It doesn't appear to be
called with phc_lock already held: efx_ptp_change_mode() calls
efx_ptp_synchronize() only after efx_ptp_start() returns. So taking
the mutex there looks straightforward.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
efx_ptp_start() still resets current_adjfreq without taking phc_lock:

drivers/net/ethernet/sfc/ptp.c:efx_ptp_start() {
    ...
	ptp->evt_frag_idx = 0;
	ptp->current_adjfreq = 0;
    ...
}

efx_ptp_start() is reached from three places:

- efx_ptp_worker(), when reset_required is set
- efx_ptp_start_datapath()->efx_ptp_restart()
- efx_ptp_change_mode()

None of them take phc_lock, so efx_ptp_start() can run alongside the
PHC clock ioctls.

Could this interleaving drop the servo's frequency correction?

efx_phc_adjfine()
  sends frequency X to the MC
  current_adjfreq = X
                              efx_ptp_start()
                                current_adjfreq = 0
efx_phc_adjtime()
  _efx_phc_adjtime()
    sends PTP_IN_ADJUST_FREQ = 0

The next adjfine would correct this, so the frequency error is
transient.

Now that phc_lock protects the other accesses to current_adjfreq,
should efx_ptp_start() take it as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009183240.1898762-1-alex.austin%40amd.com
