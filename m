Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14623EFFD7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920153; cv=none; b=R5KVgHJcbeobnp5+PVTZv0oNV3ocBrQK6rAt2DUuPrMLXSYohJWhNOVgrNcmYaGTJqrYaDrXYLOn/vMG7YzeDuJE3tpQPcGirWf4kYL4HZlnwXjaY1lS1KlZW8PoIUDF1gmDiAw4hPjGnv7CERjwnYKul9cttohzrAR67KqYhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920153; c=relaxed/simple;
	bh=tW0EEJSP2N/OF34pPwZQzNlQQa+xvGi3pOcQDAS153k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNXnZPjiJCn/exObxDya+Umybaf7XS6FHKPmkBSUp+VPzCNKT8t34nsRnhgA7jzgMoziMNMhDDGOIjrk29s1xU3I5bLn06wg3zPpYNph+mHPfN6vqIw5Reaf5tJdWDkNT/TdEPv779fUgbFhaVNufY7ILLSBbrruxajtDEsIf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN/TvN+N; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN/TvN+N"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39faa67fab8so5480721fa.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785920148; x=1786524948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cns2KhFhDqqBRLDrpH3IaGsRhRYYC7RxIFB7fl+1dVA=;
        b=IN/TvN+NXiXQzjsqsDjMhAmh7uG+RdKsxGB6JhWkYzuwvlIeZHTsM05K1X/RDNQe1T
         7gOrYyIdVRvxRoaqaQLrvBrA/AXyfXjH/Az9UmpO/7lYMdQKUIxhUH46X/0BcZxd1XNy
         ypTtVjRSP28UDgNA/ySuEaBIcy0ooEGMJ+gIPsIGWxUlXjnCXRZRUB8xZ0HaOCXidunw
         b9BzDmlALjZVV6EV47oWRLWpZS16ZrMOQRUuusLAwZZRSTmAOdk7FBV1xJKQW/JcXRN5
         XPdYsDx//cFYWVRjTXUUdWPiRo+P0XvQhNj4IFP7sqBSwzVS8jhnhMf4Qb+RrgGqiqKT
         W89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920148; x=1786524948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cns2KhFhDqqBRLDrpH3IaGsRhRYYC7RxIFB7fl+1dVA=;
        b=miQelxeIoXglYOctml7t3J9gzUIg1cPoVp4uT3TMgoYkk13JVZo2N6B03QW7WY+SCI
         ooR78Bv+cFWaT01J6vT0WNchEWmCz74uFih2Q/TnvOMPKr4sjKUCdor+5QzaTmu9EVYL
         vX3SpSNniFD+OJ455vdMfPMX/Zz2lamRglgcqMZw8takHZTE/npQy98IJg0VGX46ls3Y
         r0owB9phkNnO6NprE7bD6S9hcE0P7xnhKod44xZ2v94Y/Aue545L9LHxN22UMYaIb/PC
         G6dGg5Ulb8/Vtf+61/nbeHEBZ4H9gN1kbtNRKXnG+hY9oHjNIuxQoEdmJc9dp9Ljvtnq
         BO7w==
X-Gm-Message-State: AOJu0YxJ5bxB0mzbHDmWjydGMnqJ08NOAdqRzkiKoiB4uZ9ZkiomL2aT
	rWcz05eWm/LS5/HSy50bsg5opC/U9PkX9iw4A5YbHTUTPANuyx22n2pz5dGgiQ==
X-Gm-Gg: AR+sD10hUxNCP+IQEkGUp45rQC29bzFkSbPfjfNBnCZjXqYOldnrxhzAUJl+YWaD1C7
	mza5KZ9ca7z6yiDOg3J5Bx3TEGkN74Flc2EqtNrF4OqsGpmUqE0uljPHpjov4BZLbdKTWBKFJsO
	IIL1gKYFWXHUCpMIQDTGsaJHBdlQjDRP2uNZOXdcFGmx7DOsz6DiuwfuaIUqOyxYJ+gEy5422qQ
	AgWLmlMowqccrnJh/8FnUaCnCmy2kcGFPszU38wGipnHcLft/VHNPUcmHxOEfzLiD5T8X0TVKZQ
	s9+VlximDEP4NUA4pre/0yGszTrgJquueF4Wlm8ozSEoIC7/s3OO1uXzKWSFbViPEHC6mIIePos
	LP6rKRTr+9wbUyXGGqrHoplkTRWpV99BoXFnO6w7iMbMMWbztGYxByQTDXef9GGArMtDGPu8uPy
	+yEFZA9FVXlhbfMYHfw4A3pJKtDKYA8hYiz33LSAa2khVaPKzzLNT8hA6N35s1uQ==
