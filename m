Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA31DF25C;
	Sun, 29 Mar 2026 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824172; cv=none; b=COiGjC3S127QayDHLR/FETffIKtlgtLmWtzeiHTjjvxqDozYffd9/0F7zEh0qhUAjyTrP5b8zRgq46+VSBbeDX8IOvOmhJFcCmlvVDX8bAJbiuVGAd625ex+DpvxmeYpCgo8nkGt+yzrNFQ5Dv/yGYCkDc0OSfU7QVkMM4Rof+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824172; c=relaxed/simple;
	bh=OUyvD9eFuvFaSGYXUKLVaERy0588vxAJJ7Ux6EirYN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avj1REtcAVxWZwoIStXkGSp1jsT9NZyit3rpByUjzzQ5gASzIHOB/MKTIINTOWQRqax6dT2i449CFBJowh3p5XUJkdfUSDrG6mJrjhbbLFjP3+KfMax/g03GQAeqrs1GHXNXWwB0lbZ+asezZyRzBIby64kPx5xsLIBPwAleHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hbj/gQwK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hbj/gQwK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B295A5869;
	Mon, 30 Mar 2026 00:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774824155; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+sPJPQ1EPJVXS2Do8JruNXI9aH3le6IuYIcunDVpA2A=;
	b=hbj/gQwKs1CAYsplh1a4C/VegnNWtCq8vTSriin7x8VhyOTY6IRP4u70mZ03eYJLATmp4J
	/hNTmShLqxcnXhXwbUVQuB9ToaCNvdfhunBH9p5mg/Jfn+DSsFARWBiR0qxQxmLt+kCA4z
	jX3rWV3V52MjnqnQ0wjCfI26qAA0WsSDtoBFIq7jaFzTRHrlytSChEs16FQcFDqK6hceVz
	mqdIs/aUIWVsmkkSpfYrMX64rLG5Sw3f6VcfvzcP6FH7ZgLgCnTQxGFzpJEtVndy5lyIB3
	/1QgiFUgJnUdNikYWLx1XGpgoBxkp+BPw9ZwPYpAHxdykKs+d+YOcyu0eaLH4A==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: phy: microchip: add downshift tunable support for LAN88xx
Date: Mon, 30 Mar 2026 00:41:59 +0200
Message-ID: <20260329224202.500229-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329224202.500229-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Implement the standard ETHTOOL_PHY_DOWNSHIFT tunable for the LAN88xx
PHY. This allows runtime configuration of the auto-downshift feature
via ethtool:

  ethtool --set-phy-tunable eth0 downshift on count 3

The LAN88xx PHY supports downshifting from 1000BASE-T to 100BASE-TX
after 2-5 failed auto-negotiation attempts. Valid count values are
2, 3, 4 and 5.

This is based on an earlier downstream implementation by Phil Elwell.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/microchip.c  | 89 ++++++++++++++++++++++++++++++++++++
 include/linux/microchipphy.h |  9 ++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index dc8634e7bcbe..a044be1ade79 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -193,6 +193,93 @@ static void lan88xx_config_TR_regs(struct phy_device *phydev)
 		phydev_warn(phydev, "Failed to Set Register[0x1686]\n");
 }
 
+static int lan88xx_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val;
+
+	val = phy_read_paged(phydev, 1, LAN78XX_PHY_CTRL3);
+	if (val < 0)
+		return val;
+
+	if (!(val & LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT)) {
+		*data = DOWNSHIFT_DEV_DISABLE;
+		return 0;
+	}
+
+	switch (val & LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK) {
+	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2:
+		*data = 2;
+		break;
+	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3:
+		*data = 3;
+		break;
+	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4:
+		*data = 4;
+		break;
+	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5:
+		*data = 5;
+		break;
+	}
+
+	return 0;
+}
+
+static int lan88xx_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u32 mask = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK |
+		   LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT;
+	u32 val;
+
+	if (cnt == DOWNSHIFT_DEV_DISABLE)
+		return phy_modify_paged(phydev, 1, LAN78XX_PHY_CTRL3,
+					LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT, 0);
+
+	if (cnt == DOWNSHIFT_DEV_DEFAULT_COUNT)
+		cnt = 2;
+
+	switch (cnt) {
+	case 2:
+		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2;
+		break;
+	case 3:
+		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3;
+		break;
+	case 4:
+		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4;
+		break;
+	case 5:
+		val = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return phy_modify_paged(phydev, 1, LAN78XX_PHY_CTRL3, mask,
+				val | LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT);
+}
+
+static int lan88xx_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return lan88xx_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lan88xx_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return lan88xx_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int lan88xx_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -499,6 +586,8 @@ static struct phy_driver microchip_phy_driver[] = {
 	.set_wol	= lan88xx_set_wol,
 	.read_page	= lan88xx_read_page,
 	.write_page	= lan88xx_write_page,
+	.get_tunable	= lan88xx_get_tunable,
+	.set_tunable	= lan88xx_set_tunable,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX),
diff --git a/include/linux/microchipphy.h b/include/linux/microchipphy.h
index 517288da19fd..a8deae3977e9 100644
--- a/include/linux/microchipphy.h
+++ b/include/linux/microchipphy.h
@@ -61,6 +61,15 @@
 /* Registers specific to the LAN7800/LAN7850 embedded phy */
 #define LAN78XX_PHY_LED_MODE_SELECT		(0x1D)
 
+/* PHY Control 3 register (page 1) */
+#define LAN78XX_PHY_CTRL3			(0x14)
+#define  LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT	BIT(4)
+#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK	GENMASK(3, 2)
+#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2	(0 << 2)
+#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3	(1 << 2)
+#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4	(2 << 2)
+#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5	(3 << 2)
+
 /* DSP registers */
 #define PHY_ARDENNES_MMD_DEV_3_PHY_CFG		(0x806A)
 #define PHY_ARDENNES_MMD_DEV_3_PHY_CFG_ZD_DLY_EN_	(0x2000)
-- 
2.51.0

