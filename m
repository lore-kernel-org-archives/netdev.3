Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE548C8C7
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962597; cv=none; b=GjWzRTgPtEuBTNNBoHTclnvZqD41k2CFJhYZ6x36VaEbmENeEYqXCUIOsWrPO0ewfc0ngzl998ySjvgA0R2qAARjmENk6H5ebvs1m/OblKFUvyA+F7gRpF8ASTXRFRZXPEWVKtY+m5dGleI4h7TeqtH+qj11zUSMSromgj1zI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962597; c=relaxed/simple;
	bh=uFWTB4N8CbYOS+yEDEEIFvr4BTuj9KYHVHbnWOTLbXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXmboTVLWDqPXe0d2Gt4RI4boylBM9sB8jIUf8bPqoS3NwdueFCWCb+XgJutRfRI1aVBXx/WVo97XZgmf7dwfZj42zHfWVeAKkFt1bLpY76yXS1Quy2rOzcsKk8eiMJ8rgZkdgK/il7l/xcLLZ0qIYSP5zI9bxtK9QJYeZ51J2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2VfulsI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2VfulsI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a17baef589so5299885e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962590; x=1792567390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aRgEdiuLM67e5NxG8ScP4ZjaeN0AlrFtrVyhfl7tkQ=;
        b=R2VfulsI9Rc6xD7trqKjZ+YPbLXoMi1c5s4re5rpHgnPTigl4VIYNCoe9PflYKEvTX
         adtnVxwrF3P/0coOfTmifCIyNWMQCBx6HSJUjJsXa9avW6wlxtYVsc5ccBmH2TWgmpx+
         VoOu99Oi24axkxdBM8yxgTTFhfRho+F7c5yKz5OoArhlszQ9dZegSumw6YV0UO4RJgwp
         ILhOdhrsmU1NLz2fWZyHB4S8tcJTljOhTJdAul+Lbgkcs600UdHqsRoeKbK1bY9qxFjX
         dKqBKduOiPXCMzhFBIorrNkxTbuwpdVmWRqvsgeNru4ODqzYL3CfqP5YivWq6YBZUBLc
         qcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962590; x=1792567390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6aRgEdiuLM67e5NxG8ScP4ZjaeN0AlrFtrVyhfl7tkQ=;
        b=wDHONnWCNGQn36jTpfJaXmjhiNYyDbCSmNbxJGnFqqq6mXTgn2OuGRuKrplogTVwoU
         CNf2vo20bSdDfE6cT6gYuvy25MA11T76mvhhgOaBWPw0xvbTrEpiKnaqG4qLCyDBo8Jp
         2zXqNUdWLRsUSehw3PtOsAT1mWNhzYcqmPucLbyER6ANlVt27IrIXjcNapbd2Ap43s1c
         gMCFloYaah/urL++E+gcAVhAnCpLAsxbN1WpMgYgRqAn1Ps5gWtrUZhid/J8t7YSNXDu
         I2ecCVtA9ctmKW7/27xxi3qMME7h+K9cjbeCaf01BOkk5Hqk1ZB+O1QnxWk1liJRWi+7
         u2Vg==
X-Forwarded-Encrypted: i=1; AKwUvBwEJquJ+uRnVvaTAAN3arUmp2p1nlFHf67mNrOQfeyyx9cJ/HZh90ilEN1yJCmVq7Kz+Ng8DnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmft1HRPFquw1Ir4r1XdjFWLjwiiOn5qFVN+5JRKCLoeAUGk+b
	GnXmdvPD0+pYDfO9zwNEQW0yq6E/8OVkkHSUtoPdiFlRzHwnJkoIgizX
