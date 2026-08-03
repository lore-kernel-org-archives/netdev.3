Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81912384CEB;
	Mon,  3 Aug 2026 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729141; cv=none; b=f3fYpD69RBPzNlJCi4PR9qv8k+o2ZZ5MaDtB3mTPE4Q1GgpuOimA0BSDP69OK6p1q9phficgR9wiS38Uq48qLODNt8EBNqTWf+SczU7O9FJ+fWOPYwKPRKbDknPUPvGgCfw4EnWZYdU2Cw/KsQTxuaL+Vw4cRgSZQfe++EpHI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729141; c=relaxed/simple;
	bh=IGnPvw0/WdhBkdofKvvIUL33/OrQkStuaaVDq24Z/bU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuxOToQi0zyPiftFDjV2d38yHcWQwbXK+6c7kdTEzv3sPhVz3GGtP+dnbeIHwjwjJGx+OQ7pdSg58E6OCDUgBjePlqfjZKzS5xyez7ldOtNsvClxjNCbSDVBj7XLr5wx/11RUukcsc6mvJ7y2NZchOBFxc24aqBB0BjDvFhyJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wqjig-000000004cz-2rQz;
	Mon, 03 Aug 2026 03:52:06 +0000
Date: Mon, 3 Aug 2026 04:52:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 3/5] net: dsa: mxl862xx: add devlink flash_update
 and info_get
Message-ID: <574e63147db06e60cc7209136d25f07c2e54df89.1785728574.git.daniel@makrotopia.org>
References: <cover.1785728574.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785728574.git.daniel@makrotopia.org>

Implement runtime firmware upgrade via "devlink dev flash" and version
reporting via "devlink dev info":

  $ devlink dev info mdio_bus/mdio-bus:10
  mdio_bus/mdio-bus:10:
    driver mxl862xx
    versions:
        fixed:
          asic.id 8628
          asic.rev 0
        running:
          fw 1.0.70
        stored:
          fw 1.0.70

The "asic.id" and "asic.rev" fixed versions carry the numeric chip part
number and revision from the static CHIP ID registers (SYS_MISC_REG_RD),
which userspace such as fwupd matches firmware against; they are omitted
if the read fails or the part is unfused, so no bogus "0000" is
published. The switch boots its firmware from its own flash, so "fw" is
reported as both the running and the stored version; a flashless part
would omit "stored", distinguishing the two without an API change.

  $ devlink dev flash mdio_bus/mdio-bus:10 file mxl862xx-fw.bin

The image, including both payload CRCs, is validated first, so a
malformed file is rejected without disturbing the running switch. The
driver then sends SYS_MISC_FW_UPDATE, which reboots the switch into its
MCUboot bootloader, and transfers the signed image over the SB PDI
protocol (clause-22 SMDIO), checking every write: a failed address write
at the half-bank boundary would otherwise misplace half the payload
unnoticed. A successful transfer reboots the switch into the new
firmware. The loader verifies the image once the last slice has been
programmed and publishes the verdict, so a rejected image is reported as
such rather than as a transfer timeout. The whole cycle takes just under
a minute.

For its duration the driver closes all user and conduit interfaces and
marks the user ports not-present with netif_device_detach() so userspace
cannot reopen them; the conduit belongs to the MAC driver and is only
closed. This also stops phylib polling the switch-internal PHYs,
unreachable in MCUboot. The bridge's deferred STP DISABLED transitions
are flushed under rtnl so they reach the firmware while it still runs;
the stats poll and CRC error handler are stopped; and firmware API
commands from other paths are blocked under the MDIO bus lock so none
reaches the bus once the switch has rebooted. Progress is reported
through devlink status notifications.

The switch leaves MCUboot on its own by booting the new image, but the
driver has no in-place path back, so it reinitialises with a full
device_reprobe() scheduled regardless of the transfer outcome. During
the teardown its API reads return -ENODEV and writes fake success, so it
neither stalls on the absent firmware nor consumes buffers it never
filled; port_mdb_del() takes that -ENODEV for a MAC table that is gone
and reports success, since there is nothing left to delete. The reprobe
holds module and device references taken before the switch was disturbed
and runs from a work item, off the devlink caller's locking and signal
context; it frees itself and drops both references when it finishes. A
failed reprobe leaves the device unbound, exactly as a failed initial
probe would, and a further flash is refused until it has run. An aborted
transfer leaves the switch in MCUboot, where nothing here can reach it;
the next patch adds the detection that makes such a switch flashable
again.

