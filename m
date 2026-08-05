Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928863E51C5
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918723; cv=none; b=KlHb/IWvKpJZDqE+dR5Uu2i+o8FkknDGpHHlaMNMaJXaMS+d8xR+NvyhufcmRYuY5S/qOnY8FpiYdGtrXU7Iucs731svq1y8UiG51lvyipoKWNLAQfqk5IZJhXKl7I8P3pm7V/oyHUxHsre6P2EWH7sk24EX4yPicf3BHQxPCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918723; c=relaxed/simple;
	bh=zvCCduuuWi9y6PxSbztnblG1umKIMhrlyDzmvA1l57w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGPctS/4PCfkizgX+pOSGwsad5uYwRUH0ghXLgvZQrophgB1cJFluVKKJwuoFJ1D9pec+E19s74M09MrtG6V9LXGkLvYJmD7zJQpsHoCWld/+Ckv6V2ejdeiegUGqFS4H8vPJ8w4B/Boc6YkHS9DxL2S/wOAvh2NIf3DNvgWEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzAUm/qe; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzAUm/qe"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664a09bc459so1043769d50.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785918720; x=1786523520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttR3n5pROMgXAIrz7B0ntb4TUjlzQz5+0RatzQr8rTo=;
        b=FzAUm/qedC6vrOtVnezYyaC/YeeMmlesrVlmKD/XBoqdAX46k/U6cMfO14UvVdqH0X
         E1f6UERw5arecuHWXtIdM5XpwwyPICsqv6Vox6Q+7Zo+T5uP2ZOZILvcJWr7DmpKli0I
         IdL5j6dpfYlzwJgqU0nlA0AoiRaK27jhdhMnxJAG+i3+6hhExYu2aK0pjyJ+N9bFocDY
         tkmlqTvH3btWrA5gciA5/DLPgbr7RuKO55sVwa3F/fHEXKeFgMqXqwQr4rextxPwVv8+
         liasHXLTGkKrjWOe74AHJrkZtAJOwczT1GcV/aVHg2hYyqY5r3oUwfK+FedLg6LRS1sV
         hLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918720; x=1786523520;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ttR3n5pROMgXAIrz7B0ntb4TUjlzQz5+0RatzQr8rTo=;
        b=Mv2+nyvD9+qxaB88EaPgOITqQbFq9ZiEmdeLNCwM0M2jyN0/xRut1oWPZOPEDcpNKO
         Afli+T5P7EtKDMbhMLoRWGSge/CE3s+88yDBhLA3t+ENN1U+600SJWgGf1rOYbsaEhoj
         Xb4JxDNrl08NlydKSVzK/TdzB4LM4IGKo3YDI1aNWieTk5B5kiK7TFz36WBB7mWOc9M/
         HNmipQAoEPFImyH2isCveZK/mOZkqkbIygOP5FPX3PnS/wMCopcEP0ZZkYDV737pGXgP
         ytNtn//ar+8Qx40lyzZnFS47jHOn0l57+KMNuC0Mb0ER7p93l8/UyBNU5+JiBtjbkBGI
         8GJg==
X-Forwarded-Encrypted: i=1; AHgh+RrzaW2z5RuQpeT/dUDnkIwUXvj0PZjSY7KFpW0HGioSkZO3PJJD4V2Dgcq/qA663ILDwnU63x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQA8CqfRdNItFiTOiKlhJ4jAkM+yqbaxb40ny4r6rF/+jAGcZC
	BIvN/IxCIyvfUppZ9sAIO1++EiqeU42CDdQNa2z7c+EiZ9WwrNkR4nguXoVbgxOR
