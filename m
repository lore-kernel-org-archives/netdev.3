Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728314;
	b=ZDVDBBFn73nRoAHGenNl9gE2CbyZHXZwS+4ytP7hqUrKzvkTrf7YxM2m5kayEBncpSMP
	 8Riz6PZg+XLqAXg3gqNNJXcAfo/sAG6hZ3mjy20vAY3ouIC3xzA88AXmwPYIz40e4JajH
	 FiFAyLmF/fVDwPCI6de/oJTyHur3QnU83HOSwPrnYiGaiv3uBbfz0drBJ4zlCnJwDoTF5
	 3bRHnwHZcCGOiQTK6tbUf/vsJ4iBVCj1Tv5EDm40JVFMfEq75OdBCuSdb4uqe7IvkIO0I
	 /LxgzkQcYaipNdzOlKhGn3aZkXLd98nRDdS5n5e8cuHcQOBqN2dyqquvQ5F50tPUgnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728314;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=6zygdu4+s+H8IHTAOxJX/6tUTRs5gkoVuBjqjt5zcl4=;
	b=Xya39MA17KpvqB7y+4JGVxsiP3KG9G2AnVOJ+QQOwM4wg9Q2JXT9oTxpZ12AI3UHpAWo
	 2wp20pMqz61PEWXUBkO5swvX8T2LtIK8/7YzNDdB3n+svt8lFnEhTcO6kpWkazeaPZg1u
	 lMPe0DhplYvsP/BNO8JP7hyng8TZ+XS6A6J0YIMFZx9+lS9aDX/SNQwNt9X7y1B2SepOl
	 r0j3yNSX8N8zS7txOM6vTslFaEyEQhY+NICn46O8S2pSMrFUbPeJyF9aO8FXfVyk/+OsF
	 hex7uUlWCjpNfukkx11/AcuLmWJnu/aLIqLTWUjo5Wp2B6tcYMnCX6LSmD2Svxmzv3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCJo+VSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE7606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCJo+VSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070031F00A02;
	Tue,  3 Nov 2026 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728313;
	bh=6zygdu4+s+H8IHTAOxJX/6tUTRs5gkoVuBjqjt5zcl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XCJo+VSJbruGormxbY2k6ZG+mpcW03oHatgJs+uSrE9y5/bA3dSqDwu3ihN/W+CgA
	 /WISEu+hEnh0/w6ulB47avvCXRGK8yhF3EauKiv652+0MGTlmC6NVr93vPFzU9yRBI
	 fFVVrorjc6JVvcZbAMMXb3uTGDpUDtSEjSBGcDU3+Xf76ZBaSvNjQyHk+prBoVzpyt
	 Lhh16anXyTaJjBqEP7cfMAimjnleotsFZHB2aytGuX1guQJUtbsMDElQ0WSyWBIE/8
	 w2fpGlRwWVew19+NSnmLjlNjZjRla8sztfU6K1mJzvkomdfoKcCbHAd5uX62XWdw4u
	 XSkxqYG6Gvrbw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:24 +0100
Subject: [PATCH net-next v6 13/15] net: ethernet: cortina: Scale Gemini RX
 queues to system memory
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-13-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The default RX queues contain 512 descriptors per port. The shared
software free queue is sized at twice their combined capacity, requiring
4 MiB of page fragments even on Gemini systems with only 32 or 64 MiB of
RAM.

Choose smaller default RX queues on memory-constrained systems. Use 256
descriptors per port and a 2 MiB free queue with at most 64 MiB of RAM,
and 128 descriptors per port with a 1 MiB free queue with at most 32 MiB.
Keep the existing defaults on systems with more memory.

This preserves the existing relationship between RX descriptor capacity
and the free queue. Users can still override the defaults with ethtool.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index be2b9702718f..5e89057bb2fb 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/bitmap.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/platform_device.h>
@@ -37,6 +38,7 @@
 #include <linux/skbuff.h>
 #include <linux/phy.h>
 #include <linux/crc32.h>
+#include <linux/sizes.h>
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -475,6 +477,17 @@ static int gmac_pick_rx_max_len(unsigned int max_l3_len)
 	return -1;
 }
 
+static unsigned int gmac_pick_rxq_order(void)
+{
+	if (totalram_pages() <= (SZ_32M >> PAGE_SHIFT))
+		return DEFAULT_GMAC_RXQ_ORDER - 2;
+
+	if (totalram_pages() <= (SZ_64M >> PAGE_SHIFT))
+		return DEFAULT_GMAC_RXQ_ORDER - 1;
+
+	return DEFAULT_GMAC_RXQ_ORDER;
+}
+
 static int gmac_init(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
@@ -543,7 +556,7 @@ static int gmac_init(struct net_device *netdev)
 	writel(sw_weigh.bits32,
 	       port->dma_base + GMAC_TX_WEIGHTING_CTRL_1_REG);
 
-	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;
+	port->rxq_order = gmac_pick_rxq_order();
 	port->txq_order = DEFAULT_GMAC_TXQ_ORDER;
 	port->rx_coalesce_nsecs = DEFAULT_RX_COALESCE_NSECS;
 

-- 
2.56.0

