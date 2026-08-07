Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354E3F8254;
	Fri,  7 Aug 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099530; cv=fail; b=ScXXTNfh2IT2PKlJ/zw+7DW8Pdm6q+63xffyiUmPvSCcIOJbRZpqRv9r5uJdHnUEa33wN4TXYH3hQJqFgfsfqCqrP1v8dADEc51qKPAmJVyAr17W1Lg3KvJ1ks2IKtP850KItj0EFesRyLSUGx/gQgS1BGyGUgeeeY6FajxR/3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099530; c=relaxed/simple;
	bh=UiU3tFN537uyleTd7V5ZiBeSOVkhT5DiXveu+PLTDy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBZwp7GLsW9UlkZctDfLSTXx1rfkazKtvtRmZ2fC7uf4SHFPmDZSNt7Ps9bN2Ud9Gi7rm50PiZZaRkUbsNlTdC2SlbUNRMbfoqdf63reBh1RTi+gkWU1oExj60jmc6JQ+xGFHw7FzmG6aUh305Q6X/i8sAIJihiQJLao8SwC6ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lj6e8cu9; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lj6e8cu9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXj8dFMG/cj/ugm7nsCo8upZY9BV6UjDV92IcvFwSfO1Il7yql0nc+HPI00tvFag3k3cd2NkBepe5GoWFfFrF58ZvWqOgTmdoIos00QolBK8+JNWOEAqS0AbrViadPelGd6IEKpkflUyqsedpMD48mTBDL2A3dz/mfCbdUZwiol/cj8z6yUdYsKbvTdXwMDpkVhHZdASMU8cVNuRIBPJcBGr9TqTrJ+aSIJPoWxt4ypUukNIl5HgDNXqILQTFGXbDas93VrAeCbzrnb9zjlBRKpJRyEzJK4ZwLPwpabzFLBnJ2wIY2AVhJzzasyg0CGq+fYhne96oyUE9wIEyCNI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWSMB89lny2+NMlqwqsh9DqJnKEzeM3Z8dwn3yQxYrY=;
 b=EeujGCZ4oC0dIt4wxyWdILEL93HLkLF7dWjH1HPJvG9M0U0A+gqf3x0QMH+s6o0jmDPbB/zjW+0YsSRZ/QY9sH6peBmTmPG2/rGgJaV1F1V6hR48rL2SturpbgkpG0MlknbUtRAUV7irW9gaG4LC32qdXNA6eYTcxOZS1kGUla0y+xOM1Ccph2KF9XHnAUxZ/vy0tKbQXZx13nGgWVhwQGKyREr/W3oZnxxGSaGlYG3NGPa2TvIxi/SAx7X/bQV6GH93OTaNit3huPihRLikiUaDDMr7tSZN1QYmMXkeXZAds+HzDgSyuTU2siodNWMC1g+OECQMm/Ub3LyQOv9C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWSMB89lny2+NMlqwqsh9DqJnKEzeM3Z8dwn3yQxYrY=;
 b=Lj6e8cu9/x51FmLNq5g7AHshz0uB8UC3jn+feD940cfTC1jUsXqIEWge3btJ8d0fXnasWSaHXMwIOg/dmFG4cuPa/H1IcCrVJ0/BIjYvFYjqZl1nJ4QiWa9F3aooHG3oTbtu/JOeBZ+vA1dB+mRm5dqkgdORxTjBlqeR3NqU17s=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Fri, 7 Aug
 2026 10:45:23 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::8f) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 10:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:45:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:16 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:11 -0500
