Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DA299A87;
	Sat, 25 Jul 2026 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784945811; cv=none; b=jAGP+JdGk6lnXnk6+frFF2B/T5y8woWAZ203+GDgWDZrTeHNs7T/hCjfd0ORFIGyXknu0kkFX5+OLUqAIjtELS8h4uec2TGBVzFWyzTpVdoLSPw+Yo0BwNm8I53ZU3giyLkgsjV3IVuK7pco86KDC2q8CoUMtZpOUlhupC/5HlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784945811; c=relaxed/simple;
	bh=JN60oURDJvTkBbDu9O/8/Rn0+L55AfJyxZiTwuYwlBg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8afEJ9847AO27vUo6JA4Bu3qUs3zTNHNESdy+tko7yvlpBCk3Vb0xrNlteqvr+wS4bY4d+xQ2zjDwzSlInqfb28ZpxfGzJDbdZcL+dgGydkeVEfmOMX9H0jnN/JxpqIrzURu6Ar2s30vxLQpT5KZYXJ+XC1BeBMpyTYPjtytko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wnRwQ-000000002kK-0EbG;
	Sat, 25 Jul 2026 02:16:42 +0000
Date: Sat, 25 Jul 2026 03:16:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/5] net: dsa: mxl862xx: add devlink flash_update
 and info_get
Message-ID: <73a63f1d11658a041514f79ae177bfb93153d33a.1784945329.git.daniel@makrotopia.org>
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
which userspace such as fwupd matches firmware against. The switch boots
its firmware from its own flash, so "fw" is reported as both the running
and the stored version; a flashless part would omit "stored",
distinguishing the two without an API change.

  $ devlink dev flash mdio_bus/mdio-bus:10 file mxl862xx-fw.bin

