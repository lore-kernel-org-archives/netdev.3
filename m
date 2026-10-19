Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264B39CCEA
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378903; cv=none; b=nQ/izOUmWpMm+tP+OA/A6s/Vb8GLO46bweq93adh2E8YfiutYxkXzu/w3q3XDqBIAf5OKgrZz92rMmEVdWz1BSgjphLtP3CE5EuE5U0bn1Eq7kYIutcdiosmLcrFgDx2z4Gahl+LEk9nrnRnv2Rmw7CulzVsF/aFXD29fY8EHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378903; c=relaxed/simple;
	bh=KUzDfA55VWCYv71Z2RlGmJ55hfO3CvJRsnX0M0VB284=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goL8KCtqR76Pdy3WTpmd/O6WSVbA8N3rP7YZgKyKavc93Yoe6ZpAtlw5Zsn31LeXhbJFAbo6lr5bDKsGMDsdq9nxINyoEm6uP7kb1GY1Ae9QFalVHnaDNJ2Vn/r20YDrJzaPOnuFiVT+StIfaKqWMeFmG8BVGVDjyB31ixnFOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=zKWIErwB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zKWIErwB"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ba702cceaso20653366d6.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792378900; x=1792983700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvw4syNS+titZXjd+BAVQh8BZuoN5qywIcBOPbcEmbk=;
        b=zKWIErwBqx5rS/OGsYn9S8D+U3JSZkg+jsZUqrTDIzlW+xYpHSr5YYo6r4ypNKO4vb
         Kiyaeh1Imx4waxVVSj3kPyi+O/l+Awu2t3OjyJcdKeaPLvxrVxe3v57lq6R1JOYCu/az
         oXLdDla47e4HcNCxcbn7yJ916JnMK2n6HMXifHuYGgq7YShMUHnkiSAwgXy3z3dt3Mh8
         Cc9R/qesJsSFNEhE1SMO7cpifOXfNutpmS7hVRWi+ftZYsWrrDE91wIWZxtdgCFbdnYu
         sMQKqo1EZTJ8alvQcsfvnHwYiDofDUjh7dIfmOQSIzTfr5zPbmqr4YROzj1XPbNNKd4T
         qP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378900; x=1792983700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvw4syNS+titZXjd+BAVQh8BZuoN5qywIcBOPbcEmbk=;
        b=HPSdbaynNfnAs38+Ejt4xT8shNiV3Ldo9CzdxTtg8l/bjV0LS3QzD3gGHXBQX56HdY
         plnlEkY/MbK4/K3glJM+zJgqdU84xsSoszBVJOR9+pfd5F2zIJh/EmEiXFd9132slG6p
         962i065L8RdrPd6bKmPtqG1YUOznnbatuVLCawdTKR5/QkkF/cto83JgKpsAaC5w1BfH
         4TEgtrEAgEEPSjBAU1lSz5mD4CgV5fksEcLR+fXQ9aUUslS4mrkzg9ej9G5mO20G7zRC
         CA378Zru+1WYBPd6e1N0NRXWM+hfRbZ9W8b4satlbq1pwyluo3C9t3QbIaPGYA3fsJwj
         AwGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv/p5swG0QjUYT9A2URzYsmgasNjLmKQ/e7og7LGYtp8T+hI3s2oA/TVimRJBW7tQ9I0hhq4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0JG0kvLyPt6YWWX7pnCVKZFeUl2ZmC2218fwfmRGjbkp9QyJT
	LoE1jngu15bSapvNp8MGextwD6Q1/yKKRPEzrH1D320nksIQEzOnYT0kJcQmft996Kw=
X-Gm-Gg: AYBFou3AFy+t6n31t8rFgunLg9Pn2Hg3j+0Q8sWMyHvaWkxriU6kkN+WEVOaP0Rwf/P
	XCNa0nRDJQnek1ap4xUbw9eA8NVbOdvta5kanRcbUlXnKL3wsnJQq7vBkDjNOe7Ve4qUdKN3m7G
	CdT8d1VJ/2yMtp+4/knUzQ9GF85sG7YcgPm1LNsvVUCMMv6I6D0h4RlVZZ5rAYfERwXypYjooiD
	Z9CWqJatm+hQKqeICzyl251zRPdrAmiNLupG9U/HSphu53MG/xq7wyyQO+nko2We6DT0Cc/yp/L
	HDX0FdL4p2oy8fFRfIaeTWzt7elrSlBlLYBEFGphLBdx15lMdYUgduOVo1F2tnrqawXsgfBWJMF
	q7fZ1MK8xXCgVHZiA61PlDPVG8ULa+5+jxqclk7uM17b1Ogw2bTdT1E03ySETXCySNVIP+yFeyn
	QSSGdecVmpDOyffJu8x0jMl0BzbYH89ogLTmpBJO3p+AsSVYqF7x7ds0p7ns3oARpkBpKj5qe+T
	fwB
X-Received: by 2002:a05:620a:394c:b0:93e:c12c:4416 with SMTP id af79cd13be357-93f29df8910mr1058004285a.82.1792378900653;
        Sun, 18 Oct 2026 20:01:40 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3c61c440sm216840185a.10.2026.10.18.20.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:01:40 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	peppe.cavallaro@st.com,
	joabreu@synopsys.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
Date: Sun, 18 Oct 2026 22:01:27 -0500
Message-ID: <20261019030129.1470307-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019030129.1470307-1-elder@riscstar.com>
References: <20261019030129.1470307-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Toshiba TC9564 is an Ethernet-AVB/TSN bridge and is essentially a
small and highly-specialised SoC. Ethernet on this chip is provided
by a DesignWare XGMAC.

One consequence of the SoC-like design is that the internal AXI bus
(used by the XGMAC for DMA) maps the PCI DMA space with a non-zero base
address. This requires a translation step (happily just simple addition)
to convert the PCI DMA address to the hardware DMA address.

This is pretty funky so rather than push that translation logic into
the core driver we intend to keep that logic inside the TC9564
platform code. In order to do that we need to export a few symbols
to allow us to override some of the DMA and descriptor op tables.

FWIW this approach to overriding the ops tables is similar to the
mechanism currently found in dwmac-loongson.c (with the exception
that we have also exported a couple of functions so we don't
have to replicate their content in the TC9564 platform code).

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h |  7 +++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    |  1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 18 ++++++++++--------
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 0fe86e9942334..1b32d14c37440 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -470,4 +470,11 @@ extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
 extern const struct stmmac_dma_ops dwxgmac301_dma_ops;
 extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan);
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan);
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70ca..0effdd6969d65 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1542,6 +1542,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_setup);
 
 int dwxlgmac2_setup(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 6719ac6e395bc..f0e7b8ee48ac7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -374,3 +374,4 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_vlan = dwxgmac2_set_vlan,
 	.set_tbs = dwxgmac2_set_tbs,
 };
+EXPORT_SYMBOL_GPL(dwxgmac210_desc_ops);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index f9a77d641eb65..2f9334d7cb922 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -63,10 +63,10 @@ static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
 	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
 
-static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan)
 {
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -78,11 +78,11 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_rx_chan);
 
-static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan)
 {
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -94,6 +94,7 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_tx_chan);
 
 static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
@@ -673,3 +674,4 @@ const struct stmmac_dma_ops dwxgmac301_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+EXPORT_SYMBOL_GPL(dwxgmac301_dma_ops);
-- 
2.53.0

