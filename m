Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175E449EA6;
	Sat,  3 Oct 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042771; cv=none; b=UtRwqMMNxauRYHhL5sIusUde3eXvBU7AwS8ST1/szp4g12ddLrLEFyAw8CJOoLp6rmYW9bC6tsSz021BY17/XtfRGjHfkvwgUQ0j4zAs7JzdTTrIRGFPRG/mcDJPk191LmTFKG4ZSjGFYEXThjaXh2OUJk80eex6MKvin5CuD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042771; c=relaxed/simple;
	bh=Tla5bAqXC9Vpf8W+q9jRy3JjXuxJXZoI5X3fDsO3Bns=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0W+Dhw1bb7POuuq0CoXWCMhtxN29z0cLaxFyw80ObttJOo7t+LgHNdx3wIxJ7RULqLLVniE5F5ie2EkqJfohP1dwsTWOgdgf35Sl44qrWg42C/wHUwzStmqMDhb2XCkUh8FbkjVaAItYZUViGntxz7WB5iEjCY1IapLMvpzo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD22S-000000001Hw-35Aj;
	Sat, 03 Oct 2026 15:52:40 +0000
Date: Sat, 3 Oct 2026 16:52:37 +0100
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
Subject: [PATCH net-next v19 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <6bf133505781800d1f64ea736e72c557759bb03e.1791035885.git.daniel@makrotopia.org>
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

Implement "devlink dev flash" for firmware upgrade and "devlink dev
info" for version reporting. info reports the chip part number and
revision as the asic.id and asic.rev fixed versions, and the firmware
version as both the running and the stored version, since the switch
boots its firmware from its own flash; a zero part number or an all-zero
version is omitted rather than published as a bogus match for userspace.

flash validates the image and its payload CRCs, reboots the switch into
its MCUboot loader with SYS_MISC_FW_UPDATE, transfers the image over the
SB PDI clause-22 SMDIO protocol, and reboots into the new firmware once
the loader has verified it. For the duration the driver closes and
detaches the user ports so userspace cannot reopen them, closes the
conduit, and blocks firmware API access under the MDIO bus lock so
nothing reaches the bus after the switch has left for MCUboot. A blocked
write reports success, so a bridge tearing its ports down over a flash
does not see port_vlan_del() fail and leak its VLAN group. A transfer
that fails leaves the switch in the loader; the next patch recovers it
from there.

MCUboot offers no in-place path back, so the driver reinitialises with a
deferred re-probe scheduled through device_schedule_reprobe() from the
previous patch, which runs in the driver core off the devlink caller's
locks and without pinning the driver module. ->shutdown() and
.remove() take the devlink instance lock up front, since neither goes
through devlink and dsa_unregister_switch() frees the user netdevs
before devlink_unregister() would: this waits out a transfer in flight,
for as long as the transfer's own timeouts allow, rather than cutting
it in half, and refuses a flash that starts once teardown has begun. A
flash is refused as well until the DSA tree has finished its setup,
since devlink registers the switch before the core creates the user
ports.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v19:
 - refuse a flash while the DSA tree is still being set up: devlink
   registers the switch before the core creates the user ports, which
   it does without rtnl held (found by Sashiko AI review)
 - treat -EINVAL from the re-probe request as the device deletion it
   is, so a flash that completed on a device being deleted neither
   fails nor asks for a rebind (found by a local review)
 - read the flash gates under the MDIO bus lock in port_mdb_add(),
   port_mdb_del() and get_ethtool_stats(), where a lockless read could
   observe the hand-over from block_host to skip_teardown as neither
   flag set and report a bus error (found by Sashiko AI review)
 - tell devlink through extack that the new firmware is running but the
   driver needs rebinding when the re-probe cannot be scheduled after a
   successful transfer (found by Sashiko AI review)
 - log a rejected image once and name it in the extack, and report an
   erase or write that a bus error ended as failed rather than timed
   out (found by Sashiko AI review)
 - give the final slice's status poll the loader's verification window
   on top of the write budget, since the verdict it waits for follows
   the verification; the next patch shares that window with its drain
   (found by Sashiko AI review)
 - flush the DSA workqueue after closing the ports, where the bridge's
   host address deletions run, so they reach the firmware while it is
   still alive (found by a local review)
 - zero the cached chip ID before re-reading it, so a failed read on a
   freshly booted firmware does not keep publishing the previous one
   (found by a local review)
 - drop the check for a component, which the devlink core refuses first
   for a device that reports no component versions (found by a local
   review)
 - comments and kernel-doc: the reprobe starts from a fresh
   configuration, a failed flash also zeroes the part number,
   skip_teardown lasts until the reprobe or a rebind, WORK_STOPPED also
   covers a flash, the 16-bit status register bounds the slice, and the
   reboot and re-probe delays are not timeouts (found by Sashiko AI
   review and a local review)
 - commit message: the shutdown wait lasts as long as the transfer's own
   timeouts allow (found by a local review)

v18:
 - accept a read refused by the flash gate (-EBUSY) or the teardown gate
   (-ENODEV) alike in port_mdb_add() and port_mdb_del() while either
   gate is set, since the flash moves from one gate to the other after
   api_wrap() has dropped the MDIO bus lock (found by Sashiko AI review)
 - log a re-probe that cannot be scheduled after a failed transfer too,
   not only after a successful one (found by Sashiko AI review)
 - wait for the header byte count to change rather than for its ACK
   value, which the loader replaces with 0 as soon as the erase is done
   (found by Sashiko AI review)
 - return without a message from get_ethtool_stats() while the flash
   gates refuse the read, which unprivileged ethtool -S reaches (found by
   Sashiko AI review)
 - reword the -EBUSY extack of a flash requested while a previous one
   still awaits its reprobe, or could not schedule it, to hold in both
   cases
 - kernel-doc: mxl862xx_wait_ready() caches the chip ID only when it can
   be read, and @fw_version is refreshed after a flash and cleared after
   a failed one (found by Sashiko AI review)
 - commit message: the re-probe holds a device reference and only leaves
   the module unpinned, and a failed transfer leaves the switch for the
   next patch to recover (found by Sashiko AI review)

v17:
 - wait out a flash in flight in .remove() too, not only ->shutdown():
   dsa_unregister_switch() frees the user netdevs before it reaches the
   devlink instance lock, so an unbind racing a flash could touch a
   freed netdev; .remove() now takes that lock up front like
   ->shutdown(), and both announce the wait with dev_info() (found by
   Sashiko AI review)
 - report success for a firmware read blocked by a flash (-EBUSY) as
   well as the teardown -ENODEV in port_mdb_add() and port_mdb_del(), so
   an MDB change racing a flash does not fail and leave the entry linked
   (found by Sashiko AI review)
 - clear the SB PDI ADDR and DATA latches with 0 rather than the CTRL
   reset mode value, which only happened to be 0 (found by Sashiko AI
   review)
 - log that an unbind and rebind is needed when the post-flash re-probe
   cannot be scheduled although the new firmware is already running
   (found by Sashiko AI review)
 - kernel-doc: describe the block_host and skip_teardown policy as it
   is, a host read failing while a write reports success (found by
   Sashiko AI review)
 - commit message: scheduling the re-probe can also fail with -EINVAL
   when the device is being unbound, not only -ENOMEM (found by Sashiko
   AI review)

v16:
 - report success for a firmware write blocked by a running flash,
   instead of -EBUSY. Tearing a bridge down over a flash made
   port_vlan_del() fail, which leaves the VLAN on the bridge's list:
   __vlan_group_free() then warns and frees the group with the entries
   still linked
 - wait for a flash in flight in ->shutdown() and refuse one requested
   after it, so a reboot no longer cuts the image in half
 - state a fact in the -EBUSY extack of a pending reprobe, dropping the
   retry advice
 - the comment on mxl862xx_read_chip_id() no longer describes a
   rescue-mode cache that only the next patch creates
 - select CRC32, which nothing else selects for the crc32_le() calls
   validating the image checksums (found by Sashiko AI review)
 - Andrew's Reviewed-by is dropped for the ->shutdown() change

v15:
 - treat the closing END write as advisory: the loader has left the
   receive loop and verified the image by then, so a failed write no
   longer reports a completed flash as a transfer failure (found by
   Sashiko AI review)
 - admit only the flash task's own firmware reads past block_host,
   instead of every read from any context, which let ethtool and FDB
   queries reach the freshly booted firmware and left an mdb_add() half
   executed (found by Sashiko AI review)

v14: no changes, picked up Andrew's v13 Reviewed-by

v13: stop the stats poll with disable_delayed_work_sync() in the flash
     path, so a racing get_stats64() re-arm is a no-op, and drop the
     early return in the work function with it; the v12 reordering of
     remove() is gone as well, since the race it addressed predates
     this series and needs a fix of its own (found by Sashiko AI review)

v12:
 - cancel the stats poll after dsa_unregister_switch() in .remove(): a
   get_stats64() past its lockless WORK_STOPPED check could re-arm the
   work after the cancel and then run against the devres-freed priv
   (found by Sashiko AI review)
 - keep block_host set across the post-flash readiness poll and let
   only the flash path's own firmware reads through, so a concurrent
   bridge or STP write cannot reach the freshly booted firmware with
   stale pre-flash resource IDs while rtnl is dropped (found by Sashiko
   AI review)

v11:
 - schedule the post-flash re-probe with device_schedule_reprobe()
   instead of a driver-owned work item; the module and device references
   and the drvdata bound-check go away with it, and with them both
   findings of the v10 AI review -- the work function no longer ends in
   module text behind a module_put(), and the bound-check and detach now
   run under one __device_driver_lock() hold in the core where
   ->shutdown() cannot interleave between them
 - the dsa_switch allocation returns to devres; keeping it out only
   defused the check-vs-detach window that the core helper now closes
   outright
 - scheduling the re-probe is now the one step that can fail after the
   switch was flashed, since the helper allocates its own work item; an
   -ENOMEM there is returned as-is, since unbind and rebind reinitialises
   the driver

v10:
 - do not reprobe a device that has been shut down or unbound. The work
   cannot be cancelled from teardown: .shutdown() runs under
   device_lock(), which device_reprobe() takes as well, so a lock shared
   between the two would deadlock, and cancel_delayed_work_sync() would
   hang on the nested remove() the work triggers itself. It checks
   drvdata under device_lock() instead, which both .shutdown() and the
   driver core clear (found by Sashiko AI review of patch 4, but this is
   where the reprobe comes from)
 - allocate the dsa_switch outside devres and free it in .remove(), so
   losing the remaining race with .shutdown() cannot let devres free it
   while the DSA tree still holds dsa_ports pointing at it
 - lower the per-slice write timeout from 120 s to 60 s, so this path
   and the drain added in patch 4 agree on how long the same loader step
   may take (found by Sashiko AI review)

v9: no changes

v8:
 - refuse a second devlink dev flash while the previous one's reprobe is
   still pending: the firmware API is short-circuited by then, so the
   FW_UPDATE command faked success and the raw SB PDI writes ran against
   a switch the driver no longer tracks (found by Sashiko AI review)
 - omit the firmware version from devlink dev info while the cached copy
   is all-zero, so a failed transfer no longer publishes 0.0.0 as both
   running and stored, and clear asic_rev along with asic_id (found by
   Sashiko AI review)
 - only translate -ENODEV into success in port_mdb_del() during the
   post-flash teardown; outside it, a genuine bus error was reported to
   switchdev as a successful deletion (found by Sashiko AI review)
 - evaluate the image verification verdict the loader publishes after
   the last slice, instead of polling for a value it had already
   published, so a rejected image is no longer reported as a write
   timeout
 - rename the end_magic label to no_end, which is what it does, and
   correct the protocol comment: END is optional as the loader finalises
   on a 2 s timeout, the status register keeps the byte count while a
   chunk is programmed, and the half-bank switch does not clear DATA
   (found by Sashiko AI review)

v7:
 - reprobe from a single delayed work item instead of a kthread spawned
   by a workqueue kickoff; the kthread existed only to drop the module
   reference from core code, but its creation-failure path did the racy
   module_put() from module text anyway and could strand the driver
   bound with skip_teardown set. The collapsed form matches
   iwl_trans_reprobe_wk(), and a failed reprobe now leaves the device
   unbound like a failed probe
 - only signal END on a successful transfer; a failure leaves the loader
   mid-payload, where a STAT write is a byte count and END (0x3cc3) is
   read as one, risking a receive-counter underflow, so return the error
   and let the reprobe recover
 - add cond_resched() to the payload loop so a long transfer over a
   bit-banged MDIO bus under CONFIG_PREEMPT_NONE does not trip the
   soft-lockup detector
 - drop the cached firmware version and chip id on a failed flash so
   devlink dev info stops reporting the pre-flash version until the
   reprobe re-reads it
 - report the firmware version under DEVLINK_INFO_VERSION_GENERIC_FW
   instead of a bare "fw" string
 - correct the SB PDI header comment's SMDIO register map (page in MII
   reg 0x1f, register from the low nibble) and expand the note on why
   closing the shared conduit is safe

