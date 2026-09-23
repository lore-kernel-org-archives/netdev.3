Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35F457E6E
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196388; cv=none; b=smKU1BN9NYkLysBt8zdCMzkUIiemB0TjqUMuQEk0NZi5MfAyDYPVy/HixV4/0deFGxWW6DcAts8Q1htWG/pcksgyuz1SjNA9svOhQaVlAAdte7i7ePVzW/xHX6uICnVfDW8dl3kvf4X0ZlgJaVjinLgkcWde3MlMcf5JClMNQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196388; c=relaxed/simple;
	bh=1RSsVTsF8rxYpCqmUszQs/yq1KL6up3gWKZazL5Ju20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3vTf2/u8wyMP36to6nyVR0nbhQlFh3SIFvX1REYp4q+1X23btMpBElwBQ+Q4UwRLg22zO6MlfqtObhUywomEQWHYdG4qVy3CB6QC8ZM3fPqvTuNw0Ja0mbcxsrSuTSDQtADu3ebaG7HjwGeOktzb/G79u/PwoY87Akf1vyg4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=RSY1VFK5; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="RSY1VFK5"
Received: (wp-smtpd smtp.wp.pl 33526 invoked from network); 23 Sep 2026 22:46:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1790196376; bh=MplndVzQXrwlklXM1Sy8asTyO6X4sqD+CK3zTG6TtSc=;
          h=From:To:Cc:Subject;
          b=RSY1VFK55GNwW694qms9xWO5x3XFABWVRrhaQHCJIh2j7145OJlwJ55p1aCtppxxH
           bWqKaN4wjgZYxYWHqD0YYvjkXZ72Wjt0yZ0N5aPSPcLxI/98WBNbikSeCumUpvAlcb
           IPnSxExL0zotrK1Qs8GmU/fnRHsCJmwBYH4NowXZu0SfF26aJ25yQbCY05fr0sci+6
           zKx0U+CuhyYitm5VRX/6IR9ajzaYF+65WvptbmS+8Np3/3UJkZpC6YUZDVgZV3MTFD
           WuIgizwErQLs2K0HjcPdUeocunq75ZKlhI4jB0YrGSXy6H1W9VIy2BUmqkobzjlXMT
           rgADhdUMnyStQ==
Received: from abajkowski.lan (83.5.247.11.ipv4.supernova.orange.pl [83.5.247.11])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 23 Sep 2026 22:46:16 +0200
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
Subject: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs polarity modes
Date: Wed, 23 Sep 2026 22:45:24 +0200
Message-ID: <20260923204614.471409-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 2b96e92b93ee6fed9400b7294a078df1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [oTC8]                               

Add the led_polarity_set callback for setting LED polarity. Implement
this callback for the 88E1318 and 88E1510 PHYs. This should also work on
other Marvell PHYs, but I don't have access to the TRM or the hardware.

Tested on Adapteva Paralella board with Marvell 88E1318 PHY.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
Changes in v2:
 - add suppoer for PHY_LED_INACTIVE_HIGH_IMPEDANCE mode
---
 drivers/net/phy/marvell.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..d57fcabfec2b 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -149,6 +149,9 @@
 #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
 #define MII_88E1318S_PHY_LED_FUNC_HI_Z		(0xa)
 #define MII_88E1318S_PHY_LED_FUNC_BLINK		(0xb)
+#define MII_88E1318S_PHY_LED_POL		0x11
+#define MII_88E1318S_PHY_LED_POL_ACT_HIGH(idx)	BIT(2 * (idx))
+#define MII_88E1318S_PHY_LED_POL_HIGH_IMP(idx)	BIT(2 * (idx) + 1)
 #define MII_88E1318S_PHY_LED_TCR		0x12
 #define MII_88E1318S_PHY_LED_TCR_FORCE_INT	BIT(15)
 #define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE	BIT(7)
@@ -304,6 +307,8 @@
 #define NB_FIBER_STATS	1
 #define NB_STAT_MAX	3
 
+#define M88E1318S_MAX_LEDS	3
+
 MODULE_DESCRIPTION("Marvell PHY driver");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
@@ -3572,7 +3577,7 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int mode, reg;
 
-	if (index > 2)
+	if (index >= M88E1318S_MAX_LEDS)
 		return -EINVAL;
 
 	reg = phy_read_paged(phydev, MII_MARVELL_LED_PAGE,
@@ -3585,6 +3590,36 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
 	return marvell_get_led_rules(index, rules, mode);
 }
 
+static int m88e1318_led_polarity_set(struct phy_device *phydev, int index,
+				     unsigned long modes)
+{
+	u16 val = 0;
+	u32 mode;
+
+	if (index >= M88E1318S_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			break;
+		case PHY_LED_ACTIVE_HIGH:
+			val |= MII_88E1318S_PHY_LED_POL_ACT_HIGH(index);
+			break;
+		case PHY_LED_INACTIVE_HIGH_IMPEDANCE:
+			val |= MII_88E1318S_PHY_LED_POL_HIGH_IMP(index);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
+				MII_88E1318S_PHY_LED_POL,
+				MII_88E1318S_PHY_LED_POL_ACT_HIGH(index) |
+				MII_88E1318S_PHY_LED_POL_HIGH_IMP(index), val);
+}
+
 static int marvell_probe(struct phy_device *phydev)
 {
 	struct marvell_priv *priv;
@@ -3833,6 +3868,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		.led_polarity_set = m88e1318_led_polarity_set,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1145,
@@ -3947,6 +3983,7 @@ static struct phy_driver marvell_drivers[] = {
 		.led_hw_is_supported = m88e1318_led_hw_is_supported,
 		.led_hw_control_set = m88e1318_led_hw_control_set,
 		.led_hw_control_get = m88e1318_led_hw_control_get,
+		.led_polarity_set = m88e1318_led_polarity_set,
 		.attach_mii_port = m88e1510_attach_mii_port,
 	},
 	{
-- 
2.53.0

