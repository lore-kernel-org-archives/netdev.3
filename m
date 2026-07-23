Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5E4BC00B
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817564; cv=none; b=Z/XShHc+i5/b3uhH7Flk77BZQpOsX2ZTrLS2nNYJCOWbQ4dodH1F3YBolRDX0bqW24xGl5x7JVVNzsLrThXVGZXv5yWgp3byv/dnSA28Ere4rGARP4TO87nByVQ6nr59y5Wo9ewVdqRA2Fbfmynjj0+spWcNFOHZMlp95D+cDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817564; c=relaxed/simple;
	bh=wfF6Kt5nVkBpk+3kpVoctW2zmqOxCk48WNWDxOwu124=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LB6X+ckXtpRF0/AdcABJjuhqfbiGw6bNtWXJjprCtjlcUpCaa4kJjXfZveneRPjwbwEI4+Z+IZt/lbtU53oa8/j+/H+kh22sG1HY2PLXqgLDQ6XqAr+sU1fosf//tFFP+NM3ePXjl6wJsyzjHyULNsDbX9R+Yi0cVGMgsCy74hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze9378PL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze9378PL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4720f3bf164so382838f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784817552; x=1785422352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvu6lxj6OeqUQYyFv5DacnLWudR+U9FdlzIrhx81a10=;
        b=Ze9378PLbFUnLS4I5v7VWoIaK/vHSRK6oNjKbSSQCB0gAQq/ex0pQIcR6xmicpOudB
         eleqylRj8LgTgQP4nCLTKRCJzbZ1p9nK60czsahZMu3ZS+cvwzSYqzvSvAaqYQdGC5oT
         OafMzrv9LFqU0P+jf9F6gXfCy/UHpFqprwkCc6uyYOv97ImVsRs9YYxVt3pcLh0A02Yi
         g2euhlupZhkik//wsUv/ANAps8gSIxO3XDxn+lZerx/UbIQw9nBzD9G0Ofll1wPgiRL8
         7T6/Eu53xadWyYcLL4Na8Q441OInhBmeztGoW6jP73I1kHwCxV9bndNKdSw0cMKyXlXH
         ZT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817552; x=1785422352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvu6lxj6OeqUQYyFv5DacnLWudR+U9FdlzIrhx81a10=;
        b=hSjhvxRBL1Uek/oCiCQ0icylnCgR6ipOKcqcgQwQpSE+3axSb0S/yB9R+5gaMMTwU0
         uq92dQ2eaL7FzBRPN8WIuf94wTjYApeYKfsVC5wouxZyQ75Uahgik8GuyQN3wCGM14CF
         H5XGVGYmXB7x6D0DKTAuJ3CJqpzyOvPCdm5mAigokOnzGHSAFk6TYPDalVw/Jgz1sExs
         q0trDOdKYxyeuU09kMz+MyxsqWyMQAQZo8ytzZMEUFSlyAvBc3uq0vfE4TF/NLOC4RH1
         ZRgvIJtRo7QmiFUxBDvwIQFZ2CZxx+CboEozpLcG161tLcP8F+Dirk+BDPZxfvgQSNjN
         JGUA==
X-Forwarded-Encrypted: i=1; AHgh+RrSeKlyRRXmB1N0QRakf5wsLepslw2hqswRL29avynEnKrG6fzFFh/+rgvWUjnZqcku7JhM6Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpoC1HeE5yXG78y3iAE8Qmp25+zs2gIKgeVtc2uEynNhgkPma
	S5HdahBa/Gt3LFJuvxt9ybUntXM0nJPUvqoIxoLyBlLElEFcTgVpmdDWvsVs2wufgLg=
