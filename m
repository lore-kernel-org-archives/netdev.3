Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD646339B34
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159274; cv=none; b=uipuyrv1CdysF9UYKe4dJJDqoM8Vr4hJp733w2+hjhYH2evN1mM8Qqe5zyCHbHZk8hIxxNhtDIpEczpu/m4J57iTsNDLZqj2O5Dmk+9o3TM5yLELOqfSjv5CrNMfVDYi2EuHFc4F85bl9nhCl3DWuzCYsZGljUv8uzG1qL4JoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159274; c=relaxed/simple;
	bh=QXf1u1S0KIkKrvRpU9sjzlnmczDf8Zp3mpBHAtCSpqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFptiUjw63ASycA3fnOwoFMEOMHrSkh+LiEyAdPJHSjQdLAzZBo7xWqwa5mZFyfwKPGYf5d8lBKuSitdtYXUcfkAarY6YewzOiynnGE+dTVKO5EJ7nRxwjgaOXEynUL5DeGN2FZfmoz1zJM3Cm80XJMFqcOr1AgJYFNqDmmi37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8q-00027F-59; Fri, 23 Jan 2026 10:07:44 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8p-00244w-0Q;
	Fri, 23 Jan 2026 10:07:42 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8o-00000006ZWY-1ZNU;
	Fri, 23 Jan 2026 10:07:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [RFC PATCH 0/4] rx/tx stall detection and recovery
Date: Fri, 23 Jan 2026 10:07:36 +0100
Message-ID: <20260123090741.1566469-1-o.rempel@pengutronix.de>
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

This patch set is send for discussion on related topic:
https://lore.kernel.org/all/20260122192158.428882-4-mohsin.bashr@gmail.com/

Oleksij Rempel (4):
  net: lan78xx: Add devlink health support for diagnostics
  net: lan78xx: Implement FIFO stall recovery via lite reset
  net: lan78xx: Enhance health reporting with workqueue and detailed
    flow control stats
  net: lan78xx: Add debugfs file for error injection testing

 drivers/net/usb/lan78xx.c | 514 +++++++++++++++++++++++++++++++++++++-
 drivers/net/usb/lan78xx.h |   4 +
 2 files changed, 515 insertions(+), 3 deletions(-)

--
2.47.3

