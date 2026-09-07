Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AD3EC817;
	Mon,  7 Sep 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749322; cv=none; b=YAt0ko9xIAmmn1EJukIzcrheNVnhRlMvvivy7/rUJ9683/0LI0nA3HQXxrnkk64yTvAZKKIfsnXuA0lXkbsCY8sYsOc+Hoo7NiPQos0QEr1uOTA2CNKpN4M7Sk1/dz2qfcvNhEcp4TMvIskP3AaCE3iNS1ut7Khgs//m0A5olbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749322; c=relaxed/simple;
	bh=qnzEyg/nie29RXiGUabhxbmT5fO2YdoYhUGgcqccVhY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGUIh79w/j15x/Tag2OjR0X0F5wBC0aHGkNhNB58aiuySoTmEefjLAIc8k0t+uJCRVR0pI3iy8Gtnm/XIiZ759qrvCBCjdzM09fVwSg+jwN8mNtRAGJPzqMrCKgbhuVsZYZMKmXIvBogAiBteQ5kRYAtzX8tUMIxadH7lOaeMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrOFiAIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrOFiAIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B4C1F00A3E;
	Mon,  7 Sep 2026 02:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749319;
	bh=mX9WXj/J64XQH2pcKXhPUsEd6bw/GEdngVqrSOrNP2I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RrOFiAIBDCV/EemZgSHMbkt+oaUMH2o5IgJaAjccBvulJ//AYjiMufNbbluspRVDr
	 peF0U+/Ie2qFFQ88++EkLllECDyifCfJC1mSCd7+/t4cgruLL4VCNkQAWfusqRXY63
	 t1paMk1TRVLnMSuhUsmbCkBIjlBqxjuo6poXtlXxJ+S5pT6NUzBfDDBJkr15fF8EPr
	 /fScf1Nch4OyRgjAlD9C1joGX/LieX92YznPnPfFzZaB5Id2JQVngnBZ7nrMDcMgJo
	 ArfAwjW8PGUhdBI4XJ1BCU4/98CLRyxEBeC2NdNwdHhOXdGB9vdZ/sFzc7vSq8C55J
	 +sPvVoyLs6uEw==
Subject: Re: [PATCH net-next v3 08/10] net: ethernet: ravb: Add callback for
 gPTP clock index
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:38 +0000
Message-ID: <178874931806.219967.12751179710429084501@kernel.org>
In-Reply-To: <20260902084703.3228504-9-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-9-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 1 · High: 0 · Medium: 2 · Low: 0

- [Critical] NULL pointer dereference (oops) and post-close use-after-
  free read via the new `.clock_index` callback.
- [Medium] All timestamping capabilities, including the purely software
  SOF_TIMESTAMPING_TX_SOFTWARE bit and the tx_types/rx_filters masks,…
- [Medium] On Gen2 and RZ/V2M the gPTP shutdown is now reached only
  through `.dmac_stop = ravb_ptp_stop` at the tail of `ravb_stop_dma()`…

--

net: ethernet: ravb: Add callback for gPTP clock index

This adds a .clock_index callback to struct ravb_gptp_info and uses its
return value in ravb_get_ts_info() to decide whether the driver reports
gPTP support. Gen2, Gen3 and RZ/V2M all get ravb_gen2_ptp_clock_index()
wired up.

