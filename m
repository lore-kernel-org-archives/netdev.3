Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5230567B
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456651; cv=none; b=mAOI85soGSKA1Lq5tAENZSq99SqdgIAcXfJF6Uu5Ga0Gdo/lhtrsi+R3EPNydEHbHFKG7LE0iHJCzn6TuxnppYEKiSjpzylk+WQurTNwTUL+LK3PJ9z3cZqqOK8Ue3aDdLs7QgkdE+tFxO2o3uwrZRd5RKIukUWoteFOcw1yOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456651; c=relaxed/simple;
	bh=vXAp/mVOlrPb7Fd1npy+/sCObkSdPXGRgr+b71UchmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWnpFZ62HkzzR5x5IcukFhtNylkTreM/mU1CttS6M9EDKVJgEwWnbosvWwToPmrE+QCaYoTVhXzqVhSMdaw3pPndYUB/GDRiGXkZWGewgjhVmDIPMwNaZj18+yrPqbQHffXgh9A0hRnmmcHNsNvV8wmatEKET739dGnRkGnSBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgURVIHp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgURVIHp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso4551315e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786456646; x=1787061446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/ebuaLZT2Md8xdvwJSHj1EqpYIvEP+OxtDAJHEpI5E=;
        b=JgURVIHpEam5Dct6qTA128BIJpNIkLVc9BBJmbtvQe0VstKI7pfgM+feOtYdpDgh3T
         RaCmsnbG9An3Y4LIyGzlCioV/FPJ/A7VbzhXPnAowS9JfrUP0v4XDR2IN37uAU0+Pina
         /Eyimw4eDRlvaIMZk5s6lo9Gwu6SXfJHiIBNpmRScy6Ri6iq0f9Q/Y2pOItefZPVgTqM
         Qhh1zz0kVoLgSv2FkNCmdhPf75qk+XHa3kt9qVlZQcpJ4765n1Y78IJVKZhcygAwxwbM
         GNVoo967RTJ6ES5tbRqM0l2Br/FttxGQ5HZzSe7e6sIzfObJPlWv4eQxlUIAikp0TieF
         H2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456646; x=1787061446;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/ebuaLZT2Md8xdvwJSHj1EqpYIvEP+OxtDAJHEpI5E=;
        b=qCtDpYYH8u2fWbMLE+AA2ta78IG2TFasroriudRxQgqII6cz4k129/m4fyWn5YDWC5
         ikPkY5AE71WsZrqysOAGXk2Ws512wvCgbbsrutEeKX3aLeHDz8ZGwOP0eIEa+Z463LIM
         xCjTnX7FU4TW9Of/8eo9HkCDllDqhgbmyvM6RroLa/e0Lf/Ln8iJAriisbrv/MvP+Rfi
         dLLSxNadGyMLvQDDwkYZffmay2xJl8hrcgybevE9i03/YQIV0Ayd4jH+pOcgHiMgEtar
         LDzMuB/G5pEQMy1/COojfbPniL3vwwp2dBUYfkE06MEdi5OUmYirM2k56bRVM5cuCKVQ
         khSg==
X-Gm-Message-State: AOJu0YzIcTRIFQFoDDi5hQAPG+32dxgM9p49QRLcaDte46jiYBlKwe7I
	Ma8hkWKp/tyJNAeW5iKZDzVmmSt71i3XWnZR29h/v/IGf3cE8DkAA6hwWVxpDk19
X-Gm-Gg: AR+sD12qkfeRFblZhlD7avP0cZ3LmkL1hcPjt/qAnQlmsGFZUOCiMKCiGbEkzBLbkO+
	q0X68BFShByFl5ccrpuO0aeXztyNAOKYdPBFE07NdehuKX2u+u5k2iiJfc9shz6e0doLIX0er33
	Db2fHyBAUV6p/U7/YS4t7/7vN5s9d6IWxsvW83ykaWfDEBJY8lKTtgTjFchkhbv1kVyx2mdnDHc
	F48OX7NH9lWH/ymL86XsivKkquXARrIYLKR8x0WUTl/Mro2BTXYqrPklU8tDA6z5tyvIBb9vz73
	VzyK081OhgsvNI62qjdr8GdqQ/M5RTpUxG0NcDukc7o1psJ9IZcwWbFJTR1OgNCGDebDiHhYwVK
	NxY8CuU7bx2fmEA0KISWOBTz5e3x8CB/sJ5HbQJY1QSedN5QmHZE/oDVYBz+mC41E4QrU3Blp6F
	2grskARwIB0q7iccvergMbA6jRx9b4jeqByzljn4QsEQFK624XfLaGm6sCW4awGh2hDXYSwnL+E
	hAmIAwz3/Ulmc49WYkKw/09sw==
X-Received: by 2002:a05:600c:3b9b:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4997a62dcb0mr3540765e9.18.1786456645673;
        Tue, 11 Aug 2026 06:57:25 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788a6cdfsm34095085e9.6.2026.08.11.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:57:25 -0700 (PDT)
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
Subject: [PATCH net-next v11 2/2] ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1
Date: Tue, 11 Aug 2026 16:57:20 +0300
Message-ID: <20260811135720.109580-3-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260811135720.109580-1-maimon.sagi@gmail.com>
References: <20260811135720.109580-1-maimon.sagi@gmail.com>
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
 Documentation/ABI/testing/sysfs-timecard |   5 +
 drivers/ptp/Kconfig                      |   2 +
 drivers/ptp/ptp_ocp.c                    | 313 ++++++++++++++++++++++-
 3 files changed, 319 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 26a93cee0b89..41eeadd46330 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -30,6 +30,11 @@ Description:	(RO, root only) The status register of the TAP CPLD, in
 		ID of the CPLD is reported as the fixed "cpld.id" version by
 		devlink dev info.
 
