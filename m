Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4B4D8D96
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813130; cv=none; b=baZcpPKcKpiz4mOSJxX4aLVU3D4aPiHhKvo+4qukwFyPOoQ1KfcSGUZK2xhCEXDlAJOQrfdvUQkPpajrHDAbb8VIxBOlRznVRiZ9IcoybwOELMLAc9GGdnYnRX2BSNJh65kGARvdmqRwLkYKJ0yv41WMPuDFn62rfx9IDp+jPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813130; c=relaxed/simple;
	bh=wZsCoPkTgHzBu9K7Ak9PeC79qYVHtQQhOTSQAiUBVik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgAr7W3TYtmTUOnIppzNT5YHtHObYl5lGemkYxKX2XpGPwlSJL8hngLtj6tsJuU7LmoIxLzR/pdkkw3pb60w9CpT1OIV/OgZPd5MO6w48koBJ2A1oilMUK2cweblVY/oq29RO+tLNHRg0p5K2r6vb8xZ+RTYyZin2O+KfXO1FIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjXGa2UE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjXGa2UE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc73e322dbso7117865ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784813118; x=1785417918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JTjiazDh5FKjOsUkRzuqEDvZe9qzhZWScYBrtV4u96s=;
        b=NjXGa2UErxw89xrGVX8V0qdKRRhhQFX6/rl1O5weeaiA3wHdNkFqD3pDsSuwBkm51S
         PrUrKnr2ax6UVP9Ei69nXHnVOuuuNjxkEHHFBA+pxMgHDnZW/IyXB9dTmQOKpmf272xW
         ft0hk743NpfYZnuZvLPcWndu9ElRM6pcp2NmBDfuAjHMVeY0RKeVe8GKGcdHO1gsu0b3
         RA20wJL5h4fdNQPE0jyl3/IReAh+IfdgUaSaQRHSgFb2FnpauCVYbqEvKmIl7XKdStTb
         8ji5DWKZ5pLaaZ5aUPHtwP6uRlaERcjIbZ01OiYFC7f1L5RO2EPbJIz7WLhob7PXg93w
         /N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813118; x=1785417918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTjiazDh5FKjOsUkRzuqEDvZe9qzhZWScYBrtV4u96s=;
        b=l8mnSpHiO8879A108kM7KjEP2FKnDaw0Lm0wcEsgfgkCs/IOafmGxSgPAWeg4RbQFI
         nKK8fCsPm6Y83EmRrBe1BcI4wKGfpitXjnLCh8Np5LbGcNpHDUH04ZyvR4uJmj7g1bvS
         +Z2kLleDyu3mGpJa/PUQfokLdADfusjue4kYed0LU0OR6uLBdeiLF8f9DuclJR9uwiUC
         TWZTCDY3cSp4AE9EQNhOG3/fmLtubgBroOykKxefG93WN1o2fxZ1AdVOxLoHZytdKYAG
         Hr9tQFxJfkWhR9E0FFyGYHitKeE/jHWP8X1Uj3fvhbJWilK/W/CI+6czwmVRHnVfLVj9
         JqUg==
X-Gm-Message-State: AOJu0YyBW2P3qjEXIA73BXJi0dKRcI3kUCYTC/osqPzEk45IcsVUVN7D
	UKp8xB/E9t8vqb31HqR1FXlxhGBiSfv2PcbJAZ3Ab8AzUkQnN06MNZup
X-Gm-Gg: AR+sD133egKkAqrL0bng+wryCWyZqe3rc0kAwhPRZJRUlwKMI2muOtaPeFi9xpiK+8B
	7BudeIEzfG5vHlWnobuDeZI917FS0zwthuNWZ5a+MoIAnH5BxYR4EzVKDI9be89LIykd+l7lW9M
	q+ZkHGHVLbWKStzR01VXtSTc7Nmeci0jjYKKRtOFmGvKmUBo132lJ1gwmh1+/HVnjHOiOSVM2Gv
	l/PIdG9wInuiaz9cuMlQYiBOVD0FT4fyO/nCOSb6g3jtX02pi/WzKPj0cEm0rvRUXLsAy1WIurU
	N9cnJEPhYYwnAE/0vPzCYuaDwsb1e1sZGdfzdEzYiugro+v/GL/T1KeEs4Y+oKRlKqro4B7AlRo
	3YSL7SySD4sgG6bEzDLOgolw9wLGyfyKYhrQRSWaadnSRdUDGs5Mhstwgad1JHCx1qG7RsWcDUW
	zX
X-Received: by 2002:a17:903:1a6f:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2cfa66fe5cfmr33598455ad.0.1784813117547;
        Thu, 23 Jul 2026 06:25:17 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa38aasm33870895ad.7.2026.07.23.06.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:25:17 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next] net: stmmac: dwxgmac2: configure INTM for per-channel interrupt routing
Date: Thu, 23 Jul 2026 21:24:57 +0800
Message-Id: <20260723132457.3061337-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XGMAC DMA_MODE register has an INTM field (bits 13:12) that
controls interrupt routing behavior for DMA transfer completion
events:

  00 (default): sbd_perch_* are pulse signals, sbd_intr_o is also
                asserted for each completion event.
  01:          sbd_perch_* are level signals, sbd_intr_o is NOT
                asserted for packet transfer completion events.

When multi-MSI is enabled (dma_cfg->multi_msi_en), per-channel TX/RX
interrupts are expected to arrive on their dedicated lines
(sbd_perch_tx_intr_o / sbd_perch_rx_intr_o).  In the default INTM=00
mode, sbd_intr_o also fires for DMA completion events, but the
multi-MSI handler stmmac_mac_interrupt() only processes MAC-layer
events (LPI, PMT, timestamps) and does not service DMA channels,
silently dropping the interrupt.

Set INTM to mode 1 when multi-MSI is enabled, following the same
pattern as the GMAC4 DMA_BUS_MODE_INTM configuration in commit
6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for multi-MSI").

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 61b6d45a02f5..f8ab347f7b5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,8 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_INTM_MASK			GENMASK(13, 12)
+#define XGMAC_INTM_MODE1		0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..72aceb06f5af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,15 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	/*
+	 * Route DMA interrupts to per-channel lines when multi-MSI enabled.
+	 */
+	if (dma_cfg->multi_msi_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value = u32_replace_bits(value, XGMAC_INTM_MODE1, XGMAC_INTM_MASK);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,

base-commit: 1df10cef2d1e7f9f2fb7eddb67fc70d3abf101f9
-- 
2.34.1

