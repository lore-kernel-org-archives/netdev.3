Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1494C651D
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073045; cv=none; b=Hx6xLUB0PUGgLzel0ZFDbjTghOAF5+sswP/x83noyNjlCIABqxZFp3pF2ieEs4crrF/kQ0fGMqKor068d2Pg89JFXB+aQr9D1xcDw8b4NxwETs8T5OloJ12+Gf7TpgxJKLI1nL5RyB4nA5/g3OwUjo10jVH+p/NttKxzGTQXn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073045; c=relaxed/simple;
	bh=WnyZVcSqcrDAMAr3wsgBugh5iJthOjasuaQpP6wl2no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UP/ZSCCVnZwaS32Ax+w46Brk954YXGrrzQGc+Wpp4vRwnf8IY+pMBeGICbdl8cFdkuHuVa0CY5ZmaqPtIk1KEMt42Q1KPZpAaOS+nn/UbL4L3K3vdiipFoYLhDm4cC01VlmkHP1qIzu1iCPpBmEU1TobskOtdO8I2nVEY1gWPtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhnhiCqg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhnhiCqg"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcef474680so417257e87.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073042; x=1792677842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECSIoPsbBe7MVS/DDfDiHhRGxqZFQJYHVqA1SbJwU1E=;
        b=KhnhiCqgPoWAis6qYRLFIOGx5IbzFTvDgtTaW3yTULuCixBcvoqTPr5QdpWBpJmce8
         lRn4xd+AxAoLXL7pMp0pOUoQf5AAXpYBqMF/P3gQdtoLtdVgQm9wJvtqsEP49LRTvKTy
         Pucrrf832VU5Y582f6f3VuXE+Wk+M+njxokD4JrhmW1D4ybF7355AUtBCGqjWD0XVqrT
         LchpbI1btNdo7VRletmSZ/hGELcQPc0U+g52QUPcoX93nHZxh4KDae5zYBtgJ0HXsXbE
         jDz9dwnYOOQAQI9yBd8HaefwUD7JztC26WvCzrbFWZwcjxHVfQwTfdAeC7pLO1sIhhXy
         oRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073042; x=1792677842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECSIoPsbBe7MVS/DDfDiHhRGxqZFQJYHVqA1SbJwU1E=;
        b=DASNLZk9X0Z6SE9gVTgelWeoEOL/ZLGgd/FtdMBGkepSzmLN7jrQGWY0EvUsEZB3/l
         vgVQo6nx1t/m1ctaqewBV7HWgpSZb/44zafWoqRyBtKxMC79FUjkW7dcEH9gpCHUaKSc
         cI9h+mxdeZ80E/yxD4FzT+oWEQoTn97GkAFl02ir8KtUgy61ucq5enAhvUwS/pfqTvyP
         oLBwGquRB02Dx1kMqYQTCVk/7N0XHQnyZM+6psVLWqeMabPsl3xp6BK5idQ834zppZQ6
         TQBOPHqt45K9b4cDTYo4tYe1QamvI7/WBMUSEIMKJ6tf1hCigw02GK5JSKxM45uz/PKX
         JTFA==
X-Forwarded-Encrypted: i=1; AKwUvBxXNG+9B31UiIYJjMILycWPKyZV1gceTkZfF3FHhsjVlBygNf2L7PM0lIo0DwQR5fpBmao6xQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZbgD/L/RPV7EBhrRVKzX9pOQCRYcGVY9yAGP9fX5JjYlU5Yz4
	76r5BLx/JBvy8XE7bqF2glnofDO9VnggRctqSFNXvu+vVWsvpJfbgq7a
X-Gm-Gg: AYBFou2j4fTDA+xFruRBjuyFulNfLvtwJs2aVH8Ov6DNLqDu2Yjpe/tA+C3BIiZCpL6
	4pvwfiG/5gs6dNgv7XSkGgvpXyoYZ4fxAGP5DuP9JVKdM8GnXRH+ejxhw04BHotxCX9Kqy0bUDM
	7Nm5YZgBIsP0Iw4ETlYGIgCuRnmdd1KOf906bLDsN7VpzMWRpfjp/hdaAMRUcKnBp8V446uWfQw
	TYwyLbwFUnbtHXxP/tKGzS7+5UFQG0jqgBKVpXAxN6VFdV+cu5ZG3lnGrOjkZUVPKlCILLxwx2o
	tZFw0x2pndu5T9vi8g4Nc495MSRYF5Gmti2Xnsw8jtBM8WOQv7B9ubyZ0grb8VpJYB71jRR21jo
	B/O6TB5uQ3SM1Tq80RuJcWC/dzhKSKoeziFIgQe1n96FiHRgBm2gDOACoLi0xQ4YWwQBf6bX1V0
	IWivdXTkX/5fVk4nrx11O34oF/yD4u3fYCsf87g68bKk5KiZEUHVFnhJ1FcHwJxXPwO6HOCVxxa
	zqdlEo7XabWKUOU0RAFYadTRJj/2jJoFEbEO+a7Ytph9cxAEmVK8wdcf0Nfukylji4=
X-Received: by 2002:a05:6512:3c9f:b0:5bc:f871:2810 with SMTP id 2adb3069b0e04-5bcf8712b1bmr4822198e87.5.1792073040655;
        Thu, 15 Oct 2026 07:04:00 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48defca3fd0sm8412267f8f.15.2026.10.15.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:03:59 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	netdev@vger.kernel.org (open list:MEDIATEK ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net-next] net: ethernet: mtk_wed: Fix dma_unmap_single() size
Date: Thu, 15 Oct 2026 16:01:09 +0200
Message-ID: <20261015140110.41988-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_wed_wo_queue_refill(), the entry->buf is DMA mapped with length
q->buf_size which saved in entry->len. However, in mtk_wed_wo_dequeue(),
the same buffer is DMA unmapped with length buf_len which is set to
SKB_WITH_OVERHEAD(q->buf_size).

Change the size to q->buf_size.

This was discovered with static analysis and was only compile-tested.

Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 7063c78bd35f..4f720ec53e20 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -99,7 +99,6 @@ static void *
 mtk_wed_wo_dequeue(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q, u32 *len,
 		   bool flush)
 {
-	int buf_len = SKB_WITH_OVERHEAD(q->buf_size);
 	int index = (q->tail + 1) % q->n_desc;
 	struct mtk_wed_wo_queue_entry *entry;
 	struct mtk_wed_wo_queue_desc *desc;
@@ -123,7 +122,7 @@ mtk_wed_wo_dequeue(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q, u32 *len,
 		*len = FIELD_GET(MTK_WED_WO_CTL_SD_LEN0,
 				 le32_to_cpu(READ_ONCE(desc->ctrl)));
 	if (buf)
-		dma_unmap_single(wo->hw->dev, entry->addr, buf_len,
+		dma_unmap_single(wo->hw->dev, entry->addr, q->buf_size,
 				 DMA_FROM_DEVICE);
 	entry->buf = NULL;
 
-- 
2.53.0

