Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659260;
	b=FNg8nLB+dY+ybijdGRW/zd7T5LLeW/sudX32Pocl5S3IZcYletuy7E6SWr72lp6lkDZa
	 YBMmsghpn7sQ624rI3csLvm7RVS/V51vrUBLdhZRdHJIGG+2p3e11IJjUkQ7MoUnpVnYe
	 v6J4WUtCUowrG8SWMwwVtM8raB2ZP/PUEK6tRtkiuvKG2S1YyX0SMM9mKRAp9w+pRSkhE
	 55dGpS6ZDU8bBOJ77tXsqOcBon2IKYBotUgfB/2khKNIhTzj2qFwP7lKIpBdhkO5gk87A
	 cyETd3Ui257GYer6ZeoH1dSub+EoseRAAyfLUtFOV5f+DJxGHjr59QTRXJRLoZkT0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659260;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=rwiDdevONxvt7NX1kICTlMNzIDrXGH9Y6KRp+hUkNEw=;
	b=d8PgrRYIj9G8DcDAtvY7lKBG5e6hkSmiPtnomyQIHusKzf60RE/aCM1fkwQOIF1Jb1MK
	 0hhBgr58I6AczTYGJXSSpPQu6bhMjS5fwsJmQad7aoRR+3ScNnrSice4sJTISdiP/5wJI
	 +aZGcFBlvkoexSVYs9+zYVnNbPiRPwOz/LMriPE1h6YEjWqSIbhXu/XhR6hVHsaekUu0w
	 zl/avFQTwLRRYgf6B3Ndi5YcdwTu2ahzTs+mBtr56WtptuhRAnWyKWY9E08qtWUNnBDnT
	 TZTprsrir8jBhKwfvNqgAAwRryK7ssiZocSY3TcX184kBqfLvd+3vXKJq5AtcNwhnRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="thVG/crv";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6C606A319;
	Thu, 22 Oct 2026 08:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A6C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=thVG/crv
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9E54A1574;
	Thu, 22 Oct 2026 10:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792659256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rwiDdevONxvt7NX1kICTlMNzIDrXGH9Y6KRp+hUkNEw=;
	b=thVG/crvX8VJbGW9EOY4o4g5/GtqzFfF0yASqW7u7jAS3KNcRoA0IYB910KqAnnCYgemGg
	yPZuK3p2Qm3IoME8s++5vv4dZmviI4F1Nu7zyncI2x/1ueSJeB7gmqVW3SoWqsLd52Or//
	LSbLmzznO2gloMU7em5kHyFUuo3aGAUfSbUaUbDcI3n05kjfR08fVa+Sgg/pzIpZsLkdnL
	Cat7TdMjU/K0GB/XEJAOWNJVgap0nJsSG+y55NerxcuLqJQ2GBvVqQYEg0VZWa1z7RTFD3
	WkQJVbRGBt/gQ+zjA8zINRNkN7h3QOtmG0ejXsOyX+I/sfJKwCpHIAecQbWLbg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 22 Oct 2026 10:54:06 +0200
Subject: [PATCH net v3 1/2] net: bcmgenet: recover from a failed resume
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
Message-Id: <20261022-nb-genet-fini-dma-net-v3-1-6e9fc89c0156@tipi-net.de>
References: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
In-Reply-To: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A resume that fails in bcmgenet_init_dma() returns with the interface
still IFF_UP and the datapath gone. The next ifdown runs the teardown
a second time and napi_disable() waits for a NAPI_STATE_SCHED bit that
nothing will clear:

  task:ip  state:D
    usleep_range_state+0xec/0x158
    napi_disable_locked+0x254/0x318
    napi_disable+0x3c/0x68
    bcmgenet_netif_stop+0x1c8/0x318
    bcmgenet_close+0x24/0xd0
    __dev_close_many+0x18c/0x310

RTNL is held across the wait, so everything else blocks behind it.

The same resume gates the clock and detaches the device. Close releases
the clock a second time and ifup fails with -ENODEV. The hardware filters
stay armed, so the next WoL suspend wakes on any frame. That suspend sets
CMD_RX_EN for magic packet detection, so the WoL resume reuses rings that
are gone.

A failed resume should leave a state the ordinary paths can handle. Clear
rx_cbs and tx_cbs as they are freed so they answer whether a datapath
exists, and leave the clock alone so close and suspend release it once.
The WoL resume rebuilds instead, so stop the PHY first, phy_start() only
takes PHY_READY or PHY_HALTED.

Flagged in a sashiko review and reproduced on a CM4 by forcing the resume
allocation to fail.

Fixes: b6e978e50444 ("net: bcmgenet: add suspend/resume callbacks")
Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")	# for the WoL parts
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 92 +++++++++++++++++---------
 1 file changed, 62 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f4cfbff49a1b8..e7dec73d5b1c0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3117,7 +3117,9 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 	bcmgenet_free_rx_buffers(priv);
 	bcmgenet_destroy_rx_page_pools(priv);
 	kfree(priv->rx_cbs);
+	priv->rx_cbs = NULL;
 	kfree(priv->tx_cbs);
+	priv->tx_cbs = NULL;
 }
 
 /* init_edma: Initialize DMA control register */
@@ -3175,6 +3177,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	priv->tx_cbs = kzalloc_objs(struct enet_cb, priv->num_tx_bds);
 	if (!priv->tx_cbs) {
 		kfree(priv->rx_cbs);
+		priv->rx_cbs = NULL;
 		return -ENOMEM;
 	}
 
@@ -3194,7 +3197,9 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 		bcmgenet_free_rx_buffers(priv);
 		bcmgenet_destroy_rx_page_pools(priv);
 		kfree(priv->rx_cbs);
+		priv->rx_cbs = NULL;
 		kfree(priv->tx_cbs);
