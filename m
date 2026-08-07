Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DA3F8254;
	Fri,  7 Aug 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099537; cv=fail; b=mC6Vp/cf0ui/+jBEVovFAMRkWZtFE/1ZvSNlvEE1vOtxU0VuQWX0iJvnvCpFveGo4g8Q1qyPdvqKqAi9xEoWXRPnbyGK28Cr/5XM3+lX1HUf7hozxHA5eXNtGo6+ng3keznAMr/cu1bJl6O4hGVSVv2JXw1ONZUcFeMb2ubfLqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099537; c=relaxed/simple;
	bh=x9GMH2d8vJvuK+0C5VD1zQLhb2kfYFbXBqfEsb1lQJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfQ+Vk86B7kcRHXerMXr7Xacy6DnlG98g8In28k0AdCFWWZKK6utCm348ATz1hKXWpepGeKR7mjAj++iupNXP27HCnIr1KGu9/MamywUxxQq+mxL3LSFTeHclnlvHymOR/q4sssPTdXedvc0Fq5zbQMi9amNC/L1r97w50A6Qdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ncgWw7jD; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ncgWw7jD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYu4lF+ndBbTDZOFFsSEKRlJyut+J0DApJjMNHmMIHKH4hHjxyY9yN1Zfw9f+QtqhLzsb91NN8+8zOXNxm0Zx8MEtWfEj81w5Fa9SJNon5AhTx2ztU5mY1UNVEHgNS77CkBpVizZCEWacvr7DWo3wys3Lhm/MqZuPJbHjSQaFlbU6h9fNSMf1eYkZ6jLqa7QIy/a9JNU/BAiFXS8dbsPfOQupQxuE37bKAfuveUJahGK1HuZ+oeDCeTNI26GFd3NhGaroM9tqNPgtzcK5JUGuyM5w25WCmj/L8O6AgKOASSjtUtGfAtK9DMjJ+vdLpiXyKIQmnLRDdvmZD48wtqokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0onyrmUWbRTSXOvvNu2iNNwP6EWh035g0IcBtOo5LY=;
 b=ITZySOV7+rg/YFhhg14IbHFSWzrh7Q+rU10196FX3n+H927AdCEI3p/zbbnr/irAadbzS6nny8Av5Fq8LHpgu8YUz7j23QrqR5PYfYSxY35q6K+7GNR+ugB4GHjkiBmcu22mGITZX4t35C0Lshl8NpbM9vOR3f0ChtDs9dLZIb07KGNrP7AipPjIWkN2a3wQXl7UMDrQku4+GvBS2uqjAWZe+LRXXbtpmS7p6jRg5YrdICr1mri5R/cXqOM6IVpteAE7/fPs3pwlBjvoI5axVo5HRKsO8Fah8NIBWX//bQOSHpoltJS1T/UDmjBmn8YJev+LnS5GnqAhe+7qQvMG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0onyrmUWbRTSXOvvNu2iNNwP6EWh035g0IcBtOo5LY=;
 b=ncgWw7jD7ESTaRe5CayKjY9z50bH1VWG/lF/9F5Br8FA8B/ovGdSeKVZrwrqIwZWTbwiRx+IOp2k8kP/PvAJB3mm1GxCobjT/NUya/kf29pawj9dZ6Vl2Fv1bBeBrTgL5noQzqp9n3pzS7OLDhFp/xO0d/F8qYlVXiczBBkp4mo=
