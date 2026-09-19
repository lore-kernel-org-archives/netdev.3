Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F823A564;
	Sat, 19 Sep 2026 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801646; cv=none; b=IGZSh/ND+GUU4o8YBkoZEaeTqWgcAkj5F0Dx8/+djiydoHZHrbs0zzZMslSM8iDTlue1Agd2JFFh+T6j2JVUBNRTH1eRVThe1EF9u/FjdgcoacEiid0oiFkglsS/N+i9whb0lPYgkO2cBEDnoxhx7CJL3ZEKkxhtdW3z0KcOdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801646; c=relaxed/simple;
	bh=UuAiziJQ7jUR9Hs4MfZ2fDx01IZDG0HMPDzgeBCK8jo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oW1x6YIthXdb6rUFmL85fODxDawh90abmyai2zxiGyGEfGm/ePeKCB3dRUyoFw7SkTV9nY7oLKUrmob8x9lYXj6JRr+xArHHNyitxftLul/r1qOQVDrfI0P5qdsL796usmfoI7q9pIrXMhygl1Kufki4YpVsUD/rGqqw1IUIqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbbIolUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbbIolUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3521F000FF;
	Sat, 19 Sep 2026 07:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789801643;
	bh=fg9pzTRQqTxGPeP+l+DNgdI7aLXlmCXgMH31d30VGAw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gbbIolUWpEI055o3LOXb9tXISz5bNot5E1nCK2SHCPtNwqyhp5ycV5K57c43JtxF7
	 weQwoC0JdEUsHA4j8kZBtZDwp35YRquJ3O/MyjI6/ILGL4+SrBXZ2uEKunC0/o6sWQ
	 CASFDh0smW2wbLdqdaxzVdO05HViTqLE9w0ADA3Ou2keOG6U4YZk03NyVacm/JlT1K
	 2OUn8xfRGnerSrqokV/szGJ7MqNTbLS1O0pzTRBRRWzMhvnMdRzADfHPM7Svsk5Uue
	 98n96/UdRiiOsVuPt/9DGv5mFNBMes5rAcDftwFbexwF/AFBBH/Swt9TaA+AJEJsXo
	 jT+b+38h66Mkg==
Subject: Re: [PATCH net-next v8 1/2] net: ti: icssg-prueth: Add Frame
 Preemption MAC Merge support
From: netdev-bot+sashiko@kernel.org
To: m-malladi@ti.com
Cc: elfring@users.sourceforge.net, philippe.schenker@impulsing.ch,
 vadim.fedorenko@linux.dev, haokexin@gmail.com, devnexen@gmail.com,
 horms@kernel.org, jacob.e.keller@intel.com, arnd@arndb.de, afd@ti.com,
 parvathi@couthit.com, basharath@couthit.com, vladimir.oltean@nxp.com,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com
Date: Sat, 19 Sep 2026 07:07:22 +0000
Message-ID: <178980164223.22033.3811733445292602987@kernel.org>
In-Reply-To: <20260915063052.2274986-2-m-malladi@ti.com>
References: <20260915063052.2274986-2-m-malladi@ti.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 2

