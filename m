Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F671DF980;
	Mon, 31 Aug 2026 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209681; cv=none; b=haGAdXYCNn+xfKURHAc8Hs939jxzEGoSEIVWLYzQ60vDCUv0qEp72Gq1a2BmhOvfHkFtOZQqCE9LX0Y6Xv6xPCfOzKBAKHyqixM/N5/e/ll22TpeonxaVBl8Xs294BXV3MN4Kv/2x26a8Voi9SXtn9kZKqdjSvHH0wmyxb5t1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209681; c=relaxed/simple;
	bh=faOGrfM+mRxHv3OlG4CVb+omASgKG/OW+Le2mIkyGtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCEzbELywPmrY8mfkWxjeii1rH7lJSjIAa8IbqDtj0GxT0Op8dth+M3jdu8fWqIZE81+YIipfs/qsc3XSqIRvHuxkNp4blU8h1YvONzLOcYsSppxMUZZ/YMeQgcpVw8K+Ih6pSKGGtqF3YKOguaLNY9ED76oiHOE1I3r5V9UwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRdP5Mwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRdP5Mwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F96E1F00A3D;
	Mon, 31 Aug 2026 20:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209679;
	bh=kGQvOFm6Vy2hQSGrbr/PJi7PpB4Q2L3PvPzQOVjdI1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QRdP5MwoSHAznaddn9dMsvBRlgjeA/uZriRQingBq7felVK8Lfvy1tVefa5mBstPJ
	 de5y3mWdV/39xNpbcTU7GeSij0fGO8TzrXDJn+NR8xBKgvJB0pqYEKlwsvDETTNB5D
	 ++2pRAW/1+9/1kpLJ39TuNGU1YsFy+1KEQ6nAbe7F//2MaF2vG3fHIgbugbBX8JFSG
	 eZXtY16M72ufrI9usLT/hplURanz0/3+PQ/7lSEdEnpPBix55I6dwlFeMO+KJeIvuR
	 4pwJ67VDxZH+jujV7DDP6wJJATZgDXbJlHmMt2vDbiEM4rUtaqeR+lkICR6AS6IlkP
	 O0GJq9lV+9H+g==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 31 Aug 2026 22:54:19 +0200
Subject: [PATCH net-next v8 3/5] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ks8995-to-ksz8-v8-3-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The KS8995 100Mbit switch can do proper DSA per-port tagging
with the proper set-up. This adds the code to handle ingress
and egress KS8995 tags.

The tag is a modified 0x8100 ethertype tag where a bit in the
last nybble is set for each target port.

