Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B8370D56;
	Sat,  5 Sep 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788593331; cv=none; b=IbidrWNnnGzoIUXDAVo3dt9M27tuLtQER1vUsHOr+4Mz2KW5GyVun/DgYqWaTUwLGlBrad7Vb0B1B2YRPFtjFN91EIWzlIjCQKuSJRJmQidNKyjKSGIRMwEvHLW1nE+qjbkP3JmprbVjVr26+mHFZyPzRPeZsuwoV1qLu2hddz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788593331; c=relaxed/simple;
	bh=+qjCc6FEkT8Kh6L0z3JScE5Ju9FBDiIQjvO3Ss9Df3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQAyb3WnhU6/wfBxblDbyNSMP72Z1zOXstN62giRZ9VBBFPjuMmIdSubFnLlhhoBh0e5nGADvPVzm6D44F2lUQ4FARPRXSpxpSdS1NmoMIP/6D3cDbzZr8bMvrp70un/rapOWNbu1ztZMoekqU5DacsT6M4b5t649wxewZpc59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WEsPlZIR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WEsPlZIR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D36D1A19C7;
	Sat,  5 Sep 2026 07:28:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A3CD60580;
	Sat,  5 Sep 2026 07:28:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66C7B11C79AE2;
	Sat,  5 Sep 2026 09:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788593323; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=82GkuRC0jvPSnLbcrGMk1PpHmAiK9Vi2rhDnE52pglc=;
	b=WEsPlZIRN2lGjDk1xqUxV+RmW2U0hFhGkNDdp9wkJifcd58CtNZnxunxDKRbewYkXI9628
	OUMl47hgVdhPIPwfMS2lFk/O68YyFP29ZWGqPdmfDa3mXf8aCKoYhD4uDPXla1BLBI6+ef
	c0cCWh4+eb3EL1+d4QFINfVHyuPtRA9f2CJQsgSeOsvHxevjV0l1oSPMdRr9iz/AZeFWBr
	7w+7et8hjFwToI5XV2ZP0rDvi8GiOEHa5WOmd+rOQBbv80/C6Wsz5AclK0ry6CrXqEJaUD
	NNZ5WJm7bn1kbmcdxCjf5UvuD9LvDx/StirrsmLVmaBcw5djGSq+zTy6O60zag==
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
Subject: [PATCH net-next v2 1/3] net: phy: motorcomm: Split yt8521_config_init() page management
Date: Sat,  5 Sep 2026 09:28:26 +0200
Message-ID: <20260905072830.28986-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905072830.28986-1-maxime.chevallier@bootlin.com>
References: <20260905072830.28986-1-maxime.chevallier@bootlin.com>
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
V2: no changes

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

