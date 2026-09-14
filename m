Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539B3B7760
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370176; cv=none; b=Qi0maDkVI3FZfJ+ua46uUKuuA1n1eJgZjUM0aHit6sN0jubThpr4zgmnDzSdkqjUrrd7OlFend1FJ7MPXaKpez3rZEy4grvR/sbIZZUaoulIeSbhJ6yNdllTMm7eXi1ux/yGKU/m34b/NX8i9g/TCBM5/s+Sj1TWSdud7M6Gnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370176; c=relaxed/simple;
	bh=Z3gRReMI2MXyvkvdZqOZSuEsRFPZ8FFXXeV2fQqgflA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnuloq+w/nsn3GCL3nkyzjWDHQsAiVGIbY8ARHwSBljbJ/2HxmM6z2x5gBo5FWekeJD3LFUdDBuf338I0qtgiW4i2ggTnHNBxaNExoAs06BAsZmU/3J536Vw2KLpIXCtPYY1hD005BtzuyFyu7YRPokDjf22xmMn2F8wPBterG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyc87FPl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyc87FPl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso893350f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370172; x=1789974972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYUlTUTs+mnKKTV+ZLnSvoMgwNBVxWwasV2EoQomx3k=;
        b=kyc87FPlTdJ1dx29+7UoMI6q6f96fene8oGQMMrcLh1K2owyliTMm+Y+LclkeXhKqa
         FDBzcwPHii5S+qnfJKv6REdzKDVqW+vLM2ai4xORTuaqDTk6mhkw0EsV9/PR/dV+vG9L
         V6B/f829miqiPkS2l/r4MsjjgCp2hDkWE1wh7lsWXuzmuk+vb+yvCtnaQfQtlusP3IFj
         uzuWT+bfp9bN1Ox9wEZx5I3Ncxv2Ee7aSCdfi1C0xeDgrKreaTxjLmZWbK08OTgzBkHh
         CUq6lUbSK5jrkq3OiPHWPW4DEOMWmlK26cjEH7/UF1i2fcf20tuKARH5URT4ZIDpjw6K
         JZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370172; x=1789974972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYUlTUTs+mnKKTV+ZLnSvoMgwNBVxWwasV2EoQomx3k=;
        b=dcQwitju147o2EeUAScIoVcb3aJ/RFOsGhc9LgNK1CLd74MgJjJ0ooFx2c3fXsUsUv
         YYIazwjrLYS+qTQL4Urqos9P0Ob5f5iDRka3duQHug1RmvFHEzcNXzQZ5W8deSW6OIrc
         3IfGW9X4jltschFynD79FzdULKuwkfxbDueLKTL8S5sfCj9/ym6CB3po05injGKpoKuW
         FwP8xJ9Ug0zo+2Kjt8y1aYbbeCZddDXxz4LoZ8cW7vXXw/HGuf21IXAXvMX1p8W4buib
         t1hDbG9yolkQCXdS0VW/9zVzhEyuHyZY5/QhboHzAB5pVltzP3eOBW1LK/Ilg2AoQOQ9
         NlUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfCrZzPrJQdxK15PVBlJZh+tL/CYAD9bWkPmFgJypWG3o6GgF9Ai2LMSlc3u8V58ME8J/Arw4=@vger.kernel.org
X-Gm-Message-State: AFuF++kN3p2wYsCVh48x0hMnuoPw6nksYeB+Vs4jafeqKfG/q4lAVhFk
	RyTWWX3ac/1AwPm+zZQ71Yd7OTr0EfXKqZhPAG14WTMSCUZowxEcT/y8
X-Gm-Gg: AYBFou1unZUltEEQ1OskA8X5IEicaqU5n1nO34ayzkCby4hzu1HMdUndn9EwqZDYIVY
	fJ4syvd169iX1zy/FvfQkjVyFOmxX9PfpR6Hx2vfC+CflavmUlmwIeBX1E6sk6fII4/Ep+wKgVz
	R96NaQmeOwaf+ry8TOdXbPMBBUc9mAYmW8KSPTmabMiXGNcj0JbNgOzxVNfJxXQVz63W3gFvMpH
	ViWg9KENLM9hnOKV13pAlbrNHd9cheI/EuymtYQhgdbVcLhtZAqaHhB8r6DN/kzmjpP1IkvRtoh
	MzFA/ObEA6k22ejvDt0ZxZl411FDE6NG8XUA4Uje6sHZ9KEF33EurFmR0koa6l7p32oeaxUajVZ
	7l/Zz/mhVybUeQWxaOSOO2h8cK9w8ZRICxDdBZoPUWVkXOE2eIF7rqCSWE06evR7xhe2aVqorCA
	TLQufUhwVvAk65FTnRjeslTHoaWDeaKcRYL3nWE4+QWA8G2wIsQxSiOx4ChB8Kkagf2Ukmn0J9t
	N+RoSKL9lDSYOk3eMCQ9OCdT4CtxQhF6nnu8fxX
