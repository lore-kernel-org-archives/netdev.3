Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9A442FC5
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223223; cv=none; b=TllsNPlw+vWka8P7Wl3sYrzzs/goWyOowCXNCSTaGtmo3YkMoR6nSes9w10WoEiQrt2LmhsD9EAlozik4JaUEZ8AFknv3bQTBzlgHNUUhtieASvXW6MifHAtI37yGuiSJOh32MtRk59ZeFxUox8bkUZOWWVnlA6fg/nTkMbnw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223223; c=relaxed/simple;
	bh=bk7IxppO8qZzo/KBr3Cy2z/alzXyT221tP4dcmSGJFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2WWtXA9S/QXf85m1tkzGaiwAQ+2EORp47K/9+zZalRmK5GLfAZcdQcKtJOcDAw/NvIjR9E/Dfn/k50NPdtwYRFXdSqL2/p9+pTT9Zh4BnxO6RXpcj7aloP1ZfF9u7hba9713h/BR0JHyZkeP8d51UE5OfxCTGFIN8B2sYKDIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq0LZnXw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq0LZnXw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so56072065e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223220; x=1784828020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eijm7tyBZ3BKS4iJSXO2RvOOnDCiiSEAdOSp7UtW6t4=;
        b=Qq0LZnXwYX6+ztlgh0THPgpzKK7RmcOklNh2dQfiEU8vptg4KYecaUexDLxu7KxuKx
         RA8axePEepGJWTuA4NjZ0Stbk+by5Ls2gWnGc6YUUNmjgucpMtBIJ9roiSYsXXPyY0Px
         8mjyAnXRzT+qkoX8YzHy4PEQEPiXT+ylTBC1VuhbbgjSLERUvkmX+bwAxBfVsi5JcUWc
         eiZYHAyLoZ7P77tfqFY7K3KsCjq1tZNvbfvBtLdK9NjKCrNRMc7HiNyCOTeERN6ZFPKM
         IwG1vl1qjxciEPPJaZD1XH4IRZupQ4FGMyROq1dhxUtHDwb9bN3OpxNG6BcOzNTp4rkX
         h4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223220; x=1784828020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eijm7tyBZ3BKS4iJSXO2RvOOnDCiiSEAdOSp7UtW6t4=;
        b=S9z3G//1wDU05d1azy1CD1tRL9l9gzroJxorDXCBRzF3oI3UhwmGS1CaPcC8jhGs7d
         JHpLNOD1uMhZ6tic/qr20ixpRIZTYLNQriRbPI+Id9RwSJ0Nit1xDGBfLMbZOqDVDuXp
         i6geql75YeHpiNTvt25RtS9xpJOV6vGkC3ggyuS6ZY/q6X8AYz10j2RrDGfmM7qdlrja
         m/1lUsjUMUSJI1CFuxvCmckeMHErzd2580mRHsQg2rjtQOfAGpNEEHHFmFRpZr0YYiYs
         dq5YL+rinDIKib/wfti5CZBpHe1JL60DAMzq6wguiSQQ8wjlrb1ApC2dQzLuPsR/a4Hu
         maKQ==
X-Gm-Message-State: AOJu0Yza4dXjEId4sTWoSuMAzZNWpsqoanmT6+YPw7pIaiPxtyCE7C0F
	VwnGt40Nnj1VmZrlKJfeSNICSxVs62TBJfyMp7Ue16+WrLgOWBBU7bREDC1ECA==
X-Gm-Gg: AfdE7cl7Hrpx2eeyByKN2VyNHmuYoywMZxEg7izFgaVlnEEHAPRbeLWMATq7bZLdJ7W
	UrTnAsseInTTH7zdrhr2n+yYpzfpygQ0r+H8nFxHH9Ad6w4OhwP+syhH8AST1ML9yrF0jiw2Hju
	yspbVhTXB/+SRhWVHb4rEv7pYHtrvKb5Jjybg3IrXejIbUL6WPTivpBmyztUh1GA/qVXDfMZnI5
	jceDaS+WEJOjnvC0LXNCGQ+tFRLGDFjoK9t9UWVE0bA9/xcChjqrYWBLVoXhmrBi5B2dWUWAXUW
	zXg8lrOHeGcOxcw1PQW0Iuvx/w/sAJfHDYhLtxLplL+dPSz6HCNqggRQEyW+4BD6TWej/ZyJ11x
	wEQomUynJ29wUwEgiS6l7UUI30h/DV1sFlBWitluLTS947YM1+BSlkRewxkZO91HP4dfSML1R69
	xWswBu9viTE7x/f7+TV+g=
