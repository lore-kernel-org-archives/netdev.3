Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95D2BE65B
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830138; cv=none; b=PYOUJzgFSLBITSs0ujnjHOXx3vOO8CJ8zQ5251aM1Xp9ZfXFW7zSFpHgH4IBcLY/f3eQLIkklY5880o4lpSPi+JjmpquJh3O10qAWoy1fPygZSWwgZgiVL7QtAAiSDo/TZGWgSrAw86vle1dFT/ZdFq1VUb3s0ANveZcbbnvZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830138; c=relaxed/simple;
	bh=e5MihVsVvFe4tw/eL2DZQE1XUPpMnp6e9llrzl9igiQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2dn1/FA03meZgIs+yuAcAXgI6GhwJW86aIoFAM2vUaX+6VLHSa1ifftyJjPeuoW5iBNkqdmk2o6ZY33D/zSPVKoYf7OiaV4vB+kDYiDULzeS6Zd5PaFGdAEfLqOz0UqCEBlQ3pft2kP8vPrOOHuiPVctjrun8FJAPw7NlJlNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJa3fxBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJa3fxBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CCD1F000FF;
	Thu,  1 Oct 2026 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790830136;
	bh=eMdFBuKhoKS1uaMwcf5rSALI4bUeBraeA2XPiEFBTBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GJa3fxBP6d4WKEbyGlU+rLzju1G7GcJnNTvorRwvPhb8d1Hwqwcp1pxaap2x1R+aC
	 oT4qMmhooYppBcS9eEiNwosR2NgS+0/b9rSFy06JA3ZEc6Lrs4htLTEdOIKILKSfwI
	 OT/r3iYFT7ApX/nj9Td1BtS3REmoSvUv7guqr1xwp/aIoGYfqailwOhKGC8WSzosk4
	 Uh7J2Fboj8ELj/5U5FeYzeheA+2Be773Y7BjjBPrQiEJIlSFmphDZEeVedtXc6k8hd
	 D3/LHJZvfbUU9vDEhN0qx0EWjDdi+P8PNuPu0IhqmxLAvUkVVv2tnSYalk2yCO8X/O
	 Sw4Tsv/sniGlg==
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: add tc mqprio hw queue
 priority offload
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, olteanv@gmail.com,
 0x1207@gmail.com, daniel@riscstar.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 01 Oct 2026 04:48:55 +0000
Message-ID: <179083013550.434549.16460704020189061203@kernel.org>
In-Reply-To:
 <20260928-stmmac-mqprio-prio-offload-v3-1-abbe181f5024@oss.qualcomm.com>
References:
 <20260928-stmmac-mqprio-prio-offload-v3-1-abbe181f5024@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Stale shadow priorities in xmit_qdisc.prio[] get written back
  to hardware.
- [Medium] net: stmmac: state corruption when switching mqprio mode from
  CHANNEL to DCB

Pre-existing issues:
- [Medium] Channel-mode shaper and rate requests are accepted but never
  applied.
- [Medium] DCB mappings with queue gaps quietly disable TC
  classification.
- [Medium] The mqprio path accesses MAC/MTL registers without a runtime-
  PM reference.

--

net: stmmac: add tc mqprio hw queue priority offload

This patch adds mqprio channel mode offload to stmmac. In that mode the
MTL TX scheduler is switched to strict priority and the per-queue
PSTQx/PSTC priority bitmasks are programmed from prio_tc_map. The patch
also adds a shadow copy of the TX algorithm and the per-queue priorities
in priv->xmit_qdisc, which is programmed into the hardware on open.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 42a00446e9b4..07cf4582ed76 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1266,12 +1269,109 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
> +	if (priv->xmit_qdisc.prio_offload) {
> +		int i;
> +
> +		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> +			u32 prio;
> +
> +			if (priv->plat->tx_queues_cfg[i].use_prio)
> +				prio = priv->plat->tx_queues_cfg[i].prio;
> +			else
> +				prio = 0;
> +
> +			stmmac_tx_queue_prio(priv, priv->hw, prio, i);
> +			priv->xmit_qdisc.prio[i] = prio;
> +		}

[Severity: Medium]
Can stale entries in priv->xmit_qdisc.prio[] get written back to the
hardware?

