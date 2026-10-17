Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D3392C27
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256006; cv=none; b=a2EiG+8Du0JQsJpibS41QVwaW+kZ6KhBkp4uLZ3q2WUF5ZDQPwq+r0V87EbTNBachht0X8lsjN81HYVRdYIpvTsYaGuxLxU+qyMyizOkT6byBwaBs2C2KLhYa9/sj1pTOG7UeKYWX5aq6JOCUIx6RNOFsNKHKhYxrM1xVXVzLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256006; c=relaxed/simple;
	bh=7PTi2fWkFCMjPAym8bymWt+qcmtBbRZlQwXFCqQ7eMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGESxX6OVV2PZPOvVyRkr5VCFOD8j29nflxFmD4PzroGdnTM5TmOLeJJ4xD8T8gRU8xmTTv7PAKtUWuA4rt+qSDykzH9o8PP9lmVzHGo7ARLK41TssiRbZ/jMVY0rAOsJ53JDQwI65gWtmpibx2xGLY49VFKaAEonIXkTBaQM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlKkTpfF; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlKkTpfF"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e4a61a2ff9so3520905ad.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792256003; x=1792860803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7MGG2O6iHXtpJeWq+LVCqdiXI/1b1YP1KtK/ar5GBw=;
        b=jlKkTpfF2jd/TkoJ1jbk9SnEcYrLRoLIjj/SvdZVAguDb1kZKeaAKuJfoK7Hqg34/1
         U+eN5T7qljCE1nZCOHExrr1Fo/cqkJlYEJicxwVdrWDmOW9aGoJ0YgZNgwvp6P2Dbt3/
         dmf1Li1Bga/Gd6KI295xyMTf5F4bD3bcogRd0XJU8HXL+tjHZToIvAzQFp1+zLpoXKqj
         gZ8mgvHkuTFJ4cIB9PnWAW7E0NoJUjrgQYQ9jGnfiXzRu3yaExVF1xZ7JQTy1xfnoVzW
         7VXk+mhYjE7wOx7aEpQvGs1XnPrM1g+JunH6RgvObfOuPcZNH+WWoFy//Myywrj/dv4Q
         txhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792256003; x=1792860803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7MGG2O6iHXtpJeWq+LVCqdiXI/1b1YP1KtK/ar5GBw=;
        b=o9ldhbKKANIEYwbhiI3xbqlmdaAGjovz4d4GZtyR+7IEBW4MuDtfXEhftbImgnr1Wp
         rQHzAM93ybl1pHmZBxJn+AgmpZ81AHTShT4s+BV6vxY1kDKKTf8E6Bl1sw0MegDXwXef
         17+Q708qeFlNtii5MECPJ3w3y3h9ct4qlE+VPiMbkRRdbEiRejwVEOgpr/s8TXXCZrP8
         Nd8a8U8m/S8ED1AWr77IpTtpsFNUIKe2Qma9sIwiPZaAl49ADrJpuiUmIJyFSDWPb7Rw
         GccSjyflkCATKQmQrj5hB6GpS8OnyM+3w2XyNGTqP8a/C0eKIHwhXiIGoSt3zF8wO4r9
         hvuA==
X-Forwarded-Encrypted: i=1; AKwUvBxLwSVWA6S7Cbe7vEGwKmGFJLY57dldNBsWV+iMmFAoB1MfSSJH8GUngn9734qJ9KJVO0dobE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL323ukf57tXWdir2OwTmhC30CWBHhxOdmsWWsmqYFo9CAET2OO
	CmsV3wOm/HgGoX8VZwPAqWivQku7YXspnETSfFnSlz3sMCSS2q9bAtda
X-Gm-Gg: AYBFou30oJsQ8Mpo8hcXsWIFoxNzSD0q7nhuU636wPGtg4kWZoxDLgUvDnqxibAgpX4
	MqUrNkva+GyniZLDu/ooZyAFpPgtbKPEUIEpO/caKBY8LiGmUAi0cY32BEv4qTg5+zPYwS7OVVO
	/C9NSsNYh4OoA1uoW5eZtyar1mei2iPOuFKkPDBMEXXaQzZ91kfhAXB6WfHnHN8ywRarkOljGsz
	v6+AUrVsapuJLLFymoEt7NijnwYPFGoPcaF0eRllT2vmKhRZDAzfawDwXaf5skzFm6R1MZ/DKqz
	A5oPp7Hs/f1HzOOkGDNNK2ozOVWpXVuz6YcobCNdRrVlsDRGh8QybOshtTwZCSqgkKMI1NyAnZk
	tyhU/xc8KocnwI0thpwJrN1k/PICPcz21a9wi1oyNpaNBs0Kt72MrhAOPA/mQL7O0bB/GrCZ8vM
	y44PwZHLgY6vxRNGgkUNrkJWVwb4hIl5gP+qYRA8PIkWblAPlofh/QB7vxaandj/5hK1j5Se71L
	+1LBLxsv4LlI0U98aP2
