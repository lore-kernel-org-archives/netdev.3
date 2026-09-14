Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715B3B19B5
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370150; cv=none; b=N13/PV4noxFdcBRqpQvj/mEz3XKfcRQImE3U77PAYz4hkmU1cpGpHDUv7SWeoXGAawgvLyaT8HRrvEb8UpKmNzsHSR8T+6R9nmoZBOKUSg5bds+Q6f7lFHPRSG04VSMAZcKTfkIX/Xfutz4G8piQcmivlHaOkKNLN5/GfQc/Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370150; c=relaxed/simple;
	bh=daOt5lWNYyHvriR9j/9+ZGzI8yEvwgW80BmG1PGMQJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNi9MH7T8MCaFhveBJdOcFdTJ4OnvHmIXbVAk0TmnAWodr8pEm0tWNNE7eIdv/LFoFfnkzl2+30l20TtbsnlUfQPV8qY6X1Et5q8kb6QwK49AMCNflDq7e/Z9tfsTMB3LZOXBx1uAFBaTXJ3HARqqkwVUfqR4Fc3LS+uplDz8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTKeoyy7; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTKeoyy7"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so686586f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370145; x=1789974945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNz8sB3S+x4guC51FwtW9TDNSE702r9jmMXEbrHt3tI=;
        b=fTKeoyy7LvjngP/4yEAMjmy55uH/ih6xSn9B6Yjs7UWDqymCcfcJqpLprPDCFzL5Vf
         67JO1PdKENcTdsuty0OiZcY70D739BiXHeAXyz1duS2X+305RkBOKAReBSsz6/dDEluB
         p7oGVx9si28pMWs8HoUctMlNIeOQ1NQg5jLdrCNB1KKuWzkxgDJkdXiKXrxsmPtqwfJj
         +OUMa4op8U4RCG30HpnCg5dBb4qY+EcPJV8tPXYGYLxcv81iR75LsZ/4mFxeqwdtMbh4
         LGzvx304j8954v4j0LRj3HrjQI+YTHdFp6MTt9BpODBN3oKOQzvglOueDmbSScBndF/q
         nYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370145; x=1789974945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNz8sB3S+x4guC51FwtW9TDNSE702r9jmMXEbrHt3tI=;
        b=mx0T0IfpjwaaEgOBmTI+0oK9u8yjigKELCdbF9L1ZMxubwecpqma73YYkpmWHGNuB+
         O7i9BGoKyNLOjQDWlypaWyLcSDYsevLyK15X0NwS2Y7bWGw/ybUI0mSMUxlLV1cS9KG4
         zpCZRFtp9PGB1/CMY1HpRbQHae+iK5O1N3jMKj9nO15Va+XlJl+d5ECPZCG2MIbFHErX
         wFk3gk27Qzn6ZqGMDILGQQ7nCM8nLUX46YwuLUslw5H18i9fmBTCHnVQt18ZiY8J0lus
         1ZqzMr/e9CGexBdJIziO3M61pnVdNtdscSIzXOr2dG5NNf73kcyUZh8lTsqLNSRiS0wI
         hb5w==
X-Forwarded-Encrypted: i=1; AKwUvBzgCd+znkWFub2e2NaWtE4RpCTWRL9Rg7tFZZWZNY9NyKiLvSOQLJV0i5tPXKD8fhQvZohR8Hs=@vger.kernel.org
X-Gm-Message-State: AFuF++lPNZB0R7VIBJjU2gEt6ZJVkL1SoN0Hmln6etE/Nm/wTmcQVWeA
	2F+e36t33CpyVkWfhqw+pfFxeJ4TD/DuVCMLjdkro8MrJmVdmFVTO5h0
