Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC13ACEEA;
	Mon, 31 Aug 2026 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155026; cv=none; b=ko/f/TLNtcILZ+uCH7nGdm2i9HdInSP9gwgsoViD3zjC/yRRkfWxOpPLr148vM08IzEkbWVV8xe+s0zGaAPzmtlFQqFLv0VeS+LsWeXdvLr6lQ7QBmSCQQjcOLLoYRNO6rioY8DkGTZB8u759ti8Oi7coE/Do6PiZ9uSl6YpCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155026; c=relaxed/simple;
	bh=zptKGtHwEXaJwXJblEkf1LicRYQ3VPzhldYnJMRl5l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5HQDE6Qs3bDx75p9I4KR91NmLdqLF3AKIFYQ2+3RR1S1rEqiWJzexv+dc13ZQb1xRqCkKcFR3f0Pm6nZvfL+sk4gXL5qz4uWu50zvEF4SPmn17hosMpwmBIyqM7Xv/2tW9D+CpfDuLcbir63nILr7h1whQALu28CuFNWt7trWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=RbWiRd+2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="RbWiRd+2"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5bp093479100, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154671;
	bh=z47k+VAayHr7C1nUkXl5iAZSpS5O9mXWd+sGEsyi+5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RbWiRd+2zcQebBT3oVA3jTrxZJrRd124vpe+WQAO3zjP12scbaCJVzbMteC44kii+
	 jJcgXD4BdAYBZMYFh8mIQbkilU7Pn7Qi2TI55KLf/7rfwJDpb2kE1NLHzquWChyjac
	 VSddGna1izIiYvdaiib099glkj+3Ts9THHgA6RFe3rs5DmK16ZvYH+y+8JgSdgXoH2
	 hHwNE1QQiucNWlr/8cfh4oEDqUZQwN/0AGhfERKF85gHh98oEI13zUXW6I/aHLYvKW
	 gxpCIenocyg31oC6VCowzumOD77SMa0lczxqpLqPM2bbiIvP3h33pD0uJw/cJiuoBS
	 vZ6yiZbRG4DGQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5bp093479100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:37:51 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:37:50 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:37:50 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>, Andrew Lunn
	<andrew@lunn.ch>
Subject: [PATCH net-next v9 2/7] net: phy: phylink: add helper to modify pause
Date: Mon, 31 Aug 2026 13:37:40 +0800
Message-ID: <20260831053745.1197-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260831053745.1197-1-javen_xu@realsil.com.cn>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

For Realtek nics, when we enable jumbo, pause are not supported. So we
must check the pause capabilities from ourself and lp.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v5:
 - no changes, new file

Changes in v6:
 - rename phylink_update_mac_pause_capabilities(), this function only
   changes mac pause capability
 - set asym pause and pause according to config->pause tx and rx
 - add phydev->lock when change pl->phydev->advertising

Changes in v7:
 - modify the logic of phylink_update_mac_pause_capabilities
   funciton
 - extract a helper function to update phylink from phylink_ethtool_set_pauseparam

Changes in v8:
 - no changes

Changes in v9:
 - no changes