+		To program new CPLD firmware use the standard kernel
+		firmware-upload interface, registered per card at:
+		/sys/class/firmware/adva-cpld.N/
+		where N is the index of this ocpN device.
+
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b7..0c2c7dd32e7f 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -218,6 +218,8 @@ config PTP_1588_CLOCK_OCP
 	select NET_DEVLINK
 	select CRC16
 	select DPLL
+	select FW_LOADER
+	select FW_UPLOAD
 	help
 	  This driver adds support for an OpenCompute time card.
 
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 41a7fde1ae6a..4a0bd9b89452 100644
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
 
@@ -426,6 +428,9 @@ struct ptp_ocp {
 	struct i2c_adapter	*cpld_adap;           /* claimed adapter; valid under cpld_lock */
 	u32			cpld_id;              /* cached Lattice device ID; 0 if unread */
 	bool			has_cpld;             /* x1 TAP CPLD present */
+	struct fw_upload	*cpld_fw_upload;      /* firmware upload handle; NULL if absent */
+	bool			cpld_cancel;          /* cancellation requested */
+	bool			cpld_in_config_mode;  /* EN_CFG_TP issued but not yet REFRESH'd */
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -459,6 +464,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static const struct fw_upload_ops adva_cpld_upload_ops;
+
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
 static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id);
@@ -3225,6 +3232,29 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
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
 
@@ -4283,6 +4313,15 @@ static const struct ocp_attr_group art_timecard_groups[] = {
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
@@ -4408,7 +4447,8 @@ static void adva_x1_bus_release(struct ptp_ocp *bp)
  * Claim the TMC bus for a CPLD operation.  Holding the adapter lock over
  * the handshake keeps ptp_ocp_read_eeprom(), the nvmem attributes and the
  * at24 sysfs files off the controller while it is routed away from the
- * EEPROMs.
+ * EEPROMs.  A firmware upload holds it across the whole prepare/write/poll
+ * sequence, so an EEPROM read blocks for as long as programming takes.
  */
 static int adva_x1_bus_claim(struct ptp_ocp *bp)
 {
@@ -4442,6 +4482,20 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
 	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0);
 }
 
+/* Send 1-byte ISC command + optional arguments. */
+static int adva_x1_cpld_write(struct ptp_ocp *bp,
+			      u8 cmd, const u8 *args, u8 nargs)
+{
+	u8 buf[1 + 64];
+
+	if (nargs > 64)
+		return -EINVAL;
+	buf[0] = cmd;
+	if (nargs)
+		memcpy(&buf[1], args, nargs);
+	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, buf, 1 + nargs, NULL, 0);
+}
+
 /*
  * Send a 4-byte command then read data back without an intermediate STOP
  * (Lattice combined write->repeated-START->read).  Two messages in one
@@ -4467,6 +4521,38 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
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
@@ -4544,6 +4630,222 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
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
+	static const u8 era_args[3] = { 0x04, 0x00, 0x00 }; /* cfg sector only */
+	static const u8 en_args[2]  = { 0x08, 0x00 };
+	static const u8 dis_args[2] = { 0x00, 0x00 };
+	static const u8 zero3[3]    = { 0 };
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
+	if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
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
+	if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE, era_args, 3) ||
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
+	if (adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR, zero3, 3)) {
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
+		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);
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
+	u8 page_args[3 + CPLD_PAGE_SIZE];
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	if (READ_ONCE(bp->cpld_cancel))
+		return FW_UPLOAD_ERR_CANCELED;
+
+	if (size < CPLD_PAGE_SIZE)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	page_args[0] = 0x00;
+	page_args[1] = 0x00;
+	page_args[2] = 0x01;
+	memcpy(&page_args[3], data + offset, CPLD_PAGE_SIZE);
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_WRITE_PAGE,
+			       page_args, 3 + CPLD_PAGE_SIZE) ||
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
+	static const u8 ref_args[2] = { 0x00, 0x00 };
+	static const u8 zero3[3]    = { 0 };
+	struct ptp_ocp *bp = fwl->dd_handle;
+	int err;
+	u32 st;
+
+	lockdep_assert_held(&bp->cpld_lock);
+
+	if (READ_ONCE(bp->cpld_cancel))
+		return FW_UPLOAD_ERR_CANCELED;
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE, zero3, 3) ||
+	    adva_x1_cpld_wait_ready(bp, 1000))
+		return adva_cpld_err(bp);
+
+	if (adva_x1_cpld_read_status(bp, &st) || !(st & CPLD_STATUS_DONE))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_REFRESH, ref_args, 2))
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
+	static const u8 dis_args[2] = { 0x00, 0x00 };
+	struct ptp_ocp *bp = fwl->dd_handle;
+
+	__acquire(&bp->cpld_lock);	/* held since prepare() returned ok */
+	lockdep_assert_held(&bp->cpld_lock);
+
+	if (bp->cpld_in_config_mode) {
+		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);
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
@@ -5186,6 +5488,15 @@ ptp_ocp_detach(struct ptp_ocp *bp)
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

