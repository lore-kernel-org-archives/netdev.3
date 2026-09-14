Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E134A64CF
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420307; cv=none; b=QKo7ecJf+2eyvqZhxgf2uK+8ggM8HvWUXOVuvNMux503DF46o4+1DlPKTyKFfmQfq2EQYu79NFXzYtQI6QgDbmMv9viuQhMVWNRL0sVqwuQfu9oabt4XCYpPxwrKoigO7m4E4lXoutLHyGvb6uyjZmxq+sN8Qz6HMuDHYgCfk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420307; c=relaxed/simple;
	bh=XzYFj0tvExDCyJcHyGOsVEqL5kNINvZMfARuVlQcoLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU66ArpQRyZk5CGkDtWaat5OmVneIpRZ4t5LF73NU1IElXAX/Ob1tuKCm4o2y8ybSN55EtKpyQaHB+k4FmC5gt7kQRtDJB07OIQy4o+lzi5JZNqnjk5j4rAZMDXcBsSIgoXvhv85Og2A/MXnKexnRaLXCJs4VUyKN2bq7x1XHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=YFgffLb9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="YFgffLb9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so9760235e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789420303; x=1790025103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDHsg2YX2fYEnGQgknH4BgiBWPIDkNH+DpXPNej7l5Y=;
        b=YFgffLb9fs3BJZD+AS3XegUWv3da8jDewrVM+rteXRaH/3XMVoNzfLJNdGGK+hzwix
         ZZf6owCyuPfTUlRNcrraA5HoOVd/wgIjSNMDzQYATRvFGg6xhS6vbglkZf1xZ6dJJbrc
         aoYWCS49Klq01pNnyBdbyF/Iw4EpvWzGcI5Ce9d6G3oISGnWY9vKXThOI5iCYkh8ExgB
         FtHE1xPclQC6yqmsXY2Zz2UkM+JCrWWyyGgS+47sP+jPqA5zOTSG9hZZCy4QiXbV3tks
         LChl5pFPkTMzjajXm/eib1GuXQaqvgfbQi9nzSQtTozOkKo0W1swv0ldve7nS1cF4EXu
         AQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420303; x=1790025103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDHsg2YX2fYEnGQgknH4BgiBWPIDkNH+DpXPNej7l5Y=;
        b=JfKWOXh9/J3eeJLgGG9HJdaJiSahYg41PmqDTv6kZE3RxCMopDs4fSVikZAPdLFla3
         lx2pESgRb8cW5V/gN8ik1nmJHRu7ahmrby/qYBH4zq9uXZ7rIWNqONmX7i+bw/zdJX1n
         L3GfOFBEk9356Wdj/qpKulRcQ8U2I1g/vp5JNXiCnmYJCb6nsiDZmwp/aIJvnYaVc0Wd
         5pUr0MqJdZ1STLPqZpMujvZ+CtJoNH4iuaBXdS2C5UB5C2ZK9Lbrzzbp4vwYLXe0gtd2
         Ha65f+/Tfmn7DVpJqyRyJrft3CEjf33oNkiz7pg+ZRLlJ4KZOTLEcWxzuy+8fQGrcc6c
         VDzA==
X-Gm-Message-State: AFuF++li1wmMz84cdmMqXn2qnBRwvvfhkrqL1tM2sD4L4g2sK3d4ID8c
	iUH20HuaBVeY2lpCSR/L3cVcnE0RY56NoSOhJlbuUxVTF66H1wvkIOxgAOHM7cAGiO+9w8z5sex
	BkY3kiS8rBrtpE3Y=
X-Gm-Gg: AYBFou2Z4i8ji9iFeWrnmsxIPBJZBWNVzFqyC6tJkPEARx072X6XaYUJAPq1svKh1y0
	7Hv4IKKXjowv2pnT58Pybyz5EYXvhXn1MvufXz84SCYlM+z8vHPruwySkIVzJAj3uHPaamxL5K5
	TKHBMc9U/sRsgDQknV6wzX0xjGhB/JRf4LqRoL67EdVSJwHIXelglWjwTD8qdsJ0dNwAMtuCmAH
	Nqw7RcO3qc/nC8WOyfUl4tvO7djtgvhZxgZYNJLtUejeCHsWgpfrQ1+CJh806BwzYDp6tHf9/6N
	SuJk+Ex5+EyExjqIAMlUbNi0wU9u14eTucEC7UHvwdvElSWowN3YGTqlX0qvz0JAYfhtcD1/jSv
	EA4MAGHQTFrwIgBF4PVLbgyA05+vfHBWz3bA7pndC0RmVCG4kdMdGgS5kPDrdFCrEM0RZuCooKg
	LudY5gl28o41SfIsqdwjGs0gul1F7Smw6h0hVMU9lTXzjAr2g/9g==
