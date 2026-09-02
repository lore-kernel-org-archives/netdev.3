Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9018443E4D;
	Wed,  2 Sep 2026 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344931; cv=fail; b=coZp34FsyDncfbu/rSGH6Dgmt37JQ9Nd1WRl5xzfNrUVYh6gg8qwtwjlQb7wF45Z2LpKLdtxshE4rVA7lAMKkA67sPiU4rtkNoI9Dwq8S0oTT4WnsYfuIq+3QO+T0jtz2eD1O7/hfARLWz3lqGbMv03qvGByKXqhVyUTGJHBzwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344931; c=relaxed/simple;
	bh=nV4pQXveoiCjtzHkKUdZYIxY/KI85Z733WvJ/IgOSQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uK62a1zBjL036u0O+nBhHoQqaAZ804qGtZ8BTDL61NzU48rRQxQ50uJOIq6SMHV3ONRZa7T8gbG3524FGg5XhAPnfZM4mLluLukgSNuc1fQhZ/2Ygl4iy5twgAYEBoDzkYkQ5zIoyhr4Szk8ewoJlvI01LQz45d0pRKCmmAzF24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4KYw6mDX; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4KYw6mDX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFYhFpi+sPu/kYZNKCgR9qPkiJX4zz2NBi3pBDpsK20xVtUgI1pSrbOrBwUTW+ueTMhoFRzWFGXs4MVOEsy6PE1NYJ9kSzCBKdzy3+K3+4QLUatPWJTaxY1y8qhIKlzDV4UMU+18rnGiWXBjdc+Xw3os4eplVUdZua9bRmq1OslBGNHLaolxWY+TLX7ehrF/ZSj+gry7atK6cKdAr2H2TVLVktFVM7DIJ+D68VqA8pPf6puWZTP7+S6jik6KNgZohLN5jykHvZdCYYtVmy7os/n7KbFKQwsPlD4m8r/eAz5zytfrAxdJqFGk36QrYyGNT2IUtMuywLGKxDwd+b7d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muGewAMUgpq3XbHTr//6RsU6PIB+RVdkno0iiUO23ts=;
 b=NCNrDGwKMqOe0z+20ZrC1220rDkZKyBdePH8DoD+8MzJtRF5XRQysbznfnIEAJio6+u+FKRL6aVtYYuBZrNazsG9akkMOdk2T7LsZ7oO6YQRWd3OT2ZS+FyDPJZ0ecA+O/q1VTvE1MPWdonpEQeSuRoElQze5QjZyA0HeZBSxYQrbzpLVSeKFtUAXI2OVuS4uayJMxCzZM3Im1eObVm9xQKZ0pglkF3EHCTI0J9bXGk16VZpDsGZPzs7+VWL8v9IdZEyFKnd4ngvJi0wfqYUw5o6n+fqxFlCdTdVmdnspJp8R5OL81APkNhBeZKGVJ/3PEPJQQMcsIr6gCAtK8ETsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muGewAMUgpq3XbHTr//6RsU6PIB+RVdkno0iiUO23ts=;
 b=4KYw6mDX/B5vGG+UA4Fsqu6hTPRCvTKkdunyOM4BwuQa050e7H6cDOTYPgjtQF1vMgNOjPYHZbjSl0YswPIsRxpWXnarKNhDmqVKzUIxS6UqNwvMtxEd6gGQSW7G5DcEK+a5z2ExQWFjkah3XNTxgRnxBO3IDWallTWamPdvxmw=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:28:41 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::af) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:28:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:28:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:28:40 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:28:37 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: macb: fix NULL pointer dereference on unbind with fixed-link
