Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB114B405E;
	Sat, 10 Oct 2026 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659450; cv=none; b=o1vzufUdlLV5d92YBz+Z9mPf/VQgAnjreg5ZlYvde1EqW8v+GaDIJ6EzjKedcCmVY3yT14H8KK41wE2Fc2DPnY0niHnKj8c5fmdG9gPd9L+b0fprvCTzbr0exf+t0b9KZRYFAJqPV1GNXgejIzG3dExezqdtACdtuZzdafbAJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659450; c=relaxed/simple;
	bh=WqKq3/IcrYMSEUaGps9jVmezFTk/Mk9m7vKwDCQpAts=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGDuLwOHFFWmwmokR8+JRv9AI64ZHB27iDXVOheIeyBuCUfe6xkZqUpQVODblgCQEEVkh9ld0vgci4rHUy4gdolDbFxuICEb6NBlCYDqw2i74F95dW+G7felINCUocOdoZ0i6NqKpG8onUC+iV4+E7d1qY8bfuXJ3xlzWGK5lIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKDZ0ntX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKDZ0ntX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263E61F00893;
	Sat, 10 Oct 2026 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791659449;
	bh=pwcAo7dHSCw8nV9+0txmx3BX+wsRNt71MBoq9JyGCtw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fKDZ0ntXNmYEY5osq3GCI09sE4Tlci8NNOZ8S4AetYpFNFp1Fg7vMP1v/zygUYh7C
	 lnC9dtF4ai7P1hUBtHMAmJnxYSTR5EnTJ0A+7qOd374QT3nOUFAjlBD7BV/pq5IsOm
	 KpOoyWUE/6SWHlQrcNx6rT9s86VJt3xIa2aveFTKgr2/OhxDX9NX+YeXsgGU8ylUmT
	 tSMrWHK3p3EmGrPVlCMRMjczFb/8TL9aAtieCZpJ9c1AytYDSElDqFYqjxcKxK9DsL
	 WziJerZWc0DP0j9b5pSLK4Bb0mdphE2ZWgBIAYt784peeVW57czB6nfFGC5Akqd7JP
	 jY29EprJycnzQ==
Subject: Re: [PATCH net 2/2] sfc: ptp: avoid racing PPS timestamp updates
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, bhutchings@solarflare.com,
 davem@davemloft.net, ecree.xilinx@gmail.com, edumazet@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 pabeni@redhat.com, richardcochran@gmail.com, smhodgson@solarflare.com,
 alucero@amd.com, pieter.jansen-van-vuuren@amd.com, alucerop@amd.com
Date: Sat, 10 Oct 2026 19:10:47 +0000
Message-ID: <179165944766.434549.14678251542382712038@kernel.org>
In-Reply-To: <20261009183240.1898762-3-alex.austin@amd.com>
References: <20261009183240.1898762-3-alex.austin@amd.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Siena PTP driver still has the PPS timestamp race that
  this patch fixes in sfc.

Pre-existing issues:
- [Low] The comment above efx_ptp_process_times() in
  drivers/net/ethernet/sfc/ptp.c (lines 909-916) says the function will…

--

sfc: ptp: avoid racing PPS timestamp updates

This patch removes the shared host_time_pps field from struct
efx_ptp_data in the sfc driver. The computed PPS timestamp is now returned
through a caller-owned struct efx_ptp_sync_result. efx_ptp_pps_worker()
uses a stack-local result, and efx_ptp_change_mode() passes NULL.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index ac9951fee5ddd..103df1f8fa92d 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c

[ ... ]

> @@ -911,7 +917,8 @@ static void efx_ptp_read_timeset(MCDI_DECLARE_STRUCT_PTR(data),
>  static int
>  efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
>  		      size_t response_length,
> -		      const struct pps_event_time *last_time)
> +		      const struct pps_event_time *last_time,
> +		      struct efx_ptp_sync_result *result)
>  {

[Severity: Low]
This isn't a bug introduced by this patch, but the comment above
efx_ptp_process_times() doesn't match what the function does:

 * Extract times from returned results, and establish the minimum value
 * seen.  The minimum value represents the "best" possible time and events
 * too much greater than this are rejected - the machine is, perhaps, too
 * busy.

The loop never computes an observed minimum. It checks each reading
against SYNCHRONISATION_GRANULARITY_NS, MAX_SYNCHRONISATION_NS and
ptp->min_synchronisation_ns, and every reading that passes updates
last_good:

		} else if (corrected < ptp->min_synchronisation_ns) {
			++ptp->undersize_sync_windows;
		} else {
			ngood++;
			last_good = i;
		}

When several readings pass, the function uses the last one, not the one
with the smallest window.

Could the comment be updated to describe the fixed thresholds and the
last-good selection?

[ ... ]

> @@ -1494,14 +1506,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
>  {
>  	struct efx_ptp_data *ptp =
>  		container_of(work, struct efx_ptp_data, pps_work);
> +	struct efx_ptp_sync_result result = {};
>  	struct efx_nic *efx = ptp->efx;
>  	struct ptp_clock_event ptp_evt;
>  
> -	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
> +	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS, &result))
>  		return;
>  
>  	ptp_evt.type = PTP_CLOCK_PPSUSR;
> -	ptp_evt.pps_times = ptp->host_time_pps;
> +	ptp_evt.pps_times = result.host_time_pps;
>  	ptp_clock_event(ptp->phc_clock, &ptp_evt);
>  }

[Severity: Medium]
Does the Siena driver still have the same race?

drivers/net/ethernet/sfc/siena/ptp.c is a near copy of this file. It still
keeps host_time_pps as a shared field in its struct efx_ptp_data.

Its efx_ptp_process_times() writes that field on every successful
synchronization:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_process_times() {
    ...
	/* Set PPS timestamp to match NIC top of second */
	ptp->host_time_pps = *last_time;
	pps_sub_ts(&ptp->host_time_pps, delta);
    ...
}

Its efx_ptp_pps_worker() copies the field after the synchronization
returns:

drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_pps_worker() {
    ...
	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
		return;

	ptp_evt.type = PTP_CLOCK_PPSUSR;
	ptp_evt.pps_times = ptp->host_time_pps;
    ...
}

The SIOCSHWTSTAMP path can rewrite the field at the same time:

efx_siena_ptp_change_mode()
    efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS * 2)
        efx_ptp_process_times()
            ptp->host_time_pps = *last_time;

The Siena efx_ptp_synchronize() also takes no lock, because siena/ptp.c
has no phc_lock. So Siena has neither the serialization from "sfc: ptp:
serialize host and MC synchronization transactions" nor the caller-owned
result added here. Concurrent synchronizations can overwrite ptp->timeset[]
and host_time_pps while the worker reads them.

Both copies come from the Fixes: commit 7c236c43b838, and the commit
message does not mention Siena.

Should siena/ptp.c get the same fix, either in this patch or as a
follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009183240.1898762-1-alex.austin%40amd.com
