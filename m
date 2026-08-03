Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EE360EEE
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794082; cv=none; b=oEvcctwc6hDII/3Gg+r05u2mITePptTDS6Rm0xZ77v4Ng0PdoRIoLEjY/UaKqcoqLwyfXFX33Ado9FEwZeCosB5NqtTup5f6BKkG9XOkVkVgZid9E1wA8pzenAu7MvmoCH2dxCJ72/KN4vmRV5GYWzvevjosWmlm/SFR7k16u2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794082; c=relaxed/simple;
	bh=YEv4MDjZYBIiD2pEKuj9uC6Zug/eqbgAYmc1gAskbiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sqwBS1f2flOC2+3HGEc3ETD6n8ar3lR1KN47uj7DinamSt+40FDOaU1sB2Y52XKux8yrspgDIQfrsRHPZiGGpWOamlhnSH/TVrD3zfOrqdr3Dyb1kW48GJRK3NX5B9LbQ9oKa1+kElUa80epBGYbQtfM2lgUpFzKGxGzqeniixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL6Fxa4h; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL6Fxa4h"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ebd88be784so2480205a34.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785794077; x=1786398877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AHjFZw1Azgoi1kf/VltekG6OuCnq3PByHaECGSDSYA=;
        b=ZL6Fxa4htB35zzzi2TABfXN8d+phTdrPKUfllr3uqpEXSIZLpzo+290PF+hH+G4seu
         UmBFZxYJcErJ14mc/jUnzWveIjhyrk91mm+s8C7Yaqng+GaALnCRO6f0UuQX0NraD9y2
         RbZVww99rJRilS7zsXZSAQk1ndbqhtiCdVBLVKscyIKsNUzcfXRmqb/cHtX7GhdKcFYP
         3XsfWy0+Ae25DdHZ/Fdj89/x1cBd5uGEkBHfbeyvoeI32yOffToB1J1m4Thz5Ai3L+Dj
         ZuoObtWudnxR4erb4u/Uw0YjdA1XZrgUYaNXKSeYN3NYiGEg025G9sJcOzuqX2giBr+K
         0Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794077; x=1786398877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7AHjFZw1Azgoi1kf/VltekG6OuCnq3PByHaECGSDSYA=;
        b=YWACmMxcUnCrVZ+o8gnxfoQWZOongjlG0QSSLKNQT9lUC4eKXmqn2oL7ERfE0yP1Zw
         Xodmr1rroOaOPURUOaBH6fLlKmYndbEl708V4M8FlYbNMKWhom/v5+JU+lcApe/jz7vd
         MjCGwD5y+lYhm6SSJtBNnBFOeCguVKeidNLWhY6TS6xhkI11g9+Uc3Fqgr7m6utlQlHW
         iGGfCqZ+W9c+BxvbXUOEAC7d1jrX57+ziCB8QclpObT9g5DRUGeQUftUcTa7z9Zv07DH
         q9WzeXaMmuclr4o7TUm+86XbQujx5l6JU8oIrb0nUTELl47oMnTTWSVJASKaJ8lwF2Xd
         v5UA==
X-Gm-Message-State: AOJu0YxOVYawQVzp6WieFevJvKpKuX5TLQjF46Nmflmw73Ous0FjBVjq
	E7YpKG9z1gVqXHFVbk+antwXpbPkehl8rzPTxshJyGB6DY/e0LWVW4HS
