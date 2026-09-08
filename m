Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2E531B05
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870238; cv=none; b=Vppb4j9EgypIF95Cnaiqx314D16xxvVpvA/f1piViV/waHBe6AU3G+NgdOEZM97VP1yPZn2vLefwLOogWHspFlHyMiQmnKncgdqvnvSZNBbGRyDbA1MahP7rweYQayWxIZWAULeUUeeeF2ymNMycByrc3KeILruGfXAZ7OCxWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870238; c=relaxed/simple;
	bh=PqATjzEsz8MT0VIzTuHg8oPgXD9uUghWm95ZYTMEEGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnZR9xUE7dXAZV99yunJD2f/lwnrgzTVj8wGEBBIcoTMG0lZ1XWbe3xxQQCjjuErG6H56FEqRu1c7b3r2jArBQyJ/zaXxRqByuNBs9zjm7m+WLlLQxTqvlJGmlYSIcPamY2Tn+bDBU9AueMra5BCGXiMOBiE9aH5qLHU+QVuG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ/kbwdh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ/kbwdh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so64276675e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870234; x=1789475034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5xe6HHIWqtBdovbW5N5/pJK08vk6nkZiNA8TFPACwlE=;
        b=hQ/kbwdh4ZFplLlfhzZMaWoeZbpqQiDdu9VxTuvzyK6zYFfbqX5Ht5UN8xKCNFwwjF
         MRfNHUsGtp9bcRfes7WdTaagl6WAiiymEJkPQrF56aNeG9GVjpNNut4Hg913Wz3yRtfY
         O7jtlAjhbbqDezWMmF6Z2hsUi2vid1sZDsFUrF29jreDdS0Mtd5Si8sayz+GnO7MMsxN
         YM0ll0E4OJ6Dy71TD1H+L1b5H+oQMPsUdoYA645Kfu23a67kAaOXiUHu1I5HG/3pfvxl
         9hh2p6voWIMw94CdD7whxF59idUbLj9YTz/Sh74G1+8+tILXj+9mrstYTnxcF5nSBLLo
         7t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870234; x=1789475034;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xe6HHIWqtBdovbW5N5/pJK08vk6nkZiNA8TFPACwlE=;
        b=lTmqyFctUZvgK4r/61NwNdGO32C67tVboB6S4s60FW2HY0AzvkRPz50YgH8oqxLlob
         i3Q/8t7vLvyXQb5DINchJIYaGjMEaNIDbwvUnYec0gQ97OZdoHQou65uAbmXxSO08ORv
         Lyxlyrb7Hwa1i97nRoFdD4MreOMxZeIas6Gk4d2tNoDxSIeK7FasiekfTEZFNhD5NjE9
         9m14DMro1U9PB9TJ0r0fp6PQslfBrWjdpATss1Cs0MneOAu7UmsS33QGNb4YCROLT1O4
         Gcpl4tf2eAVI2B/6mUXxLHkwa4rZ/LE9RGTGuOPNSLBNH8km7IfVfkdHBonM+bZTM5D2
         PlQA==
X-Gm-Message-State: AFuF++mguReIjwmNSZR1r+Vp4lkewMTrWSrtJppWTysSb2gGMqBXjCpe
	GSTvhzB4Png2Fnn2Pa1pch6l8agilq5F5/a4yQ4PriKlisxm28OOHXUXNkXjnq6Z
