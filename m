Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E353D0C7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572800; cv=none; b=KoxvcPuxzMP9frmF9lHBu1bF/xzynzm3ldvoFVIz3jiN4uUMNPLBGBvT+bkBy9VHf8QISn8YCNnEqeHj0+GiWNxw8D8WvugqH9QUszdg1QQTo9bwPxW2fwuM0c/lLQlXTXmyFNTrinBVONojsBdDjsfP1LTEoAKQwrd9nsF8ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572800; c=relaxed/simple;
	bh=pDwkZQOkMgkJUnkKQxOkVBEmvoCZyTvl8CLttYZiq2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayphWQ6sxNfgSM4M8iYXZ1qB34cLWcMmonl+vJ8ogczyy4dYBGUAPZimWGaF7PGmTAK27o27gy6K1gmUuET37rp5x8qCk9dmPLgHlsruoY0Qqw+A5Z4T7cVTZW4y3T/+DuWKtHVowSedYKzDfXD5NulA1GhGzvuoCnO1Srk6xX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF3DsTUP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF3DsTUP"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a9a2f16ed4so3338067a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572778; x=1790177578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48q2r3ekm1cEhyvq/Xjpxyyg4wW+qTTRNWSDq9Z3+ZU=;
        b=mF3DsTUPCfdyVl9nbvu3etGy6W6SCnrmV9ol3aaU22IzwMBWtnVBwr5eOIt07seYnm
         e0nw6uD3iCyncg4wxxy+nYGqZLCrXgV3mY+whjKlHrA3SoF/Fb8zD5GNXkqVMO6pC6yT
         KIBlcruXPk3sj8Sg40fMy/c9JqszaVIeSXyH1Rvw0FXtHTTOXOHdvwwEdB0C4b7qkBn0
         6EXlgjBXcJz6vVuRdNtwB3zVHn+jRdnT9lO5qEVjC64IrmTPhAeszkpmpBs46Ga/u+/b
         FOkRMhRu3MqZEVXWyrPWsof75/jkCrZlXVj0QZNV++p3E6nY0fp5l2Bi+DPjEMoiYqo7
         WL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572778; x=1790177578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=48q2r3ekm1cEhyvq/Xjpxyyg4wW+qTTRNWSDq9Z3+ZU=;
        b=VyWN0azTYIwJAjCc6CB38AWo3HAUVpv/L5krHCgOfp8yXYBLJDFXZtqs1T2CYihitw
         rC388E8YCreX+nrIBasPMef2Gr8R94vf/lXQMX2UUCscOxmBV9FJOH8JRS5RLc0SrSDH
         uq+2RUIJR6368FTgDADXDuWLV5PmJij+WfVc53H0oObrlHxwKAL4VeKAXvPqzQCZN3of
         1v6B8aH3PRlYGY/mPvHE5l6wyBwrwUpi4Uw8fqzd1sm3xfxlaA850bGkoKurr8e0aFI9
         0vvSigZE7TeJNgGJgeO8gznfuMPRjCehlpdUWSQqM9lAtShKhl0tieFHTS5Kiv93fFto
         Fy9g==
X-Forwarded-Encrypted: i=1; AKwUvBzxYyuZPNWrEXlHfB1YbRNEjnxQgL83ttWhnTjgMhPA5hu2BgOKr03ks3VLlStTuCjTvLFa2p0=@vger.kernel.org
X-Gm-Message-State: AFuF++lTLlskDmQ9HX9I03mMYnJxdwFqwbT1mS0eZPEuc/qj5jHkDb3D
	E/R7HBjFFbaTCPHfIpXOu9XSgPREpq0Uzn06sr/ql4GerU2jCxWjOcJB
