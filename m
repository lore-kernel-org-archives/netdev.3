Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F930274D;
	Thu,  6 Aug 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024046; cv=none; b=C+1RyLWV5nTZ8ZDkEvHNfAg/yeGFukZjkNFvgjf7xaZ092zKb7bgKwufRTMWIqGjeidTGBLurfIrZTNwk4niJwbiMdkmNM2LlZO2VnfYNcmE/UdWh1p6KLlQoB4KcXDE4O5b8nkLujxEueWQRCmXOWDqsxzKpnXRuP1cWQEFIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024046; c=relaxed/simple;
	bh=ZfFus2gnrcpxzpMZI+iDqOBje92JpVyy2X8JuRRk/Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWK/cVS/FvlvfBEAFVQJQ/F2v3L60PDfUZU4Q9ten6wKrOi+L+D1PmL4qCKvvCTfrmdrpV/S/42FGJMuUbcrNqQS28W3mtrDekW/6yvRkyTcf/Ubb31AhMW5ELbVhmRmBu0A66wU3x/AKZnJi6x+fy+0Nt1EKdAgrA5mex10LLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D2B41200F4F;
	Thu, 06 Aug 2026 15:47:17 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wryRJ-0006EJ-2R;
	Thu, 06 Aug 2026 15:47:17 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wryRJ-0000000Ejae-2nRZ;
	Thu, 06 Aug 2026 15:47:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: [PATCH net v1 1/1] net: phy: realtek: fix EEE advertisement write on the internal PHY MMD path
Date: Thu,  6 Aug 2026 15:47:16 +0200
Message-ID: <20260806134716.3511821-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rtlgen_write_mmd(), the MDIO_AN_EEE_ADV case swaps the arguments to
rtlgen_write_vend2(): it passes the MMD register number as the OCP address
and the OCP address constant as the value. The caller's value is discarded
and the write lands on the wrong register, so the EEE advertisement cannot
be configured on the affected PHYs.

Mirror rtlgen_read_mmd() and write the value to RTL_MDIO_AN_EEE_ADV.

Fixes: da681ed73fb9 ("net: phy: realtek: improve mmd register access for internal PHY's")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/realtek/realtek_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index a0a79192384e..177b62a7b2d1 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1768,7 +1768,7 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	if (devnum == MDIO_MMD_VEND2)
 		ret = rtlgen_write_vend2(phydev, regnum, val);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
-		ret = rtlgen_write_vend2(phydev, regnum, RTL_MDIO_AN_EEE_ADV);
+		ret = rtlgen_write_vend2(phydev, RTL_MDIO_AN_EEE_ADV, val);
 	else
 		ret = -EOPNOTSUPP;
 
-- 
2.47.3

