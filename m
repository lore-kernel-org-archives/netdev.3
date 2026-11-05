Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888251;
	b=c/MmxjYP5Gdku8LN6BUlrvdKCob2jXgfzncWcDG/nHdlfMlD+sC3TyFJcPqW1pzNEGJm
	 e8yT4xX3POdETvLi6GLttHKUUoXSr+/3JmukTgBMQeCg3jS3I2N2m7LNmBBzCJTd+8qoq
	 AoHGRbwBUzia7VWRuj3AtGjeAxdSiwS4m6//jaPKfYpsSp5kEJDWKzxUvTo3oPvTxq1v2
	 Vxf9kCbHFajGlLi0t9Py7L5yV4fjfxJxG96YJAkJnDz4Vx8hUONEY+sUjJRT6BkEuVZ2A
	 5X6kxHkSRNlDMhF/HE+GUV4KcQh1KLeejrjpN1ZN0ROPWR3DkYeOhpG9WGQV7lqwt+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888251;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc;
	bh=0ojaU2af7s7k3p1h0/a46ca/TLHHbqoTqMaN6YVck7s=;
	b=YUcsageTqSEkPRf7lnuexpHrLS71mkbc/O8D9prvymP2Z7+zPHMzJpdO9daoMUtEUKgX
	 yQRzB1KXRm7Sztu7+R71Xm8cROyo/rEA0qwjSAfIXs8/owzFuBNhEuMnDzC24BjL4UsgL
	 ra1Qerd2K5w6N1ecnfKTgb1u2KcFJZgAHq22imTyq1ZQ6yw50J+z9+IqK5fjPGqA2KbPe
	 JtyLcl1yO7Zx1GczQAciTHwu5mBPThkjp8UZs1wpge/jD6LfJRATX4sbomSPuZd+d2nZ6
	 fq2Cc0qq6XrtseiicRvAH9kE65UP5EL6i/0/suyOandNb54TvmJRIxNLQpm0fe3VZ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SbYbRhbs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X8DK0AH8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE1606D812;
	Thu,  5 Nov 2026 14:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8FE1606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SbYbRhbs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X8DK0AH8
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793888249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ojaU2af7s7k3p1h0/a46ca/TLHHbqoTqMaN6YVck7s=;
	b=SbYbRhbsoPfBSUgmr6/RJgdXLwaDVJRfUWPP3HcrFRrczlPaUwtnTOq5CWG3L9q1OmIHGZ
	R3tRbeZx6OS2DOPoL/A3+6SIWzkqdiSKsIs/DSRMOyAYW7WWefsmcX23om2R1O8ldxFgaf
	nuMpyuyfab+8jrJUpk3oHZ530fJBtdLZusyc/5fp51eixvpaXd+gvZyyM7Had2QhbDBt1Z
	9sWQ90LSIM5oYwIJHD5k5D7VAyQwzJqc17JWIXMNcqMVQI5yRC8aOWUugbnFU5CrBsJi/v
	i5TO8WleyRNHiO6k9EAjKWe54qgUG+Xdk+0zxLrnoOJctcKEacqdH7+QnGMApg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793888249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ojaU2af7s7k3p1h0/a46ca/TLHHbqoTqMaN6YVck7s=;
	b=X8DK0AH8eVxn/qIkEYPnM6fy/A3zz1ERTgel2B4vb3f1mlSwSwIcsbifUuNSbhSjc5+Lf7
	6mbVkty8+1psaUBA==
Date: Thu, 05 Nov 2026 15:16:49 +0100
Subject: [PATCH net-next v4 5/8] net: dsa: Add tag handling for SoC-e
 switches
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-devel-vstrassheim-soce-dsa-ml-v4-5-02f3cde2afa1@linutronix.de>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
In-Reply-To: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Lee Jones <lee@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, mfd@lists.linux.dev, 
 Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>

SoC-e switches exchange frames with the conduit using an 8-byte SDSA
header inserted between the source MAC address and the original
EtherType. The header identifies itself with EtherType 0xdcdc and
carries the frame direction and a 10-bit source or destination port.

Add transmit support for FROM_CPU frames and receive support for TO_CPU
frames. Validate the EtherType, frame type, header length, and source
port before accepting received frames.

The SDSA header can also carry an 802.1Q TCI. Encode
hardware-accelerated 802.1Q VLAN metadata into this field on transmit
and clear the skb VLAN metadata to prevent subsequent VLAN insertion by
the conduit.

Leave existing in-band VLAN headers in the encapsulated frame, after the
SDSA header. Whether an 802.1Q tag reaches the tagger as accelerated
metadata or an in-band header depends on the VLAN TX features inherited
from the conduit.

Since SDSA carries no TPID, move accelerated tags with other VLAN
protocols into the frame before inserting the SDSA header. On receive,
the switch keeps an ingress 802.1Q header in the frame and duplicates
its TCI in the SDSA header. Drop the in-band copy and restore the TCI as
accelerated 802.1Q metadata.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 include/net/dsa.h  |   2 +
 net/dsa/Kconfig    |   6 ++
 net/dsa/Makefile   |   1 +
 net/dsa/tag_sdsa.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)

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
index 000000000000..dcfa5de0ac6b
--- /dev/null
+++ b/net/dsa/tag_sdsa.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#include <linux/bitfield.h>
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
+	bool encode_vlan;
+	bool tag_present;
+	u16 vlan_tci;
+
+	BUILD_BUG_ON(sizeof(*tag) != SDSA_HLEN);
+
+	/* SDSA carries no TPID, so only encode 802.1Q C-tags. */
+	tag_present = skb_vlan_tag_present(skb);
+	encode_vlan = tag_present && skb->vlan_proto == htons(ETH_P_8021Q);
+	/* Prevent the conduit from inserting a VLAN header ahead of SDSA. */
+	if (tag_present && !encode_vlan) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			return NULL;
+	}
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
+	if (encode_vlan) {
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
+	reason = pskb_may_pull_reason(skb, SDSA_HLEN);
+	if (unlikely(reason != SKB_NOT_DROPPED_YET))
+		goto out_drop;
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
+		/* The in-band tag duplicates the TCI carried in SDSA. */
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

