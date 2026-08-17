Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5783C8C46
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954859; cv=none; b=bmaqwBVo8tMHkwakwfKsS1dSY6gHp1EEUIHsBLvc1m4YtBZlBpvMLVXSczm+5UThFCLBSGSd0YkrPZmk618LE69TuOlCBZY/LjHztJPP0hHWj0eCr7BjhdZ3EStcxEVfbWu1ZmMzQH30EEvr/daR7zhVX09akZ95fK9uG/hxx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954859; c=relaxed/simple;
	bh=092z8nSVlijhxHSoKIlRJ16ECvURE72HxCMAnX2npH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrQ60FrZy8LhHK0Vy1N3vJBG1b4DDevmzy0815torZMMD019xKz9Agzq5PkrLIChHMs6JN3kSOirhIiJ0jWWXmMLsu56bdv9FhgGDe/hm9bjMPGO3S9hQDRrBw5MM/5UB86j+cDWaGeFv81QEXyJYYTJtzVPbimho3nSudNYUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVmh38Kq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVmh38Kq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4994c49f588so27134745e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954856; x=1787559656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e+Mvy67q6/dC+Gf4rHVcYavXLL8OqK8NuZ1lfl7xWvo=;
        b=SVmh38KqbMxpcbkNE5Y5QT8/eqxUBldkUvLSn8v4HpDQoRhIikaXhwm68wzdsR+hFp
         eDszerNi1/5TmuhLhWi1l/XO2GbuMBBOr6M2Jl4Tvz/ETdrS7LS2MVTZo9IuA7/D+qyx
         0woFdynBId/7OtkwqRHPjflZLuSCjxt+fL7QBU+BCqCNrEHjM0AlwXqwjVBcRcd+MBYT
         h1Qb3ZzQCwSWPb506qaSD5aI97yZ0IiiVVlE0TtjZmYF7/Stdi1rHyM0MK2D2fHShra5
         dlXncpoiQ2LPB8k+G4JWYzUhwU2to/aHWjQhrmE+q9nZqm9Tqf+xHkL/1M83WnYlawiu
         /opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954856; x=1787559656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e+Mvy67q6/dC+Gf4rHVcYavXLL8OqK8NuZ1lfl7xWvo=;
        b=rkvCYCDDWDFPYnl4SUCo2OWtTSSZPf9cNKLkUNjSjDLT99BQuXA64XlC5zP9WAImjZ
         MdXjEUJo/9r2A9YPKwqE6HdLF1yMd8qfKkjnrKEYptG3FZ+QIhoEkYS/9y3VrTWmt9Ym
         mTJYoxMiuJicZ2haVswzvP/PvPt1y/9PD7t96Qf0JJLGr9XI22ELgWQY5cH1Fx7nSRy3
         CmGoefr77Njh0PJiwQwynFYAI4aqADRLsEalxG3092QsVT6zJay8sJFTEghhE39VjSJy
         btTuit8e3IA9D81jvmTs6MJsyHTcver4Td74oRoJg56LE1T8zBbyS9t8s5IxvgTCjybB
         ZFiw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5UvN4+YCunWgLzLmSoRa6owvk/7Kf6SIRHbwS4NjyZynUI5Ur0hTIMKnlsgz4Vnj5uMH5iP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTsTtLFFhVT167ToLkSrZEufGD4mOt+I+1iNgvpBNfXy8ufvz
	HXyAcG/RCif8suOSAlEpiGC6+Dh415Sk+bEOHiwfrOYDxk4a642m7ef1+4oi15ey
X-Gm-Gg: AR+sD13LInMHc6O2LMp8UtuoIuhKfhuDyi8SUcCbEjhJF6PhNUgyLuIHRj2tzOK2FNP
	hqlIllLTyC0A8+pvE5kSpS+1PP4W9N0XYOXl/xpVgdh7l+ZXYxgLCZIypZ604gIuPmgSXXfeUYB
	DFZF4UqU/AFPqcyEuJdn2IqcFL1uVbwR+SkheD+eYI9SOa4lBcPp3EPM+octNLSP3TCWnhAVvOr
	V/lnH7zxnhEeEwaxX5ckmCA7Q1Kw/FzDNazgx+HYvjFteNKfoa4DRC0axN8X4MCTwP7wJ7mLwGm
	UQJlqCMRQo6Qh8h3tx3yQhg0BpfWSdOjGfA28z68Ke/wFgqvPA/BW5xeRC0j0PClTpVdO3bHsHr
	t9EJ9Xt21xpzEGY6l+gUzAjVcvUuR53K4OIwvzw9Max8M7FW81aKScQxpGJpNd/6U2U7pkr4Hww
	PCvhIc5tNyBSaVPHlsEwcD5no2oZfFtH+3RPugSjtPDzmRx4aGjrWg0rkPvvhUUhGfF2zpOBvcQ
	ynI7bjlSdY4+7PSCr5XHUImEWxiHVywNTxdkln+VI8PehiJ9u8Cpdr5
X-Received: by 2002:a05:600c:6749:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-4999a2ef9b6mr62184645e9.2.1786954855688;
        Mon, 17 Aug 2026 01:20:55 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-40-190-175.business.telecomitalia.it. [79.40.190.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm19684195e9.5.2026.08.17.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:20:55 -0700 (PDT)
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
Subject: [PATCH net-next v20 06/10] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Mon, 17 Aug 2026 10:20:28 +0200
Message-ID: <20260817082034.20326-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817082034.20326-1-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com>
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
index 6f7f5c17b532..396c1e520852 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -60,6 +60,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
+#define DSA_TAG_PROTO_AIROHA_VALUE		35
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -74,6 +75,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
 	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
 	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
+	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
 	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
 	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
 	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index d5e725b90d78..510055d7b1f3 100644
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
@@ -98,8 +105,12 @@ config NET_DSA_TAG_EDSA
 	  Say Y or M if you want to enable support for tagging frames for the
 	  Marvell switches which use EtherType DSA headers.
 
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
index b8c2667cd14a..fb8c359d6ef9 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
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
2.53.0

