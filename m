Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439013FE35E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565311; cv=none; b=ideQET4rkf0Lel//i6R5+d2Z3yonUuTuMVzEkf76wLHLKmxf6B29VP8pS4JDKW7OAAaPtQ3JSxY/fkgZPsthFZIblWeY1UDk8QnrziiAQlC4BieF4cYdwlpLgmKo/sTbZccXb6eugawkWej7QEOnOk+DJEhE/21LDKiaC/mzzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565311; c=relaxed/simple;
	bh=e4v07/+zK1P244AKQ4xDCa0GcImTQfulqMIpVfkGvXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLhBGj/rHRJ+iYYWIVUERyzb2ks1OQmisgL9WXTgu1219XXnwtf1++XnrPp9tlbCUnX3l+QzZQsrCo4lTuEEktfL3t0kycf74nUTRDPrQGvzuaI7Z1YKZtYMbClfTFVOYr0hNhTisfYe87snv1Y5yVyD2UdRhXhWpegKPY5it2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I+8GSkcP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I+8GSkcP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 300E1C63453;
	Thu,  4 Jun 2026 09:28:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0526C5FEF7;
	Thu,  4 Jun 2026 09:28:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A7E3106A184A;
	Thu,  4 Jun 2026 11:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780565308; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eQqrERDHTXSlGADmEjsJ09WzmFs2+YERQbgnmZ/C04s=;
	b=I+8GSkcPWofuZ24aPWmHVBaR64djyAiavPYkiDBicBrhZXOgyhrdi1YiPXiLmfrLJ/VFmt
	G1VWupTXhyCWANjkRf/TVU/2xhsfvGDC5oqhPxbPZmkyAF20Xh8FKg4NHjayB0FLgjnCQQ
	O+pgfu0FnVFrdc838x6bg3s3rEYZlBoDLsu3oTtNseF2O5jTBtuf91GTTijiOTC9cpaLMf
	a8t9yTgbTGaYmOXj/mg0jNrbTvGrChIqnbmJ48LhKGpYbsUNOkzzHux7DqyzaqWBbtxEFa
	0dCwTmL7Dqb++qPTpa07UO8y6A3mzbordztPHeUcueYgI+uLMcX+w39NG6PSyw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net v3 2/4] net: phy: remove phy ports upon probe failure
Date: Thu,  4 Jun 2026 11:28:16 +0200
Message-ID: <20260604092819.723505-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
References: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When phy_probe fails, let's clean the phy_ports that were successfully
added already.

Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6ccbfacf7d1d..4ba880446896 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3781,6 +3781,8 @@ static int phy_probe(struct device *dev)
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
+	phy_cleanup_ports(phydev);
+
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_unregister(phydev);
 
-- 
2.54.0

