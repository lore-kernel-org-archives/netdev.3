Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6C42B746;
	Fri,  7 Aug 2026 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099528; cv=fail; b=IHO/eu/2aaR3kJeYReim04wKKmeEimn4diF6RgZyTfaSQ2tmyBJfXP2weqYjJVKS7kbEQarVArST3sDeXu0WK+zVpZbVZ5z7B9OtoTv5txAVibJ1lmKkXcCUYSAAuFO+d+OBD7TP0hqNtSswkGBeftmfp14qOLFWFWGdwTZDSAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099528; c=relaxed/simple;
	bh=kD1xruRi+XdDUifA+83J28TvxbL3wCYZ4ZyJ0xmIehg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPA8lrNDlxflyJu9wl1WxLA+aSgaiF2jDaA+bVYQ1I2DZFCkpvS0oMY7lVDbXFgGIt3lQHB1aKh5LQZT/Q5/KzTKudl4CgrbiA6DZAt1JMDAoQwQZj93y16HRWZVkDS+eTv2poGK61a72eLqnnM4mbPqH0vzqUtCTD8Gkh4Ndg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yyQrLZL/; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yyQrLZL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhE104VYvXVfmUd+iKCFAI8YaZno+Gwhx/IKmfO/34nagwgzPTp0oMrmM4NsNSu4UdI/LZggbcRADUzH/UtwmZWDkY7Y/C7QBkrelBG6Y/JETICr/47QoeK9aFCY3jKm7mchu3Dr4R65HYFmOMRgZ21AYPgtCg0HTp/3FQWckRCgLqMl07X/41urg8c2XGYnQ+DV4/jLIt6RSWHf5QpmuqLMX1uCSOfHkLMdkWPraWfcqWGAxXNrakJqFmP7dAeOZfaVUk5GbqjglKUpR1iPYTlJN4nlM7NpFf8IM3GN6PE141t9INjz1xrA0ubsWan+K/+yBNjycy2aMcwUJWKQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7YqW8RqVCsY7BihRJc5llFw0kBsE6hvfXegAWfrUg8=;
 b=fXkoW8nigcCw8QoX0wDc/+8qfRgpA4SrBn2w9TkQRwe/fFmHkggMZ8VlyiHBINg+6yVS66FxkzVWQHMQCKnpPQBJLJwrmRSMlUhB5sGuNZkaTjH6tJYrUaeNQb6g1L4tryumQTM4h/7uhmOWScbWiV8iVF85fCX9SbS/ohko2ZBiGXx6l+OLut8E9BB/WzIjhdxFZiYQJD6mm7A9DKvFlCrwf7q9qUuPLoLtDPsdFANvnYQ7VpmxD1kmjqJylOEm/oHql6QApdWt2p9hNY8OGHk3OBpr+x82ucbSas4wlxgatZFbTC7wpYCHT+EQwhd/fhPf+z0axbOFtEgF701lvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7YqW8RqVCsY7BihRJc5llFw0kBsE6hvfXegAWfrUg8=;
 b=yyQrLZL/3nmFFtPvFftaHOpsrMqtWJLNtlsCC1bvI3vgU/rZcXhJpemilaYz39kxiMNM991uBVTPy78hUqRnvWlA/v3sMZCfDqlP17GDAIZA9JyfQbqWiETSL//aEKxWFDRI/YkifHKsAqiyli01iRN++bH32idHOaoIObxMU6w=
