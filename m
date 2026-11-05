Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887035;
	b=HqSZ1vsyPgtdewRN+9fGAkIM69/I8CZj3FWsi7qX5r5qy+1QQC91gkgBtUv8udMLT/S8
	 WTTKKDFBklH5wPaT7l8emz9MnsqSxh1BKm4r06IylBFj+md6jMiajRRfq9pClPOAff6nJ
	 Jk72+JITaHuzYd0tbnybeZEIRgP8rDKFjfhZiogCnz1qaGsS81p72xnPY2LMPuPQ1tNkW
	 PFhvzFt5Y5wLix4NgXbrcVD871NQdOjrWLDWtxQDyyOuVf3+jtSXI5AS6zE2rZ5dchuZU
	 cBCYwGaJL6m6lb5oJ5TW1tuEMgGwOQ98kqBuUyYuDOL9ApQ4UMdSfxb+i96/KiOJqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887035;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=a0HHkVp0d1WzeTz261sm5snbyXfyONSeg+unLHJTh6M=;
	b=hXG5YBgfHZtbl3XbZ3JBtAyh+CaJTaHWzAdgWU+pp9OTtfiMTJA8QS78TY7tM3qyu2h2
	 m54J8IUJvN63GKW1wA5Su1Xn48ClTxqb4DDOSHtlo8A9H5tgW0BwTmuTxj1SlpLVrLs8o
	 pdMRHDPS1fumpc1qNTo4lSIBw1BpHRlCh9pPhXPQewGkgN1xT8stnFWrvDUNz7fHXnvbs
	 oBFOAp3w1vK6ZFnwGFPnTikQqntZNrlIEPQ28FfBvJW4M2uVtTeGWoKGPQMVBJB2kBHmD
	 bBv8tw87VIQF1j+o9yr217nDlghTpshHF4oJ6n+j82yM0HU7yLEFNjmPyD/rA4Z/g8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="K0JM/GUt";
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3F606A31B;
	Thu,  5 Nov 2026 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB3F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=K0JM/GUt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793887041; x=1825423041;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wCGngij35oURRncYhXXCtXKKqEH2meAMlzZH8zHp+8A=;
  b=K0JM/GUtdRriQ1S603wQu4zjuFHM9q9zEjV10W+BoTcVORIfgHhDfKvJ
   0qG25P6iZqNNzzaA6JDdmDFkVSyzetLwI1JAKb/Ky4tagErfqyaIwPJyb
   bwo7CpEfVl8HzDdDZMGvpvatvIzntOxVTd45XyNSNrFZB3N+nVAAUwkIv
   GUqoMLL+bztc1zGa6UzhPtoRGpW5sCY02XN782VuahsBxDPCRWIxf6quQ
   Mc1lXDiFbN+am3iURqbnP8zQMfv5a12mg97cva592wdlN6HWk/sOEbaAA
   TmHAOg4MJFIgkKEHVSsGH7rrE+33rPOMxg3RHmIaTYdx14eArmvSVYqOv
   Q==;
X-CSE-ConnectionGUID: C9qMufzpTHWeg7pt1/Qu5A==
X-CSE-MsgGUID: +c7t8/TvQBeJ/duBm4/KVw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="66320536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:57:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:57:13 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:57:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:56:40 +0100
Subject: [PATCH net-next 5/9] net: sparx5/lan969x: size the FDMA buffers
 from the port MTUs
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
Message-ID: <20261105-sparx5-mtu-change-v1-5-f27bab580463@microchip.com>
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

The FDMA buffers must hold the largest frame that can be received by the
CPU, including the IFH, and on Sparx5 also the largest frame that is
transmitted, as Sparx5 copies the frames into its TX buffers. On Sparx5,
the RX buffers are skbs, and the TX buffers are a contiguous area. On
lan969x, the RX buffers are page_pool pages, which are turned into skbs
with build_skb(), and TX frames are mapped directly from the skbs. The
buffers are currently fixed to a single page, which is not large enough
to hold jumbo frames.

Instead, size the buffers from the largest MTU of the ports, plus the
Ethernet header, FCS, IFH and two VLAN tags. On Sparx5, use this length,
rounded up to the 128 byte granularity required by the FDMA, as the RX
and TX buffer size. As the TX buffers can now be smaller than a page,
make sparx5_fdma_xmit() drop frames that do not fit. On lan969x, use the
page order needed to hold the frame and the skb_shared_info, as lan966x
does, and limit the RX buffer size so that the FDMA never writes into
the skb_shared_info at the end of the page.

With the default MTU of 1500, the Sparx5 buffers become smaller, and the
lan969x pages are unchanged.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 22 ++++++++++----
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 35 ++++++++++++++++++++--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  2 ++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 5a6521ff774d8..26a0815a0173b 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -131,7 +131,7 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	if (WARN_ON(!port))
 		goto free_page;
 
-	skb = build_skb(page_address(page), fdma->db_size);
+	skb = build_skb(page_address(page), PAGE_SIZE << rx->page_order);
 	if (unlikely(!skb))
 		goto free_page;
 
@@ -161,21 +161,27 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	return NULL;
 }
 
