Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700329;
	b=G5WlL82FAu001Zo0QyG3tUYpmTzvLXYkVbd//eBgo1O3yxqkB5pEKfIa1+247caKjIOT
	 7S6SGX9Z86Q3gr0mVQcWxq+4qcnYE6iTjfGM82E8aUFhh8mMvCAlz3hibU3YQpU/fBjya
	 dJGhU5TMqdaLhAXp5/K/jgKjD0DyNNHHkRaPDSPJW/GONu8/3IfgHMk+uPVhXae/DWcm/
	 xWPcCNBxyluPFM6oh+kl5SsdFNbiWgVTSCDZu+n2So6QmiQmHCdmMd9Eo8yTfBtOifX3a
	 ev+pw1Mx6OYJAS0q4ql85LhUg11fEloPG1qIrXC6ZhkJkScBHxd1GHlsjCSwULvG6Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700329;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=eMhYrEXhK+jNgEjEWTh9+AJn7+8+y5YB3TQvTD1Q6tA=;
	b=4jFSZJkd21jvFT1VKJyB33yDKdbSdezaePpHFciM3rml61twhaS8iw6rKNv4wjFMJiDo
	 /y24veSl5Gi+69HEuvcYd9xYxpaAnPQRN3YKOjNVzxnjr+PyKk5LHmbG+mp8vGB18dbOs
	 JKItXqqhjPV6hjIh/q4XnHJyUsjJmekl6c4/6p3BpzmXeO0b83f72dh26/Kapd5GGWGtS
	 qihsFOQzyTV/R+6Rs0aPgxjTdQtMWhCDqLG+tnAvnNMxl7abU6TuIEzBgZCd3e53TOU8y
	 ehuMooVgxg3MVqypPWWhtDln59uIbgt9FhDb8ikDES11JXNz+HYcbvBiS5A46BykNEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=regW97Ie;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEAB606A808;
	Tue,  3 Nov 2026 10:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEAB606A808
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=regW97Ie
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9610CA1648;
	Tue, 03 Nov 2026 11:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eMhYrEXhK+jNgEjEWTh9+AJn7+8+y5YB3TQvTD1Q6tA=;
	b=regW97IexwV6kx+XlflsLJ3m1UK0MBab70xex4UyBDyDi+k1LifhVOw7hM+sGKhePWy2JE
	vvsCaLWo/X1MRACUpvU5CRYOEV2erkgtC97gk8MO6exYy49rJLhIbIwBaH+PHvZJcglCog
	eirPvTSLsSny2LyNJdyJ1Ot169yhd8iIEMLgsTF/9971zrIw2ORAdEqsKzR8pRcfmVgtl2
	UcEscRO1YRCv9cqBYABXKI4+OV0px9Da4bo87Lx/r8cVOVbMm5FCU/wfaad68Q8bGAMkVo
	n+raraf4wBeYsOdkQZ/Vfi85UueuT/oSCmg37asNy3CdSnLUwlZXDepze7ezqQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:04:55 +0100
Subject: [PATCH net-next v6 1/9] net: bcmgenet: ring the doorbell when the
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
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-1-61d5631676e5@tipi-net.de>
References: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
In-Reply-To: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
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

Found by a sashiko review, not by a bug report. The existing exits only
trigger on an allocation or DMA mapping failure, and the padding in a later
patch adds three more.

Write the producer index on those exits too.

Fixes: ddd0ca5d60b3 ("net: bcmgenet: add support for xmit_more")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4d2be2a21ed1b..f28b32f62a7c6 100644
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
@@ -2168,10 +2177,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -2196,7 +2203,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (ret) {
 			priv->mib.tx_dma_failed++;
 			netif_err(priv, tx_err, dev, "Tx DMA map failed\n");
-			ret = NETDEV_TX_OK;
 			goto out_unmap_frags;
 		}
 		dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
@@ -2238,10 +2244,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
 		netif_tx_stop_queue(txq);
 
-	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
-		/* Packets are ready, update producer index */
-		bcmgenet_tdma_ring_writel(priv, ring->index,
-					  ring->prod_index, TDMA_PROD_INDEX);
+	bcmgenet_tx_kick(priv, ring, txq);
 out:
 	spin_unlock(&ring->lock);
 
@@ -2258,6 +2261,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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