A few questions below.

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index b788e8f5260dd..27e2b31955ba9 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1042,6 +1042,7 @@ struct ravb_ptp {
>   * critical points in the RAVB driver.
>   *
>   * @probe:		Probe the gPTP clock
> + * @clock_index:	Get the PTP clock index, if any
>   * @set_config_mode:	Enter config mode
>   * @dmac_start:		Called when the DMAC starts
>   * @dmac_stop:		Called when the DMAC stops
> @@ -1050,6 +1051,7 @@ struct ravb_ptp {
>   */
>  struct ravb_gptp_info {
>  	int (*probe)(struct net_device *ndev);
> +	int (*clock_index)(struct net_device *ndev);
>  	int (*set_config_mode)(struct net_device *ndev);
>  	int (*dmac_start)(struct net_device *ndev);
>  	void (*dmac_stop)(struct net_device *ndev);

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 7e53eca5327f5..402370e1be634 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1773,8 +1773,13 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *hw_info = priv->info;
> +	int index = -1;
>  
> -	if (hw_info->ptp) {
> +	if (hw_info->ptp && hw_info->ptp->clock_index)
> +		index = hw_info->ptp->clock_index(ndev);
> +
> +	/* Only advertise ptp clock if present. */
> +	if (index >= 0) {
>  		info->so_timestamping =
>  			SOF_TIMESTAMPING_TX_SOFTWARE |

[Severity: Medium]
Is it intended that the whole capability block, and not just phc_index, is
now gated on the clock index?

RAVB has "depends on PTP_1588_CLOCK_OPTIONAL" in
drivers/net/ethernet/renesas/Kconfig, so CONFIG_PTP_1588_CLOCK=n is a
supported build. In that configuration ptp_clock_index() is the stub in
include/linux/ptp_clock_kernel.h:

  static inline int ptp_clock_index(struct ptp_clock *ptp)
  { return -1; }

so ravb_gen2_ptp_clock_index() always returns -1, "if (index >= 0)" never
fires, and ravb_get_ts_info() leaves so_timestamping, tx_types and
rx_filters all at 0.

Before this change the gate was "if (hw_info->ptp)", which advertised
SOF_TIMESTAMPING_TX_SOFTWARE together with the hardware bits and the
tx_types/rx_filters masks while leaving phc_index at -1. Commit
1f77af0aaf27 ("net: ravb: avoid dereferencing an invalid PTP clock")
described that as preserving "the static timestamping capabilities".

ravb_start_xmit() still calls skb_tx_timestamp(), and
__ethtool_get_ts_info() in net/ethtool/common.c only adds the RX and
generic software bits:

  info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
			   SOF_TIMESTAMPING_SOFTWARE;

so SOF_TIMESTAMPING_TX_SOFTWARE disappears from ethtool -T entirely. Should
the software capability bits and the filter masks be reported
unconditionally, with only phc_index depending on the callback?

>  			SOF_TIMESTAMPING_TX_HARDWARE |
> @@ -1785,7 +1790,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  			(1 << HWTSTAMP_FILTER_NONE) |
>  			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>  			(1 << HWTSTAMP_FILTER_ALL);
> -		info->phc_index = ptp_clock_index(priv->ptp.clock);
> +		info->phc_index = index;
>  	}
>  
>  	return 0;
> @@ -2653,6 +2658,13 @@ static int ravb_gen2_ptp_probe(struct net_device *ndev)
>  	return ravb_compute_gti(ndev, priv->clk);
>  }
>  
> +static int ravb_gen2_ptp_clock_index(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +
> +	return ptp_clock_index(priv->ptp.clock);
> +}
> +

[Severity: Critical]
Can this dereference priv->ptp.clock when no clock is registered?

With CONFIG_PTP_1588_CLOCK=y, ptp_clock_index() in drivers/ptp/ptp_clock.c
is an unconditional dereference:

  int ptp_clock_index(struct ptp_clock *ptp)
  {
	  return ptp->index;
  }

The PHC is only registered at open time (.dmac_start / .ndev_open =
ravb_ptp_init) and unregistered at close (.dmac_stop / .ndev_close =
ravb_ptp_stop), so priv->ptp.clock is NULL before the first open and stale
after close, since ravb_ptp_stop() no longer clears it:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_stop() {
	...
	if (priv->ptp.clock)
		ptp_clock_unregister(priv->ptp.clock);
}

ravb_get_ts_info() is reached from ethtool -T / ETHTOOL_MSG_TSINFO_GET, and
__ethtool_get_ts_info() in net/ethtool/common.c has no netif_running() or
CAP_NET_ADMIN gate. So a query on a never-opened interface would call
ptp_clock_index(NULL), and a query after "ip link set eth0 down" would read
memory freed by ptp_clock_unregister() and hand the result back to userspace
as phc_index. Is that reachable as written?

The "if (index >= 0)" test and the "@clock_index: Get the PTP clock index,
if any" kernel-doc suggest the callback is expected to be able to report
absence, but this implementation cannot return a negative value on
Gen2/Gen3/RZ/V2M when CONFIG_PTP_1588_CLOCK=y. The sibling helper in the
same driver family does carry the guard:

drivers/net/ethernet/renesas/rcar_gen4_ptp.c:rcar_gen4_ptp_clock_index() {
	if (!priv->initialized)
		return -1;

	return ptp_clock_index(priv->clock);
}

Note the baseline before this series cached the value instead
(info->phc_index = READ_ONCE(priv->ptp.phc_index), initialised to -1 in
ravb_probe() and reset to -1 in ravb_ptp_stop()) and cleared the pointer
with clock = xchg(&priv->ptp.clock, NULL). Those came from commit
1f77af0aaf27 ("net: ravb: avoid dereferencing an invalid PTP clock", Cc:
stable, Fixes: a0d2f20650e8) and commit 1cb9663789c5 ("net: ravb: serialize
PTP clock teardown", Cc: stable). The earlier patch in this series ("net:
ethernet: ravb: Propagate error from ptp_clock_register()") removed both,
and the later "net: ethernet: ravb: Add gPTP support for Gen4" only adds a
registration-state guard for Gen4, so Gen2/Gen3/RZ/V2M still look exposed at
the end of the series. Would a registration-state check here, plus clearing
priv->ptp.clock in ravb_ptp_stop(), restore the previous behaviour?

>  static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
>  {
>  	int ret;
> @@ -2669,6 +2681,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
>  
>  static const struct ravb_gptp_info ravb_gen2_ptp_info = {
>  	.probe = ravb_gen2_ptp_probe,
> +	.clock_index = ravb_gen2_ptp_clock_index,
>  	.set_config_mode = ravb_gen2_ptp_set_config_mode,
>  	.dmac_start = ravb_ptp_init,
>  	.dmac_stop = ravb_ptp_stop,

[Severity: Medium]
Since the clock index now depends on whether the PHC is registered, is the
Gen2/RZ/V2M teardown path via .dmac_stop always taken?

On these variants ravb_ptp_stop() is only reached from the tail of
ravb_stop_dma(), after three earlier error returns:

drivers/net/ethernet/renesas/ravb_main.c:ravb_stop_dma() {
	...
	error = ravb_wait(ndev, TCCR, info->tccr_mask, 0);
	if (error)
		return error;
	...
	/* Stop PTP Clock driver */
	if (info->ptp && info->ptp->dmac_stop)
		info->ptp->dmac_stop(ndev);
	...
}

and ravb_close() continues regardless:

drivers/net/ethernet/renesas/ravb_main.c:ravb_close() {
	...
	/* Set the config mode to stop the AVB-DMAC's processes */
	if (ravb_stop_dma(ndev) < 0)
		netdev_err(ndev,
			   "device will be stopped after h/w processes are done.\n");
	...
}

If any of the TCCR / CSR(TPO*) / CSR(RPO) polls time out, the PHC stays
registered while ravb_close() goes on to free the rings, set CCC_OPC_RESET
and call pm_runtime_put_autosuspend(). Can /dev/ptpN then still drive
ravb_ptp_gettime64()/settime64()/adjfine() and issue ravb_read()/
ravb_write() against a device in reset with clocks gated?

A following "ip link set eth0 up" also runs ravb_dmac_init() ->
.dmac_start = ravb_ptp_init -> ptp_clock_register() and overwrites
priv->ptp.clock, which looks like it leaks the previously registered
ptp_clock whose ptp_clock_info points into the netdev private data.

The baseline called ravb_ptp_stop() before ravb_stop_dma() in ravb_close(),
so a DMA-stop timeout could not skip the gPTP teardown. The commit that
moved it ("net: ethernet: ravb: Simplify gPTP start and stop") states "There
are no functional change" — does that hold for this error path?

> @@ -2706,6 +2719,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
>  
>  static const struct ravb_gptp_info ravb_gen3_ptp_info = {
>  	.probe = ravb_gen2_ptp_probe,
> +	.clock_index = ravb_gen2_ptp_clock_index,
>  	.set_config_mode = ravb_gen3_ptp_set_config_mode,
>  	.ndev_open = ravb_ptp_init,
>  	.ndev_close = ravb_ptp_stop,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
