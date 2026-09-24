Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67B43B6CD;
	Thu, 24 Sep 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240098; cv=fail; b=uVIiDSzyLnASBzd3TZCYVIsMAS+ksWrKyyMQOqLFFivairdmrc0wUcgLDilOWH657c4JWzRrl5lsc04XCbKjT3gLiGuxoBKAqDu9Vp6QI2SiVL7lKUGOip8V+v4aeZR709xitLAF9teJe76NplWNAnyEkVncjlqc698jey1dHGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240098; c=relaxed/simple;
	bh=UZH2Ym9fzjM9DEzorQX9lNPo4m6NH6gPXbxPss2uQDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1bBqBuFGxHf3myJdtCEAwy1Hf61br+Bk0X1AnEPc0pcHVK17C44wdULQc8S6ghp3QiPduqInmniA2Iuulu4lzMLSUmgpmL/xkdInrkz9Gp39jIHb1ayc8dk10U6prNhfC6c+9A7KIcOC+1pLNvPkLYSjZX3sliINzWgwQAlLV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y2xWmbBA; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y2xWmbBA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/4ISYjQ6DaurJM2IZ9B+kjY3RKLOEPvpGvOlngZd1XtdkbiCmzEc3QIneqQcBZ00qNKunRD8uOqXhzkRY+IQJlztL52T9TeOpXq3N6PQuraDecOvduHiXwojOILHpq77VgMHwrLciLkiwQSLiFC26o0b2Oiflnwl46Z5x3z1WmlUQwDKh55ZQCE3LCvMjezkBhT4fuyCLHO2XeBpYOH+fzAlMlYvA35QgNmNjWVu42aJsaMDxPwQIrH0f04iXI88j9YIfbIrnOshLuew1Kww/U1sC6cRtu3U8FuQJVntSyoT+z9LrKmgRkWsfZivECjHdKaSMmJuHaxWrFpy9a6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkpq3ia8KZ7Ff2LM/9+pvLp/Ocu6nZdcRBGw9vurXI4=;
 b=SK8shUwat5IRrfkRTiR3KHuINPYmY/8sBBWmNJF6Uo0FEX5gE3pJet62L2tna2Rs+hTVAio3VL0jy0VaLAKkrJswfYRy631wozRo2vZtb/EVX6KxIbkbzeZ5q1TIbxP89D5VDoPFoMMdesIFa9v4rpH57vdOAyqhREG83AMSb3zzyIdLEbCG2Qm8RZrgp/ekXA4l53kNuNYi9b6QeO/Jv2dRrLuNrftRrh8tspOLi8Nxyz58L1u+/OXnPfy6MXpmSHpg/ARb47cUW/hDK4pL4hJvN3H2/8wf5wTx2X9Do01c3d6g7CIoW4h+UcaFZdDCIKNfaztDRTvxgTZxlCM3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkpq3ia8KZ7Ff2LM/9+pvLp/Ocu6nZdcRBGw9vurXI4=;
 b=Y2xWmbBA12/tcssrorSVmV/cWRzWwxCbouTNfyrd/L3NDaYr0AiREh1pUzNCvzFOVN86sphz4Viyc8uRcf3MT/SjHaXM3EoAmySTMR4Dq8jAtUpEEEd6TfzCb8QYrQTHNDg/Y5ONbb0AwK8YfIRk39+AIEBsuDQtjgqyvbXLznc=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:54:51 +0000
