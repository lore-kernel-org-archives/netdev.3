Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8754D09FE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859741; cv=none; b=oI5QyyJDDVO01WtDbP1he/HuWmmgJlrbJsIO9KDcYSw+R/HF5TFmFfZCFXq6lL1yZ2XKw/IfEt1lZrgpe0sE6U9CRIlV+zJF1aIFV7OQROuDsJ7iFzPr343wfnb4/A5QOCjRMv06SVSaUytiSh75ZWAxiCdEfBkW+G1pYg5SKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859741; c=relaxed/simple;
	bh=p2NI3ZyHqoJLgsfy7YgBuMnSqNNsu035bM4X352B7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4BjqYncBhXJ+XJpJTQmm9dza3lasrFoJcPIHN/rRI7X0CigSqTflRMOWQHEWpIr22Np5KTwNMcZMqi+Ps5suZLvklo8D+WqIJJSUuaXA6elv09J6oNJbsaWl4frzXRPTO1gV/XFNPoH8MFM19oZe7MLJNQKnsJ3EuNBsf5rGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=JZ/GyrJo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="JZ/GyrJo"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b02a2359aso414417f8f.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859737; x=1791464537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fry9N6sLeZ9YtVyImRbgauN1iIH2+7ivtlR8MA+5j4A=;
        b=JZ/GyrJoUe986+BGvaiNl3d3oOMX8M2BVjj965XHm3wufRxfUckoXMuYKNtQv0K5U0
         nTuQwZlULgCU4pclga0UKv1nnIEJIsN2tOKbax6C0WcOu+BT9L5ejLJOC+tVVPWIroHJ
         YBjWb37eb/B6hoAUSyuaVhRAhdJ/u2B2WMUSur6Wp19lpjDgnlrP96SuU9gvnL6rTTS0
         BkVnYN0eWBwFJdlty0h3HEQ3IarTeEcu3OjH4wb0FIRUJdN1NKJqDR0ex1VRFsjd8NOR
         A1GFdzCDAEaiWbcjXfr8CxOfIv4skIQxenChEOguw1KzxUePfJlr06I2FfqKe0trJ2yA
         V8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859737; x=1791464537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fry9N6sLeZ9YtVyImRbgauN1iIH2+7ivtlR8MA+5j4A=;
        b=nkTjmNclAi7KA2FWueBWaVIxQz5zvzr9mkF7OWNqk86EzQHCom7DgzzrwbQXGn69UP
         m9DE+mvS/GUtTfX/X6CmMGa5qqIBZJYovApc/QU7+SXGgocPBLnhMCeFoKuBrKqfs297
         f5Vx5BHbVNQUwfaGxTGRJ888th3IxZJz92rEBPcezghfI25fo+HMCK8axOIPCF6HLaFv
         GqRNWW/vnQWrLzcDUJIuaoE9TN9H1AQQiHHPOG3fN10Z569fDPCefKVQvK9tcugqSjE3
         fdz4MIHvrTU2wmPeCsFSVXII84FzSBMd3Jz8J6SsD2EoHXganNPGA05elZIb9d8Mpnjf
         DCxw==
X-Forwarded-Encrypted: i=1; AKwUvBzaXEJkzt5zaVM5wsrjdfax2+pjqpaRHYfnmyIjJtBVYO05acCM6qTUl35aFjSPogTqFC6JZM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQdX7IvPN1hXUuumchZHRL7eb6mqzJ3xM7UYJHwy5ULEk/57Jw
	D2he5qW0sLcLh7loftt803eA1hZli0schXWsHDyGRtSt1rateT8E7QN+PvDJwQCN1i8=
X-Gm-Gg: AYBFou3BBZKR3bwik3j+sBYfRPR1ZZmhlN9gKIxruUpEQPsZmK9Qy70dBYqE2Ix07Xm
	/AnirCpi/WwOtJJUPiPiK1a9TFiQjifnHsLVWE6tGOydRHS6NkE7qPqXQI/3QeIEFPEI3kDspB2
	oLvi+pr6BWwYhp75U1SsDmk4j6WHy75wh2llUyHKtJfV4lZz97nVgXUsqB0MCv3C7uMNQf0j6A4
	hQ3mf+qYAXSK5nxcRErzRqmW3OaOdYLUa9g/hKYA+8Vx93e53lCxCNoT5bgCVnMhio7syVPYB68
	pDTLqTA4Bck6aUb/EWcI/6u35wmugWF2b00ISYljIKbg1EuPDoAjvArvVQ2L40QvXHU+F1aEeqd
	wS+dNf9EfWqdEh3x9wCxkkhQkOdUmCbsb0sGDekwGrqmfxY/uASuBhSTEwo/5DR14x306pLyQZn
	dlWNHyfLVGgUSNhJX47ZSvoghKRlkhgFwVmZa53+uVfLhhsp//eg==
