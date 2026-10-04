Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC73B9D8B;
	Sun,  4 Oct 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132166; cv=none; b=VkZXVSGS1hIW6DpCSdOWB/OQ3zmGd5TC7I4cO7DHSTSCu3s9K+w+rdU3FoPg8sNE11RgSrQhdSL4brWX/EKoBdPF6yP3dCAuw8EhRdE5zYJysxTh6+Vuw8JAOvfNh3zivA0I9qugTQNM1rzdnPFkV9nPYG/411W7rrzW0hcooDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132166; c=relaxed/simple;
	bh=3jZZAkXcWCiwOnjmH8XZydyfvTJrL9HUlltQ/7SjJV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGyJjhD0obdg6x5r9JygtQDvyps0lzepU9u/nl+uFBAH+wVU9kmjAOB9Z9DUsYuHQYX+hcLB/+qS6dg5sbLkF1LsHb1rB4X3PoL3xcSGbNSHHpIL4j394KZvBjXyOJE6DtrJVrFgbSQAFJ1o9tqfpdTYEOfjaUhUlHBIVDnF4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Knoh1U7f; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Knoh1U7f"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 732C7E83537;
	Sun, 04 Oct 2026 18:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJxvSxZbb27uj2j+6U4OhsU0Uy7nr9jy4MDDMIxjEOI=;
	b=Knoh1U7fhi7wYmBfdvt0YFjnQtbPvsuimJxUj1GqUqSbmuXSikkmjjwm1rweMp68TygdWQ
	viZBVIbEh4yZwxsH7XeRYxoYqn+5TDaNjgoAbnVAX2E4L6LXLWk7y5rKu8rWamcBedq1an
	xOZKrJxsF8Ga2rxIM1HMcL8+SneOaDmnGoMMUGNv5N7P2Z/+pXBpNLEWDK/TgNSfr23gN1
	jtNGFslEEKUJ3B43kcdfoQx06UEq0ieLB+9P8/ytRgVjkJRhVBdJtsfI41PyyeOXEU641l
	E1H0RZRsL5x4+Tyl2kpUcj3mbGiRSByx5j6BBLbt7w4AHyJjtMrQu4vFRHdKCQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id lNIgwhehDX1Y; Sun,  4 Oct 2026 18:42:42 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:41 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v8 1/7] net: pse-pd: add notifier chain for controller lifecycle events
Date: Sun,  4 Oct 2026 18:42:13 +0200
Message-ID: <20261004164219.1161294-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004164219.1161294-1-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
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

A follow-up change uses this to let the phy subsystem own the
phydev->psec lifecycle directly, decoupling PSE lookup from
fwnode_mdiobus_register_phy() and removing the probe-time
-EPROBE_DEFER coupling that currently exists between mdio, phy and
pse-pd when the PSE controller driver is modular.

A blocking chain (rather than atomic) is used because callbacks sleep.
The phy subscriber takes a mutex, and of_pse_control_get() queries the
controller hardware, over i2c or a UART on most drivers. The contract
also lets a subscriber take rtnl, which is why a controller driver must
not hold it across pse_controller_register() or
pse_controller_unregister().

The enum pse_controller_event is placed outside the
IS_ENABLED(CONFIG_PSE_CONTROLLER) guard so that subscribers compiled
into a kernel without PSE support can still reference the event values
in dead-code paths without breaking the build.

This is pure infrastructure: nothing fires events yet, and nothing
subscribes. No observable behavior change.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/pse-pd/pse_core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..84c734ed4553 100644
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
index 4e5696cfade7..bc5d36bcd993 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -21,6 +21,7 @@ struct net_device;
 struct phy_device;
 struct pse_controller_dev;
 struct netlink_ext_ack;
+struct notifier_block;
 
 /* C33 PSE extended state and substate. */
 struct ethtool_c33_pse_ext_state_info {
@@ -337,6 +338,25 @@ enum pse_budget_eval_strategies {
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
+ * @PSE_UNREGISTERED: controller already taken off pse_controller_list, so
+ *	no longer resolvable, but still valid to dereference for the
+ *	duration of the callback. Subscribers holding pse_control
+ *	references targeting it must drop them before returning and must
+ *	not acquire new references for it.
+ */
+enum pse_controller_event {
+	PSE_REGISTERED,
+	PSE_UNREGISTERED,
+};
+
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
 int pse_controller_register(struct pse_controller_dev *pcdev);
 void pse_controller_unregister(struct pse_controller_dev *pcdev);
@@ -366,6 +386,9 @@ int pse_ethtool_set_prio(struct pse_control *psec,
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
 
+int pse_register_notifier(struct notifier_block *nb);
+int pse_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node,
@@ -416,6 +439,16 @@ static inline bool pse_has_c33(struct pse_control *psec)
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