X-Gm-Gg: AYBFou2wMwgDPO1GY+T+xU9p38p5jJYrIvCn1YRgRB9SzwyCWXGlNMfI+jI1xbEBTp3
	Yw/5bTo9389i9nbgO228B2PUh3fu5fk3SJPL2e+rQkfsGWBQ8hJf/+2mwwUzqT+m/cuwvl0P0hB
	GvVd6EOAUHXuTvwgOJlFB/dOSB7NG6Cg2BCb3oLCqRxxc8Oe4AH/wnBz8hqa1niD6cdmSrwjpK3
	07loMnYnGABsvuK3BTnfstxMSAXCckbeNSdoto7rEOOY+gA1hQFBIBbx705kD8oshDtTck5lfCt
	2cEqLog1Hq69QeMeF3I+dwvA+/o/tCRI7TlSdfj3rfF2aJljO3T0WlrZPYF1lp3mW1q/Kg93mgp
	t1CfSGK/h+myte2cLQ9HeHwCHenx7wlqvf5moFMZ5oXB3rGTAdssDQpfH2/cxfJ9OPolL9GHQ/U
	tZ/HLdaP6zD83L0lBNep9XKXZ0HXcq1dn2dsZPMY47Q2Soz80fcOryyO7tCeA0w0P/OxTa7oLIY
	kJ1dBixJwpC1Yi8i7tZubqxqlYCaOf5tp7rzcRbzyWzBTDE0LeMj5yBc5k5Z0/5kyeLq0qPhTr/
	unU=
X-Received: by 2002:a05:600c:3f06:b0:49d:1cc3:fa9a with SMTP id 5b1f17b1804b1-49d1cc3fde0mr23542435e9.14.1788870233677;
        Tue, 08 Sep 2026 05:23:53 -0700 (PDT)
