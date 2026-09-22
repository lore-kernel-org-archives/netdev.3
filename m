Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAD3AE1AF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077337; cv=none; b=Ivk5LGTOmI42jeXEbaoVAdq5bSsl+jSMX9B0d22IT0i+IUPTdMuU2tYBEfjm3YIyHT/FR1bEGVEmDeB1UUQP/yyKN/Cy8IYD5tLI9nLrTi2DI9g1UG6kkfz2HE7eFzsYh6FnHpVbCQRRZUa6kupgpkFNFkMCtnh3CDJkCkI46mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077337; c=relaxed/simple;
	bh=gQThMzmppr8DvzQ1H4TwTbftx+8gbZcmHLEIzYyI+eg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfaE7AsEGO9oEw0CdGc7KqkdS7uMpIgkAg3O89PXbMbHRytrnKFSdcMFmXGWyiJ4Qx5qTlW1oNE/M9fA4VRfwNZ0CZqfQRhXGQDu2+BjRVxc8qcOh4eEueDovqqXX7IgLl+cZzk43Pu9u7Wiji4QJs2LprLqeGzM1lIE9Th/6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea6g8zMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea6g8zMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A761F000FF;
	Tue, 22 Sep 2026 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077335;
	bh=jIgkbH9tnLjhPK6n9LDroFNkRjLm4eII85arKy/oCjY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ea6g8zMdHi/HcqVGLiWcHllygfwMVrmVpUzsXt4Glx3D/JbnkQyy1Lj8PrKJrHJ7O
	 WZNUTEiOPed/swjRqEOiXFRpiQN/s2wXuS00ZAcMH3/BCG+7xkco3KNDjkp+oEFHjY
	 pRf6rkboa9BD6xSxPWJoFtlJIjI8Llchv4wVOPGboTAq9hvG3hCurvTw5NwpuNWA/K
	 ihxOThRroBi4KYd91EJiTgULv4pwTqcaxQmGp1bVNS0mO5PESTzn73jnvN7aCDi4gQ
	 pmBhjH/gym02M5b5SbPoHiK8PixQgYm35yBDvj1/FsUF+fQrpKLE3qp3FkHDzlNWr4
	 rKBBrgYPmX1Zg==
Subject: Re: [PATCH net-next] net: stmmac: add tc-mqprio qdisc offload
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, daniel@riscstar.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dcaratti@redhat.com
Date: Tue, 22 Sep 2026 11:42:13 +0000
Message-ID: <179007733391.2160803.15760096543003194202@kernel.org>
In-Reply-To:
 <20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com>
References:
 <20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] One-directional AVB/CBS rejection: tc_setup_dwmac510_mqprio()
  rejects the mqprio offload if any TX queue is already MTL_QUEUE_AVB…
- [Medium] The patch narrows an mqprio offload that already existed,
  breaking configurations the driver accepted before, and the commit…
- [Medium] The new per-TC offset validation bounds qopt->offset[i]
  against qopt->num_tc (stmmac_tc.c:1340-1343, extack 'TX queue range…
- [Medium] Replacing an offloaded mqprio qdisc makes the old qdisc's
  teardown wipe the replacement's just-installed hardware state.
- [Medium] The new mqprio setup and teardown paths perform read-modify-
  write MMIO from ndo_setup_tc without a runtime-PM reference and…
- [Medium] XGMAC index mismatch: the loop at stmmac_tc.c:1367-1390
  resolves, for each TX queue index i, the traffic class j that owns…

Pre-existing issues:
- [Medium] The mqprio offload accepts TC_MQPRIO_MODE_CHANNEL with
  TC_MQPRIO_SHAPER_BW_RATE and returns success while ignoring…

--

net: stmmac: add tc-mqprio qdisc offload

The patch implements tc-mqprio offload in stmmac by switching the MTL TX
scheduler to strict priority and programming each TX queue's PSTQX/PSTC
priority bitmask from qopt->prio_tc_map. The per-queue masks and the
scheduling algorithm are cached in the new priv->xmit_qdisc so they can be
re-applied on reopen, and teardown restores the devicetree configuration.

A few questions below about the new validation and register programming.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index c889204a7aa5..b6b5ef7c8fc4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -230,7 +230,7 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
>  		if (count == 1)
>  			continue;
>  
> -		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
> +		if (priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP) {
>  			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
>  			return -EINVAL;
>  		}

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c3..0c9083f8846e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -3604,7 +3598,7 @@ static void stmmac_mtl_configuration(struct stmmac_priv *priv)
>  	/* Configure MTL TX algorithms */
>  	if (tx_queues_count > 1)
>  		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> -				priv->plat->tx_sched_algorithm);
> +					      priv->xmit_qdisc.algo);
>  
>  	/* Configure CBS in AVB TX queues */
>  	if (tx_queues_count > 1)

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 42a00446e9b4..a2a9680da5c0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1265,6 +1265,23 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
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
> +
> +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> +				      priv->plat->tx_sched_algorithm);
> +	priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
>  
>  	netdev_reset_tc(ndev);
>  	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);

