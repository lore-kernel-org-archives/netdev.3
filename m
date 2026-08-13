Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECE36920F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607413; cv=none; b=OMjqGPWbivvCgHcHJuKDlm616KNNnNT7D6wvPPt9i2xUkOZVkwIRdv7W+2WPmMoobQHY3A1yIghUw1VwF74DHxfwkdKsJMd+lBr2l2YXk1QvmwdN8fBCQYtIRnJ1EGLCq2vtZJo6hQg+mIDRZqx7GyDHztfApxtkFfh2rsr9/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607413; c=relaxed/simple;
	bh=qmoEogHzK1kCxSGOvURN6pvKNeVEIJOqlmVkcFUU4k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ot6K0Su9kYFNMtBsQ76I+cCMGbt3O/WrkWTKIr4if+21kL2HIZIbnPLZQfzXlDpzwNAKTAXEH3JZImcoSlcFNl+U1j6sQEZNpkzefHvHaHbLO6/Pr0x0di1bpLFfEOTeqHh3N2SyAyBwfziN9itrOqDHtGLA6q/qrdwwbjeRNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/fhOWNr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/fhOWNr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590dde14so21755565e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786607407; x=1787212207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcoqLP70vWvElPZN0/ESQigbvyY/ROtDk2j5xluq2dU=;
        b=D/fhOWNr8pD9AbPmJu0fww2THVBfojGN87ruNXJb3DCKnbj6KhN++MKnurFFDHmJT8
         uw8uXgRrPECgMcQnxm0RMHIFgH7QPtfEv0KUgIw6Yr50W7WbnPMYZv8ZHoSa6mCeguQW
         rMQSWKexGHM1IGNND3iMdHwE53o4kejSBYqVt5iT5x/MSPGho5M38Zp07RD1rnAkSIY5
         k5P2v+hLHLHbV0wZxcmvp7X4Pogh2LN/Y7/WVQFZXEG5XbAKiWeyQhUNPnkwuEs6JnCR
         ziKc1F4ikx1b3f1Zp3gLO53WDfogYL93+aiAqOgwKBBL6uLiBJ+K2uSHTYKTPNebdTM/
         Uo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786607407; x=1787212207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcoqLP70vWvElPZN0/ESQigbvyY/ROtDk2j5xluq2dU=;
        b=kfdOAuHCXOLpB6yvz/5QWW4vi35QZMXZSBiSCNMulmKaydRyheQzPsDdptDIZ9NMPW
         aZrQcKKwaW3EE24cfbLfl2rQD1X7JS3Ks4/8ibbdUWyNl4IBs9LdVpiZ67EURRo8y7DM
         a8jvaYXGDtrS8OpCtCMV3vDusS8o1Z5cCKIibKfF7lyJJDwF8Ys4kWQD9qfVeKQj7Tji
         s2sqz20uFqsIG7RdickNa+U0OmKtF10cjdXQ8KuoT++OPr0+zRAxJRR7kR8S3z0Yc6PA
         CAmYm1JNaDD8m7aYc23AQnohmYsDKyMzeBkmH1vKSyE1elwOM3FzDUv1fPhLR/YrOBg8
         kdQg==
X-Gm-Message-State: AOJu0YxQGu5vIjPoemIjcsz25UUZ8UGNP1LLOP0GGHTc6r4M6/yGvoDY
	+Kd0zF1Lux5I+hD6vz8OJaDTU/I1AMTyMx5vwfJSEr81iRLgmAPB90ZE
X-Gm-Gg: AR+sD12oRA8fAwbtakf8LpQDFpeLWZCL62Z5kzu2tafp6tGVebFLv/4AbY+XHs2EPBU
	CdOLxgG+4W0AQ/PNmkZqQrpxjF5xU796T2WQT3mKACUmUScOYheY0I8A6zznZj1fomxbYbJO7fe
	13nfQ6DC5lnv8HuJSW00ovjSgSTNqHoKU5MGQv8LROYm+7TiUPNb7yvTNsFN9lFTbN6CjZeWaZQ
	C7TXXC64jYw0VajnOJ0khEpstYBiMJu6k/8Zf/QEugwoCdanjQHkDpIKMB6/ph6u0cSm+XsTDx8
	TVqlIcYQZmHOh8b52LP5bwma3yWQg+BiOVFqW0TCK7XBH/QKvEPGLTqdSQQbzqoHzEJ4IxMNdg7
	jX5PZtNtIJ21hPuTjw5vv3xLE4EjCyxp7nxLM+V8UeJfwaFokVyqJYdIUK4PXkMfDItwtRbMmHU
	0MSBtQsHNgJYNkg4f8SMp3elF5T2vIiq93m3tl9Gmuia3kRoOaHVxd7qwxLihzx3Z1asHDd8jEb
	TxPdpW1FJn0SNJQ5YKCvkz7rmhb0pV9wv8vPejG
X-Received: by 2002:a05:600c:1546:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-4998218451fmr42945125e9.7.1786607406518;
        Thu, 13 Aug 2026 00:50:06 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm41936365e9.13.2026.08.13.00.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:50:06 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Date: Thu, 13 Aug 2026 07:49:29 +0000
Subject: [PATCH v3 3/3] net: stmmac: xgmac: decouple the MAC Rx/Tx enables
 from the DMA ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-stmmac-rx-fifo-block-v3-3-738acbee55d9@gmail.com>
References: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
In-Reply-To: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786607395; l=2080;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=qmoEogHzK1kCxSGOvURN6pvKNeVEIJOqlmVkcFUU4k0=;
 b=rzTcfJD/m9BixYhCaji13vn4qbBwNoxVD/oaLnmlUzxXCfmODBqWnrSf5nTQM5ppGCPRJBZDt
 IApnsUdlaZ4Ai1SmPMzKD0imBYft7f/SrzI32pt1QtDnleeekqzlx/F
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
index df3700a0d..8e27bc58c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -258,10 +258,6 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value |= XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value |= XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -272,10 +268,6 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value &= ~XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value &= ~XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
@@ -289,10 +281,6 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
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

