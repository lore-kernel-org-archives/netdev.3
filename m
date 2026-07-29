Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787213C1D57;
	Wed, 29 Jul 2026 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340410; cv=none; b=t23INmPilwW3ktOnlMclKs45NKDMYkf5I/j1y2qRaI21k+te828xzGd+ouHsaHI415eD4BNXkZUqlssLqnkfL+F2uhcbwl5bWUchkuDHbeSrYu/A1oJF7lQ9Xyli+sXq+ka/7891s0raM19IvDw0rxANG2/fGVDNNeeLOJWFv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340410; c=relaxed/simple;
	bh=syVwcaNFaFiBzJd8qnTeh3wk25Xvs8vqXrgriUMbe/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLu94ZubFuVe/JrBSxlqutwEMytwuCsgrwnj3YMZ1BgVukVfQXxUscf3qnMSqNeFBPEFAVLBCMqST127fApnueVQso7LSapuWccEg5HsdaojPPkxr68mx9ggYhd63MfUQdtUEIQjurpd7EYLnVupFnzv9z8UXuxiETZDtUwPWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=HzIJRokq; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="HzIJRokq"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 480c54625;
	Wed, 29 Jul 2026 23:53:23 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: getshell@seu.edu.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net-next v3 RESEND] net: phy: nxp-tja11xx: cancel registration work on remove
Date: Wed, 29 Jul 2026 23:53:22 +0800
Message-ID: <20260729155322.319-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fae949c8503a1kunmfb884c4112123f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS04eVhpISUsaSk4aTUhOHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HzIJRokqXD1P9mPbLkd+NBapAPXlxMej/9b7gaTVW/BlK3YYkZHECzAofMt4GRsDDJofjXb/xqeTtlrKiVAFEPkP1Hzu1Bi9taKNnMR8/9jEGOgPLsVYHcSKpraIxdoVARaVY5Bh/7mVCfvtdowwej4H8EruQ9sxt65VnnbFPRg=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=5WjZLW/BLefPEIg1Hvp4YtOiEL/dW36wrtHsS/joX0g=;
	h=date:mime-version:subject:message-id:from;

tja1102_p0_probe() schedules work to register the second port. That work
uses the Port 0 private data and phydev. The private data is
devm-allocated, but the driver does not wait for the pending work on
remove.

Store the Port 0 private data in phydev->priv and add a remove callback.
The callback cancels the registration work before devres teardown frees
the state.

This issue was found by a static analysis tool.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
RESEND:
- resend v3 as a new independent thread as required by netdev
- no code changes

v3:
- drop the Fixes tag
- target net-next instead of net
- no code changes

v2: https://lore.kernel.org/netdev/20260729091621.1726-1-getshell@seu.edu.cn/
v1: https://lore.kernel.org/netdev/20260728123423.781-1-getshell@seu.edu.cn/

 drivers/net/phy/nxp-tja11xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 07e94a247..68062a4c5 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -620,6 +620,7 @@ static int tja1102_p0_probe(struct phy_device *phydev)
 		return -ENOMEM;
 
 	priv->phydev = phydev;
+	phydev->priv = priv;
 	INIT_WORK(&priv->phy_register_work, tja1102_p1_register);
 
 	ret = tja11xx_hwmon_register(phydev, priv);
@@ -631,6 +632,13 @@ static int tja1102_p0_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static void tja1102_p0_remove(struct phy_device *phydev)
+{
+	struct tja11xx_priv *priv = phydev->priv;
+
+	cancel_work_sync(&priv->phy_register_work);
+}
+
 static int tja1102_match_phy_device(struct phy_device *phydev, bool port0)
 {
 	int ret;
@@ -847,6 +855,7 @@ static struct phy_driver tja11xx_driver[] = {
 		.features       = PHY_BASIC_T1_FEATURES,
 		.flags          = PHY_POLL_CABLE_TEST,
 		.probe		= tja1102_p0_probe,
+		.remove		= tja1102_p0_remove,
 		.soft_reset	= tja11xx_soft_reset,
 		.config_aneg	= tja11xx_config_aneg,
 		.config_init	= tja11xx_config_init,
-- 
2.50.1.windows.1
