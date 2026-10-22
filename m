Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659260;
	b=k/QRabYadxy1QN7RIijFtbmO3uwRhgKs6Q7TqnF3RPdtTwH1S6hWClGGe+chnchqSxp9
	 kBrWW3M3MtyJY3OGD6w/jQ/+nF5sUiaVYX5eRV7SuBKDNCiedImHv2e3TbkpS5a+1EjPl
	 5LQ2DCXmVxG6YWh+d2urNXRUuILnRr5BAzEV7Ojrl/EF+abxpKAuWGYZVhR+FmKKlJ9Jv
	 zX2TFy1sNkoF5Ih9q15h3e00wgsA61eMqG35Kj475sStmQbm7vmJ6mwsjhw5sG498f0aZ
	 W0JTbnpl/nybzI5YfeoukTfc2/G+DHzXLcmMgsBaIzbZGXALJP5GPJEsrF4dd0K/wvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659260;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=i8kKzAxwRj+gsfR5tIIxVblkQjaYGtvUZ0W4uHjhqZ0=;
	b=NW77POW1l2ZX+OBM+8VRy+aGFzU7v0KYedtBzm0k8RxZevRBHTnZjAwSFYpj5hRj2eU7
	 3vSNTJ/Jk5UAFyp2kCe7N3TrgH8cUFE8JYDPzbxR4av0p20bkLb3jxsUKHVjYKaCYQpt2
	 nQMkCFk/0CrRKOhfOm1BkNUijqZUrRBXwG36oUWDbTWoLxz/7w6T4DJVm/vUgg5gxxa2C
	 svMj9mAhnyN1oi6pNtgxKINQbK70kX7//fHcU333555n2QqagP6R1fnm2aKW6wK4E9pXU
	 LmSCHkDnmwuZnkuNPRKebMgftEaaFCSODDULMDh01nyXPrDGGrvIuebBkzIZZ7cdPAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=XpgmsGMr;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595A606A31B;
	Thu, 22 Oct 2026 08:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7595A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=XpgmsGMr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DC7AA1584;
	Thu, 22 Oct 2026 10:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792659256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i8kKzAxwRj+gsfR5tIIxVblkQjaYGtvUZ0W4uHjhqZ0=;
	b=XpgmsGMri7OTM6DAPuieClpFy6jfHznmsaejoGyDMBhlxuYr8RaXpEME2ksaVdjzvykG4r
	69ox0jQI3vc7mpto7cPGJoLYBd0IV8d4Mjy5fmAnQyk0MKBALMRJFOiq+QTh8UWpLWbwHC
	OS/+GTdVHtAehF21wBbJZ/uUlF6Uc8YiH55BlFbl7PTlepPgl6ZTCHmTunH0mmr773zfgG
	LucaMBYAmdEafuRX8S9Yy0R9KtVtTV8VHVXqQ7eJZhLRt/6PDpxSEhudU9Bq2mZ6SqGLkA
	GrF1sQJoCSiLpyoQZdCxrGtYdse2nkIA+okJZfXbD28R8k8x88yWzunm3IEwdA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 22 Oct 2026 10:54:07 +0200
Subject: [PATCH net v3 2/2] net: bcmgenet: restore the Tx coalescing
 setting when the rings are rebuilt
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
Message-Id: <20261022-nb-genet-fini-dma-net-v3-2-6e9fc89c0156@tipi-net.de>
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
index e7dec73d5b1c0..f258997f20a9f 100644
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
@@ -2758,7 +2761,8 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
-	bcmgenet_tdma_ring_writel(priv, index, 1, DMA_MBUF_DONE_THRESH);
+	bcmgenet_tdma_ring_writel(priv, index, ring->tx_max_coalesced_frames,
+				  DMA_MBUF_DONE_THRESH);
 	/* Disable rate control for now */
 	bcmgenet_tdma_ring_writel(priv, index, flow_period_val,
 				  TDMA_FLOW_PERIOD);
@@ -4176,6 +4180,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
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

