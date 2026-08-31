Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7F20E030;
	Mon, 31 Aug 2026 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161886; cv=none; b=HWUQPrel4rDHaFV4FFjrOfkXEsAbHepitFUR7DkcZRZHaav2NHwVDxVPqQdNGndLY/8rXUk/7WRViRpXK0Za5IoYYPmOu4/gng51ZC0rGLK0gl0rdbAhWh8zXx1NBaYOuXAY+Jq0a8OCRFSo/LQym7f0ZN5WwGKkrv2VrvBuHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161886; c=relaxed/simple;
	bh=64/OFULvzbLlpYJvKHLvybzuSZs7NGzcE1bk3VvxVpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxtvR2oq3pUjLOZiVDPhTmta4IDGkB46ctTH4O1Un3ygMJOp6NNXmeih0/PMPs70dlX4Sx3cjeH22UuQGdLl3pKho8/EcX10vV8AGX46JN/xOq1KWQMm8PVBj6xtVTDf5PXv/o/XY/3sBuKAM4RGG7//P3cKBrWYjLAT1aIrg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GPt4V02L; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GPt4V02L"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C97484E41466;
	Mon, 31 Aug 2026 07:38:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93467601E1;
	Mon, 31 Aug 2026 07:38:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F77B11C783E3;
	Mon, 31 Aug 2026 09:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788161881; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rKqQvcYTnwhaeJBQ2ar7dKiQ42957hc/hTbAjzWCFPM=;
	b=GPt4V02LsQZNwWDDGo0O6bovgr21NkxPD57nBj3tF/tYpUaC1MSLADXxXq5lemvazZzewf
	ejQwVvIvyTYZ9eO+8G/nS39rcy+AlML9hDbVyOhvsmnN50PO772iGl4NAY2E2DWx12+dgB
	QEWpxldZtdFNw88WMVLEkxrYF4IAPtgqEGajxq9XBm/O+aGBbThK8tpoGMnw3VjscxXi2e
	Qxp/YlI+hxUesRi8RymjGSGD3Fps0qiFFcK2ymzkiY73+gBsPJS9wcoozJqVOZ9A8epeNA
	zSnHFW5EHAWiTzoT640+idGYhFlyK4FTT06wYPZEZVMaDx+VPqfpeILgqAl2dQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Yao Zi <me@ziyao.cc>,
	Frank <Frank.Sae@motor-comm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 1/3] net: phy: motorcomm: Split yt8521_config_init() page management
Date: Mon, 31 Aug 2026 09:37:43 +0200
Message-ID: <20260831073747.361482-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
References: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In preparation for separate .config_init() implementations for YT8521
and YT8531S, let's split the yt8521_config_init() into a high-level
helper that deals with page handling, and another one that implements
the logic. This will ease splitting the YT8531S-specific logic out.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/motorcomm.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index c5a2cda8d31b..58e4d67b945f 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1680,27 +1680,16 @@ static int yt8521_resume(struct phy_device *phydev)
 	return yt8521_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
 }
 
-/**
- * yt8521_config_init() - called to initialize the PHY
- * @phydev: a pointer to a &struct phy_device
- *
- * returns 0 or negative errno code
- */
-static int yt8521_config_init(struct phy_device *phydev)
+static int __yt8521_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
-	int old_page;
 	int ret = 0;
 
-	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
-	if (old_page < 0)
-		goto err_restore_page;
-
 	/* set rgmii delay mode */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII) {
 		ret = ytphy_rgmii_clk_delay_config(phydev);
 		if (ret < 0)
-			goto err_restore_page;
+			return ret;
 	}
 
 	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
@@ -1708,7 +1697,7 @@ static int yt8521_config_init(struct phy_device *phydev)
 		ret = ytphy_modify_ext(phydev, YT8521_EXTREG_SLEEP_CONTROL1_REG,
 				       YT8521_ESC1R_SLEEP_SW, 0);
 		if (ret < 0)
-			goto err_restore_page;
+			return ret;
 	}
 
 	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled")) {
@@ -1716,13 +1705,32 @@ static int yt8521_config_init(struct phy_device *phydev)
 		ret = ytphy_modify_ext(phydev, YT8521_CLOCK_GATING_REG,
 				       YT8521_CGR_RX_CLK_EN, 0);
 		if (ret < 0)
-			goto err_restore_page;
+			return ret;
 	}
 
 	if (phy_interface_is_rgmii(phydev) &&
 	    phydev_id_compare(phydev, PHY_ID_YT8531S))
 		ret = yt8531_set_ds(phydev);
 
+	return ret;
+}
+
+/**
+ * yt8521_config_init() - called to initialize the PHY
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8521_config_init(struct phy_device *phydev)
+{
+	int old_page, ret = 0;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	ret = __yt8521_config_init(phydev);
+
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
 }
-- 
2.55.0

