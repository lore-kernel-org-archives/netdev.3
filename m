Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131171;
	b=0OW/dHSANpfXKiFdOUwSCGcVnsMaiz+EgCKXr6fbChhjsg7QbWQAOyfa6C0OeEMz8RNe
	 WJNQEZM8OwYNsb272nmFIj/6hgjwJZ+Z55by35Y62hQ4l4lrDED2CgchRdmZZsiZQihxO
	 nuRkTTQ5HyF+OwDnNptaCleJsDOuH2zGXZ/iy6xr6GfGc2qistziiyGNNZnllFucVs5M6
	 E4Rgp0uX8xB/yS1pypog/zN2zWEB9lScIuxAjHUnzA6ZLuxDSgz3OB5jKvmtPOmKFpAfp
	 pGR6v8VdLN6ExOJc4N/eE3Vj6Q6UCl6I8zNvmH/BIhCFiVl8EHsSHLAZF2CdKyR8LLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rG8iS7j870j9sAI96jEzzmHgQ0BSKQpAbnQsOyox3h4=;
	b=YaEEXAvoOWKaEBX4nMRCSHACtHFe32seHium+QXVknIJIN0pesLv2uwM1Ob5W2yaE159
	 ds7/K8kZeYrcZAEwLESOcvEd0EVoETyVNMijsNKewcDRqq4rtfE03YtzyCvmFJEIBUWoi
	 9LAWDHEe+yusJLjUrlf1Nf52g/o9VIVbcamiJ0vruq9h1r8QAaukK8NMazxX9/+F4ilt5
	 JJy5l1Wd0AG7XenSfsiL8aqJL7osUGmY0hgUbjjDmz2p7Fqhp4Ku43W27JrA9XB8zguQB
	 CPNqFsbYwLo1zwRRwb0A8G93ZZTfJzWLBD59Y+gcYj8CNLBTienj2/8SuMi0eNa1KVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdWDLT2z;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B76606D81A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 09:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B76606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdWDLT2z
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so2833325ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131171; x=1794735971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rG8iS7j870j9sAI96jEzzmHgQ0BSKQpAbnQsOyox3h4=;
        b=sdWDLT2zkLq8QZWuANv0ejxugOjiwMB7bAmvZEeCXEghQ85M8cxgCORQh46Ha4WI8C
         6KiA/wQxZcA6kORrPETPCNFqFsQCVbQ+ksqyG8ho40GoS3vDqW0+IQdVrp+7aSzrPjK1
         TJVu5l49b5RvVn89tevo7J15pGAwCmp3abVZxPuLdPE9zGE/HuTBecTiyHf+Cym7KxRq
         JeIKNpGpjtGwOBmTXYU1pgO+FzB8exLbw6uOri13qbcY6HREpL2Y9QPA73yeMwlFWZjB
         M++SF6s+PHn6XsyWVWzNAx86H5ibII7M2jFfz0/yeAq8ee8zWtBiUzqeDu0Pa9esE0oO
         SPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131171; x=1794735971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rG8iS7j870j9sAI96jEzzmHgQ0BSKQpAbnQsOyox3h4=;
        b=BH3zlXHnMsDJnM8WMtsfJWJJ7NGBWI7IXLei3oxJIxqfCMGGu8W3t8O1dnhqSE+K3q
         ubnFtr0B3pdMd3g3u9tY91RtYHiNOYeQNY2JT2QArQVcfBguyWun0iIte5FL64+I4DF8
         bRR1/BCCh4IA2uHkk8bIrYCd0ecTPwPigDbnzbcrU128VOfiRiEaNUphtJwZYrZP1Kd9
         lF3G+KK4MRZ/mc1OQdDPfTCUqgrZgxU8AcMXr1mrGj/tyjGZx1IuoovtTIODlXACy8o2
         ntHPQdVOvnM79YqXBoLLOVqp1OuXKSo1uJGtw/cIgkW5Ow/uHsctmcA1pB+a59eBIwR1
         AyvQ==
X-Gm-Message-State: APuU4Z9AiXM5PzM4zQL8X9bzBNsvUILCkfjBw1Z2ZzEdw79pm7Bj9Em+
	bNypqzweMA0KAN1PgkfONLIs05I8PXOqmUbYiiJgx6sRQlefMQeKpqTPzzQfQA==
