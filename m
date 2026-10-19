Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F224E50DE;
	Mon, 19 Oct 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411122; cv=none; b=KeBGnNVYEPekdCNJimxbroHS9qAWg+APOTGPIFtI4s8fqB6wHQzBHIngA93dNUqByC29IfToEKp39Sp9h5wk0pq7aw9XDVRq61cbhX5wMY6WXa4u+NLSxWAU/wTgw+wZ7Wh1q2OxvD9LfNXwYrigufnmboA4Z18Kaitv0tn/PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411122; c=relaxed/simple;
	bh=tpHEVwr5zi3cs6emQM/4XPpanYTAxTUpFrtREz6XgQA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOyyL0lwZJE4Ft/MBYjn2fAbFaTZ3zLZ2sF9zTlX0/ZcVk01tX5J0lwVhlRndpZcTmJmi13w1pedkCuY6KsPRuJv7MMAhhiE3SURTXILbVHQLEWdSPDygcs3EQ0uqKX7s44tiE1oZxVBb6L6O76F7WMIltodT7P+kJMZdHPk/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6i4hxcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6i4hxcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06611F000C5;
	Mon, 19 Oct 2026 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411121;
	bh=mBQRezzvWOaxmu6e2fGLCSHm5PK5c8WKYX6473SGzCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j6i4hxcgR2q8/kpXiQGOOIEQisz8dy2aTGUN5Rwgc/D/Oz5EPy9EeAD8tAdg+67HM
	 GfiYoi0ciS1UZoMSgwpUJeUqqNc4nQ9nHtXwNf/17EYhkUJbtFQEgv7bQs5UL5GlWw
	 BIbP2kpb1sC3LcenDWDDcc8MLKYoEhOHbGAqK/K6IwqMuXiQpkZU1Pl9O+Wh20hvKG
	 NudFlwNC+9ZMuNUluQOG2PxfP0B83RTApx4sgev49aEInBHvzgVPvQjZhqud9hf0+T
	 l/BVzK3CNRDEbep4Ew8RyLhSGN6ybubHVVM7Qh3VXH/V0ScO16AfxXcPzyQzo3t+81
	 xZeeNliiAWcWw==
Subject: Re: [PATCH net v2 2/2] sfc: ptp: avoid racing PPS timestamp updates
From: netdev-bot+sashiko@kernel.org
To: alex.austin@amd.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:58:40 +0000
Message-ID: <179241112030.3135.17575594097702232193@kernel.org>
In-Reply-To: <20261015114104.2531624-3-alex.austin@amd.com>
References: <20261015114104.2531624-3-alex.austin@amd.com>
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

- [Medium] The fix only covers drivers/net/ethernet/sfc/ptp.c.

--

sfc: ptp: avoid racing PPS timestamp updates

This commit removes the shared host_time_pps field from efx_ptp_data.
efx_ptp_process_times() now writes the PPS timestamp into storage that
the caller provides. efx_ptp_pps_worker() passes a stack-local
pps_event_time, and efx_ptp_change_mode() passes NULL.

> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index c2f8b94592718..116b38079d8e6 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c

[ ... ]

> @@ -1504,14 +1508,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
>  {
>  	struct efx_ptp_data *ptp =
>  		container_of(work, struct efx_ptp_data, pps_work);
> +	struct pps_event_time host_time_pps = {};
>  	struct efx_nic *efx = ptp->efx;
>  	struct ptp_clock_event ptp_evt;
>  
> -	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
> +	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS, &host_time_pps))
>  		return;
>  
>  	ptp_evt.type = PTP_CLOCK_PPSUSR;
> -	ptp_evt.pps_times = ptp->host_time_pps;
> +	ptp_evt.pps_times = host_time_pps;
>  	ptp_clock_event(ptp->phc_clock, &ptp_evt);
>  }

[Severity: Medium]
Should the same change also go into drivers/net/ethernet/sfc/siena/ptp.c?

That file was split off from the code that commit 7c236c43b838 added,
and it still has the shared field. In the Siena copy of
efx_ptp_process_times():

	ptp->host_time_pps = *last_time;
	pps_sub_ts(&ptp->host_time_pps, delta);

The Siena efx_ptp_pps_worker() then copies it after synchronize returns:

	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
		return;

	ptp_evt.type = PTP_CLOCK_PPSUSR;
	ptp_evt.pps_times = ptp->host_time_pps;

Meanwhile, the timestamping config path can still rewrite that field:

siena_ptp_set_ts_config()
  efx_siena_ptp_change_mode()
    efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS * 2)
      efx_ptp_process_times()

This is the same partially updated PPS timestamp race that the commit
message describes for efx_ptp_pps_worker() and change_mode.

The Siena efx_ptp_synchronize() also takes no driver lock around the
transaction, while the sfc version holds phc_lock. Only the MCDI request
itself is serialized. Two concurrent synchronizations could therefore
overlap on these:

	WRITE_ONCE(*start, 0) on the shared DMA start flag
	the ptp->timeset[] writes in efx_ptp_process_times()
	the sync stats counters

Since the patch carries the same Fixes tag, stable kernels that have the
Siena split would get this fix only for sfc. Could Siena get the same
treatment, meaning a caller-owned pps_event_time, NULL from
efx_siena_ptp_change_mode(), and serialization of efx_ptp_synchronize()?
If Siena is left out on purpose, could the commit message say so?

> @@ -1847,7 +1852,8 @@ int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
>  				rc = efx_ptp_start(efx);
>  			if (rc == 0) {
>  				rc = efx_ptp_synchronize(efx,
> -							 PTP_SYNC_ATTEMPTS * 2);
> +							 PTP_SYNC_ATTEMPTS * 2,
> +							 NULL);
>  				if (rc != 0)
>  					efx_ptp_stop(efx);
>  			}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015114104.2531624-1-alex.austin%40amd.com
