Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17E413782
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959241; cv=none; b=BJn/dxp4osNF22LkIrCKpoqFov3vgiR2AiXlUZyIBUrJjGUthixbzjQYxTtYSZ0Yfs5RZukqg8rqthK64IKp1VqSM+AKDERYNP9JfW/yUjhhWm2QA5qq8BfMdTsJ8EPBw09nbi55Kt5kWeg1s4GevBVCwa9uNGFMeODMFcO15rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959241; c=relaxed/simple;
	bh=NEEsEWJzvXXKw1U5i3R6qVwNEZ7+58VweQO0x61IjVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNkoOPBaPXXMeirjrBF2bpMcrgNnLd1si5LZ1zKs50bwh6wtvFstezviGDctUI8/61F72r4KkZaybeK5s99zSXZRKOK4qaqY2kMj9GXS3cRJ7Sx/n4VrzjVBE3BNRWTotIeNYM/1iYrYTkZVrfJbi6sudzGHAGqI7ZwLsjCKq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km4uLm93; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km4uLm93"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso44270f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959237; x=1792564037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FcCs3sohxCHYV561RCxP42Zr6CFjBiLneuemdbNXbEY=;
        b=Km4uLm93F2xKEXVmpyWTD1Nky7ueWakHbgHwoz0HLskOTG7r/i1lZYs4m1DF0EDHoY
         u6w496J2kcwRbn5nrllSqaowKJkHrwkK+vX/qZtfEy7KAp5sPw0oFkL+WDaBmAhthH9q
         BjSExUFd++yyVuT1YRIBi6XxJSKTzQOKl1URkoK8L000tUhw6Hey9yzeJ9jt0d5WX9r6
         AygqDuynb55hE1v3OKv00Qwd9ccmpDLTjt0pbtp66JKED9X0KpMXQLg0WAaiTobDjsxD
         GSKrwTc8gsHFpMgVENUmzIJDL1UvznoX805UfpTsTBgG2Iv9aw1RzDBTQhd//wR2d4XC
         yYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959237; x=1792564037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FcCs3sohxCHYV561RCxP42Zr6CFjBiLneuemdbNXbEY=;
        b=UBJRuAmmjd6d6U0ulTGAsjQckEFLevBEWAt23lwCUK/FR5csJteIASeCIPn9UMxMqw
         wnJepYyv2S36FaovcnPsGm1mJtmJDdQxYN9luGsDdY4tKB8I3w/HmvU4l7A41nBJREBM
         QcxlS/Z1OQJpYlVIcpGrrWbi6aFlur7PVWpPobh7ZXszzN+GiHJVAzDVeARoGRqZiDX8
         0thfz3unR5yQHkTPYFqmYFvTAjFbcLTcPlAZTHUC8xfQWCRdIx4dMhNfEA4Gimf1drd7
         GYl9PBrhxg+rfKCkktS7pQuVpLof3jq1rD8EQAKo5FMC5Z/GXo5DrqKN1u/VjvHIWPi1
         QyMA==
X-Forwarded-Encrypted: i=1; AKwUvBwfGHMJnB6rGJnqWJ5tALoAL3PyJ5oKV3M5rkJ/g2la+un1bMjzpZC0NbAJHJ6gZWDKkYoFBfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUkuGLvw/2iYduIUKFvh1bT5mxNO7DbzXMWFdzTkeBpAJWfTdd
	mNJpePPwWp+/6y9uZiEsO9eRcethLNytxLe51V69ApHLY6C3hCOZey/d
