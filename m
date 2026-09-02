Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879A3603D8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324162; cv=none; b=s8lidyDznvUCBzt2OS3OUP1SMtuFvbAlo4v1/zDwTr4SF5BY8zsmEOQcpZTv/1QjUnFvu5mvLHlIIuO4loyJvr/ET8KPBuFB8RtJJ3jrgO+BYmhtoydyaSxin5RdPTuSSaCVzyGbuDN6dxjbdyHvDUXaHL/1G8J4dI9fjmtineM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324162; c=relaxed/simple;
	bh=jgnjYGJiAa07AzIL2wP61WZZPY9ce6zGXbe3VdF2mnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7/JEgk+V2rPBYLWTMPabF1uWUfWCIBFCiIg3kCWrNgV8m5+6PboD2OTrFV0DEYqz1QSZIPtpdSyDUiLi4UBw4qYGIZ7qPa8d7iz+/1LhtBbMzboLyyrsn4TI97OBrmvcZAKBO75fmTqDRPyTCP+baHeH5gZaPvdVT75X/r+HLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQUrtHmc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQUrtHmc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957eefd361so3595875e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788324158; x=1788928958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoQoHtvLCNUmujF1+W/3SyPKdcF5ZTq0L4n/+hbdFOg=;
        b=lQUrtHmcVsRUBIWPD0Xc4DlBrJJRfveUYrd3FuSstzokI2F9noAY0MF5HCecG3O8jF
         j81ihpzh4wtJ7nih39cFwfZvtJ/d+GI2SbZHocYdiDLpf4sNyUZ5JWB+HRD146Qo9pWs
         cp+zrqFLd4iaIqDvbuBxgdqQac2htXSeTbVfVrquy8r2oTN2DtPRwlHyfmEXhb9agI6q
         AklOmtAkGu/49P6ULceyk190uVYteW2Ltr8IbuUphZedaG1TodYwlh/YBpDuSnbg5UPR
         BeWZHXGs0iKEd/Rf8TaExFTOPu2FK3WEGG7N/m1BvVgKufHlE5GobkbF4SUwDTnw/fat
         p4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788324158; x=1788928958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoQoHtvLCNUmujF1+W/3SyPKdcF5ZTq0L4n/+hbdFOg=;
        b=pUasaJpqcZACPzNpibwkejeHu3ZGzIcPMjg5VzwXBEyW8wM9wpDEYGNuzSPhISsIvW
         Rsj6dVgqSx7ZMTUtDd4X+RSp6Yf6QuK9Kf1+KzjGPno8G9WE81zd8udjRFkw2WrgCVdE
         T5fg1HYpvFcvOzw5Rkrga3HLTUtH6E07Q/tn3+ThAPFQvi8UwFmH+lLdNg0k7rVoeJ/m
         XjbDIpaFnNQDwbI2X0SH+Wk2Svq1s826vVvew6PVTNWR+wFvurEZep5K/UKUaxdXno0l
         Cl0iAhnFJF84NbYK9YEH+pSWomHvRpjMFZHqO0H4PmoZrF4MI65YdFNY/9j3oORziP8D
         d9Qg==
X-Gm-Message-State: AFuF++mbf9JSdG135Al3z27iMAuszgOGkCvhj8anxRtUpANTuaiDw2dx
	8reMqr4u6RCLwnl70H6UEGXBLXrkaJtq1uUHp8iIF1k0HkGsbIv8DRT9Mbj1H7AS
X-Gm-Gg: AR+sD1119nsklqBBHBAMWdnm5mlJZjD7SIygi+A0FVUOLtaxJr/cpE+kgQDx2AHVZTY
	Hed4dkhS2PflBlsu0fMuyZpY3aWJcHwF+ACz6FuoCvX9z/xVDJSYaoo07l0KRzeCO3oqQOiDMLK
	Aqj8zgBjVq3urdskIgzJGl7CIRTHwsV6P+NtE5HardoYmKbCI0aESJA94KX2qoeq634L4+mWt8r
	GAlzMHMk/tAS83KYKqotWvXIcdas74yemU0EXq43MsxZZmgP38BAyrGquZXGVZOaOexfEyY1dxR
	3HrsKbfj1n6SqSGHCR+qsEmUaHukOo8k59v8eHy6NoZo5gzZ1bz2tZpMWIc/MxPkOdllO7zcMGe
	WHq/pa2VnXiFAUgDGtzhvS4/1U1F4t7Ms9RRrn/cpJUDlkvJJ46imjF2KkNapgAzH6aSdkE3KSQ
	c4dg16qOfBvpgaszqqmwrIV/oKk9j6Ho7rkVI84NuZsZ6JV5wzTw/b8hWnm0Dw6u3Y1PU82UEjU
	siMAuxZgH/Jjd4q4SsYrDmFcqMrTA==
