Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C43C98AF;
	Thu, 10 Sep 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051498; cv=none; b=GpRasx00jYFOU09hMKChCHRp9enEAq/45VyLncRmtiuroC5NcH5+ynVnR/P4VQDbiKUHqp2c7wXRY+PxydOoExdnUynfV8qr3MnPeBj7UVMiDjfkl6y1wUYDXPVacJsFkCLHlHWPWX1Jwy31SQB9nxUqTuryZwYx8nZiFAUSEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051498; c=relaxed/simple;
	bh=nd4EnEbKXe4OqxLQBKrEYGZ/ZTpCkAQwQYNkX1YWEzs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwOnUtSjfvmwkE2Ut07ZP4jNR0eICXGhfKm86Sp9MU525P6y9M9RoxPhNJ7TsDGaBhYYXPmHUGGLsuCHp7rCf9Kb5BNGkwIImucNoTFJtgFf9ZmGs1QrS7A8ZTHxAnTqLwVfZEzye1iQG1q9Qdsunosvb2BlXHeBLZIIP2cFXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/GmAueh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/GmAueh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C1F1F00898;
	Thu, 10 Sep 2026 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051496;
	bh=GMiGhp26CGOy4LNet6GfpTT6FG7zL0NM5J5Gwkqwon4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X/GmAuehq3doEE0rvB8/hyR2gQVEL1j51Wdemeix5/oRy0iTHueXfXWw3bWmIw5mW
	 orhWuKj/YNcW3GwHmAsc6xGUF2h47jYbdnrhOGTya4h8x2ZMBODEM5rYoT34qjzxEB
	 5qHt6xUYMRbB0/MHJa+v8E2UpRDpiHNfGtV3Z4fPbc9PHydkuTzT72GRnTDMdN1V6T
	 kZPl8eDxyxcS7SoraixhN/mLCUV/Hq/AwEzqMDyaUbFLEXxTgWZZnIYiXoH3u9SETA
	 cYRT9jDv+zJ7bnjLGTfrkMu0F+iP4SLNP7e/4BcSpngJs0aSp0GZ5+juNMIZmt7RkM
	 RijKn2NSEilMQ==
Subject: Re: [PATCH net-next v2 3/4] net: macb: Add MQPRIO qdisc hardware
 offload support
From: netdev-bot+sashiko@kernel.org
To: vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 14:44:55 +0000
Message-ID: <178905149546.219967.2086828397265707506@kernel.org>
In-Reply-To: <20260909142056.1433875-4-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-4-vineeth.karumanchi@amd.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 1

- [Medium] macb_setup_mqprio()
  (drivers/net/ethernet/cadence/macb_main.c:4495) consumes only…
- [Medium] The mqprio offload teardown path is unreachable while the MAC
  is runtime suspended, leaving the netdev traffic-class state installed…
- [Low] Concern (judged a false positive at validation): mqprio offload
  is only usable on MACB_CAPS_TC (TSN) parts and only while the device…

Pre-existing issues:
- [High] The new TC_QUERY_CAPS handler macb_tc_query_caps()
  (macb_main.c:4533) answers only TC_SETUP_QDISC_MQPRIO and returns…

--

net: macb: Add MQPRIO qdisc hardware offload support

This adds a TC_SETUP_QDISC_MQPRIO handler that installs the traffic class
to queue mapping with netdev_set_num_tc()/netdev_set_tc_queue() and resets
it when num_tc is zero.  It also adds a TC_QUERY_CAPS handler that reports
validate_queue_counts for mqprio.

