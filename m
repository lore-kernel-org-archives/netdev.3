Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB89492E4F;
	Thu, 10 Sep 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051500; cv=none; b=WDcdI+alZwfV2XvhPuWsy0O8Kyy/wwqU3+uSyTmI7SgabJ+XYaB8YLi4CEsludzYIasTEZSo1GEo2bC5if0ZYFA00auTS2XV8iCNRLOuPA0cKM63E18UOTMhzNv8LdUdzN5dNNm/xhlU3V0aUCwI3m9erChJ3ieBSWSCmZtGIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051500; c=relaxed/simple;
	bh=AV72FfqTaqVI2T2BE1cdGWX1TP6eUrru3swJh5lKEgg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cICqDC26bElen3TI7viL1a6J4LpS6rwMiT+lAwBOytww07Csc/Yjw7VA0pMA205U8mZfTsdqnVNsEfytiV35JZOHIhqDS7HEpNNskh5IYFYXVtYg2DDYGxj84ldib8Rh+T781uZhpYAMBFswh0jo6JSbgUBR5VRGTlCxuLgcmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD2ep8D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD2ep8D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C01F000FF;
	Thu, 10 Sep 2026 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051497;
	bh=wBdNsQTfyKRm4ndEj/A8KvuBz0V4hCgtrxNafl1++NQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LD2ep8D929M/G7Bfmn75ksgX3BH03bZOwBHcx3xa/h4y5tgWNqzcmAQh9r2QYTRgj
	 SediO9YXqJG8ws2o67zMfKOW9Xtng9issmmQ0qE2f+VxFYkpXcmdVPNdtS/vvoVTzH
	 nAzD5nSJoQXbDjT4o65aDYlN6yOccQvc3nN7AejoMvZpedjTltzyXl1BSGYiDrBj6q
	 V7qZdFoK4meLMkLJvUQfepoiTCc1umfdRBjHQcNBu1jklOe5VhppIqTwv8iXTeFArh
	 ATM7AjEEJwNefH3Rjurpa2qv3yZJUe+pFs08+59AKj019McqzKZ5zRMjwgwSuHvszo
	 CJZw1/uabJFrg==
Subject: Re: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload support
From: netdev-bot+sashiko@kernel.org
To: vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 14:44:56 +0000
Message-ID: <178905149676.219967.5874263463845015629@kernel.org>
In-Reply-To: <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 6 · Low: 1

- [Medium] macb_cbs_add() (drivers/net/ethernet/cadence/macb_main.c:4519)
  bakes the instantaneous link speed into the value written to…
- [Medium] macb_cbs_add() consumes only qopt->queue, qopt->enable and
  qopt->idleslope from struct tc_cbs_qopt_offload and returns 0,…
- [Medium] The CBS disable request can be rejected before it reaches
  macb_cbs_destroy(), leaving the CBS enable bit and a stale idleslope…
- [Medium] The CBS enable bits and idleslope registers programmed by
  macb_cbs_add() are never cleared on interface down and never…
