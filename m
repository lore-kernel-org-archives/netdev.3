Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBB4A3860;
	Thu, 10 Sep 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052876; cv=none; b=q6vBhvatblqIUVHY7eO0J7OrIxwKYqAKWpgqWYOWl1ksgpRu78NawOgsRH0Kp0mDfvo7GcdoplErGIgLAI2cpp3Wl1e2C/ekD/xwrB2IyvUjf2b4DPFIwxxZQy4BWbq9sPxVxybVmrGnDp9xzJoAGwdbj6hp8u7X/Mj/ZIM/Udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052876; c=relaxed/simple;
	bh=xBFnHWGK44hgcZvr1ZxtbLbA5wzSrzC+sOWiamIxjhs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9U+CjxNzDHInO/3/PEMVQg5uACKmgnsUXM2NRw08tBws1AIVSWuVLX+yVLzQTHZvhj9BWz8ZbNnwEsnDBlNq4xyi+IThTlF/AqzeBKg3wzVyJnXdZ7FF1MOdFiq1K9YmTCzEbyw02R0aBRzQ1+sn9CAxUT7rg3tPHzqigdW4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhXrpgUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhXrpgUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CDD1F000FF;
	Thu, 10 Sep 2026 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052867;
	bh=0a6DXeYoRSPuJf/o8KnFdkoa/npQEF065gLl5JrA1JA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lhXrpgUDoJY7c7QVQt7dF3vexkhUKmkGoMt+FhqLCR9l0DNi87GGdWquGIXgSZx8o
	 UilAhO64RIwNgog3wOQMqRwHYTb7orPt5otypa7jKjvQGBu2/l87DrQQb1noWGknVB
	 RVhrQKyran3lvhL1JRzrcx1x4+H5oT6y/WJTCYajo+ebdY0XlbxsQ0nTN2FVSllitV
	 yrX4SFKtZgoM/k5vN+FXg06IahsygR3VccaaNTO2JY5sqqeC4hl5qX49lnsWf4eLHw
	 hrg2EnUZzE4ifDod9V38Fr1cYvS9StzX0ZgwxbOQTGaKK90sLr49e92lsbzbCPaqqV
	 uSsVD+jNloPQA==
Subject: Re: [PATCH net v2 2/2] net: stmmac: preserve real_num_tx_queues on
 mqprio setup failure
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 0x1207@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 15:07:46 +0000
Message-ID: <178905286654.219967.8364160447492855923@kernel.org>
In-Reply-To: =?utf-8?q?=3C20260909-stmmac-tc=5Fsetup=5Fdwmac510=5Fmqprio-err?=
 =?utf-8?q?or-path-v2-2-8158b8333b3d=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20260909-stmmac-tc=5Fsetup=5Fdwmac510=5Fmqprio-erro?=
 =?utf-8?q?r-path-v2-2-8158b8333b3d=40oss=2Equalcomm=2Ecom=3E?=
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

- [Medium] The reproducer quoted in the commit message cannot demonstrate
  the bug being fixed.
- [Medium] The new error path no longer reprograms the MAC's FPE
  preemption-class register.
- [Medium] Spurious kernel warning triggered during mqprio teardown path
  in `tc_setup_dwmac510_mqprio`
- [Low] The driver-side restore of dev->num_tc / tc_to_txq[] /
  prio_tc_map[] on the FPE-failure path is immediately overridden in…