X-Received: by 2002:a2e:bc07:0:b0:39f:b9d8:b502 with SMTP id 38308e7fff4ca-39fbae27ef5mr6015241fa.7.1785920147852;
        Wed, 05 Aug 2026 01:55:47 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fb9a152aasm7470471fa.21.2026.08.05.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:55:47 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/3] net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Wed,  5 Aug 2026 11:55:40 +0300
Message-ID: <20260805085540.452260-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805085540.452260-1-a.shimko.dev@gmail.com>
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
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
 drivers/net/phy/Kconfig    |   9 ++
 drivers/net/phy/Makefile   |   1 +
 drivers/net/phy/dap8211r.c | 220 +++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/net/phy/dap8211r.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..395bcd35bffa 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -232,6 +232,15 @@ config CORTINA_PHY
 	help
 	  Currently supports the CS4340 phy.
 
+config DAP8211R_PHY
+	tristate "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY"
+	depends on OF
+	help
+	  Support for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+	  This PHY is designed for enterprise and industrial networking
+	  applications, supporting 10/100/1000 Mbps operation. Supports
+	  RGMII interface with configurable TX/RX clock delays.
+
 config DAVICOM_PHY
 	tristate "Davicom PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..c72f7730e25d 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_BCM_NET_PHYPTP)	+= bcm-phy-ptp.o
 obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
 obj-$(CONFIG_CICADA_PHY)	+= cicada.o
 obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
+obj-$(CONFIG_DAP8211R_PHY)	+= dap8211r.o
 obj-$(CONFIG_DAVICOM_PHY)	+= davicom.o
 obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_DP83822_PHY)	+= dp83822.o
diff --git a/drivers/net/phy/dap8211r.c b/drivers/net/phy/dap8211r.c
new file mode 100644
index 000000000000..0bf770f8ebbb
--- /dev/null
+++ b/drivers/net/phy/dap8211r.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
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
+/*
+ * Hardware reset RX RGMII default delay from the datasheet: 0 * 150ps == 0.00ns
+ * Used when rx-internal-delay-ps is not specified in DT for RGMII mode and
+ * in RGMII_TXID to set rx delay.
+ */
+#define DAP8211R_INITIAL_RX_DEL_VAL	0
+
+/*
+ * Hardware reset TX RGMII default delay from the datasheet: 1 * 150ps == 0.15ns
+ * Used when tx-internal-delay-ps is not specified in DT for RGMII mode and
+ * in RGMII_RXID to set tx delay.
+ */
+#define DAP8211R_INITIAL_TX_DEL_VAL	1
+
+/*
+ * Default RGMII delay: 13 * 150 == 1.95ns
+ * Used when rx-internal-delay-ps or tx-internal-delay-ps are not specified in DT
+ * for RGMII ID modes to set tx or rx delay.
+ */
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
+	s32 rx_internal_delay = DAP8211R_INITIAL_RX_DEL_VAL;
+	s32 tx_internal_delay = DAP8211R_INITIAL_TX_DEL_VAL;
+
+	if (!phy_interface_is_rgmii(phydev))
+		return 0;
+
+	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_TXID)
+		rx_internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
+							   DAP8211R_DELAY_SIZE, true);
+
+	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_RXID)
+		tx_internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
+							   DAP8211R_DELAY_SIZE, false);
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		if (rx_internal_delay < 0)
+			rx_internal_delay = DAP8211R_INITIAL_RX_DEL_VAL;
+
+		if (tx_internal_delay < 0)
+			tx_internal_delay = DAP8211R_INITIAL_TX_DEL_VAL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		if (rx_internal_delay < 0)
+			rx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		if (rx_internal_delay < 0)
+			rx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
+		fallthrough;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		if (tx_internal_delay < 0)
+			tx_internal_delay = DAP8211R_DEFAULT_DEL_SEL;
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

