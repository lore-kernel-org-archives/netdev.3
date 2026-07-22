Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C92F532F;
	Wed, 22 Jul 2026 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678498; cv=none; b=a2KYRNmHq9bRthA2lx7/7dXguFKcuugJaSNbhxI6iE2EQukwhymcxbr4vrHHtMrpwnrAcMr7RYZwdHoH7cbUwQSMjhfGulmjM6FFCd7by6Iw//I0BbdTSOm3y66mhdY1eEkRESXEnvlv24c20MsOe0FSovjNWzh6sfIbbabSzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678498; c=relaxed/simple;
	bh=tSqeWAZIS+l75+mPxOypqCyuyYqRs8RDFWKXADvnFxY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usdNFJv4qkVlHPBnMZEk0BttWxFlGYcR3LFIv5nXMTFGcJTgBfxBF89tcEjX9RUwaVOzd08nlRXNAUvNbEuXmHfGywuBaV/r2BFdpGvkPk6yk+PZjkr76b6804Kkfia/5JCriL9Gv+iQYcs+Pxe9uUbt260U1gRxeUWrPKuBlGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wmKOw-000000000dK-0PS5;
	Wed, 22 Jul 2026 00:01:30 +0000
Date: Wed, 22 Jul 2026 01:01:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 4/4] net: dsa: mxl862xx: recover switch stuck in
 MCUboot rescue mode
Message-ID: <67171f553478c82d8299712879adedf35986016d.1784665017.git.daniel@makrotopia.org>
References: <cover.1784665017.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784665017.git.daniel@makrotopia.org>

When the application firmware image is broken (e.g. after an
interrupted flash update) or the sticky rescue flag is set, the
switch stays in MCUboot which only exposes the clause-22 SMDIO
interface used for firmware download. The clause-45 MMD API never
becomes ready, probe fails with -ETIMEDOUT and the user is left
without any way to install a working firmware image other than
physical access to the UART console of the switch.

Detect this state during setup by reading the SB PDI STAT register
via SMDIO: MCUboot signals readiness for a firmware download with
the ready magic. Probe this register first to avoid pointlessly
waiting for the MMD API on a switch sitting in rescue mode, and
probe it again after a ready timeout to catch firmware which was
still alive enough to accept the reset command but then fell into
rescue mode due to a broken image on flash. An SMDIO bus error
during detection logs its own diagnostic, distinct from the MMD
ready timeout on a live bus, and counts as not in rescue mode.

In rescue mode, complete the switch registration without any user
interfaces so that devlink is available: user ports fail port_setup
with -ENODEV which makes the DSA core re-register them as unused
ports, while shared and unused ports succeed as their setup must not
fail for the tree to register. The CPU port works without firmware
access since it uses a fixed link and the phylink MAC ops do not
touch the hardware; mac_select_pcs returns no PCS in rescue mode.
Firmware API commands fail fast with -ENODEV instead of running
into the MDIO poll timeout, and the port enable/disable and STP
callbacks invoked by the DSA core during registration and teardown
become no-ops.

devlink dev info reports the running firmware version as the
canonical null version "0.0.0" in rescue mode. An operational switch
can never report this version since the major version of any
released firmware is non-zero. Version-comparing update tools like
fwupd thus treat every available release as an upgrade and offer to
install it, so the switch can be recovered through the regular
update flow. devlink flash update skips the FW_UPDATE command in
rescue mode as MCUboot is already waiting for a download, and
proceeds directly with the SB PDI handshake. After a successful
transfer the usual reprobe cycle restores normal operation; after a
failed one rescue mode is detected again and the user can simply
retry.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 - log a distinct diagnostic when rescue mode detection fails on an
   SMDIO bus error instead of silently treating it as "not in
   rescue mode"
 - clear the rescue_mode flag under the MDIO bus lock, following
   the flag write locking in the previous patch

v3:
 - report the canonical null version "0.0.0" instead of
   "mcuboot-rescue" so that version-comparing update tools like
   fwupd offer any available release as an upgrade for recovery
 - check the rescue_mode flag under the MDIO bus lock, following
   the block_host/skip_teardown change in the previous patch

v2: new patch, allowing recovery from a failed or interrupted update
    without having to use a special recovery OS image (Andrew Lunn)

 drivers/net/dsa/mxl862xx/mxl862xx-fw.c      | 58 +++++++++++++++++----
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h      |  3 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.c    |  5 ++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c |  2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         | 38 ++++++++++++--
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  3 ++
 6 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
index 4cd8231c7eca..a3f941580852 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -111,6 +111,29 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
 	devlink_flash_update_status_notify(dl, status, NULL, done, total);
 }
 
+/**
+ * mxl862xx_rescue_mode_detect - check whether the switch sits in MCUboot
+ * @priv: driver private data
+ *
+ * MCUboot signals readiness for a firmware download with the SB PDI
+ * ready magic; only the clause-22 SMDIO interface works in this state.
+ *
+ * Return: true if MCUboot is waiting for a firmware download.
+ */
+bool mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv)
+{
+	int ret;
+
+	ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
+	if (ret < 0) {
+		dev_err(&priv->mdiodev->dev,
+			"rescue mode detection failed: %pe\n", ERR_PTR(ret));
+		return false;
+	}
+
+	return ret == MXL862XX_SB_PDI_READY;
+}
+
 /* device_reprobe() -> remove() frees priv while the thread runs, so
  * the thread must not dereference priv; it drops its module reference
  * without returning to module code afterwards.
@@ -201,13 +224,15 @@ static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
 	int ret, i;
 
 	/* Step 1: reboot the firmware into MCUboot rescue mode */