v6:
 - confirm the new firmware is running with mxl862xx_wait_ready() and
   lift the host block before reporting success, so devlink dev flash
   completes only once the update has taken effect instead of relying
   on the later reprobe to pick up the new version
 - run the post-flash reprobe from a kthread that drops the module
   reference with module_put_and_kthread_exit(), spawned from a
   workqueue kickoff, closing a use-after-free where a work item's
   trailing module_put() could return into module text a racing rmmod
   had already freed
 - jump to the end_magic teardown on every flash failure from the
   ready handshake onward, so an aborted transfer sends END and lets
   MCUboot reboot instead of leaving the loader waiting
 - poll the SB PDI status register with read_poll_timeout(), which
   evaluates the condition once more after the deadline, so a preempted
   poll cannot report a spurious -ETIMEDOUT
 - bail out of the periodic stats poll when the flash teardown has set
   WORK_STOPPED, closing a get_stats64() re-arm race
 - allocate the reprobe kickoff before disturbing the switch, so an
   -ENOMEM cannot leave it flashed but never reprobed with block_host
   and skip_teardown stuck set
 - omit asic.id/asic.rev when the CHIP ID read returned 0, instead of
   publishing a bogus "0000" for fwupd to match firmware against

v5:
 - report the numeric chip part number and version read from the
   static CHIP ID registers as "asic.id" and "asic.rev" instead of a
   model-name string, which does not belong in a devlink version
   identifier (Jakub Kicinski)
 - report the running firmware version as the "stored" version too,
   since the switch boots it from its own flash, so userspace can
   tell a flash-backed part from a flashless one by the presence of
   "stored" without a future API change
 - run the post-flash reprobe from a self-contained work item again
   instead of the v4 kernel thread, which tripped the hung-task
   watchdog while parked across the flash and returned -EINTR from
   kthread_create() when the devlink command was interrupted
 - re-read the new firmware version through the reprobe's fresh probe
   and drop the SYS_MISC_FW_VERSION exemption from the host block
 - raise the firmware command poll timeout so the FW_UPDATE command
   that reboots into MCUboot is not cut short
 - move the devlink documentation into its own patch

