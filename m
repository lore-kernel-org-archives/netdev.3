Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850301;
	b=R3UsIC4I8nocwG+EvYLnEUboMEdwVIOprW3Lt7YH/afQtLfBWnMNfQPTamVQX31Qj1zh
	 T+SyRkGWjnopvfp+pzNQqgpF4zEA/QgtqbUsRIMa9+YnyCwCGLaYIt8zOFDhgdkAIziGV
	 +RUaz3Lik8RjukP2ApoAd7X7EmbiH+PiK8rYJmqPIqhDglyn1bF+2lhXb9iA3UqVlisae
	 dCaYAg4MQ/tzuYtnvOsAeaQQUP3hmyFPlclTCPUGflIhkGxA7vFTuETM5MT437+9Ut7bl
	 untn0DpILQst5N7bpDtkr+aVB/eTZpoZXMFJuWZF5vTtUsLfAf1P8VXQFJhMQy7wsTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850301;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B72Fw7CIRKX1vmz7WNisGawWPqH1hiQ3NDQAPllv1XY=;
	b=ecqqzk5AuBBwP6DgOEXa5m4CSx8W2tHEVJDoQlqpWVI8W+oNObJoR3Y0aiacr4/muS0d
	 cMI2E8uihHtQWwFBMAz2QltKzcNsQTxJbqJjFrLRjKp7UAca0SBFeIx6HMLYLHnd2I1l/
	 X5ysheStt5SSbjCe8Q2fVplVvoZsCB7bHk82jBlP6nm8UR0twlLYd0jBUVO9c9BwBI36H
	 8tcF/OT/yJClqEFzZZjWGEOcpdA0d8R+GILlHuEnwqtH/w7ER97U3xsYiyXgioyUgpofv
	 SIGkJYpCFqwFr86T502M2aIksQLI/mmPhXj2nPh6xMMcukIt5wu1aTE/RVA9o/vFPYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C080606A331
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C080606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3r002480;
	Wed, 4 Nov 2026 19:44:47 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 05/12] cxgb4: add T7 support to the main driver
Date: Thu,  5 Nov 2026 08:15:42 -0500
Message-Id: <20261105131549.547554-6-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the T7 generation in the NIC driver proper, on top of the PCI
and helper rework done in the previous patch.

Firmware and configuration:

  - Add FW7_FNAME/FW7_CFNAME, the T7 entry in fw_info_array[] and the
    matching case in adap_init0_config().
  - Bound the configuration file against the size reported by
    t4_flash_location_size(FLASH_LOC_CFG) rather than the fixed
    FLASH_CFG_MAX_SIZE, which no longer describes every generation.
  - The high priority filter and PPOD EDRAM setup is enabled for
    T6 and later rather than T6 only.

Reporting:

  - link_report() learns 200G and 400G.
  - t4_os_portmod_changed() learns the LR_SIMPLEX and DR module types.

Channel programming:

  - Port related firmware commands and register accesses now use the
    logical port number (pi->lport) rather than pi->tx_chan.  These are
    identical on T4/T5/T6; on T7 the TP channel for a port is supplied
    by firmware via FW_PARAMS_PARAM_DEV_TPCHMAP and is read through
    cxgb4_port_chan(), which the SGE queue allocation paths now use.
  - t4_set_trace_rss_control() replaces the open coded, chip
    conditional MPS trace RSS control register write.

UDP tunnels:

  - VXLAN and GENEVE RX type registers moved on T7; select between the
    legacy and T7 register offsets.

Multiple uP cores:

  - t4_sge_alloc_eth_txq() and t4_sge_alloc_ctrl_txq() take a queue
    index and program FW_EQ_{ETH,CTRL}_CMD_COREGROUP so that queues are
    distributed across the available cores.
  - setup_sge_queues() allocates num_up_cores control queues per port,
    and cfg_queues()/enable_msix() size the offload queue sets and
    vector requirements accordingly.

SGE:

  - On T7 and later the firmware derives the congestion channel map
    from the configured load balancer mode, so the driver passes the
    channel vector directly instead of building the map itself.
  - t4_sge_init() handles the T7 chip version.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 248 +++++++++---------
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |  55 ++--
 3 files changed, 168 insertions(+), 139 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index f08bb0993c37..8409e759f5ae 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1655,10 +1655,10 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		     rspq_flush_handler_t flush_handler, int cong);
 int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			 struct net_device *dev, struct netdev_queue *netdevq,
-			 unsigned int iqid, u8 dbqt);
+			 unsigned int iqid, u8 dbqt, int index);
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			  struct net_device *dev, unsigned int iqid,
-			  unsigned int cmplqid);
+			  unsigned int cmplqid, int index);
 int t4_sge_mod_ctrl_txq(struct adapter *adap, unsigned int eqid,
 			unsigned int cmplqid);
 int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 05ee6c1f9923..be4c8cbbad95 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -92,7 +92,7 @@
 
 char cxgb4_driver_name[] = KBUILD_MODNAME;
 