X-Received: by 2002:a17:903:3884:b0:2e9:6972:54d7 with SMTP id d9443c01a7336-2e9a7058929mr26666915ad.52.1792256003151;
        Sat, 17 Oct 2026 09:53:23 -0700 (PDT)
Received: from AERO17.taila7786d.ts.net ([156.231.115.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e835a19sm22530415ad.45.2026.10.17.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:53:22 -0700 (PDT)
From: Pufan Jin <cyan2254650260@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: Add JLSemi JL21xx Gigabit Ethernet PHY driver
Date: Sun, 18 Oct 2026 00:53:16 +0800
Message-ID: <20261017165316.146793-1-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new PHY driver for JLSemi (Jinglue Semiconductor (Shanghai)
Co., Ltd.) Gigabit Ethernet PHYs, specifically supporting the JL2101,
JL2121, and generic JL21xx models.

The driver implements:
- Paged register access via register 0x1f
- RGMII TX and RX internal delay configuration with Device Tree
  support via phy_get_internal_delay()
- Link downshift and resolved speed, duplex, and master/slave mode
  reporting from vendor-specific status registers
- Interrupt handling for link state change and PME wakeup events
- Hardware LED control via the Linux LED class / netdev triggers
- Wake-on-LAN (WoL) with magic packet matching
- Autonomous EEE disable to prevent interoperability packet drops
- Power management (suspend / resume)

Link: https://www.jlsemi.com/
Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
---
Changes in v2:
- Drop redundant phy_interface_is_rgmii() check in jlsemi_config_init()
  (Andrew Lunn)
- Change speed check in jlsemi_read_status() to '== SPEED_1000' since
  JL21xx only supports up to 1000M and 100BASE-TX does not use Master/Slave
  clock resolution (Andrew Lunn)
- Check device_can_wakeup() in get_wol/set_wol, and configure wakeup
  capability and wake IRQ in probe() when 'wakeup-source' is present
  (Andrew Lunn)
- Drop redundant .features = PHY_GBIT_FEATURES (Andrew Lunn)
- Use PHY_ID_MATCH_VENDOR() for generic driver and mdio table (Andrew Lunn)

 MAINTAINERS              |   6 +
 drivers/net/phy/Kconfig  |   9 +
 drivers/net/phy/Makefile |   1 +
 drivers/net/phy/jlsemi.c | 555 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 drivers/net/phy/jlsemi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8..4f738a573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13976,6 +13976,12 @@ T:	git https://github.com/kleikamp/linux-shaggy.git
 F:	Documentation/admin-guide/jfs.rst
 F:	fs/jfs/
 
+JLSEMI PHY DRIVER
+M:	Pufan Jin <cyan2254650260@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/jlsemi.c
+
 JME NETWORK DRIVER
 M:	Guo-Fu Tseng <cooldavid@cooldavid.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b4ef927fd..535a48084 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -270,6 +270,15 @@ config INTEL_XWAY_PHY
 	  PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
 	  SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
 
+config JLSEMI_PHY
+	tristate "JLSemi Ethernet PHYs"
+	help
+	  Supports the JLSemi Gigabit Ethernet PHYs, including the
+	  JL2121 and JL2101 models found on embedded system carrier boards
+	  and single-board computers.
+
+	  If unsure, say N.
+
 config LSI_ET1011C_PHY
 	tristate "LSI ET1011C PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 25c4a3c24..2d7758e86 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
+obj-$(CONFIG_JLSEMI_PHY)	+= jlsemi.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
diff --git a/drivers/net/phy/jlsemi.c b/drivers/net/phy/jlsemi.c
new file mode 100644
index 000000000..c83739ad1
--- /dev/null
+++ b/drivers/net/phy/jlsemi.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for JLSemi Gigabit Ethernet PHYs (JL2121 / JL2101)
+ *
+ * Copyright (C) 2026 Pufan Jin <cyan2254650260@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/property.h>
+
+#define PHY_ID_JL2101			0x937c4032
+#define PHY_ID_JL2121			0x937c4030
+#define PHY_ID_JLSEMI			0x937c4000
+#define JLSEMI_PAGE_SELECT		0x1f
+
+/* Status page and register */
+#define JLSEMI_STATUS_PAGE		0xa43
+#define JLSEMI_PHYSR			0x1a
+#define JLSEMI_PHYSR_DUPLEX		BIT(3)
+#define JLSEMI_PHYSR_SPEED_MASK		GENMASK(5, 4)
+#define JLSEMI_PHYSR_SPEED_1000		0x20
+#define JLSEMI_PHYSR_SPEED_100		0x10
+#define JLSEMI_PHYSR_SPEED_10		0x00
+#define JLSEMI_PHYSR_MASTER		BIT(11)
+
+/* RGMII delay page and registers */
+#define JLSEMI_RGMII_PAGE		0xd08
+#define JLSEMI_TXCR			0x11
+#define JLSEMI_TX_DELAY			BIT(8)
+#define JLSEMI_RXCR			0x15
+#define JLSEMI_RX_DELAY			BIT(3)
+
+/* Power and EEE configuration */
+#define JLSEMI_PHYCR2			0x19
+#define JLSEMI_PHYCR2_PHY_EEE_ENABLE	BIT(5)
+
+/* Interrupt page and registers */
+#define JLSEMI_INSR			0x1d
+#define JLSEMI_INER_PAGE		0xa42
+#define JLSEMI_INER			0x12
+#define JLSEMI_INER_LINK_STATUS		BIT(4)
+#define JLSEMI_INER_PME			BIT(7)
+
+/* Wake-on-LAN settings */
+#define JLSEMI_WOL_PAGE			0xd8a
+#define JLSEMI_WOL_SETTINGS_EVENTS	16
+#define JLSEMI_WOL_EVENT_MAGIC		BIT(12)
+#define JLSEMI_WOL_RST_RMSQ		17
+#define JLSEMI_WOL_RG_RSTB		BIT(15)
+#define JLSEMI_WOL_RMSQ			0x1fff
+
+/* Physical MAC address for WoL */
+#define JLSEMI_PHYSICAL_ADDR_PAGE	0xd8c
+#define JLSEMI_PHYSICAL_ADDR_WORD0	16
+#define JLSEMI_PHYSICAL_ADDR_WORD1	17
+#define JLSEMI_PHYSICAL_ADDR_WORD2	18
+
+/* LED control */
+#define JLSEMI_LED_COUNT		3
+#define JLSEMI_LEDCR_PAGE		0xd04
+#define JLSEMI_LEDCR			0x10
+#define JLSEMI_LEDCR_MODE		BIT(15)
+#define JLSEMI_LEDCR_ACT_TXRX		BIT(4)
+#define JLSEMI_LEDCR_LINK_1000		BIT(3)
+#define JLSEMI_LEDCR_LINK_100		BIT(1)
+#define JLSEMI_LEDCR_LINK_10		BIT(0)
+#define JLSEMI_LEDCR_MASK		GENMASK(4, 0)
+#define JLSEMI_LEDCR_SHIFT		5
+
+struct jlsemi_priv {
+	u16 iner;
+};
+
+static int jlsemi_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, JLSEMI_PAGE_SELECT);
+}
+
+static int jlsemi_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, JLSEMI_PAGE_SELECT, page);
+}
+
+static int jlsemi_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct jlsemi_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	if (device_property_read_bool(dev, "wakeup-source") &&
+	    phy_interrupt_is_valid(phydev)) {
+		device_set_wakeup_capable(dev, true);
+		devm_pm_set_wake_irq(dev, phydev->irq);
+	}
+	return 0;
+}
+
+static int jlsemi_config_rgmii_delay(struct phy_device *phydev)
+{
+	u16 val_txdly = 0, val_rxdly = 0;
+	s32 rx_delay = -1, tx_delay = -1;
+	int ret;
+
+	if (!phy_interface_is_rgmii(phydev))
+		return 0;
+
+	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_TXID)
+		rx_delay = phy_get_internal_delay(phydev, NULL, 0, true);
+
+	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_RXID)
+		tx_delay = phy_get_internal_delay(phydev, NULL, 0, false);
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val_txdly = 0;
+		val_rxdly = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		val_txdly = JLSEMI_TX_DELAY;
+		val_rxdly = JLSEMI_RX_DELAY;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		val_txdly = 0;
+		val_rxdly = JLSEMI_RX_DELAY;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val_txdly = JLSEMI_TX_DELAY;
+		val_rxdly = 0;
+		break;
+	default:
+		return 0;
+	}
+
+	if (rx_delay >= 0)
+		val_rxdly = rx_delay > 0 ? JLSEMI_RX_DELAY : 0;
+	if (tx_delay >= 0)
+		val_txdly = tx_delay > 0 ? JLSEMI_TX_DELAY : 0;
+
+	ret = phy_modify_paged_changed(phydev, JLSEMI_RGMII_PAGE,
+				       JLSEMI_TXCR, JLSEMI_TX_DELAY, val_txdly);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify_paged_changed(phydev, JLSEMI_RGMII_PAGE,
+					JLSEMI_RXCR, JLSEMI_RX_DELAY,
+					val_rxdly);
+}
+
+static int jlsemi_disable_autonomous_eee(struct phy_device *phydev)
+{
+	return phy_modify(phydev, JLSEMI_PHYCR2,
+				JLSEMI_PHYCR2_PHY_EEE_ENABLE, 0);
+}
+
+static int jlsemi_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = jlsemi_disable_autonomous_eee(phydev);
+	if (ret < 0)
+		return ret;
+
+	return jlsemi_config_rgmii_delay(phydev);
+}
+
+static int jlsemi_ack_interrupt(struct phy_device *phydev)
+{
+	int err = phy_read(phydev, JLSEMI_INSR);
+
+	return (err < 0) ? err : 0;
+}
+
+static int jlsemi_config_intr(struct phy_device *phydev)
+{
+	struct jlsemi_priv *priv = phydev->priv;
+	int err;
+	u16 val;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		err = jlsemi_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		val = JLSEMI_INER_LINK_STATUS;
+		err = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER, val);
+		if (!err)
+			priv->iner = val;
+	} else {
+		val = 0;
+		err = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER, val);
+		if (!err)
+			priv->iner = val;
+
+		err = jlsemi_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+static irqreturn_t jlsemi_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, JLSEMI_INSR);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (irq_status & JLSEMI_INER_LINK_STATUS) {
+		phy_trigger_machine(phydev);
+		return IRQ_HANDLED;
+	}
+
+	if (irq_status & JLSEMI_INER_PME) {
+		pm_wakeup_event(&phydev->mdio.dev, 0);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int jlsemi_read_status(struct phy_device *phydev)
+{
+	int err, val;
+
+	err = genphy_read_status(phydev);
+	if (err < 0 || !phydev->link)
+		return err;
+
+	val = phy_read_paged(phydev, JLSEMI_STATUS_PAGE, JLSEMI_PHYSR);
+	if (val < 0)
+		return val;
+
+	if (val & JLSEMI_PHYSR_DUPLEX)
+		phydev->duplex = DUPLEX_FULL;
+	else
+		phydev->duplex = DUPLEX_HALF;
+
+	switch (val & JLSEMI_PHYSR_SPEED_MASK) {
+	case JLSEMI_PHYSR_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	case JLSEMI_PHYSR_SPEED_100:
+		phydev->speed = SPEED_100;
+		break;
+	case JLSEMI_PHYSR_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
+	default:
+		phydev->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	if (phydev->speed == SPEED_1000) {
+		if (val & JLSEMI_PHYSR_MASTER)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+		else
+			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+	} else {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
+	}
+
+	return 0;
+}
+
+static void jlsemi_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
+{
+	int val;
+
+	if (!device_can_wakeup(&phydev->mdio.dev)) {
+		wol->supported = 0;
+		wol->wolopts = 0;
+		return;
+	}
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+
+	val = phy_read_paged(phydev, JLSEMI_WOL_PAGE, JLSEMI_WOL_SETTINGS_EVENTS);
+	if (val < 0)
+		return;
+
+	if (val & JLSEMI_WOL_EVENT_MAGIC)
+		wol->wolopts |= WAKE_MAGIC;
+}
+
+static int jlsemi_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
+{
+	const u8 *mac_addr;
+	int oldpage, ret;
+
+	if (!device_can_wakeup(&phydev->mdio.dev))
+		return -EOPNOTSUPP;
+
+	if (wol->wolopts & ~WAKE_MAGIC)
+		return -EINVAL;
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		if (!phydev->attached_dev)
+			return -EINVAL;
+
+		mac_addr = phydev->attached_dev->dev_addr;
+
+		oldpage = phy_select_page(phydev, JLSEMI_PHYSICAL_ADDR_PAGE);
+		if (oldpage < 0)
+			return oldpage;
+
+		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD0,
+			    mac_addr[1] << 8 | mac_addr[0]);
+		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD1,
+			    mac_addr[3] << 8 | mac_addr[2]);
+		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD2,
+			    mac_addr[5] << 8 | mac_addr[4]);
+
+		ret = __phy_write(phydev, JLSEMI_PAGE_SELECT, JLSEMI_WOL_PAGE);
+		if (ret < 0)
+			goto restore;
+
+		__phy_write(phydev, JLSEMI_WOL_SETTINGS_EVENTS,
+			    JLSEMI_WOL_EVENT_MAGIC);
+		__phy_write(phydev, JLSEMI_WOL_RST_RMSQ,
+			    JLSEMI_WOL_RMSQ);
+restore:
+		phy_restore_page(phydev, oldpage, ret);
+	} else {
+		oldpage = phy_select_page(phydev, JLSEMI_WOL_PAGE);
+		if (oldpage < 0)
+			return oldpage;
+
+		__phy_write(phydev, JLSEMI_WOL_SETTINGS_EVENTS, 0);
+		__phy_clear_bits(phydev, JLSEMI_WOL_RST_RMSQ,
+				 JLSEMI_WOL_RG_RSTB);
+
+		phy_restore_page(phydev, oldpage, 0);
+	}
+
+	device_set_wakeup_enable(&phydev->mdio.dev, !!(wol->wolopts & WAKE_MAGIC));
+
+	return 0;
+}
+
+static int jlsemi_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	if (device_may_wakeup(&phydev->mdio.dev)) {
+		ret = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER,
+				      JLSEMI_INER_PME);
+		if (ret < 0)
+			return ret;
+
+		jlsemi_ack_interrupt(phydev);
+		return 0;
+	}
+
+	return genphy_suspend(phydev);
+}
+
+static int jlsemi_resume(struct phy_device *phydev)
+{
+	struct jlsemi_priv *priv = phydev->priv;
+	int ret;
+
+	ret = genphy_resume(phydev);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER,
+			       priv ? priv->iner : 0);
+}
+
+static int jlsemi_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK) |
+					BIT(TRIGGER_NETDEV_LINK_10) |
+					BIT(TRIGGER_NETDEV_LINK_100) |
+					BIT(TRIGGER_NETDEV_LINK_1000) |
+					BIT(TRIGGER_NETDEV_RX) |
+					BIT(TRIGGER_NETDEV_TX);
+
+	if (index >= JLSEMI_LED_COUNT)
+		return -EINVAL;
+
+	if (rules & ~mask)
+		return -EOPNOTSUPP;
+
+	if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int jlsemi_led_hw_control_get(struct phy_device *phydev, u8 index,
+				     unsigned long *rules)
+{
+	int val;
+
+	if (index >= JLSEMI_LED_COUNT)
+		return -EINVAL;
+
+	val = phy_read_paged(phydev, JLSEMI_LEDCR_PAGE, JLSEMI_LEDCR);
+	if (val < 0)
+		return val;
+
+	val >>= JLSEMI_LEDCR_SHIFT * index;
+	val &= JLSEMI_LEDCR_MASK;
+
+	if (val & JLSEMI_LEDCR_LINK_10)
+		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (val & JLSEMI_LEDCR_LINK_100)
+		__set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (val & JLSEMI_LEDCR_LINK_1000)
+		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+	if ((val & JLSEMI_LEDCR_LINK_10) &&
+	    (val & JLSEMI_LEDCR_LINK_100) &&
+	    (val & JLSEMI_LEDCR_LINK_1000)) {
+		__set_bit(TRIGGER_NETDEV_LINK, rules);
+	}
+
+	if (val & JLSEMI_LEDCR_ACT_TXRX) {
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	return 0;
+}
+
+static int jlsemi_led_hw_control_set(struct phy_device *phydev, u8 index,
+				     unsigned long rules)
+{
+	const u16 mask = JLSEMI_LEDCR_MASK << (JLSEMI_LEDCR_SHIFT * index);
+	u16 reg = 0;
+
+	if (index >= JLSEMI_LED_COUNT)
+		return -EINVAL;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_10, &rules)) {
+		reg |= JLSEMI_LEDCR_LINK_10;
+	}
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_100, &rules)) {
+		reg |= JLSEMI_LEDCR_LINK_100;
+	}
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_1000, &rules)) {
+		reg |= JLSEMI_LEDCR_LINK_1000;
+	}
+
+	if (test_bit(TRIGGER_NETDEV_RX, &rules) ||
+	    test_bit(TRIGGER_NETDEV_TX, &rules)) {
+		reg |= JLSEMI_LEDCR_ACT_TXRX;
+	}
+
+	reg <<= JLSEMI_LEDCR_SHIFT * index;
+	reg |= JLSEMI_LEDCR_MODE;
+
+	return phy_modify_paged(phydev, JLSEMI_LEDCR_PAGE, JLSEMI_LEDCR,
+				mask, reg);
+}
+
+static struct phy_driver jlsemi_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_JL2101),
+		.name			= "JLSemi JL2101 Gigabit Ethernet",
+		.flags			= PHY_ALWAYS_CALL_SUSPEND,
+		.probe			= jlsemi_probe,
+		.soft_reset		= genphy_soft_reset,
+		.config_init		= jlsemi_config_init,
+		.read_status		= jlsemi_read_status,
+		.config_intr		= jlsemi_config_intr,
+		.handle_interrupt	= jlsemi_handle_interrupt,
+		.set_wol		= jlsemi_set_wol,
+		.get_wol		= jlsemi_get_wol,
+		.suspend		= jlsemi_suspend,
+		.resume			= jlsemi_resume,
+		.read_page		= jlsemi_read_page,
+		.write_page		= jlsemi_write_page,
+		.led_hw_is_supported	= jlsemi_led_hw_is_supported,
+		.led_hw_control_get	= jlsemi_led_hw_control_get,
+		.led_hw_control_set	= jlsemi_led_hw_control_set,
+		.disable_autonomous_eee	= jlsemi_disable_autonomous_eee,
+	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_JL2121),
+		.name			= "JLSemi JL2121 Gigabit Ethernet",
+		.flags			= PHY_ALWAYS_CALL_SUSPEND,
+		.probe			= jlsemi_probe,
+		.soft_reset		= genphy_soft_reset,
+		.config_init		= jlsemi_config_init,
+		.read_status		= jlsemi_read_status,
+		.config_intr		= jlsemi_config_intr,
+		.handle_interrupt	= jlsemi_handle_interrupt,
+		.set_wol		= jlsemi_set_wol,
+		.get_wol		= jlsemi_get_wol,
+		.suspend		= jlsemi_suspend,
+		.resume			= jlsemi_resume,
+		.read_page		= jlsemi_read_page,
+		.write_page		= jlsemi_write_page,
+		.led_hw_is_supported	= jlsemi_led_hw_is_supported,
+		.led_hw_control_get	= jlsemi_led_hw_control_get,
+		.led_hw_control_set	= jlsemi_led_hw_control_set,
+		.disable_autonomous_eee	= jlsemi_disable_autonomous_eee,
+	},
+	{
+		PHY_ID_MATCH_VENDOR(PHY_ID_JLSEMI),
+		.name			= "JLSemi Generic Gigabit Ethernet",
+		.flags			= PHY_ALWAYS_CALL_SUSPEND,
+		.probe			= jlsemi_probe,
+		.soft_reset		= genphy_soft_reset,
+		.config_init		= jlsemi_config_init,
+		.read_status		= jlsemi_read_status,
+		.config_intr		= jlsemi_config_intr,
+		.handle_interrupt	= jlsemi_handle_interrupt,
+		.suspend		= jlsemi_suspend,
+		.resume			= jlsemi_resume,
+		.read_page		= jlsemi_read_page,
+		.write_page		= jlsemi_write_page,
+		.disable_autonomous_eee	= jlsemi_disable_autonomous_eee,
+	},
+};
+
+module_phy_driver(jlsemi_drivers);
+
+static const struct mdio_device_id __maybe_unused jlsemi_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(PHY_ID_JL2101) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_JL2121) },
+	{ PHY_ID_MATCH_VENDOR(PHY_ID_JLSEMI) },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(mdio, jlsemi_tbl);
+
+MODULE_DESCRIPTION("JLSemi Ethernet PHY driver");
+MODULE_AUTHOR("Pufan Jin <cyan2254650260@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.56.0

