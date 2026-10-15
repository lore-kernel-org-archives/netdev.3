Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB735541E59
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077867; cv=none; b=fFL/G7cmc5jd292Zjhnss7/1eA0DYuY80nVDhKtxk0thUx0LdenRuCmI2LMo2OfDi18Bt1qr4HGD2Yn4dVBR10RrAydTiH393uUalJI4M6y4PTsmWsOQ5ZEoftJoyyel4XPtmz4p+pNfsg6R92oFdQpHIuPXjyPKQxeruT781zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077867; c=relaxed/simple;
	bh=TyDOxGxX1/U5i8ixxlja/qnq64Ra3PwGe7DWRnj3bIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDeogKnEykXj9D0NyUPgpm9SI7v2XNhI33arHtQOLpWrhr2AdybGmd+74OoMJJauYdvbd2UDCAnhS1md6BwLJFV1Nx95hPI3jBzYaFfCcb/X0HrHKZK4gJhgJzOzN0tb4DKyRh5vIHw/90O8UfOrqyotUsVCJE+rSnI3bjQ1d2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juvNet2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juvNet2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9401F000C7;
	Thu, 15 Oct 2026 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077855;
	bh=Y5y2B0QpGzYEI9ky4L5lU6nHb7u90zPiLW8yrewn2p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=juvNet2KhHBJq3oD8vLmtv9DFeUQ9i8wsixBaUQnmgZqoCp3fACHk97zcHvs4f1tN
	 hUG+dImfDftXq+m53X8kw4LgaKIAKH8CadR46DrU3IIxWQn/wMlSH8CpW8qO0dat1B
	 0VunDdHeCUPtxJ4bx6QonBHiBuWIEmBg6+lOUSQk6RzFT9G/6qV56zt8n4alyJo6SF
	 8S9KqUSorz7WHWcMzzvtSfFS8/Sxrblq3Cj9P6q/H+hsh5/SHrLV3o4Ub0pFofVGKa
	 R0l+t+zUpQ1Pw3M5h5eZ2zdE0AP5buWtq4iiBiASZ/HM3CemTCd7IC+T6j2TqO/22s
	 fdMLZUzSCYx4A==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:03 +0200
Subject: [PATCH net-next v5 03/14] net: ethernet: cortina: Drain free queue
 IRQ before resize
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-3-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
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
Assisted-by: LLM
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