X-Gm-Gg: AR+sD12/+3g2FsAw7Fa2Bb19AErb5h5hiFv9YhG2PDO1N5KU3uMN+ySWVtLalL2/ipk
	L5WMZmIuVf9uWfPi78JJYVQa1GeJtv2p9cbLx7rVrsrkzjgaqQFm7O3REy0gq+ixKrrkew98rq8
	xUeAtVXaUtAPLbHIFbQ678prghW3RcW0k1tLJ+SIVLTfi2jBevoQMEUIZ8UrVh6ngn67YaYKsHh
	mf8gc7St/MJVBwJZmj3ISZCgZItdUkVo7rYGjZsFCr8fVrzK0WKVUZCSS/DVgBKnvMAreBGjRtw
	ekss52Dx/hXxKvMvfghD3iy0qfTJqTuQTxTK4ZdOwP8xpYkU2hWDKTVdPPC2nvSrnGmnDmdgFjv
	tGJnR0nmlBaitYF0HfweDt0vX2GoovbtHA+uPpCITJTqXoygzePhKJ4RwoaJr56paiFX2gVgaOR
	u6BkNLiqPwtzWURtzVkyi1lnKmDOocmgLNWPTYgxeX/AiLOtd6aFwBKNtSAamTHIGwyNsedCERJ
	l++CB1LmZWxu1Ex/PKn4l3yig==
X-Received: by 2002:a05:690e:4396:b0:668:9b6a:653b with SMTP id 956f58d0204a3-6699a836f79mr2416953d50.3.1785918720271;
        Wed, 05 Aug 2026 01:32:00 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6699166dc17sm2512583d50.19.2026.08.05.01.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:31:59 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v10] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Wed,  5 Aug 2026 11:31:52 +0300
Message-ID: <20260805083154.3821-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
that is programmed over I2C using in-system programming (ISP).

The CPLD is connected to a secondary I2C bus shared with the onboard
MicroBlaze soft CPU.

Add support for CPLD access and firmware updates on the ADVA TimeCard X1
board by arbitration of the shared I2C bus, CPLD ISP command handling,
status polling, and firmware upload operations using the firmware-upload
subsystem.

Add the following X1-only user-visible interfaces:

  /sys/class/timecard/ocpN/cpld_device_id
        report the 32-bit Lattice MachXO3 CPLD device ID

  /sys/class/timecard/ocpN/cpld_status
        report the CPLD status register, including the DONE,
        BUSY, and FAILED indicators

Firmware updates are performed through the firmware-upload framework,
which acquires ownership of the shared I2C bus, erases the CPLD
configuration flash, programs the image page-by-page, and activates
the new image using the MachXO3 REFRESH command.

All CPLD operations are serialized and coordinated with the MicroBlaze
firmware to ensure exclusive access to the shared I2C bus. The added
interfaces are available only on ADVA TimeCard X1 boards.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

 Addressed comments from:
  - Vadim Fedorenko :https://lore.kernel.org/all/CAMuE1bEaRBJVSJYONJ2o3adOOzayv0ayNZ2qCB1zxuodpbiR=Q@mail.gmail.com/

 Changes since v9:
 - Remove duplicate header includes.
 - Fix reverse Christmas tree variable ordering.
 - Use get_unaligned_be32() for CPLD device ID decoding.
 - Make constant command argument arrays static.

 Documentation/ABI/testing/sysfs-timecard |  34 ++
 drivers/ptp/ptp_ocp.c                    | 495 ++++++++++++++++++++++-
 2 files changed, 525 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..f7c9955acb0a 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -11,6 +11,40 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
 Description:	This directory contains the attributes of the Nth timecard
 		registered.
 
+What:		/sys/class/timecard/ocpN/cpld_device_id
+Date:		July 2026
+Contact:	Sagi Maimon <maimon.sagi@gmail.com>
+Description:	(RO) The 32-bit Lattice device ID of the TAP CPLD, reported as
+		a hex string, e.g. "0xe12bc043".
+
+		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
+		The Lattice LCMXO3LF-210 reports 0xe12bc043.
+
+		The driver acquires the MicroBlaze I2C bus internally before
+		issuing the READ_IDCODE command; no bus arbitration is required
+		from userspace.
+
+What:		/sys/class/timecard/ocpN/cpld_status
+Date:		July 2026
+Contact:	Sagi Maimon <maimon.sagi@gmail.com>
+Description:	(RO) The status register of the TAP CPLD, in human-readable
+		form:
+
+		  done=<0|1> busy=<0|1> failed=<0|1>
+
+		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
+
+		done=1 indicates the configuration flash was successfully
+		programmed and is active.  busy=1 means an internal operation
+		is in progress.  failed=1 means the last ISC operation failed.
+
+		The driver acquires the MicroBlaze I2C bus internally; no bus
+		arbitration is required from userspace.
+
+		To program new CPLD firmware use the standard kernel
+		firmware-upload interface registered at:
+		/sys/class/firmware/adva-cpld/
+
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78..cb259413042b 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -24,6 +24,9 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
 #include <linux/dpll.h>
