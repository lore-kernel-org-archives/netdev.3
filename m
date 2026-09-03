Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435D4FECFF;
	Thu,  3 Sep 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459112; cv=none; b=i38RKf7HO4vdmm69NpVMcaPEigJpmd2r14hFSEdTFiBIxNy/meIjsg4a0yNawAQ0Co7pBjb0f6AzKqUkXl0VJXyXiDmzdr2Tn+6Ny+cElVarGUyxTfuTralOFJ/34lHCCpCQcnmxXVLMqc0SSWF+ubUsUv8pB4PPwPuEcgf65so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459112; c=relaxed/simple;
	bh=IhzIkMhFVBRAvWKRGStAF0ZPR5nz6jobNLpWzll85h8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHu9Tnpl9su1iOST8qIIfOj4iw5qs4BOYe/oYdojEluO/wqcsHEUeN5x3so8tMZAEy4nZK3sPvV51OokZGj6EcLQkLwAueh1VqjAMAhS8CKBGHnYXC5Oe5q3O/2g60U637yVxyKYuw3iTiwUf5cAJtqR+63fIerSJIUg8wEwSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6mn/PB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3SM2lG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6mn/PB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3SM2lG/"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788459105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoNMJWHFriw+0cV444Unh9ymreGAqfbDBHFavMleW2U=;
	b=y6mn/PB+K7lJfttjp2YBQTZD03Je0spiEtWMCoGkdGLAT2Uh9QlCZCx11L0pccFV9VSNpy
	7Yo+WL1sbr6yuTHyfrdp1Noxk/S43GZzvFSZptnPb6NZdDn94ig25PIGHACsl0X4sYqpas
	s4gBKQnZSod6vDTfCiQjfzoGIfvgmcaMXqFO0yJ9unxn5KnsAMlDaz9vTrQ64AfRG45W8l
	4h9LFOaCVapQ4L1Yozb6xm1pIu7rdxTglXcrV8LueqhZpD6ZJ5l5tTeSYPl/eu+bd0C26e
	yTBULQFvzjtpLrQn3iKUVIsNgPdPpmt1LSRyxZ9h3+V7kZ7Bumc4/iIzq+6jbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788459105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoNMJWHFriw+0cV444Unh9ymreGAqfbDBHFavMleW2U=;
	b=P3SM2lG/0OnArM0o3aWUI2xloHJi04zs384InTwK2NCDYO/mN8NJkb/rcOeDNYMgGqkgcr
	tEHQEx5UnjdV77Ag==
Date: Thu, 03 Sep 2026 20:11:00 +0200
Subject: [PATCH net-next v2 3/4] net: dsa: Add tag handling for SoC-e
 switches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-devel-vstrassheim-soce-dsa-ml-v2-3-fb0587cb466b@linutronix.de>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

SoC-e switches exchange frames with the conduit using an 8-byte SDSA
header inserted between the source MAC address and the original
EtherType. The header identifies itself with EtherType 0xdcdc and carries
the frame direction and a 10-bit source or destination port.
Add support for both frame types FROM_CPU and TO_CPU.

SDSA VLAN metadata generation could not be tested on the available
switch configuration yet. Leave these fields clear on transmit and
reject receive headers which mark the metadata as valid.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 include/net/dsa.h  |   2 +
 net/dsa/Kconfig    |   6 +++
 net/dsa/Makefile   |   1 +
 net/dsa/tag_sdsa.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7507d632e7c6..cabe9f94788a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -61,6 +61,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_NETC_VALUE		33
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
+#define DSA_TAG_PROTO_SDSA_VALUE		36
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -99,6 +100,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
+	DSA_TAG_PROTO_SDSA		= DSA_TAG_PROTO_SDSA_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 23b4b74004ed..0032ccd3badf 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -188,6 +188,12 @@ config NET_DSA_TAG_RZN1_A5PSW
 	  Renesas RZ/N1 embedded switch that uses an 8 byte tag located after
 	  destination MAC address.
 
