Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FD314D06
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679405; cv=fail; b=LeB0/8hF36rgvi93Fb1mmvdq/a5+TINu905a+vcwHdrsH9lNpxa118+kd1SmxkcPezgI7NkXSwcYpCE8r9mmxqF1d7lBpMaCiwmHhcBYp2FfkCqkZD1jqvbFKJ9Evatphakd+qAnwx3b5EkTnpz15nyjSMXmzvfzbzok8mDxMsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679405; c=relaxed/simple;
	bh=qBfwjonooOKsnDIsEjkVC+d2dEUuxf9kOsuBEOLoh1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qO/Ey3HaC9mpyDxU8si4EjrMTzFIKTLU18uXrBLKklMH+C/RHVQ5IQ1hUm6UQJi23MB5hx9s6HUZBFlcOSCQtXAXUlYZs101SxTvaV9B9djguwknHQgd9DTYjSgLOdUY1Zrz5S/h9rZNvWV+dJfow3HSAeEYonetBKW2SyP93HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kox0/B2w; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kox0/B2w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl9w2P+9RCcZelVzFfE/bK+cpmVmCk2KKrjz766H91wvEskBTlaIG7e86ZRfsCcllaYJMuy+cVOf9CYWgFnONZA9mBDvZZpmHRmKl6vAM7g1zz/9Rz5dwU5GcNuGzO3Tona5L80lFMALV1y+WkVXUCeU0lmMl7CBf1fXhxoZjraujYRy9sMq/y9r0qPqClhOdQPsxNHak0d1CwxoyB9YlgHMZfl6k0LfSG2BTrJ1hxXITqlDyCUKIs3MgqdulBfQeVIrV+bHuBpHvp4/pNwk9nAkpIatn85ffRc7uxpqNvMQ4wUgDz++7QCQGIW3qkD2fgruU3lIfhBqH6dfnYkoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad8OMHGm8htEAMJyNJd9JwNAyKyNxPJYgkZ9kwgBAdQ=;
 b=G6BsPXXgWJrpf2M9gs5JG0KCUZwsKP7iH8pslxXmlLn6z/fOXcEgG4n5FgU5VnVHmRvj4QhvMBvEdgmJr5/cRiCuqS0JRCeyLCqK6tsDQ3IXa5YyuATh3Pu3CMNm9LbhlttdMLcn01VAaFL1F3VH2x9rgMu04gvisbk2awEIdB0QY4be0cBQNymCMTX8tmn8BthSF2DYfjo8KbDRovzgUAO4OS6ZmqH2VDaCbn58NJ7Ts65v+qZKxMtJ9TxP52W6lDBL8MKD2tZKnbiKGD4MeQWf8xAlJgBvc92QO/3tc6L0rNuTfyjAVU7sZ+4SesIFhmlFoz6CUM+H7WKCsA6cQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad8OMHGm8htEAMJyNJd9JwNAyKyNxPJYgkZ9kwgBAdQ=;
 b=Kox0/B2wGMgM4J/ZPHi9PtmWdWe6C3U9KMToym4FxWYwW7WG/SodPW50WLJtIOzN6KSW1y8Q4ez0vPnHqS1MQ2wg3Czn+aLGFyqG2irzc9Cq2xJB7yPQ+TZ8deE1+MNEw3VW0pvTrkAsUT8E3VzRCEVLommOGOVKzDG7AUFXjoU=
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 00:16:36 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::7) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 00:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 00:16:36 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 19:16:35 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2] pds_core: keep the health thread stopped during reset
Date: Wed, 22 Jul 2026 00:16:21 +0000
Message-ID: <20260722001621.22527-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: af3ac101-3b67-4ac3-d176-08dee7867e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|13003099007|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CJzZEr0Swt4dO3SMwHz00yyrcL/6JB0xleU3jbuy6t3CiEMtzHsv1i/gcoIwDeoV2htSFeFD/fJ1dtqqYeSis7b0hlce0EOGEkGIVq+/Eq7RyThkfBldl+vUAOMFZAQ+lQfXc9iRIZapL7IIVfILegjjouFQKYzF1MXiAtYJnlQgxzz26rVJsIH61TZzaNtVvM4x8oWcAFJc9qOP0jfMXJSnxdOzZCqjZ/AFxceoowGNDhCVcw28INUf3PZ5ojz8p8jFLGqD2L9swr1Adhu1no3Pjzg2OIa9wQtwyAx3Fd6Ap3JAB5FIDHgllP1OzIK8+NeE2qPNDvPqybElCsbY1NMHl7g8lhkqc4oL1Kg+tpEhqFlOg4fBQcWQ64PfxQq+wHOPoD+9vuUFw4KEUZ7SU7GRzaRea0neWQanx2PNnP6hP2fK0k5tkJvIEapwhsr6DcMh9DaZd8OQrvt49w3H6jV8SWaVLdz88myGmWAKoj0Z1ZaOvUXbjYnTEgXXmz6liLpfTQ7yC34rQNH67Poj8k+vlvaVKRtR2bFiwA4JF1nT/xXFoRAXsAwe3bzszLn1rDSkz9cmHspV861hncUgmLeQGfcO8XSSYrvV6bGLM53UwxTbWHcAdPUwezuwtKsKICiXLif9vCYDyU190gTV8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(13003099007)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V0P1X/IGjCGSIRLsuYUWhGWpqk4nigFJo+YFNGxy/WB2YKTD0XMLy77+0hkOpQI9EdLaE0x0/MDmC7ov8mKFo6GwzH/kQI0H5WYAxzA3Bxks0xyD6IfJqlvZ/ud+g2AoO0ZTXZMsJvzHNSjD8Q4w24eQueZucH5a+AfBwGPJtWR9IcMAHY7icED/o6RuJ0cYXtelEiCeMNdncyzkU24np7n+uk7F5WHuclBHrLuW+8LXcYNOb9NJUt4M2GlBb2+A2ZaNGTdKyPGJDWHIcNQW0Idv5cl1L9cfXDm0No3qFsh7bysq0XV8Nc8CWkkaXpRC/gp5khtaLVMUjz7cxVlyPv278wmTDrgvTbPCMsqv5HMbg4agHXnJDagqElKWpC9BMLdlBFQi0Ysm2wkeE7pnelCR3V3eHG+NsAJeMbF9tH5UQJO6g5sJUv6EzvCXFsvg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 00:16:36.1741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3ac101-3b67-4ac3-d176-08dee7867e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

Commit d9407ff11809 ("pds_core: Prevent health thread from running
during reset/remove") stops the health thread with cancel_work_sync()
before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
health_work, so pdsc_health_thread() runs again mid-reset and double
allocates the core DMA queues via pdsc_fw_up().

Only the reset path is affected. On remove, PDSC_S_STOPPING_DRIVER gates
the health thread.

Use disable_work_sync() instead, it cancels the pending work and
disables the item, so the pdsc_fw_down() re-queue becomes a no-op.
pdsc_restart_health_thread() re-enables it with enable_work().

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..3e34350b169b 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -465,7 +465,7 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
 
 	timer_shutdown_sync(&pdsc->wdtimer);
 	if (pdsc->health_work.func)
-		cancel_work_sync(&pdsc->health_work);
+		disable_work_sync(&pdsc->health_work);
 }
 
 static void pdsc_restart_health_thread(struct pdsc *pdsc)
@@ -473,6 +473,7 @@ static void pdsc_restart_health_thread(struct pdsc *pdsc)
 	if (pdsc->pdev->is_virtfn)
 		return;
 
+	enable_work(&pdsc->health_work);
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
 	mod_timer(&pdsc->wdtimer, jiffies + 1);
 }
-- 
2.43.0

