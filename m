Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F439184B;
	Fri, 17 Jul 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279340; cv=fail; b=rRnsYzx3HlwNWP2OyozzppQbF0Iv5BYS7e3nRuKss/hv0pgvOSzCb2K59SDc84FRMgZAl8tOe2NU4fMUZINlfqDZCbs0OgJ3mW0yy58NiIUZlP/XnWRTsj2nfjc3luwJ57TUHpFK2fEt+8ZfPxkUqHGggCeHKkK8lshwwfAEWz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279340; c=relaxed/simple;
	bh=mjUtIXhdpzFUg4U57oPnaNdLAUpsFYBsorJXMn+rHGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utHBvTWv1+j5/Q0xgeW4fRVEGN5fCpyhVo3M8WEeimXYur04Be8mI+Elz2clU98gdBe/VhJ7gIS4ai9zjQLeD20de2GnDtLGXL3zqs8aK1EGyEaIEurH0Y1Z+O775Nft4E7bLQcb4m6DUu/qz7bID6263RobWpiSWSeU1U5pic8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PdJJFM/r; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PdJJFM/r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZIL+z2eB4E2CDlCbqwoS5fOw84Sqz5J1UNpsOYMIOQo7vE8Dg6XOzR78Vdefd2YT+usCkRotr04QPze8Nrp6lApfz+CPIw/3ilp4Q6/UyAsADAfIJdHk3VFXUjTP2aLn85ZTtD1OFXDjT+fEF9NgBDJAbA4IhLTZwp7I+rd0q5FCY7S88nliHo9cw79wxdPk7/N0G9+FLw0Oz3/evIx+QqRXrFL9uyXlf1CXIgfuBADXQgMVEJKPwKZc9iW8LQuMkwKT+sDBri6kB38NZEKn4arJI1rz9CEZyikh8xussSjswjy9rm0Hc/pQxvutaz7luUnd1yqC+ll9dYS6ijoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4cE7UArTN6RhuHj/AD5sk8PploVRZUygtjNoDSP+vs=;
 b=mnvQOTbEez04R9jUbShqlYC/q6tM8aMOboTEGbg4Z31wP8zh9xZYrJ9v6WDNX/6mMnIiyGX7wKX/xtKf9ukUyJu7Z0KyOZ37qpvYewSO6YVklTKPb32mg64FE3pxonlGF+MfOxSYuDrPNKMVks7Al4rchrXgOpOxZeYG+JLRKDWUncipSZKmqnlEbwbOfP2xCv0YQYgd3Na3csGGY666yi5XHDa2sE3KptauzgoBo1is8D0cGDQjfnYKAYksMIqfnHE1g98GLuCXMD+u8vrPaXDg0mxYW4qGhO2+A2pDTyLCAsikNilz6FP9WzjsM44CIv0xCPtV+fA58ROWxfYeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4cE7UArTN6RhuHj/AD5sk8PploVRZUygtjNoDSP+vs=;
 b=PdJJFM/rXnJlblYkLRxjwKqLpQ5N9LR2m1qVSLQfHWaBrM4tWlD3MSw3j74dxSj6yR/6JhLd2HnQ7mhY65tWuyc0qz8UMHUJA+qU5ni2ynFRCRRXhwzzKzX/W8gj62AJhNDs+/D0RxL6kIUy8U+o/oQAPXpthAXwBDX3krSmhFw=
