Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA448662F;
	Wed, 23 Sep 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159997; cv=none; b=gTtf1VLmWuvkaCSH7/7o2miO2cN7DTndaV8lbnHgD5DEwPbJqw5dN3cUrFXSSqY1fvv3Js3PervXsRyXfwhtBie6rXjd7iIx+wc0TOmTwsxlkyNzTJQ2xf8+iwGREbIYfSceelVjqDD2NZJ+jBqtqqDIS8oQeWSDQNMbsLcETjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159997; c=relaxed/simple;
	bh=1JMuIISHrmU9d8EK+gc0TKNfWfwNjBaS+80ZHvx8U4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gd2gyWrJrMv84EgIpNfQoQuhLZsCH0vjASXP1d+Vp9sPTYJuPdXWZqrwLy6ivmZ1R3caoHysxJ7g6jDJkInkJblClv4U8eWpiyhUIMz4gUkyqZ9hCtVZ0UOlpofPwNIof3OCvEMJEpM9MKtr7Cp54zaSWWJRBbY6ND6G9DAtY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OYU2sKQF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZRsGygQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYU2sKQF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZRsGygQ"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xc5fLkyYctlhhIjJAyWMtKYwPSfFQ54G7ushUR2JcOo=;
	b=OYU2sKQFe4CMCDOhIZ+rX91IoVVRk7f460FnkTxur+bBZaLF/E0tXbL0ZSGW6LlJObLBmL
	sJ0ZvTunBlUBGogfEqN2oZQV9+HEJR93Kzr0VrmBJCh7i9ymTld54LuCbbyk8hp5gO4+H4
	EobPSP9bBKKnm82OlglLnsxjlusOUZ8+l6gYbMOxeWGDiBFwNbUBL1q0dnu+V+M7dixvAh
	LAg7QUW3a/lftucDr+EdXxQ6XLCDQrBct+9KVr3GXKWp+Yfd18c9N4f97sre63NDPvi6q2
	f9m9rcYTXVyXAfF8/c2EjkO9QJi12+7nzvHDgDskinUEzgXYRHNW+/1Uc16Adw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xc5fLkyYctlhhIjJAyWMtKYwPSfFQ54G7ushUR2JcOo=;
	b=fZRsGygQAYEczlLkqiliB94mljV57ocZnRSTLjE57drnoqpO/jmPkGpk1pCmws4Yr2sJKZ
	IRJB0FOUOjYpy2Dw==
Date: Wed, 23 Sep 2026 12:39:31 +0200
Subject: [PATCH net-next v3 4/8] net: dsa: Add tag handling for SoC-e
 switches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-4-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

SoC-e switches exchange frames with the conduit using an 8-byte SDSA
header inserted between the source MAC address and the original
EtherType. The header identifies itself with EtherType 0xdcdc and
carries the frame direction and a 10-bit source or destination port.

Add transmit support for FROM_CPU frames and receive support for TO_CPU
frames. Validate the EtherType, frame type, header length, and source
port before accepting received frames.

The SDSA header can also carry an 802.1Q TCI. Encode accelerated VLAN
metadata into the header on transmit and restore it as skb VLAN metadata
on receive.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 include/net/dsa.h  |   2 +
 net/dsa/Kconfig    |   6 ++
 net/dsa/Makefile   |   1 +
 net/dsa/tag_sdsa.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..8287fba8b107 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -62,6 +62,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
 #define DSA_TAG_PROTO_KS8995_VALUE		36
+#define DSA_TAG_PROTO_SDSA_VALUE		37
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -101,6 +102,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
 	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
+	DSA_TAG_PROTO_SDSA		= DSA_TAG_PROTO_SDSA_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4f44bf3ede23..9b299cada316 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -194,6 +194,12 @@ config NET_DSA_TAG_RZN1_A5PSW
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
index 1f9cc30e9988..a4c8d0e6bc0f 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_NET_DSA_TAG_QCA) += tag_qca.o
 obj-$(CONFIG_NET_DSA_TAG_RTL4_A) += tag_rtl4_a.o
 obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
 obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
