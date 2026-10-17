Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDE47FB1A;
	Sat, 17 Oct 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238380; cv=none; b=ds/qo7cLpMd2G0//HgRdrrnBD5bVZDdxADbgwX4HxMMZYC0FROmewszW92rg9p6rCVxq0SQ+8geICM9F9CfklFNNuM5L7yn2rsbP5OAIYek4xv0lDtXOS3y0hl0c0qum+bqhSL6nF9+LHFc/1PUZJCoYp+GzSUpiTLs8N7LMnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238380; c=relaxed/simple;
	bh=hqZfTNjbiBw1bIaSk8YNjHZ4zV//TUy8UafwfVO/qW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VO82Dn3yX0tyczreLelg8+xKY5lmcItepHeTVCqjjmIaIQaxaF0Cf6em9JVtZzwnMwW0wAyKHl0idUwLWLRY/3vKkJrc3ljiMrdKlASGsBIqED6quFbHt1Kz4dI4jsrMsKoGW2B4Kz4rzX21AWaP1n7J9N584nP5gekoGutbfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ZkNPUv+n; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ZkNPUv+n"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6FA2A1597;
	Sat, 17 Oct 2026 13:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792238376; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9U1ictPQUq7jBYhYK3hZAIbrREH4nEUjc1MkHa3E2is=;
	b=ZkNPUv+n3F+rx9ISj5yXvkO0lS/8LqjN7cnNoovW6qQEkv7xRfSWbocd3pwQRoO/Jc3MAT
	WTpwrGEP7fbssl2J9rUiGqrNef5XfnbF1LOA/MJlTtsMroO5CK5yCtUMzGPmiGAFbNLoKS
	DZr8IuHCwzc5jvPFW5pW9tT4vFQVAJnIB3rP72pTkjy27MQSpQRkgCB2on0anYiLahauBK
	mmSi5Bzg/PWd9/hT0eytnIuz1kH8p/tYGa7xpWi1tE1q02sxrwyyQhag5eWlT/VEXvPY0u
	Db2pqlhl/KGt4NiH9zsXS1i+82KBqKDymvSj4MV+J7cawDc/Vc50EYWZXqdiQw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 17 Oct 2026 13:59:28 +0200
Subject: [PATCH net 4/4] net: bcmgenet: restore the Tx coalescing setting
 when the rings are rebuilt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-nb-genet-fini-dma-net-v1-4-47e7c57f6834@tipi-net.de>
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

bcmgenet_set_coalesce() writes tx_max_coalesced_frames straight into
DMA_MBUF_DONE_THRESH and keeps no copy of it, while
bcmgenet_init_tx_ring() programs a fixed 1. An ifdown and ifup or a resume
then puts the Tx coalescing back to one frame per interrupt.

Rx keeps its value per ring and reapplies it on init. Do the same for Tx.

Fixes: 2f9130709d2c ("net: bcmgenet: Implement TX coalescing control knobs")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 ++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index cb9951d6036fb..d4de88bbbfbad 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -931,10 +931,13 @@ static int bcmgenet_set_coalesce(struct net_device *dev,
 	/* Program all TX queues with the same values, as there is no
 	 * ethtool knob to do coalescing on a per-queue basis
 	 */
-	for (i = 0; i <= priv->hw_params->tx_queues; i++)
+	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
+		priv->tx_rings[i].tx_max_coalesced_frames =
+			ec->tx_max_coalesced_frames;
 		bcmgenet_tdma_ring_writel(priv, i,
 					  ec->tx_max_coalesced_frames,
 					  DMA_MBUF_DONE_THRESH);
+	}
 
 	for (i = 0; i <= priv->hw_params->rx_queues; i++)
 		bcmgenet_set_ring_rx_coalesce(&priv->rx_rings[i], ec);
@@ -2748,7 +2751,8 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
-	bcmgenet_tdma_ring_writel(priv, index, 1, DMA_MBUF_DONE_THRESH);
+	bcmgenet_tdma_ring_writel(priv, index, ring->tx_max_coalesced_frames,
+				  DMA_MBUF_DONE_THRESH);
 	/* Disable rate control for now */
 	bcmgenet_tdma_ring_writel(priv, index, flow_period_val,
 				  TDMA_FLOW_PERIOD);
@@ -4166,6 +4170,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		priv->rx_rings[i].index = i;
 		priv->rx_rings[i].rx_max_coalesced_frames = 1;
 	}
+	for (i = 0; i <= priv->hw_params->tx_queues; i++)
+		priv->tx_rings[i].tx_max_coalesced_frames = 1;
 
 	/* Initialize u64 stats seq counter for 32bit machines */
 	for (i = 0; i <= GENET_MAX_MQ_CNT; i++) {
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 86f2aed20dbe8..e48ce39d3e7c8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -553,6 +553,7 @@ struct bcmgenet_tx_ring {
 	unsigned int	prod_index;	/* Tx ring producer index SW copy */
 	unsigned int	cb_ptr;		/* Tx ring initial CB ptr */
 	unsigned int	end_ptr;	/* Tx ring end CB ptr */
+	unsigned int	tx_max_coalesced_frames;
 	struct bcmgenet_priv *priv;
 };
 

-- 
2.53.0