X-Gm-Gg: AYBFou2D/SVjB/FPcUwMDyTSYTMLX/02Umyk546NP/Ttz/A7j8Ekxze9NdQr+kOe27v
	WdBYRUZnQocAwNwZCb54egPGEsUYhUzlLXIFZj2KzcV+ypDlP8SFqLNKsQ5pGCUnThiKC7DDvOj
	XXHn1Kmvv0E4sTKCz0lZNLk6BGdGAB2uZnzgvojqKNcFnv5Es1sqfanjWUJJFG4aIBJcNaHc77f
	3f/KOQJ119rNbd5mhOTPdmtPHTvtrdNjJH2AUqUtlEd2bRqQr9GruyqxQ0WsZ0rSmfk7wdUlhlj
	wTfgadoGjdFm2StFQfCRs9HwS4AU9IuAKMS5nV1CdBoywi7ONqqQkb5+vggOAhhIIfSkOmIUkIY
	dWCv/g/yZBVuLWPHKqQE3JBHwb/b3VbAqhpAO9nEEFxqozEXeXUh/iWvVqpPbzJGjscz4EaVp9Z
	1vqsIpHL0Y93BpuVX6sDIIJ2NT7t2hygO5wi1gR5W7RCd7O9MzGzcSlF2CFQrtkjxP1RoQas6ce
	TdKdeOfw2q3dQqi5JpX4hfgTyDV/xMSBfgz0yognxF+0+HDy1lHq8TJifjBOdY/XVY7z3wjpIQm
	0KJANmHXUE59avL0BgrNtow8WdJD+nmMhxBP77z6sECw+LcgeKNzlP6UuQllmA==
X-Received: by 2002:a05:600c:609a:b0:4a1:717b:7976 with SMTP id 5b1f17b1804b1-4a18e4b15e5mr292084425e9.35.1791962590141;
        Wed, 14 Oct 2026 00:23:10 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:09 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 16/24] net: phy: Add Sanechips ZX5201 PHY support
Date: Wed, 14 Oct 2026 08:20:56 +0100
Message-ID: <20261014072109.1759502-17-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize the external WAN PHY and its SerDes path; generic PHY support
handles negotiation.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 drivers/net/phy/Kconfig     |   8 ++
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/sanechips.c | 152 ++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/net/phy/sanechips.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b4ef927fd4..63620fdfc4 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -416,6 +416,14 @@ config ROCKCHIP_PHY
 	help
 	  Currently supports the integrated Ethernet PHY.
 
+config SANECHIPS_PHY
+	tristate "Sanechips Ethernet PHYs"
+	help
+	  Currently supports the Sanechips ZX5201 PHY, which the ZTE ZXHN
+	  H3600 uses for its WAN port. The driver sets the PHY up so that
+	  its SerDes interface passes traffic; everything else is handled
+	  by the generic PHY code.
+
 config SMSC_PHY
 	tristate "SMSC PHYs"
 	select CRC16
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 25c4a3c242..666309f7d0 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek/
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
 obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip.o
