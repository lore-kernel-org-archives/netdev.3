Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995F46DFFC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141988; cv=none; b=QdfXLc+etBKPskEtrlHVRCp4Pw00XeW1CTnxejYGTieXp6nXOSZpHuw+uST/FRFwY7lnxGL/5eY5qBXgseS9JU01GmT5BS0vR5ZO6bDplx3y/VA3epYIwkTEorsMBD9TD5Huynf6EFChvkFXSl3yQ05YonVtluDf77cDoKsCfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141988; c=relaxed/simple;
	bh=U6JZO9nx3rPOiVZRdnCq19XQmBvRUGHPkux0rhIb7wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhP0Di6sMqaeUnGZLEsHGvKWP806622pJO4w15bD84IlQEsRJxChoTKtS6aSxtpstOpB3epp8ICtTHo9Y/4Au1Wy5S/2Kq7/lgiUZeuvfkABr6xkJUqrpEyYbfbfC+xc6ed61Ba1CI3poCUPy/HMcBCZ5XW6jHrnKQIrWzBmuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwWWzdee; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwWWzdee"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1547753a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141986; x=1792746786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EEa/2At4h8ZJit76fcYpbi2gFdx3R7gwg1DXrCjiWtw=;
        b=VwWWzdeeBUT3qf/T8/SNKFJBHdu/YKHGO67uAQ1e4HFQ5hmPQQ5DnvG/10T2l1SYMS
         iJDBjtLYEz6dI70DGpdndYI3EhwmOYZ1EVrs5NLcwTQdvbjmDV9uKzJtVBWWfH2onQ5V
         Luj7M6ItfwOl5nbBfO3ZjRyeqUzrtxVDoodyoqtK3ZcJhE0VUT5wEGdEoK1b1XmX6I0W
         6RIlyblFExR6LnkVTY8BZrDFV+GxhuEZeS9ZxWoM7UHmc14hhx++iKLi71dzrbIljjE1
         8XQPN0K2TVwFzHZEhLHRFAZ5S9N6Q/zg0guqlUhZAbGpmI0S3suW4o/bRAg7zSUTWETO
         Ak+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141986; x=1792746786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEa/2At4h8ZJit76fcYpbi2gFdx3R7gwg1DXrCjiWtw=;
        b=BB7seSnwIw/1cHpxZNR6Wgw/CRVUTPUAOo01moJJL7X8WhD4NRnjTQXh1EjsZNc6oZ
         9sk/4TMJT3fj5krkjYPB0lj5zf4LTQMbJoe8hRsl/B3oQjn+HELASGvHUSt1+22U65V7
         bRull2VlWkWdD1fqZoEABd8rRzQkF9hx8mwdGmd3bU/pi3vOiVNsfozdd47nnBMEtmqg
         zHdhuF/aeH5RongRJroWL7zNh+pHCYxJbviK2+hdtr8TNVU5IXGspboPTfyMqAIaXQc1
         duSRL7JaqzrELqcic2gT+QRpkM2K6y6ng7W5gHoJhr3TV74ZauOZYuBJRTDfRNkFwlNy
         gH7Q==
X-Gm-Message-State: AFq9FYJagv1J7wtT95LFXUx4dHkwz4WU2XgCWrSlHTwP41z9L/mXIL91
	cLtFe2gUSVqNDs8prI1Rc/7YFnvQ6wRcXJmtOu+YMxnKkMNlvZjCrdTZ
X-Gm-Gg: AYBFou2D/+VGcGN+UeJVUVFdLlY2IELOBZ8GaJ/NWWpE0ys9phEejBHjs+96Lr9vclS
	SoeJ6251pce9Qc5kcXTeuBJbbS4aa9nFjOpOUXjYhO+r5GopE94Vmc7HfRBIHlL85e0LOaVA4iz
	/rH86MH9vQeR2gdNHkHG4EQ7BkadOEWPbgF7OglUAJz/jJsEchDbBC2XceYKBx1sTAjyOFkSDns
	csc9JvJBVS69VVpaQtoj8YNs+5A4oQKZYNiWZFVRYagGP/NU6eUpvcRIF1YLRNh10azCzWPohiX
	S+uV27hOg079YPQLgDMjfGHGTa2Bf7CG/DWfSCQHf8AYFd2osaqDC4vTzZSsE7Omq+PHkD8rUOx
	C9uGjSuUm0zF8PSWwNg0MP2eb/4co6tj2UiUGlcvWwdpC4kLBepaURopOe3lACJiD68OIX1r5LP
	emn+DkU4J7/A29c4lrigdQS4Vh5mBldWxNM6FHzwkgxspdoM9yApFpLcKsuaOvl2bGF8bzF9ote
	015erHT2s2LcF/Orubmuk4STlCnhchP5szuou2ndbdcNh0QXPOf+7bVdjzw
