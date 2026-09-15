Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DFE3BB11B;
	Tue, 15 Sep 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477850; cv=none; b=NpeTndR7dONM9GVHDGi9gevXupYe3x1ZeC0NtRxt0t41dKNMtakWnW6jx9OqIKawgS9bzYqfPJthLdQviISlbPNxVH/bRGXKS3AAF3BE4FgJksGyI75IDjUMthvUBViZNn2UmPvShT6D5lc0LH6SyOAf1mx9MLuW9NDeJ9Be1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477850; c=relaxed/simple;
	bh=X0YEHUugXpL+EtwlTwrzsp8FSMEYhDmjaPr641OyUsE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/tRw50UvA76odPDSlCvby/hmUjKlr6wFAs6ITujV4tbx1zu6jZiDzELGYgQOxjp+QmfzAcW7uYpSZiGkgfji5Vig4vVY9Wud04HaeKl6vzm6iZ4000WEoO1RPvVL3g1jarDlG8HFIi9xRNZxVSafUUGLgcZ9ucSMqrPUjn28I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6Svo-000000000FZ-2sV3;
	Tue, 15 Sep 2026 13:10:40 +0000
Date: Tue, 15 Sep 2026 14:10:37 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v16 5/6] net: dsa: mxl862xx: recover switch stuck in
 MCUboot rescue mode
Message-ID: <1b6f092c5c93f34b6905e5f66f8498bdab6eeb23.1789477568.git.daniel@makrotopia.org>
References: <cover.1789477568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789477568.git.daniel@makrotopia.org>

A broken or interrupted firmware image, or the sticky rescue bit, keeps
the switch in its MCUboot bootloader, which exposes only the clause-22
SMDIO download interface. The clause-45 MMD API never comes up, so probe
would fail with -ETIMEDOUT and the only way back would be the switch's
UART console, or a power cycle or out-of-band reset (not currently
implemented).

Probe for the loader over SB PDI at setup, before any clause-45 access,
since nothing answers the firmware mailbox in MCUboot: every command
there runs into its own timeout, and probe gives up ten seconds later.
A scratch write to two mailbox registers first establishes
that a switch is there at all. It reaches a running firmware as well,
but lands in registers that firmware does not read, so it is inert
there. The status register the loader publishes then tells the cases
apart without touching C45: a running firmware, which answers with its
own non-zero status word (0x0003 on the firmware tested), so probe
continues normally; a loader idle in its console loop, confirmed live
by a register-read challenge; a loader wedged mid-download, which
publishes zero, or the count of the chunk it is programming or erasing
for once a failed clause-45 wait has ruled a firmware out; a loader
left in the opening handshake, waiting for an image header no later
session can supply; the flashless download loop, which this driver
cannot drive; and a switch whose scratch write does not latch --
absent, unpowered, misdescribed in the device tree (wrong address or
bus, or a reset GPIO with inverted polarity), or with its SB PDI window
somewhere other than the OTP reset offsets assumed here. The first four
enter rescue mode or normal operation, the last two fail probe at once
with -EOPNOTSUPP and -ENODEV, ahead of that timeout.

A loader that publishes the ready magic but never services the
register-read challenge fails probe too, with -ENXIO. The challenge is
what tells the loader apart from a firmware whose status word happens
to read the same value, and offering to flash a healthy firmware would
be worse than refusing to bind, so a mailbox that does not answer is
treated as unusable rather than as a flash target. Every loader tested
services it.

In rescue mode the switch registers without user interfaces so devlink
stays available: user ports fail port_setup with -ENODEV (the DSA core
re-registers them as unused) while shared and CPU ports succeed, and the
CPU port works on its fixed link with mac_select_pcs returning no PCS.
Firmware API commands fail fast with -ENODEV and the port and STP
callbacks become no-ops.

An interrupted download can leave the loader wedged mid-payload. A
background work item off the devlink flash path waits out an erase the
dead session left running, then drains the loader back to a clean ready
state by feeding the outstanding byte count one byte at a time, which
takes tens of minutes for a large image and is logged as it progresses;
until then devlink dev info reports no version and devlink dev flash
returns -EBUSY, and -EIO once a drain has failed for good.
Reaching the end of the count is all the drain does: the loader then
verifies the corrupt image and returns to its console loop on its own,
so the drain reprobes and lets the probe-time detection re-classify the
switch -- a valid image that a last-moment interruption left bootable
comes up as running firmware, with no second-guessing in the drain path.

