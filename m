Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887027;
	b=2Lhscuyv8QM5OhrFYG6hOyDPzqo9zQXKGmBRP8ebmDDE05tn+WJ24nNM0xdetFnBXbfs
	 skEZEdeQ3EtPi4KZT5fhXei1a8Lw8PKvoRrnKHSXdPFKd2rOI56bO8KYChwNzPI1bSYp4
	 1ACKJt8I9n7UrxVRA5ytyNyfVJz0xJ+EdPia73WhBdRcuwjlQ9wc0R4JeYeFtWKEnTSSe
	 8lqGl0Xwd1V9SGIEQXSTjq9ibzPQa+A6fOpFxrjhwCfZDRMVcznDJGLnI4qZjYOWv12U4
	 5Ufan1wIW51AhplQ8WZJjJA5n3A3ETbPL5QUHu/ffn9LZp0wNSNbhuLRS+M1B1mdkgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887027;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=hdB7q81mTRiafyTU90+Nru1Z7mdwITDPN9ZjuiDmuj4=;
	b=I6z62xfVgxJIZ0q/fVF836X2rS/i8a7OVlxr70suGfs6HCkDtU+K9JrV1ZGrmgf3/LjG
	 ezwCGnpgEsjmLISeoZMd1+vIoCeGWluXd+0kvevhTCD9Id0FOp09N/sQcQaneEzTGxc5n
	 tjz7/lTTybvD4YBdxN5ckPNRmV+yntr+2PJ+JAc5W7IUBu4ukqHEpf7F0dhZSIYu7l3ve
	 hbeLlh+0J5CDtJIa21Skzb7zm0WDhkU5sE4kBP4NUkaRC8J0tvUYgIvO2MifVjqzVA1Sv
	 kBVA8AMxzAPVGn3dKhOLB529KYrGiB9Fh/yLL4rrQ+HnqodOab9xpburrQtYaPNqNKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=HI69DD1v;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984F606A339;
	Thu,  5 Nov 2026 13:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4984F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=HI69DD1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793887027; x=1825423027;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YyUtvcvn5oJhn+gogAh9fUM8vO0gq8//Wrd0z2MWH+g=;
  b=HI69DD1vg/XFHFeP9Hopl2laOfkUYkpL+eEE7RfjWvC9+Hjh+wghmjQT
   oiTcUlWFKnildcSZplcGoi56YrUYuLYyUwQUu13H7YXudOat3RpQpGwJA
   hlf4IG4Rzw1C+sFbUBluVKYq94JONAHNorkvsKd90j3xo0AArvHaGFynt
   5D1wYAx17J0ybPMmi02obvh5s51T8ASFXZhNtUzfFZ/2RtxESJqGw1gdp
   NkExdoGRaHEIOBN/Ni9Ypqh1C0Pxe6cOqHxYbIhQsk6Z/o3GSSC5AycGF
   O71Nh74/xnxQrTpiW2gpBCgYlT8juTj3OEFdEPbzIDchIL6ToP3tPwpJ7
   A==;
X-CSE-ConnectionGUID: I8o+1O/kTI+TII5nkTt4LQ==
X-CSE-MsgGUID: uGUqt2EvTC2hBa8NXhFNyw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="65112457"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2026 06:57:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Nov 2026 06:57:05 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:57:03 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:56:37 +0100
Subject: [PATCH net-next 2/9] net: sparx5/lan969x: free the FDMA buffers on
 init errors and deinit
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
Message-ID: <20261105-sparx5-mtu-change-v1-2-f27bab580463@microchip.com>
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

The FDMA RX buffers are skbs on Sparx5, and pages from a page_pool on
lan969x, which are handed to the FDMA through the RX DCBs. On lan969x,
the TX DCBs also have an array holding the state of the TX buffers.

These are not all freed. On Sparx5, the RX skbs are never freed, and
if the TX buffers cannot be allocated, the RX DCBs are not freed. On
lan969x, if the RX DCBs cannot be allocated, the page_pool is not
destroyed, if the TX buffers cannot be allocated, only the RX DCBs are
freed, and lan969x_fdma_deinit() never frees the TX buffer state. On
both, the return value of fdma_dcbs_init() is also ignored for RX, so
if a buffer cannot be allocated while filling the RX ring, the FDMA is
started with a partly filled ring, and on lan969x,
lan969x_fdma_free_pages() later puts the pages that were never
allocated.

In preparation for MTU support, add sparx5_fdma_rx_free(), which frees
the RX skbs and DCBs, lan969x_fdma_rx_free(), which returns the pages to
the page_pool and frees the page_pool and the RX DCBs, and
lan969x_fdma_tx_free(), which frees the TX buffer state and the TX
DCBs, and use them on the error paths and on deinit. Check the return
value of fdma_dcbs_init() for RX. To know which RX buffers are still
owned by the driver, clear the RX buffer slot once the buffer has been
passed to the stack on Sparx5, and make lan969x_fdma_free_pages() skip
and clear the empty slots of the ring.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 54 ++++++++++++++++------
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 30 ++++++++++--
 2 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125eda658..d162bea02cbfb 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -90,12 +90,29 @@ static void lan969x_fdma_free_pages(struct sparx5_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 
 	for (int i = 0; i < fdma->n_dcbs; ++i) {
-		for (int j = 0; j < fdma->n_dbs; ++j)
+		for (int j = 0; j < fdma->n_dbs; ++j) {
+			if (!rx->page[i][j])
+				continue;
+
 			page_pool_put_full_page(rx->page_pool,
 						rx->page[i][j], false);
+			rx->page[i][j] = NULL;
+		}
 	}
 }
 
