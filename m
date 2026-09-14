Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A64399DD
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416543; cv=none; b=dZE0+DgzVL/FplAQ1Lh8XCR9c6kY0tRjE2L2il/mPrmh7EN2Hs7LL3SxGH9GI2y+HA2HQSoLVHeSAFGFCcfDFJZEs2iir7qotkVLD/O4217YQ/0N7GJ9mEaF93liEDrH+dbjM0TlpU0pATb9j7TGbkEItIPicJKc7byMhFliWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416543; c=relaxed/simple;
	bh=K3UHdsfnh+cFyzk5LIBtECdzO/2C8Ng4Y9JAdPX8dls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reFuqzyNhp2jgOYemK/qV9wZ5qLFVJTwQ0BI+zqXopym3XxdXfNugfS5c9M40lRWVNGMIzHmYInlv4BLdkYn1EGpyxpceD3ga+8aEtn07F8Po/o2hhYrjNyHtawpK7pd2LDc4vt0qBOZlsMFiLjRUiM0RkLLot3vi3APoKiqw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=sKibVn6E; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="sKibVn6E"
Received: (wp-smtpd smtp.wp.pl 15071 invoked from network); 14 Sep 2026 22:08:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1789416529; bh=ekwJ+AaelhMaF3XqJiC/iFJUPbfjuMMJNQhexmkXjjs=;
          h=From:To:Cc:Subject;
          b=sKibVn6E1Oe1QOYSUSK3wqCesBY+QGZ7MtkTEOmWWoYDsmQe1K1/WKFOaK+zDjvtz
           VDWeaa99xETj3gDXwRnDLsmPR4f14aa9H0Jxap52Fh/YhZ8Yd7/ZcXYqtVG3ajtLob
           tldTPVSBat3XxAoy0qK/TbNQxrclDVD5w1eW7wCrYvwnJ5idscsbIGwwxhfSaXePit
           gAD2pPk/ailEek74ghY8XOSHwOuzRHglXfy4T/Yv9BFd6aTQ2KNUTDLph4KjCxqRS4
           ExoKcc+MqpfryhoSGjKOJL2HMv2E5OKRCiuQI8ykC8QShpYOogz1m7iFiLgIxiGf7a
           htxWHud8U1tVw==
Received: from abajkowski.lan (83.24.145.133.ipv4.supernova.orange.pl [83.24.145.133])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 14 Sep 2026 22:08:49 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net-next] net: phy: marvell: add support for active-low and active-high LEDs
Date: Mon, 14 Sep 2026 22:08:37 +0200
Message-ID: <20260914200847.445375-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: e0d0765c47ad5c23e3fd692255460fb4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000004 [8ect]                               

Add the led_polarity_set callback for setting LED polarity. Implement
this callback for the 88E1318 and 88E1510 PHYs. This should also work on
other Marvell PHYs, but I don't have access to the TRM or the hardware.

Tested on Adapteva Paralella board with Marvell 88E1318 PHY.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/marvell.c | 43 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..432ad364efd8 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -149,6 +149,8 @@
 #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
 #define MII_88E1318S_PHY_LED_FUNC_HI_Z		(0xa)
 #define MII_88E1318S_PHY_LED_FUNC_BLINK		(0xb)
+#define MII_88E1318S_PHY_LED_POL		0x11
+#define MII_88E1318S_PHY_LED_POL_ACT_HIGH(idx)	(1 << 2 * (idx))
 #define MII_88E1318S_PHY_LED_TCR		0x12
 #define MII_88E1318S_PHY_LED_TCR_FORCE_INT	BIT(15)
 #define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE	BIT(7)
@@ -304,6 +306,8 @@
 #define NB_FIBER_STATS	1
 #define NB_STAT_MAX	3
 
+#define M88E1318S_MAX_LEDS	3
+
 MODULE_DESCRIPTION("Marvell PHY driver");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
@@ -3572,7 +3576,7 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int mode, reg;
 
-	if (index > 2)
+	if (index >= M88E1318S_MAX_LEDS)
 		return -EINVAL;
 
 	reg = phy_read_paged(phydev, MII_MARVELL_LED_PAGE,
@@ -3585,6 +3589,41 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
 	return marvell_get_led_rules(index, rules, mode);
 }
 
+static int m88e1318_led_polarity_set(struct phy_device *phydev, int index,
+				     unsigned long modes)
+{
+	bool force_active_low = false, force_active_high = false;
+	u32 mode;
+
+	if (index >= M88E1318S_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			force_active_low = true;
+			break;
+		case PHY_LED_ACTIVE_HIGH:
+			force_active_high = true;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (force_active_low)
+		return phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
+					MII_88E1318S_PHY_LED_POL,
+					MII_88E1318S_PHY_LED_POL_ACT_HIGH(index), 0);
+
+	if (force_active_high)
+		return phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
+					MII_88E1318S_PHY_LED_POL, 0,
+					MII_88E1318S_PHY_LED_POL_ACT_HIGH(index));
+
+	return -EINVAL;
+}
+
 static int marvell_probe(struct phy_device *phydev)
 {
 	struct marvell_priv *priv;
@@ -3833,6 +3872,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		.led_polarity_set = m88e1318_led_polarity_set,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1145,
@@ -3947,6 +3987,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		.led_polarity_set = m88e1318_led_polarity_set,
 		.attach_mii_port = m88e1510_attach_mii_port,
 	},
 	{
-- 
2.53.0

