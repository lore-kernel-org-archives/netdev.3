Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118C154425;
	Sun,  6 Sep 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708712; cv=none; b=FPdAr0IDFaAAcyhWmRFzQhElfNAc/wzuGOTua2CnhfmvPdli/o53A+UdiWGULpccZDXa4VHfk9Hw/2+L3pzx7td4UPVjLVsEYE50lgGyvBrlb6fB1OVg4ruzNenWbDFA5qyq1ekiX/3v62RR4fWf8bXOfeoVGRMCCYM1o8S7tlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708712; c=relaxed/simple;
	bh=CszSWPSVLzEtOEwbz1lpYS1BOquBSLwwkTg/t5tY0EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOqBQyIz55T6cQ02mIpFjL96RPxwUfpjTILOJd0BnT5mLJTA0QEid1uXyDV6++o00SEyNbvDkSEwKhq18RmnsQVhkr4SCIJ2oQevuKHubNemO4ELXv4nHZK/SBx94ZrPAHWqiSyl5sremROi9K5Y4spFfivvhT0zhFEWO/hBoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Ynk0h7My; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Ynk0h7My"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 1E6DFE8394F;
	Sun, 06 Sep 2026 17:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1788708708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kciAGtZEViiiIZi+P6dRGkQUAiiJE7shkwonzXg4Wc=;
	b=Ynk0h7MybEwv1ff0uJL5SmQYFABV2PXrdr3cPVwxe/peeoxc022gngcswbR2KPbFxzhtRm
	+tF0MXd4k/rZCnFnnevAb0vAPSMVCdpYxtNtIUJrauZE/5hoAbPAt+NKZEo4MemfCy591y
	+T+ubpptMyaCOfnu+ZSXm/fqGzVsay2u/cZk6KKvrK84ItvoOsg/KOZuYBHBxA81bcuyfP
	gKzxQeMe8aaBq67CMGUxPh2pkePhmyHRZZRrIQix/iI40Dctlacw5lbJtO99SCibdojWa+
	X3glNbgIzeMpfNfqa6w4uRT6SOjWKVZ81V1+na4sEkeGQmxa7suV7X8d+UX0mw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 64s2A-TXJ-9l; Sun,  6 Sep 2026 17:31:48 +0200 (CEST)
Received: from p14sgen5.lan (p578611d6.dip0.t-ipconnect.de [87.134.17.214])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 06 Sep 2026 17:31:47 +0200 (CEST)
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
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v6 4/5] net: phy: use a dedicated mutex instead of rtnl for PSE control attach
Date: Sun,  6 Sep 2026 17:31:01 +0200
Message-ID: <20260906153102.959217-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906153102.959217-1-github@szelinsky.de>
References: <20260906153102.959217-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_device_register() took rtnl_lock() around phy_try_attach_pse() to
serialise phydev->psec against the PSE controller notifier walk. But an
MDIO bus registered from ndo_init() runs with rtnl already held:

  register_netdevice()			# holds rtnl
    ndo_init() == ltq_etop_init()
      ltq_etop_mdio_init()
        mdiobus_register()
          mdiobus_scan()
            phy_device_register()
              rtnl_lock()		# deadlock

so any such driver (lantiq_etop, sni_ave, netsec) deadlocks on probe.

Replace rtnl with a dedicated mutex for the attach, for the notifier
attach/detach walks, and for the ethtool PSE paths that dereference
phydev->psec. A private lock cannot recurse against the caller's rtnl, so
the register path no longer deadlocks, while attach vs notifier and
detach vs ethtool stay mutually excluded.

The mutex lives in pse_core, not phylib, and is reached through
pse_phy_lock() / pse_phy_unlock(). net/ethtool/pse-pd.c is built into
vmlinux unconditionally while PHYLIB is tristate, so ethtool cannot call
a phylib export: with CONFIG_PHYLIB=m or =n the link fails. PSE_CONTROLLER
is bool, so pse_core is always in vmlinux (or absent, with no-op stubs
for !PSE_CONTROLLER), and both built-in and modular callers reach the
lock. It does not protect a phylib field but the phy<->controller binding
against PSE controller teardown, and it sits directly above
pse_list_mutex, which pse_core already owns.

