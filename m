Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F72378D88
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981174; cv=none; b=IREUE2KgrYKGtwSBUxwZB/MhvRXFmH3SDEfzYSY6dAJNEMujahTjr8dh+CUSAGkcdmaKtKF05KXyQtwbYHHzIMrIVAeSdneztD81iy2Dh4ccM7T+eI7Q2f/Y8XEzcWitFUFgqJ1A55QBb3RWTo7TGg6oa41K7CyDUD5bpe8RP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981174; c=relaxed/simple;
	bh=Nn4d0wHJqZTPdzNfFzD2yqGS9Q0cS3NqhyFR6MO2xBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxsqBdW26HeoymHNXoDji6MAk2XPKsViXOOtBSrBzI7eqYGxeT9WrlH9NwlwN21x1r5g6J0PNB8m+qotQ0it+R0Z0oYx3kLoXg5lkTGTFak9U9arL+OAwyVH+TU3l3Ikb0A9YaNvnFVmPW43OlUWOd31wCYZANSneJ9PkbPH0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=JDJvzlCC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="JDJvzlCC"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c169ae1cb26so567151966b.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787981167; x=1788585967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BexHGXJfmWG9wttaxQjMKssISHmEBGNX9tS0o3mB1bs=;
        b=JDJvzlCCHzaweqCApEYNm3u9o6oXLSw7fbD4X4d00U4rX4h3XZau7IwhOEE6wQ/oZG
         OXFNGh9z3h4jKdSUcXCjtlrGiLTysDOpkczZLoxFW2RhZ0UgYcJZ1X0KjlkumU9E3jbJ
         p1s6Red65YAyg3ps5DDucymlNsAX6gUVI0w9vBVWSshGvvYkAy3dtb6+6VNpkmbteuiy
         i4d0TVSvVtQjlCqBqbZq8AUO5Ubw9+GoxTURWqZWdmpDlDrfR1l/QUvYXtzNLXk0EnYc
         0ZV51JuU0bEvT4mV+9/1RMKVr1iH4b4dhmk8dBtBsmSpFYvlchVVERxUywt4opbrhsSF
         3VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787981167; x=1788585967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BexHGXJfmWG9wttaxQjMKssISHmEBGNX9tS0o3mB1bs=;
        b=TdN4rA+1SAOPBOI28x2FLASZ7mfkFI8Mw57bCTiJE4OI/PWUpahLBjGN5kg+ColsHT
         Q8pWSckgvJPAIfFslDoyJa8EVzDnjC03kcPHgG/wHtECCkWnStx25V42tdKT5DSva/QA
         WfonyeRB1f3qrCh/+bp+E8qon0AWbBm1o2TEPHPaUPb4qeSaSb3XhjhzAjHShkvlOIjC
         nVGqO0KNylbNDDuXK5mwR5CLNXa1/US0qYPxTsxV9sFhSS6R+b7Twr39hthsTz/GNi00
         4PKsDQ9WEiWnAXI6+sWq7Pqc/hbqulbNk9r5GNegHsJSyvLBX01KzCXO6BqoFkFYQYp/
         WhYw==
X-Gm-Message-State: AFuF++miDNbE5m8YSveQbw7T53RCUbhLMz+8J25SI1s6bQNN96MEjPCU
	zTCzJcyn8ACwopDJGfUeDTFxbSP7Gr2wvHtBXzfmIXqJH7mPA7Vb5H/QJpmGUPXpFgkvze7gKRi
	xWgRUKTC7gw==
X-Gm-Gg: AYBFou24Yav32N/STz2ZBesCAqgwrUD8iHOFxjuxO+ubfRtbh4IwNOrdKq8Ed5+BFCl
	kTFLPYTx+OarrE26qhqMnriCPQelszOGMH3RviJdr6MW2Sj+UGspvfA58I0mIeiUhI8wvualjxP
	ZxWAdBRZlwD4eFb6c4HfkeY3vQBZ6lmE4QSU6FPQQOKnnLrPdT67+1H5IeSRY23XBfUOkgu3ncr
	CZ8Rcxt4WGPDyOiy4wRScmM5zxkN/hE9KE01cyHPWx0TedbcwdgXi3YLvS7Dkw8/tqL4PR0tMP8
	pv0I8kLToQgHhhTSgrpVgLPr0bFOPxUAsoBiKtbWPSWp8pDXfwMVcuHKawvTXDfAo0VCZUEU/hD
	4hMZiyncFDsS0kAbiQk0UnGJsiFGMmKKHqi+BhHd7DoR3KC69/mERWn8MFdlQXFybYpHEstn1zj
	HZufETQ5y7ZV4ZTWsUWOWMM2psCKUGq+2MBZAiSSGDmQ==
