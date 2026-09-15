Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447E3D3488;
	Tue, 15 Sep 2026 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437287; cv=none; b=be9ASX3itBUlWy8ipNkGwjQLGlWcqqGRgow7eCumobh93fylcAY5Jm8ZvuQCav6dAMXDhwBFWphl1gIVluCH1YpFKlNSNo5Q9R6b/Hra52s9et++fyluznnpZTV0PTskyC+5YkwzP6uiuv+xsk1zZfnSQbeCdUyuffR/USxhbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437287; c=relaxed/simple;
	bh=hC5oMkcbHF153VYm7GIbTzw2rrFEsSFIRHM1CEHOU6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIhgEfKQ0ubVK+zwKT1tNARI9GQIKyduGZku5lNR3D+ATx7CbU27engmN7XysuR+ZRIJZydAl1JYMj6xrZkVKmDKbkbye1DEzJ/tn4G1coQtb4ALzkVpvye1HgCv3pgBKeX9ShWi4p4+H2wa435zrTNQ+jD/jkq3A+8wFIBONKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg9CLUgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg9CLUgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEC81F000FF;
	Tue, 15 Sep 2026 01:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437285;
	bh=7pALTNLNO+z28d53BfjackFdh1fuzWK4dPm4RdJyF6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jg9CLUgrXC6QcEI6d3CkIve6e/loql7p2uMdgKHskOZe5l/7dMHyPBr8Fqq+slyvj
	 dtLbQnIgJkbPNfzOyKuhW3NMHrZ2g7FeYp4MM4plNIDEFnPtrNAz/7KT53qtlPgS3j
	 4CbR59Xl2sA8qe7ciTGB/pegGMGlaSqDSk24BpYPG1UR73P/pFss6tmm1X7sdLxi9Q
	 gW9qWzKnUb5lq47FpMXLeFkEIS+Q9uuJdFb7wK9gKvB5wNFQHggK000/yC3wLYXX2x
	 Kx7/hiJzjc8yyP7KxsFrirUgs4+yE6rmMGr0uw5dOQrgq4rKSSHW5DYlYT8Pxyusos
	 X0eYiwV9ndQQg==
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
Subject: Re: [PATCH net-next v4 10/10] net: ethernet: ravb: Add gPTP support for Gen4
Date: Mon, 14 Sep 2026 18:54:44 -0700
Message-ID: <20260915015444.881349-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-11-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-11-niklas.soderlund+renesas@ragnatech.se>
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
net: ethernet: ravb: Add gPTP support for Gen4

This patch gives R-Car Gen4 its own ravb_gptp_info, resolving a system-wide
gPTP timer through a new optional ptp-timer phandle instead of the
non-existing internal gPTP clock, and selects that timer as the timestamp
source in APSR. The node reference is released in ravb_remove().

No Link: tags are present in the commit header.

A few questions below, both on the commit message and on the new code.

[Severity: Low]

The commit message says:

  "While driver advertises gPTP support on Gen4 platforms it is in fact
  completely broken."

That describes a user-visible defect in existing kernels: before this
series ravb_gen4_hw_info had .ccc_gac = 1, ravb_get_ts_info() advertised
so_timestamping and phc_index for those devices, and ravb_open() called
ravb_ptp_init(), so every board matching renesas,etheravb-rcar-gen4
exposes a /dev/ptpN for hardware the commit message says does not exist.

Should this carry a Fixes: tag pointing at 949f252a8594 ("net: ravb: Add
R-Car Gen4 support")?

Since the change depends on the ten-patch gPTP refactor in this series and
on a new DT property, it is presumably not backportable on its own - could
the commit message state that explicitly for the stable maintainers?

Also, small typo in the commit message: "optional.If not present" is
missing a space after the period.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 8617c30dbb14e..c8aa40136c3da 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2755,6 +2755,57 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
>  	.magic_pkt = 1,
>  };
>  
> +static int ravb_gen4_ptp_probe(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +
> +	priv->of_gptp = of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);

[Severity: Medium]

Does this leak the of_gptp device_node reference on probe failure?

of_parse_phandle() returns the node with an incremented reference count,
and ravb_probe() calls this callback early:

drivers/net/ethernet/renesas/ravb_main.c:ravb_probe() {
	...
	if (info->ptp && info->ptp->probe) {
		error = info->ptp->probe(ndev);
		if (error)
			goto out_reset_assert;
	}

	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
	...
}

Every later failure (devm_clk_get_optional(), pm_runtime_resume_and_get(),
devm_platform_get_and_ioremap_resource(), of_get_phy_mode(),
dma_alloc_coherent(), ravb_set_opmode(), ravb_mdio_init(),
register_netdev()) ends up in out_reset_assert / out_free_netdev, which do:

	reset_control_assert(rstc);
	free_netdev(ndev);