X-Gm-Gg: AYBFou1outgksJcW3DZubNNWeCAgXcxRWt6dT9ThoyDt1DvBa/uNjNXXLWjzWA6PUNY
	wfRkIVljcyKXalrIsTH4sIrKBHDLFjCPCYTWKE1HQ6K9EPh+K+T8XFIrOVTwLhEC/YGCKGkXyqK
	PSKknwJBfEncBOu8EDKFVfx3HlLRzz+06Zu8exk1Zm4WvkgTIHgnkwqISxrqFXKPTSh7TfZasbv
	qQ1ZoWRvDd1Vppmxe5uRh5rOI7dFo0QAjsRwKXN2gk1oXY+9kkNjTRn4dvotdmbirniylDZgAlj
	bkENx1yXQwRvJVgqPo98ZsHzT6QrDbNzhZoqnS2sESnxl8+Eo61ykdvH+EAyCcAHXkXNZuunEes
	0Gz0gEwytKjZX9UrwqssXQ9jvu1VvVq8EG98891rIhla3oQ1lAHfC5nM2idTpSgxu/051B75R7u
	p8YAzmAEPNM7OvP9lQSZFgBxANgSNfV2QUW/Hm5SU7JKPfYdA1A0+yblivcdVPZHdsH9qLjXRR7
	HnY2IxSgt6u2T+uHiHD78AfPhsz3JaOPWqVZrhTdA==
X-Received: by 2002:a05:6402:114a:b0:6a9:8c23:e0c0 with SMTP id 4fb4d7f45d1cf-6aa04039ddamr4377696a12.19.1789572777416;
        Wed, 16 Sep 2026 08:32:57 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe0562sm2067081a12.3.2026.09.16.08.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:32:56 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
X-Google-Original-From: Sagi Maimon <sagi.maimon@adtran.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v15 4/4] ptp: ocp: add TAP CPLD flashing via devlink
Date: Wed, 16 Sep 2026 18:32:42 +0300
Message-ID: <20260916153242.157171-5-sagi.maimon@adtran.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260916153242.157171-1-sagi.maimon@adtran.com>
References: <20260916153242.157171-1-sagi.maimon@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sagi Maimon <maimon.sagi@gmail.com>

The Lattice MachXO3 CPLD on the ADVA TimeCard X1 is programmed over I2C
using in-system programming (ISP).  Build on the TMC bus arbitration added
previously and expose the update path as a devlink flash component, next
to the card flash the driver already writes through devlink.

The component is named fw.cpld and reported as a running version, so
->info_get() both publishes the USERCODE of the image currently in the
part and lets the core accept the name:

  devlink dev flash pci/0000:02:00.0 file adva-cpld.bin component fw.cpld

Flashing acquires the bus, erases the configuration flash, programs the
image page by page and activates it with the MachXO3 REFRESH command,
reporting progress with the standard devlink notifications.  The CPLD is
required to come back with DONE set, not busy and no error code before the
update is called successful, as drivers/fpga/machxo2-spi.c does.

The whole sequence runs under cpld_lock and the i2c adapter lock, so an
EEPROM read blocks for as long as programming takes; the alternative is
reading the TMC bus instead.  Flashing is privileged:
DEVLINK_CMD_FLASH_UPDATE carries GENL_ADMIN_PERM.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Documentation/ABI/testing/sysfs-timecard     |  11 +-
 Documentation/networking/devlink/ptp_ocp.rst |  48 +-
 drivers/ptp/ptp_ocp.c                        | 441 ++++++++++++++++++-
 3 files changed, 479 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index e58824e0cdcd..4ba45c6ee4a3 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -31,9 +31,14 @@ Description:	(RO, root only) The flags set in the status register of the
 
 		A read arbitrates for the shared I2C bus and reprograms the
 		on-card mux, so it is restricted to root.  The Lattice device
-		ID of the CPLD is read once by the driver, shortly after
-		probe, and reported from that cached value as the fixed
-		"cpld.id" version by devlink dev info.
+		ID of the CPLD is read by the driver shortly after probe,
+		and again after a successful CPLD update, and reported from
+		that cached value as the fixed "cpld.id" version by
+		devlink dev info.
+
+		New CPLD firmware is programmed with devlink dev flash,
+		selecting the "fw.cpld" component; see
+		Documentation/networking/devlink/ptp_ocp.rst.
 
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
index 3f997cd9f3a3..f94b759d9cd6 100644
--- a/Documentation/networking/devlink/ptp_ocp.rst
+++ b/Documentation/networking/devlink/ptp_ocp.rst
@@ -5,7 +5,7 @@ ptp_ocp devlink support
 ========================
 
 This document describes the devlink features implemented by the ``ptp_ocp``
