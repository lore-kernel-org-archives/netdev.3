Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08C485949;
	Wed,  9 Sep 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989609; cv=none; b=psFSU7cjhy7CSl/359CKv3tY52oTspvO3HQQjKFJYj3u3SgRg/CWvp9aNv0Sh2ToFljqcORpyT8Kv7z0jLz5Xg7aGODDoFarOTEecnV6aW1/nlMIbiWYA7QHwk8OEY/v+tp89bUbzYt5vCUcoNWB9VE1ZVEfGzzSnub0BilOcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989609; c=relaxed/simple;
	bh=834eDjOan/A5adnG3hsLjh7NHyS9qItlttjBQ8iMDKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qd5pkqVsbzCbBNiZJrxDZAuww7SaW22Q5SJxiZX0brDsfGsLhu0a951vnS7lKwTixoZi3hSbOMqv+bQuXokwQx1J3w6f/CWXSe5yqL/65yZ8EWP5fxLzMwfHr58Cn2FIPMIK2AE+krXnmN+YX3vg1FOnxLgpB0GGmWSYyoIx5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=njbNHfNm; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="njbNHfNm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55D76408E9C;
	Wed,  9 Sep 2026 23:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788989589; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=V/qlTnUfYfGp2JdX/hItZG5Gee2j7Ew0nxnFZ6sxuQ4=;
	b=njbNHfNmVsDqxX50TMx4/HC1qNAlT73XFtEcqOCX+5q5vZN+umf7CVN2biX8IYFOq7QTmY
	fPkiBhd8WynUvTvHrd6efRjK5N+Sbtaq3XTkjYOXX4bRr+V+rrGdh2n3VYzYoTocINjWgP
	BUSJT38c1rt9hxPDekC0tPn0FXUgC0wVkrmbTKOSEKUlQl+99LgczV5aZ8HSQCQ6MRWsI6
	jV0SE3HZ46FstACiVBZMtrnt+7jaX8iFk3285cZlcxT1VLES+IOAZBS0L1gwEcCIbPrK+J
	lGsgQe3MsVoKmGLIcoRwV/9P5TGvDVOFmtUNhunF4QUD9PNjrQyvyE4nZSn4kA==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on EN71221 MCM
Date: Wed,  9 Sep 2026 21:32:50 +0000
Message-Id: <20260909213250.3184238-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 multi-chip module implementation of the MT7530
requires some additional configuration of the PHYs on startup.
The reason for this is not known, but it is possible that it has
to do with the fact that the EN751221 MCM implementation of the
MT7530 runs at an abnormal PLL frequency (362.5Mhz).

Detect whether the MT7530 PHY is attached to the MDIO bus of an
EcoNet EN751221 switch and if so, apply the necessary register
updates.

Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/mtk-ge.c | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 73d9b72f9d9e..42b06c40d703 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <linux/of.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -62,8 +63,68 @@ static void mtk_gephy_config_init(struct phy_device *phydev)
 		       FIELD_PREP(MTK_MCC_NEARECHO_OFFSET_MASK, 0x3));
 }
 
+static bool mt7530_phy_is_en751221_companion(struct phy_device *phydev)
+{
+	struct device *parent = phydev->mdio.bus->parent;
+
+	return parent && parent->of_node &&
+	       of_device_is_compatible(parent->of_node, "econet,en751221");
+}
+
+/*
+ * The EcoNet reference implementation applies additional tuning to
+ * the PHYs of the multi-chip module MT7530.
+ */
+static int mt7530_phy_en751221_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_soft_reset(phydev);
+	if (ret)
+		return ret;
+
+	/* Clause 22 local data. */
+	ret = phy_write(phydev, MII_CTRL1000, 0x1e00);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_1, 0x14, 0x3a04);
+	if (ret < 0)
+		return ret;
+
+	/* Clause 45 global/local data from mt7530GePhyCfgLoad(E3.0). */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x0417, 0x7775);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00a6, 0x0350);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0012, 0xd210);
+	if (ret < 0)
+		return ret;
+
+	/* Vendor profile disables 100/1000BASE-T EEE advertisement. */
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x003c, 0x0000);
+	if (ret < 0)
+		return ret;
+
+	phydev_info(phydev, "EN751221 companion MT7530 E3.0 PHY profile loaded\n");
+
+	return 0;
+}
+
 static int mt7530_phy_config_init(struct phy_device *phydev)
 {
+	int ret;
+
+	if (mt7530_phy_is_en751221_companion(phydev)) {
+		ret = mt7530_phy_en751221_config_init(phydev);
+		if (ret)
+			return ret;
+	}
+
 	mtk_gephy_config_init(phydev);
 
 	/* Increase post_update_timer */
-- 
2.39.5

