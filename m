Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AE3F6C5A
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565310; cv=none; b=QitnqebZHUOJvlTMplsVxkRklIwMnZuTyNTzUMImFovb3b99+E98kIqjpjKdlP820aiyPG2D4oFJWH/RLL7ffwSKlPm7Vtw14hontqU/20h3WMIWY/5gXNQ8WO8dpa2fvoBjHOr63Og5T8RY+c0mAj9D12lAi6o8h1nTVCuRhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565310; c=relaxed/simple;
	bh=BY1wSl9pkqttpFP/BkW6RWoeWfy8riR7HCU3xX210HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSBYTb0x7NBTdthCNQiUCJJBqv5PBI/mhagiybE/ZI4YdZwri5UqRKo7SJuyuJuvBRSepNbt1JbOfuNYHEL8HsSeZH8jUiWS2A6eBlqd83ajDnjj3TNKHLuYpnarl2j2xzLzqgaOfIqkIk7nyOlDfQhmXdPq5KR9pqgqSBPV0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xQ/ITLu5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xQ/ITLu5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 57161C63451;
	Thu,  4 Jun 2026 09:28:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B5115FEF7;
	Thu,  4 Jun 2026 09:28:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51CF7106A1703;
	Thu,  4 Jun 2026 11:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780565306; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=s5Hv3nkaKIJM7GUZb3G5hBDjKGl2UIsIV6beBbWFt/A=;
	b=xQ/ITLu5Yi4hFQTs2gMQpDwXHx3/PieKrp5hulaP5GU1jfGP3Homj3++5RshXObTmtUojS
	ivePVXGlFXKbu82cK1G1TDg5ctIvKVBGAmIpzkkAEHslbJ2/u1gWckc1TZakE0nI8IqSl2
	0LEGRruDdD/X5J3OsRHz++nPYzydG0LS2ZbaWVXhuoip3reI99D4hPExoF0XOvFUkTzpj6
	+HhNnv0Xj8PiFfxMRUTJ85qjruo1EKPdFklx/JQYl6oe6fZ+IpRGI5C+TMEkFHxbxS0Z42
	LR6t9HdHgD1N0TAUkqxTPryUVGPbWQdkqU6nx7WSvVVuETWsVxACXaaEa3KKPA==
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
Subject: [PATCH net v3 1/4] net: phy: clean the sfp upstream if phy probing fails
Date: Thu,  4 Jun 2026 11:28:15 +0200
Message-ID: <20260604092819.723505-2-maxime.chevallier@bootlin.com>
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

Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
failure path, so let's add it, otherwise the sfp-bus is left with a
dangling 'upstream' field, that may be used later on during SFP events.

This issue existed before the generic phylib sfp support, back when
drivers were calling phy_sfp_probe themselves.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..6ccbfacf7d1d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1718,6 +1718,9 @@ static int phy_sfp_probe(struct phy_device *phydev)
 
 		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
 		sfp_bus_put(bus);
+
+		if (ret)
+			phydev->sfp_bus = NULL;
 	}
 
 	if (!ret && phydev->sfp_bus)
@@ -3775,6 +3778,9 @@ static int phy_probe(struct device *dev)
 	return 0;
 
 out:
+	sfp_bus_del_upstream(phydev->sfp_bus);
+	phydev->sfp_bus = NULL;
+
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_unregister(phydev);
 
-- 
2.54.0