From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git-dev@amd.com>, <nagadheeraj.rottela@amd.com>
Subject: [PATCH 07/20] net: xilinx: tsn: add the endpoint TX data path
Date: Fri, 7 Aug 2026 16:14:18 +0530
Message-ID: <20260807104431.157230-8-nagadheeraj.rottela@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: f61ba497-c98e-4b64-b72b-08def470fbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V12IWZ2zOKKkFhXNrionyfKbS2++D2Akge5PDRnan0vxzUcoQvXunswNNnrzF6XqnXUMPzXu6stPooCVgZs8jI6SQF0A42W30mxUkrmXG8C30m5EAQ+zqcbrZph4uRIaZt6dSy2+h5jJ+qyLtndAX8IM6FvtHQQy8fPimrii63FyFnAhYQ8IUNCe8QwDvHfP4tzozHyMGuK7IckZsQJzFQhHLa9ANzwB61QpUv+TuzSZ5jvsPXpVw1uaH6d/9a7c+DYajxHXJ91nt8QEwJncALvMVhVDRFytCnjopmsBOTRhwiphP7s6IvgyiNkFDxF27LMT0yjzMWbJrdRViMnv5u/ktgmVO5XLU9vTVOqnun+wq5faaDuhRkWWoGhb5Agsk2DyT3EPENo5FxyL95h1UWz/XcEaIGEE1xKFUeKOLyWWsucZSWVreS1DOp4vE8Knuz7r/Tp/q39eTei5pBG+geo0tQt2/wv9GK+yjs78Y+LMVjBKKAeajEVwlnZTX7BN6PyOMR6lJPnx73Ts3kGsmWNVKoCEpPlSbUZJrWQDHCNgOMoWoRw2RCfjYQbJbc3UMXIIQls9+P7JpltgA+o5xvQ5NLY1siU0EWDgdO0g/YRFEvjqgEBxkkLqj5yA1ZJLJnWgp4gn7tF481LsP2DY0MmZG6ta8OEY09iDvuwXW5x8wxiqXQIPSw59S/GHX6eVEvSQzIEvWaqSoCMJqmdGYasBnqt5y0aiM7+kq8CFnNm1x+BkM643djszGDueTw+e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8tFq4JfGYmQUSHCDe4UywnEtxTfNnYu8gVuXJYTL+y4q4P0uRgQvsfyStzAsg85hdpP9AzEGjVSxPfZx0pyUSyk13rZnPVfx2dzV2HZ/kOp34jr6FxYjsVb1jjoKepCE2rsDXyHp0wYPVfZCS0NZm/kzuuUFnESRDe/yHwWsc62zfIomy6Sk1zJAW/3yDjmlnZdwlHGUmlY+uhEa2FFFF4P8DNPvPvZ5dQncEUs/L772PWdNVur7PINthJOJRyW6rSpz2UpEu36QNyB7u3PDkRjK1cyZt+SxgTTzmGyrR+qDCHJCB38ErlZR2XKVklPBQch0/DzAOjRF9BAYCcUMsR/LL5lrUFYwFm4nH6L7lPVOmGQXzZ/su4hQX/S6+1SQmlBEePelvYTovyR34hpWwzNI3ZTlANWB4PTJkUIK9cJfINlRVYTtli9fp4elrXS+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:22.9617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ba497-c98e-4b64-b72b-08def470fbc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

From: Srinivas Neeli <srinivas.neeli@amd.com>

Add the transmit path so the endpoint can send frames.

Look up the physical DMA channel for the frame's queue through the map
built at probe, map the frame and submit it to that channel. Stop the
queue when the ring runs out of space, and wake it from the completion
callback once a slot frees up.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 207ca3242a12..7615d27f3b36 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -29,6 +29,8 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#include <net/netdev_queues.h>
+
 #include "xilinx_tsn.h"
 
 #define DRIVER_NAME			"xilinx_tsn_ep"
