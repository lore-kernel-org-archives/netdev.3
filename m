Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149F47124E;
	Tue, 15 Sep 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460540; cv=none; b=LobxNZwWxbQ/g6PyHR081eVN1xj8tO0Wtc5dpejatGQTfLjYYxqOPtS9UFtaRnpl9x5mhoJuZk/VM+/cHAtCQ4eWMEP1IzbAR2gHRV5NUHoU1zAOxfdT+RgG6q1p8FOjIkuvSlANTX/y5HevhdO2vCXMbDFM8C342fEHTxUtCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460540; c=relaxed/simple;
	bh=xpQAnP2qYiMkdwIAcRJvfxKSIPjCZqjy79L4p16fJ6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQRXj3ULv844HPVSjGDyfarY6hRWh4rQ47hseHYSExe4tBHdNk7XsZ+Q58XuQ8JHjHV60OP9vz51VV1UD4sQba7cVmALOvkVawt/3DnZPvXi0aGn53TIrBAE6hnW0kimlRdwJT8OUfU9vM+xJ6IEB+gFKz2AcD1lVOgHHxh19Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0108436-0.15722-0.831936;FP=16769534167555263730|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jE.2dpQ_1789460520;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jE.2dpQ_1789460520 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 16:22:01 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v18 3/3] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Tue, 15 Sep 2026 16:21:52 +0800
Message-Id: <20260915082152.3104633-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
motorcomm driver, using the phy_package helpers for the shared top
extended register space

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/phy/Kconfig     |    3 +-
 drivers/net/phy/motorcomm.c | 1571 ++++++++++++++++++++++++++++++++++-
 2 files changed, 1571 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d3835597e379..996d75afed44 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -361,9 +361,10 @@ config MICROSEMI_PHY
 
 config MOTORCOMM_PHY
 	tristate "Motorcomm PHYs"
+	select PHY_PACKAGE
 	help
 	  Enables support for Motorcomm network PHYs.
-	  Currently supports YT85xx Gigabit Ethernet PHYs.
+	  Currently supports YT85xx Gigabit Ethernet PHYs and YT8824 4 * 2.5G PHY.
 
 config NATIONAL_PHY
 	tristate "National Semiconductor PHYs"
diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 90a4f86f2758..b60948c9ce88 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,24 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/8821/8824 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
+ * Author: Kyle <kyle.switch@motor-comm.com>
  */
 
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
+#include <linux/mdio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/property.h>
 
+#include "phylib.h"
+
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
 #define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
 #define PHY_ID_YT8821		0x4f51ea19
+#define PHY_ID_YT8824		0x4f51e8b8
 /* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
@@ -30,6 +37,18 @@
  *  ------------------------------------------------------------
  */
 
+/* YT8824 Register Overview
+ * UTP Register space | USXGMII Register space
+ *  ------------------------------------------------------------
+ * | UTP MII		| USXGMII MII		|
+ * | UTP MMD		|			|
+ * | UTP Extended	| USXGMII Extended	|
+ * | UTP Top Extended	| USXGMII Top Extended	|
+ *  ------------------------------------------------------------
+ * |   Common Top Extended			|
+ *  ------------------------------------------------------------
+ */
+
 /* 0x10 ~ 0x15 , 0x1E and 0x1F are common MII registers of yt phy */
 
 /* Specific Function Control Register */
@@ -381,6 +400,13 @@
 #define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
 #define YT8821_CHIP_MODE_FORCE_BX2500		1
 
