Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72F519910
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548608; cv=none; b=qpIvMBGRNz6+FVc6QQ/nlk28PM6VmeCLa2Modss7ZNC4+gNFo+yVDDi0sdj9bWRq0Egtavn9nLDKON96+togEJNPcjD0T6zr9T98UVqcBWNt8wXV2DsqhJtapR+Imh3iBgwV/Q2GXhCpnbn7QFiwor7ZUffYtZyij3zDdnrztfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548608; c=relaxed/simple;
	bh=PO8a5Z8DiIMETb3iouwkHF/HKHTLWWj3iX36fpVEXKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F004l7P7PRGISCWnaa0wEfOHydyudiLHOYzdF9DdCVmbl4Ga9ijuTco9Tq4kiOcZEp3d3u8ekwJlFanLuPXd2gPsjI/3rtDtLvYdO8Ixs54Heh/7GSe+ejov9xlPbNj2p3FkX7sxI9Lxh6y3JTa6vPeD5vx9gCGYW9oPzDfYzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=UWyq9E2y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="UWyq9E2y"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso11273455e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548599; x=1789153399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggwy/baXAuOKAxlowPZX6KfzPl9ZtpnT/akRZO0db6E=;
        b=UWyq9E2yoBfNPQhHbIYgvFzpnj2u9mR4J0oAh8Dgku4SxbeNsP1lcmv8H8uofrImf1
         wycGJgZZ1w7J9dbqUWSgOf+T4ZRB7EqOVe2lPssdGTMokd2KCBUtV/kW6Dn5P4pxdZjf
         jUWankfU2e5ekyqTDod/Ux/NSGLBNxJIXfW2LXt/aInD+DaLycW8ydopSB/EhIx+ARop
         o9e0jFesU8Cr4Tj6lID2rp1lUkQluIMhX6N79qbhcMwr6cEwmYznFP2wEewEXtsrj0H+
         JAO8m0cm+nMvWzm8jIFQECFdicPGN6VyQh11TiK/gN9vPgqF9Mpr+qZewcTP9DkB2esk
         fC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548599; x=1789153399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggwy/baXAuOKAxlowPZX6KfzPl9ZtpnT/akRZO0db6E=;
        b=tGFB4Ypntar19hGSXrLNbzg3MDCQIm6WsERAsR1rG21w+7mjSeGQWX2Eb076NpDjiR
         OuKT7ErCZN72yoK5D5xAhz1XQoIr9oLM6uIJeOAaKT9iPrig/zR0ljkubTTzm1hgExgr
         vP1SWvtOoHjx/qJQfw6nPFmlhWMxQj+Cnsg5SsJ0vCK5X7RBCJZ2VWsEm9vf/+TMQB/2
         HXOLEhX7wYjaDWTuFBXfyDEH+VhdVhzzWMiYqMdsddoc7WfC6RLuIJpKlODSRmQp+Tx+
         B9v+MEryNiOCvwfGYXro5Uv1hX+lPDlzUPcVEgbxPCuANaU/ncO/nspaZKWh5NABPxIc
         YJZw==
X-Forwarded-Encrypted: i=1; AKwUvBxwsPMzXj9XZ4ryAm6OOAor63yb5QSnSyqzc8VFU22I7gLpCoJwpybfsqGQrXZyptrjrH7LQpk=@vger.kernel.org
X-Gm-Message-State: AFuF++kHTbjToXkwsGTRFiROx4pkMknn+xtp7ZwaRqSIpl8+6w+fIxd9
	ep6lkUGBgJ1t/g6jvyokpL4zMRN4z+mv6c7KqXK+Ao/Zk4fky05C5AmguKIbzW3pPLE=
