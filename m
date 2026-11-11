Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407498;
	b=dEMLe07T+qCosTh3PQ8sBOH4Fi+xtXkzfo7Z7/TUizfEOSCWHR4M90zCnPybLNkkL2yr
	 kytln3gLNvhxX+pOpEyfFco3sySbMpWOw3NLBlqr2KC+FoNKxDJF72KbFo6ej61Et69vE
	 uFuRxJ4F0PQ9NDAMtx4JDq5L0sO3IWbuzWsGAEyOLqOmbsDQd/lGM2eTrfhD5AySPliLD
	 W/MRvKF9b23Ah3/ZSXMYk7YUnKClHld2FSeHiyQ5wyAg6esEnTHvG8oj+PtSagFcKybK0
	 Muezx5YJiDbM5FiFd88kgjZAh01iLGzj0YCKKRRyZWWzZ9OFtrBsCYAeLzDgx+0D/Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407498;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=i6i1kUy9sAi2Y6hv4St+4cljc4LjdWLYt2Gk6Dq80rA=;
	b=kFsDTxwLe0Iblk/+0uReR1PzStkcoaEVaBc+YgfbgVXKlfmpHAlJZhAicdcXKRpif1co
	 nnmJJml38eAGpVi4FRVqUm9HrOrt3gsRR79lewEzE8l/p1bT4HQsIY1vOyF/eNe7RV7zV
	 AP+UOWPMH1QPSawQXFTK4aHXIH5Ynlz9dzeHc39QasBVRCZo48G+TOvMtued5Zqj3dQbz
	 zm7Gj4l76PkADux+HTnNEirA2hizG6n8UP44M6jXSX9fSvl+83HcEwBiUcBAJscNDUzv7
	 pkEcfYcsAQ+ET/eD6vxfkP3P6gHIfjp+fxF9H6+jLPQCU6QlhjO4Sony+b7nY13aW0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=JH8z8s2L;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE7606A8A5;
	Wed, 11 Nov 2026 14:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31BE7606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=JH8z8s2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407498; x=1825943498;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FK0iO9INwMRraD9PO2ABMdsq855/zXIXouaZ0ZrvGp4=;
  b=JH8z8s2LWsjpdF+pN8faCP7Bd/fwuuSWnDAHTCSZ6nTMx/0uzOK4DWSu
   8pXjeFryUBvnYB6Yj3cYbbN8NQw/u2L4AjY+giRpkgbwcejEP+wK05+iP
   7SCOtBjo2LysfDfouJgSafKCG8IRNUtaTvXYYsoKvqjZEU1EtNXhJXU1f
   2qdI0IjF8mnZ52Z9fW4vxEsoP5BPw7JEN01RnDNQQFGbzp7cpBUqYN1k/
   i/Ny69MErDXAQvGrO2FggPwF6RGiuftpQMkv+2YI+zYCApieyzNW93h9d
   +svhyJGxFIHVoVJI9xLg2Ul0QBFym/cQsV4/uFb7wajDnoWyRm2QML07D
   A==;
X-CSE-ConnectionGUID: wCmg+WuqS9qii37n5Y5GVw==
X-CSE-MsgGUID: La2XoklETKaNjrpDeucnpA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="66598099"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 07:31:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 11 Nov 2026 07:31:37 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:34 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 11 Nov 2026 15:31:14 +0100
Subject: [PATCH net-next v2 4/9] net: sparx5/lan969x: pass the FDMA rings
 to the init and alloc functions
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
Message-ID: <20261111-sparx5-mtu-change-v2-4-59c91357e8f6@microchip.com>
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

The FDMA RX and TX rings are initialized and allocated by functions that
take struct sparx5, and operate on the rings in it. The RX buffer
callbacks also find the RX ring through struct sparx5, and the DB size
is computed in the RX and TX init functions.

In preparation for MTU support, where a new set of rings must be set up
while the FDMA keeps running on the current ones, make these functions
operate on the ring passed to them, and pass the DB size to the Sparx5
init functions. Find the RX ring in the RX buffer callbacks from the FDMA
that is passed to them. On lan969x, TX frames are mapped directly from
the skbs, so only the RX ring has to be replaced. Therefore, only its RX
functions take a ring, and its RX init function keeps computing the DB
size.

