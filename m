Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED479488239;
	Fri, 25 Sep 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334878; cv=none; b=dCcHnaSHziJ3UckoTIHC4YqGZDGnDbBymzl2weBZRcOJ178ud7/XHgCArYl1z1ouTcBJc9EvMrrCOsn6JJTDITE+zfHNBdKdSpRVTC5EXLfgsVE4trRIaA4ilNKswpcxHDN2wgwu+L9K3cwOVl5X582VCWsiFYBHE4ODdlooPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334878; c=relaxed/simple;
	bh=M5SbBkU/off2MJ7wWwmuQjedwouJ5o41Y01FYo/mwS8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knCuqXkhBKaB5D1pGczcTkdALwxUDSlDtEMO/k/Qx9GG6GX+iMpOR1jNVUCmIWeKdoCxYAeVO0dKF5Rg8ysQDIjGNGZAL6ZIR35hyRYtq0yuWAERp3ihCr3mbrvVSqbOp2BwTcL1dw/q2rz/a3jbxPcXItnBiIJDEqpaaaugfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ixCppx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ixCppx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90C21F000FF;
	Fri, 25 Sep 2026 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334876;
	bh=s90dLDlyclE6Hx56goikB48IM8IWwygQ2g5ecA6OC0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G9ixCppxww9RDvJMThS55BBq423QMuGeOGWFKzaZzHfVwLvqE5HT0kP5hD/e1kiJW
	 b1Y4fhuZ+TnRjsA18z2GV8LnqqHFwNVtAkYFjFbsA9hUSqgOSuTV4YQwUtl+bpOYIv
	 W82Nz7F/FKS46PdhKE315/g3ylDZPCRQYUHNwgouIjg0SFndUWoG/E2eTpVN1aAWGN
	 k76C/AvKW+5EU31iVTl/DiD7De0cW8g6KEUWC2E+ssLnnf8h60vlaeQCt9YDoXpxcY
	 +d+cvV2bk5bqsKgSlHhmuNm39Ux8bsvcrv3SBcaqK54pOh5pBO815WzlIT3HNowvk4
	 AAs+A+pywu7Gw==
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: add tc mqprio hw queue
 priority offload
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, daniel@riscstar.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 11:14:35 +0000
Message-ID: <179033487534.2160803.9797144025494560939@kernel.org>
In-Reply-To:
 <20260924-stmmac-mqprio-prio-offload-v2-1-fdd8b69efccf@oss.qualcomm.com>
References:
 <20260924-stmmac-mqprio-prio-offload-v2-1-fdd8b69efccf@oss.qualcomm.com>
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

