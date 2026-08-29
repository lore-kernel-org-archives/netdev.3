Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE1351C25
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981168; cv=none; b=kQVOsC3MdgqcG4fpyoOBSAgxHzE/1wsV1Snj9A8w9QnNtOw/EwE90qq4huyj//f1t8ZSvZq2qvP34vXupDNeGUlyITj6Qv5YqHMqeYfKYk34U4CufwVpSTHDfb0lt/gznmcU4+7k9xMLy5cObvprm/J7oEkJ/z16bd0lU3ZsvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981168; c=relaxed/simple;
	bh=aU6OBctWVrxG6oUxcSf2OUD2H5tHnXcJD6peUrom9T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5sIjE4OCe5pGqeGcUHzeCvnXPj/SkTmqYPUpZDMYhs37r0MhCEN9cgcTu41AD/k+yUF2/0sNY2pbZH6OzOi7XsSKACmCxmacD64YmIF86w5L90KNqu+xYE4bqTY3fObcocPNJ7V+ikypGKesOHFCAf59Pn0Kv7Sq0XExnAAtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=dDpPgqKj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="dDpPgqKj"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2533d83e3bso277980566b.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 22:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787981161; x=1788585961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ED1uJMv0jD5umM27V202Xvgcpype9EI8mqeysrKe4Ak=;
        b=dDpPgqKjMgBhYCQBJqaPnoKyv6Nu0Ge7NSvLHTdxQdPeK+dHUVaLLuwjzmr2b38DYo
         Lp9kPXcZ018ZaN/9CI1cWO2EY6qMtbBX6Ck23vsNoysat0kzG1lM84pzBHxRPjxSG0GP
         xuVd+GPNV0ZSg9p5MGatqS9p9yxQNAm46KUdtOhyxZ2typyG1Ot7FxxQcPFltVgi93jf
         boqcjdJ2xRLQ1jVlnfIVOotcwVjmmAcSfe9R+wfT7A5YjmtdIcIYv5tgNkDqFcOuSyNR
         3D1z+4dx4D3loY3ieYjyy9/gwF7S8mn8IJGzjfD6y3OVE5GYbYiwRAAZK1mW98Ci+jwR
         xbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787981161; x=1788585961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ED1uJMv0jD5umM27V202Xvgcpype9EI8mqeysrKe4Ak=;
        b=CT7MQZEuxwlnGfFaYchrv9r/TYFz55VZ1e3bCEpOwhk2oUTOQzhMP7wvjmAsKI9kPO
         i58bKpwjpieP7UrgMCTog6C/ulkqN1uBoL8u0CjBB03gQ2FQu7Iq4uBxzNncj9xuqtnG
         OWVfwYKPwObSbxH2QqiGfts0O0ReADAtI9CCew290Q/eacTHYfFi3u18f+tu6Nrm3PFn
         W2abV9MaR3rXh05bH4l/lonffw06zvbcSePtajmwZBzW+caY8hgVa/HcdD/DjHCu1gcg
         QD2bT2gu92T3LnY60UkTN4zt7BWwHtiXn7vPWpa8D4kxaRUzxLW/y+M/qZM9vlMhlov9
         Aw5A==
X-Gm-Message-State: AFuF++k4bqAObMQvltePu70qniRC2bWMMLQbNl82gQ0q9ApKKjFz5nsX
	KrGkVhyipVEy7anBbHA6DkVTfrccow3AfGLDqKNNZRTq9TKYE+NRRYjM1KUETNf5xSOPoGoIVeW
	G8xoUYeFCqg==
X-Gm-Gg: AR+sD11t+IvTd7bYGVmPpV4GQ4o9aqZ+Fm6UnPT7cwtmJu72dEDBK+HSCUT3qle1dAx
	qhRy1NF8k59yImjEkL6frnsk+lLCnn3Q9xB31qz6OB44rEx0quPVnQRVYbPCQkN6TUruSfX+t3C
	mp9beDgP5BWC5dRoo4EzNt09EkvHz1knTicYdLxzvQvMtSW9fo5Cbyl827cjv6M3cu1qwxrBNTe
	GOxbsVsG7aF0ucckHsxKLLXP7IYYIIRktnGDNQkJa59wP/p+1eU2ApZHkBgoF6g6L6L72X4FMkJ
	VrYVOPRU2IOPl6pzmSv5OLfVO4qFuKD2QHSrqxYcv9do+hmzERfWvmCPBenUcugAl4klGckVpnt
	WuetLexaY39w1+Fda3xP84nYCmciGA+MekK6Pn3+2rnnkg3PVh4Rcbd0+pxqA/jfs0Ka7J74x6P
	ynOXvUm5hkw/QR+zOBeVbX5pF6kI3X+HjFa232UfInBw==
