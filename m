Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242040;
	b=hMi7yfUwySfNBiJMNXOpZPosiX8GfbUs1AllqAzMtQbuL55Wa3DXmYc182io4Tfi8Q3b
	 LD8FZpkVuOvMP/BuqAYfXrmhpalToIyd7i/e3v3MAhvzzwZrOIJx29fcypdeHkYCG6mGb
	 8vc/hb0okJAaCOBU73JyyeAG1kXTk+Vr5L2R7QuXAE/KHIxIHUw86lo7EuJcSsfXwmYsc
	 L/Oing4RfhUwcfWeZ8ezyddLAE8RixNVE/mkiwSEe7iFbzCcnnSeR3lVknSGPJ10ITUy1
	 YIGBNBeN+Z1UFTjiN3XCQ0aEF3z1zI+qEoIvmyZheP2dR/XPXPkOTMSVNrs5UocOl+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ip09L+PRmppq3ZtI1qG/dvHVY32MUMe7JCbY5brjACs=;
	b=HERXo7uM4f8EnYqH9Q1OrcIaVGlCrGCfQPf6hVMIgRjQ0QqRXUZB+qJsZossbX0R8Th8
	 U1dUwv341uGRQ2RT+eTzucyvivSlYCwVme2wgf1AHpt+whD3b2Q1417HTp8zAGnJVPWP6
	 y5JtBpDGSqGZDNr/ppIVkIySmWkZ2b3nfLnmCo3Vy2Wd5ngoIMx97U2hZkMvx4O+/DBWN
	 kgEMbz82KcAX7DNj7A/yyPh1FvRpzxf/D9ZL8ZMx3JB02NHVmHZ+QQJgBHfvABJDqCqOb
	 5l6rx6CARLDx4Zl60pb3YtqhPbpoQ7pmaLWT37LJKh3BOj4TaPVoqrLPN625S9ayjGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Pf/U+QYW";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD755606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD755606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pf/U+QYW
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so652317a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242039; x=1794846839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ip09L+PRmppq3ZtI1qG/dvHVY32MUMe7JCbY5brjACs=;
        b=Pf/U+QYWmxMwe/Vg/CuLhn7k9MOphUtyO+sp3BzlujkXqIZtNvWl2Mzo2WNGJk8T6T
         AUNlvXaDRuSUE1kN9mPbotyInu7ZMWyMKoLdenxd+Ke/xCRMWxbe6cwwfBHvPpC4d62M
         DHJMppRfNy07IRYnGr5+zr+Fdz5udSeIav115Nf9Vz9sx9Ba1vGIN1x8oVTnMCqHRbDi
         lN2asKFhPKWCXLLXDyC8POzBsT8V7twwjajbrDa8ydMm/venv0bJ/k6HCXOez/DCnJ0o
         nEttymT33nsORz/wmxdy7eCWFCkiKnqDVXH+KXsAZhJCrncnI6nNOa3nMORnSQKwYLCI
         L+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242039; x=1794846839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ip09L+PRmppq3ZtI1qG/dvHVY32MUMe7JCbY5brjACs=;
        b=He6vP2rRBaPAtNtwRHhPjf61UHSfIDdKw9HICxHoZ6V+WYXMMug7/Jy5X2bU4LFMHK
         PNpKHUe7ZeFlZt64tVLOwpAfCmbTNeMHNh9uI1m4ioTPkQ64ybADWbspFMkLKmd8ew6q
         5HPSJdHBbdmsOTqYlk5rYa5Pe6GTQZmAw6cTm/KKsTG49792Mqnvlid5FFBW96VS7SVS
         IoE7eQK+Ds5QvQP1N5p9UE+WFrzWpnDn5kpk7J8744VquCdJu3wPp/KWsV5MdmqxyNE7
         iB8Wr7B3GOaNtYmLvkjAZ3n9sjXjSF4C47jt+hJ16NRu7lMC+IKVaubewUq5e13sKXu2
         lzlg==
X-Gm-Message-State: APuU4Z8JyhMFo53hF6FIllKJocNskhCnybN48IIn4b3Hp3BdJHOIKaK7
	WPVhbUp98AlH2zqYqpVqXn4drVYnMZ6WRxlVgkBsD4oQ3hYGWCtZ3u0FouObQQ==
X-Gm-Gg: AYBFou3iBwkuL1DyaF4DuccgatlKjtoRZ9UK4P1+hoPRZ3o6Q6VAZW6hX3kjabRnE0v
	TiEHpNXZQJcG9tRxMHuXX/lnmmtSt6m3yAYcy9/AiXAMxvEQ9kr+u8hneXvqoxhzgdM/D1vGO77
	qtY9R9q8+MpjHcz8j5C/8a8bmrW4ahVO9aEuZG2NzgEYQLwQBoPMCt++XFYeNnZmKJbnQWJ4Yq2
	PSiVz7oiu3oBnphO5liibEtE9pC7AZJoVA4eImgNiy8lmsbDOg/uSp7Tpw9ibPBnGf/CcTSpdcv
	xjINei8gg4NZqWcTNf/KkCQ5BH1bAVVo39kEcYlxG564hEjIXtmjkhHTvQix1KiLOGjeRtmfYxU
	83wnsxTctJhc5qvDG1nyZxq4rd8HughQaahCebxJA/EpLvFY3p4o6z8Zgqp1Df4jIaeDwq0vr0a
	4K4aTy1KnFYpaE8tMhhRvx+84Ftlc/8WYvpAQ/lStgm8AhTnec7TanKsfQkEhd7sb3OKDexr0EB
	l5lAKBQ/AUXt8RHGLjAcjjM+K0kGTsl+fT1tRPNYv7+MzAHTj/7kxE0mgdK+DsWZc7zsFgiRTiW
	KxIxLbMd/7AnPQMUOoCqUTT+GfR8t5x4C050NLCdvjt6ScdoPSh78Q==
