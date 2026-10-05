Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648444CE66B;
	Mon,  5 Oct 2026 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215279; cv=none; b=p7tZ50Bz7dv7yk2fE/n6GcFmEmE+QqwWzUzcZDgQNMxbbEMu86M9EOKDUSYboMbpbkSLSkvfXzGrWgGBWNnKbDf7gKS/LHwoycCojEwC8zErtd8pj6+uqMe+Jm8/m7shOJAkMvo/lqx6gYm1wbIj7pKGhk6X6TGJfKWzK9kMNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215279; c=relaxed/simple;
	bh=Ke9AD1vG/sthFtjwpPp2Yay8uO/v/VN1xwJFIxxGtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS9xHZB/Zuf3JSBBlWSc2hYFM2Be8rQg7nkr52iF92oubr9tpANolUQdGk4FjbjseFXvtqNEhcHpkCpvNWq41lgeNvxbjgGRmY2QI02KF0EkkpyIpHLvdYEK4q9zZ/4Gipbb8YdvXqdDyrFFFPydwXeu9tAvbZiORwBtYHF4u04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=md1cSpLw; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="md1cSpLw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kUpBE3sngBUcUxUEcS7Au3pbTdv8T994qlgDmuoV1d4=; b=md1cSpLw4ZZ8WneVX6YCA7oLxy
	wDmMdy8qqsMUjwCnExqXsbWYiiZ80Q9/V0gjlpm5SOI+al3yUBDTOlBhIiBq+0nW2jrMvH1L4EfAD
	z21JW+HlXJfTFbItmPKt0vNMiV+wqw1vHjyukwG/XG8Rb1SF/lP8a3JWt3mVQZ/zVn1mLDfn2KHJ7
	byvkSEXCl8GHb72WIhVVTadhvefFiunvpnNB+B4JRJ6ZLXUyKNVKpTOIEkH55rLBhoZXco58x2HFq
	DN675KP49V62hNxtBQIygB2q8KuJKuaKV0MQq45Xjx+5bHXruw78tcCbV0IHguCCBaAM9li/9Clha
	vSj1l9+w==;
Received: from [115.246.246.98] (port=10743 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <parvathi@couthit.com>)
	id 1xDkuv-000000054er-3tdg;
	Mon, 05 Oct 2026 11:47:54 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	vadim.fedorenko@linux.dev,
	haokexin@gmail.com,
	basharath@couthit.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	horms@kernel.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v5 2/3] net: ti: icssm-prueth: Add priority based RX IRQ handlers
Date: Mon,  5 Oct 2026 21:11:58 +0530
Message-ID: <20261005154654.576663-3-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005154654.576663-1-parvathi@couthit.com>
References: <20261005154654.576663-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

This patch adds support for priority based interrupt handling for the STP/
RSTP Switch, HSR and PRP protocols along with extra logic to address first
come first served to avoid port dominance.

In RSTP switch, HSR, and PRP modes the host port can receive frames from
any one of PRU ports. Servicing RX interrupts in arrival order does not
guarantee the frames are delivered to the stack in wire-arrival order due
to port dominance.

In order to achieve that, each PRU records an IEP (Industrial Ethernet
Peripheral) arrival HW timestamp into the receive buffer and pass this
information to driver. The driver will read the RX HW timestamp from frame
and process the frame which has arrived first among the two ports, giving
the stack wire-arrival ordering.

Dual-EMAC mode continues to use per-port interrupts.

Also convert struct prueth_emac_stats counters from u64 to atomic64_t,
since napi_hpq and napi_lpq can now run concurrently on different CPUs
and update the same counters.

The IEP wrap value used in the timestamp comparison differs between
firmware revisions, so this patch adds an fw_rev field to the platform
data and an enum fw_revision to identify it. icssm_prueth_probe() now
fails with -EINVAL if a platform data entry does not set fw_rev.

icssm_emac_ndo_stop() now stops TX before cancelling the TX timer.
The timer and link-up handlers restart the TX queue only when the port
is started.

Since icssm_prueth_change_mode() calls ndo_stop() while the device is
still running, TX should not restart while the shared RX/TX resources
are being changed or cleaned up.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 183 +++++++++--
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  44 ++-
 .../ethernet/ti/icssm/icssm_prueth_common.c   | 309 ++++++++++++++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.c  |  13 +
 .../ethernet/ti/icssm/icssm_prueth_switch.c   |   8 +
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   1 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |   6 +
 8 files changed, 526 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_common.c

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index e4a10d60e1a6..b6651fe73afd 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
-icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o icssm/icssm_prueth_lre.o
+icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o icssm/icssm_prueth_lre.o icssm/icssm_prueth_common.o
 
 ti-cpsw-common-y += cpsw-common.o davinci_cpdma.o
 ti-cpsw-priv-y += cpsw_priv.o cpsw_ethtool.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 453c9b259d77..42c83946f17a 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -44,6 +44,21 @@
 #define NETIF_PRUETH_LRE_OFFLOAD_FEATURES       (NETIF_F_HW_HSR_FWD | \
 						 NETIF_F_HW_HSR_TAG_RM)
 
