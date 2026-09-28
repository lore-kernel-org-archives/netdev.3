Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CD37A4B8;
	Mon, 28 Sep 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620941; cv=fail; b=qxpd5ug1mvNBHBdhQf6AmlokPxkTF7ukuM6MLqqyGndFx9um3YjDCj6sxBtpRPVlYhuBZv1DEo/L7tI3cgSH7BrXXOj2shLSdqqzvcZX4gkWCMYh8qjCnK4NJS0zVuK/EJbV7KD5mX9GN7bImHw71shO5dOugktO/iY97VWmxqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620941; c=relaxed/simple;
	bh=moHRUrQU9dkd1SK1Eh7d1ZqdaPtEtg+jnYRUQ49g0d0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwLudH8mNSknee4JkXY9IBjyXGvZpCJfRZbTnS+WSWBySbjNOv83Ple4cdzf+4FJdKVeablGCZDk5ey67/SEn30OlTH/Q99SUIhkSF0Gl7ucUs3r34vZQI71XezBl4xo/FqNGSTxTiKE7oU2makC883WO43LbKc03D8zziCueWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xsnunmu6; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xsnunmu6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REgsPZX7zyLkNEsz1ziiO/XYFUWAm/EgLNwvjcAaDqi+MfRjHtNxiUU9MvHcqlV6q8FEL0LO9CUGCMaxbdGzVVljldVhFBqsglqVdk6uKHgSmdHol/Tdk2YQFW/0am2DQZvJYFrHrDpXAVyOopOwD4SBYMIV2OyPE+8WN2FwW0JmEpc2jIhYo/oFLo6hGCYFfCSCHJopinwkyYkAlD5b544JtRkCv1O6BFKSGW/bRsi/a5cxLK9sjhFvfpnQFv2hUb6gv54x7nHR8c+T3qugPSYAEvsUOsAabUDV9oOMaWcTHrATMkIKoNswWhwhZQRyj4+OoQapXzdaB+s4XImY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDmKiv6ogXsm/U8FHSGLKv2tvJOX9s6Avgiic4wBT2A=;
 b=HPP9nXkroMgQ80AqwTxIs2d0wysCb49q1QDKKJQKb+Rz7KVEcR+7hZKvgCUONN8xpO9kYKjZWicbnab2FhKnj5KsXLfP2nUENNgvf8peJI9znd7O2GCMJ/a0yQ9FDbL9cL+mECA4OVOtuBmGkthqnzKnNG6MuMEMJI+BqvlbrBvmrTivfMI8em9RZcudb40YAxBfF38ZUKpb5TpQZZUeBaavDfMFxBqqz3k/mQ5wXzXtbjCD9qd14wnn0oIqUPnxUakunI0mC36vELHF0ebYcMaxbxHQchDlf/w0kj04Hg9HGxfsT7ZmieO03/4afpF23Yf4XdAPjpC4xFa5M4oNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDmKiv6ogXsm/U8FHSGLKv2tvJOX9s6Avgiic4wBT2A=;
 b=Xsnunmu6QoasPZ2fkDZs8+FXr9/4jRzmXe/cfvuEpdvddhHuunFwnef1K/Rw8+6YDYG/VwC2pIJK3Pc0eaP7AqOoXe9do5cciFOT8ltNLhoxy8lprnu3cUk4jRCcWFYCIk4HQVcHUxNEMKycy98rq2DjgzHZJqCFdJ1kkkIjDfE=
Received: from PH7PR17CA0016.namprd17.prod.outlook.com (2603:10b6:510:324::19)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:42:13 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::89) by PH7PR17CA0016.outlook.office365.com
 (2603:10b6:510:324::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 18:42:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 18:42:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:42:10 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 13:42:08 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v4] net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
