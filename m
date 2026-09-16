Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69868530DEC
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572789; cv=none; b=tAclOlo+pS+RdfIoxxhNLEA1rp0Pjew6Qz7r0vG+FsGOsRID5SjMqpWz156WxFIxLjtkHfpgJbWwJV3IMGsiDzU919DV8gtU0RONT1vd/W9e3aDIfY0VHm8hXzgaql7e6/cYu0g7QWmwe84q1NRhj9/hfgeTjJvZvBFvJTZW1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572789; c=relaxed/simple;
	bh=E4A+uC6mKqTGjqiafh8/hwvG5L/9VQ1iKn3wvJL0Mvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAvZ7GQM6+Vah3igy9nqCqDZlYbTfXYlf/1B5otP+MCde+2z6L1iPNedQmAiL76pTc8HhXqQCNMKD8Y+0M9wiGBX0L/Wa4wc6OM3rdOVU+9N81aYNY93m+KSP1LHzYj2Ldl5ytUPFBgDr9/O5pb/ZWEVnbjNIcPrtAzONz+sAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOU6L5yr; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOU6L5yr"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae52so1918691a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572775; x=1790177575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgBqc63Vjup4IxutUaaRpDbVvng+VN5hbzg1um80clM=;
        b=MOU6L5yrj+pgvmNnRvCYyNs79P7LqmA+F62f73E6qvV9Vz0LtEWNAN4//bggTYbvxL
         0dRwYNJYBKfjdIphNDLpzzyj3IzJHXhjrwseQ5nF8r4qJIIoxKUj9/sappKsCXBkuew8
         nksTCwgbRxZtTFtEDkAKzrRBQJAZtLkJSJk2IjnNhnqKAOb3FnCmAXhPyGtlRdZd5MIT
         MWelO+rOsebgnnpBUaFmjmhOSvWO2xmyUXI0yAWcT0Z/MAUYPhO/2XS2tRjPNPiEXLTA
         CB4HpkZY/UsxO/aAc9GCRr8+Q4+wDXaQEJHGF+aOniFvHzH9hLIXNhkHc+s95LPzdi+C
         RiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572775; x=1790177575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgBqc63Vjup4IxutUaaRpDbVvng+VN5hbzg1um80clM=;
        b=xXdwSRWtWF02EUaoOkY76KazYiJW/YLTTxGuaPOFvRBnCFPZlMWCZy/IocUYUKjNbO
         qHrzn3V8mgYnVVhHqg99qauAzObSVwwi2dA8kbxo7BAIzYL9EvB9JQKbqVQufHGdINDe
         4XhYWxWAIgVApolNNsaxF56hN00CQQ06OBENYx1AVufuDg9LH8QbmJ1e6PLyPusAdXbT
         etGSP98CF2mXTT6VGTKKuhkOEvxp2Nixg+Wc2LihPrlCJzK28pmteh5WDKo8pc9UyqgI
         exs4NYcvocnhSI85g+/bqy/5bZw5rXIgxAArz/dIZ+FJqXy3i55zb7DF5xu8OTxA7WZA
         bvxA==
X-Forwarded-Encrypted: i=1; AKwUvBxZzJbuqsTcvep6/Q/96AoTvPzObbTYQwFHHPlKDkI7qXR4tbaXgtfQVWzOZqBydPRZPZNYgRc=@vger.kernel.org
X-Gm-Message-State: AFuF++k3HIzwALy1+SMctACjOXlCmTYRe59sJa1mUUJ3qVH0Z2NyRQfc
	gXbEL63iuEqSf+en1OGN9hTh4TyG5Qlg6sG7FlN9/KE3JY85PEyz45ux
X-Gm-Gg: AYBFou0uV2I8wif/odSc7ACc9xAugKWowmz1l7Sr36mP57ZkbjALQDk8CPVgkTikByv
	fkPFyf2+wGKtEPp5wbheziO4nAQ0O+S8GYa+ET38plM7ovYTJ4v0pndcuB/vXLPaIU4QsYYnlWo
	v9UAvHIPaNMmBtwgYaWT0reOjKPXbJolDZJMkOif/DxaSarm4Lsr21qAzZh6RxpqhU0mDliu7Ob
	VucEk290Z7RS5kYF6zdt/xn/rAR43rZmmEMCtez722J2svDIonq7wj/c/SJ/WhKwtzFkfIqhuNK
	+sAuKjSKQg3NQjftjNP65dikwSTJ+U1DVapIs6TNn11rII0QkHiqNiIe/267QtKwHA3TwS9jSqc
	RHz0FgUZFVA37F0dqLpfaVcDPGjvFUHyygmO/CImLxrltQMMf1c346W6BNnq4vOyv2YST3HPQV0
	WWMv7SPNVXCwiLhYukliyRwfdTDRmLd5ZAfhiCGpw2iFJYSoPdrKclpCR4qywsioydET1GwLh7O
	W98eyu4nj7He6jiKZjnvY1IdQs81CD36ssoqWC0eQ==
