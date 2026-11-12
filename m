Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490229;
	b=uhUxaYeFjXs9FZNrWbTilZGaqduefE515H2T6Ad9xDv3dVswApsTdBViYMh8nwjDFoCk
	 Jg1XWrgR0AOSoVbTsdnGPL0J089imoFS7XoBoEdqvd5+XaNCTfX+7IzKMq8bYNI8HsLgz
	 gEIL6QjmgoN7Ctn3PoWZhSuNmftEZRA5zZDUMScHtFcS3CUvgwMKu+owMq97zLsPQStJQ
	 Ew73Vw9ccVwLUYZMtBX+5coIEL7zTjuievlT2hybYegDfFyyYhhp2anoQYK55NX+6waYf
	 /C3Jt45jmuyVSmDAysazCOcUfFLxwPp4H2vYEput/5ukIMfV4BNBFWmASkzLWmHaiTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490229;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=eNqE6RcfEf9VaUOUzWHMvysPGcdtSKHsy5HVgIcD250=;
	b=ZQCmFn07ueRp07QlfkCnlM8qaNfCEk+01Bxa6USA6pg46llP/XSoe0Th2W8rFh4WZ7Qr
	 TTqeqnkfWiidc8ymslK3OtzLBPt/tocq2Z0EvPlszx8LC4T6ssMsgVDkC0QHnNust9C0T
	 xJWxVHttY8160DvG2BuBPIpZrbemJ+XugLarWaXASEbqBC4jCVEbyNy9OuZtzBgLKmo+i
	 Xm4h5a7MHtfXAVhnBZ+0kKGZBSmCo9ne8sMWvSUnpSYALsYjoQSALyGQA9yq/APm9SQtX
	 I7NCveU8GEHQ2fgGKuNXIcDmM1xh6N4Ew/N7G2pm3nKDwpaWlVZ03CWY+4U8HvZ1aww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JX7CBHoW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7D606A339
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JX7CBHoW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E131F00A05;
	Thu, 12 Nov 2026 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490229;
	bh=eNqE6RcfEf9VaUOUzWHMvysPGcdtSKHsy5HVgIcD250=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JX7CBHoWloTfbiEGHR/mcr8SyDnRywmW/r6XhFlkaIOwan4vgTRpY01AkG6NnzVxo
	 0DAMu4r49vtPWC8N6SjLKrJxubjrA8PHfrYf8KD3WyZiN0lXBQrXghK7ZfgtvBFp5Z
	 n05dweo7LcBMpwbg4PUCyFUT2aRjN0XQelkHJhaIn/fTVpRn8YZTWmKKoD6DnKam2I
	 51CMculDCkqBMKCO8ZbC8bLs4VTUSFcRHX5pHSmLpWsFbwbCj9p3AvflX6LoR3weGG
	 35vFjLOJcwJRvGCrn4rK6OpuPXRTQC3xZyOu+61kIeqlQ5/cKKusm53WD9KmYTZkTU
	 vp4B/RHoKwBrw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:18 +0100
Subject: [PATCH net-next v8 03/19] net: ethernet: cortina: Drain free queue
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-3-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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
index 1b959ca853c6..5eade1394a56 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1019,6 +1019,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	}
 
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1059,20 +1061,37 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
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
@@ -1082,8 +1101,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
 	unsigned int new_order;
-	unsigned long flags;
-	u32 en;
 	int ret;
 
 	ASSERT_RTNL();
@@ -1120,13 +1137,8 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
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
@@ -1136,14 +1148,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
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
@@ -2406,6 +2414,9 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	u32 val, en;
 
+	if (!port->id)
+		return IRQ_NONE;
+
 	geth = port->geth;
 	spin_lock(&geth->irq_lock);
 

-- 
2.56.0

