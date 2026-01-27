Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805235A92F;
	Tue, 27 Jan 2026 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521345; cv=none; b=LxEEQ13q3/1er7//cBWyGMNazFTJvYwk87GeP1dyiwlGPy9M8ddLjRxZr7W7jbgaiH/XwHkL0W5Y4YsZffjCLpOcNtKFoZo4SB4xiGJx3lve6bNgnAWMp7jaF08RqhmOT0Mo+wls9WpufcLn77VfISConW4aYtyMNOogpjpflfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521345; c=relaxed/simple;
	bh=2x2Twk5hwB1qm9MtsaxYrP7i5T6qH8pGMbiXcSTMo1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8gt5fYCg/6r4AL5JvLTPfHlBWlNctYBrL/vb+yuSa826RMcsRSIZXJ3GQoCiAvLlDHbRNHWfyP660VF8kR2fxun7eZ1En8OvFtW7svWe1GTq7PeRMyvls8cK6nqesPtqDwJelHMPHkEPZSbn7rqkRsQ6qN/EqjArHdO7K5G0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ERgLyxk/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ERgLyxk/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E174B4E422D3;
	Tue, 27 Jan 2026 13:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3AAE606F5;
	Tue, 27 Jan 2026 13:42:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7E05119A864D;
	Tue, 27 Jan 2026 14:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521340; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vnp5YkIChB0sNg7EdJ/lX1dIvAkP9AXfzZTaTC0ju30=;
	b=ERgLyxk/5cmi2bot+No+wtGGZE0g/ywwL/+/lcGKD5S/C9Fa3jCHezTdFd4mmuvELVvlp2
	kDurb/3NW2FI/WlKgZcVA6z8hkXw/rT9M1P60iGmzjALfJh808CntD+soTDjb38gZzrjJ7
	D1u5bh7/ziXSekJQIO6gBBsn5hszeIG977xaqFsQm8pwY6mWuQfbUapUYVlhvEyeUnbDFT
	RxUv9KYoKOzTEl3nCwd88rlwzidzGBZtiI5wjkN3a4txV3JUPCEyKerj9bfhCPlcu2sPJg
	wLtpcIpa0yaEtTJZHyBoN5qyjk5eSeUANQ9r4fxr7KS7V3qRtV0B4jqpHYAvhw==
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
Subject: [PATCH net-next 01/13] net: phy: phy_port: Correctly recompute the port's linkmodes
Date: Tue, 27 Jan 2026 14:41:49 +0100
Message-ID: <20260127134202.8208-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

a PHY-driven phy_port contains a 'supported' field containing the
linkmodes available on this port. This is populated based on :
 - The PHY's reported features
 - The DT representation of the connector
 - The PHY's attach_mdi() callback

As these different attrbutin methods work in conjunction, the helper
phy_port_update_supported() recomputes the final 'supported' value based
on the populated mediums, linkmodes and pairs.

However this recompute wasn't correctly implemented, and added more
modes than necessary by or'ing the medium-specific modes to the existing
support. Let's fix this and properly filter the modes.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_port.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index ec93c8ca051e..68a0068220ed 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -118,11 +118,14 @@ void phy_port_update_supported(struct phy_port *port)
 	int i;
 
 	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
-		linkmode_zero(supported);
-		phy_caps_medium_get_supported(supported, i, port->pairs);
-		linkmode_or(port->supported, port->supported, supported);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
+
+		phy_caps_medium_get_supported(med_supported, i, port->pairs);
+		linkmode_or(supported, supported, med_supported);
 	}
 
+	linkmode_and(port->supported, port->supported, supported);
+
 	/* If there's no pairs specified, we grab the default number of
 	 * pairs as the max of the default pairs for each linkmode
 	 */
-- 
2.49.0