X-Received: by 2002:a05:6000:29d2:b0:487:37d:ae8d with SMTP id ffacd0b85a97d-487037db15amr623668f8f.21.1789370172183;
        Mon, 14 Sep 2026 00:16:12 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb357288sm25161082f8f.29.2026.09.14.00.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:16:11 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
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
Subject: [PATCH net-next v14 4/4] ptp: ocp: add TAP CPLD flashing via devlink
Date: Mon, 14 Sep 2026 10:15:55 +0300
Message-ID: <20260914071555.11684-5-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260914071555.11684-1-maimon.sagi@gmail.com>
References: <20260914071555.11684-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 Documentation/ABI/testing/sysfs-timecard     |   4 +
 Documentation/networking/devlink/ptp_ocp.rst |  37 ++-
 drivers/ptp/ptp_ocp.c                        | 327 ++++++++++++++++++-
 3 files changed, 361 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index c440d8930384..6ddca452bc63 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -35,6 +35,10 @@ Description:	(RO, root only) The flags set in the status register of the
 		probe, and reported from that cached value as the fixed
 		"cpld.id" version by devlink dev info.
 
+		New CPLD firmware is programmed with devlink dev flash,
+		selecting the "fw.cpld" component; see
+		Documentation/networking/devlink/ptp_ocp.rst.
+
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
index 3f997cd9f3a3..37e9f1ebd1a8 100644
--- a/Documentation/networking/devlink/ptp_ocp.rst
+++ b/Documentation/networking/devlink/ptp_ocp.rst
@@ -5,7 +5,7 @@ ptp_ocp devlink support
 ========================
 
 This document describes the devlink features implemented by the ``ptp_ocp``
-device driver.
+device driver: the info versions it reports and its flash update support.
 
 Info versions
 =============
