Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5A327BFB;
	Wed, 22 Jul 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678453; cv=none; b=PzCG/ROuB6aOMKMa8gLd7hZE631ih09BGUHpGc92jUk1oFQydu+6p16NzzKQyphSt0tTK9cPmh+SNm+jY3LYRN3Cz8FBYuBnB2UX3vfMAVxGQbFV168grl+jrmqx/j65Wi9h868F0/BE/lqqa9GhSg5vYS5O4xvT5jKmFe5mYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678453; c=relaxed/simple;
	bh=R/Qp+TQnSz0vWymEMOM8Qv1v7JCXKccTzut6R0e+kkI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jge4heifhlDTNChhI8RY4405BJtX36pqfT3noyfYBNt7+Wchg9eUgJO5AIfAqLQN+5DQkaKHNU8qBSEvo0Ro7rTa4rm4DXmxigub36GKHRnMAQJK3k4XOY4pxzQ1KBQnhxJLbLLbux+ncb+ucDqpdacXRCZlX34sPyT/wJZfwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wmKOA-000000000Go-3hX5;
	Wed, 22 Jul 2026 00:00:43 +0000
Date: Wed, 22 Jul 2026 01:00:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 3/4] net: dsa: mxl862xx: add devlink flash_update
 and info_get
Message-ID: <f0ecaccf2ffdf57ba7941088220dc8b34fc57cd1.1784665017.git.daniel@makrotopia.org>
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

Implement runtime firmware upgrade via "devlink dev flash" and version
reporting via "devlink dev info":

  devlink dev info mdio_bus/<bus>/<addr>
  devlink dev flash mdio_bus/<bus>/<addr> file <firmware.bin>

The "asic.id" fixed version reports a per-model chip name taken from
the OF match data, e.g. "MaxLinear MxL86252", following the mv88e6xxx
example. Userspace such as fwupd should build firmware matching
identifiers from this value.

The firmware image is validated first, including both payload CRCs,
so a malformed file is rejected without disturbing the running
switch. The driver then sends SYS_MISC_FW_UPDATE to enter MCUboot
rescue mode and transfers the signed image over the SB PDI
bulk-transfer protocol (clause-22 SMDIO). Every SMDIO write during
the transfer is checked; in particular a failed address write during
the half-bank switch would otherwise place the second half of the
payload at the wrong flash offset without any status poll noticing.
Once the transfer has finished and the switch has rebooted, the
driver launches device_reprobe() for a clean remove()+probe() cycle.

Before the transfer begins the driver closes all user and conduit
interfaces and additionally marks the user ports not-present via
netif_device_detach() so that userspace cannot bring them back up
during the flash and reprobe cycle, which takes just under a minute.
The conduit belongs to the MAC driver and is only closed. Closing
the ports also stops phylib from polling the switch-internal PHYs,
whose firmware-relayed MDIO access is unavailable while the switch
is in MCUboot mode. The bridge defers the STP state changes
triggered by closing its ports, so the driver flushes the switchdev
deferred queue while still holding the rtnl lock; the DISABLED
transitions thus reach the firmware while it is still running
instead of failing against the host block later. Progress is
reported through devlink status notifications.

While the update runs, firmware API commands from any other path are
rejected. The blocking flags are read and written under the MDIO bus
lock so that a command which had already passed the check cannot
reach the bus once the switch has rebooted into MCUboot. The block
is never lifted again; SYS_MISC_FW_VERSION is exempt from it so the
new firmware version can be queried after a successful transfer, and
the version query is only issued from the flash path itself. The
periodic stats poll and the CRC error handler are stopped before the
transfer starts.

After the transfer, API read commands fail with -ENODEV while write
commands return fake success: the scheduled reprobe tears the driver
down through remove(), whose teardown writes must not stall on the
absent firmware, but read paths such as an FDB dump must not consume
buffers the firmware never filled -- port_fdb_dump() would loop
forever on such fabricated data. port_mdb_del() maps -ENODEV from
its lookup to successful deletion: the firmware holding the entry is
gone, and reporting failure would only make the DSA core keep the
software entry and report leftover host MDB addresses when the tree
is torn down for the reprobe.

Once the FW_UPDATE command has been sent the switch is in MCUboot
mode and normal operation can only be restored by a reprobe, so the
reprobe kernel thread and the module and device references it holds
are set up before the switch is disturbed and the thread is woken
regardless of transfer outcome.

The reprobe runs in a kernel thread rather than a work item because
device_reprobe() triggers remove() which frees the devm-managed priv,
and a work item's final module_put() would still execute module code
afterwards, racing against module unload. The thread instead exits
through module_put_and_kthread_exit(), which drops the reference from
core-kernel code without returning to module text.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 497 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  15 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |  12 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |  12 +-
 drivers/net/dsa/mxl862xx/mxl862xx.h      |   6 +
 7 files changed, 542 insertions(+), 3 deletions(-)
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
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index c87a955c13c4..e2aa2934e9e1 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -70,6 +70,7 @@
 #define INT_GPHY_READ			(GPY_GPY2XX_MAGIC + 0x1)
 #define INT_GPHY_WRITE			(GPY_GPY2XX_MAGIC + 0x2)
 
+#define SYS_MISC_FW_UPDATE		(SYS_MISC_MAGIC + 0x1)
 #define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
 
 #define MXL862XX_XPCS_PCS_CONFIG	(MXL862XX_XPCS_MAGIC + 0x1)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
