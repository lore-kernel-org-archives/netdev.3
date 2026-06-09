Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342B47D941;
	Tue,  9 Jun 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018890; cv=none; b=oRxlh3kHJAcxUr2Tmo7UGs4oA28QLD2/UJViU1IB9tCtN6HRrPLju5+aMOI4XFQtpQeH9bfNgT8HZDU7dAsR3X74/FiOltC0ZeOLidae9T+Q/FgCB0Hx/ejKOsEkoYrEEUl0+Awll/rxZ614eZZ5vBkvwjf2uUwq5MIT9nbybRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018890; c=relaxed/simple;
	bh=ZqYBjVZ1Tpo2yuRSCpdoxtEC9nA2evRGn3Caoio5gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IwBTnuyoBMSeXRwsw75uma5QxpPcdV+PF4gy75SSSUQsTIlj6fQ3VoWjJ3cH/Zc33M1ICuhWSeMNSoN8EitW0NRmnwqM1+4NS6sY9flRjCqEzCkRYMbvMvPizdBUg2cZ2vpnv+q5//KxPyT3TNX70mvP+oZbNpzlV4dzwGYEE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox1XOWXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox1XOWXb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11A0DC2BCB9;
	Tue,  9 Jun 2026 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018890;
	bh=ZqYBjVZ1Tpo2yuRSCpdoxtEC9nA2evRGn3Caoio5gmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ox1XOWXbcQNutFx8bFCQ6mZNo30PC9oxluN3yHlMzbJ+nAmtoMFDJPqtIHTWqMVzo
	 3SY0yNMwMmAELtEb8OL3Huc4CNDNGRg9BfifpaAU1jaMZ9ZHLKnTcXuS9uSV8YTKdh
	 h2VKzVbmnPp/m19+5Ypr8K53wVOYHe/AlxZ9N2VUiZ3/hg0mJxjdi5gGFp9/u/KcGY
	 qlVoMgGIbDqGl55eJ3BBRv6Glce5+bVHL2nN5wpUpaUcZM9o2iAjsGjdr5rTrZcxCi
	 5L/Nu+OSp++c3v+SN6eBYc7UWNrloDLg5qJVOVJqMWR+8OOaFEvjX5dlIE1YTkGpvS
	 chfCUEpYBrlvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA3CD98C5;
	Tue,  9 Jun 2026 15:28:10 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:11 +0300
Subject: [PATCH net-next v4 12/13] net: phy: Add support for the ADIN1140
 PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-12-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=5075;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=YZY5bxbzoagmeAn2HjstRqHiQjA1XQnyrGCm1+YOxM0=;
 b=cym7AhtLfmbnmruW1yzfd1qUps4+BgArApfeTDQpxOkik1/xW5Ly8JYR2zScHg4fG4OAs2g1d
 NP//p6w/OotAY2p7knM6WyrtO5Q9uW+e9O4wc0LK4/HZN4zky9jOa4h
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

Add a driver for the ADIN1140's internal 10BASE-T1S PHY. The device
doesn't implement autonegotiation, so the link is always reported as
being up.

The device implements both C22 and C45 MDIO access methods, but can only
be discovered over C22, since the C45 MMD devices lack the MDIO_DEVID1 and
MDIO_DEVID2 registers. The indirect C45 over C22 feature is not
supported.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v4 changelog:
 - no change
v3 changelog:
 - no change
v2 changelog:
 - No longer setting PHY_MAC_INTERRUPT in order to avoid state polling.
 - Replace the driver specific .read/write_mmd() functions with the ones
   exported from genphy.
 - Renamed the file to adin1140-phy.c in order to avoid module name
   conflicts with the adin1140 ethernet driver.
---
 MAINTAINERS                    |  7 ++++
 drivers/net/phy/Kconfig        |  6 ++++
 drivers/net/phy/Makefile       |  1 +
 drivers/net/phy/adin1140-phy.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..50f795dfa880 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1858,6 +1858,13 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
+ANALOG DEVICES INC ETHERNET PHY DRIVERS
+M:	Ciprian Regus <ciprian.regus@analog.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/net/phy/adin1140-phy.c
+
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..a29d3fed8a05 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -136,6 +136,12 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
+config ADIN1140_PHY
+	tristate "Analog Devices ADIN1140 10BASE-T1S PHY"
+	help
+	  Adds support for the Analog Devices, Inc. ADIN1140's internal
+	  10BASE-T1S PHY.
+
 config AMCC_QT2025_PHY
 	tristate "AMCC QT2025 PHY"
 	depends on RUST_PHYLIB_ABSTRACTIONS
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..e23df5e836e9 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -29,6 +29,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
+obj-$(CONFIG_ADIN1140_PHY)	+= adin1140-phy.o
 obj-$(CONFIG_AIR_AN8801_PHY)	+= air_an8801.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AIR_NET_PHYLIB)	+= air_phy_lib.o
diff --git a/drivers/net/phy/adin1140-phy.c b/drivers/net/phy/adin1140-phy.c
new file mode 100644
index 000000000000..d35da4ad680d
--- /dev/null
+++ b/drivers/net/phy/adin1140-phy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Analog Devices, Inc. ADIN1140 10BASE-T1S PHY
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define ADIN1140_PHY_ID		0x0283be00
+
+#define ADIN1140_PCS_CTRL		0x08f3
+#define ADIN1140_PCS_CTRL_LOOPBACK	BIT(14)
+
+static int adin1140_config_aneg(struct phy_device *phydev)
+{
+	/* phylib tries to clear BIT(12) in MDIO_CTRL1, since AN is disabled.
+	 * However, on the ADIN1140, that field is non-standard, being used
+	 * to control the reset status of the PHY (thus it needs to remain set).
+	 */
+	return 0;
+}
+
+static int adin1140_loopback(struct phy_device *phydev, bool enable, int speed)
+{
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, ADIN1140_PCS_CTRL,
+			      ADIN1140_PCS_CTRL_LOOPBACK,
+			      enable ? ADIN1140_PCS_CTRL_LOOPBACK : 0);
+}
+
+static int adin1140_read_status(struct phy_device *phydev)
+{
+	phydev->link = 1;
+	phydev->duplex = DUPLEX_HALF;
+	phydev->speed = SPEED_10;
+	phydev->autoneg = AUTONEG_DISABLE;
+
+	return 0;
+}
+
+static struct phy_driver adin1140_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(ADIN1140_PHY_ID),
+		.name = "ADIN1140_PHY",
+		.features = PHY_BASIC_T1S_P2MP_FEATURES,
+		.read_status = adin1140_read_status,
+		.config_aneg = adin1140_config_aneg,
+		.set_loopback = adin1140_loopback,
+		.read_mmd = genphy_read_mmd_c45,
+		.write_mmd = genphy_write_mmd_c45,
+		.get_plca_cfg = genphy_c45_plca_get_cfg,
+		.set_plca_cfg = genphy_c45_plca_set_cfg,
+		.get_plca_status = genphy_c45_plca_get_status,
+	},
+};
+module_phy_driver(adin1140_driver);
+
+static const struct mdio_device_id __maybe_unused adin1140_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(ADIN1140_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, adin1140_tbl);
+
+MODULE_DESCRIPTION("Analog Devices, Inc. ADIN1140 10BASE-T1S PHY");
+MODULE_AUTHOR("Ciprian Regus <ciprian.regus@analog.com>");
+MODULE_LICENSE("GPL");

-- 
2.43.0


