Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB244A43E9
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548603; cv=none; b=JYH5Y4p38LztP0nrVtW9g0qdZnY3BLNuq3eqDI7zvglq6J2fP7dwD9hXyWzMr63NsST+gcdnJPf+rkn1EjnWo5I3RmQcjq1rwPvYI70NGmV3i9v0g48CBvdD91fAu7KDDlsAUSh24DrtNQ5BQOELwpB2Qdw+ny7JJvQdxJWWzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548603; c=relaxed/simple;
	bh=hlST2y/Nrws+rZfEBBvC+1GEYroutzXg2Z4/JIwBoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ0X5jTH68vegTFb2nzPEY+FuY3h/NElnMC8AXK1jfXehMJYTszKVOE9KXtFYHRqT6VvEmvlI/857t+vlfHH5QjvRW8PDwiSLpLGsBc1FkIZqAc3lJ1ya3JEPkHAocf/NK1kRiFJu5tdOvFpWhdrl5/6F8pEk4uYONtoEeaNXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=klbb0LW/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="klbb0LW/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so12819305e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548593; x=1789153393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+bsWXVk/02X1VVug4FP/+rrzX5a4PtjmYQgHwQj6uE=;
        b=klbb0LW/zmJgqtFYLCCHm4Xp6bDS04sv5Mpah7yueiRpPg4hoCZKfH1mplUYsiiXuz
         IRS8/SY828vauy7Sd4x30WhpUNY1xuw5TV8Jd3wn9fcjsyDQTbsheJoG52vuycpYS/z+
         x3xObYiV+EGbQuDTDZ7zeeBMubzA7LZIAMXiWRIcZsEqP2dv4R3L/ftaUEtgaCpVbYTR
         VODQai0XJgo4UDLPQN6GqCnVfQ/dQeQkQe/XszVkyHmUv1+NHmX7SvKfCy66vqzZpNC0
         XkCv/EaefF5rqKEsfzc2yRfVmSN49y+uHfEsOf1/e3ZgnvYvyDlN/DRQIwnTmRkm5eiT
         Bk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548593; x=1789153393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j+bsWXVk/02X1VVug4FP/+rrzX5a4PtjmYQgHwQj6uE=;
        b=ZnayOPAIGF1LqnY1OI8vx3TWyPwB2BzNGmcz1a2LjbLbTQWRFw7fW27RjgX8DLJ7Gb
         RMRDqxuYAAGv8X8d4S+U+GazRCuQsUm6NJqOZ4/zIhE/rMdvVqityCYuld52mqfQriz+
         nrAUVPoPU8YavL14hUmcPLmY9ABT7Q1/1aU1njuzYTnkNcduikgERPIpp+Uu8fjvAdxB
         kZOrqO5rCGYD2IUbv3Sy86SrvDr8WYKmvRr/BeYU63iXGf8OEoU+zv1DMbb8SlXDSNVs
         itqMLIXiwig7gjZZr1TpKZKZ/yZx0P8x8UEdU6GeAiDi/9FjBaUchewpxNib+1DNfi5N
         xrgw==
X-Forwarded-Encrypted: i=1; AKwUvBwkANTgC1Q9YaJ2AidlPSnbs22nAsKmDbMjpsnLROh0oVNXed1ZQeY5hO8rtmD3pOW2JIpfix0=@vger.kernel.org
X-Gm-Message-State: AFuF++mk6yePnX7Yygm9GzwbHsFKUhhUfszNNtg6iYZI1b2flxFOg8PG
	qfJhI3gOmSR8+7+k33kPFE2O+VPxj6JNH9/gj5f/8lZqC7VmQVdU2lNKsvajFgcjcjs=
X-Gm-Gg: AYBFou1ox7pPhMKGdFagkiYROfe8VLInfgT5GQJQfsQvS0x7gzb1mA7A97Kg5eQZBYr
	WdDTguHakRtvAfTSdBQLE/+QBxTE7/g1PpbnLGwoEvBXQV+3L6tLYCra5bh9a+tWlu60+Hhpwuz
	RXoEvIdyLru3WP7VhfCrfHjGVqhCTsnYZz8sb3lOwH2HQWGKPxsd3uqicVIKAmog1cJczPCZlRZ
	1CgPOuLyt7wC6o6+ufyeC8Or4Mt9xvBZHPny4WPH80gqu9aH5jTE6Uwi3CJqNvpklgPev8pEiu3
	F2zKECLAWUDm1G/Mgnz4U9ar/B2Suc6l+9Bgj+GFdUkdhlcVudd1POE2aOyEV3QW3FWUXSrMRGu
	vk5pm6hX7QCCFaUab8af0jMvlHnaZ5QKj5NJFepwBCiRVMZNMOKGeOqi5SoapSIBvVE3JxpWogj
	OkB19JJmt6Y/wPs6uQ+aN7z+wzk+2VyUGjglmbKRI=
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:e73e with SMTP id 5b1f17b1804b1-49cfa21e935mr64950255e9.20.1788548593446;
        Fri, 04 Sep 2026 12:03:13 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:13 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 05/10] net: phy: air: move the EN8811H firmware download into the library