No functional change intended.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 28 ++++++++++----------
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 30 ++++++++++------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 8e0f1ddcbf2c4..d435c4df5effa 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -25,7 +25,7 @@ static int lan969x_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 static int lan969x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				      u64 *dataptr)
 {
-	struct sparx5_rx *rx = &FDMA_PRIV(fdma)->rx;
+	struct sparx5_rx *rx = container_of(fdma, struct sparx5_rx, fdma);
 	struct page *page;
 
 	page = page_pool_dev_alloc_pages(rx->page_pool);
@@ -104,10 +104,8 @@ static void lan969x_fdma_free_pages(struct sparx5_rx *rx)
 /* Return the pages in the RX ring to the page_pool, and free the page_pool
  * and the RX DCBs.
  */
-static void lan969x_fdma_rx_free(struct sparx5 *sparx5)
+static void lan969x_fdma_rx_free(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
-	struct sparx5_rx *rx = &sparx5->rx;
-
 	lan969x_fdma_free_pages(rx);
 	fdma_free_coherent(sparx5->dev, &rx->fdma);
 	page_pool_destroy(rx->page_pool);
@@ -163,9 +161,8 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	return NULL;
 }
 
-static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
+static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
-	struct sparx5_rx *rx = &sparx5->rx;
 	struct fdma *fdma = &rx->fdma;
 	int err;
 
@@ -195,7 +192,7 @@ static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
 			     FDMA_DCB_INFO_DATAL(fdma->db_size),
 			     FDMA_DCB_STATUS_INTR);
 	if (err)
-		lan969x_fdma_rx_free(sparx5);
+		lan969x_fdma_rx_free(sparx5, rx);
 
 	return err;
 }
@@ -262,9 +259,9 @@ static void lan969x_fdma_tx_free(struct sparx5 *sparx5)
 	kfree(tx->dbs);
 }
 
-static void lan969x_fdma_rx_init(struct sparx5 *sparx5)
+static void lan969x_fdma_rx_init(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
-	struct fdma *fdma = &sparx5->rx.fdma;
+	struct fdma *fdma = &rx->fdma;
 
 	fdma->channel_id = FDMA_XTR_CHANNEL;
 	fdma->n_dcbs = FDMA_DCB_MAX;
@@ -280,7 +277,7 @@ static void lan969x_fdma_rx_init(struct sparx5 *sparx5)
 		struct sparx5_port *port = sparx5->ports[idx];
 
 		if (port && port->ndev) {
-			sparx5->rx.ndev = port->ndev;
+			rx->ndev = port->ndev;
 			break;
 		}
 	}
@@ -414,9 +411,10 @@ int lan969x_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 
 int lan969x_fdma_init(struct sparx5 *sparx5)
 {
+	struct sparx5_rx *rx = &sparx5->rx;
 	int err;
 
-	lan969x_fdma_rx_init(sparx5);
+	lan969x_fdma_rx_init(sparx5, rx);
 	lan969x_fdma_tx_init(sparx5);
 	sparx5_fdma_injection_mode(sparx5);
 
@@ -426,7 +424,7 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 		return err;
 	}
 
-	err = lan969x_fdma_rx_alloc(sparx5);
+	err = lan969x_fdma_rx_alloc(sparx5, rx);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to allocate RX buffers: %d\n",
 			err);