---
 drivers/net/phy/phylink.c | 171 +++++++++++++++++++++++++++-----------
 include/linux/phylink.h   |   2 +
 2 files changed, 123 insertions(+), 50 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5b8e956902fb..31d908105479 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1829,6 +1829,126 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+/**
+ * phylink_update_pause_state() - Update the phylink pause frame configuration
+ * @pl: a pointer to a &struct phylink instance
+ * @pause_state: bitmask indicating the new pause state
+ *
+ * Update the MAC pause frame (flow control) state for the phylink instance.
+ */
+static void phylink_update_pause_state(struct phylink *pl, int pause_state)
+{
+	struct phylink_link_state *config = &pl->link_config;
+	bool tx_pause = !!(pause_state & MLO_PAUSE_TX);
+	bool rx_pause = !!(pause_state & MLO_PAUSE_RX);
+	bool manual_changed;
+
+	mutex_lock(&pl->state_mutex);
+
+	/*
+	 * See the comments for linkmode_set_pause(), wrt the deficiencies
+	 * with the current implementation.  A solution to this issue would
+	 * be:
+	 * ethtool  Local device
+	 *  rx  tx  Pause AsymDir
+	 *  0   0   0     0
+	 *  1   0   1     1
+	 *  0   1   0     1
+	 *  1   1   1     1
+	 * and then use the ethtool rx/tx enablement status to mask the
+	 * rx/tx pause resolution.
+	 */
+	linkmode_set_pause(config->advertising, tx_pause,
+			   rx_pause);
+
+	manual_changed = (config->pause ^ pause_state) & MLO_PAUSE_AN ||
+			 (!(pause_state & MLO_PAUSE_AN) &&
+			   (config->pause ^ pause_state) & MLO_PAUSE_TXRX_MASK);
+
+	config->pause = pause_state;
+
+	/* Update our in-band advertisement, triggering a renegotiation if
+	 * the advertisement changed.
+	 */
+	if (!pl->phydev)
+		phylink_change_inband_advert(pl);
+
+	mutex_unlock(&pl->state_mutex);
+
+	/* If we have a PHY, a change of the pause frame advertisement will
+	 * cause phylib to renegotiate (if AN is enabled) which will in turn
+	 * call our phylink_phy_change() and trigger a resolve.  Note that
+	 * we can't hold our state mutex while calling phy_set_asym_pause().
+	 */
+	if (pl->phydev)
+		phy_set_asym_pause(pl->phydev, rx_pause, tx_pause);
+
+	/* If the manual pause settings changed, make sure we trigger a
+	 * resolve to update their state; we can not guarantee that the
+	 * link will cycle.
+	 */
+	if (manual_changed) {
+		pl->link_failed = true;
+		phylink_run_resolve(pl);
+	}
+}
+
+/**
+ * phylink_update_mac_pause_capabilities() - Dynamically update MAC pause
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ * @mac_pause: the new MAC pause capabilities mask
+ *
+ * This function allows a MAC driver to dynamically change its pause state,
+ * such as losing/gaining Pause frame support based on MTU size.
+ * It recalculates supported link modes and triggers renegotiation if needed.
+ */
+void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause)
+{
+	struct phylink_link_state *config = &pl->link_config;
+	unsigned long old_pause;
+	int pause_state;
+
+	ASSERT_RTNL();
+
+	if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
+		phylink_err(pl, "Attempted to dynamically change non-pause MAC capabilities\n");
+		return;
+	}
+
+	old_pause = pl->config->mac_capabilities & (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
+	if (old_pause == mac_pause)
+		return;
+
+	mutex_lock(&pl->state_mutex);
+
+	pl->config->mac_capabilities &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
+	pl->config->mac_capabilities |= mac_pause;
+
+	phylink_set(pl->supported, Pause);
+	phylink_set(pl->supported, Asym_Pause);
+
+	if (pl->phydev)
+		linkmode_and(pl->supported, pl->supported, pl->phydev->supported);
+	else if (pl->sfp_bus)
+		linkmode_and(pl->supported, pl->supported, pl->sfp_support);
+
+	phylink_validate(pl, pl->supported, config);
+
+	pause_state = config->pause;
+
+	if (!phylink_test(pl->supported, Pause)) {
+		pause_state &= ~(MLO_PAUSE_RX | MLO_PAUSE_TX);
+	} else if (!phylink_test(pl->supported, Asym_Pause)) {
+		if ((pause_state & MLO_PAUSE_RX) ^ (pause_state & MLO_PAUSE_TX))
+			pause_state &= ~(MLO_PAUSE_RX | MLO_PAUSE_TX);
+	}
+
+	mutex_unlock(&pl->state_mutex);
+
+	phylink_update_pause_state(pl, pause_state);
+}
+EXPORT_SYMBOL_GPL(phylink_update_mac_pause_capabilities);
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
@@ -3188,8 +3308,6 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_pauseparam);
 int phylink_ethtool_set_pauseparam(struct phylink *pl,
 				   struct ethtool_pauseparam *pause)
 {
-	struct phylink_link_state *config = &pl->link_config;
-	bool manual_changed;
 	int pause_state;
 
 	ASSERT_RTNL();
@@ -3213,54 +3331,7 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 	if (pause->tx_pause)
 		pause_state |= MLO_PAUSE_TX;
 
-	mutex_lock(&pl->state_mutex);
-	/*
-	 * See the comments for linkmode_set_pause(), wrt the deficiencies
-	 * with the current implementation.  A solution to this issue would
-	 * be:
-	 * ethtool  Local device
-	 *  rx  tx  Pause AsymDir
-	 *  0   0   0     0
-	 *  1   0   1     1
-	 *  0   1   0     1
-	 *  1   1   1     1
-	 * and then use the ethtool rx/tx enablement status to mask the
-	 * rx/tx pause resolution.
-	 */
-	linkmode_set_pause(config->advertising, pause->tx_pause,
-			   pause->rx_pause);
-
-	manual_changed = (config->pause ^ pause_state) & MLO_PAUSE_AN ||
-			 (!(pause_state & MLO_PAUSE_AN) &&
-			   (config->pause ^ pause_state) & MLO_PAUSE_TXRX_MASK);
-
-	config->pause = pause_state;
-
-	/* Update our in-band advertisement, triggering a renegotiation if
-	 * the advertisement changed.
-	 */
-	if (!pl->phydev)
-		phylink_change_inband_advert(pl);
-
-	mutex_unlock(&pl->state_mutex);
-
-	/* If we have a PHY, a change of the pause frame advertisement will
-	 * cause phylib to renegotiate (if AN is enabled) which will in turn
-	 * call our phylink_phy_change() and trigger a resolve.  Note that
-	 * we can't hold our state mutex while calling phy_set_asym_pause().
-	 */
-	if (pl->phydev)
-		phy_set_asym_pause(pl->phydev, pause->rx_pause,
-				   pause->tx_pause);
-
-	/* If the manual pause settings changed, make sure we trigger a
-	 * resolve to update their state; we can not guarantee that the
-	 * link will cycle.
-	 */
-	if (manual_changed) {
-		pl->link_failed = true;
-		phylink_run_resolve(pl);
-	}
+	phylink_update_pause_state(pl, pause_state);
 
 	return 0;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1dda5c7ed5f1..3a88a69882a6 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -843,4 +843,6 @@ void phylink_replay_link_begin(struct phylink *pl);
 
 void phylink_replay_link_end(struct phylink *pl);
 
+void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause);
+
 #endif
-- 
2.43.0

