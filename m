Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6F3B0584;
	Wed, 29 Jul 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337703; cv=none; b=FTiFi/4l7Dq7x7lcqRF50OBl4tt+Nb+YCJVepybh83guzieHdvDIngsCCMKZgUN+QVjoED76Yb4WVE2Rupjb/ibH/benVMHjHg9LCLCoxG/vwvrgBs2ozmpSCnNe7unZmvajAsImkT2TMDidaZNXI6oWdXT3y9FHI5o1OGGwu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337703; c=relaxed/simple;
	bh=ruNYugqnHPy5dFa9sEEiDO+GE7grFo6khi5/3XKEAec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOWD73qMylri56JOlNkqqlNYQ3RoWWUDGUFMKUXN/+Xp3IivEkLPxh6pdLOeMYV8Q5Jela3Tnl79f3uP1IcqLqRn/6fzHXbeomm4hg5pv9qW+alsMtpoKTrAGMCQRFLP7APu1DJN2dryh2/czDitxHmLfDPz/LcP9MYeFXt8avY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ervXSDgX; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ervXSDgX"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 480b597c6;
	Wed, 29 Jul 2026 23:08:12 +0800 (GMT+08:00)
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
Subject: [PATCH net-next v3] net: phy: nxp-tja11xx: cancel registration work on remove
Date: Wed, 29 Jul 2026 23:08:11 +0800
Message-ID: <20260729150812.1695-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260729091621.1726-1-getshell@seu.edu.cn>
References: <20260729091621.1726-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fae6b40f803a1kunmee69ff4d11fd53
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhlLVkJKTU9DHR5PH0xLSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ervXSDgXydx6+bWXLZkUG4bGl3de8m8xQIcDhCuzwDVIOEv3kgbihFK/qSTxBlxAXI9wDa2hkY1yh1jtf97yDomV00zPghpmMipffcQnNBrdv8+V+Q2wDyZVOtMj43cnDVjqf66CGTmIrmFcWusJ6ZCjhMjXFAytpwj+nHuC45k=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=31o8hf8JV8hmXybfzY2oPrzJ/uRXG0BzNjxK2p2+GRg=;
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
