Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5E363C50
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794082; cv=none; b=VSJLyrQKquHs7TtA16AiBwplUl8/R3tFwEXJlL7xg3DkjgdYzEiYNR8lVn35Dy2BjeBEAodH0ZUshSYTu452U7ce4TwxEb7/pkazITYMpbsBw03wwNFJlntLO6JovEPh6LfHhDXtW3acDk92rhvSjJNYh1WF+K8tIqmYcSoxKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794082; c=relaxed/simple;
	bh=yDznMIc8gIY75Ls4qDDH4bK74hDZK/dzrf/4UdiIFJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+29LJubl5OqMPe+NXa7FZDwI+3fcEIajQ9q4mDWvzL8eC2FLUDQ9nJQgCYtKVx0TLTbkeLxVaFx73JaMA7iDXG+p4SDVz2vS9jijpNhxrAmN/ZoOYxCq/dbLig9RdDAgzam7t0gGuqZuddKcTubE0YR5cZJhbDsP9mcSKoa2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn2XdiPZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn2XdiPZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb64085c45so2773240a34.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785794078; x=1786398878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8UdFlAlDvow+IM/+swbNyW6itaocfiAe9EQ4luUymI=;
        b=Pn2XdiPZCGvSMflkSd6SRQN2zFKpbUuL4ebdz6ey8C+ODoGgIT/hZSjLe89e+igPgu
         cuJEeb9beujaKoHWMXs1acKZSeB3+zvIuvtTTvQonUSb1868mXi2jVINMoN/U90edsUN
         icyzwNX/QImgdA9F6GMEvlV4JbJWLa3eiZucYWttt6U6EQYH3bIE4FIpNKesAFiv6hLf
         ibmMB7dE5pV/BK4nkep6LR1npYannVQqHQOfIbHDP6lGmKG5Y5gmpN0g2CMrWCbRzJul
         tJV6drHyj+zwHeK4R15DLKX9uN7n0s/mqcHXDqSBUAnc8aidYX+MooKCKcpbqpHoTqLt
         /8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794078; x=1786398878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8UdFlAlDvow+IM/+swbNyW6itaocfiAe9EQ4luUymI=;
        b=JW161+1LeXLI6Zs83BJJ26tKykMHCbUt2TRyc8oOGm/69egmK1w8h2s/ewUELyW3+6
         km0gR7WHK3Pok6/BzzX9yRG6XtyRYnKfTNh9fz0U61GesFWP5I2cuvXGMLPbkxp1UYCW
         I7mJW9QJeu4kSKWu1JnsWVmZOPgVAExW4Gdq08FUuehzazrLGEPKfxF1Kzd+7LRKu7fc
         s69/ieMgfbqTFWLL/It7iihDfXH0eVkYMOJ8ZNd8ybGpD/3sv5DX5hu8z+9euQwKdaMM
         saLd4xC7UVzs8SMKRxE2aJ/2Tk5W64KxwZxjJOe1+dlmqqhKalHdpYuPU2NGd9XwtL9M
         gY7w==
X-Gm-Message-State: AOJu0YzxX9ZO53TF+g/Pk+M+SaTHUCkWZBkWSeTXWjRzTYChbplhGkiI
	LtchMRR3GVz8g/C4UB6IB9M0/CiAP81o1/gWA7NjWW4INkk2A1vhvfGB
X-Gm-Gg: AR+sD11pG+wB3KJP/uowoiBBSt5d2gp4Lo8lKQ2Qq+gBSOfCTCq5kYARRpliw8ZZ4wW
	hSjzFTbLf8ObGqynuQ6GPy8+TaFoNU4IPl2/RpB4+a7viTvjiUVyHdvJIsPA2SZQPFS4nRz6vjK
	ayi9Cndu4NuEKUqEY1QvoZx/9BDpkUswzZUaQ1i1BWilhK8V85I9yfTGixXQ/q+Q0thlWbG2KHC
	JojkVlhPLQ6ICoE6sNHanj3Mc4oOQCuJdIrXjVLbe2OhGuswt6sipce/4hj1DQGXtWAychC4+aN
	N8nB6CViZO33mGBXwRszFeAc4/EtbJN+8D2ICFeOLvxqDAKTlwezOETjrmly+xV04gg5KP1uxcR
	eC5voirtqWTyPZyTBa02XuQUr9SH8WDl+i7YbZEak7LkDIhuo/ZmvguVlo198PwYzMrQNnc6sND
	jNLtuUTEDl3Qupn5TYz8Z8WDhV9r/IcPSBZGCzYi3TUl7FEnLl03tdBFBSZ8jtVnJGeuAyayYED
	8K4yAVusTb9T/cV6LSWZogL+lmUg0H+ZboH5XwWxcqAApPY/yrfOFr1ZjTrM7EOfCGmGEknNmeb
	VSeoJf8S5YDeD4XphijQJbAcOOgKUsXbWwytuxeQy4CTJzDB/joOiI+pbYWSdQTIKB53HlBw1fX
	DKv5tQN9slSFkBlw4vYO0DGnwn7U=
