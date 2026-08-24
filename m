Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DC430CFD;
	Mon, 24 Aug 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579293; cv=none; b=ulg2Z1B2Rkf9cJYNelHoG6lt9QNGL4ibmHrpzkQkwxm/vzbthW7xn0bY3r5bKBFu1a/+XnfzAQmNa8VgVuyu5Asjzq9Jv1BlM4VfTXFN38dqy511rRjjlVcxXN83p7F+lI3ksxE4ziHLwjaALroZQbJf6dcEjsaIfygYQRE4O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579293; c=relaxed/simple;
	bh=3lgI5mTXWwfiCUZ89YnTLpXMeBlxVWFjRoKzcfeGUjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obai3tDb4Mequfsr8CJdHsvgCh+FmyBnBtqYqPQAd5GIKVUqxkoOQUFfZ53EY4oebnQ409OIRCZLqYN28C9mtZUCjN3rJSKYYeplWQ1g7htgTCs8PdYr7bz2N1buNb8nlaUoTgklbbqjE9uKWKWG8lY0ZBTQ9Q8cw2HIgSrUTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=GZfjwiIh; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="GZfjwiIh"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14DB7A8EBB;
	Mon, 24 Aug 2026 15:48:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787579281; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GD8jw6PzehuNSuKMwR0vnQHN0p6FQmXgAUkY79Oe/X4=;
	b=GZfjwiIhKAGhDxGbErDGzmroAslVAwWuD7fwV+5v90y0gNN4GMDDMzPEWvxPVFeHoryZaW
	ZpWz+zrqLiVwN5AjyNbFRF/Oyy1AvBMxP06RuOfKuMtD+4zwCgojxAmEyrIBPXNJNZqvD5
	R+GC7mPCeazmEiG7+vml0QJG9rpoponraC7o26octMgn+mzu+hjXMmrNqbVWYbyjGkzV2M
	ke9G/1lcQNg8qv+XPL1VO2vFZz+6cgFgq9OkOhuGIEaGgmrgkCjc4EgtJ9afom88yHY9yT
	esQe0APSrambB8InRy+kY7BVk8jbLNgIKhxxdj1b/Xv81kpS8D37WIY4dMHoug==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 1/2] net: macb: exclude software FCS from TX byte statistics
Date: Mon, 24 Aug 2026 15:47:02 +0200
Message-ID: <20260824134703.766708-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824134703.766708-1-nb@tipi-net.de>
References: <20260824134703.766708-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Frames going through macb_pad_and_fcs() get padded and four FCS
bytes appended, and TX completion then accounts the grown skb->len.
tx_bytes is supposed to exclude the FCS, and frames padded by the
hardware are counted without the padding anyway, so these frames
show up too large in the statistics.

Remember the length the stack handed over and use that for the byte
counters. BQL stays on the padded skb->len that
netdev_tx_sent_queue() saw.

Fixes: 653e92a9175e ("net: macb: add support for padding and fcs computation")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1e1f52285a39..802971c9d344 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -968,6 +968,8 @@ struct macb_dma_desc_ptp {
  *       of the frame
  * @mapping: DMA address of the skb's fragment buffer
  * @size: size of the DMA mapped buffer
+ * @skb_len: skb->len as handed over by the stack, before padding and
+ *           software FCS, only set for the last buffer of the frame
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
  */
@@ -975,6 +977,7 @@ struct macb_tx_skb {
 	struct sk_buff		*skb;
 	dma_addr_t		mapping;
 	size_t			size;
+	unsigned int		skb_len;
 	bool			mapped_as_page;
 };
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506033..623d072a271d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1322,8 +1322,8 @@ static void macb_tx_error_task(struct work_struct *work)
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
 				packets++;
-				bp->netdev->stats.tx_bytes += skb->len;
-				queue->stats.tx_bytes += skb->len;
+				bp->netdev->stats.tx_bytes += tx_skb->skb_len;
+				queue->stats.tx_bytes += tx_skb->skb_len;
 				bytes += skb->len;
 			}
 		} else {
@@ -1450,8 +1450,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
-				bp->netdev->stats.tx_bytes += skb->len;
-				queue->stats.tx_bytes += skb->len;
+				bp->netdev->stats.tx_bytes += tx_skb->skb_len;
+				queue->stats.tx_bytes += tx_skb->skb_len;
 				packets++;
 				bytes += skb->len;
 			}
@@ -2199,7 +2199,8 @@ static void macb_poll_controller(struct net_device *netdev)
 static unsigned int macb_tx_map(struct macb *bp,
 				struct macb_queue *queue,
 				struct sk_buff *skb,
-				unsigned int hdrlen)
+				unsigned int hdrlen,
+				unsigned int skb_len)
 {
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
@@ -2284,6 +2285,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	/* This is the last buffer of the frame: save socket buffer */
 	tx_skb->skb = skb;
+	tx_skb->skb_len = skb_len;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -2476,7 +2478,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
 	netdev_tx_t ret = NETDEV_TX_OK;
-	unsigned int hdrlen;
+	unsigned int hdrlen, skb_len;
 	unsigned long flags;
 	bool is_lso;
 
@@ -2485,6 +2487,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		return ret;
 	}
 
+	skb_len = skb->len;
 	if (macb_pad_and_fcs(&skb, netdev)) {
 		dev_kfree_skb_any(skb);
 		return ret;
@@ -2548,7 +2551,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	}
 
 	/* Map socket buffer for DMA transfer */
-	if (macb_tx_map(bp, queue, skb, hdrlen)) {
+	if (macb_tx_map(bp, queue, skb, hdrlen, skb_len)) {
 		dev_kfree_skb_any(skb);
 		goto unlock;
 	}
-- 
2.53.0

