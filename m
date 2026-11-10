Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348812;
	b=IvJ5U+L+hQB4GuHm3UqZernDyDK/2RJTNdJ77LcEYJ/FaxoMAhC4rP6O22OWb0tJD/mw
	 8MmVtRNTg3hFTupVws8wyi1tf5rIMSnMZkmwbFb46FMFHPfiP5Vqm/Ri+zsB52VQq1cy2
	 xneP1eQaZstF66Gomm/Y63NHZU8XDjavk1PdPiYA6yR4MEXx01jV+mZhG1xi4L1n9NIm/
	 y4imJJLyXQkh9jp4X9yNAy91soJMsTJBfBXPf/4sFlKFReGqTaP5msxgedScwEATPBPC9
	 zTNeuC9WkttN7yF8d2Xph7SMJaYfIF5P5v52z8EoX+OktNjx+Aw6VeZz91bf0XGik6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348812;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=G8cc9J2sxDWo9Zsqxguvn+a4C74xpBHzsbSRSUmnwEU=;
	b=rUn7HYQrfJ07nDHTbAAEVbYCUeY8Z3oaeNMDfTFxjCjMEX2QEnYwHJTYtnxiy+llr7h1
	 dezJD9Jzovbw8JhwKg9m1M3iRsEXgN7apPqbYkTDRkXO21RUN4B2CpGG+ICJ5KCI2xGQJ
	 Le1aenQ8p77pE+iQj6Ly6+8kMblhl3uG1zh+6ZmpZXKWQoz+phqZWrmokI/+MZCcDMwAK
	 TdyAPIj59By3oq3kj7fr7/v/xoSJFTAcLz84Cdy+Fsc9Uh6VIaL4uf0LNY5t8a8lWVlHI
	 B50MiutBnWII5Ku5/s4EjjX8NyB8oQdSgm42sTtXjcmzP0qt/22lRkn6NdJoTTHGmQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXO14woo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48160A2600
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXO14woo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88A11F008A3;
	Tue, 10 Nov 2026 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348812;
	bh=G8cc9J2sxDWo9Zsqxguvn+a4C74xpBHzsbSRSUmnwEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JXO14woogfaWDDQ2nwiFhvmPdnnIFoNMKVj2USbwxH5acQvOtPT7beweoxJyzxI4T
	 6mf6WhfxErMZLzQH8SZtpkTdvfwXcwYQjX/As0RJ3tnFsqX3P9Gim5JJKKQ+wwvuwI
	 r5XoJWisYvF9keGrVEZK6CkADC7+HlMvd5zoBH4RkS85H9vPAzuHM60lixDhgpHyEZ
	 2tB+nMPFzSAq0yaVAxQ1pj8AEu7htd2/w28crywzQsetjJvfXwtg7yzZKc/Tmt6/pZ
	 EJLqQaJCVFKDG5J3k9ldjhRpkrH2gTppIVLLCa0zxHD87C4WE1+Xvg/7QWfi1wcNPO
	 oJelMdGNJZ9Hg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:18 +0100
Subject: [PATCH net-next v7 03/18] net: ethernet: cortina: Drain free queue
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-3-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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
index 22c3b6b8e2db..5fdbe987dc97 100644
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

