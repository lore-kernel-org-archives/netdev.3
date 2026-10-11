Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6F439F8A
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742004; cv=none; b=qfMWrh848t6npgT1s+o0DZFLNGfk1a+1ORqqffVCI1vgPGlYLwhNPzWSlKrZgjcPoADg8QR9ySDYmImUBKi49aFGegh80ZYucNfqzQf82/cNJxT8Z/UB/N1JPWxOalKX42MEu9rFRfhbW1BncEV0Z0BiHzIbDkN6dejZbfWriSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742004; c=relaxed/simple;
	bh=tRTSRjG0crhl/K0MCSIJ4Fp8Q1OYcOKjEybI1uwCdW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2M4kfweXZEMwQZt/LBJkf8x1cemAxxJoZcAE87QBNwM3PFoXdUlIS/4UwSnonSTUwv2BzEWXNM+Qx+FCicWNIl9jyMkbmAhTm1LNnrmTeqHJxigHmtCQE/XQ3MTawrYwbAkkNa3oaOqFiTCbitLkO2Iz7WdPVsBL0UjRBWY//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL6mECfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL6mECfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560641F0089B;
	Sun, 11 Oct 2026 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742002;
	bh=ufSSKWFjXPoWpo6Uh1IShKC6p6G7KsnTAy09T/nS5x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZL6mECfZYzafnIOzR7xWM1I7QFqOIwVUJDHDItT2E5OqmQFwbuAFTno4908QMojAT
	 vMJ4NDmV5tGf0Ntxw707KGsBFA3aLldibbyDOBcMEdXOiSajpcSn6XNkBaoS/KTT/E
	 1nk7E/v46M7mcj4A1u4EdRKVGQT8xmW+SpYFcg2PqCoZ+SZpyElGYrv37sGX55ZX34
	 hbD/MAUczZSanbC+XH7IYB4iAozduYuf/eMs7NDM8/aNth30rnrM0HDwKaXqABecZ9
	 YOl2Lo/ML4Xg16idFgAR3q8vMxAwQ3I7K9jPCvUeUqnD0VHu3e7n1w9WLXBTitGELX
	 ZdZUBVrqEOK7A==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:21 +0200
Subject: [PATCH net-next v4 08/15] net: ethernet: cortina: Rebuild free
 queue metadata for RX ring changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-8-4b1631b08f5d@kernel.org>
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

Changing an RX ring can leave the shared free queue order unchanged
while increasing the number of pages which may be in flight. The queue
resize fast path then retains a metadata pool sized for the old RX
rings. A failed resize also leaves the new RX order installed, and open
accepts -EBUSY and proceeds with that larger ring.

Derive the required metadata capacity in one helper and include it in
the resize fast path. Reuse an oversized queue only while another port
is running; otherwise rebuild it at the requested order so downsizing
releases the surplus pages. Propagate resize failures from open and
restore the old RX order after a failed ethtool request.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 51 ++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 284823bdfd50..cd5ded7384a5 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1068,21 +1068,31 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
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
@@ -1196,7 +1206,9 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *netdev = port->netdev;
 	struct gemini_ethernet_port *other_port;
 	struct net_device *other_netdev;
+	bool other_running;
 	unsigned int new_size = 0;
+	unsigned int page_slots;
 	unsigned int new_order;
 	int ret;
 
@@ -1211,9 +1223,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	else
 		other_port = geth->port0;
 	other_netdev = other_port ? other_port->netdev : NULL;
-
-	if (other_netdev && netif_running(other_netdev))
-		return -EBUSY;
+	other_running = other_netdev && netif_running(other_netdev);
 
 	new_size = 1 << (port->rxq_order + 1);
 	netdev_dbg(netdev, "port %d size: %d order %d\n",
@@ -1234,8 +1244,16 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	if (new_order <= PAGE_SHIFT - geth->freeq_frag_order)
 		return -EINVAL;
 
-	if (geth->freeq_ring && geth->freeq_order == new_order)
-		return 0;
+	if (geth->freeq_ring) {
+		page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
+		if (geth->num_freeq_pages >= page_slots &&
+		    (geth->freeq_order == new_order ||
+		     (other_running && geth->freeq_order > new_order)))
+			return 0;
+	}
+
+	if (other_running)
+		return -EBUSY;
 
 	disable_irq(geth->port1->irq);
 	geth_set_freeq_irq(geth, false);
@@ -2014,10 +2032,7 @@ static int gmac_open(struct net_device *netdev)
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
@@ -2376,14 +2391,20 @@ static int gmac_set_ringparam(struct net_device *netdev,
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
2.56.0

