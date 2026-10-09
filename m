Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0D39DBDB;
	Fri,  9 Oct 2026 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517426; cv=none; b=dLApwnt8+WJR21a0cV4gW9quP/L07HzZ0hwSWsfERaEKMlNk8XZ1uPARPehNsDCpfBEOofMxyqTxgzpbEe1iIEdgudcb6uoxCRt0VxOs0sKJLuhTpqjHqg302IcCddjGyIsUUgNtF6Z+Q94+6JYnGCiR5fEiAZrjbIJ9IUI5efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517426; c=relaxed/simple;
	bh=54Unc4poudAEzCKxWEFQKyVAZYHFJ7ujLAlToVsvStc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJy/7bn0Fu05Go5H4eIxxUqhXGIhyrrs738vPDiXUM26qG4tg8RKERhLLl/VDPpEWhPOhYRxYcZrqUI7rqrit6D8UgdDw4ju6EksbXrNW7LnrRJiOISQQsJI2SwEB7sYxlRV+YhFxolbAi2kcxybS+lWWw3PhSe6s7MQj/ZyprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7jzcXWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7jzcXWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C451F00893;
	Fri,  9 Oct 2026 03:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791517415;
	bh=D5AapTTHnq2d6p+TU1Dj70RGFdzqxhQ5tc7A/1UK4XU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g7jzcXWpUAqgFn8xWnPS1yr3xehZwHgAjjGfSyvhDs8EVcYyx6v7n7TfLacjGPNh/
	 CexCJXpU0tbcKUPsV8Hh9U4KWJFXN2SR4nhG4lOkEtcTN9DLkIF+dmQr8gQUnBOdIE
	 LiBJiJAzXzt4gy53ghGwItO/VH+u7a0W2ZPMJEB2S7jEBrGEc8O0kL6iAJznlEsZGM
	 8tbEybnfxxTTcmJDfJQkouoXLJliBKZUhtz6E0XpJhl1Xi572A8tGOaiHFcmMVquEt
	 c6fyK3YXt08gXJBPuQ6RbAJYEZfCB5fWveMJoaKb+Ca6tcVuSoY4qVHB6u4s1ZhKbL
	 vtVA0an69h5bQ==
Subject: Re: [PATCH net-next v5 2/3] net: ti: icssm-prueth: Add priority based
 RX IRQ handlers
From: netdev-bot+sashiko@kernel.org
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, afd@ti.com, vadim.fedorenko@linux.dev, haokexin@gmail.com,
 basharath@couthit.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, m-malladi@ti.com,
 krishna@couthit.com, mohan@couthit.com
Date: Fri, 09 Oct 2026 03:43:33 +0000
Message-ID: <179151741352.434549.8872750422705694358@kernel.org>
In-Reply-To: <20261005154654.576663-3-parvathi@couthit.com>
References: <20261005154654.576663-3-parvathi@couthit.com>
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

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new 'do not restart TX during teardown' logic is a check-
  then-act sequence with no lock or ordering against ndo_stop().
- [Medium] icssm_prueth_common_emac_rx_packets() reads the two queues'
  write pointers at different times before the loop and never re-reads…
- [Medium] The shared HP/LP NAPI pollers use a plain, unsynchronised read
  of prueth->emac_configured as the gate for dereferencing a port's…
- [Low] This feature patch also carries a fix for an existing bug, with
  no Fixes: tag.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  extends it to the new shared resources.

--

net: ti: icssm-prueth: Add priority based RX IRQ handlers

This patch adds shared high/low priority RX IRQs and NAPI instances for
switch, HSR and PRP modes. Frames from the two PRU ports are delivered
in order of the IEP arrival timestamp that the firmware records. It also
converts the per-port stats to atomic64_t, adds a firmware revision field
that selects the IEP wrap value, and changes ndo_stop() to stop TX before
it cancels the TX hrtimer.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 453c9b259d77a..42c83946f17a7 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -1126,11 +1157,28 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>  	/* disable the mac port */
>  	icssm_prueth_port_enable(emac, false);
>  
> +	/* Stop TX first. netif_tx_disable() also waits for an xmit that is
> +	 * already running. Then cancel any tx_hrtimer that xmit may have
> +	 * armed.
> +	 */
> +	netif_tx_disable(ndev);
> +	hrtimer_cancel(&emac->tx_hrtimer);

