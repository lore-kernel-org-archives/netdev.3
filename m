Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08983D413C;
	Tue, 21 Jul 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600759; cv=none; b=ox+Mfzu8S25clwT0JzJp2G/Xyyxz+h3T0h67Cy3Efg908NdNFMat8pbTSyhZBiU+7jfJhMofMzRdZP3cwraAXapgJ5Q/6yRaUBfsaxPpCCd+zGMTR5bjLCVtbFpFhcqIQUxJlB+pDlLw5qGKq/maz+QoPX4Maltc2HqBC5upSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600759; c=relaxed/simple;
	bh=aW4pnnwEsjOegqYZ8xxJL6RmKf3t/pU770Nr3GPPCBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwWxZeIh8eHi3i73XB8X9WInJ5Z29ufQWPtaJHt4Xgcvvt6TV//zMvU6tT5Kl2HPzP3RaQXy3Hwmh8qQ4aPH4V8mh2stP8ZZLC8HPeZrh7TCsYkqv9J0KZP7/gUIbEfxFXrmW/52rEwzb08anO0YQewt4Gvcu2SsFLIPwMTw8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=L6Md4+oy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="L6Md4+oy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L2OE1X02860135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784600654;
	bh=ZJlD99uY7K8SFORMYDQxUYt56yHqUHREllniP0yg94g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=L6Md4+oys58A4C7cOoKeuF9Gbjk2/SJIRaKEXzN4hiONAgCU8D6QE/pT+mgrDT+X5
	 aYap3r2IICxbw1bO0lrR4Qm3/ec0xJgxvjhI2mQEHoUpu4Z2zLbmgFKHtIecKKaaxQ
	 kFfyRR3fVTF6VaEPWgc0g3mZfpnNxut217W5pJVi4pVgbujs+RPXQltYsoA/oH04vo
	 A+zic8LW6vQQufrRP5cRRenoxVMPqna6QZgc9PPH3kyU4MlAyR4guqrFGGgZPzuhH7
	 XCfRzHOQR8TJk1KSPniDTuy/7Xz8kAXcDEEv7yruNLQWn0WVjvf8wSMgTxtwYyXJuo
	 +79B1JpFGeP4w==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L2OE1X02860135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 10:24:14 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:24:12 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 10:24:12 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 2/5] net: phy: c45: add setup and read master/slave helpers
Date: Tue, 21 Jul 2026 10:24:07 +0800
Message-ID: <20260721022410.1391-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260721022410.1391-1-javen_xu@realsil.com.cn>
References: <20260721022410.1391-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds two static helpers in drivers/net/phy/phy-c45.c to
configure and read back master-slave roles for non BASE-T1 Clause 45
PHYs via the 10GBASE-T AN control/status registers.
These helpers are wired into genphy_c45_config_aneg() and
genphy_c45_read_status(). This changes the observable ethtool output
for drivers using the generic c45 read path.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes, new file

Changes in v3:
 - re-order function according to the order in phy-c45.c
 - add kernel-doc about return value
 - add MASTER_SLAVE_CFG_MASTER_PREFERRED,
   MASTER_SLAVE_CFG_SLAVE_PREFERRED, MASTER_SLAVE_CFG_UNKNOWN,
   MASTER_SLAVE_CFG_UNSUPPORTED, MASTER_SLAVE_CFG_SLAVE_PREFERRED cfg

Changes in v4:
 - no changes

Changes in v5:
 - move genphy_c45_an_setup_master_slave() to genphy_c45_config_aneg(),
   as that C22 does.

Changes in v6:
 - add colon in the function description
 - add genphy_c45_read_master_slave in read function

Changes in v7:
 - when phydev->link is down, just return UNKNOWN
 - modify commit message

Changes in v8:
 - no changes

Changes in v9:
 - no changes

Changes in v10:
 - no changes. Netdev queue overflow. Resend.
---
 drivers/net/phy/phy-c45.c | 103 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mdio.h |   5 ++
 2 files changed, 108 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c1f817a59739..870920311f9a 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -406,6 +406,97 @@ int genphy_c45_pma_soft_reset(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_pma_soft_reset);
 
