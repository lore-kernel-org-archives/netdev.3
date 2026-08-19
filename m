Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EF3CB8F4
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119400; cv=none; b=frXPVf0UpJmyr6TYHojyIhNxQhBHUVD19iBtyqeq4IhOg/gHKeN5+XE6I1IEperaBvWVVaJen6W9IvFlTtTeoVU9YIYjv5oosPYRrLejU/q92XrKksaTscD3hw3rkjKKEstw9ohcI7MdLsXDftvLRYdzAqxKtCqKR1g/a10PGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119400; c=relaxed/simple;
	bh=8U0HypTh2AmuAZYNlvE7/CoEHCSH4bhE6LIbKUpdVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7x/xh4H9xH1uVtjO38WwhQXTzdoMrdzaMRcxTKHdRsl6WXx7q8IvmXfH+on35606ILQFNfS2U5FgadXfvfcOrDNOUwo4NRycQMRJTynSkLKhAJd9Uz0n7Tjr90w9M3RKlUmysPh3VREBctFyS+xuZs1jVEJGEejrHjpPJJJEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nxl9E3Lc; arc=none smtp.client-ip=95.215.58.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nxl9E3Lc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8U0HypTh2AmuAZYNlvE7/CoEHCSH4bhE6LIbKUpdVg8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119396; v=1; x=1787724196;
 b=Nxl9E3LcB83clKNHSslcYZvvRoOFACAOLnQxp2mcysM6La/03qo2z4mMt0rK7/pGS+kVkDMM
 nBpxWzx9HJng2tPydWqCnP38KY++CHAU3wMHkMh872d7yOQFlkZ7CcHtw87JbbwRTgvNluGbObN
 qPNdLeNlW7s6cVanJPNt52TU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 46c0bf875309408c;
	Wed, 19 Aug 2026 06:03:16 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v3 4/5] net: phy: call driver remove when core initialization fails
Date: Wed, 19 Aug 2026 14:02:35 +0800
Message-ID: <20260819060236.24665-5-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
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
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8fd6fbf378f0a..77318659ff985 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3733,7 +3733,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3750,7 +3750,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out_reset;
+		goto out_remove;
 
 	phy_advertise_supported(phydev);
 
@@ -3825,6 +3825,10 @@ static int phy_probe(struct device *dev)
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

