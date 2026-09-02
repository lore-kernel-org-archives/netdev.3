Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A061364049
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324163; cv=none; b=KZV6dYR3zpBFOqiKk9PYbgyhulUnJq9IL7kVKyU6fdwDpPNsAodhoLs8QySTnfWnV519lGlaU9wij4dY1hca4+UHP7V4WaTv56ceenOD0ROKYeJHYGoxTOJ1JyrXx8UGLIoMoC0h3GPhtlenr5tOevQVAcDGYli7RQlj6N6RZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324163; c=relaxed/simple;
	bh=zKcOsopog3ozOOI0SpKf+SNlaGytXOSh8NeVVfv+5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYirJEHwXxGizpn9NwhIzo9sbXJgpYmRUrGXoXsFs/0Sxz49mhR0Am3SO4GW4q5S/wZE++TyNzBRA0O1Vndh49o7d3Fuwr/GZaagYNGXDr1VzXXLbixx+nReKbgf7D6vnZvStU6zf7yOU44eeKzEk73jzwcenFD+AzpN5Xsqglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJLP/PQb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJLP/PQb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13797505e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788324159; x=1788928959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=57wAP4mib+WI09ZmMIhwcEbcz1OUYmBvTso2sDX7ALI=;
        b=UJLP/PQbdG2289uBx81dCmpqxutgSUDkV/B0DWyym30/ob3lQ/wMpJBFeGHRbwKjVn
         rD8QrNqvxqfuu45onjc9tbocIpgtkyhBwYiGBzQPKSXGAQ0fmXrVjzLGWP0GJa/KFUbj
         dR6i/stBpkd9z3+ifQ9hKPB2JgaJlkcp/gCJa3psj1KUcb0XquhA2Z26ZpLlY4KfcuAv
         U78pmdv3anXiABjua30mJDSumoJKVVpAwo5xL6OTigY2YGlljcILgGk3+ns55STk4Dwk
         EH1KEARGqBisUxGuhVdThldCNcfs7aAEyfO9IMHnQ0b97aRjAA4FElRA3gQ9WqCpwwjt
         w+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788324159; x=1788928959;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57wAP4mib+WI09ZmMIhwcEbcz1OUYmBvTso2sDX7ALI=;
        b=G4bP+tMxm51pBMplW0BDQFmvqiLxACFGXAMrw/BGuI6r2ZfHWKCNXaGcYUAbGaDq6N
         RdDnJeiJo7qIWZ51XgDd4KRJNvK8OEWfIEXsSwwaorupxuAF1zuphu/eZglblaftpNgV
         75ft7nqVDrmWw8uviTg3OiLbD2tsUfZC35+rtcJHjQelahMy7LnMkJJW7UXWngNdhbhC
         wP49vOkQTT+ARk/bbaozYooXq+OFp1yE7KjGxXNQ+CFT+b9ZzFM7ajMKqojz3WE19jdV
         LZIpIOs+xCDiQh26X/EkdjWdOfoeYr9hdBVARFyeZfh/ottIBtx57b4ylsGdIb2/V5UE
         4QNQ==
X-Gm-Message-State: AFuF++k1DtthRuRgIaiY3500Kg7CW6uH7id+y+mr//GF+FoyNLR+/B99
	R4jQ4/X9VbAXB+q+sS9ltwKllJrJcW8LSMUnV5dTYIe6wW3xXxzTrFbRl0nLm0Lq
X-Gm-Gg: AR+sD11yLdM6YknyMsG5Xw/+8rS2jsdA9h0ZVCXUMAYCPBFFAlvpHnAwtBSCtQZYxbp
	tKH1acqygCbvgQrkyIcqhZlqR3vbj94nG8YV0aP5tqKjDkVdSrM9bSzkYghA5Nt9DcH1kJycQub
	hFn0L+RVnpVGyF3Q7DUPfy3SY8Up+Qza94LStpCOB78kGKSsY0A6I/8CQC/4bVTQKNciXHiClI0
	/GqjTrjS5tyREz4R/pDjh9i4lkLtaEXTREo45Ub1eBnP29qxMORlYR8rA6gxZJvM+icS5VgEsk3
	R342zz8YcIDlWa+odQCbpqoCUHy6l8sJ4LG5cXpJ7BKY9J5SbUQtmUWh2o+Ir813SXLoh71KnKz
	xCjaZxbHcmu6XRWpGS15J8V0DwknpgpwQTjNu64m8gSvM6c6l4F/jxhyQVvqfNowPoKEDL6DDuL
	Hi1XlFXIdrmS1wgPjaOR9h775YExFtLtKfOXWvV6NTr472+3S290OaN3wmkkYyDldceN/ztYJBo
	fHxzDMttMvRSQT4cyZ3PihU1I/6Dg==
X-Received: by 2002:a05:600c:4f87:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49ce7bb7823mr5603765e9.1.1788324159253;
        Tue, 01 Sep 2026 21:42:39 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm127274165e9.4.2026.09.01.21.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:42:38 -0700 (PDT)
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
Subject: [PATCH net-next v12 2/2] ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1
Date: Wed,  2 Sep 2026 07:42:32 +0300
Message-ID: <20260902044232.21188-3-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260902044232.21188-1-maimon.sagi@gmail.com>
References: <20260902044232.21188-1-maimon.sagi@gmail.com>
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
 drivers/ptp/ptp_ocp.c                    | 335 ++++++++++++++++++++++-
 3 files changed, 339 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index b384e837c5e6..41eeadd46330 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -30,6 +30,10 @@ Description:	(RO, root only) The status register of the TAP CPLD, in
 		ID of the CPLD is reported as the fixed "cpld.id" version by
 		devlink dev info.
 
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
index 0c5c3ec8de5f..86d1c1a311cc 100644
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
 
