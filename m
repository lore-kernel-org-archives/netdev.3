Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59363C870E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883160; cv=none; b=mFGkGNypAGpS6hdQWx60FM0LSsarSEbBXf9d0XkhJlW7Ga+yjt0kLiqheDt+qbA4vxC8px1+HdQLLmvALoQRMnDho1tddZcwX/esi3dbmrl0hPgZ6arNsgFt3FHStfeP/l/Vdwcxip5GtpaBgFO5zO/tyZbxupKzoQzYTAnIauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883160; c=relaxed/simple;
	bh=TU2t+F0qMmilXXr9rDzcSLSoWHAU5V1hcfpKM1PF7II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QlfSahzAU/BCTBVDeykZD0C3F07Zb4tiXrBYp7HF7eG+1mBn5pjeM/KCuvgIWVHnBAJkeXX86jGdGOdkDmjQeTKcaikF8BQ/nD2E+pYLCqq0m/9s7TMmb9zyFujRTDQFxkpmLN0UgOpXy88bNNZ4OtsfmW5LNV7qOZ95Wxn8M58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrnTcI4z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrnTcI4z"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so188906b3a.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784883158; x=1785487958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXEn6DnJlp+z/3iwtjtL7o5DVxbThA9UIOkFBH/Ojxs=;
        b=TrnTcI4zeHwv54WQ7ColIFczDbxAvOtjzdND9+1BEI7QCnfgIjphCqhFmqoMq+6jxZ
         k3sk02TUSGRUiy5RkiK3k/vR1c5p1rgkolj6CSxoVCXur29D7V6dfI926Haov6R7gf+H
         j2sDlsNnuskGF1Q8o+v2vQzdYDJ0ZN1H8pm+/Mni9IXF430J2AdHU4siGwNUkO6Ov4pB
         dVklTptdvOBt4jBHo/RcVGb3J4l1BuI9FcwNjhhDR+j3HVTBvbciXfd2Q1HXFr1E2f/7
         03r9fTzgzqDk5h9fhaQ2LboLCMNaoDMMvdqJudvp6C0ZFGrIF1qPq18jOIhntPcjOPrD
         2XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883158; x=1785487958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXEn6DnJlp+z/3iwtjtL7o5DVxbThA9UIOkFBH/Ojxs=;
        b=SuBlE1jB6fOp9+beyCqUrn5DXq38Ey++B7nHTiFTRfKerYOY2evJOWARTAa5M0sqQm
         rE/WvNmJtzfbaMyvayoa+bfGSldPw0wHG5iDTFsMlL6EDnDkeSFJi57KUdH3/jh4la6a
         ytRoGtVv2oOIIioDrKPRpCxGBaK9cXBENQyFlNfxc7M0T0xLZOOnEs6M1UaPLaCJYXrV
         xULfe82/LnzUXh7CirBuY5JveXzGpby8aFO55QfkzHgbzq+kVANMaF8xqRmmBQYipOgQ
         BzbY4EehBk8t+skhKvBTVWHxgoeZb5F3OwIabCXJobGvUUHri6sBNKZP2/V/MYxR14OK
         8luA==
X-Gm-Message-State: AOJu0YxXUsJRjwB3E92A3XgJMP9Q/7k5n8Q9qyj34MoEmkBkbwdclJwA
	GQe0UhhjutIZIkj/0W8FF8L0O/i51lyFA+x7qww9cYj5ExVlmcuXCNCLcDWXPtAX
X-Gm-Gg: AR+sD123vYjiPZ0sejuoes4od3JeiD5tF2tSszHX7ksyTJiuUbr4mW9xWwcGGWwCXnj
	4e1GmYyChqW6HYGWFZghzvjjG2D+rfB2R2EQrWfAWg4DarzHyr2JeGgmeCgm503zqVDLIaED4tJ
	CPwsUW2tqg21wCKOVao8qI1E+xWA5BimE6Un98JXmA/uZIWDAtFOJfWyG/5BfCK/tEXADwciFyA
	0tYIWM+Y8tT5X7W8I46UI18xZlZ5jOFqmykb8KEiYbL6xc7mjXPLGGenirxNLV8WWPeuyQyWcMi
	yqWaCykta/+7rNUXe07+HoCF5nS3IiwMDWURdwFN2hVDci7ujZN8+4FQ5J9Tw22dUX5Ya78XHT9
	su77rtWrgx/uePV9ka5l+n4z25/m5nd96wZpqqpOWo2xLkOBt1c7Wh3dLOpC0qGKLFQBZ7JfdBE
	zC
X-Received: by 2002:a05:6a00:e89:b0:848:420a:9ce0 with SMTP id d2e1a72fcca58-84e2e8094aemr6572103b3a.6.1784883158018;
        Fri, 24 Jul 2026 01:52:38 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17262e33sm4416793b3a.14.2026.07.24.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:52:37 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next] net: phylink: add phylink_pcs_loopback() method for PCS loopback support
Date: Fri, 24 Jul 2026 16:52:24 +0800
Message-Id: <20260724085224.3321663-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pcs_loopback callback to struct phylink_pcs_ops to allow PCS
devices to expose loopback capability. This is useful for MAC drivers
running selftests on interfaces that use in-band signalling and have
no external PHY device.