Received: from fedora-tap.advaoptical.com (bzq-84-110-212-205.static-ip.bezeqint.net. [84.110.212.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm496744995e9.6.2026.09.08.05.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:23:53 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v13 2/2] ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1
Date: Tue,  8 Sep 2026 15:23:28 +0300
Message-ID: <20260908122328.52641-3-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260908122328.52641-1-maimon.sagi@gmail.com>
References: <20260908122328.52641-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Lattice MachXO3 CPLD on the ADVA TimeCard X1 is programmed over I2C
using in-system programming (ISP).  Build on the TMC bus arbitration
added previously and expose the update path through the kernel
firmware-upload subsystem.

The framework acquires the bus, erases the configuration flash, programs
the image page-by-page and activates it with the MachXO3 REFRESH
command.  The upload node is registered per card as adva-cpld.N, using
the same index as the owning ocpN device, so a host with more than one
X1 board gets one node each:

  /sys/class/firmware/adva-cpld.N/

The whole prepare/write/poll_complete/cleanup sequence runs under
cpld_lock and the i2c adapter lock, so an EEPROM read blocks for as long
as programming takes; the alternative is reading the TMC bus instead.
The upload is unregistered first on detach, which cancels and flushes an
in-flight programming cycle while the I2C controller is still up.

Select FW_LOADER and FW_UPLOAD, as the documented update path does not
exist without them.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Documentation/ABI/testing/sysfs-timecard |   4 +
 drivers/ptp/Kconfig                      |   2 +
 drivers/ptp/ptp_ocp.c                    | 381 ++++++++++++++++++++++-
 3 files changed, 383 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 70ecc15b347f..8c0d41c941ad 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -30,6 +30,10 @@ Description:	(RO, root only) The status register of the TAP CPLD, in
 		ID of the CPLD is read once at probe and reported as the
 		fixed "cpld.id" version by devlink dev info.
 
+		To program new CPLD firmware use the standard kernel
+		firmware-upload interface, registered per card at:
+		/sys/class/firmware/adva-cpld.N/
+		where N is the index of this ocpN device.
 
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index feb50f8cc406..24f047c37e4c 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -219,6 +219,8 @@ config PTP_1588_CLOCK_OCP
 	select NET_DEVLINK
 	select CRC16
 	select DPLL
+	select FW_LOADER
+	select FW_UPLOAD
 	help
 	  This driver adds support for an OpenCompute time card.
 
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7db1dc9b94bd..6eefc3db586f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -20,12 +20,14 @@
 #include <linux/spi/altera.h>
 #include <net/devlink.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/mtd/mtd.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
 #include <linux/dpll.h>
 #include <linux/unaligned.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
@@ -436,6 +438,12 @@ struct ptp_ocp {
 	bool			cpld_id_tried;
 	/* x1 TAP CPLD present */
 	bool			has_cpld;
+	/* firmware upload handle; NULL if absent */
+	struct fw_upload	*cpld_fw_upload;
+	/* cancellation requested */
+	bool			cpld_cancel;
+	/* EN_CFG_TP issued but not yet REFRESH'd */
+	bool			cpld_in_config_mode;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -469,6 +477,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static const struct fw_upload_ops adva_cpld_upload_ops;
+
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
 
@@ -3232,6 +3242,29 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	ptp_ocp_sma_init(bp);
 
 	bp->has_cpld = info->has_cpld;
+	if (bp->has_cpld) {
+		struct fw_upload *fwl;
+		const char *name;
+
+		/* One instance per card, numbered like the ocpN device.
+		 * firmware_upload_register() keeps the pointer rather than
+		 * copying the string, so it has to outlive the registration.
+		 */
+		name = devm_kasprintf(&bp->pdev->dev, GFP_KERNEL,
+				      "adva-cpld.%d", bp->id);
+		if (!name)
+			return -ENOMEM;
+
+		fwl = firmware_upload_register(THIS_MODULE, &bp->pdev->dev,
+					       name, &adva_cpld_upload_ops, bp);
+		if (IS_ERR(fwl))
+			dev_warn(&bp->pdev->dev,
+				 "CPLD firmware upload unavailable: %pe\n",
+				 fwl);
+		else
+			bp->cpld_fw_upload = fwl;
+	}
+
 	return ptp_ocp_init_clock(bp, &info->servo);
 }
 
@@ -4293,6 +4326,15 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 /* Lattice LCMXO3LF ISC command codes */
 #define CPLD_CMD_READ_ID      0xE0000000UL
 #define CPLD_CMD_READ_STATUS  0x3C000000UL
+#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mode */
+#define CPLD_CMD_DIS_CFG      0x26
+#define CPLD_CMD_ERASE        0x0E
+#define CPLD_CMD_RESET_ADDR   0x46
+#define CPLD_CMD_WRITE_PAGE   0x70
+#define CPLD_CMD_SET_DONE     0x5E
+#define CPLD_CMD_REFRESH      0x79
+#define CPLD_PAGE_SIZE        16
+#define CPLD_POLL_US          10000  /* status poll interval while busy */
 
 /* Status register bit positions (Lattice LCMXO3LF datasheet) */
 #define CPLD_STATUS_DONE   BIT(8)
@@ -4307,9 +4349,10 @@ static const struct ocp_attr_group art_timecard_groups[] = {
  *
  * The message is assembled in the scratch buffer taken by
  * adva_x1_bus_claim(), so an opcode and its arguments are copied exactly
- * once.  I2C_M_DMA_SAFE is deliberately not set: no adapter that can bind
- * here does DMA, and the two halves are not separately aligned, so the
- * core is left free to bounce.
+ * once and an upload costs one allocation, not one per page.
+ * I2C_M_DMA_SAFE is deliberately not set: no adapter that can bind here
+ * does DMA, and the two halves are not separately aligned, so the core is
+ * left free to bounce.
  *
  * Caller must hold that claim, hence __i2c_transfer() over i2c_transfer().
  */
@@ -4447,7 +4490,9 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
 		return -ENODEV;
 	}
 
-	/* One scratch buffer per claim, not per transfer. */
+	/* One scratch buffer per claim rather than per transfer: an upload
+	 * holds the claim for the whole image.
+	 */
 	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);
 	if (!bp->cpld_buf) {
 		i2c_put_adapter(adap);
@@ -4475,6 +4520,48 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
 	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, val, NULL, 0, NULL, 0);
 }
 