new file mode 100644
index 000000000000..4cd8231c7eca
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Firmware flash and devlink support for MaxLinear MxL862xx
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/rtnetlink.h>
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
+#define MXL862XX_SB_PDI_CTRL_WR	0x02
+
+/* SB PDI handshake magic */
+#define MXL862XX_SB_PDI_READY		0xc55c
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
+#define MXL862XX_FW_READY_TIMEOUT_MS	30000
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
+/* device_reprobe() -> remove() frees priv while the thread runs, so
+ * the thread must not dereference priv; it drops its module reference
+ * without returning to module code afterwards.
+ */
+static int mxl862xx_reprobe_thread_fn(void *data)
+{
+	struct device *dev = data;
+
+	msleep(MXL862XX_FW_REPROBE_DELAY_MS);
+	if (device_reprobe(dev))
+		dev_err(dev, "reprobe failed\n");
+	put_device(dev);
+	module_put_and_kthread_exit(0);
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
+	/* Failures from here on must go through end_magic so MCUboot
+	 * reboots instead of waiting forever.
+	 */
+
+	/* Step 2: wait for bootloader ready */
+	mxl862xx_flash_notify(dl, "Waiting for bootloader", 0, 0);
+	ret = mxl862xx_sb_pdi_reset(priv);
+	if (ret < 0)
+		goto write_err;
+
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					MXL862XX_FW_READY_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: bootloader not ready: %pe\n", ERR_PTR(ret));
+		goto end_magic;
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
+		goto end_magic;
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
+		goto end_magic;
+	}
+
+	/* Step 5: wait for erase to complete */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, 0,
+					MXL862XX_FW_ERASE_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: erase timeout: %pe\n", ERR_PTR(ret));
+		goto end_magic;
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
+				goto end_magic;
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
+	const char *model;
+	char ver_str[32];
+	int ret;
+
+	model = device_get_match_data(ds->dev);
+	if (model) {
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+						     model);
+		if (ret)
+			return ret;
+	}
+
+	snprintf(ver_str, sizeof(ver_str), "%u.%u.%u",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	return devlink_info_version_running_put(req, "fw", ver_str);
+}
+
+int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_sys_fw_image_version ver = {};
+	struct mxl862xx_priv *priv = ds->priv;
+	struct task_struct *reprobe;
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
+	/* Everything needed to launch the reprobe which restores
+	 * normal operation must be in place before the switch is
+	 * disturbed.
+	 */
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	reprobe = kthread_create(mxl862xx_reprobe_thread_fn, ds->dev,
+				 "mxl862xx-reprobe");
+	if (IS_ERR(reprobe)) {
+		module_put(THIS_MODULE);
+		return PTR_ERR(reprobe);
+	}
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
+	if (!ret) {
+		/* SYS_MISC_FW_VERSION is exempt from block_host, so the
+		 * new version can be queried with the block still up.
+		 */
+		memset(&ver, 0, sizeof(ver));
+		if (!MXL862XX_API_READ_QUIET(priv, SYS_MISC_FW_VERSION, ver) &&
+		    ver.iv_major)
+			dev_info(ds->dev, "flash: new firmware %u.%u.%u\n",
+				 ver.iv_major, ver.iv_minor,
+				 le16_to_cpu(ver.iv_revision));
+	}
+
+	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	priv->skip_teardown = true;
+	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
+
+	wake_up_process(reprobe);
+
+	return ret;
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
new file mode 100644
index 000000000000..a1b60fbacebf
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MXL862XX_FW_H
+#define __MXL862XX_FW_H
+
+#include <net/dsa.h>
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
index 6e582caea1fa..2b69eac24b31 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -15,6 +15,7 @@
 #include <linux/unaligned.h>
 #include <net/dsa.h>
 #include "mxl862xx.h"
+#include "mxl862xx-cmd.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -340,6 +341,17 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
 
+	if (priv->skip_teardown) {
+		ret = read ? -ENODEV : 0;
+		goto out;
+	}
+
+	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE &&
+	    cmd != SYS_MISC_FW_VERSION) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	max = (size + 1) / 2;
 
 	ret = mxl862xx_busy_wait(priv);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 45d237b3a40f..bf0f2264a931 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -21,6 +21,7 @@
 #include "mxl862xx.h"
 #include "mxl862xx-api.h"
 #include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
 #include "mxl862xx-host.h"
 #include "mxl862xx-phylink.h"
 
@@ -1572,6 +1573,11 @@ static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
 	ether_addr_copy(qparam.mac, mdb->addr);
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
+	/* -ENODEV: the firmware and its MAC table are gone, nothing left
+	 * to delete
+	 */
+	if (ret == -ENODEV)
+		return 0;
 	if (ret)
 		return ret;
 
@@ -2086,6 +2092,8 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_pause_stats = mxl862xx_get_pause_stats,
 	.get_rmon_stats = mxl862xx_get_rmon_stats,
 	.get_stats64 = mxl862xx_get_stats64,
+	.devlink_info_get = mxl862xx_devlink_info_get,
+	.devlink_flash_update = mxl862xx_devlink_flash_update,
 };
 
 static int mxl862xx_probe(struct mdio_device *mdiodev)
@@ -2191,8 +2199,8 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 }
 
 static const struct of_device_id mxl862xx_of_match[] = {
-	{ .compatible = "maxlinear,mxl86282" },
-	{ .compatible = "maxlinear,mxl86252" },
+	{ .compatible = "maxlinear,mxl86282", .data = "MaxLinear MxL86282" },
+	{ .compatible = "maxlinear,mxl86252", .data = "MaxLinear MxL86252" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxl862xx_of_match);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 432a5f3f2e08..64d91ad51936 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -319,6 +319,10 @@ struct mxl862xx_fw_version {
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
@@ -337,6 +341,8 @@ struct mxl862xx_priv {
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	bool block_host;
+	bool skip_teardown;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0