X-Received: by 2002:a05:600c:8011:b0:495:4072:4194 with SMTP id 5b1f17b1804b1-495407245a5mr62715395e9.28.1784223219913;
        Thu, 16 Jul 2026 10:33:39 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb0343sm71768905e9.10.2026.07.16.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:33:39 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Thu, 16 Jul 2026 20:33:25 +0300
Message-ID: <20260716173325.653164-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716173325.653164-1-a.shimko.dev@gmail.com>
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new PHY driver for the DAPU Telecom DAP8211R(I) Gigabit
Ethernet PHY, which is commonly used in enterprise and industrial
networking applications.

The driver implements extended register access via indirect addressing
through corresponding registers, and provides comprehensive device tree
support for RGMII delay configuration. The rx-internal-delay-ps and
tx-internal-delay-ps properties allow precise tuning of clock delays in
150 ps steps from 0 to 2250 ps. Additionally, the optional
dapu,tx-inverted-clk flag enables 180-degree TX clock phase shift for
boards where signal integrity or MAC requirements necessitate clock
inversion.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/net/phy/Kconfig    |  10 ++
 drivers/net/phy/Makefile   |   1 +
 drivers/net/phy/dap8211r.c | 191 +++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/net/phy/dap8211r.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..4576f707ac94 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -237,6 +237,16 @@ config DAVICOM_PHY
 	help
 	  Currently supports dm9161e and dm9131
 
+config DAP8211R_PHY
+	tristate "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY"
+	depends on OF
+	help
+	  Support for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+	  This PHY is designed for enterprise and industrial networking
+	  applications, supporting 10/100/1000 Mbps operation.
+	  RGMII with: configurable TX/RX clock delays, optional flag to enable
+	  180-degree TX clock phase shift and internal packet generator.
+
 config ICPLUS_PHY
 	tristate "ICPlus PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..ad35733eb4bb 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
 obj-$(CONFIG_CICADA_PHY)	+= cicada.o
 obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
 obj-$(CONFIG_DAVICOM_PHY)	+= davicom.o
+obj-$(CONFIG_DAP8211R_PHY)	+= dap8211r.o
 obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_DP83822_PHY)	+= dp83822.o
 obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
