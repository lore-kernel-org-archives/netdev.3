Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F63B388E;
	Thu,  6 Aug 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035782; cv=fail; b=jGWNxTd0YLt/ZUs+FIBX0JTflvjQ3DSW0NsiohJiAIZ6k3JxZx28g0UnTDSQGFYIDZ3useo70u/JKqjHfuY6Zs8XYgFEjxIq4ytGg+xMIZj1yktYuzpIuxHgqH2cRP/ocr7LVsfjqgBf+GhKpYrg1/5aRoL4Yndpfip9W+2g4Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035782; c=relaxed/simple;
	bh=AH1b2vP4zDE+VbTMTV1aOQxlqyWouky0eTU83jm+ZHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kk6hScNBqbfL+kFHMUIAcjKujJUPFHgJ4mmC0Odbfvq4IKDXTH3jP7E0zhrQfWpLDeqcDWqViS0LMaCxIvInvYiL3+YgVxMj235tyGar5e2L2OmNtIM/1l2scZUYQw3e8xKle0PHvNvplleEzABcD/UBjG3LA/Dmd+z8pFc1bcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fbjs33RF; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fbjs33RF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX1kjh6VS7ak/u7H3BS9C9s2rg/2jcacK7z8iDafpRCfnAqr1CwC9LyAYniMhOQrvise9a4OxvEW382V2LiiSjM9OPCjJoJfQ/omtkNfWjDQ12d+FkdsI/M/mCDeTBizko0Yvh72MvVNzbR4QucExFhA+0FoXOZeueo/UFXM0FT90L982FoTRBenwQeKEFu6NQ7OJFNyCuj9/E6PafMSQ4AYZ68s8YqTygIleWU0cGCr1idCbUSS0AihPs8+yCzJCIwH5AqcbLSQzTngiKTdoY428hB8zE98PKLp4AKjN1cQZP4RLmV2kWdaVpU83T4/SbYe0ZspcfIrDxlwVOca/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcJ0DVuHP7K4FsoT3ssJd8kPfTTgCTwUYTzhOUtP5mQ=;
 b=j0QgI103D4ycUZmEFIw5Qovcqe2eSbijNaWYUUOJFVJMB5dXRPnX2gLRWgMQW7ylgvfQ+TXe6+xxH/q12oFTao/0nSeBxYNoSsyvGpMsb877qJs0JOCvMkOhtI0nRCsj1zdF5vubp+5oUPdQ65jlpB/Ma0eEe2ANikyoWHG3aCaVT+JPAD8O7Lmfel0WUQfdLNNplUmJEdadqrm8GOKp1nuxyYkcmXQeM+yDC1BpW9zerKjHs7Q3iJJQtUcJ/pIWe6lBfix3+M4RSP0rfcRMMBTSrOe30zTpp+9l9tgLizhwFlM+YsFHixaVqxqqj/iUPSpAFTsAVRFuFDzx+SgIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcJ0DVuHP7K4FsoT3ssJd8kPfTTgCTwUYTzhOUtP5mQ=;
 b=fbjs33RFlluvsrC9p7kVOZ+vit82VD1wF4nSkAuYQeKS+P1yjWT60+aG7X2a2mMRdprQOKtxcXsQSxbJhOhEFGHAioBkM2MApp+yvw7ZsGyub3ncgDRgWvK4eFlOfy9IvUVHGfmF3ZrSIZ2jQlwYUuVYRHuBV1/bC2OeQoeuDeo=
