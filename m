Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565206;
	b=3W0QGJXD4kNKWDVBCUYT5+y5iQT/t3PrYe/FY/CXtu5YVjynJNApABaFeeguC1Hio/PQ
	 zQVsEZusqGG+qSTuo6LJitlQ7dAaCx8zYs75cWuX/dAnRhrqJn1DCaVerwMm9PObJrBNs
	 gjk4jLeAQU0g25DlkFcgBmRR2FGnlXHpTlps1q4XiX2uflLVFjh+RBhjTMA/3rAgDan/q
	 2LqOX3lIdcMc4/cL4fWEgpnsIM0AQ74rzjtvFOZU83zfX/mmEK9QtnlIxdW1aAakLtvor
	 G53b5sWmrULioVDF5S7D/cbvo6Hk5ZqI0LPLOreEV4WvPKPokbyrwlgW472NL4ljpuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565206;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=wmZTKP8AkFpo88yYS9lI1c1Yb1KHZ45faZHvkLABff0=;
	b=o9kCObvjjHJy542rHzr9xThn55r8+fmQy8bw4Yu+w63D1AlAqYyeVGcAIyBF8EPzsx95
	 QRE6pm9+ec9cn/1W2qavTWbo7eY9lfMR98wKnqKnnJSzFjgnOzmCcaDXgc98RrUZiLmdR
	 nhWFNkc6gSxdcjF2UhgLrSMZ3ZNPtgK5618VMHqX9qf18+YmC5xPPJA08xXQg4i/2VpFT
	 KijBC5YKJ8nMlmQuiZi7QpxO5uFEk7dIzv9E3kBtOg4iUBL+jFy+mMYCW43hXCgv7wDkc
	 iofVI/58k3uZgzgVv2tV8x8ReYIkXFDNpIiL9T+Pl5EgJOIWkTErSv6KITx+Vobj/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=X1491Fen;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED49606A88D;
	Fri, 13 Nov 2026 10:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED49606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=X1491Fen
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794565205; x=1826101205;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KHzBl8IqRRN8d0OWf58A1H+V0NtTw3LAiHJ4yCsHqRA=;
  b=X1491FenNgx5RcpKN6c/jna3/eSNQuOYShT3azNUdYNt4fpa6LYCiJ7k
   l4uzfe2PUpy2HJ83Cj+Qf1dRzWBUjczzo4rrt26mMUQdXD/SGcr4k3nqh
   /lkhbiA4M1v4rwLeAlWQ2UNkFEaZ70952W6QQGZThfwdZJKbC63imzCz3
   wR5VjDjmoA4dsSWnsEOR326ZzCvQujBJDUUzk9ehPOFGyvmP4ypHsoaL+
   H9Tmw/Yk8xze6OcmCsYnQtaHfRBMGvY0dDIRHh1wP2OqxzE6YyrLsytUQ
   suwVXVyFTiUUOGwVQXKtuBc/hU0TwJFyQlS7UxRBNWw9FUXHv+sXjG+PS
   g==;
X-CSE-ConnectionGUID: YE4i8/bMQBio6/YwFK363A==
X-CSE-MsgGUID: 8nzJ/0UoRn6kBa+fUPonlQ==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="77158701"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2026 03:20:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 03:20:05 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 03:20:02 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 13 Nov 2026 11:19:40 +0100
Subject: [PATCH net-next 1/4] net: lan969x: add the core PLL registers
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
Message-ID: <20261113-lan969x-core-skew-v1-1-b9b02b863d38@microchip.com>
References: <20261113-lan969x-core-skew-v1-0-b9b02b863d38@microchip.com>
In-Reply-To: <20261113-lan969x-core-skew-v1-0-b9b02b863d38@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

Add the CHIP_TOP registers required to configure the lan969x core PLL,
and map the CHIP_TOP target. They are used in a later patch of this
series.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |  1 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 82 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index c02499d1b297a..df211e608056a 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -13,6 +13,7 @@ static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
 	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
 	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
 	{ TARGET_GCB,                 0x2010000, 1 }, /* 0xe2010000 */
