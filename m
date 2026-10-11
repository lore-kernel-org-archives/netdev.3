Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672903254BB
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741989; cv=none; b=SXIepmydwm3YZckXAdTCx/gF3Y6+JbpxBxkV3KQCY9Y+5x2/QOACqGkojmcRcF7WsjINrCaSD00yZis4I1wLuWimQOnjp0tDgq47x7W2G4dPfYGWtsK6gKBg4KkjqYvtXR52CaXs3SaI03hndYBpmDXYK5zjR7c1FKYYfa1l+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741989; c=relaxed/simple;
	bh=MBj4X8ueXy3PAt/2wPRCtpW8I9cLsUbd9Ra6G1FAJcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgVIK56ETO2KjkvUs7SlE/OkgN+3BevEyArR5YJQKzh0qPs0Wn0UBf6O6CmVfc2ckOFa8LPxHkjFJSV22HcVnT0b+wEKxR/dt4B5tJsMkmmZOIuxR3mBtb7/nG7qk+tyx78LU8z86k6GtehhFhZFkzinWQ+Hn0KNvGGADVoaVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzE1Uk0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzE1Uk0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A87E1F0089C;
	Sun, 11 Oct 2026 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791741988;
	bh=WcbS1uk5b+eqFzw3QJd07frBZvh/KXF3/tFZC/3N1mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UzE1Uk0uUEqeWWns9m4AH43M1CJ97y9DZ9NZhVGRDl/HZenFE/R5tkXHGZZNm4I+F
	 4FVxjIlealvi5Ik45L9TnNp0LDcdlRg+nQOqKaBiS3CW08O510Nk9JjBbV9htqKfxy
	 qvHHJq7eVUx7S0dDyLhyf6uIXxOLNjTdfcDfompxK1Rd01jTqc71X4KSVk+qYV98Nm
	 mNbyC0SpFxHGDM0+jQr+3xm9f86LuqBjgiqluauD8Xxu79T9pD352DgZWXI6X/2hu9
	 R9R/Oka1Aj9kYx0Iy5mSmchWSLOBRc5sPvVrj7Jm6Z/x3p3uzgf0cGQhnTlFaqUPGk
	 M4hrcPizTbMAA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:16 +0200
Subject: [PATCH net-next v4 03/15] net: ethernet: cortina: Drain free queue
 IRQ before resize
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-3-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
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
 drivers/net/ethernet/cortina/gemini.c | 59 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index ec2e47688337..c03541deed49 100644
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
@@ -1084,16 +1101,11 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	new_order = min(15, ilog2(new_size - 1) + 1);
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (geth->freeq_order == new_order)
+	if (geth->freeq_ring && geth->freeq_order == new_order)
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
 
@@ -2470,10 +2481,6 @@ static void gemini_ethernet_init(struct gemini_ethernet *geth)
 	writel(0, geth->base + GLOBAL_HWFQ_RWPTR_REG);
 
 	geth->freeq_frag_order = DEFAULT_RX_BUF_ORDER;
-	/* This makes the queue resize on probe() so that we
-	 * set up and enable the queue IRQ. FIXME: fragile.
-	 */
-	geth->freeq_order = 1;
 	geth->initialized = true;
 }
 

-- 
2.56.0

