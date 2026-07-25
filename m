Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6D299A87;
	Sat, 25 Jul 2026 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784945831; cv=none; b=ES0bE4jKzN0Luir4jy3ROj1QWnw14nyI3H24kZslvvO/2/SLxOOHgvqKsWNqGGLtDpLNbg6eZ3K4V4m9HmMcsN0FoHasHHFaIlZ8CoRrxbLjpo0D0FG4Q4JRfFl38GEtMPo7vyOB3+Y6h2Xpf6Aap0eyqBkRTDS0w/FdY56dDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784945831; c=relaxed/simple;
	bh=NshBbPYnSwCi13qNuwa5OujpwAwLeSIop0CsCTRU0vM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNM9Ii1gYLFIIzNpXSCT29+QcnrHFD/+4f7eejMyifBNwMLSe24nOxZ3gsPe7SizKZnj+OaGKgGyGUfujcRV//hAGVlwooG7jMpLUJnsKYxyI2YUEaIdkfp5n3EqOIeecbgoPSpUs2QNKw0M7uBC3LG3Kl2OlSce/2AhYtcwUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wnRwj-000000002kk-2y7q;
	Sat, 25 Jul 2026 02:17:01 +0000
Date: Sat, 25 Jul 2026 03:16:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/5] net: dsa: mxl862xx: recover switch stuck in
 MCUboot rescue mode
Message-ID: <f1621f3578126598009313fa21446045e522c062.1784945329.git.daniel@makrotopia.org>
References: <cover.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784945329.git.daniel@makrotopia.org>

A broken or interrupted firmware image, or the sticky rescue bit, keeps
the switch in its MCUboot bootloader, which exposes only the clause-22
SMDIO download interface. The clause-45 MMD API never comes up, so probe
would fail with -ETIMEDOUT and the only way back would be the switch's
UART console, or a power cycle or out-of-band reset (not currently
implemented).

Probe for the loader over SB PDI at setup, before any clause-45 access,
since the C45 API floods the log with CRC errors when no firmware
answers. The same probe tells three cases apart without touching C45: a
running firmware (probe continues normally), a switch in MCUboot (enter
rescue mode), and a switch that does not answer at all -- absent,
unpowered, or misdescribed in the device tree (wrong address or bus, or
a reset GPIO with inverted polarity) -- which fails probe cleanly with
-ENODEV instead of a CRC-error storm.

In rescue mode the switch registers without user interfaces so devlink
stays available: user ports fail port_setup with -ENODEV (the DSA core
re-registers them as unused) while shared and CPU ports succeed, and the
CPU port works on its fixed link with mac_select_pcs returning no PCS.
Firmware API commands fail fast with -ENODEV and the port and STP
callbacks become no-ops.

An interrupted download can leave the loader wedged mid-payload. It is
drained back to a clean ready state by feeding the outstanding byte
count, which can take minutes, so it runs from a background work item
off the devlink flash path; until it finishes, devlink dev info reports
no version and devlink dev flash returns -EBUSY.

The CHIP ID registers need a running firmware, so no asic.id/asic.rev is
reported in rescue mode. Once the loader is ready, devlink dev info
reports the null firmware version "0.0.0" as both running and stored:

  $ devlink dev info mdio_bus/mdio-bus:10
  mdio_bus/mdio-bus:10:
    driver mxl862xx
    versions:
        running:
          fw 0.0.0
        stored:
          fw 0.0.0

An operational switch never reports 0.0.0 (a released firmware's major
is non-zero), so version-comparing tools like fwupd offer every release
as an upgrade, recovering the switch through the regular flash flow,
matched on the driver name. The flash skips the FW_UPDATE command since
MCUboot is already waiting. A successful flash reboots the switch into
the new firmware and the reprobe then brings the driver up against it
normally; after a failed one the switch is still in MCUboot, rescue mode
is detected again, and the user can retry.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5:
 - detect the switch state from the value MCUboot publishes in the SB
   PDI STAT register (loader ready, wedged download, or running
   firmware), confirming a live console loader with a register-read
   challenge, instead of trusting a bare SMDIO scratch write
 - fail probe with -ENODEV over SB PDI when the switch does not respond
   at all -- absent, unpowered, or misdescribed in the device tree --
   instead of letting the clause-45 API flood the log with CRC errors
 - drain a wedged interrupted download back to a clean ready state from
   a background work item so the multi-minute recovery never holds the
   devlink instance lock, and refuse devlink dev info and flash until it
   is ready
 - report the null firmware version as the stored version too, matching
   the running/stored reporting of the previous patch
 - do not report asic.id/asic.rev in rescue mode as the CHIP ID
   registers are unreadable without firmware; recovery tools match on
   the driver name and the "0.0.0" version instead (follows the numeric
   asic.id change in the previous patch)
 - move the devlink documentation into its own patch

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

 drivers/net/dsa/mxl862xx/mxl862xx-fw.c      | 334 +++++++++++++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h      |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c    |   8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  67 +++-
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  12 +
 6 files changed, 408 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
