Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490227;
	b=lojmtofnBeMIVMZr+k2hofHLt1nsRIP0e1ZWHWlUopFd1CaPuW8t1O0VoAJ6GEp7V6oD
	 hq/lWjxTmsT9+97i3AnsnkX86YoOX9BsexV7UHw8Wk8OV43LHoU8GgV7wHt3s7+VTo2HS
	 V7wXUyIiBKN5h+e1GYmv9x4y+5Ku3s/H6g2ipnYN1vrCHS0qAvdd5x+5ZfL2WSb3YGHX4
	 V09m59IMGtWtF7BeoLQbWwiB68+elp1FcolCw6yZfRV+c1WXccN0GCvIe4VQZe16OzJMR
	 9ZNZQRGvYz9EErcDhhQQzVW6p5Lr7FKSjAswsWEjoUXCT7qRsVVjnUVWxLviECsgtPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490227;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nFTrJpcSnv0f7k6O76GT0THtHkeQdq9dtFpO2Jb8aZs=;
	b=PvhYOA3fqwymsD1irLN54v+EmHpNuBOUifHaigpU7oLeDwdPKnPFDJJI2Jtm9g8OHFK+
	 iAcKq5xJtFcdlrdBZkctCMRx+MWCqbvLhaylaxbgPFoSpCYVO9qgRZMURxlbE3+4sQVMu
	 EyaXMujMIqY6J9MjHRpAtA8vIe/h6Tr0+qWVyUjkf8HYjG+7CDW3GTEVdtGskLEuFwzM0
	 cOg9xFvh/874xF+hp4pCNAUD+KIAnH9A76A/810UNJQd+6LehqB14l+ewYL44/o5FDHum
	 p2lFMltn5bvpe3AfYpwq4A3TLSpg/8ZMoq+pRmT+ZP949VuFZ/kDhCRXv9je8EN31nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPe4tbAm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33452606A33D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPe4tbAm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835BA1F00A06;
	Thu, 12 Nov 2026 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490226;
	bh=nFTrJpcSnv0f7k6O76GT0THtHkeQdq9dtFpO2Jb8aZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nPe4tbAmJP7zhcQNpecuucIogt5jJd2cVbRZrGc7cueYbEXOLsMPkVShkZDejT4WP
	 6XTCYyAJb9Y+YRy4YiQ/7pLezbX3Tkm2EC9xbHPJZ3JrpB67ceMD46lmldm+qwa2Or
	 9f/ujPK/ZkHJ8WH9Kg6xJbjQ1TkZYgDu45VpVp42A67w0gIVCWbW/QBRKStI0xfq8y
	 DbSMPq15lpHw7PFC/mD52Lkxe0naWhvlPpS5XclKPBgX0R0yOR5Wg/3/4Zrb0UbLVq
	 0QyKcLXfyetIcY7osjYXAEFrYIp3Z1QRc/o1F3Af7HEOv+qro8lbGUrhN/kxBdLsVs
	 LCTA4mNLviA7g==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:17 +0100
Subject: [PATCH net-next v8 02/19] net: ethernet: cortina: Keep ports bound
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-2-f55bd43e02d3@kernel.org>
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

The software free queue interrupt is routed through port 1 even on
boards which only connect a PHY to port 0. Since PHY setup was moved
into probe, the PHY-less port fails to bind and releases the threaded
handler needed by the shared queue.

Publishing the port before PHY setup also leaves a dangling parent pointer
when probe fails and devres frees the netdev private data. Opening the
sibling can then dereference freed memory.

Keep children bound as IRQ-only ports when no PHY is described or when PHY
setup or netdev registration fails permanently, so an unusable interface
does not disable its sibling. Disconnect any attached PHY after
registration failure. Continue to propagate deferred-probe and mandatory
resource errors.

Resolve referenced PHYs explicitly and defer probe until they register.
Preserve fixed-link registration and PHY connection errors, and release
fixed links on probe failure or removal. This avoids permanently binding
a port IRQ-only just because its MDIO bus has not probed yet.

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
 drivers/net/ethernet/cortina/gemini.c | 165 ++++++++++++++++++++++++++--------
 1 file changed, 129 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 0b05a1552983..1b959ca853c6 100644
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
@@ -359,18 +361,51 @@ static void gmac_adjust_link(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 }
 
+static void gmac_deregister_fixed_link(void *data)
+{
+	of_phy_deregister_fixed_link(data);
+}
+
 static int gmac_setup_phy(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	union gmac_status status = { .bits32 = 0 };
 	struct device *dev = port->dev;
+	struct device_node *phy_np;
+	phy_interface_t interface;
 	struct phy_device *phy;
+	int ret;
+
+	ret = of_get_phy_mode(dev->of_node, &interface);
+	if (ret)
+		return ret;
+
+	if (of_phy_is_fixed_link(dev->of_node)) {
+		ret = of_phy_register_fixed_link(dev->of_node);
+		if (ret)
+			return ret;
 
-	phy = of_phy_get_and_connect(netdev,
-				     dev->of_node,
-				     gmac_adjust_link);
+		ret = devm_add_action_or_reset(dev, gmac_deregister_fixed_link,
+					       dev->of_node);
+		if (ret)
+			return ret;
+
+		phy_np = of_node_get(dev->of_node);
+	} else {
+		phy_np = of_parse_phandle(dev->of_node, "phy-handle", 0);
+		if (!phy_np)
+			return -ENODEV;
+	}
+
+	phy = of_phy_find_device(phy_np);
+	of_node_put(phy_np);
 	if (!phy)
-		return -ENODEV;
+		return -EPROBE_DEFER;
+
+	ret = phy_connect_direct(netdev, phy, gmac_adjust_link, interface);
+	put_device(&phy->mdio.dev);
+	if (ret)
+		return ret;
 	netdev->phydev = phy;
 
 	phy_set_max_speed(phy, SPEED_1000);
@@ -1051,10 +1086,17 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
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
@@ -1065,7 +1107,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 		   new_size,
 		   port->rxq_order);
 	if (other_netdev) {
-		other_port = netdev_priv(other_netdev);
 		new_size += 1 << (other_port->rxq_order + 1);
 		netdev_dbg(other_netdev, "port %d size: %d order %d\n",
 			   other_netdev->dev_id,
@@ -1076,7 +1117,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	new_order = min(15, ilog2(new_size - 1) + 1);
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (geth->freeq_order == new_order)
+	if (geth->freeq_ring && geth->freeq_order == new_order)
 		return 0;
 
 	spin_lock_irqsave(&geth->irq_lock, flags);
@@ -2387,8 +2428,35 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
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
@@ -2398,19 +2466,15 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 
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
@@ -2442,10 +2506,20 @@ static void gemini_ethernet_init(struct gemini_ethernet *geth)
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
@@ -2541,15 +2615,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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
@@ -2600,17 +2665,39 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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
+		dev_err_probe(dev, ret, "PHY init failed\n");
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
@@ -2706,6 +2793,9 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
 
+	/* Quiesce firmware state before child IRQ handlers are registered. */
+	gemini_ethernet_disable_irqs(geth);
+
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);
 
@@ -2717,10 +2807,13 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
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

