Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE00517BCE;
	Mon, 21 Sep 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028037; cv=none; b=XD5zS0DjwyVCuNPEez9HGLfNRdqYUULd7UtEpVq1KlQoSRMrTWbD1aAzAp+2kkdfn/Mk26gbs6WEoPXq6Wbi5RXgROtQjlr1gDBxFWk1bfzXZWW69WAh3OGNRE/UtWA3ZCu+zjJyA7pI7MDLuDUuHtWvAYLNiwAakNoaJVBKgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028037; c=relaxed/simple;
	bh=N22nJtg7LQ4qb6hJ5vQdtKyzGOu9WI70Mu0cPM/nb+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZyV3+ITYT89duAYD6BEBQbGNAZ69O31OBvBE8eO0m969+3eIuTRolHGiEHg2GqGyRrXKHae5vzjqX+w0OeO1ydV/Qg9g6isn6ukWEgMZaa0wIoFKYRioeA8xPSI3BC3bj6rNZELPYoW8DZjhb0mw5znUTQYfGF+qNvX5sRdrjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aShnvq8m; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aShnvq8m"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7A4B6C0000E4;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7A4B6C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790028029;
	bh=N22nJtg7LQ4qb6hJ5vQdtKyzGOu9WI70Mu0cPM/nb+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aShnvq8mTflePsywKyU4JgIy1ApdEwkdYl8HOvDy8hE9Fr3iaNzDS2C7I2usHvOF8
	 zkzZ/W+2c+lMXXXirjCLENrt4Oa7xK+JXIMF9Bz0K6A7job2mAyD8vBjxcSABEEbIE
	 7nq9C8UYnHBC9qT7HlLuhVcGhx2NbriCHkLCerB4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 1C219AD9;
	Mon, 21 Sep 2026 15:00:29 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 3/5] net: bcmgenet: do not skip WoL power up on GENET V1
Date: Mon, 21 Sep 2026 15:00:19 -0700
Message-Id: <20260921220021.281418-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921220021.281418-1-florian.fainelli@broadcom.com>
References: <20260921220021.281418-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcmgenet_power_up() had an early check for bcmgenet_has_ext(priv) before
dispatching by power mode. GENET V1 does not have the EXT block (unlike
GENET V2+), which causes bcmgenet_power_up() to immediately return 0.

As a consequence, when waking up from GENET_POWER_WOL_MAGIC on GENET V1,
bcmgenet_wol_power_up_cfg() is never invoked to disable the WoL clock,
clear wake event masks, and restore normal PHY and MAC operations.

Move the bcmgenet_has_ext() checks to the GENET_POWER_PASSIVE and
GENET_POWER_CABLE_SENSE cases where the EXT registers are actually
accessed, allowing GENET_POWER_WOL_MAGIC cleanup to execute on all
hardware versions.

Fixes: c3ae64ae0c08 ("net: bcmgenet: handle GENET_POWER_WOL_MAGIC")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Siged-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 055e1362173b..bfb74dca55d6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1762,13 +1762,12 @@ static int bcmgenet_power_up(struct bcmgenet_priv *priv,
 	int ret = 0;
 	u32 reg;
 
-	if (!bcmgenet_has_ext(priv))
-		return ret;
-
-	reg = bcmgenet_ext_readl(priv, EXT_EXT_PWR_MGMT);
-
 	switch (mode) {
 	case GENET_POWER_PASSIVE:
+		if (!bcmgenet_has_ext(priv))
+			break;
+
+		reg = bcmgenet_ext_readl(priv, EXT_EXT_PWR_MGMT);
 		reg &= ~(EXT_PWR_DOWN_DLL | EXT_PWR_DOWN_BIAS |
 			 EXT_ENERGY_DET_MASK);
 		if (GENET_IS_V5(priv) && !bcmgenet_has_ephy_16nm(priv)) {
@@ -1792,8 +1791,12 @@ static int bcmgenet_power_up(struct bcmgenet_priv *priv,
 		break;
 
 	case GENET_POWER_CABLE_SENSE:
+		if (!bcmgenet_has_ext(priv))
+			break;
+
 		/* enable APD */
 		if (!GENET_IS_V5(priv)) {
+			reg = bcmgenet_ext_readl(priv, EXT_EXT_PWR_MGMT);
 			reg |= EXT_PWR_DN_EN_LD;
 			bcmgenet_ext_writel(priv, reg, EXT_EXT_PWR_MGMT);
 		}
-- 
2.34.1

