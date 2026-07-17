Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9E3909A5;
	Fri, 17 Jul 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279339; cv=fail; b=ML9KCY9+F3IT9qBijPxXBKD3AFQEbsZEeID/eXgSAyrRI7DaMw9CmMomQL/75RQToYjo9r4f6teh2xIht+qzOGcItnY6GKumCQMHJJci+5dOAt9LIChK5/M8hXljkby9QxYpHGLbWiMqCLTROVzspdhDe3LRzZ5gHEnY+hRGFpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279339; c=relaxed/simple;
	bh=3UiDx+DSVtqNFNqmf/0EwH8ToJAfPHDJUv1sksI5SN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MepXi52VC7vRMvjbFUZImdgORnVxR/h3EsxefIxM3f+adu4UBFRd0LG73jIZkZ4ATvVAd/3aom/wy5jTNDhEJ4nMJNqVp9hkPID7ctlYN+eTKKqv2jB2cGXrTH1GaGse9fV+Fugedey3j6h7sji0W/vC5kpReJ4pnoJRu4nLGzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IEgFUE6U; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IEgFUE6U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnEoVBhc8ytPOpocWWYBoFW6qYnQ/CEuTBanpOvXVGwzyTsImA3Mkdm8coYnAlhoxplXGD2w6vddfZrAuIj8r3IkQrwfAFrP28P++NZmSSfAM6JELewiEb4CcZZN0TgxOkMvf8L+wToArP10kiz34zHQYD6tSwtm9IMiRmmuGql1Jh7L6fktAvXKO5gXczp8ss9up7WdfFW/mWx5/nDRa6SaUoWhFLgGU1gL37e5KSaJ6CYHuY9iQvPWEMtfJJMelI5as3urrsSMZpNwxggtJHoBKUQS07ofwIPAO+Lz9oTJOM3LOYEUJF68IKL8rk8Crurt01RiYeJWoRB3hE5ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1/g5rL5QX2smFr2dVuS0fC7Pl732N61ONRz59+Tgpc=;
 b=O4EnAbKnvxLkZsjcN4rJEF00HiE+bWTruNSGoRW+Kgib5NQStYTZTKt5AypekgY2Rgz53s6FqfSOIZ6zPBZptDhZbANFWj+oqMtsJ43r2fZo8ll3kjfGKX2QLge7ezwqB2ZZA1Ai+xXZ5jtRgPCWaRI7aTiLXposyWl/hJpZm5zkuqj5jK/JfiM5wMsVBNXMNUm+IvANnLrld9c5HOcFMakjBiK/X/6eCcvY9YCPgBp4lnVpXLgNm/Sj4pYNIEj5yYOMOqfAx44Ylj90Bzpn543lgxRJh7FRnKINtL4MWB+snDqMdx53bm6AqMwUIXfuah0ghunlqU1dtW0BM94/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1/g5rL5QX2smFr2dVuS0fC7Pl732N61ONRz59+Tgpc=;
 b=IEgFUE6UWk9gCu2UuT1vhJYp6P5p393DarU2wmgmey5Eb4Sq7ZFak3wbUroD93mkkznQdUUssuIeM7rjiEjAbekzsJ0iiScsZp4JfpjxjlvfZ9C40vPPWyzsVpyNRcWToPNM7AAQePBbbN6C9FYdCBicQ0eyHSzckY2Nc5YRfG4=
