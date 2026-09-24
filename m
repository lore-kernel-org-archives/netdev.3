Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705647D452;
	Thu, 24 Sep 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250686; cv=none; b=ItlnS88XU+8QyqgYjdLQ6wdwuiwRMjBeCTqP2w2KDyC4TsdAyBkSyjkvvrPrM80PiVPqva0Lhc6xuFGk7WURdkghRZvTH8MW9mpsmDsAE0lA15E6+nXLSdQFlteIhNWdE3C7YYSof2/UKbIvz93JuU4iKsQ188fn9TjQ+lkLf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250686; c=relaxed/simple;
	bh=b27hqvmSTgTOeaRw8EiBS/e6j7dmt1SJ7cHIfrAFNTE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsUMsG+C2fU9TwvSFDbEs0X3Wr/1F88MvVuCqDddEUgw3S/BEnUa3F/sUmBN5I2KgRiyRRq/M+mPxpss/JQMKcenPiICS/oj3DtOHRBlHIiqAtlOczZSnZ+6+Kjl6IEgCvTf/Oy8/nrIe7/iFivR483gfTvuicftudercco78/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHR5mNKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHR5mNKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFFF1F000FF;
	Thu, 24 Sep 2026 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250684;
	bh=40AZS3LeASraEiuyYN1eO0jNo10r5tnT55mkD4+vpzM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iHR5mNKTA5R0/XTIFQA0wrF3gJkriXS4zTB8e8X/t5+Ma+8uFgw8wQ3Jz9haj55qh
	 gQpi+nJF8BDcfKe18GLionowmRJTzfEkkKy49ULcejyNU6VwjavwsLJamQjnHGae3G
	 Bux5Csc+LLkdR4gBK8OSd8DyWWnus/DJLSJE61CeVDJ288GbN1ER5FtnIE6F2JyBDT
	 jEtMpqhoHkCv2EBQIGA+tC5JJUy1x6d/xIfbcjlwiOEyHV87lkk3+nHRN8S1qVu/IB
	 oKcyaGPgOtR6TcW4sYPbupGgW8jwS0MdlPGgXO/Ee6TofFgvHJzFlEm8zDarhFH2AN
	 sWPZNHtE6azNQ==
Subject: Re: [PATCH net-next v5 03/10] net: ethernet: ravb: Simplify gPTP
 start and stop
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 24 Sep 2026 11:51:22 +0000
Message-ID: <179025068248.2160803.17842254520494656595@kernel.org>
In-Reply-To: <20260921175037.4084310-4-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-4-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Error-path bypass: for `info->gptp` devices (Gen2
  `ravb_gen2_hw_info`, RZ/V2M `ravb_rzv2m_hw_info`) the gPTP clock is…
- [Medium] Asymmetric gPTP start/stop in `ravb_tx_timeout_work()`:
  `ravb_stop_dma()` now performs the gptp `ravb_ptp_stop()` at…
- [Medium] Loss of IRQ quiescence before the unlocked timestamp-list
  teardown in `ravb_close()` for `info->gptp` devices.

--

net: ethernet: ravb: Simplify gPTP start and stop

This folds the gptp-flag gPTP clock registration into ravb_dmac_init() and
the unregistration into ravb_stop_dma(), and drops the info->gptp checks
from the ravb_open()/ravb_close() call sites so only info->ccc_gac devices
are handled there. A few questions below about the error paths that are now
reached differently.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index a89f6fe7866fe..42d208e6b8ecd 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -707,7 +707,15 @@ static int ravb_dmac_init(struct net_device *ndev)
>  		return error;
>  
>  	/* Setting the control will start the AVB-DMAC process. */
> -	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
> +	error = ravb_set_opmode(ndev, CCC_OPC_OPERATION);
> +	if (error)
> +		return error;
> +
> +	/* Initialise PTP Clock driver */
> +	if (info->gptp)
> +		ravb_ptp_init(ndev, priv->pdev);
> +
> +	return 0;
>  }
>  
>  static void ravb_get_tx_tstamp(struct net_device *ndev)
> @@ -1115,6 +1123,10 @@ static int ravb_stop_dma(struct net_device *ndev)
>  			netdev_err(ndev, "failed to stop AXI BUS\n");
>  	}
>  
> +	/* Stop PTP Clock driver */
> +	if (info->gptp)
> +		ravb_ptp_stop(ndev);
> +
>  	/* Stop AVB-DMAC process */
>  	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
>  }