[Severity: Low]
This isn't a bug, but these TX teardown changes look like a fix for an
existing problem. They are netif_tx_disable() before hrtimer_cancel()
here, plus the new emac_configured checks in
icssm_emac_tx_timer_callback() and icssm_emac_adjust_link().

The problem comes from icssm_prueth_change_mode(), which calls
ndo_stop()/ndo_open() directly while the netdev stays running. Before this
patch, icssm_emac_ndo_stop() never stopped TX, and the timer callback woke
the queue unconditionally. TX could therefore restart while the PRUs were
shut down and shared RAM/OCMC was being re-initialised.

Could this be split into its own patch, with a Fixes: tag pointing at the
commit that introduced icssm_prueth_change_mode()? Right now it is mixed
in with the HPQ/LPQ rework, the atomic64 stats conversion and the fw_rev
probe requirement, so it can't be backported on its own.

> +
>  	/* stop PHY */
>  	phy_stop(emac->phydev);
>  
> -	napi_disable(&emac->napi);
> -	hrtimer_cancel(&emac->tx_hrtimer);
> +	if (PRUETH_IS_EMAC(prueth)) {
> +		napi_disable(&emac->napi);
> +		free_irq(emac->rx_irq, ndev);
> +	} else {
> +		if (!prueth->emac_configured &&
> +		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
> +			napi_disable(&prueth->napi_lpq);
> +			napi_disable(&prueth->napi_hpq);
> +		}
> +		/* Free IRQs on last port before halting PRU */
> +		icssm_prueth_common_free_irqs(emac);
> +	}

[Severity: High]
This is a pre-existing issue, but this patch extends it to the new shared
resources. The shared NAPIs and IRQs are torn down whenever
emac_configured drops to zero, with no check that this port actually
acquired them. What happens if ndo_stop() runs on a port whose ndo_open()
failed?

icssm_prueth_change_mode() calls ndo_open() directly and just returns on
error:

    ret = ndev->netdev_ops->ndo_open(ndev);
    if (ret < 0) {
        netdev_err(ndev, "failed to start: %d", ret);
        return ret;
    }

The netdev keeps __LINK_STATE_START, but its emac_configured bit is never
set and napi_hpq/napi_lpq stay disabled (SCHED|NPSVC). One way to get
here: the switch firmware is missing, so
icssm_prueth_sw_boot_prus()->rproc_boot() fails during the EMAC to switch
change that bridge creation triggers.

A later "ip link set ethX down" then does:

    dev_close()
      icssm_emac_ndo_stop()
        napi_disable(&prueth->napi_lpq)
          napi_disable_locked()   <- spins forever on SCHED|NPSVC

and it does this while holding rtnl_lock and the netdev lock.

Would icssm_prueth_common_free_irqs() then also call free_irq() on rx_lp
and rx_hp IRQs that were never requested, with rproc_shutdown() and
icss_iep_exit() running a second time?

The EMAC path has the same pattern with the unconditional
napi_disable(&emac->napi) and free_irq(emac->rx_irq, ndev), which the
baseline also had.

[ ... ]

