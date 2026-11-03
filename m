Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709131;
	b=0r/gDsK6zA3zl7V1UjZodfqeJgWrutR0O7qDhEhY+uaeG0Daq2b3gmMwumGYcx49fjFS
	 jcRNQYQ/6/8vr/P4LPlVGIlaHqiXnQyvY8SP2Mz94DpoYKhQfTgQxFFJXGqndRaKo29Q4
	 eFPSl4iTz6iseVM8umuMDHa7DTtfFFcUsqapA9qVE1cA0LF8qfBXjOUTZXh+qYqnWfO3t
	 qBc1KzemJ6cDNl+I2oROXU+zu7bsQKF1OP9k6u516QchB/av0nLWTzyxTTIflpvEonBKW
	 Mmnidi35Q+zyzWkP+qbzBMkgN2IBTpvKTlAo0Zch220mkjl9ZYhWAtbvdkDSXMupNBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709131;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=ZIrY7sWTyTYkKwDVFwGva/Ha9V/7YFNWEejJMW9EOF8=;
	b=w8RMd3qhsKeWSm4pIQkEPras45Yx+Ne2P8r0im/7qHIQaeVJ+JzUoeBoq/o/02MdTIXY
	 zR+D7etIobj0q4/YnATjYO5dNYCq2ydiHB8Nu7BdkrJsh/uYSNO605xB/VaU+0On/ikXi
	 xoQmkHUWQDLf3tiCzaG0SnVnPAHLlH68SZPOoRMGDv0436YniOI5mhPsQucQobmKO59cq
	 44qvs0AKsRaKcmWSY1NAqa0aBC65LgPL/S+hyfLL4qDhquyMBXScTp6oSg9ZOKRdDXos8
	 jQlkFOzA4hQA58LRJ2wTiRp4aVTe0H0s6y0jxKb+QnpnsV2h25ch5DgOsbszakb7DIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="MhP/xfXr";
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2666082BCE;
	Tue,  3 Nov 2026 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2666082BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=MhP/xfXr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793709130; x=1825245130;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v4Wksjj5AeJxN/lZ7L6RHMTBMxS7dVq3fDVyWtZNCyA=;
  b=MhP/xfXr60S5Pmyqu7XTLfyBjegbQOmhFdTS+G44HIenWwPNStJmui1F
   jtWjZvrUJHr9AznfaO6wVdztd2DTfj1IdoapspMEo3+GSj4grbe4Huvc+
   SKpj2jnC9N0acKgnj8494MDgxNH2i0QkIcQTiKzTt+MWf0YhxO78iQ6x1
   q+Hk8txZaQVQ72aYDS5+fIf/jfo41R5pr9+9Z6I9Kw+PHuOx2hSgf6tk5
   6O50f9wkGRMfeaJnwjkGgdd29wF81RipgRpifZkoipw61DNBeZ4FPIKIS
   go/Cto84Dd6cobXYijcMdOgCsaa9eLAK3VSXGA6Bkc2KaJ4KmhS/D7uo9
   Q==;
X-CSE-ConnectionGUID: EX/j0TfCR6eJjUySdaW2kQ==
X-CSE-MsgGUID: M9G3UvtWR3iwuTQ957jv8g==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="76527809"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 05:32:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 3 Nov 2026 05:32:06 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Nov 2026 05:32:02 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 3 Nov 2026 13:31:56 +0100
Subject: [PATCH net-next v16 1/4] net: dsa: add tag driver for LAN9645X
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
Content-Transfer-Encoding: 8bit
Message-ID: <20261103-dsa_lan9645x_switch_driver_base-v16-1-781c96d735cf@microchip.com>
References: <20261103-dsa_lan9645x_switch_driver_base-v16-0-781c96d735cf@microchip.com>
In-Reply-To: <20261103-dsa_lan9645x_switch_driver_base-v16-0-781c96d735cf@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Add tag driver for LAN9645x using a front port as CPU port. This mode
is called an NPI port in the datasheet.
Use long prefix on extraction (RX) and no prefix on injection (TX). A
long prefix on extraction helps get through the conduit port on host
side, since it will see a broadcast MAC.

The LAN9645x chip is in the same design architecture family as ocelot
and lan966x. The tagging protocol has the same structure as these chips,
but the particular fields are different or have different sizes.
Therefore, this tag driver is similar to tag_ocelot.c, but the
differences in fields makes it hard to reuse.

LAN9645x supports 3 different tag formats for extraction/injection of
frames from a CPU port: long prefix, short prefix and no prefix.

