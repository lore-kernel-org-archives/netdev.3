Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB241F03DE
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394691; cv=none; b=UbPrCQZ0iGi5ROJmfxQiL+eQHecPPnk536c2p7oCcOkYkzT3BRb2mEP7rLJedXL3E5W9xpqS9FlgCRvsFUkhGtaLnELD0lmiPcuuSMdZkMItNggsauF13mG9xWaXFw6QURQHIjrBFVBHvqXsmWdtKSlLQgu3ACG3LyUTV7+m0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394691; c=relaxed/simple;
	bh=Ex7erFjUDpTsPuMOKQVYgdeHOyyE2YN4tnCwknhBoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IErX1RdeDpzhaAsR/bXRYo3WW+q98VIpDcnqDNgZGdlCy+5dTPmFPJ6ZK8knLRzp8uMPl5FCy765aeUgBriCKUihwntUn++EN5WW9T2uvZQgajjx5GNUzgBrKPswzgSytwVCv241dGcRCyDpH+WYw0yEktXLjOMAYe9jI5Tyy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6Wq4qem; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Wq4qem"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c0c41ff84a6so523048866b.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394688; x=1782999488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7IDrRLRfXNyENWJG/sjHARRt2tpXE2WSwlwStmm+qw=;
        b=c6Wq4qemiLAswbRSdBNaxhNYbj8U8H2jSuEOOt0x6uyXroDvdA/j8csDxOIX4yOBY3
         X9pMwo7EY6TiIS5V6PCfpnyiTcnBZX5qECD+wtuAiHFA0TjKq7jtTB+YKUGAV0LuxlLw
         tjX8tHRPsraBVvf5hI5tCNKysYlv/Ct2FC6vRHwPgoB03Vh2p1X6KyIk5X+aHqvU9J/L
         hptqylFS9GDZLmIbksAL44uGFOqQj2Jdki/tUinivvhzRab75yOVr4N6751zCIC8loFX
         zlovD+UAgteWlPy5mSI78tb6qd/k8PPvydjDrZAtKME5bOUCNSt49ElaKp+6EEOk7Aan
         Oa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394688; x=1782999488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7IDrRLRfXNyENWJG/sjHARRt2tpXE2WSwlwStmm+qw=;
        b=LGdioH1AZHNrj9VlCs6YIMkx4f4NtjpiIJyY72gjXyusd2raU0ZiSLjtvktbYKR4Vx
         sS7BFCVbHcaTJngMdIX9inUtTADD/xIJ02zegN5Tuo99PMx+NifvxdSzjedZoj5hRZka
         e1SmoMYzBgz1YDhEKUE2C/RfpUJcd9VYm1IcHMZnvBxT8M7ZXHNYprSf1Gj4Y6HAk4K2
         HnUKA94FMhOgOazuD5Wcsjq/5kRp52iHmuQA/ZijxsXzL6vVAwhSVBOU9Ke8H6fJyLlK
         8pHZMbVZ56tLiMZQrMpv9gXJfXx1+BlU1iNwoKm5PDanOea398CdGvpcH20YW8O/jBRW
         sPnw==
X-Forwarded-Encrypted: i=1; AHgh+RpeWxWHrbBf7/LXr0XrOkxLCFkmCUj38xluChz3ntF8BZEB740WHG/sEkwNXaM2bH6F2m7sM1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFqwNy+7rmu9SlGQnBlj+LZTrMDbVR14dKM2IfmJIJEuai9kJ
	UKWRnn6D6MuNLVvQtZ4qDbZg1ay/uTOSKK8b2AGy2QzbtLXtR2gIFMnz
X-Gm-Gg: AfdE7ck75J8Kg4KbiUY1wPz8O8W6immig5uJZmcT2sPxIxdLUTGUoI4gyDttVjzeBKz
	Ht0smfjOEtWhW+T34mBAmvZ1B1a93b4iGqW0AMytPwfGfuTEJ2cacp3Xe/ZeKcP2+bvqEn/QdoO
	EyZPJF/BhWqFbH7dWfI8M4QKmaF6+SqNv2Bw6MPbaXX3PhvDRYoYkvOLXGZKEPuLKBFChRDKVYl
	cTo3q6FihMwGivQ4+MRQLMFD+tNronafzJVao06yyC7pQgQlG3/d+dAOsB3b5QOisU60KwBkJa/
	vxPjLu4IZ3AaMOIt4ZMfGGbQcmHz32pBDZT2KCZKqut+kV8ODWXlzOHkChyeEkk/z10qVrSxUEv
	B5ZivwA07EzYLAgmor3VK9BKWli7lZUySpq6SSt7sN2SPVx87CI4yvLzLmvjGBz08LkvkIQ4Q8O
	INqfTMdroFx2w6OzOYs+Zzq5iAV5exfoi5NiHmeZl+Kh5/qdfC5Q==
X-Received: by 2002:a17:907:9711:b0:c11:40ff:5f79 with SMTP id a640c23a62f3a-c1205eef009mr166988866b.37.1782394687939;
        Thu, 25 Jun 2026 06:38:07 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c120dcc55besm73748966b.44.2026.06.25.06.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:38:07 -0700 (PDT)
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
Subject: [PATCH v1 1/1] ocp: Add I2C control support for Adva TimeCard
Date: Thu, 25 Jun 2026 16:38:02 +0300
Message-ID: <20260625133802.11741-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Load i2c-dev module to expose /dev/i2c-N character devices
- Add sysfs-based I2C bus control for Adva TimeCard model

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
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