@@ -427,6 +429,9 @@ struct ptp_ocp {
 	u8			*cpld_buf;            /* DMA-safe scratch; valid under cpld_lock */
 	u32			cpld_id;              /* cached Lattice device ID; 0 if unread */
 	bool			has_cpld;             /* x1 TAP CPLD present */
+	struct fw_upload	*cpld_fw_upload;      /* firmware upload handle; NULL if absent */
+	bool			cpld_cancel;          /* cancellation requested */
+	bool			cpld_in_config_mode;  /* EN_CFG_TP issued but not yet REFRESH'd */
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -460,6 +465,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static const struct fw_upload_ops adva_cpld_upload_ops;
+
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
 static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id);
@@ -3226,6 +3233,29 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
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
 
@@ -4287,6 +4317,15 @@ static const struct ocp_attr_group art_timecard_groups[] = {
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
@@ -4301,7 +4340,8 @@ static const struct ocp_attr_group art_timecard_groups[] = {
  *
  * The message is assembled in the scratch buffer taken by
  * adva_x1_bus_claim(), which the Xilinx controller needs for DMA safety:
- * an opcode and its arguments are copied exactly once.
+ * an opcode and its arguments are copied exactly once, and a firmware
+ * upload costs one allocation rather than one per page.
  *
  * Caller must hold that claim, hence __i2c_transfer() over i2c_transfer().
  */
@@ -4432,7 +4472,10 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
 	if (!adap)
 		return -ENODEV;
 
-	/* One scratch buffer per claim, not per transfer. */
+	/* One scratch buffer per claim rather than per transfer: a firmware
+	 * upload holds the claim for the whole image, so this is a single
+	 * allocation instead of one for each 16-byte page.
+	 */
 	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);
 	if (!bp->cpld_buf) {
 		i2c_put_adapter(adap);
@@ -4460,6 +4503,47 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
 	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, val, NULL, 0, NULL, 0);
 }
 
+/*
+ * Argument bytes that follow an ISC opcode.  Returns NULL with @nargs set
+ * when the arguments are all zero: adva_x1_i2c_xfer() zeroes the buffer.
+ */
+static const u8 *adva_x1_cpld_args(u8 cmd, u8 *nargs)
+{
+	static const u8 en_cfg_tp[] = { 0x08, 0x00 };
+	static const u8 erase_cfg[] = { 0x04, 0x00, 0x00 }; /* cfg sector only */
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
@@ -4485,6 +4569,38 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
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
+/* A step aborted by cancel() must be reported as such, not as a HW error. */
+static enum fw_upload_err adva_cpld_err(struct ptp_ocp *bp)
+{
+	return READ_ONCE(bp->cpld_cancel) ? FW_UPLOAD_ERR_CANCELED
+					  : FW_UPLOAD_ERR_HW_ERROR;
+}
+
 /*
  * Read the Lattice device ID of the TAP CPLD.  It is a fixed property of
  * the part, so cache it and pay the bus arbitration only once.  The
@@ -4562,6 +4678,212 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
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
+ *   cancel()       - set flag; checked at the start of each callback
+ *   cleanup()      - release bus resources (called on success or failure)
+ */
+static enum fw_upload_err
+adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
+{
+	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
+	struct ptp_ocp *bp = fwl->dd_handle;
+
+	/* Do not clear cpld_cancel here: fw_upload_start() queues the work
+	 * before this runs, so a cancel may already have arrived.  It is
+	 * cleared once the upload is over, on every exit below and in
+	 * cleanup().
+	 */
+	if (!size || size % CPLD_PAGE_SIZE) {
+		WRITE_ONCE(bp->cpld_cancel, false);
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	bp->cpld_in_config_mode = false;
+
+	mutex_lock(&bp->cpld_lock);
+
+	if (adva_x1_bus_claim(bp)) {
+		ret = FW_UPLOAD_ERR_TIMEOUT;
+		goto err_unlock;
+	}
+
+	if (adva_x1_mux_select(bp, ADVA_MUX_CHANNEL)) {
+		ret = FW_UPLOAD_ERR_HW_ERROR;
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
+	if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP) ||
+	    adva_x1_cpld_wait_ready(bp, 5000)) {
+		ret = adva_cpld_err(bp);
+		goto err_deselect;
+	}
+
+	if (READ_ONCE(bp->cpld_cancel)) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_deselect;
+	}
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE) ||
+	    adva_x1_cpld_wait_ready(bp, 15000)) {
+		ret = adva_cpld_err(bp);
+		goto err_deselect;
+	}
+
+	if (READ_ONCE(bp->cpld_cancel)) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_deselect;
+	}
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR)) {
+		ret = FW_UPLOAD_ERR_HW_ERROR;
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
+	if (adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, CPLD_CMD_WRITE_PAGE,
+			     args, sizeof(args), NULL, 0) ||
+	    adva_x1_cpld_wait_ready(bp, 100))
+		return adva_cpld_err(bp);
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
+	if (adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE) ||
+	    adva_x1_cpld_wait_ready(bp, 1000))
+		return adva_cpld_err(bp);
+
+	if (adva_x1_cpld_read_status(bp, &st) || !(st & CPLD_STATUS_DONE))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_REFRESH))
+		return FW_UPLOAD_ERR_HW_ERROR;
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
+	if (adva_x1_cpld_wait_ready(bp, 3000))
+		return READ_ONCE(bp->cpld_cancel) ? FW_UPLOAD_ERR_CANCELED
+						  : FW_UPLOAD_ERR_TIMEOUT;
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
@@ -5204,6 +5526,15 @@ ptp_ocp_detach(struct ptp_ocp *bp)
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