X-Received: by 2002:a17:907:1b0e:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c2535eab9b1mr1470544266b.2.1787981167088;
        Fri, 28 Aug 2026 22:26:07 -0700 (PDT)
Received: from remote-01 ([45.85.105.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee75a36sm163750666b.28.2026.08.28.22.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 22:26:06 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next 8/9] net: phylink: wait for PHYs that are known to probe late
Date: Sat, 29 Aug 2026 05:25:45 +0000
Message-ID: <20260829052546.1152446-9-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829052546.1152446-1-f@lex.la>
References: <20260829052546.1152446-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose driver or firmware lives on a filesystem mounted after the
MAC probes cannot be connected when the port is set up, and the port is
lost for the rest of the uptime. Let a port say so with slow-to-probe,
and poll for the PHY instead of failing.

Returning 0 rather than -ENODEV matters beyond the error itself: DSA
reads -ENODEV as permission to go looking for the PHY on the switch's
internal MDIO bus, which is the wrong device.

Wait for a PHY whose own driver has finished probing, not merely for one
that exists. A PHY can be registered long before its driver is, because
the driver arrives when userspace gets around to loading it; connecting
in between would bind the generic driver, which cannot drive such a PHY
and leaves it worse off than not connecting at all.
phylink_sfp_connect_phy() already refuses a PHY with no driver for the
same reason. Binding alone is not enough either: phy_probe() publishes
phydev->drv before it calls the driver's probe, so a PHY caught inside
that window is validated against a supported mask that is still empty.
Note that this makes slow-to-probe a request for a specific driver: a
PHY meant to run on the generic driver must not sit behind the property,
because the wait would then never end.

A PHY arriving this late has missed phylink_start(), which starts the PHY
it finds already attached, so start it here when the port is up.

Keep polling after a failed connect, because the errno does not say
whether the failure is permanent: phylink_validate_phy() returns -EINVAL
both for a PHY that cannot speak the port's interface and for one whose
link modes are not in place yet, and only the PHY's driver binding again
changes that answer. Giving up would lose the port for good. Back the
interval off and report the first failure only, since a retry that
reaches bringup detaches the PHY again and phy_detach() asserts its
reset line.

The poller runs from a workqueue and needs rtnl, while
phylink_disconnect_phy() cancels it with rtnl already held, so it takes
rtnl with trylock and requeues on failure. For the same reason the
synchronous cancel belongs in phylink_destroy(), which documents that
rtnl must not be held.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phylink.c | 202 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 196 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5b8e956902fb..eda7b61ba5d1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -73,6 +73,24 @@ struct phylink {
 	struct phylink_link_state phy_state;
 	unsigned int phy_ib_mode;
 	struct work_struct resolve;
+	/* Set while waiting for a PHY that is expected to probe late.
+	 * Written and read under rtnl only: phylink_disconnect_phy() puts
+	 * and clears it there, which is what makes the poller's dereference
+	 * safe.
+	 */
+	struct fwnode_handle *slow_phy_fwnode;
+	u32 slow_phy_flags;
+	struct delayed_work slow_phy_poll;
+	/* Interval before the next poll. Set when the poller is armed and
+	 * thereafter owned by it, since a delayed work never runs twice at
+	 * once.
+	 */
+	unsigned int slow_phy_poll_ms;
+	unsigned int slow_phy_waited_ms;
+	/* Written under rtnl, read unlocked by the poller; a stale read only
+	 * costs an extra poll cycle.
+	 */
+	bool slow_phy_stop;
 	unsigned int pcs_neg_mode;
 	unsigned int pcs_state;
 
@@ -1829,6 +1847,8 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static void phylink_slow_phy_poll(struct work_struct *work);
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
@@ -1867,6 +1887,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_DELAYED_WORK(&pl->slow_phy_poll, phylink_slow_phy_poll);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -1950,6 +1971,10 @@ void phylink_destroy(struct phylink *pl)
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	WRITE_ONCE(pl->slow_phy_stop, true);
+	cancel_delayed_work_sync(&pl->slow_phy_poll);
+	fwnode_handle_put(pl->slow_phy_fwnode);
+
 	cancel_work_sync(&pl->resolve);
 	kfree(pl);
 }
@@ -2201,10 +2226,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-			      phy_interface_t interface)
+			      phy_interface_t interface, u32 flags)
 {
-	u32 flags = 0;
-
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
@@ -2242,7 +2265,7 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 		pl->link_config.interface = pl->link_interface;
 	}
 
