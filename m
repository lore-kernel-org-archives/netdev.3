Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490259;
	b=PUI66RK3ozEikhNzi26Zpx0uV+kRV0j6nPA6f52XcY5ZQFF8DQ+e8OLSewlx7Tvt75EE
	 BevI1oxuKTcTNE83lHVgtH0L/hBJD6y49E824Wxz0Lu+I19w3e3AmV9idRTl2st1J4Eh+
	 iDnzVqXUW/jtEn2QwmLKSfvq7xLxqEZBOL5cvxwzlIxginVs0tJG4uDY9Kvu2TJAch5MF
	 fxfnilQusx9B0z+nUTe5SPlS8jatnyu+LBMwBMbPiAWJ20zEKKsDFu3lxZqS+tWlhvgLL
	 YFvYM/SMz9HHwYvZwxg6GXjQAJajz9/Ydxw6/NX3pb41LOADEqwK4eLgkICObKu9nvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490259;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=SEdSQLvUWPqt+hzMMG2djvmCgziXmwgOFfcsBO/Oktc=;
	b=L6ZRt0AFZ+I1WVjLAB0J6qb4N+gBA/kJPUyzPr6V5ftWRtmRq1RvclorYVOe44bpDjZl
	 sUiXOY+bv2UyzsDMIV5DAyKSCOk3edDcRIM62SzMRgmh53WRVstTpFNAzzQZ6Rj60OcNU
	 YDbS2rb8+vf5BFFSrh5zQSAFPpLYGbn6rSOwRDXLGvnmdyaoVO2bmFQ2bdLXYdQTypFi4
	 wJYBRcyXDKAQUIV+CLD2BCVMiqFb+hRtHTDPbrMXjjfk5Ydx3n0PZ7LALyu3Awrw8nPvq
	 2DP0ib6mp5h2H7WKoV2JlUTNB2pwZyPRXq0C+S9BgQHsqpcFFobCczAhBaKya4ceGNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjCdGdLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71A60A2607
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjCdGdLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1B21F00A06;
	Thu, 12 Nov 2026 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490259;
	bh=SEdSQLvUWPqt+hzMMG2djvmCgziXmwgOFfcsBO/Oktc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UjCdGdLDyL+8PRBjHP+jPN5T2URPZNrzqUsP/SOwJoFvBPg9TpD4XcObTEnlK4+14
	 x6G2TDBMA0v3S5859FOk2xQNsbahO7kFLCPPliNDa8F+reg+entWMN29slBD70JwaY
	 MXf43Z1LlJA6gQakXYEwLfFWeCRIJo/dAu+Xm8VjJSMQAnvdhXSO7v+UYC+AsdSXX6
	 /3bmReT1TxXoyUXhFgBbDjoscSBcpCx2K7dj6mc1TzIE6xxFvJtOghSOjnuT6hiNZb
	 xPJA2SZiDjOtugncxr0P3ehwu2t1l84I7F0wCQhxFhufckl+1lMsccoKNn4/NgRWZR
	 yooSzQQtfF4Cg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:29 +0100
Subject: [PATCH net-next v8 14/19] net: ethernet: cortina: Scale Gemini RX
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-14-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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
index 0588e573f8da..5a87d88607cd 100644
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
@@ -509,6 +511,17 @@ static int gmac_pick_rx_max_len(unsigned int max_l3_len)
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
@@ -577,7 +590,7 @@ static int gmac_init(struct net_device *netdev)
 	writel(sw_weigh.bits32,
 	       port->dma_base + GMAC_TX_WEIGHTING_CTRL_1_REG);
 
-	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;
+	port->rxq_order = gmac_pick_rxq_order();
 	port->txq_order = DEFAULT_GMAC_TXQ_ORDER;
 	port->rx_coalesce_nsecs = DEFAULT_RX_COALESCE_NSECS;
 

-- 
2.56.0

