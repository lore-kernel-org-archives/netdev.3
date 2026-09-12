Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3F47DD4E
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218287; cv=none; b=s94ehIQtYZ549Iutfq27sKRYkCJE21zgqStGiu/pTXaeT2wdQiX4iCzjxrbFESXMW1/dyOnKnhG30fWBBKew6WAoKE0XF7iWl5KiY8NW+zju4s7oF8e064gkML10uKnZhnGYpec7KV52XZWlkd6HXBSMEOhIzHctGNW08d16XMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218287; c=relaxed/simple;
	bh=wSi/zVmdNoLSb3xhhxipZmgQjKIK1uUkLkPwJbRGNG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ9DQ6qYPAkyran5OiLnEzO/RT2P/q4kJAgIcqjH6Z7bfCBiC+8lIpYg66gfH9r3iW0gmazUUJ/Gt2dXOLNcEUi90zMubGTRNQitaIntp+vaLHXOsBJpbyndJ5HupgeOhl6Xxdc9DR9mx76opvQtzeyM0MUkMJydgcwcEP8CxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=MI6lzi2z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="MI6lzi2z"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49e6e69d528so3785225e9.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789218281; x=1789823081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIc/2dc1TDQyNegTPxQApWX+hmIcLgk99V9rw78CEXY=;
        b=MI6lzi2zm8wo0ImK9hFsndekX/xQv4yKvpKjz0daLS2TQmZEJych5owG9NJ44lyhxM
         5+6/0ZLfXlA6mOpJzZBZ6I+BflsDqoEF3NiLGt9ln6KjdQHNLfs1r/qcaE6tp5B4U5oO
         XP/9PLcxJzxFxWDFYGQjNqKtf85ayoLvFsL7JXw2s1ZTHQ4fTHKaigHl6jD+NfK21HwB
         0L5KDJ09FPXWFDheoYONnlbqiqwnY1wZ4lRir/1kHqOQZ7Vg7rT/L5Rm/KWXrz2Nu7M+
         wbwiUqw7h5MloyYXOm24Ivd9sWMM/xM1CihbjO+Av1fNB4MGSEdAWcrLP3fV0P0kKVmC
         DGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218281; x=1789823081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DIc/2dc1TDQyNegTPxQApWX+hmIcLgk99V9rw78CEXY=;
        b=M/hEsO8Ykes5nWaIZUnk74278r71hcxqhVaxsXsOUTS06of2DKeVPLrR8ag1ZwIMWZ
         m2IyiNfQH3arADql2cKWw36vQpw+fTw03EO5zfA8S6nsNlFe+hI7n7YPGrTbkHeUHPg5
         2uOb4lz8NTvqZHPLza+PadMb+nX8CEUO8z2u40Gs4V7prIjfp8kU84LLO+aphZl7b75O
         1q+vbz1Q+9KIvKKJ6LrDEk8BYKze5CIRaBYEvqFkZ46kbbmuYMpUbu55FwOInVrp1sYi
         wA17KS/3XavUudmslBLdVtCpVvjJyeS3VOOB/FU318IhtaBnH1NRSndCrX4dYldSmR1J
         Lc4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwGRmubeZpha1cP3Fmz0EF6H7aYjDkVejkJ9Rd16kaPt2BS2Dlh3lCBmfPKvAgl6pQbEkg5DS0=@vger.kernel.org
X-Gm-Message-State: AFuF++kLo5EYeyy1APv4wJxLkMwJroRyeYmXwcx3FhjOda83AvZ58u2T
	FJMJsrp2TvAQiuf988e5JG8GYvA3prRRf5JCQmvEXljfz1N3uGVSV/iGDjMRSErTluU=
X-Gm-Gg: AYBFou0zCkpqdKXqI40jiFz7kWI7AWmVb5ae0EMdMjP1aYZyy1R/PhJY/nv4EbRUjsC
	Y1ioS52bnpntdMnM8gMhcshrYuiBtniGS2WLHLikJXbtHI8GVfCupACXqaecM0apCmNBX79xCTu
	Fj5Bx/fhmBIMtPPjgqI3yp7aOf1+pJtHzH6C0UB+V2kVmvYUuJtyD8YDiQXyO3055EwCOt4g1MK
	j4ID4rw0SDX1lMmt68VnsyQhmV63T5+io83jz3Icl0YBZS0x85fJhapGfBsQMR44GCOVktLF1Tc
	wUwh4FU9IY8aEcpssYPBNHL6AeBn3NFxyJAiMgbKeBRDSv3N+qERNW48Oa1GI6t0wMgxhYwwp2q
	9ZkEf20pAh2/pyPx0/GjD40ggmod531bJ54uJ5PgU5yxeXHQmj4uvZ2swDq80Ud/Zjzen7b4OsZ
	I/sVnJA7qBHuT54Urdj67jd+4Y6HkDm24NvNOikf4EHiCZ5NFD8g==