X-Received: by 2002:a17:907:9810:b0:c25:5114:c832 with SMTP id a640c23a62f3a-c2556bd290bmr844588666b.3.1787981160890;
        Fri, 28 Aug 2026 22:26:00 -0700 (PDT)
Received: from remote-01 ([45.85.105.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee75a36sm163750666b.28.2026.08.28.22.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 22:26:00 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next 4/9] net: phy: air: move the EN8811H firmware download into the library
Date: Sat, 29 Aug 2026 05:25:41 +0000
Message-ID: <20260829052546.1152446-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829052546.1152446-1-f@lex.la>
References: <20260829052546.1152446-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EN8811H firmware loader is welded to the PHY driver, but the next
patch adds an MDIO device driver that must perform the same download
before any phy_device exists.

Move the download engine into the shared library, typed on the bus
and address like the buckpbus core: the paged transfer, the FW_CTRL
sequencing, the MCU-ready wait and the version readout. The bus-level
helpers take the MDIO bus lock themselves and save and restore the
page register directly, since phy_select_page() needs a phy_device.
The MMD status poll goes through mmd_phy_read(), which already
handles both C22 indirection and C45.

The PHY driver keeps thin wrappers with its old behavior, including
the AN8811HB path, which retains its own CRC-checked loader and only
shares the paged buffer write.

No functional change.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/air_en8811h.c | 143 +-----------------
 drivers/net/phy/air_phy_lib.c | 268 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h |  26 ++++
 3 files changed, 302 insertions(+), 135 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index edd49c193e47..fdc64362a565 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -20,21 +20,15 @@
 #include <linux/bitfield.h>
 #include <linux/property.h>
 #include <linux/wordpart.h>
-#include <linux/unaligned.h>
 
 #include "air_phy_lib.h"
 
 #define EN8811H_PHY_ID		0x03a2a411
 #define AN8811HB_PHY_ID		0xc0ff04a0
 
-#define EN8811H_MD32_DM		"airoha/EthMD32.dm.bin"
-#define EN8811H_MD32_DSP	"airoha/EthMD32.DSP.bin"
 #define AN8811HB_MD32_DM	"airoha/an8811hb/EthMD32_CRC.DM.bin"
 #define AN8811HB_MD32_DSP	"airoha/an8811hb/EthMD32_CRC.DSP.bin"
 
-#define AIR_FW_ADDR_DM	0x00000000
-#define AIR_FW_ADDR_DSP	0x00100000
-
 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
 #define   AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
@@ -44,8 +38,6 @@
 #define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
 
 /* Registers on MDIO_MMD_VEND1 */
-#define EN8811H_PHY_FW_STATUS		0x8009
-#define   EN8811H_PHY_READY			0x02
 
 #define AIR_PHY_MCU_CMD_0		0x800b
 #define AIR_PHY_MCU_CMD_1		0x800c
@@ -108,8 +100,6 @@
 #define EN8811H_2P5G_LPA		0x3b30
 #define   EN8811H_2P5G_LPA_2P5G			BIT(0)
 
-#define EN8811H_FW_VERSION		0x3b3c
-
 #define EN8811H_POLARITY		0xca0f8
 #define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
 #define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
@@ -122,12 +112,6 @@
 #define EN8811H_CLK_CGM			0xcf958
 #define   EN8811H_CLK_CGM_CKO			BIT(26)
 
-#define EN8811H_FW_CTRL_1		0x0f0018
-#define   EN8811H_FW_CTRL_1_START		0x0
-#define   EN8811H_FW_CTRL_1_FINISH		0x1
-#define EN8811H_FW_CTRL_2		0x800000
-#define EN8811H_FW_CTRL_2_LOADING		BIT(11)
-
 #define AN8811HB_CRC_PM_SET1		0xf020c
 #define AN8811HB_CRC_PM_MON2		0xf0218
 #define AN8811HB_CRC_PM_MON3		0xf021c
@@ -270,80 +254,10 @@ static int __air_pbus_reg_write(struct mdio_device *mdiodev,
 			       upper_16_bits(pbus_data));
 }
 
