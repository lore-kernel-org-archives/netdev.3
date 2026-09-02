Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D748A8C7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352238; cv=none; b=aar8YfZB1R0wEiIrvtE+4/q6foHe6FdlPbzGjqErtABLt4TcdYbssO6ZqjhEAqTjvXwS5qrNg/+0qZrtFk+li4iea5N1b1buZ5B9lJsWuOV+nSJgfulsb97WjsmXFnbikz46XkNVYnNcDBr0+RHfaOpjhzmVeLdUVvGmT/5QkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352238; c=relaxed/simple;
	bh=Nnl6h+r358Jddf2JOViERhf4+WwFvRfCCgcXZzB5kVc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuvXDBkLliwng3u9ZEHVPO+gATi5jJvHdvmZteIbGONJCiQS8buzIZ2iFBqb6O0IWJGeBjgYH+KINcCQ/PiiVI6uCVwPuCX1hFU8ORx2u6SyezgpA9+kDpBWQXAZilpEFJsJBto9KVm3h9u8wS/bGx3mCHzhJmVC1hWnviop0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDzKzbS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDzKzbS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6761C1F00A3A;
	Wed,  2 Sep 2026 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788352237;
	bh=bS7MkkCR+PKshdBB6qeSv27TTzCf00ngXtnP0pfB3X8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NDzKzbS2E1xK2bZorD5wu6HVkaPvBliwe++LusjUF9qhyU3DBEC4SAsJ2cxOvvA/b
	 7PevAGdtvwZxYi1IVsSyXPpaDepjqOelDoGfUPTC23pKrdaEnOwgwyu7Msd2Z4M5ia
	 7u8UQzB21dRsfck8QwFXN2R3vkp/NQU3eD8bG4n+smeZ3h+xlS/0I+XZZj6CN2t0OI
	 kP1zABynjQraPpqNbVm0ndNUOHigbxp5/3GZmgrM8kZ5P70EsI5QrT1aoontEFDda+
	 r4+XHlfoBxmSLFY3UtFdvSc8Ec5DZmpTDN23yL04s2k0fgxWa5aoqjanJ5xQNY04Vq
	 Ro36MaLUnCD3Q==
Subject: Re: [net,2/2] net: stmmac: preserve FPE preemption class across qdisc
 replacement
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 0x1207@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 02 Sep 2026 12:30:36 +0000
Message-ID: <178835223600.3394541.1445796464059666967@kernel.org>
In-Reply-To:
 <20260829-stmmac-fix-graft-overwrite-v1-2-a4f84c4c264e@oss.qualcomm.com>
References:
 <20260829-stmmac-fix-graft-overwrite-v1-2-a4f84c4c264e@oss.qualcomm.com>
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

Critical: 0 · High: 2 · Medium: 2 (1) · Low: 0

- [High] Incomplete fix: ownership of the FPE preemption class (and of
  the EST block) is tracked per qdisc *kind* (priv->qdisc_type) instead…
- [High] The patch also gates netdev_reset_tc() and the
  netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use)…
- [Medium] Reordering regression on XGMAC: in stmmac_reset_tc_mqprio()
  the stmmac_fpe_map_preemption_class(priv, ndev, extack, 0) call is now…
- [Medium] Lost error-path rollback in tc_taprio_configure(): the
  `disable:` tail now resets the FPE preemption class only when…

Pre-existing issues:
- [Medium] struct stmmac_ops::fpe_map_preemption_class is declared as
  returning int (drivers/net/ethernet/stmicro/stmmac/hwif.h:411-413),…

--

net: stmmac: preserve FPE preemption class across qdisc replacement

The patch adds a priv->qdisc_type field recording which root qdisc policy
(mqprio or taprio) is currently offloaded, and uses it to skip clearing the
FPE preemption class during teardown when the qdisc being destroyed is not
the one that programmed it. The mqprio reset path is additionally gated on
the same field.

A few questions about the new ownership tracking below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 7582fca63741..957317ec1461 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -258,6 +258,12 @@ struct stmmac_msi {
>  	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
>  };
>  
> +enum stmmac_qdisc_type {
> +	STMMAC_QDISC_NONE = 0,
> +	STMMAC_QDISC_MQPRIO,
> +	STMMAC_QDISC_TAPRIO,
> +};
> +