X-Received: by 2002:a05:6000:4b19:b0:488:8a8d:7d15 with SMTP id ffacd0b85a97d-48b068c8c9cmr5514567f8f.28.1790859736862;
        Thu, 01 Oct 2026 06:02:16 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2cd0fsm5568155f8f.30.2026.10.01.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:16 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 2/3] net: phylink: wait for PHYs that are known to probe late
Date: Thu,  1 Oct 2026 16:02:07 +0300
Message-ID: <20261001130208.105558-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130208.105558-1-f@lex.la>
References: <20261001130208.105558-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY that needs firmware from the host and whose driver has not bound
when the MAC sets up its port is either taken by the generic driver,
which cannot drive it, or not found at all; a MAC that connects once at
setup, as DSA does, gets no working PHY on that port for the rest of the
uptime. The case this reaches is a driver built as a module on a
filesystem that is mounted after the MAC probes. Let the PHY declare it
with needs-host-firmware and, for a MAC that opts in with
phy_may_probe_late, poll until the driver binds instead of failing. A
driver that has bound is not covered, whatever it does about firmware
afterwards. Neither is one whose probe has already failed: the driver
core does not retry it, and the poller cannot tell that apart from a
driver that has yet to load, so it keeps polling.

Deferring the MAC's own probe is not an option: it keeps every port of
that MAC down until the module loads, and forever if it never does, and
those ports can include the one needed to mount the filesystem that
holds the module. Return 0 rather than -ENODEV, because DSA reads
-ENODEV as permission to look for the PHY on the switch's internal MDIO
bus, which is the wrong device.

The deferral is opt-in because it returns 0 with no PHY attached, and
some callers read 0 as a PHY being there: ucc_geth dereferences
dev->phydev later in the same open, and enetc, stmmac, mvneta, sparx5
and lan743x do one-time PHY setup at that point that a late attach
would skip. Those connect from ndo_open, where the problem does not
last: a PHY taken by genphy at one open is released at close, and the
next open finds the real driver. A MAC that connects once at setup has
no such second chance.

The deferral also needs an interface mode known up front, as without
one the MAC would be configured for PHY_INTERFACE_MODE_NA when started
before the PHY supplies its own.

Wait for a driver that has bound, not for a device that exists, because
the generic driver would otherwise bind and cannot drive such a PHY. If
the real driver goes away between that test and the attach, the generic
one binds instead; the poll detaches it and keeps waiting. The
attach-versus-unbind window itself is phylib's to close and is not
closed here.

A connect that fails with the real driver bound is retried a few times
and then given up on with one line, because silence from a poller reads
like success. Each retry re-runs the PHY's init and, on boards whose DT
gives it a reset line, pulses that reset, at a cost that depends on the
board and the PHY, so the retries are bounded. Stopping after the first
failure would leave a DSA port, which connects once, dead until the
switch driver is rebound.

Until a PHY attaches, report no link modes and refuse the ethtool
settings that would configure the MAC alone for a link that cannot come
up.

Found on a Keenetic KN-1012 (MT7981B with an MT7531 switch): the EN8811H
behind lan4 has its driver on the root filesystem, the switch sets its
ports up before that is mounted, and lan4 was lost for the uptime. With
this change lan4 attaches once the module loads. The retry path was
driven there by a local debug parameter that fails the connect after a
successful attach: two injected failures were retried a second apart and
the third attempt attached, and with failures that never stop, four
attempts ended in one "giving up" line and no further polls.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v5:
 - defer only for a MAC that sets phylink_config.phy_may_probe_late
 - defer only with a known interface mode, and drop the
   PHY_INTERFACE_MODE_NA fill-in from the poller
 - kernel-doc names the opt-in and the state after the retries run out

 drivers/net/phy/phylink.c | 221 ++++++++++++++++++++++++++++++++++++--
 include/linux/phylink.h   |   4 +
 2 files changed, 217 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7d086cdc9b2..a663390fdc9f 100644
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
@@ -1831,6 +1840,18 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static void phylink_late_phy_poll(struct work_struct *work);
+
+/* Synchronous: the poller reads the node put here. It only trylocks
+ * rtnl, so a caller holding rtnl cannot deadlock on it.
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
@@ -1989,6 +2010,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_DELAYED_WORK(&pl->late_phy_poll, phylink_late_phy_poll);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -2068,6 +2090,8 @@ EXPORT_SYMBOL_GPL(phylink_create);
  */
 void phylink_destroy(struct phylink *pl)
 {
+	phylink_late_phy_cancel(pl);
+
 	sfp_bus_del_upstream(pl->sfp_bus);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
@@ -2337,10 +2361,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-			      phy_interface_t interface)
+			      phy_interface_t interface, u32 flags)
 {
-	u32 flags = 0;
-
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
@@ -2378,7 +2400,7 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 		pl->link_config.interface = pl->link_interface;
 	}
 
-	ret = phylink_attach_phy(pl, phy, pl->link_interface);
+	ret = phylink_attach_phy(pl, phy, pl->link_interface, 0);
 	if (ret < 0)
 		return ret;
 