-#define DRV_DESC "Chelsio T4/T5/T6 Network Driver"
+#define DRV_DESC "Chelsio T4/T5/T6/T7 Network Driver"
 
 #define DFLT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK | \
 			 NETIF_MSG_TIMER | NETIF_MSG_IFDOWN | NETIF_MSG_IFUP |\
@@ -101,9 +101,11 @@ char cxgb4_driver_name[] = KBUILD_MODNAME;
 #define FW4_FNAME "cxgb4/t4fw.bin"
 #define FW5_FNAME "cxgb4/t5fw.bin"
 #define FW6_FNAME "cxgb4/t6fw.bin"
+#define FW7_FNAME "cxgb4/t7fw.bin"
 #define FW4_CFNAME "cxgb4/t4-config.txt"
 #define FW5_CFNAME "cxgb4/t5-config.txt"
 #define FW6_CFNAME "cxgb4/t6-config.txt"
+#define FW7_CFNAME "cxgb4/t7-config.txt"
 #define PHY_AQ1202_FIRMWARE "cxgb4/aq1202_fw.cld"
 #define PHY_BCM84834_FIRMWARE "cxgb4/bcm8483.bin"
 #define PHY_AQ1202_DEVICEID 0x4409
@@ -115,6 +117,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_FIRMWARE(FW4_FNAME);
 MODULE_FIRMWARE(FW5_FNAME);
 MODULE_FIRMWARE(FW6_FNAME);
+MODULE_FIRMWARE(FW7_FNAME);
 
 /*
  * The driver uses the best interrupt scheme available on a platform in the
@@ -196,6 +199,12 @@ static void link_report(struct net_device *dev)
 		case 100000:
 			s = "100Gbps";
 			break;
+		case 200000:
+			s = "200Gbps";
+			break;
+		case 400000:
+			s = "400Gbps";
+			break;
 		default:
 			pr_info("%s: unsupported speed: %d\n",
 				dev->name, p->link_cfg.speed);
@@ -283,7 +292,8 @@ void t4_os_link_changed(struct adapter *adapter, int port_id, int link_stat)
 void t4_os_portmod_changed(struct adapter *adap, int port_id)
 {
 	static const char *mod_str[] = {
-		NULL, "LR", "SR", "ER", "passive DA", "active DA", "LRM"
+		NULL, "LR", "SR", "ER", "passive DA", "active DA", "LRM",
+		"LR_SIMPLEX", "DR"
 	};
 
 	struct net_device *dev = adap->port[port_id];
@@ -529,8 +539,7 @@ static int link_start(struct net_device *dev)
 		ret = cxgb4_update_mac_filt(pi, pi->viid, &pi->xact_addr_filt,
 					    dev->dev_addr, true, &pi->smt_idx);
 	if (ret == 0)
-		ret = t4_link_l1cfg(pi->adapter, mb, pi->tx_chan,
-				    &pi->link_cfg);
+		ret = t4_link_l1cfg(pi->adapter, mb, pi->lport, &pi->link_cfg);
 	if (ret == 0) {
 		local_bh_disable();
 		ret = t4_enable_pi_params(pi->adapter, mb, pi, true,
@@ -1074,7 +1083,7 @@ static int setup_sge_queues(struct adapter *adap)
 	struct sge_uld_rxq_info *rxq_info = NULL;
 	struct sge *s = &adap->sge;
 	unsigned int cmplqid = 0;
-	int err, i, j, msix = 0;
+	int err, i, j, k, msix = 0;
 
 	if (is_uld(adap))
 		rxq_info = s->uld_rxq_info[CXGB4_ULD_RDMA];
@@ -1106,8 +1115,7 @@ static int setup_sge_queues(struct adapter *adap)
 					       msix, &q->fl,
 					       t4_ethrx_handler,
 					       NULL,
-					       t4_get_tp_ch_map(adap,
-								pi->tx_chan));
+					       t4_get_tp_ch_map(adap, pi->lport));
 			if (err)
 				goto freeout;
 			q->rspq.idx = j;
@@ -1119,7 +1127,7 @@ static int setup_sge_queues(struct adapter *adap)
 			err = t4_sge_alloc_eth_txq(adap, t, dev,
 					netdev_get_tx_queue(dev, j),
 					q->rspq.cntxt_id,
-					!!(adap->flags & CXGB4_SGE_DBQ_TIMER));
+					!!(adap->flags & CXGB4_SGE_DBQ_TIMER), j);
 			if (err)
 				goto freeout;
 		}
@@ -1132,25 +1140,26 @@ static int setup_sge_queues(struct adapter *adap)
 		if (rxq_info)
 			cmplqid	= rxq_info->uldrxq[i].rspq.cntxt_id;
 
-		err = t4_sge_alloc_ctrl_txq(adap, &s->ctrlq[i], adap->port[i],
-					    s->fw_evtq.cntxt_id, cmplqid);
-		if (err)
-			goto freeout;
+		/* Allocate at least num_up_cores control queues per port */
+		j = i * adap->params.num_up_cores;
+		for (k = 0; k < adap->params.num_up_cores; k++, j++) {
+			err = t4_sge_alloc_ctrl_txq(adap, &s->ctrlq[j], adap->port[i],
+						    s->fw_evtq.cntxt_id, cmplqid, k);
+			if (err)
+				goto freeout;
+		}
 	}
 
 	if (!is_t4(adap->params.chip)) {
 		err = t4_sge_alloc_eth_txq(adap, &s->ptptxq, adap->port[0],
 					   netdev_get_tx_queue(adap->port[0], 0)
-					   , s->fw_evtq.cntxt_id, false);
+					   , s->fw_evtq.cntxt_id, false, 0);
 		if (err)
 			goto freeout;
 	}
 
