Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D856392809
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283419; cv=none; b=qQgxpT7UUjRcL6udk0MMRC24uoCYxlftmchNKGAhA0KLzed5bm7XfjYj00sch+GlEVvxhb2wL0Z6HXZTN0rGanQh0CDHCs5jZZIpI5w5B9m/o3AWljpfw0XdPDMPQ/1dX9RaaIkBh9EBcmYb+IyioR6JIpPSdNgQyuXoQrsP9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283419; c=relaxed/simple;
	bh=wRzJK9Yc33onsr1SqP1pSLxAinwQo/XqZP+eAfKnhpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn/bkwrneEIrjKelTzfoQMigKtBEm3+A9kch1cpsR54fxuRkg/ffZJxfXZkUJgHu8VVqkev8F7vHxrqoieJ2tHfhYXyDGBUR9oJfvACXUGNhODNOZVRBpwwEkKoO8ilvwO9YwckfS5Ojv4kLjJG42ctqbmMkq0qqNPkzQWD5KGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yttt/HS3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yttt/HS3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E1AFB4E4240E;
	Thu,  5 Feb 2026 09:23:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B4592606FD;
	Thu,  5 Feb 2026 09:23:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A4C9119A8891;
	Thu,  5 Feb 2026 10:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770283416; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6yh6DzDkyKCbVY38GzuiVuOPYlrZ+spxgJkz3vkq/kI=;
	b=yttt/HS3XSOnCqL3CAMMf9uA911cvRX045XAfmc5nNXnZ+Wx0o2mwRhMSyRGK31Xkmyx/1
	lu+gJm4Ja+ZKmw8tGyY0yFf+ihPOmiS3fAXZrZi+pc3/hRnL0wr0Voy0xTSrEQxZ2ZBE4A
	1wpTVQyGuff0Znm5ukr9gcbyx7E1PV+Y+6QOLSO2LJodo7Kt1EOyEbhWlo0dHDiY02XIwX
	Ebe6Bc1hHDGpl73yJ6pMXV3WuZmeSNsCv/k8/nPXPiWD84XjfpkIfFUSHK1ArBG1i1ySxk
	ZUQGz48Lz+Et9e637N0tnK+tU8oPzcGyVnOW4la2Dzd2wq6CgQkHPMvfLqrhLQ==
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
Subject: [PATCH net-next v5 01/13] net: phy: initialize the port support based on the PHY's for OF ports
Date: Thu,  5 Feb 2026 10:23:04 +0100
Message-ID: <20260205092317.755906-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
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