Date: Fri,  4 Sep 2026 19:02:59 +0000
Message-ID: <f648710eaee17afd4d250ff0da46135db4b33971.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
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

Move the download engine into the shared library, typed on the MDIO
device like the buckpbus core. The moved helpers take the bus lock and
save and restore the page register themselves, since phy_select_page()
needs a phy_device.

The status poll now asks for the MMD register through the Clause 22
indirection unconditionally. phy_read_mmd() used to resolve that from
phydev->is_c45, which is false for every device tree describing the
Clause 22 PHYs this library serves, so hardcoding it changes nothing
any board runs today.

The version read at the end is now checked. en8811h_print_fw_version()
threw its result away, so a bus error there left the version at zero
and let probe continue; the load fails instead.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/air_en8811h.c | 139 +-----------------
 drivers/net/phy/air_phy_lib.c | 260 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h |  24 ++++
 3 files changed, 288 insertions(+), 135 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 38eb18f0e9bb..2f6ed30ba24d 100644
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
@@ -270,80 +254,9 @@ static int __air_pbus_reg_write(struct mdio_device *mdiodev,
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
+	return air_en8811h_wait_mcu_ready(&phydev->mdio);
 }
 
 static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
@@ -405,7 +318,7 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = air_write_buf(phydev, address,  fw);
+	ret = air_fw_write_buf(&phydev->mdio, address, fw);
 	release_firmware(fw);
 	return ret;
 }
@@ -501,54 +414,10 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 
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
+	ret = air_en8811h_fw_download(&phydev->mdio, &priv->firmware_version);
 	if (ret < 0)
 		phydev_err(phydev, "Load firmware failed: %d\n", ret);
 
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index e314717843ae..2f3e5b71abac 100644
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
 
 static int __air_buckpbus_reg_read(struct mdio_device *mdiodev,
 				   u32 pbus_address, u32 *pbus_data)
@@ -198,6 +203,261 @@ int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 }
 EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_modify);
 
