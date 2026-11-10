Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348807;
	b=Ffl1Hf4FFdEwmX9X+pNp0D/nD7GBz4tDFyPDvRsg4osYENUtOqaTGFhCIJWCcg/CblSb
	 IW3lYxZcjNnzBlDrWTVcTKG0B2wgwp+waRBS4ePAynjj/qhjfovZuUG1CIu1mVk1VBM/w
	 MPGIQu2tFzRkguyXxf5/d0GzCU2a4+UOK2IASz/mITrot+dMw/Gqes+CgI2cNMdhcT34q
	 DeaDGFJG6Wi86t83VZ4Ue0BJKcI4xnQ3ZFTeOo280qzjpq+aBNY98L2OQZUEDmkTyKNI0
	 DPKLon0KCpQbVkY6RCSGO8uX5+beUHB4AxzLegB4Hf5MiTzb1eO9QhG2+/xlAbm2yCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348807;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=M2hUWOgCedLe37XpMNsh1vER96Y5dhQC8IWrrxybGBw=;
	b=UjRqaFWmAjgHPok01yOXs2Owz3Mijd2D/J1BzESnHrLXKcO3dDHeS4RRgy5EaU/2rmXz
	 Q/r3xR5OqRE7fneQWCoY2TW2fr95zn81vwZTgfCTCBo3LUbtDnBrhiJzvdCik+eDyh2PD
	 aYMkP+yr58+ykWlIOQG/lOj9LEzpp7GX5wo0peIgglhSB5mbCs5lRWsnvShMboP5pOh6X
	 COWt7E13s9Gn+mKUbyyOut3GFQayhShoG+zobRdfuvNJNenTVSpzOm5OIoHQeVkqCPHdk
	 m74RrevHzUfPkPmADB7+2onqnrnyLzG6Y6CC0XmrKkVsqad+EgHWyolr8LM6FxdMZ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TywxIp1k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5484606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TywxIp1k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354B11F008A1;
	Tue, 10 Nov 2026 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348806;
	bh=M2hUWOgCedLe37XpMNsh1vER96Y5dhQC8IWrrxybGBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TywxIp1ka5dxqo0HSSuOLAFO1H7E6Mz5er+BVGxhPyz2mmKMWc6FL+AniT9F8WC5x
	 3oP91Pk6262lPstw7WnebMUluj2BzWaWwWuOI+q29ZtGJBbWYFCUyMnBEFdcAMhKHr
	 wD94rko6475CGBZtdrzSRwQjSrun4bflPcoRl6SmLoPk6g2TDHvc0DB539uJAZHa9w
	 eR1iED6P/ZcFpOGaX48wnm6No8ea9tAJTxQDuxJkrARwLMmHonaDkcTEHV8RLS/x9h
	 X1b3x4uZE6VoV6b3kdDzFpFQObKiI/VajYVck4RsjDKKO/kAoGtSppvoKYMxLwBeCM
	 i8RyqWI8ItpbA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:16 +0100
Subject: [PATCH net-next v7 01/18] net: ethernet: cortina: Keep shared free
 queue parent-owned
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-1-9c32a1a46aec@kernel.org>
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

The software free queue is shared by both Ethernet ports, but teardown is
not ordered around that ownership. On parent unbind or module unload, the
parent remove callback runs before devres depopulates the child devices. It
therefore destroys the queue while both child netdevs are still registered
and can be doing DMA. Devres then removes each child, and both child remove
callbacks destroy the same queue again, resulting in up to three cleanup
attempts.

Removal before the first interface has been opened is broken as well. The
shared block initialization assigns a nonzero queue order, but allocation
is deferred until open. Cleanup consequently derives a nonzero page count
and dereferences the NULL queue ring.

Depopulate both port devices before cleaning up the queue, and perform that
cleanup only from the parent. Disable the free-queue interrupt after the
managed handlers have drained, since its threaded handler can re-enable it.
Guard cleanup for paths where no queue was allocated.

Hold parent-managed enables on the port clocks across child removal, IRQ
draining and shared queue cleanup, so teardown never relies on clocks
already released by the children.

Port 1 owns the shared refill interrupt, so prevent the children from being
unbound independently. Unregister each netdev before detaching its PHY so
ndo_stop can still access netdev->phydev.

Reported-by: Myeonghun Pak <mhun512@gmail.com>
Closes: https://lore.kernel.org/netdev/20260917192835.58126-1-mhun512@gmail.com/
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 40 +++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2fe7fd0202d2..0b05a1552983 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1004,6 +1004,9 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	unsigned int pages = len >> fpp_order;
 	unsigned int pn;
 
+	if (!geth->freeq_ring)
+		return;
+
 	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
@@ -2387,11 +2390,10 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 static void gemini_port_remove(struct gemini_ethernet_port *port)
 {
 	if (port->netdev) {
-		phy_disconnect(port->netdev->phydev);
 		unregister_netdev(port->netdev);
+		phy_disconnect(port->netdev->phydev);
 	}
 	clk_disable_unprepare(port->pclk);
-	geth_cleanup_freeq(port->geth);
 }
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
@@ -2635,17 +2637,25 @@ static struct platform_driver gemini_ethernet_port_driver = {
 	.driver = {
 		.name = "gemini-ethernet-port",
 		.of_match_table = gemini_ethernet_port_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = gemini_ethernet_port_probe,
 	.remove = gemini_ethernet_port_remove,
 };
 
+static void gemini_ethernet_disable_clk(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int gemini_ethernet_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct gemini_ethernet *geth;
 	unsigned int retry = 5;
+	unsigned int clocks = 0;
 	u32 val;
+	int ret;
 
 	/* Global registers */
 	geth = devm_kzalloc(dev, sizeof(*geth), GFP_KERNEL);
@@ -2656,6 +2666,30 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 		return PTR_ERR(geth->base);
 	geth->dev = dev;
 
+	/* Keep both port clocks enabled until the shared queue is torn down. */
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
+		struct clk *clk;
+
+		if (!of_device_is_compatible(child, "cortina,gemini-ethernet-port"))
+			continue;
+
+		clk = devm_get_clk_from_child(dev, child, "PCLK");
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "failed to get port clock\n");
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(dev, gemini_ethernet_disable_clk,
+					       clk);
+		if (ret)
+			return ret;
+		clocks++;
+	}
+	if (!clocks)
+		return -ENODEV;
+
 	/* Wait for ports to stabilize */
 	do {
 		udelay(2);
@@ -2683,6 +2717,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
+	devm_of_platform_depopulate(&pdev->dev);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	geth_cleanup_freeq(geth);
 	geth->initialized = false;
 }

-- 
2.56.0