X-Received: by 2002:a05:6830:8387:b0:7e6:f31c:47bd with SMTP id 46e09a7af769-7f196ca981emr19428632a34.3.1785794077722;
        Mon, 03 Aug 2026 14:54:37 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c81fsm8290876a34.5.2026.08.03.14.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:54:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 03 Aug 2026 15:54:04 -0600
Subject: [PATCH v2 2/2] net: phylink: use PHY-autonomous EEE when MAC LPI
 is unavailable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-phy-autonomous-eee-v1-v2-2-222a187ba2bb@gmail.com>
References: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>
In-Reply-To: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Phylink currently treats a MAC which implements the EEE operations but
has no LPI capability for the attached interface as incapable of EEE. It
disables PHY EEE during attach and rejects ethtool EEE requests even when
the PHY can generate Tx LPI autonomously.

Use the phylib LPI-provider API during PHY bring-up. Prefer the MAC when
it supports LPI on the configured interface. For a PHY which can change
its interface with link speed, select the MAC only when every possible
interface supports LPI; otherwise keep one PHY provider across transitions.
Fall back to a configurable autonomous PHY when the MAC is unavailable.

When the PHY is selected, preserve its full EEE advertisement, route Tx
LPI configuration through phylib, and keep the MAC LPI path disabled. Only
restrict EEE modes to the MAC capability mask when the MAC is the selected
provider. Use the recorded provider for ethtool decisions rather than an
interface value which may not yet represent an established link.

If neither provider is usable, retain the existing EEE-disable and
-EOPNOTSUPP behaviour. This does not add a userspace provider selector; the
difference between MAC-managed and PHY-autonomous EEE remains an
implementation detail.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - use the explicit phylib LPI-provider selection API
  - evaluate MAC LPI support for the attached PHY interface
  - require MAC LPI support on every possible interface for PHYs that can
    change interface with link speed
  - fall back to autonomous PHY LPI only when supported and keep EEE
    unavailable when neither provider is usable
---
 drivers/net/phy/phylink.c | 89 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 18d2ead97aa5..f644524d627e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1512,6 +1512,47 @@ static void phylink_deactivate_lpi(struct phylink *pl)
 	}
 }
 
