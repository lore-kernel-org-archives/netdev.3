Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5B3101B6;
	Tue, 12 May 2026 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560432; cv=none; b=iyELXkKN9A7VNri2VdLCBNdIhyRV9/lYbPrNoq+AFpJx0eR8WRkegupBPQggLG1tesGJlTtN+OSne++DN9KeiwgAb+tB9+aMLdKtmD3XjZjPXM/iI9jWGnSDUB3c6MRqZ/Wd4HXaup3jdxUoMAS34yhvyk7+U1qecyf1x248dbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560432; c=relaxed/simple;
	bh=Pz9uOkS7hxN04dyA0P80AqFBqwyETBvDpAxCbEq3u/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKWd50SXpXsCAw5YBEe8i5KQD3gl71kBjoZlIhnhGc/7XI3+TUU1W+qH+YfZQh0MTg6LQCDRQdC/G0m4CU5lfewDNaAM87LmYK00Nd8erc1QWhKxltg4hu3jxXkChNS/wlCKOH2IAKWfjAtwvGAxFPwWQp5oIenQRjMyEEOSQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DWArqCxl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DWArqCxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778560429;
	bh=Pz9uOkS7hxN04dyA0P80AqFBqwyETBvDpAxCbEq3u/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DWArqCxlBnReaXTHLF6gFcYAckZtvtzB0Pl3uQ1MqkLAwsV2enZq47s7fOVJ6x/cz
	 V6XABbHmvSOx9ET6/kYgBHvPc0I/4ZOo6GVvn1M5vGArU/787LmqWRDaiM2gNiVn+c
	 ED2ewZD91J0boAbzjaqNwZAPy/iH1toIIcNQ4nzIID0ZXKuU//Bj0EyDT+HawCjA3d
	 jMwuk8CsW3H21QiqzPrMkYrvtzVlKy35oy5x2rrkBl8SlQ5KGg23YiE+8ny/vtwai0
	 UVN6fpW73Q8FgPK5jJFqA9axegfeVm5Vre/u7phV+eA2wCk6cGNO8xuqFVzF+X/yTN
	 2sRfN2Xf1SlcQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 14DEF17E15A7;
	Tue, 12 May 2026 06:33:48 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 12 May 2026 06:33:19 +0200
Subject: [PATCH net-next v3 2/6] net: phy: Add Airoha phy library for
 shared code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-airoha-an8801-support-v3-2-1edb34e363ae@collabora.com>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
In-Reply-To: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778560425; l=4580;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Pz9uOkS7hxN04dyA0P80AqFBqwyETBvDpAxCbEq3u/Y=;
 b=HMJdv3XoKyO1NQEQASUBktCBL+ScvHDLgSCipoEYCTUmgL5vCMupM48LkM+NZUTS0bmtMAmHd
 YAOm8nEDK4ODBL+5o76Jw70C4kE7JYjLELNDs0GXnBHF2HLWxK1+1ZG
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In preparation of Airoha AN8801R PHY support, split out the interface
functions that will be common between the already present air_en8811h
driver and the new one, and put them into a new library named
air_phy_lib.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/phy/Kconfig       |  6 ++++++
 drivers/net/phy/Makefile      |  1 +
 drivers/net/phy/air_en8811h.c | 13 ++-----------
 drivers/net/phy/air_phy_lib.c | 32 ++++++++++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h | 16 ++++++++++++++++
 5 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b5ee338b620d..b6b1cde7e51f 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -92,10 +92,16 @@ config AS21XXX_PHY
 
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
+	select AIR_NET_PHYLIB
 	select PHY_COMMON_PROPS
 	help
 	  Currently supports the Airoha EN8811H PHY.
 
+config AIR_NET_PHYLIB
+	tristate
+	help
+	  Airoha Ethernet PHY common library
+
 config AMD_PHY
 	tristate "AMD and Altima PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 05e4878af27a..7cf1fa9e12cb 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -30,6 +30,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
+obj-$(CONFIG_AIR_NET_PHYLIB)	+= air_phy_lib.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 29ae73e65caa..be7c3426182a 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -21,6 +21,8 @@
 #include <linux/wordpart.h>
 #include <linux/unaligned.h>
 
+#include "air_phy_lib.h"
+
 #define EN8811H_PHY_ID		0x03a2a411
 #define AN8811HB_PHY_ID		0xc0ff04a0
 
@@ -40,7 +42,6 @@
 #define   AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
 #define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
 
-#define AIR_EXT_PAGE_ACCESS		0x1f
 #define   AIR_PHY_PAGE_STANDARD			0x0000
 #define   AIR_PHY_PAGE_EXTENDED_4		0x0004
 
@@ -244,16 +245,6 @@ static const unsigned long en8811h_led_trig = BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
 					      BIT(TRIGGER_NETDEV_RX)          |
 					      BIT(TRIGGER_NETDEV_TX);
 
-static int air_phy_read_page(struct phy_device *phydev)
-{
-	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
-}
-
-static int air_phy_write_page(struct phy_device *phydev, int page)
-{
-	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
-}
-
 static int __air_buckpbus_reg_write(struct phy_device *phydev,
 				    u32 pbus_address, u32 pbus_data)
 {
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
new file mode 100644
index 000000000000..8ef5af4becf0
--- /dev/null
+++ b/drivers/net/phy/air_phy_lib.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Airoha Ethernet PHY common library
+ *
+ * Copyright (C) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#include "air_phy_lib.h"
+
+#define AIR_EXT_PAGE_ACCESS		0x1f
+
+int air_phy_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
+}
+EXPORT_SYMBOL_GPL(air_phy_read_page);
+
+int air_phy_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
+}
+EXPORT_SYMBOL_GPL(air_phy_write_page);
+
+MODULE_DESCRIPTION("Airoha PHY Library");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Louis-Alexis Eyraud");
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
new file mode 100644
index 000000000000..79367e8e5907
--- /dev/null
+++ b/drivers/net/phy/air_phy_lib.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#ifndef __AIR_PHY_LIB_H
+#define __AIR_PHY_LIB_H
+
+#include <linux/phy.h>
+
+int air_phy_read_page(struct phy_device *phydev);
+int air_phy_write_page(struct phy_device *phydev, int page);
+
+#endif /* __AIR_PHY_LIB_H */

-- 
2.54.0