Push any hardware-accelerated VLAN tag into the packet before adding the
switch tag. This keeps the switch tag at offset 12 for non-802.1Q tags
such as 802.1ad.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS          |   1 +
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_ks8995.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..7fabc2eae9af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17776,6 +17776,7 @@ F:	Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
 F:	drivers/net/dsa/microchip/*
 F:	include/linux/dsa/ksz_common.h
 F:	include/linux/platform_data/microchip-ksz.h
+F:	net/dsa/tag_ks8995.c
 F:	net/dsa/tag_ksz.c
 
 MICROCHIP LAN743X ETHERNET DRIVER
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7507d632e7c6..5d12191b6f6f 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -61,6 +61,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_NETC_VALUE		33
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
+#define DSA_TAG_PROTO_KS8995_VALUE		36
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -99,6 +100,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
+	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 23b4b74004ed..4f44bf3ede23 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -125,6 +125,12 @@ config NET_DSA_TAG_MXL_GSW1XX
 	  Say Y or M if you want to enable support for tagging frames for
 	  MaxLinear GSW1xx switches.
 
+config NET_DSA_TAG_KS8995
+	tristate "Tag driver for Micrel KS8995 switch"
+	help
+	  Say Y if you want to enable support for tagging frames for the
+	  Micrel KS8995 switch.
+
 config NET_DSA_TAG_KSZ
 	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index d15bcf5c68f0..1f9cc30e9988 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) += tag_brcm.o
 obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) += tag_dsa.o
 obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
+obj-$(CONFIG_NET_DSA_TAG_KS8995) += tag_ks8995.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MT7628) += tag_mt7628.o
diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
new file mode 100644
index 000000000000..6bd5f1015c26
--- /dev/null
+++ b/net/dsa/tag_ks8995.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Linus Walleij <linusw@kernel.org>
+ */
+#include <linux/etherdevice.h>
+#include <linux/log2.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "tag.h"
+
+/* The Micrel KS8995XA / Microchip KSZ8995XA Special Tag Packet ID (STPID)
+ * pushes its tag in a modified VLAN (802.1Q) tag.
+ * -----------------------------------------------------------
+ * | MAC DA | MAC SA | 2 bytes tag | 2 bytes TCI | EtherType |
+ * -----------------------------------------------------------
+ * The tag is: 0x8100 |= BIT(port), ports 0,1,2,3
+ */
+
+#define KS8995_NAME "ks8995"
+
+#define KS8995M_STPID_STD	GENMASK(15, 4)
+#define KS8995M_STPID_PORTMASK	GENMASK(3, 0)
+#define KS8995M_STPID(portmask)	htons(ETH_P_8021Q | FIELD_PREP(KS8995M_STPID_PORTMASK, portmask))
+
+static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vlan_ethhdr *hdr;
+	u16 portmask;
+
+	/* Prepare the special KS8995 tags */
+	portmask = dsa_xmit_port_mask(skb, dev);
+
+	/* The switch expects the special tag at offset 12. Move any hardware
+	 * accelerated VLAN tag into the payload so the conduit cannot insert
+	 * it outside the special tag.
+	 */
+	if (unlikely(skb_vlan_tag_present(skb))) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			return NULL;
+	}
+
+	hdr = skb_vlan_eth_hdr(skb);
+	if (hdr->h_vlan_proto != htons(ETH_P_8021Q)) {
+		skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), 0);
+		/* vlan_insert_tag() drops the skb on failure */
+		if (!skb)
+			return NULL;
+		hdr = skb_vlan_eth_hdr(skb);
+		netdev_dbg(dev, "%s: inserted VLAN TAG %04x TCI %04x\n",
+			   __func__, hdr->h_vlan_proto, hdr->h_vlan_TCI);
+	} else {
+		/* VLAN tag already exists in skb head, modify it in place */
+		hdr = vlan_eth_hdr(skb);
+		hdr->h_vlan_proto = KS8995M_STPID(portmask);
+		netdev_dbg(dev, "%s: modified VLAN TAG %04x\n",
+			   __func__, hdr->h_vlan_proto);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	int portmask;
+	u16 etype;
+
+	/* We are expecting all received packets to have a mangled VLAN
+	 * TPID, so drop anything else. Because of the non-standard TPID,
+	 * don't even bother looking for a tag in the hwaccel area.
+	 *
+	 * We have to inspect the ethertype directly because skb->protocol
+	 * will contain garbage.
+	 */
+	etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
+	if ((etype & KS8995M_STPID_STD) != ETH_P_8021Q) {
+		netdev_dbg(dev, "%s: dropped ethertype 0x%04x\n",
+			   __func__, etype);
+		kfree_skb(skb);
+		return NULL;
+	}
+	netdev_dbg(dev, "%s: received ethertype %04x\n",
+		   __func__, etype);
+
+	/* Move the custom DSA+VLAN tag into the hwaccel area and strip
+	 * it from the skb head
+	 */
+	skb = skb_vlan_untag(skb);
+	if (!skb) {
+		/* skb_vlan_untag drops the skb on failure */
+		netdev_err(dev, "%s: unable to untag skb\n", __func__);
+		return NULL;
+	}
+
+	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
+	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
+		   __func__, etype, portmask, ilog2(portmask));
+	skb->dev = dsa_conduit_find_user(dev, 0, ilog2(portmask));
+	if (!skb->dev) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Preserve the VLAN tag if it contains a non-zero VID which is not
+	 * identical to 0x001, or PCP, and restore its TPID to the standard
+	 * value.
+	 *
+	 * If this is just an ordinary inbound package the datasheet claims
+	 * it will "replace null VID with ingress port VID", which means
+	 * VID set to 1: 0x8101 0001 for port 0 or 0x8102 0001 for port 1.
+	 * So in the DSA driver we will set the default port VID to 0 so
+	 * we can properly detect non-VLAN frames.
+	 */
+	if (!skb->vlan_tci) {
+		netdev_dbg(dev, "%s: clear VLAN tag from frame\n", __func__);
+		__vlan_hwaccel_clear_tag(skb);
+	} else {
+		skb->vlan_proto = htons(ETH_P_8021Q);
+		netdev_dbg(dev, "%s: vlan_tci = 0x%04x VLAN frame\n",
+			   __func__, skb->vlan_tci);
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops ks8995_netdev_ops = {
+	.name = KS8995_NAME,
+	.proto	= DSA_TAG_PROTO_KS8995,
+	.xmit = ks8995_xmit,
+	.rcv = ks8995_rcv,
+	.needed_headroom = VLAN_HLEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Micrel KS8995 family of switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KS8995, KS8995_NAME);
+
+module_dsa_tag_driver(ks8995_netdev_ops);

-- 
2.55.0

