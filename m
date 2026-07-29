Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2B383328
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292625; cv=none; b=Hh94oAnz5DqFnWZYwEnj0g0uQvJeyYgnM9P6ovnDNMK93Y0QZx5a2U+5kMJIjVlUfWqPIt51D3IrkgXvjWNhuI/UElkTD0K1uLPX9lxROMkYGrmxuecUpLFbHl/V+hk5cqhlY6Ym484K3h5Xi+gPBpHkGBvmoDg4ctfs/fQQ0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292625; c=relaxed/simple;
	bh=G0eQe94UGnEDq42YUUBTfOszMzv9xh/fS/Xie4nDM/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l22KyDKxUy0GMXnPU7kGPBmSHI2hqzsNVvV9cbmiCX4pIcViDqqzGO53PDuV2Wcms1JKE3Un4PDRGLphMKDPWjHs+gT7t8gr4m9gMoT1U9N9bZ+AZMB/i9PGloUD0SMLoqghxaIDlCfFamA8GBiznGrnoFcYLDDFyByg2AQIUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvpRM/Qs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvpRM/Qs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso437447a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785292623; x=1785897423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccx3GkKYh9dfgEwxuiyxP74uJBByi7pq0wy57OzgWVY=;
        b=mvpRM/QsxPI1tu6WpBpO293ttpc33q2Xpb/4vH8fiFtWZyzviC0PgsLtGsJt8Aq9xH
         SA4we7E1sfLpS7mGWauMLz1RcF8rrAM/bhLQ6TqTUpF4V+GiCvrgIV4sfHyo/8hCXqc8
         BX3E+sb6QxNYidblb6AGJ+1YIXCvkBvsw6tEhF1NxOUHifKVfzv3c16ZLV4V2whFyGBX
         56O9lRIdvyrqAa8z0o7WO2IEx4n+fZByTHqHQRzs5VwVRKe7cfRW0FfOzLoiOSRuCuUg
         4U2PLctV4fyAoRDBGZS5IzbHcg3h2w2lLKZVD5Hpo7k9gr3CTKm415p+TqXwwUbBUjbv
         sdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785292623; x=1785897423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccx3GkKYh9dfgEwxuiyxP74uJBByi7pq0wy57OzgWVY=;
        b=nO3SAlpWNGb5YARxXqLC2arfuo7I0mHIBLvCHFzqcd303LpXmXLvlyBon+WRv8mEHp
         xAhnL+/S2PI4Pg+NmqaZYgeySCtLpK+qSE26L/A7eKLIcyQ9DJWJ09uhszZ4Bhym9K5z
         mDblMP2DWY9xizQF2FmKSitZySTLgnfZoXTh1u3iHZgqGILEIYac3sxO0wLQoR9JvT8E
         W12zZm5N/dPgecIbUTW6PJxGFFwvpG53E+wd84zn4sCN4VtiYIJ5m/29xxnQOxNhzWWP
         sCLN0jADQPvisCrt/dahgKaafqzwL/ClFPNow1vIF/seVH7aNy/xkpVnkMq1Xunc7u//
         VMsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcljovgMFJ0gx/ws+/P+lGviELuRqKT9/npR29l+i5rEQ61SKB8A4Yw44Zq9P9n3BZbzLehXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQ4HpN2yijNfr/448fRWO9VXvnfYMFrYUd8FZRDyWzWFIHrng
	0DkzHUEyze94XG2Np/bLomIo+ujA3oXydnRfbKoi/3UyeiXI7pICQn7m
X-Gm-Gg: AR+sD10SO6euojbCIyAg0vceeg48Qek48FbIvPOz6QUlrv+hgS5xw3yCIAyK71con7x
	qZCGR4G6CB8J0GemcUdTS9rEIqRWtgF8H1hNHMMC9ZIKoxruFOAmlmUShjX/WUNdXC/61kTKL9G
	HM9wGXusSOO14DkuCq7Y3c0w4SnErQl2H0FufzG0PiWxexGug4g1LNF7h/hrgEKQfsn+qvMuQF2
	bRLIVQ7vknpxusnf/g5Z5NvLSkH1OgJMj2ApAe/LJhGwXTyd4RDFtl+rILUnw+Hk3DdVFAJ/+w0
	/PVSMVVh4hp6XLi9uWtNsFQek60fbUeCNlJfjVfaojGTU/44CZjn/wiaTH7s7gjxElxDR2QFCZy
	Dj9/ZgGBDlAvES7U0WWPAIcIQqqxKfNwvER1sBn48iPfSoyQVQdbsyMax+SuXEtWiCLUJVslAqS
	F0Q3sv3LXpQzq2zTSscKgcPU4RSb5P4DHhcxlZQt4rPlXkbx8ah+aqfb63SiI=
X-Received: by 2002:a17:90b:3ccf:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f6a53f749mr5146544a91.40.1785292623411;
        Tue, 28 Jul 2026 19:37:03 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412ba8csm2024895a91.7.2026.07.28.19.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:37:02 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v2] net: stmmac: dwxgmac2: configure INTM for per-channel interrupt routing
Date: Wed, 29 Jul 2026 10:36:53 +0800
Message-Id: <20260729023653.1162763-1-zxyan0222@gmail.com>
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

When multi-MSI is enabled, per-channel TX/RX interrupts are expected
to arrive on their dedicated lines.  In the default INTM=00 mode,
sbd_intr_o also fires for DMA completion events, but the multi-MSI
handler stmmac_mac_interrupt() only processes MAC-layer events (LPI,
PMT, timestamps) and returns IRQ_NONE for every DMA completion
interrupt, resulting in a continuous stream of unhandled interrupts
on the common IRQ.

Hardware verification with XGMAC and multi-MSI enabled:

  INTM=00: 5.4 million common IRQ interrupts in 3 seconds, ~1.8
           million IRQ_NONE returns per second.
  INTM=01: 0 common IRQ interrupts, per-channel IRQs work normally,
           10G line rate works correctly.

Set INTM to mode 1 when multi-MSI is enabled.  This matches the
existing GMAC4 implementation.

XGMAC multi-MSI has never worked correctly since it was introduced.

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

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
index 03437f1cf3df..ff83858ebc1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,16 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	/*
+	 * Route DMA interrupts to per-channel lines when multi-MSI enabled.
+	 */
+	if (dma_cfg->multi_msi_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
+					 XGMAC_INTM_MASK);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,

base-commit: 1df10cef2d1e7f9f2fb7eddb67fc70d3abf101f9
-- 
2.34.1

