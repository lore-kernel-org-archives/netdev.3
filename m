Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76449EC76;
	Thu, 10 Sep 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050023; cv=fail; b=dj/H4G/msWRuU1BCjgx8R29t7ShmxABdGNqPx4v9BYTQDdEYvqjwsG2L8a0OR0DijZeXvNZU2B6hosf3nkuEfYFvpD3UoxTwGNZoA00fst+SP2FhEDn8jF7/5C3++B2Bh9WsOHFmULKCHqfe7fZskmW3HL73wGY940uMGmoZhMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050023; c=relaxed/simple;
	bh=POyED6gLzH43cBYCxR9VWLmx/+DHfQ/qZa7doVD5DXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwoswwoNqcueQsgMV7lQZN0WBSeriYl0jXGFMZs4a/l0asamF/FZjspaN5ptPdk2DWmjI3xCU4/676HLYclfSSelHNg34YYhvJatdb2L6MldRaeKqKrsJTBqAHFH+yvvGPrSrVhb0jXemE6iWDhcPzPf70HBMGGHaTXRiJGkt/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5uNtJm5g; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5uNtJm5g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ/lf2liQ1UrUl+KE2g0FT0D+1KCaihkvbt7e/ShY+eLnCZpz/mXHixcYBYb+Tx7RedLtY1CQiBq/ctXfICmIssqn/wWbFYKxYRajJlLo6m97Acw6ZOf73Pq7UMa/bXgeT61CUyYEXpQtZEwsDcb4tBu5ai6UKYUs20TDFBGpdOM0gz2GFyY8CqXow9AJEAOuZ7eNLMlyltDIJjFHlco0iTF7O8UGrjtz3hOzs+6w0LMmt8gXw/Y0OoD96Cku8h5JtiCc4IOZUS+4pM3YaDKW924rT2fsgUWNUCp/TkwpmkVWLu1FmdHrG9aOnbIkNBar8axl8l4ZPqR6svJRgoKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gAAAdQMr1QJE3GRXXXmrwJFYQwrrCMUm2tIURAs440=;
 b=RNjwtws7AH0I5b0F9LHL2/T2g9VvrhnlwqDrWih4F2cEigMy0wWYB7oI0HH4sWwZqWM3FtCmtNkM7tsfkcAaof1TVtCEKLqsLaRvC71XNBI2IJpoYEIooBaSxm5tW1MFzo/V/swCKCG+ds3u4piauhasj1z40INyN6qqSw/9Tifle8Y3Jad/PB0k+XJun3aTraD5DGsihOuON74c5iYka8Vr3M2Is6HL6uvwJbp6kntW7kyiA3YXeN4dKeeTH/nliZ/IozSIwD63kcc6OlB6ORcw+wR+vCFWRkOnGWh62xK5lQWIIVXM5ro6rQ+zZYEQi5j2yP/vcC7TPUZoD8rh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gAAAdQMr1QJE3GRXXXmrwJFYQwrrCMUm2tIURAs440=;
 b=5uNtJm5g+4lxtXVm9AL+8DlUX32i054p3xkZxsh198NpGfTXXohvRuisKgCRYUPtEEhVo5j+v0NSnBexXfl0Ffw8J9Vr0EUdhBpyeAoN4ogGSQyxwMCu4gs1QCBBLDATeRGorVfd0GXa80KmG+YkV8fs/SZ/LhLGRydxBUg5/pg=