- [Medium] emac_tc_setup_mqprio() commits all software state (netdev TC
  mapping via netdev_set_num_tc()/netdev_set_tc_queue(),…
- [Medium] icssg_iet_set_preempt_mask() builds EXPRESS_PRE_EMPTIVE_Q_MASK
  (0x0029) from scratch (`int prempt_mask = 0`) and only ORs in BIT(i)…
- [Medium] icssg_config_ietfpe() and icssg_qos_link_state_update() gate
  all FPE work on a single lockless READ_ONCE(emac->link) check, but…
- [Low] Concern (validated as a FALSE POSITIVE for the series): the FPE
  enable path added in icssg_qos.c (icssg_config_ietfpe() enable branch,…
- [Low] Unbalanced mutex lifecycle across the two ICSSG drivers:
  mutex_init(&emac->qos.iet.fpe_lock) is performed only by…

--

net: ti: icssg-prueth: Add Frame Preemption MAC Merge support

This adds a QoS submodule to the ICSSG driver that programs IET Frame
Preemption in firmware, tracks the MAC Merge verify state machine, and
maps mqprio traffic classes to express/preemptible queues.  FPE state is
re-driven on link up/down and serialized with a new per-port fpe_lock.

A few questions about the new code below.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 4a7d1a6f470b1..d59eef61e7012 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -1754,6 +1754,7 @@ void prueth_netdev_exit(struct prueth *prueth,
>  
>  	netif_napi_del(&emac->napi_rx);
>  
> +	mutex_destroy(&emac->qos.iet.fpe_lock);

[Severity: Low]
prueth_netdev_exit() is shared by both ICSSG drivers, but the matching
mutex_init() only happens in icssg_qos_init(), which is called from
prueth_netdev_init() in icssg_prueth.c.

icssg_prueth_sr1.c has its own static prueth_netdev_init() that never
calls icssg_qos_init(), yet it reaches this teardown from both its probe
unwind path and prueth_remove().  Does that mean every SR1 emac has its
fpe_lock destroyed without ever being initialized?

Since alloc_etherdev_mq() zeroes the private area, mutex_destroy() only
sees owner == 0 today (and it is an empty inline without
CONFIG_DEBUG_MUTEXES), so nothing warns.  Would it be cleaner to
initialize the lock in the same layer that destroys it, so that any
future shared code in icssg_common.c taking fpe_lock does not end up
locking an uninitialized mutex on SR1?

>  	pruss_release_mem_region(prueth->pruss, &emac->dram);
>  	free_netdev(emac->ndev);
>  	prueth->emac[mac] = NULL;

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..283be27a240e9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -357,11 +357,11 @@ static void emac_adjust_link(struct net_device *ndev)
>  		}
>  		if (!emac->link) {
>  			new_state = true;
> -			emac->link = 1;
> +			WRITE_ONCE(emac->link, 1);
>  		}
>  	} else if (emac->link) {
>  		new_state = true;
> -		emac->link = 0;
> +		WRITE_ONCE(emac->link, 0);
>  
>  		/* f/w should support 100 & 1000 */
>  		emac->speed = SPEED_1000;
> @@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
>  		} else {
>  			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>  		}
> +
> +		icssg_qos_link_state_update(ndev);
>  	}

[Severity: Medium]
emac->link is written here from the phylib state machine under
phydev->lock only, while the FPE path gates on it with a single lockless
read in icssg_config_ietfpe():

	if (!READ_ONCE(emac->link)) {
		netdev_dbg(ndev, "cannot change IET/FPE state when interface is down\n");
		return 0;
	}

Can the link drop while icssg_config_ietfpe() is mid-transaction?

CPU0 (tc mqprio or ethtool) holds fpe_lock, observes link == 1, writes
PRE_EMPTION_ENABLE_TX = 1 and PRE_EMPTION_ENABLE_VERIFY = 1, sends
ICSSG_EMAC_PORT_PREMPT_TX_ENABLE and then sleeps in
icssg_iet_verify_wait() for up to ICSSG_IET_VERIFY_ATTEMPTS *
verify_time_ms (384 ms at the default of 128).

CPU1 (phylib work) runs emac_adjust_link():

	WRITE_ONCE(emac->link, 0);
	...
	icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
	icssg_qos_link_state_update(ndev);	/* blocks on fpe_lock */

so CPU0 keeps enabling FPE on a port that firmware has already disabled,
and if PRE_EMPTION_ACTIVE_TX still reads 1 it sets fpe_active = true.

When CPU1 finally takes fpe_lock, icssg_qos_link_state_update() only
clears fpe_active and verify_status and resets the queue maps.  Should it
also clear PRE_EMPTION_ENABLE_TX and PRE_EMPTION_ENABLE_VERIFY, so the
firmware configuration and the driver's view do not diverge?

Also, prueth_emac_common_start() still contains a plain

	emac->link = 0;