@@ -2390,6 +2412,135 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
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
+		/* Not a failed connect: the next poll waits for the real
+		 * driver.
+		 */
+		again = true;
+	} else if (ret) {
+		phylink_err(pl, "failed to connect late PHY: %pe\n",
+			    ERR_PTR(ret));
+		/* Bounded: each retry re-runs the PHY's init, maybe its reset. */
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
@@ -2398,9 +2549,11 @@ EXPORT_SYMBOL_GPL(phylink_connect_phy);
  *
  * Connect the phy specified in the device node @dn to the phylink instance
  * specified by @pl. Actions specified in phylink_connect_phy() will be
- * performed.
+ * performed, except for a deferred connect, where they happen once the
+ * PHY attaches.
  *
- * Returns 0 on success or a negative errno.
+ * Returns what phylink_fwnode_phy_connect() returns, including 0 for a
+ * deferred connect with no PHY attached yet.
  */
 int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
 			   u32 flags)
@@ -2418,7 +2571,17 @@ EXPORT_SYMBOL_GPL(phylink_of_phy_connect);
  * Connect the phy specified @fwnode to the phylink instance specified
  * by @pl.
  *
- * Returns 0 on success or a negative errno.
+ * If the MAC set &phylink_config.phy_may_probe_late and has a known
+ * interface mode, and the PHY node carries the needs-host-firmware
+ * property and the PHY is not usable yet, 0 is returned with no PHY
+ * connected: a poller connects it once its driver has probed. Until
+ * then the MAC runs without a PHY and ethtool reports no link modes.
+ * If the connect keeps failing with the driver bound, the poller gives
+ * up after a few attempts and the port stays that way until the PHY is
+ * disconnected and connected again.
+ *
+ * Returns 0 on success - the PHY connected, or the deferred connect
+ * armed - or a negative errno.
  */
 int phylink_fwnode_phy_connect(struct phylink *pl,
 			       const struct fwnode_handle *fwnode,
@@ -2428,6 +2591,8 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	struct phy_device *phy_dev;
 	int ret;
 
+	phylink_late_phy_cancel(pl);
+
 	if (!phylink_expects_phy(pl))
 		return 0;
 
@@ -2440,6 +2605,25 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	}
 
 	phy_dev = fwnode_phy_find_device(phy_fwnode);
+	if (pl->config->phy_may_probe_late &&
+	    pl->link_interface != PHY_INTERFACE_MODE_NA &&
+	    fwnode_property_present(phy_fwnode, "needs-host-firmware") &&
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
@@ -2481,6 +2665,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	phylink_late_phy_cancel(pl);
+
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
 	if (phy) {
@@ -3047,6 +3233,14 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 
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
@@ -3119,6 +3313,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 
 	ASSERT_RTNL();
 
+	/* Would configure the MAC alone, for a link that cannot come up. */
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev) {
 		struct ethtool_link_ksettings phy_kset = *kset;
 
@@ -3292,6 +3490,9 @@ int phylink_ethtool_nway_reset(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (pl->phydev)
 		ret = phy_restart_aneg(pl->phydev);
 	phylink_pcs_an_restart(pl);
@@ -3331,6 +3532,10 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 	if (pl->req_link_an_mode == MLO_AN_FIXED)
 		return -EOPNOTSUPP;
 
+	/* pl->supported still describes the MAC, so the test below passes. */
+	if (phylink_late_phy_pending(pl))
+		return -EOPNOTSUPP;
+
 	if (!phylink_test(pl->supported, Pause) &&
 	    !phylink_test(pl->supported, Asym_Pause))
 		return -EOPNOTSUPP;
@@ -3817,7 +4022,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	/* Attach the PHY so that the PHY is present when we do the major
 	 * configuration step.
 	 */
-	ret = phylink_attach_phy(pl, phy, config.interface);
+	ret = phylink_attach_phy(pl, phy, config.interface, 0);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 3a88a69882a6..6249156b51f1 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -147,6 +147,9 @@ enum phylink_op_type {
  * @default_an_inband: if true, defaults to MLO_AN_INBAND rather than
  *		       MLO_AN_PHY. A fixed-link specification will override.
  * @eee_rx_clk_stop_enable: if true, PHY can stop the receive clock during LPI
+ * @phy_may_probe_late: if true, a connect to a PHY marked needs-host-firmware
+ *			whose driver has not bound yet is deferred until that
+ *			driver binds; see phylink_fwnode_phy_connect().
  * @get_fixed_state: callback to execute to determine the fixed link state,
  *		     if MAC link is at %MLO_AN_FIXED mode.
  * @supported_interfaces: bitmap describing which PHY_INTERFACE_MODE_xxx
@@ -169,6 +172,7 @@ struct phylink_config {
 	bool mac_requires_rxc;
 	bool default_an_inband;
 	bool eee_rx_clk_stop_enable;
+	bool phy_may_probe_late;
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
-- 
2.53.0