+/* Get the page order needed for a page to hold the largest frame */
+static u8 lan969x_fdma_get_page_order(struct sparx5 *sparx5)
+{
+	return get_order(ALIGN(sparx5_fdma_get_max_frame(sparx5), 128) +
+			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+}
+
 static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
 	int err;
 
 	struct page_pool_params pp_params = {
-		.order = 0,
+		.order = rx->page_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = fdma->n_dcbs * fdma->n_dbs,
 		.nid = NUMA_NO_NODE,
 		.dev = sparx5->dev,
 		.dma_dir = DMA_FROM_DEVICE,
 		.offset = 0,
-		.max_len = fdma->db_size -
-			   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+		.max_len = fdma->db_size,
 	};
 
 	rx->page_pool = page_pool_create(&pp_params);
@@ -238,7 +244,12 @@ static void lan969x_fdma_rx_init(struct sparx5 *sparx5, struct sparx5_rx *rx)
 	fdma->n_dbs = 1;
 	fdma->priv = sparx5;
 	fdma->size = fdma_get_size(fdma);
-	fdma->db_size = PAGE_SIZE;
+	/* Keep the FDMA from writing into the skb_shared_info at the end of
+	 * the page. The DB size must be a multiple of 128 bytes.
+	 */
+	fdma->db_size = ALIGN_DOWN((PAGE_SIZE << rx->page_order) -
+				   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+				   128);
 	fdma->ops.dataptr_cb = &lan969x_fdma_rx_dataptr_cb;
 	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 
@@ -383,6 +394,7 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 	struct sparx5_rx *rx = &sparx5->rx;
 	int err;
 
+	rx->page_order = lan969x_fdma_get_page_order(sparx5);
 	lan969x_fdma_rx_init(sparx5, rx);
 	lan969x_fdma_tx_init(sparx5);
 	sparx5_fdma_injection_mode(sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 7ac5887abe6ee..3a74a305d55d4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -18,7 +18,6 @@
 #include "sparx5_main.h"
 #include "sparx5_port.h"
 
-#define FDMA_XTR_BUFFER_SIZE		2048
 #define FDMA_WEIGHT			4
 #define SPX5_FDMA_STOP_SLEEP_US		500
 #define SPX5_FDMA_STOP_TIMEOUT_US	10000
@@ -218,6 +217,10 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 	struct fdma *fdma = &tx->fdma;
 	void *virt_addr;
 
+	/* Drop frames that do not fit in the TX buffers */
+	if (unlikely(IFH_LEN * 4 + skb->len + ETH_FCS_LEN > fdma->db_size))
+		return -EMSGSIZE;
+
 	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
 		return -EINVAL;
 
@@ -289,6 +292,33 @@ static int sparx5_fdma_tx_alloc(struct sparx5_tx *tx)
 	return 0;
 }
 
+/* Get the size of the largest frame, including IFH and VLAN tags, that can be
+ * received on any of the ports.
+ */
+u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5)
+{
+	u32 max_mtu = 0;
+
+	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
+		struct sparx5_port *port = sparx5->ports[i];
+
+		if (!port)
+			continue;
+
+		max_mtu = max(max_mtu, READ_ONCE(port->ndev->mtu));
+	}
+
+	return SPX5_HW_MTU(max_mtu) + IFH_LEN * sizeof(u32) + VLAN_HLEN * 2;
+}
+
+/* Get the DB size needed to hold the largest frame. The DB size must be a
+ * multiple of 128 bytes.
+ */
+static u32 sparx5_fdma_get_db_size(struct sparx5 *sparx5)
+{
+	return ALIGN(sparx5_fdma_get_max_frame(sparx5), 128);
+}
+
 static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 				struct sparx5_rx *rx, int channel, u32 db_size)
 {
@@ -418,7 +448,7 @@ void sparx5_fdma_injection_mode(struct sparx5 *sparx5)
 
 int sparx5_fdma_init(struct sparx5 *sparx5)
 {
-	u32 db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
+	u32 db_size;
 	int err;
 
 	/* Reset FDMA state */
@@ -435,6 +465,7 @@ int sparx5_fdma_init(struct sparx5 *sparx5)
 		 sparx5, CPU_PROC_CTRL);
 
 	sparx5_fdma_injection_mode(sparx5);
+	db_size = sparx5_fdma_get_db_size(sparx5);
 	sparx5_fdma_rx_init(sparx5, &sparx5->rx, FDMA_XTR_CHANNEL, db_size);
 	sparx5_fdma_tx_init(sparx5, &sparx5->tx, FDMA_INJ_CHANNEL, db_size);
 	err = sparx5_fdma_rx_alloc(&sparx5->rx);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8dc3a500c1c91..18b3bd33c11a7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -109,6 +109,7 @@ enum sparx5_feature {
 #define SPX5_BUFFER_CELL_SZ    184   /* Cell size  */
 #define SPX5_BUFFER_MEMORY     4194280 /* 22795 words * 184 bytes */
 #define SPX5_TAS_ENTRIES_PER_PORT 2 /* TAS lists per port */
+#define SPX5_HW_MTU(mtu)       ((mtu) + ETH_HLEN + ETH_FCS_LEN)
 
 #define XTR_QUEUE     0
 #define INJ_QUEUE     0
@@ -479,6 +480,7 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 irqreturn_t sparx5_fdma_handler(int irq, void *args);
 void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma);
 void sparx5_fdma_injection_mode(struct sparx5 *sparx5);
+u32 sparx5_fdma_get_max_frame(struct sparx5 *sparx5);
 
 /* sparx5_mactable.c */
 int sparx5_mact_learn(struct sparx5 *sparx5, int port,

-- 
2.34.1

