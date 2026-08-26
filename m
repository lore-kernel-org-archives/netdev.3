Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07862489879;
	Wed, 26 Aug 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781857; cv=none; b=guwEcYmdM4ZFaw+44tbknELuCfq8uSWlMEppgTgvQA3qnG9NukgI16ZgTvkVWdf9uPAtlKtDxGPTsu9rO6kMXSNN+ojcsqIDFiRb60SFuQZ9FKH+hd3qMf6C9hQYKCcEdjXcliEQdW3dgKQIP0t0rPVTSoIDI8Qy1nnnpjOXvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781857; c=relaxed/simple;
	bh=fmqYEd1w1shJojom/r3TIFg6Fg5cwLb7OXfD3qOP6as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij2ebi8pKucFm59WuSOK/IXyjiPVlCOOEphfdP7S+/ddwrGePPbxonEPEdiUt/f0W5wsZHMYpwoAzPYmNhz2wEVskTKK90WpWA/8oeob/8BLznPrL8bWYGUxAlUq8QUCTiYpqGywe1MiHkfLzs2j7LPIPd5nd5sbNOHkLjd4ay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=OT22dEG6; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="OT22dEG6"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D905EE83A7F;
	Thu, 27 Aug 2026 00:04:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1787781850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNJpJjsJ44wSX+LFnIgk6ew4uZj0KRGwsGIYTKtTrS4=;
	b=OT22dEG6us/cYu0Wrbm4L5ETMPsCguHP9Rhl/9H/WauYDgc47zVzRJO2W/2WTDTIniW1JZ
	0Rrb2Ntwx6qSwybTcxblPDWyZc/MecyBiwwglgTJvVseZ2j9zbiVr77D81v2ps+HFl7K2s
	cmpT+GPwxdRYivqidMROkxL55Gyyvic2bGS8LEmH670tIJJCCOGXH17fg8xU6XiDmpjLxR
	/MjXTtxP6BmgYWQat9GYVlaRPT3I/uUwkZU55KnfXITX5U2P05tjBck+KY3eNIaUGb3wl6
	rtuuGFDBwlEvPC5wQ7IRkMcomc3Pz6X9s2KRdL0M7PKLKldBOJQR4aXHQZOjow==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Z15BZuOGgDY2; Thu, 27 Aug 2026 00:04:10 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 27 Aug 2026 00:04:10 +0200 (CEST)
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
Subject: [PATCH net-next v5 4/5] net: phy: use a dedicated mutex instead of rtnl for PSE control attach
Date: Thu, 27 Aug 2026 00:03:43 +0200
Message-ID: <20260826220344.121865-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826220344.121865-1-github@szelinsky.de>
References: <20260826220344.121865-1-github@szelinsky.de>
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

Replace rtnl with a dedicated phy_pse_lock mutex for the attach, for the
notifier attach/detach walks, and for the ethtool PSE paths that
dereference phydev->psec. A private lock cannot recurse against the
caller's rtnl, so the register path no longer deadlocks, while attach vs
notifier and detach vs ethtool stay mutually excluded.

rtnl also kept the ethtool PSE reads from racing the PSE_UNREGISTERED
detach that frees phydev->psec, so net/ethtool/pse-pd.c takes the same
lock across its phydev->psec accesses; guarding only the phy side would
reopen a use-after-free there. The lock order is
phy_pse_lock -> pse_list_mutex -> pcdev->lock, and the notifier walks
enter at phy_pse_lock and never take rtnl.

Reported-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Closes: https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/phy/phy_device.c | 53 +++++++++++++++++++++++++++---------
 include/linux/phy.h          |  2 ++
 net/ethtool/pse-pd.c         | 15 ++++++----
 3 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f5febff4b00b..fa6c3d638b30 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1113,18 +1113,21 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 }
 EXPORT_SYMBOL(get_phy_device);
 
+/* Serialises phydev->psec against the PSE notifier and ethtool, not rtnl. */
+static DEFINE_MUTEX(phy_pse_lock);
+
 /* Best-effort attach of phydev->psec from a DT `pses = <&...>` phandle.
- * Caller must hold rtnl. A missing phandle (-ENOENT) or a not-yet-registered
- * controller (-EPROBE_DEFER) is silent; the notifier retries the latter at
- * PSE_REGISTERED time. Any other error means a broken binding and is warned
- * about, but left non-fatal so the phy still registers.
+ * Caller must hold phy_pse_lock. A missing phandle (-ENOENT) or a
+ * not-yet-registered controller (-EPROBE_DEFER) is silent; the notifier
+ * retries the latter at PSE_REGISTERED time. Any other error means a broken
+ * binding and is warned about, but left non-fatal so the phy still registers.
  */
 static void phy_try_attach_pse(struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	struct device_node *np;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&phy_pse_lock);
 
 	np = phydev->mdio.dev.of_node;
 	if (!np)