The phylink_pcs_loopback() helper calls the PCS ops callback if
available, and returns -EOPNOTSUPP for PCS devices that do not
support loopback.

In stmmac, use phylink_pcs_loopback() in stmmac_test_phy_loopback()
and stmmac_selftest_run() when no phydev is present but a PCS with
loopback support exists. This enables PHY loopback selftests on
interfaces without an external PHY.

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 36 ++++++++++++++-----
 drivers/net/phy/phylink.c                     | 19 ++++++++++
 include/linux/phylink.h                       | 16 +++++++++
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 29e824bd90ca..e6ac51018a65 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -377,20 +377,36 @@ static int stmmac_test_mac_loopback(struct stmmac_priv *priv)
 static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
 {
 	struct stmmac_packet_attrs attr = { };
+	struct phylink_pcs *pcs;
 	int ret;
 
-	if (!priv->dev->phydev)
-		return -EOPNOTSUPP;
+	if (priv->dev->phydev) {
+		ret = phy_loopback(priv->dev->phydev, true, 0);
+		if (ret)
+			return ret;
 
-	ret = phy_loopback(priv->dev->phydev, true, 0);
-	if (ret)
+		attr.dst = priv->dev->dev_addr;
+		ret = __stmmac_test_loopback(priv, &attr);
+
+		phy_loopback(priv->dev->phydev, false, 0);
 		return ret;
+	}
 
-	attr.dst = priv->dev->dev_addr;
-	ret = __stmmac_test_loopback(priv, &attr);
+	/* Use PCS loopback for interfaces without an external PHY. */
+	pcs = priv->hw->phylink_pcs;
+	if (pcs) {
+		ret = phylink_pcs_loopback(pcs, true);
+		if (ret)
+			return ret;
 
-	phy_loopback(priv->dev->phydev, false, 0);
-	return ret;
+		attr.dst = priv->dev->dev_addr;
+		ret = __stmmac_test_loopback(priv, &attr);
+
+		phylink_pcs_loopback(pcs, false);
+		return ret;
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static int stmmac_test_mmc(struct stmmac_priv *priv)
@@ -1986,6 +2002,8 @@ void stmmac_selftest_run(struct net_device *dev,
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
 				ret = phy_loopback(dev->phydev, true, 0);
+			else if (priv->hw->phylink_pcs)
+				ret = phylink_pcs_loopback(priv->hw->phylink_pcs, true);
 			if (!ret)
 				break;
 			fallthrough;
@@ -2019,6 +2037,8 @@ void stmmac_selftest_run(struct net_device *dev,
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
 				ret = phy_loopback(dev->phydev, false, 0);
+			else if (priv->hw->phylink_pcs)
+				ret = phylink_pcs_loopback(priv->hw->phylink_pcs, false);
 			if (!ret)
 				break;
 			fallthrough;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59dfe35afa54..a7f78c82913a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -997,6 +997,25 @@ int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL_GPL(phylink_pcs_pre_init);
 
+/**
+ * phylink_pcs_loopback() - Enable or disable loopback at the PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ * @enable: true to enable loopback, false to disable
+ *
+ * Enable or disable loopback mode at the PCS level. This is used by MAC
+ * drivers for selftest purposes when no external PHY is present.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int phylink_pcs_loopback(struct phylink_pcs *pcs, bool enable)
+{
+	if (pcs->ops->pcs_loopback)
+		return pcs->ops->pcs_loopback(pcs, enable);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(phylink_pcs_loopback);
+
 static void phylink_mac_config(struct phylink *pl,
 			       const struct phylink_link_state *state)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2bc0db3d52ac..66c7016d4acd 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -518,6 +518,7 @@ struct phylink_pcs {
  *		    the MAC.
  * @pcs_pre_init: configure PCS components necessary for MAC hardware
  *                initialization e.g. RX clock for stmmac.
+ * @pcs_loopback: enable/disable loopback mode at the PCS.
  */
 struct phylink_pcs_ops {
 	int (*pcs_validate)(struct phylink_pcs *pcs, unsigned long *supported,
@@ -542,6 +543,7 @@ struct phylink_pcs_ops {
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
+	int (*pcs_loopback)(struct phylink_pcs *pcs, bool enable);
 };
 
 #if 0 /* For kernel-doc purposes only. */
@@ -717,8 +719,22 @@ void pcs_enable_eee(struct phylink_pcs *pcs);
  */
 int pcs_pre_init(struct phylink_pcs *pcs);
 
+/**
+ * pcs_loopback() - Enable or disable loopback at the PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ * @enable: true to enable loopback, false to disable
+ *
+ * Enable or disable loopback mode at the PCS level. This is used by MAC
+ * drivers for selftest purposes when no external PHY is present.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int pcs_loopback(struct phylink_pcs *pcs, bool enable);
+
 #endif
 
+int phylink_pcs_loopback(struct phylink_pcs *pcs, bool enable);
+
 struct phylink *phylink_create(struct phylink_config *,
 			       const struct fwnode_handle *,
 			       phy_interface_t,

base-commit: 1df10cef2d1e7f9f2fb7eddb67fc70d3abf101f9
-- 
2.34.1

