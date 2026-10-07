Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DB3DAADB
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397276; cv=none; b=YvWsKx4FqpK+CxHVTjF6MmO3jQSzKk4lNGz7Ihb/JwW3Fm8geHRek7kg/6fjtgcgt64xiDij6KfvToM5KH3LMQm4rW2G4q1HGqBemHUUERbF4468c7p3FOIfYqbgKMpOhizrK7c7Wjs1hWa1/B7SajivkUBilvQQi1sHrdSnEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397276; c=relaxed/simple;
	bh=Nrf1YDM+DHXNlm7iRVDD+KL8xnbrZmtwsna5FgXWzk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+VzBWf+Mt0D3TKitkqqqCix1dkwkcPWFh0psyPfi1BndVGslvcx8raKHiMHwi0X5Qs4DcJqHlz7z4QXP/I+v3Syt+AJZTD3/rEPp7rxZmCJbXyXq8XhZqzZpIAk/69ef7QKqYbz8e15JhYdMAO0qSCMjm6g3S24kROw4o7f9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3RuL73Q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3RuL73Q"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a4c80d3d5aso2466608a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791397275; x=1792002075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKSKlzqYN/O2yAt1o5xzoyGbTxhQiLSVcfOd9AG52bQ=;
        b=p3RuL73QGPaKSbVoO6IR1fVvMW9rLv+H7nykMoCDGy5w38edy7Cbw9lFgEgb6DvKML
         2pkrhnZBus/znLtjYh3wUI3V9PRFh/QGucdUkAFFCm6n7XSDKTcUzmAWryJSmcygWdSX
         9TMAed4LupExk6YFRZauIi3cVrqo4omI49M/215Y14eZPkauj59o3dFZNdSU3O1KKCUw
         pgYAn335Sh/YorG9KJhGcSDbtGkCM2GVJhmRpsVxZEBbSRedVJ2gF2Ean4QI+Rs7NhPY
         RUOufVwSWAHDado/Ajsjp5yVkNdjJwPjARnutZIvnBoms3LMBR3wEdiyUUBxMhBPizEZ
         JigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791397275; x=1792002075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKSKlzqYN/O2yAt1o5xzoyGbTxhQiLSVcfOd9AG52bQ=;
        b=v1iZg5+GYscbTYzyhS17jpdQD5IXi7FSGOcEKX0R10Rw9tl5rUiGI132u3cQOgC0Uz
         QTGhejbjmG3TBumF2sHRvmoPRSeceKMfHH0pELf615lomcw8eapvQB3EVrZMHHYDr+p9
         WrilWfBtTePMJbc85/Cb+nwSOQJvkVv5RMCztt9XIdb4KlIkhPJ3xfw81YqbrwS7hxmQ
         gNowoZukC5f0EL/V/1D7upBj7Xug6ZG6+/UwVDTIHU818jx2U9I+oIBdJjwmwoBmHeld
         UeS1hvdp5nIGmWrxwpfmOhbkmexDMZ3awtqxGlW4Eyxzhq0YAuA7CnRYVtJXnRHRNtV7
         ofFA==
X-Gm-Message-State: AFq9FYIoSwEHQ3XqhpS4o1uq15WPSDWQrvMHUosoNNnu8IEfWQWWXvTL
	QnUnIpFNQxtTeoeQWykTQATLi4tehgpOAS1n0Yayrjow/CPE0+PhXx+PAoL5bA==
X-Gm-Gg: AYBFou0eAC6tqHQUXNibJi8DtH1MAmXkdF7rSUABbGzx/PL8Y4VSU+pGYs9ko3Ao1h8
	BbgFez2a4sDbe8D8J7l9ZrjH71bAO9ZKCWzvjpuzJwtOJJB/dR36s+9myXAbN8etTNPVImD3GrF
	+E5ZDuwX2IkBvoXQ2dioIZpU5AeCTYfCj7JpeHqL1ASfs/0zRnX6fEPsVJfg1xVOQJTuGIT0lNT
	xPVM4yN+5yCEDipCMMIFBVz+V9xkNgRS+tZ+kZgOZvKm1IQbP9a3yapMHzAWHsnZUt2MjHH6Gnu
	zpjVMSr3qoJdlTTgsd1TfO/hgoOIlN0LBQlH78JxvqSE01yVaJINANEHnCOO0eBJx0Cz6PwV/7B
	fQhLhUoSHEN6JcXcawJ5aFRrwFlk31pe778TB0BC2/168AbeGunL/jpPPhXGeISnSerXS6eqc3X
	mh0iSdA3aBfpnDXT15bD/kDLbBkg+Wd29tlBF5RS5onh8wUcUApLoaxrQKj0UlPVYyb78P9MB3N
	m3tARJ2FgD+SpX/sRXru2oKa+u/kG9BWrMwIGxeS19x8sESontej5W/6Z6Wp0tkJas0x0PS6y+1
	fexRskZhhXd4PM+IKKGyQA2QF00HT31Uh2nEy73NWX0yropP