+static int __air_write_buf(struct mdio_device *mdiodev, u32 address,
+			   const struct firmware *fw)
+{
+	unsigned int offset;
+	int ret;
+	u16 val;
+
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_MODE,
+			      AIR_BPBUS_MODE_ADDR_INCR);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_ADDR_HIGH,
+			      upper_16_bits(address));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_ADDR_LOW,
+			      lower_16_bits(address));
+	if (ret < 0)
+		return ret;
+
+	for (offset = 0; offset < fw->size; offset += 4) {
+		val = get_unaligned_le16(&fw->data[offset + 2]);
+		ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_HIGH, val);
+		if (ret < 0)
+			return ret;
+
+		val = get_unaligned_le16(&fw->data[offset]);
+		ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_LOW, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* phy_select_page() needs a phy_device, which does not exist yet. */
+static int __air_mdio_select_page(struct mdio_device *mdiodev, int page)
+{
+	int saved_page, ret;
+
+	saved_page = __mdiodev_read(mdiodev, AIR_EXT_PAGE_ACCESS);
+	if (saved_page < 0)
+		return saved_page;
+
+	if (saved_page != page) {
+		ret = __mdiodev_write(mdiodev, AIR_EXT_PAGE_ACCESS, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	return saved_page;
+}
+
+static int __air_mdio_restore_page(struct mdio_device *mdiodev,
+				   int saved_page, int page, int ret)
+{
+	int restore;
+
+	if (saved_page != page) {
+		restore = __mdiodev_write(mdiodev, AIR_EXT_PAGE_ACCESS,
+					  saved_page);
+		if (ret >= 0 && restore < 0)
+			ret = restore;
+	}
+
+	return ret;
+}
+
+int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
+		     const struct firmware *fw)
+{
+	int saved_page, ret;
+
+	mdiodev_lock(mdiodev);
+
+	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_write_buf(mdiodev, address, fw);
+		ret = __air_mdio_restore_page(mdiodev, saved_page,
+					      AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mdiodev_unlock(mdiodev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(air_fw_write_buf);
+
+static int air_mdio_buckpbus_reg_read(struct mdio_device *mdiodev,
+				      u32 pbus_address, u32 *pbus_data)
+{
+	int saved_page, ret;
+
+	mdiodev_lock(mdiodev);
+
+	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_buckpbus_reg_read(mdiodev, pbus_address, pbus_data);
+		ret = __air_mdio_restore_page(mdiodev, saved_page,
+					      AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mdiodev_unlock(mdiodev);
+	return ret;
+}
+
+static int air_mdio_buckpbus_reg_write(struct mdio_device *mdiodev,
+				       u32 pbus_address, u32 pbus_data)
+{
+	int saved_page, ret;
+
+	mdiodev_lock(mdiodev);
+
+	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_buckpbus_reg_write(mdiodev, pbus_address,
+					       pbus_data);
+		ret = __air_mdio_restore_page(mdiodev, saved_page,
+					      AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mdiodev_unlock(mdiodev);
+	return ret;
+}
+
+static int air_mdio_buckpbus_reg_modify(struct mdio_device *mdiodev,
+					u32 pbus_address, u32 mask, u32 set)
+{
+	int saved_page, ret;
+
+	mdiodev_lock(mdiodev);
+
+	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0) {
+		ret = saved_page;
+	} else {
+		ret = __air_buckpbus_reg_modify(mdiodev, pbus_address,
+						mask, set);
+		ret = __air_mdio_restore_page(mdiodev, saved_page,
+					      AIR_PHY_PAGE_EXTENDED_4, ret);
+	}
+
+	mdiodev_unlock(mdiodev);
+	return ret;
+}
+
+static int air_mmd_status_read(struct mdio_device *mdiodev)
+{
+	int ret;
+
+	mdiodev_lock(mdiodev);
+	ret = mmd_phy_read(mdiodev->bus, mdiodev->addr, false,
+			   MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS);
+	mdiodev_unlock(mdiodev);
+
+	return ret;
+}
+
+int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
+{
+	int ret, reg_value;
+
+	ret = air_mdio_buckpbus_reg_write(mdiodev, EN8811H_FW_CTRL_1,
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
+				20000, 7500000, true, mdiodev);
+	if (reg_value < 0)
+		return reg_value;
+	if (ret) {
+		dev_err(&mdiodev->dev, "MCU not ready: 0x%x\n", reg_value);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(air_en8811h_wait_mcu_ready);
+
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
+{
+	const struct firmware *fw1, *fw2;
+	struct device *dev = &mdiodev->dev;
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
+	ret = air_mdio_buckpbus_reg_write(mdiodev, EN8811H_FW_CTRL_1,
+					  EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_mdio_buckpbus_reg_modify(mdiodev, EN8811H_FW_CTRL_2,
+					   EN8811H_FW_CTRL_2_LOADING,
+					   EN8811H_FW_CTRL_2_LOADING);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_fw_write_buf(mdiodev, AIR_FW_ADDR_DM, fw1);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_fw_write_buf(mdiodev, AIR_FW_ADDR_DSP, fw2);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_mdio_buckpbus_reg_modify(mdiodev, EN8811H_FW_CTRL_2,
+					   EN8811H_FW_CTRL_2_LOADING, 0);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_en8811h_wait_mcu_ready(mdiodev);
+	if (ret < 0)
+		goto air_fw_download_out;
+
+	ret = air_mdio_buckpbus_reg_read(mdiodev, EN8811H_FW_VERSION,
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
+	/* No error print: callers log on their own terms, and a poller
+	 * would repeat it on every retry.
+	 */
+	return ret;
+}
+EXPORT_SYMBOL_GPL(air_en8811h_fw_download);
+
 int air_phy_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 01bb32e7c7c9..2a4c156d6396 100644
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
@@ -38,4 +55,11 @@ int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 int air_phy_read_page(struct phy_device *phydev);
 int air_phy_write_page(struct phy_device *phydev, int page);
 
+struct firmware;
+
+int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
+		     const struct firmware *fw);
+int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+
 #endif /* __AIR_PHY_LIB_H */
-- 
2.53.0

