Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E32BD5B4
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780126040; cv=none; b=kuBpur75peKaBxcUsMyJPJvOUhlZir91+6oqcITkx9xMUDByi0X23GAAD9UiEWctPhLkfkVHI2Stc1261WzBgkw6g6pjMzdPBid8W2G7jH4XIrM3xQPDaEn9MsWO/Xuz/hEqjmse/Bj2/ouWmcFsdL9A8b3N2HxE5x0ZitmO9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780126040; c=relaxed/simple;
	bh=gUrVe/Mpr7sLeBBv2oTXCm/tjXa4B0L/OiLxQTW7xlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXgX2egTsJunf7Tjik0nP9qzQOnTdQeOybvT48FkA6v94Nd/ybWDBPvFWeYeXvXJTl8YNIKkZi9UG6hv5swW9YUVny16MRgCTGmlFRayssJdTls+wFxMoWh/iTyjvtxr1Jtt6NYbxIf6SyTNzJysliD0lAPCYfvIgV+2cx3W2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JQxOK2SQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JQxOK2SQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E26084E42D96;
	Sat, 30 May 2026 07:27:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 908216073B;
	Sat, 30 May 2026 07:27:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04F7110888054;
	Sat, 30 May 2026 09:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780126030; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=J3Z0vjpJCn1bkKC31FGdwJe//NqYbNoaLNxF6MCnKjs=;
	b=JQxOK2SQiy2exHFJPBPJIOntqgp87bTcZ+TXYBd3Efsou9vuEYVam6aVqAvAGz9p4mczqG
	LWl+plHMCP/GktqBe6ijXD8j7WiuDspLitKFEMusB7VG9GyVrCi+WNgfVUWvbdwHzP8rmV
	Oup1PD6mCBSP71x0F+/GHCG48y/fcjevuoiaPOncECXStcxldQw2N+cfWzq7li+Nw8eRKH
	wqczCB6wCO00BSBT1czCgb6jgldwdvNBOXIkQZJMdCRv3x8Y2eQ/2lsdjW5p8nUirAXh/d
	lSKh5AfnvMdC5rvJlUXXPYlEOU2zQZvHvV0lbDJM4DBB7LMzYfj1hw/kSmEPgQ==
From: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net] net: phy: clean the sfp upstream if phy probing fails
Date: Sat, 30 May 2026 09:27:05 +0200
Message-ID: <20260530072706.3167745-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
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

Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..6c2ef91fd197 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3775,6 +3775,9 @@ static int phy_probe(struct device *dev)
 	return 0;
 
 out:
+	sfp_bus_del_upstream(phydev->sfp_bus);
+	phydev->sfp_bus = NULL;
+
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_unregister(phydev);
 
-- 
2.54.0