Date: Tue, 29 Sep 2026 00:12:07 +0530
Message-ID: <20260928184207.2361931-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1706c8ac-84fc-4ea4-44f3-08df1d9035f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|3023799007|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	uy4GgBPYLMZ8DblJNJRF3hCAeQz4emjmiU2jsTzk3ZlCbLslJw6Bc/EpHNf0L+y/iyv2KJE+NR80NoJ+Y0h8B0XSwy/Fmnvl/FXLnkcKnLIbZG71b0Iuk3KoAp8iVnc0xpfxvd6HRoQ2l+FbKSM5AtA8JrcGW9rwesud8jxviSQkGp6F8K/7b1ErhBoYOsLzNTamDqG+qYFzeTQlCPrBwAmTa6N+gvn2xKiQCMuJni14vrq3Jlfnd3WotcVUp/eGpLblZN9cfKdRJUi9Mj2E+/N2ilmWMVi2skHhL3W/XxsGNl5UKERFn71qFatgm/4jZJiUeEAuYDq8qmMXS/C11onybhAzR5TefeN6fiiSEROYbtfJrVX99qhv4NYkPFNb0JXUzDC9Zcf5R052cBiXKW1j7YPuHN9rPx6qjX27jcRjS2LaRnciJY9apNPRA/QMvQE635BFXrFh8X8arxSyUSoWm4l1YRMFkZm1o25HbJTXHZXpdd+T87/4/sBhsY8s+iDegiPZ+fk8C3JDeKVtJB2Neim5NdkHSE/JsrVCQksyNiDos90giJ9m6nW+6vncAzX0RsVcVtMs+P2/56JMSgv3fuicDWDQEhAkGHNofG/uYH15lqf7yonOZSbh5tULNDjMXpgUSJnAebHxYnSqSZnJ0AM4xh+WNcFxSuvuOVA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	57KbSdoqh2+j3pQ4uyGrQ/C0PnLr9uVaLWnP1UAWjgw1+1srEQJ6CV0oVLPhH0Ierx7CL9J5JOiqDqTkyQcx72kS/7gkzw7ZsmBC7oK+mFilPE1PrzDqXSd79TxEe/r8953kC3ve2Wf0UrKVogn9beEaQBylGBOdNWE6MFb+cY8UkXf+/ns6gGQd+R4WN73UzYykU6vzPGnTyAt2nACgqeTFhX2bR6b6v1GoXk2uXeaMZ7ZT6+t5u9lOyHci5580u1lOJkX2fbn3zV43B5DyOoLa8KCdtZPP5cZYFfYzKqu/z2sCL5Bpa/BbEP0GmMKJGdYOZIIhJk9+6YfteKsjiNHYxexu4zWbo1FimilZTI3WCzoYrXzXt87VABHvJCf243PN3Gmg10eGCsJeLjB6STOqnLguMTbFd+GVwB6/uaoRCpsQuD3cjeQp2ePQLf6R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:42:12.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1706c8ac-84fc-4ea4-44f3-08df1d9035f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

In the dmaengine path the driver pre-submits RX buffers and holds
in-flight TX buffers whose SKBs are DMA-mapped by the driver and freed
only in the completion callbacks. On ndo_stop() dmaengine_terminate_sync()
aborts these descriptors without running their callbacks, and the driver
then frees only the ring shells, leaking every SKB still owned by the
engine and its DMA mapping on each ifdown. With 128 RX buffers pre-posted
per channel, the mapping leak can eventually exhaust a limited IOMMU
aperture.

Clear the slot's skb in the TX and RX callbacks so a non-NULL skb marks a
slot that still owns a live, DMA-mapped buffer, and on stop unmap and free
every such buffer.

axienet_dma_rx_cb() runs from the DMA tasklet and re-arms the RX ring on
each completion, so it can race axienet_stop(): a completion may submit a
fresh buffer after dmaengine_terminate_sync() has returned, leaving the
channel armed with a buffer the teardown then frees while the engine may
still write into it (dma_release_channel() does not stop it either). Add a
lock that axienet_dma_rx_cb() holds across the @stopping check and the
resubmit, and axienet_stop() holds to set @stopping before terminating.
Once @stopping is set no callback can arm a new buffer, and any armed just
before is aborted by the terminate, so teardown only frees buffers the
engine no longer owns.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Cc: stable@vger.kernel.org
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
Changes in v4:
- Use plain accesses to @stopping under rx_submit_lock and drop the now
  redundant READ_ONCE()/WRITE_ONCE() on the dmaengine path (Simon Horman).

Changes in v3:
- Serialize RX descriptor resubmission in axienet_dma_rx_cb() against the
  stop with a dedicated rx_submit_lock, replacing the bare
  READ_ONCE/WRITE_ONCE @stopping fence (reported by the netdev Sashiko
  AI bot).
- Update the commit message to describe the race and its fix.

Changes in v2:
- Free outstanding TX/RX buffers on the dmaengine stop path (the original
  fix), and drop the redundant dmaengine_synchronize() calls that
  followed dmaengine_terminate_sync() (Jakub Kicinski).

