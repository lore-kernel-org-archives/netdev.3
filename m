Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33333ED3AF;
	Mon,  7 Sep 2026 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749322; cv=none; b=Kok9jLFasc0/9kCgUvnndrTlmUYqnyxBhV8BLOPz6EAm8USXfOzACqe3a1sfsjsYJAS4EV0PAuOVJofAphiBTOCk7OTcQ5KqjuEKQs+g8ziVSIL+kv0Ew68kQGYirjK5a4tKls0+T3j3dgjy8uxrE9phbueLuRTH99n1FpDSN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749322; c=relaxed/simple;
	bh=Nv0kMnPja4FaL38Ng1DJdzNZ1bQrHm6ZvmSbtaXteN0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2JwiSJVZmYwK4nEFIbxs7IE3Ld0VvrLSlH5O2hcmFWXpD9W5VWv3ylAYeP8WQfnIHziDDYwPzm/boW0DDI2Y8qnK73aHXCbMA7ZpHH7HgsLHGizKBG1TNueCBFdu5nA/bsGRabFFg3WK/TI3r4f8B/iN851kOdNSOP2XJooJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVoHDbmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVoHDbmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E843F1F00A3D;
	Mon,  7 Sep 2026 02:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749317;
	bh=p6xP2itYgAvhByxjolvTRrZ0lYGTvxkLczBv2wbz2dU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CVoHDbmhxMdh4kLOHL5E5CO4iAy0f0IcrFN9OkFSYlkUS8tCCWvre3N95tN5LWR5Z
	 TFnwoNtvK/vNTyrBCYboI8rV9AhN8izrmKR73IEwpcE5Os4qJxRqmHrBnOMPlPTWWX
	 v0HYCEqfTIcMheqV+bxBXyexawffxru1Yy95+NxFMOczh4CCzVujBL8LZgUKPNwel6
	 luybgIdR7iZ5VZEFyKzpF5GvI3vq0QCnDaSL9+KT7oqNi/TwUwMlCoFXbFrMTHJTvo
	 jhULmWQb2nhqD8kw045eNY14fRJcrQzJ3+2LbhamwnmmGvAMDd/QHi+rYqNT63ScxZ
	 BmfHiJZsAextg==
Subject: Re: [PATCH net-next v3 07/10] net: ethernet: ravb: Add callback for
 gPTP probe
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:36 +0000
Message-ID: <178874931650.219967.14780961400523753736@kernel.org>
In-Reply-To: <20260902084703.3228504-8-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-8-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Critical
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

Critical: 1 · High: 2 · Medium: 1 · Low: 0

- [Critical] ravb_get_ts_info()
  (drivers/net/ethernet/renesas/ravb_main.c:1771-1790) gates on…
- [High] ravb_ptp_stop()
  (drivers/net/ethernet/renesas/ravb_ptp.c:368-377) unregisters…
- [High] For the ccc_gac-style generations the PTP clock is registered
  from ravb_open() via info->ptp->ndev_open (ravb_main.c:1953-1956,…
- [Medium] The newly propagated ptp_clock_register() error creates
  ravb_open() failure paths that leak all DMA ring resources.

--

net: ethernet: ravb: Add callback for gPTP probe

This adds a probe callback to struct ravb_gptp_info so each RAVB
generation can acquire its own gPTP timer clock, removes the last gPTP
specific flag (gptp_ref_clk), and moves the GTI computation into the new
per-generation probe callbacks.

A few questions below about the gPTP clock lifecycle that the ptp callback
structs in this patch select.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 5d5b9c0e2f450..7e53eca5327f5 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c

[ ... ]

> @@ -2668,6 +2668,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
>  }
>  
>  static const struct ravb_gptp_info ravb_gen2_ptp_info = {
> +	.probe = ravb_gen2_ptp_probe,
>  	.set_config_mode = ravb_gen2_ptp_set_config_mode,
>  	.dmac_start = ravb_ptp_init,
>  	.dmac_stop = ravb_ptp_stop,
>  };

[Severity: High]
With dmac_stop = ravb_ptp_stop wired up here, can priv->ptp.clock end up
pointing at a freed object after the interface goes down?

ravb_ptp_stop() in ravb_ptp.c unregisters the clock but never clears the
pointer:

	if (priv->ptp.clock)
		ptp_clock_unregister(priv->ptp.clock);

