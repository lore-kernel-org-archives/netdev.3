Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407498;
	b=jR/pmAOdgLRCVAceIi9yxGNTJxC3NQGslN/4owYSquOi6y77eMKAdRYwm/kd/AeQA0SY
	 iuf+ORaG1TEcHJfHTHr0cRyUJqJCUnHOYQLbA8d/8zzJ/qqc4Zpvmsrr4ZO5zhMzSbGfb
	 d3NgEVc7x7T3lHZ+YVGXbGII+37yzj/7669jdmoXNoV6K5QuuV0HUXgqi5LaawsEV8+UJ
	 hL5Gfz353gjhJR6uKv0G5OocLw0OkshrnjW1/rWv24uElLllLl77aksT7qwMYHW5cGUfb
	 z5nL/f0OB5eGx1Ffq0p+VNFcP4YjH36Up5Jv25DO2wDJOC3Fs3WvXQoyQo+SHESG0gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407498;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=PnBK66HP/fT6H+eaQgF43Rx8pyyh+o5PBekL591aHoo=;
	b=aFnsv0IYrMVgZ33GRzcbSOS2iK0aBolWM9PjbnVFhN0d0TH98m0Bp9OV/rWXwO2jIo2I
	 NEihujGMzCu3ESuImIQQ1LAhOk8JCF8/lB28mXep/Q5TyVXRF+6FhGO/eLnh0I5uZ8DIV
	 GMfqDYnfhK2jNCQo7nh2ytR+WZHq7SU+7lUDM7wqoDfWImDg2YjT0vXF9TIZT3HV50iRE
	 BiDKP/eN+WMCN+QIIiFYCij2dRZnFDnMNeghyjoiqP5atR8QFQHoYqLtnlUFL9uhXlwQz
	 JYdQjUiKGL3+34vxzR2OFbPl9Mb9LvrT8/kCfSKkV0nlvoPDHxwlJscJOZXyxntkvZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dPN4Jdjq;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68416606A33E;
	Wed, 11 Nov 2026 14:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68416606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dPN4Jdjq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407498; x=1825943498;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dV8gIlUudsQ/pX6yvOTsYE59h2XgDt++QsYWkAJx6Ng=;
  b=dPN4JdjqurVWsMOKzzVGdJsciiUkjt2E6LCxLioolL43Xjujjd08zBS7
   WJ66rra/U4F8p85Zkqir4KnJlaHAqry3blBgCelvNjQ2gB7P12AkD/7OD
   DzruzHab7mQ/SdzYYVW14LdJEbkm4n14jdJPKN1mu8AYVlmn8HlPjUgvD
   U/EqpYDx1+Bhi4WZUf3km3u6JVFTwBnNbZckrMM1PTYzyYoddoOu1qX9q
   NVfm4eNvwqwBeYWOUv6lwfu3yZLIahoxEll/aLuHe8rghUxpbX+rISEI6
   CGFgLGFmr7qzeFIcVCprJiOO5QIJHtlrOVl8HPjaIuZspjpUNLlAQ55RL
   Q==;
X-CSE-ConnectionGUID: ePMLfJOFRNS4SYQZgnp3Iw==
X-CSE-MsgGUID: ABiaS85iSf6gT7ZvGqA09Q==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="297775319"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:31:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 07:31:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:29 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 11 Nov 2026 15:31:12 +0100
Subject: [PATCH net-next v2 2/9] net: sparx5/lan969x: free the FDMA buffers
 on init errors and deinit
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
Message-ID: <20261111-sparx5-mtu-change-v2-2-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
In-Reply-To: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14.3

The FDMA RX buffers are skbs on Sparx5, and pages from a page_pool on
lan969x, which are handed to the FDMA through the RX DCBs. On lan969x,
the TX DCBs also have an array holding the state of the TX buffers.

These are not all freed. On Sparx5, the RX skbs are never freed, and if
the TX buffers cannot be allocated, the RX DCBs are not freed. On
lan969x, if the RX DCBs cannot be allocated, the page_pool is not
destroyed, if the TX buffers cannot be allocated, only the RX DCBs are
freed, and lan969x_fdma_deinit() never frees the TX buffer state, nor
the TX buffers that are still in flight. On both, the return value of
fdma_dcbs_init() is also ignored for RX, so if a buffer cannot be
allocated while filling the RX ring, the FDMA is started with a partly
filled ring, and on lan969x, lan969x_fdma_free_pages() later puts the
pages that were never allocated.

