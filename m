Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53342C50B
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937351; cv=none; b=XyXkqQt4YnqCjRbTf8hkpYzFHVdd78dOLJYYYc/J0FQOGed9CXtPF9/iTABCRwY4kTLa1QFeaNr45sei5xdIM99Q766lb6tEL+XcLzBFAUvuxHZFalLoD0djwXFMqcyfoBu+nvKBonJvePuxVRyWO7l2VquSnGwKT4lP0JGXkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937351; c=relaxed/simple;
	bh=L7HwIh7fN0T8x7foQmGd0BHd6R82TZ8zUOMUBYesKJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDgtxqmbt0J4RcTniwwQvvdF1lpAlcrSBta1uqoH0NbQ2BZBidq2QoWRLvEo+SRC+liIQQsyTJ7bNhimgpphrQZdqiG24xv6+sxcciNDz1eAkJYkxNKjicb1wCd8S8XnY5VHfVugSxTTH1YnaBLxj/sg2as6gniEiw0OPDSBWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ1Xe7LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ1Xe7LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC0D1F00893;
	Sun, 20 Sep 2026 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789937350;
	bh=pa/1wo2m1hnzXYCaPyDlg6GU8Sd/RANQXNnu8VRITrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VJ1Xe7LOjorzG+nVrBgMuIgEkfH5VyCO2zK+h+zmH7ECw9Z5wy/3RNCckbkdcJzfd
	 MmEB1koiq6UoQ/StsGt2kHFH7ht9yzwsfV3uzDS5PDZr0KHHNU39W2yfSjNT4T98FO
	 75ksDj/gIrZqtvI+SK/0U8Zfor4crLDe3tJl1YRZTZMV47l/UIq/nF9Kn6/V4ObqzX
	 QZT7uC6aQghXwF9mML+TRRWRI13/MMkQUPspjLg04T5n32ynqDhJgpeQPtpW2JX5Lv
	 Qz0gxzi+xouu776V7Umw6/e7gPP+tRNqs4yNuMYmfdlf2sY9xDPocwCRf1i/95FLNm
	 p4/rvWpbMyzYA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 20 Sep 2026 22:48:53 +0200
Subject: [PATCH net-next 3/3] net: ethernet: cortina: Scale Gemini RX
 queues to system memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-gemini-ethernet-fixes-3-v1-3-3a2a50a83d89@kernel.org>
References: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
In-Reply-To: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
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
index 6d5f7dacf12a..a14209ec2fe6 100644
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
@@ -472,6 +474,17 @@ static int gmac_pick_rx_max_len(unsigned int max_l3_len)
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
@@ -540,7 +553,7 @@ static int gmac_init(struct net_device *netdev)
 	writel(sw_weigh.bits32,
 	       port->dma_base + GMAC_TX_WEIGHTING_CTRL_1_REG);
 
-	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;
+	port->rxq_order = gmac_pick_rxq_order();
 	port->txq_order = DEFAULT_GMAC_TXQ_ORDER;
 	port->rx_coalesce_nsecs = DEFAULT_RX_COALESCE_NSECS;
 

-- 
2.55.0