index cde00e5583ee..d28ceb98cd56 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -27,9 +27,11 @@
  *
  * STAT magics:
  *   READY  0xc55c   loader idle in the console loop        (this driver)
+ *   DL_RDY 0xc33c   loader idle in the flashless loop
  *   START  0xf48f   host   -> begin download session
  *   ACK    0xf490   loader -> START acknowledged (START + 1)
  *   END    0x3cc3   host   -> end of transfer / finalise
+ *   RDREG  0xe2c0   host   -> register-read command (| index), see below
  *
  * Console flash path (STAT=0xc55c) - mxl862xx_flash_firmware():
  *
@@ -63,6 +65,36 @@
  *   EXACTLY 0. A count larger than r_remain underflows the 32-bit counter and
  *   wedges the loader until a power cycle. Hence:
  *     - never send a slice/chunk count larger than what is outstanding;
+ *     - interrupted-download recovery feeds 1 byte at a time (see below).
+ *
+ * Interrupted-flash recovery (mxl862xx_rescue_drain):
+ *   A host that dies mid-payload leaves the loader spinning in the slice loop
+ *   holding STAT=0 (no magic). Feed single 1-byte chunks (one DATA word +
+ *   STAT=1) until r_remain reaches 0, then STAT=END; the loader finalises the
+ *   (now corrupt) image and re-arms READY for a clean reflash.
+ *
+ * Register-read challenge (non-destructive liveness proof):
+ *   DATA := 0x7c23 (marker); STAT := 0xe2c0|idx
+ *     -> loader returns a runtime word in DATA and re-arms STAT=0xc55c.
+ *   The reply source is loader BSS, not a chip id; used only to prove a live
+ *   mailbox in mxl862xx_rescue_mode_detect().
+ *
+ * The other STAT ready magic, 0xc33c, marks the loader's flashless
+ * chip-to-chip download mode (MxL86281S 16-port tier); this driver does not
+ * use it.
+ *
+ * Rescue lifecycle (devlink): probe runs mxl862xx_rescue_mode_detect(); a wedged
+ * loader is drained back to READY by a background self-heal (rescue_heal_work) so
+ * the multi-minute recovery never holds the devlink lock. devlink dev info
+ * exposes the fw version (the "flashable" signal) only once at READY;
+ * flash_update returns -EBUSY until then, and reprobes to WSP firmware on success.
+ *
+ * Notes:
+ *   - Chip id/revision (0xc0d28884/88) are NOT reachable on this channel; they
+ *     need the clause-45 MMD firmware mailbox, which is dead under MCUboot.
+ *     Rescue identity is by SB PDI behaviour only (mxl862xx_rescue_mode_detect).
+ *   - The SMDIO PHY address and the 0xe1xx offsets are OTP-configurable; derive
+ *     them from the DT binding, do not assume fixed values.
  */
 
 #include <linux/crc32.h>
@@ -94,8 +126,15 @@
 
 /* SB PDI handshake magic (published/consumed via STAT) */
 #define MXL862XX_SB_PDI_READY		0xc55c	/* loader idle, console loop */
+#define MXL862XX_SB_PDI_DL_READY	0xc33c	/* loader idle, flashless loop */
 #define MXL862XX_SB_PDI_START		0xf48f
 #define MXL862XX_SB_PDI_END		0x3cc3
+#define MXL862XX_SB_PDI_RDREG		0xe2c0	/* register-read cmd (| index) */
+#define MXL862XX_SB_PDI_RDREG_MARK	0x7c23	/* marker placed in DATA for RDREG */
+
+/* Behavioural presence probe: two distinct 16-bit latches on ADDR/DATA. */
+#define MXL862XX_SB_PDI_PROBE_A		0x5a5a
+#define MXL862XX_SB_PDI_PROBE_D		0xa5a5
 
 /* Firmware transfer geometry */
 #define MXL862XX_FW_HDR_SIZE		20