@@ -435,7 +433,7 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 
 	err = lan969x_fdma_tx_alloc(sparx5);
 	if (err) {
-		lan969x_fdma_rx_free(sparx5);
+		lan969x_fdma_rx_free(sparx5, rx);
 		dev_err(sparx5->dev, "Failed to allocate TX buffers: %d\n",
 			err);
 		return err;
@@ -450,9 +448,11 @@ int lan969x_fdma_init(struct sparx5 *sparx5)
 
 int lan969x_fdma_deinit(struct sparx5 *sparx5)
 {
+	struct sparx5_rx *rx = &sparx5->rx;
+
 	sparx5_fdma_stop(sparx5);
 	lan969x_fdma_tx_free(sparx5);
-	lan969x_fdma_rx_free(sparx5);
+	lan969x_fdma_rx_free(sparx5, rx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index f4e8ac00dbe2f..7ac5887abe6ee 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -35,8 +35,7 @@ static int sparx5_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 static int sparx5_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				     u64 *dataptr)
 {
-	struct sparx5 *sparx5 = fdma->priv;
-	struct sparx5_rx *rx = &sparx5->rx;
+	struct sparx5_rx *rx = container_of(fdma, struct sparx5_rx, fdma);
 	struct sk_buff *skb;
 
 	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);
@@ -258,9 +257,8 @@ static void sparx5_fdma_rx_free(struct sparx5_rx *rx)
 	fdma_free_phys(fdma);
 }
 
-static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
+static int sparx5_fdma_rx_alloc(struct sparx5_rx *rx)
 {
-	struct sparx5_rx *rx = &sparx5->rx;
 	struct fdma *fdma = &rx->fdma;
 	int err;
 
@@ -276,9 +274,8 @@ static int sparx5_fdma_rx_alloc(struct sparx5 *sparx5)
 	return err;
 }
 
-static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
+static int sparx5_fdma_tx_alloc(struct sparx5_tx *tx)
 {
-	struct sparx5_tx *tx = &sparx5->tx;
 	struct fdma *fdma = &tx->fdma;
 	int err;
 
@@ -293,7 +290,7 @@ static int sparx5_fdma_tx_alloc(struct sparx5 *sparx5)
 }
 
 static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
-				struct sparx5_rx *rx, int channel)
+				struct sparx5_rx *rx, int channel, u32 db_size)
 {
 	struct fdma *fdma = &rx->fdma;
 	int idx;
@@ -302,8 +299,8 @@ static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 	fdma->n_dcbs = FDMA_DCB_MAX;
 	fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
 	fdma->priv = sparx5;
-	fdma->db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
-	fdma->size = fdma_get_size(&sparx5->rx.fdma);
+	fdma->db_size = db_size;
+	fdma->size = fdma_get_size(fdma);
 	fdma->ops.dataptr_cb = &sparx5_fdma_rx_dataptr_cb;
 	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 	/* Fetch a netdev for SKB and NAPI use, any will do */
@@ -318,7 +315,7 @@ static void sparx5_fdma_rx_init(struct sparx5 *sparx5,
 }
 
 static void sparx5_fdma_tx_init(struct sparx5 *sparx5,
-				struct sparx5_tx *tx, int channel)
+				struct sparx5_tx *tx, int channel, u32 db_size)
 {
 	struct fdma *fdma = &tx->fdma;
 
@@ -326,8 +323,8 @@ static void sparx5_fdma_tx_init(struct sparx5 *sparx5,
 	fdma->n_dcbs = FDMA_DCB_MAX;
 	fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
 	fdma->priv = sparx5;
-	fdma->db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
-	fdma->size = fdma_get_size_contiguous(&sparx5->tx.fdma);
+	fdma->db_size = db_size;
+	fdma->size = fdma_get_size_contiguous(fdma);
 	fdma->ops.dataptr_cb = &sparx5_fdma_tx_dataptr_cb;
 	fdma->ops.nextptr_cb = &fdma_nextptr_cb;
 }
@@ -421,6 +418,7 @@ void sparx5_fdma_injection_mode(struct sparx5 *sparx5)
 
 int sparx5_fdma_init(struct sparx5 *sparx5)
 {
+	u32 db_size = ALIGN(FDMA_XTR_BUFFER_SIZE, PAGE_SIZE);
 	int err;
 
 	/* Reset FDMA state */
@@ -437,14 +435,14 @@ int sparx5_fdma_init(struct sparx5 *sparx5)
 		 sparx5, CPU_PROC_CTRL);
 
 	sparx5_fdma_injection_mode(sparx5);
-	sparx5_fdma_rx_init(sparx5, &sparx5->rx, FDMA_XTR_CHANNEL);
-	sparx5_fdma_tx_init(sparx5, &sparx5->tx, FDMA_INJ_CHANNEL);
-	err = sparx5_fdma_rx_alloc(sparx5);
+	sparx5_fdma_rx_init(sparx5, &sparx5->rx, FDMA_XTR_CHANNEL, db_size);
+	sparx5_fdma_tx_init(sparx5, &sparx5->tx, FDMA_INJ_CHANNEL, db_size);
+	err = sparx5_fdma_rx_alloc(&sparx5->rx);
 	if (err) {
 		dev_err(sparx5->dev, "Could not allocate RX buffers: %d\n", err);
 		return err;
 	}
-	err = sparx5_fdma_tx_alloc(sparx5);
+	err = sparx5_fdma_tx_alloc(&sparx5->tx);
 	if (err) {
 		sparx5_fdma_rx_free(&sparx5->rx);
 		dev_err(sparx5->dev, "Could not allocate TX buffers: %d\n", err);

-- 
2.34.1

