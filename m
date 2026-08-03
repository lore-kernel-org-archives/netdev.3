Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC9426430
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787765; cv=none; b=swVuL+1gqR/DECh9OzG8c3Fd4XWKMeaOABIh1Zakb8qHLNlFXvmbjXv637C3hSKsjFnJWvx85JnGcWDgqMelwQ5EGbMtlZbp+S8Kb+BSdSiRjUTNF5nPji9WIo77HFrg8+wBLs9nx+F7PXG6M1cND8TMYox4liDri5oNX6OcIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787765; c=relaxed/simple;
	bh=X0XOVeSCMJ0zGnmM3mkxwmCQx8t3dKC47QQeHw87SSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7+tBzXX8OVkJsPxGnBvxMP4g4m4qE1CjJhd5G7IuOpi8rH+gW9JK9E8pdUe4zddRbxeabS8bwNtk2EqJf1vS0RtNdRrZBLMrTFU9UbHLBCv9aZvjADh3TMi4lg0AmJ4iD/KeGNJNMNGie6JWklc/5XU5KW3b+oV9x2rE9uv0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XHFm4Ybz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XHFm4Ybz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 045944E410AE;
	Mon,  3 Aug 2026 20:09:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C88546029B;
	Mon,  3 Aug 2026 20:09:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2265811C31859;
	Mon,  3 Aug 2026 22:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785787760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cw8EEO0Qsa3oRLdZqyNldxed778wCiK/VTi6GlHQFmw=;
	b=XHFm4YbzW0lyh4UY7lCffx44k7EwyaIyQqahvfph4wERAdtIDfi01C6GvYrEO1c1AmOlzn
	aW5FYPdw4ALy/SVnqdqWzznRCiW+jiqQln9chzhSxZO2OcG3UCVV7bwrqyDzTTnp62HutT
	CjN8p5/XwZFcGzBzvSx2ixAKqdLGtS46C5Sczw2eiLFFFEX8kUMctVg6H+5lF+dzTxmyoi
	Uh3c0mgMz+JNJ7WSSqqiqgIqyOAgGK/xF6WRK3Wh34jAyqP2K2B32k/j3jW+yWfAzHDVyT
	GOoqG2l0zaxs9kHjBa3k4pWkbBNAb32FlHj3BOWlOYasBAeGigPhaFEpebK0Hg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 03 Aug 2026 22:08:21 +0200
Subject: [PATCH net-next v7 14/17] net: macb: move printk() calls out of
 bp->lock critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-macb-context-v7-14-4d7d4af04849@bootlin.com>
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
 drivers/net/ethernet/cadence/macb_main.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5a4eb87f5a97..7e77c24da8a6 100644
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
@@ -1412,6 +1411,13 @@ static void macb_tx_error_task(struct work_struct *work)
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
 
@@ -2165,7 +2171,6 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 
 	if (status & MACB_BIT(HRESP)) {
 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
@@ -2185,6 +2190,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
 	struct net_device *netdev = bp->netdev;
+	bool hresp_err = false;
 	u32 status;
 
 	status = queue_readl(queue, ISR);
@@ -2231,15 +2237,22 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
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

