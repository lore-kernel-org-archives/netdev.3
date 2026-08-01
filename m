Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF712F28FC;
	Sat,  1 Aug 2026 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593214; cv=none; b=eEiLITMP9HJ3Gcuh059oKXqDvyHil8fYCniybHU44PrVB3JDzTKMhYWLljfrv+KMck1KTJyUr23/ZEgOPuKsHyVu1LWhDKYemWcn/RvRRvOMMlbGig0Cts4iu4IIuPceuOCR2meII0uucROtXGLW5EQ3BZ/LKCGGa5yYHTPNx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593214; c=relaxed/simple;
	bh=0BQaIjrZiQjdWH/z//9tLwTT2L87qHOu66aNbP2ca6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe+HA8U1nBy3y0c0MzrV7qPmH6e0hDp8ACZHDDv6oSd0LqHqYygOQDmWHE3A9njzFBx9ZBeFE9/KziM5xJIpfkWYfTaQiRqYEtUMYmKJz9lmQ8G4h9pnFoF5Yhh+zEKdq8HXVu/5u+eCl7OfX/MJxdWmLVCI/2Izg0/PKzX9T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=id3eb6kC; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="id3eb6kC"
Received: from LAPTOP-99KJFSET (unknown [211.69.128.50])
	by smtp.qiye.163.com (Hmail) with ESMTP id 486a5481d;
	Sat, 1 Aug 2026 22:06:45 +0800 (GMT+08:00)
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
Subject: [PATCH net-next v4] net: phy: nxp-tja11xx: cancel registration work on remove
Date: Sat,  1 Aug 2026 22:06:43 +0800
Message-ID: <20260801140643.1871-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fbda60ff603a1kunm35d1f6081a7d49
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh5JVh8aGR9OGk4dSB9KSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSkpVTUJVSklDVU5LWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=id3eb6kCfZ1EMKAWgrKUBjxe2BK0EtZ/kucFV5HPyPeVNjARAANB75V0wgXFnRkD12x4pHufvqb83XB8rUQHLrSFKwDwUq/ZJxvuHVpCBY72ZUe86r+kJMReQNnaqgqKC7bBaC5egwFZ8snHay2P3Va51/TBm0lhU/t7Fa8HCOA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=lui740vOdfCKf22Uf2HUM/cjd6TI1l3obVrqiFR+cJM=;
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
v4:
- post as a new independent thread after the required 24-hour interval
- no code changes

v3: https://lore.kernel.org/netdev/20260729155322.319-1-getshell@seu.edu.cn/
- drop the Fixes tag and target net-next instead of net
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