store outside both phydev->lock and fpe_lock, so the annotations added
here do not cover every writer.  Was that store meant to be converted
too?

>  
>  	if (emac->link) {

[ ... ]

> @@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
>  
>  	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
>  
> +	icssg_qos_init(ndev);
> +
>  	ret = pruss_request_mem_region(prueth->pruss,
>  				       port == PRUETH_PORT_MII0 ?
>  				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 0000000000000..27a953d981538
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,305 @@

[ ... ]

> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt *qopt = &p_mqprio->qopt;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int prempt_mask = 0, i;
> +	u8 tc, num_tc;
> +
> +	if (!iet->preemptible_tcs)
> +		goto reset_hw;
> +
> +	if (iet->fpe_active) {
> +		/* Reset all Q_MAP entries first to clear any stale preemptible
> +		 * entries from a prior wider TC mapping.
> +		 */
> +		for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
> +			writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +
> +		/* Configure queues for user requested preemptible tc map */
> +		num_tc = p_mqprio->qopt.num_tc;
> +		for (tc = 0; tc < num_tc; tc++) {
> +			/* check if the tc is preemptive or not */
> +			if (iet->preemptible_tcs & BIT(tc)) {
> +				/* Set the queues as preemptive queues */
> +				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +					writeb(BIT(4),
> +					       config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				}
> +			} else {
> +				/* Accumulate express queue bits for the mask */
> +				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
> +					prempt_mask |= BIT(i);
> +			}
> +		}
> +		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);

[Severity: Medium]
prempt_mask starts at zero and only accumulates queues belonging to
non-preemptible traffic classes, but this writeb() replaces the whole
eight-bit queue mask.  Are the queues that no traffic class maps to
handled correctly here?

With the default emac->tx_ch_num == 1 (real_num_tx_queues == 1) and
preemptible_tcs == BIT(0), the sequence programmed is:

	Q_MAP[0]  = BIT(4)	/* preemptible */
	Q_MAP[1..7] = 0		/* express */
	Q_MASK    = 0x00	/* no queue is express */

The reset path a few lines below defines the opposite encoding for the
same registers:

	/* Reset to default: all queues as express */
	for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
		writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
	writeb(ICSSG_EXPRESS_Q_MASK_ALL, config + EXPRESS_PRE_EMPTIVE_Q_MASK);

so Q_MAP == 0 together with Q_MASK == 0xFF means express, while the
active path leaves those same entries at Q_MAP == 0 with their Q_MASK bit
cleared.  Should the bits for queues outside the mqprio map stay set?

Gaps below real_num_tx_queues are reachable as well.
mqprio_validate_queue_counts() in net/sched/sch_mqprio_lib.c only
requires counts to be non-zero, within real_num_tx_queues and
non-overlapping:

	if (qopt->offset[i] >= dev->real_num_tx_queues ||
	    last > dev->real_num_tx_queues) {

It does not require the map to start at queue 0 or to be contiguous.
Queues used outside the TC map (QUEUE_NUM_UNTAGGED,
SPL_PKT_DEFAULT_PRIORITY, and the XDP/XSK path which picks
cpu % emac->tx_ch_num) are the ones that end up with a Q_MAP and Q_MASK
that disagree.

> +		return;
> +	}
> +
> +reset_hw:
> +	/* Reset to default: all queues as express */
> +	for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
> +		writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +	writeb(ICSSG_EXPRESS_Q_MASK_ALL, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +}

[ ... ]

> +void icssg_qos_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	mutex_init(&iet->fpe_lock);
> +	/* Set default values to prevent garbage values during .get_mm() */

[Severity: Low]
This isn't a bug, but this comment (and the similar one in
icssg_qos_link_state_update()) refers to .get_mm(), which is only added
to icssg_ethtool_ops by the following patch in the series.

Within this patch alone nothing writes iet->fpe_enabled or
iet->mac_verify_configure, and mqprio_parse_tc_entries() rejects
TC_FP_PREEMPTIBLE while ethtool_dev_mm_supported() is false, so the
enable side of icssg_config_ietfpe() is not yet reachable.

Could the changelog mention that the MAC Merge uAPI arrives in the next
patch, so the forward reference in these comments is not confusing on its
own?

> +	iet->verify_time_ms = ICSSG_IET_MAX_VERIFY_TIME;
> +	iet->tx_min_frag_size = ETH_ZLEN;
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_init);
> +
> +static int icssg_iet_change_preemptible_tcs(struct prueth_emac *emac)
> +{
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +
> +	mutex_lock(&iet->fpe_lock);
> +	if (!iet->fpe_enabled && !iet->preemptible_tcs) {
> +		mutex_unlock(&iet->fpe_lock);
> +		return 0;
> +	}
> +	ret = icssg_config_ietfpe(emac->ndev, iet->fpe_enabled);
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	return ret;
> +}

