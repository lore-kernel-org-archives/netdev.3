Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D028504F;
	Thu, 10 Sep 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021911; cv=none; b=io4CAAkEMZTFpNNuVTpHUQTdYqtDnBSTuJRKpj9wL8k91l489fzEE25nM0MU3YwMFIUpbsa/ahVg0HQT5EwCkGWQ3OXGPDX9LrV7qwT3kwXAv9oOJtALpUNKpQo6iAWvoqnOPioNWVWrDScoQW6xRD7KaK0++S/wwrbRwfEmPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021911; c=relaxed/simple;
	bh=D6H+h3PmJKgCJOPrFkG+/SVoGhbY9LdmIC0KHn7VXts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwq/8rgknotyWKserzqYb0NIddgPUUuHoFvRVtbKQdIVT3BtWA1KhzDL7ngTKPVTv/WMmd4OSHEfov5xBl8zAfaWmlA/A9LLcVHcmm4p6relGxKkYo/4Bxp3qaEvXrTC6yzbJv/ChgbpANwJKDXmAt1bj5mRAvyCHT8Rzp3Cz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=AdaHREuF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="AdaHREuF"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68A6VEeI41272533, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789021874;
	bh=ZHVSjw26Toz5wMwyL/DEMoNrcl6bKhDfk8iJn9rH+yY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AdaHREuFTcxQ9terwSfqZ/sTw7LYa3VCT+05eJBrcsEKJU/+jf9qjZM3WMU+Y4xve
	 7zAp1sbfKtQP5B+iz/fFImAK1RbZ3gxWRd6YM4J8QJMR3ewlHsu7J22Y2tlFAdqdWE
	 HcGOs+6NGcgdqoh1iujo9N9DZ6ryQjPSvU1RsRAlnjEjDXSmCw10CPvDDRbixNVM52
	 lhVVTZwe9s+yfzA9EXsvlMyE+7TyxrbAwRpPxz6ZYkhqM7N8xsFMrTXbwUD0rhhuL8
	 1D5TiuiVaZ4MME+0Xjzr8iuia406KVBvSPaP1s9lu9YgToMOyM0twqYwGRoiPf9DaI
	 AHsslcfkbfjaQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68A6VEeI41272533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 14:31:14 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 10 Sep 2026 14:31:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 10 Sep 2026 14:31:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v13 1/7] r8169: add support for multi irqs
Date: Thu, 10 Sep 2026 14:31:04 +0800
Message-ID: <20260910063110.1350-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260910063110.1350-1-javen_xu@realsil.com.cn>
References: <20260910063110.1350-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

RSS uses multi rx queues to receive packets, and each rx queue needs one
irq and napi. So this patch adds support for multi irqs and napi here.
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - remove some unused definitions, such as index, name in rtl8169_irq
 - remove array imr and isr
 - remove min_irq_nvecs and max_irq_nvecs, replaced with help function
   get_min_irq_nvecs and get_max_irq_nvecs
 - alloc irq by flags, instead of PCI_IRQ_ALL_TYPES

Changes in v3:
 - add enum rtl_isr_version to replace macro definition
 - remove struct rtl8169_napi, use napi_struct array instead and alloc
   memory for this array dynamically
 - remove struct rtl8169_irq

Changes in v4:
 - change retval to ret in rtl8169_set_real_num_queue()
 - reverse xmas tree in rtl8169_poll() and rtl8169_interrupt()
 - remove tp->hw_supp_isr_ver

Changes in v5:
 - rtl8169_request_irq(), when failed, only free irqs which are
   allocated
 - remove rss_support, simplied napi init, call r8169_init_napi()
   directly
 - remove rtl_isr_version, INTR_VEC_MAP_MASK, INTR_VEC_MAP_STATUS,
   R8169_MAX_MSIX_VEC, rss_enable, recheck_desc_ownbit
 - rtl_software_parameter_initialize() this function will be expanded in
   next patch, so i want to remain it here.

Changes in v6:
 - Fix netpoll crash
 - Fix use-after-free during driver unload by registering a devm action
   for netif_napi_del()
 - remove tp->irq

Changes in v7:
 - pass NAPI as arg to rtl_rx()
 - use netif_set_real_num_queues to replace rtl8169_set_real_num_queues
 - replace rtl_software_parameter_initialize with rtl_setup_rx_params

Changes in v8:
 - no changes

Changes in v9:
 - no changes

Changes in v10:
 - no changes

Changes in v11:
 - no changes