+#include <linux/unaligned.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
@@ -85,6 +88,7 @@ struct ptp_ocp_adva_info {
 	u8				signals_nr;
 	u8				freq_in_nr;
 	const struct ocp_attr_group	*attr_groups;
+	bool				has_cpld; /* x1: supports CPLD firmware upload */
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
@@ -416,6 +421,12 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* adva_x1 CPLD I2C (internal use only) */
+	struct mutex		cpld_lock;            /* serialises CPLD operations */
+	int			cpld_i2c_adap_nr;     /* I2C adapter nr; -1 if absent */
+	struct fw_upload	*cpld_fw_upload;      /* firmware upload handle; NULL if absent */
+	bool			cpld_cancel;          /* cancellation requested */
+	bool			cpld_in_config_mode;  /* EN_CFG_TP issued but not yet REFRESH'd */
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -449,6 +460,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static const struct fw_upload_ops adva_cpld_upload_ops;
+
 static const struct ocp_sma_op ocp_adva_sma_op;
 static const struct ocp_sma_op ocp_adva_x1_sma_op;
 
@@ -1273,6 +1286,7 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 			.signals_nr   = 4,
 			.freq_in_nr   = 4,
 			.attr_groups  = adva_timecard_x1_groups,
+			.has_cpld     = true,
 		},
 	},
 	{ }
