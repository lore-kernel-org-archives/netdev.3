Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D513E44ED
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830918; cv=none; b=PWFCctA7XbK8WHIqo8LK48zVQGtUxrF8eEawdR1kR8y+yTtQDafoIIbDhPOGR1C3maX2MELVpKEf/pxzoLx7ZwlSFdLLxC2w7VMOuiimp6smdFcJbqo0Bya7KgKOTiV/WuaWj6orHgXrkdgThjEHn3M2oB3zdUNc2ikBLUPaxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830918; c=relaxed/simple;
	bh=90Ofd6eGPD8sQlrMDYyWRLUwtEaLELqAOWjog1Cq10s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naGkjfDBhfEeZBbiNIbjq+9XZWTDiiwivEVJqmsq3uXmZACSO3eQTtEd4UnTsgCu57N09d6XeguzLOWpH3sVt1ongncZ4sXTd+droEB8uCFGIMsyyM1f+cqXfHMUzXSiuEl52+I3Koi1VoChT6P+OSa0X38R6RshNKh5N7ogJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7MvSUDO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7MvSUDO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-847a483e344so496804b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830916; x=1783435716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTJrhxBEl3twqdJgMl/PY4mPnQS4A0KwvpKQuTDw05U=;
        b=n7MvSUDOnQrFnxPaViHIow3ZwdCQvi3owuxO7kC5CXGG7lM+64uTW232QeGqRtdGmD
         r7eVpX3KJcgJ2FCcZZzAbStVzvX+avCUYO1QRHe6YR3PedZvvvXBxaKy7EMYS2D5ppUN
         gKD++Xb15jbyH/+QWT1KOMOQWu9A090AjjlIQnKyaZ9dswpKolMg6pGJ1y3zparaPq2P
         yaGPFMksS6ZDR/yfsRox6y8DbmV5DmOkG11AtSbc4XcXgnpxln8JUGMCHTaguc6aqA04
         drlcu6p46vTEf5EY8t1yNxTcvgftLp+YXgHZiDV4m6Q0E+PudcRv1fwGW7BNbrftG6jB
         26DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830916; x=1783435716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTJrhxBEl3twqdJgMl/PY4mPnQS4A0KwvpKQuTDw05U=;
        b=bQCUzGxDrkZOGmaio7A+2fwcsDbJkqe8nDNGjid/0rE2sIZ6AHW6EOAEbR7ljq9LjW
         VaSy3lpagc7oesqGTsikXx5jglOeuxiKSJkKftkbfGW4kshOy9my5k1zg5q0EvA9pjSW
         vtVFnAXY51wzok+rEar+ioEPWXj498hAx/U+CiAQIvwdzvnWnCFlMGcqLq3fUeIC29xJ
         7ye5VvuiYPDzIp3PpbtWZZYPSOM8PEdzEUbCe1u+PEMAuWEhi/njqgGN/Y/WY9sCVbgr
         AB/vTOqqsWTHIBKAQjGw4U619URyru8crpE/fEEpn5MzMsmhnkDH0EsN8TIl3XnL6Swb
         nJFw==
X-Forwarded-Encrypted: i=1; AHgh+RrXnky7w4IzNIlpfqa/i/DWTqav5xoPaiSexzbiHlHL+BjvdoE8KCf9KM82ddy+MFLp2ApfV5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbzYwgprproob/VyT3OwLvOI1RqtnGxlpRSPMn1hnMQWaVlvp
	5wfNiEdZgzMCKBmrGwYezdxCVxiJH3LVp9Xcl29XQyr5ReLQz3Wq0aHQd0uhaddc
X-Gm-Gg: AfdE7clxRZgyYgi2dp9zA4BRdkOYAOiG6RcfDdFjs+cXOENz5MMb4TKkoVlUtni8qE6
	OwvcoknRX1bo4pZH2FkI+IyN7sdjC6USu3/msIueb5QlwfApf6BvH0LhbnDy8Pix91eGjk3Nj2+
	4M0c1RE02lNopmv8XMh0MuO0kSCPIZVRdU/kUjQ5MAuT1/hD8XPEMx02y1mSbF6IeNngzkH++lu
	rcisbc7iO+0V6HlhSDs7MxKLrfzbcRcl2igmze3Rb8cpdRwvpWZifrRQKL757nqjSdgV+AipMH7
	yv5Cf1ynb/GG6d+absZiqXB2M3JNMTZ9wkTfJtCD5jr6DMMIuJALsJs0yl2uf1i7rTyv3Im7p6y
	gFs+uDiWy76WIjvJN2L4BZgSWZiclKucOC8QQ4cMQyxQSXEcUvpW2lPSrwhPQYr/T8KwUUc9x94
	B5rlg01ExOqXmO198rUHqAt7uBt9+5f1laQb05VLBBoyxU3Qv8eTmh6g==
X-Received: by 2002:a05:6a00:85a3:b0:842:dd4:d9e2 with SMTP id d2e1a72fcca58-847a7ed202dmr1411685b3a.0.1782830916332;
        Tue, 30 Jun 2026 07:48:36 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03a6fcasm2220480b3a.58.2026.06.30.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:48:35 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: lorenzo@kernel.org
Cc: nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Tue, 30 Jun 2026 22:48:31 +0800
Message-ID: <20260630144831.1109-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WDMA_RING_TX(0) is required to set MTK_WED_WDMA_RING_TX for WED RX
but on a non-DBDC MT7986 it is never setup because idx is 1.

Setting MTK_WED_WDMA_RING_TX with WDMA_RING_TX(1) is not feasible because
WED still tries to send through WDMA_RING_TX(0). This is verified with
register dump.

Fix this by calling mtk_wed_wdma_tx_ring_setup if WDMA_RING_TX(0) is not
setup and guard it with mtk_wed_is_v2.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 10d9beaae372..2420557f6c96 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2334,6 +2334,10 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 		if (!dev->rx_wdma[i].desc)
 			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
 
+	if (mtk_wed_is_v2(dev->hw))
+		if (!dev->tx_wdma[0].desc)
+			mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, false);
+
 	if (dev->wlan.hw_rro) {
 		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
 			u32 addr = MTK_WED_RRO_MSDU_PG_CTRL0(i) +
-- 
2.47.3

