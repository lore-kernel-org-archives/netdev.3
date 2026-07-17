Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C533570AD;
	Fri, 17 Jul 2026 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279344; cv=fail; b=oa09GQmYjsmoz8ZJtpOesYb/1tJWdniKWxcdkW3y5GKUJXiFUIzViQRyJI/5d83WK6+sQN7kQCzJ8bzE65/oX3suqtcAJ3tlbr8Ju05e2lEc2Ymr8gkeWgzSzwKRMJZYRbZvVGrMtnSqEbRftX00pLEQ4mSUcuvSLoy/xTs+0mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279344; c=relaxed/simple;
	bh=Un/U2rCZ6QQWDCe7j1mw3anKnUUmDhgHYUl8xdP3NDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACvV1XhmxfDCdE8E4lf5AtPKOxzuhNPdcz0usRdO3Fs1Vzozk+chvNuOKfB0F8dY/jvZ3a37WDW+Io27dzodAsjlUFuLlEaE64q07KpKro7wSTnvyiFPuZtqlltS/A83eKi6DX7FEHOWeHg0szLKCazUgn+Yw0YDvqTZK5h8IUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NkDshncK; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NkDshncK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK07kPB2PjocoePPVIH3/6HOCeZIv/i+s/q/ApQ4Hk8PGBmna4rEmIgtpg2/EX/wAEZFv2t/lGR2aWiicLIQdmbGVxg7EkNOnP9hIiyIFLwzo+xHPCNw2JkX1tseKoAwpT6mcgmApYf/riFY5nYLGaFIBqfKBfuSPU5eC/bKLfGqZlI0IcREFpSaPShPE/s+EZITq9j45pFDWmuVtmqfZii3q2nph46lAbAes5YDhw4dy/nhvkuX+MoepTfaH+1AzHaDEo+e9+qEpPTdtFz2YqeSYRNrsxnVluFuV2WbR3s9BegTxtwPXHnlop80J9AVPEZZPGpEOYvDcdxTYYODMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmoqMb3dIzK3siCOfLO3U9g4OKJjSLzCQuPFj2MKo68=;
 b=lc884ugMx/JVUbGABnZdYm8nV3/4eyelwULL/xH17NWpKL0sPVGcCoh7ADkJlpSoGwgB3JtsaGFDIbtTk+IaBhgvLBnpeTuvf5lBF18eOqNEzjxl2zg/4uOSYiltFlGVaJof+EIf9clIicLP7mgQVgg2bsoTNP6PsOIDY9OVBI9qx4F08+cmOjQ5dLIA1/w9grsK5C0LGG2HNuzN6afzNMQ3TbJWkCTN4TuaYy2M3tCZWQNnfc5ZTNoL9FtXYOBuuJJS9LmfFn7fyFkfABbtS12wYOpytLZuu6P/Ep2qHvxQRMJdywucnfyNRFst9+8Hsl629Xyl0SYZ4rCRVweprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmoqMb3dIzK3siCOfLO3U9g4OKJjSLzCQuPFj2MKo68=;
 b=NkDshncKqEiKHMSNhwrVdQ/cBKLPbGqBMX5Yuh/sMgguQ/K21w2RGsQ+zSLMOdScAcsm7PPgpgQUfSn+cVv1eaEq+/N4o4mUMEL7/KgkQ6xWZSm7bsgmDxJUGchbbRzwf9uVhcYTZZJDC2Wbh9hcSUPCP/qK7Zm1ldGmwfTINY4=
Received: from DS7P220CA0053.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::31) by
 CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:08:54 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::1b) by DS7P220CA0053.outlook.office365.com
 (2603:10b6:8:224::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 09:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 09:08:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 04:08:49 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 04:08:45 -0500
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
Subject: [PATCH v5 4/4] dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
Date: Fri, 17 Jul 2026 14:38:24 +0530
Message-ID: <20260717090824.2364230-5-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: b0396e30-165d-4ec0-f856-08dee3e3067c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|10067099003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	mHpVHfB35mY5jLNbziS4EYK8nT9wCQYwCGrBI+Suj9dyfqWk9+Qpt6NjiZRAWiuY296pvLEYWH3DwTkq1fFetQYykFsWVDa2iKiNyBfL7jEnzFksl8Sohn1LYJK1P2FVn1jYn9IVJT9SPKktmnw+a3UzhK3B3OVu5hmpWk2OMLH0i1fleLt13nrN+2cAaJax1S1KbttTAUrXATJjOIJ1DKZrgPbLrmAJHj3OOzVVB50bJdH0CnENAhgXA27eUZ5owd1qEitlHF956XYxAjJZlJXngOztBdkOkHMoWAabOpGuXmqp3Jqm69H2B1Y9NmkMDFMXa1DU7MWDy9x5PRy9ZnE72kCze/j9NcQTxz5UQxwaJGh+T5KTqY4eK1G2LKlk1HhzIFm4ieeNJmGx16aL7hcd7Vu8TLEbNZjHSDbeUYuqH/JPlVRHkhUxFDNpYXOpj1G8gNLznEuc3DsaB144zgqFT712Nj9OawzINzApA5h9DyRYINCiwLhdgWRVoi4dw9hYYrVbvLwSWB6+SxfMrhisy62GnQyil5RaFi6FLFVQZ4pJF8O5uM12Dr45ASKxqCX5cE7daLf8cVQPYrfAUoyy6tKIdLS0TwcYlvMTWL8+g0MUNh74mER0WAPd0kr4SuFc80RB/ypuKDp+1CldwzTYOwSgsmqsVCZj9pLOBaL5hHBqbL2CNGrxvJ+QV+fgzo5oiwW+uRfdb2VqBeCE7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GWmgsgiU3qbPQbDVO+jlVEnYkrowiOR9UIIG6TKwfip2bqkiOAbwXDwPTSuR41KJlNjyn9cdKHQ3ajzNufFWrONMILEqfSvArbPubpetwNRhAJ96KOm5f9I27t8w/OtzYqP3gjHX5HK51qgemIobwL4++cQyTAy3Efw/W9eBw2QOZffJlx+w7n91XNenBLKDSx6wtKXpXRBgaXztTKuM5x0bCURv9Glw7aQp3cHDU6/Kz7MopUftKpkDogE2hBnnOCFNyo2nZKMk7WMhIk/pVDToS1NTfCxp1IvxoyjzZU4vUTAChC/g40JzoFQM9PKR9L06Hp2DefPEm8nP5hXKnc5wfGDz0G0aQrwzAL/Jlm6VJ2C5M+YR42rShn2ZB2z8StOhSAM0CbBZVKCm0UTcWlAb27swoCEEeZJzYGPEzGujwZ3a4KyykTzuk9W4YCiE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:08:53.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0396e30-165d-4ec0-f856-08dee3e3067c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

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
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
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
index 1b5b00f08c5f..6bf509d33e7c 100644
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
