Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A734FD270
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105435; cv=fail; b=tIybxXy3Kfqy7mzL2qZE49FTGfy0120PS1LojdZPAnK8tdd3HqnLwQu0jCX0eNWX9s8YhDeuJzWvkRsU2fbPqV3YAZSd5dLz7x2+AOIIAe7X76lTma5qFl63A4srH3q9szm3J5paOW2emx5HHxvItV+Pp0Vy6xEBcYyk5P94eFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105435; c=relaxed/simple;
	bh=hs4Wx6gexuHWNyabXUviD6AUtfJIBFo2W6/pww7endU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OHvBDPFx0XN2vTkYrNurtfDzZDvo5WIuFs+C8AFQBG5J2gccwP6PSpA+44qhVE7OSXNWsd/glq1d03ItJ9GAg6VjDQIT4jBVhRgJNVHFHF4GWeS4qIY1g5U6f1glA8dGZKAh301K5yutelQekgMrOyP1jFMeVgYb6YdvB6AEm2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nyj6YRaB; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nyj6YRaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuRvWU4SRpjdz2GvSvAyO9CkllkjltGf0tLO7Q53f+qqyoPeDp/vUupHYdRF1WkOIukPKWQZz7S1FP0Y0/aiBa86zzxPKmVKfad8AnafqrH1+6V+NdFzib6VrasEl6+GrGlrMOSeD9HnQV14wFXMZoD6CdoRm9y+0YzZTQlzGAylUcg8IxJPEdKZcM3rlGnEpIhOGm9ZSVtGr7BmcKT0XQvxokRAbiyVPU9G9RVTEdpe6RD7y6RKJrhqhkc7FC2yh9c3EmSnp+W5R8YEcwbh9htzPR8zHNmX2w5bwm3mK6KuCNPJso8Bza+dQlQC9ZskvjnQOVe0hzl9HD+xru1s4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex0+DKtpL7sZJkQbz+MEu/tpaCFx+x1vj+d/IYSwY34=;
 b=ZEV1Sbc23AO9DYYjtFBjsDAwx2iL2dNnGWwCIbsePnQBngRbHATqVCjhNUJS1FHUvZsrDrDBmwH0bIRq96k+yNFp/UVBCyapIQ3BOkPq8skfuqHvsNyUBNDcNCMZcC8f85mnYqsNbaD/03LK0zPl8c1VcKxD0ppS/7CNxxJPgVfPL0J6GQ1/PcApMdru5Fgx7GQenNhDbHjw6ugcdGDIpORaTT97yk2Z4imQZ2MbMcp4M12lD8RK45HPo0IOlzdGTlpS8JcWnmJdYPV7Zav11ZSJPR5BCcNFo+Kt8hWEJSNqCeGDGwzusn6jiGpM90avg70kM8Kp19r6G/YKU7Z9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex0+DKtpL7sZJkQbz+MEu/tpaCFx+x1vj+d/IYSwY34=;
 b=Nyj6YRaBhZ5mdSLm7OQWNOdRvttDACTVG1Ca0yYgz4o+D/12nLUd3hQCRgyBgQcEWqkaZY3wfIgyrjUICjjD9d5HIFLZeYFmSEW37j2j9FQy08z6Ydmz4CahgoRbwzcrLYFe9mzeXB16KuwYPwEgIjT4AQtZ0d+pqIb2f7PgaqU=
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 23:03:50 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::9c) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 23:03:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 23:03:50 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 18:03:42 -0500
From: Eric Joyner <eric.joyner@amd.com>
Date: Thu, 15 Oct 2026 16:03:30 -0700
Subject: [PATCH net v2 1/2] ionic: fix port_info use-after-free on firmware
 recovery
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-ionic-port-info-lifetime-v2-1-57232013fd79@amd.com>
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: a722e8b1-186f-43d7-40a4-08df2b10935b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|22082099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	IvtRiWr4crcnpB/iiiMNEGDvsvJFEukSiYxQBnHmSdFStwTod4JTnxTijOSMZUPznF9vpp7pbbQS6fKVsiUplceOtGoq4U3wAR86QJlEaNyYsJeJKa2m6MTmQQX1/S7iTd7T7ElxWhXLWKeofRjAC8fWLWnf5IYJ1WdU8WKhD6JifQf80VWv4sDbaszsLy3u0BlNmMhW2GEw5tL0f1eOFc+rN7scgFu424fpNl4g4KfubEjL5Gg1phSP9KKgj/5BhHENOamqD3MGOToVli0Nb2ofRL6Lo4kLnX0iL/rrD7uOzR4MwMIrmJdXDA/+hRjU6bu/ygPEo2OV/c850zWrYDqD7DnX6ATgSMwEM7H6gR1KHgj46wa5XKi8pMKs6kUwQTSBQYtVi3p2Q5wlCCjy68SWSmWjclUmvHi6ThCLa4kxkpiGzFO/7T4ALbpasYJXpOy55MeLOXpfo7fjjfca9A7NomcvV5X6vW/2LUg5xS/On91oUxvN+I6ZCrYuhH14iy9rSPaCfMflUsX1JNqR0pCL5VHsaWrdPaM36PJfy3kiHnwqks8Aq74rIUhtjEwT1toiZpuycv7dyRi3z/XFgwnFWcNfP5n5TuZ2ob2sLTc7WiY0bbiHpuuUTLTttPklqz7mLxAzSiesnFdviJ6Nk50bk00rRFPM9S/cQ7/ep68Q0B9k6UuYXgqxqZngMliwRCR0qe/HsICmmmDwKNq6VQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	As+DgRM2OgfCHF3eSD7EzTI7XMxC3En9F15dLxtENQecRt+nsinHSjE0Cuwtvpqtz8biNw1rtD7edrdz/Y/slnFJMTo4126ujaYA06cun+0kqeUPlsCaIk/7xHarr7beys4oQTW3G3YpPyMifUkFPyscnLcKcui4e0y/j9tiC6b+5fvLb0LRgiKGq+LbmLIMuzaDCD8S86NyD94bk0Jlc5BTT/nI2S7Px8MkANezV/++Fxn+my5pIsWT286xDJWlnRu4YrOhvBdm7WauxdjAkkNMvw5bGv7F0PRK1Z4pitlUDISOznVm5+uuw8tdB7NV/fSw6pg0+cst/ySZQM//V2F36dxd0Nf9hgBf+XF71DBGC8WnGkQJ9q9a5IyRRjAIEIUAc9GwTJENRnYl/pV+cAwv2e7GQojUwPl1JKbplIB/pww6X3NdOSIiyfaBluA8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:03:50.1181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a722e8b1-186f-43d7-40a4-08df2b10935b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041

