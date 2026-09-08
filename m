Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917B523787
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858593; cv=none; b=o8Y9/eNeb9qEMJPPTSDkWpWLopW7BoNqtgZvA3lFs1J6LlAapvqHueTpmvda8gphj1FCculNxZ526Ogj3fj1t9aMViPPCRVRRzFGjhDxBR8tlmc2hcTDUhgyRZmm0KyJi9p2dGi2+aF+eQWIjsOcjAUqGKKXYYLfRaloJx8w+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858593; c=relaxed/simple;
	bh=mleJnY3jg3i1trBgiPkAdtedpX4277SSVW0g7r4q15o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMhQutUYR4kH9tnB4nykrjl7ZRlJ2rsJMnGOxzxiIYmwXf7Wnl6d9OgUUC8XSww11kfc/E0lLZx7QnOAzbB/YLmXBbWROV+G9qOrfK8V8NMbWs22q8TQxd2jrU+PHX+fnUrwUC/tkSx0R0Xo1cMa3rByBkuxOQITWXqjbiQ2kKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQHiyRbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQHiyRbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EFE1F00A3E;
	Tue,  8 Sep 2026 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858592;
	bh=oR8pgGLcBuIzhfz4HFcqTtNs98M/cVbocTsR9l3INVg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PQHiyRbV321a4gha5dyw/SXGD3hcWm+Ld/ziej8ZQDZJvLhdoTjYVbP0WSRj87cvj
	 tGeP+dvEXt2S7vtw4Y2G0Mx+BzIVE355rYoUB1m+ASIxY15YRwpWVDaUHOSp/5x3iO
	 cJbntWGmRjTu6PWQChl8X8U9QNHB6nZkMzntOlXtT/81Qlm/ILbegq0BKQKw0D4Enk
	 CR3MEWnOW0Mz+FHGJVjHXrvl4524sqM9AORSh4PhoQpKoMKaiOxgLABrkTAcbkkovT
	 RCmGcIuatvjU6yufZS0y3OctsiIVCvhW1jgotF9j9QclO+3HpJZL8ay2mE+fbpnHnD
	 91s7XMaujeS5A==
Subject: Re: [PATCH net] net: stmmac: preserve real_num_tx_queues on mqprio
 setup failure
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 0x1207@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 08 Sep 2026 09:09:50 +0000
Message-ID: <178885859069.219967.17905742130775758644@kernel.org>
In-Reply-To: =?utf-8?q?=3C20260903-stmmac-tc=5Fsetup=5Fdwmac510=5Fmqprio-err?=
 =?utf-8?q?or-path-v1-1-eb171bdd340a=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20260903-stmmac-tc=5Fsetup=5Fdwmac510=5Fmqprio-erro?=
 =?utf-8?q?r-path-v1-1-eb171bdd340a=40oss=2Equalcomm=2Ecom=3E?=
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] The patch silently changes the semantics of the shared dispatch
  macro stmmac_fpe_map_preemption_class() in hwif.h from…
- [Medium] The TC state that the new error path saves and restores
  (num_tc via stmmac_set_ndev_tcs(), plus prio_tc_map) is immediately…

--

net: stmmac: preserve real_num_tx_queues on mqprio setup failure

This reworks tc_setup_dwmac510_mqprio() so that the previous num_tc,
tc_to_txq and prio_tc_map values are saved and restored on failure instead
of calling stmmac_reset_tc_mqprio(), and adds a stmmac_set_ndev_tcs()
helper.  It also switches the stmmac_fpe_map_preemption_class() dispatch
macro from stmmac_do_void_callback() to stmmac_do_callback().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 04dafec021b4..9314bcb85c22 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -494,7 +494,7 @@ struct stmmac_ops {
>  #define stmmac_set_arp_offload(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
>  #define stmmac_fpe_map_preemption_class(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
> +	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)

[Severity: High]
Should this macro conversion be called out in the commit message, and
possibly split into its own patch?  It changes the semantics of a shared
dispatch macro for all of its users, not only for the mqprio path.

stmmac_do_void_callback() forces the result to 0 whenever the op pointer is
populated, so before this patch the FPE callback return value was discarded
everywhere.  Two things seem to follow from that.

