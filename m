Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05151D523
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793347; cv=none; b=jtV8ldVIfx9/9sZOBVJ8T5+D4kp1iPzBfztIIgXMAwa+bC26o1d7+f0iT1x8Q1EjLmBthmIAEZ+LUeVn1vfKQcgVZwJvZddis0sPh/hRjU3CMlBZOY0u6IyxYjKciFMvZpsoxSmx5/tCQajSowL78bsrlFxwqg5532AHgjotFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793347; c=relaxed/simple;
	bh=Wez9srevnIfC8Rd+n2hLAGeZbyMP2VL+aHaODO0xoeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qjEoOQlBBgtuBAik/0/BE7XqeSGpQNxXbaRZqAWUZta/CGjy45xt1IKYhRXU+4NXt6wdzKGMarzDXyuX+Vqk8SHseETwCx1T6Qs7cIJ5KyzvDgXeuJGE4QYFBiwsnpoY8UxVdokLFNvVSjwP0iwlPM5TB3Ouo/MxXT0t6O0T1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cljvbv1m; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cljvbv1m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C2AF74E410CF;
	Wed, 30 Sep 2026 18:35:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95E7960749;
	Wed, 30 Sep 2026 18:35:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6995103286B1;
	Wed, 30 Sep 2026 20:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790793341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gpYfjJVVvP/BO4iGCfqY670W67tEKCw8EcdA/x14eN4=;
	b=cljvbv1mvSw8lBQBLKnUAA1p/aLGR9Fs3to25dWU657BqG7yqPHBOcDXTmHF7Pi2/VlCMS
	opNpJa1WJCMfz+7jB38TM+5M9ylNGPK7d6hab3OaOSDP/aQI8jnAmLoyl43iq50DGqhQ9a
	/x2bUqslZhMADAh+nxOWKMhQ4bd4qCYXmuitWl5zKqyHpY4ex7OHkm4EhHb/QXPrA9VOH0
	yuDAdNfhgrOcVDFhzjPwRf7HcOVoDFzx1txmqfGZGKmXln0CYkyMJHdoEoSIZQLadazwBf
	HaFxHYA6JKUhRoVHIYhtaA+e8BbwJkRSUzLfYFwLtPQcblZe7g2ktdPrl08kMQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 30 Sep 2026 20:35:36 +0200
Subject: [PATCH net-next] net: macb: move printk() calls out of bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHdWvWoC/yWMQQ6CMBQFr0Le2p+UgoBehbho61c/CVXaSkhI7
 27V5WQmsyNyEI44VzsCrxLl6QvUhwruYfydSa6FoZXu1KlRNBtnScJCZui7Y1MP2rQ9Sv4KfJP
 ttxrhOZHnLeHyN/FtJ3bpe0LOH3cBcZl2AAAA
X-Change-ID: 20260930-macb-irq-a87653182a47
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev
X-Last-TLS-Session-Version: TLSv1.3