[Severity: Medium]
Can a qdisc replace end up undoing the offload that was just installed?

For "tc qdisc replace dev X root mqprio ... hw 1" on top of an already
offloaded mqprio, the core creates and offloads the new qdisc first, and
only then destroys the old one:

net/sched/sch_api.c:qdisc_graft() {
	...
	notify_and_destroy(net, skb, n, classid, old, new, extack);

	if (new && new->ops->attach)
		new->ops->attach(new);
}

qdisc_put(old) -> mqprio_destroy() -> mqprio_disable_offload() issues
num_tc == 0, which tc_setup_dwmac510_mqprio() forwards to
stmmac_reset_tc_mqprio().  That now rewrites the PSTQX priorities and the
MTL scheduling algorithm back to the devicetree values, and also resets
priv->xmit_qdisc, while mqprio_attach() does not re-apply the offload.

The result looks like the replacement qdisc reporting hw offload while the
MAC is back on the devicetree scheduler and priorities, and the stale
cached state is re-applied on the next open.  Should the reset path check
whether an offloaded mqprio is still installed before reprogramming?

[Severity: Medium]
Is it safe to touch these registers from ndo_setup_tc without a runtime PM
reference?

stmmac_reset_tc_mqprio() and the setup path both call
stmmac_tx_queue_prio() and stmmac_prog_mtl_tx_algorithms() unconditionally,
and those are read-modify-write accesses, e.g.:

drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:dwmac4_tx_queue_priority() {
	value = readl(ioaddr + base_register);

	value &= ~GMAC_TXQCTRL_PSTQX_MASK(queue);
	value |= (prio << GMAC_TXQCTRL_PSTQX_SHIFT(queue)) & ...;

	writel(value, ioaddr + base_register);
}

The driver drops its PM reference at the end of probe and in
stmmac_release(), and stmmac_runtime_suspend() gates the bus/CSR clocks via
stmmac_bus_clks_config(priv, false).  Adding or deleting an mqprio qdisc on
a down interface therefore reaches these accesses with the MAC clock
gated, where the readl can return an undefined value that is then written
back over the other queues' PSTQ fields and the other MTL_Operation_Mode
bits.

Other stmmac control paths that touch registers outside open (set_mac_address,
VLAN add/del) wrap the access in pm_runtime_get_sync()/pm_runtime_put().
Would a similar guard, or a netif_running() check, be appropriate here?
These writes also look redundant while the device is down, since
stmmac_mtl_configuration() re-applies priv->xmit_qdisc on the next open.

> @@ -1290,6 +1308,17 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
>  		return -EINVAL;
>  
> +	if (!priv->dma_cap.dcben)
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but since
the entry validation is being extended here: should mqprio->mode,
mqprio->shaper, mqprio->min_rate[] and mqprio->max_rate[] be rejected?

