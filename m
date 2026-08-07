Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0940A956;
	Fri,  7 Aug 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099518; cv=fail; b=VzbuSM7QqpLFKvfaYENiD8oDCP1866F2jyoxO9YWU6XR8TS9pXgahpqfI/rWVZQWLU5Kjp6qRr1h96mbAimMI4vtjJILAFbvklPd17oEtdezn12LbRiKDVkoYhjM4J2Z4wzpEL8me27vWaEyTojtX5F+sFsRqttnDGOtTgev96I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099518; c=relaxed/simple;
	bh=M1sdlrXDtDD2wvvjD9bqelSMb4AdHUmJW7mSm8PfX30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKn0GNN/kx4Dnx4mL6X4HsIhRsqANPbtthteY0M9bpwKi7Yy18QYP4c/1LMz4RFCn+xU6znAn5F07ZgdZHLHbuRGa5lFQIFC1mQ4SRcqfwUEq4UwGRKCnTfA4HPs9x3heL3Dj9KQuYHvCkm+/DdaOe2SVsjgwiZcyevVLFz0foM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3XYIFeN7; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3XYIFeN7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0rcpEJwzi9Bbu4KO0PihsOyzVpbFgdun6/NgCk5m8EsP6OHFGQc+x0wZWCz2lu7DGwrR6X9XUD/LGUifIQ8KH9vDg/J+i+CoRyWad05XwLphASeI1xMy1RU3wEEpYva9aGi5SCZoOAwAu+4YpDtSONt7jVGcK9Y0FHy3rCKAKZ/s2gZix+NKSQR9JEBcjxHW9kHGhlUUSaf7CTRSUm/VTKaQxPtN40hME2qORvykvvmzcpINkjcX/sHkDkVYPfcBdbmQEej9Dw7a30+hZj7BEoaZESt0+XduWyy3vP/ObAfUqnSERuU82fyObRQ4A0DbmDll+XYxG9vTOKpbGAVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrfcMwPIUWQ9ezVOmLyMWVvwWV8Hb23WZBtJvN5Utvw=;
 b=gOQ+2cdvwK5f75bH257Dw7o9B6E/MSk1uoD2w2GaTjyIP/RbfoKQfa4HJED0gKr1cnFqce8kgIqawVx+JPc3iIxEZss2khZkzSz/ZWUnz7jQZQZBwIWlspKQoHz9Fnt6UVmPUpi5pnv0f/aq2KmXQWiEoMFLx6SFrsOW6HZuZAjaWH19EEACjNq3upEo7H1at4Ho/xp4OJDQXrFfLfyhnjLEoQVbWnqpCtJpL+zRaOriomdlWscf3SzN3vRxygWUhdooj90ndTwDsjvBMNh5UYO6K0ukcYt6wg795LgzsHfzBI6iRJVQIegVqaviUxBbwy4FSIWFnU5mwNMjVDKi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrfcMwPIUWQ9ezVOmLyMWVvwWV8Hb23WZBtJvN5Utvw=;
 b=3XYIFeN7iagizt/s6Xmu2CWcZtj58XJrzQIFd51ltUQsfuOj9CDnb1gmaCj5d3iFnvS2FVXKggQ/D5T9ZaUigBYamfHDuajUJ7mLy4RePOi0sSh5F5y7d4h/sBPfX+UlxvtyP5/9kgSztTH60hZRo3RIAQNPz58fJaIk77zdAIs=
