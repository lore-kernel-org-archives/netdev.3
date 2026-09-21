Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1164BE432;
	Mon, 21 Sep 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007565; cv=none; b=E2VKABv/d5ErtlwOXImyL58HT++qzPkfdezlhLiKe4d4Hqm3GJSsnQXYhLVJJxm37Vqm+pmo1OSgWAn8M1SbniGB8/pTspE0gYCNyZxWvwK/1R+QHoLWtaKIw/ONiP4TzoJ6d/c8qBWp5tehLNQ6e17xJhC7Po2q0qiMgMcR4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007565; c=relaxed/simple;
	bh=ZHJtnhUKEiw3qJAn/+DiVKMC8hpWnVdxVd9Z71Ot0EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH9t4VdqPk4hwaZdNmPyZyy3umR1tTs7zAhPRwsYPq5DzxinH9Uw/QSJb4fkkxPv9T16t7gmdhulXT1v771lAZgOBtjbrXl3LTDgTyu6RrO9wxWSwarrssd27NPU2QmLkPVJZtVy6Ka7wCzYcC82TvUpU7Hq65y4w5nPWvAiFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=auWwnWWq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="auWwnWWq"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpT295cbyzMlD8;
	Mon, 21 Sep 2026 18:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790007553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7D8EFqHEwFH6FhIuTcgoWbFdokmlAiR8iTMMffyM3s=;
	b=auWwnWWqwemJDClmHQUDI2ijfqHqLTZUwLrjmfaRx2ED3SSRK06r5YiMVNNjbXxuCeV7AD
	AiCo5MYnCOXSV1b91mwDqVNceyOat980FsJ4tEw5tBruknrP1HP+gg8P2yBaCr8zDlmPjb
	I2vYh8hojy7exvVNOP44NpA2Q+1jZvKEuwZY1r5MevLBaL/BcYIpmSWeJ/1nnYX7D+P3G/
	G+16724V8IlRWoltIJn+q8itQecwuXsEuOVScVUEGrtC/fzm8mQAzs2sNj+LehbNyUdgnq
	T0axVDG4xe0IyauqyHNRHmlLLunYxgRuAK5OuFCkqQrPtGGodYvGpl/YJfuQWg==
From: Simon Polack <spolack+git@mailbox.org>
To: andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: f.fainelli@gmail.com,
	javen_xu@realsil.com.cn,
	chad@monroe.io,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: phy: realtek: apply SerDes lane polarity on RTL8261C/D
Date: Mon, 21 Sep 2026 18:18:16 +0200
Message-ID: <20260921161817.565185-3-spolack+git@mailbox.org>
In-Reply-To: <20260921161817.565185-1-spolack+git@mailbox.org>
References: <20260921161817.565185-1-spolack+git@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8iz8wk7bq7cc5bhgtghys8c4kiitfy7c
X-MBO-RS-ID: 757fa17c40127964923

Boards such as the Gemtek W1700K (Airoha AN7581) route the USXGMII
lanes between the SoC and the PHY inverted and describe that in the
device tree with the generic tx-polarity/rx-polarity properties.
Nothing in the RTL8261C/D driver reads them and the Airoha PCS has no
polarity handling of its own, so the inversion is never programmed.
The copper side negotiates normally while the SerDes never trains and
the netdev stays NO-CARRIER.

Lane polarity on this part lives behind the same VEND1 SerDes command
window the RTL822x code already uses for in-band autoneg, in SerDes
registers 0x0000 (bits 9:8) and 0x00c2 (bits 14:13). The register at
VEND1 0xc1 that some other Realtek 10G PHYs use for the same purpose
is not implemented on this die and reads back as zero after a write.

Add a read side and a read-modify-write helper to the command window,
move rtl822x_serdes_write() up next to them so all three are visible
from the RTL8261 code, apply the polarity from config_init() and select
PHY_COMMON_PROPS for the property helpers. Only lanes actually described
in the firmware node are touched; a board without the properties keeps
whatever the boot loader and the PHY firmware left in place.