First, does the bug premise in the commit message hold for the tree the
Fixes: tag points at?  The message says:

  "In tc_setup_dwmac510_mqprio(), if stmmac_fpe_map_preemption_class()
   fails after the number of real TX queues has been set to
   num_tx_queues, the error path calls stmmac_reset_tc_mqprio()"

tc_setup_dwmac510_mqprio() is only reachable through dwmac510_tc_ops, and
every hwif.c entry that installs dwmac510_tc_ops pairs it with dwmac410_ops,
dwmac510_ops, dwxgmac210_ops or dwxlgmac2_ops, all of which populate
.fpe_map_preemption_class.  With the old void dispatch, that call could
therefore only evaluate to 0, so the described FPE failure path looks
unreachable before this patch.  The latent problem actually being fixed is
the swallowed callback error, which the message does not mention.

Second, the same macro is used by tc_taprio_configure():

drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:tc_taprio_configure() {
	...
	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
					      qopt->mqprio.preemptible_tcs);
	if (ret)
		goto disable;
	...
}

That "if (ret)" was dead code and becomes live here.  In
dwmac5_fpe_map_preemption_class():

drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c {
	...
		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
			return -EINVAL;
		}
	...
}

tx_sched_algorithm defaults to MTL_TX_ALGORITHM_SP for DT platforms in
stmmac_platform.c, and the default per-queue weights differ (0x10 + queue),
so a taprio or mqprio configuration with a preemptible TC owning more than
one TXQ now gets -EINVAL where it previously returned success with the
preemption-class register left unprogrammed.

For taprio, the new error also takes the disable label, which clears
priv->est->enable and reprograms EST, so the schedule that was just
installed is torn down.  Is that intended for configurations that used to be
accepted, for example:

  tc qdisc replace dev eth0 root taprio ... queues 2@0 2@2 ... fp E P

Also, the two remaining users that still ignore the now meaningful return
value, the taprio disable path and stmmac_reset_tc_mqprio(), were not
updated.  Should they be?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 14cabe76e53e..c99d9b7e26dc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1250,45 +1274,61 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
>  	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
>  					      mqprio->preemptible_tcs);
>  	if (err)
> -		goto err_reset_tc;
> +		goto error_reset_num_tx_queues;
>  
>  	return 0;
>  
> -err_reset_tc:
> -	stmmac_reset_tc_mqprio(ndev, extack);
> +error_reset_num_tx_queues:
> +	netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues);
> +error_reset_tc:
> +	stmmac_set_ndev_tcs(ndev, ndev_ntc, ndev_tc_to_txq);
> +	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
> +		netdev_set_prio_tc_map(ndev, i, ndev_prio_tc_map[i]);
>  
>  	return err;
>  }

[Severity: Medium]
Can this restore of num_tc, tc_to_txq and prio_tc_map ever be observed?

tc_setup_dwmac510_mqprio() with num_tc != 0 is only reached from
mqprio_enable_offload() inside mqprio_init(), and the error is returned
before hw_offload is recorded:

net/sched/sch_mqprio.c:mqprio_enable_offload() {
	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					    &mqprio);
	if (err)
		return err;

	priv->hw_offload = mqprio.qopt.hw;
}

qdisc_create() then always runs ops->destroy() on init failure:

net/sched/sch_api.c:qdisc_create() {
	if (ops->init) {
		err = ops->init(sch, tca[TCA_OPTIONS], extack);
		if (err != 0)
			goto err_out4;
	}
...
err_out4:
	if (ops->destroy)
		ops->destroy(sch);
}

and with hw_offload still 0 the else branch is taken:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

So dev->num_tc goes back to 0 immediately after the driver restored it, and
skb_tx_hash() ignores tc_to_txq and prio_tc_map when num_tc is 0.  On a
failing "tc qdisc replace" over an already offloaded mqprio, does the still
grafted old qdisc lose its priority classification anyway?

If so, should the commit message text

  "the TC-to-queue and priority-to-TC mappings are restored to the
   previously saved values"

be adjusted, since only the real_num_tx_queues part of the rollback appears
to survive?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-v1-1-eb171bdd340a%40oss.qualcomm.com