X-Gm-Gg: AYBFou0jorimTACgDkS7ScCgKZWJAwI1t2dqQ635tCWBZ8vJ0rQdU6H63NE4GVDgbK6
	AxP1CnwfHXZTFSAuUL3PjL2nHc45Jupm7ujKtL0LXdpXBdDgdxZ3G1P44A+NxxJmFFwfs1hzp4m
	SwLKgli7cVlG/o87sUu8QmlbB7Yz5leCJC7P+15kDY4ZYhsV3G5IYrzfW66SYK8rwe63vRkwy4H
	DDNiya1pOmB/DJWhqQJOedZCsj09Ql8A5//iD5UVlTzIw8T80sxOHLB+xC5m47ha48mCn0GoD52
	O6gHgndly3CVomTBQq6Ls/ZKJe0L/ap1/FjIfuLLXg1WjiBTQxmPYgihYo/g6HNChN+3NW4rryL
	4Yb6EBi8vIaHoprY6//iEcnorIEdJxJMI+un4DwrZ8TMypXG9qF7rXYs3Om4cAdgKrVSySJUUyK
	iuf2Q6dcOtkuvPGYxXpXuSd1enVYSbWNyOUvQc5w6A/TnBe87ehlIhbld1TokXzl7cWHWEpU132
	yEJ+BJtflNrvwLedl8gmr+t+1/8vt/e6tFAc9tY
X-Received: by 2002:a05:6000:1785:b0:485:8a46:b3c4 with SMTP id ffacd0b85a97d-48702b5e64bmr1135220f8f.44.1789370144806;
        Mon, 14 Sep 2026 00:15:44 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e4b5sm24472558f8f.22.2026.09.14.00.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:15:43 -0700 (PDT)
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
Subject: [PATCH net-next v14 3/4] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Mon, 14 Sep 2026 10:15:30 +0300
Message-ID: <20260914071531.11640-4-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260914071531.11640-1-maimon.sagi@gmail.com>
References: <20260914071531.11640-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X1 carries a Lattice MachXO3 CPLD on its TMC I2C bus.
Reaching it means taking that bus from the on-card MicroBlaze first.

The card has two I2C controllers.  Linux registers only the one at
0x00150000, normally routed to the config EEPROMs; the one at 0x00120000
belongs to the MicroBlaze and is routed to the TMC or M.2 bus as its
firmware selects.  A request/grant handshake re-routes the host controller
onto the TMC bus, where the PCA9548 and the CPLD behind its channel 0
live.  An operation takes the i2c core adapter lock for the whole grant
window and uses __i2c_transfer() internally; without that, a concurrent
transfer from ptp_ocp_read_eeprom(), from the nvmem attributes or from the
at24 sysfs files would be issued onto the TMC bus instead of to the
EEPROM.  The hand-back waits for the firmware to drop the grant before the
adapter lock is released, for the same reason.

On top of the arbitration this adds two read-only interfaces: a root-only
cpld_status attribute reporting the flags in the CPLD status register, and
the Lattice device ID as the fixed devlink version cpld.id.  Reading the
ID claims the bus, so it must not sit on DEVLINK_CMD_INFO_GET, which
carries no GENL_ADMIN_PERM; the driver reads it once from its own worker,
as soon as the i2c adapter has registered, and info_get() reports the
cached value.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Documentation/ABI/testing/sysfs-timecard     |  24 +
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/ptp_ocp.rst |  35 ++
 MAINTAINERS                                  |   1 +
 drivers/ptp/ptp_ocp.c                        | 447 ++++++++++++++++++-
 5 files changed, 504 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/networking/devlink/ptp_ocp.rst

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..c440d8930384 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -11,6 +11,30 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
 Description:	This directory contains the attributes of the Nth timecard
 		registered.
 
