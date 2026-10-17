Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2E3EFD24;
	Sat, 17 Oct 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238380; cv=none; b=mGegRxijucmBEa1YhK8GR7bFsE+hgTO/79rdDwz0CUBWNdIvURjo+2sFOfBi3q6AUa9WSpqJPkfjwTOFQTBZT2KBcQwaVnU+LYBALp3ztQjRdua8r303TDlGNKyzFF11/mfy38dPwGwc9+OQmINHPhoyA1KPwwviFhN79uoYksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238380; c=relaxed/simple;
	bh=GkuaJAdKLTlzIRSXrvrAZIs9RVPQ5+l5epy7umzJzKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyUkjwdBXbBMD8lQtQZbPjY+GntyXC6DqRu/cpoWVgnCv3l1qGTCfR06i6ePtCDtJ3bebahU1FDWPff/sfM3JJRjwPU5EnJ1tMdqWhu74I5hrMa7Z92D6i6tJYhC2FJfVl5doM/xJ50Ox5LwIp0kGnndZhUVwfesVYpQxZhXrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=P4HexBQs; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="P4HexBQs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A63C9A158D;
	Sat, 17 Oct 2026 13:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792238375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9zreNu2GTEcKLgAuX+6IWZZKy6Tv+DsUt1N8j/NZ5oI=;
	b=P4HexBQsG0KaXhjBn+wb1JwLaCiL7di65qXuR6ep2gN+ePeh6bGuAT4EN8PXFDJwjce2wK
	ILfbmiMexaKa564GUNiTZCFtqz78NOAUD0t6NSGFm4P70dPO58Mpnj08cdRs5OD/dz2un8
	q9FwPzHBGaglLtkGzt+DH5VHk10/8hDj14WkKOSOXzRCrCZB6eqvfIg5tdhBpZIEubTXVF
	szTd8PA9Z2sLenNkfyebp8Co3cD7cOR14gyv0c+AldaTfLDE6ly4ZLbUFPEI+IwCqNC8Nr
	Tzqf54PDtRxo4bhprQ7kBwsG25lIl2ATjhs5bZGW7r7lK2uxG9s/L7NMeAlMYg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 17 Oct 2026 13:59:26 +0200
Subject: [PATCH net 2/4] net: bcmgenet: do not tear the datapath down twice
 after a failed resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-nb-genet-fini-dma-net-v1-2-47e7c57f6834@tipi-net.de>
References: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
In-Reply-To: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

If bcmgenet_resume() fails in bcmgenet_init_dma() it returns with the
interface still IFF_UP. The suspend before it already deleted the NAPIs and
freed rx_cbs and tx_cbs, so the next ifdown runs the whole teardown again
and napi_disable() waits for a NAPI_STATE_SCHED bit that nothing will
clear:

  task:ip  state:D
    usleep_range_state+0xec/0x158
    napi_disable_locked+0x254/0x318
    napi_disable+0x3c/0x68
    bcmgenet_netif_stop+0x1c8/0x318
    bcmgenet_close+0x24/0xd0
    __dev_close_many+0x18c/0x310

RTNL is held across the wait, so every other rtnl_lock() user blocks behind
it. A second suspend ends up in the same place.

Flagged in a sashiko review, found plausible and then reproduced on a CM4.

Clear rx_cbs and tx_cbs as they are freed, so close and suspend can tell
there is nothing left to tear down.

The WoL resume path needs the same check. It reuses the rings when it sees
the receiver enabled. But after a failed resume the MAC sits in software
reset, and the next link event takes it out and enables it. Reusing rings
that are gone reattaches the interface and the first transmit hits
BUG_ON(!tx_cb_ptr), so check the rings too.

Fixes: b6e978e50444 ("net: bcmgenet: add suspend/resume callbacks")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 308716cddc077..fe3338ba81980 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3107,7 +3107,9 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 	bcmgenet_free_rx_buffers(priv);
 	bcmgenet_destroy_rx_page_pools(priv);
 	kfree(priv->rx_cbs);
+	priv->rx_cbs = NULL;
 	kfree(priv->tx_cbs);
+	priv->tx_cbs = NULL;
 }
 
 /* init_edma: Initialize DMA control register */
@@ -3165,6 +3167,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	priv->tx_cbs = kzalloc_objs(struct enet_cb, priv->num_tx_bds);
 	if (!priv->tx_cbs) {
 		kfree(priv->rx_cbs);
+		priv->rx_cbs = NULL;
 		return -ENOMEM;
 	}
 
@@ -3184,7 +3187,9 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 		bcmgenet_free_rx_buffers(priv);
 		bcmgenet_destroy_rx_page_pools(priv);
 		kfree(priv->rx_cbs);
+		priv->rx_cbs = NULL;
 		kfree(priv->tx_cbs);
+		priv->tx_cbs = NULL;
 		return ret;
 	}
 
@@ -3493,7 +3498,9 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev, false);
+	/* A failed resume has torn the datapath down already */
+	if (priv->tx_cbs)
+		bcmgenet_netif_stop(dev, false);
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -4258,7 +4265,11 @@ static int bcmgenet_resume(struct device *d)
 
 	if (device_may_wakeup(d) && priv->wolopts) {
 		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-		if (reg & CMD_RX_EN) {
+
+		/* A link event can enable the receiver after a failed
+		 * resume, so check the rings too
+		 */
+		if (priv->tx_cbs && (reg & CMD_RX_EN)) {
 			/* Successfully exited WoL, just resume data flows */
 			list_for_each_entry(rule, &priv->rxnfc_list, list)
 				if (rule->state == BCMGENET_RXNFC_STATE_ENABLED)
@@ -4343,6 +4354,15 @@ static int bcmgenet_suspend(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
+	/* A failed resume has torn the datapath down already. Resume still
+	 * enables irq1 on the WoL path, so it has to be disabled here.
+	 */
+	if (!priv->tx_cbs) {
+		if (device_may_wakeup(d) && priv->wolopts)
+			disable_irq(priv->irq1);
+		return 0;
+	}
+
 	netif_device_detach(dev);
 
 	if (device_may_wakeup(d) && priv->wolopts) {

-- 
2.53.0

