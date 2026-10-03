Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019A43B498;
	Sat,  3 Oct 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042828; cv=none; b=tBYUbhxIxgv88CIZm4Snnt6S8bZiB2QpnQA4m+KbkoMnRbn3FARuLRVooSRV4KTqN1d9qUECcg6DqUNnYqYDcjShY/ns3l2H5As33/x+N9tJcWstuEcOKt5wlrCRjcPf21a93fYttCVOu63NLFi1EcC250mLNaM3wa2/1MZoqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042828; c=relaxed/simple;
	bh=LVfSoBGUbgPjXFdP9yWpGFr37Tu/FVplZwmxNCv2UDM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5mJA8L9cgPUo4wwXlSMbrUHO7RZ6t+Pw3LMk/0fv+sjGoCGjcQCtWaA/gFN2hvvj8xt4hSCk5951va6AXxnbIX7ZCF2XJinJDqEEjVziGcsbP4MVKWVHyuoEgSb0yMIpQ+/TREsuqI1UlC3bs6K6mh1X5IEJv5vhhlAldJLWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD23N-000000001Ic-2cjy;
	Sat, 03 Oct 2026 15:53:37 +0000
Date: Sat, 3 Oct 2026 16:53:34 +0100
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
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v19 5/6] net: dsa: mxl862xx: recover switch stuck in
 MCUboot rescue mode
Message-ID: <dd243fa0df46b0cee4caf155b0388ea1702853ba.1791035885.git.daniel@makrotopia.org>
References: <cover.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791035885.git.daniel@makrotopia.org>

A broken or interrupted firmware image, or the sticky rescue bit, keeps
the switch in its MCUboot loader, which exposes only the clause-22 SMDIO
download interface. The clause-45 firmware API never comes up there, so
an ordinary probe would spend its whole timeout on a mailbox nothing
answers before failing.

Detect the loader over SB PDI at setup, ahead of any clause-45 access.
The mailbox is reset and a scratch write to it must latch, or the
switch is absent or has its SB PDI window elsewhere (-ENODEV); the
status word then names the state. A console loader is confirmed with a
register-read challenge, which only the loader's command loop services
by re-arming its ready word, and refused with -ENXIO when the challenge
goes unserviced. The loader's flashless download loop is unsupported
(-EOPNOTSUPP), an interrupted opening handshake is rescue that only a
power cycle clears, and a zero byte count is a receive loop wedged
mid-payload. A running firmware holds any other value and sees nothing
but the mailbox resets and scratch writes, which land in registers it
never reads.

In rescue mode register the switch without user interfaces so devlink
stays available to reflash it: the user ports fail setup and the DSA
core re-registers them as unused, while the shared and CPU ports come
up, the CPU port on its fixed link. devlink dev info then reports the
running firmware version as "0.0.0", which no released firmware carries,
so fwupd offers every release as an upgrade and recovers the switch
through the regular flash flow; no stored version is reported, since
what the flash holds is unknown in the loader.

