Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705958;
	b=FGolT3xKFYib50vH2XAsGKUA+gXZAGukd4t7N2e0//l/ROwOX1GarcDg8FLeFR4DA4K6
	 9/GrHs9sveh8kE8KHjymWW2pBC3TPzDZKrKZ3InepQTV50xnVAuj1Xv/qeiyErxLWGNxk
	 0bXKgiUtYceB5yrBU2QEPrL+SVBz2Un/T5vAyfnZpqLBgBAsNulyZtd6YfCjHrxBDmOEp
	 nScg9sA53bn1LT4PeT3O5AyU0z36e9tEj17R+IyKwOZI9vlTlv27pavxInP4CjKPgClc7
	 m4xJUWJWn4e5aPS5zAhu5ZgqIzmhxIMeMHzXSm73/Nmd8i12JTMdAAs8YnlG+VaJ3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kAZzQudwd0odx3okt+/7lzQEQ+9EG04goXUtaLpNBlg=;
	b=PNI49NRv4IBTKWN+lI4It+kAs6UVvY8VJ28iCbBw5QIfhwd/z80PpPc04Ts8LEBdodBl
	 MHGL136Si6vqPBhtUJ10iqddiF2Fya7xelIH5vqUlVxglV2J7OdQ8GMftxuTmE1pOyg5Z
	 5fDMNVHc2PlRGk82oT3HNsLW+R6jMxeUyZKS0cs2WLtRJEJgvL8WNbqTAjU0vTeNfpvnC
	 lSaTGr5QvjMkf0kP7HPlK0r9Ss1l9/1tZBzQg8mUXGpEgD42A6QJGa9H91eqRC3nvha2w
	 HLHXGR5S1e38aMa7s8QcG9bPsQ4t6yD5KRr5YD+z5FTCioTrgZ+0bztehMvT+yQ86yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ot48Ldaw;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8B606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A8B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ot48Ldaw
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e831e86ebfso1182375ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792705958; x=1793310758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAZzQudwd0odx3okt+/7lzQEQ+9EG04goXUtaLpNBlg=;
        b=ot48Ldaw8MX/m9Dl6m7ceKmUgfdjnnPh0EEIj7F2gdw8sbBzQemOH47vdVXumJOyH2
         s0bf38upKJe8SXGuyxycYLSdE3BfvLXifG6ORSJMNObjh4o5OHXznmQ+jRuvW8KA5soL
         iqTo2LVOZl1TAgAUmvDmog2mmzlRKUn59ZKOR2vaeJigRs9M2FW85yhQgGRXXQzKqtBF
         2vkAtICRpxhXXDBvduy7uJVE/6KhmnZ4s4cgaVHzpPXH+oSz5ciFE7HYUi237LkasF1N
         Le8pHc/qQFUeFwRHJSu6xTBaVQ379P6jyqlY1SVwTt0VW/LQet5CtqNSVl/7UHtl6ckh
         BtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792705958; x=1793310758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAZzQudwd0odx3okt+/7lzQEQ+9EG04goXUtaLpNBlg=;
        b=ZxqY4KacbCvvW55JOqdvFOJI8tLz/PeFvRCiYmtgqXIs8e9nH8WkMM8wkY3BuW+ReX
         pqMGM4waEar5fdkv8cWJ3RUbpO/P0SoKWsNFc7cuH3DsCCT8yLKnrGoUZ9WrigogOlzp
         qpzlcfJY0cvw8aD5nGLdgEcSk5lAABTfocO7LL19eo8LWrufBaNg2RAmtYvVUr86tZ1M
         Nmy9SXz8fhETK5utR0OuI0pS1aZnh4szklzfZmeiUZLhAHM+8fDHqnfIWNwfrjzFFK3q
         0YOirRs5K9sMQ+Exep09SS1vMLm5Ih3wGnv6p4SwR+TQSxPJJym2rEaHcE12ksYOGDxD
         Xg5g==
X-Gm-Message-State: AFq9FYL5C3Hiy/ID2lwjU0Qf3U8XoWspAglLPR1+vPAQIiUBHjlB22su
	QpzVlVU92paYnL0fuUJUM2CYz8lMc47F+RKPmGk1orWxR0V6/AdzofjVPNoVX74v
X-Gm-Gg: AYBFou0dJIk+xCMOhmUk045tCTv+GdOTfSoLE1ygXd8SQT6pKfYcY+JXKMd5f5CUEN7
	ClfY1WLuZEUi/hBr+oDlrsNF08Mn/qMPzzPc0tNDo2Ivpj3h2spQ2w/E53xq99m+CrVmIGVg//K
	GSVMxtkCvDOLmprNt20mQKqj3U8Fq5tJuLzVC0LH/UQJKZF+pvG996ToXGESur0HJdMzPDugV9C
	jUa/vhGe05RK5KJqwz9svJKi3zVuG3NtwnaS9fxe3ZKZ9IDO6vvzqYMPFzYBJNiaNpOwPmL95DA
	PzDdqk4G+svb9QL8Hr2PWoUfBHfvFHqBgIKNECMp0wRKinTBm6gP2sY5EpkAG7qgovdJOyfdbRA
	lxiWMTr+gYMsTsd4/r6C+vAxIubWV95sP031OvURNVuE/qscIspTtJvM5skY4JjKY6b06P6Zyks
	H6AqktdIJS00N6o8Xxm+sChSO+lPdzcU6exo2gYoqiZZGjSxyDI75Oks83zhGNyt+o6YmaptIzh
	T+rq2O2UypMSVLcxSs041x3k8XzODTCOKRPVcYBux81jE/I9uPjSbKkkk6A6JzLY5KqZRHkQqIF
	NxYtcxCKidoPF5mJ7R6FrreTNb1rasjfWzgxd2zWWeSLoXR3SYXHQ4A74Xh238PMd+sKQ01rBzS
	LTTm9KoetEqYuu7a8ZTEytWI=