The re-probe the drain schedules is the same device_schedule_reprobe()
hand-off the flash path uses: the core skips it if the device is
unbound or shut down before it fires, so a drain finishing after the
driver is gone does nothing. Should scheduling it fail, recovery is
marked failed, since the loader would otherwise sit at a clean ready
state that nothing reclassifies while devlink keeps promising that a
retry will work.

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
is detected again and the flash can be retried, unless the transfer
failed with the opening handshake already acknowledged, which leaves the
loader waiting for a header only a power cycle clears.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v16:
 - drop the claim that the clause-45 API floods the log with CRC errors
   when no firmware answers, here and in the comments. The mailbox
   commands run into their timeouts instead, and testing the
   stuck-in-MCUboot paths produces no such message. What probing SB PDI
   first saves is the ten seconds of polling and the -ETIMEDOUT that
   ends probe
 - move the rescue-mode branch of mxl862xx_setup() into a function of
   its own, which brings its messages back inside 100 columns
 - state a fact in the -EBUSY extack of a running recovery, dropping
   the retry advice
 - trim the comment on mxl862xx_rescue_drain(), whose protocol detail
   is in the file header already, and order its declarations longest
   line first
 - treat a byte count that outlives the settle step as a busy loader
   rather than a running firmware, and wait out an erase from the dead
   session before draining, so a host that died during the loader's
   erase no longer fails probe with the -ETIMEDOUT this patch exists to
   avoid (found by Sashiko AI review)
 - poll the status register every 10 ms rather than every 50 us for the
   waits now measured in minutes
 - drop the loader's clean ready state along with the cached identity
   when a flash fails, so devlink dev info stops reporting 0.0.0, which
   means "ready to accept an image", for a loader left mid transfer
   (found by Sashiko AI review)
 - state facts in the extack for a failed recovery; the remedies, which
   differ per cause, are in the documentation (found by Sashiko AI
   review)
 - name -ECANCELED in the documented return sets that can produce it,
   and the opening handshake among the detection outcomes in the commit
   message (found by Sashiko AI review)

v15:
 - classify a status register left in the download handshake as a loader
   needing a power cycle, rather than as a running firmware, which made
   probe fail with the CRC-error storm this patch avoids (found by
   Sashiko AI review)
 - give the loader one step to publish its next state when detection
   runs after a failed clause-45 wait, so the count of a chunk it is
   still programming is not read as a firmware status word (found by
   Sashiko AI review)
 - abort the drain polls as soon as teardown asks for it, instead of
   holding up unbind and shutdown for up to 17 s (found by Sashiko AI
   review)
 - pair the rescue_mode accesses with WRITE_ONCE()/READ_ONCE(), like the
   sibling rescue flags (found by Sashiko AI review)

v14:
 - initialise the SerDes state once mxl862xx_wait_ready() has cached
   the firmware version, still before the rescue-mode early return,
   so PCS setup can depend on the running firmware

v13: no changes

v12: no changes

v11:
 - schedule the post-drain re-probe with device_schedule_reprobe() too,
   instead of a driver-owned work item
 - a drain whose re-probe hand-off fails still marks recovery failed, so
   devlink does not keep promising a retry

v10:
 - share the SB PDI timeouts with the flash path: one constant for the
   verify wait (15 s) and one for a single 1-byte mailbox step (2 s),
   the latter also replacing the separate detection timeout. The
   last-slice flush gets the sum of the write and verify budgets, since
   it cannot see the boundary between programming and verifying (found
   by Sashiko AI review)
 - report a reprobe hand-off that cannot be set up after a successful
   drain, instead of leaving devlink answering "retry shortly" for good
   for a loader sitting at a clean READY (found by Sashiko AI review)
 - drop heal_lock and mxl862xx_stop_work() with it: making the flag test
   and the queueing atomic was never the guarantee its comment claimed,
   and the reprobe now decides for itself whether it may still run
   (found by Sashiko AI review)
 - return -ENXIO rather than a propagated -ETIMEDOUT when the loader
   never re-arms READY for the register-read challenge, and correct the
   documented return sets of mxl862xx_rescue_mode_detect() and
   mxl862xx_rescue_drain_finish() (found by Sashiko AI review)
 - explain why STAT == 0 during a drain is unambiguous: by the
   r_remain == 0 rule the loader cannot be both inside the receive loop
   asking for a chunk and publishing a verdict (found by Sashiko AI
   review)
 - commit message: a running firmware is not "left untouched", the
   presence probe writes two mailbox scratch registers which are inert
   to it; an SB PDI window away from the OTP reset offsets also yields
   -ENODEV; and describe the -ENXIO outcome for a READY loader that
   never services the challenge (found by Sashiko AI review)

v9: no changes

v8:
 - never send END from the drain: the loader keeps the host's byte count
   in its status register while it programs a chunk, so a lingering count
   cannot be told from the "image rejected" verdict, and END written into
   the receive loop is consumed as a 15555-byte count and underflows the
   receive counter. Wait for the loader to ask for the next chunk or to
   return to its console loop instead, since it finalises on its own
   (found by Sashiko AI review)
 - initialise the SerDes state before the rescue-mode early return, so
   the window between a successful rescue-mode flash clearing
   rescue_mode and the reprobe cannot hand phylink a PCS with no ops and
   an uninitialised mutex (found by Sashiko AI review)
 - do not fail probe when the 1-byte slice-advance leaves the wedged
   loader somewhere other than asking for the next chunk: a download
   interrupted with exactly one byte outstanding completes on that byte,
   after which the loader verifies and returns to its console loop
   (found by Sashiko AI review)
 - report a failed drain and refuse further flashes with -EIO and an
   extack asking for a power cycle, instead of leaving devlink to answer
   "retry shortly" forever for a switch that never becomes ready (found
   by Sashiko AI review)
 - reset the mailbox before the presence probe: a download interrupted
   with the write latch armed made the scratch write land in switch
   memory instead, so detection returned -ENODEV for the very state it
   exists to recover (found by Sashiko AI review)
 - tell an SMDIO bus error apart from a loader failing the register-read
   challenge, and check the reset issued after it (found by Sashiko AI
   review)
 - reject DSA links before the rescue-mode shortcut, so an unsupported
   cascade topology fails probe in rescue mode too (found by Sashiko AI
   review)
 - serialise the self-heal's reprobe hand-off against teardown with a
   mutex (found by Sashiko AI review)
 - log the drain's progress, name its timeouts, and describe its real
   duration (found by Sashiko AI review)
 - WRITE_ONCE() the rescue_ready stores, document what orders
   rescue_mode, and correct the detection kernel-doc and the note on the
   OTP-configurable SB PDI register offsets (found by Sashiko AI review)