Received: from DS1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::12) by
 CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Fri, 17 Jul 2026 09:08:46 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:44c:cafe::41) by DS1P220CA0016.outlook.office365.com
 (2603:10b6:8:44c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 09:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 09:08:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 04:08:34 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 04:08:30 -0500
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
Subject: [PATCH v5 1/4] dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
Date: Fri, 17 Jul 2026 14:38:21 +0530
Message-ID: <20260717090824.2364230-2-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e9e063-6407-40f2-7ba4-08dee3e301b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|7416014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LBId/1qYii6pq40tVMMunvKbpEEYhNvQncTGCznU/BYNG3Hrcx0BjLO9lZ9s6p3mOcerrGO+82RAskN7ZiScxcwEdTc19mEddy8tbMxHMJ/lc9QChkeIXtiuZ1HbC0UK/+nRAq3AGbgKu+xoSsKF9vNFeC4OaUBITPewKO97bSrGWV8d0Fr66k/F1KVs5c4k+TuQkPZsX1s6be6zEu+xC8LiYfhPMBRYAZHtdkEsADVCOYCprCsAtHBZzWblcHyRODKHcApRSs+Qg9q2RAjRcjSjRv0v90tELhlbHbzXhIGTPW2hK3LFj7Eok9f0gB+LFjP9GqMgkUFUlfrIHj8EoDKxs0D7PPngwWP5LJ7X8U7X7eZVcCbt+0uKdg0ENc0eMthZ4lHOAuh2E4ad1rJ976Q1NUzcZLtvk8cIKSXU1LlzwEVpnE8IzTN4qV1l7DlNPZIFMqsuSSWYE17PfPWwkElG+E4r7/oF7Pke/cMZGFuUK7p2ubw2AVee5MU7W19Jyt+6nrH1CkAhUtw2KJp0h0oSQ7rP9ae0NCHagDyncEQU7ZuSLCoDndzMAy/EB2aiZctfIHwOeKT+IEPlp1luTHegoEJTtPRnR6R1KvfwBHqTvf9BT41abdfepY4Iy7NrgrMzqmlhoCilPikJMn8nswJ883E9OiUTiKsPczZ5cktxyfDhvFGrWkhtzFAmK+LotCM5FeK419PyUf2ACQZHDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MHEZHm0jLwF923Tsa883v9cuvYNu60eibnMTTziQ8xbvNUBjjOIVT4ipEsbXQG6ljB12yIsjg+tXfZqLGBUV4LoOzyVj8dnpwkmiCRUIcL8P5fn52iOlbQcDoM1AIeC0U0ecNtdWBUzg23r+cr3sKvPPZf3djcPJQh1PKknjB4YGjiC8CZMIYC+qoPlW2GfiDfQoY1BqkJMmLs4Rq5G0E0e/KzESpdhKp23Ctxc9OYE0toor0NWiBJ5i0yLqyqfLAROE/i+5Fz4H9fF92S+ZVdheAqH+vT7a+/F2PVNQpYRSJ7RRNmm+B4AV0f1WpJcUHw42jD0F4Hv+HbNDQ0uw2zCmzwSyq5FRa04uOwUSIoXZRME9W3Jb5iO0Oam/QuAaDrBHyhe0GOyYqW1MADEir/Rnqn+WyU7+B2dMhku+ee29/u5gb0fhCgXJdzUkPcze
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:08:45.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e9e063-6407-40f2-7ba4-08dee3e301b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

The MCDMA BD format differs between memory-to-device (MM2S) and
device-to-memory (S2MM) directions, but the driver was using generic
'status' and 'sideband_status' fields for both. This led to incorrect
residue calculations when the hardware updates direction-specific fields.

Refactor the descriptor structure to use unions with direction-specific
field mappings, and update the residue calculation logic to select the
correct status field based on DMA direction.

This matches the hardware descriptor layout and fixes incorrect
residue reporting.

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V5:
 - No change.

Changes in V4:
 - Added Reviewed-by: Radhey Shyam Pandey.

Changes in V3:
 - Renamed subject from "for MM2S vs S2MM" to "based on DMA direction".
 - Reworded commit message for clarity.
 - Added XILINX_MCDMA_BD_HW_SIZE macro and static_assert to verify
   descriptor size at compile time.
 - Refactored residue calculation to separate addition and subtraction
   operations for better readability.

Changes in V2:
 - No change.
---
 drivers/dma/xilinx/xilinx_dma.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 98b41b8f8915..ff5b29a808e9 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -223,6 +223,7 @@
 #define XILINX_MCDMA_IRQ_ERR_MASK		BIT(7)
 #define XILINX_MCDMA_BD_EOP			BIT(30)
 #define XILINX_MCDMA_BD_SOP			BIT(31)
+#define XILINX_MCDMA_BD_HW_SIZE			64
 
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
@@ -277,8 +278,10 @@ struct xilinx_axidma_desc_hw {
  * @buf_addr_msb: MSB of Buffer address @0x0C
  * @rsvd: Reserved field @0x10
  * @control: Control Information field @0x14
- * @status: Status field @0x18
- * @sideband_status: Status of sideband signals @0x1C
+ * @mm2s_ctrl_sideband: Sideband control info for mm2s @0x18
+ * @s2mm_status: Status field for s2mm @0x18
+ * @mm2s_status: Status field for mm2s @0x1C
+ * @s2mm_sideband_status: Sideband status for s2mm @0x1C
  * @app: APP Fields @0x20 - 0x30
  */
 struct xilinx_aximcdma_desc_hw {
@@ -288,10 +291,17 @@ struct xilinx_aximcdma_desc_hw {
 	u32 buf_addr_msb;
 	u32 rsvd;
 	u32 control;
-	u32 status;
-	u32 sideband_status;
+	union {
+		u32 mm2s_ctrl_sideband;
+		u32 s2mm_status;
+	};
+	union {
+		u32 mm2s_status;
+		u32 s2mm_sideband_status;
+	};
 	u32 app[XILINX_DMA_NUM_APP_WORDS];
 } __aligned(64);
+static_assert(sizeof(struct xilinx_aximcdma_desc_hw) == XILINX_MCDMA_BD_HW_SIZE);
 
 /**
  * struct xilinx_cdma_desc_hw - Hardware Descriptor
@@ -1015,9 +1025,11 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 					   struct xilinx_aximcdma_tx_segment,
 					   node);
 			aximcdma_hw = &aximcdma_seg->hw;
-			residue +=
-				(aximcdma_hw->control & chan->xdev->max_buffer_len) -
-				(aximcdma_hw->status & chan->xdev->max_buffer_len);
+			residue += aximcdma_hw->control & chan->xdev->max_buffer_len;
+			if (chan->direction == DMA_DEV_TO_MEM)
+				residue -= aximcdma_hw->s2mm_status & chan->xdev->max_buffer_len;
+			else
+				residue -= aximcdma_hw->mm2s_status & chan->xdev->max_buffer_len;
 		}
 	}
 
-- 
2.43.0
