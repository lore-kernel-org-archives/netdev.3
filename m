Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6241CB4C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437608; cv=none; b=nhTzI3zjBRmU19Qp9HIuOCQetnUkb0x4lp+AkhS//LwFd40A3RPZUtQyA1Nmt9zKUeaHy6bawj8U9qu8Ug31Z0u+9s2ssczXu5s53rxvGa9PRyypttrBzmw8kUPdWQ064KQ4bdDG4sD8yo86pysdQTcrLFMNAZ0dYUW0/B39qeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437608; c=relaxed/simple;
	bh=Ki91ivYlKzP+RRHPWiPy3wSSjoN1MN972NtcTecn/n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opWEFpaVm3YsXzdh7PBPgY81V7BWcbJrL1yIfZ4PDiWs3qp7e3RtA1YGqLCzID7SQlu3X0BKTXz8e5Zk1GzGinTeA9ixEkv+fiYjOznxw09C9WKxFI7P1G0QWnIwfITP8l6f5BTpKWWQQpMGGnOtCfGnQuh3YIBF402Y/pPQ6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSjtv/F2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSjtv/F2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786437605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BlZh1iB5FjCkQFUxyH3k/amtFEOD8MLLGQLn1+xx/A=;
	b=YSjtv/F2oB5JhntWtBcqUG9hQCA8z84uVfJ3BWxl3QBo9rLkEKRGbBpY0kEJV6dNJkN3I2
	EXBS81xlv7z7IKsFD+TYE7/DCnkNNB/HvoKtUBPctBKIx6nAsLlzADaCA+BaHhEM63p/m3
	ueI+yj1XpIv4YtxdjASFfrjSIQzgg/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-lJSHwgkyPge_a0VLNmbq6Q-1; Tue,
 11 Aug 2026 04:39:54 -0400
X-MC-Unique: lJSHwgkyPge_a0VLNmbq6Q-1
X-Mimecast-MFC-AGG-ID: lJSHwgkyPge_a0VLNmbq6Q_1786437592
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7883518001E3;
	Tue, 11 Aug 2026 08:39:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73A753001D38;
	Tue, 11 Aug 2026 08:39:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v3 2/3] net: ti: icssm-prueth: Add priority based RX IRQ handlers
Date: Tue, 11 Aug 2026 10:39:33 +0200
Message-ID: <20260811083933.24428-1-pabeni@redhat.com>
In-Reply-To: <20260804121644.465118-3-parvathi@couthit.com>
References: <20260804121644.465118-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [2]: [PATCH net-next v3 2/3] net: ti: icssm-prueth: Add priority based RX IRQ handlers ---
commit f88c5c0ded57f1071a4ce5dab475dff188d16fb0
Author: Roger Quadros <rogerq@ti.com>

net: ti: icssm-prueth: Add priority based RX IRQ handlers

This adds shared high/low priority RX interrupt handlers and two shared NAPI
instances for switch, HSR and PRP modes, so the host can drain both PRU port
queues in wire-arrival order using the per-frame IEP timestamp. Dual-EMAC
mode keeps its per-port interrupt and NAPI. A new file,
icssm_prueth_common.c, holds the shared poll, IRQ request and IRQ free
helpers.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 138248f4a1eed..7031b78d2cc2f 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -842,7 +858,7 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
>  			rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
>  		overflow_cnt = readb(&queue_desc->overflow_cnt);
>  		if (overflow_cnt > 0) {
> -			emac->stats.rx_over_errors += overflow_cnt;
> +			atomic64_add(overflow_cnt, &emac->stats.rx_over_errors);
>  			/* reset to zero */
>  			writeb(0, &queue_desc->overflow_cnt);
>  		}

[Severity: Low]
[Finding: fable-5-2-6]
[Sources: fable-5]

Is the switch branch in this function still reachable after this change?

icssm_emac_rx_packets() still carries the comment

	/* Start and end queue is made common for EMAC, RSTP */

and the selection

	if (PRUETH_IS_SWITCH(emac->prueth))
		rxqueue = &sw_queue_infos[PRUETH_PORT_HOST][i];

but the only scheduler of emac->napi is the per-port RX hardirq, and after
this patch icssm_emac_ndo_open() requests emac->rx_irq and enables emac->napi
only when PRUETH_IS_EMAC(prueth). Would it be clearer to drop the switch
branch and update the comment?

