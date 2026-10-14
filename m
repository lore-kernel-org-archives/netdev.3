Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E474E534F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981687; cv=none; b=dj6t+Bp0+uQZLw3FJtvJYMnpcc7OyEKNPEw1IWUkxtVoJNf4wmzEbKCG66SJYiUMQCRosxVmIWy+cbqvLSINAZwIHVKgjAUO5OoZcrovUOjpmZefqwvc5e0sodPkPGQMg5vNA0ZiEqr6Yey7HVFKQXnUAwiWjeW+20eK/CYmoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981687; c=relaxed/simple;
	bh=JA2D5IfJ6VETPlT9ktRyUACVdBFYNuO5EzResmujV7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzXnJAWJ1Zj72vWzOC1t1awXaMoVNHUoHw/m+WqbqPqaR4gOIcHSYuXBbyxgzGfJcFILjyPDsz+aL0RU5VaUu3I7RGVb1Zb8aeB5wy42Zl2Sj93xFtjKTM5GGGUdwdh178rM6i4e7eFuc7Nyn5sf7hYgStWTv99s8tYTpgAfRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 69ECeqZ0018414;
	Wed, 14 Oct 2026 05:41:13 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v4 06/12] cxgb4: update PTP register access for T7
Date: Wed, 14 Oct 2026 18:12:51 -0400
Message-Id: <20261014221257.436789-7-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261014221257.436789-1-bharat@chelsio.com>
References: <20261014221257.436789-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAC_PORT_TX_TS_VAL_LO/HI registers moved within the port register
block on T7, and the PTP clock sum is now read from the chip global
MAC_PTP_SUM_LO/HI instead of a per port register. Select the right
registers by chip version and read both values with t4_read_reg64().
PTP port accesses now use the logical port number (pi->lport).

On T7 a transmitted PTP event packet is looped back with equal source
and destination MAC addresses rather than an MPS timestamp header.
Detect that and hand the packet to the transmit timestamp path. The
loopback packet is not necessarily UDP, so the RXF_UDP_F test is
dropped and cxgb4_ptp_is_ptp_rx() parses the frame itself, handling
VLAN tagged and IEEE 802.3 encapsulated PTP. On transmit,
ptp_classify_raw() replaces the open coded IPv4/UDP test.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_ptp.c    | 82 ++++++++++++++-----
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 13 ++-
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  |  1 +
 3 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
index cbd06d9b95d4..fb0d4ae11196 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
@@ -57,14 +57,13 @@
  */
 bool cxgb4_ptp_is_ptp_tx(struct sk_buff *skb)
 {
-	struct udphdr *uh;
-
-	uh = udp_hdr(skb);
-	return skb->len >= PTP_MIN_LENGTH &&
-		skb->len <= PTP_IN_TRANSMIT_PACKET_MAXNUM &&
-		likely(skb->protocol == htons(ETH_P_IP)) &&
-		ip_hdr(skb)->protocol == IPPROTO_UDP &&
-		uh->dest == htons(PTP_EVENT_PORT);
+	unsigned int ptp_class;
+
+	ptp_class = ptp_classify_raw(skb);
+	if (ptp_class == PTP_CLASS_NONE)
+		return false;
+
+	return true;
 }
 
 bool is_ptp_enabled(struct sk_buff *skb, struct net_device *dev)
@@ -83,11 +82,50 @@ bool is_ptp_enabled(struct sk_buff *skb, struct net_device *dev)
  */
 bool cxgb4_ptp_is_ptp_rx(struct sk_buff *skb)
 {
-	struct udphdr *uh = (struct udphdr *)(skb->data + ETH_HLEN +
-					      IPV4_HLEN(skb->data));
+	int offset = ETH_HLEN;
+	struct ethhdr *eth;
+	__be16 proto;
+
+	if (skb->len < ETH_HLEN)
+		return false;
+
+	eth = (struct ethhdr *)skb->data;
+	proto = eth->h_proto;
+
+	if (proto == htons(ETH_P_8021Q)) {
+		struct vlan_hdr *vhdr;
+
+		if (skb->len < offset + VLAN_HLEN)
+			return false;
+
+		vhdr = (struct vlan_hdr *)(skb->data + offset);
+		proto = vhdr->h_vlan_encapsulated_proto;
+		offset += VLAN_HLEN;
+	}
+
+	if (proto == htons(ETH_P_1588))
+		return true;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr *iph;
+		struct udphdr *uh;
+
+		if (skb->len < offset + sizeof(*iph))
+			return false;
+		iph = (struct iphdr *)(skb->data + offset);
+
+		if (iph->protocol != IPPROTO_UDP)
+			return false;
+		offset += (iph->ihl * 4);
+
+		if (skb->len < offset + sizeof(*uh))
+			return false;
+		uh = (struct udphdr *)(skb->data + offset);
+
+		return uh->dest == htons(PTP_EVENT_PORT);
+	}
 
