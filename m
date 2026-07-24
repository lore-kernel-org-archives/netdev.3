Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F44156D1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913673; cv=none; b=fOrqXcC4YT8wGywglmad7Oyb8fhwWWg6z1aDE9DeraeE2SE2ghFtCQVHyUDhz9vnloJ0zW13Xtm/Wm7mPJGh9alBKrZ6S9XsvPfH8iLh+ZU1N+95zWJCZtCU+3Ia/nRW4muF6OKqqVpw5xjGpCiPvhSB1pw/r/nlkdONFMGq4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913673; c=relaxed/simple;
	bh=qa6wpGjFP9WeSlXBpjHlwN1JQgVBXHAXD1d+y65qczU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3Gu7CBpHbiEgh4nBUihipSbP7+GHrKirMHIv6EsVc86/P1a8v0XtI5GvJfUI4EDj7XhwX98NmbunBeki2eWXgiFczLI1tdb9LB8/6LMfpBSb8+X23E1WhRgAjRV3vppT4Ifpp4b+a86u0BoiZD9H4DsKirFNIUi72N9OiQc5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojKkINV3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojKkINV3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso493850a91.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913669; x=1785518469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTgp6kjWgEDWWxpibus58Be09s4GYwLwxPakbsp/HLQ=;
        b=ojKkINV3fiV0E7L6IIaOkeRBuMQdppy0BExs5UxLfALeCDO4IzjTNulGGCHZgDCE1M
         VG07mynx7fw6c1YFynWxELNncobmR8q7ziGXlNnBj6XnWkk9iBF2uNxPtt0whi9WYki1
         tUP9kG1x7q0gUoipJP6Dz7Hq8KCmHPInwoez6eTlrNVW0xnEAknx2wsE/e9Vg/Oa/uez
         n+Kxxbl/D7jhD6Gmwcb0ILtVmuljvsY5fXJKaISBy3U0ZmeGVGRFOaabTZsLObYF+gWH
         I50XwhKdHZnA2GfB4dgg1oydeGMEgHP+gp0QJM4/uGr16//DVfTs9AH/ipP9+0tW1Cti
         8k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913669; x=1785518469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTgp6kjWgEDWWxpibus58Be09s4GYwLwxPakbsp/HLQ=;
        b=pJO6pJCQtFz1EKSkbnEhbsq2k2CWcpzIfXwVAXKT2ZVgTGTgBMxzmyRMxFgXJt1s9t
         v+Oj65uExcEDpmOvEWsBNCzTbwJtmhhS6yhR+KcEbu0s/1mPbwg8KQSg2Z7zO5OB9Pa/
         Kzu3hb1osxMZOewXQhrRBaSeA26GH+U2U7WGXxODE8oMVCnE+HKZqDUQyiwr7lO0SUDO
         8+qdUjuPs4xZfIFAnZtc0/G6GxY4J6yWkcg6AjZxzHipX362hNcS9EmC3r1+fdZ40rPT
         0lL3tam4V/jIzvVkugwZQDo4vEeJpEAOy2ZXzzTNeJsJ74pRKjMYhls90ndm7wQsD0MF
         Z49A==
X-Forwarded-Encrypted: i=1; AHgh+RrEXBybpo9oCSj3BtZVdWjgkHoixPr/7tutn4+CnDjdAevkMGNNIR/9rQ5e8iR0wDbemt6l0rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5PSOofCqA2syDUkMYXO1yJsQjorDlXmLrplmmBJ9zflfjPpS
	B1hF49YsGikhWXAga1z3fHlNTEN9sbgu6RDqOIXOkOQsnl+ux51dsod7WDATdgiR
X-Gm-Gg: AR+sD117qjazbkbokxc0+LLdAYBsPzCA+zWilAjpCs1B4v5ut+g7fd0fVfRlNaQk+Ey
	xItmvlxSze8nksKvrBPov7KWnJrZi2DUVDbcNT2R7tgYIFHOAcxfo3tvxGPdxxh4Gi/TF46k6wO
	fMGJIPcXqJB18DFbBTdU1m1QlB8IRIh183K9w9Dhd6EBxK5kRXLrd1EyaBuHXCQKqh0ycD4rA+s
	fzznNLC1pTYTpugW80gEjr8YzCu16amsp+s2WFyi3FqaLqmntBODQ+YLE528KSg3HZoFnhZrXH3
	WDr3LKwm2bw6AmNgfQ8QCceRj8BxrSztJ40w4GQXaK0MKzm3O3rSZTUU+zL/0CjADR7Hix8RcJ2
	snYy/c5bj594kvAxMFrTbPpj0cAvsMdtxEga99Tg3iFoeBwbC6Jo9yag56p76C6mStCbwNyc3Bm
	5Wh44XECJgXWB6j3LRqT1glLW8nBDYhspPeeHC5FMqD34=
X-Received: by 2002:a17:90b:4c:b0:38d:c74d:29c5 with SMTP id 98e67ed59e1d1-38ec69a9a7amr8004002a91.19.1784913669362;
        Fri, 24 Jul 2026 10:21:09 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041d5f78sm1789907a91.17.2026.07.24.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:21:08 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net v3 1/2] net: ethernet: mtk_wed: skip ring reset in wdma_tx_ring_setup for WED v3
Date: Sat, 25 Jul 2026 01:20:39 +0800
Message-ID: <20260724172040.1653-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently WED v3 tx wdma ring, ring reset happens in a separate code
block unconditionally.

Moreover, v3 has double the size of wdma_desc and has different init
values. mtk_wed_ring_reset doens't deal with that and would corrupt the
wdma_desc.

Fix this by skipping mtk_wed_ring_reset in mtk_wdma_tx_ring_setup for
WED v3.

Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
Changes in v3:
- new patch addressing WED v3 ring reset issue raised by Sashiko
- Link to the review: https://lore.kernel.org/netdev/20260630144831.1109-1-hujy652@gmail.com/
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 10d9beaae372..7d2775a97fa0 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1938,7 +1938,7 @@ mtk_wed_wdma_tx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_CPU_IDX, 0);
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_DMA_IDX, 0);
 
-	if (reset)
+	if (!mtk_wed_is_v3_or_greater(dev->hw) && reset)
 		mtk_wed_ring_reset(wdma, MTK_WED_WDMA_RING_SIZE, true);
 
 	if (!idx)  {
-- 
2.47.3

