Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80844DE737;
	Fri,  2 Oct 2026 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953413; cv=none; b=HmBK0294a/BQvm5ngZpXnQwLeMrl6JCQjnmr3Mqv5edjouPMUbjpOhrrvsc5HQ0kgZlpSPzzuU5Li9sAsfhn12U398JcIX0IfsGYfUBnXbYdUdJILEpP6Ptx+XTLWHpSVmf04y6FFLWfOaB23evAhIZD+IPpcxuE+OMKPQQin/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953413; c=relaxed/simple;
	bh=4KLA9OJvmvuSa485Gzsny8g07GsFmDIKMo5GrgFiPxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6Wm9W6n65sjLpTLfuKKdedDizdJb/fmZjN09MDeYLFBbU8YiIebFInSiJtWnel2S3QXJzs7rO9KkB1rq9snKjx1UMt3xEM5R6kmEPi6Q13UqkqS8j7plYrJafFdCRWuIyoJ6IZ1cR3cDdcUEVu1j+2U3rjiHm30QhvmRydcl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=JGm3H5VS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="JGm3H5VS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF6C5A4B46;
	Fri,  2 Oct 2026 17:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lLvSKGC79y0brzebVjlj5NfPZhe8xVaq6yqEVF+zh5A=;
	b=JGm3H5VS8FYo0VaqlDT2++N1BMfPP2u/dsRlxbqCFwlhLKkCmaC3f40tbs7wHBZLOXuTKe
	uXSnRu5x9ndsuMjPYUxlsIgXC2uMi/u6/Zj+b63L07GXlLmGctf9yR6WURjjkaJ4FL/cuc
	u1gq2mzbzsUc83rifbN82xFT8iFNsb5j2Dc1Y01rurgm8t+O9JH3mO7DBRYJkvakF16s3Q
	jYqu9WyhSfhSRtoQnKOmT4CYTImkyKR8IlDRf0b3SiYK9+KDme/w7Xyq2vb6xiUynYX/7q
	1sIHTqM6M59/7Z8eIPmH0gPUIT15YI5xzrKbFsd/A2LxMoAOvpy/g1WyEdjilw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 02 Oct 2026 17:03:21 +0200
Subject: [PATCH net-next 3/7] net: bcmgenet: rename ENET_MAX_MTU_SIZE to
 ENET_MAX_FRAME_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-nb-genet-mtu-nn-v2-v1-3-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ENET_MAX_MTU_SIZE holds a frame length, not an MTU. Both users program it
into hardware that expects a frame length. The name is wrong once the MTU
is no longer fixed at ETH_DATA_LEN.

No functional change.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d89ae6599760..5cb3d25482a0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2638,7 +2638,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 			     UMAC_MIB_CTRL);
 	bcmgenet_umac_writel(priv, 0, UMAC_MIB_CTRL);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_MTU_SIZE, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
 
 	/* init tx registers, enable TSB */
 	reg = bcmgenet_tbuf_ctrl_get(priv);
@@ -2744,7 +2744,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	/* Set flow period for ring != 0 */
 	if (index)
-		flow_period_val = ENET_MAX_MTU_SIZE << 16;
+		flow_period_val = ENET_MAX_FRAME_LEN << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 86f2aed20dbe..501dd1256693 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -28,12 +28,11 @@
 /* which ring is descriptor based */
 #define DESC_INDEX				16
 
-/* Body(1500) + EH_SIZE(14) + VLANTAG(4) + BRCMTAG(6) + FCS(4) = 1528.
- * 1536 is multiple of 256 bytes
- */
 #define ENET_BRCM_TAG_LEN	6
 #define ENET_PAD		8
-#define ENET_MAX_MTU_SIZE	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
+
+/* Longest frame the MAC must accept for the default MTU */
+#define ENET_MAX_FRAME_LEN	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
 				 ENET_BRCM_TAG_LEN + ETH_FCS_LEN + ENET_PAD)
 #define DMA_MAX_BURST_LENGTH    0x10
 

-- 
2.53.0

