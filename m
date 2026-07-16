Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37441B8E2
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208588; cv=none; b=Zxob9jmbBIJd/a0JGx+wofVthKbjczWhQ0MowV0OjICir8avJJrNI2yTESmTzhc99VYnS4A+zEIBPwYiw1/NzKog9FtchDqO/LqwVSQ/vI1NB0SsRs1hz/6vLHSO/BldCfePiCU3A/H+GfM8gAZHU8++mk8S/d6RYkNSjfVRVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208588; c=relaxed/simple;
	bh=GvhOhUCPReF8T0/1rhRsDmC4FfEtf13alJ4j8uiE6SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvYQFwtEJRQelas4b2vZu37OZ0yvOukSnd4L+NOnMdXivxFReFJsOgAQKN9q2f+R5RPxLcJnnjbWgzKH3V2DM9OySfenDeEGXRGDBTxrj+MNDnZViDC2bQBkA+OvyMhoktnkr+rtmnzOfUnegXYmhrX3QH7HeNseh4pKtYR3oNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxw3UPkT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxw3UPkT"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4720d22c94aso3628668f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208584; x=1784813384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3NsuUXbXPRzu8lnWh9WBCJujxSz9iHZDWRsKU+rD0s=;
        b=kxw3UPkTWNiYEwgkdLxzt7Wer5/EfAFQ1GLqOyEyIvIUC/f22qT3jtLChn1NwDRLVJ
         oiyFOICEHciuusNMtOA5Su9POll8Q7YUo8HkBbJdBjK1cC6PuKrHdMFV+ANZ2Wgj28Xw
         K+LHBW4PHaqnnzD/US9Y1szmSoIPx0hoVG03WhessmvYuanYnsb3gXY3mbrY8iRLf/8G
         tQPFFc0SU+hO2WuMFF8cmR+dyxmK+U4cZUJxqdNyboQ7DTPpA5jxnhvEGUVYzaF9z9bM
         zDY8ReqB0G9EE2iItGpeU4BSb4xV1UOKCtgoJkmx2mQOydE7fPJu3YGJ8gimvY+RzJQW
         bVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208584; x=1784813384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3NsuUXbXPRzu8lnWh9WBCJujxSz9iHZDWRsKU+rD0s=;
        b=S4KVvosiW6akrN806Q+xfR6EKwW0h4IV4Knm7lTHQfuanxmV92ag5LBNnMatRKxFXF
         MzmAx2too3aTlEkRnKqt2GLEIX47xsUojPN4FsD/l5fFcQ+vN00azITQtZmETmMlwOc2
         NXf3aR8yEG7XBh6CpmXp81ItICisFenWYs5AQEZJi2zs62OeiPlCDO9+KSnGIie199bc
         14eKUxj2VeS2Gh6+oZXDqn74ze7CXHJWZARG4Ho6LkREgKeANAcYNlpUgrS6TSnVMSdn
         IURGTtGjI5vSqlCm7MtIRM6v3TZMl8TzCQP8jwCvZ0VESk29F+h9qV64L20+qmq/CD71
         rcsA==
X-Forwarded-Encrypted: i=1; AHgh+Rrh/tucXUH65wxnSLnL6cjq/AS94gG3FiI0fHE2TgW3vaxOy8VqekQ3MkOiKZKAhUBvWlRCuqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZZVI9j9ceU940oVDSXEMgsm6g5iF5/9ei2C9CKWJZYridoYq
	R4JCRhZ+L8KLD1U4/v4thqJKNe+bUBOkUX7bFIgysrrwcjhVSJt0Hdo9
X-Gm-Gg: AfdE7clXAdGDDRFdCUf2ChQaLhie9dbK7oTjtiL68a0FOhWHv+OJ7+EEpYDcuGgqJtT
	nBD65sT4nZCpuQK+GIePfSioStazN/fLcwlHr8QQoB6qs64bcHpn8J8AfT/6mbSJEIlNGYMKMu/
	nY7U/+2B4ffBBeiKDLH6dpFlO9Gdxul2tuBkLpxKqiekuhoKAczmxTmHSYqdL/MLx96zrV44B4R
	IwH0uyfWAunPzrhQkz58/+aIA9Puj+90p14/HIqfFvKNv4dq+3JF8gRuIfVodb/ksUzpaHkrMpi
	bSxWg3AEDY90AInhK1DsL3VgEsICtjatJNLCSxZUFAefBBEWIiblz2L9PmawUPv9crwiaO7d3yk
	6xmXeX0JVRkgy/uWCKWlT8OgT7BQdq9oeXLmctFwgNGKQPgKr8v8082nXHsv1hd+gEXp+2evYR1
	/g2iiqF+VhOck8u1Puql1YxOTnPjFGn3NES1qeMVsmGgQUHRjhTg==
X-Received: by 2002:a05:6000:46c7:b0:47f:4ccf:1396 with SMTP id ffacd0b85a97d-47f4ccf15f4mr7555275f8f.14.1784208583678;
        Thu, 16 Jul 2026 06:29:43 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e5c3sm23909928f8f.1.2026.07.16.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:29:43 -0700 (PDT)
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
Subject: [PATCH v5 1/1] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Thu, 16 Jul 2026 16:29:39 +0300
Message-ID: <20260716132939.5377-1-maimon.sagi@gmail.com>
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
  - Simon Horman : https://lore.kernel.org/all/20260715111559.1920391-1-horms@kernel.org/
 
 Changes since v4:
  - Move mutex_init(&bp->tap_i2c_lock) and bp->tap_i2c_adap_nr = -1 to
  ptp_ocp_probe() before ptp_ocp_register_resources(). On adva_x1, the
  I2C resource is registered before board_init runs; if xiic-i2c probes
  synchronously the notifier writes tap_i2c_adap_nr, which board_init
  then clobbers with -1, breaking cpld_i2c_xfer permanently.

  - Drop the if (tap_i2c_adap_nr != 0) guard in ptp_ocp_detach(). The
  notifier has no variant filter so non-x1 boards can leave adap_nr != 0,
  triggering mutex_destroy on an uninitialised mutex. Also, nr=0 is a
  valid adapter number. Since mutex_init is now unconditional, so is
  mutex_destroy.

  - Fix bounce-buffer leak in ptp_ocp_cpld_i2c_write(). Assigning
  msg->buf = i2c_get_dma_safe_msg_buf() makes buf == msg->buf, so
  i2c_put_dma_safe_msg_buf() returns without kfree() on every call.
  Replace with kzalloc()/kfree() and set I2C_M_DMA_SAFE. 
 
 drivers/ptp/ptp_ocp.c | 236 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78..91fa06f0e44c 100644
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
 
@@ -5093,6 +5306,14 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bp->n_irqs = err;
 	pci_set_master(pdev);
 
+	/* Initialise before ptp_ocp_register_resources() so that the I2C bus
+	 * notifier (ptp_ocp_i2c_notifier_call) cannot fire and write
+	 * tap_i2c_adap_nr before ptp_ocp_adva_board_init() overwrites it
+	 * with -1, leaving the adapter number lost for the device lifetime.
+	 */
+	mutex_init(&bp->tap_i2c_lock);
+	bp->tap_i2c_adap_nr = -1;
+
 	err = ptp_ocp_register_resources(bp, id->driver_data);
 	if (err)
 		goto out;
@@ -5217,11 +5438,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
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

