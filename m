Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E43E4C6B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167287; cv=none; b=c7SkJYnxHQjdcNEbvbbIm4SVynsFItmmENC/NB5GDTlwTVhYWeaHjy7uB9wac+QG1dSInt9ZLBkh7Pc4uP+wpQP4A2w89rQ3fZF74liUYZNRzyK1UT82MbLHLQAPx8uIZRfuIHZ8BLDrJl9fM36dC8jhZi5Nq3leScu1311xvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167287; c=relaxed/simple;
	bh=aHP1f++jAtQs9cpk/bh29ImW3klbKsZSHoGF19kb3q4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tii7P2gAvgLezW22HDXM/dwp763NtveoxOmbFx5nn7zUEBeiVhIwf50ji//c4+FknB0Qhtj75iDqG7WXJrACb8pEy3e0PbgK0VOO+n02sAQpNG10yZg057VWbxUvwahusvLK0CxA6DRqVHz5iCylo2O6bG+TtGD6caH8sM7NN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJVKDN6/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJVKDN6/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so686905e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167284; x=1789772084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Tz2CwjjJhiae7LDEb+iwsLlaTftt3gAWGBis4F4zcg=;
        b=NJVKDN6/QLKsDehObNFwIy+YuoDXWRBbu5mHlO9giiU6nOc6zicbvJh9wv/1TS5OCn
         FCxYHJTMofIAZ2oe03oX+NjHmpH1O51r+Ib1KrdqeHm37j1KWQ03bLH3il2T0Cv/AZL5
         SHv4zjfqgunwPjhOoW3ZgJkSnNgyRy70v7UUuomwWL3bg+FZQh/wXpdqlU5Xuyi6pNry
         UeaXWKO7o0rmF5ZDYci8UEQj2mIE3hxrRxYSLMKcCpfQiIa0DigIyUBHc4jZfkoipLQ3
         IwCau5Ksp+j3cfmNzZx4G4qDzJHdwopteFPaDlKlFaPyD5p9so2m7UEY2NbLyKh6RatO
         JvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167284; x=1789772084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9Tz2CwjjJhiae7LDEb+iwsLlaTftt3gAWGBis4F4zcg=;
        b=CboJ4IfdrtnNyPP+P/dImhkPeJcTXB0M8rKKzlxUW4bgNVGxRxHMxtyfcsgj21rFMF
         /KQQWOp7AcHmeOlnQHmUQsZl0MUbLGIbCGHskH/5fu+xY9KQLUf4Fq0TJDgO9RCZvNE0
         7EmrjClhptWODaBMZlivRwOjjdMg6TbYC2zRBEsFSFY6JKMNlsHq/UmnkCmyBOut3AV8
         LEcsuLxUD0NzN0dcZ3j3h/oVaD9lyYIjEpnX70CQcMj3ETWkkqoyS48OUQHJLZj7yAnz
         zsL5OjMCkEQrXw0qq/d3fQrYRY4hjQ6RFVzm0Bi/9rtt+ky423q9wrzIyb62UsqeKAzz
         SbAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQ3ugXte88R6Mx2889I8Qwvao3cu15yF65rZ2Ram1mzthCv+bZI+thS9cQNNnVxfSqGfQcbiM=@vger.kernel.org
X-Gm-Message-State: AFuF++m18VjYonXbu0E41zYnYyTsYkptwk8SaDL9Wzqf6ThD9adViO5y
	0eZoALzvHZDoD2ZHLTI6ogx5tRCiCcM2KNE7Lg5EnQBdwr8IHebao7S3
X-Gm-Gg: AYBFou1pRrtW9S+DZo1Fo45SH2R2aN4sURi4govSumLlImTngHz/HuaGCPzwyiooA96
	lbRUmDOhpAFanYBgBDOYyWThN3rqaG+qGNyrFT+rgXNlEGJ4TpEfLjNk+hp6VMosUKGlPoRWhJg
	7Y35DxEeGKmAqlpA7cPjR0YDlo8tRqaPh/B5UZ/SKj21Eh2qtQzzOx7VKev2qJmc0RLPcXmFc2w
	0+m1rcWdVl4B3EDWuzZnqXit+erDkkdEsAPKVJyTv0IgF398fbLZWbB4F7VV4kV02brHOe7WoB6
	sBXE+w0ZWd/xv+NRjVpPhVo8YDqhaJ32/9viXIVPiv3KYwgZhHjNcr1i3c96GcfF5Co2/ZH/kz5
	gOTDOliHM8iLePLnlX/D+VS5koJCeIfaKwUlq1Oa6+ED0IwgL8+CDqWyXkkSjcM/wsjzM3gCp2k
	7edbOo0dq5gzF5QbfzgLWwhccaBcGGZfOVLtGjUq7+cykzdKemZVicPZ5y2rgVPkK/w3GJ47v+x
	tQsVWXCRzfEAGlC5y/9dRby2UisqPh0l2qpIULCrLuUYEFHrXZ+mfZNVOIaTEDC
X-Received: by 2002:a05:600c:468e:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49e6cabd4b4mr2149135e9.8.1789167284161;
        Fri, 11 Sep 2026 15:54:44 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e6221ffb0sm77593685e9.3.2026.09.11.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:54:43 -0700 (PDT)
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
Subject: [PATCH net-next v21 6/9] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Sat, 12 Sep 2026 00:53:30 +0200
Message-ID: <20260911225414.225980-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911225414.225980-1-ansuelsmth@gmail.com>
References: <20260911225414.225980-1-ansuelsmth@gmail.com>
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
index 7507d632e7c6..c5659e9ab6d3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -61,6 +61,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_NETC_VALUE		33
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
+#define DSA_TAG_PROTO_AIROHA_VALUE		36
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -75,6 +76,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
 	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
 	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
+	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
 	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
 	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
 	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 23b4b74004ed..07ad0f13416e 100644
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
index d15bcf5c68f0..57739a488a6a 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
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
2.53.0

