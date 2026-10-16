Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14657468C1F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141980; cv=none; b=hLwxtIJ8oCQJwBAlxUq38KGVuQzK62JZgad25W1gDv1gBnLEGolR3DpLDrkeu+dW1n+v4dx+934ePmmI+c3enwDznd5xTPyX0nEMRahCZIdqlxiLAXZ5RkIQeRfLq62l+auFiXug9gEQKi03OJc0NwRSOi5Km60bpBEfmDMMwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141980; c=relaxed/simple;
	bh=3VzB1FLCd2mLzCjg7kaS/GAexp/k2KRl3VSTok/MVlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvrmpQUgdwk2Rs2Y0oJ31dRP5nzxfHsVead3PZQr7beO73Zb1+vECeIVKeatUBQ1v1rZ9PsrNTRnR9XDNk2/Aq9QFWhf7fVXEvagMncyJct05w3wjIiZV1oHzqrKk6Ly7vHm3a2h+09GNE+8CZupN4TTbbnts9994b+lljkk5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IafH8SbS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IafH8SbS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so3916391a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141978; x=1792746778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DaRwbulkkTIJ93wv1Wgx1yqKGJXajwFFEDheAhreMvw=;
        b=IafH8SbSACmdLut8ZOLgTEJL8IwqKhb3bx0CxhmSNXLdkb7F8AaxXlFFeO+jfYXQWH
         cshA11S/j8o90sNATKl8bm2V+m0Vmi73rWCAV1yaZhncz/T1mNZSJItpus4mFnNOKnit
         Gu8cyW31oG7Z0aiM+Olm8Eg6WTTPFFlxLlVPwykoLRWofQpS2tUm6RPNEnpM8Mt5FBQJ
         mHK5S9B9OE35fQ/hYXwlJrkkPjtKJJDtSLsSvVFVu9cY8q4wBFAECffvfwi2iZ9/38Uk
         AM8HU4PdFQrdmVahphFLYtq+ivZfusyTiv55lY/cY4TsBuDdrXJO5pwtDRKiTgaiv/tg
         Pygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141978; x=1792746778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaRwbulkkTIJ93wv1Wgx1yqKGJXajwFFEDheAhreMvw=;
        b=SkHRxN37ujWGbDf6Hrp3pK+2VeiToJY7WW/VHlN90tN3xiena7AS+VfX7L/EdFT8g6
         H1RcAzQ/Xpyod53QpI+pO0WqqjMvS8BCqhXABTSp7to8UP5dpdUs95wCdESwT3hSUMeF
         2FiWrRm2vL4uotVBOBmgxa9KanUjxkby3LgALOSInOcfibTS36hQDdgoQ5yRRtmCVOie
         5L06GBzir1iBm/KrMTZ/IwifunrTGtoK9zAX8qu23A0iPfba3Xav7Cb3lsyuV1vkEORz
         8lZ0+2lf3pOZ/F+bL/GLq/El6hmw0oE5ADhWMLdLlvCJZ6RKTuxPi8xjEPKTJdWJvlnX
         PGOg==
X-Gm-Message-State: AFq9FYKkQrDoQL93tsE1KGjjbIojA7uErxSA9N8+6aJIQvSbocAzAkJ4
	JwJH9TbNMbUktSriv3It3p1VeCKi2uSSdsWzb0yGlooi4ZoqazHFuZFQ
X-Gm-Gg: AYBFou37+TW91u5IhpaDaZ+oqKA/QvVNIIetnpLGnlpJxvsiGlMo75fTb3G9gG8gopR
	KEHrvZdTBpy8WUBgmsZaG96U8jXN+uQCd67kQ1FCcTcdX+rt/Z5b1UHT/AljUp9ChMP2vPbRMIU
	+RiKNEC5DjcxwZDFmHZxgN4q8M8kNxhZ/AwrHNHgVbGFZy2gU5/L6987WJgFddIwjVNdCtzQW/n
	V37TlGDEy9Pdj/+7uFOOkck/vSc2OKmtSzKWwmy5Zevc4GmdZYHr8r/8t34fMO8bDe5dIB+eXJe
	atQ2TOeSjJJfp203VrveNCZqy1c6T9qFziS7SvgssM9Sk/DUt4NVswDleVw0J6g6lZkiN//NLIV
	MFFbnhaK3DqOhSRsVcW85SHsGmhEBWeLe7vtWdrIe8oUTSW/MDwPAZI9IrAKw8jhhzTQklvAIr/
	al1woa3EMQqaPKoRl40oMmWYro9pK5EfjED0wrEcFNmjTKmclTuRLdfejft8oKu6vVSXSd6zV1a
	koopUd+8LIls5TXr9mkOqT6CDhx+IGQuPhVkQRrqYYwuWunQvlNdgKSp6r+
X-Received: by 2002:a17:90b:4ac2:b0:3ac:adce:60b5 with SMTP id 98e67ed59e1d1-3acadce670bmr3331774a91.14.1792141978314;
        Fri, 16 Oct 2026 02:12:58 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm767274a12.7.2026.10.16.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:12:57 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Fri, 16 Oct 2026 17:12:33 +0800
Subject: [PATCH net v5 1/5] net: ethernet: mtk_wed: skip ring reset in
 wdma_tx_ring_setup for WED v3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-wedfix-v5-1-8b02e78fd34f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141973; l=1202;
 i=hujy652@gmail.com; s=20261016; h=from:subject:message-id;
 bh=3VzB1FLCd2mLzCjg7kaS/GAexp/k2KRl3VSTok/MVlE=;
 b=5XzbtZKpJ+yde/h6N2QHggLRyxZpPRxz/vp+RwYavuMpb/33Vc1ZKXfd0XtsE81ayaRaOHReS
 YZ2HLm9vrG6D+qpPZXfGoeFt2VcsBtBboe9mx3MoHFVkvVsdGMvmXBw
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=AYHrGhtLNb9z7JIsGOOYWmKKIoVPH7ZZgT+CLIDMuEM=

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
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 53d3b7e00e1c..d55042ccaff1 100644
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

