Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1B4DD3C9
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656266; cv=none; b=M4UZaSaa/EDcl0atDrhqAnvFEjHtK4Q6JckdSB59gJ0ypl+bLE2Wkz7j0Bmp2ZawNHOZov0Q/k/24u7VbHYlWGj1LJaJo3MqHiB7ttZzgY6qHXT0IAHsxtexCjDE86DMAO8vCeoa3JkiyyPJfe8V/7XtFTAFoZAKRXdg4rrpE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656266; c=relaxed/simple;
	bh=uaqjBwLJCC82wt/s/pAT4kIoBXhiZ8r0imzWhi6oNmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmEsoWmPNDTZCQIiyR4M6D+aOZNAZSnz3ZbsQbAFn3hCvpAURKWs7neAk8rox1ypfL3n38HwpW9vSzuxFxuDfqYyico7cyRQdV5csUVzqSR7JnPdz4m4F6NtfyHlBeN+6VgFPLNmSoIXkTB+dUwu724VN9FTNHBzqIQh1AgHXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3OX0Aj7; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3OX0Aj7"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34908so785106b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656256; x=1790261056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4aPNtQuaiA+2t73z2Ob/AKAru2eGb/yyU8jK4Q9iWQ=;
        b=e3OX0Aj7z0rSG1f3Wn8wAA1BKzlkWTna7hHuwHoZbuVdw0EVt/C2nRbM95KwgkSbuK
         pEu/AXrK4JJFO0Ia4usdzuMRZX4dObIr28Hsu1jTkZLg9RoBDmKHOSNCuHKXIr1d1udu
         PqEXu8ubWyr9kpJRCBiyqTen06iO6jz5w461iABryww6cWEDgrNAFgoTeF4T3afD6f58
         EBYHmaVTWqDbAjJe6FFvsC0Fty4Es6ajfGFUV+Nf3OdSN7l39qLfeI86Uczq8K6+8K4I
         7ZAQ1h/4hWbtP4jhHxYsxuGOfI0NhHguOSYOHu9dRVKjT44am1mgoEpe73adMr1cCtND
         tnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656256; x=1790261056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4aPNtQuaiA+2t73z2Ob/AKAru2eGb/yyU8jK4Q9iWQ=;
        b=ymyOoqFk34WTTk7n2wRdkeqawGf2x0BH7OmweDYpBLjn/5SjI/0LlUUrrKevMtgbVa
         CihjvTE3xk9EDz0zr8EVcsCFxFxsTHgCFJtEB6tg87c7GFjZ/73nfm0nfyr1Cg+5lsap
         VNC+pQ6ZZ3et7sVjvAUF3pv/i4txwRQWdZQCL8o1dKSsj7SXzIgqm8YaIyPhQmJ0coSj
         mFpZzZTJl0NFpsIJednx5LsxcLIXNitD0eLzGCvWTyuxwRo++4x5cjJ9muNB5a41G7Mp
         jL7RXrMzbOQw9+0g3L9XBB5rIPrw2vWO1usq52rxzCmWTX7bLA93zl+CTj99s8anM6ax
         0NlA==
X-Forwarded-Encrypted: i=1; AKwUvBxgS5un3v7zbnCfmj8x6+R/DzHlmrVWFJUG/t84WRCrdWOLJC9skwoS3oWU4AbL3HCA2SE7f70=@vger.kernel.org
X-Gm-Message-State: AFuF++kk2sKEtekKhBOJicpECkgIhjwoiQYhDgCL8DdAz8/9LWhzHR9v
	ThWPhE2aJ73mLO3PBapbtX2Qfxq4uEWTMGcio0VHkAPIfPNJyroZWvmp
X-Gm-Gg: AYBFou3x5sI3nF5ufbONw3Uu1V+KI61Q8uL29KKgeFqmzcwv98sbhxh4u3Q4tYySyfj
	rJo6rgr/iMbr4m6K9/v/3C8Y986QYzbawE0w52pT1fKx9GjdU8x2LsTo/wF3sFjXnMHac0J7z5E
	ASZ3D3/x0XmVmvAUsmtw6tP1gXySIxi08rFkZJAQDMR+T4U8hM1THnnSOWINWphcaAYfp5l49FB
	4RcVkfpharhXsS3+8qGd29c5dhYBobklTFp7NHXNkyaEY92XLnNbxaWvB/zHzROaBoy+e7bbQ6i
	r6mk6LYFU4TewSq2bhsCf587iDQN+uHIDxBFyX9Sx3J1wbHoLbPK065wl9LL1fGk97QKvcUVQQV
	Y+tJMgDE4p9ANk0ZbGAIw1CTC9O9qhlcQmsi4MCZS9zMS60VvogyqucyOc5aRN7Yqi11fnya0PJ
	kmC4ji44GrRyv0zhOO9fugU6vQkJQnjpFJKjNvVdb75q9SOxlDG1VQViCqgRbZO7lmV9k/K1wGY
	l7O/g+9NPs0Nc7ghq6/XKfQIdoDOcJ51gHqmL+8vcqREmXndwGU
X-Received: by 2002:a05:6a00:1d14:b0:874:708d:b626 with SMTP id d2e1a72fcca58-874708db89cmr1110819b3a.27.1789656255590;
        Thu, 17 Sep 2026 07:44:15 -0700 (PDT)
Received: from localhost.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d1b275sm2962034b3a.51.2026.09.17.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:44:15 -0700 (PDT)
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
	Rex.Lu@mediatek.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net v4 3/3] net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Thu, 17 Sep 2026 22:43:35 +0800
Message-ID: <20260917144335.19466-3-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917144335.19466-1-hujy652@gmail.com>
References: <20260917144335.19466-1-hujy652@gmail.com>
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
Changes in v4:
- no change
- Link to v3: https://lore.kernel.org/all/20260724172040.1653-2-hujy652@gmail.com/
- Still waiting for comment from maintainers for the return value concern
  raised by Sashiko and it would be a much bigger change because it
  involves mt7915 and mt7996.
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
index 3f0be70c3f14..3800e602d3c4 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2339,6 +2339,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
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

