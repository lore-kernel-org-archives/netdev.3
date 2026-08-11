Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87B33D4E8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456650; cv=none; b=o3Ls+BzwR8u1+s8m5mcGOMrEGVBuHJftt0Rm7RX/itXwt3E3BOqLLsA09HUjJao9ydq4fAamVtgTGmimQXE2lwNWyqLVKV7uHYX66hYBlWReu0v+l9jOkqASwt2pgTWGtbvIz4c8TWTChtbralH5eR87rVlu5k9Qqd8/ozvS2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456650; c=relaxed/simple;
	bh=r717KXPZHq0AeGzjZcDnH3nuDhjxd5wlCgI0fcKPl7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzVux/1R2NyAiiptyotlNewjyhk7HR5vK4nKVepLcDXjHZj0qjkVrj+eeZRMteflCY/vm4/hYCajDOAACg6k9DhZJEap1QSYQgZcMO6Q56dFEyDSthbYdSftRu4qlKIb0dLph4syI/DBYLBOx3WRDAiTXQM4D6jEKkYNxj7XceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYhGaGDR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYhGaGDR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso34003005e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786456644; x=1787061444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/LP+rqxzXW4o8Xbx0YIINob+HrBwNhW+3kF26O6H66E=;
        b=rYhGaGDRUiNFMiwoFipIugE5QdFDKR0RONGmjyNg1bzD2QtdIB9Qro7JvIX9eQwWdI
         06GTt93Hz4tY2D4gaql9uwyB5Py/caKugwTstEnrznTs/cF4JMBO/DUEwhe+4YE7Q1p0
         2rSrFyUyv07yGAaScIaST0tK+xPKvEc5Tp7wVFK203Ro3YQdv3LOuTi9TBoaTGX8UWlO
         znrLNc+XfIt5UbF9g5kRWqFebfLkOpDEDa6vf4HmJ9IfIHOD9ZARC2/GMt2RBb5mBtts
         fyoU8EG3NTjlw9voFIVNszw37OiusY4uxNJVWbqHVyWtFhMCn7xaoMMXryfrsob32oj+
         Jqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456644; x=1787061444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/LP+rqxzXW4o8Xbx0YIINob+HrBwNhW+3kF26O6H66E=;
        b=HkMyblpOrvvAwPRg+u0wqXDZdbN87eaR/LkFQvyxU94AUomrilQLhm5qyHOaVsxX7W
         MX35ve27QBALJn1wYGTz711pegRG9OoBOi991GXaqMsoN1ZuhNApNYkLMI72qfRewaGW
         s7DDIvePcgtcmOOgJldqQ01Otnacee24TH+H1AKQb1QE86i6ErN2+sRF1OM1PH3LVso1
         mTnQDDXjq2KrQOAE4HOJhy3+jGQr1cixYYpXaclkw0+RDMvjquB9U4fNLVLxycDIFK9T
         msk1whq/Nt3Uxo/fGeWCkukHI/O1j9bLCQV0khEP+Z7s+wIsPJ/FtCE1zepVBQoKWcCP
         GvMQ==
X-Gm-Message-State: AOJu0Yy/joNW8CEmDwoFhFZWVNYaA9ydfsjcfBNz02texmNaluJwzYhB
	WQh+pAb7HheHKX9SQcxJqClgIxfMlzdfjI5y0F34SlCJ2LTG7lt5kJe2tl+hJqSs
X-Gm-Gg: AR+sD11nvjiuz3PeWYL6HRnx2x9QTx1KlDZ2feHAp9LKfTBE0svqYXKddzXzf0JYxIq
	1yn8RAt2VfEervLH8BHjG6NUjbeX9N8Fq4NTPDErN6Zwu9/5htOvjraXQFLG0B49P1dySZ2RI1A
	HlkBTr0HVL1Rg+WydLZGjLh7PAS9gKUO7Sy9/llCCUkjVYZvane2rV0Bpf2JfHJ/hzbwHx4qGHE
	jdojPba9IvZ+jDsWE/OyvWi9nkvzKRy4ji+yVTKWOkrZk6VaWvGUr6BgYDrcgojtIZhpZ4M9Hze
	cO4JzdMOibGykvEabDhRyNFLlOSF1fqC8B+nU3ZK8ETkAHnqMjl8AVPoPqlZRMKytgpWwbo9RI6
	U/T7oYs/vipOMoNM/tDs9XeVYdocpQ0Poe9cIAhMsKAfdqQ6RZEhdZy5DL8JV3D5sfEQb8F/1qS
	l33/dsAUJL+8YcdYLNkG620dplWdzyZPHbE1ErC4CWW8mDN9LK0MBr7aABuDDmknYC5dXB4PdlB
	HV6TmnWY1IjPER1NlUHle8Lq60ONfZbk4rm
