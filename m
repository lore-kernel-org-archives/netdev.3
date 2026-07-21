Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEC3FD960;
	Tue, 21 Jul 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600760; cv=none; b=qV2v0NIl5gTtGNxejfTTH83cguZkeFKhQI2ooP+ZCdxBj1dHLs0yQ2WRTb8H/bOJZF634YENoIFnQTzf/1DIZSostXwUprTFp/x+2tTdzYs1cRebziNJbikMz2L2rRjKy8FOKHbqgblziBzYKcPIhTo/lKiIIKMacTzKnq+qlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600760; c=relaxed/simple;
	bh=y5WrvcsuUblRyUtZbHEmnxHmOraXMzZOGPaaVHDfYRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbM6MJNZj/cQq9NLHU8y6RyrSmPztgtIs8EXHFPRM4dyK6gttWTt81RDrckRjjmYqsG4fBKTQnw1/5G8V6XwH9eW5cRvfbyJFmovva+n2pqvQxyEgfK5Fxu64yAra3XG4s/p7OhlZVvJIRKf4pFmC0Ym7yhcGjB7vokwyryP1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Ecid64a0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Ecid64a0"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L2OF1W02860135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784600655;
	bh=v3FB5AxMqgd8L9yl3rgnxZmaXywV19D/v9zzcnCXYLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ecid64a0tgRQf+KT2jQljSmV5nLjrfpUSoEpI/dp5Gn9JGkS1ev72TILtnZS1QffD
	 F3m7yl/p8DWOK5CjpzJab41vfnXiNyu/P1mMqJO+0DhetX7ySTaLgrNr3cCAU9fviz
	 hYRe48Hz+k+SyKCD0JyQugL1jDANDYEpfAVT2OG+v5LM7Td9LRn8WhervIutYTG9Lt
	 N1Gtbj/Oy/dRdGkjebivjukc/UqP8RTkfXcPmaRb+RKNG9kS7vxr7TOGgGjIgu3NTf
	 c1yI1Q51LTHQRhfi8PkXzS3dm4MJUSTxxhhREFNZ0UBfQqTOWRNloGBDPyNamJUGQ1
	 INFnvqRvviotA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L2OF1W02860135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 10:24:15 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:24:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 10:24:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 5/5] net: phy: realtek: add support for RTL8261D
Date: Tue, 21 Jul 2026 10:24:10 +0800
Message-ID: <20260721022410.1391-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260721022410.1391-1-javen_xu@realsil.com.cn>
References: <20260721022410.1391-1-javen_xu@realsil.com.cn>
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

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v10:
 - no changes. New file.
---
 drivers/net/phy/realtek/realtek_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ba218559f39c..1c0b9c40a81e 100644
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
+		.name			= "Realtek RTL8261 10Gbps PHY",
 		.probe			= rtl8261x_probe,
 		.config_init		= rtl8261x_config_init,
 		.get_features		= rtl8261x_get_features,
-- 
2.43.0

