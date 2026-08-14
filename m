Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCC3BCD3C
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721588; cv=none; b=cqajBOrFwlahPIRJenBBbKAHoPMOibno9bfT+NJEuIJc9KgXjWcr431qX6g6fMEh89ynvkbI82L2Or89K/rbujAsR3knWioRXYEk2iFJ+5Lb9o/pxGi8JGU8kYgxlRtrC24HaM5/nShhp6GQKTxzTMBXBZn355b3LsYUBsWBs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721588; c=relaxed/simple;
	bh=l6ZVF6Xg5OfhCSgAF1VZK6EQ6CumsxwL38iwWWa4I1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzauuegMIJy9LyjPuxq7swQ+pBtIRx19KWuXwNe7vprLGR5uFriMN7gEME27Kd7nQ7pp+XKE91maW4ncPyvrlmnzFCtxUAdw+Uyu5Qtfv84Mfeb0NNzB15exr1IJiHQ1Gw/qVQGvc2ZPvA8NYl3fZK4iEcNAuVFRUuBuvlK00+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H23r9Hny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H23r9Hny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786721586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ssDOB7cblcv2badYSas4RkixSUJbeVmGWSrOHTtHIGw=;
	b=H23r9Hny+zNzNaUhjPeO2STNvzuUEsLl0BTlTtnxfAGxCyUzB0FGyamuzBx5GsvYkX6L1Y
	caSi3RMtzYQjvvwYNM7yUwaSzQXzvaEzjG4ky7BnGC+HKNd5PbrSVeYeDCy5Av+5tyon25
	CacaY5aWkeFFbB30eP0lJLPECNOuZUs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-R8Tk7Ev2Nym8VsWypDwZvA-1; Fri,
 14 Aug 2026 11:32:59 -0400
X-MC-Unique: R8Tk7Ev2Nym8VsWypDwZvA-1
X-Mimecast-MFC-AGG-ID: R8Tk7Ev2Nym8VsWypDwZvA_1786721578
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9110195605E;
	Fri, 14 Aug 2026 15:32:57 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6798030001A2;
	Fri, 14 Aug 2026 15:32:55 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vincent Jardin <vjardin@free.fr>,
	Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] dpll: zl3073x: add chip-specific minimum input reference frequency
Date: Fri, 14 Aug 2026 17:32:52 +0200
Message-ID: <20260814153253.900280-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit 24e4aff8983fe6 ("dpll: zl3073x: recognize the ZL30643 chip ID
(0x0E3B)") added support for the ZL30643, a ZL3064x line-card variant
that is register-compatible with ZL3073x. However, ZL3064x chips
require a minimum input reference frequency of 1 kHz, not 1 Hz like
other ZL3073x parts.

Add a min_ref_freq field to zl3073x_chip_info and validate it in both
the DT property parser and the ref-sync pair configuration to prevent
configuring unsupported frequencies on ZL3064x parts.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 43 +++++++++++++++++++------------------
 drivers/dpll/zl3073x/core.h |  2 ++
 drivers/dpll/zl3073x/dpll.c | 10 +++++----
 drivers/dpll/zl3073x/prop.c | 10 ++++++---
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 5b2d77f2c2288e..c0b3b0d579d524 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -20,29 +20,30 @@
 #include "dpll.h"
 #include "regs.h"
 
-#define ZL_CHIP_INFO(_id, _nchannels, _flags)				\
-	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags) }
+#define ZL_CHIP_INFO(_id, _nchannels, _flags, _min_freq)		\
+	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags),	\
+	  .min_ref_freq = (_min_freq) }
 
 static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
-	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x0E94, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP),
-	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32, 1000),
+	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x0E94, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32, 1),
+	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP, 1),
+	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP, 1),
 };
 
 #define ZL_RANGE_OFFSET		0x80
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 78dc208f3eea2a..51014463377356 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -42,11 +42,13 @@ enum zl3073x_flags {
  * @id: chip ID
  * @num_channels: number of DPLL channels supported by this variant
  * @flags: chip variant flags
+ * @min_ref_freq: minimum input reference frequency in Hz
  */
 struct zl3073x_chip_info {
 	u16		id;
 	u8		num_channels;
 	unsigned long	flags;
+	u32		min_ref_freq;
 };
 
 /**
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 83bd3027dbaa1e..ee077c3e68da83 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -281,7 +281,8 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 		sync_freq = zl3073x_ref_freq_get(sync_ref);
 
 		/* Sync signal must be 8 kHz or less and clock reference
-		 * must be 1 kHz or more and higher than the sync signal.
+		 * must meet the chip's minimum frequency requirement and be
+		 * higher than the sync signal.
 		 */
 		if (sync_freq > 8000) {
 			NL_SET_ERR_MSG(extack,
@@ -289,9 +290,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 			rc = -EINVAL;
 			goto unlock;
 		}
-		if (ref_freq < 1000) {
-			NL_SET_ERR_MSG(extack,
-				       "clock frequency must be 1 kHz or more");
+		if (ref_freq < zldev->info->min_ref_freq) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "clock frequency must be %u Hz or more",
+					   zldev->info->min_ref_freq);
 			rc = -EINVAL;
 			goto unlock;
 		}
diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978ef..cdceddcf353e46 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -20,9 +20,9 @@
  * @freq: frequency to check
  *
  * The function checks the given frequency is valid for the device. For input
- * pins it checks that the frequency can be factorized using supported base
- * frequencies. For output pins it checks that the frequency divides connected
- * synth frequency without remainder.
+ * pins it checks that the frequency is above the chip's minimum and can be
+ * factorized using supported base frequencies. For output pins it checks that
+ * the frequency divides connected synth frequency without remainder.
  *
  * Return: true if the frequency is valid, false if not.
  */
@@ -36,6 +36,10 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
 		int rc;
 
+		/* Check minimum frequency */
+		if (freq < zldev->info->min_ref_freq)
+			goto err_inv_freq;
+
 		/* Check if the frequency can be factorized */
 		rc = zl3073x_ref_freq_factorize(freq, NULL, NULL);
 		if (rc)

base-commit: 4f93b12cf7b25fbf8e73d222722805b049f0a6d3
-- 
2.54.0