- [Medium] macb_cbs_add() and macb_cbs_destroy() perform MMIO
  (gem_readl/gem_writel of GEM_CBS_CONTROL at…
- [Medium] Incorrect queue mapping allows configuring CBS on the base
  best-effort queue on 1- or 2-queue devices.
- [Low] macb_cbs_add() samples the link speed with
  phylink_ethtool_ksettings_get() at macb_main.c:4538 (outside bp->lock)…

--

net: macb: Add TSN CBS TC offload support

This adds Credit-Based Shaper (IEEE 802.1Qav) TC offload for the two
highest-priority GEM queues, computing the idleslope register value from
the current link speed and arming the per-queue CBS enable bit. A few
questions about the link-speed dependency, the ignored qopt fields and
the interaction with runtime PM / suspend below.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 67150ff03066..00c1c619dea8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -4492,6 +4496,116 @@ static int macb_setup_taprio(struct net_device *netdev,
>  	return err;
>  }
>  
> +static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
> +				     u32 *enable_bit, u32 *idleslope_reg)
> +{

[ ... ]

> +static int macb_cbs_add(struct net_device *netdev,
> +			struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 enable_bit, idleslope, speed_kbps, ctrl, idleslope_reg;
> +	struct ethtool_link_ksettings kset = {};
> +	struct macb *bp = netdev_priv(netdev);
> +	int err;
> +
> +	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &idleslope_reg);
> +	if (err) {
> +		netdev_err(netdev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
> +			   qopt->queue);
> +		return -EINVAL;
> +	}
> +
> +	/* idleslope is calibrated for the current link speed; CBS is not
> +	 * reprogrammed on link-speed changes, so it must be reconfigured
> +	 * if the link speed changes.
> +	 */
> +	phylink_ethtool_ksettings_get(bp->phylink, &kset);

[Severity: Medium]
Is there anything that makes the "must be reconfigured if the link speed
changes" requirement in this comment actually happen?

Grepping the tree, GEM_CBS_CONTROL and GEM_CBS_IDLESLOPE_Q_A/Q_B are
referenced only from macb_cbs_add() and macb_cbs_destroy().
macb_mac_link_up() reprograms NCFGR SPD/GBE for the new speed but leaves
the CBS registers alone, and on the core side cbs_dev_notifier() ->
cbs_set_port_rate() only refreshes the software port_rate on NETDEV_UP /
NETDEV_CHANGE, it never re-issues ndo_setup_tc(TC_SETUP_QDISC_CBS).

macb_cbs_add() also keeps no copy of qopt in struct macb, so is there any
data left to replay even if such a hook were added?

For standard MACB the *unit* of the register is chosen by the speed
(kset.base.speed >= 1000 selects bytes/sec vs nibbles/sec), so after a
1000 -> 100 Mbit renegotiation the register still holds a bytes/sec value
that hardware now consumes as nibbles/sec at one tenth of the port rate,
while the enable bit stays armed and userspace still sees the qdisc as
offloaded. Would deriving the port rate from the qopt parameters the way
stmmac's tc_setup_cbs() does avoid the dependency entirely?

  port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;

Related: rejecting speed 0 / SPEED_UNKNOWN means CBS cannot be installed
at all while the link is down. Is that intended?

> +
> +	if (!kset.base.speed || kset.base.speed == SPEED_UNKNOWN) {
> +		netdev_err(netdev, "CBS: Invalid link speed\n");
> +		return -EINVAL;
> +	}
> +
> +	speed_kbps = kset.base.speed * 1000;

[Severity: Low]
Can the speed sampled here change before the register write below?

The phylink_ethtool_ksettings_get() call is outside bp->lock, and the
idleslope is programmed later under scoped_guard(spinlock_irqsave,
&bp->lock). phylink_resolve() runs from the workqueue holding only
pl->phydev_mutex, phy->lock and pl->state_mutex - it does not take RTNL -
and calls phylink_link_up() -> macb_mac_link_up(), which changes the MAC
speed under bp->lock:

  macb_mac_link_up()
      spin_lock_irqsave(&bp->lock, flags);
      ctrl = macb_or_gem_readl(bp, NCFGR);
      ctrl &= ~(MACB_BIT(SPD) | MACB_BIT(FD));

So RTNL held by the qdisc path does not exclude a renegotiation landing
between the read of kset.base.speed and the write of idleslope_reg,
leaving a value scaled with the 1G factor on a 100 Mbit link. Should the
speed be sampled inside the same critical section as the programming, or
re-checked afterwards?

> +
> +	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
> +		netdev_err(netdev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
> +			   qopt->idleslope, speed_kbps);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Should qopt->hicredit, qopt->locredit and qopt->sendslope be rejected
rather than silently dropped?

Only qopt->queue, qopt->enable and qopt->idleslope are consumed here, and
0 is returned; those three field names do not appear anywhere in
macb_main.c. On the core side cbs_enable_offload() fills all four shaper
parameters:

  cbs.hicredit = opt->hicredit;
  cbs.locredit = opt->locredit;
  cbs.idleslope = opt->idleslope;
  cbs.sendslope = opt->sendslope;

and on a 0 return cbs_change() stores them and cbs_dump() echoes them
back, so "tc qdisc show" advertises credit limits and a sendslope that
hardware was never configured with.

sendslope in particular carries the port transmit rate in this ABI
(sendslope = idleslope - portTransmitRate). Would returning -EOPNOTSUPP
with an extack for the unsupported fields be preferable to reporting a
complete offload?

> +
> +	/* qopt->idleslope is in kbps; convert to the units the hardware
> +	 * register expects:
> +	 * - High-speed GEM: fraction of port bandwidth, scaled to the full
> +	 *   32-bit register range
> +	 * - Standard MACB: the register counts bytes/sec in 1G (8-bit GMII)
> +	 *   mode and nibbles/sec in 10/100 (4-bit MII) mode, so scale kbps
> +	 *   by 1000/8 (125) or 1000/4 (250) respectively
> +	 */
> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
> +		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
> +	else
> +		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		/* Disable CBS for the queue before updating idleslope */
> +		ctrl = gem_readl(bp, CBS_CONTROL) & ~enable_bit;
> +		gem_writel(bp, CBS_CONTROL, ctrl);
> +		/* Update idleslope for the queue */
> +		bp->macb_reg_writel(bp, idleslope_reg, idleslope);
> +		/* Re-enable CBS for the queue with new idleslope */
> +		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
> +	}

[Severity: Medium]
Can these register accesses run with the clocks already gated?