Received: from SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::18)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 10:45:19 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::8b) by SJ2P220CA0008.outlook.office365.com
 (2603:10b6:a03:5da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 10:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:45:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:10 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:05 -0500
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
Subject: [PATCH 06/20] net: xilinx: tsn: add the endpoint RX data path
Date: Fri, 7 Aug 2026 16:14:17 +0530
Message-ID: <20260807104431.157230-7-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 667d6715-d178-47a6-87b0-08def470f947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|921020|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dS2Y1+NxCrXEYO7Ihl7pFRFe5De4FJ6qQMhOjXLVFE13Y8Um2Wy0LRn8XXKYVYXgHEhgQOpWD8JATWR7ONqGaSmNP9JFNcizBstiH083LzDnLgKCm3J97ApssPfVgV5sgJE6Fm3Y7JZhFrhThWDWO2Ncv1bCA2Z2+eHvK7zMJyZ9CeK8Yuds8y/5Ap5M2oxUyVWy8tS8oT5EGK/0z2Log490eOKVVNyMsHzi0CafG7zzRPdLHhukMJW79Ne6xquiXWhXWwpl2mvH/bNGeSLnRAQO5pIW4D1UDtzSY66JlxWlOIumNpHb+n/leO21ahijnRcWCIjZOvh6b78QjmrRJ7hZaDnrZPQSSZm7Zpw15bkxKhezlv4A0FqMkvTKAU4NCliAheI3cc2PTRNX9nxx+qHgyKFqOxw8i7b3tstUNf53Ad9y0feYQ35puJOhyEcDymXAn+zfeBIFfLPnRNQoIh7J+lAoHcBJ8EFwO35k3YbdBHsIBvJ82YtvrIEfLUuLqfwF5a1r7LMc4r19bS491wxrsNtV+2lRaLQZ/Px9637/Ic2mJ/2pht4027FxykIbRT2tvZrGu+DGlZDV23kWtBJeHj0JU9isNCvNSZoLrG6nLgHJcK9bENCzk8bpGhpRhWYSJlatd1ppgffy2mkGNHKM6cPQ+6YGUmpZ3oQnlMZDxUGxyXwH69+J0eZu+6k8i3M6AF4L0WpOIqqfsbn/Es2bHRkroFqSIU9qGv74bqpZwA+hlIl7eMP3+CoWz7gN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(921020)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	axZDcNXi8S8Q5J1V0qBIwr/SOJDpHDw4yOYRYfzzHj5DzsEgmHZebDdTE92sUqtfgvgicVSLbK/v2yRFUAoCtnShMGnNnNLe3/6fNC0B5NMIgiubqOziaSURnFezsIDZyGKHe/nnyZrraPUmm20PhEOT8aLZWh/d9TzYzm7FwyH/RBtkVFanEeRSTEusFlgh5ZwaUVu0lRkxVHi3FtxA7PVnvCWqmUt3Gi/wy4kytd68xmO+S0Ydr2gqzEAt4GxctDOxCNbWwSjym51+aAaKJ48DkugG37+NzbqQ0PDlKrq8KsDLfcaB8rr503vw8hMKzyJj6l1nX+Hiif71tPPYeaCVkRdPfs96RdT/JcmQjafP5KEu40cEFDGhFIA4+2g2wryWvMBg2/S/j7mf/FhmFCR7mS42Lvd6ltq9hr/KHE8XhE3/soMPZZBwPTr/9+Iq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:18.7813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d6715-d178-47a6-87b0-08def470f947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

From: Srinivas Neeli <srinivas.neeli@amd.com>

With the RX channels armed, the endpoint can start receiving frames.

Post RX buffers to every RX channel on open and reap them from the
completion callback. Each inbound frame carries a TUSER port_id in the
descriptor sideband. Accept frames from MAC1 (port_id 1) and MAC2
(port_id 2) and pass them up the stack. Drop any other port_id, since
the bridged-only model never produces it. Drop and count frames with
bad descriptor status, an invalid length or no metadata pointer.

Refill each slot from the completion callback unless the interface is
closing, which keeps the ring full without a separate refill worker.
Delivery to the correct DSA user port needs the per-port metadata,
which is not added yet.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 173 +++++++++++++++++-
 1 file changed, 171 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index fa21d59ade16..207ca3242a12 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/circ_buf.h>
 #include <linux/dma/xilinx_dma.h>
@@ -42,6 +43,17 @@
 #define TX_BD_NUM_DEFAULT		64
 #define RX_BD_NUM_DEFAULT		128
 
+/*
+ * The DMA descriptor sideband status word packs TID/TDEST/TUSER together;
+ * TUSER occupies the low byte, TID/TDEST sit in the upper bits.
+ */
+#define TSN_TUSER_MASK			GENMASK(7, 0)
+/* TUSER Input Port ID field (bits [5:4] of the TUSER field) */
+#define TSN_TUSER_PORT_ID_MASK		GENMASK(5, 4)
+#define TSN_TUSER_PORT_EP		0x0
+#define TSN_TUSER_PORT_MAC1		0x1
+#define TSN_TUSER_PORT_MAC2		0x2
+
 /**
  * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
  * @sgl: scatter-gather list backing the DMA mapping
@@ -115,6 +127,147 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
 	return xchan->skb_ring[idx];
 }
 
+static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result);
+
+static void ep_rx_submit_desc(struct xlnx_tsn_ep_dma_chan *xchan)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct xlnx_tsn_ep *ep = xchan->ep;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (RX_BD_NUM_DEFAULT - 1));
+	if (!skbuf_dma)
+		return;
+
+	skb = dev_alloc_skb(ep->max_frm_size);
+	if (!skb)
+		return;
+
+	sg_init_table(skbuf_dma->sgl, 1);
+	addr = dma_map_single(xchan->dma_dev, skb->data, ep->max_frm_size,
+			      DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(xchan->dma_dev, addr))) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "DMA mapping error on RX submit\n");
+
+		goto err_free_skb;
+	}
+	sg_dma_address(skbuf_dma->sgl) = addr;
+	sg_dma_len(skbuf_dma->sgl) = ep->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc)
+		goto err_unmap_skb;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
+	skbuf_dma->desc = dma_rx_desc;
+	dma_rx_desc->callback_param = xchan;
+	dma_rx_desc->callback_result = ep_dma_rx_cb;
+	xchan->ring_head++;
+	dmaengine_submit(dma_rx_desc);
+
+	return;
+
+err_unmap_skb:
+	dma_unmap_single(xchan->dma_dev, addr, ep->max_frm_size, DMA_FROM_DEVICE);
+err_free_skb:
+	dev_kfree_skb(skb);
+}
+
+static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct xlnx_tsn_ep_dma_chan *xchan = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	size_t meta_len, meta_max_len, rx_len;
+	struct xlnx_tsn_ep *ep = xchan->ep;
+	struct net_device *ndev = ep->ndev;
+	struct sk_buff *skb;
+	u32 port_id, tuser;
+	u32 *metadata;
+	int i, avail;
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_tail & (RX_BD_NUM_DEFAULT - 1));
+	xchan->ring_tail++;
+	skb = skbuf_dma->skb;
+	skbuf_dma->skb = NULL;
+
+	dma_unmap_single(xchan->dma_dev, skbuf_dma->dma_address,
+			 ep->max_frm_size, DMA_FROM_DEVICE);
+
+	if (result->result != DMA_TRANS_NOERROR) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "RX DMA transfer error %d\n",
+				 result->result);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		DEV_STATS_INC(ndev, rx_errors);
+		goto submit_new;
+	}
+
+	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
+						   &meta_len,
+						   &meta_max_len);
+	if (IS_ERR_OR_NULL(metadata)) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		DEV_STATS_INC(ndev, rx_errors);
+		goto submit_new;
+	}
+
+	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
+	tuser = metadata[1] & TSN_TUSER_MASK;
+	rx_len = ep->max_frm_size - result->residue;
+
+	if (rx_len > ep->max_frm_size || rx_len < ETH_HLEN) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "Invalid RX length %zu (max=%u, min=%u)\n",
+				 rx_len, ep->max_frm_size, ETH_HLEN);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		DEV_STATS_INC(ndev, rx_errors);
+		goto submit_new;
+	}
+
+	port_id = FIELD_GET(TSN_TUSER_PORT_ID_MASK, tuser);
+	if (port_id != TSN_TUSER_PORT_MAC1 && port_id != TSN_TUSER_PORT_MAC2) {
+		if (net_ratelimit())
+			dev_dbg(ep->dev, "RX dropping unexpected TUSER port_id=%u\n",
+				port_id);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		goto submit_new;
+	}
+
+	skb_put(skb, rx_len);
+	skb->dev = ndev;
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb->ip_summed = CHECKSUM_NONE;
+	__netif_rx(skb);
+
+	DEV_STATS_INC(ndev, rx_packets);
+	DEV_STATS_ADD(ndev, rx_bytes, rx_len);
+
+submit_new:
+	if (READ_ONCE(ep->closing))
+		return;
+
+	avail = CIRC_SPACE(xchan->ring_head, xchan->ring_tail,
+			   RX_BD_NUM_DEFAULT);
+	for (i = 0; i < avail; i++)
+		ep_rx_submit_desc(xchan);
+	dma_async_issue_pending(xchan->chan);
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	dev_kfree_skb(skb);
@@ -229,8 +382,18 @@ static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
 	if (!chan)
 		return;
 
-	if (chan->chan)
+	if (chan->chan) {
+		/* Drain the in-flight completion callback, then synchronize in
+		 * case that callback re-armed a descriptor before it observed
+		 * ep->closing. xilinx_dma_tx_submit() clears chan->terminating
+		 * on every submit, so a single terminate does not cover a
+		 * re-arm. The final terminate is a barrier before the channel
+		 * memory is freed.
+		 */
 		dmaengine_terminate_sync(chan->chan);
+		dmaengine_synchronize(chan->chan);
+		dmaengine_terminate_sync(chan->chan);
+	}
 
 	if (chan->is_tx) {
 		while (chan->ring_tail != chan->ring_head) {
@@ -291,7 +454,7 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
 {
 	int tx_allocated = 0, rx_allocated = 0;
 	char name[16];
-	int i, ret;
+	int i, j, ret;
 
 	ep->tx_chans = kcalloc(ep->num_tx_queues, sizeof(*ep->tx_chans),
 			       GFP_KERNEL);
@@ -329,6 +492,12 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
 		rx_allocated++;
 	}
 
+	for (i = 0; i < ep->num_rx_queues; i++) {
+		for (j = 0; j < RX_BD_NUM_DEFAULT - 1; j++)
+			ep_rx_submit_desc(ep->rx_chans[i]);
+		dma_async_issue_pending(ep->rx_chans[i]->chan);
+	}
+
 	return 0;
 
 err_free_chans:
-- 
2.34.1

