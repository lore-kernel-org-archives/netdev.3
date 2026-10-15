Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01713541470
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077859; cv=none; b=ndR6yv25FccdI9tl9VK1SHvtXBmRIzj+J8ubDilQxkeoPLcrPc3ppPRqmK5e8rh3I2TRzCComahaNGXkTB/FIs0YB/JroK9xhE+2O61/JRdJQemK7FZHER+W24FnRuUNeCkwU+fRVEy2xK7Qg/wCWiiBTQwb+Kmg8AQRQGXcHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077859; c=relaxed/simple;
	bh=lXgq8DUX6kG0ndTo5sF4M6UHblhWDCRdf8/70coLUvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFzgpLNh5igVQ6OFj/I/a9Ik8wfh58y/bC62DH3H5L02ucL1rIDoM0cWaasSArlix+Itcd7OdbOxs2HEHmGMyi08YKXxAmpeO8uf6XlVnknerSuL0QgFC0ULvH9dQM9D5xkfZ104DF6FMOfxXR4p0oWKfVrdgxcXod29/RvKAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq6AlTuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq6AlTuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E491F000C6;
	Thu, 15 Oct 2026 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077853;
	bh=AuAHSl90RUJuRWZOgR1/O2sER/y9ULFtuy4Ae+JeTNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gq6AlTuXRuscSco9d9McWow2I56B+KQ0b8rm7igeKyC55Lv7uGXMsYNfEX79UHrDl
	 gnwD9T7UHguU86RMdc+QsNmDViH89atD697cj0smiWWd12jDDzNmgNlLvX484zunF/
	 8lvw5+TX4hF/RR442eoETp32U9vIQpsQ/fsCD95ymk3D2wni2H4X3nHMaQmtDEEGMd
	 FsmL06uYviSjTkGaxa40YbcDOrgU1sXM8zItHD39ZH0tSDxMD5RNUNIvmeQBcJR30Y
	 MU02Niwfq6P18wHceOnDX9+Q9xe5TVnBR9wb/8o09YgMAhaTGyQ3hNiPOzeiftZ2Cc
	 s6U9MJCOIciUQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:02 +0200
Subject: [PATCH net-next v5 02/14] net: ethernet: cortina: Keep PHY-less
 port bound for shared IRQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-2-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
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
Assisted-by: LLM
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

