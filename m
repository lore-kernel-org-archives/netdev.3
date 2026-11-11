Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408279;
	b=PLAkREPoqJFT9FQLZNg4wLi7X03pN9KRwBuep2LKUOGNzQ/IyvaFiS5oDtqBYyw9lLTV
	 li82HMosp0GcEqKi080r21d68xl74SR2x/iQf4Sm5XTpGQWnsn4wG4g6AVwZadnGkTDOa
	 q8Pg+nls2pOkGML3wMYxmvEJS8jSzUUGNibtumDceKMriIxPDvwWs+ogNCQ5iNBuZmrJF
	 hqnaGC9sBQCBoMKhhMbDmIARr5jZEoG5/kXvUzuSErM70DVkD9poc+eVFaB3x57SGNV84
	 X7RD+6K9DT85X8J57BSky6TDMgRn3CZuyeVG6X8fbjTUSXoHgaTrG9e9VD7LFShymmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rdw2NKGEuK2ni3E8kXFnfQTK+FHixFrqZyMHbZczHI4=;
	b=g0bn77gCIH/pg/3B4U3KBfgMLO2KKPah6onBLNvbZkDMuRC6x/7kPmiXbMWGCD2z/sVn
	 F+I0ZKFAiEvf+7Gh3LZ+NXZyvXwkc78v/BapdSu4UycFxoFSWBDmGmedvbDwWbqzeiBSz
	 0j5lyt5xFMn4T80xHbNuLuoEtcPWNIbD7dbNa4KLjXanuiTX3STnGy8uKjhs6cQacmLGW
	 NINQqa2cjkmIAmM+bwx+QxWfZJIEaBgE4Le9IBoF6jHWi5/EynohIis2jThwVEx7YTbHJ
	 8PxKj/X4iQS3XkIwyAVl2vdVeTI3T8dzWVCIRvogKe8R3oS0PeQwc4p43Uh9aQeWFPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbJl675O;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD660A261C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFD660A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbJl675O
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so36488205e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408277; x=1795013077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdw2NKGEuK2ni3E8kXFnfQTK+FHixFrqZyMHbZczHI4=;
        b=GbJl675OP0CDslmuWUuJm3rnklOw74KW5UWhC0QeBbefYrQxOc8DbQOhE89RR2UVNt
         GKvpfg9qx91/Js04/Xxy71E0EigHQMHQslYDdvx0Sqy+ba5tYlsMbWdBIt+rC302V0UX
         cnRro2br3BiGGYO8W6yajAE3OwaEzWfCZrTIz4dobgAlKCu60o2tfTLUf+7liKExwzJC
         Q8RgQXa1CIbAITAtuO0G5xK5isjj4v63pLLZJA/ybGpfKWCqGRoCxnUfv00UJx67F/LS
         dDMY5qdoZHA1RlAaDWuQd+jEGYk3KCy6xkLUD7TzGc6qpBdxLY+h7KcnXGsYI0S83gRK
         tfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408277; x=1795013077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rdw2NKGEuK2ni3E8kXFnfQTK+FHixFrqZyMHbZczHI4=;
        b=R9FiagIufHvU6NuYcMJ4SX5geodTss8sb0UoRI7MUJfdB2/t0BcJVy7lpsnZnOf0JR
         IwJo2mCebnfRei3KvhWueVklvTx+FicqAeSLnoaXVmUtOVqQLF33yZJ4gDa6cvPLWF0C
         PjtNJLiowwayiwLeneIePJMLyIZ+A909qKMm6Lc58nLu5xazF+QxGkOjvtE/8tGNzRTJ
         yLhZz7JPILrQQWZo4QE0Ir+oq3AlGvqAGfGG6c/CgzKVibC1rw1Mn7SkK+rvRYxoJJEk
         pbPmFARqhh2pLy+/wqoD4Y3jZfBJd33IgZF6UUqViHtnvkODXVwFM1vk8fnq994EwI3i
         stxQ==
X-Forwarded-Encrypted: i=1; AL+hErEkeW/4fOxe01nhqF/VSuE26GeyDeIn5gsNypk6XsOTD1cGjZ7t2osU1W9AHllpQXKeuvdypSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AwrtrY0IprvbP96C/sMDFhsv8S60UEN85ddCfeEqPXZDFNHYj
	f16E61VrqVjY8t3BhxpB0O5Ct83bTLwpV3newkWFZzC7UkQfjkn2CSRz
X-Gm-Gg: AYBFou0ad8bnZxOi8YaoieYviZF2g3/8V3TvFxkk/jHOEDFeX0GQXE69mfHpfxekIIc
	5moE+sPTZHFFcwYAUIeEi84iG/FF6zl9uaPFNoXMVEBvbNmR20O4gI6Az8QASf6p4mVPNJrQpOo
	vsWeh4UdAwuDctQSZ85t6Jmk93Mgm/UFSImApn7HDCFJU6TMaLUNMZ7mfsOlQFeAyoVfR8i/e+2
	iYTJ6Hfw4yH7RjflqbdvXp8EnQjN7PfWD5Ob9BXFd9Pcxa61TiYNAQyH/p+CQQD4iOAoLxaRaBs
	R9utwSWz1pgrIYVFyw6k/0autcRmcWnpl9chFqgfkxHIJckiOj6p+tWeQ1qk9oyDF+FQ3mABOTz
	l1Rt+YbYRgjkySrHqPTet6ngzfJgIIhNJzPQDA1EpbJd/myDk8XR9FQE5GTR26O5e5gIttOU4qP
	+Tu7QrzfStHd7UYwEgsvoE+OEmQ+Yf4n5nDeFrlC+9SvOhvWaLT9NpbhypJM6E0JLg/AKIk29Vk
	32BRVuV7kcxUFLJgpXUVpvSeDha1dDbKvKy98A5UpcOxliQHuGgDl4XxsLbUb5KCoVCYTkmvIAA
	ke/R5K+EASxk7Vjp3W7M4cTAAAVaqdVFyFo13q85ioF/5UVa2Wy7PNzdsw==
X-Received: by 2002:a05:600c:8b34:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4ba093775a9mr48741465e9.7.1794408276368;
        Wed, 11 Nov 2026 06:44:36 -0800 (PST)