v4:
 - run the deferred reprobe from a kernel thread ending in
   module_put_and_kthread_exit() instead of a work item whose final
   module_put() raced against module unload
 - fail API read commands with -ENODEV after the update instead of
   faking success with an unfilled buffer, which sent
   port_fdb_dump() into an endless loop
 - keep block_host set across the post-update version query by
   exempting SYS_MISC_FW_VERSION instead of briefly lifting the
   block, and write the blocking flags under the MDIO bus lock
 - check the return value of every SB PDI control write; a failed
   address write during the half-bank switch could place the second
   half of the payload at the wrong flash offset undetected
 - report SMDIO write failures through one shared error path instead
   of per-site messages
 - initialise the progress notification deadline from jiffies so
   notifications are not suppressed on 32-bit shortly after boot
 - flush the switchdev deferred queue after closing the ports so the
   bridge's deferred STP DISABLED transitions reach the firmware
   while it is still running instead of failing with -EBUSY against
   the host block
 - treat -ENODEV as successful deletion in port_mdb_del() so the
   post-update teardown does not leave leftover host MDB entries
   behind for the DSA core to report

v3:
 - validate the image, including both CRCs, before closing any ports
   so a malformed file no longer triggers a flash and reprobe cycle
 - reject images whose declared payload sizes overflow when summed
   (check_add_overflow) or sum up to zero; the latter used to erase
   the flash without writing anything back
 - allocate the reprobe work item and take the module and device
   references before disturbing the switch instead of silently
   skipping the reprobe when the allocation fails afterwards
 - check block_host/skip_teardown under the MDIO bus lock to close
   the window where a command already past the check could reach the
   bus after the switch rebooted into MCUboot
 - prevent the stats poll work from being re-armed and cancel the
   CRC error work before the transfer
 - check the return value of SB PDI data word writes; control writes
   are verified by the subsequent status polls
 - report a per-model chip name from the OF match data as "asic.id"
   instead of the devicetree compatible string whose comma is
   awkward for userspace consumers (Andrew Lunn)
 - commit message: the conduit is only closed, not detached

v2:
 - factor out SB PDI slice flush and devlink status notification
   helpers, resolving checkpatch issues
 - use kzalloc_obj() (Manuel Ebner)
 - add kernel-doc for the new mxl862xx_priv members
 - trim comments and state the actual duration of a flash and reprobe
   cycle, just under a minute (Manuel Ebner)
 - reword commit message: split up run-on sentence, explain the
   dynamically allocated reprobe work item (Manuel Ebner), mention
   that closing the ports stops phylib polling (Andrew Lunn)

 drivers/net/dsa/mxl862xx/Kconfig         |   1 +
 drivers/net/dsa/mxl862xx/Makefile        |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h  |  10 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 711 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  18 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |  31 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |  83 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  33 +-
 10 files changed, 888 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h

diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
index e51a67a3cf9bf..8bb524fe28d1f 100644
--- a/drivers/net/dsa/mxl862xx/Kconfig
+++ b/drivers/net/dsa/mxl862xx/Kconfig
@@ -3,6 +3,7 @@ config NET_DSA_MXL862
 	tristate "MaxLinear MxL862xx"
 	depends on NET_DSA
 	select CRC16
+	select CRC32
 	select NET_DSA_TAG_MXL_862XX
 	help
 	  This enables support for the MaxLinear MxL862xx switch family.
diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
index a7be0e6669dfa..bccac0d0f703f 100644
--- a/drivers/net/dsa/mxl862xx/Makefile
+++ b/drivers/net/dsa/mxl862xx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
-mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o
+mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o mxl862xx-fw.o
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index a180a5decffc0..6f771895984cb 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -1224,6 +1224,16 @@ struct mxl862xx_sys_fw_image_version {
 	__le32 iv_build_num;
 } __packed;
 
