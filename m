Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2124A3D4E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475920; cv=none; b=AacplLw029RF/mTvSW8yupgMQN5onCUTVF7V8AXUlz1y5F0/ghD/QQEGAoeJbyiOaV9wx/h3n46BEEh6C6beIgsQGMi6UaropYCHGwsy7zDOLItVJ15M5nHdSDK0sA56gGFe5O0QoAZqXwaBL6+/HT9bYKHklo7+dt5ntxKQTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475920; c=relaxed/simple;
	bh=aHP1f++jAtQs9cpk/bh29ImW3klbKsZSHoGF19kb3q4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccfuubMZRzknag2N6i4IsHrrgEUTCbTuafsb7o0ZhzKHwyrsEVFc/8zKT4Hs+QWmrabOgMGtjjJrLV8L3ihCu73qKQfRfAjXhRJ3dEf2ONaFDmJFA7OHaD0rY5kOUwP19txRHJlmuU6gPFfHTU2XPsYrT1chMfd5fZ/eXXt0UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfsytOPh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfsytOPh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso30190245e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475915; x=1790080715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Tz2CwjjJhiae7LDEb+iwsLlaTftt3gAWGBis4F4zcg=;
        b=SfsytOPhDbNVNvhXdfbsz0BZq9r0AUKroVMHmAyJjDJ2gos8pRz03Zk2nxStX1LlG0
         WCEKUsr36RXvIpwtLLDj2VhJ9e2umaPGuDX7bM93V0lvfXbRAR3qptGutrAs5i9Yl/xF
         HMxBr7Ci8HT4Dprg2vOi0KGhS3J15TGRUF66oc28Iu+qMn+mMurvaBXHUnKlUrb/wc0Z
         HIyLZfg1QC4bk2wBs5A1bmW9gajR/AJTW9XObcDV9v5Od2/5HJcQzNrhj4mtzYsSwjRE
         Wzspl6goih+2qPtSXmD0Y5mHIZPOj7gLhIQk2KNSGXcgS9QoVt2QYbzs12KZzBAB5kXO
         XP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475915; x=1790080715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9Tz2CwjjJhiae7LDEb+iwsLlaTftt3gAWGBis4F4zcg=;
        b=TfJAFTkpbhV0r/rvBPAs48PtpFUB/EsZyUTjdokV7E3W7aFwm+xRaaD+KeY7RH+W8f
         a7mpKT2mFoA6gtHxgQFOH0pUz1DTS5O46EfjNKy3RQKD3xJSoFGGJzwy97gI0VwC+qre
         LAjSzyoAjuIi21+3OUGIuEz2/20VTRs8YZun7ObqN3j3nlhd4hP5jDoTtzaVjbZ7v0v3
         7NpfEc5retFHeviKgPJ6QiYH5jmCS0bHsoDdM3IZdHf2qgjwuRGlDwYZOdtGbuLhUptp
         PprAnk/vSp1wb33TOU/Dng+8Ak/IgrvRBL2/vDaXbqS5688fG6GPK9u7k5jAGxFXQ+6l
         bTZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJY7ehgJ5BnAJ6k3R3rUfCQeOpAbjwthr0xjJKDnbxN1Bu0n7Ng8looOraqJ+nbFOI2ZG+3Lo=@vger.kernel.org
X-Gm-Message-State: AFuF++l+AkeT00+RYqH/jvOpqu0LaWO/JVhWZEP34EXqyJU9OGo0veXk
	UgijvmX5V5/t+VlSpAU6yshmdi/YJmJPM6nd6+s9KqwwcjcI6HB2OMCl
X-Gm-Gg: AYBFou31ArBXlKXyPiNxCLRqs2kkjqxmxa3a7rW+NNHYXCbMsV9R+rMKfAUJE49yq1O
	VIC8JK88C9owwhgvVKVZdQBSKXTQhzv/m/YZVlvchih3rWxFifHZfQC1f3IL9dFzehrvulvJxzX
	fnf3eYoJv+53dpoTAJGK7VbsxqLQXPUmcwXFhaTivssJlLD/HhJYqUDPwRp2lXHgPqhDD39Be5e
	CDedyVqQHvtY6B8JdPvv53bQTvbw4wUg2IHcdzzncyer9BsSLE/JU1A9MkhYZwzeH81ItxmmbGe
	e7ZeaFdEPP7EzSJdkGbVZ5khPLVlBA0wMmTbSzFCxdxMca37/WFRt2b+yZieCCdI4eMf2gTW7el
	n2Z0Tshbn6zvorGHikbJTqr2MyZGfAO6pDuxmgvPCHqhEUI8g7Im9Pyt2V07lJzSdiDsamfuly3
	xZC/iPy4F8iJAJ4g96+olrVkMWsYo/slfXlrd0JZ5E+nkLLnSzXE46eu8HMML1ANntEN3MHjtQS
	3d7MGodxby/31SBqkL6nfhsRSzUOs7J4WPB2AbXuLPR0PttxqN4WCggE9QOkq4v
X-Received: by 2002:a05:600c:4e90:b0:49e:73e7:888c with SMTP id 5b1f17b1804b1-49e7a65ce45mr95145365e9.4.1789475915466;
        Tue, 15 Sep 2026 05:38:35 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm62958635e9.9.2026.09.15.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:38:35 -0700 (PDT)
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
Subject: [PATCH net-next v22 6/9] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Tue, 15 Sep 2026 14:38:03 +0200
Message-ID: <20260915123812.14747-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915123812.14747-1-ansuelsmth@gmail.com>
References: <20260915123812.14747-1-ansuelsmth@gmail.com>
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

