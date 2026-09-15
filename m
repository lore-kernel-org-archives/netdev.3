Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645063B83FC;
	Tue, 15 Sep 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478641; cv=none; b=XVbn8y26xO1n8mTPG1Ll5JLp66+B8e4qeDN7l5onK51wr7c3s7/uR1jN2JHy1FPLimEy2XHV2tnqJ9EGZ/KimXsIB3zqfW/mcq7Ut4LuHh3v/gyRrQefvQCF9mIXbBTcczJAGxE/t4nezXu9W1FixazzJ5ssc66D1bmraesLpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478641; c=relaxed/simple;
	bh=YXWKLqImduwKpMGXTwidUQidNpPXzdetpHtcY+QDIZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TorqR4H7sfzrHcpDB3UnavvIm4QXS1Lv5l64bnbE1itX53ee7o0qAJvNH3cbZNJbgOc1/KNXYcMjolC+yrAIjFTxW9fHpD1IWzIK0khKOOavbptvWqNKYNBK/HYLHFnGt82XCgA2Ayqn1IWugvaH5tZDmuJhzyEtNK00OiZaGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wZcPJeZb; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wZcPJeZb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l3MscyIOO64+OUmxSNmyMpGFfFy+ihbEJELH1ZrwKsM=;
	b=wZcPJeZbVXktOTRoKs3y1qU0zGEg+yTIeng6wdJBPxlKfjLU40OLQnzDyA1kTvkx+1QRX3hq8
	TCspJgywf9MSvaS/u9/32Qha9o5kz16XCdnJGZfseXYXplkAy43yp6Tb0QPeuJSmu9KqcVYbPIW
	kjuhu3b7nXUkchtBOAJrVc0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hkj9x4CW5zLlSh;
	Tue, 15 Sep 2026 21:12:53 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B4AA940565;
	Tue, 15 Sep 2026 21:23:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 15 Sep 2026 21:23:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next] net: hibmcge: fix spelling mistakes in comments and identifiers
Date: Tue, 15 Sep 2026 21:23:41 +0800
Message-ID: <20260915132341.1138610-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500018.china.huawei.com (7.202.195.199)

Fix several typos found in the driver:

  - hbg_irq.c:    macro parameter "ndde_reset" -> "need_reset"
  - hbg_txrx.c:   macro "hbg_queue_next_prt" -> "hbg_queue_next_ptr"
                  (and its call sites)
  - hbg_txrx.c:   function "hbg_ring_page_pool_destory" ->
                  "hbg_ring_page_pool_destroy"
  - hbg_common.h: comment "after rest" -> "after reset"
  - hbg_reg.h:    register macro "HBG_REG_BRUST_LENGTH_*" ->
                  "HBG_REG_BURST_LENGTH_*" (and references in hbg_hw.c)

No functional changes.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h |  2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     |  4 ++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c    |  4 ++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h    |  4 ++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c   | 12 ++++++------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 8e134da3e217..9ca04909774d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -152,7 +152,7 @@ struct hbg_mac_filter {
 	bool enabled;
 };
 
-/* saved for restore after rest */
+/* saved for restore after reset */
 struct hbg_user_def {
 	struct ethtool_pauseparam pause_param;
 };
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index d6e8ce8e351a..54ed1c17bc2d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -190,8 +190,8 @@ void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
 	hbg_hw_set_pcu_max_frame_len(priv, frame_len);
 	hbg_hw_set_mac_max_frame_len(priv, frame_len);
 