+/* ICSSM (v2.1) - supports 64-bit IEP counter.
+ * Firmware stores packet timestamps using lower 32 bits
+ * which wraps at 0xffffffff.
+ */
+static const struct prueth_fw_offsets fw_offsets_v2_1 = {
+	.iep_wrap = 0xffffffff,
+};
+
+/* ICSSM (v1.0) - supports 32-bit IEP counter, which resets the
+ * counter every one second (nanosecond resolution).
+ */
+static const struct prueth_fw_offsets fw_offsets_v1_0 = {
+	.iep_wrap = NSEC_PER_SEC,
+};
+
 static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
 {
 	/* Set Multicast filter control and table offsets */
@@ -342,6 +357,8 @@ static void icssm_prueth_init_ethernet_mode(struct prueth *prueth)
 	icssm_prueth_hostinit(prueth);
 	if (prueth_is_lre(prueth))
 		icssm_prueth_lre_config(prueth);
+	else if (PRUETH_IS_SWITCH(prueth))
+		icssm_prueth_sw_config_packet_timestamping(prueth);
 }
 
 static void icssm_prueth_port_enable(struct prueth_emac *emac, bool enable)
@@ -464,7 +481,8 @@ static void icssm_emac_adjust_link(struct net_device *ndev)
 
 	if (emac->link) {
 	       /* reactivate the transmit queue if it is stopped */
-		if (netif_running(ndev) && netif_queue_stopped(ndev))
+		if (netif_running(ndev) && netif_queue_stopped(ndev) &&
+		    (prueth->emac_configured & BIT(emac->port_id)))
 			netif_wake_queue(ndev);
 	} else {
 		if (!netif_queue_stopped(ndev))
@@ -801,8 +819,8 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	local_bh_enable();
 
 	/* update stats */
-	emac->stats.rx_bytes += actual_pkt_len;
-	emac->stats.rx_packets++;
+	atomic64_add(actual_pkt_len, &emac->stats.rx_bytes);
+	atomic64_inc(&emac->stats.rx_packets);
 
 	return 0;
 }
@@ -824,7 +842,6 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 
 	shared_ram = emac->prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 
-	/* Start and end queue is made common for EMAC, RSTP */
 	start_queue = emac->rx_queue_start;
 	end_queue = emac->rx_queue_end;
 