X-Received: by 2002:a05:600c:6212:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-49e7a66b636mr54487715e9.20.1789420302856;
        Mon, 14 Sep 2026 14:11:42 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef74a5dsm5642305e9.7.2026.09.14.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:11:42 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
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
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v3 2/2] net: phylink: wait for PHYs that are known to probe late
Date: Tue, 15 Sep 2026 00:11:37 +0300
Message-ID: <20260914211137.2760618-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914211137.2760618-1-f@lex.la>
References: <20260914211137.2760618-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose driver has not bound when the MAC sets up its port cannot
be connected, and the port is lost for the rest of the uptime. The
case this reaches is a driver modular on a filesystem that is mounted
after the MAC probes. Let the PHY declare it with needs-host-firmware
and poll until the driver binds instead of failing. A driver that has
bound is not covered, whatever it does about firmware afterwards.
Neither is one whose probe has already failed: nothing re-probes it,
and the poller cannot tell that apart from a driver that has yet to
load, so it keeps polling at the backed-off rate.
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

Only that lost race is retried at the poll rate. A connect that fails
with the real driver bound is retried a small fixed number of times,
then given up on with a line that says so, because silence from a
poller reads like success. Detach and attach is what an ordinary port
teardown and set-up already do, so a PHY driver has to survive one;
what phylink cannot know is the cost of repeating it. The detach
asserts whatever reset line the DT gave the PHY, so on one board a
retry is a reset pulse and on another it is not, and either way the
re-attach re-runs phy_init_hw() with the driver's own soft reset and
config_init. That varies by board and by PHY and is not priceable
from here, so it is bounded rather than conditioned on any one part
of it. The size of the bound matters less than its existence: a few
more attempts carry a bus error that clears itself, and any bound
keeps a failure that cannot change - a rejected link mode, rejected
again on every poll with the same two bitmaps printed - from
repeating for the uptime. Stopping after the first failure was the
alternative, but a port left disconnected by a transient error stays
dead until the switch driver is rebound, since DSA connects a user
port once. The retries go out at the rate the wait phase has reached,
which is not necessarily the initial one. A PHY that arrives by
another path, an SFP for one, stops the poller instead of racing it,
and one that was ready at connect time arms no poll at all. Every
path that arms the poller cancels it first and waits, so nothing else
has to keep the poller and its state apart.

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
 drivers/net/phy/phylink.c | 227 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 220 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7079f37d8c3..6b4aa18cfb6e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -98,6 +98,15 @@ struct phylink {
 
 	u32 wolopts_mac;
 	u8 wol_sopass[SOPASS_MAX];
+
+	/* The poller writes these while it runs; arming cancels it first. */
+	struct fwnode_handle *late_phy_fwnode;
+	u32 late_phy_flags;
+	struct delayed_work late_phy_poll;
+	unsigned int late_phy_poll_ms;
+	unsigned int late_phy_waited_ms;
+	u8 late_phy_retries;
+	bool late_phy_warned;
 };
 
 #define phylink_printk(level, pl, fmt, ...) \
@@ -1831,6 +1840,20 @@ int phylink_set_fixed_link(struct phylink *pl,
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
@@ -1989,6 +2012,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_DELAYED_WORK(&pl->late_phy_poll, phylink_late_phy_poll);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -2068,6 +2092,8 @@ EXPORT_SYMBOL_GPL(phylink_create);
  */
 void phylink_destroy(struct phylink *pl)
 {
+	phylink_late_phy_cancel(pl);
+
 	sfp_bus_del_upstream(pl->sfp_bus);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
@@ -2341,10 +2367,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-			      phy_interface_t interface)
+			      phy_interface_t interface, u32 flags)
 {
-	u32 flags = 0;
-
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
@@ -2382,7 +2406,7 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 		pl->link_config.interface = pl->link_interface;
 	}
 
