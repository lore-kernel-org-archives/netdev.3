Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1823E6DF7;
	Mon,  7 Sep 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749314; cv=none; b=dY9PRe6/hmGW00oN/KMCuqBYmiTShegdHnR9/4Oe4GJMGMHinPuiopcT97lNrzy4IZ0q2ZqT1m1G4uM/bU6sx2I6Os7mdlQ5Isr/3w5E8f+Zrce+s3Mix/UUBrMhsOBfUyEGveyL4GIyEEkDhZ5PYkDm8+1XFcu4L2VdkRew2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749314; c=relaxed/simple;
	bh=8WNIpdWRexDbK7vRrFMY44cRCxAxmYVnn5/tmVcDQA4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9kk471EavIKh2oNkqEMrzSBPd9lmzeN6JvJ9rmTb9xAZvFyAOu410qwrN7nxL0ncQlTkJ6YEtpnfpATuL4vvyjRiDhAoI78/giRqwTtCSYxWKtzUMTB+KfxnXYX01dDO5/CrT1IlXDlXWIYWdaK6dIHB8h7rZtyJ0wVgXpLrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kta9dEhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kta9dEhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDBE1F00A3A;
	Mon,  7 Sep 2026 02:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749313;
	bh=M2CM6t5n607eXYzMmEmt1Ivm49OVAv9hSL0ovMsh4kk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kta9dEhEjio2QknfBjCQnyQG4FmNCxgKr7t5qc2pqquIw/66p0QfUTT39bsCB0LYV
	 qbEM0cGkBaD0jbnPC4T/7leNg7Gxfy2ZRB7RQkVzzowMD1Wwx5iFdvU4aErr43YrZC
	 6zuuWkA/E8G/MVt7vgpXmg+IRVEU29RwKYZrW0KpGrV/hpANYe4j4sooiQ811BOyMa
	 9bMgRP1D7IRe0QSRryQjN7LSQJTLIayJh6CaTsZT0ljdi5gKnOWg4zelkPThIeSGmq
	 g/SR7dYCh6B9cZJDPh/WTtIu9JuxvhsobOaFgSZQu4a35NpUlP9hIZ70oLCaquF2iO
	 kWb/2XwXew6Vg==
Subject: Re: [PATCH net-next v3 03/10] net: ethernet: ravb: Simplify gPTP
 start and stop
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:31 +0000
Message-ID: <178874931163.219967.10631528994436956442@kernel.org>
In-Reply-To: <20260902084703.3228504-4-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-4-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 0 · Low: 0

- [High] ravb_open() leaks the registered PTP clock for info->ccc_gac
  devices (R-Car Gen3/Gen4) when ravb_phy_start() fails.
- [High] Folding ravb_ptp_stop() into the tail of ravb_stop_dma()
  (ravb_main.c:1126-1128) makes gPTP teardown conditional on the AVB-…

--

net: ethernet: ravb: Simplify gPTP start and stop

This moves the info->gptp gPTP clock start and stop into ravb_dmac_init()
and ravb_stop_dma() so the gPTP clock follows the AVB-DMAC, and drops the
info->gptp part of the combined "gptp || ccc_gac" conditions in
ravb_open() and ravb_close().  The commit message states "There are no
functional change".  Two behaviour differences below look like they may
not hold up.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index a89f6fe7866fe..2d0022a4f85c3 100644
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

[Severity: High]

Is the gPTP stop still guaranteed to run for info->gptp parts?  Placing it
here puts it behind the three ravb_wait() timeouts earlier in
ravb_stop_dma():

	error = ravb_wait(ndev, TCCR, info->tccr_mask, 0);
	if (error)
		return error;

	error = ravb_wait(ndev, CSR, CSR_TPO0 | CSR_TPO1 | CSR_TPO2 | CSR_TPO3,
			  0);
	if (error)
		return error;
	...
	error = ravb_wait(ndev, CSR, CSR_RPO, 0);
	if (error)
		return error;

Before this patch every caller ran the stop unconditionally before
ravb_stop_dma(), so a wedged DMAC could not skip it.  Now ravb_close()
only logs the failure and keeps going:

	if (ravb_stop_dma(ndev) < 0)
		netdev_err(ndev,
			   "device will be stopped after h/w processes are done.\n");

so on a .gptp = 1 part (ravb_gen2_hw_info, ravb_rzv2m_hw_info) the PHC
stays registered across close.  A later open then goes
ravb_open() -> ravb_dmac_init() -> ravb_ptp_init(), which registers a
second clock and overwrites the pointer without checking:

	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
	...
	WRITE_ONCE(priv->ptp.clock, clock);