+config NET_DSA_TAG_SDSA
+	tristate "Tag driver for SoC-e switches using EtherType SDSA headers"
+	help
+	  Say Y or M if you want to enable support for tagging frames for the
+	  SoC-e switches.
+
 config NET_DSA_TAG_LAN9303
 	tristate "Tag driver for SMSC/Microchip LAN9303 family of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index d15bcf5c68f0..2f31ed0e4626 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_NET_DSA_TAG_QCA) += tag_qca.o
 obj-$(CONFIG_NET_DSA_TAG_RTL4_A) += tag_rtl4_a.o
 obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
 obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
+obj-$(CONFIG_NET_DSA_TAG_SDSA) += tag_sdsa.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
new file mode 100644
index 000000000000..83bccd65b1b1
--- /dev/null
+++ b/net/dsa/tag_sdsa.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#include <linux/bitops.h>
+#include <linux/byteorder/generic.h>
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
+#define SDSA_TAG_PORT_LO_MASK		GENMASK(7, 3)
+#define SDSA_TAG_PORT_HI_SHIFT		5
+#define SDSA_FRAME_TYPE_TO_CPU		0
+#define SDSA_FRAME_TYPE_FROM_CPU	1
+
+struct sdsa_tag {
+	__be16 ethertype;
+	__be16 reserved;
+	u8 frame_type_port_hi;
+	u8 port_lo;
+	__be16 vlan;
+};
+
+static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct sdsa_tag *tag;
+
+	BUILD_BUG_ON(sizeof(*tag) != SDSA_HLEN);
+
+	skb_push(skb, SDSA_HLEN);
+	dsa_alloc_etype_header(skb, SDSA_HLEN);
+
+	/* Construct the FROM_CPU DSA tag. */
+	tag = dsa_etype_header_pos_tx(skb);
+	tag->ethertype = cpu_to_be16(ETH_P_SDSA);
+	tag->reserved = 0;
+	tag->frame_type_port_hi =
+		FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, SDSA_FRAME_TYPE_FROM_CPU) |
+		FIELD_PREP(SDSA_TAG_PORT_HI_MASK,
+			   dp->index >> SDSA_TAG_PORT_HI_SHIFT);
+	tag->port_lo = FIELD_PREP(SDSA_TAG_PORT_LO_MASK, dp->index);
+	tag->vlan = 0;
+
+	return skb;
+}
+
+static struct sk_buff *sdsa_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	struct sdsa_tag *tag;
+	int source_port;
+	u8 frame_type;
+
+	if (unlikely(!pskb_may_pull(skb, SDSA_HLEN)))
+		goto out_drop;
+
+	tag = dsa_etype_header_pos_rx(skb);
+	if (unlikely(tag->ethertype != cpu_to_be16(ETH_P_SDSA)))
+		goto out_drop;
+
+	/* Check that the frame type is TO_CPU. */
+	frame_type = FIELD_GET(SDSA_TAG_FRAME_TYPE_MASK,
+			       tag->frame_type_port_hi);
+	if (frame_type != SDSA_FRAME_TYPE_TO_CPU)
+		goto out_drop;
+
+	/* SDSA VLAN information is not supported. */
+	if (tag->frame_type_port_hi & SDSA_TAG_VLAN_BIT)
+		goto out_drop;
+
+	/* Determine the source port from the two port fields. */
+	source_port = FIELD_GET(SDSA_TAG_PORT_HI_MASK,
+				tag->frame_type_port_hi) <<
+		      SDSA_TAG_PORT_HI_SHIFT;
+	source_port |= FIELD_GET(SDSA_TAG_PORT_LO_MASK, tag->port_lo);
+
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
+	if (!skb->dev)
+		goto out_drop;
+
+	skb_pull_rcsum(skb, SDSA_HLEN);
+	dsa_strip_etype_header(skb, SDSA_HLEN);
+
+	dsa_default_offload_fwd_mark(skb);
+	return skb;
+
+out_drop:
+	kfree_skb(skb);
+	return NULL;
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

