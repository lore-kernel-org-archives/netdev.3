Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056947F2DB;
	Thu, 24 Sep 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250690; cv=none; b=g15KTQTQ7mRpFhz8VfX1+aOBQ7iUN3Tqb2RuSOf5qjI9jGhjQ+8Z3zQ4HoirogJ9yd4g8FfilE3JkrC5SfT/W/9NHktstAoFz2AYnh72p0DbRdnApdj15Y0lK7f1lIVW5EsvUwmzqJN+LcdVyl0LV8SDxQLbWyAvjgEzal9NPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250690; c=relaxed/simple;
	bh=tD9kc/bWD+e5EEsoTzADdnBKoduGN7q8f4dcTog4QzE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9fbZTROscesiWVLxKfwdxiCONuuyPbYbj4PDSH1SJyaLJ/OZuKdbgCm8EG2b2MRZtPqCtQLws/rHjUk/4BCJRfKPAY7DLhEIrgDnuHb2VjoGrwg83CJOTs5DKxZeXnOyH7yrSMeDia9xw3E0mSMNKzzTQ2LfJVGKcB+yVkGH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Siz15/jZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Siz15/jZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82051F00893;
	Thu, 24 Sep 2026 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250688;
	bh=++nZTjMzMdYMVdCX4bQ4Xk9PhQBpeO0mj+PQXzkZ140=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Siz15/jZypiCfWzVD+bgWwfoMtXB9Hr1OGu3FPjoAYBLRKUe04rGK1aDYDZyFKGbZ
	 sj9syJ0ecEm+0vT3fiwQX4b3xM7Vf+4SSJScDy4DZOMBn2cBU28B4k+lTk0mTKyZj7
	 6ExsTAjO2qhma8MCWdICf6RjJdyQBi/tPVGyW10DFkZe83LhZVRl9CzlRtScVHWGvB
	 hQttNbTLsLPs3mWFsdAFXdn3F8vzqJfSHf/KFRXSWtZ8DdUdSS7pcJXMufNrz2i2Zw
	 D680dBSual8sMMpxbP16WE0eB3xgO1fiORyPoSMnJxcq0cKLwKU4Kb+mfSsZae0yJM
	 Lt3pQfrxhjOxg==
Subject:
 Re: [PATCH net-next v5 10/10] net: ethernet: ravb: Add gPTP support for Gen4
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 24 Sep 2026 11:51:27 +0000
Message-ID: <179025068746.2160803.12846425206722124105@kernel.org>
In-Reply-To: <20260921175037.4084310-11-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-11-niklas.soderlund+renesas@ragnatech.se>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new Gen4 PHC resolution can never succeed, so the feature
  the patch advertises ("Add gPTP support for Gen4") is inert.
- [Medium] On Gen4 the new ravb_gen4_ptp_info has no
  .dmac_start/.ndev_open, so ravb_ptp_init() is never run and no PHC…
- [Medium] ravb_gen4_ptp_probe()
  (drivers/net/ethernet/renesas/ravb_main.c:2765) acquires a device_node…