Does that permanently orphan the first registration?  ravb_remove() does
no PTP teardown before free_netdev(), and the orphaned clock's
ptp_clock_info lives in the netdev private area, so its ops would point
at freed memory after unbind.

Skipping ravb_ptp_stop() on those early returns also skips the interrupt
quiescing it performs:

	ravb_ptp_disable(ndev);
	ravb_ptp_sync_irqs(ndev);

ravb_close() then walks and frees priv->ts_skb_list without priv->lock,
while ravb_timestamp_interrupt() -> ravb_get_tx_tstamp() can still be
doing list_del() on the same list.  Can that corrupt the list?

There is also the reverse ordering.  If ravb_stop_dma() fails only in its
final ravb_set_opmode(ndev, CCC_OPC_CONFIG), the ravb_ptp_stop() above has
already unregistered the clock, and ravb_tx_timeout_work() takes the
"goto out" path whose ravb_ptp_init() is removed by this patch (hunk
below), leaving a running interface with no PHC until an administrative
down/up.  Same question for ravb_set_ringparam(): its

		error = ravb_stop_dma(ndev);
		if (error) {
			netdev_err(ndev,
				   "cannot set ringparam! Any AVB processes are still running?\n");
			return error;
		}

now returns with the gPTP clock still registered where previously it had
been stopped first.

>  	/* Stop AVB-DMAC process */
>  	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
>  }
> @@ -1719,9 +1731,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
>  
>  	if (netif_running(ndev)) {
>  		netif_device_detach(ndev);
> -		/* Stop PTP Clock driver */
> -		if (info->gptp)
> -			ravb_ptp_stop(ndev);
> +
>  		/* Wait for DMA stopping */
>  		error = ravb_stop_dma(ndev);
>  		if (error) {

[ ... ]

> @@ -1961,7 +1967,7 @@ static int ravb_open(struct net_device *ndev)
>  	ravb_emac_init(ndev);
>  
>  	/* Initialise PTP Clock driver */
> -	if (info->gptp || info->ccc_gac)
> +	if (info->ccc_gac)
>  		ravb_ptp_init(ndev, priv->pdev);
>  
>  	/* PHY control start */
> @@ -1974,9 +1980,6 @@ static int ravb_open(struct net_device *ndev)
>  	return 0;
>  
>  out_ptp_stop:
> -	/* Stop PTP Clock driver */
> -	if (info->gptp || info->ccc_gac)
> -		ravb_ptp_stop(ndev);
>  	ravb_stop_dma(ndev);

[Severity: High]

Does this leak the registered PTP clock for info->ccc_gac parts?

ravb_open() still registers it just above:

	if (info->ccc_gac)
		ravb_ptp_init(ndev, priv->pdev);

and the next fallible step is ravb_phy_start(), which jumps here.  The
replacement stop folded into ravb_stop_dma() is gated on info->gptp, and
that flag is mutually exclusive with ccc_gac (ravb_gen2_hw_info and
ravb_rzv2m_hw_info set .gptp = 1, ravb_gen3_hw_info and ravb_gen4_hw_info
set .ccc_gac = 1), so nothing unregisters the clock on this path.

ravb_close() is the only remaining ccc_gac ravb_ptp_stop() site, and it is
not reached because ndo_open returned an error.  The device is then put in
CCC_OPC_RESET and runtime suspended while /dev/ptpN stays alive with
ptp_clock_info pointing into the netdev private area.  Each further
"ip link set ethX up" attempt registers another clock and orphans the
previous one via the WRITE_ONCE(priv->ptp.clock, clock) in
ravb_ptp_init(), and ravb_remove() frees the netdev without unregistering
anything.

>  out_set_reset:
>  	ravb_set_opmode(ndev, CCC_OPC_RESET);

[ ... ]

> @@ -2020,10 +2023,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
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

[ ... ]

> @@ -2056,10 +2055,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
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
> @@ -2374,7 +2369,7 @@ static int ravb_close(struct net_device *ndev)
>  	}
>  
>  	/* Stop PTP Clock driver */
> -	if (info->gptp || info->ccc_gac)
> +	if (info->ccc_gac)
>  		ravb_ptp_stop(ndev);
>  
>  	/* Set the config mode to stop the AVB-DMAC's processes */

Both concerns come down to the same question: since ravb_stop_dma() can
return early, and its callers treat that failure differently, is the
folded start/stop still symmetric on every exit path, or would performing
the stop before the ravb_wait() loops (or leaving it at the call sites)
keep the previous behaviour?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