-	ret = phylink_attach_phy(pl, phy, pl->link_interface);
+	ret = phylink_attach_phy(pl, phy, pl->link_interface, 0);
 	if (ret < 0)
 		return ret;
 
@@ -2394,6 +2418,148 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 }
 EXPORT_SYMBOL_GPL(phylink_connect_phy);
 
+#define PHYLINK_LATE_PHY_POLL_MS	1000
+#define PHYLINK_LATE_PHY_WARN_MS	60000
+#define PHYLINK_LATE_PHY_POLL_MAX_MS	30000
+#define PHYLINK_LATE_PHY_RETRIES	3
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
+	/* A PHY arrived by another path, an SFP for one, while queued. */
+	if (!phylink_late_phy_pending(pl)) {
+		rtnl_unlock();
+		return;
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
+				 * uses.
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
+		phylink_err(pl, "failed to connect late PHY: %pe\n",
+			    ERR_PTR(ret));
+		/* Bounded: a retry pulses any reset the DT describes and
+		 * re-runs the driver's init, at a cost that varies by
+		 * board and PHY.
+		 */
+		if (pl->late_phy_retries) {
+			pl->late_phy_retries--;
+			again = true;
+		} else {
+			/* Silence from here reads as success otherwise. */
+			phylink_err(pl, "giving up on %pfw after %u attempts\n",
+				    pl->late_phy_fwnode,
+				    PHYLINK_LATE_PHY_RETRIES + 1);
+		}
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
@@ -2404,7 +2570,8 @@ EXPORT_SYMBOL_GPL(phylink_connect_phy);
  * specified by @pl. Actions specified in phylink_connect_phy() will be
  * performed.
  *
- * Returns 0 on success or a negative errno.
+ * Returns what phylink_fwnode_phy_connect() returns, including 0 for a
+ * deferred connect with no PHY attached yet.
  */
 int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
 			   u32 flags)
@@ -2422,7 +2589,13 @@ EXPORT_SYMBOL_GPL(phylink_of_phy_connect);
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
@@ -2432,6 +2605,8 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	struct phy_device *phy_dev;
 	int ret;
 
+	phylink_late_phy_cancel(pl);
+
 	if (!phylink_expects_phy(pl))
 		return 0;
 
@@ -2444,6 +2619,23 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
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
+		pl->late_phy_retries = PHYLINK_LATE_PHY_RETRIES;
+		pl->late_phy_warned = false;
+		queue_delayed_work(system_freezable_power_efficient_wq,
+				   &pl->late_phy_poll, 0);
+		return 0;
+	}
+
 	/* We're done with the phy_node handle */
 	fwnode_handle_put(phy_fwnode);
 	if (!phy_dev)
@@ -2485,6 +2677,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	phylink_late_phy_cancel(pl);
+
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
 	if (phy)
@@ -3044,6 +3238,14 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 
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
@@ -3116,6 +3318,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 
 	ASSERT_RTNL();
 
+	/* Would configure the MAC alone, for a link that cannot come up. */
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev) {
 		struct ethtool_link_ksettings phy_kset = *kset;
 
@@ -3289,6 +3495,9 @@ int phylink_ethtool_nway_reset(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev)
 		ret = phy_restart_aneg(pl->phydev);
 	phylink_pcs_an_restart(pl);
@@ -3328,6 +3537,10 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 	if (pl->req_link_an_mode == MLO_AN_FIXED)
 		return -EOPNOTSUPP;
 
+	/* pl->supported still describes the MAC, so the test below passes. */
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (!phylink_test(pl->supported, Pause) &&
 	    !phylink_test(pl->supported, Asym_Pause))
 		return -EOPNOTSUPP;
@@ -3814,7 +4027,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	/* Attach the PHY so that the PHY is present when we do the major
 	 * configuration step.
 	 */
-	ret = phylink_attach_phy(pl, phy, config.interface);
+	ret = phylink_attach_phy(pl, phy, config.interface, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

