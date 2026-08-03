Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC330F924;
	Mon,  3 Aug 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723226; cv=none; b=c0IbMDRIXaGJeSP/tIe02OJLcFemQDXP47+LCmFKGZHKmsvkkPWfCDiGK65Q0QlugoiBHoFELExrkQWhXEH9DDtsve9Kw5MZGJVsOLRSuTOxl9Xra+Oc4AhxB1b1zFeE/TrwYbcZiHaWqJgjcWr3xgQUzWPaqQvncpYJXZBX89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723226; c=relaxed/simple;
	bh=1u+TrX3NVeZJ3MY+vzppmvobVJaji0pIj1+jFrPrSgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNJFHwyDUYPD9LeLxm7f6oLHUKoBW1rXIkWu1fXN1xikDe8kMKlaRIY6SIM9gVYnXG3iqZ4OO24+QPVL+QZxYMbZA3Unp7uZJZk70Ua9OnZsQp4lXOlHgPtaNf/hUcat9eIagBoG2sploAieTosm2iNom+VTY5JRInkJ1nbf+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WENglMrc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="WENglMrc"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6732D9Kv83810915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785723189;
	bh=l0r+56M9QMVLnhdzPYhBZbiJERJSp7bGS0tXmHX+R6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WENglMrcXECh3PHtItXaiovFscxV94S7Q9w6k5fFCoJU41ikCAwYEElvuLt6OHHhL
	 dCLuhR6XiA6BML1G/81m5TtEFDfo41aTWz0yMSaeKNLsEmccfzl478Mx3eHCgGBvhC
	 jAR1DQcYbCmvXY2/Q0rfWY0VU215jUiQ4HCFonbNWU3oa5CjpjSimTtzKLNxPLHfZI
	 M1BrHcZJOz4aAT9DTYRnkjvGrldeFVPfppmThNwnpv+EoOZABZ+RZKWhFJmQxc4RFS
	 d/6w0NdAgUF0n9pdd/L83lvUKSJbYBa4hZ+kVlrrv8EfgulrROGeTmm/YCSKKUlDmJ
	 26oJ1Y3LIURxA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6732D9Kv83810915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Aug 2026 10:13:09 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Aug 2026 10:13:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 3 Aug 2026 10:13:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 7/7] r8169: support setting rx queue numbers via ethtool
Date: Mon, 3 Aug 2026 10:13:05 +0800
Message-ID: <20260803021305.488-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260803021305.488-1-javen_xu@realsil.com.cn>
References: <20260803021305.488-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch add support for changing rx queues by ethtool. We can set rx
1, 2, 4, 8 by ethtool -L eth1 rx num.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - remove rss_support and rss_enable
 - remove some zero-initialized
 - use kzalloc_objs instead of kcalloc

Changes in v5:
 - no changes

Changes in v6:
 - change subject of this patch
 - defer the assignment of tp->init_rx_desc_type until after
   rtl8169_down()
 - call netif_set_real_num_rx_queues() to synchronize the new rx queue
   number with networking core

Changes in v7:
 - no changes

Changes in v8:
 - if dev is not running, updating tp->rss_data->rss_indir_tbl and
   calling netif_set_real_num_rx_queue when change rx queue number
 - if system does not provide enough irq_nvecs, return -EINVAL
 - malloc new_rx before device down

Changes in v9:
 - pass rx_desc_type to rtl8169_rx_clear
 - return netdev_err when netif_set_real_num_rx_queues fail

Changes in v10:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 161 ++++++++++++++++++++--
 1 file changed, 153 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 85040fd431cb..f80db8f69c1c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2787,11 +2787,16 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
-static void rtl8169_init_rss(struct rtl8169_private *tp)
+static void rtl8169_set_rss_indir_tbl(struct rtl8169_private *tp,
+				      unsigned int num_rx_rings)
 {
 	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
-		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
+}
 
+static void rtl8169_init_rss(struct rtl8169_private *tp)
+{
+	rtl8169_set_rss_indir_tbl(tp, tp->num_rx_rings);
 	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
 }
 
@@ -4429,7 +4434,9 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	return data;
 }
 