An interrupted download can leave the loader wedged mid-payload with an
outstanding byte count. A background work item off the devlink flash
path drains it back to a clean ready state by feeding that count one
byte at a time, since a larger step could underflow the loader's counter
and wedge it until a power cycle, then re-probes so the probe-time
detection reclassifies the switch. Until it finishes, devlink dev info
reports no version and devlink dev flash returns -EBUSY. A loader left
in its opening handshake, a drain that fails and a re-probe that cannot
be scheduled are final for the binding: devlink dev flash then returns
-EIO. A probe that
meets the loader while it still erases for a session that died runs the
clause-45 readiness poll against it, and every poll fails its CRC check
there. The poll's reads are quiet ones, issued in the knowledge that a
switch in its loader or still coming out of reset may not answer, so a
quiet command leaves the CRC-error work alone; only a command against a
firmware believed to be running arms it. mxl862xx_api_wrap() recognises
the CRC codes at its exit, whichever step reported them, so the data
transfer steps cannot pass a firmware CRC code up raw; the host's own
verdict is a code outside the firmware's result range, so no firmware
errno can be taken for it.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v19:
 - recognise the firmware's CRC codes at the exit of mxl862xx_api_wrap()
   whichever step reported them, so the data transfer steps no longer
   pass them up raw, and give the host's own verdict a code outside the
   firmware's result range, which -EBADMSG was not; the command log
   keeps the code as reported (found by Sashiko AI review and a local
   review)
 - count rescue mode among the gates mxl862xx_api_gated() reports, so an
   unprivileged ethtool -S on the conduit stays silent in rescue mode
   (found by a local review)
 - treat -EINVAL from the self-heal's re-probe request as the device
   deletion it is, which ends the work anyway (found by a local review)
 - extack of a switch that cannot be flashed from its binding and the
   probe-time messages for an unusable switch state name what happened,
   and the command log names the host's own CRC verdict as such (found
   by a local review)
 - return a bus error of the reset closing the register-read challenge
   as such, which -ENXIO hid when the poll had also expired (found by a
   local review)
 - commit message: the three states that are final for the binding
   (found by a local review)
 - confirm READY with the register-read challenge after the settle step
   too, and judge the challenge by the re-armed ready word alone: the
   key the loader expects in DATA could collide with the word it returns
   there (found by Sashiko AI review)
 - return an SMDIO bus timeout during the challenge as the bus error it
   is; only an unserviced challenge is -ENXIO (found by Sashiko AI
   review)
 - drop the "firmware booted while draining" outcome of the drain's
   finish: the drained image's zero fill fails the loader's CRC gate, so
   any count outliving the window is a stuck loader (found by Sashiko AI
   review)
 - log a self-heal re-probe that cannot be scheduled (found by Sashiko
   AI review)
 - set WORK_STOPPED before waiting out a flash in .remove() and
   ->shutdown(), so the drain stops as early as possible (found by
   Sashiko AI review)
 - drop the rescue-mode disjunct from port_mdb_add() and port_mdb_del():
   no user netdev exists in rescue mode to reach them (found by Sashiko
   AI review)
 - the final slice's verification window moves to the previous patch
 - name the power cycle in the probe-time handshake message and the
   devlink documentation without its path in the kernel-doc, since the
   next patch adds it (found by Sashiko AI review)
 - commit message: name every detection outcome and the mailbox resets,
   and the CRC mapping (found by Sashiko AI review)
 - comments: state the drain's bound as what it is, the settle step's
   classification as the policy it is, and every cause of -EIO in the
   file header (found by Sashiko AI review and a local review)
v18:
 - a quiet firmware command, as the readiness poll issues, does not arm
   the CRC-error work: a probe that meets the loader mid-erase fails
   every poll's CRC check, which closed the conduit and warned on each
   of them; the CRC sites report -EBADMSG and mxl862xx_api_wrap() arms
   the work in one place
 - after a failed clause-45 wait, classify a status word that outlives
   the settle step as rescue only when it is the erase count of the
   session that died; any other value is a firmware that answered the
   reset without becoming ready, and probe fails with the wait error as
   it did before this patch (found by Sashiko AI review)
 - report the rescue-mode version as running only; the driver cannot
   tell what the flash holds (found by Sashiko AI review)
 - name the interrupted opening handshake in the probe-time log message,
   the only failure known at that point, and word the -EIO extack for
   every cause (found by Sashiko AI review)
 - port_mdb_add()/port_mdb_del(): rescue mode joins the flags under
   which a gated read counts as success, in the form of the previous
   patch, whose silent get_ethtool_stats() return covers rescue mode as
   well (found by Sashiko AI review)
 - kernel-doc: WORK_STOPPED also ends the drain and its reprobe
   hand-off; the file header names the -EIO state (found by Sashiko AI
   review)
 - commit message: describe the detection outcomes again (found by
   Sashiko AI review)
v17:
 - bypass the firmware-version gate in mxl862xx_phylink_get_caps() in
   rescue mode, so a SerDes CPU port does not get an empty
   supported_interfaces mask and fail phylink_create(); the sibling
   mac_select_pcs() bypass was already there (found by Sashiko AI review)
 - extend the port_mdb_add()/port_mdb_del() flash-window tolerance to
   rescue mode as well (found by Sashiko AI review)
 - the @rescue_failed kernel-doc and the mxl862xx_setup_rescue() log
   message no longer prescribe a power cycle for every cause; the
   per-cause remedy is in the documentation (found by Sashiko AI review)
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

 drivers/net/dsa/mxl862xx/mxl862xx-fw.c      | 501 +++++++++++++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h      |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c    |  73 +--
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c |   9 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c         | 108 ++++-
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  25 +-
 6 files changed, 663 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