X-Received: by 2002:a05:600c:4714:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49e61988b9emr92906245e9.10.1789218280939;
        Sat, 12 Sep 2026 06:04:40 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm80985785e9.5.2026.09.12.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:40 -0700 (PDT)
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
Subject: [RFC PATCH net-next v3 3/6] net: phy: air: move the EN8811H firmware download into the library
Date: Sat, 12 Sep 2026 16:04:27 +0300
Message-ID: <20260912130430.2246285-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912130430.2246285-1-f@lex.la>
References: <20260912130430.2246285-1-f@lex.la>
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
indirection unconditionally, which is what the Clause 22 probe path was
already doing.

Behaviour changes where the library now reports instead of printing: the
version read at the end of the download is checked, the readiness poll
hands back the errno from a failed status read rather than -ENODEV, and
the lines the old helpers printed on failure move to their callers or to
debug level. The AN8811HB probe shares the readiness wait and the block
writer, so it sees those too.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    The status read does its three Clause 22 selection writes itself rather
    than through mmd_phy_read(), which discards their errors and would let a
    failed selection read a different register back as a success. Asking for
    Clause 22 unconditionally records what was already happening rather than
    choosing it: phy_read_mmd() resolved the question from phydev->is_c45,
    which the Clause 22 probe path leaves false.
    
    The readiness poll's timeout message moves out to the PHY driver's
    wrapper, which is where the errno was already being reported to a human.
    The poll is about to gain a caller that retries forever, and an
    unconditional message there would repeat with every retry; the status
    value it used to name stays behind at debug level.
    
    The behaviour changes, one by one. The version read at the end of the
    download is now checked, so a bus error there fails the load instead of
    leaving the version at zero; en8811h_print_fw_version() still discards it
    on the AN8811HB path, which does not go through this download. The
    readiness poll hands back the errno from a failed status read rather than
    -ENODEV. Its failure is now reported once, by the wrapper and naming that
    errno, where phy_read_mmd_poll_timeout() used to print a line of its own
    before the wrapper printed the status register. A failed block write no
    longer names its address, since both callers report the failure anyway.
    The version print moves to the wrapper for the same reason as the timeout
    message: the library hands the number back through fw_version, and the
    caller decides whether a human sees it.

 drivers/net/phy/air_en8811h.c | 150 ++---------------
 drivers/net/phy/air_phy_lib.c | 297 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h |  29 ++++
 3 files changed, 337 insertions(+), 139 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 16a9171cb838..43d2eff808f1 100644
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
@@ -270,86 +254,15 @@ static int __air_pbus_reg_write(struct mdio_device *mdiodev,
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
+	int ret;
 
-	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-					 EN8811H_FW_CTRL_1_FINISH);
-	if (ret)
-		return ret;
+	ret = air_en8811h_wait_mcu_ready(&phydev->mdio);
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
@@ -411,7 +324,7 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = air_write_buf(phydev, address,  fw);
+	ret = air_fw_write_buf(&phydev->mdio, address, fw);
 	release_firmware(fw);
 	return ret;
 }
@@ -507,56 +420,15 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 
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
+	else
+		phydev_info(phydev, "MD32 firmware version: %08x\n",
+			    priv->firmware_version);
 
 	return ret;
 }
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index e314717843ae..672a82539dbe 100644
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
@@ -198,6 +202,299 @@ int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
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
+		mutex_lock(&mdiodev->bus->mdio_lock);
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
+		mutex_unlock(&mdiodev->bus->mdio_lock);
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
+	mutex_lock(&mdiodev->bus->mdio_lock);
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
+	mutex_unlock(&mdiodev->bus->mdio_lock);
+	return ret;
+}
+
+static int air_mdio_buckpbus_reg_write(struct mdio_device *mdiodev,
+				       u32 pbus_address, u32 pbus_data)
+{
+	int saved_page, ret;
+
+	mutex_lock(&mdiodev->bus->mdio_lock);
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
+	mutex_unlock(&mdiodev->bus->mdio_lock);
+	return ret;
+}
+
+static int air_mdio_buckpbus_reg_modify(struct mdio_device *mdiodev,
+					u32 pbus_address, u32 mask, u32 set)
+{
+	int saved_page, ret;
+
+	mutex_lock(&mdiodev->bus->mdio_lock);
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
+	mutex_unlock(&mdiodev->bus->mdio_lock);
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
+	mutex_lock(&mdiodev->bus->mdio_lock);
+	ret = __air_mmd_read(mdiodev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS);
+	mutex_unlock(&mdiodev->bus->mdio_lock);
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
+	struct device *dev = &mdiodev->dev;
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
index 01bb32e7c7c9..c288b34f2ffc 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -10,12 +10,19 @@
 
 #include <linux/phy.h>
 
+struct firmware;
+
 #define AIR_EXT_PAGE_ACCESS		0x1f
 
 #define AIR_PHY_PAGE_STANDARD		0x0000
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
@@ -29,6 +36,23 @@
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
@@ -38,4 +62,9 @@ int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 int air_phy_read_page(struct phy_device *phydev);
 int air_phy_write_page(struct phy_device *phydev, int page);
 
+int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
+		     const struct firmware *fw);
+int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+
 #endif /* __AIR_PHY_LIB_H */
-- 
2.53.0