X-Received: by 2002:a05:600c:1d24:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-49978460326mr53149385e9.9.1786456644236;
        Tue, 11 Aug 2026 06:57:24 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788a6cdfsm34095085e9.6.2026.08.11.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:57:23 -0700 (PDT)
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
Subject: [PATCH net-next v11 1/2] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Tue, 11 Aug 2026 16:57:19 +0300
Message-ID: <20260811135720.109580-2-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260811135720.109580-1-maimon.sagi@gmail.com>
References: <20260811135720.109580-1-maimon.sagi@gmail.com>
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
 Documentation/ABI/testing/sysfs-timecard |  19 ++
 drivers/ptp/ptp_ocp.c                    | 344 ++++++++++++++++++++++-
 2 files changed, 359 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..26a93cee0b89 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -11,6 +11,25 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
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
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 3d26ec1f7b9e..41a7fde1ae6a 100644
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
@@ -416,6 +420,12 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* adva_x1 CPLD I2C (internal use only) */
+	struct mutex		cpld_lock;            /* serialises CPLD operations */
+	int			cpld_i2c_adap_nr;     /* I2C adapter nr; -1 if absent */
+	struct i2c_adapter	*cpld_adap;           /* claimed adapter; valid under cpld_lock */
+	u32			cpld_id;              /* cached Lattice device ID; 0 if unread */
+	bool			has_cpld;             /* x1 TAP CPLD present */
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -451,6 +461,7 @@ static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
+static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id);
 
 static const struct ocp_attr_group fb_timecard_groups[];
 
@@ -1273,6 +1284,7 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 			.signals_nr   = 4,
 			.freq_in_nr   = 4,
 			.attr_groups  = adva_timecard_x1_groups,
+			.has_cpld     = true,
 		},
 	},
 	{ }
@@ -2185,6 +2197,19 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
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
 
@@ -3199,6 +3224,7 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
+	bp->has_cpld = info->has_cpld;
 	return ptp_ocp_init_clock(bp, &info->servo);
 }
 
@@ -4226,6 +4252,298 @@ static const struct ocp_attr_group art_timecard_groups[] = {
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
+ * All buffers are heap-allocated internally to guarantee DMA safety for
+ * the Xilinx I2C controller.  Caller must hold the claim taken by
+ * adva_x1_bus_claim(), hence __i2c_transfer() rather than i2c_transfer().
+ */
+static int adva_x1_i2c_xfer(struct ptp_ocp *bp,
+			    u8 addr, const void *wdata, u8 wlen,
+			    void *rdata, u8 rlen)
+{
+	u8 *wbuf = NULL, *rbuf = NULL;
+	struct i2c_adapter *adap;
+	struct i2c_msg msgs[2];
+	int nmsgs = 0, ret;
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	adap = bp->cpld_adap;
+	if (!adap)
+		return -ENODEV;
+
+	if (wlen) {
+		wbuf = kmemdup(wdata, wlen, GFP_KERNEL);
+		if (!wbuf) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		msgs[nmsgs++] = (struct i2c_msg){
+			.addr  = addr,
+			.flags = I2C_M_DMA_SAFE,
+			.len   = wlen,
+			.buf   = wbuf,
+		};
+	}
+	if (rlen) {
+		rbuf = kzalloc(rlen, GFP_KERNEL);
+		if (!rbuf) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		msgs[nmsgs++] = (struct i2c_msg){
+			.addr  = addr,
+			.flags = I2C_M_RD | I2C_M_DMA_SAFE,
+			.len   = rlen,
+			.buf   = rbuf,
+		};
+	}
+
+	ret = __i2c_transfer(adap, msgs, nmsgs);
+	if (ret == nmsgs) {
+		if (rdata && rlen)
+			memcpy(rdata, rbuf, rlen);
+		ret = 0;
+	} else {
+		ret = (ret < 0) ? ret : -EIO;
+	}
+free:
+	kfree(wbuf);
+	kfree(rbuf);
+	return ret;
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
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	i2c_put_adapter(adap);
+}
+
+/*
+ * Claim the TMC bus for a CPLD operation.  Holding the adapter lock over
+ * the handshake keeps ptp_ocp_read_eeprom(), the nvmem attributes and the
+ * at24 sysfs files off the controller while it is routed away from the
+ * EEPROMs.
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
+	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0);
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
+	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, &cmd, 4, out, out_len);
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
+ * LCMXO3LF-2100 reports 0x612BC043.
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
@@ -4274,6 +4592,7 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_cpld_status.attr,
 	NULL,
 };
 
@@ -4904,6 +5223,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	mutex_destroy(&bp->cpld_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5080,6 +5400,17 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -5219,11 +5550,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
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

