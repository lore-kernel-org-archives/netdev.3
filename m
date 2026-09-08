Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433E5908D8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908271; cv=none; b=auF3948sAJkXgjoRSBllZ6ijTn0gm5HG4xYGbRpDPYuTZeklPkxm7wjVKxjrWgFTRw9oqzuLjUGVC77uzmLfLSy6J7bPnzwxus2btY/WFTM1jDLwHZkGw/In8I+tsY4lidOYjj/km7NzmR0RVvOYeMAKuxd+0W1+zYdbR+7+QFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908271; c=relaxed/simple;
	bh=DQmWpiiP+cD4WOs/XMACwGLUuwq7F0q+Wq6Ld9uy2Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ3Ke2wpPCguzS9tI7X9Qvln32SyggDvfjF+a2+OplpPHUv5NGP5TQ10DWcZE4Nc+4AzTpa0pQwZSJjjfOTLVjqtLvPPGRNBY22QbUk8DEGStVhDMePf2ryeVRzeJZYHIuereUBT5rNVV07kEHVN+A5D9h4GViZvlWdOikSz6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmpF6IUC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmpF6IUC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3964e480f76so5996307a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908265; x=1789513065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wumeOXgAu9H0Kp97qaCmHzt/GpEB2ltmfWp7a6Ii+u8=;
        b=mmpF6IUCM7VAx/+T0HKOxspCt5wTL6l3DBH1qE0kFMamRLzsk1/q1FZ7WazcbNfllG
         9ujr5jSZAeclJVXXgd9btNs/9DDa0sDGcnp52koT+04HQAIeYZrFSJDbCV2kZ+NZeh+z
         9mMEiXmviEO3YQ/qPCl4/g4ZeFiXvY3f52+NFAnyn4zu+Kojd/Pk/SXoaJp+rYKuLhAO
         4WBVveJglt203np0sidV/zQCS9VGqskgNlx5v6/ecoxlGPDoNC+b2HYcZlUoLZyBzFvK
         8XyUR9U9biWQrbdQlfyGr9SZnoBBjyDBuDg0UUTjzY6a1IJFrg2GZmyVDgrepMv+JNYM
         P16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908265; x=1789513065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wumeOXgAu9H0Kp97qaCmHzt/GpEB2ltmfWp7a6Ii+u8=;
        b=ThiTyXLKItZc8XEnAMSWWi/Xb+dOwVBdqBhjYeYP+0h8me5OtFpawyBaErl0YxjiYl
         WrymY16hFjweS0z8+Hv/rJJLHQmditIFMOKvR5wSzjyS/8xOjlNznbqfNUwYSAJ+I3G6
         P7VT4smHWKd8orsoPbtbzCHz3A2TKLf3WZtVKd4qtkLE8g55pFofcEDl25XXx/VfGZQg
         iDhF3HOHcKOyYcvqPK2aDYRxrjYOWuYjSHcvFwFk5XSl9IlqxX0AA/VB7dM/YQDx25LS
         qZEUPaFZPPDkjZuEcUQ+ahhuGcNfdsaCIbT82qlc48edZjLg64PSUFoN5T/wtz1BLu50
         V3ng==
X-Forwarded-Encrypted: i=1; AKwUvByIUZX4N0hh0aid9RHxYUirn3aLkwD/kjVrc2p5Utjf7EFu6PKMhb4irVngUeXZ2nex9rX1XyY=@vger.kernel.org
X-Gm-Message-State: AFuF++nEqPhiLDhiEM+reNdnc/rToZ0eMtZnAojeWb64F43QH/PNi93u
	Oze+Lir2zcPTvJqLJnBqTUjyHOrKTqgKnhCKRe7uoRpmSL/p6iM7iTOm
X-Gm-Gg: AYBFou04gxywWz91hJVSzrMES8D0vpQ8r0xtCJdlsorL81xhhS1sO+7wnG/Bi+BYtbr
	RsXUNUDdDGJYv2Z04g8X3Jl8iQBbOeYUQuYiGkHzXezzUz7iU4dyF0jLE59oYnxkflSf/3yTiuP
	T47LSQGcdX8TlU/PrJUW9arvlwuJajmJWsYSIoHzYduKaCvHGCoECcI+vZbJHXTFUJMR8R6irMI
	UzAHDZ41a1IzBCD1Alp+XVZATsz3HEN/hYnWq7MpvxtvpMKDsipTQvjs6QxgQBJz1/D5aCRf8Ls
	8VNncPrZ5wSvx33l/iWoahMRktUoDkUJF8UkkNIygLt0kkJfCns8a2k/TU0+P+N3m2lSG+GAeh8
	3HaFVjLpx0GboAvv6Dj4//bnFI/pAsgAhJE4CRHwwwKyoW7FSDwSNEJcbv42DFa2RZr0vn6G8d+
	BeR9eHPt/RNNfVF3+BcRt+2wnqEaYz6MRJosBetFw9oGL10CbM5Vv9RPqqieq8RvYoM5oG3Wh/3
	9sq3w==
