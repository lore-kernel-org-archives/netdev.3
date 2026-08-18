Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB891FECBA;
	Tue, 18 Aug 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075207; cv=fail; b=g4khWcKQPi+icFO1B5McCX2pWJjqe6rbmwfgasslv5Vns8wvWkEbe3ezrWWf7/4FRW6s6z2rLlJzDbaZiFU2ACMXQ6BlNEzQ/4rr9ef7uIrZ8bgf0TZgMCA4lVzrIfWXQioMjq5P9JmNoamWxdfXl/zir1FvdUiTk7phy2UbjIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075207; c=relaxed/simple;
	bh=RByyzou4BR/O2lXguCk3mY6aLBm/6oBZC7OUermodRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idxkOo0ehnI6EXywKwTFdfrJWOJFJIlckQ4JHOJ5aw9qLb+2LItfWthxbhHQgfK0e/9NU9qhKv9TwMcwymzm7oiaxFrwLW2LEbYleZWqNseB7GtERdyic0/dRh3VoIzWYER7wi0F0JlZCBqW3d4RGCEo+Q1dzQBsctd3op3WgJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=otBQIIbt; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="otBQIIbt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmO7nr6zf7gWiK3n007tRuECLrMWJLLcoMdfK0VxS7vS/TcApiyvyYrAHO55RCbg6Jb2KqsMLC6Du1OVL+gmMkgWh50z1PT8PwNBclQ2j0AuVCRSPfW6lIW5td5qPEoBwrbi6JJpVmD4O28Gmjab6Q3Vk33DjNeHJMd6eOPb3H8Iila9jnsB1wZFAUwqso7QfX1wscYQW+HohAvZE9kTKYPSaYabpQWul9YK49FHpjWKo2gkjCy+AQH945k2Tyonbr93d+6OcfVt42+O7JluK1513OaOC/VxLBrN6X5mH7GwX84H6xWVEM5FZr10k5VQGHTQfaVY+SfsupY/E1gCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpmJJOTzRT5qcox1+ro838bJ8mpFNXjfWNhaRktsots=;
 b=vIk5FiPzju4Xea3EkAOjqJYm0J7gbQcIIA3NLJCkzo82XrN3Tx6BZyqRn++G1ECJnHzvUkYRSC97lHWZSIH9+zc+qWIdNtpIIc5UUHbrH40TYjKOb4WbohNS10WiTmJ6wlHRGrsLCtJ4ldLfrgyq4q+ksuUdL4aAnxX0/Mzv8WZIoED5mx8ToCxbH7wskeddXSefhlsSVQ/N4D0yuG0qSDCpbf3hVazD7sJWsgZ93pQxNKtpOmxMP9m2D9F8BiHtsBEV+/wGx4oaH7plidrxNy5FLHqlsbMluseYOt47DBjsymwulqQ+Q69QCxBSpHE5iepR5ge5do3VxqnQX1l4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpmJJOTzRT5qcox1+ro838bJ8mpFNXjfWNhaRktsots=;
 b=otBQIIbtN+Q64I5FQHJx74+Xi9nX6W1S8CxGaPbMq20qkQylrfghJvuZv/62wwlUtzYV9INuzoSgIEk4pkF4UdZG3G/jBDBGZBcjISztOHd9crBPhOj38IgqtoL6h7Vjooga9sdjGvSDn828bOc9gwraJduIxuaoW8+lQDvNxXU=