@@ -110,6 +149,7 @@
 #define MXL862XX_FW_WRITE_TIMEOUT_MS	120000
 #define MXL862XX_FW_REBOOT_DELAY_MS	5000
 #define MXL862XX_FW_REPROBE_DELAY_MS	500
+#define MXL862XX_RESCUE_READY_TIMEOUT_MS 1000
 
 static int mxl862xx_sb_pdi_reset(struct mxl862xx_priv *priv)
 {
@@ -170,6 +210,242 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
 	devlink_flash_update_status_notify(dl, status, NULL, done, total);
 }
 
+/* Byte-count of each chunk fed to the loader during drain. It MUST be 1: the
+ * loader only lets us observe "counter == 0", never "counter < step", so any
+ * step > 1 can subtract past zero, underflow the 32-bit counter and wedge the
+ * loader for ~2^32 more bytes (a state only a power cycle clears). Stepping by
+ * 1 walks the counter through every value and is guaranteed to land on zero
+ * whatever its (possibly odd) start. A 1-byte chunk is a path the loader
+ * already handles: the normal transfer ends with a single trailing byte for
+ * odd-sized images (see Step 6).
+ */
+#define MXL862XX_DRAIN_CHUNK_BYTES	1
+
+/* Poll STAT while draining a stuck download: 0 means "feed the next chunk",
+ * READY means the loader left the receive loop and re-armed its command loop,
+ * anything else is a transient (the count being consumed) - BUSY past the
+ * window means the counter has hit zero and the loader is finalising.
+ */
+enum { MXL862XX_DRAIN_FEED, MXL862XX_DRAIN_READY, MXL862XX_DRAIN_BUSY };
+static int mxl862xx_sb_pdi_poll_drain(struct mxl862xx_priv *priv,
+				      unsigned long timeout_ms)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int ret;
+
+	do {
+		ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
+		if (ret < 0)
+			return ret;
+		if ((u16)ret == MXL862XX_SB_PDI_READY)
+			return MXL862XX_DRAIN_READY;
+		if ((u16)ret == 0)
+			return MXL862XX_DRAIN_FEED;
+		usleep_range(50, 150);
+	} while (time_before(jiffies, timeout));
+
+	return MXL862XX_DRAIN_BUSY;
+}
+
+/* Recover a switch whose SB PDI download was interrupted mid-transfer - the
+ * host died after MCUboot began erasing flash, whether it aborted mid erase or
+ * mid image-write, both end up in the same place: the payload receive loop.
+ * There the loader publishes STAT=0, waits for the host to write a byte-count
+ * to STAT, DMAs that many bytes and subtracts the count from a remaining-bytes
+ * counter, leaving the loop only when the counter reaches exactly zero. The
+ * image size died with the host, so we feed single-byte chunks (see
+ * MXL862XX_DRAIN_CHUNK_BYTES) to walk the counter to zero without underflow,
+ * then send END. The loader runs its (failed) checksum and either re-arms
+ * READY or, if a valid image survived in flash, boots it. Returns 0 when READY
+ * is reached (the caller can flash), 1 when the loader booted instead (the
+ * switch is recovered but the intended image was not written), <0 on error.
+ * Does NOT recover a counter already underflowed by an earlier oversized-chunk
+ * attempt - that needs a power cycle.
+ */
+static int mxl862xx_rescue_drain(struct mxl862xx_priv *priv)
+{
+	struct device *dev = &priv->mdiodev->dev;
+	/* Bound: twice the loader's 16 MiB image cap, one byte per chunk. */
+	u32 max_chunks = 2u * (16u << 20) / MXL862XX_DRAIN_CHUNK_BYTES;
+	u32 chunk = 0;
+	int ret;
+
+	dev_warn(dev, "flash: draining interrupted download\n");
+
+	while (chunk < max_chunks) {
+		/* Teardown can interrupt this minutes-long drain. */
+		if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+			return -ECANCELED;
+
+		ret = mxl862xx_sb_pdi_poll_drain(priv, 2000);
+		if (ret < 0)
+			return ret;
+		if (ret == MXL862XX_DRAIN_READY)
+			return 0;
+		if (ret == MXL862XX_DRAIN_BUSY)
+			break;
+
+		/* Feed one zero byte; reset cleared the write latch. */
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+					   MXL862XX_SB_PDI_CTRL_WR);
+		if (ret < 0)
+			return ret;
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, 0x0000);
+		if (ret < 0)
+			return ret;
+		ret = mxl862xx_sb_pdi_reset(priv);
+		if (ret < 0)
+			return ret;
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+					   MXL862XX_DRAIN_CHUNK_BYTES);
+		if (ret < 0)
+			return ret;
+		chunk++;
+		cond_resched();
+	}
+
+	if (chunk >= max_chunks) {
+		dev_err(dev,
+			"flash: interrupted download did not drain after %u chunks\n",
+			chunk);
+		return -ETIMEDOUT;
+	}
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+				   MXL862XX_SB_PDI_END);
+	if (ret < 0)
+		return ret;
+
+	return mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					 MXL862XX_FW_ACK_TIMEOUT_MS);
+}
+
+/* Background self-heal: drain a wedged download back to READY off the devlink
+ * flash path, so the minutes-long recovery never holds the devlink lock.
+ * Scheduled from probe; publishes rescue_ready on success.
+ */
+void mxl862xx_rescue_heal_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_priv *priv =
+		container_of(work, struct mxl862xx_priv, rescue_heal_work);
+	struct device *dev = &priv->mdiodev->dev;
+	int ret;
+
+	dev_info(dev, "recovering interrupted download in background\n");
+	ret = mxl862xx_rescue_drain(priv);
+	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		return;
+	if (!ret) {
+		WRITE_ONCE(priv->rescue_ready, true);
+		dev_info(dev, "recovery complete, ready to flash\n");
+	}
+}
+
+/* Detect MCUboot rescue mode over clause-22 SMDIO alone, so the caller can rule
+ * the loader out before any C45 API request (which spews CRC errors when no WSP
+ * firmware answers). A scratch write to ADDR/DATA must latch or the chip is
+ * absent (-ENODEV); STAT then classifies the state, poked destructively only
+ * when 0, the one value a running firmware never holds:
+ *
+ *  - 0xc33c: flashless loop, ready.
+ *  - 0xc55c: console loop, if the register-read challenge is serviced.
+ *  - other non-zero: running firmware, left unpoked.
+ *  - 0: wedged receive loop, if a 1-byte slice-advance drains back to 0.
+ *
+ * Return: MXL862XX_IN_RESCUE, MXL862XX_NOT_RESCUE, or negative (-ENODEV/SMDIO).
+ */
+int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv)
+{
+	int stat, dat, ret, rb, a, d;
+
+	/* rescue_ready gates flashing; a wedged loader needs the drain first. */
+	priv->rescue_ready = false;
+
+	/* Presence: a live chip latches the scratch write, an absent one floats. */
+	a = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
+				 MXL862XX_SB_PDI_PROBE_A);
+	if (a < 0)
+		return a;
+	d = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
+				 MXL862XX_SB_PDI_PROBE_D);
+	if (d < 0)
+		return d;
+	a = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_ADDR);
+	if (a < 0)
+		return a;
+	d = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_DATA);
+	if (d < 0)
+		return d;
+	if ((u16)a != MXL862XX_SB_PDI_PROBE_A ||
+	    (u16)d != MXL862XX_SB_PDI_PROBE_D)
+		return -ENODEV;
+
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		return ret;
+
+	stat = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
+	if (stat < 0)
+		return stat;
+
+	/* Flashless-download loop: unambiguous ready magic, leave it alone. */
+	if ((u16)stat == MXL862XX_SB_PDI_DL_READY) {
+		priv->rescue_ready = true;
+		return MXL862XX_IN_RESCUE;
+	}
+
+	/* Console loop at READY: confirm the live mailbox with the register-read
+	 * challenge (consumes the marker from DATA and re-arms READY).
+	 */
+	if ((u16)stat == MXL862XX_SB_PDI_READY) {
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
+					   MXL862XX_SB_PDI_RDREG_MARK);
+		if (ret < 0)
+			return ret;
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+					   MXL862XX_SB_PDI_RDREG);
+		if (ret < 0)
+			return ret;
+		rb = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					       MXL862XX_RESCUE_READY_TIMEOUT_MS);
+		dat = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_DATA);
+		if (dat < 0)
+			return dat;
+		mxl862xx_sb_pdi_reset(priv);
+		if (!rb && (u16)dat != MXL862XX_SB_PDI_RDREG_MARK) {
+			priv->rescue_ready = true;
+			return MXL862XX_IN_RESCUE;
+		}
+		return -ENODEV;
+	}
+
+	/* Any other non-zero value is a running firmware, not a loader. */
+	if (stat)
+		return MXL862XX_NOT_RESCUE;
+
+	/* STAT == 0: a wedged receive loop consumes a 1-byte slice-advance back
+	 * to 0 (feed one DATA word first, like a drain chunk).
+	 */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+				   MXL862XX_SB_PDI_CTRL_WR);
+	if (ret < 0)
+		return ret;
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, 0x0000);
+	if (ret < 0)
+		return ret;
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		return ret;
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT, 1);
+	if (ret < 0)
+		return ret;
+	rb = mxl862xx_sb_pdi_poll_stat(priv, 0, MXL862XX_RESCUE_READY_TIMEOUT_MS);
+	if (!rb)
+		return MXL862XX_IN_RESCUE;
+
+	return -ENODEV;
+}
+
 /* Post-flash reprobe. Runs from a self-contained heap work (not a kthread and
  * not the devlink caller's context): kthread_create() in the caller context
  * fails -EINTR if the devlink command was Ctrl-C'd, and schedule_work() cannot.
@@ -270,13 +546,15 @@ static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
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
 
 	/* Step 2: wait for bootloader ready */