+	{ TARGET_CHIP_TOP,            0x2020000, 1 }, /* 0xe2020000 */
 	{ TARGET_QS,                  0x2030000, 1 }, /* 0xe2030000 */
 	{ TARGET_PTP,                 0x2040000, 1 }, /* 0xe2040000 */
 	{ TARGET_ANA_ACL,             0x2050000, 1 }, /* 0xe2050000 */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 1bf7dabf622e6..071d2f013a195 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -26,6 +26,7 @@ enum sparx5_target {
 	TARGET_ANA_L2 = 7,
 	TARGET_ANA_L3 = 8,
 	TARGET_ASM = 9,
+	TARGET_CHIP_TOP = 10,
 	TARGET_CLKGEN = 11,
 	TARGET_CPU = 12,
 	TARGET_DEV10G = 17,
@@ -2636,6 +2637,87 @@ extern const struct sparx5_regs *regs;
 #define ASM_RAM_INIT_RAM_CFG_HOOK_GET(x)\
 	FIELD_GET(ASM_RAM_INIT_RAM_CFG_HOOK, x)
 
+/* LAN969X ONLY */
+/* CHIP_TOP:HW_STAT:HW_STAT */
+#define CHIP_TOP_HW_STAT                                                       \
+	__REG(TARGET_CHIP_TOP, 0, 1, 92, 0, 1, 4, 0, 0, 1, 4)
+
+#define CHIP_TOP_HW_STAT_REFCLK_SEL              BIT(1)
+#define CHIP_TOP_HW_STAT_REFCLK_SEL_SET(x)\
+	FIELD_PREP(CHIP_TOP_HW_STAT_REFCLK_SEL, x)
+#define CHIP_TOP_HW_STAT_REFCLK_SEL_GET(x)\
+	FIELD_GET(CHIP_TOP_HW_STAT_REFCLK_SEL, x)
+
+/* LAN969X ONLY */
+/* CHIP_TOP:CORE_PLL_CFG:CORE_PLL_CFG */
+#define CHIP_TOP_CORE_PLL_CFG                                                  \
+	__REG(TARGET_CHIP_TOP, 0, 1, 212, 0, 1, 8, 0, 0, 1, 4)
+
+#define CHIP_TOP_CORE_PLL_CFG_REF_CLK_SEL        GENMASK(29, 28)
+#define CHIP_TOP_CORE_PLL_CFG_REF_CLK_SEL_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_REF_CLK_SEL, x)
+#define CHIP_TOP_CORE_PLL_CFG_REF_CLK_SEL_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_REF_CLK_SEL, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_DIVACK             BIT(27)
+#define CHIP_TOP_CORE_PLL_CFG_DIVACK_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_DIVACK, x)
+#define CHIP_TOP_CORE_PLL_CFG_DIVACK_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_DIVACK, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_NEWDIV             BIT(26)
+#define CHIP_TOP_CORE_PLL_CFG_NEWDIV_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_NEWDIV, x)
+#define CHIP_TOP_CORE_PLL_CFG_NEWDIV_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_NEWDIV, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_FILTER_RANGE       GENMASK(25, 23)
+#define CHIP_TOP_CORE_PLL_CFG_FILTER_RANGE_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_FILTER_RANGE, x)
+#define CHIP_TOP_CORE_PLL_CFG_FILTER_RANGE_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_FILTER_RANGE, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_DIVQ               GENMASK(22, 8)
+#define CHIP_TOP_CORE_PLL_CFG_DIVQ_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_DIVQ, x)
+#define CHIP_TOP_CORE_PLL_CFG_DIVQ_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_DIVQ, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_DIVR               GENMASK(7, 2)
+#define CHIP_TOP_CORE_PLL_CFG_DIVR_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_DIVR, x)
+#define CHIP_TOP_CORE_PLL_CFG_DIVR_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_DIVR, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_ENA_CFG            BIT(1)
+#define CHIP_TOP_CORE_PLL_CFG_ENA_CFG_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_ENA_CFG, x)
+#define CHIP_TOP_CORE_PLL_CFG_ENA_CFG_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_ENA_CFG, x)
+
+#define CHIP_TOP_CORE_PLL_CFG_LOCK_STAT          BIT(0)
+#define CHIP_TOP_CORE_PLL_CFG_LOCK_STAT_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_CFG_LOCK_STAT, x)
+#define CHIP_TOP_CORE_PLL_CFG_LOCK_STAT_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_CFG_LOCK_STAT, x)
+
+/* LAN969X ONLY */
+/* CHIP_TOP:CORE_PLL_CFG:CORE_PLL_FREQ_CFG */
+#define CHIP_TOP_CORE_PLL_FREQ_CFG                                             \
+	__REG(TARGET_CHIP_TOP, 0, 1, 212, 0, 1, 8, 4, 0, 1, 4)
+
+#define CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFI         GENMASK(30, 24)
+#define CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFI_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFI, x)
+#define CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFI_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFI, x)
+
+#define CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFF         GENMASK(23, 0)
+#define CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFF_SET(x)\
+	FIELD_PREP(CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFF, x)
+#define CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFF_GET(x)\
+	FIELD_GET(CHIP_TOP_CORE_PLL_FREQ_CFG_DIVFF, x)
+
 /* SPARX5 ONLY */
 /* CLKGEN:LCPLL1:LCPLL1_CORE_CLK_CFG */
 #define CLKGEN_LCPLL1_CORE_CLK_CFG                                             \

-- 
2.34.1