Add sparx5_fdma_rx_free(), which frees the RX skbs and DCBs,
lan969x_fdma_rx_free(), which returns the pages to the page_pool and
frees the page_pool and the RX DCBs, and lan969x_fdma_tx_free(), which
releases the TX buffers still in flight and frees the TX buffer state
and the TX DCBs, and use them on the error paths and on deinit. Check
the return value of fdma_dcbs_init() for RX. To know which RX buffers
are still owned by the driver, clear the RX buffer slot once the buffer
has been passed to the stack on Sparx5, and make
lan969x_fdma_free_pages() skip and clear the empty slots of the ring.
The two-step PTP skbs are owned by the PTP code, which may already have
freed them when a TX buffer is released, so store the length of the
mapped TX buffer, and use it instead of the skb length.

The issues were discovered by AI code review agents and confirmed by
code inspection; they were not reproduced. Tested by unbinding and
rebinding the switch driver on lan969x (EV23X71A).

Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
Fixes: 8fec1cea941d ("net: sparx5: use the FDMA library for allocation of rx buffers")
Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 89 +++++++++++++++++-----
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 30 +++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  1 +
 3 files changed, 99 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125eda658..8e0f1ddcbf2c4 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -67,13 +67,13 @@ static void lan969x_fdma_tx_clear_buf(struct sparx5 *sparx5, int weight)
 		if (!fdma_db_is_done(fdma_db_get(fdma, i, 0)))
 			continue;
 
-		db->dev->stats.tx_bytes += db->skb->len;
+		db->dev->stats.tx_bytes += db->len;
 		db->dev->stats.tx_packets++;
 		sparx5->tx.packets++;
 
 		dma_unmap_single(sparx5->dev,
 				 db->dma_addr,
-				 db->skb->len,
+				 db->len,
 				 DMA_TO_DEVICE);
 
 		if (!db->ptp)
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
@@ -202,6 +223,45 @@ static int lan969x_fdma_tx_alloc(struct sparx5 *sparx5)
 	return 0;
 }
 
+/* Release the TX buffers that are still in flight. The two-step PTP skbs are
+ * owned by the port tx_skbs list, so they are only unmapped.
+ */
+static void lan969x_fdma_tx_release(struct sparx5 *sparx5)
+{
+	struct sparx5_tx *tx = &sparx5->tx;
+	struct sparx5_tx_buf *db;
+
+	for (int i = 0; i < tx->fdma.n_dcbs; ++i) {
+		db = &tx->dbs[i];
+
+		if (!db->used)
+			continue;
+
+		db->dev->stats.tx_dropped++;
+		tx->dropped++;
+
+		dma_unmap_single(sparx5->dev,
+				 db->dma_addr,
+				 db->len,
+				 DMA_TO_DEVICE);
+
+		if (!db->ptp)
+			dev_kfree_skb_any(db->skb);
+
+		db->used = false;
+	}
+}
+
+/* Free the TX buffers, the TX buffer state and the TX DCBs */
+static void lan969x_fdma_tx_free(struct sparx5 *sparx5)
+{
+	struct sparx5_tx *tx = &sparx5->tx;
+
+	lan969x_fdma_tx_release(sparx5);
+	fdma_free_coherent(sparx5->dev, &tx->fdma);
+	kfree(tx->dbs);
+}
+
 static void lan969x_fdma_rx_init(struct sparx5 *sparx5)
 {
 	struct fdma *fdma = &sparx5->rx.fdma;
@@ -330,6 +390,7 @@ int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 
 	db_buf->dev = dev;
 	db_buf->skb = skb;
+	db_buf->len = skb->len;
 	db_buf->ptp = false;
 	db_buf->used = true;
 
@@ -353,7 +414,6 @@ int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 
 int lan969x_fdma_init(struct sparx5 *sparx5)
 {
-	struct sparx5_rx *rx = &sparx5->rx;
 	int err;
 
 	lan969x_fdma_rx_init(sparx5);
@@ -375,7 +435,7 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 
 	err = lan969x_fdma_tx_alloc(sparx5);
 	if (err) {
-		fdma_free_coherent(sparx5->dev, &rx->fdma);
+		lan969x_fdma_rx_free(sparx5);
 		dev_err(sparx5->dev, "Failed to allocate TX buffers: %d\n",
 			err);
 		return err;
@@ -390,14 +450,9 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 
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
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8dc3a500c1c91..e08b1635cfcd9 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -179,6 +179,7 @@ struct sparx5_tx_buf {
 	dma_addr_t dma_addr;
 	bool used;
 	bool ptp;
+	u32 len;
 };
 
 /* Frame DMA transmit state:

-- 
2.34.1

