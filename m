Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266353DD518;
	Fri,  7 Aug 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096242; cv=fail; b=O5AuAO3a9T1NKMYKTogAWctnQWB8C3lKx39Q/oSnh7ihGgymFclKAsX6awLb3++hDarJdcXzkE/B4bIb7BiBofqKq4lpSbhq5kFNqXhpTFfK+XnhxaoTiKtr56RF6ABNwO0tSAtrEZr7+vJ8twt90xHE/uAyY78XFN9ipQmr2Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096242; c=relaxed/simple;
	bh=wFEp2xXc+xM+2IuyRXXu9lU0h5KQCHKxOwSQ02tUPLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeZwCxI8uwHxxJsOZS2NF7JqhqVRatZCfM7iV/b0HfquGkLq5FRqzc54R7D3Kh0mGKKzmegdGC1hi9xEhRGDKXTwO880+A+qVpXVXmy9hYI71Xo4bN+afBMCEsD4N3LMbJXmsu1p+/DDnB1hQ1UMhOvmL3unBlyvXzCP0CpXaOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HPDOTRgi; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HPDOTRgi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUoGYu5Q/f7gCqsbcxItejrdQYaiNs6dOFArdF6lv8AalUYojw4+oz5idfFVsQzcCpS9FgYQ/WxIrFCSmrl3AEqUQaZCNliSwyAqNA20+3WNHglHiGiQebDyWYrNFAU1Kvu6RH2tL4Gcy3+YIfUMUUxaqd28ybGLw17qPYhK5OcFEPUNC5Wlxsx1564ebamcNbthP/QAeiY+KCpjNbQ6b3EfBHfmtLTEX336AnrNgZpmkBCM5aBy6lIYzuAmqm10kVpLPjmwOKKANxfO5tOhcV8K4MU0G1S2xYWOe7qBIVMHQ53sYBVr6eez2NI++YSYRMcySnwmg43baO2zxjTBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v1qj2GGX/dyA2R4qR/YpM5HkkNQo6xviR0hMv9POIs=;
 b=HwnpZE/QGtroi+GYAW2DB+LlYbFPE6OaiPXgMiMfqAmJO/wlcE/vjn8Ioy72pwuEYwIN7dUjagvWFU9ciyX3wkbsPk55nIIVSBdEhGJ27pvZR0UVbRLCq/Tnoa4vuvcA2QDOJdroX2JIhXgDCQgz0H1AK6SDG8qn0Ogy0KIdUWDHhRuqK7dIcRvJ5CeIc+I6e2gn4RwdbmTrv0ZuCJ7SIXDUSsIGLHn9KukG93KJwdRtaMxiFaJkkiKOPW3fFYsptqAQkfUv4cPkbpg4m23cvUn+wYf09MVhOMtj/OhCrr4M32cYqy4l74lqHOw1f6GEmhUJIBYMOayg706ZgAQA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v1qj2GGX/dyA2R4qR/YpM5HkkNQo6xviR0hMv9POIs=;
 b=HPDOTRgiskBqkl+sMAA0x1NZa8VANDD3jWUG0yNULImgZQ81ZvwRYdroZAA9piB55+deXziGxh5ulGuqhO9hPFcsag/Vd0RTqqQclfJ4Hp7Ge/IOxwmklrIipYA82Im+VtK+7EdvZVRPDTRME7lBhEJ1v3PDmJHE2DLDnCp3wGA=
Received: from MN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:52f::31)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.20; Fri, 7 Aug 2026 09:50:36 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::82) by MN0PR03CA0002.outlook.office365.com
 (2603:10b6:208:52f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 09:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 09:50:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:22 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 04:50:19 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/4] net: macb: Move TC capability and PM checks to macb_setup_tc()