This loop, and the one in tc_mqprio_config_queue_prio(), only update
prio[i] for i below the tx_queues_to_use value at that moment. With this
patch, stmmac_mac_config_tx_queues_prio() programs PSTQx/PSTC from the
shadow array on every open, where it used to read tx_queues_cfg[]:

stmmac_main.c:stmmac_mac_config_tx_queues_prio() {
	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
		stmmac_tx_queue_prio(priv, priv->hw,
				     priv->xmit_qdisc.prio[i], i);
}

With 8 TX queues from DT, each with snps,priority, this sequence looks
possible:

1) tc qdisc add ... mqprio num_tc 4 queues 1@0 1@1 1@2 1@3 hw 1 mode channel
   tc_mqprio_config_queue_prio() sets prio[4..7] = 0
2) ethtool -L <dev> tx 4
   tx_queues_to_use becomes 4
3) tc qdisc del ...
   stmmac_reset_tc_mqprio() restores only prio[0..3]
4) ethtool -L <dev> tx 8
   stmmac_open()->stmmac_hw_setup()->stmmac_mtl_configuration()->
   stmmac_mac_config_tx_queues_prio() writes 0 for queues 4..7

After that, queues 4..7 keep a zero priority map in place of their DT
values until the driver is re-probed.

The follow-up commit "net: stmmac: align real_num_tx_queues to mqprio
configuration" makes stmmac_reinit_queues() reject tx_cnt below
xmit_qdisc.num_tx_queues while mqprio is enabled. That covers shrinking
below the TC queues. Shrinking to exactly num_tx_queues is still allowed,
though, so step 2 still works at the end of the series.

Should the restore loop here cover all MTL_MAX_TX_QUEUES entries?

> +
> +		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> +					      priv->plat->tx_sched_algorithm);
> +		priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
> +		priv->xmit_qdisc.prio_offload = false;
> +	}
> +
>  	netdev_reset_tc(ndev);
>  	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
>  
>  	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
>  }
>  
> +static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
> +					struct tc_mqprio_qopt *qopt)
> +{

[ ... ]

> +		stmmac_tx_queue_prio(priv, priv->hw, prio, i);
> +		priv->xmit_qdisc.prio[i] = prio;
> +	}
> +
> +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
> +	priv->xmit_qdisc.algo = MTL_TX_ALGORITHM_SP;
> +	priv->xmit_qdisc.prio_offload = true;
> +}

[Severity: Medium]
This is a pre-existing issue, but is it safe to access the MTL registers
here without a runtime PM reference?

stmmac_setup_tc() passes TC_SETUP_QDISC_MQPRIO to
stmmac_tc_setup_mqprio() without calling pm_runtime_resume_and_get().
While the interface is down, stmmac_runtime_suspend() can gate
stmmac_clk and pclk through stmmac_bus_clks_config(priv, false).

A tc qdisc add or del on a down interface would then reach
stmmac_tx_queue_prio() and stmmac_prog_mtl_tx_algorithms() here, and in
the prio_offload block of stmmac_reset_tc_mqprio(), with those clocks
off.

This path already did unguarded MMIO before this patch, through
dwmac5_fpe_map_preemption_class():

	val = readl(priv->ioaddr + GMAC5_MTL_FPE_CTRL_STS);

Other register-touching ndos in this driver, such as set_mac_address and
the VLAN add/kill ops, call pm_runtime_resume_and_get() first.

The xmit_qdisc shadow is reapplied on open. Could the register writes be
skipped when !netif_running(), or could a PM reference be taken around
them?

> +
> +static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
> +					struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct plat_stmmacenet_data *pdata = priv->plat;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	int i;
> +
> +	if (!priv->dma_cap.dcben) {
> +		NL_SET_ERR_MSG_MOD(mqprio->extack,
> +				   "hw DCB is required to offload mqprio");
> +		return -EOPNOTSUPP;
> +	}

[ ... ]