The closed user ports and conduit are not returned to their pre-flash
administrative state across the reprobe; userspace brings them back up,
and restoring it in-driver would need DSA-core support that does not
yet exist.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

 drivers/net/dsa/mxl862xx/Makefile        |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h  |  10 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 698 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  17 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |  11 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |  68 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  14 +
 8 files changed, 820 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h

diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
index a7be0e6669df..bccac0d0f703 100644
--- a/drivers/net/dsa/mxl862xx/Makefile
+++ b/drivers/net/dsa/mxl862xx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
-mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o
+mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o mxl862xx-fw.o
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
index a180a5decffc..6f771895984c 100644
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
index c87a955c13c4..a865425aa61e 100644
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
index 000000000000..8caaf68c7569
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -0,0 +1,698 @@
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
+ *       a lingering count does not distinguish "busy" from "verdict".
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/overflow.h>
+#include <linux/rtnetlink.h>
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
+#define MXL862XX_FW_BANK_SLICE		32760	/* words per full slice */
+#define MXL862XX_FW_SB1_ADDR		0x7800	/* SB1 word address */
+
+/* Timeouts (generous upper bounds) */
+#define MXL862XX_FW_READY_TIMEOUT_MS	3000
+#define MXL862XX_FW_ACK_TIMEOUT_MS	5000
+#define MXL862XX_FW_ERASE_TIMEOUT_MS	300000
+#define MXL862XX_FW_WRITE_TIMEOUT_MS	120000
+#define MXL862XX_FW_REBOOT_DELAY_MS	5000
+#define MXL862XX_FW_REPROBE_DELAY_MS	500
+
+static int mxl862xx_sb_pdi_reset(struct mxl862xx_priv *priv)
+{
+	int ret;
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+				   MXL862XX_SB_PDI_CTRL_RST);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
+				   MXL862XX_SB_PDI_CTRL_RST);
+	if (ret < 0)
+		return ret;
+
+	return mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
+				    MXL862XX_SB_PDI_CTRL_RST);
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
+				10000, MXL862XX_FW_WRITE_TIMEOUT_MS * 1000,
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
+/* Post-flash reprobe. device_reprobe() detaches the driver -- running
+ * remove(), which frees priv -- then re-probes, so this work touches only its
+ * own device and module references and frees itself. A re-probe failure leaves
+ * the device unbound, exactly as a failed initial probe would, so it is only
+ * logged. Running from a workqueue keeps device_reprobe() out of the devlink
+ * caller's locking and signal context.
+ */
+struct mxl862xx_reprobe {
+	struct delayed_work work;
+	struct device *dev;
+};
+
+static void mxl862xx_reprobe_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_reprobe *rp =
+		container_of(work, struct mxl862xx_reprobe, work.work);
+	struct device *dev = rp->dev;
+
+	if (device_reprobe(dev))
+		dev_err(dev, "reprobe failed; device left unbound\n");
+	put_device(dev);
+	kfree(rp);
+	module_put(THIS_MODULE);
+}
+
+/* Allocate the reprobe up front, before the switch is disturbed, so an
+ * allocation failure aborts cleanly. The caller holds a module and a device
+ * reference; the work releases both once it runs. Returns NULL on -ENOMEM.
+ */
+static struct mxl862xx_reprobe *mxl862xx_reprobe_alloc(struct device *dev)
+{
+	struct mxl862xx_reprobe *rp;
+
+	rp = kzalloc_obj(*rp);
+	if (!rp)
+		return NULL;
+	rp->dev = dev;
+	INIT_DELAYED_WORK(&rp->work, mxl862xx_reprobe_work_fn);
+	return rp;
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
+	int ret, i;
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
+	/* ACK is byte count + 1 */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_FW_HDR_SIZE + 1,
+					MXL862XX_FW_ACK_TIMEOUT_MS);
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
+			"flash: erase timeout: %pe\n", ERR_PTR(ret));
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
+					"flash: write timeout at %u/%u: %pe\n",
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
+		dev_err(&priv->mdiodev->dev,
+			"flash: final slice failed: %pe\n", ERR_PTR(ret));
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
+	msleep(MXL862XX_FW_REBOOT_DELAY_MS);
+	return ret;
+
+write_err:
+	dev_err(&priv->mdiodev->dev, "flash: SMDIO write failed: %pe\n",
+		ERR_PTR(ret));
+no_end:
+	/* A failure leaves the loader mid transfer; do not signal END (a STAT
+	 * write is a byte count then, and END would be misread as one, risking
+	 * a receive-counter underflow). Return the error; the caller reprobes.
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
+	/* A 0 part number means the CHIP ID read failed or the part is
+	 * unfused; omit it rather than publish a bogus "0000" that fwupd
+	 * would match firmware against -- it then falls back to the driver
+	 * name.
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
+	struct mxl862xx_reprobe *ko;
+	struct mxl862xx_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u32 payload_size;
+	int ret, i;
+
+	if (params->component) {
+		NL_SET_ERR_MSG_MOD(extack, "component is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* A previous flash is still waiting for its reprobe: the firmware API
+	 * is short-circuited, so the raw SB PDI writes below would run against
+	 * a switch this driver no longer tracks.
+	 */
+	if (priv->skip_teardown) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "device is reinitializing, retry later");
+		return -EBUSY;
+	}
+
+	ret = mxl862xx_flash_validate(priv, params->fw, &payload_size);
+	if (ret) {
+		NL_SET_ERR_MSG_MOD(extack, "firmware image validation failed");
+		return ret;
+	}
+
+	/* The references the reprobe work needs to restore normal operation
+	 * must be held before the switch is disturbed; the work itself is
+	 * scheduled only once the flash is done (see below).
+	 */
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	get_device(ds->dev);
+
+	/* Allocate the reprobe work before disturbing the switch, so an
+	 * -ENOMEM here cannot strand it flashed but never reprobed.
+	 */
+	ko = mxl862xx_reprobe_alloc(ds->dev);
+	if (!ko) {
+		put_device(ds->dev);
+		module_put(THIS_MODULE);
+		return -ENOMEM;
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
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	priv->block_host = true;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+	cancel_delayed_work_sync(&priv->stats_work);
+	cancel_work_sync(&priv->crc_err_work);
+	for (i = 0; i < ds->num_ports; i++)
+		cancel_work_sync(&priv->ports[i].host_flood_work);
+
+	ret = mxl862xx_flash_firmware(priv, params->fw, payload_size,
+				      ds->devlink);
+	if (ret)
+		NL_SET_ERR_MSG_MOD(extack, "firmware transfer failed");
+
+	if (!ret) {
+		mutex_lock_nested(&priv->mdiodev->bus->mdio_lock,
+				  MDIO_MUTEX_NESTED);
+		priv->block_host = false;
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
+		/* The switch is in MCUboot with erased or partly written flash;
+		 * drop the cached identity so devlink dev info stops reporting
+		 * the pre-flash version until the reprobe re-reads the truth.
+		 */
+		memset(&priv->fw_version, 0, sizeof(priv->fw_version));
+		priv->asic_id = 0;
+		priv->asic_rev = 0;
+	}
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	priv->skip_teardown = true;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	/* Queue the reprobe last; the work was allocated up front and its
+	 * module and device references are already held.
+	 */
+	queue_delayed_work(system_long_wq, &ko->work,
+			   msecs_to_jiffies(MXL862XX_FW_REPROBE_DELAY_MS));
+
+	return ret;
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
new file mode 100644
index 000000000000..e96db19b2888
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -0,0 +1,17 @@
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
+
+#endif /* __MXL862XX_FW_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 11759fa6069b..76f5a78566d9 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -15,6 +15,7 @@
 #include <linux/unaligned.h>
 #include <net/dsa.h>
 #include "mxl862xx.h"
+#include "mxl862xx-cmd.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -340,6 +341,16 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
 
+	if (priv->skip_teardown) {
+		ret = read ? -ENODEV : 0;
+		goto out;
+	}
+
+	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	max = (size + 1) / 2;
 
 	ret = mxl862xx_busy_wait(priv);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 45d237b3a40f..8634a86c4168 100644
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
@@ -222,7 +230,46 @@ static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int addr,
 	return mxl862xx_phy_write_mmd(bus->priv, addr, devadd, regnum, val);
 }
 