The tag is prepended to the frame. The critical data for the chip is
contained in an internal frame header (IFH) which is 28 bytes. The
prefix formats look like this:

Long prefix (16 bytes) + IFH:
- DMAC    = 0xffffffffffff on extraction.
- SMAC    = 0xfeffffffffff on extraction.
- ETYPE   = 0x8880
- payload = 0x0011
- IFH

Short prefix (4 bytes) + IFH:
- 0x8880
- 0x0011
- IFH

No prefix:
- IFH

The format can be configured asymmetrically on RX and TX.

The IFH get/set functions are declared as inline. All the field
constants are compile-time known, so when these calls are inlined
efficient code is generated with branches pruned and loops unrolled.
During testing it was observed that without explicit inlining GCC would
have trouble inlining the functions, which hurt performance.

A frame extracted from a VLAN-aware port arrives without its VLAN tag.
REW_PORT_CFG.NO_REWRITE is clear on the NPI port, so the rewriter applies
the classified VLAN_POP_CNT, and the classified VID reaches the CPU only
through the IFH. The tagger restores it as a hwaccel tag when the IFH
reports that a tag was popped. An untagged frame is classified to the
port pvid without a pop and is delivered untagged, which the bridge also
classifies to the pvid.

The restored tag is always a C-tag, not the TPID the IFH TAG_TYPE reports.
Both TPIDs are recognized as VLAN tags unconditionally, with no per port
control to treat one as untagged customer data, so an S-tag is already
consumed as the VLAN tag before extraction. Restoring 802.1AD would make
the bridge push the tag back into the payload and reclassify the frame to
the port pvid, placing it on a different VID than the one the hardware
forwarded it on. Normalizing to a C-tag keeps the terminated path
consistent with the forwarded path, at the cost of not preserving the
S-tag TPID towards the CPU. This assumes a bridge vlan_protocol of
802.1Q, which is the only protocol the driver offloads.

On injection the IFH carries the classified VID used by the rewriter
to decide whether to add a port tag. On a VLAN-aware port, a VLAN tag
with a non-zero VID is moved from the payload into the IFH. Untagged
and priority tagged frames are injected with classified VID 0 and left
as they are, so the rewriter adds no tag to them.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v16:
- Restore the popped VLAN tag whenever the IFH reports a pop, without
  checking dsa_port_is_vlan_filtering().
- Mention the real ethernet header in the skb_postpull_rcsum() comment.

Changes in v14:
- Classify untagged and priority tagged frames to VID 0 on xmit instead
  of the bridge pvid, and leave priority tags in the payload.
- Restore the VLAN tag on rcv whenever the rewriter popped one, instead
  of only when the VID differs from the port pvid.
- Add a .flow_dissect callback that accounts for the gap left by VLAN
  tags popped on extraction. The generic dissector assumes the tag length
  is needed_headroom.
- Pull the VLAN header with pskb_may_pull() before reading it on xmit,
  so a tag in paged data is handled like a linear one, and drop the
  frame if the pull fails.

Changes in v12:
- Move an out-of-band VLAN tag into the payload with
  __vlan_hwaccel_push_inside() before reading it, rather than relying on
  the conduit never advertising NETIF_F_HW_VLAN_CTAG_TX or
  NETIF_F_HW_VLAN_STAG_TX in vlan_features.
- Return the skb from lan9645x_xmit_get_vlan_info(), since
  __vlan_hwaccel_push_inside() may reallocate and frees the skb on
  failure.
- Annotate the IFH field defines with injection/extraction
  applicability
- Drop IFH_TIMESTAMP because it is 38 bits wide. Rely on NS/SUB_NS
  subfields.
- Document how HW derives the DMAC offset from pop_cnt and etype_ofs,
  and drop frames whose encoding only a tag push could produce.
- Drop unncessary IFH_SRCPORT on injection.
- Drop the WARN_ON_ONCE() when the source port does not resolve to a
  user port.
- Move the IFH field position and size defines from
  include/linux/dsa/lan9645x.h into net/dsa/tag_lan9645x.c.
- Rename LAN9645X_IFH_LEN to LAN9645X_IFH_LEN_BYTES, so it does not read
  as the position of the IFH LEN field.
- Use skb_vlan_eth_hdr() in lan9645x_xmit_get_vlan_info().
- Drop BTM_MSK() TOP_MSK() helpers for GENMASK().
- Rename set_merge_mask() to lan9645x_ifh_merge_byte().
- Name the vendor in the Kconfig prompt, spell the part LAN9645x, and
  move the entry to its sorted position after NET_DSA_TAG_KSZ.
