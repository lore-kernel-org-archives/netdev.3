Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591290;
	b=sDWbxwU2otDHwypKzpsBSUwOPGlNF7VMIfUjrHaKbg9bDfN32Eq/z/U4rcJR3WHViPuG
	 cs7XFHMHlKGVty81pI4V1VCltyQin4X5/uQcF3F2fFk+cHAc/C6UPi2rLQUFVwr8iZtPe
	 /FSWrFhx+S8rLGoRbFiNVc5bwtlnL6H/CAcy38Cg6WDcicyu/GOx1KAWMeqf6MrK2CQGd
	 sp7UOHOfT5VR/AmG2vGKNeYsFdTWKopTMw8SuaGt0qX1BxpVx8SZ1vj6+ZQxooVZvN0iY
	 p+LwH02JykOJ1MTQVRlTO6k1dfRMEEyAvLEUws567Vodb6Jmn1U1ovsjuAsRRyRqrsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cFPNzUzaEvlmAt2XncHNzP/taiNHYfmBHlXzkk87aOE=;
	b=uOOjcq/RrO4aRKD1QBX/icLdjbzM5SsEhqReUhcw1m9S0vB7HPOwxHq0Kmup6zdMC0de
	 2btuF1vRelJ3LPrSUdXaHysvorPLkFW+5q8qi36GJj+IgVGUiI3Nd4MztlhUXz/uK4CJo
	 oZwRlXGagH3FHTdjqAx56aeDKMeiOlDVmNuL+GB5jcFOclzpz7Y1D6mpoqU9lbkqJqs6x
	 XCUZlfDh6B2zQayeQFJEPbKsv3WLf3rzh+Bj+4ttbNRbPA8ZnMhu+sL7USgvVHc9GqCwY
	 RDVcW9D6FszfWibr32VrfswD7quJZTTXOrUaJaYAgtWhVsDxU4ncRsnnSCumLO0OIwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvQEHYxo;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081D606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0081D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvQEHYxo
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3328176eec.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793591289; x=1794196089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFPNzUzaEvlmAt2XncHNzP/taiNHYfmBHlXzkk87aOE=;
        b=DvQEHYxoXn9OgKghSx0T2iQhJooKYmMi3C4cYuig4RZrGnBeCH1Z3Yt6YrDilgZfSI
         zMUBSBcU9lvSQe90A4XdpgNZQZ/vSt/FB5GCVAT5egbKCjwvI/0Uih8idz1YZGr3wACx
         RvumeXINaEw8kkR54Pd+RPkO4xSk/u8VQUSDbhmn8cqhNzQOHEC5H3nSn+HQWrItX3W8
         uU3tGgC2XSsGmeh9ANWClsYiYGWXaP5EJVQpyBYtmQXAYblmpZZhRnWjvDhJjB5PQI+E
         8JXiSjPCkTDcJl3ynan9+bNDjcCl+f3uqzu1Kc3imSlZe/VHvZ3ChO610DqoIVWBytbY
         eDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793591289; x=1794196089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFPNzUzaEvlmAt2XncHNzP/taiNHYfmBHlXzkk87aOE=;
        b=Hi5f4atPNrvjDkMw1Y0mcCwb55v6n3hWMG5SSwEP+di91mNuag3XPJvgQ23bslfXrB
         8+Vubz8+yLZCxgP+97t+gCNWPbR2kalICvo0ryTx4YuCmLu6sKaQMHUpLWFt4+0jfTib
         LWajH+FoJP1SiGs6M6Qm2/VODiqta98nQywaqEZEXutr9fTmN7VwP8UY7VWg+aYgHcMy
         kR3N0CG0fDgsUgd8yp2cf8kS//TQaDRlMDPwqMyP1iSyUc2VrCn3Z1Ax81oQQpJ/t14j
         9T5rkvIEpyJDO8LSJudvfj+VvlrM78fa37ldsx72gy70NjrUarkR2GG4WkAyXl2YXuJf
         ZdYA==
X-Gm-Message-State: APuU4Z85oxCSr2uvEB3tPslTQxOjVJD6O79ajLLewCG4z4HYimPbyzMn
	ONDYYE3pM87JybC4aHaNmzq4zQjKJDZa0s4yLU6oT77DLiDRcK4IEbVFATF4Fw==