-static int mxl862xx_wait_ready(struct dsa_switch *ds)
+/* Read the static chip part number and version from the CHIP ID
+ * registers. Only possible with a running firmware, so the values are
+ * cached at setup and left zero when the switch is in rescue mode.
+ */
+static int mxl862xx_read_chip_id(struct mxl862xx_priv *priv)
+{
+	struct mxl862xx_sys_reg_rw reg = {};
+	u16 chipid_l, chipid_m;
+	int ret;
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
+ * configuration commands, then cache the firmware version and chip ID.
+ * Takes at least two seconds.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int mxl862xx_wait_ready(struct dsa_switch *ds)
 {
 	struct mxl862xx_sys_fw_image_version ver = {};
 	unsigned long start = jiffies, timeout;
@@ -254,6 +301,11 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
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
@@ -1572,6 +1624,12 @@ static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
 	ether_addr_copy(qparam.mac, mdb->addr);
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	/* Post-flash teardown: the firmware and its MAC table are gone, so
+	 * there is nothing left to delete. Outside it, -ENODEV is a bus error
+	 * and must be reported.
+	 */
+	if (ret == -ENODEV && priv->skip_teardown)
+		return 0;
 	if (ret)
 		return ret;
 
@@ -2015,6 +2073,12 @@ static void mxl862xx_stats_work_fn(struct work_struct *work)
 	struct dsa_switch *ds = priv->ds;
 	struct dsa_port *dp;
 
+	/* A get_stats64() re-arm can race the flash teardown's WORK_STOPPED
+	 * set and cancel; bail here so a stray poll never runs during a flash.
+	 */
+	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		return;
+
 	dsa_switch_for_each_available_port(dp, ds)
 		mxl862xx_stats_poll(ds, dp->index);
 
@@ -2086,6 +2150,8 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_pause_stats = mxl862xx_get_pause_stats,
 	.get_rmon_stats = mxl862xx_get_rmon_stats,
 	.get_stats64 = mxl862xx_get_stats64,
+	.devlink_info_get = mxl862xx_devlink_info_get,
+	.devlink_flash_update = mxl862xx_devlink_flash_update,
 };
 
 static int mxl862xx_probe(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 432a5f3f2e08..66989280c59d 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -303,6 +303,10 @@ struct mxl862xx_fw_version {
  *                      flooding)
  * @fw_version:         cached firmware version, populated at probe and
  *                      compared with MXL862XX_FW_VER_MIN()
+ * @asic_id:            chip part number read from the CHIP ID registers,
+ *                      reported as the devlink "asic.id" fixed version
+ * @asic_rev:           chip version read from the CHIP ID registers,
+ *                      reported as the devlink "asic.rev" fixed version
  * @serdes_ports:       SerDes interfaces incl. sub-interfaces in case of
  *                      10G_QXGMII or QSGMII
  * @serdes_refcount:    per-XPCS count of sub-ports enabled by phylink;
@@ -319,6 +323,10 @@ struct mxl862xx_fw_version {
  * @evlan_ingress_size: per-port ingress Extended VLAN block size
  * @evlan_egress_size:  per-port egress Extended VLAN block size
  * @vf_block_size:      per-port VLAN Filter block size
+ * @block_host:         reject firmware API commands (except FW_UPDATE)
+ *                      during a firmware flash
+ * @skip_teardown:      discard firmware API commands during the teardown
+ *                      triggered by the post-flash reprobe
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -329,6 +337,8 @@ struct mxl862xx_priv {
 	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_fw_version fw_version;
+	u16 asic_id;
+	u8 asic_rev;
 	struct mxl862xx_pcs serdes_ports[8];
 	int serdes_refcount[2];
 	struct mutex serdes_lock;
@@ -337,7 +347,11 @@ struct mxl862xx_priv {
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	bool block_host;
+	bool skip_teardown;
 	struct delayed_work stats_work;
 };
 
+int mxl862xx_wait_ready(struct dsa_switch *ds);
+
 #endif /* __MXL862XX_H */
-- 
2.55.0
