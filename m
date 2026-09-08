Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50E583ACD
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883042; cv=none; b=c18R4AguWOEv6LaxxppTlOxPsgt1A/yTlP1/jHeLjWHn3KaKteUJVeG3F4dnxezfmIri+cMFQXqdbr7Y9IiRLC1qBrxR1Q5R8LvoS50WQAWFZPtM33RRvkwrb9MvATQtVIQSCrITYy2uEmVGkn+Ug4WOOgjeKM+j7DeJ9hVFli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883042; c=relaxed/simple;
	bh=2p9yZ7Q6Do51PD3NpkTwPtfW3lD7wDbzamssqSTJumM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFZj9nonXNFOUZzjVeF5LGHZgtvLn41xL9ajK+fPasbMKFiYAuf0E3ZpeV6XKKxptvXzpFyFOPspo+EwA8keojtQHmR0MsUkVfNr8B7YUK4wixa9zF0hUZ4THzUx7mJTtVVC3v717kVgBDI7b+dIMwKRgkS/RNwR1I/5+qw7wDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BmBvALFK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BmBvALFK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-485850cf499so3184980f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883036; x=1789487836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mP/t1/2ZApz5cH6iFCwEZX4W+ynS2xMGthjrCFpGvyU=;
        b=BmBvALFKHpBL57uYj8K7IOI1W59ieCu/GtzL7JWOjI9Bbi79BjsSBK++6RVjrGP4pX
         NjqfFJ0oE7kvhlb9a/0jPSktn+WfKkReeu5t7JtIr3XOXaWylHRE/mEXVA0HGD1PZjJK
         bxI5drss9fuNqaa1dVQOFdjLvHc1z+VakV7nP61XMhSYvXm7m96H4hG7w9U17k3ME71/
         bsOL/HkBDJn06IgOxJiyywVkm+NWULA6ErppLjzWxNadkFU9o93WNee+hP0AZu0OXLMp
         5BheAcR/arSE5ZSXHP4RrYJ/p05uz5b29Ozutz3lXFsnS8R7z8LBO4tzbCBqMW40e+Oc
         Ql7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883037; x=1789487837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mP/t1/2ZApz5cH6iFCwEZX4W+ynS2xMGthjrCFpGvyU=;
        b=UMXaSKh5rDPdfSGWmDA3PhpxJD+EISYjfz06VJJGc9hPFtoSe06DpCi6fmtW0UmYiO
         FKu8okkLhhaYffKzrVVa+deZ2pDLcei+thLdc1H9tzCUEQvMJJ7t63w7uowLtpTCaqkU
         +wvPpyLoqiGW/4RZ3bu7XCAmxVcqBX2HV/hMSyHUwEBMAXokA676agdBd/giyex22aDD
         bJT4ZqfwP2dOPof0HGIJy+rkcodEcs0aOSm/Y7Vww4p2KASpl/xwT8A4tMcAnTSsi4+i
         fmpzQIGOnhiygdus7vWuvb727ZA5VEFfsWiXzemUCaDh/m6Sgpot6PrbTZaDqWq+U9fP
         d/lQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNyyXoIlMCqRPhsgq8a6Lb9POgAt4S1x+5ZUCFN70BwszR6lQ1dPfTfEjNAg02slkMOCgCjEw=@vger.kernel.org
X-Gm-Message-State: AFuF++kuSEffj0HLjaF5wq1PNbFuA/piQ8kCJqARvLBZm5UG9w44rn3H
	AvwFEwP6dgSqKP6Pol5M52SZwT5fbkTlGiUmqWZtGn4Hofqvw87930EdPp17XVDXliM=