X-Received: by 2002:a05:6402:21cf:b0:6a9:b523:375b with SMTP id 4fb4d7f45d1cf-6aa22358ffamr4981856a12.6.1789572774753;
        Wed, 16 Sep 2026 08:32:54 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe0562sm2067081a12.3.2026.09.16.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:32:54 -0700 (PDT)
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
Subject: [PATCH net-next v15 3/4] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Wed, 16 Sep 2026 18:32:41 +0300
Message-ID: <20260916153242.157171-4-sagi.maimon@adtran.com>
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
 drivers/ptp/ptp_ocp.c                        | 514 ++++++++++++++++++-
 5 files changed, 571 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/networking/devlink/ptp_ocp.rst

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..e58824e0cdcd 100644
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
+		done        the configuration flash holds a valid image and
+			    it is active
+		busy        an internal operation is in progress
+		failed      the last ISC operation failed
+		==========  ================================================
+
+		For example "busy" while an operation runs, or "busy failed"
+		if a failure is latched while another one is in progress.
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
index f4299878c27c..998ea9c6b381 100644
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
@@ -416,6 +421,25 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* adva_x1 CPLD I2C (internal use only) */
+	/* serialises CPLD operations */
+	struct mutex		cpld_lock;
+	/* guards cpld_i2c_adap_nr against the bus notifier */
+	spinlock_t		cpld_adap_lock;
+	/* I2C adapter nr; -1 if absent.  Under cpld_adap_lock */
+	int			cpld_i2c_adap_nr;
+	/* claimed adapter; valid under cpld_lock */
+	struct i2c_adapter	*cpld_adap;
+	/* scratch, write half then read half; valid under cpld_lock */
+	u8			*cpld_buf;
+	/* Lattice device ID; 0 if unread */
+	u32			cpld_id;
+	/* one-shot ID read finished, successfully or not; under cpld_lock */
+	bool			cpld_id_tried;
+	/* failed ID read attempts so far; under cpld_lock */
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
 