-device driver.
+device driver: the info versions it reports and its flash update support.
 
 Info versions
 =============
@@ -30,6 +30,46 @@ The ``ptp_ocp`` driver reports the following versions
      - Lattice device ID (IDCODE) of the TAP CPLD, formatted as ``0x%08x``.
        Only present on ADVA TimeCard X1 boards, which are the only ones
        carrying that CPLD.  Reading it claims the shared I2C bus and
-       reprograms the on-card mux, so the driver does that once from its
-       own worker and reports the cached value here; the version is
-       omitted until that read has succeeded.
+       reprograms the on-card mux, so the driver does that from its own
+       worker and reports the cached value here; the version is omitted
+       until that read has succeeded.  The read is made once per binding
+       and again after a successful CPLD update.
+   * - ``fw.cpld``
+     - running
+     - USERCODE of the image programmed into the TAP CPLD, formatted as
+       ``0x%08x``.  Read together with ``cpld.id`` and reported the same
+       way.  This is the component name to pass to ``devlink dev flash``
+       to update the CPLD.
+
+Flash update
+============
+
+The driver implements ``devlink dev flash`` for two separate targets,
+selected with the component name.
+
+.. list-table:: Flash components
+   :widths: 20 80
+
+   * - Component
+     - Description
+   * - (none)
+     - The card's own flash, written through the SPI controller the driver
+       exposes.  The card runs the new image after its next reset.
+   * - ``fw.cpld``
+     - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
+       programmed over I2C with the MachXO3 in-system programming commands
+       and activated with a REFRESH, so the new image runs immediately.
+       The image is the raw configuration bitstream.  The only check the
+       driver makes is that its length is a non-zero multiple of the
+       16-byte page size, so a container such as ``.jed`` has to be
+       converted first rather than passed through - one whose length
+       happens to be a multiple of 16 would be programmed as if it were
+       a bitstream.
+
+Programming the CPLD claims the shared I2C bus for the whole cycle, so
+reads of the card's EEPROM block until it completes.  Progress is reported
+with the standard devlink status notifications.
+
+Example::
+
+    $ devlink dev flash pci/0000:02:00.0 file adva-cpld.bin component fw.cpld
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 998ea9c6b381..2802989e8494 100644
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
 
@@ -434,12 +436,18 @@ struct ptp_ocp {
 	u8			*cpld_buf;
 	/* Lattice device ID; 0 if unread */
 	u32			cpld_id;
+	/* USERCODE of the image in the part; valid once cpld_usercode_ok */
+	u32			cpld_usercode;
+	/* cpld_usercode has been read since the last flash */
+	bool			cpld_usercode_ok;
 	/* one-shot ID read finished, successfully or not; under cpld_lock */
 	bool			cpld_id_tried;
 	/* failed ID read attempts so far; under cpld_lock */
 	unsigned int		cpld_id_attempts;
 	/* x1 TAP CPLD present */
 	bool			has_cpld;
+	/* EN_CFG_TP issued but not yet REFRESH'd */
+	bool			cpld_in_config_mode;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -476,6 +484,13 @@ static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
 
+/* Flash component naming the CPLD image, as reported by ->info_get(). */
+#define ADVA_CPLD_COMPONENT	"fw.cpld"
+
+static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
+			      const struct firmware *fw,
+			      struct netlink_ext_ack *extack);
+
 static const struct ocp_attr_group fb_timecard_groups[];
 
 static const struct ocp_attr_group art_timecard_groups[];
@@ -2158,6 +2173,21 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
 	const char *msg;
 	int err;
 