> +	for (i = 0; i < qopt->num_tc; i++) {
> +		/* The offload switches the MTL scheduler to strict
> +		 * priority, which only supports a 1:1 TC to TX queue
> +		 * mapping.
> +		 */
> +		if (qopt->count[i] > 1 || qopt->offset[i] != i) {
> +			NL_SET_ERR_MSG_MOD(mqprio->extack,
> +					   "SP requires 1:1 TXQ map");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
This is a pre-existing issue, but should channel mode reject shaper and
rate requests?

In channel mode, mqprio_enable_offload() in net/sched/sch_mqprio.c
copies the flags, shaper, min_rate[] and max_rate[] into struct
tc_mqprio_qopt_offload. If the driver returns 0, it sets hw_offload and
later dumps TCA_MQPRIO_SHAPER.

tc_setup_dwmac510_mqprio() only checks TC_MQPRIO_F_MODE, and this
validator does not check TC_MQPRIO_F_SHAPER, TC_MQPRIO_F_MIN_RATE or
TC_MQPRIO_F_MAX_RATE.

So a request like "mqprio ... hw 1 mode channel shaper bw_rlimit
max_rate ..." with a 1:1 mapping succeeds. Only SP and PSTQ get
programmed, and the qdisc reports rate limiting the hardware isn't
doing.

The baseline handler ignored mode and flags entirely. Would this new
validator be a good place to return -EOPNOTSUPP for those flags?

[ ... ]

> @@ -1306,6 +1405,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  		num_tx_queues += qopt->count[i];
>  	}

[Severity: Medium]
This is a pre-existing issue, but is num_tx_queues too small when the
queue ranges have gaps?

mqprio_validate_queue_counts() does not require the ranges to be
contiguous from queue 0. Here num_tx_queues is the sum of the counts,
not the highest offset + count.

On a 4 queue device, a DCB request with a single TC at 1@2 passes both
that check and the new offset + count check in this function. It then
calls netif_set_real_num_tx_queues(ndev, 1), and netif_setup_tc() does:

	/* If TC0 is invalidated disable TC mapping */
	if (res.offset + res.count > txq) {
		netdev_warn(dev, "Number of in use tx queues changed invalidating tc mappings. Priority traffic classification disabled!\n");
		WRITE_ONCE(dev->num_tc, 0);
		return;
	}

The driver still returns 0, so mqprio reports a working offload while
the device runs on one queue with no TC mapping. With 1@0 1@2, the
priorities for TC1 are quietly remapped to TC0 instead.

The baseline code computed num_tx_queues the same way. Should this use
the highest offset + count, or reject non-contiguous ranges?

>  
> +	mode = mqprio->flags & TC_MQPRIO_F_MODE ? mqprio->mode
> +						: TC_MQPRIO_MODE_DCB;
> +	if (mode == TC_MQPRIO_MODE_CHANNEL) {
> +		err = tc_mqprio_validate_chan_mode(priv, mqprio);
> +		if (err)
> +			return err;
> +	}

[Severity: Medium]
Does a DCB mode request clean up after a previous channel mode
offload?

The xmit_qdisc state is only restored in stmmac_reset_tc_mqprio(),
which runs only when num_tc is 0. When tc_setup_dwmac510_mqprio() is
called with num_tc > 0 and mode resolves to TC_MQPRIO_MODE_DCB, nothing
touches priv->xmit_qdisc. A prior channel mode configuration therefore
leaves three things behind: xmit_qdisc.algo stays at
MTL_TX_ALGORITHM_SP, xmit_qdisc.prio_offload stays set, and the channel
mode PSTQx/PSTC maps stay programmed in the hardware.

One way to get here is replacing a channel mode mqprio with a DCB one
under a new handle. qdisc_graft() runs mqprio_init() for the new qdisc,
and so the driver offload, before mqprio_destroy() of the old qdisc
calls back with num_tc 0.

With this patch, dwmac5_fpe_map_preemption_class() tests
xmit_qdisc.algo instead of plat->tx_sched_algorithm. So on that path, a
valid DCB request with a TC spanning more than one queue is rejected
with ALG_ERR_MSG, even when DT selected a non-SP algorithm.

Any DCB request that arrives without an intervening reset has the same
problem. The MTL scheduler stays in SP with the old priority maps, and
tc_setup_cbs() keeps refusing CBS because prio_offload is still true.
That contradicts the commit message, which says DCB mode leaves the
scheduler and per-queue priorities to the device-tree configuration.

Could the prio_offload restore block in stmmac_reset_tc_mqprio() be
moved into a helper and also called on the DCB path, before
stmmac_fpe_map_preemption_class() runs? If so, the error unwind in
tc_setup_dwmac510_mqprio() would need to put the channel mode state
back when the FPE mapping fails. How would you prefer to handle that?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024%40oss.qualcomm.com
