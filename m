Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAF476CDD;
	Fri, 31 Jul 2026 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515719; cv=none; b=nKauVaJ1VD6GlsFE6UW6+UaDHK98CNx1eZaNB0r8ByeroPvx+N5XoKDu8qBx4bEAc7NUh+Q0LiN2UnWe4KsaEwhLeM4KuV81HAzSeg4t3FmLkhYy8Bj24iMKXwLvswSwBpT/L9pmaFImTGePN43yqcT66an/IEq9xVwlv38kt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515719; c=relaxed/simple;
	bh=oV6qfXsCyO9ry6zLDKoBCLrtDzf85MqkrXJYQO/abRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLoqr9I/WWrjkTq9EdgcdA3ahQO/5dEiqtWO4/MFCqREX4o+9V/+NJ0tLKCkHWKZ2BNb46zKxHWx5RZVc+2KK3/bPw1J+EaQ/ftd/rJa6tryRFGAAmIH057eJ8e2NBFXDRSXPr4oU8HJDh2rTrU9vb3f8zzHF4PXE1v7jcQat74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CeKt4jb9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CeKt4jb9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 692884E41057;
	Fri, 31 Jul 2026 16:35:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37FC26039A;
	Fri, 31 Jul 2026 16:35:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57C2E11C16AE7;
	Fri, 31 Jul 2026 18:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785515714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9l7RfnuRZxCQVx+X5JnMWSMpZf5x/lKe/lib33f1FDg=;
	b=CeKt4jb92f90Hvzd8HEI0xVbMrjfYJ3xjlgT3AmOnWG0T04f1jBXs2IDz5d0WOfl1aei0k
	cLL7vg7IfUW4VKo6b2poYAh/wgna0AD4N9MIGlEFeWS161c6IAKbD+M+X3VPXln4O/T+cZ
	mkMvVR+HLpqbroFJAQp9Tl+2JbwJ/w4JN61ufx+HnNbL46vnG80ucMgXxA2b+UE+Og/tHd
	5nC3YClN8J8CqVgg7IZPyZDhLAjMyS9rxqfY8kLmJ41LYshfKaiYRBHGFmh7u+VcPbem6k
	LbndOYryyMsfG0mzIYTjmRen8Pd8goLT1HS/x7SCLoNDDAbKplFj8FRn2lMy6A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 31 Jul 2026 18:34:23 +0200
Subject: [PATCH net-next v6 13/16] net: macb: move printk() calls out of
 bp->lock critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-macb-context-v6-13-49d5a1439d48@bootlin.com>
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

printk() while bp->lock is acquired is dangerous if netconsole is active
on the interface. In that setup, we might land in macb_poll_controller()
-> macb_interrupt() -> spin_lock(&bp->lock) but bp->lock is already
acquired.

This is not an issue currently because macb_interrupt() first checks IRQ
status, potentially early returns, then grabs lock. This early exit is
expected in netpoll scenario.

However if we came to reading the status inside the bp->lock critical
section (as it should be to avoid races), then this would turn into a
deadlock. And we will.

Solution: move printk() calls out of the critical section, to ensure we
can never netpoll under bp->lock's reign. Added benefit is a smaller
and simpler atomic section.

Defer the netdev_err() calls to after the section. Update the timeout
message to highlight it occurred in the past. Inherit the buffer
exhaustion boolean variable name from the old code comment.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 987fafb2bf40..65d5ff8a5e23 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1303,6 +1303,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_tx_skb *tx_skb;
 	struct macb_dma_desc *desc;
 	bool halt_timeout = false;
+	bool buggy_driver = false;
 	struct sk_buff *skb;
 	unsigned long flags;
 	unsigned int tail;
@@ -1329,7 +1330,6 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * macb/gem must be halted to write TBQP register
 	 */
 	if (macb_halt_tx(bp)) {
-		netdev_err(bp->netdev, "BUG: halt tx timed out\n");
 		macb_writel(bp, NCR, macb_readl(bp, NCR) & (~MACB_BIT(TE)));
 		halt_timeout = true;
 	}
@@ -1358,9 +1358,6 @@ static void macb_tx_error_task(struct work_struct *work)
 			 * since it's the only one written back by the hardware
 			 */
 			if (!(ctrl & MACB_BIT(TX_BUF_EXHAUSTED))) {
-				netdev_vdbg(bp->netdev, "txerr skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(ctx, tail),
-					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
 				packets++;
@@ -1374,8 +1371,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 * those. Statistics are updated by hardware.
 			 */
 			if (ctrl & MACB_BIT(TX_BUF_EXHAUSTED))
-				netdev_err(bp->netdev,
-					   "BUG: TX buffers exhausted mid-frame\n");
+				buggy_driver = true;
 
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
@@ -1412,6 +1408,13 @@ static void macb_tx_error_task(struct work_struct *work)
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
 	spin_unlock_irqrestore(&bp->lock, flags);
+
+	if (halt_timeout)
+		netdev_err(bp->netdev, "BUG: halt tx timed out, we ignored it\n");
+
+	if (buggy_driver)
+		netdev_err(bp->netdev, "BUG: TX buffers exhausted mid-frame\n");
+
 	napi_enable(&queue->napi_tx);
 }
 

-- 
2.55.0