The baseline cleared it before unregistering:

	WRITE_ONCE(priv->ptp.phc_index, -1);
	clock = xchg(&priv->ptp.clock, NULL);

After ip link set <if> down on Gen2/RZ-V2M, ravb_close() -> ravb_stop_dma()
-> dmac_stop = ravb_ptp_stop() leaves the stale pointer, and
ravb_get_ts_info() then reads the freed memory:

	info->phc_index = ptp_clock_index(priv->ptp.clock);

drivers/ptp/ptp_clock.c:ptp_clock_index() is just:

	return ptp->index;

ETHTOOL_GET_TS_INFO is in the list in dev_ethtool() that skips the
ns_capable(CAP_NET_ADMIN) check, so this read is reachable by any local
user once the interface is down.

Can the same stale pointer also be unregistered twice? In
ravb_tx_timeout_work(), ravb_stop_dma() runs ravb_ptp_stop() (unregister),
and if the following ravb_dmac_init() fails (ravb_ring_init() returning
-ENOMEM, or the OPERATION opmode wait timing out) the function returns via
out_unlock without re-registering, so the later ravb_close() ->
ravb_stop_dma() -> ravb_ptp_stop() calls ptp_clock_unregister() on the
already freed clock.

This was introduced earlier in the series by "net: ethernet: ravb:
Propagate error from ptp_clock_register()" and ravb_ptp_stop() is still
unchanged at the end of the series (941e688), where
ravb_gen2_ptp_clock_index() likewise still does
return ptp_clock_index(priv->ptp.clock).

> @@ -2704,6 +2705,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
>  }
>  
>  static const struct ravb_gptp_info ravb_gen3_ptp_info = {
> +	.probe = ravb_gen2_ptp_probe,
>  	.set_config_mode = ravb_gen3_ptp_set_config_mode,
>  	.ndev_open = ravb_ptp_init,
>  	.ndev_close = ravb_ptp_stop,
>  };

[Severity: High]
Since ravb_gen3_ptp_info registers the clock from ndev_open and only tears
it down from ndev_close, is the clock leaked when ravb_open() fails after
that registration?

ravb_open() calls info->ptp->ndev_open() and then ravb_phy_start(), whose
failure path is:

out_ptp_stop:
	ravb_stop_dma(ndev);

ravb_stop_dma() only stops PTP through info->ptp->dmac_stop, and
ravb_gen3_ptp_info has no dmac_stop, so nothing unregisters the clock.
ravb_gen4_hw_info uses ravb_gen3_ptp_info at this commit as well.

ravb_phy_start() can fail concretely: ravb_phy_init() returns -ENOENT when
of_phy_connect() fails, and it also propagates
of_phy_register_fixed_link() errors. As ndo_open returned an error the
netdev never goes IFF_UP, so ndo_stop and therefore ndev_close =
ravb_ptp_stop() are never called.

Consequences of that: /dev/ptpN stays registered; a retried open
overwrites priv->ptp.clock in ravb_ptp_init(), losing the old registration
for good; and a later unbind runs ravb_remove() -> free_netdev(ndev)
while the PTP core still has ptp->info pointing into the freed netdev
private area.

The baseline out_ptp_stop label did:

	if (info->gptp || info->ccc_gac)
		ravb_ptp_stop(ndev);

That was dropped by the series commit "net: ethernet: ravb: Simplify gPTP
start and stop", which added the stop only inside ravb_stop_dma(), so the
"no functional change" claim there does not seem to hold for the ccc_gac
(Gen3/Gen4) case. The gap is still present at 941e688, where out_ptp_stop
only calls ravb_stop_dma() and ravb_gen3_ptp_info still has no dmac_stop.

> @@ -2763,6 +2765,24 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
>  	.magic_pkt = 1,
>  };
>  
> +static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +
> +	priv->gptp_clk = devm_clk_get(&priv->pdev->dev, "gptp");
> +	if (IS_ERR(priv->gptp_clk))
> +		return PTR_ERR(priv->gptp_clk);
> +
> +	return ravb_compute_gti(ndev, priv->gptp_clk);
> +}
> +
> +static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
> +	.probe = ravb_rzv2m_ptp_probe,
> +	.set_config_mode = ravb_gen2_ptp_set_config_mode,
> +	.dmac_start = ravb_ptp_init,

