Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B243ED3BA;
	Mon,  7 Sep 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749331; cv=none; b=Du+QnDRY3bRbOxq+4L4afx9KYMRiWPiFNJDchoajymt9rzLAb8U7ZpEcqTO1YXsYFubvW1RiW58um7TSvwTV/PTeglb+ffp+jdLxx1Apv0oW7oiG44tyjDa13CdXQq/hlfRamhxkDo/ykSgCsTmcF2FKHe67DYb7j8Xu3c3trgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749331; c=relaxed/simple;
	bh=qd8wTf69bqNUf2206ZsrJ2ddQ7ZSL4Lf5EBgFGMPUYU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lGJCt7Su5z0+Q2+PLbhGIVarp6/0OGRcUBP7JREdMuQSnLCSC5ZOlkX82PcOxcAQGkwt45ozwvuctL9P5V8gtdXzIj1ahY0IiCQULKRfn/MOXnXNY+LWbEvsUnYqyf8nqc1MXJDGM+bLXGa0JOhQyfGCg6sTP1vrnp5u1qM5aME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrY6yRM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrY6yRM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D069D1F00A3F;
	Mon,  7 Sep 2026 02:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749322;
	bh=Y6NlQ9JusTpLDNGyzD3xRgNiViYCNyF85W/bKDxSzBk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KrY6yRM3i/Cqc1C54HxoZAjNNbO93lO6EBGonK7DQrkkO1Sb9fo7/ExBA28f1RZfl
	 Q1Ql2sjRwACvvOP48GY+YNXLpf/dc+r2MBNqbIYcGb5GM6QXQfoNq1f4QbaOOFBTlx
	 iNmMwmVVBKC8FpxoysqHI4JjQUZjsTfEfb+F66mTY4ADv9BXKRiS/A5pKWmXW1C350
	 0IzyG5HcrIAlVRCRPQIJcU/vX317O2itj6h5lT8GRqLOTgQEdl7d/i+GgLJwZTeRor
	 HABm19NTb+Ghw8ed9MOYeYH5Ke+uapLqjJxPJf/LqLRo9J43oFAiOxHdzyT1qXNnTm
	 5WTNZyk8NVWwQ==
Subject:
 Re: [PATCH net-next v3 10/10] net: ethernet: ravb: Add gPTP support for Gen4
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:41 +0000
Message-ID: <178874932136.219967.5958447401602527499@kernel.org>
In-Reply-To: <20260902084703.3228504-11-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-11-niklas.soderlund+renesas@ragnatech.se>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] The new Gen4 gPTP support can never resolve a PHC index, so the
  feature is inert.
- [Medium] Gen4 hardware-timestamping gating is incomplete: only
  ravb_get_ts_info() consults the new clock_index callback, while every…
- [Medium] OF node reference leak on all probe failure paths.
- [Low] The commit fixes a user-visible defect — it states "While driver
  advertises gPTP support on Gen4 platforms it is in fact completely…

--

net: ethernet: ravb: Add gPTP support for Gen4

This adds a Gen4-specific ravb_gptp_info that resolves a system-wide gPTP
timer through a new optional "ptp-timer" phandle, points the Gen4 hardware
info at it instead of the Gen3 one, and only advertises gPTP to user space
when the referenced timer node is present and enabled.

A few questions below.

> While driver advertises gPTP support on Gen4 platforms it is in fact
> completely broken.

[Severity: Low]
Since this changes user-visible behaviour on Gen4 (ravb_get_ts_info() no
longer reports so_timestamping/tx_types/rx_filters/phc_index there), should
the commit carry a Fixes: tag so the affected range is clear for stable
backports?

One note on attribution: 6e0713cc8206 ("ravb: Add MII support for R-Car
V4M") only split ravb_gen4_hw_info out of ravb_gen3_hw_info, copying
.ccc_gac = 1 along with it, so the bogus gPTP advertisement on Gen4 is
older than that commit.  The tag would instead point at the commit that
first bound the "renesas,etheravb-rcar-gen4" compatible to the Gen3
(ccc_gac) hardware description.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 402370e1be63..66c9cd15a19e 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2752,6 +2752,57 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
>  	.magic_pkt = 1,
>  };
>  
> +static int ravb_gen4_ptp_probe(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +
> +	priv->of_gptp = of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);
> +	if (!priv->of_gptp)
> +		return 0;

[Severity: Medium]
Does this leak the "ptp-timer" device_node when probe fails later on?

of_parse_phandle() returns the node with an incremented reference count,
and ravb_probe() calls info->ptp->probe() early:

	if (info->ptp && info->ptp->probe) {
		error = info->ptp->probe(ndev);
		if (error)
			goto out_reset_assert;
	}

Everything after that can still fail: devm_clk_get_optional() for refclk,
pm_runtime_resume_and_get(), devm_platform_get_and_ioremap_resource(),
of_get_phy_mode(), the descriptor BAT dma_alloc_coherent(),
ravb_set_opmode(), ravb_mdio_init() and register_netdev().  The unwind
labels out_napi_del, out_mdio_release, out_reset_mode, out_rpm_put,
out_rpm_disable, out_reset_assert and out_free_netdev release napi, mdio,
the opmode, the BAT, runtime PM, refclk, the reset control and the netdev,
but none of them calls of_node_put(priv->of_gptp), and free_netdev(ndev) at
out_free_netdev then destroys priv.

The only put added here is in ravb_remove(), which is never reached on a
failed probe.  ravb_remove() also returns early:

	error = pm_runtime_resume_and_get(dev);
	if (error < 0)
		return;

