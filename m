Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F423438A1;
	Tue, 29 Sep 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673622; cv=pass; b=aJfNyxOdTDkw0YfcQeAH12CORwWH/w8sfJyWFi9kbogs4KRcyDNzt9jZN2n4LKWOiN/oD+dbS+PG52HROqlKsBrVkK0v6YmM2RedLbYEFmQ/WOj89EkOasO1n7eTWPadIxEbrC8iBjvN831JYT6XxiE6adE/42utB7zuVmVbrN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673622; c=relaxed/simple;
	bh=Q/Nv/8L2I/kvC9BLzgr+4SfDLzx6E4Sj9y0ZSRMnxc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXPi3AKsuLIoL1AbAZLAYmNrFkKK4pg5xA+kbz1Oz1dgdY/CeFJYhrFEFgDxAa31hYD0V9FbwipaIxEDqIMn9WI6G7RkNm/x6VsPEqSJ5jWXHNBoZsyH+KPAEf98Q990Ma9LHjN92MBydDxDLqjBXB65IeKcfD/E3vhto27QxoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DcNmU9eY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DcNmU9eY"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4D5202010E2;
	Tue, 29 Sep 2026 11:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790673608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KTSpbGDXc3PdE6Hi7O71Rzg8zNp45oU+EK9Ujeha6q0=;
	b=DcNmU9eYyDaSU4MAb06FYMyfg9yNEDzvdr5L53uHFj/y5KbQ+Ndb+k0DluE8qWUcTkEYGe
	hUTwnd1L0PLN90B+hkTpDsCjGoE+xnN/7Op5iEglO4UobFwgvvvhW2HEuZeoAj4eJMi3rA
	3BJFOGJWJCb6SfF4JvBzzsVacLrUf9SAPuk21GyFRuXKnqtS9MUNkELRMq1xZk5PLE5zRK
	hzIpo0XOOQ9bP33o+hse1nAsoFuqorJ/1LAX5CgL8XGKwvsr5XFTFo9xoFne/YUXJfjWRF
	OIFEL4WiaG1mYhqC4p4ECnXsx1mTNj/wTgAhVkFKivescFe5TKWHv4eZSQ1ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790673608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KTSpbGDXc3PdE6Hi7O71Rzg8zNp45oU+EK9Ujeha6q0=;
	b=E5xmtKQCvmv/ldN0Jzi8WkWMbb+rQ7opfDo0rXEuWSYHIUJy9qXRe+xKb+x4iMJionHGOb
	LHcKlyictrP1edQjZH3jK6kQ//U1GqF0esK5J6x8HQnms8QvsDq1UUJAe0tkowTdrAK4mU
	ZADnw4PymQqMSuzA0GDNmrkxt8hWka/lOTJEkRpXgnPdXSnnXi1dltY5Or0AbxLW8hUIRl
	Fi9wQmOEj65SjkqIdFP0YKbnvLvGoYE03cTPRtdhIjOxrdkhL6hmzsWso8/Q4WKgg0h5kz
	sDu0DeeuC81a6nbIDyPmw7cnvYoWL6WSr+j5xVPGM10KPQORoTEe16/atieh1A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790673608; a=rsa-sha256;
	cv=none;
	b=Q+Gt8PFaytlGQVNqeHv5KKZe9DzulzIt60EoO2v808xIU6HuHB3jphOiq9IgQ2VvQ2lQoB
	AdfXQngeCWaU/ZFEmY/uaEnt3RmFB53H7n7cLG8ELsFeyLo8E45BO9ikT/WhftlUraVA+2
	AMyyeY1gHAaTg/Pem5KXg06I/3ygGF8Iw3zqPAxhx0zpYQ3greCERumpZbICDJtnGxxpuS
	B/KIi6BVefXSJL+2sePzKZLvYmj7osR+9qICEXk67O164oMRwzdisQzTibshG9ObmPZRcp
	ND62g54EaA4mX/C0ygO8FNC5eWiTT7Z9I3hca/tnLntsiwKuCqKwejEtdOX+ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 42272380FA9; Tue, 29 Sep 2026 11:20:08 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>