Received: from dev.Default ([86.127.229.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08de826asm46656495e9.0.2026.11.11.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:44:35 -0800 (PST)
From: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junyang Han <han.junyang@zte.com.cn>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 3/5] net: ethernet: zte: zx279128s: WLAN DMA ring and logical ports
Date: Wed, 11 Nov 2026 15:44:24 +0100
Message-Id: <20261111144426.1321237-4-isasmendi.agus@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
References: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
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

The switch fabric has a second DMA engine ("IDM" in the vendor code):
one RX and one TX ring of 8-byte descriptors.  A frame written to the
TX ring enters the fabric on port 6 or 7 (descriptor bit 31) as if sent
by the station the 3-bit "ssid" field names, and a classifier entry
whose egress is such a WLAN logical port (0x10 | port << 3 | ssid) makes
the fabric write the rewritten frame to the RX ring with that ssid.
The vendor firmware uses this to forward WLAN traffic without the CPU.

Add the ring (coherent descriptor area, buffer pool, NAPI, the vendor's
register sequence) behind the optional "wlan" interrupt, and the 16
logical ports as slots a mac80211 AP interface can be bound to:

- frames the fabric forwards to a bound port are handed to the
  interface for transmission through its ordinary queueing path, after
  the IPv4 header checksum is recomputed (the packet modifier
  decrements the TTL, and only the MAC egress pipeline repairs the
  checksum, which this path does not pass);
- a netfilter ingress hook on the bound interface injects the frames of
  flows the fabric holds for that port into the TX ring, re-segmenting
  mac80211's GRO superframes to wire size first; SYN, FIN and RST stay
  on the CPU so that conntrack sees connections open and close;
- an injected frame the classifier does not forward comes back on the
  switch RX ring with the WLAN port as ingress (0x10-0x1f instead of a
  switch port); it is delivered as received by the interface, marked so
  that the hook lets it pass.

Nothing binds a port yet: the flow offload code does that in the next
change.  The WLAN drivers are not involved, only the interfaces' normal
transmit and receive paths, so any mac80211 driver works.  Without the
"wlan" interrupt in the device tree the driver behaves as before.

Register sequence and descriptor layout reverse engineered from the
vendor's pon_npp_idm_init() / idm_net_tx() / idm_net_poll() and verified
on a ZTE ZXHN H3600 (two MT7915 radios on PCIe).

Assisted-by: LLM
Signed-off-by: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
---
 drivers/net/ethernet/zte/Kconfig          |   5 +-
 drivers/net/ethernet/zte/Makefile         |   3 +-
 drivers/net/ethernet/zte/zx279128s-eth.h  | 123 +++-
 drivers/net/ethernet/zte/zx279128s-main.c |  18 +-
 drivers/net/ethernet/zte/zx279128s-wlan.c | 837 ++++++++++++++++++++++
 5 files changed, 982 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/zte/zx279128s-wlan.c

diff --git a/drivers/net/ethernet/zte/Kconfig b/drivers/net/ethernet/zte/Kconfig
index 20df75486f81..b9a4a8520fc7 100644
--- a/drivers/net/ethernet/zte/Kconfig
+++ b/drivers/net/ethernet/zte/Kconfig
@@ -22,12 +22,15 @@ config ZX279128S_ETH
 	depends on ARCH_ZTE || COMPILE_TEST
 	depends on OF
 	depends on BRIDGE=y || BRIDGE=n
+	depends on NETFILTER
 	select NET_SWITCHDEV
 	select PHYLINK
 	help
 	  This driver supports the five-port gigabit switch of the ZTE
 	  zx279128s SoC and the DMA engine that connects it to the CPU.
 	  Each switch port becomes its own network interface, such as the
-	  four LAN ports and the WAN port of the ZTE ZXHN H3600.
+	  four LAN ports and the WAN port of the ZTE ZXHN H3600.  Flows
+	  to and from the AP interfaces of the SoC's PCIe WLAN cards can
+	  be offloaded through the switch's WLAN DMA ring.
 
 endif # NET_VENDOR_ZTE
diff --git a/drivers/net/ethernet/zte/Makefile b/drivers/net/ethernet/zte/Makefile
index 09b4f6558d2f..88eddc43ae18 100644
--- a/drivers/net/ethernet/zte/Makefile
+++ b/drivers/net/ethernet/zte/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_DINGHAI) += dinghai/
 
 obj-$(CONFIG_ZX279128S_ETH) += zx279128s-eth.o
-zx279128s-eth-y := zx279128s-main.o zx279128s-ppe.o zx279128s-switch.o
+zx279128s-eth-y := zx279128s-main.o zx279128s-ppe.o zx279128s-switch.o \
+		   zx279128s-wlan.o
diff --git a/drivers/net/ethernet/zte/zx279128s-eth.h b/drivers/net/ethernet/zte/zx279128s-eth.h
index 6c6e187cce93..b5a547eade35 100644
--- a/drivers/net/ethernet/zte/zx279128s-eth.h
+++ b/drivers/net/ethernet/zte/zx279128s-eth.h
@@ -13,6 +13,7 @@
 #include <linux/if_ether.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/netfilter.h>
 #include <linux/notifier.h>
 #include <linux/phylink.h>
 #include <linux/rhashtable.h>
@@ -144,6 +145,58 @@
 #define ZX_DMA_TX_START		(ZX_DMA_BASE + 0x64)
 #define ZX_DMA_RX_QUEUE_CNT(q)	(ZX_DMA_BASE + 0x100 + ((q) * 4))
 
+/*
+ * WLAN DMA engine ("IDM" in the vendor code): one RX and one TX ring of
+ * 8-byte descriptors between the switch fabric and the CPU.  Bit 31 of a
+ * descriptor selects one of two fabric ports (6 and 7), and the 3-bit
+ * "ssid" one of eight stations behind each, so the fabric sees 16 WLAN
+ * logical ports (ZX_WLAN_PORT()) that the classifier can send flows to.
+ */
+#define ZX_WLAN_BASE		0x1c8000
+#define ZX_WLAN_CTRL		(ZX_WLAN_BASE + 0x00)
+#define  ZX_WLAN_CTRL_EN	GENMASK(19, 16)
+#define  ZX_WLAN_CTRL_MODE	GENMASK(27, 20)
+#define  ZX_WLAN_CTRL_MODE_VAL	0x20		/* vendor value */
+#define ZX_WLAN_TX_RING		(ZX_WLAN_BASE + 0x04)
+#define ZX_WLAN_RX_RING		(ZX_WLAN_BASE + 0x08)
+#define ZX_WLAN_RX_EN		(ZX_WLAN_BASE + 0x0c)
+#define  ZX_WLAN_RX_EN_VAL	0x04000800	/* vendor value */
+#define ZX_WLAN_REG10		(ZX_WLAN_BASE + 0x10)	/* vendor value 0x40 */
+#define ZX_WLAN_REG18		(ZX_WLAN_BASE + 0x18)	/* vendor value 0x40 */
+#define ZX_WLAN_TIMEOUT		(ZX_WLAN_BASE + 0x1c)	/* vendor value 5000 */
+#define ZX_WLAN_INT_STATUS	(ZX_WLAN_BASE + 0x20)
+#define ZX_WLAN_INT_MASK	(ZX_WLAN_BASE + 0x24)	/* 1: masked */
+#define  ZX_WLAN_INT_RX		BIT(2)
+#define  ZX_WLAN_INT_TX		BIT(4)
+#define  ZX_WLAN_INT_ALL	GENMASK(4, 0)
+#define ZX_WLAN_TX_KICK		(ZX_WLAN_BASE + 0x40)
+#define  ZX_WLAN_KICK_NEW	GENMASK(31, 16)	/* descriptors added */
+#define  ZX_WLAN_KICK_DONE	GENMASK(15, 0)	/* descriptors consumed */
+#define ZX_WLAN_TX_DONE		(ZX_WLAN_BASE + 0x44)	/* sent, not acked */
+#define ZX_WLAN_RX_KICK		(ZX_WLAN_BASE + 0x48)
+#define ZX_WLAN_RX_PENDING	(ZX_WLAN_BASE + 0x4c)
+#define ZX_WLAN_REGC0		(ZX_WLAN_BASE + 0xc0)
+
+#define ZX_WLAN_RX_DESC		2048
+#define ZX_WLAN_TX_DESC		1024
+#define ZX_WLAN_RX_BUF		1732	/* vendor buffer size */
+#define ZX_WLAN_RX_HEADROOM	32
+#define ZX_WLAN_TX_LIMIT	512
+#define ZX_WLAN_TX_RECLAIM	256	/* per reclaim, as the vendor code */
+/* Descriptor word 1 */
+#define ZX_WLAN_RX_LEN		GENMASK(13, 0)
+#define ZX_WLAN_RX_SSID		GENMASK(18, 16)
+#define ZX_WLAN_RX_SSID_VALID	BIT(19)
+#define ZX_WLAN_TX_LEN		GENMASK(20, 0)
+#define ZX_WLAN_TX_SSID		GENMASK(30, 28)
+#define ZX_WLAN_DESC_PORT	BIT(31)		/* fabric port 7, else 6 */
+
+#define ZX_WLAN_PORTS		16
+/* The WLAN logical port of slot @i as the classifier and the fabric know it */
+#define ZX_WLAN_PORT(i)		(0x10 | (i))
+#define ZX_WLAN_PORT_IDM(i)	((i) >> 3)
+#define ZX_WLAN_PORT_SSID(i)	((i) & 7)
+
 /* Packet processor */
 #define ZX_PP_RESET		0x380000
 
