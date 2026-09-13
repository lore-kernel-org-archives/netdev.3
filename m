Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA13F58D7;
	Sun, 13 Sep 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789329423; cv=none; b=cSmLyYbBKy1G1+pADl8VzTmCg2JuYnjp5G8m2+B8yVCyEDn+52Vl8JTnBph/DUzMunLwVcE6ibWKsvo170S3V6417/K726DZcTaFW3O6rCGWGbkA+FHZWtUmpnomawB9sPDfmD3bLtzbnRlUxuQxq53gDyRv9MfMY9qWG6DEmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789329423; c=relaxed/simple;
	bh=YG1b4/CBN8K0NKYBKsXzy0TcDKCMYi0JSMeNqBHkNsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjzORj/hUEQV8CZSPdl9Vp80kYMpEacwTMb+bCiX91YtKIaIVy7PC1TPyigKwN+XxCW8+TsPR1EDezi721eJaItux3CF1GBiPheM9pGy+3RFMt/I4oiMnQ7hhpg8EVGM6/x9TMte359uPZRtzTaSgmeq5wDRNIW5QsKRnhnJ/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUuk65Du; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUuk65Du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9216D1F000FF;
	Sun, 13 Sep 2026 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789329421;
	bh=cDUsDBcPw/Ji+4pUiKR+FxM1xwT91z7Xam1IPDrKJls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oUuk65DuuXTo8a50TY0SHjljzrcjlVgSCKFXoYBUGhU8MKKtsahBbPuxX2CsfGEZH
	 OwxfA6+N7SV/PMDR2A0sAfL60a1vlNzII09KVZqfclyMfhbTimNAbOylpXWMw8Vcwg
	 iQbnG6TbvWvXh/Go/rG1v8N3bMflf0KAcM6dCXtBgnD9OMeKfmAoULBVR7S5ESNev4
	 kswG35sKb7UJroxb+4p3He3pthiHAAiBGxerS/+UNWyXyhRuwdfrrrm3809ok8W6wK
	 ALKfiMr+dOsz5DSh3kB5k3ibAbSe9B/M/OfrQMC9wonhQ3GiHu3dJsBmRPvAFiEQ9R
	 mURdRM0scNLKg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 13 Sep 2026 21:56:43 +0200
Subject: [PATCH net-next v13 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ks8995-to-ksz8-v13-2-327b16d309eb@kernel.org>
References: <20260913-ks8995-to-ksz8-v13-0-327b16d309eb@kernel.org>
In-Reply-To: <20260913-ks8995-to-ksz8-v13-0-327b16d309eb@kernel.org>
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

The tagger is used by the KSZ8995XA support added later in this
series.

The tag is a modified 0x8100 ethertype tag where a bit in the
last nibble is set for each target port.

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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS          |   1 +
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 ++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_ks8995.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 163 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e04d92d1b09..6e0d16e3ee4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17772,6 +17772,7 @@ F:	Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
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
index 000000000000..435665013a86
--- /dev/null
+++ b/net/dsa/tag_ks8995.c
@@ -0,0 +1,153 @@
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
+#define KS8995_TAG_LEN		VLAN_HLEN
+/* Reserve room for the switch tag and a hardware-accelerated VLAN tag. */
+#define KS8995_NEEDED_HEADROOM	(KS8995_TAG_LEN + VLAN_HLEN)
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
+		   __func__, ntohs(hdr->h_vlan_proto),
+		   ntohs(hdr->h_vlan_TCI));
+
+	return skb;
+}
+
+static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	int portmask;
+	int port;
+	u16 etype;
+
+	/* The special tag may be in the packet or VLAN metadata. In either
+	 * case, its TPID must retain the source-port bits.
+	 *
+	 * Read the in-band TPID directly because skb->protocol contains
+	 * ETH_P_XDSA.
+	 */
+	if (skb_vlan_tag_present(skb))
+		etype = ntohs(skb->vlan_proto);
+	else
+		etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
+	if ((etype & KS8995M_STPID_STD) != ETH_P_8021Q) {
+		netdev_dbg(dev, "%s: dropped ethertype 0x%04x\n",
+			   __func__, etype);
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
+	if (unlikely(!is_power_of_2(portmask))) {
+		netdev_dbg(dev, "%s: dropped invalid port mask 0x%04x\n",
+			   __func__, portmask);
+		kfree_skb(skb);
+		return NULL;
+	}
+	port = ilog2(portmask);
+
+	netdev_dbg(dev, "%s: received ethertype %04x\n",
+		   __func__, etype);
+
+	/* Move an in-band special tag into VLAN metadata. If already
+	 * offloaded, its TPID was validated above.
+	 */
+	if (!skb_vlan_tag_present(skb)) {
+		skb = skb_vlan_untag(skb);
+		if (!skb) {
+			/* skb_vlan_untag drops the skb on failure */
+			if (net_ratelimit())
+				netdev_err(dev, "%s: unable to untag skb\n", __func__);
+			return NULL;
+		}
+	}
+
+	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
+		   __func__, etype, portmask, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
+	if (!skb->dev) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* The special tag's TCI is now in the hardware-accelerated VLAN
+	 * metadata. The switch preserves the TCI of tagged
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
+	.needed_headroom = KS8995_NEEDED_HEADROOM,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Micrel KS8995 family of switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KS8995, KS8995_NAME);
+
+module_dsa_tag_driver(ks8995_netdev_ops);

-- 
2.55.0

