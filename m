Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D243BB9E1
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138817; cv=none; b=CZvTkIeLOw7CznyFw220Bi7C1UzK0Er0LnTylHBZzBW31y6U83VukCPBw3fyLET3LG4ghGuybp/x3Y+8zZ/CDeKDu0Q2LUeaxRoK7BhpBneEVOQuRBkpYZicMWcTMicILZV2lz7teKdyVIuJcWZ1giRTd46K8AsZc+T4dQjSbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138817; c=relaxed/simple;
	bh=dHc6qETU8dJy4l4oVAiUuanu/oJ0tJBFINLaL+Gk8uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETojOrOGIW2t0e81G/sKWKUp+I6Y2m23n3rizWLCxrosHnFcfWu7jlYbkhfxgTERUwaFAbODTUu2qfQEBCa65EQ5faPXSALqajZC2MEiHMVsH0fAeLWgojToYv0b/TtrZ+W4KiQysF+ed75heqHCFmkIw2482IMM3XGi3z2DeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emdU0sro; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emdU0sro"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so347944966b.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785138813; x=1785743613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JxZwrjGZGGkFMdjSD6WIMUsIUvSrTncEVdfBpUkOPU=;
        b=emdU0sroRVIuTzzMFy35X08hyj7etNrMUPz+CioVPzWIdkfnK+0OuS5tfKLhucrbPH
         RI0BW7QB1pJ6vuNFOnL1M2VHPczoTp2rzvKwpIkf2/bdczd6o8FONUrQKF5uXj0ZNKJu
         ReP8V/nCoMpg5FWtg2ocCTO8i5N5xKf+1P0nWKUN7wO2iaexhWffB1LrwaJNOmCT2GZP
         H7XZwg3VhoHOtaVmmWn6tiLXd4cKkLhoOgv+UWeXqPSiGaWjG/1Gj+mJoMqEMJeBnEM0
         DBq0GsF5bt302ixJt0fZjIIRt227wIVQNuLPEqxs5VjWs0vaYgTfLW7KEhy9+LM359/o
         eS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138813; x=1785743613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JxZwrjGZGGkFMdjSD6WIMUsIUvSrTncEVdfBpUkOPU=;
        b=N140X46OyWdLuzDUzvAjlPQJ9thrkm1QFFo+gGE/XPnMpjsBaPFAVNb0sXZOFh1Qe3
         QcEvKf1Mt6/gwrxvFt8kzQ3vIs9lAvQWTBoWXANq7CNsIGwqHyUb9I3YQZQWHRE46qxD
         dW/yfMOpCuAmlTffMasquevxciW48u+7sgSkIaVoxzYGnN/qYXw81Utenj3SlGv506eA
         Tpy3lfeYOt85dA9bh9WlDRn4RktOdauMBTBLy0BOGIjBXjJUMagQMG7bjhC4BoXuf3Y9
         /BvgXzTiewGag6W4oXVfbfEOcyytMqUahV8+Sua88NO+NIiVyrZ5s7CjX+FCTmA8rnwt
         YxvQ==
X-Gm-Message-State: AOJu0YzwZ1tPKN9KzSAlBW4hTgKYfhJh7KtFTeQwBZW19CHSFZ9+7/BL
	1v6SF3OT4TqiqDT1Fu4Ow75GBhBomiXHxcIF9lwEZ9Lxxqhkz3s1Nigx3nzZKA==
X-Gm-Gg: AR+sD10BcDpaL/wlBSbbQzdPIQfKtL+OC0eoShrQwxaGWC1D44ZFLIE5fyH7vVjuJ08
	r7qPWu6V/bEtm2W409ho7zaki1u27jf1LfZnmmiw+bXeRvRQZmti0SrHkKH2OKiHeH7gef66ujM
	gKtRbnLAxXvdV48AyASwYwiWWu9OORusUlwAb+hsyytw2P1zyBp62Dp8yyfewhLJ6DywjtBxYb+
	5dEUwA+OdXsxONWNmHrmtc4ESPI674fVDWEQ7pn5rAraVeU4tdGZPUyyZOnxsmjghSaFDetwW8c
	fj156/6dGer/1zFqEg+rKMvfVHteCY8P7WTPd2/SVhEzzPUiGPNzSWUiH8tdtdgGEj3J6Fg3rwo
	/Cc+X8kyhYolHh3536TsdAajo3yl7f+QyI1pfEDyd16SxwcFEINdfPy16bJWi+uk4++5qYyCz9P
	pNstw=
X-Received: by 2002:a17:906:6315:b0:c15:d608:f112 with SMTP id a640c23a62f3a-c1f1f16ba60mr307425366b.58.1785138813058;
        Mon, 27 Jul 2026 00:53:33 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac0fa4sm596226866b.20.2026.07.27.00.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:53:32 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/2] net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Mon, 27 Jul 2026 10:53:24 +0300
Message-ID: <20260727075324.3555446-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727075324.3555446-1-a.shimko.dev@gmail.com>
References: <20260727075324.3555446-1-a.shimko.dev@gmail.com>
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
150 ps steps from 0 to 2250 ps.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/net/phy/Kconfig    |  10 ++
 drivers/net/phy/Makefile   |   1 +
 drivers/net/phy/dap8211r.c | 206 +++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
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
index 000000000000..65d6fef86f26
--- /dev/null
+++ b/drivers/net/phy/dap8211r.c
@@ -0,0 +1,206 @@
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
+#define DAP8211R_RGMII_TX_DEL_MASK	GENMASK(3, 0)
+#define DAP8211R_RGMII_RX_DEL_MASK	GENMASK(13, 10)
+
+#define DAP8211R_RGMII_CONFIG_MASK	(DAP8211R_RGMII_RX_DEL_MASK | DAP8211R_RGMII_TX_DEL_MASK)
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
+ * - RGMII delays based on interface mode
+ * - Software reset to apply settings (low active, self clear)
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_config_init(struct phy_device *phydev)
+{
+	u16 set = 0;
+	int ret, val;
+	s32 rx_internal_delay;
+	s32 tx_internal_delay;
+
+	if (!phy_interface_is_rgmii(phydev))
+		return 0;
+
+	rx_internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
+						   DAP8211R_DELAY_SIZE, true);
+	tx_internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
+						   DAP8211R_DELAY_SIZE, false);
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		if (rx_internal_delay < 0)
+			rx_internal_delay = 0;
+
+		if (tx_internal_delay < 0)
+			tx_internal_delay = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		if (rx_internal_delay < 0)
+			rx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+
+		tx_internal_delay = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		if (rx_internal_delay < 0)
+			rx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+		if (tx_internal_delay < 0)
+			tx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		if (tx_internal_delay < 0)
+			tx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+
+		rx_internal_delay = 0;
+		break;
+	default:
+		phydev_err(phydev, "Unsupported interface: %d\n",
+			   phydev->interface);
+		return -EINVAL;
+	}
+
+	set |= FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, rx_internal_delay);
+	set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK, tx_internal_delay);
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_PHY_CON, DAP8211R_PHY_SW_RST, 0);
+	if (ret)
+		return ret;
+
+	/* Wait for reset self-clear (from low active to high) */
+	ret = read_poll_timeout(dap8211r_read_ext, val,
+				(val & DAP8211R_PHY_SW_RST),
+				20, 200, false, phydev, DAP8211R_PHY_CON);
+	if (ret)
+		return ret;
+	if (val < 0)
+		return val;
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
+		.soft_reset	= genphy_soft_reset,
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