-static int __air_write_buf(struct phy_device *phydev, u32 address,
-			   const struct firmware *fw)
-{
-	unsigned int offset;
-	int ret;
-	u16 val;
-
-	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_INCR);
-	if (ret < 0)
-		return ret;
-
-	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH,
-			  upper_16_bits(address));
-	if (ret < 0)
-		return ret;
-
-	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,
-			  lower_16_bits(address));
-	if (ret < 0)
-		return ret;
-
-	for (offset = 0; offset < fw->size; offset += 4) {
-		val = get_unaligned_le16(&fw->data[offset + 2]);
-		ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH, val);
-		if (ret < 0)
-			return ret;
-
-		val = get_unaligned_le16(&fw->data[offset]);
-		ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW, val);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int air_write_buf(struct phy_device *phydev, u32 address,
-			 const struct firmware *fw)
-{
-	int saved_page;
-	int ret = 0;
-
-	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-
-	if (saved_page >= 0) {
-		ret = __air_write_buf(phydev, address, fw);
-		if (ret < 0)
-			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
-				   address, ret);
-	}
-
-	return phy_restore_page(phydev, saved_page, ret);
-}
-
 static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 {
-	int ret, reg_value;
-
-	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-					 EN8811H_FW_CTRL_1_FINISH);
-	if (ret)
-		return ret;
-
-	/* Because of mdio-lock, may have to wait for multiple loads */
-	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-					EN8811H_PHY_FW_STATUS, reg_value,
-					reg_value == EN8811H_PHY_READY,
-					20000, 7500000, true);
-	if (ret) {
-		phydev_err(phydev, "MCU not ready: 0x%x\n", reg_value);
-		return -ENODEV;
-	}
-
-	return 0;
+	return air_en8811h_wait_mcu_ready(phydev->mdio.bus, phydev->mdio.addr,
+					  phydev->is_c45, &phydev->mdio.dev);
 }
 
 static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
@@ -405,7 +319,8 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = air_write_buf(phydev, address,  fw);
+	ret = air_fw_write_buf(phydev->mdio.bus, phydev->mdio.addr, address,
+			       fw);
 	release_firmware(fw);
 	return ret;
 }
@@ -501,54 +416,12 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 
 static int en8811h_load_firmware(struct phy_device *phydev)
 {
-	struct device *dev = &phydev->mdio.dev;
-	const struct firmware *fw1, *fw2;
+	struct en8811h_priv *priv = phydev->priv;
 	int ret;
 
-	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
-	if (ret < 0)
-		return ret;
-
-	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
-	if (ret < 0)
-		goto en8811h_load_firmware_rel1;
-
-	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-					 EN8811H_FW_CTRL_1_START);
-	if (ret < 0)
-		goto en8811h_load_firmware_out;
-
-	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-					  EN8811H_FW_CTRL_2_LOADING,
-					  EN8811H_FW_CTRL_2_LOADING);
-	if (ret < 0)
-		goto en8811h_load_firmware_out;
-
-	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
-	if (ret < 0)
-		goto en8811h_load_firmware_out;
-
-	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, fw2);
-	if (ret < 0)
-		goto en8811h_load_firmware_out;
-
-	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-					  EN8811H_FW_CTRL_2_LOADING, 0);
-	if (ret < 0)
-		goto en8811h_load_firmware_out;
-
-	ret = en8811h_wait_mcu_ready(phydev);
-	if (ret < 0)
-		goto en8811h_load_firmware_out;
-
-	en8811h_print_fw_version(phydev);
-
-en8811h_load_firmware_out:
-	release_firmware(fw2);
-
-en8811h_load_firmware_rel1:
-	release_firmware(fw1);
-
+	ret = air_en8811h_fw_download(phydev->mdio.bus, phydev->mdio.addr,
+				      phydev->is_c45, &phydev->mdio.dev,
+				      &priv->firmware_version);
 	if (ret < 0)
 		phydev_err(phydev, "Load firmware failed: %d\n", ret);
 
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index e0fca5f285d2..1ed5c69d7073 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -8,11 +8,16 @@
  */
 
 #include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/iopoll.h>
+#include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/unaligned.h>
 #include <linux/wordpart.h>
 
 #include "air_phy_lib.h"
+#include "phylib.h"
 
 static int __air_buckpbus_reg_read(struct mii_bus *bus, int addr,
 				   u32 pbus_address, u32 *pbus_data)
@@ -201,6 +206,269 @@ int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 }
 EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_modify);
 
