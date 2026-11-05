Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887037;
	b=zar0S8moGp0wTMfolZKBJ1nDBRsr87hwJ0EdNw/CPEgIIwGfDov2kdT71+7O4pL+SlQm
	 Cpl3TtDyVE+m+lndeFRZndsoRphX3U7Qogc05awK0Igb+2DW2J3sKk8nVJAS/bj8rI6zb
	 zq4PMCjs0EDQDUODgMbvIRDPIYWBjKqcj7CMF8pBMoyp2zTBpkiDpQ7j9gPplTH3Etq89
	 9KBprOj6K53bWDUez5az8yW5aB8cYkAWZ+1BpyleU/3JcARNtQJtx9u3oCcAj8kmyyxPh
	 R+hndcnwsEk9pgXr2WFhX+hdo7B4+E3vfy8jmTkkY0NqdnaZXeaREEX1Vm1FFJv1FpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887037;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=Y8sQUOr8VBhYpALBYlfQyOS++Z6ysNOazIq1Nrkkano=;
	b=BM1xjiVWl3d5fifFIcoVW2+kC86R+XG5pmR7ulknXH+RXLpBLoS8AQxZBrJc0kLen4n9
	 Fm3dbuqERdEP5lYkQ6HEcyG9Azw+yH4MqjU3JAo3Zat9aN0z5CW6TDGMJY2bH1ciabJMd
	 rABKBXma8YMNqnOnVwPLf60F7s9IxMTuCcENv2/TR6wXDUtL8E7hQXmqaHWQoLgoHz99h
	 nxvIYMnXUoX0U5zuPPlcW+CMQpfuE5JdSRu1ltPuDedSjS188wStcFKlQ2qSU3ZkMUK0c
	 EuQvm37dGXnRBr+qiWVeSjz+nLnXWc67DXlmglabYEUc4y80tD5WlFrxA5I0EQZHMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rBliy+5+;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A339606D826;
	Thu,  5 Nov 2026 13:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A339606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rBliy+5+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793887043; x=1825423043;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g0JFwtZNxtok7+btlnQFxiaWA3o8FrCwCtgkmJl0bgY=;
  b=rBliy+5+i+IPW8t6Vy0yIuNuKQIUJHi/YQNMUlbla3LdOvAs5aeW/FRN
   wBoCzE74WN+0ZxtPEcYW4SWIkgtzMZrtqboMtg3S18nHOx5uZPlIA1iRX
   EGCErcm7Tv2SqpAaFoaMO3NMXEM5K4h6YGU/qa0QSOF7tKChR2Pc1XrAj
   aJzynVWi2Kq3CTMwLV3dz02Gj/0spKfI56fUu2ZNYOjU/qSX7u3GOZnRZ
   f7t2zzrTWp7I7gHTn0h724GInsIBDkSuJdYBvlRMl4cfJch/7Zy4c/uRV
   yMyYaNAIw+KonjHvrTbHaLeSvql7qh6rAZwZVeKG0rd5sTXTFidz9Cym6
   g==;
X-CSE-ConnectionGUID: gl1g1QssTJi8Wwe/UHiBqw==
X-CSE-MsgGUID: 6A5MaxzVQ9u8ZwNLDacq1w==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="66320541"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:57:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:57:15 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:57:13 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:56:41 +0100
Subject: [PATCH net-next 6/9] net: sparx5/lan969x: add support for resizing
 the FDMA buffers
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-sparx5-mtu-change-v1-6-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com>
In-Reply-To: <20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
X-Mailer: b4 0.14.3

The FDMA buffers are sized from the largest MTU of the ports when the
FDMA is initialized, so they must be resized when an MTU change affects
that size. As the FDMA is shared by all ports, it must be stopped while
its buffers are replaced.

Add an fdma_resize operation, which allocates new buffers for the new
MTU while the FDMA keeps running on the current ones, so that a failed
allocation leaves the FDMA untouched. It then stops the port TX queues
and the FDMA, replaces the buffers, and restarts the FDMA and the TX
queues. On Sparx5 both the RX and TX buffers are replaced. On lan969x,
where TX frames are mapped directly from the skbs, only the RX buffers
and page_pool are replaced.