net/sched/sch_mqprio.c:mqprio_enable_offload() copies those into
tc_mqprio_qopt_offload for TC_MQPRIO_MODE_CHANNEL and relies on the driver
to refuse what it cannot do:

	case TC_MQPRIO_MODE_CHANNEL:
		mqprio.flags = priv->flags;
		...
		if (priv->flags & TC_MQPRIO_F_MAX_RATE)
			for (i = 0; i < mqprio.qopt.num_tc; i++)
				mqprio.max_rate[i] = priv->max_rate[i];

tc_setup_dwmac510_mqprio() only consumes qopt and preemptible_tcs, so
"mode channel shaper bw_rlimit max_rate ... hw 1" returns success and the
rate limits are echoed back to userspace without any shaping being
programmed.

[Severity: Medium]
Does this narrow an offload that already worked?

The baseline tc_setup_dwmac510_mqprio() validated only num_tc == 0 and
num_tc > ARRAY_SIZE(tc_to_txq).  The new !priv->dma_cap.dcben check, the
AVB-queue check below, and the count[i] > 1 check make configurations that
previously succeeded return -EOPNOTSUPP, including the FPE preemptible-TC
mapping part of the offload which is unrelated to the new priority
programming.

The count > 1 case looks like it was intentionally supported:

drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c:dwmac5_fpe_map_preemption_class() {
	...
		if (count == 1)
			continue;

		if (priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP) {
			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
			return -EINVAL;
		}

		queue_weight = priv->plat->tx_queues_cfg[offset].weight;
	...
}

That weight-checking branch becomes unreachable from the mqprio path now
that the algorithm is forced to SP before it runs.  Configurations such as
"mqprio ... queues 2@0 2@2 fp E P hw 1" lose the offload.

Additionally, forcing MTL_TX_ALGORITHM_SP overrides the devicetree
tx-sched-algorithm and the devicetree per-queue priority masks for every
mqprio user that is still accepted.  Should the commit message mention
these behaviour changes for existing users rather than describing them only
as offload requirements?

> +	/* Forcing strict priority conflicts with the CBS algorithm of AVB
> +	 * queues, so reject the offload when any queue is configured as AVB.
> +	 */
> +	for (i = 0; i < pdata->tx_queues_to_use; i++) {
> +		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB)
> +			return -EOPNOTSUPP;
> +	}
> +

[Severity: Medium]
Is this rejection effective in only one direction?

tc_setup_cbs() in the same file has no reciprocal check.  It validates the
queue index, priv->dma_cap.av and the slope parameters, then converts a DCB
queue into an AVB queue and programs the shaper:

	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
	if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
		...
		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;

Nothing there consults priv->xmit_qdisc.algo or netdev_get_num_tc(), so the
usual TSN order

  tc qdisc add dev X root mqprio ... hw 1
  tc qdisc replace dev X parent <mqprio child> cbs ... offload 1

succeeds and leaves the MAC in strict priority with a CBS/AVB queue, which
is the combination this new check and the commit message declare
unsupported.

The mismatch also survives a reopen, since stmmac_mtl_configuration()
programs the cached SP algorithm and then re-applies CBS:

	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, priv->xmit_qdisc.algo);
	/* Configure CBS in AVB TX queues */
	if (tx_queues_count > 1)
		stmmac_configure_cbs(priv);

Should tc_setup_cbs() carry the symmetric check on priv->xmit_qdisc.algo,
or is the mqprio-side rejection not needed?

> @@ -1299,6 +1328,20 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
>  
>  	for (i = 0; i < qopt->num_tc; i++) {
> +		/* The offload switches the MTL scheduler to strict priority,
> +		 * which only supports a 1:1 TC to TX queue mapping.
> +		 */
> +		if (qopt->count[i] > 1) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "SP sched requires 1:1 TXQ map");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (qopt->offset[i] >= qopt->num_tc) {
> +			NL_SET_ERR_MSG_MOD(extack, "TX queue range exceeded");
> +			return -EINVAL;
> +		}
> +

[Severity: Medium]
Should this bound be priv->plat->tx_queues_to_use rather than
qopt->num_tc?

