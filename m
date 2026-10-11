Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9B42466D
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741988; cv=none; b=Cu9DvhrIfc9nRiNAj0MylcX/QSbJxo0sA/kdwuoWH/0m9EXwtZcMyIT8uD3+GHOUYdbZ3IkWTQutBnQ6c7tkRMh8DQ3Sat4ftbTfzZ/plattDW3zL/QsN+FStWdY3xNvqfDqRlfqwgRIEx6aV9CDK/6IsppH1V3zNj7RzME5ERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741988; c=relaxed/simple;
	bh=HS/pHYoVpNhISaiP26JiIg1T1WQebmsnUPa5FyPStGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqzjV+qO51T+d27zMvUyhzLTgDhBDQWmdf/n2KyUdK+4Fm/4ObZ6F1yZA18NwJv6aB1e/Gzz0dEAMNU6j9v0Sk2Z9au7IKOVp9n5+8dKj79jMorVFXiQx4fAYiNNRtA27s4II7XmDIhINqiqxXLeuxLyKVkL5rSS47oI3fF4diQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGxqxnwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGxqxnwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5589C1F0089B;
	Sun, 11 Oct 2026 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791741985;
	bh=u0wufSxkhpld8XeeuK5AXLQwHlfhOzUWsFx5iGpJwbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BGxqxnwalcJowhCOMneg1JsINfMmhF27hmJVbcya4oZHsRhtJYXpNvv9o05CGvv0q
	 FXsVt+hVUSqj8dDIXp3VrgYGBCfOC0KjFG9PZS1KtLN2vdYXmNr2hvJfdbhv0IFwQN
	 tRzy4Cq8xQ/ijf8coMyJCOxD6+WcwvIMX68RbLY86rOW8f6cpWMxTj/9nT8PiIapjd
	 SG+9SCxxGJMiUFALQkCfvj9l4zUzJEFrImGyWKcuwEtDvRGjpngUJamwnLUQxHdo+F
	 kpeG3oSBqomXVmqLtbYrxIRWNgzQphUri1Rerz8nRuzTWq4oWX144nrW9yO9tv6+oH
	 wquUD6tgoYdHw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:15 +0200
Subject: [PATCH net-next v4 02/15] net: ethernet: cortina: Keep PHY-less
 port bound for shared IRQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-2-4b1631b08f5d@kernel.org>
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

The software free queue interrupt is routed through port 1 even on
boards which only connect a PHY to port 0. Since PHY setup was moved
into probe, the PHY-less port fails to bind and releases the threaded
handler needed by the shared queue.

Keep children without a PHY description bound as IRQ-only ports.
Publish a port to the parent only after its IRQ and optional netdev are
ready, and protect port lifetime and initialization state with RTNL.
Refuse shared queue setup until both ports have completed
initialization.

Fixes: 3e813d61401a ("net: gemini: Clean up phy registration")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 88 ++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index bf7652b04f1b..ec2e47688337 100644
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
@@ -2387,8 +2395,28 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
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
+
+	geth->initialized = false;
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
@@ -2398,12 +2426,12 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 
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
 
 	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
@@ -2446,6 +2474,20 @@ static void gemini_ethernet_init(struct gemini_ethernet *geth)
 	 * set up and enable the queue IRQ. FIXME: fragile.
 	 */
 	geth->freeq_order = 1;
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
@@ -2541,15 +2583,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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
@@ -2600,6 +2633,16 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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
@@ -2607,9 +2650,15 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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
 
@@ -2686,10 +2735,13 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
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

