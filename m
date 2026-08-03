Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4F3ACEFE
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787732; cv=none; b=WYtnGHxoAKIwXE15ZTT8eNMMk3hnk+mO8a4hggDFVyd5A/t55Egrz99URWt2EmuCesLucbNdZTbs0pGU95BsvKe4mNsIp9T9a/txCZGBeeK7hCypU5lW5JeQ3F9kh3JkVVtvuRGGh8RDlnbbRbVT4IE+0GhSf3hvm8b01DGGed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787732; c=relaxed/simple;
	bh=mE/+OqcuvdJko4qn5pSjtmKs31qRQhXg8ht7okrYGeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sfg2uqvzQ+PHVeC+RlhVCw9GUtH11kYNHny+SLeINBiclzIzBTLp+gwRVaVSdOw0TChtij6UtYpsxcupV4NDXBcf3Rs+XKP6jIAs3BYVkcdxJdtlX/0I08PU8xPypD5H24GAVM6DuuOPiEKIolLmID5vgIwHEpZaGbdfyKMT18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kzo0HhMn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kzo0HhMn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9F9124E410AE;
	Mon,  3 Aug 2026 20:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65D416029B;
	Mon,  3 Aug 2026 20:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F74F11C31858;
	Mon,  3 Aug 2026 22:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785787723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oyLt7GIGw6qoSZHfVYJjCYzpAvJu1tNbE1mbzF/87M4=;
	b=Kzo0HhMn7/Dtgndd2afRW4kxIR6NlKFUeSQBaiwKGq39Tu9y44B/Odx+nOV61Qp1WjTzqS
	tcDWpegfvZQWN96bqgpR/Ug6MB/WTpRtBeOOnRdpD5LxMXKr/dmP8MhcDjvDfCHz4ozehB
	6GoLth2u4vvfmgStf6gbIOPs+5QxdJzIWGMOsMbIfa9f9h9wRpccWVseqS1S4VUsaMq0Jn
	bFl0NNcEkJcEPhDvyxYBE1qjtEhPzAq+DzA45/G3W6mSi0kbztMcVAiuUxSCoDvC0nh20c
	RlV5RCn0GjeJtDOWtRJuR0Af08htlNtFoNSKG+qpu76CCM+i1BSnKnl+qAfSaw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 03 Aug 2026 22:08:11 +0200
Subject: [PATCH net-next v7 04/17] net: macb: unify queue index variable
 naming convention and types
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-macb-context-v7-4-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
In-Reply-To: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
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
index e01a5e0bf481..77053cb9d8f7 100644
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
 	netdev_vdbg(bp->netdev, "%s: q = %u, t = %u, h = %u\n",
-		    __func__, queue_index, queue->tx_tail, queue->tx_head);
+		    __func__, q, queue->tx_tail, queue->tx_head);
 
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
@@ -2472,10 +2472,10 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
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
@@ -2514,8 +2514,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
 	netdev_vdbg(bp->netdev,
-		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
-		    queue_index, skb->len, skb->head, skb->data,
+		    "start_xmit: queue %u len %u head %p data %p tail %p end %p\n",
+		    q, skb->len, skb->head, skb->data,
 		    skb_tail_pointer(skb), skb_end_pointer(skb));
 	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
 		       skb->data, 16, true);
@@ -2541,7 +2541,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
 		       bp->tx_ring_size) < desc_cnt) {
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
 			   queue->tx_head, queue->tx_tail);
 		ret = NETDEV_TX_BUSY;
@@ -2557,7 +2557,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
-	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
 			     skb->len);
 
 	spin_lock(&bp->lock);
@@ -2566,7 +2566,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-		netif_stop_subqueue(netdev, queue_index);
+		netif_stop_subqueue(netdev, q);
 
 unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

-- 
2.55.0