- [Low] The commit message asserts a pre-existing user-visible defect
  ("While driver advertises gPTP support on Gen4 platforms it is in fact…

--

net: ethernet: ravb: Add gPTP support for Gen4

This adds a Gen4 specific struct ravb_gptp_info that resolves a
system-wide gPTP timer through an optional ptp-timer phandle instead of
the non-existing internal gPTP clock, and programs the APSR gPTP source
bits when such a timer is described. Gen4 no longer advertises gPTP
support when the phandle is missing or its node is disabled.

> While driver advertises gPTP support on Gen4 platforms it is in fact
> completely broken.

[Severity: Low]
The changelog describes fixing an existing user-visible defect and
changes Gen4 behaviour accordingly, but there is no Fixes: tag naming
the commit that introduced the bogus Gen4 gPTP advertisement, and no
note about backportability.

The change depends on the new optional ptp-timer binding added earlier in
the series and on the preceding gPTP refactoring, so a plain Fixes: tag
may not be what is wanted here. Would it help to state explicitly that
this is net-next only and not suitable for stable, or add the tag if a
backport is intended?

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 27e2b31955ba9..5d35b40d7c584 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h

[ ... ]

> @@ -1132,6 +1134,7 @@ struct ravb_private {
>  	struct list_head ts_skb_list;
>  	u32 ts_skb_tag;
>  	struct ravb_ptp ptp;
> +	struct device_node *of_gptp;	/* Reference to external gPTP clock, if any. */
>  	spinlock_t lock;		/* Register access lock */
>  	u32 cur_rx[NUM_RX_QUEUE];	/* Consumer ring indices */
>  	u32 dirty_rx[NUM_RX_QUEUE];	/* Producer ring indices */

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 2dff47c2a125a..5a07cc0180d8b 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2758,6 +2758,57 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
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
Does this leak the ptp-timer device_node reference when probe fails
later on?

of_parse_phandle() returns the node with an incremented refcount, and the
only matching of_node_put() added here is in ravb_remove(). ravb_probe()
calls the new callback early:

	if (info->ptp && info->ptp->probe) {
		error = info->ptp->probe(ndev);
		if (error)
			goto out_reset_assert;
	}

	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
	...

Everything after that point (devm_clk_get_optional(), pm_runtime_resume_and_get(),
devm_platform_get_and_ioremap_resource(), of_get_phy_mode(),
dma_alloc_coherent(), ravb_set_opmode(), ravb_mdio_init(), register_netdev())
unwinds through out_napi_del/out_mdio_release/out_reset_mode/out_rpm_put/
out_rpm_disable/out_reset_assert/out_free_netdev, and none of those labels
calls of_node_put(priv->of_gptp) before free_netdev(ndev) frees priv.
Deferred probe retries would repeat this.

The early return in ravb_remove() looks like it has the same effect:

	error = pm_runtime_resume_and_get(dev);
	if (error < 0)
		return;
	...
	of_node_put(priv->of_gptp);

Would it be worth releasing the node in the probe unwind path as well, or
using a devm-managed lifetime for it?

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

[Severity: High]
Can this lookup ever succeed with the current in-tree gPTP providers?

ptp_clock_index_by_of_node() only matches PTP class devices whose parent
device carries the requested of_node:

drivers/ptp/ptp_clock.c:ptp_clock_of_node_match() {
	...
	return (dev->parent && dev_of_node(dev->parent) == parent_np);
}

The only in-tree registration path for the R-Car Gen4 system-wide gPTP
timer registers the clock without a parent:

drivers/net/ethernet/renesas/rcar_gen4_ptp.c:rcar_gen4_ptp_register() {
	...
	ptp_priv->clock = ptp_clock_register(&ptp_priv->info, NULL);
	...
}

and that is the path used by both rtsn and rswitch, which own the gPTP
block the new ptp-timer phandle points at (on V4H it is the tsn0 node with
reg-names = "tsnes", "gptp").

If dev->parent is always NULL there, ravb_gen4_ptp_clock_index() returns -1
even for a present and enabled ptp-timer, and ravb_get_ts_info() then skips
the capability block:

	if (hw_info->ptp && hw_info->ptp->clock_index)
		index = hw_info->ptp->clock_index(ndev);

	/* Only advertise ptp clock if present. */
	if (index >= 0) {

so ethtool -T on a correctly described Gen4 board would still report no
hardware timestamping and no phc_index. Is a companion change passing
&pdev->dev to ptp_clock_register() in rcar_gen4_ptp_register() (or some
other way to resolve the index) missing from the series?

> +}
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

[Severity: Medium]
With no .dmac_start/.ndev_open here, ravb_ptp_init() never runs on Gen4,
so there is no PHC and the gPTP counter is left unprogrammed. But
info->ptp stays non-NULL, so the timestamp machinery is still armed.
Should the request and consume paths be gated too?

Timestamp FIFO interrupts are enabled unconditionally:

ravb_dmac_init_rcar() {
	...
	/* Frame transmitted, timestamp FIFO updated */
	ravb_write(ndev, TIC_FTE0 | TIC_FTE1 | TIC_TFUE, TIC);
	...
}

and per-frame capture is armed based only on info->ptp in
ravb_start_xmit():

		desc->tagh_tsr = (ts_skb->tag >> 4) | TX_TSR;

ravb_get_tx_tstamp() then reads TFA0/TFA1/TFA2 and reports the values via
skb_tstamp_tx(), and ravb_rx_rcar_hwstamp() copies descriptor
ts_n/ts_sl/ts_sh into skb_hwtstamps().

There also looks to be a mismatch between what is advertised and what is
accepted: ravb_get_ts_info() reports no hardware timestamping when
clock_index() returns -1, while ravb_hwtstamp_set() still accepts
HWTSTAMP_TX_ON and upgrades unknown filters to HWTSTAMP_FILTER_ALL with no
check that a gPTP timer exists.

In the case where ptp-timer is absent or its node is disabled,
ravb_gen4_ptp_set_config_mode() still asserts CCC_GAC | CCC_CSEL_HPB but
skips the APSR source programming. What do TFA reads and the descriptor
timestamps contain in that configuration, and is it intended that they
still reach user space?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921175037.4084310-1-niklas.soderlund%2Brenesas%40ragnatech.se
