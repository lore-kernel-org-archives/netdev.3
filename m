Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6925D530
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787457410; cv=none; b=lkK6nVGbD1SMsnE/tNW+MebHjU5HQMPPgJQmlxRl7dDxL9sjrG6W/AZNg5eukq9oJP3KoECF9G1JkaJpdtATHzQc5pCPxgbl3sPRbxTqALqQ8PrBPQ5bR+2R9Tki0HQhwwrnxkCDcp2AvDPOHpKt7bMjlCQf/1RxldGgr+crcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787457410; c=relaxed/simple;
	bh=Pibs+c7tZQLPitx0IfvSOl7lc/8t3c9y/LRGCRLWcAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkRvTBPzUvIopAyki/N8d2MA4i0wMssGP8Q91gdhTWct7Wk8QuQIVwot4I/3La7ankfvNR2KqASDht72+LMyPZTtstPHnjuFtomemBBdtwOGPa1/2T4BfX+Ijj/M5HV4qHKu0qQR74a9iryHdOAEED/kgHU5zUh2uJ3W70gEp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJWJ5bg/; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJWJ5bg/"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Pibs+c7tZQLPitx0IfvSOl7lc/8t3c9y/LRGCRLWcAg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787457404; v=1; x=1788062204;
 b=SJWJ5bg/DacWfs0bQCrLJRIXuTEbFdYJ5bJbeJYIPvwW4YC5ptloUuKzqLGWaZkvF05c9xz2
 aCAGlDvBoMcgCCIOliNc/cbws3iX4Xvio0g0Hi3r8xK+lH9WaLkC2WnUSDPYzRD0fNMtEuvvMZr
 GsfFuYZYAu7Xzizpiczm1mP4=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 01a76de9a4044b4a;
	Sun, 23 Aug 2026 03:56:44 +0000
X-Mizu-Trace-ID: 01a76de9a4044b4a
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	chleroy@kernel.org,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v5 4/6] net: phy: call driver remove when core initialization fails
Date: Sun, 23 Aug 2026 11:55:58 +0800
Message-ID: <20260823035600.188864-5-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() may fail while querying features or completing other core
initialization after the PHY driver probe callback has succeeded. The
driver core does not run the remove path after a probe error, so
resources that the PHY driver releases in its remove callback are
leaked.

Call the PHY driver remove callback on these failures.

Fixes: efbdfdc29bdd ("net: phy: Add support for asking the PHY its abilities")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 891df46d0597f..691396794decd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3758,7 +3758,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3775,7 +3775,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	phy_advertise_supported(phydev);
 
@@ -3850,6 +3850,10 @@ static int phy_probe(struct device *dev)
 	phy_sfp_release(phydev);
 	phy_cleanup_ports(phydev);
 
+out_remove:
+	if (phydev->drv->remove)
+		phydev->drv->remove(phydev);
+
 out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
-- 
2.43.0