num_tc is only limited by ARRAY_SIZE(tc_to_txq) here and by the core:

net/sched/sch_mqprio_lib.c:mqprio_validate_queue_counts() {
	...
		if (qopt->offset[i] >= dev->real_num_tx_queues ||
		    last > dev->real_num_tx_queues) {
	...
}

stmmac allocates the netdev with MTL_MAX_TX_QUEUES queues and only clamps
real_num_tx_queues to plat->tx_queues_to_use in stmmac_hw_setup(), so
before the first open a request like "mqprio num_tc 4 ... queues 1@0 1@1
1@2 1@3 hw 1" on a device with tx_queues_to_use == 2 passes both checks.

The priority programming loop below is bounded by pdata->tx_queues_to_use,
so the TCs with offset >= tx_queues_to_use never get a PSTQX/PSTC mask
while the offload still returns success, and netif_setup_tc() remaps those
priorities to TC0 at the next open.

The same check also rejects a sparse but otherwise legal map, e.g.
num_tc 2 with "queues 1@0 1@2".  Is that intentional?

> @@ -1315,14 +1358,44 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  	if (err)
>  		goto error_reset_tc;
>  
> +	priv->xmit_qdisc.algo = MTL_TX_ALGORITHM_SP;
>  	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
>  					      mqprio->preemptible_tcs);
>  	if (err)
> -		goto error_reset_num_tx_queues;
> +		goto error_reset_xmit_algo;
> +
> +	for (i = 0; i < pdata->tx_queues_to_use; i++) {
> +		u32 prio = 0;
> +		int j;
> +
> +		for (j = 0; j < qopt->num_tc; j++) {
> +			int p;
> +
> +			if (qopt->offset[j] != i)
> +				continue;
> +
> +			/* The PSTQX/PSTC priority map is 8 bits wide, so only
> +			 * priorities 0-7 can be represented in hardware.
> +			 * Priorities 8-15 are handled in software by the
> +			 * kernel through the netdev prio_tc_map.
> +			 */
> +			for (p = 0; p < 8; p++) {
> +				if (qopt->prio_tc_map[p] == j)
> +					prio |= BIT(p);
> +			}
> +			break;
> +		}
> +
> +		stmmac_tx_queue_prio(priv, priv->hw, prio, i);

[Severity: Medium]
Is the last argument the right index on XGMAC?

The mask computed here belongs to traffic class j, but the index passed to
stmmac_tx_queue_prio() is the queue index i.  For XGMAC the callback is:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_tx_queue_prio() {
	reg = (queue < 4) ? XGMAC_TC_PRTY_MAP0 : XGMAC_TC_PRTY_MAP1;
	...
	value &= ~XGMAC_PSTC(queue);
	value |= (prio << XGMAC_PSTC_SHIFT(queue)) & XGMAC_PSTC(queue);
}

XGMAC_PSTC() selects a traffic-class field in MTL_TC_Prty_Map0/1, while the
queue to TC association is programmed separately in XGMAC_Q2TCMAP:

drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c:dwxgmac3_fpe_map_preemption_class() {
	for (u32 i = 0; i < count; i++) {
		val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
		writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP), ...);
}

Both dwxgmac210 and dwxlgmac2 use dwmac510_tc_ops, and a permuted map such
as "mqprio num_tc 2 map ... queues 1@1 1@0 hw 1" passes both
intervals_overlap() in the core and the new offset < num_tc check.  In that
case TC0's mask would be written into the PSTC field of TC1 and vice versa.
Should the XGMAC path program PSTC using the TC index, or should
non-identity offsets be rejected?

> +		priv->xmit_qdisc.prio[i] = prio;
> +	}
> +
> +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
>  
>  	return 0;
>  
> -error_reset_num_tx_queues:
> +error_reset_xmit_algo:
> +	priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
>  	if (netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues))
>  		netdev_warn(ndev, "Failed to restore %u TX queues\n",
>  			    ndev_num_tx_queues);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58%40oss.qualcomm.com