Received: from SJ2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:a03:505::21)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 10:45:27 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::23) by SJ2PR07CA0019.outlook.office365.com
 (2603:10b6:a03:505::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:45:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:21 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:16 -0500
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
Subject: [PATCH 08/20] net: xilinx: tsn: deliver endpoint RX frames to DSA user ports
Date: Fri, 7 Aug 2026 16:14:19 +0530
Message-ID: <20260807104431.157230-9-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: dd619b0c-e256-4043-8aae-08def470fe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	NFHBXVje98Bx+GP0PCuN/zP193E2lE71FHlermhfXty7Zp8+P+T+iRPdHVTtgVSclELJ28wDRK2TGQCeBlFEy6DlTWg7D46jNgi8pFxnL5ZISRCA3PFn8LMpfXvGhECMCp41qpibH4xnSmNpLIAQQ8XvVSf1lJt3PmfofwSEloSWLGYcvEEN8HBn3sJxGsj7b7G/tJHdUhY/Q8RZmNiTOAw+1T5SwSHhYgHTsyiEfuqDD6hbWaK0WZ8HnuWUA1afBMYtpp1gLNdj1GAJleaJMX++mj2pk1wzVISm/ZoniGqvFoK3+EFGjZ8egZVBxAzI3OzMX1upVI6LJGh530Rpnyb2ONOiMxI1fbzErShRrkt7IAn4daf4r4X+iWrNTQ3W0/Y1J/ZoWI4p9CTNm8PlhSt/CYbuI2gejbFDfOAi+CkrCXFHuEZRcJmeAeedIU9xs9Ybai1SoPiqpTDFlu3Zoe2Hllseb3ZRfJ/naW8QIcMNKiap4J3oAtRj2d4XImgQtcPlkVyGXOMmC5bEN4TLyuVWcuUwdUgjmUiJpagciRUaz4FU7Y9SKiJVUlvoOXlNxfx8Eozm0RmjrGM996xTYXDpRuabLPtKCUNTV55U9R+GqXv8mD1TE42tNDhMzpdyzLSnf6m/p9OnItxOYh87O8C96n3SCQE7/rErav7Zi4tmQcyd3VS373jd9qImhDUk4zZsQ4BQIanvq+GB+A2frOOHLD/E5yycp7lZh70sEtGezHKLlRH4S80s0xW6Vy2c
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w74rfV5/q7XbSrb0+4YaT7tB97vMwCmTgq+NJKwx/QndpFZA7XfRaPn/RV694mYg59HIA9boJ5ksO+6PRe9u61WtYr/JHWfoxG9jzyNLbvagqPDQYG8ZsnlGLO7SwtDF+0kt4jKBMKwsMK+8ZfoAQb4UD6ehpqwW2qV85rdm+177gVcwgEbI8uhRRxUfaR1LjBmkYYdJmNisCp7qMr1en/720+hlWls2CFI2aO/4RyJXTefIb6pPffXpcYcWlJXnpD6M/apmMlQAQdjmn1YImqxA9qinsFK0d6Fj5Bq4gVJTsV7DOx6d9uRR2KcHznE+r10kPwrO/JI6Qf8ASRbGApB4Ixdhu9ba9gvBJ2e7a+VHnNDqJk2yZkjJUplFwvPwKd0tCnT4YoCUCXjfew9GUQn6Cm4ef/4+YFMo7DSrNKOCLSC+V6MoCB8PlzqYUQ5h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:27.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd619b0c-e256-4043-8aae-08def470fe4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624

The DSA core routes an RX frame to a user port from the port metadata
attached to the skb. Without that metadata, frames from the two MACs
cannot reach their swpN netdevs.

Allocate a METADATA_HW_PORT_MUX entry per MAC port at probe and attach
the matching entry to each RX frame by its TUSER port_id. Frames from
MAC1 and MAC2 now reach the correct user netdev, which completes the
conduit data path.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 7615d27f3b36..051285b47ddb 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#include <net/dst_metadata.h>
 #include <net/netdev_queues.h>
 
 #include "xilinx_tsn.h"
@@ -56,6 +57,9 @@
 #define TSN_TUSER_PORT_MAC1		0x1
 #define TSN_TUSER_PORT_MAC2		0x2
 
+/* Sized to index port_md[] by TUSER port_id (1 or 2, slot 0 unused) */
+#define XLNX_TSN_EP_PORT_MD_SLOTS	(TSN_TUSER_PORT_MAC2 + 1)
+
 /**
  * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
  * @sgl: scatter-gather list backing the DMA mapping
@@ -107,6 +111,8 @@ struct xlnx_tsn_ep_dma_chan {
  * @tx_chans: array of TX channels (size @num_tx_queues)
  * @rx_chans: array of RX channels (size @num_rx_queues)
  * @closing: set in ndo_stop so the RX completion callback stops re-arming
+ * @port_md: per-TUSER-port METADATA_HW_PORT_MUX entries attached on RX,
+ *	indexed by port_id (1 for MAC1, 2 for MAC2)
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -124,6 +130,8 @@ struct xlnx_tsn_ep {
 	struct xlnx_tsn_ep_dma_chan **rx_chans;
 
 	bool closing;
+
+	struct metadata_dst *port_md[XLNX_TSN_EP_PORT_MD_SLOTS];
 };
 
 static inline struct skbuf_dma_descriptor *
@@ -254,6 +262,7 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	}
 
 	skb_put(skb, rx_len);
+	skb_dst_set_noref(skb, &ep->port_md[port_id]->dst);
 	skb->dev = ndev;
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -771,6 +780,37 @@ static int ep_count_dma_queues(struct device *dev, u32 *out_tx, u32 *out_rx)
 	return 0;
 }
 
+static void ep_free_port_md(struct xlnx_tsn_ep *ep)
+{
+	int i;
+
+	for (i = 0; i < XLNX_TSN_EP_PORT_MD_SLOTS; i++) {
+		if (ep->port_md[i]) {
+			metadata_dst_free(ep->port_md[i]);
+			ep->port_md[i] = NULL;
+		}
+	}
+}
+
+static int ep_alloc_port_md(struct xlnx_tsn_ep *ep)
+{
+	int i;
+
+	for (i = TSN_TUSER_PORT_MAC1; i <= TSN_TUSER_PORT_MAC2; i++) {
+		struct metadata_dst *md;
+
+		md = metadata_dst_alloc(0, METADATA_HW_PORT_MUX, GFP_KERNEL);
+		if (!md) {
+			ep_free_port_md(ep);
+			return -ENOMEM;
+		}
+		md->u.port_info.port_id = i;
+		ep->port_md[i] = md;
+	}
+
+	return 0;
+}
+
 static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -835,16 +875,24 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 			 ndev->dev_addr);
 	}
 
+	ret = ep_alloc_port_md(ep);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to allocate per-port metadata\n");
+		goto err_free_ndev;
+	}
+
 	platform_set_drvdata(pdev, ep);
 
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register net device\n");
-		goto err_free_ndev;
+		goto err_free_md;
 	}
 
 	return 0;
 
+err_free_md:
+	ep_free_port_md(ep);
 err_free_ndev:
 	free_netdev(ndev);
 	return ret;
@@ -858,6 +906,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ep->ndev);
+	ep_free_port_md(ep);
 	free_netdev(ep->ndev);
 }
 
-- 
2.34.1