+What:		/sys/class/timecard/ocpN/cpld_status
+Date:		July 2026
+Contact:	Sagi Maimon <maimon.sagi@gmail.com>
+Description:	(RO, root only) The flags set in the status register of the
+		TAP CPLD, space separated, or an empty line when none is
+		set.  Only present on ADVA x1 TAP boards (PCI ID
+		0xad5a:0x0410).
+
+		==========  ================================================
+		done        the configuration flash was programmed
+			    successfully and is active
+		busy        an internal operation is in progress
+		failed      the last ISC operation failed
+		==========  ================================================
+
+		For example "busy" while programming, or "busy failed" if a
+		failure is latched while another operation runs.
+
+		A read arbitrates for the shared I2C bus and reprograms the
+		on-card mux, so it is restricted to root.  The Lattice device
+		ID of the CPLD is read once by the driver, shortly after
+		probe, and reported from that cached value as the fixed
+		"cpld.id" version by devlink dev info.
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
index 0e04d92d1b09..113f31434617 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20479,6 +20479,7 @@ OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/networking/devlink/ptp_ocp.rst
 F:	drivers/ptp/ptp_ocp.c
 
 OPENCORES I2C BUS DRIVER
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index f4299878c27c..98cb26077181 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -20,10 +20,14 @@
 #include <linux/spi/altera.h>
 #include <net/devlink.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/mtd/mtd.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
 #include <linux/dpll.h>
+#include <linux/unaligned.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
@@ -85,6 +89,8 @@ struct ptp_ocp_adva_info {
 	u8				signals_nr;
 	u8				freq_in_nr;
 	const struct ocp_attr_group	*attr_groups;
+	/* x1: TAP CPLD present */
+	bool				has_cpld;
 };
 
 #define OCP_CTRL_ENABLE		BIT(0)
@@ -163,7 +169,8 @@ struct gpio_reg {
 	u32	gpio1;
 	u32	__pad0;
 	u32	gpio2;
-	u32	__pad1;
+	/* adva_x1: I2C bus ownership register; reserved on other variants */
+	u32	i2c_bus_ctrl;
 };
 
 struct irig_master_reg {
@@ -416,6 +423,23 @@ struct ptp_ocp {
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
+	/* the one-shot ID read is finished, successfully or not */
+	bool			cpld_id_tried;
+	/* failed ID read attempts so far */
+	unsigned int		cpld_id_attempts;
+	/* x1 TAP CPLD present */
+	bool			has_cpld;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -1273,6 +1297,7 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 			.signals_nr   = 4,
 			.freq_in_nr   = 4,
 			.attr_groups  = adva_timecard_x1_groups,
+			.has_cpld     = true,
 		},
 	},
 	{ }
@@ -2159,6 +2184,7 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	const char *fw_image;
 	char buf[32];
 	int err;
+	u32 id;
 
 	fw_image = bp->fw_loader ? "loader" : "fw";
 	sprintf(buf, "%d.%d", bp->fw_tag, bp->fw_version);
@@ -2166,6 +2192,18 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
+	/* Read by the worker, not here: this command is unprivileged and
+	 * reading the ID claims the I2C bus.  0 means unread - skip it
+	 * rather than fail, devlink discards the whole reply on error.
+	 */
+	id = READ_ONCE(bp->cpld_id);
+	if (bp->has_cpld && id) {
+		sprintf(buf, "0x%08x", id);
+		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
+		if (err)
+			return err;
+	}
+
 	if (!bp->has_eeprom_data) {
 		ptp_ocp_read_eeprom(bp);
 		if (!bp->has_eeprom_data)
@@ -3199,6 +3237,8 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
+	bp->has_cpld = info->has_cpld;
+
 	return ptp_ocp_init_clock(bp, &info->servo);
 }
 