- [Low] The newly added rollback in tc_setup_dwmac510_mqprio() discards
  the return value of netif_set_real_num_tx_queues(ndev,…

--

net: stmmac: preserve real_num_tx_queues on mqprio setup failure

This patch saves ndev->real_num_tx_queues along with the TC-to-queue and
priority-to-TC mappings before an mqprio offload is applied, and restores
them if stmmac_fpe_map_preemption_class() fails, instead of calling
stmmac_reset_tc_mqprio() which reset the queue count to the platform
maximum.

Some questions about the commit message and the new rollback path below.

>     The issue can be triggered using the following configuration:
>     
>       # First mqprio config lowers the hw queue count.
>       $tc qdisc add dev eth0 root handle 1: mqprio queues 4@0 4@4

[Severity: Medium]
Does this reproducer actually show the difference between the old and new
error paths?

"queues 4@0 4@4" totals 8 TX queues, and mqprio only accepts it if
real_num_tx_queues is already >= 8:

net/sched/sch_mqprio_lib.c:mqprio_validate_queue_counts() {
	...
	if (qopt->offset[i] >= dev->real_num_tx_queues ||
	    last > dev->real_num_tx_queues) {
	...
}

stmmac opts into that check via caps->validate_queue_counts = true in
tc_query_caps(), allocates MTL_MAX_TX_QUEUES (8) TX queues, and
stmmac_hw_setup() sets:

	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);

So the first command is only accepted when tx_queues_to_use == 8, i.e.
real_num_tx_queues is already at the platform maximum, and the comment
"First mqprio config lowers the hw queue count" does not match what
happens.

With real_num_tx_queues == 8, the old path
stmmac_reset_tc_mqprio() -> netif_set_real_num_tx_queues(ndev,
priv->plat->tx_queues_to_use) restores exactly the same 8 that the new
code restores from ndev_num_tx_queues, so the two behave identically for
the quoted commands.

Would a first configuration that totals fewer queues than
tx_queues_to_use, for example "queues 2@0 2@2" on an 8-queue MAC followed
by the failing "queues 2@0 2@2 fp E P", be a better reproducer?

>     Note that a failed setup makes the qdisc layer run mqprio_destroy() on
>     the new qdisc, which resets dev->num_tc to 0; that is qdisc-layer handling,
>     out of the driver's control, and the driver-side restore remains correct
>     for the still-active previous configuration.

[Severity: Low]
Is "the driver-side restore remains correct for the still-active previous
configuration" accurate for num_tc and the two map arrays?

mqprio_enable_offload() only assigns priv->hw_offload after ndo_setup_tc()
succeeds:

net/sched/sch_mqprio.c:mqprio_enable_offload() {
	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
	if (err)
		return err;

	priv->hw_offload = mqprio.qopt.hw;
}

so on the failure path mqprio_destroy() takes the else branch:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

netdev_set_num_tc() writes num_tc only, so the netdev ends up with num_tc
== 0 while the driver-restored tc_to_txq[] and prio_tc_map[] stay
populated, a combination netdev_reset_tc() never produces on its own.

Since skb_tx_hash(), netif_setup_tc(), mqprio_qopt_reconstruct() and XPS
all gate on num_tc, is the newly added save/restore of num_tc and of the
two 16-entry maps doing anything observable, and is priority
classification for the still-installed previous qdisc actually preserved?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 5398616fcdfe..7d73b0c16f50 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1251,43 +1275,59 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,

[ ... ]

> +	err = stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq);
> +	if (err)
> +		goto error_reset_tc;
> +
> +	ndev_num_tx_queues = ndev->real_num_tx_queues;
> +	err = netif_set_real_num_tx_queues(ndev, num_tx_queues);
>  	if (err)
> -		goto err_reset_tc;
> +		goto error_reset_tc;
>  
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

[Severity: Medium]
Is the rollback order at these two labels right when the new mqprio
configuration asks for more TX queues than the one it replaces?

When error_reset_num_tx_queues is reached, the netdev still carries
the mapping that stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq)
just installed: dev->num_tc is qopt->num_tc and tc_to_txq[] describes
num_tx_queues queues. The restore call then shrinks
real_num_tx_queues back to ndev_num_tx_queues, and because
dev->num_tc is non-zero netif_set_real_num_tx_queues() goes through
netif_setup_tc():

