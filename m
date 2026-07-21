Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA43364959;
	Tue, 21 Jul 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600760; cv=none; b=htinKqIEiJexCA4LJN8INCI5ibzjntkW//rdPLAfzrkYWownGwCUw/uip0Mu3JBYXCawLXiuP43lJWgEEE6Osh04W4A9+YoOqcEzGkd7Xk+VpruDKMa7/smRiy611hnC4pfwPCDUaKbijODipXG/VoxocQ92BySsDUA6fbJcQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600760; c=relaxed/simple;
	bh=XermuJBmE8XCNU56S8kdBUdkOKcHX6zHiDuNweMQnUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRx0I1Fp+bku5ZzSWArqsU1tsSjD6/qs7JMLW2FpAJv5FQCzX6uctEYwo4b2s/HasslteeJdQAYqmUUHi3kuIHKRKA5LzIqA4zOv4eJ/OrKRYmlyHvEjzKK4cso/h67wRQRISK0Yj0NRc/5dYArBntbrUPZz9eLSH0hge3wXb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=QoUI0sSn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="QoUI0sSn"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L2OE1Z02860135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784600655;
	bh=UIYncYARkVJrHjJB10+L71uvag/iFRC5OrzQiXEY6nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QoUI0sSnNu9nDOQm4bl/bnnBjaPJn+7JqG18cPELKDi/XXEbcFre9h0vR53mMt12b
	 o7auPHgSy2K4jv7o6nsqZzAhMSTtCuBrQXYVqC0icqxwCgYxJDxYHUn5nXs4visj8Y
	 N0QJ+XUXFScBFsA9YwnX0fZl1iSLjMsZBoL1a0nuKpnWwYs2KxZPnZMZl+GKtPVeSR
	 WDaT1Vfl11BggItNawzr7WiWjguau5uefum3BvsvNVfCddt3WYU0p5uV29hNXZeR16
	 Z50eE9Ozx/QJPYk2bnki52jw7Ed3apm72DJQyik/7E2XFmOXzFzZy0lkfWiUxu8ERw
	 VAvqpaX6qv1dg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L2OE1Z02860135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 10:24:15 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:24:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 10:24:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 4/5] net: phy: realtek: load firmware for RTL8261C_CG
Date: Tue, 21 Jul 2026 10:24:09 +0800
Message-ID: <20260721022410.1391-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260721022410.1391-1-javen_xu@realsil.com.cn>
References: <20260721022410.1391-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for loading firmware. Download some parameters
for RTL8261C_CG.
=0D
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will not =
pad
 - reverse xmas tree for some definition
 - add explanation on rtl_phy_write_mmd_bits()

Changes in v3:
 - add struct rtl8261x_priv

Changes in v4:
 - add struct device *dev

Changes in v5:
 - no changes

Changes in v6:
 - replace rtl_phy_write_mmd_bits with phy_modify_mmd, keep mdio lock
 - check msb and lsb at the beginning of rtl8261x_fw_execute_entry()
 - add comments on rtl8261x_config_init()

Changes in v7:
 - no changes

Changes in v8:
 - remove some phydev_err message in rtl8261x_fw_execute_entry() and
   rtl8261x_config_init()

Changes in v9:
 - no changes

Changes in v10:
 - no changes. Netdev queue overflow. Resend.
---
 drivers/net/phy/realtek/realtek_main.c | 214 +++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realt=
ek/realtek_main.c
index e09bff76e1dc..ba218559f39c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -8,7 +8,9 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
  */
 #include <linux/bitops.h>
+#include <linux/crc32.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/firmware.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pm_wakeirq.h>
@@ -281,6 +283,43 @@
 					 RTL8261X_INT_ALDPS_CHG | \
 					 RTL8261X_INT_JABBER)
