Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FC572682
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883060; cv=none; b=gkppQW3D2NwnmnykVDGi6E0gkRxKG44GBPYkryd9Ach3oiKQ0HJezkxsr18EueC0JAqhq+8zoT9wTqayxVlo+w2pH/shPeLfGvg0BbiJ9l9xyOj+H5Dn51oifdGw1XlmQB33vmM/0Re7XIS89QSHPtt2xYBMS+8ywA9lKVRZ5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883060; c=relaxed/simple;
	bh=RichJAb3WUIXvHmkckzegxBh9c+qsyloSrT5sVgqtYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk1DmUmSMueWCH/MKhzbaZQo7OpoNbSpOo/fvEkOpixmOEC6msdhqac+RaGIf43J2mRcbFbx9/7/DZ/hxdF5wjhOWFKtahJ/WhtwVi4mztgGjJMr2b8vv8RXTn3jowkR9m73HqtNig/31p/cqGhyD7otl3vmd/PfNxnd/6JCe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Q2StC/yO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Q2StC/yO"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482dbe4d247so2671362f8f.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883054; x=1789487854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgFh9Cc2TQQLTwmVJEQQxCEyfMY2XV4D1NQ7tPACFGU=;
        b=Q2StC/yO1kKmgE8cN2MyLVeU1va6dRJapVE18yA2Epk4zoh3tbodgX0FE7Rtfgk726
         IjjB+K9pMc0rngUEIeC1FIzdqB8BrTELImJ7nfTO+axahsOJz/gktuVCfKBJwWDLz5vC
         1ly8Yh/3FQvGzHS8VCGNalXDQ6iTNXINMhFHi1V3XMVPIYsdvjFzLbvjQQZZpyBPXbYe
         OipvPtjy/HtLUeI2dAyozw/wKStNYxr1edVM7JjmfDsoSx5vMV05SK6tQYb+ZajeajjT
         hpdDv0LhUb7QPkAU8/RegE2u16VUJE9OGYgXnfSaglAMIZ4jF80WMnXw8guWDCSyzKtt
         +4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883054; x=1789487854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgFh9Cc2TQQLTwmVJEQQxCEyfMY2XV4D1NQ7tPACFGU=;
        b=d3kfimpxdPrVe6liJVR+418ei5tcJ6p6y7Ytu9Qzgazha9U9WoBZGGIRAkAxJXdDof
         SKQX7AjN7cmLnUlEHsXyZwdJk3PMxc7EgyLdmSGSWcgfprNYxLQfSMRrtnsIMY6AHhP+
         gnxP9Eq8Lxgt3MVcxk4JDtYH82t+JPmiR94wZwpU2OxIazWkRD6txWLMXCE9vZaPy5E9
         lZvyJuBUeLguHe8mq64y8z0UlHFPxdLl7mqzIcL6gP16T30b+S27odJkFStXZgeGz941
         4csH+LlfIaPVl48LqkzqsgwdXYwBrsDEm4SSPmiETgnEVEQ/JWMjYq1yokFG7y8lnIyI
         FVtA==
X-Forwarded-Encrypted: i=1; AKwUvBwaHNbAszQErArb6/kesM5WVLjVtKb/C5E6oGmW1JqK5t7xclaDyCpi1I0tN8JWN6JVRxlm6cM=@vger.kernel.org
X-Gm-Message-State: AFuF++kpoPI6tpwf3/uXlteJV5kYjYUhJvaLpKFoqqf95celtbCUgx/7
	/BtbAOfbBJNLb5RXuHfl5yWXLjaXziNPsRCxFiopxkq5oCL/MY4eaM12UQWwXIMFORs=
X-Gm-Gg: AYBFou2TMuwl3U1FRtPOQ/y9Iif17Klee3uyA3uyI/tUMcTwI/UXZzY3L6HwBEAVk+f
	Y2ADN+o1eeEvtdVGxqeVZAlk6KiV7DwoKFjdyat4cKVb/xfJBcKy+Pw3ta8KlPDkXwg3Tv8sPpv
	o6IuCCSsggDd9oaXq7uenDBQIX6EJn5R+KnyRaVIVXw7YSTmhATsqKlx37NGPubsfn7Lenf/J8t
	3aW96XfPipSRt4uPv7EZdSIvi2P9jgio7xM1AJ2rOQyuV+z6aFuzNhDOYk52E4UdkPhhOTa+/vh
	XYIuks7zM5jZ8L/CjRhkuxUdnCTHTSito5vHP8fgkaRXGHNMWm3IwbFkHmbV1lxJ7uaWm7L3sO2
	8thTK4mJzxmeavR0m0DRkucDtkwgrhGDhWvBQORPg5Uu5TAMUyG1wC3vrIkmj7gQWp1R5jgf+uU
	zQumtnk8ZgZBQmFD6tmDG/yzrCc6exLs1h/B5muvM=
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cf825c119mr660622285e9.16.1788883054080;
        Tue, 08 Sep 2026 08:57:34 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm542370045e9.5.2026.09.08.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:33 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: conor@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v2 2/2] net: phylink: wait for PHYs that are known to probe late