The forwarding to the CPU ports is stopped, and the frames already
queued for the CPU are extracted, before the FDMA is stopped. Otherwise,
with frames arriving for the CPU, extraction to the CPU can stop for
good after the restart.

On lan969x, to know which RX pages are still owned by the driver when
freeing them, clear the RX buffer slot once the page has been passed to
the stack.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   1 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   2 +
 .../microchip/sparx5/lan969x/lan969x_fdma.c        |  98 +++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 198 ++++++++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   9 +-
 6 files changed, 297 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index e8c30049b54cf..2ea3bb6023f92 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -356,6 +356,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.fdma_deinit             = &lan969x_fdma_deinit,
 	.fdma_poll               = &lan969x_fdma_napi_poll,
 	.fdma_xmit               = &lan969x_fdma_xmit,
+	.fdma_resize             = &lan969x_fdma_resize,
 };
 
 const struct sparx5_match_data lan969x_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
index 529fde3d4deba..c34ce0ed4e555 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
@@ -78,5 +78,7 @@ int lan969x_fdma_deinit(struct sparx5 *sparx5);
 int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight);
 int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 		      struct net_device *dev);
+int lan969x_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
+			int new_mtu);
 
 #endif
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 26a0815a0173b..d84663da35891 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -153,6 +153,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	skb->dev->stats.rx_bytes += skb->len;
 	skb->dev->stats.rx_packets++;
 
+	/* The page is passed to the stack in the skb, so clear its slot in the
+	 * ring, so that lan969x_fdma_rx_free() does not return it to the
+	 * page_pool.
+	 */
+	rx->page[fdma->dcb_index][fdma->db_index] = NULL;
+
 	return skb;
 
 free_page:
@@ -162,9 +168,11 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 }
 
 /* Get the page order needed for a page to hold the largest frame */
-static u8 lan969x_fdma_get_page_order(struct sparx5 *sparx5)
+static u8 lan969x_fdma_get_page_order(struct sparx5 *sparx5,
+				      struct sparx5_port *port, int new_mtu)
 {
-	return get_order(ALIGN(sparx5_fdma_get_max_frame(sparx5), 128) +
+	return get_order(ALIGN(sparx5_fdma_get_max_frame(sparx5, port, new_mtu),
+			       128) +
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
 }
 
@@ -394,7 +402,7 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 	struct sparx5_rx *rx = &sparx5->rx;
 	int err;
 
-	rx->page_order = lan969x_fdma_get_page_order(sparx5);
+	rx->page_order = lan969x_fdma_get_page_order(sparx5, NULL, 0);
 	lan969x_fdma_rx_init(sparx5, rx);
 	lan969x_fdma_tx_init(sparx5);
 	sparx5_fdma_injection_mode(sparx5);
@@ -437,3 +445,87 @@ int lan969x_fdma_deinit(struct sparx5 *sparx5)
 
 	return 0;
 }
+
+/* Release the TX buffers that were in flight when the FDMA was reset, and
+ * initialize the TX DCBs again.
+ */
+static void lan969x_fdma_tx_reset(struct sparx5 *sparx5)
+{
+	struct sparx5_tx *tx = &sparx5->tx;
+	struct fdma *fdma = &tx->fdma;
+	struct sparx5_tx_buf *db;
+
+	/* Complete the frames that were transmitted before the reset. BHs are
+	 * disabled as tx_clear_buf() expects to run from NAPI.
+	 */
+	local_bh_disable();
+	lan969x_fdma_tx_clear_buf(sparx5, 0);
+	local_bh_enable();
+
+	for (int i = 0; i < fdma->n_dcbs; ++i) {
+		db = &tx->dbs[i];
+
+		if (!db->used)
+			continue;
+
+		db->dev->stats.tx_dropped++;
+		sparx5->tx.dropped++;
+
+		dma_unmap_single(sparx5->dev,
+				 db->dma_addr,
+				 db->skb->len,
+				 DMA_TO_DEVICE);
+
+		if (!db->ptp)
+			dev_kfree_skb_any(db->skb);
+
+		db->used = false;
+	}
+
+	fdma_dcbs_init(fdma,
+		       FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_DONE);
+}
+
+int lan969x_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
+			int new_mtu)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_rx *rx_new;
+	u8 page_order;
+	int err;
+
+	page_order = lan969x_fdma_get_page_order(sparx5, port, new_mtu);
+	if (page_order == rx->page_order)
+		return 0;
+
+	rx_new = kzalloc_obj(*rx_new);
+	if (!rx_new)
+		return -ENOMEM;
+
+	rx_new->page_order = page_order;
+	lan969x_fdma_rx_init(sparx5, rx_new);
+
+	err = lan969x_fdma_rx_alloc(sparx5, rx_new);
+	if (err)
+		goto out;
+
+	sparx5_fdma_pause(sparx5);
+
+	/* The FDMA is stopped and reset, and NAPI and the TX queues are
+	 * disabled, so nothing uses the buffers until sparx5_fdma_resume().
+	 */
+	lan969x_fdma_tx_reset(sparx5);
+	lan969x_fdma_rx_free(sparx5, rx);
+
+	rx->fdma = rx_new->fdma;
+	rx->page_pool = rx_new->page_pool;
+	rx->page_order = rx_new->page_order;
+	memcpy(rx->page, rx_new->page, sizeof(rx->page));
+
+	sparx5_fdma_resume(sparx5);
+out:
+	kfree(rx_new);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 3a74a305d55d4..f4bb420d3f27b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -21,6 +21,13 @@
 #define FDMA_WEIGHT			4
 #define SPX5_FDMA_STOP_SLEEP_US		500
 #define SPX5_FDMA_STOP_TIMEOUT_US	10000
