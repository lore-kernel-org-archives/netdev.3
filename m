Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E449363A;
	Thu, 10 Sep 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051497; cv=none; b=FXWeY2eO1q/LqKciuYGM+KUiDtBPahmXByRe236d0wMcTp1LecIJze/UXvfqHKt84RyRom34tB/ioHGrwG32ruxKDUDqXvNwZkiOoFf3ONuHnfYyd6k3KeBHE0mxe3vmokAHE7EB/Aj8zW706D7om4W8zEYmd+7p+r1Ns/L59Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051497; c=relaxed/simple;
	bh=L0fABXhhJ5o8ApxCOeK/jaa7PFD2AoXBi/8UZQrILF0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbEDfN4jLH9CZYW7cOkEyeObYciM+sDc+MnxAVe3bwPi64k/62LWf1vtjMVLlLuCPR1/51FDuxXiGORwsNi4FwerdXx6p6x/vq29yQV47ipsZ0xh6ozncnIOODiajbxN8DIB4M4m5zBz9UkEYS8r8KHqTMT46VbM8e0MLTqJrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAG39x7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAG39x7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9791F000FF;
	Thu, 10 Sep 2026 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051495;
	bh=hVgXNw+GYAQS66+HUyXSaWPsjVdGkaA4o2+RXQZwmK0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fAG39x7haeZ2E6gmNHG6kQCR6mdQSZ1lnMYeeK31phAO3B6OE2uZ/GFDmxSKviWpu
	 ZQ52HAPvY+kBAs6pijQBSTfwXl7zgGiveF3RMIKEhSdH0UjHUs6ZDe8tFpzfvzqPd5
	 R4rrb8RSUDU1cfLgVtBoR0qk/2p/p+vF2cn1opLMNI/+Ho+gCrP11KbnuzEzfP5U0f
	 WzbdlkvRMlMLNLbTaIaJcpl1Sv7hi0kQM4uheqwfuLAEoVcFmcsuEGg/RHXIfxcpKK
	 IhBlsmyNpGHDsoIuepkjKLIDm1G+L9RLruz5EZYM/hUTRkXyfICKm0LsOKboGtrreY
	 zYysO1MORr+vA==
Subject: Re: [PATCH net-next v2 2/4] net: macb: Move TC capability and PM
 checks to macb_setup_tc()
From: netdev-bot+sashiko@kernel.org
To: vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 14:44:54 +0000
Message-ID: <178905149422.219967.17478774177902422624@kernel.org>
In-Reply-To: <20260909142056.1433875-3-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-3-vineeth.karumanchi@amd.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

- [High] macb_setup_tc() only samples the runtime-PM state with
  pm_runtime_suspended() (macb_main.c:4509) and never acquires a…
- [Medium] macb_setup_tc()
  (drivers/net/ethernet/cadence/macb_main.c:4494-4519) now runs the…

