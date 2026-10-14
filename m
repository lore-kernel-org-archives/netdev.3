Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64104908CA
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962612; cv=none; b=jMrXFUZqf58YENJT8efMbXKHIrWBh243EpRFRy/eTTOs+J96KOzV1C22lW1syeFcEzyDJOcX+OeI4L6tgEw+amzIyrfM56qbvhvB2DBvM+T3lHLnPc+xbeOWNQAU9gFL6zpZnfTxNqsLa+pu2fng1haMpnyJTOkqZBMqNyaoWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962612; c=relaxed/simple;
	bh=p7Yf0WK2RMKNG7XPWoQVavU/dg5zXYJxJmxAg5Cq/Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbayepBx/jHF5Ym4r937zqPl59qgXq0pNVeXYtST9uM9am3JQemR18ryPJncvB4P+icV/5zFWaB0ibXvlEuu4nD0z6MwAk6KztUre5ItmuRQAmYDV7X789fX1jv7fR7ElIqByQseJKILfA0ermKPbW1wmtobzxZUPsw9tA9o2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijQN6Ftq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijQN6Ftq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-486e70f2457so47689f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962594; x=1792567394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzX06tZzoccjgdsi2vPWEkxOF+J9qfaGnc2iTVC9QEU=;
        b=ijQN6FtqnzshzG75XHbYgZiSR8oBfjNSCWgj7tTbYFPdEsFg3OZn9KeoYiB8b8KRg4
         dLejggCQV9oFv5zWNdpU0egf+ZKhAUDSvX7Vpmj2sWIUUyQdtv0ECRcHwP9gLv8stGd7
         moPzkM9zKvPOyliE7rFWV7qXJJaoz4GtxCSsBUK/De4J+3ozI3UGvjBdQyZs5uKCXq9W
         nrQ6cn+3XNTXSGGs2XcUDOMm2h3pomwLz8s5iPUMR1o5daSwKib40hIjCR/lOddpC3bV
         NoT1dssmFV2iKc4NJ9ziMlhjLBIGBETiIhODhE0oJp73Lqcp87f2PehGa6b7gTsXh1o4
         ajDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962594; x=1792567394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VzX06tZzoccjgdsi2vPWEkxOF+J9qfaGnc2iTVC9QEU=;
        b=j9WSJ3WGoRxwig0BCx6rBjF9Ff3bciSQLRzGcpLnATfdJjiwne5zuOM087//542f94
         XCIiyM3AXZYdwY6JqxdjqCDGn4TDJr8x6jfwXlbnpDL1rOSMPwpKD54/HMU7E53MX/b5
         WPXd5ml4kP1epu4x9I/S5VkEnhFBjaOFUHh6eE+cx86RzAUz9+r8abFFaUqi/zD4vvEU
         0MxGJsYTwu/Dj1c4CJBEuL1RS7aWLGrNaQgunMuAajP0sR80neFOTA3GWV1Lp4Nutthb
         PHlGiyIEltcZmkSw9/DSn1BDYHzYSf6h8qwNRyu5wbv3OSHmpvoC9nQVDxD+VikNju+K
         T4QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDEepj8qM7IE0VkmP7Q6907gkmTlK7YXMomT6PzQf6KNj5aNp0nQxbo0r0gXftJnGQ5kH+2c4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLikLmH+8IJhYLx3dGxbueWn/gWp9aUM5vZ8rmUE2mMug4H7bOo
	eqKCM3EYXt67FjjHA2waGqX9YHcMk09+pRpHdJ5OboUvEfK/Mztk7nsv
X-Gm-Gg: AYBFou3IoiW+RE7rmq9KuBKZVZbjcIrJ6tUJprp7qmw30mMfJkNjmoX3TskKUSCRkjc
	cMDqw9uXj9saW/7wa4nOA/PpcEwu2uZtVTBCMGst+H4LcCjX7z6PwFdxSkEQQbkokt+gi1ygnZP
	Hl0zHW057nipocLAy+mrObkjmGSWN2BTL4iNILe1scaI6x2OtPmdrSKo7kcqHGuSSlpqktkxbJY
	hOBp+9ZJMt0JK0kPpntslqEkm4jEVzK6Q21KgD+Sk2PPN9mNDiweisuO7IqUBxzV1AZc+ELuPaZ
	Tqjldz1xc4kkaqDEqjJQhJTtbL2PizfZFE31A28fbONIwLgMRR0msX2a2ZrmdFx/dFdZZ8+c94M
	rtT2kdcDLQTHE3qFVLNM93YO37lfTmajGQ+GU1OQ1j7hOadl26TyeWvs5N+w+lGNNdVaPrdoPgA
	mOMr//7/RFL9Te8ZvzEjoLggGJeZVU2+V3FTydyzoq+iF3F+Kom1rL4OYBZ1I/1qBRPt3Jy0bkb
	rbM+k1/3uC40TV5c6ENh0q+c41/81DnjsdserWXMWjB9OgzbyHC/YeG1VqUCPh491FlaPKbqK3f
	GKRcM1V1He5zV6i6a/fMlAdLokDArLwAdLBkWm8AB47r3QY+zFsSCQ8l2FuVkA==
X-Received: by 2002:a05:6000:491c:b0:48c:4272:86b2 with SMTP id ffacd0b85a97d-48dba9bdcfemr29571176f8f.11.1791962592961;
        Wed, 14 Oct 2026 00:23:12 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:12 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Junyang Han <han.junyang@zte.com.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 18/24] net: ethernet: zte: Add ZX279128S Ethernet switch driver
Date: Wed, 14 Oct 2026 08:20:58 +0100
Message-ID: <20261014072109.1759502-19-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide per-port interfaces, phylink, IRQ NAPI, switchdev bridge
forwarding, hardware IPv4 flow offload and verified standard MAC
statistics. Use software fallback for unsupported VLAN and routing
cases.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 drivers/net/ethernet/zte/Kconfig            |   13 +
 drivers/net/ethernet/zte/Makefile           |    3 +
 drivers/net/ethernet/zte/zx279128s-eth.h    |  386 +++++
 drivers/net/ethernet/zte/zx279128s-main.c   | 1502 +++++++++++++++++++
 drivers/net/ethernet/zte/zx279128s-ppe.c    |  805 ++++++++++
 drivers/net/ethernet/zte/zx279128s-switch.c |  368 +++++
 6 files changed, 3077 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/zx279128s-eth.h
 create mode 100644 drivers/net/ethernet/zte/zx279128s-main.c
 create mode 100644 drivers/net/ethernet/zte/zx279128s-ppe.c
 create mode 100644 drivers/net/ethernet/zte/zx279128s-switch.c

diff --git a/drivers/net/ethernet/zte/Kconfig b/drivers/net/ethernet/zte/Kconfig
index b95c2fc7db..20df75486f 100644
--- a/drivers/net/ethernet/zte/Kconfig
+++ b/drivers/net/ethernet/zte/Kconfig
@@ -17,4 +17,17 @@ if NET_VENDOR_ZTE
 
 source "drivers/net/ethernet/zte/dinghai/Kconfig"
 
+config ZX279128S_ETH
+	bool "ZTE zx279128s Ethernet switch support"
+	depends on ARCH_ZTE || COMPILE_TEST
+	depends on OF
+	depends on BRIDGE=y || BRIDGE=n
+	select NET_SWITCHDEV
+	select PHYLINK
+	help
+	  This driver supports the five-port gigabit switch of the ZTE
+	  zx279128s SoC and the DMA engine that connects it to the CPU.
+	  Each switch port becomes its own network interface, such as the
+	  four LAN ports and the WAN port of the ZTE ZXHN H3600.
+
 endif # NET_VENDOR_ZTE
diff --git a/drivers/net/ethernet/zte/Makefile b/drivers/net/ethernet/zte/Makefile
index cd9929b615..09b4f6558d 100644
--- a/drivers/net/ethernet/zte/Makefile
+++ b/drivers/net/ethernet/zte/Makefile
@@ -4,3 +4,6 @@
 #
 
 obj-$(CONFIG_DINGHAI) += dinghai/
