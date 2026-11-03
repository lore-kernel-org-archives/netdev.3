Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728283;
	b=TlkhAvlVjD5TS6/5EBxAexiRVId5i06tP8OehzFUPdEJhQZlGztYEngt3XWqvBpoOJN9
	 Gv0jn8+KLSDqVYf7KTF1GZk0zpu1/cNSOz4iQ9dqS+N6RKzqsrXTAHiD4ljECo+JSZcCo
	 Z3r4VUnHkEi5VPt5enyiXcFnoH07M6M8xdybNGKRwj7Zc6ljSDT2JUUdDgIELNPNiFo6L
	 Oo+QlU1eRvcErrwvVu9tiIX3WSymOmCexJkKcnC5unWkttCvf3urb9Oup63esN0G5F80D
	 EG1ghiWIP2PUsCEcK7U0ngOMJs/DLjy1kOXF16xVxS+uHblP/x2dQVdjUYcdzvBAbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728283;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=OH/1mq9Ug5RsQq1cpNM8mOzcepRDcbZuhjewE0jLXPw=;
	b=bJgwVFN+XgOval+5dtiKqXaDPSssSwt+lWP9kdJsU/iMAv4mPudZUuc+8UrO8spHj90O
	 JfKXk4n8NHMnAX6u5mVdUgSpIkgaPteVB3xfFbDJRY9bqkUNXfLK1xJpB8EwXD+G1Dd21
	 M8No3YHgWoTEew4EsmaNlm+JVi6MzF9g/K6c6ZwA5dFkvRv9e5pnTYOH9s7mXK2y7V9Ap
	 0WEVwDwvWmluadCQfvqmjbybiyP0fy88Ph2LIP0v0criMvy3T9vZ804ezBMh8dWgqaurH
	 7rbUn59Sp4VFNvuxindG4JIlBkQzq7dNZfWlSqDJZYwX3YYd6CjCqdBs7dUf1cBitlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tb+IUXyG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA0606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tb+IUXyG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFFA1F00A16;
	Tue,  3 Nov 2026 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728283;
	bh=OH/1mq9Ug5RsQq1cpNM8mOzcepRDcbZuhjewE0jLXPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tb+IUXyGKdbjanrHjhcI37gHIDhdSaMrNrODymDKepit4ggjh4CoBlCt3FLAsxi7R
	 PiZ9dKb0LAHjirXniyylPp11gT2DZlT8Gixxca3sORfrPL+MC9mC9eGWQrlCPZ90Kq
	 RITAR0jqi20ol5KfRc3e+bf27Ld2VXnHwzygtDm/8epUeTFl2A60vhm2FT/WZ+KbPY
	 1+Y6jD9D9NfC2JqVFr/BWFqMPNgYR1u9f/LWzHCalbYf7VMs9qoM0HJ63tZ1Wxi43N
	 8OVNEh0XYcM4y3rKb93IWCRyCI5mDJAL8Xikaor4VgSe94tjdzADT2wHIelf6ml3Wh
	 JButZ0DFGc8mA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:13 +0100
Subject: [PATCH net-next v6 02/15] net: ethernet: cortina: Keep PHY-less
 port bound for shared IRQ
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-2-c4b5ff8a65d8@kernel.org>
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

The software free queue interrupt is routed through port 1 even on
boards which only connect a PHY to port 0. Since PHY setup was moved
into probe, the PHY-less port fails to bind and releases the threaded
handler needed by the shared queue.

Keep children without a PHY description bound as IRQ-only ports.
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
 drivers/net/ethernet/cortina/gemini.c | 110 +++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index bf7652b04f1b..79c046364292 100644
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
@@ -2600,6 +2632,16 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	if (ret)
 		goto unprepare;
 
+	if (!of_property_present(np, "phy-handle") &&
+	    !of_phy_is_fixed_link(np)) {
+		dev_info(dev, "no PHY, keeping port for shared IRQ\n");
+		port->netdev = NULL;
+		rtnl_lock();
+		gemini_port_publish(port);
+		rtnl_unlock();
+		return 0;
+	}
+
 	ret = gmac_setup_phy(netdev);
 	if (ret) {
 		netdev_err(netdev,
@@ -2607,9 +2649,15 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 		goto unprepare;
 	}
 
-	ret = register_netdev(netdev);
-	if (ret)
+	rtnl_lock();
+	ret = register_netdevice(netdev);
+	if (!ret)
+		gemini_port_publish(port);
+	rtnl_unlock();
+	if (ret) {
+		phy_disconnect(netdev->phydev);
 		goto unprepare;
+	}
 
 	return 0;
 
@@ -2675,6 +2723,9 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
 
+	/* Quiesce firmware state before child IRQ handlers are registered. */
+	gemini_ethernet_disable_irqs(geth);
+
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);
 
@@ -2686,10 +2737,13 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
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

