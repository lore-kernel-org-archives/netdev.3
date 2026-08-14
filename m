Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261B353A73
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687721; cv=none; b=cxi81+pJKZZoyuh44qHwdnCfTHK2ez5IcusLn9thhbP2+mGwIx1NQqJpYc9Tx16NwFF4GOijgg925txL1r0pJtajcAKcc/GO567y4NI7KXU89C92YvqjNPK9tk2p5zo7OoccyADpZggwM49hxnQUKONtW+JCNaJcifIVMfj4SvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687721; c=relaxed/simple;
	bh=0Vwj+Yf7E1Ji8YvFOtq75mgQ/Wgtg5/pWR1g1XG9zro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udpFfAvf0x35x9PlUbxq9SQZY/CR1IrGHrASOUAePHo+Saqszl+6ssulCqeiBmLle9QqgbEi5JPThIJAJCk3FE8iK190nBRX/zak2FB04yaU4vjPt5mI6tUzPlVNEX4OVaT35wPcFd3m8w07M406SyydnlA+B2jQKomU84NKMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0G11eX2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0G11eX2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495437bb891so4084535e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786687718; x=1787292518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dr5UudFe4F6r6fPOKSi/bBNU+7nHpGE79pgT3ehlkvE=;
        b=Z0G11eX2wPdBjPCQKpexBDK0EZl1IwP43WvhjfZfyTU3Mg3l2qNSsoSmMTBf3+z1ll
         ZTpwaKxToyyabuY48qYTRkNQG5kL8ZIxX9fUmRztQhspwceRU/47oZ43dEz4C9nGelWS
         6J/KJxzUdkcf5TxSMxB/25ci0ZW9ogycdO8HmWlEyH+iO3u/QMvsVyAl0CV99e0YxBO5
         TOPkSolCHeNqqwX3o5EYKW4yGQjR+9YfmGj8ukLj7i8J62cboY5bF42vZJiQNNGsW1zm
         jfvkUHnfELNsjuqNvqVOX5X/9SY66jqRMFppY/7rbCkSJKERWQh15p6UFZgU1TPyXs0b
         M8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786687718; x=1787292518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dr5UudFe4F6r6fPOKSi/bBNU+7nHpGE79pgT3ehlkvE=;
        b=JoyGgO6n3Xg8MGhXzQGCdB/UgY8pLQUOkYV5N4bwp2ovIPwUf4YNZAWf9s7QnQmb7+
         bheyVSGPgJgNK1P06ye7tp0U3MbieNvDzk5sHVpZrOQKAG5NzF9vBhcyK7b41368QTm9
         /7HcjcsviIBn2ZqRugq+FJosDfGigSG1irIHzULxC+acV/WnyiuyjTiWqeecIJXujqg+
         ODdAomeXBxLzJJJld1wmlrVQLp9UznV67tElU+4jTFDLa5RcpREv5EX6axZHZoKmUDRZ
         RtBr7CGbjZgDrqf5244hVUTgkIFsqCd28IvhBNkGEEokW9QdV3IByp9wjvL3A4+9iM6F
         tV1Q==
X-Gm-Message-State: AOJu0YxojxhNtb3pBL0Phc1jqa1bbiJt0vQF1JUqhdL022GhrZCF1f0P
	wVkC6DW45hQi6KhqGoyGtRAg+q0T0a68cU5dHCAJeSIN0s1U8/FnUkVg
X-Gm-Gg: AR+sD109Ko0WDpzU9jh9IV29DQ5JcE2BEmYrXNq+LXfqFz5z2ru6TjU8mzuUdrmuT20
	JxQyy5O0uDpcWB5AtC1pCTIQ588PSozP1NdwDb8sMKupqgpwMypk3xWvdRHcqqBjK8z5sQpNxaa
	HGaMCPAK5+fzHkUbM7+Jm9ByQDo7oatG4zDxeECUUpoNpNsG71TDGO5kalKcW4vESeo0Gcr5Gpl
	8vemC8U3cVQU80jmPvs/1GHli6+LfTXHkup+tXAvh3geR6EF364fCTTn0Vqz85XMYxuai2zyZmT
	Khlzj6U+sQEGiwGXIjwcPO/0dJGAcs4Xv65gBRNItco7pzjKCgt3AKEbSo5C5PIA+XxnCZjSHzw
	Ls5oZzfFfNRsrkNlwPoVaSfZnwnHW/A2CUVQHLTgBwdYTEap5EF3RV8ZCEEJr6w8ZOBj/0GjapG
	0p4o/0bD3POll9MtujZJ7pVFUebxCXbMKuLpf1Sf2dyHrvsCRTJKH0E8Uu8TWsssazOcicBrHFq
	IHN0J+IiELfmRb9KmULNWXWVMWRSMBmHqQHEFnH
X-Received: by 2002:a05:600d:117:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-49987ab4e1bmr24402485e9.7.1786687718165;
        Thu, 13 Aug 2026 23:08:38 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49989ae9618sm1475095e9.13.2026.08.13.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 23:08:37 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Date: Fri, 14 Aug 2026 06:07:55 +0000
Subject: [PATCH net-next v4 3/3] net: stmmac: xgmac: decouple the MAC Rx/Tx
 enables from the DMA ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-stmmac-rx-fifo-block-v4-3-1951fd3d33b7@gmail.com>
References: <20260814-stmmac-rx-fifo-block-v4-0-1951fd3d33b7@gmail.com>
In-Reply-To: <20260814-stmmac-rx-fifo-block-v4-0-1951fd3d33b7@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786687705; l=2086;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=0Vwj+Yf7E1Ji8YvFOtq75mgQ/Wgtg5/pWR1g1XG9zro=;
 b=LnFwns+EYkt/RIAKFdCfRUKmnaV61xN7S2an1VxP7zn2xuNjez526gMQes2zTFI9XOaZ6kK4H
 5/E/AvF2/T7AGDRwZWlVD+q5/OhyACmoDs/5PWIlyCnPGg7tS+Xwabl
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=

The XGMAC per-channel DMA start and stop ops also raise and lower
MAC_Tx_Configuration.TE and MAC_Rx_Configuration.RE. Those bits are
global, not per channel, so an op meant to touch one channel
reconfigures the whole MAC. stmmac_tx_err() restarting a single Tx
channel clears TE and stops transmit on every other channel too.

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index df366b2e6bd7..ba4f535fb9eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -268,10 +268,6 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value |= XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value |= XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -282,10 +278,6 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value &= ~XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value &= ~XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
@@ -299,10 +291,6 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 	value |= XGMAC_RXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
-	value |= XGMAC_CONFIG_RE;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,

-- 
2.43.0