Pre-existing issues:
- [Low] The relocated gate in macb_setup_tc() tests the immutable
  capability mask (`netdev->hw_features & NETIF_F_HW_TC`,…

--

net: macb: Move TC capability and PM checks to macb_setup_tc()

This moves the NETIF_F_HW_TC capability test and the runtime PM suspend
guard out of macb_setup_taprio() and into the shared macb_setup_tc()
entry point so future TC qdisc types do not have to repeat them.

A few questions about the relocated checks below.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8223ad81215b..ff7e02d3fab8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4476,18 +4476,8 @@ static void macb_taprio_destroy(struct net_device *netdev)
>  static int macb_setup_taprio(struct net_device *netdev,
>  			     struct tc_taprio_qopt_offload *taprio)
>  {
> -	struct macb *bp = netdev_priv(netdev);
>  	int err = 0;
>  
> -	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
> -		return -EOPNOTSUPP;
> -
> -	/* Check if Device is in runtime suspend */
> -	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
> -		netdev_err(netdev, "Device is in runtime suspend\n");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	switch (taprio->cmd) {
>  	case TAPRIO_CMD_REPLACE:
>  		err = macb_taprio_setup_replace(netdev, taprio);

[ ... ]

> @@ -4505,9 +4495,22 @@ static int macb_setup_taprio(struct net_device *netdev,
>  static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  			 void *type_data)
>  {
> +	struct macb *bp;
> +
>  	if (!netdev || !type_data)
>  		return -EINVAL;
>  
> +	bp = netdev_priv(netdev);
> +
> +	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
> +		return -EOPNOTSUPP;

[Severity: Low]
This isn't a bug introduced by this patch, since the test is only being
relocated here, but should this gate look at netdev->features rather than
netdev->hw_features?

macb_probe() sets:

	if (bp->caps & MACB_CAPS_TC)
		netdev->hw_features |= NETIF_F_HW_TC;

	netdev->features = netdev->hw_features;

hw_features is never touched again, so this condition reduces to a
MACB_CAPS_TC capability test. macb_set_features() only reacts to
NETIF_F_HW_CSUM, NETIF_F_RXCSUM and NETIF_F_NTUPLE and returns 0 for a
NETIF_F_HW_TC change, so after

	ethtool -K ethX hw-tc-offload off

does a subsequent taprio replace still get accepted and programmed into
the ENST registers, and does an already programmed configuration stay
active?  The usual spelling for this gate elsewhere is
dev->features & NETIF_F_HW_TC (see tc_can_offload()).

> +
> +	/* Check if Device is in runtime suspend */
> +	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
> +		netdev_err(netdev, "Device is in runtime suspend\n");
> +		return -EOPNOTSUPP;
> +	}

[Severity: High]
Since this is now presented as the precondition for all ndo_setup_tc
paths, is a plain status read enough to keep the register clocks on for
the duration of the offload?

pm_runtime_suspended() only reports runtime_status == RPM_SUSPENDED, so it
returns false both when the device is RPM_ACTIVE with a pending
autosuspend and when it is RPM_SUSPENDING. macb_close() drops the
reference asynchronously:

	pm_runtime_put(&bp->pdev->dev);

which arms the MACB_PM_TIMEOUT (100 ms) autosuspend. Can the timer then
expire right after the check passes, so that

macb_runtime_suspend()
    macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk, bp->rx_clk, bp->tsu_clk);

runs while macb_taprio_setup_replace() or macb_taprio_destroy() is still
writing ENST_CONTROL and the per-queue ENST_START_TIME / ENST_ON_TIME /
ENST_OFF_TIME registers?  macb_taprio_setup_replace() does sleeping work
(kcalloc(GFP_KERNEL), phylink_ethtool_ksettings_get()) before it reaches
the register block, so the window is not small, and bp->lock does not
exclude the PM core.

Every other register-touching path in this driver brackets access with a
usage reference instead, for example macb_mdio_read()/macb_mdio_write(),
macb_open() and at91ether_open() use
pm_runtime_resume_and_get() ... pm_runtime_put_autosuspend(). Would
replacing the check with that pairing here be preferable to relocating
it, given the MQPRIO and CBS handlers added later in the series inherit
this precondition too?

> +
>  	switch (type) {
>  	case TC_SETUP_QDISC_TAPRIO:
>  		return macb_setup_taprio(netdev, type_data);

[Severity: Medium]
The guard above now runs before the switch, so it also fires for
tc_setup_type values this driver never handled. Is the netdev_err() on
those paths intended?

net/sched/cls_api.c:tcf_block_offload_cmd() calls ndo_setup_tc
unconditionally with non-NULL type_data:

	if (dev->netdev_ops->ndo_setup_tc) {
		int err;

		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
		if (err < 0) {
			if (err != -EOPNOTSUPP)
				NL_SET_ERR_MSG(extack, "Driver ndo_setup_tc failed");

and -EOPNOTSUPP is a normal outcome there (tcf_block_offload_bind() falls
back to no_offload_dev_inc() and returns 0).

So on MACB_CAPS_TC hardware whose interface is down and has autosuspended,
does every clsact/ingress qdisc add and delete now print
"Device is in runtime suspend" at error level while the command itself
succeeds?  The message is not rate limited, so repeating the operation
would repeat the log line. At this commit the same applies to
qdisc_offload_query_caps():

	if (ops->ndo_setup_tc)
		ops->ndo_setup_tc(dev, TC_QUERY_CAPS, &base);

The TC_QUERY_CAPS case is later moved ahead of the guard by the following
patch in the series ("net: macb: Add MQPRIO qdisc hardware offload
support"), but TC_SETUP_BLOCK still reaches it at the end of the series.

Before this patch these types went straight to the default case and
returned -EOPNOTSUPP with no PM inspection and no log output. Could the
commit message mention this, since it is described as centralizing
existing preconditions?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909142056.1433875-1-vineeth.karumanchi%40amd.com