@@ -835,13 +852,10 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 	/* search host queues for packets */
 	for (i = start_queue; i <= end_queue; i++) {
 		queue_desc = emac->rx_queue_descs + i;
-		if (PRUETH_IS_SWITCH(emac->prueth))
-			rxqueue = &sw_queue_infos[PRUETH_PORT_HOST][i];
-		else
-			rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
+		rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
 		overflow_cnt = readb(&queue_desc->overflow_cnt);
 		if (overflow_cnt > 0) {
-			emac->stats.rx_over_errors += overflow_cnt;
+			atomic64_add(overflow_cnt, &emac->stats.rx_over_errors);
 			/* reset to zero */
 			writeb(0, &queue_desc->overflow_cnt);
 		}
@@ -863,7 +877,7 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 				 * these packets
 				 */
 				update_rd_ptr = bd_wr_ptr;
-				emac->stats.rx_length_errors++;
+				atomic64_inc(&emac->stats.rx_length_errors);
 			} else if (pkt_info.length > EMAC_MAX_FRM_SUPPORT) {
 				/* if the packet is too large we skip it but we
 				 * still need to move the read pointer ahead
@@ -872,7 +886,7 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 				 * these packets
 				 */
 				update_rd_ptr = bd_wr_ptr;
-				emac->stats.rx_length_errors++;
+				atomic64_inc(&emac->stats.rx_length_errors);
 			} else {
 				update_rd_ptr = bd_rd_ptr;
 				ret = icssm_emac_rx_packet(emac, &update_rd_ptr,
@@ -1070,19 +1084,33 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 			goto iep_exit;
 	}
 
-	ret = icssm_emac_request_irqs(emac);
-	if (ret)
-		goto rproc_shutdown;
+	if (PRUETH_IS_EMAC(prueth)) {
+		napi_enable(&emac->napi);
+	} else {
+		if (!prueth->emac_configured &&
+		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
+			napi_enable(&prueth->napi_hpq);
+			napi_enable(&prueth->napi_lpq);
+		}
+	}
 
-	napi_enable(&emac->napi);
+	/* In switch and LRE modes the shared HPQ/LPQ IRQs are used,
+	 * register them here and reuse for both modes.
+	 */
+	if (PRUETH_IS_EMAC(prueth))
+		ret = icssm_emac_request_irqs(emac);
+	else
+		ret = icssm_prueth_common_request_irqs(emac);
+	if (ret)
+		goto disable_napi;
 
+	prueth->emac_configured |= BIT(emac->port_id);
 	/* start PHY */
 	phy_start(emac->phydev);
 
 	/* enable the port and vlan */
 	icssm_prueth_port_enable(emac, true);
 
-	prueth->emac_configured |= BIT(emac->port_id);
 	if (PRUETH_IS_SWITCH(prueth))
 		icssm_prueth_sw_set_stp_state(prueth, emac->port_id,
 					      BR_STATE_LEARNING);
@@ -1091,7 +1119,10 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 
 	return 0;
 
-rproc_shutdown:
+disable_napi:
+	if (PRUETH_IS_EMAC(prueth))
+		napi_disable(&emac->napi);
+
 	if (!PRUETH_IS_EMAC(prueth))
 		icssm_prueth_sw_shutdown_prus(emac, ndev);
 	else
@@ -1126,11 +1157,28 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
 	/* disable the mac port */
 	icssm_prueth_port_enable(emac, false);
 
+	/* Stop TX first. netif_tx_disable() also waits for an xmit that is
+	 * already running. Then cancel any tx_hrtimer that xmit may have
+	 * armed.
+	 */
+	netif_tx_disable(ndev);
+	hrtimer_cancel(&emac->tx_hrtimer);
+
 	/* stop PHY */
 	phy_stop(emac->phydev);
 
-	napi_disable(&emac->napi);
-	hrtimer_cancel(&emac->tx_hrtimer);
+	if (PRUETH_IS_EMAC(prueth)) {
+		napi_disable(&emac->napi);
+		free_irq(emac->rx_irq, ndev);
+	} else {
+		if (!prueth->emac_configured &&
+		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
+			napi_disable(&prueth->napi_lpq);
+			napi_disable(&prueth->napi_hpq);
+		}
+		/* Free IRQs on last port before halting PRU */
+		icssm_prueth_common_free_irqs(emac);
+	}
 
 	/* stop the PRU */
 	if (!PRUETH_IS_EMAC(prueth))
@@ -1141,9 +1189,6 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
 	if (prueth_is_lre(prueth) && !prueth->emac_configured)
 		icssm_prueth_lre_cleanup(prueth);
 
-	/* free rx interrupts */
-	free_irq(emac->rx_irq, ndev);
-
 	/* free memory related to sw */
 	icssm_prueth_free_memory(emac->prueth);
 
@@ -1280,8 +1325,8 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
 		goto fail_tx;
 	}
 
-	emac->stats.tx_packets++;
-	emac->stats.tx_bytes += skb->len;
+	atomic64_inc(&emac->stats.tx_packets);
+	atomic64_add(skb->len, &emac->stats.tx_bytes);
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
@@ -1295,7 +1340,7 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
 		ret = NETDEV_TX_BUSY;
 	} else {
 		/* error */
-		emac->stats.tx_dropped++;
+		atomic64_inc(&emac->stats.tx_dropped);
 		ret = NET_XMIT_DROP;
 	}
 
@@ -1315,13 +1360,13 @@ static void icssm_emac_ndo_get_stats64(struct net_device *ndev,
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
-	stats->rx_packets = emac->stats.rx_packets;
-	stats->rx_bytes = emac->stats.rx_bytes;
-	stats->tx_packets = emac->stats.tx_packets;
-	stats->tx_bytes = emac->stats.tx_bytes;
-	stats->tx_dropped = emac->stats.tx_dropped;
-	stats->rx_over_errors = emac->stats.rx_over_errors;
-	stats->rx_length_errors = emac->stats.rx_length_errors;
+	stats->rx_packets = atomic64_read(&emac->stats.rx_packets);
+	stats->rx_bytes = atomic64_read(&emac->stats.rx_bytes);
+	stats->tx_packets = atomic64_read(&emac->stats.tx_packets);
+	stats->tx_bytes = atomic64_read(&emac->stats.tx_bytes);
+	stats->tx_dropped = atomic64_read(&emac->stats.tx_dropped);
+	stats->rx_over_errors = atomic64_read(&emac->stats.rx_over_errors);
+	stats->rx_length_errors = atomic64_read(&emac->stats.rx_length_errors);
 }
 
 /* enable/disable MC filter */
