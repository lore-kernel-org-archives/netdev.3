Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17525BA3D;
	Fri, 17 Jul 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294655; cv=none; b=KX/youE7O/07h4LdgkTHQsczy+qGKH52WCsIvonp8xcCCC+E1Ty8TTFX3c5p09cZEmLCDvtLl/9UXJYQXVjmsR0GBHZFWPPaeh2/99+d3uAcrRA0ODMTqyY9uXLSJFVtXF7bNCkelmxypzKka0Gzbc3hc9qz0dUx6r0CD7xak6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294655; c=relaxed/simple;
	bh=Wh5aAHP76/WeVELUcKivGAIVaxiVIRXfYJQCXwoCO88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m82e/X/uTIV2ovkGX/jZpMxHTJIZnie9PXfrvnVCmrlzIAKP60RL5wQMBrZyCNVZWtr4d69xq+tJm+KaEwxO7YaKO+MHoPZpkrBcs7si2xSAAKzTEJnDvyjKF9U7w37w1TyR31cDJiLsYuJV8ZfBI23fTWZMSShCnmSxHa8r2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpxdzmTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpxdzmTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74081F000E9;
	Fri, 17 Jul 2026 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294653;
	bh=9deRSWKyipGxDDO9EO+7ahzRIydEVDZEpzWVIqwuNlA=;
	h=From:To:Cc:Subject:Date;
	b=RpxdzmTopOGc2MutgjHzUSv41g605RtmNyYhpCxNWtrH5GQth1qiphg7rfohBSu/j
	 /n7cD8q9l7WjewtPyWKe+0JMBWPKd36XY8H6g3VMLj3Qmh8ii3vM9ma8yCZ1GTdhcc
	 W0fh2y5DkhS1AY9KQwKCc/z2ir4UdWctd5pVj//rYhAFGVokidf0ytJ7yeocyelG3T
	 Nva5TityhbSjW5RR39e7KQBAsrPjxDvNlOEEk/VUCFYNWEqrMWnRMBPY3kAbb1LskG
	 RQe3/vFrKT/aOVr7FYQV29izj5DdrAeUR24yn86ficv7vQ7OsILDk6FYfyPedPlW+q
	 c8uOajRwSzOig==
From: Michael Walle <mwalle@kernel.org>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net v3] net: dpaa: fix mode setting
Date: Fri, 17 Jul 2026 15:20:29 +0200
Message-ID: <20260717132401.2653252-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before converting to the phylink interface, the init function would have
set a non-reserved I/F mode in the maccfg2 register. After converting to
phylink, 0 is written as mode, which is a reserved value (although it's
the hardware default). Without a valid mode, a SGMII link is never
established between the MAC and the PHY and thus .link_up() is never
called which could set the correct mode according to the actual speed.

Fix it by setting the maximum speed of the phy_interface_t in use in
.mac_config() - just like the driver did before the phylink conversion.

Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
Suggested-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
I didn't grab Sean's Rb tag as this is somewhat different.

Changes in v3:
 - keep the mode setting also in .adjust_link().
 - reword the commit message, to be (hopefully) more precise
 - Link to v2: https://lore.kernel.org/r/20260710143430.2276141-1-mwalle@kernel.org/

Changes in v2:
 - the setting is/was based on the maximum speed, not the current
   speed. thus, move the setting into mac_config().
 - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/

 .../net/ethernet/freescale/fman/fman_dtsec.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index fe35703c509e..b8d70c0ecb6c 100644
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
-- 
2.47.3

