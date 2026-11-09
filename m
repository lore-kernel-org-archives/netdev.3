Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228458;
	b=hsAMOrwD02WwG6uEDBbTzLOpwZV6g7MLnaeXYXaabuHpZi2K6/0JmYDkgm1ZVn6Ww5OG
	 /4OjuruhTB7pU/d5P6s7AolLjNrl5/UzZA3ljJ9E/vnJ0HzerQSmSdAycYmomFlhxRrpy
	 7pWR9Lyn/UKIZwua3cF86LliVLpQxXFf9494vimaUSju44mQqbcUWzqitn7sNeLDOgaMo
	 Gi8EQb1WGNULMOi2om0b43QuZrl88iYHaIJ3YMEGqqXTkDRmgeyPbGjV1ErPvKdLSeKtG
	 5TC2oIfqKk3yBBZ6KOHkBJk2Au1dkMg5FMXB2KzfVParvMy/wcjkqoxhQ2RhYlPa27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228458;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=6jx28qt1Cjm8L1peGY2PNhPMUgaEfvpROcE6lSEMoCo=;
	b=AwARg3itYBjei7VUAcaFuB4SmyhaubZuVC7hes3Fah++DvRc0kR8x8sOlglj7ZCXhtem
	 vApljKkIvlriChEbzUJig50xWvcjV75Srd0L681QCy9O5BciGgH8EZ7lNs9PAZ71h4BSR
	 pRzyS1MRIuU443UnurMprXF7pIgMjCtQzd6KfK07E180OBsF+9+vs13rGABYh2PmINPhI
	 NTZAzwjjwXQvK2yIW+CtfadSMuNnrOjMhTkhsmEE5HuR52PmwRD+jeOV2hIQ+6c2+sbvN
	 G7ynzwP2wqjvPkE4/P65saRjgb1wZXHoUUu/jhtudD9Swdw8f/9ZM1QgiLT/SMpYZYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=V8pVKqpn;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB5606A33B;
	Mon,  9 Nov 2026 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BB5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=V8pVKqpn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30975C5845A;
	Mon,  9 Nov 2026 12:47:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E54A60051;
	Mon,  9 Nov 2026 12:47:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D5D8103293DD;
	Mon,  9 Nov 2026 13:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794228449; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6jx28qt1Cjm8L1peGY2PNhPMUgaEfvpROcE6lSEMoCo=;
	b=V8pVKqpnum7Hu7inAO292xGBOGVVCay5Nc/FGIj2MoA7t6XBlU0xiJ03Utcn8lsD1AOUVD
	fMP7l9N8CxCqPZ5VSZYddr44Py9idkofoqFDEYp/Hb/++6SW+24sLo4OgC1DjwNfmljh/M
	YoS/q5ptLDMz9jL+yHTZRsDrk321d1FPkBNzY2JUmetMOh6Q7eQy6kqNRa5skb+cXETZiK
	AnL+MH81OP3L1Q+JBBAfDuS0ndytoRp6ykU+IbjS7Rnc8c/34KN6n2UNN1QODay9ZUW9O2
	9cV9tkfJ2qtP0Ji0siufl6SKtuoL53NxLjIU97zqwSLPQnsUCRDIzSa8j1BCsQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 09 Nov 2026 13:44:55 +0100
Subject: [PATCH net-next 1/2] net: phy: marvell: move mode configuration
 into standalone function
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-marvell-phy-rgmii-v1-1-026979ef4f13@bootlin.com>
References: <20261109-marvell-phy-rgmii-v1-0-026979ef4f13@bootlin.com>
In-Reply-To: <20261109-marvell-phy-rgmii-v1-0-026979ef4f13@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794228436; l=2232;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=5hr05G9oJg/PCsrrlKGduHDcZ6wwQp77JB5x7IJiFA8=;
 b=d3jLEeNph+o5/1VYJy+IwOrrRXcLP0FvuGPSocXtIFvTpnWSDUM30gmCDkl9EmOJvcGeyg8e/
 bX3LzR+FmZ/AIBz+OUFBz49n/OyL/LuoYZjSl8oX/axkqJvzF6eTkv+
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Move the configuration of the m88e151x out of the
m88e1510_port_configure_serdes() function, so that other part of the
driver can use it.

Signed-off-by: Paul Louvel (Schneider Electric) <paul.louvel@bootlin.com>
---
 drivers/net/phy/marvell.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 2c688d661297..aef5f8279133 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1332,6 +1332,27 @@ static int m88e1318_config_init(struct phy_device *phydev)
 	return marvell_config_init(phydev);
 }
 
+static int m88e1510_config_mode(struct phy_device *phydev, u16 mode)
+{
+	int oldpage;
+	int ret = 0;
+
+	oldpage = phy_select_page(phydev, MII_MARVELL_MODE_PAGE);
+	if (oldpage < 0)
+		goto error;
+
+	ret = __phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1,
+			   MII_88E1510_GEN_CTRL_REG_1_MODE_MASK, mode);
+	if (ret < 0)
+		goto error;
+
+	ret = __phy_set_bits(phydev, MII_88E1510_GEN_CTRL_REG_1,
+			     MII_88E1510_GEN_CTRL_REG_1_RESET);
+
+error:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int m88e1510_config_init(struct phy_device *phydev)
 {
 	static const struct {
@@ -3656,8 +3677,6 @@ static int m88e1510_port_configure_serdes(struct phy_port *port, bool enable,
 {
 	struct phy_device *phydev = port_phydev(port);
 	struct device *dev;
-	int oldpage;
-	int ret = 0;
 	u16 mode;
 
 	dev = &phydev->mdio.dev;
@@ -3685,20 +3704,7 @@ static int m88e1510_port_configure_serdes(struct phy_port *port, bool enable,
 		mode = MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII;
 	}
 
-	oldpage = phy_select_page(phydev, MII_MARVELL_MODE_PAGE);
-	if (oldpage < 0)
-		goto error;
-
-	ret = __phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1,
-			   MII_88E1510_GEN_CTRL_REG_1_MODE_MASK, mode);
-	if (ret < 0)
-		goto error;
-
-	ret = __phy_set_bits(phydev, MII_88E1510_GEN_CTRL_REG_1,
-			     MII_88E1510_GEN_CTRL_REG_1_RESET);
-
-error:
-	return phy_restore_page(phydev, oldpage, ret);
+	return m88e1510_config_mode(phydev, mode);
 }
 
 static const struct phy_port_ops m88e1510_serdes_port_ops = {

-- 
2.56.0