Subject: [PATCH net-next v1 1/1] net: phy: realtek: add MDI-X support for RTL8365MB-VC
Date: Tue, 29 Sep 2026 11:20:07 +0200
Message-ID: <20260929092007.1184843-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MDI-X configuration and status reporting for the RTL8365MB-VC internal
PHYs. Without a driver hook genphy cannot reach the chip's crossover
control register, so forcing MDI/MDI-X with "ethtool -s <dev> mdix on|off"
is a no-op and "ethtool <dev>" cannot report the resolved MDI-X state on
this PHY.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/realtek/realtek_main.c | 80 ++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 3b3352e2cdc6..e14960192e79 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -239,6 +239,16 @@
 #define RTL_PHYSR_MASTER			BIT(11)
 #define RTL_PHYSR_SPEED_MASK			(RTL_PHYSR_SPEEDL | RTL_PHYSR_SPEEDH)
 
+/* MDI-X control and status of the RTL8365MB-VC internal PHY. The resolved
+ * MDI-X state is reported in RTL_PHYSR; the configuration lives in a
+ * chip-specific control register. Both are only known to apply to this model.
+ * On this chip a set select/resolved bit means MDI, not MDI-X (measured).
+ */
+#define RTL8365MB_VC_PHYCR1			0x18
+#define RTL8365MB_VC_PHYCR1_MDIX_FORCE		BIT(9)
+#define RTL8365MB_VC_PHYCR1_MDI			BIT(8)
+#define RTL8365MB_VC_PHYSR_MDI			BIT(1)
+
 #define	RTL_MDIO_PCS_EEE_ABLE			0xa5c4
 #define	RTL_MDIO_AN_EEE_ADV			0xa5d0
 #define	RTL_MDIO_AN_EEE_LPABLE			0xa5d2
@@ -3058,6 +3068,74 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int rtl8365mb_config_mdix(struct phy_device *phydev)
+{
+	u16 val;
+
+	switch (phydev->mdix_ctrl) {
+	case ETH_TP_MDI:
+		val = RTL8365MB_VC_PHYCR1_MDIX_FORCE |
+		      RTL8365MB_VC_PHYCR1_MDI;
+		break;
+	case ETH_TP_MDI_X:
+		val = RTL8365MB_VC_PHYCR1_MDIX_FORCE;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = 0;
+		break;
+	default:
+		/* Leave the hardware configuration alone until user space
+		 * asks for a specific mode.
+		 */
+		return 0;
+	}
+
+	return phy_modify_changed(phydev, RTL8365MB_VC_PHYCR1,
+				  RTL8365MB_VC_PHYCR1_MDIX_FORCE |
+				  RTL8365MB_VC_PHYCR1_MDI, val);
+}
+
+static int rtl8365mb_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = rtl8365mb_config_mdix(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* The pair assignment is only evaluated while the link is brought up,
+	 * so renegotiate if the crossover configuration changed.
+	 */
+	return __genphy_config_aneg(phydev, ret);
+}
+
+static int rtl8365mb_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read(phydev, RTL8365MB_VC_PHYCR1);
+	if (ret < 0)
+		return ret;
+
+	if (ret & RTL8365MB_VC_PHYCR1_MDIX_FORCE) {
+		if (ret & RTL8365MB_VC_PHYCR1_MDI)
+			phydev->mdix_ctrl = ETH_TP_MDI;
+		else
+			phydev->mdix_ctrl = ETH_TP_MDI_X;
+	} else {
+		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+	}
+
+	ret = phy_read(phydev, RTL_PHYSR);
+	if (ret < 0)
+		return ret;
+
+	phydev->mdix = (ret & RTL8365MB_VC_PHYSR_MDI) ? ETH_TP_MDI :
+							ETH_TP_MDI_X;
+
+	return genphy_read_status(phydev);
+}
+
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -3354,6 +3432,8 @@ static struct phy_driver realtek_drvs[] = {
 		/* Interrupt handling analogous to RTL8366RB */
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.config_aneg	= rtl8365mb_config_aneg,
+		.read_status	= rtl8365mb_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 	}, {
-- 
2.47.3