+/**
+ * struct mxl862xx_sys_reg_rw - System register read/write
+ * @addr: 32-bit register address
+ * @val: register value
+ */
+struct mxl862xx_sys_reg_rw {
+	__le32 addr;
+	__le32 val;
+} __packed;
+
 /**
  * enum mxl862xx_port_type - Port Type
  * @MXL862XX_LOGICAL_PORT: Logical Port
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index c87a955c13c48..a865425aa61e1 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -70,7 +70,9 @@
 #define INT_GPHY_READ			(GPY_GPY2XX_MAGIC + 0x1)
 #define INT_GPHY_WRITE			(GPY_GPY2XX_MAGIC + 0x2)
 
+#define SYS_MISC_FW_UPDATE		(SYS_MISC_MAGIC + 0x1)
 #define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
+#define SYS_MISC_REG_RD			(SYS_MISC_MAGIC + 0x8)
 
 #define MXL862XX_XPCS_PCS_CONFIG	(MXL862XX_XPCS_MAGIC + 0x1)
 #define MXL862XX_XPCS_PCS_GET_STATE	(MXL862XX_XPCS_MAGIC + 0x2)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
new file mode 100644
index 0000000000000..eae7048707870
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Firmware flash and devlink support for MaxLinear MxL862xx
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ *
+ * SB PDI - firmware download interface over clause-22 SMDIO
+ * =========================================================
+ *
+ * The MxL862xx MCUboot loader accepts a firmware image through four "SB PDI"
+ * registers in the switch SMDIO register space. It runs whenever no WSP
+ * firmware is active: the normal firmware update enters it deliberately - the
+ * SYS_MISC_FW_UPDATE API command sets a sticky rescue bit and reboots into
+ * MCUboot - and the loader also stays here when the stored WSP firmware fails
+ * its boot-time integrity check. This driver drives the loader's 0xc55c
+ * "console" download path.
+ *
+ * SMDIO register access (mxl862xx_smdio_read/write):
+ *   MII reg 0x1f := (<sb_pdi_reg> & 0xfff0)   ; page latch
+ *   MII reg (<sb_pdi_reg> & 0x000f) := / => <u16 data>
+ * so CTRL/ADDR/DATA/STAT (0xe100..0xe103) are MII regs 0/1/2/3 of page
+ * 0xe100, not all reg 0x00.
+ *
+ * SB PDI registers (host name/addr  ->  MCU mailbox):
+ *   CTRL 0xe100 -> 0xc0938400   mode: RST=0x00  RD=0x01  WR=0x02
+ *   ADDR 0xe101 -> 0xc0938404   SB target word address (SB1 bank = 0x7800)
+ *   DATA 0xe102 -> 0xc0938408   16-bit data / reply word
+ *   STAT 0xe103 -> 0xc093840c   handshake: a magic (below) or a byte count
+ *
+ * STAT magics:
+ *   READY  0xc55c   loader idle in the console loop        (this driver)
+ *   START  0xf48f   host   -> begin download session
+ *   ACK    0xf490   loader -> START acknowledged (START + 1)
+ *   END    0x3cc3   host   -> finalise now (optional, see below)
+ *
+ * Console flash path (STAT=0xc55c) - mxl862xx_flash_firmware():
+ *
+ *   host                                   loader
+ *   ----                                   ------
+ *   reset (CTRL=ADDR=DATA=0)
+ *   read STAT ............................ 0xc55c   (READY, idle)
+ *   STAT := START(0xf48f)  -------------->
+ *                          <-------------- STAT = 0xf490 (ACK)
+ *   CTRL := WR
+ *   DATA := hdr[0..9]  (20-byte header: type,size1,crc1,size2,crc2)
+ *   reset; STAT := 20 (header len)  -----> parse hdr; r_remain=size1+size2;
+ *                                          ERASE target region(s)
+ *                          <-------------- STAT=21 (len+1), then STAT=0
+ *                                          (erased)
+ *   -- payload, streamed in slices: --
+ *   CTRL := WR
+ *   DATA := word x N ...
+ *     at word 16384: CTRL:=RST; ADDR:=0x7800; CTRL:=WR  (half-bank -> SB1)
+ *     at word 32760: flush slice:
+ *        reset; STAT := <bytes_this_slice> ---> r_remain -= bytes; program
+ *                          <------------------- STAT=0  (ready for next slice)
+ *   ... repeat until the whole payload is sent ...
+ *                          <------------------- STAT=0  image verified
+ *                                               (STAT=1: image rejected)
+ *   STAT := END(0x3cc3)  ---------------------> finalise and boot
+ *
+ * The r_remain == 0 rule (critical):
+ *   Every host STAT write in the payload phase is a byte count; the loader
+ *   does r_remain -= count and stays in the receive loop while r_remain != 0.
+ *   It leaves the loop ONLY when r_remain hits EXACTLY 0, and a count larger
+ *   than r_remain underflows the 32-bit counter and wedges the loader until a
+ *   power cycle. Having left it, the loader verifies the image, publishes the
+ *   verdict in STAT (0 good, 1 rejected) and waits 2 s for END before
+ *   finalising regardless -- clearing its rescue-enable bit so boot_go boots
+ *   the new image -- so END only saves that wait. Hence:
+ *     - never send a slice/chunk count larger than what is outstanding;
+ *     - a STAT write is a command only once the loader has left the loop;
+ *     - the loader leaves the count in STAT while it programs the chunk, so
+ *       a lingering count does not distinguish "busy" from "verdict";
+ *     - STAT is a 16-bit register, so a slice holds at most 65535 bytes,
+ *       which is what bounds MXL862XX_FW_BANK_SLICE.
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/netdevice.h>
+#include <linux/overflow.h>
+#include <linux/rtnetlink.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include <net/dsa.h>
+#include <net/switchdev.h>
+
+#include "mxl862xx.h"
+#include "mxl862xx-api.h"
+#include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
+#include "mxl862xx-host.h"
+
+/* SB PDI registers (clause-22 SMDIO address space) */
+#define MXL862XX_SB_PDI_CTRL		0xe100
+#define MXL862XX_SB_PDI_ADDR		0xe101
+#define MXL862XX_SB_PDI_DATA		0xe102
+#define MXL862XX_SB_PDI_STAT		0xe103
+
+/* SB PDI CTRL modes */
+#define MXL862XX_SB_PDI_CTRL_RST	0x00
+#define MXL862XX_SB_PDI_CTRL_WR		0x02
+
+/* SB PDI handshake magic (published/consumed via STAT) */
+#define MXL862XX_SB_PDI_READY		0xc55c	/* loader idle, console loop */
+#define MXL862XX_SB_PDI_START		0xf48f
+#define MXL862XX_SB_PDI_END		0x3cc3
+
+/* Image verification verdict published in STAT once the receive loop ends */
+#define MXL862XX_SB_PDI_VERIFY_OK	0
+#define MXL862XX_SB_PDI_VERIFY_BAD	1
+
+/* Firmware transfer geometry */
+#define MXL862XX_FW_HDR_SIZE		20
+#define MXL862XX_FW_BANK_HALF		16384	/* words per half-bank */
+#define MXL862XX_FW_BANK_SLICE		32760	/* words per full slice, 65520 B */
+#define MXL862XX_FW_SB1_ADDR		0x7800	/* SB1 word address */
+
+/* Timeouts (generous upper bounds) */
+#define MXL862XX_FW_READY_TIMEOUT_MS	3000
+#define MXL862XX_FW_ACK_TIMEOUT_MS	5000
+#define MXL862XX_FW_ERASE_TIMEOUT_MS	300000
+#define MXL862XX_FW_WRITE_TIMEOUT_MS	60000
+/* Covers the loader's END wait, verification and the reset into READY */
+#define MXL862XX_SB_PDI_VERIFY_MS	15000
+
+/* Delays spent in full: the reboot into the new image, and the re-probe */
+#define MXL862XX_FW_REBOOT_DELAY_MS	5000
+#define MXL862XX_FW_REPROBE_DELAY_MS	500
+
+static int mxl862xx_sb_pdi_reset(struct mxl862xx_priv *priv)
+{
+	int ret;
+
+	/* CTRL selects RST mode; ADDR and DATA are cleared to 0. */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+				   MXL862XX_SB_PDI_CTRL_RST);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR, 0x0000);
+	if (ret < 0)
+		return ret;
+
+	return mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, 0x0000);
+}
+
+static int mxl862xx_sb_pdi_poll_stat(struct mxl862xx_priv *priv, u16 expected,
+				     unsigned long timeout_ms)
+{
+	int ret, val;
+
+	ret = read_poll_timeout(mxl862xx_smdio_read, val,
+				val < 0 || (u16)val == expected,
+				10000, timeout_ms * 1000, false,
+				priv, MXL862XX_SB_PDI_STAT);
+	if (val < 0)
+		return val;
+	return ret;
+}
+
+static int mxl862xx_sb_pdi_flush_slice(struct mxl862xx_priv *priv,
+				       u32 data_written)
+{
+	int ret;
+
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT, data_written);
+	if (ret < 0)
+		return ret;
+
+	return mxl862xx_sb_pdi_poll_stat(priv, 0,
+					 MXL862XX_FW_WRITE_TIMEOUT_MS);
+}
+
+/* Flush the last slice, which ends the receive loop: the loader verifies the
+ * image and replaces the count in STAT with its verdict, so wait for the count
+ * to go rather than for a fixed value.
+ */
+static int mxl862xx_sb_pdi_flush_last(struct mxl862xx_priv *priv,
+				      u32 data_written)
+{
+	int ret, val;
+
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT, data_written);
+	if (ret < 0)
+		return ret;
+
+	ret = read_poll_timeout(mxl862xx_smdio_read, val,
+				val < 0 || (u16)val != (u16)data_written,
+				10000, (MXL862XX_FW_WRITE_TIMEOUT_MS +
+					MXL862XX_SB_PDI_VERIFY_MS) * 1000,
+				false, priv, MXL862XX_SB_PDI_STAT);
+	if (val < 0)
+		return val;
+
+	if (!ret && (u16)val == MXL862XX_SB_PDI_VERIFY_OK)
+		return 0;
+
+	/* A final count of 1 is indistinguishable from the reject verdict, so
+	 * a timeout still holding it lands here too.
+	 */
+	if ((u16)val == MXL862XX_SB_PDI_VERIFY_BAD) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: loader rejected the image\n");
+		return -EBADMSG;
+	}
+
+	return ret ? ret : -EPROTO;
+}
+
+static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
+				  u32 done, u32 total)
+{
+	devlink_flash_update_status_notify(dl, status, NULL, done, total);
+}
+
+/* MCUboot firmware image header */
+struct mxl862xx_fw_hdr {
+	__le32 image_type;
+	__le32 image_size_1;
+	__le32 image_checksum_1;
+	__le32 image_size_2;
+	__le32 image_checksum_2;
+} __packed;
+
+static int mxl862xx_flash_validate(struct mxl862xx_priv *priv,
+				   const struct firmware *fw,
+				   u32 *payload_size)
+{
+	const struct mxl862xx_fw_hdr *hdr;
+	u32 size1, size2, total;
+	const u8 *payload;
+	u32 crc;
+
+	if (fw->size < MXL862XX_FW_HDR_SIZE)
+		return -EINVAL;
+
+	hdr = (const struct mxl862xx_fw_hdr *)fw->data;
+	payload = fw->data + MXL862XX_FW_HDR_SIZE;
+	size1 = le32_to_cpu(hdr->image_size_1);
+	size2 = le32_to_cpu(hdr->image_size_2);
+
+	if (check_add_overflow(size1, size2, &total) ||
+	    total > fw->size - MXL862XX_FW_HDR_SIZE) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: firmware file too small for declared size\n");
+		return -EINVAL;
+	}
+
+	if (!total) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: firmware file with empty payload\n");
+		return -EINVAL;
+	}
+
+	if (size1) {
+		crc = ~crc32_le(~0U, payload, size1);
+		if (crc != le32_to_cpu(hdr->image_checksum_1)) {
+			dev_err(&priv->mdiodev->dev,
+				"flash: image 1 CRC mismatch (got %08x, expected %08x)\n",
+				crc, le32_to_cpu(hdr->image_checksum_1));
+			return -EINVAL;
+		}
+	}
+
+	if (size2) {
+		crc = ~crc32_le(~0U, payload + size1, size2);
+		if (crc != le32_to_cpu(hdr->image_checksum_2)) {
+			dev_err(&priv->mdiodev->dev,
+				"flash: image 2 CRC mismatch (got %08x, expected %08x)\n",
+				crc, le32_to_cpu(hdr->image_checksum_2));
+			return -EINVAL;
+		}
+	}
+
+	*payload_size = total;
+
+	return 0;
+}
+
+static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
+				   const struct firmware *fw,
+				   u32 payload_size, struct devlink *dl)
+{
+	const u8 *payload = fw->data + MXL862XX_FW_HDR_SIZE;
+	u32 word_idx = 0, data_written = 0, idx = 0;
+	unsigned long next_notify = jiffies - 1;
+	u16 word, fdata;
+	int ret, val, i;
+
+	/* Step 1: reboot the firmware into MCUboot rescue mode */
+	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
+				false, false);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: FW_UPDATE command failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Step 2: wait for bootloader ready */
+	mxl862xx_flash_notify(dl, "Waiting for bootloader", 0, 0);
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		goto write_err;
+
+	/* Failures from here on end up at no_end, which returns the error
+	 * without signalling END -- see there.
+	 */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					MXL862XX_FW_READY_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: bootloader not ready: %pe\n", ERR_PTR(ret));
+		goto no_end;
+	}
+
+	/* Step 3: start handshake */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+				   MXL862XX_SB_PDI_START);
+	if (ret < 0)
+		goto write_err;
+
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_START + 1,
+					MXL862XX_FW_ACK_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: start handshake failed: %pe\n", ERR_PTR(ret));
+		goto no_end;
+	}
+
+	/* Step 4: transfer image header */
+	mxl862xx_flash_notify(dl, "Erasing flash", 0, 0);
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+				   MXL862XX_SB_PDI_CTRL_WR);
+	if (ret < 0)
+		goto write_err;
+
+	for (i = 0; i < MXL862XX_FW_HDR_SIZE / 2; i++) {
+		word = fw->data[i * 2] |
+		       ((u16)fw->data[i * 2 + 1] << 8);
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, word);
+		if (ret < 0)
+			goto write_err;
+	}
+
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		goto write_err;
+
+	/* the byte count in STAT triggers the erase */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+				   MXL862XX_FW_HDR_SIZE);
+	if (ret < 0)
+		goto write_err;
+
+	/* The ACK is the count + 1, replaced by 0 as soon as the erase is done,
+	 * so wait for the count to go: a short erase retires the ACK between
+	 * two polls.
+	 */
+	ret = read_poll_timeout(mxl862xx_smdio_read, val,
+				val < 0 || (u16)val != MXL862XX_FW_HDR_SIZE,
+				10000, MXL862XX_FW_ACK_TIMEOUT_MS * 1000, false,
+				priv, MXL862XX_SB_PDI_STAT);
+	if (val < 0)
+		ret = val;
+	if (!ret && (u16)val != MXL862XX_FW_HDR_SIZE + 1 && (u16)val != 0)
+		ret = -EPROTO;
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: header ACK failed: %pe\n", ERR_PTR(ret));
+		goto no_end;
+	}
+
+	/* Step 5: wait for erase to complete */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, 0,
+					MXL862XX_FW_ERASE_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: erase failed: %pe\n", ERR_PTR(ret));
+		goto no_end;
+	}
+
+	/* Step 6: transfer payload */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+				   MXL862XX_SB_PDI_CTRL_WR);
+	if (ret < 0)
+		goto write_err;
+
+	while (idx < payload_size) {
+		cond_resched();
+		if (idx + 1 < payload_size) {
+			fdata = payload[idx] |
+				((u16)payload[idx + 1] << 8);
+			idx += 2;
+			data_written += 2;
+		} else {
+			fdata = payload[idx];
+			idx++;
+			data_written++;
+		}
+
+		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, fdata);
+		if (ret < 0)
+			goto write_err;
+		word_idx++;
+
+		if (idx >= payload_size) {
+			ret = mxl862xx_sb_pdi_flush_last(priv, data_written);
+			break;
+		}
+
+		/* Half-bank boundary: switch to SB1 address */
+		if (word_idx == MXL862XX_FW_BANK_HALF) {
+			ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+						   MXL862XX_SB_PDI_CTRL_RST);
+			if (ret < 0)
+				goto write_err;
+
+			ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
+						   MXL862XX_FW_SB1_ADDR);
+			if (ret < 0)
+				goto write_err;
+
+			ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+						   MXL862XX_SB_PDI_CTRL_WR);
+			if (ret < 0)
+				goto write_err;
+		} else if (word_idx >= MXL862XX_FW_BANK_SLICE) {
+			ret = mxl862xx_sb_pdi_flush_slice(priv, data_written);
+			if (ret) {
+				dev_err(&priv->mdiodev->dev,
+					"flash: write failed at %u/%u: %pe\n",
+					idx, payload_size, ERR_PTR(ret));
+				goto no_end;
+			}
+			word_idx = 0;
+			data_written = 0;
+			ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+						   MXL862XX_SB_PDI_CTRL_WR);
+			if (ret < 0)
+				goto write_err;
+
+			if (time_after(jiffies, next_notify)) {
+				mxl862xx_flash_notify(dl, "Flashing", idx,
+						      payload_size);
+				next_notify = jiffies + msecs_to_jiffies(500);
+			}
+		}
+	}
+
+	if (ret) {
+		/* a rejected image (-EBADMSG) has been logged where it was seen */
+		if (ret != -EBADMSG)
+			dev_err(&priv->mdiodev->dev,
+				"flash: final slice failed: %pe\n", ERR_PTR(ret));
+		goto no_end;
+	}
+
+	mxl862xx_flash_notify(dl, "Flashing", payload_size, payload_size);
+
+	/* Success: the loader has left the receive loop at r_remain == 0 and
+	 * verified the image, so END(0x3cc3) is a finalise/boot request rather
+	 * than a byte count. Signal it here -- and only here -- to boot the new
+	 * image without waiting out the loader's 2 s END timeout.
+	 */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+				   MXL862XX_SB_PDI_END);
+	if (ret < 0)
+		dev_warn(&priv->mdiodev->dev,
+			 "flash: END signalling failed, waiting the loader out: %pe\n",
+			 ERR_PTR(ret));
+
+	msleep(MXL862XX_FW_REBOOT_DELAY_MS);
+	return 0;
+
+write_err:
+	dev_err(&priv->mdiodev->dev, "flash: SMDIO write failed: %pe\n",
+		ERR_PTR(ret));
+no_end:
+	/* A failure may leave the loader mid transfer, where a STAT write is a
+	 * byte count and END would be misread as one, risking a receive-counter
+	 * underflow, so END is never signalled here. The caller reprobes.
+	 */
+	return ret;
+}
+
+int mxl862xx_devlink_info_get(struct dsa_switch *ds,
+			      struct devlink_info_req *req,
+			      struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	char buf[16];
+	int ret;
+
+	/* A 0 part number means the CHIP ID read failed, the part is unfused
+	 * or a flash failed; omit it rather than publish a bogus "0000" that
+	 * fwupd would match firmware against, it then falls back to the
+	 * driver name.
+	 */
+	if (priv->asic_id) {
+		snprintf(buf, sizeof(buf), "%04X", priv->asic_id);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+						     buf);
+		if (ret)
+			return ret;
+
+		snprintf(buf, sizeof(buf), "%u", priv->asic_rev);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	/* An all-zero version is the cache a failed flash left behind, not a
+	 * released firmware; omit it like the part number above.
+	 */
+	if (!priv->fw_version.major && !priv->fw_version.minor &&
+	    !priv->fw_version.revision)
+		return 0;
+
+	snprintf(buf, sizeof(buf), "%u.%u.%u",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	ret = devlink_info_version_running_put(req,
+			DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+	if (ret)
+		return ret;
+
+	/* boots this image from its own flash: stored == running */
+	return devlink_info_version_stored_put(req,
+			DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+}
+
+int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u32 payload_size;
+	int ret, err, i;
+
+	/* devlink registers the switch before the DSA core creates its user
+	 * ports, which it publishes without rtnl held.
+	 */
+	if (!ds->dst->setup) {
+		NL_SET_ERR_MSG_MOD(extack, "switch tree is not set up");
+		return -EBUSY;
+	}
+
+	/* Written under the instance lock this call is holding. */
+	if (priv->shutting_down) {
+		NL_SET_ERR_MSG_MOD(extack, "device is shutting down");
+		return -ENODEV;
+	}
+
+	/* A previous flash has short-circuited the firmware API until the
+	 * reprobe or a rebind, so the raw SB PDI writes below would run
+	 * against a switch this driver no longer tracks.
+	 */
+	if (priv->skip_teardown) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "a previous flash left the driver awaiting reinitialisation");
+		return -EBUSY;
+	}
+
+	ret = mxl862xx_flash_validate(priv, params->fw, &payload_size);
+	if (ret) {
+		NL_SET_ERR_MSG_MOD(extack, "firmware image validation failed");
+		return ret;
+	}
+
+	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	/* Close ports while the firmware is still alive so the DSA core's
+	 * MDB/FDB tracking is drained, and detach user ports so userspace
+	 * cannot reopen them during the flash. The conduit is only closed,
+	 * not detached: it belongs to the MAC driver. This driver binds a
+	 * single switch with a direct host link and no cascade ports, so the
+	 * conduit serves only this switch, and flashing it reboots the switch,
+	 * which takes the tree down regardless.
+	 */
+	rtnl_lock();
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dp->user) {
+			dev_close(dp->user);
+			netif_device_detach(dp->user);
+		}
+	}
+	dsa_switch_for_each_cpu_port(dp, ds)
+		dev_close(dp->conduit);
+	/* The bridge defers the STP state changes triggered by closing
+	 * the ports; let them reach the firmware while it is still alive.
+	 */
+	switchdev_deferred_process();
+	rtnl_unlock();
+	/* The bridge's host address deletions run on the DSA workqueue. */
+	dsa_flush_workqueue();
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	priv->block_host = true;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+	disable_delayed_work_sync(&priv->stats_work);
+	cancel_work_sync(&priv->crc_err_work);
+	for (i = 0; i < ds->num_ports; i++)
+		cancel_work_sync(&priv->ports[i].host_flood_work);
+
+	ret = mxl862xx_flash_firmware(priv, params->fw, payload_size,
+				      ds->devlink);
+	if (ret == -EBADMSG)
+		NL_SET_ERR_MSG_MOD(extack, "loader rejected the image");
+	else if (ret)
+		NL_SET_ERR_MSG_MOD(extack, "firmware update failed");
+
+	if (!ret) {
+		mutex_lock_nested(&priv->mdiodev->bus->mdio_lock,
+				  MDIO_MUTEX_NESTED);
+		/* Keep block_host set so host writes stay blocked, but let the
+		 * readiness poll below read the freshly booted firmware.
+		 */
+		priv->flash_owner = current;
+		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+		/* Refresh the cached versions so the flash update only
+		 * completes once the new firmware is confirmed running and
+		 * devlink dev info reports it. Must happen before setting
+		 * skip_teardown, which discards all firmware API reads.
+		 */
+		ret = mxl862xx_wait_ready(ds);
+		if (ret)
+			NL_SET_ERR_MSG_MOD(extack,
+					   "new firmware did not become ready");
+	}
+
+	if (ret) {
+		/* The loader may hold an erased or partly written image; drop
+		 * the cached identity so devlink dev info stops reporting the
+		 * pre-flash version until the reprobe re-reads the truth.
+		 */
+		memset(&priv->fw_version, 0, sizeof(priv->fw_version));
+		priv->asic_id = 0;
+		priv->asic_rev = 0;
+	}
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	priv->flash_owner = NULL;
+	priv->block_host = false;
+	priv->skip_teardown = true;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	/* Reinitialise through a deferred re-probe: remove() runs with
+	 * skip_teardown set, then a fresh probe() starts against whatever
+	 * the switch now runs. The core drops the re-probe if the device is
+	 * unbound or deleted before it fires.
+	 */
+	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);
+	/* -EINVAL is a device being deleted, whose teardown takes over. */
+	if (err == -EINVAL)
+		err = 0;
+	if (err)
+		dev_err(ds->dev,
+			"flash: re-probe could not be scheduled (%pe); unbind and rebind to reinitialise\n",
+			ERR_PTR(err));
+	if (err && !ret)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "new firmware is running, the driver needs rebinding");
+
+	return ret ? ret : err;
+}
+
+/* The devlink core holds the instance lock across a flash, so taking it here
+ * waits for a transfer in flight instead of cutting the image in half, and
+ * bars one that has not started yet.
+ */
+void mxl862xx_flash_shutdown(struct dsa_switch *ds)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (!ds->devlink)
+		return;
+
+	/* A flash holds the instance lock for its whole run. Announce the
+	 * wait so the delay is not mistaken for a hang.
+	 */
+	if (!devl_trylock(ds->devlink)) {
+		dev_info(ds->dev,
+			 "firmware update in progress, waiting for it to finish\n");
+		devl_lock(ds->devlink);
+	}
+	priv->shutting_down = true;
+	devl_unlock(ds->devlink);
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
new file mode 100644
index 0000000000000..15ed3a46bcfe2
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MXL862XX_FW_H
+#define __MXL862XX_FW_H
+
+#include <net/dsa.h>
+
+struct mxl862xx_priv;
+
+int mxl862xx_devlink_info_get(struct dsa_switch *ds,
+			      struct devlink_info_req *req,
+			      struct netlink_ext_ack *extack);
+int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack);
+void mxl862xx_flash_shutdown(struct dsa_switch *ds);
+
+#endif /* __MXL862XX_FW_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 6fc04a38675ae..b229c4512b82c 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -12,9 +12,11 @@
 #include <linux/crc16.h>
 #include <linux/iopoll.h>
 #include <linux/limits.h>