X-Gm-Gg: AYBFou3Ilz7/hPAK86upGoeqBG/jTTmhMvBo6VIdgWXcEnuKxW4531o3yOsanWEUu7G
	OwSJDHwTZc0c5ErLhvWeKWNkN4w/3iW/zz/Gqu0o7AQH3ENxWanvgHIeQ2SytMt9Rwd0IEHizR3
	hWVvDqC5/s0jWdsYM8g9PDnzRT1PGsxxkcm6/c8Cg6+ZeefEKTU8TlmhA7PSpLEqHH4Gd8D+faM
	cB/oFn1ZE5hkOLmCx+9W7em/ioT9UUD/7hxIbRRoxF0lPUTpVTjrOp/4bwzB+TTM72LLMXejkJQ
	L3tThaNax8uWbmPcA+TbGMEN+U31+BrCcYVk9zuJLGuiED8QqWf+dVEqfwFNTj8MIZnO/O+AbA2
	pvKhpzbeOuJcaK0vxswIehIXi3XJzdrlWv6KpXcXKssrrzKPJFcfei2isnLW290vQA/GElNcz+E
	fVXWSR71rIRWu2ztZAnBnPZmIoMsTHo15x+ssMrq4=
X-Received: by 2002:a05:600c:1991:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49cf824f7damr77027875e9.11.1788548599214;
        Fri, 04 Sep 2026 12:03:19 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:18 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 09/10] net: phylink: wait for PHYs that are known to probe late
Date: Fri,  4 Sep 2026 19:03:03 +0000
Message-ID: <3662f8fafff9a386dcf1e798bb85d2d7cede7079.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose driver or firmware lives on a filesystem mounted after the
MAC probes cannot be connected when the port is set up, and the port is
lost for the rest of the uptime. Let a port declare that with
phy-needs-host-firmware and poll for the PHY instead of failing. Return
0 rather than -ENODEV, because DSA reads -ENODEV as permission to look
for the PHY on the switch's internal MDIO bus, which is the wrong
device.

Wait for a driver that has bound rather than a device that exists,
because the generic driver would otherwise bind and cannot drive such a
PHY. Deferring the MAC's own probe is not an option: it would take every
port with it, including the one needed to mount the filesystem that
holds the firmware. Keep polling after a failed connect, because a
failed bringup detaches the PHY and whether the next attempt succeeds
depends on which driver binds it, which phylink cannot see; -EBUSY is
the exception and stops the poller, because it means the PHY is already
attached, here or elsewhere, and polling cannot change that, after which
the port keeps the pending state and reports no link modes until it is
reconnected. When the port is running and nothing else is holding the
link down, the MAC is configured before the PHY is started, the order
phylink_start() uses, and the only other place that starts a late PHY
should not use a different one; that also makes the forced configuration
run at a deterministic moment rather than whenever the workqueue reaches
it. rtnl is taken with trylock so the poller never blocks on it, which
keeps it from parking a shared workqueue worker while another thread
holds rtnl. The asynchronous cancel in phylink_disconnect_phy() is then
enough, because the stop flag makes a run that slips through a no-op.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phylink.c | 179 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 172 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 97712c1572ad..bceeac954779 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -73,6 +73,15 @@ struct phylink {
 	struct phylink_link_state phy_state;
 	unsigned int phy_ib_mode;
 	struct work_struct resolve;
+	/* Set before the poller is queued, cleared under rtnl. */
+	struct fwnode_handle *slow_phy_fwnode;
+	u32 slow_phy_flags;
+	struct delayed_work slow_phy_poll;
+	unsigned int slow_phy_poll_ms;
+	unsigned int slow_phy_waited_ms;
+	bool slow_phy_err_logged;
+	/* Read unlocked by the poller; a stale read costs one poll cycle. */
+	bool slow_phy_stop;
 	unsigned int pcs_neg_mode;
 	unsigned int pcs_state;
 
@@ -1829,6 +1838,8 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static void phylink_slow_phy_poll(struct work_struct *work);
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
@@ -1867,6 +1878,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_DELAYED_WORK(&pl->slow_phy_poll, phylink_slow_phy_poll);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -1950,6 +1962,10 @@ void phylink_destroy(struct phylink *pl)
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	WRITE_ONCE(pl->slow_phy_stop, true);
+	cancel_delayed_work_sync(&pl->slow_phy_poll);
+	fwnode_handle_put(pl->slow_phy_fwnode);
+
 	cancel_work_sync(&pl->resolve);
 	kfree(pl);
 }