index eae7048707870..eb48fbf7c7115 100644
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
@@ -73,7 +75,41 @@
  *     - the loader leaves the count in STAT while it programs the chunk, so
  *       a lingering count does not distinguish "busy" from "verdict";
  *     - STAT is a 16-bit register, so a slice holds at most 65535 bytes,
- *       which is what bounds MXL862XX_FW_BANK_SLICE.
+ *       which is what bounds MXL862XX_FW_BANK_SLICE;
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
+ *   DATA := 0x7c23 (key); STAT := 0xe2c0|idx
+ *     -> loader returns a runtime word in DATA and re-arms STAT=0xc55c.
+ *   Only the re-arm counts, to prove a live mailbox in
+ *   mxl862xx_rescue_mode_detect(); the word is loader BSS, not a chip id.
+ *
+ * The other STAT ready magic, 0xc33c, marks the loader's flashless
+ * chip-to-chip download mode (MxL86281S 16-port tier); this driver does not
+ * use it.
+ *
+ * Rescue lifecycle (devlink): probe runs mxl862xx_rescue_mode_detect(); a
+ * wedged loader is drained back to READY by a background self-heal
+ * (rescue_heal_work), so the long recovery never holds the devlink lock.
+ * devlink dev info exposes the fw version (the "flashable" signal) only once at
+ * READY; flash_update returns -EBUSY until then, -EIO for good once the
+ * loader cannot accept a download (a failed recovery, or a handshake no
+ * session can finish), and reprobes to WSP firmware on success.
+ *
+ * Notes:
+ *   - Chip id/revision (0xc0d28884/88) are NOT reachable on this channel; they
+ *     need the clause-45 MMD firmware mailbox, which is dead under MCUboot.
+ *     Rescue identity is by SB PDI behaviour only (mxl862xx_rescue_mode_detect).
+ *   - The SMDIO PHY address comes from the device tree; the 0xe1xx register
+ *     offsets are the OTP reset defaults and the only layout supported here.
  */
 
 #include <linux/crc32.h>
@@ -106,8 +142,15 @@
 
 /* SB PDI handshake magic (published/consumed via STAT) */
 #define MXL862XX_SB_PDI_READY		0xc55c	/* loader idle, console loop */
+#define MXL862XX_SB_PDI_DL_READY	0xc33c	/* loader idle, flashless loop */
 #define MXL862XX_SB_PDI_START		0xf48f
 #define MXL862XX_SB_PDI_END		0x3cc3
+#define MXL862XX_SB_PDI_RDREG		0xe2c0	/* register-read cmd (| index) */
+#define MXL862XX_SB_PDI_RDREG_MARK	0x7c23	/* key the loader expects in DATA */
+
+/* Behavioural presence probe: two distinct 16-bit latches on ADDR/DATA. */
+#define MXL862XX_SB_PDI_PROBE_A		0x5a5a
+#define MXL862XX_SB_PDI_PROBE_D		0xa5a5
 
 /* Image verification verdict published in STAT once the receive loop ends */
 #define MXL862XX_SB_PDI_VERIFY_OK	0
@@ -126,6 +169,11 @@
 #define MXL862XX_FW_WRITE_TIMEOUT_MS	60000
 /* Covers the loader's END wait, verification and the reset into READY */
 #define MXL862XX_SB_PDI_VERIFY_MS	15000
+/* One loader mailbox step: program a 1-byte chunk or service a command */
+#define MXL862XX_SB_PDI_STEP_MS		2000
+/* STAT poll intervals: a mailbox step is quick, an erase is not */
+#define MXL862XX_SB_PDI_POLL_US		50
+#define MXL862XX_SB_PDI_SLOW_POLL_US	10000
 
 /* Delays spent in full: the reboot into the new image, and the re-probe */
 #define MXL862XX_FW_REBOOT_DELAY_MS	5000
@@ -225,6 +273,395 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
 	devlink_flash_update_status_notify(dl, status, NULL, done, total);
 }
 