+#define SPX5_FDMA_TX_DRAIN_SLEEP_US	10
+#define SPX5_FDMA_TX_DRAIN_TIMEOUT_US	5000
+#define SPX5_FDMA_XTR_DRAIN_SLEEP_US	100
+#define SPX5_FDMA_XTR_DRAIN_TIMEOUT_US	100000
+
+/* Base of the QRES resources tracking memory per destination port */
+#define SPX5_QRES_DST_MEM		2048
 
 static int sparx5_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				     u64 *dataptr)
@@ -293,19 +300,23 @@ static int sparx5_fdma_tx_alloc(struct sparx5_tx *tx)
 }
 
 /* Get the size of the largest frame, including IFH and VLAN tags, that can be
- * received on any of the ports.
+ * received on any of the ports. If a port is given, its MTU is taken to be
+ * new_mtu instead of its current MTU, as the MTU is only updated once the
+ * buffers have been resized.
  */
-u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5)
+u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5,
+			      struct sparx5_port *port, int new_mtu)
 {
 	u32 max_mtu = 0;
 
 	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
-		struct sparx5_port *port = sparx5->ports[i];
+		struct sparx5_port *p = sparx5->ports[i];
 
-		if (!port)
+		if (!p)
 			continue;
 
-		max_mtu = max(max_mtu, READ_ONCE(port->ndev->mtu));
+		max_mtu = max_t(u32, max_mtu, p == port ?
+				new_mtu : READ_ONCE(p->ndev->mtu));
 	}
 
 	return SPX5_HW_MTU(max_mtu) + IFH_LEN * sizeof(u32) + VLAN_HLEN * 2;
@@ -314,9 +325,10 @@ u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5)
 /* Get the DB size needed to hold the largest frame. The DB size must be a
  * multiple of 128 bytes.
  */
-static u32 sparx5_fdma_get_db_size(struct sparx5 *sparx5)
+static u32 sparx5_fdma_get_db_size(struct sparx5 *sparx5,
+				   struct sparx5_port *port, int new_mtu)
 {
-	return ALIGN(sparx5_fdma_get_max_frame(sparx5), 128);
+	return ALIGN(sparx5_fdma_get_max_frame(sparx5, port, new_mtu), 128);
 }
 
 static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
@@ -465,7 +477,7 @@ int sparx5_fdma_init(struct sparx5 *sparx5)
 		 sparx5, CPU_PROC_CTRL);
 
 	sparx5_fdma_injection_mode(sparx5);