net/core/dev.c:netif_setup_tc() {
	struct netdev_tc_txq *tc = &dev->tc_to_txq[0];

	/* If TC0 is invalidated disable TC mapping */
	if (tc->offset + tc->count > txq) {
		netdev_warn(dev, "Number of in use tx queues changed"
				 " invalidating tc mappings...\n");
		dev->num_tc = 0;
		return;
	}

	for (i = 1; i < TC_BITMASK + 1; i++) {
		...
		if (tc->offset + tc->count > txq) {
			netdev_warn(dev, "... Setting map to 0\n");
			netdev_set_prio_tc_map(dev, i, 0);
		}
	}
}

So for a sequence such as "queues 2@0 2@2" followed by a failing
"queues 4@0 4@4 fp E P", the driver's own rollback makes the core
print "Priority traffic classification disabled!" (and possibly the
per-priority warnings), zero dev->num_tc and rewrite prio_tc_map[]
entries, purely as a side effect of the intermediate state. The
following stmmac_set_ndev_tcs(ndev, ndev_ntc, ndev_tc_to_txq) and
the netdev_set_prio_tc_map() loop do repair all of that, so the
end state looks correct, but users see a scary warning for an
internal undo step and the tc mappings are transiently invalid.

Would reversing the two rollback steps, restoring ndev_ntc /
ndev_tc_to_txq / ndev_prio_tc_map first and only then calling
netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues), avoid this?
The saved mapping by construction fits ndev_num_tx_queues, so
netif_setup_tc() should have nothing to complain about. If there is
a reason the queue count has to be restored first, could that be
spelled out in a comment?

[Severity: Low]
Should the return value of the restoring netif_set_real_num_tx_queues() be
checked here?

On this path the call always grows the queue count, because
mqprio_validate_queue_counts() already ensured num_tx_queues <=
ndev_num_tx_queues, and growing can fail:

net/core/dev.c:netif_set_real_num_tx_queues() {
	...
		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
						  txq);
		if (rc)
			return rc;
	...
}

net/core/net-sysfs.c:netdev_queue_update_kobjects() {
	for (i = old_num; i < new_num; i++) {
		error = netdev_queue_add_kobject(dev, i);
		if (error) {
			new_num = old_num;
			break;
		}
	}
}

The early return happens before dev->real_num_tx_queues is assigned, so on
-ENOMEM the device keeps the lower queue count while the following
stmmac_set_ndev_tcs() reinstates a tc_to_txq[] whose offsets and counts
describe queues beyond real_num_tx_queues. The function still returns only
the original FPE error, so nothing above sees the partial restore.

[Severity: Medium]
Does this error path need to reprogram the FPE preemption-class register?

The previous code reached the disarm through:

drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:stmmac_reset_tc_mqprio() {
	netdev_reset_tc(ndev);
	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);

	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
}

dwmac5_fpe_map_preemption_class() does all of its validation before its
single read-modify-write:

drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c {
		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
			return -EINVAL;
		}
	...
update_mapping:
	val = readl(priv->ioaddr + GMAC5_MTL_FPE_CTRL_STS);
	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
	       priv->ioaddr + GMAC5_MTL_FPE_CTRL_STS);
}

so on the -EINVAL path GMAC5_MTL_FPE_CTRL_STS still holds the mask
programmed by the previous successful configuration.

The new error_reset_num_tx_queues/error_reset_tc labels touch no MAC
register, and the qdisc layer then zeroes dev->num_tc via
mqprio_destroy() -> netdev_set_num_tc(dev, 0). Is the hardware then left
with a per-TXQ preemptible mask armed while the driver's only description
of which TXQs belong to which TC says there are no traffic classes, so
express-intended frames can land on TXQs the MAC merge layer will
fragment?

The driver recomputes the mask only from netdev_get_num_tc() and
tc_to_txq[] on later calls, so it appears the stale mask stays until the
previous qdisc is deleted or replaced. Would it be worth mentioning this
hardware-state change in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d%40oss.qualcomm.com