X-Gm-Gg: AR+sD10D5nJN6rrUToj+jnvSB7LN1FfdGU2pcRigHiNGx+yEXCByRBIp57H2wkWaOr6
	Yfmqlkd0dt2o9UXBM08bxmXvzdXBcqtaUjssHVfqE6F3Q94Cfmgl6QXOxKtcNzw4g9oZJZZD1lp
	AuJcniWaHi7Zfev6w5qyZisp28QkQuetuTlwyR0z0xDizRMXLP6EL+abSCgTwYRL8Ht3VwTZaWd
	VRkatrLCOyoU5fSCuTm5Y+WeSfCm/TFTtI/gl5CzppVmyA29VHe+2efMlAO50nTt9IPwl8ut40w
	XP41oZYQUmMsbQNR39A3dRSqztp57pzsd/mRE23Q0e92/p4D+6FQ6AeyU86eqz3nAMxw/CukM4w
	3XL+xjGl5bfeOI8/Usep5zTjFBrUTyP7sxPPzhCwia0H3S5uaky6bj6Fbktklzeaiwasf8qoZwx
	ZTxds0j5LNqKKIIfL7rvrz2CajOpZ0AbNH3l0B0jE=
X-Received: by 2002:a05:6000:188e:b0:472:1424:fc7c with SMTP id ffacd0b85a97d-47f901cde65mr3859380f8f.10.1784817552059;
        Thu, 23 Jul 2026 07:39:12 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm16650154f8f.33.2026.07.23.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:39:11 -0700 (PDT)
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
Subject: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Thu, 23 Jul 2026 17:39:07 +0300
Message-ID: <20260723143908.4019-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
that is programmed over I2C using in-system programming (ISP).

The CPLD is connected to a secondary I2C bus shared with the onboard
MicroBlaze soft CPU.  Add support for taking ownership of this bus and
exposing the required interfaces through sysfs, allowing userspace tools
to perform CPLD programming.

To limit the scope of this functionality, sysfs-based I2C access is
restricted to the ADVA TimeCard X1 variant and only for the two I2C
slave addresses used during ISP (0x40 CPLD, 0x74 mux).

Add two sysfs attributes under /sys/class/timecard/ocpN/ (x1 only):

i2c_bus_ctrl  - arbitrate the shared I2C bus from the MicroBlaze via
                a three-step read/write/poll handshake

cpld_i2c_xfer - binary passthrough for I2C transactions to the CPLD
                and its PCA9548 mux; one atomic request per write()

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

 Addressed comments from:
  - Jakub Kicinski :https://lore.kernel.org/all/20260722184418.266546-1-kuba@kernel.org/

 Changes since v5:
  - ptp_ocp.c: move mutex_init(&bp->tap_i2c_lock) and
    bp->tap_i2c_adap_nr = -1 to before the first error path that
    reaches ptp_ocp_detach(), so mutex_destroy() never operates on an
    uninitialised mutex (CONFIG_DEBUG_MUTEXES splat on the
    pci_alloc_irq_vectors() failure path).
  - ptp_ocp.c: reword the ordering comment above mutex_init /
    tap_i2c_adap_nr to correctly describe the notifier race: the -1
    sentinel must precede ptp_ocp_register_resources() so that a
    ptp_ocp_i2c_notifier_call() firing during adapter registration is
    not overwritten by this initialisation line; ptp_ocp_adva_board_init()
    does not touch tap_i2c_adap_nr and was wrongly cited in the
    previous wording.
  - Documentation/ABI/testing/sysfs-timecard: add entries for the two
    new attributes cpld_i2c_xfer (binary I2C pass-through, wire protocol,
    allowed addresses, response layout) and i2c_bus_ctrl (three-step
    handshake, magic values, release requirement, PCIe ordering note).   
 
 Documentation/ABI/testing/sysfs-timecard |  56 ++++++
 drivers/ptp/ptp_ocp.c                    | 239 ++++++++++++++++++++++-
 2 files changed, 290 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..c62766df7a20 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -11,6 +11,62 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
 Description:	This directory contains the attributes of the Nth timecard
 		registered.
 