@@ -4226,6 +4266,367 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+/*
+ * adva_x1 TAP CPLD (Lattice LCMXO3LF-2100) helpers.
+ *
+ * The card has two I2C controllers; Linux registers only 0x00150000.
+ * The i2c_bus_ctrl handshake re-routes what each is wired to:
+ *
+ *   grant 0:  0x150000 -> EEPROMs     0x120000 -> TMC or M.2, MB's choice
+ *   grant 1:  0x150000 -> TMC bus     0x120000 -> M.2
+ *
+ * The PCA9548 at 0x74 and the CPLD at 0x40 behind its channel 0 are on the
+ * TMC bus, reachable only while the grant is held.  The EEPROMs are not
+ * behind the adapter for that window, so a CPLD operation holds cpld_lock
+ * and the adapter lock to keep the EEPROM and nvmem paths off it.
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
+#define CPLD_ID_MAX_ATTEMPTS  10     /* one per sync_work tick */
+
+/* Status register bit positions (Lattice LCMXO3LF datasheet) */
+#define CPLD_STATUS_DONE   BIT(8)
+#define CPLD_STATUS_BUSY   BIT(12)
+#define CPLD_STATUS_FAILED BIT(13)
+
+/*
+ * Issue one I2C transaction on the TMC bus: @cmd if not negative, then
+ * @wlen bytes of @wdata (NULL sends zeros), then @rlen bytes read back.
+ * The message is built in the scratch buffer from adva_x1_bus_claim(), so
+ * an upload costs one allocation rather than one per page.  I2C_M_DMA_SAFE
+ * is not set: the two halves are not separately aligned, so let the core
+ * bounce.  Caller holds the claim, hence __i2c_transfer().
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
+/* Hand the segment back, and wait for the firmware to drop the grant before
+ * the caller unlocks the adapter: a transfer queued behind us would
+ * otherwise be clocked out while the controller is still on the TMC bus,
+ * which is what holding the adapter lock across the grant exists to stop.
+ */
+static void adva_x1_mblaze_release(struct ptp_ocp *bp)
+{
+	int i;
+
+	if (!bp->pps_select)
+		return;
+
+	iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
+	/* Flush the posted write, as the acquire path does. */
+	ioread32(&bp->pps_select->i2c_bus_ctrl);
+
+	for (i = 0; i < MBLAZE_RETRIES; i++) {
+		if (ioread32(&bp->pps_select->i2c_bus_ctrl) != MBLAZE_GRANTED)
+			return;
+		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
+	}
+
+	dev_warn(&bp->pdev->dev, "TMC bus still granted after release\n");
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
+static int adva_x1_i2c_adap_match(struct device *dev, const void *data)
+{
+	return !!i2c_verify_adapter(dev);
+}
+
+/*
+ * Cache the adapter the CPLD hangs off.  ptp_ocp_i2c_notifier_call() misses
+ * it when the i2c controller driver is already loaded: the adapter is then
+ * added from inside platform_device_register(), before bp->i2c_ctrl is set.
+ * Only direct children are searched, so a mux adapter cannot match.
+ */
+static void adva_x1_cache_i2c_adap(struct ptp_ocp *bp)
+{
+	struct device *child;
+
+	if (!bp->has_cpld || !bp->i2c_ctrl ||
+	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
+		return;
+
+	child = device_find_child(&bp->i2c_ctrl->dev, NULL,
+				  adva_x1_i2c_adap_match);
+	if (!child)
+		return;
+
+	WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
+	put_device(child);
+}
+
+/*
+ * Claim the TMC bus.  The adapter lock is held across the handshake to keep
+ * the EEPROM, nvmem and at24 paths off the controller while it is routed
+ * away from the EEPROMs; an EEPROM read blocks until the claim is dropped.
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
+	/* One scratch buffer per claim rather than per transfer: an upload
+	 * holds the claim for the whole image.
+	 */
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
+ * Send a 4-byte command and read back without an intermediate STOP: two
+ * messages in one transfer is the Lattice write -> repeated START -> read,
+ * so no protocol-mangling flag is needed.
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
+ * unprivileged devlink path, which reports the cached value.  -EBUSY means
+ * cpld_lock is held, so the caller can retry rather than wait behind a long
+ * CPLD operation.
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
+		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
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
+/* cpld_status - show the flags set in the TAP CPLD status register. */
+static ssize_t
+cpld_status_show(struct device *dev, struct device_attribute *attr,
+		 char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+	int count = 0;
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
+	if (ret)
+		return ret;
+
+	/* Flags: the names of the bits that are set, nothing when none is,
+	 * rather than a value per bit in one file.
+	 */
+	if (st & CPLD_STATUS_DONE)
+		count += sysfs_emit_at(buf, count, "done");
+	if (st & CPLD_STATUS_BUSY)
+		count += sysfs_emit_at(buf, count, "%sbusy", count ? " " : "");
+	if (st & CPLD_STATUS_FAILED)
+		count += sysfs_emit_at(buf, count, "%sfailed",
+				       count ? " " : "");
+
+	return count + sysfs_emit_at(buf, count, "\n");
+}
+static DEVICE_ATTR_ADMIN_RO(cpld_status);
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
@@ -4274,6 +4675,7 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_cpld_status.attr,
 	NULL,
 };
 
@@ -4904,6 +5306,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	mutex_destroy(&bp->cpld_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5052,6 +5455,20 @@ ptp_ocp_sync_work(struct work_struct *work)
 
 	bp->sync = sync;
 
+	/* The adapter can appear after probe, so read the ID from here once
+	 * it has.  A claim can fail transiently - the firmware may not grant
+	 * the segment straight after power-up - so retry a bounded number of
+	 * times.  -EBUSY means cpld_lock is held and does not count.
+	 */
+	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
+	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0) {
+		int err = adva_x1_cpld_read_id(bp);
+
+		if (err != -EBUSY &&
+		    (!err || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS))
+			WRITE_ONCE(bp->cpld_id_tried, true);
+	}
+
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 }
 