-	hbg_reg_write_field(priv, HBG_REG_BRUST_LENGTH_ADDR,
-			    HBG_REG_BRUST_LENGTH_B, burst_len_bit);
+	hbg_reg_write_field(priv, HBG_REG_BURST_LENGTH_ADDR,
+			    HBG_REG_BURST_LENGTH_B, burst_len_bit);
 }
 
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index ae4cb35186d8..2d67c7557b72 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -37,9 +37,9 @@ static void hbg_irq_handle_rx_buf_val(struct hbg_priv *priv,
 
 #define HBG_IRQ_I(name, handle) \
 	{#name, HBG_INT_MSK_##name##_B, false, false, false, handle}
-#define HBG_ERR_IRQ_I(name, need_print, ndde_reset) \
+#define HBG_ERR_IRQ_I(name, need_print, need_reset) \
 	{#name, HBG_INT_MSK_##name##_B, true, need_print, \
-	ndde_reset, hbg_irq_handle_err}
+	need_reset, hbg_irq_handle_err}
 
 static const struct hbg_irq_info hbg_irqs[] = {
 	HBG_IRQ_I(RX, hbg_irq_handle_rx),
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 30b3903c8f2d..0d2554ca3b5f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -191,8 +191,8 @@
 #define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
 #define HBG_REG_TX_CFF_ADDR_3_ADDR		(HBG_REG_SGMII_BASE + 0x0494)
 #define HBG_REG_RX_CFF_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x04A0)
-#define HBG_REG_BRUST_LENGTH_ADDR		(HBG_REG_SGMII_BASE + 0x04C4)
-#define HBG_REG_BRUST_LENGTH_B			BIT(29)
+#define HBG_REG_BURST_LENGTH_ADDR		(HBG_REG_SGMII_BASE + 0x04C4)
+#define HBG_REG_BURST_LENGTH_B			BIT(29)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 207ada721dd9..2ea025fd964f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -26,10 +26,10 @@
 	(hbg_queue_used_num((head), (tail), (ring)) == 0)
 #define hbg_queue_is_full(head, tail, ring) \
 	(hbg_queue_left_num((head), (tail), (ring)) == 0)
-#define hbg_queue_next_prt(p, ring) (((p) + 1) % (ring)->len)
+#define hbg_queue_next_ptr(p, ring) (((p) + 1) % (ring)->len)
 #define hbg_queue_move_next(p, ring) ({ \
 	typeof(ring) _ring = (ring); \
-	_ring->p = hbg_queue_next_prt(_ring->p, _ring); })
+	_ring->p = hbg_queue_next_ptr(_ring->p, _ring); })
 
 #define hbg_get_page_order(ring) ({ \
 	typeof(ring) _ring = (ring); \
@@ -167,7 +167,7 @@ netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* This smp_store_release() pairs with smp_load_acquire() in
 	 * hbg_napi_tx_recycle() called in tx interrupt handle process.
 	 */
-	smp_store_release(&ring->ntu, hbg_queue_next_prt(ntu, ring));
+	smp_store_release(&ring->ntu, hbg_queue_next_ptr(ntu, ring));
 	dev_sw_netstats_tx_add(netdev, 1, skb->len);
 	return NETDEV_TX_OK;
 }
@@ -220,7 +220,7 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 			break;
 
 		hbg_buffer_free(buffer);
-		ntc = hbg_queue_next_prt(ntc, ring);
+		ntc = hbg_queue_next_ptr(ntc, ring);
 		packet_done++;
 	}
 
@@ -535,7 +535,7 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 	return packet_done;
 }
 
-static void hbg_ring_page_pool_destory(struct hbg_ring *ring)
+static void hbg_ring_page_pool_destroy(struct hbg_ring *ring)
 {
 	if (!ring->page_pool)
 		return;
@@ -589,7 +589,7 @@ static void hbg_ring_uninit(struct hbg_ring *ring)
 		buffer->priv = NULL;
 	}
 
-	hbg_ring_page_pool_destory(ring);
+	hbg_ring_page_pool_destroy(ring);
 	dma_free_coherent(&ring->priv->pdev->dev,
 			  ring->len * sizeof(*ring->queue),
 			  ring->queue, ring->queue_dma);

base-commit: 348ea4642f56ab3dc93621c8e3ab0ccd0e5f1782
-- 
2.43.0

