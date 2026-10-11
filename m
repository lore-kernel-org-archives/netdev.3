Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80A439F8A
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742020; cv=none; b=Yh3GeQHCZTMZcpageelXwbQ/eyG7agjQUhGXX9/a07s5Xhn17t3c5AJek381lH3X/aKhoJcXaRdDhVafqujtxSikhMjTHpCrhfkszpK2uarMGia5IvDAmGY6dug0rIWVYSmLwtnXyhdeqyX4E4u2U6fh3n35v6yXoOTEtLU3AhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742020; c=relaxed/simple;
	bh=Pc572/R0IvjpgVDMuvW6H8WBWj0GqpfyYDmDNYJ+aBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSg3ZBMecPI9UPVadhiOMGjjQK1YeguPKEC2iL5+r6LZK40voWezHjmx3D4PE7XG7dK00ff2PWbz+YEnGWNmTSwTlBa2YxwMTjwsrkaN6gse/pICEkEtddNCztSj+kI0a2/JYJHOM7iQGTNyoPC6zjv8uQvhvAzIGvil2z+xXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN+fU5BH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN+fU5BH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083601F0089B;
	Sun, 11 Oct 2026 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742019;
	bh=hsQo05VuFs1kzg0cifpZusOqpFBHENGhh0/jxgYT8pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CN+fU5BHFagwefMS7rdE/eylsQNLBDAdQrsLil2UyEMCZD5TPFpJ/y4i8Coaw/c2N
	 LL7vMRTZ/z3APWGfWsPE9t09eDhey5Ec4ChpfWPbw7AlTKLf1HIcY5M4tYm9Da3Wwr
	 M4tUjuR9782c1lzAiiQXLQy4KU1jjFSk87fpotsezmvRhg95twl01WDDP4+w0eU7Mb
	 RNmy/7dzy6xKel9HmQavk0LpiYgMPREV3GNAuVzLi+0pSOdbD/VUVcNESddgK6mW5H
	 z/z/mMQn79XSteyAQuobMdYTHnVlCxrshGjSGSeCCqVHa6vR1iJGRFpYsvqJGZjCps
	 aO351LKAfk2bA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:27 +0200
Subject: [PATCH net-next v4 14/15] net: ethernet: cortina: Scale Gemini RX
 queues to system memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-14-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
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

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 32291d4c3390..a61bace61ea4 100644
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
@@ -36,6 +37,7 @@
 #include <linux/skbuff.h>
 #include <linux/phy.h>
 #include <linux/crc32.h>
+#include <linux/sizes.h>
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -474,6 +476,17 @@ static int gmac_pick_rx_max_len(unsigned int max_l3_len)
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
@@ -542,7 +555,7 @@ static int gmac_init(struct net_device *netdev)
 	writel(sw_weigh.bits32,
 	       port->dma_base + GMAC_TX_WEIGHTING_CTRL_1_REG);
 
-	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;
+	port->rxq_order = gmac_pick_rxq_order();
 	port->txq_order = DEFAULT_GMAC_TXQ_ORDER;
 	port->rx_coalesce_nsecs = DEFAULT_RX_COALESCE_NSECS;
 

-- 
2.56.0

