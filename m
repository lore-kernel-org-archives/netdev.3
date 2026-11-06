Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990915;
	b=MS6IGD7OKicKFiGmPH/5S1wgxZ/2u9qIXBg2VxGBgAvJTNAL1jkTKhcn3S4vcF6voJED
	 cQP/upkQ/jmMfe+pXbMChQNpSzbRieB+ck/D9eq3ZvOyZ0W5V74lcaU6EyLZoVkByUiVZ
	 BGVqipLW0v5C+XWBpbWjwmByzGGLVpEtMFQznImihEUXywnsRyywaTX73Sz5xoaJVlCY4
	 vtqTwdx7IQzRv3awQEuz40JjKI5e9XSn3i7yHmWS0JtCpIj1LUC0lB4QaLaGa5zgkcm7g
	 yTUS7k6kdOpYbX64e+Lh745SatRIKe0w58+GJW0LZVNvQWLpyLQqlpVdLe1A5+UdNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XLNAWdYUMNe6x6F53Gp8/RC3ZJK2NtFfa25xEg3W11g=;
	b=qS0HNO+blIqXUp+9qL5WtSLHGWNwQGORl6ivS/5M8jbJM3wTwxgtW8BnU0KMMOWZWO0j
	 DRiWIt5g42fSYt2zwiOLs37uYUkedE6trzj54hw3lCnae61gCP3xYB4hurV87fZrbJgKg
	 zCsK5SAvHVskR/GSzh7uGeL+fPaEpm/pkCBqwht6ENfSj8YkopaLa99zALMhxopZoeWlQ
	 +0GH4fvTO78soCjDKxhnbEF/pIpK30UsJrpRHlQqNYgcpgDGNM2GUA9x512eYQDIWqCWd
	 EZ3qZtCImGOD5zJUfDu8/NiEBg+Kap/1aqP0y410viLXOhWMKko71a2NElQr7s5US6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wNxPIkog;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119BC606EE90
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 119BC606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wNxPIkog
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso451422a91.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990914; x=1794595714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLNAWdYUMNe6x6F53Gp8/RC3ZJK2NtFfa25xEg3W11g=;
        b=wNxPIkogLNzbl2hvxPqIV7Ixc0u4XpDD2Kc3z6ZtASalChmI3R+nv5EXhzSppCd45A
         hoC0q3HoaViiwQVrzpMXbQTvUwCPr+Nj7zQ8z/htCpvJ4snODTbT4Swl2psdYqJZbGIR
         3sgvumvViGlpmjdCiDeZNmXPWhqEc4rmZLAH5ZiJTx1CdAYL9kQMKB6KW03/9g0Pykh5
         93rzEt/BDl+HMpFQtr83pbpNs0d7zEmRV01GlxZEhryxlUm1GpO8gFSgCzrhuo7Fg37j
         bGaNaO1bnFJi0MBdZDHW0d2nyDzlaM6nCc0KOceFSkyrkdzXG1YAWsaCSsl0GixUb/0b
         06lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990914; x=1794595714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XLNAWdYUMNe6x6F53Gp8/RC3ZJK2NtFfa25xEg3W11g=;
        b=1DCUjLG1jfUQ5syV1S6l9JN3dG6uCVLj4zd5sZ0Xy/F6iSYz9wxPcRz2teIn/aGvEN
         G5oi3bsnzke8R+kHaIFMcA1BTpkzxMJQcGbofA1bipo8nvsu5+N3sVcWyyNDD3SA/Nee
         WpnhDo4Ih6UdH0ar69vHLPeH2JpEM+kBLNV0VEifPlZEYSey64OBpSY6IdDrJO+pG9zk
         6PEX+tYXEBNPYta+hhR0ipRgPx1IvSU/KoDxIWAFJ3XqNW+dwq10XHD9ZXsA3pWFyVxv
         05s8WV90FRZ0G5++ooXus6QPI4aaa+cmDKwuMx/Y/WwdlnmstElHZ4N+1OCTiTzYemWI
         q3Aw==
X-Gm-Message-State: APuU4Z9dqTeB1HdWNocps05EHV+kr6fwXHrfZnX6BiS41M9GgwVNKEkm
	WqSWegNZ674ODrkwPUk92RuQNxVVStfGqvGCv8XZYLH65eSVZUhTWhh9L+w7PQ==
