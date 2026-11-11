Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407613;
	b=PbMl9/THTBzmrAvB5D/Kz0vKxvqO8KVBG1Ccc3rOva2pQ1jPekV2Hiz7u9hems/AbxWW
	 RYIAOCDd3k7qi+FL2wZFtKC6z7smGaHWHnpHuNY/moUexx/usmvsZ4mZ8unP+G7D5ANxo
	 NhBKtNLKnaylGTQ7Eha4qIBPmtUPmGHz2Ff2QAZcM8gQDErRoQMPcPAtUWOQ5xnGiFdHl
	 17iyLdVGHNgKQiwyt3z2bT75lArdog67ee50r/aUAGKP/pjaIVuiwOLk4+y3Axyu/YZ8E
	 nvLqm1E9gVjR+fHovFvMN8RjZl/27XLjulCeTsDEpo5msAlg4DbLjtOsgX6YrrBWd9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VlTAfS+aDDJzfuAid+fcFgyn4gZ+nf+2jOp18GNl+aE=;
	b=XB7f5LqrKyfTZ1zFwPM+WO9dpfK828FuGbVCDpAKnBBNPdNHwSArNtZdf9MJiC+4WQKm
	 BzKw7Trkv2MCfibbkiKRd39d86fUG65ArEtSnLZRgLFDhU3AsKSNHsAbT62KEeHnFfS/f
	 9OBpIzc60DqoukcjbaqytCk8tjPMkKDAd4aMuM/h939evUqbNkWEarL/erwVkKJB8jHYp
	 fgoIA1yVg+qYoQQBW3awO44wuh7cg2asJVzthOx8MG3ZUYhaVfi0AJMjAXG0tU0/FxEHE
	 QPL12QEFBLMGEocdYWEARFwkU5p5ruaoVVbPQJgVqjziizAz9gLahyoOwBmZD+sh8cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la82EePt;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3E60A382F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA3E60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la82EePt
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1532733a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794407612; x=1795012412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlTAfS+aDDJzfuAid+fcFgyn4gZ+nf+2jOp18GNl+aE=;
        b=la82EePt5iZ9LBB40kCqXT8j+0mjuB3LVFJBzsaksS2sNUdiRpirY4S8j1teiVP2cL
         3aeMAg/dvZ/pnN2Ei8ogAqRocCEI3YixrmkkcnZEXMJONRwzBI19xTkS4lZIptkFaDI1
         HxeEf3RpSZrEN+2o/0bIOtMjDROcRmjre0oRbBh2nK8afC1Pisumds+bwOXpt9Wlegqp
         c6Dg5UdCiaD7xpbEQJ2hryY9ijm4/TiuOHDovWfJUnXJ40iuW3jHTp2UfQsfAUfRPdr2
         WErj8VesCiVpWoTMzMVY4dyiZa8mb2ukIR7eoL6/ZmrY4zkD7LEc5PY2oEqr46CwbNHJ
         2SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407612; x=1795012412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlTAfS+aDDJzfuAid+fcFgyn4gZ+nf+2jOp18GNl+aE=;
        b=VoNGZ2vogBO72+Ulyw0Yz+Z3Ia/pVOxeX6jEL8jX4aeewkC2p23Mbv9nIvusqyCOS3
         oF5MEt6KL3GQo8QnnSRN/ofLzcAGdX3A9AjHOj5hd3MsVRXJi94bsutPGv1A8dQE0z+O
         FmTqa8c+639qsVPn8qfl6dBT8L2wK+QrCYFblA0J0qQP+J0BgM6bwbu9sGBv0sgLQBVR
         df5j4UOxKHB4jGfetJLUsolaqRBP5XggEbuCrEv47Kuwkub3JS8zMVfSh2DCEnX8X6CB
         GUb+/3E1jG/fN/DxzTgIDQtuwdYvQgXcoOACYxa78wq3wafIWf4JDqZIUQ/Vcx7zV8I6
         bjIg==