Received: from PH7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::8)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 10:45:09 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::ad) by PH7P220CA0064.outlook.office365.com
 (2603:10b6:510:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 10:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:45:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:44:59 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:44:54 -0500
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
Subject: [PATCH 04/20] net: xilinx: tsn: parse endpoint DMA channel configuration
Date: Fri, 7 Aug 2026 16:14:15 +0530
Message-ID: <20260807104431.157230-5-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: caf8ae03-bcd9-429c-3062-08def470f38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	STV13yRW9LHkv7g7Y4E9uGIVKIEGEynS5gngEEEHNYj1LQtEKIaxVF0FqHjoTrl4GmdLzrnMs/P7kzJtx1cIV7q0LMr/bWhWoBURgjhpJHW0gbYL+3hgnyK+Z4sItTuqQQQHWr9PJt3NCtN7qq1B7GGEj3V2UGMRrl9zpjuExsnmFpkfKWtSiazr31MrUDV6mOX4plTzjljUakCQqoB+BggHQc8y6YfbVWbwkGW/Jj2tafaETPilOJEFvHwX6Xkb/ZB7qe7/GPVBx8G8vMK8GFTmkbPUAANd+aQIDnY4Sjt4Dle0dQ6KjRc72NY2e5eciBi1eU5xictq4tpx6zKIBQxhR/RNCFM8DDHD0UdD/6AkQJD/79DFi7ASvXhkBpT0xiW5P693K1ErliRoVLWaVwkFVLJlzvwQGjmDpLRBcCVA6lVSqEmLAfFpjy8V7WY09pEW8px+iDbnO6QYP04DvJtfknbX4ng/yPeOaoW6FuueOq46rYI5paH1SIL8rUoOdxnHkWS6Q5MRCIrMGM/9C/QoWUA2i/LBIAF1mFPHD0vZ3N+5lwbJ6zj33DzWPMWJHi3F/lZk0kp3mFm6XDtBoY3A/loU346mLX1f8CtRkq30xEMxUqvTGpKXDjY7Ubf0JHc3oYd6HK4ao3zEoiTOGMhGUuz02iKS49pF88bKHlGuSmVGXGYec97YtALY0z11Gws+7pRV70PpVd6Coh6F0D2l3LsFj252o6f66ZkuJVyw+xvZrt7Yekvu5yE1AYl+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dVSZEVVoRGGQaA7G0N8d3Cd6KYNHLFOEiWV5Au0yEs2fMjj6Decvfc1gWitimld0EL8koPPZw9tdpGlBpC0uOoJgtDlu5IQSMd6t1VasRwsUNHo4+WwMKPIylMrRn+hfudK+6K5/xhgien5OnEg0Jdnt6OR9Wv+fw7fTYqZDeEriufEiLv/DhbkDuqdL4Zyekqe2P3cnv4TgdnEsxt3vX1ssTw5ooKoa0wX1aB6sLG3C7DZsVQcsbKCJSmdMEEsochfUF3eDXYIPlHYo8p4zI7HGuVdLryULzjpPERIuQjYdjYlT+wRlHOO/kemod/m/0bYzbQCClhM6MAKwDj4nxWUNSGgmBFdraGwWiq/vSZlTuvw5gJmF6f41Q21lVeFgCsiFUPL1pccWyUDCqkd8KusRyUnpVymHEwpBFaDljwy6EZ02njjoFDpECgy1lC2T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:09.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf8ae03-bcd9-429c-3062-08def470f38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436

From: Srinivas Neeli <srinivas.neeli@amd.com>

The endpoint has one MCDMA channel per TX queue and per RX queue, and
the device tree lists them in "dma-names". The transmit path needs to
know which physical DMA channel backs each logical TX queue.

Count the TX and RX channels in "dma-names" and allocate the conduit
netdev with that many hardware queues. Parse the "tx-queues-config"
child node to map each logical TX queue to its physical DMA channel.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 138 +++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 9b556edf5423..062cb94c2153 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2026 Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -22,16 +24,32 @@
 
 #define DRIVER_NAME			"xilinx_tsn_ep"
 
+#define TSN_DMA_CH_INVALID		0xFFU
+#define TSN_MAX_TX_QUEUE		8
+#define TSN_MAX_RX_QUEUE		16
+
+#define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
+					 ETH_FCS_LEN)
+
 /**
  * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
  * @ndev: the conduit netdev ("ep")
  * @dev: backing device
  * @regs: EP MAC register window
+ * @num_tx_queues: number of TX DMA channels (one per priority)
+ * @num_rx_queues: number of RX DMA channels
+ * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
+ * @max_frm_size: maximum frame size accepted on RX
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
 	struct device *dev;
 	void __iomem *regs;
+
+	u32 num_tx_queues;
+	u32 num_rx_queues;
+	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
+	u32 max_frm_size;
 };
 
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
@@ -72,15 +90,116 @@ static const struct ethtool_ops ep_ethtool_ops = {
 	.get_drvinfo	= ep_get_drvinfo,
 };
 
+/*
+ * Parse the "tx-queues-config" child of the EP node. The logical queue
+ * index is taken from the "queue<N>" node name, so the mapping does not
+ * depend on the order the child nodes appear in the device tree.
+ */
+static int ep_parse_tx_queue_config(struct xlnx_tsn_ep *ep,
+				    struct device_node *txcfg_np)
+{
+	DECLARE_BITMAP(chan_seen, TSN_MAX_TX_QUEUE) = {};
+	DECLARE_BITMAP(queue_seen, TSN_MAX_TX_QUEUE) = {};
+	unsigned int count = 0;
+	int ret;
+
+	for_each_child_of_node_scoped(txcfg_np, qnode) {
+		u32 chan, queue;
+
+		if (!str_has_prefix(qnode->name, "queue") ||
+		    kstrtou32(qnode->name + strlen("queue"), 10, &queue) ||
+		    queue >= ep->num_tx_queues)
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: invalid queue node %pOFn (have %u queues)\n",
+					     qnode, ep->num_tx_queues);
+
+		if (test_and_set_bit(queue, queue_seen))
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: queue %u described twice\n",
+					     queue);
+
+		ret = of_property_read_u32(qnode, "xlnx,dma-channel-num", &chan);
+		if (ret)
+			return dev_err_probe(ep->dev, ret,
+					     "tx-config: queue %u missing xlnx,dma-channel-num\n",
+					     queue);
+
+		if (chan >= ep->num_tx_queues)
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: queue %u channel %u has no matching tx_chan (have %u)\n",
+					     queue, chan, ep->num_tx_queues);
+
+		if (test_and_set_bit(chan, chan_seen))
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: channel %u already assigned to another queue\n",
+					     chan);
+
+		ep->tx_dma_chan_map[queue] = chan;
+		count++;
+	}
+
+	if (count != ep->num_tx_queues)
+		return dev_err_probe(ep->dev, -EINVAL,
+				     "tx-config: described %u queues but expected %u\n",
+				     count, ep->num_tx_queues);
+
+	return 0;
+}
+
+static int ep_count_dma_queues(struct device *dev, u32 *out_tx, u32 *out_rx)
+{
+	u32 tx = 0, rx = 0;
+	int n, i;
+
+	n = of_property_count_strings(dev->of_node, "dma-names");
+	if (n < 0)
+		return dev_err_probe(dev, n, "failed to read dma-names\n");
+
+	for (i = 0; i < n; i++) {
+		const char *name;
+
+		if (of_property_read_string_index(dev->of_node, "dma-names",
+						  i, &name))
+			continue;
+		if (str_has_prefix(name, "tx_chan"))
+			tx++;
+		else if (str_has_prefix(name, "rx_chan"))
+			rx++;
+	}
+
+	if (!tx || tx > TSN_MAX_TX_QUEUE)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid TX queue count (%u, max %u)\n",
+				     tx, TSN_MAX_TX_QUEUE);
+
+	if (!rx || rx > TSN_MAX_RX_QUEUE)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid RX queue count (%u, max %u)\n",
+				     rx, TSN_MAX_RX_QUEUE);
+
+	*out_tx = tx;
+	*out_rx = rx;
+
+	return 0;
+}
+
 static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *txcfg_np;
 	struct net_device *ndev;
 	struct xlnx_tsn_ep *ep;
 	u8 mac_addr[ETH_ALEN];
