Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E304848B6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585447; cv=none; b=nAv0T3WoXI0DzLqcH9t9ISXyF7HJr05Mx3/+e4qJmguhZqpCPy42Dg35QP4GUW2ZxNIJPW3akGs2zTYVcCD7CFWI3JuGIm28teA4B2LQzclIXTixtdJBpSkqwP8gKVBeMmduhXMZbqOVj9wmgqj71jrP2EplMGbmAUgVzb3uGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585447; c=relaxed/simple;
	bh=TPA6GcueTmhgi2Vb/Cds5PvbdXUyfkbdVC8aRWnmlVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIb33X8cpsieP4yCaNjsPDvtEIcpPGVFbH85la6Pdglrv5sSkPlqSxJHXyjcw4WLvCwlgD06krAH7u3Ka6GFwt4+WrZzc6OY7wcOzi1408phmFGrv443idWjoCUsXRRL8396j208DBbenkOD95bbaI7KTWkjMvlUq4JVPSNAgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHo/TEsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHo/TEsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76781F000FF;
	Mon, 28 Sep 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585445;
	bh=/2K5m54GMggvDjhV9PFumCOXjESz+II3pRrB8DIIq/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZHo/TEsAqaZ86kv/yEqCjbvySbhTaicDDWEYmBe195YZAyEBXXqCTtZ7gl6acb9sU
	 n6r8qUKtDXh5Yx8y6SS7t1qVEUQa8QDQc2exJ31O0ddSGQSoeiuc5z6I0yIoLIrUaQ
	 A/dU5W5CL1NXra+53TLKOZQOX3Rl265yUEzo86QrA9bad69f+agDoDQ1wtVtQwQ6a8
	 BSafV5N6BnQjGn6r7fz7V7Iby0wewM9CTPKCgy4hkhMFCgNDpFb98EdG8LvCEmFNeY
	 fbivhbb0H9Znm410uBmg3C02mJ8zOynSdXMo3mMSIf9VEvsPNdAyad8W5TZaMQXchM
	 Df3WXPkeMSo+w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:28 +0200
Subject: [PATCH net-next v2 02/11] net: ethernet: cortina: Drain free queue
 IRQ before resize
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-2-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Masking the software free queue interrupt does not stop a threaded
handler which was already woken. That handler can refill the queue while
resize frees its ring and page metadata, then re-enable the interrupt
after teardown.

Both net devices are stopped while the shared queue is resized. Drain
the interrupt routed through port 1 after masking it, then mask it again
in case the threaded handler re-enabled it before completing.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 31bcd41c17fa..e5531e41ae9a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1030,6 +1030,21 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 			  geth->freeq_ring, geth->freeq_dma_base);
 }
 
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
+}
+
 /**
  * geth_resize_freeq() - resize the software queue depth
  * @port: the port requesting the change
@@ -1047,8 +1062,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
 	unsigned int new_order;
-	unsigned long flags;
-	u32 en;
 	int ret;
 
 	if (netdev->dev_id == 0)
@@ -1079,13 +1092,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	if (geth->freeq_order == new_order)
 		return 0;
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
-
-	/* Disable the software queue IRQs */
-	en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	en &= ~SWFQ_EMPTY_INT_BIT;
-	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
+	/* The threaded handler can already be running and re-enable the IRQ. */
+	geth_set_freeq_irq(geth, false);
+	synchronize_irq(geth->port1->irq);
+	geth_set_freeq_irq(geth, false);
 
 	/* Drop the old queue */
 	if (geth->freeq_ring)
@@ -1099,10 +1109,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	 * after probe(), this is where the interrupts get turned on
 	 * in the first place.
 	 */
-	spin_lock_irqsave(&geth->irq_lock, flags);
-	en |= SWFQ_EMPTY_INT_BIT;
-	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
+	geth_set_freeq_irq(geth, true);
 
 	return ret;
 }

-- 
2.55.0

