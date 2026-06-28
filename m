Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491A26C3BD
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782625127; cv=none; b=imYMuR8hGcvqgNcnYnKqxRIc6CK4S2AQsAhd1mMkiSKAWRtOE+4cU0eScAUwG133m3u0vfW92vwxDM4YjRdTP/eTBv+9x0FwZES2nY+AFt2/7edFkH0Y9NzJEVEM0xpATZnG1zJgySsQH/z1e0VIRJ7QlizovQ6p5Tgp6lHaUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782625127; c=relaxed/simple;
	bh=9X4NR4faCoAw8gAB6DE6MXzAJt7E9V1scWMVnpmHSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBnHORgyG46qTV1ngKo/2lOn4AfLZH33ac3XXtYX2eAL/3H/lwSr1wPcQRB/iDA5Xr7S9Qm7+cJfNM1HF4GkqlHrcYvDuXiuVUat3xjaYf5c6Cgu9HlofMeprs6JhiL7zitawrrv4Jw/c4CVcivxNXEi74MJ0bqt6VY3Kxpe8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKMB1B5j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKMB1B5j"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a97fad2fso1033275e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782625124; x=1783229924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnnBkviPIVGVSUUeDRaGIGK1tCYZppMxJfO/BcaDKK4=;
        b=SKMB1B5jQIOPU8jwNaIqkPcFJH2XCkdwGE8jdwvvcSCv+sPRQVpHPKKSXU+mNCYsUf
         A1sRkQgO9vAka36P9b2nxseyGW8nYSH8flgaJpo/GC0mnoOeGjy4knW8RL07odVx7TjZ
         20Aa7HXMJYW34M5drLv1oceIPL7vCh/Ej7hTAEPP0N73FD73v5np+q6/XA7ddreYxsxq
         jGcBAMl9Qweu1TZRMBsZHs+fHmexAE3X7Iu3ZeP7HKiy2SlsIoIOULLZesDMBZ7ZM48f
         2gPtg/TaVYK3pln83oZwZioi2Gj78H4eyBs/H3o1ZgvJs8BpaU4pl1URlMGXjUmsMY07
         anFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782625124; x=1783229924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnnBkviPIVGVSUUeDRaGIGK1tCYZppMxJfO/BcaDKK4=;
        b=j0yXvNfAye75in8dI04eE5ttwtgmSbC0CIk8qWx89+WjjhU4/JD5t+xYcfL2nWCCzj
         I021wYFmIRtkm9H1IPG12Bh+EJzrdHJVcFTl4aWQOEOKa/EZvKk86yG+pD9AOtfJyMBE
         ukdZcAmiMgb2xV/inxqlOOz47nkcV9DiIBRVCZ71oDbQpHT0+7Zy/cP8GKTAL2irj84U
         LD/k+KzePv7iBfiagFdYc3K2hsi944f3cdc+FXIXE41T3LobpxSzZQIW7OcA9QEDrXaV
         UrR/LPnaZqOhfrAHBgx862EEvAEXSycJ+xvFnIvGVn5QNdCrFspBKGluuxqTyOyPmwge
         ziCw==
X-Forwarded-Encrypted: i=1; AFNElJ9gizjcVKJtLzcggTIFNPUp9k1Fip+9pqavMt1NgeGKutSkok2bpG85Nm11yYHa7cotxgfVtl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Fu+/h4rPZLBLlGeo6dIhilfxsK+fin7e/agOdm3zPOQwYPWd
	+YDaX1mnNJYn3swtgZ+Gpseiy6OIi3q7SgLArO6zjEgwwgWyfEbTzlnN
X-Gm-Gg: AfdE7cnCVnZbuyJxyAEshp+z9L41KkvSbH7fK6Xw9ETbUr4fmP3H2YeDjG1oDL6GMqW
	rKoIYV2CcT0gvviYOsyEUuTtlR+jcyAtoVbK2cgzxBfzjO59VMxp3oTMZhB5II0NpUmOL8QsuqF
	6goKi0HLuzHqIERRUeyic7mNBSfkq5ALHDVAzNvRENekMkTaNm5mmmn/aNZR0kRWFS053/fDknu
	pmkKE5Zc4O1RAgFZcPZyVrBfw8nAXxUn+/ETzhfrvLqcHgIgx+gVzoD85maUoY8fsEodMIGRRhP
	q8cROq9KK5EW51phcCD3SUL08q01w4Fcr+QwQfAJtvgqj3IAQmVTyoYPQvgvJJKwPqW5ExuwsfT
	C90hqXs4j/jOZOFWqcKRW58fP9tzzegylcPnGOu2dL+4c3nydTy3KKp2BYK3w2ET+7pfywIi7EO
	LV34YdgpPD6Du4CB0x9NYHyugsVVnJ+i73NDHbmdbYh83m9m4+GQ==
X-Received: by 2002:a05:600c:3b24:b0:492:3fcb:22fe with SMTP id 5b1f17b1804b1-492668551dbmr198217305e9.1.1782625124333;
        Sat, 27 Jun 2026 22:38:44 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47327c47122sm1059843f8f.34.2026.06.27.22.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:38:44 -0700 (PDT)
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
Subject: [PATCH v2] ptp: ocp: add I2C ISP support for ADVA TimeCard CPLD
Date: Sun, 28 Jun 2026 08:38:40 +0300
Message-ID: <20260628053840.4305-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard programs its on-board CPLD (Lattice MachXO3)
via I2C using in-system programming (ISP).

The CPLD resides on a secondary I2C bus controlled by the
embedded MicroBlaze. To allow programming, the driver must
take ownership of this bus and expose it to userspace.

Add support to:
  - enable the i2c-dev interface to expose /dev/i2c-N
  - provide sysfs control over the secondary I2C bus

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Address comments from:
  - Andrew Lunn: https://www.spinics.net/lists/netdev/msg1200997.html

 Changes since v1:
  - Add reasoning to the commit message
 
 
 drivers/ptp/ptp_ocp.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78..1b4ccb4feca5 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4224,6 +4224,34 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+static ssize_t
+i2c_bus_ctrl_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+
+	if (!bp->pps_select)
+		return -ENODEV;
+	return sysfs_emit(buf, "0x%08x\n",
+			  ioread32(&bp->pps_select->__pad1));
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
+	iowrite32(val, &bp->pps_select->__pad1);
+	return count;
+}
+
+static DEVICE_ATTR_RW(i2c_bus_ctrl);
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
@@ -4272,6 +4300,7 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_i2c_bus_ctrl.attr,
 	NULL,
 };
 
@@ -5235,6 +5264,7 @@ ptp_ocp_init(void)
 	const char *what;
 	int err;
 
+	request_module("i2c-dev");
 	ptp_ocp_debugfs_init();
 
 	what = "timecard class";
-- 
2.47.0