@@ -2219,10 +2235,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-			      phy_interface_t interface)
+			      phy_interface_t interface, u32 flags)
 {
-	u32 flags = 0;
-
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
@@ -2260,7 +2274,7 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 		pl->link_config.interface = pl->link_interface;
 	}
 
-	ret = phylink_attach_phy(pl, phy, pl->link_interface);
+	ret = phylink_attach_phy(pl, phy, pl->link_interface, 0);
 	if (ret < 0)
 		return ret;
 
@@ -2272,6 +2286,124 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 }
 EXPORT_SYMBOL_GPL(phylink_connect_phy);
 
+#define PHYLINK_SLOW_PHY_POLL_MS	1000
+#define PHYLINK_SLOW_PHY_WARN_MS	60000
+#define PHYLINK_SLOW_PHY_POLL_MAX_MS	30000
+
+/* Bound, not drv: drv is published before the driver's probe runs. The
+ * device lock cannot be taken under rtnl, and losing this race costs a
+ * generic-driver attach, not memory safety.
+ */
+static bool phylink_phy_is_usable(struct phy_device *phy_dev)
+{
+	return phy_dev && device_is_bound(&phy_dev->mdio.dev);
+}
+
+static void phylink_slow_phy_backoff(struct phylink *pl)
+{
+	WRITE_ONCE(pl->slow_phy_poll_ms,
+		   min_t(unsigned int, pl->slow_phy_poll_ms * 2,
+			 PHYLINK_SLOW_PHY_POLL_MAX_MS));
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
+	/* Never block on rtnl: this runs on a shared workqueue. */
+	if (!rtnl_trylock())
+		goto requeue;
+
+	if (READ_ONCE(pl->slow_phy_stop)) {
+		rtnl_unlock();
+		return;
+	}
+
+	/* Under rtnl: phylink_disconnect_phy() puts and clears the node. */
+	phy_dev = fwnode_phy_find_device(pl->slow_phy_fwnode);
+	if (!phylink_phy_is_usable(phy_dev)) {
+		if (phy_dev)
+			phy_device_free(phy_dev);
+
+		pl->slow_phy_waited_ms += pl->slow_phy_poll_ms;
+		if (pl->slow_phy_waited_ms >= PHYLINK_SLOW_PHY_WARN_MS &&
+		    pl->slow_phy_waited_ms - pl->slow_phy_poll_ms <
+		    PHYLINK_SLOW_PHY_WARN_MS)
+			phylink_warn(pl,
+				     "still waiting for %pfw (phy-needs-host-firmware)\n",
+				     pl->slow_phy_fwnode);
+		/* Past the warn it may never come: stop paying 1 Hz for it. */
+		if (pl->slow_phy_waited_ms >= PHYLINK_SLOW_PHY_WARN_MS)
+			phylink_slow_phy_backoff(pl);
+		rtnl_unlock();
+		goto requeue;
+	}
+
+	if (pl->link_interface == PHY_INTERFACE_MODE_NA) {
+		mutex_lock(&pl->state_mutex);
+		pl->link_interface = phy_dev->interface;
+		pl->link_config.interface = pl->link_interface;
+		mutex_unlock(&pl->state_mutex);
+	}
+
+	ret = phylink_attach_phy(pl, phy_dev, pl->link_interface,
+				 pl->slow_phy_flags);
+	phy_device_free(phy_dev);
+	if (!ret) {
+		ret = phylink_bringup_phy(pl, phy_dev,
+					  pl->link_config.interface);
+		if (ret) {
+			phy_detach(phy_dev);
+		} else {
+			/* Only a major config programs the masks bringup just
+			 * narrowed; the resolve's own trigger cannot see it.
+			 */
+			mutex_lock(&pl->state_mutex);
+			pl->force_major_config = true;
+			mutex_unlock(&pl->state_mutex);
+			if (!test_bit(PHYLINK_DISABLE_STOPPED,
+				      &pl->phylink_disable_state)) {
+				/* MAC first, then the PHY, as phylink_start()
+				 * does; the config is skipped while the
+				 * resolve is disabled.
+				 */
+				phylink_run_resolve(pl);
+				flush_work(&pl->resolve);
+				phy_start(phy_dev);
+			}
+		}
+	}
+	if (ret) {
+		/* The errno does not distinguish permanent from transient. */
+		if (!pl->slow_phy_err_logged) {
+			pl->slow_phy_err_logged = true;
+			phylink_err(pl, "failed to connect late PHY: %pe\n",
+				    ERR_PTR(ret));
+		}
+
+		if (ret == -EBUSY) {
+			rtnl_unlock();
+			return;
+		}
+		phylink_slow_phy_backoff(pl);
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
@@ -2282,7 +2414,8 @@ EXPORT_SYMBOL_GPL(phylink_connect_phy);
  * specified by @pl. Actions specified in phylink_connect_phy() will be
  * performed.
  *
- * Returns 0 on success or a negative errno.
+ * Returns what phylink_fwnode_phy_connect() returns, including 0 for a
+ * deferred connect with no PHY attached yet.
  */
 int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
 			   u32 flags)
@@ -2300,7 +2433,13 @@ EXPORT_SYMBOL_GPL(phylink_of_phy_connect);
  * Connect the phy specified @fwnode to the phylink instance specified
  * by @pl.
  *
- * Returns 0 on success or a negative errno.
+ * If the port node carries the phy-needs-host-firmware property and the
+ * PHY is not usable yet, 0 is returned with no PHY connected: a poller
+ * connects it once its driver has probed. Until then the MAC runs
+ * without a PHY and ethtool reports no link modes.
+ *
+ * Returns 0 on success - the PHY connected, or the deferred connect
+ * armed - or a negative errno.
  */
 int phylink_fwnode_phy_connect(struct phylink *pl,
 			       const struct fwnode_handle *fwnode,
@@ -2322,6 +2461,25 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	}
 
 	phy_dev = fwnode_phy_find_device(phy_fwnode);
+	if (fwnode_property_present(fwnode, "phy-needs-host-firmware") &&
+	    !phylink_phy_is_usable(phy_dev)) {
+		/* -ENODEV here would also send DSA to the switch's own bus. */
+		if (phy_dev)
+			phy_device_free(phy_dev);
+
+		fwnode_handle_put(pl->slow_phy_fwnode);
+		pl->slow_phy_fwnode = phy_fwnode;
+		pl->slow_phy_flags = flags;
+		WRITE_ONCE(pl->slow_phy_poll_ms, PHYLINK_SLOW_PHY_POLL_MS);
+		pl->slow_phy_waited_ms = 0;
+		pl->slow_phy_err_logged = false;
+		WRITE_ONCE(pl->slow_phy_stop, false);
+		/* mod_delayed_work: a cancelled poll may still be pending. */
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				 &pl->slow_phy_poll, 0);
+		return 0;
+	}
+
 	/* We're done with the phy_node handle */
 	fwnode_handle_put(phy_fwnode);
 	if (!phy_dev)
@@ -2363,6 +2521,13 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	/* Async is enough: the stop flag no-ops a run that slips through. */
+	WRITE_ONCE(pl->slow_phy_stop, true);
+	cancel_delayed_work(&pl->slow_phy_poll);
+	/* The next connect re-arms from its own lookup. */
+	fwnode_handle_put(pl->slow_phy_fwnode);
+	pl->slow_phy_fwnode = NULL;
+
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
 	if (phy)
@@ -3741,7 +3906,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	/* Attach the PHY so that the PHY is present when we do the major
 	 * configuration step.
 	 */
-	ret = phylink_attach_phy(pl, phy, config.interface);
+	ret = phylink_attach_phy(pl, phy, config.interface, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