+
+obj-$(CONFIG_ZX279128S_ETH) += zx279128s-eth.o
+zx279128s-eth-y := zx279128s-main.o zx279128s-ppe.o zx279128s-switch.o
diff --git a/drivers/net/ethernet/zte/zx279128s-eth.h b/drivers/net/ethernet/zte/zx279128s-eth.h
new file mode 100644
index 0000000000..6c6e187cce
--- /dev/null
+++ b/drivers/net/ethernet/zte/zx279128s-eth.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE zx279128s Ethernet switch and DMA driver: registers and shared state
+ *
+ * Copyright (C) 2026 Navid Ghahremani <ghahramani.navid@gmail.com>
+ */
+
+#ifndef ZX279128S_ETH_H
+#define ZX279128S_ETH_H
+
+#include <linux/bitmap.h>
+#include <linux/hrtimer.h>
+#include <linux/if_ether.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/notifier.h>
+#include <linux/phylink.h>
+#include <linux/rhashtable.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#define DRV_NAME		"zx279128s-eth"
+
+/*
+ * Register offsets from the start of the block (0x92000000). The names follow
+ * the vendor modules where they are known. Registers that only appear in the
+ * vendor's init sequences, with no known meaning, keep their offsets.
+ */
+
+/* Global control */
+#define ZX_GLB_RESET		0x000008	/* write 0, then all ones */
+#define ZX_GLB_CLK_CTRL		0x040018
+#define  ZX_GLB_CLK_CTRL_BITS	GENMASK(1, 0)	/* cleared by the vendor code */
+#define ZX_GLB_PORT_CLK_EN	0x04001c	/* bit n: clock of MAC port n */
+
+/* Switch core */
+#define ZX_SW_PORT_FILTER(p)	(0x1c0060 + 4 * (p))
+#define  ZX_SW_PORT_FILTER_BITS	GENMASK(25, 23)	/* cleared for every port */
+#define ZX_SW_FWD_CTRL		0x1cc000
+#define  ZX_SW_FWD_CTRL_ON	17
+
+/* Switch port attributes (stock tm.ko "spa") */
+#define ZX_SPA_UP_REG_PKT_EN	0x1d4000
+#define ZX_SPA_DN_REG_PKT_EN	0x1d4040
+#define ZX_SPA_TRAP_DMAC	0x1d41a0	/* 8 bytes per entry */
+#define  ZX_SPA_TRAP_DMAC_NUM	2		/* entries the driver uses */
+#define ZX_SPA_TRAP_PROTO	0x1d41c0
+#define ZX_SPA_TRAP_ETH_TYPE	0x1d41c4	/* 4 x 16 bits, big end first */
+#define ZX_SPA_PORT_EN(i)	(0x1d428c + 4 * (i))
+#define ZX_SPA_ONU_MAC		0x1d4120	/* 16 x 8 bytes: our MACs, routed */
+#define  ZX_SPA_ONU_MAC_NUM	16
+#define ZX_SPA_REG_PKT_TCP_ACK	BIT(4)		/* word 2: TCP without payload */
+
+/* MAC ports 0-4 */
+#define ZX_MAC_BASE		0x200000
+#define ZX_PORT_STRIDE		0x040000
+#define ZX_MAC_PORT(p)		(ZX_MAC_BASE + (p) * ZX_PORT_STRIDE)
+#define ZX_MAC_CTRL		0x000
+#define  ZX_MAC_CTRL_EN		GENMASK(1, 0)	/* receive and transmit */
+#define  ZX_MAC_CTRL_FD		BIT(13)		/* full duplex */
+#define  ZX_MAC_CTRL_100	BIT(14)		/* 100 Mbit/s, with _MII */
+#define  ZX_MAC_CTRL_MII	BIT(15)		/* 10 or 100 Mbit/s */
+
+/* MAC port counters: 32 bits, not cleared by reading */
+#define ZX_MAC_TX_HIST(i)	(0x724 + 4 * (i))	/* frame size bins */
+#define ZX_MAC_TX_MCAST		0x740
+#define ZX_MAC_TX_BCAST		0x744
+#define ZX_MAC_TX_OCTETS	0x764
+#define ZX_MAC_TX_FRAMES	0x768
+#define ZX_MAC_RX_OCTETS	0x784
+#define ZX_MAC_RX_BCAST		0x78c
+#define ZX_MAC_RX_MCAST		0x790
+#define ZX_MAC_RX_HIST(i)	(0x7ac + 4 * (i))
+#define ZX_MAC_RX_UCAST		0x7c4
+#define ZX_MAC_HIST_BINS	6	/* 64, 65-127, ... 1024 bytes and up */
+
+/* Traffic manager */
+#define ZX_TM_BASE		0x340000
+#define ZX_TM_CTRL		(ZX_TM_BASE + 0x00)
+#define  ZX_TM_CTRL_BIT6	BIT(6)		/* set by the vendor code */
+#define ZX_TM_CONFIG_START	(ZX_TM_BASE + 0x04)
+#define ZX_TM_TAB0_ADDR		(ZX_TM_BASE + 0xe8)
+#define ZX_TM_TAB1_ADDR		(ZX_TM_BASE + 0xec)
+#define ZX_TM_BUF_F0		(ZX_TM_BASE + 0xf0)
+#define ZX_TM_BUF_START		(ZX_TM_BASE + 0xf4)
+#define ZX_TM_BUF_END		(ZX_TM_BASE + 0xf8)
+#define ZX_TM_TAB_LIMIT		(ZX_TM_BASE + 0xfc)
+#define ZX_TM_INT_STATUS	(ZX_TM_BASE + 0x100)
+#define ZX_TM_INT_MASK		(ZX_TM_BASE + 0x104)	/* 1: masked */
+#define  ZX_TM_INT_RX		GENMASK_U32(1, 0)		/* frames for the CPU */
+
+/* Traffic manager tables, reached through an indirect access window */
+#define ZX_TM_IND_CMD		(ZX_TM_BASE + 0x4014)
+#define  ZX_TM_IND_INDEX	GENMASK(21, 0)
+#define  ZX_TM_IND_TABLE	GENMASK(26, 22)
+#define  ZX_TM_IND_READ		BIT(27)
+#define ZX_TM_IND_STATUS	(ZX_TM_BASE + 0x4018)
+#define  ZX_TM_IND_READY	BIT(0)
+#define ZX_TM_IND_DATA(i)	(ZX_TM_BASE + 0x401c + 4 * (i))
+#define ZX_TM_TABLE_QUEUE	0
+#define ZX_TM_TABLE_QUEUE_USE	1
+#define ZX_TM_TABLE_RED		2
+#define ZX_TM_TABLE_SCHED	4
+
+/* Release of consumed RX slots */
+#define ZX_RX_REL_CTRL		(ZX_TM_BASE + 0x4064)
+#define  ZX_RX_REL_BUSY		BIT(0)
+#define ZX_RX_REL_DATA		(ZX_TM_BASE + 0x4068)
+#define  ZX_RX_REL_QUEUE	GENMASK(2, 0)
+#define  ZX_RX_REL_CLASS	BIT(3)
+#define  ZX_RX_REL_COUNT	GENMASK(13, 4)
+
+/* Buffer management unit */
+#define ZX_BMU_BASE		(ZX_TM_BASE + 0x8000)
+#define ZX_BMU_CTRL		(ZX_BMU_BASE + 0x00)
+#define  ZX_BMU_CTRL_EN		BIT(0)
+#define ZX_BMU_CFG1		(ZX_BMU_BASE + 0x04)
+#define ZX_BMU_CFG2		(ZX_BMU_BASE + 0x08)
+#define ZX_BMU_BUF_ID		(ZX_BMU_BASE + 0x0c)
+#define  ZX_BMU_BUF_ID_VALID	BIT(31)
+#define  ZX_BMU_BUF_ID_BP	GENMASK(15, 0)
+#define ZX_BMU_BUF_FREE		(ZX_BMU_BASE + 0x10)
+#define ZX_BMU_BUF_ALLOC	(ZX_BMU_BASE + 0x14)
+#define  ZX_BMU_BUF_ALLOC_REQ	BIT(0)
+#define  ZX_BMU_BUF_ALLOC_BUSY	GENMASK(1, 0)
+#define ZX_BMU_FREE_STATUS	(ZX_BMU_BASE + 0xdc)
+#define  ZX_BMU_FREE_SLOTS	GENMASK(8, 3)
+#define ZX_BMU_THRES1		(ZX_BMU_BASE + 0x48)
+#define ZX_BMU_THRES2		(ZX_BMU_BASE + 0x4c)
+#define ZX_BMU_LIMIT1		(ZX_BMU_BASE + 0x58)
+#define ZX_BMU_LIMIT2		(ZX_BMU_BASE + 0x5c)
+
+/* DMA engine between the switch and the CPU */
+#define ZX_DMA_BASE		(ZX_TM_BASE + 0x10000)
+#define ZX_DMA_CTRL		(ZX_DMA_BASE + 0x00)
+#define  ZX_DMA_CTRL_EN		GENMASK(19, 16)
+#define  ZX_DMA_CTRL_BIT21	BIT(21)		/* always set, as in the vendor code */
+#define ZX_DMA_RX_IRQ_TIMER	(ZX_DMA_BASE + 0x30)	/* in 20 ns ticks */
+#define ZX_DMA_RX_IRQ_FRAMES	(ZX_DMA_BASE + 0x34)
+#define ZX_DMA_RING_CFG		(ZX_DMA_BASE + 0x3c)
+#define ZX_DMA_AREA50		(ZX_DMA_BASE + 0x50)	/* 1 MiB area, use unknown */
+#define ZX_DMA_TX_RING		(ZX_DMA_BASE + 0x60)	/* ring of frames to send */
+#define ZX_DMA_TX_START		(ZX_DMA_BASE + 0x64)
+#define ZX_DMA_RX_QUEUE_CNT(q)	(ZX_DMA_BASE + 0x100 + ((q) * 4))
+
+/* Packet processor */
+#define ZX_PP_RESET		0x380000
+
+/* Bridge block (sbrg), ports numbered with ZX_BRPORT() */
+#define ZX_SBRG_PORT_CTRL	0x388004
+#define ZX_SBRG_FLUSH_PORTS	GENMASK(15, 8)	/* drop the entries of these */
+#define ZX_SBRG_FLUSH		BIT(16)
+#define ZX_SBRG_IND_CMD		0x388014	/* 27: read, 26-22: memory, 11-0: entry */
+#define ZX_SBRG_IND_READ	BIT(27)
+#define ZX_SBRG_IND_DONE	0x388018
+#define ZX_SBRG_IND_DATA(i)	(0x38801c + 4 * (i))
+#define ZX_SBRG_TABLE_SEL	0x388184	/* source table: 4 RAMs of 1024/256/512 */
+#define ZX_SBRG_LEARN		0x3881c0	/* ports that learn source MACs */
+#define ZX_SBRG_EGRESS(bp)	(0x3883c0 + 4 * (bp))	/* ports bp may send to */
+#define ZX_SBRG_MEM_VLAN	4		/* 1 word per VID */
+#define ZX_SBRG_VLAN_VALID	BIT(0)
+#define ZX_SBRG_VLAN_UNTAG(bp)	(1 << (2 * (bp) + 1))
+
+/* Packet processor tables, reached through an indirect access window:
+ * command (index | table << 22 | read << 27), status bit 0 = idle, data.
+ * The classifier (CLA) has 17 data words, the packet modifier (PM) 8.
+ */
+#define ZX_CLA_BASE		0x38c000
+#define ZX_PM_BASE		0x39c000
+#define ZX_PP_IND_CMD		0x14
+#define ZX_PP_IND_STATUS	0x18
+#define ZX_PP_IND_DATA		0x1c
+#define ZX_PM_IND_DATA_HI	0x100	/* PM data words 4-7 */
+#define ZX_PP_IND_READ		BIT(27)
+
+#define ZX_CLA_EXTRA_INDEX	0	/* header fields each packet type extracts */
+#define ZX_CLA_EXTRA_RULE	1
+#define ZX_CLA_HASH0		2	/* 256 flow entries, CRC-32 slot */
+#define ZX_CLA_HASH1		3	/* 128 flow entries, CRC-32C slot */
+#define ZX_CLA_AGING		8	/* hit flags, bank 0 then bank 1 */
+#define ZX_PM_FLOW		0	/* rewrite of a flow */
+#define ZX_PM_NEXT_HOP		1	/* new destination IP and MAC */
+#define ZX_PM_CMD		3
+#define ZX_PM_SUB		6
+#define ZX_PM_SRC_MAC		12	/* source MAC of each subnet */
+#define ZX_PP_SNAT_IP(s)	(0x3a0400 + (s) * 4)	/* source IP of each subnet */
+
+#define ZX_PPE_HASH0_SIZE	256
+#define ZX_PPE_HASH_SIZE	(256 + 128)
+/*
+ * The rewrite index in a classifier entry has 7 bits (ZX_CLA_W0_FLOW), and
+ * the stock firmware never used more than 125, so only 127 flows (1-127) can
+ * be offloaded at a time. More would reuse the rewrite of another flow.
+ */
+#define ZX_PPE_FLOWS		128
+#define ZX_PPE_NEXT_HOPS	512
+#define ZX_PPE_SUBNETS		16
+/* IPv4 TCP/UDP: extract index 9 and its rule; hashed with this rule id */
+#define ZX_PPE_V4_INDEX		9
+#define ZX_PPE_V4_RULE		0x98
+
+/* Word 0 of a classifier hash entry */
+#define ZX_CLA_W0_FLOW		GENMASK(31, 25)	/* packet modifier rewrite index */
+#define ZX_CLA_W0_FWD		BIT(24)		/* forward to the egress port */
+#define ZX_CLA_W0_EGRESS	GENMASK(15, 12)	/* bridge port, ZX_BRPORT() */
+#define ZX_CLA_W0_BITS		0x44		/* as in every stock entry */
+
+/* Bridge ports: 0 is the PON side, 1-5 are the switch ports 0-4 */
+#define ZX_BRPORT(p)		((p) + 1)
+
+/* DMA buffer pool: 4096 buffers x 2048 bytes = 8 MiB */
+#define ZX_NUM_BUFFERS		4096
+#define ZX_BUF_SIZE		2048
+#define ZX_BUF_POOL_SIZE	(ZX_NUM_BUFFERS * ZX_BUF_SIZE)
+
+/* Free-index tables (written big-endian u16 per U-Boot convention) */
+#define ZX_TAB0_ENTRIES		ZX_NUM_BUFFERS
+#define ZX_TAB1_ENTRIES		512
+
+/* DMA descriptor rings */
+#define ZX_NUM_TX_DESC		1024
+#define ZX_TX_QUEUE_LIMIT	256
+#define ZX_TX_POLL_US		250	/* see zx_tx_kick() */
+
+/*
+ * The RX interrupt comes after this many frames, or this long after the
+ * first one.  Larger batches cost less per frame: 500 us receive faster
+ * than polling every 1 ms did and still answer sooner.
+ */
+#define ZX_RX_IRQ_FRAMES	64
+#define ZX_RX_IRQ_USECS		500
+#define ZX_NUM_RX_DESC		1024
+#define ZX_DESC_SIZE		16	/* bytes per descriptor */
+
+/* Layout of the 16 MiB DMA arena */
+#define ZX_DMA_ARENA_SIZE	0x1000000
+#define ZX_TAB0_OFFSET		0x800000
+#define ZX_TAB1_OFFSET		0x808000
+#define ZX_RX_OFFSET		0xa00000
+#define ZX_AREA50_OFFSET	0xb00000
+#define ZX_TX_OFFSET		0xc00000
+/* RX ring of queue q at ZX_RX_OFFSET + q * 16 KiB (1024 descriptors) */
+#define ZX_RX_QUEUE_STRIDE	0x4000
+#define ZX_RX_QUEUES		8
+#define ZX_DMA_TX_DONE		(ZX_DMA_BASE + 0x68)
+
+struct zx_eth_adapter;
+
+/* One net_device per switch port: ports 0-3 LAN, port 4 WAN */
+#define ZX_NUM_PORTS		5
+/* TM egress queue of switch port p (as in the vendor driver) */
+#define ZX_PORT_TX_QUEUE(p)	(40 + (p))
+/* MACs the Linux bridge moved away from a switch port, queued for removal */
+#define ZX_SW_FDB_QUEUE		16
+
+/* The MAC counters the driver keeps, see zx_mib_regs[] */
+enum zx_mib {
+	ZX_MIB_TX_OCTETS,
+	ZX_MIB_TX_FRAMES,
+	ZX_MIB_TX_MCAST,
+	ZX_MIB_TX_BCAST,
+	ZX_MIB_TX_HIST,
+	ZX_MIB_RX_OCTETS = ZX_MIB_TX_HIST + ZX_MAC_HIST_BINS,
+	ZX_MIB_RX_UCAST,
+	ZX_MIB_RX_MCAST,
+	ZX_MIB_RX_BCAST,
+	ZX_MIB_RX_HIST,
+	ZX_MIB_NUM = ZX_MIB_RX_HIST + ZX_MAC_HIST_BINS,
+};
+
+struct zx_eth_priv {
+	struct net_device	*netdev;
+	struct zx_eth_adapter	*adapter;
+	int			port;
+	struct phylink		*phylink;
+	struct phylink_config	phylink_config;
+
+	/* MAC counters, summed up into 64 bits (under adapter->mib_lock) */
+	u64			mib[ZX_MIB_NUM];
+	u32			mib_last[ZX_MIB_NUM];	/* last register values */
+};
+
+struct zx_eth_adapter {
+	struct device		*dev;
+	void __iomem		*base;
+	struct napi_struct	napi;
+	struct hrtimer		tx_timer;
+
+	struct net_device	*ports[ZX_NUM_PORTS];
+	int			open_count;
+	int			irq;
+
+	/* DMA arena remains allocated across down/up */
+	void			*buffer_pool;
+	dma_addr_t		buf_pool_dma;
+	void			*tx_ring;
+	dma_addr_t		tx_ring_dma;
+	void			*rx_ring;
+	dma_addr_t		rx_ring_dma;
+	void			*tab0;
+	dma_addr_t		tab0_dma;
+	void			*tab1;
+	dma_addr_t		tab1_dma;
+
+	u32			tx_cur_idx;
+	u32			tx_pending;
+	u32			tx_complete_cnt;
+	u32			tx_done_excess;
+	u32			bmu_free_slots;
+	u32			bmu_alloc_fail;
+	u32			bmu_alloc_late;		/* buffers of timed-out requests */
+	bool			bmu_alloc_pending;
+	u32			bmu_free_fail;
+	u32			rx_cur_idx[ZX_RX_QUEUES];
+	bool			rx_synced[ZX_RX_QUEUES];
+	u32			rx_resync_cnt;
+	u32			rx_alias_cnt;
+	u32			rx_nobuf_cnt;
+	u32			rx_rel_fail;
+	u32			rx_bad_cnt;
+
+	/* TX ring, BMU buffer allocation and the TX counters */
+	spinlock_t		tx_lock;
+	/* BMU free register and bmu_free_slots */
+	spinlock_t		bmu_free_lock;
+
+	/* MAC counters of all ports, read before their 32 bits wrap */
+	struct mutex		mib_lock;
+	struct delayed_work	mib_work;
+
+	/* Hardware flow offload (packet processor NAT) */
+	struct mutex		ppe_lock;
+	bool			ppe_active;
+	int			ppe_users;	/* bound flowtables */
+	struct rhashtable	ppe_flows;
+	DECLARE_BITMAP(ppe_hash_used, ZX_PPE_HASH_SIZE);
+	DECLARE_BITMAP(ppe_flow_used, ZX_PPE_FLOWS);
+	DECLARE_BITMAP(ppe_nh_used, ZX_PPE_NEXT_HOPS);
+	struct {
+		u8	mac[ETH_ALEN];
+		__be32	ip;
+		int	refs;
+	} ppe_subnet[ZX_PPE_SUBNETS];
+	u32			ppe_saved[4];
+	u32			ppe_count;
+	u32			ppe_add_skip;	/* flows the hardware cannot take */
+	u32			ppe_add_fail;	/* no free entry, access timeout */
+
+	/* Hardware LAN switching between the ports of one Linux bridge */
+	spinlock_t		trap_lock;	/* zx_update_traps() */
+	struct mutex		sw_lock;
+	bool			sw_ready;	/* bridge notifications registered */
+	u8			sw_members;	/* bridge ports that switch */
+	struct work_struct	sw_work;
+	spinlock_t		sw_fdb_lock;	/* the fields below */
+	struct net_device	*sw_bridge[ZX_NUM_PORTS];
+	bool			sw_recompute;
+	u8			sw_flush;	/* bridge ports to flush */
+	bool			sw_fdb_overflow;
+	unsigned int		sw_fdb_count;
+	u8			sw_fdb_mac[ZX_SW_FDB_QUEUE][ETH_ALEN];
+	u32			sw_fdb_deleted;
+	struct notifier_block	sw_netdev_nb;
+	struct notifier_block	sw_switchdev_nb;
+	struct notifier_block	sw_switchdev_blocking_nb;
+};
+
+/* zx279128s-main.c */
+bool zx_eth_is_port(const struct net_device *dev);
+void zx_set_trap_dmac(struct zx_eth_adapter *adapter, int idx, const u8 *mac);
+
+/* zx279128s-ppe.c */
+extern const struct rhashtable_params zx_ppe_ht_params;
+void zx_update_traps(struct zx_eth_adapter *adapter);
+void zx_update_mac_tables(struct zx_eth_adapter *adapter);
+int zx_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		    void *type_data);
+
+/* zx279128s-switch.c */
+void zx_sw_init(struct zx_eth_adapter *adapter);
+void zx_sw_fini(struct zx_eth_adapter *adapter);
+void zx_sw_work(struct work_struct *work);
+void zx_sw_port_down(struct zx_eth_adapter *adapter, int port);
+
+#endif
diff --git a/drivers/net/ethernet/zte/zx279128s-main.c b/drivers/net/ethernet/zte/zx279128s-main.c
new file mode 100644
index 0000000000..45a0dc1363
--- /dev/null
+++ b/drivers/net/ethernet/zte/zx279128s-main.c
@@ -0,0 +1,1502 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE zx279128s Ethernet switch and DMA driver
+ *
+ * Copyright (C) 2026 Navid Ghahremani <ghahramani.navid@gmail.com>
+ *
+ * The zx279128s has a five-port gigabit switch with a traffic manager (TM),
+ * a buffer management unit (BMU) and a DMA engine that moves frames between
+ * the switch and the CPU. Every port is its own net_device (lan1-lan4 and wan
+ * on the ZTE ZXHN H3600). Ports in the same Linux bridge switch known unicast
+ * in hardware (zx279128s-switch.c), and established flows can be offloaded to
+ * the packet processor (zx279128s-ppe.c).
+ *
+ * All frames pass through buffers of the BMU pool, which lives in a 16 MiB
+ * DMA arena that is allocated once at probe and kept. Received frames are
+ * copied out of their buffer into an skb, frames to send are copied into a
+ * buffer. The ingress port of a received frame is in its descriptor, and a
+ * frame to send goes to the TM queue of its port. The hardware tables are
+ * programmed from scratch, with the values of the vendor firmware.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/rtnetlink.h>
+#include <linux/seq_file.h>
+
+#include "zx279128s-eth.h"
+
+/* ---- BMU helpers --------------------------------------------------- */
+
+/*
+ * Allocate a buffer from the BMU (caller holds tx_lock).  A request that
+ * does not complete in time stays with the BMU, which hands out its
+ * buffer later: keep it pending and collect that buffer on the next call,
+ * as the vendor driver does.  Starting a new request instead lost one
+ * buffer for good with every timeout.
+ */
+static int zx_bmu_alloc_bp(struct zx_eth_adapter *adapter)
+{
+	void __iomem *base = adapter->base;
+	u32 val;
+	int ret;
+
+	if (adapter->bmu_alloc_pending) {
+		if (readl(base + ZX_BMU_BUF_ALLOC) & ZX_BMU_BUF_ALLOC_REQ) {
+			adapter->bmu_alloc_fail++;
+			return -EBUSY;
+		}
+		adapter->bmu_alloc_pending = false;
+		val = readl(base + ZX_BMU_BUF_ID);
+		if (val & ZX_BMU_BUF_ID_VALID) {
+			adapter->bmu_alloc_late++;
+			return FIELD_GET(ZX_BMU_BUF_ID_BP, val);
+		}
+	}
+
+	val = readl(base + ZX_BMU_BUF_ALLOC);
+	writel(val | ZX_BMU_BUF_ALLOC_REQ, base + ZX_BMU_BUF_ALLOC);
+	ret = readl_poll_timeout_atomic(base + ZX_BMU_BUF_ALLOC, val,
+					!(val & ZX_BMU_BUF_ALLOC_BUSY), 1, 1000);
+	if (!ret) {
+		val = readl(base + ZX_BMU_BUF_ID);
+		if (val & ZX_BMU_BUF_ID_VALID)
+			return FIELD_GET(ZX_BMU_BUF_ID_BP, val);
+		ret = -ENOSPC;
+	}
+
+	adapter->bmu_alloc_pending = true;
+	adapter->bmu_alloc_fail++;
+	return ret;
+}
+
+static int zx_bmu_free_bp(struct zx_eth_adapter *adapter, u16 bp)
+{
+	u32 val;
+	int ret = 0;
+
+	spin_lock_bh(&adapter->bmu_free_lock);
+	if (!adapter->bmu_free_slots) {
+		ret = readl_poll_timeout_atomic(adapter->base + ZX_BMU_FREE_STATUS,
+						val, val & ZX_BMU_FREE_SLOTS, 1, 5000);
+		if (ret) {
+			adapter->bmu_free_fail++;
+			goto out;
+		}
+		adapter->bmu_free_slots = FIELD_GET(ZX_BMU_FREE_SLOTS, val);
+	}
+
+	adapter->bmu_free_slots--;
+	writel(bp, adapter->base + ZX_BMU_BUF_FREE);
+out:
+	spin_unlock_bh(&adapter->bmu_free_lock);
+	return ret;
+}
+
+/* ---- RX descriptor release ----------------------------------------- */
+
+/*
+ * Hand @n consumed slots of RX queue @q back to the hardware with one
+ * command, as the vendor driver does (count in bits 13:4, ring B), instead
+ * of two register polls and two writes per frame.
+ *
+ * The traffic manager counts each frame it hands to the CPU against the
+ * class in descriptor byte 6 bit 0, and a release only returns slots of the
+ * class it names.  Releasing a class-1 slot as class 0 leaves the frame
+ * counted in the CPU queue for good: after 1024 frames the queue's reserved
+ * space is used up.  So count the slots per class and release each class
+ * separately, as the vendor driver does.
+ */
+static int zx_rx_release(struct zx_eth_adapter *adapter, int q, int class,
+			 u32 n)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(adapter->base + ZX_RX_REL_CTRL,
+					val, !(val & ZX_RX_REL_BUSY), 1, 5000);
+	if (ret)
+		return ret;
+	writel(FIELD_PREP(ZX_RX_REL_COUNT, n) | FIELD_PREP(ZX_RX_REL_CLASS, class) |
+	       FIELD_PREP(ZX_RX_REL_QUEUE, q), adapter->base + ZX_RX_REL_DATA);
+	writel(ZX_RX_REL_BUSY, adapter->base + ZX_RX_REL_CTRL);
+	return 0;
+}
+
+/*
+ * Clear a consumed descriptor.  All cleared descriptors must be visible
+ * before their slots are released: with a full ring the hardware refills a
+ * slot as soon as it is released, and clearing it afterwards would wipe
+ * the new descriptor.
+ */
+static void zx_rx_clear_desc(__le32 *desc)
+{
+	desc[0] = 0; desc[1] = 0; desc[2] = 0; desc[3] = 0;
+}
+
+/* Count a consumed slot for its release class, then clear it. */
+static void zx_rx_consume(__le32 *desc, u32 rel[2])
+{
+	rel[((u8 *)desc)[6] & 1]++;
+	zx_rx_clear_desc(desc);
+}
+
+/* ---- MAC port helpers ---------------------------------------------- */
+
+static void zx_port_set_speed(struct zx_eth_adapter *adapter, int port,
+			      int speed, int duplex)
+{
+	void __iomem *reg = adapter->base + ZX_MAC_PORT(port) + ZX_MAC_CTRL;
+	u32 val = readl(reg);
+
+	if (speed == SPEED_1000) {
+		val &= ~(ZX_MAC_CTRL_MII | ZX_MAC_CTRL_100);
+		val |= ZX_MAC_CTRL_FD;
+	} else {
+		if (duplex == DUPLEX_FULL) {
+			val |= ZX_MAC_CTRL_MII | ZX_MAC_CTRL_FD;
+		} else {
+			val &= ~ZX_MAC_CTRL_FD;
+			val |= ZX_MAC_CTRL_MII;
+		}
+		if (speed == SPEED_100)
+			val |= ZX_MAC_CTRL_100;
+		else
+			val &= ~ZX_MAC_CTRL_100;
+	}
+	writel(val, reg);
+}
+
+static void zx_port_enable(struct zx_eth_adapter *adapter, int port, bool enable)
+{
+	void __iomem *reg = adapter->base + ZX_MAC_PORT(port) + ZX_MAC_CTRL;
+	u32 val = readl(reg);
+
+	if (enable)
+		val |= ZX_MAC_CTRL_EN;
+	else
+		val &= ~ZX_MAC_CTRL_EN;
+	writel(val, reg);
+}
+
+/* ---- PHY link callbacks -------------------------------------------- */
+
+static struct zx_eth_priv *zx_config_to_priv(struct phylink_config *config)
+{
+	return netdev_priv(to_net_dev(config->dev));
+}
+
+static void zx_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	/* the MAC follows the link in zx_mac_link_up() only */
+}
+
+static void zx_mac_link_down(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct zx_eth_priv *priv = zx_config_to_priv(config);
+
+	zx_port_enable(priv->adapter, priv->port, false);
+	zx_sw_port_down(priv->adapter, priv->port);
+}
+
+static void zx_mac_link_up(struct phylink_config *config,
+			   struct phy_device *phy, unsigned int mode,
+			   phy_interface_t interface, int speed, int duplex,
+			   bool tx_pause, bool rx_pause)
+{
+	struct zx_eth_priv *priv = zx_config_to_priv(config);
+
+	zx_port_set_speed(priv->adapter, priv->port, speed, duplex);
+	zx_port_enable(priv->adapter, priv->port, true);
+}
+
+static const struct phylink_mac_ops zx_phylink_mac_ops = {
+	.mac_config	= zx_mac_config,
+	.mac_link_down	= zx_mac_link_down,
+	.mac_link_up	= zx_mac_link_up,
+};
+
+/*
+ * Frames addressed to one of our MAC addresses go to the CPU, whatever
+ * their type (the ethertype traps below cover the common ones).
+ */
+void zx_set_trap_dmac(struct zx_eth_adapter *adapter, int idx, const u8 *mac)
+{
+	writel(mac[2] << 24 | mac[3] << 16 | mac[4] << 8 | mac[5],
+	       adapter->base + ZX_SPA_TRAP_DMAC + idx * 8);
+	writel(mac[0] << 8 | mac[1], adapter->base + ZX_SPA_TRAP_DMAC + idx * 8 + 4);
+}
+
+static void zx_dma_enable(struct zx_eth_adapter *adapter, bool enable)
+{
+	u32 val = readl(adapter->base + ZX_DMA_CTRL);
+
+	val &= ~ZX_DMA_CTRL_EN;
+	val |= ZX_DMA_CTRL_BIT21 | (enable ? ZX_DMA_CTRL_EN : 0);
+	writel(val, adapter->base + ZX_DMA_CTRL);
+	readl(adapter->base + ZX_DMA_CTRL);
+}
+
+static int zx_tm_write(struct zx_eth_adapter *adapter, u32 table, u32 index,
+		       const u32 data[4])
+{
+	void __iomem *base = adapter->base;
+	u32 val;
+	int i, ret;
+
+	ret = readl_poll_timeout(base + ZX_TM_IND_STATUS, val,
+				 val & ZX_TM_IND_READY, 1, 1000);
+	if (ret)
+		return ret;
+	writel(FIELD_PREP(ZX_TM_IND_INDEX, index) |
+	       FIELD_PREP(ZX_TM_IND_TABLE, table), base + ZX_TM_IND_CMD);
+	for (i = 3; i >= 0; i--)
+		writel(data[i], base + ZX_TM_IND_DATA(i));
+	return 0;
+}
+
+static int zx_tm_read0(struct zx_eth_adapter *adapter, u32 table, u32 index,
+		       u32 *data)
+{
+	void __iomem *base = adapter->base;
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(base + ZX_TM_IND_STATUS, val,
+				 val & ZX_TM_IND_READY, 1, 1000);
+	if (ret)
+		return ret;
+	writel(FIELD_PREP(ZX_TM_IND_INDEX, index) |
+	       FIELD_PREP(ZX_TM_IND_TABLE, table) | ZX_TM_IND_READ,
+	       base + ZX_TM_IND_CMD);
+	ret = readl_poll_timeout(base + ZX_TM_IND_STATUS, val,
+				 val & ZX_TM_IND_READY, 1, 1000);
+	if (ret)
+		return ret;
+	*data = readl(base + ZX_TM_IND_DATA(0));
+	return 0;
+}
+
+/* Queue, RED and scheduler tables.  The RED profiles use the vendor
+ * pon_tm_red_init() value.
+ *
+ * Queue word 0 is the reserved space (bits 10:0) plus the shared space
+ * (bits 25:11), in buffers.  Queues 0-15 feed the CPU.  They get 1023
+ * reserved and no shared buffers, as in the stock firmware: a frame stays
+ * counted in its queue until the driver releases its RX slot, so the
+ * traffic manager never has more than 1023 frames in the 1024-slot RX
+ * ring and drops the excess itself.  With more, a burst faster than the
+ * driver drains the ring makes the DMA overwrite slots that were not read
+ * yet, and those frames and their buffers are lost.
+ *
+ * The queue usage in table 1 survives the reset.  U-Boot receives a TFTP
+ * download on CPU queue 0 and never returns the slots, so after a TFTP
+ * boot the queue starts with up to 1024 frames counted that will never be
+ * released, and a 1023 limit would drop every frame.  Raise the limit of
+ * each CPU queue by what is left counted in it.
+ */
+static int zx_tm_init(struct zx_eth_adapter *adapter)
+{
+	static const u32 queue[4] = { 0x00800400, 0, 0, 0 };
+	static const u32 red[4] = { 0x00200020, 0, 0, 0 };
+	static const u32 scheduler[4] = {
+		0xff803fff, 0x0100ff80, 0x00100200, 32
+	};
+	u32 cpu_queue[4] = { 0, 0, 0, 0 };
+	u32 used, limit;
+	int i, ret;
+
+	for (i = 0; i < 16; i++) {
+		ret = zx_tm_read0(adapter, ZX_TM_TABLE_QUEUE_USE, i, &used);
+		if (ret)
+			return ret;
+		used = (used & 0x7ff) + ((used >> 11) & 0x7fff);
+		if (used)
+			dev_dbg(adapter->dev,
+				"CPU queue %d: %u frames left counted by the boot loader\n",
+				i, used);
+		limit = 1023 + used;
+		cpu_queue[0] = min(limit, 0x7ffU) | (limit - min(limit, 0x7ffU)) << 11;
+		ret = zx_tm_write(adapter, ZX_TM_TABLE_QUEUE, i, cpu_queue);
+		if (ret)
+			return ret;
+	}
+	for (i = 16; i < 400; i++) {
+		ret = zx_tm_write(adapter, ZX_TM_TABLE_QUEUE, i, queue);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < 384; i++) {
+		ret = zx_tm_write(adapter, ZX_TM_TABLE_RED, i, red);
+		if (ret)
+			return ret;
+		ret = zx_tm_write(adapter, ZX_TM_TABLE_SCHED, i, scheduler);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/* ---- Hardware initialisation --------------------------------------- */
+
+static void zx_pp_init(struct zx_eth_adapter *adapter)
+{
+	void __iomem *base = adapter->base;
+
+	/* Mode-2 TX goes through the packet processor bridge.  The bootloader
+	 * initializes it for TFTP, but not when booting directly from NAND.
+	 * Initialize it ourselves, while DMA and the MACs are quiesced.  These
+	 * are the H3600 bootloader's PP reset, bridge and classifier settings.
+	 */
+	writel(2, base + ZX_PP_RESET);
+	usleep_range(1000, 2000);
+
+	writel(0x000200ff, base + ZX_SBRG_PORT_CTRL);
+	/* Stock firmware value.  With the reset value 0x00010000 the bridge
+	 * steered IPv6 unicast arriving on WAN to a queue the driver never
+	 * services, and each frame kept a BMU buffer: about one leaked
+	 * buffer per background WAN frame on an IPv6 network.
+	 */
+	writel(0x0000dfdf, base + 0x388008);
+	/* The bridge would forward a frame between ports only through VLAN
+	 * table entries, which the driver does not program, so it drops what
+	 * the traps leave.  Frames between two LAN ports must reach the Linux
+	 * bridge instead.  Turn off source address learning, so that every
+	 * unicast destination is unknown, and send unknown unicast arriving on
+	 * a switch port (bridge ports 1-5) to the CPU.  Without this, lifting
+	 * the IPv4 trap for flow offload loses IPv4 between two LAN hosts.
+	 */
+	writel(0x00000000, base + ZX_SBRG_LEARN);
+	writel(0xff5ffdff, base + 0x388340);
+	writel(0x0000003e, base + 0x388344);
+	writel(0x0000003f, base + 0x388380);
+	writel(0xaaaaaaaa, base + 0x38863c);
+	writel(0x00005555, base + 0x3881c4);
+	writel(0x000bf874, base + 0x388188);
+	writel(0x000000ff, base + 0x3882c0);
+	writel(0x0000ffff, base + 0x388300);
+	writel(0x0000003e, base + 0x388304);
+
+	writel(0x0000309a, base + 0x38c080);
+	writel(0, base + 0x38c088);
+	writel(1, base + 0x38c0cc);
+	writel(0, base + 0x3a0010);
+	writel(0, base + 0x3a0014);
+}
+
+/* Reset the switch and leave its ports and DMA stopped */
+static void zx_hw_reset(struct zx_eth_adapter *adapter)
+{
+	void __iomem *base = adapter->base;
+	int i;
+
+	/* Master reset pulse */
+	writel(0, base + ZX_GLB_RESET);
+	fsleep(10);
+	writel(0xffffffff, base + ZX_GLB_RESET);
+
+	/* Quiesce all 5 ports */
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		zx_port_enable(adapter, i, false);
+	zx_dma_enable(adapter, false);
+	writel(0, base + ZX_BMU_CTRL);
+}
+
+static int zx_hw_init(struct zx_eth_adapter *adapter)
+{
+	void __iomem *base = adapter->base;
+	static const int port_to_sw_idx[8] = { 0, 1, 2, 3, 4, -1, 5, 6 };
+	__be16 *tab;
+	u32 val;
+	int i, ret;
+
+	/* 0. Reset, interrupts off until a port is opened */
+	zx_hw_reset(adapter);
+	writel(~0, base + ZX_TM_INT_MASK);
+	msleep(20);
+
+	/* 1. Clock gating: enable the clocks of MAC ports 0-4 */
+	writel(readl(base + ZX_GLB_CLK_CTRL) & ~ZX_GLB_CLK_CTRL_BITS,
+	       base + ZX_GLB_CLK_CTRL);
+	writel(GENMASK(ZX_NUM_PORTS - 1, 0), base + ZX_GLB_PORT_CLK_EN);
+	zx_pp_init(adapter);
+
+	/* 2. Free-buffer index tables */
+	tab = adapter->tab0;
+	for (i = 0; i < ZX_TAB0_ENTRIES; i++)
+		tab[i] = cpu_to_be16(i);
+
+	tab = adapter->tab1;
+	for (i = 0; i < ZX_TAB1_ENTRIES; i++)
+		tab[i] = cpu_to_be16(i);
+
+	dma_wmb();
+	ret = zx_tm_init(adapter);
+	if (ret)
+		return dev_err_probe(adapter->dev, ret, "TM table setup timed out\n");
+
+	/* 3. Traffic Manager buffer pool */
+	writel((u32)adapter->tab0_dma, base + ZX_TM_TAB0_ADDR);
+	writel((u32)adapter->tab1_dma, base + ZX_TM_TAB1_ADDR);
+	writel(0x08000800, base + ZX_TM_TAB_LIMIT);
+	writel((u32)adapter->buf_pool_dma, base + ZX_TM_BUF_START);
+	writel((u32)adapter->buf_pool_dma + ZX_BUF_POOL_SIZE, base + ZX_TM_BUF_END);
+	writel((u32)adapter->rx_ring_dma, base + ZX_TM_BUF_F0);
+	writel(16, base + ZX_TM_CONFIG_START);
+
+	/* DMA and TM control values from the vendor pon_tm_dma_init() and
+	 * the stock firmware, programmed before the BMU is configured.
+	 */
+	writel(1,      base + ZX_DMA_BASE + 0x28);
+	writel(1,      base + ZX_DMA_BASE + 0x2c);
+	writel(ZX_RX_IRQ_USECS * 50, base + ZX_DMA_RX_IRQ_TIMER);
+	writel(ZX_RX_IRQ_FRAMES, base + ZX_DMA_RX_IRQ_FRAMES);
+	writel(0x7f,   base + ZX_DMA_BASE + 0x04);
+	writel(32,     base + ZX_DMA_BASE + 0x20);
+	writel(32,     base + ZX_DMA_BASE + 0x24);
+	/* The bootloader leaves 0x00131213 here, the stock firmware runs with
+	 * 0x00131217.
+	 */
+	writel(0x00131217, base + ZX_DMA_BASE + 0x388);
+	writel(readl(base + ZX_TM_CTRL) | ZX_TM_CTRL_BIT6, base + ZX_TM_CTRL);
+
+	/* 4. Buffer Management Unit */
+	writel(0,          base + ZX_BMU_CTRL);
+	writel(0x0104c040, base + ZX_BMU_CFG1);
+	writel(0x0104c040, base + ZX_BMU_CFG2);
+	/* Pool size in units of 32 buffers.  With a 2048-buffer pool the BMU
+	 * never fills its external free list (BPPE) after a cold NAND boot and
+	 * runs on its ~64-entry internal cache only.  4096 works.
+	 */
+	writel(ZX_NUM_BUFFERS / 32 - 1, base + ZX_BMU_LIMIT1);
+	writel(15,         base + ZX_BMU_LIMIT2);
+	writel(ZX_NUM_BUFFERS << 16, base + ZX_BMU_THRES1);
+	writel(0x2000000,  base + ZX_BMU_THRES2);
+	writel(0,          base + ZX_BMU_BUF_ALLOC);
+	writel(ZX_BMU_CTRL_EN, base + ZX_BMU_CTRL);
+
+	writel(17, base + 0x3a00e0);
+
+	/* 5. DMA descriptor rings */
+	memset(adapter->tx_ring, 0, ZX_NUM_TX_DESC * ZX_DESC_SIZE);
+	memset(adapter->rx_ring, 0, ZX_RX_QUEUES * ZX_RX_QUEUE_STRIDE);
+	adapter->tx_cur_idx = 0;
+	for (i = 0; i < ZX_RX_QUEUES; i++) {
+		adapter->rx_cur_idx[i] = 0;
+		adapter->rx_synced[i] = false;
+	}
+	adapter->tx_pending = 0;
+	adapter->tx_complete_cnt = 0;
+	adapter->tx_done_excess = 0;
+	adapter->bmu_free_slots = 0;
+
+	writel((u32)adapter->buf_pool_dma + ZX_AREA50_OFFSET, base + ZX_DMA_AREA50);
+	writel((u32)adapter->tx_ring_dma, base + ZX_DMA_TX_RING);
+	writel(0x00400040,             base + ZX_DMA_RING_CFG);
+	readl(base + ZX_DMA_TX_DONE);
+
+	dma_wmb();
+
+	/* 6. Switch: enable forwarding */
+	writel(ZX_SW_FWD_CTRL_ON, base + ZX_SW_FWD_CTRL);
+
+	for (i = 0; i < 8; i++) {
+		int idx = port_to_sw_idx[i];
+
+		if (idx >= 0)
+			writel(1, base + ZX_SPA_PORT_EN(idx));
+	}
+
+	/*
+	 * Enable every class of packets the switch can hand to the CPU, up
+	 * and down direction, as the stock firmware does.  With only a few
+	 * classes enabled, IPv6 neighbour discovery never reached the CPU.
+	 */
+	writel(0xffffffff, base + ZX_SPA_UP_REG_PKT_EN);
+	writel(0xffffffff, base + ZX_SPA_UP_REG_PKT_EN + 4);
+	writel(0xffffffff, base + ZX_SPA_DN_REG_PKT_EN);
+	writel(0xffffffff, base + ZX_SPA_DN_REG_PKT_EN + 4);
+
+	/*
+	 * The switch never forwards from port to port and hands the CPU only
+	 * the frames a trap matches; the Linux bridge forwards between the
+	 * port netdevs.  So trap the common ethertypes whatever their
+	 * destination (IPv4, IPv6, ARP, VLAN tagged).  This also covers what
+	 * the IPv4 protocol trap (TCP, UDP, ICMP) did, so clear that one.
+	 */
+	writel(ETH_P_IP << 16 | ETH_P_IPV6, base + ZX_SPA_TRAP_ETH_TYPE);
+	writel(ETH_P_ARP << 16 | ETH_P_8021Q, base + ZX_SPA_TRAP_ETH_TYPE + 4);
+	writel(0, base + ZX_SPA_TRAP_PROTO);
+
+	/* Clear port filter bits for ports 0-4 */
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		val = readl(base + ZX_SW_PORT_FILTER(i));
+		val &= ~ZX_SW_PORT_FILTER_BITS;
+		writel(val, base + ZX_SW_PORT_FILTER(i));
+	}
+
+	/* 7. MAC ports 0-4 */
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		void __iomem *pb = base + ZX_MAC_PORT(i);
+
+		writel(0x00bbe000, pb + ZX_MAC_CTRL);
+		writel(0x80000001, pb + 0x08);
+		writel(0x0000fffe, pb + 0x04);
+		writel(0x00011200, pb + 0xe0);
+		writel(50,         pb + 0xd00);
+		writel(168,        pb + 0xd30);
+		writel(0x00300002, pb + 0x70);
+		writel(0x4000,     pb + 0xb4);
+		writel(0x0010ff11, pb + 0xb00);
+
+		zx_port_set_speed(adapter, i, SPEED_1000, DUPLEX_FULL);
+		zx_port_enable(adapter, i, false);
+	}
+
+	return 0;
+}
+
+/*
+ * No interrupt reports sent frames.  They are reclaimed on every transmit
+ * and in the NAPI poll; while a full ring keeps the queues stopped, a timer
+ * runs the poll until they can be woken again.  Called with tx_lock held.
+ */
+static void zx_tx_kick(struct zx_eth_adapter *adapter)
+{
+	if (!hrtimer_active(&adapter->tx_timer))
+		hrtimer_start(&adapter->tx_timer, us_to_ktime(ZX_TX_POLL_US),
+			      HRTIMER_MODE_REL);
+}
+
+static void zx_tx_reclaim(struct zx_eth_adapter *adapter)
+{
+	u32 done = readl(adapter->base + ZX_DMA_TX_DONE) & 0xffff;
+	u32 n = min(done, adapter->tx_pending);
+
+	if (unlikely(done > adapter->tx_pending))
+		adapter->tx_done_excess += done - adapter->tx_pending;
+	adapter->tx_complete_cnt += n;
+	adapter->tx_pending -= n;
+	if (adapter->tx_pending < ZX_TX_QUEUE_LIMIT) {
+		int p;
+
+		for (p = 0; p < ZX_NUM_PORTS; p++)
+			if (adapter->ports[p] && netif_queue_stopped(adapter->ports[p]))
+				netif_wake_queue(adapter->ports[p]);
+	}
+}
+
+/* ---- TX path ------------------------------------------------------- */
+
+static netdev_tx_t zx_eth_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+	struct zx_eth_adapter *adapter = priv->adapter;
+	void __iomem *base = adapter->base;
+	unsigned int len = skb->len;
+	__le32 *desc;
+	u32 tx_idx;
+	u8 *buf_ptr;
+	int bp;
+
+	if (len > 1536) {
+		dev_kfree_skb_any(skb);
+		dev_dstats_tx_dropped(netdev);
+		return NETDEV_TX_OK;
+	}
+
+	spin_lock_bh(&adapter->tx_lock);
+	zx_tx_reclaim(adapter);
+	/*
+	 * The ports share the ring.  The queues are stopped as soon as it is
+	 * full, but another port's transmit may already be waiting for the
+	 * lock: give its frame back to the stack.
+	 */
+	if (adapter->tx_pending >= ZX_TX_QUEUE_LIMIT) {
+		netif_stop_queue(netdev);
+		zx_tx_kick(adapter);
+		spin_unlock_bh(&adapter->tx_lock);
+		return NETDEV_TX_BUSY;
+	}
+	if (skb_put_padto(skb, ETH_ZLEN)) {
+		spin_unlock_bh(&adapter->tx_lock);
+		dev_dstats_tx_dropped(netdev);
+		return NETDEV_TX_OK;
+	}
+	len = skb->len;
+	bp = zx_bmu_alloc_bp(adapter);
+	if (bp < 0 || bp >= ZX_NUM_BUFFERS) {
+		spin_unlock_bh(&adapter->tx_lock);
+		dev_dstats_tx_dropped(netdev);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	buf_ptr = (u8 *)adapter->buffer_pool + ((u32)bp * ZX_BUF_SIZE) + 16;
+	if (skb_copy_bits(skb, 0, buf_ptr, len)) {
+		zx_bmu_free_bp(adapter, bp);
+		spin_unlock_bh(&adapter->tx_lock);
+		dev_dstats_tx_dropped(netdev);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	tx_idx = adapter->tx_cur_idx % ZX_NUM_TX_DESC;
+	desc = (__le32 *)adapter->tx_ring + tx_idx * (ZX_DESC_SIZE / sizeof(*desc));
+
+	/*
+	 * Directed egress to the port's TM queue.  The switch does not
+	 * forward between ports: the Linux bridge does, one netdev per port.
+	 */
+	desc[0] = cpu_to_le32(0x80 | (ZX_PORT_TX_QUEUE(priv->port) << 20));
+	desc[3] = cpu_to_le32(0x3 | ((len & 0x3fff) << 2));
+	desc[1] = cpu_to_le32(0x10000);
+	desc[2] = cpu_to_le32(0x21000000 | ((len & 0x3fff) << 9));
+
+	((u8 *)desc)[7] = (u8)((bp & 0x7f) << 1);
+	((u8 *)desc)[8] = (u8)(bp >> 7);
+
+	dma_wmb();
+	writel(1, base + ZX_DMA_TX_START);
+
+	adapter->tx_cur_idx++;
+	adapter->tx_pending++;
+	if (adapter->tx_pending >= ZX_TX_QUEUE_LIMIT) {
+		int p;
+
+		for (p = 0; p < ZX_NUM_PORTS; p++)
+			if (adapter->ports[p])
+				netif_stop_queue(adapter->ports[p]);
+		zx_tx_kick(adapter);
+	}
+	spin_unlock_bh(&adapter->tx_lock);
+	dev_dstats_tx_add(netdev, len);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+/* ---- RX path ------------------------------------------------------- */
+
+static bool zx_is_own_addr(struct zx_eth_adapter *adapter, const u8 *addr)
+{
+	int i;
+
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		if (adapter->ports[i] &&
+		    ether_addr_equal(adapter->ports[i]->dev_addr, addr))
+			return true;
+	return false;
+}
+
+static int zx_eth_rx(struct zx_eth_adapter *adapter, int budget)
+{
+	int work_done = 0, q;
+
+	for (q = ZX_RX_QUEUES - 1; q >= 0 && work_done < budget; q--) {
+		u32 avail = readl(adapter->base + ZX_DMA_RX_QUEUE_CNT(q)) & 0xffff;
+		u32 rel[2] = { 0, 0 };
+
+		while (avail && work_done < budget) {
+			u32 idx = adapter->rx_cur_idx[q] % ZX_NUM_RX_DESC;
+			__le32 *desc = adapter->rx_ring + q * ZX_RX_QUEUE_STRIDE +
+				       idx * ZX_DESC_SIZE;
+			u16 bp, len;
+			int port;
+			struct sk_buff *skb;
+			struct net_device *dest_dev;
+
+			dma_rmb();
+			bp = (((u8 *)desc)[7] >> 1) | ((u16)((u8 *)desc)[8] << 7);
+			len = (le32_to_cpu(desc[3]) >> 2) & 0x3fff;
+			port = (((u8 *)desc)[6] >> 3) ? ((((u8 *)desc)[6] >> 3) - 1) : 0;
+
+			if (bp >= ZX_NUM_BUFFERS || len < ETH_HLEN || len > 1536) {
+				u32 scan, idx2, found = 0;
+
+				if (adapter->rx_synced[q]) {
+					/*
+					 * The hardware counted this slot but it
+					 * holds no frame: it can leave a slot
+					 * empty (e.g. when it had no buffer).
+					 * Consume it as the vendor driver does.
+					 * Waiting for it would leave our index
+					 * behind the hardware's for good.
+					 */
+					adapter->rx_bad_cnt++;
+					if (net_ratelimit())
+						dev_warn(adapter->dev,
+							 "rxq%d: skipping slot %u (%08x %08x %08x %08x), %u pending\n",
+							 q, idx, le32_to_cpu(desc[0]),
+							 le32_to_cpu(desc[1]),
+							 le32_to_cpu(desc[2]),
+							 le32_to_cpu(desc[3]), avail);
+					zx_rx_consume(desc, rel);
+					adapter->rx_cur_idx[q]++;
+					work_done++;
+					avail--;
+					if (bp && bp < ZX_NUM_BUFFERS &&
+					    zx_bmu_free_bp(adapter, bp))
+						adapter->bmu_free_fail++;
+					continue;
+				}
+
+				for (scan = 1; scan < ZX_NUM_RX_DESC; scan++) {
+					__le32 *d2;
+					u16 bp2, len2;
+
+					idx2 = (idx + scan) % ZX_NUM_RX_DESC;
+					d2 = adapter->rx_ring + q * ZX_RX_QUEUE_STRIDE +
+					     idx2 * ZX_DESC_SIZE;
+					dma_rmb();
+					bp2 = (((u8 *)d2)[7] >> 1) |
+					      ((u16)((u8 *)d2)[8] << 7);
+					len2 = (le32_to_cpu(d2[3]) >> 2) & 0x3fff;
+					if (bp2 < ZX_NUM_BUFFERS &&
+					    len2 >= ETH_HLEN && len2 <= 1536) {
+						found = 1;
+						break;
+					}
+				}
+				if (!found)
+					break;
+				adapter->rx_cur_idx[q] = idx2;
+				adapter->rx_resync_cnt++;
+				continue;
+			}
+			adapter->rx_synced[q] = true;
+
+			/* Aliasing detector: frames from one of our own addresses */
+			if (len >= ETH_HLEN) {
+				u8 *d = adapter->buffer_pool + bp * ZX_BUF_SIZE + 16;
+
+				if (zx_is_own_addr(adapter, d + ETH_ALEN)) {
+					adapter->rx_alias_cnt++;
+					zx_rx_consume(desc, rel);
+					adapter->rx_cur_idx[q]++;
+					work_done++;
+					avail--;
+					/*
+					 * A frame of our own that the switch
+					 * sent back still has an RX buffer of
+					 * its own: return it, or every such
+					 * frame leaks one BMU buffer.
+					 */
+					if (zx_bmu_free_bp(adapter, bp))
+						adapter->bmu_free_fail++;
+					continue;
+				}
+			}
+
+			/* Deliver to the netdev of the ingress port */
+			dest_dev = port < ZX_NUM_PORTS ? adapter->ports[port] : NULL;
+
+			skb = napi_alloc_skb(&adapter->napi, len);
+			if (skb && dest_dev && (dest_dev->flags & IFF_UP)) {
+				dma_rmb();
+				memcpy(skb_put(skb, len), adapter->buffer_pool +
+				       bp * ZX_BUF_SIZE + 16, len);
+				skb->dev = dest_dev;
+				skb->protocol = eth_type_trans(skb, dest_dev);
+				napi_gro_receive(&adapter->napi, skb);
+				dev_dstats_rx_add(dest_dev, len);
+			} else {
+				if (skb)
+					dev_kfree_skb_any(skb);
+				if (dest_dev)
+					dev_dstats_rx_dropped(dest_dev);
+			}
+
+			zx_rx_consume(desc, rel);
+			adapter->rx_cur_idx[q]++;
+			work_done++;
+			avail--;
+			if (zx_bmu_free_bp(adapter, bp))
+				adapter->bmu_free_fail++;
+		}
+		if (rel[0] || rel[1])
+			dma_wmb();
+		if (rel[0] && zx_rx_release(adapter, q, 0, rel[0]))
+			adapter->rx_rel_fail++;
+		if (rel[1] && zx_rx_release(adapter, q, 1, rel[1]))
+			adapter->rx_rel_fail++;
+	}
+	return work_done;
+}
+
+/* ---- interrupt and NAPI poll -------------------------------------- */
+
+static irqreturn_t zx_eth_isr(int irq, void *dev_id)
+{
+	struct zx_eth_adapter *adapter = dev_id;
+
+	if (!(readl(adapter->base + ZX_TM_INT_STATUS) & ZX_TM_INT_RX))
+		return IRQ_NONE;
+
+	writel(~0, adapter->base + ZX_TM_INT_MASK);
+	napi_schedule(&adapter->napi);
+	return IRQ_HANDLED;
+}
+
+static int zx_eth_poll(struct napi_struct *napi, int budget)
+{
+	struct zx_eth_adapter *adapter =
+		container_of(napi, struct zx_eth_adapter, napi);
+	int work_done;
+
+	spin_lock_bh(&adapter->tx_lock);
+	zx_tx_reclaim(adapter);
+	if (adapter->tx_pending >= ZX_TX_QUEUE_LIMIT)
+		zx_tx_kick(adapter);
+	spin_unlock_bh(&adapter->tx_lock);
+	work_done = budget ? zx_eth_rx(adapter, budget) : 0;
+
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		writel(~ZX_TM_INT_RX, adapter->base + ZX_TM_INT_MASK);
+
+	return work_done;
+}
+
+static enum hrtimer_restart zx_eth_tx_timer(struct hrtimer *timer)
+{
+	struct zx_eth_adapter *adapter =
+		container_of(timer, struct zx_eth_adapter, tx_timer);
+
+	napi_schedule(&adapter->napi);
+	return HRTIMER_NORESTART;
+}
+
+/* ---- ndo_open / ndo_stop ------------------------------------------- */
+
+static int zx_eth_open(struct net_device *netdev)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+	struct zx_eth_adapter *adapter = priv->adapter;
+
+	if (adapter->open_count == 0) {
+		napi_enable(&adapter->napi);
+		writel(~ZX_TM_INT_RX, adapter->base + ZX_TM_INT_MASK);
+	}
+	adapter->open_count++;
+
+	phylink_start(priv->phylink);
+	netif_start_queue(netdev);
+	return 0;
+}
+
+static int zx_eth_stop(struct net_device *netdev)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+	struct zx_eth_adapter *adapter = priv->adapter;
+
+	netif_tx_disable(netdev);
+	phylink_stop(priv->phylink);
+	adapter->open_count--;
+
+	if (adapter->open_count == 0) {
+		writel(~0, adapter->base + ZX_TM_INT_MASK);
+		hrtimer_cancel(&adapter->tx_timer);
+		napi_disable(&adapter->napi);
+		/* a last poll may have unmasked it again */
+		writel(~0, adapter->base + ZX_TM_INT_MASK);
+		synchronize_irq(adapter->irq);
+	}
+
+	return 0;
+}
+
+/* ---- net_device_ops ------------------------------------------------ */
+
+static int zx_eth_set_mac_address(struct net_device *netdev, void *p)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+	struct zx_eth_adapter *adapter = priv->adapter;
+	int ret;
+
+	ret = eth_mac_addr(netdev, p);
+	if (ret)
+		return ret;
+
+	mutex_lock(&adapter->ppe_lock);
+	zx_update_mac_tables(adapter);
+	mutex_unlock(&adapter->ppe_lock);
+	return 0;
+}
+
+static int zx_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+
+	return phylink_mii_ioctl(priv->phylink, ifr, cmd);
+}
+
+static const struct net_device_ops zx_netdev_ops = {
+	.ndo_open		= zx_eth_open,
+	.ndo_stop		= zx_eth_stop,
+	.ndo_start_xmit		= zx_eth_xmit,
+	.ndo_set_mac_address	= zx_eth_set_mac_address,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_eth_ioctl		= zx_eth_ioctl,
+	.ndo_setup_tc		= zx_eth_setup_tc,
+};
+
+bool zx_eth_is_port(const struct net_device *dev)
+{
+	return dev->netdev_ops == &zx_netdev_ops;
+}
+
+/* ---- MAC counters -------------------------------------------------- */
+
+/*
+ * The offsets are from the vendor's statistics table, and the vendor driver
+ * picks the same counters.  The MACs have more (errors, collisions, pause
+ * frames), but these are the ones checked against known traffic.
+ */
+static const u16 zx_mib_regs[ZX_MIB_NUM] = {
+	[ZX_MIB_TX_OCTETS]	= ZX_MAC_TX_OCTETS,
+	[ZX_MIB_TX_FRAMES]	= ZX_MAC_TX_FRAMES,
+	[ZX_MIB_TX_MCAST]	= ZX_MAC_TX_MCAST,
+	[ZX_MIB_TX_BCAST]	= ZX_MAC_TX_BCAST,
+	[ZX_MIB_TX_HIST + 0]	= ZX_MAC_TX_HIST(0),
+	[ZX_MIB_TX_HIST + 1]	= ZX_MAC_TX_HIST(1),
+	[ZX_MIB_TX_HIST + 2]	= ZX_MAC_TX_HIST(2),
+	[ZX_MIB_TX_HIST + 3]	= ZX_MAC_TX_HIST(3),
+	[ZX_MIB_TX_HIST + 4]	= ZX_MAC_TX_HIST(4),
+	[ZX_MIB_TX_HIST + 5]	= ZX_MAC_TX_HIST(5),
+	[ZX_MIB_RX_OCTETS]	= ZX_MAC_RX_OCTETS,
+	[ZX_MIB_RX_UCAST]	= ZX_MAC_RX_UCAST,
+	[ZX_MIB_RX_MCAST]	= ZX_MAC_RX_MCAST,
+	[ZX_MIB_RX_BCAST]	= ZX_MAC_RX_BCAST,
+	[ZX_MIB_RX_HIST + 0]	= ZX_MAC_RX_HIST(0),
+	[ZX_MIB_RX_HIST + 1]	= ZX_MAC_RX_HIST(1),
+	[ZX_MIB_RX_HIST + 2]	= ZX_MAC_RX_HIST(2),
+	[ZX_MIB_RX_HIST + 3]	= ZX_MAC_RX_HIST(3),
+	[ZX_MIB_RX_HIST + 4]	= ZX_MAC_RX_HIST(4),
+	[ZX_MIB_RX_HIST + 5]	= ZX_MAC_RX_HIST(5),
+};
+
+/*
+ * The counters are 32 bits wide and keep running.  At 1 Gbit/s the byte
+ * counters wrap after 34 s, so they are read every few seconds, and what
+ * they grew by since the last read is added to 64-bit sums.
+ */
+#define ZX_MIB_INTERVAL		(5 * HZ)
+
+static void zx_mib_update(struct zx_eth_priv *priv)
+{
+	void __iomem *base = priv->adapter->base + ZX_MAC_PORT(priv->port);
+	int i;
+
+	lockdep_assert_held(&priv->adapter->mib_lock);
+
+	for (i = 0; i < ZX_MIB_NUM; i++) {
+		u32 val = readl(base + zx_mib_regs[i]);
+
+		priv->mib[i] += val - priv->mib_last[i];	/* modulo 2^32 */
+		priv->mib_last[i] = val;
+	}
+}
+
+static void zx_mib_work(struct work_struct *work)
+{
+	struct zx_eth_adapter *adapter =
+		container_of(to_delayed_work(work), struct zx_eth_adapter,
+			     mib_work);
+	int i;
+
+	mutex_lock(&adapter->mib_lock);
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		if (adapter->ports[i])
+			zx_mib_update(netdev_priv(adapter->ports[i]));
+	mutex_unlock(&adapter->mib_lock);
+
+	schedule_delayed_work(&adapter->mib_work, ZX_MIB_INTERVAL);
+}
+
+/* ---- ethtool_ops --------------------------------------------------- */
+
+static int zx_eth_get_link_ksettings(struct net_device *netdev,
+				     struct ethtool_link_ksettings *cmd)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
+}
+
+static int zx_eth_set_link_ksettings(struct net_device *netdev,
+				     const struct ethtool_link_ksettings *cmd)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
+}
+
+static int zx_eth_nway_reset(struct net_device *netdev)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+
+	return phylink_ethtool_nway_reset(priv->phylink);
+}
+
+static void zx_eth_get_eth_mac_stats(struct net_device *netdev,
+				     struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+	const u64 *mib = priv->mib;
+
+	mutex_lock(&priv->adapter->mib_lock);
+	zx_mib_update(priv);
+
+	mac_stats->FramesTransmittedOK = mib[ZX_MIB_TX_FRAMES];
+	mac_stats->OctetsTransmittedOK = mib[ZX_MIB_TX_OCTETS];
+	mac_stats->MulticastFramesXmittedOK = mib[ZX_MIB_TX_MCAST];
+	mac_stats->BroadcastFramesXmittedOK = mib[ZX_MIB_TX_BCAST];
+	/* there is a total, but the vendor driver adds up these three */
+	mac_stats->FramesReceivedOK = mib[ZX_MIB_RX_UCAST] +
+				      mib[ZX_MIB_RX_MCAST] +
+				      mib[ZX_MIB_RX_BCAST];
+	mac_stats->OctetsReceivedOK = mib[ZX_MIB_RX_OCTETS];
+	mac_stats->MulticastFramesReceivedOK = mib[ZX_MIB_RX_MCAST];
+	mac_stats->BroadcastFramesReceivedOK = mib[ZX_MIB_RX_BCAST];
+
+	mutex_unlock(&priv->adapter->mib_lock);
+}
+
+/* The last bin also counts 1522-byte (VLAN-tagged) frames */
+static const struct ethtool_rmon_hist_range zx_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1522 },
+	{}
+};
+
+static void zx_eth_get_rmon_stats(struct net_device *netdev,
+				  struct ethtool_rmon_stats *rmon_stats,
+				  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct zx_eth_priv *priv = netdev_priv(netdev);
+	int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(zx_rmon_ranges) != ZX_MAC_HIST_BINS + 1);
+
+	mutex_lock(&priv->adapter->mib_lock);
+	zx_mib_update(priv);
+	for (i = 0; i < ZX_MAC_HIST_BINS; i++) {
+		rmon_stats->hist[i] = priv->mib[ZX_MIB_RX_HIST + i];
+		rmon_stats->hist_tx[i] = priv->mib[ZX_MIB_TX_HIST + i];
+	}
+	mutex_unlock(&priv->adapter->mib_lock);
+
+	*ranges = zx_rmon_ranges;
+}
+
+static const struct ethtool_ops zx_ethtool_ops = {
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= zx_eth_get_link_ksettings,
+	.set_link_ksettings	= zx_eth_set_link_ksettings,
+	.nway_reset		= zx_eth_nway_reset,
+	.get_eth_mac_stats	= zx_eth_get_eth_mac_stats,
+	.get_rmon_stats		= zx_eth_get_rmon_stats,
+};
+
+/* ---- debugfs ------------------------------------------------------- */
+
+/* Driver counters and the main DMA, BMU and switch registers */
+static int zx_eth_dma_state_show(struct seq_file *s, void *data)
+{
+	struct zx_eth_adapter *adapter = dev_get_drvdata(s->private);
+	static const u32 regs[] = {
+		ZX_TM_TAB0_ADDR, ZX_TM_TAB1_ADDR, ZX_TM_BUF_F0,
+		ZX_TM_BUF_START, ZX_TM_BUF_END, ZX_BMU_CTRL,
+		ZX_BMU_FREE_STATUS,
+		ZX_DMA_CTRL, ZX_DMA_RING_CFG,
+		ZX_DMA_AREA50, ZX_DMA_TX_RING,
+		ZX_DMA_TX_START,
+		ZX_RX_REL_CTRL, ZX_RX_REL_DATA,
+		ZX_MAC_PORT(0), ZX_MAC_PORT(1), ZX_MAC_PORT(2),
+		ZX_MAC_PORT(3), ZX_MAC_PORT(4),
+		ZX_SW_FWD_CTRL,
+		ZX_SPA_UP_REG_PKT_EN, ZX_SPA_UP_REG_PKT_EN + 4,
+		ZX_SPA_DN_REG_PKT_EN, ZX_SPA_DN_REG_PKT_EN + 4,
+		0x1d4080, 0x1d4084,
+		0x1d40c0, 0x1d40c4,
+		0x1d4100, 0x1d4104,
+		ZX_SPA_TRAP_PROTO,
+		ZX_SPA_PORT_EN(0), ZX_SPA_PORT_EN(1), ZX_SPA_PORT_EN(2),
+		ZX_SPA_PORT_EN(3), ZX_SPA_PORT_EN(4), ZX_SPA_PORT_EN(6),
+	};
+	int i;
+
+	rtnl_lock();
+	seq_printf(s, "arena=%pad open_count=%d\n",
+		   &adapter->buf_pool_dma, adapter->open_count);
+	seq_printf(s, "tx_submitted=%u tx_completed=%u tx_pending=%u tx_done_excess=%u rx_resync=%u\n",
+		   adapter->tx_cur_idx, adapter->tx_complete_cnt,
+		   adapter->tx_pending, adapter->tx_done_excess,
+		   adapter->rx_resync_cnt);
+	seq_printf(s, "rx_alias=%u rx_nobuf=%u rx_rel_fail=%u rx_bad=%u\n",
+		   adapter->rx_alias_cnt, adapter->rx_nobuf_cnt,
+		   adapter->rx_rel_fail, adapter->rx_bad_cnt);
+	seq_printf(s, "ppe_active=%u ppe_flows=%u ppe_add_skip=%u ppe_add_fail=%u\n",
+		   adapter->ppe_active, adapter->ppe_count,
+		   adapter->ppe_add_skip, adapter->ppe_add_fail);
+	seq_printf(s, "sw_members=%#x sw_fdb_deleted=%u\n",
+		   adapter->sw_members,
+		   adapter->sw_fdb_deleted);
+	seq_printf(s, "bmu_alloc_fail=%u bmu_alloc_late=%u bmu_free_fail=%u bmu_free_slots=%u\n",
+		   adapter->bmu_alloc_fail, adapter->bmu_alloc_late,
+		   adapter->bmu_free_fail, adapter->bmu_free_slots);
+
+	for (i = 0; i < 0x100; i += 4)
+		seq_printf(s, "bmu+%03x=%08x\n", i,
+			   readl(adapter->base + ZX_BMU_BASE + i));
+	/* Reading 0x68 (TX done) would clear the count of sent frames */
+	for (i = 0; i < 0x120; i += 4) {
+		if (i == 0x68)
+			continue;
+		seq_printf(s, "dma+%03x=%08x\n", i,
+			   readl(adapter->base + ZX_DMA_BASE + i));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++)
+		seq_printf(s, "%06x=%08x\n", regs[i],
+			   readl(adapter->base + regs[i]));
+
+	for (i = 0; i < ZX_RX_QUEUES; i++)
+		seq_printf(s, "rxq%d count=%u consumed=%u\n", i,
+			   readl(adapter->base + ZX_DMA_RX_QUEUE_CNT(i)) & 0xffff,
+			   READ_ONCE(adapter->rx_cur_idx[i]));
+	rtnl_unlock();
+
+	return 0;
+}
+
+/*
+ * The driver cannot be unbound (suppress_bind_attrs) and has no remove
+ * function, so the directory stays until reboot.
+ */
+static void zx_eth_debugfs_init(struct zx_eth_adapter *adapter)
+{
+	struct dentry *dir = debugfs_create_dir(dev_name(adapter->dev), NULL);
+
+	debugfs_create_devm_seqfile(adapter->dev, "dma_state", dir,
+				    zx_eth_dma_state_show);
+}
+
+static int zx_eth_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zx_eth_adapter *adapter;
+	struct device_node *np;
+	u8 addrs[ZX_NUM_PORTS][ETH_ALEN];
+	unsigned long have_addr = 0;
+	struct device_node *ports_np;
+	int i, ret;
+
+	ports_np = of_get_child_by_name(dev->of_node, "ethernet-ports");
+	if (!ports_np)
+		return dev_err_probe(dev, -ENODEV, "no ethernet-ports node\n");
+
+	/*
+	 * The MAC addresses can come from nvmem cells on a flash partition
+	 * that is not registered yet.  Get them before the hardware is set
+	 * up, so that deferring the probe leaves no DMA running.
+	 */
+	for_each_available_child_of_node(ports_np, np) {
+		u32 port;
+
+		if (of_property_read_u32(np, "reg", &port) ||
+		    port >= ZX_NUM_PORTS)
+			continue;
+		ret = of_get_mac_address(np, addrs[port]);
+		if (ret == -EPROBE_DEFER) {
+			of_node_put(np);
+			of_node_put(ports_np);
+			return ret;
+		}
+		if (!ret)
+			__set_bit(port, &have_addr);
+	}
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		of_node_put(ports_np);
+		return dev_err_probe(dev, ret, "failed to set the DMA mask\n");
+	}
+
+	adapter = devm_kzalloc(dev, sizeof(*adapter), GFP_KERNEL);
+	if (!adapter) {
+		of_node_put(ports_np);
+		return -ENOMEM;
+	}
+
+	adapter->irq = platform_get_irq(pdev, 0);
+	if (adapter->irq < 0) {
+		of_node_put(ports_np);
+		return adapter->irq;
+	}
+
+	adapter->dev = dev;
+	spin_lock_init(&adapter->tx_lock);
+	spin_lock_init(&adapter->bmu_free_lock);
+	mutex_init(&adapter->ppe_lock);
+	spin_lock_init(&adapter->trap_lock);
+	mutex_init(&adapter->sw_lock);
+	spin_lock_init(&adapter->sw_fdb_lock);
+	INIT_WORK(&adapter->sw_work, zx_sw_work);
+	mutex_init(&adapter->mib_lock);
+	INIT_DELAYED_WORK(&adapter->mib_work, zx_mib_work);
+	ret = rhashtable_init(&adapter->ppe_flows, &zx_ppe_ht_params);
+	if (ret) {
+		of_node_put(ports_np);
+		return ret;
+	}
+
+	adapter->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adapter->base)) {
+		ret = PTR_ERR(adapter->base);
+		goto err_rhash;
+	}
+
+	adapter->buffer_pool = dma_alloc_coherent(dev, ZX_DMA_ARENA_SIZE,
+						  &adapter->buf_pool_dma, GFP_KERNEL);
+	if (!adapter->buffer_pool) {
+		ret = -ENOMEM;
+		goto err_rhash;
+	}
+	adapter->tab0 = adapter->buffer_pool + ZX_TAB0_OFFSET;
+	adapter->tab0_dma = adapter->buf_pool_dma + ZX_TAB0_OFFSET;
+	adapter->tab1 = adapter->buffer_pool + ZX_TAB1_OFFSET;
+	adapter->tab1_dma = adapter->buf_pool_dma + ZX_TAB1_OFFSET;
+	adapter->rx_ring = adapter->buffer_pool + ZX_RX_OFFSET;
+	adapter->rx_ring_dma = adapter->buf_pool_dma + ZX_RX_OFFSET;
+	adapter->tx_ring = adapter->buffer_pool + ZX_TX_OFFSET;
+	adapter->tx_ring_dma = adapter->buf_pool_dma + ZX_TX_OFFSET;
+
+	ret = zx_hw_init(adapter);
+	if (ret)
+		goto err_dma;
+	zx_dma_enable(adapter, true);
+
+	/* One netdev per port, named by the port's label */
+	for_each_available_child_of_node(ports_np, np) {
+		struct net_device *netdev;
+		struct zx_eth_priv *priv;
+		phy_interface_t interface;
+		const char *label;
+		u32 port;
+
+		if (of_property_read_u32(np, "reg", &port) || port >= ZX_NUM_PORTS ||
+		    adapter->ports[port]) {
+			dev_warn(dev, "%pOF: bad or duplicate reg\n", np);
+			continue;
+		}
+
+		netdev = devm_alloc_etherdev(dev, sizeof(struct zx_eth_priv));
+		if (!netdev) {
+			ret = -ENOMEM;
+			of_node_put(np);
+			goto err_disconnect;
+		}
+		SET_NETDEV_DEV(netdev, dev);
+		if (!of_property_read_string(np, "label", &label)) {
+			strscpy(netdev->name, label, IFNAMSIZ);
+			netdev->name_assign_type = NET_NAME_PREDICTABLE;
+		}
+		if (test_bit(port, &have_addr))
+			eth_hw_addr_set(netdev, addrs[port]);
+		else
+			eth_hw_addr_random(netdev);
+		netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+		netdev->netdev_ops = &zx_netdev_ops;
+		netdev->ethtool_ops = &zx_ethtool_ops;
+		netdev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+		netdev->hw_features |= NETIF_F_HW_TC;
+		netdev->features |= NETIF_F_HW_TC;
+		netdev->min_mtu    = 68;
+		netdev->max_mtu    = 1500;
+		priv = netdev_priv(netdev);
+		priv->netdev  = netdev;
+		priv->adapter = adapter;
+		priv->port    = port;
+		adapter->ports[port] = netdev;
+
+		ret = of_get_phy_mode(np, &interface);
+		if (ret) {
+			dev_err_probe(dev, ret, "%pOF: no valid phy-mode\n", np);
+			of_node_put(np);
+			goto err_disconnect;
+		}
+		priv->phylink_config.dev = &netdev->dev;
+		priv->phylink_config.type = PHYLINK_NETDEV;
+		priv->phylink_config.mac_capabilities = MAC_10 | MAC_100 |
+							MAC_1000FD;
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  priv->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  priv->phylink_config.supported_interfaces);
+		priv->phylink = phylink_create(&priv->phylink_config,
+					       of_fwnode_handle(np), interface,
+					       &zx_phylink_mac_ops);
+		if (IS_ERR(priv->phylink)) {
+			ret = dev_err_probe(dev, PTR_ERR(priv->phylink),
+					    "port %u: phylink\n", port);
+			priv->phylink = NULL;
+			of_node_put(np);
+			goto err_disconnect;
+		}
+		ret = phylink_of_phy_connect(priv->phylink, np, 0);
+		if (ret)
+			dev_warn(dev, "port %u: PHY connect failed: %d\n", port, ret);
+	}
+	of_node_put(ports_np);
+	ports_np = NULL;
+
+	/* The MAC counters start from zero, whatever the registers hold */
+	mutex_lock(&adapter->mib_lock);
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		struct zx_eth_priv *priv;
+
+		if (!adapter->ports[i])
+			continue;
+		priv = netdev_priv(adapter->ports[i]);
+		zx_mib_update(priv);
+		memset(priv->mib, 0, sizeof(priv->mib));
+	}
+	mutex_unlock(&adapter->mib_lock);
+
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		if (adapter->ports[i])
+			break;
+	if (i == ZX_NUM_PORTS) {
+		ret = dev_err_probe(dev, -ENODEV, "no usable port\n");
+		goto err_disconnect;
+	}
+
+	mutex_lock(&adapter->ppe_lock);
+	zx_update_mac_tables(adapter);
+	mutex_unlock(&adapter->ppe_lock);
+
+	/* One NAPI context serves all ports */
+	netif_napi_add(adapter->ports[i], &adapter->napi, zx_eth_poll);
+	hrtimer_setup(&adapter->tx_timer, zx_eth_tx_timer,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	/* zx_hw_init() masked the interrupt, a port's open enables it */
+	ret = devm_request_irq(dev, adapter->irq, zx_eth_isr, 0, dev_name(dev),
+			       adapter);
+	if (ret)
+		goto err_napi;
+
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		if (!adapter->ports[i])
+			continue;
+		ret = register_netdev(adapter->ports[i]);
+		if (ret) {
+			dev_err(dev, "port %d: register_netdev failed: %d\n", i, ret);
+			while (--i >= 0)
+				if (adapter->ports[i])
+					unregister_netdev(adapter->ports[i]);
+			goto err_napi;
+		}
+	}
+
+	platform_set_drvdata(pdev, adapter);
+
+	zx_sw_init(adapter);
+	schedule_delayed_work(&adapter->mib_work, ZX_MIB_INTERVAL);
+
+	zx_eth_debugfs_init(adapter);
+	return 0;
+
+err_napi:
+	netif_napi_del(&adapter->napi);
+err_disconnect:
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		struct zx_eth_priv *priv;
+
+		if (!adapter->ports[i])
+			continue;
+		priv = netdev_priv(adapter->ports[i]);
+		if (priv->phylink) {
+			phylink_disconnect_phy(priv->phylink);
+			phylink_destroy(priv->phylink);
+		}
+	}
+	of_node_put(ports_np);
+	zx_dma_enable(adapter, false);
+err_dma:
+	dma_free_coherent(dev, ZX_DMA_ARENA_SIZE, adapter->buffer_pool,
+			  adapter->buf_pool_dma);
+err_rhash:
+	rhashtable_destroy(&adapter->ppe_flows);
+	return ret;
+}
+
+/* ---- module glue --------------------------------------------------- */
+
+/*
+ * The switch writes received frames, and frames of offloaded flows, into
+ * the buffer pool without the CPU.  Stop it before a reboot or kexec: after
+ * kexec, that memory belongs to the next kernel.
+ */
+static void zx_eth_shutdown(struct platform_device *pdev)
+{
+	struct zx_eth_adapter *adapter = platform_get_drvdata(pdev);
+	int i;
+
+	if (!adapter)
+		return;
+
+	zx_sw_fini(adapter);
+
+	rtnl_lock();
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		if (!adapter->ports[i])
+			continue;
+		netif_device_detach(adapter->ports[i]);
+		dev_close(adapter->ports[i]);
+	}
+	rtnl_unlock();
+	cancel_work_sync(&adapter->sw_work);
+	cancel_delayed_work_sync(&adapter->mib_work);
+
+	zx_hw_reset(adapter);
+}
+
+static const struct of_device_id zx_eth_dt_ids[] = {
+	{ .compatible = "zte,zx279128s-gmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, zx_eth_dt_ids);
+
+static struct platform_driver zx_eth_driver = {
+	.probe  = zx_eth_probe,
+	.shutdown = zx_eth_shutdown,
+	.driver = {
+		.name           = DRV_NAME,
+		.of_match_table = zx_eth_dt_ids,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(zx_eth_driver);
+
+MODULE_AUTHOR("Navid Ghahremani <ghahramani.navid@gmail.com>");
+MODULE_DESCRIPTION("ZTE zx279128s Ethernet switch and DMA driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/zte/zx279128s-ppe.c b/drivers/net/ethernet/zte/zx279128s-ppe.c
new file mode 100644
index 0000000000..ff19d2cc67
--- /dev/null
+++ b/drivers/net/ethernet/zte/zx279128s-ppe.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE zx279128s Ethernet switch: hardware flow offload
+ *
+ * Copyright (C) 2026 Navid Ghahremani <ghahramani.navid@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/etherdevice.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ip.h>
+#include <linux/rhashtable.h>
+#include <linux/slab.h>
+#include <net/flow_offload.h>
+
+#include "zx279128s-eth.h"
+
+/* ---- Hardware flow offload ------------------------------------------ */
+
+/*
+ * The packet processor forwards established IPv4 TCP/UDP flows without the
+ * CPU: the classifier looks the 5-tuple up in two hash banks, the packet
+ * modifier rewrites MACs, addresses, ports and TTL, and the entry sends
+ * the frame straight to the egress port.  A miss goes to the CPU as usual.
+ * Formats reverse engineered from the stock firmware's NPU tables.
+ *
+ * The WAN is a plain switch port here, so the hardware treats both
+ * directions of a connection as upstream: both use the upstream key
+ * header, and each direction has its own flow (rewrite) index.
+ */
+
+struct zx_ppe_entry {
+	struct rhash_head	node;
+	unsigned long		cookie;
+	u16			hash;	/* 0-255 bank 0, 256-383 bank 1 */
+	u16			flow;
+	u16			nh;
+	u8			subnet;
+};
+
+const struct rhashtable_params zx_ppe_ht_params = {
+	.head_offset		= offsetof(struct zx_ppe_entry, node),
+	.key_offset		= offsetof(struct zx_ppe_entry, cookie),
+	.key_len		= sizeof(unsigned long),
+	.automatic_shrinking	= true,
+};
+
+static u32 zx_pp_data_reg(u32 blk, int i)
+{
+	if (blk == ZX_PM_BASE && i >= 4)
+		return ZX_PM_IND_DATA_HI + (i - 4) * 4;
+	return ZX_PP_IND_DATA + i * 4;
+}
+
+static int zx_pp_wait(struct zx_eth_adapter *adapter, u32 blk)
+{
+	u32 val;
+
+	return readl_poll_timeout(adapter->base + blk + ZX_PP_IND_STATUS, val,
+				  val & 1, 0, 1000);
+}
+
+/* Write @n data words of an entry; the hardware takes them when word 0 is
+ * written, so it goes last (as in the stock driver).
+ */
+static int zx_pp_write(struct zx_eth_adapter *adapter, u32 blk, u32 table,
+		       u32 index, const u32 *data, int n)
+{
+	int words = blk == ZX_CLA_BASE ? 17 : 8;
+	int i, ret;
+
+	ret = zx_pp_wait(adapter, blk);
+	if (ret)
+		return ret;
+	writel(index | table << 22, adapter->base + blk + ZX_PP_IND_CMD);
+	for (i = words - 1; i >= 0; i--)
+		writel(i < n ? data[i] : 0, adapter->base + blk + zx_pp_data_reg(blk, i));
+	/* the status can still read idle right after the command */
+	for (i = 0; i < 64 && (readl(adapter->base + blk + ZX_PP_IND_STATUS) & 1); i++)
+		;
+	return zx_pp_wait(adapter, blk);
+}
+
+static int zx_pp_read_word0(struct zx_eth_adapter *adapter, u32 blk, u32 table,
+			    u32 index, u32 *val)
+{
+	int i, ret;
+
+	ret = zx_pp_wait(adapter, blk);
+	if (ret)
+		return ret;
+	writel(index | table << 22 | ZX_PP_IND_READ, adapter->base + blk + ZX_PP_IND_CMD);
+	for (i = 0; i < 64 && (readl(adapter->base + blk + ZX_PP_IND_STATUS) & 1); i++)
+		;
+	ret = zx_pp_wait(adapter, blk);
+	if (!ret)
+		*val = readl(adapter->base + blk + ZX_PP_IND_DATA);
+	return ret;
+}
+
+/* MAC in the layout of the switch's MAC registers: bytes 2-5, then 0-1 */
+static void zx_mac_words(const u8 *mac, u32 *w)
+{
+	w[0] = mac[2] << 24 | mac[3] << 16 | mac[4] << 8 | mac[5];
+	w[1] = mac[0] << 8 | mac[1];
+}
+
+/* Set @width bits at bit @pos of a little-endian bit string */
+static void zx_ppe_put_bits(u8 *buf, int pos, int width, u32 val)
+{
+	int i;
+
+	for (i = 0; i < width; i++, pos++)
+		if (val & BIT(i))
+			buf[pos / 8] |= BIT(pos % 8);
+}
+
+/* MSB-first CRC over the key, last byte first, no init or final xor */
+static u32 zx_ppe_crc(u32 poly, const u8 *key, int len)
+{
+	u32 crc = 0;
+	int i, b;
+
+	for (i = len - 1; i >= 0; i--) {
+		crc ^= key[i] << 24;
+		for (b = 0; b < 8; b++)
+			crc = crc & BIT(31) ? crc << 1 ^ poly : crc << 1;
+	}
+	return crc;
+}
+
+struct zx_ppe_tuple {
+	u8	proto;
+	__be32	saddr, daddr;
+	__be16	sport, dport;
+};
+
+static void zx_ppe_halfwords(const struct zx_ppe_tuple *t, u16 hw[7])
+{
+	u32 s = be32_to_cpu(t->saddr), d = be32_to_cpu(t->daddr);
+
+	hw[0] = t->proto;
+	hw[1] = s >> 16;
+	hw[2] = s & 0xffff;
+	hw[3] = d >> 16;
+	hw[4] = d & 0xffff;
+	hw[5] = be16_to_cpu(t->sport);
+	hw[6] = be16_to_cpu(t->dport);
+}
+
+/* Hash slot of a tuple in bank 0 (0-255) and bank 1 (256-383).  The key is
+ * 45 bytes: header (extract rule id at bit 23, direction bit 32 = 0) and
+ * the extracted halfwords from bit 33.
+ */
+static void zx_ppe_slots(const struct zx_ppe_tuple *t, u16 slot[2])
+{
+	u8 key[45] = {};
+	u16 hw[7];
+	int i;
+
+	zx_ppe_halfwords(t, hw);
+	zx_ppe_put_bits(key, 23, 8, ZX_PPE_V4_RULE);
+	for (i = 0; i < 7; i++)
+		zx_ppe_put_bits(key, 33 + 16 * i, 16, hw[i]);
+	slot[0] = zx_ppe_crc(0x04c11db7, key, sizeof(key)) & 0xff;
+	slot[1] = ZX_PPE_HASH0_SIZE + (zx_ppe_crc(0x1edc6f41, key, sizeof(key)) & 0x7f);
+}
+
+/*
+ * Classifier entry: rewrite index, egress port and forward flag, then the
+ * key. Words 1-3 are the same constants in every entry of the stock
+ * firmware, and so is the 0x44 in word 0.
+ */
+static void zx_ppe_hash_entry(const struct zx_ppe_tuple *t, u16 flow, int port,
+			      u32 w[9])
+{
+	u8 key[20] = {};
+	u16 hw[7];
+	int i;
+
+	zx_ppe_halfwords(t, hw);
+	/* valid, extract index 9, upstream */
+	zx_ppe_put_bits(key, 0, 8, 0x40 | ZX_PPE_V4_INDEX);
+	for (i = 0; i < 7; i++)
+		zx_ppe_put_bits(key, 24 + 16 * i, 16, hw[i]);
+	w[0] = FIELD_PREP(ZX_CLA_W0_FLOW, flow) | ZX_CLA_W0_FWD |
+	       FIELD_PREP(ZX_CLA_W0_EGRESS, ZX_BRPORT(port)) | ZX_CLA_W0_BITS;
+	w[1] = 0xfa11c000;
+	w[2] = 0x00000608;
+	w[3] = 0x80000000;
+	for (i = 0; i < 5; i++)
+		w[4 + i] = get_unaligned_le32(key + 4 * i);
+}
+
+struct zx_ppe_rewrite {
+	bool	sip, dip, sport, dport;
+	__be16	new_sport, new_dport;
+	u8	subnet;
+	u16	nh;
+};
+
+/* Packet modifier flow entry (12 bytes, little-endian bit fields) */
+static void zx_ppe_flow_entry(const struct zx_ppe_rewrite *r, u32 w[3])
+{
+	u8 b[12] = {};
+
+	zx_ppe_put_bits(b, 0, 1, 1);			/* replace destination MAC */
+	zx_ppe_put_bits(b, 1, 1, 1);			/* replace source MAC */
+	if (r->dport)
+		zx_ppe_put_bits(b, 2, 16, be16_to_cpu(r->new_dport));
+	if (r->sport)
+		zx_ppe_put_bits(b, 18, 16, be16_to_cpu(r->new_sport));
+	zx_ppe_put_bits(b, 34, 1, 1);			/* decrement TTL */
+	zx_ppe_put_bits(b, 35, 1, 1);			/* update L4 checksum */
+	zx_ppe_put_bits(b, 36, 1, 1);			/* update IP checksum */
+	zx_ppe_put_bits(b, 37, 1, r->dport);
+	zx_ppe_put_bits(b, 38, 1, r->sport);
+	zx_ppe_put_bits(b, 39, 1, r->dip);
+	zx_ppe_put_bits(b, 40, 1, r->sip);
+	zx_ppe_put_bits(b, 41, 4, r->subnet);
+	zx_ppe_put_bits(b, 50, 9, r->nh);
+	w[0] = get_unaligned_le32(b);
+	w[1] = get_unaligned_le32(b + 4);
+	w[2] = get_unaligned_le32(b + 8);
+}
+
+/* Subnet: source MAC and (for SNAT) source IP of rewritten frames */
+static int zx_ppe_subnet_get(struct zx_eth_adapter *adapter, const u8 *mac,
+			     __be32 ip)
+{
+	int i, free = -1;
+	u32 w[2];
+
+	for (i = 0; i < ZX_PPE_SUBNETS; i++) {
+		if (adapter->ppe_subnet[i].refs &&
+		    ether_addr_equal(adapter->ppe_subnet[i].mac, mac) &&
+		    adapter->ppe_subnet[i].ip == ip) {
+			adapter->ppe_subnet[i].refs++;
+			return i;
+		}
+		if (!adapter->ppe_subnet[i].refs && free < 0)
+			free = i;
+	}
+	if (free < 0)
+		return -ENOSPC;
+
+	zx_mac_words(mac, w);
+	if (zx_pp_write(adapter, ZX_PM_BASE, ZX_PM_SRC_MAC, free, w, 2))
+		return -ETIMEDOUT;
+	writel(be32_to_cpu(ip), adapter->base + ZX_PP_SNAT_IP(free));
+	ether_addr_copy(adapter->ppe_subnet[free].mac, mac);
+	adapter->ppe_subnet[free].ip = ip;
+	adapter->ppe_subnet[free].refs = 1;
+	return free;
+}
+
+static void zx_ppe_subnet_put(struct zx_eth_adapter *adapter, int i)
+{
+	adapter->ppe_subnet[i].refs--;
+}
+
+static int zx_ppe_alloc(unsigned long *map, int size, int first)
+{
+	int i = find_next_zero_bit(map, size, first);
+
+	if (i >= size)
+		return -ENOSPC;
+	set_bit(i, map);
+	return i;
+}
+
+/*
+ * Apply one of the MAC rewrites that nf_flow_table_offload.c builds: the
+ * destination MAC as 4 bytes at offset 0 and 2 bytes at offset 4 (mask
+ * 0xffff0000), the source MAC as 2 bytes at offset 4 (mask 0x0000ffff, value
+ * in the upper half) and 4 bytes at offset 8. The masks and values are in
+ * CPU order, so the byte positions below are those of a little-endian CPU,
+ * which the zx279128s is.
+ */
+static void zx_ppe_mangle_eth(const struct flow_action_entry *act, void *eth)
+{
+	void *dest = eth + act->mangle.offset;
+	const void *src = &act->mangle.val;
+
+	if (act->mangle.offset > 8)
+		return;
+	if (act->mangle.mask == 0xffff) {
+		src += 2;
+		dest += 2;
+	}
+	memcpy(dest, src, act->mangle.mask ? 2 : 4);
+}
+
+static int zx_ppe_flow_add(struct zx_eth_adapter *adapter,
+			   struct flow_cls_offload *f)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
+	struct flow_action_entry *act;
+	struct zx_ppe_rewrite rw = {};
+	struct zx_ppe_tuple t = {};
+	struct net_device *odev = NULL;
+	struct zx_ppe_entry *e;
+	struct ethhdr eth = {};
+	__be32 new_saddr, new_daddr;
+	u16 slot[2];
+	u32 w[17];
+	int i, ret, port, subnet, flow, nh;
+
+	if (rhashtable_lookup_fast(&adapter->ppe_flows, &f->cookie, zx_ppe_ht_params))
+		return -EEXIST;
+
+	/* the hardware only sees frames from our switch ports */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META)) {
+		struct flow_match_meta match;
+
+		flow_rule_match_meta(rule, &match);
+		for (i = 0; i < ZX_NUM_PORTS; i++)
+			if (adapter->ports[i] &&
+			    adapter->ports[i]->ifindex == match.key->ingress_ifindex)
+				break;
+		if (i == ZX_NUM_PORTS)
+			return -EOPNOTSUPP;
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		if (match.key->addr_type != FLOW_DISSECTOR_KEY_IPV4_ADDRS)
+			return -EOPNOTSUPP;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+		if (match.key->n_proto != htons(ETH_P_IP))
+			return -EOPNOTSUPP;
+		t.proto = match.key->ip_proto;
+	}
+	if (t.proto != IPPROTO_TCP && t.proto != IPPROTO_UDP)
+		return -EOPNOTSUPP;
+
+	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS) ||
+	    !flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS))
+		return -EOPNOTSUPP;
+	{
+		struct flow_match_ipv4_addrs addrs;
+		struct flow_match_ports ports;
+
+		flow_rule_match_ipv4_addrs(rule, &addrs);
+		flow_rule_match_ports(rule, &ports);
+		t.saddr = addrs.key->src;
+		t.daddr = addrs.key->dst;
+		t.sport = ports.key->src;
+		t.dport = ports.key->dst;
+	}
+	new_saddr = t.saddr;
+	new_daddr = t.daddr;
+	rw.new_sport = t.sport;
+	rw.new_dport = t.dport;
+
+	flow_action_for_each(i, act, &rule->action) {
+		switch (act->id) {
+		case FLOW_ACTION_MANGLE:
+			switch (act->mangle.htype) {
+			case FLOW_ACT_MANGLE_HDR_TYPE_ETH:
+				zx_ppe_mangle_eth(act, &eth);
+				break;
+			case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
+				/* the value holds the address in network order */
+				if (act->mangle.offset == offsetof(struct iphdr, saddr))
+					new_saddr = (__force __be32)act->mangle.val;
+				else if (act->mangle.offset == offsetof(struct iphdr, daddr))
+					new_daddr = (__force __be32)act->mangle.val;
+				else
+					return -EOPNOTSUPP;
+				break;
+			case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
+			case FLOW_ACT_MANGLE_HDR_TYPE_UDP: {
+				u32 val = be32_to_cpu((__force __be32)act->mangle.val);
+
+				if (act->mangle.offset == 0) {
+					if (act->mangle.mask == ~(__force u32)cpu_to_be32(0xffff))
+						rw.new_dport = cpu_to_be16(val);
+					else
+						rw.new_sport = cpu_to_be16(val >> 16);
+				} else if (act->mangle.offset == 2) {
+					rw.new_dport = cpu_to_be16(val);
+				} else {
+					return -EOPNOTSUPP;
+				}
+				break;
+			}
+			default:
+				return -EOPNOTSUPP;
+			}
+			break;
+		case FLOW_ACTION_CSUM:
+			break;
+		case FLOW_ACTION_REDIRECT:
+			odev = act->dev;
+			break;
+		default:
+			/* VLAN, PPPoE and tunnel encapsulation are not supported */
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (!odev || !zx_eth_is_port(odev))
+		return -EOPNOTSUPP;
+	port = ((struct zx_eth_priv *)netdev_priv(odev))->port;
+	if (!is_valid_ether_addr(eth.h_source) || !is_valid_ether_addr(eth.h_dest))
+		return -EOPNOTSUPP;
+
+	rw.sip = new_saddr != t.saddr;
+	rw.dip = new_daddr != t.daddr;
+	rw.sport = rw.new_sport != t.sport;
+	rw.dport = rw.new_dport != t.dport;
+
+	zx_ppe_slots(&t, slot);
+	if (!test_bit(slot[0], adapter->ppe_hash_used))
+		slot[1] = slot[0];
+	else if (test_bit(slot[1], adapter->ppe_hash_used))
+		return -EBUSY;
+
+	e = kzalloc_obj(*e);
+	if (!e)
+		return -ENOMEM;
+
+	subnet = zx_ppe_subnet_get(adapter, eth.h_source, rw.sip ? new_saddr : 0);
+	if (subnet < 0) {
+		ret = subnet;
+		goto err_free;
+	}
+	flow = zx_ppe_alloc(adapter->ppe_flow_used, ZX_PPE_FLOWS, 1);
+	if (flow < 0) {
+		ret = flow;
+		goto err_subnet;
+	}
+	nh = zx_ppe_alloc(adapter->ppe_nh_used, ZX_PPE_NEXT_HOPS, 1);
+	if (nh < 0) {
+		ret = nh;
+		goto err_flow;
+	}
+	rw.subnet = subnet;
+	rw.nh = nh;
+
+	/* next hop: new destination IP (used for DNAT) and MAC */
+	w[0] = rw.dip ? be32_to_cpu(new_daddr) : 0;
+	zx_mac_words(eth.h_dest, w + 1);
+	ret = zx_pp_write(adapter, ZX_PM_BASE, ZX_PM_NEXT_HOP, nh, w, 3);
+	if (ret)
+		goto err_nh;
+	zx_ppe_flow_entry(&rw, w);
+	ret = zx_pp_write(adapter, ZX_PM_BASE, ZX_PM_FLOW, flow, w, 3);
+	if (ret)
+		goto err_nh;
+	ret = zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_AGING, slot[1], w, 0);
+	if (ret)
+		goto err_nh;
+	zx_ppe_hash_entry(&t, flow, port, w);
+	ret = zx_pp_write(adapter, ZX_CLA_BASE,
+			  slot[1] < ZX_PPE_HASH0_SIZE ? ZX_CLA_HASH0 : ZX_CLA_HASH1,
+			  slot[1] % ZX_PPE_HASH0_SIZE, w, 9);
+	if (ret)
+		goto err_nh;
+
+	e->cookie = f->cookie;
+	e->hash = slot[1];
+	e->flow = flow;
+	e->nh = nh;
+	e->subnet = subnet;
+	ret = rhashtable_insert_fast(&adapter->ppe_flows, &e->node, zx_ppe_ht_params);
+	if (ret)
+		goto err_entry;
+	set_bit(e->hash, adapter->ppe_hash_used);
+	adapter->ppe_count++;
+	return 0;
+
+err_entry:
+	zx_pp_write(adapter, ZX_CLA_BASE,
+		    slot[1] < ZX_PPE_HASH0_SIZE ? ZX_CLA_HASH0 : ZX_CLA_HASH1,
+		    slot[1] % ZX_PPE_HASH0_SIZE, w, 0);
+err_nh:
+	clear_bit(nh, adapter->ppe_nh_used);
+err_flow:
+	clear_bit(flow, adapter->ppe_flow_used);
+err_subnet:
+	zx_ppe_subnet_put(adapter, subnet);
+err_free:
+	kfree(e);
+	return ret;
+}
+
+static void zx_ppe_entry_remove(struct zx_eth_adapter *adapter,
+				struct zx_ppe_entry *e)
+{
+	zx_pp_write(adapter, ZX_CLA_BASE,
+		    e->hash < ZX_PPE_HASH0_SIZE ? ZX_CLA_HASH0 : ZX_CLA_HASH1,
+		    e->hash % ZX_PPE_HASH0_SIZE, NULL, 0);
+	zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_AGING, e->hash, NULL, 0);
+	clear_bit(e->hash, adapter->ppe_hash_used);
+	clear_bit(e->flow, adapter->ppe_flow_used);
+	clear_bit(e->nh, adapter->ppe_nh_used);
+	zx_ppe_subnet_put(adapter, e->subnet);
+	adapter->ppe_count--;
+}
+
+static int zx_ppe_flow_del(struct zx_eth_adapter *adapter,
+			   struct flow_cls_offload *f)
+{
+	struct zx_ppe_entry *e;
+
+	e = rhashtable_lookup_fast(&adapter->ppe_flows, &f->cookie, zx_ppe_ht_params);
+	if (!e)
+		return -ENOENT;
+	rhashtable_remove_fast(&adapter->ppe_flows, &e->node, zx_ppe_ht_params);
+	zx_ppe_entry_remove(adapter, e);
+	kfree(e);
+	return 0;
+}
+
+/* No packet counters: report use from the entry's hit flag */
+static int zx_ppe_flow_stats(struct zx_eth_adapter *adapter,
+			     struct flow_cls_offload *f)
+{
+	struct zx_ppe_entry *e;
+	u32 hit;
+
+	e = rhashtable_lookup_fast(&adapter->ppe_flows, &f->cookie, zx_ppe_ht_params);
+	if (!e)
+		return -ENOENT;
+	if (zx_pp_read_word0(adapter, ZX_CLA_BASE, ZX_CLA_AGING, e->hash, &hit))
+		return -ETIMEDOUT;
+	if (hit & 1) {
+		f->stats.lastused = jiffies;
+		zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_AGING, e->hash, NULL, 0);
+	}
+	return 0;
+}
+
+/* Values from the stock firmware */
+static const u32 zx_ppe_v4_index[5] = {
+	0x93929190, 0x97969594, 0x9b9a9998, 0x9f9e9d9c,
+	0x00150151,	/* bit 8: look up the hash banks */
+};
+
+static const u32 zx_ppe_v4_rule[16] = {
+	0x22038608, 0x000058a1, 0, 0, 0xf00ff000, 0xffffffff, 0xffffffff,
+	0x0fffffff, 0, 0, 0, 0, 0, 0, 0x00700000, 0x00092492,
+};
+
+static const u32 zx_ppe_sub[2] = { 0xfc000000, 0x00001fff };
+
+/* classifier L3 MTU and actions, packet modifier padding of short frames.
+ * The "other L3 packet" action (0x38c0cc) keeps the value 1 of the base
+ * driver: with the stock value 0, IPv6 addressed to our MACs was dropped
+ * once its trap was lifted (hardware LAN switching).
+ */
+static const u32 zx_ppe_regs[4] = { 0x38c088, 0x38c094, 0x38c098, 0x39c034 };
+static const u32 zx_ppe_reg_vals[4] = { 0x7fff, 4, 0x7fff7fff, 0x3d };
+
+/*
+ * Traps that send frames to the CPU before the flow lookup: the IPv4
+ * ethertype trap, and the registered packet class for TCP segments without
+ * payload (trap reason 0x2c), which would send every pure ACK of an
+ * offloaded connection through the software path.  Both are off while
+ * offload is active.  SYN, FIN and RST still reach the CPU, so conntrack
+ * sees connections open and close.  Hardware LAN switching also needs the
+ * IPv6 trap off.  Frames for the router, broadcast, multicast and unknown
+ * unicast still reach the CPU through the other traps.
+ */
+void zx_update_traps(struct zx_eth_adapter *adapter)
+{
+	void __iomem *base = adapter->base;
+	bool sw, fwd;
+	u32 val;
+
+	spin_lock(&adapter->trap_lock);
+	sw = READ_ONCE(adapter->sw_members);
+	fwd = READ_ONCE(adapter->ppe_active) || sw;
+	writel((fwd ? 0 : ETH_P_IP << 16) | (sw ? 0 : ETH_P_IPV6),
+	       base + ZX_SPA_TRAP_ETH_TYPE);
+	val = readl(base + ZX_SPA_UP_REG_PKT_EN + 8);
+	if (fwd)
+		val &= ~ZX_SPA_REG_PKT_TCP_ACK;
+	else
+		val |= ZX_SPA_REG_PKT_TCP_ACK;
+	writel(val, base + ZX_SPA_UP_REG_PKT_EN + 8);
+	spin_unlock(&adapter->trap_lock);
+}
+
+/*
+ * Frames to the ports' own addresses reach the CPU through the trap table,
+ * or with flow offload active, through the ONU MAC table, which marks them
+ * as routed so that the classifier sees them first.  Addresses beyond the
+ * trap table still reach the CPU as unknown unicast.  Called with ppe_lock
+ * held, after an address or the offload state changed.
+ */
+void zx_update_mac_tables(struct zx_eth_adapter *adapter)
+{
+	static const u8 none[ETH_ALEN];
+	void __iomem *base = adapter->base;
+	const u8 *addrs[ZX_NUM_PORTS];
+	int i, j, n = 0;
+	u32 w[2];
+
+	lockdep_assert_held(&adapter->ppe_lock);
+
+	/* each distinct port address once */
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		struct net_device *dev = adapter->ports[i];
+
+		if (!dev)
+			continue;
+		for (j = 0; j < n; j++)
+			if (ether_addr_equal(addrs[j], dev->dev_addr))
+				break;
+		if (j == n)
+			addrs[n++] = dev->dev_addr;
+	}
+
+	for (i = 0; i < ZX_SPA_ONU_MAC_NUM; i++) {
+		zx_mac_words(adapter->ppe_active && i < n ? addrs[i] : none, w);
+		writel(w[0], base + ZX_SPA_ONU_MAC + i * 8);
+		writel(w[1], base + ZX_SPA_ONU_MAC + i * 8 + 4);
+	}
+	for (i = 0; i < ZX_SPA_TRAP_DMAC_NUM; i++)
+		zx_set_trap_dmac(adapter, i,
+				 !adapter->ppe_active && i < n ? addrs[i] : none);
+}
+
+/*
+ * Routed frames must reach the classifier: mark our MACs as routed (ONU
+ * MAC table) and stop trapping IPv4 and frames to our MACs straight to the
+ * CPU.  IPv6, ARP and VLAN tagged frames stay trapped.  Frames the
+ * classifier does not know still go to the CPU.
+ */
+static int zx_ppe_start(struct zx_eth_adapter *adapter)
+{
+	static const u32 cmd = 0x00010000;
+	void __iomem *base = adapter->base;
+	int i, ret;
+
+	for (i = 0; i < ZX_PPE_SUBNETS; i++)
+		adapter->ppe_subnet[i].refs = 0;
+	bitmap_zero(adapter->ppe_hash_used, ZX_PPE_HASH_SIZE);
+	bitmap_zero(adapter->ppe_flow_used, ZX_PPE_FLOWS);
+	bitmap_zero(adapter->ppe_nh_used, ZX_PPE_NEXT_HOPS);
+
+	for (i = 0; i < ARRAY_SIZE(zx_ppe_regs); i++) {
+		adapter->ppe_saved[i] = readl(base + zx_ppe_regs[i]);
+		writel(zx_ppe_reg_vals[i], base + zx_ppe_regs[i]);
+	}
+
+	ret = zx_pp_write(adapter, ZX_PM_BASE, ZX_PM_CMD, 0, &cmd, 1);
+	if (!ret)
+		ret = zx_pp_write(adapter, ZX_PM_BASE, ZX_PM_SUB, 0, zx_ppe_sub, 2);
+	if (!ret)
+		ret = zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_EXTRA_RULE,
+				  ZX_PPE_V4_RULE, zx_ppe_v4_rule, 16);
+	if (!ret)
+		ret = zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_EXTRA_INDEX,
+				  ZX_PPE_V4_INDEX, zx_ppe_v4_index, 5);
+	if (ret) {
+		for (i = 0; i < ARRAY_SIZE(zx_ppe_regs); i++)
+			writel(adapter->ppe_saved[i], base + zx_ppe_regs[i]);
+		return ret;
+	}
+
+	adapter->ppe_active = true;
+	zx_update_mac_tables(adapter);
+	zx_update_traps(adapter);
+	dev_info(adapter->dev, "hardware flow offload enabled\n");
+	return 0;
+}
+
+static void zx_ppe_flush(void *ptr, void *arg)
+{
+	struct zx_ppe_entry *e = ptr;
+
+	zx_ppe_entry_remove(arg, e);
+	kfree(e);
+}
+
+static void zx_ppe_stop(struct zx_eth_adapter *adapter)
+{
+	void __iomem *base = adapter->base;
+	int i, ret;
+
+	/* back to trapping everything, then drop the tables */
+	adapter->ppe_active = false;
+	zx_update_traps(adapter);
+	zx_update_mac_tables(adapter);
+
+	rhashtable_free_and_destroy(&adapter->ppe_flows, zx_ppe_flush, adapter);
+	ret = rhashtable_init(&adapter->ppe_flows, &zx_ppe_ht_params);
+	if (ret)
+		dev_err(adapter->dev, "failed to reinitialize flow table: %d\n", ret);
+	zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_EXTRA_INDEX, ZX_PPE_V4_INDEX, NULL, 0);
+	zx_pp_write(adapter, ZX_CLA_BASE, ZX_CLA_EXTRA_RULE, ZX_PPE_V4_RULE, NULL, 0);
+	for (i = 0; i < ARRAY_SIZE(zx_ppe_regs); i++)
+		writel(adapter->ppe_saved[i], base + zx_ppe_regs[i]);
+	dev_info(adapter->dev, "hardware flow offload disabled\n");
+}
+
+static int zx_ppe_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
+{
+	struct zx_eth_adapter *adapter = cb_priv;
+	struct flow_cls_offload *f = type_data;
+	int ret;
+
+	if (type != TC_SETUP_CLSFLOWER)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adapter->ppe_lock);
+	switch (f->command) {
+	case FLOW_CLS_REPLACE:
+		ret = zx_ppe_flow_add(adapter, f);
+		if (ret == -EOPNOTSUPP)
+			adapter->ppe_add_skip++;
+		else if (ret && ret != -EEXIST)
+			adapter->ppe_add_fail++;
+		break;
+	case FLOW_CLS_DESTROY:
+		ret = zx_ppe_flow_del(adapter, f);
+		break;
+	case FLOW_CLS_STATS:
+		ret = zx_ppe_flow_stats(adapter, f);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+	mutex_unlock(&adapter->ppe_lock);
+	return ret;
+}
+
+static LIST_HEAD(zx_ppe_block_cb_list);
+
+/* One callback for the flowtable of all port netdevs, so each flow is
+ * offered once.
+ */
+int zx_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		    void *type_data)
+{
+	struct zx_eth_priv *priv = netdev_priv(dev);
+	struct zx_eth_adapter *adapter = priv->adapter;
+	struct flow_block_offload *f = type_data;
+	struct flow_block_cb *block_cb;
+	int ret = 0;
+
+	if (type != TC_SETUP_FT)
+		return -EOPNOTSUPP;
+	if (f->binder_type != FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		return -EOPNOTSUPP;
+
+	f->driver_block_list = &zx_ppe_block_cb_list;
+	block_cb = flow_block_cb_lookup(f->block, zx_ppe_block_cb, adapter);
+
+	switch (f->command) {
+	case FLOW_BLOCK_BIND:
+		if (block_cb) {
+			flow_block_cb_incref(block_cb);
+			return 0;
+		}
+		block_cb = flow_block_cb_alloc(zx_ppe_block_cb, adapter, adapter, NULL);
+		if (IS_ERR(block_cb))
+			return PTR_ERR(block_cb);
+		/* A ruleset reload binds the new flowtable before it unbinds the
+		 * old one, so keep the hardware on while any flowtable is bound.
+		 */
+		mutex_lock(&adapter->ppe_lock);
+		if (!adapter->ppe_users)
+			ret = zx_ppe_start(adapter);
+		if (!ret)
+			adapter->ppe_users++;
+		mutex_unlock(&adapter->ppe_lock);
+		if (ret) {
+			flow_block_cb_free(block_cb);
+			return ret;
+		}
+		flow_block_cb_incref(block_cb);
+		flow_block_cb_add(block_cb, f);
+		list_add_tail(&block_cb->driver_list, &zx_ppe_block_cb_list);
+		return 0;
+	case FLOW_BLOCK_UNBIND:
+		if (!block_cb)
+			return -ENOENT;
+		if (!flow_block_cb_decref(block_cb)) {
+			flow_block_cb_remove(block_cb, f);
+			list_del(&block_cb->driver_list);
+			mutex_lock(&adapter->ppe_lock);
+			if (!--adapter->ppe_users)
+				zx_ppe_stop(adapter);
+			mutex_unlock(&adapter->ppe_lock);
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/ethernet/zte/zx279128s-switch.c b/drivers/net/ethernet/zte/zx279128s-switch.c
new file mode 100644
index 0000000000..b76a057f1d
--- /dev/null
+++ b/drivers/net/ethernet/zte/zx279128s-switch.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE zx279128s Ethernet switch: hardware LAN switching
+ *
+ * Copyright (C) 2026 Navid Ghahremani <ghahramani.navid@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/rtnetlink.h>
+#include <net/switchdev.h>
+
+#include "zx279128s-eth.h"
+
+/* ---- Hardware LAN switching ---------------------------------------- */
+
+/*
+ * The bridge block forwards a unicast frame from one switch port to another
+ * when its source table knows the destination and both ports are members
+ * of the port VLAN (1).  Normally learning is off and the VLAN table empty,
+ * so every frame goes to the Linux bridge.  Ports of the same Linux bridge
+ * switch between each other in hardware, as long as the bridge does not
+ * filter VLANs and the port forwards, learns, and is neither isolated nor
+ * locked (zx_sw_bridge()); any other port stays on the CPU path:
+ * - VLAN 1 has them as untagged members, each may send only to the other
+ *   ports of its bridge (egress mask 0 for all other ports, so nothing is
+ *   switched to or from a port outside the bridge), and only they learn;
+ * - the IPv4 and IPv6 ethertype traps are off (zx_update_traps()).
+ * Only known unicast is switched.  Frames for the router, broadcast,
+ * multicast and unknown unicast reach the CPU alone, and the Linux bridge
+ * floods them, also to the hosts on its other ports (Wi-Fi).  So received
+ * frames are never marked as forwarded already (offload_fwd_mark).
+ * A host that moves loses its hardware entry: the entries of a port are
+ * dropped when its link goes down, and a MAC is dropped as soon as the
+ * Linux bridge learns it on a port that is not a switch port.
+ */
+static int zx_sbrg_ind(struct zx_eth_adapter *adapter, u32 cmd)
+{
+	u32 val;
+
+	writel(cmd, adapter->base + ZX_SBRG_IND_CMD);
+	return readl_poll_timeout_atomic(adapter->base + ZX_SBRG_IND_DONE, val,
+					 val & 1, 0, 1000);
+}
+
+static void zx_sbrg_flush(struct zx_eth_adapter *adapter, u8 brports)
+{
+	void __iomem *reg = adapter->base + ZX_SBRG_PORT_CTRL;
+	u32 val = readl(reg) & ~(ZX_SBRG_FLUSH_PORTS | ZX_SBRG_FLUSH);
+
+	writel(val | FIELD_PREP(ZX_SBRG_FLUSH_PORTS, brports) | ZX_SBRG_FLUSH, reg);
+	usleep_range(1000, 2000);
+	writel(val, reg);
+}
+
+/* Remove one MAC from the source table: scan the four RAMs */
+static void zx_sbrg_fdb_del(struct zx_eth_adapter *adapter, const u8 *mac)
+{
+	static const int sizes[4] = { 1024, 256, 512, 512 };
+	void __iomem *base = adapter->base;
+	u32 hi = mac[0] << 16 | mac[1] << 8 | mac[2];
+	u32 lo = mac[3] << 24 | mac[4] << 16 | mac[5] << 8;
+	int ram, i;
+
+	for (ram = 0; ram < 4; ram++) {
+		int bank_size = sizes[ram];
+
+		for (i = 0; i < bank_size; i++) {
+			if (zx_sbrg_ind(adapter, ZX_SBRG_IND_READ | ram << 22 | i))
+				return;
+			if (!(readl(base + ZX_SBRG_IND_DATA(2)) & 0xf0) ||
+			    (readl(base + ZX_SBRG_IND_DATA(1)) & 0xffffff) != hi ||
+			    (readl(base + ZX_SBRG_IND_DATA(0)) & 0xffffff00) != lo)
+				continue;
+			writel(0, base + ZX_SBRG_IND_DATA(2));
+			writel(0, base + ZX_SBRG_IND_DATA(1));
+			writel(0, base + ZX_SBRG_IND_DATA(0));
+			if (zx_sbrg_ind(adapter, ram << 22 | i))
+				return;
+			adapter->sw_fdb_deleted++;
+		}
+	}
+}
+
+/* the bridge a port switches in, or NULL if it stays on the CPU path */
+static struct net_device *zx_sw_bridge(struct net_device *dev)
+{
+	struct net_device *br;
+
+	ASSERT_RTNL();
+	if (!dev || !netif_is_bridge_port(dev))
+		return NULL;
+	br = netdev_master_upper_dev_get(dev);
+	if (!br || br_vlan_enabled(br) ||
+	    br_port_get_stp_state(dev) != BR_STATE_FORWARDING ||
+	    !br_port_flag_is_set(dev, BR_LEARNING) ||
+	    br_port_flag_is_set(dev, BR_ISOLATED) ||
+	    br_port_flag_is_set(dev, BR_PORT_LOCKED))
+		return NULL;
+	return br;
+}
+
+static void zx_sw_apply(struct zx_eth_adapter *adapter)
+{
+	struct net_device *br[ZX_NUM_PORTS] = {};
+	void __iomem *base = adapter->base;
+	u8 egress[ZX_NUM_PORTS] = {};
+	u8 members = 0;
+	u32 vlan = 0;
+	int i, j;
+
+	lockdep_assert_held(&adapter->sw_lock);
+
+	rtnl_lock();
+	for (i = 0; adapter->sw_ready && i < ZX_NUM_PORTS; i++)
+		br[i] = zx_sw_bridge(adapter->ports[i]);
+	rtnl_unlock();
+
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		for (j = 0; j < ZX_NUM_PORTS; j++)
+			if (j != i && br[i] && br[j] == br[i])
+				egress[i] |= BIT(ZX_BRPORT(j));
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		if (!egress[i]) {
+			br[i] = NULL;
+			continue;
+		}
+		members |= BIT(ZX_BRPORT(i));
+		vlan |= ZX_SBRG_VLAN_UNTAG(ZX_BRPORT(i));
+	}
+
+	spin_lock_bh(&adapter->sw_fdb_lock);
+	memcpy(adapter->sw_bridge, br, sizeof(br));
+	spin_unlock_bh(&adapter->sw_fdb_lock);
+
+	/* traps back on before the tables go, off once they are in place */
+	if (!members) {
+		WRITE_ONCE(adapter->sw_members, 0);
+		zx_update_traps(adapter);
+	}
+
+	/* no learning while the tables change, then start empty */
+	writel(0, base + ZX_SBRG_LEARN);
+	writel(members ? vlan | ZX_SBRG_VLAN_VALID : 0,
+	       base + ZX_SBRG_IND_DATA(0));
+	if (zx_sbrg_ind(adapter, ZX_SBRG_MEM_VLAN << 22 | 1))
+		dev_warn(adapter->dev, "bridge VLAN table access timed out\n");
+	/* the reset value lets a port send to every other port */
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		writel(members ? egress[i] : (u8)~BIT(ZX_BRPORT(i)),
+		       base + ZX_SBRG_EGRESS(ZX_BRPORT(i)));
+	zx_sbrg_flush(adapter, 0xff);
+	writel(members, base + ZX_SBRG_LEARN);
+	if (members) {
+		WRITE_ONCE(adapter->sw_members, members);
+		zx_update_traps(adapter);
+	}
+	dev_dbg(adapter->dev, "hardware LAN switching %s (bridge ports %#x)\n",
+		members ? "on" : "off", members);
+}
+
+void zx_sw_work(struct work_struct *work)
+{
+	struct zx_eth_adapter *adapter = container_of(work, struct zx_eth_adapter,
+						      sw_work);
+	u8 macs[ZX_SW_FDB_QUEUE][ETH_ALEN];
+	bool recompute, overflow;
+	unsigned int n, i;
+	u8 flush;
+
+	spin_lock_bh(&adapter->sw_fdb_lock);
+	recompute = adapter->sw_recompute;
+	overflow = adapter->sw_fdb_overflow;
+	flush = adapter->sw_flush;
+	n = adapter->sw_fdb_count;
+	memcpy(macs, adapter->sw_fdb_mac, n * ETH_ALEN);
+	adapter->sw_recompute = false;
+	adapter->sw_fdb_overflow = false;
+	adapter->sw_flush = 0;
+	adapter->sw_fdb_count = 0;
+	spin_unlock_bh(&adapter->sw_fdb_lock);
+
+	mutex_lock(&adapter->sw_lock);
+	if (recompute) {
+		zx_sw_apply(adapter);
+	} else if (READ_ONCE(adapter->sw_members)) {
+		if (overflow)
+			flush = 0xff;
+		if (flush)
+			zx_sbrg_flush(adapter, flush);
+		for (i = 0; !overflow && i < n; i++)
+			zx_sbrg_fdb_del(adapter, macs[i]);
+	}
+	mutex_unlock(&adapter->sw_lock);
+}
+
+void zx_sw_port_down(struct zx_eth_adapter *adapter, int port)
+{
+	if (!READ_ONCE(adapter->sw_members))
+		return;
+	spin_lock_bh(&adapter->sw_fdb_lock);
+	adapter->sw_flush |= BIT(ZX_BRPORT(port));
+	spin_unlock_bh(&adapter->sw_fdb_lock);
+	schedule_work(&adapter->sw_work);
+}
+
+static bool zx_sw_is_port(struct zx_eth_adapter *adapter,
+			  const struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < ZX_NUM_PORTS; i++)
+		if (adapter->ports[i] == dev)
+			return true;
+	return false;
+}
+
+static void zx_sw_recompute(struct zx_eth_adapter *adapter)
+{
+	spin_lock_bh(&adapter->sw_fdb_lock);
+	adapter->sw_recompute = true;
+	spin_unlock_bh(&adapter->sw_fdb_lock);
+	schedule_work(&adapter->sw_work);
+}
+
+/* a switch port joined or left a bridge */
+static int zx_sw_netdev_event(struct notifier_block *nb, unsigned long event,
+			      void *ptr)
+{
+	struct zx_eth_adapter *adapter = container_of(nb, struct zx_eth_adapter,
+						      sw_netdev_nb);
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (event == NETDEV_CHANGEUPPER && zx_sw_is_port(adapter, dev))
+		zx_sw_recompute(adapter);
+	return NOTIFY_DONE;
+}
+
+static bool zx_sw_dev_check(const struct net_device *dev)
+{
+	return zx_eth_is_port(dev);
+}
+
+/* something that decides whether the port switches (zx_sw_bridge()) */
+static int zx_sw_port_attr_set(struct net_device *dev, const void *ctx,
+			       const struct switchdev_attr *attr,
+			       struct netlink_ext_ack *extack)
+{
+	struct zx_eth_priv *priv = netdev_priv(dev);
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		/* the CPU path handles what the switch does not */
+		return 0;
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		zx_sw_recompute(priv->adapter);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int zx_sw_switchdev_blocking_event(struct notifier_block *nb,
+					  unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	if (event != SWITCHDEV_PORT_ATTR_SET)
+		return NOTIFY_DONE;
+	err = switchdev_handle_port_attr_set(dev, ptr, zx_sw_dev_check,
+					     zx_sw_port_attr_set);
+	return notifier_from_errno(err);
+}
+
+/* the Linux bridge learned a MAC; if it is on a non-switch port of a
+ * switching bridge (Wi-Fi), the host left its switch port
+ */
+static int zx_sw_switchdev_event(struct notifier_block *nb,
+				 unsigned long event, void *ptr)
+{
+	struct zx_eth_adapter *adapter = container_of(nb, struct zx_eth_adapter,
+						      sw_switchdev_nb);
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_fdb_info *fdb;
+	struct net_device *br;
+	bool queued = false;
+	int i;
+
+	if (event != SWITCHDEV_FDB_ADD_TO_DEVICE || zx_sw_is_port(adapter, dev))
+		return NOTIFY_DONE;
+	fdb = container_of(ptr, struct switchdev_notifier_fdb_info, info);
+	if (fdb->is_local)
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	br = netdev_master_upper_dev_get_rcu(dev);
+	rcu_read_unlock();
+	if (!br)
+		return NOTIFY_DONE;
+
+	spin_lock_bh(&adapter->sw_fdb_lock);
+	for (i = 0; i < ZX_NUM_PORTS; i++) {
+		if (adapter->sw_bridge[i] != br)
+			continue;
+		if (adapter->sw_fdb_count < ZX_SW_FDB_QUEUE)
+			memcpy(adapter->sw_fdb_mac[adapter->sw_fdb_count++],
+			       fdb->addr, ETH_ALEN);
+		else
+			adapter->sw_fdb_overflow = true;
+		queued = true;
+		break;
+	}
+	spin_unlock_bh(&adapter->sw_fdb_lock);
+	if (queued)
+		schedule_work(&adapter->sw_work);
+	return NOTIFY_DONE;
+}
+
+/* Follow the bridges the ports are in; called at the end of probe */
+void zx_sw_init(struct zx_eth_adapter *adapter)
+{
+	int ret;
+
+	adapter->sw_netdev_nb.notifier_call = zx_sw_netdev_event;
+	adapter->sw_switchdev_nb.notifier_call = zx_sw_switchdev_event;
+	adapter->sw_switchdev_blocking_nb.notifier_call =
+		zx_sw_switchdev_blocking_event;
+
+	ret = register_netdevice_notifier(&adapter->sw_netdev_nb);
+	if (ret)
+		goto err_netdev;
+
+	ret = register_switchdev_notifier(&adapter->sw_switchdev_nb);
+	if (ret)
+		goto err_switchdev;
+
+	ret = register_switchdev_blocking_notifier(&adapter->sw_switchdev_blocking_nb);
+	if (ret)
+		goto err_blocking;
+
+	adapter->sw_ready = true;
+	return;
+
+err_blocking:
+	unregister_switchdev_notifier(&adapter->sw_switchdev_nb);
+err_switchdev:
+	unregister_netdevice_notifier(&adapter->sw_netdev_nb);
+err_netdev:
+	dev_warn(adapter->dev,
+		 "no bridge notifications: hardware LAN switching unavailable\n");
+}
+
+void zx_sw_fini(struct zx_eth_adapter *adapter)
+{
+	if (!adapter->sw_ready)
+		return;
+
+	adapter->sw_ready = false;
+	unregister_switchdev_blocking_notifier(&adapter->sw_switchdev_blocking_nb);
+	unregister_switchdev_notifier(&adapter->sw_switchdev_nb);
+	unregister_netdevice_notifier(&adapter->sw_netdev_nb);
+}
-- 
2.55.0

