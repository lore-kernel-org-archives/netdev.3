Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51E47ECCC;
	Thu, 24 Sep 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250689; cv=none; b=FbLMs/WbJBzL9JnW46/stgj6wqTFnEf0/4WBd6CtlQUCuKXmu9gHZdwr79s8r9ixeMeafLRlfhIos1+O7g1D9ypVDgg6w2Y/YtO0mxenJoPz4OsbJGgnaAy7i5nB+DtbYd7C6Egv6WAI7IrN/6SlHChXGgUeGfN4W57sqURgmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250689; c=relaxed/simple;
	bh=et67JnYvGwAa/uLEFq3AR6iyvghvukNKBnQEJl6f4c8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swCRPtQUI8m2BH/8WjbcUvUDtJtK5e0Eoec5+guMwQAjE/o1F9SfZNWLi4vr3Mrwm2VJZYYHB5X50szXkZabszCK6pirGgjZqnUyeIONSxGLHIHLN2yio5t/sut0XKNpRM5yyCnVqIzncVmctlz9i3lCsZ6NUo/O86XZdHV8roM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj9GaAw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj9GaAw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4901F000FF;
	Thu, 24 Sep 2026 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250687;
	bh=C2IDqNgAx1/AET5tl6YMkN9EAjQvOdmBgh1MPVD61II=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xj9GaAw4FdAu5sdMGIE5jboEJkH7N/fyNE0wZVeS3ULlkg1LmyuElMDC0+W5OjeRK
	 C3dzr4H8MWlCySLJiksXC3GQ8/8jQe9Ts9ppiQeQin3WnOv+QEHzAJhSiV+PpZIg21
	 e/M2mJ55cyNanoBd1v/UX08dhtLwSRiDr6qbMaz1zd5RRykHUkM7h05fAWF8fSjrjx
	 axBkAgOrl+sFIFZ1NCZRSCdnbAJbCof9L0GPMfOHgIeHONXmq8FpD3GVCXaiDwfFBM
	 f/eeJDHK+vxajVZ3t1OCsIX23zHqOEtkfW0GiEZtTV1904AE9LXXB9Tp22AOtK/Q6c
	 zqB/EzIu5ZGnw==
Subject: Re: [PATCH net-next v5 06/10] net: ethernet: ravb: Replace gPTP flags
 with callbacks
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 24 Sep 2026 11:51:25 +0000
Message-ID: <179025068595.2160803.6948767428206808307@kernel.org>
In-Reply-To: <20260921175037.4084310-7-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-7-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The gPTP clock teardown in this series no longer atomically
  detaches priv->ptp.clock before disabling gPTP interrupts and…
- [Medium] The newly propagated gPTP start error creates a failure return
  in ravb_dmac_init() that happens *after* info->dmac_init() allocated…
- [Medium] Both newly created PTP failure paths leak the RX/TX rings.
- [Low] Undisclosed behavioural change: the commit message presents the
  patch as a mechanical replacement of info->gptp/info->ccc_gac by…

