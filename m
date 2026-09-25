Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D94D2ED3
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360712; cv=none; b=nog2h2NJo0A5t7NcBcjD3R3MtRFpwOU6TIIR+y6AYrqxd5rr8S2m+HfnP4IoVuYnOZhKrVb5N59YhIAuoZQu6mxBZvvNHQ8FHFQiAqLGeKITQHwg/kCzxjXXw3+5q7O7osQOVi4nc9FUMsfaVbRsWz0vTzm5uTB5H5tULpLefDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360712; c=relaxed/simple;
	bh=0QQnZP1p2yN9vF5dpgaDO0cs3PioDmc8Lhtzbqk7Vg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P593xBdfXLpHoyN+YXICbRp+dREpLdZEa960s1xVb3071AcVw/I3QjDFdRGEphge7Ru6GoAyEGcCYXllIEDZwrZALBhfk/pcD0ose8V1uNlD1T6+BNnPgeJg7HNmpPgGmdBfCkutZB/l1GHTsOQii9+l9vmRtcog5B0DR1wwt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElrdH20n; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElrdH20n"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e66390995so7352575e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360707; x=1790965507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RLKc66fcC+JNVwgHdi/2vbRPcicTKmn6g9qNXOjPoho=;
        b=ElrdH20nTHwcLjCIisGu7CdX4HlGrTenoMZ2rVi8FDGO44pLy+F2f9AefXvkzCJu4p
         NB6nS75g7uKaM5y/ljvOP4d4KqqdvzCxOcpe5JluPiapVSY05n9cFN8OJzkMIoE63VRP
         xH0eJKaZFbQJjiMFjZzcdL6uZWuVnpUYa+kvIcaNNwWTgWf11U5Pp7nCZGqcVURMEBmy
         b7cc+z5oKLQv9A+QmXY3zmYNpLc5j9JqYLstC0z/8OOYNteq6oE46kODtbqkHpjrjua0
         5aYWk7yWpapO4g+eJN2bUeBpY5mSd58DbKhKY9C5HJor5dXt8RGV6zG/XrJmszq7qNef
         Ql3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360707; x=1790965507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RLKc66fcC+JNVwgHdi/2vbRPcicTKmn6g9qNXOjPoho=;
        b=CGKGskVxUTn+0h5w5sy/AGz09X0KvXZDuWOaCO3PSHDGNubUJSviz4rmwWSpfeXL6J
         KZlp12mCcRmadJsGqUbU9m6i6ZVp6Vp12OstB96Yg/wY8FArxrXmuJ6w25dnpBwgUbhN
         buCi15kFi0bPfdP59kY32aVp2mC4Drt7Q6lC9RGOl56D7B3nz17IIJ98tk7UBWGN3sPT
         iwrOHdtzmYd/S7WNwVPMkatotsLqNa3B8zwFs393XFiggENT8twLzlGCBiWXqzzCIm5b
         ty2E7Qgr9uVa6ouiRxGaGXCyA6x5Fgf1fnH5IIvYxdgD4djuRrWIXChczumJsGdhuFh0
         4ftw==
X-Forwarded-Encrypted: i=1; AKwUvBxSAkhB1WH06XN6rkOiA5dU3/JCjljkfBis2+osIu3Jd3BnBByojndLZduMpfd2CdTnbJV955M=@vger.kernel.org
X-Gm-Message-State: AFuF++noLFqPo0azWHIZIYG3tgjTkbMuy3Xf2FJiAa98JK08T/BcEB4e
	5yN0v7llUc+ASqOZcdIbVp62rI6mS6zQVFGuJ+tZdADcxXjXuyhD9tWF
X-Gm-Gg: AYBFou3ZQLI1qOKEBU0EzgLolAxQk8CWZjLKrXvHZZpigpfxeIotn82yJ2YHgObifz9
	nDFaw6EGf2ziR/F7g62kN3XqKYKtiv7nUImYhki/xcxwOC1G25TZXYEV2nXxKRlCL8yX0cWGhDd
	255jhJF3Q5lxXw84DXEI7z7oOrnSICpD42VCIeCUd6NSY0WJraQ4ng4fTkk8uvFD9mLnW1PRB4v
	tEAr7MNLfRIJoBktV9MeWCmo1u8+nSsMJMsojcEkA+Df2XJztfIg1HD/KzWoerfhGgnr46ihudt
	O8OXNa/lTpdVPr2KokaGzZg40vC6zw7JjHrhc0W2yEcinJ5P/jiPNQYU2IEhtoj04hoL9Gqd7Hn
	eRqQgP5Ax5xgbRoS3IiFSqzdSX1YFUNve64p3kyFp9EYP29CipZTcupT7/TK/PTkqKdkxdbQbPt
	akJD9y2SW0rFX/yA2WzbeCPLEMQzMhW6QEl7mJ63DoFAFQe4/bbNrfwf/CK4830Se1bCr3+4ITL
	FxMvjeXjkVpW7jLtzBulmg1CAWsog0A8WA8DMLFLeRkZqetPHCB0jnLJ8ZNkUwEu8Ktw9xReAE=