+obj-$(CONFIG_NET_DSA_TAG_SDSA) += tag_sdsa.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
new file mode 100644
index 000000000000..8cc3fa357be4
--- /dev/null
+++ b/net/dsa/tag_sdsa.c
@@ -0,0 +1,158 @@
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
+#include <linux/if_vlan.h>
+#include <linux/unaligned.h>
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
+	u16 vlan_tci;
+
+	BUILD_BUG_ON(sizeof(*tag) != SDSA_HLEN);
+
+	skb_push(skb, SDSA_HLEN);
+	dsa_alloc_etype_header(skb, SDSA_HLEN);
+
+	tag = dsa_etype_header_pos_tx(skb);
+	tag->ethertype = cpu_to_be16(ETH_P_SDSA);
+	tag->reserved = 0;
+	tag->frame_type_port_hi =
+		FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, SDSA_FRAME_TYPE_FROM_CPU) |
+		FIELD_PREP(SDSA_TAG_PORT_HI_MASK,
+			   dp->index >> SDSA_TAG_PORT_HI_SHIFT);
+	tag->port_lo = FIELD_PREP(SDSA_TAG_PORT_LO_MASK, dp->index);
+	/* SDSA carries no TPID, so only encode 802.1Q C-tags. */
+	if (skb_vlan_tag_present(skb) &&
+	    skb->vlan_proto == htons(ETH_P_8021Q)) {
+		vlan_tci = skb_vlan_tag_get(skb);
+		__vlan_hwaccel_clear_tag(skb);
+		tag->frame_type_port_hi |= SDSA_TAG_VLAN_BIT;
+		tag->vlan = cpu_to_be16(vlan_tci);
+	} else {
+		tag->vlan = 0;
+	}
+
+	return skb;
+}
+
+static struct sk_buff *sdsa_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	enum skb_drop_reason reason;
+	struct sdsa_tag *tag;
+	u16 dummy_vlan_tci;
+	bool vlan_present;
+	int source_port;
+	u16 encap_proto;
+	u8 frame_type;
+	u16 vlan_tci;
+
+	if (unlikely(!pskb_may_pull(skb, SDSA_HLEN))) {
+		reason = SKB_DROP_REASON_HDR_TRUNC;
+		goto out_drop;
+	}
+
+	tag = dsa_etype_header_pos_rx(skb);
+	if (unlikely(be16_to_cpu(tag->ethertype) != ETH_P_SDSA)) {
+		reason = SKB_DROP_REASON_DEV_HDR;
+		goto out_drop;
+	}
+
+	frame_type = FIELD_GET(SDSA_TAG_FRAME_TYPE_MASK,
+			       tag->frame_type_port_hi);
+	if (frame_type != SDSA_FRAME_TYPE_TO_CPU) {
+		reason = SKB_DROP_REASON_DEV_HDR;
+		goto out_drop;
+	}
+
+	vlan_present = tag->frame_type_port_hi & SDSA_TAG_VLAN_BIT;
+	vlan_tci = be16_to_cpu(tag->vlan);
+	encap_proto = get_unaligned_be16((u8 *)tag + SDSA_HLEN);
+
+	source_port = FIELD_GET(SDSA_TAG_PORT_HI_MASK,
+				tag->frame_type_port_hi) <<
+		      SDSA_TAG_PORT_HI_SHIFT;
+	source_port |= FIELD_GET(SDSA_TAG_PORT_LO_MASK, tag->port_lo);
+
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
+	if (!skb->dev) {
+		reason = SKB_DROP_REASON_DEV_HDR;
+		goto out_drop;
+	}
+
+	skb_pull_rcsum(skb, SDSA_HLEN);
+	dsa_strip_etype_header(skb, SDSA_HLEN);
+	if (vlan_present) {
+		if (encap_proto == ETH_P_8021Q) {
+			skb_push_rcsum(skb, ETH_HLEN);
+			skb_reset_mac_header(skb);
+			if (__skb_vlan_pop(skb, &dummy_vlan_tci)) {
+				reason = SKB_DROP_REASON_NOMEM;
+				goto out_drop;
+			}
+			skb_pull_rcsum(skb, ETH_HLEN);
+		}
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+	return skb;
+
+out_drop:
+	kfree_skb_reason(skb, reason);
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