v7:
 - queue the reprobe as a delayed work item from the background
   self-heal, following the previous patch's move off the reprobe
   kthread
 - report the rescue-mode firmware version under
   DEVLINK_INFO_VERSION_GENERIC_FW too
 - drop two redundant rescue-recovery log lines; the setup message
   ("switch in MCUboot with an interrupted download, recovering in
   background") already says it
 - return distinct errno from rescue_mode_detect() so an absent switch
   (-ENODEV), one strapped into flashless-download mode (-EOPNOTSUPP)
   and one that answers SB PDI READY but fails the register-read
   challenge, or wedges without draining (-ENXIO), are no longer all
   reported as -ENODEV

v6:
 - after the background drain finalises the interrupted transfer,
   reprobe and let the probe-time detection re-classify the switch, so
   a valid image a last-moment interruption left bootable is picked up
   as running firmware; rescue_drain() no longer inspects or reports
   the outcome (its stale kernel-doc claiming a "return 1" case is gone)
 - poll the drain status register with read_poll_timeout() as well,
   which evaluates the condition once more after the deadline, matching
   the poll fix in the previous patch
 - treat the flashless-download loop (STAT 0xc33c) as an unsupported
   configuration and fail probe with -ENODEV, rather than advertising it
   as flashable when the console flash path cannot drive it

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

 drivers/net/dsa/mxl862xx/mxl862xx-fw.c      | 491 +++++++++++++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h      |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c    |   8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         | 110 ++++-
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  20 +
 6 files changed, 605 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
index 139c14adf2d9..d001a884e6fc 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -29,9 +29,11 @@
  *
  * STAT magics:
  *   READY  0xc55c   loader idle in the console loop        (this driver)
+ *   DL_RDY 0xc33c   loader idle in the flashless loop
  *   START  0xf48f   host   -> begin download session
  *   ACK    0xf490   loader -> START acknowledged (START + 1)
  *   END    0x3cc3   host   -> finalise now (optional, see below)
+ *   RDREG  0xe2c0   host   -> register-read command (| index), see below
  *
  * Console flash path (STAT=0xc55c) - mxl862xx_flash_firmware():
  *
@@ -71,7 +73,40 @@
  *     - never send a slice/chunk count larger than what is outstanding;
  *     - a STAT write is a command only once the loader has left the loop;
  *     - the loader leaves the count in STAT while it programs the chunk, so
- *       a lingering count does not distinguish "busy" from "verdict".
+ *       a lingering count does not distinguish "busy" from "verdict";
+ *     - interrupted-download recovery feeds 1 byte at a time (see below).
+ *
+ * Interrupted-flash recovery (mxl862xx_rescue_drain):
+ *   A host that dies mid-payload leaves the loader in the receive loop holding
+ *   STAT=0. Feed single 1-byte chunks (one DATA word + STAT=1) until r_remain
+ *   reaches 0; the loader then verifies the (now corrupt) image, publishes its
+ *   verdict and comes back to READY by itself. END is never sent here: while
+ *   r_remain is non-zero it would be consumed as a 15555-byte count, and a
+ *   lingering STAT=1 cannot be told from a chunk still being programmed.
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
+ * Rescue lifecycle (devlink): probe runs mxl862xx_rescue_mode_detect(); a
+ * wedged loader is drained back to READY by a background self-heal
+ * (rescue_heal_work), so the long recovery never holds the devlink lock.
+ * devlink dev info exposes the fw version (the "flashable" signal) only once at
+ * READY; flash_update returns -EBUSY until then, and reprobes to WSP firmware
+ * on success.
+ *
+ * Notes:
+ *   - Chip id/revision (0xc0d28884/88) are NOT reachable on this channel; they
+ *     need the clause-45 MMD firmware mailbox, which is dead under MCUboot.
+ *     Rescue identity is by SB PDI behaviour only (mxl862xx_rescue_mode_detect).
+ *   - The SMDIO PHY address comes from the device tree; the 0xe1xx register
+ *     offsets are the OTP reset defaults and the only layout supported here.
  */
 
 #include <linux/crc32.h>
@@ -104,8 +139,15 @@
 
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
 
 /* Image verification verdict published in STAT once the receive loop ends */
 #define MXL862XX_SB_PDI_VERIFY_OK	0
@@ -124,6 +166,13 @@
 #define MXL862XX_FW_WRITE_TIMEOUT_MS	60000
 #define MXL862XX_FW_REBOOT_DELAY_MS	5000
 #define MXL862XX_FW_REPROBE_DELAY_MS	500
+/* One loader mailbox step: program a 1-byte chunk or service a command */
+#define MXL862XX_SB_PDI_STEP_MS		2000
+/* Covers the loader's END wait, verification and the reset into READY */
+#define MXL862XX_SB_PDI_VERIFY_MS	15000
+/* STAT poll intervals: a mailbox step is quick, an erase is not */
+#define MXL862XX_SB_PDI_POLL_US		50
+#define MXL862XX_SB_PDI_SLOW_POLL_US	10000
 
 static int mxl862xx_sb_pdi_reset(struct mxl862xx_priv *priv)
 {
@@ -193,7 +242,8 @@ static int mxl862xx_sb_pdi_flush_last(struct mxl862xx_priv *priv,
 
 	ret = read_poll_timeout(mxl862xx_smdio_read, val,
 				val < 0 || (u16)val != (u16)data_written,
-				10000, MXL862XX_FW_WRITE_TIMEOUT_MS * 1000,
+				10000, (MXL862XX_FW_WRITE_TIMEOUT_MS +
+					MXL862XX_SB_PDI_VERIFY_MS) * 1000,
 				false, priv, MXL862XX_SB_PDI_STAT);
 	if (val < 0)
 		return val;
@@ -219,6 +269,379 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
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
+/* Log the drain's progress every so many bytes; it can run for a long time */
+#define MXL862XX_DRAIN_LOG_BYTES	(128 * 1024)
+
+/* Wait for the loader to ask for the next chunk (STAT 0) or to come back to its
+ * command loop (STAT READY), and return the STAT value either way, or
+ * -ECANCELED once teardown asks the caller to stop. On timeout the value is
+ * whatever STAT still holds, which carries no further information: the
+ * loader keeps the count we wrote visible while it programs the chunk, and that
+ * is the same value it publishes as the "image rejected" verdict once the
+ * counter reaches zero.
+ *
+ * STAT 0 is unambiguous here even though it is also the "image verified"
+ * verdict: by the r_remain == 0 rule the loader leaves the receive loop the
+ * moment the counter reaches zero, so it is never both inside the loop asking
+ * for a chunk and publishing a verdict. Once it has left, the next STAT write
+ * is a command rather than a count, so feeding one more chunk after a verdict
+ * cannot underflow anything either.
+ */
+static int mxl862xx_sb_pdi_poll_drain(struct mxl862xx_priv *priv,
+				      unsigned long sleep_us,
+				      unsigned long timeout_ms)
+{
+	int val;
+
+	read_poll_timeout(mxl862xx_smdio_read, val,
+			  val < 0 || (u16)val == MXL862XX_SB_PDI_READY ||
+			  (u16)val == 0 ||
+			  test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags),
+			  sleep_us, timeout_ms * 1000, false,
+			  priv, MXL862XX_SB_PDI_STAT);
+	if (val < 0)
+		return val;
+	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		return -ECANCELED;
+	return (u16)val;
+}
+
+/* The loader is not asking for a chunk: it may still be programming the last
+ * one, or the counter has reached zero and it is verifying the image and
+ * resetting into READY. Before the first chunk it may also still be erasing
+ * for the session that died, which no verify window covers. Wait that out --
+ * STAT cannot tell the cases apart, and guessing would mean writing END into a
+ * live receive loop.
+ *
+ * Return: 0 once the loader has left the loop, -EAGAIN if it asks for another
+ * chunk after all, -EIO for a loader still holding the count when the window
+ * expires, -ECANCELED on teardown, or an SMDIO bus error.
+ */
+static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
+{
+	struct device *dev = &priv->mdiodev->dev;
+	int stat;
+
+	if (chunk)
+		stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
+						  MXL862XX_SB_PDI_VERIFY_MS);
+	else
+		stat = mxl862xx_sb_pdi_poll_drain(priv,
+						  MXL862XX_SB_PDI_SLOW_POLL_US,
+						  MXL862XX_FW_ERASE_TIMEOUT_MS);
+	if (stat < 0)
+		return stat;
+	if (stat == MXL862XX_SB_PDI_READY)
+		return 0;
+	if (stat == MXL862XX_SB_PDI_VERIFY_BAD) {
+		dev_err(dev,
+			"flash: loader stuck after %u chunks, power cycle it\n",
+			chunk);
+		return -EIO;
+	}
+	if (stat) {
+		if (!chunk) {
+			dev_err(dev,
+				"flash: loader still busy after the erase window\n");
+			return -EIO;
+		}
+		/* A firmware is answering, not the loader: an image survived
+		 * in flash and booted.
+		 */
+		dev_info(dev, "flash: firmware booted while draining\n");
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+/* Walk the loader's receive counter to zero (see the header): the image size
+ * died with the host, and a chunk larger than what is outstanding underflows
+ * the counter, so only single bytes are safe. Tens of minutes for a multi-MiB
+ * remainder. Returns 0 once the loader has left the receive loop, <0 on error;
+ * a counter an earlier oversized chunk underflowed needs a power cycle.
+ */
+static int mxl862xx_rescue_drain(struct mxl862xx_priv *priv)
+{
+	/* Bound: twice the loader's 16 MiB image cap, one byte per chunk. */
+	u32 max_chunks = 2u * (16u << 20) / MXL862XX_DRAIN_CHUNK_BYTES;
+	struct device *dev = &priv->mdiodev->dev;
+	u32 chunk = 0;
+	int ret, stat;
+
+	while (chunk < max_chunks) {
+		/* Teardown can interrupt this long drain. */
+		if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+			return -ECANCELED;
+
+		stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
+						  MXL862XX_SB_PDI_STEP_MS);
+		if (stat < 0)
+			return stat;
+		if (stat == MXL862XX_SB_PDI_READY)
+			return 0;
+
+		if (stat) {
+			ret = mxl862xx_rescue_drain_finish(priv, chunk);
+			if (ret != -EAGAIN)
+				return ret;
+		}
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
+		if (!(chunk % MXL862XX_DRAIN_LOG_BYTES))
+			dev_info(dev, "flash: drained %u KiB so far\n",
+				 chunk / 1024);
+		cond_resched();
+	}
+
+	dev_err(dev,
+		"flash: interrupted download did not drain after %u chunks\n",
+		chunk);
+
+	return -ETIMEDOUT;
+}
+
+/* Background self-heal: drain a wedged download off the devlink flash path, so
+ * the long recovery never holds the devlink lock. Scheduled from probe;
+ * reprobes on success so the probe-time detection re-classifies the switch.
+ */
+void mxl862xx_rescue_heal_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_priv *priv =
+		container_of(work, struct mxl862xx_priv, rescue_heal_work);
+	struct device *dev = &priv->mdiodev->dev;
+	int ret;
+
+	ret = mxl862xx_rescue_drain(priv);
+	if (ret == -ECANCELED)
+		return;
+	if (ret) {
+		/* Nothing retries this, so say so: rescue_ready stays clear
+		 * and devlink dev flash reports why it refuses.
+		 */
+		dev_err(dev, "flash: download recovery failed: %pe\n",
+			ERR_PTR(ret));
+		WRITE_ONCE(priv->rescue_failed, true);
+		return;
+	}
+
+	/* The interrupted transfer is finalised; reprobe so the probe-time
+	 * detection brings the driver up -- flashable in rescue mode if the
+	 * loader is at READY, or normally if a valid image booted. The core
+	 * skips the re-probe on its own if the device is unbound first; the
+	 * flag test only avoids scheduling one certain to be skipped. A
+	 * failed hand-off leaves nothing to reclassify the switch, so mark
+	 * recovery failed rather than promise a retry that cannot succeed.
+	 */
+	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		return;
+
+	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
+		WRITE_ONCE(priv->rescue_failed, true);
+}
+
+/* Detect MCUboot rescue mode over clause-22 SMDIO alone, so the caller can rule
+ * the loader out before any C45 API request (which only runs into its timeouts
+ * when no WSP firmware answers). A scratch write to ADDR/DATA must latch or the
+ * chip is absent (-ENODEV); the mailbox is reset first, or a transfer
+ * interrupted with CTRL=WR would take that write as a payload word instead of
+ * latching it. STAT then classifies the state, poked destructively only when 0,
+ * the one value a running firmware never holds:
+ *
+ *  - 0xc33c: flashless loop; recognised but not supported here.
+ *  - 0xc55c: console loop, if the register-read challenge is serviced.
+ *  - 0xf48f/0xf490: a download handshake nobody can finish; rescue, but only
+ *    a power cycle gets the loader out of it.
+ *  - other non-zero: running firmware, left unpoked. With @settle the loader
+ *    gets one step to publish 0 or READY first, and a count outliving that is
+ *    a busy loader, for a caller which has ruled a running firmware out.
+ *  - 0: wedged receive loop; the 1-byte slice-advance then says whether it
+ *    still needs draining or has just finished.
+ *
+ * The scratch write reaches a running firmware too, but lands in mailbox
+ * registers it does not read, so it is inert there.
+ *
+ * Return: MXL862XX_IN_RESCUE, MXL862XX_NOT_RESCUE, -ENODEV when the scratch
+ * write does not latch, which is a switch that does not answer at all or one
+ * whose SB PDI window is not at the offsets above, -EOPNOTSUPP for the
+ * flashless loop, -ENXIO for a READY loader whose mailbox fails the challenge,
+ * -ECANCELED when teardown interrupts a poll, or an SMDIO bus error.
+ */
+int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv, bool settle)
+{
+	int stat, dat, ret, rb, a, d;
+
+	/* rescue_ready gates flashing; a wedged loader needs the drain first. */
+	WRITE_ONCE(priv->rescue_ready, false);
+
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		return ret;
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
+	/* Flashless-download loop (MxL86281S tier): this driver does not
+	 * support it -- the console flash path expects READY. Treat it as an
+	 * unusable configuration, like any other unsupported state.
+	 */
+	if ((u16)stat == MXL862XX_SB_PDI_DL_READY)
+		return -EOPNOTSUPP;
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
+					       MXL862XX_SB_PDI_STEP_MS);
+		dat = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_DATA);
+		ret = mxl862xx_sb_pdi_reset(priv);
+		/* Never re-arming READY fails the challenge like any other
+		 * unserviced command; report it as such rather than as a bus
+		 * timeout the bus never saw.
+		 */
+		if (rb == -ETIMEDOUT)
+			rb = -ENXIO;
+		if (rb < 0)
+			return rb;
+		if (dat < 0)
+			return dat;
+		if (ret < 0)
+			return ret;
+		if ((u16)dat != MXL862XX_SB_PDI_RDREG_MARK) {
+			WRITE_ONCE(priv->rescue_ready, true);
+			return MXL862XX_IN_RESCUE;
+		}
+		/* READY but the marker is untouched, so nothing is servicing the
+		 * mailbox. A firmware publishing 0xc55c as its status word looks
+		 * exactly like this, and flashing one would be far worse than
+		 * refusing to bind, so treat it as unusable.
+		 */
+		return -ENXIO;
+	}
+
+	/* The download handshake lives in STAT too and outlives a mailbox
+	 * reset, so an aborted transfer leaves the loader waiting for a
+	 * header no later session can supply: only a power cycle clears it.
+	 */
+	if ((u16)stat == MXL862XX_SB_PDI_START ||
+	    (u16)stat == MXL862XX_SB_PDI_START + 1) {
+		WRITE_ONCE(priv->rescue_failed, true);
+		return MXL862XX_IN_RESCUE;
+	}
+
+	/* Any other non-zero value is a running firmware, not a loader -- but
+	 * the loader also holds the count of a chunk it is programming or
+	 * erasing for, so let a caller that has ruled the firmware out wait a
+	 * step for the next state; a count outliving that is that busy loader.
+	 */
+	if (stat) {
+		if (!settle)
+			return MXL862XX_NOT_RESCUE;
+
+		stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
+						  MXL862XX_SB_PDI_STEP_MS);
+		if (stat < 0)
+			return stat;
+		if (stat == MXL862XX_SB_PDI_READY) {
+			WRITE_ONCE(priv->rescue_ready, true);
+			return MXL862XX_IN_RESCUE;
+		}
+		if (stat)
+			return MXL862XX_IN_RESCUE;
+	}
+
+	/* STAT == 0: a wedged receive loop takes a 1-byte slice-advance (feed
+	 * one DATA word first, like a drain chunk) and asks for the next chunk
+	 * by publishing 0 again. Had that byte been the last one outstanding,
+	 * the loader leaves the loop instead and returns to READY, having
+	 * consumed the advance -- proof enough of a live mailbox to skip the
+	 * challenge. Anything else means it is still working on it. All three
+	 * are rescue, so this never fails probe; only the drain does.
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
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+				   MXL862XX_DRAIN_CHUNK_BYTES);
+	if (ret < 0)
+		return ret;
+
+	rb = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
+					MXL862XX_SB_PDI_STEP_MS);
+	if (rb < 0)
+		return rb;
+	if (rb == MXL862XX_SB_PDI_READY)
+		WRITE_ONCE(priv->rescue_ready, true);
+
+	return MXL862XX_IN_RESCUE;
+}
+
 /* MCUboot firmware image header */
 struct mxl862xx_fw_hdr {
 	__le32 image_type;
@@ -294,13 +717,15 @@ static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
 	int ret, i;
 
 	/* Step 1: reboot the firmware into MCUboot rescue mode */
-	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
-				false, false);
-	if (ret) {
-		dev_err(&priv->mdiodev->dev,
-			"flash: FW_UPDATE command failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
+	if (!READ_ONCE(priv->rescue_mode)) {
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
@@ -487,6 +912,25 @@ int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 	char buf[16];
 	int ret;
 
+	/* No chip-id/revision in MCUboot (needs the firmware MMD mailbox). The
+	 * fw version doubles as the "ready to flash" signal: report it only
+	 * once the loader is at a clean READY, nothing while still draining.
+	 */
+	if (READ_ONCE(priv->rescue_mode)) {
+		if (!READ_ONCE(priv->rescue_ready))
+			return 0;
+
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
+		ret = devlink_info_version_running_put(req,
+				DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+		if (ret)
+			return ret;
+		return devlink_info_version_stored_put(req,
+				DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+	}
+
 	/* A 0 part number means the CHIP ID read failed or the part is
 	 * unfused; omit it rather than publish a bogus "0000" that fwupd
 	 * would match firmware against -- it then falls back to the driver
@@ -565,9 +1009,27 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		return ret;
 	}
 
-	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
-		 priv->fw_version.major, priv->fw_version.minor,
-		 priv->fw_version.revision);
+	/* Refuse to flash while the background self-heal is still draining, and
+	 * for good once it has given up on the loader.
+	 */
+	if (READ_ONCE(priv->rescue_failed)) {
+		NL_SET_ERR_MSG_MOD(extack, "download recovery failed");
+		return -EIO;
+	}
+
+	if (READ_ONCE(priv->rescue_mode) && !READ_ONCE(priv->rescue_ready)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "switch is recovering an interrupted download");
+		return -EBUSY;
+	}
+
+	if (READ_ONCE(priv->rescue_mode))
+		dev_info(ds->dev,
+			 "flash: flashing switch via MCUboot rescue mode\n");
+	else
+		dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
 
 	/* Close ports while the firmware is still alive so the DSA core's
 	 * MDB/FDB tracking is drained, and detach user ports so userspace
@@ -614,6 +1076,7 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		 * readiness poll below read the freshly booted firmware.
 		 */
 		priv->flash_owner = current;
+		WRITE_ONCE(priv->rescue_mode, false);
 		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
 
 		/* Refresh the cached versions so the flash update only
@@ -630,11 +1093,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 	if (ret) {
 		/* The switch is in MCUboot with erased or partly written flash;
 		 * drop the cached identity so devlink dev info stops reporting
-		 * the pre-flash version until the reprobe re-reads the truth.
+		 * the pre-flash version until the reprobe re-reads the truth,
+		 * and with it the loader's clean READY state.
 		 */
 		memset(&priv->fw_version, 0, sizeof(priv->fw_version));
 		priv->asic_id = 0;
 		priv->asic_rev = 0;
+		WRITE_ONCE(priv->rescue_ready, false);
 	}
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
index 15ed3a46bcfe..02e5a627e947 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -6,7 +6,10 @@
 #include <net/dsa.h>
 
 struct mxl862xx_priv;
+struct work_struct;
 
+int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv, bool settle);
+void mxl862xx_rescue_heal_work_fn(struct work_struct *work);
 int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 			      struct devlink_info_req *req,
 			      struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 4b3956a518cf..694c22d2dd09 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -17,6 +17,7 @@
 #include <net/dsa.h>
 #include "mxl862xx.h"
 #include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -347,6 +348,11 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 		goto out;
 	}
 
+	if (priv->rescue_mode) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	/* During the post-flash readiness poll block_host stays set, but the
 	 * flash path's own firmware version reads must reach the new image;
 	 * host writes stay blocked so stale resource IDs cannot corrupt it.
@@ -558,9 +564,11 @@ int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val)
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
index b689652aa9b9..6fde3a58939d 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -406,6 +406,8 @@ mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
 
 	switch (port) {
 	case 9 ... 16:
+		if (READ_ONCE(priv->rescue_mode))
+			return NULL;
 		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84)) {
 			dev_warn_once(dp->ds->dev,
 				      "SerDes PCS unsupported on old firmware.\n");
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 5668aac9ef7a..d5e29fd74adb 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -667,27 +667,85 @@ static void mxl862xx_free_bridge(struct dsa_switch *ds,
 	priv->bridges[bridge->num] = 0;
 }
 
+static void mxl862xx_setup_rescue(struct dsa_switch *ds)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (priv->rescue_ready) {
+		dev_warn(ds->dev,
+			 "switch in MCUboot rescue mode, use devlink to flash new firmware\n");
+		return;
+	}
+
+	if (priv->rescue_failed) {
+		dev_warn(ds->dev,
+			 "switch in MCUboot with an unfinishable download, power cycle it\n");
+		return;
+	}
+
+	/* Drain the wedged download in the background so it never holds the
+	 * devlink lock; info and flash become available once ready.
+	 */
+	dev_warn(ds->dev,
+		 "switch in MCUboot with an interrupted download, recovering in background\n");
+	queue_work(system_long_wq, &priv->rescue_heal_work);
+}
+
 static int mxl862xx_setup(struct dsa_switch *ds)
 {
 	struct mxl862xx_priv *priv = ds->priv;
 	int n_user_ports = 0, max_vlans;
 	int ingress_finals, vid_rules;
 	struct dsa_port *dp;
-	int ret, i;
+	int ret, i, rescue;
 
-	ret = mxl862xx_reset(priv);
-	if (ret)
-		return ret;
+	/* Detect the loader over SB PDI first: it needs no firmware, unlike the
+	 * C45 API (mxl862xx_reset/wait_ready), which spends its whole 10 s
+	 * window on a mailbox nobody answers. Touch C45 only once rescue is
+	 * ruled out.
+	 */
+	rescue = mxl862xx_rescue_mode_detect(priv, false);
+	if (rescue < 0) {
+		dev_err(ds->dev, "switch state detection failed: %pe\n",
+			ERR_PTR(rescue));
+		return rescue;
+	}
 
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
+			rescue = mxl862xx_rescue_mode_detect(priv, true);
+			if (rescue < 0) {
+				dev_err(ds->dev,
+					"switch not responding after reset: %pe\n",
+					ERR_PTR(rescue));
+				return rescue;
+			}
+			if (rescue == MXL862XX_NOT_RESCUE)
+				return ret;
+		}
+	}
+
+	priv->rescue_mode = rescue;
 