-	t4_write_reg(adap, is_t4(adap->params.chip) ?
-				MPS_TRC_RSS_CONTROL_A :
-				MPS_T5_TRC_RSS_CONTROL_A,
-		     RSSCONTROL_V(netdev2pinfo(adap->port[0])->tx_chan) |
-		     QUEUENUMBER_V(s->ethrxq[0].rspq.abs_id));
+	t4_set_trace_rss_control(adap, netdev2pinfo(adap->port[0])->tx_chan,
+				 s->ethrxq[0].rspq.abs_id);
 	return 0;
 freeout:
 	dev_err(adap->pdev_dev, "Can't allocate queues, err=%d\n", -err);
@@ -2282,70 +2291,16 @@ EXPORT_SYMBOL(cxgb4_sync_txq_pidx);
 
 int cxgb4_read_tpte(struct net_device *dev, u32 stag, __be32 *tpte)
 {
-	u32 edc0_size, edc1_size, mc0_size, mc1_size, size;
-	u32 edc0_end, edc1_end, mc0_end, mc1_end;
-	u32 offset, memtype, memaddr;
-	struct adapter *adap;
-	u32 hma_size = 0;
+	struct adapter *adap = netdev2adap(dev);
+	u32 offset;
 	int ret;
 
-	adap = netdev2adap(dev);
-
 	offset = ((stag >> 8) * 32) + adap->vres.stag.start;
-
-	/* Figure out where the offset lands in the Memory Type/Address scheme.
-	 * This code assumes that the memory is laid out starting at offset 0
-	 * with no breaks as: EDC0, EDC1, MC0, MC1. All cards have both EDC0
-	 * and EDC1.  Some cards will have neither MC0 nor MC1, most cards have
-	 * MC0, and some have both MC0 and MC1.
-	 */
-	size = t4_read_reg(adap, MA_EDRAM0_BAR_A);
-	edc0_size = EDRAM0_SIZE_G(size) << 20;
-	size = t4_read_reg(adap, MA_EDRAM1_BAR_A);
-	edc1_size = EDRAM1_SIZE_G(size) << 20;
-	size = t4_read_reg(adap, MA_EXT_MEMORY0_BAR_A);
-	mc0_size = EXT_MEM0_SIZE_G(size) << 20;
-
-	if (t4_read_reg(adap, MA_TARGET_MEM_ENABLE_A) & HMA_MUX_F) {
-		size = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
-		hma_size = EXT_MEM1_SIZE_G(size) << 20;
-	}
-	edc0_end = edc0_size;
-	edc1_end = edc0_end + edc1_size;
-	mc0_end = edc1_end + mc0_size;
-
-	if (offset < edc0_end) {
-		memtype = MEM_EDC0;
-		memaddr = offset;
-	} else if (offset < edc1_end) {
-		memtype = MEM_EDC1;
-		memaddr = offset - edc0_end;
-	} else {
-		if (hma_size && (offset < (edc1_end + hma_size))) {
-			memtype = MEM_HMA;
-			memaddr = offset - edc1_end;
-		} else if (offset < mc0_end) {
-			memtype = MEM_MC0;
-			memaddr = offset - edc1_end;
-		} else if (is_t5(adap->params.chip)) {
-			size = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
-			mc1_size = EXT_MEM1_SIZE_G(size) << 20;
-			mc1_end = mc0_end + mc1_size;
-			if (offset < mc1_end) {
-				memtype = MEM_MC1;
-				memaddr = offset - mc0_end;
-			} else {
-				/* offset beyond the end of any memory */
-				goto err;
-			}
-		} else {
-			/* T4/T6 only has a single memory channel */
-			goto err;
-		}
-	}
+	if (offset >= (adap->vres.stag.start + adap->vres.stag.size))
+		goto err;
 
 	spin_lock(&adap->win0_lock);
-	ret = t4_memory_rw(adap, 0, memtype, memaddr, 32, tpte, T4_MEMORY_READ);
+	ret = t4_memory_rw(adap, MEMWIN_NIC, MEM_EDC0, offset, 32, tpte, T4_MEMORY_READ);
 	spin_unlock(&adap->win0_lock);
 	return ret;
 
@@ -3033,8 +2988,7 @@ static void cxgb_get_stats(struct net_device *dev,
 		spin_unlock(&adapter->stats_lock);
 		return;
 	}
-	t4_get_port_stats_offset(adapter, p->tx_chan, &stats,
-				 &p->stats_base);
+	t4_get_port_stats_offset(adapter, p->lport, &stats, &p->stats_base);
 	spin_unlock(&adapter->stats_lock);
 
 	ns->tx_bytes   = stats.tx_octets;
@@ -3372,7 +3326,7 @@ static int cxgb4_mgmt_set_vf_rate(struct net_device *dev, int vf,
 			      SCHED_CLASS_MODE_CLASS,
 			      SCHED_CLASS_RATEUNIT_BITS,
 			      SCHED_CLASS_RATEMODE_ABS,
-			      pi->tx_chan, class_id, 0,
+			      pi->lport, class_id, 0,
 			      max_tx_rate * 1000, 0, pktsize, 0);
 	if (ret) {
 		dev_err(adap->pdev_dev, "Err %d for Traffic Class config\n",
@@ -3756,16 +3710,19 @@ static int cxgb_udp_tunnel_unset_port(struct net_device *netdev,
 	struct port_info *pi = netdev_priv(netdev);
 	struct adapter *adapter = pi->adapter;
 	u8 match_all_mac[] = { 0, 0, 0, 0, 0, 0 };
+	u32 chip_ver, reg;
 	int ret = 0, i;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
+
 	switch (ti->type) {
 	case UDP_TUNNEL_TYPE_VXLAN:
 		adapter->vxlan_port = 0;
-		t4_write_reg(adapter, MPS_RX_VXLAN_TYPE_A, 0);
+		reg = chip_ver >= CHELSIO_T7 ? T7_MPS_RX_VXLAN_TYPE_A : MPS_RX_VXLAN_TYPE_A;
 		break;
 	case UDP_TUNNEL_TYPE_GENEVE:
 		adapter->geneve_port = 0;
-		t4_write_reg(adapter, MPS_RX_GENEVE_TYPE_A, 0);
+		reg = chip_ver >= CHELSIO_T7 ? T7_MPS_RX_GENEVE_TYPE_A : MPS_RX_GENEVE_TYPE_A;
 		break;
 	default:
 		return -EINVAL;
@@ -3778,17 +3735,16 @@ static int cxgb_udp_tunnel_unset_port(struct net_device *netdev,
 		return 0;
 	for_each_port(adapter, i) {
 		pi = adap2pinfo(adapter, i);
-		ret = t4_free_raw_mac_filt(adapter, pi->viid,
-					   match_all_mac, match_all_mac,
-					   adapter->rawf_start + pi->port_id,
-					   1, pi->port_id, false);
-		if (ret < 0) {
-			netdev_info(netdev, "Failed to free mac filter entry, for port %d\n",
-				    i);
-			return ret;
-		}
+		ret = t4_free_raw_mac_filt(adapter, pi->viid, match_all_mac, match_all_mac,
+					   adapter->rawf_start + pi->port_id, 1, pi->port_id,
+					   false);
+		if (ret < 0)
+			netdev_info(netdev,
+				    "RAW MAC Filter free failed for port %d, UDP port %u, ret: %d\n",
+				    i, be16_to_cpu(ti->port), ret);
 	}
 
+	t4_write_reg(adapter, reg, 0);
 	return 0;
 }
 
@@ -3799,18 +3755,26 @@ static int cxgb_udp_tunnel_set_port(struct net_device *netdev,
 	struct port_info *pi = netdev_priv(netdev);
 	struct adapter *adapter = pi->adapter;
 	u8 match_all_mac[] = { 0, 0, 0, 0, 0, 0 };
+	u32 chip_ver, reg, val;
+	__be16 *port_save;
 	int i, ret;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
+
 	switch (ti->type) {
 	case UDP_TUNNEL_TYPE_VXLAN:
 		adapter->vxlan_port = ti->port;
-		t4_write_reg(adapter, MPS_RX_VXLAN_TYPE_A,
-			     VXLAN_V(be16_to_cpu(ti->port)) | VXLAN_EN_F);
+		port_save = &adapter->vxlan_port;
+		reg = chip_ver >= CHELSIO_T7 ? T7_MPS_RX_VXLAN_TYPE_A :
+					       MPS_RX_VXLAN_TYPE_A;
+		val = VXLAN_V(be16_to_cpu(ti->port)) | VXLAN_EN_F;
 		break;
 	case UDP_TUNNEL_TYPE_GENEVE:
 		adapter->geneve_port = ti->port;
-		t4_write_reg(adapter, MPS_RX_GENEVE_TYPE_A,
-			     GENEVE_V(be16_to_cpu(ti->port)) | GENEVE_EN_F);
+		port_save = &adapter->geneve_port;
+		reg = chip_ver >= CHELSIO_T7 ?
+			T7_MPS_RX_GENEVE_TYPE_A : MPS_RX_GENEVE_TYPE_A;
+		val = GENEVE_V(be16_to_cpu(ti->port)) | GENEVE_EN_F;
 		break;
 	default:
 		return -EINVAL;
@@ -3831,13 +3795,27 @@ static int cxgb_udp_tunnel_set_port(struct net_device *netdev,
 					    adapter->rawf_start + pi->port_id,
 					    1, pi->port_id, false);
 		if (ret < 0) {
-			netdev_info(netdev, "Failed to allocate a mac filter entry, not adding port %d\n",
-				    be16_to_cpu(ti->port));
-			return ret;
+			netdev_info(netdev,
+				    "RAW MAC Filter alloc failed for port %d, UDP port %u, ret: %d\n",
+				    i, be16_to_cpu(ti->port), ret);
+			goto out_free;
 		}
 	}
 
+	*port_save = ti->port;
+	t4_write_reg(adapter, reg, val);
 	return 0;
+
+out_free:
+	while (i-- > 0) {
+		pi = adap2pinfo(adapter, i);
+		t4_free_raw_mac_filt(adapter, pi->viid, match_all_mac,
+				     match_all_mac,
+				     adapter->rawf_start + pi->port_id,
+				     1, pi->port_id, false);
+	}
+
+	return ret;
 }
 
 static const struct udp_tunnel_nic_info cxgb_udp_tunnels = {
@@ -4460,14 +4438,15 @@ static int adap_init0_phy(struct adapter *adap)
  */
 static int adap_init0_config(struct adapter *adapter, int reset)
 {
+	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	char *fw_config_file, fw_config_file_path[256];
 	u32 finiver, finicsum, cfcsum, param, val;
 	struct fw_caps_config_cmd caps_cmd;
 	unsigned long mtype = 0, maddr = 0;
 	const struct firmware *cf;
 	char *config_name = NULL;
-	int config_issued = 0;
-	int ret;
+	int ret, config_issued = 0;
+	int devid = 0;
 
 	/*
 	 * Reset device if necessary.
@@ -4484,7 +4463,8 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 	 * to be performed after any global adapter RESET above since some
 	 * PHYs only have local RAM copies of the PHY firmware.
 	 */
-	if (is_10gbt_device(adapter->pdev->device)) {
+	devid = adapter->pdev->device;
+	if (is_10gbt_device(devid)) {
 		ret = adap_init0_phy(adapter);
 		if (ret < 0)
 			goto bye;
@@ -4494,7 +4474,7 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 	 * then use that.  Otherwise, use the configuration file stored
 	 * in the adapter flash ...
 	 */
-	switch (CHELSIO_CHIP_VERSION(adapter->params.chip)) {
+	switch (chip_ver) {
 	case CHELSIO_T4:
 		fw_config_file = FW4_CFNAME;
 		break;
@@ -4504,9 +4484,12 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 	case CHELSIO_T6:
 		fw_config_file = FW6_CFNAME;
 		break;
+	case CHELSIO_T7:
+		fw_config_file = FW7_CFNAME;
+		break;
 	default:
 		dev_err(adapter->pdev_dev, "Device %d is not supported\n",
-		       adapter->pdev->device);
+		       devid);
 		ret = -EINVAL;
 		goto bye;
 	}
@@ -4523,9 +4506,10 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 			"/lib/firmware/%s", fw_config_file);
 		config_name = fw_config_file_path;
 
-		if (cf->size >= FLASH_CFG_MAX_SIZE)
+		ret = t4_flash_location_size(adapter, FLASH_LOC_CFG);
+		if (ret < 0 || cf->size >= ret) {
 			ret = -ENOMEM;
-		else {
+		} else {
 			params[0] = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
 			     FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_CF));
 			ret = t4_query_params(adapter, adapter->mbox,
@@ -4669,7 +4653,7 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 		dev_err(adapter->pdev_dev,
 			"HMA configuration failed with error %d\n", ret);
 
-	if (is_t6(adapter->params.chip)) {
+	if (chip_ver >= CHELSIO_T6) {
 		adap_config_hpfilter(adapter);
 		ret = setup_ppod_edram(adapter);
 		if (!ret)
@@ -4747,7 +4731,23 @@ static struct fw_info fw_info_array[] = {
 			.intfver_iscsi = FW_INTFVER(T6, ISCSI),
 			.intfver_fcoepdu = FW_INTFVER(T6, FCOEPDU),
 			.intfver_fcoe = FW_INTFVER(T6, FCOE),
-		},
+			},
+	}, {
+		.chip = CHELSIO_T7,
+		.fs_name = FW7_CFNAME,
+		.fw_mod_name = FW7_FNAME,
+		.fw_hdr = {
+			.chip = FW_HDR_CHIP_T7,
+			.fw_ver = __cpu_to_be32(FW_VERSION(T7)),
+			.intfver_nic = FW_INTFVER(T7, NIC),
+			.intfver_vnic = FW_INTFVER(T7, VNIC),
+			.intfver_ofld = FW_INTFVER(T7, OFLD),
+			.intfver_ri = FW_INTFVER(T7, RI),
+			.intfver_iscsipdu = FW_INTFVER(T7, ISCSIPDU),
+			.intfver_iscsi = FW_INTFVER(T7, ISCSI),
+			.intfver_fcoepdu = FW_INTFVER(T7, FCOEPDU),
+			.intfver_fcoe = FW_INTFVER(T7, FCOE),
+			},
 	}
 
 };
@@ -4768,12 +4768,11 @@ static struct fw_info *find_fw_info(int chip)
  */
 static int adap_init0(struct adapter *adap, int vpd_skip)
 {
+	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	struct fw_caps_config_cmd caps_cmd;
-	u32 params[7], val[7];
+	u32 port_vec, v, params[7], val[7];
 	enum dev_state state;
-	u32 v, port_vec;
-	int reset = 1;
-	int ret;
+	int ret, reset = 1;
 
 	/* Grab Firmware Device Log parameters as early as possible so we have
 	 * access to it for debugging, etc.
@@ -4803,20 +4802,20 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	if (ret)
 		state = DEV_STATE_UNINIT;
 	if ((adap->flags & CXGB4_MASTER_PF) && state != DEV_STATE_INIT) {
-		struct fw_info *fw_info;
-		struct fw_hdr *card_fw;
 		const struct firmware *fw;
 		const u8 *fw_data = NULL;
 		unsigned int fw_size = 0;
+		struct fw_info *fw_info;
+		struct fw_hdr *card_fw;
 
 		/* This is the firmware whose headers the driver was compiled
 		 * against
 		 */
-		fw_info = find_fw_info(CHELSIO_CHIP_VERSION(adap->params.chip));
+		fw_info = find_fw_info(chip_ver);
 		if (fw_info == NULL) {
 			dev_err(adap->pdev_dev,
 				"unable to get firmware info for chip %d.\n",
-				CHELSIO_CHIP_VERSION(adap->params.chip));
+				chip_ver);
 			return -EINVAL;
 		}
 
@@ -5496,7 +5495,7 @@ pci_ers_result_t cxgb4_pci_eeh_slot_reset(struct pci_dev *pdev)
 		struct port_info *pi = adap2pinfo(adap, i);
 		u8 vivld = 0, vin = 0;
 
-		ret = t4_alloc_vi(adap, adap->mbox, pi->tx_chan, adap->pf, 0, 1,
+		ret = t4_alloc_vi(adap, adap->mbox, pi->lport, adap->pf, 0, 1,
 				  NULL, NULL, &vivld, &vin);
 		if (ret < 0)
 			return PCI_ERS_RESULT_DISCONNECT;
@@ -5756,6 +5755,16 @@ static int cfg_queues(struct adapter *adap)
 			s->ofldqsets = avail_uld_qsets;
 		}
 
+		/*
+		 * 1. num_of_cores should not be less than one for tensilica
+		 * 2. num of ofld queues per port should not be less than num cores
+		 */
+
+		if (adap->params.tid_qid_sel_mask &&
+		    s->ofldqsets <
+			    adap->params.num_up_cores * adap->params.nports)
+			s->ofldqsets = adap->params.num_up_cores * adap->params.nports;
+
 		avail_qsets -= num_ulds * s->ofldqsets;
 	}
 
@@ -5899,7 +5908,7 @@ static int enable_msix(struct adapter *adap)
 {
 	u32 eth_need, uld_need = 0, ethofld_need = 0, mirror_need = 0;
 	u32 ethqsets = 0, ofldqsets = 0, eoqsets = 0, mirrorqsets = 0;
-	u8 num_uld = 0, nchan = adap->params.nports;
+	u8 nchan = adap->params.nports;
 	u32 i, want, need, num_vec;
 	struct sge *s = &adap->sge;
 	struct msix_entry *entries;
@@ -5917,9 +5926,8 @@ static int enable_msix(struct adapter *adap)
 #endif
 	eth_need = need;
 	if (is_uld(adap)) {
-		num_uld = adap->num_ofld_uld + adap->num_uld;
-		want += num_uld * s->ofldqsets;
-		uld_need = num_uld * nchan;
+		want += s->ofldqsets;
+		uld_need = adap->params.num_up_cores * nchan;
 		need += uld_need;
 	}
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 492cd35ce9d2..4a694d94f6eb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1697,7 +1697,7 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif /* CONFIG_CHELSIO_T4_FCOE */
 	}
 
-	ctrl0 = TXPKT_OPCODE_V(CPL_TX_PKT_XT) | TXPKT_INTF_V(pi->tx_chan) |
+	ctrl0 = TXPKT_OPCODE_V(CPL_TX_PKT_XT) | TXPKT_INTF_V(pi->lport) |
 		TXPKT_PF_V(adap->pf);
 	if (ptp_enabled)
 		ctrl0 |= TXPKT_TSTAMP_F;
@@ -2003,7 +2003,7 @@ static netdev_tx_t cxgb4_vf_eth_xmit(struct sk_buff *skb,
 
 	 /* Fill in the TX Packet CPL message header. */
 	cpl->ctrl0 = cpu_to_be32(TXPKT_OPCODE_V(CPL_TX_PKT_XT) |
-				 TXPKT_INTF_V(pi->port_id) |
+				 TXPKT_INTF_V(pi->lport) |
 				 TXPKT_PF_V(0));
 	cpl->pack = cpu_to_be16(0);
 	cpl->len = cpu_to_be16(skb->len);
@@ -4400,7 +4400,7 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		FW_IQ_CMD_IQANUD_V(UPDATEDELIVERY_INTERRUPT_X) |
 		FW_IQ_CMD_IQANDSTINDEX_V(intr_idx >= 0 ? intr_idx :
 							-intr_idx - 1));
-	c.iqdroprss_to_iqesize = htons(FW_IQ_CMD_IQPCIECH_V(pi->tx_chan) |
+	c.iqdroprss_to_iqesize = htons(FW_IQ_CMD_IQPCIECH_V(cxgb4_port_chan(dev)) |
 		FW_IQ_CMD_IQGTSMODE_F |
 		FW_IQ_CMD_IQINTCNTTHRESH_V(iq->pktcnt_idx) |
 		FW_IQ_CMD_IQESIZE_V(ilog2(iq->iqe_len) - 4));
@@ -4527,13 +4527,21 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		if (cong == 0) {
 			val = CONMCTXT_CNGTPMODE_V(CONMCTXT_CNGTPMODE_QUEUE_X);
 		} else {
-			val =
-			    CONMCTXT_CNGTPMODE_V(CONMCTXT_CNGTPMODE_CHANNEL_X);
-			for (i = 0; i < 4; i++) {
-				if (cong & (1 << i))
-					ch_map |= 1 << (i << cng_ch_bits_log);
+			if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+				/*
+				 * For T7+, firmware calculates the congestion channel
+				 * map internally based on configured LB_MODE.
+				 */
+				val = T7_DMAQ_CONM_CTXT_CH_VEC_V(cong);
+			} else {
+				val =
+				    CONMCTXT_CNGTPMODE_V(CONMCTXT_CNGTPMODE_CHANNEL_X);
+				for (i = 0; i < 4; i++) {
+					if (cong & (1 << i))
+						ch_map |= 1 << (i << cng_ch_bits_log);
+				}
+				val |= CONMCTXT_CNGCHMAP_V(ch_map);
 			}
-			val |= CONMCTXT_CNGCHMAP_V(ch_map);
 		}
 		ret = t4_set_params(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val);
@@ -4584,10 +4592,11 @@ static void init_txq(struct adapter *adap, struct sge_txq *q, unsigned int id)
  *	@netdevq: the corresponding Linux TX Queue
  *	@iqid: the Ingress Queue to which to deliver CIDX Update messages
  *	@dbqt: whether this TX Queue will use the SGE Doorbell Queue Timers
+ *	@index: the queue index within the port, used to pick the uP core group
  */
 int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			 struct net_device *dev, struct netdev_queue *netdevq,
-			 unsigned int iqid, u8 dbqt)
+			 unsigned int iqid, u8 dbqt, int index)
 {
 	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	struct port_info *pi = netdev_priv(dev);
@@ -4595,6 +4604,9 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 	struct fw_eq_eth_cmd c;
 	int ret, nentries;
 
+	if (adap->params.num_up_cores > 1)
+		txq->group_id = index % adap->params.num_up_cores;
+
 	/* Add status entries */
 	nentries = txq->q.size + s->stat_len / sizeof(struct tx_desc);
 
@@ -4611,7 +4623,9 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			    FW_EQ_ETH_CMD_PFN_V(adap->pf) |
 			    FW_EQ_ETH_CMD_VFN_V(0));
 	c.alloc_to_len16 = htonl(FW_EQ_ETH_CMD_ALLOC_F |
-				 FW_EQ_ETH_CMD_EQSTART_F | FW_LEN16(c));
+				 FW_EQ_ETH_CMD_EQSTART_F |
+				 FW_EQ_ETH_CMD_COREGROUP_V(txq->group_id) |
+				 (sizeof(c) / 16));
 
 	/* For TX Ethernet Queues using the SGE Doorbell Queue Timer
 	 * mechanism, we use Ingress Queue messages for Hardware Consumer
@@ -4628,7 +4642,7 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 		htonl(FW_EQ_ETH_CMD_HOSTFCMODE_V((chip_ver <= CHELSIO_T5) ?
 						 HOSTFCMODE_INGRESS_QUEUE_X :
 						 HOSTFCMODE_STATUS_PAGE_X) |
-		      FW_EQ_ETH_CMD_PCIECHN_V(pi->tx_chan) |
+		      FW_EQ_ETH_CMD_PCIECHN_V(cxgb4_port_chan(dev)) |
 		      FW_EQ_ETH_CMD_FETCHRO_F | FW_EQ_ETH_CMD_IQID_V(iqid));
 
 	/* Note that the CIDX Flush Threshold should match MAX_TX_RECLAIM. */
@@ -4681,13 +4695,17 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			  struct net_device *dev, unsigned int iqid,
-			  unsigned int cmplqid)
+			  unsigned int cmplqid, int index)
 {
 	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
-	struct port_info *pi = netdev_priv(dev);
 	struct sge *s = &adap->sge;
 	struct fw_eq_ctrl_cmd c;
-	int ret, nentries;
+	int ret, nentries, ngroups;
+
+	ngroups = (adap->params.tid_qid_sel_mask >>
+			adap->params.tid_qid_sel_shift) + 1;
+	if (adap->params.tid_qid_sel_mask)
+		txq->tid_qid_group_id = index % ngroups;
 
 	/* Add status entries */
 	nentries = txq->q.size + s->stat_len / sizeof(struct tx_desc);
@@ -4703,12 +4721,14 @@ int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			    FW_EQ_CTRL_CMD_PFN_V(adap->pf) |
 			    FW_EQ_CTRL_CMD_VFN_V(0));
 	c.alloc_to_len16 = htonl(FW_EQ_CTRL_CMD_ALLOC_F |
-				 FW_EQ_CTRL_CMD_EQSTART_F | FW_LEN16(c));
+				 FW_EQ_CTRL_CMD_EQSTART_F |
+				 FW_EQ_CTRL_CMD_COREGROUP_V(txq->tid_qid_group_id) |
+				 (sizeof(c) / 16));
 	c.cmpliqid_eqid = htonl(FW_EQ_CTRL_CMD_CMPLIQID_V(cmplqid));
 	c.physeqid_pkd = htonl(0);
 	c.fetchszm_to_iqid =
 		htonl(FW_EQ_CTRL_CMD_HOSTFCMODE_V(HOSTFCMODE_STATUS_PAGE_X) |
-		      FW_EQ_CTRL_CMD_PCIECHN_V(pi->tx_chan) |
+		      FW_EQ_CTRL_CMD_PCIECHN_V(cxgb4_port_chan(dev)) |
 		      FW_EQ_CTRL_CMD_FETCHRO_F | FW_EQ_CTRL_CMD_IQID_V(iqid));
 	c.dcaen_to_eqsize =
 		htonl(FW_EQ_CTRL_CMD_FBMIN_V(chip_ver <= CHELSIO_T5
@@ -5196,6 +5216,7 @@ int t4_sge_init(struct adapter *adap)
 		egress_threshold = EGRTHRESHOLDPACKING_G(sge_conm_ctrl);
 		break;
 	case CHELSIO_T6:
+	case CHELSIO_T7:
 		egress_threshold = T6_EGRTHRESHOLDPACKING_G(sge_conm_ctrl);
 		break;
 	default:
-- 
2.39.1

