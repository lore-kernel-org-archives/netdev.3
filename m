Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B046F4A2;
	Mon, 12 Oct 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795659; cv=none; b=fq6GnyMPLnz+M/rtn1V5rtSC3i3s/eVvOIyZFAHzRFJGRL+Fd4SBvr6F7lUsYczV1zofChMiLKMstRLLDyxZf9Z7UG1np0XXeG4tbICjYI1CIKGxxyfhpIHqfKjQiT8vfMHVWoSGSeJoVrBrmkZjGqBMUussG5bAf4ssOs9dmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795659; c=relaxed/simple;
	bh=taA9qOXNPg+KrqkETCKZ7HdCd0A1SWGdZ3N30keDOJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CM3GmO/sKK1DxXL+CsLbVpHbcYlHykIv0Ky7SaXPi2qWVogaUbSV17pkvXfO6p0/59Ag9rJ2TfAPu/VoY3znT6HIYV15uPm/aeyHeosLsUUJ5CFM7cca8ymDp4+goln7YbUlu1lipR/H3avhY3sJufkFKPTGUxCVapWP/Sqspvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sFRg8cEC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sFRg8cEC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09A61A1577;
	Mon, 12 Oct 2026 11:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791795652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AWtBQ0hKVwYuH6ZSZCwTscFLhuHVjpzu9TStxFLxEJ0=;
	b=sFRg8cECDDbCefk4OmI4CsYu7WwwEQCJgTrpjQXCenSxYSelZeyxxYUFn+IOTrjzX0ybMh
	ydf0mSZ5UI2mqvKLLsAjKacHcX4fyfP/tNmgdCealw1+Hliy8ajW7qDRang16O/9c9tPhq
	SAF505DN8yV8NVhFkpYpmZuIi5d5+HY80+sBBHMWUK5Dl9KtZPYWV2iviJ6P893AVcbbk1
	7c3zhQNgWJBu2Psxm1JgJuHiBXBetPOFa/2GpWpPNim6S74r0HC/gbH85jK2UKwnE4X0AP
	VwqhkeQ/tm3LndI2VAE6m/itKAeR8xVwcFmUwtv6CfIRKbYAAwItj3f8lMB7jg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 12 Oct 2026 11:00:37 +0200
Subject: [PATCH net-next v4 1/8] net: bcmgenet: ring the doorbell when the
 last frame of a batch is dropped
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nb-genet-mtu-nn-v2-v4-1-2e2e3bfaf8cc@tipi-net.de>
References: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
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

Found by a sashiko review, not by a bug report. The existing exits only
trigger on an allocation or DMA mapping failure, and the padding in a later
patch adds three more.

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

