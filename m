Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD33CCFB2;
	Tue, 15 Sep 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437280; cv=none; b=iZmm1CBIb0HH0JiG0fRR8sVrs+kXSLeE+pWxDszwB6TaCDVeLobwtYENLIJeJ5AFK6tqn6Iw8aLShHrmOTv2qdPiecHUo8QC3puhHJ0+IJi+EbpDnEqw9M44LmXo++Gz9leAt+XriVTyLFI/oi6tx3rrDXdctHHBP2QtTdKeGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437280; c=relaxed/simple;
	bh=qt5kRLVnZOtxO3649HqxOIW//GqZBseExKsaQ707m4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpT/wnolnj3CtnVVRpziAifLlsb4+8BVPKmAwyDEiaPNIO9porPORkMFsgUU2DX5GgbMR9ENW1KATPzRQt6pM0ubU9+Up2W1Va6rXkgur3A14xBbIgnoWCdn9+EzwWeSNAcFIF/o6/fmbUtTC/i9trXDIqLyi1sqxIYiz5Gkl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovVYjpll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovVYjpll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8F41F000FF;
	Tue, 15 Sep 2026 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437278;
	bh=AqwsyU29526fvesGZLKUh8Kmvb0hHOaznOAvSuxJROI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ovVYjplllZ6LE6mEJuwHi7vJfolppUInJkZd7JJupzVSvYQotbg57dJ2ROISj3rPf
	 xsKAvfou11G1W8+NiozwyieqZuLOGSUZ0uMhZo+3sM3ZI5nQaXyTHjStsmAGRUzdBZ
	 QZboyZKYjc+ULnukkTc9PoikcaUSWl7SmIenN7fkRj3HIZSKrNifRhKBAN39DIF6li
	 SvypPu62UUoUtB4QiNnMpdwz0pvk5Gk/2nhvoCsh2QMVbO6x6oJRxxLHXBzqZdE4Vj
	 nYeF/fQcAuQgYj1Nh60psTOXT3X2nszMGY0/YeCwDT6t1H5u+rbAZ2CmNW6E312egE
	 PMuZK+TcY/OQA==
From: Jakub Kicinski <kuba@kernel.org>
To: niklas.soderlund+renesas@ragnatech.se
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@pbarker.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] net: ethernet: ravb: Simplify gPTP start and stop
Date: Mon, 14 Sep 2026 18:54:37 -0700
Message-ID: <20260915015437.881154-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-4-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-4-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: ravb: Simplify gPTP start and stop

The patch folds the gptp-flag ravb_ptp_init() and ravb_ptp_stop() calls into
ravb_dmac_init() and ravb_stop_dma(), and drops the info->gptp part of the
two combined gptp/ccc_gac call sites in ravb_open() and ravb_close().  It is
described as having no functional change.

A few questions about the resulting start/stop balance below.

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
Is the new stop reachable on all exits from ravb_stop_dma()?  It sits after
three unconditional error returns earlier in the same function:

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

Before this patch, ravb_close(), ravb_set_ringparam(),
ravb_tx_timeout_work() and ravb_open()'s unwind all called ravb_ptp_stop()
unconditionally before ravb_stop_dma(), so a wait timeout did not affect the
unregister.

ravb_close() treats a ravb_stop_dma() failure as non-fatal:

	/* Set the config mode to stop the AVB-DMAC's processes */
	if (ravb_stop_dma(ndev) < 0)
		netdev_err(ndev,
			   "device will be stopped after h/w processes are done.\n");

and then goes on to free the rings, program CCC_OPC_RESET and drop the
runtime-PM reference.  For .gptp devices (ravb_gen2_hw_info,
ravb_rzv2m_hw_info) does that leave the PHC registered after ndo_stop has
returned success, with the gPTP interrupt enables still set because
ravb_ptp_disable()/ravb_ptp_sync_irqs() in ravb_ptp_stop() were skipped?

A subsequent open then runs ravb_dmac_init() -> ravb_ptp_init(), whose

	WRITE_ONCE(priv->ptp.clock, clock);

overwrites the only handle, while ravb_ptp_stop() only xchg()s the current
pointer.  Since ravb_remove() has no independent PTP unregister and ends in
free_netdev(), does the stranded registration leave ptp_clock_info pointing
into freed netdev private memory, reachable through the surviving
/dev/ptpN?

ravb_ptp_stop() looks idempotent (xchg of priv->ptp.clock), so would doing
the stop before the fallible ravb_wait() calls, or on all exit paths, keep
the old behaviour?

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

[Severity: High]
Same question for this call site: with the explicit pre-stop removed, does a
ravb_stop_dma() timeout here return with the interface detached and the Gen2
gPTP clock still registered?

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
>  out_set_reset:
>  	ravb_set_opmode(ndev, CCC_OPC_RESET);

[Severity: High]
Does this leak the registered PTP clock for info->ccc_gac devices when
ravb_open() fails?

ravb_open() still calls ravb_ptp_init() for info->ccc_gac, but the
counterpart at out_ptp_stop: is gone, and the relocated teardown in
ravb_stop_dma() is gated on:

	if (info->gptp)
		ravb_ptp_stop(ndev);

info->gptp and info->ccc_gac are mutually exclusive (.gptp in
ravb_gen2_hw_info and ravb_rzv2m_hw_info, .ccc_gac in ravb_gen3_hw_info and
ravb_gen4_hw_info), so nothing unregisters the clock on this path.

The failure right after the init is a plain software path, ravb_phy_start()
-> ravb_phy_init() returns -ENOENT when of_phy_connect() fails, or
propagates an of_phy_register_fixed_link() error:

	error = ravb_phy_init(ndev);
	if (error)
		return error;

Since ndo_open failed, ndo_stop/ravb_close() is never called, so the
if (info->ccc_gac) ravb_ptp_stop(ndev); in ravb_close() does not run either.
Does that leave /dev/ptpN live on a block that ravb_open() then puts into
CCC_OPC_RESET and runtime-suspends, so gettime64/settime64/adjfine perform
MMIO with no runtime-PM reference held, and with GIC/GIS enables still set?

And on a later successful open, ravb_ptp_init()'s
WRITE_ONCE(priv->ptp.clock, clock) replaces the handle, so the first
registration can no longer be reached by ravb_ptp_stop().  With
ravb_remove() calling free_netdev() without any PHC unregister, does that
become a use-after-free through the surviving PTP chardev?

Would keeping if (info->ccc_gac) ravb_ptp_stop(ndev); at out_ptp_stop:
restore the balance?

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

[Severity: Medium]
Can TX-timeout recovery now resume traffic with the Gen2 gPTP clock left
unregistered?

In ravb_stop_dma() the new stop runs just before the fallible final
transition:

	/* Stop PTP Clock driver */
	if (info->gptp)
		ravb_ptp_stop(ndev);

	/* Stop AVB-DMAC process */
	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);

If that ravb_set_opmode() times out, ravb_tx_timeout_work() takes the
"hardware is still operating" branch:

	if (ravb_stop_dma(ndev)) {
		...
		ravb_rcv_snd_enable(ndev);
		goto out;
	}
	...
out:
	netif_tx_start_all_queues(ndev);

With the ravb_ptp_init() at out: removed, RX/TX and the TX queues are
re-enabled for .gptp devices while the PHC has been unregistered and the
gPTP interrupts cleared.  Previously this path always re-registered the
clock when resuming operation.  Does hardware timestamping and /dev/ptpN
now stay gone until a full close/open cycle?

[ ... ]