X-Received: by 2002:a05:6a21:1bc2:b0:3dd:a197:7368 with SMTP id adf61e73a8af0-3e16c0b3393mr19115807637.65.1792141986248;
        Fri, 16 Oct 2026 02:13:06 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm767274a12.7.2026.10.16.02.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:13:05 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Fri, 16 Oct 2026 17:12:35 +0800
Subject: [PATCH net v5 3/5] net: ethernet: mtk_wed: free up rings during
 detach
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-wedfix-v5-3-8b02e78fd34f@gmail.com>
References: <20261016-wedfix-v5-0-8b02e78fd34f@gmail.com>
In-Reply-To: <20261016-wedfix-v5-0-8b02e78fd34f@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141973; l=3046;
 i=hujy652@gmail.com; s=20261016; h=from:subject:message-id;
 bh=U6JZO9nx3rPOiVZRdnCq19XQmBvRUGHPkux0rhIb7wY=;
 b=nho+TYyw4v1ERH9ayHCtI/6QwLa6MGM/Qf8gpXAuCuRUXlco0OF1n/jItA5a2GBAW2NuSlqtz
 6PqqC3ACTmFAmO1YrmJ7m8BXbsbZYKG9hA4G/3QUJ68hCZj+vVdi8Au
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=AYHrGhtLNb9z7JIsGOOYWmKKIoVPH7ZZgT+CLIDMuEM=

During __mtk_wed_detach, rx_ring and tx_wdma aren't freed up.

Fix this by add them to mtk_wed_free_rx_rings, also set
MTK_WED_RING_CONFIGURED flag in tx/rx ring and wdma tx/rx ring setup.
Only free rings that has the flag set.

This patch is pulled from mtk-openwrt-feeds to address Sashiko's review.

Link: https://github.com/mediatek/mtk-openwrt-feeds/blob/main/25.12/files/target/linux/mediatek/patches-6.12/999-wed-04-Fix-reinsert-wifi-module-cause-memory-leak-issue.patch
Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 3f0be70c3f14..b8264435acbe 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -949,6 +949,16 @@ mtk_wed_free_ring(struct mtk_wed_device *dev, struct mtk_wed_ring *ring)
 static void
 mtk_wed_free_rx_rings(struct mtk_wed_device *dev)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->rx_ring); i++)
+		if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
+			mtk_wed_free_ring(dev, &dev->rx_ring[i]);
+
+	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
+		if ((dev->tx_wdma[i].flags & MTK_WED_RING_CONFIGURED))
+			mtk_wed_free_ring(dev, &dev->tx_wdma[i]);
+
 	mtk_wed_free_rx_buffer(dev);
 	mtk_wed_free_ring(dev, &dev->rro.ring);
 }
@@ -959,9 +969,11 @@ mtk_wed_free_tx_rings(struct mtk_wed_device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
-		mtk_wed_free_ring(dev, &dev->tx_ring[i]);
+		if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
+			mtk_wed_free_ring(dev, &dev->tx_ring[i]);
 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
-		mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
+		if ((dev->rx_wdma[i].flags & MTK_WED_RING_CONFIGURED))
+			mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
 }
 
 static void
@@ -1885,6 +1897,8 @@ mtk_wed_wdma_rx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
 					 dev->hw->soc->wdma_desc_size, true))
 		return -ENOMEM;
 
+	wdma->flags |= MTK_WED_RING_CONFIGURED;
+
 	wdma_w32(dev, MTK_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_BASE,
 		 wdma->desc_phys);
 	wdma_w32(dev, MTK_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_COUNT,
@@ -1931,6 +1945,8 @@ mtk_wed_wdma_tx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
 		}
 	}
 
+	wdma->flags |= MTK_WED_RING_CONFIGURED;
+
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_BASE,
 		 wdma->desc_phys);
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_COUNT,
@@ -2504,6 +2520,7 @@ mtk_wed_tx_ring_setup(struct mtk_wed_device *dev, int idx, void __iomem *regs,
 
 	ring->reg_base = MTK_WED_RING_TX(idx);
 	ring->wpdma = regs;
+	ring->flags |= MTK_WED_RING_CONFIGURED;
 
 	if (mtk_wed_is_v3_or_greater(dev->hw) && idx == 1) {
 		/* reset prefetch index */

-- 
2.47.3