free_netdev() destroys the priv that held the only pointer to the node, so
the reference is lost. devm_clk_get_optional() can return -EPROBE_DEFER, so
this can repeat on every retry. Would an extra unwind label, or
devm_add_action_or_reset(), keep the acquisition symmetric?

> +	if (!priv->of_gptp)
> +		return 0;
> +
> +	if (!of_device_is_available(priv->of_gptp)) {
> +		of_node_put(priv->of_gptp);
> +		priv->of_gptp = NULL;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]

This resolves the timer purely from the phandle plus of_device_is_available(),
with no dependency on the driver that actually owns and clocks the shared
gPTP counter (rswitch on S4, rtsn on V4H).

ravb_gen4_ptp_probe() cannot fail and prints nothing, so a dangling
phandle, an unbound or deferred provider, and a genuinely absent ptp-timer
all look identical from user space: ethtool -T simply reports no PHC. Would
a dev_warn() (or -EPROBE_DEFER / a device link) help here?

There is also no check that the shared counter is running before the
timestamp source is switched over in ravb_gen4_ptp_set_config_mode():

	/* Set PTP source to GPTP module, only option on Gen4. */
	if (priv->of_gptp)
		ravb_modify(ndev, APSR, APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK,
			    APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK);

The provider can stop that counter at any time while RAVB is up -
rtsn_remove() and rswitch_deinit() call rcar_gen4_ptp_unregister(), which
does:

drivers/net/ethernet/renesas/rcar_gen4_ptp.c:rcar_gen4_ptp_unregister() {
	iowrite32(1, ptp_priv->addr + PTPTMDC_REG);
	return ptp_clock_unregister(ptp_priv->clock);
}

Is the resulting cross-driver load-order and unbind dependency intentional?
It is not mentioned in the commit message.

> +
> +static int ravb_gen4_ptp_clock_index(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +
> +	/* If no clock, mimic ptp_clock_index_by_of_node() fail and return -1 */
> +	if (!priv->of_gptp)
> +		return -1;
> +
> +	return ptp_clock_index_by_of_node(priv->of_gptp);
> +}

[Severity: High]

Can this lookup ever succeed against an in-tree provider?

ptp_clock_index_by_of_node() matches on the parent device of the registered
clock:

drivers/ptp/ptp_clock.c:ptp_clock_of_node_match() {
	return (dev->parent && dev_of_node(dev->parent) == parent_np);
}

But the only in-tree registrar of the R-Car Gen4 system gPTP timer passes a
NULL parent:

drivers/net/ethernet/renesas/rcar_gen4_ptp.c:rcar_gen4_ptp_register() {
	...
	ptp_priv->clock = ptp_clock_register(&ptp_priv->info, NULL);
	...
}

and ptp_clock_register() stores that as ptp->dev.parent. With parent NULL
the predicate is false for every np, class_find_device() returns NULL, and
the helper returns -1 even for a valid and enabled ptp-timer phandle.

ravb_get_ts_info() only fills anything in when index >= 0:

