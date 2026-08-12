Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF563B9922;
	Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521860; cv=none; b=ufXhx81a6SwBXEPadnFbIHRXojJ6gekt705/FShnc8qCl0tMzcC+FiHE44VozLxpFxJdLCoLBNclrlsXVT4lSCMdosSANJQ9Mrjyw+Feb9cHPnpne+pgiTIcxOWLil38tqI/gTkpDsy2imwShjyAYqEtgSuJlgDjqt9/8vKnpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521860; c=relaxed/simple;
	bh=aqb5wzUnjQiE92vTQG6HskaW9vJagCtBpTvw3msDOHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkHEvjeoRuPMlVRH1mRBgBpixUQV4mFKl+C4mFnbfalveqcGNMOIpkXwrZeHTTEBobEOnj2zw8e4PmFm+j8ON7xv3f/zqo4WTFvX/dPLvqClQAS9wJnKRKLkaDpFp3RsQkaMiHjtemvTjRlGfSf+rmayE7cXB034SIwTA8oQ1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CeNMOylA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CeNMOylA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C43D71A15AE;
	Wed, 12 Aug 2026 08:04:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91E076045E;
	Wed, 12 Aug 2026 08:04:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03FA911C4C946;
	Wed, 12 Aug 2026 10:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521856; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0ZUucWJM0ugD0v7uyorCqPnZmrLP4lvxGxWS5J58lyY=;
	b=CeNMOylAcxF+s2VJGsuXoVeRa+AVD8PgPb6wRRH+Iwz7opSQPWBPkv0lywBPpDT3ha9KKr
	4VqBU0sjzeX78q+evs9/MzJORE2sy7jnDe4sh2vr6iDg7XA1KupIpTqXKOUv9JF7GVxP0q
	+ithCuA9e+NgPW51JKqBQgqzkAQnvfpPcWLvY08alN8AbHQ4mQW9b6z+ihbSDxSedituY7
	975jQ5dY9WfkTQwHRYPbQRZcUOtRnmRYKqZLvUT/9vvcjtGjnhJ3htddpNjta3htfnrRnY
	2UHhnMFwf9BfeL7D27ri/7qibyeElCoeF1klpmDivNYSrTddMWWZ+TleGWLLAg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 12 Aug 2026 10:03:28 +0200
Subject: [PATCH net-next v9 14/17] net: macb: move printk() calls out of
 bp->lock critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-macb-context-v9-14-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
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

--

In macb_tx_error_task(), defer netdev_err("halt tx timed out") call to
after the critical section. Update the message to highlight it occurred
in the past. Inherit the buffer exhaustion boolean variable name from
the old code comment.

In macb_tx_error_task(), defer the netdev_err("TX buffers exhausted
mid-frame") call out of the loop. This also means it goes from
1-per-error to 1-per-task-invocation.

In IRQ handling, move HRESP error printing out of macb_interrupt_misc()
into macb_interrupt(). Again, it means we dedup error reporting if
status is read multiple times in a row with HRESP bit set. This is fine
as from past instances I've seen, this message spams our log if it
occurs.

Notice we *ignore* debug printks; if you are debugging MACB maybe don't
use netconsole...

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5a4eb87f5a97..d23a0d08c276 100644
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
@@ -1374,8 +1374,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 * those. Statistics are updated by hardware.
 			 */
 			if (ctrl & MACB_BIT(TX_BUF_EXHAUSTED))
-				netdev_err(bp->netdev,
-					   "BUG: TX buffers exhausted mid-frame\n");
+				buggy_driver = true;
 
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
@@ -1412,7 +1411,14 @@ static void macb_tx_error_task(struct work_struct *work)
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
@@ -2121,11 +2127,8 @@ static void gem_wol_interrupt(struct macb_queue *queue, u32 status)
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
@@ -2165,7 +2168,6 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 
 	if (status & MACB_BIT(HRESP)) {
 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
@@ -2185,6 +2187,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
 	struct net_device *netdev = bp->netdev;
+	bool hresp_err = false;
 	u32 status;
 
 	status = queue_readl(queue, ISR);
@@ -2231,15 +2234,22 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
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
 

-- 
2.55.0

