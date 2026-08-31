Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462B400987;
	Mon, 31 Aug 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179807; cv=none; b=NMYdzYtUsaRtEYyJ/8SAlV5MdZDiAEOcm5C44/0g+Pm413brgWEYUPJQ+L21d76GyrmB9Rlo08zraQxvthVgEPmfs5OeR4jksp5v0Fx2/BlECAgcE7UwRj8HSB4LaS/sCg4g8w2INX59omYAweJRkWRmyIp0ONSpIn7n4VyTjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179807; c=relaxed/simple;
	bh=faHESbD3X0n1KYkLzW0BMEpvQqf2fvWMxZn5fMLlcTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LBHLNB8M2vioFMt7hpTX9fSASnYbAnh6xN3hCDxwmtCP6mdCM+5YGOnbs3tkOLQe2iGbP9yPrARfWa3hRI2ksr24sS7K6TKZ3LnhfnGAKwYFFzL1jmmw99OE7VQv7c7LVzB5GGF9C27ITuVv25XPKitqceDu87lMWuMvS07jQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 39ED3201865;
	Mon, 31 Aug 2026 14:36:38 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-004G6X-0O;
	Mon, 31 Aug 2026 14:36:38 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-00000002nO3-09G4;
	Mon, 31 Aug 2026 14:36:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dsa: realtek: enable RTL8365MB power supplies
Date: Mon, 31 Aug 2026 14:36:34 +0200
Message-ID: <20260831123637.666457-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RTL8365MB family has several external power rails (analog, digital I/O
and PLL supplies) that on some boards are gated by regulators. Until now the
driver assumed they were always on, so it could not be used on designs that
keep these rails software-controlled.

This series adds a device-tree description for those supplies and enables
them in the driver before the chip is accessed:

The supplies are optional: boards that hard-wire the rails work unchanged

Ahmad Fatoum (1):
  net: dsa: realtek: rtl83xx: add support for enabling supplies

Oleksij Rempel (2):
  dt-bindings: net: dsa: realtek: add RTL8365MB power supplies
  net: dsa: realtek: rtl83xx: use dev_err_cast_probe() for reset GPIO

 .../devicetree/bindings/net/dsa/realtek.yaml  | 33 +++++++++++++++++++
 drivers/net/dsa/realtek/realtek.h             |  3 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c      |  6 ++++
 drivers/net/dsa/realtek/rtl83xx.c             | 23 ++++++++++---
 4 files changed, 60 insertions(+), 5 deletions(-)

--
2.47.3

