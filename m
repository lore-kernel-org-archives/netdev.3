Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206626;
	b=ziVs3dbWx74XBJX9NnT7G91K0SOtywxNxz+3R9Fh5qQDrpm5vaYkc2eHyedkjHPo20e3
	 g4Bp/qHHG0xB0BrGMUqchQRFYM6zFKgeabk/uj+A+WjZoQ/JzU90IujGIezOAAzFH/e4K
	 p3xlDT3zlWNHf70cgd8RvmXsFhK5FZNYzQwwfiogCG6uxWV6Xshda6mARBsh5ThJ8vArs
	 eYIFzs9TvrjBEzdvoXIm7ZK0dQ6k59fAT00ZLA6cqwtxTAGNKSfYJuJVsLenkEW4YeUqB
	 uSTUf5fVMGQYbpYDV0lYUOD9uxdi5RZTnmepgQ3cEgkDhBMT2GfJxPSpOjn0u2r6kEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206626;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Xwqg9o6T0wYStvp9Lpu50Cfm9mn74IHiuePlPWzMtcs=;
	b=lB0Zz9Xx6n/kBGx4qbk0FiCVCRC6IFCPuqlSLH2MSLT4JDFCMZ+85wnlKsMreXuMTL2G
	 AoB8Q5Re4ngWyHR1gIuQ/dsKmiShQgSIrTiw5qOPMKZZ5ceKS/K0RRApRm47MaZaeZ1dV
	 saZCHodK1HBO0xAtHWYP8rM/DKHCEfahuOUD80fpxlQf28vMogWiJQjV3WovwYz65fM+4
	 ZATagGwnMzer98WU1uUq7q/FhYuJquCiY0zYkpm0kIgethCMzmkfx/LqTZ7V6qW8+i/K3
	 E4LFjTIO8BXUd+NagcFMXKJ8cy5+8NVc0X4urs7nfSyhR6iAHP3OyfnFH7XbC4qh99Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.149
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35138606A31C;
	Mon,  9 Nov 2026 06:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35138606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0114667-0.234744-0.753789;FP=14482270393350098034|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=frank.sae@motor-comm.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jzrZwxT_1794206612;
Received: from motor-comm.com(mailfrom:frank.sae@motor-comm.com fp:SMTPD_---.jzrZwxT_1794206612 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 14:43:33 +0800
From: "Frank.sae" <frank.sae@motor-comm.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lingyu.zou@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v2] net: phy: motorcomm: add YT8831 2.5G PHY support
Date: Mon,  9 Nov 2026 06:43:32 +0000
Message-ID: <20261109064332.3381180-1-frank.sae@motor-comm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the motorcomm yt8831 2.5G ethernet phy. Verified the
driver on BPI-R3 (with MediaTek SoC)

yt8831 2.5G ethernet phy works in AUTO_BX2500_SGMII or FORCE_BX2500
interface, supports 2.5G/1000M/100M/10M speeds, and wol(magic packet).

v2:
- Fix the notes of function yt8831_set_wol has no return value
- Fix YT8831 SDS config_init softreset error
- Fix YT8831 read_status dont read LP's 2.5G status
v1:
https://lore.kernel.org/all/20261022054642.1332801-1-frank.sae@motor-comm.com/

Signed-off-by: Frank.sae <frank.sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 555 +++++++++++++++++++++++++++++++++++-
 1 file changed, 553 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 463e1ea3efc9..eac96c2d3754 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8522/8531/8531S/861x/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/861x/8821/8831 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
@@ -22,6 +22,7 @@
 /* Live captured from YT921x switch internal MDIO bus */
 #define PHY_ID_INT861X		0x01e04281
 #define PHY_ID_YT8821		0x4f51ea19