X-Received: by 2002:a17:90b:274e:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39b2610fe62mr47435731a91.9.1788908264615;
        Tue, 08 Sep 2026 15:57:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:91c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm45266746eec.7.2026.09.08.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:57:44 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v3 3/6] eth: fbnic: cache hwmon sensor readings
Date: Tue,  8 Sep 2026 15:57:34 -0700
Message-ID: <20260908225737.3034403-4-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908225737.3034403-1-limzhineng2@gmail.com>
References: <20260908225737.3034403-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each hwmon attribute access triggers its own TSENE firmware mailbox
round-trip, so reading the full set of attributes or polling them at a
high rate floods the firmware mailbox with quick, successive IPC messages
for data that barely changes between ticks.

Cache the last temperature and voltage reading and serve reads from it
for the remainder of the current jiffy. A single TSENE response carries
both readings, so one transaction on a miss refreshes both and satisfies
a whole batch of reads. The cache is seeded with the FBNIC_SENSOR_NO_DATA
sentinel at registration so the first read always refreshes, and
concurrent reads are serialized by the hwmon core so no additional
locking is required.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  7 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  7 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 35 +++++++++++++------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index d0715695c43e..f647ef07704b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -22,11 +22,18 @@ struct fbnic_napi_vector;
 #define FBNIC_MAX_NAPI_VECTORS		128u
 #define FBNIC_MBX_CMPL_SLOTS		4

+struct fbnic_hwmon_cache {
+	unsigned long last_read;
+	s32 temp_mdeg;
+	s32 volt_mv;
+};
+
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
 	struct dentry *dbg_fbd;
 	struct device *hwmon;
+	struct fbnic_hwmon_cache hwmon_cache;
 	struct devlink_health_reporter *fw_reporter;
 	struct devlink_health_reporter *otp_reporter;

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index d84723e4cfa3..42a5f83ddb45 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -6,6 +6,7 @@

 #include <linux/completion.h>
 #include <linux/if_ether.h>
+#include <linux/limits.h>
 #include <linux/types.h>

 struct fbnic_dev;
@@ -44,6 +45,12 @@ struct fbnic_fw_ver {
 	char commit[FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE];
 };

+/* Sentinel for a sensor value the driver does not have: a threshold the
+ * firmware never populated (older firmware) or a cache entry not yet
+ * refreshed.
+ */
+#define FBNIC_SENSOR_NO_DATA			S32_MIN
+
 struct fbnic_fw_cap {
 	struct {
 		struct fbnic_fw_ver mgmt, bootloader;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index 38bb26cb8e6c..c8e7ff1d36fc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */

 #include <linux/hwmon.h>
+#include <linux/jiffies.h>

 #include "fbnic.h"
 #include "fbnic_mac.h"
@@ -25,26 +26,31 @@ static umode_t fbnic_hwmon_is_visible(const void *drvdata,

 static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
 {
+	struct fbnic_hwmon_cache *cache = &fbd->hwmon_cache;
 	struct fbnic_fw_completion *fw_cmpl;
 	int err = 0;
-	s32 *sensor;
-
-	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
-	if (!fw_cmpl)
-		return -ENOMEM;
+	s32 *cached;

 	switch (id) {
 	case FBNIC_SENSOR_TEMP:
-		sensor = &fw_cmpl->u.tsene.millidegrees;
+		cached = &cache->temp_mdeg;
 		break;
 	case FBNIC_SENSOR_VOLTAGE:
-		sensor = &fw_cmpl->u.tsene.millivolts;
+		cached = &cache->volt_mv;
 		break;
 	default:
-		err = -EINVAL;
-		goto exit_free;
+		return -EINVAL;
+	}
+
+	if (*cached != FBNIC_SENSOR_NO_DATA && cache->last_read == jiffies) {
+		*val = *cached;
+		return 0;
 	}

+	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
 	err = fbnic_fw_xmit_tsene_read_msg(fbd, fw_cmpl);
 	if (err) {
 		dev_err(fbd->dev,
@@ -67,7 +73,12 @@ static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
 		goto exit_cleanup;
 	}

-	*val = *sensor;
+	/* FW returns both readings in one response, cache both. */
+	cache->temp_mdeg = fw_cmpl->u.tsene.millidegrees;
+	cache->volt_mv = fw_cmpl->u.tsene.millivolts;
+	cache->last_read = jiffies;
+
+	*val = *cached;
 exit_cleanup:
 	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
 exit_free:
@@ -107,6 +118,10 @@ void fbnic_hwmon_register(struct fbnic_dev *fbd)
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return;

+	/* Seed cache with sentinel so the first read always refreshes. */
+	fbd->hwmon_cache.temp_mdeg = FBNIC_SENSOR_NO_DATA;
+	fbd->hwmon_cache.volt_mv = FBNIC_SENSOR_NO_DATA;
+
 	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
 						     fbd, &fbnic_chip_info,
 						     NULL);
--
2.53.0-Meta
