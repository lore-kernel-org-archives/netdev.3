Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70F340A6A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365233; cv=none; b=kI8VxGWeovZFOA3w5A2/11r+1gtzcMoaf1siB3dt2B9jME6IEj9Tl1h5xSnTpubOmhKa9xClsTUT5N6ey0IKXFsb8snAEURTJXy0yCWTzP7p7nsNZxIh4Y3eNvTdx0sq0Y3BPNHW6G5IKajeXHtbE8eAKblteV/gFMndsnqnQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365233; c=relaxed/simple;
	bh=H+S/vF7zqBlmZmD9v/uR+QGG8M1L5rQ9//Aah8cWcGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6+fvy0Wwbf9vpWwQnKZ9wkQVg73b3YKf1/wnSwcn3Vpk0c3BjyyEh792c8lytSKIjyYyMJuBfc4TCH/RNyru71TI9SOylT7rWVuv//FT4ZtVrqjZYFtJbTHX57hCOVZxYNFSOjxz+crY5fP2k6xkTRPPB0Dmjh3PMVRXAAYDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6swpvV4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6swpvV4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so1185312a91.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792365232; x=1792970032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vPqHr+Gg0B5YUPN0hepny7OsCrNhKrVgDwpy9W2Jn9c=;
        b=M6swpvV45jZPtM9cKPK+0su8gNDsfv9Da18tRU0YTB8P0ZEOgJQosmemrLcHii7y4K
         I1tdMXUexVjxZhwKTnVdCpH0T93Ft9+qKQq55MmVyJ1KpUGoh1j3qD94/rRnA3LnWBEq
         nWLIciJSiYuQfWqBfTmnmVs5GBcoMscoAwlJvDydtEEbzkH+NQHmbB9GpeJ9E7CvdvWf
         gxxbPCPgKNX0FC8XrPa/VQ+c3rTxFTdCYR8D1N8w1fO7JbCZfovqj2olIYAiU6FYIpkT
         btQOCHdguIlqWQvcmfJXC2t8at2alcUxD4dr339SpeheB+fo81DZsu2zFtpFh8YhPWgV
         8OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365232; x=1792970032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPqHr+Gg0B5YUPN0hepny7OsCrNhKrVgDwpy9W2Jn9c=;
        b=Sp6hqFHkMCDLs0H6DrdrY2DpT6P4rTqd7vzoPgxZVIJgVBzHWoVhDSC/1lum35hGZo
         RFNO0jsbPmZid7HqfugM68mV7Bq/KOH7X7hO5iZvfbFMeCMZElgDLUuWKZhkQDAEHc8F
         BlgvkkHgklcchSKarcSpm0o/Lq542SZCQOb5qQHJ5tVtMVzmerSwVyfludB+bzcz3oEi
         jx4oB4xHLpuo5MxZY37dySUTOiEa88geOsybY9w5O6hjeNvGZNB+apw7whndG3sDWnIg
         9NolmaWjs864F608j+Zmp9qyBJquMd1g3vmgkyj/AgtKlmobecNW+AivTrXtA1ZSDq26
         Fmcg==
X-Gm-Message-State: AFq9FYI69ls7MuN2B+gKr0HGvT/xtlJVy93v9wsgLrlBkx3dAZX6RBMF
	mWgcgQ1T+wK6ULAyh8rfO0vFgpM9wlcwl/XrngZcKHu0J4kFkBOfUF5ENEhj8Q==
X-Gm-Gg: AYBFou3rruQrYaifE8mcp61dwbLbPbuk+LkvizjJGGyNq+V0yXiG8NW8lzJbnZi9sL7
	WJQctMOwhJn6FtqEwf22KDY1SxysB5wAgmnrt6m7qt1zBvtSqEnwpeDdVC06cHOI+LAq7c7Gw3r
	KWtlkrnFViPVZG9o6WbJY0dRuYT3oiH6OXkXnJG0puIv8lZtoq4EZ5LsSygXF7n19MVuct0A9ID
	LokIXsllbP+wTJN5ReXsYULvRo/6e0QsH7+ZHqIJHawe1x31JjTii7dWGyt5zaQUrnJ7RNfIo5O
	9Osf5mpftlhGLo6p2fzczzL4U6s6d/18qOIU3dJLDWLIK5w5AgNt50GprAMApCBnzRxuoQTnGwP
	i8NcSwmN0Yxbxk+JZsPqcesk8nMoVEMgQKsDkxtXtutNv1dmO3tGbE+sdkovF/bBXaCPaSCP9M5
	ndW7OJg7v4SKHhn1O4Qaf/JQ3j8xCP+vVViBMwdPYlxT6N7rW1gEM/vycx+BmnOlPe4mS/arymh
	KJoebfAXPBMyVLreIHm4p4tN5+dQBjZHQE2OhIqLz8cGlq2YvTdJTMM6xLUv9KNrvBEdhroFzre
	VKwsYGlJWMUsMFL4EQWqRHTnirMSwhDTdmXrZiKTqF3479z+Gg==
X-Received: by 2002:a17:90b:2f84:b0:3ac:7613:1ec3 with SMTP id 98e67ed59e1d1-3acef29cff4mr4311436a91.37.1792365231878;
        Sun, 18 Oct 2026 16:13:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc492fa54sm13087225a91.13.2026.10.18.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:13:50 -0700 (PDT)
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
Subject: [PATCH net] net: bgmac: fix TX DMA unmapping on fragment mapping failure
Date: Sun, 18 Oct 2026 16:13:48 -0700
Message-ID: <20261018231348.36884-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mapping a fragment fails, bgmac_dma_tx_add() unwinds with the
wrong slots. It passes the failed fragment's slot->dma_addr, which
holds the mapping error, to dma_unmap_single() for the head. The
fragment loop indexes from ring->end instead of ring->end + 1, so it
unmaps the head a second time as a page and leaves the last mapped
fragment mapped.

None of the affected slots get their dma_addr cleared either, which
includes the head slot when mapping the head fails.
bgmac_dma_tx_ring_free() unmaps every slot with a non-zero dma_addr,
so tearing down the ring unmaps these addresses again.

Unmap the head and each mapped fragment from their own slots, and
clear dma_addr on every slot the failed packet touched.

Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 1835266fdd09..134eff89f787 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -208,19 +208,24 @@ static netdev_tx_t bgmac_dma_tx_add(struct bgmac *bgmac,
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
 
-- 
2.56.0

