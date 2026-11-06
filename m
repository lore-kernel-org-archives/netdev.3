Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955992;
	b=gjC0poq9xPnABFB5eqTrZsI6LspLiZRxBtsBXVLi/48QHOPVZSrHr3bRd2mVhCXZ3+Ln
	 +aQD2IjzoCEN/q5N762i/Ku+VWvPtIJ6z3N5ydtVVkGN9tjkYpsAn/oZkKVme1+SvK19p
	 9OH0XS99emvYhUXMkydKlrAuWmokSELjUdU3p8mo4VPM1hvkdC0UdcSjTKnyNA2yym4q3
	 z2GgLXKO4CosHBten2cmB1rU2debD0GyECSysVR0PD80RzkxIZHioWi3PzANRQomtmrwm
	 QQqS6AJcQE3NlxZWPQ6XkcQOiwpyQYtRNyUW8LvCR5luTuzub3TS+sBj8BCFqW0r4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955992;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=FFBN4jVBSpK7+XAViyBm0X7EI9kVp/5kh3B0b5bkumc=;
	b=Dgb3KxthH1r54bIndURMZ9kQHZ9K8kHViTJh8R6ObonpvZnbgwGKrfskM6h0IyOFuTX6
	 c6pwtHV6q3VOeQ50ZA7KGafMR/EO8hl+hk/pNcNFyyr0fHf8gERM0BGfyq/rEmKz/AZmS
	 argtrdymsQ4P5QSTs33/ttfP2pR/96Xp1nbaFaBMEaO0bisPtsl31dQ5H9F0E3I18WVZv
	 9GbOuttsH0y3hNPXn0CIsGF2Fdx4ghkQVCkLXP+EwXUNb+615kchzMu7GIho5HJOLpese
	 9XqZbByTZNv+68F7ffxbLyNI+2oDJqvIbCANQpz9fiddUAe9r9T+MhzPLk4Zm4Zl/3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YkRuuNHv;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038B606A32E;
	Fri,  6 Nov 2026 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3038B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YkRuuNHv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FF
	BN4jVBSpK7+XAViyBm0X7EI9kVp/5kh3B0b5bkumc=; b=YkRuuNHvNhMIy6ENW+
	0zVNhLi2nyIoq0bJ8U0ltJ/s6SBiPSNCUsfNcZ5Utex9SBoZZVPzALKiQp7kxA+4
	Qr6Edlbul59DSAkjDUl++Htkbu1kFY8y/F8beUBbXdm8hcpXjjU8kVbOMeosFkjq
	t7QasU0l1/8Z7vQrtuhvQ1NTM=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_7hJmO1qqwdQFQ--.15084S4;
	Fri, 06 Nov 2026 17:05:36 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net-next v6 RESEND 2/4] net: stmmac: clean up partially allocated DMA rings on error
Date: Fri,  6 Nov 2026 17:05:04 +0800
Message-Id: <20261106090507.1020751-3-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106090507.1020751-1-dinghui1111@163.com>
References: <20261106090507.1020751-1-dinghui1111@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_7hJmO1qqwdQFQ--.15084S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr45JryrWFy3Ar4kWry5twb_yoWrJr47pF
	4xCw4qkryjqr13Jw4DJw48X3Z0kayFyr4YgF47uw4S93ZFyry0kF1YvryUWry8JrykuF1S
	v3yDC3W5CF1DJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBBT5UUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0gBUgGrtmGAHiwAA31

From: Ding Hui <dinghui@lixiang.com>

__alloc_dma_rx_desc_resources() and __alloc_dma_tx_desc_resources()
allocate resources in multiple steps but return early on failure
without cleaning up what they have already allocated. The outer
error paths then call the free helpers on partially-initialized
queues, relying on the NULL guards added previously.

Fix this by making each allocation function responsible for undoing
its own allocations on error, following the standard kernel error
handling pattern of cleaning up in reverse order of allocation.

Also free the RX resources in alloc_dma_desc_resources() when the TX
allocation fails, as the callers only free dma_conf itself on that
path.

Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2f03600cc5bd..a8401b04d79f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2333,15 +2333,19 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	}
 
 	rx_q->buf_pool = kzalloc_objs(*rx_q->buf_pool, dma_conf->dma_rx_size);
-	if (!rx_q->buf_pool)
-		return -ENOMEM;
+	if (!rx_q->buf_pool) {
+		ret = -ENOMEM;
+		goto err_destroy_pool;
+	}
 
 	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
 	addr = dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy,
 				  GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
+	if (!addr) {
+		ret = -ENOMEM;
+		goto err_free_buf_pool;
+	}
 
 	if (priv->extend_desc)
 		rx_q->dma_erx = addr;
@@ -2357,10 +2361,22 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
-		return -EINVAL;
+		goto err_free_dma;
 	}
 
 	return 0;
+
+err_free_dma:
+	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	rx_q->dma_erx = NULL;
+	rx_q->dma_rx = NULL;
+err_free_buf_pool:
+	kfree(rx_q->buf_pool);
+	rx_q->buf_pool = NULL;
+err_destroy_pool:
+	page_pool_destroy(rx_q->page_pool);
+	rx_q->page_pool = NULL;
+	return ret;
 }
 
 static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
@@ -2413,14 +2429,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
 
 	tx_q->tx_skbuff = kzalloc_objs(struct sk_buff *, dma_conf->dma_tx_size);
 	if (!tx_q->tx_skbuff)
-		return -ENOMEM;
+		goto err_free_skbuff_dma;
 
 	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
 	addr = dma_alloc_coherent(priv->device, size,
 				  &tx_q->dma_tx_phy, GFP_KERNEL);
 	if (!addr)
-		return -ENOMEM;
+		goto err_free_skbuff;
 
 	if (priv->extend_desc)
 		tx_q->dma_etx = addr;
@@ -2430,6 +2446,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
 		tx_q->dma_tx = addr;
 
 	return 0;
+
+err_free_skbuff:
+	kfree(tx_q->tx_skbuff);
+	tx_q->tx_skbuff = NULL;
+err_free_skbuff_dma:
+	kfree(tx_q->tx_skbuff_dma);
+	tx_q->tx_skbuff_dma = NULL;
+	return -ENOMEM;
 }
 
 static int alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
@@ -2472,6 +2496,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }
-- 
2.34.1