+	/* Software-only SerDes state, needed before anything can reach phylink,
+	 * including a rescue-mode flash clearing rescue_mode ahead of reprobe.
+	 */
 	mutex_init(&priv->serdes_lock);
 	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
 		mxl862xx_setup_pcs(priv, &priv->serdes_ports[i],
 				   i + MXL862XX_FIRST_SERDES_PORT);
 
+	if (priv->rescue_mode) {
+		mxl862xx_setup_rescue(ds);
+		return 0;
+	}
+
 	/* Calculate Extended VLAN block sizes.
 	 * With VLAN Filter handling VID membership checks:
 	 *   Ingress: only final catchall rules (PVID insertion, 802.1Q
@@ -766,11 +824,21 @@ static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
 static int mxl862xx_port_enable(struct dsa_switch *ds, int port,
 				struct phy_device *phydev)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (READ_ONCE(priv->rescue_mode))
+		return 0;
+
 	return mxl862xx_port_state(ds, port, true);
 }
 
 static void mxl862xx_port_disable(struct dsa_switch *ds, int port)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (READ_ONCE(priv->rescue_mode))
+		return;
+
 	if (mxl862xx_port_state(ds, port, false))
 		dev_err(ds->dev, "failed to disable port %d\n", port);
 }
@@ -1388,6 +1456,17 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
 	bool is_cpu_port = dsa_port_is_cpu(dp);
 	int ret;
 
+	if (dsa_port_is_dsa(dp)) {
+		dev_err(ds->dev, "port %d: DSA links not supported\n", port);
+		return -EOPNOTSUPP;
+	}
+
+	/* DSA reinits failed user ports as unused; shared ports must
+	 * succeed for the tree to register.
+	 */
+	if (READ_ONCE(priv->rescue_mode))
+		return dsa_port_is_user(dp) ? -ENODEV : 0;
+
 	ret = mxl862xx_port_state(ds, port, false);
 	if (ret)
 		return ret;