printk() call while bp->lock is acquired might be a bad idea:

 - It grows the spinlock atomic section.

 - If netconsole is active on the same interface (and we run on the
   queue's CPU), we risk a deadlock because macb_poll_controller()
   calls macb_interrupt() which grab bp->lock if an IRQ is pending.

Three messages are changed:

 - In macb_tx_error_task(), defer netdev_err("halt tx timed out") call
   to after the critical section. Update the message to highlight it
   occurred in the past. Inherit the buffer exhaustion boolean variable
   name from the old code comment.

 - In macb_tx_error_task(), defer the netdev_err("TX buffers exhausted
   mid-frame") call out of the loop. This also means it goes from
   1-per-error to 1-per-task-invocation.

 - In IRQ handling, move HRESP error printing out of
   macb_interrupt_misc() into macb_interrupt(). Again, it means we
   dedup error reporting if status is read multiple times in a row with
   HRESP bit set. This is fine as from past instances I've seen, this
   message spams our log if it occurs.

Notice we *ignore* debug printks; if you are debugging MACB maybe don't
use netconsole...

The netconsole deadlock is theoretical & never reproduced.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
This patch used to be part of context swapping V9.
It got moved out as there aren't any dependency or relationship.

Technically it is a fix, in practice I'm happy for it to go through
net-next/main for more testing and it is a theoretical bugfix (as usual
nowadays). Decided after seeing Jakub taking a similar patch into
net-next this morning:

> Since Linus is pushing back on our number of Fixes let's go for
> net-next with similar fixes until the merge window
https://lore.kernel.org/netdev/20260929184531.36ac3dc3@kernel.org/

Changes since context swapping v9:
- Rebase onto latest net-next/main (47a144672573).
- Send patch standalone.
- Simplify the commit message (it was a long and partially wrong
  rambling before). Also mention that it is a theoretical bugfix.
- Link to v9: https://patch.msgid.link/20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com
---
 drivers/net/ethernet/cadence/macb_main.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 20fe30789834..6725f8ac7606 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1282,6 +1282,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_tx_skb *tx_skb;
 	struct macb_dma_desc *desc;
 	bool halt_timeout = false;
+	bool buggy_driver = false;
 	struct sk_buff *skb;
 	unsigned long flags;
 	unsigned int tail;
@@ -1308,7 +1309,6 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * macb/gem must be halted to write TBQP register
 	 */
 	if (macb_halt_tx(bp)) {
-		netdev_err(bp->netdev, "BUG: halt tx timed out\n");
 		macb_writel(bp, NCR, macb_readl(bp, NCR) & (~MACB_BIT(TE)));
 		halt_timeout = true;
 	}
@@ -1353,8 +1353,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 * those. Statistics are updated by hardware.
 			 */
 			if (ctrl & MACB_BIT(TX_BUF_EXHAUSTED))
-				netdev_err(bp->netdev,
-					   "BUG: TX buffers exhausted mid-frame\n");
+				buggy_driver = true;
 
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
@@ -1391,7 +1390,14 @@ static void macb_tx_error_task(struct work_struct *work)
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
 	spin_unlock_irqrestore(&bp->lock, flags);
+
 	napi_enable(&queue->napi_tx);
+
+	if (halt_timeout)
+		netdev_err(bp->netdev, "BUG: halt tx timed out, we ignored it\n");
+
+	if (buggy_driver)
+		netdev_err(bp->netdev, "BUG: TX buffers exhausted mid-frame\n");
 }
 
 static bool ptp_one_step_sync(struct sk_buff *skb)
@@ -2143,11 +2149,8 @@ static void gem_wol_interrupt(struct macb_queue *queue, u32 status)
 static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 {
 	struct macb *bp = queue->bp;
-	struct net_device *netdev;
 	u32 ctrl;
 
-	netdev = bp->netdev;
-
 	if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
 		queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
 		schedule_work(&queue->tx_error_task);
@@ -2187,7 +2190,6 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 
 	if (status & MACB_BIT(HRESP)) {
 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
@@ -2207,6 +2209,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
 	struct net_device *netdev = bp->netdev;
+	bool hresp_err = false;
 	u32 status;
 
 	status = queue_readl(queue, ISR);
@@ -2253,15 +2256,22 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			napi_schedule_irqoff(&queue->napi_tx);
 		}
 
-		if (unlikely(status & MACB_INT_MISC_FLAGS))
+		if (unlikely(status & MACB_INT_MISC_FLAGS)) {
 			if (macb_interrupt_misc(queue, status))
 				break;
 
+			if (status & MACB_BIT(HRESP))
+				hresp_err = true;
+		}
+
 		status = queue_readl(queue, ISR);
 	}
 
 	spin_unlock(&bp->lock);
 
+	if (hresp_err)
+		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
+
 	return IRQ_HANDLED;
 }
 

---
base-commit: 068b5854d6cf588826bd876172652e7c1469d4e6
change-id: 20260930-macb-irq-a87653182a47

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

