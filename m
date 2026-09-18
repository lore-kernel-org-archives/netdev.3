Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F25369D5E;
	Fri, 18 Sep 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723049; cv=none; b=g9T75Uk4UpBUSfHg8gp2nEhcFCAceqsaHjOzLVBMlgZkT/EqvlKjtwEodDdWAS8ojiF4qwSLsDu7Qwva6qKQ4qmi1JzvZbm4jVWMaDtIsI3SEocY8ggEjqyPB/3HsJQmswS8fJDY2Wt8jvgQVhZaqD7Xfw1TCLDLxpT8HdXR10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723049; c=relaxed/simple;
	bh=wpgsYyTnoD6zTUngzBpCsXnvUjR9zXwoSjfHF2CjZts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj++wTYtZzJ82AkCrCneaY4RoX3p6fe8bkuGg6Jac6dVcj0UzgLp3JNs6psKL7f4DdkvZB+vUbrerilfq6S9nBZl4aDwV6Lpm3z+5tVx3SRYV2DePXiCAlItLbQ/jSlIPNpJByilex4imoYewOUsyRXwG3XsEcR8xWlMokka1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 65642200496;
	Fri, 18 Sep 2026 11:17:23 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x7Uih-001XsH-11;
	Fri, 18 Sep 2026 11:17:23 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x7Uih-0000000DipR-0ywI;
	Fri, 18 Sep 2026 11:17:23 +0200
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
Subject: [PATCH net-next v4 1/3] net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
Date: Fri, 18 Sep 2026 11:17:20 +0200
Message-ID: <20260918091722.3270534-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918091722.3270534-1-o.rempel@pengutronix.de>
References: <20260918091722.3270534-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8365MB-VC PHYs are integrated into the switch and have no MMD
registers of their own. What phylib would access as MMD registers (the EEE
ability/advertisement) lives in the switch's OCP registers instead.

For a C22 PHY, phy_read_mmd()/phy_write_mmd() use C22 indirect-MMD, which
this hardware does not implement. Point .read_mmd/.write_mmd at
genphy_{read,write}_mmd_c45() so phylib issues those MMD accesses over C45,
where the DSA user MDIO bus can carry them to the switch's OCP registers.

This patch only redirects the MMD access path; it does not enable EEE. The
OCP mapping (the DSA bus .read_c45/.write_c45 handlers) and EEE support are
added by the following patch. Until then an MMD access returns -EOPNOTSUPP;
the only one that runs is the EEE-ability read in phy_probe(), which phylib
ignores, so probe, link and traffic are unaffected and ethtool --show-eee
reports EEE unsupported -- the same as before this series, not a regression
(verified on an RTL8365MB-VC).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Changes since v3:
- Commit message only: state in the body that this patch only redirects the
  MMD path and does not enable EEE (that is added by the following patch),
  folding the prerequisite / no-regression note from the anticipated-questions
  section into the body; no code change.
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

