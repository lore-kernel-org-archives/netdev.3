Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA03CC330;
	Tue, 25 Aug 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686531; cv=none; b=sCizW7iTglw/BKDk5AFC6DHj1qp5nnzFshnM6szkzdPwkROdlUVck+5dbtdiiUGQO/bhC7aezM2E/WXqtM82/r3aBPh1eLFLDsKranjZTj7KNQTxrSU9wskKD0kpA/veBSNv1agb6uDTOvIV5VLb+Ao9E86Y0Y9P1M37efdIeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686531; c=relaxed/simple;
	bh=4gW+YJlWBGOHHkYJdnkByKPkoZs+xEg89SPsViM3OdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=atFcsoM+Af6EQyONqGlAmXG/xISBJAstgj4kP78NW2if3xP4dZiG3kqbczjAi3+GDBtlYutGgeSESeenY0P2yAreddPrNVUzH+FJuoXCXg1EGK3vWnWOid59b2xAC6Lb54WE54cDa0onpaiCudQpCl25v0zoxmSXtaEzO2AxnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=Xj03XAPj; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="Xj03XAPj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0843A1BFDEC;
	Tue, 25 Aug 2026 21:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787686521; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6FiZYyse+CrN3tymCYgowEJem9KKsKbBXowTpsHQ8wY=;
	b=Xj03XAPj+XWm6PN9OHeHiUdA7MZ7gLNOcrX0/p9WCeirILqG6MketVAWXnSsmtu4c15Y96
	dcvLcPxmenSuaMZ7yLXt4RLTvt37w3UFal454MNO0Ae1lEvTDu6F2yxdH13WrJME0dIYyp
	CmOv7xhsKCcAU2gBdC9/Gsl9bi70UtfXEnjgU14TYwCnmp98Iq159+8vqZO19/3714ZGwA
	jPNPOlGAe0dCg0g2SzhtFXwqHsn7FcOXvvY94imY+2B2Geqrr3HCrxXfXYTpUOB+v+01iK
	cBJ9HmdWNaieRX/dQZviJi6rhnoEIUzClokRWarsFU6TH3qu71q/Z5yope2AqQ==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	cjd@cjdns.fr,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 2/3] net: phy: mediatek: bug fixes to airoha-ge-soc.c
Date: Tue, 25 Aug 2026 19:34:55 +0000
Message-Id: <20260825193456.1823985-3-cjd@cjdns.fr>
In-Reply-To: <20260825193456.1823985-1-cjd@cjdns.fr>
References: <20260825193456.1823985-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fix crash bug from unconfigured shared, potential namespace collision
in devm_phy_package_join() and typo in Kconfig.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/Kconfig         | 2 +-
 drivers/net/phy/mediatek/airoha-ge-soc.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index fe51f4616c54..b8df1a8016c6 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -9,7 +9,7 @@ config AIROHA_GE_SOC_PHY
 	  Supports Airoha SoC built-in Gigabit Ethernet PHYs.
 
 	  Include support for built-in Ethernet PHYs which are present in
-	  the AN7581 and AN7583 SoCs. These PHYs d will dynamically
+	  the AN7581 and AN7583 SoCs. These PHYs will dynamically
 	  calibrate during startup.
 
 config MEDIATEK_2P5GE_PHY
diff --git a/drivers/net/phy/mediatek/airoha-ge-soc.c b/drivers/net/phy/mediatek/airoha-ge-soc.c
index 601a64d83365..ab183779ee84 100644
--- a/drivers/net/phy/mediatek/airoha-ge-soc.c
+++ b/drivers/net/phy/mediatek/airoha-ge-soc.c
@@ -1596,11 +1596,14 @@ static int an7581_phy_probe(struct phy_device *phydev)
 		dev_err(&phydev->mdio.bus->dev,
 			"Failed to setup PHY LED pinctrl\n");
 
-	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, 0,
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
+				    AIROHA_DEFAULT_PORT0_ADDR,
 				    sizeof(struct airoha_socphy_shared));
 	if (ret)
 		return ret;
 
+	shared = phy_package_get_priv(phydev);
+
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.39.5