drivers/net/ethernet/renesas/ravb_main.c:ravb_get_ts_info() {
	...
	/* Only advertise ptp clock if present. */
	if (index >= 0) {
	...
}

So does Gen4 end up never advertising gPTP at all, leaving the feature this
patch adds inert unless rswitch/rtsn are changed to pass the owning device
to ptp_clock_register()?

> +
> +static int ravb_gen4_ptp_set_config_mode(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +	int ret;
> +
> +	/* Enable gPTP Clock and Select High-speed peripheral bus clock. */
> +	ret = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
> +	if (ret)
> +		return ret;
> +
> +	/* Set PTP source to GPTP module, only option on Gen4. */
> +	if (priv->of_gptp)
> +		ravb_modify(ndev, APSR, APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK,
> +			    APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK);
> +
> +	return 0;
> +}
> +
> +static const struct ravb_gptp_info ravb_gen4_ptp_info = {
> +	.probe = ravb_gen4_ptp_probe,
> +	.clock_index = ravb_gen4_ptp_clock_index,
> +	.set_config_mode = ravb_gen4_ptp_set_config_mode,
> +};
> +

[Severity: Medium]

For Gen4 without an available ptp-timer (the newly optional case), do the
two halves of the timestamping uAPI now disagree?

ravb_get_ts_info() reports nothing, because clock_index() returns -1, so
so_timestamping, tx_types, rx_filters stay zero and phc_index keeps the
caller's -1.

ravb_hwtstamp_set() still accepts the request and returns success:

drivers/net/ethernet/renesas/ravb_main.c:ravb_hwtstamp_set() {
	...
	priv->tstamp_tx_ctrl = tstamp_tx_ctrl;
	priv->tstamp_rx_ctrl = tstamp_rx_ctrl;

	return 0;
}

net_hwtstamp_validate() only range-checks the enums, so HWTSTAMP_TX_ON and
HWTSTAMP_FILTER_ALL are accepted here.

The datapath then keys off info->ptp, which is always non-NULL for Gen4
now:

drivers/net/ethernet/renesas/ravb_main.c:ravb_start_xmit() {
	...
	/* TX timestamp required */
	if (info->ptp) {
		if (q == RAVB_NC) {
	...
}

drivers/net/ethernet/renesas/ravb_main.c:ravb_rx_rcar_hwstamp() {
	if (q == RAVB_NC)
		get_ts = priv->tstamp_rx_ctrl != HWTSTAMP_FILTER_NONE;
	...
}

Should these gates use the same "is a gPTP clock available" predicate as
ravb_get_ts_info(), so user space cannot enable timestamping the driver
declares unsupported and get TFA/descriptor values from a counter the
commit message says Gen4 does not have?

>  static const struct ravb_hw_info ravb_gen4_hw_info = {
>  	.receive = ravb_rx_rcar,
>  	.set_rate = ravb_set_rate_rcar,
> @@ -2777,7 +2828,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
>  	.tx_counters = 1,
>  	.multi_irqs = 1,
>  	.irq_en_dis = 1,
> -	.ptp = &ravb_gen3_ptp_info,
> +	.ptp = &ravb_gen4_ptp_info,
>  	.nc_queues = 1,
>  	.magic_pkt = 1,
>  };
> @@ -3191,6 +3242,7 @@ static void ravb_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(dev);
>  	clk_unprepare(priv->refclk);
> +	of_node_put(priv->of_gptp);
>  	reset_control_assert(priv->rstc);
>  	free_netdev(ndev);
>  	platform_set_drvdata(pdev, NULL);

[Severity: Medium]

Is the of_gptp node also leaked on the early return at the top of
ravb_remove()?

drivers/net/ethernet/renesas/ravb_main.c:ravb_remove() {
	error = pm_runtime_resume_and_get(dev);
	if (error < 0)
		return;
	...
	of_node_put(priv->of_gptp);
	...
}

The new of_node_put() sits below that return, so an unbind where runtime
resume fails drops out without releasing the reference.

Two more observations about the gPTP stop paths introduced earlier in this
series, in commit "net: ethernet: ravb: Simplify gPTP start and stop",
which this patch builds on:

[Severity: High]

On Gen3, does a PHY start failure in ravb_open() leave the PTP clock
registered?

ravb_open() registers the clock and then, on ravb_phy_start() failure,
goes to out_ptp_stop:

drivers/net/ethernet/renesas/ravb_main.c:ravb_open() {
	...
	/* Initialise PTP Clock driver */
	if (info->ptp && info->ptp->ndev_open) {
		error = info->ptp->ndev_open(ndev);
		...
	}

	/* PHY control start */
	error = ravb_phy_start(ndev);
	if (error)
		goto out_ptp_stop;
	...
out_ptp_stop:
	ravb_stop_dma(ndev);
	...
}

ravb_stop_dma() only calls dmac_stop:

drivers/net/ethernet/renesas/ravb_main.c:ravb_stop_dma() {
	...
	/* Stop PTP Clock driver */
	if (info->ptp && info->ptp->dmac_stop)
		info->ptp->dmac_stop(ndev);
	...
}

but ravb_gen3_ptp_info puts ravb_ptp_stop() in .ndev_close, not
.dmac_stop:

static const struct ravb_gptp_info ravb_gen3_ptp_info = {
	.probe = ravb_gen2_ptp_probe,
	.clock_index = ravb_gen2_ptp_clock_index,
	.set_config_mode = ravb_gen3_ptp_set_config_mode,
	.ndev_open = ravb_ptp_init,
	.ndev_close = ravb_ptp_stop,
};

so ptp_clock_unregister() is never reached. Since ndo_open failed, ndo_stop
(and .ndev_close) will not run either. A later successful open calls
ravb_ptp_init() again and overwrites priv->ptp.clock, and ravb_remove()
eventually calls free_netdev() while the leaked clock still points at the
embedded priv->ptp.info - can that turn into a use-after-free on a
subsequent /dev/ptpN or /sys/class/ptp/ptpN access?

The earlier commit claims no functional change, but the code it removed
from out_ptp_stop covered the ccc_gac case too:

	if (info->gptp || info->ccc_gac)
		ravb_ptp_stop(ndev);

[Severity: Medium]

Related question for Gen2 and RZ/V2M, where ravb_ptp_stop() is reached only
via dmac_stop at the end of ravb_stop_dma(): the function has three earlier
error returns before that point.

drivers/net/ethernet/renesas/ravb_main.c:ravb_stop_dma() {
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
	...
}

ravb_close() only logs the failure and keeps going:

	if (ravb_stop_dma(ndev) < 0)
		netdev_err(ndev,
			   "device will be stopped after h/w processes are done.\n");

Before the refactor, ravb_close() called ravb_ptp_stop() unconditionally
ahead of the fallible ravb_stop_dma(). Does the clock now stay registered
after the interface goes down when a wait times out, with the next open
overwriting priv->ptp.clock?