X-Gm-Gg: AYBFou37V2pX0pSqt7pKyBKzPtrUOPSAtnQGimtRbnTTqNzLvlO/f/X/qVxaY28CaQU
	bwe6ZWYAAXghDfT3wSvTzMNhpkx38jNwFQGSXcxKRSXA862bVXRzyE8iZHRKg23qaPrP55jlyBl
	aIwTNuZ/iezTs80cPmM+aaLBq+36eC8htp2zi447mA5D8HDNrgCxlCJnfk4O9bxb111xoKSZvhE
	2h6v2umbHL8sQRXN+KPa7dsNutYtcpofGbIVxK/JrgmtLWnFaOHg3PUK97JNqBB2FyJAZEAO+B9
	gRbjCCQaUD5H9T4Zm+Vjwps8ehrGH6gBKqBoIc3BFLBfGsQTanQzvNU3IXgnikAt2+f2aDGA+WJ
	HM1PFyu6GSEk2GeCqm/XB4lU47X7adqTW/raSM5EGbqBwiGC0MgXdY3lFUaK34fqTsxE2YvF7aE
	/1rY0NB2kvC0L55GPnHhkuxX2QeuJzPAypV5WyICTITs2Cxcm3n/JC930Jvti4S8eGamKwFE4Oo
	7xKS0YkgdBVJ8Y+BxKe/krXlLduKl7kfZB5UIcL4mt/jKyJGiNdTYgDhR1hDQKM9q41yTe+3gxi
	RVJ4N0zF8/Rclxqc824cnNVR+kqUzIXh10aq5EVAMDu3obzfUu9kLzm5vXY5i4mtQ89XzJjj1KZ
	Ge2zScXRYgL+k74OzEuP9lxzqDl04KJzbo0bhG5jiyMIU5Pqn6o6v7c5xYvgsk0eIrj7Si83mJb
	svPg==
X-Received: by 2002:a05:693c:4153:20b0:358:8f02:e0ca with SMTP id 5a478bee46e88-36a4236903fmr14289283eec.9.1793591288664;
        Sun, 01 Nov 2026 19:48:08 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm34899514eec.3.2026.11.01.19.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 19:48:08 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ibm: emac: use page_pool for RX buffers
Date: Sun,  1 Nov 2026 19:48:06 -0800
Message-ID: <20261102034806.190498-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The RX ring held skbs that were allocated and DMA mapped when a slot was
refilled. By the time a frame arrived in that slot the skb was cold, and
every refill paid for a full skb allocation and a dma_map_single().

Take the RX buffers from a page_pool instead and build the skb with
napi_build_skb() once a frame has arrived. Frames spanning several BDs
get the following buffers attached as page fragments instead of being
copied into one large skb. The BD size is capped so that a buffer always
fits into a page. The driver now syncs the received data for the CPU
before reading it.

The pool recycles directly into the MAL NAPI instance, so it is
destroyed while that instance is disabled.

Routing a single TCP stream through the qca8k switch of a Meraki MX60
(iperf3 median of 3):

          LAN->WAN   WAN->LAN  (Mbit/s)
  before  588        508
  after   614        528

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/Kconfig |   1 +
 drivers/net/ethernet/ibm/emac/core.c  | 234 ++++++++++++++++----------
 drivers/net/ethernet/ibm/emac/core.h  |  39 +++--
 drivers/net/ethernet/ibm/emac/mal.c   |  18 ++
 drivers/net/ethernet/ibm/emac/mal.h   |   2 +
 5 files changed, 191 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/Kconfig b/drivers/net/ethernet/ibm/emac/Kconfig
index c8e5de5987ac..8779c5b6a2c3 100644
--- a/drivers/net/ethernet/ibm/emac/Kconfig
+++ b/drivers/net/ethernet/ibm/emac/Kconfig
@@ -3,6 +3,7 @@ config IBM_EMAC
 	tristate "IBM EMAC Ethernet support"
 	depends on PPC_DCR
 	select CRC32
