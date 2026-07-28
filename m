Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43043A7F1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253768; cv=none; b=XBdTP/EpowuubmIUbsQQzvjHMiV9ESh0gZ70HO0M6aNZ2iWLjKAGDsYenset+bDKrCFRjqQE5yGTC2PRqxgA4pIYP88xavtpgvB3+0sm9GxIjTDEtU6s9YbK5d4DHGeHH02gEj7V0Mq8ryOUrjAsLnohnkZrb+CSMI/8LWdgjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253768; c=relaxed/simple;
	bh=HtxPwbJhALSR6gxEmmq3KN2FA8fvMBnYu1DhX2mxpHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpRMuXdPzGcz3LFhZQoLj02M+bftP5Sas7gC4DyxhQSA24+rI/4hRzWt/hLH7U9w1ueuB9Ph90Bn5itjaOcF5w4LW/y4w3XfY3/fhdKoQO3I1rCosIr1BRCXlC2IuMOAx/zQ8RfW9OTyMsKpKL0+u9QN5fdj3ixKd/IBUGiSx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAFgdoXs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAFgdoXs"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-496b7622a83so21277665e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253765; x=1785858565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fyT8pu9DDCRukEU+gkGjHTZrhqI/Cex3ciHiNAV4A3I=;
        b=FAFgdoXs6SXp4HYAXIkJljyUze7dPT1p1lyyalgqOzdcnpRhFQcYIYv3lmehFbr8ud
         VtcnmBI8IH/5p7svL8EWTqfgDT5rTpF825XUXhtSpqosYsoKprQ9KZzCp3cLmh1u/r3h
         0CXrNerINbkmq2plYk62o6zGCthMECtUDs5bUMv5RfC+mhRxP3jdFt+URa9GJ1uZq0Sc
         UC5JWl3iufbIS+M0q9MlmbIBAi8XpExMbDTgtaCc26tQaP3fJJbPOIrRWln7LRAnVwIq
         mW0W/Lpv77SmulNt8A5/181mq+CXkmrdWLLLsHrS9HgjRvAAvsdMD6bkJnya8udvX9g4
         6bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253765; x=1785858565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fyT8pu9DDCRukEU+gkGjHTZrhqI/Cex3ciHiNAV4A3I=;
        b=bq38/C4hEMDWQ2tZea3C+nuE0zwR81lYNYjeh8zkn8s6TvvAbtYZSGGdJNLlYQ/Wv0
         5ysnRE0qpjlyYNMfFxVpZ+T8xQUcCFni41KtU1Xxsi9/HM2CZFvW3weUriSCD1rrB05/
         ayMhEg4Zza7ZOy6mj1q0YxEjxBktWZflhX8Zx5H0Cctsf9V3rGmo1NJjIkEA83N3yaoE
         yQQs5TKVJeKP0U0qKFJehk/0T7eiw89Ve/lXZAduhNUA2H1ZZ0+jq0gKMivlLIbYfpOp
         wpiORVTfAGTtlZKC66hpg1VJUelOM0DjziHZR1KKID7WE5E83xXFWQov49im4fWBsoRA
         1+Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpKv59PR1M2Z2p5aeZa2ZcjPHEb42ZKvLLHwv61GDmWycroLvCJSnaliRzqsRTnaxyUdht93pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMtfxs5fr/sKqh4kqrVU/sxoNP2UArnBv8EgAYrjLGSjivBQH
	Cu01abP0YO52ASFQRXXCMzyeDQz6DkcOsdtL4cci3QMDDDBnLU2ZPPnH
X-Gm-Gg: AR+sD10Dx39KZvCQluwyEGKSM8mq08VOhqA8M8KbTWp65UI5qMNQ+Uyxmu/ImwvPjR8
	/RNwMBJ3Sg0++BLjEiws0Y5sD9TRYwv1ORmtOvqmqDmTdfk1Oaiyd8rIGOW+mfQMF9tnOzbMCHH
	VgaKxgYVgRWPNEunBHOoxLrgfvclMkUuD/nddMUXJimgweCksDsF2u3iR6vV+zjL7lhrGwu9QA9
	vV6YRXgur8Zb2TVd4RzOdoYG1TaGaxlQ7smzHscKeAxVAAMMzZtLyhLoLxHXyXh+INb33tkFnVp
	ZxPTJwd3HtLFAMSRVkRDVgiD1/Y1Zeq3Yx3SHksqYrbvY8LQRoVx6V8++FxVBUwTQ4rolxCSKHx
	5BfNAjC+oke3EeqOnBtQ+6tB/Rzy8mPp9Ako3AyRHVmfsgman1Xh7e7fWPQ0WZ2wy6Wof3nGCk3
	RruwQeKoQlH0bGcjb3cq4WzZTtR30N
X-Received: by 2002:a05:600c:4703:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-496c6565dfamr38085465e9.25.1785253764634;
        Tue, 28 Jul 2026 08:49:24 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([37.161.95.51])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm94912035e9.15.2026.07.28.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:49:24 -0700 (PDT)
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
Subject: [PATCH net-next v19 06/10] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Tue, 28 Jul 2026 17:48:33 +0200
Message-ID: <20260728154846.1828945-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
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
index 8c16ef23cc10..9957443e2907 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -59,6 +59,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
+#define DSA_TAG_PROTO_AIROHA_VALUE		34
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -73,6 +74,7 @@ enum dsa_tag_protocol {
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

