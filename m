Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D13CF1F8;
	Tue, 15 Sep 2026 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437283; cv=none; b=bd+UXDONvjsdXiBSqsNuBQNFaVRjlvcSgof1giLArvR2XgqeHrH1lImj2UObiwiy2IVj3tGdexcQzn9FLl4sSVKsX+TXAZ6iKdvpmk/Mdw0q/j9wy1IVWZ+VL6VINWhnWyu3/so1hvVD8i7tZLPMXxa9kAnwq7NOd3vVuU1bg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437283; c=relaxed/simple;
	bh=guq27DQV+XQhQpuU+aj1hUeDlwrh+ICG/zqLYQJ4RDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/W3wLJMb6p92mv57NLIcJSf16StAK2KzoJimJq7c+cJJQDgqFGbRFPD0zuODQuEWiB6cOwEfnSAdt0OI0o7MjytWTbCEEuzgKnt/+xvo/MqpIBLBTk+yy1M683RxhzghxQ40H5tsA8fOP1ueu7Z2Kl2bx06OPYuhrIzbcXDILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWt4bRW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWt4bRW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B61F000FF;
	Tue, 15 Sep 2026 01:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437281;
	bh=xUG5YGa0uHPBHARxLMNh6SWTGhBBRupwiEERjOmN+mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWt4bRW1K1bPhbykN/1TIJ0YbtuU9/jUhMOCTwLAqGffqYBJRV0UAEve4KcNYS8Qa
	 LAkQXfgq51HWcdwwJIvoBUkh9upy2MIgp+vD+TSgYjKVU7Gh4qYbgcbYp01E6bb1lW
	 Dlh5Sh0F04YGRxCgNymFyUspoXdBZ4EVXH6Pb5hv0GANYc/1/63eeuZVe2HKVlFtJ+
	 rUySAub7WxUfSVz4iTs5rRFNJKX2kuhCjBfIc1McZHjJWvmwVKkFPsN8fINPXo/9dV
	 hMJVqe8l7N8r/41xxLxAermMqTFznzo0Wc5kGzts5BQpcOdZv6vZskRXri+gXvbYfQ
	 +H+hwDVLW/djA==
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
Subject: Re: [PATCH net-next v4 06/10] net: ethernet: ravb: Replace gPTP flags with callbacks
Date: Mon, 14 Sep 2026 18:54:40 -0700
Message-ID: <20260915015440.881226-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-7-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-7-niklas.soderlund+renesas@ragnatech.se>
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
net: ethernet: ravb: Replace gPTP flags with callbacks

This replaces the info->gptp and info->ccc_gac hardware feature flags with
a new struct ravb_gptp_info callback table hanging off struct ravb_hw_info.
Gen2 and RZ/V2M get ravb_gen2_ptp_info (dmac_start/dmac_stop), Gen3 and Gen4
get ravb_gen3_ptp_info (ndev_open/ndev_close).

A few questions on the conversion below.

> net: ethernet: ravb: Replace gPTP flags with callbacks
>
> Prepare for adding Gen4 support which will add a third and new way to
> interact with the gPTP clock by replacing the flags for Gen2 behavior
> (info->gptp) and Gen3 behavior (info->ccc_gac) with callbacks.

[Severity: Low]
The message describes this as replacing flags with callbacks, but the patch
also changes error semantics.  Before this change both call sites discarded
the return value:

	if (info->gptp)
		ravb_ptp_init(ndev);        /* ravb_dmac_init() */

	if (info->ccc_gac)
		ravb_ptp_init(ndev);        /* ravb_open() */

After this change the value is returned from ravb_dmac_init() and acted on
in ravb_open() with a goto out_ptp_stop.  So a ptp_clock_register() failure
in ravb_ptp_init() that previously only cost hardware timestamping now makes
bringing the interface up fail on every generation.

