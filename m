Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0743BCD04;
	Tue, 25 Aug 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638603; cv=none; b=PlphGLEuxeRgCJ3ULffhJydzkLk72loEVfT/Zs0p+sAnv83NXj98eNEuTNN3wZtWL4SBhfQWkDNokIaYU5kQ9q90af20SfG/ZDsADR/VCctgfiZLqKDmiCsI/ET4sC79/sscKpAYmLhjxL32+n2cerpSlttRsVMm5bUX4t9RtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638603; c=relaxed/simple;
	bh=2V8wY7TVpNHxk1Cr1fuy+ixDPMoRG9Yf+nOOuLUQemE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lg/x/sf9M9w6coofus78ZiSzIkgTZSMvWvM/VshAVIWO/UqlEfBXikIcHiRIRwpML3pbOZLjIYmNM0DaywCfKhJz4VNtIiUTAMZph5r3xBx5WT8DemMQ3bCe/QSLCJ4VtRib20XlKi1EXDpaYgg5+Ez38mQRwsUqFVzbIBLI0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437155|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0175438-0.000238198-0.982218;FP=10835553164181933712|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iwcg9DI_1787638588;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iwcg9DI_1787638588 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 25 Aug 2026 14:16:28 +0800
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
	jianmin.wang@motor-comm.com
Subject: [PATCH v3 net-next 1/2] net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
Date: Tue, 25 Aug 2026 14:16:09 +0800
Message-Id: <20260825061610.3116673-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
References: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the Motorcomm YT922x series, tag are supported, and with a
default TPID(Tag Protocol Identifier) 0x9988, and the tag occupies
8 bytes.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_yt922x.c | 111 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 net/dsa/tag_yt922x.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7507d632e7c6..d1c4f2abc8e1 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -61,6 +61,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_NETC_VALUE		33
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
 #define DSA_TAG_PROTO_MT7628_VALUE		35
+#define DSA_TAG_PROTO_YT922X_VALUE              36
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -99,6 +100,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 	DSA_TAG_PROTO_MT7628		= DSA_TAG_PROTO_MT7628_VALUE,
+	DSA_TAG_PROTO_YT922X		= DSA_TAG_PROTO_YT922X_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 23b4b74004ed..0b9f8a632cf2 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -227,4 +227,10 @@ config NET_DSA_TAG_YT921X
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
index d15bcf5c68f0..0c53f4184bdb 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
+obj-$(CONFIG_NET_DSA_TAG_YT922X) += tag_yt922x.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
new file mode 100644
index 000000000000..d973c1e02cc1
--- /dev/null
+++ b/net/dsa/tag_yt922x.c
@@ -0,0 +1,111 @@
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
+#define YT922X_TAG_LEN	8
+
+/*
+ * To define the from cpu tag format 8 bytes:
+ */
+#define YT922X_TAG_NAME			"yt922x"
+#define YT922X_TAG_PORTMASK_0		BIT(15)
+#define YT922X_TAG_PORTMASK_M		GENMASK(8, 0)
+#define  YT922X_TAG_PORTS(x)			FIELD_PREP(YT922X_TAG_PORTMASK_M, ((x) >> 0x1))
+#define YT922X_TAG_FORCE_DST		BIT(9)
+#define YT922X_TAG_PRIO_M		GENMASK(12, 10)
+#define YT922X_TAG_PRIO_EN		BIT(13)
+#define  YT922X_TAG_PRIO(x)			(FIELD_PREP(YT922X_TAG_PRIO_M, (x)) | YT922X_TAG_PRIO_EN)
+#define YT922X_TAG_RX_PORT_M		GENMASK(5, 2)
+#define YT922X_TAG_RX_PRIO_M		GENMASK(15, 13)
+
+static struct sk_buff *
+yt922x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	__be16 *tag;
+	u16 ctrl;
+
+	skb_push(skb, YT922X_TAG_LEN);
+	dsa_alloc_etype_header(skb, YT922X_TAG_LEN);
+	tag = dsa_etype_header_pos_tx(skb);
+
+	tag[0] = htons(ETH_P_YT921X);
+	if (dp->index != 0) {
+		/* Port index is not equal 0 in tag[1] */
+		ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
+			YT922X_TAG_PORTS(dsa_xmit_port_mask(skb, netdev));
+		tag[1] = htons(ctrl);
+		tag[2] = 0;
+	} else {
+		/* Port 0 in bit15 in tag[2] */
+		ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST;
+		tag[1] = htons(ctrl);
+		ctrl = YT922X_TAG_PORTMASK_0;
+		tag[2] = htons(ctrl);
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
+	.name   = YT922X_TAG_NAME,
+	.proto  = DSA_TAG_PROTO_YT922X,
+	.xmit   = yt922x_tag_xmit,
+	.rcv    = yt922x_tag_rcv,
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