@@ -5080,6 +5497,14 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto out_disable;
 
+	/* Before the first error path that calls ptp_ocp_detach(), so
+	 * mutex_destroy() runs on an initialised mutex, and before
+	 * ptp_ocp_register_resources(), so this sentinel cannot overwrite an
+	 * adapter number the i2c notifier stores during registration.
+	 */
+	mutex_init(&bp->cpld_lock);
+	bp->cpld_i2c_adap_nr = -1;
+
 	INIT_DELAYED_WORK(&bp->sync_work, ptp_ocp_sync_work);
 
 	/* compat mode.
@@ -5099,6 +5524,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto out;
 
+	adva_x1_cache_i2c_adap(bp);
+
 	bp->ptp = ptp_clock_register(&bp->ptp_info, &pdev->dev);
 	if (IS_ERR(bp->ptp)) {
 		err = PTR_ERR(bp->ptp);
@@ -5158,6 +5585,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_dpll_put:
 	dpll_device_put(bp->dpll, &bp->tracker);
 out_devlink:
+	/* detach() destroys cpld_lock; no devlink op may still reach it */
 	devlink_unregister(devlink);
 out:
 	ptp_ocp_detach(bp);
@@ -5204,6 +5632,7 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 			  unsigned long action, void *data)
 {
 	struct device *dev, *child = data;
+	struct i2c_adapter *adap;
 	struct ptp_ocp *bp;
 	bool add;
 
@@ -5227,11 +5656,21 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+	adap = i2c_verify_adapter(child);
+	if (add) {
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		/* Only the card's own controller: a mux child added on it
+		 * reaches ptp_ocp through the same walk.  Numbers are
+		 * recycled, so the claim re-checks the parent itself.
+		 */
+		if (bp->i2c_ctrl && adap->dev.parent == &bp->i2c_ctrl->dev)
+			WRITE_ONCE(bp->cpld_i2c_adap_nr, adap->nr);
+	} else {
+		/* invalidate before free, but only for the cached adapter */
+		if (READ_ONCE(bp->cpld_i2c_adap_nr) == adap->nr)
+			WRITE_ONCE(bp->cpld_i2c_adap_nr, -1);
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
-
+	}
 	return 0;
 }
 
-- 
2.47.0