+	if (params->component) {
+		if (!bp->has_cpld ||
+		    strcmp(params->component, ADVA_CPLD_COMPONENT)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "unsupported flash component");
+			return -EOPNOTSUPP;
+		}
+
+		err = adva_x1_cpld_flash(bp, devlink, params->fw, extack);
+		msg = err ? "Flash error" : "Flash complete";
+		devlink_flash_update_status_notify(devlink, msg,
+						   ADVA_CPLD_COMPONENT, 0, 0);
+		return err;
+	}
+
 	dev = ptp_ocp_find_flash(bp);
 	if (!dev) {
 		dev_err(&bp->pdev->dev, "Can't find Flash SPI adapter\n");
@@ -2180,6 +2210,8 @@ static int
 ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 			 struct netlink_ext_ack *extack)
 {
+	enum devlink_info_version_type ver_type =
+					DEVLINK_INFO_VERSION_TYPE_COMPONENT;
 	struct ptp_ocp *bp = devlink_priv(devlink);
 	const char *fw_image;
 	char buf[32];
@@ -2192,14 +2224,35 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
-	/* Read by the worker, not here: this command is unprivileged and
-	 * reading the ID claims the I2C bus.  0 means unread - skip it
-	 * rather than fail, devlink discards the whole reply on error.
-	 */
-	id = READ_ONCE(bp->cpld_id);
-	if (bp->has_cpld && id) {
-		sprintf(buf, "0x%08x", id);
-		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
+	if (bp->has_cpld) {
+		/* Read by the worker, not here: this command is unprivileged
+		 * and reading the ID claims the I2C bus.  0 means unread -
+		 * skip it rather than fail, devlink discards the whole reply
+		 * on error.
+		 */
+		id = READ_ONCE(bp->cpld_id);
+		if (id) {
+			sprintf(buf, "0x%08x", id);
+			err = devlink_info_version_fixed_put(req, "cpld.id",
+							     buf);
+			if (err)
+				return err;
+		}
+
+		/* The flashable component.  Naming it here is what lets
+		 * "devlink dev flash ... component fw.cpld" through, as the
+		 * core matches the name against the versions reported here,
+		 * so it is reported for every board that has the part and not
+		 * only once its USERCODE has been read: a part left holding a
+		 * bad image answers neither, and gating the component on the
+		 * read would make that state unrecoverable.
+		 */
+		if (smp_load_acquire(&bp->cpld_usercode_ok))
+			sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
+		else
+			strscpy(buf, "unknown", sizeof(buf));
+		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
+							   ver_type);
 		if (err)
 			return err;
 	}
@@ -4306,13 +4359,36 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 
 /* Lattice LCMXO3LF ISC command codes */
 #define CPLD_CMD_READ_ID      0xE0000000UL
+/* The USERCODE lives in the configuration flash that ERASE wipes, and the
+ * page writes carry it: after programming an image whose JEDEC UH field is
+ * 0x00000004 the part reads back 0x00000004, not an erased value.  So there
+ * is no separate ISC_PROGRAM_USERCODE step here.
+ */
+#define CPLD_CMD_READ_USERCODE 0xC0000000UL
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
+/* Bounds how long a claim can hold the i2c root lock, not image validity:
+ * far above any bitstream this part takes.
+ */
+#define CPLD_MAX_IMAGE_SZ     (256 * 1024)
+#define CPLD_EXIT_CFG_TRIES   3
+#define CPLD_ERASE_MS         15000  /* config sector erase, datasheet max */
 #define CPLD_ID_MAX_ATTEMPTS  10     /* one per sync_work tick */
 
 /* Status register bit positions (Lattice LCMXO3LF datasheet) */
 #define CPLD_STATUS_DONE   BIT(8)
+#define CPLD_STATUS_ENAB   BIT(9)
 #define CPLD_STATUS_BUSY   BIT(12)
 #define CPLD_STATUS_FAILED BIT(13)
+#define CPLD_STATUS_ERR    GENMASK(25, 23)
 
 /*
  * Issue one I2C transaction on the TMC bus: @cmd if not negative, then
@@ -4571,6 +4647,54 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
 	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, val, NULL, 0, NULL, 0);
 }
 
+/*
+ * Argument bytes that follow an ISC opcode.  Returns NULL with @nargs set
+ * when the arguments are all zero: adva_x1_i2c_xfer() zeroes the buffer.
+ *
+ * EN_CFG_TP, DIS_CFG and REFRESH take two operand bytes here where the SPI
+ * drivers in drivers/fpga send three.  These are the frames the part on this
+ * board answers: the sequence below has programmed and refreshed it
+ * successfully over I2C, so the counts are kept as validated rather than
+ * aligned with the SPI framing.
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
  * Send a 4-byte command and read back without an intermediate STOP: two
  * messages in one transfer is the Lattice write -> repeated START -> read,
@@ -4596,11 +4720,86 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
 	return 0;
 }
 
+/* Poll the status register until the CPLD goes idle, or @max_ms elapses.
+ * The deadline is on wall time, so the I2C transactions count against it,
+ * and the status is read once more after it expires before giving up.
+ */
+static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
+{
+	u32 status = 0;
+	int err = 0, ret;
+
+	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
+				err || (status & CPLD_STATUS_FAILED) ||
+				!(status & CPLD_STATUS_BUSY),
+				CPLD_POLL_US, max_ms * USEC_PER_MSEC, false,
+				bp, &status);
+	if (ret)
+		return ret;
+	/* Keep the transport errno so it reaches userspace as-is; -EIO is
+	 * reserved for the CPLD itself reporting FAILED.
+	 */
+	if (err)
+		return err;
+	if (status & CPLD_STATUS_FAILED)
+		return -EIO;
+
+	return 0;
+}
+
+/* Wait for BUSY to clear.  Unlike adva_x1_cpld_wait_ready() a latched FAILED
+ * status is not an error here: this is used on the exit path, where an ISC
+ * command issued while the part is still erasing or programming may not
+ * latch, so the operation has to be waited out whatever its outcome.
+ */
+static int adva_x1_cpld_wait_idle(struct ptp_ocp *bp, unsigned int max_ms)
+{
+	u32 status = 0;
+	int err = 0, ret;
+
+	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
+				err || !(status & CPLD_STATUS_BUSY),
+				CPLD_POLL_US, max_ms * USEC_PER_MSEC, false,
+				bp, &status);
+	if (ret)
+		return ret;
+
+	return err;
+}
+
+/* Leave transparent configuration mode.
+ *
+ * A DIS_CFG issued while the part is still busy may not latch, so the wait
+ * has to succeed before the write is believed - an ACKed write after a
+ * timed-out wait says nothing about whether the part left the mode.  Retry
+ * a few times rather than leaving it latched on one bad attempt; there is
+ * no other caller that would try again.
+ */
+static void adva_x1_cpld_exit_config(struct ptp_ocp *bp)
+{
+	int err, i;
+
+	if (!bp->cpld_in_config_mode)
+		return;
+
+	for (i = 0; i < CPLD_EXIT_CFG_TRIES; i++) {
+		err = adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS);
+		if (!err)
+			err = adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
+		if (!err) {
+			bp->cpld_in_config_mode = false;
+			return;
+		}
+	}
+
+	dev_err(&bp->pdev->dev, "CPLD left in configuration mode: %d\n", err);
+}
+
 /*
- * Read the Lattice device ID into bp->cpld_id.  Done once, off the
- * unprivileged devlink path, which reports the cached value.  -EBUSY means
- * cpld_lock is held, so the caller can retry rather than wait behind a long
- * CPLD operation.
+ * Read the Lattice device ID and the image USERCODE under one bus claim.
+ * Done once, off the unprivileged devlink path, which reports the cached
+ * values.  -EBUSY means cpld_lock is held, so the caller can retry rather
+ * than wait behind a long CPLD operation.
  */
 static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
 {
@@ -4621,8 +4820,21 @@ static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
 	if (ret)
 		goto deselect;
 	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
-	if (!ret)
-		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
+	if (ret)
+		goto deselect;
+	/* Publish the ID before the USERCODE is attempted: a part that does
+	 * not answer 0xC0 must not cost us the device ID as well.
+	 */
+	WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
+
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_USERCODE, data, 4);
+	if (ret)
+		goto deselect;
+	WRITE_ONCE(bp->cpld_usercode, get_unaligned_be32(data));
+	/* Pairs with the acquire in ptp_ocp_devlink_info_get(): the value has
+	 * to be visible before the flag that declares it valid.
+	 */
+	smp_store_release(&bp->cpld_usercode_ok, true);
 deselect:
 	err = adva_x1_mux_select(bp, -1);
 	if (!ret)