@@ -1397,11 +1476,6 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
 	if (dsa_port_is_unused(dp))
 		return 0;
 
-	if (dsa_port_is_dsa(dp)) {
-		dev_err(ds->dev, "port %d: DSA links not supported\n", port);
-		return -EOPNOTSUPP;
-	}
-
 	ret = mxl862xx_configure_sp_tag_proto(ds, port, is_cpu_port);
 	if (ret)
 		return ret;
@@ -1623,11 +1697,12 @@ static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
 	ether_addr_copy(qparam.mac, mdb->addr);
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
-	/* Post-flash teardown: the firmware and its MAC table are gone, so
-	 * there is nothing left to delete. Outside it, -ENODEV is a bus error
-	 * and must be reported.
+	/* Post-flash teardown or MCUboot: the firmware and its MAC table are
+	 * gone, so there is nothing left to delete. Outside those, -ENODEV is a
+	 * bus error and must be reported.
 	 */
-	if (ret == -ENODEV && priv->skip_teardown)
+	if (ret == -ENODEV &&
+	    (priv->skip_teardown || READ_ONCE(priv->rescue_mode)))
 		return 0;
 	if (ret)
 		return ret;
@@ -1685,6 +1760,9 @@ static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
 	struct mxl862xx_priv *priv = ds->priv;
 	int ret;
 