@@ -1662,6 +1707,11 @@ static enum hrtimer_restart icssm_emac_tx_timer_callback(struct hrtimer *timer)
 {
 	struct prueth_emac *emac =
 			container_of(timer, struct prueth_emac, tx_hrtimer);
+	struct prueth *prueth = emac->prueth;
+
+	/* Don't restart TX on a port that ndo_stop() is tearing down */
+	if (!(READ_ONCE(prueth->emac_configured) & BIT(emac->port_id)))
+		return HRTIMER_NORESTART;
 
 	if (netif_queue_stopped(emac->ndev))
 		netif_wake_queue(emac->ndev);
@@ -1779,9 +1829,25 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 
 	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
 
+	if ((prueth->support_lre || fw_data->support_switch) &&
+	    emac->port_id == PRUETH_PORT_MII0) {
+		netif_napi_add(ndev, &prueth->napi_hpq,
+			       icssm_prueth_common_napi_poll_hpq);
+		netif_napi_add(ndev, &prueth->napi_lpq,
+			       icssm_prueth_common_napi_poll_lpq);
+	}
+
 	hrtimer_setup(&emac->tx_hrtimer, &icssm_emac_tx_timer_callback,
 		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 
+	if ((prueth->support_lre || fw_data->support_switch) &&
+	    emac->port_id == PRUETH_PORT_MII0) {
+		prueth->hp->ndev = ndev;
+		prueth->hp->priority = 0;
+		prueth->lp->ndev = ndev;
+		prueth->lp->priority = 1;
+	}
+
 	return 0;
 free:
 	emac->ndev = NULL;
@@ -1793,6 +1859,7 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 static void icssm_prueth_netdev_exit(struct prueth *prueth,
 				     struct device_node *eth_node)
 {
+	const struct prueth_private_data *fw_data = prueth->fw_data;
 	struct prueth_emac *emac;
 	enum prueth_mac mac;
 
@@ -1807,6 +1874,13 @@ static void icssm_prueth_netdev_exit(struct prueth *prueth,
 	phy_disconnect(emac->phydev);
 
 	netif_napi_del(&emac->napi);
+
+	if ((prueth->support_lre || fw_data->support_switch) &&
+	    emac->port_id == PRUETH_PORT_MII0) {
+		netif_napi_del(&prueth->napi_hpq);
+		netif_napi_del(&prueth->napi_lpq);
+	}
+
 	prueth->emac[mac] = NULL;
 }
 
@@ -2110,6 +2184,13 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, prueth);
 	prueth->dev = dev;
 	prueth->fw_data = device_get_match_data(dev);
+	if (prueth->fw_data->fw_rev == FW_REV_V1_0)
+		prueth->fw_offsets = fw_offsets_v1_0;
+	else if (prueth->fw_data->fw_rev == FW_REV_V2_1)
+		prueth->fw_offsets = fw_offsets_v2_1;
+	else
+		return -EINVAL;
+
 	icssm_prueth_set_fw_offsets(prueth);
 
 	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
@@ -2265,6 +2346,41 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	if (has_lre && (!eth0_node || !eth1_node))
 		has_lre = false;
 
+	/* Switch and LRE share HPQ/LPQ IRQs across both ports,
+	 * allocate the shared priority structures once here
+	 */
+	if (prueth->fw_data->support_switch || has_lre) {
+		prueth->hp = devm_kzalloc(dev,
+					  sizeof(struct prueth_ndev_priority),
+					  GFP_KERNEL);
+		if (!prueth->hp) {
+			ret = -ENOMEM;
+			goto free_pool;
+		}
+		prueth->lp = devm_kzalloc(dev,
+					  sizeof(struct prueth_ndev_priority),
+					  GFP_KERNEL);
+		if (!prueth->lp) {
+			ret = -ENOMEM;
+			goto free_pool;
+		}
+
+		prueth->rx_lpq_irq = of_irq_get_byname(np, "rx_lp");
+		if (prueth->rx_lpq_irq < 0) {
+			ret = prueth->rx_lpq_irq;
+			if (ret != -EPROBE_DEFER)
+				dev_err(prueth->dev, "could not get rx_lp irq\n");
+			goto free_pool;
+		}
+		prueth->rx_hpq_irq = of_irq_get_byname(np, "rx_hp");
+		if (prueth->rx_hpq_irq < 0) {
+			ret = prueth->rx_hpq_irq;
+			if (ret != -EPROBE_DEFER)
+				dev_err(prueth->dev, "could not get rx_hp irq\n");
+			goto free_pool;
+		}
+	}
+
 	prueth->support_lre = has_lre;
 	spin_lock_init(&prueth->addr_lock);
 	/* setup netdev interfaces */
@@ -2505,6 +2621,7 @@ static struct prueth_private_data am335x_prueth_pdata = {
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am335x-pru1-prusw-fw.elf",
 	},
+	.fw_rev = FW_REV_V1_0,
 	.support_lre = true,
 	.support_switch = true,
 };
@@ -2532,6 +2649,7 @@ static struct prueth_private_data am437x_prueth_pdata = {
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am437x-pru1-prusw-fw.elf",
 	},
+	.fw_rev = FW_REV_V1_0,
 	.support_lre = true,
 	.support_switch = true,
 };
