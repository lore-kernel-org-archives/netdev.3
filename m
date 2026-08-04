Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F123CEBBB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839628; cv=none; b=J+A1j+X7pKa1S6T8bNhlDRedqWeANlBi1V8/42INFOXmJk5E4xbz9JFauaGBdzHZhNzFOjf6oncZv6Yzw4l/fk95fA9xo9tnlsiUS0cTFikHQNgjbYPX5E7GHI4j8BjfIMpewD8pfazTQ408xqx7cMzAhCz5PJY1hZMIKjoy+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839628; c=relaxed/simple;
	bh=guAKTInMrlwfOovBCJoOb0OREjwloaHW/6qgleMazX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MihnESbpl06CnKyfbh3anlKI3xPmr7cQJw8xpKjDAkJdLKEm0USh2Hfzk3zR84I9tJdP5WUoHOl2C7hoFqw8ySHbivLZmLkqrZfyAVgTrtZsx6vPGUl6UjiAmGCwH6ZstcU3KuZNCtxWV6WnpYVCc3vQpqxjmL+stNOlfMUSUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvL9DzNM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvL9DzNM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso10598355ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785839626; x=1786444426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTXDHsnwFlbf3g77LNyPYkdxcBB8Zd+YWsg2JPpDVpU=;
        b=cvL9DzNMPvE5ITphM9M9OP9cMFe9owZ668vIK38tnQIULW4QwwirLas+jNCRB00SsA
         t4RZJMVC4OSODNUFdTaiTau5vge/a89N1jpFC4qalxB1CR2Kwhnl8AeukufnOkospTIt
         3Q4jC6tgzPSMeMqQOBTZaUqoGHbIpkh4bMe5JaYji5Oeo6tWl5VhmOBBkNdq1Mum+M9A
         YQDkdU/B/01YGUJBZ7lo52fwj/ULGqXyXWiF326SH/kfz6M+uFmJUr/TkEo6NQMqtTHg
         CPUZk+QsQGtgRp5L4iWmSXpdyRCu6uQ/3pXNOwS/fJfrcQlaj4OwkyWxESrOW6XjuTCp
         OHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785839626; x=1786444426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTXDHsnwFlbf3g77LNyPYkdxcBB8Zd+YWsg2JPpDVpU=;
        b=YZfqzzWOGSUrUqsM3+K32a3PAlOrwdRSaHX69lRxgt2ONHhKcbYMXNbbJwGq3dglaN
         XoAt26x3gfR7uYKgx4CM1WhxxvcLUvrRaUzOGH60iZBHY4/qDykiEE38ax5s856nck0u
         PF09fByFIFEkChms+NwDH5yFWtaHFzPgFrUbIhxzuK1wPLVKknkdyUmYbwEH7zyLGJpL
         ZnX0kdp/rdn9ajQdy8rSB5OSOW5j1u/7J+9AEn5cjPK2N2ujaGnbvQfDHYs3uzd0zf05
         bGp868B4vnwXRL+/l0UYliBX5/ZCTzHtmbEPreLDJ2HiVbz5I4IvH7IIo8JCYEnZ5BSL
         BjXA==
X-Gm-Message-State: AOJu0YylO3v0BNyfVKQdl13G4kavpRPwirItF7Nw9J1+2JKpig3hsutr
	p1mYZqKaXaOXKTWkr1+FVvSGijGDP7C6HKlEQIxrXR+9WPz9k4BtB1PuigSj+Z4Q
X-Gm-Gg: AR+sD131H4wTWxY9lpXltG+Y5YxvtUt1szc8qIbbNpS1qRvkpyWywGyVVIoTgBXP/dL
	Xjt48xo06G2ERmZr8McPo7NMIaXCH5W50C8dmMEZBN9viInPgom699cEhElcl6BGqEYURhai5Sz
	N9TTuJATb8u1jekzJo1Kl2z6VEaVLGtC+ysy1uAowR2Ca/QCEkgTzpyVHaY0clKtv1Cz3qmyvgL
	t8z7hfkwbo2/omDeWfilzAxrj1sHKeES5MPy7592F7hGVapiuA4DrZqLfEA89gnxK0jSsZU1zbs
	CZkUtlMH0AkHk5wSQvo0gB32203Vz8QgfSggG5WOEZSEjMvgMjqcGGcXOK3thO7PHGn52vTgpYF
	m80gTm944Sbmeb4f8FzrH49IZAAopjo/yKTu+4fkQ90b/pGFprmJIhsh5eWSqD7/6MJOR7YKUN1
	9JW0lAOC2kLGXyW3KK+BFiZxhzJbiStR48QnK61i53bQDYMRpBDL/S2m4HaUrZQUiO/13/