-	ret = phylink_attach_phy(pl, phy, pl->link_interface);
+	ret = phylink_attach_phy(pl, phy, pl->link_interface, 0);
 	if (ret < 0)
 		return ret;
 
@@ -2254,6 +2277,129 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 }
 EXPORT_SYMBOL_GPL(phylink_connect_phy);
 
+/* How often to re-check whether a late-probing PHY has turned up. */
+#define PHYLINK_SLOW_PHY_POLL_MS	1000
+#define PHYLINK_SLOW_PHY_WARN_MS	60000
+
+/* Ceiling that interval backs off to once a connect attempt has failed. */
+#define PHYLINK_SLOW_PHY_POLL_MAX_MS	30000
+
+/* A phy-handle has resolved only once it names a device with its own driver
+ * bound. A device that is absent, or present with the generic driver bound to
+ * it, is equally unusable: this is the state slow-to-probe waits out, and both
+ * the arming site and the poller must agree on it.
+ *
+ * Bound is not probed. phy_probe() assigns phydev->drv before it calls the
+ * driver's own probe(), and only fills phydev->supported from get_features()
+ * once that has returned; a device connected in between is validated against
+ * an empty link-mode mask. PHY_DOWN is the documented state of a device whose
+ * probe has not completed, and phy_probe() leaves it in PHY_READY.
+ */
+static bool phylink_phy_is_usable(struct phy_device *phy_dev)
+{
+	return phy_dev && phy_dev->drv && phy_dev->state != PHY_DOWN &&
+	       !phy_driver_is_genphy(phy_dev);
+}
+
+static void phylink_slow_phy_poll(struct work_struct *work)
+{
+	struct phylink *pl = container_of(to_delayed_work(work), struct phylink,
+					  slow_phy_poll);
+	struct phy_device *phy_dev;
+	int ret;
+
+	if (READ_ONCE(pl->slow_phy_stop))
+		return;
+
+	/* phylink_disconnect_phy() cancels this work while holding rtnl, so
+	 * blocking on rtnl here would deadlock against it. Requeue instead and
+	 * let the canceller finish.
+	 */
+	if (!rtnl_trylock())
+		goto requeue;
+
+	if (READ_ONCE(pl->slow_phy_stop)) {
+		rtnl_unlock();
+		return;
+	}
+
+	/* Do not "optimize" the lookup out from under rtnl: rtnl is what
+	 * makes phylink_disconnect_phy()'s put-and-clear of slow_phy_fwnode
+	 * safe against this dereference. The uncontended trylock above is
+	 * cheaper than the use-after-free.
+	 */
+	phy_dev = fwnode_phy_find_device(pl->slow_phy_fwnode);
+	if (!phylink_phy_is_usable(phy_dev)) {
+		if (phy_dev)
+			phy_device_free(phy_dev);
+
+		/* A PHY that never turns up would otherwise wait in complete
+		 * silence: one breadcrumb after a minute, like the connect
+		 * failure below gets, and like a missing firmware file gets
+		 * from the MDIO side.
+		 */
+		pl->slow_phy_waited_ms += pl->slow_phy_poll_ms;
+		if (pl->slow_phy_waited_ms >= PHYLINK_SLOW_PHY_WARN_MS &&
+		    pl->slow_phy_waited_ms - pl->slow_phy_poll_ms <
+		    PHYLINK_SLOW_PHY_WARN_MS)
+			phylink_warn(pl,
+				     "still waiting for the slow-to-probe PHY (%pfw)\n",
+				     pl->slow_phy_fwnode);
+		rtnl_unlock();
+		goto requeue;
+	}
+
+	if (pl->link_interface == PHY_INTERFACE_MODE_NA) {
+		pl->link_interface = phy_dev->interface;
+		pl->link_config.interface = pl->link_interface;
+	}
+
+	ret = phylink_attach_phy(pl, phy_dev, pl->link_interface,
+				 pl->slow_phy_flags);
+	phy_device_free(phy_dev);
+	if (!ret) {
+		ret = phylink_bringup_phy(pl, phy_dev,
+					  pl->link_config.interface);
+		if (ret)
+			phy_detach(phy_dev);
+		else if (!test_bit(PHYLINK_DISABLE_STOPPED,
+				   &pl->phylink_disable_state))
+			/* phylink_start() starts the PHY it finds attached,
+			 * and ran long before this one turned up.
+			 */
+			phy_start(phy_dev);
+	}
+	if (ret) {
+		/* Whether this is permanent cannot be read off the errno: the
+		 * same -EINVAL comes out of phylink_validate_phy() for a PHY
+		 * that is still filling in its link modes and for one that
+		 * genuinely cannot speak this interface. What decides it is
+		 * the PHY's supported mask, and only the driver binding again
+		 * changes that, so keep polling - giving up here loses the
+		 * port for the lifetime of this phylink. Back off instead: a
+		 * failed bringup ends in phy_detach(), which asserts the PHY's
+		 * reset line. Report the first failure only, so a PHY that
+		 * will never fit costs one line rather than a stream of them.
+		 */
+		if (pl->slow_phy_poll_ms == PHYLINK_SLOW_PHY_POLL_MS)
+			phylink_err(pl, "failed to connect late PHY: %pe\n",
+				    ERR_PTR(ret));
+
+		WRITE_ONCE(pl->slow_phy_poll_ms,
+			   min_t(unsigned int, pl->slow_phy_poll_ms * 2,
+				 PHYLINK_SLOW_PHY_POLL_MAX_MS));
+	}
+	rtnl_unlock();
+
+	if (!ret)
+		return;
+
+requeue:
+	queue_delayed_work(system_freezable_power_efficient_wq,
+			   &pl->slow_phy_poll,
+			   msecs_to_jiffies(READ_ONCE(pl->slow_phy_poll_ms)));
+}
+
 /**
  * phylink_of_phy_connect() - connect the PHY specified in the DT mode.
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2282,7 +2428,13 @@ EXPORT_SYMBOL_GPL(phylink_of_phy_connect);
  * Connect the phy specified @fwnode to the phylink instance specified
  * by @pl.
  *
- * Returns 0 on success or a negative errno.
+ * If the port node carries the slow-to-probe property and the PHY is not
+ * usable yet, 0 is returned with no PHY connected: a poller connects it
+ * once its driver has probed. Until then the MAC runs without a PHY and
+ * ethtool reports no link modes.
+ *
+ * Returns 0 on success - the PHY connected, or the deferred connect
+ * armed - or a negative errno.
  */
 int phylink_fwnode_phy_connect(struct phylink *pl,
 			       const struct fwnode_handle *fwnode,
@@ -2304,6 +2456,32 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	}
 
 	phy_dev = fwnode_phy_find_device(phy_fwnode);