+#define YT8824_RSSR_SPACE_MASK			BIT(0)
+#define YT8824_RSSR_USXGMII_SPACE		(0x1)
+#define YT8824_RSSR_UTP_SPACE			(0x0)
+#define YT8824_SDS_CFG_MIN_PRE_MASK		GENMASK(3, 0)
+#define YT8824_SDS_EN_FILL_PRE			BIT(13)
+#define YT8824_SDS_TX_PRE_PADDING		(0x7)
+
 struct yt8521_priv {
 	/* combo_advertising is used for case of YT8521 in combo mode,
 	 * this means that yt8521 may work in utp or fiber mode which depends
@@ -399,6 +425,12 @@ struct yt8521_priv {
 	u8 reg_page;
 };
 
+struct yt8824_shared_priv {
+	phy_interface_t interface_mode;
+	/* shared_lock used to UTPs operation isolation during swap reg space */
+	struct mutex shared_lock;
+};
+
 /**
  * ytphy_read_ext() - read a PHY's extended register
  * @phydev: a pointer to a &struct phy_device
@@ -437,6 +469,70 @@ static int ytphy_read_ext_with_lock(struct phy_device *phydev, u16 regnum)
 	return ret;
 }
 
+/**
+ * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @regnum: register number to read
+ *
+ * Returns: the value of regnum reg or negative error code
+ */
+static int ytphy_read_top_ext(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
+	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return __phy_package_read(phydev, 0, YTPHY_PAGE_DATA);
+}
+
+/**
+ * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @regnum: register number to write
+ * @val: register val to write
+ *
+ * Returns: 0 or negative error code
+ */
+static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
+			       u16 val)
+{
+	int ret;
+
+	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
+	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);
+}
+
+/**
+ * phy8824_page_write_with_lock() - write page for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @page: reg page(YT8824_RSSR_USXGMII_SPACE/YT8824_RSSR_UTP_SPACE).
+ *
+ * Returns: 0 or negative error code
+ */
+static int phy8824_page_write_with_lock(struct phy_device *phydev, int page)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (ret < 0)
+		goto err;
+	ret &= ~YT8824_RSSR_SPACE_MASK;
+	ret |= (page & YT8824_RSSR_SPACE_MASK);
+	ret = ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, ret);
+
+err:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 /**
  * ytphy_write_ext() - write a PHY's extended register
  * @phydev: a pointer to a &struct phy_device
@@ -633,6 +729,1048 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 	return phy_restore_page(phydev, old_page, ret);
 }
 
+/**
+ * yt8824_read_page() - read PHY8824 reg page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: current reg space of yt8824 (YT8824_RSSR_USXGMII_SPACE/
+ * YT8824_RSSR_UTP_SPACE) or negative errno code
+ */
+static int yt8824_read_page(struct phy_device *phydev)
+{
+	int old_page;
+
+	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+
+	return old_page & YT8824_RSSR_SPACE_MASK;
+};
+
+/**
+ * yt8824_write_page() - write reg page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: Reg page(YT8824_RSSR_USXGMII_SPACE/YT8824_RSSR_UTP_SPACE) to write.
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_write_page(struct phy_device *phydev, int page)
+{
+	int old_page;
+	u16 data;
+
+	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+	data = old_page & (~YT8824_RSSR_SPACE_MASK);
+	data |= page;
+
+	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);
+};
+
+/**
+ * yt8824_utp_invalid_test_mode_paged() - config YT8824 to invalid test mode.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_invalid_test_mode_paged(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return genphy_c45_template_testmode
+		(phydev, MDIO_PMA_10GBT_TESTMODE_1);
+}
+
+/**
+ * yt8824_sds_isolate_paged() - enable YT8824 serdes isolate.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_sds_isolate_paged(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_USXGMII_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* enable sds isolate */
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_ISOLATE, BMCR_ISOLATE);
+
+err_restore_page:
+	/* restore page, release the lock */
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_utp_softreset_paged() - config YT8824 UTP softreset.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_softreset_paged(struct phy_device *phydev)
+{
+	int ret = 0;
+	int val;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
+	if (ret < 0)
+		return ret;
+	/* wait until softreset done. */
+	return phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				     50000, 600000, true);
+}
+
+/**
+ * yt8824_utp_normal_test_mode_paged() - config YT8824 to normal test mode.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_normal_test_mode_paged(struct phy_device *phydev)
+{
+	int ret = 0;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return genphy_c45_template_testmode(phydev,
+					    MDIO_PMA_10GBT_TESTMODE_NORMAL);
+}
+
+/**
+ * yt8824_sds_isolate_and_softreset_paged() - disable YT8824 serdes isolate
+ * and sds softreset.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_sds_isolate_and_softreset_paged(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int val = 0;
+	int ret = -1;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_USXGMII_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* sds softreset and disable isolate */
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ISOLATE,
+			   BMCR_RESET & ~BMCR_ISOLATE);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* poll while still holding the lock */
+	ret = read_poll_timeout(__phy_read, val,
+				(val < 0) || !(val & BMCR_RESET), 50000, 600000,
+				true, phydev, MII_BMCR);
+	if (val < 0)
+		ret = val;
+
+err_restore_page:
+	/* restore page, release the lock */
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_restore_working_status() - called to do store working status
+ * @phydev: a pointer to a &struct phy_device
+ * @ret: operation's return code
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_restore_working_status(struct phy_device *phydev, int ret)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int r;
+
+	/* configure normal test mode */
+	r = yt8824_utp_normal_test_mode_paged(phydev);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	if (priv->interface_mode != PHY_INTERFACE_MODE_INTERNAL) {
+		/* sds soft reset and disable isolation */
+		r = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret >= 0 && r < 0)
+			ret = r;
+	}
+
+	return ret;
+}
+
+/**
+ * yt8824_soft_reset() - called to do PHY software reset
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_soft_reset(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		/* invalid test mode */
+		ret = yt8824_utp_invalid_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+		ret = yt8824_utp_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+		/* normal mode */
+		ret = yt8824_utp_normal_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	} else {
+		/* invalid test mode */
+		ret = yt8824_utp_invalid_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* sds isolation */
+		ret = yt8824_sds_isolate_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* utp soft reset */
+		ret = yt8824_utp_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* normal mode */
+		ret = yt8824_utp_normal_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* sds soft reset and disable isolation */
+		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	}
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+retry:
+	ret = yt8824_restore_working_status(phydev, ret);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_extern_config_utp_init_paged() - config external phy8824 utp init
+ * @phydev: target phy_device struct
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_extern_config_utp_init_paged(struct phy_device *phydev)
+{
+	int ret = 0;
+	int val = 0;
+	int r;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+	/* power down */
+	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+	if (ret < 0)
+		goto err_restore;
+
+	/* pll calibration */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0001, 0x0003);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa20e, 0x0cba);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa20a, 0xc3f1);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa20c, 0x1620);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2b6, 0x0a00);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2b6, 0x0e00);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimization utp */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0001, 0x0003);
+	if (ret < 0)
+		goto err_restore;
+
+	/* enable nibble */
+	ret = ytphy_write_ext_with_lock(phydev, 0xa003, 0x0003);
+	if (ret < 0)
+		goto err_restore;
+
+	/* idle err detect enable */
+	ret = ytphy_write_ext_with_lock(phydev, 0x03d0, 0x5210);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 2.5G long cable performance */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0372, 0x5038);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x037c, 0x6068);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0388, 0x00a0);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized fast retrain */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0359, 0x2140);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x000c, 0xc1a0);
+	if (ret < 0)
+		goto err_restore;
+
+	/* 2.5G template tone */
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2fa, 0x0083);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x04e2, 0x0149);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 2.5G template */
+	ret = ytphy_write_ext_with_lock(phydev, 0x047e, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x047f, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0480, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0481, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 1000M cable length threshold */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0336, 0xab0a);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0340, 0x301d);
+	if (ret < 0)
+		goto err_restore;
+
+	/* 100M template amplitude */
+	ret = ytphy_write_ext_with_lock(phydev, 0x046e, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x046f, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0470, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0471, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 100M cable length threshold */
+	ret = ytphy_write_ext_with_lock(phydev, 0x030b, 0xaa1d);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x071f, 0x0036);
+	if (ret < 0)
+		goto err_restore;
+
+	/* 10M template amplitude */
+	ret = ytphy_write_ext_with_lock(phydev, 0x046b, 0x1818);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x046c, 0x1818);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 10M cable length threshold */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0466, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0467, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0468, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0469, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimize utp 1000M performance */
+	ret = ytphy_write_ext_with_lock(phydev, 0x034a, 0xff03);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x00f8, 0xb3ff);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0059, 0x4040);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x032c, 0x5094);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x032d, 0xd094);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x032e, 0x5308);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x0322, 0x6440);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x04d3, 0x5220);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x04d2, 0x5220);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized EMC CS */
+	ret = ytphy_write_ext_with_lock(phydev, 0x00c8, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x00be, 0x6406);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x037a, 0x40ff);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized EMC RE */
+	ret = ytphy_write_ext_with_lock(phydev, 0x0482, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d5, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d6, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d7, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d8, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa218, 0x006e);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01d, 0xfff0);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01e, 0xfff0);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01d, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01e, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+
+	ret = genphy_c45_template_testmode(phydev, MDIO_PMA_10GBT_TESTMODE_1);
+	if (ret < 0)
+		goto err_restore_normal;
+	/* reset */
+	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE,
+			 BMCR_RESET | BMCR_ANENABLE);
+	if (ret < 0)
+		goto err_restore_normal;
+	ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				    50000, 600000, true);
+	if (ret < 0)
+		goto err_restore_normal;
+
+	ret = genphy_c45_template_testmode(phydev,
+					   MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret < 0)
+		goto err_restore_normal;
+	return 0;
+
+err_restore:
+	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	return ret;
+
+err_restore_normal:
+	r = genphy_c45_template_testmode(phydev,
+					 MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	return ret;
+}
+
+/**
+ * yt8824_extern_config_sds_init_paged() - config external phy8824 sds init
+ * @phydev: target phy_device struct
+ *
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_extern_config_sds_init_paged(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int val_1, val_2, val_3, tmp;
+	int ret = -1;
+	int val;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_USXGMII_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* read efuse */
+	ret = ytphy_read_top_ext(phydev, 0xa13e);
+	if (ret < 0)
+		goto err_restore_page;
+	else
+		val_1 = ret;
+
+	ret = ytphy_read_top_ext(phydev, 0xa13f);
+	if (ret < 0)
+		goto err_restore_page;
+	else
+		val_2 = ret;
+
+	ret = ytphy_read_top_ext(phydev, 0xa140);
+	if (ret < 0)
+		goto err_restore_page;
+	else
+		val_3 = ret;
+
+	/* Serdes optimization */
+	ret = ytphy_write_ext(phydev, 0x04be, 0x000d);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x049f, 0x7ded);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x04a9, 0x009f);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* analog CDR */
+	ret = ytphy_write_ext(phydev, 0x0406, 0x0800);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized VCO */
+	ret = ytphy_write_ext(phydev, 0x0438, 0x9024);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x0439, 0x00c0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized PLL lock */
+	ret = ytphy_read_ext(phydev, 0x0429);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(13) | BIT(12));
+	tmp = (val_1 & (BIT(7) | BIT(6))) >> 6;
+	ret |= (tmp << 12);
+	ret = ytphy_write_ext(phydev, 0x0429, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_read_ext(phydev, 0x0441);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(1) | BIT(0));
+	tmp = (val_1 & (BIT(5) | BIT(4))) >> 4;
+	ret |= tmp;
+	ret = ytphy_write_ext(phydev, 0x0441, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_read_ext(phydev, 0x042b);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(13) | BIT(12));
+	tmp = (val_3 & (BIT(1) | BIT(0)));
+	ret |= (tmp << 12);
+	ret = ytphy_write_ext(phydev, 0x042b, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x043a, 0x1006);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x042a, 0xf070);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* cable length threshold */
+	ret = ytphy_write_ext(phydev, 0x0491, 0x007f);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x0492, 0x7f7f);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Serdes training threshold */
+	ret = ytphy_write_ext(phydev, 0x0454, 0x0f14);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x0497, 0x0a44);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* digital eye diagram of SerDes */
+	ret = ytphy_write_ext(phydev, 0x04cd, 0x0000);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Serdes LDO */
+	ret = ytphy_read_ext(phydev, 0x04b5);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(6) | BIT(5) | BIT(4));
+	tmp = (val_2 & (BIT(4) | BIT(3) | BIT(2))) >> 2;
+	ret |= (tmp << 4);
+	ret = ytphy_write_ext(phydev, 0x04b5, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_read_ext(phydev, 0x04b4);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(10) | BIT(9) | BIT(8));
+	tmp = (val_2 & (BIT(7) | BIT(6) | BIT(5))) >> 5;
+	ret |= (tmp << 8);
+	ret = ytphy_write_ext(phydev, 0x04b4, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized Serdes RX */
+	ret = ytphy_write_ext(phydev, 0x04af, 0x45e3);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x048a, 0x0fff);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x0408, 0x7c00);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x04d6, 0x007f);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x044f, 0xff08);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized Serdes TX */
+	ret = ytphy_write_ext(phydev, 0x048e, 0x7d00);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x000d, 0x0606);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Serdes manual config */
+	ret = ytphy_write_ext(phydev, 0x04b0, 0x0804);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x04b1, 0x7074);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x04af, 0x45e7);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* restart calibration */
+	ret = ytphy_write_ext(phydev, 0x0003, 0x5603);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x0492, 0x7fff);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x0492, 0x7f7f);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x2000, 0x0040);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, 0x2000, 0x0000);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* TX preamble padded to 8; RX IPG always > 8 */
+	ret = __phy_read(phydev, MII_RESV1);
+	if (ret < 0)
+		goto err_restore_page;
+	ret &= ~YT8824_SDS_CFG_MIN_PRE_MASK;
+	ret |= YT8824_SDS_TX_PRE_PADDING;
+	ret |= YT8824_SDS_EN_FILL_PRE;
+	ret = __phy_write(phydev, MII_RESV1, ret);
+	if (ret < 0)
+		goto err_restore_page;
+	/* reset serdes */
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE,
+			   BMCR_RESET | BMCR_ANENABLE);
+	if (ret < 0)
+		goto err_restore_page;
+	/* poll while still holding the lock; __phy_read takes no lock */
+	ret = read_poll_timeout(__phy_read, val,
+				(val < 0) || !(val & BMCR_RESET), 50000, 600000,
+				true, phydev, MII_BMCR);
+	if (val < 0)
+		ret = val;
+err_restore_page:
+	/* restore page, release the lock */
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_internal_config_init_paged() - config internal phy8824 init
+ * @phydev: target phy_device struct
+ *
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_internal_config_init_paged(struct phy_device *phydev)
+{
+	int ret = 0;
+	int val = 0;
+	int r = 0;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	ret = ytphy_write_ext_with_lock(phydev, 0x1, 0x3);
+	if (ret < 0)
+		return ret;
+	/* power down */
+	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa20e, 0xcba);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa20a, 0xc3f1);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa20c, 0x1620);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2b6, 0xa00);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2b6, 0xe00);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa003, 0x3);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x3d0, 0x5210);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x372, 0x5038);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x37c, 0x6068);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x388, 0xa0);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x359, 0x2140);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2fa, 0x83);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x4e2, 0x149);
+	if (ret < 0)
+		goto err_restore;
+	/* 2.5G tempate */
+	ret = ytphy_write_ext_with_lock(phydev, 0x47e, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x47f, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x480, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x481, 0x3939);
+	if (ret < 0)
+		goto err_restore;
+	/* 1000 cable length threshold */
+	ret = ytphy_write_ext_with_lock(phydev, 0x336, 0xab0a);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x340, 0x301d);
+	if (ret < 0)
+		goto err_restore;
+	/* 1000 performance */
+	ret = ytphy_write_ext_with_lock(phydev, 0x34a, 0xff03);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xf8, 0xb3ff);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x32c, 0x5094);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x32d, 0xd094);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x32e, 0x5308);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x322, 0x6440);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x4d3, 0x5220);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x4d2, 0x5220);
+	if (ret < 0)
+		goto err_restore;
+	/* 100 tempate */
+	ret = ytphy_write_ext_with_lock(phydev, 0x46e, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x46f, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x470, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x471, 0x4545);
+	if (ret < 0)
+		goto err_restore;
+	/* 100 cable length threshold */
+	ret = ytphy_write_ext_with_lock(phydev, 0x30b, 0xaa1d);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x71f, 0x36);
+	if (ret < 0)
+		goto err_restore;
+	/* 10 tempate */
+	ret = ytphy_write_ext_with_lock(phydev, 0x46b, 0x1818);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x46c, 0x1818);
+	if (ret < 0)
+		goto err_restore;
+	/* 10 tempate MAU*/
+	ret = ytphy_write_ext_with_lock(phydev, 0x466, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x467, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x468, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x469, 0x6c6c);
+	if (ret < 0)
+		goto err_restore;
+	/* EMC CS, Inconsistent with external phy */
+	ret = ytphy_write_ext_with_lock(phydev, 0xc8, 0xfff);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xbe, 0x6406);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0x37a, 0x40ff);
+	if (ret < 0)
+		goto err_restore;
+	/* EMC RE*/
+	ret = ytphy_write_ext_with_lock(phydev, 0x482, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d5, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d6, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d7, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa2d8, 0x1f1f);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa218, 0x6e);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01d, 0xfff0);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01e, 0xfff0);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01d, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xa01e, 0xffff);
+	if (ret < 0)
+		goto err_restore;
+	ret = ytphy_write_ext_with_lock(phydev, 0xc, 0x41a1);
+	if (ret < 0)
+		goto err_restore;
+	ret = genphy_c45_template_testmode(phydev, MDIO_PMA_10GBT_TESTMODE_1);
+	if (ret)
+		goto err_restore_normal;
+	/* reset */
+	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE,
+			 BMCR_RESET | BMCR_ANENABLE);
+	if (ret < 0)
+		goto err_restore_normal;
+	ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				    50000, 600000, true);
+	if (ret < 0)
+		goto err_restore_normal;
+
+	ret = genphy_c45_template_testmode(phydev,
+					   MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret < 0)
+		goto err_restore_normal;
+
+	return 0;
+
+err_restore:
+	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	return ret;
+
+err_restore_normal:
+	r = genphy_c45_template_testmode(phydev,
+					 MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	return ret;
+}
+
+/**
+ * yt8824_config_init() - phy initializatioin
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_config_init(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		ret = yt8824_internal_config_init_paged(phydev);
+		if (ret < 0)
+			goto err;
+	} else {
+		ret = yt8824_extern_config_sds_init_paged(phydev);
+		if (ret < 0)
+			goto err;
+		ret = yt8824_extern_config_utp_init_paged(phydev);
+		if (ret < 0)
+			goto err;
+	}
+	mutex_unlock(&priv->shared_lock);
+	ret = yt8824_soft_reset(phydev);
+
+	phydev_dbg(phydev, "%s done, phy addr: %d\n", __func__,
+		   phydev->mdio.addr);
+	return ret;
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
 static int yt8531_set_wol(struct phy_device *phydev,
 			  struct ethtool_wolinfo *wol)
 {
@@ -3104,6 +4242,418 @@ static int yt8821_resume(struct phy_device *phydev)
 	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
 }
 
+/**
+ * yt8824_get_features - read mmd register to get 2.5G capability
+ * @phydev: target phy_device struct
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_get_features(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err;
+	ret = yt8821_get_features(phydev);
+
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
+/**
+ * yt8824_aneg_done()  - check negotiation state.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: link status or negative errno code
+ */
+static int yt8824_aneg_done(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int link = 0;
+	int ret = 0;
+
+	mutex_lock(&priv->shared_lock);
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err;
+
+	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	if (ret < 0)
+		goto err;
+	mutex_unlock(&priv->shared_lock);
+	link = !!(ret & YTPHY_SSR_LINK);
+
+	phydev_dbg(phydev, "%s, phy addr: %d, link_utp: %d\n", __func__,
+		   phydev->mdio.addr, link);
+	return link;
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
+/**
+ * yt8824_read_status_paged() -  determines the speed and duplex of one page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_read_status_paged(struct phy_device *phydev)
+{
+	int link = 0;
+	int ret = 0;
+	int val = 0;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (phydev->autoneg_complete) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	link = val & YTPHY_SSR_LINK;
+	if (link)
+		yt8821_adjust_status(phydev, val);
+
+	if (link) {
+		if (phydev->link == 0)
+			phydev_dbg(phydev, "%s, phy addr: %d, link up\n",
+				   __func__, phydev->mdio.addr);
+		phydev->link = 1;
+	} else {
+		if (phydev->link == 1)
+			phydev_dbg(phydev, "%s, phy addr: %d, link down\n",
+				   __func__, phydev->mdio.addr);
+		phydev->link = 0;
+	}
+	phy_resolve_aneg_pause(phydev);
+	return 0;
+}
+
+/**
+ * yt8824_read_status() -  determines the negotiated speed and duplex
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_read_status(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = yt8824_read_status_paged(phydev);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_utp_power_on(): utp power on.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_power_on(struct phy_device *phydev)
+{
+	int ret = 0;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0x0);
+}
+
+/**
+ * yt8824_utp_power_down(): utp power down.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_power_down(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+}
+
+/**
+ * yt8824_power_on()  - set utp power on.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * NOTE: need WA like softreset
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_power_on(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+	int r;
+
+	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		/* invalid test mode */
+		ret = yt8824_utp_invalid_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+		/* utp power on */
+		ret = yt8824_utp_power_on(phydev);
+		if (ret < 0)
+			goto retry;
+		/* normal mode */
+		ret = yt8824_utp_normal_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	} else {
+		/* invalid test mode */
+		ret = yt8824_utp_invalid_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* sds isolation */
+		ret = yt8824_sds_isolate_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* utp power on */
+		ret = yt8824_utp_power_on(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* normal mode */
+		ret = yt8824_utp_normal_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* sds soft reset and disable isolation */
+		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	}
+	return 0;
+
+retry:
+	/*
+	 * If the PHY up operation succeeds but the subsequent operation
+	 * fails, revert to the default state.
+	 */
+	r = yt8824_utp_power_down(phydev);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	ret = yt8824_restore_working_status(phydev, ret);
+	return ret;
+}
+
+/**
+ * yt8824_resume() - resume the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_resume(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = yt8824_power_on(phydev);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_power_down()  - set utp power down.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * NOTE: need WA like softreset
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_power_down(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+	int r;
+
+	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		/* invalid test mode */
+		ret = yt8824_utp_invalid_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+		/* utp power down */
+		ret = yt8824_utp_power_down(phydev);
+		if (ret < 0)
+			goto retry;
+		/* normal mode */
+		ret = yt8824_utp_normal_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	} else {
+		/* invalid test mode */
+		ret = yt8824_utp_invalid_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* sds isolation */
+		ret = yt8824_sds_isolate_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* utp power down */
+		ret = yt8824_utp_power_down(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* normal mode */
+		ret = yt8824_utp_normal_test_mode_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		/* sds soft reset and disable isolation */
+		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	}
+	return 0;
+
+retry:
+	/*
+	 * If the PHY down operation succeeds but the subsequent operation
+	 * fails, revert to the default state.
+	 */
+	r = yt8824_utp_power_on(phydev);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	ret = yt8824_restore_working_status(phydev, ret);
+	return ret;
+}
+
+/**
+ * yt8824_suspend() - suspend the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_suspend(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = yt8824_power_down(phydev);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_config_aneg() - config negotiation
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_config_aneg(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int phy_ctrl = 0;
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
+	if (ret < 0)
+		goto err;
+
+	ret = __genphy_config_aneg(phydev, ret);
+
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
+/**
+ * yt8824_phy_package_probe_once()  - init phy package for phy8824.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_phy_package_probe_once(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	struct device_node *np = phy_package_get_node(phydev);
+	int res;
+
+	if (!priv || !np) {
+		phydev_err(phydev, "%s: missing shared priv or DT node\n",
+			   __func__);
+		return -EINVAL;
+	}
+	/* Initialise shared lock for YT8824 */
+	mutex_init(&priv->shared_lock);
+	res = of_get_phy_mode(np, &priv->interface_mode);
+	if (res < 0) {
+		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n", __func__);
+		priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
+	}
+
+	return 0;
+}
+
+/**
+ * yt8824_probe() - phy8824 probe.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct yt8824_shared_priv *shared_priv;
+	int ret;
+
+	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
+	if (ret)
+		return ret;
+
+	if (phy_package_probe_once(phydev)) {
+		ret = yt8824_phy_package_probe_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static struct phy_driver motorcomm_phy_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
@@ -3190,13 +4740,29 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend		= yt8821_suspend,
 		.resume			= yt8821_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8824),
+		.name = "YT8824 Quad Ports 2.5Gbps Ethernet",
+		.get_features = yt8824_get_features,
+		.read_page = yt8824_read_page,
+		.write_page = yt8824_write_page,
+		.probe = yt8824_probe,
+		.config_aneg = yt8824_config_aneg,
+		.aneg_done = yt8824_aneg_done,
+		.config_init = yt8824_config_init,
+		.read_status = yt8824_read_status,
+		.soft_reset = yt8824_soft_reset,
+		.suspend = yt8824_suspend,
+		.resume = yt8824_resume,
+	},
 };
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821/8824 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
+MODULE_AUTHOR("Kyle");
 MODULE_LICENSE("GPL");
 
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
@@ -3206,6 +4772,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8824) },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

