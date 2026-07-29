Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AA4C900A;
	Wed, 29 Jul 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343073; cv=none; b=dRGSE3DgJPOC+1+WWzLPt4RNQn3Ot2l0GQRcTZiZeUunVtsKJVfASrx0HTsPs9IBi9aSAfJUt/iwZh+Znf/iCB4YJTlch0/Q8fSysWvL75gmwWaxXh/t4Z2EPXtbJF+m3iyzC5NEDzVW3FaBuIKk0kwksxtxvGPJ7kUca6YlS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343073; c=relaxed/simple;
	bh=r5bZOrn3pbMQ+Nnfs8WnRpghq+Dm2sqFQLYNMlmC9z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpv7IeLphohTIauiReU7ZRFghJHgSks3tFkEQmIGSOJP8TvtgHbrB3yXnuXnbt6UnhL26/x7SNZ1im33otpodzOkcQgIqkWOscbLDd9jzhZiYsrSVqkhfjqViPHPZbiqX/T0dYB3P9hdXbRticnZYRLsnfz+x+4+zcMlkoxvyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nA7YEuMo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3INchAlY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nA7YEuMo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3INchAlY"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785343066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDDVLWzzb1dep9cMJQx0EWCjVnpAQOthC9yi9bbzIi8=;
	b=nA7YEuMotw7zW+lxQi1etUhCRT5B6uwjSmsa4tFJkAjKYawC9CXPqfqbl7fS4W06pd9ljT
	3g1DXiPBY4qibn9IV7xrFmf6vtuSuNArGshFyrVN1jBDfI+ZzvmDCAUxL6vJJFEqFIeCpq
	zagtQEKZnWARBU80nd7JkdHw3K4K2S+6R/OhR4KRHRplCFxPSxYSehEmk1LgNTNODCKIxa
	+A1pJV12gRbCLD6jTWNULbCexKejS2UpE8yPUybV2jEPFYsfyO6oImn5gzBp90ot9Xohy6
	5pKcwdGgatSJvT/z7O8Kvx4OcjlYeyjYP/JdSaQ75peeRxG/5sFZBkc0DNeU0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785343066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDDVLWzzb1dep9cMJQx0EWCjVnpAQOthC9yi9bbzIi8=;
	b=3INchAlY/Tf1sJrdPUGibXKjev2zPapUMMWHnpKezClBQvUzP79UtV2sncvW7bJmx6RoFQ
	TtZWbg/LX5vKT1Cg==
Date: Wed, 29 Jul 2026 18:36:56 +0200
Subject: [PATCH 3/4] net: dsa: Add support for SoC-e SDSA tags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-devel-vstrassheim-soce-dsa-ml-v1-3-be569dae1b20@linutronix.de>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add a DSA tagger for the SoC-e SDSA header format used between
the conduit and SoC-e switch ports.

The implementation adds TX tag insertion and RX tag parsing and
registers a new DSA tag protocol.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 include/net/dsa.h  |   2 ++
 net/dsa/Kconfig    |   6 ++++
 net/dsa/Makefile   |   1 +
 net/dsa/tag_sdsa.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc10..744bbb4d54ea 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -59,6 +59,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
+#define DSA_TAG_PROTO_SDSA_VALUE		34
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -95,6 +96,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
+	DSA_TAG_PROTO_SDSA		= DSA_TAG_PROTO_SDSA_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index d5e725b90d78..1e1b0f2fb726 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
 	  Say Y or M if you want to enable support for tagging frames for the
 	  Marvell switches which use EtherType DSA headers.
 
+config NET_DSA_TAG_SDSA
+	tristate "Tag driver for SoC-e switches using EtherType SDSA headers"
+	help
+	  Say Y or M if you want to enable support for tagging frames for the
+	  SoC-e switches.
+
 config NET_DSA_TAG_MTK
 	tristate "Tag driver for Mediatek switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index b8c2667cd14a..dc154f10e0a0 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -23,6 +23,7 @@ dsa_core-y += \
 obj-$(CONFIG_NET_DSA_TAG_AR9331) += tag_ar9331.o
 obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) += tag_brcm.o
 obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) += tag_dsa.o
+obj-$(CONFIG_NET_DSA_TAG_SDSA) += tag_sdsa.o
 obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
