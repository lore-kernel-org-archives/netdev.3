Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410FF47DFBA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627811; cv=none; b=kYGb7GUcMgrjNQAOOMjFN+VZz1v76o6Sz9o/afZyVsH7CHMdJD2YVz/ebzvm0FJso+aAmB7SR50kLC8rwnPrD9PQlXYZp8xEtKFDpszj1E+xnN+o8U0HDgei+Sd4Rtxm+OcGlQzLZh/YLJ6BBuY0bQ2fN0Jvmc0fn7EqCEVBcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627811; c=relaxed/simple;
	bh=CL0N8elDQ4wwTZ4RkCqCpiUMNIVZK9/qKZ0kQM8xFgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohE/3HtSvkRaUgiyL5jYymYIMmeUGcf+INMg5CnJJ0fYF0TTigSrVIcv3wza8+5tILcMVG0FZRkcL31qO/y5VGChr42KSnRvqhICRfidNkwvnyZpMAUn0cCf8JX2SXwAyT04IZkmmYrow3jJWdOFGY3Pj0gyJAq/BWRaJ9SQLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FaMopyxB; arc=none smtp.client-ip=95.215.58.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FaMopyxB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CL0N8elDQ4wwTZ4RkCqCpiUMNIVZK9/qKZ0kQM8xFgg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627808; v=1; x=1787232608;
 b=FaMopyxBWJhUH2slXW/Bh20t0m0FYV9yI+/MEwHZPDXuTmby24TY4BalAerAi4EoV1k6zeg2
 yUZepPf2noy2/7MSODzJ+C3BTaf9H2qtO7dPh6c3or9YDkyXuhBTRSPLmhns9lARxzg4DmmqdE/
 Irn8fjSip6XNn5v/0TIodxCE=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 88ccd6f65087217c;
	Thu, 13 Aug 2026 13:30:08 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 1/5] net: phy: split phy_probe() error paths
Date: Thu, 13 Aug 2026 21:29:41 +0800
Message-ID: <20260813132946.116176-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
References: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
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
index 0615228459ef4..c9976ffa7128c 100644
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
+		goto out_ports;
 
 	phy_advertise_supported(phydev);
 
@@ -3728,7 +3728,7 @@ static int phy_probe(struct device *dev)
 	 */
 	err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
 	if (err)
-		goto out;
+		goto out_ports;
 
 	/* Get the EEE modes we want to prohibit. */
 	of_set_phy_eee_broken(phydev);
@@ -3781,20 +3781,22 @@ static int phy_probe(struct device *dev)
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev)) {
 		err = of_phy_leds(phydev);
 		if (err)
-			goto out;
+			goto out_led_triggers;
 	}
 
 	return 0;
 
-out:
+out_led_triggers:
+	if (!phydev->is_on_sfp_module)
+		phy_led_triggers_unregister(phydev);
+
+out_ports:
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