X-Received: by 2002:a17:903:98f:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2d08ab8bec3mr29565945ad.22.1785839625772;
        Tue, 04 Aug 2026 03:33:45 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158676f579sm2955011eec.20.2026.08.04.03.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:33:45 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net-next] net: phy: mediatek: add EcoNet EN7528 PHY support
Date: Tue,  4 Aug 2026 14:33:21 +0400
Message-Id: <20260804103321.3331802-1-naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EcoNet EN7528 MIPS SoC embeds four Gigabit Ethernet PHYs (PHY ID
0x03a29491) behind its built-in MT7530 switch. They use the same LED
register layout as the other SoC PHYs handled by this driver, but their
LED controller powers up with its external control disabled, so the LED
pins stay dark regardless of what is programmed into the LED control
registers.

Add a phy_driver entry for it, modelled on the Airoha AN7583 one. Its
config_init callback enables the LED controller through the LED basic
control register, which this driver does not program for its other
PHYs, but which the air_en8811h driver already handles as
AIR_PHY_LED_BCR. LED behaviour is then controlled through the phylib
LED operations shared with the other PHYs of this driver.

The LED block is shared by the four PHYs of the EN7528: the LED
configuration programmed through any one of them applies to all four,
while each PHY still drives its own LED pin from its own link state.

The EN7528 PHYs need no efuse calibration data, so relax the
MEDIATEK_GE_SOC_PHY dependencies to allow building the driver on the
ECONET platform.

Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---
 drivers/net/phy/mediatek/Kconfig      |  8 ++++--
 drivers/net/phy/mediatek/mtk-ge-soc.c | 35 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index bb7dc876271e..b6d41bbbbc27 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -23,9 +23,9 @@ config MEDIATEK_GE_PHY
 
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARM64 || ECONET || COMPILE_TEST
 	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
-		   COMPILE_TEST
+		   ECONET || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	select PHY_PACKAGE
 	help
@@ -36,5 +36,9 @@ config MEDIATEK_GE_SOC_PHY
 	  present in the SoCs efuse and will dynamically calibrate VCM
 	  (common-mode voltage) during startup.
 
+	  Also include support for the built-in Gigabit Ethernet PHYs of
+	  the Airoha AN7581 and AN7583 SoCs and of the EcoNet EN7528 SoC,
+	  which need no efuse calibration data.
+
 config MTK_NET_PHYLIB
 	tristate
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 9a54949644d5..0041300d4f10 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -16,6 +16,7 @@
 
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
+#define MTK_GPHY_ID_EN7528			0x03a29491
 #define MTK_GPHY_ID_AN7581			0x03a294c1
 #define MTK_GPHY_ID_AN7583			0xc0ff0420
 
@@ -320,6 +321,14 @@
 /* Registers on MDIO_MMD_VEND2 */
 #define MTK_PHY_LED1_DEFAULT_POLARITIES		BIT(1)
 
+/* LED basic control register, part of the same LED block as the LED0/LED1
+ * control registers above. The air_en8811h driver describes the same
+ * register as AIR_PHY_LED_BCR.
+ */
+#define MTK_PHY_LED_BCR				0x21
+#define   MTK_PHY_LED_BCR_CLK_EN		BIT(3)
+#define   MTK_PHY_LED_BCR_EXT_CTRL		BIT(15)
+
 #define MTK_PHY_RG_BG_RASEL			0x115
 #define   MTK_PHY_RG_BG_RASEL_MASK		GENMASK(2, 0)
 
@@ -1470,6 +1479,19 @@ static int an7583_phy_config_init(struct phy_device *phydev)
 	return phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
 }
 
+static int en7528_phy_config_init(struct phy_device *phydev)
+{
+	/* The LED controller of the EN7528 powers up with its external
+	 * control disabled, leaving the LED pins dark regardless of what is
+	 * programmed into the LED control registers. Hand the pins over to
+	 * the LED control registers the same way the air_en8811h driver
+	 * does; the mode field of this register is already set out of reset.
+	 */
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED_BCR,
+				MTK_PHY_LED_BCR_CLK_EN |
+				MTK_PHY_LED_BCR_EXT_CTRL);
+}
+
 static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
@@ -1505,6 +1527,18 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
 	},
+	{
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_EN7528),
+		.name		= "EcoNet EN7528 PHY",
+		.config_init	= en7528_phy_config_init,
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+	},
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581),
 		.name		= "Airoha AN7581 PHY",
@@ -1537,6 +1571,7 @@ module_phy_driver(mtk_socphy_driver);
 static const struct mdio_device_id __maybe_unused mtk_socphy_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_EN7528) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7583) },
 	{ }

base-commit: 5b4f243f78a533abf414bfd96325aa2c96e711a3
-- 
2.34.1

