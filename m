Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1793A8734;
	Mon, 17 Aug 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974493; cv=none; b=ccoFGUwCEtaoOINWUUZQZZ678+80bHhzUlhD4wqgNANPTsEU86wAVcMaVcDwEN2UQzp5+dtyFe+tBTLs84B1qub7SijbcWt4xYJzzos8xkAgXTLiNkQsfp4g6CkUTYPoz/zqyMo4RsgblH2ooKdzG/gXVKaRq16K+4gwRo/dLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974493; c=relaxed/simple;
	bh=GNAwFUGh2+vKS7191QO3ZeDT8Gd1dTAqi2SS1koRCYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzfHB7qlc2j20XF/yp4uIT3cbYZ07woUqAf5qUwWu/rRbctPtiZTG9xS4kNtwKILHkr9Oi6ZNEYP1SdIOAeuhc/GDCoo4Gvuo+YPnX2oJwIV3N4fF2OMWjmAaEUB1DNjqzz9x8EwxuI19KcuC/Lauilj6iJqAgavpsOU6HC3y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 39A7C200C95;
	Mon, 17 Aug 2026 15:47:59 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wvxh1-001xpX-0P;
	Mon, 17 Aug 2026 15:47:59 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wvxh1-0000000HY9u-0Dsg;
	Mon, 17 Aug 2026 15:47:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/2] net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
Date: Mon, 17 Aug 2026 15:47:57 +0200
Message-ID: <20260817134758.4182833-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817134758.4182833-1-o.rempel@pengutronix.de>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8365MB-VC PHYs are integrated into the switch and have no MMD
registers of their own. What phylib accesses as MMD registers (EEE)
actually lives in the switch's OCP registers; the realtek DSA driver maps
those MMD requests onto OCP and exposes them over C45.

For a C22 PHY, phy_read_mmd()/phy_write_mmd() would use C22 indirect-MMD,
which this hardware does not implement. Point .read_mmd/.write_mmd at
genphy_{read,write}_mmd_c45() so phylib's MMD accesses go over C45 to the
DSA driver's mapping instead.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/realtek/realtek_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 177b62a7b2d1..ad8017e91b4f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -3388,6 +3388,8 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc942),
 		.name		= "RTL8365MB-VC Gigabit Ethernet",
+		.read_mmd	= genphy_read_mmd_c45,
+		.write_mmd	= genphy_write_mmd_c45,
 		/* Interrupt handling analogous to RTL8366RB */
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
-- 
2.47.3