+obj-$(CONFIG_SANECHIPS_PHY)	+= sanechips.o
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
diff --git a/drivers/net/phy/sanechips.c b/drivers/net/phy/sanechips.c
new file mode 100644
index 0000000000..92d6388f7d
--- /dev/null
+++ b/drivers/net/phy/sanechips.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sanechips ZX5201 Ethernet PHY
+ *
+ * The ZX5201 answers on two MDIO addresses: the copper PHY on its own
+ * address and its MAC-side SerDes interface on the next one. The copper PHY
+ * uses the standard registers and the generic PHY code; this driver only adds
+ * the setup that the PHY needs before it passes traffic. The values come from
+ * the vendor firmware of the ZTE ZXHN H3600, and most of them are not
+ * documented.
+ *
+ * Copyright (C) 2026 Navid Ghahremani <ghahramani.navid@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define PHY_ID_ZX5201		0x84b95011
+
+/* Copper PHY vendor registers */
+#define ZX5201_REG18		18
+#define ZX5201_EXT_ADDR		16	/* extended register access: address */
+#define ZX5201_EXT_DATA		17	/* extended register access: data */
+#define ZX5201_REG29		29
+
+/*
+ * SerDes interface registers, at the PHY's MDIO address + 1. The names are
+ * a best guess from the way the vendor firmware uses them.
+ */
+#define ZX5201_SDS_WDATA_LO	16
+#define ZX5201_SDS_WDATA_HI	17
+#define ZX5201_SDS_CMD		18
+#define ZX5201_SDS_RDATA_LO	20
+#define ZX5201_SDS_RDATA_HI	21
+#define ZX5201_SDS_REG22	22
+#define ZX5201_SDS_REG27	27
+
+static int zx5201_sds_read(struct phy_device *phydev, u32 regnum)
+{
+	return mdiobus_read(phydev->mdio.bus, phydev->mdio.addr + 1, regnum);
+}
+
+static int zx5201_sds_write(struct phy_device *phydev, u32 regnum, u16 val)
+{
+	return mdiobus_write(phydev->mdio.bus, phydev->mdio.addr + 1, regnum,
+			     val);
+}
+
+static int zx5201_ext_write(struct phy_device *phydev, u16 reg, u16 val)
+{
+	int ret;
+
+	ret = phy_write(phydev, ZX5201_EXT_ADDR, reg);
+	if (ret)
+		return ret;
+
+	return phy_write(phydev, ZX5201_EXT_DATA, val);
+}
+
+static int zx5201_config_init(struct phy_device *phydev)
+{
+	static const u16 led_regs[] = { 0xb409, 0xb407, 0xb406, 0xb408 };
+	int ret, lo, hi, i;
+
+	ret = phy_write(phydev, ZX5201_REG18, 0x8402);
+	if (ret)
+		return ret;
+
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_REG22, 0x0a0f);
+	if (ret)
+		return ret;
+
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_REG27, 0x0800);
+	if (ret)
+		return ret;
+
+	ret = phy_write(phydev, ZX5201_REG29, 0x0355);
+	if (ret)
+		return ret;
+
+	ret = zx5201_ext_write(phydev, 0xb62d, 0x0006);
+	if (ret)
+		return ret;
+
+	/*
+	 * This looks like an indirect read-modify-write of SerDes register 4:
+	 * read it, set bits 9-13 of its high half (bits 25-29 of the register)
+	 * to 0b10100, and write it back.
+	 */
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_CMD, 0x0004);
+	if (ret)
+		return ret;
+
+	hi = zx5201_sds_read(phydev, ZX5201_SDS_RDATA_HI);
+	if (hi < 0)
+		return hi;
+
+	lo = zx5201_sds_read(phydev, ZX5201_SDS_RDATA_LO);
+	if (lo < 0)
+		return lo;
+
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_WDATA_HI,
+			       (hi & 0xc1ff) | 0x2800);
+	if (ret)
+		return ret;
+
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_WDATA_LO, lo);
+	if (ret)
+		return ret;
+
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_CMD, 0x0204);
+	if (ret)
+		return ret;
+
+	ret = zx5201_sds_read(phydev, ZX5201_SDS_REG22);
+	if (ret < 0)
+		return ret;
+
+	ret = zx5201_sds_write(phydev, ZX5201_SDS_REG22, (ret & 0xfff3) | 0x0004);
+	if (ret)
+		return ret;
+
+	/* LED control registers, all cleared as the vendor firmware does */
+	for (i = 0; i < ARRAY_SIZE(led_regs); i++) {
+		ret = zx5201_ext_write(phydev, led_regs[i], 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct phy_driver sanechips_phy_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_ZX5201),
+		.name		= "Sanechips ZX5201",
+		.config_init	= zx5201_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
+};
+module_phy_driver(sanechips_phy_driver);
+
+static const struct mdio_device_id __maybe_unused sanechips_phy_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(PHY_ID_ZX5201) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, sanechips_phy_tbl);
+
+MODULE_AUTHOR("Navid Ghahremani <ghahramani.navid@gmail.com>");
+MODULE_DESCRIPTION("Sanechips Ethernet PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