X-Gm-Gg: AYBFou2dtdjQ+VjVd35rNy78mIFK/fp3byC0wW5faXP5NajoeI4mvMFN4xdWbx7aGgT
	hK7BZf44WYd+dBECRSOs3oGUnY79E5QBfgpz/JY1YciDh20XJzK3EXoJc7sw9p1XpzJoD/6vrHr
	7zwJsT+CPgUuUJRxwUE0TKaZNt2d7IcebP5suC+shjQkBqd35CyyWqVZK3a15rmpD2ZBTNJV05I
	7UGAOOcy5gzsqEIo9sXXRJoF5YflHW8b9a3Z9C6/wCsqdho7YJmWXuvV/8mUJP4iIk/x4gsPKc0
	Evvz2bWOQf6Npl+cttYJBYm+2OFvYNOn85Ju8K+q9TX21gifANS/ZpEs09uu6OeY2CgetM4gRYW
	O80fgK8XftgqPcOMRJ5imaPydFhazTzKb46K8IY6snLM/onWiTMNxuu/xYgWwPvyDoNwEe0N2rc
	dX0ThYPGEU+3y/KOxLmN3DV6hGpmxcc/IBmX35qZc=
X-Received: by 2002:a05:6000:220f:b0:485:8c17:9762 with SMTP id ffacd0b85a97d-4858c17993amr29729185f8f.36.1788883036147;
        Tue, 08 Sep 2026 08:57:16 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm37345704f8f.21.2026.09.08.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:15 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v2 4/7] net: phy: air: move the EN8811H firmware download into the library
Date: Tue,  8 Sep 2026 15:57:04 +0000
Message-ID: <20260908155707.4164559-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908155707.4164559-1-f@lex.la>
References: <20260908155707.4164559-1-f@lex.la>
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

The write loop is broken into chunks that each take the bus lock on
their own, because the larger of the two blobs held it for 65536
register writes at a stretch and stalled every other PHY on the bus.
It did not matter while this only ran from phy_probe() on a quiet bus
at boot; the next patches run it on a live system.

The status poll asks for the MMD register through the Clause 22
indirection unconditionally. phy_read_mmd() resolved that from
phydev->is_c45, which the Clause 22 probe path leaves false, so the
constant records what the code already did rather than choosing it. It
does the three selection writes itself rather than through
mmd_phy_read(), which discards their errors and would let a failed
selection read a different register back as a success.

The readiness poll's timeout message moves out to the PHY driver's
wrapper, which is where the errno was already being reported to a
human. The poll is about to gain a caller that retries forever, and an
unconditional message there would repeat with every retry; the status
value it used to name stays behind at debug level.

Two return values change with the move. The version read at the end of
the download is now checked, so a bus error there fails the load
instead of leaving the version at zero; en8811h_print_fw_version()
still discards it on the AN8811HB path, which does not go through this
download. And the readiness poll hands back the errno from a failed
status read rather than -ENODEV, which reaches the AN8811HB probe too,
since it shares the wait.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/air_en8811h.c | 146 +----------------
 drivers/net/phy/air_phy_lib.c | 301 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h |  29 ++++
 3 files changed, 337 insertions(+), 139 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 16a9171cb838..6822774d9ae3 100644
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
@@ -270,86 +254,14 @@ static int __air_pbus_reg_write(struct mdio_device *mdiodev,
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
-	if (fw->size % 4) {
-		phydev_err(phydev, "firmware size %zu is not a multiple of 4\n",
-			   fw->size);
-		return -EINVAL;
-	}
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
+	int ret = air_en8811h_wait_mcu_ready(&phydev->mdio);
 
-	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-					 EN8811H_FW_CTRL_1_FINISH);
-	if (ret)
-		return ret;
+	if (ret < 0)
+		phydev_err(phydev, "MCU not ready: %pe\n", ERR_PTR(ret));
 
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
+	return ret;
 }
 
 static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
@@ -411,7 +323,7 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = air_write_buf(phydev, address,  fw);
+	ret = air_fw_write_buf(&phydev->mdio, address, fw);
 	release_firmware(fw);
 	return ret;
 }
