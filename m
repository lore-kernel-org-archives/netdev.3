Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA903AEF2F;
	Wed, 29 Jul 2026 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316600; cv=none; b=PKvarWfM24G86VrW3a90mTbOuV8B0duFEZlA3LQ+JLRZ1xL22jDJb65rtmVPfY4bvjN10R0XV1cySBRRWu5zzk8IaBYcVUVin0ltgAio1YhApb77iX9r22l95h8vQBlaAJUto/DQ2WOiv4CkGiEt5cr/r2Rkj6X5yfRXaqzulvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316600; c=relaxed/simple;
	bh=SeBpxSVR4easvYcp8HvbZoYuBSgu3hp15BfoHgftsyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xphu7vfFm/swywA+XpHXoDpwhCIuKiec2jZ5QnaTJCmh/kXhgNoDvU1MrYVOeZTtZBu3/7PPy0McULyGfJBB9w9X13INPPSKCAUbNj5g6eFYamzMgpBiSYy/clHSRx5CxpJINzVp8KK1tcon0nJ8sFXO7Qu1X40ky12IZbBOEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=M66osUe3; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="M66osUe3"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4802f9075;
	Wed, 29 Jul 2026 17:16:23 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net v2] net: phy: nxp-tja11xx: cancel registration work on remove
Date: Wed, 29 Jul 2026 17:16:21 +0800
Message-ID: <20260729091621.1726-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260728123423.781-1-getshell@seu.edu.cn>
References: <20260728123423.781-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fad29252b03a1kunm207ca0dd114df9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkweVkkfTExDTk9NS04ZTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M66osUe39eOBGCm+qMoOEBaxr6bpV1ItUp92SfIqICbtwp6Y+gImKaeX9uxqCmwnEI6Iko9ekXil70H8tEZTe5wrHeC7pmDFJqm5udsx7zTavp7uTDjglEEguBbSUCrGwXqnLMiGtAPOr2PKh5hRo43PsnNBNLQa3du4YNEyuWw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=BoCRjQ+N4JAbH+/IG96MmGT5tMLpVInHjsPWhb577T4=;
	h=date:mime-version:subject:message-id:from;

tja1102_p0_probe() schedules work to register the second port. That work
uses the Port 0 private data and phydev. The private data is
devm-allocated, but the driver does not cancel the work before detach.

If the device is removed before the worker runs, devres can free the
private data while the pending work still dereferences it.

Store the Port 0 private data in phydev->priv and add a remove callback.
The callback waits for the registration work before devres can free it.

This issue was found by a static analysis tool.

Fixes: 6a64d3cdc5ef ("net: phy: tja11xx: add delayed registration of TJA1102 PHY1")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
v2:
- mark the patch for the net tree as suggested by Andrew Lunn
- add the Fixes tag
- no code changes

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