X-Gm-Gg: AR+sD12ELbkka/jxK3jcsbV+Cr5tX/iWQLlx3uiXvYe304oIe3ZanoZqGy/GHuPOux2
	E3epe/dkStKbJ5gOSrdUs/H5JGL0y8y5HCUpeETVoAtzWGckUUggLU19BlizHpWLOoX2GU5JkM9
	QSeXc7jSB/C8JYFVTVrAVs9SjiplXu67Rq6UY6MmKxxlYU0EfRrPvDprt4ckSMrIXHU+vtcaoTh
	u9e5H6B/buQ9Puu5iQbyQU29Q2U8kcOngVFe+2Tpsj2ZkeTQAwFqkzaxDSJF1NJubYSgHopVe5A
	LFxDzqf2gU1NJoycHh1QtiY5f14aVJOkASgSOfHV30Pvpx0iPfywg4d1celKibgOgvAV337yjbQ
	W0NwfH59z/l9mlVrEEGVrltKq6GlUeO7VmWIWD3VDfVfu55zbOSigTFOyBJJ/dUPuhPH+YOCNfq
	k/tZ/SqRpcWCzjsElRiTEf9qKLcrIfVsDzm9V9RoWtiP95xiP1YwSxoA1neafrNLaW2X96FaCmT
	BUHOLiHm5417Hm/3fJg1Bt2iQp7+u2hf5/aFqKKcKbHvXBEg4un7du9NS5cSs+kS5DlbTPuWfec
	56RyCzrcU97pXmcnaxHNWYZ+f3oGNvYgeptcbEWW6tnPGcLrRbeDT7n0iZe+UmWmHMAIKgcvoBN
	5PcWUCWWgrIrdq/WZ
X-Received: by 2002:a05:6830:3888:b0:7e6:e385:4c1e with SMTP id 46e09a7af769-7f196b9a988mr20757395a34.4.1785794076944;
        Mon, 03 Aug 2026 14:54:36 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c81fsm8290876a34.5.2026.08.03.14.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:54:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 03 Aug 2026 15:54:03 -0600
Subject: [PATCH v2 1/2] net: phy: support PHY-autonomous EEE as an LPI
 provider
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-phy-autonomous-eee-v1-v2-1-222a187ba2bb@gmail.com>
References: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>
In-Reply-To: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Some PHYs can generate transmit Low Power Idle (LPI) autonomously after
EEE is negotiated. Phylib can currently disable this mode when a MAC
takes control, but cannot select the PHY as the LPI provider or apply
ethtool Tx LPI settings to it.

Callback presence alone is not enough to infer ownership. Phylib must
remember whether the MAC or PHY was selected so that enable_tx_lpi only
asks the MAC to generate LPI in the former case.

Add explicit MAC, PHY and legacy provider states. The legacy state
preserves the behaviour of drivers which have not selected a provider.
Add set_autonomous_eee(), a narrow PHY-driver operation taking only the
enable state and idle timer rather than the complete ethtool structure.

Expose phylib calls to select either provider, allowing non-phylink
drivers to use the same policy, and make phy_support_eee() select the MAC
provider as existing callers expect. When the PHY is selected, apply Tx
LPI changes through the new operation, roll them back if the EEE update
fails, and keep enable_tx_lpi clear so the MAC is not also enabled.

Restore the selected provider after PHY reset. Drivers without the new
operation retain the legacy behaviour, while drivers implementing only
disable_autonomous_eee() continue to support the MAC handoff.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - model legacy, MAC and PHY LPI providers explicitly instead of inferring
    ownership from callback presence
  - replace the callback taking eee_config with set_autonomous_eee() taking
    only the enable state and timer
  - add phylib provider-selection helpers for phylink and non-phylink users
  - route Tx LPI updates, rollback and reset restoration only to the selected
    provider
  - keep enable_tx_lpi clear when the PHY supplies LPI
---
 drivers/net/phy/phy.c        |  48 ++++++++++++++++--
 drivers/net/phy/phy_device.c | 118 +++++++++++++++++++++++++++++++++++++------
 include/linux/phy.h          |  41 +++++++++++++--
 3 files changed, 184 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..86d63d380ab2 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1024,8 +1024,10 @@ static int phy_check_link_status(struct phy_device *phydev)
 		phydev->state = PHY_RUNNING;
 		err = genphy_c45_eee_is_active(phydev, NULL);
 		phydev->eee_active = err > 0;