X-Received: by 2002:a05:600c:3107:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49ff06e502dmr57684725e9.16.1790360706918;
        Fri, 25 Sep 2026 11:25:06 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm266231245e9.12.2026.09.25.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:25:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v23 6/9] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Fri, 25 Sep 2026 20:24:28 +0200
Message-ID: <20260925182435.21207-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925182435.21207-1-ansuelsmth@gmail.com>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add variant of the MTK TAG for Airoha Switch and comments about difference
between Airoha AN8855 and Mediatek tag bitmap.

Airoha AN8855 doesn't support controlling SA learning and Leaky VLAN
from tag. Although these bits are not used (and even not defined for
Leaky VLAN), it's worth to add comments for these difference to prevent
any kind of regression in the future if ever these bits will be used.

Rework the makefile, config and tag driver to better report to
external tool (like libpcap) the usage of this variant with a dedicated
"Airoha" name.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/net/dsa.h |  2 ++
 net/dsa/Kconfig   | 11 +++++++++++
 net/dsa/Makefile  |  2 +-
 net/dsa/tag_mtk.c | 36 +++++++++++++++++++++++++++++++++---
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..9824c63ad50b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -62,6 +62,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
 #define DSA_TAG_PROTO_KS8995_VALUE		36
+#define DSA_TAG_PROTO_AIROHA_VALUE		37
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -76,6 +77,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
 	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
 	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
+	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
 	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
 	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
 	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4f44bf3ede23..28a249f04a43 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -24,6 +24,13 @@ config NET_DSA_TAG_NONE
 	  Say Y or M if you want to enable support for switches which don't tag
 	  frames over the CPU port.
 
+config NET_DSA_TAG_AIROHA
+	tristate "Tag driver for Airoha switches"
+	select NET_DSA_TAG_MTK_COMMON
+	help
+	  Say Y or M if you want to enable support for tagging frames for
+	  Airoha switches.
+
 config NET_DSA_TAG_AR9331
 	tristate "Tag driver for Atheros AR9331 SoC with built-in switch"
 	help
@@ -104,8 +111,12 @@ config NET_DSA_TAG_MT7628
 	  Say Y or M if you want to enable support for tagging frames for the
 	  switch embedded in the MT7628 SoC.
 
+config NET_DSA_TAG_MTK_COMMON
+	tristate
+
 config NET_DSA_TAG_MTK
 	tristate "Tag driver for Mediatek switches"
+	select NET_DSA_TAG_MTK_COMMON
 	help
 	  Say Y or M if you want to enable support for tagging frames for
 	  Mediatek switches.
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 1f9cc30e9988..7ccaa528a989 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_NET_DSA_TAG_KS8995) += tag_ks8995.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MT7628) += tag_mt7628.o
-obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
+obj-$(CONFIG_NET_DSA_TAG_MTK_COMMON) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
 obj-$(CONFIG_NET_DSA_TAG_NETC) += tag_netc.o
diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index c7dc7731675e..f8087d768da6 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 
 #define MTK_NAME		"mtk"
+#define AIROHA_NAME		"airoha"
 
 #define MTK_HDR_LEN		4
 #define MTK_HDR_XMIT_UNTAGGED		0
@@ -18,6 +19,9 @@
 #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
 #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
 #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
+/* AN8855 doesn't support SA_DIS and Leaky VLAN
+ * control in tag as these bits doesn't exist.
+ */
 #define MTK_HDR_XMIT_SA_DIS		BIT(6)
 
 static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
@@ -99,6 +103,7 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	return skb;
 }
 
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
 static const struct dsa_device_ops mtk_netdev_ops = {
 	.name		= MTK_NAME,
 	.proto		= DSA_TAG_PROTO_MTK,
@@ -107,8 +112,33 @@ static const struct dsa_device_ops mtk_netdev_ops = {
 	.needed_headroom = MTK_HDR_LEN,
 };
 
-MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
-MODULE_LICENSE("GPL");
+DSA_TAG_DRIVER(mtk_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MTK, MTK_NAME);
+#endif
 
-module_dsa_tag_driver(mtk_netdev_ops);
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
+static const struct dsa_device_ops airoha_netdev_ops = {
+	.name		= AIROHA_NAME,
+	.proto		= DSA_TAG_PROTO_AIROHA,
+	.xmit		= mtk_tag_xmit,
+	.rcv		= mtk_tag_rcv,
+	.needed_headroom = MTK_HDR_LEN,
+};
+
+DSA_TAG_DRIVER(airoha_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
+#endif
+
+static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
+	&DSA_TAG_DRIVER_NAME(mtk_netdev_ops),
+#endif
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
+	&DSA_TAG_DRIVER_NAME(airoha_netdev_ops),
+#endif
+};
+
+module_dsa_tag_drivers(dsa_tag_driver_array);
+
+MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
+MODULE_LICENSE("GPL");
-- 
2.55.0