A few questions below.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ff7e02d3fab8..67150ff03066 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4492,6 +4492,60 @@ static int macb_setup_taprio(struct net_device *netdev,
>  	return err;
>  }
>  
> +static int macb_setup_mqprio(struct net_device *netdev,
> +			     struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	u8 num_tc = qopt->num_tc;
> +	int err;
> +	u8 i;
> +
> +	/* Handle reset case early */
> +	if (!num_tc) {
> +		netdev_reset_tc(netdev);
> +		return 0;
> +	}
> +
> +	/* Configure traffic classes */
> +	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;

[Severity: Medium]
Should macb_setup_mqprio() reject the offload parameters it does not
implement instead of reporting the request as offloaded?

net/sched/sch_mqprio.c:mqprio_enable_offload() fills in more than qopt
before calling into the driver:

	case TC_MQPRIO_MODE_CHANNEL:
		mqprio.flags = priv->flags;
		if (priv->flags & TC_MQPRIO_F_MODE)
			mqprio.mode = priv->mode;
	...
	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
	if (err)
		return err;
	priv->hw_offload = mqprio.qopt.hw;

macb_setup_mqprio() looks only at mqprio->qopt, so a request like

	tc qdisc add dev eth0 root mqprio num_tc 2 map ... queues 1@0 1@1 \
	    hw 1 mode channel shaper bw_rlimit max_rate 100Mbit 200Mbit

returns 0 with qopt->hw set, and tc reports hardware offload, while
mqprio->mode, mqprio->shaper, mqprio->min_rate[] and mqprio->max_rate[] are
not referenced anywhere in macb_main.c.

Other drivers reject these up front, for example cpsw_priv.c does

	if (mqprio->mode != TC_MQPRIO_MODE_DCB)
		return -EINVAL;

and mlx5 en_main.c / cxgb4_tc_mqprio.c return -EOPNOTSUPP for modes and
shapers they cannot honour.

Would it be worth also passing the reason back through mqprio->extack?

> +
> +	err = netdev_set_num_tc(netdev, num_tc);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < num_tc; i++) {
> +		err = netdev_set_tc_queue(netdev, i, qopt->count[i],
> +					  qopt->offset[i]);
> +		if (err)
> +			goto err_reset_tc;
> +
> +		netdev_dbg(netdev, "MQPRIO: TC%d -> queue %u (count=%u)\n",
> +			   i, qopt->offset[i], qopt->count[i]);
> +	}
> +
> +	return 0;
> +
> +err_reset_tc:
> +	netdev_reset_tc(netdev);
> +	return err;
> +}
> +
> +static int macb_tc_query_caps(struct net_device *netdev,
> +			      struct tc_query_caps_base *base)
> +{
> +	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +
> +		return 0;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but since
this is the callback where it would be declared: should
TC_SETUP_QDISC_TAPRIO also be answered here with
tc_taprio_caps.gate_mask_per_txq = true?

net/sched/sch_taprio.c:taprio_sched_to_offload() converts the mask to a
queue mask only when the driver asks for it:

		if (caps->gate_mask_per_txq)
			e->gate_mask = tc_map_to_queue_mask(dev,
							    entry->gate_mask);
		else
			e->gate_mask = entry->gate_mask;

and include/net/pkt_sched.h documents struct tc_taprio_sched_entry as:

	/* The gate_mask in the offloading side refers to traffic classes */
	u32 gate_mask;

macb_taprio_setup_replace() decodes that value as a hardware queue index:

		queue_id = order_base_2(entry->gate_mask);
		if (queue_id >= bp->num_queues) {
	...
		/* Enable ENST for all configured queues in one write */
		gem_writel(bp, ENST_CONTROL, configured_queues);

With a non-identity map, say "taprio num_tc 2 queues 2@0 2@2", a sched-entry
gate mask of 0x2 means TC1, i.e. queues 2 and 3, but queue_id becomes 1, so
the ENST window is programmed on hardware queue 1 while queues 2 and 3 stay
open, and configured_queues (a traffic class mask) is written into
GEM_ENST_CONTROL whose bits are per hardware queue.  The

		if (!is_power_of_2(entry->gate_mask))

check also rejects any entry that opens more than one traffic class.

Since this patch is what makes non-identity TC to queue maps a normal
configuration for macb, does the taprio gate mask handling need updating in
the same series?

>  static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  			 void *type_data)
>  {
> @@ -4500,6 +4554,9 @@ static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  	if (!netdev || !type_data)
>  		return -EINVAL;
>  
> +	if (type == TC_QUERY_CAPS)
> +		return macb_tc_query_caps(netdev, type_data);
> +
>  	bp = netdev_priv(netdev);
>  
>  	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))

[Severity: Low]
This isn't a bug, but the commit message doesn't mention that the new
offload is only reachable on parts where macb_init_dflt() sets
NETIF_F_HW_TC:

	/* Enable TC offload for TSN-capable hardware */
	if (bp->caps & MACB_CAPS_TC)
		netdev->hw_features |= NETIF_F_HW_TC;

macb_setup_mqprio() only manipulates net_device software state, so on
non-TSN macb variants "hw 1" returns -EOPNOTSUPP from macb_setup_tc().
Could the log state that mqprio hardware offload is limited to
MACB_CAPS_TC parts?

> @@ -4512,6 +4569,8 @@ static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  	}
>  
>  	switch (type) {
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return macb_setup_mqprio(netdev, type_data);

[Severity: Medium]
Can the mqprio teardown be lost while the device is runtime suspended?

TC_QUERY_CAPS is dispatched before the runtime PM check, but
TC_SETUP_QDISC_MQPRIO is dispatched after it, so the num_tc == 0 path in
macb_setup_mqprio() that calls netdev_reset_tc() cannot run in that state:

	/* Check if Device is in runtime suspend */
	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
		netdev_err(netdev, "Device is in runtime suspend\n");
		return -EOPNOTSUPP;
	}

macb_close() drops the runtime PM reference and macb_probe() enables
autosuspend, so this sequence reaches it:

	ip link set eth0 up
	tc qdisc replace dev eth0 root mqprio ... hw 1
	ip link set eth0 down		/* autosuspend after MACB_PM_TIMEOUT */
	tc qdisc del dev eth0 root

net/sched/sch_mqprio.c:mqprio_destroy() skips its own fallback when the
qdisc was offloaded:

	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);

and mqprio_disable_offload() discards the ndo_setup_tc() return value, so
the -EOPNOTSUPP is silent and dev->num_tc, dev->tc_to_txq[] and
dev->prio_tc_map[] stay configured after the owning qdisc is freed,
continuing to steer transmit queue selection.

Since this handler touches no registers, would it be better to handle the
num_tc == 0 reset before the runtime suspend check, the same way
TC_QUERY_CAPS is?

>  	case TC_SETUP_QDISC_TAPRIO:
>  		return macb_setup_taprio(netdev, type_data);
>  	default:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909142056.1433875-1-vineeth.karumanchi%40amd.com