so the reference is skipped on that path too.  With EPROBE_DEFER retry
cycles this accumulates one node reference per attempt.

> +
> +	if (!of_device_is_available(priv->of_gptp)) {
> +		of_node_put(priv->of_gptp);
> +		priv->of_gptp = NULL;
> +	}
> +
> +	return 0;
> +}
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
Can this lookup ever succeed with the in-tree Gen4 gPTP provider?

ptp_clock_index_by_of_node() matches through class_find_device() using:

drivers/ptp/ptp_clock.c:ptp_clock_of_node_match() {
	...
	return (dev->parent && dev_of_node(dev->parent) == parent_np);
}

so the PHC must have been registered with a parent device whose OF node is
the phandle target.  The R-Car Gen4 system-wide timer is provided by
rcar_gen4_ptp.c (used by rswitch and rtsn, i.e. the two blocks the binding
patch names as sharing the Gen4 gPTP clock), and it registers with no
parent:

drivers/net/ethernet/renesas/rcar_gen4_ptp.c:rcar_gen4_ptp_register() {
	...
	ptp_priv->clock = ptp_clock_register(&ptp_priv->info, NULL);
	...
}

ptp_clock_register() then stores ptp->dev.parent = parent, so the PTP class
device has no parent and therefore no OF node, and rcar_gen4_ptp_alloc()
never keeps the pdev/device around either.

With that, ravb_gen4_ptp_clock_index() returns -1 even for a correctly
described board, and ravb_get_ts_info() takes the "index < 0" path:

	/* Only advertise ptp clock if present. */
	if (index >= 0) {

leaving so_timestamping, tx_types, rx_filters and phc_index unset, so
ethtool -T and ptp4l see nothing on Gen4.

For comparison, the same "ptp-timer" consumer pattern works for enetc
because the provider passes an owning device:

drivers/ptp/ptp_qoriq.c:ptp_qoriq_init() {
	...
	ptp_qoriq->clock = ptp_clock_register(&ptp_qoriq->caps, ptp_qoriq->dev);
	...
}

Should rcar_gen4_ptp.c pass the owning device to ptp_clock_register(), or
should a different lookup key be used here?

> +
> +static int ravb_gen4_ptp_set_config_mode(struct net_device *ndev)
> +{

[ ... ]

> +
> +static const struct ravb_gptp_info ravb_gen4_ptp_info = {
> +	.probe = ravb_gen4_ptp_probe,
> +	.clock_index = ravb_gen4_ptp_clock_index,
> +	.set_config_mode = ravb_gen4_ptp_set_config_mode,
> +};
> +

[Severity: Medium]
The commit message says that without "ptp-timer" the driver "will no longer
advertise gPTP support to user-space", but is only the advertisement
silenced here?

ravb_get_ts_info() is the single site that consults ->clock_index().
ravb_gen4_hw_info.ptp stays non-NULL, and nothing else looks at
priv->of_gptp, so the remaining timestamping paths stay armed:

ravb_hwtstamp_set() still accepts the request and returns 0:

	switch (config->tx_type) {
	case HWTSTAMP_TX_OFF:
	case HWTSTAMP_TX_ON:
		tstamp_tx_ctrl = config->tx_type;

and net_hwtstamp_validate() in net/core/dev_ioctl.c only range-checks
tx_type/rx_filter, it never consults the ethtool ts_info.  So SIOCSHWTSTAMP
succeeds on an interface that reports no hardware timestamping at all, and
ravb_hwtstamp_get() afterwards reports it as enabled.

The TX timestamp bookkeeping in ravb_start_xmit() is keyed only off
info->ptp and the queue:

	/* TX timestamp required */
	if (info->ptp) {
		if (q == RAVB_NC) {
			ts_skb = kmalloc_obj(*ts_skb, GFP_ATOMIC);

Each such skb gets an extra skb_get(), SKBTX_IN_PROGRESS and an entry on
priv->ts_skb_list.  The only drain is ravb_get_tx_tstamp(), which is driven
by the TX timestamp FIFO:

	count = (ravb_read(ndev, TSR) & TSR_TFFL) >> 8;
	while (count--) {

and that FIFO is fed by the timestamp counter this change intentionally
leaves without a source when "ptp-timer" is absent (and, given the PHC
lookup above, also when it is present).

An unprivileged SO_TIMESTAMPING socket sets SKBTX_HW_TSTAMP and
ravb_select_queue() steers those skbs to RAVB_NC, so if the FIFO never
produces entries, does priv->ts_skb_list keep growing with pinned skbs
until ravb_close() flushes it, with the senders never getting a timestamp?

Would it be cleaner to gate the hwtstamp_set/get and the RAVB_NC TX
timestamp path on the presence of a usable gPTP source as well?

> @@ -2774,7 +2825,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
>  	.tx_counters = 1,
>  	.multi_irqs = 1,
>  	.irq_en_dis = 1,
> -	.ptp = &ravb_gen3_ptp_info,
> +	.ptp = &ravb_gen4_ptp_info,
>  	.nc_queues = 1,
>  	.magic_pkt = 1,
>  };
> @@ -3188,6 +3239,7 @@ static void ravb_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(dev);
>  	clk_unprepare(priv->refclk);
> +	of_node_put(priv->of_gptp);
>  	reset_control_assert(priv->rstc);
>  	free_netdev(ndev);
>  	platform_set_drvdata(pdev, NULL);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