Received: from MN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:52f::26)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 17:46:40 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::63) by MN0PR03CA0006.outlook.office365.com
 (2603:10b6:208:52f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 17:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 17:46:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 12:46:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 12:42:18 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 12:42:13 -0500
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
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH V6 4/4] dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
Date: Tue, 18 Aug 2026 23:11:51 +0530
Message-ID: <20260818174151.1608971-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818174151.1608971-1-srinivas.neeli@amd.com>
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: c915818f-a1de-4340-7dc8-08defd50a8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KZb5s1N3eehNr3en/UJiCY4NEMKd2Q3bCu3tNU/pVpDC4S2P7jyLtOZfpJLl0NlxGZkEVuFFWBEiD8N/N8sNRxTygan0cbGmICMSH8k+gUm5nOaCMgKwg+VRtDb/b2jrtG6//YWf8fYiY/+uYWhrUwFsGHG0yU5OMdvKiZo/Im7IDxGsaXwkXahxvC9X0/4R/WwSA6czSJt8nthe6EtqZwbhrgJ83ZfMv/cjJVUNaDeMZfoFDP1PNzNJz51Uj8rl0vKeQi+vAJplG9wH4P7uY6mpEPEU4Hy8pH+XhkioUOk/y5w5w6cNOth3t6sCQUqhAed+TGyIXAjWmMtdv4NxTQcQCm6cIF4go1B7+Wsfpa1tdI7Jwb1RzO3WNIdCtxaJdRlCdiC1gbGsBaA/ltg3n8HxI5YMkIWlEI7/m2XW79yVAzRaNZJR2M20VbdTyfuOyk9v1kTSV67W06gbmTM3YLmcw4FgbAODF7tF+PDjUU7mXxzYkE88UWcBwwWdfGv5/yve+wwB2Qs374wEOlMWx2q4TDYBqLpm60IohLipWzsn27eGK4zOsifQu0/3vcxpghOqsNhcSff+hJ+meyJR7LfwnWXh7hercq7mC/hUG0UQexSBbaz6AveqaWkyY/9u3MC0YY25Nbu8zP6+3+OF78M7LFeBg1i2OWoTeekpJgiha2RQRYvafKsDbCzB/SKhUmEZgPsqVWnnqzocGIc83A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5omnvEVkBJzNWufeRyjQ1rrNixONvqGTk5duqekUwu2XmfXb5rXRzrzQ0IOVn/a7WR+AFnzW7WlwvtgsRQR3n4M1Msq3NugEkGtEbo063PWPFiEl9np5cbX4Z9qComrGc0719cN0OA7AEMEu+uz8i5ZStZUXhx/aoO0KMzFLpbm902OhXgDPqdjSwJM4/yp4LkYKGhmmZ1WUnyWwF/jEZ6bI6GjIpQViiTAMPN/SwYOA76MO6GTxQUBZY4wGYjdGs8nZe4G3P5Qm4M0ztjJ3iwIm88K4bIANuxGHaYj63XB/0LbYmOs5S/y0mYBjq2kjzLmRi2Ho6wmn6xxHK2O0qPXzvCakdBbwHAY9IWWMGn4f+3Gw0ZH5TlYKA64i2oWsdtTYhXWmO3Jt82t/aTULLfwphC+B0DgVBRb2sc1beh1X/jhATqVwMnYqlq2ulnV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:46:40.2398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c915818f-a1de-4340-7dc8-08defd50a8b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588

From: Suraj Gupta <suraj.gupta2@amd.com>

xilinx_dma_get_metadata_ptr() returns the AXI DMA APP words from the SOP
descriptor in both directions. This is wrong for RX, where the hardware
writes the APP words into the EOF descriptor. It also leaves AXI MCDMA
without metadata support.

Return the metadata from the SOP descriptor for TX and from the EOF
descriptor for RX, matching where the hardware reads and writes the
fields. For AXI DMA, expose the APP words (20 bytes). For AXI MCDMA,
expose the control sideband, status, and APP fields (28 bytes). On TX
the control sideband holds TID and TUSER configuration for the outgoing
stream. On RX the sideband status holds the received TID, TDEST and TUSER
from the incoming stream. The field layout differs between MM2S and S2MM,
and the wider payload lets a consumer distinguish the two controllers.
No in-tree consumer is affected.

Read xlnx,axistream-connected for AXI MCDMA. Attach metadata_ops in
xilinx_mcdma_prep_slave_sg() when an AXI4-Stream interface is present,
so MCDMA clients use the metadata API the same way as AXI DMA clients.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V6:
 - Added Reviewed-by: Radhey Shyam Pandey tag.

Changes in V5:
 - Take the metadata pointer from the SOP descriptor for TX and the EOF
   descriptor for RX, matching where the hardware reads and writes the
   fields (TX previously used the EOF descriptor).
 - AXI DMA now exposes only the APP words (20 bytes) in both directions,
   instead of the status word followed by APP (24 bytes).
 - AXI MCDMA exposes the control sideband, status and APP fields
   (28 bytes), with the sideband position differing between MM2S and S2MM.
 - Reworked the kernel-doc index table and commit message accordingly.

