Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E142CAFC;
	Fri,  7 Aug 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099521; cv=fail; b=OUo7YtqVTIxxvi/lXIasg+yccaREwP9odD5pCEYlSQTibnZm+4zksFECh5ukvq6YJwIak8HiZl0/wBm9L1fuZ4sbbeHZPkXN0sqVOvXTfCUBG5tUIzb/Q58eVxVPsV/emBcEclB3N9l7t1DkFIdbPqVBZUQlg78f6HhQt3AoF7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099521; c=relaxed/simple;
	bh=7IiN7WEX4eerRphMITxeGDNf1+Oj5oE3/27Ztmj5//g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgMBOP6MyySEm4vp8x0IaQsbjESMX3tbJ/PXCpwd3yj343qRapeLYfQMmeDxFbnuYx0MT+tEr4kerixkPo3MAnnfBUbVlO7hpWUtvRUo1DgF5FSwgBeugURrQ0/zX9txZfQSyKcsBw2mzeWl9qqDUWjLtA/Tg7meUSJaxkzr598=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pPeGhjwT; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pPeGhjwT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh7K3E34HD29Ybfzl8vLou9nDLhtDe9qFRyEe8u1ar458Ilc1evH8YvPg0HKbUjbGNTxXHsDpHOz4tFeGXTHPJ7Uc5xw7LBBo9KgfWv9sT0yC+ji2eXfOrhgIzspgswVq+lsf8KBjY//0wq8uc+Okcbc4T5MubGbOMn7NnQREX2fOzxGq/Yc+TxyFAHsGUOVzuPaNRwW9rGP6eE6eEzcnYFiZ0E+Sw6jNEKEwP9QU3gDywPkLCGrOgp6MQEA64LiNSo4EHOIbPolygrtMLdhdDfQynujcba8DJBnYsblVqf47vRga2NPteOzXAaRm9x9G7aI6AId+SSoEtgvz1y6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4FTbUBPo/A855TyJNiIV2016LvcdHxqF2S9gCkk0Ro=;
 b=roydPjsn28vksm+k4Bn1kcN9tU0XUH6iQS2SbA6+/FLpPpATZ407SfBOwD6I6GJpyIlfZ+gLoOIz4H5IeCm64RpotNK+1YmLeQKEGhWddR5bojGLDVA7mdYlseWgHbFPb+IOfwz3tqdF2INsNEN+EevbfMTrHqDYBHRy5UgVDNUvhR5eX9XvbSSVxd5LR8b7l8aepsAiD3xP+TmPB2gxbq8921YKKooSV6XsE+qaTZEHVKf21ZxmliW8VNbZWaxaxm2hOVH8dcF9/W4dhfwK/L/uQzzi1YHMrpyKnG1IvJR50kZWJFHUzHdN6oJSMhrVPxmICR6C4H2HjF3M/7XdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4FTbUBPo/A855TyJNiIV2016LvcdHxqF2S9gCkk0Ro=;
 b=pPeGhjwTkGhXJCwRpaJPBVbZR9H3OEWuye0RLKduAlziK48NEbtWT+Ln0ekKfO5ki3fd33t+Fvr3ZUOMeSbJtUOJ0DAnVSQ8hR4cnqwSSX+d0mnaIUQDP+4x474HEh6ptAeTJZsS/n7DtlpOhcqn+LVPW8DKVeTtZeoGdGC6uV8=
