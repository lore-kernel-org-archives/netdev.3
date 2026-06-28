Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C223BD1B
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782673112; cv=none; b=WIaTFD+bcgwskKLTIwBQF6ym6fQOWuIIrDifZOG9X9den2iceIqATmXRe7pxzTX4gZXvlUonZH6F+937av4sWx0YRxsY60zSSO8Lxlsmi5QPbXJXp9hQ2kpqjhBO+nWUK6+9M8lYSB6G0uKj9K3nSOrBTdFpv1i/ZI3mRv+NZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782673112; c=relaxed/simple;
	bh=ApGLgapq9SSwy6ECFnrNtveQD3i+heLsBxJ5F/36GhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsHxgI9c9Flf9Jlq0+x3asfGqE5N23fvz1a9Mhr/l3JcaeSraOrt3HJMa0qV2IuOv6WkIcteqnSIDrzkLSy0cmsdp59VtkfwL/cV8Q56vHfUlVsTSKwyDAWtVHR1R9op3w6MixzBYLpbp1cJmeoSur1cfFY0xWDt62PzoJyZdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br22Jx7Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br22Jx7Y"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49265ea001cso765685e9.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782673109; x=1783277909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a32PHggIfZNY2LJCoqy17uVgYDrxc5NEYTyFY53jgB8=;
        b=Br22Jx7YvG6gb67XhAobDU5Xg1/ZR8r5hbvqpWYLjePQvFQD+eQDMDbbEHM0FRD9+b
         xd52Jj312Ugiq1f+d9fYwGyO6zVgSZ4JwTAFDcO59TB+BWAItgf2NGOy6B1NptcwUH/i
         Rj2VtEaYinLPPPyEQqJ36O3Zm5G0py2QWHqsAbwM3AJ48GRqCzj5xrCeYNKwRIYUXH2o
         ClnQ5W5xfPWQbmWm+WaVCDwEnniUdEPBI0YvBDJN+kjlHyCBC681LHXHu+bfEwrszzU8
         aaUGUgymQMxVG/GJI9wOTmhfDVlceNP+G+rThvnykox9doJKc+m/8bZkCZnYoIjc/XKs
         AAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782673109; x=1783277909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a32PHggIfZNY2LJCoqy17uVgYDrxc5NEYTyFY53jgB8=;
        b=fF/ADmllvnaXlm7TwC7U7IxKouCYxcqlhz1JTJFLAkyeg4veTQLkMRkSMAkdQGFcyd
         cK2A4LYZMUQdpVibJ33wzxWQi9oZdEHUMNq3CTOs+P/eNcXRXR2+j4RlP3M+aL77oSxt
         JMDgbj8vLVzQBt4UcYqe4IlXszbCmneotQdwjRgWDinRMEGLIeeAEZkakfw4VbaE1iAC
         BqZXvL01XzVULQVA3sYHOU96RHKA4wfm3V38WQybjCEHzOnuMckUkN/o/k7mzNv1hyUm
         KoBJgrBxwhzYRi+CQSdEehVB7dzF2bBFMCCuqOknikz/N9pp09nfkfEfNV1vt15NvtVo
         aOnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v3T7d2vf1VfG4ZAl2rjj4+68XcCjDHGFBCZUHOL1gv9W6xKMhYpGxZavhEYkjlTFy+janJmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnETg/MM0lg4I28qm89/3DScgFVm02cqMUeATNgTGjsUk5E8wM
	52CFXC2PkUc31tkyTocLeqwm3L9TGOzvPsnRcUOZX2R9Dyz6TJUUUWKv
X-Gm-Gg: AfdE7cm4UOH+wqp7TFdhvLrLCe+/9RGLsiouF3Mjjk6NirDoPG9eKhksGyQKULb8usL
	j/Cq83NGA6qdAnr+6zy8vDX7vYzRBooLOdCaJgMZrX3sWFpLCo7/77bODzpDz+01eF4sdP1SwIO
	hiBdcH157//iwH/X9/IC0sRFx3pZCG3PvOx71X86tksIHPwl5jZO7VS3RoSBEd77lHFro9qdF9D
	bhc/OeLRHSmPb8n8SnrTLrCAqKRdhpbxKiDEyDh0zgYNSMZ5MArofMYV/euCasD3QzHus6fAnaX
	roDF99aRJ1Rx3kCMPUsXTIalufvoarterL7rcfrQFtXReyg9MHzeXg4T959/EabuRKFdHRSvBti
	45MON8tWpchsUJBvRsCURTdkLwaVyBhGkoZ91s2neELYTyPhyYcswTHnl1JJ/bPvE5foMo/JPrF
	8DFgHJ7T+mpmbSY46SHIgHJNqc+NxvUWE=