-static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
+static void rtl8169_rx_clear(struct rtl8169_private *tp,
+			     struct rtl8169_rx_ring *ring,
+			     enum rx_desc_type desc_type)
 {
 	int i;
 
@@ -4440,7 +4447,7 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring
 		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
 		ring->rx_databuff[i] = NULL;
 		ring->rx_desc_phy_addr[i] = 0;
-		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS) {
+		if (desc_type == RX_DESC_TYPE_RSS) {
 			ring->rx_desc_array[i].rss_addr = 0;
 			ring->rx_desc_array[i].rss_opts1 = 0;
 		} else {
@@ -4471,7 +4478,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
 
 		data = rtl8169_alloc_rx_data(tp, ring, i);
 		if (!data) {
-			rtl8169_rx_clear(tp, ring);
+			rtl8169_rx_clear(tp, ring, tp->init_rx_desc_type);
 			return -ENOMEM;
 		}
 		ring->rx_databuff[i] = data;
@@ -4538,7 +4545,7 @@ static int rtl8169_init_ring(struct rtl8169_private *tp)
 
 err_clear:
 	while (--i >= 0)
-		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+		rtl8169_rx_clear(tp, &tp->rx_ring[i], tp->init_rx_desc_type);
 	return ret;
 }
 
@@ -5544,7 +5551,7 @@ static int rtl8169_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	rtl8169_down(tp);
 	for (int i = 0; i < tp->num_rx_rings; i++)
-		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+		rtl8169_rx_clear(tp, &tp->rx_ring[i], tp->init_rx_desc_type);
 
 	rtl8169_free_irq(tp);
 
@@ -5623,7 +5630,7 @@ static int rtl_open(struct net_device *dev)
 err_release_fw_2:
 	rtl_release_firmware(tp);
 	for (int i = 0; i < tp->num_rx_rings; i++)
-		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+		rtl8169_rx_clear(tp, &tp->rx_ring[i], tp->init_rx_desc_type);
 err_free_rx_1:
 	rtl8169_free_rx_desc(tp);
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
@@ -6214,6 +6221,142 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	ch->max_rx = tp->hw_supp_num_rx_queues;
+	ch->max_tx = 1;
+
+	ch->rx_count = tp->num_rx_rings;
+	ch->tx_count = 1;
+}
+
+static int rtl8169_realloc_rx(struct rtl8169_private *tp,
+			      struct rtl8169_rx_ring *new_rx,
+			      int new_count)
+{
+	int i, ret;
+
+	for (i = 0; i < new_count; i++) {
+		struct rtl8169_rx_ring *ring = &new_rx[i];
+
+		ring->rx_desc_array = dma_alloc_coherent(&tp->pci_dev->dev,
+							 R8169_RX_RING_BYTES,
+							 &ring->rx_phy_addr,
+							 GFP_KERNEL);
+		if (!ring->rx_desc_array) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+
+		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
+		ret = rtl8169_rx_fill(tp, ring);
+		if (ret) {
+			dma_free_coherent(&tp->pci_dev->dev, R8169_RX_RING_BYTES,
+					  ring->rx_desc_array, ring->rx_phy_addr);
+			goto err_free;
+		}
+	}
+	return 0;
+
+err_free:
+	while (--i >= 0) {
+		rtl8169_rx_clear(tp, &new_rx[i], tp->init_rx_desc_type);
+		dma_free_coherent(&tp->pci_dev->dev, R8169_RX_RING_BYTES,
+				  new_rx[i].rx_desc_array, new_rx[i].rx_phy_addr);
+	}
+	return ret;
+}
+
+static int rtl8169_set_channels(struct net_device *dev,
+				struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	bool if_running = netif_running(dev);
+	enum rx_desc_type old_rx_desc_type;
+	enum rx_desc_type new_desc_type;
+	struct rtl8169_rx_ring *new_rx;
+	int i, ret;
+
+	if (ch->rx_count == tp->num_rx_rings)
+		return 0;
+
+	old_rx_desc_type = tp->init_rx_desc_type;
+
+	if (!rtl_hw_support_rss(tp)) {
+		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (ch->rx_count > tp->hw_supp_num_rx_queues || !is_power_of_2(ch->rx_count) ||
+	    tp->irq_nvecs < get_min_irq_nvecs(tp))
+		return -EINVAL;
+
+	new_desc_type = ch->rx_count > 1 ? RX_DESC_TYPE_RSS : RX_DESC_TYPE_DEFAULT;
+
+	if (!if_running) {
+		ret = netif_set_real_num_rx_queues(dev, ch->rx_count);
+		if (ret)
+			return ret;
+
+		tp->num_rx_rings = ch->rx_count;
+		tp->init_rx_desc_type = new_desc_type;
+
+		rtl8169_set_rss_indir_tbl(tp, tp->num_rx_rings);
+		rtl_set_irq_mask(tp);
+		return 0;
+	}
+
+	new_rx = kzalloc_objs(*new_rx, R8169_MAX_RX_QUEUES);
+	if (!new_rx)
+		return -ENOMEM;
+
+	netif_stop_queue(dev);
+	rtl8169_down(tp);
+
+	ret = netif_set_real_num_rx_queues(dev, ch->rx_count);
+	if (ret)
+		goto err_up;
+
+	tp->init_rx_desc_type = new_desc_type;
+
+	ret = rtl8169_realloc_rx(tp, new_rx, ch->rx_count);
+	if (ret)
+		goto err_reset;
+
+	for (i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i], old_rx_desc_type);
+	rtl8169_free_rx_desc(tp);
+
+	tp->num_rx_rings = ch->rx_count;
+
+	memset(tp->rx_ring, 0, sizeof(tp->rx_ring));
+	memcpy(tp->rx_ring, new_rx, sizeof(*new_rx) * ch->rx_count);
+
+	rtl8169_set_rss_indir_tbl(tp, tp->num_rx_rings);
+	rtl_set_irq_mask(tp);
+
+	rtl8169_up(tp);
+	netif_start_queue(dev);
+
+	kfree(new_rx);
+
+	return 0;
+
+err_reset:
+	if (netif_set_real_num_rx_queues(dev, tp->num_rx_rings))
+		netdev_err(dev, "Failed to revert rx_queues, state might be inconsistent!\n");
+	tp->init_rx_desc_type = old_rx_desc_type;
+err_up:
+	rtl8169_up(tp);
+	netif_start_queue(dev);
+	kfree(new_rx);
+
+	return ret;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6232,6 +6375,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
+	.set_channels		= rtl8169_set_channels,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0