+	u32 num_tx, num_rx;
 	int ret;
+	int i;
 
-	ndev = alloc_netdev(sizeof(*ep), "ep", NET_NAME_UNKNOWN, ether_setup);
+	ret = ep_count_dma_queues(dev, &num_tx, &num_rx);
+	if (ret)
+		return ret;
+
+	ndev = alloc_netdev_mqs(sizeof(*ep), "ep", NET_NAME_UNKNOWN,
+				ether_setup, num_tx, num_rx);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -92,6 +211,12 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	ep = netdev_priv(ndev);
 	ep->ndev = ndev;
 	ep->dev = dev;
+	ep->num_tx_queues = num_tx;
+	ep->num_rx_queues = num_rx;
+	ep->max_frm_size = TSN_MAX_VLAN_FRAME_SIZE;
+
+	for (i = 0; i < TSN_MAX_TX_QUEUE; i++)
+		ep->tx_dma_chan_map[i] = TSN_DMA_CH_INVALID;
 
 	ep->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep->regs)) {
@@ -99,6 +224,17 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 		goto err_free_ndev;
 	}
 
+	txcfg_np = of_get_child_by_name(dev->of_node, "tx-queues-config");
+	if (!txcfg_np) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "missing tx-queues-config node\n");
+		goto err_free_ndev;
+	}
+	ret = ep_parse_tx_queue_config(ep, txcfg_np);
+	of_node_put(txcfg_np);
+	if (ret)
+		goto err_free_ndev;
+
 	ret = of_get_mac_address(dev->of_node, mac_addr);
 	if (ret == -EPROBE_DEFER) {
 		goto err_free_ndev;
-- 
2.34.1