diff --git a/drivers/net/phy/dap8211r.c b/drivers/net/phy/dap8211r.c
new file mode 100644
index 000000000000..e6381fd8c98c
--- /dev/null
+++ b/drivers/net/phy/dap8211r.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL
+/*
+ * Driver for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+ *
+ * Specifications:
+ *   - IEEE 802.3 10BASE-Te, 100BASE-TX, 1000BASE-T
+ *   - IEEE 802.3az-2010 Energy Efficient Ethernet
+ *   - IEEE 1588 SyncE support
+ *   - RGMII
+ *
+ * Author: Artem Shimko <a.shimko.dev@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define DAP8211R_PHY_ID			0x0008011B
+#define DAP8211R_PHY_ID_MASK		0xFFFFFFFF
+
+#define DAP8211R_EXT_ADD		0x1E
+#define DAP8211R_EXT_DATA		0x1F
+
+#define DAP8211R_PHY_CON		0xA001
+#define DAP8211R_PHY_SW_RST		BIT(15)
+
+#define DAP8211R_RGMII_CON		0xA003
+/* Default initial TX delay value by datasheet. */
+#define DAP8211R_INIT_TX_DEL_VAL	1
+#define DAP8211R_RGMII_TX_DEL_MASK	GENMASK(3, 0)
+#define DAP8211R_RGMII_RX_DEL_MASK	GENMASK(13, 10)
+#define DAP8211R_RGMII_CLK_INVERT	BIT(14)
+
+#define DAP8211R_RGMII_CONFIG_MASK	(DAP8211R_RGMII_CLK_INVERT | \
+					DAP8211R_RGMII_RX_DEL_MASK | \
+					DAP8211R_RGMII_TX_DEL_MASK)
+
+/* Default RGMII delay: 13 * 150 == 1.95ns */
+#define DAP8211R_DEFAULT_DEL_SEL	0xD
+
+static const int dap8211r_internal_delay[] = {0, 150, 300, 450, 600, 750, 900,
+					      1050, 1200, 1350, 1500, 1650, 1800,
+					      1950, 2100, 2250};
+
+#define DAP8211R_DELAY_SIZE	ARRAY_SIZE(dap8211r_internal_delay)
+
+/**
+ * dap8211r_read_ext() - Read extended register
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ *
+ * Reads a PHY extended register using the indirect access method.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: Register value on success, or negative error code
+ */
+static int dap8211r_read_ext(struct phy_device *phydev, u16 reg)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_read(phydev, DAP8211R_EXT_DATA);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+/**
+ * dap8211r_modify_ext() - Modify extended register bits
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ * @mask: Bit mask of bits to clear
+ * @set: Bit mask of bits to set
+ *
+ * Modifies a PHY extended register using the indirect access method.
+ * New value = (old value & ~mask) | set.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_modify_ext(struct phy_device *phydev, u16 reg, u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_modify(phydev, DAP8211R_EXT_DATA, mask, set);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+/**
+ * dap8211r_config_init() - Initialize PHY
+ * @phydev: PHY device structure
+ *
+ * Configures the PHY during initialization:
+ * - TX clock invertion
+ * - RGMII delays based on interface mode
+ * - Software reset to apply settings (low active, self clear)
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_config_init(struct phy_device *phydev)
+{
+	struct device_node *phydev_node = phydev->mdio.dev.of_node;
+	u16 set = 0, val = 0;
+	int ret;
+	s32 internal_delay;
+
+	if (of_property_read_bool(phydev_node, "dapu,tx-inverted-clk"))
+		set |= DAP8211R_RGMII_CLK_INVERT;
+
+	internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
+						DAP8211R_DELAY_SIZE, true);
+	if (internal_delay < 0) {
+		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
+			internal_delay = 0;
+		else
+			internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+	}
+
+	set |= FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, internal_delay);
+
+	internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
+						DAP8211R_DELAY_SIZE, false);
+	if (internal_delay < 0) {
+		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
+			internal_delay = DAP8211R_INIT_TX_DEL_VAL;
+		else
+			internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+	}
+
+	set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK, internal_delay);
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_PHY_CON, DAP8211R_PHY_SW_RST, 0);
+	if (ret)
+		return ret;
+
+	/* Wait for reset self-clear (max 200 us) */
+	ret = read_poll_timeout(dap8211r_read_ext, val,
+				(val & DAP8211R_PHY_SW_RST),
+				20, 200, false, phydev, DAP8211R_PHY_CON);
+	if (ret)
+		return ret;
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_RGMII_CON, DAP8211R_RGMII_CONFIG_MASK, set);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct phy_driver dap8211r_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(DAP8211R_PHY_ID),
+		.name		= "DAP8211R Gigabit Ethernet",
+		.config_init	= dap8211r_config_init,
+		.read_status	= genphy_read_status,
+		.set_loopback	= genphy_loopback,
+		.config_aneg	= genphy_config_aneg,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
+};
+module_phy_driver(dap8211r_driver);
+
+MODULE_DESCRIPTION("DAP8211R Gigabit Ethernet PHY driver");
+MODULE_AUTHOR("Artem Shimko <a.shimko.dev@gmail.com>");
+MODULE_LICENSE("GPL");
+
+static const struct mdio_device_id __maybe_unused dap8211r_tb[] = {
+	{ DAP8211R_PHY_ID, DAP8211R_PHY_ID_MASK },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(mdio, dap8211r_tb);
+
-- 
2.43.0