Changes in V4:
 - Restructured xilinx_dma_get_metadata_ptr(): AXIDMA is now the
   fall-through path instead of a separate branch guarded by
   WARN_ON_ONCE()/ERR_PTR().
 - Rewrote the kernel-doc as an index table covering AXI DMA, MCDMA S2MM
   and MCDMA MM2S, and documented that the pointer and payload length are
   the same for both MCDMA directions.
 - Added an inline comment explaining the union aliasing.
 - Condensed the commit message.

Changes in V3:
 - Renamed subject to include "AXI DMA and MCDMA" (was "AXI MCDMA" only).
 - Complete rewrite of commit message and implementation.
 - Metadata pointer now returns status field at index 0 instead of APP
   fields, exposing status and sideband information to clients.
 - Changed from list_first_entry to list_last_entry to return the EOF
   descriptor where hardware writes status and APP fields.
 - Added explicit handling for both AXIDMA and MCDMA types with proper
   payload length calculation.
 - Added WARN_ON_ONCE for unsupported DMA types.
 - Removed the 'chan' field from struct xilinx_dma_tx_descriptor (was
   added in V2) as it's no longer needed; channel is obtained from
   tx->chan instead.
 - Dropped V2 patches 4/5 (dt-bindings xlnx,include-stscntrl-strm) and
   5/5 (xferred_bytes support) as the approach changed to use residue.

Changes in V2:
 - Added support for MCDMA metadata handling alongside AXIDMA.
 - Added 'chan' field to struct xilinx_dma_tx_descriptor.
---
 drivers/dma/xilinx/xilinx_dma.c | 48 +++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 506ce1ec29bc..6ba3c172a006 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -651,17 +651,51 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
  * @tx: async transaction descriptor
  * @payload_len: metadata payload length
  * @max_len: metadata max length
- * Return: The app field pointer.
+ *
+ * The metadata lives in the SOP descriptor for TX and the EOF descriptor for RX.
+ * Field order depends on dmatype and direction:
+ *
+ *   AXI DMA:         [0..] app
+ *   AXI MCDMA (TX):  [0] ctrl_sideband, [1] status, [2..] app
+ *   AXI MCDMA (RX):  [0] status, [1] sideband, [2..] app
+ *
+ * Return: Pointer to the first metadata word.
  */
 static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 					 size_t *payload_len, size_t *max_len)
 {
 	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
+	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
+
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		struct xilinx_aximcdma_tx_segment *seg;
+
+		if (chan->direction == DMA_DEV_TO_MEM) {
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_aximcdma_tx_segment, node);
+			*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
+						  sizeof(seg->hw.s2mm_sideband_status) +
+						  sizeof(seg->hw.app);
+			return &seg->hw.s2mm_status;
+		}
+		seg = list_first_entry(&desc->segments,
+				       struct xilinx_aximcdma_tx_segment, node);
+		*max_len = *payload_len = sizeof(seg->hw.mm2s_ctrl_sideband) +
+					  sizeof(seg->hw.mm2s_status) +
+					  sizeof(seg->hw.app);
+		return &seg->hw.mm2s_ctrl_sideband;
+	}
+
 	struct xilinx_axidma_tx_segment *seg;
 
-	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
-	seg = list_first_entry(&desc->segments,
-			       struct xilinx_axidma_tx_segment, node);
+	if (chan->direction == DMA_DEV_TO_MEM)
+		seg = list_last_entry(&desc->segments,
+				      struct xilinx_axidma_tx_segment, node);
+	else
+		seg = list_first_entry(&desc->segments,
+				       struct xilinx_axidma_tx_segment, node);
+
+	*max_len = *payload_len = sizeof(seg->hw.app);
 	return seg->hw.app;
 }
 
@@ -2639,6 +2673,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		segment->hw.control |= XILINX_MCDMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3287,7 +3324,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
 
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
+	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		xdev->has_axistream_connected =
 			of_property_read_bool(node, "xlnx,axistream-connected");
 	}
-- 
2.43.0