X-Gm-Message-State: APuU4Z90YPVWKPKsuAZIGljbrKnTrGTWRJDJHC4RNHHK/NW7JXc6nKgM
	51d9pKfgBYUx7RC/iZTGDznbsh2EZNT58VS/Yd3/W8F9+iE3jn14a7p5
X-Gm-Gg: AYBFou1FdazbmjJ3PW/0q+lFtvBfr4DOTjHU9iYO8GYYy/jvjtvVMS57x8tcbbVUc9d
	2yvKPLHlNTzMif9ofdYwFKGDO32qdXTf/RJQXO9AWgeStOjB6KYFFx60rk5WR1e2z//bgTiaNa2
	PatvKb+B3WxhwuO8bAeCXdAOEYDAewWrVJ5S0Krh8fxudkDpeVhM1YQdTFUZQ7g0VJfyQqvA+ix
	H2QRt8MP5MDXIghZ4eHbvc2RIOjiNpbIwvmBM300NDJk89mB1354aHmxQ+esb9WPf4qxt3nUw8j
	/ZO8w06P0crrnvPYSeUw/A1NEpxGPwB/TQxPSf2lInkFZoLuBT+SviEHcGguZaQth0A8g/jCqxn
	H/j3+/ORvyCaxw0ukErN9kUS0bOGnJ3LK/kefUSpnE4DDfbKhIZNu0ysNTIEj/PysLz1OhclY6L
	JJfE1MgfhYWqTA90dYD0pFLRycY7osFNTlq6Qi7btisc8lRMva8PnOX1AK7FqSdtwVE+xYmZrx6
	jsrbwRBrpK/91Bjlae73LLu8+w2Ddr6D4mml1YzZKCwEuKeLGYPVtff3xji6PNTjGnRaklqJIHo
	rvmlzCdW990gvUDQCW01bAnznk3PtA==
X-Received: by 2002:a17:90b:562f:b0:3b0:b64e:1e34 with SMTP id 98e67ed59e1d1-3b183005a9emr2622998a91.51.1794407612126;
        Wed, 11 Nov 2026 06:33:32 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e0df70asm4981540a91.9.2026.11.11.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:33:31 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	Jose.Abreu@synopsys.com,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH] net: stmmac: program the FSM timeout timer
Date: Wed, 11 Nov 2026 22:33:22 +0800
Message-Id: <20261111143322.2234321-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac enables the FSM timeout checker (TMOUTEN) but never programs the
MAC_FSM_ACT_Timer register.  Per the databook the checker only fires once
NTMRMD is programmed with a non-zero duration; NTMRMD == 0 disables the
timer, so with TMOUTEN set but the timer left at reset a stuck FSM is
never reported and the advertised timeout protection is ineffective.

Program MAC_FSM_ACT_Timer right after TMOUTEN is enabled, deriving the
TMR field (CSR clocks per 1us tic) from the CSR clock rate and defaulting
to a 1s timeout.  A platform can override the default through the new
ntmrmd field in stmmac_safety_feature_cfg.

The issue was hit in testing on a downstream platform, where a stuck FSM
was not reported through the safety interrupt despite TMOUTEN being set.

Fixes: 8bf993a5877e ("net: stmmac: Add support for DWMAC5 and implement Safety Features")
Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 20 ++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  6 +++++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 20 ++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  3 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  8 +++++++-
 include/linux/stmmac.h                        | 17 ++++++++++++++++
 7 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index f1bb981cab7c..4ab7a3df98c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017 Synopsys, Inc. and/or its affiliates.
 // stmmac Support for 5.xx Ethernet QoS cores
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
 #include "common.h"
@@ -184,7 +185,8 @@ static void dwmac5_handle_dma_err(struct net_device *ndev,
 }
 
 int dwmac5_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