> @@ -1071,11 +1087,25 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
>  			goto iep_exit;
>  	}
>  
> -	ret = icssm_emac_request_irqs(emac);
> -	if (ret)
> -		goto rproc_shutdown;
> +	if (PRUETH_IS_EMAC(prueth)) {
> +		napi_enable(&emac->napi);
> +	} else {
> +		if (!prueth->emac_configured &&
> +		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
> +			napi_enable(&prueth->napi_hpq);
> +			napi_enable(&prueth->napi_lpq);
> +		}
> +	}
>  
> -	napi_enable(&emac->napi);
> +	/* In switch and LRE modes the shared HPQ/LPQ IRQs are used,
> +	 * register them here and reuse for both modes.
> +	 */
> +	if (PRUETH_IS_EMAC(prueth))
> +		ret = icssm_emac_request_irqs(emac);
> +	else
> +		ret = icssm_prueth_common_request_irqs(emac);
> +	if (ret)
> +		goto disable_napi;
>  
>  	/* start PHY */
>  	phy_start(emac->phydev);

[ ... ]

> @@ -1127,12 +1167,26 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>  	/* disable the mac port */
>  	icssm_prueth_port_enable(emac, false);
>  
> +	netif_stop_queue(ndev);
> +
>  	/* stop PHY */
>  	phy_stop(emac->phydev);
>  
> -	napi_disable(&emac->napi);
>  	hrtimer_cancel(&emac->tx_hrtimer);

[Severity: Low]
[Finding: main-5-23]
[Sources: opus-5]

Can the tx hrtimer undo this netif_stop_queue()?

The queue is stopped before phy_stop() (which can sleep) and before
hrtimer_cancel(&emac->tx_hrtimer), and the callback does:

drivers/net/ethernet/ti/icssm/icssm_prueth.c:icssm_emac_tx_timer_callback() {
	...
	if (netif_queue_stopped(emac->ndev))
		netif_wake_queue(emac->ndev);
	...
}

So a timer armed by the previous HR_TIMER_TX_DELAY_US back-pressure event and
expiring in that window re-wakes the queue.

On the icssm_prueth_change_mode() path ndo_stop() is called directly from the
netdev notifier rather than through dev_close(), so __LINK_STATE_START stays
set and the qdisc is still active, and a re-woken queue can enter
ndo_start_xmit() for a port whose firmware and queues are being
reconfigured. Would cancelling the hrtimer first, or using
netif_tx_disable(), be preferable?

>  
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
> +

[Severity: High]
[Finding: fable-5-5-26]
[Sources: fable-5, opus-5, sonnet-5]

When the first of the two ports is closed, is anything left to stop RX for
that port?

This branch skips napi_disable() while the peer is still configured,
icssm_prueth_common_free_irqs() returns early for the same reason, and
icssm_prueth_sw_shutdown_prus() also early-returns:

drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c:icssm_prueth_sw_shutdown_prus() {
	...
	if (prueth->emac_configured)
		return 0;
	...
}

Both PRUs therefore keep enqueuing frames, and the shared poll has no
per-port liveness check, so it keeps draining both host queues and calls

	ret = icssm_emac_rx_packet(emac_p, &update_rd_ptr,
				   pkt_info_p, rxqueue_p);

for the port that was just stopped, which ends in netif_receive_skb() with
skb->dev set to the closed interface, plus stats and FDB updates for it.

Both shared NAPIs and prueth->hp->ndev / prueth->lp->ndev are bound to the
MII0 netdev, and icssm_prueth_remove() unregisters registered_netdevs[0]
first. Its dev_close() takes the early-return path while MII1 is still
configured, so can the shared IRQ and NAPI still deliver skbs into an
already unregistered net_device and re-schedule NAPI on it?

Before this patch each port tore down its own IRQ and NAPI unconditionally in
its own ndo_stop.

>  	/* stop the PRU */
>  	if (!PRUETH_IS_EMAC(prueth))
>  		icssm_prueth_sw_shutdown_prus(emac, ndev);

[ ... ]

> @@ -1766,9 +1817,25 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>  
>  	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
>  
> +	if ((prueth->support_lre || fw_data->support_switch) &&
> +	    emac->port_id == PRUETH_PORT_MII0) {
> +		netif_napi_add(ndev, &prueth->napi_hpq,
> +			       icssm_prueth_lre_napi_poll_hpq);
> +		netif_napi_add(ndev, &prueth->napi_lpq,
> +			       icssm_prueth_lre_napi_poll_lpq);
> +	}
> +