+/* Byte-count of each chunk fed to the loader during drain. It MUST be 1: the
+ * loader only lets us observe "counter == 0", never "counter < step", so any
+ * step > 1 can subtract past zero, underflow the 32-bit counter and wedge the
+ * loader for ~2^32 more bytes (a state only a power cycle clears). Stepping by
+ * 1 walks the counter through every value and is guaranteed to land on zero
+ * whatever its (possibly odd) start; the loader counts bytes, not words, and
+ * single-byte chunks are what the drain was tested with.
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
+ * for the session that died, which no verify window covers. Wait that out:
+ * STAT cannot tell the cases apart, and guessing would mean writing END into a
+ * live receive loop. The drained image never boots, since its zero fill fails
+ * the loader's CRC gate, so a count outliving the window is a loader that has
+ * stopped servicing the mailbox.
+ *
+ * Return: 0 once the loader is back at READY, -EAGAIN if it asks for another
+ * chunk after all, -EIO for a loader still holding a count when the window
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
+	if (!stat)
+		return -EAGAIN;
+
+	if (chunk)
+		dev_err(dev,
+			"flash: loader stuck after %u chunks, power cycle it\n",
+			chunk);
+	else
+		dev_err(dev, "flash: loader still busy after the erase window\n");
+
+	return -EIO;
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
+	/* Bound: 32 MiB in single-byte chunks, many times the largest image. */
+	u32 max_chunks = (32u << 20) / MXL862XX_DRAIN_CHUNK_BYTES;
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
+	 * detection brings the driver up flashable, with the loader at READY.
+	 * The core drops the re-probe on its own if the device is unbound
+	 * first; the flag test only avoids scheduling one certain to be
+	 * dropped. A failed hand-off leaves nothing to reclassify the switch,
+	 * so recovery is marked failed rather than promising a retry that
+	 * cannot succeed.
+	 */
+	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		return;
+
+	/* -EINVAL is a device being deleted, whose teardown ends this work. */
+	ret = device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS);
+	if (ret && ret != -EINVAL) {
+		dev_err(dev,
+			"flash: re-probe could not be scheduled (%pe); unbind and rebind to reinitialise\n",
+			ERR_PTR(ret));
+		WRITE_ONCE(priv->rescue_failed, true);
+	}
+}
+
+/* Prove a live console loader behind READY: the register-read command, keyed
+ * by the word in DATA, is serviced by re-arming READY, which nothing but the
+ * loader's command loop does. The reset afterwards clears the word it leaves
+ * in DATA.
+ */
+static int mxl862xx_sb_pdi_challenge(struct mxl862xx_priv *priv)
+{
+	int ret, err, val;
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
+				   MXL862XX_SB_PDI_RDREG_MARK);
+	if (ret < 0)
+		return ret;
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+				   MXL862XX_SB_PDI_RDREG);
+	if (ret < 0)
+		return ret;
+
+	ret = read_poll_timeout(mxl862xx_smdio_read, val,
+				val < 0 || (u16)val == MXL862XX_SB_PDI_READY,
+				MXL862XX_SB_PDI_SLOW_POLL_US,
+				MXL862XX_SB_PDI_STEP_MS * 1000, false,
+				priv, MXL862XX_SB_PDI_STAT);
+	err = mxl862xx_sb_pdi_reset(priv);
+	if (val < 0)
+		return val;
+	if (err < 0)
+		return err;
+	if (ret)
+		return -ENXIO;
+
+	return 0;
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
+ *    gets one step to publish 0 or READY first; a count outliving that is
+ *    taken for rescue only when it is the erase of a session that died
+ *    (header length + 1), anything else for a firmware that never became
+ *    ready.
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
+	int stat, ret, rb, a, d;
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
+	 * challenge. A firmware publishing 0xc55c as its status word looks the
+	 * same until then, and flashing one would be far worse than refusing
+	 * to bind, so an unserviced challenge is unusable (-ENXIO).
+	 */
+	if ((u16)stat == MXL862XX_SB_PDI_READY) {
+		ret = mxl862xx_sb_pdi_challenge(priv);
+		if (ret < 0)
+			return ret;
+		WRITE_ONCE(priv->rescue_ready, true);
+		return MXL862XX_IN_RESCUE;
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
+	/* Any other non-zero value is a running firmware, not a loader, but
+	 * the loader also holds the count of a chunk it is programming or
+	 * erasing for, so let a caller whose clause-45 wait has failed give it
+	 * a step for the next state. A count that outlives the step is taken
+	 * for rescue only when it is the erase count of a session that died;
+	 * any other is taken for a firmware that answered the reset without
+	 * becoming ready, since a status word of that firmware could hold any
+	 * value.
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
+			ret = mxl862xx_sb_pdi_challenge(priv);
+			if (ret < 0)
+				return ret;
+			WRITE_ONCE(priv->rescue_ready, true);
+			return MXL862XX_IN_RESCUE;
+		}
+		if (stat == MXL862XX_FW_HDR_SIZE + 1)
+			return MXL862XX_IN_RESCUE;
+		if (stat)
+			return MXL862XX_NOT_RESCUE;
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
@@ -300,13 +737,15 @@ static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
 	int ret, val, i;
 
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
@@ -504,6 +943,22 @@ int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 	char buf[16];
 	int ret;
 
+	/* No chip-id/revision in MCUboot (needs the firmware MMD mailbox). The
+	 * fw version doubles as the "ready to flash" signal: report it only
+	 * once the loader is at a clean READY, nothing while still draining,
+	 * and as running only, since what the flash holds is unknown here.
+	 */
+	if (READ_ONCE(priv->rescue_mode)) {
+		if (!READ_ONCE(priv->rescue_ready))
+			return 0;
+
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
+		return devlink_info_version_running_put(req,
+				DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+	}
+
 	/* A 0 part number means the CHIP ID read failed, the part is unfused
 	 * or a flash failed; omit it rather than publish a bogus "0000" that
 	 * fwupd would match firmware against, it then falls back to the
@@ -585,9 +1040,28 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		return ret;
 	}
 
-	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
-		 priv->fw_version.major, priv->fw_version.minor,
-		 priv->fw_version.revision);
+	/* Refuse to flash while the background self-heal is still draining, and
+	 * for good once it has given up on the loader.
+	 */
+	if (READ_ONCE(priv->rescue_failed)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "switch is not flashable from this binding");
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
@@ -638,6 +1112,7 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		 * readiness poll below read the freshly booted firmware.
 		 */
 		priv->flash_owner = current;
+		WRITE_ONCE(priv->rescue_mode, false);
 		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
 
 		/* Refresh the cached versions so the flash update only
@@ -654,11 +1129,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 	if (ret) {
 		/* The loader may hold an erased or partly written image; drop
 		 * the cached identity so devlink dev info stops reporting the
-		 * pre-flash version until the reprobe re-reads the truth.
+		 * pre-flash version until the reprobe re-reads the truth, and
+		 * with it the loader's clean READY state.
 		 */
 		memset(&priv->fw_version, 0, sizeof(priv->fw_version));
 		priv->asic_id = 0;
 		priv->asic_rev = 0;
+		WRITE_ONCE(priv->rescue_ready, false);
 	}
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
index 15ed3a46bcfe2..02e5a627e9471 100644
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
index b229c4512b82c..744bbb8d6a24e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -17,6 +17,7 @@
 #include <net/dsa.h>
 #include "mxl862xx.h"
 #include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -55,9 +56,14 @@ static void mxl862xx_crc_err_work_fn(struct work_struct *work)
 	clear_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags);
 }
 
