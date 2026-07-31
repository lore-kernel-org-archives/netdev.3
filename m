Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6A47140E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515695; cv=none; b=MQux8xpyPXrqWY730HOmRBzrVTINxvQ0Ll0jCq5ch+5vPQs4iJ83XeIEqMx1++8d+8NiDMutoVT/ItSP7oJnBd3lCdVysGV/vRU75LqLM8F3/jpHPJ0RvjvwRY0g6oS9Fjd/661qeIHOUhy0iCk90gxsA4X56mp/xV/ya/0Cylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515695; c=relaxed/simple;
	bh=ytHMJk9uwCI3Ih/lKU3WQYtNXzXOFq1u52qIS/DZ99I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnQJ58jtMTiPXDD15nnD5yTxGFrj1j9SzctaWi/qR88bPR2BFi/ESgF0MregLNRUGQlkoxRUG4C95vtyRWzzQhfTFReYDkpS1SQmOT5rUwGmst3YvqAYFxSyCNKJAdrIdrPsqlX0rq0UFljKCRecm7/76/OU7tq5jSd5aNdv0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uV0K+WIP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uV0K+WIP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 44B074E4104D;
	Fri, 31 Jul 2026 16:34:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17B966039A;
	Fri, 31 Jul 2026 16:34:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E85711C16ADF;
	Fri, 31 Jul 2026 18:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785515686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DE8wAhiqMK7RJdZQV0kChIZ2rai1PXBvdBaWg7ZuXrw=;
	b=uV0K+WIPDEV6L0e7iHS8ydvWwMOGQoU8ET34AcM4sZV+PZrJBt+N/NMbpqWVp59VKjxTPy
	iRqXgs77RC0frqqhbKZA2bGMsfnElQIWg/bUY9h5TW6BqdXOI0nsURyDzZrM8maf9jRElf
	l6He2xyt2VkGJeDLAKff985GybwwkZQBhSiUBydXbvNtg6yilbxEEzqpTSdrxF6QxSM7l7
	SkWdU5nE348dpgyKYbdUptFWFHA7f5jaA74RuUABZl09RL/U2toeRyGAVl6L2fJWEgwQ+3
	m51Bqo4tN5UT0ynyifUaQrGx/T1KX6vB9fEbSMRyElZl2NyR9AJy56Mh6mjARQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 31 Jul 2026 18:34:15 +0200
Subject: [PATCH net-next v6 05/16] net: macb: enforce reverse christmas
 tree (RCT) convention
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-macb-context-v6-5-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-0-49d5a1439d48@bootlin.com>
In-Reply-To: <20260731-macb-context-v6-0-49d5a1439d48@bootlin.com>
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

Enforce the reverse christmas tree convention in those functions:

   macb_tx_error_task()
   gem_rx_refill()
   gem_rx()
   macb_rx_frame()
   macb_init_rx_ring()
   macb_rx()
   macb_rx_pending()
   macb_start_xmit()

The goal is to minimise unrelated diff in future patches.

In macb_tx_error_task(), we fold the assignment into the declaration
statement.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 61 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 77053cb9d8f7..b138b94ea0d8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1254,20 +1254,19 @@ static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
 
 static void macb_tx_error_task(struct work_struct *work)
 {
-	struct macb_queue	*queue = container_of(work, struct macb_queue,
-						      tx_error_task);
-	bool			halt_timeout = false;
-	struct macb		*bp = queue->bp;
-	unsigned int		q;
-	u32			packets = 0;
-	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
-	struct macb_dma_desc	*desc;
-	struct sk_buff		*skb;
-	unsigned int		tail;
-	unsigned long		flags;
+	struct macb_queue *queue = container_of(work, struct macb_queue,
+						tx_error_task);
+	unsigned int q = queue - queue->bp->queues;
+	struct macb *bp = queue->bp;
+	struct macb_tx_skb *tx_skb;
+	struct macb_dma_desc *desc;
+	bool halt_timeout = false;
+	struct sk_buff *skb;
+	unsigned long flags;
+	unsigned int tail;
+	u32 packets = 0;
+	u32 bytes = 0;
 
-	q = queue - bp->queues;
 	netdev_vdbg(bp->netdev, "%s: q = %u, t = %u, h = %u\n",
 		    __func__, q, queue->tx_tail, queue->tx_head);
 
@@ -1487,11 +1486,11 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 static void gem_rx_refill(struct macb_queue *queue)
 {
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	struct sk_buff *skb;
+	unsigned int entry;
+	dma_addr_t paddr;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1584,11 +1583,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct macb *bp = queue->bp;
-	unsigned int		len;
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
-	int			count = 0;
+	struct macb_dma_desc *desc;
+	struct sk_buff *skb;
+	unsigned int entry;
+	unsigned int len;
+	int count = 0;
 
 	while (count < budget) {
 		u32 ctrl;
@@ -1675,12 +1674,12 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 			 unsigned int first_frag, unsigned int last_frag)
 {
-	unsigned int len;
-	unsigned int frag;
+	struct macb *bp = queue->bp;
+	struct macb_dma_desc *desc;
 	unsigned int offset;
 	struct sk_buff *skb;
-	struct macb_dma_desc *desc;
-	struct macb *bp = queue->bp;
+	unsigned int frag;
+	unsigned int len;
 
 	desc = macb_rx_desc(queue, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
@@ -1757,9 +1756,9 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 
 static inline void macb_init_rx_ring(struct macb_queue *queue)
 {
+	struct macb_dma_desc *desc = NULL;
 	struct macb *bp = queue->bp;
 	dma_addr_t addr;
-	struct macb_dma_desc *desc = NULL;
 	int i;
 
 	addr = queue->rx_buffers_dma;
@@ -1778,9 +1777,9 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 {
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
-	int received = 0;
-	unsigned int tail;
 	int first_frag = -1;
+	unsigned int tail;
+	int received = 0;
 
 	for (tail = queue->rx_tail; budget > 0; tail++) {
 		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
@@ -1855,8 +1854,8 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 static bool macb_rx_pending(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
-	unsigned int		entry;
-	struct macb_dma_desc	*desc;
+	struct macb_dma_desc *desc;
+	unsigned int entry;
 
 	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 	desc = macb_rx_desc(queue, entry);
@@ -2476,10 +2475,10 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
+	netdev_tx_t ret = NETDEV_TX_OK;
 	unsigned int hdrlen;
 	unsigned long flags;
 	bool is_lso;
-	netdev_tx_t ret = NETDEV_TX_OK;
 
 	if (macb_clear_csum(skb)) {
 		dev_kfree_skb_any(skb);

-- 
2.55.0