[Severity: Low]
[Finding: fable-5-2-8]
[Sources: fable-5, sonnet-5]

This isn't a bug, but the names are scoped to LRE while the polls are also
used by switch (RSTP) mode, which the same patch configures via
icssm_prueth_sw_config_packet_timestamping(). The same applies to the comment
in icssm_prueth_common_free_irqs():

	/* HSR/PRP: free irqs when last port is down */

although icssm_emac_ndo_stop() calls it for every !PRUETH_IS_EMAC(prueth)
mode, switch included. Would icssm_prueth_common_napi_poll_hpq/_lpq and a
comment mentioning switch as well be more accurate?

>  	hrtimer_setup(&emac->tx_hrtimer, &icssm_emac_tx_timer_callback,
>  		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
>  
> +	if ((prueth->support_lre || fw_data->support_switch) &&
> +	    emac->port_id == PRUETH_PORT_MII0) {
> +		prueth->hp->ndev = ndev;
> +		prueth->hp->priority = 0;
> +		prueth->lp->ndev = ndev;
> +		prueth->lp->priority = 1;
> +	}
> +
>  	return 0;
>  free:
>  	emac->ndev = NULL;

[ ... ]

> @@ -2093,7 +2168,13 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, prueth);
>  	prueth->dev = dev;
>  	prueth->fw_data = device_get_match_data(dev);
> -	prueth->fw_offsets = fw_offsets_v2_1;
> +
> +	if (prueth->fw_data->fw_rev == FW_REV_V1_0)
> +		prueth->fw_offsets = fw_offsets_v1_0;
> +	else if (prueth->fw_data->fw_rev == FW_REV_V2_1)
> +		prueth->fw_offsets = fw_offsets_v2_1;
> +	else
> +		return -EINVAL;
>  
>  	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
>  	if (!eth_ports_node)

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> index a5d5bcd08bcdb..9af19617967ee 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h

[ ... ]