@@ -33,3 +33,38 @@ The ``ptp_ocp`` driver reports the following versions
        reprograms the on-card mux, so the driver does that once from its
        own worker and reports the cached value here; the version is
        omitted until that read has succeeded.
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
+       The image is the raw configuration bitstream, a whole number of
+       16-byte pages; container formats such as ``.jed`` are rejected.
+
+Programming the CPLD claims the shared I2C bus for the whole cycle, so
+reads of the card's EEPROM block until it completes.  Progress is reported
+with the standard devlink status notifications.
+
+Example::
+
+    $ devlink dev flash pci/0000:02:00.0 file adva-cpld.bin component fw.cpld
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 98cb26077181..58b90b2b282f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -434,12 +434,16 @@ struct ptp_ocp {
 	u8			*cpld_buf;
 	/* Lattice device ID; 0 if unread */
 	u32			cpld_id;
+	/* USERCODE of the programmed image; valid once cpld_id is set */
+	u32			cpld_usercode;
 	/* the one-shot ID read is finished, successfully or not */
 	bool			cpld_id_tried;
 	/* failed ID read attempts so far */
 	unsigned int		cpld_id_attempts;
 	/* x1 TAP CPLD present */
 	bool			has_cpld;
+	/* EN_CFG_TP issued but not yet REFRESH'd */
+	bool			cpld_in_config_mode;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -476,6 +480,13 @@ static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
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
@@ -2158,6 +2169,17 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
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
+		return adva_x1_cpld_flash(bp, devlink, params->fw, extack);
+	}
+
 	dev = ptp_ocp_find_flash(bp);
 	if (!dev) {
 		dev_err(&bp->pdev->dev, "Can't find Flash SPI adapter\n");
@@ -2180,6 +2202,8 @@ static int
 ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 			 struct netlink_ext_ack *extack)
 {
+	enum devlink_info_version_type ver_type =
+					DEVLINK_INFO_VERSION_TYPE_COMPONENT;
 	struct ptp_ocp *bp = devlink_priv(devlink);
 	const char *fw_image;
 	char buf[32];
@@ -2202,6 +2226,16 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
 		if (err)
 			return err;
+
+		/* The flashable component: naming it here is what lets
+		 * "devlink dev flash ... component fw.cpld" through, as the
+		 * core matches the name against the versions reported here.
+		 */
+		sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
+		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
+							   ver_type);
+		if (err)
+			return err;
 	}
 
 	if (!bp->has_eeprom_data) {
@@ -4296,13 +4330,25 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 
 /* Lattice LCMXO3LF ISC command codes */
 #define CPLD_CMD_READ_ID      0xE0000000UL
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
+#define CPLD_ERASE_MS         15000  /* config sector erase, datasheet max */
 #define CPLD_ID_MAX_ATTEMPTS  10     /* one per sync_work tick */
 
 /* Status register bit positions (Lattice LCMXO3LF datasheet) */
 #define CPLD_STATUS_DONE   BIT(8)
 #define CPLD_STATUS_BUSY   BIT(12)
 #define CPLD_STATUS_FAILED BIT(13)
+#define CPLD_STATUS_ERR    GENMASK(25, 23)
 
 /*
  * Issue one I2C transaction on the TMC bus: @cmd if not negative, then
@@ -4522,6 +4568,48 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
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
  * Send a 4-byte command and read back without an intermediate STOP: two
  * messages in one transfer is the Lattice write -> repeated START -> read,
@@ -4547,14 +4635,82 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
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
+/* Wait for BUSY to clear, ignoring a pending cancel.  An ISC command issued
+ * while the part is still erasing or programming may not latch, so an abort
+ * has to wait the operation out before it can leave configuration mode.
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
+/* Leave transparent configuration mode.  cpld_in_config_mode stays set when
+ * DIS_CFG does not get through, so a later cleanup() tries again rather than
+ * recording an exit that never happened.
+ */
+static void adva_x1_cpld_exit_config(struct ptp_ocp *bp)
+{
+	int err;
+
+	if (!bp->cpld_in_config_mode)
+		return;
+
+	adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS);
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
+	if (err)
+		dev_warn(&bp->pdev->dev,
+			 "CPLD left in configuration mode: %d\n", err);
+	else
+		bp->cpld_in_config_mode = false;
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
+	u32 id, usercode;
 	u8 data[4];
 	int ret;
 
@@ -4568,8 +4724,19 @@ static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
 	if (ret)
 		goto release;
 	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
-	if (!ret)
-		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
+	if (ret)
+		goto deselect;
+	id = get_unaligned_be32(data);
+
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_USERCODE, data, 4);
+	if (ret)
+		goto deselect;
+	usercode = get_unaligned_be32(data);
+
+	/* cpld_id is the validity flag for both, so publish it last. */
+	WRITE_ONCE(bp->cpld_usercode, usercode);
+	WRITE_ONCE(bp->cpld_id, id);
+deselect:
 	adva_x1_mux_select(bp, -1);
 release:
 	adva_x1_bus_release(bp);
@@ -4627,6 +4794,154 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
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
+	int err;
+	u32 st;
+
+	if (!fw->size || fw->size % CPLD_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "image must be a whole number of 16-byte pages");
+		return -EINVAL;
+	}
+
+	mutex_lock(&bp->cpld_lock);
+
+	err = adva_x1_bus_claim(bp);
+	if (err)
+		goto unlock;
+	err = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (err)
+		goto release;
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
+	devlink_flash_update_status_notify(devlink, "Erasing",
+					   ADVA_CPLD_COMPONENT, 0, 0);
+	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
+	if (!err)
+		err = adva_x1_cpld_wait_ready(bp, CPLD_ERASE_MS);
+	if (err)
+		goto exit_config;
+
+	err = adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR);
+	if (err)
+		goto exit_config;
+
+	for (offset = 0; offset < fw->size; offset += CPLD_PAGE_SIZE) {
+		u8 args[3 + CPLD_PAGE_SIZE] = { 0x00, 0x00, 0x01 };
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
+	/* The image on the part changed, so the cached USERCODE has too. */
+	WRITE_ONCE(bp->cpld_id, 0);
+	WRITE_ONCE(bp->cpld_id_tried, false);
+	bp->cpld_id_attempts = 0;
+
+exit_config:
+	adva_x1_cpld_exit_config(bp);
+deselect:
+	adva_x1_mux_select(bp, -1);
+release:
+	adva_x1_bus_release(bp);
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