+What:		/sys/class/timecard/ocpN/cpld_i2c_xfer
+Date:		July 2026
+Contact:	Sagi Maimon <sagi.maimon@adva.com>
+Description:	(RW) Binary sysfs attribute providing a raw I2C passthrough to
+		the CPLD and I2C mux on ADVA x1 TAP boards.  Only present on
+		that board variant.
+
+		Each write initiates one I2C transaction.  The write payload
+		must be exactly four header bytes followed by the write data:
+
+		  Byte 0: slave address (only 0x40 and 0x74 are permitted)
+		  Byte 1: number of bytes to write (0..67)
+		  Byte 2: number of bytes to read back (0..20)
+		  Byte 3: flags
+		            bit 0 - suppress the repeated START before the
+		                    read segment (I2C_M_NOSTART); only valid
+		                    when both write and read lengths are
+		                    non-zero
+		  Bytes 4..: write data (write_len bytes)
+
+		A subsequent read() returns:
+
+		  Byte 0: status (0 = success, positive errno on error)
+		  Bytes 1..: read data (read_len bytes), present only when
+		             status is 0 and read_len > 0
+
+		The write and read portions of the sysfs file share a single
+		per-device response buffer protected by a mutex; a single
+		open() / write() / read() sequence must be used to avoid
+		data races between concurrent users.
+
+		Only slave addresses 0x40 (Lattice CPLD) and 0x74 (PCA9548
+		I2C mux) are accepted; all others return EPERM.
+
+What:		/sys/class/timecard/ocpN/i2c_bus_ctrl
+Date:		July 2026
+Contact:	Sagi Maimon <sagi.maimon@adva.com>
+Description:	(RW) Exposes the MicroBlaze I2C bus arbitration register for
+		the shared I2C bus on ADVA x1 and x2 TAP boards.  Only
+		present when the board has a pps_select register block.
+
+		Userspace must complete a three-step handshake before
+		driving the bus:
+
+		  1. Read  - value must be 0x00000000 (bus is free).
+		  2. Write - 0x0000ffff (request ownership).
+		  3. Poll  - read until the value is 0xffffffff (MicroBlaze
+		             has acknowledged the handover).
+
+		After all I2C traffic is complete the bus must be released
+		by writing 0x00000000.
+
+		The poll read is a PCIe non-posted read and therefore also
+		flushes the preceding posted write to the FPGA; no
+		additional read-back is required for ordering.
+
 What:		/sys/class/timecard/ocpN/available_clock_sources
 Date:		September 2021
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78..79fec5161c99 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -163,7 +163,8 @@ struct gpio_reg {
 	u32	gpio1;
 	u32	__pad0;
 	u32	gpio2;
-	u32	__pad1;
+	/* adva_x1: I2C bus ownership register; reserved on other variants */
+	u32	i2c_bus_ctrl;
 };
 
 struct irig_master_reg {
@@ -416,6 +417,11 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* cpld_i2c_xfer sysfs (adva_x1) */
+	struct mutex		tap_i2c_lock;
+	int			tap_i2c_adap_nr; /* adapter nr; -1 if absent */
+	u8			tap_i2c_rsp[21]; /* [status, read_data...] */
+	size_t			tap_i2c_rsp_len;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -4224,6 +4230,205 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+/*
+ * i2c_bus_ctrl exposes the MicroBlaze I2C bus arbitration register.
+ *
+ * The shared bus requires a three-step handshake before use:
+ *   read 0x00000000 (free) -> write 0x0000ffff (request) ->
+ *   poll until 0xffffffff (MicroBlaze confirms release).
+ *
+ * The poll is a PCIe non-posted read, which also flushes the preceding
+ * posted write to the FPGA, so no separate kernel read-back is needed.
+ */
+static ssize_t
+i2c_bus_ctrl_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+
+	if (!bp->pps_select)
+		return -ENODEV;
+	return sysfs_emit(buf, "0x%08x\n",
+			  ioread32(&bp->pps_select->i2c_bus_ctrl));
+}
+
+static ssize_t
+i2c_bus_ctrl_store(struct device *dev, struct device_attribute *attr,
+		   const char *buf, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!bp->pps_select)
+		return -ENODEV;
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+	iowrite32(val, &bp->pps_select->i2c_bus_ctrl);
+	return count;
+}
+
+static DEVICE_ATTR_RW(i2c_bus_ctrl);
+
+/*
+ * cpld_i2c_xfer - sysfs binary I2C passthrough for adva_x1 TAP CPLD.
+ *
+ * write: [addr][write_len][read_len][flags][write_data...]
+ *   flags bit 0: I2C_M_NOSTART on the read segment
+ * read:  [status][read_data...]
+ *   status 0 = success, else positive errno
+ *
+ * Only addresses 0x40 (CPLD) and 0x74 (mux) are permitted.
+ */
+#define TAP_I2C_ALLOWED_ADDRS_NUM  2
+static const u8 tap_i2c_allowed_addrs[TAP_I2C_ALLOWED_ADDRS_NUM] = {
+	0x40, /* CPLD */
+	0x74, /* mux  */
+};
+
+/*
+ * tap_i2c_errno_to_byte - encode a kernel errno as a one-byte status.
+ *
+ * Errnos > 255 (e.g. ENOTSUPP=524) or multiples of 256 would truncate
+ * to a wrong or zero value with a plain (u8) cast.  Map those to EIO.
+ */
+static u8 tap_i2c_errno_to_byte(int err)
+{
+	int val = (err < 0) ? -err : EIO;
+
+	return (val > 0 && val <= 0xFF) ? (u8)val : EIO;
+}
+
+#define TAP_I2C_REQ_HDR_LEN   4
+#define TAP_I2C_MAX_WRITE_LEN 67
+#define TAP_I2C_MAX_READ_LEN  20
+#define TAP_I2C_FLAG_NOSTART  BIT(0)
+
+static ssize_t
+ptp_ocp_cpld_i2c_write(struct file *file, struct kobject *kobj,
+		       const struct bin_attribute *attr,
+		       char *buf, loff_t off, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	const u8 *req = (const u8 *)buf;
+	u8 addr, write_len, read_len, flags;
+	struct i2c_adapter *adap;
+	struct i2c_msg msgs[2];
+	u8 *rdbuf = NULL;
+	int nmsgs, ret, i;
+
+	/* Each write is one atomic request; non-zero offset means a
+	 * mid-buffer pwrite() which would misparse the header.
+	 */
+	if (off != 0)
+		return -EINVAL;
+	if (count < TAP_I2C_REQ_HDR_LEN || count > TAP_I2C_REQ_HDR_LEN + TAP_I2C_MAX_WRITE_LEN)
+		return -EINVAL;
+
+	addr      = req[0];
+	write_len = req[1];
+	read_len  = req[2];
+	flags     = req[3];
+
+	/* Validate */
+	for (i = 0; i < TAP_I2C_ALLOWED_ADDRS_NUM; i++)
+		if (addr == tap_i2c_allowed_addrs[i])
+			break;
+	if (i == TAP_I2C_ALLOWED_ADDRS_NUM)
+		return -EPERM;
+
+	if (write_len > TAP_I2C_MAX_WRITE_LEN)
+		return -EINVAL;
+	if (read_len > TAP_I2C_MAX_READ_LEN)
+		return -EINVAL;
+	if (write_len + TAP_I2C_REQ_HDR_LEN > count)
+		return -EINVAL;
+	if (write_len == 0 && read_len == 0)
+		return -EINVAL;
+	/* I2C_M_NOSTART suppresses the repeated START between write and read
+	 * segments; it has no meaning on a first-and-only message.
+	 */
+	if ((flags & TAP_I2C_FLAG_NOSTART) && write_len == 0)
+		return -EINVAL;
+
+	/* i2c_get_adapter() takes a reference under core_lock; safe against
+	 * concurrent adapter unbind.
+	 */
+	adap = i2c_get_adapter(READ_ONCE(bp->tap_i2c_adap_nr));
+	if (!adap)
+		return -ENODEV;
+
+	nmsgs = 0;
+	if (write_len > 0) {
+		msgs[nmsgs].addr  = addr;
+		msgs[nmsgs].flags = 0;
+		msgs[nmsgs].len   = write_len;
+		msgs[nmsgs].buf   = (u8 *)req + TAP_I2C_REQ_HDR_LEN;
+		nmsgs++;
+	}
+	if (read_len > 0) {
+		u16 rd_flags = I2C_M_RD;
+
+		if (flags & TAP_I2C_FLAG_NOSTART)
+			rd_flags |= I2C_M_NOSTART;
+		msgs[nmsgs].addr  = addr;
+		msgs[nmsgs].flags = rd_flags | I2C_M_DMA_SAFE;
+		msgs[nmsgs].len   = read_len;
+		rdbuf = kzalloc(read_len, GFP_KERNEL);
+		if (!rdbuf) {
+			i2c_put_adapter(adap);
+			return -ENOMEM;
+		}
+		msgs[nmsgs].buf = rdbuf;
+		nmsgs++;
+	}
+
+	/* Serialise transfer+publish so concurrent writers cannot overwrite
+	 * each other's response in tap_i2c_rsp.
+	 */
+	mutex_lock(&bp->tap_i2c_lock);
+	ret = i2c_transfer(adap, msgs, nmsgs);
+	if (ret == nmsgs) {
+		bp->tap_i2c_rsp[0] = 0;
+		if (read_len > 0)
+			memcpy(&bp->tap_i2c_rsp[1], rdbuf, read_len);
+		bp->tap_i2c_rsp_len = 1 + read_len;
+		ret = count;
+	} else {
+		bp->tap_i2c_rsp[0]  = tap_i2c_errno_to_byte(ret);
+		bp->tap_i2c_rsp_len = 1;
+		ret = (ret < 0) ? ret : -EIO;
+	}
+	mutex_unlock(&bp->tap_i2c_lock);
+	kfree(rdbuf);
+	i2c_put_adapter(adap);
+
+	return ret;
+}
+
+static ssize_t
+ptp_ocp_cpld_i2c_read(struct file *file, struct kobject *kobj,
+		      const struct bin_attribute *attr,
+		      char *buf, loff_t off, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	ssize_t ret;
+
+	mutex_lock(&bp->tap_i2c_lock);
+	if (off >= bp->tap_i2c_rsp_len) {
+		ret = 0;
+	} else {
+		ret = min(count, bp->tap_i2c_rsp_len - (size_t)off);
+		memcpy(buf, bp->tap_i2c_rsp + off, ret);
+	}
+	mutex_unlock(&bp->tap_i2c_lock);
+	return ret;
+}
+
+static const struct bin_attribute tap_i2c_bin_attr = {
+	.attr  = { .name = "cpld_i2c_xfer", .mode = 0600 },
+	.write = ptp_ocp_cpld_i2c_write,
+	.read  = ptp_ocp_cpld_i2c_read,
+};
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
@@ -4272,11 +4477,18 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_i2c_bus_ctrl.attr,
+	NULL,
+};
+
+static const struct bin_attribute *const bin_adva_x1_timecard_attrs[] = {
+	&tap_i2c_bin_attr,
 	NULL,
 };
 
 static const struct attribute_group adva_timecard_x1_group = {
-	.attrs = adva_timecard_x1_attrs,
+	.attrs     = adva_timecard_x1_attrs,
+	.bin_attrs = bin_adva_x1_timecard_attrs,
 };
 
 static const struct ocp_attr_group adva_timecard_x1_groups[] = {
@@ -4902,6 +5114,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	mutex_destroy(&bp->tap_i2c_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5078,6 +5291,17 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto out_disable;
 
+	/* Must be before the first error path that calls ptp_ocp_detach(),
+	 * so mutex_destroy() always runs on an initialised mutex.
+	 * Must also be before ptp_ocp_register_resources(): the I2C bus
+	 * notifier (ptp_ocp_i2c_notifier_call) fires when the adapter
+	 * registers and stores the adapter number in tap_i2c_adap_nr; the
+	 * -1 sentinel below must already be written so that a notifier
+	 * firing during registration is never overwritten by this init.
+	 */
+	mutex_init(&bp->tap_i2c_lock);
+	bp->tap_i2c_adap_nr = -1;
+
 	INIT_DELAYED_WORK(&bp->sync_work, ptp_ocp_sync_work);
 
 	/* compat mode.
@@ -5217,11 +5441,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+	if (add) {
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		/* Cache adapter number; cpld_i2c_xfer uses i2c_get_adapter()
+		 * for a reference-counted, unbind-safe lookup.
+		 */
+		WRITE_ONCE(bp->tap_i2c_adap_nr, i2c_verify_adapter(child)->nr);
+	} else {
+		WRITE_ONCE(bp->tap_i2c_adap_nr, -1);	/* invalidate before free */
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
-
+	}
 	return 0;
 }
 
-- 
2.47.0

