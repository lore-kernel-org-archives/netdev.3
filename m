Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E50349B1C;
	Mon, 31 Aug 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175918; cv=none; b=MQDkZqfiUp344ytAlaB2csm9YgGLEc7FquchEllPPeDrRfHfXv1nARAQ1gLTbToGL2WBJooups8pKeU37HzMktEUykGoW1Ik9S+jlombq2FFyKyTQRLdLIDmgmTlY3oXsyEclXd5L004KUsUtkE38uyYPQ8QOcCvfBkYEJTfxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175918; c=relaxed/simple;
	bh=WBYSbjAyJMar+AWDYIJVYt2kwpVmbrEuRdJTtUfwa+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6NZ80JWF6zjUTN1OOhJZv/XxWv6NogH3uLeIEJr5acLqo84RkN8QDkJL5g98hYzJ0PJfWpToXAnkMoXCVZQvDUNZv9PTmN1D2EoaeHok1YEtvnp26jf8rav7j8CYHSB98gvGbsPlHcfuWR4oueRR+oHjNnvOcCBk4N1gtYqQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=eKNOlAPX; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="eKNOlAPX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4627A3C01;
	Mon, 31 Aug 2026 13:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788175910; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ikqKP7N4gfkljOC5wiO0qpzCYoDu6acU4F3h7XHJdX4=;
	b=eKNOlAPXphB57yUnkms4F+M5xtW5q6CN2qvGYpznAORw5LZ/RsGpPPsmAVkTkDIK+Kh7pL
	wA87/e/ejHw7HnezVyRdg9fi1qFkYmlAeEGqWRnnzs9DTTdg61FdwTE+dSSNEBOLduAC6R
	AOHjTDFZiIA8ZfyFBKIErlFzhCiBdqzDi0gdT6ooEbuBBKtkAvrtd/FoZZG/UdU3kkJnpQ
	JwGBpDUTe2mVnLVggV/UykDVsnAer3JUdYmNUWDg1nwMUsVkaZ1voevYBvd0HTa3pca95q
	FAgFMnWdsrruHzqb+PFsoYnjXVoJf4c4C8ozJHpTRwdxb0R5Jl4QXzrFWodGYA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net] net: macb: exclude software FCS from TX byte statistics
Date: Mon, 31 Aug 2026 13:31:28 +0200
Message-ID: <20260831113128.1678674-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Frames for which macb_pad_and_fcs() supplies the FCS have four FCS
bytes appended, and TX completion then accounts the grown skb->len.
tx_bytes is defined to exclude the FCS, so these frames are reported
four bytes too large.

Track only the number of FCS bytes appended in software, 0 or
ETH_FCS_LEN, and subtract that from skb->len at completion. skb->len
already reflects the padded length by then, so there is nothing else
to store. macb_pad_and_fcs() already returns 0 on every non-error
path. Return the FCS length from there instead, rather than
recomputing the same check in the caller. BQL stays on the padded
skb->len that netdev_tx_sent_queue() saw.

Fixes: 653e92a9175e ("net: macb: add support for padding and fcs computation")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Originally patch 1/2 of "net: macb: fix zero UDPv4 checksum on
transmit" [1], split out into its own patch since it's a pre-existing,
partly related issue, as suggested by Paolo and David.

[1] https://lore.kernel.org/all/20260824134703.766708-1-nb@tipi-net.de/

 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1e1f52285a39..d6931c41f39d 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -968,6 +968,8 @@ struct macb_dma_desc_ptp {
  *       of the frame
  * @mapping: DMA address of the skb's fragment buffer
  * @size: size of the DMA mapped buffer
+ * @fcs_len: FCS bytes appended in software, 0 or ETH_FCS_LEN, only
+ *           set for the last buffer of the frame
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
  */
@@ -975,6 +977,7 @@ struct macb_tx_skb {
 	struct sk_buff		*skb;
 	dma_addr_t		mapping;
 	size_t			size;
+	u8			fcs_len;
 	bool			mapped_as_page;
 };
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506033..b1939da4c95a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1322,8 +1322,8 @@ static void macb_tx_error_task(struct work_struct *work)
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
 				packets++;
-				bp->netdev->stats.tx_bytes += skb->len;
-				queue->stats.tx_bytes += skb->len;
+				bp->netdev->stats.tx_bytes += skb->len - tx_skb->fcs_len;
+				queue->stats.tx_bytes += skb->len - tx_skb->fcs_len;
 				bytes += skb->len;
 			}
 		} else {
@@ -1450,8 +1450,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
-				bp->netdev->stats.tx_bytes += skb->len;
-				queue->stats.tx_bytes += skb->len;
+				bp->netdev->stats.tx_bytes += skb->len - tx_skb->fcs_len;
+				queue->stats.tx_bytes += skb->len - tx_skb->fcs_len;
 				packets++;
 				bytes += skb->len;
 			}
@@ -2199,7 +2199,8 @@ static void macb_poll_controller(struct net_device *netdev)
 static unsigned int macb_tx_map(struct macb *bp,
 				struct macb_queue *queue,
 				struct sk_buff *skb,
-				unsigned int hdrlen)
+				unsigned int hdrlen,
+				u8 fcs_len)
 {
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
@@ -2284,6 +2285,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	/* This is the last buffer of the frame: save socket buffer */
 	tx_skb->skb = skb;
+	tx_skb->fcs_len = fcs_len;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -2417,6 +2419,7 @@ static inline int macb_clear_csum(struct sk_buff *skb)
 	return 0;
 }
 
+/* Returns a negative errno, or the FCS bytes appended (0 or ETH_FCS_LEN). */
 static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 {
 	bool cloned = skb_cloned(*skb) || skb_header_cloned(*skb) ||
@@ -2465,7 +2468,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 	skb_put_u8(*skb, (fcs >> 16)	& 0xff);
 	skb_put_u8(*skb, (fcs >> 24)	& 0xff);
 
-	return 0;
+	return ETH_FCS_LEN;
 }
 
 static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
@@ -2478,6 +2481,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	netdev_tx_t ret = NETDEV_TX_OK;
 	unsigned int hdrlen;
 	unsigned long flags;
+	int fcs_len;
 	bool is_lso;
 
 	if (macb_clear_csum(skb)) {
@@ -2485,7 +2489,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		return ret;
 	}
 
-	if (macb_pad_and_fcs(&skb, netdev)) {
+	fcs_len = macb_pad_and_fcs(&skb, netdev);
+	if (fcs_len < 0) {
 		dev_kfree_skb_any(skb);
 		return ret;
 	}
@@ -2548,7 +2553,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	}
 
 	/* Map socket buffer for DMA transfer */
-	if (macb_tx_map(bp, queue, skb, hdrlen)) {
+	if (macb_tx_map(bp, queue, skb, hdrlen, fcs_len)) {
 		dev_kfree_skb_any(skb);
 		goto unlock;
 	}
-- 
2.53.0

