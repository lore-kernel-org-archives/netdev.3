Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71552FE51
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870237; cv=none; b=Kr4OAcDRrNG9tCWGbA4zIJM+2Ary9Ra+FTIAsn/76cC0gBtSM1fW7/rWnfo9KGXmyyxINbBB/Gc1jiVVXZfhIZr2St4av/9sBm0SVpJoCck7kQ7kRtYLV5A87O9Yio3W6E2TSSCYy/8Ee0lsv4B6M+Nu6iKK0RYHbvjDUVG68dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870237; c=relaxed/simple;
	bh=RKmsTQPVumxB4zCD2zZPTy+kMRNAhF5B+/EngMI11zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYm0b3lhCx4wVxZDmgcxyC6Bl+qxGQCUYtBNxAZP/srUbxfKQt7nu4wEySvnfOW+EpEX+ZGHfp0W/BURFCbwXmX7Vddh7kdTOhmaeINWzYQMWB0RE7BvcwlbWdrVrCys+PuSJzFFSRtJijdylGYELnFasijKAsnmLPT2fK3Aj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYa7Sq9D; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYa7Sq9D"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590dde14so65087445e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870232; x=1789475032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zINAt/xeYyfrPw/9U7bnw4E6K+8YicvFFTxwS9h6aPY=;
        b=YYa7Sq9DhBe5HEbFu3SUXB4kBFeqVEmzQbsusxf9YuiDPMXRhE/n5iAtaC+Xc2kkTd
         bU+dVyc3qNw19u1wFQi7zlvVSzvlsUKcYUNDCeC3Ix2kd88AgmXQI9S21a/D+TUqmd6x
         FAqjAJfsHW6Tb1rswsOzw10M96tN1qxHEXua8uZpO9TQBzhUF1MyDGRw1YN1I7JwF+/5
         Ri+gNZAdz5Bg4sQWmbB4XVqGw7VR1Z03QXmreOrw/iiUeTzmBE3hf5ijOzMT/hTtIRGC
         H5qnnPEJ0BeiP8CaXjj7Jbt7xbiPkBdc6LrXvbB7nZjLtX6SBNdnBKkrCNAt+1txrMU/
         BexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870232; x=1789475032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zINAt/xeYyfrPw/9U7bnw4E6K+8YicvFFTxwS9h6aPY=;
        b=JqMEHSEBHxPfoSi4/0aSapnAkplCmoqFhloXWjXjYl/UMJaDHhgFlf0R5MALumy/23
         /PKd/PlK8U+yyRFEXln1l3wd1jLtjFQgwDs/g9mAp+6nYGngNej8MSqNlLvAe/nlOyzJ
         wjBUs3j5sXOGL7eDHAxGjsQH9Elpx80JzBUgXv22WqmPLt/SKEfjhV8Xd3oh37RQd4BQ
         jtIDQ6VozPgk7TSZvRs/M6eB5SliLqH/I5kAIX7PfQDBZfk+QFIp8AY9yahOdslBmceL
         J4/qoATPbU+qo9DKoZpMRFr/gbKNkVza/f1I0G18CTbJZIHiWbtIjTSvdOOjWXdFwvkU
         3j9Q==
X-Gm-Message-State: AFuF++ktYzdc/Roe5Kc1gihUoU1uKCi7GDZjJ0bzzZ3uGNpc0lGVkiR1
	STlqSLcPSvFA+z0+Vdci31CBq4NGRvMqmiwld05fx7v3R7dU5JUBGxCLmnb53aEN
X-Gm-Gg: AYBFou3ubteszyzbJZOq8Aym3t2BsMZm9dq++wx5ZZ7GssbAAmuQ4KAMKqych3Roa8D
	IBtwgU8yXWcn35cWhD7n6TbxrjzlkQb7oMyPcHi/PQGVpGo60NVgU1WXqmINaneJfkmr2Jlufeo
	gCVVAtQ4YDo1/KgQMCFG9/xIahKhnp/+6/cr4F7/PQNQNy1hBTQplWUNGyQ4idtNFS2x/oJylR3
	4qF5AY9uHqBliM/cEcoHveulTWo+vZR3rAppAhfn05SwLp4JymV9h95zEmjywJnSv2Vt5NoZCAF
	3LrcEk3ktNAKfThACiHhPF7oHdNbZeQlOMI37HWXfXOpwvD7UJ3nvyS4qMVxLljFrAbxl2NQ4ZY
	3H+Ptzzvmqkho6/D6KJnopZlvVjSJVLPsd7fNK8ko5AiFpPmt7aSXTNLjz4yx1/bgCRsAAo48k2
	pyFgvVbjBsbVaTXxnRdJB3LmWJKmGRe9KkjK+UrS+r/8TR8mc1oB7OutEBmtR0rwGRgjohTejgE
	zYVdbpyb4gd2yEvLgNbXjAYToJYguuSHDERl93dPy2LFZNokzQsfjMHLCs1RFJj/llZnXWCzF7j
	KpA=