Received: from PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::17)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 10:45:14 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::54) by PH7P220CA0082.outlook.office365.com
 (2603:10b6:510:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:45:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:05 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:00 -0500
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
Subject: [PATCH 05/20] net: xilinx: tsn: bring up the endpoint MCDMA channels
Date: Fri, 7 Aug 2026 16:14:16 +0530
Message-ID: <20260807104431.157230-6-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: f0022b7c-14f7-46aa-8f21-08def470f6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|7416014|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	PkTQKo7mzmOqzJ9dvLzdsqVQ0DhFHPr6VbqDbWaQpUtSJnKnZL8wQ/qi9Q5MpPPENl3vnu6aIWJbee1FOtSBCt5bMtXF/momZlhW6nfRK+pVvUqu5mioM98tQf+C9KZkLFmjcz5f6YWjmjsl3Z85/bVgTtS1JzdKiig5gq+nb+Gr9QqiPr543Rb94ch7JD4cLYmuEvr/DKLXiNMQ6hXyFJ/Q5ZDz/lZXJ+4jW39cXJ0ixO1jg0Y6WeRn4Y4T4A+am2vn/o1MxIre9ldsz+94Pqun+C8ZTR5k65bSwgkSdjIUG8VzHZ6fgnZoDt2VDPfUP7yQXZH/UYAoK3bvnLiR0Cb28H5TMW7IIdD5RPpQBzuWcbevCvpLEkn32zx9qwAqskCRoMLrBOevmVHTvYSBD0j0N57pdNOrML10szrBNXA8+mWDuUH1w6m8lPxt4sHyu/Z6WE2+0Yn766uOA3xF9mkaP0S3danq267foPpqOPj31x/cLjINh0SV0WR1/gJX24b20fuMPyFUImaLaLuHVsZiAM7z9TA+dDWejjDq0lU8FGPaGKbz+aItW1ZRClw+UjLDEaxztQy0RDuG/HXxwMuSGuZHY29jWMGMiWZ4+/x+QeQOmeb7LFGvfVeCEZ13QAY/CZszukZ6tFsqGBcb0PlhXwWhdkTRgvEaUiugxiOwxkGZP5FJkj9EzLdVFg1ivthXZkB3nmMWaa7l9i/zoI6bqrBOCT58giZwtAR5lvb8FU+CJs2DcuiGJkmDqoGG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4/tdOhYd8KV8F1aLunROk/YTTU563XNaFdmnLLf5z4iQ3KLYAMoMr38oyxHwqt+ZsrnlD6NWeslGFbI8Is8M4YRonRpnq/e0aaFA2NME2c80uKBUnaKJrLW0flIZ51zYO9DNz8C+QKoE0mJAnILZuoZ2twlwIN9JAAEE2b0jEDlwu/EhReq3uVgUxXTMSiUNKEX41kyl8BSwqUZg1sc9/7gmIk2smJve2w8wor4Qe73S4zgrGCSQRBB541shOyFN/Y9dWBFJh267bfxBvmhtQjB81css2qy3K7saAZUtlzrKVbWLngzESifDHmxgRxzKtp+6f2kprI4jmOhGq7mwh70jSK2Vp/UD3jRGEWaL141mCxb93h0nHeZX5br1+tTXwnKCvVDi4RhdbTG9Zj/pWImzBly4vjwiDR6bm+DCiNYssg1snQ16IAZrNeAPGdfi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:14.6816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0022b7c-14f7-46aa-8f21-08def470f6d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

From: Srinivas Neeli <srinivas.neeli@amd.com>

Before the endpoint can move frames, each MCDMA channel needs a ring of
buffers and a live dmaengine channel.

Request every TX and RX channel named in the device tree when the
interface opens, and give each one a ring of preallocated SKB
descriptor slots. Reset the controller through tx_chan0 on open, and
release the channels on stop. Add the XILINX_DMA dependency for the
dmaengine and Xilinx DMA APIs.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Kconfig       |   1 +
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 274 ++++++++++++++++++
 2 files changed, 275 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
index 45af4d3f10e6..551139a220ef 100644
--- a/drivers/net/ethernet/xilinx/tsn/Kconfig
+++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
@@ -6,6 +6,7 @@
 config XILINX_TSN
 	tristate "Xilinx TSN Ethernet driver"
 	depends on OF && HAS_IOMEM
+	depends on XILINX_DMA
 	help
 	  This driver supports the AMD/Xilinx Time-Sensitive Networking
 	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 062cb94c2153..fa21d59ade16 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -6,10 +6,15 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/circ_buf.h>
+#include <linux/dma/xilinx_dma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -17,6 +22,9 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -31,6 +39,47 @@
 #define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
 					 ETH_FCS_LEN)
 
