Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AB391E7F;
	Fri, 17 Jul 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279340; cv=fail; b=rSnROeDw5m7vLnqZabCNpaEZsQSZTsNnOWHiPIeuoFMxoyfWcKuM6S/ixfEltL4L5fMxzkNKQS4V59xYsdwBIPYoA8nHyuqkgg3SDaCNWgPYEpO9j945dGAVTBU5OGEJygKOakxyZoHv4v0ovPwDKZanmt1d0gf027vJmq+xcEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279340; c=relaxed/simple;
	bh=9sMyAFUoACTPEwASUlyEgQDtANu87bGKoS8/QGciW0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYOi6E1E9W5lwmunoPaCNsAWQgdcCcvsnv467LOJy1AnxmLhTqbVbOzC3554WZXpr64/SCibX5K/+YbxxwGpeqDYZeXMSosPVWIm4DLG3Yv2fZi0wpTJr/Wl7RW4GODspdtd1uMtfxnmML/l9n4iAUKXaxm3zhPSYrppT5IPWY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3jFbfWGb; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3jFbfWGb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLDfIfVKMOFvPS1dAwBRwXIonZrRbWma0MiKj45zeohwG/7pSs01G98acHwAJJFQssj8iDoao9QHrLtffQov9eK0Y8xC6AxjskM1ovfWa/OXdhnVXUW71LAc9qKK0Ra046BEMecr5f9En71lr7CeaLb/okK/Ez1ajRvU9Y00LEx+FKslaJ/v8uc2y0BmwTiKvaaEI4CuHYhBF1SmivY3snHBdFfz4rBJ3XkF2dOt0TybOINNtFEhvpivoKW5vJXj+ikpI/Upi08GtBtQbsK61/Wk6wHHzmdn8d5ZMwTGhQqpMbcH/Ez13yAXZMFVBeaFvQLE8qofasf+lVioKhUecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UylQPwXPoGj8c0AxdVI2rnrXenxhOyAAk+bvpa38SIY=;
 b=O0jUEHx0SCTnBEcqdOqDne+nbf3krVM0yTA4gn4XoqhVpM/V/PHdJMc2XEm35Qd7U8ONL+EiLbI1QD6oK+uH2rB68Z4JhOkOgd7ODLLhd4x1RM06qhGjqdgEoqSQCUbpP9gIETa4qpmngPMA040UJDG+C0iNBdNTXIeNPGEvIVPKa4W4lfNwkOQA40GrkLVpDiGNpY7eMBeKXJvQo1qP+u3F6xILAZtUkaDKZkqaBlMkLVScU7Cnwa3kHhNw2yAHrULOEI+4aHmNVWLvA5jsjE8Nn6j/VvUuvi3xqkJBPz9Zy/kup8sdPRIqSjRYEb3xzvwUNQYrcMxUgLgxJzoPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UylQPwXPoGj8c0AxdVI2rnrXenxhOyAAk+bvpa38SIY=;
 b=3jFbfWGbYSf0ktcWdRMwpzc+bbt+cEW5bKudP+4zJ++Acl08KJ4wfeLe3mIiWgR8G0TOzcgVRsX5c3VSeKGHhnYHiToW0/NLUAM5d35zEhgXY/rNdWHT6wCPCmwUBuS84ZraIt//ZFZ5k9ttDSNi2W+ZDlOJktE23n3xWUUFPmM=