X-Gm-Gg: AYBFou1ia++faMS44kU5ky7geMDYTwX8UGze69JLjt4VR8x+BtT1+AZCz1dk6NTZG6p
	JayGvDRZF0mN6FpbdzbrwkNR17eN3cnwae0Jcrene5f1V23EuAP6Nt4mFikKVMSVunHImcG0wh2
	H7/vIDENLXQZlKmlr58+O4LlBSvEw5VGGisL1BJpbERTCoCyi1o9DRZTcpSPLZ1cQtrr6jtrswQ
	FKpAE4uFWmsZMJM7JNwREkAwVDQ4o3F3wW1AKuqcvvqCcPT5fKFuppotzCUuHqwr30a+V9YEbmY
	pWWZJAoW5JPjv5G4GdOjzrnQ7sk+GxtODFlhaiPWbKAtyNjJeO8eew4FOuZuZIjtyQEuyPNm2BX
	/x0MVpYSadhSzY1dpCsDA5GBAx+huGbR/+OjvPjTBTU/wqdxBq6qQZITC/aROBES0OFt9HE9ozZ
	BEPtIVOLt9u7MMUWPepa9Vk/f6hRTmvkUM6NMn8QcgSStBI/4kol+bVCG6yCtG0ZtqirLnHHItv
	3TvzOL5WLqBVUGcUquHsmLRVN6uYrQFzV30f9XqOeYU1UBXLNMLHwe9HIS0Bg1Aft/QVTaIcFVx
	sexDdHrmARSnlZuGh78zxS2G88BdqoKUklbj6+fufZBCeAvYKIHV43gtu28w1BeOQ/blR/rM2uM
	=
X-Received: by 2002:a17:902:f712:b0:2eb:404a:cc44 with SMTP id d9443c01a7336-2ed83788005mr8670135ad.54.1794131170494;
        Sun, 08 Nov 2026 01:46:10 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed813af834sm3222715ad.0.2026.11.08.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:46:09 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: dsa: motorcomm: Add devlink info and resources
Date: Sun,  8 Nov 2026 17:45:10 +0800
Message-ID: <20261108094512.1285796-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108094512.1285796-1-mmyangfl@gmail.com>
References: <20261108094512.1285796-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the ASIC model via devlink info (ASIC_ID), and register devlink
resources for ACLs, FDB and meters. Resource occupancy is read back from
the hardware counters for learned FDB entries; static FDB entries are
counted in software.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/Makefile  |   1 +
 drivers/net/dsa/motorcomm/chip.c    |  55 ++++++-
 drivers/net/dsa/motorcomm/chip.h    |   4 +
 drivers/net/dsa/motorcomm/devlink.c | 216 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  18 +++
 5 files changed, 288 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/devlink.c
 create mode 100644 drivers/net/dsa/motorcomm/devlink.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 9eaa59f699e8..0b31d815ce43 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
 yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
+yt921x-objs += devlink.o
 yt921x-objs += mdio_bus.o
 yt921x-objs += mib.o
 yt921x-objs += pcs-921x.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index a7a9a7439304..95d57e74d64c 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,6 +26,7 @@
 #include <net/ieee8021q.h>
 
 #include "chip.h"
+#include "devlink.h"
 #include "leds.h"
 #include "mdio_bus.h"
 #include "mib.h"
@@ -731,6 +732,10 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (val & YT921X_FDB_RESULT_NOTFOUND)
 		return -ENOSPC;
 
+	if (is_multicast_ether_addr(addr))
+		priv->fdb_static_mcast_cnt++;
+	else
+		priv->fdb_static_ucast_cnt++;
 	return 0;
 }
 
@@ -761,18 +766,35 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
 	ctrl2 = val2 & ~YT921X_FDB_IO2_EGR_PORTS(ports_mask);
 	if (ctrl2 == val2)
 		return 0;
+
+	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &ctrl1);
+	if (res)
+		return res;
+
 	if (!(ctrl2 & YT921X_FDB_IO2_EGR_PORTS_M)) {
 		ctrl = YT921X_FDB_OP_OP_DEL | YT921X_FDB_OP_START;
 		res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
 		if (res)
 			return res;
 
-		return yt921x_fdb_wait(priv, &val);
-	}
+		res = yt921x_fdb_wait(priv, &val);
+		if (res)
+			return res;
 
-	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &ctrl1);
-	if (res)
-		return res;
+		if ((ctrl1 & YT921X_FDB_IO1_STATUS_M) ==
+		    YT921X_FDB_IO1_STATUS_STATIC) {
+			unsigned short *cnt;
+
+			if (is_multicast_ether_addr(addr))
+				cnt = &priv->fdb_static_mcast_cnt;
+			else
+				cnt = &priv->fdb_static_ucast_cnt;
+
+			if (!WARN_ON(!*cnt))
+				(*cnt)--;
+		}
+		return 0;
+	}
 
 	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
 }
