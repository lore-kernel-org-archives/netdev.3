Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6A3EB0F4;
	Tue, 28 Jul 2026 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242073; cv=none; b=MvrIeFkAFe86YFr/Hrvatk5XKtHrlT9g+XDvdib6LGJXKRWSsurYrEWCiKSxRc5mJxD4ps794L5pk6Sy3OSNzwAKYE7807yDLq+rl18JL1c1hOxjIhZ10aNEHbxZQ3g2ZHmTpBjDjlO07cLxEWLjRgY5YHcNZZPuW9ef1pHPYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242073; c=relaxed/simple;
	bh=68pnB9/8lOrA/TRpG96s5Pz13QQKtJE8EzW2lHW26L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re1WOUd/SvCjcSp6MDtCLr+GO73x3lytzBZv4DBK2880ydxVgqRZu+LIK6NsRXFEcgJGKC+pgUfdGx4YIeCuZ5EZbihDgqXSqPOa16RuaJDXU2oOMIryWiJ0U2a9QJFgEazE1KbsFn83VMKDOIVUWBy37RfNuxJcx+lfoqtggKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ErX+UaCZ; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ErX+UaCZ"
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47e10a908;
	Tue, 28 Jul 2026 20:34:25 +0800 (GMT+08:00)
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
Subject: [PATCH] net: phy: nxp-tja11xx: cancel registration work on remove
Date: Tue, 28 Jul 2026 20:33:35 +0800
Message-ID: <20260728123423.781-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8b8171203a1kunm4c64fbaeeece9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEpCVklPThodGR9LHxhLH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=ErX+UaCZSu4DwzBtZd6ZjndSLzshwi8DiC3pYj+e0tLqUHxYHv4ket1s2e5MUhYvRWWJL9r5z2H4Nh9o/ggEdAZtu5D2o46cyCP43Jde0RtVYGeaSGgh88TzBYX+jRrcp8rAHpVtWP1utnfBz8ByoJNezZJkorVlFnTz03/vTHk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=WzGV7IEq5vFiZnpU7ONYnrWIFeFanYHdMqdo9f2Av6Y=;
	h=date:mime-version:subject:message-id:from;

tja1102_p0_probe() schedules work to register the second port. The work
uses the Port 0 private data and phydev. The private data is
devm-allocated, but the driver did not cancel the work before detach.

Store the Port 0 private data in phydev->priv and add a remove callback.
The callback waits for the registration work before devres can free it.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
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