-/* Firmware CRC error codes (outside normal Zephyr errno range). */
+/* The firmware reports a CRC-6 mismatch on ctrl/len_ret and a CRC-16 mismatch
+ * on the data payload with codes outside the Zephyr errno range. The host's
+ * own verdict lies outside the 11-bit result range, so no firmware result
+ * can be mistaken for it.
+ */
 #define MXL862XX_FW_CRC6_ERR		(-1024)
 #define MXL862XX_FW_CRC16_ERR		(-1023)
+#define MXL862XX_HOST_CRC_ERR		(-1025)
 
 /* 3GPP CRC-6 lookup table (polynomial 0x6F).
  * Matches the firmware's default CRC-6 implementation.
@@ -216,7 +222,9 @@ static int mxl862xx_busy_wait(struct mxl862xx_priv *priv)
 /* Issue a firmware command with CRC-6 protection on the ctrl and len_ret
  * registers, wait for completion, and verify the response CRC-6.
  *
- * Return: firmware result value (>= 0) on success, or negative errno.
+ * Return: firmware result value (>= 0) on success, a negative firmware
+ * errno or CRC code, %MXL862XX_HOST_CRC_ERR for a response failing its
+ * CRC-6 check here, or a negative bus errno.
  */
 static int mxl862xx_issue_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 len)
 {
@@ -250,15 +258,18 @@ static int mxl862xx_issue_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 len)
 	len_enc = ret;
 
 	ret = mxl862xx_crc6_verify(ctrl_enc, len_enc, &fw_result);
