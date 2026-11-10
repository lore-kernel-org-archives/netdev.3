Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348810;
	b=EiLdz1Z4e5XEbcURqIKuJPQp02qrtRudqbqf2LIV9ygTmsmvPMcKam6cT9aQhsSG5vGB
	 LiWXfBmahNfB2xgVsUdgIrIuKHrgOVo1xJc3iGAVVLBym5SaOrDWDC1gXTIfp9HAnPBnq
	 pGPxgcGOR2RMOn7LD5A9g5eeD+h6XTpbfZdY5BzcahFuZCnn30egRBAyCVZw6+7L2eB0u
	 ZyV4dC5FReb1KFagPoZ70UBZqVBNuRxUvyd+FLqK5J19wWVFAT7rM775wxqKl+FbC2Xfm
	 EVsBTJKQCKbwOa7YnE2CSJhd8Hk5PDkHMNx8s9GiS/2sp7Vm6tJKzViagIitk5BQU4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348810;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=9IaBC6RXA0SY42F4SbdsKXij1YpIggrP7VrUWj5Ywe4=;
	b=J4m6lC//IQ8x6FVvsAXet2f19Z4s4SHl/UwmxojXh0lJWTiyRP3f07OhGqk4rvW7onPo
	 ghGiF7/hlvj1PKftiiwLL9dRH6ksLC1D55ycypBtyDmVSdPp+RMafIUaU+Z3aR24UntPX
	 JMjAKydRK83Zmw06fNreBWbPgCtWsndfJA/xUca4bnrHCfWs7/PUeG45UbeeHMn7PRMJy
	 7spExbzqhZsbM5lEEJK14XJrRs1QcSx4cpsaVefPo9JDAWoH1cfimMZNocSqfAMlCQpfI
	 7SYnC9TGhIOJolFxf+b5Wv3s1VnulfkyQzrw/7fEPgi51FhaqXMOnOnLW2lItaN4YzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyrE2iv3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE83606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyrE2iv3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F001F0089F;
	Tue, 10 Nov 2026 22:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348809;
	bh=9IaBC6RXA0SY42F4SbdsKXij1YpIggrP7VrUWj5Ywe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AyrE2iv3oGgQlXdH8B9q4Ct62iv6woFN/O12Yqz9oJ3hAaM751a/B67fZ1lQapbvr
	 akuE7Mh8osxIOv3qo7y2eLGtbui+h3n786zPEJSak81a7ZIqXwsDKgf4FcUzzX34Nd
	 KZB7qQSw6ouln01AAA3fLzyEsHLmEI3AlU/Wm94sY6A6L6rbMVWKy/u6ws6jpeyEmL
	 M8ODF5OPwwYUgHJ8HViVONTS/BZQssBwkyNzOq0iK5Z/fElTmq+AutYrfoE3Jlj8z9
	 b3Zf8Uekf3LLhdbIr4YbClxEqPoXlUrBTPEFymNtOgiy5df9NC9KbQY319flALsu5V
	 tIhSB5dfhmDjA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:17 +0100
Subject: [PATCH net-next v7 02/18] net: ethernet: cortina: Keep ports bound
 for shared IRQ
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-2-9c32a1a46aec@kernel.org>
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

The software free queue interrupt is routed through port 1 even on
boards which only connect a PHY to port 0. Since PHY setup was moved
into probe, the PHY-less port fails to bind and releases the threaded
handler needed by the shared queue.

Publishing the port before PHY setup also leaves a dangling parent pointer
when probe fails and devres frees the netdev private data. Opening the
sibling can then dereference freed memory.

Keep children bound as IRQ-only ports when no PHY is described or when PHY
setup or netdev registration fails, so an unusable interface does not
disable its sibling. Disconnect any attached PHY after registration
failure. Continue to propagate deferred-probe and mandatory resource
errors.

Publish a port to the parent only after its IRQ and optional netdev are
ready, and protect port lifetime with RTNL. Refuse shared queue setup
until both ports have completed initialization.

Keep shared hardware initialization parent-owned across individual child
removal so recreating one child cannot reset a live sibling. Mask
firmware interrupt state before child IRQ handlers are registered, and
use the allocated ring rather than an order sentinel to decide whether
the queue still needs initial setup.