Pre-existing issues:
- [Low] ravb_ptp_init() requests a gPTP timer-increment load by setting
  GCCR.LTI, but then polls the unrelated GCCR.TCR field (ravb_wait(ndev,…

--

net: ethernet: ravb: Replace gPTP flags with callbacks

The two hardware-info flags describing gPTP behaviour, info->gptp (Gen2)
and info->ccc_gac (Gen3), are replaced by a new struct ravb_gptp_info with
set_config_mode/dmac_start/dmac_stop/ndev_open/ndev_close callbacks.  Each
generation's hw_info now points at one of ravb_gen2_ptp_info or
ravb_gen3_ptp_info.

A few questions below about the new error propagation and about the gPTP
teardown this series ends up with.

>     Prepare for adding Gen4 support which will add a third and new way to
>     interact with the gPTP clock by replacing the flags for Gen2 behavior
>     (info->gptp) and Gen3 behavior (info->ccc_gac) with callbacks.

[Severity: Low]
The description reads as a mechanical flag-to-callback conversion, but the
patch also changes behaviour: the ravb_ptp_init() return value, which was
deliberately discarded at both call sites before, is now propagated.

In ravb_dmac_init() the call becomes "return info->ptp->dmac_start(ndev);"
and in ravb_open() the ndev_open callback error does "goto out_ptp_stop".
Since ravb_ptp_init() returns PTR_ERR(ptp_clock_register()), a PHC
registration failure now makes "ip link set up" fail, makes "ethtool -G"
fail and aborts TX timeout recovery, where previously the interface came up
without a PHC.

Could the commit message mention that open and DMAC init now abort on a
gPTP start error?  The only mention today is the "Handle error from starting
the PTP clock" line in the post-"---" v1 to v2 changelog, which does not end
up in the git history.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index db3ef87f09912..b558e9f5611e1 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -712,8 +712,8 @@ static int ravb_dmac_init(struct net_device *ndev)
>  		return error;
>  
>  	/* Initialise PTP Clock driver */
> -	if (info->gptp)
> -		ravb_ptp_init(ndev);
> +	if (info->ptp && info->ptp->dmac_start)
> +		return info->ptp->dmac_start(ndev);
>  
>  	return 0;
>  }

[Severity: Medium]
For ravb_gen2_ptp_info (used by ravb_gen2_hw_info and ravb_rzv2m_hw_info)
dmac_start is ravb_ptp_init(), which returns PTR_ERR(ptp_clock_register()).
Are the three callers of ravb_dmac_init() prepared for a failure that
happens this late?

At this point info->dmac_init() has already allocated and formatted the
BE/NC rings, handed RX descriptors to hardware, and CCC.OPC == OPERATION has
been confirmed via CSR.OPS:

	/* Setting the control will start the AVB-DMAC process. */
	error = ravb_set_opmode(ndev, CCC_OPC_OPERATION);
	if (error)
		return error;

	/* Initialise PTP Clock driver */
	if (info->ptp && info->ptp->dmac_start)
		return info->ptp->dmac_start(ndev);

ravb_open() routes this error to out_set_reset, which skips ravb_stop_dma()
and writes CCC_OPC_RESET straight from OPERATION, a transition the driver
does not otherwise use (ravb_close() and the sibling out_ptp_stop path always
reach RESET from CONFIG via ravb_stop_dma()).  The ravb_wait() result of that
write is also dropped before pm_runtime_put_autosuspend() may suspend the
device with the DMAC still running.

ravb_tx_timeout_work() takes out_unlock, whose comment states an invariant
that no longer holds:

	error = ravb_dmac_init(ndev);
	if (error) {
		/* If ravb_dmac_init() fails, descriptors are freed. So, this
		 * should return here to avoid re-enabling the TX and RX in
		 * ravb_emac_init().
		 */
		goto out_unlock;
	}

With a gPTP start failure the descriptors are not freed and the DMAC is
running, while ravb_emac_init() and netif_tx_start_all_queues() are skipped
after ravb_rcv_snd_disable() - doesn't that leave the interface dead until an
administrative down/up?

ravb_set_ringparam() has the same shape:

		error = ravb_dmac_init(ndev);
		if (error) {
			netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n", __func__, error);
			return error;
		}

which returns after netif_device_detach() and before
ravb_emac_init()/netif_device_attach(), leaving the netdev detached with the
freshly programmed DMAC operating.

Only the Gen3/Gen4 ndev_open failure path calls ravb_stop_dma(), so the three
call sites now disagree about what a ravb_dmac_init() error means.

[ ... ]

> @@ -1967,8 +1957,11 @@ static int ravb_open(struct net_device *ndev)
>  	ravb_emac_init(ndev);
>  
>  	/* Initialise PTP Clock driver */
> -	if (info->ccc_gac)
> -		ravb_ptp_init(ndev);
> +	if (info->ptp && info->ptp->ndev_open) {
> +		error = info->ptp->ndev_open(ndev);
> +		if (error)
> +			goto out_ptp_stop;
> +	}
>  
>  	/* PHY control start */
>  	error = ravb_phy_start(ndev);
> @@ -1981,8 +1974,8 @@ static int ravb_open(struct net_device *ndev)
>  
>  out_ptp_stop:
>  	/* Stop PTP Clock driver */
> -	if (info->ccc_gac)
> -		ravb_ptp_stop(ndev);
> +	if (info->ptp && info->ptp->ndev_close)
> +		info->ptp->ndev_close(ndev);
>  	ravb_stop_dma(ndev);
>  out_set_reset:
>  	ravb_set_opmode(ndev, CCC_OPC_RESET);

[Severity: Medium]
Do the two new gPTP failure paths leak the RX/TX rings?

Neither out_ptp_stop (taken for the Gen3/Gen4 ndev_open error) nor
out_set_reset (taken for the Gen2/RZ-V2M ravb_dmac_init error) calls
ravb_ring_free(), yet ravb_dmac_init_rcar() has already run both:

	error = ravb_ring_init(ndev, RAVB_BE);
	if (error)
		return error;
	error = ravb_ring_init(ndev, RAVB_NC);

and ravb_ring_init() allocates per queue:

	priv->rx_pool[q] = page_pool_create(&params);
	...
	priv->rx_buffers[q] = kzalloc_objs(*priv->rx_buffers[q], priv->num_rx_ring[q]);
	...
	priv->tx_ring[q] = dma_alloc_coherent(ndev->dev.parent, ring_size, &priv->tx_desc_dma[q], GFP_KERNEL);

Since ndo_open returned an error, ravb_close() never runs, and ravb_remove()
does not call ravb_ring_free() either.  Wouldn't the next successful
ravb_open() overwrite priv->rx_pool[], priv->rx_buffers[], priv->tx_skb[],
priv->rx_ring[], priv->tx_ring[] and priv->tx_align[], making the previous
page pool with its mapped pages, the kzalloc'd arrays and the
dma_alloc_coherent() rings unreachable?

The same unwind gap already existed for a ravb_phy_start() failure, but this
patch adds a second, independent trigger for it.

> @@ -2663,6 +2656,26 @@ static int ravb_mdio_release(struct ravb_private *priv)
>  	return 0;
>  }
>  
> +static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
> +{
> +	int ret;
> +
> +	ret = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
> +	if (ret)
> +		return ret;
> +
> +	/* gPTP Clock Select High-speed peripheral bus clock. */
> +	ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
> +
> +	return 0;
> +}
> +
> +static const struct ravb_gptp_info ravb_gen2_ptp_info = {
> +	.set_config_mode = ravb_gen2_ptp_set_config_mode,
> +	.dmac_start = ravb_ptp_init,

[Severity: Low]
This isn't a bug introduced by this patch, and ravb_ptp.c isn't touched here,
but while looking at the new dmac_start callback: ravb_ptp_init() requests a
gPTP increment load with GCCR.LTI and then polls a different field:

	/* Request GTI loading. */
	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);

	/* Wait for GIT loading to complete by checking there are no requests. */
	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);

