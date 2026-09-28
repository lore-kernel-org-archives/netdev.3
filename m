Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148E4F93A0
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624771; cv=none; b=UnuP7Eu1JWyKpilWs640tRFXfH4B3u5qNeFf/T5W+xccrpxUuP3sNkOpr4HkJmm+hQw69KO8TIjZ+IIUs84bRLSMvWB3tJ9E6pQuAHQHWP72/FWKp0vS3QywtvbXacUblTf0JfXn4bAOox6wblQtsR5NMOzrpiTnJ3/ayxD+WFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624771; c=relaxed/simple;
	bh=NU4X2VJGcjl2rlOCjM4L+p3D3tqMARtIFAjlFc9hBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaD+2cCzKBJy+Y1wGkBVq1ZTkrzdOeIhVmQWZ8cWAos12whcaa1rv6T3lRf9vfiMsGREAxT0audXQnsL85IoQLIIsdWgSMby97yiVPYgpVWv1N20OZjM1amLAt5oC1NNhQEe5aAXRLW0mB+2cTosu5+E1q1iKLw9gpfSfOuhc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcHX69n7; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcHX69n7"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dc83so2927805f8f.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790624768; x=1791229568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbIAcFETs7Fo7Fiw9hweWROaB2K6gpG5L37UCuTLIIU=;
        b=RcHX69n733uV9vC1Ky+L+Rql0JjOeAqvo+AYnaGHnOY0ZTcHnGj25T7HjlEGPj5jpl
         RN/o7Uz0+iy3wXjlBmD4r3JiDiyvrUOXcXpoCjTQF1A1MHP/JOFnuBTRhpqR0eWGDpG/
         h3oV6g/lZrI5wpHsLk8mQ9PtvJU5S90Pu1SpYxF4o3It863Gn4QyZ7sm4FKXFwDLfTQ3
         WsmijOdlnEV6zNs29byfGwjSDp6QXFB7F5P3uZqY+vN+LDe/YX4uW3ap82f8r7p90Ale
         S04QaCwH1ZVNTW1yBrIkJhqpl70M5Vp1v0E7RMOLDaIYa7rqW2p1FT6XQdlk8iOohJa9
         ttDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624768; x=1791229568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbIAcFETs7Fo7Fiw9hweWROaB2K6gpG5L37UCuTLIIU=;
        b=T6z05JbsdNp/5c7ZnJthvLF/2wPQWG13tmqCkx6cfhwyGdZLqEndGjiw0RJNECP+mv
         t6EOarUbvfiKIMMlqJhLIOIiVibTxzqJH+3fQCQ8K4vZvcuRzUVWewX8qvfY1cPZhuWS
         JjlxIyYbDVUdpG0DWZ+B7VLkuFPBs7X9E67cxBuFvn3UH30P8eX72/EipN9djGMkl7w7
         NrMu3/k6ym1wGUPjumCzAxWc48AfbSOCovKQ0WbqhJ+lbAXgO5OFli8TWDziJS+YuLMw
         +zz9fu3t3D6sPzlJMEWQEvTjWqJVCnGI/vLJci9E5MMeW7v9acdGZ7FmpLqAtgnvCT1U
         kWlw==
X-Forwarded-Encrypted: i=1; AKwUvBzt+WwTww/iHvJDBxJRgcoMcgA3jC3MQbIlPByzlmFuyI6YP5xhQYZeSyNK15IwwOgXzoqR1fw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCx/zgRZiqTU/QE6lI5iCSo7sWoD0nUY9g/YfUtRUl3y/V9uLj
	5oQaB+lbSIGwAZRExQ/i5rqCkbD4LOjUtcatRpb7i1k1HoLi/T1LWGYQ
X-Gm-Gg: AYBFou2Bs58QiA+Xg11FpiU/PaxxjMmd4Ji8ifyMlF1V1ev5JKnn4y5y0vocH/0bzFx
	3ICjFH9xc9N2dk0cS+hGty1sBzXosQePo5B7GxFqAn/HvRg5BvNG/OPwV2DhxPyp4BOXNUg5oMP
	JaUuJBKhKNbeQlswYR1OLuzLnRu8KOtqNVNnbTm9GeUt5lLymVVchZHLu9hAv1qN+xlxR27WJ2m
	vJjuLI4su39tKC/eega+dv7O280QEf0Ig8HyZPYETsS7Abkj7ITnha948wAMd7zFBBH3Y07/AIU
	rrk3IS3V9jQ+1V0py1QVfK+TLkzieo0pJMeoSW0avS90rKugs6/c4BEiQOpQ0vjCtp1wuvvUBCE
	rN88MKfOK/M2/d/rkBnU6mGCmm1fvYzXkb8PgMpwkwNxO2gQjpNzXWsoEMcUy20jeza9vA+xu0p
	4qPcXsXf9+0bJ+wVeswLw/4PVb41hA6w1PYO4M8AxyxOxY5gn811mf7xueRwGFpEKPVS/oHKJdI
	A3HoIc+kAJky10W+Aa5eWIDF9uwBdGHEsSnnULf06sIe0G5aWRyMmVnkss+/rj5
X-Received: by 2002:a05:6000:40d9:b0:487:342:d148 with SMTP id ffacd0b85a97d-48872ac7199mr23494967f8f.38.1790624767700;
        Mon, 28 Sep 2026 12:46:07 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48af071532dsm1527706f8f.20.2026.09.28.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:46:07 -0700 (PDT)
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
	Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v24 06/10] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Mon, 28 Sep 2026 21:45:05 +0200
Message-ID: <20260928194511.41878-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928194511.41878-1-ansuelsmth@gmail.com>
References: <20260928194511.41878-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