X-Received: by 2002:a05:600c:c16d:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-49ce55cb47cmr39633605e9.0.1788324157688;
        Tue, 01 Sep 2026 21:42:37 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm127274165e9.4.2026.09.01.21.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:42:37 -0700 (PDT)
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
Subject: [PATCH net-next v12 1/2] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Wed,  2 Sep 2026 07:42:31 +0300
Message-ID: <20260902044232.21188-2-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260902044232.21188-1-maimon.sagi@gmail.com>
References: <20260902044232.21188-1-maimon.sagi@gmail.com>
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
 Documentation/ABI/testing/sysfs-timecard |  20 ++
 drivers/ptp/ptp_ocp.c                    | 362 ++++++++++++++++++++++-
 2 files changed, 378 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..b384e837c5e6 100644
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
+		ID of the CPLD is reported as the fixed "cpld.id" version by
+		devlink dev info.
+
+
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 3d26ec1f7b9e..0c5c3ec8de5f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -24,6 +24,8 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
 #include <linux/dpll.h>
+#include <linux/unaligned.h>
+#include <linux/delay.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
@@ -85,6 +87,7 @@ struct ptp_ocp_adva_info {
 	u8				signals_nr;
 	u8				freq_in_nr;
 	const struct ocp_attr_group	*attr_groups;
+	bool				has_cpld; /* x1: supports CPLD firmware upload */
 };
 
 #define OCP_CTRL_ENABLE		BIT(0)
@@ -163,7 +166,8 @@ struct gpio_reg {
 	u32	gpio1;
 	u32	__pad0;
 	u32	gpio2;
-	u32	__pad1;
+	/* adva_x1: I2C bus ownership register; reserved on other variants */
+	u32	i2c_bus_ctrl;
 };
 
 struct irig_master_reg {
@@ -416,6 +420,13 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* adva_x1 CPLD I2C (internal use only) */
+	struct mutex		cpld_lock;            /* serialises CPLD operations */
+	int			cpld_i2c_adap_nr;     /* I2C adapter nr; -1 if absent */
+	struct i2c_adapter	*cpld_adap;           /* claimed adapter; valid under cpld_lock */
+	u8			*cpld_buf;            /* DMA-safe scratch; valid under cpld_lock */
+	u32			cpld_id;              /* cached Lattice device ID; 0 if unread */
+	bool			has_cpld;             /* x1 TAP CPLD present */
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -451,6 +462,7 @@ static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
+static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id);
 
 static const struct ocp_attr_group fb_timecard_groups[];
 
@@ -1273,6 +1285,7 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 			.signals_nr   = 4,
 			.freq_in_nr   = 4,
 			.attr_groups  = adva_timecard_x1_groups,
+			.has_cpld     = true,
 		},
 	},
 	{ }
@@ -2185,6 +2198,19 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
+	if (bp->has_cpld) {
+		u32 id;
+
+		err = adva_x1_cpld_device_id(bp, &id);
+		if (err)
+			return err;
+
+		sprintf(buf, "0x%08x", id);
+		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -3199,6 +3225,7 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
+	bp->has_cpld = info->has_cpld;
 	return ptp_ocp_init_clock(bp, &info->servo);
 }
 
@@ -4226,6 +4253,315 @@ static const struct ocp_attr_group art_timecard_groups[] = {
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
+ * adva_x1_bus_claim(), which the Xilinx controller needs for DMA safety:
+ * an opcode and its arguments are copied exactly once.
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
+			.flags = I2C_M_DMA_SAFE,
+			.len   = hdr + wlen,
+			.buf   = wbuf,
+		};
+	}
+	if (rlen) {
+		msgs[nmsgs++] = (struct i2c_msg){
+			.addr  = addr,
+			.flags = I2C_M_RD | I2C_M_DMA_SAFE,
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
+ * EEPROMs.  A firmware upload holds it across the whole prepare/write/poll
+ * sequence, so an EEPROM read blocks for as long as programming takes.
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
+ * Read the Lattice device ID of the TAP CPLD.  It is a fixed property of
+ * the part, so cache it and pay the bus arbitration only once.  The
+ * LCMXO3LF-2100 IDCODE is 0xe12bc043.
+ */
+static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id)
+{
+	u8 data[4];
+	int ret;
+
+	if (bp->cpld_id) {
+		*id = bp->cpld_id;
+		return 0;
+	}
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
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
+	if (!ret)
+		bp->cpld_id = get_unaligned_be32(data);
+	adva_x1_mux_select(bp, -1);
+release:
+	adva_x1_bus_release(bp);
+out:
+	mutex_unlock(&bp->cpld_lock);
+	if (!ret)
+		*id = bp->cpld_id;
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
@@ -4274,6 +4610,7 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_cpld_status.attr,
 	NULL,
 };
 
@@ -4904,6 +5241,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	mutex_destroy(&bp->cpld_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5080,6 +5418,17 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -5219,11 +5568,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+	if (add) {
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		/* Cache adapter nr; used by the CPLD status/id/upload paths
+		 * for reference-counted unbind-safe adapter access.
+		 */
+		WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
+	} else {
+		WRITE_ONCE(bp->cpld_i2c_adap_nr, -1); /* invalidate before free */
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
-
+	}
 	return 0;
 }
 
-- 
2.47.0

