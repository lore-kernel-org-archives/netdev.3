Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466B3101D0
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913678; cv=none; b=dKeXCenk28h/3KKNbFjBap8b/MNozbj0lE8Q5o4OrbW0HnAAhc3afq2fnzUC25erYjaEfkJHURPCK2JaCmzYUaWcNk4jzRia6GAg5HjzodYcb9gKu3lkv4bra14m+UJ278ryRfgGOj0V6fCqhs4kN/7I34CJcLzmZ9fqTbgHTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913678; c=relaxed/simple;
	bh=7BDbAKtoQ7RrxeWP/mB6HB+l68yj4ywnLE1Pz644nHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFJ0oHwPJDb+ZkP2QT7G6UKqO2Hq7bgxc1UDCZFyfSndzRQdjRECvmhJo5wudGdr/d552HOZ9Rt1P8OgRAU/JgsiNIILgW4WQW02eacO40FzCCPagkjAfMzRjDND+qjdCUKSsukQUyO3r/J8j6a8H3pc57rLXk7mkehMN9grhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS2gFTuW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS2gFTuW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso665930a91.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913674; x=1785518474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CxrX6ndLjkzVoOvx8ReLw2F27C6sP51HDWvrcv3raA=;
        b=nS2gFTuWK+3MdzdNNwfBi1oqu+AtxrXhJgBHuqNWphT58jcau/BskAU+hQdN785qk+
         0Z8ZJssaljU4KQPp8iX0DkW3/cx6VInu3dpnYqHayx5eLtbI6Ja+zU7JSgrZgrC5qYO2
         ojSrAwUO9O6Cce6iXfGJckYwl5ukHxKMjQAxA8jxnVmYRQLh82Q+E8AhtJurTIYeIctk
         WEIRAHyhURF0O/G/TXpLEYU4CPMDAyZMxTD/7yUDBPdcDjFs5eurxXbWy7tnL4LUzW9m
         sU1tdCc1nDS65M8vUOvS6Ts/sVCK16yV69/g2wL9I7yUyfRvlP7idZZBNJ6KkY4dm//t
         09SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913674; x=1785518474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CxrX6ndLjkzVoOvx8ReLw2F27C6sP51HDWvrcv3raA=;
        b=tSLyFGGACICKl7ag73NoYgM1ZNO0eFXFjm+AQeQ/TCyEoo2cxBq/YFg3v2eDeVgLCU
         K+iK0ajuX52qKOWnA/6OZuGo+JU6LAZAZydVcx4gCYjUSImfLXOD3Y0UjmachOx/GoOc
         1yBs1HdZ0ZZ33JATtQ1XpkOJ5nC5Np3vTm2UydUkC8cwfYfdY4nsNey9o4+KTAPlaajV
         ptdO5k92i+KWUDg3MowU81ZBjfF929cAU83d3EbVs6f7k0tdeIlkM5TFsopcNKxbIgok
         WWQL6XjA+e7Ho/2WEsAs/LfkK0IylxL4K4K/fZFjkdZ1Jly5eLkG8oDJb5VSIiGHk9Tm
         C/AQ==
X-Forwarded-Encrypted: i=1; AHgh+RoksZ6NpROj2SAQFz2J4sF8yzYfZmNjz14YLwomLNAK0GJUmXntOrTPyW1NjQY20Jb7xt0XSCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+MZLYTi2i2G4HB0sP+QH/yWA8kqbzs5NAQjzTglT6uuY5P9m
	xn1oL+FbRGh3cbSLfOkX1+/gPJQ2+tsFa7B0Cjs4Ow6PPTG8heyuZCbX
X-Gm-Gg: AR+sD13ajot2vWYbeheSdL0I7taue1vyuU9PQYXoefqF95Y03B7CFnD9az9XPnolwZ6
	2S5LprhQ0D//jyvr+3RgxJskcQ6J2JLGj2oiaqbOsMtekEN0g0CDOXx/6fkgeeqVN71czlr3Ih9
	alNl2IZqRJ4IzpsrVNe+0OYHVA3gQFGlhLLPS/Q5fbyR3jxMpAm66OfGoPNBBq+205ohyJ6Xv1k
	A+1gitjItE+zIHcdAZq5cA7wZ18FyzHmycjAZrua/indEWCdbroMpJz96TiBZrjbCcxPmWmbnQC
	/qsucw5+Cb+MCKAcgTp4pUIpQmbcaL02KC1glDVySJG8KHQFrDmvqhlB+tQ+fu2ZVP1PuonOBmY
	hJWPtzpOieVmISvRB3xOaTx3s/DqssO8RH+Ig2GWFdVVuAyI4svVzsmb9yiLhFrfpstkspY1nb8
	XKHezgLgDug+psUmcgv4k1USentHSm5eZHgrf30jsvUwU=
X-Received: by 2002:a17:90b:55c7:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-38f1f9406damr954371a91.2.1784913673756;
        Fri, 24 Jul 2026 10:21:13 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041d5f78sm1789907a91.17.2026.07.24.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:21:13 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Sat, 25 Jul 2026 01:20:40 +0800
Message-ID: <20260724172040.1653-2-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724172040.1653-1-hujy652@gmail.com>
References: <20260724172040.1653-1-hujy652@gmail.com>
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

Fix this by calling mtk_wed_wdma_tx_ring_setup if wed is v2 and
rx_ring[0] is not allocated and reset tx_wdma[0] if it's already
allocated.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
Changes in v3:
- no change
- Link to v2: https://lore.kernel.org/r/20260711112128.971-1-hujy652@gmail.com
Changes in v2:
- Address warm reset concern raised by AI review.
- Return value concern is skipped until further comment from reviewers.
- Added a comment to explain this special case.
- Link to v1: https://lore.kernel.org/r/20260630144831.1109-1-hujy652@gmail.com
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 7d2775a97fa0..b48abad995d7 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2334,6 +2334,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
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

