Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E74D956C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167361; cv=none; b=gBkXQgJaDkP4+Dt6Hb58nl6icxCKI8sKpntcxi+z4AdPjO1mXwT4BliL0dkKO0Wd8NrCqNmlcwg0hUY7vWZKQgp08GcjDBNHV/CYmzIdMpZGno0B/DDozhgyCM840Sq0cwPirVhP+th4iZEqeviLySFbI4OMZoanm0v+8fS2KTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167361; c=relaxed/simple;
	bh=b24qo8LmhPkuNd3NuW73vXN8vY1fkyHYQRMaRyRqh8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMhN98BX5TzZdNsfM3lAJbj3pNpZxNfLw1be4ukvZlpPy/+aN8qdimVlxKM2l8SQCskb5sdD1/TQxAKJiR9qFjpjszN1K5I6/b6NEsanKe9tJ8Cxng0xJTAtQefDzBbWt1II8JFiwV7NVGDbXqmu4MC/u3odRBmlW6JnPL2WO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj7MIkZd; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj7MIkZd"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso28992eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792167354; x=1792772154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDXaAnUIIYiZp3PumgthTafuIL4vgBDyv/LTLf82Ybg=;
        b=dj7MIkZdNO1mR1s330W20CzBzJMWEpyuehZqgLdi3yd5o1tmutOyHAYAlUXB3QwY3m
         bSLWdqZwQ608VwQabG7t8BRETY1ZfUsuPm3xIpXYSvRbh3HURD9aNJI+iSuAma7jJoIy
         8dBF9YFO4nPjpZ3jmXpbUBWHj2HRHqB2IgZGhQahKgDZJXPdcQt72RWWcAP3MVkz0D16
         7l5xyVbZYDFSY+YbAr1o2L4ZME7xf0Cq7W5legqkFmShe4ZtfDwQcjYV7d7rEGK/9t8h
         qNBV7vQURz5nPO3kDjQLvkLs45brMwB0d7k4DfeaJgIMcZvHSfcD9ulIgsOrzRjUl7nc
         RwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167354; x=1792772154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDXaAnUIIYiZp3PumgthTafuIL4vgBDyv/LTLf82Ybg=;
        b=dRyUVdx7vuZn69lOd2kFi43wL8Lvy3x7uV3o+kOm1TM3hDpackG/5aS4S/28bjT2lO
         wPi2lgtKyKKj3WDgLSa6xa2nxmHKVG7Dat5G6AhiwujKt0IjVwK9ghraXM8dM4zvFeGO
         W/tRNH14G2j2MRzaqZUzLB/ehB6iWyAEf+lt5eKiAEyOTfX3tBsXKY04PQqx99CoQ75X
         uI78T74m87tppiai0AZi0nKhOFWyqBDqVdD4bts4gsDwqRr0s28z0pv+7tHm4i8+U/t9
         za1yKqKrNuyKwoz6Zo8gX/Wn8yYtsIzZT4LKlYlt2NQfUtVScWobX2I9hje2P9Mz3noT
         tslg==
X-Forwarded-Encrypted: i=1; AKwUvByvLprTWLuyCeSde/2g5MZIWdx0SRCJ3dxuvFnWlVyWLzBR9HAayTiQh+0fjM5R8HAt7WYTKTg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWk9uh+1HcLGqsfRJxsqER7dXRA1TrPDMLdvHkqS8RjptLEd7Y
	L7S1L4Etm24TL0xSIw/wVVMlsF4Frr1j1+e4M/oYoSzQKgUumjd7hrL1
X-Gm-Gg: AYBFou26dTfIp9l7Ao/2uwaNtzNMmTQW8v348jim+SUd4JQQQFJwd63Oo9lE7pFcrpq
	yBTHItFNSYv5aUnl45A+/2UfYdJXWW2UmX1VI1JvzpQiYuAHIxXV1GgzrGzG2laZl0XUiSU3RRe
	BGYC9dl04A7yi45jNOtujODAecifqFlpf7aosFIeAi9tUNxVnwcoxNEyD13jidN32+ZcU+LrE5v
	oyYe8QRdjHtV7pcv1jalMSHVIGX/Nk7E1sgodVZPlWXPG/zdRqeTcKhXy9qtq72sc9qCDYvdJmP
	7ygVQFX47duiAOzp4fqmVAUjwIS4l9fVjfKrOisz9B0hCCtHivQ6IMFZIA6VjtbBO7wbEg1kmb4
	uCuxPZGsuBKlKNZGIeDeRFxm201BetGoSFHkhCWX5Qtyw1ZoVAIWlspoLFiZoaasxW66o6kFw8V
	JyPV7fENW0+aAPlPUF0AHvOZNCEZevrytV0NYHlSZBUirD0RVKRm1oM9zka2Y6w1ZudIK1181/I
	iibZwDnxkllzHOnSWU=
X-Received: by 2002:a05:701b:204f:20b0:151:7f08:5961 with SMTP id a92af1059eb24-1850c9cf541mr524837c88.4.1792167353909;
        Fri, 16 Oct 2026 09:15:53 -0700 (PDT)
Received: from AERO17.taila7786d.ts.net ([152.175.65.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm7956688c88.4.2026.10.16.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:15:51 -0700 (PDT)
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
Subject: [PATCH net-next] net: phy: Add JLSemi JL21xx Gigabit Ethernet PHY driver
Date: Sat, 17 Oct 2026 00:15:43 +0800
Message-ID: <20261016161543.444356-1-cyan2254650260@gmail.com>
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
 MAINTAINERS              |   6 +
 drivers/net/phy/Kconfig  |   9 +
 drivers/net/phy/Makefile |   1 +
 drivers/net/phy/jlsemi.c | 551 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 567 insertions(+)
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
index 000000000..c3acff48d
--- /dev/null
+++ b/drivers/net/phy/jlsemi.c
@@ -0,0 +1,551 @@
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
+
+#define PHY_ID_JL2101			0x937c4032
+#define PHY_ID_JL2121			0x937c4030
+#define PHY_ID_JL21XX			0x937c0000
+#define JLSEMI_PHY_ID_MASK		0xffff0000
+
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
+	if (phy_interface_is_rgmii(phydev)) {
+		ret = jlsemi_config_rgmii_delay(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
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
+	if (phydev->speed >= SPEED_1000) {
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
+		.features		= PHY_GBIT_FEATURES,
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
+		.features		= PHY_GBIT_FEATURES,
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
+		.phy_id			= PHY_ID_JL21XX,
+		.phy_id_mask		= JLSEMI_PHY_ID_MASK,
+		.name			= "JLSemi Generic Gigabit Ethernet",
+		.features		= PHY_GBIT_FEATURES,
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
+	{ PHY_ID_JL21XX, JLSEMI_PHY_ID_MASK },
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