> @@ -197,24 +208,26 @@ enum pruss_device {
>  struct prueth_emac_stats {
> -	u64 tx_packets;
> -	u64 tx_dropped;
> -	u64 tx_bytes;
> -	u64 rx_packets;
> -	u64 rx_bytes;
> -	u64 rx_length_errors;
> -	u64 rx_over_errors;
> +	atomic64_t tx_packets;
> +	atomic64_t tx_dropped;
> +	atomic64_t tx_bytes;
> +	atomic64_t rx_packets;
> +	atomic64_t rx_bytes;
> +	atomic64_t rx_length_errors;
> +	atomic64_t rx_over_errors;
>  };

[Severity: Medium]
[Finding: fable-5-1-2]
[Sources: fable-5, opus-5]

Could the commit message mention the changes beyond the RX IRQ handlers?

The changelog says:

	Dual-EMAC mode continues to use per-port interrupts.

but the patch also converts every counter in struct prueth_emac_stats from
u64 to atomic64_t and rewrites all seven update sites plus
icssm_emac_ndo_get_stats64(), which adds an atomic read-modify-write per
packet and per byte to the dual-EMAC TX and RX hot paths on 32-bit ARM.

Two further undescribed changes: the new enum fw_revision plus fw_rev in the
three platform data entries makes icssm_prueth_probe() return -EINVAL when
fw_rev is unset, a new probe failure mode for any platform data added later
without it, and icssm_emac_ndo_stop() gains netif_stop_queue().

The atomic conversion looks required by the new design, since napi_hpq and
napi_lpq can run concurrently on different CPUs and both update the same
emac counters. Documentation/networking/statistics.rst points at
u64_stats_sync for per-device packet and byte counters rather than
atomic64_t; would that be preferable here, and could the conversion be split
into its own patch?

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> new file mode 100644
> index 0000000000000..43140add81725
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> @@ -0,0 +1,281 @@

[ ... ]

> +static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
> +					       int quota, u8 qid1, u8 qid2)
> +{

[ ... ]

> +	prueth = emac->prueth;
> +	ocmc_ram = prueth->mem[PRUETH_MEM_OCMC].va;
> +	shared_ram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
> +	other_emac = prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
> +			PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
> +
> +	iep_wrap = prueth->fw_offsets.iep_wrap;
> +	/* search host queues for packets */
> +	queue_desc = emac->rx_queue_descs + qid1;
> +	queue_desc_o = other_emac->rx_queue_descs + qid2;
> +
> +	rxqueue = &sw_queue_infos[PRUETH_PORT_HOST][qid1];
> +	rxqueue_o = &sw_queue_infos[PRUETH_PORT_HOST][qid2];
> +
> +	/* skip Rx if budget is 0 */
> +	if (!quota)
> +		return 0;
> +
> +	overflow_cnt = readb(&queue_desc->overflow_cnt);
> +	overflow_cnt_o = readb(&queue_desc_o->overflow_cnt);

[Severity: High]
[Finding: fable-5-3-13]
[Sources: fable-5, opus-5]

Can other_emac->rx_queue_descs be NULL or stale here?

rx_queue_descs is assigned only in the opening port's own ndo_open path, via
icssm_prueth_sw_emac_config() -> icssm_prueth_sw_port_config():

	emac->rx_queue_descs = dram1_base + P0_QUEUE_DESC_OFFSET;

The shared HP and LP IRQs are requested and both shared NAPIs enabled on the
first port open, while prueth->emac_configured is still 0, and
icssm_prueth_sw_boot_prus() boots both PRUs, so the first HP/LP interrupt can
run this poll while the peer port has never been opened in this mode.

icssm_prueth_change_mode() only stops and reopens ports for which
netif_running() was true:

	portstatus[i] = netif_running(ndev);
	if (!portstatus[i])
		continue;

so this sequence enters switch mode with eth1 never configured:

	ip link set eth0 down
	ip link set eth1 down
	ip link set eth0 master br0
	ip link set eth1 master br0
	ip link set eth0 up

If eth1 has never been opened since probe, rx_queue_descs is the zeroed value
from devm_alloc_etherdev() and readb(&queue_desc_o->overflow_cnt) reads a
small fixed address. If eth1 was last opened in dual-EMAC mode, it still
holds the EMAC value sram + HOST_QUEUE_DESC_OFFSET rather than
dram1 + P0_QUEUE_DESC_OFFSET, so the rd/wr pointers read from it are used as
offsets into shared RAM and OCMC below and a bogus rd_ptr is written back
with writew(). The same recipe applies to HSR/PRP when only one slave is
brought up.

Should the poll skip a port that has no descriptors configured for the
current mode? This looks unchanged at the end of the series, where
icssm_prueth_lre_port_config() also sets rx_queue_descs per port.

> +
> +	if (overflow_cnt > 0) {
> +		atomic64_add(overflow_cnt, &emac->stats.rx_over_errors);
> +		writeb(0, &queue_desc->overflow_cnt);
> +	}
> +	if (overflow_cnt_o > 0) {
> +		atomic64_add(overflow_cnt_o, &other_emac->stats.rx_over_errors);
> +		writeb(0, &queue_desc_o->overflow_cnt);
> +	}
> +
> +	bd_rd_ptr = readw(&queue_desc->rd_ptr);
> +	bd_wr_ptr = readw(&queue_desc->wr_ptr);
> +
> +	bd_rd_ptr_o = readw(&queue_desc_o->rd_ptr);
> +	bd_wr_ptr_o = readw(&queue_desc_o->wr_ptr);
> +
> +	port0_q_empty = (bd_rd_ptr == bd_wr_ptr);
> +	port1_q_empty = (bd_rd_ptr_o == bd_wr_ptr_o);
> +
> +	while (!port0_q_empty || !port1_q_empty) {
> +		rd_buf_desc = readl(shared_ram + bd_rd_ptr);
> +		rd_buf_desc_o = readl(shared_ram + bd_rd_ptr_o);
> +
> +		icssm_parse_packet_info(prueth, rd_buf_desc, &pkt_info);
> +		icssm_parse_packet_info(prueth, rd_buf_desc_o, &pkt_info_o);
> +
> +		pkt_ts = readl(ocmc_ram + ICSS_LRE_TIMESTAMP_ARRAY_OFFSET +
> +			       bd_rd_ptr - SRAM_START_OFFSET);
> +		pkt_ts_o = readl(ocmc_ram + ICSS_LRE_TIMESTAMP_ARRAY_OFFSET +
> +				 bd_rd_ptr_o - SRAM_START_OFFSET);

[ ... ]

> +		if (used >= quota)
> +			return used;
> +	}
> +
> +	return used;
> +}
> +
> +int icssm_prueth_lre_napi_poll_lpq(struct napi_struct *napi, int budget)
> +{

[ ... ]

> +	num_rx_packets = icssm_prueth_common_emac_rx_packets(emac, budget,
> +							     qid1, qid2);
> +	if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
> +		enable_irq(prueth->rx_lpq_irq);
> +
> +	return num_rx_packets;
> +}