+	select PAGE_POOL
 	select PHYLIB
 	help
 	  This driver supports the IBM EMAC family of Ethernet controllers
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 640618c0a09e..9496c09d7a7c 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -41,6 +41,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <net/page_pool/helpers.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -1020,10 +1021,30 @@ static int emac_set_mac_address(struct net_device *ndev, void *sa)
 	return 0;
 }
 
+static void *emac_alloc_rx_buf(struct emac_instance *dev, unsigned int size,
+			       gfp_t gfp)
+{
+	return page_pool_alloc_va(dev->rx_pool, &size, gfp);
+}
+
+static void emac_prepare_rx_buf(struct emac_instance *dev, int slot, void *va)
+{
+	struct page *page = virt_to_page(va);
+
+	dev->rx_buf[slot] = va;
+	dev->rx_dma[slot] = page_pool_get_dma_addr(page) + offset_in_page(va) +
+			    NET_SKB_PAD;
+	dev->rx_desc[slot].data_len = 0;
+	dev->rx_desc[slot].data_ptr = dev->rx_dma[slot] + NET_IP_ALIGN;
+	/* Descriptor fields must be visible before MAL sees it as empty */
+	wmb();
+	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
+	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
+}
+
 static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
 {
-	int rx_sync_size = emac_rx_sync_size(new_mtu);
-	int rx_skb_size = emac_rx_skb_size(new_mtu);
+	int rx_buf_size = emac_rx_buf_size(new_mtu);
 	int i, ret = 0;
 	int mr1_jumbo_bit_change = 0;
 
@@ -1051,28 +1072,23 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
 		    (i == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
 	}
 
-	/* Reallocate RX ring only if bigger skb buffers are required */
-	if (rx_skb_size <= dev->rx_skb_size)
+	/* Reallocate RX ring only if bigger buffers are required */
+	if (rx_buf_size <= dev->rx_buf_size)
 		goto skip;
 
-	/* Second pass, allocate new skbs */
+	/* Second pass, allocate new buffers */
 	for (i = 0; i < NUM_RX_BUFF; ++i) {
-		struct sk_buff *skb;
+		void *va;
 
-		skb = netdev_alloc_skb_ip_align(dev->ndev, rx_skb_size);
-		if (!skb) {
+		BUG_ON(!dev->rx_buf[i]);
+		va = emac_alloc_rx_buf(dev, rx_buf_size, GFP_KERNEL);
+		if (!va) {
 			ret = -ENOMEM;
 			goto oom;
 		}
 
-		BUG_ON(!dev->rx_skb[i]);
-		dev_kfree_skb(dev->rx_skb[i]);
-
-		dev->rx_desc[i].data_ptr =
-		    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
-				   rx_sync_size, DMA_FROM_DEVICE)
-				   + NET_IP_ALIGN;
-		dev->rx_skb[i] = skb;
+		page_pool_free_va(dev->rx_pool, dev->rx_buf[i], false);
+		emac_prepare_rx_buf(dev, i, va);
 	}
  skip:
 	/* Check if we need to change "Jumbo" bit in MR1 */
@@ -1092,6 +1108,8 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
 		emac_full_tx_reset(dev);
 	}
 
+	/* Must be updated before RX restarts, NAPI refills with this size */
+	dev->rx_buf_size = rx_buf_size;
 	mal_set_rcbs(dev->mal, dev->mal_rx_chan, emac_rx_size(new_mtu));
  oom:
 	/* Restart RX */
@@ -1117,15 +1135,14 @@ static int emac_change_mtu(struct net_device *ndev, int new_mtu)
 		/* Check if we really need to reinitialize RX ring. The
 		 * jumbo frame settings are only updated by a resize.
 		 */
-		if (emac_rx_skb_size(ndev->mtu) != emac_rx_skb_size(new_mtu) ||
+		if (emac_rx_buf_size(ndev->mtu) != emac_rx_buf_size(new_mtu) ||
 		    ndev->mtu > ETH_DATA_LEN || new_mtu > ETH_DATA_LEN)
 			ret = emac_resize_rx_ring(dev, new_mtu);
 	}
 
 	if (!ret) {
 		WRITE_ONCE(ndev->mtu, new_mtu);
-		dev->rx_skb_size = emac_rx_skb_size(new_mtu);
-		dev->rx_sync_size = emac_rx_sync_size(new_mtu);
+		dev->rx_buf_size = emac_rx_buf_size(new_mtu);
 	}
 
 	return ret;
