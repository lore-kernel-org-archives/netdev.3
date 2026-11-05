Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848500;
	b=wPNPxtTjKy+/8zaF1N+vFJjoHYaUMeQOWBcA75V/60ISgwjblI3ij56Q8TdKIiXxquY/
	 OMYRVV0I+3b61H4LRsZ2nw/2PA3vq9DjlmGH5hcEZjUBRvg9UQxo+vjSb4eNpJFGhuQF3
	 buQjepRXXXPgoAGKM4IYEUTDsQ6MBEyTD8zAEhRIic6uF4v6r0b+ls559LZH9wjCn92Ji
	 RnWfCVWj2XP0Jb9O343W2RI+W9BRwLq8enJCLzXmtj3+i0mxm0o97oMPyl7HtPd5eJOdQ
	 yVpw+cFcpGUpnMDOP7kxe7z3D1vkhRKa8ThdAREI+jXNqQkoG3apj5EhSWe4fRQQgyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848500;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=89HJq3j17qfXSpuvYLC/yhuEvLNw+77pM0D/ZB41kWk=;
	b=ubI+nt510cImIYcTgCmFpVKVTVAPSMxNHrPtcRqlrvN5zlaxVWQQ8QK95qT/IjI/FAv0
	 JLLSEopbGUlOlgsyRinQKZWkbyevzkmKoAyR5771WMflkKjbl1iYmMLbZb0SVZdp3T9Eb
	 SNtrQ6aaJqUb9EpPW9iJM9lRTceevCBhSPDBytvadJDRKQFQOp/q8AyAQ+TDUmde8TyoH
	 ojQyyTE0buy38WhNc1vWCPaRwooSTeqgxsqeb+g22NOjcpx218qWP552qZ0SSj7UqjT9x
	 Jhs5t03OjMRkQd8NhiGsv0xusUD58KGK2cj7mgXI6EISVb014rApmx83bxejQtZxqNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.194
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC72606A33E;
	Thu,  5 Nov 2026 03:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC72606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436306|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0208765-0.00028719-0.978836;FP=13141431387832458768|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jx7-i2e_1793848492;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jx7-i2e_1793848492 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:14:53 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v17 4/5] net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
Date: Thu,  5 Nov 2026 11:14:41 +0800
Message-Id: <20261105031442.4164960-5-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DSA tag support for Motorcomm YT922x switches.  YT922x uses the
same ETH_P_YT921X EtherType and the same 8-byte tag length as YT921x,
but the tag layout differs, so a separate tag driver is needed instead
of extending tag_yt921x.c.

The new driver documents both the to-CPU and from-CPU tag layouts.

Update the co-maintainer for the Motorcomm DSA driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 MAINTAINERS          |   2 +
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_yt922x.c | 122 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 net/dsa/tag_yt922x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..1ebe978115f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18817,11 +18817,13 @@ F:	drivers/net/phy/motorcomm.c
 
 MOTORCOMM YT921X ETHERNET SWITCH DRIVER
 M:	David Yang <mmyangfl@gmail.com>
+M:	Kyle Switch <kyle.switch@motor-comm.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 F:	drivers/net/dsa/motorcomm/
 F:	net/dsa/tag_yt921x.c
+F:	net/dsa/tag_yt922x.c
 
 MOXA SMARTIO/INDUSTIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@kernel.org>
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d12191b6f6f..5a173fe2bb87 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -62,6 +62,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
 #define DSA_TAG_PROTO_KS8995_VALUE		36
+#define DSA_TAG_PROTO_YT922X_VALUE		37
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -101,6 +102,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
 	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
+	DSA_TAG_PROTO_YT922X		= DSA_TAG_PROTO_YT922X_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4f44bf3ede23..06d8d6526054 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -233,4 +233,10 @@ config NET_DSA_TAG_YT921X
 	  Say Y or M if you want to enable support for tagging frames for
 	  Motorcomm YT921x switches.
 
