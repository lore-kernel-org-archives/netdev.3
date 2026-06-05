Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DE481FCA;
	Fri,  5 Jun 2026 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645497; cv=none; b=TKlyMXI/R9CqmJj1hybdK0h0+5oZ1bDwVa4RjdH6gqysfmDfs2uLyodODJuxnsNZuOK7DALKQzr7cwx8vx88/emDDpAf7UNT0R1rW+B9CpzW3qqDjWfs2JhdWGFUNhyZYDYXehHWLXp1XPEOTgieXvqaULjCubkovjRKCOrDsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645497; c=relaxed/simple;
	bh=T4B7H85vrvd5LrFha4O8snmkpPt3uAYMiFPtIBi1GXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzGuRFM6/Y5btDk2Xjug38AmxFnzudQ7qwu1ZGxwT2Q9bq/cEuv/NOryKmPaCR47EozPES5CV5JQPufTBS/UF/sTFRgnOU1snnilKVH5QuoZS7BB4+5oTAiBq2fmdzJ5CEnp04yPvT5pUkuIfqKGTw5lPmaERMWqIdfxvS96uv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WSSGsK92; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="WSSGsK92"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6557hUeW51221753, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780645411;
	bh=nWzts/H4wwuI5TljBKGOGaj/2CwHAdU2rSYQgB7LJbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WSSGsK92N/CcWIPxdkM/o04OoQGctJ+JaYSZQaenAVR9BZiretChwtzPSugQoJiiL
	 sSS1MEIiJ5o3iMuJl/0MwAffodmVxiRGgqrzxPGgFT7llcC9DGtsgdBgemah6v7zJB
	 lAnwT/g/oViD6AM35TAAM5LiLHnbEIO+1h5i45NY9/j6UqY7Mq0TlYj6Ocddx8NSUR
	 cOr5FxQVoEM+cU11N14ftvW5UcoGOYEW08BE5LYnR1leT3I0qBwVR7Brqtr387Yj5X
	 Yc21sd5iRP2cRdsnrBKB8t1GqJ8JvaZzkAybPAa9BoeB3XIrIDJ3jDRD8QyFUGtblO
	 yUt6sfx6ihdyw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6557hUeW51221753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 15:43:31 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 15:43:31 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Jun 2026 15:43:31 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 2/4] net: phy: c45: add genphy_c45_an_setup_master_slave()
Date: Fri, 5 Jun 2026 15:43:26 +0800
Message-ID: <20260605074328.1800-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260605074328.1800-1-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add a generic helper to configure forced master/slave mode for Clause 45
PHYs using the 10GBASE-T AN control register.

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
---
 drivers/net/phy/phy-c45.c | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 include/uapi/linux/mdio.h |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d8a83179ec40..28cb173ff7aa 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -406,6 +406,48 @@ int genphy_c45_soft_reset(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);
 
+/**
+ * genphy_c45_an_setup_master_slave - Configure Master/Slave setting for C45 PHYs
+ * @phydev: target phy_device struct
+ *
+ * Description: Configure the forced or preferred Master/Slave role
+ * 10GBASE-T control register (MMD 7, Register 0x0020) according to
+ * IEEE 802.3 standards.
+ *
+ * Returns negative errno code on failure, 0 if Master/Slave didn't change,
+ * or 1 if Master/Slave modes changed.
+ */
+int genphy_c45_an_setup_master_slave(struct phy_device *phydev)
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
+EXPORT_SYMBOL_GPL(genphy_c45_an_setup_master_slave);
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 25a66320df56..a46f4d9a6155 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2310,6 +2310,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
 int genphy_c45_soft_reset(struct phy_device *phydev);
+int genphy_c45_an_setup_master_slave(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..ffca03fd82c9 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,6 +332,9 @@
 #define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
+#define MDIO_AN_10GBT_CTRL_MS_ENABLE	0x8000	/* Master/slave manual config enable */
+#define MDIO_AN_10GBT_CTRL_MS_VALUE	0x4000	/* Master/slave config value (1=Master) */
+#define MDIO_AN_10GBT_CTRL_MS_PORT_TYPE	0x2000	/* Master Preferred Type */
 
 /* AN 10GBASE-T status register. */
 #define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
-- 
2.43.0