X-Received: by 2002:a05:600c:1d89:b0:492:7082:92e9 with SMTP id 5b1f17b1804b1-49270829314mr59246055e9.0.1782673108936;
        Sun, 28 Jun 2026 11:58:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:354:c290:1fe1:e65a:5670:6227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49271c1bb11sm152002095e9.4.2026.06.28.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:58:28 -0700 (PDT)
From: Lucas Poupeau <lucasp.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	kuniyu@google.com,
	sdf@fomichev.me,
	brauner@kernel.org,
	krikku@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: [PATCH] net: sysfs: cleanup coding style
Date: Sun, 28 Jun 2026 20:58:24 +0200
Message-ID: <20260628185824.231250-1-lucasp.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace DEVICE_ATTR() with DEVICE_ATTR_RW() where applicable to
follow kernel coding style conventions. Add blank lines between
function definitions and macro invocations. Fold multi-line
attribute initializations onto single lines where it improves
readability without exceeding the line length limit.

Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
---
 net/core/net-sysfs.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e71c9ed41e8..14efe81d006b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -494,6 +494,7 @@ static ssize_t mtu_store(struct device *dev, struct device_attribute *attr,
 {
 	return netdev_store(dev, attr, buf, len, change_mtu);
 }
+
 NETDEVICE_SHOW_RW(mtu, fmt_dec);
 
 static int change_flags(struct net_device *dev, unsigned long new_flags)
@@ -506,6 +507,7 @@ static ssize_t flags_store(struct device *dev, struct device_attribute *attr,
 {
 	return netdev_store(dev, attr, buf, len, change_flags);
 }
+
 NETDEVICE_SHOW_RW(flags, fmt_hex);
 
 static ssize_t tx_queue_len_store(struct device *dev,
@@ -517,6 +519,7 @@ static ssize_t tx_queue_len_store(struct device *dev,
 
 	return netdev_store(dev, attr, buf, len, dev_change_tx_queue_len);
 }
+
 NETDEVICE_SHOW_RW(tx_queue_len, fmt_dec);
 
 static int change_gro_flush_timeout(struct net_device *dev, unsigned long val)
@@ -534,6 +537,7 @@ static ssize_t gro_flush_timeout_store(struct device *dev,
 
 	return netdev_lock_store(dev, attr, buf, len, change_gro_flush_timeout);
 }
+
 NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
 
 static int change_napi_defer_hard_irqs(struct net_device *dev, unsigned long val)
@@ -555,6 +559,7 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
 	return netdev_lock_store(dev, attr, buf, len,
 				 change_napi_defer_hard_irqs);
 }
+
 NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_uint);
 
 static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
@@ -612,8 +617,9 @@ static ssize_t group_store(struct device *dev, struct device_attribute *attr,
 {
 	return netdev_store(dev, attr, buf, len, change_group);
 }
+
 NETDEVICE_SHOW(group, fmt_dec);
-static DEVICE_ATTR(netdev_group, 0644, group_show, group_store);
+static DEVICE_ATTR_RW(netdev_group);
 
 static int change_proto_down(struct net_device *dev, unsigned long proto_down)
 {
@@ -626,6 +632,7 @@ static ssize_t proto_down_store(struct device *dev,
 {
 	return netdev_store(dev, attr, buf, len, change_proto_down);
 }
+
 NETDEVICE_SHOW_RW(proto_down, fmt_dec);
 
 static ssize_t phys_port_id_show(struct device *dev,
@@ -1125,8 +1132,7 @@ static struct rx_queue_attribute rps_cpus_attribute __ro_after_init
 	= __ATTR(rps_cpus, 0644, show_rps_map, store_rps_map);
 
 static struct rx_queue_attribute rps_dev_flow_table_cnt_attribute __ro_after_init
-	= __ATTR(rps_flow_cnt, 0644,
-		 show_rps_dev_flow_table_cnt, store_rps_dev_flow_table_cnt);
+	= __ATTR(rps_flow_cnt, 0644, show_rps_dev_flow_table_cnt, store_rps_dev_flow_table_cnt);
 #endif /* CONFIG_RPS */
 
 static struct attribute *rx_queue_default_attrs[] __ro_after_init = {
@@ -1279,8 +1285,7 @@ static int rx_queue_change_owner(struct net_device *dev, int index, kuid_t kuid,
 		return error;
 
 	if (dev->sysfs_rx_queue_group)
-		error = sysfs_group_change_owner(
-			kobj, dev->sysfs_rx_queue_group, kuid, kgid);
+		error = sysfs_group_change_owner(kobj, dev->sysfs_rx_queue_group, kuid, kgid);
 
 	return error;
 }
@@ -1358,6 +1363,7 @@ struct netdev_queue_attribute {
 			 struct netdev_queue *queue, const char *buf,
 			 size_t len);
 };
+
 #define to_netdev_queue_attr(_attr) \
 	container_of(_attr, struct netdev_queue_attribute, attr)
 
@@ -1366,8 +1372,7 @@ struct netdev_queue_attribute {
 static ssize_t netdev_queue_attr_show(struct kobject *kobj,
 				      struct attribute *attr, char *buf)
 {
-	const struct netdev_queue_attribute *attribute
-		= to_netdev_queue_attr(attr);
+	const struct netdev_queue_attribute *attribute = to_netdev_queue_attr(attr);
 	struct netdev_queue *queue = to_netdev_queue(kobj);
 
 	if (!attribute->show)
@@ -1380,8 +1385,7 @@ static ssize_t netdev_queue_attr_store(struct kobject *kobj,
 				       struct attribute *attr,
 				       const char *buf, size_t count)
 {
-	const struct netdev_queue_attribute *attribute
-		= to_netdev_queue_attr(attr);
+	const struct netdev_queue_attribute *attribute = to_netdev_queue_attr(attr);
 	struct netdev_queue *queue = to_netdev_queue(kobj);
 
 	if (!attribute->store)
@@ -1499,15 +1503,12 @@ static ssize_t tx_maxrate_store(struct kobject *kobj, struct attribute *attr,
 	return err;
 }
 
-static struct netdev_queue_attribute queue_tx_maxrate __ro_after_init
-	= __ATTR_RW(tx_maxrate);
+static struct netdev_queue_attribute queue_tx_maxrate __ro_after_init = __ATTR_RW(tx_maxrate);
 #endif
 
-static struct netdev_queue_attribute queue_trans_timeout __ro_after_init
-	= __ATTR_RO(tx_timeout);
+static struct netdev_queue_attribute queue_trans_timeout __ro_after_init = __ATTR_RO(tx_timeout);
 
-static struct netdev_queue_attribute queue_traffic_class __ro_after_init
-	= __ATTR_RO(traffic_class);
+static struct netdev_queue_attribute queue_traffic_class __ro_after_init = __ATTR_RO(traffic_class);
 
 #ifdef CONFIG_BQL
 /*
@@ -1565,8 +1566,7 @@ static ssize_t bql_set_hold_time(struct kobject *kobj, struct attribute *attr,
 }
 
 static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
-	= __ATTR(hold_time, 0644,
-		 bql_show_hold_time, bql_set_hold_time);
+	= __ATTR(hold_time, 0644, bql_show_hold_time, bql_set_hold_time);
 
 static ssize_t bql_show_stall_thrs(struct kobject *kobj, struct attribute *attr,
 				   struct netdev_queue *queue, char *buf)
@@ -1660,8 +1660,7 @@ static ssize_t bql_set_ ## NAME(struct kobject *kobj,			\
 }									\
 									\
 static struct netdev_queue_attribute bql_ ## NAME ## _attribute __ro_after_init \
-	= __ATTR(NAME, 0644,				\
-		 bql_show_ ## NAME, bql_set_ ## NAME)
+	= __ATTR(NAME, 0644, bql_show_ ## NAME, bql_set_ ## NAME)
 
 BQL_ATTR(limit, limit);
 BQL_ATTR(limit_max, max_limit);
@@ -1816,8 +1815,7 @@ static ssize_t xps_cpus_store(struct kobject *kobj, struct attribute *attr,
 	return err ? : len;
 }
 
-static struct netdev_queue_attribute xps_cpus_attribute __ro_after_init
-	= __ATTR_RW(xps_cpus);
+static struct netdev_queue_attribute xps_cpus_attribute __ro_after_init = __ATTR_RW(xps_cpus);
 
 static ssize_t xps_rxqs_show(struct kobject *kobj, struct attribute *attr,
 			     struct netdev_queue *queue, char *buf)
@@ -1886,8 +1884,7 @@ static ssize_t xps_rxqs_store(struct kobject *kobj, struct attribute *attr,
 	return err ? : len;
 }
 
-static struct netdev_queue_attribute xps_rxqs_attribute __ro_after_init
-	= __ATTR_RW(xps_rxqs);
+static struct netdev_queue_attribute xps_rxqs_attribute __ro_after_init = __ATTR_RW(xps_rxqs);
 #endif /* CONFIG_XPS */
 
 static struct attribute *netdev_queue_default_attrs[] __ro_after_init = {
-- 
2.53.0