-			      struct stmmac_safety_feature_cfg *safety_feat_cfg)
+			      struct stmmac_safety_feature_cfg *safety_feat_cfg,
+			      unsigned int csr_clk_mhz)
 {
 	struct stmmac_safety_feature_cfg all_safety_feats = {
 		.tsoee = 1,
@@ -245,6 +247,22 @@ int dwmac5_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 		value |= TMOUTEN; /* FSM Timeout Feature */
 	writel(value, ioaddr + MAC_FSM_CONTROL);
 
+	/* Program the FSM active timer so the timeout checker actually fires.
+	 * TMR is the number of CSR clocks per 1us tic, i.e. csr_clk in MHz.
+	 * Default to a 1s timeout when the platform did not select one.
+	 */
+	if (safety_feat_cfg->tmouten && csr_clk_mhz) {
+		u32 ntmrmd = safety_feat_cfg->ntmrmd;
+
+		ntmrmd = (ntmrmd >= STMMAC_NTMRMD_1US &&
+			  ntmrmd <= STMMAC_NTMRMD_64SEC) ?
+			 ntmrmd : STMMAC_NTMRMD_1SEC;
+
+		writel(FIELD_PREP(MAC_FSM_ACT_TIMER_NTMRMD, ntmrmd) |
+		       FIELD_PREP(MAC_FSM_ACT_TIMER_TMR, csr_clk_mhz),
+		       ioaddr + MAC_FSM_ACT_TIMER);
+	}
+
 	/* 4. Enable Data Parity Protection */
 	value = readl(ioaddr + MTL_DPP_CONTROL);
 	if (safety_feat_cfg->edpp)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 00b151b3b688..734e7630f28d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -8,8 +8,11 @@
 #define MAC_DPP_FSM_INT_STATUS		0x00000140
 #define MAC_AXI_SLV_DPE_ADDR_STATUS	0x00000144
 #define MAC_FSM_CONTROL			0x00000148
+#define MAC_FSM_ACT_TIMER		0x0000014C
 #define PRTYEN				BIT(1)
 #define TMOUTEN				BIT(0)
+#define MAC_FSM_ACT_TIMER_TMR		GENMASK(9, 0)
+#define MAC_FSM_ACT_TIMER_NTMRMD	GENMASK(19, 16)
 
 #define MAC_PPS_CONTROL			0x00000b70
 #define PPS_MAXIDX(x)			((((x) + 1) * 8) - 1)
@@ -82,7 +85,8 @@
 #define GMAC_INT_FPE_EN			BIT(17)
 
 int dwmac5_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
-			      struct stmmac_safety_feature_cfg *safety_cfg);
+			      struct stmmac_safety_feature_cfg *safety_cfg,
+			      unsigned int csr_clk_mhz);
 int dwmac5_safety_feat_irq_status(struct net_device *ndev,
 		void __iomem *ioaddr, unsigned int asp,
 		struct stmmac_safety_stats *stats);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index f8ab347f7b5b..1fd501728b18 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -169,8 +169,11 @@
 #define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
 #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
 #define XGMAC_MAC_FSM_CONTROL		0x00000158
+#define XGMAC_MAC_FSM_ACT_TIMER		0x0000015C
 #define XGMAC_PRTYEN			BIT(1)
 #define XGMAC_TMOUTEN			BIT(0)
+#define XGMAC_MAC_FSM_ACT_TIMER_TMR		GENMASK(9, 0)
+#define XGMAC_MAC_FSM_ACT_TIMER_NTMRMD		GENMASK(19, 16)
 #define XGMAC_MDIO_ADDR			0x00000200
 #define XGMAC_MDIO_DATA			0x00000204
 #define XGMAC_MDIO_C22P			0x00000220
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..76c850ea13a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitrev.h>
 #include <linux/crc32.h>
 #include <linux/iopoll.h>
@@ -835,7 +836,8 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 
 static int
 dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