@@ -809,7 +831,18 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (ctrl1 == val1 && ctrl2 == val2)
 		return 0;
 
-	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+	res = yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+	if (res)
+		return res;
+
+	if ((val1 & YT921X_FDB_IO1_STATUS_M) !=
+	    YT921X_FDB_IO1_STATUS_STATIC) {
+		if (is_multicast_ether_addr(addr))
+			priv->fdb_static_mcast_cnt++;
+		else
+			priv->fdb_static_ucast_cnt++;
+	}
+	return 0;
 }
 
 static int
@@ -2154,6 +2187,8 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 	yt921x_leds_remove(priv);
 #endif
+
+	dsa_devlink_resources_unregister(ds);
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -2481,6 +2516,9 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 			  pp->pcs.supported_interfaces);
 	}
 
+	priv->fdb_static_ucast_cnt = 0;
+	priv->fdb_static_mcast_cnt = 0;
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_chip_setup(priv);
 	mutex_unlock(&priv->reg_lock);
@@ -2488,6 +2526,10 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+	res = yt921x_devlink_setup(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	res = yt921x_leds_setup(priv);
 	if (res)
@@ -2576,6 +2618,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
 #endif
 	/* chip */
+	.devlink_info_get	= yt921x_dsa_devlink_info_get,
 	.teardown		= yt921x_dsa_teardown,
 	.setup			= yt921x_dsa_setup,
 };
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index fc315f1d8f87..d3f2a86feb22 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -248,6 +248,7 @@ enum yt921x_app_selector {
 #define   YT921X_PORT_LEARN_MODE_AUTO			YT921X_PORT_LEARN_MODE(0)
 #define   YT921X_PORT_LEARN_MODE_AUTO_AND_COPY		YT921X_PORT_LEARN_MODE(1)
 #define   YT921X_PORT_LEARN_MODE_CPU_CONTROL		YT921X_PORT_LEARN_MODE(2)
+#define YT921X_LEARN_UCAST_CNT		0x18043c
 #define YT921X_AGEING			0x180440
 #define  YT921X_AGEING_INTERVAL_M		GENMASK(15, 0)
 #define YT921X_FDB_IN0			0x180454
@@ -312,6 +313,7 @@ enum yt921x_app_selector {
 #define   YT921X_FDB_IO2_PRIO(x)			FIELD_PREP(YT921X_FDB_IO2_PRIO_M, (x))
 #define  YT921X_FDB_IO2_NEW_VID_M		GENMASK(11, 0)
 #define   YT921X_FDB_IO2_NEW_VID(x)			FIELD_PREP(YT921X_FDB_IO2_NEW_VID_M, (x))
+#define YT921X_LEARN_MCAST_CNT		0x180504
 #define YT921X_FILTER_UNK_UCAST		0x180508
 #define YT921X_FILTER_UNK_MCAST		0x18050c
 #define YT921X_FILTER_MCAST		0x180510
@@ -525,6 +527,8 @@ struct yt921x_priv {
 	struct yt921x_port ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
+	unsigned short fdb_static_ucast_cnt;
+	unsigned short fdb_static_mcast_cnt;
 
 	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
 
diff --git a/drivers/net/dsa/motorcomm/devlink.c b/drivers/net/dsa/motorcomm/devlink.c
new file mode 100644
index 000000000000..a9a611ef5571
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/devlink.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include "chip.h"
+#include "devlink.h"
+#include "smi.h"
+#include "tc.h"
+
+int
+yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
+			    struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	int res;
+
+	if (!priv->info)
+		return -ENODEV;
+
+	res = devlink_info_version_fixed_put(req,
+					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+					     priv->info->name);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static u64 yt921x_devlink_occ_get_acl(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	u64 count = 0;
+
+	mutex_lock(&priv->reg_lock);
+	for (unsigned int i = 0; i < YT921X_ACL_BLK_NUM; i++)
+		count += hweight8(priv->acl_masks[i]);
+	mutex_unlock(&priv->reg_lock);
+
+	return count;
+}
+
+static u64 yt921x_devlink_occ_get_fdb_ucast(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_LEARN_UCAST_CNT, &val);
+	if (!res)
+		val += priv->fdb_static_ucast_cnt;
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return 0;
+	return val;
+}
+
+static u64 yt921x_devlink_occ_get_fdb_mcast(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_LEARN_MCAST_CNT, &val);
+	if (!res)
+		val += priv->fdb_static_mcast_cnt;
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return 0;
+	return val;
+}
+
+static u64 yt921x_devlink_occ_get_fdb_static(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	u64 count;
+
+	mutex_lock(&priv->reg_lock);
+	count = priv->fdb_static_ucast_cnt + priv->fdb_static_mcast_cnt;
+	mutex_unlock(&priv->reg_lock);
+
+	return count;
+}
+
+static u64 yt921x_devlink_occ_get_fdb(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	u64 count = 0;
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+
+	res = yt921x_reg_read(priv, YT921X_LEARN_UCAST_CNT, &val);
+	if (res)
+		goto end;
+	count += val;
+
+	res = yt921x_reg_read(priv, YT921X_LEARN_MCAST_CNT, &val);
+	if (res)
+		goto end;
+	count += val;
+
+	count += priv->fdb_static_ucast_cnt;
+	count += priv->fdb_static_mcast_cnt;
+
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return 0;
+	return count;
+}
+
+static u64 yt921x_devlink_occ_get_meter(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	u64 count;
+
+	mutex_lock(&priv->reg_lock);
+	count = bitmap_weight(priv->meters_map, YT921X_METER_NUM);
+	mutex_unlock(&priv->reg_lock);
+
+	return count;
+}
+
+enum yt921x_devlink_resource_id {
+	YT921X_DEVLINK_RESOURCE_ID_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
+	YT921X_DEVLINK_RESOURCE_ID_ACL,
+	YT921X_DEVLINK_RESOURCE_ID_FDB,
+	YT921X_DEVLINK_RESOURCE_ID_FDB_UCAST,
+	YT921X_DEVLINK_RESOURCE_ID_FDB_MCAST,
+	YT921X_DEVLINK_RESOURCE_ID_FDB_STATIC,
+	YT921X_DEVLINK_RESOURCE_ID_METER,
+};
+
+struct yt921x_devlink_resource {
+	const char *name;
+	devlink_resource_occ_get_t *occ_get;
+	unsigned short size;
+	unsigned char id;
+	unsigned char parent_id;
+};
+
+static const struct yt921x_devlink_resource yt921x_devlink_resources[] = {
+	{
+		"ACLs", yt921x_devlink_occ_get_acl,
+		YT921X_ACL_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_ACL,
+		DEVLINK_RESOURCE_ID_PARENT_TOP,
+	},
+	{
+		"FDBs", yt921x_devlink_occ_get_fdb,
+		YT921X_FDB_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+		DEVLINK_RESOURCE_ID_PARENT_TOP,
+	},
+	{
+		"ucast", yt921x_devlink_occ_get_fdb_ucast,
+		0,
+		YT921X_DEVLINK_RESOURCE_ID_FDB_UCAST,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+	},
+	{
+		"mcast", yt921x_devlink_occ_get_fdb_mcast,
+		0,
+		YT921X_DEVLINK_RESOURCE_ID_FDB_MCAST,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+	},
+	{
+		"static", yt921x_devlink_occ_get_fdb_static,
+		0,
+		YT921X_DEVLINK_RESOURCE_ID_FDB_STATIC,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+	},
+	{
+		"meters", yt921x_devlink_occ_get_meter,
+		YT921X_METER_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_METER,
+		DEVLINK_RESOURCE_ID_PARENT_TOP,
+	},
+};
+
+int yt921x_devlink_setup(struct yt921x_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	int res;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_devlink_resources);
+	     i++) {
+		struct devlink_resource_size_params size_params;
+		const struct yt921x_devlink_resource *r;
+
+		r = &yt921x_devlink_resources[i];
+
+		devlink_resource_size_params_init(&size_params, r->size,
+						  r->size, 1,
+						  DEVLINK_RESOURCE_UNIT_ENTRY);
+
+		res = dsa_devlink_resource_register(ds, r->name, r->size, r->id,
+						    r->parent_id, &size_params);
+		if (res) {
+			dsa_devlink_resources_unregister(ds);
+			return res;
+		}
+
+		dsa_devlink_resource_occ_get_register(ds, r->id, r->occ_get,
+						      priv);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/dsa/motorcomm/devlink.h b/drivers/net/dsa/motorcomm/devlink.h
new file mode 100644
index 000000000000..184b9f05742e
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/devlink.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_DEVLINK_H
+#define _YT_DEVLINK_H
+
+#include <net/dsa.h>
+
+struct yt921x_priv;
+
+int
+yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
+			    struct netlink_ext_ack *extack);
+int yt921x_devlink_setup(struct yt921x_priv *priv);
+
+#endif
-- 
2.53.0