Changes in v12:
 - no changes

Changes in v13:
 - Fix sleep-in-atomic bug in netpoll by passing 0 to
   rtl8169_interrupt()
 - call netif_napi_set_irq() to properly associate NAPI with IRQ vector
 - Fix print format for unsigned int tp->irq_nvecs from %d to %u
---
 drivers/net/ethernet/realtek/r8169_main.c | 151 +++++++++++++++++-----
 1 file changed, 122 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5415ff62a286..b362855c262f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -761,7 +761,6 @@ struct rtl8169_private {
 	struct pci_dev *pci_dev;
 	struct net_device *dev;
 	struct phy_device *phydev;
-	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
 	enum rtl_sfp_mode sfp_mode;
@@ -774,10 +773,12 @@ struct rtl8169_private {
 	dma_addr_t RxPhyAddr;
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	struct napi_struct *rtl8169_napi;
+	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
-	int irq;
+	unsigned int irq_nvecs;
 	struct clk *clk;
 	int speed;
 
@@ -2769,6 +2770,11 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_setup_rx_params(struct rtl8169_private *tp)
+{
+	tp->num_rx_rings = 1;
+}
+
 static void rtl_request_firmware(struct rtl8169_private *tp)
 {
 	struct rtl_fw *rtl_fw;
@@ -4431,9 +4437,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
 	netdev_reset_queue(tp->dev);
 }
 
+static void rtl8169_napi_disable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_disable(&tp->rtl8169_napi[i]);
+}
+
+static void rtl8169_napi_enable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_enable(&tp->rtl8169_napi[i]);
+}
+
 static void rtl8169_cleanup(struct rtl8169_private *tp)
 {
-	napi_disable(&tp->napi);
+	rtl8169_napi_disable(tp);
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
 	synchronize_net();
@@ -4479,7 +4497,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
 	for (i = 0; i < NUM_RX_DESC; i++)
 		rtl8169_mark_to_asic(tp->RxDescArray + i);
 
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
 	rtl_hw_start(tp);
 }
 
@@ -4933,7 +4951,8 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
 		skb_checksum_none_assert(skb);
 }
 
-static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
+static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
+		  int budget, struct napi_struct *napi)
 {
 	struct device *d = tp_to_dev(tp);
 	int count;
@@ -4985,7 +5004,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
+		skb = napi_alloc_skb(napi, pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
 			goto release_descriptor;
@@ -5009,7 +5028,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->napi, skb);
+		napi_gro_receive(napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
@@ -5021,8 +5040,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 
 static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
-	struct rtl8169_private *tp = dev_instance;
-	u32 status = rtl_get_events(tp);
+	struct napi_struct *napi = dev_instance;
+	struct rtl8169_private *tp;
+	u32 status;
+
+	tp = netdev_priv(napi->dev);
+	status = rtl_get_events(tp);
 
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
@@ -5043,13 +5066,43 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	}
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule(napi);
 out:
 	rtl_ack_events(tp, status);
 
 	return IRQ_HANDLED;
 }
 
+static void rtl8169_free_irq(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		struct napi_struct *napi = &tp->rtl8169_napi[i];
+
+		pci_free_irq(tp->pci_dev, i, napi);
+	}
+}
+
+static int rtl8169_request_irq(struct rtl8169_private *tp)
+{
+	struct net_device *dev = tp->dev;
+	struct napi_struct *napi;
+	int i, rc;
+
+	for (i = 0; i < tp->irq_nvecs; i++) {
+		napi = &tp->rtl8169_napi[i];
+		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
+				     NULL, napi, "%s-%d", dev->name, i);
+		if (rc)
+			goto free_irq;
+	}
+	return 0;
+
+free_irq:
+	while (--i >= 0)
+		pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
+	return rc;
+}
+
 static void rtl_task(struct work_struct *work)
 {
 	struct rtl8169_private *tp =
@@ -5084,13 +5137,13 @@ static void rtl_task(struct work_struct *work)
 
 static int rtl8169_poll(struct napi_struct *napi, int budget)
 {
-	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
-	struct net_device *dev = tp->dev;
-	int work_done;
+	struct rtl8169_private *tp = netdev_priv(napi->dev);
+	struct net_device *dev = napi->dev;
+	int work_done = 0;
 
 	rtl_tx(dev, tp, budget);
 
-	work_done = rtl_rx(dev, tp, budget);
+	work_done = rtl_rx(dev, tp, budget, napi);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5175,7 +5228,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	if (tp->phydev)
 		rtl8169_init_phy(tp);
 
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 }
@@ -5192,7 +5245,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 
 	phylink_disconnect_phy(tp->phylink);
 
@@ -5213,7 +5266,8 @@ static void rtl8169_netpoll(struct net_device *dev)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
-	rtl8169_interrupt(tp->irq, tp);
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		rtl8169_interrupt(0, &tp->rtl8169_napi[i]);
 }
 #endif
 
