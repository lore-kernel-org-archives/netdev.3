Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BB3CA4B5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161887; cv=none; b=q57C4NeFO4IAgrGg0JCEedNL1oGiJucEvTv5rV7evY0OErW77cnXcCl9Bp7GBcql26aVPkvl99xwp0y7+ajp6KA1YyqsbIBAlbrQKhmwkxRktPbeCUSZablhekQ6qO5QWHuv3fG37zKifkjMwboqiyx+5I9gOB897Y4GEdGZBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161887; c=relaxed/simple;
	bh=F1HrH0j97zLYNKimeeofQTyF4AjNKH73sd08OhHSUYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQNIkTjxPWJzh4Agz75MOUbkjncs7xeI6QfYtu9xCteoL5pWHhzWcbK8pPW+/re4CVGEEz9xBB+SmJO4oVIKW+NyCfpb/fB6BdslfWeJbPdNKQfcguE6L94tTPH3gk51PdtcB1dGZhlYe/tNAzo41TW3x7+Pj7poCSpZH8pvKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wCVk8Ng1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wCVk8Ng1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AE33E4E41467;
	Mon, 31 Aug 2026 07:38:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C65C601E1;
	Mon, 31 Aug 2026 07:38:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E40BB11C788FA;
	Mon, 31 Aug 2026 09:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788161883; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QMDNxhjS6p7m3ikTdxZ2TWzg9kXtx6ojXOERB6s57fk=;
	b=wCVk8Ng1hsrjwSVgqmJTOIECQsxQPp5bBuzahUP2MBEsmFz4DbbimBqwTcbDE6BdnSf+sp
	MbxQwSPgUZhFjY+9TtIt/V55rNKG9KR6LKskHE2TfYhrUh3ZqcVOeOAaN+EkL9PYkD+DoE
	EpS7uRXlaOsXL486oO9y56ZN03F1biMYw8axUZQ90sIGVthMlzJGnJ467YbUSOvxG6HOBH
	Ce/6tzZoSU5uGpEbPLls0WuY3Xv9moj/2itktGtHLSjGbDAM/RRaQso8j3DemNDW0Fr+Nk
	yCDnHoI36Rb0hfU8AYPkgtnb+W4ThHOqq0AsPkVnIv13kaL3O7QJgricQMJCmA==
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
Subject: [PATCH net-next 2/3] net: phy: motorcomm: Add a dedicated .config_init for YT8531S
Date: Mon, 31 Aug 2026 09:37:44 +0200
Message-ID: <20260831073747.361482-3-maxime.chevallier@bootlin.com>
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

The YT8531S PHY configuration logic is similar to the YT8521, but with
some extra steps for the RGMII configuration. In preparation for
improvements in the YT8531S configuration for the version found
integrated with the YT6801 PCIe NIC, let's split the logic out by
extending the YT8521 configuration sequence.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/motorcomm.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 58e4d67b945f..36c229460a77 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1700,19 +1700,12 @@ static int __yt8521_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled")) {
+	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled"))
 		/* enable RXC clock when no wire plug */
-		ret = ytphy_modify_ext(phydev, YT8521_CLOCK_GATING_REG,
-				       YT8521_CGR_RX_CLK_EN, 0);
-		if (ret < 0)
-			return ret;
-	}
+		return ytphy_modify_ext(phydev, YT8521_CLOCK_GATING_REG,
+					YT8521_CGR_RX_CLK_EN, 0);
 
-	if (phy_interface_is_rgmii(phydev) &&
-	    phydev_id_compare(phydev, PHY_ID_YT8531S))
-		ret = yt8531_set_ds(phydev);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -1735,6 +1728,25 @@ static int yt8521_config_init(struct phy_device *phydev)
 	return phy_restore_page(phydev, old_page, ret);
 }
 
+static int yt8531s_config_init(struct phy_device *phydev)
+{
+	int old_page, ret = 0;
+
+	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	ret = __yt8521_config_init(phydev);
+	if (ret)
+		goto err_restore_page;
+
+	if (phy_interface_is_rgmii(phydev))
+		ret = yt8531_set_ds(phydev);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
 static const unsigned long supported_trgs = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
 					     BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
 					     BIT(TRIGGER_NETDEV_LINK)        |
@@ -3143,7 +3155,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.set_wol	= ytphy_set_wol,
 		.config_aneg	= yt8521_config_aneg,
 		.aneg_done	= yt8521_aneg_done,
-		.config_init	= yt8521_config_init,
+		.config_init	= yt8531s_config_init,
 		.read_status	= yt8521_read_status,
 		.soft_reset	= yt8521_soft_reset,
 		.suspend	= yt8521_suspend,
-- 
2.55.0

