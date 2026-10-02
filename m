Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5534F85CB
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958320; cv=none; b=sm6UNIm36md+b2FtfKt+flWAMrrKkMMt8Z6NIJ+2xqYZePs0oIe78i6nDowSEie7UoLd/Roh8i9yTCx5y4/+OCOegPmMOfjcnkTKtfgxDiy0GFIPFlt7jCzSAFGD2797Mx/RkXbUd7N5rGlbPsuuOrB/SI/RZEKVh1e6l2JwVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958320; c=relaxed/simple;
	bh=YI1DY6zOpr9f9O1s3BaqU615QQd3nKT/nbVlbT0EWmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcUYjZcMB4rEBzYTtF/sY7lorkfv3sqEpws/qywYd1Mh+yMXGZ8i+U+MoHqQsmDRg+A8WaT1csq7Cwhj8ZVQyi1z94vMomSG3MS771PxWT7C+dTs7efdxxPYuKmM7DePQnH0Gjn5Prx/sme7gDALiGrZdEp57Nkf4SjjjwKfLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM2fQ0RB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM2fQ0RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626FB1F000FF;
	Fri,  2 Oct 2026 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958319;
	bh=Y549ZYlIDwfKblfqNz9/8+ubXHsjjVE7dhLZ8PVsaBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fM2fQ0RBI5mTa8aPF22BlFYr3+DrOH/YpU6tbVUw8xVzJYon2sgd+jjn6lalpBmK+
	 4I8g2VQug7wcJ3HccQAE4da/9+o04NEMb64dGiEEVXOVsHPFs7D5T1mQWOeUNoBOTD
	 DRP9sm9qDdqFqj6/YWZak9jY7BbpTENV6A0rm3ciCmpWWO49zzRX1oPm36M6e7sHPB
	 RANa4Ug1FXUFq7Or00aq992kM9arnhcYUd8IsHg+3N/Y0t7povl+UwyJHGvwR1EoOB
	 eYcqWKYhvL3yMNLvXr3DbBxihdNpaOad7XIEQlaJtf2IhNTJ1fVmQQBclI58W4T7jL
	 BRYsQFlmSkKow==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:51 +0200
Subject: [PATCH net-next v3 12/12] net: ethernet: cortina: Scale Gemini RX
 queues to system memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-12-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
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
index 2ebfbbe84eba..437f36b1738c 100644
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
@@ -35,6 +36,7 @@
 #include <linux/skbuff.h>
 #include <linux/phy.h>
 #include <linux/crc32.h>
+#include <linux/sizes.h>
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -471,6 +473,17 @@ static int gmac_pick_rx_max_len(unsigned int max_l3_len)
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
@@ -539,7 +552,7 @@ static int gmac_init(struct net_device *netdev)
 	writel(sw_weigh.bits32,
 	       port->dma_base + GMAC_TX_WEIGHTING_CTRL_1_REG);
 
-	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;
+	port->rxq_order = gmac_pick_rxq_order();
 	port->txq_order = DEFAULT_GMAC_TXQ_ORDER;
 	port->rx_coalesce_nsecs = DEFAULT_RX_COALESCE_NSECS;
 

-- 
2.55.0