X-Gm-Gg: AYBFou0SUEMR7dJXuosAZuK9EuzAnmxv1OwW5K0xHrCTVaKyx0usmUjAoIplS3/qFWi
	0A0Sg/Mhbu8X7cQN8N7la8HwbHLCMYJPwVeSRqO3EET8+TRq0Xawu+WUw8T2wxi2z6Utm2/EOTz
	dmcTMdEq3BFny/BEOijODB8phW1PDZ19Gi4YqYxCqd04cZm9HvO3ylZRn1IypfTyqQXSlY12bX2
	VbMrX6oJtjYgqXxN2Wt4Y+27/EcIy/bdEm7YRL1R9SXopT7BC3xP/zabhZtgPm3gohxjJKQsA98
	/my7vtNK8ymK/zrt3i92sNXxJ+KW2hmRpLbUSr0CvJnFKABeSFrdy2RX4/dLmijgpvco+M2eWIT
	5xcRFg7ADIUj5LtjfOpubERwPGeU1GvxBuz1yMEEJVsxv0xS+6VR/PV6pvFQL470MgGqim3Go10
	7w5RNiwKomYPNR6x0aS5xo1LpZgaHwCh0ChZuYRGCtsDG7G6BmZorYunVtP++KYW1M0cPvtGPOa
	50OQ7vVzNAl4TigaCij3XOqvcY4tKr8a82Dxq9aP6droMiK+iOWtfSz1iOYZR7cRHXSsmzIgyV2
	X3WUQcZ5m3wS/ztpjPQeGbhyyuqRdqJEz6kwFKjxKOoRgM2UBI7uSBj237rk9znsUPb+T46enIu
	AAw==
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id 5b1f17b1804b1-4a18e47aa9amr307794635e9.6.1791959237236;
        Tue, 13 Oct 2026 23:27:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aed1-da01-ddff-863b-8308-ab16.310.pool.telefonica.de. [2a02:3100:aed1:da01:ddff:863b:8308:ab16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm528846745e9.4.2026.10.13.23.27.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 23:27:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: stmmac: handle partially allocated DMA queues
Date: Wed, 14 Oct 2026 08:26:59 +0200
Message-Id: <3537f9a4f3e875291812486982b907b3b02bec15.1791958735.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791958735.git.kmehltretter@gmail.com>
References: <cover.1791958735.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA allocation failure unwinds every configured queue, including the
failed queue and queues not yet allocated. The cleanup helpers then
dereference buffer arrays that may not exist.

Only traverse allocated buffer arrays. Clear freed pointers because the
queue structures persist and XDP reconfiguration can reuse them.

Found by inspection. On a BeagleV Ahead (TH1520), fault injection at
the RX buffer metadata and TX DMA metadata allocations reached these
invalid cleanup paths before a test guard stopped them. With this
change, cleanup completed without the guard.

Fixes: 54139cf3bb33 ("net: stmmac: adding multiple buffers for rx")
Fixes: ce736788e8a9 ("net: stmmac: adding multiple buffers for TX")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27..495ff7aef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2144,10 +2144,12 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	void *addr;
 
 	/* Release the DMA RX socket buffers */
-	if (rx_q->xsk_pool)
-		dma_free_rx_xskbufs(priv, dma_conf, queue);
-	else
-		dma_free_rx_skbufs(priv, dma_conf, queue);
+	if (rx_q->buf_pool) {
+		if (rx_q->xsk_pool)
+			dma_free_rx_xskbufs(priv, dma_conf, queue);
+		else
+			dma_free_rx_skbufs(priv, dma_conf, queue);
+	}
 
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
@@ -2161,13 +2163,17 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
 	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	rx_q->dma_erx = NULL;
+	rx_q->dma_rx = NULL;
 
 	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
 
 	kfree(rx_q->buf_pool);
+	rx_q->buf_pool = NULL;
 	if (rx_q->page_pool)
 		page_pool_destroy(rx_q->page_pool);
+	rx_q->page_pool = NULL;
 }
 
 static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
@@ -2196,7 +2202,8 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 	void *addr;
 
 	/* Release the DMA TX socket buffers */
-	dma_free_tx_skbufs(priv, dma_conf, queue);
+	if (tx_q->tx_skbuff_dma && tx_q->tx_skbuff)
+		dma_free_tx_skbufs(priv, dma_conf, queue);
 
 	if (priv->extend_desc) {
 		addr = tx_q->dma_etx;
@@ -2209,9 +2216,14 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
 	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+	tx_q->dma_etx = NULL;
+	tx_q->dma_entx = NULL;
+	tx_q->dma_tx = NULL;
 
 	kfree(tx_q->tx_skbuff_dma);
+	tx_q->tx_skbuff_dma = NULL;
 	kfree(tx_q->tx_skbuff);
+	tx_q->tx_skbuff = NULL;
 }
 
 static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
-- 
2.39.5 (Apple Git-154)