+	if (!phylink_phy_is_usable(phy_dev) &&
+	    fwnode_property_present(fwnode, "slow-to-probe")) {
+		/* The PHY is known to appear late, so keep the node and poll
+		 * for it rather than failing the port for good. Returning an
+		 * error here would also send DSA off to look for the PHY on
+		 * the switch's own MDIO bus.
+		 */
+		if (phy_dev)
+			phy_device_free(phy_dev);
+
+		pl->slow_phy_fwnode = phy_fwnode;
+		pl->slow_phy_flags = flags;
+		WRITE_ONCE(pl->slow_phy_poll_ms, PHYLINK_SLOW_PHY_POLL_MS);
+		pl->slow_phy_waited_ms = 0;
+		WRITE_ONCE(pl->slow_phy_stop, false);
+		/* mod_ rather than queue_: a poll that a disconnect cancelled
+		 * mid-backoff may still be pending with seconds left on it.
+		 */
+		/* Freezable: attaching and starting a PHY has no place in
+		 * the middle of a system suspend transition.
+		 */
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				 &pl->slow_phy_poll, 0);
+		return 0;
+	}
+
 	/* We're done with the phy_node handle */
 	fwnode_handle_put(phy_fwnode);
 	if (!phy_dev)
@@ -2345,6 +2523,18 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	/* Cannot cancel synchronously: the poller takes rtnl, which is held. */
+	WRITE_ONCE(pl->slow_phy_stop, true);
+	cancel_delayed_work(&pl->slow_phy_poll);
+	/* The next connect re-arms from its own fwnode lookup; holding on to
+	 * this one would leak a reference per connect cycle and keep the
+	 * pending state - and its empty-ksettings window - alive on an
+	 * interface whose PHY is long since usable. The poller cannot race
+	 * this: it reads the node only under rtnl, after the stop check.
+	 */
+	fwnode_handle_put(pl->slow_phy_fwnode);
+	pl->slow_phy_fwnode = NULL;
+
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
 	if (phy) {
@@ -3730,7 +3920,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	/* Attach the PHY so that the PHY is present when we do the major
 	 * configuration step.
 	 */
-	ret = phylink_attach_phy(pl, phy, config.interface);
+	ret = phylink_attach_phy(pl, phy, config.interface, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