X-Gm-Gg: AYBFou1CmXt8jw8V4pMFyt3FNtZgu8uhtEHpbtptHSa+TL92CEKDD4s8/jO7ScoyUc7
	kSDe0e0SF5uw+39wpYPngo2NdONgEWoj4ERtzV5jz8KsGEv3dO0+ufFsT+Ji9qs0bIQN19KziRT
	+mslmCF2dHlECSPj3mMLt5khsEnlqovgMsk9/FvTArN4S4dCjfRwAN4TZkxXQUivr2YyjrQX8In
	FavRsMJXVU9pCoHsF3jjWIt8BRZ/mnhiqsUo/+m2jYZ8ZmwKOXy/E+nE7vEiugDQKmXX3A5MSWd
	vszHkBUWX0fB4iC8BBUM845XqDgaf2i7QHxvdW6kmQnv1QPFWaUEmAESekRrs3jXF8PR3wlHrDd
	YTyeJ0gXx5HqR4u8hJRLprCGsPWEqm7ZqyTYDJ0vfoD0c7vQvEHhXtxiO5kPW652VuUBMja5o2D
	OwxBud2K1d/Yxz07Vzx8eblv73h9GJD0a0BfjpLzBI1ciJevfhKY417fX6HmZmp47WSUnufLsVk
	S7TuDRiqyHuaHp6vcX0jpBMOI0INmRkI4pQyXgkrOSmnrJTHVq7RfJykhNxsTi7QEap36YRfqWK
	/XZj4V9xqzRJBQ0rL8Nq2lYscFUS6N1tmuVooYuYbQ9Qf4rH6KXI
X-Received: by 2002:a17:90b:3b8f:b0:3a8:cb54:e135 with SMTP id 98e67ed59e1d1-3b0db6c99c5mr3248864a91.19.1793990914295;
        Fri, 06 Nov 2026 10:48:34 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm45036a91.0.2026.11.06.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:48:33 -0800 (PST)
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
Subject: [PATCH net-next 2/2] net: dsa: motorcomm: Add devlink info and resources
Date: Sat,  7 Nov 2026 02:48:08 +0800
Message-ID: <20261106184811.350700-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106184811.350700-1-mmyangfl@gmail.com>
References: <20261106184811.350700-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/motorcomm/chip.c    |  37 ++++-
 drivers/net/dsa/motorcomm/chip.h    |   3 +
 drivers/net/dsa/motorcomm/devlink.c | 208 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  16 +++
 5 files changed, 259 insertions(+), 6 deletions(-)
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
index a7a9a7439304..c3c555cb8941 100644
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
@@ -809,7 +820,14 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (ctrl1 == val1 && ctrl2 == val2)
 		return 0;
 
-	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+	res = yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
+	if (res)
+		return res;
+
+	if ((val1 & YT921X_FDB_IO1_STATUS_M) !=
+	    YT921X_FDB_IO1_STATUS_STATIC)
+		priv->fdb_static_cnt++;
+	return 0;
 }
 
 static int
@@ -2154,6 +2172,8 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 	yt921x_leds_remove(priv);
 #endif
+
+	dsa_devlink_resources_unregister(ds);
 }
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
@@ -2488,6 +2508,10 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+	res = yt921x_devlink_setup(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	res = yt921x_leds_setup(priv);
 	if (res)
@@ -2576,6 +2600,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
index 000000000000..cddc77a6fd11
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/devlink.c
@@ -0,0 +1,208 @@
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
+#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
+
+int
+yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
+			    struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
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
+
+	return READ_ONCE(priv->fdb_static_cnt);
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
+		YT921X_FDB_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_FDB_UCAST,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+	},
+	{
+		"mcast", yt921x_devlink_occ_get_fdb_mcast,
+		YT921X_FDB_NUM,
+		YT921X_DEVLINK_RESOURCE_ID_FDB_MCAST,
+		YT921X_DEVLINK_RESOURCE_ID_FDB,
+	},
+	{
+		"static", yt921x_devlink_occ_get_fdb_static,
+		YT921X_FDB_NUM,
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
index 000000000000..e13fbe320bca
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/devlink.h
@@ -0,0 +1,16 @@
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
+int
+yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
+			    struct netlink_ext_ack *extack);
+int yt921x_devlink_setup(struct yt921x_priv *priv);
+
+#endif
-- 
2.53.0

