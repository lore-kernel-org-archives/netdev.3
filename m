Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BF36604B;
	Tue,  6 Oct 2026 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265319; cv=none; b=lq1pKYvoCQAtFeYLSmn/lfqxw6YbKreLSZfU9pB+/a8MqF+IqMAa2vJnRJCe4KAhP16FQTV6hQeCpAeAIeGns2Hh5J5ng4vtMBJVLFNWvE+1h8NFnd3VTR3R9S86JZY3N59Aq8plU9m0h+i74JSV7mbOK7dTif26beK6Spr7Ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265319; c=relaxed/simple;
	bh=1iOVfLzrma7K/hofEAr4pozewWhmu55KBQwUm6QIOl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bI7ZcRQz4FJ7nXRfXOV/AkYUyXtzqbNQiUJla3yJDfvwmqF54AJSk1uB00T+urVLyC86clj6iX4hNzQs80xaGUYADhkCEO70JzJR8KS7ZAn45yU9B8FxX5e8TwwS2IQPfF2Iu8h5uhFj4tBRcn24Pre5SPk0hBjHLuZIaIH8GJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=wKPzmmU8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="wKPzmmU8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5CEDA0E37;
	Tue,  6 Oct 2026 07:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791265313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iunHygIHWhS3fid0esaS6vPYpunkM8jMxHnVgGD6RoQ=;
	b=wKPzmmU8taLWaJW/vp9AmGoEgQ9g7zuqlMrLr3R/rGnFw3j9CSZaJj+6RrEwXPPun2rlGV
	pkI9TnjIpGsiA5ntUg23+C47vJ5lrqEf0Zp9SfVupFAee+UBjm/Mo3gXMQ/wZjgxoeMgGH
	BRf+lx0iN5z8OIqficW91eSkefmr4/HL8Hd+t1ntIlKYkJ1v6yhM62BhS4y7yeg39Ekv8T
	sfII1BDCYVGOsVxZpVMpw5S8ZmwcXHSCBrL9VU5PSa2QMbN7BltZgarFuixIQJ2Hotk4f4
	Mi7KaJ8P1siwMAE6FjA9bDzr8aO9sE5+sblswYN6awxoCqHuPrko4f2tIrsjyw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 07:41:32 +0200
Subject: [PATCH net 1/2] net: macb: check TX ring before modifying skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-macb-shared-skb-net-v1-1-a80641479041@tipi-net.de>
References: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
In-Reply-To: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

macb_pad_and_fcs() replaces or extends the skb before the ring space
check. On NETDEV_TX_BUSY the stack requeues an skb that is already freed
or grown.

Check the ring first, using the padded length for the descriptor count.
Nonlinear skbs always take the copy path so the count can assume a
linear skb.

Fixes: 653e92a9175e ("net: macb: add support for padding and fcs computation")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 76 +++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8e5c034dc3a4..6082e63009a5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2421,8 +2421,15 @@ static inline int macb_clear_csum(struct sk_buff *skb)
 	return 0;
 }
 
+static bool macb_needs_sw_fcs(struct sk_buff *skb, struct net_device *netdev)
+{
+	return netdev->features & NETIF_F_HW_CSUM &&
+	       skb->ip_summed != CHECKSUM_PARTIAL &&
+	       !skb_shinfo(skb)->gso_size && !ptp_one_step_sync(skb);
+}
+
 /* Returns a negative errno, or the FCS bytes appended (0 or ETH_FCS_LEN). */