Date: Tue,  8 Sep 2026 15:57:28 +0000
Message-ID: <20260908155729.4164814-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908155729.4164814-1-f@lex.la>
References: <20260908155729.4164814-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose driver or firmware lives on a filesystem mounted after the
MAC probes cannot be connected when the port is set up, and the port is
lost for the rest of the uptime. Let the PHY declare that with
needs-host-firmware and poll for it instead of failing.
Deferring the MAC's own probe is not an option: it would take every
port with it, including the one needed to mount the filesystem that
holds the firmware. Return 0 rather than -ENODEV, because DSA reads
-ENODEV as permission to look for the PHY on the switch's internal MDIO
bus, which is the wrong device.

Wait for a driver that has bound, not for a device that exists, because
the generic driver would otherwise bind and cannot drive such a PHY.
The test cannot be made to hold past its own return: the device lock it
wants cannot be held across the attach, whose failure path takes it
again. What is caught instead is the outcome one step later, where the
attach bound a generic driver and returned success, and the poll puts
that back. The window before it, where phy_attach_direct() meets a NULL
phydev->drv, stays open; closing it wants a check inside that function,
or an event from the bind instead of this poll.

Only that lost race is retried. A connect that fails with the real
driver bound is not, because the failure path ends in phy_detach(),
which asserts a PHY-node reset line - and on the boards this exists for
that erases the firmware a retry would need, once per attempt for the
uptime. A PHY that was ready at connect time arms no poll and keeps the
old behaviour. Every path that arms the poller cancels it first and
waits, so nothing else has to keep the poller and its state apart.

While the poll runs the port has no PHY, so reporting the MAC's own
link modes would describe a link that cannot come up and would let
ethtool accept settings for it. Report an empty set instead, and refuse
to configure, to set pause parameters, and to restart autonegotiation,
which has nothing to renegotiate with. The reply says autonegotiation
is off, which is the ethtool core's zero left in place and agrees with
the empty set: a port advertising nothing is negotiating nothing.
Reading pause parameters is left alone, because it reports the
configured request rather than a capability, and the EEE calls already
return -EOPNOTSUPP with no PHY attached.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phylink.c | 210 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 203 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6ed2219961fb..a872f000204a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -98,6 +98,14 @@ struct phylink {
 
 	u32 wolopts_mac;
 	u8 wol_sopass[SOPASS_MAX];
+
+	/* The poller owns these; every other writer cancels it first. */
+	struct fwnode_handle *late_phy_fwnode;
+	u32 late_phy_flags;
+	struct delayed_work late_phy_poll;
+	unsigned int late_phy_poll_ms;
+	unsigned int late_phy_waited_ms;
+	bool late_phy_warned;
 };
 
 #define phylink_printk(level, pl, fmt, ...) \