The bit assignment has been verified on an RTL8261CE (sub-model 0x00,
PHY ID 0x001cc899): on the W1700K, SerDes register 0x0000 goes from
0x1403 to 0x1703 and 0x00c2 from 0x0000 to 0x6000, after which VEND1
0x758d reports the SerDes linked (0x0010 -> 0x001e) and the link comes
up at 1G and 10G and passes traffic. The RTL8261C, RTL8261D and
RTL8261D_VM share rtl8261x_config_init() and get the same treatment,
but have not been tested with inverted lanes.

Assisted-by: LLM
Signed-off-by: Simon Polack <spolack+git@mailbox.org>
---
 drivers/net/phy/realtek/Kconfig        |   1 +
 drivers/net/phy/realtek/realtek_main.c | 174 +++++++++++++++++++++----
 2 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index a741b34d193e..a9272aebe26d 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config REALTEK_PHY
 	tristate "Realtek PHYs"
+	select PHY_COMMON_PROPS
 	select PHY_PACKAGE
 	help
 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 1e670638dd1c..04d397f0a2d8 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -13,9 +13,11 @@
 #include <linux/firmware.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/netdevice.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/string_choices.h>
@@ -164,6 +166,7 @@
 #define   RTL822X_VND1_SERDES_INBAND_DISABLE	0x71d0
 #define   RTL822X_VND1_SERDES_INBAND_ENABLE	0x70d0
 #define RTL822X_VND1_SERDES_DATA		0x7589
+#define RTL822X_VND1_SERDES_RDATA		0x758a
 
 #define RTL822X_VND2_TO_PAGE(reg)		((reg) >> 4)
 #define RTL822X_VND2_TO_PAGE_REG(reg)		(16 + (((reg) & GENMASK(3, 0)) >> 1))
@@ -271,6 +274,18 @@
 #define RTL8261X_INT_ALDPS_CHG		BIT(9)
 #define RTL8261X_INT_JABBER		BIT(10)
 
+/* SerDes lane polarity, behind the VEND1 SerDes command window. This is not
+ * the global inversion bit that other Realtek 10G PHYs use; the bit
+ * assignment below has only been verified on an RTL8261CE reporting PHY ID
+ * 0x001cc899.
+ */
+#define RTL8261X_SERDES_POL_REG0	0x0000
+#define  RTL8261X_SERDES_POL_REG0_TX	BIT(8)
+#define  RTL8261X_SERDES_POL_REG0_RX	BIT(9)
+#define RTL8261X_SERDES_POL_REGC2	0x00c2
+#define  RTL8261X_SERDES_POL_REGC2_TX	BIT(14)
+#define  RTL8261X_SERDES_POL_REGC2_RX	BIT(13)
+
 #define RTL8261X_INT_MASK_DEFAULT	(RTL8261X_INT_AUTONEG_DONE | \
 					 RTL8261X_INT_LINK_CHG | \
 					 RTL8261X_INT_AUTONEG_ERROR | \
