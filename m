Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BF46AA95
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141997; cv=none; b=lDaPCICT6INJTbvhzV5au13x+XZH1TzR0xhad83r3RqXP81Ih+4idkrZ1AhO4jHqVaXgSAfcXdJ40sZEnj094yu0DcGzpFc1YrYAFsRCYqIH+bbt556u34pJQJCSeGo8zPUQvhwXQFxXqwZ5LPKCcKD1mhZIG5MRKCsxSRc+acA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141997; c=relaxed/simple;
	bh=ePo8kYEQepEUUlHGep4r47dMcAUe+w0OHJZFIANEXVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hf91HprOfjW0tsRKZCx/WL1m2ZmUDXzc10YA7eGzxrAfPKB7wamGeSyraXBeSW/drfUqDXfXkPOqv4WO7chyNv7THAOSkEzqpHTegg3Hy35XTpLH1x6bxmTnRjHOJ7XkqqtyWhdrVwzOMpTA3XNoBf3wYsOpFkeMo6JpGMdtTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGWPkmIx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGWPkmIx"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so3397237a91.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141995; x=1792746795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5N4qyFuyYUzsn7yKUmEA1eVXAS1dMHnjfF1B2UXe6bw=;
        b=XGWPkmIxuvWyiroUGa19xTIVrJYZ+FQEq1q1eqadnzfwg3+dEwMhwSg46fvA65Dpj2
         wwVyA36ikqQlIJ2jUcbin6ug2XxPDK6O5MtL1qVimb8myRSWnzByGkDy1DsVvydAHBJd
         dXBTmxvthMHYCm/nknLJ5wjwwf9vJK+ixG0Jc+Y9I6V9voX7jM8D2JpYKBtfd5YkU/Pq
         TfN8VGUxv/KgP1+G6NHE83cc/Ajm3XmchiHYmyCD2+QK6Gy5bY5+LyIZ25NY8j666GjE
         u75HQ/Qls9lPSmRTIyKTrXf3z3gp0C4Yo+9zTWPZ1wMiYR6Unacg4J0izbtbrMONZ3N0
         I9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141995; x=1792746795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5N4qyFuyYUzsn7yKUmEA1eVXAS1dMHnjfF1B2UXe6bw=;
        b=PBnWUqaL2cAxDylUwsJ9bYe0T3AV9BLdPlDPt3bWmLCL2flZKdU1MCzlOXT7KaZ/vC
         bVZvkiURHCSdiqqZ25wvzeVCJeUrO8m59aghuZp560Lt3I+O9T2nwK88LQ9d0FDxuHvH
         j+roCzOnk1x6celSUi7mCevI2EP2pmqQCyR+49DVlb31C+5Gvm4hJIN6pZVZzY+n0/81
         6mKetEVl64FOc9eJh5T8s/lR19joBVht1j6Ru9CH2QYcQwZdyOSzOzD89/Z3OIMoY2lc
         Vi/AxCS1TimQyzvgrbpwGBpQON1HHOcPZ8QB0eEXrnUfUfyQOLadAYm2+xjLqCpt5cif
         1acg==
X-Gm-Message-State: AFq9FYK+PDzfDeGc7vk4PmQxMuhtJDoSVJrm1QnKKivcEldOP19XGfL8
	LlpHazfDf3pNkJjG7pKuL5qbRwilEdHn+Sba56ubN5EVm4bG+a7Y9Aj2
X-Gm-Gg: AYBFou0DzId/bmXeN0Yj/Ty5dUCJuXuI3eQ+mwDp86BrSQQ26oviv8vXrmjAzMEI7zv
	0k1XG1PQ3vWHVEpNJrz4AMCS3cAXKlMaTXDWvFEXAGe7lbGw0bXrKLZKEcb61pvUImbkKobiKiJ
	nO6Hyf/gP9COVLpZRkPGY5+zWBpYKRZszRzG0jUmfAPV3mMTphFWPgx2inucZWj82Ar/NSAbGJH
	rewi39hAvthk5KWRYMCZhhp5Roprru2ZtPLUMaJhteRfumSVYeGPujNxDdGfoR24VdcbIKDk4ao
	Y5NMJJ0QrLJVK5Gw8Mh21NUeoUMUZuk6Ok09CGmFoygh0+y0JJtcNj3TMQ959dSsCmd+LdeGdda
	59XkT1nCNde62uhBzw7xnnrNE0ikB01RDy2HgUJr58SWvboxJ3V6ROmmmW1loeTkz0nSLin/vRS
	QGAyfgm0X2/z2TMTlV5yTjdiKYFzyR7DkMKMYXvYyzcmkg1l984uEzFyr5nhycQTkUSVKWC1Wt4
	I4qRvueBEHGmCjx+6XRSq48IKo9cL/LfBklSqFgg0iUygBQZA==
X-Received: by 2002:a17:90b:28c8:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3aca7ef2e00mr3511520a91.2.1792141995392;
        Fri, 16 Oct 2026 02:13:15 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm767274a12.7.2026.10.16.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:13:13 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Fri, 16 Oct 2026 17:12:37 +0800
Subject: [PATCH net v5 5/5] net: ethernet: mtk_wed: bail out when failed to
 set up rings in wed_start
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-wedfix-v5-5-8b02e78fd34f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141974; l=1511;
 i=hujy652@gmail.com; s=20261016; h=from:subject:message-id;
 bh=ePo8kYEQepEUUlHGep4r47dMcAUe+w0OHJZFIANEXVY=;
 b=n9KaOOF5fBmx0U1LSDXbITyZem2x/eJbiwispep6tmzvNhm1EtTdd5kx/xEfHrdoEZpp/bctn
 SxpS9hnOJO6A+sKBm+tdCHRuzDp4HbwtG6Evlqx2+TjBkoY99pVw88r
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=AYHrGhtLNb9z7JIsGOOYWmKKIoVPH7ZZgT+CLIDMuEM=

Add error message and return when fail to set up tx/rx wdma rings.

This is suggested by Sashiko.

Link: https://lore.kernel.org/all/179000700034.2160803.10594281691384015089@kernel.org/
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 3a7c2bb33691..86845893ae20 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2353,14 +2353,20 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 
 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
 		if (!dev->rx_wdma[i].desc)
-			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
+			if (mtk_wed_wdma_rx_ring_setup(dev, i, 16, false)) {
+				dev_err(dev->hw->dev, "wdma rx ring %d setup failed\n", i);
+				return;
+			}
 
 	/*
 	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
 	 * but tx_wdma[0] is also needed for WED to function.
 	 */
 	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
-		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);
+		if (mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc)) {
+			dev_err(dev->hw->dev, "wdma tx ring 0 setup failed\n");
+			return;
+		}
 
 	if (dev->wlan.hw_rro) {
 		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {

-- 
2.47.3

