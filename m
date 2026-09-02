Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABD3E7BA0
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338065; cv=none; b=sQ6g9JE+aNBGye77O6deXKKvnxh4IoKLDkdeuaVc5EO8mJnuLyUOTeT29nzIqE4TABiVJtID5mQNnHbZx/oCM0D0VxBo9GDTGH6ZPABEUyhr6GkXHtoOjH8zDCAeMIYTvOtDTFqOkEUKJy4hYRc/XKpKSSHUFqAKsB/FWJk52MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338065; c=relaxed/simple;
	bh=+BGW2TdHHMlAmTLl9Cng2FWDfac/lUv0EMe0agbScOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=edXkNx+8vQ5MiBIGF6DmtDkrwTfY+YL0ONRy3dUaBnR9xBG0pQ8leZJc6ohC8QvfPMjhpzuf9lMX5C6WYyIl5LdfXWvVqr6a+XWJd1uBvMlJNls+qpg1EtImfuTF40EnudndubrgwdpEK+cTAm2JtCF4gAT5IRM+5+m7VUCbGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HfmSs0FX; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HfmSs0FX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s6
	Cjm7g5Z6qOMJYombXPmtz7FrdtDFAD8qCGS6asI2g=; b=HfmSs0FX1TlhZ6EHVM
	8ARMtOPF+hG9dIiQdtuP5+VN/cQZRqgEQnWxE1k2ib0UM92RIYplP9Wog+12cAl4
	V3PpbBts1gO/9Xo8W72ruqUoBgMs4/NQRLUpC7ZeRAawtkMGia8e2Y3S+GIdQMGO
	Jh9GoLkeFbgmsIwtnyt4wSxyY=
Received: from ubuntu.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCX92Zv35dqGkJYAA--.12854S2;
	Wed, 02 Sep 2026 16:33:55 +0800 (CST)
From: huhai <15815827059@163.com>
To: kuba@kernel.org,
	andrew@lunn.ch,
	divya.koppera@microchip.com
Cc: netdev@vger.kernel.org,
	huhai <huhai@kylinos.cn>
Subject: [PATCH] net: phy: microchip_t1: fix NULL pointer dereference in lan887x_phy_init()
Date: Wed,  2 Sep 2026 16:33:42 +0800
Message-Id: <20260902083342.221050-1-15815827059@163.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX92Zv35dqGkJYAA--.12854S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw17Aw45tw1fKr1rAFy5Arb_yoW8Ww1fpF
	4furyFqF1DXw45Ww18tFWkGr1Yv39rtrykuw4rGwn2qw48AF1DGa9rta4UWFy5GFW8XayS
	qw4jva45CF1kZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um-ewUUUUU=
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbCzRSVG2qX33TlFAAA3w

From: huhai <huhai@kylinos.cn>

mchp_rds_ptp_probe() may return NULL when CONFIG_PTP_1588_CLOCK is disabled.
lan887x_phy_init() only checks for an error pointer before using the returned
clock to configure the periodic output pin, which can result in a NULL
pointer dereference.

Handle the NULL return as PTP being unavailable and skip the event pin
configuration in that case.

Fixes: 8541fc12edcd ("net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal")
Signed-off-by: huhai <huhai@kylinos.cn>
---
 drivers/net/phy/microchip_t1.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 3292b2235c8f..e38d20bf6aa4 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -1285,14 +1285,16 @@ static int lan887x_phy_init(struct phy_device *phydev)
 		if (IS_ERR(priv->clock))
 			return PTR_ERR(priv->clock);
 
-		/* Enable pin mux for EVT */
-		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
-			       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
-			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
-			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
-
-		/* Initialize pin numbers specific to PEROUT */
-		priv->clock->event_pin = 3;
+		if (priv->clock) {
+			/* Enable pin mux for EVT */
+			phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+				       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
+				       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
+				       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
+
+			/* Initialize pin numbers specific to PEROUT */
+			priv->clock->event_pin = 3;
+		}
 
 		priv->init_done = true;
 	}
-- 
2.40.1