The only protection is the pm_runtime_suspended(&bp->pdev->dev) sample
taken earlier in macb_setup_tc(); no usage reference is taken here (no
pm_runtime_resume_and_get() / pm_runtime_put_autosuspend()). macb_close()
drops the driver's reference with pm_runtime_put() and the autosuspend
delay is MACB_PM_TIMEOUT (100 ms), and macb_runtime_suspend() gates the
clocks without taking bp->lock:

  macb_runtime_suspend()
      if (!(device_may_wakeup(dev)))
              macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk, bp->rx_clk, bp->tsu_clk);

so the scoped_guard(spinlock_irqsave, &bp->lock) here cannot delay the
transition. macb_mdio_read()/macb_mdio_write() and macb_open() take
pm_runtime_resume_and_get() before touching registers - should the CBS
paths do the same?

> +
> +	netdev_dbg(netdev, "CBS: Configured queue %d with idleslope 0x%x\n",
> +		   qopt->queue, idleslope);
> +
> +	return 0;
> +}
> +
> +static void macb_cbs_destroy(struct net_device *netdev, u8 queue_num)
> +{
> +	struct macb *bp = netdev_priv(netdev);
> +	u32 enable_bit, idleslope_reg;
> +
> +	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &idleslope_reg))
> +		return;
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
> +		bp->macb_reg_writel(bp, idleslope_reg, 0);
> +	}

[Severity: Medium]
Does the CBS state survive an interface down/up or a suspend/resume in a
way that was intended?

macb_reset_hw(), used by macb_close() and by the non-WoL suspend path,
clears NCR/TSR/RSR/PBUFRXCUT and the per-queue interrupts but does not
touch GEM_CBS_CONTROL or GEM_CBS_IDLESLOPE_Q_A/Q_B, so after "ip link set
down" the shaper stays armed with the idleslope computed for the previous
link speed, and the next macb_open() transmits under it even with no CBS
qdisc attached.

In the other direction macb_resume() restores the state the driver tracks:

  if (netdev->hw_features & NETIF_F_NTUPLE)
          gem_writel_n(bp, ETHT, SCRT2_ETHT, bp->pm_data.scrt2);
  ...
  macb_init_hw(bp);

but there is no CBS restore, so if the controller loses register content
an installed, still-"offloaded" CBS qdisc silently stops shaping.

Since macb_cbs_add() stores nothing in struct macb, is there any way to
repair either direction at runtime?

> +
> +	netdev_dbg(netdev, "CBS: Disabled queue %d\n", queue_num);
> +}
> +
> +static int macb_setup_cbs(struct net_device *netdev,
> +			  struct tc_cbs_qopt_offload *qopt)
> +{
> +	if (qopt->enable)
> +		return macb_cbs_add(netdev, qopt);
> +
> +	macb_cbs_destroy(netdev, qopt->queue);
> +	return 0;
> +}
> +

[ ... ]

> @@ -4571,6 +4685,8 @@ static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  	switch (type) {
>  	case TC_SETUP_QDISC_MQPRIO:
>  		return macb_setup_mqprio(netdev, type_data);
> +	case TC_SETUP_QDISC_CBS:
> +		return macb_setup_cbs(netdev, type_data);

[Severity: Medium]
Can the disable request be dropped before it reaches this case?

macb_setup_tc() returns -EOPNOTSUPP for every TC_SETUP_QDISC_CBS call,
including enable == 0, when the device is runtime suspended:

  if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
          netdev_err(netdev, "Device is in runtime suspend\n");
          return -EOPNOTSUPP;
  }

so this switch is never reached and macb_cbs_destroy() never runs. A
sequence like: offload CBS on the top queue, "ip link set ethX down"
(macb_close() -> pm_runtime_put(), then the 100 ms autosuspend), then "tc
qdisc del ..." ends in cbs_destroy() -> cbs_disable_offload(), which only
warns:

  err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
  if (err < 0)
          pr_warn("Couldn't disable CBS offload for queue %d\n", cbs.queue);

and frees the qdisc anyway. With macb_reset_hw()/macb_init_hw() not
touching GEM_CBS_CONTROL, does the queue stay credit-shaped with the old
idleslope after the next "ip link set up" even though no CBS qdisc
exists?

>  	case TC_SETUP_QDISC_TAPRIO:
>  		return macb_setup_taprio(netdev, type_data);
>  	default:

[ ... ]

