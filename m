Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADB2E7F3A;
	Sun,  6 Sep 2026 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680910; cv=none; b=HTLrGIqGo3NJYiLyBxAm93IFOjR7Ckxgq25A3W2q78bp02QvuuQcd7JYwMRVAmBHhl4TXERHxpkKxcHpxvA3gKPCoWgOjzPXh5Y5ZLNQzZHkeVs99LtHsGtSCaxj6rpn5rroj+9TrgSwG9PFUOHjelLfUWcxJqbFBlXRJWqqkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680910; c=relaxed/simple;
	bh=EeFfTPMkFwcRx5pvCMmVvSGQvQ3s/UAOYNacvA6Q+oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLWr/Zyx2mKXQ+jHIa4XqxnJJt3KQs6dj5jGDbeiL8Wa04/RFU4ARt+YhSBQfozk6GIESE7ugB551EWuepCsKea/ym5DBaYMrCd1C1Ud64Rg0MS4DPYb/Muwf5TWjxk6RVAoEpn+Iy7K4CzySKuBXB9TyNMLgYyD4Aclpzq71sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3lNXHqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3lNXHqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701821F00A3A;
	Sun,  6 Sep 2026 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788680908;
	bh=Mor0rmiOzIBs7n1d17IMUikqNOUcDIJARQmRoBMByr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X3lNXHqnoDzqk7NfSqFkbhveMu5qVJzYR08PKprhi7ef9WKKq6I1IWmrCoCAJlNlv
	 074J0HLcSVatk+ABAQSQRikRD1cU52K/hT2o5YsKl+hThqFinSWLhvcS+6Oo4X6/ci
	 ed/446aNPTDUp1f9ifKd6HHPfmO8zh2lQUNz7win5w0QPXh+Yn1Ar6w7bHTFm9/Uy8
	 AWSQsee7YCwV52jdqYdkeb45A+2P1vG5aXI8d54mcYqDLVL9ydmVg2EXRT4gp17OVq
	 vrpNn0ycccFuCc9kr5M9qQ+Y6Mbt8uzEy1ILgMZErkPfiTEgUiUTaRTJc/f9+VQmV9
	 PbptH93qirdDg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 06 Sep 2026 09:48:12 +0200
Subject: [PATCH net-next v9 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ks8995-to-ksz8-v9-2-8d8815a91bd8@kernel.org>
References: <20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8@kernel.org>
In-Reply-To: <20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8@kernel.org>
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

Always insert a distinct outer switch tag. User ports remove this
field on egress, so reusing an existing 802.1Q header would consume
the sender VLAN tag instead of preserving it.

Push any hardware-accelerated VLAN tag into the packet first. This
keeps the switch tag at offset 12 while retaining 802.1Q, 802.1ad and
stacked VLAN headers as inner payload, and avoids relying on a valid
SKB MAC header in direct transmit paths.

Rate-limit receive untagging errors so repeated failures cannot flood
the kernel log.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS          |   1 +
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_ks8995.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+)

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
index 000000000000..db90b3165a85
--- /dev/null
+++ b/net/dsa/tag_ks8995.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Linus Walleij <linusw@kernel.org>
+ */
+#include <linux/etherdevice.h>
+#include <linux/log2.h>
+#include <linux/list.h>
+#include <linux/net.h>
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
+	/* Always add a distinct outer tag. The user port removes this field on
+	 * egress, so reusing an existing 802.1Q tag would consume that VLAN tag.
+	 */
+	skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), 0);
+	/* vlan_insert_tag() drops the skb on failure */
+	if (!skb)
+		return NULL;
+	hdr = skb_vlan_eth_hdr(skb);
+	netdev_dbg(dev, "%s: inserted VLAN TAG %04x TCI %04x\n",
+		   __func__, hdr->h_vlan_proto, hdr->h_vlan_TCI);
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
+		if (net_ratelimit())
+			netdev_err(dev, "%s: unable to untag skb\n", __func__);
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
+	/* skb_vlan_untag() moved the special tag's TCI into the hardware-
+	 * accelerated VLAN metadata. The switch preserves the TCI of tagged
+	 * frames, but inserts the ingress port's default tag for untagged frames.
+	 * Since the driver programs the default tag to 0, a zero TCI identifies
+	 * an originally untagged frame. Preserve every non-zero TCI as an
+	 * 802.1Q tag, including VID 0 frames with PCP or DEI set.
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