+#include <linux/sched.h>
 #include <linux/unaligned.h>
 #include <net/dsa.h>
 #include "mxl862xx.h"
+#include "mxl862xx-cmd.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -327,6 +329,17 @@ static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
 	return ret;
 }
 
+bool mxl862xx_api_gated(struct mxl862xx_priv *priv)
+{
+	bool gated;
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	gated = priv->block_host || priv->skip_teardown;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	return gated;
+}
+
 int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 		      u16 size, bool read, bool quiet)
 {
@@ -340,6 +353,24 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
 
+	if (priv->skip_teardown) {
+		ret = read ? -ENODEV : 0;
+		goto out;
+	}
+
+	/* During the post-flash readiness poll block_host stays set, but the
+	 * flash path's own firmware version reads must reach the new image;
+	 * host writes stay blocked so stale resource IDs cannot corrupt it.
+	 * A blocked write reports success: the reprobe discards the switch
+	 * configuration anyway, and a bridge tearing down over a flash must
+	 * not see port_vlan_del() fail, which leaks its VLAN group.
+	 */
+	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE &&
+	    !(read && priv->flash_owner == current)) {
+		ret = read ? -EBUSY : 0;
+		goto out;
+	}
+
 	max = (size + 1) / 2;
 
 	ret = mxl862xx_busy_wait(priv);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
