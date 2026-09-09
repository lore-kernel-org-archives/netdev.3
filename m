Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C856855D;
	Wed,  9 Sep 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963695; cv=fail; b=GFp6PnWsnvN2gSUGCy0dy8c7IgBloG3GSXVySKVFw4jvjnehGmRFpKj33SxyhcxeaVcGj80bMiRDXG62azTkBjZKJuykgSD7maZsFJmfBR7olX4h7iudx1+ZNbl6EqsTZRSO73/W5rzx4pCOwkQeU2zKNUZrD3RC2dFnTnj6+RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963695; c=relaxed/simple;
	bh=AGXlSBdQ7yc/+sQDAbQXrAc8mKtbz0L8CIU/E7SPIgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV7OgHZd3+ZyM4HSUjUyJyd11p9abKoB5h53jAzYdvm/msWDtqbCmJTPidzSbiHksBMBqo5kltlJrnIwD+t0kiJn+m2STt1Z850N1WKw3/SkBeeon4sR5oV6HTtl71wn+h6t+G0GBj4xDA/iOmE233czdog/66etzL57R4vZc3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qq04ST0m; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qq04ST0m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+RISE3mWOqiTUu4ZRaFqpj4kcoyzQ00G8PgAqpm9tzGe/7usIuPam+gmLSk5Q9wW61P2Bk8p1JziL+HpKRTIg4sbfEJHGIDRvScDFaJFfp2A9H2Qv6mDbpuUB9AE+LnJeAOSgFmBjXupbZKaFc1hE4+gOw3zqmmGpBJ7PcichIc46SyR9kik83EN/W9CSHqgzcrOGxuxqd3Y0wI9mOZ8j32qKNBOa2xtCwh+FTX5f1abV9TC53g2pA2cmqYLX3dnHYQmXmCet0gvTBOP3AbT4KTZYD/yBH7xl5ox70X5ONeuiyjpITgvadei/VAF2f+6dxkv/Xcy7MkF7S6I2lMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEMM4i2YvMOqxg00tn0W8VjYzkEBhEyZ8Hkr5mIvyoM=;
 b=misQj8C0pDjjgk86yHEhjrmaLO8qyj15hGCsHhybttuOZnLxT96oZb1W/i0+W0inOB9weT2WqDult0vZgWC6BWWvpzVZ5fm5t890t5RU4yzSUogYQzDgiRytaamlSoJr5DxKT0Q8PIunNcAs0BIN8/L8NwEkFktmPVkuxWpULnGnZ2j3chQYT5/PGbaa0Pan3cTP/Ibhk87AU/6G0pvgQPUSjr4RHXClOeWL6R/qWfBZ8OiOmE+ZtHvAH40SJHhKH2qw2tLhGN753aYmnb50ycQIP2bou7FMZfb7EQRYu+oc1yxzGjDpNJiFgJOCdRDtsq8sggk2OAhpCb7a0ZWQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEMM4i2YvMOqxg00tn0W8VjYzkEBhEyZ8Hkr5mIvyoM=;
 b=qq04ST0ma+kXcOwzYvIHF47beWpo7+/UFyHMl1wIFu2uQmsl1WyYxqWbRed0KMd8eJaj/Vu70MqZLcfeXZgC5ILuKxRkEUIyFVF1dSe2XHElkazIuySVtHBF5/z4GeyLZTIJFo09P6DNoshBx2JzNh6skY2WDFGyhPHZsfSRQtM=
Received: from SJ0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:a03:33e::23)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:21:24 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7d) by SJ0PR03CA0048.outlook.office365.com
 (2603:10b6:a03:33e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 14:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 14:21:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:21:03 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 09:21:00 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 1/4] net: macb: Rename MACB_CAPS_QBV to MACB_CAPS_TC