[ ... ]

> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
> +{

[ ... ]

> +	if (!qopt->num_tc) {
> +		netdev_reset_tc(ndev);
> +	} else {
> +		netdev_set_num_tc(ndev, qopt->num_tc);
> +
> +		for (tc = 0; tc < qopt->num_tc; tc++) {
> +			count = qopt->count[tc];
> +			offset = qopt->offset[tc];
> +			netdev_set_tc_queue(ndev, tc, count, offset);
> +		}
> +	}
> +
> +	mutex_lock(&iet->fpe_lock);
> +	if (!qopt->num_tc) {
> +		iet->preemptible_tcs = 0;
> +	} else {
> +		memcpy(&p_mqprio->qopt, qopt, sizeof(*qopt));
> +		iet->preemptible_tcs = mqprio->preemptible_tcs;
> +	}
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	netdev_dbg(ndev, "dev->num_tc %u dev->real_num_tx_queues %u\n",
> +		   ndev->num_tc, ndev->real_num_tx_queues);
> +
> +	return icssg_iet_change_preemptible_tcs(emac);

[Severity: Medium]
By the time this runs, the netdev TC mapping, p_mqprio->qopt and
iet->preemptible_tcs have all been committed, and a failure is returned
straight to mqprio_init() with no rollback.

icssg_config_ietfpe() can genuinely fail:

  - icssg_set_port_state() returns -ETIMEDOUT when the firmware R30
    command is not acknowledged within the read_poll_timeout() window
  - the function returns -EIO when PRE_EMPTION_ACTIVE_TX != 1, or when
    icssg_iet_verify_wait() reports ICSSG_IETFPE_STATE_FAILED or times
    out

On that failure path mqprio_init() aborts, and since priv->hw_offload was
never set, mqprio_destroy() takes the non-offload branch:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

so the driver is never called back.  Does emac->qos.iet.preemptible_tcs
and emac->qos.mqprio.qopt then describe a qdisc that does not exist?

If so, icssg_qos_link_state_update() -> icssg_iet_change_preemptible_tcs()
will re-apply that state on every subsequent link-up, using offsets and
counts that were validated against a real_num_tx_queues value which may
have changed since (ethtool -L).  Should the software state be rolled
back when the firmware configuration fails?

> +}

[ ... ]

> +void icssg_qos_link_state_update(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +
> +	if (!READ_ONCE(emac->link)) {
> +		/* Clear FPE active state on link-down so get_mm() reports
> +		 * accurate tx_active and verify_status while link is down.
> +		 */
> +		mutex_lock(&iet->fpe_lock);
> +		iet->fpe_active = false;
> +		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +		icssg_iet_set_preempt_mask(emac);
> +		mutex_unlock(&iet->fpe_lock);
> +		return;
> +	}
> +
> +	ret = icssg_iet_change_preemptible_tcs(emac);
> +	if (ret)
> +		netdev_dbg(ndev, "IET FPE %s failed\n",
> +			   str_enable_disable(iet->fpe_enabled));
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915063052.2274986-1-m-malladi%40ti.com