new file mode 100644
index 000000000000..b32dca1e367c
--- /dev/null
+++ b/net/dsa/tag_sdsa.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#include <linux/bitops.h>
+#include <linux/etherdevice.h>
+
+#include "tag.h"
+
+#define SDSA_HLEN	8
+
+#define SDSA_NAME	"sdsa"
+#define ETH_P_SDSA	0xDCDC
+
+/* SDSA tag byte layout (after the 12-byte MAC header):
+ * Bytes 0-1: SDSA EtherType (0xDCDC)
+ * Bytes 2-3: Reserved
+ * Byte 4:    Frame type (bits 7-6), VLAN-info bit (bit 5), port[9:5] (bits 4-0)
+ * Byte 5:    Port[4:0] (bits 7-3)
+ * Bytes 6-7: PCP (bits 7-5) / CFI (bit 4) / VID (bits 3-0 + byte 7), only
+ *            meaningful when the VLAN-info bit is set.
+ */
+#define SDSA_TAG_FRAME_TYPE_MASK	GENMASK(7, 6)
+#define SDSA_TAG_VLAN_BIT		BIT(5)
+#define SDSA_TAG_PORT_HI_MASK		GENMASK(4, 0)
+#define SDSA_TAG_PORT_MASK		GENMASK(7, 3)
+
+static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	u8 *sdsa_header;
+
+	if (skb_cow_head(skb, SDSA_HLEN) < 0)
+		return NULL;
+
+	skb_push(skb, SDSA_HLEN);
+	dsa_alloc_etype_header(skb, SDSA_HLEN);
+
+	/* Construct the FROM_CPU DSA tag. */
+	sdsa_header = dsa_etype_header_pos_tx(skb);
+	sdsa_header[0] = (ETH_P_SDSA >> 8) & 0xff;
+	sdsa_header[1] = ETH_P_SDSA & 0xff;
+	sdsa_header[2] = 0x00; /* reserved */
+	sdsa_header[3] = 0x00; /* reserved */
+	sdsa_header[4] = FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, 1) |
+			 FIELD_PREP(SDSA_TAG_PORT_HI_MASK, dp->index >> 5);
+	sdsa_header[5] = FIELD_PREP(SDSA_TAG_PORT_MASK, dp->index);
+	sdsa_header[6] = 0x00; /* VLAN not supported */
+	sdsa_header[7] = 0x00; /* VLAN not supported */
+
+	return skb;
+}
+
+static struct sk_buff *sdsa_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	u8 *sdsa_header;
+	int source_port;
+	u8 frame_type;
+
+	if (unlikely(!pskb_may_pull(skb, SDSA_HLEN)))
+		return NULL;
+
+	sdsa_header = dsa_etype_header_pos_rx(skb);
+
+	/* Check that the frame type is TO_CPU. */
+	frame_type = FIELD_GET(SDSA_TAG_FRAME_TYPE_MASK, sdsa_header[4]);
+	if (frame_type != 0)
+		return NULL;
+
+	/* VLAN-tagged traffic is intentionally unsupported yet. */
+	if (sdsa_header[4] & SDSA_TAG_VLAN_BIT)
+		return NULL;
+
+	/* Determine the source port from the two port fields. */
+	source_port = ((sdsa_header[4] & 0x1f) << 5) |
+		      ((sdsa_header[5] & 0xf8) >> 3);
+
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
+	if (!skb->dev)
+		return NULL;
+
+	skb_pull_rcsum(skb, SDSA_HLEN);
+	dsa_strip_etype_header(skb, SDSA_HLEN);
+
+	dsa_default_offload_fwd_mark(skb);
+	return skb;
+}
+
+static const struct dsa_device_ops sdsa_netdev_ops = {
+	.name = SDSA_NAME,
+	.proto = DSA_TAG_PROTO_SDSA,
+	.xmit = sdsa_xmit,
+	.rcv = sdsa_rcv,
+	.needed_headroom = SDSA_HLEN,
+};
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DSA tag driver for SoC-e SDSA protocol");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_SDSA, SDSA_NAME);
+
+module_dsa_tag_driver(sdsa_netdev_ops);

-- 
2.39.5