v3: https://lore.kernel.org/netdev/20260924085441.74012-1-suraj.gupta2@amd.com/
v2: https://lore.kernel.org/netdev/20260917100525.250952-1-suraj.gupta2@amd.com/
v1: https://lore.kernel.org/netdev/20260910141946.3017164-1-suraj.gupta2@amd.com/
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  7 ++-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 51 +++++++++++++++----
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc..c63d99686d0b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -523,8 +523,9 @@ struct skbuf_dma_descriptor {
  * @stats_work: Work for reading the hardware statistics counters often enough
  *              to catch overflows.
  * @dma_err_task: Work structure to process Axi DMA errors
- * @stopping:   Set when @dma_err_task shouldn't do anything because we are
- *              about to stop the device.
+ * @stopping:   Set when we are about to stop the device: makes @dma_err_task
+ *              a no-op (legacy DMA path) and fences RX descriptor
+ *              resubmission in axienet_dma_rx_cb() (dmaengine path).
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
  * @eth_irq:	Ethernet core IRQ number
@@ -545,6 +546,7 @@ struct skbuf_dma_descriptor {
  * @tx_ring_tail: TX skb ring buffer tail index.
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
+ * @rx_submit_lock: Protects RX ring resubmission vs teardown in dmaengine path.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -626,6 +628,7 @@ struct axienet_local {
 	int tx_ring_tail;
 	int rx_ring_head;
 	int rx_ring_tail;
+	spinlock_t rx_submit_lock;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..c846aede1bd8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -881,6 +881,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_update_end(&lp->tx_stat_sync);
 	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
 	dev_consume_skb_any(skbuf_dma->skb);
+	skbuf_dma->skb = NULL;
 	netif_txq_completed_wake(txq, 1, len,
 				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
 				 2);
@@ -1171,6 +1172,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
+	skbuf_dma->skb = NULL;
 
 	if (IS_ERR(app_metadata)) {
 		if (net_ratelimit())
@@ -1193,10 +1195,17 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_update_end(&lp->rx_stat_sync);
 
 rx_submit:
+	spin_lock(&lp->rx_submit_lock);
+	if (lp->stopping) {
+		spin_unlock(&lp->rx_submit_lock);
+		return;
+	}
+
 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
 				   RX_BUF_NUM_DEFAULT); i++)
 		axienet_rx_submit_desc(lp->ndev);
 	dma_async_issue_pending(lp->rx_chan);
+	spin_unlock(&lp->rx_submit_lock);
 }
 
 /**
@@ -1541,6 +1550,7 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 	lp->tx_ring_head = 0;
 	lp->rx_ring_tail = 0;
 	lp->rx_ring_head = 0;
+	lp->stopping = false;
 	lp->tx_skb_ring = kzalloc_objs(*lp->tx_skb_ring, TX_BD_NUM_MAX);
 	if (!lp->tx_skb_ring) {
 		ret = -ENOMEM;
@@ -1752,20 +1762,42 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
 	} else {
+		struct skbuf_dma_descriptor *skbuf_dma;
+
+		spin_lock_bh(&lp->rx_submit_lock);
+		lp->stopping = true;
+		spin_unlock_bh(&lp->rx_submit_lock);
+
 		dmaengine_terminate_sync(lp->tx_chan);
-		dmaengine_synchronize(lp->tx_chan);
 		dmaengine_terminate_sync(lp->rx_chan);
-		dmaengine_synchronize(lp->rx_chan);
-
-		for (i = 0; i < TX_BD_NUM_MAX; i++)
-			kfree(lp->tx_skb_ring[i]);
-		kfree(lp->tx_skb_ring);
-		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
-			kfree(lp->rx_skb_ring[i]);
-		kfree(lp->rx_skb_ring);
 
 		dma_release_channel(lp->rx_chan);
 		dma_release_channel(lp->tx_chan);
+
+		/* Unmap and free any buffer the terminate did not reclaim, so it
+		 * is not leaked; a non-NULL skb marks such a slot.
+		 */
+		for (i = 0; i < TX_BD_NUM_MAX; i++) {
+			skbuf_dma = lp->tx_skb_ring[i];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_sg(lp->dev, skbuf_dma->sgl,
+					     skbuf_dma->sg_len, DMA_TO_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(skbuf_dma);
+		}
+		kfree(lp->tx_skb_ring);
+
+		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
+			skbuf_dma = lp->rx_skb_ring[i];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_single(lp->dev, skbuf_dma->dma_address,
+						 lp->max_frm_size, DMA_FROM_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(skbuf_dma);
+		}
+		kfree(lp->rx_skb_ring);
 	}
 
 	netdev_reset_queue(ndev);
@@ -3071,6 +3103,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
+	spin_lock_init(&lp->rx_submit_lock);
 	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
 	lp->rx_dim_enabled = true;
 	lp->rx_dim.profile_ix = 1;
-- 
2.25.1

