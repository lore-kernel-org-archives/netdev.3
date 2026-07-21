Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B845A2B4
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672152; cv=none; b=iBjk0yTcibDIj/czh1yWC1DEmTltGsaJQppoaQEqTN3TJmCEXFjwz/axTY5hBNC4Sfpbamyp/Ek2d9w+jqPN1R687yJRYGlBH5nwi+b6WzIeaWKp4ylqe2xqQsk+LqZoXNJdhCjLB6Pudy+0cOT4lV9DnL810m6t0yk0H7JWQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672152; c=relaxed/simple;
	bh=F4Vn7w9he8XvFaQgePxC49jos8Ircb4h09eWzonsEE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9KY5HFXsV95um9rPVIMthC4UdVN1iMoBfByvbX14+SfNF9Ncv5ajB2D/fC8V+5kANOMiIxI4h0jeeXuWp+CKQzb1AQS+oxjlwyTgnG+li6/RIiYdu4lHTU/vUVlH22+roXDS+MqN18G2ko7O5zdHDN/jvATfhZNyxBoXR8zvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbDS7aiE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbDS7aiE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso125773395ad.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672150; x=1785276950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4WjCM0YGYpG6uGbEGVqjVtxdg84mLbv5nOzooF+Ac4=;
        b=jbDS7aiEvLFmrZPbHaLgJIPNEoh5w9pEoexnqQxCgsYOJYHkDrF2gTjNMNjOLzGH47
         Yb04K8JDLETYNB6idSMNa/GFFJUO8RpFzjhSJMki+i3W2C13opy3z7QrLfVh9ZsJ2mw7
         +rRFNijTvNEizn+Mn71cVjYGul8M0W5LxwHI4rdgVZMd164XIyOST/8Zkeh4RhqEYkZv
         wrjNVHJ9NRs9uJS6Yet3IHiX2SSknIkUKUEdnigm8vNxpbFoqDK1t8vk6nXKDTTjikLW
         ZwcVXFBWN4Mea2cUkc2Z+Rnphe+RG9qewKFBJQkz+4VzhCWL1iEOF+VsrUiwbK5K9SZO
         CKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672150; x=1785276950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4WjCM0YGYpG6uGbEGVqjVtxdg84mLbv5nOzooF+Ac4=;
        b=dnEz9eIKDzNI1ci38cXavjOc7rygG1nnuPsGHKJay8GjLziT/8RMvfNg3E3tz3yX+l
         UIRrqaivo+yzwC0rNxgwghfzZ1m/gcxqz+naJu6FsPQz3hKQ0/SvT2HnIKt3XvnjF4Rw
         H0Ec76VZ0Dbuq+aAmEjQOT4WVGTRa86pR637H6sAW8j7uW8RlizxJW7yxDlK52+ucTAr
         3BqtCP9ui//kR0HvDLSvqYS/8Zj5+5OwyKlWDpegjqJe1515HX5dDsx+9WJHqxMJq6YJ
         cc72jmxJIwLK3adJem7a44ExVhwsu7fbp5aM3OT1ftkIJrd44ddh+832tOobG8GphfRg
         /vyg==
X-Forwarded-Encrypted: i=1; AHgh+RqFK4EaRswB1bh9lcUvYQGWw1VM0jPPAitImBD0ZJQwWx+nCoSnJTwUyZI7MX0oRY2y/Xe00Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTSGWq0HuuhAhZ0C2g6LJQ66ZBaE85/GUoee2whD2XY7pguIQ
	LrB5l6cTl6z5cAuJro3V08M1R0hw64pZDi3KuWriiimQDJqS5SWN9PQX
X-Gm-Gg: AR+sD13uyDBEDnugukv36uPuTBqJpKzEFXSDWYvU404zYN56pmjRzTMjewJJA7cNMXe
	bePuTo7vsoM5s5l97SvlN0LnaWp0m1jU2fsGLdLPp9Qpqd1GsrJqus5Opt7MIAGlTSAY2kZsOGb
	3Kx5oh6Qyvwk2YrPETMFBdLQaK5sCct0cS/ffSlihAuRXFY1aMKuCaSdPOn3OQV0PCKYop4eHpX
	LF7J8xlNRqhYyFaYMOLZ8scrivTWEvi5i5W0a6pWBQIc4UAtUv+S9nV1h5f3/sM+eiRgEoKQxvW
	DIcjU7TgDO3R7Vzi+O8IItHOMHmFMdYrtZfk1bFd7mOf2MX4vRYyEvNqyi+aLYvOX3U/ZccT4q0
	rR500SZgtYDZ/k8WmgVPZzZLTuEA7W7rn3UKNC3ALkJ9Xu0Sp4yDjGC21FdFyYJWspumUznygKp
	yxGBQ3hg==
X-Received: by 2002:a05:6a21:9d84:b0:3c3:a5e4:9141 with SMTP id adf61e73a8af0-3c3ad66b6c2mr21683461637.18.1784672150139;
        Tue, 21 Jul 2026 15:15:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::9edb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e07000fsm4420107eec.21.2026.07.21.15.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:15:49 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next 3/6] eth: fbnic: cache hwmon sensor readings
Date: Tue, 21 Jul 2026 15:15:37 -0700
Message-ID: <20260721221540.648272-4-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721221540.648272-1-limzhineng2@gmail.com>
References: <20260721221540.648272-1-limzhineng2@gmail.com>
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
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 36 +++++++++++++------
 3 files changed, 40 insertions(+), 10 deletions(-)

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
index 38bb26cb8e6c..f35cb0065093 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/hwmon.h>
+#include <linux/jiffies.h>
 
 #include "fbnic.h"
 #include "fbnic_mac.h"
@@ -25,26 +26,32 @@ static umode_t fbnic_hwmon_is_visible(const void *drvdata,
 
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
+	if (*cached != FBNIC_SENSOR_NO_DATA &&
+	    time_is_after_eq_jiffies(cache->last_read)) {
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
@@ -67,7 +74,12 @@ static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
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
@@ -107,6 +119,10 @@ void fbnic_hwmon_register(struct fbnic_dev *fbd)
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