@@ -5221,7 +5275,6 @@ static int rtl_open(struct net_device *dev)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 	struct pci_dev *pdev = tp->pci_dev;
-	unsigned long irqflags;
 	int retval = -ENOMEM;
 
 	pm_runtime_get_sync(&pdev->dev);
@@ -5246,8 +5299,7 @@ static int rtl_open(struct net_device *dev)
 
 	rtl_request_firmware(tp);
 
-	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
-	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
+	retval = rtl8169_request_irq(tp);
 	if (retval < 0)
 		goto err_release_fw_2;
 
@@ -5266,7 +5318,7 @@ static int rtl_open(struct net_device *dev)
 	return retval;
 
 err_free_irq:
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
 	rtl8169_rx_clear(tp);
@@ -5419,6 +5471,14 @@ static void rtl_shutdown(struct pci_dev *pdev)
 		pci_prepare_to_sleep(pdev);
 }
 
+static void r8169_free_napi(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		netif_napi_del(&tp->rtl8169_napi[i]);
+
+	kfree(tp->rtl8169_napi);
+}
+
 static void rtl_remove_one(struct pci_dev *pdev)
 {
 	struct rtl8169_private *tp = pci_get_drvdata(pdev);
@@ -5432,6 +5492,7 @@ static void rtl_remove_one(struct pci_dev *pdev)
 		r8169_remove_leds(tp->leds);
 
 	unregister_netdev(tp->dev);
+	r8169_free_napi(tp);
 	phylink_destroy(tp->phylink);
 
 	if (tp->dash_type != RTL_DASH_NONE)
@@ -5473,7 +5534,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
+	struct pci_dev *pdev = tp->pci_dev;
 	unsigned int flags;
+	int nvecs;
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
@@ -5489,7 +5552,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
+	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
+
+	if (nvecs < 0)
+		return nvecs;
+
+	tp->irq_nvecs = nvecs;
+
+	return 0;
 }
 
 static void rtl_read_mac_address(struct rtl8169_private *tp,
@@ -6005,6 +6075,15 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 	return 0;
 }
 
+static void r8169_init_napi(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+		netif_napi_set_irq(&tp->rtl8169_napi[i],
+				   pci_irq_vector(tp->pci_dev, i));
+	}
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
@@ -6105,12 +6184,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rtl_hw_reset(tp);
 
+	rtl_setup_rx_params(tp);
+
 	rc = rtl_alloc_irq(tp);
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
-	tp->irq = pci_irq_vector(pdev, 0);
-
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
 
@@ -6118,8 +6197,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->ethtool_ops = &rtl8169_ethtool_ops;
 
-	netif_napi_add(dev, &tp->napi, rtl8169_poll);
-
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
 	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
@@ -6180,6 +6257,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (jumbo_max)
 		dev->max_mtu = jumbo_max;
 
+	rc = netif_set_real_num_queues(tp->dev, 1, tp->num_rx_rings);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
+
 	rtl_set_irq_mask(tp);
 
 	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
@@ -6202,10 +6283,17 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
+				   GFP_KERNEL);
+	if (!tp->rtl8169_napi)
+		return -ENOMEM;
+
+	r8169_init_napi(tp);
+
 	rc = register_netdev(dev);
 	if (rc) {
 		phylink_destroy(tp->phylink);
-		return rc;
+		goto err_free_napi;
 	}
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
@@ -6215,8 +6303,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			tp->leds = rtl8168_init_leds(dev);
 	}
 
-	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d\n",
-		    chip->name, dev->dev_addr, ext_xid_str, xid, tp->irq);
+	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d (%u total)\n",
+		    chip->name, dev->dev_addr, ext_xid_str, xid,
+		    pci_irq_vector(pdev, 0), tp->irq_nvecs);
 
 	if (jumbo_max)
 		netdev_info(dev, "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
@@ -6236,6 +6325,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
+
+err_free_napi:
+	r8169_free_napi(tp);
+	return rc;
 }
 
 static struct pci_driver rtl8169_pci_driver = {
-- 
2.43.0