index 4e054c6e4c0e4..8b3a41de065ff 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -7,6 +7,7 @@
 
 void mxl862xx_host_init(struct mxl862xx_priv *priv);
 void mxl862xx_host_shutdown(struct mxl862xx_priv *priv);
+bool mxl862xx_api_gated(struct mxl862xx_priv *priv);
 int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
 		      bool read, bool quiet);
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index e05ad52cd297e..e6f710c676e65 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -21,6 +21,7 @@
 #include "mxl862xx.h"
 #include "mxl862xx-api.h"
 #include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
 #include "mxl862xx-host.h"
 #include "mxl862xx-phylink.h"
 
@@ -71,6 +72,13 @@ static const struct ethtool_rmon_hist_range mxl862xx_rmon_ranges[] = {
 #define MXL862XX_READY_TIMEOUT_MS	10000
 #define MXL862XX_READY_POLL_MS		100
 
+/* Chip ID registers, read via SYS_MISC_REG_RD */
+#define MXL862XX_CHIPID_L		0xc0d28884
+#define MXL862XX_CHIPID_M		0xc0d28888
+#define MXL862XX_CHIPID_L_PNUML		GENMASK(15, 12)
+#define MXL862XX_CHIPID_M_PNUMM		GENMASK(11, 0)
+#define MXL862XX_CHIPID_M_VERSION	GENMASK(14, 12)
+
 #define MXL862XX_TCM_INST_SEL		0xe00
 #define MXL862XX_TCM_CBS		0xe12
 #define MXL862XX_TCM_EBS		0xe13
@@ -222,7 +230,48 @@ static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int addr,
 	return mxl862xx_phy_write_mmd(bus->priv, addr, devadd, regnum, val);
 }
 