@@ -1829,6 +1837,20 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static void phylink_late_phy_poll(struct work_struct *work);
+
+/* Synchronous because the node is put here and the poller reads it, and
+ * not every caller holds the rtnl that would keep them apart. It cannot
+ * deadlock on a caller that does: the poller only ever takes rtnl with
+ * trylock, so it never waits for the lock this may be called under.
+ */
+static void phylink_late_phy_cancel(struct phylink *pl)
+{
+	cancel_delayed_work_sync(&pl->late_phy_poll);
+	fwnode_handle_put(pl->late_phy_fwnode);
+	pl->late_phy_fwnode = NULL;
+}
+
 /**
  * phylink_update_pause_state() - Update the phylink pause frame configuration
  * @pl: a pointer to a &struct phylink instance
@@ -1987,6 +2009,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_DELAYED_WORK(&pl->late_phy_poll, phylink_late_phy_poll);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -2070,6 +2093,8 @@ void phylink_destroy(struct phylink *pl)
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	phylink_late_phy_cancel(pl);
+
 	cancel_work_sync(&pl->resolve);
 	kfree(pl);
 }
@@ -2339,10 +2364,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-			      phy_interface_t interface)
+			      phy_interface_t interface, u32 flags)
 {
-	u32 flags = 0;
-
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
@@ -2380,7 +2403,7 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 		pl->link_config.interface = pl->link_interface;
 	}
 
-	ret = phylink_attach_phy(pl, phy, pl->link_interface);
+	ret = phylink_attach_phy(pl, phy, pl->link_interface, 0);
 	if (ret < 0)
 		return ret;
 
@@ -2392,6 +2415,133 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 }
 EXPORT_SYMBOL_GPL(phylink_connect_phy);
 
+#define PHYLINK_LATE_PHY_POLL_MS	1000
+#define PHYLINK_LATE_PHY_WARN_MS	60000
+#define PHYLINK_LATE_PHY_POLL_MAX_MS	30000
+
+static bool phylink_late_phy_pending(struct phylink *pl)
+{
+	return pl->late_phy_fwnode && !pl->phydev;
+}
+
+/* Stale the moment it returns: the device lock this wants cannot be held
+ * across the attach, whose own failure path takes it again.
+ */
+static bool phylink_phy_is_usable(struct phy_device *phy_dev)
+{
+	return phy_dev && device_is_bound(&phy_dev->mdio.dev) && phy_dev->drv;
+}
+
+static void phylink_late_phy_backoff(struct phylink *pl)
+{
+	pl->late_phy_poll_ms = min_t(unsigned int, pl->late_phy_poll_ms * 2,
+				     PHYLINK_LATE_PHY_POLL_MAX_MS);
+}
+
+static void phylink_late_phy_poll(struct work_struct *work)
+{
+	struct phylink *pl = container_of(to_delayed_work(work), struct phylink,
+					  late_phy_poll);
+	struct phy_device *phy_dev;
+	bool again = false, lost_race = false;
+	int ret;
+
+	/* Never block on rtnl: this runs on a shared workqueue. */
+	if (!rtnl_trylock()) {
+		pl->late_phy_waited_ms += pl->late_phy_poll_ms;
+		goto requeue;
+	}
+
+	/* Stable here: whoever clears it waits for this work first. */
+	phy_dev = fwnode_phy_find_device(pl->late_phy_fwnode);
+	if (!phylink_phy_is_usable(phy_dev)) {
+		if (phy_dev)
+			phy_device_free(phy_dev);
+
+		if (!pl->late_phy_warned &&
+		    pl->late_phy_waited_ms >= PHYLINK_LATE_PHY_WARN_MS) {
+			pl->late_phy_warned = true;
+			phylink_warn(pl,
+				     "still waiting for %pfw (needs-host-firmware)\n",
+				     pl->late_phy_fwnode);
+		}
+		/* Past the warn it may never come: stop paying 1 Hz for it. */
+		if (pl->late_phy_waited_ms >= PHYLINK_LATE_PHY_WARN_MS)
+			phylink_late_phy_backoff(pl);
+		/* The first run is immediate, so count the sleep ahead. */
+		pl->late_phy_waited_ms += pl->late_phy_poll_ms;
+		rtnl_unlock();
+		goto requeue;
+	}
+
+	/* Under the mutex, unlike at connect: this port may be live. */
+	if (pl->link_interface == PHY_INTERFACE_MODE_NA) {
+		mutex_lock(&pl->state_mutex);
+		pl->link_interface = phy_dev->interface;
+		pl->link_config.interface = pl->link_interface;
+		mutex_unlock(&pl->state_mutex);
+	}
+
+	ret = phylink_attach_phy(pl, phy_dev, pl->link_interface,
+				 pl->late_phy_flags);
+	if (!ret && phy_driver_is_genphy(phy_dev)) {
+		/* Lost the race: the attach bound the generic driver, which
+		 * is the outcome this poller exists to avoid.
+		 */
+		phy_detach(phy_dev);
+		lost_race = true;
+		ret = -EAGAIN;
+	}
+	if (!ret) {
+		ret = phylink_bringup_phy(pl, phy_dev,
+					  pl->link_config.interface);
+		if (ret) {
+			phy_detach(phy_dev);
+		} else {
+			/* Only a major config programs the masks bringup
+			 * narrowed.
+			 */
+			if (!test_bit(PHYLINK_DISABLE_STOPPED,
+				      &pl->phylink_disable_state)) {
+				mutex_lock(&pl->state_mutex);
+				pl->force_major_config = true;
+				mutex_unlock(&pl->state_mutex);
+				/* MAC before the PHY, the order a start
+				 * uses; on a port already running that is a
+				 * forced major config, not an initial one.
+				 */
+				phylink_run_resolve(pl);
+				flush_work(&pl->resolve);
+				phy_start(phy_dev);
+			}
+		}
+	}
+	if (lost_race) {
+		/* The lost race unbound the generic driver again, and the
+		 * real one is arriving, so look again at the current rate
+		 * without spending the wait's budget.
+		 */
+		again = true;
+	} else if (ret) {
+		/* Not retried: every attempt ends in phy_detach(), which
+		 * asserts a PHY-node reset line, and on the boards this
+		 * exists for that erases the firmware a retry would need.
+		 */
+		phylink_err(pl, "failed to connect late PHY: %pe\n",
+			    ERR_PTR(ret));
+	}
+	phy_device_free(phy_dev);
+	rtnl_unlock();
+
+	if (!again)
+		return;
+
+requeue:
+	queue_delayed_work(system_freezable_power_efficient_wq,
+			   &pl->late_phy_poll,
+			   msecs_to_jiffies(pl->late_phy_poll_ms));
+}
+
 /**
  * phylink_of_phy_connect() - connect the PHY specified in the DT mode.
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2402,7 +2552,8 @@ EXPORT_SYMBOL_GPL(phylink_connect_phy);
  * specified by @pl. Actions specified in phylink_connect_phy() will be
  * performed.
  *
- * Returns 0 on success or a negative errno.
+ * Returns what phylink_fwnode_phy_connect() returns, including 0 for a
+ * deferred connect with no PHY attached yet.
  */
 int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
 			   u32 flags)