@@ -449,6 +727,23 @@ int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 	char buf[16];
 	int ret;
 
+	/* No chip-id/revision in MCUboot (needs the firmware MMD mailbox). The
+	 * fw version doubles as the "ready to flash" signal: report it only
+	 * once the loader is at a clean READY, nothing while still draining.
+	 */
+	if (priv->rescue_mode) {
+		if (!READ_ONCE(priv->rescue_ready))
+			return 0;
+
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
+		ret = devlink_info_version_running_put(req, "fw", buf);
+		if (ret)
+			return ret;
+		return devlink_info_version_stored_put(req, "fw", buf);
+	}
+
 	snprintf(buf, sizeof(buf), "%04X", priv->asic_id);
 	ret = devlink_info_version_fixed_put(req,
 					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
@@ -496,6 +791,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		return ret;
 	}
 
+	/* Refuse to flash while the background self-heal is still draining. */
+	if (priv->rescue_mode && !READ_ONCE(priv->rescue_ready)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "switch is recovering an interrupted download, retry shortly");
+		return -EBUSY;
+	}
+
 	/* The references the reprobe work needs to restore normal operation
 	 * must be held before the switch is disturbed; the work itself is
 	 * scheduled only once the flash is done (see below).
@@ -505,9 +807,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 
 	get_device(ds->dev);
 
-	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
-		 priv->fw_version.major, priv->fw_version.minor,
-		 priv->fw_version.revision);
+	if (priv->rescue_mode)
+		dev_info(ds->dev,
+			 "flash: flashing switch via MCUboot rescue mode\n");
+	else
+		dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
 
 	/* Close ports while the firmware is still alive so the DSA
 	 * core's MDB/FDB tracking is drained, and detach user ports
@@ -544,7 +850,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 	if (ret)
 		NL_SET_ERR_MSG_MOD(extack, "firmware transfer failed");
 
-	/* The reprobe below re-reads and logs the new version. */
+	if (!ret) {
+		mutex_lock_nested(&priv->mdiodev->bus->mdio_lock,
+				  MDIO_MUTEX_NESTED);
+		priv->rescue_mode = false;
+		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+		/* The reprobe below re-reads and logs the new version. */
+	}
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
 	priv->skip_teardown = true;
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
index e96db19b2888..7cd87c7ad871 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -6,7 +6,10 @@
 #include <net/dsa.h>
 
 struct mxl862xx_priv;