The image, including both payload CRCs, is validated first, so a
malformed file is rejected without disturbing the running switch. The
driver then sends SYS_MISC_FW_UPDATE, which reboots the switch into its
MCUboot bootloader, and transfers the signed image over the SB PDI
protocol (clause-22 SMDIO), checking every write: a failed address write
at the half-bank boundary would otherwise misplace half the payload
unnoticed. A successful transfer reboots the switch into the new
firmware. The whole cycle takes just under a minute.

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
device_reprobe() scheduled regardless of the transfer outcome -- after a
failure the switch is still in MCUboot and probe re-detects it. During
the teardown its API reads return -ENODEV and writes fake success, so it
neither stalls on the absent firmware nor consumes buffers it never
filled. The reprobe holds module and device references taken before the
switch was disturbed and runs from a heap work item, not a kernel
thread: remove() frees the devm-managed priv, and kthread_create() in
the devlink caller would return -EINTR on interrupt or trip the
hung-task watchdog while parked across the minute-long flash.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 572 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  17 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |  11 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |  49 ++
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  12 +
 8 files changed, 674 insertions(+), 1 deletion(-)
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
index 000000000000..cde00e5583ee
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -0,0 +1,572 @@
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
+ *   MII reg 0x1f := <sb_pdi_reg>      ; address/page latch
+ *   MII reg 0x00 := / => <u16 data>   ; data window
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
+ *   END    0x3cc3   host   -> end of transfer / finalise
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
+ *     at word 16384: reset; ADDR:=0x7800; CTRL:=WR   (half-bank -> SB1)
+ *     at word 32760: flush slice:
+ *        reset; STAT := <bytes_this_slice> ---> r_remain -= bytes; program
+ *                          <------------------- STAT=0  (ready for next slice)
+ *   ... repeat until the whole payload is sent ...
+ *   STAT := END(0x3cc3)  ---------------------> finalise
+ *
+ * The r_remain == 0 rule (critical):
+ *   Every host STAT write in the payload phase is a byte count; the loader
+ *   does r_remain -= count and stays in the receive loop while r_remain != 0.
+ *   It leaves the loop, validates, and - if it was in rescue - clears its
+ *   rescue-enable bit so boot_go boots the new image, ONLY when r_remain hits
+ *   EXACTLY 0. A count larger than r_remain underflows the 32-bit counter and
+ *   wedges the loader until a power cycle. Hence:
+ *     - never send a slice/chunk count larger than what is outstanding;
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
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
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int ret;
+
+	do {
+		ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
+		if (ret < 0)
+			return ret;
+		if ((u16)ret == expected)
+			return 0;
+		usleep_range(10000, 11000);
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
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
+static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
+				  u32 done, u32 total)
+{
+	devlink_flash_update_status_notify(dl, status, NULL, done, total);
+}
+
+/* Post-flash reprobe. Runs from a self-contained heap work (not a kthread and
+ * not the devlink caller's context): kthread_create() in the caller context
+ * fails -EINTR if the devlink command was Ctrl-C'd, and schedule_work() cannot.
+ * device_reprobe() -> remove() frees priv, so this must not touch priv; it uses
+ * only the held device reference and drops its module reference afterwards.
+ */
+struct mxl862xx_reprobe_work {
+	struct work_struct work;
+	struct device *dev;
+};
+
+static void mxl862xx_reprobe_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_reprobe_work *rw =
+		container_of(work, struct mxl862xx_reprobe_work, work);
+	struct device *dev = rw->dev;
+
+	msleep(MXL862XX_FW_REPROBE_DELAY_MS);
+	if (device_reprobe(dev))
+		dev_err(dev, "reprobe failed\n");
+	put_device(dev);
+	kfree(rw);
+	module_put(THIS_MODULE);
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
+	/* Failures from here on must go through end_magic so MCUboot
+	 * reboots instead of waiting forever.
+	 */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					MXL862XX_FW_READY_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: bootloader not ready: %pe\n", ERR_PTR(ret));
+		return ret;
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
+		return ret;
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
+		return ret;
+	}
+
+	/* Step 5: wait for erase to complete */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, 0,
+					MXL862XX_FW_ERASE_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: erase timeout: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Step 6: transfer payload */
+	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+				   MXL862XX_SB_PDI_CTRL_WR);
+	if (ret < 0)
+		goto write_err;
+
+	while (idx < payload_size) {
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
+			ret = mxl862xx_sb_pdi_flush_slice(priv, data_written);
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
+				return ret;
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
+			"flash: final write timeout: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	mxl862xx_flash_notify(dl, "Flashing", payload_size, payload_size);
+	goto end_magic;
+
+write_err:
+	dev_err(&priv->mdiodev->dev, "flash: SMDIO write failed: %pe\n",
+		ERR_PTR(ret));
+end_magic:
+	/* reboot MCUboot even after a failed transfer */
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+			     MXL862XX_SB_PDI_END);
+	msleep(MXL862XX_FW_REBOOT_DELAY_MS);
+
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
+	snprintf(buf, sizeof(buf), "%04X", priv->asic_id);
+	ret = devlink_info_version_fixed_put(req,
+					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+					     buf);
+	if (ret)
+		return ret;
+
+	snprintf(buf, sizeof(buf), "%u", priv->asic_rev);
+	ret = devlink_info_version_fixed_put(req,
+					     DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
+					     buf);
+	if (ret)
+		return ret;
+
+	snprintf(buf, sizeof(buf), "%u.%u.%u",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	ret = devlink_info_version_running_put(req, "fw", buf);
+	if (ret)
+		return ret;
+
+	/* boots this image from its own flash: stored == running */
+	return devlink_info_version_stored_put(req, "fw", buf);
+}
+
+int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_reprobe_work *rw;
+	struct dsa_port *dp;
+	u32 payload_size;
+	int ret, i;
+
+	if (params->component) {
+		NL_SET_ERR_MSG_MOD(extack, "component is not supported");
+		return -EOPNOTSUPP;
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
+	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	/* Close ports while the firmware is still alive so the DSA
+	 * core's MDB/FDB tracking is drained, and detach user ports
+	 * so userspace cannot reopen them during the flash. The
+	 * conduit belongs to the MAC driver and is only closed.
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
+	/* The reprobe below re-reads and logs the new version. */
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	priv->skip_teardown = true;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	/* Hand the reprobe to a self-contained work, scheduled last. Doing it
+	 * from a work (rather than a kthread spawned here) avoids both the
+	 * hung-task splat of a thread parked across the flash and the -EINTR
+	 * that kthread_create() returns if the devlink command was Ctrl-C'd.
+	 * Its module and device references are already held above.
+	 */
+	rw = kzalloc_obj(*rw);
+	if (!rw) {
+		dev_err(ds->dev,
+			"flash: out of memory for reprobe; reload the driver to restore operation\n");
+		put_device(ds->dev);
+		module_put(THIS_MODULE);
+		return ret ? ret : -ENOMEM;
+	}
+	INIT_WORK(&rw->work, mxl862xx_reprobe_work_fn);
+	rw->dev = ds->dev;
+	schedule_work(&rw->work);
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
index 6e582caea1fa..66b388eed0ce 100644
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
index 45d237b3a40f..5d4a13beed1a 100644
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
@@ -222,6 +230,35 @@ static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int addr,
 	return mxl862xx_phy_write_mmd(bus->priv, addr, devadd, regnum, val);
 }
 
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
 static int mxl862xx_wait_ready(struct dsa_switch *ds)
 {
 	struct mxl862xx_sys_fw_image_version ver = {};
@@ -254,6 +291,11 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
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
@@ -1572,6 +1614,11 @@ static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
 	ether_addr_copy(qparam.mac, mdb->addr);
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	/* -ENODEV: the firmware and its MAC table are gone, nothing left
+	 * to delete
+	 */
+	if (ret == -ENODEV)
+		return 0;
 	if (ret)
 		return ret;
 
@@ -2086,6 +2133,8 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_pause_stats = mxl862xx_get_pause_stats,
 	.get_rmon_stats = mxl862xx_get_rmon_stats,
 	.get_stats64 = mxl862xx_get_stats64,
+	.devlink_info_get = mxl862xx_devlink_info_get,
+	.devlink_flash_update = mxl862xx_devlink_flash_update,
 };
 
 static int mxl862xx_probe(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 432a5f3f2e08..39535cd58706 100644
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
@@ -337,6 +347,8 @@ struct mxl862xx_priv {
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	bool block_host;
+	bool skip_teardown;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0