+	if (READ_ONCE(priv->rescue_mode))
+		return;
+
 	switch (state) {
 	case BR_STATE_DISABLED:
 		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_DISABLE);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 2d38885ecfda..4ed2fd5cbca7 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -4,7 +4,9 @@
 #define __MXL862XX_H
 
 #include <asm/byteorder.h>
+#include <linux/bitops.h>
 #include <linux/mdio.h>
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
 
@@ -14,6 +16,10 @@ struct mxl862xx_priv;
 #define MXL862XX_FIRST_SERDES_PORT	9
 #define MXL862XX_SERDES_SLOTS		4
 
+/* mxl862xx_rescue_mode_detect() return codes (negative values are errors) */
+#define MXL862XX_NOT_RESCUE		0
+#define MXL862XX_IN_RESCUE		1
+
 #define MXL862XX_DEFAULT_BRIDGE		0
 #define MXL862XX_MAX_BRIDGES		48
 #define MXL862XX_MAX_BRIDGE_PORTS	128
@@ -332,6 +338,16 @@ struct mxl862xx_fw_version {
  * @shutting_down:      set under the devlink instance lock once ->shutdown()
  *                      has begun, so no flash starts while the system is
  *                      going down
+ * @rescue_mode:        switch is in MCUboot; firmware API commands fail fast,
+ *                      only clause-22 SMDIO works. Set from setup() before the
+ *                      switch is registered and cleared with WRITE_ONCE() under
+ *                      the MDIO bus lock for the benefit of mxl862xx_api_wrap();
+ *                      readers outside that lock use READ_ONCE().
+ * @rescue_ready:       (rescue_mode) loader is at a clean READY and will accept
+ *                      a flash; false while rescue_heal_work is draining
+ * @rescue_failed:      (rescue_mode) the self-heal gave up or cannot run; the
+ *                      loader needs a power cycle and no flash can be accepted
+ * @rescue_heal_work:   background self-heal draining a wedged download to READY
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -339,6 +355,7 @@ struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
 	struct work_struct crc_err_work;
+	struct work_struct rescue_heal_work;
 	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_fw_version fw_version;
@@ -356,6 +373,9 @@ struct mxl862xx_priv {
 	bool block_host;
 	bool skip_teardown;
 	bool shutting_down;
+	bool rescue_mode;
+	bool rescue_ready;
+	bool rescue_failed;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0