X-Received: by 2002:a17:90b:4b07:b0:39e:6a80:b793 with SMTP id 98e67ed59e1d1-3a8a0de64famr3014829a91.35.1791397274686;
        Wed, 07 Oct 2026 11:21:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7aaf8asm642007a91.6.2026.10.07.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:21:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
Date: Wed,  7 Oct 2026 11:21:12 -0700
Message-ID: <20261007182112.821061-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

marvell_config_intr() rewrote the whole interrupt enable register, so
the config_intr call from phy_init_hw() on resume silently cleared
WOL_EIE on the 88E1318S and 88E1510: m88e1318_get_wol() still reported
WAKE_MAGIC, but a matched magic packet was no longer routed to INTn and
the board did not wake.

Make config_intr update every bit except WOL_EIE with phy_modify(), so
the WoL interrupt enable is owned only by set_wol and always matches
what it programmed. The read-modify-write runs under the MDIO bus lock,
as do the accesses in m88e1318_set_wol(), so the two can no longer
overwrite each other's update. Have m88e1318_set_wol() clear WOL_EIE
when WoL is fully disabled, since config_intr no longer does.

The interrupt register layout is the same across the PHYs this driver
handles, so extend the shared handler to also claim a WoL event instead
of adding a per-PHY one.

Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: remove MII_88E1318S_PHY_CSIER_ defines.
 v3: use phy_modify()
 v2: resolved review warnings, including wol d.
 drivers/net/phy/marvell.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..5f9a43a4a063 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -55,6 +55,12 @@
 #define MII_M1011_IMASK			0x12
 #define MII_M1011_IMASK_INIT		0x6400
 #define MII_M1011_IMASK_CLEAR		0x0000
+#define MII_M1011_IMASK_WOL		BIT(7)
+/* Bits updated by config_intr. The WoL interrupt enable is owned by
+ * set_wol, so the config_intr call from phy_init_hw() on resume does not
+ * silently disarm Wake-on-LAN.
+ */
+#define MII_M1011_IMASK_CONFIG_MASK	(U16_MAX & ~MII_M1011_IMASK_WOL)
 
 #define MII_M1011_PHY_SCR			0x10
 #define MII_M1011_PHY_SCR_DOWNSHIFT_EN		BIT(11)
@@ -139,11 +145,6 @@
 #define MII_88E1318S_PHY_MSCR1_REG	16
 #define MII_88E1318S_PHY_MSCR1_PAD_ODD	BIT(6)
 
-/* Copper Specific Interrupt Enable Register */
-#define MII_88E1318S_PHY_CSIER				0x12
-/* WOL Event Interrupt Enable */
-#define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
-
 #define MII_88E1318S_PHY_LED_FUNC		0x10
 #define MII_88E1318S_PHY_LED_FUNC_OFF		(0x8)
 #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
@@ -393,11 +394,13 @@ static int marvell_config_intr(struct phy_device *phydev)
 		if (err)
 			return err;
 
-		err = phy_write(phydev, MII_M1011_IMASK,
-				MII_M1011_IMASK_INIT);
+		err = phy_modify(phydev, MII_M1011_IMASK,
+				 MII_M1011_IMASK_CONFIG_MASK,
+				 MII_M1011_IMASK_INIT);
 	} else {
-		err = phy_write(phydev, MII_M1011_IMASK,
-				MII_M1011_IMASK_CLEAR);
+		err = phy_modify(phydev, MII_M1011_IMASK,
+				 MII_M1011_IMASK_CONFIG_MASK,
+				 MII_M1011_IMASK_CLEAR);
 		if (err)
 			return err;
 
@@ -417,7 +420,7 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 		return IRQ_NONE;
 	}
 
-	if (!(irq_status & MII_M1011_IMASK_INIT))
+	if (!(irq_status & (MII_M1011_IMASK_INIT | MII_M1011_IMASK_WOL)))
 		return IRQ_NONE;
 
 	phy_trigger_machine(phydev);
@@ -1991,8 +1994,8 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 			__phy_read(phydev, MII_M1011_IEVENT);
 
 		/* Enable the WOL interrupt */
-		err = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
-				     MII_88E1318S_PHY_CSIER_WOL_EIE);
+		err = __phy_set_bits(phydev, MII_M1011_IMASK,
+				     MII_M1011_IMASK_WOL);
 		if (err < 0)
 			goto error;
 
@@ -2074,6 +2077,18 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 			goto error;
 	}
 
+	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
+		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+		if (err < 0)
+			goto error;
+
+		/* Disable the WOL interrupt, config_intr leaves it alone */
+		err = __phy_clear_bits(phydev, MII_M1011_IMASK,
+				       MII_M1011_IMASK_WOL);
+		if (err < 0)
+			goto error;
+	}
+
 error:
 	return phy_restore_page(phydev, oldpage, err);
 }
-- 
2.56.0

