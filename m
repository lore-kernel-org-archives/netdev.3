Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3347D94A
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983268; cv=none; b=rcK0v4qKUa29LkPmaOnnuetJWBhBu92Uwj2b+kPtYDmSHl/kmRdqGS8eRlofKy288WMonpiUZ4YyJFY978QptCajT9UAkJTvqRJ+Y4iMhvWqfOgADQeyKvf/aE9VFHvwbZSm5WWxkfJV0GUYRxwq7f5MWMvx00zN/6kW+USzyHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983268; c=relaxed/simple;
	bh=61WSwrssb9c8TNCp/njGvpB1zUaXcun6NGnhBHfB+MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7j3DRzOFGW+2VjIlf3oQd/3vZ3veStH/tnWUC8IfDrc2zgyx3I/LJvUlsqln3+qVCKaPXYSlQx5YBUZ0rd9oXBisv7H08hq1dqke//tpNHPk8XtFJDrBkxbmnZ8bNQ9DwfIDsBgVvF9jXbMLtSvagy60NeDIKxFMAg11LgIm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=my9u+Viy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="my9u+Viy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9E6D0C4FED5;
	Thu,  2 Jul 2026 09:07:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F81E5FF03;
	Thu,  2 Jul 2026 09:07:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00705104C9691;
	Thu,  2 Jul 2026 11:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KHdhGqOFhwRyNSafdEd66cpF3tWCslIw2j6fNzFnuDU=;
	b=my9u+Viy8RbQBoNm6OXRsgYESk8KXYYMOBOSEUGHMlQM2Hn1SAHiCofYkz2DJeiDV9rGau
	AZGb7PvDerjb6/o29IcfdyrSMoBDVNsf2saldxwxiAXJ2T/COo7MTJCA4S7X3oK25TE1H7
	7e5L3pKVm+tyeUfz3HhKKmn/FzxxNpyBDNLm5R5llET8UBcRfieJylLN4K4WEcTJ6z325g
	aQemBHgPjCnzTGvvrbscXdkNpic+5IhupvneRz3JT/sUdP+KyvRPtKYIlj5oWciunpDEEz
	8NhzMIme7QpPd3OQhZYxHYPWfnZaw2WSR7JCGq7tl93LH1IoN8/TuMGf6EeF+A==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:27 +0200
Subject: [PATCH net-next 05/10] net: dsa: microchip: move ksz_get_gbit()
 and ksz_get_xmii() to ksz9477.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-5-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ksz_get_gbit() and ksz_get_xmii() are defined in the ksz_common while
they are only used by the ksz9477 driver.

Move their definition into ksz9477.c

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c    | 56 ++++++++++++++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.c | 51 -------------------------------
 drivers/net/dsa/microchip/ksz_common.h |  2 --
 3 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 0b08d2175f17..ad6748905e08 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1181,6 +1181,58 @@ void ksz9477_port_mirror_del(struct dsa_switch *ds, int port,
 			     PORT_MIRROR_SNIFFER, false);
 }
 
