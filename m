Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61123F6C4F;
	Tue, 28 Jul 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223922; cv=none; b=trlHVXuXTm13pQOXlm4m91ilt7PPxBUnlWF6UNDB1yoG5xpCR/wcnmOB45/i+JbCeQXMIwBeYiLaHoTWto03kljqEFGUDioeFZ7EJg5IjcSCDH7jaIOVzSK4wwJEl9Qj+t59ZK89eTnl9NQVys+K1XbUcyHmtAJIYq8LbLxfD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223922; c=relaxed/simple;
	bh=npK3GhiQuqqQxvf5iJQV021mIN99QsEr6SqwPf7ekCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuTJbjxAz332F/DqpKWNe1w403UOK/TULOcvgsdYQkTrVnr+4ghUV3hh17F0wBG5RgRKH5L7OOtOUOkiTdWHDe+siHON+AAB58iXB4emKQ8myU1XEfpjawulPmtQ8z2Mg7y1xijEvAa6n/HW3VlxsnaOE4l9W5BCQEwbWQHQbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=IRk/fw09; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="IRk/fw09"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66S7V9ttC3681099, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785223869;
	bh=+SA8PSYEhCkAa/He9LHYOTIXfQPnE5uYt+3wPWnh8AY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IRk/fw09RWTlUaBypPu0B9TCvmCDtSq8hxO5fpCp9fzt+pFcBbHDXEV+ACEz41HIh
	 XqE02SO33Y6bF8A7LtEdlsDK4G3i9RrY9FMxa/WqNGvZ7Q3oupIUX87EIf0L9+fV/7
	 yoirlTH7JapUWdR0Fi3x5QhyoLq/Y/Qw3foIVtGDRd7QSerBe0t4P5udWORU8rLNVw
	 VhMNT1opKyT01e9POMeVHGFR8ufiGC9JNHgYX7J6WOdEeSW4/cvd2pTT71bR7HFVtg
	 ZapOb9TWyig7KXbWyuzo8cKkJjjeiram8VasbXNezHqpRzgopb4535R1wtVFQ1YX8H
	 vgA5t5rKdndOA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66S7V9ttC3681099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 15:31:09 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 15:31:10 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Jul 2026 15:31:10 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v11 5/5] net: phy: realtek: add support for RTL8261D
Date: Tue, 28 Jul 2026 15:31:06 +0800
Message-ID: <20260728073106.1515-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260728073106.1515-1-javen_xu@realsil.com.cn>
References: <20260728073106.1515-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8261D is also 10g phy. It's sub_phy_id is 0x81. And it does not need
any firmware.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v10:
 - no changes. New file.

Changes in v11:
 - rename .name = RTL8261 to RTL8261C/D.
---
 drivers/net/phy/realtek/realtek_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ba218559f39c..a0a79192384e 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -260,6 +260,7 @@
 #define RTL_8261C_CG				0x001cc898
 
 #define RTL8261C_CE_MODEL		0x00
+#define RTL8261D_MODEL			0x81
 #define RTL8261X_INT_AUTONEG_ERROR	BIT(0)
 #define RTL8261X_INT_PAGE_RECV		BIT(2)
 #define RTL8261X_INT_AUTONEG_DONE	BIT(3)
@@ -413,6 +414,10 @@ static int rtl8261x_probe(struct phy_device *phydev)
 		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
 		break;
 
+	case RTL8261D_MODEL:
+		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
+		break;
+
 	default:
 		phydev_warn(phydev, "Unknown sub_id 0x%02x, default behavior\n", sub_phy_id);
 		return -ENODEV;
@@ -3397,7 +3402,7 @@ static struct phy_driver realtek_drvs[] = {
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
-		.name			= "Realtek RTL8261C 10Gbps PHY",
+		.name			= "Realtek RTL8261C/D 10Gbps PHY",
 		.probe			= rtl8261x_probe,
 		.config_init		= rtl8261x_config_init,
 		.get_features		= rtl8261x_get_features,
-- 
2.43.0