- Clamp the classified QoS class to the width of IFH_QOS_CLASS. A
  skb->priority above 7 aliased down onto an unrelated class.
- Comment why needed_headroom covers the extraction prefix.
- Restore the classified VLAN as a C-tag rather than following the IFH
  TAG_TYPE, so a terminated S-tagged frame lands on the same VID the
  hardware forwards it on.

Changes in v11:
- Update comment about vlan tag hwaccel use in tag driver.
- Bump DSA_TAG_PROTO value in include/net/dsa.h.

Changes in v10:
- Update tag driver after skb ownership model change in DSA taggers.
  Explicitly freeing the skb at rcv/xmit return points.

Changes in v8:
- Drop the cpu_port local and use ds->num_ports directly as the IFH
  source port (the CPU port module index).
- Reword the reflection comment to refer to "the CPU".

Changes in v7:
- Introduce cpu queue based frame classification, and refactor to the
  categories default, trap and copy, which mirrors usage instead of
  being based on frame types.

Changes in v6:
- rebased on net-next, bumping DSA_TAG_PROTO_LAN9645X_VALUE to 34

Changes in v5:
- Undo offset fix in postpull_rcsum. The original logic was correct for
  CHECKSUM_COMPLETE host NICs
- Use __always_inline in lan9645x_ifh_{get,set}
- remove double space after = in set_merge_mask

Changes in v4:
- Fix offset in postpull_rcsum so prefix eth header is cleared, not
  actual eth header, so tag driver works with CHECKSUM_COMPLETE host
  NICs
- Fix untagged rx on vlan aware port with pvid

Changes in v3:
- guard vlan_remove_tag behind skb_headlen(skb) >= VLAN_ETH_HLEN on xmit
- add pskb_may_pull checks in rx path

Changes in v2:
- sorting in net/dsa/Kconfig
- sorting in net/dsa/Makefile
- remove default zero promisc_on_conduit
- move functions to to .c file
- add justification for inline usage to commit message
- add __skb_put_padto on xmit path
- fix hwaccel_put_tag
---
 MAINTAINERS                  |   8 +
 include/linux/dsa/lan9645x.h |  54 +++++
 include/net/dsa.h            |   2 +
 net/dsa/Kconfig              |  11 +
 net/dsa/Makefile             |   1 +
 net/dsa/tag_lan9645x.c       | 513 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 589 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..2305052c3a5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18184,6 +18184,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/microchip_t1.c
 
+MICROCHIP LAN9645X ETHERNET SWITCH DRIVER
+M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
+M:	UNGLinuxDriver@microchip.com
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	include/linux/dsa/lan9645x.h
+F:	net/dsa/tag_lan9645x.c
+
 MICROCHIP LAN966X ETHERNET DRIVER
 M:	Horatiu Vultur <horatiu.vultur@microchip.com>
 M:	UNGLinuxDriver@microchip.com
diff --git a/include/linux/dsa/lan9645x.h b/include/linux/dsa/lan9645x.h
new file mode 100644
index 000000000000..e774aa137092
--- /dev/null
+++ b/include/linux/dsa/lan9645x.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#ifndef _NET_DSA_TAG_LAN9645X_H_
+#define _NET_DSA_TAG_LAN9645X_H_
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* LAN9645x supports 3 different formats on an NPI port, long prefix, short
+ * prefix and no prefix. The format can be configured asymmetrically on RX and
+ * TX. We use long prefix on extraction (RX), and no prefix on injection.
+ * The long prefix on extraction helps get through the conduit port on host
+ * side, since it will see a broadcast MAC.
+ *
+ * The internal frame header (IFH) is 28 bytes.
+ *
+ * Long prefix, 16 bytes + IFH:
+ * - DMAC    = 0xFFFFFFFFFFFF on extraction.
+ * - SMAC    = 0xFEFFFFFFFFFF on extraction.
+ * - ETYPE   = 0x8880
+ * - payload = 0x0011
+ * - IFH
+ *
+ * Short prefix, 4 bytes + IFH:
+ * - 0x8880
+ * - 0x0011
+ * - IFH
+ *
+ * No prefix:
+ * - IFH
+ *
+ */
+#define LAN9645X_IFH_TAG_TYPE_C		0
+#define LAN9645X_IFH_TAG_TYPE_S		1
+#define LAN9645X_IFH_LEN_U32		7
+#define LAN9645X_IFH_LEN_BYTES		(LAN9645X_IFH_LEN_U32 * sizeof(u32))
+#define LAN9645X_IFH_BITS		(LAN9645X_IFH_LEN_BYTES * BITS_PER_BYTE)
+#define LAN9645X_LONG_PREFIX_LEN	16
+#define LAN9645X_TOTAL_TAG_LEN \
+	(LAN9645X_LONG_PREFIX_LEN + LAN9645X_IFH_LEN_BYTES)
+
+/* Chip has 8 cpu queues. The cpu queues used by a frame are passed as a mask in
+ * the IFH on extraction. We use this to avoid classifying BPDU, IGMP and MLD
+ * frames in the tag driver.
+ */
+enum {
+	LAN9645X_CPUQ_DEF = 0,
+	LAN9645X_CPUQ_TRAP = 1,
+	LAN9645X_CPUQ_COPY = 2,
+};
+
+#endif /* _NET_DSA_TAG_LAN9645X_H_ */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..09f3043d57f0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -62,6 +62,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
 #define DSA_TAG_PROTO_KS8995_VALUE		36