+		priv->tx_cbs = NULL;
 		return ret;
 	}
 
@@ -3503,7 +3508,9 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev, false);
+	/* A failed resume has torn the datapath down already */
+	if (priv->tx_cbs)
+		bcmgenet_netif_stop(dev, false);
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -3511,6 +3518,9 @@ static int bcmgenet_close(struct net_device *dev)
 	free_irq(priv->irq0, priv);
 	free_irq(priv->irq1, priv);
 
+	/* A failed resume left the device detached, __dev_open() refuses that */
+	netif_device_attach(dev);
+
 	if (priv->internal_phy)
 		ret = bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
 
@@ -4268,7 +4278,11 @@ static int bcmgenet_resume(struct device *d)
 
 	if (device_may_wakeup(d) && priv->wolopts) {
 		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-		if (reg & CMD_RX_EN) {
+
+		/* The WoL power down sets CMD_RX_EN itself, so the bit
+		 * alone does not mean the rings survived
+		 */
+		if (priv->tx_cbs && (reg & CMD_RX_EN)) {
 			/* Successfully exited WoL, just resume data flows */
 			list_for_each_entry(rule, &priv->rxnfc_list, list)
 				if (rule->state == BCMGENET_RXNFC_STATE_ENABLED)
@@ -4298,6 +4312,9 @@ static int bcmgenet_resume(struct device *d)
 		bcmgenet_rdma_disable(priv);
 		bcmgenet_intr_disable(priv);
 		bcmgenet_fini_dma(priv);
+		if (phy_is_started(dev->phydev) ||
+		    dev->phydev->state == PHY_ERROR)
+			phy_stop(dev->phydev);
 		enable_irq(priv->irq1);
 	}
 
@@ -4320,8 +4337,9 @@ static int bcmgenet_resume(struct device *d)
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv, false);
 	if (ret) {
+		/* Leave the block clocked, close and suspend tear it down */
 		netdev_err(dev, "failed to initialize DMA\n");
-		goto out_clk_disable;
+		return ret;
 	}
 
 	if (!device_may_wakeup(d))
@@ -4332,24 +4350,57 @@ static int bcmgenet_resume(struct device *d)
 	netif_device_attach(dev);
 
 	return 0;
+}
 
-out_clk_disable:
-	if (priv->internal_phy)
-		bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
-	clk_disable_unprepare(priv->clk);
-	return ret;
+/* Arm the configured wake filters and drop the rest, then clear old
+ * matches so that only a new one wakes the system
+ */
+static void bcmgenet_wol_arm_filters(struct bcmgenet_priv *priv)
+{
+	struct bcmgenet_rxnfc_rule *rule;
+	u32 reg, hfb_enable = 0;
+
+	if (priv->wolopts & WAKE_FILTER)
+		list_for_each_entry(rule, &priv->rxnfc_list, list)
+			if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE &&
+			    rule->state == BCMGENET_RXNFC_STATE_ENABLED)
+				hfb_enable |= 1 << rule->fs.location;
+
+	reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+	if (GENET_IS_V1(priv) || GENET_IS_V2(priv)) {
+		reg &= ~RBUF_HFB_FILTER_EN_MASK;
+		reg |= hfb_enable << (RBUF_HFB_FILTER_EN_SHIFT + 1);
+	} else {
+		bcmgenet_hfb_reg_writel(priv, hfb_enable << 1,
+					HFB_FLT_ENABLE_V3PLUS + 4);
+	}
+	if (!hfb_enable)
+		reg &= ~RBUF_HFB_EN;
+	bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+
+	bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_MASK_SET);
+	bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_CLEAR);
 }
 
 static int bcmgenet_suspend(struct device *d)
 {
 	struct net_device *dev = dev_get_drvdata(d);
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct bcmgenet_rxnfc_rule *rule;
-	u32 reg, hfb_enable = 0;
 
 	if (!netif_running(dev))
 		return 0;
 
+	/* A failed resume has torn the datapath down already. Resume still
+	 * enables irq1 on the WoL path, so it has to be disabled here.
+	 */
+	if (!priv->tx_cbs) {
+		if (device_may_wakeup(d) && priv->wolopts) {
+			bcmgenet_wol_arm_filters(priv);
+			disable_irq(priv->irq1);
+		}
+		return 0;
+	}
+
 	netif_device_detach(dev);
 
 	if (device_may_wakeup(d) && priv->wolopts) {
@@ -4358,26 +4409,7 @@ static int bcmgenet_suspend(struct device *d)
 		netif_tx_disable(dev);
 
 		/* Suspend non-wake Rx data flows */
-		if (priv->wolopts & WAKE_FILTER)
-			list_for_each_entry(rule, &priv->rxnfc_list, list)
-				if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE &&
-				    rule->state == BCMGENET_RXNFC_STATE_ENABLED)
-					hfb_enable |= 1 << rule->fs.location;
-		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
-		if (GENET_IS_V1(priv) || GENET_IS_V2(priv)) {
-			reg &= ~RBUF_HFB_FILTER_EN_MASK;
-			reg |= hfb_enable << (RBUF_HFB_FILTER_EN_SHIFT + 1);
-		} else {
-			bcmgenet_hfb_reg_writel(priv, hfb_enable << 1,
-						HFB_FLT_ENABLE_V3PLUS + 4);
-		}
-		if (!hfb_enable)
-			reg &= ~RBUF_HFB_EN;
-		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
-
-		/* Clear any old filter matches so only new matches wake */
-		bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_MASK_SET);
-		bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_CLEAR);
+		bcmgenet_wol_arm_filters(priv);
 
 		if (-ETIMEDOUT == bcmgenet_tdma_disable(priv))
 			netdev_warn(priv->dev,

-- 
2.53.0

