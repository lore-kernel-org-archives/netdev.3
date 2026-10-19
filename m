Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D354AB3AA;
	Mon, 19 Oct 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403581; cv=none; b=Ml/tGweFrYgM0XAufe3I6pXYAOjz3JKubusROussBD3hDMdLvQy/m7ZZjs3hnarQB8ckZBlOeS8cNbjGrydIrRon4fkWbMM3OcvJLN7AhMcvKFUtdyLKw3u4pf6f/x49tYAH/uuPGawf2rOp8vsExf5U8ybuaOrlW5Ai2BoLNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403581; c=relaxed/simple;
	bh=eKqZcG+WdaRvipTs7s0Tuc/enag0E2VLloLAfPS3Xlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyRkjaZoMA9z2dXSeTw9zhuxO9kS7lcBozpWrR9JaHbosuNvyf1tKrqOgVBPfGzkSGkp31QbFQTjwjpyVa9J3pS6DDGIo9Z6EfsymoXqsPCD1g6M6ZD8hXxj0zsMOr8EpfNDTPbipnuOLrbUT6YQv5PXMP9sTI+9K6zpTBNsZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=P1Q8Xh5A; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="P1Q8Xh5A"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E61DA161E;
	Mon, 19 Oct 2026 11:52:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792403577; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EUln+fwWoOEMLcpEf2foA0UQ3r0lDhQ0PrvxchfOHfA=;
	b=P1Q8Xh5APXn/xMM7BCyfMjDxnflmCFDxQJG1FBICTPN6t/o9PxVea46RGbQwJthnGigz1E
	Ib4tofK2qV4YObaAEZ44znA5jnECNrpoVf9iptLaFAMkYa0fUjT9SxmCH7q4QKzh7CvDOL
	9nA7mjUtXqTT3I4ZShx59vs9v690fYOD88XQjTyxkSv+Wdpc02S5jDJIDu/fxNBZaeXCz9
	VatpED5TayXyvtsrPutUlW4vFnryNyAREs3lrMxfmzgDPsS8oUumUohazpw4zy2xTWWrIx
	58/ora9svJF7mUmiO6wy4qkkel3yS6apNH9BBZiBSHwePbEajO7Y6PLR6G1mrw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 19 Oct 2026 11:52:48 +0200
Subject: [PATCH net v2 2/2] net: bcmgenet: restore the Tx coalescing
 setting when the rings are rebuilt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-nb-genet-fini-dma-net-v2-2-b85f6b92654a@tipi-net.de>
References: <20261019-nb-genet-fini-dma-net-v2-0-b85f6b92654a@tipi-net.de>
In-Reply-To: <20261019-nb-genet-fini-dma-net-v2-0-b85f6b92654a@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Justin Chen <justin.chen@broadcom.com>
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
index 34acd3c47cc55..8db82d924d218 100644
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

