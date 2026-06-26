Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290EE3FD941;
	Fri, 26 Jun 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493204; cv=none; b=dXEye+I3fBl/J4KDkSNJSC2PzulBLieJFpGgQ0TMWK6ztF3jkoHiyLngSKPy4H7koWQLxUKAgyRFqZyMm9XvgHKIvfFsiyzUiVN1aPfZ9eyX6PYZh1jV+XcKSFcOr7Vu+wmYNVVD17gLBkx+TAJq6uRaVd3LlawlvfVuXLgHl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493204; c=relaxed/simple;
	bh=LwEyheUgxFn5Zed4Frr86O8UPdktL72d5a/Ce4SWWJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reNCuhA9QZm/kxt2S/vRWt1QzAvBLSSEcKk5xxz+7AcUMWRdag/rxLH1917eFSfYe1Kv3/3uJDuQR3pu6LuwnFL4JrplSoO+a3PycnPcf9T/a8zqXdGdy2MMsPVI0WRyl/Tr6bxX6Oulp2iniPlD7O/EGj+RGh9QFbFlcGyaOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=dV0Tlr1F; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="dV0Tlr1F"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 043D2E8333A;
	Fri, 26 Jun 2026 18:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782493195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYh3Tn1+pF8J/XvTUK0W3BBmsEFu2+bZAgbD8J/ItSA=;
	b=dV0Tlr1FmZKnWXil0e9NP/39BB+SXYN+xDLc/Q4AXqOAV0THlsyIYs6yU+tZoQYU/WLrKs
	mVIcRe2yKeH8GDRJKYd5Alk93yO1K6Q2jhUmYXAdCxiTAD/QHWfgVp9jHn5bXFg44Qi7Vm
	Qm7EDK5R2pyfsS9OJGOYEXEZUr6mp6bMgC0x/TgG5TNCZCcXKvN/2afNCzl1RwLN4BjxBe
	uSLme6eevd/gGL1uleqkkwcaoSiXxZZQ3T0CF8kikrwv/csIBNB/6sE5nuUPhWGCOm5PvF
	aRRmLJ8vcHX0CyqH9hquiFCeG7ZvlJ6yqxd3ZkJxQApYKWJTBApS98sY+lqyNA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id JykR5EFsMD9i; Fri, 26 Jun 2026 18:59:54 +0200 (CEST)
Received: from p14sgen5.lan (p5784dea5.dip0.t-ipconnect.de [87.132.222.165])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri, 26 Jun 2026 18:59:54 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v3 1/3] net: pse-pd: add notifier chain for controller lifecycle events
Date: Fri, 26 Jun 2026 18:59:27 +0200
Message-ID: <20260626165929.2908782-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626165929.2908782-1-github@szelinsky.de>
References: <20260626165929.2908782-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Corey Leavitt <corey@leavitt.info>

Introduce a blocking notifier chain that allows other subsystems to be
informed when a PSE controller is registered or unregistered, and
provide pse_register_notifier() / pse_unregister_notifier() as the
subscriber interface.

Subsequent patches will use this to let the phy subsystem own the
phydev->psec lifecycle directly, decoupling PSE lookup from
fwnode_mdiobus_register_phy() and removing the probe-time
-EPROBE_DEFER coupling that currently exists between mdio, phy and
pse-pd when the PSE controller driver is modular.

A blocking chain (rather than atomic) is used because callbacks will
take rtnl_lock and call back into pse_core via of_pse_control_get().

The enum pse_controller_event is placed outside the
IS_ENABLED(CONFIG_PSE_CONTROLLER) guard so that subscribers compiled
into a kernel without PSE support can still reference the event
values in dead-code paths without breaking the build.

This patch is pure infrastructure: nothing fires events yet, and
nothing subscribes. No observable behavior change.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 69dbdbde9d71..3c4d09f1d6e4 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
@@ -23,6 +24,39 @@ static LIST_HEAD(pse_controller_list);
 static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
 static DEFINE_MUTEX(pse_pw_d_mutex);
 
+static BLOCKING_NOTIFIER_HEAD(pse_controller_notifier);
+
+/**
+ * pse_register_notifier - register a callback for PSE controller events
+ * @nb: notifier block to register
+ *
+ * See enum pse_controller_event for events fired and their subscriber
+ * contract. Callbacks run in process context; they may sleep, take
+ * rtnl, and call of_pse_control_get(). The chain fires synchronously,
+ * so a PSE controller driver's probe/unbind path must not hold any
+ * such lock when calling pse_controller_register() or
+ * pse_controller_unregister().
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int pse_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&pse_controller_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(pse_register_notifier);
+
+/**
+ * pse_unregister_notifier - unregister a previously registered callback
+ * @nb: notifier block previously passed to pse_register_notifier()
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int pse_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&pse_controller_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(pse_unregister_notifier);
+
 /**
  * struct pse_control - a PSE control
  * @pcdev: a pointer to the PSE controller device
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 4e5696cfade7..78fe3a2b1ea8 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -21,6 +21,7 @@ struct net_device;
 struct phy_device;
 struct pse_controller_dev;
 struct netlink_ext_ack;
+struct notifier_block;
 
 /* C33 PSE extended state and substate. */
 struct ethtool_c33_pse_ext_state_info {
@@ -337,6 +338,24 @@ enum pse_budget_eval_strategies {
 	PSE_BUDGET_EVAL_STRAT_DYNAMIC	= 1 << 2,
 };
 
+/**
+ * enum pse_controller_event - PSE controller lifecycle events
+ *
+ * Event data in callbacks is always a pointer to the struct
+ * pse_controller_dev firing the event.
+ *
+ * @PSE_REGISTERED: controller added to pse_controller_list and
+ *	resolvable by of_pse_control_get().
+ * @PSE_UNREGISTERED: controller about to be removed from
+ *	pse_controller_list. Subscribers holding pse_control references
+ *	targeting it must drop them before returning and must not
+ *	acquire new references for it.
+ */
+enum pse_controller_event {
+	PSE_REGISTERED,
+	PSE_UNREGISTERED,
+};
+
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
 int pse_controller_register(struct pse_controller_dev *pcdev);
 void pse_controller_unregister(struct pse_controller_dev *pcdev);
@@ -366,6 +385,9 @@ int pse_ethtool_set_prio(struct pse_control *psec,
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
 
+int pse_register_notifier(struct notifier_block *nb);
+int pse_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node,
@@ -416,6 +438,16 @@ static inline bool pse_has_c33(struct pse_control *psec)
 	return false;
 }
 
+static inline int pse_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int pse_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.43.0