[Severity: High]
Is tracking the qdisc kind enough to identify the owner here?  The create-
then-destroy ordering the commit message describes also happens for a
same-kind replace when a different handle is used.  In
net/sched/sch_api.c:__tc_modify_qdisc():

	if (!q || !tcm->tcm_handle || q->handle != tcm->tcm_handle) {
		if (tcm->tcm_handle) {
			...
			q = qdisc_lookup(dev, tcm->tcm_handle);
			if (!q)
				goto create_n_graft;

so tc qdisc replace dev X root handle 8002: mqprio ... over an mqprio
installed at handle 8001: creates and offloads the new instance first and
destroys the old one afterwards, with both instances reporting the same
kind.

For mqprio -> mqprio, the new tc_setup_dwmac510_mqprio() stores
STMMAC_QDISC_MQPRIO, and the old instance's teardown then reaches
stmmac_reset_tc_mqprio() with qdisc_type == STMMAC_QDISC_MQPRIO, so it
clears the live qdisc's FPE class, calls netdev_reset_tc() and restores the
queue count, leaving qdisc_type == STMMAC_QDISC_NONE.

For taprio -> taprio, the new REPLACE stores STMMAC_QDISC_TAPRIO and the old
instance's TAPRIO_CMD_DESTROY satisfies the new guard, so
FPE_MTL_PREEMPTION_CLASS is cleared for the live qdisc.  The unconditional
disable: tail in tc_taprio_configure() also runs for that DESTROY:

	if (priv->est) {
		mutex_lock(&priv->est_lock);
		priv->est->enable = false;
		stmmac_est_configure(priv, priv, priv->est,
				     priv->plat->clk_ptp_rate);

which switches EST off (and zeroes the per-queue taprio stats) after the
replacing taprio has programmed its gate control list.  Would per-instance
identity (handle or a cookie/generation) be needed instead of the kind, and
should EST ownership be covered too?

>  struct stmmac_priv {
>  	/* Frequently used values are kept adjacent for cache effect */
>  	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index be8ddda2aa76..7fe587b47d52 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1120,7 +1122,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		mutex_unlock(&priv->est_lock);
>  	}
>  
> -	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
> +	if (priv->qdisc_type == STMMAC_QDISC_TAPRIO &&
> +	    qopt->cmd == TAPRIO_CMD_DESTROY) {
> +		stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
> +		priv->qdisc_type = STMMAC_QDISC_NONE;
> +	}

[Severity: Medium]
Does the added cmd == TAPRIO_CMD_DESTROY term drop the rollback on the
error path?  The disable: label is also reached with cmd ==
TAPRIO_CMD_REPLACE:

	ret = stmmac_est_configure(priv, priv, priv->est,
				   priv->plat->clk_ptp_rate);
	mutex_unlock(&priv->est_lock);
	if (ret) {
		netdev_err(priv->dev, "failed to configure EST\n");
		goto disable;
	}

est_configure() in stmmac_est.c can return -EINVAL when ptp_rate is 0, and
-ETIMEDOUT via the readl_poll_timeout() inside est_write().  For a failing
REPLACE on an already offloaded taprio (qdisc_type == STMMAC_QDISC_TAPRIO),
the block now disables EST but leaves the previously programmed
FPE_MTL_PREEMPTION_CLASS mask in the hardware, while taprio_change() has
already installed the new num_tc/tc_to_txq mapping.  Before the patch that
mask was cleared unconditionally.

Would the ownership test alone (qdisc_type == STMMAC_QDISC_TAPRIO) be
sufficient for the case described in the commit message?

>  
>  	return ret;
>  }
> @@ -1266,9 +1272,15 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
> -	netdev_reset_tc(ndev);
> -	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
> -	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
> +	if (priv->qdisc_type != STMMAC_QDISC_TAPRIO)
> +		stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
> +
> +	if (priv->qdisc_type == STMMAC_QDISC_MQPRIO) {
> +		netdev_reset_tc(ndev);
> +		netif_set_real_num_tx_queues(ndev,
> +					     priv->plat->tx_queues_to_use);
> +		priv->qdisc_type = STMMAC_QDISC_NONE;
> +	}
>  }

[Severity: High]
Can this leave real_num_tx_queues permanently reduced?  The commit message
only mentions gating the FPE preemption class, but the queue-count restore
is now gated too.

On an mqprio -> taprio root replace the taprio REPLACE offload runs first
and sets qdisc_type = STMMAC_QDISC_TAPRIO.  The old mqprio teardown
(mqprio_destroy() -> mqprio_disable_offload() with num_tc == 0 ->
stmmac_reset_tc_mqprio()) then takes neither branch, so the value programmed
earlier by tc_setup_dwmac510_mqprio() stays in place:

	ndev_num_tx_queues = ndev->real_num_tx_queues;
	err = netif_set_real_num_tx_queues(ndev, num_tx_queues);

where num_tx_queues is the sum of qopt->count[i], which
mqprio_validate_queue_counts() allows to be smaller than
plat->tx_queues_to_use.

Nothing appears to restore it afterwards: taprio_destroy() in
net/sched/sch_taprio.c only calls netdev_reset_tc(dev) and never touches
real_num_tx_queues, and the stmmac taprio DESTROY path only clears the FPE
class.  Recovery then requires an interface down/up so that
stmmac_hw_setup() re-runs netif_set_real_num_tx_queues().  Later tc
configurations would also be validated against the stale
dev->real_num_tx_queues.

Should the netdev TC/queue-count restore be kept independent of the FPE
ownership state, since the two resources have different owners?

[Severity: Medium]
Does the reordering here break the XGMAC default TXQ-to-TC restore?  The
FPE clear is now issued before netdev_reset_tc(ndev), while previously the
order was netdev_reset_tc() -> netif_set_real_num_tx_queues() -> FPE clear.

dwxgmac3_fpe_map_preemption_class() in stmmac_fpe.c restores the default
mapping only when the netdev already has no traffic classes:

	int num_tc = netdev_get_num_tc(ndev);

	if (!num_tc) {
		/* Restore default TC:Queue mapping */
		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
		}
	}

