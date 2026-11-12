Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442852;
	b=Ln/Cs+j4PeDjwTnL+29rfy89fX+XXaNHSLSHkHoGhHkJGghB3X+zEQf0hUHODKqvI/8T
	 hnT2UG3RChnDHEk4s99sbbuAQpn4VAWm+p0nTQeEoB2QmEVFmmyjoOlKrNLqdAsw4+Wa0
	 wavN+gRClfw5lmkmb6zgLMOK/Mic07nfU/z3V4Z0JyHzPzfEcKywXZY16jWm2XOmGL4jV
	 fnSxV5VW2XBsMhDgmkgbOwGpQDQEofu5gA7RQu+4u0xiwXFqm46hC0CvIBzAYEkyOY+pb
	 t8mHynAB5GVekez1yl7StVk/zqO2IQyQTezyydjOGt0fJbG8To3Rhbul2a7keWyjQug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4u/i0K/kZxeNYTNdEkP+SGosn3lLleQQ1euUt+BT4f0=;
	b=iohdk1sd7DLPB+orurqtsB7NlBgFPM/cqb1+46iieZM0zA2fHR2el+yMlIR3CAEpOh7G
	 oUzanuiR5U6l9fKVFnAyV6dEnIib0w1uKWrnUW3FwfUOYfEi9v5cJObb8w+ZH8ZSYJ4zs
	 zj8S/rWq9EuRMLEPFqRkNqen9GZHZG2kpJ8TFrWkP+TkB4HP3ylTh7UQ39t/+LVdlR9AQ
	 HY3YsgM0UWKRO9VvzK6pSA1HlUiIBgCj4fIFQrHFZgL41PhFF7TZX+iRN047XoaGcgoP2
	 CI+ZM6ps/sBB4vA4Upm8Or1ai2uyCIbf+a/S0g7HHfFO0sLWzArrcUH/XhCYc93Eyfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BzP5PfQP;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF60606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF60606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BzP5PfQP
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1482746a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442851; x=1795047651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4u/i0K/kZxeNYTNdEkP+SGosn3lLleQQ1euUt+BT4f0=;
        b=BzP5PfQP5IOY+08Ovdd8G+oGzosODbOdBwPQj2+lm5GPJfWiOD55XAsPyaWQKEiT4j
         FGFVitsqzvURcqIsMXGabmGJdxDPOJ7Yb6rgNIpQTYnzVpJF5Ejp34ERLSYKgHyIOZnJ
         2dksh8kbcR8r8Xp7XBheLmbCUTIvp8fZZyP4M8g93he06ABh8fZGrOQ8c/4MlubSpqby
         d2y9SfdO3gTu1zYiCrsWNrw9KakiRqEzX54N67NACwraed+UifJrZFpX4sAHmfbi1N8T
         3eHy3pfh8gaX+0pdm6n0RBH3oifeoA1JT6HD+VVRVLNWZ3ildyEsg+fqa9avJD84FGM5
         jzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442851; x=1795047651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4u/i0K/kZxeNYTNdEkP+SGosn3lLleQQ1euUt+BT4f0=;
        b=KLX4QyKk3TmkO2KQQ3fTpy7V+7PmV3V/hnH9EAHmspKMKvUA7s1eO6dsQW7DKq5UAV
         uVMzvnlSU8GrZKFY7tlZX4TIncpgJ/XoMAhHTzabc4Kdb+ZQdFii1QEfyxZZZnoD0g5L
         3kS5vZKoGbGmp/xu20+lfw9qGV7+nmDHuMN1Ki5n5qOKQ/VQ6ISCMtuHJuKu23L8GN3v
         77m2TlP2OZS9j0LyvGmd+FVBODxnpdSkH5GCdTlPAZ+NE+6ncu7076We/dtwydXEXBAw
         24HuGZcYIUweFo+1GCvFvpFVXLSpv9LeKalG5RbOO1N9Zp4dGJTtYalcSIKxO4tAJAhm
         qXXA==
X-Gm-Message-State: APuU4Z+96kZosL/zeTJlC8bm3JIxWGbJ47m+34nKINSPhIbZnmyOIChp
	MbaZV3oMbogcT7ZPRRqoXVVulU4iJZ0DXZJ6PtvSAn4NIT24Pkb3Tu5FSVGoQA==