-	if (ret) {
-		if (!test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
-			schedule_work(&priv->crc_err_work);
-		return -EIO;
-	}
+	if (ret)
+		return MXL862XX_HOST_CRC_ERR;
 
 	return fw_result;
 }
 
+static bool mxl862xx_crc_failed(int ret)
+{
+	return ret == MXL862XX_HOST_CRC_ERR || ret == MXL862XX_FW_CRC6_ERR ||
+	       ret == MXL862XX_FW_CRC16_ERR;
+}
+
 static int mxl862xx_set_data(struct mxl862xx_priv *priv, u16 words)
 {
 	u16 cmd;
@@ -305,26 +316,20 @@ static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
 
 	ret = mxl862xx_issue_cmd(priv, cmd, size);
 
-	/* Handle errors returned by the firmware as -EIO.
+	/* Handle errors returned by the firmware as -EIO; a CRC code passes
+	 * through for mxl862xx_api_wrap() to act on.
 	 * The firmware is based on Zephyr OS and uses the errors as
 	 * defined in errno.h of Zephyr OS. See
 	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
-	 *
-	 * The firmware signals CRC validation failures with dedicated
-	 * error codes outside the normal Zephyr errno range:
-	 *   -1024: CRC-6 mismatch on ctrl/len_ret registers
-	 *   -1023: CRC-16 mismatch on data payload
 	 */
-	if (ret < 0) {
-		if ((ret == MXL862XX_FW_CRC6_ERR ||
-		     ret == MXL862XX_FW_CRC16_ERR) &&
-		    !test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
-			schedule_work(&priv->crc_err_work);
-		if (!quiet)
-			dev_err(&priv->mdiodev->dev,
-				"CMD %04x returned error %d\n", cmd, ret);
-		return -EIO;
-	}
+	if (ret == MXL862XX_HOST_CRC_ERR && !quiet)
+		dev_err(&priv->mdiodev->dev,
+			"CMD %04x response failed its CRC check\n", cmd);
+	else if (ret < 0 && !quiet)
+		dev_err(&priv->mdiodev->dev,
+			"CMD %04x returned error %d\n", cmd, ret);
+	if (ret < 0)
+		return mxl862xx_crc_failed(ret) ? ret : -EIO;
 
 	return ret;
 }
@@ -334,7 +339,7 @@ bool mxl862xx_api_gated(struct mxl862xx_priv *priv)
 	bool gated;
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
-	gated = priv->block_host || priv->skip_teardown;
+	gated = priv->block_host || priv->skip_teardown || priv->rescue_mode;
 	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
 
 	return gated;
@@ -358,6 +363,11 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
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
@@ -491,9 +501,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	}
 
 	if (crc16(0xffff, (const u8 *)data, size) != crc) {
-		if (!test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
-			schedule_work(&priv->crc_err_work);
-		ret = -EIO;
+		ret = MXL862XX_HOST_CRC_ERR;
 		goto out;
 	}
 
@@ -503,6 +511,15 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	dev_dbg(&priv->mdiodev->dev, "RET %d DATA %*ph\n", ret, size, data);
 
 out:
+	/* A quiet command is expected to go unanswered by a switch still
+	 * booting or sitting in its loader, so it does not arm the shutdown.
+	 */
+	if (mxl862xx_crc_failed(ret)) {
+		if (!quiet &&
+		    !test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
+			schedule_work(&priv->crc_err_work);
+		ret = -EIO;
+	}
 	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
 
 	return ret;
@@ -570,9 +587,11 @@ int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val)
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
index b689652aa9b92..df77bbf108d5e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -47,7 +47,12 @@ void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
 		fallthrough;
 	case 10 ... 12:
 	case 14 ... 16:
-		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
+		/* Rescue mode has no firmware version, so bypass the gate and
+		 * advertise the full set; a CPU port on a quad sub-interface
+		 * would otherwise get an empty mask and fail phylink_create().
+		 */
+		if (!READ_ONCE(priv->rescue_mode) &&
+		    !MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
 			break;
 		__set_bit(PHY_INTERFACE_MODE_QSGMII, config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_10G_QXGMII, config->supported_interfaces);
@@ -406,6 +411,8 @@ mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
 
 	switch (port) {
 	case 9 ... 16:
+		if (READ_ONCE(priv->rescue_mode))
+			return NULL;
 		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84)) {
 			dev_warn_once(dp->ds->dev,
 				      "SerDes PCS unsupported on old firmware.\n");
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index e6f710c676e65..9097b0c559256 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -670,27 +670,85 @@ static void mxl862xx_free_bridge(struct dsa_switch *ds,
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
+			 "switch in MCUboot with an unfinishable download handshake, only a power cycle clears it\n");
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
+		dev_err(ds->dev, "switch in an unusable state: %pe\n",
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
 
+		ret = mxl862xx_wait_ready(ds);
+		if (ret) {
+			/* the reset may only now have triggered rescue mode */
+			rescue = mxl862xx_rescue_mode_detect(priv, true);
+			if (rescue < 0) {
+				dev_err(ds->dev,
+					"switch in an unusable state after reset: %pe\n",
+					ERR_PTR(rescue));
+				return rescue;
+			}
+			if (rescue == MXL862XX_NOT_RESCUE)
+				return ret;
+		}
+	}
+
+	priv->rescue_mode = rescue;
+
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
@@ -781,11 +839,21 @@ static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
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
@@ -1403,6 +1471,17 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
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
@@ -1412,11 +1491,6 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
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
@@ -1706,6 +1780,9 @@ static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
 	struct mxl862xx_priv *priv = ds->priv;
 	int ret;
 
+	if (READ_ONCE(priv->rescue_mode))
+		return;
+
 	switch (state) {
 	case BR_STATE_DISABLED:
 		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_DISABLE);
@@ -2234,14 +2311,14 @@ static void mxl862xx_remove(struct mdio_device *mdiodev)
 
 	priv = ds->priv;
 
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+
 	/* Wait out a flash in flight and bar a new one before the DSA core
 	 * frees the user netdevs; the devlink instance lock does not cover
 	 * that free, which dsa_unregister_switch() reaches first.
 	 */
 	mxl862xx_flash_shutdown(ds);
 
-	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-
 	dsa_unregister_switch(ds);
 
 	mxl862xx_host_shutdown(priv);
@@ -2266,11 +2343,12 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 
 	priv = ds->priv;
 
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+
 	mxl862xx_flash_shutdown(ds);
 
 	dsa_switch_shutdown(ds);
 
-	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
 	disable_delayed_work_sync(&priv->stats_work);
 
 	mxl862xx_host_shutdown(priv);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 7d6bee9fa33d7..98b3afdc5ef1f 100644
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
@@ -298,7 +304,8 @@ struct mxl862xx_fw_version {
  *                      before CRC-triggered shutdown and cleared after;
  *                      %MXL862XX_FLAG_WORK_STOPPED is set before cancelling
  *                      stats_work to prevent rescheduling during teardown
- *                      and a flash
+ *                      and a flash, and ends the rescue drain and its
+ *                      reprobe hand-off
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
@@ -340,6 +347,18 @@ struct mxl862xx_fw_version {
  * @shutting_down:      set under the devlink instance lock once ->shutdown()
  *                      or .remove() has begun, so no flash starts while the
  *                      switch is going away
+ * @rescue_mode:        switch is in MCUboot; firmware API commands fail fast,
+ *                      only clause-22 SMDIO works. Set from setup() before the
+ *                      switch is registered and cleared with WRITE_ONCE() under
+ *                      the MDIO bus lock for the benefit of mxl862xx_api_wrap();
+ *                      readers outside that lock use READ_ONCE().
+ * @rescue_ready:       (rescue_mode) loader is at a clean READY and will accept
+ *                      a flash; false while rescue_heal_work is draining
+ * @rescue_failed:      (rescue_mode) no flash is possible from this binding:
+ *                      an unfinishable handshake, a failed drain or a
+ *                      re-probe that could not be scheduled; the log names
+ *                      the cause, the devlink documentation the remedy
+ * @rescue_heal_work:   background self-heal draining a wedged download to READY
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -347,6 +366,7 @@ struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
 	struct work_struct crc_err_work;
+	struct work_struct rescue_heal_work;
 	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_fw_version fw_version;
@@ -364,6 +384,9 @@ struct mxl862xx_priv {
 	bool block_host;
 	bool skip_teardown;
 	bool shutting_down;
+	bool rescue_mode;
+	bool rescue_ready;
+	bool rescue_failed;
 	struct delayed_work stats_work;
 };
 
-- 
2.56.0
