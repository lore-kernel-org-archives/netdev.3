Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728286;
	b=PZ/vYDFY3TVIigOvoWgvcAt3utxU9fhminLF52sC4GlMY/wc0oOrcHNkXipuMNo1ffIt
	 7cJ4kw7uI/Ywp4UKEMQrM2x9ua0ooT4wQGYP0nvjUKvBvpNEqwQ8LPq+xh3RTGkSVMihl
	 yBzrchpNVmal3YggrEd+ZZSE+U4sLoEYgNHBgj8XbAfGtGbT+BPkm/B7rozf+8JC534sw
	 N5WfFc4uyc7stkcF3CfcSiHNUTnYd55uBkEQ78eUdn3sk3hnyrjSTwTZ5q2s3NtzTRbhc
	 jwjhuXMLxKCKW0QkSYQ73fLbxqDlD4PrpF6qGdFCA+p29xiO1MkHjWk/t8mj/DFVZOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728286;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sk0HzFlKhHff/S2BSJsJ/wZnzdUaYotaq8LbvBpO3eU=;
	b=iNYRtxmbl3QMmfmp05DNC5lAjk5P0AkOaV5IazaOeVnp5oWEZwADZEwav9CTVjrhMaFL
	 sFaZRR1r08GNWqohnvF1unjS1rOCyOyNHosHtwckw/0nmuRSMBkyRgnU4lZCgsnuTZP/R
	 ZG/asGEz/KW7lj1/4EwMtHBKQwaI2y1z4k0oKpk4l0x57egmT06meL5NtXdt8xxedTCWU
	 lKA8hjEi6QNGVGEpxJ2NmgdNO5Gt5wTBmSSzXqi0sF2fhEHoT83MBsFMwtzKRw3EmsvOt
	 kcq62mglvviyu94iksHpp6Znz5HM8FU5Y7WzPpT2vmS6FWZr6Cp2MmARRbqGtLaN3GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgSOwQls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E36606A334
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgSOwQls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80341F00919;
	Tue,  3 Nov 2026 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728286;
	bh=sk0HzFlKhHff/S2BSJsJ/wZnzdUaYotaq8LbvBpO3eU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AgSOwQlsnMBnlqRK5fOuKX+TH0Pv25w8dQqhxIGA3Wx+NyRtnIvNtzYnV3a7+NfNI
	 VE3kmlCP8eM/tedoTPhrol+F5SwbGBHxUb/7Q9PR6kdlgth/cG6B0UZ0rY3rAxHNs9
	 MOLjXKqEVL+qDeIprW6YQNlht6ngqn8sj1GCJUR/03QgAIrJc6nepf0EELHOCvuO5Y
	 74FwmB5szSza9kr8OdpcguGxX21+YD0jbgCS0cyZfZO61nprA5zcR7crb5rDUA8VZK
	 ip2edKbF9iXLBTlE/DrIThqIwOsOyTPvzIcjTdqFfSj19dMB9wRpBIwRKw1euKs06o
	 W45f16SN1laKQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:14 +0100
Subject: [PATCH net-next v6 03/15] net: ethernet: cortina: Drain free queue
 IRQ before resize
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-3-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The software free queue interrupt remains registered while both netdevs
are down. Merely masking the device source does not stop a threaded
handler which was already woken. That handler can refill the queue while
resize frees its ring and page metadata, or re-enable the source after
teardown.

The free queue interrupt is routed through port 1, but both port IRQs
register the global handler. Ignore the source on port 0, then disable the
port 1 Linux IRQ for the entire resize. disable_irq() drains hard and
threaded handlers and prevents a new thread from being woken.

After the drain, mask the device source and rebuild the queue. If setup
succeeds, re-enable the source before the Linux IRQ. On failure, keep the
source masked, clear freed queue state and restore the Linux IRQ so a later
open retries setup safely.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 53 +++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 79c046364292..003108270d06 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -986,6 +986,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	}
 
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1026,20 +1028,37 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	}
 
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
 			  geth->freeq_ring, geth->freeq_dma_base);
+	geth->freeq_ring = NULL;
+}
+
+static void geth_set_freeq_irq(struct gemini_ethernet *geth, bool enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&geth->irq_lock, flags);
+	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
+	if (enable)
+		val |= SWFQ_EMPTY_INT_BIT;
+	else
+		val &= ~SWFQ_EMPTY_INT_BIT;
+	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 /**
  * geth_resize_freeq() - resize the software queue depth
  * @port: the port requesting the change
  *
- * This gets called at least once during probe() so the device queue gets
- * "resized" from the hardware defaults. Since both ports/net devices share
- * the same hardware queue, some synchronization between the ports is
- * needed.
+ * This is called when a port is opened or its RX ring size changes. Since
+ * both ports/net devices share the same hardware queue, some synchronization
+ * between the ports is needed.
  */
 static int geth_resize_freeq(struct gemini_ethernet_port *port)
 {
@@ -1049,8 +1068,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
 	unsigned int new_order;
-	unsigned long flags;
-	u32 en;
 	int ret;
 
 	ASSERT_RTNL();
@@ -1087,13 +1104,8 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	if (geth->freeq_ring && geth->freeq_order == new_order)
 		return 0;
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
-
-	/* Disable the software queue IRQs */
-	en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	en &= ~SWFQ_EMPTY_INT_BIT;
-	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
+	disable_irq(geth->port1->irq);
+	geth_set_freeq_irq(geth, false);
 
 	/* Drop the old queue */
 	if (geth->freeq_ring)
@@ -1103,14 +1115,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	geth->freeq_order = new_order;
 	ret = geth_setup_freeq(geth);
 
-	/* Restart the interrupts - NOTE if this is the first resize
-	 * after probe(), this is where the interrupts get turned on
-	 * in the first place.
-	 */
-	spin_lock_irqsave(&geth->irq_lock, flags);
-	en |= SWFQ_EMPTY_INT_BIT;
-	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
+	/* Enable the queue interrupt only after successful setup. */
+	if (!ret)
+		geth_set_freeq_irq(geth, true);
+	enable_irq(geth->port1->irq);
 
 	return ret;
 }
@@ -2373,6 +2381,9 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	u32 val, en;
 
+	if (!port->id)
+		return IRQ_NONE;
+
 	geth = port->geth;
 	spin_lock(&geth->irq_lock);
 

-- 
2.56.0

