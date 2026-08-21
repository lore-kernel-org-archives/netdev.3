Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92F2F361E
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295842; cv=none; b=sg0HbZ9YObSpW2Z6RnS70OMQAlI+rm3ERlLkmR+WZVVRMfES/7ubwFuoMzuWdzUVH0ycZNZE5749LLFhgursgY6H9pO/+JPOgFOtUf5h0amGLDrY9qjxKz+B7gRzDe8xleF4ESmV2czKITtIfjPfeuEjDFF9HzcJE8op9KERB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295842; c=relaxed/simple;
	bh=znURPWLxZWEMIGdoNbH1oygckZ9cvOk5K8POBG6JQB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbMc/MRVN9oRIY/9UBlU2oo1Y/vUBi6Qu6443D0mCmwR5SES8WrPcokpIoCpjjrQ5wpW1ro8i73ete6kFPWxWYrIyIOmrhJBHF3x20rGSXepIPbkrFrtnhmiHNbKGiBJ0hzo9MIQQqiXpiSalo+hGGsSkln+IMGxRcxnIscfc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJo4Itxv; arc=none smtp.client-ip=91.218.175.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJo4Itxv"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=znURPWLxZWEMIGdoNbH1oygckZ9cvOk5K8POBG6JQB4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787295838; v=1; x=1787900638;
 b=SJo4ItxvqWq6Dj3pIjWWQlDRl7ZC+3+VfrF5shWv5QPPVyDV2PKgdYcgVOudBuqACaiHUhmh
 U+lLXHm+yMjrnG8MFe3gYy8gwwYfQ36X8/w5b4V1AO6UztDSvE5WO5FD+gmJViYOWG3chjc/6Rv
 abdNTKS1W8jJShgEs32RYj3M=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 827a16a903200fa8;
	Fri, 21 Aug 2026 07:03:58 +0000
X-Mizu-Trace-ID: 827a16a903200fa8
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v4 1/6] net: phy: split phy_probe() error paths
Date: Fri, 21 Aug 2026 15:03:22 +0800
Message-ID: <20260821070327.16147-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
References: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
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

Unregister LED triggers before releasing the SFP upstream and ports,
because the LED triggers are initialized after those resources and must
be unwound first.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a37..2cf70471ae089 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3706,7 +3706,7 @@ static int phy_probe(struct device *dev)
 	if (phydev->drv->probe) {
 		err = phydev->drv->probe(phydev);
 		if (err)
-			goto out;
+			goto out_reset;
 	}
 
 	phy_disable_interrupts(phydev);
@@ -3727,7 +3727,7 @@ static int phy_probe(struct device *dev)
 		err = genphy_read_abilities(phydev);
 
 	if (err)
-		goto out;
+		goto out_reset;
 
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			       phydev->supported))
@@ -3744,7 +3744,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out;
+		goto out_sfp_release;
 
 	phy_advertise_supported(phydev);
 
@@ -3753,7 +3753,7 @@ static int phy_probe(struct device *dev)
 	 */
 	err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
 	if (err)
-		goto out;
+		goto out_sfp_release;
 
 	/* Get the EEE modes we want to prohibit. */
 	of_set_phy_eee_broken(phydev);
@@ -3806,20 +3806,22 @@ static int phy_probe(struct device *dev)
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

