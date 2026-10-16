Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EE47140B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141992; cv=none; b=AyHfFspaNETwLBqlgrLH0jLEoNyqgk9f8O15Duid3gW61eGL8OKZFpB1cR/2lv+kVnKFp0DTQDrd/n6/DmW7gBVsArSMizAGGgtG5lG9rXZyE8ASmRc5s4bPCpUWqQww5kZIbdX/IUlluJz5QBz+sWwZvQnVhCEbByzUX6HQ32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141992; c=relaxed/simple;
	bh=rUJYQSuI+MzYXfpzfZnBP1kIyuFVh0MGSn+0u0Ma/Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7FSVqzzEqtcvcPy3d6xnU7dSfD3K1+XTCOS+k3YRiEBDPrVKNqWib62tUsEMMQHpXkGqDHnvV03TIXl8Qjt7+jK5X15RtntrY18k/R/AOgJl/Q4QhAtMyvZoR4YULUGkruUl5+GF8SwvGrUCe0ooTWlNb2vMThPGqrI8bvXG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qryOYlQz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qryOYlQz"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso2851243a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141990; x=1792746790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/o83MrjUD3Eacil49PDH6LIS7qqkykZOJ1j61n2I+M=;
        b=qryOYlQz1ki6fc1Gdon0JUpEWMvoirk2Gs/z5hwvW1vVxyI1tYurVKeVBlLEntNXbP
         rh0dc9EJBXHjLq+lUwHsjtHv3Se3HqcEIKtF/2FxVpZy/oT/V4Sd6tntKfbJHiqgssop
         3o3HR8p/huSTj54+uAk9ID4NzTF+iBQBG+7xA69NaUQhzuLcQrYvmOxIVcNQr3rBPOmd
         sI4sXXoIWbuC1KnAhlVgp2XpJxbbAoAornlqR6mP+OcrO+Icf8G/qpX0IjVN65brfPjk
         cyfJ9D7paf/dxgpCGHuLMUa3zPjlUT5Jya9lbfyCD4lfVdsQdIa7zyopqsNH29SyW8iW
         A0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141990; x=1792746790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/o83MrjUD3Eacil49PDH6LIS7qqkykZOJ1j61n2I+M=;
        b=fR9EMzyIMF38f9/wQSovI7vrr7czDww09VKJPy5f6zSkyb/cxLQkljikbpxEe/Fk12
         UMLS6C3SzgIpb8MI1P5+j/6REkQz/lurIjEsbR7AvEgmzPR277+a4vVxYsBPWc2tiP3u
         zTPM08grxEkZJx/940aF1E8kPXOz4G8ehucVFpOYTQpBTr9hcoiE3m5FNMaprbW/zWhf
         LLuZyqpz0isQBtGn5lJMB/5bLsJxrvadIhjR8u8NDj9Wss8YEsHxSxYMiqPcMAJTG2ZB
         6B4YKC2qn6PQvK7gM8/9yqzH5cBlChRxFQ9gduudnhXFWE460pj9cJju2aUgET/TrZ2M
         uFIA==
X-Gm-Message-State: AFq9FYL17w9AxR2UFL8wm9DETA/VzW9eE7G+YCNRxUscbsIlITffN7uA
	3Qe0MDrQZOJEMkXRG//FCjwNK9Uum6KiaGEm7kTpoYmY827zYVweX/kf
X-Gm-Gg: AYBFou0b217S0yrAKzS4bbKmrYYtBryQd5HX5/q2wjzx74ZUUwzu9PmeIAbVYnMFmj8
	20I3uuxd6SHlMUhXScMk9wkAomci9G3Zeo/LTHr2i3kDC8Eg4YLEn+EMFdgtJK7hmHXMH+kQ4mD
	MvbYa/5oEK2boQ05FEYjP+tydc9CSGYFbKnrqLIXLrv/OGC1RuAReil61+AWGlSGZxZEbhxkgOA
	Z6IqlfAY0BkLNvKc/UHvPbsv6XHqnVW7f99nz1xtjsrpd9GHwXQcpuQDX3LfSkGlizA4i0GkMOX
	ijYPgRqslY/keBAR1lbsPng6uROQarh/y22k/5M5Rqp7mqg1wtM5BumXIoAehWOonpx7QtD4ZNJ
	mx79dXogYYZLl+54JcR5WTyIaOX6/15f78/foeJ13upjpDX1CBOSEfSyqIqcdYJqb7Lr6jHvj76
	bW56OPnMRCL358t+HDOdOw8Qhcp7XQRkEIJ6zb8w5g6ZXYYDC8xc4Rv3rZtUqivJBUN+REWJxRY
	GZMItTKrFhM3A8wtAb3WXHlniuGiZEzrZaZgwM0Uj1dtcqbjA==
X-Received: by 2002:a17:90b:4d88:b0:3aa:6b5d:9fe4 with SMTP id 98e67ed59e1d1-3ab3a952849mr18771119a91.12.1792141990180;
        Fri, 16 Oct 2026 02:13:10 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm767274a12.7.2026.10.16.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:13:09 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Fri, 16 Oct 2026 17:12:36 +0800
Subject: [PATCH net v5 4/5] net: ethernet: mtk_wed: setup WDMA_RING_TX(0)
 for non-DBDC MT7986
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-wedfix-v5-4-8b02e78fd34f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141974; l=1493;
 i=hujy652@gmail.com; s=20261016; h=from:subject:message-id;
 bh=rUJYQSuI+MzYXfpzfZnBP1kIyuFVh0MGSn+0u0Ma/Pk=;
 b=L0as7tLnYzXS+Bqtr1fz9FPvuHKDSa9tmnSYahzb18gVgM0Oe4uBm+MqAIXLmIL6GfYKXrcr0
 5E3tQHHvbQZC3w3g8mnFEM6uuaJT56L7ZPMaub/Q74s526GTmqiIVyJ
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=AYHrGhtLNb9z7JIsGOOYWmKKIoVPH7ZZgT+CLIDMuEM=

WDMA_RING_TX(0) is required to set MTK_WED_WDMA_RING_TX for WED RX
but on a non-DBDC MT7986 it is never setup because idx is 1.

Setting MTK_WED_WDMA_RING_TX with WDMA_RING_TX(1) is not feasible because
WED still tries to send through WDMA_RING_TX(0). This is verified with
register dump.

Fix this by calling mtk_wed_wdma_tx_ring_setup if wed is v2 and
rx_ring[0] is not allocated and reset tx_wdma[0] if it's already
allocated.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index b8264435acbe..3a7c2bb33691 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2355,6 +2355,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 		if (!dev->rx_wdma[i].desc)
 			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
 
+	/*
+	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
+	 * but tx_wdma[0] is also needed for WED to function.
+	 */
+	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
+		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);
+
 	if (dev->wlan.hw_rro) {
 		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
 			u32 addr = MTK_WED_RRO_MSDU_PG_CTRL0(i) +

-- 
2.47.3

