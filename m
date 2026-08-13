Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DD417D7A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647850; cv=none; b=eyg96dWweRagPgdWCHvVlVRv35bdnWeOuUN7GWgYqtANh99qcWZ3V1M6G5y12L2NQ8CjAxvYFMU2WdKdAf72UMAGI/xQTWP05DqjGIp/T/bYTsqmXiyG8/+lX7pCvvK4PPrgI3D2OJ67BN+IfdzuH/fFh1kS7JuYlclAI8+P2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647850; c=relaxed/simple;
	bh=CPXDwaPbKTNDHjgs4dTLg2HNAE9Z3YzE8UwNjzdTlSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h47GmiXAQ/aHKOmr/crcjIUq5Tw9+6WWNdDU1mSmwlBEJrV/cODLNjS/AFQgSoyJWYWFfh9f6UHNBLIMg8oDGn079QQtE0+xivCm9QC+pJWsV3hGhnPYchgrP5xsS5PRO1sFllxrhh3hdbWZOrojwezkOyXF2fhtNRJTLqOMD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=Mxo8vglG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=pP0wcYJR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="Mxo8vglG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="pP0wcYJR"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Mxo8vglGMj+eF69AkTV/P1myTlXlubL8go1T5lx4LqCcgk8Wncut+NiqaiwRzWrS9gzW+mbaNz/A19EhvYH/nz940ANCPIaL+TigyKhzRjH6Ajd/7VpkF6b0mlfO3kA/hYiduVC1MkmZAGC/SdyPgcv68gllRm6PHUiRjcFcPnFACIFwNUCLg2lSLqFPEcA0IEGVDcpG7L7+asf3bISm3PmcHm5A5sSibMDbUfQMng+metmUMSwBmWC63NzwbG1JHbkfRfCK4ku3wgLxti7aZCP+pDqoCiTVwAr1Sc8bDLPb+u+M9imyJBgMKLWvM4YqipWo6R9LqlN0RsARRHV/SQ==; s=purelymail3; d=tinyisr.com; v=1; bh=CPXDwaPbKTNDHjgs4dTLg2HNAE9Z3YzE8UwNjzdTlSk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=pP0wcYJRkZnnLoaiXl0ruVA57VVqSJPSO4f8BJ8ewSnyL53cyTxijhu0gwyVU2bg61HfaFhSG9gaL5DSl4YpXvrnDsgQHI5+iwsXM72mmL00R0R0pHgzHYTD7cuspO1776q+JeT64+XK66A+2yB6Nomg49pKLHKZowjMIAVsL7tLoPDs2MtOcoHgiKoJE8DBcKbqzqY9H5zxS79H8lxgZUNsXM2P37g7l8el6X4Y0sV7BhsUpS93rZymaACcRBGQUDyyE0bjcfdUl3WLnK1T/fzhYY+UrKcqoD6+rMqEt3Zkw0zeBm84kFuHD4+Gdq7AdgD0LlV+xWuVms+crWP/lg==; s=purelymail3; d=purelymail.com; v=1; bh=CPXDwaPbKTNDHjgs4dTLg2HNAE9Z3YzE8UwNjzdTlSk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1221505461;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 19:04:00 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v7 3/4] net: dsa: initial MT7628 tagging driver
Date: Thu, 13 Aug 2026 22:02:40 +0300
Message-ID: <20260813190241.789323-4-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813190241.789323-1-joey@tinyisr.com>
References: <20260813190241.789323-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add support for the MT7628 embedded switch's tag.

The MT7628 tag is merged with the VLAN TPID field when a VLAN is
appended by the switch hardware. It is not installed if the VLAN tag is
already there on ingress. Due to this hardware quirk the tag cannot be
trusted for port 0 if we don't know that the VLAN was added by the
hardware. As a workaround for this the switch is configured to always
append the port PVID tag even if the incoming packet is already tagged.
The tagging driver can then trust that the tag is always accurate and
the whole VLAN tag can be removed on ingress as it's only metadata for
the tagger.

On egress the MT7628 tag allows precise TX, but the correct VLAN tag
from tag_8021q is still appended or the switch will not forward the
packet.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 include/net/dsa.h    |  2 +
 net/dsa/Kconfig      |  6 +++
 net/dsa/Makefile     |  1 +
 net/dsa/tag_mt7628.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 net/dsa/tag_mt7628.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6f7f5c17b532..7507d632e7c6 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -60,6 +60,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL862_VALUE=09=0932
 #define DSA_TAG_PROTO_NETC_VALUE=09=0933
 #define DSA_TAG_PROTO_KSZ8463_VALUE=09=0934
+#define DSA_TAG_PROTO_MT7628_VALUE=09=0935
=20
 enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_NONE=09=09=3D DSA_TAG_PROTO_NONE_VALUE,
