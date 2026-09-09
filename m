Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7E583AAC;
	Wed,  9 Sep 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963699; cv=fail; b=f7q8lRhXyxl8MGdsWsfrmIaJ2ydGjmNf5QOit6n5HzulR7PFVnM7qVN5/xH0lNdjhTn5Y52HYyEtoQNpNBpkeZwCFbR52Rbntp+IMqV+a7Fjlt5FWF1PyTDEt4STU6xQGdGPUM+XCheZVxjOkE7Z67edOsROgwqIMKQ/FmhGcWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963699; c=relaxed/simple;
	bh=rsqzPeqvQxomQx2X+fY8O361BifKnNMZJI98REfK+TU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRMkEBbFUFHMJyLnj8SNiXJ/7zWXWUDjNoDAcnSoGlmgCPKMvIOOYOZ92eMEfpWfP7dWZEtfBiH2+Fp6Jq1h7zW+m1wiCn2rrr8irxOWi0IIqr3W4GeNvgYYid1lIsGnXurKreY+NoC2iOvvuBxQvo7jtLlWlKL6Wj2s2xf/GWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6FrWG1Y; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6FrWG1Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjouS6skrHmBsl8RqpnOnicrmedxM+X6DyWiwtUJBqxY0uQ+9DPg9Re7HiMOIv57TJhIr/Dz8SALLceHxljPLJrwUbYDc0Ga3uXcc9ZEGXfGGfpRkv1ilG+sPlvC3sXjDhEeB4HIhIJGEbc6xnF0RE7KpmEnvQLHJKUNvbFq0AoCsJYwuFFmzD8k6vYKFe18AFwiIUHYsXNUxfMhPjMpcL3yrB5yqpmFtvl5rA+NUCH7YhLqr3qbwQj6SVMA7ncqW36JKuKRejGDbtK7cPueJJ1/A/IQ+drquTeDQaoMd26KjI/JC98uiLsWuw7Ga99gRRzojSTml7is2+qloFzcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEwmXTD73KeYoMHw7cygkFHM2inYbhhAk+o81Q3+97U=;
 b=ARejUCgx+HhnB5xyDHuIHbmhdq+UqciQGu0zVqLxiRt6oGpfb4qQI0R+3LfdzO4zdyOWkjk5U8vCj0IpouvVOOX9j29Q3okqqJirtIMl7ZUFcgFSbpSE2dbAb05adrYWwsqXiMttQ/MZunLbsPRIfHKNl1oKREylWeGTeQacdRY9HV/UXMFiC9R19oMlBz8DzTDXhC1wZXBWpuyHa7p11tobQmKh3TaO7vEFkOHdzqbCOHy47x2Qb7MGdSDEjhfLz5Y//p4ZwAOuZrAVx4mVQ6JuQYAiS3ZAd5rKEMXyT+e6dteINjyO+6b1q5nqh9QISleYVvs9UshMpxY9W4hPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEwmXTD73KeYoMHw7cygkFHM2inYbhhAk+o81Q3+97U=;
 b=q6FrWG1YiXTzw2NXsDessNYrdUQ7MxMYhF/vok31i335FvOoOC2AzDF36dOLYHOW5KT7M50AaZLs4LVRdeCrbCgvUDRtDXSALxZ/JtW5evowvtZ8TMwE9d0tFtl2VYvkpdswPItinyER+HuPVD5cJzlWBc4YzEXjjunodMf9s9o=
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:21:32 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::98) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 14:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 14:21:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:21:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:21:06 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 09:21:03 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 2/4] net: macb: Move TC capability and PM checks to macb_setup_tc()
Date: Wed, 9 Sep 2026 19:50:54 +0530
Message-ID: <20260909142056.1433875-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1559fa65-a7b4-4b67-902a-08df0e7da3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yo1mxy+8ypwv2E6zMgFNx/Y+xd+vE4GS0ymqA8SylsMHrsRVLcusGQe1QuT493OpWwfbPGYUNm4wt4cz7vVq7viM4Vvu32kz4VnEh8xdriOTxUbg9BxsDSBtrdNeIcyJZFxcXza4EXKwlFf0HSmVrgVIv8yOip74mDZW4Tmt+VGOfY0+fOod+He/Eg07Ot46spOz1JuFjDltelKQPWJnZQeQ+A4nb+I2/CvKqjzhHSEFT4L494g4c9hJq8jZkOYtiF3DGZ/24MPoAyO2hor0HJsxKQ1HlfnIYLtgaSSCFoWWThylD+lSMHy3AdiXoZoJ2fnVNdgc15DJtIM+gIyKlFFzHmO88t44Ej97Rkrx0ibRmB/wDHOG5bNpLL95j/ArEZHIxv27UI8hsYAiiuwcJ2HHC1ynf4Gk+9La2rFIVzvCe7cBfmh4Zl35xXOER+y7LVoVyJ39DL5aQyhUy0h80uZ6mZTq848dHAIjMrN7Fx6EMnvej11SBjwFNwp7dcxKvrQEZHSKdUiDO8E6qiByZslk8P1rothncz0oRIRL3yzGIZIXeKfw5ngb37gGPYKFy+NJ43/5ZFg1BpAl4it57Bx2Sn7BmGR8iR3QKqw1UIMGP6/0hUYl0b8EDmAEQ6GUEOLyMo8zuyHszk3ZvZ2WnYl4RXZqOjbNV3xwCcFz/lbKSB/gsyC1xp91FRKX33ScCpn3GVTOthEuesgJsUYLiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z/i1xst8/Sn3rZsL19Tz1XY5OaWTFX3ichvJoK3HzbIBXx0UCdEnxkAxfzZR6EYqkvsADAe2ZbZKPZ0M5k9LB5Zi40pNG8dyneyrwYN6EA3JV6Hxz0CHpMHnj1Kivzj+Wkob8dMIPK4vkqItKG5XsahT/6iL7uBvYBjOoRoigylUDFWlZHSlozzVK3aIj5RfXj018MaMb5Ph+2z4bF/+d5vZJoxuKR1YGo0Cnf64yQwXzTV/87PB8kdiMrQQY1U9s0TCJb7WSt1g+LU6zy+DAm/BvjHmgrsz9S4UpHslF280x7D8A7pyPsaWPdyDhNUExR1ALp4jNdXalR3iGlNk8cZB206ToFte4Yky7Igvt1ha1e6xuxuTwTGh/R/okpn9M9+S7LFLpeMKZ+hhEBa4/tj+exL6GdTiBLRRojYcFrsZSqNPBjMfbtg7JyhwgOIj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:21:28.8044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1559fa65-a7b4-4b67-902a-08df0e7da3a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