-	return  uh->dest == htons(PTP_EVENT_PORT) &&
-		uh->source == htons(PTP_EVENT_PORT);
+	return false;
 }
 
 /**
@@ -103,12 +141,11 @@ void cxgb4_ptp_read_hwstamp(struct adapter *adapter, struct port_info *pi)
 
 	skb_ts = skb_hwtstamps(adapter->ptp_tx_skb);
 
-	tx_ts = t4_read_reg(adapter,
-			    T5_PORT_REG(pi->port_id, MAC_PORT_TX_TS_VAL_LO));
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T7)
+		tx_ts = t4_read_reg64(adapter, T7_PORT_REG(pi->lport, T7_MAC_PORT_TX_TS_VAL_LO));
+	else
+		tx_ts = t4_read_reg64(adapter, T5_PORT_REG(pi->lport, MAC_PORT_TX_TS_VAL_LO));
 
-	tx_ts |= (u64)t4_read_reg(adapter,
-				  T5_PORT_REG(pi->port_id,
-					      MAC_PORT_TX_TS_VAL_HI)) << 32;
 	skb_ts->hwtstamp = ns_to_ktime(tx_ts);
 	skb_tstamp_tx(adapter->ptp_tx_skb, skb_ts);
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
@@ -183,7 +220,7 @@ int cxgb4_ptp_redirect_rx_packet(struct adapter *adapter, struct port_info *pi)
 
 	c.retval_len16 = cpu_to_be32(FW_CMD_LEN16_V(sizeof(c) / 16));
 	c.u.init.sc = FW_PTP_SC_RDRX_TYPE;
-	c.u.init.txchan = pi->tx_chan;
+	c.u.init.txchan = pi->lport;
 	c.u.init.absid = cpu_to_be16(receive_q->rspq.abs_id);
 
 	err = t4_wr_mbox(adapter, adapter->mbox, &c, sizeof(c), NULL);
@@ -319,9 +356,10 @@ static int cxgb4_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 					       ptp_clock_info);
 	u64 ns;
 
-	ns = t4_read_reg(adapter, T5_PORT_REG(0, MAC_PORT_PTP_SUM_LO_A));
-	ns |= (u64)t4_read_reg(adapter,
-			       T5_PORT_REG(0, MAC_PORT_PTP_SUM_HI_A)) << 32;
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T7)
+		ns = t4_read_reg64(adapter, MAC_PTP_SUM_LO_A);
+	else
+		ns = t4_read_reg64(adapter, T5_PORT_REG(0, MAC_PORT_PTP_SUM_LO_A));
 
 	/* convert to timespec*/
 	*ts = ns_to_timespec64(ns);
@@ -432,7 +470,7 @@ void cxgb4_ptp_init(struct adapter *adapter)
 	spin_lock_init(&adapter->ptp_lock);
 
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_clock_info,
-						&adapter->pdev->dev);
+						adapter->pdev_dev);
 	if (IS_ERR_OR_NULL(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
 		dev_err(adapter->pdev_dev,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 4a694d94f6eb..2171db2f201a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -3483,7 +3483,8 @@ static void do_gro(struct sge_eth_rxq *rxq, const struct pkt_gl *gl,
 enum {
 	RX_NON_PTP_PKT = 0,
 	RX_PTP_PKT_SUC = 1,
-	RX_PTP_PKT_ERR = 2
+	RX_PTP_PKT_ERR = 2,
+	RX_PTP_PKT_T7 = 3
 };
 
 /**
@@ -3509,6 +3510,13 @@ static noinline int t4_systim_to_hwstamp(struct adapter *adapter,
 
 	data = skb->data + sizeof(*cpl);
 	skb_pull(skb, 2 * sizeof(u64) + sizeof(struct cpl_rx_mps_pkt));
+
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) == CHELSIO_T7) {
+		struct ethhdr *eth = (struct ethhdr *)skb->data;
+
+		if (ether_addr_equal(eth->h_source, eth->h_dest))
+			return RX_PTP_PKT_T7;
+	}
 	offset = ETH_HLEN + IPV4_HLEN(skb->data) + UDP_HLEN;
 	if (skb->len < offset + OFF_PTP_SEQUENCE_ID + sizeof(short))
 		return RX_PTP_PKT_ERR;
@@ -3740,8 +3748,7 @@ int t4_ethrx_handler(struct sge_rspq *q, const __be64 *rsp,
 		__skb_pull(skb, s->pktshift); /* remove ethernet header pad */
 
 	/* Handle the PTP Event Tx Loopback packet */
-	if (unlikely(pi->ptp_enable && !ret &&
-		     (pkt->l2info & htonl(RXF_UDP_F)) &&
+	if (unlikely(pi->ptp_enable && (ret == RX_PTP_PKT_T7 || !ret) &&
 		     cxgb4_ptp_is_ptp_rx(skb))) {
 		if (!t4_tx_hststamp(adapter, skb, q->netdev))
 			return 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
index 5ac262ec389f..e8bcce1993e1 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
@@ -4533,6 +4533,7 @@
 #define MAC_PORT_EPIO_OP_A 0x8d0
 
 #define MAC_PORT_CFG2_A 0x818
+#define MAC_PTP_SUM_LO_A 0x38108
 
 #define MAC_PORT_PTP_SUM_LO_A 0x990
 #define MAC_PORT_PTP_SUM_HI_A 0x994
-- 
2.39.1

