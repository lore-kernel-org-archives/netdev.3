Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541867;
	b=lvzkSahH/+tqSrQ4Z40zsUSAdgc9hHvi5lN3RYydTljkz0Ynk4TMiU7vlXje31yuVETO
	 XupSFE5WcHIav0fvIske/aTCSei5yRVwetSI4uOLBciqWYSBZXskkQtT0OPX6cPNHUlsB
	 qbxH+EKpJFl3lyZ0Jr8GJYRGyTuxLBWtfcPSmwWbV6c7F1n1mdZ8y+ZTlsX3oqAV3q5Yr
	 0JjJ3Yw/TL9T7YmCwe9nFeUom8VH7U+B6EGSex3sKnbEcnb0ixwsvb2d1cbG9ra56e6o6
	 NO7nG9Qn8bHPob7ll+rbIejrpTUdTxU2D92KpWhnA4Pgi2ZYopRRTJUf/wzI23CX2lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lt5khUmxw1gOh/n0LWJhaeEcTc68Du7k7RW7yXiy7Vc=;
	b=Fx5WLKGWPgdS5evEfDvLMaY9DN6pr8ICKbna5b625OCw8BTD/+HIwvDBgI6OoP2OEOqf
	 YEvk7v5oyPCl6Tp+uEZaBJ/xZ/CuXpmY9Jo093ty3VwLR4Eo9j2pFeqGOaEOQjXe6biP0
	 xuL27hbQE6QzmOd5NHHUo8rcA5xmXP11jM4GcPac66QWsniRzNzKMacePGYJ6tHGAVSdY
	 AmNVEL/bWUR0aRlG+YkqjJN3sxqUQJzTLPE2yp1fuU7LDS2JXLkoIBXbS9EbvFwq0ODgV
	 uNWgkw2Li4ZkEzCOCj0c9oqzcNrKk+ZvxhGYUQ6M8Nt2Y94BR9e+N+DhQGtm73+fhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cQKJTXtP;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0232606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0232606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cQKJTXtP
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd69954c755so58355a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541866; x=1793146666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lt5khUmxw1gOh/n0LWJhaeEcTc68Du7k7RW7yXiy7Vc=;
        b=cQKJTXtPOqOBfFDsdmTJkZ2OP3TUQ+Y7iAfiMLRmfMLaIqO0Erebw7x2fl65rR0bGh
         sbjaFbYwRmB6kLa0h0kE2q74WqZs/o3MZgPrRBnZK/rL+g+zM/SRNseY288b/1ROKBxl
         fNq75cihBGfySJuNAyMTyIGgm0wu65y/Cxiwj+YoX6i8mon51QsSMEGIAdNdpR5WUP3j
         1gfAx96eeFXrJCoNlqPqr4aII+X7Qj9c/MobJv8GDGKk9ZbJdkm/pJeMowAnJFViHZ3n
         hP+vk55GI6uy5SEzGFn0ALTe1QTHOY4KceT31X1uYHu74UsvLASz09PFWJC3ADKKF4R0
         yeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541866; x=1793146666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lt5khUmxw1gOh/n0LWJhaeEcTc68Du7k7RW7yXiy7Vc=;
        b=aPLEDGTWZZRIkrCsSfgYFbA/myFd5t61R7AzBo+YPx5ap/Uvdu+c0PYpKKtnK0Di6A
         85nCKzLQN6AmB59qXbl3RNR0D77+WyaItazG/rbWwl+loMGwKAncn/w4thtvoa9Dcozt
         +Xb6JHsjgeud7vSK0a7s+cPbKZFXMPbMsTZfkmV1Rvm16mUgqAdoCFfykp3nyFkNYRmV
         ri6tlR9FZkFXShpq6AFdZLVczoSC4LrTAQVTm2fyZiVt90kyE23tkkqMOshUiQFdQaQN
         +B2clamJZiH/xNc9V4e0qCxBzS1PzGL/PQ52wwZaf8lM/xFoeJLPegbnce4p8jemSV9e
         o4WQ==
X-Gm-Message-State: AFq9FYJZmhUK8W/oCHDL2/CwQQRX9K6GY0cyC8MGJjiIOMXK01sld+9g
	0PdKNrfz9w/ZLnypZg1ZORCa1+2Eb2RAbfhhUMv8IrFY9AIQJvcGZMPbdXQWqA==
X-Gm-Gg: AYBFou2/O+KJ1kPXEJBDg9fhLnxUYjEtfVq3xD4IU+qoHnYCo9b/IH27FszQsFbII5s
	EhZuDL1lynzcfu/lQXP09sReAE/Ia82y9oJvThS1P40GES5xrwWpJBgGe+gW0++bHsMAcFslW+K
	j2RQh1cm157ecUZ/i9fUfv4F3mXGb6heIKeDGP2CYzxw2t1tvAo99dnDicLv4ArPqxZ9AbmZZpm
	ktcvs7mcM9vUffeHuWV2e40az15tbvtWilaJ0jvskYWsk0zxdNA9PISvST/COVVRcA8GkND7Ffl
	WqqGXC8uVXKL2aIH+rb/j6TQqTNY/ntEU/UYz6/jYWwKyF0/vzFB1+CwU6Qeb7HdKB1o3556hke
	Jiyo2Q1Ec3QfhXUw4TceHFEdXieZMYeuSVMibUP9og2JWRk3zIrf06SeJryXjHKVCzQz2mbUFL4
	7mQvBMHQ5SJP1RgmT4mTSkqO/4E2y0JPiOpm82tzVEPumVxX0Sn4mn/7gqsro1xPyipbSZDb3kn
	b2NH5Yh70T2h/ex1KN0p23c8R0C/OrN7JtDbuwsTGFhCk8mj5OL+3JeEYgNTbhgThzYjiiU3dO9
	v6qwU2t+3WK59h4yTSO25Y0SDhOW1fHBn5QyMFefoK32VU+XCDlRgIwmnw==
X-Received: by 2002:a17:90b:2f85:b0:3ac:53e0:4ed5 with SMTP id 98e67ed59e1d1-3ad86f6e8camr387246a91.39.1792541866147;
        Tue, 20 Oct 2026 17:17:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:37f::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f38df2sm547894a91.2.2026.10.20.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:17:45 -0700 (PDT)
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
Subject: [PATCH net v2] net: bgmac: fix TX DMA unmapping and slot cleanup
Date: Tue, 20 Oct 2026 17:17:44 -0700
Message-ID: <20261021001744.2042320-1-rosenp@gmail.com>
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

Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
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