+struct work_struct;
 
+int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv);
+void mxl862xx_rescue_heal_work_fn(struct work_struct *work);
 int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 			      struct devlink_info_req *req,
 			      struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 66b388eed0ce..2dbd074c0fe2 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -16,6 +16,7 @@
 #include <net/dsa.h>
 #include "mxl862xx.h"
 #include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -346,6 +347,11 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 		goto out;
 	}
 
+	if (priv->rescue_mode) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE) {
 		ret = -EBUSY;
 		goto out;
@@ -544,9 +550,11 @@ int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val)
 void mxl862xx_host_init(struct mxl862xx_priv *priv)
 {
 	INIT_WORK(&priv->crc_err_work, mxl862xx_crc_err_work_fn);
+	INIT_WORK(&priv->rescue_heal_work, mxl862xx_rescue_heal_work_fn);
 }
 
 void mxl862xx_host_shutdown(struct mxl862xx_priv *priv)
 {
 	cancel_work_sync(&priv->crc_err_work);
+	cancel_work_sync(&priv->rescue_heal_work);
 }
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
index 5d4a13beed1a..9ac668c13c9e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -664,15 +664,49 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	int n_user_ports = 0, max_vlans;
 	int ingress_finals, vid_rules;
 	struct dsa_port *dp;