+#define PHY_ID_YT8831		0x4f51e938
 /* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
@@ -171,6 +172,11 @@
 #define YT8521_RSSR_UTP_SPACE			(0x0 << 1)
 #define YT8521_RSSR_TO_BE_ARBITRATED		(0xFF)
 
+#define YT8831_REG_SPACE_SELECT_REG		0x8020
+#define YT8831_RSSR_SPACE_MASK			(BIT(1) | BIT(0))
+#define YT8831_RSSR_FIBER_SAPCE			BIT(1)
+#define YT8831_RSSR_UTP_SAPCE			BIT(0)
+
 #define YT8521_CHIP_CONFIG_REG			0xA001
 #define YT8521_CCR_SW_RST			BIT(15)
 #define YT8531_RGMII_LDO_VOL_MASK		GENMASK(5, 4)
@@ -258,6 +264,53 @@
 #define YTPHY_WCR_INTR_SEL			BIT(6)
 #define YTPHY_WCR_ENABLE			BIT(3)
 
+#define YT8831_WOL_CONFIG_REG			0x160a
+#define YT8831_WOL_ENABLE_MASK			BIT(0)
+#define YT8831_WOL_ENABLE			BIT(0)
+#define YT8831_WOL_DISABLE			0x0
+#define YT8831_WOL_PULSE_WIDTH_MASK             (BIT(3) | BIT(2))
+#define YT8831_WOL_PULSE_WIDTH_168MS            BIT(2)
+#define YT8831_WOL_OUTPUT_TYPE_SEL_MASK         BIT(1)
+#define YT8831_WOL_OUTPUT_TYPE_SEL_PULSE        BIT(1)
+
+#define YT8831_WOL_MACADDR2_REG	                0x1604
+#define YT8831_WOL_MACADDR1_REG			0xA006
+#define YT8831_WOL_MACADDR0_REG			0xA008
+
+#define YT8831_WCR_INTR_REG                     0x8301
+#define YT8831_WCR_INTR_SEL_MASK		(BIT(1) | BIT(0))
+#define YT8831_WCR_INTR_SEL_WOL_ONLY		0x2
+#define YT8831_WCR_INTR_SEL_ALL			0x1
+
+
+#define YT8831_SDS_WRITE_PROTECT_REG		0x873
+#define YT8831_SDS_SGMII_OUTPUT_REG		0x1002
+
+#define YT8831_UTP_WRITE_PROTECT_REG			0x1
+#define YT8831_UTP_DAC_DATA_DLY_REG			0x0
+#define YT8831_UTP_REF_DLAY_SEL_REG			0x3
+#define YT8831_UTP_REF_DLAY_SEL_FEXT_REG		0x4
+#define YT8831_UTP_COE_MANUAL_SHIFT_SEL_2500_REG	0x723
+#define YT8831_UTP_EEE_OPTIM_1_REG			0x727
+#define YT8831_UTP_EEE_OPTIM_2_REG			0x339
+#define YT8831_UTP_EEE_MSE1_REG				0xc3
+#define YT8831_UTP_EEE_MSE2_REG				0x32
+#define YT8831_UTP_EEE_OPTIM_3_REG			0xff
+#define YT8831_UTP_EEE_OPTIM_4_REG			0x372
+#define YT8831_UTP_EEE_OPTIM_5_REG			0x336
+#define YT8831_UTP_EEE_OPTIM_6_REG			0x340
+#define YT8831_UTP_PSAN_OPTIM_REG			0x1e58
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_1_REG		0x209e
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_2_REG		0x20a4
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_3_REG		0x20a9
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_4_REG		0x20af
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_5_REG		0x20b4
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_6_REG		0x20ba
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_7_REG		0x20bf
+#define YT8831_UTP_1000M_TEMPLATE_OPTIM_8_REG		0x20c5
+#define YT8831_UTP_2500M_TEMPLATE_OPTIM_1_REG		0x20ff
+#define YT8831_UTP_2500M_TEMPLATE_OPTIM_2_REG		0x2100
+
 /* 2b00 84ms
  * 2b01 168ms  *default*
  * 2b10 336ms
@@ -397,6 +450,16 @@
 #define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
 #define YT8821_CHIP_MODE_FORCE_BX2500		1
 
+#define YT8831_CHIP_MODE_SEL				0x8802
+#define YT8831_CHIP_MODE_SEL_MASK			GENMASK(2, 0)
+#define YT8831_CHIP_MODE_AUTO_BX2500_SGMII		0x0
+#define YT8831_CHIP_MODE_FORCE_2500BASEX		BIT(0)
+#define YT8831_CHIP_MODE_UTP_TO_FIBER_FORCE		(BIT(2) | BIT(0))
+
+#define YT8831_MDIO_ADDRESS_CTL				0x8004
+#define YT8831_MDIO_ADDRESS_CTL_EN_BROADCAST_MASK	BIT(8)
+#define YT8831_MDIO_ADDRESS_CTL_EN_BROADCAST		BIT(8)
+
 struct yt8521_priv {
 	/* combo_advertising is used for case of YT8521 in combo mode,
 	 * this means that yt8521 may work in utp or fiber mode which depends
@@ -543,6 +606,29 @@ static int ytphy_modify_ext_with_lock(struct phy_device *phydev, u16 regnum,
 	return ret;
 }
 
+/**
+ * yt8831_get_wol() - report whether wake-on-lan is enabled
+ * @phydev: a pointer to a &struct phy_device
+ * @wol: a pointer to a &struct ethtool_wolinfo
+ *
+ * NOTE: YT8831_WOL_CONFIG_REG is common ext reg.
+ */
+static void yt8831_get_wol(struct phy_device *phydev,
+			  struct ethtool_wolinfo *wol)
+{
+	int wol_config;
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+
+	wol_config = ytphy_read_ext_with_lock(phydev, YT8831_WOL_CONFIG_REG);
+	if (wol_config < 0)
+		return;
+
+	if (wol_config & YT8831_WOL_ENABLE_MASK)
+		wol->wolopts |= WAKE_MAGIC;
+}
+
 /**
  * ytphy_get_wol() - report whether wake-on-lan is enabled
  * @phydev: a pointer to a &struct phy_device
@@ -704,6 +790,76 @@ static int yt8531_set_wol(struct phy_device *phydev,
 	return 0;
 }
 
+/**
+ * yt8831_set_wol() - turn wake-on-lan on or off
+ * @phydev: a pointer to a &struct phy_device
+ * @wol: a pointer to a &struct ethtool_wolinfo
+ *
+ * NOTE: YT8831_WOL_CONFIG_REG is common ext reg.
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8831_set_wol(struct phy_device *phydev,
+			  struct ethtool_wolinfo *wol)
+{
+	const u16 mac_addr_reg[] = {
+		YT8831_WOL_MACADDR2_REG,
+		YT8831_WOL_MACADDR1_REG,
+		YT8831_WOL_MACADDR0_REG,
+	};
+	const u8 *mac_addr;
+	u16 mask, val;
+	int ret;
+	u8 i;
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		mac_addr = phydev->attached_dev->dev_addr;
+
+		/* Store the device address for the magic packet */
+		for (i = 0; i < 3; i++) {
+			ret = ytphy_write_ext_with_lock(phydev, mac_addr_reg[i],
+							((mac_addr[i * 2] << 8)) |
+							(mac_addr[i * 2 + 1]));
+			if (ret < 0)
+				return ret;
+		}
+
+		/* Enable WOL feature */
+		mask = YT8831_WOL_ENABLE_MASK
+			| YT8831_WOL_PULSE_WIDTH_MASK
+			| YT8831_WOL_OUTPUT_TYPE_SEL_MASK;
+
+		val = YT8831_WOL_ENABLE
+			| YT8831_WOL_PULSE_WIDTH_168MS
+			| YT8831_WOL_OUTPUT_TYPE_SEL_PULSE;
+
+		ret = ytphy_modify_ext_with_lock(phydev, YT8831_WOL_CONFIG_REG,
+						 mask, val);
+		if (ret < 0)
+			return ret;
+
+		/* Enable WOL interrupt */
+		ret = ytphy_modify_ext_with_lock(phydev, YT8831_WCR_INTR_REG,
+				YT8831_WCR_INTR_SEL_MASK,
+				YT8831_WCR_INTR_SEL_WOL_ONLY);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Disable WOL feature */
+		mask = YT8831_WOL_ENABLE_MASK;
+		ret = ytphy_modify_ext_with_lock(phydev, YT8831_WOL_CONFIG_REG,
+							mask, YT8831_WOL_DISABLE);
+
+		/* Disable WOL interrupt */
+		ret = ytphy_modify_ext_with_lock(phydev, YT8831_WCR_INTR_REG,
+					YT8831_WCR_INTR_SEL_MASK, YT8831_WCR_INTR_SEL_ALL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int yt8511_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, YT8511_PAGE_SELECT);
@@ -798,6 +954,27 @@ static int yt8521_read_page(struct phy_device *phydev)
 	return YT8521_RSSR_UTP_SPACE;
 };
 