[Severity: High]
The registration side in ravb_dmac_init() is unconditional once the DMAC
started, but the new unregistration sits after the three fallible waits in
ravb_stop_dma():

	error = ravb_wait(ndev, TCCR, info->tccr_mask, 0);
	if (error)
		return error;

	error = ravb_wait(ndev, CSR, CSR_TPO0 | CSR_TPO1 | CSR_TPO2 | CSR_TPO3, 0);
	if (error)
		return error;
	...
	error = ravb_wait(ndev, CSR, CSR_RPO, 0);
	if (error)
		return error;
	...
	/* Stop PTP Clock driver */
	if (info->gptp)
		ravb_ptp_stop(ndev);

Can the gPTP clock stay registered when any of those waits returns
-ETIMEDOUT?  Both callers tolerate that failure:  ravb_close() only logs
"device will be stopped after h/w processes are done." and then continues to
ravb_set_opmode(ndev, CCC_OPC_RESET) and pm_runtime_put_autosuspend(), and
the out_ptp_stop path of ravb_open() discards the ravb_stop_dma() return
value entirely.

If so, does /dev/ptpN survive on a block that has been put into
CCC_OPC_RESET with its clocks runtime suspended, so PHC ioctls do MMIO on a
gated block?

Also, does a subsequent open leak the first ptp_clock?  ravb_ptp_init()
ends with:

	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
	...
	WRITE_ONCE(priv->ptp.clock, clock);

so the stale pointer is overwritten without unregistering, and
ravb_ptp_stop() only consumes the current pointer via xchg().

And since ravb_remove() has no ravb_ptp_stop() fallback:

	reset_control_assert(priv->rstc);
	free_netdev(ndev);

does a still-registered clock then keep a pointer to &priv->ptp.info inside
the freed ravb_private, reachable from userspace through the surviving PHC
device?

Would doing the gptp ravb_ptp_stop() before the fallible wait sequence, or
keeping the explicit teardown in the callers, preserve the previous
ordering?

The commit message says:

    Fold the gptp-flag start and stop calls into ravb_dmac_init() and
    ravb_stop_dma(), which start and stop the AVB-DMAC. There are no
    functional change as all call sites [...]

Given the error-path difference above, could that "no functional change"
claim be qualified?

This also appears to persist to the end of the series: at 02206b03 the call
is "if (info->ptp && info->ptp->dmac_stop) info->ptp->dmac_stop(ndev);"
still after the same early returns, Gen2/RZ-V2M provide only
.dmac_start/.dmac_stop with no .ndev_close, and ravb_remove() still ends in
free_netdev() with no PTP fallback.

[ ... ]

> @@ -1975,7 +1981,7 @@ static int ravb_open(struct net_device *ndev)
>  
>  out_ptp_stop:
>  	/* Stop PTP Clock driver */
> -	if (info->gptp || info->ccc_gac)
> +	if (info->ccc_gac)
>  		ravb_ptp_stop(ndev);
>  	ravb_stop_dma(ndev);
>  out_set_reset:

