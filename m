Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA35511237;
	Fri, 18 Sep 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747941; cv=none; b=D68f31CijI4k0tw/rEClePQFXvRovMgVErXizy0iKfKOhEN13ndv9mTU0nsKOOLeyZ0/gMEeBvdz72xkBakV1/u11v4PbkBSB9QUTw7d8EmoxU6joDLu5oDewxs3hOth1wJ9K/YZRO1Kznv4nv3CX0om1ObhFsKX9ysgr/mxUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747941; c=relaxed/simple;
	bh=OJH6hx0nA6yyBvhmDQ1IwSjnsHCV66logSjjurpz3lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGv37nJBAh7PovarVRw7vwIj9Mvp/TOJ5+faSz3ll27YxedgMt5Bzx9zuvd5yACc16ui6YbtdZLHUnzcYqB2Mf0pbqzKfyO+vnFfQgRpbKicRoHmLO4LOHKiInlSYiAbFCgcT13/btR4TiTqzDgFEwQO/NGSzgqK5/3BDwUHcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=IU+Sa0SC; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="IU+Sa0SC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9FD4E2396;
	Fri, 18 Sep 2026 18:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789747932; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KJDSnN54e6nHoVHI3hmkPcATaJ7eX7EbuynT3I/CgVs=;
	b=IU+Sa0SC7beHmdw2MSK4P/O7aAu25uLSTXaSTrVN+eAouJYEIgoffuEjLOBxEzfFzK81rW
	7mZU+yb8cGTbqN0Zz1aeJP161GroHj4nEUvB8Pu26vWvx6dKpi/lNH8u25r/31rbp5/WS3
	Z2FlBKJhvmGQjt4M9hF7OiM/agJ3GnG7CKx0cknRfz7RTXB0GPXWhJnkJDmeSpfB/ZaAU9
	fukxQSqr5y1FTtsWZcz4MAiYX3RJpLV2ZdaguX+C5wD0GeBkn5bwc/WhnaktDpNslUxV1t
	ZmX0dfXfqP8A7t6y37nCA1L87ocdywUK6GV4STg2InvTf7jZ4iHzqUidNcq42Q==
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
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH net-next] net: phy: mediatek: do not match MT7530 PHY if 10/100 only
Date: Fri, 18 Sep 2026 16:11:56 +0000
Message-Id: <20260918161156.377822-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

An EcoNet SoC 10/100 PHY uses the same ID as the MT7530 PHY, but a true
MT7530 PHY always has gigabit support so they can be distinguished by
the presence of the ESTATUS_1000_TFULL flag. Add a match_phy_device
which refuses to match if the PHY is not gigabit.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
This supercedes [PATCH v6 net-next] net: phy: mediatek: support MT7530 PHYs on EN71221 MCM
Link: https://lore.kernel.org/netdev/20260917130534.297930-1-cjd@cjdns.fr
Because after the recent EEE disablement in the driver, it is found
that the default MT7530 PHY driver does apparently work with the EcoNet
MCM MT7530.
---
 drivers/net/phy/mediatek/mtk-ge.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 96d8ac5154e5..f801966bb4ee 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -101,6 +101,18 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+/*
+ * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
+ * does not advertise ESTATUS_1000_TFULL. Match this driver only if the PHY
+ * advertizes gigabit capability.
+ */
+static int mt753x_gphy_match(struct phy_device *phydev,
+			     const struct phy_driver *phydrv)
+{
+	return genphy_match_phy_device(phydev, phydrv) &&
+	       (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0;
+}
+
 static int mt7531_phy_config_init(struct phy_device *phydev)
 {
 	mtk_gephy_config_init(phydev);
@@ -135,6 +147,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		 */
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.match_phy_device = mt753x_gphy_match,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= mtk_phy_read_page,
-- 
2.39.5

