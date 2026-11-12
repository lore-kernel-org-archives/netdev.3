Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480328;
	b=RBK3SDUVNTFVSNJiRPXC+K/4UcJrkuJulAPlLyGQPln4NolX29Wd6F15mqEWoFTeLf/F
	 PjEmYUeZf4Wc80IjRQMkI+GrZNcXFd/AbKtjT61G5M1LnIQNZjyGL6atMk4/uMkuGXFyC
	 Kkwylv34S4UnftJjqGd6IlXeFXOqoODwozXrc548lZpUssGAnB5SFAR1mlbmE3Y3nFmNs
	 iTEm8EZiI+zenIyD5TvQEqF17Hha17iilKW7Z9ah4YxPIUtmyxNkxGYVfCxKSyHTbP/eu
	 fTU4O4ninr/6NHALL4XQGIoSxXBtWtaU8+c7+Qj0IV7RotHCPNfzPc+LDSaVBWpBotQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480328;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=T16O+6zhR+p9Je0siluHmer56Vdp74YQqdb4noZIbnA=;
	b=pgKHPsxaO3p5/tSSVzKSjC6CxwI72PlxPO3tJYtwzpO7ES1xTY0ebqIYNgNjbx3kS51W
	 K4rJ6+AGddYf8AM2fY3Z6GbHvGK9+OpAW5IBOdRJPYnAU/NMxJn14BfaUd9Dqf/u+Deqc
	 AiUbPzGHRLO+1M52byFZTExlSqvfhQc6H3Xz2j8AeHpIGaKqYEL7KtkeEhclg58wW3zCi
	 y+zBpYMKneN+WxSQ3Uq9CtrC4lI1oigRYS5pnAldqGW/R077naCKsJLQHhYpsN4b60Rw5
	 5y/1DIr/Ariy84JkS4tIO3VV23jHPi/LOIkLo/6A4jvOI7wuwo5BAgopVjEks3O9t+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Fr4fi5b1;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E89606A886;
	Thu, 12 Nov 2026 10:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E89606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Fr4fi5b1
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39641A1D1C;
	Thu, 12 Nov 2026 11:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794480325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T16O+6zhR+p9Je0siluHmer56Vdp74YQqdb4noZIbnA=;
	b=Fr4fi5b1wCL+Fg4ssReUwsqcv56xg4taF+xh+R99agxlrCMrf3fm7vaENef/zrJbDpcOo5
	uMUaUN3MzBqhPsHBXh/u9EpfADPVgAqOKYlkP5c8ZHMSAFzia4j24ECi4QNv5Z3+TweXOU
	i+og69zLgp4tlIX23Y0rtLEwTBHR09YQfHcN+ot9Ahed/v5iPy/sk/R6fFF+d+meNWYYLC
	eXtzsxeAqRhslf5vOt37M7ucjSEE4nhenfbez4NB3MsbnVg8cNzm8W5yImFpRO0oAuzBqo
	BnMFqaM3HS6JNTkywOm5M+U7Ct+veXgC2DBNUrLX/zLSKEtGsf1/hlTbeieeJg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 11:45:15 +0100
Subject: [PATCH net-next v7 1/9] net: bcmgenet: ring the doorbell when the
 last frame of a batch is dropped
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
Message-Id: <20261112-nb-genet-mtu-nn-v2-v7-1-43a5d90b3256@tipi-net.de>
References: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
In-Reply-To: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_xmit() only writes the producer index at the end of a batch. The
error exits return before that write. If the dropped frame was the last of
an xmit_more batch, the frames queued before it stay in the ring until the
next transmit. The queue is still running, so the watchdog does not fire.

It came out of a sashiko review, not a bug report. Those exits only run
when a clone, an allocation or a DMA mapping fails, and a later patch adds
one more.

Write the producer index on those exits too.

Fixes: ddd0ca5d60b3 ("net: bcmgenet: add support for xmit_more")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 31 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 61f5a4c2f0cd9..1114fe46d2f73 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2122,6 +2122,15 @@ static void bcmgenet_hide_tsb(struct sk_buff *skb)
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
@@ -2153,8 +2162,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!skb) {
 			spin_lock(&ring->lock);
 			BCMGENET_STATS64_INC((&ring->stats64), dropped);
-			ret = NETDEV_TX_OK;
-			goto out;
+			goto drop;
 		}
 		nr_frags = 0;
 	}
@@ -2173,8 +2181,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb) {
 		BCMGENET_STATS64_INC((&ring->stats64), dropped);
-		ret = NETDEV_TX_OK;
-		goto out;
+		goto drop;
 	}
 
 	/* Retain how many bytes will be sent on the wire, without TSB inserted
@@ -2184,10 +2191,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -2212,7 +2217,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (ret) {
 			priv->mib.tx_dma_failed++;
 			netif_err(priv, tx_err, dev, "Tx DMA map failed\n");
-			ret = NETDEV_TX_OK;
 			goto out_unmap_frags;
 		}
 		dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
@@ -2254,10 +2258,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (ring->free_bds <= ring->stop_thld)
 		netif_tx_stop_queue(txq);
 
-	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
-		/* Packets are ready, update producer index */
-		bcmgenet_tdma_ring_writel(priv, ring->index,
-					  ring->prod_index, TDMA_PROD_INDEX);
+	bcmgenet_tx_kick(priv, ring, txq);
 out:
 	spin_unlock(&ring->lock);
 
@@ -2274,6 +2275,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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