-	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
-				false, false);
-	if (ret) {
-		dev_err(&priv->mdiodev->dev,
-			"flash: FW_UPDATE command failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
+	if (!priv->rescue_mode) {
+		ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
+					false, false);
+		if (ret) {
+			dev_err(&priv->mdiodev->dev,
+				"flash: FW_UPDATE command failed: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
 	}
 
 	/* Failures from here on must go through end_magic so MCUboot
@@ -391,6 +416,10 @@ int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 			return ret;
 	}
 
+	/* canonical null version: no operational firmware on the switch */
+	if (priv->rescue_mode)
+		return devlink_info_version_running_put(req, "fw", "0.0.0");
+
 	snprintf(ver_str, sizeof(ver_str), "%u.%u.%u",
 		 priv->fw_version.major, priv->fw_version.minor,
 		 priv->fw_version.revision);
@@ -436,9 +465,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 
 	get_device(ds->dev);
 
-	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
-		 priv->fw_version.major, priv->fw_version.minor,
-		 priv->fw_version.revision);
+	if (priv->rescue_mode)
+		dev_info(ds->dev,
+			 "flash: recovering switch from MCUboot rescue mode\n");
+	else
+		dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
 
 	/* Close ports while the firmware is still alive so the DSA
 	 * core's MDB/FDB tracking is drained, and detach user ports
@@ -476,6 +509,11 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		NL_SET_ERR_MSG_MOD(extack, "firmware transfer failed");
 
 	if (!ret) {
+		mutex_lock_nested(&priv->mdiodev->bus->mdio_lock,
+				  MDIO_MUTEX_NESTED);
+		priv->rescue_mode = false;
+		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
 		/* SYS_MISC_FW_VERSION is exempt from block_host, so the
 		 * new version can be queried with the block still up.
 		 */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
index a1b60fbacebf..57c2000cfee5 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -5,6 +5,9 @@
 
 #include <net/dsa.h>
 
+struct mxl862xx_priv;
+
+bool mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv);
 int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 			      struct devlink_info_req *req,
 			      struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 2b69eac24b31..4c61820f05ee 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -346,6 +346,11 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 		goto out;
 	}
 
+	if (priv->rescue_mode) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE &&
 	    cmd != SYS_MISC_FW_VERSION) {
 		ret = -EBUSY;
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
index b689652aa9b9..a5b6940b552e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -406,6 +406,8 @@ mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
 
 	switch (port) {
 	case 9 ... 16:
+		if (priv->rescue_mode)
+			return NULL;
 		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84)) {
 			dev_warn_once(dp->ds->dev,
 				      "SerDes PCS unsupported on old firmware.\n");
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index bf0f2264a931..7a2ea580e6f0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -629,9 +629,22 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	ret = mxl862xx_wait_ready(ds);
-	if (ret)
-		return ret;
+	priv->rescue_mode = mxl862xx_rescue_mode_detect(priv);
+	if (!priv->rescue_mode) {
+		ret = mxl862xx_wait_ready(ds);
+		if (ret) {
+			/* the reset may only now have triggered rescue mode */
+			priv->rescue_mode = mxl862xx_rescue_mode_detect(priv);
+			if (!priv->rescue_mode)
+				return ret;
+		}
+	}
+
+	if (priv->rescue_mode) {
+		dev_warn(ds->dev,
+			 "switch stuck in MCUboot rescue mode, use devlink to flash new firmware\n");
+		return 0;
+	}
 
 	mutex_init(&priv->serdes_lock);
 	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
@@ -716,11 +729,21 @@ static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
 static int mxl862xx_port_enable(struct dsa_switch *ds, int port,
 				struct phy_device *phydev)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (priv->rescue_mode)
+		return 0;
+
 	return mxl862xx_port_state(ds, port, true);
 }
 
 static void mxl862xx_port_disable(struct dsa_switch *ds, int port)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (priv->rescue_mode)
+		return;
+
 	if (mxl862xx_port_state(ds, port, false))
 		dev_err(ds->dev, "failed to disable port %d\n", port);
 }
@@ -1338,6 +1361,12 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
 	bool is_cpu_port = dsa_port_is_cpu(dp);
 	int ret;
 
+	/* DSA reinits failed user ports as unused; shared ports must
+	 * succeed for the tree to register.
+	 */
+	if (priv->rescue_mode)
+		return dsa_port_is_user(dp) ? -ENODEV : 0;
+
 	ret = mxl862xx_port_state(ds, port, false);
 	if (ret)
 		return ret;
@@ -1634,6 +1663,9 @@ static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
 	struct mxl862xx_priv *priv = ds->priv;
 	int ret;
 
+	if (priv->rescue_mode)
+		return;
+
 	switch (state) {
 	case BR_STATE_DISABLED:
 		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_DISABLE);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 64d91ad51936..5d21296561e3 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -323,6 +323,8 @@ struct mxl862xx_fw_version {
  *                      during a firmware flash
  * @skip_teardown:      discard firmware API commands during the teardown
  *                      triggered by the post-flash reprobe
+ * @rescue_mode:        switch is stuck in MCUboot; firmware API commands
+ *                      fail fast, only clause-22 SMDIO works
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -343,6 +345,7 @@ struct mxl862xx_priv {
 	u16 vf_block_size;
 	bool block_host;
 	bool skip_teardown;
+	bool rescue_mode;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0