@@ -1152,10 +1169,10 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
 	int i;
 
 	for (i = 0; i < NUM_RX_BUFF; ++i)
-		if (dev->rx_skb[i]) {
+		if (dev->rx_buf[i]) {
 			dev->rx_desc[i].ctrl = 0;
-			dev_kfree_skb(dev->rx_skb[i]);
-			dev->rx_skb[i] = NULL;
+			page_pool_free_va(dev->rx_pool, dev->rx_buf[i], false);
+			dev->rx_buf[i] = NULL;
 			dev->rx_desc[i].data_ptr = 0;
 		}
 
@@ -1163,6 +1180,9 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
 		dev_kfree_skb(dev->rx_sg_skb);
 		dev->rx_sg_skb = NULL;
 	}
+
+	mal_destroy_page_pool(dev->mal, dev->rx_pool);
+	dev->rx_pool = NULL;
 }
 
 static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
@@ -1176,44 +1196,20 @@ static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
 	}
 }
 
-static int
-__emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
-{
-	if (unlikely(!skb))
-		return -ENOMEM;
-
-	dev->rx_skb[slot] = skb;
-	dev->rx_desc[slot].data_len = 0;
-
-	dev->rx_desc[slot].data_ptr =
-	    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
-			   dev->rx_sync_size, DMA_FROM_DEVICE) + NET_IP_ALIGN;
-	wmb();
-	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
-	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
-
-	return 0;
-}
-
-static int
-emac_alloc_rx_skb(struct emac_instance *dev, int slot)
+static struct page_pool *emac_create_rx_pool(struct emac_instance *dev)
 {
-	struct sk_buff *skb;
-
-	skb = __netdev_alloc_skb_ip_align(dev->ndev, dev->rx_skb_size,
-					  GFP_KERNEL);
+	struct page_pool_params pp = {
+		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size	= NUM_RX_BUFF,
+		.nid		= NUMA_NO_NODE,
+		.dev		= &dev->ofdev->dev,
+		.napi		= &dev->mal->napi,
+		.netdev		= dev->ndev,
+		.dma_dir	= DMA_FROM_DEVICE,
+		.max_len	= PAGE_SIZE,
+	};
 
-	return __emac_prepare_rx_skb(skb, dev, slot);
-}
-
-static int
-emac_alloc_rx_skb_napi(struct emac_instance *dev, int slot)
-{
-	struct sk_buff *skb;
-
-	skb = napi_alloc_skb(&dev->mal->napi, dev->rx_skb_size);
-
-	return __emac_prepare_rx_skb(skb, dev, slot);
+	return page_pool_create(&pp);
 }
 
 static void emac_print_link_status(struct emac_instance *dev)