Received: from CY5P221CA0152.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::16)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:08:50 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::6a) by CY5P221CA0152.outlook.office365.com
 (2603:10b6:930:6a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 09:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 09:08:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 04:08:44 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 04:08:40 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Suraj Gupta
	<suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Alex Bereza <alex@bereza.email>, "Folker
 Schwesinger" <dev@folker-schwesinger.de>, <dmaengine@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH v5 3/4] net: xilinx: axienet: Derive RX frame length from residue in dmaengine path
Date: Fri, 17 Jul 2026 14:38:23 +0530
Message-ID: <20260717090824.2364230-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717090824.2364230-1-srinivas.neeli@amd.com>
References: <20260717090824.2364230-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 7924a67b-38db-4a9f-12d4-08dee3e30472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|6133799003|3023799007|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ovfFIKaDQZVcJPUBskrEPSHHs3DNuoIs1HGOpwvQn+tZdZHrJUP9rQ0In3I37HpuZ7Le8xAd7DkYXxK0PeDGevj09DHa/GfnioJA0ZAFwZMy4qI5BMN5NqECCVKTlxruwKnbNbM46wkRl9asMVnzSI917jPnq8oqgNoyT1yqFcGafXsMVbhR4Lr4s4ZYGxiI9kpSlJ4SGv865zfXrCdWl6xmo1yG18YgNKpxh9zEl3eq2Of8DUP7nwCCNb9zBT639mx0gKoWlsEOMUEVt/jOXrDstqF+KK7ye+VJOVGCVpvONWbv01y52icr4HCUz38B4nAOv3yv8d7YhFG0l6f28bfjw6/cH7IUVb5lUUC3FrExFjE34cdcF5TwRA6Jf9oYzrh8DxSM7MrjbQavhiRf62M8971W1YxP5OEqgMMsfUkPN72yxy+TqqEmDIrQx3OoyU6OdPFp7g5bdUiTFT2AaTStX8rJR6lPA5IoEBpOGAXKuumPBfHwhJtTOPVyAuPratHU9hHZuolOWxTNX3R+L/oaAiBdAmvPkx1DBXB1ov+vHxA6TfjY1DnrhuAC/vxvYXE8+hHSd+9p0clwU7TsoCHSNDHUFWiKZFv4TlphganLOj5kYXt7ybmLOdgsl5DBy9pxIUZCIXentn7cGCRslgomADAQERamgwVyim/BT6j7bIe3nRXe6nHI68pUw1MXqD/rEARpCVtGHc4IcnNz8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YsMmBIZCmxGIGIb3M1DjbShOL0hVNtUVs3OLthosXMwQ4mCliomoUaYQbY+XYKTiUeVUN46NIvcdo9BCqpLRy71bAXPXsVb//zszx1Siu5nvYYuCUNuT7mC7XuaY1T55pq/ES1Kzdi1iaJlg6cBcBeaOGAgIK4O1D/782y5/pTo40rNY3li2HChXtAa/gDxcwcx07WT2MgXKP6eFQ6IGyuxrP0sx9G2CZYlOL1mbOq/kcgBIIYKz+DsYA2KJCdArOGhVvScF0mjo6UNImX3DHfRUwHododPjSTnRMAYtZFdAcFA0Gi0uXAHPJfTu+YzZsyuQ87Z3Vm1iseHoXP93e9l8JGni3x8auQVrIF3llyKCnZKU+9gGq/vJULrLIbMrFe/L+fXgQK64MOinXH6KpJfT59o0B0GQvnYsTlnpuo0akqr3qJAFOcPeI53bSa7X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:08:50.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7924a67b-38db-4a9f-12d4-08dee3e30472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

The dmaengine RX path derived the received frame length from the descriptor
APP metadata. That only works when the optional AXI4-Stream status/control
interface is present, because the hardware populates the APP fields solely
when that interface is enabled. On designs without it the length read back
is invalid.

The AXI DMA engine already reports how many bytes it wrote into the buffer
through the standard dmaengine residue mechanism. Compute the RX frame
length as the posted buffer length minus result->residue, which is
independent of the status/control interface and correct across all designs,
including multi-descriptor frames where the residue is summed over the
chain.

Drop the descriptor metadata lookup, which was only used for this purpose.
Detect a failed transfer from dmaengine_result.result instead of the
metadata pointer return value, and remove the now unused LEN_APP macro.

The transmit path is unaffected. It still passes APP metadata for checksum
offload and derives its length from the skb.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in V5:
 - No change.

Changes in V4:
 - Renamed subject to "Derive RX frame length from residue in dmaengine
   path".
 - Condensed the commit message.
 - Dropped the Fixes tag.

Changes in V3:
 - New patch in this series.
 - This patch enables axienet to work on designs where the AXI4-Stream
   status/control interface is not present. By using the standard
   dmaengine residue mechanism, the driver no longer depends on APP
   fields being populated by hardware.
 - This approach replaces the V2 xferred_bytes mechanism (V2 patch 5/5),
   making the dt-bindings patch (V2 patch 4/5) for xlnx,include-stscntrl-strm
   also unnecessary. Both V2 patches are dropped in this series.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..67d1b8e91d68 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -53,7 +53,6 @@
 #define TX_BD_NUM_MAX			4096
 #define RX_BD_NUM_MAX			4096
 #define DMA_NUM_APP_WORDS		5
-#define LEN_APP				4
 #define RX_BUF_NUM_DEFAULT		128
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
@@ -1159,29 +1158,26 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 {
 	struct skbuf_dma_descriptor *skbuf_dma;
-	size_t meta_len, meta_max_len, rx_len;
 	struct axienet_local *lp = data;
 	struct sk_buff *skb;
-	u32 *app_metadata;
+	size_t rx_len;
 	int i;
 
 	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
 	skb = skbuf_dma->skb;
-	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
-						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
 
-	if (IS_ERR(app_metadata)) {
+	if (result->result != DMA_TRANS_NOERROR) {
 		if (net_ratelimit())
-			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
+			netdev_err(lp->ndev, "RX DMA transfer failed\n");
 		dev_kfree_skb_any(skb);
 		lp->ndev->stats.rx_dropped++;
 		goto rx_submit;
 	}
 
-	/* TODO: Derive app word index programmatically */
-	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
+	/* Actual length = posted buffer length - residue. */
+	rx_len = lp->max_frm_size - result->residue;
 	skb_put(skb, rx_len);
 	skb->protocol = eth_type_trans(skb, lp->ndev);
 	skb->ip_summed = CHECKSUM_NONE;
-- 
2.43.0