> @@ -1662,6 +1707,11 @@ static enum hrtimer_restart icssm_emac_tx_timer_callback(struct hrtimer *timer)
>  {
>  	struct prueth_emac *emac =
>  			container_of(timer, struct prueth_emac, tx_hrtimer);
> +	struct prueth *prueth = emac->prueth;
> +
> +	/* Don't restart TX on a port that ndo_stop() is tearing down */
> +	if (!(READ_ONCE(prueth->emac_configured) & BIT(emac->port_id)))
> +		return HRTIMER_NORESTART;
>  
>  	if (netif_queue_stopped(emac->ndev))
>  		netif_wake_queue(emac->ndev);

[Severity: High]
Is this check enough to keep TX from restarting during teardown? The
check and the wake are not atomic with respect to icssm_emac_ndo_stop().
That function does a plain clear of the bit, then netif_tx_disable(),
then hrtimer_cancel():

CPU0 (tx_hrtimer callback)          CPU1 (icssm_emac_ndo_stop)
READ_ONCE(emac_configured) has bit
                                    emac_configured &= ~BIT(port_id)
                                    icssm_prueth_port_enable(emac, false)
                                    netif_tx_disable(ndev)
netif_queue_stopped() -> true
netif_wake_queue()
                                    hrtimer_cancel() returns

hrtimer_cancel() only waits for the callback to finish. Nothing stops the
queue again afterwards.

In the icssm_prueth_change_mode() path the qdisc is still active. So
ndo_start_xmit() could run against the PRU queues while the PRUs are shut
down and icssm_prueth_hostinit() clears shared RAM/OCMC.

icssm_emac_adjust_link() has the same check-then-wake pattern. It uses a
plain load under emac->lock, and ndo_stop() never takes that lock.

emac_configured itself is also accessed racily: a plain u8
read-modify-write in ndo_stop(), READ_ONCE() here, and a plain load in
icssm_emac_adjust_link().

Would clearing the bit with release semantics and calling
netif_tx_disable() again after hrtimer_cancel() close this? Serialising
the check-and-wake against teardown with a lock would be another option.

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> new file mode 100644
> index 0000000000000..1a5e5a84345e1
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> @@ -0,0 +1,309 @@

[ ... ]

> +	port0_configured = prueth->emac_configured & BIT(emac->port_id);
> +	port1_configured = other_emac &&
> +			   (prueth->emac_configured & BIT(other_emac->port_id));

[ ... ]

> +	if (port1_configured) {
> +		queue_desc_o = other_emac->rx_queue_descs + qid2;

[Severity: Medium]
Are these plain loads of emac_configured enough to make rx_queue_descs
safe to dereference?

When the second port opens while the first is already up,
icssm_prueth_sw_port_config() stores emac->rx_queue_descs. After that,
icssm_emac_ndo_open() sets the bit:

    prueth->emac_configured |= BIT(emac->port_id);

In this case icssm_prueth_sw_init_fdb_table(), icssm_prueth_sw_boot_prus()
and icssm_prueth_common_request_irqs() all return early. So no lock,
barrier or MMIO write orders the rx_queue_descs store before the bit
store.

On SMP (AM57xx), could the HPQ/LPQ poller on the other CPU see the bit
before the pointer? If the port has never been opened since probe, it
would then compute other_emac->rx_queue_descs + qid2 from NULL and call
readb()/readw() on the result.

On the teardown side, ndo_stop() for a non-last port clears its bit but
does not synchronise with the shared NAPIs. A poll that has already read
port1_configured as true can keep calling icssm_emac_rx_packet(other_emac,
...) and writing its rd_ptr, up to the budget, while ndo_stop() runs.

Are smp_store_release()/smp_load_acquire() on the mask (or a lock shared
with the pollers), plus napi_synchronize() when a non-last port stops,
needed here?

[ ... ]

> +		bd_rd_ptr_o = readw(&queue_desc_o->rd_ptr);
> +		bd_wr_ptr_o = readw(&queue_desc_o->wr_ptr);
> +		port1_q_empty = (bd_rd_ptr_o == bd_wr_ptr_o);

[ ... ]

> +	while (!port0_q_empty || !port1_q_empty) {
> +		rd_buf_desc = readl(shared_ram + bd_rd_ptr);
> +		rd_buf_desc_o = readl(shared_ram + bd_rd_ptr_o);

[ ... ]

> +		} else if (!port0_q_empty) {
> +			/* Packet(s) in port0 queue only */
> +			port = 0;
> +		} else {
> +			/* Packet(s) in port1 queue only */
> +			port = 1;
> +		}

[Severity: Medium]
Can this deliver frames out of wire order? bd_wr_ptr and bd_wr_ptr_o are
each read once before the loop, at different times, and never re-read.

Consider:

  readw(&queue_desc->wr_ptr)     port0 looks empty
  frame A completes on port0
  frame B completes on port1
  readw(&queue_desc_o->wr_ptr)   port1 has B

port0_q_empty stays true for the whole loop. The else branch picks port1,
and B goes to netif_receive_skb() without being compared against A's
timestamp. A is only seen on the next poll.

The same thing happens once port0's snapshot has been used up. In HSR/PRP,
consecutive frames of one flow can arrive first on different ports, so
this could show up as TCP reordering.

Would re-reading wr_ptr for a queue that looks empty, before taking a
frame from the peer queue, avoid this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005154654.576663-1-parvathi%40couthit.com