X-Received: by 2002:a05:600d:8487:20b0:49c:cee0:e7c0 with SMTP id 5b1f17b1804b1-49cf8261bf0mr426399585e9.16.1788870232293;
        Tue, 08 Sep 2026 05:23:52 -0700 (PDT)
Received: from fedora-tap.advaoptical.com (bzq-84-110-212-205.static-ip.bezeqint.net. [84.110.212.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm496744995e9.6.2026.09.08.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:23:51 -0700 (PDT)
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
Subject: [PATCH net-next v13 1/2] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Tue,  8 Sep 2026 15:23:27 +0300
Message-ID: <20260908122328.52641-2-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260908122328.52641-1-maimon.sagi@gmail.com>
References: <20260908122328.52641-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X1 (PCI device 0x0410) carries a Lattice MachXO3 CPLD
on the TMC I2C bus.  The card has two I2C controllers: Linux registers
only the one at 0x00150000, normally routed to the config EEPROMs, while
the one at 0x00120000 belongs to the on-card MicroBlaze and is routed to
either the TMC or the M.2 bus as its firmware selects.

A request/grant handshake re-routes the host controller from the EEPROM
segment onto the TMC bus, leaving the MicroBlaze with M.2 only.  The
PCA9548 at 0x74 and the CPLD at 0x40 behind its channel 0 are reachable
from the host only while that grant is held.

Add the arbitration and the read-only interfaces built on it.  Because
the handshake changes what the host adapter is wired to, an operation
takes the i2c core adapter lock for the whole grant window and uses
__i2c_transfer() internally; without that, a concurrent transfer from
ptp_ocp_read_eeprom(), from the nvmem attributes or from the at24 sysfs
files would be issued onto the TMC bus instead of to the EEPROM.

The Lattice device ID is a fixed property of the part, so report it as
the fixed devlink version "cpld.id" rather than as a sysfs attribute,
and cache it so the arbitration is paid once per card.

Add one X1-only attribute:

  /sys/class/timecard/ocpN/cpld_status
        report the CPLD status register, including the DONE, BUSY and
        FAILED indicators

A read arbitrates for the shared bus and reprograms the on-card mux, so
it is root-only and takes cpld_lock interruptibly.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Documentation/ABI/testing/sysfs-timecard     |  20 +
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/ptp_ocp.rst |  35 ++
 MAINTAINERS                                  |   1 +
 drivers/ptp/ptp_ocp.c                        | 388 ++++++++++++++++++-
 5 files changed, 439 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/networking/devlink/ptp_ocp.rst

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..70ecc15b347f 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -11,6 +11,26 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
 Description:	This directory contains the attributes of the Nth timecard
 		registered.
 
+What:		/sys/class/timecard/ocpN/cpld_status
+Date:		July 2026
+Contact:	Sagi Maimon <maimon.sagi@gmail.com>
+Description:	(RO, root only) The status register of the TAP CPLD, in
+		human-readable form:
+
+		  done=<0|1> busy=<0|1> failed=<0|1>
+
+		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
+
+		done=1 indicates the configuration flash was successfully
+		programmed and is active.  busy=1 means an internal operation
+		is in progress.  failed=1 means the last ISC operation failed.
+
+		A read arbitrates for the shared I2C bus and reprograms the
+		on-card mux, so it is restricted to root.  The Lattice device
+		ID of the CPLD is read once at probe and reported as the
+		fixed "cpld.id" version by devlink dev info.
+
+
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index d4a83fdcff7f..1af780c811ee 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -99,6 +99,7 @@ parameters, info versions, and other features it supports.
    nfp
    octeontx2
    prestera
+   ptp_ocp
    qed
    sfc
    stmmac
diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
new file mode 100644
index 000000000000..3f997cd9f3a3
--- /dev/null
+++ b/Documentation/networking/devlink/ptp_ocp.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+ptp_ocp devlink support
+========================
+
+This document describes the devlink features implemented by the ``ptp_ocp``
+device driver.
+
+Info versions
+=============
+
+The ``ptp_ocp`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+   :widths: 5 5 90
+
+   * - Name
+     - Type
+     - Description
+   * - ``fw``
+     - running
+     - Version of the firmware running on the card.  Reported as ``loader``
+       instead when the card is running the firmware loader.
+   * - ``board.id``
+     - fixed
+     - Board identifier, read from the on-card EEPROM.
+   * - ``cpld.id``
+     - fixed
+     - Lattice device ID (IDCODE) of the TAP CPLD, formatted as ``0x%08x``.
+       Only present on ADVA TimeCard X1 boards, which are the only ones
+       carrying that CPLD.  Reading it claims the shared I2C bus and
+       reprograms the on-card mux, so the driver does that once from its
+       own worker and reports the cached value here; the version is
+       omitted until that read has succeeded.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0b42e898f4d8..6216244edb04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20485,6 +20485,7 @@ OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/networking/devlink/ptp_ocp.rst
 F:	drivers/ptp/ptp_ocp.c
 
 OPENCORES I2C BUS DRIVER
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 3d26ec1f7b9e..7db1dc9b94bd 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -24,6 +24,8 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
 #include <linux/dpll.h>
+#include <linux/unaligned.h>
+#include <linux/delay.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
@@ -85,6 +87,8 @@ struct ptp_ocp_adva_info {
 	u8				signals_nr;
 	u8				freq_in_nr;
 	const struct ocp_attr_group	*attr_groups;
+	/* x1: TAP CPLD present */
+	bool				has_cpld;
 };
 
 #define OCP_CTRL_ENABLE		BIT(0)
@@ -163,7 +167,8 @@ struct gpio_reg {
 	u32	gpio1;
 	u32	__pad0;
 	u32	gpio2;
-	u32	__pad1;
+	/* adva_x1: I2C bus ownership register; reserved on other variants */
+	u32	i2c_bus_ctrl;
 };
 
 struct irig_master_reg {
@@ -416,6 +421,21 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* adva_x1 CPLD I2C (internal use only) */
+	/* serialises CPLD operations */
+	struct mutex		cpld_lock;
+	/* I2C adapter nr; -1 if absent */
+	int			cpld_i2c_adap_nr;
+	/* claimed adapter; valid under cpld_lock */
+	struct i2c_adapter	*cpld_adap;
+	/* scratch, write half then read half; valid under cpld_lock */
+	u8			*cpld_buf;
+	/* Lattice device ID; 0 if unread */
+	u32			cpld_id;
+	/* the one-shot ID read has been attempted */
+	bool			cpld_id_tried;
+	/* x1 TAP CPLD present */
+	bool			has_cpld;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -1273,6 +1293,7 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 			.signals_nr   = 4,
 			.freq_in_nr   = 4,
 			.attr_groups  = adva_timecard_x1_groups,
+			.has_cpld     = true,
 		},
 	},
 	{ }
@@ -2166,6 +2187,17 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
+	/* Read by the worker, not here: this command is unprivileged and
+	 * reading the ID claims the I2C bus.  0 means unread - skip it
+	 * rather than fail, devlink discards the whole reply on error.
+	 */
+	if (bp->cpld_id) {
+		sprintf(buf, "0x%08x", bp->cpld_id);
+		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
+		if (err)
+			return err;
+	}
+
 	if (!bp->has_eeprom_data) {
 		ptp_ocp_read_eeprom(bp);
 		if (!bp->has_eeprom_data)
@@ -3199,6 +3231,7 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
+	bp->has_cpld = info->has_cpld;
 	return ptp_ocp_init_clock(bp, &info->servo);
 }
 
@@ -4226,6 +4259,319 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+/*
+ * Internal helpers for the adva_x1 TAP CPLD (Lattice LCMXO3LF-2100).
+ *
+ * The card has two I2C controllers; Linux registers only 0x00150000.
+ * The i2c_bus_ctrl handshake re-routes what each one is wired to:
+ *
+ *   grant 0:  0x150000 -> EEPROMs     0x120000 -> TMC or M.2, MB's choice
+ *   grant 1:  0x150000 -> TMC bus     0x120000 -> M.2
+ *
+ * The PCA9548 at 0x74 and the CPLD at 0x40 behind its channel 0 sit on
+ * the TMC bus, so they are reachable only while the grant is held.  For
+ * that same window the EEPROMs are not behind the adapter at all, so a
+ * CPLD operation holds cpld_lock and the i2c adapter lock across it to
+ * keep the EEPROM and nvmem paths off the controller.
+ *
+ * No raw I2C access is exposed to userspace, only the attributes below.
+ */
+
+#define ADVA_MUX_ADDR     0x74
+#define ADVA_CPLD_ADDR    0x40
+#define ADVA_MUX_CHANNEL  0
+
+/* Longest command or reply; bounds each half of the per-claim scratch. */
+#define ADVA_CPLD_XFER_MAX 32
+
+#define MBLAZE_REQUEST    0x0000aaaaU
+#define MBLAZE_GRANTED    0x5555aaaaU
+#define MBLAZE_RELEASE    0x55550000U
+#define MBLAZE_RETRIES    200
+#define MBLAZE_RETRY_US   10000
+
+/* Lattice LCMXO3LF ISC command codes */
+#define CPLD_CMD_READ_ID      0xE0000000UL
+#define CPLD_CMD_READ_STATUS  0x3C000000UL
+
+/* Status register bit positions (Lattice LCMXO3LF datasheet) */
+#define CPLD_STATUS_DONE   BIT(8)
+#define CPLD_STATUS_BUSY   BIT(12)
+#define CPLD_STATUS_FAILED BIT(13)
+
+/*
+ * adva_x1_i2c_xfer() - issue a single I2C transaction on the TMC bus.
+ *
+ * Writes @cmd when it is not negative, followed by @wlen bytes of @wdata,
+ * then reads @rlen bytes if asked.  A NULL @wdata sends zeros.
+ *
+ * The message is assembled in the scratch buffer taken by
+ * adva_x1_bus_claim(), so an opcode and its arguments are copied exactly
+ * once.  I2C_M_DMA_SAFE is deliberately not set: no adapter that can bind
+ * here does DMA, and the two halves are not separately aligned, so the
+ * core is left free to bounce.
+ *
+ * Caller must hold that claim, hence __i2c_transfer() over i2c_transfer().
+ */
+static int adva_x1_i2c_xfer(struct ptp_ocp *bp, u8 addr, int cmd,
+			    const void *wdata, u8 wlen,
+			    void *rdata, u8 rlen)
+{
+	u8 *wbuf, *rbuf;
+	struct i2c_adapter *adap;
+	struct i2c_msg msgs[2];
+	int nmsgs = 0, ret;
+	u16 hdr = cmd >= 0;
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	adap = bp->cpld_adap;
+	if (!adap || !bp->cpld_buf)
+		return -ENODEV;
+
+	if (hdr + wlen > ADVA_CPLD_XFER_MAX || rlen > ADVA_CPLD_XFER_MAX)
+		return -EINVAL;
+
+	wbuf = bp->cpld_buf;
+	rbuf = bp->cpld_buf + ADVA_CPLD_XFER_MAX;
+
+	if (hdr + wlen) {
+		if (hdr)
+			wbuf[0] = cmd;
+		if (wdata)
+			memcpy(wbuf + hdr, wdata, wlen);
+		else
+			memset(wbuf + hdr, 0, wlen);
+		msgs[nmsgs++] = (struct i2c_msg){
+			.addr  = addr,
+			.flags = 0,
+			.len   = hdr + wlen,
+			.buf   = wbuf,
+		};
+	}
+	if (rlen) {
+		msgs[nmsgs++] = (struct i2c_msg){
+			.addr  = addr,
+			.flags = I2C_M_RD,
+			.len   = rlen,
+			.buf   = rbuf,
+		};
+	}
+
+	ret = __i2c_transfer(adap, msgs, nmsgs);
+	if (ret != nmsgs)
+		return (ret < 0) ? ret : -EIO;
+
+	if (rdata && rlen)
+		memcpy(rdata, rbuf, rlen);
+
+	return 0;
+}
+
+static void adva_x1_mblaze_release(struct ptp_ocp *bp)
+{
+	if (bp->pps_select)
+		iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
+}
+
+/* Acquire the shared I2C bus from the MicroBlaze firmware.  Returns with no
+ * request outstanding on failure, so the firmware is never left granting a
+ * segment to a host that has given up waiting for it.
+ */
+static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
+{
+	u32 val;
+	int i;
+
+	if (!bp->pps_select)
+		return -ENODEV;
+
+	/* Drop a request left by a caller that died mid-sequence; cpld_lock
+	 * keeps live ones out.  The read back only flushes the posted write.
+	 */
+	iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
+	ioread32(&bp->pps_select->i2c_bus_ctrl);
+
+	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
+	for (i = 0; i < MBLAZE_RETRIES; i++) {
+		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
+		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
+		if (val == MBLAZE_GRANTED)
+			return 0;
+	}
+
+	adva_x1_mblaze_release(bp);
+	return -ETIMEDOUT;
+}
+
+/* Route the host controller back to the EEPROMs and release the adapter.
+ * Safe after a failed claim: it also clears a request that was never granted.
+ */
+static void adva_x1_bus_release(struct ptp_ocp *bp)
+{
+	struct i2c_adapter *adap = bp->cpld_adap;
+
+	if (!adap)
+		return;
+
+	adva_x1_mblaze_release(bp);
+	bp->cpld_adap = NULL;
+	kfree(bp->cpld_buf);
+	bp->cpld_buf = NULL;
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	i2c_put_adapter(adap);
+}
+
+/*
+ * Claim the TMC bus for a CPLD operation.  Holding the adapter lock over
+ * the handshake keeps ptp_ocp_read_eeprom(), the nvmem attributes and the
+ * at24 sysfs files off the controller while it is routed away from the
+ * EEPROMs, so an EEPROM read blocks for as long as the claim is held.
+ */
+static int adva_x1_bus_claim(struct ptp_ocp *bp)
+{
+	struct i2c_adapter *adap;
+	int ret;
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
+	if (!adap)
+		return -ENODEV;
+
+	/* The number is freed before the notifier clears it, so it can
+	 * already be another adapter's.  Check this is still ours.
+	 */
+	if (!bp->i2c_ctrl || adap->dev.parent != &bp->i2c_ctrl->dev) {
+		i2c_put_adapter(adap);
+		return -ENODEV;
+	}
+
+	/* One scratch buffer per claim, not per transfer. */
+	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);
+	if (!bp->cpld_buf) {
+		i2c_put_adapter(adap);
+		return -ENOMEM;
+	}
+
+	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	bp->cpld_adap = adap;
+
+	ret = adva_x1_mblaze_acquire(bp);
+	if (ret)
+		adva_x1_bus_release(bp);
+
+	return ret;
+}
+
+/* Select a mux channel, or deselect all with ch < 0 - the power-on state.
+ * The mux is on the TMC bus, so what it is left set to never affects the
+ * EEPROM paths.
+ */
+static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
+{
+	u8 val = (ch >= 0) ? BIT(ch) : 0;
+
+	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, val, NULL, 0, NULL, 0);
+}
+
+/*
+ * Send a 4-byte command then read data back without an intermediate STOP
+ * (Lattice combined write->repeated-START->read).  Two messages in one
+ * transfer is exactly that, so no protocol-mangling flag is needed.
+ */
+static int adva_x1_cpld_cmd_read(struct ptp_ocp *bp,
+				 u32 cmd_be, u8 *out, u8 out_len)
+{
+	__be32 cmd = cpu_to_be32(cmd_be);
+
+	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, -1, &cmd, 4, out, out_len);
+}
+
+static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
+{
+	u8 buf[4];
+	int ret;
+
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_STATUS, buf, 4);
+	if (ret)
+		return ret;
+	*status = get_unaligned_be32(buf);
+	return 0;
+}
+
+/*
+ * Read the Lattice device ID into bp->cpld_id.  Done once, off the
+ * unprivileged devlink path, which reports the cached value only.
+ * Returns -EBUSY if the bus is busy, so the caller can retry rather than
+ * wait out a firmware upload.  The LCMXO3LF-2100 IDCODE is 0xe12bc043.
+ */
+static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
+{
+	u8 data[4];
+	int ret;
+
+	if (!mutex_trylock(&bp->cpld_lock))
+		return -EBUSY;
+
+	ret = adva_x1_bus_claim(bp);
+	if (ret)
+		goto out;
+	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (ret)
+		goto release;
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
+	if (!ret)
+		bp->cpld_id = get_unaligned_be32(data);
+	adva_x1_mux_select(bp, -1);
+release:
+	adva_x1_bus_release(bp);
+out:
+	mutex_unlock(&bp->cpld_lock);
+	if (ret)
+		dev_dbg(&bp->pdev->dev,
+			"CPLD device ID unavailable: %d\n", ret);
+
+	return ret;
+}
+
+/*
+ * cpld_status - show the status register of the TAP CPLD.
+ *
+ * Returns a human-readable string: "done=<0|1> busy=<0|1> failed=<0|1>\n"
+ */
+static ssize_t
+cpld_status_show(struct device *dev, struct device_attribute *attr,
+		 char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+	u32 st = 0;
+	int ret;
+
+	/* A CPLD operation can hold cpld_lock a long time; stay killable. */
+	ret = mutex_lock_interruptible(&bp->cpld_lock);
+	if (ret)
+		return ret;
+
+	ret = adva_x1_bus_claim(bp);
+	if (ret)
+		goto out;
+	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (ret)
+		goto release;
+	ret = adva_x1_cpld_read_status(bp, &st);
+	adva_x1_mux_select(bp, -1);
+release:
+	adva_x1_bus_release(bp);
+out:
+	mutex_unlock(&bp->cpld_lock);
+	return ret ? ret : sysfs_emit(buf, "done=%u busy=%u failed=%u\n",
+				      !!(st & CPLD_STATUS_DONE),
+				      !!(st & CPLD_STATUS_BUSY),
+				      !!(st & CPLD_STATUS_FAILED));
+}
+static DEVICE_ATTR_ADMIN_RO(cpld_status);
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
@@ -4274,6 +4620,7 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_cpld_status.attr,
 	NULL,
 };
 
@@ -4904,6 +5251,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	mutex_destroy(&bp->cpld_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5052,6 +5400,14 @@ ptp_ocp_sync_work(struct work_struct *work)
 
 	bp->sync = sync;
 
+	/* The i2c adapter is registered after probe returns, so the ID is
+	 * read from here, once, as soon as the adapter shows up.
+	 */
+	if (bp->has_cpld && !bp->cpld_id_tried &&
+	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0 &&
+	    adva_x1_cpld_read_id(bp) != -EBUSY)
+		bp->cpld_id_tried = true;
+
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 }
 
@@ -5080,6 +5436,17 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto out_disable;
 
+	/* Must be before the first error path that calls ptp_ocp_detach(),
+	 * so mutex_destroy() always runs on an initialised mutex.
+	 * Must also be before ptp_ocp_register_resources(): the I2C bus
+	 * notifier (ptp_ocp_i2c_notifier_call) fires when the adapter
+	 * registers and stores the adapter number in cpld_i2c_adap_nr; the
+	 * -1 sentinel below must already be written so that a notifier
+	 * firing during registration is never overwritten by this init.
+	 */
+	mutex_init(&bp->cpld_lock);
+	bp->cpld_i2c_adap_nr = -1;
+
 	INIT_DELAYED_WORK(&bp->sync_work, ptp_ocp_sync_work);
 
 	/* compat mode.
@@ -5119,12 +5486,12 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(bp->dpll)) {
 		err = PTR_ERR(bp->dpll);
 		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
-		goto out;
+		goto out_devlink;
 	}
 
 	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
 	if (err)
-		goto out;
+		goto out_devlink;
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
@@ -5151,6 +5518,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
 	}
 	dpll_device_put(bp->dpll, &bp->tracker);
+out_devlink:
+	/* detach() destroys cpld_lock; no devlink op may still reach it */
+	devlink_unregister(devlink);
 out:
 	ptp_ocp_detach(bp);
 out_disable:
@@ -5219,11 +5589,17 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+	if (add) {
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		/* Cache the number; adva_x1_bus_claim() takes the reference
+		 * and re-checks the parent, as the number can be recycled.
+		 */
+		WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
+	} else {
+		/* invalidate before free */
+		WRITE_ONCE(bp->cpld_i2c_adap_nr, -1);
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
-
+	}
 	return 0;
 }
 
-- 
2.47.0

