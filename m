Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A944A403;
	Wed, 16 Sep 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546562; cv=none; b=g7NBvv6ubd9CXwsCGYQyMQbx69RdwaXazbOTxSlWR1UL7hA7ii1gj7LPjIzf1YQCt6SI5qfxOcdI9AUoFj1bZGNQU6WP6ehYgGsM9Slpk5ax/j7f0d4Neapf4W1lzL9Q2P8oxgmd8XBOR3CNytKoa843m25PDKPUJOSVoqO82Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546562; c=relaxed/simple;
	bh=qE8jhYIvwaKVFax4xv5AiOwt5Qho1A/NXpV3jMyK5Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Thh/NjF4lPMS9ACf3sQOmC4U9hNBOo8M68zo+M6sqFKQURW3XS33r4rRyOXsaRzUlntJ9qAWXMEggUydjNV8kugS1vyOAb1OatiRuUOwuimEeQLjDwX6G6JQpCCWrJq7zd93rKgEajcx/6gDNcaebfAZwJxBNRuEXAW9pCN4KGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=s3j1W+Mu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="s3j1W+Mu"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68G8ElRR22223080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789546487;
	bh=SRGeMPku5l2vTjpAIT+lBQj4fW755JN9tnfcxRaVKwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=s3j1W+MuVh72jTnlPI3ZBDSKI1n+YNpc5cxt7Qy67gpXx6ndoGm4mflEogoCAMsDa
	 Fbhki3P73O90xA/x8r9jYzMYgntu7gKKHrigZe5SZ6+K0XLBL8EBKlVxytwvULiPR0
	 Omd281+O2UrXT8D+RQKUL3zQtd63MeEXu4wh2nHfDgDzJz83xyRpEIP4c/jts6RdKI
	 b0NGXd0Jw2upQt7yVFPBHT3VUZzlv0qTGME1/OnnAbp4xhzpSDI1CKAz7TR8DH72ND
	 engGiQu+mN2o214yaQx9R/SYQnf0dqUlp6WJhaTuatNTCpqzY2uujTuAenKEobFbvG
	 ATEKqIEYGK8mg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68G8ElRR22223080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 16:14:47 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 16:14:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 16:14:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 1/3] net: phy: realtek: add support for RTL8261CE_CG
Date: Wed, 16 Sep 2026 16:14:42 +0800
Message-ID: <20260916081444.497-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260916081444.497-1-javen_xu@realsil.com.cn>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261CE_CG, its phy id is 0x001cc899. RTL8261CE_CG
share the same sub_phy_id and firmware with RTL8261C_CG.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 97b0b67b9900..d0d09e8e8f5c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -257,6 +257,7 @@
 #define RTL_8251B				0x001cc862
 #define RTL_8261C				0x001cc890
 #define RTL_8261C_CG				0x001cc898
+#define RTL_8261CE_CG				0x001cc899
 
 #define RTL8261C_CE_MODEL		0x00
 #define RTL8261D_MODEL			0x81
@@ -3363,6 +3364,19 @@ static struct phy_driver realtek_drvs[] = {
 		.soft_reset		= genphy_c45_pma_soft_reset,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(RTL_8261CE_CG),
+		.name			= "Realtek RTL8261CE 10Gbps PHY",
+		.probe			= rtl8261x_probe,
+		.config_init		= rtl8261x_config_init,
+		.get_features		= rtl8261x_get_features,
+		.config_aneg		= rtl8261x_config_aneg,
+		.read_status		= rtl8261x_read_status,
+		.config_intr		= rtl8261x_config_intr,
+		.handle_interrupt	= rtl8261x_handle_interrupt,
+		.soft_reset		= genphy_c45_pma_soft_reset,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
 	},
 };
 
-- 
2.43.0