@@ -2560,6 +2678,7 @@ static struct prueth_private_data am57xx_prueth_pdata = {
 			"ti-pruss/am57xx-pru1-prusw-fw.elf",
 
 	},
+	.fw_rev = FW_REV_V2_1,
 	.support_lre = true,
 	.support_switch = true,
 };
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index a5d5bcd08bcd..8cca5b87d4ff 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -179,11 +179,22 @@ enum prueth_mem {
 	PRUETH_MEM_MAX,
 };
 
+/* PRU firmware revision */
+enum fw_revision {
+	FW_REV_INVALID = 0,
+	FW_REV_V1_0,
+	FW_REV_V2_1
+};
+
 /* Firmware offsets/size information */
 struct prueth_fw_offsets {
 	u32 mc_ctrl_offset;
 	u32 mc_filter_mask;
 	u32 mc_filter_tbl;
+	/* IEP wrap is used in the rx packet ordering logic and
+	 * is different for ICSSM v1.0 vs 2.1
+	 */
+	u32 iep_wrap;
 };
 
 enum pruss_device {
@@ -197,24 +208,26 @@ enum pruss_device {
  * struct prueth_private_data - PRU Ethernet private data
  * @driver_data: PRU Ethernet device name
  * @fw_pru: firmware names to be used for PRUSS ethernet usecases
+ * @fw_rev: Firmware revision identifier
  * @support_switch: boolean to indicate if switch is enabled
  * @support_lre: boolean to indicate if LRE is enabled
  */
 struct prueth_private_data {
 	enum pruss_device driver_data;
 	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
+	enum fw_revision fw_rev;
 	bool support_switch;
 	bool support_lre;
 };
 
 struct prueth_emac_stats {
-	u64 tx_packets;
-	u64 tx_dropped;
-	u64 tx_bytes;
-	u64 rx_packets;
-	u64 rx_bytes;
-	u64 rx_length_errors;
-	u64 rx_over_errors;
+	atomic64_t tx_packets;
+	atomic64_t tx_dropped;
+	atomic64_t tx_bytes;
+	atomic64_t rx_packets;
+	atomic64_t rx_bytes;
+	atomic64_t rx_length_errors;
+	atomic64_t rx_over_errors;
 };
 
 /* data for each emac port */
@@ -255,6 +268,11 @@ struct prueth_emac {
 	int offload_fwd_mark;
 };
 
+struct prueth_ndev_priority {
+	struct net_device *ndev;
+	int priority;
+};
+
 struct prueth {
 	struct device *dev;
 	struct pruss *pruss;
@@ -270,6 +288,12 @@ struct prueth {
 	struct device_node *eth_node[PRUETH_NUM_MACS];
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
+	struct prueth_ndev_priority *hp, *lp;
+	/* NAPI for lp and hp queue scans */
+	struct napi_struct napi_lpq;
+	struct napi_struct napi_hpq;
+	int rx_lpq_irq;
+	int rx_hpq_irq;
 
 	bool support_lre;
 	unsigned int tbl_check_mask;
@@ -303,6 +327,12 @@ void icssm_emac_mc_filter_bin_allow(struct prueth_emac *emac, u8 hash);
 void icssm_emac_mc_filter_bin_disallow(struct prueth_emac *emac, u8 hash);
 u8 icssm_emac_get_mc_hash(u8 *mac, u8 *mask);
 
+int icssm_prueth_common_napi_poll_lpq(struct napi_struct *napi, int budget);
+int icssm_prueth_common_napi_poll_hpq(struct napi_struct *napi, int budget);
+
+int icssm_prueth_common_request_irqs(struct prueth_emac *emac);
+void icssm_prueth_common_free_irqs(struct prueth_emac *emac);
+
 static inline bool prueth_is_lre(struct prueth *prueth)
 {
 	return PRUETH_IS_HSR(prueth) || PRUETH_IS_PRP(prueth);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
new file mode 100644
index 000000000000..1a5e5a84345e
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSM Ethernet Driver
+ *
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/if_vlan.h>
+
+#include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+
+static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
+					       int quota, u8 qid1, u8 qid2)
+{
+	u16 bd_rd_ptr, bd_wr_ptr, update_rd_ptr, bd_rd_ptr_o, bd_wr_ptr_o;
+	const struct prueth_queue_info *rxqueue, *rxqueue_o, *rxqueue_p;
+	struct prueth_packet_info pkt_info, pkt_info_o, *pkt_info_p;
+	u32 rd_buf_desc, rd_buf_desc_o, pkt_ts, pkt_ts_o, iep_wrap;
+	int ret, used = 0, port, port0_q_empty, port1_q_empty;
+	struct prueth_queue_desc __iomem *queue_desc_o = NULL;
+	struct prueth_queue_desc __iomem *queue_desc = NULL;
+	struct prueth_emac *emac_p, *other_emac;
+	void __iomem *shared_ram, *ocmc_ram;
+	bool port0_configured, port1_configured;
+	u8 overflow_cnt, overflow_cnt_o;
+	u16 *bd_rd_ptr_p, *bd_wr_ptr_p;
+	struct prueth *prueth;
+
+	prueth = emac->prueth;
+	ocmc_ram = prueth->mem[PRUETH_MEM_OCMC].va;
+	shared_ram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	other_emac = prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
+			PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
+
+	iep_wrap = prueth->fw_offsets.iep_wrap;
+	rxqueue = &sw_queue_infos[PRUETH_PORT_HOST][qid1];
+	rxqueue_o = &sw_queue_infos[PRUETH_PORT_HOST][qid2];
+
+	/* skip Rx if budget is 0 */
+	if (!quota)
+		return 0;
+
+	/* A port's rx_queue_descs is only valid once that port has
+	 * completed its own ndo_open() for the currently active mode:
+	 * before that it is NULL (never opened) or stale (opened in a
+	 * different mode), since the shared HP/LP IRQs and PRUs are
+	 * started as soon as the first port opens, independent of the
+	 * peer port's state. Treat an unconfigured port's queue as
+	 * permanently empty instead of dereferencing rx_queue_descs.
+	 */
+	port0_configured = prueth->emac_configured & BIT(emac->port_id);
+	port1_configured = other_emac &&
+			   (prueth->emac_configured & BIT(other_emac->port_id));
+
+	if (port0_configured) {
+		queue_desc = emac->rx_queue_descs + qid1;
+
+		overflow_cnt = readb(&queue_desc->overflow_cnt);
+		if (overflow_cnt > 0) {
+			atomic64_add(overflow_cnt, &emac->stats.rx_over_errors);
+			writeb(0, &queue_desc->overflow_cnt);
+		}
+
+		bd_rd_ptr = readw(&queue_desc->rd_ptr);
+		bd_wr_ptr = readw(&queue_desc->wr_ptr);
+		port0_q_empty = (bd_rd_ptr == bd_wr_ptr);
+	} else {
+		bd_rd_ptr = 0;
+		bd_wr_ptr = 0;
+		port0_q_empty = 1;
+	}
+
+	if (port1_configured) {
+		queue_desc_o = other_emac->rx_queue_descs + qid2;
+
+		overflow_cnt_o = readb(&queue_desc_o->overflow_cnt);
+		if (overflow_cnt_o > 0) {
+			atomic64_add(overflow_cnt_o,
+				     &other_emac->stats.rx_over_errors);
+			writeb(0, &queue_desc_o->overflow_cnt);
+		}
+
+		bd_rd_ptr_o = readw(&queue_desc_o->rd_ptr);
+		bd_wr_ptr_o = readw(&queue_desc_o->wr_ptr);
+		port1_q_empty = (bd_rd_ptr_o == bd_wr_ptr_o);
+	} else {
+		bd_rd_ptr_o = 0;
+		bd_wr_ptr_o = 0;
+		port1_q_empty = 1;
+	}
+
+	while (!port0_q_empty || !port1_q_empty) {
+		rd_buf_desc = readl(shared_ram + bd_rd_ptr);
+		rd_buf_desc_o = readl(shared_ram + bd_rd_ptr_o);
+
+		icssm_parse_packet_info(prueth, rd_buf_desc, &pkt_info);
+		icssm_parse_packet_info(prueth, rd_buf_desc_o, &pkt_info_o);
+
+		pkt_ts = readl(ocmc_ram + ICSS_LRE_TIMESTAMP_ARRAY_OFFSET +
+			       bd_rd_ptr - SRAM_START_OFFSET);
+		pkt_ts_o = readl(ocmc_ram + ICSS_LRE_TIMESTAMP_ARRAY_OFFSET +
+				 bd_rd_ptr_o - SRAM_START_OFFSET);
+
+		if (!port0_q_empty && !port1_q_empty) {
+			/* Both ports have a pending frame, pick the
+			 * earlier one by comparing timestamps and
+			 * account for wraparound.
+			 */
+			if (pkt_ts > pkt_ts_o)
+				port = (pkt_ts - pkt_ts_o) > (iep_wrap / 2) ?
+					0 : 1;
+			else
+				port = (pkt_ts_o - pkt_ts) > (iep_wrap / 2) ?
+					1 : 0;
+
+		} else if (!port0_q_empty) {
+			/* Packet(s) in port0 queue only */
+			port = 0;
+		} else {
+			/* Packet(s) in port1 queue only */
+			port = 1;
+		}
+
+		/* Select correct data structures for queue/packet selected */
+		if (port == 0) {
+			pkt_info_p = &pkt_info;
+			bd_wr_ptr_p = &bd_wr_ptr;
+			bd_rd_ptr_p = &bd_rd_ptr;
+			emac_p = emac;
+			rxqueue_p = rxqueue;
+		} else {
+			pkt_info_p = &pkt_info_o;
+			bd_wr_ptr_p = &bd_wr_ptr_o;
+			bd_rd_ptr_p = &bd_rd_ptr_o;
+			emac_p = other_emac;
+			rxqueue_p = rxqueue_o;
+		}
+
+		if ((*pkt_info_p).length < EMAC_MIN_PKTLEN) {
+			/* Undersized frame: firmware should have filtered
+			 * it, so the read pointer can't be trusted. Drop
+			 * everything pending in this queue by moving the
+			 * read pointer to the write pointer.
+			 */
+			update_rd_ptr = *bd_wr_ptr_p;
+			atomic64_inc(&emac_p->stats.rx_length_errors);
+		} else if ((*pkt_info_p).length > EMAC_MAX_FRM_SUPPORT) {
+			/* Oversized frame: same handling as above */
+			update_rd_ptr = *bd_wr_ptr_p;
+			atomic64_inc(&emac_p->stats.rx_length_errors);
+		} else {
+			update_rd_ptr = *bd_rd_ptr_p;
+			ret = icssm_emac_rx_packet(emac_p, &update_rd_ptr,
+						   pkt_info_p, rxqueue_p);
+			if (ret)
+				return used;
+
+			used++;
+		}
+
+		/* Zero the BD after consuming it, a misaligned rd_ptr
+		 * would otherwise mistake stale data for a valid incoming
+		 * frame.
+		 */
+		if (port == 0) {
+			writel(0, shared_ram + bd_rd_ptr);
+			writew(update_rd_ptr, &queue_desc->rd_ptr);
+			bd_rd_ptr = update_rd_ptr;
+		} else {
+			writel(0, shared_ram + bd_rd_ptr_o);
+			writew(update_rd_ptr, &queue_desc_o->rd_ptr);
+			bd_rd_ptr_o = update_rd_ptr;
+		}
+
+		port0_q_empty = (bd_rd_ptr == bd_wr_ptr) ? 1 : 0;
+		port1_q_empty = (bd_rd_ptr_o == bd_wr_ptr_o) ? 1 : 0;
+
+		if (used >= quota)
+			return used;
+	}
+
+	return used;
+}
+
+int icssm_prueth_common_napi_poll_lpq(struct napi_struct *napi, int budget)
+{
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	struct prueth *prueth;
+	int num_rx_packets;
+	u8 qid1, qid2;
+
+	prueth = container_of(napi, struct prueth, napi_lpq);
+	ndev = prueth->lp->ndev;
+	emac = netdev_priv(ndev);
+	qid1 = PRUETH_QUEUE2;
+	qid2 = PRUETH_QUEUE4;
+
+	num_rx_packets = icssm_prueth_common_emac_rx_packets(emac, budget,
+							     qid1, qid2);
+	if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
+		enable_irq(prueth->rx_lpq_irq);
+
+	return num_rx_packets;
+}
+
+int icssm_prueth_common_napi_poll_hpq(struct napi_struct *napi, int budget)
+{
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	struct prueth *prueth;
+	int num_rx_packets;
+	u8 qid1, qid2;
+
+	prueth = container_of(napi, struct prueth, napi_hpq);
+	ndev = prueth->hp->ndev;
+	emac = netdev_priv(ndev);
+	qid1 = PRUETH_QUEUE1;
+	qid2 = PRUETH_QUEUE3;
+
+	num_rx_packets = icssm_prueth_common_emac_rx_packets(emac, budget,
+							     qid1, qid2);
+	if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
+		enable_irq(prueth->rx_hpq_irq);
+
+	return num_rx_packets;
+}
+
+static irqreturn_t icssm_prueth_common_emac_rx_hardirq(int irq, void *dev_id)
+{
+	struct prueth_ndev_priority *ndev_prio;
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	struct prueth *prueth;
+
+	ndev_prio = (struct prueth_ndev_priority *)dev_id;
+	ndev = ndev_prio->ndev;
+	emac = netdev_priv(ndev);
+	prueth = emac->prueth;
+
+	/* disable Rx system event */
+	if (ndev_prio->priority == 1) {
+		disable_irq_nosync(prueth->rx_lpq_irq);
+		napi_schedule(&prueth->napi_lpq);
+	} else {
+		disable_irq_nosync(prueth->rx_hpq_irq);
+		napi_schedule(&prueth->napi_hpq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int icssm_prueth_common_request_irqs(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	int ret;
+
+	/* Request irq when first port is initialized */
+	if (prueth->emac_configured)
+		return 0;
+
+	ret = request_irq(prueth->rx_hpq_irq,
+			  icssm_prueth_common_emac_rx_hardirq,
+			  IRQF_TRIGGER_HIGH, "eth_hp_int", prueth->hp);
+	if (ret) {
+		netdev_err(emac->ndev, "unable to request RX HPQ IRQ\n");
+		goto free_napi_hpq_lpq;
+	}
+
+	ret = request_irq(prueth->rx_lpq_irq,
+			  icssm_prueth_common_emac_rx_hardirq,
+			  IRQF_TRIGGER_HIGH, "eth_lp_int", prueth->lp);
+	if (ret) {
+		netdev_err(emac->ndev, "unable to request RX LPQ IRQ\n");
+		goto free_rx_hpq_irq;
+	}
+
+	return 0;
+
+free_rx_hpq_irq:
+	free_irq(prueth->rx_hpq_irq, prueth->hp);
+
+free_napi_hpq_lpq:
+	napi_disable(&prueth->napi_lpq);
+	napi_disable(&prueth->napi_hpq);
+
+	return ret;
+}
+
+/**
+ * icssm_prueth_common_free_irqs - free irq
+ *
+ * @emac: EMAC data structure
+ *
+ */
+void icssm_prueth_common_free_irqs(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+
+	/* HSR/PRP/Switch: free irqs when last port is down */
+	if (prueth->emac_configured)
+		return;
+
+	free_irq(prueth->rx_lpq_irq, prueth->lp);
+	free_irq(prueth->rx_hpq_irq, prueth->hp);
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
index 6276dd1e8bb1..239542101943 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
@@ -152,6 +152,14 @@ static void icssm_prueth_lre_protocol_init(struct prueth *prueth)
 	       dram1 + ICSS_LRE_SUP_ADDR_LOW);
 }
 
+static void icssm_prueth_lre_config_packet_timestamping(struct prueth *prueth)
+{
+	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	writeb(1, sram + ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET);
+	writeb(1, sram + ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET);
+}
+
 static enum hrtimer_restart icssm_prueth_lre_timer(struct hrtimer *timer)
 {
 	struct prueth *prueth;
@@ -202,6 +210,11 @@ void icssm_prueth_lre_config(struct prueth *prueth)
 	icssm_prueth_lre_init(prueth);
 	icssm_prueth_lre_dbg_init(prueth);
 	icssm_prueth_lre_protocol_init(prueth);
+	/* Enable per-packet timestamping so the driver can order
+	 * received frames by arrival time across the two slave ports.
+	 */
+	icssm_prueth_lre_config_packet_timestamping(prueth);
+
 }
 
 void icssm_prueth_lre_cleanup(struct prueth *prueth)
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
index 66866ea37913..9d67fc7c23ac 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -886,6 +886,14 @@ void icssm_prueth_sw_hostconfig(struct prueth *prueth)
 		    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
 }
 
+void icssm_prueth_sw_config_packet_timestamping(struct prueth *prueth)
+{
+	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	writeb(1, sram + SWITCH_PRIORITY_INTRS_STATUS_OFFSET);
+	writeb(1, sram + SWITCH_TIMESTAMP_PKTS_STATUS_OFFSET);
+}
+
 static int icssm_prueth_sw_port_config(struct prueth *prueth,
 				       enum prueth_port port_id)
 {
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
index e6111bba166e..fe7197f9a6da 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -29,6 +29,7 @@ void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
 int icssm_prueth_sw_learn_fdb(struct prueth_emac *emac, u8 *src_mac);
 int icssm_prueth_sw_purge_fdb(struct prueth_emac *emac);
 void icssm_prueth_sw_hostconfig(struct prueth *prueth);
+void icssm_prueth_sw_config_packet_timestamping(struct prueth *prueth);
 int icssm_prueth_sw_emac_config(struct prueth_emac *emac);
 int icssm_prueth_sw_boot_prus(struct prueth *prueth, struct net_device *ndev);
 int icssm_prueth_sw_shutdown_prus(struct prueth_emac *emac,
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index 5ba9ce14da44..b4d6b8660539 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -301,6 +301,12 @@
 #define P0_Q1_BD_OFFSET		P0_BUFFER_DESC_OFFSET
 #define P0_BUFFER_DESC_OFFSET	SRAM_START_OFFSET
 
+/* Enable/disable interrupts for high/low priority instead of per port.
+ * 0 = disabled (default), 1 = enabled
+ */
+#define SWITCH_PRIORITY_INTRS_STATUS_OFFSET	0x1FAA
+#define SWITCH_TIMESTAMP_PKTS_STATUS_OFFSET	0x1FAB
+
 /* Memory Usage of L3 OCMC RAM */
 
 /* L3 64KB Memory - mainly buffer Pool */
-- 
2.43.0