and the qdisc core does not clear dev->num_tc for an offloaded mqprio:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

So on tc qdisc del dev X root with an offloaded mqprio, num_tc is still
non-zero when the callback runs, the restore branch is skipped, and the MTL
Q2TCMAP keeps the grouping of the mqprio that is being torn down.  Could the
FPE clear stay after netdev_reset_tc()?

>  
>  static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
> @@ -1318,6 +1330,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  	if (err)
>  		goto error_reset_num_tx_queues;
>  
> +	priv->qdisc_type = STMMAC_QDISC_MQPRIO;
> +

[Severity: Medium]
This isn't a problem introduced by this patch, but can err here ever be
non-zero?  struct stmmac_ops declares

	int (*fpe_map_preemption_class)(struct net_device *ndev,
					struct netlink_ext_ack *extack,
					u32 pclass);

while the accessor in hwif.h goes through the void variant:

	#define stmmac_fpe_map_preemption_class(__priv, __args...) \
		stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)

stmmac_do_void_callback() discards the callback result and evaluates to 0
whenever the pointer is set.  dwmac5_fpe_map_preemption_class() does return
an error before programming FPE_MTL_PREEMPTION_CLASS:

	if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
		NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
		return -EINVAL;
	}

so with an SP scheduler (or mismatched TXQ weights inside a TC) the mapping
is rejected but reported as success.  With this patch, qdisc_type is then set
to STMMAC_QDISC_MQPRIO (and likewise to STMMAC_QDISC_TAPRIO in
tc_taprio_configure()) for a mapping that was never written to the hardware,
so the new ownership state describes hardware state that does not exist.
Would routing the accessor through stmmac_do_callback(), or making the ops
member void, be preferable before building ownership tracking on the return
value?

>  	return 0;
>  
>  error_reset_num_tx_queues:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e%40oss.qualcomm.com