> @@ -2020,10 +2026,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
>  
>  	netif_tx_stop_all_queues(ndev);
>  
> -	/* Stop PTP Clock driver */
> -	if (info->gptp)
> -		ravb_ptp_stop(ndev);
> -
>  	/* Wait for DMA stopping */
>  	if (ravb_stop_dma(ndev)) {
>  		/* If ravb_stop_dma() fails, the hardware is still operating
> @@ -2056,10 +2058,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
>  	ravb_emac_init(ndev);
>  
>  out:
> -	/* Initialise PTP Clock driver */
> -	if (info->gptp)
> -		ravb_ptp_init(ndev, priv->pdev);
> -
>  	netif_tx_start_all_queues(ndev);
>  
>  out_unlock:

[Severity: Medium]
In ravb_tx_timeout_work(), can the gptp clock end up stopped with nothing
restarting it?

ravb_stop_dma() now does the gptp ravb_ptp_stop() immediately before its
last fallible step:

	/* Stop PTP Clock driver */
	if (info->gptp)
		ravb_ptp_stop(ndev);

	/* Stop AVB-DMAC process */
	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);

and ravb_set_opmode() can return -ETIMEDOUT from
ravb_wait(ndev, CSR, CSR_OPS, csr_ops).  In that case
ravb_tx_timeout_work() takes:

	if (ravb_stop_dma(ndev)) {
		...
		ravb_rcv_snd_enable(ndev);
		goto out;
	}

which skips ravb_dmac_init(), the only remaining place that re-registers the
PHC for gptp devices, and the removed ravb_ptp_init() at out: no longer
compensates.  Does the interface then resume TX/RX with priv->ptp.clock ==
NULL and phc_index == -1, while ravb_start_xmit() still requests TX
timestamps under "if (info->gptp || info->ccc_gac)"?

The commit message states:

    are always just after a call to into ravb_dmac_init()

Is that true for the out: label, which is also reached from the
ravb_stop_dma() failure branch where ravb_dmac_init() never runs?

At 02206b03 the ordering in ravb_stop_dma() and the contents of the out:
label look unchanged, so this appears to carry through the series.

> @@ -2374,7 +2372,7 @@ static int ravb_close(struct net_device *ndev)
>  	}
>  
>  	/* Stop PTP Clock driver */
> -	if (info->gptp || info->ccc_gac)
> +	if (info->ccc_gac)
>  		ravb_ptp_stop(ndev);
>  
>  	/* Set the config mode to stop the AVB-DMAC's processes */

[Severity: Medium]
For info->gptp devices this also removes the unconditional IRQ drain that
used to run before the timestamp list is cleared.  ravb_ptp_stop() ends
with:

	ravb_ptp_disable(ndev);
	ravb_ptp_sync_irqs(ndev);

where ravb_ptp_sync_irqs() does synchronize_irq(ndev->irq) plus the err and
mgmt IRQs when info->err_mgmt_irqs (RZ/V2M).  After this patch that drain
happens only inside ravb_stop_dma(), i.e. after its early -ETIMEDOUT
returns, while ravb_close() continues regardless:

	/* Set the config mode to stop the AVB-DMAC's processes */
	if (ravb_stop_dma(ndev) < 0)
		netdev_err(ndev,
			   "device will be stopped after h/w processes are done.\n");

	/* Clear the timestamp list */
	if (info->gptp || info->ccc_gac) {
		list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
			list_del(&ts_skb->list);
			kfree_skb(ts_skb->skb);
			kfree(ts_skb);
		}
	}

That loop runs without priv->lock, and ravb_get_tx_tstamp(), called from
hardirq context via ravb_timestamp_interrupt() in ravb_interrupt() and
ravb_multi_interrupt(), walks and frees entries of the same list:

	list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
		...
		list_del(&ts_skb->list);
		kfree(ts_skb);

Can a handler still in flight (or entered because the error summary source
is not masked by close) double free a ravb_tstamp_skb here?  The window for
a newly arriving interrupt existed before this patch; what changes is that
the in-flight drain no longer runs unconditionally for gptp devices.  Would
taking priv->lock around the ts_skb_list teardown be the more robust fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921175037.4084310-1-niklas.soderlund%2Brenesas%40ragnatech.se