-		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
-					phydev->eee_active;
+		phydev->enable_tx_lpi =
+			phydev->eee_lpi_provider !=
+			PHY_EEE_LPI_PROVIDER_PHY &&
+			phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
 
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
@@ -1970,7 +1972,8 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
 {
 	bool enable_tx_lpi;
 
-	if (!phydev->link)
+	if (!phydev->link ||
+	    phydev->eee_lpi_provider == PHY_EEE_LPI_PROVIDER_PHY)
 		return;
 
 	enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
@@ -1996,6 +1999,8 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
 	struct eee_config old_cfg;
+	bool tx_lpi_cfg_attempted = false;
+	bool tx_lpi_cfg_changed;
 	int ret;
 
 	if (!phydev->drv)
@@ -2005,16 +2010,49 @@ int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	old_cfg = phydev->eee_cfg;
 	eee_to_eeecfg(&phydev->eee_cfg, data);
+	tx_lpi_cfg_changed = phydev->eee_cfg.tx_lpi_enabled !=
+			     old_cfg.tx_lpi_enabled ||
+			     phydev->eee_cfg.tx_lpi_timer !=
+			     old_cfg.tx_lpi_timer;
+
+	if (tx_lpi_cfg_changed &&
+	    phydev->eee_lpi_provider == PHY_EEE_LPI_PROVIDER_PHY) {
+		ret = phydev->drv->set_autonomous_eee(phydev,
+				phydev->eee_cfg.tx_lpi_enabled,
+				phydev->eee_cfg.tx_lpi_timer);
+		tx_lpi_cfg_attempted = true;
+		if (ret)
+			goto restore_tx_lpi;
+	}
 
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
 	if (ret == 0)
 		phy_ethtool_set_eee_noneg(phydev, &old_cfg);
 	else if (ret < 0)
-		phydev->eee_cfg = old_cfg;
+		goto restore_tx_lpi;
 
 	mutex_unlock(&phydev->lock);
 
-	return ret < 0 ? ret : 0;
+	return 0;
+
+restore_tx_lpi:
+	if (tx_lpi_cfg_attempted) {
+		int rollback_ret;
+
+		rollback_ret = phydev->drv->set_autonomous_eee(phydev,
+				old_cfg.tx_lpi_enabled,
+				old_cfg.tx_lpi_timer);
+		if (rollback_ret)
+			phydev_warn(phydev,
+				    "Failed to restore autonomous Tx LPI: %pe\n",
+				    ERR_PTR(rollback_ret));
+	}
+
+	phydev->eee_cfg = old_cfg;
+
+	mutex_unlock(&phydev->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL(phy_ethtool_set_eee);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..f07df601267a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1338,6 +1338,96 @@ static int phy_poll_reset(struct phy_device *phydev)
 	return 0;
 }
 
+bool phy_has_autonomous_eee(struct phy_device *phydev)
+{
+	return phydev->drv && phydev->drv->set_autonomous_eee;
+}
+EXPORT_SYMBOL_GPL(phy_has_autonomous_eee);
+
+static int phy_configure_autonomous_eee(struct phy_device *phydev,
+					bool enable)
+{
+	if (phydev->drv->set_autonomous_eee)
+		return phydev->drv->set_autonomous_eee(phydev, enable,
+					phydev->eee_cfg.tx_lpi_timer);
+
+	if (!enable && phydev->drv->disable_autonomous_eee)
+		return phydev->drv->disable_autonomous_eee(phydev);
+
+	return enable ? -EOPNOTSUPP : 0;
+}
+
+static int phy_set_eee_lpi_provider(struct phy_device *phydev,
+				    enum phy_eee_lpi_provider provider)
+{
+	bool autonomous;
+	int ret;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	switch (provider) {
+	case PHY_EEE_LPI_PROVIDER_MAC:
+		autonomous = false;
+		break;
+	case PHY_EEE_LPI_PROVIDER_PHY:
+		if (!phy_has_autonomous_eee(phydev))
+			return -EOPNOTSUPP;
+		autonomous = phydev->eee_cfg.tx_lpi_enabled;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (phydev->eee_lpi_provider == provider)
+		return 0;
+
+	ret = phy_configure_autonomous_eee(phydev, autonomous);
+	if (ret)
+		return ret;
+
+	phydev->eee_lpi_provider = provider;
+	phydev->enable_tx_lpi = provider != PHY_EEE_LPI_PROVIDER_PHY &&
+				phydev->eee_cfg.tx_lpi_enabled &&
+				phydev->eee_active;
+
+	return 0;
+}
+
+/**
+ * phy_disable_autonomous_eee - hand EEE Tx LPI control to the MAC
+ * @phydev: PHY device to configure
+ *
+ * Disable PHY-autonomous EEE without changing EEE advertisement. The current
+ * Tx LPI policy remains in &phy_device.eee_cfg and phylib reports its resolved
+ * state to the MAC through &phy_device.enable_tx_lpi.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int phy_disable_autonomous_eee(struct phy_device *phydev)
+{
+	return phy_set_eee_lpi_provider(phydev,
+					PHY_EEE_LPI_PROVIDER_MAC);
+}
+EXPORT_SYMBOL_GPL(phy_disable_autonomous_eee);
+
+/**
+ * phy_support_autonomous_eee - hand EEE Tx LPI control to the PHY
+ * @phydev: PHY device to configure
+ *
+ * Apply the current ethtool Tx LPI policy through the PHY driver's autonomous
+ * EEE operation. Phylib continues to resolve EEE negotiation, but no longer
+ * asks the MAC to generate Tx LPI.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int phy_support_autonomous_eee(struct phy_device *phydev)
+{
+	return phy_set_eee_lpi_provider(phydev,
+					PHY_EEE_LPI_PROVIDER_PHY);
+}
+EXPORT_SYMBOL_GPL(phy_support_autonomous_eee);
+
 int phy_init_hw(struct phy_device *phydev)
 {
 	int ret = 0;
@@ -1375,10 +1465,13 @@ int phy_init_hw(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* Re-apply autonomous EEE disable after soft reset */
-	if (phydev->autonomous_eee_disabled &&
-	    phydev->drv->disable_autonomous_eee) {
-		ret = phydev->drv->disable_autonomous_eee(phydev);
+	/* Restore the selected LPI provider after a soft reset. */
+	if (phydev->eee_lpi_provider != PHY_EEE_LPI_PROVIDER_LEGACY) {
+		bool enable = phydev->eee_lpi_provider ==
+			      PHY_EEE_LPI_PROVIDER_PHY &&
+			      phydev->eee_cfg.tx_lpi_enabled;
+
+		ret = phy_configure_autonomous_eee(phydev, enable);
 		if (ret)
 			return ret;
 	}
@@ -2895,9 +2988,7 @@ EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
  * This function configures the initial policy for Energy Efficient Ethernet
  * (EEE) on the specified PHY device, influencing that EEE capabilities are
  * advertised before the link is established. It should be called during PHY
- * registration by the MAC driver and/or the PHY driver (for SmartEEE PHYs)
- * if MAC supports LPI or PHY is capable to compensate missing LPI functionality
- * of the MAC.
+ * registration by a MAC driver which supports LPI generation.
  *
  * The function sets default EEE policy parameters, including preparing the PHY
  * to advertise EEE capabilities based on hardware support.
@@ -2915,18 +3006,15 @@ void phy_support_eee(struct phy_device *phydev)
 	phydev->eee_cfg.tx_lpi_enabled = true;
 	phydev->eee_cfg.eee_enabled = true;
 
-	/* If the PHY supports autonomous EEE, disable it so the MAC can
-	 * manage LPI signaling instead. The flag is stored so it can be
-	 * re-applied after a PHY soft reset (e.g. suspend/resume).
-	 */
-	if (phydev->drv && phydev->drv->disable_autonomous_eee) {
-		int ret = phydev->drv->disable_autonomous_eee(phydev);
+	/* Select the MAC as the LPI provider and disable autonomous EEE. */
+	if (phydev->drv) {
+		int ret;
+
+		ret = phy_disable_autonomous_eee(phydev);
 
 		if (ret)
 			phydev_warn(phydev, "Failed to disable autonomous EEE: %pe\n",
 				    ERR_PTR(ret));
-		else
-			phydev->autonomous_eee_disabled = true;
 	}
 }
 EXPORT_SYMBOL(phy_support_eee);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fc680901275b..76fb5af5a55b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -555,6 +555,22 @@ struct phy_oatc14_sqi_capability {
 	u8 sqiplus_bits;
 };
 
+/**
+ * enum phy_eee_lpi_provider - provider of EEE Tx LPI signalling
+ * @PHY_EEE_LPI_PROVIDER_LEGACY: No provider has been selected explicitly
+ * @PHY_EEE_LPI_PROVIDER_MAC: The MAC generates Tx LPI
+ * @PHY_EEE_LPI_PROVIDER_PHY: The PHY generates Tx LPI autonomously
+ *
+ * The legacy state preserves the behaviour of drivers which predate explicit
+ * provider selection. In that state, phylib continues to report the resolved
+ * Tx LPI state to the MAC through &phy_device.enable_tx_lpi.
+ */
+enum phy_eee_lpi_provider {
+	PHY_EEE_LPI_PROVIDER_LEGACY,
+	PHY_EEE_LPI_PROVIDER_MAC,
+	PHY_EEE_LPI_PROVIDER_PHY,
+};
+
 /**
  * struct phy_device - An instance of a PHY
  *
@@ -612,8 +628,7 @@ struct phy_oatc14_sqi_capability {
  * @advertising_eee: Currently advertised EEE linkmodes
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @eee_active: phylib private state, indicating that EEE has been negotiated
- * @autonomous_eee_disabled: Set when autonomous EEE has been disabled,
- *	used to re-apply after PHY soft reset
+ * @eee_lpi_provider: Provider selected to generate EEE Tx LPI
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
@@ -741,7 +756,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
 	bool enable_tx_lpi;
 	bool eee_active;
-	bool autonomous_eee_disabled;
+	enum phy_eee_lpi_provider eee_lpi_provider;
 	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
@@ -1373,6 +1388,23 @@ struct phy_driver {
 	 */
 	int (*disable_autonomous_eee)(struct phy_device *dev);
 
+	/**
+	 * @set_autonomous_eee: Configure PHY-autonomous EEE
+	 * @dev: PHY device to configure
+	 * @enable: Whether the PHY should generate Tx LPI autonomously
+	 * @tx_lpi_timer: Time in microseconds before entering LPI
+	 *
+	 * The presence of this callback advertises that the driver supports
+	 * using the PHY as the EEE Tx LPI provider. Phylib calls it for ethtool
+	 * Tx LPI configuration only while the PHY is the selected provider. A
+	 * request with @enable false must be accepted regardless of
+	 * @tx_lpi_timer, since the timer has no meaning while Tx LPI is disabled.
+	 *
+	 * Return: 0 on success, negative errno on failure.
+	 */
+	int (*set_autonomous_eee)(struct phy_device *dev, bool enable,
+				  u32 tx_lpi_timer);
+
 	/* Get and Set PHY tunables */
 	/** @get_tunable: Return the value of a tunable */
 	int (*get_tunable)(struct phy_device *dev,
@@ -2392,6 +2424,9 @@ void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_support_eee(struct phy_device *phydev);
+bool phy_has_autonomous_eee(struct phy_device *phydev);
+int phy_disable_autonomous_eee(struct phy_device *phydev);
+int phy_support_autonomous_eee(struct phy_device *phydev);
 void phy_disable_eee(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);

-- 
2.53.0