+static int __air_write_buf(struct mii_bus *bus, int addr, u32 address,
+			   const struct firmware *fw)
+{
+	unsigned int offset;
+	int ret;
+	u16 val;
+
+	ret = __mdiobus_write(bus, addr, AIR_BPBUS_MODE,
+			      AIR_BPBUS_MODE_ADDR_INCR);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, addr, AIR_BPBUS_WR_ADDR_HIGH,
+			      upper_16_bits(address));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, addr, AIR_BPBUS_WR_ADDR_LOW,
+			      lower_16_bits(address));
+	if (ret < 0)
+		return ret;
+
+	for (offset = 0; offset < fw->size; offset += 4) {
+		val = get_unaligned_le16(&fw->data[offset + 2]);
+		ret = __mdiobus_write(bus, addr, AIR_BPBUS_WR_DATA_HIGH, val);
+		if (ret < 0)
+			return ret;
+
+		val = get_unaligned_le16(&fw->data[offset]);
+		ret = __mdiobus_write(bus, addr, AIR_BPBUS_WR_DATA_LOW, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* The phy_select_page() path is not usable here: these run before any
+ * phy_device exists. Callers hold the bus lock across select/op/restore.
+ */
+static int air_mdio_select_page(struct mii_bus *bus, int addr, int page)
+{
+	int saved_page, ret;
+
+	saved_page = __mdiobus_read(bus, addr, AIR_EXT_PAGE_ACCESS);
+	if (saved_page < 0)
+		return saved_page;
+
+	if (saved_page != page) {
+		ret = __mdiobus_write(bus, addr, AIR_EXT_PAGE_ACCESS, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	return saved_page;
+}
+
+static int air_mdio_restore_page(struct mii_bus *bus, int addr,
+				 int saved_page, int page, int ret)
+{
+	int restore;
+
+	if (saved_page != page) {
+		restore = __mdiobus_write(bus, addr, AIR_EXT_PAGE_ACCESS,
+					  saved_page);
+		if (ret >= 0 && restore < 0)
+			ret = restore;
+	}
+
+	return ret;
+}
+
+int air_fw_write_buf(struct mii_bus *bus, int addr, u32 address,
+		     const struct firmware *fw)
+{
+	int saved_page, ret;
+
+	mutex_lock(&bus->mdio_lock);
+
+	saved_page = air_mdio_select_page(bus, addr, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_write_buf(bus, addr, address, fw);
+		ret = air_mdio_restore_page(bus, addr, saved_page,
+					    AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(air_fw_write_buf);
+
+static int air_mdio_buckpbus_reg_read(struct mii_bus *bus, int addr,
+				      u32 pbus_address, u32 *pbus_data)
+{
+	int saved_page, ret;
+
+	mutex_lock(&bus->mdio_lock);
+
+	saved_page = air_mdio_select_page(bus, addr, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_buckpbus_reg_read(bus, addr, pbus_address,
+					      pbus_data);
+		ret = air_mdio_restore_page(bus, addr, saved_page,
+					    AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+
+static int air_mdio_buckpbus_reg_write(struct mii_bus *bus, int addr,
+				       u32 pbus_address, u32 pbus_data)
+{
+	int saved_page, ret;
+
+	mutex_lock(&bus->mdio_lock);
+
+	saved_page = air_mdio_select_page(bus, addr, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_buckpbus_reg_write(bus, addr, pbus_address,
+					       pbus_data);
+		ret = air_mdio_restore_page(bus, addr, saved_page,
+					    AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+
+static int air_mdio_buckpbus_reg_modify(struct mii_bus *bus, int addr,
+					u32 pbus_address, u32 mask, u32 set)
+{
+	int saved_page, ret;
+
+	mutex_lock(&bus->mdio_lock);
+
+	saved_page = air_mdio_select_page(bus, addr, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_buckpbus_reg_modify(bus, addr, pbus_address,
+						mask, set);
+		ret = air_mdio_restore_page(bus, addr, saved_page,
+					    AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+
+static int air_mmd_status_read(struct mii_bus *bus, int addr, bool is_c45)
+{
+	int ret;
+
+	mutex_lock(&bus->mdio_lock);
+	ret = mmd_phy_read(bus, addr, is_c45, MDIO_MMD_VEND1,
+			   EN8811H_PHY_FW_STATUS);
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret;
+}
+
+int air_en8811h_wait_mcu_ready(struct mii_bus *bus, int addr, bool is_c45,
+			       struct device *dev)
+{
+	int ret, reg_value;
+
+	ret = air_mdio_buckpbus_reg_write(bus, addr, EN8811H_FW_CTRL_1,
+					  EN8811H_FW_CTRL_1_FINISH);
+	if (ret)
+		return ret;
+
+	/* Because of mdio-lock, may have to wait for multiple loads. A read
+	 * error ends the poll at once, like phy_read_mmd_poll_timeout()
+	 * would: the bus is not going to heal within the timeout.
+	 */
+	ret = read_poll_timeout(air_mmd_status_read, reg_value,
+				reg_value < 0 ||
+				reg_value == EN8811H_PHY_READY,
+				20000, 7500000, true, bus, addr, is_c45);
+	if (reg_value < 0)
+		return reg_value;
+	if (ret) {
+		dev_err(dev, "MCU not ready: 0x%x\n", reg_value);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(air_en8811h_wait_mcu_ready);
+
+int air_en8811h_fw_download(struct mii_bus *bus, int addr, bool is_c45,
+			    struct device *dev, u32 *fw_version)
+{
+	const struct firmware *fw1, *fw2;
+	int ret;
+
+	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
+	if (ret < 0)
+		return ret;
+
+	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
+	if (ret < 0)
+		goto air_fw_download_rel1;
+
+	ret = air_mdio_buckpbus_reg_write(bus, addr, EN8811H_FW_CTRL_1,
+					  EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_mdio_buckpbus_reg_modify(bus, addr, EN8811H_FW_CTRL_2,
+					   EN8811H_FW_CTRL_2_LOADING,
+					   EN8811H_FW_CTRL_2_LOADING);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_fw_write_buf(bus, addr, AIR_FW_ADDR_DM, fw1);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_fw_write_buf(bus, addr, AIR_FW_ADDR_DSP, fw2);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_mdio_buckpbus_reg_modify(bus, addr, EN8811H_FW_CTRL_2,
+					   EN8811H_FW_CTRL_2_LOADING, 0);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_en8811h_wait_mcu_ready(bus, addr, is_c45, dev);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_mdio_buckpbus_reg_read(bus, addr, EN8811H_FW_VERSION,
+					 fw_version);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	dev_info(dev, "MD32 firmware version: %08x\n", *fw_version);
+
+air_fw_download_out:
+	release_firmware(fw2);
+
+air_fw_download_rel1:
+	release_firmware(fw1);
+
+	/* No error print here: the callers retry or log on their own terms,
+	 * and a poller retrying a half-installed firmware package would turn
+	 * a print at this level into a permanent drumbeat.
+	 */
+	return ret;
+}
+EXPORT_SYMBOL_GPL(air_en8811h_fw_download);
+
+MODULE_FIRMWARE(EN8811H_MD32_DM);
+MODULE_FIRMWARE(EN8811H_MD32_DSP);
+
 int air_phy_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 01bb32e7c7c9..6b11dbeaea9b 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -29,6 +29,23 @@
 #define AIR_BPBUS_RD_DATA_HIGH		0x17
 #define AIR_BPBUS_RD_DATA_LOW		0x18
 
+#define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
+#define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
+
+#define AIR_FW_ADDR_DM			0x00000000
+#define AIR_FW_ADDR_DSP			0x00100000
+
+#define EN8811H_FW_CTRL_1		0x0f0018
+#define   EN8811H_FW_CTRL_1_START		0x0
+#define   EN8811H_FW_CTRL_1_FINISH		0x1
+#define EN8811H_FW_CTRL_2		0x800000
+#define   EN8811H_FW_CTRL_2_LOADING		BIT(11)
+
+#define EN8811H_PHY_FW_STATUS		0x8009
+#define   EN8811H_PHY_READY			0x02
+
+#define EN8811H_FW_VERSION		0x3b3c
+
 int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 				u32 mask, u32 set);
 int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
@@ -38,4 +55,13 @@ int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 int air_phy_read_page(struct phy_device *phydev);
 int air_phy_write_page(struct phy_device *phydev, int page);
 
+struct firmware;
+
+int air_fw_write_buf(struct mii_bus *bus, int addr, u32 address,
+		     const struct firmware *fw);
+int air_en8811h_wait_mcu_ready(struct mii_bus *bus, int addr, bool is_c45,
+			       struct device *dev);
+int air_en8811h_fw_download(struct mii_bus *bus, int addr, bool is_c45,
+			    struct device *dev, u32 *fw_version);
+
 #endif /* __AIR_PHY_LIB_H */
-- 
2.53.0

