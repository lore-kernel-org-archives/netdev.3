Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348840;
	b=bc7Y7irTWG8kN5n3vXCccQKiu/SZboqs3idnkACQ01iYBy5vibYhrYaCor20fgWk6wlX
	 rS0x6hroy5TtsyfUxEJ+dSziEGI42125tYq/KuzaOt/LH9LVyNva4Y/qtPeD7xOlYNvLj
	 8o2hRHWcnn7GmK5U7qLK+/dALDBvzEWIkznbeqWFitoaE6UDznCAhWweGGkJKzNGfoHCn
	 Ig1tDO83hXaUDUzUg8loSJQTprX6d97lFxjoUMF+4ly8RrJp5e7D6ib3cgniKnAuXCKtg
	 Up+8+7zStf9rKIyW6H1/lDuz19BRiNN41fjfsgdR4SQr0hCn+ey6eSw4MS+kQ6FF03Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348840;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=aHT0oe+9666WqHA8sjUCxydzPLGhtXncbWuycSjH+/0=;
	b=DRcICQAAmY6T5TOAMusGZG15iTHR+gPQZnOSX57ffBD2kB3JmdQlA8fnuMy/ipsDwNO3
	 lxr6Jr+4qdQmu8+GguqFNxHNwB1i7lv9u6ZPgDAxWEnckXN857ognBasySj5kFQCNN6/y
	 D0w24LLJc9jMcCZXGuqxfO2cfH/W2Y7wMiq6sxvqy9X50T1KEdJNXeObV6QWI/hNZUMYk
	 vv2JhopRcfm0p4ChB+wa1NISQ5nXQM08/j+oXQdwd0OuJKqQct93OOfjOgvkNvjpi4HJ8
	 PTGkMsrH6rXT5tHJxCOPyV/RnJISq4/VR151n7vnsAwhD+IGfzCtbap9jq/8GvAOWMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvZUBnYW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA7606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvZUBnYW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B01F008A3;
	Tue, 10 Nov 2026 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348840;
	bh=aHT0oe+9666WqHA8sjUCxydzPLGhtXncbWuycSjH+/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AvZUBnYWeee4NBdzrPsn+bgzN5dxEbYaHHiwFjQqnmGjgTGfmxpL8XRmVp1jNfsLo
	 3hkVVTaKq/TGB2EMHLtS21vBSNvBOXm3ollmU7US75KfIdXwDveBsUD+FoUkDTb0mm
	 ES31TrH9EpvSHZWsT73uGXFhjcwU+m5kIDdAavHPA9aG4yugYyoYN+0NnPdi8A5Kih
	 lCPiWlf9q6H53vPTOSnVpKHG9Z0e7ua07LCrtH6E22mr+wKXz5Vcpy6cbXa8r0kZLW
	 Bs5mR+1AhmGC5nukEyHswG7dwk3Z3XXOCJgirP9jsOLzFeYhgZYrDc70mVtmr+Cf+n
	 QMXf/W9DDlM6g==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:28 +0100
Subject: [PATCH net-next v7 13/18] net: ethernet: cortina: Scale Gemini RX
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-13-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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
index d08dbb0aabcf..a96b6292820a 100644
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