@@ -203,7 +256,7 @@
 /* Word 0 of a classifier hash entry */
 #define ZX_CLA_W0_FLOW		GENMASK(31, 25)	/* packet modifier rewrite index */
 #define ZX_CLA_W0_FWD		BIT(24)		/* forward to the egress port */
-#define ZX_CLA_W0_EGRESS	GENMASK(15, 12)	/* bridge port, ZX_BRPORT() */
+#define ZX_CLA_W0_EGRESS	GENMASK(23, 12)	/* ZX_BRPORT() or ZX_WLAN_PORT() */
 #define ZX_CLA_W0_BITS		0x44		/* as in every stock entry */
 
 /* Bridge ports: 0 is the PON side, 1-5 are the switch ports 0-4 */
@@ -245,6 +298,8 @@
 #define ZX_RX_QUEUES		8
 #define ZX_DMA_TX_DONE		(ZX_DMA_BASE + 0x68)
 
+struct dentry;
+struct platform_device;
 struct zx_eth_adapter;
 
 /* One net_device per switch port: ports 0-3 LAN, port 4 WAN */
@@ -281,11 +336,62 @@ struct zx_eth_priv {
 	u32			mib_last[ZX_MIB_NUM];	/* last register values */
 };
 
+/* A WLAN logical port: a mac80211 AP interface bound to one of the 16 slots */
+struct zx_wlan_port {
+	struct zx_wlan		*wlan;
+	u8			slot;
+	struct net_device	*vif;		/* held while bound */
+	struct nf_hook_ops	hook;		/* ingress hook injecting UP frames */
+	bool			hooked;
+	u32			tx_injected;
+	u32			rx_delivered;
+	u32			trap_delivered;
+};
+
+/* The WLAN DMA engine and the logical ports (zx279128s-wlan.c) */
+struct zx_wlan {
+	struct zx_eth_adapter	*adapter;
+	int			irq;
+	struct napi_struct	napi;
+	struct notifier_block	netdev_nb;
+
+	void			*desc;		/* RX ring, then TX ring */
+	dma_addr_t		desc_dma;
+	struct sk_buff		*rx_skb[ZX_WLAN_RX_DESC];
+	struct sk_buff		*tx_skb[ZX_WLAN_TX_DESC];
+	u32			rx_idx;
+	/* TX ring producer/consumer state and tx_skb[] */
+	spinlock_t		tx_lock;
+	u32			tx_idx;
+	u32			tx_done;
+	u32			tx_pending;
+
+	struct zx_wlan_port	ports[ZX_WLAN_PORTS];
+	/* pre-NAT flow keys the ingress hooks inject (index = PPE flow) */
+	u32			flow_key[ZX_PPE_FLOWS];
+	u8			flow_port[ZX_PPE_FLOWS];
+	u32			flow_count;
+	bool			inject_all;	/* debug: inject every frame */
+
+	u32			rx_count;
+	u32			rx_nossid;	/* no station id: dropped */
+	u32			rx_nobind;	/* no interface bound: dropped */
+	u32			rx_bad;
+	u32			tx_busy;
+	u32			tx_count;
+	u32			trap_count;
+	u32			trap_nobind;
+	u32			trap_noparse;
+	u32			inj_gso;
+	u32			inj_gso_fail;
+};
+
 struct zx_eth_adapter {
 	struct device		*dev;
 	void __iomem		*base;
 	struct napi_struct	napi;
 	struct hrtimer		tx_timer;
+	struct zx_wlan		*wlan;		/* NULL without the WLAN interrupt */
 
 	struct net_device	*ports[ZX_NUM_PORTS];
 	int			open_count;
@@ -383,4 +489,19 @@ void zx_sw_fini(struct zx_eth_adapter *adapter);
 void zx_sw_work(struct work_struct *work);
 void zx_sw_port_down(struct zx_eth_adapter *adapter, int port);
 
+/* zx279128s-wlan.c */
+int zx_wlan_init(struct zx_eth_adapter *adapter, struct platform_device *pdev);
+void zx_wlan_fini(struct zx_eth_adapter *adapter);
+void zx_wlan_trap_rx(struct zx_eth_adapter *adapter, int slot, const u8 *buf,
+		     unsigned int len);
+int zx_wlan_port_of_egress(struct zx_eth_adapter *adapter,
+			   struct net_device *dev, const u8 *dmac);
+int zx_wlan_port_of_ingress(struct zx_eth_adapter *adapter, int ifindex,
+			    __be32 saddr);
+u32 zx_wlan_flow_key(u8 proto, __be32 saddr, __be32 daddr, __be16 sport,
+		     __be16 dport);
+void zx_wlan_flow_set(struct zx_eth_adapter *adapter, int flow, u32 key,
+		      int slot);
+void zx_wlan_debugfs_init(struct zx_eth_adapter *adapter, struct dentry *dir);
+
 #endif
diff --git a/drivers/net/ethernet/zte/zx279128s-main.c b/drivers/net/ethernet/zte/zx279128s-main.c
index 45a0dc13639e..a0dcb4d7011a 100644
--- a/drivers/net/ethernet/zte/zx279128s-main.c
+++ b/drivers/net/ethernet/zte/zx279128s-main.c
@@ -804,7 +804,17 @@ static int zx_eth_rx(struct zx_eth_adapter *adapter, int budget)
 			/* Deliver to the netdev of the ingress port */
 			dest_dev = port < ZX_NUM_PORTS ? adapter->ports[port] : NULL;
 
-			skb = napi_alloc_skb(&adapter->napi, len);
+			/* A frame injected for a WLAN logical port (ingress
+			 * 0x10-0x1f) that the classifier did not forward.
+			 */
+			if (port >= 15) {
+				zx_wlan_trap_rx(adapter, port - 15,
+						adapter->buffer_pool +
+						bp * ZX_BUF_SIZE + 16, len);
+				skb = NULL;
+			} else {
+				skb = napi_alloc_skb(&adapter->napi, len);
+			}
 			if (skb && dest_dev && (dest_dev->flags & IFF_UP)) {
 				dma_rmb();
 				memcpy(skb_put(skb, len), adapter->buffer_pool +
@@ -1197,6 +1207,7 @@ static void zx_eth_debugfs_init(struct zx_eth_adapter *adapter)
 
 	debugfs_create_devm_seqfile(adapter->dev, "dma_state", dir,
 				    zx_eth_dma_state_show);
+	zx_wlan_debugfs_init(adapter, dir);
 }
 
 static int zx_eth_probe(struct platform_device *pdev)
@@ -1419,6 +1430,10 @@ static int zx_eth_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, adapter);
 
+	ret = zx_wlan_init(adapter, pdev);
+	if (ret)
+		dev_warn(dev, "no WLAN offload: %d\n", ret);
+
 	zx_sw_init(adapter);
 	schedule_delayed_work(&adapter->mib_work, ZX_MIB_INTERVAL);
 
@@ -1465,6 +1480,7 @@ static void zx_eth_shutdown(struct platform_device *pdev)
 		return;
 
 	zx_sw_fini(adapter);
+	zx_wlan_fini(adapter);
 
 	rtnl_lock();
 	for (i = 0; i < ZX_NUM_PORTS; i++) {
diff --git a/drivers/net/ethernet/zte/zx279128s-wlan.c b/drivers/net/ethernet/zte/zx279128s-wlan.c
new file mode 100644
index 000000000000..17ba32bd993a
--- /dev/null
+++ b/drivers/net/ethernet/zte/zx279128s-wlan.c
@@ -0,0 +1,837 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE zx279128s Ethernet switch: WLAN DMA ring and logical ports
+ *
+ * Copyright (C) 2026 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ip.h>
+#include <linux/jhash.h>
+#include <linux/netfilter.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <net/arp.h>
+#include <net/cfg80211.h>
+#include <net/checksum.h>
+#include <net/gso.h>
+#include <net/ip.h>
+#include <net/neighbour.h>
+#include <net/netfilter/nf_flow_table.h>
+
+#include "zx279128s-eth.h"
+
+/*
+ * The switch fabric has a second DMA engine besides the one that serves the
+ * switch ports: a ring pair the vendor firmware uses for its WLAN drivers.
+ * A frame written to its TX ring enters the fabric on port 6 or 7 (bit 31
+ * of the descriptor) as if it came from the station the 3-bit "ssid" names,
+ * and a classifier entry whose egress is such a WLAN logical port makes the
+ * fabric write the frame, rewritten, to the RX ring with that ssid.
+ *
+ * This file uses it to offload flows to and from mac80211 AP interfaces of
+ * the PCIe WLAN cards:
+ * - a logical port is bound to an AP interface the first time a flow to or
+ *   from it is offloaded (zx279128s-ppe.c), and released when the interface
+ *   goes away;
+ * - frames the fabric forwards to a WLAN port (RX ring) are handed to the
+ *   bound interface for transmission;
+ * - frames received by a bound interface are taken off its ingress path and
+ *   injected into the TX ring when they belong to an offloaded flow, so the
+ *   fabric rewrites and forwards them without the CPU.  A frame the
+ *   classifier does not know comes back to the CPU on the switch RX ring
+ *   with the WLAN port as ingress, and is delivered as received by the
+ *   interface (zx_wlan_trap_rx()).
+ * The WLAN drivers are not involved: the interfaces' ordinary transmit and
+ * receive paths are used, so this works with any mac80211 driver.
+ */
+
+/* Mark an skb the driver injects or delivers, so the ingress hook can tell
+ * its own frames from new ones (the cb of a received skb is unused until the
+ * bridge or the protocol handler takes it).
+ */
+struct zx_wlan_cb {
+	u8	magic;
+	u8	slot;
+};
+
+#define ZX_WLAN_CB(skb)		((struct zx_wlan_cb *)&(skb)->cb[40])
+#define ZX_WLAN_CB_DELIVERED	0xa5	/* came back from the fabric */
+
+/* ---- descriptor rings ---------------------------------------------- */
+
+static __le32 *zx_wlan_rx_desc(struct zx_wlan *w, u32 idx)
+{
+	return (__le32 *)w->desc + idx * 2;
+}
+
+static __le32 *zx_wlan_tx_desc(struct zx_wlan *w, u32 idx)
+{
+	return (__le32 *)(w->desc + ZX_WLAN_RX_DESC * 8) + idx * 2;
+}
+
+static dma_addr_t zx_wlan_map_rx(struct zx_wlan *w, struct sk_buff *skb)
+{
+	return dma_map_single(w->adapter->dev, skb->data,
+			      ZX_WLAN_RX_BUF - ZX_WLAN_RX_HEADROOM,
+			      DMA_FROM_DEVICE);
+}
+
+static struct sk_buff *zx_wlan_alloc_rx(struct zx_wlan *w, dma_addr_t *dma,
+					gfp_t gfp)
+{
+	struct sk_buff *skb;
+
+	skb = __netdev_alloc_skb(w->napi.dev, ZX_WLAN_RX_BUF, gfp);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, ZX_WLAN_RX_HEADROOM);
+	*dma = zx_wlan_map_rx(w, skb);
+	if (dma_mapping_error(w->adapter->dev, *dma)) {
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+	return skb;
+}
+
+static void zx_wlan_free_rx(struct zx_wlan *w)
+{
+	int i;
+
+	for (i = 0; i < ZX_WLAN_RX_DESC; i++) {
+		__le32 *d = zx_wlan_rx_desc(w, i);
+
+		if (!w->rx_skb[i])
+			continue;
+		dma_unmap_single(w->adapter->dev, le32_to_cpu(d[0]),
+				 ZX_WLAN_RX_BUF - ZX_WLAN_RX_HEADROOM,
+				 DMA_FROM_DEVICE);
+		dev_kfree_skb(w->rx_skb[i]);
+		w->rx_skb[i] = NULL;
+	}
+}
+
+static void zx_wlan_free_tx(struct zx_wlan *w)
+{
+	int i;
+
+	for (i = 0; i < ZX_WLAN_TX_DESC; i++) {
+		__le32 *d = zx_wlan_tx_desc(w, i);
+
+		if (!w->tx_skb[i])
+			continue;
+		dma_unmap_single(w->adapter->dev, le32_to_cpu(d[0]),
+				 w->tx_skb[i]->len, DMA_TO_DEVICE);
+		dev_kfree_skb(w->tx_skb[i]);
+		w->tx_skb[i] = NULL;
+	}
+}
+
+/* The register sequence of the vendor driver's WLAN DMA initialisation */
+static int zx_wlan_hw_init(struct zx_wlan *w)
+{
+	void __iomem *base = w->adapter->base;
+	dma_addr_t dma;
+	u32 val;
+	int i;
+
+	writel(ZX_WLAN_INT_ALL, base + ZX_WLAN_INT_MASK);
+	writel(0x40, base + ZX_WLAN_REG18);
+	writel(5000, base + ZX_WLAN_TIMEOUT);
+	writel(0x40, base + ZX_WLAN_REG10);
+	val = readl(base + ZX_WLAN_CTRL) | ZX_WLAN_CTRL_EN;
+	writel(val, base + ZX_WLAN_CTRL);
+	val &= ~ZX_WLAN_CTRL_MODE;
+	val |= FIELD_PREP(ZX_WLAN_CTRL_MODE, ZX_WLAN_CTRL_MODE_VAL);
+	writel(val, base + ZX_WLAN_CTRL);
+	writel(0, base + ZX_WLAN_REGC0);
+	writel(w->desc_dma + ZX_WLAN_RX_DESC * 8, base + ZX_WLAN_TX_RING);
+	writel(w->desc_dma, base + ZX_WLAN_RX_RING);
+
+	for (i = 0; i < ZX_WLAN_RX_DESC; i++) {
+		__le32 *d = zx_wlan_rx_desc(w, i);
+
+		w->rx_skb[i] = zx_wlan_alloc_rx(w, &dma, GFP_KERNEL);
+		if (!w->rx_skb[i])
+			return -ENOMEM;
+		d[0] = cpu_to_le32(dma);
+		d[1] = 0;
+	}
+	dma_wmb();
+	/* one refill per slot, as the vendor driver */
+	for (i = 0; i < ZX_WLAN_RX_DESC; i++)
+		writel(FIELD_PREP(ZX_WLAN_KICK_NEW, 1), base + ZX_WLAN_RX_KICK);
+	writel(ZX_WLAN_RX_EN_VAL, base + ZX_WLAN_RX_EN);
+	return 0;
+}
+
+static void zx_wlan_hw_stop(struct zx_wlan *w)
+{
+	void __iomem *base = w->adapter->base;
+
+	writel(ZX_WLAN_INT_ALL, base + ZX_WLAN_INT_MASK);
+	writel(0, base + ZX_WLAN_RX_EN);
+	writel(readl(base + ZX_WLAN_CTRL) & ~ZX_WLAN_CTRL_EN, base + ZX_WLAN_CTRL);
+}
+
+/* ---- TX: inject a frame into the fabric ---------------------------- */
+
+static void zx_wlan_tx_reclaim(struct zx_wlan *w)
+{
+	void __iomem *base = w->adapter->base;
+	u32 done, i;
+
+	spin_lock_bh(&w->tx_lock);
+	done = FIELD_GET(ZX_WLAN_KICK_DONE, readl(base + ZX_WLAN_TX_DONE));
+	done = min3(done, w->tx_pending, (u32)ZX_WLAN_TX_RECLAIM);
+	for (i = 0; i < done; i++) {
+		u32 idx = w->tx_done;
+		struct sk_buff *skb = w->tx_skb[idx];
+
+		w->tx_done = (idx + 1) % ZX_WLAN_TX_DESC;
+		w->tx_skb[idx] = NULL;
+		if (!skb)
+			continue;
+		dma_unmap_single(w->adapter->dev,
+				 le32_to_cpu(zx_wlan_tx_desc(w, idx)[0]),
+				 skb->len, DMA_TO_DEVICE);
+		dev_consume_skb_any(skb);
+	}
+	w->tx_pending -= done;
+	if (done)
+		writel(FIELD_PREP(ZX_WLAN_KICK_DONE, done), base + ZX_WLAN_TX_KICK);
+	spin_unlock_bh(&w->tx_lock);
+}
+
+/*
+ * Inject one linear, wire-sized frame (Ethernet header first) as if the
+ * station of @slot had sent it.  Takes ownership of the skb.
+ */
+static void zx_wlan_xmit(struct zx_wlan *w, int slot, struct sk_buff *skb)
+{
+	void __iomem *base = w->adapter->base;
+	dma_addr_t dma;
+	__le32 *d;
+	u32 idx;
+
+	/* the fabric wants at least 64 bytes, and reads skb->data verbatim */
+	if (skb_put_padto(skb, ETH_ZLEN + ETH_FCS_LEN))
+		return;
+	if (skb_is_nonlinear(skb) && skb_linearize(skb))
+		goto drop;
+
+	if (READ_ONCE(w->tx_pending) >= ZX_WLAN_TX_LIMIT) {
+		zx_wlan_tx_reclaim(w);
+		if (READ_ONCE(w->tx_pending) >= ZX_WLAN_TX_LIMIT) {
+			w->tx_busy++;
+			goto drop;
+		}
+	}
+	dma = dma_map_single(w->adapter->dev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(w->adapter->dev, dma))
+		goto drop;
+
+	spin_lock_bh(&w->tx_lock);
+	idx = w->tx_idx;
+	w->tx_idx = (idx + 1) % ZX_WLAN_TX_DESC;
+	d = zx_wlan_tx_desc(w, idx);
+	d[0] = cpu_to_le32(dma);
+	d[1] = cpu_to_le32(FIELD_PREP(ZX_WLAN_TX_LEN, skb->len) |
+			   FIELD_PREP(ZX_WLAN_TX_SSID, ZX_WLAN_PORT_SSID(slot)) |
+			   (ZX_WLAN_PORT_IDM(slot) ? ZX_WLAN_DESC_PORT : 0));
+	w->tx_skb[idx] = skb;
+	w->tx_pending++;
+	w->tx_count++;
+	w->ports[slot].tx_injected++;
+	dma_wmb();
+	writel(FIELD_PREP(ZX_WLAN_KICK_NEW, 1), base + ZX_WLAN_TX_KICK);
+	spin_unlock_bh(&w->tx_lock);
+	return;
+
+drop:
+	kfree_skb(skb);
+}
+
+/* ---- RX: frames the fabric forwarded to a WLAN port ---------------- */
+
+/*
+ * Hand a frame the fabric forwarded to the interface of its WLAN port.  The
+ * packet modifier decremented the TTL but the IPv4 header checksum is not
+ * repaired on this path (the MAC egress pipeline does that for the switch
+ * ports), so recompute it.  The frame is transmitted through the ordinary
+ * queueing path of the interface; mac80211 needs the network header to
+ * classify it into a traffic class, or the flow is spread over all of them.
+ */
+static void zx_wlan_rx_deliver(struct zx_wlan *w, int slot, struct sk_buff *skb)
+{
+	struct net_device *vif = READ_ONCE(w->ports[slot].vif);
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+
+	if (!vif || !netif_running(vif) || !netif_carrier_ok(vif)) {
+		w->rx_nobind++;
+		kfree_skb(skb);
+		return;
+	}
+	if (eth->h_proto == htons(ETH_P_IP) &&
+	    skb->len >= ETH_HLEN + sizeof(struct iphdr)) {
+		struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
+
+		iph->check = 0;
+		iph->check = ip_fast_csum(iph, iph->ihl);
+	}
+	skb->dev = vif;
+	skb_reset_mac_header(skb);
+	skb_set_network_header(skb, ETH_HLEN);
+	skb->protocol = eth_header_parse_protocol(skb);
+	w->ports[slot].rx_delivered++;
+	dev_queue_xmit(skb);
+}
+
+static int zx_wlan_rx(struct zx_wlan *w, int budget)
+{
+	void __iomem *base = w->adapter->base;
+	int done = 0;
+
+	while (done < budget) {
+		u32 pending = readl(base + ZX_WLAN_RX_PENDING) & 0xffff;
+		u32 n, take;
+
+		if (!pending)
+			break;
+		take = min_t(u32, pending, budget - done);
+		for (n = 0; n < take; n++) {
+			u32 idx = w->rx_idx;
+			__le32 *d = zx_wlan_rx_desc(w, idx);
+			struct sk_buff *skb = w->rx_skb[idx], *new_skb;
+			u32 word1 = le32_to_cpu(d[1]);
+			u32 len = FIELD_GET(ZX_WLAN_RX_LEN, word1);
+			dma_addr_t new_dma;
+			int slot;
+
+			w->rx_count++;
+			if (!len || len > ZX_WLAN_RX_BUF - ZX_WLAN_RX_HEADROOM) {
+				w->rx_bad++;
+				d[1] = 0;
+				goto next;
+			}
+			new_skb = zx_wlan_alloc_rx(w, &new_dma, GFP_ATOMIC);
+			if (!new_skb) {
+				w->rx_bad++;
+				d[1] = 0;
+				goto next;
+			}
+			dma_unmap_single(w->adapter->dev, le32_to_cpu(d[0]),
+					 ZX_WLAN_RX_BUF - ZX_WLAN_RX_HEADROOM,
+					 DMA_FROM_DEVICE);
+			d[0] = cpu_to_le32(new_dma);
+			d[1] = 0;
+			w->rx_skb[idx] = new_skb;
+			skb_put(skb, len);
+
+			if (!(word1 & ZX_WLAN_RX_SSID_VALID)) {
+				/* flooded by the bridge, not for a station */
+				w->rx_nossid++;
+				kfree_skb(skb);
+				goto next;
+			}
+			slot = FIELD_GET(ZX_WLAN_RX_SSID, word1);
+			if (word1 & ZX_WLAN_DESC_PORT)
+				slot |= 8;
+			zx_wlan_rx_deliver(w, slot, skb);
+next:
+			w->rx_idx = (idx + 1) % ZX_WLAN_RX_DESC;
+			done++;
+		}
+		/* consumed and refilled: the same count */
+		writel(FIELD_PREP(ZX_WLAN_KICK_NEW, n) | FIELD_PREP(ZX_WLAN_KICK_DONE, n),
+		       base + ZX_WLAN_RX_KICK);
+	}
+	return done;
+}
+
+static int zx_wlan_poll(struct napi_struct *napi, int budget)
+{
+	struct zx_wlan *w = container_of(napi, struct zx_wlan, napi);
+	int done;
+
+	zx_wlan_tx_reclaim(w);
+	done = zx_wlan_rx(w, budget);
+	if (done < budget && napi_complete_done(napi, done))
+		writel(readl(w->adapter->base + ZX_WLAN_INT_MASK) &
+		       ~(ZX_WLAN_INT_RX | ZX_WLAN_INT_TX),
+		       w->adapter->base + ZX_WLAN_INT_MASK);
+	return done;
+}
+
+static irqreturn_t zx_wlan_isr(int irq, void *dev_id)
+{
+	struct zx_wlan *w = dev_id;
+	void __iomem *base = w->adapter->base;
+
+	if (!readl(base + ZX_WLAN_INT_STATUS))
+		return IRQ_NONE;
+	writel(readl(base + ZX_WLAN_INT_MASK) | ZX_WLAN_INT_RX | ZX_WLAN_INT_TX,
+	       base + ZX_WLAN_INT_MASK);
+	napi_schedule(&w->napi);
+	return IRQ_HANDLED;
+}
+
+/* ---- frames that missed the classifier --------------------------- */
+
+/*
+ * A frame injected for a WLAN port that the classifier did not forward
+ * comes back on the switch RX ring with the WLAN port as ingress.  It is
+ * delivered to the bound interface's receive path, as if the interface had
+ * just received it, and marked so that the ingress hook lets it pass.
+ * The frame usually starts at the same offset as a switch port's frame;
+ * the two other layouts seen on this path are probed by their ethertype.
+ */
+void zx_wlan_trap_rx(struct zx_eth_adapter *adapter, int slot, const u8 *buf,
+		     unsigned int len)
+{
+	static const u8 offsets[] = { 0, 2 };
+	struct zx_wlan *w = adapter->wlan;
+	struct net_device *vif;
+	struct sk_buff *skb;
+	unsigned int i, off = 0;
+	bool found = false;
+
+	if (!w || slot >= ZX_WLAN_PORTS)
+		return;
+	w->trap_count++;
+	vif = READ_ONCE(w->ports[slot].vif);
+	if (!vif || !netif_running(vif)) {
+		w->trap_nobind++;
+		return;
+	}
+	for (i = 0; i < ARRAY_SIZE(offsets) && !found; i++) {
+		__be16 proto;
+
+		off = offsets[i];
+		if (len < off + ETH_HLEN)
+			break;
+		proto = *(const __be16 *)(buf + off + 2 * ETH_ALEN);
+		found = eth_proto_is_802_3(proto);
+	}
+	if (!found) {
+		w->trap_noparse++;
+		return;
+	}
+	skb = netdev_alloc_skb(vif, len - off);
+	if (!skb)
+		return;
+	memcpy(skb_put(skb, len - off), buf + off, len - off);
+	ZX_WLAN_CB(skb)->magic = ZX_WLAN_CB_DELIVERED;
+	ZX_WLAN_CB(skb)->slot = slot;
+	skb->protocol = eth_type_trans(skb, vif);
+	w->ports[slot].trap_delivered++;
+	netif_rx(skb);
+}
+
+/* ---- ingress hook: inject the frames of offloaded flows ------------ */
+
+u32 zx_wlan_flow_key(u8 proto, __be32 saddr, __be32 daddr, __be16 sport,
+		     __be16 dport)
+{
+	return jhash_3words((__force u32)saddr, (__force u32)daddr,
+			    (__force u32)sport << 16 | (__force u32)dport,
+			    proto) ?: 1;
+}
+
+/* Remember (or forget, @key 0) the pre-NAT key of a flow the fabric holds
+ * for a WLAN ingress port; called with ppe_lock held.
+ */
+void zx_wlan_flow_set(struct zx_eth_adapter *adapter, int flow, u32 key,
+		      int slot)
+{
+	struct zx_wlan *w = adapter->wlan;
+
+	if (!w || flow < 0 || flow >= ZX_PPE_FLOWS)
+		return;
+	if (!!w->flow_key[flow] != !!key)
+		w->flow_count += key ? 1 : -1;
+	WRITE_ONCE(w->flow_key[flow], key);
+	w->flow_port[flow] = slot;
+}
+
+static bool zx_wlan_flow_held(struct zx_wlan *w, u32 key)
+{
+	int i;
+
+	for (i = 1; i < ZX_PPE_FLOWS; i++)
+		if (READ_ONCE(w->flow_key[i]) == key)
+			return true;
+	return false;
+}
+
+/*
+ * Runs on every frame a bound AP interface receives, after tc and before
+ * the bridge's rx_handler.  Frames of a flow the fabric holds for this port
+ * are injected into the fabric; everything else (control plane, bridged
+ * traffic, SYN/FIN/RST, flows on the software path) goes on to the stack.
+ * mac80211's GRO hands over superframes, which the fabric would drop as too
+ * long, so they are segmented to wire size first.
+ */
+static unsigned int zx_wlan_ingress_hook(void *priv, struct sk_buff *skb,
+					 const struct nf_hook_state *state)
+{
+	struct zx_wlan_port *port = priv;
+	struct zx_wlan *w = port->wlan;
+	int slot = port->slot;
+	const struct iphdr *iph;
+	__be16 sport, dport;
+	unsigned int thoff;
+
+	if (ZX_WLAN_CB(skb)->magic == ZX_WLAN_CB_DELIVERED)
+		return NF_ACCEPT;
+	if (!READ_ONCE(w->flow_count) && !READ_ONCE(w->inject_all))
+		return NF_ACCEPT;
+	if (skb->protocol != htons(ETH_P_IP) || !pskb_may_pull(skb, sizeof(*iph)))
+		return NF_ACCEPT;
+	iph = ip_hdr(skb);
+	if (iph->ihl < 5 || ip_is_fragment(iph) ||
+	    (iph->protocol != IPPROTO_TCP && iph->protocol != IPPROTO_UDP))
+		return NF_ACCEPT;
+	thoff = iph->ihl * 4;
+	if (iph->protocol == IPPROTO_TCP) {
+		const struct tcphdr *th;
+
+		if (!pskb_may_pull(skb, thoff + sizeof(*th)))
+			return NF_ACCEPT;
+		iph = ip_hdr(skb);
+		th = (const struct tcphdr *)((const u8 *)iph + thoff);
+		/* conntrack must see the connection open and close */
+		if (th->syn || th->fin || th->rst)
+			return NF_ACCEPT;
+		sport = th->source;
+		dport = th->dest;
+	} else {
+		const struct udphdr *uh;
+
+		if (!pskb_may_pull(skb, thoff + sizeof(*uh)))
+			return NF_ACCEPT;
+		iph = ip_hdr(skb);
+		uh = (const struct udphdr *)((const u8 *)iph + thoff);
+		sport = uh->source;
+		dport = uh->dest;
+	}
+	if (!READ_ONCE(w->inject_all) &&
+	    !zx_wlan_flow_held(w, zx_wlan_flow_key(iph->protocol, iph->saddr,
+						   iph->daddr, sport, dport)))
+		return NF_ACCEPT;
+
+	/* the fabric wants the frame from its Ethernet header */
+	if (!skb_mac_header_was_set(skb) ||
+	    skb_mac_header(skb) != skb->data - ETH_HLEN)
+		return NF_ACCEPT;
+	skb_push(skb, ETH_HLEN);
+
+	if (skb_is_gso(skb)) {
+		struct sk_buff *segs, *seg, *next;
+
+		w->inj_gso++;
+		skb->mac_len = ETH_HLEN;
+		segs = skb_gso_segment(skb, 0);
+		if (IS_ERR_OR_NULL(segs)) {
+			w->inj_gso_fail++;
+			skb_pull(skb, ETH_HLEN);
+			return NF_ACCEPT;
+		}
+		consume_skb(skb);
+		skb_list_walk_safe(segs, seg, next) {
+			skb_mark_not_on_list(seg);
+			zx_wlan_xmit(w, slot, seg);
+		}
+		return NF_STOLEN;
+	}
+	zx_wlan_xmit(w, slot, skb);
+	return NF_STOLEN;
+}
+
+/* ---- logical ports ------------------------------------------------- */
+
+static bool zx_wlan_is_ap(const struct net_device *dev)
+{
+	return dev && dev->ieee80211_ptr &&
+	       dev->ieee80211_ptr->iftype == NL80211_IFTYPE_AP;
+}
+
+/* Bind @vif to a free slot, or find its slot.  Called with ppe_lock held. */
+static int zx_wlan_port_get(struct zx_wlan *w, struct net_device *vif)
+{
+	struct zx_wlan_port *port;
+	int i, free = -1;
+
+	for (i = 0; i < ZX_WLAN_PORTS; i++) {
+		if (w->ports[i].vif == vif)
+			return i;
+		if (!w->ports[i].vif && free < 0)
+			free = i;
+	}
+	if (free < 0)
+		return -ENOSPC;
+	port = &w->ports[free];
+	memset(port, 0, sizeof(*port));
+	port->wlan = w;
+	port->slot = free;
+	port->hook.hook = zx_wlan_ingress_hook;
+	port->hook.priv = port;
+	port->hook.pf = NFPROTO_NETDEV;
+	port->hook.hooknum = NF_NETDEV_INGRESS;
+	port->hook.priority = INT_MIN + 1;	/* before the flowtable's */
+	port->hook.dev = vif;
+	port->hooked = !nf_register_net_hook(dev_net(vif), &port->hook);
+	if (!port->hooked)
+		netdev_warn(vif, "no ingress hook: flows from this interface stay in software\n");
+	dev_hold(vif);
+	WRITE_ONCE(port->vif, vif);
+	dev_dbg(w->adapter->dev, "%s bound to WLAN port %#x\n", vif->name,
+		ZX_WLAN_PORT(free));
+	return free;
+}
+
+static void zx_wlan_port_put(struct zx_wlan *w, int slot)
+{
+	struct zx_wlan_port *port = &w->ports[slot];
+	struct net_device *vif = port->vif;
+	int i;
+
+	if (!vif)
+		return;
+	WRITE_ONCE(port->vif, NULL);
+	for (i = 1; i < ZX_PPE_FLOWS; i++)
+		if (w->flow_key[i] && w->flow_port[i] == slot)
+			zx_wlan_flow_set(w->adapter, i, 0, 0);
+	if (port->hooked)
+		nf_unregister_net_hook(dev_net(vif), &port->hook);
+	/* no RX dispatch or hook still uses the interface */
+	synchronize_net();
+	port->hooked = false;
+	dev_put(vif);
+}
+
+/* The AP interface behind a bridge's forwarding path for @dmac, or @dev */
+static struct net_device *zx_wlan_bridge_port(struct net_device *dev,
+					      const u8 *dmac)
+{
+	struct net_device_path_ctx ctx = { .dev = dev };
+	struct net_device_path path = {};
+
+	if (!netif_is_bridge_master(dev) ||
+	    !dev->netdev_ops->ndo_fill_forward_path)
+		return dev;
+	memcpy(ctx.daddr, dmac, ETH_ALEN);
+	if (dev->netdev_ops->ndo_fill_forward_path(&ctx, &path) || !ctx.dev)
+		return dev;
+	/* a port of the bridge, which the caller only reads under RCU */
+	return (struct net_device *)ctx.dev;
+}
+
+/*
+ * The WLAN port of a flow's egress: @dev is the AP interface, or a bridge
+ * the flowtable stopped at because mac80211 fills no forwarding path, in
+ * which case the port the next hop MAC was learned on is the interface.
+ * Returns the slot, or -ENODEV when the egress is not an AP interface.
+ */
+int zx_wlan_port_of_egress(struct zx_eth_adapter *adapter,
+			   struct net_device *dev, const u8 *dmac)
+{
+	struct net_device *vif;
+
+	if (!adapter->wlan || !dev)
+		return -ENODEV;
+	rcu_read_lock();
+	vif = zx_wlan_bridge_port(dev, dmac);
+	if (!zx_wlan_is_ap(vif))
+		vif = NULL;
+	rcu_read_unlock();
+	if (!vif)
+		return -ENODEV;
+	return zx_wlan_port_get(adapter->wlan, vif);
+}
+
+/*
+ * The WLAN port of a flow's ingress: @ifindex is the AP interface, or the
+ * bridge it is a port of; then the station's address (@saddr, the flow's
+ * pre-NAT source) leads through the bridge's neighbour entry and forwarding
+ * database to the interface.
+ */
+int zx_wlan_port_of_ingress(struct zx_eth_adapter *adapter, int ifindex,
+			    __be32 saddr)
+{
+	struct net_device *dev, *vif = NULL;
+
+	if (!adapter->wlan || !ifindex)
+		return -ENODEV;
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(dev_net(adapter->wlan->napi.dev), ifindex);
+	if (dev && netif_is_bridge_master(dev) && saddr) {
+		struct neighbour *n = neigh_lookup(arp_table(dev_net(dev)),
+						   &saddr, dev);
+
+		if (n) {
+			if (READ_ONCE(n->nud_state) & NUD_VALID) {
+				u8 mac[ETH_ALEN];
+
+				neigh_ha_snapshot(mac, n, dev);
+				vif = zx_wlan_bridge_port(dev, mac);
+			}
+			neigh_release(n);
+		}
+	} else {
+		vif = dev;
+	}
+	if (!zx_wlan_is_ap(vif))
+		vif = NULL;
+	rcu_read_unlock();
+	if (!vif)
+		return -ENODEV;
+	return zx_wlan_port_get(adapter->wlan, vif);
+}
+
+static int zx_wlan_netdev_event(struct notifier_block *nb, unsigned long event,
+				void *ptr)
+{
+	struct zx_wlan *w = container_of(nb, struct zx_wlan, netdev_nb);
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	int i;
+
+	if (event != NETDEV_UNREGISTER || !zx_wlan_is_ap(dev))
+		return NOTIFY_DONE;
+	mutex_lock(&w->adapter->ppe_lock);
+	for (i = 0; i < ZX_WLAN_PORTS; i++)
+		if (w->ports[i].vif == dev)
+			zx_wlan_port_put(w, i);
+	mutex_unlock(&w->adapter->ppe_lock);
+	return NOTIFY_DONE;
+}
+
+/* ---- debugfs ------------------------------------------------------- */
+
+static int zx_wlan_state_show(struct seq_file *s, void *data)
+{
+	struct zx_eth_adapter *adapter = dev_get_drvdata(s->private);
+	struct zx_wlan *w = adapter->wlan;
+	int i;
+
+	if (!w)
+		return 0;
+	seq_printf(s, "rx=%u rx_nossid=%u rx_nobind=%u rx_bad=%u tx=%u tx_busy=%u tx_pending=%u\n",
+		   w->rx_count, w->rx_nossid, w->rx_nobind, w->rx_bad,
+		   w->tx_count, w->tx_busy, w->tx_pending);
+	seq_printf(s, "trap=%u trap_nobind=%u trap_noparse=%u gso=%u gso_fail=%u flows=%u inject_all=%u\n",
+		   w->trap_count, w->trap_nobind, w->trap_noparse, w->inj_gso,
+		   w->inj_gso_fail, w->flow_count, w->inject_all);
+	seq_printf(s, "ctrl=%08x int_status=%08x int_mask=%08x rx_pending=%08x\n",
+		   readl(adapter->base + ZX_WLAN_CTRL),
+		   readl(adapter->base + ZX_WLAN_INT_STATUS),
+		   readl(adapter->base + ZX_WLAN_INT_MASK),
+		   readl(adapter->base + ZX_WLAN_RX_PENDING));
+	for (i = 0; i < ZX_WLAN_PORTS; i++) {
+		struct net_device *vif = READ_ONCE(w->ports[i].vif);
+
+		if (!vif)
+			continue;
+		seq_printf(s, "port %#x %s hook=%u injected=%u delivered=%u trapped=%u\n",
+			   ZX_WLAN_PORT(i), vif->name, w->ports[i].hooked,
+			   w->ports[i].tx_injected, w->ports[i].rx_delivered,
+			   w->ports[i].trap_delivered);
+	}
+	return 0;
+}
+
+void zx_wlan_debugfs_init(struct zx_eth_adapter *adapter, struct dentry *dir)
+{
+	if (!adapter->wlan)
+		return;
+	debugfs_create_devm_seqfile(adapter->dev, "wlan_state", dir,
+				    zx_wlan_state_show);
+	debugfs_create_bool("wlan_inject_all", 0600, dir,
+			    &adapter->wlan->inject_all);
+}
+
+/* ---- init / fini --------------------------------------------------- */
+
+/* Called at the end of probe, with the port netdevs registered */
+int zx_wlan_init(struct zx_eth_adapter *adapter, struct platform_device *pdev)
+{
+	struct device *dev = adapter->dev;
+	struct zx_wlan *w;
+	int i, irq, ret;
+
+	irq = platform_get_irq_byname_optional(pdev, "wlan");
+	if (irq < 0)
+		return irq == -ENXIO ? 0 : irq;
+	for (i = 0; i < ZX_NUM_PORTS && !adapter->ports[i]; i++)
+		;
+	if (i == ZX_NUM_PORTS)
+		return -ENODEV;
+
+	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+	w->adapter = adapter;
+	w->irq = irq;
+	spin_lock_init(&w->tx_lock);
+	w->desc = dmam_alloc_coherent(dev, (ZX_WLAN_RX_DESC + ZX_WLAN_TX_DESC) * 8,
+				      &w->desc_dma, GFP_KERNEL);
+	if (!w->desc)
+		return -ENOMEM;
+
+	netif_napi_add(adapter->ports[i], &w->napi, zx_wlan_poll);
+	ret = zx_wlan_hw_init(w);
+	if (ret)
+		goto err_rx;
+	ret = devm_request_irq(dev, irq, zx_wlan_isr, 0, "zx279128s-wlan", w);
+	if (ret)
+		goto err_rx;
+	w->netdev_nb.notifier_call = zx_wlan_netdev_event;
+	ret = register_netdevice_notifier(&w->netdev_nb);
+	if (ret)
+		goto err_rx;
+
+	adapter->wlan = w;
+	/* the ring runs from now on: offloaded flows do not wait for a port */
+	napi_enable(&w->napi);
+	writel(readl(adapter->base + ZX_WLAN_INT_MASK) &
+	       ~(ZX_WLAN_INT_RX | ZX_WLAN_INT_TX),
+	       adapter->base + ZX_WLAN_INT_MASK);
+	dev_info(dev, "WLAN offload ring on IRQ %d\n", irq);
+	return 0;
+
+err_rx:
+	zx_wlan_hw_stop(w);
+	zx_wlan_free_rx(w);
+	netif_napi_del(&w->napi);
+	return ret;
+}
+
+void zx_wlan_fini(struct zx_eth_adapter *adapter)
+{
+	struct zx_wlan *w = adapter->wlan;
+	int i;
+
+	if (!w)
+		return;
+	unregister_netdevice_notifier(&w->netdev_nb);
+	mutex_lock(&adapter->ppe_lock);
+	for (i = 0; i < ZX_WLAN_PORTS; i++)
+		zx_wlan_port_put(w, i);
+	mutex_unlock(&adapter->ppe_lock);
+	zx_wlan_hw_stop(w);
+	synchronize_irq(w->irq);
+	napi_disable(&w->napi);
+	zx_wlan_hw_stop(w);
+	netif_napi_del(&w->napi);
+	zx_wlan_free_tx(w);
+	zx_wlan_free_rx(w);
+	adapter->wlan = NULL;
+}
-- 
2.30.2

