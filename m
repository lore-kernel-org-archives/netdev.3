Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5046E000
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141984; cv=none; b=pfdksvN3tdV47RdBPV6+m+qjIcXWgg2q7zP7nZW+p3dU0GJ+r/iirkY6YrU/kV2cfwL0VFI5roRm/V7BVLQ6abZpEeXYeLUk/DJSN12CHI6gD19GgZmiq4GOj4nHcbiAZKgnDEZMIHF41hyBhaP31vHu4+AeKrzxIPInXM8mPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141984; c=relaxed/simple;
	bh=ef7Fw6tWRmoS7SAlJ88r6e3K75+WCUkomH/n+4D5raw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgL9Lv4i2n5Dtg0d8yRuv6thk8URPmUOxtevP3qYorXrGtQkrKIXHFocIjH6mTxhwD+26K11a7FgokJizwO3AF6b0jnzVELEuaiJShIQ+yyNXVkHu+guqvQw3zRI2XMx9GQUbvizgnvfFoOf7JdPVFG8Tm3C4i4k1VjAH3FrutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFjVZs3h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFjVZs3h"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so4623500a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141982; x=1792746782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3K54IdL4RZByTjgnEb8ZCDinU/s/KfGgM+FAnEVJz+c=;
        b=kFjVZs3haVxGgGO9dYMeooCWmPexNk6tlYx+KZp3MZQWNKAhDVL34iyIa3cca4dDsm
         vLjWrvIqqcRh1WtYXK91Cj8dIvBHAx82fIRkHJNsmlXhv9m0881Wsk15H+h9/L14xnld
         etbo5YNFLDQWJT3IRdpDGGHgqJx3XBCEEPpgrHOofBiaeWFTp1vcSn0gihgg1tb60BUN
         ZM1R5fCdkAVNxLHoQdggpPdm0KDvy2QhAGqzlQ04u8e6duu0U4J7ohh/dEFL3EeEbGpi
         hkEYeyZdf+MwqjcDf5h4thgpj+y2C/vuF4OjOWmiDrhhhKFlo9cjfc4nfuJkznPexc/5
         unLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141982; x=1792746782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K54IdL4RZByTjgnEb8ZCDinU/s/KfGgM+FAnEVJz+c=;
        b=vzdsVpv6wUZ8XYacrOzv6AULDwJf9eSff04HQKhQpUcSgy/FL6XuMJitNJXQBKdQtb
         KfY9Hatb0gJcjITNvTU90sQEMbgZSeMxM5lneS3mVrepNLD+Iuwhw9migXkg83cTPCJf
         ldOOU38KJotvEhVDeInU4LgsGpVK17QvwuNFSDrbyVSpLJ9zaqwzFO4VZAvZ2oX4htQ6
         tzy0x0+sqO/Cf3YufSjrtqfs5OIQMKIrajAqC9y4z1tC2GCYeKDwsujB/OI+008cwAZn
         kO0B9dwO5h7mLkNXCs7JlQTg3qJn7hUG6EkSraO1XqxaLGAjR+2WIrVZR0SY9fKjS6ef
         /SuQ==
X-Gm-Message-State: AFq9FYJcGUwBd1SLZW6HB3nuEX7AvyJNPiSm20nVkcWId+N6YheQ3ST1
	Fx/D6FjKghYplpcZs8fwdHlk1AI4aYNIuMcoxwsVwkDXfWsz4TPfwkhT
X-Gm-Gg: AYBFou2WoZQ6gnTiwslecdo8mWxdi/aHNHcQdMG9M4XMC8nNW1xrP2v17UgT9AJsti6
	f054bX7MKs/HoR3gRF/fojrDDmJu1of8qlaQvMR1GiierO0K059byFtQf45M1uI2cv8PTMG/8vg
	jc+QbqWnsi/uGhLCnYLiKaXJmcs2fgDOVmgiGNYinxeS2NZeaQNULBBC1EJ40YXhCfOIO6MJZWL
	NWO8qA6aIDhwfTxa+Nj7wNOn01WvOUhTLAqG/0hClVZE/YhKyPLQVzB4SACAY8BMVenf8TiARYd
	yHRvkf8tZtvR92WEDhLuN6c1FdRfG0DVUAjBlyFGzhfeLpvwYDQgZsLm23mtcnr1VvgKq7BBhjg
	B7MAsuIQFfWE/9gVGPuyIoWU4GAuYYsKH30kRVjbKZ//gxKmfir9dYlseyaAj1q2Epvbw7r80Hw
	mBWB+4+HGQuosbVyOkPVfVD5HGKuRNJH1RWVHbuaYCyhtqHGfneWHXIWiEB7sBPJ9GEaKAjru9I
	YLgFaPeQizxmdTRCtEiRQZ9ftrPtiW3f6cRDiWnM5a//eHpOA==
X-Received: by 2002:a17:90b:4d10:b0:3ab:e789:ce84 with SMTP id 98e67ed59e1d1-3abe789df31mr14032439a91.65.1792141982237;
        Fri, 16 Oct 2026 02:13:02 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm767274a12.7.2026.10.16.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:13:01 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Fri, 16 Oct 2026 17:12:34 +0800
Subject: [PATCH net v5 2/5] net: ethernet: mtk_wed: fix reset condition for
 rx wdma
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-wedfix-v5-2-8b02e78fd34f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141973; l=911;
 i=hujy652@gmail.com; s=20261016; h=from:subject:message-id;
 bh=ef7Fw6tWRmoS7SAlJ88r6e3K75+WCUkomH/n+4D5raw=;
 b=+PQFTR5s+TTWwx7Z6oJWtXxCv8fvB1yIrErU3O65A0x/ZCM9asxgNMV5LpBxXawCXZOXvZ+QF
 sEZym+shfFOBc3c8pjPDBrbFSHIHqiTE/3NTqOrXjEhY1KjtJmVMjZJ
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=AYHrGhtLNb9z7JIsGOOYWmKKIoVPH7ZZgT+CLIDMuEM=

In mtk_wdma_rx_reset, only the wdma rings that weren't allocated are
reset which is wrong.

Fix this by inverting the reset condition so allocated rings will be
reset.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index d55042ccaff1..3f0be70c3f14 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -257,7 +257,7 @@ mtk_wdma_rx_reset(struct mtk_wed_device *dev)
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
 
 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++) {
-		if (dev->rx_wdma[i].desc)
+		if (!dev->rx_wdma[i].desc)
 			continue;
 
 		wdma_w32(dev,

-- 
2.47.3