=20
+#define FW_MAIN_MAGIC			0x52544C38
+#define FW_SUB_MAGIC_8261C		0x32363143
+#define RTL8261X_POLL_TIMEOUT_MS	100
+#define RTL8261X_MAX_MMD_DEV		31
+
+#define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
+MODULE_FIRMWARE(RTL8261C_CE_FW_NAME);
+
+enum rtl8261x_fw_op {
+	OP_WRITE =3D 0x00,	/* Write */
+	OP_POLL  =3D 0x02,	/* Polling */
+};
+
+struct rtl8261x_fw_header {
+	__le32 main_magic;	/* Main magic number */
+	__le32 sub_magic;	/* Sub magic number */
+	__le16 version_major;	/* Major version */
+	__le16 version_minor;	/* Minor version */
+	__le16 num_entries;	/* Number of entries */
+	__le16 reserved;	/* Reserved */
+	__le32 crc32;		/* CRC32 checksum */
+};
+
+struct rtl8261x_fw_entry {
+	__u8  type;		/* Operation type (OP_*) */
+	__u8  dev;		/* MMD device */
+	__le16 addr;		/* Register address */
+	__u8  msb;		/* MSB bit position */
+	__u8  lsb;		/* LSB bit position */
+	__le16 value;		/* Value to write/compare */
+	__le16 timeout_ms;	/* Poll timeout in milliseconds */
+	__u8  poll_set;		/* Poll until equal (1) or not equal (0) */
+	__u8  reserved;		/* Reserved */
+};
+
+#define FW_HEADER_SIZE		sizeof(struct rtl8261x_fw_header)
+#define FW_ENTRY_SIZE		sizeof(struct rtl8261x_fw_entry)
=20
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
@@ -300,6 +339,11 @@ struct rtl821x_priv {
 	u16 iner;
 };
=20
+struct rtl8261x_priv {
+	const char *fw_name;
+	bool fw_loaded;
+};
+
 static int rtl821x_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, RTL821x_PAGE_SELECT);
