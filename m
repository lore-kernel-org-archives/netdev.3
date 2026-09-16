Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333348F82D;
	Wed, 16 Sep 2026 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549287; cv=none; b=GXjGFG4itdMcfbybC8Cp5ifvPbKhFKMwFB4zf1Yik/3QS+fXemDfY48OCHaEn7MoQLf5+D5kNfOK0kOSMTOkj4uFxaeli30y1QnCHtaWD2rF4McqZSJ2dxeO26nUbtR15VZbRodQPOY+4ZKA2XoAqDYFHvbWNcvLO20i+/2VLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549287; c=relaxed/simple;
	bh=4mZpkxATI4qiyTSXSJVGZ61KAftzgBuhrIfRNPs44+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRVkHD6glUg0yLGVU1HMH+/lPXOpNT3g3ev6n1OM7wHN40A+kqKqPhpoVWfI5U5M26IVg3JZy+7XVOCYhL1EEf1A1xFxJb3Q3ZNQJ1pACGG+b2VlVIXIhbSEUERRB1D9S0c0xoot6fa1mhyKIpP19rIdoATz4ng6O9TeqixG3Fo=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 929EB200124;
	Wed, 16 Sep 2026 11:01:03 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x6lVn-001CpX-1X;
	Wed, 16 Sep 2026 11:01:03 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x6lVn-00000001SqM-1e2b;
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
Subject: [PATCH net-next v3 0/3] net: dsa: realtek: EEE support for RTL8365MB-VC
Date: Wed, 16 Sep 2026 11:00:59 +0200
Message-ID: <20260916090102.349157-1-o.rempel@pengutronix.de>
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