@@ -97,6 +98,7 @@ enum dsa_tag_protocol {
 =09DSA_TAG_PROTO_MXL862=09=09=3D DSA_TAG_PROTO_MXL862_VALUE,
 =09DSA_TAG_PROTO_NETC=09=09=3D DSA_TAG_PROTO_NETC_VALUE,
 =09DSA_TAG_PROTO_KSZ8463=09=09=3D DSA_TAG_PROTO_KSZ8463_VALUE,
+=09DSA_TAG_PROTO_MT7628=09=09=3D DSA_TAG_PROTO_MT7628_VALUE,
 };
=20
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index d5e725b90d78..23b4b74004ed 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
 =09  Say Y or M if you want to enable support for tagging frames for the
 =09  Marvell switches which use EtherType DSA headers.
=20
+config NET_DSA_TAG_MT7628
+=09tristate "Tag driver for the MT7628 embedded switch"
+=09help
+=09  Say Y or M if you want to enable support for tagging frames for the
+=09  switch embedded in the MT7628 SoC.
+
 config NET_DSA_TAG_MTK
 =09tristate "Tag driver for Mediatek switches"
 =09help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index b8c2667cd14a..d15bcf5c68f0 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) +=3D tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) +=3D tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) +=3D tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) +=3D tag_lan9303.o
+obj-$(CONFIG_NET_DSA_TAG_MT7628) +=3D tag_mt7628.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) +=3D tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) +=3D tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) +=3D tag_mxl-gsw1xx.o
diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
new file mode 100644
index 000000000000..80b50ff08e53
--- /dev/null
+++ b/net/dsa/tag_mt7628.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Joris Vaisvila <joey@tinyisr.com>
+ * MT7628 switch tag support
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/dsa/8021q.h>
+#include <net/dsa.h>
+
+#include "tag.h"
+
+/*
+ * The MT7628 tag is encoded in the VLAN TPID field.
+ * On TX the lower 6 bits encode the destination port bitmask.
+ * On RX the lower 3 bits encode the source port number.
+ *
+ * The switch hardware will not modify the TPID of an incoming packet if i=
t is
+ * already VLAN tagged. To work around this the switch is configured to al=
ways
+ * append a tag_8021q standalone VLAN tag for each port. That means we can
+ * safely strip the outer VLAN tag after parsing it.
+ *
+ * A VLAN tag is constructed on egress to target the standalone VLAN and
+ * destination port.
+ */
+
+#define MT7628_TAG_NAME "mt7628"
+
+#define MT7628_TAG_TX_PORT GENMASK(5, 0)
+#define MT7628_TAG_RX_PORT GENMASK(2, 0)
+#define MT7628_TAG_LEN 4
+
+static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
+=09=09=09=09       struct net_device *dev)
+{
+=09struct dsa_port *dp;
+=09u16 xmit_vlan;
+=09__be16 *tag;
+
+=09dp =3D dsa_user_to_port(dev);
+=09xmit_vlan =3D dsa_tag_8021q_standalone_vid(dp);
+
+=09skb_push(skb, MT7628_TAG_LEN);
+=09dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
+
+=09tag =3D dsa_etype_header_pos_tx(skb);
+
+=09tag[0] =3D htons(ETH_P_8021Q |
+=09=09       FIELD_PREP(MT7628_TAG_TX_PORT,
+=09=09=09=09  dsa_xmit_port_mask(skb, dev)));
+=09tag[1] =3D htons(xmit_vlan);
+
+=09return skb;
+}
+
+static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
+=09=09=09=09      struct net_device *dev)
+{
+=09__be16 *phdr;
+
+=09if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN))) {
+=09=09kfree_skb(skb);
+=09=09return NULL;
+=09}
+
+=09phdr =3D dsa_etype_header_pos_rx(skb);
+=09skb->dev =3D
+=09    dsa_conduit_find_user(dev, 0,
+=09=09=09=09  FIELD_GET(MT7628_TAG_RX_PORT, ntohs(*phdr)));
+=09if (!skb->dev) {
+=09=09kfree_skb(skb);
+=09=09return NULL;
+=09}
+
+=09skb_pull_rcsum(skb, MT7628_TAG_LEN);
+=09dsa_strip_etype_header(skb, MT7628_TAG_LEN);
+=09dsa_default_offload_fwd_mark(skb);
+=09return skb;
+}
+
+static const struct dsa_device_ops mt7628_tag_ops =3D {
+=09.name =3D MT7628_TAG_NAME,
+=09.proto =3D DSA_TAG_PROTO_MT7628,
+=09.xmit =3D mt7628_tag_xmit,
+=09.rcv =3D mt7628_tag_rcv,
+=09.needed_headroom =3D MT7628_TAG_LEN,
+};
+
+module_dsa_tag_driver(mt7628_tag_ops);
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MT7628, MT7628_TAG_NAME);
+MODULE_DESCRIPTION("DSA tag driver for MT7628 switch");
+MODULE_LICENSE("GPL");
--=20
2.55.0