The only mention is the "Handle error from starting the PTP clock" note
below the --- marker, which does not end up in git history.  Could the
commit message say that error handling behaviour changes too?

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 0c122a8158409..6603f90b19e15 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1034,6 +1034,27 @@ struct ravb_ptp {
>  	struct ravb_ptp_perout perout[N_PER_OUT];
>  };
>  
> +/**
> + * struct ravb_gptp_info - Platform specific gPTP behavior
> + *
> + * Each generation of RAVB have slightly different behaviors when interacting
> + * with the gPTP clock. This struct provides the callbacks to be called at
> + * critical points in the RAVB driver.
> + *
> + * @set_config_mode:	Enter config mode
> + * @dmac_start:		Called when the DMAC starts
> + * @dmac_stop:		Called when the DMAC stops
> + * @ndev_open:		Called when the ndev is opened
> + * @ndev_close:		Called when the ndev is closed
> + */
> +struct ravb_gptp_info {
> +	int (*set_config_mode)(struct net_device *ndev);
> +	int (*dmac_start)(struct net_device *ndev);
> +	void (*dmac_stop)(struct net_device *ndev);
> +	int (*ndev_open)(struct net_device *ndev);
> +	void (*ndev_close)(struct net_device *ndev);
> +};
> +

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 5ba322593a014..9e9b1c4fbe956 100644
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
Should ravb_dmac_init() unwind the DMAC start when dmac_start() fails?

The new return is reached after the block already entered
CCC_OPC_OPERATION and after info->dmac_init() allocated and armed the
descriptor rings:

	/* Setting the control will start the AVB-DMAC process. */
	error = ravb_set_opmode(ndev, CCC_OPC_OPERATION);
	if (error)
		return error;

	/* Initialise PTP Clock driver */
	if (info->ptp && info->ptp->dmac_start)
		return info->ptp->dmac_start(ndev);

For Gen2 and RZ/V2M dmac_start is ravb_ptp_init(), which can fail on a
plain software condition when ptp_clock_register() returns an ERR_PTR.
Previously every ravb_dmac_init() failure returned with the block still in
CONFIG mode, and its three callers were written for that.

ravb_tx_timeout_work() documents the old invariant explicitly:

	error = ravb_dmac_init(ndev);
	if (error) {
		/* If ravb_dmac_init() fails, descriptors are freed. So, this
		 * should return here to avoid re-enabling the TX and RX in
		 * ravb_emac_init().
		 */
		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
			   __func__, error);
		goto out_unlock;
	}

With the new failure mode the descriptors are armed and the DMAC is left in
OPERATION mode, while ravb_emac_init() is skipped and the TX queues stay
stopped.  ravb_set_ringparam() has the same shape and returns with
netif_device_detach() still in effect.  In ravb_open() the error goes to
out_set_reset, which skips ravb_stop_dma() entirely.

Would it be simpler to start the gPTP clock before the switch to
CCC_OPC_OPERATION, so a failure still leaves the block in CONFIG mode?

> @@ -1124,8 +1124,8 @@ static int ravb_stop_dma(struct net_device *ndev)
>  	}
>  
>  	/* Stop PTP Clock driver */
> -	if (info->gptp)
> -		ravb_ptp_stop(ndev);
> +	if (info->ptp && info->ptp->dmac_stop)
> +		info->ptp->dmac_stop(ndev);
>  
>  	/* Stop AVB-DMAC process */
>  	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);

[Severity: Critical]
This dispatch is the only PTP teardown reachable from the
ravb_open() error path, and .dmac_stop is NULL in
ravb_gen3_ptp_info, so on Gen3 and Gen4 nothing is stopped here.

The registration for those two generations happens in the new
info->ptp->ndev_open() call in ravb_open(), which is ravb_ptp_init().
If ravb_phy_start() fails right after it, control goes to
out_ptp_stop, which calls ravb_stop_dma(), which reaches this hunk
and finds no .dmac_stop callback. ravb_ptp_stop() is therefore never
called, priv->ptp.clock stays populated, and the ptp_clock plus its
chardev stay registered while ravb_open() goes on to put the block
into CCC_OPC_RESET and runtime suspend the device. Before this
series the label itself did the pairing unconditionally for both
flags, so this path was covered.

The part that worries me most is what happens afterwards. Since
ndo_open failed the interface never came up, so ravb_close() is not
called on unbind either: unregister_netdev() has nothing to stop and
ravb_remove() proceeds to free_netdev(), freeing the ravb_private
area. The leaked ptp_clock still holds priv->ptp.info, which points
into that freed allocation, and it remains reachable from userspace
through /dev/ptpN, so the adjfine/gettime/settime callbacks then run
on freed memory (and would do ravb_read()/ravb_write() MMIO on a
device in RESET even before the free). A userspace loop that keeps
retrying open on a board where PHY connect fails also re-runs
ravb_ptp_init() each time and overwrites priv->ptp.clock, leaking a
registration per attempt.

