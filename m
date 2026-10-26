Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008687;
	b=wFmUCA8MIPLINbNwpm9gfXNsEDFyoHSXYNTNIS1Wnk1M3Iioq9AY1kCfz4q0j8kJIIEj
	 7a55Ry5XDmAy+dsoJGeEEqVzjGUItqHEmRua9kpuc2wpGV6IqEgMWKgY09f6hIy8aBv9b
	 2tqhLLvguYjXKFk4B79Z2dkYaK1av1Gl1Gx0qO+to+E2UfuLI/PqT6H6Ip9mLQIJbYcx3
	 vryXm78sfioNYFE+jUYkuWyASiiIBlxY1BV39I/O0jCkKLRVqbYlw3HHfMmcaGj0SudkN
	 RF9J/Mo20hGO6NKCFgJy5YTyulCC+r1Y48uJLBTsLSS01xUcyFgmIz+58Syxlqw021w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=VDwFEGyVQgtBZkQFcesk6CRn82+sTJh+EWU2kWF78Wg=;
	b=0hOVDfWIccgBpm/2H1/YkletXyYd0LvW0VhkP99ZbVrPcvYBI17Eo9VbdCDrv9szQ4S7
	 SerjzGOQHSKrNGOPsefEXKh+cY6GKtlD4rR6LYU7JJaFQC6TmIW4Vadctbh1ylMnTUx2d
	 GZVSH2sIDyCEUaeBDtT/XdU+1/zS2y8Y9GgzWZHy9qpy1BSYyHPB9VRBPAscdhS0R6WPD
	 tH0jHsc/psZGjTXxSH+tW+mm9PTBDRkqKYIAGsEkodLzCcHU1RCZnS6dJKbSSQjLTQYm4
	 FT5bi02X2jUwZ9fdVJwljtFXazYls08h39+mnbLybkCAfBF17lnt2scz8ZTT1wjI8VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=djyMSPcN;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B1606CF86
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 671B1606CF86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=djyMSPcN
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1083327b3a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008687; x=1793613487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDwFEGyVQgtBZkQFcesk6CRn82+sTJh+EWU2kWF78Wg=;
        b=djyMSPcNEYycFWCkTiq78IYh2FqA3xt0mvEpsfT5ptBzvs6yRZu/raSpeDz49kNlni
         9OMJLn+x6iNJ7LkxohKhy3lbEDiGvWGmU+sMLPg0BZ9iM1eArOSwfSjieg8X2C3bfnTu
         yhjwT1IsXSJwNPEN5D6EP1hA3VjBT7jGgkxCU88SvNxpleYp/AR3tdLCwlg0XL35m4cr
         n4AP05n2WAxiU/QVFETVtGLarIszxA9irFpsPf0XSgI7KEi3NpQA8KW6WIQ2rQfZZPn/
         h5CyXBCtDHLNp/6RdTenUK9GOehco5feKozkl1+XUjsiTkhRiTv5edxvgIIqBJrUrsiB
         AFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008687; x=1793613487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VDwFEGyVQgtBZkQFcesk6CRn82+sTJh+EWU2kWF78Wg=;
        b=rux93EY9MO+hynFm58oONyuKv848T+CK63hZLkL0yIr9PUXocgWjY0faJDbGRY0DZK
         sOPefB8t+oN/5CmnTYreU/HeoQxJkST+Yl4h9RqQzlvn50EbU49c2kiDE2ccSRbmKwQP
         lhH79M27bfmsGgaPBtTKsTdLdUyv0YTq/GK8A/6AQeRDpr4Lhi3gGaKCG6+iQh+Xj5Jq
         iU1A+jPdIfYbljAZ9E9epfHokDc31TjSD5cYEc4Ezk0qqsbY9wqEalJ487LdfeUIm04n
         QTImPBIS6PPY6BLTyryo1+5SGA/p+VP9uvhXYP5UBUwZUm4K/bKfDBUUesx3pM79XKIw
         2aEw==
X-Gm-Message-State: AFq9FYK6cnVQZszQqRLvpQnnpUDES+Cy90LUhtbttoT0ad4IWfU/TTBw
	SItrnMU4ryTMw+rF5EA1UbS+apgDZyjauP8EEPWVBk50XKaynY9SsREM