+#define DSA_TAG_PROTO_LAN9645X_VALUE		37
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -101,6 +102,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
 	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
+	DSA_TAG_PROTO_LAN9645X		= DSA_TAG_PROTO_LAN9645X_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4f44bf3ede23..bdeb60af764b 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -137,6 +137,17 @@ config NET_DSA_TAG_KSZ
 	  Say Y if you want to enable support for tagging frames for the
 	  Microchip 8795/937x/9477/9893 families of switches.
 
+config NET_DSA_TAG_LAN9645X
+	tristate "Tag driver for Microchip LAN9645x switches"
+	help
+	  Say Y or M if you want to enable NPI tagging for the Microchip
+	  LAN9645x switches. In this mode, the frames over the Ethernet CPU
+	  port are prepended with a hardware-defined injection/extraction frame
+	  header. On injection a 28 byte internal frame header (IFH) is used.
+	  On extraction a 16 byte prefix is prepended before the internal frame
+	  header. This prefix starts with a broadcast MAC, to ease passage
+	  through the host side RX filter.
+
 config NET_DSA_TAG_NETC
 	tristate "Tag driver for NXP NETC switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 1f9cc30e9988..3cd53124448d 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KS8995) += tag_ks8995.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
+obj-$(CONFIG_NET_DSA_TAG_LAN9645X) += tag_lan9645x.o
 obj-$(CONFIG_NET_DSA_TAG_MT7628) += tag_mt7628.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