X-Received: by 2002:a17:90b:51c1:b0:3b0:ada3:b505 with SMTP id 98e67ed59e1d1-3b166cde89amr171965a91.19.1794242038918;
        Mon, 09 Nov 2026 08:33:58 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1679c41aasm13995a91.0.2026.11.09.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:33:58 -0800 (PST)
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
Subject: [PATCH net-next v3 2/2] net: dsa: motorcomm: Add devlink info and resources
Date: Tue, 10 Nov 2026 00:30:09 +0800
Message-ID: <20261109163117.1792478-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109163117.1792478-1-mmyangfl@gmail.com>
References: <20261109163117.1792478-1-mmyangfl@gmail.com>
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
resources for ACLs, FDB and meters.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/Makefile  |   1 +
 drivers/net/dsa/motorcomm/chip.c    |  38 +++++--
 drivers/net/dsa/motorcomm/chip.h    |   3 +
 drivers/net/dsa/motorcomm/devlink.c | 148 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  18 ++++
 5 files changed, 202 insertions(+), 6 deletions(-)
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
index a7a9a7439304..b441d82f6d99 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,6 +26,7 @@
 #include <net/ieee8021q.h>
 
 #include "chip.h"
+#include "devlink.h"
 #include "leds.h"
 #include "mdio_bus.h"
 #include "mib.h"
@@ -731,6 +732,7 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (val & YT921X_FDB_RESULT_NOTFOUND)
 		return -ENOSPC;
 
+	priv->fdb_static_cnt++;
 	return 0;
 }
 
@@ -761,18 +763,27 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
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
+		    YT921X_FDB_IO1_STATUS_STATIC &&
+		    !WARN_ON(!priv->fdb_static_cnt))
+			priv->fdb_static_cnt--;
+		return 0;
+	}
 
 	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
 }
@@ -809,7 +820,13 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (ctrl1 == val1 && ctrl2 == val2)
 		return 0;
 
-	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+	res = yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+	if (res)
+		return res;
+
+	if (ctrl1 != val1)
+		priv->fdb_static_cnt++;
+	return 0;
 }
 
 static int
@@ -2154,6 +2171,8 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 	yt921x_leds_remove(priv);
 #endif
+
+	dsa_devlink_resources_unregister(ds);
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -2481,6 +2500,8 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 			  pp->pcs.supported_interfaces);
 	}
 
+	priv->fdb_static_cnt = 0;
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_chip_setup(priv);
 	mutex_unlock(&priv->reg_lock);
@@ -2488,6 +2509,10 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+	res = yt921x_devlink_setup(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	res = yt921x_leds_setup(priv);
 	if (res)
@@ -2576,6 +2601,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
 #endif
 	/* chip */
+	.devlink_info_get	= yt921x_dsa_devlink_info_get,
 	.teardown		= yt921x_dsa_teardown,
 	.setup			= yt921x_dsa_setup,
 };
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index fc315f1d8f87..5408ec268ba0 100644
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
@@ -525,6 +527,7 @@ struct yt921x_priv {
 	struct yt921x_port ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
+	unsigned short fdb_static_cnt;
 
 	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
 
diff --git a/drivers/net/dsa/motorcomm/devlink.c b/drivers/net/dsa/motorcomm/devlink.c
new file mode 100644
index 000000000000..529d2decc403
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/devlink.c
@@ -0,0 +1,148 @@
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
+	unsigned int count = 0;
+
+	mutex_lock(&priv->reg_lock);
+	for (unsigned int i = 0; i < YT921X_ACL_BLK_NUM; i++)
+		count += hweight8(priv->acl_masks[i]);
+	mutex_unlock(&priv->reg_lock);
+
+	return count;
+}
+
+static u64 yt921x_devlink_occ_get_fdb(void *ctx)
+{
+	struct yt921x_priv *priv = ctx;
+	unsigned int count = 0;
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
+	count += priv->fdb_static_cnt;
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
+		"ACL", yt921x_devlink_occ_get_acl,
+		YT921X_ACL_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_ACL,
+		DEVLINK_RESOURCE_ID_PARENT_TOP,
+	},
+	{
+		"FDB", yt921x_devlink_occ_get_fdb,
+		YT921X_FDB_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+		DEVLINK_RESOURCE_ID_PARENT_TOP,
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

