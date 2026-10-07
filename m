Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251C4503E4;
	Wed,  7 Oct 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363116; cv=none; b=mfOP0uC+IQfgMMRvsKrsmMYME5qDEk/2Ks5v2pnO1yXbV3lU0cCqvY5AIAPo50a+VL8RZeBieAhXxpl7gW+3ocbutERwQMYN3UdHWFtKV8CsjLvETC55zN+YniEPCIiJyXb70dJY9WCw9jymi0y32VjG4NIXdOlgx+2ZqpJ2Vrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363116; c=relaxed/simple;
	bh=cFOzzudVAcpIU7mQ3ZbBkWrtOr4wyt8UCOlfnqZ7fOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/Vbb+F6WFMgkmMj4Rf4jNMCHAo51gf06ipqEEffru9w0pxHzISm/ge5cFHjbTkj+rI/lYQKMcJ/EV1oM8YwNlg4Np2K32auTQAMJGs/H0xZoa4irDzhzi7cc8Q6W6jrG7S824jvjA9aDpHz/At+9SPVtsLbAp80BzlVQTswFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=dEjvZHw+; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="dEjvZHw+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BCAFA1543;
	Wed,  7 Oct 2026 10:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791363111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wUu0f8/2KvHZ0v6WxQXMKgdRUNW5dZTs0nAPztRZaGQ=;
	b=dEjvZHw+j6ZlLeftQgBik3fVv513rSgMzOKD4KVlJel3qI5OpCoXY54eCmvDJ8plWkSGXt
	xsKROSCB0OhAziORRSMLQg5uVyoxoXAaqyId4tpKipkb/SaD1zWdd+CuROYby/VWfylaTR
	Sveusuv71EEFLBTgVSaJcupsCPcEt7bUnU5NUbC7zKDs5PJkArG0DgDZVGH/FmWxf5PXfi
	aejHkKZYCb0npjDsnyR6bEG9lySGrK54omBOMyas4Cv1fyc5yj/6cS5dOkG0phZ1l8BbQL
	HfbXknvkj2PjGgEfU4yx3VGp1WX9t0YCo597Ga5Pf4YlB53FyahvhYPXRA1i6Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 07 Oct 2026 10:51:24 +0200
Subject: [PATCH net-next v3 1/8] net: bcmgenet: ring the doorbell when the
 last frame of a batch is dropped
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-nb-genet-mtu-nn-v2-v3-1-74a796c019ce@tipi-net.de>
References: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
In-Reply-To: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_xmit() only writes the producer index at the end of a batch. The
error exits return before that write. If the dropped frame was the last of
an xmit_more batch, the frames queued before it stay in the ring until the
next transmit. The queue is still running, so the watchdog does not fire.

Write the producer index on those exits too.

Fixes: ddd0ca5d60b3 ("net: bcmgenet: add support for xmit_more")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4c9db2f9fc25..06ec8c211dd7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2119,6 +2119,15 @@ static void bcmgenet_hide_tsb(struct sk_buff *skb)
 	__skb_pull(skb, sizeof(struct status_64));
 }
 
+static void bcmgenet_tx_kick(struct bcmgenet_priv *priv,
+			     struct bcmgenet_tx_ring *ring,
+			     struct netdev_queue *txq)
+{
+	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
+		bcmgenet_tdma_ring_writel(priv, ring->index,
+					  ring->prod_index, TDMA_PROD_INDEX);
+}
+
 static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
@@ -2155,10 +2164,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* add the Transmit Status Block */
 	skb = bcmgenet_add_tsb(dev, skb, ring);
-	if (!skb) {
-		ret = NETDEV_TX_OK;
-		goto out;
-	}
+	if (!skb)
+		goto drop;
 
 	for (i = 0; i <= nr_frags; i++) {
 		tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
@@ -2183,7 +2190,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (ret) {
 			priv->mib.tx_dma_failed++;
 			netif_err(priv, tx_err, dev, "Tx DMA map failed\n");
-			ret = NETDEV_TX_OK;
 			goto out_unmap_frags;
 		}
 		dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
@@ -2225,10 +2231,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
 		netif_tx_stop_queue(txq);
 
-	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
-		/* Packets are ready, update producer index */
-		bcmgenet_tdma_ring_writel(priv, ring->index,
-					  ring->prod_index, TDMA_PROD_INDEX);
+	bcmgenet_tx_kick(priv, ring, txq);
 out:
 	spin_unlock(&ring->lock);
 
@@ -2245,6 +2248,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	dev_kfree_skb(skb);
+drop:
+	/* The dropped frame may have been the last one of the batch */
+	bcmgenet_tx_kick(priv, ring, txq);
+	ret = NETDEV_TX_OK;
 	goto out;
 }
 

-- 
2.53.0

