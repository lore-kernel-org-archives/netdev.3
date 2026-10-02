Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9E4F55D0
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958307; cv=none; b=oCrvcoxpjIrskwH8NjjMUpuHoocluMnNK5+h4CzNokG/D9gXeTUG6T4ofRU0+R/umJecEmf9RhO9cFnScv5e7zlu7bRcibfbsds++p/YWcQGCKD2vjBddaCqPamOEk9bRiPR1xuO8b+bMDbFYMYL9V0rZxPHIHp5d/D6lgIejYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958307; c=relaxed/simple;
	bh=cRT/1fvG5rxOS2bI9TGftmjt7rSLggfkMyTACIFZRfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KOHM/9rnsVXk0ABW5OpgSaognhpfiQqbRjOT01U08EXP62I2iTAONcVBHPpONBFDUlhSFZCGYtrvPGKaNFXqFS6VaPMcjqRpNyFx3Wu9amqcgyiMy42fpE4446oyep0bxTFQKm0291SmtXLYPGxya7vYx8jS/GbbT8E9suzkWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUnrO++A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUnrO++A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D1A1F00893;
	Fri,  2 Oct 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958305;
	bh=YqJaP125s+ipiOMoBPy5iIsaJGSFZqnx62dhBDXVOqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jUnrO++AeQMCbOXWqaKCCs7Y1PLOqYFGyAlFkuo3s5psNPmdET+RfcSgRAbkvkevm
	 FpbzoaCfVMTu2aDVu7v4cf/cbl2/O/YqoxmbWI0pgZmTeVv03e3YpWc5ooAeRyaFl+
	 di/OF8a8FvKgEFyj6fW/sG1p7EZeDmpCLjDKfml1H+L2GP9SlEWCQKnmNq8qqfxoZe
	 RTN3mUYJce/XVfg0aqsI1otKvrtsnt1hdw8+fMxbq6k4Z20RUgBHBiYGkXQeTGxsMb
	 LSXMccUmMvTEB7zf1pmqZdqE4VRk8xVOfc9mwnk4BDEMBIcCtd7fpRNbRWNJ8NFMx0
	 LmElxPEsO+kRw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:46 +0200
Subject: [PATCH net-next v3 07/12] net: ethernet: cortina: Rebuild free
 queue metadata for RX ring changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-7-3e1f25890ae8@kernel.org>
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

Changing an RX ring can leave the shared free queue order unchanged
while increasing the number of pages which may be in flight. The queue
resize fast path then retains a metadata pool sized for the old RX
rings. A failed resize also leaves the new RX order installed, and open
accepts -EBUSY and proceeds with that larger ring.

Derive the required metadata capacity in one helper and include it in
the resize fast path. Return success while another port is running only
when the existing queue is large enough. Otherwise propagate the
failure from open and restore the old RX order after a failed ethtool
request.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 48 ++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 660e51634017..2345d582cb59 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1066,21 +1066,31 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 	xa_destroy(&geth->freeq_mappings);
 }
 
+static unsigned int
+geth_freeq_page_slots(struct gemini_ethernet *geth, unsigned int order)
+{
+	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	unsigned int slots = 1 << (order - fpp_order);
+
+	if (geth->port0 && geth->port0->netdev)
+		slots += 1 << geth->port0->rxq_order;
+	if (geth->port1 && geth->port1->netdev)
+		slots += 1 << geth->port1->rxq_order;
+
+	return slots;
+}
+
 static int geth_setup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
-	unsigned int pages = len >> fpp_order;
-	unsigned int page_slots = pages;
+	unsigned int page_slots;
 	unsigned int expected;
 	union queue_threshold qt;
 	union dma_skb_size skbsz;
 	unsigned int filled;
 
-	if (geth->port0)
-		page_slots += 1 << geth->port0->rxq_order;
-	if (geth->port1)
-		page_slots += 1 << geth->port1->rxq_order;
+	page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
 
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1193,6 +1203,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct gemini_ethernet_port *other_port;
 	struct net_device *other_netdev;
 	unsigned int new_size = 0;
+	unsigned int page_slots;
 	unsigned int new_order;
 	int ret;
 
@@ -1206,9 +1217,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 		other_port = geth->port0;
 	other_netdev = other_port ? other_port->netdev : NULL;
 
-	if (other_netdev && netif_running(other_netdev))
-		return -EBUSY;
-
 	new_size = 1 << (port->rxq_order + 1);
 	netdev_dbg(netdev, "port %d size: %d order %d\n",
 		   netdev->dev_id,
@@ -1225,8 +1233,15 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	new_order = min(15, ilog2(new_size - 1) + 1);
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (geth->freeq_ring && geth->freeq_order == new_order)
-		return 0;
+	if (geth->freeq_ring) {
+		page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
+		if (geth->freeq_order >= new_order &&
+		    geth->num_freeq_pages >= page_slots)
+			return 0;
+	}
+
+	if (other_netdev && netif_running(other_netdev))
+		return -EBUSY;
 
 	disable_irq(geth->port1->irq);
 	geth_set_freeq_irq(geth, false);
@@ -2008,10 +2023,7 @@ static int gmac_open(struct net_device *netdev)
 	phy_start(netdev->phydev);
 
 	err = geth_resize_freeq(port);
-	/* It's fine if it's just busy, the other port has set up
-	 * the freeq in that case.
-	 */
-	if (err && (err != -EBUSY)) {
+	if (err) {
 		netdev_err(netdev, "could not resize freeq\n");
 		goto err_stop_phy;
 	}
@@ -2370,14 +2382,20 @@ static int gmac_set_ringparam(struct net_device *netdev,
 			      struct netlink_ext_ack *extack)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
+	unsigned int old_rxq_order;
 	int err = 0;
 
 	if (netif_running(netdev))
 		return -EBUSY;
 
 	if (rp->rx_pending) {
+		old_rxq_order = port->rxq_order;
 		port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
 		err = geth_resize_freeq(port);
+		if (err) {
+			port->rxq_order = old_rxq_order;
+			return err;
+		}
 	}
 	if (rp->tx_pending) {
 		port->txq_order = min(15, ilog2(rp->tx_pending - 1) + 1);

-- 
2.55.0

