Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E62D2493
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139741; cv=none; b=B5giwRnDqAnNHc9qIXBsT3OumoFmldE0XpyTIUeXm9rcjpRUH24ZC4cUOHuTLViBPivEuUW/IqAr2VwOOaGpnQ+mbnRooGbV3eyXwRkQm9MzMxtJa1TyrTTptJJph3emRUmzpYhMKTSTZo+bVaTlOg8TCAmQ+x1JjlB7czeJarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139741; c=relaxed/simple;
	bh=wRzJK9Yc33onsr1SqP1pSLxAinwQo/XqZP+eAfKnhpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBbsOvqdKK/2xg3oCwW5J9h0gwmvDivkt2csta1FXt0w4XwwCe0stv8C3ykzp3rYplqfWVeyk93JuuwWsqq3RB7PLXzclewsWsX0Puhi7tkGX5GkBjdY5zGR5YdFRQdtTRiCl7Tn4iMBQyE3tok40EvKre46L6YXT2w3dXuUzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fhYErvC5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fhYErvC5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 799A61A2BC5;
	Tue,  3 Feb 2026 17:28:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C71A60728;
	Tue,  3 Feb 2026 17:28:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42561119A88EE;
	Tue,  3 Feb 2026 18:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770139732; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6yh6DzDkyKCbVY38GzuiVuOPYlrZ+spxgJkz3vkq/kI=;
	b=fhYErvC5sSdGikVuWpcEzDzDWhLg6o+F2I6+ZKl9KAQzFSHQELyFIv9NJBs/jGXRo2m2Y4
	2uw/oIALzzCqzi0vTFiO0+f7p+u30WF8YsT7Sg7Py71fgXftUUfSlDxoD2uFiVKcCd6acN
	wbtkc9YO5yZil4BQzW7hj+TcGpYqhGfGQEA1Rsliexv1zKyIDtMk9oR++vXBOU/lO08uTx
	l5SaoIe69TYKNg4/s+crVbNBgC9xJC/J+Uy08ObVKgmiWvln6jQ0d08bcbQ9SDEmewWGO+
	hnsn0DdRPWawonXeclX1uM9hkIxrc2kLOpi00WwDkSHtunHOoMSicI4J/b0WlQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v4 01/13] net: phy: initialize the port support based on the PHY's for OF ports
Date: Tue,  3 Feb 2026 18:28:25 +0100
Message-ID: <20260203172839.548524-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With the phy_port infrastructure came an ethernet-connector binding,
allowing to represent the MDI of a PHY in devicetree. This allows
specifying the mediums and pairs of a port.

Let's initialize the port's supported list based on what the PHY
reports, so that we can then filter it with what the connector allows
using.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8a3eb1839a3d..9b8eaac63b90 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3499,6 +3499,9 @@ static int of_phy_ports(struct phy_device *phydev)
 
 		port->parent_type = PHY_PORT_PHY;
 		port->phy = phydev;
+
+		linkmode_copy(port->supported, phydev->supported);
+
 		err = phy_add_port(phydev, port);
 		if (err) {
 			phy_port_destroy(port);
-- 
2.49.0

