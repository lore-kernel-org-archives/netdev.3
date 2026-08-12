Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BA32F764
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539125; cv=none; b=Q7HOmPCIEZrPeLTJe0HVdq/mFUe0r5L306U7XlEprRkl9w7QCvi5OMtQZdAAVo9b486hBeSM0J6K5B5hfRGqOs8RGx08HvNFyLoxO+374TYL22Qy5Dlk3ttmyHGtdwv+j4wddD3Rf1NyKlCwN9KoqdvjAu7Doi19Lh1VjvfeKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539125; c=relaxed/simple;
	bh=cr/4+5Zfa/zkZ85VUOeLYyutNIJ6Hh5yXjA2ZCJ0OjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iosV8mFGqxakOr0S5Lat2JftwbILUhj8M9op//aTfn4fbhQ6hFG/IdfAzQ4d30AZPfAL3Gv8hWi6q5Mm8P6m0ctQ3X3Cmv0WoFPTMQb3BENifg6pAVlf4IRqUe7tJj4BesVH8afvwnGAYjNtbGa5tR7/JYb40sj9TOMcfCbcg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=frDarJV9; arc=none smtp.client-ip=95.215.58.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="frDarJV9"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cr/4+5Zfa/zkZ85VUOeLYyutNIJ6Hh5yXjA2ZCJ0OjU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786539122; v=1; x=1787143922;
 b=frDarJV9Qwf757y+7wSa/sBMxYTUS6PjrnzsHFug4JrLX26v76mVbrVVA4If9SAo6KNOIVSH
 /rqbWwnq5J3XSaY1yTpTk++jbhI0Ozn/sellHPnKBT61cdYpTRV7ZTtn57i56SVBT5j1wMkpNNl
 ameINcV77aOC5wL4ffSIJkOY=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 8edfd4d755774df5;
	Wed, 12 Aug 2026 12:52:02 +0000
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1 1/2] net: phy: split phy_probe() error paths
Date: Wed, 12 Aug 2026 20:51:26 +0800
Message-ID: <20260812125127.106255-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
References: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() uses one cleanup path for failures at every initialization
stage. This runs cleanup for resources that have not been initialized
and leaves phy_setup_ports() relying on its caller to remove an SFP
upstream after a partial failure.

Make phy_setup_ports() unwind the SFP upstream before removing its ports.
Then split the phy_probe() cleanup so each failure path unwinds only the
resources that may have been initialized.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef4..f8e434daab66e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3556,6 +3556,9 @@ static int phy_setup_ports(struct phy_device *phydev)
 	return 0;
 
 out:
+	sfp_bus_del_upstream(phydev->sfp_bus);
+	phydev->sfp_bus = NULL;
+
 	phy_cleanup_ports(phydev);
 	return ret;
 }
@@ -3681,7 +3684,7 @@ static int phy_probe(struct device *dev)
 	if (phydev->drv->probe) {
 		err = phydev->drv->probe(phydev);
 		if (err)
-			goto out;
+			goto out_reset;
 	}
 
 	phy_disable_interrupts(phydev);
@@ -3702,7 +3705,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out;
+		goto out_reset;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3719,7 +3722,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out;
+		goto out_reset;
 
 	phy_advertise_supported(phydev);
 
@@ -3728,7 +3731,7 @@ static int phy_probe(struct device *dev)
 	 */
 	err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
 	if (err)
-		goto out;
+		goto out_ports;
 
 	/* Get the EEE modes we want to prohibit. */
 	of_set_phy_eee_broken(phydev);
@@ -3781,20 +3784,22 @@ static int phy_probe(struct device *dev)
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