-static int mxl862xx_wait_ready(struct dsa_switch *ds)
+/* The CHIP ID registers are only readable through the firmware mailbox, so
+ * the values are cached here and stay zero while no firmware answers.
+ */
+static int mxl862xx_read_chip_id(struct mxl862xx_priv *priv)
+{
+	struct mxl862xx_sys_reg_rw reg = {};
+	u16 chipid_l, chipid_m;
+	int ret;
+
+	priv->asic_id = 0;
+	priv->asic_rev = 0;
+
+	reg.addr = cpu_to_le32(MXL862XX_CHIPID_L);
+	ret = MXL862XX_API_READ(priv, SYS_MISC_REG_RD, reg);
+	if (ret)
+		return ret;
+	chipid_l = le32_to_cpu(reg.val);
+
+	reg.addr = cpu_to_le32(MXL862XX_CHIPID_M);
+	ret = MXL862XX_API_READ(priv, SYS_MISC_REG_RD, reg);
+	if (ret)
+		return ret;
+	chipid_m = le32_to_cpu(reg.val);
+
+	priv->asic_id = FIELD_GET(MXL862XX_CHIPID_L_PNUML, chipid_l) |
+			FIELD_GET(MXL862XX_CHIPID_M_PNUMM, chipid_m) << 4;
+	priv->asic_rev = FIELD_GET(MXL862XX_CHIPID_M_VERSION, chipid_m);
+
+	return 0;
+}
+
+/**
+ * mxl862xx_wait_ready - wait for the switch firmware to become operational
+ * @ds: DSA switch instance
+ *
+ * Poll the firmware until it reports its version and accepts
+ * configuration commands, then cache the firmware version, and the chip
+ * ID when it can be read. Takes at least two seconds.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int mxl862xx_wait_ready(struct dsa_switch *ds)
 {
 	struct mxl862xx_sys_fw_image_version ver = {};
 	unsigned long start = jiffies, timeout;
@@ -254,6 +303,11 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
 		priv->fw_version.major = ver.iv_major;
 		priv->fw_version.minor = ver.iv_minor;
 		priv->fw_version.revision = le16_to_cpu(ver.iv_revision);
+
+		ret = mxl862xx_read_chip_id(priv);
+		if (ret)
+			dev_warn(ds->dev, "failed to read chip ID: %pe\n",
+				 ERR_PTR(ret));
 		return 0;
 
 not_ready_yet:
@@ -1547,6 +1601,12 @@ static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
 	qparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	/* A flash blocks the API (-EBUSY) and its teardown drops the MAC
+	 * table (-ENODEV); there is then nothing to program, and the reprobe
+	 * starts from a fresh configuration. See mxl862xx_port_mdb_del().
+	 */
+	if ((ret == -EBUSY || ret == -ENODEV) && mxl862xx_api_gated(priv))
+		return 0;
 	if (ret)
 		return ret;
 