GCCR.LTI is the self-clearing load-request bit, as ravb_ptp_adjfine() shows:

	gccr = ravb_read(ndev, GCCR);
	if (gccr & GCCR_LTI) {
		spin_unlock_irqrestore(&priv->lock, flags);
		return -EBUSY;
	}

GCCR.TCR describes timer reset/capture requests and is normally already
GCCR_TCR_NOREQ, so the wait returns immediately, and its return value is
discarded.  Should this poll on GCCR_LTI instead?

> +	.dmac_stop = ravb_ptp_stop,
> +};

[Severity: High]
This isn't a change made by this patch either - it only wires ravb_ptp_stop()
up as a callback - but the preceding patch in this series, "net: ethernet:
ravb: Propagate error from ptp_clock_register()", removed the atomic detach
that commit 1cb9663789c5 ("net: ravb: serialize PTP clock teardown", Cc:
stable) added, and it is still gone at the end of the series.  Can the
use-after-free come back?

ravb_ptp_stop() now keeps the pointer published while the clock is torn down:

	ravb_ptp_disable(ndev);
	ravb_ptp_sync_irqs(ndev);

	if (priv->ptp.clock) {
		ptp_clock_unregister(priv->ptp.clock);
		priv->ptp.clock = NULL;
	}

whereas 1cb9663789c5 did "clock = xchg(&priv->ptp.clock, NULL);" before
ravb_ptp_disable()/ravb_ptp_sync_irqs() so later handlers were guaranteed to
observe NULL.

The IRQ side still dereferences the snapshot:

	struct ptp_clock *clock = READ_ONCE(priv->ptp.clock);
	u32 gis = ravb_read(ndev, GIS);

	gis &= ravb_read(ndev, GIC);
	if ((gis & GIS_PTCF) && clock) {
		...
		ptp_clock_event(clock, &event);

Is the GIC = 0 write enough on its own?  A PTP_EXTTS_REQUEST or
PTP_PEROUT_REQUEST ioctl is still serviceable until posix_clock_unregister()
takes clk->rwsem, and ravb_ptp_extts()/ravb_ptp_perout() re-set
GIC_PTCE/GIC_PTME:

CPU0 ravb_close() or the ravb_open() error path
  ravb_ptp_stop()
    ravb_ptp_disable()      /* GIC = 0 */
    ravb_ptp_sync_irqs()
    ptp_clock_unregister(priv->ptp.clock)   /* pointer still published */

CPU1 ioctl on /dev/ptpN
  ravb_ptp_enable()
    ravb_modify(ndev, GIC, GIC_PTCE, GIC_PTCE)
  gPTP capture IRQ -> ravb_ptp_interrupt() reads the non-NULL pointer
    ptp_clock_event(clock, &event)

The same commit also dropped priv->ptp.phc_index, which 1f77af0aaf27 added,
and ravb_get_ts_info() dereferences priv->ptp.clock directly again.  Was that
revert intentional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921175037.4084310-1-niklas.soderlund%2Brenesas%40ragnatech.se