@@ -342,8 +386,16 @@ static int rtl821x_modify_ext_page(struct phy_device *=
phydev, u16 ext_page,
=20
 static int rtl8261x_probe(struct phy_device *phydev)
 {
+	struct device *dev =3D &phydev->mdio.dev;
+	struct rtl8261x_priv *priv;
 	int sub_phy_id, ret;
=20
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv =3D priv;
+
 	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_ADDR_REG,
 			    RTL_8261X_SUB_PHY_ID_ADDR);
 	if (ret < 0)
@@ -357,6 +409,7 @@ static int rtl8261x_probe(struct phy_device *phydev)
=20
 	switch (sub_phy_id) {
 	case RTL8261C_CE_MODEL:
+		priv->fw_name =3D RTL8261C_CE_FW_NAME;
 		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
=20
@@ -413,6 +466,152 @@ static int rtl8261x_read_status(struct phy_device *ph=
ydev)
 	return 0;
 }
=20
+static int rtl8261x_verify_firmware(struct phy_device *phydev, const struc=
t firmware *fw)
+{
+	const struct rtl8261x_fw_header *hdr;
+	u32 main_magic, sub_magic;
+	u32 calc_crc, file_crc;
+	size_t data_len;
+	u16 num_entries;
+
+	if (fw->size < FW_HEADER_SIZE) {
+		phydev_err(phydev, "Firmware too small: %zu bytes\n", fw->size);
+		return -EINVAL;
+	}
+
+	hdr =3D (const struct rtl8261x_fw_header *)fw->data;
+
+	main_magic =3D le32_to_cpu(hdr->main_magic);
+	if (main_magic !=3D FW_MAIN_MAGIC) {
+		phydev_err(phydev, "Invalid firmware magic: 0x%08x\n", main_magic);
+		return -EINVAL;
+	}
+
+	sub_magic =3D le32_to_cpu(hdr->sub_magic);
+	if (sub_magic !=3D FW_SUB_MAGIC_8261C) {
+		phydev_err(phydev, "Invalid sub magic: 0x%08x\n", sub_magic);
+		return -EINVAL;
+	}
+
+	num_entries =3D le16_to_cpu(hdr->num_entries);
+	data_len =3D num_entries * FW_ENTRY_SIZE;
+
+	if (fw->size !=3D sizeof(*hdr) + data_len) {
+		phydev_err(phydev, "Firmware size mismatch\n");
+		return -EINVAL;
+	}
+
+	calc_crc =3D crc32(~0, fw->data + FW_HEADER_SIZE, data_len) ^ ~0;
+	file_crc =3D le32_to_cpu(hdr->crc32);
+
+	if (calc_crc !=3D file_crc) {
+		phydev_err(phydev, "CRC32 mismatch: calculated=3D0x%08x file=3D0x%08x\n",
+			   calc_crc, file_crc);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtl8261x_fw_execute_entry(struct phy_device *phydev,
+				     const struct rtl8261x_fw_entry *entry)
+{
+	u16 addr, value, timeout_ms;
+	u8 dev, msb, lsb, poll_set;
+	u32 bits, expect_val;
+	int ret, val;
+
+	dev =3D entry->dev;
+	addr =3D le16_to_cpu(entry->addr);
+	msb =3D entry->msb;
+	lsb =3D entry->lsb;
+	value =3D le16_to_cpu(entry->value);
+	timeout_ms =3D le16_to_cpu(entry->timeout_ms);
+	poll_set =3D entry->poll_set;
+
+	if (timeout_ms =3D=3D 0)
+		timeout_ms =3D RTL8261X_POLL_TIMEOUT_MS;
+
+	if (dev > RTL8261X_MAX_MMD_DEV) {
+		phydev_err(phydev, "invalid firmware MMD device: dev=3D%u\n", dev);
+		return -EINVAL;
+	}
+
+	if (msb > 15 || lsb > msb) {
+		phydev_err(phydev, "invalid firmware bits: msb=3D%u, lsb=3D%u\n", msb, l=
sb);
+		return -EINVAL;
+	}
+
+	switch (entry->type) {
+	case OP_WRITE:
+		ret =3D phy_modify_mmd(phydev, dev, addr,
+				     GENMASK(msb, lsb), (value << lsb) & GENMASK(msb, lsb));
+		if (ret)
+			return ret;
+		break;
+
+	case OP_POLL:
+		bits =3D GENMASK(msb, lsb);
+		expect_val =3D (value << lsb) & bits;
+
+		if (poll_set)
+			ret =3D phy_read_mmd_poll_timeout(phydev, dev, addr, val,
+							(val & bits) =3D=3D expect_val,
+							1000, timeout_ms * 1000, false);
+		else
+			ret =3D phy_read_mmd_poll_timeout(phydev, dev, addr, val,
+							(val & bits) !=3D expect_val,
+							1000, timeout_ms * 1000, false);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtl8261x_fw_load(struct phy_device *phydev)
+{
+	struct rtl8261x_priv *priv =3D phydev->priv;
+	const struct rtl8261x_fw_entry *entry;
+	const struct rtl8261x_fw_header *hdr;
+	const struct firmware *fw;
+	int ret, i;
+
+	if (!priv->fw_name)
+		return 0;
+
+	ret =3D request_firmware(&fw, priv->fw_name, &phydev->mdio.dev);
+	if (ret) {
+		phydev_err(phydev, "Failed to load firmware %s: %d\n", priv->fw_name, re=
t);
+		return ret;
+	}
+
+	ret =3D rtl8261x_verify_firmware(phydev, fw);
+	if (ret)
+		goto release_fw;
+
+	hdr =3D (const struct rtl8261x_fw_header *)fw->data;
+
+	entry =3D (const struct rtl8261x_fw_entry *)(fw->data + FW_HEADER_SIZE);
+	for (i =3D 0; i < le16_to_cpu(hdr->num_entries); i++, entry++) {
+		ret =3D rtl8261x_fw_execute_entry(phydev, entry);
+		if (ret) {
+			phydev_err(phydev, "Entry %d failed: %d\n", i, ret);
+			goto release_fw;
+		}
+	}
+
+	priv->fw_loaded =3D true;
+
+release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
 static int rtl8261x_config_intr(struct phy_device *phydev)
 {
 	int ret;
@@ -490,6 +689,20 @@ static int rtl8261x_config_aneg(struct phy_device *phy=
dev)
 	return 0;
 }
=20
+static int rtl8261x_config_init(struct phy_device *phydev)
+{
+	struct rtl8261x_priv *priv =3D phydev->priv;
+
+	/* The firmware parameters are preserved across IEEE soft resets and
+	 * suspend/resume cycles. Reloading is only necessary after a power
+	 * cycle or hard reset.
+	 */
+	if (priv->fw_name && !priv->fw_loaded)
+		return rtl8261x_fw_load(phydev);
+
+	return 0;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev =3D &phydev->mdio.dev;
@@ -3186,6 +3399,7 @@ static struct phy_driver realtek_drvs[] =3D {
 		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
 		.name			=3D "Realtek RTL8261C 10Gbps PHY",
 		.probe			=3D rtl8261x_probe,
+		.config_init		=3D rtl8261x_config_init,
 		.get_features		=3D rtl8261x_get_features,
 		.config_aneg		=3D rtl8261x_config_aneg,
 		.read_status		=3D rtl8261x_read_status,
--=20
2.43.0

