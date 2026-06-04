Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7493947AB;
	Thu,  4 Jun 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558972; cv=none; b=b4Euwc0302w4JJNuaDEft1yZDyo9JMdk8u5YX3W1kpwsT8qyYqE5luaqHqaNQWdHgHfoUTQ17xTjXBDXfVyVq6TgqS8oO8AzBJmJVfgcLThPvWt/5A+xnSWUcHJmnWnrdu39MfdqUJJT2WqsPCrUKs2tEb7AVhWG+0yxxKX6JDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558972; c=relaxed/simple;
	bh=+OSl/9Tg8QZDlHSmSofCJZOkgxqpsg/6y0R7twGKNMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDdptyJL7GCuMmKddoiEKC+Wulj/ayXhMeLyRAD/no6r4bBPnNk9OUaUXOzOmEQLY3H88FfawJZULSwt9ryS1veCOTfyTNGWmfdxhHn81mChVfFsiMU+qvaCJR3qxTVDFIPdIrEhMryQ7ybnQVvp/8nn/27kUw9dPquhC55pg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Z+vN+/sZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Z+vN+/sZ"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6547gCotD206040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780558932;
	bh=8EcVsiTJKG7rqcLq7ehM2aQoe+JZYKMbrtZECLfzNMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Z+vN+/sZCCH+KehYLeZZmgNgH2+72gcZH23XPYkIlSsdrluAZoCK6+0KUZItnOExK
	 9X+z6T5FuF+o4ChrgOclTsajiRdiktRNWH4VbeHlFJj3+a0PfuNqzZ+wDjlcblB4ZY
	 sSq2ZmSNO+jI9SwaoejBth0pLLRZ2SWbCKzz2QVX8WgxOs7B3h5mawQO5PtFK0/d/s
	 kCedUMbOU+9ebQ57s/LqNO52LVrk9ieuT5vQgXKiPJRFZlJJn3ySqNtmhUPUh2rYqP
	 sXl9ktRkPVReVjgyWUvdffcMFyM65oQcZnARz5zcW3f0JKN5orvmQhAV2+QMtgbOcK
	 5ZRnqN+BgS/qw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6547gCotD206040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 15:42:12 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 15:42:11 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 15:42:11 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 2/4] net: phy: c45: add genphy_c45_config_master_slave()
Date: Thu, 4 Jun 2026 15:42:07 +0800
Message-ID: <20260604074209.93-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604074209.93-1-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
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
---
 drivers/net/phy/phy-c45.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 include/uapi/linux/mdio.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 216a2cb9e3f0..bbab5586c348 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -352,6 +352,38 @@ int genphy_c45_soft_reset(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);
 
+/**
+ * genphy_c45_config_master_slave - Configure Master/Slave setting for C45 PHYs
+ * @phydev: target phy_device struct
+ *
+ * Description: Configures the Master/Slave manual setting in the
+ * 10GBASE-T control register (MMD 7, Register 0x0020) according to
+ * IEEE 802.3 standards.
+ */
+int genphy_c45_config_master_slave(struct phy_device *phydev)
+{
+	u16 val = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		val = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		val = MDIO_AN_10GBT_CTRL_MS_ENABLE;
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+	default:
+		break;
+	}
+
+	return phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				      MDIO_AN_10GBT_CTRL_MS_ENABLE |
+				      MDIO_AN_10GBT_CTRL_MS_VALUE, val);
+}
+EXPORT_SYMBOL_GPL(genphy_c45_config_master_slave);
+
 /**
  * genphy_c45_restart_aneg - Enable and restart auto-negotiation
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 25a66320df56..d9c8c86e2d81 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2310,6 +2310,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
 int genphy_c45_soft_reset(struct phy_device *phydev);
+int genphy_c45_config_master_slave(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..2f36005b3133 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,6 +332,8 @@
 #define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
+#define MDIO_AN_10GBT_CTRL_MS_ENABLE	0x8000	/* Master/slave manual config enable */
+#define MDIO_AN_10GBT_CTRL_MS_VALUE	0x4000	/* Master/slave config value (1=Master) */
 
 /* AN 10GBASE-T status register. */
 #define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
-- 
2.43.0