@@ -708,18 +723,147 @@ static int rtl8261x_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_serdes_wait(struct phy_device *phydev)
+{
+	int poll;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					 RTL822X_VND1_SERDES_CMD, poll,
+					 !(poll & RTL822X_VND1_SERDES_CMD_BUSY),
+					 500, 100000, false);
+}
+
+static int rtl822x_serdes_read(struct phy_device *phydev, u16 reg)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CMD,
+			    RTL822X_VND1_SERDES_CMD_BUSY);
+	if (ret < 0)
+		return ret;
+
+	ret = rtl822x_serdes_wait(phydev);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_RDATA);
+}
+
+static int rtl822x_serdes_write(struct phy_device *phydev, u16 reg, u16 val)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_DATA, val);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CMD,
+			    RTL822X_VND1_SERDES_CMD_WRITE |
+			    RTL822X_VND1_SERDES_CMD_BUSY);
+	if (ret < 0)
+		return ret;
+
+	return rtl822x_serdes_wait(phydev);
+}
+
+static int rtl822x_serdes_modify(struct phy_device *phydev, u16 reg,
+				 u16 mask, u16 set)
+{
+	int val;
+
+	val = rtl822x_serdes_read(phydev, reg);
+	if (val < 0)
+		return val;
+
+	if ((val & mask) == set)
+		return 0;
+
+	return rtl822x_serdes_write(phydev, reg, (val & ~mask) | set);
+}
+
+/* The host-side SerDes lanes are only inverted when the board says so.
+ * Lanes the firmware node does not describe are left as the boot loader
+ * and PHY firmware left them.
+ */
+static int rtl8261x_config_serdes_polarity(struct phy_device *phydev)
+{
+	bool tx_present, rx_present, tx_invert = false, rx_invert = false;
+	u16 reg0_mask = 0, reg0_set = 0, regc2_mask = 0, regc2_set = 0;
+	struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
+	const char *mode = phy_modes(phydev->interface);
+	unsigned int pol;
+	int ret;
+
+	tx_present = fwnode_property_present(fwnode, "tx-polarity");
+	rx_present = fwnode_property_present(fwnode, "rx-polarity");
+	if (!tx_present && !rx_present)
+		return 0;
+
+	if (tx_present) {
+		ret = phy_get_manual_tx_polarity(fwnode, mode, &pol);
+		if (ret)
+			return ret;
+		tx_invert = pol == PHY_POL_INVERT;
+	}
+
+	if (rx_present) {
+		ret = phy_get_manual_rx_polarity(fwnode, mode, &pol);
+		if (ret)
+			return ret;
+		rx_invert = pol == PHY_POL_INVERT;
+	}
+
+	if (tx_present) {
+		reg0_mask |= RTL8261X_SERDES_POL_REG0_TX;
+		regc2_mask |= RTL8261X_SERDES_POL_REGC2_TX;
+		if (tx_invert) {
+			reg0_set |= RTL8261X_SERDES_POL_REG0_TX;
+			regc2_set |= RTL8261X_SERDES_POL_REGC2_TX;
+		}
+	}
+
+	if (rx_present) {
+		reg0_mask |= RTL8261X_SERDES_POL_REG0_RX;
+		regc2_mask |= RTL8261X_SERDES_POL_REGC2_RX;
+		if (rx_invert) {
+			reg0_set |= RTL8261X_SERDES_POL_REG0_RX;
+			regc2_set |= RTL8261X_SERDES_POL_REGC2_RX;
+		}
+	}
+
+	ret = rtl822x_serdes_modify(phydev, RTL8261X_SERDES_POL_REG0,
+				    reg0_mask, reg0_set);
+	if (ret < 0)
+		return ret;
+
+	return rtl822x_serdes_modify(phydev, RTL8261X_SERDES_POL_REGC2,
+				     regc2_mask, regc2_set);
+}
+
 static int rtl8261x_config_init(struct phy_device *phydev)
 {
 	struct rtl8261x_priv *priv = phydev->priv;
+	int ret;
 
 	/* The firmware parameters are preserved across IEEE soft resets and
 	 * suspend/resume cycles. Reloading is only necessary after a power
 	 * cycle or hard reset.
 	 */
-	if (priv->fw_name && !priv->fw_loaded)
-		return rtl8261x_fw_load(phydev);
+	if (priv->fw_name && !priv->fw_loaded) {
+		ret = rtl8261x_fw_load(phydev);
+		if (ret)
+			return ret;
+	}
 
-	return 0;
+	return rtl8261x_config_serdes_polarity(phydev);
 }
 
 static int rtl821x_probe(struct phy_device *phydev)
@@ -2120,30 +2264,6 @@ static int rtl822xb_config_init(struct phy_device *phydev)
 	return rtl822x_set_serdes_option_mode(phydev, false);
 }
 
-static int rtl822x_serdes_write(struct phy_device *phydev, u16 reg, u16 val)
-{
-	int ret, poll;
-
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_ADDR, reg);
-	if (ret < 0)
-		return ret;
-
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_DATA, val);
-	if (ret < 0)
-		return ret;
-
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CMD,
-			    RTL822X_VND1_SERDES_CMD_WRITE |
-			    RTL822X_VND1_SERDES_CMD_BUSY);
-	if (ret < 0)
-		return ret;
-
-	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-					 RTL822X_VND1_SERDES_CMD, poll,
-					 !(poll & RTL822X_VND1_SERDES_CMD_BUSY),
-					 500, 100000, false);
-}
-
 static int rtl822x_config_inband(struct phy_device *phydev, unsigned int modes)
 {
 	return rtl822x_serdes_write(phydev, RTL822X_VND1_SERDES_ADDR_AUTONEG,
-- 
2.55.0