Critical: 0 · High: 1 · Medium: 2 (4) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a check to tc_setup_cbs() (stmmac_tc.c:349-350):
  `if (qopt->enable && priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP)…
- [Medium] stmmac_reset_tc_mqprio() now calls
  stmmac_prog_mtl_tx_algorithms() on every mqprio teardown (num_tc ==…
- [Medium] net: stmmac: hw state desynchronization on mqprio replacement
  error path
- [Low] tc_mqprio_validate_chan_mode() (stmmac_tc.c:1335-1344) returns a
  bare -EOPNOTSUPP in two new cases: when priv->dma_cap.dcben is clear,…

Pre-existing issues:
- [Medium] In channel mode, mqprio_enable_offload() (sch_mqprio.c) passes
  mqprio->flags, shaper, min_rate[] and max_rate[] to the driver.
- [Medium] Replacing an offloaded mqprio root with a new mqprio that uses
  a different handle goes through create_n_graft.
- [Medium] tc_setup_dwmac510_mqprio() computes num_tx_queues as the sum
  of qopt->count[] and not as the highest queue endpoint.
- [Medium] stmmac_setup_tc() dispatches TC_SETUP_QDISC_MQPRIO to
  tc_setup_dwmac510_mqprio() without pm_runtime_resume_and_get().

--

net: stmmac: add tc mqprio hw queue priority offload

This commit offloads the tc mqprio TX queue priority configuration in
stmmac. In channel mode it switches the MTL TX scheduler to strict
priority and programs each queue's priority bitmask from prio_tc_map. A
new xmit_qdisc state tracks the active scheduler and per-queue
priorities, and CBS offload is now rejected while that scheduler is SP.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 42a00446e9b4..54242461a860 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -346,6 +346,9 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.av)
>  		return -EOPNOTSUPP;
>  
> +	if (qopt->enable && priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP)
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
Can this error path leave xmit_qdisc.algo out of sync with the
hardware?

Say a channel mode mqprio is already offloaded. The MTL TX scheduler
is then programmed as SP, and xmit_qdisc.algo is MTL_TX_ALGORITHM_SP.
Now a second channel mode request arrives. One example is "tc qdisc
replace dev X root handle 2: mqprio ... mode channel hw 1", which
initializes the new qdisc while the old one is still installed.

tc_setup_dwmac510_mqprio() sets algo to SP early. If a later step
fails, the error path sets algo to priv->plat->tx_sched_algorithm.
The failing step could be stmmac_set_ndev_tcs(),
netif_set_real_num_tx_queues() or stmmac_fpe_map_preemption_class().
The value from before the call is never restored.

tc_mqprio_config_queue_prio() is never reached on that path. The
hardware is still in SP with the old qdisc's per-queue priorities,
and the old qdisc stays installed. But algo now holds whatever the
DT selected, for example WRR.

>From then on, the checks that rely on algo don't match the hardware:

  - tc_setup_cbs() would accept enabling CBS while the scheduler is
    still SP.
  - dwmac5_fpe_map_preemption_class() would accept a DCB mode mqprio
    with more than one queue per TC. A DCB request doesn't reprogram
    the scheduler, so the hardware would stay in SP.

The next stmmac_hw_setup() goes wrong in the other direction.
stmmac_mtl_configuration() programs the stale algo, while the old
channel mode qdisc is still installed and expects SP. That setup runs
on ifdown/ifup or resume.

Would it be better to save xmit_qdisc.algo on entry and restore that
value on failure? Another option is to set algo only once
tc_mqprio_config_queue_prio() has actually run. Is there a reason it
needs to be set before stmmac_fpe_map_preemption_class() is called?

[Severity: High]
Can this reject CBS offload on boards that never installed an mqprio
qdisc?

At probe, priv->xmit_qdisc.algo is copied from the platform data:

__stmmac_dvr_probe()
    priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;

stmmac_mtl_setup() sets that to SP when the DT has no snps,tx-sched-*
property:

stmmac_mtl_setup() {
    ...
	else if (of_property_read_bool(tx_node, "snps,tx-sched-dwrr"))
		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_DWRR;
	else
		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
    ...
}

This means SP set by the DT can't be told apart from SP forced by
channel mode mqprio. For example, imx8mp-evk has
snps,tx-queues-to-use = <5> and no tx-sched property. On that board,
"tc qdisc ... cbs ... offload 1" would now always fail with -EOPNOTSUPP.

dwmac4_tc_ops also uses tc_setup_cbs(), and its mqprio offload is
tc_setup_mqprio_unimplemented. So channel mode can't be the cause on
those parts.

The DT path still accepts SP together with CBS.
stmmac_mtl_configuration() programs CBS for AVB queues whatever the
scheduler is:

	/* Configure CBS in AVB TX queues */
	if (tx_queues_count > 1)
		stmmac_configure_cbs(priv);

The commit message says DCB mode leaves the scheduler to the devicetree.
It doesn't mention any change to CBS. The later patch in the series,
"net: stmmac: align real_num_tx_queues to mqprio configuration", doesn't
change tc_setup_cbs() either.

Could this check test whether channel mode offload is actually active,
for example with a separate flag, rather than the scheduler value?

[ ... ]

> @@ -1265,6 +1268,23 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
>  				  struct netlink_ext_ack *extack)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int i;
> +
> +	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> +		u32 prio;
> +
> +		if (priv->plat->tx_queues_cfg[i].use_prio)
> +			prio = priv->plat->tx_queues_cfg[i].prio;
> +		else
> +			prio = 0;
> +
> +		stmmac_tx_queue_prio(priv, priv->hw, prio, i);
> +		priv->xmit_qdisc.prio[i] = prio;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but is it safe to access
these registers while the device may be runtime suspended?

stmmac_setup_tc() dispatches TC_SETUP_QDISC_MQPRIO without calling
pm_runtime_resume_and_get(). stmmac_set_mac_address() and the VLAN
add/kill handlers do take that reference.

When the interface is down, the device can be runtime suspended.
stmmac_runtime_suspend()->stmmac_bus_clks_config(priv, false) then gates
stmmac_clk and pclk.

This path already did an unguarded read-modify-write of the FPE control
register through fpe_map_preemption_class. The new stmmac_tx_queue_prio()
and stmmac_prog_mtl_tx_algorithms() calls, here and in
tc_mqprio_config_queue_prio(), add more MMIO to it:

  - MAC_TxQ_Prty_Map / XGMAC_TC_PRTY_MAP
  - MTL_OPERATION_MODE
  - XGMAC_MTL_TCx_ETS_CONTROL on XGMAC

One way to hit this is "ip link set X down" followed by
"tc qdisc add/del ... mqprio ... hw 1".

> +
> +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> +				      priv->plat->tx_sched_algorithm);

[Severity: Medium]
Does this unconditional reprogramming drop CBS on AVB queues on XGMAC?

stmmac_reset_tc_mqprio() runs on every mqprio teardown. That includes
removing a DCB mode mqprio, which is still allowed when AVB queues
exist. XGMAC and XLGMAC use dwmac510_tc_ops, so this call reaches
dwxgmac2_prog_mtl_tx_algorithms(), which clears TSA on every TC:

	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
		value &= ~XGMAC_TSA;
		if (ets)
			value |= XGMAC_ETS;
		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
	}

That erases the TSA=CBS setting that dwxgmac2_config_cbs() wrote to the
same register. Before this patch, the only caller was
stmmac_mtl_configuration(), which calls stmmac_configure_cbs()
afterwards, so CBS was always written last.

After "tc qdisc del" of a DCB mqprio, AVB queues set up from the DT
(snps,avb-algorithm) would lose credit-based shaping in hardware.
tx_queues_cfg[q].mode_to_use still says MTL_QUEUE_AVB. This lasts until
the next stmmac_hw_setup().

Should the reset path reapply CBS for AVB queues? Or should it skip
reprogramming the scheduler when channel mode was never offloaded?

> +	priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;

[ ... ]

> @@ -1272,6 +1292,73 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,

[ ... ]

> +static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
> +					struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	int i;
> +
> +	if (!priv->dma_cap.dcben)
> +		return -EOPNOTSUPP;
> +
> +	/* Forcing strict priority conflicts with the CBS algorithm
> +	 * of AVB queues, so reject the offload when any queue is
> +	 * configured as AVB.
> +	 */
> +	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> +		if (priv->plat->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB)
> +			return -EOPNOTSUPP;
> +	}

[Severity: Low]
This isn't a bug, but could the dcben check and the AVB check set an
extack message, as the 1:1 mapping check below does? At the moment the
user only sees "Operation not supported". Missing DCB support looks the
same as a conflict with AVB queues set by the DT or by an earlier cbs
offload.

> +
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
This is a pre-existing issue, but should channel mode also reject shaper
and rate requests here?

In channel mode, mqprio_enable_offload() passes these through:

	case TC_MQPRIO_MODE_CHANNEL:
		mqprio.flags = priv->flags;
		...
		if (priv->flags & TC_MQPRIO_F_SHAPER)
			mqprio.shaper = priv->shaper;
		if (priv->flags & TC_MQPRIO_F_MIN_RATE)
			...
		if (priv->flags & TC_MQPRIO_F_MAX_RATE)
			...

Neither tc_mqprio_validate_chan_mode() nor tc_setup_dwmac510_mqprio()
checks TC_MQPRIO_F_SHAPER, TC_MQPRIO_F_MIN_RATE or TC_MQPRIO_F_MAX_RATE.
So "mode channel shaper bw_rlimit max_rate ..." is accepted and reported
as offloaded, but no rate limiting is programmed.

The old code also accepted channel mode without checking the shaper. Now
that this function validates channel mode, would it be the right place
to reject shaper != TC_MQPRIO_SHAPER_DCB?

> +
>  static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  				    struct tc_mqprio_qopt_offload *mqprio)
>  {
> @@ -1282,23 +1369,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,

[ ... ]

>  	for (i = 0; i < qopt->num_tc; i++) {
> +		if (qopt->offset[i] + qopt->count[i] >
> +		    priv->plat->tx_queues_to_use) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Queues exceed hw TX queues");
> +			return -EINVAL;
> +		}
> +
>  		tc_to_txq[i] = (struct netdev_tc_txq) {
>  			.count = qopt->count[i],
>  			.offset = qopt->offset[i],
> @@ -1306,6 +1392,24 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  		num_tx_queues += qopt->count[i];
>  	}

[Severity: Medium]
This is a pre-existing issue, but does adding up count[] give the right
real_num_tx_queues when the queue layout has gaps?

The core validation and the new offset + count <= tx_queues_to_use check
both allow gaps. Take 4 TX queues and a DCB request with num_tc=1,
count[0]=1, offset[0]=2. num_tx_queues becomes 1, and then:

tc_setup_dwmac510_mqprio()
  netif_set_real_num_tx_queues(ndev, 1)
    netif_setup_tc()
	/* If TC0 is invalidated disable TC mapping */
	if (res.offset + res.count > txq) {
		...
		WRITE_ONCE(dev->num_tc, 0);
		return;
	}

With preemptible_tcs == 0 the function still returns 0. The offload
reports success, but TC classification is disabled and only queue 0 is
used.

Would the highest offset + count avoid this, instead of the sum? The
later patch "net: stmmac: align real_num_tx_queues to mqprio
configuration" saves this same value in xmit_qdisc.num_tx_queues and
applies it on every open.

[ ... ]

> @@ -1320,6 +1424,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  	if (err)
>  		goto error_reset_num_tx_queues;
>  
> +	if (mode == TC_MQPRIO_MODE_CHANNEL)
> +		tc_mqprio_config_queue_prio(priv, qopt);
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but does this configuration
survive replacing an offloaded mqprio root with one that has a different
handle?

Take "tc qdisc replace dev X root handle 2: mqprio ... mode channel
hw 1" over an existing offloaded root 1:. qdisc_create() initializes the
new qdisc first. That reaches this call and programs SP and the queue
priorities.

qdisc_graft() then destroys the old qdisc:

qdisc_graft()
  notify_and_destroy()
    mqprio_destroy()
      mqprio_disable_offload()      /* num_tc = 0 */
        tc_setup_dwmac510_mqprio()
          stmmac_reset_tc_mqprio()

That resets the scheduler, the per-queue priorities and xmit_qdisc to
the platform defaults. mqprio's ->attach doesn't offload again, and
stmmac doesn't handle TC_SETUP_ROOT_QDISC. The replace reports success,
but the new qdisc's channel configuration is gone.

Before this patch, the same ordering already wiped the netdev TC map,
real_num_tx_queues and the FPE mapping. This patch adds the scheduler
and priority state to what gets lost.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf%40oss.qualcomm.com