+config NET_DSA_TAG_YT922X
+	tristate "Tag driver for Motorcomm YT922x switches"
+	help
+	  Say Y or M if you want to enable support for tagging frames for
+	  Motorcomm YT922x switches.
+
 endif
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 1f9cc30e9988..0ef6dfce3b92 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
+obj-$(CONFIG_NET_DSA_TAG_YT922X) += tag_yt922x.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
new file mode 100644
index 000000000000..b6146a9af98b
--- /dev/null
+++ b/net/dsa/tag_yt922x.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Motorcomm YT922x Switch Extended CPU Port Tagging
+ *
+ * Copyright (c) 2026 Kyle switch <kyle.switch@motor-comm.com>
+ *
+ */
+
+#include <linux/etherdevice.h>
+
+#include "tag.h"
+
+#define YT922X_TAG_LEN 8
+
+/*
+ * To define the from cpu tag format 8 bytes.
+ *
+ * To-CPU (RX) tag format, 8 bytes:
+ *
+ *   tag[0]: TPID (default: 0x9988)
+ *   tag[1]: VID lookup
+ *   tag[2]: bit 5:2  - RX source port
+ *
+ * From-CPU (TX) tag format, 8 bytes:
+ *
+ *   tag[0]: TPID (default: 0x9988)
+ *   tag[1]: bit 8:0 - Dst port mask
+ *   tag[2]: bit 15  - Dst port 0
+ *
+ */
+#define YT922X_TAG_NAME		"yt922x"
+#define YT922X_TAG_PORTMASK_0	BIT(15)
+#define YT922X_TAG_PORTMASK_M	GENMASK(8, 0)
+#define  YT922X_TAG_PORTS(x)		FIELD_PREP(YT922X_TAG_PORTMASK_M, (x))
+#define YT922X_TAG_FORCE_DST	BIT(9)
+#define YT922X_TAG_PRIO_M	GENMASK(12, 10)
+#define YT922X_TAG_PRIO_EN	BIT(13)
+#define  YT922X_TAG_PRIO(x)	(FIELD_PREP(YT922X_TAG_PRIO_M, (x)) | YT922X_TAG_PRIO_EN)
+#define YT922X_TAG_RX_PORT_M	GENMASK(5, 2)
+
+static struct sk_buff *
+yt922x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	unsigned long ports;
+	__be16 *tag;
+	u16 ctrl;
+
+	skb_push(skb, YT922X_TAG_LEN);
+	dsa_alloc_etype_header(skb, YT922X_TAG_LEN);
+	tag = dsa_etype_header_pos_tx(skb);
+
+	tag[0] = htons(ETH_P_YT921X);
+	ports = dsa_xmit_port_mask(skb, netdev);
+	/*To fill in the case where the port index is not 0 */
+	ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
+	       YT922X_TAG_PORTS(ports >> 1);
+	tag[1] = htons(ctrl);
+	if (ports & BIT(0)) {
+		/* To fill in the case where the port index is 0 */
+		ctrl = YT922X_TAG_PORTMASK_0;
+		tag[2] = htons(ctrl);
+	} else {
+		tag[2] = 0;
+	}
+	tag[3] = 0;
+
+	return skb;
+}
+
+static struct sk_buff *
+yt922x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	unsigned int port;
+	__be16 *tag;
+	u16 rx;
+
+	if (unlikely(!pskb_may_pull(skb, YT922X_TAG_LEN))) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	tag = dsa_etype_header_pos_rx(skb);
+
+	if (unlikely(tag[0] != htons(ETH_P_YT921X))) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Unexpected EtherType 0x%04x\n",
+				     ntohs(tag[0]));
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Locate which port this is coming from */
+	rx = ntohs(tag[2]);
+	port = FIELD_GET(YT922X_TAG_RX_PORT_M, rx);
+	skb->dev = dsa_conduit_find_user(netdev, 0, port);
+	if (unlikely(!skb->dev)) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Couldn't decode source port %u\n", port);
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Remove tag and update checksum */
+	skb_pull_rcsum(skb, YT922X_TAG_LEN);
+	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
+
+	return skb;
+}
+
+static const struct dsa_device_ops yt922x_netdev_ops = {
+	.name = YT922X_TAG_NAME,
+	.proto = DSA_TAG_PROTO_YT922X,
+	.xmit = yt922x_tag_xmit,
+	.rcv = yt922x_tag_rcv,
+	.needed_headroom = YT922X_TAG_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Motorcomm YT922x switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_YT922X, YT922X_TAG_NAME);
+
+module_dsa_tag_driver(yt922x_netdev_ops);
-- 
2.25.1