-static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
+static int macb_pad_and_fcs(struct sk_buff **skb, bool add_fcs)
 {
 	bool cloned = skb_cloned(*skb) || skb_header_cloned(*skb) ||
 		      skb_is_nonlinear(*skb);
@@ -2431,18 +2438,15 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 	struct sk_buff *nskb;
 	u32 fcs;
 
-	if (!(netdev->features & NETIF_F_HW_CSUM) ||
-	    !((*skb)->ip_summed != CHECKSUM_PARTIAL) ||
-	    skb_shinfo(*skb)->gso_size || ptp_one_step_sync(*skb))
+	if (!add_fcs)
 		return 0;
 
 	if (padlen <= 0) {
-		/* FCS could be appeded to tailroom. */
-		if (tailroom >= ETH_FCS_LEN)
+		/* FCS could be appended to tailroom. */
+		if (!skb_is_nonlinear(*skb) && tailroom >= ETH_FCS_LEN)
 			goto add_fcs;
-		/* No room for FCS, need to reallocate skb. */
-		else
-			padlen = ETH_FCS_LEN;
+		/* Reallocate with room for the FCS. */
+		padlen = ETH_FCS_LEN;
 	} else {
 		/* Add room for FCS. */
 		padlen += ETH_FCS_LEN;
@@ -2481,27 +2485,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
 	netdev_tx_t ret = NETDEV_TX_OK;
-	unsigned int hdrlen;
+	unsigned int hdrlen, tx_len;
+	bool add_fcs, is_lso;
 	unsigned long flags;
 	int fcs_len;
-	bool is_lso;
-
-	if (macb_clear_csum(skb)) {
-		dev_kfree_skb_any(skb);
-		return ret;
-	}
-
-	fcs_len = macb_pad_and_fcs(&skb, netdev);
-	if (fcs_len < 0) {
-		dev_kfree_skb_any(skb);
-		return ret;
-	}
-
-	if (macb_dma_ptp(bp) &&
-	    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
+	add_fcs = macb_needs_sw_fcs(skb, netdev);
 	is_lso = (skb_shinfo(skb)->gso_size != 0);
+	tx_len = add_fcs ? max_t(unsigned int, skb->len, ETH_ZLEN) +
+			   ETH_FCS_LEN : skb->len;
 
 	if (is_lso) {
 		/* length of headers */
@@ -2515,8 +2507,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 			/* if this is required, would need to copy to single buffer */
 			return NETDEV_TX_BUSY;
 		}
-	} else
+	} else if (add_fcs) {
+		hdrlen = umin(tx_len, bp->max_tx_length);
+	} else {
 		hdrlen = umin(skb_headlen(skb), bp->max_tx_length);
+	}
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
 	netdev_vdbg(bp->netdev,
@@ -2531,12 +2526,18 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	 * socket buffer: skb fragments of jumbo frames may need to be
 	 * split into many buffer descriptors.
 	 */
-	if (is_lso && (skb_headlen(skb) > hdrlen))
+	if (add_fcs) {
+		/* macb_pad_and_fcs() linearizes the skb before adding the FCS. */
+		desc_cnt = DIV_ROUND_UP(tx_len, bp->max_tx_length);
+		nr_frags = 0;
+	} else if (is_lso && (skb_headlen(skb) > hdrlen)) {
 		/* extra header descriptor if also payload in first buffer */
 		desc_cnt = DIV_ROUND_UP((skb_headlen(skb) - hdrlen), bp->max_tx_length) + 1;
-	else
+		nr_frags = skb_shinfo(skb)->nr_frags;
+	} else {
 		desc_cnt = DIV_ROUND_UP(skb_headlen(skb), bp->max_tx_length);
-	nr_frags = skb_shinfo(skb)->nr_frags;
+		nr_frags = skb_shinfo(skb)->nr_frags;
+	}
 	for (f = 0; f < nr_frags; f++) {
 		frag_size = skb_frag_size(&skb_shinfo(skb)->frags[f]);
 		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
@@ -2554,6 +2555,21 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		goto unlock;
 	}
 
+	if (macb_clear_csum(skb)) {
+		dev_kfree_skb_any(skb);
+		goto unlock;
+	}
+
+	fcs_len = macb_pad_and_fcs(&skb, add_fcs);
+	if (fcs_len < 0) {
+		dev_kfree_skb_any(skb);
+		goto unlock;
+	}
+
+	if (macb_dma_ptp(bp) &&
+	    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
 	/* Map socket buffer for DMA transfer */
 	if (macb_tx_map(bp, queue, skb, hdrlen, fcs_len)) {
 		dev_kfree_skb_any(skb);

-- 
2.53.0

