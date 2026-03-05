Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB89460
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721281; cv=none; b=TplhIB1y012zbjRwpx3FAiHwG6w/rU7oQC6l4e72rwCr04vRoAlocT5vR0GabaD3MoU3Y3eLnd+Jxu0XUdRQxY6l/xA4E0Kc0rMgn42HRqVpzJ35gQmeMbrYzmlfBcIklSOGpfTI5ETHoon+sT1H4zNRmrfp/zB1ieydW+7KzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721281; c=relaxed/simple;
	bh=uDVOFbw2XYWrpJ70udOh31mZUO7NNXV76H6RExjbvpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joopfPuBO9KpnSubtPRw8Y8QmGALQkUwekgOXllVY95Zar+VHz/P5ITuGxWUu3180UMf8hBr0OmE81Zgeov9N6RRBl4nrOeExhjJLvXKJFkS16eaI4aX5omyPuqT0hDzNnLjNc73UpQnp3k3wMcFHzLrKhM/LoLhDnuuooUgbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mZ-000460-Pg; Thu, 05 Mar 2026 15:34:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mX-003twj-1q;
	Thu, 05 Mar 2026 15:34:30 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mY-00000002E7w-3XA9;
	Thu, 05 Mar 2026 15:34:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 0/4] net: usb: lan78xx: accumulated bug fixes
Date: Thu,  5 Mar 2026 15:34:25 +0100
Message-ID: <20260305143429.530909-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This series contains a collection of standalone bug fixes for the
Microchip LAN78xx driver, addressing packet handling, TX statistics,
invalid register accesses, and a kernel warning during disconnect.

Oleksij Rempel (4):
  net: usb: lan78xx: fix silent drop of packets with checksum errors
  net: usb: lan78xx: fix TX byte statistics for small packets
  net: usb: lan78xx: skip LTM configuration for LAN7850
  net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

 drivers/net/usb/lan78xx.c | 12 ++++++++----
 drivers/net/usb/lan78xx.h |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

--
2.47.3

