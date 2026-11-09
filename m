Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228463;
	b=Vt3eRdvZ3s7ot7zw5fcArlAg6MVPgs6lHpo7OaKJj34mSDFd78lYBugiH7Je+1Qvw5yJ
	 85iX4t5K1v1oYRxsk3tPLe9DWxZzBah++1mssIWL4/Xlg3NT2asYjc2GMwHkhO+ByB3Eg
	 p++1ldlSeHBfeWu6bFFPv8sgCMqzsa0vm0cDQ6LnjrYSPIAFSiSVPru8G92d42o+jlIDq
	 7A6CRgmG4j6aMgdfqc4FSyIud+ASDPKg/9sPVqj3U0tHxHkkqrao/eSvymiLPqYAgzinz
	 7pnZiC1DvSJC/ToF1KLGDXgvFFaZWP2xjtFBt17pglnpmdCSv9V5mx3lh3DgRjStXog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228463;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=wxk+bhvyLH0V8Ro0RSES6TcYnCuINk9KDIVovqPlrco=;
	b=nAeXHC90pDpydQCp5pLalRO68rhOXtcZVXuN/yD+sRjiobzI2rYSZKamwbv7eec+4Jg/
	 NBIOp2AqhrvXLxCyDaCsCYkZ2TaEuBqC+bbEtaTLEATNX2R5x5hZQIt3P6ZsREB0J05W0
	 V/Id8jRXJYs9DScjNJQWV+jDo2yUZg4vvg0P/pf+wL9wPItdZNAms4TDUQDuKk0w+Hu/T
	 UVmAYAQt3QQKY85TEmianWKUovqVHvhyXOfUB7FE3rfwv9wvfvA8aviilS4YNxujfzklL
	 VbyuqIp8fOFYNQvwBc00sY8h5D7WVrrZ5GvEazZDLzndkwyoM9AjAI7A24O4P4qHnkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Zug4BiSa;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699A606D80B
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E699A606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Zug4BiSa
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 637461A15D4;
	Mon,  9 Nov 2026 12:47:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 313A960051;
	Mon,  9 Nov 2026 12:47:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0A1A103293A7;
	Mon,  9 Nov 2026 13:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794228455; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wxk+bhvyLH0V8Ro0RSES6TcYnCuINk9KDIVovqPlrco=;
	b=Zug4BiSadZnRUO+7qaJKJviEJxbniARKUmLjFqFaD/+G/0fnXauDtkzAocTUoYMhxn5e/V
	8TMje7aBW+YOoB6sz1fzpE89EgOMXVpCKN0QoeTWy/JfCVbBLhHXNLkPGZspZQeHF2eHoP
	MuM5xYgd1q7kgNimoAF48LtOQIsZgRLQwDoZkMuhnt9hpohuZqXM2naUaTfdu3fXJMEnEM
	eb+CR4uyK6c0boIO1bmd2SwSMP38zLOy865hi97UKiV26cNOWWKTKYdYcKLds5a2T3CuIn
	AX1B/aMbogTK04OlF/WEIZbEW7vbhuTIQu4vpRzb/o7N2bZxFFNHV6UmYdYuBw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 09 Nov 2026 13:44:56 +0100
Subject: [PATCH net-next 2/2] net: phy: marvell: add RGMII-to-Copper mode
 configuration
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
Message-Id: <20261109-marvell-phy-rgmii-v1-2-026979ef4f13@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794228436; l=1900;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=0+Pao/luz/FKciKGjA9DPEBPbRWwHZisVEAkAXPuHUw=;
 b=2Kl60nv/2d49BdYQKj4TI6T1Yb6we6SFZQCxikBM4duKj90ueV1JDjdZuM+3IQKG63CuktQcw
 pd/t+KHGGl8Br+gskJ02H6H8CMaX2EHunHKdhjFjDY+wvt/TOg2e00A
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The driver currently programs it only for SGMII-to-Copper, based on the
PHY interface mode.

Some MAC connect to the PHY via RGMII. Add code to configure the device
in m88e1510_config_init().

Signed-off-by: Paul Louvel (Schneider Electric) <paul.louvel@bootlin.com>
---
 drivers/net/phy/marvell.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index aef5f8279133..b8b466eb1c45 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1394,31 +1394,14 @@ static int m88e1510_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	/* SGMII-to-Copper mode initialization */
-	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		/* Select page 18 */
-		err = marvell_set_page(phydev, 18);
-		if (err < 0)
-			return err;
-
-		/* In reg 20, write MODE[2:0] = 0x1 (SGMII to Copper) */
-		err = phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1,
-				 MII_88E1510_GEN_CTRL_REG_1_MODE_MASK,
-				 MII_88E1510_GEN_CTRL_REG_1_MODE_SGMII);
-		if (err < 0)
-			return err;
-
-		/* PHY reset is necessary after changing MODE[2:0] */
-		err = phy_set_bits(phydev, MII_88E1510_GEN_CTRL_REG_1,
-				   MII_88E1510_GEN_CTRL_REG_1_RESET);
-		if (err < 0)
-			return err;
+	/* RGMII/SGMII-to-Copper mode initialization */
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII)
+		err = m88e1510_config_mode(phydev, MII_88E1510_GEN_CTRL_REG_1_MODE_SGMII);
+	else if (phy_interface_is_rgmii(phydev))
+		err = m88e1510_config_mode(phydev, MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII);
+	if (err < 0)
+		return err;
 
-		/* Reset page selection */
-		err = marvell_set_page(phydev, MII_MARVELL_COPPER_PAGE);
-		if (err < 0)
-			return err;
-	}
 	err = m88e1011_set_downshift(phydev, 3);
 	if (err < 0)
 		return err;

-- 
2.56.0