Received: from BL1PR13CA0385.namprd13.prod.outlook.com (2603:10b6:208:2c0::30)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 14:19:55 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a9) by BL1PR13CA0385.outlook.office365.com
 (2603:10b6:208:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu,
 10 Sep 2026 14:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 14:19:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 09:19:54 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 09:19:51 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Michal Simek <michal.simek@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
Date: Thu, 10 Sep 2026 19:49:46 +0530
Message-ID: <20260910141946.3017164-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ebe028-72dd-4c21-55c5-08df0f469622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	8z7qBTxshVwKt1612zpsThiaI1A5oLqXqfJ1nWjJKmsUWRsw1+6hsCja9WpKZxf+0+jCVVhumZGy99jQh6naMNhRR9/M2hGzS0eVhhSSf1cdsJ+Emr5MGNSssJT2uJ6XD6nsdD419yb/aswtCknDUHoZgUDExSIO+N/xEXtjB3hfg8v9VdV7nh2PamhIDZaTimciUnSnWS6PY85RHZymFBoP9bk8OKPVbpBcvrqN8oj+Sqv/6P4q7oLhZb9XrJrVKnwtO5t07S1JgDYZQZQiyNKndXXJeCDssO7eYYvLXJECUSUAZqNO5NUuoMSBWV1PfPklXkfVZMh0KsIXFDPbD42SrmR0S6ZCBSHFflTeFxtXfVhd4rI8V/JGUGtMsWJxELktnURtL9SQWxYYVZJc3u56VbWRg1t6w4/so+bQV1zmZht0Yn83Or/ORWkd9J0bsOx6ThjCS5vhw9dqWhPJehH59XzRCsbN4NXhepcF1mrVfj7JxXtST8ZLl7giGEbH76LPia0sLIjxxeXGOUQjalbwO5WyRSue+Ou000iqbd6UweNlJpoIH6U7UMiDnyYJca+4IenAlhxf/Q/YLeh1fFBhO/n3H13hBD5YtdcMk4Kp/FLcdBRsabAoKR0Zhbb7/7mc7krgHljIQizF5JvLGQPISJ1LEDfXt/NS9D7bidCizNJuJZjlfDH/yQAj1Ds/g5vZnffk6vlphFzDdnVyGQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4+Cytbwhh78r1cZw80cqhgINDNp3C0NVidOYPfj+v5bOTXwpxaXuMuSuHa2GXawvLTZg4VSjXsqM4pb85oxLXN6+k5Bsh9xeDPD9rpeC71XR5PSjlDKyuW5uvIVrLAFuLsWO37k5rw4M3MNesk4F+/vqQrkYy5FC3R3pKTBsyPSrHRj5OqacfSJhOvL1hIfjow1i3mtsoxaaLnGCiCHRlZH6tuiQ6cq4VUhn4gHuiltTa83gbFQOe24YGYpfT2ZEMWNbmwFhfhVQ4XxKMxM9qMDwIObCfQvGEaJXSH/F3TTi3LlWd4iA6wAhsZwz+MqD/8scfFYXFSCzsKHgqBtpR3W3QIOTR/xl3W/zBFXL+6FE923IglBaXNZSXk7VZlIecSiMwE8byWIYFotZ72pOvuZ+UjHFY+SC4ru+1Oc7BQyu3L39B9Q/s9iMptllM9Lv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 14:19:55.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ebe028-72dd-4c21-55c5-08df0f469622
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

In the dmaengine path the driver pre-submits RX buffers (and holds
in-flight TX buffers) whose SKBs are allocated and DMA-mapped by the
driver and reclaimed only in the completion callbacks. On ndo_stop()
the driver calls dmaengine_terminate_sync(), which aborts these
descriptors without running their callbacks, and then frees only the
skbuf_dma_descriptor ring shells with kfree().

As a result every SKB still owned by the DMA engine, together with its
DMA mapping, is leaked on each interface down. With RX_BUF_NUM_DEFAULT
(128) RX buffers pre-posted per channel, an ifup/ifdown cycle leaks up
to 128 SKBs and their DMA mappings; on systems with a limited IOMMU
aperture the mapping leak can eventually exhaust the address space.

Clear the ring slot's skb pointer in the TX and RX completion callbacks
so that a non-NULL skb reliably marks a slot that still owns a live,
DMA-mapped buffer. On stop, after terminating the channels, walk the
whole ring and unmap and free every such buffer before releasing the
rings, mirroring what the completion callbacks do.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Cc: stable@vger.kernel.org
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1722b7038f34..7828fbb09dc8 100644
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
@@ -1752,16 +1754,40 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
 	} else {
+		struct skbuf_dma_descriptor *skbuf_dma;
+
 		dmaengine_terminate_sync(lp->tx_chan);
 		dmaengine_synchronize(lp->tx_chan);
 		dmaengine_terminate_sync(lp->rx_chan);
 		dmaengine_synchronize(lp->rx_chan);
 
-		for (i = 0; i < TX_BD_NUM_MAX; i++)
-			kfree(lp->tx_skb_ring[i]);
+		/* dmaengine_terminate_sync() aborts the descriptors still owned
+		 * by the DMA engine without running their completion callbacks.
+		 * A ring slot owns a live, DMA-mapped SKB iff its skb pointer is
+		 * non-NULL (the callbacks clear it on completion), so unmap and
+		 * free those here. Otherwise every outstanding TX/RX SKB and its
+		 * DMA mapping is leaked on ifdown.
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
 		kfree(lp->tx_skb_ring);
-		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
-			kfree(lp->rx_skb_ring[i]);
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
 		kfree(lp->rx_skb_ring);
 
 		dma_release_channel(lp->rx_chan);
-- 
2.25.1

