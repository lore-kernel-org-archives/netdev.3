Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6B3CB8F4
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119377; cv=none; b=ZDY+Jb95rCZBhSVS73v+XOccNZJ1RV7WpiPbteKjSN6hhSCkYn0lNhRO12jZ42rJmaFTMiLgoxq9bcn8rgIHfg8gPA/WCxfDsAD57ELy+FCcgiG+04qzPZvWvVi/46/gvDQ3TDZRdfSkFHfNw6DwyqW1U9Wi5P4qST1btnaGlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119377; c=relaxed/simple;
	bh=WeqA8pFD0+VEJMYtafd904AuzYUQopOTlTrjheK8V1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh7bxe/P8KCT3PFJPZNI787kiSaoS6MT0kHt7TQbz7CJkbtlditr73XjCN/sRQwYjk60YC5x1sdqEWJYBHiykUljXlVz1Id2VEN3rkRHoaRWou2OkivJ48DRJyUBHRBfqRH5ernY2on5aWN2wOlsRQnQaMAFytv5DxY1WVo1HME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Th9ZCjyd; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Th9ZCjyd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WeqA8pFD0+VEJMYtafd904AuzYUQopOTlTrjheK8V1s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119373; v=1; x=1787724173;
 b=Th9ZCjydeBxeSrKNxgITE2sykRaV4hBevY26gPhgg+8acNDzEYQN5FC3I7L7rEASnATgct6j
 8mZBJFEO2hJj93Cb1AGl3zoe5i/eQ3mQOvYNgslY9RDyR5H4gsWEccu3e1xP5zlatS5+2FqWn1t
 lJQlDYqhYnF8G6MihHN0sZpg=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id a3addec7ac238d5d;
	Wed, 19 Aug 2026 06:02:53 +0000
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
Subject: [PATCH net v3 1/5] net: phy: split phy_probe() error paths
Date: Wed, 19 Aug 2026 14:02:32 +0800
Message-ID: <20260819060236.24665-2-xuanqiang.luo@linux.dev>
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

phy_probe() uses one cleanup path for failures at every initialization
stage. This runs cleanup for resources that have not been initialized.

Split the cleanup by initialization stage so each failure path unwinds
only the resources that may have been initialized.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef4..59ee5a76af2ba 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3681,7 +3681,7 @@ static int phy_probe(struct device *dev)
 	if (phydev->drv->probe) {
 		err = phydev->drv->probe(phydev);
 		if (err)
-			goto out;
+			goto out_reset;
 	}
 
 	phy_disable_interrupts(phydev);
@@ -3702,7 +3702,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out;
+		goto out_reset;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3719,7 +3719,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out;
+		goto out_sfp_release;
 
 	phy_advertise_supported(phydev);
 
@@ -3728,7 +3728,7 @@ static int phy_probe(struct device *dev)
 	 */
 	err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
 	if (err)
-		goto out;
+		goto out_sfp_release;
 
 	/* Get the EEE modes we want to prohibit. */
 	of_set_phy_eee_broken(phydev);
@@ -3781,20 +3781,22 @@ static int phy_probe(struct device *dev)
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev)) {
 		err = of_phy_leds(phydev);
 		if (err)
-			goto out;
+			goto out_unreg_led_triggers;
 	}
 
 	return 0;
 
-out:
+out_unreg_led_triggers:
+	if (!phydev->is_on_sfp_module)
+		phy_led_triggers_unregister(phydev);
+
+out_sfp_release:
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
 	phy_cleanup_ports(phydev);
 
-	if (!phydev->is_on_sfp_module)
-		phy_led_triggers_unregister(phydev);
-
+out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
 
-- 
2.43.0