rtnl also kept the ethtool PSE reads from racing the PSE_UNREGISTERED
detach that frees phydev->psec, so net/ethtool/pse-pd.c takes the same
lock across its phydev->psec accesses; guarding only the phy side would
reopen a use-after-free there. The lock order is
rtnl -> pse_phy_mutex -> pse_list_mutex -> pcdev->lock, and the notifier
walks enter at pse_phy_lock() and never take rtnl.

Because the attach no longer takes rtnl, phy_device_register() and the
phy_device_register_locked() variant that was added for the rtnl-holding
sfp caller became identical, so fold them back into phy_device_register().

Reported-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Closes: https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/phy/phy_device.c  | 94 +++++++++++------------------------
 drivers/net/phy/sfp.c         |  2 +-
 drivers/net/pse-pd/pse_core.c | 46 +++++++++++++++++
 include/linux/phy.h           |  2 -
 include/linux/pse-pd/pse.h    | 23 +++++++++
 net/ethtool/pse-pd.c          | 16 ++++--
 6 files changed, 111 insertions(+), 72 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f5febff4b00b..e8d894bbfa7a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1114,17 +1114,17 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 EXPORT_SYMBOL(get_phy_device);
 
 /* Best-effort attach of phydev->psec from a DT `pses = <&...>` phandle.
- * Caller must hold rtnl. A missing phandle (-ENOENT) or a not-yet-registered
- * controller (-EPROBE_DEFER) is silent; the notifier retries the latter at
- * PSE_REGISTERED time. Any other error means a broken binding and is warned
- * about, but left non-fatal so the phy still registers.
+ * Caller must hold pse_phy_lock(). A missing phandle (-ENOENT) or a
+ * not-yet-registered controller (-EPROBE_DEFER) is silent; the notifier
+ * retries the latter at PSE_REGISTERED time. Any other error means a broken
+ * binding and is warned about, but left non-fatal so the phy still registers.
  */
 static void phy_try_attach_pse(struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	struct device_node *np;
 
-	ASSERT_RTNL();
+	pse_phy_lock_assert_held();
 
 	np = phydev->mdio.dev.of_node;
 	if (!np)
@@ -1146,7 +1146,7 @@ static void phy_try_attach_pse(struct phy_device *phydev)
 
 static int phy_pse_attach_one(struct device *dev, void *data __maybe_unused)
 {
-	ASSERT_RTNL();
+	pse_phy_lock_assert_held();
 
 	if (dev->type != &mdio_bus_phy_type)
 		return 0;
@@ -1161,7 +1161,7 @@ static int phy_pse_detach_one(struct device *dev, void *data)
 	struct phy_device *phydev;
 	struct pse_control *psec;
 
-	ASSERT_RTNL();
+	pse_phy_lock_assert_held();
 
 	if (dev->type != &mdio_bus_phy_type)
 		return 0;
@@ -1181,16 +1181,16 @@ static int phy_pse_notifier_event(struct notifier_block *nb,
 {
 	switch (event) {
 	case PSE_REGISTERED:
-		rtnl_lock();
+		pse_phy_lock();
 		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
 				 phy_pse_attach_one);
-		rtnl_unlock();
+		pse_phy_unlock();
 		return NOTIFY_OK;
 	case PSE_UNREGISTERED:
-		rtnl_lock();
+		pse_phy_lock();
 		bus_for_each_dev(&mdio_bus_type, NULL, data,
 				 phy_pse_detach_one);
-		rtnl_unlock();
+		pse_phy_unlock();
 		return NOTIFY_OK;
 	default:
 		return NOTIFY_DONE;
@@ -1201,15 +1201,22 @@ static struct notifier_block phy_pse_notifier __read_mostly = {
 	.notifier_call = phy_pse_notifier_event,
 };
 
-/* Core registration: add the phy to the MDIO bus. Does not touch rtnl or
- * PSE. phydev->psec is attached by the callers below, after device_add()
- * has made the phy visible on mdio_bus_type, so that a concurrent PSE
- * notifier walk and the attach can never leave the phy unattached. Keeping
- * device_add() out of rtnl also avoids deadlocking when binding a phy that
- * itself provides an SFP cage (phy_probe() -> phy_sfp_probe() ->
- * sfp_bus_add_upstream() takes rtnl).
+/**
+ * phy_device_register - Register the phy device on the MDIO bus
+ * @phydev: phy_device structure to be added to the MDIO bus
+ *
+ * phydev->psec is attached after device_add() has made the phy visible on
+ * mdio_bus_type, so that a concurrent PSE notifier walk and the attach can
+ * never leave the phy unattached. Neither step takes rtnl: keeping
+ * device_add() out of rtnl avoids deadlocking when binding a phy that itself
+ * provides an SFP cage (phy_probe() -> phy_sfp_probe() ->
+ * sfp_bus_add_upstream() takes rtnl), and pse_phy_lock() rather than rtnl
+ * guards the attach so a bus registered from ndo_init (which already holds
+ * rtnl) does not recurse on it.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
-static int __phy_device_register(struct phy_device *phydev)
+int phy_device_register(struct phy_device *phydev)
 {
 	int err;
 
@@ -1233,6 +1240,10 @@ static int __phy_device_register(struct phy_device *phydev)
 		goto out;
 	}
 
+	pse_phy_lock();
+	phy_try_attach_pse(phydev);
+	pse_phy_unlock();
+
 	return 0;
 
  out:
@@ -1241,51 +1252,6 @@ static int __phy_device_register(struct phy_device *phydev)
 	mdiobus_unregister_device(&phydev->mdio);
 	return err;
 }
-
-/**
- * phy_device_register_locked - Register the phy device on the MDIO bus
- * @phydev: phy_device structure to be added to the MDIO bus
- *
- * Same as phy_device_register() but caller must already hold rtnl_lock().
- *
- * Return: 0 on success, negative error code on failure.
- */
-int phy_device_register_locked(struct phy_device *phydev)
-{
-	int err;
-
-	ASSERT_RTNL();
-
-	err = __phy_device_register(phydev);
-	if (err)
-		return err;
-
-	phy_try_attach_pse(phydev);
-
-	return 0;
-}
-EXPORT_SYMBOL(phy_device_register_locked);
-
-/**
- * phy_device_register - Register the phy device on the MDIO bus
- * @phydev: phy_device structure to be added to the MDIO bus
- *
- * Return: 0 on success, negative error code on failure.
- */
-int phy_device_register(struct phy_device *phydev)
-{
-	int err;
-
-	err = __phy_device_register(phydev);
-	if (err)
-		return err;
-
-	rtnl_lock();
-	phy_try_attach_pse(phydev);
-	rtnl_unlock();
-
-	return 0;
-}
 EXPORT_SYMBOL(phy_device_register);
 
 /**
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 18868bdd6485..03bfd8640db9 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2083,7 +2083,7 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
 	/* Mark this PHY as being on a SFP module */
 	phy->is_on_sfp_module = true;
 
-	err = phy_device_register_locked(phy);
+	err = phy_device_register(phy);
 	if (err) {
 		phy_device_free(phy);
 		dev_err(sfp->dev, "phy_device_register failed: %pe\n",
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 611540df43bb..b771f5a2a83f 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -24,8 +24,54 @@ static LIST_HEAD(pse_controller_list);
 static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
 static DEFINE_MUTEX(pse_pw_d_mutex);
 
+/* Serialises phydev->psec against the PSE controller lifecycle notifier and
+ * the ethtool PSE paths, in place of rtnl. The attach must not take rtnl: an
+ * MDIO bus registered from ndo_init (e.g. lantiq_etop) calls
+ * phy_device_register() with rtnl already held, so taking rtnl for the attach
+ * would deadlock. It lives here rather than in phylib because PSE_CONTROLLER
+ * is bool, so pse_core is always built into vmlinux and net/ethtool can call
+ * these directly; phylib is tristate and must not be linked against from
+ * built-in code. Lock order: rtnl -> pse_phy_mutex -> pse_list_mutex ->
+ * pcdev->lock.
+ */
+static DEFINE_MUTEX(pse_phy_mutex);
+
 static BLOCKING_NOTIFIER_HEAD(pse_controller_notifier);
 
+/**
+ * pse_phy_lock - hold phydev->psec stable against PSE controller teardown
+ *
+ * The PSE_UNREGISTERED notifier clears phydev->psec and drops the last
+ * reference on the pse_control before the controller frees its state. Callers
+ * that attach, detach or dereference phydev->psec must hold this lock across
+ * the whole access so the detach cannot run underneath them.
+ */
+void pse_phy_lock(void)
+{
+	mutex_lock(&pse_phy_mutex);
+}
+EXPORT_SYMBOL_GPL(pse_phy_lock);
+
+/**
+ * pse_phy_unlock - release the lock taken by pse_phy_lock()
+ */
+void pse_phy_unlock(void)
+{
+	mutex_unlock(&pse_phy_mutex);
+}
+EXPORT_SYMBOL_GPL(pse_phy_unlock);
+
+#ifdef CONFIG_LOCKDEP
+/**
+ * pse_phy_lock_assert_held - assert that pse_phy_lock() is held
+ */
+void pse_phy_lock_assert_held(void)
+{
+	lockdep_assert_held(&pse_phy_mutex);
+}
+EXPORT_SYMBOL_GPL(pse_phy_lock_assert_held);
+#endif
+
 /**
  * pse_register_notifier - register a callback for PSE controller events
  * @nb: notifier block to register
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 865b9baddb85..199a7aaa341b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2158,8 +2158,6 @@ struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
 struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
 int phy_device_register(struct phy_device *phy);
-/* Caller must hold rtnl_lock(); see phy_device_register() for the public form. */
-int phy_device_register_locked(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
 void phy_device_remove(struct phy_device *phydev);
 int phy_get_c45_ids(struct phy_device *phydev);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index d4310ca71a3e..8c10613d9c51 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -391,6 +391,17 @@ bool pse_control_matches_pcdev(struct pse_control *psec,
 int pse_register_notifier(struct notifier_block *nb);
 int pse_unregister_notifier(struct notifier_block *nb);
 
+void pse_phy_lock(void);
+void pse_phy_unlock(void);
+
+#ifdef CONFIG_LOCKDEP
+void pse_phy_lock_assert_held(void);
+#else
+static inline void pse_phy_lock_assert_held(void)
+{
+}
+#endif
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node,
@@ -457,6 +468,18 @@ static inline int pse_unregister_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void pse_phy_lock(void)
+{
+}
+
+static inline void pse_phy_unlock(void)
+{
+}
+
+static inline void pse_phy_lock_assert_held(void)
+{
+}
+
 #endif
 
 #endif
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 757c9e0cc856..654325946aaa 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -71,7 +71,9 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
+	pse_phy_lock();
 	ret = pse_get_pse_attributes(phydev, info->extack, data);
+	pse_phy_unlock();
 
 	ethnl_ops_complete(dev);
 
@@ -281,9 +283,12 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
+
+	pse_phy_lock();
+
 	ret = ethnl_set_pse_validate(phydev, info);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (tb[ETHTOOL_A_PSE_PRIO]) {
 		unsigned int prio;
@@ -291,7 +296,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		prio = nla_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
 		ret = pse_ethtool_set_prio(phydev->psec, info->extack, prio);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
@@ -301,7 +306,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		ret = pse_ethtool_set_pw_limit(phydev->psec, info->extack,
 					       pw_limit);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* These values are already validated by the ethnl_pse_set_policy */
@@ -319,10 +324,11 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		 */
 		ret = pse_ethtool_set_config(phydev->psec, info->extack,
 					     &config);
-		if (ret)
-			return ret;
 	}
 
+out:
+	pse_phy_unlock();
+
 	/* Return errno or zero - PSE has no notification */
 	return ret;
 }
-- 
2.43.0

