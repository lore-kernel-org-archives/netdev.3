Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460C386559
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752269; cv=none; b=dL6G/EI1mzqR5c3wH2kQarfw/qIGgiUxhtzL74W5Swy8UW5JJ5+QOKelBEbS2EhVXfGYVnK5tir+BZ+2idB0ptiDY8kptlRSMl8C2fDNb2Jy0vVVRv5lMZ5qm9MlhQkegN/6iYBU7m8kGffTcABACG+PTUJ/nkJYJLvIVdyWZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752269; c=relaxed/simple;
	bh=PT7My96EEa1lNH5x10waWLcPYjUn6A/zF3CDbbVcIKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyxv4AlUWsTeuAXD7hgC8qQik8Z6AJv8fs5GD4f/WFmPnKjZTR9wbeTFxz/iI2plMfqdkknY2OcidUJXRlPDZggI2Z8VslXtpXg3kUkNFspOXUqL6uFocIXahQUvvX82PNx4p3PbeH5gHOQ1E8oJtFSbU4QJ9mcVOFMQeyobytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVhOQ0qu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVhOQ0qu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso5230553a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752265; x=1786357065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPumfBe/66i3X626SZOp7NjOJzxWzmdqzUlDSo+SAR0=;
        b=oVhOQ0quFh2XT48Ho2Tb2MIPmM1slGlkRsHBpcwopFiOwOsMPoMJHIWzd6kAuAAUrb
         kmFdMvJEWFyU/Pvt5QbP5KndUpsyA8vQB05Mk8fRmIENEKC+LiCqBLl7vzNWddgpvXmD
         XlFNtgR70RnpLhUthKwWakcUiV5vQVMbHZXm+S2K0OeTLJVyPEPO1AH6diSZ1bv+9q9c
         q50JUI0/I5sqv+0XL05gX49x3/5dRRm6NYdKvBxxL2sxx/jebAhfEddFThJMUviCyqS6
         O1/qjKm/UuxsA1NHa1vTJg/sHry7xkvFsZ+t29ndNXLMGioF/Nusf9iKso3WCIKCxhWv
         Ssqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752265; x=1786357065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPumfBe/66i3X626SZOp7NjOJzxWzmdqzUlDSo+SAR0=;
        b=oMKs9iMJEMKy2BO780jDTajkOTzaobpEGLWFPbNJ7fAjIqCpX/jqUTiPY+dEizkKpy
         q/lPyH8oNhxIstRh+WH/dVpKj9OlJndn4vH8Te6F+5e/YqJE1NI5xzORUiF1zk3ZJLbQ
         YQjVgJ3Wh56/hQn53uYumEokcK8sz9rrENwfHEP7BqB5VnlLV78uIqc/EqflgDLT/C3X
         eJKGmSQfTRK0n5rH6dei/WBfnoRcVmOWX9xDDpeYMxjLy8A2rcA4iB9qLyfMjw+CJsor
         nGYX4K/W95gMcYVoo9lN0gvTqQk7xkhUau8EoAA+v6tKfWzhE+TZ1+T/KUuJaafjIW+H
         5HqA==
X-Gm-Message-State: AOJu0Yx0yieHAN1QlGKXKdWSPMjWu5m4RikVQ00hL4y1f3W2Xg70Pn+k
	UTYkSGunfj933J/7R4654nBN12CugTvYOoWzQmCpStRkBcI1WdWRfirKlL9fkA==
X-Gm-Gg: AR+sD10xDxkZpQcmdSfV6xWZVExOLtVx27biq9fZY9X+TpwS7Hm55CTFvKdpwZp825f
	QBcMpG9dr39rrZegdz+sjFZIcwUHffcQpXXOgn/CiFu13HkpkQl6hWkyLCP+7cYyM+33/WUkaL2
	3xDjxv5zHGnGnR6CFGs4SKzCybN3J/KxvwNsOU8JPnG+HJYHaXoerAlSix+dBD6nvFj8NGdxtj/
	QD9ht0N0Qt0SPMaRMuaHrLUM4YigMVWszZJjqv2l08yUMml9N/dSt/Ve853jAD7SrR4SrsZ/6zT
	VFOxIGtippu5ufscllBPWrqr04E9Nv2nVMNuS+KBgneVbV+Fc3/Mg9hhgDU3jTqDtTTE0bRf979
	0uleABQd5vl983aYLfIH2Cms1T4LeZtzVyftfjikL0fKpvRnGlDW0FtVUPXEqrXhzOBa71YwLVl
	+otwSPtwdjujFS6GOP+twRVTOVjJN9xxS09wDkWevzFQ6AAWirGZh1xkg2q5ABbA==
X-Received: by 2002:a17:906:1014:10b0:c15:cd7c:fcf0 with SMTP id a640c23a62f3a-c1fe7ea65eemr451096266b.1.1785752264331;
        Mon, 03 Aug 2026 03:17:44 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6566b3sm5355731a12.23.2026.08.03.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:17:43 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/3] net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Mon,  3 Aug 2026 13:17:34 +0300
Message-ID: <20260803101734.270821-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101734.270821-1-a.shimko.dev@gmail.com>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
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
 drivers/net/phy/dap8211r.c | 206 +++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
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
index 000000000000..f010ce0c3bd1
--- /dev/null
+++ b/drivers/net/phy/dap8211r.c
@@ -0,0 +1,206 @@
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
+/* Initial RGMII RX delay per hardware specification: 0 * 150ps == 0.00ns */
+#define DAP8211R_INITIAL_RX_DEL_VAL	0
+/* Initial RGMII TX delay per hardware specification: 1 * 150ps == 0.15ns*/
+#define DAP8211R_INITIAL_TX_DEL_VAL	1
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

