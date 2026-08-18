Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A617B47A86C;
	Tue, 18 Aug 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075208; cv=fail; b=t1HHF3cMreKsVcprlpmhKxyquZUElO+zd+V4C32EOGhvYaTlFUE6H9l+jLbwe2d8uqCL2xkQpavnOMtNr61KbFCZHkKKU+VJgLlF35BrfBO9IMFI8bO1SS8r8gYwCWndLPHzyFK8sI4/o/R9cYoQIeP0LiFgfof/SEFaXLTTy/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075208; c=relaxed/simple;
	bh=bHJ4MtHXufoYSvDvOaSQcw+1U2l4gWuNxj30FWHeOIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsDJwhIg3lmHPiOaaQAxrAod2CsXNNHsd5Dlrh9GVgjMPP3s92A+U7goNopSIAT0SF80bVSRpRQGJdIydFNiwcsBPHU6sKYAw7npKByVXM+WvFZjkWvIMHk/WZOVBtMSH1QWRTgXP4dq7J7oUUbyI7v4v9H7zk8XxYF4Ux89INA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgmphE8N; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgmphE8N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9fHAFUD5VO5Z+mhPAQDv61J6nUQaV+CVjkMt5VE9Ly2IVH/hwMf++/ubjBM4ErLju1sFaGRQVD6VeLzPQxj/zKcxfJhwSr7SWUC2UiRfY6bmHOjRPi0i0RRx0pTbOwTxBldhDIpwZs9CgY71HuUyKvhb+Jv90f9cZzKcwEmSDO8wDBhn7iaPZwSw1DmC4x/8Ex/quxkCSYY/AqoTLzNHlMMndTRSdGgkzCgI1tyrLqtzQ5ziLlQ8BhH078nhxG105IYP6RPfMpbBpEDusnagA4huR/ujshGHRMdRfgz4CmUNdbCtd/M4/YTZ6lanf2FA7UHzPcgh5/rSHo38DtgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNKvW+4WFtVgL6eduRiyC+7q+wV5EqmZb7e2tzVX1EA=;
 b=w+Io6UmyeVOivZ/MgAHrKYDI9DQ0tjDTAK4mImqw+03GmrFwam0Y/NxILeoo00nPrnS7yC0a0lzMhTlGgtxBNWw93oabw3YMaXT+tS1P1n6e8ZBle/KaJ2cKCsdmW2Ecfk3Ga5tzaGbmTSVZLm9YklMTI55/f7vd2ypcdQ4kfdH9mmdAL+raHO+ArlwPQYlbCMwXQkf1cYY9HOs/bSQHMEn88pQDFqUe4SYZKz2mQzsjn1xtc9O6GSio97UBksz3dLKqZTzPptCJjajTr8/+Yt5yHhxar5g9LM3mlpSTa0AWBGNk7lXOG6tZsI7dwMaCjZPzSErgiUQXt9Y/m2mGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNKvW+4WFtVgL6eduRiyC+7q+wV5EqmZb7e2tzVX1EA=;
 b=IgmphE8NpDkOHODxzTMT8Idc29AwN2q5t9e1Oe3OFxRpnY/OCGbiavrV1Tv416ocyz06vUSrfDOeFlasrbu2tLfGmhdpZJcGb0PangmV5s6DqinAobnSafQZraPyHrO+RrAu1akvUPzrgA79dxaurAleMnqonTelta5KbSOAc94=
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 17:46:39 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::28) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 17:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 17:46:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 12:46:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 12:42:02 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 12:41:57 -0500
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
Subject: [PATCH V6 1/4] dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
Date: Tue, 18 Aug 2026 23:11:48 +0530
Message-ID: <20260818174151.1608971-2-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 400e9e04-ba0f-467d-60d3-08defd50a834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uB1mSE1cNicMgBtJpqVLkQZzSH9X3/3ZyO0htGtQ8MvcQlxpapCbiqz/wOALv45c/eCklScfCWWRR/pHs22HMrsZO1KEGcdUl1yhvyb6p8AMy380La2I6r5PLyBtuxZ4g1XLsFQGGg6ymawLuld2KpKyarOYAN/PtY60cqQdf3wz0o/HMaaZdqvhBH1M0USruWk5J5zrLnSMkT2rmxOONtXbWLwGPUEM84zUQCnhZej/T7A5nikovpHeW08HwCHEO/APvgnifM8N85OCkx+JvO7thbUJb6oFM/syJqSh4nQLzE59zPp8oG65aAxhcT6DZN9v9FOcUEL+fV4uD+wRA7G4+yOHqnIi0k2Hfze6J0ioPQU5bhN1jSXjRXkXQFNFbPZGodfI4y2lIkHblTTbPAs4K0pTFX9TX1rjSSAyYp2s/gXWhCJGAcnX7NR/8XhDRLOWPrYTp/2WGh39zpPbnGEExOTYbEXVfZMQy/1//mg8f2ZlVbTSRnjIZBcOUVN7vvG2/hCQlbBTdNVxnwdzc6w5P1LaU0tXANASc9fhFXfwsu+gsNKbfuJMySDllUChc7ucklGBkSoii+0MvOnmWvN418Q48ANCBdK0YbbKjgHYNZWkolJguoAkldtyuUmL67mCSDLcPcMcLymy6TeA2Az+wZ6QCVatULFDE6LGMgd0FbhojzaSK3WNm+QPfma0KMGXOm92azrdkokR6Fcrag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/dpEfD9PMh0+QCPSoY7svGXND+nkPdJuE8WHtRuwSfnK++QJlV9HAMhEiR2eFjCiuBFe7rB7DGAtakN2LP2QWtAVy6fIexcmYCURThNAJfw/PWYuSG8lyO/KjF03Ct2sArOOVUY7ceyqD0N99EutAZZigk/wYMPP+CZzyxrJS2bVTXKseHSMvIEUHwIhqda7tmLJbXDx4s4hlGGuMShP2SnBKOheUF8KoHKzdblJlN+XNwyAp8ZEA+I5umY1/06O/7F6u9xAZvYSsdrcFr0s+S5r/LOhsMDeqzZguYfjLtOS009MRfE29SA3lRcv7prnuFcYmIuRNBv63TPex64b7qQJOyIHZzYIeJlqkSDQLQA67O8mbNmzben7+8e/Xcp69ffhQsoMdDRWPO/YQtOjjyT5TPaGJvJrHatSIq0Zn5wcxImMLo6QULXhQlON2OfN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:46:39.3971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400e9e04-ba0f-467d-60d3-08defd50a834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

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
Changes in V6:
 - No change.

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
index bef2b031dba1..2319101be778 100644
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