From: "Nikhil P. Rao" <nikhil.rao@amd.com>

ionic_port_init() allocates port_info when the pointer is NULL, but its
error path frees it without checking whether this call allocated it.
Before commit ddc5911b9bd2 ("ionic: call ionic_port_init after
fw-upgrade") the function returned early when the buffer already
existed, so the two were symmetric.

Since then a failed PORT_INIT on either recovery path - fw_up or
reset_done - frees a buffer an earlier init owns, while the netdev is
registered and the ethtool ops are reading it.

Free only what this call allocated.

Fixes: ddc5911b9bd2 ("ionic: call ionic_port_init after fw-upgrade")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 10501be9ef95..38b47b959a11 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -722,6 +722,7 @@ int ionic_port_init(struct ionic *ionic)
 {
 	struct ionic_identity *ident = &ionic->ident;
 	struct ionic_dev *idev = &ionic->idev;
+	bool allocated = false;
 	size_t sz;
 	int err;
 
@@ -733,6 +734,8 @@ int ionic_port_init(struct ionic *ionic)
 						     GFP_KERNEL);
 		if (!idev->port_info)
 			return -ENOMEM;
+
+		allocated = true;
 	}
 
 	/* If the driver knows about more "extra stats" than the firmware,
@@ -757,10 +760,12 @@ int ionic_port_init(struct ionic *ionic)
 	mutex_unlock(&ionic->dev_cmd_lock);
 	if (err) {
 		dev_err(ionic->dev, "Failed to init port\n");
-		dma_free_coherent(ionic->dev, idev->port_info_sz,
-				  idev->port_info, idev->port_info_pa);
-		idev->port_info = NULL;
-		idev->port_info_pa = 0;
+		if (allocated) {
+			dma_free_coherent(ionic->dev, idev->port_info_sz,
+					  idev->port_info, idev->port_info_pa);
+			idev->port_info = NULL;
+			idev->port_info_pa = 0;
+		}
 	}
 
 	return err;

-- 
2.53.0