Move the NETIF_F_HW_TC capability check and the runtime PM suspend
guard from macb_setup_taprio() into the common macb_setup_tc()
entry point.

These preconditions apply to all hardware TC offload paths routed
through ndo_setup_tc(), not just TAPRIO. Centralizing them avoids
duplicating the same checks as new TC qdisc types are added.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- No functional change; rebased on net-next, which renamed the
  struct net_device pointer to "netdev" (was "dev").

 drivers/net/ethernet/cadence/macb_main.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8223ad81215b..ff7e02d3fab8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4476,18 +4476,8 @@ static void macb_taprio_destroy(struct net_device *netdev)
 static int macb_setup_taprio(struct net_device *netdev,
 			     struct tc_taprio_qopt_offload *taprio)
 {
-	struct macb *bp = netdev_priv(netdev);
 	int err = 0;
 
-	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
-		return -EOPNOTSUPP;
-
-	/* Check if Device is in runtime suspend */
-	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
-		netdev_err(netdev, "Device is in runtime suspend\n");
-		return -EOPNOTSUPP;
-	}
-
 	switch (taprio->cmd) {
 	case TAPRIO_CMD_REPLACE:
 		err = macb_taprio_setup_replace(netdev, taprio);
@@ -4505,9 +4495,22 @@ static int macb_setup_taprio(struct net_device *netdev,
 static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			 void *type_data)
 {
+	struct macb *bp;
+
 	if (!netdev || !type_data)
 		return -EINVAL;
 
+	bp = netdev_priv(netdev);
+
+	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
+		return -EOPNOTSUPP;
+
+	/* Check if Device is in runtime suspend */
+	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
+		netdev_err(netdev, "Device is in runtime suspend\n");
+		return -EOPNOTSUPP;
+	}
+
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
 		return macb_setup_taprio(netdev, type_data);
-- 
2.43.0