Date: Fri, 7 Aug 2026 15:20:10 +0530
Message-ID: <20260807095012.640223-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa68c91-28ff-48cc-59c1-08def469546b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K0sYzsrQePEilu0Ca7FCltDWDIkH7mat3agYszLVmVUlHRPoYYBf45DD6fV65+iGnrra75RlPaeAyvFcilr7EDPJyxZ//maef6CQkXynXhRCnI45pQKKcaj+97yv9stUKIoF4nVVe6SEkFG8MEN9gQPBuS2osbZ/p28fnxk/xnSJcaLolg89nZeFTPa1jgqLLSi/fFgt5XyM4ku84Nv10fiAAmRjKAUUfaG/kC8vOyuUxPmlbI4cloHq8Fwr9wT4ysPBVUKvMy36/dUvRcoZsAoDIy9waDjtMMpvvY9gs8YLCNGzil3VMrtQEasMkFhY6l9r0WU+Opdcx3jpWGnvMk/xQACq9GgIeiEuuZ/14zAvxnqF0jj5B5elPryAc32/P19TxoFi7+0yXJs1GkFUudP1gRE+kdTs5vjh7lVpiM6mLQ3MdGD0WqNvMqeIaCtSb4w3bSWq6fznvGiASBBEK2y2lS7+GsE+PeRAlGY2tThejavBkYVwG+GYe1odabqsGM5QAFrl/KLqw+YVVcUzF0kUB9qV9szkfa92iPR1cQKHiZkjoeppbW1YqUa0rTq6DDZ5fouIB2BpU6JfVWOavyb7Fz8pOPVDKWE/Lh6OiLbObWnr2X9z1B++Wovu5pMx7PgzQZqD/5k/tmSdL7mZ7N3TlCcsJiI6RbX5AtlDa8Gw0TnFnXvGLJ4CayIqEGy1WMCnKrkWhjHw49jygWrqUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q/fRPdL1fzIq35/l0HXLl+iIRIE/g8Qs1o7Yb+qE/5Mw9EAfhiF7FxhTqhMaVwO73GsWguVQL9DwmsBNITeexopbMfwvafOuyKcEYI/N6Qpup8THqLLDXd6yzoLnAylMIxq5HUoFnVcy9OmwOk2RVIGD5RTM5xuKNLvBvWhZjBNJAPhtIUpcWiAJxDwFimYdDgGpknMWFZtPiRQTTXrc4C35MT2AWVaGG0DokLkB37DkqWBCiTMcRmqQATLVQLkwlX36aUZfWYbHjn+p2qMKTgfUTYyTxrcog6chE9Dx3QfzkmEWwnY+g1pldJzw1oON5o8K/ulHoEkKGDnrAt5e+BUhm9ekP/C63mlEzyD61nfJpswzoLRfYCu9EU3FQpRYZYn5qMRL2xpc/janMIRgrLsltxyFLsbs3OBHfBoQbJns00l1qJ5ilOEJbfKmMjCl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 09:50:35.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa68c91-28ff-48cc-59c1-08def469546b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

Move the NETIF_F_HW_TC capability check and the runtime PM suspend
guard from macb_setup_taprio() into the common macb_setup_tc()
entry point.

These preconditions apply to all hardware TC offload paths routed
through ndo_setup_tc(), not just TAPRIO. Centralizing them avoids
duplicating the same checks as new TC qdisc types are added.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 29c93df1444c..508d952e2ae7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4499,18 +4499,8 @@ static void macb_taprio_destroy(struct net_device *ndev)
 static int macb_setup_taprio(struct net_device *ndev,
 			     struct tc_taprio_qopt_offload *taprio)
 {
-	struct macb *bp = netdev_priv(ndev);
 	int err = 0;
 
-	if (unlikely(!(ndev->hw_features & NETIF_F_HW_TC)))
-		return -EOPNOTSUPP;
-
-	/* Check if Device is in runtime suspend */
-	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
-		netdev_err(ndev, "Device is in runtime suspend\n");
-		return -EOPNOTSUPP;
-	}
-
 	switch (taprio->cmd) {
 	case TAPRIO_CMD_REPLACE:
 		err = macb_taprio_setup_replace(ndev, taprio);
@@ -4528,9 +4518,22 @@ static int macb_setup_taprio(struct net_device *ndev,
 static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 			 void *type_data)
 {
+	struct macb *bp;
+
 	if (!dev || !type_data)
 		return -EINVAL;
 
+	bp = netdev_priv(dev);
+
+	if (unlikely(!(dev->hw_features & NETIF_F_HW_TC)))
+		return -EOPNOTSUPP;
+
+	/* Check if Device is in runtime suspend */
+	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
+		netdev_err(dev, "Device is in runtime suspend\n");
+		return -EOPNOTSUPP;
+	}
+
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
 		return macb_setup_taprio(dev, type_data);
-- 
2.44.4