Received: from CH5P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::15)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 17:02:57 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::69) by CH5P221CA0007.outlook.office365.com
 (2603:10b6:610:1f2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 17:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 17:02:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 12:02:56 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 12:02:53 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: xilinx: axienet: Treat xlnx,rxmem as a required property
Date: Thu, 6 Aug 2026 22:32:53 +0530
Message-ID: <20260806170253.1199749-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 0135765e-91e4-43ff-43d8-08def3dc9014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	D6F5OLfOWCYuEvQbRnWBPl6WcEYdndttPHFoSjnPd7eh/8VPyUtOxIkKf/eHWJvvKKiCdzX2RS+C8HfFxOObxFK3zAzaKQOlx0Y4VIjZkuHpzXvr9bML68e7h9SmCcAVW07eYGP3J7EoHkREz3ORR5DmFrw9NTXWuVd2SM6UlD9egdhqXpJLiON/yCp+r/8gzuqhUclcvjZIm6vKMsLy+fbFc84KynNjjjNOq9PQ104cKHylo3i7pMfxwgQlEwcND7TDXtIgsKCxJji2g3mkioBpjPb2hnmpnHJX4sVx5tApSQywKU8h3rTmgbYpX5MAv0SahqDc+vrdvqfQ6Gcf3p9xXgq4sCkko71OcUnHTdSxix3gQtgCbTU4GMatBReH4F5dY57tgWCFyTUgxNLNQCmInBQZpkWMoOmecqmm7iMv7OxFSCBh70b3b172AgwfixdTeGSIm135OXFJFUDw8syh1DUTI8L+uOpJcCM/pxBUomw4fOxcXWGJ2+8vQfkcJkkjS0/th1yx7rljqXHhqdUj3qLjcb0JfmrwjUHym+K5Y1ze+6QxaicMywtvdw7UEIuqIpPu91g0QzINunmeA78img02QrBMsQ7UsxP3A+qD6y42ueKrrNkCDEiQGI9kqxwswBTZsYoZXWtfQ30h5sJu/rhzhxAFpuy2f7YsxFtIynfRnEHxgzOfN0BYPGFycu3qd7qtzjQToCH92ddjVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WKBU0eHAlCVzBMiuY63veUBmrSHaqKCo4LBIDkldvrGku6kdfHTcQTAACWbKp5GOnLIIzMhEoRpD5AKmZpQiKs328aInNLCpIx0i0chz/0YzRAPHotzw5O2kpnbZ6MnNnOIRXqfQz3KPtObemRJm9okbz1C0QJ+1fXKJxvNMYqs7wlY/OmwrnSX1wJOjWeTyIpWbOjYoRSbqrtyJEFjcvmB4qmsiEcMZ6ZBBwpIEfkR9Pd3i9KM7NccUWQT+ronuBjVuIzEy/xIJxtAp7mzDv4l1JIoGScp/4q5dmWhZCSm1qP0ytp/rIjv0E9gGFueUfBNO1epizjvcP+NGcBUYt1/g3PXo4ro5o795xtGUB0PzguVt0Ry1TSGdM6HESd8pGV3Zc4IClmrmpM22anc8Vjd2b6h+85DSYX4SjnPTlyHDOIFaMx681DtOY3Uh0fmM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 17:02:56.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135765e-91e4-43ff-43d8-08def3dc9014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

"xlnx,rxmem" device-tree property is used to learn the size of the Rx/Tx
packet buffer built into the ethernet IP, but return value of
of_property_read_u32() is ignored. When the property is absent lp->rxmem is
left at 0, which silently limits the interface to the default MTU and
disables jumbo frames with no indication of the misconfiguration.

"xlnx,rxmem" has been documented as a required property since the binding
was introduced. Check the return value of of_property_read_u32() and fail
probe when the property is missing, so a misconfigured device tree is
reported rather than silently degrading functionality.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..1722b7038f34 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2898,7 +2898,10 @@ static int axienet_probe(struct platform_device *pdev)
 	 * Here we check for memory allocated for Rx/Tx in the hardware from
 	 * the device-tree and accordingly set flags.
 	 */
-	of_property_read_u32(pdev->dev.of_node, "xlnx,rxmem", &lp->rxmem);
+	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxmem", &lp->rxmem);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to read xlnx,rxmem property\n");
 
 	lp->switch_x_sgmii = of_property_read_bool(pdev->dev.of_node,
 						   "xlnx,switch-x-sgmii");
-- 
2.25.1