-			    struct stmmac_safety_feature_cfg *safety_cfg)
+			    struct stmmac_safety_feature_cfg *safety_cfg,
+			    unsigned int csr_clk_mhz)
 {
 	u32 value;
 
@@ -871,6 +873,22 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
 	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
 
+	/* Program the FSM active timer so the timeout checker actually fires.
+	 * TMR is the number of CSR clocks per 1us tic, i.e. csr_clk in MHz.
+	 * Default to a 1s timeout when the platform did not select one.
+	 */
+	if (safety_cfg && safety_cfg->tmouten && csr_clk_mhz) {
+		u32 ntmrmd = safety_cfg->ntmrmd;
+
+		ntmrmd = (ntmrmd >= STMMAC_NTMRMD_1US &&
+			  ntmrmd <= STMMAC_NTMRMD_64SEC) ?
+			 ntmrmd : STMMAC_NTMRMD_1SEC;
+
+		writel(FIELD_PREP(XGMAC_MAC_FSM_ACT_TIMER_NTMRMD, ntmrmd) |
+		       FIELD_PREP(XGMAC_MAC_FSM_ACT_TIMER_TMR, csr_clk_mhz),
+		       ioaddr + XGMAC_MAC_FSM_ACT_TIMER);
+	}
+
 	/* 5. Enable Data Path Parity Protection */
 	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
 	/* already enabled by default, explicit enable it again */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 8ae95e91a36a..395655b01ea8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -378,7 +378,8 @@ struct stmmac_ops {
 			     bool srgmi_ral);
 	/* Safety Features */
 	int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp,
-				  struct stmmac_safety_feature_cfg *safety_cfg);
+				  struct stmmac_safety_feature_cfg *safety_cfg,
+				  unsigned int csr_clk_mhz);
 	int (*safety_feat_irq_status)(struct net_device *ndev,
 			void __iomem *ioaddr, unsigned int asp,
 			struct stmmac_safety_stats *stats);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f8dceafdda2d..52f63f624d67 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3639,10 +3639,16 @@ static void stmmac_mtl_configuration(struct stmmac_priv *priv)
 
 static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
 {
+	unsigned int csr_clk_mhz = 0;
+
 	if (priv->dma_cap.asp) {
 		netdev_info(priv->dev, "Enabling Safety Features\n");
+		if (priv->plat->stmmac_clk)
+			csr_clk_mhz = clk_get_rate(priv->plat->stmmac_clk) /
+				      1000000;
 		stmmac_safety_feat_config(priv, priv->ioaddr, priv->dma_cap.asp,
-					  priv->plat->safety_feat_cfg);
+					  priv->plat->safety_feat_cfg,
+					  csr_clk_mhz);
 	} else {
 		netdev_info(priv->dev, "No Safety Features support found\n");
 	}
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 00be2df63d22..cb470a153bf8 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -168,8 +168,25 @@ struct stmmac_safety_feature_cfg {
 	u32 edpp;
 	u32 prtyen;
 	u32 tmouten;
+	/* FSM normal-mode timeout value (MAC_FSM_ACT_Timer.NTMRMD). The TMR
+	 * field (CSR clocks per 1us) is derived from the CSR clock by stmmac.
+	 * 0 selects the default 1s timeout.
+	 */
+	u32 ntmrmd;
 };
 
+/* MAC_FSM_ACT_Timer.NTMRMD timeout durations */
+#define STMMAC_NTMRMD_1US		0x1
+#define STMMAC_NTMRMD_4MS		0x2
+#define STMMAC_NTMRMD_16MS		0x3
+#define STMMAC_NTMRMD_64MS		0x4
+#define STMMAC_NTMRMD_256MS		0x5
+#define STMMAC_NTMRMD_1SEC		0x6
+#define STMMAC_NTMRMD_4SEC		0x7
+#define STMMAC_NTMRMD_16SEC		0x8
+#define STMMAC_NTMRMD_32SEC		0x9
+#define STMMAC_NTMRMD_64SEC		0xa
+
 /* Addresses that may be customized by a platform */
 struct dwmac4_addrs {
 	u32 dma_chan;
-- 
2.34.1