+static bool ksz9477_get_gbit(struct ksz_device *dev, int port)
+{
+	const u8 *bitval = dev->info->xmii_ctrl1;
+	const u16 *regs = dev->info->regs;
+	bool gbit = false;
+	u8 data8;
+	bool val;
+
+	ksz_pread8(dev, port, regs[P_XMII_CTRL_1], &data8);
+
+	val = FIELD_GET(P_GMII_1GBIT_M, data8);
+
+	if (val == bitval[P_GMII_1GBIT])
+		gbit = true;
+
+	return gbit;
+}
+
+static phy_interface_t ksz9477_get_xmii(struct ksz_device *dev, int port,
+					bool gbit)
+{
+	const u8 *bitval = dev->info->xmii_ctrl1;
+	const u16 *regs = dev->info->regs;
+	phy_interface_t interface;
+	u8 data8;
+	u8 val;
+
+	ksz_pread8(dev, port, regs[P_XMII_CTRL_1], &data8);
+
+	val = FIELD_GET(P_MII_SEL_M, data8);
+
+	if (val == bitval[P_MII_SEL]) {
+		if (gbit)
+			interface = PHY_INTERFACE_MODE_GMII;
+		else
+			interface = PHY_INTERFACE_MODE_MII;
+	} else if (val == bitval[P_RMII_SEL]) {
+		interface = PHY_INTERFACE_MODE_RMII;
+	} else {
+		interface = PHY_INTERFACE_MODE_RGMII;
+		if (data8 & P_RGMII_ID_EG_ENABLE)
+			interface = PHY_INTERFACE_MODE_RGMII_TXID;
+		if (data8 & P_RGMII_ID_IG_ENABLE) {
+			interface = PHY_INTERFACE_MODE_RGMII_RXID;
+			if (data8 & P_RGMII_ID_EG_ENABLE)
+				interface = PHY_INTERFACE_MODE_RGMII_ID;
+		}
+	}
+
+	return interface;
+}
+
 static phy_interface_t ksz9477_get_interface(struct ksz_device *dev, int port)
 {
 	phy_interface_t interface;
@@ -1189,9 +1241,9 @@ static phy_interface_t ksz9477_get_interface(struct ksz_device *dev, int port)
 	if (dev->info->internal_phy[port])
 		return PHY_INTERFACE_MODE_NA;
 
-	gbit = ksz_get_gbit(dev, port);
+	gbit = ksz9477_get_gbit(dev, port);
 
-	interface = ksz_get_xmii(dev, port, gbit);
+	interface = ksz9477_get_xmii(dev, port, gbit);
 
 	return interface;
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 56dd4c27b182..92fcbd9605c7 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2966,39 +2966,6 @@ void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface)
 	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_1], data8);
 }
 
-phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
-{
-	const u8 *bitval = dev->info->xmii_ctrl1;
-	const u16 *regs = dev->info->regs;
-	phy_interface_t interface;
-	u8 data8;
-	u8 val;
-
-	ksz_pread8(dev, port, regs[P_XMII_CTRL_1], &data8);
-
-	val = FIELD_GET(P_MII_SEL_M, data8);
-
-	if (val == bitval[P_MII_SEL]) {
-		if (gbit)
-			interface = PHY_INTERFACE_MODE_GMII;
-		else
-			interface = PHY_INTERFACE_MODE_MII;
-	} else if (val == bitval[P_RMII_SEL]) {
-		interface = PHY_INTERFACE_MODE_RMII;
-	} else {
-		interface = PHY_INTERFACE_MODE_RGMII;
-		if (data8 & P_RGMII_ID_EG_ENABLE)
-			interface = PHY_INTERFACE_MODE_RGMII_TXID;
-		if (data8 & P_RGMII_ID_IG_ENABLE) {
-			interface = PHY_INTERFACE_MODE_RGMII_RXID;
-			if (data8 & P_RGMII_ID_EG_ENABLE)
-				interface = PHY_INTERFACE_MODE_RGMII_ID;
-		}
-	}
-
-	return interface;
-}
-
 bool ksz_phylink_need_config(struct phylink_config *config,
 			     unsigned int mode)
 {
@@ -3034,24 +3001,6 @@ void ksz_phylink_mac_config(struct phylink_config *config,
 		ksz_set_xmii(dev, port, state->interface);
 }
 
-bool ksz_get_gbit(struct ksz_device *dev, int port)
-{
-	const u8 *bitval = dev->info->xmii_ctrl1;
-	const u16 *regs = dev->info->regs;
-	bool gbit = false;
-	u8 data8;
-	bool val;
-
-	ksz_pread8(dev, port, regs[P_XMII_CTRL_1], &data8);
-
-	val = FIELD_GET(P_GMII_1GBIT_M, data8);
-
-	if (val == bitval[P_GMII_1GBIT])
-		gbit = true;
-
-	return gbit;
-}
-
 static int ksz_switch_detect(struct ksz_device *dev)
 {
 	u8 id1, id2, id4;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 347787ef1f00..2c7716d8cf28 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -395,8 +395,6 @@ void ksz_teardown(struct dsa_switch *ds);
 void ksz_init_mib_timer(struct ksz_device *dev);
 void ksz_r_mib_stats64(struct ksz_device *dev, int port);
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
-bool ksz_get_gbit(struct ksz_device *dev, int port);
-phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit);
 extern const struct ksz_chip_data ksz_switch_chips[];
 int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack);

-- 
2.54.0