Received: from DS1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::9) by
 BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:08:48 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:44c:cafe::53) by DS1P220CA0020.outlook.office365.com
 (2603:10b6:8:44c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 09:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 09:08:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 04:08:39 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 04:08:35 -0500
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
Subject: [PATCH v5 2/4] dmaengine: xilinx_dma: Move descriptors to done list based on completion bit
Date: Fri, 17 Jul 2026 14:38:22 +0530
Message-ID: <20260717090824.2364230-3-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a001f5-571c-4c0e-8fa6-08dee3e30324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|7416014|376014|82310400026|10067099003|5023799004|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6/NJZT/5WpLgL5B7YLGvQ+DUCZX6HRZ+si6TB0KuSdUtzMCzWEmuSLZ7QAc2YC16674ZPcZfZNPNsAXBI7wS+JPXvJIa5E51xFXTOoKcVcM+bXj1kIjPEYRSD3Br59FAuqtORB8IbdnH7MPaRzKd6q2ze57isTEVWH8Q5pIqKM9KotPZ45hbWmD7BMFDmYmC6pkns2bqg3VYGiexV5xqElbiCl7zbqeUVGnvzoxu1GK/WsaW2rMpe5PdujplnsqOmGS+q9KcBZWdcXtmfmFuqLswgR/nVKPRP8ofm7QC/o2nZxci9GnSKA+mmJ44gc31Xghw44cNSCZ4m7UQOtbT/xEyB6FTCk9A5NX/yhd+UuFr/EW4Nw3eOKyjSiZQ6V1S4uISNYd1cXi8Xovx2GPFDafcMrdZg4jQQMbNzF4CyXCZ/OwGnZSy8rO34FfJxEIsM7/1kohL5N6nMjUL+fGeZBkTA6o8wElrbwSGxyhB74HVbKkUzWRfmLLyWFkQniA4Kl52lrYHAjqH3uOnrqq3UiYbQuAARqLOYFuOEROBbEJ4/IFrv3HVLofu06cwak7NA96XxjuWc1EbbpYqVbL4WKKGvyS7L4PiCJEe+i0vHw43sT9lOc5bYoCUWYF6D1JRF8YkYVcS6UY4dge652uG1dEpALvz7pFx6CMr8nZllCKNnlcJoD0Rq4uz0wG3GXPOiuKcEcn6UzLNBS8BO07b/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(7416014)(376014)(82310400026)(10067099003)(5023799004)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o9+GtI70uCLUpBJKDhRZZbOFOhg/fXtdkBYIg3OHin47zG1OI0+V1+IR970MRV5a8pOPGKD9Qmkl0w6+YBtCs9PGCUx4Y1R0gFJldoqGHWnUIXh8QdaRffUt8dQCSO8C31dLT+cHhn89heK0VMaajpRB+Ta4yhCG4w1DVg6VeKD/kPdb6uDEf9zhztKuKq+Xz4P37C4SqrzlgdtMQnuehPSXzaRnVfk0GlIa2J6C/zZX+w4dD5GWuQjaeieSwMQ1RT1CnT3ujH0ytf8Svc9rUncArxC8oY5TFHwqyfeJ7K1h9qmLFtXxfO+EEwGvk9hHfic0ILzPJz2vbuAvpp6j7QZLpUnGnnCqP9692FGYukPXzFxeBeUetqO/0niFXNu8NTJ7dfapYKK7QpXkQ0XzDw8SGzR283SA7VwsVBjA/dGks03OXLoHK+ShuyrGjoqw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:08:48.2368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a001f5-571c-4c0e-8fa6-08dee3e30324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

In AXI MCDMA, xilinx_dma_complete_descriptor() walks the channel's
active_list and unconditionally moves every entry to the done_list. The
MCDMA IOC interrupt handler invokes this function on every
interrupt-on-completion, but with interrupt coalescing (IRQThreshold > 1)
an IOC interrupt may fire after only a subset of the queued descriptors
have actually been processed by the hardware. As a result, descriptors
whose completion bit is not yet set in the BD status were being reported
as completed to client drivers.

Add a check for the descriptor completion bit before moving entries from
the active list to the done list, using the appropriate direction-
specific status field (s2mm_status for DMA_DEV_TO_MEM, mm2s_status for
DMA_MEM_TO_DEV).

This mirrors the AXIDMA fix in commit 7bcdaa658102 ("dmaengine:
xilinx_dma: Freeup active list based on descriptor completion bit").

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V5:
 - No change.

Changes in V4:
 - Reworded commit message to reference the AXIDMA fix it mirrors
   (commit 7bcdaa658102).
 - Added Reviewed-by: Radhey Shyam Pandey.

Changes in V3:
 - Added Fixes tag.
 - Expanded commit message to explain the interrupt coalescing scenario
   and why the has_sg guard is omitted for MCDMA.
 - Changed local variable from 'bool completed' to 'u32 status' for
   cleaner status field access.
 - Simplified completion check logic.

Changes in V2:
 - No change.
---
 drivers/dma/xilinx/xilinx_dma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ff5b29a808e9..1b5b00f08c5f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1784,6 +1784,17 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 					      struct xilinx_axidma_tx_segment, node);
 			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
 				break;
+		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+			struct xilinx_aximcdma_tx_segment *seg;
+			u32 status;
+
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_aximcdma_tx_segment,
+					      node);
+			status = (chan->direction == DMA_DEV_TO_MEM) ?
+				seg->hw.s2mm_status : seg->hw.mm2s_status;
+			if (!(status & XILINX_DMA_BD_COMP_MASK))
+				break;
 		}
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
-- 
2.43.0