Date: Wed, 9 Sep 2026 19:50:53 +0530
Message-ID: <20260909142056.1433875-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9791ff-3bb8-4c7b-88eb-08df0e7d9fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NRLRjfb4Wfche6bu5c7wui0h6WkyypaHiYRFQXVgevMwCcuAhKbjo5fmBTs92euDrYMBiEaeiUvit+OEAcTn5Er4ih31G4pEfx0G8O3OFkbtuxJt0LmLvAATmvIPnhzmyS6JkeZEiuIXJ6riNAnaatyKbDlpMAdmbVuCQAQcST1b9g8OnyjvcG/J3BjP3UoBFMe4QIBBGzKfc/waZo5JQ8fEQFPH1U13Uyz//H+/0hO7uxy2eWwjBz+FvPZuGPVP9ch1Fjq25pqn/uT1gjiK96JV+jqAtY+X2ppRznu51Z+rM8h0kX6tOZqpfDebEAR++S5ehn2sdiE18414oEPM0WAij0CfO9EiFCc3TsGaFoIeMkbiq+NYrLw5mUXAp5ZgZ6Jw7QojXGe6yxKn7HVNeJIZjUuJdNRDA+bbM5cm81voBj7QLoP3R6K//+Z2F2C0WBBswOdbxnsblVO8dWjFUSudXzG86itUvrGfLqHuF7UVq0BX+y7hw/R4YObxJeee8HmeWAX42DO0mETzqsrkE+3DQZhuupupMmdkadGqBdjpEvUj53zU8EBwShXE91atc8dEOch85wuLDvvEJaG1NVctkiydycxK4DUQk6h1zM2tfYUTc7TBk/BbpKRFYeULsT0oqiqHSCUEIPw/hnUlnNwcyryAe2JFi9TcXRC+y7zitE2edKQ7PojYsizezA0MdTqGHElOgUve5fm0K48I1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nsf00pEWAQFwGCYwda2evhki6gwEzguyFvOKNX/vftnWFZdf9Dsh+m8la5UPUZzwYOJpygmWtWv75NaSynAZJbRLXDNH7XkJ2CStQQKf19W3I37BWk21p10OjrviBGtnmwYDbtvCSiA8AS6yr0vK1Qo0MVkee4Wq/11g7pCOny6QVmCBsGdZyefMhj64iJD/IiXbHycKrJQpiCxCGsZgbP2dg6WrPEIulg8NzwpKa98DSzV0VICd0ghJ84CEJp76lAlCSuS86MRy/djYp+wTDJ9TD7k+FdyQbtBusXIKQ0XsZQPJ6n9N8h2DhEsvO0OfCGKG4/lZHtmK6RdLZ/073raQ8phc1PBWUpWHtI69fnHqGZQQ+O7rCLBkbToUcD8AAVWtBjG3xlfIa9erOrQn0PXS8qLBvNbzrDVPddUljlijWT3iWq2nchBTG1clHuP+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:21:22.5079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9791ff-3bb8-4c7b-88eb-08df0e7d9fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080

The MACB_CAPS_QBV capability flag was originally introduced to
gate TAPRIO/QBV support. However, GEM IP versions that support
QBV also implement multiple TSN clauses.

Replace this with a generic capability flag that can be reused
by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
better reflect its role as a general traffic-class offload capability.

The supported TSN clauses are handled through macb_setup_tc().

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v2:
- No functional change; rebased on net-next.

 drivers/net/ethernet/cadence/macb.h      | 2 +-
 drivers/net/ethernet/cadence/macb_main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d6931c41f39d..f5359549f3d4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -768,7 +768,7 @@
 #define MACB_CAPS_MIIONRGMII			BIT(9)
 #define MACB_CAPS_NEED_TSUCLK			BIT(10)
 #define MACB_CAPS_QUEUE_DISABLE			BIT(11)
-#define MACB_CAPS_QBV				BIT(12)
+#define MACB_CAPS_TC				BIT(12)
 #define MACB_CAPS_PCS				BIT(13)
 #define MACB_CAPS_HIGH_SPEED			BIT(14)
 #define MACB_CAPS_CLK_HW_CHG			BIT(15)
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a427a5b9d894..8223ad81215b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4823,8 +4823,8 @@ static int macb_init_dflt(struct platform_device *pdev)
 		netdev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		netdev->hw_features &= ~NETIF_F_SG;
-	/* Enable HW_TC if hardware supports QBV */
-	if (bp->caps & MACB_CAPS_QBV)
+	/* Enable TC offload for TSN-capable hardware */
+	if (bp->caps & MACB_CAPS_TC)
 		netdev->hw_features |= NETIF_F_HW_TC;
 
 	netdev->features = netdev->hw_features;
@@ -5693,7 +5693,7 @@ static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_QBV |
+		MACB_CAPS_TC |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
-- 
2.43.0