+/**
+ * genphy_c45_an_setup_master_slave - Configure Master/Slave setting for C45 PHYs
+ * @phydev: target phy_device struct
+ *
+ * Description: Configure the forced or preferred Master/Slave role
+ * 10GBASE-T control register (MMD 7, Register 0x0020) according to
+ * IEEE 802.3 standards.
+ *
+ * Return: negative errno code on failure, 0 if Master/Slave didn't change,
+ * or 1 if Master/Slave modes changed.
+ */
+static int genphy_c45_an_setup_master_slave(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+		ctl = MDIO_AN_10GBT_CTRL_MS_PORT_TYPE;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+		break;
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		ctl = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		ctl = MDIO_AN_10GBT_CTRL_MS_ENABLE;
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+		return 0;
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	return phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				      MDIO_AN_10GBT_CTRL_MS_ENABLE |
+				      MDIO_AN_10GBT_CTRL_MS_VALUE |
+				      MDIO_AN_10GBT_CTRL_MS_PORT_TYPE, ctl);
+}
+
+/**
+ * genphy_c45_read_master_slave - read master/slave status
+ * @phydev: target phy_device struct
+ *
+ * Description: Read the Master/Slave configuration and status
+ * from 10GBASE-T control/status registers (MMD 7, Reg 0x0020 and 0x0021).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int genphy_c45_read_master_slave(struct phy_device *phydev)
+{
+	int val;
+
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_AN_10GBT_CTRL_MS_ENABLE) {
+		if (val & MDIO_AN_10GBT_CTRL_MS_VALUE)
+			phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
+		else
+			phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
+	} else {
+		if (val & MDIO_AN_10GBT_CTRL_MS_PORT_TYPE)
+			phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_PREFERRED;
+		else
+			phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_PREFERRED;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_AN_10GBT_STAT_MS_FAULT) {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_ERR;
+	} else if (phydev->link) {
+		if (val & MDIO_AN_10GBT_STAT_MS_RES)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+		else
+			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+	} else {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+	}
+
+	return 0;
+}
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
@@ -1214,6 +1305,10 @@ int genphy_c45_read_status(struct phy_device *phydev)
 			ret = genphy_c45_baset1_read_status(phydev);
 			if (ret < 0)
 				return ret;
+		} else {
+			ret = genphy_c45_read_master_slave(phydev);
+			if (ret < 0)
+				return ret;
 		}
 
 		phy_resolve_aneg_linkmode(phydev);
@@ -1247,6 +1342,14 @@ int genphy_c45_config_aneg(struct phy_device *phydev)
 	if (ret > 0)
 		changed = true;
 
+	if (!genphy_c45_baset1_able(phydev)) {
+		ret = genphy_c45_an_setup_master_slave(phydev);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			changed = true;
+	}
+
 	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 EXPORT_SYMBOL_GPL(genphy_c45_config_aneg);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..06f4bc3c20c7 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,8 +332,13 @@
 #define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
+#define MDIO_AN_10GBT_CTRL_MS_ENABLE	0x8000	/* Master/slave manual config enable */
+#define MDIO_AN_10GBT_CTRL_MS_VALUE	0x4000	/* Master/slave config value (1=Master) */
+#define MDIO_AN_10GBT_CTRL_MS_PORT_TYPE	0x2000	/* Master Preferred Type */
 
 /* AN 10GBASE-T status register. */
+#define MDIO_AN_10GBT_STAT_MS_FAULT	0x8000	/* Master/slave fault */
+#define MDIO_AN_10GBT_STAT_MS_RES	0x4000	/* Master/slave resolution (1=Master) */
 #define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
 #define MDIO_AN_10GBT_STAT_LP5G		0x0040  /* LP is 5GBT capable */
 #define MDIO_AN_10GBT_STAT_LPTRR	0x0200	/* LP training reset req. */
-- 
2.43.0