[Severity: Medium]
With dmac_start = ravb_ptp_init, does a failing ptp_clock_register() leak
the DMA rings?

ravb_dmac_init() first runs info->dmac_init = ravb_dmac_init_rcar(), which
allocates both queues in ravb_ring_init():

	priv->rx_pool[q] = page_pool_create(&params);
	...
	priv->tx_ring[q] = dma_alloc_coherent(ndev->dev.parent, ring_size,
					      &priv->tx_desc_dma[q], GFP_KERNEL);

and only afterwards does:

	/* Initialise PTP Clock driver */
	if (info->ptp && info->ptp->dmac_start)
		return info->ptp->dmac_start(ndev);

If ptp_clock_register() in ravb_ptp_init() fails (for example -ENOMEM under
memory pressure), that error reaches ravb_open(), which jumps to
out_set_reset. Neither out_set_reset nor out_ptp_stop calls
ravb_ring_free(), and since ndo_open returned an error, ravb_close() (the
only ring freeing path) never runs; ravb_remove() does not free them
either.

A later open re-enters ravb_ring_init() and overwrites priv->rx_pool[q],
priv->rx_buffers[q], priv->tx_skb[q], priv->rx_ring[q] and
priv->tx_ring[q], so the previous page pools with their DMA mappings and
the coherent descriptor memory are lost.

For Gen3/Gen4 the equivalent ndev_open failure goes to out_ptp_stop, which
also does not call ravb_ring_free(). The same leak shape already existed
for a failing ravb_set_opmode(CCC_OPC_OPERATION); the new trigger comes
from the series commit "net: ethernet: ravb: Propagate error from
ptp_clock_register()", and the ravb_open() error labels are unchanged at
941e688.

> +	.dmac_stop = ravb_ptp_stop,
> +};
> +
>  static const struct ravb_hw_info ravb_rzv2m_hw_info = {
>  	.receive = ravb_rx_rcar,
>  	.set_rate = ravb_set_rate_rcar,
> @@ -2783,8 +2803,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
>  	.dbat_entry_num = 22,
>  	.multi_irqs = 1,
>  	.err_mgmt_irqs = 1,
> -	.ptp = &ravb_gen2_ptp_info,
> -	.gptp_ref_clk = 1,
> +	.ptp = &ravb_rzv2m_ptp_info,

[Severity: Critical]
hw_info->ptp is what ravb_get_ts_info() tests, and it only says the IP
supports gPTP. Can that path dereference a NULL priv->ptp.clock?

ravb_get_ts_info() does:

	if (hw_info->ptp) {
		...
		info->phc_index = ptp_clock_index(priv->ptp.clock);
	}

priv->ptp.clock is the zero initialised NULL from alloc_etherdev_mqs()
until the clock is registered, which only happens in the open lifecycle
(Gen2/RZ-V2M via ravb_dmac_init() -> dmac_start = ravb_ptp_init(),
Gen3/Gen4 via ravb_open() -> ndev_open = ravb_ptp_init()), and
ravb_ptp_init() explicitly stores NULL on registration failure:

	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
	if (IS_ERR(priv->ptp.clock)) {
		ret = PTR_ERR(priv->ptp.clock);
		priv->ptp.clock = NULL;

With CONFIG_PTP_1588_CLOCK=y, ptp_clock_index() is
return ptp->index;, so ethtool -T on an interface that has never been
opened (the state right after probe and register_netdev) oopses.
ETHTOOL_GET_TS_INFO does not require CAP_NET_ADMIN in dev_ethtool(), so an
unprivileged user can reach it; only CONFIG_PTP_1588_CLOCK=n is safe
because of the inline stub returning -1.

The baseline kept a separate priv->ptp.phc_index initialised to -1 in
ravb_probe() and read it with READ_ONCE(); the series commit "net:
ethernet: ravb: Propagate error from ptp_clock_register()" removed that
field and its -1 initialisation. At 941e688 the callback
ravb_gen2_ptp_clock_index() still does
return ptp_clock_index(priv->ptp.clock) and is installed for gen2, gen3
and rzv2m.

>  	.nc_queues = 1,
>  	.magic_pkt = 1,
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