X-Received: by 2002:a17:903:384d:b0:2df:8f19:5db8 with SMTP id d9443c01a7336-2ea7d1669c2mr4002555ad.59.1792705957657;
        Thu, 22 Oct 2026 14:52:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3b01a6sm3090325ad.44.2026.10.22.14.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:52:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] net: bgmac: fix TX DMA unmapping and slot cleanup
Date: Thu, 22 Oct 2026 14:52:35 -0700
Message-ID: <20261022215235.3692083-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When mapping a fragment fails, bgmac_dma_tx_add() unwinds with the
wrong slots. It passes the failed fragment's slot->dma_addr, which
holds the mapping error, to dma_unmap_single() for the head. The
fragment loop indexes from ring->end instead of ring->end + 1, so it
unmaps the head a second time as a page and leaves the last mapped
fragment mapped. None of the affected slots get their dma_addr cleared
either, which includes the head slot when mapping the head fails.

bgmac_dma_tx_ring_free() unmaps every slot with a non-zero dma_addr,
so tearing down the ring unmaps these addresses again. It also frees
the skbs of pending TX slots but leaves slot->skb and slot->dma_addr
set. The slots survive a down/up cycle, and bgmac_dma_tx_add() only
sets slot->skb on the last slot of a packet. If a slot with a stale
pointer is later used for the head or a fragment of a scatter/gather
packet, bgmac_dma_tx_free() frees the old skb a second time when that
slot completes.

bgmac_dma_tx_ring_free() also picks dma_unmap_single() or
dma_unmap_page() by looking at slot->skb, which is set on the last slot
of a packet, while the head was mapped with dma_map_single() and the
fragments with skb_frag_dma_map().

In the error path, unmap the head and each mapped fragment from their
own slots, and clear dma_addr on every slot the failed packet touched.
In bgmac_dma_tx_ring_free(), choose the unmap function by the SOF flag
of the descriptor like bgmac_dma_tx_free() does, unmap before freeing,
and clear both fields.

This was found through code inspection by an LLM while hitting other
bugs on an Asus RT-N16. It did not hit these ones specifically.

Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: clarify how this was found
 v2: merge two patches into one
 drivers/net/ethernet/broadcom/bgmac.c | 41 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index e66856337d33..55d126c7d35c 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -205,19 +205,24 @@ static netdev_tx_t bgmac_dma_tx_add(struct bgmac *bgmac,
 	return NETDEV_TX_OK;
 
 err_dma:
-	dma_unmap_single(dma_dev, slot->dma_addr, skb_headlen(skb),
-			 DMA_TO_DEVICE);
+	slot->dma_addr = 0;
 
 	while (i-- > 0) {
-		int index = (ring->end + i) % BGMAC_TX_RING_SLOTS;
-		struct bgmac_slot_info *slot = &ring->slots[index];
-		u32 ctl1 = le32_to_cpu(ring->cpu_base[index].ctl1);
-		int len = ctl1 & BGMAC_DESC_CTL1_LEN;
-
-		dma_unmap_page(dma_dev, slot->dma_addr, len, DMA_TO_DEVICE);
+		index = (ring->end + 1 + i) % BGMAC_TX_RING_SLOTS;
+		slot = &ring->slots[index];
+		dma_unmap_page(dma_dev, slot->dma_addr,
+			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
+			       DMA_TO_DEVICE);
+		slot->dma_addr = 0;
 	}
 
+	slot = &ring->slots[ring->end % BGMAC_TX_RING_SLOTS];
+	dma_unmap_single(dma_dev, slot->dma_addr, skb_headlen(skb),
+			 DMA_TO_DEVICE);
+
 err_dma_head:
+	slot->dma_addr = 0;
+
 	netdev_err(bgmac->net_dev, "Mapping error of skb on ring 0x%X\n",
 		   ring->mmio_base);
 
@@ -535,17 +540,19 @@ static void bgmac_dma_tx_ring_free(struct bgmac *bgmac,
 		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
 
 		slot = &ring->slots[i];
-		dev_kfree_skb(slot->skb);
 
-		if (!slot->dma_addr)
-			continue;
+		if (slot->dma_addr) {
+			if (le32_to_cpu(dma_desc[i].ctl0) & BGMAC_DESC_CTL0_SOF)
+				dma_unmap_single(dma_dev, slot->dma_addr,
+						 len, DMA_TO_DEVICE);
+			else
+				dma_unmap_page(dma_dev, slot->dma_addr,
+					       len, DMA_TO_DEVICE);
+			slot->dma_addr = 0;
+		}
 
-		if (slot->skb)
-			dma_unmap_single(dma_dev, slot->dma_addr,
-					 len, DMA_TO_DEVICE);
-		else
-			dma_unmap_page(dma_dev, slot->dma_addr,
-				       len, DMA_TO_DEVICE);
+		dev_kfree_skb(slot->skb);
+		slot->skb = NULL;
 	}
 }
 
-- 
2.56.0