+/* Return the pages in the RX ring to the page_pool, and free the page_pool
+ * and the RX DCBs.
+ */
+static void lan969x_fdma_rx_free(struct sparx5 *sparx5)
+{
+	struct sparx5_rx *rx = &sparx5->rx;
+
+	lan969x_fdma_free_pages(rx);
+	fdma_free_coherent(sparx5->dev, &rx->fdma);
+	page_pool_destroy(rx->page_pool);
+}
+
 static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 						 struct sparx5_rx *rx)
 {
@@ -169,14 +186,18 @@ static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
 		return PTR_ERR(rx->page_pool);
 
 	err = fdma_alloc_coherent(sparx5->dev, fdma);
-	if (err)
+	if (err) {
+		page_pool_destroy(rx->page_pool);
 		return err;
+	}
 
-	fdma_dcbs_init(fdma,
-		       FDMA_DCB_INFO_DATAL(fdma->db_size),
-		       FDMA_DCB_STATUS_INTR);
+	err = fdma_dcbs_init(fdma,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_INTR);
+	if (err)
+		lan969x_fdma_rx_free(sparx5);
 
-	return 0;
+	return err;
 }
 
 static int lan969x_fdma_tx_alloc(struct sparx5 *sparx5)
@@ -202,6 +223,15 @@ static int lan969x_fdma_tx_alloc(struct sparx5 *sparx5)
 	return 0;
 }
 
+/* Free the TX buffer state and the TX DCBs */
+static void lan969x_fdma_tx_free(struct sparx5 *sparx5)
+{
+	struct sparx5_tx *tx = &sparx5->tx;
+
+	fdma_free_coherent(sparx5->dev, &tx->fdma);
+	kfree(tx->dbs);
+}
+
 static void lan969x_fdma_rx_init(struct sparx5 *sparx5)
 {
 	struct fdma *fdma = &sparx5->rx.fdma;
@@ -353,7 +383,6 @@ int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 
 int lan969x_fdma_init(struct sparx5 *sparx5)
 {
-	struct sparx5_rx *rx = &sparx5->rx;
 	int err;
 
 	lan969x_fdma_rx_init(sparx5);
@@ -375,7 +404,7 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 
 	err = lan969x_fdma_tx_alloc(sparx5);
 	if (err) {
-		fdma_free_coherent(sparx5->dev, &rx->fdma);
+		lan969x_fdma_rx_free(sparx5);
 		dev_err(sparx5->dev, "Failed to allocate TX buffers: %d\n",
 			err);
 		return err;
@@ -390,14 +419,9 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 
 int lan969x_fdma_deinit(struct sparx5 *sparx5)
 {
-	struct sparx5_rx *rx = &sparx5->rx;
-	struct sparx5_tx *tx = &sparx5->tx;
-
 	sparx5_fdma_stop(sparx5);
-	fdma_free_coherent(sparx5->dev, &tx->fdma);
-	fdma_free_coherent(sparx5->dev, &rx->fdma);
-	lan969x_fdma_free_pages(rx);
-	page_pool_destroy(rx->page_pool);
+	lan969x_fdma_tx_free(sparx5);
+	lan969x_fdma_rx_free(sparx5);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index bcae0bbd5e44e..f4e8ac00dbe2f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -174,6 +174,10 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 	skb->dev->stats.rx_bytes += skb->len;
 	skb->dev->stats.rx_packets++;
 	rx->packets++;
+	/* The skb is passed to the stack, so clear its slot in the ring, so
+	 * that sparx5_fdma_rx_free() does not free it.
+	 */
+	rx->skb[fdma->dcb_index][fdma->db_index] = NULL;
 	netif_receive_skb(skb);
 	return true;
 }
@@ -239,6 +243,21 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+/* Free the RX skbs owned by the driver, and the RX DCBs */
+static void sparx5_fdma_rx_free(struct sparx5_rx *rx)
+{
+	struct fdma *fdma = &rx->fdma;
+
+	for (int i = 0; i < fdma->n_dcbs; i++) {
+		for (int j = 0; j < fdma->n_dbs; j++) {
+			consume_skb(rx->skb[i][j]);
+			rx->skb[i][j] = NULL;
+		}
+	}
+
+	fdma_free_phys(fdma);
+}
+
 static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 {
 	struct sparx5_rx *rx = &sparx5->rx;
@@ -249,10 +268,12 @@ static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 	if (err)
 		return err;
 
-	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
-		       FDMA_DCB_STATUS_INTR);
+	err = fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_INTR);
+	if (err)
+		sparx5_fdma_rx_free(rx);
 
-	return 0;
+	return err;
 }
 
 static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
@@ -425,6 +446,7 @@ int sparx5_fdma_init(struct sparx5 *sparx5)
 	}
 	err = sparx5_fdma_tx_alloc(sparx5);
 	if (err) {
+		sparx5_fdma_rx_free(&sparx5->rx);
 		dev_err(sparx5->dev, "Could not allocate TX buffers: %d\n", err);
 		return err;
 	}
@@ -434,7 +456,7 @@ int sparx5_fdma_init(struct sparx5 *sparx5)
 int sparx5_fdma_deinit(struct sparx5 *sparx5)
 {
 	sparx5_fdma_stop(sparx5);
-	fdma_free_phys(&sparx5->rx.fdma);
+	sparx5_fdma_rx_free(&sparx5->rx);
 	fdma_free_phys(&sparx5->tx.fdma);
 
 	return 0;

-- 
2.34.1

