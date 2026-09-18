Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA41C6FF5;
	Fri, 18 Sep 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723049; cv=none; b=U3NcUbvBwRexDDJ2FIDYKd67I+mXEqmVmrdhxf9PbRT/+OHarTawZHkaPbA/MGYIMDDIVDLUt3ZgDeMlqCuamVzhyz0oCDAVZlWYfGX3/WCjC7RraNitYrqNKhOS4etL7hO8AoBi/856fuDpRrwZE+FjgqNeb7UKZ/fCxn6NHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723049; c=relaxed/simple;
	bh=4mZpkxATI4qiyTSXSJVGZ61KAftzgBuhrIfRNPs44+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRynY47OdsSS9ztGW6PWYb9COA/ZjtzUkDrUgI4M7jhCnUqbJ5eiO31FGpt9yKyhnIuVURMNH6Cf2wCOYZMJhQc43JAvPI5MUCgLKHn/2yJkckNeHKwHcg70C+H+IR+HPROrKV+lLn9GQfAZ/6QDO7BzateQZjYip3UkHDAgktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 621DD200109;
	Fri, 18 Sep 2026 11:17:23 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x7Uih-001XsG-0w;
	Fri, 18 Sep 2026 11:17:23 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x7Uih-0000000DipI-0rXC;
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
Subject: [PATCH net-next v4 0/3] net: dsa: realtek: EEE support for RTL8365MB-VC
Date: Fri, 18 Sep 2026 11:17:19 +0200
Message-ID: <20260918091722.3270534-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On these switches EEE is enabled by default, but so far it is neither
visible nor controllable from user space. This series wires EEE up to
phylib/phylink on the RTL8365MB-VC integrated-PHY ports so it can be
observed and controlled per port via ethtool

Oleksij Rempel (3):
  net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
  net: dsa: realtek: rtl8365mb: extract PHY OCP address halves with
    FIELD_GET
  net: dsa: realtek: rtl8365mb: add EEE support

 drivers/net/dsa/realtek/realtek.h        |   4 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 137 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl83xx.c        |  20 ++++
 drivers/net/phy/realtek/realtek_main.c   |   2 +
 4 files changed, 161 insertions(+), 2 deletions(-)

--
2.47.3