Received: from BN7PEPF00000091.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::94) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 08:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF00000091.mail.protection.outlook.com (10.167.245.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 08:54:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 03:54:49 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 03:54:47 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v3] net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
Date: Thu, 24 Sep 2026 14:24:41 +0530
Message-ID: <20260924085441.74012-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000091:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1f5c75-5fd1-4e48-e65e-08df1a197e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|18002099003|3023799007|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/io2m164S+VEJoH0q+aGunW62wxBDDr93+yG2cpAakg5GzG/SXT0CuVTR6aNDh8HvyL3SX3e8i+t+VqK0MoFpaqhB0Y0iUnAzlXkFMrJDOSp+lY6LrVcol0qCMrxipY0zojw+6gj7+bGa1Y5UpJ6VvIz+xpY5qRTGGu9ZbQ0zCNkP4a5m0KE6wSf9VAgBWleLBsBVeokXoLVOipW1UpP7lSbX4SEqJjwVtCRSDoKdPHi02OK6Sn+jTZyaa9kT6nCOSUEPXRJagY2K66EMUILkH5qtwEM4f1mrX9hOvs3SVXviRjKMhFzFYm3ZSSyYpXdKp6CrAP2OWYf4BGtx9bjLBR2e16lHVfj7pDWQh1ZWNdsDtI5v64UcJ1ArJCGCAKm/2gTpL8Wn8iWtc12JPlEDazLJJx9Q/1t0JcGVv2l5CJ9URlEDx+4Pk9KqYDcJlR/WVYzYPpPm+LTuy0USpT+4/4FKdHgE8x0aP++0Imgp4goQmPr9nMKoXBkyQ6wM/KDomPIv+RfBwTG2EQH2/YVN7MB/VkdTb+Bdkwc2dopiua4RkyFp8aAbi1kNh02LhwSy3ZIYVeDErLspd6fOxlmsGpMtUIqK9WsjkDCTpptyltmJjAHe3oOnec23hLYxXTso7/Hu99+5zRtKs4i05f+XYcy0HH2md7vu42fahPXC6naB9gbnnLFYsAAdNKJucJ1HyQJEwmV5gSlwpmlT19dmQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(18002099003)(3023799007)(13003099007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VuW0pwqbCLBphITZUCFO9qwIVFezB6zPli+Pcw/wF9iosZyKMNpFoWSDuh2YtInqjkRicKRT6+gtbAqWytDV8EKJO6OLIIEhuzWlradOerzrf6/Jc7G9JER7WXyQMOQZUiz+362DTwFrwmXXXDbF3zafzIE2dWR2Mzeh1iD8+E0Vkp/MT1DSIAMjVflkgaYCw+Wj3VAhxFds871EcHJxXv1bQn9nexqNfvs64bnUUysVlRJ7t/szCLPgT+2ufGMaMGF4VoHq1+LYSNdlT6Bi6MO/bPL8NE7dZZwUdkfE39bcZ3FVQeuhuZyLf2nvnDROP7mS1x9NLeEERUoYl/2kJI8txVPheEJZqrzBvL+wQrkxS+HlpZ1aeUimDEYF6DBSmaLYx85YICUUObf4JJFbU1vJle94l2Uquz58NlvwHH5mb0KrQHa5KwAGhstAwlWm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:54:50.2269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f5c75-5fd1-4e48-e65e-08df1a197e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

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
Changes in v3:
- Serialize RX descriptor resubmission in axienet_dma_rx_cb() against the
  stop with a dedicated rx_submit_lock, replacing the bare
  READ_ONCE/WRITE_ONCE @stopping fence. (reported by the netdev Sashiko
  AI bot).
- Update the commit message to describe the race and its fix.
v2: https://lore.kernel.org/netdev/20260917100525.250952-1-suraj.gupta2@amd.com/

Changes in v2:
- Free outstanding TX/RX buffers on the dmaengine stop path (the original
  fix), and drop the redundant dmaengine_synchronize() calls that
  followed dmaengine_terminate_sync() (Jakub Kicinski).
v1: https://lore.kernel.org/netdev/20260910141946.3017164-1-suraj.gupta2@amd.com/
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  7 ++-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 51 +++++++++++++++----
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc..c5c505269ec9 100644
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
index 782f903d318f..61d830e0e9b2 100644
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
+	if (READ_ONCE(lp->stopping)) {
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
+		WRITE_ONCE(lp->stopping, true);
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