@@ -1232,17 +1228,27 @@ static void emac_print_link_status(struct emac_instance *dev)
 static int emac_open(struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
+	struct page_pool *pool;
 	int i;
 
 	DBG(dev, "open" NL);
 
+	pool = emac_create_rx_pool(dev);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+	dev->rx_pool = pool;
+
 	/* Allocate RX ring */
-	for (i = 0; i < NUM_RX_BUFF; ++i)
-		if (emac_alloc_rx_skb(dev, i)) {
+	for (i = 0; i < NUM_RX_BUFF; ++i) {
+		void *va = emac_alloc_rx_buf(dev, dev->rx_buf_size, GFP_KERNEL);
+
+		if (!va) {
 			printk(KERN_ERR "%s: failed to allocate RX ring\n",
 			       ndev->name);
 			goto oom;
 		}
+		emac_prepare_rx_buf(dev, i, va);
+	}
 
 	dev->tx_cnt = dev->tx_slot = dev->ack_slot = dev->rx_slot = 0;
 	clear_bit(MAL_COMMAC_RX_STOPPED, &dev->commac.flags);
@@ -1661,17 +1667,23 @@ static void emac_poll_tx(void *param)
 	netif_tx_unlock_bh(dev->ndev);
 }
 
+static inline void emac_rx_sync_for_cpu(struct emac_instance *dev, int slot,
+					int len)
+{
+	dma_sync_single_for_cpu(&dev->ofdev->dev, dev->rx_dma[slot],
+				SKB_DATA_ALIGN(len + NET_IP_ALIGN),
+				DMA_FROM_DEVICE);
+}
+
 static inline void emac_recycle_rx_skb(struct emac_instance *dev, int slot,
 				       int len)
 {
-	struct sk_buff *skb = dev->rx_skb[slot];
-
 	DBG2(dev, "recycle %d %d" NL, slot, len);
 
 	if (len)
-		dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
-			       SKB_DATA_ALIGN(len + NET_IP_ALIGN),
-			       DMA_FROM_DEVICE);
+		dma_sync_single_for_device(&dev->ofdev->dev, dev->rx_dma[slot],
+					   SKB_DATA_ALIGN(len + NET_IP_ALIGN),
+					   DMA_FROM_DEVICE);
 
 	dev->rx_desc[slot].data_len = 0;
 	wmb();
@@ -1717,23 +1729,69 @@ static inline void emac_rx_csum(struct emac_instance *dev,
 #endif
 }
 
+/* Hand the buffer of the slot to a new skb and refill the slot */
+static struct sk_buff *emac_build_rx_skb(struct emac_instance *dev, int slot,
+					 int len)
+{
+	struct sk_buff *skb;
+	void *va;
+
+	va = emac_alloc_rx_buf(dev, dev->rx_buf_size,
+			       GFP_ATOMIC | __GFP_NOWARN);
+	if (unlikely(!va))
+		return NULL;
+
+	/* napi_build_skb() only writes the skb_shared_info, which is past the
+	 * BD area, so the slot is synced for the CPU only once it is consumed.
+	 */
+	skb = napi_build_skb(dev->rx_buf[slot], dev->rx_buf_size);
+	if (unlikely(!skb)) {
+		page_pool_free_va(dev->rx_pool, va, true);
+		return NULL;
+	}
+
+	emac_rx_sync_for_cpu(dev, slot, len);
+	skb_mark_for_recycle(skb);
+	skb_reserve(skb, EMAC_RX_HEADROOM);
+	skb_put(skb, len);
+	emac_prepare_rx_buf(dev, slot, va);
+
+	return skb;
+}
+
 static inline int emac_rx_sg_append(struct emac_instance *dev, int slot)
 {
-	if (likely(dev->rx_sg_skb != NULL)) {
+	struct sk_buff *skb = dev->rx_sg_skb;
+
+	if (likely(skb)) {
 		int len = dev->rx_desc[slot].data_len;
-		int tot_len = dev->rx_sg_skb->len + len;
+		void *buf = dev->rx_buf[slot];
+		void *va;
 
-		if (unlikely(tot_len + NET_IP_ALIGN > dev->rx_skb_size)) {
+		if (unlikely(skb->len + len >
+			     dev->ndev->mtu + EMAC_MTU_OVERHEAD ||
+			     skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
 			++dev->estats.rx_dropped_mtu;
-			dev_kfree_skb(dev->rx_sg_skb);
-			dev->rx_sg_skb = NULL;
-		} else {
-			memcpy(skb_tail_pointer(dev->rx_sg_skb),
-					 dev->rx_skb[slot]->data, len);
-			skb_put(dev->rx_sg_skb, len);
-			emac_recycle_rx_skb(dev, slot, len);
-			return 0;
+			goto drop;
 		}
+
+		va = emac_alloc_rx_buf(dev, dev->rx_buf_size,
+				       GFP_ATOMIC | __GFP_NOWARN);
+		if (unlikely(!va)) {
+			++dev->estats.rx_dropped_oom;
+			goto drop;
+		}
+
+		emac_rx_sync_for_cpu(dev, slot, len);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				virt_to_page(buf),
+				offset_in_page(buf) + EMAC_RX_HEADROOM,
+				len, dev->rx_buf_size);
+		emac_prepare_rx_buf(dev, slot, va);
+		return 0;
+ drop:
+		dev_kfree_skb(skb);
+		dev->rx_sg_skb = NULL;
 	}
 	emac_recycle_rx_skb(dev, slot, 0);
 	return -1;
@@ -1756,7 +1814,6 @@ static int emac_poll_rx(void *param, int budget)
 		if (ctrl & MAL_RX_CTRL_EMPTY)
 			break;
 
-		skb = dev->rx_skb[slot];
 		mb();
 		len = dev->rx_desc[slot].data_len;
 
@@ -1785,15 +1842,19 @@ static int emac_poll_rx(void *param, int budget)
 			if (unlikely(!copy_skb))
 				goto oom;
 
+			emac_rx_sync_for_cpu(dev, slot, len);
 			memcpy(copy_skb->data - NET_IP_ALIGN,
-			       skb->data - NET_IP_ALIGN,
+			       dev->rx_buf[slot] + NET_SKB_PAD,
 			       len + NET_IP_ALIGN);
 			emac_recycle_rx_skb(dev, slot, len);
 			skb = copy_skb;
-		} else if (unlikely(emac_alloc_rx_skb_napi(dev, slot)))
-			goto oom;
+			skb_put(skb, len);
+		} else {
+			skb = emac_build_rx_skb(dev, slot, len);
+			if (unlikely(!skb))
+				goto oom;
+		}
 
-		skb_put(skb, len);
 	push_packet:
 		skb->protocol = eth_type_trans(skb, dev->ndev);
 		emac_rx_csum(dev, skb, ctrl);
@@ -1810,13 +1871,11 @@ static int emac_poll_rx(void *param, int budget)
 	sg:
 		if (ctrl & MAL_RX_CTRL_FIRST) {
 			BUG_ON(dev->rx_sg_skb);
-			if (unlikely(emac_alloc_rx_skb_napi(dev, slot))) {
+			dev->rx_sg_skb = emac_build_rx_skb(dev, slot, len);
+			if (unlikely(!dev->rx_sg_skb)) {
 				DBG(dev, "rx OOM %d" NL, slot);
 				++dev->estats.rx_dropped_oom;
 				emac_recycle_rx_skb(dev, slot, 0);
-			} else {
-				dev->rx_sg_skb = skb;
-				skb_put(skb, len);
 			}
 		} else if (!emac_rx_sg_append(dev, slot) &&
 			   (ctrl & MAL_RX_CTRL_LAST)) {
@@ -3097,8 +3156,7 @@ static int emac_probe(struct platform_device *ofdev)
 		       np, dev->mal_dev->dev.of_node);
 		goto err_rel_deps;
 	}
-	dev->rx_skb_size = emac_rx_skb_size(ndev->mtu);
-	dev->rx_sync_size = emac_rx_sync_size(ndev->mtu);
+	dev->rx_buf_size = emac_rx_buf_size(ndev->mtu);
 
 	/* Get pointers to BD rings */
 	dev->tx_desc =
@@ -3113,7 +3171,7 @@ static int emac_probe(struct platform_device *ofdev)
 	emac_clear_mal_desc(dev->tx_desc, NUM_TX_BUFF);
 	emac_clear_mal_desc(dev->rx_desc, NUM_RX_BUFF);
 	memset(dev->tx_skb, 0, NUM_TX_BUFF * sizeof(struct sk_buff *));
-	memset(dev->rx_skb, 0, NUM_RX_BUFF * sizeof(struct sk_buff *));
+	memset(dev->rx_buf, 0, sizeof(dev->rx_buf));
 
 	/* Attach to ZMII, if needed */
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII) &&
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 43578fe97fb2..d77ff352b957 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -53,24 +53,31 @@
 /* Maximum L2 header length (VLAN tagged, no FCS) */
 #define EMAC_MTU_OVERHEAD		(6 * 2 + 2 + 4)
 
-/* RX BD size for the given MTU */
-static inline int emac_rx_size(int mtu)
-{
-	return mal_rx_size(max(mtu, ETH_DATA_LEN) + EMAC_MTU_OVERHEAD);
-}
+/* Headroom in front of the received frame */
+#define EMAC_RX_HEADROOM		(NET_SKB_PAD + NET_IP_ALIGN)
+
+/* Largest RX BD size whose buffer still fits into one page */
+#define EMAC_RX_MAX_SIZE \
+	ALIGN_DOWN(SKB_WITH_OVERHEAD(PAGE_SIZE) - EMAC_RX_HEADROOM, 16)
 
-/* Size of RX skb for the given MTU */
-static inline int emac_rx_skb_size(int mtu)
+/* RX BD size for the given MTU, larger frames span several BDs */
+static inline int emac_rx_size(int mtu)
 {
-	int size = max(mtu + EMAC_MTU_OVERHEAD, emac_rx_size(mtu));
+	int size = mal_rx_size(max(mtu, ETH_DATA_LEN) + EMAC_MTU_OVERHEAD);
 
-	return SKB_DATA_ALIGN(size + NET_IP_ALIGN) + NET_SKB_PAD;
+	return min_t(int, size, EMAC_RX_MAX_SIZE);
 }
 
-/* RX DMA sync size */
-static inline int emac_rx_sync_size(int mtu)
+/* Size of an RX buffer for the given MTU, including the headroom and
+ * the skb_shared_info. Buffers above half a page take a whole page.
+ */
+static inline int emac_rx_buf_size(int mtu)
 {
-	return SKB_DATA_ALIGN(emac_rx_size(mtu) + NET_IP_ALIGN);
+	int size = SKB_HEAD_ALIGN(NET_SKB_PAD +
+				  SKB_DATA_ALIGN(emac_rx_size(mtu) +
+						 NET_IP_ALIGN));
+
+	return size > PAGE_SIZE / 2 ? PAGE_SIZE : size;
 }
 
 /* Driver statistcs is split into two parts to make it more cache friendly:
@@ -238,11 +245,13 @@ struct emac_instance {
 	struct mal_descriptor		*rx_desc;
 	int				rx_slot;
 	struct sk_buff			*rx_sg_skb;	/* 1 */
-	int 				rx_skb_size;
-	int				rx_sync_size;
+	int				rx_buf_size;
+	struct page_pool		*rx_pool;
 
 	struct sk_buff			*tx_skb[NUM_TX_BUFF];
-	struct sk_buff			*rx_skb[NUM_RX_BUFF];
+	void				*rx_buf[NUM_RX_BUFF];
+	/* DMA address of rx_buf + NET_SKB_PAD, cache line aligned */
+	dma_addr_t			rx_dma[NUM_RX_BUFF];
 
 	/* Stats
 	 */
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 236603a381bc..f1f7541379bc 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <net/page_pool/types.h>
 
 #include "core.h"
 #include <asm/dcr-regs.h>
@@ -86,6 +87,23 @@ void mal_unregister_commac(struct mal_instance	*mal,
 	netdev_unlock(mal->napi.dev);
 }
 
+/* A page pool that recycles directly into the MAL NAPI instance can only be
+ * destroyed while that instance is disabled.
+ */
+void mal_destroy_page_pool(struct mal_instance *mal, struct page_pool *pool)
+{
+	bool enabled;
+
+	netdev_lock(mal->napi.dev);
+	enabled = !list_empty(&mal->list);
+	if (enabled)
+		napi_disable_locked(&mal->napi);
+	page_pool_destroy(pool);
+	if (enabled)
+		napi_enable_locked(&mal->napi);
+	netdev_unlock(mal->napi.dev);
+}
+
 int mal_set_rcbs(struct mal_instance *mal, int channel, unsigned long size)
 {
 	BUG_ON(channel < 0 || channel >= mal->num_rx_chans ||
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index e0ddc41186a2..8264e5f0c9c1 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -276,6 +276,8 @@ void mal_disable_rx_channel(struct mal_instance *mal, int channel);
 void mal_poll_disable(struct mal_instance *mal, struct mal_commac *commac);
 void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac);
 
+void mal_destroy_page_pool(struct mal_instance *mal, struct page_pool *pool);
+
 /* Add/remove EMAC to/from MAL polling list */
 void mal_poll_add(struct mal_instance *mal, struct mal_commac *commac);
 void mal_poll_del(struct mal_instance *mal, struct mal_commac *commac);
-- 
2.56.0