@@ -4694,6 +4906,207 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_ADMIN_RO(cpld_status);
 
+/*
+ * Program the CPLD configuration flash from @fw and activate it.  Selected
+ * by the "fw.cpld" flash component; the SPI flash keeps the default path.
+ * Runs under cpld_lock with the i2c adapter lock held, so an EEPROM read
+ * blocks for as long as programming takes.
+ */
+static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
+			      const struct firmware *fw,
+			      struct netlink_ext_ack *extack)
+{
+	size_t offset;
+	int err, ret;
+	u32 st;
+
+	if (!fw->size || fw->size % CPLD_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "image must be a whole number of 16-byte pages");
+		return -EINVAL;
+	}
+	if (fw->size > CPLD_MAX_IMAGE_SZ) {
+		NL_SET_ERR_MSG_MOD(extack, "image too large for this part");
+		return -EINVAL;
+	}
+
+	mutex_lock(&bp->cpld_lock);
+
+	err = adva_x1_bus_claim(bp);
+	if (err)
+		goto unlock;
+	/* A select reported as failed may still have been ACKed, so hand the
+	 * mux back deselected either way.
+	 */
+	err = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (err)
+		goto deselect;
+
+	/* A previous flash may have failed to leave configuration mode.  Now
+	 * that the bus is claimed again, retry the exit before re-entering;
+	 * a no-op when the flag is already clear.
+	 */
+	adva_x1_cpld_exit_config(bp);
+
+	/* Set before EN_CFG_TP, not after: the CPLD may have entered config
+	 * mode even if the write errors or the wait times out, and only this
+	 * makes the exit path send DIS_CFG.  A stray DIS_CFG is harmless;
+	 * leaving config mode enabled is not.
+	 */
+	bp->cpld_in_config_mode = true;
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, 5000);
+	if (err)
+		goto exit_config;
+
+	/* Confirm the part really entered configuration mode.  An enable
+	 * frame that did not latch leaves an idle part reporting neither
+	 * BUSY nor FAILED, the erase and page writes are ignored, and DONE
+	 * is still set from the old image - so every later check passes and
+	 * the update would be reported successful with the flash untouched.
+	 */
+	err = adva_x1_cpld_read_status(bp, &st);
+	if (err)
+		goto exit_config;
+	if (!(st & CPLD_STATUS_ENAB)) {
+		dev_err(&bp->pdev->dev,
+			"CPLD did not enter configuration mode, status 0x%08x\n",
+			st);
+		NL_SET_ERR_MSG_MOD(extack,
+				   "CPLD did not enter configuration mode");
+		err = -EIO;
+		goto exit_config;
+	}
+
+	devlink_flash_update_status_notify(devlink, "Erasing",
+					   ADVA_CPLD_COMPONENT, 0, 0);
+	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, CPLD_ERASE_MS);
+	if (err)
+		goto exit_config;
+
+	/* The old image is gone from here on, so stop reporting its
+	 * identity even if the rest of the sequence fails.  Written under
+	 * cpld_lock, which adva_x1_cpld_read_id() also holds across its own
+	 * bookkeeping, so the worker cannot resurrect any of it.
+	 */
+	WRITE_ONCE(bp->cpld_id, 0);
+	WRITE_ONCE(bp->cpld_usercode_ok, false);
+	bp->cpld_id_tried = false;
+	bp->cpld_id_attempts = 0;
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR);
+	if (err)
+		goto exit_config;
+
+	for (offset = 0; offset < fw->size; offset += CPLD_PAGE_SIZE) {
+		u8 args[3 + CPLD_PAGE_SIZE] = { 0x00, 0x00, 0x01 };
+
+		/* The loop holds cpld_lock and the i2c root lock for the
+		 * whole image, so give a dying task a way out.  The part is
+		 * left unconfigured, which is recoverable: fw.cpld stays
+		 * advertised so the image can be written again.
+		 */
+		if (fatal_signal_pending(current)) {
+			err = -EINTR;
+			goto exit_config;
+		}
+
+		memcpy(&args[3], fw->data + offset, CPLD_PAGE_SIZE);
+		err = adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, CPLD_CMD_WRITE_PAGE,
+				       args, sizeof(args), NULL, 0);
+		if (!err)
+			err = adva_x1_cpld_wait_ready(bp, 100);
+		if (err)
+			goto exit_config;
+
+		if (!(offset % (CPLD_PAGE_SIZE * 64)))
+			devlink_flash_update_status_notify(devlink,
+							   "Programming",
+							   ADVA_CPLD_COMPONENT,
+							   offset, fw->size);
+	}
+	devlink_flash_update_status_notify(devlink, "Programming",
+					   ADVA_CPLD_COMPONENT,
+					   fw->size, fw->size);
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, 1000);
+	if (err)
+		goto exit_config;
+
+	err = adva_x1_cpld_read_status(bp, &st);
+	if (err)
+		goto exit_config;
+	if (!(st & CPLD_STATUS_DONE)) {
+		dev_err(&bp->pdev->dev,
+			"CPLD SET_DONE left status 0x%08x\n", st);
+		NL_SET_ERR_MSG_MOD(extack, "CPLD did not accept the image");
+		err = -EIO;
+		goto exit_config;
+	}
+
+	devlink_flash_update_status_notify(devlink, "Activating",
+					   ADVA_CPLD_COMPONENT, 0, 0);
+	err = adva_x1_cpld_write(bp, CPLD_CMD_REFRESH);
+	if (err)
+		goto exit_config;
+
+	/* REFRESH reboots the CPLD out of configuration mode, so the exit
+	 * path must not send DIS_CFG afterwards even if a check below fails.
+	 */
+	bp->cpld_in_config_mode = false;
+
+	/* The new image is already running, so a segment that is not back
+	 * yet must not be reported as a failed update: retry the reselect
+	 * rather than sampling the mux once at a fixed delay.
+	 */
+	msleep(1500);
+	err = read_poll_timeout(adva_x1_mux_select, err, !err, CPLD_POLL_US,
+				3000 * USEC_PER_MSEC, false,
+				bp, ADVA_MUX_CHANNEL);
+	if (err)
+		goto deselect;
+
+	err = adva_x1_cpld_wait_ready(bp, 3000);
+	if (err)
+		goto deselect;
+
+	/* Require DONE set, not busy and no error code, as machxo2-spi.c does
+	 * after a refresh: without it a CRC or preamble error reads back as a
+	 * successful update.
+	 */
+	err = adva_x1_cpld_read_status(bp, &st);
+	if (err)
+		goto deselect;
+	if (!(st & CPLD_STATUS_DONE) || (st & CPLD_STATUS_BUSY) ||
+	    (st & CPLD_STATUS_ERR)) {
+		dev_err(&bp->pdev->dev,
+			"CPLD refresh left status 0x%08x\n", st);
+		NL_SET_ERR_MSG_MOD(extack, "CPLD did not come back configured");
+		err = -EIO;
+		goto deselect;
+	}
+
+exit_config:
+	adva_x1_cpld_exit_config(bp);
+deselect:
+	ret = adva_x1_mux_select(bp, -1);
+	if (!err)
+		err = ret;
+	ret = adva_x1_bus_release(bp);
+	if (!err)
+		err = ret;
+unlock:
+	mutex_unlock(&bp->cpld_lock);
+
+	return err;
+}
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
-- 
2.47.0