@@ -1146,7 +1149,7 @@ static void phy_try_attach_pse(struct phy_device *phydev)
 
 static int phy_pse_attach_one(struct device *dev, void *data __maybe_unused)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&phy_pse_lock);
 
 	if (dev->type != &mdio_bus_phy_type)
 		return 0;
@@ -1161,7 +1164,7 @@ static int phy_pse_detach_one(struct device *dev, void *data)
 	struct phy_device *phydev;
 	struct pse_control *psec;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&phy_pse_lock);
 
 	if (dev->type != &mdio_bus_phy_type)
 		return 0;
@@ -1181,16 +1184,16 @@ static int phy_pse_notifier_event(struct notifier_block *nb,
 {
 	switch (event) {
 	case PSE_REGISTERED:
-		rtnl_lock();
+		mutex_lock(&phy_pse_lock);
 		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
 				 phy_pse_attach_one);
-		rtnl_unlock();
+		mutex_unlock(&phy_pse_lock);
 		return NOTIFY_OK;
 	case PSE_UNREGISTERED:
-		rtnl_lock();
+		mutex_lock(&phy_pse_lock);
 		bus_for_each_dev(&mdio_bus_type, NULL, data,
 				 phy_pse_detach_one);
-		rtnl_unlock();
+		mutex_unlock(&phy_pse_lock);
 		return NOTIFY_OK;
 	default:
 		return NOTIFY_DONE;
@@ -1201,6 +1204,28 @@ static struct notifier_block phy_pse_notifier __read_mostly = {
 	.notifier_call = phy_pse_notifier_event,
 };
 
+/**
+ * phy_pse_control_lock - hold phydev->psec stable against PSE controller teardown
+ *
+ * The PSE_UNREGISTERED notifier detaches phydev->psec and drops its last
+ * reference. Callers that dereference phydev->psec (the ethtool PSE paths) must
+ * hold this lock across the access so the detach cannot run underneath them.
+ */
+void phy_pse_control_lock(void)
+{
+	mutex_lock(&phy_pse_lock);
+}
+EXPORT_SYMBOL_GPL(phy_pse_control_lock);
+
+/**
+ * phy_pse_control_unlock - release the lock taken by phy_pse_control_lock()
+ */
+void phy_pse_control_unlock(void)
+{
+	mutex_unlock(&phy_pse_lock);
+}
+EXPORT_SYMBOL_GPL(phy_pse_control_unlock);
+
 /* Core registration: add the phy to the MDIO bus. Does not touch rtnl or
  * PSE. phydev->psec is attached by the callers below, after device_add()
  * has made the phy visible on mdio_bus_type, so that a concurrent PSE
@@ -1260,7 +1285,9 @@ int phy_device_register_locked(struct phy_device *phydev)
 	if (err)
 		return err;
 
+	mutex_lock(&phy_pse_lock);
 	phy_try_attach_pse(phydev);
+	mutex_unlock(&phy_pse_lock);
 
 	return 0;
 }
@@ -1280,9 +1307,9 @@ int phy_device_register(struct phy_device *phydev)
 	if (err)
 		return err;
 
-	rtnl_lock();
+	mutex_lock(&phy_pse_lock);
 	phy_try_attach_pse(phydev);
-	rtnl_unlock();
+	mutex_unlock(&phy_pse_lock);
 
 	return 0;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 865b9baddb85..55a0049c6c2b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2162,6 +2162,8 @@ int phy_device_register(struct phy_device *phy);
 int phy_device_register_locked(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
 void phy_device_remove(struct phy_device *phydev);
+void phy_pse_control_lock(void);
+void phy_pse_control_unlock(void);
 int phy_get_c45_ids(struct phy_device *phydev);
 int phy_init_hw(struct phy_device *phydev);
 int phy_suspend(struct phy_device *phydev);
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 757c9e0cc856..4edd9a514de1 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -71,7 +71,9 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
+	phy_pse_control_lock();
 	ret = pse_get_pse_attributes(phydev, info->extack, data);
+	phy_pse_control_unlock();
 
 	ethnl_ops_complete(dev);
 
@@ -281,9 +283,12 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
+
+	phy_pse_control_lock();
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
@@ -319,11 +324,11 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 		 */
 		ret = pse_ethtool_set_config(phydev->psec, info->extack,
 					     &config);
-		if (ret)
-			return ret;
 	}
 
+out:
 	/* Return errno or zero - PSE has no notification */
+	phy_pse_control_unlock();
 	return ret;
 }
 
-- 
2.43.0