@@ -3197,6 +3211,20 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
+	if (info->has_cpld) {
+		struct fw_upload *fwl;
+
+		fwl = firmware_upload_register(THIS_MODULE, &bp->pdev->dev,
+					       "adva-cpld",
+					       &adva_cpld_upload_ops, bp);
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
 
@@ -4224,6 +4252,442 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+/*
+ * Internal helpers for the adva_x1 TAP CPLD (Lattice LCMXO3LF-210).
+ *
+ * The CPLD sits at I2C address 0x40 behind a PCA9548 mux (0x74) on
+ * channel 0.  The I2C bus is shared with the MicroBlaze firmware;
+ * cpld_lock + mblaze acquire/release provide mutual exclusion for the
+ * full duration of any CPLD operation.  No raw I2C access is exposed
+ * to userspace; only the high-level attributes below are.
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
+#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mode */
+#define CPLD_CMD_DIS_CFG      0x26
+#define CPLD_CMD_ERASE        0x0E
+#define CPLD_CMD_RESET_ADDR   0x46
+#define CPLD_CMD_WRITE_PAGE   0x70
+#define CPLD_CMD_SET_DONE     0x5E
+#define CPLD_CMD_REFRESH      0x79
+#define CPLD_PAGE_SIZE        16
+
+/* Status register bit positions (Lattice LCMXO3LF datasheet) */
+#define CPLD_STATUS_DONE   BIT(8)
+#define CPLD_STATUS_BUSY   BIT(12)
+#define CPLD_STATUS_FAILED BIT(13)
+
+/*
+ * adva_x1_i2c_xfer() - issue a single I2C transaction on the CPLD bus.
+ *
+ * All buffers are heap-allocated internally to guarantee DMA safety for
+ * the Xilinx I2C controller.  Caller must hold bp->cpld_lock.
+ */
+static int adva_x1_i2c_xfer(struct ptp_ocp *bp,
+			    u8 addr, const void *wdata, u8 wlen,
+			    void *rdata, u8 rlen, bool nostart)
+{
+	u8 *wbuf = NULL, *rbuf = NULL;
+	struct i2c_adapter *adap;
+	struct i2c_msg msgs[2];
+	int nmsgs = 0, ret;
+
+	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
+	if (!adap)
+		return -ENODEV;
+
+	if (wlen) {
+		wbuf = kmemdup(wdata, wlen, GFP_KERNEL);
+		if (!wbuf) {
+			ret = -ENOMEM;
+			goto put;
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
+			goto put;
+		}
+		msgs[nmsgs++] = (struct i2c_msg){
+			.addr  = addr,
+			.flags = I2C_M_RD | I2C_M_DMA_SAFE |
+				 (nostart ? I2C_M_NOSTART : 0),
+			.len   = rlen,
+			.buf   = rbuf,
+		};
+	}
+
+	ret = i2c_transfer(adap, msgs, nmsgs);
+	if (ret == nmsgs) {
+		if (rdata && rlen)
+			memcpy(rdata, rbuf, rlen);
+		ret = 0;
+	} else {
+		ret = (ret < 0) ? ret : -EIO;
+	}
+put:
+	kfree(wbuf);
+	kfree(rbuf);
+	i2c_put_adapter(adap);
+	return ret;
+}
+
+/* Acquire the shared I2C bus from the MicroBlaze firmware. */
+static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
+{
+	u32 val;
+	int i;
+
+	if (!bp->pps_select)
+		return -ENODEV;
+
+	/* Release any stale grant left by a previous crashed caller. */
+	iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
+	val = ioread32(&bp->pps_select->i2c_bus_ctrl);
+	if (val != 0)
+		return -EBUSY;
+
+	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
+	for (i = 0; i < MBLAZE_RETRIES; i++) {
+		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
+		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
+		if (val == MBLAZE_GRANTED)
+			return 0;
+	}
+	return -ETIMEDOUT;
+}
+
+static void adva_x1_mblaze_release(struct ptp_ocp *bp)
+{
+	if (bp->pps_select)
+		iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
+}
+
+static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
+{
+	u8 val = (ch >= 0) ? BIT(ch) : 0;
+
+	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0, false);
+}
+
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
+	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, buf, 1 + nargs,
+				 NULL, 0, false);
+}
+
+/*
+ * Send a 4-byte command then read data back without an intermediate STOP
+ * (Lattice combined write→repeated-START→read).
+ */
+static int adva_x1_cpld_cmd_read(struct ptp_ocp *bp,
+				 u32 cmd_be, u8 *out, u8 out_len)
+{
+	__be32 cmd = cpu_to_be32(cmd_be);
+
+	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, &cmd, 4, out, out_len, true);
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
+static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
+{
+	unsigned int elapsed = 0;
+	u32 status;
+
+	while (elapsed < max_ms) {
+		if (adva_x1_cpld_read_status(bp, &status))
+			return -EIO;
+		if (status & CPLD_STATUS_FAILED)
+			return -EIO;
+		if (!(status & CPLD_STATUS_BUSY))
+			return 0;
+		usleep_range(100000, 101000);
+		elapsed += 100;
+	}
+	return -ETIMEDOUT;
+}
+
+/*
+ * cpld_device_id - show the Lattice device ID of the TAP CPLD.
+ *
+ * Returns the 32-bit ID as a hex string, e.g. "0x612bc043\n".
+ * Lattice LCMXO3LF-210 reports 0x612BC043.
+ */
+static ssize_t
+cpld_device_id_show(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+	u8 data[4];
+	u32 id = 0;
+	int ret;
+
+	mutex_lock(&bp->cpld_lock);
+	ret = adva_x1_mblaze_acquire(bp);
+	if (ret)
+		goto out;
+	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (ret)
+		goto release;
+	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
+	if (!ret)
+		id = get_unaligned_be32(data);
+	adva_x1_mux_select(bp, -1);
+release:
+	adva_x1_mblaze_release(bp);
+out:
+	mutex_unlock(&bp->cpld_lock);
+	return ret ? ret : sysfs_emit(buf, "0x%08x\n", id);
+}
+static DEVICE_ATTR_RO(cpld_device_id);
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
+	mutex_lock(&bp->cpld_lock);
+	ret = adva_x1_mblaze_acquire(bp);
+	if (ret)
+		goto out;
+	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (ret)
+		goto release;
+	ret = adva_x1_cpld_read_status(bp, &st);
+	adva_x1_mux_select(bp, -1);
+release:
+	adva_x1_mblaze_release(bp);
+out:
+	mutex_unlock(&bp->cpld_lock);
+	return ret ? ret : sysfs_emit(buf, "done=%u busy=%u failed=%u\n",
+				      !!(st & CPLD_STATUS_DONE),
+				      !!(st & CPLD_STATUS_BUSY),
+				      !!(st & CPLD_STATUS_FAILED));
+}
+static DEVICE_ATTR_RO(cpld_status);
+
+/*
+ * adva_x1 CPLD firmware-upload callbacks.
+ *
+ * The kernel firmware-upload subsystem (CONFIG_FW_UPLOAD) exposes:
+ *   /sys/class/firmware/adva-cpld/{data,loading,status,error,...}
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
+	if (!size || size % CPLD_PAGE_SIZE)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	bp->cpld_cancel		= false;
+	bp->cpld_in_config_mode	= false;
+
+	mutex_lock(&bp->cpld_lock);
+
+	if (adva_x1_mblaze_acquire(bp)) {
+		ret = FW_UPLOAD_ERR_TIMEOUT;
+		goto err_unlock;
+	}
+
+	if (adva_x1_mux_select(bp, ADVA_MUX_CHANNEL)) {
+		ret = FW_UPLOAD_ERR_HW_ERROR;
+		goto err_release;
+	}
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
+	    adva_x1_cpld_wait_ready(bp, 5000)) {
+		ret = FW_UPLOAD_ERR_HW_ERROR;
+		goto err_deselect;
+	}
+	bp->cpld_in_config_mode = true;
+
+	if (bp->cpld_cancel) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_deselect;
+	}
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE, era_args, 3) ||
+	    adva_x1_cpld_wait_ready(bp, 15000)) {
+		ret = FW_UPLOAD_ERR_HW_ERROR;
+		goto err_deselect;
+	}
+
+	if (bp->cpld_cancel) {
+		ret = FW_UPLOAD_ERR_CANCELED;
+		goto err_deselect;
+	}
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR, zero3, 3)) {
+		ret = FW_UPLOAD_ERR_HW_ERROR;
+		goto err_deselect;
+	}
+
+	return FW_UPLOAD_ERR_NONE;	/* cleanup() will unlock everything */
+
+err_deselect:
+	if (bp->cpld_in_config_mode) {
+		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);
+		bp->cpld_in_config_mode = false;
+	}
+	adva_x1_mux_select(bp, -1);
+err_release:
+	adva_x1_mblaze_release(bp);
+err_unlock:
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
+	if (bp->cpld_cancel)
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
+		return FW_UPLOAD_ERR_HW_ERROR;
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
+	u32 st;
+
+	if (bp->cpld_cancel)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE, zero3, 3) ||
+	    adva_x1_cpld_wait_ready(bp, 1000))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	if (adva_x1_cpld_read_status(bp, &st) || !(st & CPLD_STATUS_DONE))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	if (adva_x1_cpld_write(bp, CPLD_CMD_REFRESH, ref_args, 2))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	/* CPLD reboots after REFRESH; re-select mux once it comes back up */
+	msleep(1500);
+	adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
+	if (adva_x1_cpld_wait_ready(bp, 3000))
+		return FW_UPLOAD_ERR_TIMEOUT;
+
+	bp->cpld_in_config_mode = false;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void
+adva_cpld_cancel(struct fw_upload *fwl)
+{
+	struct ptp_ocp *bp = fwl->dd_handle;
+
+	bp->cpld_cancel = true;
+}
+
+static void
+adva_cpld_cleanup(struct fw_upload *fwl)
+{
+	static const u8 dis_args[2] = { 0x00, 0x00 };
+	struct ptp_ocp *bp = fwl->dd_handle;
+
+	if (bp->cpld_in_config_mode) {
+		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);
+		bp->cpld_in_config_mode = false;
+	}
+	adva_x1_mux_select(bp, -1);
+	adva_x1_mblaze_release(bp);
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
@@ -4272,6 +4736,8 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_cpld_device_id.attr,
+	&dev_attr_cpld_status.attr,
 	NULL,
 };
 
@@ -4902,6 +5368,11 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	if (bp->cpld_fw_upload) {
+		firmware_upload_unregister(bp->cpld_fw_upload);
+		bp->cpld_fw_upload = NULL;
+	}
+	mutex_destroy(&bp->cpld_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5078,6 +5549,17 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -5217,11 +5699,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+	if (add) {
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		/* Cache adapter nr; used by cpld_device_id/cpld_status/cpld_program
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