[Severity: Medium]
[Finding: fable-5-5-25]
[Sources: fable-5, opus-5]

Can this enable_irq() run after the matching free_irq()?

enable_irq() happens after napi_complete_done() has already cleared
NAPIF_STATE_SCHED, and napi_disable() waits only on that bit, so in
icssm_emac_ndo_stop():

	napi_disable(&prueth->napi_lpq);
	napi_disable(&prueth->napi_hpq);
	icssm_prueth_common_free_irqs(emac);   /* -> free_irq() */

can complete while the poll has not yet reached enable_irq(). free_irq()
shuts the line down leaving depth 1, so the late enable_irq() re-enables a
line with no handler, giving an unbalanced enable warning or an unhandled
interrupt storm, or a skewed disable depth against the next request_irq().

The open error path has the same inversion: icssm_emac_ndo_open() enables
napi_hpq and napi_lpq before requesting the IRQs, and when the LPQ
request_irq() fails icssm_prueth_common_request_irqs() does

free_rx_hpq_irq:
	free_irq(prueth->rx_hpq_irq, prueth->hp);

while napi_hpq is enabled and possibly mid-poll; napi_disable() only runs
later at the disable_napi: label. Would requesting the IRQs before enabling
the NAPIs, and disabling the NAPIs before freeing them, close this?

The same enable_irq()-after-napi_complete_done() pattern already exists in
the dual-EMAC icssm_emac_napi_poll(), so the idiom is not new, but the open
path ordering is introduced here.

[ ... ]

> +/**
> + * icssm_prueth_common_free_irqs - free irq
> + *
> + * @emac: EMAC data structure
> + *
> + */
> +void icssm_prueth_common_free_irqs(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth = emac->prueth;
> +
> +	/* HSR/PRP: free irqs when last port is down */
> +	if (prueth->emac_configured)
> +		return;
> +
> +	free_irq(prueth->rx_lpq_irq, prueth->lp);
> +	free_irq(prueth->rx_hpq_irq, prueth->hp);
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
> index 66866ea37913f..9d67fc7c23acc 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
> @@ -886,6 +886,14 @@ void icssm_prueth_sw_hostconfig(struct prueth *prueth)
>  		    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
>  }
>  
> +void icssm_prueth_sw_config_packet_timestamping(struct prueth *prueth)
> +{
> +	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
> +
> +	writeb(1, sram + SWITCH_PRIORITY_INTRS_STATUS_OFFSET);
> +	writeb(1, sram + SWITCH_TIMESTAMP_PKTS_STATUS_OFFSET);
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
> index 5ba9ce14da445..13b1b93ef4c27 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
> +++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
> @@ -331,6 +331,12 @@
>  #define P0_COL_BUFFER_OFFSET	0xEE00
>  #define P0_Q1_BUFFER_OFFSET	0x0000
>  
> +/* Enable/disable interrupts for high/low priority instead of per port.
> + * 0 = disabled (default), 1 = enabled
> + */
> +#define SWITCH_PRIORITY_INTRS_STATUS_OFFSET	0x1FAA
> +#define SWITCH_TIMESTAMP_PKTS_STATUS_OFFSET	0x1FAB

[Severity: Low]
[Finding: main-2-4]
[Sources: opus-5, sonnet-5]

Are these two defines in the right section of the header?

They land in the block the header labels

	/* Memory Usage of L3 OCMC RAM */

right after P0_COL_BUFFER_OFFSET and P0_Q1_BUFFER_OFFSET, but the only
consumer, icssm_prueth_sw_config_packet_timestamping(), writes them into
prueth->mem[PRUETH_MEM_SHARED_RAM].va. Their values also match the shared RAM
constants ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET and
ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET in icssm_lre_firmware.h, so the writes
themselves look fine and only the placement is off.

The duplication is asymmetric too: switch-named mirrors are added for the two
status bytes, yet icssm_prueth_common_emac_rx_packets() reads the arrival
timestamps for switch-mode frames through the LRE-only
ICSS_LRE_TIMESTAMP_ARRAY_OFFSET, and the switch memory map has no entry
saying the switch firmware publishes that array at the same offset. Does the
switch firmware place the timestamp array there, and could the switch memory
map document it?

>  #define V2_1_FDB_TBL_LOC          PRUETH_MEM_SHARED_RAM
>  #define V2_1_FDB_TBL_OFFSET       0x2000
-- 
This is an AI-generated review.