@@ -507,54 +419,10 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 
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
index e314717843ae..5b7427e0d977 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -8,8 +8,12 @@
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
@@ -198,6 +202,303 @@ int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 }
 EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_modify);
 
+static int __air_write_buf(struct mdio_device *mdiodev, u32 address,
+			   const u8 *data, size_t len)
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
+	for (offset = 0; offset < len; offset += 4) {
+		val = get_unaligned_le16(&data[offset + 2]);
+		ret = __mdiodev_write(mdiodev, AIR_BPBUS_WR_DATA_HIGH, val);
+		if (ret < 0)
+			return ret;
+
+		val = get_unaligned_le16(&data[offset]);
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
+	size_t chunk, done = 0;
+	int saved_page, ret;
+
+	if (fw->size % 4) {
+		dev_err(&mdiodev->dev, "firmware size %zu is not a multiple of 4\n",
+			fw->size);
+		return -EINVAL;
+	}
+
+	while (done < fw->size) {
+		chunk = min_t(size_t, fw->size - done, AIR_FW_CHUNK_BYTES);
+
+		mdiodev_lock(mdiodev);
+
+		saved_page = __air_mdio_select_page(mdiodev,
+						    AIR_PHY_PAGE_EXTENDED_4);
+		if (saved_page < 0) {
+			ret = saved_page;
+		} else {
+			ret = __air_write_buf(mdiodev, address + done,
+					      fw->data + done, chunk);
+			ret = __air_mdio_restore_page(mdiodev, saved_page,
+						      AIR_PHY_PAGE_EXTENDED_4,
+						      ret);
+		}
+
+		mdiodev_unlock(mdiodev);
+		if (ret < 0)
+			return ret;
+
+		done += chunk;
+	}
+
+	return 0;
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
+/* mmd_phy_read() drops the errors from the three writes that select the
+ * register, so a failed selection reads a different one back as success.
+ */
+static int __air_mmd_read(struct mdio_device *mdiodev, u16 devad, u16 regnum)
+{
+	struct mii_bus *bus = mdiodev->bus;
+	int addr = mdiodev->addr;
+	int ret;
+
+	ret = __mdiobus_write(bus, addr, MII_MMD_CTRL, devad);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, addr, MII_MMD_DATA, regnum);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, addr, MII_MMD_CTRL,
+			      devad | MII_MMD_CTRL_NOINCR);
+	if (ret < 0)
+		return ret;
+
+	return __mdiobus_read(bus, addr, MII_MMD_DATA);
+}
+
+static int air_mmd_status_read(struct mdio_device *mdiodev)
+{
+	int ret;
+
+	mdiodev_lock(mdiodev);
+	ret = __air_mmd_read(mdiodev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS);
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
+	 * error ends the poll at once, like phy_read_mmd_poll_timeout().
+	 */
+	ret = read_poll_timeout(air_mmd_status_read, reg_value,
+				reg_value < 0 ||
+				reg_value == EN8811H_PHY_READY,
+				20000, 7500000, true, mdiodev);
+	if (reg_value < 0)
+		return reg_value;
+	if (ret) {
+		dev_dbg(&mdiodev->dev, "MCU not ready: 0x%x\n", reg_value);
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
index 01bb32e7c7c9..70c8ba66bd73 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -16,6 +16,11 @@
 #define AIR_PHY_PAGE_EXTENDED_1		0x0001
 #define AIR_PHY_PAGE_EXTENDED_4		0x0004
 
+/* Bytes written between bus releases, so the other PHYs on it get a turn.
+ * At a 2.5 MHz MDC this size holds the bus for about 30 ms.
+ */
+#define AIR_FW_CHUNK_BYTES		2304
+
 /* MII Registers Page 4*/
 #define AIR_BPBUS_MODE			0x10
 #define   AIR_BPBUS_MODE_ADDR_FIXED		0x0000
@@ -29,6 +34,23 @@
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
@@ -38,4 +60,11 @@ int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
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