X-Gm-Gg: AYBFou2Pfj0/Mb+wJ9Rb6jEGhstBaIXgH6XQGCQ0lsJGAy/dJUixad6rCEXIYf5rDKf
	JjnHWXvUV/mnaQxy1i13fGfWHJVOTwAF1x8aIiL2OrY+jBx+oL9lKUzhT1lfdV6ns/sxlwlIjVv
	sTPKqsKUVtH9y5c8d/c0LthMqpkNLPYf/a92/K5g8kWJt0TV7yHb+uu7o0Mle3oxipOFQDzz7lY
	lg+yqb+eDZIwNejAy11L3GqoESB6Sifyfhlfm3Jf2GDGSBZjx71FiBRYf+OUnkr6Vw9wI0EDH2I
	W5n6o+Q+n96ORG2fgDrCt1qdeTyV26mmBUHYEnaZ9thi3xYnRuu/TV92ICc6W9uSGitc0i3pAoZ
	KS7FRgjac/1N5QlnwY+qXDuV/hWSEuzhd7HKZdHk/6kQUDzkTs/35ypHXsxO3HsKnl8Npstk/Ro
	B8PFi1JcoXi/x4v5/YbQXC5c1mG7ZnjwdBWWsPHKJAUN2Y8oAMNxSuGGZcqbY6fimXs6jOaLs81
	J5GT2Fm1zU+FLevk/LfeoUT5CdZC/sGCk1J0bZQpfd7BduNd6GOuUsR7JkZiUqGvsxJjbvpYmNd
	AjNNGU/lPxqLM+9Wb/3tiAZbhAjy1LUCFs/U5cufWVimekKjCbUH4g==
X-Received: by 2002:a05:6a20:2589:b0:3e2:7e05:49b0 with SMTP id adf61e73a8af0-3f2ff5d26d7mr3934258637.50.1794442850892;
        Wed, 11 Nov 2026 16:20:50 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:6e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaac46b20sm2647262b3a.30.2026.11.11.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:20:50 -0800 (PST)
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
Subject: [PATCH net-next v4] net: dsa: motorcomm: Add devlink info and resources
Date: Thu, 12 Nov 2026 08:20:29 +0800
Message-ID: <20261112002031.1475005-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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
resources for ACLs and meters.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v4:
 - remove FDB-related changes
v3: https://lore.kernel.org/r/20261109163117.1792478-1-mmyangfl@gmail.com
 - remove the buggy sub-resources
v2: https://lore.kernel.org/r/20261108094512.1285796-1-mmyangfl@gmail.com
 - fix issues reported by sashiko
v1: https://lore.kernel.org/r/20261106184811.350700-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/Makefile  |   1 +
 drivers/net/dsa/motorcomm/chip.c    |   8 ++
 drivers/net/dsa/motorcomm/chip.h    |   2 +
 drivers/net/dsa/motorcomm/devlink.c | 111 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  18 +++++
 5 files changed, 140 insertions(+)
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
index a1d0ce35f4f3..855637d0548d 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,6 +26,7 @@
 #include <net/ieee8021q.h>
 
 #include "chip.h"
+#include "devlink.h"
 #include "leds.h"
 #include "mdio_bus.h"
 #include "mib.h"
@@ -2141,6 +2142,8 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 	yt921x_leds_remove(priv);
 #endif
+
+	dsa_devlink_resources_unregister(ds);
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -2475,6 +2478,10 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+	res = yt921x_devlink_setup(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	res = yt921x_leds_setup(priv);
 	if (res)
@@ -2563,6 +2570,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
 #endif
 	/* chip */
+	.devlink_info_get	= yt921x_dsa_devlink_info_get,
 	.teardown		= yt921x_dsa_teardown,
 	.setup			= yt921x_dsa_setup,
 };
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index fc315f1d8f87..55a36716266c 100644
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
diff --git a/drivers/net/dsa/motorcomm/devlink.c b/drivers/net/dsa/motorcomm/devlink.c
new file mode 100644
index 000000000000..6be9630e1e5e
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/devlink.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include "chip.h"
+#include "devlink.h"
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