new file mode 100644
index 000000000000..9b373bac91e9
--- /dev/null
+++ b/net/dsa/tag_lan9645x.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/dsa/lan9645x.h>
+
+#include "tag.h"
+
+#define LAN9645X_NAME "lan9645x"
+
+/* The internal frame header (IFH) is 28 bytes, and the fields are documented
+ * below. Some fields are only used on either injection or extraction.
+ *
+ * Injection header
+ */
+#define IFH_INJ_TIMESTAMP		192
+#define IFH_BYPASS			191
+#define IFH_MASQ			190
+/* Extraction header */
+#define IFH_TIMESTAMP_NS		194
+#define IFH_TIMESTAMP_SUBNS		186
+/* Injection header */
+#define IFH_MASQ_PORT			186
+#define IFH_RCT_INJ			185
+/* Extraction header */
+#define IFH_LEN				171
+#define IFH_WRDMODE			169
+/* Extraction/Injection header */
+#define IFH_RTAGD			167
+/* Extraction header */
+#define IFH_CUTTHRU			166
+/* Extraction/Injection header */
+#define IFH_REW_CMD			156
+#define IFH_REW_OAM			155
+#define IFH_PDU_TYPE			151
+#define IFH_FCS_UPD			150
+#define IFH_DP				149
+/* Reserved */
+#define IFH_RTE_INB_UPDATE		148
+/* Extraction/Injection header */
+#define IFH_POP_CNT			146
+#define IFH_ETYPE_OFS			144
+/* Extraction header */
+#define IFH_SRCPORT			140
+/* Extraction/Injection header */
+#define IFH_SEQ_NUM			120
+#define IFH_TAG_TYPE			119
+#define IFH_TCI				103
+#define IFH_DSCP			97
+#define IFH_QOS_CLASS			94
+#define IFH_CPUQ			86
+/* Extraction header */
+#define IFH_LEARN_FLAGS			84
+/* Extraction/Injection header */
+#define IFH_SFLOW_ID			80
+#define IFH_ACL_HIT			79
+#define IFH_ACL_IDX			73
+#define IFH_ISDX			65
+#define IFH_DSTS			55
+/* Extraction header */
+#define IFH_FLOOD			53
+/* Extraction/Injection header */
+#define IFH_SEQ_OP			51
+#define IFH_IPV				48
+/* Injection header */
+#define IFH_AFI				47
+/* Reserved */
+#define IFH_RTP_ID			37
+#define IFH_RTP_SUBID			36
+#define IFH_PN_DATA_STATUS		28
+#define IFH_PN_TRANSF_STATUS_ZERO	27
+#define IFH_PN_CC			11
+/* Extraction/Injection header */
+#define IFH_DUPL_DISC_ENA		10
+/* Extraction header */
+#define IFH_RCT_AVAIL			9
+
+#define IFH_INJ_TIMESTAMP_SZ		32
+#define IFH_BYPASS_SZ			1
+#define IFH_MASQ_SZ			1
+#define IFH_TIMESTAMP_NS_SZ		30
+#define IFH_TIMESTAMP_SUBNS_SZ		8
+#define IFH_MASQ_PORT_SZ		4
+#define IFH_RCT_INJ_SZ			1
+#define IFH_LEN_SZ			14
+#define IFH_WRDMODE_SZ			2
+#define IFH_RTAGD_SZ			2
+#define IFH_CUTTHRU_SZ			1
+#define IFH_REW_CMD_SZ			10
+#define IFH_REW_OAM_SZ			1
+#define IFH_PDU_TYPE_SZ			4
+#define IFH_FCS_UPD_SZ			1
+#define IFH_DP_SZ			1
+#define IFH_RTE_INB_UPDATE_SZ		1
+#define IFH_POP_CNT_SZ			2
+#define IFH_ETYPE_OFS_SZ		2
+#define IFH_SRCPORT_SZ			4
+#define IFH_SEQ_NUM_SZ			16
+#define IFH_TAG_TYPE_SZ			1
+#define IFH_TCI_SZ			16
+#define IFH_DSCP_SZ			6
+#define IFH_QOS_CLASS_SZ		3
+#define IFH_CPUQ_SZ			8
+#define IFH_LEARN_FLAGS_SZ		2
+#define IFH_SFLOW_ID_SZ			4
+#define IFH_ACL_HIT_SZ			1
+#define IFH_ACL_IDX_SZ			6
+#define IFH_ISDX_SZ			8
+#define IFH_DSTS_SZ			10
+#define IFH_FLOOD_SZ			2
+#define IFH_SEQ_OP_SZ			2
+#define IFH_IPV_SZ			3
+#define IFH_AFI_SZ			1
+#define IFH_RTP_ID_SZ			10
+#define IFH_RTP_SUBID_SZ		1
+#define IFH_PN_DATA_STATUS_SZ		8
+#define IFH_PN_TRANSF_STATUS_ZERO_SZ	1
+#define IFH_PN_CC_SZ			16
+#define IFH_DUPL_DISC_ENA_SZ		1
+#define IFH_RCT_AVAIL_SZ		1
+
+static __always_inline void lan9645x_ifh_merge_byte(u8 *dst, u8 src, u8 mask)
+{
+	*dst = *dst ^ ((*dst ^ src) & mask);
+}
+
+/* The internal frame header (IFH) is a big-endian 28 byte unpadded bit array.
+ * Frames can be prepended with an IFH on injection and extraction. There
+ * are two field layouts, one for extraction and one for injection.
+ *
+ *    IFH bits go from high to low, for instance
+ *    ifh[0]  = [223:216]
+ *    ifh[27] = [7:0]
+ *
+ * Here is an example of setting a value starting at bit 13 of bit length 17.
+ *
+ * val    = 0x1ff
+ * pos    = 13
+ * length = 17
+ *
+ *
+ * IFH[]   0                         23       24       25        26      27
+ *
+ *                                           end_u8           start_u8
+ *      +--------+----------------+--------+--------+--------+--------+--------+
+ *      |        |                |        |        |        |        |        |
+ * IFH  |        | ....           |        |  vvvvvvvvvvvvvvvvvvv     |        |
+ *      |        |                |        |  |     |        |  |     |        |
+ *      +--------+----------------+--------+--+-----+--------+--+-----+--------+
+ * Bits  223                       39    32 31|   24 23    16 15|    8 7      0
+ *                                            |                 |
+ *                                            |                 |
+ *                                            |                 |
+ *                                            v                 v
+ *                                        end       = 29       pos        = 13
+ *                                        end_rem   = 5        pos_rem    = 5
+ *                                        end_u8    = 3        start_u8   = 1
+ *                                    GENMASK(5, 0) = 0x3f  GENMASK(7, 5) = 0xe0
+ *
+ *
+ * In end_u8 and start_u8 we must merge the existing IFH byte with the new
+ * value. In the 'middle' bytes of the value we can overwrite the corresponding
+ * IFH byte.
+ */
+static __always_inline void lan9645x_ifh_set(u8 *ifh, u32 val, size_t pos,
+					     size_t length)
+{
+	size_t end = (pos + length) - 1;
+	size_t end_rem = end & 0x7;
+	size_t pos_rem = pos & 0x7;
+	size_t start_u8 = pos >> 3;
+	size_t end_u8 = end >> 3;
+	u8 end_mask, start_mask;
+	size_t vshift;
+	u8 *ptr;
+
+	BUILD_BUG_ON_MSG(length > 32, "IFH field size wider than 32.");
+	BUILD_BUG_ON_MSG(length == 0, "IFH field size of 0.");
+	BUILD_BUG_ON_MSG(pos + length > LAN9645X_IFH_BITS,
+			 "IFH field overflows IFH");
+
+	end_mask = GENMASK(end_rem, 0);
+	start_mask = GENMASK(7, pos_rem);
+
+	ptr = &ifh[LAN9645X_IFH_LEN_BYTES - 1 - end_u8];
+
+	if (end_u8 == start_u8)
+		return lan9645x_ifh_merge_byte(ptr, val << pos_rem,
+					       end_mask & start_mask);
+
+	vshift = length - end_rem - 1;
+	lan9645x_ifh_merge_byte(ptr++, val >> vshift, end_mask);
+
+	for (size_t j = 1; j < end_u8 - start_u8; j++) {
+		vshift -= 8;
+		*ptr++ = val >> vshift;
+	}
+
+	lan9645x_ifh_merge_byte(ptr, val << pos_rem, start_mask);
+}
+
+static __always_inline u32 lan9645x_ifh_get(const u8 *ifh, size_t pos,
+					    size_t length)
+{
+	size_t end = (pos + length) - 1;
+	size_t end_rem = end & 0x7;
+	size_t pos_rem = pos & 0x7;
+	size_t start_u8 = pos >> 3;
+	size_t end_u8 = end >> 3;
+	u8 end_mask, start_mask;
+	const u8 *ptr;
+	u32 val;
+
+	BUILD_BUG_ON_MSG(length > 32, "IFH field size wider than 32.");
+	BUILD_BUG_ON_MSG(length == 0, "IFH field size of 0.");
+	BUILD_BUG_ON_MSG(pos + length > LAN9645X_IFH_BITS,
+			 "IFH field overflows IFH");
+
+	end_mask = GENMASK(end_rem, 0);
+	start_mask = GENMASK(7, pos_rem);
+
+	ptr = &ifh[LAN9645X_IFH_LEN_BYTES - 1 - end_u8];
+
+	if (end_u8 == start_u8)
+		return (*ptr & end_mask & start_mask) >> pos_rem;
+
+	val = *ptr++ & end_mask;
+
+	for (size_t j = 1; j < end_u8 - start_u8; j++)
+		val = val << 8 | *ptr++;
+
+	return val << (8 - pos_rem) | (*ptr & start_mask) >> pos_rem;
+}
+
+static struct sk_buff *lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
+						   struct net_device *br,
+						   u32 *vlan_tci,
+						   u32 *tag_type)
+{
+	struct vlan_ethhdr *hdr;
+	u16 proto, tci;
+
+	/* If the VLAN tag is in the hwaccel area, move it to the payload so
+	 * that both cases are handled uniformly below, and so that the conduit
+	 * cannot insert it into the middle of the IFH we are about to prepend.
+	 */
+	if (unlikely(skb_vlan_tag_present(skb))) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			return NULL;
+	}
+
+	if (!br || !br_vlan_enabled(br)) {
+		*vlan_tci = 0;
+		*tag_type = LAN9645X_IFH_TAG_TYPE_C;
+		return skb;
+	}
+
+	br_vlan_get_proto(br, &proto);
+
+	*vlan_tci = 0;
+	if (skb->len >= VLAN_ETH_HLEN) {
+		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN))) {
+			kfree_skb(skb);
+			return NULL;
+		}
+
+		hdr = skb_vlan_eth_hdr(skb);
+		if (ntohs(hdr->h_vlan_proto) == proto &&
+		    ntohs(hdr->h_vlan_TCI) & VLAN_VID_MASK) {
+			vlan_remove_tag(skb, &tci);
+			*vlan_tci = tci;
+		}
+	}
+
+	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
+					     LAN9645X_IFH_TAG_TYPE_C;
+
+	return skb;
+}
+
+static void lan9645x_offload_fwd_mark(struct sk_buff *skb, u32 cpuq)
+{
+	/* Trapped frames must be forwarded by the stack. */
+	if (cpuq & BIT(LAN9645X_CPUQ_TRAP)) {
+		skb->offload_fwd_mark = 0;
+		return;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+}
+
+static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
+				     struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	u32 vlan_tci, tag_type;
+	u32 qos_class;
+	void *ifh;
+
+	skb = lan9645x_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(dp),
+					  &vlan_tci, &tag_type);
+	if (!skb)
+		return NULL;
+
+	/* We need to make sure frame has the proper size after IFH is stripped
+	 * by hw.
+	 */
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NULL;
+
+	qos_class = netdev_get_num_tc(ndev) ?
+		    netdev_get_prio_tc_map(ndev, skb->priority) :
+		    skb->priority;
+	qos_class = min_t(u32, qos_class, GENMASK(IFH_QOS_CLASS_SZ - 1, 0));
+
+	/* Make room for IFH */
+	ifh = skb_push(skb, LAN9645X_IFH_LEN_BYTES);
+	memset(ifh, 0, LAN9645X_IFH_LEN_BYTES);
+
+	lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
+	lan9645x_ifh_set(ifh, tag_type, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
+	lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);
+	lan9645x_ifh_set(ifh, qos_class, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
+	lan9645x_ifh_set(ifh, BIT(dp->index), IFH_DSTS, IFH_DSTS_SZ);
+
+	return skb;
+}
+
+static int lan9645x_ifh_gap_len(const u8 *ifh)
+{
+	u32 popcnt = lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
+	u32 etype_ofs = lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_SZ);
+
+	/* Tag pushing is disabled on the NPI port via REW_TAG_CFG, so if this
+	 * fires REW_TAG_CFG is misconfigured.
+	 */
+	if (popcnt == 1 ||
+	    (popcnt == 0 && etype_ofs > 0))
+		return -EINVAL;
+
+	/* Since REW_PORT_CFG_NO_REWRITE=0 is required on the NPI port, we need
+	 * to account for any tags popped by the hardware, as that will leave a
+	 * gap between the IFH and DMAC. Tag pushing is disabled.
+	 *
+	 * The IFH fields do not have intuitive values. This is how HW does the
+	 * calculation:
+	 *
+	 * DMAC_DT = (ifh.pop_cnt == 0 && ifh.etype_ofs == 0) ? 4 : ifh.pop_cnt
+	 * DMAC_OFFSET = TAG_SIZE + 4*(DMAC_DT - 2)
+	 *
+	 * With tag pushing disabled we have either
+	 *
+	 * popcnt=0 and etype_ofs=0     => 2x pop
+	 * popcnt=3 and etype_ofs=*     => 1x pop
+	 * popcnt=2 and etype_ofs=*     => no pop
+	 *
+	 * The remaining combinations indicate a push and will not occur.
+	 */
+	if (popcnt == 0 && etype_ofs == 0)
+		return 2 * VLAN_HLEN;
+	if (popcnt == 3)
+		return VLAN_HLEN;
+
+	return 0;
+}
+
+static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
+				    struct net_device *ndev)
+{
+	u32 src_port, qos_class, vlan_tci, cpuq;
+	int ifh_gap_len;
+	u8 *ifh;
+
+	/* Conduit already consumed DMAC,SMAC,ETYPE from long prefix. Go back
+	 * to beginning of frame.
+	 */
+	skb_push(skb, ETH_HLEN);
+
+	if (unlikely(!pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN))) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* IFH starts after our long prefix */
+	ifh = skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);
+
+	src_port = lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
+	vlan_tci = lan9645x_ifh_get(ifh, IFH_TCI, IFH_TCI_SZ);
+	qos_class = lan9645x_ifh_get(ifh, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
+	cpuq = lan9645x_ifh_get(ifh, IFH_CPUQ, IFH_CPUQ_SZ);
+
+	ifh_gap_len = lan9645x_ifh_gap_len(ifh);
+	if (ifh_gap_len < 0) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Set skb->data at start of real header */
+	skb_pull(skb, LAN9645X_IFH_LEN_BYTES);
+
+	if (unlikely(!pskb_may_pull(skb, ifh_gap_len + ETH_HLEN))) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	skb_pull(skb, ifh_gap_len);
+	skb_reset_mac_header(skb);
+	skb_set_network_header(skb, ETH_HLEN);
+	skb_reset_mac_len(skb);
+
+	/* Reset skb->data past the actual ethernet header. */
+	skb_pull(skb, ETH_HLEN);
+
+	/* We must deliver the skb so skb->csum only covers the data beyond the
+	 * real ethernet header. The fake ethernet header in the prefix is
+	 * not part of skb->csum already. We must subtract what remains of the
+	 * prefix, the ifh, the gap and the real ethernet header, which
+	 * dsa_switch_rcv() pushes back without updating skb->csum. The start
+	 * is derived from the current skb->data rather than saved on entry,
+	 * because the pskb_may_pull() calls above may have reallocated
+	 * skb->head.
+	 */
+	skb_postpull_rcsum(skb,
+			   skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len,
+			   LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
+
+	skb->dev = dsa_conduit_find_user(ndev, 0, src_port);
+	if (!skb->dev) {
+		/* Reflection is disabled for frames from the tag driver itself,
+		 * however it is possible that a frame sent directly on the
+		 * conduit gets reflected, so we drop it here.
+		 */
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	lan9645x_offload_fwd_mark(skb, cpuq);
+
+	skb->priority = qos_class;
+
+	/* While we have REW_PORT_CFG_NO_REWRITE=0 on the NPI port, we still
+	 * disable port VLAN tag pushing with REW_TAG_CFG. A frame ingressing
+	 * on a vlan aware port, which is forwarded to the CPU, will not carry
+	 * vlan info in the frame data, because the tag is popped. The
+	 * classified VID is only communicated via the IFH, never in the
+	 * payload. We therefore restore it via hwaccel and must not pop an
+	 * in-band tag here.
+	 */
+	if (ifh_gap_len) {
+		/* The tag is restored as a C-tag, not as the TAG_TYPE the IFH
+		 * reports. The classifier recognizes both TPIDs as VLAN tags,
+		 * so an S-tag has already been used for classification by the
+		 * time we get here. Restoring it as 802.1AD would make the
+		 * bridge push it back into the payload and reclassify the frame
+		 * to the port pvid, on a different VID than the one the
+		 * hardware forwarded it on.
+		 */
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
+	}
+
+	return skb;
+}
+
+static void lan9645x_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+				  int *offset)
+{
+	u8 ifh_buf[LAN9645X_IFH_LEN_BYTES];
+	const __be16 *encap_proto;
+	__be16 proto_buf;
+	const u8 *ifh;
+	int tag_len;
+
+	*proto = 0;
+	*offset = 0;
+
+	ifh = skb_header_pointer(skb, LAN9645X_LONG_PREFIX_LEN - ETH_HLEN,
+				 LAN9645X_IFH_LEN_BYTES, ifh_buf);
+	if (!ifh)
+		return;
+
+	tag_len = lan9645x_ifh_gap_len(ifh);
+	if (tag_len < 0)
+		return;
+
+	tag_len += LAN9645X_TOTAL_TAG_LEN;
+
+	encap_proto = skb_header_pointer(skb, tag_len - sizeof(proto_buf),
+					 sizeof(proto_buf), &proto_buf);
+	if (!encap_proto)
+		return;
+
+	*proto = *encap_proto;
+	*offset = tag_len;
+}
+
+static const struct dsa_device_ops lan9645x_netdev_ops = {
+	.name			= LAN9645X_NAME,
+	.proto			= DSA_TAG_PROTO_LAN9645X,
+	.xmit			= lan9645x_xmit,
+	.rcv			= lan9645x_rcv,
+	.flow_dissect		= lan9645x_flow_dissect,
+	/* Covers the extraction prefix too, since dsa_tag_protocol_overhead()
+	 * sizes the conduit MTU from this.
+	 */
+	.needed_headroom	= LAN9645X_TOTAL_TAG_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for LAN9645x family of switches, using NPI port");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN9645X, LAN9645X_NAME);
+
+module_dsa_tag_driver(lan9645x_netdev_ops);

-- 
2.52.0