Where do you want the fix? Calling info->ptp->ndev_close() from the
out_ptp_stop label looks like the smallest change and restores the
old pairing, but having ravb_stop_dma() fall back to ndev_close when
dmac_stop is absent would also work if you would rather keep the
teardown in one place. If it ends up at the label, the label name
finally matches what it does again.

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

[Severity: High]
Can this leak the registered ptp_clock on Gen3 and Gen4 when
ravb_phy_start() fails?

ndev_open is ravb_ptp_init() for ravb_gen3_ptp_info, so the clock is
registered here.  If ravb_phy_start() then fails, for example when
ravb_phy_init() cannot connect the PHY and returns -ENOENT, control reaches:

ravb_open() {
	...
out_ptp_stop:
	ravb_stop_dma(ndev);
out_set_reset:
	ravb_set_opmode(ndev, CCC_OPC_RESET);
out_rpm_put:
	pm_runtime_put_autosuspend(dev);
	...
}

but ravb_stop_dma() only dispatches dmac_stop:

	/* Stop PTP Clock driver */
	if (info->ptp && info->ptp->dmac_stop)
		info->ptp->dmac_stop(ndev);

and ravb_gen3_ptp_info leaves .dmac_stop NULL, so ravb_ptp_stop() never
runs.  priv->ptp.clock stays set and the ptp_clock plus its chardev stay
registered while the device is put into CCC_OPC_RESET and runtime
suspended.

Three follow-on effects:

- userspace can still call the ptp_clock_info callbacks, which do
  ravb_read()/ravb_write()/ravb_wait() MMIO on a device in RESET and
  possibly clock gated.

- each retried open re-runs ravb_ptp_init() and overwrites
  priv->ptp.clock, leaking the previous registration.

- ndo_stop never ran, so ravb_close() does not clean up either, and
  ravb_remove() does unregister_netdev() followed by free_netdev() with
  no ravb_ptp_stop() anywhere in ravb_main.c outside the two callback
  tables.  The leaked ptp_clock keeps a priv->ptp.info pointer into the
  freed netdev private area, reachable through /dev/ptpN.

Gen2 and RZ/V2M are not affected since their teardown is dmac_stop, which
ravb_stop_dma() does call.

The label name out_ptp_stop is also now misleading for the Gen3/Gen4
callback set, since nothing stops PTP there.  Would calling
info->ptp->ndev_close() on this path, or wiring ndev_close into the error
label, be the intent?

For reference, the baseline before this series had the pairing at the
label:

	if (info->gptp || info->ccc_gac)
		ravb_ptp_stop(ndev);

[ ... ]

> @@ -2678,12 +2691,24 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
>  			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
>  	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
>  	.dbat_entry_num = 22,
> +	.ptp = &ravb_gen2_ptp_info,
>  	.aligned_tx = 1,
> -	.gptp = 1,
>  	.nc_queues = 1,
>  	.magic_pkt = 1,
>  };
>  
> +static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
> +{
> +	/* Enable gPTP Clock and Select High-speed peripheral bus clock. */
> +	return ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
> +}
> +
> +static const struct ravb_gptp_info ravb_gen3_ptp_info = {
> +	.set_config_mode = ravb_gen3_ptp_set_config_mode,
> +	.ndev_open = ravb_ptp_init,
> +	.ndev_close = ravb_ptp_stop,
> +};

This is the table with no .dmac_stop referenced in the ravb_open() comment
above, and it is shared by both ravb_gen3_hw_info and ravb_gen4_hw_info:

> @@ -2733,7 +2758,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
>  	.tx_counters = 1,
>  	.multi_irqs = 1,
>  	.irq_en_dis = 1,
> -	.ccc_gac = 1,
> +	.ptp = &ravb_gen3_ptp_info,
>  	.nc_queues = 1,
>  	.magic_pkt = 1,
>  };

[ ... ]