@@ -97,6 +99,7 @@ struct xlnx_tsn_ep_dma_chan {
  * @ndev: the conduit netdev ("ep")
  * @dev: backing device
  * @regs: EP MAC register window
+ * @tx_lock: protects TX ring head/tail and SKB ring slots
  * @num_tx_queues: number of TX DMA channels (one per priority)
  * @num_rx_queues: number of RX DMA channels
  * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
@@ -110,6 +113,8 @@ struct xlnx_tsn_ep {
 	struct device *dev;
 	void __iomem *regs;
 
+	spinlock_t tx_lock;	/* protects TX ring buffers */
+
 	u32 num_tx_queues;
 	u32 num_rx_queues;
 	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
@@ -268,8 +273,145 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	dma_async_issue_pending(xchan->chan);
 }
 
+static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct xlnx_tsn_ep_dma_chan *xchan = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct xlnx_tsn_ep *ep = xchan->ep;
+	struct netdev_queue *txq;
+	struct net_device *ndev;
+	struct scatterlist *sgl;
+	struct sk_buff *skb;
+	int sg_len;
+	int len;
+
+	scoped_guard(spinlock, &ep->tx_lock) {
+		skbuf_dma = ep_get_desc(xchan,
+					xchan->ring_tail & (TX_BD_NUM_DEFAULT - 1));
+		if (!skbuf_dma || !skbuf_dma->skb)
+			return;
+
+		skb = skbuf_dma->skb;
+		sgl = skbuf_dma->sgl;
+		sg_len = skbuf_dma->sg_len;
+
+		dma_unmap_sg(xchan->dma_dev, sgl, sg_len, DMA_TO_DEVICE);
+
+		skbuf_dma->skb = NULL;
+		xchan->ring_tail++;
+	}
+
+	ndev = skb->dev;
+	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
+	len = skb->len;
+
+	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
+		DEV_STATS_INC(ndev, tx_errors);
+	} else {
+		DEV_STATS_INC(ndev, tx_packets);
+		DEV_STATS_ADD(ndev, tx_bytes, len);
+	}
+
+	dev_consume_skb_any(skb);
+	netif_txq_completed_wake(txq, 1, len,
+				 CIRC_SPACE(READ_ONCE(xchan->ring_head),
+					    READ_ONCE(xchan->ring_tail),
+					    TX_BD_NUM_DEFAULT), 2);
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct dma_async_tx_descriptor *dma_tx_desc;
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	int queue = skb_get_queue_mapping(skb);
+	struct xlnx_tsn_ep_dma_chan *xchan;
+	struct dma_device *dma_dev;
+	struct netdev_queue *txq;
+	int sg_len, nents, ret;
+	u32 phys_chan;
+
+	if (unlikely(queue >= ep->num_tx_queues)) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Invalid TX queue %d (max %u)\n",
+				    queue, ep->num_tx_queues);
+		goto err_drop_skb;
+	}
+
+	phys_chan = ep->tx_dma_chan_map[queue];
+	if (phys_chan == TSN_DMA_CH_INVALID) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Logical TX queue %d has invalid DMA mapping\n",
+				    queue);
+		goto err_drop_skb;
+	}
+
+	xchan = ep->tx_chans[phys_chan];
+	dma_dev = xchan->chan->device;
+
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	txq = netdev_get_tx_queue(ndev, queue);
+
+	spin_lock_bh(&ep->tx_lock);
+	if (CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
+		       TX_BD_NUM_DEFAULT) <= 1) {
+		netif_txq_try_stop(txq,
+				   CIRC_SPACE(xchan->ring_head,
+					      READ_ONCE(xchan->ring_tail),
+					      TX_BD_NUM_DEFAULT),
+				   2);
+		spin_unlock_bh(&ep->tx_lock);
+		if (net_ratelimit())
+			netdev_warn(ndev, "TSN TX ring full\n");
+
+		return NETDEV_TX_BUSY;
+	}
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (TX_BD_NUM_DEFAULT - 1));
+	if (!skbuf_dma) {
+		spin_unlock_bh(&ep->tx_lock);
+		goto err_drop_skb;
+	}
+	spin_unlock_bh(&ep->tx_lock);
+
+	sg_init_table(skbuf_dma->sgl, sg_len);
+	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
+	if (ret < 0)
+		goto err_drop_skb;
+
+	nents = dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	if (!nents)
+		goto err_drop_skb;
+
+	dma_tx_desc = dma_dev->device_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+						    nents, DMA_MEM_TO_DEV,
+						    DMA_PREP_INTERRUPT, NULL);
+	if (!dma_tx_desc)
+		goto err_unmap_sg;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->sg_len = sg_len;
+	dma_tx_desc->callback_param = xchan;
+	dma_tx_desc->callback_result = ep_dma_tx_cb;
+
+	spin_lock_bh(&ep->tx_lock);
+	xchan->ring_head++;
+	netdev_tx_sent_queue(txq, skb->len);
+	netif_txq_maybe_stop(txq,
+			     CIRC_SPACE(xchan->ring_head,
+					READ_ONCE(xchan->ring_tail),
+					TX_BD_NUM_DEFAULT),
+			     2, 2);
+	spin_unlock_bh(&ep->tx_lock);
+
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(xchan->chan);
+
+	return NETDEV_TX_OK;
+
+err_unmap_sg:
+	dma_unmap_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+err_drop_skb:
 	dev_kfree_skb(skb);
 	DEV_STATS_INC(ndev, tx_dropped);
 	return NETDEV_TX_OK;
@@ -304,10 +446,13 @@ static int ep_open(struct net_device *ndev)
 static int ep_stop(struct net_device *ndev)
 {
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	unsigned int i;
 
 	netif_tx_disable(ndev);
 	WRITE_ONCE(ep->closing, true);
 	ep_exit_dmaengine(ep);
+	for (i = 0; i < ndev->num_tx_queues; i++)
+		netdev_tx_reset_subqueue(ndev, i);
 
 	return 0;
 }
@@ -657,6 +802,7 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	ep->num_tx_queues = num_tx;
 	ep->num_rx_queues = num_rx;
 	ep->max_frm_size = TSN_MAX_VLAN_FRAME_SIZE;
+	spin_lock_init(&ep->tx_lock);
 
 	for (i = 0; i < TSN_MAX_TX_QUEUE; i++)
 		ep->tx_dma_chan_map[i] = TSN_DMA_CH_INVALID;
-- 
2.34.1