-	int ret, i;
+	int ret, i, rescue;
 
-	ret = mxl862xx_reset(priv);
-	if (ret)
-		return ret;
+	/* Detect the loader over SB PDI first: it needs no firmware, unlike the
+	 * C45 API (mxl862xx_reset/wait_ready) which spews CRC errors when none
+	 * answers. Touch C45 only once rescue is ruled out.
+	 */
+	rescue = mxl862xx_rescue_mode_detect(priv);
+	if (rescue < 0)
+		return rescue;
 
-	ret = mxl862xx_wait_ready(ds);
-	if (ret)
-		return ret;
+	if (rescue == MXL862XX_NOT_RESCUE) {
+		ret = mxl862xx_reset(priv);
+		if (ret)
+			return ret;
+
+		ret = mxl862xx_wait_ready(ds);
+		if (ret) {
+			/* the reset may only now have triggered rescue mode */
+			rescue = mxl862xx_rescue_mode_detect(priv);
+			if (rescue < 0)
+				return rescue;
+			if (rescue == MXL862XX_NOT_RESCUE)
+				return ret;
+		}
+	}
+
+	priv->rescue_mode = rescue;
+
+	if (priv->rescue_mode) {
+		if (priv->rescue_ready) {
+			dev_warn(ds->dev,
+				 "switch in MCUboot rescue mode, use devlink to flash new firmware\n");
+		} else {
+			/* Drain the wedged download in the background so it
+			 * never holds the devlink lock; info and flash become
+			 * available once ready.
+			 */
+			dev_warn(ds->dev,
+				 "switch in MCUboot with an interrupted download, recovering in background\n");
+			queue_work(system_long_wq, &priv->rescue_heal_work);
+		}
+		return 0;
+	}
 
 	mutex_init(&priv->serdes_lock);
 	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
@@ -757,11 +791,21 @@ static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
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
@@ -1379,6 +1423,12 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
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
@@ -1675,6 +1725,9 @@ static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
 	struct mxl862xx_priv *priv = ds->priv;
 	int ret;
 
+	if (priv->rescue_mode)
+		return;
+
 	switch (state) {
 	case BR_STATE_DISABLED:
 		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_DISABLE);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 39535cd58706..72dc31cc2b62 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -14,6 +14,10 @@ struct mxl862xx_priv;
 #define MXL862XX_FIRST_SERDES_PORT	9
 #define MXL862XX_SERDES_SLOTS		4
 
+/* mxl862xx_rescue_mode_detect() return codes (negative values are errors) */
+#define MXL862XX_NOT_RESCUE		0
+#define MXL862XX_IN_RESCUE		1
+
 #define MXL862XX_DEFAULT_BRIDGE		0
 #define MXL862XX_MAX_BRIDGES		48
 #define MXL862XX_MAX_BRIDGE_PORTS	128
@@ -327,6 +331,11 @@ struct mxl862xx_fw_version {
  *                      during a firmware flash
  * @skip_teardown:      discard firmware API commands during the teardown
  *                      triggered by the post-flash reprobe
+ * @rescue_mode:        switch is in MCUboot; firmware API commands fail fast,
+ *                      only clause-22 SMDIO works
+ * @rescue_ready:       (rescue_mode) loader is at a clean READY and will accept
+ *                      a flash; false while rescue_heal_work is draining
+ * @rescue_heal_work:   background self-heal draining a wedged download to READY
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -334,6 +343,7 @@ struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
 	struct work_struct crc_err_work;
+	struct work_struct rescue_heal_work;
 	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_fw_version fw_version;
@@ -349,6 +359,8 @@ struct mxl862xx_priv {
 	u16 vf_block_size;
 	bool block_host;
 	bool skip_teardown;
+	bool rescue_mode;
+	bool rescue_ready;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0