Date: Wed, 2 Sep 2026 15:58:36 +0530
Message-ID: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b70442-294a-4d31-ef2a-08df08dcf559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	p/8EObetm8wbEHvlVKDTNvsylx5mZsCTcxYwaary2egurhDeYjC0pr2LjxD0+KZeJDfkTYdinZRtsSG2c1kwJKSkEkkZsZrQt86cj5X6gviH4aNldwFr5I6SvXJK+81y374zOv34aJRNtkbVYQE6o7nzNOdvUJeasx93Lv5aPLkhsDOVxNP7uKs0NqlW9MBcPBk+iU74CwpkDJRhHgxNzJIMMEMyEKm4qx/5o4amUhe0ec1mc8iSupp43gKSAHOQvjpp8D0f4/CAhtmCoernjhjsvrcpavvnp+NWDZX5GPWrV+5/cgsIqGigsrF2G/HPR+u0LLJFVy3WCuncReH7l1D8+joT/fmMDn9CpgV26FXv4yAyNhSPqoWu6nPr5vZ+XNtxjhWXUN3HlhGo6DQdj2UKp3Kvqoz92B1rTYjrIyqsckfiDHO16G0AiT5BHC8sLgsPxdTHVKBuhi3Y/yiiGlS5ZQ6AA8+MLfKiJg3/pnAyPaQc/dPTINWkHnBq63aPcyCLvgZ/Dzqu7/g6XxhHEt4Q+0ep3Op13KGPVoAsSjVeDH9nsXkr70soD8xDGl0q72NZCbcvifbjllT+PdxNPvkcJ3dpLKl6nPS0En+zpKFsn+WsQIrNQINOk1cxMioxUaGc2cp94B2C5krZqBSiCWUTqxF6SVEwZTfUc+n9njC4fFG6/fDfgCIFHeh3BVK7xNM2yVWPvhPHgeLH4uqeoA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dQrqnL10nuuRq/N1vwUAL1pdZrjBA4IawWIi0gio+NPJ7oI4BDjM2wHwXr8ltekzahW1jSJ7Nz/PoElOcHy34OuOgYlKtGAGCPDjIaWFRLI6ia2yM4OriZxOKCPlbcoDCgVJjaBeD0+XAxTm15y964QS1dHeXMxcSzyTua/3QYQkUbzuzQEvUirC9wiCZnDtFvlUaZUyEi3HVTwbzEbA3ugGxhs9/N96agpjpC7+aTHsAGVfDBsg1oJjZs2NtI1lWyYGk/1de3ZrBGG9OHfTz9EM6IhrgTPPIujFO/uBo3cub9RxpmlrvliE5XnGLDqgFigrKM3PmFQPcq5WVXoFHFyLiDdrBTwEtQCOyG5RuKTaM7tJTutcrevZcTG76twLv4nh0zEgLaDvoiy55Zi2MAjV5BrsmiSWDVgl+kfx7oYw3WopW/FDlU8q3kmXee5a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:28:41.1391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b70442-294a-4d31-ef2a-08df08dcf559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227

When the device tree describes a fixed-link and has no "mdio" child
node, macb_mii_init() returns early without allocating the MDIO bus,
leaving bp->mii_bus as NULL.

Two cleanup paths then dereference this NULL bus:

1. On driver unbind, macb_remove() unconditionally calls
   mdiobus_unregister(bp->mii_bus), which oopses:

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000004a8
  pc : mdiobus_unregister+0x14/0xa4
  lr : macb_remove+0x38/0xa4
  Call trace:
   mdiobus_unregister+0x14/0xa4 (P)
   macb_remove+0x38/0xa4
   platform_remove+0x20/0x30
   device_release_driver_internal+0x1c8/0x224
   unbind_store+0xb4/0xbc

2. On the probe error path in macb_probe(), reached when
   macb_mii_init() has succeeded but a subsequent step fails, the
   err_out_unregister_mdio label runs the same unconditional cleanup.

mdiobus_unregister() and mdiobus_free() do not guard against a NULL
bus, so guard the calls in both macb_remove() and the probe error
path.

Fixes: d0c3601f2c4e ("net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY")
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506033..88eebe187eac 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5971,8 +5971,10 @@ static int macb_probe(struct platform_device *pdev)
 	macb_free_tieoff(bp);
 
 err_out_unregister_mdio:
-	mdiobus_unregister(bp->mii_bus);
-	mdiobus_free(bp->mii_bus);
+	if (bp->mii_bus) {
+		mdiobus_unregister(bp->mii_bus);
+		mdiobus_free(bp->mii_bus);
+	}
 
 err_out_phy_exit:
 	phy_exit(bp->phy);
@@ -6001,8 +6003,10 @@ static void macb_remove(struct platform_device *pdev)
 		unregister_netdev(netdev);
 		macb_free_tieoff(bp);
 		phy_exit(bp->phy);
-		mdiobus_unregister(bp->mii_bus);
-		mdiobus_free(bp->mii_bus);
+		if (bp->mii_bus) {
+			mdiobus_unregister(bp->mii_bus);
+			mdiobus_free(bp->mii_bus);
+		}
 
 		device_set_wakeup_enable(&bp->pdev->dev, 0);
 		cancel_delayed_work_sync(&bp->tx_lpi_work);
-- 
2.43.0