+static bool phylink_phy_supports_autonomous_eee(struct phy_device *phy)
+{
+	return phy && phy_has_autonomous_eee(phy);
+}
+
+static bool phylink_phy_manages_eee(struct phy_device *phy)
+{
+	return phy &&
+	       phy->eee_lpi_provider == PHY_EEE_LPI_PROVIDER_PHY;
+}
+
+static bool phylink_mac_manages_eee(struct phy_device *phy)
+{
+	return phy &&
+	       phy->eee_lpi_provider == PHY_EEE_LPI_PROVIDER_MAC;
+}
+
+static bool
+phylink_mac_supports_eee_interface(struct phylink *pl,
+				   phy_interface_t interface)
+{
+	return pl->mac_supports_eee &&
+	       test_bit(interface, pl->config->lpi_interfaces);
+}
+
+static bool phylink_mac_supports_eee_phy(struct phylink *pl,
+					 struct phy_device *phy,
+					 phy_interface_t interface)
+{
+	if (!pl->mac_supports_eee)
+		return false;
+
+	/* Keep one provider for PHYs which change their interface with speed. */
+	if (!phy_interface_empty(phy->possible_interfaces))
+		return bitmap_subset(phy->possible_interfaces,
+				     pl->config->lpi_interfaces,
+				     PHY_INTERFACE_MODE_MAX);
+
+	return phylink_mac_supports_eee_interface(pl, interface);
+}
+
 static void phylink_activate_lpi(struct phylink *pl)
 {
 	int err;
@@ -2090,6 +2131,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 {
 	struct phylink_link_state config;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+	bool phy_eee;
+	bool mac_eee;
 	char *irq_str;
 	int ret;
 
@@ -2106,6 +2149,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	linkmode_copy(supported, phy->supported);
 	linkmode_copy(config.advertising, phy->advertising);
 	config.interface = interface;
+	mac_eee = phylink_mac_supports_eee_phy(pl, phy, interface);
+	phy_eee = !mac_eee && phylink_phy_supports_autonomous_eee(phy);
 
 	ret = phylink_validate_phy(pl, phy, supported, &config);
 	if (ret) {
@@ -2141,10 +2186,21 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	/* Restrict the phy advertisement according to the MAC support. */
 	linkmode_copy(phy->advertising, config.advertising);
 
+	if (pl->mac_supports_eee) {
+		/* Convert the MAC's LPI capabilities to linkmodes. */
+		linkmode_zero(pl->supported_lpi);
+		phylink_caps_to_linkmodes(pl->supported_lpi,
+					  pl->config->lpi_capabilities);
+	}
+
 	/* If the MAC supports phylink managed EEE, restrict the EEE
 	 * advertisement according to the MAC's LPI capabilities.
 	 */
-	if (pl->mac_supports_eee) {
+	if (mac_eee) {
+		ret = phy_disable_autonomous_eee(phy);
+		if (ret)
+			goto out_unlock;
+
 		/* If EEE is enabled, then we need to call phy_support_eee()
 		 * to ensure that the advertising mask is appropriately set.
 		 * This also enables EEE at the PHY.
@@ -2155,24 +2211,30 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		phy->eee_cfg.tx_lpi_enabled = pl->eee_cfg.tx_lpi_enabled;
 		phy->eee_cfg.tx_lpi_timer = pl->eee_cfg.tx_lpi_timer;
 
-		/* Convert the MAC's LPI capabilities to linkmodes */
-		linkmode_zero(pl->supported_lpi);
-		phylink_caps_to_linkmodes(pl->supported_lpi,
-					  pl->config->lpi_capabilities);
-
 		/* Restrict the PHYs EEE support/advertisement to the modes
 		 * that the MAC supports.
 		 */
 		linkmode_and(phy->advertising_eee, phy->advertising_eee,
 			     pl->supported_lpi);
+	} else if (phy_eee) {
+		if (pl->eee_cfg.eee_enabled)
+			phy_advertise_eee_all(phy);
+
+		phy->eee_cfg = pl->eee_cfg;
+		ret = phy_support_autonomous_eee(phy);
+		if (ret)
+			goto out_unlock;
 	} else if (pl->mac_supports_eee_ops) {
 		/* MAC supports phylink EEE, but wants EEE always disabled. */
 		phy_disable_eee(phy);
 	}
 
+out_unlock:
 	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
 	mutex_unlock(&pl->phydev_mutex);
+	if (ret)
+		return ret;
 
 	phylink_dbg(pl,
 		    "phy: %s setting supported %*pb advertising %*pb\n",
@@ -3300,17 +3362,20 @@ EXPORT_SYMBOL_GPL(phylink_get_eee_err);
  */
 int phylink_ethtool_get_eee(struct phylink *pl, struct ethtool_keee *eee)
 {
+	bool mac_eee;
 	int ret = -EOPNOTSUPP;
 
 	ASSERT_RTNL();
+	mac_eee = phylink_mac_manages_eee(pl->phydev);
 
-	if (pl->mac_supports_eee_ops && !pl->mac_supports_eee)
+	if (pl->mac_supports_eee_ops && !mac_eee &&
+	    !phylink_phy_manages_eee(pl->phydev))
 		return ret;
 
 	if (pl->phydev) {
 		ret = phy_ethtool_get_eee(pl->phydev, eee);
 		/* Restrict supported linkmode mask */
-		if (ret == 0 && pl->mac_supports_eee_ops)
+		if (ret == 0 && mac_eee)
 			linkmode_and(eee->supported, eee->supported,
 				     pl->supported_lpi);
 	}
@@ -3326,10 +3391,11 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_eee);
  */
 int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_keee *eee)
 {
-	bool mac_eee = pl->mac_supports_eee;
+	bool mac_eee;
 	int ret = -EOPNOTSUPP;
 
 	ASSERT_RTNL();
+	mac_eee = phylink_mac_manages_eee(pl->phydev);
 
 	phylink_dbg(pl, "mac %s phylink EEE%s, adv %*pbl, LPI%s timer %uus\n",
 		    mac_eee ? "supports" : "does not support",
@@ -3337,12 +3403,13 @@ int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_keee *eee)
 		    __ETHTOOL_LINK_MODE_MASK_NBITS, eee->advertised,
 		    eee->tx_lpi_enabled ? " enabled" : "", eee->tx_lpi_timer);
 
-	if (pl->mac_supports_eee_ops && !mac_eee)
+	if (pl->mac_supports_eee_ops && !mac_eee &&
+	    !phylink_phy_manages_eee(pl->phydev))
 		return ret;
 
 	if (pl->phydev) {
 		/* Restrict advertisement mask */
-		if (pl->mac_supports_eee_ops)
+		if (mac_eee)
 			linkmode_and(eee->advertised, eee->advertised,
 				     pl->supported_lpi);
 		ret = phy_ethtool_set_eee(pl->phydev, eee);

-- 
2.53.0