+/**
+ * yt8831_read_page() - read reg page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns current reg space of yt8831 (YT8831_RSSR_FIBER_SAPCE/
+ * YT8831_RSSR_UTP_SAPCE) or negative errno code
+ */
+static int yt8831_read_page(struct phy_device *phydev)
+{
+	int old_page;
+
+	old_page = ytphy_read_ext(phydev, YT8831_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+
+	if ((old_page & YT8831_RSSR_SPACE_MASK) == YT8831_RSSR_FIBER_SAPCE)
+		return YT8831_RSSR_FIBER_SAPCE;
+
+	return YT8831_RSSR_UTP_SAPCE;
+};
+
 /**
  * yt8521_write_page() - write reg page
  * @phydev: a pointer to a &struct phy_device
@@ -818,6 +995,26 @@ static int yt8521_write_page(struct phy_device *phydev, int page)
 	return ytphy_modify_ext(phydev, YT8521_REG_SPACE_SELECT_REG, mask, set);
 };
 
+/**
+ * yt8831_write_page() - write reg page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: The reg page(YT8831_RSSR_FIBER_SAPCE/YT8831_RSSR_UTP_SAPCE) to write.
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8831_write_page(struct phy_device *phydev, int page)
+{
+	int mask = YT8831_RSSR_SPACE_MASK;
+	int set;
+
+	if ((page & YT8831_RSSR_SPACE_MASK) == YT8831_RSSR_FIBER_SAPCE)
+		set = YT8831_RSSR_FIBER_SAPCE;
+	else
+		set = YT8831_RSSR_UTP_SAPCE;
+
+	return ytphy_modify_ext(phydev, YT8831_REG_SPACE_SELECT_REG, mask, set);
+};
+
 /**
  * struct ytphy_cfg_reg_map - map a config value to a register value
  * @cfg: value in device configuration
@@ -2554,6 +2751,187 @@ static int yt8521_get_features(struct phy_device *phydev)
 	return ret;
 }
 
+static int yt8831_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_c45_config_aneg(phydev);
+}
+
+/**
+ * yt8831_serdes_init() - serdes init
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8831_serdes_init(struct phy_device *phydev)
+{
+	int old_page = YT8831_RSSR_UTP_SAPCE;
+	int ret = -EINVAL;
+
+
+	old_page = phy_select_page(phydev, YT8831_RSSR_FIBER_SAPCE);
+	if (old_page < 0) {
+		phydev_err(phydev, "Failed to select page: %d\n",
+				old_page);
+		goto err_restore_page;
+	}
+
+	ret = ytphy_write_ext(phydev, YT8831_SDS_WRITE_PROTECT_REG, 0x1);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, YT8831_SDS_SGMII_OUTPUT_REG, 0xc4);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* softreset sds space */
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
+	if (ret < 0)
+		goto err_restore_page;
+
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8831_utp_init() - utp init
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8831_utp_init(struct phy_device *phydev)
+{
+	int ret = -EINVAL;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_WRITE_PROTECT_REG, 0x3);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_DAC_DATA_DLY_REG, 0xc8d);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_REF_DLAY_SEL_REG, 0xa426);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_REF_DLAY_SEL_FEXT_REG, 0x8009);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_COE_MANUAL_SHIFT_SEL_2500_REG, 6);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_OPTIM_1_REG, 0x1001);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_OPTIM_2_REG, 0x7c52);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_MSE1_REG, 0x3848);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_MSE2_REG, 0xa8e8);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_OPTIM_3_REG, 0x5200);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_OPTIM_4_REG, 0x5849);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_OPTIM_5_REG, 0xb00a);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_EEE_OPTIM_6_REG, 0x3022);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_PSAN_OPTIM_REG, 0x1f10);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_1_REG, 0x22c8);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_2_REG, 0x2437);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_3_REG, 0x22c8);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_4_REG, 0x2437);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_5_REG, 0x22c8);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_6_REG, 0x2437);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_7_REG, 0x22c8);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_1000M_TEMPLATE_OPTIM_8_REG, 0x2437);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_2500M_TEMPLATE_OPTIM_1_REG, 0x1111);
+	if (ret < 0)
+		goto err;
+
+	ret = ytphy_write_ext_with_lock(phydev, YT8831_UTP_2500M_TEMPLATE_OPTIM_2_REG, 0x1111);
+	if (ret < 0)
+		goto err;
+
+err:
+	return ret;
+}
+
+/**
+ * yt8831_get_rate_matching - read register to get phy chip mode
+ * @phydev: target phy_device struct
+ * @iface: PHY data interface type
+ *
+ * Returns: rate matching type or negative errno code
+ */
+static int yt8831_get_rate_matching(struct phy_device *phydev,
+				    phy_interface_t iface)
+{
+	int val;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8831_CHIP_MODE_SEL);
+	if (val < 0)
+		return val;
+
+	if (FIELD_GET(YT8831_CHIP_MODE_SEL_MASK, val) ==
+	    YT8831_CHIP_MODE_FORCE_2500BASEX)
+		return RATE_MATCH_PAUSE;
+
+	return RATE_MATCH_NONE;
+}
+
 /**
  * yt861x_config_init() - apply the auto sleep setting to the PHY
  * @phydev: a pointer to a &struct phy_device
@@ -2992,6 +3370,67 @@ static int yt8821_soft_reset(struct phy_device *phydev)
 					  YT8521_CCR_SW_RST, 0);
 }
 
+/**
+ * yt8831_config_init() - phy initializatioin
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8831_config_init(struct phy_device *phydev)
+{
+
+	u8 mode = YT8831_CHIP_MODE_AUTO_BX2500_SGMII;
+	int ret;
+
+
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			phydev->possible_interfaces);
+
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+			phydev->possible_interfaces);
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_2500BASEX:
+		mode = YT8831_CHIP_MODE_FORCE_2500BASEX;
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		mode = YT8831_CHIP_MODE_AUTO_BX2500_SGMII;
+		phydev->rate_matching = RATE_MATCH_NONE;
+		break;
+	default:
+		mode = YT8831_CHIP_MODE_AUTO_BX2500_SGMII;
+		phydev->rate_matching = RATE_MATCH_NONE;
+		break;
+	}
+
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8831_CHIP_MODE_SEL,
+					 YT8831_CHIP_MODE_SEL_MASK,
+					 mode);
+	if (ret < 0)
+		return ret;
+
+	/* Disable broadcast*/
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8831_MDIO_ADDRESS_CTL,
+					 YT8831_MDIO_ADDRESS_CTL_EN_BROADCAST_MASK,
+					 0);
+	if (ret < 0)
+		return ret;
+
+	ret = yt8831_serdes_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = yt8831_utp_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
 /**
  * yt8821_config_init() - phy initializatioin
  * @phydev: a pointer to a &struct phy_device
@@ -3102,6 +3541,55 @@ static void yt8821_update_interface(struct phy_device *phydev)
 	}
 }
 
+/**
+ * yt8831_read_status() -  determines the negotiated speed and duplex
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8831_read_status(struct phy_device *phydev)
+{
+	int ret;
+	int val;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+	if (val & YTPHY_SSR_LINK) {
+		phydev->link = true;
+		yt8821_adjust_status(phydev, val);
+	}
+
+	phydev_dbg(phydev,
+		"%s, phy addr: %d, link %s\n",
+		__func__, phydev->mdio.addr, phydev->link ? "up" : "down");
+
+
+	val = ytphy_read_ext_with_lock(phydev, YT8831_CHIP_MODE_SEL);
+	if (val < 0)
+		return val;
+
+	if (FIELD_GET(YT8831_CHIP_MODE_SEL_MASK, val) ==
+	    YT8831_CHIP_MODE_AUTO_BX2500_SGMII)
+		yt8821_update_interface(phydev);
+
+
+	return 0;
+}
+
 /**
  * yt8821_read_status() -  determines the negotiated speed and duplex
  * @phydev: a pointer to a &struct phy_device
@@ -3190,6 +3678,29 @@ static int yt8821_modify_utp_fiber_bmcr(struct phy_device *phydev,
 					mask, set);
 }
 
+/**
+ * yt8831_suspend() - suspend the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+
+static int yt8831_suspend(struct phy_device *phydev)
+{
+	struct ethtool_wolinfo wol = {0};
+	int ret;
+
+	yt8831_get_wol(phydev, &wol);
+
+	/* if wol enable, do nothing */
+	if (wol.wolopts & WAKE_MAGIC)
+		ret = 0;
+	else
+		ret = genphy_suspend(phydev);
+
+	return ret;
+}
+
 /**
  * yt8821_suspend() - suspend the hardware
  * @phydev: a pointer to a &struct phy_device
@@ -3212,6 +3723,29 @@ static int yt8821_suspend(struct phy_device *phydev)
 	return yt8821_modify_utp_fiber_bmcr(phydev, 0, BMCR_PDOWN);
 }
 
+/**
+ * yt8831_resume() - resume the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8831_resume(struct phy_device *phydev)
+{
+	struct ethtool_wolinfo wol = {0};
+	int ret;
+
+	yt8831_get_wol(phydev, &wol);
+
+	/* if wol enable, do nothing */
+	if (wol.wolopts & WAKE_MAGIC)
+		ret = 0;
+	else
+		ret = genphy_resume(phydev);
+
+	return ret;
+}
+
+
 /**
  * yt8821_resume() - resume the hardware
  * @phydev: a pointer to a &struct phy_device
@@ -3337,11 +3871,28 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend		= yt8821_suspend,
 		.resume			= yt8821_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8831),
+		.name			= "YT8831/YT8821-VD 2.5Gbps PHY",
+		.get_features		= yt8821_get_features,
+		.read_page		= yt8831_read_page,
+		.write_page		= yt8831_write_page,
+		.get_wol		= yt8831_get_wol,
+		.set_wol		= yt8831_set_wol,
+		.config_aneg		= yt8831_config_aneg,
+		.aneg_done		= genphy_aneg_done,
+		.config_init		= yt8831_config_init,
+		.get_rate_matching	= yt8831_get_rate_matching,
+		.read_status		= yt8831_read_status,
+		.soft_reset		= genphy_soft_reset,
+		.suspend		= yt8831_suspend,
+		.resume			= yt8831_resume,
+	},
 };
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821/8831 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
 MODULE_LICENSE("GPL");
-- 
2.43.0