Fixes: 3e813d61401a ("net: gemini: Clean up phy registration")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 126 +++++++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 0b05a1552983..22c3b6b8e2db 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
+#include <linux/rtnetlink.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
@@ -155,6 +156,7 @@ struct gemini_ethernet_port {
 struct gemini_ethernet {
 	struct device *dev;
 	void __iomem *base;
+	/* Protected by RTNL. */
 	struct gemini_ethernet_port *port0;
 	struct gemini_ethernet_port *port1;
 	bool initialized;
@@ -1051,10 +1053,17 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	u32 en;
 	int ret;
 
+	ASSERT_RTNL();
+
+	/* The software free queue interrupt is routed through port 1. */
+	if (!geth->initialized || !geth->port0 || !geth->port1)
+		return -ENODEV;
+
 	if (netdev->dev_id == 0)
-		other_netdev = geth->port1->netdev;
+		other_port = geth->port1;
 	else
-		other_netdev = geth->port0->netdev;
+		other_port = geth->port0;
+	other_netdev = other_port ? other_port->netdev : NULL;
 
 	if (other_netdev && netif_running(other_netdev))
 		return -EBUSY;
@@ -1065,7 +1074,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 		   new_size,
 		   port->rxq_order);
 	if (other_netdev) {
-		other_port = netdev_priv(other_netdev);
 		new_size += 1 << (other_port->rxq_order + 1);
 		netdev_dbg(other_netdev, "port %d size: %d order %d\n",
 			   other_netdev->dev_id,
@@ -1076,7 +1084,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	new_order = min(15, ilog2(new_size - 1) + 1);
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (geth->freeq_order == new_order)
+	if (geth->freeq_ring && geth->freeq_order == new_order)
 		return 0;
 
 	spin_lock_irqsave(&geth->irq_lock, flags);
@@ -2387,8 +2395,35 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 	return ret;
 }
 
+static void gemini_port_clear(struct gemini_ethernet_port *port)
+{
+	struct gemini_ethernet *geth = port->geth;
+
+	ASSERT_RTNL();
+
+	if (!port->id && geth->port0 == port)
+		geth->port0 = NULL;
+	else if (port->id && geth->port1 == port)
+		geth->port1 = NULL;
+	else
+		return;
+}
+
+static void gemini_ethernet_disable_irqs(struct gemini_ethernet *geth)
+{
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_1_REG);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_2_REG);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_3_REG);
+	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
+}
+
 static void gemini_port_remove(struct gemini_ethernet_port *port)
 {
+	rtnl_lock();
+	gemini_port_clear(port);
+	rtnl_unlock();
+
 	if (port->netdev) {
 		unregister_netdev(port->netdev);
 		phy_disconnect(port->netdev->phydev);
@@ -2398,19 +2433,15 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 
 static void gemini_ethernet_init(struct gemini_ethernet *geth)
 {
+	ASSERT_RTNL();
+
 	/* Only do this once both ports are online */
 	if (geth->initialized)
 		return;
-	if (geth->port0 && geth->port1)
-		geth->initialized = true;
-	else
+	if (!geth->port0 || !geth->port1)
 		return;
 
-	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
-	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_1_REG);
-	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_2_REG);
-	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_3_REG);
-	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
+	gemini_ethernet_disable_irqs(geth);
 
 	/* Interrupt config:
 	 *
@@ -2442,10 +2473,20 @@ static void gemini_ethernet_init(struct gemini_ethernet *geth)
 	writel(0, geth->base + GLOBAL_HWFQ_RWPTR_REG);
 
 	geth->freeq_frag_order = DEFAULT_RX_BUF_ORDER;
-	/* This makes the queue resize on probe() so that we
-	 * set up and enable the queue IRQ. FIXME: fragile.
-	 */
-	geth->freeq_order = 1;
+	geth->initialized = true;
+}
+
+static void gemini_port_publish(struct gemini_ethernet_port *port)
+{
+	struct gemini_ethernet *geth = port->geth;
+
+	ASSERT_RTNL();
+
+	if (!port->id)
+		geth->port0 = port;
+	else
+		geth->port1 = port;
+	gemini_ethernet_init(geth);
 }
 
 static void gemini_port_save_mac_addr(struct gemini_ethernet_port *port)
@@ -2541,15 +2582,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	reset_control_reset(port->reset);
 	usleep_range(100, 500);
 
-	/* Assign pointer in the main state container */
-	if (!id)
-		geth->port0 = port;
-	else
-		geth->port1 = port;
-
-	/* This will just be done once both ports are up and reset */
-	gemini_ethernet_init(geth);
-
 	platform_set_drvdata(pdev, port);
 
 	/* Set up and register the netdev */
@@ -2600,17 +2632,41 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	if (ret)
 		goto unprepare;
 
+	if (!of_property_present(np, "phy-handle") &&
+	    !of_phy_is_fixed_link(np)) {
+		dev_info(dev, "no PHY\n");
+		goto irq_only;
+	}
+
 	ret = gmac_setup_phy(netdev);
 	if (ret) {
-		netdev_err(netdev,
-			   "PHY init failed\n");
-		goto unprepare;
+		dev_err(dev, "PHY init failed: %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			goto unprepare;
+		goto irq_only;
 	}
 
-	ret = register_netdev(netdev);
-	if (ret)
-		goto unprepare;
+	rtnl_lock();
+	ret = register_netdevice(netdev);
+	if (!ret)
+		gemini_port_publish(port);
+	rtnl_unlock();
+	if (ret) {
+		phy_disconnect(netdev->phydev);
+		dev_err(dev, "netdev registration failed: %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			goto unprepare;
+		goto irq_only;
+	}
+
+	return 0;
 
+irq_only:
+	dev_info(dev, "keeping port for shared IRQ\n");
+	port->netdev = NULL;
+	rtnl_lock();
+	gemini_port_publish(port);
+	rtnl_unlock();
 	return 0;
 
 unprepare:
@@ -2706,6 +2762,9 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
 
+	/* Quiesce firmware state before child IRQ handlers are registered. */
+	gemini_ethernet_disable_irqs(geth);
+
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);
 
@@ -2717,10 +2776,13 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
+	rtnl_lock();
+	geth->initialized = false;
+	rtnl_unlock();
+
 	devm_of_platform_depopulate(&pdev->dev);
 	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	geth_cleanup_freeq(geth);
-	geth->initialized = false;
 }
 
 static const struct of_device_id gemini_ethernet_of_match[] = {

-- 
2.56.0

