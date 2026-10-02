Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670B4E322A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958295; cv=none; b=aMxJ4spiHDqqE4Bzs2iQxWpTlm1XArmQzbTY1dJJ/oa/kmWOXsnL7GI0rRs/7bg1HwtOjkeUTarC4W8U5+2txNrWc9sHNHxUdXdnqr4w5NNqP9I386XOiM6b98FnoBoHIsI38SUc4G63MabBrwOwEreB/GgGNhov5KB+tJ/Sd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958295; c=relaxed/simple;
	bh=+t2QbyG4IIipiMZMebJATevNYVVDTzVYtAmFUCBc+tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXG8sDTrTRIALY09W8MX0b8J83Rq0V0xyzGwy7f39zsB79veM9sGXFKn8ARcYtdHWjyF69TlM1+Bi9s6Yy3vqfraeyItLtk/BhVoe9nTXxxuRTdgsefjJh1f8Wsx+aeyQO53Y4hCp02Q5LeZSEhF33+TnJ6zLFRYCSGYMgZtTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGgAwP5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGgAwP5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4D41F00893;
	Fri,  2 Oct 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958294;
	bh=jZ0VHw/d3Ywq26T2PGKPCnrZNzqasb61BWup9RUwCvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UGgAwP5gwcrrP97+3qJ1U6ZT1YbaO0TuiVrF/0a2UMkuRoJUrieomvuLYmHNV4LaO
	 nG3+/Al6FtG08Vx+hO+xB7FvIyLBrISjejSbYrEmmdbWGmEfr/VvcxqXlpCQhKlPKr
	 jtrAsDsRPuNJpd4dlxg5JxQWVHfPdcwezkhKN73dMKVshk7a/kNl7mSiF0nLyQIjKu
	 lMl3TlCMsQxJGMt0mfqfWaSwLo9p0sWuL4EwP/3k3vkRt6G/2Qdu/lW6LZh22VhBTd
	 xRo6qdquNSJJJnx+KYIhKw+46ooAJ6GduBKsspFsi3qcdL+Ho3UYfX1ABmvN5duDHC
	 Wc9RU7gzxkLMw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:42 +0200
Subject: [PATCH net-next v3 03/12] net: ethernet: cortina: Drain free queue
 IRQ before resize
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-3-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
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

The free queue interrupt is routed through port 1. Disable that Linux IRQ
for the entire resize. disable_irq() drains hard and threaded handlers and
prevents a new thread from being woken.

After the drain, mask the device source and rebuild the queue. If setup
succeeds, re-enable the source before the Linux IRQ. On failure, keep the
source masked, clear freed queue state and restore the Linux IRQ so a later
open retries setup safely.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 15ad9f721dd5..a2daf22e7698 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -984,6 +984,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	}
 
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1024,10 +1026,28 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
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
@@ -1047,8 +1067,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
 	unsigned int new_order;
-	unsigned long flags;
-	u32 en;
 	int ret;
 
 	/* The software free queue interrupt is routed through port 1. */
@@ -1080,16 +1098,11 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
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
@@ -1103,10 +1116,9 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	 * after probe(), this is where the interrupts get turned on
 	 * in the first place.
 	 */
-	spin_lock_irqsave(&geth->irq_lock, flags);
-	en |= SWFQ_EMPTY_INT_BIT;
-	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
+	if (!ret)
+		geth_set_freeq_irq(geth, true);
+	enable_irq(geth->port1->irq);
 
 	return ret;
 }

-- 
2.55.0