+/*
+ * Argument bytes that follow an ISC opcode.  Returns NULL with @nargs set
+ * when the arguments are all zero: adva_x1_i2c_xfer() zeroes the buffer.
+ */
+static const u8 *adva_x1_cpld_args(u8 cmd, u8 *nargs)
+{
+	static const u8 en_cfg_tp[] = { 0x08, 0x00 };
+	/* cfg sector only */
+	static const u8 erase_cfg[] = { 0x04, 0x00, 0x00 };
+
+	switch (cmd) {
+	case CPLD_CMD_EN_CFG_TP:
+		*nargs = sizeof(en_cfg_tp);
+		return en_cfg_tp;
+	case CPLD_CMD_ERASE:
+		*nargs = sizeof(erase_cfg);
+		return erase_cfg;
+	case CPLD_CMD_RESET_ADDR:
+	case CPLD_CMD_SET_DONE:
+		*nargs = 3;
+		return NULL;
+	case CPLD_CMD_DIS_CFG:
+	case CPLD_CMD_REFRESH:
+		*nargs = 2;
+		return NULL;
+	default:
+		*nargs = 0;
+		return NULL;
+	}
+}
+
+/* Send an ISC command with the fixed arguments that belong to it. */
+static int adva_x1_cpld_write(struct ptp_ocp *bp, u8 cmd)
+{
+	const u8 *args;
+	u8 nargs;
+
+	args = adva_x1_cpld_args(cmd, &nargs);
+
+	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, cmd, args, nargs, NULL, 0);
+}
+
 /*
  * Send a 4-byte command then read data back without an intermediate STOP
  * (Lattice combined write->repeated-START->read).  Two messages in one
@@ -4500,6 +4587,55 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
 	return 0;
 }
 
+/* Poll the status register until the CPLD goes idle, or @max_ms elapses.
+ * The deadline is on wall time, so the I2C transactions count against it,
+ * and the status is read once more after it expires before giving up.
+ */
+static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
+{
+	u32 status = 0;
+	int err, ret;
+
+	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
+				err || READ_ONCE(bp->cpld_cancel) ||
+				(status & CPLD_STATUS_FAILED) ||
+				!(status & CPLD_STATUS_BUSY),
+				CPLD_POLL_US, max_ms * USEC_PER_MSEC, false,
+				bp, &status);
+	if (ret)
+		return ret;
+	if (READ_ONCE(bp->cpld_cancel))
+		return -ECANCELED;
+	if (err || (status & CPLD_STATUS_FAILED))
+		return -EIO;
+
+	return 0;
+}
+
+/* Map an errno onto the category userspace reads back from
+ * /sys/class/firmware/adva-cpld.N/error.  A step aborted by cancel() must
+ * be reported as such, not as a HW error.
+ */
+static enum fw_upload_err adva_cpld_err(struct ptp_ocp *bp, int err)
+{
+	if (READ_ONCE(bp->cpld_cancel))
+		return FW_UPLOAD_ERR_CANCELED;
+
+	switch (err) {
+	case -ECANCELED:
+		return FW_UPLOAD_ERR_CANCELED;
+	case -ETIMEDOUT:
+		return FW_UPLOAD_ERR_TIMEOUT;
+	case -ENOMEM:
+		return FW_UPLOAD_ERR_BUSY;
+	case -ENODEV:
+	case -EIO:		/* FAILED status, or a short transfer */
+		return FW_UPLOAD_ERR_HW_ERROR;
+	default:		/* from the i2c controller itself */
+		return FW_UPLOAD_ERR_RW_ERROR;
+	}
+}
+
 /*
  * Read the Lattice device ID into bp->cpld_id.  Done once, off the
  * unprivileged devlink path, which reports the cached value only.
@@ -4572,6 +4708,234 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_ADMIN_RO(cpld_status);
 
+/*
+ * adva_x1 CPLD firmware-upload callbacks.
+ *
+ * The kernel firmware-upload subsystem (CONFIG_FW_UPLOAD) exposes:
+ *   /sys/class/firmware/adva-cpld.N/{data,loading,status,error,...}
+ * where N is the index of the owning ocpN device.
+ * Userspace writes the raw binary page data directly — no /lib/firmware/
+ * staging file is needed.
+ *
+ * Callback sequence driven by the framework:
+ *   prepare()      - validate size, acquire bus, enable config, erase flash
+ *   write()        - program one 16-byte page per call
+ *   poll_complete()- set DONE, REFRESH, wait for CPLD to reboot
+ *   cancel()       - set flag; checked on entry to each callback
+ *   cleanup()      - release bus resources (called on success or failure)
+ */
+static enum fw_upload_err
+adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
+{
+	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
+	struct ptp_ocp *bp = fwl->dd_handle;
+	int err;
+
+	/* Do not clear cpld_cancel here: fw_upload_start() queues the work
+	 * before this runs, so a cancel may already have arrived - honour it
+	 * before touching the hardware.  It is cleared once the upload is
+	 * over, on every exit below and in cleanup().
+	 */
+	if (READ_ONCE(bp->cpld_cancel)) {
+		WRITE_ONCE(bp->cpld_cancel, false);
+		return FW_UPLOAD_ERR_CANCELED;
+	}
+
+	if (!size || size % CPLD_PAGE_SIZE) {
+		WRITE_ONCE(bp->cpld_cancel, false);
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	bp->cpld_in_config_mode = false;
+
+	mutex_lock(&bp->cpld_lock);
+
+	err = adva_x1_bus_claim(bp);
+	if (err) {
+		ret = adva_cpld_err(bp, err);
+		goto err_unlock;
+	}
+
+	err = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (err) {
+		ret = adva_cpld_err(bp, err);
+		goto err_release;
+	}
+
+	/* Set before issuing EN_CFG_TP, not after it completes: the CPLD may
+	 * have entered configuration mode even if the write reports an error
+	 * or the wait below times out, and err_deselect only sends DIS_CFG
+	 * when this is set.  A DIS_CFG to a device that never entered the
+	 * mode is harmless; leaving it enabled is not.
+	 */
+	bp->cpld_in_config_mode = true;
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, 5000);
+	if (err) {
+		ret = adva_cpld_err(bp, err);
+		goto err_deselect;
+	}
+
+	if (READ_ONCE(bp->cpld_cancel)) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_deselect;
+	}
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, 15000);
+	if (err) {
+		ret = adva_cpld_err(bp, err);
+		goto err_deselect;
+	}
+
+	if (READ_ONCE(bp->cpld_cancel)) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_deselect;
+	}
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR);
+	if (err) {
+		ret = adva_cpld_err(bp, err);
+		goto err_deselect;
+	}
+
+	/* cleanup() unlocks everything.  fw_upload_main() only pairs it with
+	 * a prepare() that succeeded, so the error paths below unlock here
+	 * instead; hand the context to cleanup() for sparse's benefit.
+	 */
+	__release(&bp->cpld_lock);
+	return FW_UPLOAD_ERR_NONE;
+
+err_deselect:
+	if (bp->cpld_in_config_mode) {
+		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
+		bp->cpld_in_config_mode = false;
+	}
+	adva_x1_mux_select(bp, -1);
+err_release:
+	adva_x1_bus_release(bp);
+err_unlock:
+	WRITE_ONCE(bp->cpld_cancel, false);
+	mutex_unlock(&bp->cpld_lock);
+	return ret;
+}
+
+static enum fw_upload_err
+adva_cpld_write(struct fw_upload *fwl, const u8 *data,
+		u32 offset, u32 size, u32 *written)
+{
+	struct ptp_ocp *bp = fwl->dd_handle;
+	u8 args[3 + CPLD_PAGE_SIZE] = { 0x00, 0x00, 0x01 };
+	int err;
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	if (READ_ONCE(bp->cpld_cancel))
+		return FW_UPLOAD_ERR_CANCELED;
+
+	if (size < CPLD_PAGE_SIZE)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	memcpy(&args[3], data + offset, CPLD_PAGE_SIZE);
+
+	err = adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, CPLD_CMD_WRITE_PAGE,
+			       args, sizeof(args), NULL, 0);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, 100);
+	if (err)
+		return adva_cpld_err(bp, err);
+
+	*written = CPLD_PAGE_SIZE;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err
+adva_cpld_poll_complete(struct fw_upload *fwl)
+{
+	struct ptp_ocp *bp = fwl->dd_handle;
+	int err;
+	u32 st;
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	if (READ_ONCE(bp->cpld_cancel))
+		return FW_UPLOAD_ERR_CANCELED;
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, 1000);
+	if (err)
+		return adva_cpld_err(bp, err);
+
+	err = adva_x1_cpld_read_status(bp, &st);
+	if (err)
+		return adva_cpld_err(bp, err);
+	if (!(st & CPLD_STATUS_DONE))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_REFRESH);
+	if (err)
+		return adva_cpld_err(bp, err);
+
+	/* REFRESH reboots the CPLD out of configuration mode, so cleanup()
+	 * must not send DIS_CFG afterwards even if the checks below fail.
+	 */
+	bp->cpld_in_config_mode = false;
+
+	/* The new image is already running at this point, so a segment that
+	 * is not back yet must not be reported as a failed update: retry the
+	 * reselect instead of sampling the mux once at a fixed delay.
+	 */
+	msleep(1500);
+	if (read_poll_timeout(adva_x1_mux_select, err, !err, CPLD_POLL_US,
+			      3000 * USEC_PER_MSEC, false,
+			      bp, ADVA_MUX_CHANNEL))
+		return FW_UPLOAD_ERR_TIMEOUT;
+
+	err = adva_x1_cpld_wait_ready(bp, 3000);
+	if (err)
+		return adva_cpld_err(bp, err);
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void
+adva_cpld_cancel(struct fw_upload *fwl)
+{
+	struct ptp_ocp *bp = fwl->dd_handle;
+
+	WRITE_ONCE(bp->cpld_cancel, true);
+}
+
+static void
+adva_cpld_cleanup(struct fw_upload *fwl)
+{
+	struct ptp_ocp *bp = fwl->dd_handle;
+
+	__acquire(&bp->cpld_lock);	/* held since prepare() returned ok */
+	lockdep_assert_held(&bp->cpld_lock);
+
+	if (bp->cpld_in_config_mode) {
+		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
+		bp->cpld_in_config_mode = false;
+	}
+	adva_x1_mux_select(bp, -1);
+	adva_x1_bus_release(bp);
+	WRITE_ONCE(bp->cpld_cancel, false);
+	mutex_unlock(&bp->cpld_lock);
+}
+
+static const struct fw_upload_ops adva_cpld_upload_ops = {
+	.prepare	 = adva_cpld_prepare,
+	.write		 = adva_cpld_write,
+	.poll_complete	 = adva_cpld_poll_complete,
+	.cancel		 = adva_cpld_cancel,
+	.cleanup	 = adva_cpld_cleanup,
+};
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
@@ -5214,6 +5578,15 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 {
 	int i;
 
+	/* Must come first: cancels and flushes an in-flight upload while the
+	 * I2C controller is still up, and drops cpld_lock so a cpld_status
+	 * reader cannot stall ptp_ocp_attr_group_del() below.
+	 */
+	if (bp->cpld_fw_upload) {
+		firmware_upload_unregister(bp->cpld_fw_upload);
+		bp->cpld_fw_upload = NULL;
+	}
+
 	ptp_ocp_debugfs_remove_device(bp);
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
-- 
2.47.0

