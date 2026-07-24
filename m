Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA834D915;
	Fri, 24 Jul 2026 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906987; cv=none; b=pnrbNNtPqVo+O8MJKBkZUxrCK32q39dVrB6nOr1y7xZr10hPM/3GZRf85MNl90IBqb2ujYE4FwRlT0C/0WgVo0DYAkmkzerR1Hpfzf3/obvZl+H5QWtK+bHbS7aqyf8fieZc64c2QUVfN6uulFOMlR+LG5HxwXwK5j0sMsF4tDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906987; c=relaxed/simple;
	bh=A4AeFJohsjvoE6z18K8MKaPBrqroZMgmXqUskrN9q8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sX4XEzp67RAAYO+wFy3CQS1e4zHxk83UjvwQRi7Zz3TR6TEYTXMUAmehQRbciob2GF4hvLy09NFGpmRXo1C+kEuyA4GpXvuQBWK2EGNFEWHMytb8QaRAfygnubX6JaJbmiOjBpTqxn09bVLAih7Sjb/+A0ckUnNapZOQ3uH7Qi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CEVEwzEV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CEVEwzEV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C5C474E40F33;
	Fri, 24 Jul 2026 15:29:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9989860395;
	Fri, 24 Jul 2026 15:29:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52D4711C12774;
	Fri, 24 Jul 2026 17:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784906982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vvkaddsCVLx8HLz7HBHt7v2yU8Im97aemV0OsXBJc3g=;
	b=CEVEwzEVvyS93dcmX0lM2c3h60TK/sXMAwvAm3DH+QqX8tXP3ki9olnB05kSf234I6zY1u
	sMOMOspbcTFMJ51JcYbeoM1CBUygyhdA3p2nUHeFKV547PVZSV6TbIxCC+xRlxmvB6lC2I
	IW09CdD63KEBi1EPr7JG7yki3o2TINaVOuDXeBfUdVVmBeyTGW+Z+ikS4x5d7u+2EXPv64
	d3382X/s0IMuhCv0GsFldtoQtfPNTIZ9oL3McfYOGOyjF311VbT3L3Maqk37spr/Dt2f6Y
	rUdVOTKi0rr0n91p3CxgEbfIrbPoWVnsr3PCX2W1ByU5091KU9SPfJIMC+8bpw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 24 Jul 2026 17:29:27 +0200
Subject: [PATCH net-next v5 04/15] net: macb: unify queue index variable
 naming convention and types
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-macb-context-v5-4-569b1852bc7f@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Variables are named q or queue_index. Types are int, unsigned int, u32
and u16. Use `unsigned int q` everywhere.

Skip over taprio functions. They use `u8 queue_id` which fits with the
`struct macb_queue_enst_config` field. Using `queue_id` everywhere
would be too verbose.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 0e0e0969d4b0..99d3c9091d19 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -877,7 +877,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 static void gem_shuffle_tx_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
-	int q;
+	unsigned int q;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; q++, queue++)
 		gem_shuffle_tx_one_ring(queue);
@@ -1258,7 +1258,7 @@ static void macb_tx_error_task(struct work_struct *work)
 						      tx_error_task);
 	bool			halt_timeout = false;
 	struct macb		*bp = queue->bp;
-	u32			queue_index;
+	unsigned int		q;
 	u32			packets = 0;
 	u32			bytes = 0;
 	struct macb_tx_skb	*tx_skb;
@@ -1267,9 +1267,9 @@ static void macb_tx_error_task(struct work_struct *work)
 	unsigned int		tail;
 	unsigned long		flags;
 
-	queue_index = queue - bp->queues;
+	q = queue - bp->queues;
 	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
-		    queue_index, queue->tx_tail, queue->tx_head);
+		    q, queue->tx_tail, queue->tx_head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1342,7 +1342,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
 	/* Set end of TX queue */
@@ -1407,7 +1407,7 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
-	u16 queue_index = queue - bp->queues;
+	unsigned int q = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
@@ -1469,14 +1469,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		}
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
 	queue->tx_tail = tail;
-	if (__netif_subqueue_stopped(bp->netdev, queue_index) &&
+	if (__netif_subqueue_stopped(bp->netdev, q) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
-		netif_wake_subqueue(bp->netdev, queue_index);
+		netif_wake_subqueue(bp->netdev, q);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	if (packets)
@@ -2470,10 +2470,10 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	u16 queue_index = skb_get_queue_mapping(skb);
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue = &bp->queues[queue_index];
+	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
+	struct macb_queue *queue = &bp->queues[q];
 	unsigned int hdrlen;
 	unsigned long flags;
 	bool is_lso;
@@ -2512,8 +2512,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
 	netdev_vdbg(bp->netdev,
-		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
-		    queue_index, skb->len, skb->head, skb->data,
+		    "start_xmit: queue %u len %u head %p data %p tail %p end %p\n",
+		    q, skb->len, skb->head, skb->data,
 		    skb_tail_pointer(skb), skb_end_pointer(skb));
 	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
 		       skb->data, 16, true);
@@ -2539,7 +2539,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
 		       bp->tx_ring_size) < desc_cnt) {
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
 			   queue->tx_head, queue->tx_tail);
 		ret = NETDEV_TX_BUSY;
@@ -2555,7 +2555,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
-	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
 			     skb->len);
 
 	spin_lock(&bp->lock);
@@ -2564,7 +2564,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 
 unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

-- 
2.55.0

