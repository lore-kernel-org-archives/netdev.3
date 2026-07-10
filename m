Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CC285CAE;
	Fri, 10 Jul 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694080; cv=none; b=Ttr8kSzdQP/B3UJC7fOQ0nEgYhfzskiOTxli/H7TcbPU0T/pd4JMwbqL/sM10t2uzNtsypCB4jSEsXx0GvQsEoWK7HIuWi2Qd4IX2PSSQ2lX0qxs4PGikQsfVPUzFGIya1c5dTYdP4CGUwXJ5sJr+W29r9CB+eYMJm4YHx1o2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694080; c=relaxed/simple;
	bh=m5u5jWzMfb3bFFbg/FF1bJfqcZZG0HRJ+m7H+CYTAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKQ3kMjTEcO6703oig+PQ3JZh0uP6gu7RlRssNCo8OMBSzAGW2wuD+I7heDSCOb0ZI92fGt3elyc8SbGlsZot+CQjKfpCpqWf1g+sU9ihBE9BtzWgnpvGHZiUPw2R+mKMwxkdISIfr2j3AddxLCyQQDooArtnP4k1bLWfMNYefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVRsbNNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVRsbNNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC5E1F00A3A;
	Fri, 10 Jul 2026 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694078;
	bh=0ENWpG1z+0rCGqz4fuziQTcjVKazqA7gHCFR1DJEeGo=;
	h=From:To:Cc:Subject:Date;
	b=SVRsbNNFN+GhoZq62ZDUP9+h/7Oo9lhea0KwU8jgFYWW4P1CGYIH99+HTSh/qn1vK
	 eKbYuH+RBEEbjh4l2WsVTb8FW3aAGf511iQ7bd1x7YvtjoVLulGCD7TyiW81R7IO+I
	 F7LFrGGfKKCk8UCzarTxEPZYDKRUFZriR6uMK3QX3q7u48VKhOj57aTNPlyA1tnfdQ
	 TExq4dTUDQvHUHUupEW1sSc9MSBKNwTEGTZNQ+c6bK/XgBV4QKIlTgbYQaCPP5lj7l
	 kJajjEAL9vA0B2yHJFQscq6E+gbhdGdhT04zXSmFNxiNLYrt+Tger4pMcihrWR6yZw
	 5iS/GT6QvXbSw==
From: Michael Walle <mwalle@kernel.org>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net v2] net: dpaa: fix mode setting
Date: Fri, 10 Jul 2026 16:22:29 +0200
Message-ID: <20260710143430.2276141-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before converting to the phylink interface, the init function would have
set the correct I/F mode depending on the maximum link speed of an
interface. After converting to phylink, the established link speed
is used to determine this setting and is set in the .link_up()
callback. The callback isn't called because the link is never
established between the PCS and a connected SGMII PHY.
To fix it, don't use the current speed, but set the mode depending on
the interface (which implies the maximum speed) in .mac_config().

Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
Suggested-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
FWIW, I dropped setting a non-reserved mode in init(). The hardware
default is 0 and the mac_config() will set a valid mode anyway.

Changes in v2:
 - the setting is/was based on the maximum speed, not the current
   speed. thus, move the setting into mac_config().
 - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/

 .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index fe35703c509e..7075f93bab49 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
 {
 	struct mac_device *mac_dev = fman_config_to_mac(config);
 	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
-	u32 tmp;
+	u32 ecntrl, maccfg2;
+
+	maccfg2 = ioread32be(&regs->maccfg2);
+	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
 
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_RMII:
-		tmp = DTSEC_ECNTRL_RMM;
+		ecntrl = DTSEC_ECNTRL_RMM;
+		maccfg2 |= MACCFG2_NIBBLE_MODE;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
+		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
+		maccfg2 |= MACCFG2_BYTE_MODE;
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
-		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
+		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
+		maccfg2 |= MACCFG2_BYTE_MODE;
 		break;
 	default:
 		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
@@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
 		return;
 	}
 
-	iowrite32be(tmp, &regs->ecntrl);
+	iowrite32be(ecntrl, &regs->ecntrl);
+	iowrite32be(maccfg2, &regs->maccfg2);
 }
 
 static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
@@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
 	iowrite32be(tmp, &regs->ecntrl);
 
 	tmp = ioread32be(&regs->maccfg2);
-	tmp &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPLEX);
-	if (speed >= SPEED_1000)
-		tmp |= MACCFG2_BYTE_MODE;
-	else
-		tmp |= MACCFG2_NIBBLE_MODE;
-
 	if (duplex == DUPLEX_FULL)
 		tmp |= MACCFG2_FULL_DUPLEX;
-
+	else
+		tmp &= ~MACCFG2_FULL_DUPLEX;
 	iowrite32be(tmp, &regs->maccfg2);
 
 	mac_dev->update_speed(mac_dev, speed);
-- 
2.47.3

