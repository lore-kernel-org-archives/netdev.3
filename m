Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBF3CAA57
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716759; cv=none; b=ofDZZJ0aITAeykx7JLhXz0VT4nV0urK/kYEhNiPUwkER/9Egx8ksX3na/NG6kyOy/RgJz2ridBsjHykNA3g5nAvP6woei09IlOUzESp7mW1slKwyI0u70IZuorrIAEEDZQOdHRrWvmc3jVAdjLhJr7pFse9iwt75Jend8NqpgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716759; c=relaxed/simple;
	bh=xdisZz+DkVGtPIWoZoRqXSljlwpgnhj3MZcVyEplODs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beuZP8uuayK+IBjue+B/Qbx5r04PVo2jaAXwr3gQ7AFRMqpiRk7ufRwKLeIV/Qn2JbTmGZDnaeLTmUrhxaxt70aoWga4YYvOlmaSrzWrqPFATDGGKWnxcNc2bR+ic7TvUO/J5uHyX8X6eeD/F+nTVnINKoZCZ6Hl8Y9QaU+893Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=iSDIjEge; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="iSDIjEge"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1361811f8f.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788716754; x=1789321554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5yq0K7Toe89sHS+2VR4FOJB6v/+peITAwOBRO1SMuw=;
        b=iSDIjEge5bGv/ln2407pHaMoeoavRp+dvQlyIZidBq/QDW5lW27vCK0FBAKybpG73P
         Fl/LZmzPx6v35IBlMVrvjnm0zE1VaPp35ySU4xtmEAMaHFVHtBMPaSEJCdMjRG/42QYC
         QaHGeXpA7uTOR6x23mcWNiXtViFPP9VlQVuuSBgtiHX7q3aWXxxZsePES/zH+0XzCbDh
         GzrL1R+CPEnjULmn2j2jdQTW5s4sAOxChG2DkRSuTwJ6zRVz1Wqe15GLL5iDkD+jMhEG
         89sfvaJ/HF+h0q9UEMLxv/dFqVVTOgM6JjR2QEUCo3fl74vaJy48p5rNjUsTKZ4AAzw9
         AN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716754; x=1789321554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5yq0K7Toe89sHS+2VR4FOJB6v/+peITAwOBRO1SMuw=;
        b=RAA17uXQfUpJV0zH2DoqbdObVG5GXwzzkRHEeWIjcQAgurlpMk/AbcQMJ+CbKEtqqo
         SWHZq/vWoudSZ5WdVbcPUW16rb9H0hI7d767MK0fjJneRx3pjOEon7FhloWdFnz0Wxbl
         hW7qINSPk+FfqrtkFNQpRReuLJkOfj9oiUlR5QHsscPAQ7RaXTmtfTO9gJUBsR3NDud1
         gFXeQaQhAkGo1T271ed2R61hCoZUscAKuQ0KXKpm2YMSmQIWsmjp5VjG735kDTr/qj4+
         5CKjQjBfWOYTRfw5rDToL3TBdW+Xld5eP3TJvo92QwL3KoHB+7hgPqnmY5l2R14Y3ev+
         kaCA==
X-Forwarded-Encrypted: i=1; AKwUvBypvdD9/ioLC9GZjRzgG5XZCX+OG1sQz9iKvyqaJOFuADt7Is9LRG3F2fdRLzszilVHosepXfE=@vger.kernel.org
X-Gm-Message-State: AFuF++mlemwuso/LJGqyXPvf94QczixyLJiDmkbD1iSLFa958Gl1VFKt
	h6WQ2KGeHIupzXznHsSzrI5OBbpuPHr/6Vzg66ByFf+nDr21ExkoXmgobYOKJDaukbc=
X-Gm-Gg: AYBFou3iY5Oad4udafSg4lvDXrH+cxdnLbN1YtY3krtk5+bfgIAgZfM/MXOLF4x3Aeh
	aDmtRM8B1b3yHq43RdzxAeWvdRlNHBKcDETQuup16hEot8tmGBX9kMDhxuz5PuWCWPuilLAP8Hh
	vGfHKZ2+XrGfWFeQmyJ7htaHM/EvKFsnCkYyTzv81emte2+g5nRJVZIXkUZJSB84CE8PKqlsRQv
	Apl2f+IMRpWZOfcyabsg6Cd8ZM5eIX8jXvEhRvp5DbvcFDTZwZJzZ+QDM/tmEs//fHJiwjo8SYp
	Okc7SlJ4cQT2XDtVdYARJmtNCNwZid/RXM1Q5OFyVHaq0GQLQnITNZXKb2TAizcl6/D8x0f0Mk3
	xUdZZrzY7P5cPvpfKpQkzJEqpf+0azIDKGMMQNMQBO11mYh42cg+GQ23Os+T1Jmizb9p55pVyEb
	QmJjUSlvy6yuXxr/8GmecdfdQYUi7nFbzXy43976BwLlNIF4FVlA==
X-Received: by 2002:a05:600c:4e90:b0:49c:f3dd:e166 with SMTP id 5b1f17b1804b1-49cf826ca60mr177274745e9.13.1788716754356;
        Sun, 06 Sep 2026 10:45:54 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm245418805e9.0.2026.09.06.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:45:54 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 4/7] net: phy: air: move the EN8811H firmware download into the library
Date: Sun,  6 Sep 2026 17:45:40 +0000
Message-ID: <20260906174548.4106801-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788711797.git.f@lex.la>
References: <cover.1788711797.git.f@lex.la>
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
index ec7c44ca68e7..920cc0ea1f67 100644
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

