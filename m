Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C044AB90;
	Wed, 16 Sep 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549293; cv=none; b=chOXh28ZOPHgjEyrfOpcJjpNVGabd1lq/BfBOZSrnSnRkt2C+Z62DwpFfEGvW1ktsK2zaPD2jhRVxec6ythfaltoFHRb20h9PiCisqORqbp6wxFQF15UAMqqOwGOS5hkS0wJkWuzfpB741EZsLh1vQDqtDoaQp4v3jAUyNgv6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549293; c=relaxed/simple;
	bh=91wbg/bu2gtyMOvzzNBAgNWwZMHv8M2P9CRKkGct2lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Svx5qk+EE1zofiTI+hQC6jGLWgQiJTU4kEBc4cm3lvmtwKnZy3pb6J7pQg1SZH/vTLDSk9xQiG/XKQnX6gdj3PsH+t2y5dh/sriY9ofgn/m2UAHR1n/johHiUl4SPlJpPOBG2kVbwKTL5TWt4uQV4xGG26UYcQHAnPJuhmGU9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: andrew@lunn.ch
X-PTX-Original-Recipient: luizluca@gmail.com
X-PTX-Original-Recipient: olteanv@gmail.com
X-PTX-Original-Recipient: davem@davemloft.net
X-PTX-Original-Recipient: edumazet@google.com
X-PTX-Original-Recipient: linusw@kernel.org
X-PTX-Original-Recipient: kuba@kernel.org
X-PTX-Original-Recipient: pabeni@redhat.com
X-PTX-Original-Recipient: o.rempel@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: a.fatoum@pengutronix.de
X-PTX-Original-Recipient: alvin.sipraga@analog.com
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: netdev@vger.kernel.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A2A43201F41;
	Wed, 16 Sep 2026 11:01:03 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x6lVn-001CpY-1b;
	Wed, 16 Sep 2026 11:01:03 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x6lVn-00000001SqV-1lRk;
	Wed, 16 Sep 2026 11:01:03 +0200
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
Subject: [PATCH net-next v3 1/3] net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
Date: Wed, 16 Sep 2026 11:01:00 +0200
Message-ID: <20260916090102.349157-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916090102.349157-1-o.rempel@pengutronix.de>
References: <20260916090102.349157-1-o.rempel@pengutronix.de>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Anticipated reviewer questions:

Q: .read_mmd/.write_mmd now use the C45 helpers, but the DSA user MDIO bus
   only gains .read_c45/.write_c45 in the next patch -- is this bisect-broken?
A: No. Until then an MMD access returns -EOPNOTSUPP, but the only one that runs
   is the EEE-ability read in phy_probe(), which phylib ignores; probe, link and
   traffic are unaffected. ethtool --show-eee reports EEE unsupported here -- the
   same as before this series, since these ports gain EEE only in the next patch
   -- so it is not a regression. Verified on an RTL8365MB-VC.
---
 drivers/net/phy/realtek/realtek_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 97b0b67b9900..b55691681df6 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -3338,6 +3338,8 @@ static struct phy_driver realtek_drvs[] = {
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