@@ -4226,6 +4266,434 @@ static const struct ocp_attr_group art_timecard_groups[] = {
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
+/* i2c_bus_ctrl carries a host-written request half and a firmware-written
+ * grant half.  MBLAZE_GRANTED is what a granted register reads while our
+ * request still stands; the release write clears the request half, so from
+ * then on only the grant field can be tested.  Measured on an ADVA
+ * TimeCard X1: the register reads 0x00000012 once the firmware has handed
+ * the segment back, about 670 ms after the release write, so the low half
+ * is not zero then and only the grant field is a valid test.
+ */
+#define MBLAZE_REQUEST    0x0000aaaaU
+#define MBLAZE_GRANTED    0x5555aaaaU
+#define MBLAZE_RELEASE    0x55550000U
+#define MBLAZE_GRANT_MASK 0xffff0000U
+#define MBLAZE_GRANT      0x55550000U
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
+ * a run of transfers costs one allocation, not one each.  I2C_M_DMA_SAFE
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
+static int adva_x1_mblaze_release(struct ptp_ocp *bp)
+{
+	u32 val = 0;
+	int i;
+
+	if (!bp->pps_select)
+		return 0;
+
+	iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
+	/* Flush the posted write, as the acquire path does. */
+	ioread32(&bp->pps_select->i2c_bus_ctrl);
+
+	for (i = 0; i < MBLAZE_RETRIES; i++) {
+		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
+		if ((val & MBLAZE_GRANT_MASK) != MBLAZE_GRANT)
+			return 0;
+		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
+	}
+
+	dev_err(&bp->pdev->dev,
+		"TMC bus still granted after release, i2c_bus_ctrl 0x%08x\n",
+		val);
+
+	return -ETIMEDOUT;
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
+	/* Drop the request we gave up on.  Any error from the hand-back is
+	 * subsumed by the -ETIMEDOUT we are already returning.
+	 */
+	adva_x1_mblaze_release(bp);
+	return -ETIMEDOUT;
+}
+
+/* Route the host controller back to the EEPROMs and release the adapter.
+ * Safe after a failed claim: it also clears a request that was never granted.
+ *
+ * The adapter is unlocked even when the hand-back timed out: keeping the
+ * root lock would stall every other user of the controller for good, with
+ * no way to recover it.  The error is returned instead, so the operation
+ * that held the claim fails rather than reporting success over a bus that
+ * may still be routed to the TMC segment.
+ */
+static int adva_x1_bus_release(struct ptp_ocp *bp)
+{
+	struct i2c_adapter *adap = bp->cpld_adap;
+	int err;
+
+	if (!adap)
+		return 0;
+
+	err = adva_x1_mblaze_release(bp);
+	bp->cpld_adap = NULL;
+	kfree(bp->cpld_buf);
+	bp->cpld_buf = NULL;
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	i2c_put_adapter(adap);
+
+	return err;
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
+ *
+ * Called from the worker rather than once from probe: device_add() notifies
+ * before it links the device to its parent, so with asynchronous probing
+ * both the notifier and a single lookup here can miss the same adapter.
+ * Retrying costs a short klist walk per tick until one of them succeeds.
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
+	/* Re-test under the lock so this does not overwrite a number the
+	 * notifier published meanwhile.  It cannot tell that apart from a
+	 * number the notifier has just invalidated, so an adapter removed in
+	 * this window can still be cached; adva_x1_bus_claim() rejects it on
+	 * the parent check and forgets it, and the next tick looks again.
+	 */
+	scoped_guard(spinlock, &bp->cpld_adap_lock) {
+		if (bp->cpld_i2c_adap_nr < 0)
+			bp->cpld_i2c_adap_nr = i2c_verify_adapter(child)->nr;
+	}
+
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
+	 * already be another adapter's.  Check this is still ours, and drop
+	 * a number that is not: otherwise every later claim fails the same
+	 * way, where forgetting it lets the worker look the adapter up again.
+	 */
+	if (!bp->i2c_ctrl || adap->dev.parent != &bp->i2c_ctrl->dev) {
+		scoped_guard(spinlock, &bp->cpld_adap_lock) {
+			if (bp->cpld_i2c_adap_nr == adap->nr)
+				bp->cpld_i2c_adap_nr = -1;
+		}
+		i2c_put_adapter(adap);
+		return -ENODEV;
+	}
+
+	/* One scratch buffer per claim rather than per transfer: a claim can
+	 * cover many transfers.
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
+		adva_x1_bus_release(bp);	/* keeps the acquire error */
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
+	int err, ret;
+
+	if (!mutex_trylock(&bp->cpld_lock))
+		return -EBUSY;
+
+	ret = adva_x1_bus_claim(bp);
+	if (ret)
+		goto out;
+	/* A select reported as failed may still have been ACKed, so the
+	 * deselect runs either way rather than handing the mux back with a
+	 * channel possibly left open.
+	 */
+	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (ret)
+		goto deselect;
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
+	if (!ret)
+		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
+deselect:
+	err = adva_x1_mux_select(bp, -1);
+	if (!ret)
+		ret = err;
+	err = adva_x1_bus_release(bp);
+	if (!ret)
+		ret = err;
+out:
+	/* Under cpld_lock, so an operation that resets this bookkeeping
+	 * while holding the lock cannot have it overwritten afterwards by a
+	 * worker that had already finished reading.
+	 */
+	if (!ret || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS)
+		bp->cpld_id_tried = true;
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
+	int err, ret;
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
+		goto deselect;
+	ret = adva_x1_cpld_read_status(bp, &st);
+deselect:
+	err = adva_x1_mux_select(bp, -1);
+	if (!ret)
+		ret = err;
+	err = adva_x1_bus_release(bp);
+	if (!ret)
+		ret = err;
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
@@ -4274,6 +4742,7 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_cpld_status.attr,
 	NULL,
 };
 
@@ -4904,6 +5373,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	mutex_destroy(&bp->cpld_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5052,6 +5522,17 @@ ptp_ocp_sync_work(struct work_struct *work)
 
 	bp->sync = sync;
 
+	/* Resolve the adapter here rather than once in probe, where it can
+	 * race the adapter's own registration, and read the ID as soon as it
+	 * turns up.  A claim can fail transiently - the firmware may not
+	 * grant the segment straight after power-up - so adva_x1_cpld_read_id()
+	 * retries a bounded number of times before giving up.
+	 */
+	adva_x1_cache_i2c_adap(bp);
+	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
+	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
+		adva_x1_cpld_read_id(bp);
+
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 }
 
@@ -5080,6 +5561,15 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto out_disable;
 
+	/* Before the first error path that calls ptp_ocp_detach(), so
+	 * mutex_destroy() runs on an initialised mutex, and before
+	 * ptp_ocp_register_resources(), so this sentinel cannot overwrite an
+	 * adapter number the i2c notifier stores during registration.
+	 */
+	mutex_init(&bp->cpld_lock);
+	spin_lock_init(&bp->cpld_adap_lock);
+	bp->cpld_i2c_adap_nr = -1;
+
 	INIT_DELAYED_WORK(&bp->sync_work, ptp_ocp_sync_work);
 
 	/* compat mode.
@@ -5158,6 +5648,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_dpll_put:
 	dpll_device_put(bp->dpll, &bp->tracker);
 out_devlink:
+	/* detach() destroys cpld_lock; no devlink op may still reach it */
 	devlink_unregister(devlink);
 out:
 	ptp_ocp_detach(bp);
@@ -5204,6 +5695,7 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 			  unsigned long action, void *data)
 {
 	struct device *dev, *child = data;
+	struct i2c_adapter *adap;
 	struct ptp_ocp *bp;
 	bool add;
 
@@ -5227,11 +5719,25 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
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
+		if (bp->i2c_ctrl && adap->dev.parent == &bp->i2c_ctrl->dev) {
+			scoped_guard(spinlock, &bp->cpld_adap_lock)
+				bp->cpld_i2c_adap_nr = adap->nr;
+		}
+	} else {
+		/* invalidate before free, but only for the cached adapter */
+		scoped_guard(spinlock, &bp->cpld_adap_lock) {
+			if (bp->cpld_i2c_adap_nr == adap->nr)
+				bp->cpld_i2c_adap_nr = -1;
+		}
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
-
+	}
 	return 0;
 }
 
-- 
2.47.0