@@ -1584,6 +1644,12 @@ static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
 	ether_addr_copy(qparam.mac, mdb->addr);
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	/* A flash blocks the API (-EBUSY) and its teardown drops the MAC
+	 * table (-ENODEV); a delete then has nothing to do. Outside these,
+	 * both are bus errors and must be reported.
+	 */
+	if ((ret == -EBUSY || ret == -ENODEV) && mxl862xx_api_gated(priv))
+		return 0;
 	if (ret)
 		return ret;
 
@@ -1818,6 +1884,11 @@ static void mxl862xx_get_ethtool_stats(struct dsa_switch *ds, int port,
 	void *field;
 
 	ret = mxl862xx_read_rmon(ds, port, &cnt);
+	/* The flash gates refuse with these, and ethtool -S needs no privilege
+	 * to reach them, so they must not log.
+	 */
+	if ((ret == -EBUSY || ret == -ENODEV) && mxl862xx_api_gated(ds->priv))
+		return;
 	if (ret) {
 		dev_err(ds->dev, "failed to read RMON stats on port %d\n", port);
 		return;
@@ -2097,6 +2168,8 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_pause_stats = mxl862xx_get_pause_stats,
 	.get_rmon_stats = mxl862xx_get_rmon_stats,
 	.get_stats64 = mxl862xx_get_stats64,
+	.devlink_info_get = mxl862xx_devlink_info_get,
+	.devlink_flash_update = mxl862xx_devlink_flash_update,
 };
 
 static int mxl862xx_probe(struct mdio_device *mdiodev)
@@ -2161,6 +2234,12 @@ static void mxl862xx_remove(struct mdio_device *mdiodev)
 
 	priv = ds->priv;
 
+	/* Wait out a flash in flight and bar a new one before the DSA core
+	 * frees the user netdevs; the devlink instance lock does not cover
+	 * that free, which dsa_unregister_switch() reaches first.
+	 */
+	mxl862xx_flash_shutdown(ds);
+
 	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
 
 	dsa_unregister_switch(ds);
@@ -2187,6 +2266,8 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 
 	priv = ds->priv;
 
+	mxl862xx_flash_shutdown(ds);
+
 	dsa_switch_shutdown(ds);
 
 	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 432a5f3f2e08e..7d6bee9fa33d7 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -298,11 +298,18 @@ struct mxl862xx_fw_version {
  *                      before CRC-triggered shutdown and cleared after;
  *                      %MXL862XX_FLAG_WORK_STOPPED is set before cancelling
  *                      stats_work to prevent rescheduling during teardown
+ *                      and a flash
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
- * @fw_version:         cached firmware version, populated at probe and
- *                      compared with MXL862XX_FW_VER_MIN()
+ * @fw_version:         cached firmware version, compared with
+ *                      MXL862XX_FW_VER_MIN(); refreshed by
+ *                      mxl862xx_wait_ready() after a flash and cleared by
+ *                      a failed one until the reprobe
+ * @asic_id:            chip part number read from the CHIP ID registers,
+ *                      reported as the devlink "asic.id" fixed version
+ * @asic_rev:           chip version read from the CHIP ID registers,
+ *                      reported as the devlink "asic.rev" fixed version
  * @serdes_ports:       SerDes interfaces incl. sub-interfaces in case of
  *                      10G_QXGMII or QSGMII
  * @serdes_refcount:    per-XPCS count of sub-ports enabled by phylink;
@@ -319,6 +326,20 @@ struct mxl862xx_fw_version {
  * @evlan_ingress_size: per-port ingress Extended VLAN block size
  * @evlan_egress_size:  per-port egress Extended VLAN block size
  * @vf_block_size:      per-port VLAN Filter block size
+ * @block_host:         during a firmware flash, a host firmware read fails
+ *                      with -EBUSY and a write reports success without
+ *                      touching the bus, so a teardown racing the flash
+ *                      does not fail; FW_UPDATE and the flash owner's own
+ *                      reads still reach the bus
+ * @flash_owner:        task running the post-flash readiness poll; only its
+ *                      own firmware reads pass block_host
+ * @skip_teardown:      from the end of a flash until the reprobe, or a rebind
+ *                      when the reprobe could not be scheduled, a host
+ *                      firmware read fails with -ENODEV and a write reports
+ *                      success without touching the bus
+ * @shutting_down:      set under the devlink instance lock once ->shutdown()
+ *                      or .remove() has begun, so no flash starts while the
+ *                      switch is going away
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -329,6 +350,8 @@ struct mxl862xx_priv {
 	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_fw_version fw_version;
+	u16 asic_id;
+	u8 asic_rev;
 	struct mxl862xx_pcs serdes_ports[8];
 	int serdes_refcount[2];
 	struct mutex serdes_lock;
@@ -337,7 +360,13 @@ struct mxl862xx_priv {
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	struct task_struct *flash_owner;
+	bool block_host;
+	bool skip_teardown;
+	bool shutting_down;
 	struct delayed_work stats_work;
 };
 
+int mxl862xx_wait_ready(struct dsa_switch *ds);
+
 #endif /* __MXL862XX_H */
-- 
2.56.0
