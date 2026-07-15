Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90813E51EF
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110517; cv=none; b=Q12XHns+xAOQrOe3yC7M6ubu9ofHZKOfITWolBqH0TnjRvcLOZEzzQyLyekXs86Q0/Psc+kMr/uvQTSuoQIx0UFvyFehgt2hlZRhPnWeNI9b3kXWpwLJ5+hzWRtuT2yoOmgHLc/p6jBTfzZjpOMKSr/9QO+ypMq3vuozQ5EFFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110517; c=relaxed/simple;
	bh=KkuGd+d8gm2IYS/fTqDghHxK4JS2j1Y2Pxjjj99KUVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXTKVmk8qyswxPWAslAgCbUPHxibTApeuDQhxbEC0/6a6pv6Wi/WYF5A8l4xnX+13BHEnJxjD/AIJnR2cWk10vEFu/K85RJkFWXciWiNp/5RPuH2s2Z6NgYjHv3vRYUSuyU/dwquKVEOUoRJiG2CdwPhdkJfB649YfhZ8kQENHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lCC8LRuq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lCC8LRuq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 174711A0FF3;
	Wed, 15 Jul 2026 10:15:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE5466035C;
	Wed, 15 Jul 2026 10:15:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2134B11BD3BB3;
	Wed, 15 Jul 2026 12:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784110511; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6nZorEMvp7MChNt8EprrNo5x6LonYT52L40mYo/flmA=;
	b=lCC8LRuqbqhF5+67zjnMiKX/JXW/dsD2ubzbGTG69nwblfYueupfLfmAAdWVmdtQsRTGMp
	WHZASHShIpSqBhCKJqR7v6znY3535VIfSjn0yuGsnuJTZYaA0K6zpum2jOFV+PV0wiuJyJ
	18CK63MEltNNUkXaySSOU6Mg3Wgrq9P75dlWRtODqCj9tEFTTQCJ/8rfK+TCYn89SBYwDf
	FDAE2MJpUv8kvvhl7RV/6EOzbbCBFo4dZhQgrBPpo5hUiHokY3FQBMXcQUSJTZSo2ZMNXz
	KXWq/Gwfey9KScx3SQBfMUMjMpViH3YYwQglZqj76Px1ngrZ9UV66NHcWwNHfw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH net-next] net: phy: at803x: Use a helper to check for phy reset existence
Date: Wed, 15 Jul 2026 12:13:54 +0200
Message-ID: <20260715101355.88536-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The at803x family of devices are subjected to an errata that requires
hard-reseting the PHY upon link change.

That can only work if there's a physical reset line wired to the PHY,
which the driver checks by looking if there's a reset GPIO configured
for the MDIO device.

The reset may however be controlled through a reset controller, which
isn't accounted for in the errata handling.

Besides that, PHY drivers aren't expected to directly access the
mdiodev's resources directly, let's therefore wrap this with a phylib
helper, that uses a similar mdio helper to check for reset existence.

This was found in preparation for bus-level resource management for
better mdio scan support.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/qcom/at803x.c | 2 +-
 include/linux/mdio.h          | 5 +++++
 include/linux/phy.h           | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index ba4dc07752b6..6872dbf77856 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -537,7 +537,7 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	 * in the FIFO. In such cases, the FIFO enters an error mode it
 	 * cannot recover from by software.
 	 */
-	if (phydev->state == PHY_NOLINK && phydev->mdio.reset_gpio) {
+	if (phydev->state == PHY_NOLINK && phy_device_has_reset(phydev)) {
 		struct at803x_context context;
 
 		at803x_context_save(phydev, &context);
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 300805e66592..a7d9e3ae362a 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -86,6 +86,11 @@ static inline void *mdiodev_get_drvdata(struct mdio_device *mdio)
 	return dev_get_drvdata(&mdio->dev);
 }
 
+static inline bool mdiodev_has_reset(struct mdio_device *mdio)
+{
+	return (mdio->reset_gpio || mdio->reset_ctrl);
+}
+
 void mdio_device_free(struct mdio_device *mdiodev);
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
 int mdio_device_register(struct mdio_device *mdiodev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fc680901275b..beff1d6fcc7c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2231,6 +2231,11 @@ static inline void phy_device_reset(struct phy_device *phydev, int value)
 	mdio_device_reset(&phydev->mdio, value);
 }
 
+static inline bool phy_device_has_reset(struct phy_device *phydev)
+{
+	return mdiodev_has_reset(&phydev->mdio);
+}
+
 #define phydev_err(_phydev, format, args...)	\
 	dev_err(&_phydev->mdio.dev, format, ##args)
 
-- 
2.55.0