+#define TX_BD_NUM_DEFAULT		64
+#define RX_BD_NUM_DEFAULT		128
+
+/**
+ * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
+ * @sgl: scatter-gather list backing the DMA mapping
+ * @desc: dmaengine descriptor handle
+ * @dma_address: physical address of the first sgl entry (RX path)
+ * @skb: SKB owning the buffer
+ * @sg_len: number of valid entries in @sgl (TX path)
+ */
+struct skbuf_dma_descriptor {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	int sg_len;
+};
+
+/**
+ * struct xlnx_tsn_ep_dma_chan - one DMA channel and its SKB ring
+ * @skb_ring: per-slot SKB descriptors
+ * @ep: pointer back to the owning EP instance
+ * @chan: dmaengine channel handle
+ * @dma_dev: device used for DMA mapping (the DMA engine, not the EP)
+ * @ring_head: producer index
+ * @ring_tail: consumer index
+ * @ring_size: number of slots in @skb_ring
+ * @is_tx: true for TX channels, false for RX
+ */
+struct xlnx_tsn_ep_dma_chan {
+	struct skbuf_dma_descriptor **skb_ring;
+	struct xlnx_tsn_ep *ep;
+	struct dma_chan *chan;
+	struct device *dma_dev;
+	u32 ring_head;
+	u32 ring_tail;
+	u32 ring_size;
+	bool is_tx;
+};
+
 /**
  * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
  * @ndev: the conduit netdev ("ep")
@@ -40,6 +89,9 @@
  * @num_rx_queues: number of RX DMA channels
  * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
  * @max_frm_size: maximum frame size accepted on RX
+ * @tx_chans: array of TX channels (size @num_tx_queues)
+ * @rx_chans: array of RX channels (size @num_rx_queues)
+ * @closing: set in ndo_stop so the RX completion callback stops re-arming
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -50,8 +102,19 @@ struct xlnx_tsn_ep {
 	u32 num_rx_queues;
 	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
 	u32 max_frm_size;
+
+	struct xlnx_tsn_ep_dma_chan **tx_chans;
+	struct xlnx_tsn_ep_dma_chan **rx_chans;
+
+	bool closing;
 };
 
+static inline struct skbuf_dma_descriptor *
+ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
+{
+	return xchan->skb_ring[idx];
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	dev_kfree_skb(skb);
@@ -59,8 +122,27 @@ static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep);
+static int ep_init_dmaengine(struct xlnx_tsn_ep *ep);
+static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep);
+
 static int ep_open(struct net_device *ndev)
 {
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	int ret;
+
+	WRITE_ONCE(ep->closing, false);
+
+	ret = ep_reset_dma_controller(ep);
+	if (ret)
+		return ret;
+
+	ret = ep_init_dmaengine(ep);
+	if (ret) {
+		netdev_err(ndev, "failed to initialize DMA engine\n");
+		return ret;
+	}
+
 	netif_tx_start_all_queues(ndev);
 
 	return 0;
@@ -68,7 +150,11 @@ static int ep_open(struct net_device *ndev)
 
 static int ep_stop(struct net_device *ndev)
 {
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+
 	netif_tx_disable(ndev);
+	WRITE_ONCE(ep->closing, true);
+	ep_exit_dmaengine(ep);
 
 	return 0;
 }
@@ -90,6 +176,194 @@ static const struct ethtool_ops ep_ethtool_ops = {
 	.get_drvinfo	= ep_get_drvinfo,
 };
 
+static struct xlnx_tsn_ep_dma_chan *
+ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, const char *name, bool is_tx,
+		  int ring_size)
+{
+	struct xlnx_tsn_ep_dma_chan *chan;
+	struct dma_chan *err_chan;
+	int i;
+
+	chan = kzalloc_obj(*chan);
+	if (!chan)
+		return ERR_PTR(-ENOMEM);
+
+	chan->chan = dma_request_chan(ep->dev, name);
+	if (IS_ERR(chan->chan)) {
+		err_chan = chan->chan;
+		kfree(chan);
+		return ERR_CAST(err_chan);
+	}
+
+	chan->skb_ring = kcalloc(ring_size, sizeof(*chan->skb_ring), GFP_KERNEL);
+	if (!chan->skb_ring) {
+		dma_release_channel(chan->chan);
+		kfree(chan);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < ring_size; i++) {
+		chan->skb_ring[i] = kzalloc_obj(*chan->skb_ring[i]);
+		if (!chan->skb_ring[i]) {
+			while (--i >= 0)
+				kfree(chan->skb_ring[i]);
+			kfree(chan->skb_ring);
+			dma_release_channel(chan->chan);
+			kfree(chan);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	chan->is_tx = is_tx;
+	chan->ep = ep;
+	chan->ring_size = ring_size;
+	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
+
+	return chan;
+}
+
+static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
+{
+	int i;
+
+	if (!chan)
+		return;
+
+	if (chan->chan)
+		dmaengine_terminate_sync(chan->chan);
+
+	if (chan->is_tx) {
+		while (chan->ring_tail != chan->ring_head) {
+			struct skbuf_dma_descriptor *skbuf_dma;
+
+			skbuf_dma = chan->skb_ring[chan->ring_tail &
+						  (chan->ring_size - 1)];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_sg(chan->dma_dev, skbuf_dma->sgl,
+					     skbuf_dma->sg_len, DMA_TO_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+				skbuf_dma->skb = NULL;
+			}
+			chan->ring_tail++;
+		}
+	}
+
+	if (chan->skb_ring) {
+		for (i = 0; i < chan->ring_size; i++) {
+			struct skbuf_dma_descriptor *skbuf_dma = chan->skb_ring[i];
+
+			if (skbuf_dma && !chan->is_tx && skbuf_dma->skb) {
+				dma_unmap_single(chan->dma_dev,
+						 skbuf_dma->dma_address,
+						 chan->ep->max_frm_size,
+						 DMA_FROM_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(chan->skb_ring[i]);
+		}
+		kfree(chan->skb_ring);
+	}
+	if (chan->chan)
+		dma_release_channel(chan->chan);
+
+	kfree(chan);
+}
+
+static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep)
+{
+	int i;
+
+	if (ep->tx_chans) {
+		for (i = 0; i < ep->num_tx_queues; i++)
+			ep_free_dma_chan(ep->tx_chans[i]);
+		kfree(ep->tx_chans);
+		ep->tx_chans = NULL;
+	}
+	if (ep->rx_chans) {
+		for (i = 0; i < ep->num_rx_queues; i++)
+			ep_free_dma_chan(ep->rx_chans[i]);
+		kfree(ep->rx_chans);
+		ep->rx_chans = NULL;
+	}
+}
+
+static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
+{
+	int tx_allocated = 0, rx_allocated = 0;
+	char name[16];
+	int i, ret;
+
+	ep->tx_chans = kcalloc(ep->num_tx_queues, sizeof(*ep->tx_chans),
+			       GFP_KERNEL);
+	if (!ep->tx_chans)
+		return -ENOMEM;
+
+	ep->rx_chans = kcalloc(ep->num_rx_queues, sizeof(*ep->rx_chans),
+			       GFP_KERNEL);
+	if (!ep->rx_chans) {
+		ret = -ENOMEM;
+		goto err_free_tx;
+	}
+
+	for (i = 0; i < ep->num_tx_queues; i++) {
+		snprintf(name, sizeof(name), "tx_chan%d", i);
+		ep->tx_chans[i] = ep_alloc_dma_chan(ep, name, true,
+						    TX_BD_NUM_DEFAULT);
+		if (IS_ERR(ep->tx_chans[i])) {
+			ret = PTR_ERR(ep->tx_chans[i]);
+			ep->tx_chans[i] = NULL;
+			goto err_free_chans;
+		}
+		tx_allocated++;
+	}
+
+	for (i = 0; i < ep->num_rx_queues; i++) {
+		snprintf(name, sizeof(name), "rx_chan%d", i);
+		ep->rx_chans[i] = ep_alloc_dma_chan(ep, name, false,
+						    RX_BD_NUM_DEFAULT);
+		if (IS_ERR(ep->rx_chans[i])) {
+			ret = PTR_ERR(ep->rx_chans[i]);
+			ep->rx_chans[i] = NULL;
+			goto err_free_chans;
+		}
+		rx_allocated++;
+	}
+
+	return 0;
+
+err_free_chans:
+	while (--rx_allocated >= 0)
+		ep_free_dma_chan(ep->rx_chans[rx_allocated]);
+	while (--tx_allocated >= 0)
+		ep_free_dma_chan(ep->tx_chans[tx_allocated]);
+	kfree(ep->rx_chans);
+	ep->rx_chans = NULL;
+err_free_tx:
+	kfree(ep->tx_chans);
+	ep->tx_chans = NULL;
+	return ret;
+}
+
+static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
+{
+	struct xilinx_vdma_config cfg = { .reset = 1 };
+	struct dma_chan *tx_chan0;
+	int ret;
+
+	tx_chan0 = dma_request_chan(ep->dev, "tx_chan0");
+	if (IS_ERR(tx_chan0))
+		return dev_err_probe(ep->dev, PTR_ERR(tx_chan0),
+				     "failed to request tx_chan0 for reset\n");
+
+	ret = xilinx_vdma_channel_set_config(tx_chan0, &cfg);
+	dma_release_channel(tx_chan0);
+	if (ret < 0)
+		return dev_err_probe(ep->dev, ret,
+				     "failed to reset DMA controller\n");
+
+	return 0;
+}
+
 /*
  * Parse the "tx-queues-config" child of the EP node. The logical queue
  * index is taken from the "queue<N>" node name, so the mapping does not
-- 
2.34.1