> @@ -4492,6 +4496,116 @@ static int macb_setup_taprio(struct net_device *netdev,
>  	return err;
>  }
>  
> +static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
> +				     u32 *enable_bit, u32 *idleslope_reg)
> +{
> +	/* Queue A is highest priority (num_queues - 1) */
> +	if (queue_num == bp->num_queues - 1) {
> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_A);
> +		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_A;
> +		return 0;
> +	}
> +
> +	/* Queue B is second highest priority (num_queues - 2) */
> +	if (queue_num == bp->num_queues - 2) {
> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_B);
> +		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_B;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int macb_cbs_add(struct net_device *netdev,
> +			struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 enable_bit, idleslope, speed_kbps, ctrl, idleslope_reg;
> +	struct ethtool_link_ksettings kset = {};
> +	struct macb *bp = netdev_priv(netdev);
> +	int err;
> +
> +	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &idleslope_reg);
> +	if (err) {
> +		netdev_err(netdev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
> +			   qopt->queue);
> +		return -EINVAL;
> +	}
> +
> +	/* idleslope is calibrated for the current link speed; CBS is not
> +	 * reprogrammed on link-speed changes, so it must be reconfigured
> +	 * if the link speed changes.
> +	 */
> +	phylink_ethtool_ksettings_get(bp->phylink, &kset);
> +
> +	if (!kset.base.speed || kset.base.speed == SPEED_UNKNOWN) {
> +		netdev_err(netdev, "CBS: Invalid link speed\n");
> +		return -EINVAL;
> +	}
> +
> +	speed_kbps = kset.base.speed * 1000;
> +
> +	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
> +		netdev_err(netdev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
> +			   qopt->idleslope, speed_kbps);
> +		return -EINVAL;
> +	}
> +
> +	/* qopt->idleslope is in kbps; convert to the units the hardware
> +	 * register expects:
> +	 * - High-speed GEM: fraction of port bandwidth, scaled to the full
> +	 *   32-bit register range
> +	 * - Standard MACB: the register counts bytes/sec in 1G (8-bit GMII)
> +	 *   mode and nibbles/sec in 10/100 (4-bit MII) mode, so scale kbps
> +	 *   by 1000/8 (125) or 1000/4 (250) respectively
> +	 */
> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
> +		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
> +	else
> +		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		/* Disable CBS for the queue before updating idleslope */
> +		ctrl = gem_readl(bp, CBS_CONTROL) & ~enable_bit;
> +		gem_writel(bp, CBS_CONTROL, ctrl);
> +		/* Update idleslope for the queue */
> +		bp->macb_reg_writel(bp, idleslope_reg, idleslope);
> +		/* Re-enable CBS for the queue with new idleslope */
> +		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
> +	}
> +
> +	netdev_dbg(netdev, "CBS: Configured queue %d with idleslope 0x%x\n",
> +		   qopt->queue, idleslope);
> +
> +	return 0;
> +}
> +
> +static void macb_cbs_destroy(struct net_device *netdev, u8 queue_num)
> +{
> +	struct macb *bp = netdev_priv(netdev);
> +	u32 enable_bit, idleslope_reg;
> +
> +	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &idleslope_reg))
> +		return;
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
> +		bp->macb_reg_writel(bp, idleslope_reg, 0);
> +	}
> +
> +	netdev_dbg(netdev, "CBS: Disabled queue %d\n", queue_num);
> +}
> +
> +static int macb_setup_cbs(struct net_device *netdev,
> +			  struct tc_cbs_qopt_offload *qopt)
> +{
> +	if (qopt->enable)
> +		return macb_cbs_add(netdev, qopt);
> +
> +	macb_cbs_destroy(netdev, qopt->queue);
> +	return 0;
> +}
> +
>  static int macb_setup_mqprio(struct net_device *netdev,
>  			     struct tc_mqprio_qopt_offload *mqprio)
>  {

[Severity: Medium]
Does this mapping still hold on hardware with only one or two
queues?

bp->num_queues comes from the DCFG6 queue mask in macb_probe(), and
nothing here bounds it from below. On a 2-queue GEM, bp->num_queues -
2 == 0, so a CBS qdisc installed on queue 0 - the base best-effort
queue - matches the Queue B branch and gets GEM_BIT(CBS_ENABLE_QUEUE_B)
plus GEM_CBS_IDLESLOPE_Q_B programmed for it. On single-queue
hardware the same happens one branch earlier: bp->num_queues - 1 == 0,
so queue 0 is treated as Queue A. In both cases macb_cbs_add()
returns 0, the qdisc is reported as offloaded, and the CBS enable bit
is armed for a priority queue the design does not have, while the
traffic on queue 0 is not shaped at all.

The commit message says CBS is restricted to the two highest-priority
queues "matching hardware capability", but the base queue is exactly
the one that is not a priority queue, so the arithmetic silently
includes it once bp->num_queues drops to 2. Should
macb_cbs_get_queue_params() reject the request unless bp->num_queues
is at least 3, or is the intent to gate CBS on a capability flag (the
way MACB_CAPS_* is used elsewhere) and also refuse to advertise it in
macb_tc_query_caps() on such devices? Whichever way, an explicit
lower bound on bp->num_queues here would make the queue A/B
identification safe to read.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909142056.1433875-1-vineeth.karumanchi%40amd.com