@@ -2420,7 +2571,13 @@ EXPORT_SYMBOL_GPL(phylink_of_phy_connect);
  * Connect the phy specified @fwnode to the phylink instance specified
  * by @pl.
  *
- * Returns 0 on success or a negative errno.
+ * If the PHY node carries the needs-host-firmware property and the
+ * PHY is not usable yet, 0 is returned with no PHY connected: a poller
+ * connects it once its driver has probed. Until then the MAC runs
+ * without a PHY and ethtool reports no link modes.
+ *
+ * Returns 0 on success - the PHY connected, or the deferred connect
+ * armed - or a negative errno.
  */
 int phylink_fwnode_phy_connect(struct phylink *pl,
 			       const struct fwnode_handle *fwnode,
@@ -2430,6 +2587,8 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	struct phy_device *phy_dev;
 	int ret;
 
+	phylink_late_phy_cancel(pl);
+
 	if (!phylink_expects_phy(pl))
 		return 0;
 
@@ -2442,6 +2601,22 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	}
 
 	phy_dev = fwnode_phy_find_device(phy_fwnode);
+	if (fwnode_property_present(phy_fwnode, "needs-host-firmware") &&
+	    !phylink_phy_is_usable(phy_dev)) {
+		/* -ENODEV here would also send DSA to the switch's own bus. */
+		if (phy_dev)
+			phy_device_free(phy_dev);
+
+		pl->late_phy_fwnode = phy_fwnode;
+		pl->late_phy_flags = flags;
+		pl->late_phy_poll_ms = PHYLINK_LATE_PHY_POLL_MS;
+		pl->late_phy_waited_ms = 0;
+		pl->late_phy_warned = false;
+		queue_delayed_work(system_freezable_power_efficient_wq,
+				   &pl->late_phy_poll, 0);
+		return 0;
+	}
+
 	/* We're done with the phy_node handle */
 	fwnode_handle_put(phy_fwnode);
 	if (!phy_dev)
@@ -2483,6 +2658,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	phylink_late_phy_cancel(pl);
+
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
 	if (phy)
@@ -3042,6 +3219,14 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 
 	ASSERT_RTNL();
 
+	/* No PHY yet: the port supports nothing, not what the MAC alone can. */
+	if (phylink_late_phy_pending(pl)) {
+		kset->base.port = pl->link_port;
+		kset->base.speed = SPEED_UNKNOWN;
+		kset->base.duplex = DUPLEX_UNKNOWN;
+		return 0;
+	}
+
 	if (pl->phydev)
 		phy_ethtool_ksettings_get(pl->phydev, kset);
 	else
@@ -3114,6 +3299,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 
 	ASSERT_RTNL();
 
+	/* Would configure the MAC alone, for a link that cannot come up. */
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev) {
 		struct ethtool_link_ksettings phy_kset = *kset;
 
@@ -3287,6 +3476,9 @@ int phylink_ethtool_nway_reset(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev)
 		ret = phy_restart_aneg(pl->phydev);
 	phylink_pcs_an_restart(pl);
@@ -3326,6 +3518,10 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 	if (pl->req_link_an_mode == MLO_AN_FIXED)
 		return -EOPNOTSUPP;
 
+	/* pl->supported still describes the MAC, so the test below passes. */
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (!phylink_test(pl->supported, Pause) &&
 	    !phylink_test(pl->supported, Asym_Pause))
 		return -EOPNOTSUPP;
@@ -3812,7 +4008,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	/* Attach the PHY so that the PHY is present when we do the major
 	 * configuration step.
 	 */
-	ret = phylink_attach_phy(pl, phy, config.interface);
+	ret = phylink_attach_phy(pl, phy, config.interface, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