X-Gm-Gg: AYBFou2dBb5T68j7Ti21nJ/WqckQajBc4kCEBHp7U5A9T4htb0z0y3QvLQDAHGBNfe2
	qkrYNG+F+LnRhaFK7M2/ZIhdx0E9lpT4210ddNNcwn11nC0BR16xwQZqkOeGP4MinYPMuPQ+WK0
	Sjui6cr3YbAucSh/uQ4+kB7u2oY26gBqZ5rLjschgk1HR/ktJ5C6j5zLMLCG8F3UH1jXTvH0r/o
	04W2JUoIerQt+UU8GTGZ2OY2mAyyGEPuTOWV5vCpPusNloEpjU42TIs3SVonYzF6s6ZRb2Cgk6O
	Tvrr7QOruN0VqQEIpx0xIR7rNhKdGHDh9AEnm0Q9Bnch7brHlP2n+PUiOQZ0eeBKIRogBDA6hk3
	DOmaj05QirdMoPVxOeMLx50/WgLPrGNLVQqlXrEj9QVii2p2gcPvPP0XrO2gJmxQ3L+obbF0ait
	wClNz4vynUaxtmC3TPxbWZcSLH8SC3Y8xFPkKzgJE6LLZzJQQrwR3bzD4HgkULFNeX00VTqP7J3
	wbxctkz8xceMqS1Ao4Y0R/q/dQ3lpZNk6OVFHhVVrlQxaBi7KtUt7dx/37BUEjm288ZrQWoLoso
	VMboKaA0CA==
X-Received: by 2002:a05:6300:6bc9:b0:3e0:ee68:77e9 with SMTP id adf61e73a8af0-3e7bfa1f8ccmr4070259637.14.1793008686851;
        Mon, 26 Oct 2026 02:58:06 -0700 (PDT)
Received: from [127.0.1.1] (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bf0f4dcsm1095577b3a.44.2026.10.26.02.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:58:06 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Mon, 26 Oct 2026 17:57:30 +0800
Subject: [PATCH net v6 3/4] net: ethernet: mtk_wed: free up rings during
 detach
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-wedfix-v6-3-a52f6b15d2fc@gmail.com>
References: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
In-Reply-To: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>, Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793008668; l=1486;
 i=hujy652@gmail.com; s=20261026; h=from:subject:message-id;
 bh=UWHNlBK328nlitWq3waPngcB77Xg7ScOwadSLgwLsIE=;
 b=LcWwNARY5jB8Z5a4CvUeT9ByKEYHzcoTRjRnxOpYFt8K3OYc1Wc+OQfcw9T3+x6N+n9wZodMM
 vTQfLdPO0efAw5SswG0HyEDttPwooeBxSl8S8ABpC+lIWlPcNYoRqqJ
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=uXjqvnRsKEfHEyUr63sOg4fEJIDs4AmiW/rB1cWarXg=

During __mtk_wed_detach, rx_ring and tx_wdma aren't freed up.

Fix this by add them to mtk_wed_free_rx_rings.

This patch is pulled from mtk-openwrt-feeds to address Sashiko's review
and edit to rely on ring->desc instead of an extra flag.

Link: https://github.com/mediatek/mtk-openwrt-feeds/blob/main/25.12/files/target/linux/mediatek/patches-6.12/999-wed-04-Fix-reinsert-wifi-module-cause-memory-leak-issue.patch
Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/message/179000700034.2160803.10594281691384015089%40kernel.org
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 3f0be70c3f14..3044a7a8ea03 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -949,6 +949,14 @@ mtk_wed_free_ring(struct mtk_wed_device *dev, struct mtk_wed_ring *ring)
 static void
 mtk_wed_free_rx_rings(struct mtk_wed_device *dev)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->rx_ring); i++)
+		mtk_wed_free_ring(dev, &dev->rx_ring[i]);
+
+	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
+		mtk_wed_free_ring(dev, &dev->tx_wdma[i]);
+
 	mtk_wed_free_rx_buffer(dev);
 	mtk_wed_free_ring(dev, &dev->rro.ring);
 }

-- 
2.55.0