-	db_size = sparx5_fdma_get_db_size(sparx5);
+	db_size = sparx5_fdma_get_db_size(sparx5, NULL, 0);
 	sparx5_fdma_rx_init(sparx5, &sparx5->rx, FDMA_XTR_CHANNEL, db_size);
 	sparx5_fdma_tx_init(sparx5, &sparx5->tx, FDMA_INJ_CHANNEL, db_size);
 	err = sparx5_fdma_rx_alloc(&sparx5->rx);
@@ -558,3 +570,173 @@ int sparx5_fdma_stop(struct sparx5 *sparx5)
 
 	return 0;
 }
+
+/* Check if any TX DB is still waiting to be transmitted */
+static bool sparx5_fdma_tx_busy(struct fdma *fdma)
+{
+	for (int i = 0; i < fdma->n_dcbs; i++)
+		if (!fdma_db_is_done(fdma_db_get(fdma, i, 0)))
+			return true;
+
+	return false;
+}
+
+/* Enable or disable the forwarding of frames to the CPU ports */
+static void sparx5_fdma_cpu_fwd_set(struct sparx5 *sparx5, bool ena)
+{
+	for (int cpu = SPX5_PORT_CPU_0; cpu <= SPX5_PORT_CPU_1; cpu++) {
+		int portno = sparx5_get_internal_port(sparx5, cpu);
+
+		spx5_rmw(QFWD_SWITCH_PORT_MODE_PORT_ENA_SET(ena),
+			 QFWD_SWITCH_PORT_MODE_PORT_ENA,
+			 sparx5,
+			 QFWD_SWITCH_PORT_MODE(portno));
+	}
+}
+
+/* Get the memory used by the frames queued to the CPU ports */
+static u32 sparx5_fdma_cpu_queue_use(struct sparx5 *sparx5)
+{
+	u32 use = 0;
+
+	for (int cpu = SPX5_PORT_CPU_0; cpu <= SPX5_PORT_CPU_1; cpu++) {
+		int portno = sparx5_get_internal_port(sparx5, cpu);
+		u32 base;
+
+		base = SPX5_QRES_DST_MEM + SPX5_PRIOS * portno;
+		for (int prio = 0; prio < SPX5_PRIOS; prio++)
+			use += QRES_RES_STAT_CUR_INUSE_GET(spx5_rd(sparx5,
+					QRES_RES_STAT_CUR(base + prio)));
+	}
+
+	return use;
+}
+
+/* Stop the port TX queues and the FDMA, and reset the FDMA, so that the FDMA
+ * buffers can be replaced.
+ */
+void sparx5_fdma_pause(struct sparx5 *sparx5)
+{
+	bool busy;
+	u32 use;
+
+	/* Only ports that are up have TX queues to stop */
+	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
+		struct sparx5_port *port = sparx5->ports[i];
+
+		if (port && netif_running(port->ndev))
+			netif_tx_disable(port->ndev);
+	}
+
+	/* Give the frames already handed to the FDMA a chance to be sent, as
+	 * they are lost when the FDMA is reset.
+	 */
+	if (read_poll_timeout(sparx5_fdma_tx_busy,
+			      busy,
+			      !busy,
+			      SPX5_FDMA_TX_DRAIN_SLEEP_US,
+			      SPX5_FDMA_TX_DRAIN_TIMEOUT_US,
+			      false,
+			      &sparx5->tx.fdma))
+		dev_warn(sparx5->dev, "FDMA TX not drained, frames dropped\n");
+
+	/* Stop the switch core from forwarding frames to the CPU, and let the
+	 * FDMA extract the frames already queued, so that the FDMA is not
+	 * stopped and reset while the switch core is still sending it frames.
+	 */
+	sparx5_fdma_cpu_fwd_set(sparx5, false);
+	if (read_poll_timeout(sparx5_fdma_cpu_queue_use,
+			      use,
+			      !use,
+			      SPX5_FDMA_XTR_DRAIN_SLEEP_US,
+			      SPX5_FDMA_XTR_DRAIN_TIMEOUT_US,
+			      false,
+			      sparx5))
+		dev_warn(sparx5->dev, "CPU queue not drained, frames dropped\n");
+
+	sparx5_fdma_stop(sparx5);
+
+	/* Reset FDMA state */
+	spx5_wr(FDMA_CTRL_NRESET_SET(0), sparx5, FDMA_CTRL);
+	spx5_wr(FDMA_CTRL_NRESET_SET(1), sparx5, FDMA_CTRL);
+
+	/* Discard frames queued for the CPU, as they may not fit the new
+	 * buffers.
+	 */
+	sparx5_xtr_flush(sparx5, XTR_QUEUE);
+}
+
+/* Restart the FDMA and the port TX queues after sparx5_fdma_pause() */
+void sparx5_fdma_resume(struct sparx5 *sparx5)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_tx *tx = &sparx5->tx;
+
+	/* Enable NAPI before the RX interrupt is enabled, as the interrupt
+	 * handler schedules NAPI, as in sparx5_fdma_start().
+	 */
+	napi_enable(&rx->napi);
+
+	sparx5_fdma_rx_activate(sparx5, rx);
+	sparx5_fdma_tx_activate(sparx5, tx);
+
+	/* Forward frames to the CPU again, now that the FDMA can extract them */
+	sparx5_fdma_cpu_fwd_set(sparx5, true);
+
+	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
+		struct sparx5_port *port = sparx5->ports[i];
+
+		if (port && netif_running(port->ndev))
+			netif_tx_wake_all_queues(port->ndev);
+	}
+}
+
+int sparx5_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
+		       int new_mtu)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_tx *tx = &sparx5->tx;
+	struct sparx5_tx tx_new = {};
+	struct sparx5_rx *rx_new;
+	u32 db_size;
+	int err;
+
+	db_size = sparx5_fdma_get_db_size(sparx5, port, new_mtu);
+	if (db_size == rx->fdma.db_size)
+		return 0;
+
+	rx_new = kzalloc_obj(*rx_new);
+	if (!rx_new)
+		return -ENOMEM;
+
+	sparx5_fdma_rx_init(sparx5, rx_new, FDMA_XTR_CHANNEL, db_size);
+	sparx5_fdma_tx_init(sparx5, &tx_new, FDMA_INJ_CHANNEL, db_size);
+
+	err = sparx5_fdma_rx_alloc(rx_new);
+	if (err)
+		goto out;
+
+	err = sparx5_fdma_tx_alloc(&tx_new);
+	if (err) {
+		sparx5_fdma_rx_free(rx_new);
+		goto out;
+	}
+
+	sparx5_fdma_pause(sparx5);
+
+	/* The FDMA is stopped and reset, and NAPI and the TX queues are
+	 * disabled, so nothing uses the buffers until sparx5_fdma_resume().
+	 */
+	sparx5_fdma_rx_free(rx);
+	fdma_free_phys(&tx->fdma);
+
+	rx->fdma = rx_new->fdma;
+	memcpy(rx->skb, rx_new->skb, sizeof(rx->skb));
+	tx->fdma = tx_new.fdma;
+
+	sparx5_fdma_resume(sparx5);
+out:
+	kfree(rx_new);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index e039f5369b95e..cf9cdd494674f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -1092,6 +1092,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.fdma_deinit             = &sparx5_fdma_deinit,
 	.fdma_poll               = &sparx5_fdma_napi_callback,
 	.fdma_xmit               = &sparx5_fdma_xmit,
+	.fdma_resize             = &sparx5_fdma_resize,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 18b3bd33c11a7..7bf5bdbc2ee1b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -357,6 +357,8 @@ struct sparx5_ops {
 	int (*fdma_poll)(struct napi_struct *napi, int weight);
 	int (*fdma_xmit)(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 			 struct net_device *dev);
+	int (*fdma_resize)(struct sparx5 *sparx5, struct sparx5_port *port,
+			   int new_mtu);
 };
 
 struct sparx5_main_io_resource {
@@ -480,7 +482,12 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 irqreturn_t sparx5_fdma_handler(int irq, void *args);
 void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma);
 void sparx5_fdma_injection_mode(struct sparx5 *sparx5);
-u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5);
+u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5,
+			      struct sparx5_port *port, int new_mtu);
+void sparx5_fdma_pause(struct sparx5 *sparx5);
+void sparx5_fdma_resume(struct sparx5 *sparx5);
+int sparx5_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
+		       int new_mtu);
 
 /* sparx5_mactable.c */
 int sparx5_mact_learn(struct sparx5 *sparx5, int port,

-- 
2.34.1

